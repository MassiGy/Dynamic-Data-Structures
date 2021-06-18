
Program trees;


Type 
  root = ^tree;
  tree = Record
    data : integer;
    left : root;
    right: root;
  End;


Type 
  node = ^list;
  list = Record
    data : integer;
    next : node;
  End;

Type 
  fnReturn = ^returnBlok;
  returnBlok = Record
    val : integer;
    child: node;
    next: fnReturn;
  End;


Var head, element : root;
//var queue : node;


//* For list {in order to help in the tree traversal process}



Procedure nodeMakerV2 (Var el: node; val : integer);
Begin
  new(el);
  el^.data:= val;
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


Procedure printList(head: node);

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





Function shift(Var head: node): fnReturn;
Begin
  If (head <> Nil) Then
    Begin
      new(shift);
      shift^.child := head;
      head := head^.next;
      shift^.child^.next := Nil;
      shift^.val := listLengthCounter(head);
    End;
End;


Function push(Var head : node; val : integer): fnReturn;

Var tmp, el : node;
Begin
      nodeMakerV2(el, val);

  If (head = Nil) Then head :=el 

  Else
    Begin
      tmp := head;
      While (tmp^.next <> Nil) Do tmp := tmp^.next;
      tmp^.next:= el;
    End;
  new(push);
  push^.child := Nil;
  push^.val := listLengthCounter(head);
End;





//* For Trees 

Procedure treeMaker(Var root : root);
Begin
  new(root);
  writeln('enter your data');
  writeln(root^.data);
  root^.left := Nil;
  root^.right := Nil;
End;


Procedure treeMakerV2(Var root : root; value: integer);
Begin
  new(root);
  root^.data :=  value;
  root^.left := Nil;
  root^.right := Nil;
End;


Function max(x,y: integer):integer;
Begin
    if(x < y) then max:=y
    else max:=x;
end;

Function treeLength(root : root): integer;
Begin
  If (root  = Nil ) Then treeLength := 0
  Else If ((root^.left = Nil ) And (root^.right = Nil )) Then treeLength := 1
  Else treeLength := 1 +max( treeLength(root^.left) , treeLength(root^.right));
End;






//* Tree traversal.



Function inserter(Var root , son: root) : root;
Begin
  If (root = Nil) Then
    Begin
      root := son;
      new(inserter);
      inserter := root;
    End
  Else
    Begin
      If (root^.data > son^.data) Then
        Begin
          If (root^.left = Nil ) Then root^.left := son
          Else inserter(root^.left, son);
        End;
      If (root^.data < son^.data) Then
        Begin
          If (root^.right = Nil) Then root^.right := son
          Else inserter(root^.right, son);
        End;
    End;
  new(inserter);
  inserter := root;
End;


Function inserterV2(Var root : root; value : integer) : root;

Var son : root;
Begin
  If (root = Nil) Then
    Begin
      treeMakerV2(root, value);
      new(inserterV2);
      inserterV2 := root;
    End
  Else
    Begin
      If (root^.data > value) Then
        Begin
          If (root^.left = Nil ) Then
            Begin
              treeMakerV2(son,value);
              root^.left := son;
            End
          Else inserterV2(root^.left, value);
        End;
      If (root^.data < value) Then
        Begin
          If (root^.right = Nil) Then
            Begin
              treeMakerV2(son, value);
              root^.right := son;
            End
          Else inserterV2(root^.right, value);
        End;
    End;
  new(inserterV2);
  inserterV2 := root;
End;

Procedure displayer(head : root); // depth fisrt search / preOrder traversal principle
Begin
    if(head = nil) then writeln('empty tree')
    else 
        Begin   
                writeln('the data inside of this node is equal to ', head^.data);
                writeln('on the left');
                displayer(head^.left);
                writeln('on the right');
                displayer(head^.right);
        end;
end;



function searcher(head : root ; query : integer):root;
var tmp: root;
begin
    if(head = nil) then searcher := nil
    else if (head^.data = query) then searcher:= head
    else 
        begin
            if(query < head^.data) then searcher:= searcher(head^.left , query);
            if(query > head^.data) then searcher:= searcher(head^.right, query);
        end;
end;


function breadth_vs(var head : root) : node; // breadth first search traversal principle
var queue, current : node;
    branch : root;
Begin
    queue:=nil;
    current:=nil;
    breadth_vs:=nil;
    if(head = nil ) then writeln('empty tree')
    else 
      begin
        push(queue, head^.data);
        while (listLengthCounter(queue) > 0) do 
           begin
                
                current:= shift(queue)^.child;
                push(breadth_vs,current^.data );
                branch:= searcher(head, current^.data);
                if(branch^.left <> nil ) then push(queue, branch^.left^.data);
                if(branch^.right <> nil ) then push(queue, branch^.right^.data);
            end;
      end;
end;

//* Depth first search.


Procedure dfs_PreOrder(head : root;var store : node); //visit the node then traverse the left side of it, then righ one.
Begin
    if(head = nil) then writeln('empty tree')
    else 
        Begin
            push(store, head^.data );
            if(head^.left <> nil) then dfs_PreOrder(head^.left, store);
            if(head^.right <> nil)then dfs_PreOrder(head^.right,store);
        end;
end;

Procedure dfs_inOnder(head : root; var store : node); // traverse  the left side of a node, then visit the node before going through the right side.
Begin
    if(head = nil) then writeln('empty tree')
    else 
        Begin
            if(head^.left <> nil) then dfs_PreOrder(head^.left, store);
            push(store, head^.data );
            if(head^.right <> nil)then dfs_PreOrder(head^.right, store);
        end;
end;


Procedure dfs_postOnder(head : root; var store: node); // traverse  the left side of a node, then the right side, and finaly the node itself.
Begin
    if(head = nil) then writeln('empty tree')
    else 
        Begin
            if(head^.left <> nil) then dfs_PreOrder(head^.left, store);
            if(head^.right <> nil)then dfs_PreOrder(head^.right, store);
            push(store, head^.data );
        end;
end;



Procedure visulizeTree(tree : root; choice : integer);
var resault : node;
Begin
    if(choice = 1) then 
        Begin
            writeln('this is the breadth first search, // basicly we visit all the sibling nodes befor moving forwards');
            writeln('Note: sibling nodes is a group of nodes that are located in the same row or tree level.');
            resault:= breadth_vs(tree);
            printList(resault);
        end;
    if(choice = 2) then
        begin
            writeln('this is the depth first search traversal pattern ,Option: Pre Order');
            writeln('basicly you visit a node then all the left side of it ,before going to the right side;');
            dfs_PreOrder(tree, resault);
            printList(resault);
        end;
    if(choice = 3) then
      begin
          writeln('this is the depth first search traversal pattern, Option: In Order');
          writeln('basicly you visit the left side of a node ,then the node itself, then the right side of it ');
          dfs_inOnder(tree, resault);
          printList(resault);
      end;
    if(choice = 4) then
    begin
      writeln('this is the depth first search traversal pattern, Option: Post Order');
      writeln('Basicly you visit the left side of a node, then the right side before the node itself');
      dfs_postOnder(tree, resault);
      printList(resault);
    end;
end;

Procedure filler(var tree  : root; nodeCount : integer);
var counter, val : integer;
begin
  for counter:=1 to nodeCount do  
    begin
      writeln('enter your data {integer type}');
      readln(val);
      inserterV2(tree, val);
    end;
end; 


//* Main program //

begin
  writeln('filling the tree');
  inserterV2(head,10);
  inserterV2(head,6);
  inserterV2(head,3);
  inserterV2(head,8);
  inserterV2(head,15);
  inserterV2(head,20);

  //* Run any function you want
  visulizeTree(head, 2);
  displayer(head);
  readln;
End.



