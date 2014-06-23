with Spark.Strings;

package Spark.Type_Image with
     Spark_Mode => On is

   function Boolean_Image (N : Boolean) return Strings.SparkString;
   --  Return Boolean'Image (N)

   function Integer_Image (N : Integer) return Strings.SparkString;
   --  Return a string that corresponds to Integer'Image (N), adapted
   --  from GNAT's System.Img_Int.Image_Integer.

end Spark.Type_Image;
