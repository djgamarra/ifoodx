class OrderChannel < ApplicationCable::Channel
  def subscribed
    reject_subscription if params[:user_id].nil?
    if User.find_by(id: params[:user_id]).is_admin
      stream_from "user"
    else
      stream_from "user_#{params[:user_id]}"
    end
  end

  def unsubscribed
  end
end
