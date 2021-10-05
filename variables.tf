variable rest_api_execution_arn {
  type    = string
  default = null
}

variable rest_api_root_resource_id {
  type    = string
  default = null
}

variable rest_api_id {
  type    = string
  default = null
}

variable rest_api_path {
  type    = string
  default = null
}

variable post_enabled {
  type    = bool
  default = false
}

variable get_enabled {
  type    = bool
  default = false
}

variable put_enabled {
  type    = bool
  default = false
}

variable patch_enabled {
  type    = bool
  default = false
}

variable delete_enabled {
  type    = bool
  default = false
}

variable options_enabled {
  type    = bool
  default = false
}

variable cors_enabled {
  type    = bool
  default = false
}

variable lambda_function_name {
  type    = string
  default = null
}

variable lambda_function_invoke_arn {
  type    = string
  default = null
}

variable lambda_permissions {
  type    = bool
  default = true
}

variable integration_type {
  type = string
  default = "AWS_PROXY"
}

variable api_key_required {
  type = bool
  default = true
}

variable authorization {
  type = string
  default = "NONE"
}

variable authorizer_id {
  type = string
  default = null
}
