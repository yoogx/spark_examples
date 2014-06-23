with Ada.Characters.Latin_1;

package Spark.Strings.Maps with
     Spark_Mode => On is

   --------------------------------
   -- Character Set Declarations --
   --------------------------------

   type Character_Set is array (Character) of Boolean;
   --  Representation for a set of character values:

   Null_Set : constant Character_Set;

   ---------------------------
   -- Constructors for Sets --
   ---------------------------

   type Character_Range is record
      Low  : Character;
      High : Character;
   end record;
   --  Represents Character range Low .. High

   type Character_Ranges is array (Positive range <>) of Character_Range;

   --  function To_Set (Ranges : Character_Ranges) return Character_Set;

   --  function To_Set (Span : Character_Range) return Character_Set;

   --  function To_Ranges (S    : Character_Set)    return Character_Ranges;

   ----------------------------------
   -- Operations on Character Sets --
   ----------------------------------

   function Equal_Op (Left, Right : Character_Set) return Boolean;
   --# return R => R = (Left = Right);

   function Not_Op (Right : Character_Set) return Character_Set;
   --# return R => R = (not Right);

   function And_Op (Left, Right : Character_Set) return Character_Set;
   --# return R => R = (Left and Right);

   function Or_Op (Left, Right : Character_Set) return Character_Set;
   --# return R => R = (Left or Right);

   function Xor_Op (Left, Right : Character_Set) return Character_Set;
   --# return R => R = (Left xor Right);

   function Minus_Op (Left, Right : Character_Set) return Character_Set;
   --# return R => R = (Left and not Right);

   function Is_In (Elt : Character; S : Character_Set) return Boolean;

   function Is_Subset (Elts : Character_Set; S : Character_Set) return Boolean;

   --  function "<="
   --    (Left  : Character_Set;
   --     Right : Character_Set) return  Boolean
   --  renames Is_Subset;

   --  subtype Character_Sequence is String;
   --  Alternative representation for a set of character values

   --  function To_Set (Seq : Character_Sequence) return Character_Set;
   --  function To_Set (Singleton : Character) return Character_Set;

   --  function To_Sequence (S : Character_Set) return Character_Sequence;

   ------------------------------------
   -- Character Mapping Declarations --
   ------------------------------------

   type Character_Mapping is private;
   pragma Preelaborable_Initialization (Character_Mapping);
   --  Representation for a character to character mapping:

   function Value (Map : Character_Mapping; Elt : Character) return Character;

   Identity : constant Character_Mapping;

   ----------------------------
   -- Operations on Mappings --
   ----------------------------

   --  function To_Mapping
   --    (Frm, To : Character_Sequence)
   --     return    Character_Mapping;

   --  function To_Domain
   --    (Map : Character_Mapping) return Character_Sequence;

   --  function To_Range
   --    (Map : Character_Mapping) return Character_Sequence;

private
   pragma Inline (Is_In);
   pragma Inline (Value);

   Null_Set : constant Character_Set := Character_Set'(others => False);

   type Character_Mapping is array (Character) of Character;

   Identity : constant Character_Mapping :=
     Character_Mapping'
       (Ada.Characters.Latin_1.NUL,  --  NUL      0
        Ada.Characters.Latin_1.SOH,  --  SOH      1
        Ada.Characters.Latin_1.STX,  --  STX      2
        Ada.Characters.Latin_1.ETX,  --  ETX      3
        Ada.Characters.Latin_1.EOT,  --  EOT      4
        Ada.Characters.Latin_1.ENQ,  --  ENQ      5
        Ada.Characters.Latin_1.ACK,  --  ACK      6
        Ada.Characters.Latin_1.BEL,  --  BEL      7
        Ada.Characters.Latin_1.BS,  --  BS       8
        Ada.Characters.Latin_1.HT,  --  HT       9
        Ada.Characters.Latin_1.LF,  --  LF      10
        Ada.Characters.Latin_1.VT,  --  VT      11
        Ada.Characters.Latin_1.FF,  --  FF      12
        Ada.Characters.Latin_1.CR,  --  CR      13
        Ada.Characters.Latin_1.SO,  --  SO      14
        Ada.Characters.Latin_1.SI,  --  SI      15
        Ada.Characters.Latin_1.DLE,  --  DLE     16
        Ada.Characters.Latin_1.DC1,  --  DC1     17
        Ada.Characters.Latin_1.DC2,  --  DC2     18
        Ada.Characters.Latin_1.DC3,  --  DC3     19
        Ada.Characters.Latin_1.DC4,  --  DC4     20
        Ada.Characters.Latin_1.NAK,  --  NAK     21
        Ada.Characters.Latin_1.SYN,  --  SYN     22
        Ada.Characters.Latin_1.ETB,  --  ETB     23
        Ada.Characters.Latin_1.CAN,  --  CAN     24
        Ada.Characters.Latin_1.EM,  --  EM      25
        Ada.Characters.Latin_1.SUB,  --  SUB     26
        Ada.Characters.Latin_1.ESC,  --  ESC     27
        Ada.Characters.Latin_1.FS,  --  FS      28
        Ada.Characters.Latin_1.GS,  --  GS      29
        Ada.Characters.Latin_1.RS,  --  RS      30
        Ada.Characters.Latin_1.US,  --  US      31
        Ada.Characters.Latin_1.Space,  --  ' '     32
        Ada.Characters.Latin_1.Exclamation,  --  '!'     33
        Ada.Characters.Latin_1.Quotation,  --  '"'     34
        Ada.Characters.Latin_1.Number_Sign,  --  '#'     35
        Ada.Characters.Latin_1.Dollar_Sign,  --  '$'     36
        Ada.Characters.Latin_1.Percent_Sign,  --  '%'     37
        Ada.Characters.Latin_1.Ampersand,  --  ','     38
        Ada.Characters.Latin_1.Apostrophe,  --  '''     39
        Ada.Characters.Latin_1.Left_Parenthesis,  --  '('     40
        Ada.Characters.Latin_1.Right_Parenthesis,  --  ')'     41
        Ada.Characters.Latin_1.Asterisk,  --  '*'     42
        Ada.Characters.Latin_1.Plus_Sign,  --  '+'     43
        Ada.Characters.Latin_1.Comma,  --  ','     44
        Ada.Characters.Latin_1.Hyphen,  --  '-'     45
        Ada.Characters.Latin_1.Full_Stop,  --  '.'     46
        Ada.Characters.Latin_1.Solidus,  --  '/'     47
        '0',  --  '0'     48
        '1',  --  '1'     49
        '2',  --  '2'     50
        '3',  --  '3'     51
        '4',  --  '4'     52
        '5',  --  '5'     53
        '6',  --  '6'     54
        '7',  --  '7'     55
        '8',  --  '8'     56
        '9',  --  '9'     57
        Ada.Characters.Latin_1.Colon,  --  ':'     58
        Ada.Characters.Latin_1.Semicolon,  --  ';'     59
        Ada.Characters.Latin_1.Less_Than_Sign,  --  '<'     60
        Ada.Characters.Latin_1.Equals_Sign,  --  '='     61
        Ada.Characters.Latin_1.Greater_Than_Sign,  --  '>'     62
        Ada.Characters.Latin_1.Question,  --  '?'     63
        Ada.Characters.Latin_1.Commercial_At,  --  '@'     64
        'A',  --  'A'     65
        'B',  --  'B'     66
        'C',  --  'C'     67
        'D',  --  'D'     68
        'E',  --  'E'     69
        'F',  --  'F'     70
        'G',  --  'G'     71
        'H',  --  'H'     72
        'I',  --  'I'     73
        'J',  --  'J'     74
        'K',  --  'K'     75
        'L',  --  'L'     76
        'M',  --  'M'     77
        'N',  --  'N'     78
        'O',  --  'O'     79
        'P',  --  'P'     80
        'Q',  --  'Q'     81
        'R',  --  'R'     82
        'S',  --  'S'     83
        'T',  --  'T'     84
        'U',  --  'U'     85
        'V',  --  'V'     86
        'W',  --  'W'     87
        'X',  --  'X'     88
        'Y',  --  'Y'     89
        'Z',  --  'Z'     90
        Ada.Characters.Latin_1.Left_Square_Bracket,  --  '['     91
        Ada.Characters.Latin_1.Reverse_Solidus,  --  '\'     92
        Ada.Characters.Latin_1.Right_Square_Bracket,  --  ']'     93
        Ada.Characters.Latin_1.Circumflex,  --  '^'     94
        Ada.Characters.Latin_1.Low_Line,  --  '_'     95
        Ada.Characters.Latin_1.Grave,  --  '`'     96
        Ada.Characters.Latin_1.LC_A,  --  'a'     97
        Ada.Characters.Latin_1.LC_B,  --  'b'     98
        Ada.Characters.Latin_1.LC_C,  --  'c'     99
        Ada.Characters.Latin_1.LC_D,  --  'd'    100
        Ada.Characters.Latin_1.LC_E,  --  'e'    101
        Ada.Characters.Latin_1.LC_F,  --  'f'    102
        Ada.Characters.Latin_1.LC_G,  --  'g'    103
        Ada.Characters.Latin_1.LC_H,  --  'h'    104
        Ada.Characters.Latin_1.LC_I,  --  'i'    105
        Ada.Characters.Latin_1.LC_J,  --  'j'    106
        Ada.Characters.Latin_1.LC_K,  --  'k'    107
        Ada.Characters.Latin_1.LC_L,  --  'l'    108
        Ada.Characters.Latin_1.LC_M,  --  'm'    109
        Ada.Characters.Latin_1.LC_N,  --  'n'    110
        Ada.Characters.Latin_1.LC_O,  --  'o'    111
        Ada.Characters.Latin_1.LC_P,  --  'p'    112
        Ada.Characters.Latin_1.LC_Q,  --  'q'    113
        Ada.Characters.Latin_1.LC_R,  --  'r'    114
        Ada.Characters.Latin_1.LC_S,  --  's'    115
        Ada.Characters.Latin_1.LC_T,  --  't'    116
        Ada.Characters.Latin_1.LC_U,  --  'u'    117
        Ada.Characters.Latin_1.LC_V,  --  'v'    118
        Ada.Characters.Latin_1.LC_W,  --  'w'    119
        Ada.Characters.Latin_1.LC_X,  --  'x'    120
        Ada.Characters.Latin_1.LC_Y,  --  'y'    121
        Ada.Characters.Latin_1.LC_Z,  --  'z'    122
        Ada.Characters.Latin_1.Left_Curly_Bracket,  --  '{'    123
        Ada.Characters.Latin_1.Vertical_Line,  --  '|'    124
        Ada.Characters.Latin_1.Right_Curly_Bracket,  --  '}'    125
        Ada.Characters.Latin_1.Tilde,  --  '~'    126
        Ada.Characters.Latin_1.DEL,  --  DEL    127
        Ada.Characters.Latin_1.Reserved_128,  --  Reserved_128
   --  128
        Ada.Characters.Latin_1.Reserved_129,  --  Reserved_129
   --  129
        Ada.Characters.Latin_1.BPH,  --  BPH    130
        Ada.Characters.Latin_1.NBH,  --  NBH    131
        Ada.Characters.Latin_1.Reserved_132,  --  Reserved_132
   --  132
        Ada.Characters.Latin_1.NEL,  --  NEL    133
        Ada.Characters.Latin_1.SSA,  --  SSA    134
        Ada.Characters.Latin_1.ESA,  --  ESA    135
        Ada.Characters.Latin_1.HTS,  --  HTS    136
        Ada.Characters.Latin_1.HTJ,  --  HTJ    137
        Ada.Characters.Latin_1.VTS,  --  VTS    138
        Ada.Characters.Latin_1.PLD,  --  PLD    139
        Ada.Characters.Latin_1.PLU,  --  PLU    140
        Ada.Characters.Latin_1.RI,  --  RI     141
        Ada.Characters.Latin_1.SS2,  --  SS2    142
        Ada.Characters.Latin_1.SS3,  --  SS3    143
        Ada.Characters.Latin_1.DCS,  --  DCS    144
        Ada.Characters.Latin_1.PU1,  --  PU1    145
        Ada.Characters.Latin_1.PU2,  --  PU2    146
        Ada.Characters.Latin_1.STS,  --  STS    147
        Ada.Characters.Latin_1.CCH,  --  CCH    148
        Ada.Characters.Latin_1.MW,  --  MW     149
        Ada.Characters.Latin_1.SPA,  --  SPA    150
        Ada.Characters.Latin_1.EPA,  --  EPA    151
        Ada.Characters.Latin_1.SOS,  --  SOS    152
        Ada.Characters.Latin_1.Reserved_153,  --  Reserved_153
   --  153
        Ada.Characters.Latin_1.SCI,  --  SCI    154
        Ada.Characters.Latin_1.CSI,  --  CSI    155
        Ada.Characters.Latin_1.ST,  --  ST     156
        Ada.Characters.Latin_1.OSC,  --  OSC    157
        Ada.Characters.Latin_1.PM,  --  PM     158
        Ada.Characters.Latin_1.APC,  --  APC    159
        Ada.Characters.Latin_1.No_Break_Space,   --  No_Break_Space
   --  160
        Ada.Characters.Latin_1.Inverted_Exclamation, --  Inverted_Exclamation
   --  161
        Ada.Characters.Latin_1.Cent_Sign,  --  Cent_Sign   162
        Ada.Characters.Latin_1.Pound_Sign,    --  Pound_Sign
   --  163
        Ada.Characters.Latin_1.Currency_Sign,    --  Currency_Sign 164
        Ada.Characters.Latin_1.Yen_Sign,  --  Yen_Sign  165
        Ada.Characters.Latin_1.Broken_Bar,    --  Broken_Bar
   --  166
        Ada.Characters.Latin_1.Section_Sign,  --  Section_Sign
   --  167
        Ada.Characters.Latin_1.Diaeresis,  --  Diaeresis             168
        Ada.Characters.Latin_1.Copyright_Sign,   --  Copyright_Sign
   --  169
        Ada.Characters.Latin_1.Feminine_Ordinal_Indicator,
   --  Feminine_Ordina l _Indicator 170

        Ada.Characters.Latin_1.Left_Angle_Quotation,
   --  Left_Angle_Quotation 171

        Ada.Characters.Latin_1.Not_Sign,
   --  Not_Sign                      172
        Ada.Characters.Latin_1.Soft_Hyphen,   --  Soft_Hyphen
   --  173
        Ada.Characters.Latin_1.Registered_Trade_Mark_Sign,
   --  Registered_Trad e _Mark_Sign 174

        Ada.Characters.Latin_1.Macron,  --  Macron 175
        Ada.Characters.Latin_1.Degree_Sign,   --  Degree_Sign
   --  176
        Ada.Characters.Latin_1.Plus_Minus_Sign,  --  Plus_Minus_Sign
   --  177
        Ada.Characters.Latin_1.Superscript_Two,  --  Superscript_Two
   --  178
        Ada.Characters.Latin_1.Superscript_Three,   --  Superscript_Three
   --  179
        Ada.Characters.Latin_1.Acute,  --  Acute  180
        Ada.Characters.Latin_1.Micro_Sign,    --  Micro_Sign
   --  181
        Ada.Characters.Latin_1.Pilcrow_Sign,  --  Pilcrow_Sign
   --  182
        Ada.Characters.Latin_1.Middle_Dot,    --  Middle_Dot
   --  183
        Ada.Characters.Latin_1.Cedilla,  --  Cedilla                       184
        Ada.Characters.Latin_1.Superscript_One,  --  Superscript_One
   --  185
        Ada.Characters.Latin_1.Masculine_Ordinal_Indicator,
   --  Masculine_Ordin a l_Indicator 186

        Ada.Characters.Latin_1.Right_Angle_Quotation,
   --  Right_Angle_Quotation 187
        Ada.Characters.Latin_1.Fraction_One_Quarter,
   --  Fraction_One_Quarter 188

        Ada.Characters.Latin_1.Fraction_One_Half,
   --  Fraction_One_Half 189

        Ada.Characters.Latin_1.Fraction_Three_Quarters,
   --  Fraction_Three_Qua r ters 190

        Ada.Characters.Latin_1.Inverted_Question,   --  Inverted_Question
   --  191
        Ada.Characters.Latin_1.UC_A_Grave,    --  UC_A_Grave
   --  192
        Ada.Characters.Latin_1.UC_A_Acute,    --  UC_A_Acute
   --  193
        Ada.Characters.Latin_1.UC_A_Circumflex,  --  UC_A_Circumflex
   --  194
        Ada.Characters.Latin_1.UC_A_Tilde,    --  UC_A_Tilde
   --  195
        Ada.Characters.Latin_1.UC_A_Diaeresis,   --  UC_A_Diaeresis
   --  196
        Ada.Characters.Latin_1.UC_A_Ring,  --  UC_A_Ring 197
        Ada.Characters.Latin_1.UC_AE_Diphthong,  --  UC_AE_Diphthong
   --  198
        Ada.Characters.Latin_1.UC_C_Cedilla,  --  UC_C_Cedilla
   --  199
        Ada.Characters.Latin_1.UC_E_Grave,    --  UC_E_Grave
   --  200
        Ada.Characters.Latin_1.UC_E_Acute,    --  UC_E_Acute
   --  201
        Ada.Characters.Latin_1.UC_E_Circumflex,  --  UC_E_Circumflex
   --  202
        Ada.Characters.Latin_1.UC_E_Diaeresis,   --  UC_E_Diaeresis
   --  203
        Ada.Characters.Latin_1.UC_I_Grave,    --  UC_I_Grave
   --  204
        Ada.Characters.Latin_1.UC_I_Acute,    --  UC_I_Acute
   --  205
        Ada.Characters.Latin_1.UC_I_Circumflex,  --  UC_I_Circumflex
   --  206
        Ada.Characters.Latin_1.UC_I_Diaeresis,   --  UC_I_Diaeresis
   --  207
        Ada.Characters.Latin_1.UC_Icelandic_Eth,    --  UC_Icelandic_Eth
   --  208
        Ada.Characters.Latin_1.UC_N_Tilde,    --  UC_N_Tilde
   --  209
        Ada.Characters.Latin_1.UC_O_Grave,    --  UC_O_Grave
   --  210
        Ada.Characters.Latin_1.UC_O_Acute,    --  UC_O_Acute
   --  211
        Ada.Characters.Latin_1.UC_O_Circumflex,  --  UC_O_Circumflex
   --  212
        Ada.Characters.Latin_1.UC_O_Tilde,    --  UC_O_Tilde
   --  213
        Ada.Characters.Latin_1.UC_O_Diaeresis,   --  UC_O_Diaeresis
   --  214
        Ada.Characters.Latin_1.Multiplication_Sign,    --  Multiplication_Sign
   --  215
        Ada.Characters.Latin_1.UC_O_Oblique_Stroke,    --  UC_O_Oblique_Stroke
   --  216
        Ada.Characters.Latin_1.UC_U_Grave,    --  UC_U_Grave
   --  217
        Ada.Characters.Latin_1.UC_U_Acute,    --  UC_U_Acute
   --  218
        Ada.Characters.Latin_1.UC_U_Circumflex,  --  UC_U_Circumflex
   --  219
        Ada.Characters.Latin_1.UC_U_Diaeresis,   --  UC_U_Diaeresis
   --  220
        Ada.Characters.Latin_1.UC_Y_Acute,    --  UC_Y_Acute
   --  221
        Ada.Characters.Latin_1.UC_Icelandic_Thorn,  --  UC_Icelandic_Thorn
   --  222
        Ada.Characters.Latin_1.LC_German_Sharp_S,   --  LC_German_Sharp_S
   --  223
        Ada.Characters.Latin_1.LC_A_Grave,    --  LC_A_Grave
   --  224
        Ada.Characters.Latin_1.LC_A_Acute,    --  LC_A_Acute
   --  225
        Ada.Characters.Latin_1.LC_A_Circumflex,  --  LC_A_Circumflex
   --  226
        Ada.Characters.Latin_1.LC_A_Tilde,    --  LC_A_Tilde
   --  227
        Ada.Characters.Latin_1.LC_A_Diaeresis,   --  LC_A_Diaeresis
   --  228
        Ada.Characters.Latin_1.LC_A_Ring,  --  LC_A_Ring 229
        Ada.Characters.Latin_1.LC_AE_Diphthong,  --  LC_AE_Diphthong
   --  230
        Ada.Characters.Latin_1.LC_C_Cedilla,  --  LC_C_Cedilla
   --  231
        Ada.Characters.Latin_1.LC_E_Grave,    --  LC_E_Grave
   --  232
        Ada.Characters.Latin_1.LC_E_Acute,    --  LC_E_Acute
   --  233
        Ada.Characters.Latin_1.LC_E_Circumflex,  --  LC_E_Circumflex
   --  234
        Ada.Characters.Latin_1.LC_E_Diaeresis,   --  LC_E_Diaeresis
   --  235
        Ada.Characters.Latin_1.LC_I_Grave,    --  LC_I_Grave
   --  236
        Ada.Characters.Latin_1.LC_I_Acute,    --  LC_I_Acute
   --  237
        Ada.Characters.Latin_1.LC_I_Circumflex,  --  LC_I_Circumflex
   --  238
        Ada.Characters.Latin_1.LC_I_Diaeresis,   --  LC_I_Diaeresis
   --  239
        Ada.Characters.Latin_1.LC_Icelandic_Eth,    --  LC_Icelandic_Eth
   --  240
        Ada.Characters.Latin_1.LC_N_Tilde,    --  LC_N_Tilde
   --  241
        Ada.Characters.Latin_1.LC_O_Grave,    --  LC_O_Grave
   --  242
        Ada.Characters.Latin_1.LC_O_Acute,    --  LC_O_Acute
   --  243
        Ada.Characters.Latin_1.LC_O_Circumflex,  --  LC_O_Circumflex
   --  244
        Ada.Characters.Latin_1.LC_O_Tilde,    --  LC_O_Tilde
   --  245
        Ada.Characters.Latin_1.LC_O_Diaeresis,   --  LC_O_Diaeresis
   --  246
        Ada.Characters.Latin_1.Division_Sign,    --  Division_Sign
   --  247
        Ada.Characters.Latin_1.LC_O_Oblique_Stroke,    --  LC_O_Oblique_Stroke
   --  248
        Ada.Characters.Latin_1.LC_U_Grave,    --  LC_U_Grave
   --  249
        Ada.Characters.Latin_1.LC_U_Acute,    --  LC_U_Acute
   --  250
        Ada.Characters.Latin_1.LC_U_Circumflex,  --  LC_U_Circumflex
   --  251
        Ada.Characters.Latin_1.LC_U_Diaeresis,   --  LC_U_Diaeresis
   --  252
        Ada.Characters.Latin_1.LC_Y_Acute,    --  LC_Y_Acute
   --  253
        Ada.Characters.Latin_1.LC_Icelandic_Thorn,  --  LC_Icelandic_Thorn
   --  254
        Ada.Characters.Latin_1.LC_Y_Diaeresis); --  LC_Y_Diaeresis
   --  255

end Spark.Strings.Maps;
