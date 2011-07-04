package QuickInputCategory::Callbacks;
use strict;

sub template_source_list_category {
    my ($cb, $app, $tmpl_ref) = @_;
    my $version = MT->version_id;

    my ($target, $insert, $replace);

    $target = quotemeta '<input type="text" name="<mt:var name="object_type" lower_case="1">_label" class="text short disabled" disabled="disabled" placeholder="<__trans phrase="[_1] label" params="<mt:var name="object_label">">">';
    $insert = <<'__MTML__';
        <input type="text" name="<mt:var name="object_type" lower_case="1">_basename" class="text short disabled" disabled="disabled" placeholder="<__trans phrase="Basename">">
__MTML__
    $$tmpl_ref =~ s!($target)!$1$insert!;

    $target = quotemeta 'function addItem(parent, label';
    $replace =          'function addItem(parent, label, basename';
    $$tmpl_ref =~ s/$target/$replace/;

    $target = quotemeta             'var basename = makeBasename(parent, id, label)';
    $replace =          'if (! basename) basename = makeBasename(parent, id, label)';
    $$tmpl_ref =~ s/$target/$replace/;

    $target = <<'__MTML__';
jQuery('input[name=<mt:var name="object_type">_label]').live('keypress', function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        jQuery(this).siblings('button.add').click();
        return false;
    }
});
__MTML__
    $target = quotemeta $target;
    $replace = <<'__MTML__';
jQuery('input[name=<mt:var name="object_type">_label]').live('keypress', function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        jQuery(this).next('input:text').focus();
        return false;
    }
});
jQuery('input[name=<mt:var name="object_type">_basename]').live('keypress', function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        jQuery(this).siblings('button.add').click().end().prev().focus();
        return false;
    }
});
__MTML__
    $$tmpl_ref =~ s/$target/$replace/;

    $target = quotemeta q/  var label = jQuery(this).parent('#area-action').find('input').val();/;
    $replace = <<'__MTML__';
  var label = jQuery(this).parent('#area-action').find('input:eq(0)').val();
  var basename = jQuery(this).parent('#area-action').find('input:eq(1)').val();
__MTML__
    $$tmpl_ref =~ s/$target/$replace/;

    $target = quotemeta 'if ( addItem(parent, label) ) {';
    $replace =          'if ( addItem(parent, label, basename) ) {';
    $$tmpl_ref =~ s/$target/$replace/g;

    $target = quotemeta q{<input type="text" name="<mt:var name="object_type" lower_case="1">_label" class="text short" placeholder="<__trans phrase="[_1] label" params="<mt:var name="object_label">" escape="js">" />};
    $insert = q{<input type="text" name="<mt:var name="object_type" lower_case="1">_basename" class="text short" placeholder="<__trans phrase="Basename" escape="js">" />};
    $$tmpl_ref =~ s!($target)!$1$insert!;

    $target = quotemeta q/$form.css('margin-left', (nest.length+1)*indent).insertAfter($element).find('input[name=<mt:var name="object_label" lower_case="1">_label]').focus();/;
    $replace = q/$form.css('margin-left', (nest.length+1)*indent).insertAfter($element).find('input:eq(0)').focus();/;
    $$tmpl_ref =~ s/$target/$replace/g;


    $target = quotemeta q/var label = jQuery(this).parent('.add-form').find('input').val();/;
    $replace = <<'__MTML__';
var label = jQuery(this).parent('.add-form').find('input:eq(0)').val();
var basename = jQuery(this).parent('.add-form').find('input:eq(1)').val();
__MTML__
    $$tmpl_ref =~ s/$target/$replace/;

}

1;