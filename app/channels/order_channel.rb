class OrderChannel < ApplicationCable::Channel
  def subscribed
    reject_subscription if params[:user_id].nil?
    stream_from "user_#{params[:user_id]}"
  end

  def unsubscribed
  end
end
