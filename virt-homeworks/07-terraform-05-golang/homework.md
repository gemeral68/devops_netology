# 7.5 "Основы golang"
## Задание 1
### Установите golang.
```sh
[bulat@bulat-pc GOlang]$ go version
go version go1.19.5 linux/amd64
```

## Задание 3
### Написание кода.
- Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:
```go
package main
import (
    "fmt"
)
 
func main() {
    var distance float64
    fmt.Println("Введите расстояние в футах: ")
    fmt.Scan(&distance)
    
    var distancekm float64 = distance * 0.3048
    if distancekm >= 0 {
    	fmt.Println("Расстояние в km:") 
    	fmt.Println(distancekm)
    }else{
    	fmt.Println("Введенное значение некорректно")
    }	
}
```
- Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
```
x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
```

```go
package main
import (
    "fmt"
    "sort"
)
 
func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    sort.Ints(x)
    fmt.Println(x[0])
}
```

- Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).
```go
package main
import (
    "fmt"
)

func main() {
    a := []int{}
    for i := 1; i <= 100; i++ {
        if i % 3 == 0 {
            a = append(a, i)
        }
    }
    fmt.Println(a)
}
```
