--  This package is a wrapper on top of the Ada.Command_Line
--  package. It defines the same functions and semantics.

with Spark.Strings;

package Spark.Command_Line with
     Spark_Mode => On is

   function Argument_Count return Natural;
   --  If the external execution environment supports passing arguments to a
   --  program, then Argument_Count returns the number of arguments passed to
   --  the program invoking the function. Otherwise it return 0.

   function Argument (Number : Positive) return Strings.SparkString;
   --  If the external execution environment supports passing arguments to
   --  a program, then Argument returns an implementation-defined value
   --  corresponding to the argument at relative position Number. If Number
   --  is outside the range 1 .. Argument_Count, then Constraint_Error is
   --  propagated.

   function Command_Name return Strings.SparkString;
   --  If the external execution environment supports passing arguments to
   --  a program, then Command_Name returns an implementation-defined value
   --  corresponding to the name of the command invoking the program.
   --  Otherwise Command_Name returns the null string.

   subtype Exit_Status is Integer;

   procedure Set_Exit_Status (Code : Exit_Status);

end Spark.Command_Line;
