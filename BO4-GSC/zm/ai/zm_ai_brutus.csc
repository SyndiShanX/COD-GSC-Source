/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_brutus.csc
***********************************************/

#include scripts\core_common\ai\archetype_brutus;
#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;

#namespace zm_ai_brutus;

autoexec __init__system__() {
  system::register(#"zm_ai_brutus", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter", &brutus_shock_attack_fx, 0, 0);
  clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int", &function_80adaab1, 0, 0);
  clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter", &brutus_shock_attack_player, 0, 0);
  footsteps::registeraitypefootstepcb(#"brutus", &function_6e2a738c);
}

function_80adaab1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval) {
    self.lightfx = util::playFXOnTag(localclientnum, "light/fx8_light_spot_brutus_flicker", self, "tag_spotlight");
    playFX(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
    return;
  }

  if(isDefined(self.lightfx)) {
    stopfx(localclientnum, self.lightfx);
  }

  playFX(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
}

brutus_shock_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  radius = self ai::function_9139c839().var_1709a39;

  if(!isDefined(radius)) {
    radius = 512;
  }

  playFX(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_shock", self.origin, anglestoup(self.angles));
  earthquake(localclientnum, 1, 1, self.origin, radius);
}

brutus_shock_attack_player(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  function_36e4ebd4(localclientnum, "damage_heavy");
}

function_6e2a738c(localclientnum, pos, surface, notetrack, bone) {
  a_players = getlocalplayers();

  for(i = 0; i < a_players.size; i++) {
    if(abs(self.origin[2] - a_players[i].origin[2]) < 128) {
      var_ed2e93e5 = a_players[i] getlocalclientnumber();

      if(isDefined(var_ed2e93e5)) {
        earthquake(var_ed2e93e5, 0.5, 0.1, self.origin, 1500);
        playrumbleonposition(var_ed2e93e5, "brutus_footsteps", self.origin);
      }
    }
  }
}