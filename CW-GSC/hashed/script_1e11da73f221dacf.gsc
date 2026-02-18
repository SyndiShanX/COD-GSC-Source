/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1e11da73f221dacf.gsc
***********************************************/

#using script_237e957844a8197c;
#using script_5991d6501121591f;
#using script_6b2490222adab2af;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace namespace_f7efe8a3;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_plaza_struct", "plaza_allies_move_up");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_plaza_struct");
  level hms_util::function_ee1d1df6("adler", "Adler", "adler_plaza_struct");
  level hms_util::function_ee1d1df6("mason", "Mason", "mason_plaza_struct");
  level hms_util::function_ee1d1df6("woods", "Woods", "woods_plaza_struct");
  level thread namespace_a789f8ae::function_716ff5d8("plaza");
  namespace_232ddc52::music("3.0_plaza");
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  level.player endon(#"death");
  level.var_6c5fdfbf = spawnStruct();
  level.player thread function_9229eced();
  level.player thread namespace_307260b8::function_1b57de8d();
  level.player thread namespace_307260b8::function_e8de26b3();
  level thread namespace_a789f8ae::function_eff61506();
  hms_util::function_eaa0342e("plaza_containment_warnings", "plaza_containment_fails");
  savegame::checkpoint_save();
  level thread function_7ab9202f();
  level thread function_d18ca3e4();
  level.redshirt_1 = spawner::simple_spawn_single("redshirt_1");
  level.redshirt_2 = spawner::simple_spawn_single("redshirt_2");
  level.redshirt_3 = spawner::simple_spawn_single("redshirt_3");
  level thread function_49469e2f();
  level flag::set("flg_squad_2_spawned_in");
  trigger::use("plaza_squad_2_spawn_colors", "targetname");
  trigger::use("plaza_squad_redshirts_spawn_colors", "targetname");
  level.adler.grenadeammo = 0;
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  level.adler.script_forcecolor = "c";
  level.woods.grenadeammo = 0;
  level.woods setdesiredspeed("sprint");
  level.woods.script_forcecolor = "c";
  level.mason.grenadeammo = 0;
  level.mason.script_forcecolor = "c";
  level.park.grenadeammo = 0;
  level.park ai::set_behavior_attribute("disablepeek", 0);
  level.park ai::set_behavior_attribute("disablelean", 0);
  level.park ai::set_behavior_attribute("vignette_mode", "off");
  level.park.pushable = 1;
  level.park val::set(#"hash_5b20d1b59a41939d", "push_player", 0);
  level.lazar.grenadeammo = 0;
  level.lazar ai::set_behavior_attribute("disablepeek", 0);
  level.lazar ai::set_behavior_attribute("disablelean", 0);
  level.lazar ai::set_behavior_attribute("vignette_mode", "off");
  level.lazar.pushable = 1;
  level.lazar val::set(#"hash_5b20d1b59a41939d", "push_player", 0);
  var_43444aae = getnode("park_initial_plaza_node", "targetname");
  var_724db48b = getnode("lazar_initial_plaza_node", "targetname");
  level.park setgoal(var_43444aae);
  level.lazar setgoal(var_724db48b);
  level flag::wait_till("flg_street_enemies_spawn");
  level thread function_9685b467();
  var_f736c7a7 = spawner::simple_spawn("plaza_street_enemies");

  hms_util::print("<dev string:x4a>");

  level thread namespace_307260b8::function_85939627(var_f736c7a7, "flg_street_guys_fallback_1", 3);
  level flag::wait_till_any(array("flg_spawn_plaza_mg_guys", "flg_street_guys_fallback_1"));
  createthreatbiasgroup("player");
  createthreatbiasgroup("snipers");
  setthreatbias("player", "snipers", 750);

  if(isDefined(level.player)) {
    level.player setthreatbiasgroup("player");
  }

  var_3453c903 = spawner::simple_spawn("plaza_sniper_left_enemies", &function_f7a1c261);
  level flag::set("flg_sniper_wave_1_spawned");
  level flag::set("flg_mg_nest_1");
  var_79db78ed = namespace_307260b8::function_516b7ec("plaza_mg_guy_right", "plaza_turret_mounted_right", 0);
  var_9226ff76 = namespace_307260b8::function_516b7ec("plaza_mg_guy_left", "plaza_turret_mounted_left", 0);
  var_79db78ed thread function_f8d17019("mg_damage_clip_right");
  var_9226ff76 thread function_f8d17019("mg_damage_clip_left");
  var_9226ff76 thread function_87504f69();
  level flag::wait_till_any(array("flg_street_guys_fallback_1", "flg_plaza_retreat_street_guys"));
  var_f736c7a7 = getaiarray("plaza_street_enemies", "targetname");

  foreach(guy in var_f736c7a7) {
    guy thread function_302b4058("plaza_street_guys_fallback_1", 0.5, 2);
  }

  level flag::wait_till("flg_wave_1_enemies");
  level flag::wait_till("flg_wave_1_smoke");
  var_2bb008f0 = spawner::simple_spawn("plaza_wave_1_enemies");

  hms_util::print("<dev string:x62>");

  var_5a6ad0b9 = struct::get_array("plaza_wave_1_smoke", "targetname");
  level flag::set("flg_smoke_deployed");

  foreach(var_10ed23ba in var_5a6ad0b9) {
    e_grenade = level.player magicgrenadeplayer(getweapon(#"willy_pete"), var_10ed23ba.origin, (0, 0, 0));
    e_grenade.var_3791d005 = 0;
    wait 2.5;
  }

  level flag::set("flg_delete_plaza_ground_drones");
  var_1d7ca9b = spawner::simple_spawn("plaza_right_optional_enemies");
  var_f5c39c6d = spawner::simple_spawn("plaza_sniper_right_enemies", &function_f7a1c261);
  level flag::set("flg_sniper_wave_2_spawned");

  hms_util::print("<dev string:x7a>");

  level thread namespace_307260b8::function_85939627(var_2bb008f0, "flg_wave_1_reinforce", 3);
  level flag::wait_till_any(["flg_wave_1_reinforce", "flg_wave_2_enemies"]);
  var_f736c7a7 = getaiarray("plaza_street_enemies", "targetname");

  foreach(guy in var_f736c7a7) {
    guy thread function_302b4058("plaza_wave_1_guys_fallback_1");
  }

  var_2bb008f0 = getaiarray("plaza_wave_1_enemies", "targetname");

  foreach(guy in var_2bb008f0) {
    guy thread function_302b4058("plaza_wave_1_guys_fallback_1");
  }

  var_1d7ca9b = getaiarray("plaza_right_optional_enemies", "targetname");

  foreach(guy in var_1d7ca9b) {
    guy thread function_302b4058("plaza_stairway_fallback_fallback");
  }

  level flag::set("flg_mg_nest_2");
  var_cc42ff9 = namespace_307260b8::function_516b7ec("plaza_mg_guy_center", "plaza_turret_mounted_center");
  var_ffde7019 = namespace_307260b8::function_516b7ec("plaza_mg_guy_left_center", "plaza_turret_mounted_left_center", 0);

  if(isDefined(var_cc42ff9)) {
    var_cc42ff9 thread function_3367d18d();
  }

  var_ffde7019 thread function_f8d17019("mg_damage_clip_left_center");

  if(isDefined(var_79db78ed)) {
    var_79db78ed val::reset(#"turret_gunner", "ignoreme");
  }

  if(isDefined(var_9226ff76)) {
    var_9226ff76 val::reset(#"turret_gunner", "ignoreme");
  }

  level flag::wait_till("flg_wave_2_enemies");
  var_25d63705 = spawner::simple_spawn("plaza_wave_2_enemies");

  hms_util::print("<dev string:x91>");

  level thread namespace_307260b8::function_85939627(var_25d63705, "flg_wave_2_reinforce", 2);
  level thread function_399b4bd4();
  var_25d63705 = getaiarray("plaza_wave_2_enemies", "targetname");

  foreach(guy in var_25d63705) {
    guy thread function_302b4058("plaza_stairway_fallback_fallback");
  }

  level flag::wait_till_any(array("flg_wave_2_reinforce", "flg_spawn_wave_2_reinforce"));
  var_3d5c4510 = spawner::simple_spawn("plaza_wave_2_reinforce_enemies");
  level thread function_6cfa44d7(var_3d5c4510);

  hms_util::print("<dev string:xa9>");

  if(isDefined(var_cc42ff9)) {
    var_cc42ff9 val::reset(#"turret_gunner", "ignoreme");
  }

  if(isDefined(var_ffde7019)) {
    var_ffde7019 val::reset(#"turret_gunner", "ignoreme");
  }

  var_f736c7a7 = getaiarray("plaza_street_enemies", "targetname");
  var_2bb008f0 = getaiarray("plaza_wave_1_enemies", "targetname");
  var_1d7ca9b = getaiarray("plaza_right_optional_enemies", "targetname");
  var_25d63705 = getaiarray("plaza_wave_2_enemies", "targetname");
  var_3d5c4510 = getaiarray("plaza_wave_2_reinforce_enemies", "targetname");
  var_3e9559b8 = arraycombine(var_f736c7a7, var_2bb008f0);
  var_3e9559b8 = arraycombine(var_3e9559b8, var_1d7ca9b);
  var_3e9559b8 = arraycombine(var_3e9559b8, var_25d63705);
  var_3e9559b8 = arraycombine(var_3e9559b8, var_3d5c4510);
  level thread namespace_307260b8::function_85939627(var_3e9559b8, "flg_plaza_enemies_dead", var_3e9559b8.size);
  level flag::wait_till_any(array("flg_remove_squad_2_from_color", "flg_plaza_enemies_dead"));
  trigger::use("floor_one_park_initial_color", "targetname");
  level thread namespace_a789f8ae::function_986b3cba(7, 10);
  level flag::set("flg_mgs_retreat");

  if(isDefined(var_9226ff76)) {
    var_9226ff76 deletedelay();
  }

  if(isDefined(var_79db78ed)) {
    var_79db78ed deletedelay();
  }

  if(isDefined(var_ffde7019)) {
    var_ffde7019 deletedelay();
  }

  hms_util::print("<dev string:xcb>");

  level flag::set("flg_redshirts_split_off");
}

function function_f7a1c261() {
  self endon(#"death");
  self setthreatbiasgroup("snipers");
  self.script_accuracy = 1;

  if(self.script_noteworthy === "sniper_ik_guy") {
    self.enableterrainik = 1;
  }

  namespace_307260b8::function_2b6287f4("plaza_retreat_rooftop_snipers");
  level flag::set("flg_snipers_reatreating");
  self.goalradius = 16;
  self thread function_302b4058("a_wave_catch_all_enemies_fallback", 1, 2);
  self waittill(#"goal");
  self deletedelay();
}

function function_1b331deb() {
  level.player endon(#"death");
  level flag::wait_till("flg_redshirts_split_off");
  level.adler hms_util::dialogue("vox_cp_cbcr_01200_adlr_captaintakeyour_50");
  wait 0.5;

  if(isDefined(level.redshirt_1)) {
    level.redshirt_1 hms_util::dialogue("vox_cp_cbcr_01200_cia1_copythat_8d");
  }

  if(isDefined(level.redshirt_2)) {
    level.redshirt_2 hms_util::dialogue("vox_cp_cbcr_01200_cia1_letsmove_8b");
  }
}

function function_9685b467() {
  level flag::wait_till("flg_spawn_plaza_mg_guys");
  var_4a3daa0b = struct::get("plaza_second_floor_drone_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  var_251b3a07 = spawner::simple_spawn("plaza_second_floor_drones");
  wait 2;
  var_251b3a07 = spawner::simple_spawn("plaza_second_floor_drones");
  wait 1.5;
  var_251b3a07 = spawner::simple_spawn("plaza_second_floor_drones");
  var_a0d22a3 = spawner::simple_spawn("plaza_ground_drones");
  level flag::wait_till("flg_delete_plaza_ground_drones");

  foreach(guy in var_a0d22a3) {
    if(isDefined(guy)) {
      guy deletedelay();
    }
  }
}

function function_3367d18d() {
  self endon(#"death");
  level endon(#"flag_obj_plaza_done");
  self waittill(#"exit_turret");
  fallback_vol = getent("plaza_stairway_fallback_fallback", "targetname");
  self ai::force_goal(fallback_vol, 0);
  aiutility::releaseclaimnode(self);
  aiutility::choosebestcovernodeasap(self);
}

function function_87504f69() {
  level.player endon(#"death");
  var_2c3b91fc = struct::get_array("turret_point_plaza");
  e_turret = getent("plaza_mg_left_intro_gun", "targetname");
  n_shots = 4;
  e_turret turret::enable(0, 1, undefined);
  e_turret waittill(#"hash_47d72700d29f432e");
  e_turret turret::function_aecc6bed(var_2c3b91fc, n_shots, 0);
  var_896dcb0c = getent("plaza_dest_car", "script_noteworthy");
  var_896dcb0c dodamage(5000, var_896dcb0c.origin);
}

function function_f8d17019(var_63610c73) {
  self endon(#"death");
  var_a9224983 = getent(var_63610c73, "targetname");

  while(true) {
    var_c83de2f = var_a9224983 waittill(#"damage");

    if(var_c83de2f.weapon == getweapon(#"launcher_freefire_t9")) {
      break;
    }
  }

  radiusdamage(self.origin, 100, 1000, 200, level.player, "MOD_EXPLOSIVE");
}

function function_1bdb683(var_9608b240, min_delay = 2, max_delay = 8) {
  self endon(#"death");
  level endon(#"flag_obj_plaza_done");
  wait randomfloatrange(min_delay, max_delay);
  self val::set(#"hash_58e0e1db15cf1334", "ignoreall", 1);
  fallback_vol = getent(var_9608b240, "targetname");
  self ai::force_goal(fallback_vol, 0);
  self waittill(#"goal");
  self val::reset(#"hash_58e0e1db15cf1334", "ignoreall");
}

function function_302b4058(var_9608b240, min_delay = 1, max_delay = 4, var_226603c5 = 0) {
  self endon(#"death");
  level endon(#"flag_obj_plaza_done");
  wait randomfloatrange(min_delay, max_delay);
  fallback_vol = getent(var_9608b240, "targetname");
  self ai::force_goal(fallback_vol, var_226603c5);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:xde>");

  level notify(#"hash_4b94195c7c990e8f");
  level thread function_60645fdb();
}

function function_7ab9202f() {
  var_b6ac0499 = struct::get("s_plaza_objective", "targetname");
  objectives::goto("obj_plaza", var_b6ac0499.origin, #"hash_73f5c4e9425acbd9");
  level flag::wait_till("flag_obj_plaza_done");
  objectives::complete("obj_plaza");
}

function function_d18ca3e4() {
  level.player endon(#"death");
  level endon(#"hash_7e73fe70b4f2f0c8");
  level thread function_72beaeea();
  level flag::set("flg_vo_church_done");
  level flag::wait_till("flg_squad_2_spawned_in");
  level.woods hms_util::dialogue("vox_cp_cbcr_01100_adlr_contact_ed");
  wait 0.25;
  level.woods hms_util::dialogue("vox_cp_cbcr_01100_wood_likefuckingcloc_9c");
  wait 2;
  level.adler hms_util::dialogue("vox_cp_cbcr_01100_adlr_spreadoutpushto_c3");
  level thread function_5ac9ac6b();
  level thread function_838b0689();
  level thread function_560a377b();
  level thread function_1b331deb();
  level thread function_93738039();
}

function function_93738039() {
  level endon(#"death");
  level flag::wait_till("flag_woods_first_floor_intro_vo");

  while(!level flag::get("flg_dead_bodies_entrance")) {
    level.adler hms_util::dialogue("vox_cp_cbcr_01300_adlr_parktakeyourtea_3d");
    level.adler hms_util::dialogue("vox_cp_cbcr_01300_park_copy_c9");
    break;
  }
}

function function_5ac9ac6b() {
  level.player endon(#"death");
  level endon(#"flg_mgs_retreat");
  level flag::wait_till("flg_mg_nest_1");
  var_ee41891c = randomintrangeinclusive(0, 2);

  switch (var_ee41891c) {
    case 0:

      hms_util::print(var_ee41891c);

      level.adler hms_util::dialogue("vox_cp_cbcr_01200_adlr_contactsecondfl_f7");
      break;
    case 1:

      hms_util::print(var_ee41891c);

      level.adler hms_util::dialogue("vox_cp_cbcr_01200_adlr_enemyfiresecond_c4");
      break;
    case 2:

      hms_util::print(var_ee41891c);

      level.adler hms_util::dialogue("vox_cp_cbcr_01200_adlr_shooterssecondf_57");
      break;
    default:
      assertmsg("<dev string:xee>");
      break;
  }

  var_a211789f = spawner::get_ai_group_ai("mg_group_1");
  ai::waittill_dead(var_a211789f);
  level.mason hms_util::dialogue("vox_cp_cbcr_02400_masn_allgunturretsar_25");
  level.mason hms_util::dialogue("vox_cp_cbcr_02400_masn_moveupmoveup_9a");
  level flag::wait_till("flg_mg_nest_2");
  var_7d6c8efc = randomintrangeinclusive(0, 2);

  switch (var_7d6c8efc) {
    case 0:
      level.adler hms_util::dialogue("vox_cp_cbcr_02200_adlr_mgssecondfloort_2c");
      break;
    case 1:
      level.adler hms_util::dialogue("vox_cp_cbcr_02200_adlr_wegotmgssecondf_48");
      break;
    case 2:
      level.adler hms_util::dialogue("vox_cp_cbcr_02200_adlr_takeoutthosemgs_83");
      break;
    default:
      assertmsg("<dev string:xee>");
      break;
  }
}

function function_838b0689() {
  level.player endon(#"death");
  level endon(#"flg_snipers_reatreating");
  level flag::wait_till("flg_sniper_wave_1_spawned");
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_snipersupahead_1e");
  var_8cc27d95 = spawner::get_ai_group_ai("sniper_group");

  foreach(ai in var_8cc27d95) {
    ai thread function_e0be8177();

    hms_util::print("<dev string:x13a>");
  }

  level flag::wait_till("flg_sniper_wave_2_spawned");
  var_88d2bb65 = spawner::get_ai_group_ai("sniper_group_2");

  foreach(var_8933ebaf in var_88d2bb65) {
    var_8933ebaf thread function_e0be8177();

    hms_util::print("<dev string:x146>");
  }
}

function function_e0be8177() {
  level endon(#"flg_snipers_reatreating");
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.mason, "vox_cp_cbcr_02400_masn_niceonebell_cd");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.mason, "vox_cp_cbcr_02400_masn_thatsanotherone_93");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.mason, "vox_cp_cbcr_02400_masn_scratchanothero_5c");
  self waittill(#"death");

  hms_util::print("<dev string:x152>");

  if(math::cointoss(25)) {
    hms_util::vo_knockout_manager("cuban_snipers_down", var_ffbbfc35);
  }
}

function function_560a377b() {
  level.player endon(#"death");
  level flag::wait_till("flg_smoke_deployed");
  wait randomfloatrange(0.2, 1);
  var_85239fdd = randomintrangeinclusive(0, 2);

  switch (var_85239fdd) {
    case 0:
      level.woods hms_util::dialogue("vox_cp_cbcr_02400_wood_theyrepoppingsm_e9");
      break;
    case 1:
      level.woods hms_util::dialogue("vox_cp_cbcr_02400_wood_watchittheyrepo_1e");
      break;
    case 2:
      level.woods hms_util::dialogue("vox_cp_cbcr_02400_wood_enemypoppingsmo_5d");
      break;
  }
}

function function_a6d837d0() {
  var_a765d3ea = getent("RPG_origin", "targetname");
  var_da43ffcd = getent("RPG_destination", "targetname");
  level flag::wait_till("flg_rpg_shoots");
  var_4a3daa0b = struct::get("plaza_column_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  savegame::checkpoint_save();
  level flag::wait_till("flg_plaza_column_destruction_ready");
  level thread namespace_a789f8ae::function_c68fb2ec();
  magicbullet(getweapon(#"hash_3ce617d496140d52"), var_a765d3ea.origin, var_da43ffcd.origin);
}

function function_399b4bd4() {
  namespace_307260b8::function_2b6287f4("lobby_trigger");
  level flag::set("flg_plaza_cleanup_start");

  if(isDefined(level.park)) {
    level.park.script_accuracy = 1000;
  }

  if(isDefined(level.lazar)) {
    level.lazar.script_accuracy = 1000;
  }

  if(isDefined(level.adler)) {
    level.adler.script_accuracy = 1000;
  }

  if(isDefined(level.woods)) {
    level.woods.script_accuracy = 1000;
  }

  if(isDefined(level.mason)) {
    level.mason.script_accuracy = 1000;
  }
}

function function_72beaeea() {
  level.player endon(#"death");
  level endon(#"hash_7e73fe70b4f2f0c8");
  var_3518b0f6 = getEntArray("trig_wander_off_plaza", "targetname");

  while(true) {
    foreach(trig in var_3518b0f6) {
      if(isDefined(trig)) {
        if(level.player istouching(trig)) {
          level function_ede8e547();
          wait 5;
          break;
        }

        if(level.player istouching(trig)) {}
      }
    }

    wait 1;
  }
}

function function_ede8e547() {
  level endon(#"flg_plaza_cleanup_start", #"hash_7e73fe70b4f2f0c8");
  var_16bf64d2 = randomintrangeinclusive(0, 7);

  switch (var_16bf64d2) {
    case 0:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_bellwhereareyou_03");
      break;
    case 1:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_bellstayonmissi_a1");
      break;
    case 2:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_bellpushtotheen_55");
      break;
    case 3:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_bellstickwithme_ad");
      break;
    case 4:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_wrongwaybell_6a");
      break;
    case 5:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_belltheactionis_10");
      break;
    case 6:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_keepyourbloodyh_cd");
      break;
    case 7:
      level.park hms_util::dialogue("vox_cp_cbcr_01100_park_bellstayclose_e3");
      break;
  }
}

function function_6cfa44d7(var_bf6c8bb9) {
  level endon(#"flag_obj_plaza_done");
  level flag::wait_till("flg_spawn_wave_2_reinforce");
  var_a274dfb9 = array::random(var_bf6c8bb9);
  var_879729fe = array::random(var_bf6c8bb9);

  while(isDefined(var_a274dfb9) && isDefined(var_879729fe)) {
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01200_csm1_stopthem_95");
    var_879729fe hms_util::dialogue("vox_cp_cbcr_01200_csm2_alertperseus_20");
    wait randomfloatrange(0.5, 1.25);
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01200_csm1_theamericansthe_ec");
    var_879729fe hms_util::dialogue("vox_cp_cbcr_01200_csm2_keepthemawayfro_01");
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01200_csm1_lockthedownthel_93");
    wait randomfloatrange(0.5, 1.25);
    var_879729fe hms_util::dialogue("vox_cp_cbcr_01200_csm2_ididntsignupfor_ad");
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01200_csm1_howdidtheyfindu_61");
    break;
  }
}

function function_49469e2f() {
  level endon(#"flg_redshirts_split_off");
  level thread function_7ad3c858();
  wait 2;
  level.redshirt_1.grenadeammo = 0;
  level.redshirt_1.health = 200;
  level.redshirt_2.grenadeammo = 0;
  level.redshirt_2.health = 200;
  level.redshirt_3.grenadeammo = 0;
  level.redshirt_3.health = 200;

  while(!level flag::get("flg_redshirts_split_off")) {
    wait 30;

    if(!isalive(level.redshirt_1)) {
      redshirt_1 = spawner::simple_spawn_single("redshirt_1");
      level.redshirt_1 = redshirt_1;
      level.redshirt_1.grenadeammo = 0;
      level.redshirt_1.health = 200;
    }

    if(!isalive(level.redshirt_2)) {
      redshirt_2 = spawner::simple_spawn_single("redshirt_2");
      level.redshirt_2 = redshirt_2;
      level.redshirt_2.grenadeammo = 0;
      level.redshirt_2.health = 200;
    }

    if(!isalive(level.redshirt_3)) {
      redshirt_3 = spawner::simple_spawn_single("redshirt_3");
      level.redshirt_3 = redshirt_3;
      level.redshirt_3.grenadeammo = 0;
      level.redshirt_3.health = 200;
    }
  }
}

function function_7ad3c858() {
  level endon(#"game_ended", #"death");
  level flag::wait_till("flg_redshirts_split_off");

  if(isDefined(level.redshirt_1)) {
    level.redshirt_1 colors::disable();
    level.redshirt_1.goalradius = 8;
    wait 1.5;
    level.redshirt_1 thread namespace_307260b8::function_10223871("plaza_redshirt_delete_volume", 1);
  }

  if(isDefined(level.redshirt_2)) {
    level.redshirt_2 colors::disable();
    level.redshirt_2.goalradius = 8;
    wait 1.5;
    level.redshirt_2 thread namespace_307260b8::function_10223871("plaza_redshirt_delete_volume", 1);
  }

  if(isDefined(level.redshirt_3)) {
    level.redshirt_3 colors::disable();
    level.redshirt_3.goalradius = 8;
    wait 1.5;
    level.redshirt_3 thread namespace_307260b8::function_10223871("plaza_redshirt_delete_volume", 1);
  }
}

function function_60645fdb() {
  level endon(#"game_ended");
  var_9a1edfd9 = struct::get("annihilator_spawn");
  var_78088964 = getent("first_floor_painting", "targetname");
  var_78088964 setCanDamage(1);

  while(true) {
    s_result = var_78088964 waittill(#"damage");

    if(s_result.attacker === level.player) {
      break;
    }
  }

  var_78088964 setCanDamage(0);
  var_78088964 physicslaunch(var_78088964.origin + (0, 0, 8), (2, 2, 0));
  var_dc039d87 = getweapon(#"hash_3ed4419427e0d85a", "fastreload2", "heavy2", "compensator", "handle2");
  e_weapon = spawnweapon(var_dc039d87, var_9a1edfd9.origin, var_9a1edfd9.angles, 1);
}

function function_9229eced() {
  self endon(#"death", #"flg_plaza_enemies_dead");

  while(true) {
    waitresult = self waittill(#"enter_vehicle");

    if(waitresult.vehicle.vehicleclass === "artillery") {
      waittillframeend();
      self val::reset(#"player_vehicle", "ignoreme");
    }
  }
}