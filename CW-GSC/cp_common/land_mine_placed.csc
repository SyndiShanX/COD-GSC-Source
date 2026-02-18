/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\land_mine_placed.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace land_mine_placed;

function private autoexec __init__system__() {
  system::register(#"land_mine_placed", &init_preload, undefined, undefined, undefined);
}

function private init_preload() {
  clientfield::register("scriptmover", "show_blink_fx", 1, 1, "int", &show_blink_fx, 0, 0);
}

function private show_blink_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_29af9712)) {
    stopfx(fieldname, self.var_29af9712);
  }

  if(bwastimejump > 0) {
    self.var_29af9712 = util::playFXOnTag(fieldname, "light/fx8_blink_red_sm", self, "tag_fx");
  }
}