# Xulu CLI — Terms of Use

**Last updated:** 2026-08-29

These Terms of Use ("Terms") apply to the Xulu command-line software made available as pre-built binaries (the "Software") from [xuluhq/xulu](https://github.com/xuluhq/xulu) and related official download channels. By downloading, installing, or using the Software, you agree to these Terms.

The Software is **proprietary**. Source code is not published under an open-source license. The public GitHub repository provides releases, documentation links, and related materials only.

## 1. License grant

Subject to these Terms, Xulu grants you a limited, non-exclusive, non-transferable, revocable license to install and use the Software on systems you control or are authorized to use, for your internal business or personal purposes.

Inspect and diff capabilities are currently offered at no charge. Future features or editions may be subject to separate terms or fees, which will be described before they apply.

## 2. Nature of the Software

The Software is a **local analysis and reporting tool**. For commands such as inspect, diff, and (when available) validate:

- it **reads** your input files and **does not modify, overwrite, delete, or rewrite** those input files as part of normal operation;
- it produces **reports and other output** (for example on stdout or via `-o` / `--output`) that are derived from those inputs;
- reports, exit codes, and similar results are **informational only** — you remain solely responsible for how you interpret them and for any decisions, scripts, CI gates, or production actions you take based on them.

You are responsible for backing up your data and for verifying results before relying on them. Xulu does not warrant that reports are complete, accurate, or free of defects.

## 3. Restrictions

You may not, and may not permit others to:

- copy, modify, adapt, or create derivative works of the Software, except as necessary for normal installation and use;
- reverse engineer, decompile, or disassemble the Software, except where applicable law expressly permits despite this limitation;
- remove or alter proprietary notices;
- sublicense, sell, rent, lease, or redistribute the Software, except that you may share **unmodified** official release binaries only by pointing others to official download locations (e.g. GitHub Releases); or
- use the Software in violation of applicable law or third-party rights.

## 4. Ownership

The Software and all related intellectual property rights remain the property of Xulu and its licensors. No rights are granted except as expressly stated in these Terms.

## 5. Updates

The Software may offer updates (for example via `xulu update`). Updates are subject to these Terms unless accompanied by different terms. Xulu may modify or discontinue the Software or any feature at any time.

## 6. Local processing

The CLI runs on your machine. Input files you point it at are processed locally by default; Xulu does not require you to upload those files to Xulu in order to use inspect or diff. Any future hosted or account-based features will be described separately (including privacy information where required).

## 7. Disclaimer of warranties

THE SOFTWARE IS PROVIDED **"AS IS"** AND **"AS AVAILABLE"**, WITHOUT WARRANTIES OR GUARANTEES OF ANY KIND, WHETHER EXPRESS, IMPLIED, OR STATUTORY — INCLUDING WITHOUT LIMITATION ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, NON-INFRINGEMENT, ACCURACY, COMPLETENESS, OR UNINTERRUPTED OR ERROR-FREE OPERATION.

## 8. Exclusion of liability

**To the maximum extent permitted by applicable law**, Xulu and its affiliates, officers, employees, and agents exclude all liability arising out of or relating to the Software or these Terms — whether in contract, tort (including negligence), statute, or otherwise — including without limitation liability for:

- loss, corruption, or unavailability of data;
- incorrect, incomplete, or misleading reports or exit codes;
- decisions or actions taken (or not taken) based on the Software’s output;
- business interruption, lost profits, revenue, savings, or goodwill;
- any direct, indirect, incidental, special, consequential, or punitive damages;

even if Xulu was advised of the possibility of such damages, and even if a remedy fails of its essential purpose.

**Where you paid nothing for the Software, Xulu’s aggregate liability is CHF 0 (zero).** Where mandatory law does not allow a complete exclusion, liability is limited to the smallest amount that law still requires.

**Nothing in these Terms excludes or limits liability for intent (Vorsatz) or gross negligence (grobe Fahrlässigkeit), or for death or personal injury caused by negligence, or any other liability that cannot be excluded under Swiss law.**

## 9. Your responsibility

You use the Software at your own risk. You are solely responsible for:

- choosing whether and how to use the Software on your systems and data;
- reviewing outputs before acting on them;
- compliance with laws applicable to your data and use cases.

## 10. Changes to these Terms

Xulu may update these Terms from time to time. The "Last updated" date above will change when they do. Continued use of the Software after changes become effective constitutes acceptance of the revised Terms. Material changes will be reflected on the docs site and in the public repository.

## 11. Termination

These Terms apply until terminated. Xulu may terminate your license if you breach these Terms. Upon termination, you must stop using the Software and delete copies in your possession.

## 12. Governing law and venue

These Terms are governed by the substantive laws of **Switzerland**, excluding conflict-of-law rules and the United Nations Convention on Contracts for the International Sale of Goods (CISG).

Subject to mandatory consumer-protection venue rules that may apply to you, the exclusive place of jurisdiction is **Zurich, Switzerland**.

## 13. General

These Terms constitute the entire agreement between you and Xulu regarding the Software. If any provision is unenforceable, the remaining provisions remain in effect. Failure to enforce a provision is not a waiver.

Questions: contact information may be published on [xulu.dev](https://xulu.dev) or the public GitHub repository when available.
