defmodule CuidarMePrjWeb.UserForgotPasswordLive do
  use CuidarMePrjWeb, :live_view

  alias CuidarMePrj.Accounts

  def render(assigns) do
    ~H"""
    <div class="w-screen h-screen bg-fundo flex items-center font-pop font-semibold">

        <div class="w-[460px] h-[582px]  border rounded-3xl bg-zinc-100 m-auto">
        <img class="m-auto mt-16" src="https://beneficiarios.cuidar.me/assets/black.292e99da.svg"
        alt="Logo da cuidar.me">

          <.simple_form for={@form} id="reset_password_form" phx-submit="send_email" class="flex flex-col items-center mt-20">
            <.input field={@form[:email]} type="email" placeholder="Email" required />
            <:actions>
            <.button phx-disable-with="Sending..." class="mt-8 m-auto w-[245px] h-[58px] border rounded-3xl bg-botao text-white">
              Redefinir senha
            </.button>
            </:actions>
          </.simple_form>
            <p class="text-center text-sm mt-4">
            <.link href={~p"/users/register"}>Registrar</.link>
          | <.link href={~p"/users/log_in"}>Login</.link>
            </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
