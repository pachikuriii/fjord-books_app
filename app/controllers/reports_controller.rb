# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :ensure_user, only: %i[edit update destroy]
  # GET /reports or /reports.json
  def index
    @reports = Report.includes(:user).order(:id).page(params[:page])
  end

  # GET /reports/1 or /reports/1.json
  def show
    @report = Report.find(params[:id])
    @comments = @report.comments
    @comment = current_user.comments.build
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports or /reports.json
  def create
    @report = current_user.reports.build(report_params)

      if @report.save
        redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human) 
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    @report = Report.find(params[:id])
      if @report.update(report_params)
         redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human) 
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def ensure_user
    @reports = current_user.reports
    @report = @reports.eager_load(:user).find_by(id: params[:id])
    redirect_to new_report_path unless @report
  end
end
