/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_ajax.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\struct;
#include scripts\mp_common\gametypes\ct_ajax_tutorial;
#include scripts\mp_common\gametypes\ct_bots;
#include scripts\mp_common\gametypes\ct_core;
#include scripts\mp_common\gametypes\ct_gadgets;
#include scripts\mp_common\gametypes\ct_utils;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_utils;

#namespace ct_ajax;

event_handler[gametype_init] main(eventstruct) {
  ct_core::function_46e95cc7();
  level.select_character = ct_utils::get_roleindex(#"prt_mp_swatpolice");
  level.var_820c5561 = "AJAX";
  ct_utils::function_be3a76b7(level.var_820c5561);
  level.var_d6d98fbe = 0;
  level.debugbots = 0;
  ct_core::function_fa03fc55();
  level.var_4c2ecc6f = &function_6db6572b;
  level.var_c01b7f8b = &function_ba542258;
  level.var_49240db3 = &function_b89106ad;
  level.var_8b9d690e = &function_cf3224fe;
  level.onspawnplayer = &function_7c4ef26b;
  player::function_cf3aa03d(&function_9d65db70);
  level.var_cdb8ae2c = &ct_utils::function_a8da260c;
  level.resurrect_override_spawn = &ct_utils::function_78469779;
  level.var_e31c5d7a = &ct_bots::function_e31c5d7a;
  callback::on_game_playing(&ct_core::function_1e84c767);
  globallogic_spawn::addsupportedspawnpointtype("ct");
  ct_utils::function_6046a5e3(#"ar_accurate_t8", array(#"quickdraw", #"fmj", #"extbarrel"));
  ct_utils::function_c3e647e2(#"pistol_standard_t8");
  level flag::init("combat_training_started");
  level flag::init("mission_success");
  level flag::init("mission_failed");
  level flag::init("attack_event_active");
  level.fx_warlord_igc_ = 0.7;

  if(level.ctdifficulty == 0) {
    level ct_ajax_tutorial::init();
  }
}

function_7c4ef26b(predictedspawn) {
  if(level.ctdifficulty == 0) {
    self ct_ajax_tutorial::function_c9ff0dce();
    return;
  }

  setdvar(#"custom_killstreak_mode", 2);
  setdvar(#"custom_killstreak1", level.killstreakindices[#"uav"]);
  setdvar(#"custom_killstreak2", level.killstreakindices[#"satellite"]);
  setdvar(#"custom_killstreak3", level.killstreakindices[#"remote_missile"]);
  self thread ct_core::function_d2845186();
  spawning::onspawnplayer(predictedspawn);

  if(self.team == #"allies") {
    self thread function_7f166658();
    nd_node = function_5d9ec9e5();

    if(isDefined(nd_node)) {
      self setorigin(nd_node.origin);
      self setplayerangles(nd_node.angles);
    }
  } else if(level flag::get("attack_event_active")) {
    self function_bf0cfe30();
  }

  if(isbot(self)) {
    if(isDefined(level.var_e31c5d7a)) {
      self[[level.var_e31c5d7a]]();
    }
  }
}

function_9d65db70(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(level.ctdifficulty == 0) {
    self ct_ajax_tutorial::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(self.team == #"allies") {
    if(!isbot(self)) {
      self thread ct_utils::function_ee4639dd(-5);
    }

    return;
  }

  if(isDefined(weapon) && weapon == getweapon(#"sig_buckler_turret")) {
    e_player = getplayers()[0];
    e_player thread ct_utils::function_d471f8fa(2);
  }
}

function_6db6572b() {
  level.var_347db8b6 = 0;
}

function_ba542258(mode) {
  level flag::clear("mission_success");
  level flag::clear("mission_failed");
  level flag::clear("times_up");
  level flag::clear("attack_event_active");

  if(isDefined(level.var_1ecfe3a2)) {
    self.var_71a70093 = level.var_1ecfe3a2;
  }

  self thread ct_gadgets::function_19181566();
  self loadout::function_cdb86a18();
  level.var_1dccc4d3 = undefined;

  if(level.ctdifficulty !== 0) {
    self thread ct_utils::objcounter_init(undefined, 0, 3, 1);
  }

  level.var_8bd6a2ee = 0;
  level thread ct_utils::function_289b4b9f(#"hash_4bd6eabc52f9148b", 1, 45, undefined, &function_8f111670);
}

function_b89106ad(gamedifficulty) {
  level endon(#"combattraining_logic_finished");
  level notify(#"hash_2a473e02881ca991");
  level.usingscorestreaks = 0;
  level.disablescoreevents = 1;
  level.disablemomentum = 1;

  if(gamedifficulty == 0) {
    ct_ajax_tutorial::function_9b9525e9();
  } else {
    j_fore_le_01();
  }

  level notify(#"combattraining_logic_finished", {
    #success: 1
  });
}

function_cf3224fe(b_success) {
  ct_utils::get_player() ct_utils::function_8b7a2fdd();
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  var_cd803a6b = gettime();
  return var_cd803a6b;
}

j_fore_le_01() {
  level endon(#"combattraining_logic_finished");
  level.var_cbcb0078 = 1;
  level thread ct_utils::function_1db91571();
  level thread function_e268b155();
  level thread function_9e33a62();
  level.var_347db8b6 = 0;

  while(level.var_347db8b6 < 3) {
    function_7446a885();

    if(level flag::get("mission_success") || level flag::get("mission_failed")) {
      break;
    }

    e_player = getplayers()[0];
    e_player thread ct_utils::function_785eb2ca();

    if(level.var_347db8b6 + 1 < 3) {
      function_1082e3b7();
    }

    level.var_347db8b6++;
  }

  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);

  if(level flag::get("times_up") == 0) {
    level flag::set("mission_success");
    level notify(#"combattraining_logic_finished", {
      #success: 1
    });
    return;
  }

  level flag::set("mission_failed");
  level notify(#"combattraining_logic_finished", {
    #success: 0
  });
}

function_7446a885() {
  level flag::set("attack_event_active");
  n_time = function_17b486d1();
  n_bomb_timer = int(gettime() + 1000 + int(n_time * 1000));
  setmatchflag("bomb_timer_a", 1);
  setbombtimer("A", n_bomb_timer);
  level.var_cbcb0078 = 0;
  str_name = "s_attack_objective_" + level.var_347db8b6 + 1;
  var_d8e47fe3 = struct::get(str_name, "targetname");
  attack_waypoint = ct_utils::create_waypoint(#"hash_14f53e0433721169", var_d8e47fe3.origin, var_d8e47fe3.angles, #"any", undefined, 0, undefined);
  level.var_a8a15809 = var_d8e47fe3.origin;

  if(isDefined(level.var_571c3787) && level.var_571c3787) {
    level.var_cbcb0078 = 1;

    while(true) {
      e_player = getplayers()[0];
      n_dist = distance(e_player.origin, level.var_a8a15809);

      if(n_dist < 1000) {
        level thread function_8aa1c633();
        break;
      }

      waitframe(1);
    }

    level.var_571c3787 = undefined;
    level.var_cbcb0078 = 0;
  }

  level.var_e6db911d = 1;
  var_e8d6f89 = function_ecef370c();
  ct_bots::activate_bots(var_e8d6f89, #"axis");

  while(true) {
    a_bots = ct_bots::function_fbe3dcbb();

    if(a_bots.size == 0) {
      break;
    }

    if(level flag::get("times_up")) {
      level flag::set("mission_failed");
    }

    if(level flag::get("mission_failed")) {
      break;
    }

    waitframe(1);
  }

  attack_waypoint gameobjects::set_visible_team("none");
  level.var_cbcb0078 = 1;
  level flag::clear("attack_event_active");
}

function_1082e3b7() {
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  level.var_1dccc4d3 = undefined;
  level thread function_d5b13da7();
  level.var_e6db911d = 1;
  ct_bots::deactivate_bots();
  level thread ct_utils::function_bfa522d1(0);
  level.var_571c3787 = 1;
}

function_bf0cfe30() {
  nd_node = function_b2de37ed();
  self ct_utils::function_5b59f3b7(nd_node.origin, nd_node.angles, 256);
  self setorigin(nd_node.origin);
  self setplayerangles(nd_node.angles);
}

function_b2de37ed() {
  if(!isDefined(level.var_1dccc4d3)) {
    str_name = "attack_bot_node_" + level.var_347db8b6 + 1;
    level.var_1dccc4d3 = getnodearray(str_name, "targetname");
    level.var_e6871c2 = 0;
  }

  nd_node = level.var_1dccc4d3[level.var_e6871c2];
  level.var_e6871c2++;

  if(level.var_e6871c2 >= level.var_1dccc4d3.size) {
    level.var_e6871c2 = 0;
  }

  return nd_node;
}

function_ecef370c() {
  str_name = "attack_bot_node_" + level.var_347db8b6 + 1;
  var_54b979f2 = getnodearray(str_name, "targetname");
  return var_54b979f2.size;
}

function_5d9ec9e5() {
  if(!isDefined(level.var_347db8b6)) {
    return undefined;
  }

  str_name = "ajax_player_respawn_" + level.var_347db8b6 + 1;
  nd_node = getnode(str_name, "targetname");
  return nd_node;
}

function_8f111670() {
  if(level flag::get("attack_event_active") == 0) {
    return true;
  }

  if(isDefined(level.var_8bd6a2ee) && level.var_8bd6a2ee) {
    return true;
  }

  return false;
}

function_7f166658() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"weapon_change");

    if(isDefined(waitresult.weapon) && waitresult.weapon == getweapon(#"sig_buckler_dw")) {
      level.var_8bd6a2ee = 1;
    }
  }
}

function_17b486d1() {
  switch (level.var_347db8b6) {
    case 0:
      n_time = 35 - 1;
      break;
    case 1:
      n_time = 40 - 1;
      break;
    case 2:
      n_time = 45 - 1;
      break;
  }

  return n_time;
}

function_9e33a62() {
  level endon(#"combattraining_logic_finished");

  while(true) {
    level waittill(#"hash_ac034f4f7553641");
    e_player = getplayers()[0];
    e_player thread ct_utils::function_d471f8fa(3);
  }
}

function_d5b13da7() {
  e_player = getplayers(#"allies")[0];
  e_player thread ct_utils::function_329f9ba6(#"hash_7fa79308d4e0fd8", 5, "green");
}

function_8aa1c633() {
  e_player = getplayers(#"allies")[0];
  e_player thread ct_utils::function_329f9ba6(#"hash_443101fa69c21abf", 5, "green");
}

function_e268b155() {
  e_player = getplayers(#"allies")[0];
  e_player thread ct_utils::function_329f9ba6(#"hash_25fd00b5dda353c3", 5, "green");
}