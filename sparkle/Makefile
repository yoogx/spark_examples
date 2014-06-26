bb:
	gnatprove -Pspark.gpr --proof=progressive --report=fail --timeout=10 spark-bubble_sort.adb

spark:
	gnatprove -Pspark.gpr *.ad?

pp:
	gnatpp -Pspark.gpr -rnb

clean:
	gnatclean -Pspark.gpr
	-rm -rf *~

distclean: clean
	-rm -rf gnatprove auto.cgpr
