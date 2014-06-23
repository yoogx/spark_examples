package Spark.Strings with
     Spark_Mode => On is

   subtype Lengths is Integer range 0 .. 255;
   MaxStringLength : constant Lengths := Lengths'Last;
   subtype Positions is Lengths range 1 .. MaxStringLength;
   subtype StringText is String (Positions);

   type SparkString is record
      Length : Lengths;
      Text   : StringText;
   end record;

   EmptyString : constant SparkString :=
     SparkString'(Length => 0, Text => StringText'(Positions => ' '));

   procedure AppendChar
     (Str     : in out SparkString;
      Ch      :        Character;
      Success :    out Boolean) with
      Post =>
      ((Str'Old.Length = MaxStringLength and Success = False) or
       (Str'Old.Length < MaxStringLength and
        (Success and
         Str.Length = Str'Old.Length + 1 and
         Str.Text (Str.Length) = Ch)));

   function Substring
     (Str  : SparkString;
      Pos1 : Positions;
      Pos2 : Positions) return SparkString with
      Pre  => (Pos2 <= Str.Length and Pos1 <= Str.Length),
      Post =>
      ((Pos2 - Pos1 < 0 and Substring'Result.Length = 0) or
       (Substring'Result.Length = Str.Length and
        (for all J in
           Positions range Positions'First .. Substring'Result.Length =>
           (Substring'Result.Text (J) = Str.Text (J)))) or
       (Substring'Result.Length = (Pos2 - Pos1) + Positions'First and
        (for all J in Positions'First .. Substring'Result.Length =>
           (Substring'Result.Text (J) = Str.Text (Pos1 + J - 1)))));
      --  Return the substring of Str starting at Pos1 and ending at (and
      --  including) Pos2
      --  XXX GNATProve GPL 2014

   procedure CopyString (DestStr : out SparkString; SrcStr : String) with
      Pre  => (SrcStr'Length <= MaxStringLength and SrcStr'Length >= 0),
      Post =>
      (DestStr.Length = SrcStr'Length and
       DestStr.Text (1 .. SrcStr'Length) = SrcStr);
      --  XXX GNATProve GPL 2014

end Spark.Strings;
