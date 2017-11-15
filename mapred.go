
package main

import (
	"bufio"
	"fmt"
	"os"
        "strings"
        "strconv"
)

func main() {
    var columns int
    var rcounter int
    file_path := "./file_list.txt"
    c1 := make(chan int)
    w1 := make(chan int)
    s1 := make(chan bool)

    f, _ := os.Open(file_path)
    scanner := bufio.NewScanner(f)
    for scanner.Scan() {
        line := scanner.Text()
        // Split the line on commas.
        parts := strings.Fields(line)
        columns = len(parts)
        break
    }
    f.Close()

    go reader0(c1, w1, s1, file_path )
    rcounter++
    //go writer0(c1, w1)
    //rcounter++
    _ = columns

    for {
        cstate := <-s1
        if cstate == false {
            break
        }
        number := <-c1
        fmt.Println(number)
    }
    

    for ;rcounter!=0;rcounter-- {
       _ = <-w1
       //fmt.Println("rcounter:", rcounter) 
    }
}




func reader0(c1 chan int, w1 chan int, s1 chan bool, file_path string) {
    f, _ := os.Open(file_path)
    scanner := bufio.NewScanner(f)
    for scanner.Scan() {
        s1 <- true
        line := scanner.Text()

        // Split the line on commas.
        parts := strings.Fields(line)
        //fmt.Println(parts[0], parts[1])
        number, _ := strconv.Atoi(parts[1])
        c1 <- number + 1
    }
    //c1 <- rand.Int()
    f.Close()
    s1 <- false
    w1 <- 0
}

//func writer0(c1 chan int, w1 chan int) {
//    number := <-c1
//    fmt.Printf("%d\n", number++)
//    w1 <- 0
//} 

