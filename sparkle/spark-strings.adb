package body Spark.Strings with
     Spark_Mode => On is

   ----------------
   -- CopyString --
   ----------------

   procedure CopyString (DestStr : out SparkString; SrcStr : String) is
   begin
      DestStr.Length                    := SrcStr'Length;
      DestStr.Text (1 .. SrcStr'Length) := SrcStr; --   XXX GNATProve GPL2014
   end CopyString;

   ---------------
   -- AppenChar --
   ---------------

   procedure AppendChar
     (Str     : in out SparkString;
      Ch      :        Character;
      Success :    out Boolean)
   is
      ResultString : StringText;
      ResultLength : Lengths;
   begin
      ResultString := Str.Text;
      ResultLength := Str.Length;

      if ResultLength < MaxStringLength then
         Success                     := True;
         ResultLength                := ResultLength + 1;
         ResultString (ResultLength) := Ch;
      else
         Success := False;
      end if;

      Str.Text   := ResultString;
      Str.Length := ResultLength;
   end AppendChar;

   ---------------
   -- Substring --
   ---------------

   function Substring
     (Str  : SparkString;
      Pos1 : Positions;
      Pos2 : Positions) return SparkString
   is
      NewString : SparkString;
      Buffer    : StringText;
      BLen      : Positions;
      J         : Positions;
   begin
      if Pos2 - Pos1 < 0 then
         --# assert Pos2 - Pos1 < 0;
         NewString := EmptyString;
         --  Overides the EmptyString length
         NewString.Length := 0;

      else
         --# assert Pos2 - Pos1 >= 0;
         BLen := (Pos2 - Pos1) + Positions'First;

         if BLen >= Str.Length then
            --# assert BLen >= Str.Length
            --#    and BLen = Pos2 - Pos1 + Positions'First;
            NewString := Str;

         else
            --# assert BLen < Str.Length
            --#    and BLen > 0
            --#    and BLen = Pos2 - Pos1 + Positions'First;
            Buffer := StringText'(others => ' ');

            J := Positions'First;
            loop
            --# assert BLen < Str.Length
            --#    and J <= BLen + Positions'First
            --#    and BLen = Pos2 - Pos1 + Positions'First;
               exit when J > BLen;

               --# assert J <= BLen
               --#    and BLen < Str.Length
               --#    and BLen = Pos2 - Pos1 + Positions'First
               --#    and Pos1 + (J - Positions'First) in Positions;

               Buffer (J) := Str.Text (Pos1 + (J - Positions'First));
               J          := J + 1;
            end loop;

            NewString := SparkString'(Length => BLen, Text => Buffer);
         end if;
      end if;

      return NewString;
   end Substring;

end Spark.Strings;
