defmodule Intercept.Email do
  import Bamboo.Email

  @default_subject "Got a new notification"

  def notify(body, subject \\ @default_subject) do
    new_email(
      to: email_to(),
      from: email_from(),
      subject: email_subject(subject),
      text_body: body
    )
  end

  defp email_to(), do: Application.get_env(:intercept, Intercept.Email)[:to]
  defp email_from(), do: Application.get_env(:intercept, Intercept.Email)[:from]
  defp email_subject_prefix(), do: Application.get_env(:intercept, Intercept.Email)[:subject_prefix]
  defp email_subject(subject), do: "#{email_subject_prefix()} #{subject}"
end
