"""Fictional count-sum model with no empirical interpretation."""
import json
from pathlib import Path
import sys

inputs = json.loads(Path(sys.argv[1]).read_text())
print(json.dumps({"total": sum(inputs["counts"])}))
