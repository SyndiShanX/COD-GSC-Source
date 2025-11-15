/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_door_lockdown.csc
*******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_door_lockdown;

autoexec __init__system__() {
  system::register(#"zm_trial_door_lockdown", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  clientfield::register("scriptmover", "" + #"zm_trial_door_lockdown", 16000, 1, "int", &zm_trial_door_lockdown, 0, 0);
  level._effect[#"hash_351debe7af1f588b"] = "maps/zm_escape/fx8_flame_wall_64x64";
  level._effect[#"hash_257bf4ae70b5a852"] = "maps/zm_escape/fx8_flame_wall_128x128";
  level._effect[#"hash_3ea271ae7eb7fdce"] = "maps/zm_escape/fx8_flame_wall_256x256";
  zm_trial::register_challenge(#"door_lockdown", &on_begin, &on_end);
}

private on_begin(localclientnum, a_params) {}

private on_end(localclientnum) {}

private zm_trial_door_lockdown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    v_forward = anglesToForward(self.angles);

    switch (self.model) {
      case #"collision_player_wall_64x64x10":
        var_b1e1a2db = level._effect[#"hash_351debe7af1f588b"];
        break;
      case #"collision_player_wall_128x128x10":
        var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
        break;
      case #"collision_player_wall_256x256x10":
        var_b1e1a2db = level._effect[#"hash_3ea271ae7eb7fdce"];
        break;
      default:
        var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
        break;
    }

    self.var_958e3374 = playFX(localclientnum, var_b1e1a2db, self.origin - (0, 0, 48), v_forward);
    return;
  }

  if(isDefined(self.var_958e3374)) {
    stopfx(localclientnum, self.var_958e3374);
    self.var_958e3374 = undefined;
  }
}