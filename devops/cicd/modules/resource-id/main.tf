locals {
  resource-id = substr(
    lower(
      replace(
        replace(
          join(
            "-", [
              terraform.workspace,
              substr(var.branch-name, 0, 16),
              substr(var.resource-name, 0, 32)
            ]
          ), "/[^a-zA-Z0-9-]/", "-"
        ),"/-{2,}/","-"
      )
    ), 0, 62
  )
}
