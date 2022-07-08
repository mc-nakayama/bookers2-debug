class GroupsController < ApplicationController
  before_action :ensure_correct_owner, only: [:edit,:update]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @new_book = Book.new
  end

  # 参加機能
  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to  groups_path
  end
  # 離脱機能
  def leave
    @group = Group.find(params[:group_id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end


  #メール送信機能
  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    NoticeMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end


  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_owner
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
