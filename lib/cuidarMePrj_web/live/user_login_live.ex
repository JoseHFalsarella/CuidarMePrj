defmodule CuidarMePrjWeb.UserLoginLive do
  use CuidarMePrjWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-screen h-screen bg-fundo flex items-center font-pop font-semibold">

      <div class="w-[460px] h-[582px]  border rounded-3xl bg-zinc-100 m-auto ">

      <img class="m-auto mt-16" src="https://beneficiarios.cuidar.me/assets/black.292e99da.svg"
            alt="Logo da cuidar.me">

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore" class="flex flex-col items-center ">
        <.input field={@form[:email]} type="email" label="Email" required/>

            <.icon name="hero-identification" class="h-6 w-6 text-darkBlue absolute -translate-y-[68px] translate-x-3  z-10 "/>

        <.input field={@form[:password]} type="password" label="Senha" required />

            <.icon name="hero-lock-closed" class="h-6 w-6 text-darkBlue absolute -translate-y-[68px] translate-x-3 z-10"/>

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Manter conectado"/>
          <.link href={~p"/users/reset_password"} class="text-sm font-pop text-fundo underline-offset-1">
          Esqueceu sua senha?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="mt-8 m-auto w-[245px] h-[58px] border rounded-3xl bg-botao text-white">
          Entrar
          </.button>
        </:actions>
      </.simple_form>
    </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
