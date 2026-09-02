module ExAula3 where 


    data Correncia = USD | BTC | BRL deriving (Show,Eq,Ord,Enum)

    data Moeda = Moeda {
        valor       :: Double, 
        correncia   :: Correncia
        } deriving (Show,Eq,Ord)

    converterBRL :: Moeda -> Moeda
    converterBRL (Moeda x USD) = Moeda (x * 5.2) BRL
    converterBRL (Moeda x BTC) = Moeda (x * 337364.41) BRL
    converterBRL m = m

    dobrarMoeda :: Moeda -> Moeda
    dobrarMoeda (Moeda x c) = Moeda (x * 2) c

    somarMoedas :: Moeda -> Moeda -> Maybe Moeda
    somarMoedas (Moeda v1 USD) (Moeda v2 USD) = Just (Moeda (v1 + v2) USD)
    somarMoedas (Moeda v1 BRL) (Moeda v2 BRL) = Just (Moeda (v1 + v2) BRL)
    somarMoedas (Moeda v1 BTC) (Moeda v2 BTC) = Just (Moeda (v1 + v2) BTC)
    somarMoedas m1 m2 = Nothing

    somarMoedas1 :: Moeda -> Moeda -> Either String Moeda
    somarMoedas1 (Moeda v1 USD) (Moeda v2 USD) = Right (Moeda (v1 + v2) USD)
    somarMoedas1 (Moeda v1 BRL) (Moeda v2 BRL) = Right (Moeda (v1 + v2) BRL)
    somarMoedas1 (Moeda v1 BTC) (Moeda v2 BTC) = Right (Moeda (v1 + v2) BTC)
    somarMoedas1 m1 m2 = Left "Tipos de moeda diferentes"
