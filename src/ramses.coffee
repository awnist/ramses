fs = require 'fs'
glob = require 'glob'
path = require 'path'
detectIndent = require 'detect-indent'
xcson = require 'xcson'

module.exports = buildFragment = (file) ->

	raml = fs.readFileSync(file, 'utf8').toString()

	indent = detectIndent(raml) || '  ';

	cwd = path.dirname(file) or "./"

	raml.replace /(([ \t]*).*)\!include (.+)/g, (whole, lead, spaces, includes) ->

		return whole if whole.match /#/

		spaces = indent unless spaces

		buffer = ""

		isjson = false

		for include in includes.split /\s,/

			founds = glob.sync include,
				cwd: cwd
				nonegate: true

			throw "Can't resolve \"#{include}\" in #{file}" unless founds.length

			for found in founds

				foundfile = path.resolve(cwd, found)

				if found.match /\.(c|j)son/
					isjson = true
					mason = new xcson
						file: foundfile
						stringifySpaces: spaces
					infile = mason.toString()
				else
					infile = buildFragment foundfile

				buffer += infile.replace(/[ \t]*$/, "\n")

		afterlead = " "

		# Drop down to next line if this is a JSON file.
		if isjson
			afterlead = " |\n"

		# Drop down to next line if this is a YAML list.
		else if buffer.match /\s*\-/
			afterlead = "\n"

		if afterlead.match /\n$/
			buffer = spaces + indent + buffer.replace(/([\n\r])/g, "$1"+spaces+indent)

		return lead.replace(/\s*$/, afterlead) + buffer

