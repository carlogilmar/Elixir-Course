defmodule BankAccountGS do
  use GenServer


  #Api
  def start_link(balance \\ 0)do
    GenServer.start_link(__MODULE__, balance)
  end

  def deposit(account, amount) do
    GenServer.cast(account, {:deposit, amount})
  end

  def withdraw(account, amount) do
    GenServer.cast(account, {:withdraw, amount})
  end

  def balance(account) do
    GenServer.call(account, :balance)
  end

  #Server CallBacks
  def init(balance)do
    {:ok, balance}
  end

  def handle_cast({:deposit, amount}, balance) do
    {:noreply, balance + amount}
  end

  def handle_cast({:withdraw, amount}, balance) do
    {:noreply, balance - amount}
  end

  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end

end

