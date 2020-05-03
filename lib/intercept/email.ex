defmodule Intercept.Email do
  import Bamboo.Email

  def notify(body) do
    new_email(
      to: "john@example.com",
      from: "support@myapp.com",
      subject: "[INTERCEPT] Got a new notification",
      text_body: body
    )
  end
end
