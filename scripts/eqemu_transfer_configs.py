#!/usr/bin/python

import os, errno
import sys
import glob

# Transfers configuration to the appropriate location. Expects
# the configuration to be loaded in the environment.


def load_environment():
	env_dict = {}
	for key in os.environ:
		if key.startswith("EQEMU_"):
			env_dict[key] = os.environ[key]
	return env_dict

def mkdir_p(path):
	try:
		os.makedirs(path)
	except OSError as exc:
		if exc.errno == errno.EEXIST and os.path.isdir(path):
			pass
		else: raise

def transfer_file(from_file, to_file, keys):
	print " * %s" % os.path.basename(from_file)

	infile = open(from_file, "r")
	outfile = open(to_file, "w")

	for line in infile:
		if line.find("$") != -1:
			for k in keys:
				line = line.replace("$" + k, keys[k])
		outfile.write(line)


if __name__ != "__main__":
	print "Cannot run as a module"
	exit(1)

this_dir = os.path.dirname(os.path.realpath(__file__))
templates_dir = os.path.join(this_dir, "config_templates")
configs_dir = os.path.normpath(os.path.join(this_dir, "..", "server"))

environ = load_environment()

print "\033[1;37mLoaded environment:\033[0m"
for k in environ:
	print "* %s = %s" % (k, environ[k])

mkdir_p(configs_dir)

print "\033[1;37mTransferring files to %s:\033[0m" % configs_dir
for infile in glob.glob(os.path.join(templates_dir, "*")):
	transfer_file(infile, os.path.join(configs_dir, os.path.basename(infile)), environ)
