Metasave
========

The Gnome file manager Nautilus keeps all kinds of interestig data about your files in the Gnome Virtual Filesystem metadata:

- comments per file system node

- custom icon per file system node

- icon emblems

- icon positions

- icon size

- view settings per directory

However, when copying files to another system, to another user on the same computer, onto an external harddisk, or when updating the operating system, this data is lost.

Metasave will, starting from the current directory, recursively save all metadata as an executable shell script. Running this script will re-create the metadata. -- Now only the file manager you use needs to respect this data.

Usage
-----

Make `metasave.pl` executable and put it somewhere into your $PATH, or directly put it into the directory structure you want to save metadata for.

Redirect the script's output into a file. Run this file to restore the metadata.

Example:

    $ metasave.pl > metarestore.sh
    $ rsync -rva . destination
    $ cd destination
    $ sh metarestore.sh

Dependencies
------------

Requires Perl version 5.10 or higher. Depends on the [String::ShellQuote](http://search.cpan.org/~rosch/String-ShellQuote-1.03/ShellQuote.pm) module from CPAN. This module is available in the debian or Ubuntu repositories under the name `libstring-shellquote-perl`.

Expressive File Management
--------------------------

Sadly, with the Gnome Shell 3.6 release, the Gnome developers have decided to remove all things from the Nautilus file manager that used to make it great.

Files used to be more than a few icons in a grid. File management was expressive and ambiguous. Users could visually group files together, visually mark them, enlarge the icons, etc. The sum of these features enabled a user-centric means of working with files without the need for specialized apps.

Since Nautilus is about to become "simplified" to a degree that it removes all expressive power from the user, **now is the time to save your metadata**. Removing these features means that expressive power is shifting to a primitive database logic, since only enumerable qualities of files -- their names, byte size, last-modified dates -- are able to influence their presentation.

I am keeping my metadata in the hope that once another filemanager will be able to make use of it.

*Dragan Espenschied*