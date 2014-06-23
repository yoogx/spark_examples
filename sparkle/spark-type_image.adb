package body Spark.Type_Image with
     Spark_Mode => On is

   -------------------
   -- Boolean_Image --
   -------------------

   function Boolean_Image (N : Boolean) return Strings.SparkString is
      True_String : constant String := "TRUE";

      Result : Strings.SparkString;
   begin
      if N then
         Strings.CopyString (Result, True_String);
      else
         Strings.CopyString (Result, "FALSE");
      end if;

      return Result;
   end Boolean_Image;

   -------------------
   -- Integer_Image --
   -------------------

   function Integer_Image (N : Integer) return Strings.SparkString is
      Result : Strings.SparkString := Strings.EmptyString;
      V      : Integer;
      Index  : Strings.Positions;
   begin
      if N >= 0 then
         V := -N;
      else
         V := N;
      end if;

      Result.Length := Strings.MaxStringLength;

      for J in
        reverse Natural range
          Strings.MaxStringLength - 20 ..
            Strings.MaxStringLength
      loop
         Index := J;

         exit when V > -10;
         Result.Text (J) := Character'Val (Character'Pos ('0') - (V rem 10));
         V               := V / 10;

         pragma Loop_Invariant
           (Index <= Strings.MaxStringLength and
            Index >= Strings.MaxStringLength - 20 and
            Result.Length = Strings.MaxStringLength);
      end loop;

      Result.Text (Index) := Character'Val (Character'Pos ('0') - (V rem 10));

      if N < 0 then
         Index               := Index - 1;
         Result.Text (Index) := '-';
      end if;

      Result := Strings.Substring (Result, Index, Result.Length);
      return Result;
   end Integer_Image;

end Spark.Type_Image;
