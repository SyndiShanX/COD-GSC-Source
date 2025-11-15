/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_werewolf.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_werewolf;

autoexec __init__system__() {
  system::register(#"zm_ai_werewolf", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "wrwlf_silver_death_fx", 8000, 1, "int", &function_c65ce64a, 0, 0);
  clientfield::register("actor", "wrwlf_weakpoint_fx", 8000, 2, "counter", &function_3f3f0d8, 0, 0);
  clientfield::register("actor", "wrwlf_silver_hit_fx", 8000, 1, "counter", &function_39053880, 0, 0);
  clientfield::register("actor", "wrwlf_leap_attack_rumble", 8000, 1, "counter", &function_e980911c, 0, 0);
  ai::add_archetype_spawn_function(#"werewolf", &function_d45ef8ea);
  footsteps::registeraitypefootstepcb(#"werewolf", &function_f4b140ab);
}

function_d45ef8ea(localclientnum) {
  self.breath_fx = util::playFXOnTag(localclientnum, "zm_ai/fx8_werewolf_breath", self, "j_head");
  self.var_f87f8fa0 = "tag_eye";
  self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_orange", #"hash_524decea28717b7c");
  self callback::on_shutdown(&on_entity_shutdown);
  self playrenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
}

on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {
    if(isDefined(self.breath_fx)) {
      stopfx(localclientnum, self.breath_fx);
    }

    self zm_utility::good_barricade_damaged(localclientnum);
  }

  self stoprenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
}

function_c65ce64a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_815cc85c(localclientnum);
  }
}

function_815cc85c(localclientnum) {
  self zm_utility::good_barricade_damaged(localclientnum);
  self stoprenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
  self playrenderoverridebundle("rob_zm_werewolf_dust");
}

function_3f3f0d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    util::playFXOnTag(localclientnum, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_chest_ws");
    return;
  }

  if(newval == 2) {
    util::playFXOnTag(localclientnum, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_back_ws");
  }
}

private function_39053880(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    util::playFXOnTag(localclientnum, "maps/zm_mansion/fx8_silver_hit_werewolf", self, "j_spine4");
  }
}

private function_f4b140ab(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  var_107019dc = 1000 * 1000;
  n_scale = (var_107019dc - n_dist) / var_107019dc;
  n_scale *= 0.25;

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(localclientnum, n_scale, 0.1, pos, n_dist);

  if(n_scale <= 0.25 && n_scale > 0.2) {
    function_36e4ebd4(localclientnum, "anim_med");
    return;
  }

  if(n_scale <= 0.2 && n_scale > 0.1) {
    function_36e4ebd4(localclientnum, "damage_light");
    return;
  }

  function_36e4ebd4(localclientnum, "damage_light");
}

private function_e980911c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(localclientnum);
  n_dist = distancesquared(self.origin, e_player.origin);
  var_107019dc = 500 * 500;
  n_scale = (var_107019dc - n_dist) / var_107019dc;
  n_scale = min(n_scale, 0.75);

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(localclientnum, n_scale, 0.5, self.origin, n_dist, 1);

  if(n_scale >= 0.5) {
    function_36e4ebd4(localclientnum, "zm_shield_break");
    return;
  }

  function_36e4ebd4(localclientnum, "damage_light");
}