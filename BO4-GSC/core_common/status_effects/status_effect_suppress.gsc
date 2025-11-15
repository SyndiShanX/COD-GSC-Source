/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_suppress.gsc
*****************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\serverfield_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_suppress;

autoexec __init__system__() {
  system::register(#"status_effect_suppress", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(4, &suppress_apply);
  status_effect::function_5bae5120(4, &registersamanthas_bundle);
  status_effect::function_6f4eaf88(getstatuseffect("suppress"));
  serverfield::register("status_effect_suppress_field", 1, 5, "int", &function_aa232314);
  callback::on_spawned(&onplayerspawned);
}

suppress_apply(var_756fda07, weapon, applicant) {}

registersamanthas_bundle() {}

private function_aa232314(oldval, newval) {
  if(oldval != newval) {
    if(newval) {
      self.var_dc148218 = 1;

      if(newval > 1) {
        var_4d81e7b4 = newval - 2;

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }

          if(player getentitynumber() == var_4d81e7b4) {
            self.var_ead9cdbf = player;
            break;
          }
        }
      }

      var_2deafbea = function_1115bceb(#"suppress");
      self.var_14407070 = {};

      if(isDefined(var_2deafbea.var_b86e9a5e)) {
        self playlocalsound(var_2deafbea.var_b86e9a5e);
      }

      if(isDefined(var_2deafbea.var_801118b0)) {
        self playLoopSound(var_2deafbea.var_801118b0);
        self.var_14407070.var_801118b0 = var_2deafbea.var_801118b0;
      }

      if(isDefined(var_2deafbea.var_36c77790)) {
        self.var_14407070.var_36c77790 = var_2deafbea.var_36c77790;
      }

      return;
    }

    self.var_dc148218 = 0;
    self.var_ead9cdbf = undefined;

    if(isDefined(self.var_14407070) && isDefined(self.var_14407070.var_36c77790)) {
      if(isplayer(self)) {
        self playlocalsound(self.var_14407070.var_36c77790);
      }
    }

    if(isDefined(self.var_14407070) && isDefined(self.var_14407070.var_801118b0)) {
      if(isplayer(self)) {
        self stoploopsound(0.5);
      }
    }

    self.var_14407070 = undefined;
  }
}

private onplayerspawned() {
  self.var_dc148218 = 0;
}