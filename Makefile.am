if ENABLE_BUILD_UTILS

build_SUBDIRS = xml2po

pkgdata_DATA=\
	template.omf.in \
	template.make \
	template-document.xml

endif

# doc must go last
SUBDIRS = data po xslt tools $(build_SUBDIRS) doc

ACLOCAL_AMFLAGS = -I m4 -I tools ${ACLOCAL_FLAGS}

EXTRA_DIST = 						\
	$(pkgdata_DATA)					\
	COPYING.GPL					\
	COPYING.LGPL					\
	bootstrap.make					\
	intltool-extract.in  				\
	intltool-merge.in    				\
	intltool-update.in

DISTCLEANFILES =					\
	intltool-extract  				\
	intltool-merge    				\
	intltool-update					\
	gnome-doc-utils.make

DISTCHECK_CONFIGURE_FLAGS = --disable-scrollkeeper

distuninstallcheck_listfiles =  \
find -regex '.*/var/scrollkeeper/.*' -prune -or -type f -print
