---
title: Main Page Example
---
~~~~  {.curry .bg-primary}
-- | Returns the last element.
last :: [a] -> a
last xs | ys ++ [x] =:= xs = x
  where
    x, ys free
~~~~