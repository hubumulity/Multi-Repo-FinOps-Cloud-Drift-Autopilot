# 方式 A：直接从本地或远程 state 导出结构化 JSON
terraform show -json > tfstate.json

# 方式 B：用 jq 快速列出所有托管资源的 address、type 与实例属性（如 bucket / id / arn）
jq -r '
  .values.root_module as $root |
  [
    ($root.resources // []),
    ([($root.child_modules // [])[] | .resources // []] | add // [])
  ] | add[] |
  "\(.address)\t\(.type)\t\(.values.bucket // .values.id // .values.arn // "")"
' tfstate.json
