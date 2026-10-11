/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_272e4f4980b32088.gsc
*************************************************/

#using script_638d701d263ee1ed;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\stealth\manager;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\player;
#using scripts\stealth\utility;
#namespace ob_stealth;

function function_fb9de2c84b81e225() {
  flag_init("stealth_enabled");
  flag_init("level_stealth_initialized");
  flag_init("stealth_spotted");
  scripts\cp_mp\stealth\manager::main();
  flag_set("level_stealth_initialized");
  callback::add("player_connect", &function_9835b18e8fd03f25);
  function_cdfd74e95368bd63(1);
  function_8368f8fe908ce8be(300);
  function_3c6ca4287e09d8b4(300);
  stealthsetdefaulttimetodropthreatsight(1000);
  function_c3c56969a259ab89(600);
  flag_wait("sentientpoolmanager_initialized");
  function_3d7d85d395df9243("Lethal_Static");
  setthreatbiasagainstall("Killstreak_Static", -10000);
  function_52eb45afb6040851();
  callback::add("on_zombie_ai_spawned", &function_c0aafded157c2f8a);
  callback::add("on_agent_spawned", &function_f2a020129a48ebdb);
  level scripts\stealth\utility::set_stealth_func("event_should_ignore", &function_7e42763f1b217a62);
}

function private function_7e42763f1b217a62(event) {
  if(event.receiver.unittype == "soldier") {
    return 0;
  }

  if(event.typeorig == "bulletwhizby") {
    return 1;
  }

  dist = distancesquared(event.receiver.origin, event.origin);

  if(event.typeorig == "footstep_walk") {
    var_3ff005c91ef572e3 = 375;

    if(isDefined(event.receiver.footstepdetectdistwalk) && event.receiver.footstepdetectdistwalk > 0) {
      var_3ff005c91ef572e3 = event.receiver.footstepdetectdistwalk;
    }

    if(dist > squared(var_3ff005c91ef572e3)) {
      return 1;
    }
  }

  if(event.typeorig == "footstep_sprint") {
    var_5430818c2f6b8ffa = 375;

    if(isDefined(event.receiver.footstepdetectdistsprint) && event.receiver.footstepdetectdistsprint > 0) {
      var_5430818c2f6b8ffa = event.receiver.footstepdetectdistsprint;
    }

    if(dist > squared(var_5430818c2f6b8ffa)) {
      return 1;
    }
  }

  return 0;
}

function private function_52eb45afb6040851() {
  hiddenranges["prone"] = 4000;
  hiddenranges["crouch"] = 6000;
  hiddenranges["stand"] = 8000;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 4000;
  spottedranges["crouch"] = 6000;
  spottedranges["stand"] = 8000;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
}

function private function_c0aafded157c2f8a(params) {
  self.var_b19befc7a8bfc30f = 1;
  self.var_f9723ce1df93efe4 = 1;

  if(!isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = function_60ec71076d4f96b6();
  }

  thread scripts\stealth\enemy::main();
  scripts\stealth\utility::set_stealth_func("should_hunt", &function_a7dc8702a26f1e8d);
}

function private function_f2a020129a48ebdb(params) {
  agent = params.agent;
  agent.var_275bfc58ce28d17a = 0;
}

function private function_a7dc8702a26f1e8d() {
  return false;
}

function private function_60ec71076d4f96b6() {
  region = namespace_4df2ab39b0e96ec7::get_region(self.origin);

  if(!isstring(region)) {
    region = "default_stealth_group_";
  }

  for(i = 0; i < 10; i++) {
    stealthgroup = region + i;
    a_grp = function_dbc2d928c8e424d9(stealthgroup);

    if(!isDefined(a_grp) || a_grp.members.size < 40) {
      return stealthgroup;
    }
  }
}

function private function_9835b18e8fd03f25(params) {
  scripts\stealth\player::main();
}