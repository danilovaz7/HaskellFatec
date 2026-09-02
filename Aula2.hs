module Aula2 where 

dobro :: Int -> Int
dobro x = x * 2

somar :: Int -> Int -> Int
somar x y = x + y

func :: Int -> [Int] -> [Int]
func x xs = (x + 1) : xs

func2 :: String -> Bool
func2 ps = even (length ps)



-- list comprehension (permite criar listas a partir de oexpressoes e filtros)
-- eh um filtro denumeros primos
ehPrimo :: Int -> Bool
ehPrimo n = length [x | x <- [1 .. n], mod n x == 0] == 2

-- listas sao estruturas que carregar elementos do mesmo tipo e possuem tamanho variavel
-- tuplas sao estruturas que carregam elementos de tipos diferentes e possuem tamanho fixo