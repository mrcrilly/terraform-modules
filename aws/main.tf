# This is primarily for running tests, but it also acts
# as an example for review and learning.

module "vpc" {
  source = "./vpc"
  cidr = "10.1.0.0/16"
}