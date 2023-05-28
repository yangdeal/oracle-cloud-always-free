module "k8s_services" {
  source = "./services"

  name = "test_nginx"
  image = "nginx"

}
