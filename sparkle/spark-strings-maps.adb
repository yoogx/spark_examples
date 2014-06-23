package body Spark.Strings.Maps with
     Spark_Mode => Off
   --  XXX GNATProve GPL2014
   --
   --  Internal error:
   --  File "/Users/hugues/Desktop/Work/Dev/git/spark_examples/sparkle/gnatprove/spark-strings-maps/../spark-strings-maps.mlw", line 8444, characters 90-249:
   --  This expression has type map bool, it cannot be applied.
   --  Aborting.

 is

   ---------
   -- "-" --
   ---------

   function Minus_Op (Left, Right : Character_Set) return Character_Set is
      Result    : Character_Set;
      Not_Right : Character_Set;
   --  XXX GCC.4.4.0 barks about direct boolean operator here
   begin
      Not_Right := not Right;
      Result    := Left and Not_Right;
      return Result;
   end Minus_Op;

   ---------
   -- "=" --
   ---------

   function Equal_Op (Left, Right : Character_Set) return Boolean is
   begin
      return Left = Right;
   end Equal_Op;

   -----------
   -- "and" --
   -----------

   function And_Op (Left, Right : Character_Set) return Character_Set is
      Result : Character_Set;
   begin
      Result := Left and Right;
      return Result;
   end And_Op;

   -----------
   -- "not" --
   -----------

   function Not_Op (Right : Character_Set) return Character_Set is
   begin
      return not Right;
   end Not_Op;

   ----------
   -- "or" --
   ----------

   function Or_Op (Left, Right : Character_Set) return Character_Set is
      Result : Character_Set;
   begin
      Result := Left or Right;
      return Result;
   end Or_Op;

   -----------
   -- "xor" --
   -----------

   function Xor_Op (Left, Right : Character_Set) return Character_Set is
      Result : Character_Set;
   begin
      Result := Left xor Right;
      return Result;
   end Xor_Op;

   -----------
   -- Is_In --
   -----------

   function Is_In (Elt : Character; S : Character_Set) return Boolean is
   begin
      return S (Elt);
   end Is_In;

   ---------------
   -- Is_Subset --
   ---------------

   function Is_Subset
     (Elts : Character_Set;
      S    : Character_Set) return Boolean
   is
      Result : Boolean;
   begin
      Result := And_Op (Elts, S) = Elts;
      return Result;
   end Is_Subset;

   ---------------
   -- To_Domain --
   ---------------

   --  function To_Domain (Map : Character_Mapping) return Character_Sequence
   --  is
   --     Result : String (1 .. Map'Length);
   --     J      : Natural;

   --  begin
   --     J := 0;
   --     for C in Map'Range loop
   --        if Map (C) /= C then
   --           J := J + 1;
   --           Result (J) := C;
   --        end if;
   --     end loop;

   --     return Result (1 .. J);
   --  end To_Domain;

   ----------------
   -- To_Mapping --
   ----------------

   --  function To_Mapping
   --    (Frm, To : Character_Sequence) return Character_Mapping
   --  is
   --     Result   : Character_Mapping;
   --     --  Inserted : Character_Set := Null_Set;
   --     --  Frm_Len : constant Natural := Frm'Length;
   --     --  To_Len   : constant Natural := To'Length;

   --  begin
   --     --  if Frm_Len /= To_Len then
   --     --     raise Strings.Translation_Error;
   --     --  end if;

   --     for Char in Character loop
   --        Result (Char) := Char;
   --     end loop;

   --     for J in Frm'Range loop
   --        --  if Inserted (Frm (J)) then
   --        --     raise Strings.Translation_Error;
   --        --  end if;

   --        Result   (Frm (J)) := To (J - Frm'First + To'First);
   --        --  Inserted (Frm (J)) := True;
   --     end loop;

   --     return Result;
   --  end To_Mapping;

   --------------
   -- To_Range --
   --------------

   --  function To_Range (Map : Character_Mapping) return Character_Sequence
   --  is
   --     Result : String (1 .. Map'Length);
   --     J      : Natural;
   --  begin
   --     J := 0;
   --     for C in Map'Range loop
   --        if Map (C) /= C then
   --           J := J + 1;
   --           Result (J) := Map (C);
   --        end if;
   --     end loop;

   --     return Result (1 .. J);
   --  end To_Range;

   ---------------
   -- To_Ranges --
   ---------------

   --  function To_Ranges (S : Character_Set) return Character_Ranges is
   --     Max_Ranges : Character_Ranges (1 .. S'Length / 2 + 1);
   --     Range_Num  : Natural;
   --     C          : Character;

   --  begin
   --     C := Character'First;
   --     Range_Num := 0;

   --     loop
   --        --  Skip gap between subsets

   --        while not S (C) loop
   --           exit when C = Character'Last;
   --           C := Character'Succ (C);
   --        end loop;

   --        exit when not S (C);

   --        Range_Num := Range_Num + 1;
   --        Max_Ranges (Range_Num).Low := C;

   --        --  Span a subset

   --        loop
   --           exit when not S (C) or else C = Character'Last;
   --           C := Character'Succ (C);
   --        end loop;

   --        if S (C) then
   --           Max_Ranges (Range_Num). High := C;
   --           exit;
   --        else
   --           Max_Ranges (Range_Num). High := Character'Pred (C);
   --        end if;
   --     end loop;

   --     return Max_Ranges (1 .. Range_Num);
   --  end To_Ranges;

   -----------------
   -- To_Sequence --
   -----------------

   --  function To_Sequence (S : Character_Set) return Character_Sequence is
   --     Result : String (1 .. Character'Pos (Character'Last) + 1);
   --     Count  : Natural := 0;
   --  begin
   --     for Char in S'Range loop
   --        if S (Char) then
   --           Count := Count + 1;
   --           Result (Count) := Char;
   --        end if;
   --     end loop;

   --     return Result (1 .. Count);
   --  end To_Sequence;

   ------------
   -- To_Set --
   ------------

   --  function To_Set (Ranges : Character_Ranges) return Character_Set is
   --     Result : Character_Set;
   --  begin
   --     for C in Result'Range loop
   --        Result (C) := False;
   --     end loop;

   --     for R in Ranges'Range loop
   --        for C in Ranges (R).Low .. Ranges (R).High loop
   --           Result (C) := True;
   --        end loop;
   --     end loop;

   --     return Result;
   --  end To_Set;

   --  function To_Set (Span : Character_Range) return Character_Set is
   --     Result : Character_Set;
   --  begin
   --     for C in Result'Range loop
   --        Result (C) := False;
   --     end loop;

   --     for C in Span.Low .. Span.High loop
   --        Result (C) := True;
   --     end loop;

   --     return Result;
   --  end To_Set;

   --  function To_Set (Seq : Character_Sequence) return Character_Set is
   --     Result : Character_Set := Null_Set;
   --  begin
   --     for J in Seq'Range loop
   --        Result (Seq (J)) := True;
   --     end loop;

   --     return Result;
   --  end To_Set;

   --  function To_Set (Singleton : Character) return Character_Set is
   --     Result : Character_Set := Null_Set;
   --  begin
   --     Result (Singleton) := True;
   --     return Result;
   --  end To_Set;

   -----------
   -- Value --
   -----------

   function Value
     (Map : Character_Mapping;
      Elt : Character) return Character
   is
   begin
      return Map (Elt);
   end Value;

end Spark.Strings.Maps;
