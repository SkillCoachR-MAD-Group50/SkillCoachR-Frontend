# Changelog

## [1.3.0](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/compare/v1.2.0...v1.3.0) (2026-03-25)


### Features

* **auth:** complete sign-up flow and final navigation refinements ([a16b599](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/a16b599ce66c95ad4a06971f31529fc0ae7650da))
* **auth:** implement explicit redirection, error mapping, and firestore sync ([d8543dc](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/d8543dc854044d67232c679f967d28a0e88f5ea4))
* **navigation:** complete landing page flow and fix redirection circularity ([d58638a](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/d58638a08bcc26d94944e0286177ca0c2aaf4bdb))
* **router:** add refreshListenable and protect home route ([e71a31e](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/e71a31eb7485febe77125c70a066aaeaf4117529))


### Bug Fixes

* **auth:** add missing firebase_auth import in LoginScreen ([3807e65](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3807e6543b0b8b23e57f8141210a1d5a56b1a16e))
* **router:** correct refreshListenable stream reference ([7320c40](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/7320c408ebead2a42eb2d4379013aa2d7a8d2298))

## [1.2.0](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/compare/v1.1.0...v1.2.0) (2026-03-25)


### Features

* **auth:** finalize firebase initialization with android options ([c9457aa](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/c9457aa86de65bc65357b9a81539ce2631fc6727))
* **auth:** implement smart routing, sign-out, and navigation stability fixes ([92ddb0d](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/92ddb0ddeb20645c262d59bb0327a22fc42526c5))


### Bug Fixes

* **auth:** resolve google_sign_in build errors by downgrading to v6.2.1 and using prefixed imports ([ad85d6a](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/ad85d6af7497889e236ea9e8634da333cd7e5c71))

## [1.1.0](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/compare/v1.0.0...v1.1.0) (2026-03-25)


### Features

* Add 6 skills based on career goal in Assessment Module ([79069c3](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/79069c34b7c7682dc17ed17c48d5cbf1a7f9e109))
* **assessment:** implement skill gap analysis screen and radar chart ([1db4382](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1db4382815874df8e592c35545b8b1a2d9875381))
* **assessment:** render real data in gap analysis screen using Riverpod ([9abdfa4](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/9abdfa43ed109b2563b1d679f13e284bc607ca30))
* **auth:** implement premium login ui and redirect get started button ([3105208](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3105208a1b7236a5a63f9d90d9b7598a80921f08))
* **auth:** integrate firebase authentication and connect login ui ([36ed6c9](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/36ed6c92532b48f6759e54960602f835af0a728e))
* Calculate skill-assessment dynamic progress based on user ratings ([0ac397c](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/0ac397c2b0e6a5ec7c6a185f8de76a947675e058))
* Implement Dynamic Skill Gap Analysis Screen ([cc4ad71](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/cc4ad71d9755cc6fc8759f248487d091a9717444))
* implement Profile Setup Step 2 screen and navigation ([94de5f1](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/94de5f16d70b95d65f606af39a9139dd51946dcd))
* implement Profile Setup Step 3 screen and navigation ([97b769e](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/97b769e00b6fc867a8eceb77c01ae62f0ac70c8a))
* implement Profile Setup Step 4 screen and navigation ([1ef4022](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1ef4022b6df3c8bf6958035822bd4d5bbf4a139f))
* implement Profile Setup Step 5 screen with dynamic time slider ([1001eb4](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1001eb43bf043362bdbf7ba3babc636c503e7287))
* **profile:** add input validation to disable next buttons until fields are filled ([9df600b](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/9df600b3bffa7f4188eba7c2292c40563d259af1))
* **profile:** add input validation to setup profile pages ([ebaf502](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/ebaf50279e7cde4e407ab6257184cb8a21de459a))


### Bug Fixes

* **ai:** sanitize api key and improve error handling ([70cb242](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/70cb242a93b0521dfccdea85f122804abac69c89))
* Prevent ProfileSetupProvider from auto-disposing ([3e3b752](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3e3b7521520ab4e210721b356e1d7e38696c949c))
* **profile:** disable next button when name is empty in step 1 ([ce7578b](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/ce7578b124ea160bc4ac6903ef6874c7ea421c3b))
* **profile:** fix missing parenthesis syntax error ([e3fb058](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/e3fb05854ff1848b7ee9d4fa4e6f6517a04183f4))
* **profile:** handle physical keyboard input correctly by trimming spaces ([6cf48fe](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/6cf48fe667dd9ba2fc6d4a77d0a2ca337809dabb))
* **profile:** improve text field robustness and add physical keyboard submit action ([08da588](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/08da5885d77883ff5d280e6fcfcd55375855cdaa))
* **profile:** input name field issue ([1f2def5](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1f2def50931ebce0475b10ada1af8b01cf7617d1))
* **profile:** prevent name input from losing focus in step 1 ([75454d6](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/75454d6663f887bf8630bc81c575f06ddf4d8f25))
* **profile:** setup profile step 1 handle physical keyboard input correctly ([3866c3d](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3866c3df35460903f4f1ef128151a4f6896e07b6))
* redirect to assessment page after complete setup ([dcf98d0](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/dcf98d071241d6cf4c4cf1afe58c6b69b0a51c20))
* remove default 'era' value from profile setup name input ([b1de697](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/b1de6975260574b70f0c0594f55ab0f30eed630a))

## 1.0.0 (2026-03-25)


### Features

* Add 6 skills based on career goal in Assessment Module ([79069c3](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/79069c34b7c7682dc17ed17c48d5cbf1a7f9e109))
* **assessment:** implement skill gap analysis screen and radar chart ([1db4382](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1db4382815874df8e592c35545b8b1a2d9875381))
* **assessment:** render real data in gap analysis screen using Riverpod ([9abdfa4](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/9abdfa43ed109b2563b1d679f13e284bc607ca30))
* **auth:** implement premium login ui and redirect get started button ([3105208](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3105208a1b7236a5a63f9d90d9b7598a80921f08))
* **auth:** integrate firebase authentication and connect login ui ([36ed6c9](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/36ed6c92532b48f6759e54960602f835af0a728e))
* Calculate skill-assessment dynamic progress based on user ratings ([0ac397c](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/0ac397c2b0e6a5ec7c6a185f8de76a947675e058))
* Implement Dynamic Skill Gap Analysis Screen ([cc4ad71](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/cc4ad71d9755cc6fc8759f248487d091a9717444))
* implement Profile Setup Step 2 screen and navigation ([94de5f1](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/94de5f16d70b95d65f606af39a9139dd51946dcd))
* implement Profile Setup Step 3 screen and navigation ([97b769e](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/97b769e00b6fc867a8eceb77c01ae62f0ac70c8a))
* implement Profile Setup Step 4 screen and navigation ([1ef4022](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1ef4022b6df3c8bf6958035822bd4d5bbf4a139f))
* implement Profile Setup Step 5 screen with dynamic time slider ([1001eb4](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1001eb43bf043362bdbf7ba3babc636c503e7287))
* **profile:** add input validation to disable next buttons until fields are filled ([9df600b](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/9df600b3bffa7f4188eba7c2292c40563d259af1))
* **profile:** add input validation to setup profile pages ([ebaf502](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/ebaf50279e7cde4e407ab6257184cb8a21de459a))


### Bug Fixes

* **ai:** sanitize api key and improve error handling ([70cb242](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/70cb242a93b0521dfccdea85f122804abac69c89))
* Prevent ProfileSetupProvider from auto-disposing ([3e3b752](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3e3b7521520ab4e210721b356e1d7e38696c949c))
* **profile:** disable next button when name is empty in step 1 ([ce7578b](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/ce7578b124ea160bc4ac6903ef6874c7ea421c3b))
* **profile:** fix missing parenthesis syntax error ([e3fb058](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/e3fb05854ff1848b7ee9d4fa4e6f6517a04183f4))
* **profile:** handle physical keyboard input correctly by trimming spaces ([6cf48fe](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/6cf48fe667dd9ba2fc6d4a77d0a2ca337809dabb))
* **profile:** improve text field robustness and add physical keyboard submit action ([08da588](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/08da5885d77883ff5d280e6fcfcd55375855cdaa))
* **profile:** input name field issue ([1f2def5](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/1f2def50931ebce0475b10ada1af8b01cf7617d1))
* **profile:** prevent name input from losing focus in step 1 ([75454d6](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/75454d6663f887bf8630bc81c575f06ddf4d8f25))
* **profile:** setup profile step 1 handle physical keyboard input correctly ([3866c3d](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/3866c3df35460903f4f1ef128151a4f6896e07b6))
* redirect to assessment page after complete setup ([dcf98d0](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/dcf98d071241d6cf4c4cf1afe58c6b69b0a51c20))
* remove default 'era' value from profile setup name input ([b1de697](https://github.com/SkillCoachR-MAD-Group50/SkillCoachR-Frontend/commit/b1de6975260574b70f0c0594f55ab0f30eed630a))
