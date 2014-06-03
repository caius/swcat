# swcat

[cat(1)](http://www.freebsd.org/cgi/man.cgi?cat(1)) *partial* clone in Swift.

Currently supports reading from stdin and writing to stdout with no arguments given, or reading filenames from given arguments.

## Usage

Reading stdin to stdout:

```bash
$ echo "hi" | swcat
hi
```

Reading multiple files, including ones that don't exist:

```bash
$ swcat bling.txt count.txt
swcat: bling.txt: No such file or directory
1
2
3
4
5
```

## License

```bash
$ swcat LICENSE
```
