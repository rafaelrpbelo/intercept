defmodule Intercept.Email do
  import Bamboo.Email

  @default_subject "Got a new notification"

  def notify(body, subject \\ @default_subject) do
    new_email(
      to: "john@example.com",
      from: "support@myapp.com",
      subject: "[INTERCEPT] #{subject}",
      text_body: body
    )
  end
end
