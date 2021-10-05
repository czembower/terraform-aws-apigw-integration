resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.rest_api_root_resource_id
  path_part   = var.rest_api_path
}

resource "aws_api_gateway_method" "post" {
  count            = var.post_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "POST"
  authorization    = var.authorization
  api_key_required = var.api_key_required
  authorizer_id    = var.authorization == "NONE" ? null : var.authorizer_id
}

resource "aws_api_gateway_integration" "post" {
  count       = var.post_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.post[0].resource_id
  http_method = aws_api_gateway_method.post[0].http_method

  integration_http_method = "POST"
  type                    = var.integration_type
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_api_gateway_method" "get" {
  count            = var.get_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "GET"
  authorization    = var.authorization
  api_key_required = var.api_key_required
  authorizer_id    = var.authorization == "NONE" ? null : var.authorizer_id
}

resource "aws_api_gateway_integration" "get" {
  count       = var.get_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.get[0].resource_id
  http_method = aws_api_gateway_method.get[0].http_method

  integration_http_method = "POST"
  type                    = var.integration_type
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_api_gateway_method" "put" {
  count            = var.put_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "PUT"
  authorization    = var.authorization
  api_key_required = var.api_key_required
  authorizer_id    = var.authorization == "NONE" ? null : var.authorizer_id
}

resource "aws_api_gateway_integration" "put" {
  count       = var.put_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.put[0].resource_id
  http_method = aws_api_gateway_method.put[0].http_method

  integration_http_method = "POST"
  type                    = var.integration_type
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_api_gateway_method" "patch" {
  count            = var.patch_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "PATCH"
  authorization    = var.authorization
  api_key_required = var.api_key_required
  authorizer_id    = var.authorization == "NONE" ? null : var.authorizer_id
}

resource "aws_api_gateway_integration" "patch" {
  count       = var.patch_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.patch[0].resource_id
  http_method = aws_api_gateway_method.patch[0].http_method

  integration_http_method = "POST"
  type                    = var.integration_type
  uri                     = var.lambda_function_invoke_arn
}


resource "aws_api_gateway_method" "delete" {
  count            = var.delete_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "DELETE"
  authorization    = var.authorization
  api_key_required = var.api_key_required
  authorizer_id    = var.authorization == "NONE" ? null : var.authorizer_id
}

resource "aws_api_gateway_integration" "delete" {
  count       = var.delete_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.delete[0].resource_id
  http_method = aws_api_gateway_method.delete[0].http_method

  integration_http_method = "POST"
  type                    = var.integration_type
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_api_gateway_method" "options" {
  count            = var.options_enabled == true ? 1 : 0
  rest_api_id      = var.rest_api_id
  resource_id      = aws_api_gateway_resource.this.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_method_response" "options_200" {
  count       = var.options_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.options[0].http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration" "options" {
  count       = var.options_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.options[0].http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  count       = var.options_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.options[0].http_method
  status_code = aws_api_gateway_method_response.options_200[0].status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,DELETE,PUT,PATCH'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_method_response.options_200]
}

resource "aws_api_gateway_method_response" "cors_get" {
  count       = var.cors_enabled == true && var.get_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.get[0].http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "cors_post" {
  count       = var.cors_enabled == true && var.post_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.post[0].http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "cors_put" {
  count       = var.cors_enabled == true && var.put_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.put[0].http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "cors_patch" {
  count       = var.cors_enabled == true && var.patch_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.patch[0].http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "cors_delete" {
  count       = var.cors_enabled == true && var.delete_enabled == true ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.delete[0].http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_lambda_permission" "this" {
  count         = var.lambda_permissions == false ? 0 : 1
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.rest_api_execution_arn}/*"
}
