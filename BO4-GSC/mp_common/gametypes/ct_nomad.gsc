/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_nomad.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawning_shared;
#include scripts\killstreaks\dog_shared;
#include scripts\mp_common\gametypes\ct_ai;
#include scripts\mp_common\gametypes\ct_bots;
#include scripts\mp_common\gametypes\ct_core;
#include scripts\mp_common\gametypes\ct_gadgets;
#include scripts\mp_common\gametypes\ct_nomad_tutorial;
#include scripts\mp_common\gametypes\ct_utils;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_utils;

#namespace ct_nomad;

event_handler[gametype_init] main(eventstruct) {
  ct_core::function_46e95cc7();
  level.select_character = ct_utils::get_roleindex(#"prt_mp_trapper");
  level.var_820c5561 = "NOMAD";
  ct_utils::function_be3a76b7(level.var_820c5561);
  level.var_f4bbd9a8[#"fail_timeover"] = #"hash_43308bd441c5527f";
  ct_core::function_fa03fc55();
  clientfield::register("actor", "warlord_radar_enable", 1, 1, "int");
  level.var_4c2ecc6f = &function_29b562bd;
  level.var_c01b7f8b = &function_e800c473;
  level.var_49240db3 = &function_99296cc0;
  level.var_8b9d690e = &function_50c46d66;
  level.onspawnplayer = &function_f8bfe7b4;
  player::function_cf3aa03d(&function_1779a8c2);
  level.var_cdb8ae2c = &ct_utils::function_a8da260c;
  level.resurrect_override_spawn = &ct_utils::function_78469779;
  level.var_e31c5d7a = &function_562b3e27;
  callback::on_game_playing(&ct_core::function_1e84c767);
  globallogic_spawn::addsupportedspawnpointtype("ct");
  level flag::init("combat_training_started");
  level.var_8d02c681 = &function_8d02c681;
  level.var_560ecf29 = &function_560ecf29;
  level.var_156f3cee = 1;
  level.var_403b73b4 = &function_403b73b4;
  ct_utils::function_6046a5e3(#"ar_stealth_t8", array(#"damage", #"extbarrel", #"rf", #"uber"));
  ct_utils::function_c3e647e2(#"pistol_standard_t8");
  level flag::init("mission_success");
  level flag::init("mission_failed");
  level flag::init("data_downloaded");
  level flag::init("hardpoint_active");
  level.fx_warlord_igc_ = 0.7;

  if(level.ctdifficulty == 0) {
    level ct_nomad_tutorial::init();
  }
}

function_562b3e27() {
  self thread function_8a349869();
}

function_8a349869() {
  ct_bots::function_e31c5d7a();

  if(isDefined(level.var_4d47c040)) {
    self.var_ef59b90 = 4;
    self.var_9a79d89d = level.var_4d47c040;
    self.var_5ab7c19c = (0, 0, 0);
    self.var_bab91f2 = 1200;
    self.var_59860ee1 = 8000;
    self.var_dd940df3 = 12000;
    self.var_bab91f2 = 800;

    while(true) {
      n_dist = distance(self.origin, level.var_4d47c040);

      if(n_dist <= self.var_bab91f2) {
        break;
      }

      waitframe(1);
    }

    self.var_bab91f2 = 1200;
  }
}

function_33b2a588() {
  level endon(#"combattraining_logic_finished");

  while(true) {
    if(isDefined(self.var_78db19c8) && self.var_78db19c8) {
      axis = getaiteamarray(#"axis");

      foreach(entity in axis) {
        entity.ignoreall = 0;
      }
    }

    waitframe(1);
  }
}

function_f8bfe7b4(predictedspawn) {
  self thread ct_core::function_d2845186();
  spawning::onspawnplayer(predictedspawn);

  if(level.ctdifficulty == 0) {
    self ct_nomad_tutorial::function_c9ff0dce();
    return;
  }

  if(self.team == #"allies") {
    if(level flag::get("hardpoint_active")) {
      self thread function_5ccd53d5();
    }

    self thread function_33b2a588();
  }

  if(isbot(self)) {
    if(isDefined(level.var_e31c5d7a)) {
      self[[level.var_e31c5d7a]]();
    }

    if(isDefined(self.var_9a79d89d)) {
      self function_795960e7();
    }
  }
}

function_1779a8c2(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(level.ctdifficulty == 0) {
    self ct_nomad_tutorial::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(self.team == #"allies") {
    self function_f71e7ad9();
    self thread ct_utils::function_ee4639dd(-10);
    return;
  }

  if(isDefined(einflictor) && isDefined(einflictor.isdog) && einflictor.isdog && isDefined(attacker)) {
    attacker thread ct_utils::function_d471f8fa(5, "DogKill", 1, "_dogkill");
    attacker thread ct_utils::function_329f9ba6(#"hash_4bc9eb282022bb61", 2, "green", 0);
    return;
  }

  if(isplayer(einflictor)) {
    einflictor ct_utils::function_d471f8fa(1, undefined, 1);
  }
}

function_29b562bd() {
  level thread function_a6b6f492();
}

function_e800c473(mode) {
  level flag::clear("mission_success");
  level flag::clear("mission_failed");
  level flag::clear("data_downloaded");
  level flag::clear("hardpoint_active");
  level flag::clear("times_up");
  level clientfield::set("area_arrows_specialist", 1);
  level.var_156f3cee = 1;
  level.var_9a533a40 = 0;

  if(isDefined(level.var_1ecfe3a2)) {
    self.var_71a70093 = level.var_1ecfe3a2;
  }

  self thread ct_gadgets::function_19181566();
  var_61ca8276 = 420000;
  self function_9270ab93(0, var_61ca8276);
  self loadout::function_cdb86a18();
  level thread ct_utils::function_289b4b9f(#"hash_4eacd78bb7b344fe", 22, 25, undefined, &function_f8f42b40);
  level.var_ebad4ea8 = gettime();
  level.var_bf36382a = 0;
}

function_9270ab93(var_db89c655, var_27875ecd) {
  var_e7cc5e43 = [];
  var_e7cc5e43[#"mp_frenetic"][1] = 360000;
  var_e7cc5e43[#"mp_frenetic"][2] = 270000;
  var_e7cc5e43[#"mp_frenetic"][3] = 180000;
  var_e7cc5e43[#"mp_offshore"][1] = 360000;
  var_e7cc5e43[#"mp_offshore"][2] = 270000;
  var_e7cc5e43[#"mp_offshore"][3] = 180000;
  var_e7cc5e43[#"mp_seaside"][1] = 360000;
  var_e7cc5e43[#"mp_seaside"][2] = 270000;
  var_e7cc5e43[#"mp_seaside"][3] = 180000;
  var_e7cc5e43[#"mp_silo"][1] = 360000;
  var_e7cc5e43[#"mp_silo"][2] = 270000;
  var_e7cc5e43[#"mp_silo"][3] = 180000;
  str_map = hash(getrootmapname());
  ct_utils::function_7a21ac57(var_db89c655, var_27875ecd, var_e7cc5e43[str_map][1], var_e7cc5e43[str_map][2], var_e7cc5e43[str_map][3]);
}

function_99296cc0(gamedifficulty) {
  level endon(#"combattraining_logic_finished");
  level.var_e6db911d = 0;
  level notify(#"hash_2a473e02881ca991");
  level.usingscorestreaks = 0;
  level.disablescoreevents = 1;
  level.disablemomentum = 1;

  if(gamedifficulty == 0) {
    ct_nomad_tutorial::function_9b9525e9();
  } else {
    function_a898afdc();
  }

  level notify(#"combattraining_logic_finished", {
    #success: 1
  });
}

function_50c46d66(b_success) {
  level.var_156f3cee = 1;
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);

  foreach(tripwire in level.tripwires) {
    if(!isDefined(tripwire)) {
      continue;
    }

    tripwire delete();
  }

  level.tripwires = [];
  level.var_38c87b5 = b_success && level.var_bf36382a;
  var_cd803a6b = gettime() - level.var_ebad4ea8;
  return var_cd803a6b;
}

function_a898afdc() {
  level.var_cbcb0078 = 1;
  e_player = getplayers()[0];
  e_player ct_utils::objcounter_init(undefined, 0, 3, 1);
  level thread ct_utils::function_1db91571();

  for(i = 0; i < 3; i++) {
    var_edc95125 = "vol_hardpoint_" + i + 1;
    function_be529164(var_edc95125);
    function_86a5d2b9();
    level thread function_d2ae88f1();
    level thread function_30e4da9a(i);
    level thread function_62e9842e(i);
    level thread function_1ca79c02(var_edc95125);
    n_start_time = gettime() / 1000;

    while(true) {
      if(level flag::get("data_downloaded")) {
        break;
      }

      if(level flag::get("mission_failed")) {
        break;
      }

      if(level flag::get("times_up")) {
        level flag::set("mission_failed");
        break;
      }

      waitframe(1);
    }

    if(level flag::get("mission_failed")) {
      break;
    }

    e_player = getplayers()[0];
    e_player thread ct_utils::function_785eb2ca();
    level notify(#"hardpoint_completed");
    level.var_156f3cee++;

    if(level.var_156f3cee <= 3) {
      function_37adbd8f();
    }
  }

  level clientfield::set("area_arrows", 0);
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);

  if(level flag::get("data_downloaded")) {
    level flag::set("mission_success");
    return;
  }

  level flag::set("mission_failed");
  wait 0.1;
  level notify(#"combattraining_logic_finished", {
    #success: 0
  });
}

function_be529164(var_edc95125) {
  level clientfield::set("area_arrows", level.var_156f3cee);
  n_bomb_timer = int(gettime() + 1000 + int(function_86c4ebb2() * 1000));
  setmatchflag("bomb_timer_a", 1);
  setbombtimer("A", n_bomb_timer);
  level flag::clear("data_downloaded");
  var_511a3f1c = getent(var_edc95125, "targetname");
  level.var_4d47c040 = var_511a3f1c.origin;
  level.var_133aacc1 = ct_utils::create_waypoint(#"hash_15f6e3728e503f47", level.var_4d47c040, (0, 0, 0), #"any", undefined, 0, undefined);
}

function_37adbd8f() {
  level clientfield::set("area_arrows", 0);
  level.var_e6db911d = 1;
  a_bots = ct_bots::function_fbe3dcbb();

  foreach(bot in a_bots) {
    bot dodamage(bot.health + 100, bot.origin);
  }

  level thread ct_utils::function_bfa522d1(0);
  level thread function_61011245();
  wait 2;
}

function_1ca79c02(var_edc95125) {}

function_86a5d2b9() {
  level endon(#"combattraining_logic_finished");
  level.var_bd6e4af0 = 0;
  e_player = getplayers()[0];
  e_player thread function_85eb0847();
  e_player thread function_764aabbc();

  while(true) {
    if(!isalive(e_player)) {
      while(!isalive(e_player)) {
        waitframe(1);
        e_player = getplayers()[0];
      }

      e_player thread function_85eb0847();
      e_player thread function_764aabbc();
    }

    if(level.var_bd6e4af0 >= 4) {
      break;
    }

    waitframe(1);
  }

  level notify(#"tripwires_planted");
}

function_85eb0847() {
  self endon(#"death");
  level endon(#"hardpoint_completed", #"combattraining_logic_finished");

  while(true) {
    self waittill(#"tripwire_spawn");
    level.var_bd6e4af0++;
    level.var_12cf0f6f = 1;
  }
}

function_5b0597d0(var_511a3f1c) {
  level.var_5a623458 = 1;

  while(true) {
    e_player = getplayers(#"allies")[0];

    if(e_player istouching(var_511a3f1c)) {
      break;
    }

    waitframe(1);
  }

  level.var_5a623458 = 0;
  level flag::set("hardpoint_active");
}

spawn_warlords(var_c03b0783, var_97f91376) {
  for(i = 0; i < var_c03b0783; i++) {
    v_pos = var_97f91376[i].origin;
    v_angles = var_97f91376[i].angles;
    level thread ct_ai::spawn_warlord(v_pos, v_angles);
  }
}

function_30e4da9a(var_4d4513ee) {
  var_c03b0783 = [];
  var_c03b0783[0] = 1;
  var_c03b0783[1] = 2;
  var_c03b0783[2] = 2;
  var_ec102dab = var_c03b0783[var_4d4513ee];
  level waittill(#"hash_7fb8a9f892ea26f9");
  level thread function_d485c784();
  level.var_42a4603 = &function_42a4603;
  var_7716dee7 = "warlord_spawn_point_" + var_4d4513ee + 1;
  var_97f91376 = getnodearray(var_7716dee7, "targetname");
  var_97f91376 = array::randomize(var_97f91376);
  level thread spawn_warlords(var_ec102dab, var_97f91376);
}

function_42a4603() {
  self endon(#"death");
  self clientfield::set("warlord_radar_enable", 1);
  self thread function_9e0ccd9b();
  self.var_1574ae06 = 1;
  e_player = getplayers()[0];
  self.var_9a79d89d = e_player.origin;
  self.var_5ab7c19c = e_player.angles;
  self.var_bab91f2 = 500;
  self thread ct_bots::function_956b904a();
  wait 12;
  self.var_1574ae06 = undefined;
  self.var_bab91f2 = 1200;
}

function_9e0ccd9b() {
  self endon(#"death");
  level flag::wait_till_clear("hardpoint_active");
  self.var_857e12cc = 1;
  self dodamage(self.health + 100, self.origin);
}

function_62e9842e(var_4d4513ee) {
  var_e8d6f89 = [];
  var_e8d6f89[0] = 1;
  var_e8d6f89[1] = 4;
  var_e8d6f89[2] = 4;
  var_7f5c713a = var_e8d6f89[var_4d4513ee];
  level waittill(#"hash_7fb8a9f892ea26f9");
  n_start_time = gettime() / 1000;

  while(true) {
    n_time = gettime() / 1000;
    dt = n_time - n_start_time;

    if(dt > 22) {
      break;
    }

    if(dt > 5) {
      a_ai = getaiarray();
      var_c03b0783 = 0;

      foreach(ai in a_ai) {
        if(ai.archetype == #"warlord") {
          var_c03b0783++;
        }
      }

      if(var_c03b0783 == 0) {
        break;
      }
    }

    waitframe(1);
  }

  e_player = getplayers()[0];
  e_player thread ct_utils::function_329f9ba6(#"hash_3701a39ca23497ed", 5, "red", 2);
  wait 3;
  a_ai = getaiarray();

  if(a_ai.size > 0) {
    level thread ct_bots::activate_bots(2, #"axis");

    while(a_ai.size > 0) {
      a_ai = getaiarray();
      waitframe(1);
    }

    level thread ct_bots::activate_bots(var_7f5c713a - 2, #"axis");
    return;
  }

  level thread ct_bots::activate_bots(var_7f5c713a, #"axis");
}

function_403b73b4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isDefined(self.var_857e12cc) && self.var_857e12cc || isDefined(weapon) && weapon == getweapon(#"eq_tripwire") && smeansofdeath != "MOD_IMPACT") {
    idamage = 10000;
    e_player = getplayers()[0];
    e_player thread ct_utils::function_d471f8fa(10, undefined, 1, "_killedwarlord");
    e_player thread ct_utils::function_329f9ba6(#"hash_592d203c0744194b", 2, "green", 1);
    level thread ct_utils::function_bfa522d1(0);

    if(!(isDefined(level.var_bf36382a) && level.var_bf36382a)) {
      level.players[0] potm::bookmark(#"ct_nomad", gettime(), level.players[0]);
      level.var_bf36382a = 1;
    }
  } else {
    if(isDefined(einflictor) && isplayer(einflictor)) {
      self thread function_f44e6cdf();
    }

    idamage = 0;
  }

  self.ignoreall = 0;
  return idamage;
}

function_5ccd53d5() {}

function_d3aa2fd3() {
  var_7716dee7 = "player_spawn_point_" + level.var_156f3cee;
  var_b74696c9 = getnodearray(var_7716dee7, "targetname");
  var_b74696c9 = array::randomize(var_b74696c9);
  a_bots = ct_bots::function_fbe3dcbb();
  var_3fe7e48b = var_b74696c9.size;
  var_70eb710b = 0;
  e_player = getplayers(#"allies")[0];

  while(var_70eb710b < var_3fe7e48b) {
    nd_spawn = var_b74696c9[var_70eb710b];
    var_d057e192 = 1;

    foreach(bot in a_bots) {
      n_dist = distance(nd_spawn.origin, bot.origin);

      if(n_dist < 800) {
        var_d057e192 = 0;
        break;
      }
    }

    if(var_d057e192) {
      break;
    }

    var_70eb710b++;
  }

  e_player setorigin(nd_spawn.origin);
  e_player setplayerangles(nd_spawn.angles);
}

function_f71e7ad9() {
  var_7716dee7 = "player_spawn_point_" + level.var_156f3cee;
  var_b74696c9 = getnodearray(var_7716dee7, "targetname");
  var_b74696c9 = array::randomize(var_b74696c9);
  nd_spawn = var_b74696c9[0];
  self.var_6b6241ac = nd_spawn.origin;
  self.var_45cac770 = nd_spawn.angles;
  return true;
}

function_795960e7() {
  if(!isDefined(level.var_736740f3)) {
    level.var_736740f3 = 0;
  }

  var_7716dee7 = "bot_spawn_point_" + level.var_156f3cee;
  var_b74696c9 = getnodearray(var_7716dee7, "targetname");
  e_player = getplayers()[0];
  var_70eb710b = 0;

  while(true) {
    if(level.var_736740f3 >= var_b74696c9.size) {
      level.var_736740f3 = 0;
    }

    nd_spawn = var_b74696c9[level.var_736740f3];
    level.var_736740f3++;
    n_dist = distance(e_player.origin, self.origin);

    if(n_dist > 700 && !e_player cansee(self)) {
      break;
    }

    var_70eb710b++;

    if(var_70eb710b >= 3) {
      break;
    }
  }

  self setorigin(nd_spawn.origin);
  self setplayerangles(nd_spawn.angles);
}

function_8d02c681() {
  level notify(#"dog_spawned", {
    #dog: self
  });
  self thread function_bb7fe568();
  self thread function_2ff69a5d();
}

function_560ecf29(owner) {
  angles = owner getplayerangles();
  forwarddir = anglesToForward(angles);
  var_84e7232 = owner.origin + vectorscale(forwarddir, 100);
  closest = getclosestpointonnavmesh(var_84e7232, 200);

  if(isDefined(closest)) {
    return {
      #origin: closest, 
      #angles: owner.angles
    };
  }

  return undefined;
}

function_2ff69a5d() {
  self endon(#"death");
  level flag::wait_till_any(array("mission_success", "mission_failed"));
  self dog::function_441cdbb6();
  wait 0.5;
}

function_bb7fe568() {
  level.var_b418a53e = 1;
  self waittill(#"death");
  level.var_b418a53e = 0;
}

function_f8f42b40() {
  if(isDefined(level.var_b418a53e) && level.var_b418a53e) {
    return true;
  }

  if(level flag::get("hardpoint_active") == 0) {
    return true;
  }

  return false;
}

function_86c4ebb2() {
  return 120 - 1;
}

function_f44e6cdf() {
  self endon(#"death");

  if(!isDefined(level.var_589def91)) {
    level.var_589def91 = -10000;
  }

  n_time = gettime() / 1000;
  dt = n_time - level.var_589def91;

  if(dt < 40) {
    return;
  }

  level.var_589def91 = n_time;
  e_player = getplayers(#"allies")[0];
  e_player endon(#"death");
  e_player ct_utils::function_329f9ba6(#"hash_7c4a814a0a5e844a", 3, "red");
}

function_d485c784() {
  e_player = getplayers(#"allies")[0];
  e_player endon(#"death");
  e_player ct_utils::function_329f9ba6(#"hash_2dfd1305d6a5cf37", 5, "red", 2);
}

function_61011245() {
  e_player = getplayers(#"allies")[0];
  e_player endon(#"death");
  e_player ct_utils::function_329f9ba6(#"hash_45beec294727759e", 4, "green", 1);
}

function_d2ae88f1() {
  wait 1;
  e_player = getplayers(#"allies")[0];
  e_player endon(#"death");
  e_player ct_utils::function_329f9ba6(#"hash_137035fcfbcfbfa7", 4, "green", 2);
}

function_764aabbc() {
  self endon(#"death");

  if(isDefined(level.var_d08f855b) && level.var_d08f855b) {
    self ct_utils::function_a7d0e0f3();
    waitframe(1);
  }

  level.var_d08f855b = 1;
  self thread ct_utils::function_329f9ba6(#"hash_65db26ed106e82cd", 10000, "green", 2);
  level waittill(#"tripwires_planted");
  self thread ct_utils::function_415cd308(0.1, "green", 2);
  level.var_d08f855b = 0;
}

function_a6b6f492() {
  level thread scene::init(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_vines_01_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_vines_02_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_vines_03_bundle");
  level thread scene::init(#"p8_fxanim_mp_frenetic_rock_slide_bundle");
  level waittill(#"desc_countdown_start");
  level scene::add_scene_func(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle", &function_dd64960c, "play");
  level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_01_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_02_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_solar_panels_delay_03_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_vines_01_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_vines_02_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_vines_03_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_rock_slide_bundle");
  level thread scene::play(#"p8_fxanim_mp_frenetic_flyaway_tarp_bundle");
}

function_dd64960c(a_ents) {
  if(isDefined(a_ents[#"prop 1"])) {
    var_7425591a = a_ents[#"prop 1"] gettagorigin("tarp_06_jnt") + (0, 0, -8);
    a_ents[#"prop 1"] waittill(#"physics_pulse", #"death");
    physicsexplosionsphere(var_7425591a, 1024, 1, 1);
  }
}