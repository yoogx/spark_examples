spark:
	gnatprove -Pspark.gpr *.ad?

pp:
	gnatpp -Pspark.gpr -rnb

clean:
	gnatclean -Pspark.gpr
	-rm -rf *~

distclean: clean
	-rm -rf gnatprove auto.cgpr
