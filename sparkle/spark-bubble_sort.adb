--  Credits: loop invariants were greatly improved thanks to Yannick
--  Moy explanations and patches.

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

   --  Bubble sort compares each element with its immediate right
   --  neighbor, and swaps them if they are not in ascending
   --  order. The comparison is performed untile all elements are
   --  sorted. The following Wikipedia article provides details on
   --  this algorithm: http://en.wikipedia.org/wiki/Bubble_sort
   --
   --  The algorithm operates as two imbricated loop:
   --  * the inner loop "moves" one element to its top-most position
   --  in the array. It goes forward.
   --  * the outer loop goes backward, considering the last elements
   --  of the array as sorted, it sorts the remaining ones.

   procedure Sort (A : in out T_Arr) is
      Finished : Boolean;
   begin
      Outer : for I in reverse A'First + 1 .. A'Last loop
         Finished := True;

         Inner : for J in A'First .. I - 1 loop
            if A (J) > A (J + 1) then
               Finished := False;
               Swap (A, J, J + 1);
            end if;

            --  (I-1) J+1th element is the greated element in range
            --  A'First .. J

            pragma Loop_Invariant
              (for all K in A'First .. J => A (K) <= A (J + 1));

            --  (I-2) We performed a permutation of A elements

            pragma Loop_Invariant
              (for all K1 in A'First .. I =>
                 (for some K2 in A'First .. I =>
                      A(K1) = A'Loop_Entry(Inner)(K2)));

            --  (I-3) We did not modify elements from I + 1 to A'Last,
            --  hence previously demonstrated properties still hold.

            pragma Loop_Invariant
              (for all K in I+1 .. A'Last =>
                 A(K) = A'Loop_Entry(Inner)(K));

            --  (I-4) If Finished is still true at this stage, it means we
            --  did not need to swap elements, and these are sorted.

            pragma Loop_Invariant
              (if Finished then (for all K in A'First .. J
                                   => A (K) <= A (K + 1)));
         end loop Inner;

         --  (O-1) elements in I .. A'Last are sorted

         pragma Loop_Invariant
           (for all K in I .. A'Last => A (K - 1) <= A (K));

         --  (O-2) We repeat loop inviant (I-1)

         pragma Loop_Invariant
           (for all K in A'First .. I-1 => A(K) <= A (I));

         --  (O-3) We repeat loop invariant (I-4)

         pragma Loop_Invariant
           (if Finished then (for all K in A'First .. I - 1
                                => A (K) <= A (K + 1)));

         exit when Finished;

      end loop Outer;

      --  Here, in all path, but combining (O-1) and (O-3) we can
      --  conclude the array has been sorted.
   end Sort;

end Spark.Bubble_Sort;
