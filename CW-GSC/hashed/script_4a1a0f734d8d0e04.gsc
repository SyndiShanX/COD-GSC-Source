/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a1a0f734d8d0e04.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_3dc93ca9902a9cda;
#using script_5991d6501121591f;
#using script_6bb8615992324ccf;
#using script_7728aa611ab72ad9;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\lui_shared;
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
#using scripts\cp\cp_nic_revolucion;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\land_mine_placed;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_63e55f9b;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_floor_one_struct", "floor_one_park_initial_color");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_floor_one_struct");
  level hms_util::function_ee1d1df6("adler", "Adler", "woods_floor_one_struct", undefined, undefined, level.var_4cdd9d45);
  level hms_util::function_ee1d1df6("mason", "Mason", "mason_floor_one_struct", undefined, undefined, level.var_7b391e49);
  level hms_util::function_ee1d1df6("woods", "Woods", "adler_floor_one_struct", undefined, undefined, level.var_bb9beed5);
  level.var_ba0f7a1a = 1;
  level thread namespace_a789f8ae::function_986b3cba(7, 10);
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  level.var_34c0ce7a = spawnStruct();
  namespace_232ddc52::music("4.0_palace");
  namespace_232ddc52::music("5.0_minefield", undefined, "flg_right_courtyard_initial_spawn");
  namespace_232ddc52::music("6.0_courtyard", undefined, "flg_ambush_spawned");
  namespace_232ddc52::music("deactivate_6.0_courtyard", undefined, "flg_vig_first_floor_door_kick");
  level.player thread namespace_307260b8::function_1b57de8d();
  level.player thread namespace_307260b8::function_e8de26b3();
  level thread namespace_a789f8ae::function_eff61506();
  level thread namespace_a789f8ae::function_6f16e46d();
  level thread namespace_a789f8ae::function_c9b603f3("floor_one");
  level thread namespace_a789f8ae::function_8d918610("floor_one");
  hms_util::function_eaa0342e("floor_one_containment_warnings", "floor_one_containment_fails");
  level thread function_efdab146();
  level thread function_1a77e8e2("trig_floor_one_vignette", "floor_one_drive_by");
  level thread function_4becb74d("trig_cctv_vignette");
  level thread function_d7a2bda8();
  level thread function_8269cbf();
  level thread function_fc9b8c7e();
  level thread namespace_a789f8ae::function_ccfa368();
  level thread function_aeab0158();
  level thread panic_room_fleeing_civ();
  level thread function_d184f2a7();
  level thread function_c8f482ed();
  level function_bf23ef25();
  level thread function_82b2bc5e();
  savegame::checkpoint_save();

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar ai::set_behavior_attribute("demeanor", "combat");
    level.lazar battlechatter::function_2ab9360b(0);
  }

  level flag::set("flg_red_shirts_split");

  if(isDefined(level.woods)) {
    level.woods colors::disable();
    level.woods.goalradius = 8;
    level.woods ai::set_behavior_attribute("demeanor", "combat");
    level.woods val::set(#"hash_6599567569045808", "ignoreall", 1);
    level.woods val::set(#"hash_6599567569045808", "ignoreme", 1);
    level.woods battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.mason)) {
    level.mason colors::disable();
    level.mason.goalradius = 8;
    level.mason ai::set_behavior_attribute("demeanor", "combat");
    level.mason val::set(#"hash_6599567569045808", "ignoreall", 1);
    level.mason val::set(#"hash_6599567569045808", "ignoreme", 1);
    level.mason battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.adler)) {
    level.adler colors::disable();
    level.adler.goalradius = 8;
    level.adler ai::set_behavior_attribute("demeanor", "combat");
    level.adler val::set(#"hash_6599567569045808", "ignoreall", 1);
    level.adler val::set(#"hash_6599567569045808", "ignoreme", 1);
    level.adler battlechatter::function_2ab9360b(0);
  }

  cctv_entrance_door_clip = getent("cctv_entrance_door_clip", "targetname");
  cctv_entrance_door_clip hide();
  cctv_entrance_door_clip notsolid();
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4e>");

  level notify(#"hash_2fb605a6c7053f96");
  namespace_a789f8ae::function_afa9528d(0);
  var_cdb289d1 = getEntArray("land_mine_placed", "targetname");
  e_vol = getent("first_courtyard_landmine_volume", "targetname");

  foreach(e_mine in var_cdb289d1) {
    if(e_mine istouching(e_vol)) {
      e_mine delete();
    }
  }
}

function function_d7a2bda8() {
  objectives::scripted("obj_goto_security_room", undefined, #"hash_64b4beed7c03f4a2");
  level breadcrumb::function_61037c6c("bc_first_floor_objective");
  level flag::wait_till("flg_security_room_entered");
  level breadcrumb::function_e261021e("bc_first_floor_objective");
  objectives::complete("obj_goto_security_room");
  skipto::function_4e3ab877("1st_floor");
}

function function_aeab0158() {
  flag::wait_till("flg_enable_bc_courtyard");
  savegame::checkpoint_save();
}

function panic_room_fleeing_civ() {
  namespace_307260b8::function_2b6287f4("panic_room_fleeing_civ");
  var_e09781cd = spawner::simple_spawn_single("fleeing_civ_lower_courtyard", &function_a2f76a8e);
  doors::open("side_room_doors", "targetname", var_e09781cd);
  snd::client_msg("audio_courtyard_side_doors_open");
  wait 1.25;
  doors::function_f35467ac("side_room_doors", "targetname");
  var_2c82cf72 = struct::get("panic_room_magic_bullet_spawner", "targetname");

  while(isalive(var_e09781cd)) {
    magicbullet(getweapon(#"ar_accurate_t9"), var_2c82cf72.origin, var_e09781cd gettagorigin("tag_eye"));
    wait randomfloatrange(0.15, 0.25);
  }
}

function function_718b720f() {
  level.player endon(#"death");
  level waittill(#"hash_16165b3f25c881f4");
  var_16bf64d2 = randomintrangeinclusive(0, 1);

  switch (var_16bf64d2) {
    case 0:
      level.park hms_util::dialogue("vox_cp_cbcr_02400_park_minedefused_b7");
      break;
    case 1:
      level.park hms_util::dialogue("vox_cp_cbcr_02400_park_bombdefused_ae");
      break;
  }
}

function function_b441e79f() {
  self endon(#"death");
  self setgoal(self.origin);
  self val::set(#"fleeing_civ", "ignoreall", 1);

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), self getEye(), cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), self getEye(), 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      hms_util::print("<dev string:x62>");

      break;
    }

    waitframe(1);
  }

  self ai::set_behavior_attribute(#"_civ_mode", "run");
  self thread spawner::go_to_struct(struct::get("mine_civ_goal", "targetname"));
  level flag::set("flg_vo_mines");
  self waittill(#"reached_path_end");
  self ai::set_behavior_attribute(#"_civ_mode", "panic");
  var_200e33ac = getent("mine_intro", "script_noteworthy");
  var_200e33ac.t_proximity notify(#"trigger");
  wait 1;
  savegame::checkpoint_save();
}

function function_a2f76a8e() {
  self endon(#"death");
  self ai::set_behavior_attribute(#"_civ_mode", "run");
  self waittill(#"reached_path_end");
  self kill();
}

function function_bf23ef25() {
  namespace_307260b8::function_2b6287f4("gazebo_color_group");
  level.lazar setdesiredspeed("shuffle");
  level.park setdesiredspeed("shuffle");
  wait 1;
  var_5a14aaf0 = spawner::simple_spawn("right_courtyard_exit_enemies");
  level flag::set("flg_ambush_spawned");
  level thread function_41dd485b();
}

function function_41dd485b() {
  namespace_307260b8::function_2b6287f4("trigger_exit_courtyard_1");
  a_ai_enemies = getactorarray("right_courtyard_exit_enemies", "targetname");
  array::thread_all(a_ai_enemies, &function_f46ca8fb);
  scene::play("scene_rev_2030_fir_park_mantle", level.park);
}

function function_fc9b8c7e() {
  t_spawn = getent("right_1_enemy_trigger", "targetname");
  t_spawn waittill(#"trigger");
  level.park.grenadeammo = 5;
  level.lazar.grenadeammo = 5;
  level.park.script_accuracy = 0.3;
  level.lazar.script_accuracy = 0.3;
  level waittill(#"hash_20b372100c1d49b2");
  wait 0.25;
  var_12576417 = spawner::simple_spawn("courtyard_exit_spawner");
  ai::waittill_dead_or_dying(var_12576417, 0, 15);
  level flag::set("flg_banter_vo");
  array::thread_all(var_12576417, &function_f46ca8fb);
}

function function_12deeb75() {
  self ai::set_behavior_attribute("demeanor", "cqb");
}

function function_eac97f7a() {
  self endon(#"death");
  self waittill(#"damage", #"bulletwhizby");
  wait randomfloatrange(0.5, 1.5);
  self function_f46ca8fb(250);
}

function function_c1ed8300() {
  level.player endon(#"death");
  level flag::wait_till("flg_right_courtyard_initial_spawn");
  savegame::checkpoint_save();
  var_864dbd75 = spawner::simple_spawn("right_courtyard_initial_enemies");
  t_spawn = getent("first_floor_allies_trigger", "targetname");
  t_spawn waittill(#"trigger");
  var_727580f3 = spawner::simple_spawn("right_courtyard_enemy_spawner");
  var_425b2d39 = arraycombine(var_864dbd75, var_727580f3);
  ai::waittill_dead_or_dying(var_425b2d39, 3, 45);
  function_1eaaceab(var_425b2d39);
  var_425b2d39 = arraysortclosest(var_425b2d39, level.player.origin);

  for(i = 0; i < var_425b2d39.size; i++) {
    if(i <= 2) {
      var_425b2d39[i] thread function_f46ca8fb();
      continue;
    }

    var_425b2d39[i] thread function_1bdb683("courtyard_fountain_fallback");
  }

  util::delay(7.5, undefined, &trigger::use, "gazebo_color_group");
}

function function_f46ca8fb(var_4b433742 = 500, var_97055d22 = 1) {
  self endon(#"death");

  if(var_97055d22) {
    wait randomfloatrange(0.5, 2.5);
  }

  self setgoal(level.player, 0, var_4b433742);
}

function function_1bdb683(var_9608b240, min_delay = 2.5, max_delay = 5) {
  self endon(#"death");
  wait randomfloatrange(min_delay, max_delay);
  self ai::set_pacifist(1);
  self ai::set_goal(var_9608b240, "targetname", 1);
  self waittilltimeout(3, #"goal");
  self ai::set_pacifist(0);
}

function function_1eb3b7ac() {
  level endon(#"hash_50cbe4c0247f66ca");
  var_4a3daa0b = struct::get("balcony_drone_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      hms_util::print("<dev string:x71>");

      break;
    }

    waitframe(1);
  }

  var_44756054 = spawner::simple_spawn("courtyard_balcony_drone");
}

function function_d184f2a7() {
  namespace_307260b8::function_2b6287f4("panic_room_encounter_trig");
  var_3665bea = spawner::simple_spawn("panic_room_encounter_enemies", &function_eac97f7a);
}

function function_c8f482ed() {
  namespace_307260b8::function_2b6287f4("panic_room_encounter_trig");
  var_c228b588 = spawner::simple_spawn_single("panic_room_guard");
  var_c228b588.grenadeammo = 0;
  var_b543969b = struct::get("panic_room_lookat", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_b543969b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_b543969b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      hms_util::print("<dev string:x88>");

      break;
    }

    waitframe(1);
  }

  var_fc6c4527 = getent("panic_room_door", "targetname");
  var_3b7aad05 = struct::get("panic_room_door_moveto_closed", "targetname");
  var_fc6c4527 moveto(var_3b7aad05.origin, 3.5);
  snd::play("evt_panic_room_door", var_fc6c4527);
  var_50f5aa55 = struct::get("panic_room_interact", "targetname");
  var_35c66d32 = util::spawn_model("tag_origin", var_50f5aa55.origin, var_50f5aa55.angles);
  var_35c66d32 util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_77f2f4b5474df6a1", 64, undefined, undefined, undefined, 145);
  var_35c66d32 waittill(#"trigger");
  level namespace_a789f8ae::function_5997824f();
  var_72b63413 = struct::get("panic_room_door_moveto_open", "targetname");
  var_fc6c4527 moveto(var_72b63413.origin, 3.5);
  snd::play("evt_panic_room_door", var_fc6c4527);
  wait 1.5;

  if(isalive(var_c228b588)) {
    var_c228b588 setgoal(level.player, 1, 200);
    var_c228b588 hms_util::dialogue("vox_cp_cbcr_01200_csm2_ididntsignupfor_ad");
  }

  level flag::wait_till("flg_player_left_panic_room");
  savegame::checkpoint_save();
}

function function_82b2bc5e() {
  namespace_307260b8::function_2b6287f4("spawn_balcony_rpg_enemy");
  level notify(#"hash_50cbe4c0247f66ca");
  level.lazar setdesiredspeed("jog");
  level.park setdesiredspeed("jog");
  level flag::set("flg_rpg_scripted");
  level.var_cd37abff = spawner::simple_spawn_single("floor_two_balcony_rpg", &function_d210173f, "balcony_rpg_inital_pos", "balcony_rpg_target", "balcony_rpg_volume", "flg_balcony_rpg_fire");
  savegame::checkpoint_save();
  level flag::wait_till("flg_balcony_rpg_fire");
  var_decc34ff = spawner::simple_spawn("left_courtyard_balcony_enemies");
  var_a94b43b3 = arraycombine(var_decc34ff, [level.var_cd37abff]);
  level thread function_a02e8212(var_a94b43b3);
  level thread function_25e8f9d6();
  level flag::wait_till("flg_first_floor_2nd_courtyard_reinforcements");
  level notify(#"hash_4f2daaca49b239c4");
  savegame::checkpoint_save();
  var_34a2caa8 = spawner::simple_spawn("left_3_enemy_spawner");
  level thread function_2b154e4a(var_34a2caa8, 2);
  level.var_c65a97ee = spawner::get_ai_group_count("second_courtyard");
  level flag::set("flg_all_guys_spawned");
  level flag::wait_till("flg_first_floor_reinforce_cctv_door");
  id = objectives::function_285e460("obj_goto_security_room");
  thread objectives_ui::function_f3ac479c(id);
  level.player thread objectives_ui::show_objectives();
  savegame::checkpoint_save();
  var_62a189d1 = spawner::simple_spawn("left_courtyard_reinforce_door_spawner");
  var_a94b43b3 = arraycombine(var_a94b43b3, var_62a189d1);
  level flag::wait_till("flg_vig_first_floor_door_kick");
  var_4a3daa0b = struct::get("first_floor_cctv_door_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  level flag::set("flg_cctv_open");
  function_1eaaceab(var_a94b43b3);

  foreach(ai in var_a94b43b3) {
    ai delete();
  }

  var_7bacf73f = level spawner::simple_spawn("cctv_guards");
  a_actors = [];
  a_actors[#"actor 1"] = var_7bacf73f[0];
  a_actors[#"actor 2"] = var_7bacf73f[1];
  a_actors[#"actor 1"] thread function_c4edad62();
  a_actors[#"actor 2"] thread function_34c5b067();
  a_actors[#"actor 1"] val::set(#"door_kick", "takedamage", 0);
  a_actors[#"actor 2"] val::set(#"door_kick", "takedamage", 0);
  level thread scene::play("cctv_door_kick_scene", "targetname", a_actors);
  a_actors[#"actor 1"] waittill(#"hash_553184e6c2383c0d");
  doors::open("cctv_entrance_door_01", "targetname", a_actors[#"actor 1"]);
  a_actors[#"actor 1"] val::reset(#"door_kick", "takedamage");
  a_actors[#"actor 2"] val::reset(#"door_kick", "takedamage");
  doors::function_f35467ac("cctv_entrance_door_01", "targetname");
  thread function_40626d6c();
  ai::waittill_dead_or_dying(var_7bacf73f, var_7bacf73f.size);
  wait 0.2;
  trigger::use("allies_enter_cctv_room", "targetname");
  savegame::checkpoint_save(1);
  level notify(#"hash_2217c60a57d6c9a3");
}

function function_a02e8212(a_ai_enemies) {
  level endon(#"hash_4f2daaca49b239c4");
  ai::waittill_dead_or_dying(a_ai_enemies, 3);
  wait 1.5;
  flag::set("flg_first_floor_2nd_courtyard_reinforcements");
}

function function_25e8f9d6() {
  level endon(#"hash_4f2daaca49b239c4");
  namespace_307260b8::function_2b6287f4("left_courtyard_fight_trigger");
  flag::set("flg_first_floor_2nd_courtyard_reinforcements");
}

function function_40626d6c() {
  posent = getent("cctv_soldier_slide_phys_loc", "targetname");
  var_39cfa734 = getent("cctv_soldier_slide_phys_loc_2", "targetname");
  physicsexplosionsphere(posent.origin, 90, 0, 0.16);
  wait 1;
  physicsexplosionsphere(var_39cfa734.origin, 90, 0, 0.16);
}

function function_d210173f(var_3c97f36d, var_5442a320, var_f4145afc, var_695971f7) {
  self endon(#"death");
  self setdesiredspeed("sprint");
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 1);
  self spawner::go_to_struct(struct::get(var_3c97f36d, "targetname"));
  self waittill(#"goal");

  if(isDefined(var_695971f7)) {
    level flag::wait_till(var_695971f7);
  }

  self thread ai::shoot_at_target("normal", getent(var_5442a320, "targetname"), "tag_origin", 10, 100, 1);
  self waittill(#"shoot");
  self ai::stop_shoot_at_target();
  level thread function_b23f3226();
  self setgoal(getent(var_f4145afc, "targetname"), 1);
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 0);
}

function function_b23f3226() {
  level endon(#"flg_hands_up_played");
  vol = getent("scripted_rpg_hands_up_trig", "targetname");

  if(istouching(level.player.origin, vol)) {
    wait 0.5;
    level.player playrumbleonentity("damage_light");
    screenshake(level.player.origin, 12, 6, 6, 1.5, 0, 0.8, 0, 2, 0.5, 0.5, 2);
    level.player playgestureviewmodel(#"hash_5723248289b2a00b");
    level flag::set("flg_hands_up_played");
    return;
  }
}

function function_c4edad62() {
  self endon(#"death");
  self waittill(#"hash_542161c43bda2568");
  var_c0a56818 = getnode("post_door_kick_goal_node", "targetname");
  self setgoal(var_c0a56818);
  self getenemyinfo(level.player);
}

function function_34c5b067() {
  self endon(#"death");
  self waittill(#"hash_542161c43bda2568");
  self setgoal(level.player, 1, 150);
}

function function_2b154e4a(ai_array, killcount) {
  ai::waittill_dead_or_dying(ai_array, killcount);
  function_1eaaceab(ai_array);
  array::thread_all(ai_array, &function_f46ca8fb);
}

function function_6e03dd7d() {
  level.player endon(#"death");
  level flag::wait_till("flg_vo_scientist_floor_1");
  var_4a3daa0b = struct::get("floor_one_dead_bodies", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(45));

    if(within_fov == 1) {
      break;
    }

    waitframe(1);
  }

  level.park hms_util::dialogue("vox_cp_cbcr_01300_park_thereareclosedc_9b");
  level.park hms_util::dialogue("vox_cp_cbcr_01300_park_wecouldusethemt_22");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01300_lazr_niceshotsharpas_5d");
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

function function_393a7ac3() {
  level.player endon(#"death");
  level flag::wait_till("flg_stop_dead_bodies");
  exploder::exploder("floor_one_cctv_sparks");
  level flag::wait_till("flg_obj_courtyard_update");
  exploder::exploder_stop("floor_one_cctv_sparks");
}

function function_8269cbf() {
  level.player endon(#"death");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  var_241fd810 = getent("t_extra_vo_talk", "targetname");
  level flag::wait_till("flg_dead_bodies_entrance");
  var_4a3daa0b = struct::get("entrance_bodies_struct", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(45));

    if(within_fov == 1) {
      break;
    }

    waitframe(1);
  }

  wait 0.25;
  level.lazar hms_util::dialogue("vox_cp_cbcr_02400_lazr_whatdthesepoorb_b2");

  if(!flag::get("flg_stop_dead_bodies")) {
    level.park hms_util::dialogue("vox_cp_cbcr_02400_park_theyfinishedthe_c9");
    level.lazar hms_util::dialogue("vox_cp_cbcr_02400_lazr_hellofareward_ce");
  }

  level flag::set("flg_vo_done_play_adler_nag");
  level thread function_393a7ac3();
  level thread function_6e03dd7d();
  level flag::wait_till("flg_banter_vo");
  var_18f35bb2 = struct::get("first_floor_woods_vo", "targetname");
  var_ab0186f6 = spawner::get_ai_group_ai("table_room_guys");
  ai::waittill_dead_or_dying(var_ab0186f6, 3, 200);
  var_527d6757 = getent("trig_side_table_room", "targetname");
  wait randomfloatrange(2, 4);

  if(!flag::get("flg_right_courtyard_initial_spawn") && level.player istouching(var_527d6757)) {
    level.park hms_util::dialogue("vox_cp_cbcr_02400_park_itsquietallofas_13");
    wait 0.2;
    level.park hms_util::dialogue("vox_cp_cbcr_02400_park_staysharp_0d");
  }

  level flag::wait_till("flg_vo_mines");
  level thread function_718b720f();
  level.lazar hms_util::dialogue("vox_cp_cbcr_02400_lazr_contact_ed");
  level.var_dc8e763c hms_util::dialogue("vox_cp_cbcr_02400_ms2_helpustheyretry_f3");
  level thread function_ca5ecc5();
  level flag::wait_till("flg_ambush_spawned");
  wait 0.75;
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_ambush_81");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(1);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(1);
  }

  level flag::wait_till("flg_balcony_rpg_fire");

  if(isalive(level.var_cd37abff)) {
    level.park hms_util::dialogue("vox_cp_cbcr_02400_park_rpgonthebalcony_71");
  }

  level flag::wait_till("flg_all_guys_spawned");
  var_bb84ad51 = 0;

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  while(level.player istouching(var_241fd810)) {
    hms_util::print(level.var_c65a97ee);

    if(level.var_c65a97ee <= 10 && !var_bb84ad51) {
      level.lazar hms_util::dialogue("vox_cp_cbcr_01300_lazr_parkwaddayasayy_15");
      wait 0.2;
      level.park hms_util::dialogue("vox_cp_cbcr_01300_park_yourpersistence_a5");
      level.lazar hms_util::dialogue("vox_cp_cbcr_01300_lazr_thatsnotano_0c");
      wait 0.25;
      var_18f35bb2 hms_util::dialogue("vox_cp_cbcr_01300_wood_jeezusgetafucki_ab", 1, "allies", "Woods");
      var_bb84ad51 = 1;
      break;
    } else if(flag::get("flg_cctv_vo_flirt") && !var_bb84ad51) {
      level.lazar hms_util::dialogue("vox_cp_cbcr_01300_lazr_parkwaddayasayy_15");
      wait 0.2;
      level.park hms_util::dialogue("vox_cp_cbcr_01300_park_yourpersistence_a5");
      level.lazar hms_util::dialogue("vox_cp_cbcr_01300_lazr_thatsnotano_0c");
      wait 0.25;
      var_18f35bb2 hms_util::dialogue("vox_cp_cbcr_01300_wood_jeezusgetafucki_ab", 1, "allies", "Woods");
      var_bb84ad51 = 1;
      break;
    }

    level.var_c65a97ee = spawner::get_ai_group_count("second_courtyard");
    wait 1;
  }
}

function function_ca5ecc5() {
  level.player endon(#"death");
  level endon(#"flg_ambush_spawned");
  level waittill(#"hash_ab5ce3c74acd448");
  wait 0.5;
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_fuckeveryonealr_61");
  wait 1.5;
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_bellsweepformin_c0");
}

function function_da0bfdde() {
  level.player endon(#"death");
  var_81f9e5e = getEntArray("t_searching", "targetname");
  var_f5488cfa = array("vox_cp_cbcr_01300_park_thecameracontro_06", "vox_cp_cbcr_01300_park_thisisntit_9c", "vox_cp_cbcr_01300_park_keeplooking_c6", "vox_cp_cbcr_01300_park_shitwhereisthat_ca");

  while(!flag::get("flg_cctv_vo_wonder_cables")) {
    foreach(trig in var_81f9e5e) {
      trig waittill(#"trigger");
      level thread function_8880c1e3(var_f5488cfa);
    }

    wait 0.1;
  }
}

function function_8880c1e3(var_305d3956) {
  var_16bf64d2 = randomintrangeinclusive(0, 3);
  level.park hms_util::dialogue(var_305d3956[var_16bf64d2]);
  array::remove_index(var_305d3956, var_16bf64d2);
}

function function_efdab146() {
  var_aa87baf1 = getent("pallet_destruction_trigger", "targetname");
  var_aa87baf1 trigger::wait_till();
  snd::client_msg("rpg_vs_pillar");
  scene::play_from_time("p9_fxanim_cp_revolucion_pallet_destruction_bundle", "play");
  scene::function_f81475ae("p9_fxanim_cp_revolucion_pallet_destruction_bundle");
}

function function_1a77e8e2(t_trig, var_c68d51a8) {
  level.player endon(#"death");
  var_9e332b5a = getent(t_trig, "targetname");
  var_9e332b5a waittill(#"trigger");
  veh = vehicle::simple_spawn_and_drive(var_c68d51a8);
  var_a974a435 = getEntArray("floor_1_riders", "targetname");

  foreach(v in veh) {
    v val::set("first_vignette", "ignoreme", 1);
  }

  snd::play([0, "veh_ext_truck_lp", 1.5], veh);
  level flag::wait_till("flg_stop_audio_floor1");

  hms_util::print("<dev string:xa1>");

  snd::stop_alias("veh_ext_truck_lp", veh);

  foreach(v in var_a974a435) {
    if(isDefined(v)) {
      v deletedelay();
    }
  }
}

function function_4becb74d(t_trig) {
  level.player endon(#"death");
  var_1aaaab19 = getent(t_trig, "targetname");
  var_1c12e0b4 = struct::get("vol_goal");
  var_1aaaab19 waittill(#"trigger");
  var_d293bb3b = randomintrangeinclusive(0, 2);
  wait randomfloatrange(0.25, 1.25);

  switch (var_d293bb3b) {
    case 0:
      veh = vehicle::simple_spawn_and_drive("cctv_drive_loop");

      foreach(v in veh) {
        v val::set("v1", "ignoreme", 1);
      }

      snd::play("veh_cctv_truck_driveby_lp", veh);
      break;
    case 1:
      veh = vehicle::simple_spawn_and_drive("cctv_drive_loop_2");

      foreach(v in veh) {
        v val::set("v2", "ignoreme", 1);
      }

      wait randomfloatrange(0.25, 1.25);
      var_c26707f = vehicle::simple_spawn_and_drive("cctv_drive_loop_2_2");

      foreach(v in var_c26707f) {
        v val::set("v3", "ignoreme", 1);
      }

      snd::play("veh_cctv_truck_driveby_lp", var_c26707f);
      break;
    case 2:
      wait randomfloatrange(0.25, 1.25);
      veh = vehicle::simple_spawn_and_drive("cctv_drive_drop_off");

      foreach(v in veh) {
        v val::set("v4", "ignoreme", 1);
      }

      snd::play("veh_cctv_truck_driveby_lp", veh);
      wait randomfloatrange(0.25, 1.25);
      var_c26707f = vehicle::simple_spawn_and_drive("cctv_drive_drop_off_2");

      foreach(v in var_c26707f) {
        v val::set("v5", "ignoreme", 1);
      }

      snd::play("veh_cctv_truck_driveby_lp", var_c26707f);
      wait randomfloatrange(0.25, 1.25);
      var_8c12f056 = vehicle::simple_spawn_and_drive("cctv_drive_drop_off_3");

      foreach(v in var_8c12f056) {
        v val::set("v6", "ignoreme", 1);
      }

      snd::play("veh_cctv_truck_driveby_lp", var_8c12f056);
      break;
  }

  wait randomfloatrange(2, 4.25);
  a_ai = spawner::simple_spawn("drone_runner_guys");

  foreach(ai in a_ai) {
    ai val::set("v7", "ignoreme", 1);
  }
}