class FavoriteMailer < ActionMailer::Base
  default from: "mrdougwright@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@sheltered-forest-8124.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@sheltered-forest-8124.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@sheltered-forest-8124.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")    
  end
end
