locals {
  resource_id = substr(
    replace(
      join("_", [terraform.workspace, var.branch_name, var.resource_name]), "__", "_"
    ), 0, 62
  )
}

