/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_icebreaker_water.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_icebreaker_water;

autoexec __init__system__() {
  system::register(#"mp_icebreaker_water", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "toggle_player_freezing_water", 1, 1, "counter", &toggle_player_freezing_water, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned(localclientnum) {
  if(self === function_5c10bd79(localclientnum)) {
    self.var_b5c65495 = 0;
    self.var_f809ca21 = 0;

    if(self postfx::function_556665f2("pstfx_frost_loop_fullscreen")) {
      self postfx::stoppostfxbundle("pstfx_frost_loop_fullscreen");
    }
  }
}

toggle_player_freezing_water(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isalive(self) || self !== function_5c10bd79(localclientnum)) {
    return;
  }

  if(isDefined(self.var_b5c65495) && self.var_b5c65495) {
    self.var_b5c65495 = 0;
    wait 1;

    while(isalive(self) && !(isDefined(self.var_b5c65495) && self.var_b5c65495) && isDefined(self.var_f809ca21) && self.var_f809ca21 > 0) {
      self.var_f809ca21 -= 0.2;

      if(self.var_f809ca21 < 0) {
        self.var_f809ca21 = 0;
      }

      self postfx::function_c8b5f318("pstfx_frost_loop_fullscreen", #"reveal threshold", self.var_f809ca21);
      wait 5 * 0.2;
    }

    if(isalive(self) && !self.var_b5c65495) {
      self postfx::stoppostfxbundle("pstfx_frost_loop_fullscreen");
    }

    return;
  }

  self.var_b5c65495 = 1;

  if(!self postfx::function_556665f2("pstfx_frost_loop_fullscreen")) {
    self postfx::playpostfxbundle("pstfx_frost_loop_fullscreen");
  }

  while(isalive(self) && isDefined(self.var_b5c65495) && self.var_b5c65495 && isDefined(self.var_f809ca21) && self.var_f809ca21 < 1) {
    self.var_f809ca21 += 0.1;

    if(self.var_f809ca21 > 1) {
      self.var_f809ca21 = 1;
    }

    self postfx::function_c8b5f318("pstfx_frost_loop_fullscreen", #"reveal threshold", self.var_f809ca21);
    wait 10 * 0.1;
  }
}