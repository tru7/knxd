#!/bin/sh

case `uname` in
	Darwin*)
		LIBTOOLIZE=glibtoolize ;;
	*)
		LIBTOOLIZE=libtoolize ;;
esac

# on Debian systems we need pkg-config
if which dpkg >/dev/null && ! which pkg-config >/dev/null ; then
	echo "Tool 'pkg-config' missing. Install package 'pkgconf' or older 'pkg-config'."
	exit 2
fi

$LIBTOOLIZE --copy --force --install && \
	aclocal -I m4 --force && \
	autoheader && \
	automake --add-missing --copy --force-missing && \
	autoconf
