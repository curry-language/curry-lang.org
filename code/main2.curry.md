---
title: Main Page Example
---
~~~~  {.curry .bg-primary}
-- | Returns the last element.
last :: [a] -> a
last xs | ys ++ [x] =:= xs = x
  where
    x, ys free

--  Additions below
{-|
This is a Doc Comment
|-}

{-# LANGUAGE RankNTypes #-}

helloWorld :: String
helloWorld = "Hello" ++ "World" ++ ['!']

answer = 21 + 21.0
~~~~