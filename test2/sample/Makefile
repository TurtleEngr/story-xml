mTidyOpt = -asxhtml -i -q -m -wrap 78 --indent-spaces 8 --show-warnings no

all : other.html

other.html : other-inc.xml other.xml ../../src/web/page.fmt
	xsltproc ../../src/web/page.fmt other-inc.xml
	-tidy $(mTidyOpt) other.html
	unexpand other.html >t.tmp
	mv -f t.tmp other.html
