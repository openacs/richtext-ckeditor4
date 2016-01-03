ad_library {

    CKEditor 4 integration with the richtext widget of acs-templating.

    This script defines the following two procs:

       ::richtext-ckeditor4::initialize_widget
       ::richtext-ckeditor4::render_widgets    
    
    @author Gustaf Neumann
    @creation-date 1 Jan 2016
    @cvs-id $Id$
}

namespace eval ::richtext-ckeditor4 {
    
    ad_proc initialize_widget {
        -form_id
        -text_id
        {-options {}}
    } {
        
        Initialize an CKEditor richtext editor widget.
        
    } {
        ns_log debug "initialize CKEditor instance with <$options>"

        # The richtext widget might be specified by "options {editor
        # ckeditor4}" or via the package parameter "RichTextEditor" of
        # acs-templating.
        #
        # The following options handled by the CKEditor integration
        # can be specified in the widget spec of the richtext widget:
        #
        #      plugins skin customConfig spellcheck
        #
        set ckOptionsList {}
        
        if {![dict exists $options spellcheck]} {
            dict set options spellcheck true
        }

        lappend ckOptionsList \
            "language: '[lang::conn::language]'" \
            "scayt_autoStartup: [dict get $options spellcheck]"

        if {[dict exists options plugins]} {
            lappend ckOptionsList "extraPlugins: '[dict get $options plugins]'"
        }
        if {[dict exists options skin]} {
            lappend ckOptionsList "skin: '[dict get $options skin]'"
        }
        if {[dict exists options customConfig]} {
            lappend ckOptionsList "customConfig: '[dict get $options customConfig]'"
        }
        set ckOptions [join $ckOptionsList ", "]
        
        #
        # Add the configuration via body script
        #
        template::add_script -section body -script [subst {
            CKEDITOR.replace( '$text_id', {$ckOptions} );
        }]

        template::head::add_javascript -src "//cdn.ckeditor.com/4.5.6/standard/ckeditor.js"

        #
        # do we need render_widgets?
        #
        return ""
    }


    ad_proc render_widgets {} {

        Render the ckeditor4 rich-text widgets. This function is created
        at a time when all rich-text widgets of this page are already
        initialized. The function is controlled via the global variables

           ::acs_blank_master(ckeditor4)
           ::acs_blank_master__htmlareas
        
    } {
        #
        # In case no ckeditor4 instances are created, nothing has to be
        # done.
        #
        if {![info exists ::acs_blank_master(ckeditor4)]} {
            return
        }
        #
        # Since "template::head::add_javascript -src ..." prevents
        # loading the same resource multiple times, we can perform the
        # load in the per-widget initialization and we are done here.
        #
    }

}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End: