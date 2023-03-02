
ORIGINAL_FILES = LICENSE Makefile README.md reject.py

define REJECT
#!/usr/bin/env python\import os;\import sys;\\SEP = os.sep;\ignored = ['.', '..', '.git', __file__]\MAGIC_WORD = 'ORIGINAL_FILES='\\def find(dirname):\	ret = [];\	try:\		for basename in os.listdir(dirname):\			filename = dirname + SEP + basename;\			if (basename in ignored):\				continue ;\			ret.append(filename);\			ret += find(filename);\	except:\		pass\	return (ret);\\def dirnameof(filename):\	while (SEP + SEP in filename):\		filename = filename.replace(SEP + SEP, SEP);\	while (filename.startswith('.' + SEP)):\		filename = filename[1 + len(SEP):];\	while (filename.endswith(SEP)):\		filename = filename[:-len(SEP)]\	if (not(SEP in filename)):\		return (os.getcwd());\	dirname = filename[:-len(filename.split(SEP)[-1])]\	return (dirname);\\def remove_duplicates(mylist):\	return (list(dict.fromkeys(mylist)))\\def removefiles(x):\	x = remove_duplicates(x);\	while (x):\		if ('' in x):\			x.remove('')\		i = 0;\		while (i < len(x)):\			file = x[i];\			if (not (file) or not (os.path.exists(file))):\				x[i] = '';\				i = i + 1;\				continue ;\			try:\				os.unlink(file);\			except:\				try:\					os.remove(file);\				except:\					try:\						os.rmdir(file);\					except:\						pass ;\			if (not (os.path.exists(file))):\				print ('remove(\'' + file + '\')');\				x[i] = '';\			i = i + 1;\\def fix_filename(filename, work_dir):\	filename = filename.strip();\	if (not filename):\		return ('');\	if (not filename.startswith(SEP)):\		filename = work_dir + SEP + filename;\	while (SEP+SEP in filename):\		filename = filename.replace(SEP+SEP, SEP);\	while (filename.endswith(SEP)):\		filename = filename[:-1];\	if ('.git' in ignored):\		if (SEP + '.git' + SEP in filename):\			return ('');\		if (filename.startswith('.git' + SEP)):\			return ('');\	if (filename in ignored):\		return ('');\	return (filename);\\def fix_files(files, work_dir):\	nfiles = [];\	for file in files:\		file = fix_filename(file, work_dir).strip();\		if (file):\			nfiles.append(file);\	return (nfiles);\\def reject_files(ofiles, work_dir = os.getcwd()):\	ofiles = ofiles.strip();\	if not(ofiles):\		return ;\	for i in '\r\t\n\f\b':\		ofiles = ofiles.replace(i, ' ');\	while ('  ' in ofiles):\		ofiles = ofiles.replace('  ', ' ');\	ofiles = ofiles.strip();\	ofiles = ofiles.split(' ');\	ofiles = fix_files(ofiles, work_dir);\	rejected = fix_files(find(work_dir), work_dir);\	for file in ofiles:\		file = fix_filename(file, work_dir);\		if (not file):\			continue ;\		# khask t rejecti filename o dirname dyal o dirname dyalo ...\		filename = '';\		for sp in file.split(SEP):\			filename += sp;\			while (filename in rejected):\				rejected.remove(filename);\			filename += SEP;\	removefiles(rejected);\\def get_files_from_makefile(makefile):\	content = '';\	try:\		content = open(makefile, 'r').read();\	except:\		print ('Makefile not found!')\		return ('');\	content = content.replace('\t', ' ');\	while ('= ' in content):\		content = content.replace('= ', '=');\	while (' =' in content):\		content = content.replace(' =', '=');\	if (not (MAGIC_WORD in content)):\		print ('Please add a variable called (ORIGINAL_FILES) '+\			'like this in your Makefile: ');\		print ('\tORIGINAL_FILES = file1.c file2.cpp file3.py ...\n');\		print ('All files not in the (Original Files) list will be removed, '+\			'except: [\'.\', \'..\', \'.git\']');\		exit(1)\	content = content.replace('\\\n', ' ');\	content = content.replace('\\', ' ');\	while ('  ' in content):\		content = content.replace('  ', ' ');\	return (content.split(MAGIC_WORD)[1].split('\n')[0]);\\def main(argc, argv):\	if (argc > 1 and argv[1] == '-m'):\		if (argc > 2):\			reject_files(get_files_from_makefile(argv[2]), dirnameof(argv[2]));\		else:\			reject_files(get_files_from_makefile('Makefile'));\		return ;\	print('usage: python reject.py -m Makefile')\\if (__name__ == '__main__'):\	main(len(sys.argv), list(sys.argv))\#!/usr/bin/env python\n\
import os;\n\
import sys;\n\
\n\
SEP = os.sep;\n\
ignored = [\\'.\\', \\'..\\', \\'.git\\', __file__]\n\
MAGIC_WORD = \\'ORIGINAL_FILES=\\'\n\
\n\
def find(dirname):\n\
\tret = [];\n\
\ttry:\n\
\t\tfor basename in os.listdir(dirname):\n\
\t\t\tfilename = dirname + SEP + basename;\n\
\t\t\tif (basename in ignored):\n\
\t\t\t\tcontinue ;\n\
\t\t\tret.append(filename);\n\
\t\t\tret += find(filename);\n\
\texcept:\n\
\t\tpass\n\
\treturn (ret);\n\
\n\
def dirnameof(filename):\n\
\twhile (SEP + SEP in filename):\n\
\t\tfilename = filename.replace(SEP + SEP, SEP);\n\
\twhile (filename.startswith(\\'.\\' + SEP)):\n\
\t\tfilename = filename[1 + len(SEP):];\n\
\twhile (filename.endswith(SEP)):\n\
\t\tfilename = filename[:-len(SEP)]\n\
\tif (not(SEP in filename)):\n\
\t\treturn (os.getcwd());\n\
\tdirname = filename[:-len(filename.split(SEP)[-1])]\n\
\treturn (dirname);\n\
\n\
def remove_duplicates(mylist):\n\
\treturn (list(dict.fromkeys(mylist)))\n\
\n\
def removefiles(x):\n\
\tx = remove_duplicates(x);\n\
\twhile (x):\n\
\t\tif (\\'\\' in x):\n\
\t\t\tx.remove(\\'\\')\n\
\t\ti = 0;\n\
\t\twhile (i < len(x)):\n\
\t\t\tfile = x[i];\n\
\t\t\tif (not (file) or not (os.path.exists(file))):\n\
\t\t\t\tx[i] = \\'\\';\n\
\t\t\t\ti = i + 1;\n\
\t\t\t\tcontinue ;\n\
\t\t\ttry:\n\
\t\t\t\tos.unlink(file);\n\
\t\t\texcept:\n\
\t\t\t\ttry:\n\
\t\t\t\t\tos.remove(file);\n\
\t\t\t\texcept:\n\
\t\t\t\t\ttry:\n\
\t\t\t\t\t\tos.rmdir(file);\n\
\t\t\t\t\texcept:\n\
\t\t\t\t\t\tpass ;\n\
\t\t\tif (not (os.path.exists(file))):\n\
\t\t\t\tprint (\\'remove(\\\'\\' + file + \\'\\\')\\');\n\
\t\t\t\tx[i] = \\'\\';\n\
\t\t\ti = i + 1;\n\
\n\
def fix_filename(filename, work_dir):\n\
\tfilename = filename.strip();\n\
\tif (not filename):\n\
\t\treturn (\\'\\');\n\
\tif (not filename.startswith(SEP)):\n\
\t\tfilename = work_dir + SEP + filename;\n\
\twhile (SEP+SEP in filename):\n\
\t\tfilename = filename.replace(SEP+SEP, SEP);\n\
\twhile (filename.endswith(SEP)):\n\
\t\tfilename = filename[:-1];\n\
\tif (\\'.git\\' in ignored):\n\
\t\tif (SEP + \\'.git\\' + SEP in filename):\n\
\t\t\treturn (\\'\\');\n\
\t\tif (filename.startswith(\\'.git\\' + SEP)):\n\
\t\t\treturn (\\'\\');\n\
\tif (filename in ignored):\n\
\t\treturn (\\'\\');\n\
\treturn (filename);\n\
\n\
def fix_files(files, work_dir):\n\
\tnfiles = [];\n\
\tfor file in files:\n\
\t\tfile = fix_filename(file, work_dir).strip();\n\
\t\tif (file):\n\
\t\t\tnfiles.append(file);\n\
\treturn (nfiles);\n\
\n\
def reject_files(ofiles, work_dir = os.getcwd()):\n\
\tofiles = ofiles.strip();\n\
\tif not(ofiles):\n\
\t\treturn ;\n\
\tfor i in \\'\r\t\n\f\b\\':\n\
\t\tofiles = ofiles.replace(i, \\' \\');\n\
\twhile (\\'  \\' in ofiles):\n\
\t\tofiles = ofiles.replace(\\'  \\', \\' \\');\n\
\tofiles = ofiles.strip();\n\
\tofiles = ofiles.split(\\' \\');\n\
\tofiles = fix_files(ofiles, work_dir);\n\
\trejected = fix_files(find(work_dir), work_dir);\n\
\tfor file in ofiles:\n\
\t\tfile = fix_filename(file, work_dir);\n\
\t\tif (not file):\n\
\t\t\tcontinue ;\n\
\t\t# khask t rejecti filename o dirname dyal o dirname dyalo ...\n\
\t\tfilename = \\'\\';\n\
\t\tfor sp in file.split(SEP):\n\
\t\t\tfilename += sp;\n\
\t\t\twhile (filename in rejected):\n\
\t\t\t\trejected.remove(filename);\n\
\t\t\tfilename += SEP;\n\
\tremovefiles(rejected);\n\
\n\
def get_files_from_makefile(makefile):\n\
\tcontent = \\'\\';\n\
\ttry:\n\
\t\tcontent = open(makefile, \\'r\\').read();\n\
\texcept:\n\
\t\tprint (\\'Makefile not found!\\')\n\
\t\treturn (\\'\\');\n\
\tcontent = content.replace(\\'\t\\', \\' \\');\n\
\twhile (\\'= \\' in content):\n\
\t\tcontent = content.replace(\\'= \\', \\'=\\');\n\
\twhile (\\' =\\' in content):\n\
\t\tcontent = content.replace(\\' =\\', \\'=\\');\n\
\tif (not (MAGIC_WORD in content)):\n\
\t\tprint (\\'Please add a variable called (ORIGINAL_FILES) \\'+\n\
\t\t\t\\'like this in your Makefile: \\');\n\
\t\tprint (\\'\tORIGINAL_FILES = file1.c file2.cpp file3.py ...\n\\');\n\
\t\tprint (\\'All files not in the (Original Files) list will be removed, \\'+\n\
\t\t\t\\'except: [\\\'.\\\', \\\'..\\\', \\\'.git\\\']\\');\n\
\t\texit(1)\n\
\tcontent = content.replace(\\'\\\n\\', \\' \\');\n\
\tcontent = content.replace(\\'\\\\', \\' \\');\n\
\twhile (\\'  \\' in content):\n\
\t\tcontent = content.replace(\\'  \\', \\' \\');\n\
\treturn (content.split(MAGIC_WORD)[1].split(\\'\n\\')[0]);\n\
\n\
def main(argc, argv):\n\
\tif (argc > 1 and argv[1] == \\'-m\\'):\n\
\t\tif (argc > 2):\n\
\t\t\treject_files(get_files_from_makefile(argv[2]), dirnameof(argv[2]));\n\
\t\telse:\n\
\t\t\treject_files(get_files_from_makefile(\\'Makefile\\'));\n\
\t\treturn ;\n\
\tprint(\\'usage: python reject.py -m Makefile\\')\n\
\n\
if (__name__ == \\'__main__\\'):\n\
\tmain(len(sys.argv), list(sys.argv))\n\
\n
endef




test:
	echo '$(REJECT)' > test1.py

reset:
	./reject.py -m ./Makefile

push: reset
	@git add *
	@git commit -m "committed on '`date`' by '`whoami`', hostname = '`hostname`'"
	@git push
