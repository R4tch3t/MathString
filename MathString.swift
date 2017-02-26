//
//  MathString.swift
//  Calculus Lite
//
//  Created by Victor Manuel Santamaria on 1/9/17.
//  Copyright © 2017 Victor Manuel Santamaria. All rights reserved.
//

import Cocoa

class MathString: NSObject {
    
    func cleanR(_ str: String)->String{
        var aux="", rstr=".0"
        var arrStr: Array! = Array(str.characters)
        var str = str
        var bandminus = false
        var i=0, j=0, k=0

        if str == "" || str == " " || str == "0" || str == "00" || str == "NaN" || str == "nan" || str == "inf"
        {
            return "0"
        }
      
        if arrStr != nil {
            if arrStr.first! == "-"{
            bandminus=true
            }
            if arrStr.last! == "."{
                arrStr.removeLast()
            }
            if arrStr.count == 1 && arrStr.first! == "0"{
            return "0"
            }
            
            if arrStr.first! == "-" {
            str=String(arrStr.removeFirst())
            }
            
            var countLeft=0
            if str.contains("."){
                countLeft=str.components(separatedBy: ".")[0].characters.count
               
                while(arrStr.count>0&&arrStr.first! == "0"&&countLeft>1){
                    arrStr.removeFirst()
                    countLeft-=1
                }
                
                countLeft=str.components(separatedBy: ".")[1].characters.count
                
                while(arrStr.count>0&&arrStr.last! == "0"&&countLeft>1){
                    arrStr.removeLast()
                    countLeft-=1
                }
                
            }else{
            
        while(arrStr.count>1&&arrStr.first! == "0"){
            arrStr.removeFirst()
                }
            }
    }
        str = ""
        
        while i<arrStr.count{
            k=i
            aux=""
            
            if((i+2)<=arrStr.count){
                while j<2{
                    aux+=String(arrStr[k])
                    
                    j+=1
                    k+=1
                }
            }
            
            if(aux==rstr){
                
                if i+2>=arrStr.count{
                    
                    break
                }
                str+=String(arrStr[i])
            }
            else{
                str+=String(arrStr[i])
            }
            j=0;
            i+=1;
        }
        
        if bandminus {
            str="-"+str
        }
        return str
    }
    
    func isNumber(_ str: String)->Bool{
      
        return !isSimbol(str)
    }
    
    func isSimbol(_ str: String)->Bool{
        return str == "" || str.contains(" ") || str.contains("+") || str == "-" || str.contains("*") || str.contains("/") || str.contains("c") || str.contains("÷") || str.contains("(") || str.contains(")") || str.contains("quad")
    }
    
    func cos(_ number: String)->String{
        var number=number
        
        return number
    }
    
    func absstr(_ str: String)->String{
        var arr=Array(str.characters)
        if str == "" {
            return str
        }
        
        if arr.first! == "-"{
            arr.removeFirst()
        }
        
        return String(arr)
    }
    
    //"Rasurar" cadena
    func ShaveStr(_ str: String,_ digits: Int)->String{
       var str=str
       
        if str.contains("."){
         var StackStr=Array(str.components(separatedBy: "."))
         var Stack1 = Array(StackStr[1].characters)
          //  str=StackStr[0]+"."
            if Stack1.count > digits{
         
                if Int(String(Stack1[digits]))! > 4{
                    if Int(String(Stack1[digits-1]))! == 9{
                    //Efecto domino inverso a la cadena
                        var i = digits-1
                        Stack1[i]="0"
                        i -= 1
                        if Stack1[i] == "9"{
                                while Stack1[i] == "9" && i > 0 {
                                    Stack1[i]="0"
                                    i -= 1
                                }
                    }
                    
                    if i == 0 {
                        if Stack1[i] == "9" {
                        Stack1[i]="0"
                        StackStr[0]=plusstr(StackStr[0], "1")
                        }else{
                            let n = plusstr(String(Stack1[i]), "1")
                            Stack1[i]=Array(n.characters)[0]
                        }
                    }else{
                        let n = plusstr(String(Stack1[i]), "1")
                    Stack1[i]=Array(n.characters)[0]
                        
                    }
                    
                }else{
                    let n = plusstr(String(Stack1[digits-1]),"1")
                    Stack1[digits-1]=Array(n.characters)[0]
                }
            }
            
            str=StackStr[0]+"."
            var i = 0
            while i < digits {
                str+=String(Stack1[i])
            i += 1
            }
            
            }
            
        }
        
        return cleanR(str)
    }
    
    func addZeros(_ N: Int)->String{
        var str = "1"
        var i = 0
        while i<N {
            str=str+"0"
            i+=1
        }
        return str
    }
    
    
    func powstr(_ numberA: String,_ numberB: String)->String{
     var str = numberA
     var countS = "0"
        
        while LessThan(countS, numberB){
            str = forstr(str, numberA)
            countS = plusstr(countS, "1")
        }
        return str
    }
    
    func isFrac(_ Str: String)->Bool{
        return Str.contains("/") || isNumber(Str)
    }
    
    //a%b
    func residuo(_ numberA: String,_ numberB: String)->String{
        var numberA=numberA
        var numberB=numberB
        var banddecimal = false
        var countDot = 0
        var Result=""
    
        numberA=cleanR(numberA)
        numberB=cleanR(numberB)
        
        if numberA=="1" && numberB=="1"{
            return "0"
        }
        
        if numberA=="1" || numberB=="1"{
            return "1"
        }
       /*
        if numberA.contains("-") && !numberB.contains("-"){
            return numberA
        }
        */
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")
        
        if LessThan(numberA, numberB){
            return numberA
        }
        
        
        
        
        if numberB == "1"{
            return numberA
        }
        
        
        if numberA == "0" && numberB == "0"{
            return "nan"
        }
        
        if numberA == "0" {
            return "0"
        }
        
        if numberB == "0" {
            return "inf"
        }
        
        if numberA.contains("."){
            countDot+=numberA.components(separatedBy: ".")[1].characters.count
        }
        
        if numberB.contains("."){
            countDot+=numberB.components(separatedBy: ".")[1].characters.count
        }
        
        if BiggerThan(numberA, numberB) || BiggerThan(numberB, numberA){
            let aux=numberA
            numberA=numberB
            numberB=aux
            // bandminus=true
        }
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
        
        //      var StackA=Array(numberA.characters)
        var StackB=Array(numberB.characters)
        
        var residuos=""
        var forStr=""
        var sum=""
        var digitLimit = 0
        var countB=0
        var baux=""
        let borg=numberB
        
        //Optimizar, que no es más que disminuir ciclos.
        numberB=""
        while (countB<StackB.count)&&BiggerThan(numberA, numberB) {
            numberB+=String(StackB[countB])
            countB+=1
        }
        
        if numberB == ""{
            numberB=borg
        }
        
        if countB==StackB.count{
            countDot *= -1
            while digitLimit < 128 {
                
            if residuos != "" && LessThan(residuos, numberA){
                    return residuos
                }
                
                baux=residuos+numberB
                if LessThan(baux, numberA){
                    baux+="0"
                    while LessThan(baux, numberA){
                        baux+="0"
                        Result+="0"
                    }
                    
                    banddecimal=true
                    
                }
                
                if baux != ""{
                    numberB=baux
                }
                
                
                
                if numberB == numberA{
                    Result+="1"
                    residuos="0"
                }else {
                    forStr=forstr(numberA, numberA)
                    
                    if LessThan(forStr, numberB){
                        sum=plusstr(numberA,numberA)
                        forStr=forstr(sum,numberA)
                        
                        while LessThan(forStr, numberB){
                            sum=plusstr(sum, numberA)
                            forStr=forstr(sum,numberA)
                            
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, numberA)
                            forStr=forstr(sum, numberA)
                            
                            while BiggerThan(forStr, numberB) {
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                                
                                
                            }
                            
                            while LessThan(forStr, numberB){
                                sum=plusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            
                            
                            while BiggerThan(forStr, numberB){
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            
                            residuos=minusstr(numberB, forStr)
                            
                        }
                        
                    }else{
                        sum="0"
                        forStr="0"
                        while LessThan(forStr, numberB) {
                            sum=plusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                            residuos=minusstr(numberB, forStr)
                            
                        }
                    }
                    
                    Result+=sum
                    
                    
                    
                    
                }
                
                numberB=""
                digitLimit+=1
                
                
            }
            
            
        }
        else{
            
            while  digitLimit < 128 || countB<StackB.count{
                
                
                if numberB == numberA{
                    Result+="1"
                    residuos="0"
                }
                    
                else {
                    forStr=forstr(numberA, numberA)
                    
                    if LessThan(forStr, numberB){
                        sum=plusstr(numberA,numberA)
                        forStr=forstr(sum,numberA)
                        
                        while LessThan(forStr, numberB){
                            sum=plusstr(sum, numberA)
                            forStr=forstr(sum,numberA)
                            
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, numberA)
                            forStr=forstr(sum, numberA)
                            
                            while BiggerThan(forStr, numberB) {
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                                
                                
                            }
                            
                            while LessThan(forStr, numberB){
                                sum=plusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            
                            
                            while BiggerThan(forStr, numberB){
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            residuos=minusstr(numberB, forStr)
                            
                        }
                        
                        
                    }else{
                        sum="0"
                        forStr="0"
                        while LessThan(forStr, numberB) {
                            sum=plusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                            
                            residuos=minusstr(cleanR(numberB), forStr)
                            
                            
                        }
                    }
                    
                    if sum != "0"{
                        Result+=sum
                    }
                    
                    
                }
                
                
                
                numberB=""
                if residuos == "0" && countB >= StackB.count {
                    if cleanR(baux) == "0"{
                        Result += "0"
                    }
                    
                    break
                }
                
                if countB >= StackB.count{
                    
                    baux=residuos+numberB
                    baux=cleanR(baux)
                    
                    
                    if LessThan(baux, numberA){
                        baux+="0"
                        
                        
                        while LessThan(baux, numberA){
                            baux+="0"
                            Result+="0"
                        }
                        
                        
                        banddecimal=true
                        
                    }
                    
                    if countB==StackB.count{
                        countDot+=Result.characters.count
                        
                        if Array(Result.characters).last! == "0"{
                            countDot-=1
                        }
                        
                    }
                    
                    if residuos != "" && LessThan(residuos, numberA){
                        
                        return residuos
                    }
                    
                }
                else {
                    baux=residuos+numberB+String(StackB[countB])
                    baux=cleanR(baux)
                }
                
                while LessThan(baux, numberA) && countB<(StackB.count-1) {
                    countB+=1
                    baux+=String(StackB[countB])
                    Result+="0"
                }
                
                if baux != ""{
                    numberB=baux
                }else{
                    numberB=String(StackB[countB])
                }
                
                
                countB+=1
                digitLimit+=1
                
            }
        }
        
        if !banddecimal {
            banddecimal = numberA.contains(".") || numberB.contains(".")
        }else{
            if countDot > 0{
                var a = Array(Result.characters)
                a.insert(".", at: countDot)
                Result=String(a)
            } else if countDot <= 0{
                var i = countDot
                while i < 0{
                    Result="0"+Result
                    i+=1
                }
                
                Result="0."+Result
            }
            
        }
        
    return residuos
    }
    //Maximo Común Divisor
    func MCD(_ a: String,_ b: String)->String{
       
        
        if b != "0" {
            
            return MCD(b, residuo(a,b))
        
        }
        
        return a
    }
    
    //Menor que
    func LessThan(_ numberA: String,_ numberB: String)->Bool{
        return !BiggerThan(numberA, numberB) && numberA != numberB
    }
    
    //Mayor que
    func BiggerThan(_ numberA: String,_ numberB: String)->Bool{
        var numberA=numberA
        var numberB=numberB
        
        if numberA == "" || numberA == " " {
        return false
        }
 
        if numberB == ""{
        return true
        }
 
        
        numberA=numberA.replacingOccurrences(of: "inf", with: "0").replacingOccurrences(of: "nan", with: "0").replacingOccurrences(of: "NaN", with: "0")
        
        numberB=numberB.replacingOccurrences(of: "inf", with: "0").replacingOccurrences(of: "nan", with: "0").replacingOccurrences(of: "NaN", with: "0")
        let bandminus = numberA.contains("-") && numberB.contains("-")
        if numberA.contains("-") && !numberB.contains("-"){
            return false
        }
        
        if !numberA.contains("-") && numberB.contains("-"){
            return true
        }
        
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")
        
        if numberA == numberB {
            return false
        }
        
        if !numberA.contains("."){
            numberA+=".0"
        }
        if !numberB.contains("."){
            numberB+=".0"
        }
        
        if numberA.components(separatedBy: ".")[0]==""{
            numberA="0"+numberA
        }
        
        if numberB.components(separatedBy: ".")[0]==""{
            numberB="0"+numberB
        }
        
        var countA=numberA.components(separatedBy: ".")[1].characters.count
        var countB=numberB.components(separatedBy: ".")[1].characters.count
        var dif = 0
        var i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA+="0"
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
                numberB+="0"
                i+=1
            }
        }
        
        countA=numberA.components(separatedBy: ".")[0].characters.count
        countB=numberB.components(separatedBy: ".")[0].characters.count
         dif = 0
         i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA="0"+numberA
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
               numberB="0"+numberB
                i+=1
            }
        }
        
      //  numberA=numberA.replacingOccurrences(of: ".", with: "")
      //  numberB=numberB.replacingOccurrences(of: ".", with: "")
        var StackA=Array(numberA.characters)
        var StackB=Array(numberB.characters)
        
        if StackB.count > StackA.count{
            let auxS=StackA
            StackA=StackB
            StackB=auxS
        }
        
        for n1 in StackA {
    
            if 0 < StackB.count{
            if String(n1) != "." {
                
                let a = Int(String(n1))!
                let b = Int(String(StackB.first!))!
               
                if  a > b {
               
                    return !bandminus
                    
                }else if a != b{
                
                    return bandminus

                }
                
                
            }
                StackB.removeFirst()
            }
        }
        
        return false
    }
    
    func EvaluateFrac(_ Str: String)->String{
        var numbers = ""
        var numbersP = Array<String>()
        var simbols = Array<String>()
        var Result = ""
        var Precode = unichar(0)
        var codes=Array(Str.characters)
        
        while !codes.isEmpty {
            let char = (String(codes.removeFirst()) as NSString)
            let uniChar = char.character(at: codes.startIndex)
            
            //si es numero
            if (uniChar > 47 && uniChar < 58 ) || uniChar == 46 {
                
                numbers+=String(char)
                
            }else {
                if isNumber(numbers)   {
                    numbersP.append(numbers)
                    
                    if uniChar != 40 && uniChar != 41{
                        simbols.append(String(char))
                    }
                    numbers=""
                }else if uniChar == 45{
                    if (Precode > 38 && Precode<46 || Precode==47||Precode==183||Precode==0||Precode==247) && Precode != 44 {
                        simbols.append(String(char))
                        
                    }else{
                        
                        numbers+=String(char)
                        
                    }
                    
                }else if uniChar != 40 && uniChar != 41{
                    
                    simbols.append(String(char))
                    
                }
                
            }
            Precode=uniChar;
        }
        
        if isNumber(numbers){
            
            numbersP.append(numbers)
            
        }
        
       
        if numbersP.count == 3 {
            if simbols.first! == "-" && simbols[1] != "/" {
                numbersP[0]=simbols.removeFirst()+numbersP[0]
            }
            
            if simbols.count == 3 {
                
                if ((simbols[1] == "*" || simbols[1] == "÷" ) && simbols[2] == "-"){
                    
                    numbersP[2] = simbols.remove(at: 2)+numbersP[2]
                    
                }
            }
            
            if simbols.count > 0 {
                if ((simbols[0] == "*" || simbols[0] == "÷" ) && simbols[1] == "-"){
                    
                    numbersP[2] = simbols.remove(at: 1)+numbersP[2]
                    
                }
            }
            
            
            
            if  simbols.first == "/"{
                if simbols[1] != "÷" {
                    if simbols[1] == "*" {
                        Result=forstr(numbersP[0],numbersP[2])+"/"+numbersP[1]
                    }else if simbols[1] == "-"{
                        
                    Result=minusstr(numbersP[0],forstr(numbersP[2],numbersP[1]))+"/"+numbersP[1]
                        
                    }else{
                    Result=plusstr(numbersP[0],forstr(numbersP[2],numbersP[1]))+"/"+numbersP[1]
                    }
                    
                    
                }else if BiggerThan(absstr(numbersP[2]), "0")   {
                    let mcd = MCD(numbersP[0], numbersP[2])
                    
                    if LessThan(mcd, "2"){
                        Result=numbersP[0]+"/"+forstr(numbersP[1],numbersP[2])
                    }else{
                        let mcd = MCD(numbersP[0], numbersP[2])
                        
                        Result=dividestr(numbersP[0],mcd,128)+"/"+forstr(numbersP[1],dividestr(numbersP[2],mcd,128))
                    }
                    
                }/* else{
                    Steps=Steps.replacingOccurrences(of: "=", with: "")
                    
                }*/
                
            }
            else if simbols.first == "+" {
                Result=plusstr(forstr(numbersP[2],numbersP[0]),numbersP[1])+"/"+numbersP[2]
            }
            else if simbols.first == "-" {
                Result=minusstr(forstr(numbersP[2],numbersP[0]),numbersP[1])+"/"+numbersP[2]
            }
            else if simbols.first == "÷" {
                let mcd = MCD(numbersP[1], numbersP[0])
                
                if LessThan(mcd, "2"){
                    
            Result=forstr(numbersP[0],numbersP[2])+"/"+numbersP[1]
                    
                }else{
                   // let mcd = MCD(numbersP[0], numbersP[1])
                    Result=forstr(dividestr(numbersP[0], mcd, 128),numbersP[2])+"/"+dividestr(numbersP[1], mcd,128)
                }
                
            }else if simbols.first == "*" {
                Result=forstr(numbersP[0], numbersP[1])+"/"+numbersP[2]
            }
            
            
            
        }
        else if numbersP[0] != "0"{
            if simbols.count > 2 && ( (simbols[2] == "*" || simbols[2] == "÷") && simbols[3] == "-"){
                
                numbersP[2] = simbols.remove(at: 3)+numbersP[2]
                
            }
            if simbols.count > 2{
                if ((simbols[1] == "*" || simbols[1] == "÷") && simbols[2] == "-"){
                    
                    numbersP[2] = simbols.remove(at: 2)+numbersP[2]
                    
                }
            }
            if simbols.first! == "-"{
                numbersP[0] = simbols.removeFirst()+numbersP[0]
            }
            
            if simbols.count > 1 && numbersP.count > 3 {
                if (simbols[1] == "+" || simbols[1] == "-"){
                    
                    if numbersP[1] == numbersP[3] {
                        
                        if simbols[1]=="-"{
                            let minustr=minusstr(numbersP[0], numbersP[2])
                            let mcd = MCD(minustr, numbersP[3])
                            Result=minustr+"/"+numbersP[3]
                            
                            if BiggerThan(mcd, "1"){
                                Result=dividestr(minustr,mcd,128)+"/"+dividestr(numbersP[3], mcd, 128)
                            }
                        
                        }
                        else if simbols[1]=="+"{
                            let plustr=plusstr(numbersP[0], numbersP[2])
                            let mcd = MCD(plustr, numbersP[3])
                            Result=plustr+"/"+numbersP[3]
                            
                            if BiggerThan(mcd, "1"){
                            Result=dividestr(plustr,mcd,128)+"/"+dividestr(numbersP[3], mcd, 128)
                            }
                        }
                    }else{
                        var a=forstr(numbersP[0], numbersP[3])
                        let b=forstr(numbersP[1], numbersP[2])
                        let c=forstr(numbersP[1], numbersP[3])
                
                        if simbols[1] == "+" {
                            a=plusstr(a,b)
                            let mcd = MCD(a, c)
                            Result=a+"/"+c
                            if BiggerThan(mcd, "1") {
                            
                            Result=dividestr(a,mcd,128)+"/"+dividestr(c, mcd, 128)
                            }
                            
                        }else{
                            a=minusstr(a, b)
                            let mcd = MCD(a, c)
                            Result=a+"/"+c
                            if BiggerThan(mcd, "1") {
                                
                                Result=dividestr(a,mcd,128)+"/"+dividestr(c, mcd, 128)
                            }
                        }
                    }
                    
                }
                else if simbols[1] == "*"{
                    let a=forstr(numbersP[0], numbersP[2])
                    let b=forstr(numbersP[1], numbersP[3])
                    let mcd=MCD(a, b)
                    Result=a+"/"+b
                    if BiggerThan(mcd, "1") {
                        Result=dividestr(a,mcd,128)+"/"+dividestr(b,mcd,128)
                    }
                }
                else if simbols[1] == "÷" {
                    let a=forstr(numbersP[0], numbersP[3])
                    let b=forstr(numbersP[1], numbersP[2])
                    let mcd=MCD(a, b)
                    
                    Result=a+"/"+b
                    if BiggerThan(mcd, "1"){
                        
                        Result=dividestr(a,mcd,128)+"/"+dividestr(b,mcd,128)
                        
                    }
                }
                
            }
            
        }
        
        return Result
    
    }
    

    func dividestr(_ numberA: String,_ numberB: String,_ LimitDigits: Int)->String{
        var numberA=cleanR(numberA)
        var numberB=cleanR(numberB)
        var bandminus = false
        var banddecimal = false
        var countDot = 0
        var Result=""
        
        
        if numberB == "1"{
        return numberA
        }
        
        if numberA.contains("-") && !numberB.contains("-"){
            bandminus=true
        }
        
        if numberB.contains("-") && !numberA.contains("-"){
            bandminus=true
        }
        
        
        if numberA == "0" && numberB == "0"{
        return "nan"
        }
        
        if numberA == "0" {
            return "0"
        }
        
        if numberB == "0" {
            return "inf"
        }
        
        if numberA.contains("."){
        let partDecimal = numberA.components(separatedBy: ".")[1]
            
            countDot = -partDecimal.characters.count
        }
        
        if numberB.contains("."){
            
            countDot+=numberB.components(separatedBy: ".")[1].characters.count
        }
        
        
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")
        if BiggerThan(numberA, numberB) || BiggerThan(numberB, numberA){
            let aux=numberA
            numberA=numberB
            numberB=aux
        }
        
        banddecimal = numberA.contains(".") || numberB.contains(".")
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
        
        numberA=cleanR(numberA)
        numberB=cleanR(numberB)
        
        var StackB=Array(numberB.characters)
        var residuos=""
        var forStr=""
        var sum=""
        var digitCount = 0
        var countB=0
        var baux=""
        let borg=numberB
        //Optimizar, que no es más que disminuir ciclos.
        numberB=""
        while (countB<StackB.count)&&BiggerThan(numberA, numberB) {
            numberB+=String(StackB[countB])
            countB+=1
        }
        if numberB == ""{
            numberB=borg
        }
     
        
        
        if countB==StackB.count{
            
            
            
            while residuos != "0" && digitCount < LimitDigits {
                
                baux=residuos+numberB
                    if LessThan(baux, numberA){
                        baux+="0"
                        while LessThan(baux, numberA){
                            baux+="0"
                        Result+="0"
                        digitCount+=1
                        }
                        banddecimal=true
                  //   countDot += 1
                    }else{
                     countDot += 1
               // banddecimal=true
                }
                
                if baux != ""{
                    numberB=baux
                }
        
                
                
                if numberB == numberA{
                    Result+="1"
                    residuos="0"
                }else {
                forStr=forstr(numberA, numberA)
                    
                    if LessThan(forStr, numberB){
                        sum=plusstr(numberA,numberA)
                        forStr=forstr(sum,numberA)
                        
                        while LessThan(forStr, numberB){
                            sum=plusstr(sum, numberA)
                            forStr=forstr(sum,numberA)
                            
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, numberA)
                            forStr=forstr(sum, numberA)
                            
                            while BiggerThan(forStr, numberB) {
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                                
                                
                            }
                            
                            while LessThan(forStr, numberB){
                                sum=plusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            
                            
                            while BiggerThan(forStr, numberB){
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
 
                            residuos=minusstr(numberB, forStr)
                            
                        }
                        
                    }else{
                    sum="0"
                    forStr="0"
                    while LessThan(forStr, numberB) {
                        sum=plusstr(sum, "1")
                        forStr=forstr(sum, numberA)
                    }
                    
                    if forStr == numberB{
                        residuos="0"
                        
                    }else{
                        sum=minusstr(sum, "1")
                        forStr=forstr(sum, numberA)
                        residuos=minusstr(numberB, forStr)
                        
                    }
                    }
                    
                    Result+=sum
                    
                    
                    
                    
                }
                
                numberB=""
                digitCount+=1
                
          
            
            }
            
        
        
        }
        else{
            
            while  digitCount < LimitDigits || countB<StackB.count{
                numberB=cleanR(numberB)
                if numberB == numberA{
                    
                    Result+="1"
                    residuos="0"
                    
                }
                else {
                    forStr=forstr(numberA, numberA)
                    
                    if LessThan(forStr, numberB){
                        sum=plusstr(numberA,numberA)
                        forStr=forstr(sum,numberA)
                        
                        while LessThan(forStr, numberB){
                            sum=plusstr(sum, numberA)
                            forStr=forstr(sum,numberA)
                            
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, numberA)
                            forStr=forstr(sum, numberA)
                            
                            while BiggerThan(forStr, numberB) {
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                                
                                
                            }
                            
                            while LessThan(forStr, numberB){
                                sum=plusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            
                            
                            while BiggerThan(forStr, numberB){
                                sum=minusstr(sum, "1")
                                forStr=forstr(sum, numberA)
                            }
                            residuos=minusstr(numberB, forStr)
                           
                        }
                    
                    
                    }else{
                        sum="0"
                        forStr="0"
                        while LessThan(forStr, numberB) {
                            sum=plusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                        }
                        
                        if forStr == numberB{
                            residuos="0"
                            
                        }else{
                            sum=minusstr(sum, "1")
                            forStr=forstr(sum, numberA)
                           
                            residuos=minusstr(cleanR(numberB), forStr)
                            
                        
                        }
                    }
                    
                    
                    
                    Result+=sum
                    
                    
                }
   
                if countB==StackB.count{
                    if cleanR(baux) == "0"{
                    countDot+=1
                    countDot+=(Result+"0").characters.count
                    }else{
                    countDot+=Result.characters.count
                        
                    }
                }
 
                numberB=""
                if residuos == "0" && countB >= StackB.count {
                    countB+=1
                    break
                }
                
                if countB >= StackB.count{
                    
                    baux=residuos+numberB
                    baux=cleanR(baux)
                    
                    if LessThan(baux, numberA){
                        baux+="0"
                        
                        
                        while LessThan(baux, numberA){
                            baux+="0"
                            Result+="0"
                            digitCount+=1
                        }
                        
                        
                        banddecimal=true
                    }
 
                }
                else {
                    baux=residuos+numberB+String(StackB[countB])
                    baux=cleanR(baux)
                }
                
                
                
                
                if LessThan(baux, numberA) && countB<(StackB.count-1) {
                 
                    if baux=="0"{ //yo creo que se puede simplificar mas
                    baux=""
                    }
                    
                    while LessThan(baux, numberA) && countB<(StackB.count-1) {
                      
                    countB+=1
                    baux+=String(StackB[countB])
                    Result+="0"
                        
                    }
                    
                }
                
                if baux != ""{
                    numberB=baux
                }else{
                    numberB=String(StackB[countB])
                }
                
                countB+=1
                
                
                digitCount+=1
                
                
            
            }
            
            if countB  <= StackB.count{
                if cleanR(baux) == "0"{
                    countDot+=1
                    countDot+=(Result+"0").characters.count
                }else{
                    countDot+=Result.characters.count
                }
            }
            
        }
        
        
        if banddecimal {
         
            if countDot > 0{
            var a = Array(Result.characters)
                if a.count <= countDot{
                var i = countDot-a.count
                    while i>0 {
                        a.append("0")
                    i -= 1
                    }
                }else{
                a.insert(".", at: countDot)
            }
            Result=String(a)
            }else{
            var i = countDot
                while i < 0{
                    Result="0"+Result
                    i+=1
                }
                
                Result="0."+Result
            }
         
        }
     
        if bandminus {
         Result="-"+Result
        }
        return cleanR(Result)
    }
    
    func forstr(_ numberA: String,_ numberB: String)->String{
        var numberA=numberA
        var numberB=numberB
        var bandminus = false
        let banddecimal = numberA.contains(".") || numberB.contains(".")
        var countDot = 0
        var Result=""
        var carry=0
        
        if numberA.contains("-") && !numberB.contains("-"){
            bandminus=true
        }
        
        if numberB.contains("-") && !numberA.contains("-"){
            bandminus=true
        }
        
        if numberA.contains("."){
            countDot+=numberA.components(separatedBy: ".")[1].characters.count
        }
        
        if numberB.contains("."){
           countDot+=numberB.components(separatedBy: ".")[1].characters.count
        }
        
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")
        
        if LessThan(numberA, numberB){
            let aux=numberA
            numberA=numberB
            numberB=aux
           // bandminus=true
        }
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
       
        var StackA=Array(numberA.characters)
        var StackB=Array(numberB.characters)
        StackB=StackB.reversed()
        StackA=StackA.reversed()
        
        
        var StackPlus=Array<String>()
       var countA=0
       var countB=0
       
        for n1 in StackB {
         StackPlus.append("")
            for n2 in StackA{
                let x = String(Int(String(n1))!*Int(String(n2))!+carry)
                
                if countA < (StackA.count-1) && x.characters.count > 1{
            
                carry=Int(String(Array(x.characters)[0]))!
                    
            StackPlus[StackPlus.count-1]=String(Array(x.characters)[1])+StackPlus[StackPlus.count-1]
                    
                }else{
                    StackPlus[StackPlus.count-1]=x+StackPlus[StackPlus.count-1]
                    carry=0
                }
            countA+=1
            }
            
            if StackB.count > 1{
                
                
                if countB == 0{
                    var auxStack = Array(StackPlus.removeFirst().characters)
                    Result=String(auxStack.removeLast())+Result
                    
                    StackPlus.append(String(auxStack))
                }else{
                    
                    var auxStack = Array(cleanR(plusstr(StackPlus.removeFirst(), StackPlus.removeFirst())).characters)
                    
                    if countB < (StackB.count-1){
                    Result=String(auxStack.removeLast())+Result
                    }
                    
                    StackPlus.append(String(auxStack))
                }
            }
           
            
            countA=0
            countB+=1
        }
        if StackPlus.count > 0 {
        Result=String(Array(StackPlus.first!.characters))+Result
        }else{
            Result="00"
        }
        
        if banddecimal {
            var arr=Array(Result.characters)
        
            countDot=arr.count-countDot
            if countDot < 0{
                countDot *= -1
                while countDot > 0 {
                    arr.insert("0", at: 0)
                    countDot -= 1
                }
                arr.insert(".", at: 0)
            }else{
                arr.insert(".", at: countDot)
            }
            
            
            Result=String(arr)
        }
        
      
        if bandminus{
            Result="-"+Result
        }
        return cleanR(Result)
    }
    
    func Double(_ str: String)->String{
    var arr=Array(str.characters)
    var bandminus = false
    
    if str == "." || str == ""{
        return "0"
        }
    if arr.first! == "-"{
        arr.removeFirst()
        bandminus=true
        }
   // var str=String(arr)
       // if str.contains("."){
    if arr.first! == "."{
     //str="0"+str
     arr.insert("0", at: 0)
        }
    
        if arr.last! == "."{
            arr.removeLast()
        }
      /*  }else{
            str+=".0"
        }
        */
        if bandminus{
            arr.insert("-", at: 0)
        }
        return String(arr)
    }
    
    func lengthCount(_ str: String)->Int{
        var count = 0
        var arr: Array! = Array(str.characters)
        if arr != nil {
        while arr.first! != "."  {
            arr.removeFirst()
            count+=1
            }
            
        }
        return count
    }
    
    func minusstr(_ numberA: String,_ numberB: String)->String{
        var numberA=numberA
        var numberB=numberB
        var bandminus = false
        var Result=""
        var count=0
        var carry=0
        
        if numberA == numberB {
            return "0"
        }
        
        if numberA.contains("-")&&numberB.contains("-"){
        return plusstr(numberB.replacingOccurrences(of: "-", with: ""), numberA)
        }
        
        if numberA.contains("-"){
         return "-"+plusstr(numberA.replacingOccurrences(of: "-", with: ""), numberB)
        }
        
        if numberB.contains("-"){
            return plusstr(numberA, numberB.replacingOccurrences(of: "-", with: ""))
        }
        
        if LessThan(numberA, numberB){
        bandminus=true
        }
        
        if LessThan(numberB, numberA){
            let aux=numberA
            numberA=numberB
            numberB=aux
        }
        
        if !numberA.contains("."){
            numberA+=".0"
        }
        
        if !numberB.contains("."){
            numberB+=".0"
        }
        var countA=numberA.components(separatedBy: ".")[1].characters.count
        var countB=numberB.components(separatedBy: ".")[1].characters.count
        var dif = 0
        var i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA+="0"
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
                numberB+="0"
                i+=1
            }
        }
        
        
         countA=numberA.components(separatedBy: ".")[0].characters.count
         countB=numberB.components(separatedBy: ".")[0].characters.count
        dif = 0
        i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA="0"+numberA
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
                numberB="0"+numberB
                i+=1
            }
        }
        var countDot=lengthCount(numberA)
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
        var StackA=Array(numberA.characters)
        var StackB=Array(numberB.characters)
        StackB=StackB.reversed()
        StackA=StackA.reversed()
        
        
        while count < StackA.count {
           if 0 < StackB.count /*&& String(StackA[count]) != "." && String(StackB.first!) != "."*/ {
            let a = Int(String(StackA[count]))!
            var b = Int(String(StackB.removeFirst()))!
            b+=carry
            if b < a{
                    b+=10
                    let rest = b-a
                carry = -1
                    Result=String(rest)+Result
                
            }else{
                    let rest = b-a
                    
                    Result=String(rest)+Result
                    carry=0
                }
                
            }else{
             /*   if String(StackA[count]) == "." {
                    Result=String(StackB.removeFirst())+Result
                }else{
             */
                    Result=String(Int(String(StackB.first!))!+carry)+Result
                    carry=0
             
           // }
                
            }
           
            
            count+=1
        }
        
        while !StackB.isEmpty {
              Result=String(StackB.removeFirst())+Result
        }
        
        var arr = Array(Result.characters)
        arr.insert(".", at: countDot)
        Result = String(arr)
        
        if bandminus{
            Result="-"+Result
        }
        
        return cleanR(Result)
    }
    
    func plusstr(_ numberA: String,_ numberB: String)->String{
        var numberA=numberA
        var numberB=numberB
        if numberA.contains("-") && !numberB.contains("-"){
            return minusstr(numberB, numberA.replacingOccurrences(of: "-", with: ""))
        }
        if numberB.contains("-") && !numberA.contains("-"){
            return minusstr(numberA, numberB.replacingOccurrences(of: "-", with: ""))
        }
        let bandminus = numberB.contains("-") && numberA.contains("-")
        
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")
        if !numberA.contains("."){
            numberA+=".0"
        }
        
        if !numberB.contains("."){
            numberB+=".0"
        }
        
        var countA=numberA.components(separatedBy: ".")[1].characters.count
        var countB=numberB.components(separatedBy: ".")[1].characters.count
        var dif = 0
        var i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA+="0"
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
                numberB+="0"
                i+=1
            }
        }
        
        countA=numberA.components(separatedBy: ".")[0].characters.count
        countB=numberB.components(separatedBy: ".")[0].characters.count
        dif = 0
        i=0
        
        if countA < countB{
            dif = countB-countA
            while i<dif {
                numberA="0"+numberA
                i+=1
            }
        }else{
            dif = countA-countB
            while i<dif {
                numberB="0"+numberB
                i+=1
            }
        }
        var countDot=lengthCount(numberA)
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
        var StackA=Array(numberA.characters)
        var StackB=Array(numberB.characters)
        StackB=StackB.reversed()
        StackA=StackA.reversed()
        var Result=""
        var count=0
        var carry=0
       
        
        while count < StackA.count {
            if 0 < StackB.count /*&& String(StackA[count]) != "." && String(StackB.first!) != "."*/{
                let a = Int(String(StackA[count]))!
                let b = Int(String(StackB.removeFirst()))!+carry
                var sum = a+b
                
                if sum>9 {
                    
                    sum-=10
                    
                    carry = 1
                    Result=String(sum)+Result
                    StackA.append(Array(String("0").characters)[0])
                    StackB.append(Array(String("0").characters)[0])
                    countDot+=1
         
                }else{
                    
                    Result=String(sum)+Result
                    carry=0
                }
                
            }else{
             /*   if String(StackA[count]) == "." {
                    Result=String(StackB.removeFirst())+Result
                }else{
               */
                    Result=String(Int(String(StackB.first!))!+carry)+Result
                    carry=0
                
             //   }
                
            }
            
            count+=1
        
        }
        
        var arr = Array(Result.characters)
        arr.insert(".", at: countDot)
        Result = String(arr)
        
        if bandminus {
            Result="-"+Result
        }
        return cleanR(Result)
        
    }
}
