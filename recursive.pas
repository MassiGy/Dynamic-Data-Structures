
Program recursive;



Type container = array [1..4] Of integer;

Var arr , tmp : container;

Function factorial(num : integer): integer;

Begin
  If (num = 1) Then factorial := 1;
  If (num>1) Then factorial := num * factorial(num-1);
End;



Function fib(num : integer): integer;
Begin
  If (num = 0) Then fib := 0;
  If ((num = 1) Or (num = 2)) Then fib := 1;
  If (num > 2) Then fib := fib(num -1) + fib(num -2);
End;


Function squaresSum(num : integer): integer;
Begin
  If (num = 0) Then squaresSum := 0;
  If (num = 1) Then squaresSum := 1;
  If (num > 1) Then squaresSum := num * num + squaresSum(num-1);
End;


Function inverser(text : String; x: integer) : string;
Begin
  If (x = 0 ) Then  inverser := '';
  If (x > 0)  Then inverser := text[x] + inverser(text, x -1);
End;

Function inverseStr(text : String): string;
// in this function we will use the recursive helper methode 

Var num : integer;
  // patters, in this case the recursive stack will be the inverser function
Begin
  // and the helper stack will be the function named inverseStr;
  num := length(text);
  inverseStr := inverser(text, num);
End;


function subStr (text : string; from, till: integer): string;
var i : integer;
begin
    subStr:='';
    for i:=from to till Do
    begin
        subStr:=subStr + text[i];
    end; 
end;



function strfinder(chain, query : string; i,j : integer):integer;
var tmp : string;
begin
  if(chain = '') then strfinder:=-1
  else if(length(chain) < length(query)) then strfinder:=-1
  else
   begin
        tmp:= subStr(chain,i,j);
        if(tmp = query) then strfinder:= i
       else strfinder:= strfinder(chain, query, i+1,j+1);
  end;
end;


function findStr(chain, query : string): integer; // apply the helper methode pattern,
var i,j: integer;
begin
    i:=1;
    j:=length(query);
    findStr:=strfinder(chain,query, i,j);
end;



// Procedure strOccurence(chain, query: string; var resault:integer);
// var i, j : integer;

// Begin
// if(findStr(chain,query) = -1) then break
// else  
//     Begin
//         resault:=resault+1;
//         i:=findStr(chain,query)+ length(query);
//         j:=length(chain);
//         chain:=subStr(chain, i, j);
//         strOccurence(chain,query, resault);
//     end;
 
      
// end;


Function max (x, y : integer): integer;
Begin
  If (x > y ) Then max := x
  Else max := y;
End;


//function findMax (arr : array of integer; index : integer): integer;
//begin
//    if(index > 0) then
//        findMax := max(arr[index], findMax(arr, index -1))
//    else findMax := arr[0];
//end;

Function findMax(arr :container ; index : integer): integer;
Begin
  If (index<length(arr)) Then findMax := max(arr[index], findMax(arr, index+1))
  Else findMax := arr[length(arr)];
End;





Procedure reverse(Var arr  : container ; i,j: integer);

Var tmp  : integer;
Begin
  If (i < j) Then
    Begin
      tmp := arr[i];
      arr[i] := arr[j];
      arr[j] := tmp;
      reverse(arr, i+1, j -1);
    End;
End;

Procedure reverseArray( Var arr : container) ;

Begin
  reverse(arr, 0, length(arr));
End;










Procedure filler(Var arr : container);

Var counter : integer;
Begin
  counter := 1;
  While (counter < length(arr)) Do
    Begin
      writeln('enter your integer');
      readln(arr[counter]);
      counter := counter+1;
    End;
End;

Procedure displayer(arr : container);

Var counter: integer;
Begin
  counter := 1;
  While (counter < length(arr)) Do
    Begin
      writeln(arr[counter]);
      counter := counter+1;
    End;
End;


Function finder(arr: container; index, query : integer): integer;
Begin
  If (index = length(arr)) Then
    Begin
      If (arr[index] = query) Then finder := index
      Else finder := -1;
    End
  Else If (arr[index] = query) Then finder := index
  Else finder := finder(arr, index+1 , query);
End;


Function sum_positiv_nums(arr:container; index : integer): integer;

Var total : integer;
Begin
  total := 0;
  If (index = length(arr)) Then
    If (arr[index] > 0) Then total := arr[index];
  If (index < length(arr)) Then
    Begin
      If (arr[index]>0) Then total := arr[index];
      sum_positiv_nums := total+ sum_positiv_nums(arr, index+1);
    End;
End;


Function sum_negative_nums(arr : container ; index : integer): integer;

Var total : integer;
Begin

  total := 0;
  If (index = length(arr))Then
    If (arr[index] < 0) Then total := arr[index];
  If (index < length(arr)) Then
    Begin
      If (arr[index] < 0 ) Then total := arr[index];
      sum_negative_nums := total + sum_negative_nums(arr, index +1);
    End;
End;

Procedure sum_neg_pos_nums (arr : container);
Begin
  writeln('the  sum_positiv_nums of the array is ', sum_positiv_nums(arr, 1));
  writeln('the sum_negative_nums of the array is ', sum_negative_nums(arr, 1));
End;



//*Main program

Begin
  writeln(findStr('this is it', 'is'));

  readln;
End.