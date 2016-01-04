class Mailer < ApplicationMailer
    def contact_us_email(name, from, message)
        @name = name
        @from = from
        @message = message
        mail(to: 'amyandkevinswedding2016@gmail.com', from: from, subject: "Amy and Kevin's Wedding - Contact Us")
    end
end
