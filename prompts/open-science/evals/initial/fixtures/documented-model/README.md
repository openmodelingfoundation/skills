# Synthetic count-sum model

Fictional model version 1.0, a deterministic arithmetic example without an
empirical interpretation. All inputs are invented and non-sensitive. Source,
inputs and documentation are covered by the repository's MIT license.

## Smallest documented example

Runtime: Python 3.12, standard library only. No installation or network access
is needed. From this directory, the documented command is:

```sh
python3 model.py inputs.json
```

`inputs.json` supplies a single `counts` array containing integers in units of
individual items. It contains `[1, 2]`. Initial conditions are exactly that
array; there are no random choices, seed or replications. The program stops
after summing it once and prints the JSON object `{"total": 3}` to stdout.
No output file is expected. Acceptance for the example is exit status zero and
that JSON object; this does not reproduce a publication result.

This documentation describes the intended example, not a record of execution.
