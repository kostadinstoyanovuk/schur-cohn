# Verification records

The files in this directory record preparation and verification of the pinned
Lean environment on 2026-09-24. See [COMMANDS.md](COMMANDS.md) for the steps and
[lake-build.log](lake-build.log) for the successful build. The build completed
1,184 jobs, including cached dependencies; this count does not represent 1,184
new theorems. The setup examples do not satisfy programme proof gates G6 or G7.

The original cache failure is retained in `cache-first-attempt.log`; the
successful second attempt is recorded in `cache-get.log`. The initial failure
arose because the portable Lean executable was absent from the process PATH.

The machine-specific path in `mathlib-clone.log` is normalised for publication:
`<workspace>` denotes this repository's directory. Build output, versions,
failure evidence and verified toolchain digest are unchanged.

`setuptools-84.0.0.json` is a labelled extract of the retrieved PyPI metadata,
not the original response bytes. It preserves the package version, Python
requirement, official source and metadata URLs, artifact names and sizes,
release timestamps, and SHA-256 digests. Its `original_response_sha256` matches
the retrieval record in `source-provenance.json`; that digest describes the
original response, not this extract. Other source snapshots retain their
upstream content and retrieval details.
