/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_offshore_alt_player_rain.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace mp_offshore_alt_player_rain;

autoexec __init__system__() {
  system::register(#"mp_offshore_alt_player_rain", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "toggle_player_rain", 1, 1, "counter", &toggle_player_rain, 0, 0);
}

toggle_player_rain(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self !== function_5c10bd79(localclientnum)) {
    return;
  }

  if(isDefined(self.var_8401c7bc) && self.var_8401c7bc) {
    self.var_8401c7bc = 0;
    self postfx::stoppostfxbundle("pstfx_sprite_rain_loop_offshore");
    return;
  }

  self.var_8401c7bc = 1;

  if(!self postfx::function_556665f2("pstfx_sprite_rain_loop_offshore")) {
    self postfx::playpostfxbundle("pstfx_sprite_rain_loop_offshore");
  }
}