class ContactUsController < ApplicationController
    def index
    end

    def create
        name = params[:name]
        from = params[:email]
        message = params[:message]

        if name.blank? || from.blank? || message.blank?
            return head :bad_request
        end

        Mailer.contact_us_email(name, from, message).deliver_now

        Email.create!(name: name, from: from, message: message)

        head :created
    end
end
