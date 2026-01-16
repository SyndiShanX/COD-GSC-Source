/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_nosferatu.csc
***********************************************/

#include scripts\core_common\ai\archetype_nosferatu;
#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_nosferatu;

autoexec __init__system__() {
  system::register(#"zm_ai_nosferatu", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "nosferatu_damage_fx", 8000, 1, "counter", &nosferatudamagefx, 0, 0);
  clientfield::register("actor", "nosferatu_spawn_fx", 8000, 1, "counter", &nosferatu_spawn_fx, 0, 0);
  clientfield::register("actor", "nfrtu_silver_hit_fx", 8000, 1, "counter", &function_6b82c26d, 0, 0);
  clientfield::register("actor", "summon_nfrtu", 8000, 1, "int", &function_4207e678, 0, 0);
  clientfield::register("actor", "nfrtu_move_dash", 8000, 1, "int", &function_a354a47f, 0, 0);
  ai::add_archetype_spawn_function(#"nosferatu", &function_5ec9aadb);
}

private function_6b82c26d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    util::playFXOnTag(localclientnum, "maps/zm_mansion/fx8_silver_hit_zombie", self, "j_spine4");
  }
}

private function_4207e678(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread function_3a03717(localclientnum);
    return;
  }

  self notify(#"stop_summon");
}

function_3a03717(localclientnum) {
  self notify(#"stop_summon");
  self endon(#"death", #"stop_summon");

  while(true) {
    e_player = function_5c10bd79(localclientnum);
    n_dist = distance(self.origin, e_player.origin);

    if(n_dist < 400) {
      function_36e4ebd4(localclientnum, "damage_light");
    }

    wait 0.5;
  }
}

private function_a354a47f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_b8cc5182 = util::playFXOnTag(localclientnum, "zm_ai/fx8_nosferatu_dash_eyes", self, "tag_eye");
    return;
  }

  if(isDefined(self.var_b8cc5182)) {
    stopfx(localclientnum, self.var_b8cc5182);
  }
}

private function_5ec9aadb(localclientnum) {
  if(zm_custom::function_901b751c(#"zmhealthregenrate") == 2 && zm_custom::function_901b751c(#"zmhealthregendelay") == 1) {
    level.var_371d767c = self ai::function_9139c839().var_52a41524;
  } else if(zm_custom::function_901b751c(#"zmhealthregendelay") == 0) {
    level.var_371d767c = 2;
  } else if(zm_custom::function_901b751c(#"zmhealthregendelay") == 2) {
    level.var_371d767c = 8;
  } else {
    level.var_371d767c = 4;
  }

  self callback::on_shutdown(&on_entity_shutdown);
}

private nosferatudamagefx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue && self util::function_50ed1561(localclientnum)) {
    self thread function_3468dc45(localclientnum);
  }
}

function_3468dc45(localclientnum) {
  self notify(#"nosferatu_damage_fx");
  self endon(#"death", #"disconnect", #"nosferatu_damage_fx");
  self endoncallback(&function_84346679, #"death", #"hash_70253e729ea3d013");

  if(!self postfx::function_556665f2("pstfx_zm_man_curse")) {
    self postfx::playpostfxbundle("pstfx_zm_man_curse");
  }

  if(!isDefined(self.var_222e996f)) {
    self playSound(localclientnum, #"hash_373ab869c634b58b");
    self.var_222e996f = self playLoopSound(#"hash_5b12d6dc3fd13c3d");
  }

  level waittilltimeout(level.var_371d767c, #"hash_7646638df88a3656");
  self notify(#"hash_70253e729ea3d013");
}

function_84346679(var_c34665fc) {
  if(self postfx::function_556665f2("pstfx_zm_man_curse")) {
    self postfx::exitpostfxbundle("pstfx_zm_man_curse");
  }

  if(isDefined(self.var_222e996f)) {
    localclientnum = self getlocalclientnumber();
    self playSound(localclientnum, #"hash_4f2c92409321076e");
    self stoploopsound(self.var_222e996f);
    self.var_222e996f = undefined;
  }
}

nosferatu_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, #"hash_611d887cc85e2cb8", self, "j_spine2");
  playSound(localclientnum, #"hash_15f98d1e471b4335", self.origin);
}

on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {}
}