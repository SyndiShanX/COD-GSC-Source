/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_ally.gsc
*****************************************************/

ally_start() {
  setsaveddvar("ammoCounterHide", "1");
  thread airlock_interior_hatch();
  thread close_exterior_hatch();
  thread maps\odin_audio::sfx_enemy_nodes();
  maps\odin_util::move_player_to_start_point("start_odin_ally");
  thread maps\odin_escape::manage_earth("hide");
  thread maps\odin_anim::empty_suit_animation();
  level.ally maps\_utility::gun_remove();
  level.ally.animname = "odin_ally";
  level.player disableweapons();
  common_scripts\utility::flag_set("player_approaching_infiltration");
  common_scripts\utility::flag_set("invasion_clear");
  thread maps\odin_fx::satellite_rcs_thrusters();
  maps\odin_util::actor_teleport(level.ally, "odin_ally_tp");
  thread maps\odin_intro::tweak_off_axis_player();
  common_scripts\utility::flag_set("clear_to_tweak_player");
  thread odin_invasion_scene();
}

section_precache() {
  precacherumble("heavy_1s");
  precacherumble("light_1s");
  precacherumble("smg_fire");
  precachemodel("head_fed_space_head_c");
  precachemodel("body_fed_space_assault_b");
  precachemodel("body_fed_space_assault_a");
  precachestring(&"PLATFORM_ODIN_STRUGGLE_FAIL");
  precachestring(&"PLATFORM_ODIN_STRUGGLE_FAIL_ALT");
  precachestring(&"ODIN_STRUGGLE_FAIL_PC");
}

section_flag_init() {
  common_scripts\utility::flag_init("ally_clear");
  common_scripts\utility::flag_init("play_invader_scene");
  common_scripts\utility::flag_init("invader_scene_begin");
  common_scripts\utility::flag_init("open_airlock_door");
  common_scripts\utility::flag_init("start_player_animating");
  common_scripts\utility::flag_init("prepare_anim_round_hatch");
  common_scripts\utility::flag_init("first_encounter_dialogue");
  common_scripts\utility::flag_init("ally_gun_struggle_FOV_change");
  common_scripts\utility::flag_init("stop_struggle_rotate");
  common_scripts\utility::flag_init("struggle_has_started");
  common_scripts\utility::flag_init("spin_player_and_enemy");
  common_scripts\utility::flag_init("player_shoot_anims");
  common_scripts\utility::flag_init("struggle_grunt");
  common_scripts\utility::flag_init("saved_ally");
  common_scripts\utility::flag_init("teleport_player_to_z_trans");
  common_scripts\utility::flag_init("player_second_z_turn");
  common_scripts\utility::flag_init("kyra_ally_vo_01");
  common_scripts\utility::flag_init("ally_out_of_z");
  common_scripts\utility::flag_init("post_z_push_cancel");
  common_scripts\utility::flag_init("lock_post_z_room");
  common_scripts\utility::flag_init("unlock_post_z_room");
  common_scripts\utility::flag_init("lock_first_z_trans_door");
  common_scripts\utility::flag_init("unlock_first_z_trans_door");
  common_scripts\utility::flag_init("open_post_infil_door");
  common_scripts\utility::flag_init("open_enemy_door");
  common_scripts\utility::flag_init("lock_z_hall_close_door");
  common_scripts\utility::flag_init("unlock_z_hall_close_door");
  common_scripts\utility::flag_init("lock_post_infil_auto_door");
  common_scripts\utility::flag_init("unlock_post_infil_auto_door");
  common_scripts\utility::flag_init("lock_escape_door_blocker");
  common_scripts\utility::flag_init("unlock_escape_door_blocker");
  common_scripts\utility::flag_init("switched_sticks");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("ally_struggle_fail", &"PLATFORM_ODIN_STRUGGLE_FAIL", ::odin_struggle_fail_hint);
  maps\_utility::add_hint_string("ally_struggle_fail_alt", &"PLATFORM_ODIN_STRUGGLE_FAIL_ALT", ::odin_struggle_fail_hint);
  maps\_utility::add_hint_string("ally_struggle_fail_PC", &"ODIN_STRUGGLE_FAIL_PC", ::odin_struggle_fail_hint);
}

odin_struggle_fail_hint() {
  if(common_scripts\utility::flag("saved_ally") || common_scripts\utility::flag("switched_sticks"))
    return 1;
  else
    return 0;
}

ally_main() {
  common_scripts\utility::flag_set("unlock_post_infil_auto_door");
  common_scripts\utility::flag_set("unlock_escape_door_blocker");
  level.ally pushplayer(1);
  thread ally_cleanup(0);
  maps\_utility::autosave_by_name("ally_begin");
  thread ally_setup();
  thread ally_dialogue();
  level.ally ally_invasion_scene_approach();
  hallway_encounter();
  thread maps\odin_escape::escape_setup();
  common_scripts\utility::flag_wait("ally_clear");
}

ally_setup() {
  setsaveddvar("ragdoll_max_life", 90000);
  thread maps\odin_util::create_sliding_space_door("first_z_trans_door_to_close", 1, 0, 0, 0, "lock_first_z_trans_door", "unlock_first_z_trans_door");
  thread maps\odin_util::create_sliding_space_door("z_hall_close_door", 1, 0, 0, 0, "lock_z_hall_close_door", "unlock_z_hall_close_door");
  thread maps\odin_util::create_sliding_space_door("post_infil_auto_door", 1, 0, 0, 0, "lock_post_infil_auto_door", "unlock_post_infil_auto_door");
  thread maps\odin_util::create_sliding_space_door("escape_door_blocker", 1, 0, 0, 0, "lock_escape_door_blocker", "unlock_escape_door_blocker");
  thread maps\odin_escape::create_escape_doors();
}

ally_dialogue() {
  common_scripts\utility::flag_wait("player_approaching_infiltration");
  common_scripts\utility::flag_wait("play_invader_scene");
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  common_scripts\utility::flag_wait("player_at_airlock");
  common_scripts\utility::flag_set("invader_scene_begin");
  maps\_utility::radio_dialogue_stop();
  maps\_utility::delaythread(3.0, maps\_utility::radio_dialogue_stop);
  maps\_utility::smart_radio_dialogue("odin_pyl_translatedmovein");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("odin_cub_emergencyfoothold");
  maps\_utility::smart_radio_dialogue("odin_cub_federationsoldiersonthe");
  common_scripts\utility::flag_set("objective_shutdown_sat");
  maps\_utility::smart_radio_dialogue("odin_atl_odinmainthisis");
  common_scripts\utility::flag_set("invasion_clear");
  maps\_utility::smart_radio_dialogue("odin_cub_atlasmainrepeatthey");

  if(!common_scripts\utility::flag("first_encounter_dialogue"))
    maps\_utility::smart_radio_dialogue("odin_kyr_weneedtomove");

  if(!common_scripts\utility::flag("first_encounter_dialogue"))
    thread maps\_utility::smart_radio_dialogue("odin_red_galleytoodincontrol");

  common_scripts\utility::flag_wait("first_encounter_dialogue");
  maps\_utility::smart_radio_dialogue("odin_kyr_argh");
  level.play_npc_deaths = 1;
  maps\_utility::smart_radio_dialogue("odin_kyr_lookout");
  common_scripts\utility::flag_wait("struggle_has_started");
  wait 0.025;
  level.struggle_guy thread maps\_anim::anim_single_solo(level.struggle_guy, "odin_pyl_translatednostopno");
  wait 3.1;
  common_scripts\utility::flag_wait("saved_ally");
  wait 1.0;
  maps\_utility::smart_radio_dialogue("odin_ast1_houstontheyrefederation");
  thread maps\odin_audio::sfx_odin_spinup();
  maps\_utility::smart_radio_dialogue("odin_shq_odincontrolodinis");
  level.fake_kyra maps\_space_ai::smart_radio_dialogue_facial("odin_kyr_weneedanopsstation", "odin_kyr_weneedanopsstation");
  maps\_utility::smart_radio_dialogue("odin_us2_odincontrolenemiesare");
}

squad_kill(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 kill();
  }
}

airlock_compression_door() {
  thread maps\odin_audio::sfx_pressurize_sound();
  wait 10;
  common_scripts\utility::flag_set("open_airlock_door");
  common_scripts\utility::flag_set("objective_return_to_station_complete");
}

odin_invasion_scene() {
  thread post_infil_door();
  thread invasion_door_anim();
  thread enemy_infiltration_door();
  var_0 = enemy_squad_spawn("intro_bad_guys_", 5, "intro_bad_guys_tp_");
  var_1 = getent("invasion_round_hatch", "targetname");
  var_2 = 1;

  foreach(var_4 in var_0) {
    var_4.ignoreall = 1;
    var_4.animname = "odin_invader_0" + var_2;
    var_4.diequietly = 1;
    var_4 maps\_utility::gun_remove();
    var_4 maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
    var_2 = var_2 + 1;
    level.ally_ent_del[level.ally_ent_del.size] = var_4;
    var_4 setModel("body_fed_space_assault_a");
  }

  var_6 = maps\odin_util::spawn_odin_actor_array("intro_room_victim", 1);
  var_2 = 1;

  foreach(var_8 in var_6) {
    var_8.animname = "odin_victim_0" + var_2;
    var_2 = var_2 + 1;
    var_8 maps\_utility::gun_remove();
    var_8.diequietly = 1;
    var_8.ignoreall = 1;
    var_8.dontevershoot = 1;
    var_8.nodeathimpulse = 1;
    level.ally_ent_del[level.ally_ent_del.size] = var_8;
  }

  var_0[3] hidepart("tag_silencer");
  var_6[0].name = "";
  var_6[2].name = "";
  var_10 = getent("intro_breach_origin", "targetname");
  var_11 = [];
  var_11["odin_invader_01"] = var_0[0];
  var_11["odin_invader_02"] = var_0[1];
  var_11["odin_invader_03"] = var_0[2];
  var_11["odin_invader_04"] = var_0[3];
  var_11["odin_invader_05"] = var_0[4];
  var_12 = [];
  var_12["odin_victim_01"] = var_6[0];
  var_12["odin_victim_03"] = var_6[2];
  var_10 maps\_anim::anim_first_frame(var_11, "odin_infiltrate");
  var_10 maps\_anim::anim_first_frame(var_12, "odin_infiltrate");
  var_10 thread maps\_anim::anim_loop(var_12, "odin_infiltrate_idle", "stop_infil_idle");
  var_10 thread maps\_anim::anim_loop_solo(var_6[1], "odin_infiltrate_idle", "stop_infil_idle_extra");
  common_scripts\utility::flag_wait("play_invader_scene");
  var_10 notify("stop_infil_idle_extra");
  thread idle_victim_logic(var_10, var_6[1]);
  common_scripts\utility::flag_wait("invader_scene_begin");
  level notify("stop_idle_logic");
  var_12["odin_victim_02"] = var_6[1];
  thread maps\odin_audio::sfx_odin_enemies();
  common_scripts\utility::flag_set("lock_post_infil_auto_door");
  common_scripts\utility::flag_set("no_push_zone");
  level.player allowsprint(0);
  thread maps\odin_audio::sfx_bg_fighting_line_emitter();
  var_10 notify("stop_infil_idle");
  var_10 notify("stop_infil_extra_idle");

  foreach(var_14 in var_12)
  thread victim_anim_and_death(var_10, var_14);

  var_10 maps\_anim::anim_single(var_11, "odin_infiltrate");

  foreach(var_4 in var_0)
  var_4 delete();

  common_scripts\utility::flag_wait("player_second_z_turn");

  foreach(var_8 in var_6) {
    if(isalive(var_8))
      var_8 kill();
  }
}

idle_victim_logic(var_0, var_1) {
  level endon("stop_idle_logic");
  var_2 = randomintrange(2, 5);
  var_1 thread maps\odin_util::dialogue_facial("odin_gs1_budgivemea", "odin_gs1_budgivemea");

  for(;;) {
    var_2 = randomintrange(2, 5);
    var_0 notify("stop_infil_idle_extra");
    var_0 thread maps\_anim::anim_loop_solo(var_1, "odin_infiltrate_wave", "stop_infil_idle_extra");
    wait 3;
    var_0 notify("stop_infil_idle_extra");
    var_0 thread maps\_anim::anim_loop_solo(var_1, "odin_infiltrate_idle", "stop_infil_idle_extra");
    wait(var_2);
  }
}

victim_anim_and_death(var_0, var_1) {
  var_0 thread maps\_anim::anim_single_solo(var_1, "odin_infiltrate");
  var_1 kill();
}

player_invasion_anims() {
  if(common_scripts\utility::flag("invasion_ok_to_anim_player")) {
    var_0 = maps\_utility::spawn_anim_model("player_rig");
    level.ally_ent_del[level.ally_ent_del.size] = var_0;
    var_1 = getent("anim_entrance_to_infiltrate", "script_noteworthy");
    var_0 hide();
    var_2 = [];
    var_2["player_rig"] = var_0;
    var_1 maps\_anim::anim_first_frame(var_2, "odin_infiltrate_player");
    var_3 = distance2d(level.player.origin, var_0.origin);
    thread player_link(var_0);
    wait 0.75;
    var_1 maps\_anim::anim_single(var_2, "odin_infiltrate_player");
    level.player unlink();
    var_0 delete();
    thread post_invasion_push_back();
    common_scripts\utility::flag_set("clear_to_tweak_player");
  }

  level.player allowsprint(1);
  wait 2;
}

ramp_down_push(var_0) {
  var_0 = var_0 * (3500, 1500, 0);
  var_1 = var_0[0];
  var_2 = var_0[1];

  for(;;) {
    var_1 = var_1 - 60;
    var_2 = var_2 - 60;

    if(var_1 < 0)
      var_1 = 0;

    if(var_2 < 0)
      var_2 = 0;

    setsaveddvar("player_swimSpeed", (var_1, var_2, 0));

    if(var_2 == 0 && var_1 == 0) {
      return;
    }
    wait 0.05;
  }
}

player_link(var_0) {
  var_1 = 20;
  maps\odin_util::view_control_lerp(20, (3225.28, 47453, 48493), (356.753, 210.604, 3.4468), 1.15, 1.15, 0, var_0);
  var_0 show();
}

post_invasion_push_back() {
  var_0 = getent("infil_push_back_point", "targetname");
  var_1 = var_0.origin[1];
  var_2 = 0;
  var_3 = 0;
  var_4 = 1500;
  setsaveddvar("player_swimWaterCurrent", (var_3, var_4, 0));

  while(var_2 == 0) {
    var_5 = level.player.origin[1];

    if(var_5 - var_1 >= -32)
      var_2 = 1;

    wait 0.05;
  }

  for(;;) {
    var_4 = var_4 - 50;
    var_3 = var_3 - 50;

    if(var_4 < 0)
      var_4 = 0;

    if(var_3 < 0)
      var_3 = 0;

    if(var_4 <= 0 && var_3 <= 0) {
      setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
      break;
    }

    setsaveddvar("player_swimWaterCurrent", (var_3, var_4, 0));
    wait 0.05;
  }
}

player_invasion_wipe_flag() {
  var_0 = getent("intro_breach_origin", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  wait 0.01;
  var_1.origin = level.player.origin - (0, 0, 40);
  var_1.angles = level.player.angles;
  wait 0.05;
  var_1 linktoplayerview(level.player, "tag_origin", (0, 0, -60), (0, 0, 0), 1);
  var_2 = [];
  var_2["player_rig"] = var_1;
  level.player maps\_anim::anim_single(var_2, "odin_infiltrate_player_wipe");
  var_1 unlink();
  var_1 delete();
}

ally_invasion_scene_approach() {
  level.ally pushplayer(1);
  var_0 = getent("anim_entrance_to_infiltrate", "script_noteworthy");
  var_0 notify("stop_loop");
  maps\_utility::delaythread(1, maps\odin_util::push_out_of_doorway, "X", "<", 1000, 1000);
  var_0 maps\_anim::anim_single_solo(self, "odin_infiltrate_kyra_to_door");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_infiltrate_kyra_door_idle", "stop_loop");
  common_scripts\utility::flag_wait("invader_scene_begin");
  var_0 notify("stop_loop");
  waittillframeend;
  level.ally maps\_utility::disable_ai_color();
  thread maps\odin_audio::sfx_kyra_hatch(level.ally);
  var_0 maps\_anim::anim_single_solo(self, "odin_infiltrate_kyra_start");
  thread player_invasion_anims();

  if(common_scripts\utility::flag("invasion_ok_to_anim_player"))
    var_0 maps\_anim::anim_single_solo(self, "odin_infiltrate_kyra");
  else
    var_0 maps\_anim::anim_single_solo(self, "odin_infiltrate_kyra_no_push");

  var_0 thread maps\_anim::anim_loop_solo(self, "odin_infiltrate_kyra_escape_idle", "stop_loop");
  thread maps\odin_util::finale_anim_loop_killer(var_0, "stop_loop");
  wait_for_player_approach(128);
  common_scripts\utility::flag_clear("no_push_zone");
  var_0 notify("stop_loop");
}

invasion_door_shut(var_0) {
  common_scripts\utility::flag_set("prepare_anim_round_hatch");
}

invasion_door_anim() {
  var_0 = getent("infil_main_door", "targetname");
  var_1 = getent("infil_main_door_org", "targetname");
  var_2 = getent("scriptednode_door", "targetname");
  var_3 = maps\_utility::spawn_anim_model("space_round_hatch");
  level.ally_ent_del[level.ally_ent_del.size] = var_3;
  var_2 maps\_anim::anim_first_frame_solo(var_3, "odin_infiltrate_hatch");
  var_1 linkto(var_3, "door_DM");
  var_0 linkto(var_1);
  common_scripts\utility::flag_wait("prepare_anim_round_hatch");
  var_2 maps\_anim::anim_single_solo(var_3, "odin_infiltrate_hatch");
}

wait_for_player_approach(var_0) {
  for(;;) {
    var_1 = distance2d(level.player.origin, level.ally.origin);

    if(var_1 <= var_0) {
      return;
    }
    wait 0.01;
  }
}

shut_post_infil_door_flag(var_0) {
  common_scripts\utility::flag_set("open_post_infil_door");
  thread maps\odin_util::push_out_of_doorway("y", "<", 1500, 1500);
}

post_infil_door() {
  var_0 = getent("scriptednode_door", "targetname");
  var_1 = maps\_utility::spawn_anim_model("space_square_hatch");
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_2 = getent("post_infil_struggle_clip", "targetname");
  var_3 = getent("post_infil_struggle_clip_origin", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_infiltrate_escape_door");
  var_3 linkto(var_1, "tag_origin");
  var_2 linkto(var_3);
  common_scripts\utility::flag_wait("open_post_infil_door");
  thread maps\odin_audio::sfx_post_infil_door();
  var_0 maps\_anim::anim_single_solo(var_1, "odin_infiltrate_escape_door");
}

open_enemy_infiltration_door_flag(var_0) {
  common_scripts\utility::flag_set("open_enemy_door");
}

enemy_infiltration_door() {
  var_0 = getent("scriptednode_door", "targetname");
  var_1 = maps\_utility::spawn_anim_model("space_square_hatch");
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_infiltrate_enemy_door");
  common_scripts\utility::flag_wait("open_enemy_door");
  thread maps\odin_audio::sfx_infiltrator_door();
  var_0 maps\_anim::anim_single_solo(var_1, "odin_infiltrate_enemy_door");
}

hallway_encounter() {
  level endon("struggle_end");
  var_0 = maps\_utility::spawn_anim_model("odin_opfor");
  level.struggle_guy = var_0;
  level.ally_ent_del[level.ally_ent_del.size] = var_0;
  var_0 setModel("body_fed_space_assault_b");
  var_1 = getent("struggle_enemy_head", "targetname");
  var_2 = getent("struggle_enemy_inner_head", "targetname");
  var_3 = var_0 gettagorigin("J_Spine4");
  var_4 = var_0 gettagangles("J_Spine4");
  var_1.origin = var_3;
  var_1.angles = var_4;
  var_2.origin = var_3;
  var_2.angles = var_4;
  var_1 linkto(var_0, "J_Spine4");
  var_0 attach("head_fed_space_head_c", "", 1);
  var_2 linkto(var_0, "J_Spine4");
  var_1 hide();
  var_2 hide();
  var_5 = getent("struggle_gun", "targetname");
  var_6 = getent("struggle_dummygun", "targetname");
  var_6 linkto(var_5);
  var_6 attach("weapon_acog_iw6", "tag_acog_2", 1);
  var_5.origin = var_0 gettagorigin("tag_weapon_right");
  var_5.angles = var_0 gettagangles("tag_weapon_right");
  var_5 linkto(var_0, "tag_weapon_right");
  playFXOnTag(level._effect["flashlight"], var_6, "tag_flash");
  level.player thread maps\odin_util::struggle_flashlight(var_5);
  var_5 hide();
  level.ally.ignoreall = 1;
  level.ally pushplayer(1);
  var_7 = maps\_utility::spawn_anim_model("player_rig");
  level.ally_ent_del[level.ally_ent_del.size] = var_7;
  var_7 hide();
  thread struggle_rotate(var_0, var_7);
  var_8 = getent("gun_struggle_intro", "targetname");
  level.ally.animname = "odin_ally";
  var_0.animname = "odin_opfor";
  var_9 = [];
  var_9["odin_ally"] = level.ally;
  var_9["odin_opfor"] = var_0;
  var_8 maps\_anim::anim_single(var_9, "gun_struggle_intro");
  var_8 thread maps\_anim::anim_loop_solo(level.ally, "gun_struggle_intro_loop", "end_loops");
  thread maps\odin_util::finale_anim_loop_killer(var_8, "end_loops");
  var_8 thread maps\_anim::anim_loop_solo(var_0, "gun_struggle_intro_loop", "end_loops");
  common_scripts\utility::flag_wait("gun_struggle_commence_trig");
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  level.player allowsprint(0);
  common_scripts\utility::flag_set("first_encounter_dialogue");
  var_8 notify("time_to_toss");
  var_9 = [];
  var_9["odin_ally"] = level.ally;
  var_9["odin_opfor"] = var_0;
  var_10 = [];
  var_10["player_rig"] = var_7;
  var_0 thread maps\odin_audio::sfx_ally_ally_grapple();
  var_8 maps\_anim::anim_first_frame(var_10, "gun_struggle_intro_throw");
  maps\_utility::autosave_by_name("space_shotgun");
  var_8 thread maps\_anim::anim_single(var_9, "gun_struggle_intro_throw");
  level.ally maps\_utility::disable_ai_color();
  common_scripts\utility::flag_wait("start_player_animating");
  level.player thread maps\odin_audio::sfx_ally_plr_grapple();
  var_11 = [];
  var_11["odin_opfor"] = var_0;
  var_12 = 0;
  level.player playerlinktoblend(var_7, "tag_player", 0.75, 0.4);
  wait 0.75;
  level.player playerlinktodelta(var_7, "tag_player", 1, 0, 0, 0, 0);
  var_7 show();
  var_8 notify("end_loops");
  common_scripts\utility::flag_set("ally_gun_struggle_FOV_change");
  var_8 maps\_anim::anim_single(var_10, "gun_struggle_intro_throw");
  var_5 show();
  var_6 hide();
  var_8 maps\_anim::anim_first_frame(var_10, "odin_hallway_weapon_struggle_range_player");
  var_8 maps\_anim::anim_first_frame(var_11, "odin_hallway_weapon_struggle_range_opfor");
  var_0 setanim(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_range_opfor"], 1, 0, 0);
  var_7 setanim(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_range_player"], 1, 0, 0);
  thread struggle_logic(var_7, var_0, level.ally);
  common_scripts\utility::flag_set("unlock_first_z_trans_door");
  common_scripts\utility::flag_set("unlock_z_hall_close_door");
}

start_struggle_spin(var_0) {
  common_scripts\utility::flag_set("spin_player_and_enemy");
}

set_player_anim_flag(var_0) {
  common_scripts\utility::flag_set("start_player_animating");
}

struggle_door_opens(var_0) {}

struggle_logic(var_0, var_1, var_2) {
  level endon("struggle_end");
  level.ally setgoalpos(level.ally.origin);
  level.player setCanDamage(0);
  thread struggle_grunts();
  var_3 = getent("struggle_gun", "targetname");
  var_4 = getent("struggle_gun_target", "targetname");
  var_5 = getent("acog_scope_struggle", "targetname");
  var_6 = 0.01;
  var_7 = 0;
  var_8 = 1;
  var_9 = "left";
  var_10 = 0;
  var_11 = 0.1;
  var_12 = var_11;
  var_13 = 0.4;
  level.struggle_anim_time = 0;
  var_8 = 2;
  var_14 = 1;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = (0, 0, 0);
  var_20 = 1;

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {} else {
    var_18 = 1;
    level.player enablemousesteer(1);
  }

  var_3 hidepart("tag_sight_on", "viewmodel_space_tar21");
  var_5.origin = var_3 gettagorigin("tag_acog_2");
  var_5.angles = var_3 gettagangles("tag_acog_2");
  var_5 linkto(var_3, "tag_acog_2");
  var_4 linkto(var_3);
  var_3.origin = var_0 gettagorigin("tag_weapon");
  var_3.angles = var_0 gettagangles("tag_weapon");
  var_3 linkto(var_0, "tag_weapon");
  common_scripts\utility::flag_set("struggle_has_started");
  level.sfx_plr_grapple_loop_playing = 0;
  level.player thread maps\odin_audio::sfx_ally_plr_grapple_loop_init();
  thread layering_logic(var_1, var_0);
  thread player_wins_struggle(var_1, var_0, var_2);
  thread space_shotgun_firing(var_1, var_0);
  thread give_player_struggle_hint();

  while(var_7 == 0) {
    var_21 = level.player getnormalizedcameramovement();

    if((var_21[1] > 0.15 || var_21[1] < -0.15) && var_20 == 1) {
      var_20 = 0;

      if(level.sfx_plr_grapple_playing == 0)
        level.player thread maps\odin_audio::sfx_ally_plr_grapple_ss();

      level.player thread maps\odin_audio::sfx_ally_plr_grapple_loop();
    } else if(var_21[1] < 0.15 && var_21[1] > -0.15) {
      var_20 = 1;
      level.player thread maps\odin_audio::sfx_ally_plr_grapple_stop();
    }

    if(var_18 == 1) {
      var_21 = var_21 * -1;

      if(var_21[1] >= 0.15 || var_21[1] <= -0.15)
        var_19 = var_21;
      else
        var_21 = var_19;
    }

    if(level.struggle_anim_time <= 0.2 || level.struggle_anim_time >= 0.7)
      var_8 = 2.6;

    if(level.struggle_anim_time > 0.2 && level.struggle_anim_time < 0.398 && var_21[1] > 0.15) {
      var_14 = 1;
      var_15 = 0;
      var_8 = 0.5;
      level.player playrumbleonentity("light_1s");
    }

    if(level.struggle_anim_time > 0.574 && level.struggle_anim_time < 0.7 && var_21[1] < -0.15) {
      var_14 = 0;
      var_15 = 1;
      var_8 = 0.5;
      level.player playrumbleonentity("light_1s");
    }

    if(level.struggle_anim_time > 0.4 && level.struggle_anim_time < 0.55 && var_14 == 1) {
      if(maps\_utility::getdifficulty() == "easy" || maps\_utility::getdifficulty() == "medium")
        var_8 = 1 - var_16;
      else
        var_8 = 3 - var_16;

      level.player playrumbleonentity("heavy_1s");
      common_scripts\utility::flag_set("struggle_grunt");
    }

    if(level.struggle_anim_time > 0.4 && level.struggle_anim_time < 0.55 && var_15 == 1) {
      if(maps\_utility::getdifficulty() == "easy" || maps\_utility::getdifficulty() == "medium")
        var_8 = 1 - var_16;
      else
        var_8 = 3 - var_16;

      level.player playrumbleonentity("heavy_1s");
    }

    if(level.struggle_anim_time > 0.4 && level.struggle_anim_time < 0.55) {
      if(level.struggle_anim_time > 0.47)
        level.struggle_anim_time = level.struggle_anim_time + (0.3 - var_16 * 0.1);
      else
        level.struggle_anim_time = level.struggle_anim_time - (0.3 - var_16 * 0.1);

      if(var_17 == 0) {
        var_17 = 1;

        if(var_16 <= 0.7)
          var_16 = var_16 + 0.3;
      }
    } else
      var_17 = 0;

    var_11 = var_21[1] * var_8;

    if(level.struggle_anim_time <= 0.4 && var_21[1] < 0.15)
      var_11 = -1.8;

    if(level.struggle_anim_time >= 0.55 && var_21[1] > -0.15)
      var_11 = 1.8;

    var_12 = var_12 + (var_11 - var_12) * var_13;
    thread enemy_struggle_anim(var_1, var_6, var_12);
    thread player_struggle_anim(var_0, var_6, var_12);
    wait(var_6);
    screenshake(level.player.origin, 0.25, 1, 0.1, 0.25);
  }
}

layering_logic(var_0, var_1) {
  level endon("struggle_end");
  wait 0.1;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0.1;

  for(;;) {
    var_8 = maps\_utility::round_float(level.struggle_anim_prog, 2, 0);

    if(var_8 <= 0.25) {
      var_2 = maps\odin_util::factor_value_min_max(-1, 0, maps\odin_util::normalize_value(0, 0.25, var_8));
      var_2 = maps\_utility::round_float(var_2, 2, 0);
      var_2 = var_2 * -1;
      thread enemy_struggle_anim_additives(var_0, var_2, 0, 0, var_7);
      thread player_struggle_anim_additives(var_1, var_2, 0, 0, var_7);
      var_3 = maps\odin_util::factor_value_min_max(0, 1, maps\odin_util::normalize_value(0, 0.25, var_8));
      var_3 = maps\_utility::round_float(var_3, 2, 0);
      thread enemy_struggle_mid_additives(var_0, var_3, 0, var_7);
      thread player_struggle_mid_additives(var_1, var_3, 0, var_7);
    }

    if(var_8 > 0.25 && var_8 < 0.5) {
      var_5 = maps\odin_util::factor_value_min_max(0, 1, maps\odin_util::normalize_value(0.25, 0.5, var_8));
      var_5 = maps\_utility::round_float(var_5, 2, 0);
      thread enemy_struggle_anim_additives(var_0, 0, 0, var_5, var_7);
      thread player_struggle_anim_additives(var_1, 0, 0, var_5, var_7);
      var_3 = maps\odin_util::factor_value_min_max(-1, 0, maps\odin_util::normalize_value(0.25, 0.5, var_8));
      var_3 = maps\_utility::round_float(var_3, 2, 0);
      var_3 = var_3 * -1;
      thread enemy_struggle_mid_additives(var_0, var_3, 0, var_7);
      thread player_struggle_mid_additives(var_1, var_3, 0, var_7);
    }

    if(var_8 > 0.5 && var_8 < 0.75) {
      var_5 = maps\odin_util::factor_value_min_max(-1, 0, maps\odin_util::normalize_value(0.5, 0.75, var_8));
      var_5 = var_5 * -1;
      var_5 = maps\_utility::round_float(var_5, 2, 0);
      thread enemy_struggle_anim_additives(var_0, 0, 0, var_5, var_7);
      thread player_struggle_anim_additives(var_1, 0, 0, var_5, var_7);
      var_4 = maps\odin_util::factor_value_min_max(0, 1, maps\odin_util::normalize_value(0.5, 0.75, var_8));
      var_4 = maps\_utility::round_float(var_4, 2, 0);
      thread enemy_struggle_mid_additives(var_0, 0, var_4, var_7);
      thread player_struggle_mid_additives(var_1, 0, var_4, var_7);
    }

    if(var_8 >= 0.75) {
      var_6 = maps\odin_util::factor_value_min_max(0, 1, maps\odin_util::normalize_value(0.75, 1, var_8));
      var_6 = maps\_utility::round_float(var_6, 2, 0);
      thread enemy_struggle_anim_additives(var_0, 0, var_6, 0, var_7);
      thread player_struggle_anim_additives(var_1, 0, var_6, 0, var_7);
      var_4 = maps\odin_util::factor_value_min_max(-1, 0, maps\odin_util::normalize_value(0.75, 1, var_8));
      var_4 = maps\_utility::round_float(var_4, 2, 0);
      var_4 = var_4 * -1;
      thread enemy_struggle_mid_additives(var_0, 0, var_4, var_7);
      thread player_struggle_mid_additives(var_1, 0, var_4, var_7);
    }

    wait 0.1;
  }
}

#using_animtree("generic_human");

enemy_struggle_mid_additives(var_0, var_1, var_2, var_3) {
  level endon("struggle_end");
  var_0 setanimlimited(%odin_struggle_left_add, var_1, var_3, 1);
  var_0 setanimlimited(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor_add"], 1, var_3, 0.65);
  var_0 setanimlimited(%odin_struggle_right_add, var_2, var_3, 1);
  var_0 setanimlimited(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor_add"], 1, var_3, 0.65);
}

#using_animtree("player");

player_struggle_mid_additives(var_0, var_1, var_2, var_3) {
  level endon("struggle_end");
  var_0 setanimlimited(%odin_struggle_left_add, var_1, var_3, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player_add"], 1, var_3, 0.65);
  var_0 setanimlimited(%odin_struggle_right_add, var_2, var_3, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player_add"], 1, var_3, 0.65);
}

#using_animtree("generic_human");

enemy_struggle_anim_additives(var_0, var_1, var_2, var_3, var_4) {
  level endon("struggle_end");
  var_0 setanimlimited(%odin_struggle_left, var_1, var_4, 1);
  var_0 setanimlimited(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor"], 1, var_4, 0.65);
  var_0 setanimlimited(%odin_struggle_center, var_3, var_4, 1);
  var_0 setanimlimited(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_center_opfor"], 1, var_4, 0.65);
  var_0 setanimlimited(%odin_struggle_right, var_2, var_4, 1);
  var_0 setanimlimited(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor"], 1, var_4, 0.65);
}

#using_animtree("player");

player_struggle_anim_additives(var_0, var_1, var_2, var_3, var_4) {
  level endon("struggle_end");
  var_0 setanimlimited(%odin_struggle_left, var_1, var_4, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player"], 1, var_4, 0.65);
  var_0 setanimlimited(%odin_struggle_center, var_3, var_4, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_center_player"], 1, var_4, 0.65);
  var_0 setanimlimited(%odin_struggle_right, var_2, var_4, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player"], 1, var_4, 0.65);
}

#using_animtree("generic_human");

enemy_struggle_anim(var_0, var_1, var_2) {
  level endon("struggle_end");
  var_0 setanim(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_range_opfor"], 1, var_1, var_2);
  level.struggle_anim_prog = var_0 getanimtime(%odin_hallway_weapon_struggle_range_opfor);
}

#using_animtree("player");

player_struggle_anim(var_0, var_1, var_2) {
  level endon("struggle_end");
  var_0 setanim(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_range_player"], 1, var_1, var_2);
  level.struggle_anim_time = var_0 getanimtime(%odin_hallway_weapon_struggle_range_player);
}

space_shotgun_firing(var_0, var_1) {
  level endon("struggle_end");
  var_2 = getent("struggle_gun", "targetname");
  var_3 = getent("struggle_gun_target", "targetname");
  var_3 linkto(var_2);
  var_4 = gettime();
  var_5 = var_4 - 500;
  var_6 = 0;
  var_7 = gettime() - 6000;
  var_8 = gettime();
  var_9 = 0;
  var_10 = 1;
  level.struggle_bullets = 32;

  for(;;) {
    var_7 = gettime() - 9000;

    if(level.player attackbuttonpressed() && var_10 == 1) {
      fire_space_microtar(var_2, var_3);
      var_4 = gettime();
      var_5 = var_4 - 500;
      var_6 = var_6 + 1;
      thread space_stuggle_enemy_death(var_0);
      thread struggle_shot_grunt();
    }

    if(level.player attackbuttonpressed(1))
      var_10 = 0;
    else
      var_10 = 1;

    if(var_7 >= var_8 || level.struggle_bullets <= 0) {
      thread player_failed_struggle(var_0, var_1);
      return;
    }

    wait 0.01;
  }
}

fire_space_microtar(var_0, var_1) {
  wait 0.05;

  for(var_2 = 0; var_2 < 3; var_2++) {
    magicbullet("microtar_space_interior", var_0 gettagorigin("tag_flash"), var_1.origin, level.player);
    level.player playSound("weap_tar21_fire_plr");
    level.player playrumbleonentity("smg_fire");
    playFXOnTag(common_scripts\utility::getfx("space_microtar_shot"), var_0, "tag_flash");
    level.struggle_bullets = level.struggle_bullets - 1;
    wait 0.05;
  }
}

player_failed_struggle(var_0, var_1) {
  level endon("ally_clear");
  level notify("struggle_end");
  common_scripts\utility::flag_set("stop_struggle_rotate");
  level.player thread maps\odin_audio::sfx_ally_plr_grapple_failed();
  var_2 = getent("struggle_rotate_hinge", "targetname");
  var_2 rotateto((0, 270, 0), 1.5);
  var_3 = [];
  var_3["odin_opfor"] = var_0;
  var_3["player_rig"] = var_1;

  foreach(var_5 in var_3)
  var_5 maps\_utility::anim_stopanimscripted();

  wait 0.01;
  thread fire_enemy_gun();
  var_2 thread maps\_anim::anim_single(var_3, "odin_hallway_weapon_struggle_fail");
  wait 1;
  level.player kill();
  common_scripts\utility::flag_set("mission_failed");
  maps\_utility::missionfailedwrapper();
}

give_player_struggle_hint() {
  level endon("ally_clear");
  wait 5;
  var_0 = getsticksconfig();

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy")
      level.player thread maps\_utility::display_hint("ally_struggle_fail_alt");
    else
      level.player thread maps\_utility::display_hint("ally_struggle_fail");
  } else
    level.player thread maps\_utility::display_hint("ally_struggle_fail_PC");

  thread check_for_layout_change_mid_hint(var_0);
}

check_for_layout_change_mid_hint(var_0) {
  while(!common_scripts\utility::flag("saved_ally")) {
    var_1 = getsticksconfig();

    if(var_1 != var_0) {
      common_scripts\utility::flag_set("switched_sticks");
      var_0 = var_1;
      wait 0.1;
      common_scripts\utility::flag_clear("switched_sticks");

      if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
        if(var_1 == "thumbstick_southpaw" || var_1 == "thumbstick_legacy")
          level.player thread maps\_utility::display_hint("ally_struggle_fail_alt");
        else
          level.player thread maps\_utility::display_hint("ally_struggle_fail");
      } else
        level.player thread maps\_utility::display_hint("ally_struggle_fail_PC");
    }

    wait 0.05;
  }
}

fire_enemy_gun() {
  level endon("ally_clear");
  var_0 = getent("struggle_gun", "targetname");
  level.player playSound("scn_odin_player_grapple_lost");
  wait 0.7;
  playFXOnTag(common_scripts\utility::getfx("spc_explosion_240"), var_0, "tag_flash");
  level.player playSound("weap_tar21_fire_plr");
}

space_stuggle_enemy_death(var_0) {
  level endon("ally_clear");
  var_1 = getent("struggle_enemy_head", "targetname");
  var_2 = getent("struggle_enemy_inner_head", "targetname");

  if(level.struggle_anim_time > 0.325 && level.struggle_anim_time < 0.635) {
    level notify("struggle_end");
    common_scripts\utility::flag_set("player_shoot_anims");
    common_scripts\utility::flag_set("stop_struggle_rotate");
    var_3 = getent("struggle_gun", "targetname");
    stopFXOnTag(common_scripts\utility::getfx("spc_explosion_240"), var_3, "tag_flash");
    playFXOnTag(level._effect["blood_impact_space"], var_2, "tag_eye");
    var_0 setModel(level.scr_model["odin_opfor"] + "_cracked");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("blood_impact_space"), var_2, "J_Spine4");
  }
}

struggle_guy_line(var_0) {
  level.struggle_guy maps\_utility::smart_radio_dialogue("odin_pyl_translatednostopno");
}

player_wins_struggle(var_0, var_1, var_2) {
  level endon("ally_clear");
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  common_scripts\utility::flag_wait("player_shoot_anims");
  common_scripts\utility::flag_set("saved_ally");
  var_0 maps\_utility::anim_stopanimscripted();
  maps\_utility::radio_dialogue_stop();
  thread maps\odin_audio::sfx_ally_plr_grapple_success();
  maps\_utility::radio_dialogue_stop();
  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_1A");
  thread struggle_succeed_slowmo();
  thread struggle_succeed_fx(var_0);
  thread z_trans(var_1, var_0, var_2);
  var_3 = getent("z_trans_hinge_a", "targetname");
  var_4 = maps\_utility::spawn_anim_model("player_rig");
  var_4 hide();
  var_3 maps\_anim::anim_first_frame_solo(var_4, "odin_hall_escape_turn01_player");
  thread push_enemy_down(var_0);
  var_1 setanimknob(%odin_hallway_weapon_struggle_shoot_player, 1, 0.05, 1);
  level.struggle_hinge rotateto((0, 270, 0), 1.25, 0, 1.25);
  wait 1.3;
  var_1 unlink();
  var_1 moveto((3323.92, 46696.8, 48483.7), 0.75, 0.75, 0);
  wait 0.8;
  var_5 = [];
  var_5["player_rig"] = var_1;
  thread maps\odin_audio::sfx_traversal_01();
  var_1 maps\_utility::anim_stopanimscripted();
  thread end_layered_anims(var_1);
  thread z_trans_player(var_1);
  var_3 thread maps\_anim::anim_single_solo(var_1, "odin_hall_escape_turn01_player");
  wait 2;
  common_scripts\utility::flag_set("teleport_player_to_z_trans");
  level.player allowsprint(1);
  level.player setCanDamage(1);
}

rotation_resetter(var_0) {
  for(;;) {
    iprintlnbold(var_0.angles);
    wait 0.1;
  }
}

#using_animtree("generic_human");

push_enemy_down(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_2 = getent("z_trans_hinge_a", "targetname");
  var_0 setanimknob(%odin_spin_struggling_enemy_01, 1, 0.5, 0.75);
  var_3 = common_scripts\utility::spawn_tag_origin();
  level.ally_ent_del[level.ally_ent_del.size] = var_3;
  var_4 = getent("struggle_rotate_hinge", "targetname");
  var_3.origin = var_4.origin;
  var_3.angles = level.player.angles;
  var_0 unlink();
  var_0 linkto(var_3);
  var_5 = level.player getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = anglesToForward(var_2.angles);
  var_8 = vectordot(var_6, var_7);

  if(var_8 >= 0) {
    if(var_0.origin[2] <= level.player.origin[2] + 10)
      var_3 rotatepitch(180, 7, 7, 0);
    else
      var_3 rotatepitch(-180, 4, 4, 0);
  }

  common_scripts\utility::flag_wait("teleport_player_to_z_trans");
  var_0 unlink();
  thread move_dead_enemy(var_0);
}

#using_animtree("player");

end_layered_anims(var_0) {
  var_0 setanimlimited(%odin_struggle_left, 0, 0.05, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player"], 0, 0.05, 65);
  var_0 setanimlimited(%odin_struggle_center, 0, 0.05, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_center_player"], 0, 0.05, 1);
  var_0 setanimlimited(%odin_struggle_right, 0, 0.05, 1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player"], 0, 0.05, 1);
}

#using_animtree("generic_human");

move_dead_enemy(var_0) {
  var_1 = var_0;
  var_2 = getent("z_trans_2_1_node", "targetname");
  wait 0.05;
  var_1.origin = var_2.origin - (0, -352, 0);
  var_1 setanimknob(%odin_spin_struggling_enemy_01, 1, 0.02, 0.05);
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_0.origin;
  var_0 linkto(var_3);
  var_3.angles = var_2.angles + (0, 90, 0);
  var_4 = randomfloatrange(300, 400);
  var_3 rotateby((-10, 10, 10), 60, 0, 0);
  var_3 movez(-15, 60, 0, 0);
}

struggle_succeed_fx(var_0) {
  level endon("ally_clear");
  var_1 = getent("struggle_enemy_head", "targetname");
  var_2 = getent("struggle_enemy_inner_head", "targetname");
  playFXOnTag(level._effect["odin_helmet_glass_shatter"], var_2, "tag_eye");
}

struggle_succeed_slowmo() {
  level endon("ally_clear");
  var_0 = 0.2;
  maps\_utility::slowmo_setspeed_slow(var_0);
  maps\_utility::slowmo_setlerptime_in(0.2);
  maps\_utility::slowmo_lerp_in();
  level.player setmovespeedscale(0.3);
  var_1 = 0.3;
  wait(var_1);
  maps\_utility::slowmo_setlerptime_out(1.65);
  maps\_utility::slowmo_lerp_out();
  maps\_utility::slowmo_end();
  level.player setmovespeedscale(1.0);
}

struggle_rotate(var_0, var_1) {
  level endon("struggle_end");
  level.struggle_hinge = common_scripts\utility::spawn_tag_origin();
  var_2 = 0;
  common_scripts\utility::flag_wait("spin_player_and_enemy");
  level.struggle_hinge.origin = var_1 gettagorigin("tag_player");
  level.struggle_hinge.angles = var_1 gettagangles("tag_player");
  level.struggle_hinge = getent("struggle_rotate_hinge", "targetname");
  var_0 linkto(level.struggle_hinge);
  var_1 linkto(level.struggle_hinge);
  level.struggle_hinge rotatepitch(-90, 1, 1, 0);
  wait 1;

  while(!common_scripts\utility::flag("saved_ally") && !common_scripts\utility::flag("stop_struggle_rotate")) {
    level.struggle_hinge rotatepitch(-5400, 60, 0, 0);
    wait 60;
  }

  var_3 = level.struggle_hinge.angles[2] / 360 * -1;

  while(var_2 == 0) {
    if(var_3 - 1 > 0) {
      var_3 = var_3 - 1;
      continue;
    }

    var_2 = 1;
  }
}

struggle_shot_grunt() {
  level endon("ally_clear");
  level endon("struggle_end");
}

struggle_grunts() {
  level endon("ally_clear");
  level endon("struggle_end");

  for(;;) {
    common_scripts\utility::flag_wait("struggle_grunt");
    wait(randomfloatrange(2, 4));
    common_scripts\utility::flag_clear("struggle_grunt");
  }
}

z_trans(var_0, var_1, var_2) {
  var_3 = getent("ally_doppleganger1", "targetname");
  var_2 = var_3 maps\_utility::spawn_ai();
  level.ally_ent_del[level.ally_ent_del.size] = var_2;
  level.fake_kyra = var_2;
  var_2 maps\_utility::gun_remove();
  var_2.ignoreall = 1;
  var_2.animname = "odin_ally";
  level.ally maps\_utility::disable_ai_color();
  var_4 = getent("z_trans_hinge_a", "targetname");
  var_5 = getent("z_trans_2_1_node", "targetname");
  var_6 = getent("z_trans_2_2_node", "targetname");
  var_7 = getent("z_trans_final_node", "targetname");
  var_8 = getEntArray("z_trans_test", "targetname");
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_9["odin_ally"] = level.ally;
  var_10["odin_ally"] = var_2;
  var_4 maps\_anim::anim_first_frame_solo(level.ally, "odin_hall_escape_turn01_ally");
  var_5 maps\_anim::anim_first_frame_solo(var_2, "odin_hall_escape_turn01_ally");
  var_4 thread maps\_anim::anim_single_solo(level.ally, "odin_hall_escape_turn01_ally");
  var_5 maps\_anim::anim_single_solo(var_2, "odin_hall_escape_turn01_ally");
  thread maps\odin_audio::sfx_bg_fighting_stop();
  var_7 thread maps\_anim::anim_single_solo(level.ally, "odin_hall_escape_turn02_ally");
  var_6 maps\_anim::anim_single_solo(var_2, "odin_hall_escape_turn02_ally");
  common_scripts\utility::flag_set("ally_out_of_z");
  var_12 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  var_6 = getent("ally_kyra_move_node01", "targetname");
  var_6 thread maps\_anim::anim_loop_solo(var_2, "odin_escape_start_first_encounter_loop_ally01", "stop_loops");
  var_12 thread maps\_anim::anim_loop_solo(level.ally, "odin_escape_start_first_encounter_loop_ally01", "stop_loops");
  common_scripts\utility::flag_wait("player_second_z_turn");
  var_12 notify("stop_loops");
  var_6 thread maps\_anim::anim_single_solo(var_2, "odin_escape_first_encounter_ally01");
  level.ally unlink();
  level.ally setgoalpos(level.ally.origin);
  level.ally maps\_utility::enable_ai_color();

  foreach(var_14 in var_8)
  var_14 delete();

  common_scripts\utility::flag_set("ally_clear");
  var_12 = common_scripts\utility::getstruct("ally_kyra_move_node01", "targetname");
}

#using_animtree("player");

z_trans_player(var_0) {
  thread early_escape_start();
  var_1 = getent("z_trans_hinge_a", "targetname");
  var_2 = getent("z_trans_2_1_node", "targetname");
  var_3 = getent("z_trans_2_2_node", "targetname");
  var_4 = getent("z_trans_final_node", "targetname");
  var_5 = getent("struggle_gun", "targetname");
  var_6 = maps\_utility::spawn_anim_model("player_rig");
  level.ally_ent_del[level.ally_ent_del.size] = var_6;
  var_7 = maps\_utility::spawn_anim_model("player_rig");
  level.ally_ent_del[level.ally_ent_del.size] = var_7;
  var_8 = [];
  var_9 = [];
  var_8["player_rig"] = var_6;
  var_9["player_rig"] = var_7;
  var_2 maps\_anim::anim_first_frame(var_9, "odin_hall_escape_turn01_player");
  maps\odin_util::fx_odin_monitor_bink_init();
  var_2 thread maps\_anim::anim_single(var_9, "odin_hall_escape_turn01_player");
  wait 2;
  var_10 = var_7 gettagorigin("tag_player");
  var_11 = var_7 gettagangles("tag_player");
  level.player setplayerangles(var_11);
  level.player setorigin(var_10);
  var_12 = 0;
  level.player playerlinktodelta(var_7, "tag_player", 1, var_12, var_12, var_12, var_12, 1);
  wait 3.03333;
  var_6 hide();
  var_7 hide();
  var_5 delete();
  common_scripts\utility::flag_set("lock_first_z_trans_door");
  level.player unlink();
  level.player giveweapon(level.player.weapon_interior);
  level.player setweaponammoclip(level.player.weapon_interior, level.struggle_bullets);
  level.player switchtoweapon(level.player.weapon_interior);
  setsaveddvar("ammoCounterHide", "0");
  level.player enableweapons();
  var_3 maps\_anim::anim_first_frame(var_9, "odin_hall_escape_turn02_player");
  var_4 maps\_anim::anim_first_frame(var_8, "odin_hall_escape_turn02_player");
  var_6 show();
  level.player maps\_utility::autosave_by_name("z_trans");
  thread maps\odin_util::dynamic_object_pusher();
  common_scripts\utility::flag_wait("player_second_z_turn");
  thread maps\odin_audio::sfx_traversal_02();
  level.player disableweapons();
  level.player playerlinktoblend(var_7, "tag_player", 0.75);
  wait 0.75;
  level.player playerlinktodelta(var_7, "tag_player", 1, var_12, var_12, var_12, var_12, 1);
  var_3 thread maps\_anim::anim_single(var_9, "odin_hall_escape_turn02_player");
  var_4 thread maps\_anim::anim_single(var_8, "odin_hall_escape_turn02_player");
  var_13 = 0;
  var_14 = 0;

  while(var_13 == 0) {
    var_15 = var_6 getanimtime(%odin_hallway_escape_turn02_player);
    var_15 = maps\_utility::round_float(var_15, 2, 0);

    if(var_15 >= 0.0 && var_14 == 0) {
      var_14 = 1;
      var_10 = var_6 gettagorigin("tag_player");
      var_11 = var_6 gettagangles("tag_player");
      level.player unlink();
      level.player setplayerangles(var_11);
      level.player setorigin(var_10);
      level.player playerlinktodelta(var_6, "tag_player", 1, var_12, var_12, var_12, var_12, 1);
    }

    if(var_15 >= 0.7)
      common_scripts\utility::flag_set("lock_z_hall_close_door");

    if(var_15 == 1)
      var_13 = 1;

    wait 0.01;
  }

  level.player unlink();
  thread post_z_push();
  level.player enableweapons();
  var_6 delete();
  var_7 delete();
  wait 0.25;
  common_scripts\utility::flag_set("clear_to_tweak_player");
}

early_escape_start() {
  common_scripts\utility::flag_wait("player_second_z_turn");
  thread maps\odin_escape::crew_quarters_combat();
}

post_z_push() {
  level endon("post_z_push_cancel");
  level thread post_z_push_cancel();

  for(var_0 = 0; var_0 > -4500; var_0 = var_0 - 700) {
    setsaveddvar("player_swimWaterCurrent", (var_0, 0, 0));
    wait 0.05;
  }

  wait 1.5;

  for(var_0 = -4500; var_0 < 0; var_0 = var_0 + 75) {
    setsaveddvar("player_swimWaterCurrent", (var_0, 0, 0));
    wait 0.05;
  }

  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
  level notify("post_z_push_done");
}

post_z_push_cancel() {
  level endon("post_z_push_done");

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] < -0.9)
      setsaveddvar("player_swimWaterCurrent", (0, 0, 0));

    wait 0.1;
  }
}

close_exterior_hatch() {
  level endon("ally_clear");
  var_0 = getent("scriptednode_pdoor", "targetname");
  var_1 = maps\_utility::spawn_anim_model("space_round_hatch");
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_intro_exterior_door_open");
}

airlock_interior_hatch() {
  level endon("ally_clear");
  var_0 = getent("scriptednode_squareDoor", "targetname");
  var_1 = maps\_utility::spawn_anim_model("space_square_hatch");
  level.ally_ent_del[level.ally_ent_del.size] = var_1;
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_infiltrate_door_open");
  var_2 = getent("intro_airlock_hatch_blocker", "targetname");
  var_3 = getent("intro_airlock_hatch_blocker_org", "targetname");
  var_3 linkto(var_1, "tag_origin");
  var_2 linkto(var_3);
  thread maps\odin_audio::sfx_airlock_door();
  var_0 maps\_anim::anim_single_solo(var_1, "odin_infiltrate_door_open");
}

ally_cleanup(var_0) {
  if(var_0 == 0) {
    common_scripts\utility::flag_wait("trigger_third_guy");

    if(isDefined(level.ally_ent_del)) {
      foreach(var_2 in level.ally_ent_del) {
        if(isDefined(var_2))
          var_2 delete();
      }
    }
  }

  maps\odin_util::safe_delete_noteworthy("ally_spawner_to_clean");
  maps\odin_util::safe_delete_noteworthy("ally_trig_to_clean");
  maps\odin_util::safe_delete_noteworthy("ally_ent_to_clean");
  var_4 = getEntArray("ally_tar_to_clean", "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6))
      var_6 delete();
  }
}

enemy_squad_spawn(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = getent(var_0 + var_5, "targetname");
    var_7 = var_6 maps\_utility::spawn_ai();
    var_3[var_5] = var_7;
    var_7 make_swimmer();
    maps\odin_util::actor_teleport(var_7, var_2 + var_5);
  }

  return var_3;
}

make_swimmer() {
  if(self.team == "allies") {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(self.swimmer) || self.swimmer == 0)
    thread maps\_space_ai::enable_space();
}