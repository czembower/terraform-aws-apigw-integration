# terraform-aws-apigw-integration

Terraform module to create AWS API Gateway / Lambda integrations with a single declaration.

## Example Usage

```
module "apigw_integration" {
  source  = "../modules/apigw-integration/aws"

  rest_api_path              = "this"
  rest_api_id                = aws_api_gateway_rest_api.this.id
  rest_api_execution_arn     = aws_api_gateway_rest_api.this.execution_arn
  rest_api_root_resource_id  = aws_api_gateway_resource.this.id
  lambda_function_name       = aws_lambda_function.this.function_name
  lambda_function_invoke_arn = aws_lambda_function.this.invoke_arn
  lambda_permissions         = true
  authorization              = "CUSTOM"
  authorizer_id              = aws_api_gateway_authorizer.this.id
  api_key_required           = false

  cors_enabled    = true
  post_enabled    = true
  get_enabled     = true
  put_enabled     = true
  delete_enabled  = true
  options_enabled = true
}
```
