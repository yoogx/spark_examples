--  This package provides an implementation of the Mersenne Twister,
--  MT19937 random generator for 32-bits machines, designed by Makoto
--  Matsumoto and Takuji Nishimura
--
--  See http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html for
--  details and licence information.
--
--  Note: this code originates from PolyORB, its API has been slightly
--  adapted to SPARK2014.

with Interfaces; use Interfaces;

package Spark.Random with
     Spark_Mode => On is

   type Generator is limited private;

   type Seed_Type is new Unsigned_32;

   Default_Seed : constant Seed_Type;

   procedure Random (G : in out Generator; S : out Unsigned_32);

   procedure Reset (G : in out Generator; Seed : Seed_Type := Default_Seed);

private

   N : constant := 624; -- Length of state vector

   Invalid : constant := N + 1;

   type Vector is array (0 .. N) of Unsigned_32;

   type State is record
      Vector_N  : Vector    := (others => 0);
      Condition : Natural   := Invalid;
      Seed      : Seed_Type := Default_Seed;
   end record;

   type Generator is limited record
      Gen_State : State;
   end record;

   Default_Seed : constant Seed_Type := 19_650_218;

end Spark.Random;
