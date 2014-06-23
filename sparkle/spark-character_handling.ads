with Spark.Strings;

package Spark.Character_Handling with
     Spark_Mode => On is

   ----------------------------------------
   -- Character Classification Functions --
   ----------------------------------------

   function Is_Control (Item : Character) return Boolean;
   function Is_Graphic (Item : Character) return Boolean;
   function Is_Letter (Item : Character) return Boolean;
   function Is_Lower (Item : Character) return Boolean;
   function Is_Upper (Item : Character) return Boolean;
   function Is_Basic (Item : Character) return Boolean;
   function Is_Digit (Item : Character) return Boolean;
--   function Is_Decimal_Digit     (Item : Character) return Boolean
--     renames Is_Digit;
   function Is_Hexadecimal_Digit (Item : Character) return Boolean;
   function Is_Alphanumeric (Item : Character) return Boolean;
   function Is_Special (Item : Character) return Boolean;

   ---------------------------------------------------
   -- Conversion Functions for Character and String --
   ---------------------------------------------------

   function To_Lower (Item : Character) return Character;
   function To_Upper (Item : Character) return Character;
   function To_Basic (Item : Character) return Character;

   --  function To_Lower (Item : String) return String;
   --  function To_Upper (Item : String) return String;
   --  function To_Basic (Item : String) return String;

   function LowerCase (Str : Strings.SparkString) return Strings.SparkString;
   --  Return the given string with any alphabetic characters
   --  converted to lower case. The length of the returned string is
   --  equal to the length of the input string.

   function UpperCase (Str : Strings.SparkString) return Strings.SparkString;
   --  Return the given string with any alphabetic characters
   --  converted to upper case. The length of the returned string is
   --  equal to the length of the input string.

   ----------------------------------------------------------------------
   -- Classifications of and Conversions Between Character and ISO 646 --
   ----------------------------------------------------------------------

   subtype ISO_646 is Character range Character'Val (0) .. Character'Val (127);

   function Is_ISO_646 (Item : Character) return Boolean;
--   function Is_ISO_646 (Item : String)    return Boolean;

   function To_ISO_646 (Item : Character; Substitute : ISO_646) return ISO_646;

   --  function To_ISO_646
   --    (Item       : String;
   --     Substitute : ISO_646) return String;

end Spark.Character_Handling;
