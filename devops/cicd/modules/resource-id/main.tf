locals {
  resource-id = substr(
    lower(
      replace(
        replace(
          join(
            "-", [terraform.workspace, var.branch-name, var.resource-name]
          ), "/[^a-zA-Z0-9-]/", "-"
        ),"/-{2,}/","-"
      )
    ), 0, 62
  )
}
