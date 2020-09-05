---
title: Main Page Example
---
```curry
-- Returns the last element of a list.
last :: [a] -> a
last (_ ++ [x]) = x

-- Returns some permutation of a list.
perm :: [a] -> [a]
perm []     = []
perm (x:xs) = insert (perm xs)
 where insert ys     = x : ys
       insert (y:ys) = y : insert ys
```