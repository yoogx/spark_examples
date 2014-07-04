spark:
	gnatprove -Pspark.gpr -j 8 --proof=progressive --report=statistics --timeout=120 *.ad?

pp:
	gnatpp -Pspark.gpr -rnb

clean:
	gnatclean -Pspark.gpr
	-rm -rf *~

distclean: clean
	-rm -rf gnatprove auto.cgpr spark-loc.xml gnatinspect.db
