---
title: "Markdown Test"
---
<section>
:::md:max-w-3xl

Dark Background section
==============================

Legible Text Test

## Paragraph

Currently, there is no support for automatically uploading
and publishing new packages.
However, if you have developed some package that might be of
interest to other Curry users, please send the package
as a tar or zip file to

## Text with link

For further information, look into the  [manual of CPM](https://www-ps.informatik.uni-kiel.de/currywiki/_media/tools/cpm/manual.pdf){rel="external noopener noreferrer"}

## Shell Code

---

```sh
> cypm curry
```

---

## Curry Code

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

## Inline Code


If you need some other packages for your project,
add them as a dependency in `package.json`.

:::
</section>
<section>
:::md:max-w-3xl

Light Background section
==============================

Legible Text Test

## Paragraph

Currently, there is no support for automatically uploading
and publishing new packages.
However, if you have developed some package that might be of
interest to other Curry users, please send the package
as a tar or zip file to

## Text with link

For further information, look into the  [manual of CPM](https://www-ps.informatik.uni-kiel.de/currywiki/_media/tools/cpm/manual.pdf){rel="external noopener noreferrer"}

## Shell Code

---

```sh
> cypm curry
```

---

## Curry Code

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

## Inline Code


If you need some other packages for your project,
add them as a dependency in `package.json`.

:::
</section>