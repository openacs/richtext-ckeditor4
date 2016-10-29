ad_library {

    CKEditor 4 integration with the richtext widget of acs-templating.

    This script defines the following two procs:

       ::richtext-ckeditor4::initialize_widget
       ::richtext-ckeditor4::render_widgets    
    
    @author Gustaf Neumann
    @creation-date 1 Jan 2016
    @cvs-id $Id$
}

namespace eval ::richtext::ckeditor4 {
    
    ad_proc initialize_widget {
        -form_id
        -text_id
        {-options {}}
    } {
        
        Initialize an CKEditor richtext editor widget.
        
    } {
        ns_log debug "initialize CKEditor instance with <$options>"

        # allow per default all classes, unless the user has specified
        # it differently
        if {![dict exists $options extraAllowedContent]} {
            dict set options extraAllowedContent {*(*)}
        }
        
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
            dict set options spellcheck [parameter::get \
                                             -package_id [apm_package_id_from_key "richtext-ckeditor4"] \
                                             -parameter "SCAYT" \
                                             -default "false"]
        }

        # For the native spellchecker, one has to hold "ctrl" or "cmd"
        # with the right click.
        
        lappend ckOptionsList \
            "language: '[lang::conn::language]'" \
            "disableNativeSpellChecker: false" \
            "scayt_autoStartup: [dict get $options spellcheck]"

        if {[dict exists $options plugins]} {
            lappend ckOptionsList "extraPlugins: '[dict get $options plugins]'"
        }
        if {[dict exists $options skin]} {
            lappend ckOptionsList "skin: '[dict get $options skin]'"
        }
        if {[dict exists $options customConfig]} {
            lappend ckOptionsList "customConfig: '[dict get $options customConfig]'"
        }
        if {[dict exists $options extraAllowedContent]} {
            lappend ckOptionsList "extraAllowedContent: '[dict get $options extraAllowedContent]'"
        }

        set ckOptions [join $ckOptionsList ", "]
        
        #
        # Add the configuration via body script
        #
        template::add_script -section body -script [subst {
            CKEDITOR.replace( '$text_id', {$ckOptions} );
        }]

        template::head::add_javascript -src "//cdn.ckeditor.com/4.5.11/standard/ckeditor.js"

        #
        # add required directives for content security policies
        #
        security::csp::require script-src 'unsafe-eval'
        security::csp::require -force script-src 'unsafe-inline'
        security::csp::require script-src cdn.ckeditor.com
        security::csp::require style-src cdn.ckeditor.com
        security::csp::require img-src cdn.ckeditor.com
        
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
