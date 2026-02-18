/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_43e82b8f8b9aea77.gsc
***********************************************/

#using script_19971192452f4209;
#using script_2d443451ce681a;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using script_eb1a9e047313195;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\util;
#namespace namespace_fdde5f3d;

function function_f50bc4b9() {
  level flag::init("flag_post_prisoner_ally_enter");
  level flag::init("flag_post_prisoner_ally_exit");
  level flag::init("flag_post_prisoner_lie");
  level flag::init("flag_post_prisoner_truth");
  level flag::init("flag_post_prisoner_radio");
  level flag::init("flag_post_prisoner_complete");
}

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  if(level.var_b28c2c3a == "dev_post_prisoner_park_survived") {
    level.player player_decision::function_ff7e19cb(0);
  }

  if(level.var_b28c2c3a == "dev_post_prisoner_lazar_survived") {
    level.player player_decision::function_ff7e19cb(1);
  }

  if(level.var_b28c2c3a == "dev_post_prisoner_no_survivors") {
    level.player player_decision::function_ff7e19cb(2);
  }

  level.player districts::function_a7d79fcb("safehouse", 1);
  level thread scene::init_streamer(#"scene_hub_post_prisoner_dialog_lazar_survived", getplayers());
  level thread scene::init_streamer(#"scene_hub_post_prisoner_dialog_park_survived", getplayers());
  level thread scene::init_streamer(#"scene_hub_post_prisoner_dialog_no_survivor", getplayers());
  level thread scene::init_streamer(#"scene_hub_post_prisoner_flashback_overlook", getplayers());
  level thread namespace_31c67f6d::function_12e3ea01();
  level namespace_31c67f6d::function_6194f34a("post_prisoner", 1);
  level thread function_dbf5481b();
  level thread namespace_4ed3ce47::function_7edafa59(var_50cc0d4f + "_briefing");
  level thread exploder::exploder("exp_post_armada_lazar_workbench");
  level thread exploder::exploder("exp_lgt_post_prioner_dialog");
  collision = getent("gurney_collision", "targetname");
  collision hide();
  level thread function_c21e258e();
  level thread namespace_31c67f6d::function_b0558ba2("8");
  level function_3b9f24df();
  skipto::function_4e3ab877("post_prisoner");
}

function function_3b9f24df() {
  level.player endon(#"death");
  level.var_ea95c1e7 = namespace_31c67f6d::function_c9dc0e79();
  level.player thread clientfield::set_to_player("set_hub_fov", 1);
  level.player val::set("safehouse", "freezecontrols_allowlook", 1);
  level.player val::set("safehouse", "allow_melee", 0);
  level.player val::set("safehouse", "allow_jump", 0);
  level.player.var_c681e4c1 = 1;
  level.player disableweapons(1);
  level thread function_270a48e0();
  level flag::wait_till("level_is_go");

  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    waitframe(1);
  }

  level thread function_474dc7d3();
  wait 2;

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }

  level flag::wait_till(#"gameplay_started");
  level thread namespace_31c67f6d::pstfx_teleport(2, 1, 1, 1);
  wait 2;
  level thread function_f8e379f0();
  level thread util::delay(1, undefined, &globallogic_ui::function_7bc0e4b9, 0, 0);
  level function_3812af3b();
  level function_5091c7b2();
  level function_5e48631f();
  level function_92141ec2();
  level function_8c5e0f4f();
  level function_3c0e1eab();
  level function_b96d7941();
  level function_4f7ea045();
  level function_40dc24e2();
  level function_af645aa();
  level function_49bbba06();
  level function_96eb5464();
  level function_47f7d061();
  level function_8c6c6957();
  level function_855165f7();
  level function_a53df109();
}

function function_270a48e0() {
  var_ea95c1e7 = namespace_31c67f6d::function_c9dc0e79();

  switch (var_ea95c1e7) {
    case # "park":
      level.str_scene_name = "scene_hub_post_prisoner_dialog_park_survived";
      break;
    case # "lazar":
      level.str_scene_name = "scene_hub_post_prisoner_dialog_lazar_survived";
      break;
    case # "sims":
      level.str_scene_name = "scene_hub_post_prisoner_dialog_no_survivor";
      break;
  }
}

function function_474dc7d3() {
  level thread scene::init(level.str_scene_name, "dt_01_enter", level.var_58ccee4);
}

function function_3812af3b() {
  level thread namespace_4ed3ce47::function_e522e5de();
  level scene::play(level.str_scene_name, "dt_01_enter", level.var_58ccee4);
  level thread scene::play(level.str_scene_name, "dt_01_waiting_idle", level.var_58ccee4);
}

function function_5091c7b2() {
  level thread scene::play(level.str_scene_name, "dt_01_waiting_idle", level.var_58ccee4);
  level.adler.var_dfbbd0a = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_dfbbd0a dialog_tree::add_option(#"hash_14ea8d0dbbc54b93", undefined, "dt_1a", "dt_01_waiting_idle", 1);
  level.adler.var_dfbbd0a dialog_tree::add_option(#"hash_14f4bd0dbbcdf1a8", undefined, "dt_1b", "dt_01_waiting_idle", 1);
  level dialog_tree::function_21780fc5(level.adler.var_dfbbd0a, array(1224, 650));
  level.adler.var_dfbbd0a dialog_tree::run(level.adler);
}

function function_5e48631f() {
  level thread scene::play(level.str_scene_name, "dt_01_waiting_idle", level.var_58ccee4);
  level.adler.var_fc421997 = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_fc421997 dialog_tree::add_option(#"hash_54b2eb15279dd690", undefined, "dt_2a", "dt_01_waiting_idle");
  level.adler.var_fc421997 dialog_tree::add_option(#"hash_54a8fb1527959d3b", undefined, undefined, undefined, 1, undefined, undefined, &function_5271d49a);
  level.adler.var_fc421997 dialog_tree::add_option(#"hash_54abdf152797a37e", undefined, undefined, undefined, 1, undefined, undefined, &function_3c3aa82c);
  level dialog_tree::function_21780fc5(level.adler.var_fc421997, array(1224, 650));
  level.adler.var_fc421997 dialog_tree::run(level.adler);
}

function function_5271d49a() {
  function_ab329090("dt_2b");
}

function function_3c3aa82c() {
  function_ab329090("dt_2c");
}

function function_ab329090(str_shotname) {
  level thread scene::play(level.str_scene_name, str_shotname, level.var_58ccee4);
  level waittill(#"hash_77c12f83fb0438ea");
  level thread namespace_31c67f6d::pstfx_teleport(1, 1, 1, undefined, 1);
  wait 1;
  level scene::stop();
  level thread scene::play(level.str_scene_name, "dt_03_waiting_idle", level.var_58ccee4);
}

function function_92141ec2() {
  function_b663575e();
  snd::client_msg(#"hash_1b78b54c338981ad");
  level thread namespace_4ed3ce47::function_a59705f8();
  wait 0.75;
  level.player districts::function_a7d79fcb("airstrip", 1);
  level flag::set("af_player_start_ride");
  level scene::stop(level.str_scene_name);
  level.var_20047fb0 = getDvar(#"hash_62b11f12963c68d4");
  setDvar(#"hash_62b11f12963c68d4", 2000);
  level.var_f9247f8c = getDvar(#"hash_4af7f2a3b5e31c77");
  setDvar(#"hash_4af7f2a3b5e31c77", 0.5);
  level.var_3b87c282 = getDvar(#"hash_7b06b8037c26b99b");
  setDvar(#"hash_7b06b8037c26b99b", 255);
  function_cbd66c4c();
  setDvar(#"hash_62b11f12963c68d4", level.var_20047fb0);
  setDvar(#"hash_4af7f2a3b5e31c77", level.var_f9247f8c);
  setDvar(#"hash_7b06b8037c26b99b", level.var_3b87c282);
  level.player districts::function_a7d79fcb("safehouse", 1);
}

function function_b663575e() {
  function_f7c7ce51();
  level.player = getplayers()[0];
  level thread scene::init("scene_hub_post_prisoner_flashback_overlook", "overlook_shot", [level.arash, level.var_e2e0716f]);
  level thread scene::init("scene_tkd_hit3_intro_overlook", "overlook_shot", undefined);
  level thread scene::init("scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot", undefined);
}

function function_cbd66c4c() {
  setsaveddvar(#"hash_7bf40e4b6a830d11", 0);
  level.player setcinematicmotionoverride("cinematicmotion_handheld_heavy");
  level.player playrumblelooponentity("chopper_gunner_rumble_intro");
  vehicle::add_spawn_function_group("airport_truck_approach", "targetname", &function_78bc26d5);
  vehicle::simple_spawn("airport_truck_approach");
  plane = function_5431431d();
  function_c8381339(plane, 0);
  level thread function_5dd4ff85();
  thread function_82ab6677();
  thread function_f406d0f4();
  vehicle::add_spawn_function_group("af_intro_vehicle", "targetname", &function_78bc26d5);
  guys = ai::array_spawn("af_unloader_guy");
  thread function_c6f0c41a(guys);
  level music::setmusicstate("b2.0_recon", undefined, 6);
  level thread scene::play_from_time("scene_hub_post_prisoner_flashback_overlook", "overlook_shot", [level.arash, level.var_e2e0716f]);
  level thread scene::play_from_time("scene_tkd_hit3_intro_overlook", "overlook_shot", undefined);
  level thread scene::play_from_time("scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot", undefined);
  level thread util::delay("play_b3.0_iced_mus", undefined, &music::function_edda155f, "b3.0_iced");
  level thread util::delay("play_b3.0_iced_mus", undefined, &music::setmusicstate, "b4.0_hold_fire");
  level thread util::delay("play_b4.1_identify_mus", undefined, &music::function_edda155f, "b4.1_identify");
  wait 1;
  level.player val::set(#"overlook", "ignoreme", 1);
  wait 50;
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, 0, 3);
  level.arash dialogue::queue("vox_cp_sh8_00010_adlr_voweweretherewe_12");
  waitframe(1);
  thread function_cd682321(guys, plane);
  snd::client_msg(#"hash_5c379cf8b486919b");
}

function function_f8e379f0() {
  thread namespace_31c67f6d::function_77a7721();
}

function function_82ab6677() {
  level waittill(#"hash_2b4e106c6a717410");
  level.player setcinematicmotionoverride("default_cinematicmotion");
  level.player stoprumble("chopper_gunner_rumble_intro");
  var_fe4a8480 = getent("intel_dossier", "targetname");
  var_fe4a8480 setModel("p9_sr_evidence_perseus_bloody_dossier_01a_anim");
}

function function_f406d0f4() {
  level.player val::set("intro_player_anim", "takedamage", 1);
  level waittill(#"hash_5f328340bea67520");
  level.player dodamage(20, level.player.origin + (0, 0, 60));
  level waittill(#"hash_5f328340bea67520");
  level.player dodamage(20, level.player.origin + (0, 0, 60));
}

function function_c6f0c41a(guys) {
  foreach(guy in guys) {
    guy val::set("tarmac", "ignoreall", 1);
  }
}

function function_cd682321(guys, plane) {
  level thread scene::stop("scene_hub_post_prisoner_flashback_overlook", 1);
  level thread scene::stop("scene_tkd_hit3_intro_overlook", 1);
  level thread scene::stop("scene_tkd_hit3_intro_overlook_enemy4", 1);
  plane thread scene::stop("scene_tkd_hit3_chase_plane", 1);

  foreach(guy in guys) {
    if(isDefined(guy)) {
      guy delete();
    }
  }

  if(isDefined(plane)) {
    plane delete();
  }

  if(isDefined(level.arash)) {
    level.arash delete();
  }

  if(isDefined(level.var_e2e0716f)) {
    level.var_e2e0716f delete();
  }
}

function function_5431431d() {
  plane = getent("cargo_plane", "targetname");
  plane notsolid();
  var_853687bd = getEntArray("af_plane_triggers", "targetname");
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_floor_clip", "targetname"));
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_cargo", "targetname"));

  foreach(thing in var_853687bd) {
    thing enablelinkto();
    thing linkto(plane, "tag_body_animate");
  }

  scene::add_scene_func("scene_tkd_hit3_chase_plane", &function_d804fc99, "init");
  plane thread scene::init("scene_tkd_hit3_chase_plane");
  thread function_d60a1c78(plane);
  level.af_plane = plane;
  level.var_c7b3a621 = util::spawn_model("tag_origin", plane.origin - (200, 0, 175), plane.angles);
  level.var_c7b3a621 linkto(plane);
  function_c8381339(plane, 1);
  return plane;
}

function function_c8381339(plane, var_857b0901) {
  probe = getent("cargo_probe_1", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-24, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_2", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-152, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_3", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-288, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_4", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-408, 0, -40), (0, 0, 0));
  }

  if(var_857b0901) {
    probe = getent("cargo_probe_5", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (-72, 0, -88), (0, 0, 0));
    }

    probe = getent("cargo_probe_6", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (72, 280, -48), (0, 0, 0));
    }

    probe = getent("cargo_probe_7", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (72, -280, -48), (0, 0, 0));
    }

    probe = getent("cargo_probe_8", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (-664, 200, -40), (0, 0, 0));
    }

    probe = getent("cargo_probe_9", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (-664, -200, -40), (0, 0, 0));
    }
  }
}

function function_d804fc99(a_ents) {
  var_936fb5e7 = ["Prop 1", "Prop 2", "Prop 3", "Prop 4"];

  foreach(prop in var_936fb5e7) {
    if(isDefined(a_ents[prop]) && !isDefined(a_ents[prop].clip)) {
      clip = getent(prop, "script_noteworthy");
      a_ents[prop].clip = clip;
      clip linkto(a_ents[prop], undefined, (0, 0, 0), (0, 0, 0));
    }
  }
}

function function_d60a1c78(plane) {
  wait 0.2;
  level.plane_mover = util::spawn_model("tag_origin", plane.origin, plane.angles);
  plane linkto(level.plane_mover, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5dd4ff85() {
  level waittill(#"hash_59132013626fbab6");
  level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot");
}

function function_f7c7ce51() {
  level.driver = ai::array_spawn("driver")[0];
  level.driver.var_c681e4c1 = 1;
  level.arash = ai::array_spawn("arash")[0];
  level.arash.var_c681e4c1 = 1;
  level.af_enemy1 = ai::array_spawn("af_enemy1")[0];
  level.af_enemy1.var_c681e4c1 = 1;
  level.af_enemy2 = ai::array_spawn("af_enemy2")[0];
  level.af_enemy2.var_c681e4c1 = 1;
  level.af_enemy3 = ai::array_spawn("af_enemy3")[0];
  level.af_enemy3.var_c681e4c1 = 1;
  level.af_enemy4 = ai::array_spawn("af_enemy4")[0];
  level.af_enemy4.var_c681e4c1 = 1;
  weapon = getweapon(#"hash_7b2fff6ff4ea2c93");
  level.arash aiutility::setprimaryweapon(weapon);
  level.arash ai::gun_switchto(weapon, "right");
}

function function_78bc26d5() {
  self vehicle::lights_on();
  self vehicle::toggle_force_driver_taillights(1);
  level.var_e2e0716f = self;
}

function function_8c5e0f4f() {
  level thread namespace_4ed3ce47::function_f526df02();
  wait 1;
  level util::create_streamer_hint((19, -597, 46), (-10, -77, -2), 1, 1000);
  level function_55851873(#"hash_6ebae1c8430f4e3d");
  level thread scene::play(level.str_scene_name, "dt_03_waiting_idle", level.var_58ccee4);
  level thread namespace_31c67f6d::pstfx_teleport(2.25, 1, 1, 1);
  wait 0.25;
}

function function_3c0e1eab() {
  wait 2;
  level.adler.var_eae6f6e1 = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_eae6f6e1 dialog_tree::add_option(#"hash_72bc6a5ab99e461d", undefined, "dt_3ab", "character_creation", 1, undefined, undefined, &function_1af4ad41);
  level.adler.var_eae6f6e1 dialog_tree::add_option(#"hash_72b8825ab99a860e", undefined, "dt_3ab", "character_creation", 1, undefined, undefined, &function_1af4ad41);
  level dialog_tree::function_21780fc5(level.adler.var_eae6f6e1, array(240, 650));
  level.adler.var_eae6f6e1 dialog_tree::run(level.adler);
}

function function_1af4ad41() {
  level waittill(#"hash_77c12f83fb0438ea");
  level thread namespace_31c67f6d::pstfx_teleport(0.25, 1, 1, undefined, 1);
}

function function_b96d7941() {
  wait 1;
  level.player thread namespace_70eba6e6::function_5a4cb86d(0, 0);
  wait 0.25;
  function_80996e77();
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, undefined, 1);
  wait 1;
  level notify(#"personnel_profile_closed");
}

function function_80996e77() {
  level.adler dialogue::queue("vox_cp_sh8_00010_adlr_weneededtogivey_ee");
  wait 1;
  level.adler util::dialog_faction_vo("vox_cp_sh8_00010_adlr_simsandibothwan_44", "vox_cp_sh8_00010_adlr_itwasparksideat_fd", "vox_cp_sh8_00010_adlr_hudsonthoughtwe_d6", "vox_cp_sh8_00010_adlr_intheendnospeci_e0");
  wait 1;
}

function function_4f7ea045() {
  level thread scene::play(level.str_scene_name, "dt_04_waiting_idle", level.var_58ccee4);
  level thread function_4af4a400();
  level function_55851873(#"hash_79f67753e1008c25");
  level thread namespace_31c67f6d::pstfx_teleport(0.25, 1, 1, 1);
  level.player val::set("safehouse", "freezecontrols_allowlook", 1);
}

function function_4af4a400() {
  level.adler dialogue::queue("vox_cp_sh8_00010_adlr_andwewereableto_cd");
}

function function_40dc24e2() {
  thread function_d8f4275c();
  level waittill(#"hash_77c12f83fb0438ea");
}

function function_d8f4275c() {
  level scene::play(level.str_scene_name, "mind_control_explanation", level.var_58ccee4);
  level thread scene::play(level.str_scene_name, "dt_04_waiting_idle", level.var_58ccee4);
}

function function_af645aa() {
  level thread namespace_4ed3ce47::function_3f60bc38();
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, undefined, 1);
  wait 0.25;
  wait 1;
  level thread scene::play(level.str_scene_name, "dt_04_waiting_idle", level.var_58ccee4);
  level function_55851873(#"hash_567390b2aed44f14");
  level thread namespace_31c67f6d::pstfx_teleport(0.25, 1, 1, 1);
  wait 0.25;
}

function function_49bbba06() {
  level thread namespace_4ed3ce47::function_4825c155();
  wait 2;
  level.adler.var_d924535c = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_d924535c dialog_tree::add_option(#"hash_4543be1afb05e83a", undefined, "dt_4a", "dt_04_waiting_idle");
  level.adler.var_d924535c dialog_tree::add_option(#"hash_4546a61afb07f549", undefined, "dt_4b", "dt_04_waiting_idle");
  level.adler.var_d924535c.var_2fad984e = level.adler.var_d924535c dialog_tree::add_option(#"hash_454a8a1afb0bae8c", undefined, "dt_4c", "dt_05_waiting_idle", 1);
  level dialog_tree::function_21780fc5(level.adler.var_d924535c, array(240, 650));
  level.adler.var_d924535c dialog_tree::run(level.adler);
}

function function_96eb5464() {
  level thread scene::play(level.str_scene_name, "dt_05_waiting_idle", level.var_58ccee4);
  level.adler.var_5900d313 = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_5900d313 dialog_tree::add_option(#"hash_454a8d1afb0bb3a5", undefined, "dt_5a", "dt_05_waiting_idle", 1, undefined, undefined, &function_495d14d2);
  level.adler.var_5900d313 dialog_tree::add_option(#"hash_4532821afaf70f13", undefined, "dt_5b", "dt_05_waiting_idle", 1, undefined, undefined, &function_495d14d2);
  level dialog_tree::function_21780fc5(level.adler.var_5900d313, array(240, 650));
  level.adler.var_5900d313 dialog_tree::run(level.adler);
}

function function_495d14d2() {
  level waittill(#"hash_77c12f83fb0438ea");
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, undefined, 1);
  wait 1;
  level.adler scene::stop();
}

function function_47f7d061() {
  wait 0.25;
  level function_55851873(#"hash_414a0ea2bb7b7c1a");
  level thread namespace_31c67f6d::pstfx_teleport(0.5, 1, 1, 1);
  wait 0.05;
}

function function_558f09c7() {}

function function_8c6c6957() {
  thread function_a5852747();
  level waittill(#"hash_77c12f83fb0438ea");
  level thread namespace_4ed3ce47::function_85d1dd20();
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, undefined, 1);
  wait 0.25;
  wait 1;
  level function_55851873(#"hash_6c55001895364f06");
  level thread namespace_31c67f6d::pstfx_teleport(0.25, 1, 1, 1);
  wait 0.05;
}

function function_a5852747() {
  level scene::play(level.str_scene_name, "red_door_explanation", level.var_58ccee4);
  level thread namespace_4ed3ce47::function_32eb5fd4();
}

function function_855165f7() {
  thread function_ab7cf798();
  level waittill(#"hash_77c12f83fb0438ea");
  level thread namespace_31c67f6d::pstfx_teleport("white_screen_over", 1, 1, undefined, 1);
  wait 0.25;
  wait 1;
  level thread namespace_4ed3ce47::function_d73cc011();
  level function_55851873(#"hash_62923ce4f14e135");
  level thread namespace_31c67f6d::pstfx_teleport(0.25, 1, 1, 1);
}

function function_d1620daa() {}

function function_ab7cf798() {
  level scene::play(level.str_scene_name, "adlers_plea", level.var_58ccee4);
  level thread scene::play(level.str_scene_name, "dt_06_waiting_idle", level.var_58ccee4);
  level flag::set("adler_done_with_plea");
}

function function_a53df109() {
  level thread namespace_4ed3ce47::function_7aef4705();
  level flag::wait_till("adler_done_with_plea");
  level scene::play(level.str_scene_name, "dt_06_enter", level.var_58ccee4);
  level thread scene::play(level.str_scene_name, "dt_06_waiting_idle", level.var_58ccee4);
  var_b688fbdc = struct::get("hint_projector_remote", "targetname");
  level.var_5538ea31 = util::spawn_model("tag_origin", var_b688fbdc.origin, var_b688fbdc.angles);
  level thread function_688ad7f0();
  level.adler.var_37378f81 = dialog_tree::new_tree(undefined, undefined, 1, 1, level.str_scene_name);
  level.adler.var_37378f81 dialog_tree::add_option(#"hash_52b14f9f73548cd5", undefined, undefined, undefined, 1, undefined, "forever", &function_46d26798);
  level.adler.var_37378f81 dialog_tree::add_option(#"hash_6bbcd96077b1429a", undefined, undefined, undefined, 1, undefined, "forever", &function_f1eacff2);
  level dialog_tree::function_21780fc5(level.adler.var_37378f81, array(240, 650));
  level.adler.var_37378f81 dialog_tree::run(level.adler);
}

function function_688ad7f0() {
  level endon(#"hash_7c4cadf8854821e0");
  level.player thread dialogue::radio("vox_cp_sh8_00010_pers_fromthesafetyof_d1_1", undefined, 1);
  wait 4;
  level.player thread dialogue::radio("vox_cp_sh8_00010_pers_solovetsky_fb", undefined, 1);
}

function function_46d26798() {
  level notify(#"hash_7c4cadf8854821e0");
  level scene::play(level.str_scene_name, "dt_6a", level.var_58ccee4);
  level thread function_5662c89e("str_truth");
  wait 17;
  level flag::set("flag_post_prisoner_truth");
  player_decision::function_8c0836dd(0);
}

function function_f1eacff2() {
  level notify(#"hash_7c4cadf8854821e0");
  level scene::play(level.str_scene_name, "dt_6b", level.var_58ccee4);
  level thread function_5662c89e("str_lie");
  level.adler thread entname::add(#"hash_7edabf22111a04da", #"axis");
  level.adler setteam(#"axis");
  level.sims thread entname::add(#"hash_726674254495739e", #"axis");
  level.sims setteam(#"axis");

  if(isDefined(level.lazar)) {
    level.lazar thread entname::add(#"hash_6a46f5c74f586cb6", #"axis");
    level.lazar setteam(#"axis");
  }

  if(isDefined(level.park)) {
    level.park thread entname::add(#"hash_a0d642b09afc71a", #"axis");
    level.park setteam(#"axis");
  }

  wait 14;
  level flag::set("flag_post_prisoner_lie");
  player_decision::function_8c0836dd(1);
}

function function_5662c89e(str_state) {
  level thread function_f2c15144(str_state);
  level thread function_3606874a();
  level scene::play(level.str_scene_name, "dt_06_exit", level.var_58ccee4);
  level thread scene::play(level.str_scene_name, "zone_idle", level.var_58ccee4);
}

function function_f2c15144(str_state) {
  if(str_state == "str_lie") {
    level waittill(#"hash_4d17a18e02811363");
    playsoundatposition("vox_cp_sh8_00010_adlr_simsgetwashingt_5a_1", level.adler gettagorigin("j_neck"));
    level waittill(#"hash_2c4c87e30305fbaa");
    playsoundatposition("vox_cp_sh8_00010_adlr_youmadetheright_ea_1", level.adler gettagorigin("j_neck"));
    return;
  }

  level waittill(#"hash_4d17a18e02811363");
  playsoundatposition("vox_cp_sh8_00010_adlr_simsgetwashingt_5a", level.adler gettagorigin("j_neck"));
  level waittill(#"hash_2c4c87e30305fbaa");
  playsoundatposition("vox_cp_sh8_00010_adlr_youmadetheright_ea", level.adler gettagorigin("j_neck"));
}

function function_3606874a() {
  level waittill(#"hash_53021dd99bc5b45e");
  level.adler dialogue::queue("vox_cp_sh8_00020_adlr_adler_16");
  wait 3;
  level.adler dialogue::queue("vox_cp_sh8_00020_adlr_right_2c");
  wait 3;
  level.adler dialogue::queue("Vox_cp_sh8_00020_adlr_yeah_c6");
  wait 5;
  level.adler dialogue::queue("Vox_cp_sh8_00020_adlr_wellleavewithin_dc");
  wait 5;
  level.adler dialogue::queue("Vox_cp_sh8_00020_adlr_wewontletthepre_39");
}

function function_dbf5481b() {
  level thread namespace_4ed3ce47::function_dd79396d();
  level thread namespace_4ed3ce47::function_d3856f8a();
}

function function_49369331() {
  level thread namespace_4ed3ce47::function_849d7772();
  level thread namespace_4ed3ce47::function_7f23d560();
  level thread namespace_4ed3ce47::function_ef8c9b18();
}

function function_c649acda(var_d3440450) {
  level thread scene::play(level.str_scene_name, "zone_idle", level.var_58ccee4);
  level thread exploder::exploder("exp_post_armada_lazar_workbench");
  level thread namespace_31c67f6d::function_b0558ba2("8");
  level flag::set("flag_post_prisoner_lie");
}

function function_55851873(str_scene_name) {
  level lui::play_movie(str_scene_name, "fullscreen", 0, 0);
  level notify(#"white_screen_over");
}

function function_6be7ec40(var_d3440450) {
  level thread scene::play(level.str_scene_name, "zone_idle", level.var_58ccee4);
  level thread exploder::exploder("exp_post_armada_lazar_workbench");
  level thread namespace_31c67f6d::function_b0558ba2("8");
  level flag::set("flag_post_prisoner_truth");
}

function function_82c37b22(var_d3440450, var_50cc0d4f) {
  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    waitframe(1);
  }

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }

  level function_d6d3bd92();

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_d6d3bd92() {
  if(level flag::get("flag_post_prisoner_truth")) {
    wait 5;
    skipto::function_1c2dfc20("cp_rus_siege");
    return;
  }

  if(level flag::get("flag_post_prisoner_lie")) {
    level thread savegame::function_7790f03();
    level thread namespace_4ed3ce47::function_e25181b5();
    level.player enableweapons();
    level.player playgestureviewmodel("dem_lowreadyup");
    level.player val::set("safehouse", "freezecontrols_allowlook", 0);
    level.player val::set("safehouse", "allow_jump", 1);
    wait 3;
    level thread function_af3dcba6();
    wait 7;
    level thread function_2a020b14();
    level flag::wait_till_all_timeout(30, array("flag_post_prisoner_radio"));

    if(level flag::get("flag_post_prisoner_radio")) {
      wait 5;
    }

    skipto::function_1c2dfc20("cp_rus_duga");
  }
}

function function_af3dcba6() {
  level.player notify(#"combination_correct");
  level thread scene::play("scene_hub_env_chain_link_gate");
  gate_clip = getent("chain_link_gate_clip", "targetname");

  if(isDefined(gate_clip)) {
    gate_clip delete();
  }

  struct = struct::get("struct_obj_radio", "targetname");
  objectives::function_4eb5c04a("radio_objective", struct.origin + (0, 0, 8), #"hash_6d27d69a4d24a684", 1, undefined, #"hash_5099fd7b8025bec5");
  objectives::function_6a43edf3("radio_objective");
  objectives_ui::function_49dec5b("radio_objective", undefined, #"hash_696adfeed5b67f39");
  waitframe(1);
  e_tag = spawn("script_model", struct.origin);
  e_tag setModel("tag_origin");
  level thread function_cb6a2e9b();

  while(true) {
    if(level flag::get("flag_post_prisoner_radio")) {
      return;
    }

    e_tag util::create_cursor_hint("tag_origin", (0, 0, 8), #"hash_696adfeed5b67f39");
    level thread function_b93309a5(e_tag, "radio_objective");
    e_tag waittill(#"trigger");
    level.player playrumbleonentity("damage_light");
    level.player val::set("safehouse_dt", "freezecontrols", 1);
    level.player val::set("safehouse_dt", "allow_crouch", 0);
    level.player val::set("safehouse_dt", "allow_prone", 0);
    level.player val::set("safehouse_dt", "allow_stand", 1);
    s_tag = dialog_tree::new_tree(undefined, undefined, 1, 1);
    s_tag dialog_tree::add_option(#"hash_55ea9de6f02d4ad8", undefined, undefined, undefined, 1, undefined, undefined, &function_8bd27331, e_tag);
    s_tag dialog_tree::add_option(#"hash_6dac763351e3c08c", undefined, undefined, undefined, 1);
    s_tag dialog_tree::run(s_tag);
    wait 1;
    level.player val::set("safehouse_dt", "freezecontrols", 0);
    level.player val::set("safehouse_dt", "allow_crouch", 1);
    level.player val::set("safehouse_dt", "allow_prone", 1);
    level.player val::set("safehouse_dt", "allow_stand", 1);
  }
}

function function_8bd27331(e_tag) {
  level notify(#"kill_timer");
  namespace_4ed3ce47::function_8bd27331();
  playsoundatposition("vox_cp_sh8_00010_rms1_yessir_1e", e_tag.origin);
  objectives::complete("radio_objective");
  level.player player_decision::function_cde4f4e9(1);
  player_decision::function_8c0836dd(2);
  waitframe(1);
  level flag::set("flag_post_prisoner_radio");
  wait 1;
  level.player val::set("safehouse_dt", "freezecontrols", 0);
  level.player val::set("safehouse_dt", "allow_crouch", 1);
  level.player val::set("safehouse_dt", "allow_prone", 1);
  level.player val::set("safehouse_dt", "allow_stand", 1);
}

function function_b93309a5(e_tag, str_objective) {
  e_tag endon(#"trigger");

  while(true) {
    var_9da15859 = distance2dsquared(e_tag.origin, level.player.origin);

    if(var_9da15859 <= 57600) {
      objectives::hide(str_objective);

      while(true) {
        var_9da15859 = distance2dsquared(e_tag.origin, level.player.origin);

        if(var_9da15859 > 57600) {
          objectives::show(str_objective);
          break;
        }

        waitframe(1);
      }
    }

    waitframe(1);
  }
}

function function_2a020b14() {
  collision = getent("gurney_collision", "targetname");
  collision show();
}

function function_c21e258e() {
  level.player player_decision::function_cde4f4e9(0);
}

function function_fb10b77d(var_d3440450) {}

function function_cbf93ca7(var_d3440450, var_50cc0d4f) {
  level thread namespace_31c67f6d::function_f2cd5fc0();
  level namespace_31c67f6d::function_1f4ed1b4("dev_burn_safehouse");
  level scene::init("scene_hub_safehouse_burns");
  level thread function_49369331();
  level thread namespace_31c67f6d::function_b0558ba2("1");

  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    waitframe(1);
  }

  wait 3;
  level.player stopgestureviewmodel();

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }

  setlightingstate(1);
  level.var_3b87c282 = getDvar(#"hash_7b06b8037c26b99b");
  setDvar(#"hash_7b06b8037c26b99b", 255);
  animation::add_notetrack_func("hub_post_prisoner::burn_pstfx", &function_95b1e0d9);
  thread function_374843a();
  thread function_62a6be7();
  scene::play("scene_hub_safehouse_burns");
  setDvar(#"hash_7b06b8037c26b99b", level.var_3b87c282);
  level waittill(#"forever");
}

function function_95b1e0d9(player) {
  level.player clientfield::set_to_player("clf_pstfx_burn_safehouse", 1);
}

function function_374843a() {
  level waittill(#"hash_32de83776213afe5");
  namespace_4ed3ce47::function_89070bfe();
}

function function_62a6be7() {
  level waittill(#"hash_50e95b22fb132786");
  namespace_4ed3ce47::function_8d5b23ae();
}

function function_6bb0fd28(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_cb6a2e9b() {
  wait 7;
  level thread namespace_ae270045::function_cfcd9b92(30, #"hash_1f7c6dd82a346f10");
  level waittill(#"hash_56a61cb4fe8b8e79");
  level flag::set("mission_timer_fail");
}