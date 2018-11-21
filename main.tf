locals {
  service_name            = "${local.unique_id}-thor"
  service_log_group_name  = "${local.unique_id}-thor-service-logs"
  service_container_port  = 8080
  region                  = "us-east-1"
}

module "service-infra" {
  source = "git@github.com:ecsworkshop2018/terraform_modules.git//ecs-service-module"
  unique_id = "${local.unique_id}"
  region = "${local.region}"
  service_name = "${local.service_name}"
  target_group_name = "thor-tg"
  docker_image = "${var.docker_image}"
  cluster_name = "ecs-cluster"
  alb_path_pattern = "/thor/*"
  service_container_port = "${local.service_container_port}"
  vpc_name = "dev-ecs-workshop"
  service_log_group_name = "${local.service_log_group_name}"
  health_check_endpoint = "/thor/actuator/health"
  alb_name = "${local.unique_id}-asgard-alb"
}