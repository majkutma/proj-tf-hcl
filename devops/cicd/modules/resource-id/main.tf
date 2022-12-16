locals {
  resource-id = substr(
    replace(
      join("-", [terraform.workspace, var.branch-name, var.resource-name]), "--", "-"
    ), 0, 62
  )
}

