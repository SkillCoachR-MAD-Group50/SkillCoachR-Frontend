import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/milestone.dart';
import '../models/quiz_question.dart';

class AIService {
  const apiKey = String.fromEnvironment('GROQ_API_KEY');
  static const String _model = 'llama-3.3-70b-versatile';

  static Future<String> _call(String prompt) async {
    final res = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
        'max_tokens': 4000,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('Groq API error ${res.statusCode}: ${res.body}');
    }
    return (jsonDecode(res.body)['choices'][0]['message']['content']) as String;
  }

  static Future<List<Milestone>> generateRoadmap(
    String goal,
    String skill,
  ) async {
    final prompt =
        '''
Generate a skill gap learning roadmap for career goal: "$goal", skill: "$skill".
Create exactly 5 milestones from beginner to advanced, aligned to industry standards.

Respond ONLY with valid JSON:
{
  "milestones": [
    {
      "title": "Milestone title",
      "description": "What the learner achieves",
      "topics": ["topic1", "topic2", "topic3"],
      "materials": [
        {"title": "Video Name", "type": "Video", "is_free": true, "url": "https://www.youtube.com/watch?v=ID"},
        {"title": "Official Docs", "type": "Documentation", "is_free": true, "url": "https://DOCS_URL"},
        {"title": "Course Name", "type": "Web Course", "is_free": false, "url": "https://example.com"}
      ]
    }
  ]
}
Rules: 5 milestones, each 3+ materials, include official docs, real YouTube URLs.
''';
    final text = await _call(prompt);
    final data = jsonDecode(_extractJson(text));
    final list = data['milestones'] as List;
    return list
        .asMap()
        .entries
        .map(
          (e) => Milestone.fromJson(
            (e.value as Map).cast<String, dynamic>(),
            e.key,
          ),
        )
        .toList();
  }

  static Future<List<QuizQuestion>> generateQuiz(
    String skill,
    Milestone milestone,
  ) async {
    final prompt =
        '''
Generate a skill assessment quiz for "$skill", milestone: "${milestone.title}".
Topics: ${milestone.topics.join(', ')}.
Create exactly 10 multiple choice questions.

Respond ONLY with valid JSON:
{"questions": [{"question": "Q?", "options": ["A","B","C","D"], "correct_index": 0, "explanation": "Why"}]}
''';
    final text = await _call(prompt);
    final data = jsonDecode(_extractJson(text));
    return (data['questions'] as List)
        .map((q) => QuizQuestion.fromJson((q as Map).cast<String, dynamic>()))
        .toList();
  }

  static String _extractJson(String text) {
    final s = text.indexOf('{');
    final e = text.lastIndexOf('}');
    if (s == -1 || e == -1) throw Exception('No JSON found');
    return text.substring(s, e + 1);
  }
}
