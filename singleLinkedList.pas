Program singleLinkedList;

Type 
  node = ^list;
  list = Record
    data : string;
    next : node;
  End;

Type 
  fnReturn = ^returnBlok;
  returnBlok = Record
    value : integer;
    child: node;
    next: fnReturn;
  End;




Var 
  head,element , aChild : node;
  listLength, limit: integer;




Procedure nodeMaker (Var el: node);
Begin
  new(el);
  writeln('enter your data <15 chars');
  readln(el^.data);
  el^.next := Nil;

End;

Procedure nodeMakerV2 (Var el: node; data : string);
Begin
  new(el);
  el^.data:=data;
  el^.next := Nil;
End;


Function listLengthCounter( start : node): integer;

Var walker: node;
  lengthCount: integer;
Begin
  walker := start;
  If (walker = Nil) Then listLengthCounter := 0
  Else If (walker^.next =Nil )Then listLengthCounter := 1
  Else
    Begin
      lengthCount := 1;
      While (walker^.next <> Nil) Do
        Begin
          walker := walker^.next;
          lengthCount := lengthCount+1;
        End;
      listLengthCounter := lengthCount;
    End;
End;



Function  unshift (Var head : node; el : node) : fnReturn;

Begin

  If (head = Nil ) Then head := el
  Else
    Begin
      el^.next := head;
      head := el;
    End;
  new(unshift);
  unshift^.child := Nil;
  unshift^.value := listLengthCounter(head);

End;


Function shift(Var head: node): fnReturn;
Begin
  If (head <> Nil) Then
    Begin
      new(shift);
      shift^.child := head;
      head := head^.next;
      shift^.child^.next := Nil;
      shift^.value := listLengthCounter(head);
    End;
End;


Function push(Var head : node; el: node): fnReturn;

Var tmp : node;
Begin

  If (head = Nil) Then head := el

  Else
    Begin
      tmp := head;
      While (tmp^.next <> Nil) Do
        tmp := tmp^.next;
      tmp^.next := el;
      el^.next := Nil;
    End;
  new(push);
  push^.child := Nil;
  push^.value := listLengthCounter(head);
End;


Function popup(Var head : node): fnReturn;

Var tmp: node;

Begin
  If (head <> Nil ) Then
    Begin
      tmp := head;
      While (tmp^.next^.next <> Nil ) Do
        tmp := tmp^.next;
      new(popup);
      popup^.child := tmp^.next;
      tmp^.next := Nil;
      popup^.value := listLengthCounter(head);
    End;
End;





Function searcher(head, query : node): node;

Var tmp  : node;
Begin
  tmp := Nil;
  If (head = Nil) Then searcher := Nil
  Else
    Begin
      tmp := head;
      While ((tmp <> Nil) And (tmp <> query) ) Do
        tmp := tmp^.next;
      If (tmp <> Nil) Then searcher := tmp
      Else searcher := Nil;
    End;
End;


Function searcherV2(head: node; query : String): node;

Var tmp : node;
Begin
  tmp := Nil;
  If (head = Nil) Then searcherV2 := Nil
  Else
    Begin
      tmp := head;
      While ((tmp^.data <> query) And (tmp^.next <> Nil )) Do
        tmp := tmp^.next;
      If (tmp^.data = query ) Then searcherV2 := tmp
      Else searcherV2 := Nil;
    End;
End;


Function insert(Var head , after: node; el : node ): fnReturn;

Var tmp: node;
Begin
  tmp := Nil;
  If ((head = Nil) Or (searcher(head,after) = Nil) ) Then writeln('Refrence Error/ list head is nil or after is not include in the list')
  Else
    Begin
      tmp := after^.next;
      after^.next := el;
      el^.next := tmp;
      new(insert);
      insert^.child := Nil;
      insert^.value := listLengthCounter(head);
// Note : we've could use the searcher(head,after) value to gain the memory space reserved for tmp; 
    End;
End;



Function splice(Var head, after: node; elCount: integer): fnReturn;

Var tmp, elToRemove: node;
  count: integer;
Begin
  tmp := Nil;
  If ((head = Nil) Or (searcher(head, after) = Nil) ) Then writeln('Refrence Error/ list empty or the splice startup element is not include in ')
  Else
    Begin
      If (elCount =1) Then
        Begin
          tmp := searcher(head, after);
          elToRemove := searcher(head, after)^.next;
          tmp^.next := elToRemove^.next;
          elToRemove^.next := Nil;
        End;
      If (elCount > 1) Then
        Begin
          tmp := searcher(head, after);
          // it the next element but we need to store the previous
          elToRemove := tmp;
          count := 0;
          While ((count < elCount) And (elToRemove<> Nil)) Do
            Begin
              elToRemove := elToRemove^.next;
              count := count+1;
            End;
          tmp^.next := elToRemove^.next;
          elToRemove^.next := Nil;

        End;
// Note : we've could use the value of the searcherV2 function to gain the reserved space for tmp or elToRemove variables
      new(splice);
      splice^.child := elToRemove;
      splice^.value := listLengthCounter(head);
      elToRemove := Nil;
    End;

End;

Function replace (Var head, after : node; el : node): node;

Var elToReplace: node;

Begin

  If ((head = Nil) Or (searcher(head, after) = Nil) ) Then writeln('Refrence Error/ list empty or the splice startup element is not include in '  )
  Else
    Begin
      elToReplace := searcher(head, after)^.next;
      If (elToReplace = Nil ) Then writeln('/Refrece Error: element to replace is not found')
      Else
        Begin
          searcher(head, after)^.next := el;
          el^.next := elToReplace^.next;
          replace := elToReplace;
          replace^.next := Nil;
          elToReplace := Nil;
        End;
    End;

End;






Procedure fillerOnTop(Var head: node);
// note fill on top is also the correct way to fill a stack (pile in french)
Begin
  nodeMaker(element);
  unshift(head, element);
End;


Procedure fillerOnButtom (Var head: node);
// note: fill on buttum is also the correct way to fill a queue (file (file d'attente) in french)
Begin
  nodeMaker(element);
  push(head, element);
End;

Procedure displayer(head: node);

Var tmp: node;
Begin
  If (head = Nil ) Then writeln('List empty')
  Else
    Begin
      tmp := head;
      While (tmp <> Nil ) Do
        Begin
          writeln('data is equal to ', tmp^.data);
          tmp := tmp^.next;
        End;
    End;
End;

Procedure swaper(Var prevNode,curNode : node);

Var tmp: node;
Begin
  If (curNode^.next <> Nil) Then
    Begin
      // swap elements
      tmp := curNode^.next;
      curNode^.next := curNode^.next^.next;
      prevNode^.next := tmp;
      tmp^.next := curNode;
      tmp := Nil;
    End;
End;


Procedure treater(Var head : node);
/// BUBBLE SORT .OPTIMIZED VERSION

Var  j,stop,tmp, beforJ: node;
  i: integer;
  noSwaps: boolean;


// noSwap variable is used to prevent the bubble sort to walk through the list when no changes can be made!
Begin
  If (head = Nil) Then writeln('list empty')
  Else If (head^.next = Nil) Then writeln('list can not be treated anymore further')
  Else
    Begin
      i := 1;
      stop := Nil;
      listLength := listLengthCounter(head);
      While (i <  listLength)  Do
        Begin
          noSwaps := true;
          If (head^.data > head^.next^.data) Then
            Begin
              tmp := head^.next;
              head^.next := head^.next^.next;
              tmp^.next := head;
              head := tmp;
              tmp := Nil;
              noSwaps := false;

            End;
          j := head^.next;
          beforJ := head;
          While (j^.next <> stop) Do
            Begin
              If (j^.data >= j^.next^.data )Then
                Begin
                  swaper(beforJ,j);
                  noSwaps := false;
                End;
              beforJ := beforJ^.next;
            End;
          stop := j;
          If (noSwaps = true) Then i := listLength  // just break up the loop
          Else i := i+1;
        End;

    End;
End;



Function o_merge(Var firstList, secondList : node): fnReturn;
// merge then treat

Var temporary: node;
Begin
  If (firstList = secondList) Then writeln('Input Error/ arg1 & arg2 can not be equal ')
  Else
    Begin
      temporary := firstList;
      // we have to merge the two and respect the sort;         
      While (temporary^.next <> Nil) Do
        temporary := temporary^.next;
      // temporary will be the last element of the first list and temporary^.next = nil
      temporary^.next := secondList;
      new(o_merge);
      o_merge^.value := listLengthCounter(firstList) + listLengthCounter(secondList);
      treater(firstList);
      o_merge^.child := firstList;
      // no need to it;
    End;
End;

Function o_mergeV2(Var firstList, secondList : node): fnReturn;
// merge and treat at the same time

Var temporary,store, local: node;
  counter: integer;
Begin
  counter := 1;
  treater(firstList);
  treater(secondList);
  new(o_mergeV2);
  o_mergeV2^.value := listLengthCounter(firstList) + listLengthCounter(secondList);
  If (firstList = secondList) Then writeln('Input Error/ arg1 & arg2 can not be equal ')
  Else
    Begin
      new(temporary);
      temporary^.data := '';
      temporary^.next := firstList;


  // Now we can change the list on top of it head, and not from the head, which does not let us the 
      // chance to insert before it (it refers to the head)
      While ((counter < o_mergeV2^.value) And (
            listLengthCounter(secondList) >0) ) Do
        Begin
          If ((temporary^.next^.data >= secondList^.data) ) Then
            Begin
              local := shift(secondList)^.child;
              insert(temporary,temporary,local);
            End
          Else
            Begin
              store := temporary;
              While ((store^.data <secondList^.data) And (store^.next <> Nil)) Do
                Begin
                  store := store^.next;
                End;
              local := shift(secondList)^.child;
              insert(temporary,store,local);
            End;
          counter := counter+1;

        End;
      firstList := temporary^.next;
      o_mergeV2^.child := firstList;
      // not need to it, just done to respect the general data managment schema
    End;
End;


///* Main program// 
Begin
  head := Nil;
  element := Nil;
  writeln('please enter the length of your list');
  readln(limit);
  While (listLengthCounter(head) < limit) Do
    fillerOnButtom(head);
  //* Run every function you want!
  displayer(head);
  readln;
End.