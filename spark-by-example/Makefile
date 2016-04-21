all:
	gnatprove -Pp.gpr -j 2 --proof=progressive --timeout=120 --prover=altergo,cvc4 chap?.adb

pp:
	gnatpp -Pp.gpr -rnb

clean:
	gnatclean -Pp.gpr
	-rm -rf *~

distclean: clean
	-rm -rf gnatprove auto.cgpr
