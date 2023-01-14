# Disease spread

A disease has erupted in an hospital. The daily change in amount of sick people is calculated like this:

p = amount of sick people
k = coefficient

```
p = p        + p  ⋅ k ⋅ ⎛1 - p ⎞
     (t - 1)    t       ⎝     t⎠
```

## Language
Written in full UASM-assembly for a x84_64 processor under linux
Why? 
- I wanted to get familiar with the FPU
- This project is fairly easy to write in ASM
- I can pat myself on the back that this code is fast (though I have some potential for optimization... Buffering writes instead of invoking int80h,4 all the time)

## Examples

![example 1](https://github.com/Wittmaxi/Simulations/blob/main/disease_spread/photo_2023-01-15_00-24-40.jpg?raw=true)
![example 2](https://github.com/Wittmaxi/Simulations/blob/main/disease_spread/photo_2023-01-15_00-24-45.jpg?raw=true)
![example 3](https://github.com/Wittmaxi/Simulations/blob/main/disease_spread/photo_2023-01-15_00-24-49.jpg?raw=true)
![example 4](https://github.com/Wittmaxi/Simulations/blob/main/disease_spread/photo_2023-01-15_00-24-53.jpg?raw=true)
