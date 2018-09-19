class FederationController < ApplicationController
  def toml
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Content-Type"] = "application/toml"
  end
end
