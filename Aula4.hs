module Aula4 where

-- ** Lambdas: São funcoes anonimas e sao enxergadas pelo compilador como valor do tipo FUNÇÃO (o lambida eh a barra invertida!!)

-- ghci> (\x -> x + 1) 5            "o 5 assume papel do x e o resultado é 6"
-- ghci> (\x y -> x ++ y ++ "!!") "OI" " FATEC"        "o resultado é OI FATEC!!"
-- ghci> (\x y z -> x * y * z) 2 3 4         "o resultado é 24"
-- ghci> (\x y z  -> y) 2 1 3            "1"
-- ghci> (\x y   -> (x,y)) "True" "K"            "(True, "k")"
-- ghci> (\x y z  -> 8) 2 5 3            "8"


-- ** Funções de alta ordem (High-Order functions): São funções que recebem e/ou retornam outras funções.
-- exercicios com isso na prova precisa colocar a linha de raciocionio, se nn ele desconsidera!!!

-- a)
-- ghci> (\f -> f 5) (\x -> 3*x)
-- = (\x -> 3 * x) 5
-- = 3 * 5 = 15

-- b)
-- ghci> (\g f -> g(f 3)) (\x -> x) (\y -> 4)
-- = (\x -> x) ((\y -> 4) 3)
-- = (\x -> x) 4
-- = 4

-- c)
-- ghci (\f -> f 1) 3
-- = 3 1  ----> ERRO

-- d)
-- ghci (\g x -> x ++ g x) reverse "Fatec "
-- = "Fatec " ++ reverse "Fatec "
-- = "Fatec  cetaF"

-- e)
-- ghci (\f g x -> f x ++ g x) reverse (\x -> x ++ "AB") "SANTOS"
-- = reverse "SANTOS" ++ (\X -> X ++ "AB") "SANTOS"
-- = reverse "SANTOS" ++ "SANTOSAB" 
-- = "SOTNASSANTOSAB"

-- f)
-- ghci (\f g -> (f(f 1)),g 2)) (\x -> 2 * x) (\x -> 9)
-- = ( (\x -> 2 * x)((\x -> 2 * x) 1),(\x -> 9)2) )
-- = ((\x -> 2 * x) 2),9 )
-- = (4,9)

-- ** Currying: ato de chamar uma função com o número de argumentos menor que o pedido, retornando uma função.

-- a)
-- ghci s = (\x y z -> x + y + z) 1 3
-- Logo , s= (\z -> 1 + 3 + z)
-- ghci (\f -> f 1) s
-- = (\z -> 1 + 3 + z) 1
-- = 5

-- b)
-- ghci (2+) = (\x y -> x + y)2        "o haskkel interpreta o (2+) assim porque ficaria (\y -> 2 + y)"

-- c)
-- ghci (\f g -> g(f 1))(+2)(3*)
-- = (3*)((+2)1)
-- = (3*)3
-- = 9

-- d)
-- ghci (\f -> 1 + f 3) (+5)
-- = 1 + (+5)3
-- = 1 + 8
-- = 9

-- e)
-- ghci (\f -> f 3) (== 2)
-- = (==2) 3
-- = False

-- f)
-- ghci (\x f g -> f x (g x))7 (+) (2*)
-- = (+) 7 ((2*)7)
-- = (\x y -> x + y)7 ((2*)7)
-- = (7+) 14
-- = 21

-- g)
-- ghci (\x f -> x == f x) 5 (\x -> x)
-- = 5 == (\x -> x)5
-- = 5 == 5
-- TRUE

-- h)
-- ghci (\f -> f 2) (>3)
-- = (>3) 2
-- = FALSE

-- i)
-- ghci s = (\x y z -> x * y * z) 3
-- (\x -> s x x) 5
-- = ((\x y z -> x * y * z) 3 5 5)
-- = 75 

-- f alternativo -> (\x f g -> f x (g x)) (+) (2*)
-- == (\g -> (2*)(+) (g(+)) -> ERRO DE COMPILAÇÃO!!!


-- ** Map: a função de alta ordem  map recebe uma função e uma lista como parâmetros. 
-- Esta função retorna uma lista com a função aplicada em todos os elementos.

-- map f [] = []   e    map f [e1,e2,...,en] = [fe1,fe2,...,fen]

-- a) map (+2) [1,2,3,4] = [3,4,5,6]
-- b) map reverse ["oi", "fatec"] = [reverse "oi", reverse "fatec"] -> ["oi","cetaf"]
-- c) map (==2) [1..5] = [false,true,false,false,false]
-- d) map (\x -> x) [1,2,3] = [1,2,3]
-- e) map (\x -> 8) [1 .. 4] = [8,8,8,8]

-- ** Filter: o filter é uma função de alta ordem que recebe um predicado (função que retorna bool) e uma lista.
-- a mesma retorna os elementos que são TRUE de acordo com o predicado.

-- a) filter (>1) [1,2,3] = [2,3]
-- b) filter (\x -> x == "oi") ["oi", "fatec"] = ["oi"]
-- c) filter (5==) [1,2,3,4] = []
-- d) filter (\x -> x + 2 > 4) [1,2,3,4] = [3,4]

-- ** Fold-Left : fold-left é uma função de alta ordem que recebe um operador binario (função com 2 parametros), um valor inicial
-- e uma lista. A função retorna um valor que é fruto de sucessivas aplicações do operador no valor acumulado e no valor da lista.

-- foldl f v [] = v    e   foldl f v [e1,e2,...,en] = f(f(f v e1) e2)en)

-- a) foldl (+) 0 [1,2,3]    -> isso basicamente ta somando todos os itens
-- = (+)((+)((+) 0 1)2)3
-- = 6

-- b) foldl (*) 1 [1..5]
-- = 1*1*2*3*4*5 = 120

-- c) foldl (++) "" ["oi","fatec","santos"]
-- = "oifatecsantos"