
ORIGINAL_FILES = LICENSE Makefile README.md reject.py

reset:
	./reject.py -m ./Makefile

push: reset
	@git add *
	@git commit -m "committed on '`date`' by '`whoami`', hostname = '`hostname`'"
	@git push
