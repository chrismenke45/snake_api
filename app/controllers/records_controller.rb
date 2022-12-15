class RecordsController < ApplicationController
  #protect_from_forgery with: :null_session
  before_action :cors_set_access_control_headers

  # GET /records or /records.json
  def index
    @records = Record.order(score: :desc).limit(10)
    render :json => @records
  end

  # POST /records or /records.json
  def create
    @record = Record.new(record_params)

    if @record.save
      Record.order("score desc").offset(10).destroy_all
      render json: @record, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def record_params
    params.require(:record).permit(:name, :score)
  end

  #set headers
  def cors_set_access_control_headers
    #headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Origin"] = ENV["CLIENT_URL"]
    headers["Access-Control-Allow-Methods"] = "POST, PUT, DELETE, GET, OPTIONS"
    headers["Access-Control-Request-Method"] = "*"
    headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  end
end
