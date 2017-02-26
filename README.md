#                         ---> THE Millennial Genius <---
# MathString Vol. 1
A library with functions that compute Strings, to the Digital Style.

# Programming Language
Swift 3

# Methods
 1.- cleanR(n:String)->String:
 
         This method clean a "number" in form of String, if is anomalous String.
  
 2.- isNumber(n:String)->Bool:
 
         Compare byte per byte of the String to check if it's "number".
  
 3.- isSimbol(n:String)->Bool:
 
         Check if it's "simbol".
  
 4.- absstr(n:String)->String: 
 
         If n contains in first char one negative simbol ('-') or charASCII==45, remove't and then return n.
  
 5.- ShaveStr(n:String)->String:
 
        Remove the overflow zeros produces in the "Decimal Number" before and after of the dot.
  
 6.- addZeros(n:String)->String:
 
        Method dependent of another method that transform the "Decimal" to "fraction".
  
 7.- powstr(n:String)->String:
 
       Returns the raised base to the exponent.
  
 8.- isFrac(n:String)->Bool:
 
       Compare String to check if it's a "fraction".
  
 9.- residuo(nA:String,nB:String)->String: 
 
       Method COMPLEX and dependent, return the last residue of the division for two numbers, this done for find the MCD for another methods.
  
 10.- MCD(nA:String,nB:String)->String:
 
       Return the greatest common divisor.
  
 11.- BiggerThan(nA:String,nB:String)->Bool:
  
       LessThan(nA:String,nB:String)->Bool; Return the boolean band produced after the two numbers comparation.
  
 12.- EvaluateFrac(n:String)->String:
 
       Method that return the process step by step on form of String.
  
 13.- forstr(nA:String, nB:String)->String:
  
 14.- minusstr(nA:String, nB:String)->String:
  
 15.- plusstr(nA:String, nB:String)->String:
  
 16.-dividestr(nA:String, nB:String)->String: 
  
       Fundamental methods of this Library, since analize the String byte per byte for later evaluate the two "numbers" and return the "result". 
  
  17.- Double(n:String)->String: 
  
       Transform String(int) to String(Double).
  
  18.- lengthCount(n:String)->String: 
  
       Algorithm that calculates the count of the dot, method dependent of Foundamental methods and this is required for these.
