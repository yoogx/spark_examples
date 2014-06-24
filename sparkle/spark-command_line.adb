with Ada.Command_Line;

package body Spark.Command_Line is

   --  This package relies directly on the functions defined in
   --  Ada.Command_Line, thus they are hidden.

   --------------------
   -- Argument_Count --
   --------------------

   function Argument_Count return Natural is
   begin
      return Ada.Command_Line.Argument_Count;
   end Argument_Count;

   --------------
   -- Argument --
   --------------

   function Argument (Number : Positive) return Argument_Result is
      Result_S        : Spark.Strings.SparkString;
      Argument_String : constant String := Ada.Command_Line.Argument (Number);
   begin
      if Argument_String'Length <= Spark.Strings.MaxStringLength
        and then Argument_String'Length >= 0
      then
         Spark.Strings.CopyString (Result_S, Argument_String);
         return Argument_Result'(No_Error, Result_S);
      else
         return Argument_Result'(Error => Invalid_Number);
      end if;
   end Argument;

   ------------------
   -- Command_Name --
   ------------------

   function Command_Name return Spark.Strings.SparkString is
      Result : Spark.Strings.SparkString;
   begin
      Spark.Strings.CopyString (Result, Ada.Command_Line.Command_Name);

      return Result;
   end Command_Name;

   ---------------------
   -- Set_Exit_Status --
   ---------------------

   procedure Set_Exit_Status (Code : Exit_Status) is
   begin
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Exit_Status (Code));
   end Set_Exit_Status;

end Spark.Command_Line;
