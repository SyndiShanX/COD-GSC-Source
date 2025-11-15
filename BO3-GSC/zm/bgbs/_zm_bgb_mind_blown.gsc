/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_mind_blown.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_mind_blown;

function autoexec __init__sytem__() {
  system::register("zm_bgb_mind_blown", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("actor", "zm_bgb_mind_pop_fx", 15000, 1, "int");
  clientfield::register("actor", "zm_bgb_mind_ray_fx", 15000, 1, "int");
  bgb::register("zm_bgb_mind_blown", "activated", 3, undefined, undefined, & validation, & activation);
  level.var_3e825919 = lightning_chain::create_lightning_chain_params(0, 1, 300, 20, 100, 0.11, 10, 0, 4, 1, 0, undefined, 1, 1);
}

function validation() {
  if(isDefined(level.var_398d0113) && level.var_398d0113) {
    return false;
  }
  return true;
}

function activation() {
  self endon("disconnect");
  self thread function_2a8862aa();
  level thread function_80e37569();
}

function function_80e37569() {
  level.var_398d0113 = 1;
  wait(5);
  level.var_398d0113 = 0;
}

function function_2a8862aa() {
  self endon("disconnect");
  self endon("hash_7946ded7");
  var_bd6badee = 1200 * 1200;
  var_3c48f56 = [];
  allai = getaiarray();
  foreach(ai in allai) {
    if(isDefined(ai.var_5691b7d8) && ai[[ai.var_5691b7d8]]()) {
      continue;
    }
    if(distance2dsquared(ai.origin, self.origin) >= var_bd6badee) {
      continue;
    }
    if(isalive(ai) && !ai ispaused() && ai.team == level.zombie_team && ai.archetype === "zombie" && !ai ishidden() && (!(isDefined(ai.var_85934541) && ai.var_85934541))) {
      array::add(var_3c48f56, ai);
    }
  }
  var_e4760c66 = [];
  var_e37fbbbd = [];
  foreach(ai in var_3c48f56) {
    if(distance2dsquared(ai.origin, self.origin) >= var_bd6badee) {
      var_e4760c66[var_e4760c66.size] = ai;
      continue;
    }
    var_e37fbbbd[var_e37fbbbd.size] = ai;
  }
  function_2ca71d8b(var_e4760c66, 1);
  function_2ca71d8b(var_e37fbbbd, 0, 75);
}

function private function_2ca71d8b(allai, trace, degree = 45) {
  var_f1649153 = allai;
  players = getplayers();
  var_445b9352 = cos(degree);
  var_f1649153 = self cantseeentities(var_f1649153, var_445b9352, trace);
  foreach(ai in allai) {
    if(isinarray(var_f1649153, ai)) {
      continue;
    }
    thread function_1bb7ee0(ai);
  }
}

function function_1bb7ee0(ai) {
  ai.marked_for_death = 1;
  ai.var_85934541 = 1;
  ai.no_powerups = 1;
  ai.deathpoints_already_given = 1;
  ai.tesla_head_gib_func = & zombie_head_gib;
  ai lightning_chain::arc_damage(ai, self, 1, level.var_3e825919);
}

function zombie_head_gib() {
  self endon("death");
  self clientfield::set("zm_bgb_mind_ray_fx", 1);
  wait(randomfloatrange(0.65, 2.5));
  self clientfield::set("zm_bgb_mind_pop_fx", 1);
  self playsoundontag("zmb_bgb_mindblown_pop", "tag_eye");
  self zombie_utility::zombie_head_gib();
}