/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_stakeout_fx.gsc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace cp_ger_stakeout_fx;

function private autoexec __init__system__() {
  system::register(#"cp_ger_stakeout_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function private function_fa076c68() {}

function private function_bc948200() {
  clientfield::register("actor", "umbrella_drips", 1, 2, "int");
  clientfield::register("scriptmover", "police_headlights", 1, 1, "int");
  clientfield::register("vehicle", "police_headlights", 1, 1, "int");
  clientfield::register("scriptmover", "police_sirens", 1, 1, "int");
  clientfield::register("vehicle", "police_sirens", 1, 1, "int");
  clientfield::register("scriptmover", "clf_contact_cig_smoke", 1, 1, "int");
}

function function_22b7fffd() {
  animation::add_notetrack_func("cp_ger_stakeout_fx::umbrella_drips_on", &function_7ac85f6e);
  animation::add_notetrack_func("cp_ger_stakeout_fx::umbrella_drips_off", &function_a2a2a7e9);
}

function function_943c286e() {
  if(is_true(self.var_e00a27ab)) {
    return;
  }

  self.var_e00a27ab = 1;
  self clientfield::set("clf_contact_cig_smoke", 1);
  thread function_b428955a();
}

function function_b428955a() {
  if(!is_true(self.var_e00a27ab)) {
    return;
  }

  level waittill(#"hash_23cc6d8b29c98232");
  self.var_e00a27ab = undefined;
  self clientfield::set("clf_contact_cig_smoke", 0);
}

function function_7ac85f6e(params) {
  if(is_true(self.var_2f05f8b4)) {
    return;
  }

  self.var_2f05f8b4 = 1;

  if(params === "left") {
    self clientfield::set("umbrella_drips", 1);
    return;
  }

  if(params === "right") {
    self clientfield::set("umbrella_drips", 2);
    return;
  }

  assertmsg("<dev string:x38>");
}

function function_a2a2a7e9(params) {
  if(!is_true(self.var_2f05f8b4)) {
    return;
  }

  self.var_2f05f8b4 = undefined;
  self clientfield::set("umbrella_drips", 0);
}

function function_93e3e68a(on) {
  if(is_true(on)) {
    self clientfield::set("police_headlights", 1);
    return;
  }

  self clientfield::set("police_headlights", 0);
}

function function_ad03f35b(on) {
  if(is_true(on)) {
    self clientfield::set("police_sirens", 1);
    return;
  }

  self clientfield::set("police_sirens", 0);
}