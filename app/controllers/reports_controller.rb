# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :ensure_user, only: %i[edit update destroy]
  # GET /reports or /reports.json
  def index
    @reports = Report.includes(:user).order(:id).page(params[:page])
  end

  # GET /reports/1 or /reports/1.json
  def show
    @report = Report.includes(comments: :user).find(params[:id])
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
    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human) }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    @report = Report.find(params[:id])
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human) }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human) }
      format.json { head :no_content }
    end
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
