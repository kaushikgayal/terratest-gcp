variables{
    project = "fluted-bit-403323"
    env = "dev"
    subnet = "dev-subnet-01"
    total_servers = 1
    auth_token = "ya29.a0AfB_byBBdJc4uFiZF4jvfV7r_XarDGduYPMbJ0G-axCMLykPe7-lwOBtZRXBnjl1ESY5t6vitI8fRPi9XhlbSAD15UJFrfbcxPLwoTj3TmXnqTAn13snAoksBJGaQvRj91LqA_g3k40s2UcSTbWHEkaWCxskGOZugh_EMluMft8aCgYKAWkSARISFQGOcNnCsGh2FRWol1ry-5ZOiAeh0g0178"
}

provider "google" {
  project      = var.project
  access_token = var.auth_token
}

provider "google-beta" {
  project      = var.project
  access_token = var.auth_token
}

run "good_input_should_pass"{
  command = plan
}

run "bad_input_should_fail"{
  command = plan
  variables {
    total_servers = 200
  }
  expect_failures = [
    var.total_servers
  ]
}



run "http_server_name_check"{
    command = apply
    module {
        source = "../../modules/http_server"
    }

    assert {
        condition = output.instance_name == "dev-apache2-instance"
        error_message = "Http Server Name is not matching the expected value!"
    }
}

run "is_website_running" {
  command = apply

  module {
    source = "./tests/helpers"
  }

  variables {
    endpoint = run.http_server_name_check.external_ip
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}