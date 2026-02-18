/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_vapor_random.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_vapor_random;

function private autoexec __init__system__() {
  system::register(#"zm_vapor_random", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int", &random_vapor_altar_available_fx, 0, 0);
  level._effect[# "random_vapor_altar_available"] = "zombie/fx_powerup_on_green_zmb";
}

function random_vapor_altar_available_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!isDefined(self.var_476bef54)) {
      self.var_476bef54 = util::playFXOnTag(fieldname, level._effect[# "random_vapor_altar_available"], self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_476bef54)) {
    stopfx(fieldname, self.var_476bef54);
  }
}