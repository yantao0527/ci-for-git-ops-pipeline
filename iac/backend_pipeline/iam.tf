# IAM role and policy for CodePipeline
resource aws_iam_role codepipeline_backend {
  name                 = "${var.application_name}-codepipeline-${var.environment}"
  assume_role_policy   = data.aws_iam_policy_document.codepipeline.json
}

data "aws_iam_policy_document" "codepipeline" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  } 
}

resource aws_iam_policy codepipeline_backend {
  name        = "${var.application_name}-codepipeline-${var.environment}"
  description = "Allow Codepipeline deployments"
  policy      = data.aws_iam_policy_document.codepipeline_backend.json
}

resource aws_iam_role_policy_attachment codepipeline_backend {
  role       = aws_iam_role.codepipeline_backend.name
  policy_arn = aws_iam_policy.codepipeline_backend.arn
}

data aws_iam_policy_document codepipeline_backend {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:StartBuild",
      "codebuild:StopBuild",
      "codebuild:BatchGetBuilds"
    ]

    resources = ["arn:aws:codebuild:us-east-2:*"]
  }
}

# IAM role and policy for CodeBuild
resource aws_iam_role codebuild_backend {
  name                 = "${var.application_name}-codebuild-${var.environment}"
  assume_role_policy   = data.aws_iam_policy_document.codebuild.json
}

data "aws_iam_policy_document" "codebuild" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  } 
}

resource aws_iam_policy codebuild_backend {
  name        = "${var.application_name}-codebuild-${var.environment}"
  description = "Allow codebuild deployments"
  policy      = data.aws_iam_policy_document.codebuild_backend.json
}

resource aws_iam_role_policy_attachment codebuild_backend {
  role       = aws_iam_role.codebuild_backend.name
  policy_arn = aws_iam_policy.codebuild_backend.arn
}

data aws_iam_policy_document codebuild_backend {
  statement {
    effect = "Allow"
    sid = "AllowAllPermissions"
    actions = [
      "*"
    ]
    resources = [
      "*"
    ]
  }
}

# data aws_iam_policy_document codebuild_backend {
#   statement {
#     effect = "Allow"

#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "ec2:CreateNetworkInterface",
#       "ec2:DescribeDhcpOptions",
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DeleteNetworkInterface",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeVpcs",
#       "ec2:CreateNetworkInterfacePermission"
#     ]

#     resources = ["arn:aws:logs:us-east-2:*","arn:aws:ec2:us-east-2:*"]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:*"
#     ]

#     resources = [
#       "arn:aws:s3:::*"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "codebuild:UpdateReportGroup",
#       "codebuild:ListReportsForReportGroup",
#       "codebuild:CreateReportGroup",
#       "codebuild:CreateReport",
#       "codebuild:UpdateReport",
#       "codebuild:ListReports",
#       "codebuild:DeleteReport",
#       "codebuild:ListReportGroups",
#       "codebuild:BatchPutTestCases",
#       "codebuild:ImportSourceCredentials"
#     ]

#     resources = [
#       "arn:aws:codebuild:us-east-2:*"
#     ]
#   }
#}