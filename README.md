## What's "ramses"?

Ramses is a node.js module that makes building [RAML](http://raml.org/) awesome.

## Usage

    ramses = require('ramses');
    console.log(ramses("file.raml"));

## Features

### Better includes

How about including a directory of files in list form?

    traits: !include config/traits/*
    resourceTypes: !include config/resourceTypes/*

How about being able to include anything, anywhere?

    version: v3
    !include anything.raml

### Better JSON

How about including a [CSON](https://github.com/bevry/cson) schema based on [xcson](https://github.com/awnist/xcson) that automatically compiles down to JSON?

    schema: !include example.cson

## Installation

Use [npm](http://www.npmjs.org/).

    $ npm install ramses

Otherwise, you can check ramses into your repository and expose it:

    $ git clone git://github.com/awnist/ramses.git node_modules/ramses/

ramses is [UNLICENSED](http://unlicense.org/).
