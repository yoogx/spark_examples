--  This package is a thin binding of C functions defined in the C
--  Reference Manual ISO-IEC ISO/IEC 9899:TC2 standard.

with System;
with Spark.Strings;

package Spark.OS_Lib with
     Spark_Mode => On is

   type size_t is mod 2**System.Word_Size;

   ---------------
   -- <stdio.h> --
   ---------------

   --  XXX Spark does not allow constructions like
   --      type is new System.Address, and
   --  subtype of private types are not allowed either

   function FOpen_Read (Name : Strings.SparkString) return System.Address with
      Global => null;

   function stdout return System.Address with
      Global => null;
   function stderr return System.Address with
      Global => null;
      --  See 7.19.1 of ISO/IEC 9899:TC2

   function fclose (Stream : System.Address) return Integer with
      Global => null;
   pragma Import (C, fclose);
   --  See 7.19.5.1 of ISO/IEC 9899:TC2

   function fopen (Path : String; FMode : String) return System.Address with
      Global => null;
   pragma Import (C, fopen);
   --  See 7.19.5.3 of ISO/IEC 9899:TC2

   function fgetc (stream : System.Address) return Integer with
      Post   => (fgetc'Result >= 0 and fgetc'Result <= 255),
      Global => null;
   pragma Import (C, fgetc);
   --  See 7.19.7.1 of ISO/IEC 9899:TC2

   procedure fputc (C : Integer; Stream : System.Address) with
      Global => null;
   pragma Import (C, fputc);
   --  See 7.19.7.3 of ISO/IEC 9899:TC2

   function feof (stream : System.Address) return Integer with
      Global => null;
   pragma Import (C, feof);
   --  See 7.19.10.2 of ISO/IEC 9899:TC2

   function ferror (stream : System.Address) return Integer with
      Global => null;
   pragma Import (C, ferror);
   --  See 7.19.10.3 of ISO/IEC 9899:TC2

   ----------------
   -- <stdlib.h> --
   ----------------

   procedure OS_Exit (Status : Integer) with
      Global => null;
   pragma Import (C, OS_Exit, "exit");
   pragma No_Return (OS_Exit);
   --  See 7.20.4.3 of ISO/IEC 9899:TC2

end Spark.OS_Lib;
