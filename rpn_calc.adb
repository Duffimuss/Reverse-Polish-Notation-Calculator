with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with BigNumPkg; use BigNumPkg;
with BigNumPkg.Signed; use BigNumPkg.Signed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with StackPkg;

-- Name: Chris Gunter
-- Date: April 11, 2018
-- Course: ITEC 320 Procedural Analysis and Design

-- Purpose: This program implements a Reverse Polish Notation Calculator
-- All input is assumed valid.
-- When presented with p the current top of stack is printed.
-- When presented with P then pop top of stack
-- When presented with q then quit
-- example input:
--10
--20+p
--
--p
--
--P
--2   6   *   p
--
-- example Output:
--30
--30
--12
-- Help Recieved: none
procedure Rpn_Calc is

   ------------------------------------------------------------------
   -- Purpose: Performs Functions on Signed_BigNums
   -- Parameters: char : operation X,Y : Values to be operated
   -- Precondition: char is a legal operation
   -- Postcondition: Returns final value from operation
   ------------------------------------------------------------------
   function doProc(char : Character; X,Y : Signed_BigNum) return Signed_BigNum is
      ResultNum : Signed_BigNum; -- result number
      falseKey : Boolean; -- a filler for others case
   begin
      case char is
      when '+' =>
	 ResultNum := X + Y;
      when '-' =>
	 ResultNum := X - Y;
      when '*' =>
	 ResultNum := X * Y;
      when others =>
	 falseKey := false;
      end case;
      return ResultNum;
   end doProc;

   ------------------------------------------------------------------
   -- Purpose: Validates legal characters
   -- Parameters: char : character to be validated
   -- Precondition:
   -- Postcondition: Returns True if character is valid
   ------------------------------------------------------------------
   function validChar(char : Character) return Boolean is
      key : Boolean;
   begin
      case char is
      when '+' =>
	 key := true;
      when '-' =>
	 key := true;
      when '*' =>
	 key := true;
      when others =>
	 key := false;
      end case;
      return key;
   end validChar;

   package MyStkPkg is new StackPkg(Size => 100, ItemType => Signed_BigNum);
   use MyStkPkg;

   SignStack : MyStkPkg.Stack;
   mySignNum : Signed_BigNum;
   charCheck : Character;
   opVal : Character;
   EOL : Boolean;
   tempOne : Signed_BigNum;
   tempTwo : Signed_BigNum;
begin
   loop
      exit when End_Of_File;
      Look_Ahead(charCheck, EOL);
      if EOL then
	 Skip_Line;
      elsif charCheck = ' ' then
	 Ada.Text_IO.Get(charCheck);
      else
	 if Is_Digit(charCheck) then -- if digit then get SignBigNum
	    Get(mySignNum);          -- and push on stack
	    push(mySignNum, SignStack);
	 else
	    Ada.Text_IO.Get(opVal); -- else get character and check
	    if validChar(opVal) then -- if valid do operation
	       tempOne := top(SignStack);
	       pop(SignStack);
	       tempTwo := top(SignStack);
	       pop(SignStack);
	       mySignNum := doProc(opVal,tempOne,tempTwo);
	       push(mySignNum, SignStack);
	    elsif opVal = 'p' then -- if p then print
	       Put(top(SignStack));
	    elsif opVal = 'P' then -- if P then pop
	       pop(SignStack);
	    elsif opVal = 'q' then -- if q quit
	       exit;
	    end if;
	 end if;
      end if;
   end loop;
end Rpn_Calc;
