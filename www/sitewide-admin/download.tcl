ad_page_contract {
    @author Gustaf Neumann

    @creation-date Jan 04, 2017
} {
    {ck_package:token,notnull ""}
    {version:token,notnull ""}
}

::richtext::ckeditor4::download -ck_package $ck_package -version $version
ad_returnredirect .

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
