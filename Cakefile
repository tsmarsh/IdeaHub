### Build file for CoffeePhysics. ###
fs 			  = require 'fs'
uglify 		  = require 'uglify-js'
{exec, spawn} = require 'child_process'
util = require 'util'

grr = (message = '') -> 
    options = {
        title: 'CoffeeScript'
        image: '/Users/justin/node_modules/growl/lib/CoffeeScript.png'
    }
    try require('growl')(message, options)



uglify = (file) ->
    exec 'uglifyjs --overwrite ' + file, (err, stdout, stderr) ->
        throw err if err
        util.log 'uglified ' + file

task 'watch', 'Watch .coffee and compress them on the fly', ->
    log = (data) ->
        data = data.toString().trim()
        console.log data
        lines = data.split '\n'
        for line in lines
            parts = line.split ' '
            if parts[2] is 'compiled'
                path = parts[3].split '/'
                if path[2] is 'client'
                    uglify './public/js' + parts[3].slice(17, -6) + 'js'

    coffee_client = spawn 'coffee', ['-cwb' , '-o', './public/js', 'src/coffee/client']
    coffee_client.stdout.on 'data', log
    coffee_client.stderr.on 'data', log
    coffee_client.on 'exit', log

    sass_client = spawn 'sass', ['--watch', 'src/sass:public/css' ]
    sass_client.stdout.on 'data', console.log
    sass_client.stderr.on 'data', console.log
    sass_client.on 'exit', console.log

task 'build', 'Create the .nw', ->
    exec 'cd public && zip -r ../ideahub.nw *'
			