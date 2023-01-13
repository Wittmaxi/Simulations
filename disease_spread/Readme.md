# Disease spread

A disease has erupted in an hospital. The daily change in amount of sick people is calculated like this:

p = amount of new sick people
k = coefficient

```
p        = p  ⋅ k ⋅ ⎛1 - p ⎞
 (t + 1)    t       ⎝     t⎠
```

S = total amount of sick people during n days
```
      n
     ___
S =  ╲    p 
     ╱     i
     ‾‾‾
    i = 0
```
