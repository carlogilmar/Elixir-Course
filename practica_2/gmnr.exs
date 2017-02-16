defmodule Guess_my_number do
  def start_game(start_number..final_number,my_number) do
    guess(start_number..final_number,my_number)
  end
  defp guess(start_number..final_number,my_number) when not(my_number >= start_number and my_number <= final_number)  do
    IO.puts "Errozzz"
  end
  defp guess(start_number..final_number,my_number) do
    #Formula ((y-x)/2)+x
    pivot = div((final_number - start_number), 2) + start_number
    IO.puts "Pivot: #{pivot}, start_number: #{start_number}, final_number: #{final_number}, my_number: #{my_number}"
    find_number(pivot,start_number..final_number,my_number)    
  end
  
  defp find_number(pivot, _.._,my_number) when pivot == my_number do 
    IO.puts "Your number is #{my_number}"
  end
  defp find_number(pivot, start_number.._,my_number) when my_number < pivot do
    IO.puts "Calling my number is less than pivot"
    guess(start_number..(pivot),my_number)
  end
  defp find_number(pivot, _..final_number,my_number) when my_number > pivot do
    IO.puts "Calling my number is equals or greater than pivot"
    guess(pivot..final_number,my_number)
  end
end
#No olvidar el orden de las funciones 
#El alcance de las funciones, las llamadas recursivas deben tener el mismo alcance, todas publicas o todas privadas
#El compilador ayuda a depurar el codigo, por ejemplo variables no usadas
