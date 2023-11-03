resource "shoreline_notebook" "docker_network_routing_issue" {
  name       = "docker_network_routing_issue"
  data       = file("${path.module}/data/docker_network_routing_issue.json")
  depends_on = [shoreline_action.invoke_docker_network_check,shoreline_action.invoke_network_management]
}

resource "shoreline_file" "docker_network_check" {
  name             = "docker_network_check"
  input_file       = "${path.module}/data/docker_network_check.sh"
  md5              = filemd5("${path.module}/data/docker_network_check.sh")
  description      = "Check the Docker network configuration and ensure that it is set up properly to avoid any potential routing issues."
  destination_path = "/tmp/docker_network_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "network_management" {
  name             = "network_management"
  input_file       = "${path.module}/data/network_management.sh"
  md5              = filemd5("${path.module}/data/network_management.sh")
  description      = "If the issue is affecting multiple containers, consider recreating the network entirely."
  destination_path = "/tmp/network_management.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_docker_network_check" {
  name        = "invoke_docker_network_check"
  description = "Check the Docker network configuration and ensure that it is set up properly to avoid any potential routing issues."
  command     = "`chmod +x /tmp/docker_network_check.sh && /tmp/docker_network_check.sh`"
  params      = ["NETWORK_NAME"]
  file_deps   = ["docker_network_check"]
  enabled     = true
  depends_on  = [shoreline_file.docker_network_check]
}

resource "shoreline_action" "invoke_network_management" {
  name        = "invoke_network_management"
  description = "If the issue is affecting multiple containers, consider recreating the network entirely."
  command     = "`chmod +x /tmp/network_management.sh && /tmp/network_management.sh`"
  params      = ["YOUR_NETWORK_NAME"]
  file_deps   = ["network_management"]
  enabled     = true
  depends_on  = [shoreline_file.network_management]
}

