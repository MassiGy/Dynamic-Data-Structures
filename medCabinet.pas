program medCabinet;

uses crt, sysUtils;



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



procedure clientsArrival(var femaleQueue, maleQueue:node);
var client: node;
begin
    delay(15000);
    writeln('client arrival');
    if(random(2)<1) then 
      begin
        if(listLengthCounter(femaleQueue)<10) then 
          begin
            nodeMakerV2(client, 'female');
            push(femaleQueue, client);
            writeln('new women in the queue');
          end;
      end
    else if(listLengthCounter(maleQueue) <10)then
            begin
                 nodeMakerV2(client,'male');
                 push(maleQueue, client);
                 writeln('new man in the queue');
            end;
end;


Procedure medAssitence(var doctorQueue, femaleQueue, maleQueue: node);
begin
            if(listLengthCounter(maleQueue) < listLengthCounter(femaleQueue))then
            begin
            push(doctorQueue,shift(femaleQueue)^.child);
            writeln('new women in the doctor office')
            end
            Else 
                begin
                    writeln('new man in the doctor office');
                    push(doctorQueue, shift(maleQueue)^.child);
                end;
end;


procedure doctorProcess(var doctorQueue,femaleQueue,maleQueue:node;
                       var Gain, lowCost, hightCost, patientPassed,servedFemales ,servedMales: integer );
var currentPatient: node;
var  visitDuration: integer;
begin
    if(listLengthCounter(doctorQueue)= 0) then medAssitence(doctorQueue,femaleQueue,maleQueue);
    currentPatient := shift(doctorQueue)^.child;
    visitDuration:=(random(26)+20);
    delay(visitDuration * 1000);
    if(visitDuration > 30) then
    begin
     Gain:=Gain+2000; 
     hightCost:=hightCost+1;
     patientPassed:=patientPassed+1;
     if(currentPatient^.data = 'female') then servedFemales:= servedFemales+1
     else servedMales:=servedMales+1;
    end
    else 
        begin
            Gain:=Gain+1500;
            lowCost:=lowCost+1;
            patientPassed:=patientPassed+1;
            if(currentPatient^.data = 'female') then servedFemales:= servedFemales+1
            else servedMales:=servedMales+1;
        end;

end;

Procedure medProcess(endOfDay : boolean);
var servedFemales,servedMales, patientPassed, Gain, hightCost, lowCost: integer; 
var doctorQueue,maleQueue,femaleQueue:node;
var counter : integer;
begin
    counter:=0;
    servedFemales:=0;
    servedMales:=0;
    lowCost:=0;
    hightCost:=0;
    patientPassed:=0;
    Gain:=0;
    doctorQueue:=nil;
    maleQueue:=nil;
    femaleQueue:=nil;
    While(endOfDay = false) do
        begin
            clientsArrival(femaleQueue,maleQueue);
            medAssitence(doctorQueue,femaleQueue, maleQueue);
            doctorProcess(doctorQueue,femaleQueue,maleQueue,Gain, lowCost,hightCost,patientPassed,servedFemales,servedMales);
            if(counter =3) then endOfDay:=true;
            counter:=counter+1;
        end;
    writeln('***************Day sumurize***************************************************');
    writeln('** the number of patient Passed is equal to ', patientPassed);
    writeln('** the number of male served is equal to ', servedMales);
    writeln('** the number of female served is equal to ', servedFemales);
    writeln('** the total gain this day is equal to ', Gain, 'dzd');
    writeln('** the number of patient passed with a visit duration over then 30min is ', hightCost);
    writeln('** the number of patient passed with a visit duration less then 30min is ', lowCost );
end;




begin
//* This program is here to semulate how a day in the medical Cabinet happens
//* Built with dynamic programing and Dynamic Data structure: queues and singleLinkedLists
randomize;

medProcess(false);
readln;
end.