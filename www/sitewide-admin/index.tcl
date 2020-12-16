ad_page_contract {
    @author Gustaf Neumann

    @creation-date Aug 6, 2018
} {
    {ck_package:token ""}
}

set version $::richtext::ckeditor4::version
set default_ck_package $::richtext::ckeditor4::ck_package
if {$ck_package eq ""} {
    set ck_package $::richtext::ckeditor4::ck_package
}
set resource_info [::richtext::ckeditor4::resource_info -ck_package $ck_package]
set download_url download?ck_package=$ck_package

set title "[dict get $resource_info resourceName] - Sitewide Admin"
set context [list $title]


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
