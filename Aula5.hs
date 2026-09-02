module Aula5 where

data Valor = VInt Int | VBool Bool deriving Show
type Memoria = [(String, Valor)]
data Expr = CInt Int | CBool Bool | Soma Expr Expr | Var String | Leq Expr Expr | Eq Expr Expr deriving Show

data Pgm = Print Expr | Atr String Expr | Se Expr Pgm Pgm | Seq Pgm Pgm | Skip  deriving Show
type Tela  = [String]

execp :: Memoria -> Pgm -> (Memoria, Tela)
execp mem Skip = (mem, [])
execp mem (Print exp) = 
        let 
            valor = exec mem exp
        in
            (mem, [show valor])
execp mem (Seq p1 p2) = 
        let 
            (mem1, tela1) = execp mem p1
            (mem2, tela2) = execp mem1 p2
        in
            (mem2, tela1 ++ tela2)
execp mem (Atr var exp) = 
        let 
            valor = exec mem exp
        in 
            (upsertAl var valor mem, [])
execp mem (Se cond p1 p2) = 
        let 
            condicao = exec mem cond
        in 
             case (condicao) of
                VBool True -> execp mem p1
                VBool False -> execp mem p2

-- funcao de sobrescrever variaveis
upsertAl :: String -> Valor -> Memoria -> Memoria
upsertAl key newVal [] = [(key, newVal)]
upsertAl key newVal ((k,v) : xs)
    | key == k = (key,newVal) : xs
    | otherwise = (k,v) : upsertAl key newVal xs

exec :: Memoria -> Expr -> Valor
exec mem (CInt n) = VInt n
exec mem (CBool b) = VBool b
exec mem (Var x) = carregar x mem
exec mem (Soma e1 e2) = 
        let 
            valor1 = exec mem e1
            valor2 = exec mem e2
        in 
            case (valor1, valor2) of
                (VInt x, VInt y) -> VInt (x+y)
                _ -> error "SOMA SO FAZ COM INTEIRO"
exec mem (Leq e1 e2) =
        let 
            valor1 = exec mem e1
            valor2 = exec mem e2
        in 
            case (valor1, valor2) of
                (VInt x, VInt y) -> VBool (x <= y)
                _ -> error "LEQ SO FAZ COM INTEIRO"
exec mem (Eq e1 e2) =
        let 
            valor1 = exec mem e1
            valor2 = exec mem e2
        in 
            case (valor1, valor2) of
                (VInt x, VInt y) -> VBool (x == y)
                (VBool x, VBool y) -> VBool (x == y)
                _ -> error "LEQ SO FAZ COM INTEIRO"

carregar :: String -> Memoria -> Valor
carregar var mem =
    case lookup var mem of
        Just x -> x
        Nothing -> error "Variavel nao encontrada"

-- o tipo Lista é um tipo recursivo. o seu caso base é o cons (construtor) vazio
-- o passo de recursao é dado pelo cons. O contrutor cons recebe um inteiro e uma continuação (recursiva)
data Lista = Vazio | Cons Int Lista deriving Show

toHaskellLista :: Lista -> [Int]
toHaskellLista Vazio = []
toHaskellLista (Cons n cont) = n : toHaskellLista cont

-- toHaskellLista (Cons 1 (Cons 2 (Cons 3 Vazio))) 
-- = 1 : toHaskellLista (Cons 2 (Cons 3 Vazio))
-- toHaskellLista (Cons 2 (Cons 3 Vazio))
-- = 2 : toHaskellLista (Cons 3 Vazio)
-- toHaskellLista (Cons 3 Vazio)
-- = 3 : toHaskellLista Vazio
-- toHaskellLista  Vazio
-- = Vazio      cai no caso base

-- resultado fica [1,2,3]

fromHaskellLista :: [Int] -> Lista
fromHaskellLista [] = Vazio
fromHaskellLista (a : as) = Cons a (fromHaskellLista as) 


-- Recursao : tecnica de programacao que chama a si proprio
-- para resolver problemas menores.  A recursao é constituida
-- de um caso base e o passo de recursao (neste caso o 0 e 1 são os casos base)

fat :: Int -> Int 
fat 0 = 1 -- pattern matching
fat 1 = 1 -- pattern matching
fat n = n * fat(n-1)

-- fat 5 = 5 * fat(4) -> fat 4 = 4 * fat(3) e por ai vai ate ser fat 1 = 1
-- entao ele multiplica todos os resultados nesse caso: 5 * 4 * 3 * 2 * 1 = 120
-- ele faz um looping ate encontrar o caso base, ele monta uma pilha ate encontrar o caso base
-- chegando no caso base ele tem solucao, entao ele vai fazendo o processo inverso ate chegar na primeira da pilha.

-- funcao de modulo
modulo :: Int -> Int 
modulo n 
    | n >= 0 = n
    | otherwise = -n


fatt :: Int -> Int
fatt n 
    | n <= 1 = 1 
    | otherwise =  n * fat(n-1)


-- map é uma funcao polimorfica 
-- funcao polimorfica:  é uma funcao ao qual os tipos de entrada ou de saida
-- sao dados por variaveis. No caso do map, a e b    map :: (a,b) -> [a] -> [b]

-- polimorfismo parametrico nos deixa criar funcoes que possuem o mesmo comportamento
-- independentemente do tipo


-- f :: a -> b    é uma funcao de alta ordem que recebe um valor de tipo a e devolve um valor de tipo b
-- [a] :: uma lista de tipo a
-- [b] :: retorna uma lista de tipo b

mapa :: (a -> b) -> [a] -> [b]
mapa f [] = [] --caso base
mapa f (a : as) = f a : mapa f as -- passo de recursao
                                                        -- lemos esses resultados da utlima linha pra primeira !!
-- mapa (+1) [1,2,3,4] = ((+1) 1) : mapa (+1) [2,3,4]   -> fica 2:3:4:5:[]
-- mapa (+1) [2,3,4] = ((+1) 2) : mapa (+1) [3,4]       -> fica 3:4:5:[]
-- mapa (+1) [3,4] = ((+1) 3) : mapa (+1) [4]           -> fica 4:5:[]
-- mapa (+1) [4] = ((+1) 4) : mapa (+1) []              -> fica 5:[]
-- ai cai no caso base pois ta vindo a lista vazia
-- vai resolvendo do ultimo ate o primeiro e ficamos com 2:3:4:5:[] = [2,3,4,5]
