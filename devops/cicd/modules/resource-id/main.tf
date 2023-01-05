locals {
  resource_id = substr(
    lower(
      replace(
        replace(
          join(
            "-", [
              terraform.workspace,
              substr(var.branch_name, 0, 16),
              substr(var.resource_name, 0, 32)
            ]
          ), "/[^a-zA-Z0-9-]/", "-"
        ),"/-{2,}/","-"
      )
    ), 0, 62
  )
}
