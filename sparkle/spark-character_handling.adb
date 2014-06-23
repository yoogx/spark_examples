with Ada.Characters.Latin_1;
with Spark.Strings.Maps;
with Spark.Strings.Maps.Constants;

package body Spark.Character_Handling with
     Spark_Mode => On is

   ------------------------------------
   -- Character Classification Table --
   ------------------------------------

   type Character_Flags is mod 256;

   Control   : constant Character_Flags := 1;
   Lower     : constant Character_Flags := 2;
   Upper     : constant Character_Flags := 4;
   Basic     : constant Character_Flags := 8;
   Hex_Digit : constant Character_Flags := 16;
   Digit     : constant Character_Flags := 32;
   Special   : constant Character_Flags := 64;

   Letter   : constant Character_Flags := Lower or Upper;
   Alphanum : constant Character_Flags := Letter or Digit;
   Graphic  : constant Character_Flags := Alphanum or Special;

   type Char_Map_Array is array (Character) of Character_Flags;

   Char_Map : constant Char_Map_Array :=
     Char_Map_Array'
       (Ada.Characters.Latin_1.NUL => Control,
        Ada.Characters.Latin_1.SOH => Control,
        Ada.Characters.Latin_1.STX => Control,
        Ada.Characters.Latin_1.ETX => Control,
        Ada.Characters.Latin_1.EOT => Control,
        Ada.Characters.Latin_1.ENQ => Control,
        Ada.Characters.Latin_1.ACK => Control,
        Ada.Characters.Latin_1.BEL => Control,
        Ada.Characters.Latin_1.BS  => Control,
        Ada.Characters.Latin_1.HT  => Control,
        Ada.Characters.Latin_1.LF  => Control,
        Ada.Characters.Latin_1.VT  => Control,
        Ada.Characters.Latin_1.FF  => Control,
        Ada.Characters.Latin_1.CR  => Control,
        Ada.Characters.Latin_1.SO  => Control,
        Ada.Characters.Latin_1.SI  => Control,

        Ada.Characters.Latin_1.DLE => Control,
        Ada.Characters.Latin_1.DC1 => Control,
        Ada.Characters.Latin_1.DC2 => Control,
        Ada.Characters.Latin_1.DC3 => Control,
        Ada.Characters.Latin_1.DC4 => Control,
        Ada.Characters.Latin_1.NAK => Control,
        Ada.Characters.Latin_1.SYN => Control,
        Ada.Characters.Latin_1.ETB => Control,
        Ada.Characters.Latin_1.CAN => Control,
        Ada.Characters.Latin_1.EM  => Control,
        Ada.Characters.Latin_1.SUB => Control,
        Ada.Characters.Latin_1.ESC => Control,
        Ada.Characters.Latin_1.FS  => Control,
        Ada.Characters.Latin_1.GS  => Control,
        Ada.Characters.Latin_1.RS  => Control,
        Ada.Characters.Latin_1.US  => Control,

        Ada.Characters.Latin_1.Space             => Special,
        Ada.Characters.Latin_1.Exclamation       => Special,
        Ada.Characters.Latin_1.Quotation         => Special,
        Ada.Characters.Latin_1.Number_Sign       => Special,
        Ada.Characters.Latin_1.Dollar_Sign       => Special,
        Ada.Characters.Latin_1.Percent_Sign      => Special,
        Ada.Characters.Latin_1.Ampersand         => Special,
        Ada.Characters.Latin_1.Apostrophe        => Special,
        Ada.Characters.Latin_1.Left_Parenthesis  => Special,
        Ada.Characters.Latin_1.Right_Parenthesis => Special,
        Ada.Characters.Latin_1.Asterisk          => Special,
        Ada.Characters.Latin_1.Plus_Sign         => Special,
        Ada.Characters.Latin_1.Comma             => Special,
        Ada.Characters.Latin_1.Hyphen            => Special,
        Ada.Characters.Latin_1.Full_Stop         => Special,
        Ada.Characters.Latin_1.Solidus           => Special,

        '0' .. '9' => Digit + Hex_Digit,

        Ada.Characters.Latin_1.Colon             => Special,
        Ada.Characters.Latin_1.Semicolon         => Special,
        Ada.Characters.Latin_1.Less_Than_Sign    => Special,
        Ada.Characters.Latin_1.Equals_Sign       => Special,
        Ada.Characters.Latin_1.Greater_Than_Sign => Special,
        Ada.Characters.Latin_1.Question          => Special,
        Ada.Characters.Latin_1.Commercial_At     => Special,

        'A' .. 'F' => Upper + Basic + Hex_Digit,
        'G' .. 'Z' => Upper + Basic,

        Ada.Characters.Latin_1.Left_Square_Bracket  => Special,
        Ada.Characters.Latin_1.Reverse_Solidus      => Special,
        Ada.Characters.Latin_1.Right_Square_Bracket => Special,
        Ada.Characters.Latin_1.Circumflex           => Special,
        Ada.Characters.Latin_1.Low_Line             => Special,
        Ada.Characters.Latin_1.Grave                => Special,

        'a' .. 'f' => Lower + Basic + Hex_Digit,
        'g' .. 'z' => Lower + Basic,

        Ada.Characters.Latin_1.Left_Curly_Bracket  => Special,
        Ada.Characters.Latin_1.Vertical_Line       => Special,
        Ada.Characters.Latin_1.Right_Curly_Bracket => Special,
        Ada.Characters.Latin_1.Tilde               => Special,

        Ada.Characters.Latin_1.DEL          => Control,
        Ada.Characters.Latin_1.Reserved_128 => Control,
        Ada.Characters.Latin_1.Reserved_129 => Control,
        Ada.Characters.Latin_1.BPH          => Control,
        Ada.Characters.Latin_1.NBH          => Control,
        Ada.Characters.Latin_1.Reserved_132 => Control,
        Ada.Characters.Latin_1.NEL          => Control,
        Ada.Characters.Latin_1.SSA          => Control,
        Ada.Characters.Latin_1.ESA          => Control,
        Ada.Characters.Latin_1.HTS          => Control,
        Ada.Characters.Latin_1.HTJ          => Control,
        Ada.Characters.Latin_1.VTS          => Control,
        Ada.Characters.Latin_1.PLD          => Control,
        Ada.Characters.Latin_1.PLU          => Control,
        Ada.Characters.Latin_1.RI           => Control,
        Ada.Characters.Latin_1.SS2          => Control,
        Ada.Characters.Latin_1.SS3          => Control,

        Ada.Characters.Latin_1.DCS => Control,
        Ada.Characters.Latin_1.PU1 => Control,
        Ada.Characters.Latin_1.PU2 => Control,
        Ada.Characters.Latin_1.STS => Control,
        Ada.Characters.Latin_1.CCH => Control,
        Ada.Characters.Latin_1.MW  => Control,
        Ada.Characters.Latin_1.SPA => Control,
        Ada.Characters.Latin_1.EPA => Control,

        Ada.Characters.Latin_1.SOS          => Control,
        Ada.Characters.Latin_1.Reserved_153 => Control,
        Ada.Characters.Latin_1.SCI          => Control,
        Ada.Characters.Latin_1.CSI          => Control,
        Ada.Characters.Latin_1.ST           => Control,
        Ada.Characters.Latin_1.OSC          => Control,
        Ada.Characters.Latin_1.PM           => Control,
        Ada.Characters.Latin_1.APC          => Control,

        Ada.Characters.Latin_1.No_Break_Space              => Special,
        Ada.Characters.Latin_1.Inverted_Exclamation        => Special,
        Ada.Characters.Latin_1.Cent_Sign                   => Special,
        Ada.Characters.Latin_1.Pound_Sign                  => Special,
        Ada.Characters.Latin_1.Currency_Sign               => Special,
        Ada.Characters.Latin_1.Yen_Sign                    => Special,
        Ada.Characters.Latin_1.Broken_Bar                  => Special,
        Ada.Characters.Latin_1.Section_Sign                => Special,
        Ada.Characters.Latin_1.Diaeresis                   => Special,
        Ada.Characters.Latin_1.Copyright_Sign              => Special,
        Ada.Characters.Latin_1.Feminine_Ordinal_Indicator  => Special,
        Ada.Characters.Latin_1.Left_Angle_Quotation        => Special,
        Ada.Characters.Latin_1.Not_Sign                    => Special,
        Ada.Characters.Latin_1.Soft_Hyphen                 => Special,
        Ada.Characters.Latin_1.Registered_Trade_Mark_Sign  => Special,
        Ada.Characters.Latin_1.Macron                      => Special,
        Ada.Characters.Latin_1.Degree_Sign                 => Special,
        Ada.Characters.Latin_1.Plus_Minus_Sign             => Special,
        Ada.Characters.Latin_1.Superscript_Two             => Special,
        Ada.Characters.Latin_1.Superscript_Three           => Special,
        Ada.Characters.Latin_1.Acute                       => Special,
        Ada.Characters.Latin_1.Micro_Sign                  => Special,
        Ada.Characters.Latin_1.Pilcrow_Sign                => Special,
        Ada.Characters.Latin_1.Middle_Dot                  => Special,
        Ada.Characters.Latin_1.Cedilla                     => Special,
        Ada.Characters.Latin_1.Superscript_One             => Special,
        Ada.Characters.Latin_1.Masculine_Ordinal_Indicator => Special,
        Ada.Characters.Latin_1.Right_Angle_Quotation       => Special,
        Ada.Characters.Latin_1.Fraction_One_Quarter        => Special,
        Ada.Characters.Latin_1.Fraction_One_Half           => Special,
        Ada.Characters.Latin_1.Fraction_Three_Quarters     => Special,
        Ada.Characters.Latin_1.Inverted_Question           => Special,

        Ada.Characters.Latin_1.UC_A_Grave       => Upper,
        Ada.Characters.Latin_1.UC_A_Acute       => Upper,
        Ada.Characters.Latin_1.UC_A_Circumflex  => Upper,
        Ada.Characters.Latin_1.UC_A_Tilde       => Upper,
        Ada.Characters.Latin_1.UC_A_Diaeresis   => Upper,
        Ada.Characters.Latin_1.UC_A_Ring        => Upper,
        Ada.Characters.Latin_1.UC_AE_Diphthong  => Upper + Basic,
        Ada.Characters.Latin_1.UC_C_Cedilla     => Upper,
        Ada.Characters.Latin_1.UC_E_Grave       => Upper,
        Ada.Characters.Latin_1.UC_E_Acute       => Upper,
        Ada.Characters.Latin_1.UC_E_Circumflex  => Upper,
        Ada.Characters.Latin_1.UC_E_Diaeresis   => Upper,
        Ada.Characters.Latin_1.UC_I_Grave       => Upper,
        Ada.Characters.Latin_1.UC_I_Acute       => Upper,
        Ada.Characters.Latin_1.UC_I_Circumflex  => Upper,
        Ada.Characters.Latin_1.UC_I_Diaeresis   => Upper,
        Ada.Characters.Latin_1.UC_Icelandic_Eth => Upper + Basic,
        Ada.Characters.Latin_1.UC_N_Tilde       => Upper,
        Ada.Characters.Latin_1.UC_O_Grave       => Upper,
        Ada.Characters.Latin_1.UC_O_Acute       => Upper,
        Ada.Characters.Latin_1.UC_O_Circumflex  => Upper,
        Ada.Characters.Latin_1.UC_O_Tilde       => Upper,
        Ada.Characters.Latin_1.UC_O_Diaeresis   => Upper,

        Ada.Characters.Latin_1.Multiplication_Sign => Special,

        Ada.Characters.Latin_1.UC_O_Oblique_Stroke => Upper,
        Ada.Characters.Latin_1.UC_U_Grave          => Upper,
        Ada.Characters.Latin_1.UC_U_Acute          => Upper,
        Ada.Characters.Latin_1.UC_U_Circumflex     => Upper,
        Ada.Characters.Latin_1.UC_U_Diaeresis      => Upper,
        Ada.Characters.Latin_1.UC_Y_Acute          => Upper,
        Ada.Characters.Latin_1.UC_Icelandic_Thorn  => Upper + Basic,

        Ada.Characters.Latin_1.LC_German_Sharp_S => Lower + Basic,
        Ada.Characters.Latin_1.LC_A_Grave        => Lower,
        Ada.Characters.Latin_1.LC_A_Acute        => Lower,
        Ada.Characters.Latin_1.LC_A_Circumflex   => Lower,
        Ada.Characters.Latin_1.LC_A_Tilde        => Lower,
        Ada.Characters.Latin_1.LC_A_Diaeresis    => Lower,
        Ada.Characters.Latin_1.LC_A_Ring         => Lower,
        Ada.Characters.Latin_1.LC_AE_Diphthong   => Lower + Basic,
        Ada.Characters.Latin_1.LC_C_Cedilla      => Lower,
        Ada.Characters.Latin_1.LC_E_Grave        => Lower,
        Ada.Characters.Latin_1.LC_E_Acute        => Lower,
        Ada.Characters.Latin_1.LC_E_Circumflex   => Lower,
        Ada.Characters.Latin_1.LC_E_Diaeresis    => Lower,
        Ada.Characters.Latin_1.LC_I_Grave        => Lower,
        Ada.Characters.Latin_1.LC_I_Acute        => Lower,
        Ada.Characters.Latin_1.LC_I_Circumflex   => Lower,
        Ada.Characters.Latin_1.LC_I_Diaeresis    => Lower,
        Ada.Characters.Latin_1.LC_Icelandic_Eth  => Lower + Basic,
        Ada.Characters.Latin_1.LC_N_Tilde        => Lower,
        Ada.Characters.Latin_1.LC_O_Grave        => Lower,
        Ada.Characters.Latin_1.LC_O_Acute        => Lower,
        Ada.Characters.Latin_1.LC_O_Circumflex   => Lower,
        Ada.Characters.Latin_1.LC_O_Tilde        => Lower,
        Ada.Characters.Latin_1.LC_O_Diaeresis    => Lower,

        Ada.Characters.Latin_1.Division_Sign => Special,

        Ada.Characters.Latin_1.LC_O_Oblique_Stroke => Lower,
        Ada.Characters.Latin_1.LC_U_Grave          => Lower,
        Ada.Characters.Latin_1.LC_U_Acute          => Lower,
        Ada.Characters.Latin_1.LC_U_Circumflex     => Lower,
        Ada.Characters.Latin_1.LC_U_Diaeresis      => Lower,
        Ada.Characters.Latin_1.LC_Y_Acute          => Lower,
        Ada.Characters.Latin_1.LC_Icelandic_Thorn  => Lower + Basic,
        Ada.Characters.Latin_1.LC_Y_Diaeresis      => Lower);

   ---------------------
   -- Is_Alphanumeric --
   ---------------------

   function Is_Alphanumeric (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Alphanum) /= 0;
   end Is_Alphanumeric;

   --------------
   -- Is_Basic --
   --------------

   function Is_Basic (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Basic) /= 0;
   end Is_Basic;

   ----------------
   -- Is_Control --
   ----------------

   function Is_Control (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Control) /= 0;
   end Is_Control;

   --------------
   -- Is_Digit --
   --------------

   function Is_Digit (Item : Character) return Boolean is
   begin
      return Item in '0' .. '9';
   end Is_Digit;

   ----------------
   -- Is_Graphic --
   ----------------

   function Is_Graphic (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Graphic) /= 0;
   end Is_Graphic;

   --------------------------
   -- Is_Hexadecimal_Digit --
   --------------------------

   function Is_Hexadecimal_Digit (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Hex_Digit) /= 0;
   end Is_Hexadecimal_Digit;

   ----------------
   -- Is_ISO_646 --
   ----------------

   function Is_ISO_646 (Item : Character) return Boolean is
   begin
      return Item in ISO_646;
   end Is_ISO_646;

   --  Note: much more efficient coding of the following function is possible
   --  by testing several 16#80# bits in a complete word in a single operation

   --  function Is_ISO_646 (Item : String) return Boolean is
   --  begin
   --     for J in Item'Range loop
   --        if Item (J) not in ISO_646 then
   --           return False;
   --        end if;
   --     end loop;

   --     return True;
   --  end Is_ISO_646;

   ---------------
   -- Is_Letter --
   ---------------

   function Is_Letter (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Letter) /= 0;
   end Is_Letter;

   --------------
   -- Is_Lower --
   --------------

   function Is_Lower (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Lower) /= 0;
   end Is_Lower;

   ----------------
   -- Is_Special --
   ----------------

   function Is_Special (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Special) /= 0;
   end Is_Special;

   --------------
   -- Is_Upper --
   --------------

   function Is_Upper (Item : Character) return Boolean is
   begin
      return (Char_Map (Item) and Upper) /= 0;
   end Is_Upper;

   --------------
   -- To_Basic --
   --------------

   function To_Basic (Item : Character) return Character is
   begin
      return Strings.Maps.Value (Strings.Maps.Constants.Basic_Map, Item);
   end To_Basic;

   --  function To_Basic (Item : String) return String is
   --     Result : String (1 .. Item'Length);

   --  begin
   --     for J in Item'Range loop
   --        Result (J - (Item'First - 1))
   --          := Strings.Maps.Value
   --          (Strings.Maps.Constants.Basic_Map, Item (J));
   --     end loop;

   --     return Result;
   --  end To_Basic;

   ----------------
   -- To_ISO_646 --
   ----------------

   function To_ISO_646
     (Item       : Character;
      Substitute : ISO_646) return ISO_646
   is
      Result : ISO_646;
   begin
      if Item in ISO_646 then
         Result := Item;
      else
         Result := Substitute;
      end if;

      return Result;
   end To_ISO_646;

   --  function To_ISO_646
   --    (Item       : String;
   --     Substitute : ISO_646) return String
   --  is
   --     Result : String (1 .. Item'Length);

   --  begin
   --     for J in Item'Range loop
   --        if Item (J) in ISO_646 then
   --           Result (J - (Item'First - 1)) := Item (J);
   --        else
   --           Result (J - (Item'First - 1)) := Substitute;
   --        end if;
   --     end loop;

   --     return Result;
   --  end To_ISO_646;

   --------------
   -- To_Lower --
   --------------

   function To_Lower (Item : Character) return Character is
   begin
      return Strings.Maps.Value (Strings.Maps.Constants.Lower_Case_Map, Item);
   end To_Lower;

   --  function To_Lower (Item : String) return String is
   --     Result : String (1 .. Item'Length);

   --  begin
   --     for J in Item'Range loop
   --        Result (J - (Item'First - 1))
   --          := Strings.Maps.Value
   --          (Strings.Maps.Constants.Lower_Case_Map, Item (J));
   --     end loop;

   --     return Result;
   --  end To_Lower;

   --------------
   -- To_Upper --
   --------------

   function To_Upper (Item : Character) return Character is
   begin
      return Strings.Maps.Value (Strings.Maps.Constants.Upper_Case_Map, Item);
   end To_Upper;

   --  function To_Upper
   --    (Item : String) return String
   --  is
   --     Result : String (1 .. Item'Length);

   --  begin
   --     for J in Item'Range loop
   --        Result (J - (Item'First - 1))
   --          := Strings.Maps.Value
   --          (Strings.Maps.Constants.Upper_Case_Map, Item (J));
   --     end loop;

   --     return Result;
   --  end To_Upper;

   ---------------
   -- LowerCase --
   ---------------

   function LowerCase (Str : Strings.SparkString) return Strings.SparkString is
      Res : Strings.SparkString;

   begin
      Res        := Strings.EmptyString;
      Res.Length := Str.Length;

      for J in Strings.Positions range 1 .. Str.Length loop
         Res.Text (J) := To_Lower (Str.Text (J));
      end loop;

      return Res;
   end LowerCase;

   ---------------
   -- UpperCase --
   ---------------

   function UpperCase (Str : Strings.SparkString) return Strings.SparkString is
      Res : Strings.SparkString;
   begin
      Res        := Strings.EmptyString;
      Res.Length := Str.Length;

      for J in Strings.Positions range 1 .. Str.Length loop
         Res.Text (J) := To_Upper (Str.Text (J));
      end loop;

      return Res;
   end UpperCase;

end Spark.Character_Handling;
