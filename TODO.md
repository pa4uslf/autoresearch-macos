# TODO

- [ ] 优化 `prepare.py:357` / `train.py:788` 的最终评估路径，解决 macOS MPS 下 `evaluate_bpb` 明显过慢的问题。
- [ ] 跑通一轮完整基线，产出真实 `val_bpb`、`eval_seconds` 与 `peak_vram_mb`，并更新 `results.tsv`。
- [ ] 评估是否需要继续降低 MPS 默认训练/评估批量，或为评估阶段单独增加更激进的回退与可观测日志。
