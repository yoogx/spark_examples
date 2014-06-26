--  This package provides an implementation of the Bubble sort sorting
--  algorithm.

--  Todo: translate this package in a generic

package Spark.Bubble_Sort with
     Spark_Mode => On is

   type T is new Integer;

   type Index_T is range 0 .. 10;
   subtype Index is Index_T range 1 .. 10;

   type T_Arr is array (Index) of T;

   --  Sort an array in ascending order
   procedure Sort (A : in out T_Arr) with
     Pre  => (A'Last > A'First),
     Post => (Is_Sorted_2 (A, A'First, A'Last));

   --  Predicates for asserting whether an array is sorted
   function Is_Sorted
     (A : T_Arr) return Boolean is
     ((A'Length = 1)
      or else
      (for all J in A'Range =>
         (for all K in J + 1 .. A'Last => A (J) <= A (K))));

   function Is_Sorted_2
     (A       : T_Arr;
      A_Start : Index;
      A_End   : Index) return Boolean is
     ((A_Start >= A_End)
      or else (for all J in A_Start .. A_End - 1 => A (J) <= A (J + 1)));

   function Is_Sorted
     (A       : T_Arr;
      A_Start : Index;
      A_End   : Index) return Boolean is
     ((A_Start >= A_End)
      or else
      (for all J in A_Start .. A_End =>
         (for all K in J + 1 .. A_End => A (J) <= A (K))));


end Spark.Bubble_Sort;
