---
title: Main Page Example
---
```curry
-- | Returns the last element.
last :: [a] -> a
last xs | ys ++ [x] =:= xs = x
  where
    x, ys free
```