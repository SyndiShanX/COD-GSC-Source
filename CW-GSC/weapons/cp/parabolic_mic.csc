/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\parabolic_mic.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace parabolic_mic;

function private autoexec __init__system__() {
  system::register("parabolic_mic", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  var_1e935eba = array("scriptmover");

  foreach(str_type in var_1e935eba) {
    clientfield::register(str_type, "parabolic_mic_volume_scale", 1, 5, "float", &scale_volume, 1, 0);
  }

  clientfield::register_clientuimodel("hudItems.ParabolicMic.active", #"parabolic_mic", #"active", 1, 1, "int", undefined, 0, 1);
}

function private scale_volume(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("354e823c02b201c");
  self endon("354e823c02b201c");

  while(isDefined(self)) {
    self function_7b308729(bwastimejump);
    waitframe(1);
  }
}