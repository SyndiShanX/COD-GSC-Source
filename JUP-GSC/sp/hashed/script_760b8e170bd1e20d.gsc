/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_760b8e170bd1e20d.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4b7698942d6f679a;
#using script_51f0a664afd44022;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\anim\cqb;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\fakeactor;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#using scripts\sp\statemachine;
#using scripts\sp\utility;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace namespace_5e5cef645f58d25c;

function function_8106fefb1e9cb632() {
  thread sp_jup_vip_lighting::function_9f153f00841d1005();
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
  namespace_9c93a5b828db4a4b::spawn_allies();
  utility::set_start_location("rooftop_infil", [level.player, level.ally1, level.ally2]);
  thread function_509115a6d7f4e772();
}

function function_fcb2584dbaf97de3() {
  level thread function_6e70ab947d1b1fa2();
  level thread function_20f7943d5a3d5b7e();
  level thread function_c6aecb595687f644();
  level thread function_135be6f15f578e5e();
  level thread function_880d72bf3a1e2b0b();
  level thread function_a45bea327250a363();
  level thread function_394006dbec35a30e();
  thread namespace_165c742e346e899e::function_706ab63d4d8f034b();
  level.player scripts\sp\player::player_movement_state("cqb");
  level.player val::set("vip_infil_wall", "sprint", 1);
  level.player val::set("vip_infil_wall", "supersprint", 0);
  utility::flag_wait("flag_player_over_wall");
  level thread function_82a2939269bdeb73();
  waitframe();
  utility::enable_trigger_with_targetname("killvolume_infil_01");
  utility::enable_trigger_with_targetname("killvolume_infil_02");
  level.ally1 set_ignoreme(1);
  level.ally2 set_ignoreme(1);

  if(!flag("fail_message_alert_gulag_displayed")) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  utility::flag_wait("flag_start_wall");
  utility::flag_set("flag_obj_reach_cells_activate");
  utility::flag_wait("flag_infil_tower_enter");

  if(!flag("fail_message_alert_gulag_displayed")) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  utility::flag_wait("flag_walkway_guys_dead");
  level notify("begin_bravo_infil");
  utility::flag_wait("flag_obj_infil_wall_complete");

  if(!flag("fail_message_alert_gulag_displayed")) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  level.ally1 disable_ai_color();
  level.ally2 disable_ai_color();
  level.ally1 cleargoalentity();
  level.ally2 cleargoalentity();
  var_81161d2fd5ea73a4 = getnode("infil_ally1_outside_door_node", "targetname");
  var_86c0d44fe85fda2d = getnode("infil_ally2_outside_door_node", "targetname");
  level.ally1 thread scripts\sp\spawner::go_to_node(var_81161d2fd5ea73a4);
  level.ally2 thread scripts\sp\spawner::go_to_node(var_86c0d44fe85fda2d);
  utility::flag_set("flag_infil_vo_ally2_stair_descent_begin");
  level.player scripts\sp\player::player_movement_state("default");
  level.player val::set("vip_infil_wall", "sprint", 1);
}

function function_394006dbec35a30e() {
  utility::flag_set("vip_fov_wallascend_top_of_wall");
}

function function_ef78e4e3897edffa() {}

function function_3364a6997c95ae82() {
  if(!nvg_player::is_nvg_on()) {
    utility::display_hint("nvg_hint", 60, 0, level.player, "night_vision_on");
  }
}

function function_6e70ab947d1b1fa2() {
  utility::flag_wait("flag_player_over_wall");
  function_64f815da552ce8c6();
  level.ally1 dialogue::say("dx_sp_jvip_wlat_koa1_allteamsalphasinhowc", 0, 0, 0, 0.5);
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_wlat_kob1_bravosoverthedz");
  level.player.vo_handler say("dx_sp_jvip_wlat_kob1_bravosoverthedz", 0, 0, 0, 0.5);
  level.player.vo_handler say("dx_sp_jvip_wlat_koc1_charliestandingby", 0, 0, 0, 0.5);
  utility::flag_wait_any("flag_ally_turn", "flag_start_wall");
  wait 1;
  delaythread(0.5, &function_3364a6997c95ae82);
  utility::flag_set_delayed("flag_IR_blinkers_on", 0.5);
  level.player dialogue::say("dx_sp_jvip_wlat_koa2_nodsonirstrobeson");
  utility::flag_wait("flag_nightvision_on");
  level.ally1 dialogue::say("dx_sp_jvip_wlat_koa1_keepitquiet", 0, 0, 0, 0.5);
  utility::flag_wait_any("flag_infil_tower_enter", "flag_early_bravo_landing");
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_wlat_kob1_bravoisinbound");
  thread namespace_165c742e346e899e::function_476aed0f6557231b();
  level.player.vo_handler say("dx_sp_jvip_wlat_kob1_bravoisinbound", 0, 0, 0, 0.5);
  level.ally1 say("dx_sp_jvip_wlat_koa1_solidcopymovetoset", 0, 0, 0, 0.5);
  utility::flag_wait("flag_infil_walkway");
  thread infil_music();

  if(!utility::flag("flag_walkway_guys_dead")) {
    level.ally1 dialogue::say("dx_sp_jvip_brav_koa1_drophim");
  }

  utility::flag_wait("flag_walkway_guys_dead");
  wait 1;
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_brav_kob1_bravoinbound");
  level.player.vo_handler say("dx_sp_jvip_brav_kob1_bravoinbound");
  utility::flag_wait("alpha_moving_up");
  level.player.vo_handler dialogue::say("dx_sp_jvip_bila_kob1_allteamsbravosondeck");
  level.ally1 dialogue::say("dx_sp_jvip_bila_koa1_alphatocharlieyouset", 0, 0, 0, 1.5);
  level.player.vo_handler dialogue::say("dx_sp_jvip_bila_koc1_affirmative", 0, 0, 0, 0.5);
  utility::flag_wait("flag_infil_vo_ally2_stair_descent_begin");

  if(!flag("flag_allies_teleported_to_maint_breach")) {
    level.ally1 dialogue::say("dx_sp_jvip_bila_koa1_allteamsgreentogoonp", 0, 0, 0, 0.25);
    level.player.vo_handler dialogue::say("dx_sp_jvip_bila_koc1_check", 0, 0, 0, 0.5);
    level.player.vo_handler dialogue::say("dx_sp_jvip_bila_kob1_rog", 0, 0, 0, 0.25);
  }

  var_917e821f26929a64 = ["finished_bravo_stair_animation", "flag_allies_to_maint_breach"];
  utility::function_7a252abaaa15fcd7(var_917e821f26929a64);
  flag_set("flag_maint_vo_start");
}

function infil_music() {
  wait 3.5;
  setmusicstate("mx_vip_infil");
}

function function_7c6d68434a3baa65(var_e5a295a65b330eb3) {
  utility::flag_wait("flag_infil_walkway");
  wait var_e5a295a65b330eb3;
  utility::flag_set("flag_spotlight_guys_clean_up");
}

function function_32c487d85e1e8d5(var_e5a295a65b330eb3) {
  utility::flag_wait("flag_infil_walkway");
  var_e1232776ace3639b = 3.4;
  var_f29f75610736fe45 = var_e5a295a65b330eb3 - var_e1232776ace3639b + 1;
  flag_clear("flag_infil_tower_enter");

  if(var_f29f75610736fe45 > 0) {
    wait var_f29f75610736fe45;
  }

  if(false) {
    iprintlnbold("EARLY BRAVO LANDING");
  }

  utility::flag_set("flag_early_bravo_landing");
}

function function_a45bea327250a363() {
  thread spotlight_controller();
  spawner = getspawner("infil_walkway_spotlight_guy_2", "targetname");
  level.spotlight_guy_2 = spawner utility::spawn_ai(1);
  waitframe();
  level.var_3defec7c969f1ba4 = utility::spawn_targetname("infil_tower_guy", 1);
  level.var_3defec7c969f1ba4.dropweapon = 0;
  spotlight_guys = [level.var_3defec7c969f1ba4, level.spotlight_guy_2];
  level thread function_1f292f7b027ee00d(spotlight_guys);
  animnode = utility::getStruct("scene_vip_0400_bravointro", "targetname");
  level.var_3defec7c969f1ba4 thread function_b58ed1162babf1dd("flag_guy_1_dead");
  level.spotlight_guy_2 thread function_b58ed1162babf1dd("flag_guy_2_dead");
  thread function_7c6d68434a3baa65(7);
  thread function_32c487d85e1e8d5(7);
  thread function_129d292c1dcbad35();
  flag_wait_any("stealth_spotted", "flag_spotlight_guys_clean_up", "flag_shoot_binocs_guy");
  utility::flag_set("flag_first_spotlight_guy_dead");
  damage_volume_spotlight = getEnt("damage_volume_spotlight", "targetname");
  damage_volume_spotlight dodamage(100, level.ally2.origin, level.ally1, level.ally1);
  level.ally2 notify("takedown_early_out");
  level notify("infil_tower_guy_moving");
  utility::flag_set("flag_walkway_guys_dead");
  utility::flag_set("flag_infil_walkway");
  level waittill("Alpha_valve_complete");
  utility::flag_set("flag_allies_over_wall");
}

function function_a20339442c7fef45(enemy_eye_pos) {
  var_4de5f4e60cca6423 = sighttracepassed(level.ally1 getEye(), enemy_eye_pos, 1, undefined);

  if(flag("flag_infil_walkway_allies") || var_4de5f4e60cca6423) {
    var_91767ab8c24b270c = spawn_tag_origin(enemy_eye_pos);
    level.ally1 shoot(10, enemy_eye_pos);
    return;
  }

  if(isDefined(level.team_b_1)) {
    magicbullet(level.var_c63685a4fe1d55fa, level.team_b_1.origin, enemy_eye_pos, level.team_b_1);
    return;
  }

  magicbullet(level.var_c63685a4fe1d55fa, (-8041, -16760, 2147), enemy_eye_pos, undefined);
}

function function_129d292c1dcbad35() {
  utility::flag_wait("flag_infil_walkway");

  if(!flag("flag_infil_walkway_allies")) {
    utility::activate_trigger_with_targetname("trig_allies_go_outside");
  }

  level.ally1.ignoreall = 0;
  level.ally1 disable_ai_color();

  if(!is_dead_or_dying(level.spotlight_guy_2)) {
    level.ally1 thread utility::aim_at(level.spotlight_guy_2 getEye(), 0, undefined, 0.5);
    level.ally1 thread utility::link_aim_to(level.spotlight_guy_2, "j_head", (0, 0, 0));
  }

  flag_wait_any("stealth_spotted", "flag_spotlight_guys_clean_up", "flag_shoot_binocs_guy");

  if(!is_dead_or_dying(level.spotlight_guy_2)) {
    wait 0.5;
  }

  if(!is_dead_or_dying(level.spotlight_guy_2)) {
    level.spotlight_guy_2.health = 1;
    level.ally1 setgoalpos(level.spotlight_guy_2.origin);
  }

  var_91767ab8c24b270c = undefined;

  if(!is_dead_or_dying(level.spotlight_guy_2)) {
    enemy_eye_pos = level.spotlight_guy_2 getEye();
    function_a20339442c7fef45(enemy_eye_pos);
    level.spotlight_guy_2 dodamage(150, level.spotlight_guy_2.origin, level.ally1, level.ally1);
  }

  if(!is_dead_or_dying(level.var_3defec7c969f1ba4)) {
    level.ally1 thread utility::aim_at(level.var_3defec7c969f1ba4 getEye(), 0, undefined, 0.5);
    level.ally1 thread utility::link_aim_to(level.var_3defec7c969f1ba4, "j_head", (0, 0, 0));
    wait 0.5;
  }

  if(!is_dead_or_dying(level.var_3defec7c969f1ba4)) {
    enemy_eye_pos = level.var_3defec7c969f1ba4 getEye();
    function_a20339442c7fef45(enemy_eye_pos);
    level.var_3defec7c969f1ba4 dodamage(150, level.var_3defec7c969f1ba4.origin, level.ally1, level.ally1);
  }

  if(isDefined(level.ally1.aim_target)) {
    level.ally1.aim_target unlink();

    if(isDefined(var_91767ab8c24b270c)) {
      level.ally1 thread utility::aim_at(var_91767ab8c24b270c.origin, 0, undefined, 0.5);
      level.ally1 thread utility::link_aim_to(var_91767ab8c24b270c);
      wait 0.5;
      level.ally1.aim_target unlink();
    }
  }

  level.ally1 utility::stop_aiming();
  level.ally1 enable_ai_color();
  level.ally1.ignoreall = 1;
  trigger_allies_go_down_scaffolding = getEnt("trigger_allies_go_down_scaffolding", "targetname");

  if(isDefined(trigger_allies_go_down_scaffolding) && isDefined(trigger_allies_go_down_scaffolding.count) && trigger_allies_go_down_scaffolding.count < 1) {
    utility::activate_trigger_with_targetname("trig_ally2_walks_towards_spotlight");
  }
}

function function_1f292f7b027ee00d(array) {
  waittill_any_ents_array(array, "damage", "death", "suppression", "bulletwhizby");
  flag_set("flag_spotlight_guys_clean_up");
}

function function_e2264870ca61b52() {
  utility::flag_wait("flag_charlie_explosion");
  screenshake(level.player.origin, 2.5, 1.2, 3.5, 0.5, 0, 0, 0, 6, 8, 2);
  wait 2;
  utility::flag_set("flag_turn_spotlights_towards_explosion");
  wait 4;
  utility::flag_set("flag_team_c_explosion_complete");
}

function function_b58ed1162babf1dd(var_acba072b7e847a86) {
  self waittill("death");
  flag_set(var_acba072b7e847a86);
}

function enemy_listener() {
  beginning_node = utility::getStruct(self.target, "targetname");

  while(!utility::flag("flag_infil_chopper_land")) {
    wait 5;
    self waittill("goal");
    self forceteleport(beginning_node.origin, beginning_node.angles);
  }

  waitframe();

  if(!utility::is_dead_or_dying(self)) {
    self delete();
  }
}

function function_2661bf383ba3d15d() {
  utility::flag_wait("flag_infil_chopper_land");

  if(!utility::is_dead_or_dying(self)) {
    self delete();
  }
}

function function_7128f160856cac8d() {
  waitframe();
  self waittill("goal");

  if(!utility::is_dead_or_dying(self)) {
    self delete();
  }
}

function function_509115a6d7f4e772() {
  spotlight_base = getEnt("spotlight_charlie_1_base", "targetname");

  if(!isDefined(spotlight_base)) {
    return;
  }

  spotlight_face = getEnt("spotlight_charlie_1_face", "targetname");
  rotation_struct = utility::getStruct("spotlight_charlie_1_rotation", "targetname");
  rotation_point = utility::spawn_tag_origin(rotation_struct.origin, rotation_struct.angles);
  fx_loc = utility::spawn_tag_origin(rotation_struct.origin + (10, 10, 0), rotation_struct.angles);
  fx_loc linkTo(rotation_point, "tag_origin", fx_loc.origin - rotation_point.origin, (0, 0, -90));
  spotlight_face linkTo(rotation_point, "tag_origin", (0, 0, -80), (0, 0, 0));
  rotation_point linkTo(spotlight_base, "tag_origin", (0, 0, 80), (0, 0, 0));
  var_5cbc6c52b656faf8 = getEnt("spotlight_charlie_2_base", "targetname");
  var_7fbefd96bb2a5494 = getEnt("spotlight_charlie_2_face", "targetname");
  var_6c0c54e238ff64 = utility::getStruct("spotlight_charlie_2_rotation", "targetname");
  var_54367f376e5bb5b7 = utility::spawn_tag_origin(var_6c0c54e238ff64.origin, var_6c0c54e238ff64.angles);
  var_a4c9c3e3b5c4da53 = utility::spawn_tag_origin(var_6c0c54e238ff64.origin + (10, 10, 0), var_6c0c54e238ff64.angles);
  var_a4c9c3e3b5c4da53 linkTo(var_54367f376e5bb5b7, "tag_origin", var_a4c9c3e3b5c4da53.origin - var_54367f376e5bb5b7.origin, (0, 0, -90));
  var_7fbefd96bb2a5494 linkTo(var_54367f376e5bb5b7, "tag_origin", (0, 0, -80), (0, 0, 0));
  var_54367f376e5bb5b7 linkTo(var_5cbc6c52b656faf8, "tag_origin", (0, 0, 80), (0, 0, 0));
  var_5cbc6d52b656fd2b = getEnt("spotlight_charlie_3_base", "targetname");
  var_7fbefe96bb2a56c7 = getEnt("spotlight_charlie_3_face", "targetname");
  var_6c0d54e2390197 = utility::getStruct("spotlight_charlie_3_rotation", "targetname");
  var_54367e376e5bb384 = utility::spawn_tag_origin(var_6c0d54e2390197.origin, var_6c0d54e2390197.angles);
  var_a4c9c2e3b5c4d820 = utility::spawn_tag_origin(var_6c0d54e2390197.origin + (10, 10, 0), var_6c0d54e2390197.angles);
  var_a4c9c2e3b5c4d820 linkTo(var_54367e376e5bb384, "tag_origin", var_a4c9c2e3b5c4d820.origin - var_54367e376e5bb384.origin, (0, 0, -90));
  var_7fbefe96bb2a56c7 linkTo(var_54367e376e5bb384, "tag_origin", (0, 0, -80), (0, 0, 0));
  var_54367e376e5bb384 linkTo(var_5cbc6d52b656fd2b, "tag_origin", (0, 0, 80), (0, 0, 0));
  playFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_02"), fx_loc, "tag_origin");
  playFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_02"), var_a4c9c3e3b5c4da53, "tag_origin");
  playFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_02"), var_a4c9c2e3b5c4d820, "tag_origin");
  rotation_point rotatebylinked((0, 0, -15), 0.1);
  var_54367f376e5bb5b7 rotatebylinked((0, 0, -45), 0.1);
  var_54367e376e5bb384 rotatebylinked((0, 0, -15), 0.1);
  spotlight_base thread function_713a6f093aa49313("flag_turn_spotlights_towards_explosion", 50);
  wait 0.5;
  var_5cbc6c52b656faf8 thread function_713a6f093aa49313("flag_turn_spotlights_towards_explosion", 30);
  var_5cbc6d52b656fd2b rotateTo((0, 175, 0), 2, 1, 1);
  utility::flag_wait("flag_player_over_wall");
  wait 2;
  var_5cbc6d52b656fd2b rotateTo((0, 135, 0), 10, 1, 2);
  wait 10;
  var_54367e376e5bb384 rotatebylinked((0, 0, -45), 2);
  var_5cbc6d52b656fd2b rotateTo((0, 175, 0), 4, 1, 2);
  wait 4;
  var_5cbc6d52b656fd2b thread function_713a6f093aa49313("flag_turn_spotlights_towards_explosion");
  wait 1;
  utility::flag_wait("flag_turn_spotlights_towards_explosion");
  var_54367e376e5bb384 rotatebylinked((0, 0, 60), 3, 1, 1);
  var_5cbc6d52b656fd2b rotateTo((0, 30, 0), 4, 1, 2);
  wait 0.5;
  rotation_point rotatebylinked((0, 0, 15), 3, 1, 1);
  spotlight_base rotateTo((0, 15, 0), 4, 1, 2);
  wait 0.5;
  var_54367f376e5bb5b7 rotatebylinked((0, 0, 15), 3, 1, 1);
  var_5cbc6c52b656faf8 rotateTo((0, 30, 0), 4, 1, 2);
}

function spotlight_controller() {
  level endon("flag_obj_infil_maintenance_complete");
  spotlight_base = getEnt("spotlight_02_base", "targetname");
  var_20f98fa55b857dac = getEnt("spotlight_02_base_clip", "targetname");
  var_20f98fa55b857dac linkTo(spotlight_base);

  if(!isDefined(spotlight_base) || !isDefined(var_20f98fa55b857dac)) {
    return;
  }

  spotlight_face = getEnt("spotlight_02_face", "targetname");
  var_678f431f78447d98 = getEnt("spotlight_02_face_clip", "targetname");
  var_678f431f78447d98 linkTo(spotlight_face);
  damage_volume_spotlight = getEnt("damage_volume_spotlight", "targetname");
  damage_volume_spotlight linkTo(spotlight_face);
  rotation_struct = utility::getStruct("spotlight_02_rotation", "targetname");
  rotation_point = utility::spawn_tag_origin(rotation_struct.origin, rotation_struct.angles);
  fx_loc = utility::spawn_tag_origin(rotation_struct.origin + (10, 10, 0), rotation_struct.angles);
  fx_loc linkTo(rotation_point, "tag_origin", fx_loc.origin - rotation_point.origin, (0, 0, -90));
  spotlight_face linkTo(rotation_point, "tag_origin", (0, 0, -80), (0, 0, 0));
  rotation_point linkTo(spotlight_base, "tag_origin", (0, 0, 80), (0, 0, 0));
  playFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_01"), fx_loc, "tag_origin");
  rotation_point rotatebylinked((0, 0, 15), 0.1);
  wait 3;
  spotlight_base thread function_713a6f093aa49313("flag_turn_off_light");
  damage_volume_spotlight = getEnt("damage_volume_spotlight", "targetname");
  damage_volume_spotlight setCanDamage(1);
  damage_volume_spotlight.health = 10;
  damage_volume_spotlight solid();
  damage_volume_spotlight waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
  utility::flag_set("flag_turn_off_light");
  level notify("spotlight_stopped");
  snd_play("scn_vip_spotlight_end", spotlight_base);
  spotlight_face setModel("flak_tower_ger_sw37_searchlight_head");
  stopFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_01"), fx_loc, "tag_origin");
  rotation_point rotatebylinked((0, 0, -75), 2.5, 2);
}

function function_713a6f093aa49313(flag_string, var_40b12e1dfb31b5db) {
  self endon("stop_rotation");
  i = 0;
  blend_in = 0;
  blend_out = 0;

  if(!isDefined(var_40b12e1dfb31b5db)) {
    var_40b12e1dfb31b5db = 75;
  }

  wait_time = 2;
  rotate_increment = var_40b12e1dfb31b5db / 5;

  while(!utility::flag(flag_string)) {
    var_4cef47e15ad65b1e = snd_play("scn_vip_spotlight_left_motor", self);
    function_74726126b3d8b0aa(var_4cef47e15ad65b1e, "spotlight_stopped", 0.5);

    for(i = 0; i < 5; i++) {
      if(i < 2) {
        blend_in = 2;
        blend_out = 0;
      } else if(i > 8) {
        blend_in = 0;
        blend_out = 2;
      } else {
        blend_in = 0;
        blend_out = 0;
      }

      if(!utility::flag(flag_string)) {
        self rotateby((0, rotate_increment, 0), 2, blend_in, blend_out);
        wait wait_time;
        continue;
      }

      return;
    }

    if(!utility::flag(flag_string)) {
      var_c15822b60d042813 = snd_play("scn_vip_spotlight_right_motor", self);
      function_74726126b3d8b0aa(var_c15822b60d042813, "spotlight_stopped", 0.5);
    }

    for(i = 0; i < 5; i++) {
      if(i < 2) {
        blend_in = 2;
        blend_out = 0;
      } else if(i > 8) {
        blend_in = 0;
        blend_out = 2;
      } else {
        blend_in = 0;
        blend_out = 0;
      }

      if(!utility::flag(flag_string)) {
        self rotateby((0, rotate_increment * -1, 0), 2, blend_in, blend_out);
        wait wait_time;
        continue;
      }

      return;
    }
  }
}

function function_16e310b41ae87efb() {
  var_917e821f26929a64 = ["flag_allies_to_maint_breach", "flag_ally1_bravo_intro_finished", "flag_ally_at_door_node_1"];
  utility::function_7a252abaaa15fcd7(var_917e821f26929a64);
  level.ally1 setavoidanceradius(15);
  thread scene::play(level.ally1, ["ally1_ai_transition", "ally1_breach_loop"]);
}

function function_5959ae728c14d48c() {
  var_917e821f26929a64 = ["flag_allies_to_maint_breach", "flag_ally2_bravo_intro_finished", "flag_ally_at_door_node_2"];
  utility::function_7a252abaaa15fcd7(var_917e821f26929a64);
  level.ally2 setavoidanceradius(15);
  thread scene::play(level.ally2, ["ally2_ai_transition", "ally2_breach_loop"]);
}

function function_38eebb1fa0580155(outside_door_node, var_acba072b7e847a86) {
  var_70b9054a6c41ffea = getnode(outside_door_node, "targetname");

  while(distance(self.origin, var_70b9054a6c41ffea.origin) > 8) {
    teleport_ai(var_70b9054a6c41ffea);
    wait 0.1;
  }

  flag_set(var_acba072b7e847a86);
}

function function_f356d59670e0749d() {
  maint_breach_door = getStruct("maint_breach_door", "script_noteworthy");

  while(!flag("flag_ally_at_door_node_1") && !flag("flag_ally_at_door_node_2")) {
    maint_breach_door waittill("trigger");

    if(!flag("flag_ally_at_door_node_1") && !flag("flag_ally_at_door_node_2")) {
      traversal_zone_dont_teleport_allies = getEnt("traversal_zone_dont_teleport_allies", "targetname");
      var_f15efa38074d0a3a = level.ally1 istouching(traversal_zone_dont_teleport_allies);
      var_8c60c70c07bfd185 = level.ally2 istouching(traversal_zone_dont_teleport_allies);
      var_9b6086c135d6a7e9 = getnode("infil_ally1_outside_door_node", "targetname");
      var_268b4bea05cf6c9a = function_e7c30095a6cdc3ef(maint_breach_door.origin, 35, 0);
      var_e4edc9a299a2fdc6 = function_e7c30095a6cdc3ef(var_9b6086c135d6a7e9.origin);

      if(var_268b4bea05cf6c9a && !var_e4edc9a299a2fdc6 && !var_f15efa38074d0a3a && !var_8c60c70c07bfd185) {
        level.ally1 thread function_38eebb1fa0580155("infil_ally1_outside_door_node", "ally1_teleported");
        level.ally2 thread function_38eebb1fa0580155("infil_ally2_outside_door_node", "ally2_teleported");
        flag_wait_all("ally1_teleported", "ally2_teleported");
        flag_set("flag_allies_callout_obective");
        flag_set("finished_bravo_stair_animation");
        flag_set("flag_allies_teleported_to_maint_breach");
        flag_set("flag_ally_at_door_node_1");
        flag_set("flag_ally_at_door_node_2");
      }
    }

    waitframe();
  }
}

function function_7cc7dfaa66712025() {
  var_8218aa35d2c29cf1 = getEnt("maint_breach_door", "targetname");
  var_8218aa35d2c29cf1.animname = "Prop 1";
  actor_array = [level.ally1, level.ally2, var_8218aa35d2c29cf1];
  breach_node = utility::getStruct("scene_vip_0500_maintenance_breach", "targetname");
  var_feb7c672cad2a1fb = utility::getStruct("scene_vip_0500_maintenance_breach", "targetname");
  var_feb7c772cad2a42e = utility::getStruct("scene_vip_0500_maintenance_breach", "targetname");
  waitframe();
  player_blocker = getEnt("maint_breach_blocker", "targetname");
  player_blocker_end_loc = utility::getStruct("maint_player_blocker_end_loc", "targetname");
  var_2240bbc5229376ee = player_blocker.origin;
  var_c3b3af1bcdb5d944 = player_blocker.angles;
  level.ally1 thread function_b1c9be88f661252a();
  level.ally2 thread function_b1c9be88f661252a();
  var_feb7c672cad2a1fb thread function_16e310b41ae87efb();
  var_feb7c772cad2a42e thread function_5959ae728c14d48c();
  var_687ecf072a4e88a3 = ["flag_maint_breach_allies_in_pos_1", "flag_maint_breach_allies_in_pos_2"];
  utility::function_7a252abaaa15fcd7(var_687ecf072a4e88a3);
  utility::flag_wait("flag_infil_player_at_door");
  maint_breach_door = getStruct("maint_breach_door", "script_noteworthy");
  maint_breach_door function_ec55b3dd58f10e7b();
  var_feb7c672cad2a1fb scene::stop();
  var_feb7c772cad2a42e scene::stop();
  breach_node thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, actor_array, "breach_enter");
  utility::flag_set("flag_infil_vo_lockpick");
  level.ally1 utility::enable_ai_color();
  level.ally2 utility::enable_ai_color();
  waitframe();
  level.ally1 waittill("delete_maint_blocker");
  player_blocker moveTo(player_blocker_end_loc.origin, 0.1);
  player_blocker rotateTo(player_blocker.angles + (0, 80, 0), 0.1);
  thread function_57c9b0ca9cd16e3e(player_blocker, var_2240bbc5229376ee, var_c3b3af1bcdb5d944, var_8218aa35d2c29cf1, breach_node);
  flag_wait("flag_allies_breached");
  flag_set("flag_maint_allies_phase_1");
  flag_set_delayed("flag_maint_allies_phase_1.5", 3);
  function_52b5aaee35540c0b(0);

  if(flag("flag_charlie_explosion")) {
    breach_node scene::stop();
  } else {
    thread function_5a22adf38a7b8a8b(breach_node);
  }

  level.ally2 waittill("maint_nods_off");
  namespace_9c93a5b828db4a4b::function_37f2a21dd7f9971(0);
  breach_node waittill("scene_complete");
  utility::flag_set("flag_maint_breach_complete");
}

function function_57c9b0ca9cd16e3e(player_blocker, var_2240bbc5229376ee, var_c3b3af1bcdb5d944, var_8218aa35d2c29cf1, breach_node) {
  utility::flag_wait("flag_infil_to_maintenance_switch");
  player_blocker moveTo(var_2240bbc5229376ee, 0.1);
  player_blocker rotateTo(var_c3b3af1bcdb5d944, 0.1);
  breach_node thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, var_8218aa35d2c29cf1, "closed door");
}

function function_5a22adf38a7b8a8b(animnode) {
  while(true) {
    if(flag("flag_maint_breach_complete")) {
      break;
    }

    if(flag("flag_player_engaged")) {
      animnode scene::stop();
      break;
    }

    waitframe();
  }
}

function function_b1c9be88f661252a() {
  self waittill("maint_breach_allies_in_pos");

  if(self == level.ally1) {
    flag_name = "flag_maint_breach_allies_in_pos_1";
    waitframe();
    utility::flag_set(flag_name);
    return;
  }

  if(self == level.ally2) {
    flag_name = "flag_maint_breach_allies_in_pos_2";
    waitframe();
    utility::flag_set(flag_name);
  }
}

function function_f73025f4d205a951() {
  var_42bdffab0292d734 = utility::getStruct("vip_0500_halflife_liftgrate", "targetname");
  waitframe();
  hatch_nav_mod = getEnt("hatch_nav_mod", "targetname");
  hatch_nav_mod disconnectPaths();
  var_5273a68c46390ac1 = utility::getStruct("grate_interact_org", "targetname");
  var_5273a68c46390ac1 cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_VIP/INTERACT_LIFT_GRATE", undefined, undefined, 100, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_5273a68c46390ac1 waittill("trigger");
  level.player hide();
  hatch_nav_mod connectpaths();
  flag_set("flag_player_triggered_grate_open_vo");
  thread namespace_165c742e346e899e::function_b80f653e86c98321();
  thread namespace_165c742e346e899e::function_35621b694094d7de();
  level.player player::focusdisable();
  utility::function_1ae8f046dee579e0(1);
  var_42bdffab0292d734 thread scene::play(level.player, "player_anim");
  wait 1;
  level.player show();
  var_42bdffab0292d734 thread scene::play(level.ally1, "liftgrate_ally01");
  var_42bdffab0292d734 thread scene::play(level.ally2, "liftgrate_ally02");
  level.player waittill("piperoom_fov_transition");
  utility::flag_set("vip_fov_maintenance_piperoom_enter");
  level.ally1 utility::enable_ai_color();
  level.ally2 utility::enable_ai_color();
  utility::flag_set("allies_to_pipe_entrance");
  level.player waittill("0500_take_weapon");
  thread namespace_165c742e346e899e::function_b80f623e86c97c88();
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);
  utility::activate_trigger_with_targetname("trig_allys_post_grate_lift_pos");
}

#using_animtree("vehicles");

function function_ae20b2a7fa79cb4() {
  if(utility::flag("flag_infil_chopper_land")) {
    return;
  }

  heli_static_model = getEnt("heli_static_model", "targetname");

  if(!isDefined(heli_static_model)) {
    return;
  }

  heli_static_model setModel("veh9_mil_air_heli_hind_mp");
  heli_static_model useanimtree(#animtree);
  heli_static_model.origin += (0, 0, 144);
  heli_static_model setanim(%bh_rotors, 1, 0.2, 1);
  heli_static_model_just_gears = getEnt("heli_static_model_just_gears", "targetname");

  if(!isDefined(heli_static_model_just_gears)) {
    return;
  }

  heli_static_model_just_gears.var_e4f619e19ea53346 = 0;
  playFXOnTag(getfx("vfx_vip_heli_lights_blinkies"), heli_static_model, "body_animate_jnt");
  utility::flag_wait("flag_infil_chopper_land");
  killfxontag(getfx("vfx_vip_heli_lights_blinkies"), heli_static_model, "body_animate_jnt");
  heli_static_model delete();
  heli_static_model_just_gears delete();
}

function function_20f7943d5a3d5b7e() {
  level.infil_allies = [level.ally1, level.ally2];
  waitframe();

  foreach(guy in level.infil_allies) {
    if(isDefined(guy)) {
      guy utility::set_ignoreall(1);
      guy utility::set_ignoreme(1);
      guy utility::disable_stayahead();
      guy demeanoroverride("cqb");
      guy setavoidanceradius(8);
      guy.pushable = 0;
      guy pushplayer(1);
    }
  }

  thread function_a183f727f82d77f7();
  struct_pos = utility::getStruct("struct_fov_check", "targetname");
  struct = utility::spawn_tag_origin(struct_pos.origin, struct_pos.angles);
  var_7345059852f576d3 = 0;

  while(!var_7345059852f576d3) {
    var_7345059852f576d3 = utility::within_fov(level.player.origin, level.player getplayerangles(), struct.origin, cos(45));
    waitframe();
  }

  utility::flag_set("flag_ally_turn");
  level.player thread function_55e693bd720abf06();
  utility::flag_wait("flag_IR_blinkers_on");
  utility::flag_wait("flag_walkway_guys_dead");
}

function function_55e693bd720abf06() {
  self endon("death");
  nvg_on = 0;
  var_3fd61f2142ca168d = 0;
  offset_wait = randomfloatrange(0, 0.5);
  utility::flag_wait("flag_IR_blinkers_on");

  while(!utility::flag("flag_obj_infil_wall_complete")) {
    if(nvg_player::is_nvg_on() && !nvg_on) {
      foreach(guy in level.infil_allies) {
        if(isDefined(guy)) {
          wait offset_wait;
          guy.light_tag = utility::spawn_tag_origin(guy gettagorigin("j_helmet"), guy gettagangles("tag_eye"));
          guy.light_tag linkTo(guy, "j_helmet", (1.5, 3, 0), (0, 0, 0));
          playFXOnTag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
        }
      }

      nvg_on = 1;
    } else if(!nvg_player::is_nvg_on() && nvg_on) {
      foreach(guy in level.infil_allies) {
        if(isDefined(guy)) {
          killfxontag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
          guy.light_tag delete();
        }
      }

      nvg_on = 0;
    }

    if(nvg_player::is_nvg_on() && !var_3fd61f2142ca168d && isDefined(level.var_205d06de6ed69c4c)) {
      playFXOnTag(utility::getfx("vfx_vip_nightvision_beacon_grenade"), level.var_205d06de6ed69c4c, "tag_origin");
      var_3fd61f2142ca168d = 1;
    } else if(!nvg_player::is_nvg_on() && var_3fd61f2142ca168d && isDefined(level.var_205d06de6ed69c4c)) {
      killfxontag(utility::getfx("vfx_vip_nightvision_beacon_grenade"), level.var_205d06de6ed69c4c, "tag_origin");
      var_3fd61f2142ca168d = 0;
    }

    wait 0.25;
  }

  if(nvg_on) {
    foreach(guy in level.infil_allies) {
      if(isDefined(guy)) {
        killfxontag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
        guy.light_tag delete();
      }
    }

    if(isDefined(level.var_205d06de6ed69c4c)) {
      killfxontag(utility::getfx("vfx_vip_nightvision_beacon"), level.var_205d06de6ed69c4c, "tag_origin");
    }
  }
}

function function_a183f727f82d77f7() {
  utility::activate_trigger_with_targetname("trig_allies_begin_color_after_wall_climb");
  utility::flag_wait("flag_infil_allies_begin");
  utility::activate_trigger_with_targetname("trig_allies_to_parrapet_enter");
  utility::flag_wait_any("flag_shoot_binocs_guy", "flag_guy_1_dead", "flag_guy_2_dead");
}

function function_a9dfe9e51ba2ac79() {
  level endon("next_node_cancel");
  next_node = getnode(self.infil_node.target, "targetname");
  utility::set_goal_node(next_node);
  self.infil_node = next_node;
}

function function_82a2939269bdeb73() {
  level.team_b_1 = utility::spawn_targetname("team_b_1", 1);
  waitframe();
  level.team_b_2 = utility::spawn_targetname("team_b_2", 1);
  waitframe();
  level.team_b_3 = utility::spawn_targetname("team_b_3", 1);
  waitframe();
  level.team_b_1.goalradius = 8;
  level.team_b_2.goalradius = 8;
  level.team_b_3.goalradius = 8;
  level.team_b_1.animname = "team_b_1";
  level.team_b_2.animname = "team_b_2";
  level.team_b_3.animname = "team_b_3";
  level.team_b_1.name = "Gibson";
  level.team_b_1.callsign = "Bravo-1";
  level.team_b_2.name = "Rees";
  level.team_b_2.callsign = "Bravo-2";
  level.team_b_3.name = "Davidson";
  level.team_b_3.callsign = "Bravo-3";
  level.team_b_1.ignoreme = 1;
  level.team_b_2.ignoreme = 1;
  level.team_b_3.ignoreme = 1;
  level.team_b_1.laserenabled = 0;
  level.team_b_1.var_ac586f2e112c08cf = 1;
  level.team_b_1 laserforceoff();
  level.team_b_1 laseroff();
  level.team_b_2.laserenabled = 0;
  level.team_b_2.var_ac586f2e112c08cf = 1;
  level.team_b_2 laserforceoff();
  level.team_b_2 laseroff();
  level.team_b_3.laserenabled = 0;
  level.team_b_3.var_ac586f2e112c08cf = 1;
  level.team_b_3 laserforceoff();
  level.team_b_3 laseroff();
  level.team_b_1.health = 100000;
  level.team_b_2.health = 100000;
  level.team_b_3.health = 100000;
  level.team_b_1 set_strict_ff(1);
  level.team_b_2 set_strict_ff(1);
  level.team_b_3 set_strict_ff(1);
  waitframe();
  level thread function_39fdded6856d3823();
  animation_array = [level.team_b_1, level.team_b_2, level.team_b_3, level.ally1, level.ally2];
  animnode = utility::getStruct("scene_vip_0400_bravointro", "targetname");
  flag_array = ["ally1_in_bravo_pos", "ally2_in_bravo_pos"];

  if(isDefined(animnode)) {
    flag_wait_any("flag_walkway_guys_dead", "flag_early_bravo_landing", "flag_shoot_binocs_guy");

    if(flag("flag_walkway_guys_dead")) {
      if(false) {
        iprintlnbold("<dev string:x1c>");
      }
    } else if(flag("flag_early_bravo_landing")) {
      if(false) {
        iprintlnbold("<dev string:x54>");
      }

      flag_wait_any_timeout(4.6, "flag_infil_tower_enter", "flag_walkway_guys_dead", "flag_shoot_binocs_guy");
    }

    animnode thread function_57ac36ea7abb5af4(undefined, animation_array, "shot_060");
    utility::flag_set("flag_obj_synch_with_bravo");
    utility::flag_set("flag_start_sync_vo");
    utility::flag_set("flag_turn_off_light");
    utility::flag_set("ally2_in_bravo_pos");
    level.var_3b33cf134cac5e5b = getStruct("scene_vip_0400_bravointro_second_ally", "targetname");

    if(!isDefined(level.var_3b33cf134cac5e5b)) {
      level.var_3b33cf134cac5e5b = spawnStruct();
      level.var_3b33cf134cac5e5b.origin = animnode.origin;
      level.var_3b33cf134cac5e5b.angles = animnode.angles;
      level.var_3b33cf134cac5e5b.script_scenescriptbundle = animnode.script_scenescriptbundle;
    }
  }

  level notify("Alpha_valve_complete");
  level.var_635ed198aeb022ff = utility::getStruct("scene_vip_alpha_valve", "targetname");
  level thread function_87efd7e889e044c8();
  level thread function_87efdae889e04b61();
  animnode waittill("scene_complete");
  waitframe();
  level.team_b_1.laserenabled = 0;
  level.team_b_1.var_ac586f2e112c08cf = 1;
  level.team_b_1 laserforceoff();
  level.team_b_1 laseroff();
  level.team_b_2.laserenabled = 0;
  level.team_b_2.var_ac586f2e112c08cf = 1;
  level.team_b_2 laserforceoff();
  level.team_b_2 laseroff();
  level.team_b_3.laserenabled = 0;
  level.team_b_3.var_ac586f2e112c08cf = 1;
  level.team_b_3 laserforceoff();
  level.team_b_3 laseroff();
}

function function_87efdae889e04b61() {
  level.ally2 endon("death");
  flag_set("flag_ally2_bravo_intro_finished");
  level.ally2.pushable = 0;
  waitframe();
  poi_1 = getEnt("poi_1", "targetname");
  poi_2 = getEnt("poi_2", "targetname");
  poi_3 = getnode("poi_3", "targetname");
  poi_4 = getnode("poi_4", "targetname");
  poi_4.script_poi_forcestrafe = 1;
  poi_5 = getnode("poi_5", "targetname");
  poi_5.script_poi_forcestrafe = 1;

  if(isDefined(poi_1)) {
    while(!level.ally2 istouching(poi_1) && !flag("flag_allies_teleported_to_maint_breach")) {
      waitframe();
    }

    while(!level.ally2 istouching(poi_2) && !flag("flag_allies_teleported_to_maint_breach")) {
      waitframe();
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      level.ally2 scripts\anim\cqb::function_50fb5efa67518b10(poi_4);
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      wait 3;
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      level.ally2 scripts\anim\cqb::function_50fb5efa67518b10(poi_5);
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      wait 2;
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      level.ally2 scripts\anim\cqb::function_50fb5efa67518b10(level.ally1);
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      wait 0.1;
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      level.ally2 scripts\anim\cqb::function_50fb5efa67518b10();
    }

    flag_wait("flag_start_maint_breach_anim");
    utility::flag_set("finished_bravo_stair_animation");
    level.ally2 scripts\anim\cqb::function_50fb5efa67518b10();
  }
}

function function_87efd7e889e044c8() {
  flag_set("flag_ally1_bravo_intro_finished");
  level.ally1.pushable = 0;
  waitframe();
  level notify("allys_post_bravo_stair_pos");
  poi_1 = getEnt("poi_1", "targetname");
  poi_2 = getEnt("poi_2", "targetname");
  poi_3 = getnode("poi_3", "targetname");
  poi_3.script_poi_forcestrafe = 1;
  poi_4 = getnode("poi_4", "targetname");
  poi_5 = getnode("poi_5", "targetname");

  if(isDefined(poi_1)) {
    while(!level.ally1 istouching(poi_1) && !flag("flag_allies_teleported_to_maint_breach")) {
      waitframe();
    }

    while(!level.ally1 istouching(poi_2) && !flag("flag_allies_teleported_to_maint_breach")) {
      waitframe();
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      level.ally1 scripts\anim\cqb::function_50fb5efa67518b10(poi_5);
    }

    if(!flag("flag_allies_teleported_to_maint_breach")) {
      wait 2;
    }

    level.ally1 scripts\anim\cqb::function_50fb5efa67518b10();
  }

  flag_wait("flag_start_maint_breach_anim");
  utility::flag_set("finished_bravo_stair_animation");
}

function function_f010597f6b1354ec() {
  utility::flag_set("flag_call_charlie_triggered");
}

function function_39fdded6856d3823() {
  team_b_1_node_2 = getnode("team_b_1_node_2", "targetname");
  team_b_2_node_2 = getnode("team_b_2_node_2", "targetname");
  team_b_3_node_2 = getnode("team_b_3_node_2", "targetname");
  wait 2;
  level.team_b_1 setgoalnode(team_b_1_node_2);
  level.team_b_2 setgoalnode(team_b_2_node_2);
  level.team_b_3 setgoalnode(team_b_3_node_2);
  level.team_b_1 thread function_bb60b11bddbf81d6();
  level.team_b_2 thread function_bb60b11bddbf81d6();
  level.team_b_3 thread function_bb60b11bddbf81d6();
}

function function_bb60b11bddbf81d6() {
  self waittill("goal");
  self hide();
  self.health = 150;
}

function function_135be6f15f578e5e() {
  spawners = utility::get_spawner_array("maint_guys_staging", "script_noteworthy");
  var_81644012f83b53ab = utility::array_spawn(spawners, 1, undefined, 1);
  waitframe();
  var_713c3db6d9d98f0d = spawn_script_noteworthy("rush_guy_1", 1);
  waitframe();
  var_713c3ab6d9d98874 = spawn_script_noteworthy("rush_guy_2", 1);
  waitframe();
  var_86be94ea39d8f43d = getspawner("guard_leader", "targetname");
  var_86be94ea39d8f43d.count = 2;
  var_48ed85e4151ae5f8 = spawn_targetname("guard_leader");
  waitframe();
  var_ead48747b16df473 = vehicle::spawn_vehicle_from_targetname_and_drive("maint_prisoner_truck");
  var_300e53b0d3951e34 = vehicle::spawn_vehicle_from_targetname_and_drive("maint_guard_truck");
  var_7e638ab2e31cbc34 = utility::array_spawn_targetname("truck_prisoners_linked", undefined, undefined, undefined, 1);

  foreach(guy in var_81644012f83b53ab) {
    guy thread function_62d83dcf709eb185();
  }

  var_713c3db6d9d98f0d thread function_62d83dcf709eb185();
  var_713c3ab6d9d98874 thread function_62d83dcf709eb185();
  var_48ed85e4151ae5f8 thread function_62d83dcf709eb185();
  var_ead48747b16df473 thread function_5b42349675f58a2d();
  var_300e53b0d3951e34 thread function_5b42349675f58a2d();

  foreach(guy in var_7e638ab2e31cbc34) {
    guy thread function_62d83dcf709eb185();
    guy.animname = "guy";
    org = getEnt(guy.target, "targetname");
    org thread animation::anim_loop_solo(guy, "prisoner_kneel_idle");
    wait 0.05;
    org thread animation::anim_set_time_solo(guy, "prisoner_kneel_idle", randomfloatrange(0, 1));
    guy linkTo(var_ead48747b16df473);
    org linkTo(var_ead48747b16df473);
    guy.name = "";
  }

  utility::array_spawn_function_noteworthy("infil_ambience", &function_62d83dcf709eb185);
  utility::array_spawn_function_noteworthy("infil_ambience_truck_guys", &function_62d83dcf709eb185);
  utility::array_spawn_function_noteworthy("infil_ambience_truck_guys", &function_c9fc09b9bab7a4b4);
  spawners = utility::get_spawner_array("infil_ambience_footmen", "script_noteworthy");
  infil_ambience_footmen = utility::array_spawn(spawners, 1, undefined, 1);
  spawners = utility::get_spawner_array("infil_ambience_footmen_torch", "script_noteworthy");
  infil_ambience_footmen_torch = utility::array_spawn(spawners, 1, undefined, 1);

  foreach(guy in infil_ambience_footmen) {
    guy thread function_62d83dcf709eb185();
  }

  foreach(guy in infil_ambience_footmen_torch) {
    guy thread function_62d83dcf709eb185();
    playFXOnTag(utility::getfx("vfx_flashlight_npc_perf_short_vip"), guy, "tag_laser_attach");
  }

  truck3 = vehicle::spawn_vehicle_from_targetname_and_drive("infil_moving_truck_3", 1);
  wait 1;
  truck1 = vehicle::spawn_vehicle_from_targetname_and_drive("infil_moving_truck_1", 1);
  truck3 thread function_5b42349675f58a2d();
  truck1 thread function_5b42349675f58a2d();
  level thread function_eee55f7cd4a3332d();
  utility::flag_wait("flag_first_truck_in_position");
  wait 2.5;
  utility::flag_set("flag_send_first_truck");
  utility::flag_wait("flag_second_truck_in_position");
  wait 4;
  utility::flag_set("flag_send_second_truck");
  utility::flag_wait("flag_truck_01_reached_end");
  utility::flag_wait("infil_cleanup_ambience");
}

function function_eee55f7cd4a3332d() {
  level endon("infil_cleanup_ambience");
  infil_amb = getEntArray("infil_ambience", "script_noteworthy", 1);
  var_58388df8f779780b = getEntArray("infil_ambience_truck_guys", "script_noteworthy", 1);
  var_daad172ac16edf6d = getEntArray("infil_ambience_footmen", "script_noteworthy", 1);
  var_47f72555ad905cc0 = getEntArray("infil_ambience_footmen_torch", "script_noteworthy", 1);
  var_8a9247dfd5f035f = getEntArray("maint_guys_staging", "script_noteworthy", 1);
  var_57b46f520723cbf5 = getEntArray("rush_guy_1", "script_noteworthy", 1);
  var_57b46c520723c55c = getEntArray("rush_guy_2", "script_noteworthy", 1);
  var_2a74364a7908137c = getEntArray("guard_leader", "targetname", 1);
  var_acc7f3be93240850 = getEntArray("truck_prisoners_linked", "targetname", 1);
  level.courtyard_amb = utility::array_combine(infil_amb, var_58388df8f779780b, var_daad172ac16edf6d, var_47f72555ad905cc0);
  level.courtyard_amb = utility::array_combine(level.courtyard_amb, var_8a9247dfd5f035f, var_57b46f520723cbf5, var_57b46c520723c55c);
  level.courtyard_amb = utility::array_combine(level.courtyard_amb, var_2a74364a7908137c, var_acc7f3be93240850);
  waitframe();

  foreach(guy in level.courtyard_amb) {
    guy utility::add_damage_function(&function_887312ff02286036);
  }

  thread function_9e9681018dc2a57c();
  thread function_deffbbddba11196f();
  flag_wait_any("courtyard_amb_received_fail_event", "courtyard_amb_somone_not_idle");

  foreach(guy in level.courtyard_amb) {
    if(isai(guy) && isalive(guy)) {
      guy.ignoreall = 0;
      guy.favoriteenemy = level.player;
    }
  }

  if(!flag("fail_message_alert_gulag_displayed")) {
    if(flag("flag_unsuppressed_fire_in_bravo_intro")) {
      scripts\sp\player_death::set_custom_death_quote(528);
    } else {
      scripts\sp\player_death::set_custom_death_quote(522);
    }

    flag_set("fail_message_alert_gulag_displayed");
    thread function_1cf51eb6f7b2612a();
  }

  wait 2;
  utility::missionfailedwrapper();
}

function function_1cf51eb6f7b2612a() {
  wait 0.5;
  level.ally1 say("dx_sp_jvip_ecfa_koa1_wevebeenspotted");
  level.ally1 say("dx_sp_jvip_ecfa_koa1_allteamsbeadvisedalp", 0, 0, 0, 1);
}

function function_deffbbddba11196f() {
  level endon("infil_cleanup_ambience");
  var_a34542da1f8cc55c = 0;

  while(!var_a34542da1f8cc55c) {
    foreach(guy in level.courtyard_amb) {
      if(isai(guy) && isalive(guy)) {
        if(!is_equal(guy.alertlevel, "noncombat") && !is_equal(guy.targetname, "truck_prisoners_linked") && !is_equal(guy.script_noteworthy, "infil_ambience_truck_guys")) {
          var_a34542da1f8cc55c = 1;
        }
      }
    }

    waitframe();
  }

  flag_set("courtyard_amb_somone_not_idle");
}

function function_9e9681018dc2a57c() {
  level endon("infil_cleanup_ambience");

  foreach(guy in level.courtyard_amb) {
    if(issentient(guy)) {
      guy addaieventlistener("suppression");
      guy addaieventlistener("bulletwhizby");
      guy addaieventlistener("explosion");
      guy addaieventlistener("grenade danger");
      guy addaieventlistener("silenced_shot_impact");
      guy addaieventlistener("projectile_impact");
      guy addaieventlistener("gunshot_impact");
      guy thread function_caa87b522ebf5764();
    }
  }
}

function function_caa87b522ebf5764() {
  self endon("death");

  while(true) {
    self waittill("ai_events", events);

    foreach(event in events) {
      if(isDefined(event.entity) && event.entity == level.player) {
        if(isDefined(event.type) && event.type == "gunshot") {
          flag_set("flag_unsuppressed_fire_in_bravo_intro");
          return;
        }

        flag_set("courtyard_amb_received_fail_event");
        return;
      }
    }

    waitframe();
  }
}

function function_887312ff02286036(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  level endon("infil_cleanup_ambience");

  if(isPlayer(attacker)) {
    foreach(guy in level.courtyard_amb) {
      if(isai(guy) && isalive(guy)) {
        guy.ignoreall = 0;
        guy.favoriteenemy = level.player;
      }
    }

    if(!flag("fail_message_alert_gulag_displayed")) {
      scripts\sp\player_death::set_custom_death_quote(522);
      flag_set("fail_message_alert_gulag_displayed");
      thread function_1cf51eb6f7b2612a();
    }

    wait 2;
    utility::missionfailedwrapper();
  }
}

function function_208c1563362a8be3() {}

function function_6c846fc3431cc563() {
  level.player modifybasefov(65, 2, 0.5, 0.5);
  thread sp_jup_vip_lighting::function_48daccb47fb01be();
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
  namespace_9c93a5b828db4a4b::spawn_allies();
  utility::set_start_location("maintenance_start", [level.player, level.ally1, level.ally2]);
  level thread function_c6aecb595687f644();
  level.infil_allies = [level.ally1, level.ally2];
  waitframe();

  foreach(guy in level.infil_allies) {
    if(isDefined(guy)) {
      guy utility::set_ignoreall(1);
      guy demeanoroverride("cqb");
    }
  }

  utility::flag_set("flag_maint_vo_start");
}

function function_ebad221b81fb5af4() {
  level thread function_ef78e4e3897edffa();
  level thread function_e2264870ca61b52();
  level thread function_faaa7bb304a96433();
  level thread function_3277928815a5a045();
  level thread function_f73025f4d205a951();
  level thread function_d41254dec276d69d();
  level thread function_2aa96ca850238119();
  level thread function_e2ead3c025ab16ac();
  level thread function_4b27a4680b0bda9d();
  level thread function_b7f8a772dea93fa();
  level thread function_793634f97003c184();
  level thread function_b635ccfafc41a976();
  level thread maint_clean_up();
  level thread function_4d7103682cad153d();
  level thread function_99b3b03a555f022();
  level thread function_a4fd7114e7f60775();
  level thread function_647a2d3431bb9887();
  level thread function_647a2e3431bb9aba();
  level thread function_98992153cb6acf5a();
  level thread function_e70168c08d0d611();
  level thread function_4a62d19024336c52();
  level thread function_1d1aff229b5e2516();
  level thread function_df34408ff071b086();
  level thread function_7cc7dfaa66712025();
  level thread function_f356d59670e0749d();
  level thread function_ac2afbe0a151e81e();
  level thread function_d01d497a9ecb24a3();
  level thread function_cb2dfb26d25f42f();
  level thread function_22eff1c8f13bcfdd();
  level thread function_d2c7c4eaadde310f();
  level thread function_d185e9eb0b7f1061();
  utility::flag_wait("flag_obj_infil_maintenance_start");

  if(!flag("fail_message_alert_gulag_displayed")) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  utility::flag_wait("flag_infil_chopper_land");
  level notify("infil_chopper_land");

  if(!flag("fail_message_alert_gulag_displayed")) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  utility::flag_wait("flag_obj_infil_maintenance_complete");
  thread utility::autosave_by_name("Infil_complete");
  level.player setclientomnvar("ui_show_objectives", 0);
  utility::flag_set("flag_obj_reach_cells_complete");
  level thread function_f52f8d62b2111c52();

  foreach(guy in level.maint_guys) {
    if(isalive(guy)) {
      guy delete();
    }
  }

  foreach(guy in level.courtyard_reinforcements) {
    if(isalive(guy)) {
      guy delete();
    }
  }

  if(flag("flag_spawn_archway_guys")) {
    foreach(guy in level.maint_archway_guys) {
      if(isalive(guy)) {
        guy delete();
      }
    }
  }

  if(isalive(level.lmg_guy)) {
    level.lmg_guy delete();
  }

  if(isalive(level.crouch_dude)) {
    level.crouch_dude delete();
  }

  trigger_piperoom_pipe = getEnt("trigger_piperoom_pipe", "targetname");
  trigger_piperoom_pipe thread function_8716708a1bd31db3();
  level.ally1 enable_ai_color();
  level.ally2 enable_ai_color();
}

function function_1d1aff229b5e2516() {
  flag_wait("flag_alert_everyone");
  function_aa9fa9c5a97d0f6e(1);
  flag_wait("flag_player_triggered_grate_open_vo");
  function_aa9fa9c5a97d0f6e(0);
}

function function_df34408ff071b086() {
  level endon("flag_player_triggered_grate_open_vo");
  flag_wait("flag_gates_closed");
  trig_kill_maint_outsiders = getEnt("trig_kill_maint_outsiders", "targetname");
  all_guys = array_add(level.maint_guys, level.guard_leader);

  foreach(guy in all_guys) {
    if(!is_dead_or_dying(guy)) {
      if(guy istouching(trig_kill_maint_outsiders)) {
        guy kill();
      }
    }
  }
}

function function_4b27a4680b0bda9d() {
  level endon("flag_player_engaged");
  utility::flag_wait("flag_infil_to_maintenance_switch");
  utility::flag_set("infil_cleanup_ambience");
  level notify("infil_cleanup_ambience");
  level.ally1.ignoreall = 0;
  level.ally2.ignoreall = 0;
  level.var_544981c51aff7a54 = getEnt("start_goal_volume", "targetname");
  wait 0.5;
  function_64f815da552ce8c6();
  var_ca4d322daedb972b = getEnt("infil_garage_gate_blocker", "targetname");
  var_ca4d322daedb972b connectpaths();
  utility::array_spawn_function_targetname("maint_guys", &function_7b4c097220e84956);
  level.maint_guys = utility::array_spawn_targetname("maint_guys", undefined, undefined, undefined, 1);
  wait 0.2;
  utility::flag_set("flag_maint_guys_spawned");
  level notify("flag_maint_guys_spawned");
  level.prisoner_guard = spawn_targetname("prisoner_guard", 1);
  level.prisoner_guard add_damage_function(&function_3d0a0e8385ad687f);
  level.guard_leader = spawn_targetname("guard_leader", 1);
  waitframe();
  level.guard_leader thread function_428857ec62739e69();

  foreach(guy in level.maint_guys) {
    guy utility::add_damage_function(&function_3d0a0e8385ad687f);

    if(isplatformxb3() || isplatformps4()) {
      guy dontcastshadows();
    }
  }

  level.guard_leader utility::add_damage_function(&function_3d0a0e8385ad687f);
  level.maint_prisoner_truck = vehicle::spawn_vehicle_from_targetname_and_drive("maint_prisoner_truck");
  thread namespace_165c742e346e899e::function_91fc06baa8e56f0d(level.maint_prisoner_truck);
  rush_guy_1 = getEnt("rush_guy_1", "script_noteworthy");
  rush_guy_2 = getEnt("rush_guy_2", "script_noteworthy");
  waitframe();
  level.maint_guard_truck = vehicle::spawn_vehicle_from_targetname_and_drive("maint_guard_truck");
  level.maint_truck_driver = spawn_targetname("maint_truck_driver", 1);

  if(isDefined(level.maint_truck_driver) && isDefined(level.maint_guard_truck)) {
    level.maint_truck_driver ai::magic_bullet_shield(1);
    level.maint_guard_truck guy_enter(level.maint_truck_driver, 0);
    level.maint_truck_driver.ignoreme = 1;
  }

  level.maint_guard_truck function_9ce59aa48970a667();
  level.maint_guard_truck.script_allow_driver_death = 0;
  level.maint_guard_truck.vehicle_keeps_going_after_driver_dies = 1;
  level.maint_guard_truck thread function_d8ee5cc43159be12();
  level.bg_prisoners = utility::array_spawn_targetname("infil_garage_bg_prisoners");

  foreach(guy in level.bg_prisoners) {
    guy.friend_kill_points = -1200;
    guy.animname = "guy";
    org = utility::getStruct(guy.target, "targetname");
    org thread animation::anim_loop_solo(guy, "prisoner_kneel_idle");
    wait 0.05;
    org thread animation::anim_set_time_solo(guy, "prisoner_kneel_idle", randomfloatrange(0, 1));
  }

  level.truck_prisoners = utility::array_spawn_targetname("truck_prisoners_linked");

  foreach(guy in level.truck_prisoners) {
    guy.friend_kill_points = -1200;
    guy.animname = "guy";
    org = getEnt(guy.target, "targetname");
    org thread animation::anim_loop_solo(guy, "prisoner_kneel_idle");
    wait 0.05;
    org thread animation::anim_set_time_solo(guy, "prisoner_kneel_idle", randomfloatrange(0, 1));
    guy linkTo(level.maint_prisoner_truck);
    org linkTo(level.maint_prisoner_truck);
    guy.name = "";
  }

  flag_wait("flag_charlie_explosion");
  wait 5.5;
  level.ally1 thread say("dx_sp_jvip_cfgt_koa1_lightemup", 1, 0, 0, 1);
  wait 3;

  if(!is_dead_or_dying(rush_guy_1)) {
    level.ally1 utility::aim_at(rush_guy_1 getEye(), 0, undefined, 0.25);
    level.ally1 utility::link_aim_to(rush_guy_1, "tag_eye", (0, 0, 0));
    level.ally1 shoot(10, rush_guy_1 getEye());
    wait 0.1;

    if(!is_dead_or_dying(rush_guy_1)) {
      level.ally1 shoot(10, rush_guy_1 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_1)) {
      level.ally1 shoot(10, rush_guy_1 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_1)) {
      level.ally1 shoot(10, rush_guy_1 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_1)) {
      rush_guy_1 dodamage(20, rush_guy_1.origin, level.ally1, level.ally1);
      rush_guy_1 kill();
    }

    if(isDefined(level.ally1.aim_target)) {
      level.ally1.aim_target unlink();
    }

    level.ally1 utility::stop_aiming();
  }

  wait 0.25;

  if(!is_dead_or_dying(rush_guy_2)) {
    level.ally2 utility::aim_at(rush_guy_2 getEye(), 0, undefined, 0.25);
    level.ally2 utility::link_aim_to(rush_guy_2, "tag_eye", (0, 0, 0));
    level.ally2 shoot(10, rush_guy_2 getEye());
    wait 0.1;

    if(!is_dead_or_dying(rush_guy_2)) {
      level.ally2 shoot(10, rush_guy_2 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_2)) {
      level.ally2 shoot(10, rush_guy_2 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_2)) {
      level.ally2 shoot(10, rush_guy_2 getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(rush_guy_2)) {
      rush_guy_2 dodamage(20, rush_guy_2.origin, level.ally2, level.ally2);
      rush_guy_2 kill();
    }

    if(isDefined(level.ally2.aim_target)) {
      level.ally2.aim_target unlink();
    }

    level.ally2 utility::stop_aiming();
  }

  wait 1;
  flag_set("flag_maint_allies_phase_2");
  wait 1;

  if(!is_dead_or_dying(level.guard_leader)) {
    level.ally2 utility::aim_at(level.guard_leader getEye(), 0, undefined, 0.25);
    level.ally2 utility::link_aim_to(level.guard_leader, "tag_eye", (0, 0, 0));
    level.ally2 shoot(10, level.guard_leader getEye());
    level.guard_leader dodamage(20, level.guard_leader.origin, level.ally2, level.ally2);
    level.guard_leader kill();

    if(isDefined(level.ally2.aim_target)) {
      level.ally2.aim_target unlink();
    }

    level.ally2 utility::stop_aiming();
  }

  foreach(prisoner in level.bg_prisoners) {
    if(!utility::is_dead_or_dying(prisoner)) {
      prisoner delete();
    }
  }

  if(!is_dead_or_dying(level.prisoner_guard)) {
    level.prisoner_guard delete();
  }

  flag_wait("flag_maint_obj_update");
}

function function_b7f8a772dea93fa() {
  flag_wait("flag_player_engaged");
  wait 2;
  flag_wait("flag_player_in_pos_for_charlie");
  flag_set("flag_maint_allies_phase_2");

  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader.ignoreall = 0;
    level.guard_leader.ignoreme = 0;
  }

  foreach(prisoner in level.bg_prisoners) {
    if(!utility::is_dead_or_dying(prisoner)) {
      prisoner delete();
    }
  }

  if(!is_dead_or_dying(level.prisoner_guard)) {
    level.prisoner_guard delete();
  }
}

function function_4a62d19024336c52() {
  flag_wait("flag_maint_guys_spawned");
  guys = level.maint_guys;

  while(guys.size >= 4) {
    foreach(guy in guys) {
      if(is_dead_or_dying(guy)) {
        guys = array_remove(guys, guy);
      }
    }

    wait 0.2;
  }

  retreat_vol = getEnt("retreat_vol", "targetname");

  foreach(guy in level.maint_guys) {
    if(!is_dead_or_dying(guy)) {
      guy cleargoalvolume();
      guy setgoalpos(guy.origin);
      guy setgoalvolumeauto(retreat_vol);
    }
  }

  base_accuracy = level.ally1 get_baseaccuracy();
  waitframe();
  level.ally1 set_baseaccuracy(0);
  level.ally2 set_baseaccuracy(0);
  flag_wait("flag_spawn_reinforcements_phase_2");
  level.ally1 set_baseaccuracy(base_accuracy);
  level.ally2 set_baseaccuracy(base_accuracy);
}

function function_99b3b03a555f022() {
  flag_wait("flag_infil_player_at_door");
  level.ally1.ignoreall = 1;
  level.ally2.ignoreall = 1;
  level.ally1.ignoreme = 1;
  level.ally2.ignoreme = 1;
  flag_wait("flag_maint_guys_spawned");
  flag_clear("stealth_spotted");
  flag_wait_any("stealth_spotted", "flag_heli_attacked", "flag_player_engaged", "flag_charlie_explosion");
  level.ally1.ignoreall = 0;
  level.ally2.ignoreall = 0;
  level.ally1.ignoreme = 0;
  level.ally2.ignoreme = 0;
}

function function_a4fd7114e7f60775() {
  level endon("flag_player_triggered_grate_open_vo");
  flag_wait("flag_maint_allies_phase_1");
  utility::activate_trigger_with_targetname("trig_allies_down_stairs");
  flag_wait("flag_maint_allies_phase_1.5");
  utility::activate_trigger_with_targetname("trig_allies_archway_setup");
  flag_wait("flag_maint_allies_phase_2");
  utility::activate_trigger_with_targetname("trig_send_allies_into_courtyard");
  flag_wait("flag_maint_allies_phase_3");
  utility::activate_trigger_with_targetname("trig_team_advance");
  flag_wait("flag_maint_allies_phase_4");
  utility::activate_trigger_with_targetname("trig_allies_go_to_grate");
}

function maint_clean_up() {
  flag_wait("flag_maint_clean_up");
  all_guys = array_combine(level.maint_guys, level.courtyard_reinforcements);

  foreach(guy in all_guys) {
    if(!is_dead_or_dying(guy)) {
      guy delete();
    }
  }

  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader delete();
  }

  foreach(prisoner in level.bg_prisoners) {
    if(!utility::is_dead_or_dying(prisoner)) {
      prisoner delete();
    }
  }

  if(!is_dead_or_dying(level.prisoner_guard)) {
    level.prisoner_guard delete();
  }
}

function function_5ec08f58412fb03c() {
  var_1089cdb4324f9e65 = utility::spawn_tag_origin(self gettagorigin("tag_laser_attach"), self gettagangles("tag_laser_attach"));
  var_1089cdb4324f9e65 linkTo(self, "tag_laser_attach");
  playFXOnTag(utility::getfx("vfx_flashlight_npc_perf_short_vip"), self, "tag_laser_attach");
}

function function_98992153cb6acf5a() {
  flag_wait("flag_stop_player_running_away");

  if(!flag("flag_gates_closed")) {
    level.player kill();
  }
}

function function_2aa96ca850238119() {
  flag_wait("flag_maint_guys_spawned");
  flag_clear("stealth_spotted");
  flag_wait("flag_infil_chopper_land");
  flag_wait_any("stealth_spotted", "flag_player_in_pos_for_charlie", "flag_heli_attacked", "flag_player_engaged");
  flag_set("flag_send_truck_1");
  wait 2;
  flag_wait("flag_charlie_explosion");
  wait 1;
  flag_set("flag_send_truck_2");
}

function function_4d7103682cad153d() {
  flag_wait("flag_delete_truck_prisoners");
  array_delete(level.truck_prisoners);
}

function function_3277928815a5a045() {
  level.var_953787c6ba4d9b52 = getnode("explosion_lookout", "targetname");
  flag_wait("flag_explosion_time");
  thread function_8a691b483d7eec10();
  utility::flag_set("flag_call_charlie_triggered");
  level.ally1 clear_demeanor_override();
  level.ally2 clear_demeanor_override();
  level notify("charlie_explosion_setoff");
  level.player notify("called_charlie");
  utility::flag_set("flag_charlie_explosion");
  utility::flag_set("flag_begin_explosions");
  thread namespace_165c742e346e899e::function_6b72014931968dc5();
  thread maintenance_music();
  thread namespace_165c742e346e899e::function_5ef8ac1cdc725e45();
  setsaveddvar(@ "hash_ac413fc6c99ddeeb", 1);
  wait 0.5;
  level.player thread utility::actionslotoverrideremove(4);
}

function function_8a691b483d7eec10() {
  wait 1;
  side_door = getEnt("infil_garage_side_gate", "targetname");
  var_4d7523444b8b3814 = utility::getStruct("infil_garage_side_gate_sbm_end_org", "targetname");
  side_door moveTo(var_4d7523444b8b3814.origin, 1.5);
  flag_wait("flag_close_main_gate");
  garage_door = getEnt("infil_garage_door", "targetname");
  garage_door_end_org = utility::getStruct("infil_garage_door_end_org", "targetname");
  garage_door moveTo(garage_door_end_org.origin, 5);
  var_ca4d322daedb972b = getEnt("infil_garage_gate_blocker", "targetname");
  var_ca4d322daedb972b disconnectPaths();
  wait 5;
  flag_set("flag_gates_closed");
}

function function_4ff73d73ed1234a3() {
  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader anim_stopanimScripted();
  }
}

function function_d41254dec276d69d() {
  targ_1 = getEnt("bullet_target_1", "targetname");
  targ_2 = getEnt("bullet_target_2", "targetname");
  targ_3 = getEnt("bullet_target_3", "targetname");
  targ_4 = getEnt("bullet_target_4", "targetname");
  targ_5 = getEnt("bullet_target_5", "targetname");
  targ_6 = getEnt("bullet_target_6", "targetname");
  targ_7 = getEnt("bullet_target_7", "targetname");
  targ_8 = getEnt("bullet_target_8", "targetname");
  targ_9 = getEnt("bullet_target_9", "targetname");
  targ_10 = getEnt("bullet_target_9", "targetname");
  mg_pos = getStruct("maint_mg_nest_struct", "targetname");
  flag_wait("flag_player_triggered_grate_open_vo");
  wait 3.6;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_5.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_5.origin);
  wait 0.1;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_6.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_6.origin);
  wait 0.3;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_8.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_8.origin);
  wait 0.1;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_9.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_9.origin);
  wait 0.2;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_1.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_1.origin);
  wait 0.4;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_2.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_2.origin);
  wait 0.2;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_3.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_3.origin);
  wait 0.1;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_4.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_4.origin);
  wait 0.1;
  magicbullet("iw9_mg_jltv_sp", mg_pos.origin, targ_10.origin);
  magicbullet("iw8_sn_hdromeo", mg_pos.origin, targ_10.origin);
}

function function_d5160af72ff5fbfb() {
  level.player setclientomnvar("ui_show_objectives", 1);
  wait 5;
  level.player setclientomnvar("ui_show_objectives", 0);
}

function function_647a2d3431bb9887() {
  level endon("flag_obj_infil_maintenance_complete");
  flag_wait("flag_maint_guys_spawned");
  level.maint_combat_end_vol = getEnt("maint_combat_end_vol", "targetname");
  waitframe();
  guys = level.maint_guys;

  while(guys.size >= 3 && !flag("flag_force_spawn_reinforcements")) {
    foreach(guy in guys) {
      if(is_dead_or_dying(guy)) {
        guys = array_remove(guys, guy);
      }
    }

    wait 0.5;
  }

  flag_wait_any("flag_spawn_reinforcements", "flag_force_spawn_reinforcements");
  flag_set("flag_maint_allies_phase_3");
  level.courtyard_reinforcements = utility::array_spawn_targetname("courtyard_reinforcements");
  flag_set("flag_spawn_reinforcements_phase_2");

  foreach(guy in level.courtyard_reinforcements) {
    guy thread function_5ec08f58412fb03c();
    guy.goalradius = 16;

    if(isplatformxb3() || isplatformps4()) {
      guy dontcastshadows();
    }
  }

  waitframe();
  shotgun_guys = getEntArray("shotgun_guy", "script_noteworthy");

  foreach(guy in shotgun_guys) {
    guy.dropweapon = 0;
  }

  guys = level.courtyard_reinforcements;

  while(guys.size >= 3) {
    foreach(guy in guys) {
      if(is_dead_or_dying(guy)) {
        guys = array_remove(guys, guy);
      }
    }

    waitframe();
  }

  guys = array_removedead_or_dying(guys);

  if(guys.size > 0) {
    foreach(guy in guys) {
      if(!is_dead_or_dying(guy)) {
        guy cleargoalvolume();
        guy setgoalvolumeauto(level.maint_combat_end_vol);
        guy getenemyinfo(level.player);
        guy set_favoriteenemy(level.player);
      }
    }
  }

  while(guys.size >= 1) {
    foreach(guy in guys) {
      if(is_dead_or_dying(guy)) {
        guys = array_remove(guys, guy);
      }
    }

    waitframe();
  }

  thread function_dcd5e20a000a2f3e();
  flag_set("flag_maint_allies_phase_4");
  wait 3;
  flag_set("flag_level_2_guys_check_end");

  if(isalive(level.lmg_guy)) {
    level.ally2 utility::aim_at(level.lmg_guy getEye(), 0, undefined, 0.25);
    level.ally2 utility::link_aim_to(level.lmg_guy, "tag_eye", (0, 0, 0));
    level.ally2 shoot(10, level.lmg_guy getEye());
    wait 0.1;

    if(!is_dead_or_dying(level.lmg_guy)) {
      level.ally2 shoot(10, level.lmg_guy getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.lmg_guy)) {
      level.ally2 shoot(10, level.lmg_guy getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.lmg_guy)) {
      level.ally2 shoot(10, level.lmg_guy getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.lmg_guy)) {
      level.lmg_guy dodamage(20, level.lmg_guy.origin, level.ally2, level.ally2);
    }

    if(isDefined(level.ally2.aim_target)) {
      level.ally2.aim_target unlink();
    }

    if(isalive(level.lmg_guy)) {
      level.lmg_guy kill();
    }

    level.ally2 stop_aiming();
  }

  wait 1;

  if(isalive(level.crouch_dude)) {
    level.ally1 utility::aim_at(level.crouch_dude getEye(), 0, undefined, 0.25);
    level.ally1 utility::link_aim_to(level.crouch_dude, "tag_eye", (0, 0, 0));
    level.ally1 shoot(10, level.crouch_dude getEye());
    wait 0.1;

    if(!is_dead_or_dying(level.crouch_dude)) {
      level.ally1 shoot(10, level.crouch_dude getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.crouch_dude)) {
      level.ally1 shoot(10, level.crouch_dude getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.crouch_dude)) {
      level.ally1 shoot(10, level.crouch_dude getEye());
    }

    wait 0.1;

    if(!is_dead_or_dying(level.crouch_dude)) {
      level.crouch_dude dodamage(20, level.crouch_dude.origin, level.ally1, level.ally1);
    }

    if(isDefined(level.ally1.aim_target)) {
      level.ally1.aim_target unlink();
    }

    if(isalive(level.crouch_dude)) {
      level.crouch_dude kill();
    }

    level.ally1 stop_aiming();
  }

  wait 0.5;
  flag_set("flag_ally_hatch_vo");
  thread function_d5160af72ff5fbfb();
}

function function_dcd5e20a000a2f3e() {
  level endon("flag_level_2_guys_check_end");

  while(!is_dead_or_dying(level.lmg_guy) || !is_dead_or_dying(level.crouch_dude)) {
    waitframe();
  }

  wait 0.5;
  flag_set("flag_ally_hatch_vo");
}

function function_e70168c08d0d611() {
  level endon("flag_obj_infil_maintenance_complete");
  flag_wait("flag_spawn_archway_guys");
  level.maint_archway_guys = array_spawn_targetname("maint_archway_guys");

  foreach(guy in level.maint_archway_guys) {
    guy thread function_5ec08f58412fb03c();
    guy thread function_9ed4477124ab39e5();
  }
}

function function_9ed4477124ab39e5() {
  flag_wait("flag_player_outside");

  if(!is_dead_or_dying(self)) {
    self kill();
  }
}

function function_647a2e3431bb9aba() {
  flag_wait("flag_spawn_reinforcements_phase_2");
  wait 4;
  level.crouch_dude = spawn_targetname("crouch_dude");
  level.crouch_dude.goalradius = 16;
  level.crouch_dude thread function_5ec08f58412fb03c();
  level.lmg_guy = spawn_targetname("lmg_guy");
  level.lmg_guy.goalradius = 16;
  level.lmg_guy thread function_5ec08f58412fb03c();
  flag_set("flag_reinforcements_phase_2_vo");
}

function function_faaa7bb304a96433() {
  utility::flag_wait("flag_infil_chopper_land");
  level.heli = vehicle::spawn_vehicle_from_targetname("infil_garage_chopper");
  vehicle_build::build_treadfx(level.heli.classname_mp, "default", "vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_tread_water.vfx", 1);
  thread namespace_165c742e346e899e::function_3024fd1bd3bebfe();
  level.heli thread function_d8ee5cc43159be12();
  level.spotlight_org = getEnt("infil_garage_chopper_spotlight_org", "targetname");
  level.spotlight_org.origin += (0, 30, -5);
  level.spotlight_org linkTo(level.heli);
  level.spotlight_org thread function_9ac92350fe8bc8ab(level.heli);
  wait 2.5;
  thread namespace_165c742e346e899e::function_45f94918253b138a();
  level.heli thread vehicle_paths::gopath();
  playFXOnTag(getfx("vfx_vip_heli_light_cockpit"), level.heli, "tag_ik_loc_ri_seat_0");
  playFXOnTag(getfx("vfx_vip_heli_lights_blinkies"), level.heli, "body_animate_jnt");
  level thread function_2d345777a1e35c00();
  utility::flag_wait("flag_charlie_explosion");
  wait 1.5;
  startnode = utility::getStruct("infil_garage_chopper_peel_start_node", "targetname");
  level.heli thread vehicle::vehicle_paths(startnode);
  thread namespace_165c742e346e899e::function_f3657f158f212b7d();
  vehicle_paths::gopath(level.heli);
}

function function_2d345777a1e35c00() {
  flag_wait("vip_fov_maintenance_piperoom_enter");
  killfxontag(getfx("vfx_vip_heli_light_cockpit"), level.heli, "tag_ik_loc_ri_seat_0");
  killfxontag(getfx("vfx_vip_heli_lights_blinkies"), level.heli, "body_animate_jnt");
}

function function_428857ec62739e69() {
  self endon("death");
  utility::set_grenadeammo(0);
  self.ignoreall = 1;
  thread function_5ec08f58412fb03c();

  if(isplatformxb3() || isplatformps4()) {
    self dontcastshadows();
  }

  flag_wait_any("flag_charlie_explosion", "flag_alert_everyone");
  utility::enable_stealth_for_ai(0);
  demeanor_override("combat");

  if(!is_dead_or_dying(level.guard_leader) && !flag("flag_alert_everyone")) {
    level.guard_leader.animname = "guy";
    animnode = getStruct("guard_leader_anim_struct", "targetname");
    animnode anim_reach_solo(level.guard_leader, "est_cy_enemy_alarmed02");
    animnode thread anim_single_solo(level.guard_leader, "est_cy_enemy_alarmed02");
    level.guard_leader waittill("damage");
    function_4ff73d73ed1234a3();

    if(!is_dead_or_dying(level.guard_leader)) {
      level.guard_leader.ignoreall = 0;
      level.guard_leader.ignoreme = 0;
    }
  }
}

function function_7b4c097220e84956() {
  self endon("death");
  utility::set_grenadeammo(0);
  thread function_5ec08f58412fb03c();
  self.ignoreme = 0;
  self.ignoreall = 0;

  while(!flag("flag_charlie_explosion")) {
    if(!is_equal(self.alertlevel, "noncombat")) {
      wait 1;
      flag_set("flag_alert_everyone");
      break;
    }

    waitframe();
  }

  if(!flag("flag_player_engaged")) {
    if(isDefined(self.animname) && self.animname == "walkway_guy") {
      if(!is_dead_or_dying(self)) {
        self setgoalnode(level.var_953787c6ba4d9b52);
      }
    }
  }

  while(!is_dead_or_dying(self) && !flag("flag_alert_everyone")) {
    self demeanoroverride("combat");
    waitframe();
  }
}

function function_bd34af163126bc92() {
  courtyard_combat_vol = getEnt("courtyard_combat_vol", "targetname");
  flag_wait("flag_player_in_courtyard");

  foreach(guy in level.maint_guys) {
    if(!is_dead_or_dying(guy)) {
      guy setgoalvolumeauto(courtyard_combat_vol);
    }
  }
}

function function_793634f97003c184() {
  flag_wait("flag_player_outside");

  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader.ignoreall = 0;
  }

  flag_set("flag_player_engaged");
  thread function_8a691b483d7eec10();
  thread function_4ff73d73ed1234a3();

  foreach(guy in level.maint_guys) {
    if(!is_dead_or_dying(guy)) {
      guy utility::enable_stealth_for_ai(0);
      guy setgoalvolumeauto(level.var_544981c51aff7a54);
    }
  }
}

function function_3d0a0e8385ad687f(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  if(!flag("flag_player_engaged")) {
    if(isPlayer(attacker)) {
      utility::flag_set("flag_alert_everyone");
    }
  }
}

function function_e2ead3c025ab16ac() {
  utility::flag_wait("flag_alert_everyone");

  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader.ignoreall = 0;
    level.guard_leader setgoalvolumeauto(level.var_544981c51aff7a54);
  }

  flag_set("flag_player_engaged");
  function_aa9fa9c5a97d0f6e(1);
  thread function_8a691b483d7eec10();
  thread function_4ff73d73ed1234a3();

  foreach(guy in level.maint_guys) {
    if(!is_dead_or_dying(guy)) {
      guy utility::enable_stealth_for_ai(0);
      guy.ignoreall = 0;
      guy setgoalvolumeauto(level.var_544981c51aff7a54);
    }
  }
}

function function_b635ccfafc41a976() {
  flag_wait("flag_maint_guys_spawned");
  utility::waittill_any_ents_array(level.maint_guys, "suppression", "bulletwhizby", "grenade danger", "explosion");
  utility::flag_set("flag_alert_everyone");
}

function function_d8ee5cc43159be12() {
  self waittill("damage");
  flag_set("flag_alert_everyone");
}

function function_bf4da5e644e35955() {
  utility::flag_set("flag_obj_infil_maintenance_start");
  utility::flag_set("flag_maint_obj_update");
  utility::flag_set("flag_obj_infil_maintenance_complete");
  utility::flag_set("flag_obj_infil__pipe_room_complete");
  utility::flag_set("flag_obj_infil_descend_begin");
  utility::flag_set("flag_obj_synch_with_bravo");
  utility::flag_set("flag_start_sync_vo");
  utility::flag_set("flag_call_charlie");
  utility::flag_set("flag_call_charlie_triggered");
  utility::flag_set("vip_fov_maintenance_squeezy_stairs_exit");
  utility::flag_set("vip_fov_maintenance_piperoom_enter");
  clearmusicstate();
  setmusicstate("mx_vip_maintenance");
}

function function_e5dfbc0e24d4c85() {
  maint_breach_door = getStruct("maint_breach_door", "script_noteworthy");
  maint_breach_door waittill("trigger");
  flag_set("player_tried_breach_door");
  wait 0.5;
  level.player say("dx_sp_jvip_cprp_koa2_doorslocked");
  level.ally1 say("dx_sp_jvip_cprp_koa1_rogonit", 0, 0, 0, 0.5);
  flag_set("player_tried_breach_door_vo_finished");
}

function function_ac2afbe0a151e81e() {
  function_64f815da552ce8c6();
  level endon("flag_break_stealth_vo");
  thread function_e5dfbc0e24d4c85();
  utility::flag_wait("flag_infil_vo_lockpick");

  if(!flag("player_tried_breach_door")) {
    level.ally1 say("dx_sp_jvip_cprp_koa1_movinginterior", 0, 0, 0, 0);
  } else {
    flag_wait("player_tried_breach_door_vo_finished");
  }

  if(flag("player_tried_breach_door")) {
    level.ally1 say("dx_sp_jvip_cprp_koa1_gotit", 0, 0, 0, 1.5);
  }

  level.ally1 dialogue::say("dx_sp_jvip_cprp_koa1_allclear", 0, 0, 0, 5.5);
  wait 3;
  close_distance = 240;
  var_3c936353c5d4bba4 = distance(level.player.origin, level.ally1.origin);
  var_8696003fa30953f4 = var_3c936353c5d4bba4 < close_distance;

  if(var_8696003fa30953f4) {
    level.player dialogue::say("dx_sp_jvip_cprp_koa2_descendingsouthstair", 0, 0, 0, 0);
  } else {
    wait_time = function_4fba9e11ee207d7c("dx_sp_jvip_cprp_koa2_descendingsouthstair");
    wait wait_time;
  }

  level.ally1 dialogue::say("dx_sp_jvip_cprp_koa1_allshootersbeadvised", 0, 0, 0, 3);
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_cprp_kob1_copywereheadsup");
  level.player.vo_handler dialogue::say("dx_sp_jvip_cprp_kob1_copywereheadsup", 0, 0, 0, 1);
  utility::flag_wait("flag_nods_off");

  if(nvg_player::is_nvg_on()) {
    utility::display_hint("nvg_hint", 60, 0, level.player, "night_vision_off");
    level.ally1 dialogue::say("dx_sp_jvip_cprp_koa1_nodsoff", 0, 0, 0, 0.5);
  }

  level.player dialogue::say("dx_sp_jvip_cprp_koa2_movementinthecourtya", 0, 0, 0, 1);
  level.ally1 dialogue::say("dx_sp_jvip_cprp_koa1_notourguyonme", 0, 0, 0, 0.5);
  level.ally1 dialogue::say("dx_sp_jvip_main_koa1_weholdforcharlietoli", 0, 0, 0, 1);
  thread function_d5160af72ff5fbfb();
  level.ally1 say("dx_sp_jvip_cprp_koa1_holduphere", 0, 0, 0, 0.5);
  flag_wait("flag_player_in_pos_for_charlie");
  level.ally1 dialogue::say("dx_sp_jvip_cprp_koa1_allteamsalphasinposi", 0, 0, 0, 0.5);
  flag_set("flag_kill_early_charlie");
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_cprp_kob1_copybravoset");
  level.player.vo_handler dialogue::say("dx_sp_jvip_cprp_kob1_copybravoset", 0, 0, 0, 1);
  dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_cprp_koc1_charliegoodtogo");
  level.player.vo_handler dialogue::say("dx_sp_jvip_cprp_koc1_charliegoodtogo", 0, 0, 0, 1);
  level.ally1 say("dx_sp_jvip_chpr_koa1_fireintheholestandby", 0, 0, 0, 1);
  flag_set("flag_charlie_countdown");
}

function function_d01d497a9ecb24a3() {
  flag_wait("flag_maint_guys_spawned");
  flag_clear("stealth_spotted");
  flag_wait_any("flag_player_engaged", "stealth_spotted");

  if(!flag("flag_kill_early_charlie")) {
    flag_set("flag_break_stealth_vo");

    if(istrue(level.ally1.is_talking)) {
      stop_talking(level.ally1);
    }

    if(istrue(level.ally2.is_talking)) {
      stop_talking(level.ally2);
    }

    wait 0.5;
    level.ally1 dialogue::say("dx_sp_jvip_chpr_koa1_goinghotcharliegofor", 1, 0, 0, 0);
    dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_chpr_koc1_roger");
    level.player.vo_handler dialogue::say("dx_sp_jvip_chpr_koc1_roger", 1, 0, 0, 0.5);
    wait 1;
    flag_set("flag_explosion_time");
  }
}

function function_cb2dfb26d25f42f() {
  flag_wait("flag_charlie_countdown");
  thread dialogue::function_4495922f7faaffe7(100, "dx_sp_jvip_chpr_koc1_321execute");
  level.player.vo_handler thread dialogue::say("dx_sp_jvip_chpr_koc1_321execute", 0, 0, 0, 1);
  wait 3;
  utility::flag_set("flag_explosion_time");
  wait 1.5;

  if(!flag("flag_player_engaged")) {
    level.player say("dx_sp_jvip_cfgt_koa2_theyretakingthebait", 0, 0, 0, 1);
  }

  wait 1;

  if(!is_dead_or_dying(level.guard_leader)) {
    level.guard_leader say("dx_sp_jvip_cfgt_vipg_lockeverythingdownyo", 1, 0, 0, 1);
  }
}

function function_22eff1c8f13bcfdd() {
  flag_wait("flag_spawn_reinforcements_phase_2");
  var_9f0c1fef4e1cc025 = randomintrange(1, 4);

  if(var_9f0c1fef4e1cc025 == 1) {
    level.ally1 say("dx_sp_jvip_enre_koa1_hostilesincoming");
  } else if(var_9f0c1fef4e1cc025 == 2) {
    level.ally1 say("dx_sp_jvip_enre_koa1_reinforcements");
  } else if(var_9f0c1fef4e1cc025 == 3) {
    level.ally1 say("dx_sp_jvip_enre_koa1_enemiesincoming");
  }

  flag_wait("flag_reinforcements_phase_2_vo");
  var_91f92b128d6934b4 = randomintrange(1, 3);

  if(var_91f92b128d6934b4 == 1) {
    level.ally1 dialogue::say("dx_sp_jvip_enwi_koa1_shooterssecondfloorw", 0, 0, 0, 1);
  } else if(var_91f92b128d6934b4 == 2) {
    level.ally1 dialogue::say("dx_sp_jvip_enwi_koa3_targetsinthewindows", 0, 0, 0, 1);
  }

  var_91f92c128d6936e7 = randomintrange(1, 3);

  if(var_91f92c128d6936e7 == 1) {
    level.player say("dx_sp_jvip_enwi_koa2_rogerwindows", 0, 0, 0, 1);
  } else if(var_91f92c128d6936e7 == 2) {
    level.player say("dx_sp_jvip_enwi_koa2_copythat", 0, 0, 0, 1);
  }

  flag_wait("flag_ally_hatch_vo");
  level.ally1 dialogue::say("dx_sp_jvip_reac_koa1_clear", 0, 0, 0, 0);
  level.ally1 dialogue::say("dx_sp_jvip_chch_koa1_21rallyatthehatchfor", 0, 0, 0, 1.5);
  flag_set("flag_battle_vo_over");
}

function function_d185e9eb0b7f1061() {
  utility::flag_wait("flag_player_triggered_grate_open_vo");
  thread function_f99a810f0b55d952();

  if(istrue(level.ally1.is_talking)) {
    stop_talking(level.ally1);
  }

  if(istrue(level.ally2.is_talking)) {
    stop_talking(level.ally2);
  }

  wait 1;
  level.player say("dx_sp_jvip_chch_koa2_enemiesincominggetun", 1, 0, 0, 1);
  level.ally1 say("dx_sp_jvip_cfgt_koa1_onmemove", 1, 0, 0, 1);
  utility::flag_wait("flag_obj_infil_maintenance_complete");
  function_64f815da552ce8c6();
  level.ally1 dialogue::say("dx_sp_jvip_cbar_koa1_bravoalphasinthetunn", 0, 0, 0, 2);
  level.player.vo_handler dialogue::say("dx_sp_jvip_cbar_kob1_outsidethecontrolroo", 0, 0, 0, 0.5);
  level.ally1 dialogue::say("dx_sp_jvip_cbar_koa1_copyatthegatestandby", 0, 0, 0, 1);
}

function function_92dacc5765d444a5() {
  flag_wait("stealth_spotted");
  flag_set("flag_player_engaged");
}

function function_d2c7c4eaadde310f() {
  level endon("flag_player_triggered_grate_open_vo");
  flag_wait_all("flag_hatch_nags", "flag_battle_vo_over");

  while(true) {
    wait 3;
    level.ally1 dialogue::say("dx_sp_jvip_chch_koa1_waitinonyouatthehatc", 1, 0, 0, 1);
    wait 5;

    if(!flag("flag_obj_pinged")) {
      display_hint("focus_hint", undefined, 0, level, "flag_player_triggered_grate_open_vo");
    }

    flag_set("flag_obj_pinged");
    level.ally2 dialogue::say("dx_sp_jvip_chgn_koa3_entrypointisthehatch", 1, 0, 0, 1);
    wait 5;
    level.ally1 dialogue::say("dx_sp_jvip_chon_koa1_21popthehatchnowwego", 1, 0, 0, 1);
    wait 5;
    level.ally1 dialogue::say("dx_sp_jvip_chon_koa1_onyou21getitopen", 1, 0, 0, 1);
  }
}

function maintenance_music() {
  setmusicstate("mx_vip_maintenance");
}

function function_f99a810f0b55d952() {
  wait 0.5;
  stopmusicstate("mx_vip_maintenance");
}

function function_6c23eae5541f704f() {}

function function_ee31bb4c23aa0803() {
  wait 1;
  fx_org = utility::spawn_tag_origin();
  start_ang = fx_org.angles;
  playFXOnTag(utility::getfx("vfx_hind_spotlight"), fx_org, "tag_origin");

  while(!utility::flag("vip_fov_maintenance_piperoom_enter")) {
    rot_x = randomfloatrange(1, 8);

    if(utility::cointoss()) {
      rot_x *= -1;
    }

    rot_y = randomfloatrange(1, 8);

    if(utility::cointoss()) {
      rot_y *= -1;
    }

    rot_z = randomfloatrange(1, 8);

    if(utility::cointoss()) {
      rot_z *= -1;
    }

    time = randomfloatrange(0.25, 1.5);
    fx_org rotateTo(start_ang + (rot_x, rot_y, rot_z), time, time * 0.25, time * 0.25);
    wait randomfloatrange(time, time * 2);
  }

  wait 1;
  stopFXOnTag(utility::getfx("vfx_hind_spotlight"), fx_org, "tag_origin");
}

function function_9ac92350fe8bc8ab(heli) {
  wait 0.5;
  fx_org = utility::spawn_tag_origin();
  playFXOnTag(utility::getfx("vfx_hind_spotlight"), fx_org, "tag_origin");
  targ = getEnt("infil_garage_heli_spotlight_targ", "targetname");
  targ thread function_e541602d4ead089b("infil_garage_heli_start_spotlight_locs");
  thread function_98aafd49125770a6(fx_org, targ);
  utility::flag_wait("flag_charlie_explosion");
  wait 2.5;
  targ thread function_e541602d4ead089b("infil_garage_heli_spotlight_locs");
  utility::flag_wait("vip_fov_maintenance_piperoom_enter");
  level notify("infil_heli_stop_targeting");
  wait 1;
  killfxontag(utility::getfx("vfx_hind_spotlight"), fx_org, "tag_origin");
  fx_org delete();
  heli delete();
}

function function_98aafd49125770a6(fx_org, targ) {
  while(true) {
    if(flag("flag_player_triggered_grate_open_vo")) {
      break;
    }

    fx_org.origin = self.origin;
    dir = targ.origin - fx_org.origin;
    rot = vectortoangles(dir);
    fx_org.angles = rot;
    waitframe();
  }
}

function function_e541602d4ead089b(var_dcb0b6d89c18eb6e, optional_ents) {
  level endon("infil_heli_stop_targeting");
  locs = utility::getStructArray(var_dcb0b6d89c18eb6e, "targetname");

  while(true) {
    if(flag("flag_player_triggered_grate_open_vo")) {
      break;
    }

    move_time = randomfloatrange(0.5, 1.5);
    self moveTo(utility::random(locs).origin, move_time, move_time * 0.25, move_time * 0.25);
    wait randomfloatrange(1.5, 3);
  }
}

function function_6f453752e8bf2365(time) {
  self endon("death");
  wait time;

  if(!utility::is_dead_or_dying(self)) {
    self delete();
  }
}

function function_f52f8d62b2111c52() {
  pipe_gate = getEnt("infil_pipe_gate", "targetname");
  ents = getEntArray(pipe_gate.target, "targetname");

  foreach(ent in ents) {
    ent hide();
    ent delete();
  }

  pipe_gate hide();
  pipe_gate delete();
  waitframe();
  interact_struct = utility::getStruct("infil_pipe_gate_interact", "targetname");
  level.player thread namespace_165c742e346e899e::function_d89fe7f8e99f072e();
  interact_struct cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_VIP/INTERACT_OPEN_GATE", undefined, 600, 60, 1);
  interact_struct waittill("trigger");
  thread function_fe3e08bf9670b880();
  level.player val::set("gulag_descend", "allow_movement", 0);
  level.player function_5ee68a5b461ab5b8(1);
  namespace_9c3faffc064160e8::function_7b2743af8410b08e();
  clip_descend_vent_door = getEnt("clip_descend_vent_door", "targetname");
  clip_descend_vent_door hide();
  clip_descend_vent_door delete();
  thread namespace_165c742e346e899e::function_33dd9108ce8fd72e();
  weaplist = level.player getweaponslistprimaries();

  foreach(weaponobject in weaplist) {
    level.player givemaxammo(weaponobject);
  }

  level.player val::set("gulag_infil", "crouch", 1);
  level.player val::set("gulag_infil", "prone", 1);
  level.player val::set("gulag_infil", "stand", 1);
  level.player val::set("gulag_infil", "sprint", 1);
  level.player val::set("gulag_infil", "supersprint", 1);
  setsaveddvar(@ "hash_37e882c5f9efc349", "1");
  utility::flag_set("flag_descend_start_anim");
}

function function_62d83dcf709eb185() {
  self endon("death");
  self.ignoreall = 0;
  utility::flag_wait("infil_cleanup_ambience");

  if(!utility::is_dead_or_dying(self)) {
    waitframe();
    self delete();
  }
}

function function_c9fc09b9bab7a4b4() {
  self endon("death");
  utility::flag_wait("flag_truck_reached");
  wait 3.5;

  if(!utility::is_dead_or_dying(self)) {
    waitframe();
    self delete();
  }
}

function function_5b42349675f58a2d() {
  self endon("death");
  utility::flag_wait("infil_cleanup_ambience");

  if(!utility::is_dead_or_dying(self)) {
    waitframe();
    self delete();
  }
}

function function_6d702914762e1c72() {
  start_node = getnode(self.target, "targetname");
  end_node = getnode(start_node.target, "targetname");

  while(true) {
    self setgoalnode(end_node);
    self waittill("goal");
    self forceteleport(start_node.origin, start_node.angles);
    waitframe();
  }
}

function function_d35ab83927d91418() {
  utility::flag_set("flag_alpha_container_pos");
  utility::flag_set("flag_obj_reach_cells_activate");
  utility::flag_set("flag_obj_infil_wall_complete");
  utility::flag_set("flag_allies_callout_obective");
  utility::flag_set("flag_obj_synch_with_bravo");
  utility::flag_set("finished_bravo_stair_animation");
  utility::flag_set("flag_allies_to_maint_breach");
  utility::flag_set("flag_ally_at_door_node_1");
  utility::flag_set("flag_ally_at_door_node_2");
  utility::flag_set("vip_fov_wallascend_top_of_wall");
  utility::flag_set("flag_ally1_bravo_intro_finished");
  utility::flag_set("flag_ally2_bravo_intro_finished");
  clearmusicstate();
  setmusicstate("mx_vip_infil");
}

function function_880d72bf3a1e2b0b() {
  level.player endon("death");
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");

  while(!level.player utility::ent_flag_exist("stealth_use_real_lighting")) {
    waitframe();
  }

  setomnvar("ai_fulllight", 0.005);
  setomnvar("ai_nolight", 7e-05);
  hiddenranges["prone"] = 100;
  hiddenranges["crouch"] = 300;
  hiddenranges["stand"] = 550;
  var_b6b642cbeff52b88["prone"] = 50;
  var_b6b642cbeff52b88["crouch"] = 150;
  var_b6b642cbeff52b88["stand"] = 200;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 200;
  spottedranges["crouch"] = 600;
  spottedranges["stand"] = 800;
  var_d0f35fc0a5c3df79["prone"] = 150;
  var_d0f35fc0a5c3df79["crouch"] = 200;
  var_d0f35fc0a5c3df79["stand"] = 400;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
  function_531194f673a06de5(1);
  function_d5823c94e8131ea6(1);
  event_distances["spotted"]["explosion"] = 2500;
  event_distances["hidden"]["explosion"] = 2500;
  event_distances["spotted"]["gunshot"] = 2500;
  event_distances["hidden"]["gunshot"] = 2500;
  manager::set_custom_distances(event_distances);
}

function function_a3ccc1eae6406d88() {}

function function_2ccfd6fd7896c60a() {
  level.player modifybasefov(80, 1, 0.1, 0.1);
  thread sp_jup_vip_lighting::cp_descend();
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
  utility::set_start_location("descend", [level.player]);
  thread namespace_165c742e346e899e::function_81dcf0a672ccda1d();
  thread namespace_165c742e346e899e::function_fc02814045757b93();
  namespace_9c93a5b828db4a4b::spawn_allies();
  level thread function_c6aecb595687f644();
  thread function_f52f8d62b2111c52();
  trigger_piperoom_pipe = getEnt("trigger_piperoom_pipe", "targetname");
  trigger_piperoom_pipe thread function_8716708a1bd31db3();
  level.player setstance("crouch", undefined, 1, 1);
}

function function_8716708a1bd31db3() {
  jump_enabled = 1;

  while(true) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      if(jump_enabled == 1) {
        level.player val::set("gulag_descend", "allow_jump", 0);
        jump_enabled = 0;
        level.player scripts\sp\player::player_movement_state("cqb");
        level.player val::set("gulag_descend", "prone", 0);
        level.player val::set("gulag_descend", "sprint", 0);
        level.player val::set("gulag_descend", "supersprint", 0);
      }

      waitframe();
    }

    if(jump_enabled == 0) {
      level.player val::set("gulag_descend", "allow_jump", 1);
      jump_enabled = 1;

      if(!utility::flag("flag_descend_start_anim")) {
        level.player scripts\sp\player::player_movement_state("default");
        level.player val::set("gulag_descend", "sprint", 1);
        level.player val::set("gulag_descend", "supersprint", 1);
        level.player val::set("gulag_descend", "crouch", 0);
        level.player val::set("gulag_descend", "prone", 0);
        waitframe();
        level.player val::reset_all("gulag_descend");
      }
    }
  }
}

function function_de4d8de6db88efb0(var_d82d2d6af1b9401b) {
  if(!isDefined(var_d82d2d6af1b9401b)) {
    var_d82d2d6af1b9401b = 65;
  }

  while(!flag("flag_end_descend")) {
    player_pos = level.player.origin;
    var_69cc6029f1b7c73d = getStruct("descender_toptop", "targetname");
    top_struct = getStruct("descender_top", "targetname");
    middle_struct = getStruct("descender_middle", "targetname");
    var_f32fef35fb09a91a = var_d82d2d6af1b9401b;
    var_91f5f6e46f91dac7 = 60;

    if(player_pos[2] > var_69cc6029f1b7c73d.origin[2]) {
      var_f32fef35fb09a91a = 0;
    } else if(player_pos[2] >= middle_struct.origin[2] && player_pos[2] <= var_69cc6029f1b7c73d.origin[2]) {
      delta = math::normalize_value(middle_struct.origin[2], var_69cc6029f1b7c73d.origin[2], player_pos[2]);
      delta = 1 - delta;
      var_f32fef35fb09a91a = math::factor_value(0, var_d82d2d6af1b9401b, delta);
    }

    fraction = level.player function_c39d905ff4845368();

    if(fraction >= 0.9) {
      delta = math::normalize_value(0.9, 0.99, fraction);
      var_91f5f6e46f91dac7 = math::factor_value(60, 20, delta);
    }

    setsaveddvar(@ "hash_83c5677c88e07e0a", var_f32fef35fb09a91a);
    setsaveddvar(@ "hash_7445fe65361a3214", var_91f5f6e46f91dac7);
    waitframe();
  }

  setsaveddvar(@ "hash_83c5677c88e07e0a", 90);
  setsaveddvar(@ "hash_7445fe65361a3214", 70);
}

function function_84facbc07f411f7b() {
  level.var_1abd3d4b293ec222 = 0;
  weaplist = level.player getweaponslistprimaries();

  foreach(weaponobject in weaplist) {
    level.player givemaxammo(weaponobject);
  }

  utility::flag_set("flag_obj_reach_descend_activate");
  utility::flag_set("vip_fov_cellblockdescend_pipe_enter");
  setdvarifuninitialized(@ "hash_2d59deb63c029ea8", 0);
  setsaveddvar(@ "hash_e25973f21baa3bad", 1);
  setsaveddvar(@ "hash_342c89634f966b1", 1);
  setsaveddvar(@ "hash_1c2634c4ee0cf540", 0);
  setsaveddvar(@ "hash_7c3ea2f8e170a3ff", 0);
  setsaveddvar(@ "hash_c5cc81fb17510582", 1);
  setsaveddvar(@ "hash_3a3e29ebd15066e3", 1);
  setsaveddvar(@ "hash_6f8523c84d674426", 1.1);
  setsaveddvar(@ "hash_aca865842d98d3cf", 1.1);
  setsaveddvar(@ "hash_b73a33ae3fb3c304", 200);
  setsaveddvar(@ "hash_129e2d55f32364d4", 733);
  setsaveddvar(@ "hash_baf6e0fabc914e0d", 866);
  setsaveddvar(@ "hash_15392c9f5b4c9bd8", 1066);
  setsaveddvar(@ "hash_184d64f1e31f1e47", 1433);
  setsaveddvar(@ "hash_dfad421081d60b84", 1);
  setsaveddvar(@ "hash_21604faac3da1d0d", 10.5);
  setsaveddvar(@ "hash_cd0e097b9db91f40", -11);
  setsaveddvar(@ "hash_b35ca2379cf300c4", 300);
  setsaveddvar(@ "hash_5184d01d415afae3", 1);
  setsaveddvar(@ "hash_49a61061b237bca9", 1);
  setsaveddvar(@ "hash_d16bf47081fecac5", 1);
  thread function_de4d8de6db88efb0(65);
  setsaveddvar(@ "hash_7445fe65361a3214", 60);
  setsaveddvar(@ "hash_5d9690d1b87f2da7", 15);
  thread function_9c660c7238d7e120();
  thread function_9346a90b6e9a603e();
  thread function_6c502da1beda4da5();
  thread function_d076b508d9cc254f();
  thread namespace_9c93a5b828db4a4b::function_b2c16545d363192c();
  thread function_d742184711940033();
  thread function_4da5447b02b552fa();
  thread function_96c77466fa259a95();
  thread function_d98706eac0b726a9();
  thread function_a533d8921f706b7e();
  thread function_977bc5c7594695cf();
  thread function_977bc6c759469802();
  thread function_977bc7c759469a35();
  thread function_b52b3186b12df630();
  thread namespace_165c742e346e899e::function_667fc48a5675425a();
  thread function_994699d967e94f7e();
  thread function_63371c4864779c5c();
  thread function_aac15783d6e1e65a();
  level.player utility::ent_flag_wait("descend_ally_idle_start");
  utility::flag_set("vip_fov_cellblockdescend_gameplay_start");
  utility::flag_set("flag_obj_reach_makarov_activate");
}

function function_63371c4864779c5c() {
  level.player waittill("ascender_attached");

  while(level.player israisingweapon()) {
    waitframe();
  }

  level.player waittill("ascender_detached");
  utility::flag_set("flag_descend_player_detached");
  level.player scripts\sp\player::player_movement_state("cqb");
}

function function_a6d53693fe2b91af() {
  level.player endon("back_pressed_with_min_time");

  while(true) {
    [var_bd837da502678594] = level.player getnormalizedmovement(0.2, 0.2);

    if(var_bd837da502678594 < 0) {
      level.player notify("back_pressed");
    }

    waitframe();
  }
}

function function_35d4a82278e736f4() {
  self endon("back_pressed_with_min_time");
  self waittill("back_pressed");
  flag_set("flag_descend_back_pressed");
}

function function_f3b70fc9918abd5a() {
  self endon("back_pressed_with_min_time");
  flag_wait("flag_stop_1");
  self notify("back_pressed_with_min_time");
}

function function_626355e7538e3226(delay_time) {
  self endon("back_pressed_with_min_time");
  wait delay_time;

  if(!flag("flag_stop_1")) {
    thread function_f3b70fc9918abd5a();
    wait 3;
  }

  flag_wait("flag_descend_back_pressed");
  self notify("back_pressed_with_min_time");
}

function function_68090a12079dd899() {
  utility::flag_wait("flag_check_level_one_threat");
  utility::flag_set("flag_obj_assess_threat_1");
  utility::flag_set("flag_obj_assess_threat_2");
  utility::flag_set("flag_obj_assess_threat_3");
}

function function_f3829bdd7bfdf76e() {
  namespace_9c93a5b828db4a4b::function_c8431cc67f0b0824("lookat_level_1_pushdown", "level_1_enemy_damaged", 55);
  utility::flag_set("flag_lookedat_level_1_pushdown");
  level.player notify("lookedat_level_1_pushdown");
}

function function_d13920cacc8ba75b() {
  smoke = level.player.offhandinventory[1];
  smoke_count = level.player getweaponammoclip(smoke);
  level.player give_offhand("smoke_righthand", smoke_count);
  level.player waittill("ascender_detach_complete");
  smoke = level.player.offhandinventory[1];
  smoke_count = level.player getweaponammoclip(smoke);
  level.player give_offhand("smoke", smoke_count);
}

function function_aac15783d6e1e65a() {
  level.player endon("ascender_detached");
  level.player endon("death");
  thread function_68090a12079dd899();
  utility::flag_wait("flag_descend_allies_initialized");
  utility::flag_wait("flag_control_checkers_dead");
  wait 1;
  utility::flag_set("flag_check_level_one_threat");
  delay_time = 4;
  utility::display_hint("belay_hint", 60, delay_time, level.player, "back_pressed_with_min_time");
  level.player notifyonplayercommand("back_pressed", "+back");
  level.player thread function_a6d53693fe2b91af();
  level.player thread function_35d4a82278e736f4();
  level.player thread function_626355e7538e3226(delay_time);
  utility::flag_wait("flag_stop_1");
  thread function_f3829bdd7bfdf76e();
  namespace_9c93a5b828db4a4b::flag_wait_either("flag_stop_descender", "level_1_enemy_damaged");
  utility::flag_set("level_1_enemy_damaged");
  wait 1;
  wait 1;
  utility::flag_set("flag_level_1_no_threat");
  wait 1;
  utility::flag_set("flag_level_1_clear");
  utility::flag_wait("flag_stop_3");
  utility::flag_clear("flag_stop_descender");
  thread flag_set_delayed("level_2_flashlight_timeout", 2);
  flag_wait_any("flag_stop_descender", "level_2_enemy_damaged", "level_2_flashlight_timeout");

  if(flag("level_2_flashlight_timeout")) {}

  if(flag("flag_stop_descender")) {}

  if(flag("level_2_enemy_damaged")) {}

  flag_set("flag_stop_descender");
  flag_set("flag_level_2_player_in_flashlight");
  flag_set("level_2_enemy_damaged");
  wait 1;
  utility::flag_wait("flag_leaving_level_2");
  utility::flag_wait("flag_stop_4");
  utility::flag_set("flag_stair_runners_down");
  utility::flag_wait("flag_stop_5");
  utility::flag_clear("flag_stop_descender");
  utility::flag_wait_or_timeout("flag_force_flashlight_ambush", 4);
  wait 1;
  utility::flag_wait("flag_stop_6");
  utility::flag_wait("flag_descend_holdup_guard_dead");
  wait 1;
}

function function_b031abe39fc32203() {
  level.player endon("ascender_detached");
  level.player endon("death");
  max_multiplier = 3;
}

function function_282ef1fd49db6eef(state, blend_time) {
  if(!isDefined(blend_time)) {
    blend_time = 2;
  }

  if(state) {
    thread utility::lerp_saveddvar(@ "hash_c533867ac3fdc690", 20, blend_time);
    thread utility::lerp_saveddvar(@ "hash_94d94e451d01da61", 20, blend_time);
    return;
  }

  thread utility::lerp_saveddvar(@ "hash_c533867ac3fdc690", 1, blend_time);
  thread utility::lerp_saveddvar(@ "hash_94d94e451d01da61", 1, blend_time);
}

function function_8cdc4d166a5a2c01() {
  level.player endon("ascender_detached");
  level.player endon("death");

  while(true) {
    if(level.player isreloading() || level.player isswitchingweapon()) {
      if(!level.player utility::ent_flag("descender_sway_suppressed_for_reloading")) {
        function_282ef1fd49db6eef(0, 2);
        level.player utility::ent_flag_set("descender_sway_suppressed_for_reloading");
      }
    } else if(level.player utility::ent_flag("descender_sway_suppressed_for_reloading")) {
      if(!level.player utility::ent_flag("descender_sway_suppressed_for_pain_flinch")) {
        function_282ef1fd49db6eef(1, 2);
      }

      level.player utility::ent_flag_clear("descender_sway_suppressed_for_reloading");
    }

    waitframe();
  }
}

function function_ae0938b18c3c637c() {
  level.player endon("ascender_detached");
  level.player endon("death");

  while(true) {
    level.player waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);
    thread function_ca55221dda42d938();
  }
}

function function_ca55221dda42d938() {
  level notify("player_sway_flinch_handler_started");
  level endon("player_sway_flinch_handler_started");
  level.player utility::ent_flag_set("descender_sway_suppressed_for_pain_flinch");
  function_282ef1fd49db6eef(0, 0.01);
  wait 2;

  if(!level.player utility::ent_flag("descender_sway_suppressed_for_reloading")) {
    function_282ef1fd49db6eef(1, 1);
  }

  level.player utility::ent_flag_clear("descender_sway_suppressed_for_pain_flinch");
}

function function_d9f162cb6aefa040() {
  utility::flag_set("flag_end_descend");
  utility::flag_set("flag_obj_reach_descend_activate");
  utility::flag_set("flag_obj_reach_descend_complete");
  utility::flag_set("flag_obj_assess_threat_1");
  utility::flag_set("flag_obj_assess_threat_2");
  utility::flag_set("flag_obj_assess_threat_3");
  utility::flag_set("flag_killed_all_level_1_enemies");
  utility::flag_set("flag_killed_level_2_enemies");
  utility::flag_set("flag_killed_level_3_enemies");
  utility::flag_set("flag_obj_reach_makarov_activate");
  utility::flag_set("vip_fov_cellblockdescend_pipe_enter");
  utility::flag_set("vip_fov_cellblockdescend_gameplay_start");
  clearmusicstate();
  setmusicstate("mx_vip_descend");
}

function function_9c660c7238d7e120() {
  if(!isDefined(level.ally1)) {
    namespace_9c93a5b828db4a4b::spawn_allies();
  }

  animnode = utility::getStruct("scene_vip_0600_descend_control", "targetname");
  var_18dd1e3e78259cf = utility::getStruct("scene_vip_0600_descend_control_allies", "targetname");
  var_b4dd203f4a059f53 = utility::getStruct("scene_vip_0600_descend_control_bravo", "targetname");

  if(!isDefined(level.team_b_1)) {
    level.team_b_1 = utility::spawn_targetname("team_b_1", 1);
    level.team_b_2 = utility::spawn_targetname("team_b_2", 1);
    level.team_b_3 = utility::spawn_targetname("team_b_3", 1);
  } else {
    level.team_b_1 show();
    level.team_b_2 show();
    level.team_b_3 show();
  }

  level.team_b_1.animname = "Bravo01";
  level.team_b_2.animname = "Bravo02";
  level.team_b_3.animname = "Bravo03";
  level.team_b_1.name = "Gibson";
  level.team_b_1.callsign = "Bravo-1";
  level.team_b_2.name = "Rees";
  level.team_b_2.callsign = "Bravo-2";
  level.team_b_3.name = "Davidson";
  level.team_b_3.callsign = "Bravo-3";
  level.team_b_1.ignoreme = 1;
  level.team_b_2.ignoreme = 1;
  level.team_b_3.ignoreme = 1;
  level.team_b_1 utility::set_ignoreall(1);
  level.team_b_2 utility::set_ignoreall(1);
  level.team_b_3 utility::set_ignoreall(1);
  level.team_b_1 set_strict_ff(1);
  level.team_b_2 set_strict_ff(1);
  level.team_b_3 set_strict_ff(1);
  level.team_b_1 thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend");
  level.team_b_2 thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend");
  level.team_b_3 thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend");
  var_92ae3b77ec6cabb5 = [level.team_b_1, level.team_b_2, level.team_b_3];
  allies_array = [level.ally1, level.ally2];
  animnode scene::function_8207074e79f22926(level.player, "player_fov_out", "Player");
  animnode scene::function_8207074e79f22926(level.player, "player_fov_in", "Player");
  animnode scene::function_8207074e79f22926(level.player, "lights_out_1", "Player");
  animnode scene::function_8207074e79f22926(level.player, "lights_out_2", "Player");
  animnode scene::function_8207074e79f22926(level.player, "lights_out_3", "Player");
  animnode scene::function_8207074e79f22926(level.player, "lights_out_4", "Player");
  animnode scene::function_8207074e79f22926(level.player, "lights_out_5", "Player");
  animnode scene::function_8207074e79f22926(level.player, "ally1_laser_on", "Player");
  animnode scene::function_8207074e79f22926(level.player, "ally2_laser_on", "Player");
  animnode scene::function_8207074e79f22926(level.player, "control_room_cleared", "Player");
  animnode scene::function_8207074e79f22926(level.player, "nvg_on", "Player");
  animnode scene::function_8207074e79f22926(level.player, "ascender_legs_enable", "Player");
  animnode scene::function_8207074e79f22926(level.player, "ascender_legs_disable", "Player");
  level.player thread function_dea7ed64c2923f46();
  assertex(isDefined(animnode), "Descend control intro anim not defined!");
  animnode thread scene::play(level.player, "pre_idle");
  guard_actors = animnode scene::get_entities("pre_idle");

  foreach(actor in guard_actors) {
    if(utility::is_equal(actor.team, "axis")) {
      actor namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e();
    }
  }

  utility::flag_wait("flag_descend_start_anim");
  level.player setsuit("jup_suit_descender_sp");
  level.player nightvisiongogglesforceoff();
  level.player val::set("gulag_descend", "allow_movement", 1);
  thread player::disable_player_weapon_info();
  thread function_d13920cacc8ba75b();
  level.player player::focusdisable();
  utility::function_1ae8f046dee579e0(1);
  var_d5146610cf31d61d = 0;

  if(function_8595b85eca795ef0()) {
    var_d5146610cf31d61d = 0.99;
  }

  animnode thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, level.player, "shot_010", var_d5146610cf31d61d);
  var_18dd1e3e78259cf thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, allies_array, "shot_010", var_d5146610cf31d61d);
  var_b4dd203f4a059f53 thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, var_92ae3b77ec6cabb5, ["shot_010", "post_idle"], var_d5146610cf31d61d);
  animnode thread function_85e0c72c5866e4a4();
  waitframe();
  level.player setclientomnvar("ui_is_in_scripted_cinematic", 1);

  if(function_8595b85eca795ef0()) {
    utility::flag_set("lgt_descend_start");
    level.player notify("lights_out_1");
    level.player notify("lights_out_2");
    level.player notify("lights_out_3");
    level.player notify("lights_out_4");
    level.player notify("lights_out_5");
    level.player thread utility::notify_delay("ally1_laser_on", 0);
    level.player thread utility::notify_delay("ally2_laser_on", 0.1);
    level.player notify("nvg_on");
    thread function_d818b006c6bb99de();
    utility::flag_set("flag_control_room_clear");
    utility::flag_set("flag_descend_player_nvg_on");
    level.player utility::ent_flag_set("descend_ally_idle_start");
    level.team_b_1 laserforceoff();
    level.team_b_2 laserforceoff();
    level.team_b_3 laserforceoff();
    return;
  }

  wait 11.7;
  var_e3a1538d64fab78 = level.player getlocalplayerprofiledata("highVisibilityMode");

  if(var_e3a1538d64fab78 > 0) {
    level.player setlocalplayerprofiledata("highVisibilityMode", 0);
  }

  wait 8.3;
  level.player function_e86b627cc002881f();
  animnode scene::function_bc521bee52fde214(0);
  var_18dd1e3e78259cf scene::function_bc521bee52fde214(0);
  var_b4dd203f4a059f53 scene::function_bc521bee52fde214(0);
  level.player thread namespace_165c742e346e899e::function_b59010081eb9575();
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);
  level.player notifyonplayercommand("nvg_button_pressed", "nightvision");
  level.player notifyonplayercommand("nvg_button_pressed", "+actionslot 2");
  utility::display_hint("nvg_hint", undefined, 0, level.player, "nvg_button_pressed");
  level.player waittill("nvg_button_pressed");
  level.player player::focusdisable();
  utility::function_1ae8f046dee579e0(1);
  thread namespace_165c742e346e899e::function_e0416375588d2899();
  animnode scene::function_bc521bee52fde214(1);
  var_18dd1e3e78259cf scene::function_bc521bee52fde214(1);
  var_b4dd203f4a059f53 scene::function_bc521bee52fde214(1);
  level.player setclientomnvar("ui_is_in_scripted_cinematic", 0);

  if(var_e3a1538d64fab78 > 0) {
    level.player setlocalplayerprofiledata("highVisibilityMode", var_e3a1538d64fab78);
  }

  utility::flag_set("flag_descend_goggles_back_on");
  level.player waittill("control_room_cleared");
  utility::flag_set("flag_control_room_clear");
  var_18dd1e3e78259cf waittill("scene_complete");
  level.team_b_1 laserforceoff();
  level.team_b_2 laserforceoff();
  level.team_b_3 laserforceoff();
  level.player utility::ent_flag_set("descend_ally_idle_start");
  level.player lerpviewangleclamp(0, 0, 0, 90, 120, 90, 90, 1);
  thread player::allow_player_weapon_info(0);
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);
  level.player setspreadoverride(1);
}

function function_adef44457034f5a4() {
  level endon("flag_descend_level_3_allies_disengage");
  level.ally1 utility::set_ignoreme(0);
  level.ally2 utility::set_ignoreme(0);
  var_7207174c4d07707f = 4;
  var_d80aa61e33f68581 = 4;
  var_d80aa61e33f68581 += 1;

  for(var_f7f12102b9e05042 = 1; !utility::flag("flag_descend_level_3_allies_disengage"); var_f7f12102b9e05042 = !var_f7f12102b9e05042) {
    wait randomfloatrange(var_7207174c4d07707f, var_d80aa61e33f68581);
    shot_count = randomintrange(5, 9);
    level.var_8bfebd2a4bb5c29c = utility::array_removedead_or_dying(level.var_8bfebd2a4bb5c29c);

    if(var_f7f12102b9e05042) {
      closest_guy = utility::getclosest(level.ally1.origin, level.var_8bfebd2a4bb5c29c);
    } else {
      closest_guy = utility::getclosest(level.ally2.origin, level.var_8bfebd2a4bb5c29c);
    }

    if(isDefined(closest_guy) && isalive(closest_guy) && !utility::flag("flag_descend_level_3_allies_disengage")) {
      if(false) {
        iprintlnbold("<dev string:x8e>");
      }

      if(var_f7f12102b9e05042) {
        level.ally1 thread function_1b32ce95e1099942(closest_guy, 0, 1, 1);
        level.ally1 delaythread(1.5, &function_7c44fca4cc7926e9, closest_guy);
      } else {
        level.ally2 thread function_1b32ce95e1099942(closest_guy, 0, 1, 1);
        level.ally2 delaythread(1.5, &function_7c44fca4cc7926e9, closest_guy);
      }
    }

    wait 1.5;

    if(isDefined(closest_guy) && isalive(closest_guy) && !utility::flag("flag_descend_level_3_allies_disengage")) {
      if(false) {
        iprintlnbold("<dev string:xab>");
      }

      if(var_f7f12102b9e05042) {
        level.ally1.var_a5b8326e0a4d80e = randomintrange(2, 3);
        level.ally1.var_b6198f8f921d0b28 = 1;
      } else {
        level.ally2.var_a5b8326e0a4d80e = randomintrange(2, 3);
        level.ally2.var_b6198f8f921d0b28 = 1;
      }
    }

    wait 1;
  }
}

function function_2258651fd9d29236() {
  utility::flag_wait_either("flag_killed_2_level_1_enemies", "flag_leaving_level_4");
  wait 1;
  enemy_counter = 0;

  foreach(guy in level.var_fbc4741479364a60) {
    if(!utility::is_dead_or_dying(guy)) {
      if(enemy_counter == 0) {
        level.ally1 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally1);
        }
      } else {
        level.ally2 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally2);
        }
      }

      enemy_counter++;
    }
  }
}

function function_75625697cec0d4af() {
  utility::flag_wait_either("flag_killed_2_level_2_enemies", "flag_leaving_level_4");
  wait 1;
  enemy_counter = 0;

  foreach(guy in level.var_17b5b44b7bf1f73b) {
    if(!utility::is_dead_or_dying(guy)) {
      if(enemy_counter == 0) {
        level.ally1 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally1);
        }
      } else {
        level.ally2 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally2);
        }
      }

      enemy_counter++;
    }
  }
}

function function_1320ceec8a77364c() {
  enemy_counter = 0;

  foreach(guy in level.var_8bfebd2a4bb5c29c) {
    if(!utility::is_dead_or_dying(guy)) {
      if(enemy_counter == 0) {
        level.ally1 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally1);
        }
      } else {
        level.ally2 thread function_7c44fca4cc7926e9(guy);
        waitframe();

        if(!utility::is_dead_or_dying(guy)) {
          guy kill(guy.origin, level.ally2);
        }
      }

      enemy_counter++;
    }

    wait 0.25;
  }
}

function function_f3d9db81102372() {
  self waittill("death", killer);

  if(isDefined(killer)) {
    if(killer == level.ally1 || killer == level.ally2) {} else if(killer == level.player) {
      level.var_1abd3d4b293ec222++;
    } else if(isDefined(level.var_cf8077f2c356cb00) && level.var_cf8077f2c356cb00 == self) {
      level.var_1abd3d4b293ec222++;
    }

    if(level.var_1abd3d4b293ec222 == 12) {
      level.player function_6a369480dbaf1090("jup_sp_deathpenalty");
    }
  }
}

function function_529a27e3ff718090(guy) {
  guy endon("death");

  while(!function_b877cff8b7533624()) {
    waitframe();
  }

  wait 1.5;
  flag_set("flag_shoot_control_checkers_early");
}

function function_6ebf3cba7b7b221f() {
  flag_wait("flag_entering_level_1");
  flag_set("flag_shoot_control_checkers_early");
}

function function_a728b7985cda407d(var_7779ffca6f8e068e, animnode, var_5166be0ce1f7c31f) {
  utility::flag_wait(var_7779ffca6f8e068e);

  if(isDefined(level.var_b03c39f14f72c725) && isDefined(level.var_be7a6f4bb2b1394b)) {
    if(self == level.var_b03c39f14f72c725) {
      animnode scene::stop();
      waitframe();
      function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, self);
      return;
    }

    if(isDefined(var_5166be0ce1f7c31f) && var_5166be0ce1f7c31f) {
      animnode scene::stop();
    }
  }
}

function function_7d6d3dffa1c41e90() {
  utility::flag_wait("flag_descend_goggles_back_on");
  level.ally1 utility::set_ignoreme(1);
  level.ally2 utility::set_ignoreme(1);

  if(false) {
    iprintlnbold("<dev string:xc7>");
  }

  control_checker_01 = utility::spawn_targetname("control_checker_01", 1);
  control_checker_02 = utility::spawn_targetname("control_checker_02", 1);
  control_checkers = [];
  control_checkers = utility::array_add(control_checkers, control_checker_01);
  control_checkers = utility::array_add(control_checkers, control_checker_02);
  utility::array_thread(control_checkers, &function_4f4c1c19f2710e37);
  utility::array_thread(control_checkers, &function_f3d9db81102372);
  utility::array_thread(control_checkers, &function_672fd16c1e8480a4);
  var_33d30a1a870ec56c = utility::getStruct("vip_0650_descend_guards_03", "targetname");
  var_33d30d1a870ecc05 = utility::getStruct("vip_descend_control_checkers", "targetname");
  var_33d30a1a870ec56c thread scene::play(control_checker_01, "idle");
  var_33d30d1a870ecc05 thread scene::play(control_checker_02, "idle_actor_2");
  thread namespace_9c93a5b828db4a4b::function_b6000b715fed87e(control_checkers, "flag_descend_control_checkers_killed");

  if(false) {
    iprintlnbold("<dev string:xd1>");
  }

  wait 2;
  utility::flag_set("flag_control_checkers_show");
  wait 1;
  utility::flag_set("flag_control_checkers_stairway_start_walk");
  var_33d30a1a870ec56c thread scene::play(control_checker_01, "shot_010_guard_search", undefined, 0);
  var_33d30d1a870ecc05 thread scene::play(control_checker_02, "stairway_walk_actor_2", undefined, 0);
  var_33d30d1a870ecc05 thread scene::function_bc521bee52fde214(0.66);
  control_checker_01 thread function_4add6fc11546b7a4("level_0_walkway_guy_stuck_with_grenade");
  control_checker_02 thread function_4add6fc11546b7a4("level_0_walkway_guy_stuck_with_grenade");
  control_checker_01 thread function_a728b7985cda407d("level_0_walkway_guy_stuck_with_grenade", var_33d30a1a870ec56c);
  control_checker_02 thread function_a728b7985cda407d("level_0_walkway_guy_stuck_with_grenade", var_33d30d1a870ecc05);
  thread function_6ebf3cba7b7b221f();
  utility::flag_wait("flag_descend_allies_initialized");

  if(false) {
    iprintlnbold("<dev string:xdb>");
  }

  level.ally1.var_a523960b4b241765 = -30;
  level.ally2.var_a523960b4b241765 = -60;
  level.ally1 thread function_1b32ce95e1099942(control_checkers[1], 0, 0, 2);
  level.ally2 thread function_1b32ce95e1099942(control_checkers[0], 0, 1, 2);
  level.ally2 thread function_ca4612afbc7a3e44(control_checkers[0], 3.7, "flag_shoot_control_checkers_early", 1);
  level.ally1 thread function_ca4612afbc7a3e44(control_checkers[1], 4, "flag_shoot_control_checkers_early", 1);
  level.level_1_bk_guards = utility::array_spawn_targetname("level_1_bk_guards", 1);
  utility::array_thread(level.level_1_bk_guards, &function_441bc0dbe9b09396);
  utility::array_thread(level.level_1_bk_guards, &function_f3d9db81102372);
  utility::array_thread(level.level_1_bk_guards, &function_2ee9e8d6a1b3ba62, "level_1_enemy_damaged");

  foreach(guy in control_checkers) {
    if(!utility::is_dead_or_dying(guy)) {
      guy waittill("death");
    }
  }

  utility::flag_set("flag_control_checkers_dead");
  wait 0.5;
  level.ally1.var_a523960b4b241765 = 10;
  level.ally2.var_a523960b4b241765 = 10;
  var_d7eb51df1fde329e = utility::getStruct("ally2_pos_level_1", "targetname");

  if(false) {
    iprintlnbold("<dev string:xe5>");
  }

  level.ally2 thread function_db5eb753be437e37(var_d7eb51df1fde329e.origin, 3);
  var_775350d6c930fe9b = utility::getStruct("ally1_pos_level_1", "targetname");

  if(false) {
    iprintlnbold("<dev string:x10c>");
  }

  level.ally1 thread function_db5eb753be437e37(var_775350d6c930fe9b.origin + (0, 0, 50), 3);
  wait 1;
  utility::flag_set("flag_send_background_guys");
  wait 2;

  if(false) {
    iprintlnbold("<dev string:x133>");
  }

  guy2 = getEnt("spawner_level_1_vignette_guard_01", "targetname");
  level.ally1 function_1b32ce95e1099942(level.scenario_2_guard, 0, 0, 2);
  level.ally2 function_1b32ce95e1099942(guy2, 0, 0, 2);
  utility::flag_wait("level_1_enemy_damaged");

  if(false) {
    iprintlnbold("<dev string:x13d>");
  }

  time_to_wait = 4;
  utility::flag_wait_any_timeout(time_to_wait, "flag_killed_2_level_1_enemies", "flag_leaving_level_4", "flag_leaving_level_1");

  if(false) {
    iprintlnbold("<dev string:x147>");
  }

  thread function_2258651fd9d29236();

  if(!flag("flag_killed_2_level_1_enemies") && !flag("flag_leaving_level_4")) {
    timeout = 4;
    flag_wait_any_timeout(timeout, "flag_killed_2_level_1_enemies", "flag_leaving_level_4");
  }

  var_f7f12102b9e05042 = 1;

  foreach(guy in level.var_fbc4741479364a60) {
    if(!utility::is_dead_or_dying(guy)) {
      if(var_f7f12102b9e05042) {
        level.ally1 function_1b32ce95e1099942(guy, 1, 1);
        level.ally1 delaythread(1, &function_7c44fca4cc7926e9, guy);
      } else {
        level.ally2 function_1b32ce95e1099942(guy, 1, 1);
        level.ally2 delaythread(1, &function_7c44fca4cc7926e9, guy);
      }

      var_f7f12102b9e05042 = !var_f7f12102b9e05042;

      if(!flag("flag_killed_2_level_1_enemies") && !flag("flag_leaving_level_4")) {
        timeout = 4;
        flag_wait_any_timeout(timeout, "flag_killed_2_level_1_enemies", "flag_leaving_level_4");
      }
    }
  }

  utility::flag_wait_either("flag_killed_all_level_1_enemies", "flag_leaving_level_4");

  if(false) {
    iprintlnbold("<dev string:x151>");
  }

  level.ally1.descend_target = undefined;
  level.ally2.descend_target = undefined;
  wait 1;
  var_775350d6c930fe9b = utility::getStruct("ally1_pos_level_2", "targetname");
  var_d7eb51df1fde329e = utility::getStruct("ally2_pos_level_2", "targetname");

  if(false) {
    iprintlnbold("<dev string:x15b>");
  }

  level.ally1 thread function_db5eb753be437e37(var_775350d6c930fe9b.origin, 5);

  if(false) {
    iprintlnbold("<dev string:x182>");
  }

  level.ally2 thread function_db5eb753be437e37(var_d7eb51df1fde329e.origin, 5);
  level.ally1.var_a523960b4b241765 = -30;
  wait 5;
  utility::flag_wait("flag_leaving_level_1");

  if(false) {
    iprintlnbold("<dev string:x1a9>");
  }

  waitframe();

  if(!is_dead_or_dying(level.var_c80a15f730645bf8[1]) && !flag("flag_leaving_level_4")) {
    level.ally2 thread function_1b32ce95e1099942(level.var_c80a15f730645bf8[1], 0, 1, 4);
  }

  if(!is_dead_or_dying(level.var_c80a15f730645bf8[0]) && !flag("flag_leaving_level_4")) {
    level.ally1 thread function_1b32ce95e1099942(level.var_c80a15f730645bf8[0], 0, 1, 3);
  }

  utility::flag_wait_either("flag_level_2_player_in_flashlight", "level_2_enemy_damaged");

  if(false) {
    iprintlnbold("<dev string:x1b3>");
  }

  if(false) {
    iprintlnbold("<dev string:x1bd>");
  }

  time_to_wait = 4;
  utility::flag_wait_any_timeout(time_to_wait, "flag_killed_2_level_2_enemies", "flag_leaving_level_4", "flag_leaving_level_2");

  if(false) {
    iprintlnbold("<dev string:x1c9>");
  }

  thread function_75625697cec0d4af();

  if(!flag("flag_killed_2_level_2_enemies") && !flag("flag_leaving_level_4")) {
    timeout = 4;
    flag_wait_any_timeout(timeout, "flag_killed_2_level_2_enemies", "flag_leaving_level_4");
  }

  var_f7f12102b9e05042 = 1;

  foreach(guy in level.var_17b5b44b7bf1f73b) {
    if(!utility::is_dead_or_dying(guy)) {
      if(var_f7f12102b9e05042) {
        level.ally1 function_1b32ce95e1099942(guy, 1, 1);
        level.ally1 delaythread(1, &function_7c44fca4cc7926e9, guy);
      } else {
        level.ally2 function_1b32ce95e1099942(guy, 1, 1);
        level.ally2 delaythread(1, &function_7c44fca4cc7926e9, guy);
      }

      var_f7f12102b9e05042 = !var_f7f12102b9e05042;

      if(!flag("flag_killed_2_level_2_enemies") && !flag("flag_leaving_level_4")) {
        timeout = 4;
        flag_wait_any_timeout(timeout, "flag_killed_2_level_2_enemies", "flag_leaving_level_4");
      }
    }
  }

  utility::flag_wait_either("flag_set_level_2_spotters_dead", "flag_leaving_level_4");

  if(false) {
    iprintlnbold("<dev string:x1d5>");
  }

  wait 0.5;
  var_775350d6c930fe9b = utility::getStruct("ally1_pos_level_3", "targetname");

  if(false) {
    iprintln("Ally 1 descending to ally1_pos_level_3 (vip_descend_level_3_combat_encounter)");
  }

  level.ally1 thread function_db5eb753be437e37(var_775350d6c930fe9b.origin, 4);
  var_d7eb51df1fde329e = utility::getStruct("ally2_pos_level_3", "targetname");

  if(false) {
    iprintln("Ally 2 descending to ally2_pos_level_3 (vip_descend_level_3_combat_encounter)");
  }

  level.ally2 thread function_db5eb753be437e37(var_d7eb51df1fde329e.origin, 4);
  wait 4;
  utility::flag_wait("flag_leaving_level_2");

  if(false) {
    iprintlnbold("<dev string:x1e8>");
  }

  level.ally1.descend_target = undefined;
  level.ally2.descend_target = undefined;
  flag_wait("flag_stop_4");

  if(false) {
    iprintlnbold("<dev string:x1f3>");
  }

  waitframe();

  if(!is_dead_or_dying(level.var_d234d4665c4354fd[0]) && !flag("flag_leaving_level_4")) {
    if(false) {
      iprintlnbold("<dev string:x1fe>");
    }

    level.ally1 thread function_1b32ce95e1099942(level.var_d234d4665c4354fd[0], 0, 0, 3);
  }

  waitframe();

  if(!flag("flag_leaving_level_4")) {
    if(false) {
      iprintlnbold("<dev string:x226>");
    }

    thread function_adef44457034f5a4();
  } else {
    if(false) {
      iprintlnbold("<dev string:x244>");
    }

    utility::flag_set("flag_descend_level_3_allies_disengage");
  }

  utility::flag_wait("flag_descend_level_3_allies_disengage");
  thread function_1320ceec8a77364c();

  if(false) {
    iprintlnbold("<dev string:x277>");
  }

  var_775350d6c930fe9b = utility::getStruct("ally1_descend_near_end", "targetname");
  var_d7eb51df1fde329e = utility::getStruct("ally2_descend_end", "targetname");

  if(false) {
    iprintlnbold("<dev string:x282>");
  }

  level.ally1 function_db5eb753be437e37(var_775350d6c930fe9b.origin, 4);
  level.ally2 function_db5eb753be437e37(var_d7eb51df1fde329e.origin, 3);
  wait 4;

  if(false) {
    iprintlnbold("<dev string:x2a9>");
  }

  utility::flag_wait("flag_entering_level_4");

  if(false) {
    iprintlnbold("<dev string:x2b4>");
  }

  level.ally1 utility::set_ignoreme(1);
  level.ally2 utility::set_ignoreme(1);

  if(false) {
    iprintlnbold("<dev string:x2bf>");
  }

  utility::flag_set("flag_enable_ally_detach");
}

function function_7c44fca4cc7926e9(guard) {
  if(isDefined(guard) && !is_dead_or_dying(guard)) {
    magicbullet("jup_jp02_ar_bromeo805", self.origin, guard.origin + (0, 0, 48), self);
  }
}

function function_aa573edf1460a186(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  self endon("death");

  if(isPlayer(attacker)) {
    level.var_cf8077f2c356cb00 = self;
  }
}

function function_33b350220029c40b() {
  if(!flag("flag_leaving_level_1")) {
    wait 1;
  }

  self addaieventlistener("silenced_shot_impact");
}

function function_2ee9e8d6a1b3ba62(var_acba072b7e847a86, var_9d92eec4427f390a) {
  self endon("death");

  if(!utility::is_equal(self.team, "axis") && self.classname != "script_model") {
    utility::add_damage_function(&function_d799ec6e01836246);
  } else {
    utility::add_damage_function(&function_aa573edf1460a186);
  }

  if(!isDefined(var_9d92eec4427f390a) || var_9d92eec4427f390a == 0) {
    self addaieventlistener("damage");
    self addaieventlistener("explosion");
    self addaieventlistener("grenade danger");
    flag_wait("flag_control_checkers_dead");
    waitframe();
    self addaieventlistener("suppression");
    self addaieventlistener("bulletwhizby");
    self addaieventlistener("projectile_impact");
    self addaieventlistener("gunshot_impact");
    function_33b350220029c40b();
    thread function_4add6fc11546b7a4(var_acba072b7e847a86);

    while(true) {
      self waittill("ai_events", events);

      foreach(event in events) {
        if(isDefined(event.entity) && event.entity == level.player || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_smoke_v0" || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_semtex_v0_sp") {
          flag_set(var_acba072b7e847a86);
          return;
        }
      }

      waitframe();
    }

    return;
  }

  self waittill("damage");
  flag_set(var_acba072b7e847a86);
}

function function_2d8f824971f69dde(var_5c256070f853384a) {
  self endon("death");
  self waittill("damage");

  if(!flag(var_5c256070f853384a)) {
    flag_set(var_5c256070f853384a);
    self notify("aud_riot_guy_interuppted");
  }
}

function function_f4b19c46a8dc30e8(var_5c256070f853384a) {
  self endon("death");

  if(!utility::is_equal(self.team, "axis") && self.classname != "script_model") {
    utility::add_damage_function(&function_d799ec6e01836246);
  } else {
    utility::add_damage_function(&function_aa573edf1460a186);
  }

  thread function_2d8f824971f69dde(var_5c256070f853384a);
  self addaieventlistener("damage");
  self addaieventlistener("explosion");
  self addaieventlistener("grenade danger");
  thread function_4add6fc11546b7a4(var_5c256070f853384a, 1);

  while(true) {
    self waittill("ai_events", events);

    foreach(event in events) {
      if(isDefined(event.entity) && event.entity == level.player || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_smoke_v0" || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_semtex_v0_sp") {
        if(distance(event.origin, self.origin) < 100) {
          if(!flag(var_5c256070f853384a)) {
            flag_set(var_5c256070f853384a);
            self notify("aud_riot_guy_interuppted");
            return;
          }
        }
      }
    }

    waitframe();
  }
}

function function_52f0a868e9bc8767() {
  level.var_ca30e2e5fb0267e0 = utility::getStruct("scene_panopticon_guard_holding_prisoner", "targetname");
  level.scenario_2_guard = utility::spawn_targetname("spawner_scenario_2_guard", 1);
  level.scenario_2_prisoner = utility::spawn_targetname("spawner_scenario_2_prisoner", 1);
  waitframe();
  level.scenario_2_guard thread function_650b5a3a8851c709(1);
  level.scenario_2_guard thread function_f3d9db81102372();
  level.scenario_2_prisoner thread function_12251ccb5c04b482(1);
  level.scenario_2_guard thread function_2ee9e8d6a1b3ba62("level_1_guard_pushdown_guard_damaged", 1);
  level.scenario_2_prisoner thread function_2ee9e8d6a1b3ba62("level_1_guard_pushdown_prisoner_damaged", 1);
  level.scenario_2_guard thread function_4add6fc11546b7a4("level_1_guard_pushdown_guard_stuck_with_grenade");
  level.scenario_2_prisoner thread function_4add6fc11546b7a4("level_1_guard_pushdown_prisoner_stuck_with_grenade");

  if(!flag("level_1_enemy_damaged") && !flag("level_1_guard_pushdown_guard_damaged") && !flag("level_1_guard_pushdown_prisoner_damaged") && !is_dead_or_dying(level.scenario_2_guard) && !is_dead_or_dying(level.scenario_2_prisoner) && !level.scenario_2_guard.delayeddeath && !level.scenario_2_prisoner.delayeddeath && !flag("level_1_guard_pushdown_guard_stuck_with_grenade") && !flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
    level.var_ca30e2e5fb0267e0 thread scene::play([level.scenario_2_guard, level.scenario_2_prisoner], "shot_010_wait_idle_pair01");
  } else {
    flag_set("level_1_enemy_damaged");
    level.var_ca30e2e5fb0267e0 scene::stop();

    if(flag("level_1_guard_pushdown_guard_stuck_with_grenade") || flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
      waitframe();

      if(flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_guard);
      }

      if(flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_prisoner);
      }
    }
  }

  utility::flag_wait_any("flag_send_background_guys", "level_1_enemy_damaged", "level_1_guard_pushdown_guard_damaged", "level_1_guard_pushdown_prisoner_damaged");

  if(!flag("level_1_enemy_damaged") && !flag("level_1_guard_pushdown_guard_damaged") && !flag("level_1_guard_pushdown_prisoner_damaged") && !is_dead_or_dying(level.scenario_2_guard) && !is_dead_or_dying(level.scenario_2_prisoner) && !level.scenario_2_guard.delayeddeath && !level.scenario_2_prisoner.delayeddeath && !flag("level_1_guard_pushdown_guard_stuck_with_grenade") && !flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
    level.scenario_2_guard ai::magic_bullet_shield(0);
    level.scenario_2_prisoner ai::magic_bullet_shield(0);
    thread function_409b5ce9e290ff35();
    thread function_2742d2943638c97f();
    level.var_ca30e2e5fb0267e0 scene::play([level.scenario_2_guard, level.scenario_2_prisoner], "shot_020_wait_to_panic_pair01");
    flag_set("pushdown_finished");
  } else {
    flag_set("level_1_enemy_damaged");
    level.var_ca30e2e5fb0267e0 scene::stop();

    if(flag("level_1_guard_pushdown_guard_stuck_with_grenade") || flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
      waitframe();

      if(flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_guard);
      }

      if(flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_prisoner);
      }
    }
  }

  if(!flag("level_1_enemy_damaged") && !flag("level_1_guard_pushdown_guard_damaged") && !flag("level_1_guard_pushdown_prisoner_damaged") && !is_dead_or_dying(level.scenario_2_guard) && !is_dead_or_dying(level.scenario_2_prisoner) && !level.scenario_2_guard.delayeddeath && !level.scenario_2_prisoner.delayeddeath && !flag("level_1_guard_pushdown_guard_stuck_with_grenade") && !flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
    level.var_ca30e2e5fb0267e0 thread scene::play([level.scenario_2_guard, level.scenario_2_prisoner], "shot_030_panic_idle_pair01");
    return;
  }

  flag_set("level_1_enemy_damaged");
  level.var_ca30e2e5fb0267e0 scene::stop();

  if(flag("level_1_guard_pushdown_guard_stuck_with_grenade") || flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
    waitframe();

    if(flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
      function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_guard);
    }

    if(flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
      function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_prisoner);
    }
  }
}

function function_409b5ce9e290ff35() {
  wait 6;
  flag_set("prisoner_on_floor");

  if(isDefined(level.scenario_2_prisoner) && !is_dead_or_dying(level.scenario_2_prisoner)) {
    level.scenario_2_prisoner.deathfunction = &function_ce450b9957138bd5;
  }
}

function function_2742d2943638c97f() {
  flag_wait_any("level_1_guard_pushdown_guard_damaged", "level_1_guard_pushdown_prisoner_damaged", "level_1_enemy_damaged");

  if(!flag("pushdown_finished") && !flag("prisoner_on_floor")) {
    level.var_ca30e2e5fb0267e0 scene::stop();
    level.scenario_2_guard ai::stop_magic_bullet_shield();
    level.scenario_2_prisoner ai::stop_magic_bullet_shield();
    flag_set("level_1_enemy_damaged");

    if(flag("level_1_guard_pushdown_guard_damaged")) {
      if(flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
        waitframe();
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_guard);
      } else if(isDefined(level.scenario_2_guard.lastattacker)) {
        level.scenario_2_guard kill(level.scenario_2_guard.origin, level.scenario_2_guard.lastattacker);
      } else {
        level.scenario_2_guard kill();
      }
    }

    if(flag("level_1_guard_pushdown_prisoner_damaged")) {
      if(flag("level_1_guard_pushdown_prisoner_stuck_with_grenade")) {
        waitframe();
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_prisoner);
      } else if(isDefined(level.scenario_2_prisoner.lastattacker)) {
        level.scenario_2_prisoner kill(level.scenario_2_prisoner.origin, level.scenario_2_prisoner.lastattacker);
      } else {
        level.scenario_2_prisoner kill();
      }
    }

    return;
  }

  if(flag("level_1_guard_pushdown_guard_damaged")) {
    flag_set("level_1_enemy_damaged");
    level.var_865a59615e347886 = utility::getStruct("scene_panopticon_guard_holding_prisoner_guard_death", "targetname");
    level.var_fcb2b0b92947d079 = utility::getStruct("scene_panopticon_guard_holding_prisoner_prisoner_death", "targetname");
    level.var_ca30e2e5fb0267e0 scene::stop();
    level.var_fcb2b0b92947d079 thread scene::play(level.scenario_2_prisoner, ["shot_045_panic_to_ground_prisoner01", "shot_050_ground_idle_prisoner01"]);

    if(!flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
      level.var_865a59615e347886 scene::play(level.scenario_2_guard, "shot_040_death_guard01");
    }

    level.scenario_2_guard ai::stop_magic_bullet_shield();

    if(flag("level_1_guard_pushdown_guard_stuck_with_grenade")) {
      waitframe();
      function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, level.scenario_2_guard);
    } else {
      level.scenario_2_guard.skipdeathanim = 1;
      level.scenario_2_guard.noragdoll = 1;
      level.scenario_2_guard.diequietly = 1;

      if(isDefined(level.scenario_2_guard.lastattacker)) {
        level.scenario_2_guard kill(level.scenario_2_guard.origin, level.scenario_2_guard.lastattacker);
      } else {
        level.scenario_2_guard kill();
      }
    }

    thread function_3d1725e3d846b3b1();
    return;
  }

  flag_set("level_1_enemy_damaged");
  level.var_865a59615e347886 = utility::getStruct("scene_panopticon_guard_holding_prisoner_guard_death", "targetname");
  level.var_fcb2b0b92947d079 = utility::getStruct("scene_panopticon_guard_holding_prisoner_prisoner_death", "targetname");
  level.scenario_2_guard ai::stop_magic_bullet_shield();
  level.var_865a59615e347886 thread scene::play(level.scenario_2_guard, "shot_070_panic_to_alert_guard01");
  level.var_fcb2b0b92947d079 scene::play(level.scenario_2_prisoner, "shot_060_death_prisoner01");
  level.scenario_2_prisoner ai::stop_magic_bullet_shield();
  level.scenario_2_prisoner.skipdeathanim = 1;
  level.scenario_2_prisoner.noragdoll = 1;
  level.scenario_2_prisoner.diequietly = 1;

  if(isDefined(level.scenario_2_prisoner.lastattacker)) {
    level.scenario_2_prisoner kill(level.scenario_2_prisoner.origin, level.scenario_2_prisoner.lastattacker);
    return;
  }

  level.scenario_2_prisoner kill();
}

function function_3d1725e3d846b3b1() {
  level.scenario_2_prisoner endon("death");
  flag_wait("level_1_guard_pushdown_prisoner_damaged");
  flag_set("level_1_enemy_damaged");
  level.var_fcb2b0b92947d079 = utility::getStruct("scene_panopticon_guard_holding_prisoner_prisoner_death", "targetname");
  level.var_fcb2b0b92947d079 scene::play(level.scenario_2_prisoner, "shot_060_death_prisoner01");
  level.scenario_2_prisoner ai::stop_magic_bullet_shield();
  level.scenario_2_prisoner.skipdeathanim = 1;
  level.scenario_2_prisoner.noragdoll = 1;
  level.scenario_2_prisoner.diequietly = 1;

  if(isDefined(level.scenario_2_prisoner.lastattacker)) {
    level.scenario_2_prisoner kill(level.scenario_2_prisoner.origin, level.scenario_2_prisoner.lastattacker);
    return;
  }

  level.scenario_2_prisoner kill();
}

function function_a023dd30506dd2ef() {
  clip_level_1_stairs_blocker = getEnt("clip_level_1_stairs_blocker", "targetname");
  clip_level_1_stairs_blocker disconnectPaths();
  level_1_vignette_guard_01 = utility::spawn_targetname("spawner_level_1_vignette_guard_01", 1);
  level.level_1_vignette_guard_03 = utility::spawn_targetname("spawner_level_1_vignette_guard_03", 1);
  level_1_vignette_prisoner_01 = utility::spawn_targetname("spawner_level_1_vignette_prisoner_01", 1);
  level_1_vignette_guard_01 thread function_f3d9db81102372();
  level.level_1_vignette_guard_03 thread function_f3d9db81102372();
  thread namespace_165c742e346e899e::function_35be43e20f294568();
  waitframe();
  level_1_vignette_guard_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  level.level_1_vignette_guard_03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  level_1_vignette_prisoner_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  level_1_vignette_guard_01 thread function_2ee9e8d6a1b3ba62("level_1_enemy_damaged");
  level.level_1_vignette_guard_03 thread function_2ee9e8d6a1b3ba62("level_1_enemy_damaged");
  level_1_vignette_prisoner_01 thread function_2ee9e8d6a1b3ba62("level_1_enemy_damaged");
  level_1_vignette_guard_01 thread function_650b5a3a8851c709(1);
  level.level_1_vignette_guard_03 thread function_650b5a3a8851c709(1);
  level_1_vignette_prisoner_01 thread function_12251ccb5c04b482(1);
  descend_level_1_cell_2_prisoner01 = utility::spawn_targetname("descend_level_1_cell_2_prisoner01", 1);
  descend_level_1_cell_2_prisoner02 = utility::spawn_targetname("descend_level_1_cell_2_prisoner02", 1);
  descend_level_1_cell_2_prisoner03 = utility::spawn_targetname("descend_level_1_cell_2_prisoner03", 1);
  descend_level_1_cell_2_prisoner04 = utility::spawn_targetname("descend_level_1_cell_2_prisoner04", 1);
  descend_level_1_cell_2_prisoner05 = utility::spawn_targetname("descend_level_1_cell_2_prisoner05", 1);
  descend_level_1_cell_2_prisoner06 = utility::spawn_targetname("descend_level_1_cell_2_prisoner06", 1);
  descend_level_1_cell_3_prisoner01 = utility::spawn_targetname("descend_level_1_cell_3_prisoner01", 1);
  descend_level_1_cell_3_prisoner02 = utility::spawn_targetname("descend_level_1_cell_3_prisoner02", 1);
  descend_level_1_cell_3_prisoner03 = utility::spawn_targetname("descend_level_1_cell_3_prisoner03", 1);
  descend_level_1_cell_3_prisoner04 = utility::spawn_targetname("descend_level_1_cell_3_prisoner04", 1);
  descend_level_1_cell_3_prisoner05 = utility::spawn_targetname("descend_level_1_cell_3_prisoner05", 1);
  descend_level_1_cell_3_prisoner06 = utility::spawn_targetname("descend_level_1_cell_3_prisoner06", 1);
  var_4ecb980264a3e376 = [descend_level_1_cell_2_prisoner01, descend_level_1_cell_2_prisoner02, descend_level_1_cell_2_prisoner03, descend_level_1_cell_2_prisoner04, descend_level_1_cell_2_prisoner05, descend_level_1_cell_2_prisoner06];
  var_d7c7c7d337d94e05 = [descend_level_1_cell_3_prisoner01, descend_level_1_cell_3_prisoner02, descend_level_1_cell_3_prisoner03, descend_level_1_cell_3_prisoner04, descend_level_1_cell_3_prisoner05, descend_level_1_cell_3_prisoner06];
  descend_level_1_cell_2_prisoner01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_2_prisoner02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_2_prisoner03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_2_prisoner04 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_2_prisoner05 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_2_prisoner06 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner04 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner05 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  descend_level_1_cell_3_prisoner06 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  utility::array_thread(var_4ecb980264a3e376, &function_2ee9e8d6a1b3ba62, "level_1_enemy_damaged");
  utility::array_thread(var_d7c7c7d337d94e05, &function_2ee9e8d6a1b3ba62, "level_1_enemy_damaged");
  utility::array_thread(var_4ecb980264a3e376, &function_645b5a7cb58249b2);
  utility::array_thread(var_d7c7c7d337d94e05, &function_645b5a7cb58249b2);
  function_a9aa5770d19631a4("level_1_cell_2", undefined, "flag_entering_level_2", undefined, "level_1_enemy_damaged", var_4ecb980264a3e376);
  function_a9aa5770d19631a4("level_1_cell_3", undefined, "flag_entering_level_2", undefined, "level_1_enemy_damaged", var_d7c7c7d337d94e05);
  function_a9aa5770d19631a4("vip_captive_prisoner_level_1_prisoner_01", undefined, "flag_entering_level_2", undefined, "level_1_enemy_damaged", level_1_vignette_prisoner_01, undefined, 1);
  function_a9aa5770d19631a4("vip_captive_prisoner_level_1_guard_01", undefined, "flag_entering_level_2", undefined, "level_1_enemy_damaged", level_1_vignette_guard_01);
  function_a9aa5770d19631a4("vip_captive_prisoner_level_1_guard_03", undefined, "flag_entering_level_2", undefined, "level_1_enemy_damaged", level.level_1_vignette_guard_03);
  utility::flag_wait("level_1_enemy_damaged");
  utility::delaythread(0.5, &function_cf17edb2ede66426, 2, 1.5);
  thread namespace_165c742e346e899e::function_f7d9f3bce91871a1();
  utility::delaythread(0.1, &function_cf17edb2ede66426, 3, 1.5);
  thread namespace_165c742e346e899e::function_22f559c53423d1c6(var_4ecb980264a3e376);
  thread namespace_165c742e346e899e::function_22f559c53423d1c6(var_d7c7c7d337d94e05);
  var_7e51275566bd2dfa = [level_1_vignette_guard_01, level.level_1_vignette_guard_03, level.scenario_2_guard];
  level.var_fbc4741479364a60 = utility::array_combine(level.level_1_bk_guards, var_7e51275566bd2dfa);
  thread function_13972cc24c2e562d(level.var_fbc4741479364a60);

  foreach(guy in level.var_fbc4741479364a60) {
    if(!utility::is_dead_or_dying(guy)) {
      guy function_d3262c3e00795e21();
    }
  }

  utility::flag_set("flag_killed_all_level_1_enemies");

  if(!function_143af7d577e696a4()) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d(0);
  }
}

function function_143af7d577e696a4() {
  if(flag("level_1_enemy_damaged") && isDefined(level.var_fbc4741479364a60) && level.var_fbc4741479364a60.size > 0 && !flag("flag_killed_all_level_1_enemies")) {
    return true;
  }

  if(flag("level_2_enemy_damaged") && isDefined(level.var_17b5b44b7bf1f73b) && level.var_17b5b44b7bf1f73b.size > 0 && !flag("flag_killed_level_2_enemies")) {
    return true;
  }

  if(flag("flag_force_flashlight_ambush") && isDefined(level.var_8bfebd2a4bb5c29c) && level.var_8bfebd2a4bb5c29c.size > 0 && !flag("flag_killed_level_3_enemies")) {
    return true;
  }

  return false;
}

function function_13972cc24c2e562d(var_4bc085c2dc0e4b37) {
  while(!flag("flag_killed_all_level_1_enemies") && !flag("flag_killed_2_level_1_enemies")) {
    var_cce630a8d58dc517 = 0;

    foreach(guy in var_4bc085c2dc0e4b37) {
      if(utility::is_dead_or_dying(guy)) {
        var_cce630a8d58dc517++;
      }
    }

    if(var_cce630a8d58dc517 >= 2) {
      utility::flag_set("flag_killed_2_level_1_enemies");
    }

    waitframe();
  }
}

function function_65c249e7e485b802(var_4bc085c2dc0e4b37) {
  while(!flag("flag_killed_level_2_enemies") && !flag("flag_killed_2_level_2_enemies")) {
    var_cce630a8d58dc517 = 0;

    foreach(guy in var_4bc085c2dc0e4b37) {
      if(utility::is_dead_or_dying(guy)) {
        var_cce630a8d58dc517++;
      }
    }

    if(var_cce630a8d58dc517 >= 2) {
      utility::flag_set("flag_killed_2_level_2_enemies");
    }

    waitframe();
  }
}

function function_c4dc951716032762() {
  function_c8431cc67f0b0824("lookat_level_2_cells", "level_2_enemy_damaged", 55, 1);
  utility::flag_set("flag_lookedat_level_2_cells");
  level.player notify("lookedat_level_2_cells");
}

function function_4626e030e8e3616b() {
  waitframe();
  wait 4;

  if(isDefined(level.level_2_group2_guard01) && !is_dead_or_dying(level.level_2_group2_guard01)) {
    level.level_2_group2_guard01 thread say("dx_sp_jvip_cbv4_vipg_getbacktoyourcells");
  }

  wait 3;

  if(isDefined(level.level_2_group1_guard01) && !is_dead_or_dying(level.level_2_group1_guard01)) {
    level.level_2_group1_guard01 thread say("dx_sp_jvip_cbv4_vipg_therestoomanyweneedh");
  }

  wait 4;

  if(isDefined(level.level_2_group1_guard01) && !is_dead_or_dying(level.level_2_group1_guard01)) {
    played_line = 0;

    foreach(guy in level.var_17b5b44b7bf1f73b) {
      if(!utility::is_dead_or_dying(guy)) {
        if(!played_line) {
          guy thread say("dx_sp_jvip_cbv4_grd2_lethimgo");
          played_line = 1;
        }
      }
    }

    if(!played_line) {
      if(isDefined(level.level_2_group2_guard01) && !is_dead_or_dying(level.level_2_group2_guard01)) {
        level.level_2_group2_guard01 thread say("dx_sp_jvip_cbv4_grd2_lethimgo");
        played_line = 1;
      }
    }

    return;
  }

  if(isDefined(level.level_2_group2_guard01) && !is_dead_or_dying(level.level_2_group2_guard01)) {
    played_line = 0;

    foreach(guy in level.var_17b5b44b7bf1f73b) {
      if(!utility::is_dead_or_dying(guy)) {
        if(!played_line) {
          guy thread say("dx_sp_jvip_cbv4_grd2_lethimgo");
          played_line = 1;
        }
      }
    }

    if(!played_line) {
      if(isDefined(level.level_2_group1_guard01) && !is_dead_or_dying(level.level_2_group1_guard01)) {
        level.level_2_group1_guard01 thread say("dx_sp_jvip_cbv4_grd2_lethimgo");
        played_line = 1;
      }
    }
  }
}

function function_fd64c8a49961c70() {
  var_1d5bdcf60388eddd = getEntArray("clip_level_2_guard_struggle", "targetname");

  foreach(hallway_clip in var_1d5bdcf60388eddd) {
    hallway_clip hide();
    hallway_clip connectpaths();
  }

  descend_level_2_prisoner = utility::array_spawn_targetname("descend_level_2_prisoner", 1);
  utility::array_thread(descend_level_2_prisoner, &function_137440284cccabe9);
  utility::array_thread(descend_level_2_prisoner, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  level.level_2_group1_guard01 = utility::spawn_targetname("level_2_group1_guard01", 1);
  level.level_2_group1_guard01 thread function_f6095cf01e23cf54();
  level.level_2_group1_guard01 thread function_f3d9db81102372();
  level.level_2_group1_guard01 utility::add_damage_function(&function_aa573edf1460a186);
  level.level_2_group2_guard01 = utility::spawn_targetname("level_2_group2_guard01", 1);
  level.level_2_group2_guard01 thread function_f6095cf01e23cf54();
  level.level_2_group2_guard01 thread function_f3d9db81102372();
  level.level_2_group2_guard01 utility::add_damage_function(&function_aa573edf1460a186);
  level.level_2_group1_guard01 thread function_4add6fc11546b7a4("level_2_grapple_group1_stuck_with_grenade_idle");
  level.level_2_group2_guard01 thread function_4add6fc11546b7a4("level_2_grapple_group2_stuck_with_grenade_idle");
  function_a9aa5770d19631a4("vip_0800_group1", ["shot_010"], undefined, undefined, "level_2_grapple_group1_stuck_with_grenade_idle", level.level_2_group1_guard01, undefined, 1, "level_2_enemy_damaged");
  function_a9aa5770d19631a4("vip_0800_group2", ["shot_010"], undefined, undefined, "level_2_grapple_group2_stuck_with_grenade_idle", level.level_2_group2_guard01, undefined, 1, "level_2_enemy_damaged");
  thread namespace_165c742e346e899e::function_c1387e6531f8ae71(level.level_2_group1_guard01, level.level_2_group2_guard01);
  level.var_c80a15f730645bf8 = utility::array_spawn_targetname("level_2_spotter_group_guard", 1);
  utility::array_thread(level.var_c80a15f730645bf8, &function_8ed01f09666d3f8b);
  utility::array_thread(level.var_c80a15f730645bf8, &function_f3d9db81102372);
  utility::array_thread(level.var_c80a15f730645bf8, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  var_2c61e58153f7d927 = utility::array_spawn_targetname("level_2_spotter_prisoner_group", 1);
  utility::array_thread(var_2c61e58153f7d927, &function_813c035677d376f4);
  utility::array_thread(var_2c61e58153f7d927, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  var_ea0e39916b9a075a = utility::array_spawn_targetname("level_2_spotter_prisoner_group_captive", 1);
  utility::array_thread(var_ea0e39916b9a075a, &function_813c035677d376f4);
  utility::array_thread(var_ea0e39916b9a075a, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  var_3d36f8e73c6d8b12 = utility::array_spawn_targetname("level_2_spotter_group_prisoner", 1);
  utility::array_thread(var_3d36f8e73c6d8b12, &function_813c035677d376f4);
  utility::array_thread(var_3d36f8e73c6d8b12, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  level.var_3c122fc368a167a1 = utility::array_spawn_targetname("level_2_spotter_group_guard_main", 1);
  utility::array_thread(level.var_3c122fc368a167a1, &function_8ed01f09666d3f8b);
  utility::array_thread(level.var_3c122fc368a167a1, &function_f3d9db81102372);
  utility::array_thread(level.var_3c122fc368a167a1, &function_2ee9e8d6a1b3ba62, "level_2_enemy_damaged");
  waitframe();

  foreach(guy in level.var_3c122fc368a167a1) {
    guy namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(4);
  }

  ai_array = utility::array_combine(level.var_c80a15f730645bf8, var_2c61e58153f7d927);
  level.var_17b5b44b7bf1f73b = utility::array_combine(level.var_c80a15f730645bf8, level.var_3c122fc368a167a1);
  var_41ef6367352eca0c = utility::getStruct("vip_descend_flashlight_spotted", "targetname");
  var_41ef6367352eca0c thread scene::play(ai_array, "shot_010");
  utility::array_thread(ai_array, &function_a728b7985cda407d, "level_2_enemy_damaged", var_41ef6367352eca0c);
  var_6bcdf415c9345bcf = utility::getStruct("vip_descend_flashlight_spotted_captive", "targetname");
  var_6bcdf415c9345bcf thread scene::play(var_ea0e39916b9a075a, "shot_040");
  var_cac49c0dd899ba58 = utility::getStruct("vip_descend_flashlight_spotted_main", "targetname");
  var_cac49c0dd899ba58 thread scene::play(level.var_3c122fc368a167a1, "shot_010");
  utility::array_thread(level.var_3c122fc368a167a1, &function_a728b7985cda407d, "level_2_enemy_damaged", var_cac49c0dd899ba58);
  var_6ad8cf3c7c911047 = utility::getStruct("vip_descend_flashlight_spotted_prisoner", "targetname");
  var_6ad8cf3c7c911047 thread scene::play(var_3d36f8e73c6d8b12, "shot_010");
  utility::array_thread(var_3d36f8e73c6d8b12, &function_a728b7985cda407d, "level_2_enemy_damaged", var_6ad8cf3c7c911047);
  thread function_c4dc951716032762();
  utility::flag_wait_either("flag_level_2_player_in_flashlight", "level_2_enemy_damaged");
  utility::flag_set("flag_level_2_player_spotted_vo");
  thread function_4626e030e8e3616b();

  if(!is_dead_or_dying(level.level_2_group1_guard01)) {
    level.level_2_group1_guard01 thread function_4add6fc11546b7a4("level_2_grapple_group1_stuck_with_grenade_riot");
  }

  if(!is_dead_or_dying(level.level_2_group2_guard01)) {
    level.level_2_group2_guard01 thread function_4add6fc11546b7a4("level_2_grapple_group2_stuck_with_grenade_riot");
  }

  function_a9aa5770d19631a4("vip_0800_group1", ["shot_020", "shot_030"], "flag_leaving_level_3", 0.1, "level_2_grapple_group1_stuck_with_grenade_riot", level.level_2_group1_guard01, undefined, 1, "level_2_enemy_damaged");
  function_a9aa5770d19631a4("vip_0800_group2", ["shot_020", "shot_030"], "flag_leaving_level_3", 0.1, "level_2_grapple_group2_stuck_with_grenade_riot", level.level_2_group2_guard01, undefined, 1, "level_2_enemy_damaged");
  utility::delaythread(3.5, &function_95c7afd18c8c12b3, 1, 1.5);
  utility::delaythread(3.6, &function_95c7afd18c8c12b3, 2, 1.5);
  utility::delaythread(3.7, &function_95c7afd18c8c12b3, 3, 1.5);
  utility::delaythread(3.8, &function_95c7afd18c8c12b3, 4, 1.5);
  utility::delaythread(3.9, &function_95c7afd18c8c12b3, 5, 1.5);
  utility::delaythread(4, &function_95c7afd18c8c12b3, 6, 1.5);
  thread namespace_165c742e346e899e::function_76b9d2def4764bfb();
  utility::array_thread(ai_array, &function_4add6fc11546b7a4, "level_2_enemy_stuck_with_grenade");
  utility::array_thread(ai_array, &function_a728b7985cda407d, "level_2_enemy_stuck_with_grenade", var_41ef6367352eca0c);
  utility::array_thread(level.var_3c122fc368a167a1, &function_4add6fc11546b7a4, "level_2_enemy_stuck_with_grenade");
  utility::array_thread(level.var_3c122fc368a167a1, &function_a728b7985cda407d, "level_2_enemy_stuck_with_grenade", var_cac49c0dd899ba58);
  utility::array_thread(var_3d36f8e73c6d8b12, &function_4add6fc11546b7a4, "level_2_enemy_stuck_with_grenade");
  utility::array_thread(var_3d36f8e73c6d8b12, &function_a728b7985cda407d, "level_2_enemy_stuck_with_grenade", var_6ad8cf3c7c911047);
  var_6a763bc739e7a6f8 = 0;

  if(isDefined(level.var_b03c39f14f72c725) && isDefined(level.var_3c122fc368a167a1[0]) && level.var_b03c39f14f72c725 == level.var_3c122fc368a167a1[0]) {} else {
    var_cac49c0dd899ba58 thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, level.var_3c122fc368a167a1, "shot_020");
    var_6a763bc739e7a6f8 = 1;
  }

  utility::flag_set("flag_level_2_player_actually_spotted");

  if(isDefined(level.var_b03c39f14f72c725) && isDefined(var_3d36f8e73c6d8b12[0]) && level.var_b03c39f14f72c725 == var_3d36f8e73c6d8b12[0]) {} else if(!utility::is_dead_or_dying(var_3d36f8e73c6d8b12[0])) {
    var_6ad8cf3c7c911047 thread scene::play(var_3d36f8e73c6d8b12, ["shot_020", "shot_030"]);
  }

  var_51ea9be75da16c89 = [];

  foreach(guy in ai_array) {
    var_b02a2df14f5e6f65 = isDefined(level.var_b03c39f14f72c725) && isDefined(guy) && level.var_b03c39f14f72c725 == guy;

    if(!utility::is_dead_or_dying(guy) && !var_b02a2df14f5e6f65) {
      var_51ea9be75da16c89 = utility::array_add(var_51ea9be75da16c89, guy);
    }
  }

  var_41ef6367352eca0c thread scene::play(var_51ea9be75da16c89, "shot_020");

  if(var_6a763bc739e7a6f8) {
    var_cac49c0dd899ba58 utility::waittill_any_timeout(2, "scene_complete", "death");
  }

  descend_level_2_prisoner_runner = utility::array_spawn_targetname("descend_level_2_prisoner_runner", 1);
  utility::array_thread(descend_level_2_prisoner_runner, &function_137440284cccabe9);
  thread namespace_165c742e346e899e::function_553372e150ab6c08(descend_level_2_prisoner_runner, descend_level_2_prisoner);

  foreach(hallway_clip in var_1d5bdcf60388eddd) {
    hallway_clip show();
    hallway_clip disconnectPaths();
  }

  thread function_65c249e7e485b802(level.var_17b5b44b7bf1f73b);

  foreach(guy in level.var_17b5b44b7bf1f73b) {
    if(!utility::is_dead_or_dying(guy)) {
      guy function_d3262c3e00795e21();
    }
  }

  utility::flag_set("flag_killed_level_2_enemies");

  if(!function_143af7d577e696a4()) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d(0);
  }

  utility::flag_set("flag_set_level_2_spotters_dead");
}

function function_98e11596a7489aed(var_48a75c4d557129ac) {
  while(level.var_8bfebd2a4bb5c29c.size != var_48a75c4d557129ac) {
    numalive = 0;

    foreach(guy in level.var_8bfebd2a4bb5c29c) {
      if(!utility::is_dead_or_dying(guy)) {
        numalive++;
      }
    }

    waitframe();
  }
}

function function_6c73abd49cfc0f69(var_8f3b0acda2444220) {
  namespace_9c93a5b828db4a4b::function_4d3ad1d021710127(level.var_8bfebd2a4bb5c29c, var_8f3b0acda2444220);
  utility::flag_set("l3_open_the_door");
}

function function_37f37419b9b2355d() {
  level.var_8bfebd2a4bb5c29c = [];
  ambush_guys = utility::array_spawn_targetname("ambushers", 1);
  utility::array_thread(ambush_guys, &function_12c78bb12cfa25);
  utility::array_thread(ambush_guys, &function_f3d9db81102372);
  level_3_door_left_clip = getEnt("level_3_door_left_clip", "targetname");

  if(isDefined(level_3_door_left_clip)) {
    level_3_door_left_clip hide();
    level_3_door_left_clip connectpaths();
  }

  level_3_door_right_clip = getEnt("level_3_door_right_clip", "targetname");

  if(isDefined(level_3_door_right_clip)) {
    level_3_door_right_clip hide();
    level_3_door_right_clip connectpaths();
  }

  utility::flag_wait("flag_stop_4");
  level.var_d234d4665c4354fd = utility::array_spawn_targetname("gunfight_encounter_stairs_runner", 1);
  utility::array_thread(level.var_d234d4665c4354fd, &function_994da04e9b16d72b);
  utility::array_thread(level.var_d234d4665c4354fd, &function_f3d9db81102372);
  utility::flag_wait("flag_force_flashlight_ambush");

  foreach(guy in level.var_d234d4665c4354fd) {
    if(!utility::is_dead_or_dying(guy)) {
      guy.ignoreall = 0;
    }
  }

  thread function_6c73abd49cfc0f69(2);
  flag_wait_either("l3_open_the_door", "flag_leaving_level_3");
  thread function_7e952b38489b2054();
  flag_wait("flag_descend_level_3_ambushers_spawned");
  waitframe();

  foreach(guy in level.var_8bfebd2a4bb5c29c) {
    if(!utility::is_dead_or_dying(guy)) {
      guy function_d3262c3e00795e21();
    }
  }

  utility::flag_set("flag_killed_level_3_enemies");

  if(!function_143af7d577e696a4()) {
    namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  }

  utility::flag_set("flag_descend_level_3_allies_disengage");
}

function function_7e952b38489b2054() {
  utility::delaythread(0, &function_b41340a6c57b3d4a, "level_3_smoke_grenade_2");
  wait 1;
  doors = getEntArray("level_3_door", "targetname");
  var_c0e2fc68b36ccf50 = utility::getStruct(doors[0].target, "targetname");
  var_c0e2ff68b36cd5e9 = utility::getStruct(var_c0e2fc68b36ccf50.target, "targetname");
  var_a5ea61937b8eb235 = utility::getStruct(doors[1].target, "targetname");
  var_a5ea5e937b8eab9c = utility::getStruct(var_a5ea61937b8eb235.target, "targetname");
  level_3_door_left_clip = getEnt("level_3_door_left_clip", "targetname");

  if(isDefined(level_3_door_left_clip)) {
    level_3_door_left_clip show();
    level_3_door_left_clip disconnectPaths();
  }

  level_3_door_right_clip = getEnt("level_3_door_right_clip", "targetname");

  if(isDefined(level_3_door_right_clip)) {
    level_3_door_right_clip show();
    level_3_door_right_clip disconnectPaths();
  }

  level.var_1431a1d92bb32369 = utility::array_spawn_targetname("ambushers_door_group", 1);
  utility::array_thread(level.var_1431a1d92bb32369, &function_df80ba83de168f97);
  utility::array_thread(level.var_1431a1d92bb32369, &function_f3d9db81102372);
  flag_set("flag_descend_level_3_ambushers_spawned");
  doors[0] rotateTo(var_c0e2fc68b36ccf50.angles, 0.6, 0.5, 0.1);
  doors[0] thread utility::delaycall(0.6, &rotateto, var_c0e2ff68b36cd5e9.angles, 12, 3, 2);
  doors[1] rotateTo(var_a5ea61937b8eb235.angles, 0.8, 0.4, 0.1);
  doors[1] thread utility::delaycall(0.8, &rotateto, var_a5ea5e937b8eab9c.angles, 15, 5, 2);
  thread namespace_165c742e346e899e::metal_door_slam_open();
}

function function_7556f8e22a47ffb4() {
  utility::flag_wait("flag_stop_5");
  third_encounter = utility::array_spawn_targetname("third_encounter", 1);
  level.third_encounter_guard = getEnt("third_encounter_guard", "script_noteworthy");
  level.third_encounter_guard.health = 100000;
  prisoner = getEnt("third_encounter_prisoner", "script_noteworthy");
  level.third_encounter_guard.animname = "scenario_3_guard";
  prisoner.animname = "scenario_3_prisoner";
  animnode = utility::getStruct("scene_panopticon_scenario_3", "targetname");
  character_array = [level.third_encounter_guard, prisoner];
  shot_array = ["shot_010_idle_start"];
  animnode thread scene::play(character_array, shot_array);
  utility::flag_wait("flag_leaving_level_3");
  prisoner thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  level.third_encounter_guard thread namespace_9c93a5b828db4a4b::function_5353f2029567d563(6000);
  shot_array = ["shot_020_guard_prisoner_shoot"];
  animnode thread scene::play(character_array, shot_array);
  level.third_encounter_guard thread utility::flag_on_death("flag_descend_holdup_guard_dead");
  wait 2;
  level.third_encounter_guard thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  animnode scene::function_bc521bee52fde214(0.8);

  if(!utility::is_dead_or_dying(level.third_encounter_guard)) {
    level.third_encounter_guard utility::waittill_any_timeout(3, "damage");
  }

  if(isDefined(level.third_encounter_guard) && !utility::is_dead_or_dying(level.third_encounter_guard)) {
    flag_set("ally_1_can_shoot_third_encounter_guard");
  }

  while(!utility::is_dead_or_dying(level.third_encounter_guard)) {
    waitframe();
  }

  utility::flag_set("flag_descend_holdup_guard_dead");

  if(isDefined(prisoner) && !utility::is_dead_or_dying(prisoner)) {
    prisoner.goalradius = 8;
    prisoner function_b661b022700ba72f("script", 1);
    prisoner function_d5cda8a759cc36bc("flee");
    goal_node = getnode("prisoner_3_goal", "targetname");
    prisoner setgoalnode(goal_node);
    waitframe();
    prisoner function_d5cda8a759cc36bc("cower");
  }
}

function function_93042866211a9029() {
  bottom_left_riot_shield_guy_02 = utility::spawn_targetname("bottom_left_riot_shield_guy_02", 1);
  bottom_left_riot_prisoner_guy_03 = utility::spawn_targetname("bottom_left_riot_prisoner_guy_03", 1);
  bottom_left_riot_shield_guy_04 = utility::spawn_targetname("bottom_left_riot_shield_guy_04", 1);
  bottom_left_riot_prisoner_guy_05 = utility::spawn_targetname("bottom_left_riot_prisoner_guy_05", 1);
  bottom_left_riot_shield_guy_01 = utility::spawn_targetname("bottom_left_riot_shield_guy_01", 1);
  bottom_left_riot_prisoner_guy_02 = utility::spawn_targetname("bottom_left_riot_prisoner_guy_02", 1);
  bottom_left_riot_shield_guy_03 = utility::spawn_targetname("bottom_left_riot_shield_guy_03", 1);
  bottom_left_riot_prisoner_guy_01 = utility::spawn_targetname("bottom_left_riot_prisoner_guy_01", 1);
  thread namespace_165c742e346e899e::function_bb508ef505b312b2(bottom_left_riot_shield_guy_01, bottom_left_riot_shield_guy_02, bottom_left_riot_shield_guy_03, bottom_left_riot_shield_guy_04);
  thread namespace_165c742e346e899e::function_461058a3a2d50aff(bottom_left_riot_shield_guy_01, bottom_left_riot_shield_guy_02, bottom_left_riot_shield_guy_03, bottom_left_riot_shield_guy_04);
  waitframe();
  level.var_622d18e0498316ce = [bottom_left_riot_shield_guy_02, bottom_left_riot_shield_guy_04, bottom_left_riot_shield_guy_01, bottom_left_riot_shield_guy_03];
  utility::array_thread(level.var_622d18e0498316ce, &function_f3d9db81102372);
  bottom_left_riot_shield_guy_02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_left_riot_prisoner_guy_03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_left_riot_shield_guy_04 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_left_riot_prisoner_guy_05 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_left_riot_shield_guy_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_left_riot_prisoner_guy_02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_left_riot_shield_guy_03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_left_riot_prisoner_guy_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_left_riot_shield_guy_02 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_01_damaged");
  bottom_left_riot_prisoner_guy_03 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_01_damaged");
  bottom_left_riot_shield_guy_04 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_02_damaged");
  bottom_left_riot_prisoner_guy_05 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_02_damaged");
  bottom_left_riot_shield_guy_01 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_03_damaged");
  bottom_left_riot_prisoner_guy_02 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_03_damaged");
  bottom_left_riot_shield_guy_03 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_04_damaged");
  bottom_left_riot_prisoner_guy_01 thread function_f4b19c46a8dc30e8("flag_level_g_riot_l_pair_04_damaged");
  bottom_left_riot_shield_guy_02 thread function_529fb6c65ef6bad3("flag_level_g_riot_l_pair_01_damaged");
  bottom_left_riot_prisoner_guy_03 thread function_5830c787f8dc3dc("flag_level_g_riot_l_pair_01_damaged");
  bottom_left_riot_shield_guy_04 thread function_529fb6c65ef6bad3("flag_level_g_riot_l_pair_02_damaged");
  bottom_left_riot_prisoner_guy_05 thread function_5830c787f8dc3dc("flag_level_g_riot_l_pair_02_damaged");
  bottom_left_riot_shield_guy_01 thread function_529fb6c65ef6bad3("flag_level_g_riot_l_pair_03_damaged");
  bottom_left_riot_prisoner_guy_02 thread function_5830c787f8dc3dc("flag_level_g_riot_l_pair_03_damaged");
  bottom_left_riot_shield_guy_03 thread function_529fb6c65ef6bad3("flag_level_g_riot_l_pair_04_damaged");
  bottom_left_riot_prisoner_guy_01 thread function_5830c787f8dc3dc("flag_level_g_riot_l_pair_04_damaged");
  var_a0f9ea1e10768aef = [bottom_left_riot_shield_guy_02, bottom_left_riot_prisoner_guy_03];
  var_a0f9eb1e10768d22 = [bottom_left_riot_shield_guy_04, bottom_left_riot_prisoner_guy_05];
  var_a0f9ec1e10768f55 = [bottom_left_riot_shield_guy_01, bottom_left_riot_prisoner_guy_02];
  var_a0f9e51e10767ff0 = [bottom_left_riot_shield_guy_03, bottom_left_riot_prisoner_guy_01];
  function_a9aa5770d19631a4("jup_vip_riot_clash_L_01", ["shot_010", "shot_020"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_l_pair_01_damaged", var_a0f9ea1e10768aef, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_L_02", ["shot_030", "shot_040"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_l_pair_02_damaged", var_a0f9eb1e10768d22, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_L_03", ["shot_050", "shot_060"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_l_pair_03_damaged", var_a0f9ec1e10768f55, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_L_04", ["shot_070", "shot_080"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_l_pair_04_damaged", var_a0f9e51e10767ff0, undefined, 1);
  bottom_right_riot_shield_guy_02 = utility::spawn_targetname("bottom_right_riot_shield_guy_02", 1);
  bottom_right_riot_prisoner_guy_03 = utility::spawn_targetname("bottom_right_riot_prisoner_guy_03", 1);
  bottom_right_riot_shield_guy_04 = utility::spawn_targetname("bottom_right_riot_shield_guy_04", 1);
  bottom_right_riot_prisoner_guy_05 = utility::spawn_targetname("bottom_right_riot_prisoner_guy_05", 1);
  bottom_right_riot_shield_guy_01 = utility::spawn_targetname("bottom_right_riot_shield_guy_01", 1);
  bottom_right_riot_prisoner_guy_02 = utility::spawn_targetname("bottom_right_riot_prisoner_guy_02", 1);
  bottom_right_riot_shield_guy_03 = utility::spawn_targetname("bottom_right_riot_shield_guy_03", 1);
  bottom_right_riot_prisoner_guy_01 = utility::spawn_targetname("bottom_right_riot_prisoner_guy_01", 1);
  bottom_right_riot_shield_guy_06 = utility::spawn_targetname("bottom_right_riot_shield_guy_06", 1);
  bottom_right_riot_prisoner_guy_04 = utility::spawn_targetname("bottom_right_riot_prisoner_guy_04", 1);
  thread namespace_165c742e346e899e::function_6bf4417f8523d77f(bottom_right_riot_shield_guy_01, bottom_right_riot_shield_guy_02, bottom_right_riot_shield_guy_03, bottom_right_riot_shield_guy_04, bottom_right_riot_shield_guy_06);
  thread namespace_165c742e346e899e::function_3fc486a245c54b0(bottom_right_riot_shield_guy_01, bottom_right_riot_shield_guy_02, bottom_right_riot_shield_guy_03, bottom_right_riot_shield_guy_04, bottom_right_riot_shield_guy_06);
  waitframe();
  bottom_right_riot_shield_guy_02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_right_riot_prisoner_guy_03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_right_riot_shield_guy_04 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_right_riot_prisoner_guy_05 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_right_riot_shield_guy_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_right_riot_prisoner_guy_02 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_right_riot_shield_guy_03 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_right_riot_prisoner_guy_01 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_right_riot_shield_guy_06 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4(1);
  bottom_right_riot_prisoner_guy_04 thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
  bottom_right_riot_shield_guy_02 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_01_damaged");
  bottom_right_riot_prisoner_guy_03 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_01_damaged");
  bottom_right_riot_shield_guy_04 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_02_damaged");
  bottom_right_riot_prisoner_guy_05 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_02_damaged");
  bottom_right_riot_shield_guy_01 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_03_damaged");
  bottom_right_riot_prisoner_guy_02 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_03_damaged");
  bottom_right_riot_shield_guy_03 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_04_damaged");
  bottom_right_riot_prisoner_guy_01 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_04_damaged");
  bottom_right_riot_shield_guy_06 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_05_damaged");
  bottom_right_riot_prisoner_guy_04 thread function_f4b19c46a8dc30e8("flag_level_g_riot_r_pair_05_damaged");
  bottom_right_riot_shield_guy_02 thread function_529fb6c65ef6bad3("flag_level_g_riot_r_pair_01_damaged");
  bottom_right_riot_prisoner_guy_03 thread function_5830c787f8dc3dc("flag_level_g_riot_r_pair_01_damaged");
  bottom_right_riot_shield_guy_04 thread function_529fb6c65ef6bad3("flag_level_g_riot_r_pair_02_damaged");
  bottom_right_riot_prisoner_guy_05 thread function_5830c787f8dc3dc("flag_level_g_riot_r_pair_02_damaged");
  bottom_right_riot_shield_guy_01 thread function_529fb6c65ef6bad3("flag_level_g_riot_r_pair_03_damaged");
  bottom_right_riot_prisoner_guy_02 thread function_5830c787f8dc3dc("flag_level_g_riot_r_pair_03_damaged");
  bottom_right_riot_shield_guy_03 thread function_529fb6c65ef6bad3("flag_level_g_riot_r_pair_04_damaged");
  bottom_right_riot_prisoner_guy_01 thread function_5830c787f8dc3dc("flag_level_g_riot_r_pair_04_damaged");
  bottom_right_riot_shield_guy_06 thread function_529fb6c65ef6bad3("flag_level_g_riot_r_pair_05_damaged");
  bottom_right_riot_prisoner_guy_04 thread function_5830c787f8dc3dc("flag_level_g_riot_r_pair_05_damaged");
  var_1c7a5676a13cf025 = [bottom_right_riot_shield_guy_02, bottom_right_riot_prisoner_guy_03];
  var_1c7a5376a13ce98c = [bottom_right_riot_shield_guy_04, bottom_right_riot_prisoner_guy_05];
  var_1c7a5476a13cebbf = [bottom_right_riot_shield_guy_01, bottom_right_riot_prisoner_guy_02];
  var_1c7a5176a13ce526 = [bottom_right_riot_shield_guy_03, bottom_right_riot_prisoner_guy_01];
  var_1c7a5276a13ce759 = [bottom_right_riot_shield_guy_06, bottom_right_riot_prisoner_guy_04];
  function_a9aa5770d19631a4("jup_vip_riot_clash_R_01", ["shot_010", "shot_020"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_r_pair_01_damaged", var_1c7a5676a13cf025, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_R_02", ["shot_030", "shot_040"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_r_pair_02_damaged", var_1c7a5376a13ce98c, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_R_03", ["shot_050", "shot_060"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_r_pair_03_damaged", var_1c7a5476a13cebbf, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_R_04", ["shot_070", "shot_080"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_r_pair_04_damaged", var_1c7a5176a13ce526, undefined, 1);
  function_a9aa5770d19631a4("jup_vip_riot_clash_R_05", ["shot_090", "shot_100"], "flag_obj_reach_makarov_complete", 0.2, "flag_level_g_riot_r_pair_05_damaged", var_1c7a5276a13ce759, undefined, 1);
}

function function_a9aa5770d19631a4(var_d85d9cb5e98ed736, shots, endon_flag, time_fraction, breakout_flag, existingentities, var_360f1e66fe40e371, var_5422a1bcd9870344, var_9e5572c2484aee3e) {
  animnodes = utility::getStructArray(var_d85d9cb5e98ed736, "targetname");

  foreach(node in animnodes) {
    thread function_563d01353542e321(node, shots, endon_flag, time_fraction, breakout_flag, existingentities, var_360f1e66fe40e371, var_5422a1bcd9870344, var_9e5572c2484aee3e);
  }
}

function private function_66c9721f50412ba6(animnode, breakout_flag, existingentities) {
  if(!isDefined(breakout_flag)) {
    return;
  }

  utility::flag_wait(breakout_flag);

  if(isDefined(level.var_b03c39f14f72c725) && isDefined(level.var_be7a6f4bb2b1394b)) {
    if(isDefined(existingentities)) {
      if(isarray(existingentities)) {
        foreach(guy in existingentities) {
          if(guy == level.var_b03c39f14f72c725) {
            animnode scene::stop();
            waitframe();
            function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, guy);
            return;
          }
        }
      } else if(existingentities == level.var_b03c39f14f72c725) {
        animnode scene::stop();
        waitframe();
        function_60daa23100a2b874(level.var_be7a6f4bb2b1394b, existingentities);
        return;
      }
    }
  }

  react_offset = randomfloatrange(0.5, 1.5);
  wait react_offset;
  animnode scene::stop();
}

function private function_563d01353542e321(animnode, shots, endon_flag, time_fraction, breakout_flag, existingentities, var_360f1e66fe40e371, var_5422a1bcd9870344, var_9e5572c2484aee3e) {
  animnode thread scene::play(existingentities, shots, undefined, time_fraction);
  animnode function_80d26e9184fea124(breakout_flag, var_5422a1bcd9870344, var_9e5572c2484aee3e, shots);

  if(!isDefined(var_360f1e66fe40e371) || var_360f1e66fe40e371 == 1) {
    thread function_66c9721f50412ba6(animnode, breakout_flag, existingentities);
  }

  if(!isDefined(endon_flag)) {
    return;
  }

  if(isarray(endon_flag)) {
    utility::function_7a252abaaa15fcd7(endon_flag);
  } else {
    utility::flag_wait(endon_flag);
  }

  animnode scene::cleanup(1);

  if(!isDefined(animnode.var_cf24d127aa3920a0)) {
    return;
  }

  foreach(object in animnode.var_cf24d127aa3920a0) {
    object delete();
  }
}

function function_80d26e9184fea124(var_dc5425f09814e79a, var_5422a1bcd9870344, var_9e5572c2484aee3e, shots) {
  scene_ents = scene::get_entities();
  var_a2698ed003071f17 = self;

  foreach(guy in scene_ents) {
    if(!isDefined(guy)) {
      continue;
    }

    if(!utility::is_equal(guy.animtree, "generic_human")) {
      continue;
    }

    if(utility::is_equal(guy.team, "axis")) {
      guy utility::function_1a479cad9c3adbb1(0);
      guy.context_melee_allowed = 0;

      if(isai(guy)) {
        guy actoraimassistoff();
      }

      if(var_a2698ed003071f17.script_scenescriptbundle == "jup_vip_riot_clash") {
        guy namespace_9c93a5b828db4a4b::function_490f29409c2f4249();
      } else {
        guy namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e();
      }

      if(var_a2698ed003071f17.script_scenescriptbundle == "vip_0800_group1" || var_a2698ed003071f17.script_scenescriptbundle == "vip_0800_group2") {
        if(isDefined(shots) && shots[0] == "shot_020") {
          thread function_aeef9381b04e37d0(guy);
        }
      }

      continue;
    }

    if(var_a2698ed003071f17.script_scenescriptbundle == "jup_vip_riot_clash") {
      guy namespace_9c93a5b828db4a4b::function_dfec397a9c5e2aab();
    } else {
      guy namespace_9c93a5b828db4a4b::function_84972f5da4b3994b();

      if(isDefined(var_dc5425f09814e79a)) {
        if(var_dc5425f09814e79a == "level_1_enemy_damaged") {
          guy thread function_2ee9e8d6a1b3ba62(var_dc5425f09814e79a);
        }
      } else if(guy.classname != "script_model") {
        guy utility::add_damage_function(&function_d799ec6e01836246);
      }
    }

    guy.deathfunction = &function_ce450b9957138bd5;

    if(isDefined(var_5422a1bcd9870344) && var_5422a1bcd9870344) {
      guy function_672fd16c1e8480a4(1);
    } else {
      guy function_672fd16c1e8480a4(0);
    }

    if(isDefined(var_9e5572c2484aee3e)) {
      var_a2698ed003071f17 thread function_818e37d4b4717611(var_9e5572c2484aee3e, guy);
    }
  }
}

function function_aeef9381b04e37d0(guy) {
  while(scene::get_state() == "Playing") {
    waitframe();
  }

  if(isDefined(guy)) {
    guy notify("aud_grapple_guy_interuppted");
  }
}

function function_818e37d4b4717611(var_9e5572c2484aee3e, guy) {
  self endon("death");
  flag_wait(var_9e5572c2484aee3e);

  while(isDefined(self) && scene::get_state() == "Playing") {
    waitframe();
  }

  wait 1;

  if(!is_dead_or_dying(guy)) {
    if(guy.classname != "script_model") {
      guy thread function_4f46323e9dc18ea3();
    }
  }
}

function function_8595b85eca795ef0() {
  return getdvarint(@ "hash_755c77cf196c015f", 0) != 0;
}

function function_dea7ed64c2923f46() {
  self waittill("nvg_on");
  self nightvisionviewon(1);
  thread namespace_165c742e346e899e::function_632bfcbdb195bc04();
  setsaveddvar(@ "hash_ac413fc6c99ddeeb", 0.3);
  utility::flag_set("flag_descend_player_nvg_on");
}

function function_85e0c72c5866e4a4() {
  level.player endon("death");
  thread function_d818b006c6bb99de();
  self waittill("scene_complete");
  waitframe();
  self waittill("scene_complete");
}

function function_d818b006c6bb99de() {
  level.player endon("death");
  level.player val::set("vip_player", "show_legs_and_shadow", 1);
  level.player waittill("ascender_attached");
  level.player function_5ee68a5b461ab5b8(0);
  level.player waittill_either("ascender_legs_disable", "ascender_detach_complete");
  level.player val::set("vip_player", "show_legs_and_shadow", 0);
  animnode = utility::getStruct("scene_vip_0620_descend_vm_detached_rope", "targetname");

  if(isDefined(animnode)) {
    animnode.origin = level.player.origin;
    animnode.angles = level.player.angles;
    animnode thread scene::play(undefined, "shot_010");
    utility::flag_wait("flag_obj_reach_makarov_complete");
    animnode scene::stop();
  }

  setsaveddvar(@ "hash_e25973f21baa3bad", 0);
  setsaveddvar(@ "hash_342c89634f966b1", 0);
  setsaveddvar(@ "hash_1c2634c4ee0cf540", 200);
  setsaveddvar(@ "hash_7c3ea2f8e170a3ff", 200);
}

function function_622e7b5c7b909510(name) {
  descend_states = [["descend_start", &function_e50fa344285e9dd6], ["descend_move", &function_dbc0ecaf2b5fa981, &function_851ada3df4784c20], ["descend_end", &function_43650c512642166b], ["shoot", &function_7463bb96fc3f0224, &function_73e466d846d215cb], ["idle", &function_67056f8b32e0ce29, &function_99410dc9e5566148], ["exit"]];
  self.descend_mover = spawn("script_origin", self.origin);
  self.descend_mover.angles = self.angles;
  self.descend_mover.script_scenescriptbundle = "vip_0640_alphateam_descend";
  self.descend_mover.targetname = "vip_0640_alphateam_descend";
  self.var_a5b8326e0a4d80e = 1;
  self.var_a523960b4b241765 = 10;
  self linkTo(self.descend_mover);

  if(!isDefined(name)) {
    name = "Ally01";
  }

  self.descend_name = name;
  thread function_fd419f2b5f8858f2("stationary_idle");
  thread function_685f916602e2f67e();
  thread statemachine::begin_fsm(descend_states, "idle");
}

function function_fd419f2b5f8858f2(animname) {
  if(istrue(self.var_5b7b0ea5c92175e1)) {
    return;
  }

  if(!isDefined(self getlinkedparent())) {
    self linkTo(self.descend_mover);
  }

  self.descend_mover scene::play([self], animname);

  if(!isDefined(self getlinkedparent())) {
    self linkTo(self.descend_mover);
  }
}

function function_9171717a9886dc55() {
  if(istrue(self.started_testing)) {
    return;
  }

  self.started_testing = 1;
  function_1b32ce95e1099942(level.player, 0, 0, 2);
  wait 2;
  thread statemachine::goto_state("shoot");
  wait 2;
  var_3256e9410b368e4b = (0, 0, 0);
  var_e613ff08f4909a47 = (0, 0, 0);

  for(i = 0; i < 60; i++) {
    var_3b0370857dc824e3 = self gettagorigin("<dev string:x2ca>");
    dir = anglesToForward(self gettagangles("<dev string:x2ca>"));
    var_6d8ec0de3ed65e6b = anglesToForward(self.descend_mover.angles);
    offset = self gettagorigin("<dev string:x2ca>") - self.descend_mover.origin;
    var_8391ef6076730fd0 = rotatevectorinverted(offset, self.descend_mover.angles);
    line(var_3b0370857dc824e3, var_3b0370857dc824e3 + dir * 200, (1, 0, 0));
    line(var_3b0370857dc824e3, var_3b0370857dc824e3 + (dir[0], dir[1], 0) * 200, (0, 0, 1));
    line(self.descend_mover.origin, self.descend_mover.origin + offset);
    sphere(var_3b0370857dc824e3, 5);
    sphere(self.descend_mover.origin, 5);
    iprintln(var_8391ef6076730fd0);
    diff = self.descend_mover.angles - self gettagangles("<dev string:x2ca>");
    var_3256e9410b368e4b += diff;
    var_e613ff08f4909a47 += var_8391ef6076730fd0;
    waitframe();
  }

  wait 2;
  var_3256e9410b368e4b /= 60;
  var_e613ff08f4909a47 /= 60;
  iprintln("<dev string:x2d4>" + var_3256e9410b368e4b);
  iprintln("<dev string:x2db>" + var_e613ff08f4909a47);
}

function function_67056f8b32e0ce29() {
  if(istrue(self.var_5b7b0ea5c92175e1)) {
    return;
  }

  thread function_fd419f2b5f8858f2("stationary_idle");
}

function function_ddc0185e520313fa() {
  return isDefined(self.descend_target) && (isalive(self.descend_target) || !isai(self.descend_target));
}

function function_79398925599cb93() {
  if(isDefined(self.var_3c317ec489b5e32b)) {
    vdistance = self.descend_mover.origin[2] - self.descend_point[2];
    self.descend_speed = vdistance / self.var_3c317ec489b5e32b;

    if(isDefined(self.descend_target)) {
      aim_angles = function_b1c6fc6120d48ca1();
      yaw_diff = abs(self.descend_mover.angles[1] - aim_angles[1]);
      self.var_6e98bac3b8b24ab5 = yaw_diff / self.var_3c317ec489b5e32b;
    }

    return;
  }

  self.descend_speed = randomfloatrange([60, 80][0], [60, 80][1]);
}

function function_99410dc9e5566148() {
  if(istrue(self.var_5b7b0ea5c92175e1)) {
    return;
  }

  if(function_ddc0185e520313fa() && istrue(self.var_583b6383e32e5a7f)) {
    statemachine::goto_state("shoot");
    return;
  }

  if(isDefined(self.descend_point)) {
    vdistance = self.descend_mover.origin[2] - self.descend_point[2];

    if(vdistance > 5) {
      statemachine::goto_state("descend_start");
    }
  }
}

function function_fc4e9265baa59458() {
  waitframe();
  utility::flag_set("descend_fsm_done_" + self.descend_name);
}

function function_7194767729a71b2e(aim_angles) {
  while(true) {
    if(!isDefined(self.descend_target)) {
      waitframe();
      continue;
    }

    line(self gettagorigin("<dev string:x2e4>"), self.descend_target.origin, (255, 255, 255), 1, 1, 1);
    target_point = (self.descend_mover.origin[0], self.descend_mover.origin[1], self.descend_target.origin[2]);
    v_offset = function_578f53497852b35e();
    line(target_point, target_point + (0, 0, v_offset));

    waitframe();
  }
}

function function_b1c6fc6120d48ca1() {
  if(!isDefined(self.descend_target)) {
    return undefined;
  }

  gun_origin = self.descend_mover.origin - rotatevector((-16.84, -4.3, 30.96), self.descend_mover.angles);
  var_339b99a0c9ed9168 = self.descend_target.origin - gun_origin;
  var_339b99a0c9ed9168 = (var_339b99a0c9ed9168[0], var_339b99a0c9ed9168[1], 0);
  var_339b99a0c9ed9168 = vectorNormalize(var_339b99a0c9ed9168);
  rightvector = vectorcross(var_339b99a0c9ed9168, (0, 0, 1));
  aim_angles = axistoangles(var_339b99a0c9ed9168, rightvector, (0, 0, 1));
  target_angles = aim_angles - (0, 37.77, 0);
  return target_angles;
}

function function_578f53497852b35e() {
  if(!self tagexists("tag_laser")) {
    return 0;
  }

  var_42bf0b924ceeebb2 = self gettagorigin("tag_laser");
  return distance2d(self.descend_mover.origin, self.descend_target.origin) * tan(26.98) - self.var_a523960b4b241765 - var_42bf0b924ceeebb2[2] - self.descend_mover.origin[2];
}

function function_30ade328c99c667c(a, b) {
  forwards = abs(a - b);
  backwards = ter_op(a > b, 360 - a + b, 360 - b + a);
  return min(forwards, backwards);
}

function function_685f916602e2f67e() {
  self endon("descend_stop_aiming");
  var_7e70b89613643be8 = undefined;

  if(isDefined(self.var_6e98bac3b8b24ab5)) {
    speed = self.var_6e98bac3b8b24ab5;
  } else {
    speed = randomfloatrange([100, 120][0], [100, 120][1]);
  }

  angledelta = 1000;

  while(true) {
    while(!function_ddc0185e520313fa()) {
      waitframe();
    }

    if(!utility::is_equal(var_7e70b89613643be8, self.descend_target)) {
      wait 0.3;
    }

    if(!function_ddc0185e520313fa()) {
      var_7e70b89613643be8 = self.descend_target;
      continue;
    }

    target_angles = function_b1c6fc6120d48ca1();
    angledelta = function_30ade328c99c667c(target_angles[1], self.descend_mover.angles[1]);
    var_a138aa227043a34b = speed / 10;

    if(angledelta < var_a138aa227043a34b) {
      vdistance = self.descend_mover.origin[2] - self.descend_point[2];

      if(vdistance < 5) {
        self.var_583b6383e32e5a7f = 1;
      }

      self.var_6e98bac3b8b24ab5 = undefined;
      self.descend_mover.angles = target_angles;
    } else {
      var_b5b3431a0126e171 = anglelerpquat(self.descend_mover.angles, target_angles, speed / 20);
      self.descend_mover rotateTo(var_b5b3431a0126e171, 0.05, 0, 0);
    }

    var_7e70b89613643be8 = self.descend_target;
    waitframe();
  }
}

function function_49c86767f2e53440(var_f96f8c8a89216ea, timetomove) {
  self.descend_target = undefined;
  self.descend_point = (self.descend_mover.origin[0], self.descend_mover.origin[1], var_f96f8c8a89216ea);
  self.var_3c317ec489b5e32b = timetomove;
  function_79398925599cb93();
}

function function_db5eb753be437e37(point, timetomove) {
  function_49c86767f2e53440(point[2], timetomove);
}

function function_c45b3677cc6daafe(finalangles) {
  self.var_8100762b968485df = 1;
  self notify("descend_stop_aiming");
  self.descend_mover rotateTo(finalangles, 1, 0.25, 0.25);
}

function function_eaa9ef50c7242c99() {
  if(!isDefined(self.descend_target) || !isalive(self.descend_target)) {
    return;
  }

  self.var_785fbcb7e9f743a9 = 1;
}

function function_c39b7d5bebf23d8f(shotcount) {
  self.var_a5b8326e0a4d80e = shotcount;
}

function function_1b32ce95e1099942(target, var_6291bf4ed7f9a322, canmove, timetomove) {
  if(!isDefined(target)) {
    return;
  }

  self.descend_target = target;
  self.var_583b6383e32e5a7f = 0;
  self.var_b6198f8f921d0b28 = var_6291bf4ed7f9a322;

  if(!isDefined(canmove) || canmove) {
    v_offset = function_578f53497852b35e();
    target_point = (self.descend_mover.origin[0], self.descend_mover.origin[1], target.origin[2] + v_offset);

    if(target_point[2] < self.descend_mover.origin[2]) {
      if(isDefined(timetomove)) {
        if(timetomove < 1) {
          self.descend_mover.origin = target_point;
          return;
        }

        self.var_3c317ec489b5e32b = timetomove;
      }

      self.descend_point = target_point;
      function_79398925599cb93();
    } else {
      self.descend_point = self.descend_mover.origin;
    }

    return;
  }

  self.descend_point = self.descend_mover.origin;
}

function function_7463bb96fc3f0224() {
  self.var_27d54c9e26833c55 = 0;
  function_fd419f2b5f8858f2("aim_middle_enter");

  if(!function_ddc0185e520313fa()) {
    statemachine::goto_state("idle");
    self.var_27d54c9e26833c55 = 1;
    return;
  }

  thread function_fd419f2b5f8858f2("aim_middle_idle");
  self.var_27d54c9e26833c55 = 1;
}

function function_73e466d846d215cb() {
  if(!istrue(self.var_27d54c9e26833c55)) {
    return;
  }

  if(!isDefined(self.descend_target)) {
    statemachine::goto_state("idle");
    return;
  }

  if(!isai(self.descend_target)) {
    vdistance = self.origin[2] - self.descend_point[2];

    if(vdistance < 5) {
      return;
    } else {
      self.var_583b6383e32e5a7f = 0;
      statemachine::goto_state("idle");
      return;
    }
  } else if(!isalive(self.descend_target)) {
    statemachine::goto_state("idle");
    return;
  }

  if(!istrue(self.var_785fbcb7e9f743a9) && (!istrue(self.var_b6198f8f921d0b28) || !istrue(self.var_583b6383e32e5a7f))) {
    return;
  }

  thread function_fd419f2b5f8858f2("shoot_middle");
  self shoot(1, self.descend_target);
  self.var_a5b8326e0a4d80e -= 1;

  if(self.var_a5b8326e0a4d80e < 1) {
    self.descend_target kill(self.descend_target.origin, self);
    self.var_b6198f8f921d0b28 = 0;
    self.descend_target = undefined;
    self.var_583b6383e32e5a7f = 1;
    self.var_785fbcb7e9f743a9 = 0;
    self.var_a5b8326e0a4d80e = 1;
  }

  wait 0.27;

  if(!isDefined(self.descend_target) || !isalive(self.descend_target)) {
    function_fd419f2b5f8858f2("aim_middle_exit");
    statemachine::goto_state("idle");
  }
}

function function_e50fa344285e9dd6() {
  ramptime = randomfloatrange([0.87, 0.88][0], [0.87, 0.88][1]);
  thread function_fd419f2b5f8858f2("descend_enter");
  targetpoint = self.origin - (0, 0, self.descend_speed * ramptime);
  self.descend_mover moveTo(targetpoint, ramptime, ramptime, 0);
  wait ramptime;
  statemachine::goto_state("descend_move");
}

function function_dbc0ecaf2b5fa981(distance, delay, time) {
  thread function_fd419f2b5f8858f2("descend_idle");
  self.var_1466fc7064208992 = randomfloatrange([0.49, 0.51][0], [0.49, 0.51][1]);
}

function function_851ada3df4784c20() {
  vdistance = self.descend_mover.origin[2] - self.descend_point[2];

  if(vdistance < self.descend_speed * self.var_1466fc7064208992) {
    statemachine::goto_state("descend_end");
    return;
  }

  var_ad8cb398ceefee68 = self.descend_mover.origin - (0, 0, self.descend_speed / 20);
  self.descend_mover moveTo(var_ad8cb398ceefee68, 0.05, 0, 0);
}

function function_43650c512642166b() {
  if(istrue(self.var_8100762b968485df)) {
    zoffset = self gettagorigin("tag_origin")[2] - self.descend_mover.origin[2];
    self.descend_point -= (0, 0, zoffset);
    vdistance = self.descend_mover.origin[2] - self.descend_point[2];
    time = vdistance / self.descend_speed;
    self.descend_mover moveTo(self.descend_point, time, 0, 0);
    wait time;
    self.var_5b7b0ea5c92175e1 = 1;
    thread function_fc4e9265baa59458();
    statemachine::goto_state("exit");
    return;
  }

  self.descend_mover moveTo(self.descend_point, self.var_1466fc7064208992, 0, self.var_1466fc7064208992);
  function_fd419f2b5f8858f2("descend_exit");
  statemachine::goto_state("idle");
}

function function_bb6c1d32e8c7aa7f() {
  self.fakelaser = spawn("script_model", self gettagorigin("tag_laser"));
  self.fakelaser.angles = self gettagangles("tag_laser");
  laserweapon = makeweapon("jup_vip_xbright_ir_scripted");
  self.fakelaser setmoverlaserweapon(laserweapon);
  self.fakelaser linkTo(self, "tag_laser");
  self.fakelaser setModel("tag_laser");
  self.fakelaser laseron();
  self laserforceoff();
  self laseroff();
  self.laserenabled = 0;
  thread function_5ed2a259ca732352();
}

function function_24ea96fe4af4dec9() {
  if(!isDefined(level.ally1.fakelaser) || !isDefined(level.ally2.fakelaser)) {
    return;
  }

  waitframe();
  level.ally1 notify("kill_laser_aim");
  level.ally2 notify("kill_laser_aim");
  level notify("kill_fakelasers");
  waitframe();
  level.ally1.laserenabled = 0;
  level.ally1.var_ac586f2e112c08cf = 1;
  level.ally1.fakelaser laseroff();
  level.ally1.fakelaser delete();
  level.ally2.laserenabled = 0;
  level.ally2.var_ac586f2e112c08cf = 1;
  level.ally2.fakelaser laseroff();
  level.ally2.fakelaser delete();
}

function clamp_angle(angle, target, delta) {
  difference = angleclamp180(target - angle);

  if(abs(difference) > delta) {
    return (difference > 0 ? angleclamp(target - delta) : angleclamp(target + delta));
  }

  return angle;
}

function function_b1efca9984ae3ea(angle, target, delta) {
  return (clamp_angle(angle[0], target[0], delta[0]), clamp_angle(angle[1], target[1], delta[1]), clamp_angle(angle[2], target[2], delta[2]));
}

function function_5ed2a259ca732352() {
  self endon("kill_laser_aim");
  laser_clamp = 0;
  lasttime = 0;
  var_9dc10f35c2ce7ad2 = 1000;
  var_d0200967e3b4fa48 = undefined;
  self.var_6c20f5686f111822 = "J_SpineUpper";

  while(true) {
    waitframe();

    if(!self.fakelaser islinked()) {
      continue;
    }

    var_e8e83272f6d7c09 = self gettagangles("tag_laser");

    if(!isDefined(self.descend_target) || !is_equal(self.descend_target, var_d0200967e3b4fa48) && laser_clamp != 0) {
      laser_clamp = 0;
      self.fakelaser rotatetolinked((0, 0, 0), 0.5);
      wait 0.5;
      lasttime = gettime();
      var_d0200967e3b4fa48 = self.descend_target;
      continue;
    }

    gun_origin = self gettagorigin("tag_laser");
    laser_clamp = clamp((gettime() - lasttime) / var_9dc10f35c2ce7ad2, 0, 1);
    angle_delta = vectorlerp((0, 0, 0), (30, 10, 5), laser_clamp);

    if(isai(self.descend_target)) {
      aim_pos = self.descend_target gettagorigin(self.var_6c20f5686f111822);
    } else {
      aim_pos = self.descend_target.origin;
    }

    var_339b99a0c9ed9168 = aim_pos - gun_origin;
    var_339b99a0c9ed9168 = vectorNormalize(var_339b99a0c9ed9168);
    aim_angles = vectortoangles(var_339b99a0c9ed9168);
    aim_angles = function_b1efca9984ae3ea(aim_angles, var_e8e83272f6d7c09, angle_delta);
    aim_angles = function_848155be2b7da2cb(var_e8e83272f6d7c09, aim_angles);
    self.fakelaser setlinkedangles(aim_angles);
  }
}

function function_d742184711940033() {
  level.player utility::ent_flag_wait("descend_ally_idle_start");
  array = [level.ally1, level.ally2];
  namespace_9c93a5b828db4a4b::function_37f2a21dd7f9971(1);
  level.ally2 function_622e7b5c7b909510("ally2");
  level.ally1 function_622e7b5c7b909510("ally1");
  utility::flag_set("flag_descend_allies_initialized");
}

function function_6bc1156c2325dd90() {
  transient_load("sp_jup_vip_cell_tr");
  wait 5;
  transient_unload("sp_jup_vip_piperoom_tr");
}

function function_4da5447b02b552fa() {
  utility::flag_wait("flag_enable_ally_detach");
  var_3b2390ff315e754d = -86.123;
  var_d12bd534714e7b25 = (0.676, 32.317, -3.508);
  var_7dcc9d6b395ba524 = -268.479;
  var_6747d79f46f82272 = (-1.956, -158.852, -1.003);
  level.ally1 function_49c86767f2e53440(var_3b2390ff315e754d, 4);
  level.ally2 function_49c86767f2e53440(var_7dcc9d6b395ba524, 4);
  level.ally1 function_c45b3677cc6daafe(var_d12bd534714e7b25);
  level.ally2 function_c45b3677cc6daafe(var_6747d79f46f82272);
  var_9cce3514d979f535 = utility::getStruct("scene_first_doorway_reach_mak", "targetname");
  thread function_2a28a35009dd823c();
  thread function_16cdb70d22a1a8df();
  utility::flag_wait("flag_descend_player_detached");
  thread function_6bc1156c2325dd90();
  utility::flag_set("flag_end_descend");
  allies = [level.ally1, level.ally2];
  utility::flag_wait_all("flag_descend_ally1_fully_detached", "flag_descend_ally2_fully_detached");
  namespace_9c93a5b828db4a4b::function_37f2a21dd7f9971(0);
  var_9cce3514d979f535 thread namespace_9c93a5b828db4a4b::function_57ac36ea7abb5af4(undefined, allies, ["shot_090_door_01_door_02_ally_01_breach"]);
  var_9cce3514d979f535 thread function_6fab71cdd028ba69();
  utility::activate_trigger_with_targetname("trig_allies_to_first_path_node");
  utility::flag_set_delayed("flag_reach_vip_door_2_opened", 1);
  flag_wait_any("flag_level_g_riot_l_pair_01_damaged", "flag_level_g_riot_l_pair_02_damaged", "flag_level_g_riot_l_pair_03_damaged", "flag_level_g_riot_l_pair_04_damaged", "flag_level_g_riot_l_pair_05_damaged");
  var_33fb3f54e3157316 = 0;

  if(isDefined(level.var_622d18e0498316ce)) {
    foreach(guy in level.var_622d18e0498316ce) {
      if(!utility::is_dead_or_dying(guy)) {
        var_33fb3f54e3157316++;
      }
    }
  }

  if(var_33fb3f54e3157316 > 0) {
    var_9cce3514d979f535 scene::stop();
    level.ally1 enable_ai_color();
    level.ally2 enable_ai_color();
    level.ally1.ignoreall = 0;
    level.ally2.ignoreall = 0;
    function_52b5aaee35540c0b(1);
  }
}

function function_6fab71cdd028ba69() {
  self waittill("scene_complete");
  waitframe();
  function_52b5aaee35540c0b(1);
}

function function_c1a7b95a7e94e655(ally) {
  waitframe();
  ally.descend_mover scene::stop();
  ally unlink();
}

function function_2a28a35009dd823c() {
  utility::flag_wait("descend_fsm_done_ally1");
  thread function_c1a7b95a7e94e655(level.ally1);
  animnode = utility::getStruct("scene_first_doorway_reach_mak", "targetname");
  animnode thread scene::play(level.ally1, "shot_010_detach_ally_01");
  thread namespace_165c742e346e899e::function_e89a46d1508b964b();
  level.ally1 waittill("descend_detach_ally1_atdoor");
  animnode thread scene::play(level.ally1, "shot_030_door_01_ally_01_idle");
  utility::flag_set("flag_descend_ally1_fully_detached");
  rope = animnode scene::get_entity("ally_01_rope");
  utility::flag_wait("flag_obj_reach_makarov_complete");
  rope delete();
}

function function_16cdb70d22a1a8df() {
  utility::flag_wait("descend_fsm_done_ally2");
  thread function_c1a7b95a7e94e655(level.ally2);
  animnode = utility::getStruct("scene_first_doorway_reach_mak", "targetname");
  thread namespace_165c742e346e899e::function_3d4fa2577f2d7512();
  level.ally2 thread vo_start();
  animnode thread scene::play(level.ally2, "shot_020_detach_ally_02");
  level.ally2 waittill("descend_detach_ally2_atdoor");
  animnode thread scene::play(level.ally2, "shot_040_door_01_ally_02_idle");
  utility::flag_set("flag_descend_ally2_fully_detached");
  rope = animnode scene::get_entity("ally_02_rope");
  utility::flag_wait("flag_obj_reach_makarov_complete");
  rope delete();
}

function vo_start() {
  wait 8;
  utility::flag_set("flag_reach_vip_open_door_2");
}

function function_96c77466fa259a95() {
  level endon("flag_end_descend");
  level endon("kill_fakelasers");
  thread function_138c42db00d9f81e();
  level.player waittill("ally1_laser_on");
  level.ally1 function_bb6c1d32e8c7aa7f();
  thread sp_jup_vip_lighting::function_4068626e9ddd7a11();
  level.player waittill("ally2_laser_on");
  level.ally2 function_bb6c1d32e8c7aa7f();

  while(true) {
    level.player waittill("night_vision_off");
    level.ally1.fakelaser laseroff();
    thread sp_jup_vip_lighting::function_82e700452debfc2d();
    level.ally2.fakelaser laseroff();
    level.player waittill("night_vision_on");
    level.ally1.fakelaser laseron();
    thread sp_jup_vip_lighting::function_4068626e9ddd7a11();
    level.ally2.fakelaser laseron();
  }
}

function function_138c42db00d9f81e() {
  utility::flag_wait("flag_end_descend");
  waitframe();
  thread sp_jup_vip_lighting::function_82e700452debfc2d();
  function_24ea96fe4af4dec9();
}

function function_6c502da1beda4da5() {
  level.var_315bbefab4471f73 = 0;
  level.player thread function_c74fe426fa61946c("lights_out_1", &sp_jup_vip_lighting::lights_out_1, 0.2);
  level.player thread function_8b8ab1de6aa32ce3("lights_out_2", &sp_jup_vip_lighting::lights_out_2, 0.5);
  level.player thread function_8b8ab1de6aa32ce3("lights_out_3", &sp_jup_vip_lighting::lights_out_3, 0.8);
  level.player thread function_8b8ab1de6aa32ce3("lights_out_4", &sp_jup_vip_lighting::lights_out_4, 1.2);
  level.player thread function_cfc266b5c493ea38("lights_out_5", &sp_jup_vip_lighting::lights_out_5, 5);
  utility::flag_wait("flag_descend_start_anim");
  wait 1;
  utility::flag_set("flag_panopticon_in_darkness");
  wait 3;
  utility::flag_set("flag_start_panopticon_background_guards");
}

function function_c74fe426fa61946c(notetrack, process, volume) {
  self waittill(notetrack);
  thread[[process]]();
  thread namespace_165c742e346e899e::function_ae2505fbe8427706();
  level.var_315bbefab4471f73++;
}

function function_8b8ab1de6aa32ce3(notetrack, process, volume) {
  self waittill(notetrack);
  thread[[process]]();
  level.var_315bbefab4471f73++;
}

function function_cfc266b5c493ea38(notetrack, process, volume) {
  self waittill(notetrack);
  thread[[process]]();
  thread namespace_165c742e346e899e::function_94d88335f8d56485();
  thread namespace_165c742e346e899e::function_8f4fac61a4ac9526();
  thread namespace_165c742e346e899e::function_387c7e41e257f7e3();
  thread namespace_165c742e346e899e::function_a7e5725d5345fa2d();
  level.var_315bbefab4471f73++;
}

function function_9346a90b6e9a603e() {
  utility::flag_wait("flag_descend_start_anim");

  if(function_8595b85eca795ef0()) {
    return;
  }

  function_a9aa5770d19631a4("vip_descend_control_prisoner_lines", undefined, "flag_control_room_clear");
  function_a9aa5770d19631a4("vip_descend_guards_prisoners_hallway", undefined, "flag_control_room_clear");
  utility::flag_wait("flag_start_panopticon_background_guards");
  hookup_background_guard = utility::array_spawn_targetname("hookup_background_guard", 1);

  foreach(guy in hookup_background_guard) {
    guy.pushable = 0;
    guy visiblenotsolid();
    guy enableavoidance(0, 0);
    guy.var_3119604b74dfdbbd = 0;
    guy setavoidanceradius(2);
    guy setavoidancereciprocity(0.1);

    if(utility::is_equal(guy.script_noteworthy, "slow_walker")) {
      guy demeanoroverride("combat");
      guy aisetdesiredspeed(50);
      continue;
    }

    guy aisetdesiredspeed(randomintrange(130, 160));
  }

  while(!isDefined(level.var_315bbefab4471f73)) {
    waitframe();
  }

  while(level.var_315bbefab4471f73 < 5 && !utility::flag("flag_obj_reach_descend_complete")) {
    waitframe();
  }

  foreach(guy in hookup_background_guard) {
    if(isalive(guy)) {
      guy.nocorpse = 1;
      guy.diequietly = 1;
      guy delete();
    }
  }
}

function function_35137d45a80929af(var_141b6c08b35b073e) {
  level.player endon("lookedat_level_1_pushdown");
  wait 7;
  vo_array = ["dx_sp_jvip_desc_koa1_alpha21checkthecellb", "dx_sp_jvip_desc_koa1_seeingguardssendshot", "dx_sp_jvip_desc_koa1_21gotguardsputrounds"];
  current_vo = 0;

  while(!utility::flag("flag_lookedat_level_1_pushdown") && !flag("level_1_enemy_damaged")) {
    level.player.vo_handler dialogue::say(vo_array[current_vo]);
    current_vo++;

    if(current_vo == vo_array.size) {
      current_vo = 0;
    }

    wait var_141b6c08b35b073e;
  }
}

function function_5d82bcb5f8d5670e(var_141b6c08b35b073e) {
  flag_wait("flag_lookedat_level_1_pushdown");
  wait var_141b6c08b35b073e;
  vo_array = ["dx_sp_jvip_desc_koa1_takeemout", "dx_sp_jvip_desc_koa1_engagethoseguards21"];
  current_vo = 0;

  while(!flag("level_1_enemy_damaged")) {
    level.player.vo_handler dialogue::say(vo_array[current_vo]);
    current_vo++;

    if(current_vo == vo_array.size) {
      current_vo = 0;
    }

    wait var_141b6c08b35b073e;
  }
}

function function_71feed6a190eb298() {
  level.player endon("lookedat_level_2_cells");
  wait 14;

  if(!utility::flag("flag_lookedat_level_2_cells")) {
    level.player.vo_handler thread dialogue::say("dx_sp_jvip_desc_koa1_alpha21checkthecellb");
    display_hint("focus_hint", undefined, 0, level.player, "lookedat_level_2_cells");
  }
}

function function_52ee5314b79fa2d5() {
  vo_guard = undefined;

  foreach(guy in level.var_3c122fc368a167a1) {
    vo_guard = guy;
  }

  while(!utility::flag("flag_level_2_player_actually_spotted")) {
    if(!utility::flag("flag_level_2_player_actually_spotted") && !utility::is_dead_or_dying(vo_guard)) {
      vo_guard say("dx_sp_jvip_desc_vipg_heywhatisthat");
      wait 3;
    }

    if(!utility::flag("flag_level_2_player_actually_spotted") && !utility::is_dead_or_dying(vo_guard)) {
      vo_guard say("dx_sp_jvip_desc_grd2_youseesomething");
      wait 3;
    }

    if(!utility::flag("flag_level_2_player_actually_spotted") && !utility::is_dead_or_dying(vo_guard)) {
      vo_guard say("dx_sp_jvip_desc_vipg_issomeonethere");
      wait 3;
    }

    waitframe();
  }

  wait 1;
  played_line = 0;

  foreach(guy in level.var_17b5b44b7bf1f73b) {
    if(!played_line && !utility::is_dead_or_dying(guy)) {
      guy thread say("dx_sp_jvip_cbv3_grd2_whothefuckisthat");
      played_line = 1;
    }
  }
}

function function_d769fba71399aa80(var_db3cd80db6ec9d9b) {
  level endon("flag_end_descend");
  flag_wait(var_db3cd80db6ec9d9b);
  level.player.vo_handler thread dialogue::say(level.var_47271776e1556e2d[level.var_2b642a36b737e94c]);
  level.var_2b642a36b737e94c++;

  if(level.var_2b642a36b737e94c == level.var_47271776e1556e2d.size) {
    level.var_2b642a36b737e94c = 0;
  }
}

function function_9c9652a117afcbb2() {
  wait 4;

  if(!is_dead_or_dying(level.level_1_vignette_guard_03) && !flag("level_1_enemy_damaged")) {
    level.level_1_vignette_guard_03 thread say("dx_sp_jvip_cbv4_grd2_releasehimandstepawa");
  }

  utility::flag_wait("level_1_enemy_damaged");
  wait 3;
  played_line = 0;

  foreach(guy in level.var_fbc4741479364a60) {
    if(!played_line && !utility::is_dead_or_dying(guy)) {
      guy thread say("dx_sp_jvip_cbv3_vipg_shotsfired");
      played_line = 1;
    }
  }
}

function function_80c859bbfd2cb690(var_141b6c08b35b073e) {
  level.player endon("back_pressed_with_min_time");
  level.player endon("back_pressed");
  wait 5.5;
  vo_array = ["dx_sp_jvip_desc_koa1_pushdown", "dx_sp_jvip_desc_koa1_move", "dx_sp_jvip_desc_koa1_ropesoutletsmove", "dx_sp_jvip_desc_koa1_ropesoutletsgetdownt"];
  current_vo = 0;

  while(!flag("flag_stop_1") && !flag("level_1_enemy_damaged")) {
    level.player.vo_handler dialogue::say(vo_array[current_vo]);
    current_vo++;

    if(current_vo == vo_array.size) {
      current_vo = 0;
    }

    wait var_141b6c08b35b073e;
  }
}

function function_c60799f986b4ac2e(time_to_wait) {
  wait time_to_wait;
  var_f23743d01d0d8f2 = level.player getclientomnvar("ui_show_objectives");

  if(var_f23743d01d0d8f2) {
    level.player setclientomnvar("ui_show_objectives", 0);
  }
}

function function_dd12262399b7c1e1(wait_delay) {
  wait wait_delay;

  if(!flag("flag_control_checkers_dead")) {
    level.player.vo_handler thread say("dx_sp_jvip_cblo_koa3_rogerguardsonly");
  }
}

function function_b87f2501edf1f4ac() {
  flag_wait("flag_finished_smoke_em_vo");

  if(!flag("level_1_enemy_damaged")) {
    level.player.vo_handler thread say("dx_sp_jvip_desc_koa1_holdstayhighkillthos", 1);
  }
}

function function_977bc5c7594695cf() {
  function_64f815da552ce8c6();
  utility::flag_wait("flag_descend_start_anim");
  wait 3.3;
  level dialogue::say("dx_sp_jvip_cbar_koa2_allteamsletsrollthun");
  level dialogue::say("dx_sp_jvip_cbar_koa2_bravopulltheplug");
  wait 1.5;
  level.player.vo_handler dialogue::say("dx_sp_jvip_cblo_kob1_rogblackoutin3");
  wait 0.5;
  level.player.vo_handler thread dialogue::say("dx_sp_jvip_cblo_kob1_2");
  wait 1;
  level.player.vo_handler thread dialogue::say("dx_sp_jvip_cblo_kob1_1");
  wait 0.9;
  level.player.vo_handler thread dialogue::say("dx_sp_jvip_cblo_kob1_execute");
  utility::flag_wait("flag_control_room_clear");
  thread descend_music();
  level.player.vo_handler dialogue::say("dx_sp_jvip_cblo_kob1_allteamsbravosgotthe");
  level.player.vo_handler say("dx_sp_jvip_cblo_koa1_copytargettheguardso");
  thread function_dd12262399b7c1e1(1);
  utility::flag_wait("flag_control_room_clear");
  level.player utility::ent_flag_wait("descend_ally_idle_start");
  utility::flag_set("flag_start_descend");
  utility::flag_set("flag_lights_out_complete");
  utility::flag_set("flag_obj_reach_descend_complete");
  utility::flag_wait("flag_descend_allies_initialized");
  utility::flag_wait("flag_control_checkers_dead");
  thread function_80c859bbfd2cb690(6);
  wait 0.5;
  level.player.vo_handler thread say("dx_sp_jvip_desc_koa1_clearmoreinthecellbl", undefined, undefined, undefined, 0.5);
  thread flag_set_delayed("flag_finished_smoke_em_vo", 4);
  var_f23743d01d0d8f2 = level.player getclientomnvar("ui_show_objectives");

  if(!var_f23743d01d0d8f2) {
    level.player setclientomnvar("ui_show_objectives", 1);
    thread function_c60799f986b4ac2e(10);
  }

  level.var_2b642a36b737e94c = 0;
  level.var_47271776e1556e2d = ["dx_sp_jvip_cbgw_kob1_guardsaboveyoualpha", "dx_sp_jvip_cbgw_kob1_guardsonthestairs", "dx_sp_jvip_cbgw_kob1_watchthestairs", "dx_sp_jvip_cbgw_kob1_guardsmovingtothewal", "dx_sp_jvip_cbgw_kob1_alphacheckthewalkway"];
  thread function_d769fba71399aa80("flag_level_1_enemies_on_walkways");
  utility::flag_wait_either("flag_stop_1", "level_1_enemy_damaged");
  thread function_35137d45a80929af(6);
  thread function_5d82bcb5f8d5670e(8);
  thread function_b87f2501edf1f4ac();
  thread function_9c9652a117afcbb2();
  var_f23743d01d0d8f2 = level.player getclientomnvar("ui_show_objectives");

  if(var_f23743d01d0d8f2) {
    level.player setclientomnvar("ui_show_objectives", 0);
  }

  utility::flag_wait("level_1_enemy_damaged");
  waitframe();
  var_b24e9cd6426318fb = 0;

  foreach(guy in level.var_fbc4741479364a60) {
    if(!utility::is_dead_or_dying(guy) && var_b24e9cd6426318fb == 0) {
      guy thread say("dx_sp_jvip_desc_vipg_thereshootthem", undefined, undefined, undefined, 1);
      var_b24e9cd6426318fb = 1;
    }
  }

  level.player say("dx_sp_jvip_desc_koa2_bravokickofftheriot", 1);
  level.player.vo_handler thread say("dx_sp_jvip_desc_kob1_rogeropeningblockson_01", undefined, undefined, undefined, 0.5);
  utility::flag_wait("flag_killed_all_level_1_enemies");
  level.player.vo_handler say("dx_sp_jvip_desc_koa1_clearcheckthenextcel", undefined, undefined, undefined, 0.5);
  thread function_71feed6a190eb298();
}

function function_977bc6c759469802() {
  thread function_d769fba71399aa80("flag_level_2_enemies_on_walkways");
  utility::flag_wait_either("flag_stop_3", "level_2_enemy_damaged");

  if(!flag("level_2_enemy_damaged")) {
    level.player.vo_handler thread say("dx_sp_jvip_desc_koa1_staysharpguardsknoww");
  }

  thread function_52ee5314b79fa2d5();
  utility::flag_wait("flag_level_2_player_spotted_vo");
  var_b24e9cd6426318fb = 0;

  foreach(guy in level.var_17b5b44b7bf1f73b) {
    if(!utility::is_dead_or_dying(guy) && var_b24e9cd6426318fb == 0) {
      guy thread say("dx_sp_jvip_desc_vipg_intruderseliminateth", undefined, undefined, undefined, 1);
      var_b24e9cd6426318fb = 1;
    }
  }

  waitframe();
  level.player.vo_handler say("dx_sp_jvip_desc_koa1_bravoopencellblockso", 1);
  level.player.vo_handler thread say("dx_sp_jvip_desc_kob1_copyopening", undefined, undefined, undefined, 0.5);
  utility::flag_set("flag_open_level_2_doors");
  utility::flag_wait("flag_killed_level_2_enemies");
  level.player thread say("dx_sp_jvip_desc_koa2_droppedemletsgo");
}

function function_63f5fc6443fa22d4() {
  wait 2;

  if(isDefined(level.var_8bfebd2a4bb5c29c) && level.var_8bfebd2a4bb5c29c.size > 0) {
    played_line = 0;

    foreach(guy in level.var_8bfebd2a4bb5c29c) {
      if(!played_line && !utility::is_dead_or_dying(guy)) {
        guy thread say("dx_sp_jvip_cbv4_grd3_weneedbackupsendunit");
        played_line = 1;
      }
    }
  }

  wait 3;

  if(isDefined(level.var_8bfebd2a4bb5c29c) && level.var_8bfebd2a4bb5c29c.size > 0) {
    played_line = 0;

    foreach(guy in level.var_8bfebd2a4bb5c29c) {
      if(!played_line && !utility::is_dead_or_dying(guy)) {
        guy thread say("dx_sp_jvip_cbv2_vipg_whatthehellisgoingon");
        played_line = 1;
      }
    }
  }
}

function function_977bc7c759469a35() {
  thread function_d769fba71399aa80("flag_level_3_enemies_on_walkways");
  utility::flag_wait("flag_force_flashlight_ambush");
  level.player.vo_handler thread say("dx_sp_jvip_desc_koa1_contact");
  thread function_63f5fc6443fa22d4();
  utility::flag_wait("flag_killed_level_3_enemies");
  level.player.vo_handler thread say("dx_sp_jvip_desc_koa1_clear");
}

function function_b52b3186b12df630() {
  flag_wait_all("flag_killed_all_level_1_enemies", "flag_killed_level_2_enemies", "flag_killed_level_3_enemies");
  wait 1;
  utility::flag_set("flag_speed_increase");
  thread function_7ee9fbf06d14c301();
  level.player.vo_handler thread say("dx_sp_jvip_desc_koa2_blockisclearheadingd");
  var_141b6c08b35b073e = 7;
  wait var_141b6c08b35b073e;
  thread function_15785923e0edaa5a(var_141b6c08b35b073e);
}

function function_7ee9fbf06d14c301() {
  wait 3;
  stopmusicstate("mx_vip_descend");
}

function function_d04a63a863545370() {
  level.var_8fa50d2578d5a956 = 0;
  level.var_5eb8b4e1940196c5 = 0;

  while(!flag("flag_end_descend")) {
    [var_bd837da502678594] = level.player getnormalizedmovement(0.2, 0.2);

    if(var_bd837da502678594 < 0) {
      level.var_8fa50d2578d5a956 = 1;
      level.var_5eb8b4e1940196c5 = 0;
    } else {
      level.var_8fa50d2578d5a956 = 0;
      level.var_5eb8b4e1940196c5++;
    }

    waitframe();
  }
}

function function_15785923e0edaa5a(var_141b6c08b35b073e) {
  vo_array = ["dx_sp_jvip_cbdn_koa1_descend21", "dx_sp_jvip_cbdn_koa1_down21", "dx_sp_jvip_cbdn_koa1_alphasonthegroundwai", "dx_sp_jvip_cbdn_koa1_regroupatthebottom21", "dx_sp_jvip_cbdn_koa1_movedown21clocksrunn"];
  current_vo = 0;
  thread function_d04a63a863545370();
  var_14bc6037730e34e8 = 24;

  while(!flag("flag_end_descend")) {
    if(level.var_8fa50d2578d5a956 == 0 && level.var_5eb8b4e1940196c5 >= var_14bc6037730e34e8) {
      level.player.vo_handler dialogue::say(vo_array[current_vo]);
      current_vo++;

      if(current_vo == vo_array.size) {
        current_vo = 0;
      }

      wait var_141b6c08b35b073e;
      continue;
    }

    if(level.var_8fa50d2578d5a956 == 0 && level.var_5eb8b4e1940196c5 < var_14bc6037730e34e8) {
      waitframe();
      continue;
    }

    waitframe();
  }
}

function function_fe3e08bf9670b880() {
  wait 0.6;
  setmusicstate("mx_vip_panopticon");
}

function descend_music() {
  setmusicstate("mx_vip_descend");
}

function function_75554023708b4127() {
  level.player endon("death");
  utility::flag_wait("flag_descend_lights_on");
  thread utility::set_nvg_vision("nvg_base_color_overexposed");
  utility::flag_wait("flag_release_prisoners");
  thread utility::set_nvg_vision("nvg_base_color_vip_descend");
}

function function_d98706eac0b726a9() {
  level.player waittill("descend_ally_idle_start");
  function_64f815da552ce8c6();

  for(count_down = int(65); count_down > 0 && !utility::flag("flag_leaving_level_4"); count_down--) {
    wait 1;
  }

  utility::flag_wait("flag_lights_on_trigger");
  wait 1;
  utility::flag_set("flag_descend_lights_on");
  level.ally1.laserenabled = 0;
  level.ally1.var_ac586f2e112c08cf = 1;
  level.ally1 laserforceoff();
  level.ally2.laserenabled = 0;
  level.ally2.var_ac586f2e112c08cf = 1;
  level.ally2 laserforceoff();
  waitframe();
  level.ally1 shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  level.ally2 shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  function_24ea96fe4af4dec9();
  sp_jup_vip_lighting::function_1c490662fd0cada2();
  sp_jup_vip_lighting::function_1c490562fd0cab6f();
  sp_jup_vip_lighting::function_1c490462fd0ca93c();
  sp_jup_vip_lighting::function_1c490362fd0ca709();
}

function function_6f8aa8528ab2fb84() {
  self endon("death");
  self.ignoreall = 1;
  utility::clear_demeanor_override();
  waitframe();
  utility::demeanor_override("combat");
  function_672fd16c1e8480a4();
  self aisetdesiredspeed(140);
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  self.pushable = 0;
  thread function_f1ea343210c7275c();
}

function function_33be106241312c26() {
  self endon("death");
  level.var_8bfebd2a4bb5c29c[level.var_8bfebd2a4bb5c29c.size] = self;
  arrayindex = randomintrange(6, 7);
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(arrayindex);
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self.fixednode = 1;
  self.grenadeammo = 0;
  self.var_98add129a7ecb962 = 0;
  function_672fd16c1e8480a4();
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self aisetdesiredspeed(200);
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  utility::set_ignoreall(1);
  namespace_9c93a5b828db4a4b::function_c8431cc67f0b0824("lookat_level_3_runners", "flag_flashlight_searcher_killed", 30);
  utility::set_ignoreall(0);
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
  wait 1;
  thread function_f1ea343210c7275c();
}

function function_994da04e9b16d72b() {
  self endon("death");
  level.var_8bfebd2a4bb5c29c[level.var_8bfebd2a4bb5c29c.size] = self;
  arrayindex = randomintrange(0, 1);
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(arrayindex);
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self getenemyinfo(level.player);
  self.grenadeammo = 0;
  function_672fd16c1e8480a4();
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.var_98add129a7ecb962 = 0;
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  utility::demeanor_override("cqb");
  self aisetdesiredspeed(100);
  thread function_c6f104de128fe4dd("flag_force_flashlight_ambush");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  self.ignoreall = 1;
  flag_wait("flag_force_flashlight_ambush");
  self.ignoreall = 0;
  utility::flag_wait("flag_leaving_level_3");

  if(!utility::is_dead_or_dying(self)) {
    if(utility::is_equal(self.animname, "guard5")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_01", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard6")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_02", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    }

    utility::set_baseaccuracy(1);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
  }
}

function function_437916a5563209bd() {
  self endon("death");
  level.var_8bfebd2a4bb5c29c[level.var_8bfebd2a4bb5c29c.size] = self;
  arrayindex = randomintrange(4, 5);
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(arrayindex);
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self.fixednode = 1;
  self getenemyinfo(level.player);
  self.grenadeammo = 0;
  function_672fd16c1e8480a4();
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.var_98add129a7ecb962 = 0;

  if(utility::is_equal(self.script_parameters, "flashlight")) {
    thread function_f1ea343210c7275c();
  }

  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
}

function function_df80ba83de168f97() {
  level.var_8bfebd2a4bb5c29c[level.var_8bfebd2a4bb5c29c.size] = self;
  self.grenadeammo = 0;
  utility::set_baseaccuracy(0.01);
  self.ignoresuppression = 1;
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
  thread function_f1ea343210c7275c("tag_accessory_left");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  self endon("death");

  while(!utility::flag("flag_leaving_level_3") && !utility::flag("flag_l3_ambushers_stop_megafire")) {
    rand_wait = randomfloatrange(0.8, 2.5);
    rand_shots = randomintrange(4, 7);
    wait rand_wait;

    for(i = 0; i < rand_shots; i++) {
      if(!utility::flag("flag_end_descend")) {
        self shoot(0.5, level.player);
      }

      wait 0.08;
    }

    if(!utility::flag("flag_l3_ambushers_in_position")) {
      utility::flag_wait("flag_l3_ambushers_in_position");
      self.goalradius = 1000;
    }

    utility::flag_set_delayed("flag_l3_ambushers_stop_megafire", 2);
  }

  utility::set_baseaccuracy(0.25);
  self.ignoresuppression = 0;

  if(flag("flag_l3_ambushers_stop_megafire")) {}

  utility::flag_wait("flag_leaving_level_3");

  if(!utility::is_dead_or_dying(self)) {
    if(utility::is_equal(self.animname, "guard1")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_05", "targetname");
      thread scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard3")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_04", "targetname");
      thread scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard2")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_03", "targetname");
      thread scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard4")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_3_balcony_cover_07", "targetname");
      thread scripts\sp\spawner::go_to_node(newgoal);
    }

    thread function_99b65153519612e9(0, 1, 7);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
    wait 2;

    while(!utility::flag("flag_descend_level_3_allies_disengage") && !utility::flag("flag_l3_ambushers_stop_megafire_ii")) {
      rand_wait = randomfloatrange(0.8, 1.5);
      rand_shots = randomintrange(4, 7);
      wait rand_wait;

      for(i = 0; i < rand_shots; i++) {
        if(!utility::flag("flag_end_descend")) {
          self shoot(0.5, level.player);
        }

        wait 0.08;
      }

      utility::flag_set_delayed("flag_l3_ambushers_stop_megafire_ii", 5);
    }
  }
}

function function_12c78bb12cfa25() {
  self endon("death");
  level.var_8bfebd2a4bb5c29c[level.var_8bfebd2a4bb5c29c.size] = self;
  arrayindex = randomintrange(0, 1);
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(arrayindex);
  utility::set_baseaccuracy(0.25);
  self.goalradius = 8;
  self.fixednode = 1;
  self getenemyinfo(level.player);
  self.grenadeammo = 0;
  function_672fd16c1e8480a4();
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.var_98add129a7ecb962 = 0;

  if(utility::is_equal(self.script_parameters, "flashlight")) {
    thread function_c6f104de128fe4dd("flag_force_flashlight_ambush");
  }

  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  waitframe();
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
  utility::flag_wait("flag_leaving_level_3");

  if(!utility::is_dead_or_dying(self)) {
    self cleargoalentity();
    waitframe();
    newgoal = getnode("level_3_balcony_cover_06", "targetname");
    scripts\sp\spawner::go_to_node(newgoal);
    thread function_99b65153519612e9(0, 1, 7);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
  }
}

function function_c6f104de128fe4dd(wait_flag) {
  self endon("death");
  utility::set_ignoreall(1);
  utility::flag_wait(wait_flag);
  utility::set_ignoreall(0);
  wait randomfloatrange(0.5, 0.9);
  thread function_f1ea343210c7275c();
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
}

function function_f6095cf01e23cf54() {
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self.fixednode = 1;
  self.grenadeammo = 0;
  self.var_98add129a7ecb962 = 0;
  function_672fd16c1e8480a4(1);
  self.pushable = 0;
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_entering_level_3", level.ally1);
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
}

function function_8ed01f09666d3f8b() {
  arrayindex = randomintrange(0, 1);
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e(arrayindex);
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self.fixednode = 1;
  self.grenadeammo = 0;
  self.var_98add129a7ecb962 = 0;
  function_672fd16c1e8480a4();
  self.pushable = 0;
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  thread function_f1ea343210c7275c("tag_accessory_left");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  utility::set_ignoreall(1);
  utility::flag_wait_either("flag_level_2_player_in_flashlight", "level_2_enemy_damaged");
  self setgoalpos(self.origin);
  utility::set_ignoreall(0);
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
  utility::flag_wait("flag_leaving_level_2");

  if(!utility::is_dead_or_dying(self)) {
    if(utility::is_equal(self.animname, "guard2")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_2_balcony_cover_01", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard3")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_2_balcony_cover_02", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.animname, "guard1")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_2_balcony_cover_03", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    }

    thread function_99b65153519612e9(0, 1, 7);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
  }
}

function function_12251ccb5c04b482(very_low) {
  self endon("death");
  function_672fd16c1e8480a4(very_low);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend");
  utility::flag_wait("level_1_enemy_damaged");
  waitframe();
  self function_b661b022700ba72f("script", 1);
  waitframe();
  self function_d5cda8a759cc36bc("flee");
  waitframe();
  self function_d5cda8a759cc36bc("cower");
  wait 0.5;
  thread function_4f46323e9dc18ea3();

  if(isDefined(self) && !is_dead_or_dying(self)) {
    self function_d5cda8a759cc36bc("cower");
  }

  wait 1;

  if(isDefined(self) && !is_dead_or_dying(self)) {
    self function_d5cda8a759cc36bc("cower");
  }
}

function function_5830c787f8dc3dc(var_5c256070f853384a) {
  self endon("death");
  function_672fd16c1e8480a4();
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_obj_reach_makarov_complete");
  utility::flag_wait(var_5c256070f853384a);
  self.deathfunction = &function_ce450b9957138bd5;
  waitframe();
  self function_b661b022700ba72f("script", 1);
  waitframe();
  self function_d5cda8a759cc36bc("flee");
  var_41a2028178207804 = self.script_noteworthy;
  newgoal = getStruct(var_41a2028178207804, "targetname");
  scripts\sp\spawner::go_to_node(newgoal);
  self waittill("goal");
  waitframe();
  self function_d5cda8a759cc36bc("cower");
  wait 0.5;
  thread function_4f46323e9dc18ea3();
}

function function_4f46323e9dc18ea3() {
  self endon("death");

  while(true) {
    if(level.player scripts\sp\friendlyfire::enemy_is_visible()) {
      if(isDefined(self) && !is_dead_or_dying(self)) {
        self.friend_kill_points = undefined;
      } else {
        return;
      }
    } else if(isDefined(self) && !is_dead_or_dying(self)) {
      self.friend_kill_points = -1200;
    } else {
      return;
    }

    waitframe();
  }
}

function function_529fb6c65ef6bad3(var_5c256070f853384a) {
  self endon("death");
  utility::set_baseaccuracy(0.2);
  self.goalradius = 16;
  self.fixednode = 1;
  self.grenadeammo = 0;
  self.var_98add129a7ecb962 = 0;
  function_672fd16c1e8480a4(1);
  self.pushable = 0;
  self.var_d28e54645050df58 = 0;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 1;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_obj_reach_makarov_complete");
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  utility::flag_wait(var_5c256070f853384a);
  self notify("aud_riot_guy_interuppted");
  self setgoalpos(self.origin);
  utility::set_ignoreall(0);
  utility::set_ignoreme(0);
  self getenemyinfo(level.player);
  wait 4;

  if(!is_dead_or_dying(self)) {
    utility::set_baseaccuracy(0.4);
  }

  wait 3;

  if(!is_dead_or_dying(self)) {
    utility::set_baseaccuracy(0.6);
  }

  wait 2;

  if(!is_dead_or_dying(self)) {
    utility::set_baseaccuracy(0.8);
  }

  wait 1;

  if(!is_dead_or_dying(self)) {
    utility::set_baseaccuracy(1);
  }
}

function function_f1ea343210c7275c(var_e47f8a7629b4cd8, flashlight_fx) {
  if(!isDefined(var_e47f8a7629b4cd8)) {
    var_e47f8a7629b4cd8 = "tag_flash";
  }

  if(!isDefined(flashlight_fx)) {
    flashlight_fx = "vfx_flashlight_npc_perf";
  }

  assertex(self tagexists(var_e47f8a7629b4cd8), "Entity doesn't have specified tag to attach the flashlight to: " + var_e47f8a7629b4cd8);

  if(!isalive(self)) {
    return;
  }

  fx = utility::getfx(flashlight_fx);
  playFXOnTag(fx, self, var_e47f8a7629b4cd8);
  utility::waittill_any_3("death", "long_death", "cleanup_flashlight");
  killfxontag(fx, self, var_e47f8a7629b4cd8);
  waitframe();

  if(isDefined(self) && self tagexists(var_e47f8a7629b4cd8)) {
    killfxontag(fx, self, var_e47f8a7629b4cd8);
  }
}

function function_650b5a3a8851c709(very_low) {
  self endon("death");
  utility::set_baseaccuracy(0.25);
  self.goalradius = 16;
  self.fixednode = 1;
  self.grenadeammo = 0;
  self.var_98add129a7ecb962 = 0;
  function_672fd16c1e8480a4(very_low);
  self.pushable = 0;
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self enableavoidance(0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(24);
  self setavoidancereciprocity(0.5);
  thread function_f1ea343210c7275c("tag_accessory_left");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  utility::set_ignoreall(1);
  utility::flag_wait("level_1_enemy_damaged");
  utility::set_ignoreall(0);
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
  utility::flag_wait("flag_leaving_level_1");

  if(!utility::is_dead_or_dying(self)) {
    if(utility::is_equal(self.targetname, "spawner_scenario_2_guard")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_1_balcony_cover_01", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.targetname, "spawner_level_1_vignette_guard_03")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_1_balcony_cover_03", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    } else if(utility::is_equal(self.targetname, "spawner_level_1_vignette_guard_01")) {
      self cleargoalentity();
      waitframe();
      newgoal = getnode("level_1_balcony_cover_04", "targetname");
      scripts\sp\spawner::go_to_node(newgoal);
    }

    thread function_99b65153519612e9(0, 1, 7);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
  }
}

function function_99b65153519612e9(start_accuracy, end_accuracy, time) {
  self endon("death");
  time_tick = time / 10;
  accuracy = start_accuracy;

  if(isDefined(self) && !is_dead_or_dying(self)) {
    utility::set_baseaccuracy(accuracy);
  }

  wait 3;

  if(start_accuracy < end_accuracy) {
    accuracy_tick = (end_accuracy - start_accuracy) / 10;

    while(accuracy < end_accuracy) {
      if(isDefined(self) && !is_dead_or_dying(self)) {
        utility::set_baseaccuracy(accuracy);
      }

      accuracy += accuracy_tick;
      wait time_tick;
    }

    if(isDefined(self) && !is_dead_or_dying(self)) {
      utility::set_baseaccuracy(end_accuracy);
    }

    return;
  }

  if(start_accuracy > end_accuracy) {
    accuracy_tick = (start_accuracy - end_accuracy) / 10;

    while(accuracy > end_accuracy) {
      if(isDefined(self) && !is_dead_or_dying(self)) {
        utility::set_baseaccuracy(accuracy);
      }

      accuracy -= accuracy_tick;
      wait time_tick;
    }

    if(isDefined(self) && !is_dead_or_dying(self)) {
      utility::set_baseaccuracy(end_accuracy);
    }
  }
}

function function_813c035677d376f4() {
  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("flee");
  self.disablearrivals = 1;
  self aisetdesiredspeed(randomfloatrange(150, 200));
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 16;
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend");
  function_672fd16c1e8480a4(1);
  flag_wait("level_2_enemy_damaged");

  if(isDefined(self) && !is_dead_or_dying(self) && isDefined(self.animname) && self.animname == "prisoner2") {
    self function_d5cda8a759cc36bc("cower");
    wait 6;
  }

  if(isDefined(self) && !is_dead_or_dying(self)) {
    self.deathfunction = &function_ce450b9957138bd5;
    thread function_4f46323e9dc18ea3();
  }
}

function function_411f790ee645206a() {
  namespace_9c93a5b828db4a4b::function_9dbe83b3e459b76e();
  self.grenadeammo = 0;
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 16;
  self.pushable = 0;
  self.fixednode = 1;
  self.var_98add129a7ecb962 = 0;
  self aisetdesiredspeed(randomintrange(100, 120));
  self actoraimassistoff();
  utility::set_baseaccuracy(0.25);
  function_672fd16c1e8480a4();
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);

  if(utility::is_equal(self.script_parameters, "flashlight")) {
    thread function_f1ea343210c7275c();
  }

  thread utility::flag_on_death("flag_descend_flashlight_straggler_killed");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  self endon("death");
  utility::flag_wait_either("flag_descend_flashlight_stragglers_see_player", "flag_descend_flashlight_straggler_killed");

  if(utility::flag("flag_descend_flashlight_stragglers_see_player")) {
    wait randomfloatrange(1.5, 1.8);
  }

  utility::set_ignoreall(0);
  event = spawnStruct();
  event.typeorig = "combat";
  event.type = "combat";
  event.origin = level.player.origin;
  event.investigate_pos = level.player.origin;
  self[[self.fnsetstealthstate]]("combat", event);
  self getenemyinfo(level.player);
}

function function_b93669cc671face6() {
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 80;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self aisetdesiredspeed(randomintrange(150, 160));
  self actoraimassistoff();
  utility::set_cautious_navigation(1);
  self.pushable = 0;
  function_672fd16c1e8480a4();
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
  self visiblenotsolid();
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
}

function function_13179d13b55464e4() {
  namespace_9c93a5b828db4a4b::function_84972f5da4b3994b();
  self.disablearrivals = 1;
  self aisetdesiredspeed(200);
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 64;
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
}

function function_645b5a7cb58249b2() {
  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("flee");
  self.disablearrivals = 1;
  self aisetdesiredspeed(randomfloatrange(150, 200));
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 80;
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_leaving_level_2");
  self.deathfunction = &function_ce450b9957138bd5;
}

function function_137440284cccabe9() {
  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("flee");
  self.disablearrivals = 1;
  self aisetdesiredspeed(randomfloatrange(150, 200));
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 80;
  self enableavoidance(0, 0);
  self.var_3119604b74dfdbbd = 0;
  self setavoidanceradius(2);
  self setavoidancereciprocity(0.1);
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_leaving_level_3");
  self.deathfunction = &function_ce450b9957138bd5;
}

function function_4f4c1c19f2710e37() {
  if(!isDefined(level.control_checkers)) {
    level.control_checkers = [];
  }

  level.control_checkers[level.control_checkers.size] = self;
  self.laserenabled = 0;
  self.var_ac586f2e112c08cf = 1;
  self laserforceoff();
  function_672fd16c1e8480a4();
  self.grenadeammo = 0;
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 32;
  self.disablearrivals = 1;
  self aisetdesiredspeed(20);
  self.gunposeoverride = "ads";
  utility::set_cautious_navigation(1);
  thread utility::flag_on_death("flag_one_control_checker_died");
  thread namespace_9c93a5b828db4a4b::function_5353f2029567d563();
  utility::flag_wait("flag_control_checkers_stairway_start_walk");
  wait 1;
  wait randomfloat(1);
  thread function_f1ea343210c7275c("tag_accessory_left");
}

function function_441bc0dbe9b09396() {
  self endon("death");
  self.grenadeammo = 0;
  utility::set_ignoreall(1);
  utility::set_ignoreme(1);
  self.goalradius = 32;
  self.disablearrivals = 1;
  self aisetdesiredspeed(randomintrange(50, 70));
  self actoraimassistoff();
  function_672fd16c1e8480a4();
  self.gunposeoverride = "ads";
  utility::set_cautious_navigation(1);
  thread function_f1ea343210c7275c("tag_accessory_left");
  thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_end_descend", level.ally1);
  utility::flag_wait("level_1_enemy_damaged");
  react_offset = randomfloatrange(0.5, 1.5);
  wait react_offset;
  utility::set_cautious_navigation(0);
  self aisetdesiredspeed(100);
  self actoraimassiston();
  self.gunposeoverride = "disable";
  utility::set_ignoreall(0);
  newgoal = getStruct("level_1_bg_enemies_goto", "targetname");
  scripts\sp\spawner::go_to_node(newgoal);
  utility::flag_wait("flag_leaving_level_1");

  if(!utility::is_dead_or_dying(self)) {
    self cleargoalentity();
    waitframe();
    newgoal = getnode("level_1_balcony_cover_02", "targetname");
    scripts\sp\spawner::go_to_node(newgoal);
    thread function_99b65153519612e9(0, 1, 7);
    thread function_fe6f08c2290a88c7(100);
    self aisetdesiredspeed(100);
    self.goalradius = 100;
    self.disablearrivals = 1;
    self.aggressivemode = 1;
    self.disablereload = 1;
    self.ignoresuppression = 1;
  }
}

function function_fe6f08c2290a88c7(var_6cca86b6634aa67e, slowdown_time) {
  if(!isDefined(slowdown_time)) {
    slowdown_time = 0.5;
  }

  while(true) {
    level.player waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
    level.player dodamage(var_6cca86b6634aa67e, level.player.origin, attacker);
    flag_set("flag_player_slowed");
    flag_clear_delayed_endonset("flag_player_slowed", slowdown_time);
    waitframe();
  }
}

function function_4add6fc11546b7a4(var_acba072b7e847a86, var_d6ea42a51dc9a868) {
  self endon("death");

  while(!flag("flag_end_descend")) {
    level.player waittill("grenade_fire", grenade, weapon);

    if(isDefined(grenade)) {
      thread function_ac64b90e4f5bcde8(grenade, var_acba072b7e847a86, var_d6ea42a51dc9a868);
    }

    waitframe();
  }
}

function function_ac64b90e4f5bcde8(grenade, var_acba072b7e847a86, var_d6ea42a51dc9a868) {
  self endon("death");
  ret = grenade waittill_any_timeout_no_endon_death(8, "death", "missile_stuck");

  if(ret == "missile_stuck" && isDefined(grenade)) {
    if(!is_dead_or_dying(self)) {
      var_c41213d3dde06933 = distance(grenade.origin, self.origin);

      if(var_c41213d3dde06933 < 70) {
        level.var_b03c39f14f72c725 = self;
        level.var_be7a6f4bb2b1394b = grenade;
        flag_set(var_acba072b7e847a86);

        if(isDefined(var_d6ea42a51dc9a868) && var_d6ea42a51dc9a868) {
          self notify("aud_riot_guy_interuppted");
        }
      }
    }

    return;
  }
}

function function_d076b508d9cc254f() {
  clip_level_1_stairs_blocker = getEnt("clip_level_1_stairs_blocker", "targetname");
  clip_level_1_stairs_blocker hide();
  clip_level_1_stairs_blocker connectpaths();
  thread function_7d6d3dffa1c41e90();
  utility::flag_wait("flag_descend_allies_initialized");
  var_64deafcbf8d940bd = getEnt("level_g_path_blocker_r", "targetname");
  var_64deafcbf8d940bd connectpaths();
  thread function_a023dd30506dd2ef();
  namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  thread function_52f0a868e9bc8767();
  namespace_9c93a5b828db4a4b::function_c8431cc67f0b0824("lookat_level_1_pushdown", "flag_leaving_level_1", 55);
  utility::flag_wait("flag_leaving_level_1");
  level.ally2.var_a523960b4b241765 = 100;
  thread function_fd64c8a49961c70();
  utility::flag_wait("flag_entering_level_2");
  thread function_37f37419b9b2355d();
  utility::flag_wait_either("flag_leaving_level_3", "flag_descend_level_3_allies_disengage");
  utility::flag_wait("flag_prevent_player_leaving");
  thread function_93042866211a9029();
  utility::flag_wait("flag_leaving_level_4");
  utility::flag_set("flag_descend_level_3_allies_disengage");
  utility::flag_wait("flag_end_descend");
  level.player resetspreadoverride();
}

function function_2d4a81f941f8eb6c() {
  self endon("ascender_detached");

  while(true) {
    currentweapon = level.player getcurrentweapon();

    if(!isnullweapon(currentweapon)) {
      currentammo = level.player getfractionmaxammo(currentweapon);

      if(currentammo < 0.2) {
        level.player givemaxammo(currentweapon);
      }
    }

    wait 0.5;
  }
}

function function_b41340a6c57b3d4a(var_5c6ec3e0f088f842, timer) {
  if(!isDefined(timer)) {
    timer = 1.5;
  }

  spawn_struct = utility::getStruct(var_5c6ec3e0f088f842, "targetname");
  goal_struct = utility::getStruct(spawn_struct.target, "targetname");
  org_vector = vectorNormalize(goal_struct.origin - spawn_struct.origin);
  scale = distance(goal_struct.origin, spawn_struct.origin);
  throw_vector = org_vector * scale;
  magicgrenademanual("smoke", spawn_struct.origin, throw_vector, timer);
}

function function_ca4612afbc7a3e44(victim, delay, forced_flag, shot_count) {
  victim endon("death");

  if(utility::is_dead_or_dying(victim)) {
    return;
  }

  if(!isDefined(forced_flag)) {
    forced_flag = "flag_never_ever";
  }

  result = utility::waittill_any_ents_or_timeout_return(delay, level.player, "weapon_fired", level, forced_flag);

  if(result == "weapon_fired") {
    wait 0.3;
  }

  if(!isDefined(shot_count)) {
    shot_count = randomintrange(1, 2);
  }

  self.var_a5b8326e0a4d80e = shot_count;
  self.var_b6198f8f921d0b28 = 1;
}

function function_cf17edb2ede66426(door_id, var_5dc35ee4f9fafafd) {
  door_model = getEnt("descend_level_1_door_" + door_id, "targetname");
  open_pos = utility::getStruct(door_model.target, "targetname");
  utility::flag_set("flag_cell_doors_level_1_open");

  if(isDefined(var_5dc35ee4f9fafafd) && var_5dc35ee4f9fafafd > 0.5) {
    door_model moveTo(open_pos.origin, var_5dc35ee4f9fafafd);
    wait_time = var_5dc35ee4f9fafafd - 0.2;
    wait wait_time;
  } else {
    door_model moveTo(open_pos.origin, 2.5);
    wait 2.3;
  }

  utility::flag_set("flag_descend_level_1_opened_cell_" + door_id);
}

function function_95c7afd18c8c12b3(door_id, var_5dc35ee4f9fafafd) {
  door_model = getEnt("descend_level_2_door_" + door_id, "targetname");
  open_pos = utility::getStruct(door_model.target, "targetname");
  utility::flag_set("flag_cell_doors_multiple_open");

  if(isDefined(var_5dc35ee4f9fafafd) && var_5dc35ee4f9fafafd > 0.5) {
    door_model moveTo(open_pos.origin, var_5dc35ee4f9fafafd);
    wait_time = var_5dc35ee4f9fafafd - 0.2;
    wait wait_time;
  } else {
    door_model moveTo(open_pos.origin, 2.5);
    wait 2.3;
  }

  utility::flag_set("flag_descend_level_2_opened_cell_" + door_id);
}

function function_a5d5a6be8fc6e254() {
  level.player endon("ascender_detached");
  level.player endon("death");

  while(true) {
    if(utility::flag("flag_player_stopped")) {
      setsaveddvar(@ "hash_82bf2761cf29c9bf", 14);
      wait 0.1;
      setsaveddvar(@ "hash_82bf2761cf29c9bf", 7);
      wait 0.1;
      setsaveddvar(@ "hash_82bf2761cf29c9bf", 3.5);
      wait 0.1;
      setsaveddvar(@ "hash_82bf2761cf29c9bf", 1);
      utility::flag_waitopen("flag_player_stopped");
    }

    waitframe();
  }
}

function function_994699d967e94f7e() {
  level.player endon("ascender_detached");
  level.player endon("death");
  max_speed = 32.5;
  min_speed = max_speed / 3;
  speed_increased = 0;
  var_ed62407e1efa045c = 0;
  var_715f852e6a4e649d = 30;
  var_71d1573aaee11ef = 0.33;

  while(true) {
    if(utility::flag("flag_player_stopped")) {
      min_speed = 1;
      var_715f852e6a4e649d = 10;
    } else {
      min_speed = 32.5 / 3;
      var_715f852e6a4e649d = 20;
    }

    if(utility::flag("flag_speed_increase")) {
      max_speed = 32.5 + 16.25;
    }

    current_movement = level.player getnormalizedmovement()[0];
    var_e38f272e577509ac = abs(current_movement);

    if(utility::flag("flag_player_stopped") && current_movement < 0) {
      var_e38f272e577509ac = 0;
    }

    additive_speed = (max_speed - min_speed) * var_e38f272e577509ac;
    final_speed = min_speed + additive_speed;

    if(current_movement <= 0 && (utility::flag("flag_player_slowed") || utility::flag("flag_player_stopped"))) {
      var_ed62407e1efa045c++;

      if(var_ed62407e1efa045c > var_715f852e6a4e649d) {
        var_ed62407e1efa045c = var_715f852e6a4e649d;
      }
    } else {
      var_ed62407e1efa045c--;
      var_ed62407e1efa045c--;

      if(var_ed62407e1efa045c < 0) {
        var_ed62407e1efa045c = 0;
      }
    }

    multiplier = (1 - var_71d1573aaee11ef) * var_ed62407e1efa045c / var_715f852e6a4e649d;
    reduced_speed = final_speed * multiplier;
    final_speed = clamp(final_speed - reduced_speed, 1, 65);
    setsaveddvar(@ "hash_82bf2761cf29c9bf", final_speed);
    waitframe();
  }
}

function function_8daa114e8845c8f0() {
  riot_shield_guys = utility::array_spawn_targetname("riot_shield_guys");

  foreach(guy in riot_shield_guys) {
    guy thread namespace_9c93a5b828db4a4b::function_672fd16c1e8480a4();
    guy thread function_f4b19c46a8dc30e8("level_g_left_riot_actor_damaged");
    guy thread function_529fb6c65ef6bad3("level_g_left_riot_actor_damaged");
  }

  halldoor_00 = getEnt("vip_reach_vip_halldoor_00", "targetname");
  var_c09cdd31d76aa066 = utility::getStruct("vip_reach_vip_halldoor_00_dest", "targetname");
  halldoor_00_dest = var_c09cdd31d76aa066.origin;
  utility::flag_wait("flag_close_halldoor_00");
  halldoor_00 moveTo(halldoor_00_dest, 2.5, 1, 1);
  wait 6;

  foreach(guy in riot_shield_guys) {
    guy.diequietly = 1;
    guy kill();
  }
}

function function_76b252dbe04bb96e() {
  level.player endon("death");
  nvg_on = 0;
  utility::flag_wait("flag_descend_player_nvg_on");

  if(!isDefined(level.infil_allies)) {
    level.infil_allies = [level.ally1, level.ally2];
  }

  while(!utility::flag("flag_end_descend")) {
    if(nvg_player::is_nvg_on() && !nvg_on) {
      foreach(guy in level.infil_allies) {
        if(isDefined(guy)) {
          guy.light_tag = utility::spawn_tag_origin(guy gettagorigin("j_helmet"), guy gettagangles("tag_eye"));
          guy.light_tag linkTo(guy, "j_helmet", (1.5, 3, 0), (0, 0, 0));
          playFXOnTag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
        }
      }

      nvg_on = 1;
    } else if(!nvg_player::is_nvg_on() && nvg_on) {
      foreach(guy in level.infil_allies) {
        if(isDefined(guy)) {
          killfxontag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
          guy.light_tag delete();
        }
      }

      nvg_on = 0;
    }

    wait 0.25;
  }

  if(nvg_on) {
    foreach(guy in level.infil_allies) {
      if(isDefined(guy)) {
        killfxontag(utility::getfx("vfx_vip_nightvision_beacon"), guy.light_tag, "tag_origin");
        guy.light_tag delete();
      }
    }
  }
}