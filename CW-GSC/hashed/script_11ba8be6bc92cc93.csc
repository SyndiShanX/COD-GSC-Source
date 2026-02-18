/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_11ba8be6bc92cc93.csc
***********************************************/

#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2a445563;

function init() {
  function_cae618b4("spawner_zombietron_werewolf");
  clientfield::register("actor", "wrwlf_silver_death_fx", 1, 1, "int", &function_c65ce64a, 0, 0);
  clientfield::register("actor", "wrwlf_weakpoint_fx", 1, 2, "counter", &function_3f3f0d8, 0, 0);
  clientfield::register("actor", "wrwlf_silver_hit_fx", 1, 1, "counter", &function_39053880, 0, 0);
  clientfield::register("actor", "wrwlf_leap_attack_rumble", 1, 1, "counter", &function_e980911c, 0, 0);
  ai::add_archetype_spawn_function(#"werewolf", &function_d45ef8ea);
  footsteps::registeraitypefootstepcb(#"werewolf", &function_f4b140ab);
}

function function_d45ef8ea(localclientnum) {
  self.breath_fx = util::playFXOnTag(localclientnum, "zm_ai/fx8_werewolf_breath", self, "j_head");
  self.var_f87f8fa0 = "tag_eye";
  self zombie_eye_glow::function_3a020b0f(localclientnum, "rob_zm_eyes_orange", #"hash_524decea28717b7c");
  self callback::on_shutdown(&on_entity_shutdown);
  self playrenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
}

function on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {
    if(isDefined(self.breath_fx)) {
      stopfx(localclientnum, self.breath_fx);
    }

    self zombie_eye_glow::good_barricade_damaged(localclientnum);
  }

  self stoprenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
}

function function_c65ce64a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread function_815cc85c(fieldname);
  }
}

function function_815cc85c(localclientnum) {
  self zombie_eye_glow::good_barricade_damaged(localclientnum);
  self stoprenderoverridebundle("rob_zm_man_werewolf_nonboss_weakpoint");
  self playrenderoverridebundle("rob_zm_werewolf_dust");
}

function function_3f3f0d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    util::playFXOnTag(fieldname, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_chest_ws");
    return;
  }

  if(bwastimejump == 2) {
    util::playFXOnTag(fieldname, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_back_ws");
  }
}

function private function_39053880(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    util::playFXOnTag(fieldname, "maps/zm_mansion/fx8_silver_hit_werewolf", self, "j_spine4");
  }
}

function private function_f4b140ab(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(notetrack);
  n_dist = distancesquared(bone, e_player.origin);
  var_107019dc = sqr(1000);
  n_scale = (var_107019dc - n_dist) / var_107019dc;
  n_scale *= 0.25;

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(notetrack, n_scale, 0.1, bone, n_dist);

  if(n_scale <= 0.25 && n_scale > 0.2) {
    function_36e4ebd4(notetrack, "anim_med");
    return;
  }

  if(n_scale <= 0.2 && n_scale > 0.1) {
    function_36e4ebd4(notetrack, "damage_light");
    return;
  }

  function_36e4ebd4(notetrack, "damage_light");
}

function private function_e980911c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);
  n_dist = distancesquared(self.origin, e_player.origin);
  var_107019dc = sqr(500);
  n_scale = (var_107019dc - n_dist) / var_107019dc;
  n_scale = min(n_scale, 0.75);

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(bwastimejump, n_scale, 0.5, self.origin, n_dist, 1);

  if(n_scale >= 0.5) {
    function_36e4ebd4(bwastimejump, "damage_heavy");
    return;
  }

  function_36e4ebd4(bwastimejump, "damage_light");
}