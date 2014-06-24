--  This package is a wrapper on top of the Ada.Command_Line
--  package. It defines the same functions and semantics.

with Spark.Strings;

package Spark.Command_Line with
     Spark_Mode => On is

   function Argument_Count return Natural;
   --  If the external execution environment supports passing arguments to a
   --  program, then Argument_Count returns the number of arguments passed to
   --  the program invoking the function. Otherwise it return 0.

   type Argument_Error is (No_Error, Invalid_Number);

   type Argument_Result (Error: Argument_Error) is
     record
        case Error is
           when No_Error =>
              The_Argument : Strings.SparkString;
           when Invalid_Number =>
              null;
       end case;
     end record;

   function Argument (Number : Positive) return Argument_Result;
   --  If the external execution environment supports passing arguments to
   --  a program, then Argument returns an implementation-defined value
   --  corresponding to the argument at relative position Number. If Number
   --  is outside the range 1 .. Argument_Count, then an invalid result
   --  is returned.

   function Command_Name return Strings.SparkString;
   --  If the external execution environment supports passing arguments to
   --  a program, then Command_Name returns an implementation-defined value
   --  corresponding to the name of the command invoking the program.
   --  Otherwise Command_Name returns the null string.

   subtype Exit_Status is Integer;

   procedure Set_Exit_Status (Code : Exit_Status);

end Spark.Command_Line;
