variable get_address_url {
  type = string

  default = "https://api.ipify.org"

  description = "URL for getting external IP address"
}

variable get_address_request_headers {
  type = map

  default = {
    Accept = "text/plain"
  }

  description = "HTTP headers to send"
}