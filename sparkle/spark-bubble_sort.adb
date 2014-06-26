package body Spark.Bubble_Sort with
     Spark_Mode => On is

   ----------
   -- Swap --
   ----------

   procedure Swap (A : in out T_Arr; I : Index; J : Index) with
      Post =>
      (A (I) = A'Old (J) and
       A (J) = A'Old (I) and
       (for all K in A'Range =>
          (if K /= I and K /= J then A (K) = A'Old (K))));

   procedure Swap (A : in out T_Arr; I : Index; J : Index) is
      Temp : T;
   begin
      Temp  := A (I);
      A (I) := A (J);
      A (J) := Temp;
   end Swap;

   ----------
   -- Sort --
   ----------

   procedure Sort (A : in out T_Arr) is
      Finished : Boolean;
   begin
      for I in reverse A'First + 1 .. A'Last loop
         Finished := True;

         for J in A'First .. I - 1 loop
            if A (J + 1) < A (J) then
               Finished := False;
               Swap (A, J, J + 1);
               pragma Assert (A (J) < A (J + 1));
            end if;
            pragma Loop_Invariant
              (for all K in A'First .. J =>
                 (A (K) <= A (J + 1))
                 and then (if Finished then Is_Sorted (A, A'First, J + 1)));

         end loop;
         pragma Assert (A (I - 1) <= A (I));
         pragma Assert (if Finished then Is_Sorted (A, A'First, I));
         pragma Loop_Invariant
           (A (I - 1) <= A (I)
--           );
         and then (for all K in I .. A'Last => A (K - 1) <= A (K)));

         exit when Finished;

      end loop;
   end Sort;

end Spark.Bubble_Sort;
