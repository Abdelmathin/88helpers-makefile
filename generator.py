import os;
import sys;

SEP = os.sep;
ignored = ['.', '..', '.git', __file__]

def find(dirname):
	ret = [];
	try:
		for basename in os.listdir(dirname):
			filename = dirname + SEP + basename;
			if (basename in ignored):
				continue ;
			ret.append(filename);
			ret += find(filename);
	except:
		pass
	return (ret);

def write(s):
	print(s)

def generate_makefile(dirname):
	files = find(dirname);
	VARS = {
		'MANDATORY': {'C': [], 'H': []},
		'BONUS': {'C': [], 'H': []}
		};
	for file in files:
		if (file.endswith('.c') or file.endswith('.h')):
			file = file[len(dirname):];
			while (file.startswith('./') or file.startswith('/')):
				file = file[file.index('/') + 1:];
			K = file.split('.')[-1].upper();
			PART = 'MANDATORY';
			if ('_bonus.' in file):
				PART = 'BONUS'
			if (not (file in VARS[PART][K])):
				VARS[PART][K].append(file);
	write ('MANDATORY_SOURCES	=	\\');
	for file in VARS['MANDATORY']['C']:
		write ('\t\t\t\t\t' + file + '\\')


generate_makefile("/Users/ahabachi/Desktop/Projects/42cursus-libft/");


# 88helpers-orthodox_canonical_form

# The Orthodox Canonical Class Form
# A default constructor: used internally to initialize objects and data members when no other value is available.
# A copy constructor: used in the implementation of call-by-value parameters.
# An assignment operator: used to assign one value to another.
# A destructor: Invoked when an object is deleted.


# This repository may help you to generate C++ classes in the Orthodox Canonical Form.



# this repsitory may help you to genearte a C++ classes in the Orthodox Canonical Class Form







