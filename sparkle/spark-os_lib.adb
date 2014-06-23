with Ada.Characters.Latin_1;

package body Spark.OS_Lib is

   ---------------
   -- Open_Read --
   ---------------

   function FOpen_Read (Name : Strings.SparkString) return System.Address is
      C_Name : String (1 .. Name.Length + 1);
      Mode   : constant String (1 .. 2) := "r" & Ada.Characters.Latin_1.NUL;

   begin
      C_Name (1 .. Name.Length) := Name.Text (1 .. Name.Length);
      C_Name (C_Name'Last)      := Ada.Characters.Latin_1.NUL;
      return fopen (C_Name, Mode);
   end FOpen_Read;

   ------------
   -- stdout --
   ------------

   function stdout return System.Address is
      --  XXX We could certainly defined it as a global variable in
      --  the spec, but this would adds lot of new annotations, to be
      --  assessed .. same for being in the body ..
      function C_Stdout return System.Address;
      pragma Import (C, C_Stdout, "__gnat_constant_stdout");

   begin
      return C_Stdout;
   end stdout;

   ------------
   -- stderr --
   ------------

   function stderr return System.Address is
      --  Note we use a hide annotation since C_Stderdd is not fully
      --  defined in the Ada body.

      function C_Stderr return System.Address;
      pragma Import (C, C_Stderr, "__gnat_constant_stderr");
   begin
      return C_Stderr;
   end stderr;

end Spark.OS_Lib;
