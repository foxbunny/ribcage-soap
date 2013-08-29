# Ribcage-SOAP

This library provides [Ribcage](https://github.com/foxbunny/ribcage)-compatible
model and collection for consuming SOAP services.

The SOAP functionality used to be part of Ribcage until v0.2, and has since
been removed. It is now maintained separately.

## Requirements

Ribcage-SOAP depends on Ribcage, 
[jQuery Soap](http://plugins.jquery.com/soap/), and 
[jquery.xml2json](http://code.google.com/p/jquery-xml2json-plugin/).

## Installing

Ribcage-SOAP modules are in UMD format. This means you can use them either with
an AMD module loader such as [RequireJS](http://requirejs.org/), or with the
classic `<script>` tag.

When loading modules using the `<script>` tag, please make sure `main.js` is
loaded before other modules. Also, when adding the modules using `<script>`
tags, the UMD wrapper will do a basic dependency check and you may receive
exceptions if the dependencies are not available.

## Installing using volo

If you are using [volo](http://volojs.org/), use the add command:

    volo add foxbunny/ribcage-soap

It will be installed into `lib/ribcage-soap`. An alias for
`lib/ribcage-soap/main.js` will be created at `lib/ribcage-soap.js`.

The CoffeeScript sources are located in `src` directory, and are _not_
installed by volo. If you want to use them instead of JavaScript code, you can
manually copy them into your project.

## Documentation

Please see [Ribcage-SOAP wiki](https://github.com/foxbunny/ribcage-soap/wiki)
for basic usage.

## Reporting bugs

Please report all issues to [Ribcage-SOAP GitHub issue
tracker](https://github.com/foxbunny/ribcage-soap/issues)
