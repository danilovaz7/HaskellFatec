module Aula3 where

data Dia = Domingo | Segunda | Terca | Quarta | Quinta | Sexta | Sabado  deriving (Show,Eq,Ord,Enum)

data Curso = ADS | SI | RH | CD | GE | GP deriving (Show,Eq,Ord,Enum)

-- o Aluno se comporta "como construtor"
-- em haskell chamamos de value constructor
data Aluno = Aluno String String Int Curso deriving  (Show,Eq,Ord)

-- record syntax: Da nome aos campos, estes nomes sao funcoes de projecao (tipo um getter tlgd)
data Discente = Discente {nome :: String, ra :: String, idade :: Int, curso :: Curso} deriving (Show,Eq,Ord)

fazerAniversarioD :: Discente -> Discente
fazerAniversarioD d = Discente {
    nome    = nome d,     -- d.nome
    ra      = ra d,       -- d.ra
    idade   = idade d + 1,
    curso   = curso d
}

fazerAniversario :: Aluno -> Aluno
fazerAniversario (Aluno nome ra idade curso) = Aluno nome ra (idade + 1) curso