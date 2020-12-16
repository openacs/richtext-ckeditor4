<master>
<property name="doc(title)">@title;literal@</property>
<property name="context">@context;literal@</property>

<h1>@title;noquote@</h1>
<p>Checking for CKEditor 4 in configuration <strong>@ck_package@</strong>
[<a href='.?ck_package=basic'>basic</a>,
<a href='.?ck_package=standard'>standard</a>,
<a href='.?ck_package=full'>full</a>]
<include src="/packages/acs-tcl/lib/check-installed" &=resource_info &=version &=download_url>
