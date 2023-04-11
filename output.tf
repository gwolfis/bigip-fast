# Output

output "FAST_Template_Deployment" {
  value = <<EOF
      application  : ${bigip_fast_https_app.fast_https_app.application}
      tenant       : ${bigip_fast_https_app.fast_https_app.tenant}
      virtual_ip   : ${bigip_fast_https_app.fast_https_app.virtual_server[0].ip}
      virtual_port : ${bigip_fast_https_app.fast_https_app.virtual_server[0].port}
    EOF
}