/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1c91b680ee44e52f.csc
***********************************************/

#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace namespace_df4fbf0;

function init() {
  function_cae618b4("spawner_zombietron_brutus");
  clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter", &brutus_shock_attack_player, 0, 0);
  clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter", &brutus_shock_attack_fx, 0, 0);
  footsteps::registeraitypefootstepcb(#"brutus", &function_6e2a738c);
}

function function_6e2a738c(localclientnum, pos, surface, notetrack, bone) {}

function brutus_shock_attack_player(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  function_36e4ebd4(bwasdemojump, "damage_heavy");
}

function brutus_shock_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(bwasdemojump);

  if(!isDefined(self)) {
    return;
  }

  playFX(bwasdemojump, "maps/zm_escape/fx8_alcatraz_brut_shock", self.origin, anglestoup(self.angles));
  earthquake(bwasdemojump, 1, 1, self.origin, 512);
}