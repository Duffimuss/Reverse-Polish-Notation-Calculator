-- Name: Chris Gunter
-- Date: March 25, 2018
-- Course: ITEC 320 Procedural Analysis and Design

-- Purpose: To implement the methods in stackpkg.ads

-- Help recieved: I used material from board pictures on stacks.
package body StackPkg is

   ------------------------------------------------------------------
   -- Purpose: Determines if stack is empty
   -- Parameters: s : Stack
   -- Precondition:
   -- Postcondition: Returns boolean
   ------------------------------------------------------------------
   function isEmpty (s : Stack) return Boolean is
   begin
      return s.Top = 0;
   end isEmpty;

   ------------------------------------------------------------------
   -- Purpose: Determines if stack is full
   -- Parameters: s : Stack
   -- Precondition:
   -- Postcondition: Returns Boolean
   ------------------------------------------------------------------
   function isFull (s : Stack) return Boolean is
   begin
      return s.Top = Size;
   end isFull;

   ------------------------------------------------------------------
   -- Purpose: Pushes item to the top of the stack
   -- Parameters: item : itemType to be pushed, s : stack
   -- Precondition: Stack is not full
   -- Postcondition: Item is pushed to stack
   ------------------------------------------------------------------
   procedure push (item : ItemType; s : in out Stack) is
   begin
      if isFull(s) then
	 raise Stack_Full;
      else
	 s.Top := s.Top + 1;
	 s.Elements(s.Top) := Item;
      end if;
   end push;

   ------------------------------------------------------------------
   -- Purpose: Removes Item from Stack
   -- Parameters: s : Stack
   -- Precondition: Stack is not empty
   -- Postcondition: Removed Item from Stack
   ------------------------------------------------------------------
   procedure pop (s : in out Stack) is
   begin
      if isEmpty(s) then
	 raise Stack_Empty;
      else
	 s.Top := s.Top - 1;
      end if;
   end pop;

   ------------------------------------------------------------------
   -- Purpose: Returns element on top of the stack
   -- Parameters: s : Stack
   -- Precondition:
   -- Postcondition: Returns ItemType on top of the stack
   ------------------------------------------------------------------
   function  top (s : Stack) return ItemType is
   begin
      return s.Elements(s.Top);
   end top;

end StackPkg;
