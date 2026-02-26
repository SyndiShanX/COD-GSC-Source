/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_e4d4b4e82f6b90e.gsc
***********************************************/

#using script_1e11da73f221dacf;
#using script_210ec734a4149bac;
#using script_237e957844a8197c;
#using script_4a1a0f734d8d0e04;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_9162cd57;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_floor_two_struct");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_floor_two_struct");
  door_blocker = getent("second_floor_stairway_door", "targetname");
  var_cee57de3 = getent("second_floor_stairway_door_clip", "targetname");
  door_blocker delete();
  var_cee57de3 delete();
  level thread namespace_a789f8ae::function_223dbff(1);
  namespace_232ddc52::music("9.0_c4");
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  level.var_9b05d82d = spawnStruct();
  level.player thread namespace_307260b8::function_1b57de8d();
  level.player thread namespace_307260b8::function_e8de26b3();
  level thread namespace_a789f8ae::function_eff61506();
  hms_util::function_eaa0342e("floor_two_containment_warnings", "floor_two_containment_fails");
  level thread function_acf07bae();
  level thread function_74774e71();
  level thread function_393a7ac3();
  level thread function_cd60a984();
  level thread namespace_a789f8ae::function_e73fa40e("2nd_floor");
  level thread namespace_a789f8ae::function_b91f9a58("2nd_floor");
  level thread function_5ccf94e2();
  savegame::checkpoint_save();
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4e>");

  level notify(#"hash_24b259ee7a18193a");
  exploder::exploder("nuke_camera_sparks");
  var_cdb289d1 = getEntArray("land_mine_placed", "targetname");
  array::delete_all(var_cdb289d1);
}

function function_b0ba87a4() {
  self endon(#"death");
  self waittill(#"trigger");
  e_blocker = getent("nuke_door_blocker", "targetname");
  e_blocker show();
  level flag::wait_till("obj_photo_done");
  e_blocker hide();
}

function function_949d7906(var_5a04e6d6, var_b9f33580) {
  self ai::set_behavior_attribute("disablepeek", var_5a04e6d6);
  self ai::set_behavior_attribute("disablelean", var_b9f33580);
}

function function_acf07bae() {
  objectives::scripted("obj_goto_bomb", undefined, #"hash_110b2d9474b5420f");
  level breadcrumb::function_61037c6c("bc_second_floor_objective");
  level flag::wait_till("flg_floor_two_end");
  var_4a3daa0b = struct::get("nuke_room_door_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  level breadcrumb::function_e261021e("bc_second_floor_objective");
  level flag::wait_till("flg_pre_nuke_room_vo_complete");
  objectives::complete("obj_goto_bomb");
  level notify(#"hash_2e47b50259ab3bec");
  skipto::function_4e3ab877("2nd_floor");
}

function function_393a7ac3() {
  level.player endon(#"death");
  level flag::wait_till("flg_door_breached_to_second_floor");
  wait 0.15;
  exploder::exploder("2nd_floor_shotgun_fire");
  level flag::wait_till("flg_remove_shotgun_fire");
  exploder::exploder_stop("2nd_floor_shotgun_fire");
}

function function_dd58d582() {
  level.player endon(#"death");
  level endon(#"2nd_floor");
  level flag::wait_till("flg_snipers_dead");
}

function function_98d37226() {
  level.player endon(#"death");
  level endon(#"2nd_floor");
  var_64186d96 = struct::get("scientist_kill_spot", "targetname");
  level flag::wait_till("flg_civs_in_motion");
  level.var_cf87018c thread hms_util::dialogue("vox_cp_cbcr_02200_sci_pleaseno_79", 0, "allies", "Scientist 2");
  level waittill(#"hash_d52a07210534762");
  var_64186d96 thread hms_util::dialogue("vox_cp_cbcr_02200_sci_agggh_ff", 1, "allies", "Scientist 2");
  wait randomfloatrange(0.5, 1);
  level.park hms_util::dialogue("vox_cp_cbcr_02200_park_snipersontheroo_a2");
}

function function_74774e71() {
  level.player endon(#"death");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  wait 1.75;

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  level.park hms_util::dialogue("vox_cp_cbcr_02300_park_adlerweremoving_f5");
  var_e534dcb hms_util::dialogue("vox_cp_cbcr_02200_adlr_werepinneddownm_81", 1, "allies", "adler");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(1);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(1);
  }

  level thread function_98d37226();
  level thread function_dd58d582();
  level flag::wait_till("flg_spotted_mg");

  if(isalive(level.var_5deea171)) {
    level.lazar hms_util::dialogue("vox_cp_cbcr_02400_lazr_theyrereallyhun_99");
    level.park hms_util::dialogue("vox_cp_cbcr_02400_park_takeoutthatheav_e0");
  }

  level flag::wait_till("flg_player_nearing_vip_room_vo");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  level.park hms_util::dialogue("vox_cp_cbcr_01500_park_27badlerweregoi_54");
  level flag::set("flg_open_nuke_door");
  level flag::set("flg_pre_nuke_room_vo_complete");
  level waittill(#"hash_6fe52ef74791cc55");
  level.lazar thread hms_util::dialogue("vox_cp_cbcr_01500_lazr_anythingforyoul_f7", undefined);
}

function function_400f93ba() {
  level.player endon(#"death");
  namespace_307260b8::function_2b6287f4("2nd_floor_office_ambush_trigger");
  var_b002bd9b = spawner::simple_spawn("2nd_floor_office_ambushers", &function_687b1b14);
  var_408c4a10 = spawner::simple_spawn_single("2nd_floor_office_ambushers_slide", &function_687b1b14);
  trigger::use("set_conference_color");

  foreach(ai in var_b002bd9b) {
    ai ai::set_behavior_attribute(#"demeanor", "cqb");
  }

  a_scene_ents[#"soldier"] = var_408c4a10;
  var_408c4a10 val::set(#"ai_forcegoal", "ignoreall", 1);
  var_7820eb66 = struct::get("scene_soldier_slide", "targetname");
  thread function_cda1622();
  var_7820eb66 scene::play(a_scene_ents);
  spawner::waittill_ai_group_ai_count("2nd_floor_office_shotgunners", 1);
  spawner::simple_spawn("2nd_floor_office_reinforcements", &function_687b1b14);
}

function function_cda1622() {
  wait 3;
  var_a08ef2a1 = getent("parkour_physics_impulse", "targetname");
  physicsexplosionsphere(var_a08ef2a1.origin, 210, 0, 0.56);
}

function function_18580559() {
  var_ccb58619 = getaiarray("2nd_floor_right_main_hall", "targetname");
  var_5a9ddf12 = getaiarray("2nd_floor_right_main_hall_reinforcements", "targetname");
  var_628e7cf5 = arraycombine(var_ccb58619, var_5a9ddf12);
  level flag::wait_till("flg_axis_retreat_2");
  var_5a7199e6 = getaiarray("vip_area_last_stand_guards", "targetname");
  var_fa9ba784 = getaiarray("vip_area_last_stand_guards_reinforcements", "targetname");
  var_4e346220 = arraycombine(var_ccb58619, var_5a9ddf12);

  foreach(guy in var_4e346220) {
    if(isDefined(guy)) {
      guy thread namespace_f7efe8a3::function_1bdb683("fallback_2", 0.1, 1);
    }
  }
}

function function_7a1d5f84() {
  var_8a693ebe = getent("t_gate_guys_color", "targetname");

  if(isalive(self)) {
    self thread namespace_f7efe8a3::function_302b4058("gate_enemy_retreat", 0, 0.5, 1);
  }

  if(isDefined(var_8a693ebe)) {
    var_8a693ebe trigger::use();
  }
}

function function_e6757b30(ai_sniper, var_f8e5e80) {
  player = getplayers()[0];
  player endon(#"death");

  if(isDefined(ai_sniper)) {
    ai_sniper waittill(#"death");
  }

  if(isalive(var_f8e5e80)) {
    hms_util::print("<dev string:x62>");

    player stats::function_dad108fa(#"hash_22e14d246f6dfe19", 1);
  } else {
    hms_util::print("<dev string:x76>");
  }

  wait 1;
}

function function_e2d61fd0() {
  level.player endon(#"death");
  var_d8320f70 = struct::get("rooftop_sniper_intro", "targetname");
  var_4a3daa0b = struct::get("scientist_lookat", "targetname");
  t_spawner = getent("trig_spawn_scientist", "targetname");
  level.var_cf87018c = spawner::simple_spawn_single("scientist_guy_killed_02", &function_687b1b14);
  level thread scene::init("scene_rev_3080_sec_scientist_flee", array(undefined, level.var_cf87018c));
  level thread function_146a9996();
  level thread function_1fd1357a();

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(65));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1 && level.player istouching(t_spawner)) {
      break;
    }

    waitframe(1);
  }

  thread scene::play("scene_rev_3080_sec_scientist_flee", "start", array(undefined, level.var_cf87018c));
  level.var_4a6bcfce = spawner::simple_spawn_single("rooftop_sniper_killer", &function_687b1b14);
  level.var_f4da5fc4 = spawner::simple_spawn_single("scientist_guy_save_challenge", &function_687b1b14);
  level flag::wait_till("scientist_at_goal");
  waitframe(1);
  var_6ad55ca3 = spawner::simple_spawn_single("2nd_floor_rooftop_snipers", &function_687b1b14);
  var_e4a88c19 = spawner::simple_spawn_single("2nd_floor_sniper_scaffold", &function_687b1b14);

  if(!isDefined(var_6ad55ca3)) {
    var_6ad55ca3 = [];
  } else if(!isarray(var_6ad55ca3)) {
    var_6ad55ca3 = array(var_6ad55ca3);
  }

  var_6ad55ca3[var_6ad55ca3.size] = level.var_4a6bcfce;

  if(!isDefined(var_6ad55ca3)) {
    var_6ad55ca3 = [];
  } else if(!isarray(var_6ad55ca3)) {
    var_6ad55ca3 = array(var_6ad55ca3);
  }

  var_6ad55ca3[var_6ad55ca3.size] = var_e4a88c19;

  if(isDefined(level.var_4a6bcfce)) {
    level.var_4a6bcfce thread spawner::go_to_node(var_d8320f70);
  }

  level flag::set("flg_civs_in_motion");
  level thread function_b8cb638d(var_6ad55ca3);
  ai::waittill_dead_or_dying(var_6ad55ca3);
  level flag::set("flg_snipers_dead");
}

function function_146a9996() {
  level.player endon(#"death");
  var_b6e612d4 = (1288.51, 1008.02, 422.937);
  var_6dec00d9 = level.var_cf87018c getEye();
  var_2d5ffa27 = struct::get("scientist_flee_shoot_from");
  level waittill(#"hash_d529f72105345af");
  magicbullet(getweapon("sniper_standard_t9"), var_2d5ffa27.origin, var_b6e612d4);
  level waittill(#"hash_d52a07210534762");
  magicbullet(getweapon("sniper_standard_t9"), var_2d5ffa27.origin, var_6dec00d9);
}

function function_1fd1357a() {
  level.player endon(#"death");
  level waittill(#"hash_4d5c9599ee0ef28c");

  hms_util::print("<dev string:x8e>");

  level thread function_4a631484(level.var_4a6bcfce);
  level thread function_e6757b30(level.var_4a6bcfce, level.var_f4da5fc4);
}

function function_b9fa18dc(n_time, str_flag) {
  level.player endon(#"death");
  wait n_time;

  hms_util::print("<dev string:xa0>" + str_flag);

  level flag::set(str_flag);
}

function function_b8cb638d(ai) {
  level endon(#"flg_snipers_dead");
  var_165eacc0 = 0.2;
  var_273d568b = 10;
  wait 5;

  while(ai.size > 0 && var_165eacc0 < 100) {
    foreach(guy in ai) {
      if(isalive(guy)) {
        guy.script_accuracy += var_165eacc0;
        var_165eacc0 += 0.2;

        hms_util::print(guy.script_accuracy);

        wait var_273d568b;
        var_273d568b--;
      }
    }
  }
}

function private function_8bba1be() {
  self spawner::function_461ce3e9();
  var_6694a018 = struct::get("civilian_floor_two_retreat_goal", "targetname");
  self.var_5313e2e3 = var_6694a018.origin;
  self.goalradius = 1000;
  self.nextfindbestcovertime = gettime();
  self namespace_f592a7b::function_8e430c8(var_6694a018.origin);
  self ai::set_behavior_attribute(#"_civ_mode", "panic");
}

function function_4a631484(ai_sniper) {
  level.var_f4da5fc4 endon(#"death");
  var_859633df = struct::get("civ_path1", "targetname");
  level.var_f4da5fc4 ai::set_behavior_attribute(#"_civ_mode", "panic");
  level.var_f4da5fc4 thread spawner::go_to_node(var_859633df);
  level.var_f4da5fc4 waittill(#"goal");
  level flag::set("scientist_at_goal");

  if(isalive(ai_sniper)) {
    var_10507c40 = level.var_f4da5fc4 getEye();
    magicbullet(ai_sniper.weapon, ai_sniper gettagorigin("tag_flash"), var_10507c40, ai_sniper);
    level flag::set("flg_scientist_sniped");
    level.var_f4da5fc4 startragdoll();
    level.var_f4da5fc4 kill();
    return;
  }

  level.var_f4da5fc4 function_8bba1be();
}

function function_225b3079() {
  self endon(#"death");
  var_9750d754 = struct::get("civ_path2", "targetname");
  self ai::set_behavior_attribute(#"_civ_mode", "run");
  self thread spawner::go_to_node(var_9750d754);
  s_notify = level flag::wait_till_any(["flg_scientist_sniped", "flg_snipers_dead"]);

  if(s_notify._notify == "flg_scientist_sniped") {
    var_976c732e = struct::get("civ_path2_change", "targetname");
    self spawner::function_461ce3e9();
    self thread spawner::go_to_node(var_976c732e);
    level flag::wait_till("flg_snipers_dead");
    self function_8bba1be();
  }
}

function function_cd60a984() {
  level.park colors::enable();
  level.lazar colors::enable();
  level thread function_18580559();
  namespace_307260b8::function_2b6287f4("2nd_floor_gate_enemy_trig");
  var_31091b0f = spawner::simple_spawn("2nd_floor_gate_spawner", &function_687b1b14);
  level thread function_dda2c76e(var_31091b0f);
  array::thread_all(var_31091b0f, &function_165eaaa);
  namespace_307260b8::function_2b6287f4("2nd_floor_gate_retreat");

  foreach(guy in var_31091b0f) {
    guy thread function_7a1d5f84();
  }

  namespace_232ddc52::music("10.0_skirmish");
  level thread function_400f93ba();
  level flag::wait_till("flg_ready_snipers");
  level thread function_e2d61fd0();
  savegame::checkpoint_save();
  level flag::wait_till_any(array("flg_main_hall_guys", "flg_snipers_dead"));
  var_9606fd42 = spawner::simple_spawn("2nd_floor_right_main_hall", &function_687b1b14);
  array::thread_all(var_9606fd42, &function_165eaaa);
  trigger::use("post_sniper_colors");
  namespace_307260b8::function_2b6287f4("2nd_floor_hallway_reinforcements_trigger");
  var_9606fd42 = spawner::simple_spawn("2nd_floor_right_main_hall_reinforcements", &function_687b1b14);
  trigger::use("2nd_reinforcements");
  level thread function_d1cabeee();
  level thread function_c7c21ff9();
  namespace_307260b8::function_2b6287f4("vip_last_stand_trigger");
  var_8f235119 = spawner::simple_spawn("vip_area_last_stand_guards", &function_687b1b14);
  namespace_307260b8::function_2b6287f4("vip_last_stand_trigger_reinforcements");
  var_c7d1f560 = spawner::simple_spawn("vip_area_last_stand_guards_reinforcements", &function_687b1b14);
  array::thread_all(var_c7d1f560, &function_165eaaa);
  var_62cf72f4 = arraycombine(var_c7d1f560, var_8f235119);
  level.park.var_24f6e6a6 = 10000;
  level.lazar.var_24f6e6a6 = 10000;
  ai::waittill_dead_or_dying(var_62cf72f4, undefined, undefined, 1);
  level flag::set("flg_vip_door_last_stand_enemies_dead");
  node = getnode("n_park_nuke_room_door", "targetname");
  var_4aec9f2c = getnode("n_lazar_nuke_room_door", "targetname");

  if(isDefined(level.park) && isDefined(level.lazar)) {
    hms_util::print("<dev string:xb2>");

    level.park setdesiredspeed("sprint");
    level.lazar setdesiredspeed("sprint");
    level.park ai::set_behavior_attribute("disablepeek", 1);
    level.park ai::set_behavior_attribute("disablelean", 1);
    level.lazar colors::disable();
    level.park colors::disable();
    level.park setgoal(node);
    level.lazar setgoal(var_4aec9f2c);
  }

  savegame::checkpoint_save();
}

function function_c7c21ff9() {
  level.player endon(#"death");
  var_5b23cbdd = getent("vip_last_stand_trigger", "targetname");
  var_2c3b91fc = struct::get_array("turret_points");
  e_turret = getent("mg_nest_2nd_floor", "targetname");
  level.var_5deea171 = namespace_307260b8::function_516b7ec("2nd_floor_turret_gunner", "2nd_floor_support_turret");
  var_5b23cbdd waittill(#"trigger");
  n_shots = 5;

  if(isalive(level.var_5deea171)) {
    e_turret turret::enable(0, 1, undefined);
    e_turret turret::function_aecc6bed(var_2c3b91fc, n_shots, 0);
  }
}

function function_8604d848() {
  var_1623c030 = getent("vip_guards_flank_encounter_trigger", "targetname");

  if(isDefined(var_1623c030)) {
    var_1623c030 delete();

    hms_util::print("<dev string:xc9>");
  }
}

function function_d1cabeee() {
  level.player endon(#"death");
  level endoncallback(&function_8604d848, #"hash_4c719d73886d1dee");
  var_1623c030 = getent("vip_guards_flank_encounter_trigger", "targetname");

  if(isDefined(var_1623c030) && isalive(level.var_5deea171)) {
    var_1623c030 waittill(#"trigger");

    hms_util::print("<dev string:xec>");

    var_cdad6c18 = spawner::simple_spawn("vip_area_last_stand_guards_optional", &function_687b1b14);
  }
}

function function_803c0cb(var_5d361b57, var_6d6e8577, var_f5d1b9c4, var_5207b7a8) {
  spawner::waittill_ai_group_ai_count(var_5d361b57, var_6d6e8577);
  var_dfcedc81 = spawner::get_ai_group_ai(var_5d361b57);

  foreach(ai in var_dfcedc81) {
    if(isalive(ai)) {
      ai ai::set_behavior_attribute(var_5207b7a8, 1);
      ai ai::force_goal(var_f5d1b9c4);
    }
  }
}

function function_f4e023d2(a_ai_enemies) {
  level.player endon(#"death");
  var_1eea432a = getent("player_hangback_trig", "targetname");
  var_b4725f7b = getent("vip_room_volume", "targetname");

  while(a_ai_enemies.size > 0 && isDefined(var_1eea432a)) {
    if(level.player istouching(var_1eea432a)) {
      level thread function_803c0cb("vip_area_guards", 3, level.player.origin, "sprint");
    } else if(!level.player istouching(var_1eea432a)) {
      level thread function_803c0cb("vip_area_guards", 3, var_b4725f7b, "sprint");
    }

    wait 0.25;
  }
}

function function_165eaaa() {
  self ai::set_behavior_attribute("sprint", 1);
}

function function_687b1b14() {
  self endon(#"death");
  level waittill(#"hash_2e47b50259ab3bec");
  self delete();
}

function function_5e5f8f2(ai_rider, var_9114191) {
  ai_rider waittill(#"death");
  self vehicle::kill_rider(ai_rider);
  self turretcleartarget(var_9114191);
  self notify("turret_disabled" + var_9114191);
}

function function_dda2c76e(var_bf6c8bb9) {
  level endon(#"death");
  var_a274dfb9 = array::random(var_bf6c8bb9);
  var_879729fe = array::random(var_bf6c8bb9);

  while(isDefined(var_a274dfb9) && isDefined(var_879729fe)) {
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01500_csm1_thelabkeepthema_7b");
    var_879729fe hms_util::dialogue("vox_cp_cbcr_01500_csm2_protectthelab_b2");
    wait randomfloatrange(0.5, 1.25);
    var_a274dfb9 hms_util::dialogue("vox_cp_cbcr_01500_csm1_ifwedonotstopth_4e");
    var_879729fe hms_util::dialogue("vox_cp_cbcr_01500_csm2_theresonlythree_75");
    break;
  }
}

function function_5ccf94e2() {
  var_1262898c = getEntArray("projector_trigger", "targetname");

  foreach(trigger in var_1262898c) {
    trigger thread function_fefbff01();
  }
}

function function_fefbff01() {
  exploder::exploder("exploder_lgt_palaceUpper_projector");
  exploder::exploder("projector_exploder");
  self waittill(#"damage");
  exploder::stop_exploder("exploder_lgt_palaceUpper_projector");
  exploder::exploder("projector_explosion");
  snd::client_msg("audio_projector_expl");
  exploder::stop_exploder("projector_exploder");
}