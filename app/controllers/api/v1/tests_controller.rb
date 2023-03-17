class Api::V1::TestsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    result = [
      { id: 1, name: "alex" },
      { id: 2, name: "john" }
    ]
    render json: result
  end
end
