class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :authenticate_user!
  
  def index
    @lessons = Lesson.all
  end

  def my_lessons
    @my_lessons = Lesson.where(teacher_id: current_user.id) 
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
      UserMailer.confirm_lesson(@lesson).deliver_now!
      redirect_to @lesson, notice: 'Lesson was successfully confirmed.'

      
  
    end
  end

   
  def create
    @lesson = Lesson.new(lesson_params)
    @skill = Skill.find_by(id: params[:skill])
    @lesson.skill = @skill
    @lesson.teacher = @lesson.skill.teacher
    @lesson.student = current_user
    @lesson.requested_at = DateTime.now
    respond_to do |format|
      if @lesson.teacher == current_user
        format.html { redirect_to @skill, notice: 'You cannot learn your own skill.' }
      elsif @lesson.start_time < DateTime.now
        format.html { redirect_to @skill, notice: 'You cannot schedule a lesson in the past.' }
      elsif @lesson.save
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
      whitelisted = params.require(:lesson).permit(:skill, :teacher, :student, :teacher_rating_student, :student_rating_teacher, :start_time, :end_time, :requested_at, :confirmed_at, :hours)
      whitelisted.merge(teacher_id: current_user.id.to_i)
    end
end
