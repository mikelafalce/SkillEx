class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :authenticate_user!

  def index
    @lessons = Lesson.all
  end

  def my_lessons
    @my_lessons_as_teacher = current_user.lessons_as_teacher
    @my_lessons_as_student = current_user.lessons_as_student
  end

  def show
  end

  def new
    @lesson = Lesson.new
    @skill = Skill.find_by(id: params[:skill])
  end


  def confirm
    if @lesson.teacher != current_user
      redirect_to @lesson, notice: 'You can only confirm lessons you teach.'
    else
      @lesson.confirmed_at = DateTime.now
      @lesson.save
      redirect_to @lesson, notice: 'Lesson was successfully confirmed.'
    end
  end


  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.skill = Skill.find_by(id: params[:skill])
    @lesson.teacher = @lesson.skill.teacher
    @lesson.student = current_user
    @lesson.requested_at = DateTime.now
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully requested.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @lesson.teacher_id != current_user.id
       format.html { redirect_to @lesson, notice: 'Sorry, you may only edit your own lessons!' }
      elsif @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def lesson_params
      whitelisted = params.require(:lesson).permit(:skill, :teacher, :student, :teacher_rating_student, :student_rating_teacher, :start_time, :hours, :requested_at, :confirmed_at)
      whitelisted.merge(teacher_id: current_user.id.to_i)
    end
end
