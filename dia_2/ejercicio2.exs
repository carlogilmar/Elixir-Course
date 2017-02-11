IO.puts "Ejercicio 2"

defmodule Geometry do

  defmodule Rectangle do
    def area(a,b) do
      a*b
    end

    def perimetro(a,b)do
      a+a+b+b
    end
  end

  defmodule Circle do
    def area(r), do: 3.1415*r*r
  end

end

Geometry.Rectangle.area(1,2)  |> IO.puts
Geometry.Rectangle.perimetro(1,2)  |> IO.puts
Geometry.Circle.area(2) |> IO.puts

Geometry.Rectangle.area(1,2) |> Geometry.Circle.area |> IO.puts
