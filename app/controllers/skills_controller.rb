class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_skill, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @skills = Skill.all
    @skills_props = { skills: @skills }
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.teacher = current_user
    if @skill.save
      current_user.skills << @skill
      redirect_to @skill, notice: 'Skill was successfully created.'
    else
      render :new, locals: { skill: @skill }
    end
  end

  def show
    @teacher = @skill.teacher
  end

  def edit
  end

  def update
    if current_user != @skill.teacher
      redirect_to @skill, notice: 'You can only edit your own skill.'
    elsif @skill.update(skill_params)
      redirect_to @skill, notice: 'Skill was successfully updated.'
    else
      render :edit, locals: { skill: @skill }
    end
  end

  def destroy
    if current_user != @skill.teacher
      redirect_to @skill, notice: 'You can only delete your own skill.'
    elsif @skill.destroy
      redirect_to skills_path, notice: 'Skill was successfully deleted.'
    end
  end


  private

  def find_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:title, :description)
  end
end
