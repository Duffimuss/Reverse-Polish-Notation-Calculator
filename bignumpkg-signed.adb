with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

-- Name: Chris Gunter
-- Date: April 11, 2018
-- Course: ITEC 320 Procedural Analysis and Design

-- Purpose: This is a package representing a Signed_BigNum
-- Numbers 0... to 4999999999999... are equal to 0.. to 4999999999999999..
-- Numbers 50000000000000000.. to 999999999999999... are equal to
-- -00000000000000000... to -49999999999999999.....
-- the package does math operations and get/ put.
-- Help Recieved: none
package body BigNumPkg.Signed is
   InternalBase : constant Positive := 10;

   -- This is a stub routine
   -- You are to complete the implementation of this routine
   -- I could not get the toString to work.
   ------------------------------------------------------------------
   -- Purpose: Converts Signed_BigNums to Strings
   -- Parameters: X : Signed_BigNum to convert
   -- Precondition:
   -- Postcondition: Returns String of X
   ------------------------------------------------------------------
   function toString(X: Signed_BigNum) return String is
   --   count : Natural := 0;
   begin
 --     loop
--	 exit when X(count) /= 0;
--	 count := count + 1;
  --    end loop;
  --    declare
--	 resultStr : String(count..Size-1);
--	 tempNum : Natural;
   --   begin
--	 for I in count..Size-1 loop
--	    tempNum := tempNum + X(I);
--	    resultStr(I) := Integer'Image(tempNum);
--	 end loop;
--	 return resultStr;
   --   end;
   return "";
   end toString;

   ------------------------------------------------------------------
   -- Purpose: Determines if X is less than Y
   -- Parameters: X, Y : Signed_BigNums to be compared
   -- Precondition:
   -- Postcondition: Returns True if X is less than Y
   ------------------------------------------------------------------
   function "<"  (X, Y : Signed_BigNum) return Boolean is
   begin
      -- if x and y > 4999 then reverse < | else normal <
      if BigNum(X) > BigNum(Last) or BigNum(Y) > BigNum(Last) then
	 return BigNum(X) > BigNum(Y);
      else
	 return BigNum(X) < BigNum(Y);
      end if;
   end "<";

   ------------------------------------------------------------------
   -- Purpose: Determines if X is greater than Y
   -- Parameters: X, Y : Signed_BigNums to be compared
   -- Precondition:
   -- Postcondition: Returns True if X is greater than Y
   ------------------------------------------------------------------
   function ">"  (X, Y : Signed_BigNum) return Boolean is
   begin
      -- if x and y > 4999 then reverse > | else normal >
      if BigNum(X) > BigNum(Last) or BigNum(Y) > BigNum(Last) then
	 return BigNum(X) < BigNum(Y);
      else
	 return BigNum(X) > BigNum(Y);
      end if;
   end ">";

   ------------------------------------------------------------------
   -- Purpose: Determines if X is less than or equal to Y
   -- Parameters: X, Y : Signed_BigNums to be compared
   -- Precondition:
   -- Postcondition: Returns True if X is less than or equal to Y
   ------------------------------------------------------------------
   function "<=" (X, Y : Signed_BigNum) return Boolean is
   begin
      -- if x and y > 4999 then reverse <= | else normal <=
      if BigNum(X) > BigNum(Last) or BigNum(Y) > BigNum(Last) then
	 return BigNum(X) >= BigNum(Y);
      else
	 return BigNum(X) <= BigNum(Y);
      end if;
   end "<=";

   ------------------------------------------------------------------
   -- Purpose: Determines if X is greater than or equal to Y
   -- Parameters: X, Y : Signed_BigNums to be compared
   -- Precondition:
   -- Postcondition: Returns True if X is greater than or equal to Y
   ------------------------------------------------------------------
   function ">=" (X, Y : Signed_BigNum) return Boolean is
   begin
      -- if x and y > 4999 then reverse >= | else normal >=
      if BigNum(X) > BigNum(Last) or BigNum(Y) > BigNum(Last) then
	 return BigNum(X) <= BigNum(Y);
      else
	 return BigNum(X) >= BigNum(Y);
      end if;
   end ">=";

   ------------------------------------------------------------------
   -- Purpose: Converts X into a negative number
   -- Parameters: X : Signed_BigNum to be negated
   -- Precondition:
   -- Postcondition: Returns Signed_BigNum of negated X
   ------------------------------------------------------------------
   function negate (X : Signed_BigNum) return Signed_BigNum is
      limitNum : Signed_BigNum := (0 => 5, others => 0); -- 500000...
      resultNum : Signed_BigNum := (others => 0); -- result
      count : Natural := 0; -- used to negate first number then loop
   begin
      resultNum(count) := (X(count) + limitNum(count));

      if resultNum(count) >= InternalBase then
	 raise Signed_BigNumOverFlow; -- if first digit >= 10
      else

	 count := count + 1; -- position 2

	 for I in count..Size-1 loop
	    resultNum(I) := X(I);
	 end loop;
      end if;

      return resultNum;
   end negate;

   ------------------------------------------------------------------
   -- Purpose: Converts X to its Absolute Value
   -- Parameters: X : Signed_BigNum to be converted
   -- Precondition:
   -- Postcondition: Returns Absolute Value of X
   ------------------------------------------------------------------
   function abs_val (X : Signed_BigNum) return Signed_BigNum is
      limitNum : Signed_BigNum := (0 => 5, others => 0); -- 5000...
      resultNum : Signed_BigNum := (others => 0); -- result
   begin
      -- if x > 4999 then x - 50000....
      if BigNum(X) > BigNum(Last) then
	 for I in 0..Size-1 loop
	    resultNum(I) := X(I) - limitNum(I);
	 end loop;
      else -- result = x;
	 for I in 0..Size-1 loop
	    resultNum(I) := X(I);
	 end loop;
      end if;
      return resultNum;
   end abs_val;

   ------------------------------------------------------------------
   -- Purpose: Does Addition of Signed_BigNums and Returns overflow
   -- Parameters: X, Y : Signed_BigNums to be added;
   -- Result : Signed_BigNum the sum of X, Y; Overflow : Boolean that
   -- represents Overflow of sum.
   -- Precondition:
   -- Postcondition: Returns the sum of X,Y
   ------------------------------------------------------------------
   procedure plus_ov (X, Y : Signed_BigNum; Result : out Signed_BigNum; Overflow : out Boolean) is
      Carry : Natural := 0;
      Sum : Integer;
   begin
      for I in reverse 0..Size-1 loop
         Sum := Carry + X(I) + Y(I);

         -- Determine the amount of carry.
         if Sum >= InternalBase then
            Sum := Sum - InternalBase;
            Carry := 1;
         else
            Carry := 0;
         end if;

         Result(I) := Sum;
      end loop;

      -- The result is too big if the left-most column gave
      -- a carry.
      Overflow := Carry > 0;
   end plus_ov;

   ------------------------------------------------------------------
   -- Purpose: Computes X's 9C.
   -- Parameters: X : Signed_BigNums to be converted
   -- Precondition:
   -- Postcondition: Returns 9C of X
   ------------------------------------------------------------------
   function nineC (X : Signed_BigNum) return Signed_BigNum is
      ResultNum : Signed_BigNum;
      nine : constant Positive := 9;
   begin
      for I in 0..Size-1 loop
	 ResultNum(I) := nine - X(I); -- 9 - each digit
      end loop;
      return ResultNum;
   end nineC;

   ------------------------------------------------------------------
   -- Purpose: Adds two Signed_BigNums
   -- Parameters: X, Y : Signed_BigNums to be added
   -- Precondition:
   -- Postcondition: Returns Sum of X,Y
   ------------------------------------------------------------------
   function "+" (X, Y : Signed_BigNum) return Signed_BigNum is
      LimitNum : Signed_BigNum := (0 => 5, others => 0);
      xNeg : Signed_BigNum;
      yNeg : Signed_BigNum;
      yNine : Signed_BigNum;
      key : Boolean := false;
      ResultNum : Signed_BigNum;
      finalNum : Signed_BigNum;
   begin

      --if x and y < 4999 then normal bignum +
      if BigNum(X) < BigNum(Last) and BigNum(Y) < BigNum(Last) then
	 ResultNum := Signed_BigNum(BigNum(X) + BigNum(Y));
	 if ResultNum(0) >= LimitNum(0) then
	    raise Signed_BigNumOverFlow;
	 else
	    return ResultNum;
	 end if;
	 -- if x and y > 4999 then normal bignum +
      elsif BigNum(X) > BigNum(Last) and BigNum(Y) > BigNum(Last) then
	 ResultNum := Signed_BigNum(BigNum(X) + BigNum(Y));
	 if ResultNum(0) >= LimitNum(0) then
	    raise Signed_BigNumOverFlow;
	 else
	    return ResultNum;
	 end if;
      else -- find and negate all positives then bignum + and 9c-bignum+
	 if BigNum(X) < BigNum(Last) then
	    xNeg := negate(X);
	 else
	    xNeg := X;
	 end if;

	 if BigNum(Y) < BigNum(Last) then
	    yNeg := negate(Y);
	    yNine := nineC(yNeg);
	 else
	    yNeg := Y;
	    yNine := nineC(yNeg);
	 end if; -- all positives negated.

	 plus_ov(xNeg, yNine, ResultNum, key);
	 if key then -- if overflow then re-add one
	    plus_ov(ResultNum, One, finalNum, key);
	    return finalNum;
	 else -- else just re-add with 5000
	    plus_ov(ResultNum, LimitNum, finalNum, key);
	    return finalNum;
	 end if;
      end if;
   end "+";

   ------------------------------------------------------------------
   -- Purpose: Subtracts two Signed_BigNums
   -- Parameters: X, Y : Signed_BigNums to be subtracted
   -- Precondition:
   -- Postcondition: Returns the difference of X,Y
   ------------------------------------------------------------------
   function "-" (X, Y : Signed_BigNum) return Signed_BigNum is
      limitNum : Signed_BigNum := (0 => 5, others => 0);
      ResultNum : Signed_BigNum := (others => 0);
      xNeg : Signed_BigNum;
      yNeg : Signed_BigNum;
      yNine : Signed_BigNum := nineC(Y);
      tempNum : Signed_BigNum;
      overFlow : Boolean;
   begin

      -- if x and y < 4999 then
      -- Sum = X + 9C(Y)
      -- Result = (If Sum < 10_000 then 5_000 + 9C(Sum) else Sum + 1 - 10_000)
      if BigNum(X) < BigNum(Last) and BigNum(Y) < BigNum(Last) then
	 plus_ov(X, yNine, tempNum, overFlow);
	 if overFlow then
	    plus_ov(tempNum, One, ResultNum, overFlow);
	 else
	    yNine := nineC(tempNum);
	    plus_ov(limitNum, yNine, ResultNum, overFlow);
	 end if;
	 -- if x and y > 4999 then swith x and y pos
	 -- Sum = X + 9C(Y)
         -- Result = (If Sum < 10_000 then 5_000 + 9C(Sum) else Sum + 1 - 10_000)
      elsif BigNum(X) > BigNum(Last) and BigNum(Y) > BigNum(Last) then
	 yNine := nineC(X);
	 plus_ov(Y, yNine, tempNum, overFlow);
	 if overFlow then
	    plus_ov(tempNum, One, ResultNum, overFlow);
	 else
	    yNine := nineC(tempNum);
	    plus_ov(limitNum, yNine, ResultNum, overFlow);
	 end if;
	 -- negate all positives and treat like first case
      else
	 if BigNum(X) < BigNum(Last) then
	    xNeg := negate(X);
	 else
	    xNeg := X;
	 end if;

	 if BigNum(Y) < BigNum(Last) then
	    yNeg := negate(Y);
	 else
	    yNeg := Y;
	 end if;
	 ResultNum := xNeg + yNeg;
      end if;
      return ResultNum;
   end "-";

   ------------------------------------------------------------------
   -- Purpose: Multiplies two Signed_BigNums
   -- Parameters: X, Y : Signed_BigNums to be multiplied
   -- Precondition:
   -- Postcondition: Returns product of X,Y
   ------------------------------------------------------------------
   function "*" (X, Y : Signed_BigNum) return Signed_BigNum is
      ResultNum : Signed_BigNum := (others => 0);
      xAbs : Signed_BigNum;
      yAbs : Signed_BigNum;
   begin
      -- if all positive then bignum *
      if BigNum(X) < BigNum(Last) and BigNum(Y) < BigNum(Last) then
	 ResultNum := Signed_BigNum(BigNum(X) * BigNum(Y));

	 -- if all negative then absolute value all and bignum *
      elsif BigNum(X) > BigNum(Last) and BigNum(Y) > BigNum(Last) then
	 xAbs := abs_val(X);
	 yAbs := abs_val(Y);
	 ResultNum := Signed_BigNum(BigNum(xAbs) * BigNum(yAbs));

	 -- absolute value all and treat like first case
      else
	 if BigNum(X) < BigNum(Last) then
	    xAbs := X;
	 else
	    xAbs := abs_val(X);
	 end if;

	 if BigNum(Y) < BigNum(Last) then
	    yAbs := Y;
	 else
	    yAbs := abs_val(Y);
	 end if;
	 ResultNum := Signed_BigNum(BigNum(xAbs) * BigNum(yAbs));
      end if;
      if ResultNum(0) > InternalBase then
	 raise Signed_BigNumOverFlow;
      end if;
      return ResultNum;
   end "*";

   ------------------------------------------------------------------
   -- Purpose: Prints a Signed_BigNum
   -- Parameters: Item : Signed_BigNums to be printed; Width : Width
   -- of each digit.
   -- Precondition:
   -- Postcondition: Prints Signed_BigNum
   ------------------------------------------------------------------
   procedure Put (Item : Signed_BigNum; Width : Natural := 1) is
      limitNum : Signed_BigNum := (0 => 5,others => 0);
      tempNum : Signed_BigNum := Item;
      First : Integer := Size-1;
   begin

      -- major difference if negative then subtract and multiply -1
      if Item(0) >= limitNum(0) then
	 tempNum := abs_val(tempNum);
	 tempNum(0) := tempNum(0) * (-1);
      end if;
      -- Determine where the first digit of the number is,
      -- and thus the length of the number.
      for I in 0..Size-1 loop
	 if tempNum(I) /= 0 then
            First := I;
            exit;
         end if;
      end loop;

      -- Put any leading blanks that are necessary.
      for I in Size-First+1..Width loop
         Put(' ');
      end loop;

      -- Write out the digits of the number.
      for I in First..Size-1 loop
         Put(tempNum(I), Width => 1);
      end loop;
      New_Line;
   end Put;

   ------------------------------------------------------------------
   -- Purpose: Get reads positive and negative numbers
   -- Parameters: Item : Signed_BigNums to be read and stored;
   -- Precondition:
   -- Postcondition: reads and stores a Signed_BigNum
   ------------------------------------------------------------------
   procedure Get (Item : out Signed_BigNum) is
      limitNum : Signed_BigNum := (0 => 5, others => 0);
   begin
      Get(BigNum(Item));
      if Item(0) >= limitNum(0) then
	 Item := negate(Item);
      end if;
   end Get;

end BigNumPkg.Signed;
