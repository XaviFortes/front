# Define la región y la cuenta de AWS
provider "aws" {
  region = "eu-south-2"
}


##############################################
##                  DYNAMODB                ##
##############################################


# Crea la tabla DynamoDB
resource "aws_dynamodb_table" "hackathon_users" {
  name           = "hackathon_users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  attribute {
    name = "user_id"
    type = "S"
  }
}

##############################################
##                  LAMBDA                  ##
##############################################

# Crea la función de Lambda
resource "aws_lambda_function" "create_user" {
  filename         = "create_user.zip"
  function_name    = "create_user"
  role             = aws_iam_role.lambda_role_hackathon.arn
  # architectures = [ "arm64" ]
  handler          = "create_user.lambda_handler"
  runtime          = "python3.10"
  memory_size      = 128
  timeout          = 10
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hackathon_users.name
    }
  }
}

# Crea la función de Lambda
resource "aws_lambda_function" "modify_user" {
  filename         = "modify_user.zip"
  function_name    = "modify_user"
  role             = aws_iam_role.lambda_role_hackathon.arn
  # architectures = [ "arm64" ]
  handler          = "modify_user.lambda_handler"
  runtime          = "python3.10"
  memory_size      = 128
  timeout          = 10
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hackathon_users.name
    }
  }
}

# Crea la función de Lambda
resource "aws_lambda_function" "get_user" {
  filename         = "get_user.zip"
  function_name    = "get_user"
  role             = aws_iam_role.lambda_role_hackathon.arn
  # architectures = [ "arm64" ]
  handler          = "get_user.lambda_handler"
  runtime          = "python3.10"
  memory_size      = 128
  timeout          = 10
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hackathon_users.name
    }
  }
}

# Crea la función de Lambda
resource "aws_lambda_function" "create_cover_letter" {
  filename         = "create_cl.zip"
  function_name    = "create_cover_letter"
  role             = aws_iam_role.lambda_role_hackathon.arn
  # architectures = [ "arm64" ]
  handler          = "create_cl.lambda_handler"
  runtime          = "python3.10"
  memory_size      = 128
  timeout          = 10
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hackathon_users.name
    }
  }
}


##############################################
##                  IAM                     ##
##############################################


# Crea el rol de IAM para la función de Lambda
resource "aws_iam_role" "lambda_role_hackathon" {
  name = "lambda_role_hackathon"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["lambda.amazonaws.com"]
        }
      }
    ]
  })
}

# Crea una política de IAM para la función de Lambda
resource "aws_iam_policy" "lambda_policy_hackathon" {
  name = "lambda_policy_hackathon"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Effect = "Allow"
        // Also allow Api Gateway to call the Lambda function
        Resource = [
          aws_dynamodb_table.hackathon_users.arn,
          aws_lambda_function.create_user.arn,
          aws_lambda_function.modify_user.arn,
          aws_lambda_function.get_user.arn
        ]
      }
    ]
  })
}

# Asocia la política de IAM con el rol de IAM para la función de Lambda
resource "aws_iam_role_policy_attachment" "lambda_attachment_hackathon" {
  policy_arn = aws_iam_policy.lambda_policy_hackathon.arn
  role       = aws_iam_role.lambda_role_hackathon.name
}

##############################################
##               API GATEWAY                ##
##############################################

# Crea la API Gateway
resource "aws_api_gateway_rest_api" "users_api_hackathon" {
  name = "users_api_hackathon"
}

############ Crear usuario ############

# Crea un recurso y un método para la API Gateway
resource "aws_api_gateway_resource" "create_user_resource" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  parent_id   = aws_api_gateway_rest_api.users_api_hackathon.root_resource_id
  path_part   = "create_user"
}

resource "aws_api_gateway_method" "create_user_method" {
  rest_api_id   = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id   = aws_api_gateway_resource.create_user_resource.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    # "method.request.body" = true
  }
  depends_on = [
    aws_api_gateway_resource.create_user_resource
  ]
}

# Conecta el método de la API Gateway con la función de Lambda
resource "aws_api_gateway_integration" "create_user_integration" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.create_user_resource.id
  http_method = aws_api_gateway_method.create_user_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.create_user.invoke_arn
  content_handling = "CONVERT_TO_TEXT"
  depends_on = [
    aws_api_gateway_method.create_user_method
  ]
}

############ Modificar usuario ############

# Crea un recurso y un método para la API Gateway
resource "aws_api_gateway_resource" "modify_user_resource" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  parent_id   = aws_api_gateway_rest_api.users_api_hackathon.root_resource_id
  path_part   = "modify_user"
}

resource "aws_api_gateway_method" "modify_user_method" {
  rest_api_id   = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.modify_user_resource.id
  http_method = "PUT"
  authorization = "NONE"
  request_parameters = {
    # "method.request.body" = true
  }
  depends_on = [
    aws_api_gateway_resource.modify_user_resource
  ]
}

# Conecta el método de la API Gateway con la función de Lambda
resource "aws_api_gateway_integration" "modify_user_integration" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.modify_user_resource.id
  http_method = aws_api_gateway_method.modify_user_method.http_method
  integration_http_method = "PUT"
  type = "AWS_PROXY"
  uri = aws_lambda_function.create_user.invoke_arn
  content_handling = "CONVERT_TO_TEXT"
  depends_on = [
    aws_api_gateway_method.modify_user_method
  ]
}

############ Consultar usuario ############

# Crea un recurso y un método para la API Gateway
resource "aws_api_gateway_resource" "get_user_resource" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  parent_id   = aws_api_gateway_rest_api.users_api_hackathon.root_resource_id
  path_part   = "get_user"
}

resource "aws_api_gateway_method" "get_user_method" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.get_user_resource.id
  http_method = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.querystring.dni" = true
  }
  depends_on = [
    aws_api_gateway_resource.get_user_resource
  ]
}

# Conecta el método de la API Gateway con la función de Lambda
resource "aws_api_gateway_integration" "get_user_integration" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.get_user_resource.id
  http_method = aws_api_gateway_method.get_user_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.get_user.invoke_arn
  content_handling = "CONVERT_TO_TEXT"
}

############# Crear Carta de Presentacion #############

# Crea un recurso y un método para la API Gateway
resource "aws_api_gateway_resource" "create_cover_letter_resource" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  parent_id   = aws_api_gateway_rest_api.users_api_hackathon.root_resource_id
  path_part   = "create_cover_letter"
}

resource "aws_api_gateway_method" "create_cover_letter_method" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.create_cover_letter_resource.id
  http_method = "POST"
  authorization = "NONE"
  depends_on = [
    aws_api_gateway_resource.create_cover_letter_resource
  ]
}

# Conecta el método de la API Gateway con la función de Lambda
resource "aws_api_gateway_integration" "create_cover_letter_integration" {
  rest_api_id = aws_api_gateway_rest_api.users_api_hackathon.id
  resource_id = aws_api_gateway_resource.create_cover_letter_resource.id
  http_method = aws_api_gateway_method.create_cover_letter_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.create_cover_letter.invoke_arn
  content_handling = "CONVERT_TO_TEXT"
  depends_on = [
    aws_api_gateway_method.create_cover_letter_method
  ]
}