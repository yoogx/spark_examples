package body Spark.Random with
     Spark_Mode => On is

   M : constant := 397;            -- Period parameter

   Upper_Mask : constant := 16#80000000#;   -- Most significant w-r bits
   Lower_Mask : constant := 16#7FFFFFFF#;   -- Least significant r bits

   -----------
   -- Magic --
   -----------

   function Magic (S : Unsigned_32) return Unsigned_32;
   --  Return magic value for computation in random number generation

   function Magic (S : Unsigned_32) return Unsigned_32 is
   begin
      if (S and 16#1#) = 1 then
         return 16#9908B0DF#;
      else
         return 0;
      end if;
   end Magic;

   ------------
   -- Random --
   ------------

   procedure Random (G : in out Generator; S : out Unsigned_32) is
   begin
      if G.Gen_State.Condition >= N then
         if G.Gen_State.Condition = Invalid then

            --  The generator is not initialized

            Reset (G);
         end if;

         --  Generate a vector of random numbers, and cache them

         for J in 0 .. N - M - 1 loop
            S :=
              (G.Gen_State.Vector_N (J) and Upper_Mask) or
              (G.Gen_State.Vector_N (J + 1) and Lower_Mask);

            G.Gen_State.Vector_N (J) :=
              G.Gen_State.Vector_N (J + M) xor
              Shift_Right (S, 1) xor
              Magic (S);

         end loop;

         for J in N - M .. N - 2 loop
            S :=
              (G.Gen_State.Vector_N (J) and Upper_Mask) or
              (G.Gen_State.Vector_N (J + 1) and Lower_Mask);

            G.Gen_State.Vector_N (J) :=
              G.Gen_State.Vector_N (J + (M - N)) xor
              Shift_Right (S, 1) xor
              Magic (S);

         end loop;

         S :=
           (G.Gen_State.Vector_N (N - 1) and Upper_Mask) or
           (G.Gen_State.Vector_N (0) and Lower_Mask);

         G.Gen_State.Vector_N (N - 1) :=
           G.Gen_State.Vector_N (M - 1) xor Shift_Right (S, 1) xor Magic (S);

         G.Gen_State.Condition := 0;
      end if;

      --  Tempering

      S := G.Gen_State.Vector_N (G.Gen_State.Condition);

      G.Gen_State.Condition := G.Gen_State.Condition + 1;

      S := S xor Shift_Right (S, 11);
      S := S xor (Shift_Left (S, 7) and 16#9D2C5680#);
      S := S xor (Shift_Left (S, 15) and 16#EFC60000#);
      S := S xor Shift_Right (S, 18);

   end Random;

   -----------
   -- Reset --
   -----------

   procedure Reset (G : in out Generator; Seed : Seed_Type := Default_Seed) is
   begin
      G.Gen_State.Seed         := Seed;
      G.Gen_State.Vector_N (0) :=
        Unsigned_32 (G.Gen_State.Seed) and 16#FFFFFFFF#;

      --  See Knuth, "The Art Of Computer Programming" (Vol2. 3rd Ed. p.106)
      --  for multiplier.

      for J in 1 .. N loop
         G.Gen_State.Vector_N (J) :=
           1_812_433_253 *
           (G.Gen_State.Vector_N (J - 1) xor
            Shift_Right (G.Gen_State.Vector_N (J - 1), 30)) +
           Unsigned_32 (J);

         G.Gen_State.Vector_N (J) := G.Gen_State.Vector_N (J) and 16#FFFFFFFF#;
      end loop;

      G.Gen_State.Condition := N;
   end Reset;

end Spark.Random;
