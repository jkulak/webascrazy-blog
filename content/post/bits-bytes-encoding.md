+++
title = "Bits, bytes, encoding, char sets and file formats"
description = ""
author = "Jakub Kułak"
tags = ["programming", "learning"]
date = "2016-12-13T12:50:29-06:00"
draft = false
+++

# Bits, bytes, char sets, encoding, file formats

To full understand the concepts of storing data and encoding, we will use the sequence of bytes, and step by step transform it to see what kind of data it stores.

Let's start from bottom, and move up to be able to understand all the concepts step by step.

## Storing bits and bytes, raw data

1. Data (either in memory or files on a drive) is stored as a sequence of bits (0s and 1s) - this is the sequence we will use in all next examples:
`111011111011101110111111010101100110111101101001011011001100001 110100000001000001111000010011111000000100100001010010000001010`

2. Since every 8 bits make a byte (this is for the [historical reason](https://www.quora.com/Why-it-is-that-1-Byte-is-equal-to-8-Bits)), we can say that files are stored as a sequence of bytes:
`11101111 10111011 10111111 01010110 01101111 01101001 01101100 11000011 10100000 00100000 11110000 10011111 10010000 10100100 00001010`

3. Bytes can be represented in different [numeral systems](https://en.wikipedia.org/wiki/Numeral_system) (this is purely for presentational purposes - because it is easier for us, humans, to distinguish decimal and hexadecimal values that binary values)

    - binary (0, 1), min byte value: 00000000, max byte value: 11111111 (like seen above)      

    - decimal (0, 1, 2, 3, 4, 5, 6, 7, 8, 9), min byte value: 0, max byte value: 255
        `239 187 191 86 111 105 108 195 160 32 240 159 144 164 10` - you will not see that too often - it's just for explanation purposes here
    - hexadecimal (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c, d, e, f), min byte value: 0, max byte value: ff (we add the preceding 0 for values smaller than 10 for readability)
        `ef bb bf 56 6f 69 6c c3 a0 20 f0 9f 90 a4 0a` - to distinguish hexadecimal notation, often `0x` is added in front the values, therefor it becomes `0xefbbbf 0x566f69 0x6cc3a0 0x20f09f 0x90a40a` (after grouping some bytes together)

By looking at those bytes - we are not yet able to tell anything about the data that is being stored - if it is an image, json file or a PDF file. Although, if you are familiar with encoding already, the first three bytes: `0xefbbbf` might give you a clue.

## Character encoding

Character encoding is an algorithm that translates a list of characters (which can be letters, symbols, emoji) to binary code, so it can be stored on disk.

There are plenty of character encodings. The most popular in 2016 for websites, are:

* UTF-8 (88.1%)
* ISO-8859-1 (5.5%)
* Windows-1251 (1,7%)
* Shift JIS (1,1%)

### ASCII

It is a 7-bit code for coding characters in computers and generally in all communication devices that use text. 7-bit (0b0000000–0b1111111) means it can represent 128 characters, from which, some of them are not visible (control characters). Complete list with codes can be found here: http://www.columbia.edu/kermit/ascii.html

### ISO-8859
It is a set of 8-bit single-byte coded character encoding schemes. 8-bit (0b00000000–0b11111111) means that each of the encodings from ISO-8859 can represent 255 characters, from which some of them are not visible (control characters). For backward compatibility first 128 characters have same codes as in ASCII. Rest of the codes are assign to language specific characters, depending on ISO-8859 part.

### ISO-8859–2

Part 2 of ISO-8859 character encoding (also referred as Latin-2). Created to be used with Central European languages like Bosnian, Polish, Croatian, Czech, Slovak, Slovene and some else. First 128 characters are same as ASCII codes.

### Windows-1250

It is MS Windows 8-bit character encoding for Central European languages. It has many of the same characters as ISO-8895–2 but in a different arrangement, which leads to some confusions.

### UTF-8

UTF-8 is a 8-bit variable-length character encoding for Unicode. This means that one character is represented by 1 to 4 bytes, so UTF-8 contains way more characters than ISO-8895 and other local charsets. Unlike UTF-16 and UTF-32, UTF-8 is backward compatible with ASCII (first 128 characters are the same) — this is one of the reasons UTF-8 got most popular from among unicode encodings.

## Guessing the file encoding

There is no universal way to tell the file (sequence of bytes) encoding. Different applications, make a guess based on several rules, example of detection: https://github.com/aadsm/jschardet/blob/master/src/universaldetector.js#L75-L100.

The best shot is the [BOM](https://en.wikipedia.org/wiki/Byte_order_mark), byte order mark, that might be present as the first bytes in the file.

By looking at our sequence `0xefbbbf 0x566f69 0x6cc3a0 0x20f09f 0x90a40a` we can see, that the first three bytes are actually a BOM for UTF-8 encoding `0xef 0xbb 0xbf`.

Let's try to save those bytes into a file and see what comes up (we use `\x` to be able to use hexadecimal values):
```
$ echo -n -e '\xef\xbb\xbf\x56\x6f\x69\x6c\xc3\xa0\x20\xf0\x9f\x90\xa4\x0a' > testfile
```

Now, running `$ cat testfile` might give you different results, depending on which encoding is used by your terminal. You might get gibberish like `ï»¿VoilÃ  ğ¤` or something more meaningful when you use UTF-8 - see for yourself.

Removing the three first bytes from our sequence (UTF-8 BOM), would still give good results when displaying the content of the file using UTF-8, but would not display correctly using different encoding (here we use `iconv` to view the content of the file using selected encoding):
```
$ iconv -t utf-16be testfile
```

### BOM

Byte Order Mark is a character (can be 2-5 bytes long) that placed at the start of a text stream (sequence of bytes) can signal several things to a reader of the stream, like

* which of the Unicode character encodings is used to encode the stream
* byte order (endianness: little-endian (LE) or big-endian (BE))

```
🐥 :~ $ iconv -t utf-16be testfile | xxd
0000000: 0056 006f 0069 006c 00e0 0020 d83d dc24  .V.o.i.l... .=.$
0000010: 000a                                     ..
🐥 :~ $ xxd testfile
0000000: 566f 696c c3a0 20f0 9f90 a40a            Voil.. .....
🐥 :~ $iconv -t utf-16le testfile | xxd
0000000: 5600 6f00 6900 6c00 e000 2000 3dd8 24dc  V.o.i.l... .=.$.
0000010: 0a00
```

## Character sets

A character set is a list of characters with unique numbers (these numbers are sometimes referred to as "code points"). Unicode is the most popular example of a character set (that can be encoded using different character encodings, like UTF-7, UTF-8, UTF-16BE, UTF-32 and others).

### Unicode

Unicode is a standard for consistent representation and handling of text expressed in most of the world’s writing systems (e-mails, files, websites). Despite graphical representation it handles related items, such as character properties, rules for normalization, decomposition, collation, rendering, and bidirectional display order (for the correct display of text containing both right-to-left scripts, such as Arabic or Hebrew, and left-to-right scripts).

## Useful commands

1. View file content in hexadecimal format : `$ xxd testfile`
2. View file content in binary format: `$ xxd -b testfile`
3. Write bytes to file: `$ echo -n -e '\xEF\xBB\xBF\xf0\x9f\x98\x80' > smiley_face`
4. See the list of iconv supported encodings: `$ iconv -l`
5. Try to guess file encoding: `$ file -I testfile` (osx), `$ file -i testfile` (linux). For better detection, consider using https://linux.die.net/man/1/enconv

# Notes

In browser JavaScript console
```
var out = ""
"11101111 10111011 10111111 01010110 01101111 01101001 01101100 11000011 10100000 00100000 11110000 10011111 10010000 10100100 00001010".split(" ").forEach(function(elem) {
out += parseInt(elem, 2) + " "
})
console.log(out)
```
