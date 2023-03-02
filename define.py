#  **************************************************************************  #
#                                                                              #
#                                                          :::      ::::::::   #
#    define.py                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ahabachi <ahabachi@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/21 13:45:17 by ahabachi          #+#    #+#              #
#    Updated: 2022/11/24 18:11:43 by ahabachi         ###   ########.fr        #
#                                                                              #
#  **************************************************************************  #

# env -i bash

characters_keys = [
	 '$', # khasha tkon heya lawla
	 '\t', '\n', '\\'
]
characters_values = [
	'$(DOLAR)', # khasha tkon heya lawla 
	'$(TAB)', '$(NEWLINE)', '$(BACKSLASH)'
]

def define(filename):
	content = '';
	try:
		content = open(filename, 'r').read();
	except:
		return ;
	for key in characters_keys:
		value = characters_values[characters_keys.index(key)];
		content = content.replace(key, value)
	basename = filename.split('/')[-1];
	_name = filename.split('/')[-1].split('.')[0].upper();
	text = content;
	text = text.strip()
	if (text.endswith('\\')):
		text = text[:-1];
	text = ('define ' + _name) + '\n' + text + '\nendef\n';
	text+= '\nreset:\n\t@echo "${' + _name + '}" > ' + basename;
	text+= '\n\t@python ' + basename + ' -m Makefile'
	# '\nSPACE		=	 \nBACKSLASH	=	\\\\';
	
	prefix = ('# ' * 40 + '\n') * 1;

	prefix += 'DOLAR\t\t=\t$\n';
	prefix += 'TAB\t\t\t=\t\\t\n';
	prefix += 'NEWLINE\t\t=\t\\n\n';
	prefix += 'BACKSLASH\t=\t\\\\\\\\';
	
	text = prefix + '\n\n' + text;
	text += '\n\npush: reset';
	text += '\n\t@git add .';
	text += '\n\t@git commit -m "committed on \'`date`\' by \'`whoami`\', hostname = \'`hostname`\'"';
	text += '\n\t@git push';
	text += '\n\nnorm:';
	text += '\n\t@norminette';

	text += '\n';
	print (text)

define("reject.py")
