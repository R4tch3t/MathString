//
//  MathString.swift
//  Calculus Lite
//
//  Created by Victor Manuel Santamaria on 1/9/17.
//  Copyright © 2017 Victor Manuel Santamaria. All rights reserved.
//

import Cocoa
import Foundation


class MathString: NSObject {
    
    func cleanR(_ str: String)->String{
        var aux="", rstr=".0"
        var arrStr: Array! = Array(str)
        var str = str
        var bandminus = false
        var i=0, j=0, k=0

        if str == "" || str == " " || str == "0" || str == "00" || str == "NaN" || str == "nan" || str == "inf"
        {
            return "0"
        }

        if arrStr != nil {
            if arrStr.first?.description == "-"{
                bandminus=true
            }
            if arrStr.last?.description == "."{
                arrStr.removeLast()
            }
            if arrStr.count == 1 && arrStr.first?.description == "0"{
                return "0"
            }
            
            if arrStr.first?.description == "-" {
                str=String(arrStr.removeFirst())
            }
            
            var countLeft=0
            if str.contains("."){

                countLeft=str.components(separatedBy: ".")[0].count
               
                while(arrStr.count>0&&arrStr.first?.description == "0"&&countLeft>1){
                    arrStr.removeFirst()
                    countLeft-=1
                }
                
                countLeft=str.components(separatedBy: ".")[1].count

                while(arrStr.count>0&&arrStr.last?.description == "0"&&countLeft>1){
                    arrStr.removeLast()
                    countLeft-=1
                }
                
            }else{
            
                while(arrStr.count>1&&arrStr.first?.description == "0"){
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

        if(String(str.first!)=="."){
            str.insert("0", at: str.startIndex)
        }
        
        if bandminus {
            str="-"+str
        }
        return str
    }
    
    func isNumber(_ str: String)->Bool{

        if str.contains("e") || str.contains("oo") {
            return true
        }
        return !isSimbol(str)
    }
    
    func isSimbol(_ str: String)->Bool{
        return str == "" || str.contains(" ") || str.contains("+") || str == "-" || str.contains("*") || str.contains("/") || str.contains("c") || str.contains("÷") || (str.contains("(") && str.count==2 && str.contains(")")) || str.contains("quad")
    }

    func lnStr(_ number: String)->String{
        let number=Double(number) ?? 0.0
        return String(log(number))
    }

    func log10Str(_ number: String)->String{
        let number=Double(number) ?? 0.0
        return String(log10(number))
    }

    func log2Str(_ number: String)->String{
        let number=Double(number) ?? 0.0
        return String(log2(number))
    }

    func cosStr(_ number: String,_ degrad: Int)->String{
        var number=Double(number) ?? 0.0

        if degrad==1{
          number=(number / Double.pi) * 180
        }

        number=cos(number * Double.pi / 180)

        return String(number)
    }

    func senStr(_ number: String,_ degrad: Int)->String{
        var number=Double(number) ?? 0.0

        if degrad==1 {
            number=number / Double.pi * 180
        }

        number=sin(number * Double.pi / 180)

        return String(number)
    }

    func tanStr(_ number: String,_ degrad: Int)->String{
        var number=Double(number) ?? 0.0

        if degrad==1 {
            number=number / Double.pi * 180
        }

        number=tan(number * Double.pi / 180)
        return String(number)
    }
    
    func absstr(_ str: String)->String{
        if str == "" {
            return str
        }

        var arr=Array(str)

        if arr.first! == "-" {
            arr.removeFirst()
        }

        return String(arr)
    }

    func moreDStr(_ str: String)->String{
        var str=str
        if str.contains("e") {
            str=str.replacingOccurrences(of: "e", with: "")
            var zeros = ""

            while str.last! != "+" && str.last! != "-" {
                zeros = String(str.removeLast()) + zeros
            }

            let arr = str.split(separator: ".")
            str=str.replacingOccurrences(of: ".", with: "")
            if str.removeLast() == "+" {
                var c = (Int(zeros) ?? 0) - arr[1].count
                while c > 0  {
                    str+="0"
                    c-=1
                }
            } else {
                var c = (Int(zeros) ?? 0) - 1
                while c > 0  {
                    str="0"+str
                    c-=1
                }
                str="0."+str
            }

        }
        return str
    }

    //"Rasurar" cadena
    func ShaveStr(_ str: String,_ digits: Int)->String{
       var str=str

        str = moreDStr(str)

        if str.contains("."){
            
            var StackStr=Array(str.components(separatedBy: "."))
            var Stack1 = Array(StackStr[1].map{String($0)})

          //  str=StackStr[0]+"."
            if Stack1.count > digits{
         
                if (Int(Stack1[digits]) ?? 0) > 4{
                    if (Int(Stack1[digits-1]) ?? 0) == 9{
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
                            let n = plusstr(Stack1[i], "1")
                            Stack1[i]=n
                        }
                    }else{
                        let n = plusstr(Stack1[i], "1")
                        Stack1[i]=n
                    }
                    
                }else{
                    let n = plusstr(Stack1[digits-1],"1")
                    Stack1[digits-1]=n
                }
            }
            
            str=StackStr[0]+"."
            var i = 0
            while i < digits {
                str+=Stack1[i]
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
    
    func powStr(_ numberA: String,_ numberB: String)->String{
        let a=Double(numberA) ?? 0.0
        let b=Double(numberB) ?? 0.0
        var str = String(pow(a,b))
        str=str.replacingOccurrences(of: "inf", with: "oo")
        return str
    }

    func sqrtStr(_ numberA: String,_ numberB: String)->String{
        let a = Double(numberA) ?? 0.0
        let b = 1/(Double(numberB) ?? 2.0)
        return String(pow(a,b))
        /*
         Newton-Rhapson
         // number Mode ( f a s t )
        let a = Double(numberA) ?? 0.0
        let b = Double(numberB) ?? 0.0
        var n = 5.0
        var x = 5.0
        var x2 = 0.0
        let powI = b-1.0
        if b == 1 || a == 1 {
            return String(a)
        }

        while n > 0.000005 {
            x2 = x - ((pow(x,b)-a)/(b*(pow(x,powI))))
            n=x-x2
            x=x2
        }

        return String(x)

         //String mode( l a z y )
        let a = numberA
        let b = numberB
        var n = "5"
        var x = "5"
        var x2 = "5"
        let pow = minusstr(b, "1")
        if b == "1" || a == "1" {
            return a
        }

        while n != "0" {
            x2 = minusstr(x, dividestr(minusstr(powStr(x, b), a), forstr(b, powStr(x, pow)), 8))
            n = minusstr(x, x2)
            x=x2
            n = ShaveStr(n, 8)
            print("x: "+x)
            print("n: "+n)
        }

        return x*/
    }
    
    func isFrac(_ Str: String)->Bool{
        return Str.contains("/") || isNumber(Str)
    }
    
    //a%b
    func residuo(_ numberA: String,_ numberB: String)->String{
        var divA=numberA
        var divB=numberB
    
        divA=cleanR(divA)
        divB=cleanR(divB)
        
        if divA=="1" && divB=="1"{
            return "0"
        }
        
        if divA=="1" || divB=="1"{
            return "1"
        }

        divA=divA.replacingOccurrences(of: "-", with: "")
        divB=divB.replacingOccurrences(of: "-", with: "")
        
        if LessThan(divA, divB){
            return divA
        }
        
        if divB == "1"{
            return numberA
        }
        
        
        if divA == "0" && numberB == "0"{
            return "nan"
        }
        
        if divA == "0" {
            return "0"
        }
        
        if divB == "0" {
            return "inf"
        }
        
        divA=divA.replacingOccurrences(of: ".", with: "")
        divB=divB.replacingOccurrences(of: ".", with: "")
        divA=cleanR(divA)
        divB=cleanR(divB)

        var StackA=Array(divA)
        var residuos=""

        //div process
        if(StackA.count>0){
            //a/b, divA empty, while b>a take first element to the array and put into divA
            divA=""

        }

        //a/b, subtract a to b, a-b, who many a contains b redundant
        while(!StackA.isEmpty){

            while(BiggerThan(divB, divA) && !StackA.isEmpty){
                divA+=StackA.removeFirst().description
            }
            while(BiggerThan(divA, divB)){
                divA=minusstr(divA,divB)
            }

            if divA==divB {
                residuos="0"
                divA=""
            }else{
                residuos=divA
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
 
        if numberB == "" {
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
        
        var countA=numberA.components(separatedBy: ".")[1].count
        var countB=numberB.components(separatedBy: ".")[1].count
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
        
        countA=numberA.components(separatedBy: ".")[0].count
        countB=numberB.components(separatedBy: ".")[0].count
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

        var StackA=Array(numberA)
        var StackB=Array(numberB)
        
        if StackB.count > StackA.count{
            let auxS=StackA
            StackA=StackB
            StackB=auxS
        }
        
        for n1 in StackA {
    
            if 0 < StackB.count{
            if String(n1) != "." {
                
                let a = Int(String(n1)) ?? 0
                let b = Int(String(StackB.first!)) ?? 0
               
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
        var codes=Array(Str)

        while !codes.isEmpty {
            let char = (String(codes.removeFirst()) as NSString)
            let uniChar = char.character(at: codes.startIndex)
            
            //si es numero
            if (uniChar > 47 && uniChar < 58 ) || uniChar == 46 {
                
                numbers+=String(char)
                
            }else {
                if isNumber(numbers) {
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

            if simbols.count==4{

                if simbols[0] == "-" && simbols[2] == "-" {
                    simbols.removeFirst()
                    simbols.remove(at: 1)
                }
                
            }


           if  simbols.first == "/"{
                if simbols[1] != "÷" {
                    if simbols[1] == "*" {
                        Result=forstr(numbersP[0],numbersP[2])+"/"+numbersP[1]
                    }else if simbols[1] == "-" {
                        
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
                        Result=dividestr(numbersP[0],mcd,128)
                        Result+="/"+forstr(numbersP[1],dividestr(numbersP[2],mcd,128))
                    }
                    
                }/* else{
                    Steps=Steps.replacingOccurrences(of: "=", with: "")
                    
                }*/
                
            }
            else if simbols.first == "+" {
                Result=plusstr(forstr(numbersP[2],numbersP[0]),numbersP[1])+"/"+numbersP[2]
            }
            else if simbols.first == "-" {
                if simbols.count == 3{
                    let b=forstr(numbersP[1],numbersP[2])
                        numbersP[0]=simbols.first!+numbersP[0]
                    if simbols.last == "-"{
                        Result=minusstr(numbersP[0],b)+"/"+numbersP[1]
                    }else{
                        Result=plusstr(numbersP[0],b)+"/"+numbersP[1]
                    }
                }else{
                    Result=minusstr(forstr(numbersP[2],numbersP[0]),numbersP[1])+"/"+numbersP[2]
                }

            }
            else if simbols.first == "÷" {
                let mcd = MCD(numbersP[1], numbersP[0])
                
                if LessThan(mcd, "2"){
                    
                    Result=forstr(numbersP[0],numbersP[2])+"/"+numbersP[1]
                    
                }else{
                    Result=forstr(dividestr(numbersP[0], mcd, 128),numbersP[2])
                    Result+="/"+dividestr(numbersP[1], mcd,128)
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
        //declare and mov method vars to local vars
        var divA=cleanR(numberA)
        var divB=cleanR(numberB) //a/b
        var bandminus = false
        var countDot = 0
        var Result=""

        if divB == "1"{
            return numberA
        }

        bandminus=(divA.contains("-") && !divB.contains("-"))||(!divA.contains("-") && divB.contains("-"))

        if divA == "0" && divB == "0" {
            return "(NaN) quad Not quad a quad Number"
        }

        if divA == "0" {
            return "0"
        }

        if divB == "0" {
            return "oo"
        }

        if divA.contains("."){
            let partDecimal = divA.components(separatedBy: ".")[1]

            countDot = -partDecimal.count
        }

        if divB.contains("."){
            countDot+=divB.components(separatedBy: ".")[1].count
        }


        divA=divA.replacingOccurrences(of: "-", with: "")
        divB=divB.replacingOccurrences(of: "-", with: "")
        divA=divA.replacingOccurrences(of: ".", with: "")
        divB=divB.replacingOccurrences(of: ".", with: "")
        divA=cleanR(divA)
        divB=cleanR(divB)

        var StackA=Array(divA)
        var residuos=""
        var LimitDigits=LimitDigits
        var mult="0"
        var bandDot=false

        //div process
        if(StackA.count>0){
            //a/b, divA empty, while b>a take first element to the array and put into divA
            divA=""
            if(BiggerThan(divB, divA) && !StackA.isEmpty){
                divA+=StackA.removeFirst().description
                countDot+=1
            }
            while(BiggerThan(divB, divA) && !StackA.isEmpty){
                divA+=StackA.removeFirst().description
            }
            //if stack count == 0, complement with Zeros to div and result, countDot add 1
            if(StackA.isEmpty){
                if(BiggerThan(divB, divA)){
                    bandDot=true
                while(BiggerThan(divB, divA)){
                    divA+="0"
                    countDot-=1
                }
              }
            }
        }

        //a/b, subtract a to b, a-b, who many a contains b redundant
        while(residuos != "0" && LimitDigits>0){

            while(BiggerThan(divA, divB)||divA==divB){
                divA=minusstr(divA,divB)
                mult=plusstr(mult,"1")
            }

            Result+=mult
            if(StackA.count>0){
                if(BiggerThan(divB, divA)){
                    divA+=StackA.removeFirst().description
                    countDot+=1
                }
                while(BiggerThan(divB, divA) && !StackA.isEmpty){
                    divA+=StackA.removeFirst().description
                    Result+="0"
                    countDot+=1
                }

                bandDot=BiggerThan(divB, divA) && StackA.isEmpty
                while(BiggerThan(divB, divA) && StackA.isEmpty){
                    divA+="0"
                    Result+="0"
                }
          }

            mult="0"
            LimitDigits-=1
            divA=cleanR(divA)
            residuos=divA

            if(StackA.count==0){
                if(divA != "0" && BiggerThan(divB, divA)){
                    divA+="0"
                    bandDot=true
                    while(BiggerThan(divB, divA)){
                        divA+="0"
                        Result+="0"
                    }
               }
            }
        }

        //appending dot on the correct position
        if(bandDot){
            if(countDot>0){
                StackA=Array(Result)
                if(StackA.count>countDot){
                    StackA.insert(".", at: countDot)
                }else{
                    countDot-=1
                    while(countDot>0){
                        StackA.append("0")
                        countDot-=1
                    }
                }

                Result=StackA+""
            }else{
                StackA=Array(Result)
                countDot-=1
                while(countDot<0){
                    StackA.insert("0", at: 0)
                    countDot+=1
                }
                StackA.insert(".", at: 1)
                Result=StackA+""
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
            countDot+=numberA.components(separatedBy: ".")[1].count
        }
        
        if numberB.contains("."){
           countDot+=numberB.components(separatedBy: ".")[1].count
        }
        
        numberA=numberA.replacingOccurrences(of: "-", with: "")
        numberB=numberB.replacingOccurrences(of: "-", with: "")

        if numberA == "oo" || numberB == "oo" {
            return "oo"
        }

        if LessThan(numberA, numberB){
            let aux=numberA
            numberA=numberB
            numberB=aux
        }
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
       
        let StackA=Array(numberA.reversed())
        let StackB=Array(numberB.reversed())

        
       var StackPlus=Array<String>()
       var countA=0
       var countB=0
       
        for n1 in StackB {
         StackPlus.append("")
            for n2 in StackA{
                let nI1 = (Int(String(n1)) ?? 0)
                let nI2 = (Int(String(n2)) ?? 0)
                let x = String(nI1*nI2+carry)
                
                if countA < (StackA.count-1) && x.count > 1{
            
                carry=Int(String(Array(x)[0]))!
                    
                StackPlus[StackPlus.count-1]=String(Array(x)[1])+StackPlus[StackPlus.count-1]
                    
                }else{
                    StackPlus[StackPlus.count-1]=x+StackPlus[StackPlus.count-1]
                    carry=0
                }
                countA+=1
            }
            
            if StackB.count > 1{

                if countB == 0{
                    var auxStack = Array(StackPlus.removeFirst())
                    Result=String(auxStack.removeLast())+Result
                    StackPlus.append(String(auxStack))
                }else{
                    
                    var auxStack = Array(cleanR(plusstr(StackPlus.removeFirst(), StackPlus.removeFirst())))
                    
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
        Result=String(StackPlus.first!)+Result
        }else{
            Result="00"
        }
        
        if banddecimal {
            var arr=Array(Result)
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
    
    func DoubleStr(_ str: String)->String{
        var arr=Array(str)
        var bandminus = false

        if str == "." || str == ""{
            return "0"
        }
        if arr.first! == "-"{
            arr.removeFirst()
            bandminus=true
        }
        if arr.first! == "."{
            arr.insert("0", at: 0)
        }

        if arr.last! == "."{
            arr.removeLast()
        }
        if bandminus{
            arr.insert("-", at: 0)
        }
        /*arr.withUnsafeBufferPointer { ptr in
            return String(cString: ptr.baseAddress!)
        }*/
        return String(arr)
    }
    
    func lengthCount(_ str: String)->Int{
        var count = 0
        var arr: Array! = Array(str)

        if arr != nil {

        while arr.first! != "." {
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

        if numberA == "oo" || numberB == "oo" {
            return "oo"
        }
        
        if !numberA.contains("."){
            numberA+=".0"
        }
        
        if !numberB.contains("."){
            numberB+=".0"
        }
        var countA=numberA.components(separatedBy: ".")[1].count
        var countB=numberB.components(separatedBy: ".")[1].count
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

        countA=numberA.components(separatedBy: ".")[0].count
        countB=numberB.components(separatedBy: ".")[0].count
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
        let countDot=lengthCount(numberA)
        
        numberA=numberA.replacingOccurrences(of: ".", with: "")
        numberB=numberB.replacingOccurrences(of: ".", with: "")
        var StackA=Array(numberA)
        var StackB=Array(numberB)
        StackB=StackB.reversed()
        StackA=StackA.reversed()
        
        
        while count < StackA.count {
           if 0 < StackB.count /*&& String(StackA[count]) != "." && String(StackB.first!) != "."*/ {
            let a = Int(String(StackA[count])) ?? 0
            var b = Int(String(StackB.removeFirst())) ?? 0
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
                Result=String(Int(String(StackB.first!))!+carry)+Result
                carry=0
            }

            count+=1
        }
        
        while !StackB.isEmpty {
            Result=String(StackB.removeFirst())+Result
        }
        
        var arr = Array(Result)
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

        if numberA == "oo" || numberB == "oo" {
            return "oo"
        }

        if !numberA.contains("."){
            numberA+=".0"
        }
        
        if !numberB.contains("."){
            numberB+=".0"
        }
        
        var countA=numberA.components(separatedBy: ".")[1].count
        var countB=numberB.components(separatedBy: ".")[1].count
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
        
        countA=numberA.components(separatedBy: ".")[0].count
        countB=numberB.components(separatedBy: ".")[0].count
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
        
        var StackA=Array(numberA.reversed())
        var StackB=Array(numberB.reversed())
        var Result=""
        var count=0
        var carry=0

        while count < StackA.count {
            if 0 < StackB.count {

                let a = Int(StackA[count].description) ?? 0
                let b = (Int(StackB.removeFirst().description) ?? 0)+carry

                var sum = a+b
                if sum>9 {
                    sum-=10
                    carry = 1
                    Result=String(sum)+Result
                    StackA.append("0")
                    StackB.append("0")
                    countDot+=1
         
                }else{
                    Result=String(sum)+Result
                    carry=0
                }
                
            }else{
                Result=String(Int(StackB.first!.description)!+carry)+Result
                    carry=0
            }
            
            count+=1
        }
        
        var arr = Array(Result.map { String($0) })
        arr.insert(".", at: countDot) 
        Result = arr.joined()

        if bandminus {
            Result="-"+Result
        }
        return cleanR(Result)
        
    }
}
