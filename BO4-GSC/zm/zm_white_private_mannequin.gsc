/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_private_mannequin.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_computer_system;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_white_private_mannequin;

autoexec __init__system__() {
  system::register(#"zm_white_private_mannequin", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("world", "" + #"hash_681de2aa531ffcd0", 20000, 1, "int");
}

__main__() {
  if(!zm_utility::is_ee_enabled()) {
    delete_entities();
    return;
  }

  init_flags();
  init_quest();
  init_vo();
}

init_vo() {
  level.var_9acf4bf7 = array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
  level.var_9acf4bf7 = array::randomize(level.var_9acf4bf7);
  level.var_ebab3906 = 0;
  level.var_a73770b4 = array(0, 1, 2, 3, 4);
  level.var_a73770b4 = array::randomize(level.var_a73770b4);
  level.var_1dcefa7 = 0;
  callback::on_connect(&function_e453faa6);
  callback::on_ai_killed(&function_d5faedec);
}

init_flags() {
  level flag::init(#"hash_3ee874ebee843004");
  level flag::init(#"hash_315d0bf1d50724f0");
  level flag::init(#"hash_359cbec050523f4");
  level flag::init(#"hash_130656ec8ad5480d");
  level flag::init(#"hash_6202f3e00d7008b0");
  level flag::init(#"hash_1b68ccd211cab219");
  level flag::init(#"hash_7524c96c167377ef");
}

init_quest() {
  var_e3d10631 = getEntArray("private_mannequin_parts", "targetname");

  foreach(e_part in var_e3d10631) {
    e_part hide();
  }

  level thread function_8527738e();
  s_pernell_key = struct::get("pernell_key");
  s_pernell_drawer = struct::get("pernell_drawer");

  if(isDefined(s_pernell_key) && isDefined(s_pernell_drawer)) {
    level flag::init("pernell_key_acquired");
    s_pernell_key zm_unitrigger::create("", 64);
    s_pernell_key thread function_eb06b83();
    zm_unitrigger::function_89380dda(s_pernell_key.s_unitrigger, 1);
    s_pernell_drawer zm_unitrigger::create("", 64);
    s_pernell_drawer thread function_65066810();
    zm_unitrigger::function_89380dda(s_pernell_drawer.s_unitrigger, 1);
  }

  level.mannequin_ally_spawner = getent("mannequin_ally_spawner", "targetname");
  level.var_777acf92 = level.mannequin_ally_spawner;
  zm_sq::register(#"private_mannequin_program", #"step_1", #"private_mannequin_step1", &private_mannequin_step1_setup, &private_mannequin_step1_cleanup);
  zm_sq::register(#"private_mannequin_program", #"step_2", #"private_mannequin_step2", &private_mannequin_step2_setup, &private_mannequin_step2_cleanup);
  zm_sq::start(#"private_mannequin_program");
}

delete_entities() {
  var_c000b3f5 = getEntArray("private_mannequin_program_code", "targetname");

  foreach(var_3984178 in var_c000b3f5) {
    var_3984178 delete();
  }

  var_c000b3f5 = getEntArray("sawyer_authorization_code", "targetname");

  foreach(var_3984178 in var_c000b3f5) {
    var_3984178 delete();
  }

  var_c000b3f5 = getEntArray("pernell_authorization_code", "targetname");

  foreach(var_3984178 in var_c000b3f5) {
    var_3984178 delete();
  }

  var_c000b3f5 = getEntArray("mccain_authorization_code", "targetname");

  foreach(var_3984178 in var_c000b3f5) {
    var_3984178 delete();
  }

  var_e3d10631 = getEntArray("private_mannequin_parts", "targetname");
  var_f0aefc5c = getent("pernell_key", "targetname");
  var_6e32b553 = getent("pernell_drawer", "targetname");
  mannequin_ally_spawner = getent("mannequin_ally_spawner", "targetname");

  foreach(e_part in var_e3d10631) {
    e_part delete();
  }

  var_f0aefc5c delete();
  var_6e32b553 delete();
  mannequin_ally_spawner delete();
}

private_mannequin_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    while(!flag::get(#"hash_130656ec8ad5480d")) {
      level flag::wait_till(#"hash_3ee874ebee843004");

      iprintlnbold("<dev string:x38>");

        level play_start_vo();
      level thread timer_countdown();
      level clientfield::set("" + #"hash_681de2aa531ffcd0", 1);
      a_flags = array(#"hash_315d0bf1d50724f0", #"hash_7524c96c167377ef");
      level flag::wait_till_any(a_flags);

      if(flag::get(#"hash_315d0bf1d50724f0")) {

        iprintlnbold("<dev string:x83>");

          level flag::set(#"hash_7524c96c167377ef");
        level.countdown_clock zm_white_computer_system::function_9b1511fa();
        level function_d1086c12();
        level thread timer_countdown();
      } else {
        reset_codes();
        continue;
      }

      a_flags = array(#"hash_359cbec050523f4", #"hash_7524c96c167377ef");
      level flag::wait_till_any(a_flags);

      if(flag::get(#"hash_359cbec050523f4")) {

        iprintlnbold("<dev string:xa8>");

          level flag::set(#"hash_7524c96c167377ef");
        level.countdown_clock zm_white_computer_system::function_9b1511fa();
        level function_5de15b91();
        level thread timer_countdown();
      } else {
        reset_codes();
        continue;
      }

      a_flags = array(#"hash_130656ec8ad5480d", #"hash_7524c96c167377ef");
      level flag::wait_till_any(a_flags);

      if(flag::get(#"hash_130656ec8ad5480d")) {

        iprintlnbold("<dev string:xce>");

          level flag::set(#"hash_7524c96c167377ef");
        level.countdown_clock zm_white_computer_system::function_9b1511fa();
        level thread visit_prototype_minigun();
        continue;
      }

      reset_codes();
      continue;
    }
  }
}

private_mannequin_step1_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"hash_3ee874ebee843004");
    level flag::set(#"hash_315d0bf1d50724f0");
    level flag::set(#"hash_130656ec8ad5480d");
    level flag::set(#"hash_130656ec8ad5480d");
  }
}

timer_countdown() {
  level flag::clear(#"hash_7524c96c167377ef");
  self endon(#"hash_7524c96c167377ef");
  level.countdown_clock zm_white_computer_system::clock_countdown();

  iprintlnbold("<dev string:xf6>");

    level flag::set(#"hash_7524c96c167377ef");
}

reset_codes() {

  iprintlnbold("<dev string:x11b>");

    level flag::clear(#"hash_3ee874ebee843004");
  level flag::clear(#"hash_315d0bf1d50724f0");
  level flag::clear(#"hash_130656ec8ad5480d");
  level flag::clear(#"hash_130656ec8ad5480d");
  level.var_f13364b4.a_n_codes[level.var_f13364b4.var_8deb4ed2].var_544c05c6 = 1;
  level.var_f13364b4.a_n_codes[level.var_f13364b4.var_a7450be4].var_544c05c6 = 1;
  level.var_f13364b4.a_n_codes[level.var_f13364b4.var_72c3e48c].var_544c05c6 = 1;
  level.var_f13364b4.a_n_codes[level.var_f13364b4.var_98e79e76].var_544c05c6 = 1;
}

function_eb06b83() {
  level endon(#"end_game");
  self endon(#"death");
  s_waitresult = self waittill(#"trigger_activated");
  e_who = s_waitresult.e_who;
  e_who playSound("zmb_ee_key_pickup");
  e_who thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
  level flag::set("pernell_key_acquired");
  zm_ui_inventory::function_7df6bb60("zm_white_private_mannequin_key_part", 1);
  var_f0aefc5c = getent("pernell_key", "targetname");

  if(isDefined(var_f0aefc5c)) {
    var_f0aefc5c delete();
  }

  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  self struct::delete();
}

function_65066810() {
  level flag::wait_till("pernell_key_acquired");
  s_waitresult = self waittill(#"trigger_activated");
  e_who = s_waitresult.e_who;
  var_6e32b553 = getent("pernell_drawer", "targetname");

  if(isDefined(var_6e32b553)) {
    var_7b8000e5 = anglestoright(var_6e32b553.angles) * 16;
    var_6e32b553 playSound("zmb_ee_drawer_open");
    var_6e32b553 moveto(var_6e32b553.origin + var_7b8000e5, 0.33);
  }

  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  self struct::delete();
}

play_start_vo() {
  self endon(#"hash_78e2cadb25129fa2");
  level zm_hms_util::function_3c173d37();
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_start", 0, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_start", 1, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_start", 2, 0, 1);
}

function_d1086c12() {
  self notify(#"hash_78e2cadb25129fa2");
  self endon(#"hash_78e2cadb25129fa2");
  level zm_hms_util::function_3c173d37();
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_sawyer", 0, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_sawyer", 1, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_sawyer", 2, 0, 1);
}

function_5de15b91() {
  self notify(#"hash_78e2cadb25129fa2");
  self endon(#"hash_78e2cadb25129fa2");
  level zm_hms_util::function_3c173d37();
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_mccain", 0, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_mccain", 1, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_mccain", 2, 0, 1);
}

visit_prototype_minigun() {
  self notify(#"hash_78e2cadb25129fa2");
  self endon(#"hash_78e2cadb25129fa2");
  level zm_hms_util::function_3c173d37();
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_pernell", 0, 0, 1);
  level.var_5dd0d3ff zm_hms_util::function_6a0d675d("vox_adam_code_pernell", 1, 0, 1);
  level.var_f13364b4.var_12633dc5 zm_hms_util::function_51b752a9("vox_adam_code_pernell", 2, 0);
}

private_mannequin_step2_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level thread function_88265619();
    level flag::wait_till(#"hash_6202f3e00d7008b0");
  }
}

private_mannequin_step2_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    if(!isDefined(level.var_f5746584)) {
      level thread function_88265619();
    }
  }
}

function_a51b6403(is_opening) {
  if(!isDefined(self.v_start_pos)) {
    self.v_start_pos = self.origin;
  }

  if(is_opening) {
    self playSound("evt_bunker_door_interior_open");
    self moveto(self.v_start_pos + (0, 0, -128), 1);
    return;
  }

  self playSound("evt_bunker_door_interior_close");
  self moveto(self.v_start_pos, 1);
}

function_11862a9b(e_player) {
  if(level.var_f5746584 == 0) {
    self sethintstring(#"hash_5ebbcacfe7506b1b");
  } else {
    self sethintstring(#"hash_17a473c2067a81f1", 3000);
  }

  return true;
}

function_1e88595a() {
  level flag::clear(#"hash_6202f3e00d7008b0");

  do {
    var_6ba58f5f = 0;
    s_waitresult = self waittill(#"trigger_activated");
    e_who = s_waitresult.e_who;

    if(!e_who zm_score::can_player_purchase(self.s_unitrigger.cost)) {
      zm_utility::play_sound_on_ent("no_purchase");
      e_who zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      continue;
    }

    e_who zm_score::minus_to_player_score(self.s_unitrigger.cost);
    e_who thread adam_activated_vo();
    var_6ba58f5f = 1;
  }
  while(!var_6ba58f5f);

  self.var_1a612d42 = e_who;
  level flag::set(#"hash_6202f3e00d7008b0");
}

function_eaa63f5b(n_minutes = 1) {

  iprintlnbold("<dev string:x156>" + n_minutes + "<dev string:x178>");

    n_time_end = gettime() + n_minutes * 60 * 1000;
  level flag::set(#"hash_1b68ccd211cab219");

  while(true) {
    if(gettime() > n_time_end && !(isDefined(self) && isDefined(self.reviving_a_player) && self.reviving_a_player)) {
      if(isDefined(self) && isalive(self)) {
        util::stop_magic_bullet_shield(level.mannequin_ally);
        self kill();
        level.mannequin_ally = undefined;
      }

      level flag::clear(#"hash_1b68ccd211cab219");

      iprintlnbold("<dev string:x187>");

        break;
    }

    wait 10;
  }
}

function_88265619() {
  level endon(#"game_ended", #"hash_48039f3a4c1a3248");
  level.var_f5746584 = 0;
  var_e3d10631 = getEntArray("private_mannequin_parts", "targetname");
  var_a2c75164 = getent("mannequin_ally_door", "targetname");
  assert(isDefined(var_a2c75164), "<dev string:x1a4>");

  while(true) {
    level flag::wait_till_clear(#"hash_1b68ccd211cab219");

    if(level.var_f5746584 > 0) {
      wait 45;
    }

    var_a2c75164 function_a51b6403(1);

    foreach(e_part in var_e3d10631) {
      e_part show();
    }

    level clientfield::set("" + #"hash_681de2aa531ffcd0", 0);
    var_e3d10631[0] zm_unitrigger::create(&function_11862a9b, 96, undefined, 1, 1);
    var_e3d10631[0] thread function_1e88595a();

    if(level.var_f5746584 == 0) {
      var_e3d10631[0].s_unitrigger.cost = 0;
    } else {
      var_e3d10631[0].s_unitrigger.cost = 3000;
    }

    level flag::wait_till(#"hash_6202f3e00d7008b0");

    foreach(e_part in var_e3d10631) {
      e_part hide();
    }

    zm_unitrigger::unregister_unitrigger(var_e3d10631[0].s_unitrigger);
    level.var_1a612d42 = var_e3d10631[0].var_1a612d42;
    level.var_1a612d42.eligible_leader = 1;

    if(isDefined(level.mannequin_ally_spawner)) {
      level.mannequin_ally = level.mannequin_ally_spawner spawnfromspawner();
      level.mannequin_ally.name = "adam";
      level.mannequin_ally.isspeaking = 0;
      level.mannequin_ally.var_5b6ebfd0 = 0;
      util::magic_bullet_shield(level.mannequin_ally);
      level.mannequin_ally.aioverridedamage = array(&function_26edbcdc);
      level.mannequin_ally thread function_eaa63f5b(3);
      level.var_f5746584++;
      level.mannequin_ally thread function_e29e2b0b();
    }

    wait 1.5;
    level.mannequin_ally thread zm_hms_util::function_6a0d675d("vox_adam_activated");
    var_a2c75164 function_a51b6403(0);
  }
}

adam_activated_vo() {
  self zm_hms_util::function_51b752a9("vox_adam_activate");
}

function_26edbcdc(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  return false;
}

function_8527738e() {
  level._effect[#"hash_fc6d4d4b4df98f8"] = #"hash_4419642343624864";
  level.var_c8b6a556 = getent("pernel_paper_stack", "targetname");
  level.var_c8b6a556 setCanDamage(1);
  level.var_c8b6a556 val::set("private_mannequin_quest_paper_stack", "allowDeath", 0);
  s_notify = level.var_c8b6a556 waittill(#"damage");
  level.var_c8b6a556.tag = util::spawn_model("tag_origin", level.var_c8b6a556.origin);
  level.var_c8b6a556.tag.angles = level.var_c8b6a556.angles;
  playFXOnTag(level._effect[#"hash_fc6d4d4b4df98f8"], level.var_c8b6a556.tag, "tag_origin");
  level.var_c8b6a556 hide();
  wait 5;
  level.var_c8b6a556.tag delete();
  level.var_c8b6a556 delete();
}

function_d5faedec(params) {
  e_attacker = params.eattacker;

  if(isDefined(level.mannequin_ally) && e_attacker === level.mannequin_ally) {
    e_attacker notify(#"zom_kill");
  }
}

function_e29e2b0b() {
  self endon(#"death");
  kills = 4;
  time = 15;

  if(!isDefined(self.timerisrunning)) {
    self.timerisrunning = 0;
    self.killcounter = 0;
  }

  while(true) {
    waitresult = self waittill(#"zom_kill");
    zomb = waitresult.zombie;
    self.killcounter++;

    if(self.timerisrunning != 1) {
      self.timerisrunning = 1;
      self thread timer_actual(kills, time);
    }
  }
}

timer_actual(kills, time) {
  self endon(#"disconnect", #"death");
  timer = gettime() + time * 1000;

  while(gettime() < timer) {
    if(self.killcounter > kills) {
      if(isDefined(level.mannequin_ally)) {
        level.mannequin_ally zm_hms_util::function_6a0d675d("vox_adam_multi_kill", function_f20dfe6a(), 0, 1);
      }

      if(math::cointoss()) {
        players = getplayers();

        foreach(e_player in players) {
          if(!isDefined(e_player)) {
            continue;
          }

          if(sighttracepassed(self.origin + (0, 0, 30), e_player.origin + (0, 0, 30), 0, undefined)) {
            e_player zm_audio::create_and_play_dialog(#"kill", #"streak_adam");
          }
        }
      }

      wait 10;
      self.killcounter = 0;
      timer = -1;
    }

    wait 0.1;
  }

  self.killcounter = 0;
  self.timerisrunning = 0;
}

function_f20dfe6a() {
  n_variant = level.var_9acf4bf7[level.var_ebab3906];
  level.var_ebab3906++;

  if(level.var_ebab3906 >= level.var_9acf4bf7.size) {
    level.var_ebab3906 = 0;
    level.var_9acf4bf7 = array::randomize(level.var_9acf4bf7);
  }

  return n_variant;
}

function_e453faa6(e_reviver) {
  self endon(#"death");

  while(true) {
    results = self waittill(#"player_revived");

    if(isDefined(level.mannequin_ally) && results.reviver === level.mannequin_ally) {
      level.mannequin_ally zm_hms_util::function_6a0d675d("vox_adam_revive", function_9368a51d(), 0, 1);
      self thread zm_audio::create_and_play_dialog(#"revive", #"adam", undefined, 1);
    }
  }
}

function_9368a51d() {
  n_variant = level.var_a73770b4[level.var_1dcefa7];
  level.var_1dcefa7++;

  if(level.var_1dcefa7 >= level.var_a73770b4.size) {
    level.var_1dcefa7 = 0;
    level.var_a73770b4 = array::randomize(level.var_a73770b4);
  }

  return n_variant;
}