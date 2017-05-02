
class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_skill, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @lesson = Lesson.new
    if current_user
      @current_user_id = current_user.id
    end
    if params[:search]
      @skills = Skill.search(params[:search])
    else
      @skills = Skill.all
    end
  end

  def my_skills
    @skills = current_user.skills
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
    @reviewed_lessons = @skill.lessons.where.not(student_reviewing_teacher: nil, student_reviewing_teacher: '')
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
    params.require(:skill).permit(:title, :description, :search, :avatar, :avatar_cache, :remove_avatar)
  end
end
