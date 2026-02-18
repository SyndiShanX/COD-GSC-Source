/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_77d064824b2c820c.gsc
***********************************************/

#using script_155b17ff7c8b315c;
#using script_3dc93ca9902a9cda;
#using script_446752c03c555e16;
#using script_4489198b8bcf36e8;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_rus_amerika;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\smokegrenade;
#namespace namespace_4c1dd357;

function function_ad51fa26(str_objective) {
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_facades", 0, 0);
  level thread function_725c2118();
  level thread namespace_fc3e8cb::function_f87024e0("nd_vh_town_square_apc_facades_start");
  level flag::set("flg_observation_woods_end_stairs");
  namespace_b61bbd82::music("12.1_exit");
}

function function_bb5a40cc(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(var_50cc0d4f);

  level thread function_ad066a85();
  level thread function_7afbb8d0();
  level thread ai_t8_zm_twrs_tgr_stalk_turn_l_90();
  level thread function_20d4e36c();
  level thread function_2bd1a728();
  level flag::wait_till("flg_facades_end");
  skipto::function_4e3ab877(var_50cc0d4f);
}

function function_7c8934a0(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level flag::set("flg_facades_dropdown");
}

function function_ad066a85() {
  if(!isDefined(objectives::function_285e460("obj_observation_follow_woods", level.woods))) {
    objectives::follow("obj_observation_follow_woods", level.woods, #"hash_6783da2c53b544a4", 0);
  }

  level flag::wait_till("flg_facades_end");
  objectives::complete("obj_observation_follow_woods", level.woods);
}

function function_c691e305(var_630bb80a) {
  if(isDefined(objectives::function_285e460("obj_courtyard_main"))) {
    return;
  }

  objectives::scripted("obj_courtyard_main", undefined, #"hash_34b5d949ba5c2a1b", 0);
  level breadcrumb::function_61037c6c(var_630bb80a);
  level flag::wait_till("flg_storage_end");
  objectives::complete("obj_courtyard_main");
}

function ai_t8_zm_twrs_tgr_stalk_turn_l_90() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level thread namespace_4bd68414::function_ff520414();
  level flag::wait_till("flg_observation_woods_end_stairs");
  level.woods.grenadeammo = 0;
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreall", 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods battlechatter::function_2ab9360b(0);
  level.player util::blend_movespeedscale(0.9, 1);
  level.woods ai::set_behavior_attribute("sprint", 1);
  level.woods.forcesprint = 1;
  level.woods setdesiredspeed(265);
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_facades_woods_start", 1, 1);
  level namespace_fc3e8cb::function_92dea087("flg_facades_start", "flg_facades_dropdown");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_facades_woods_angle", 1, 1);
  level namespace_fc3e8cb::function_92dea087("flg_facades_angle", "flg_facades_turn_corner");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_facades_woods_destruction_2", 1, 1);
  level flag::wait_till("flg_facades_corridor_enter");
  vol_facades_woods_stumble = getent("vol_facades_woods_stumble", "targetname");
  var_54675276 = istouching(level.woods.origin, vol_facades_woods_stumble);

  if(var_54675276 == 1) {
    level.woods notify(#"amk_woods_new_goal");
    level.woods clearforcedgoal();
    level.woods val::set(#"ai_forcegoal", "ignoreall", 1);
    level.vh_town_square_apc util::delay(1, undefined, &hms_util::function_b5da96ca, level.woods getEye() + (0, 0, 32), undefined, 0);
    s_scene_facades_woods_stumble_a = struct::get("s_scene_facades_woods_stumble_a", "targetname");
    s_scene_facades_woods_stumble_a scene::play("scene_amk_6025_fds_stumble_woods_a");
    level.woods ai::set_behavior_attribute("sprint", 1);
    level.woods setdesiredspeed(265);
  } else {
    level namespace_fc3e8cb::function_92dea087("flg_facades_destruction_2_play", "flg_facades_corridor_enter");
  }

  level.woods notify(#"amk_woods_new_goal");
  level.woods clearforcedgoal();
  level.woods val::set(#"ai_forcegoal", "ignoreall", 1);
  level thread function_659aef1f();
  s_scene_facades_woods_parkour = struct::get("s_scene_facades_woods_parkour", "targetname");
  s_scene_facades_woods_parkour scene::play("scene_amk_6030_fds_parkour_woods");
  level.woods ai::set_behavior_attribute("sprint", 1);
  level.woods setdesiredspeed(265);
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_facades_near_end", 1, 1);
  level namespace_fc3e8cb::function_92dea087("flg_facades_near_end", "flg_facades_destruction_3_play");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_rooftops_woods_start", 1, 1);
  level flag::wait_till("flg_rooftops_start");
  level.woods.grenadeammo = 99;
  level.woods ai::set_behavior_attribute("vignette_mode", "off");
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreall", 0);
  level.woods ai::set_behavior_attribute("disablepeek", 0);
  level.woods ai::set_behavior_attribute("disablelean", 0);
  level.woods ai::set_behavior_attribute("sprint", 0);
  level.woods.forcesprint = 0;
  level.woods function_9ae1c50();
  level.woods battlechatter::function_2ab9360b(1);
}

function function_659aef1f() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  s_target = struct::get("s_facades_apc_woods_parkour_target", "targetname");
  wait 0.5;
  level.woods waittill(#"reach_done");
  wait 2.5;
  level.vh_town_square_apc thread hms_util::function_b5da96ca(level.woods getEye() + (0, 0, 32), undefined, 1, s_target.script_noteworthy);
}

function function_725c2118() {
  println("<dev string:x38>");
  var_b9f6cfe = spawner::simple_spawn("ai_enemy_facades", &function_22df39e0);
  level thread namespace_fc3e8cb::function_85939627(var_b9f6cfe, "flg_facades_enemies_most_dead", var_b9f6cfe.size - 2);
  level thread namespace_fc3e8cb::function_18e5080e("flg_rooftops_start", var_b9f6cfe);
  level thread namespace_fc3e8cb::function_1c62d05e("ai_enemy_facades_drone", "flg_rooftops_start");
}

function function_22df39e0() {
  self endon(#"death");
  self ai::set_pacifist(1);
  self.script_accuracy = 0.5;
  self.grenadeammo = 0;
  level flag::wait_till("flg_facades_dropdown");
  self ai::set_pacifist(0);
}

function function_20d4e36c() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_10a7296c = struct::get_array("s_facades_apc_intro_target", "targetname");
  var_10a7296c = array::sort_by_script_int(var_10a7296c, 1);
  level.vh_town_square_apc hms_util::function_c21ef1d8("scripted", var_10a7296c[0].origin);
  level.vh_town_square_apc.aim_only_no_shooting = 1;
  level namespace_fc3e8cb::function_92dea087("flg_facades_start", "flg_facades_dropdown");
  level flag::set("flg_facades_intro_apc");
  level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_75a9fa51();
  level.vh_town_square_apc.aim_only_no_shooting = undefined;
  level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d(var_10a7296c, "end_facades_intro_fake_shooting");
  level.vh_town_square_apc turret::function_aecc6bed(var_10a7296c, 1, 0, 0.15);
  level.vh_town_square_apc notify(#"end_facades_intro_fake_shooting");
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
  var_2fb1c08b = struct::get_array("s_facades_apc_target_mannequin", "targetname");
  array::thread_all(var_2fb1c08b, &namespace_fc3e8cb::function_649019cf, "flg_storage_end");
  level namespace_fc3e8cb::function_92dea087("flg_facades_corridor_enter", "flg_facades_corridor_approach");
  var_86a0a866 = struct::get_array("s_facades_apc_wall_target", "targetname");
  var_86a0a866 = array::sort_by_script_int(var_86a0a866, 1);
  level.vh_town_square_apc hms_util::function_c21ef1d8("scripted", var_86a0a866[0].origin);
  level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d(var_86a0a866, "end_facades_wall_fake_shooting");
  level.vh_town_square_apc turret::function_aecc6bed(var_86a0a866, 1, 0, 0.15);
  level.vh_town_square_apc notify(#"end_facades_wall_fake_shooting");
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
  level flag::wait_till("flg_facades_end");
  level.vh_town_square_apc hms_util::function_c21ef1d8("los_player");
}

function function_2bd1a728() {
  scene::function_27f5972e("p9_fxanim_rus_amk_building_facade_sim_bundle");
  level thread function_e8e989b6();
  level thread function_9a4d45a4();
  level thread function_d32c932f();
  level flag::wait_till("flg_facades_end");
  scene::function_f81475ae("p9_fxanim_rus_amk_building_facade_sim_bundle");
}

function function_e8e989b6() {
  level namespace_fc3e8cb::function_92dea087("flg_facades_turn_corner", "flg_facades_near_corner");
  level flag::set("flg_facades_destruction_scene_1");
  s_scene = struct::get("s_facades_destruction_scene_1", "targetname");
  s_scene thread scene::play_from_time("play");
  s_scene function_8cc9e7c2(1);
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
}

function function_9a4d45a4() {
  level namespace_fc3e8cb::function_92dea087("flg_facades_corridor_midpoint", "flg_facades_destruction_2_play");
  level flag::set("flg_facades_destruction_scene_2");
  level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_c7c2eb9c();
  s_scene = struct::get("s_facades_destruction_scene_2", "targetname");
  s_scene thread scene::play_from_time("play");
  s_scene function_8cc9e7c2();
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
}

function function_d32c932f() {
  level namespace_fc3e8cb::function_92dea087("flg_facades_near_end", "flg_facades_destruction_3_play");
  level flag::set("flg_facades_destruction_scene_3");
  s_scene = struct::get("s_facades_destruction_scene_3", "targetname");
  s_scene thread scene::play_from_time("play");
  s_scene function_8cc9e7c2();
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
}

function function_63c5e2dc(var_f487c534) {
  a_targets = [];
  str_anim = var_f487c534.str_current_anim;
  notetracks = getnotetracksindelta(str_anim, 0, 999);

  if(notetracks.size) {
    foreach(notetrack in notetracks) {
      if(notetrack[1] == # "hash_2eff926bcf50d924" && notetrack[2] != # "end") {
        v_tag_origin = var_f487c534 gettagorigin(notetrack[2]);
        a_targets[a_targets.size] = v_tag_origin;
      }
    }
  }

  return a_targets;
}

function function_8cc9e7c2(var_43182387 = 0) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_facades_end");
  self endon(#"scene_stop");
  var_17b7891d = "ce44873009f8c9a" + turret::_index(0);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  var_f487c534 = self.scene_ents[# "prop 2"];
  level.vh_town_square_apc hms_util::function_c21ef1d8("scripted");
  var_afa4f4f6 = 0;
  w_weapon = turret::get_weapon(0);
  s_turret = level.vh_town_square_apc.a_turrets[0];
  a_targets = function_63c5e2dc(var_f487c534);
  var_ba051ef5 = 0;

  if(a_targets.size) {
    level.vh_town_square_apc turret::set_target(a_targets[var_ba051ef5], undefined, 0);
  }

  while(true) {
    return_val = var_f487c534 waittill(#"hash_2eff926bcf50d924");

    if(return_val.tag_name === # "end") {
      break;
    }

    v_end_pos = var_f487c534 gettagorigin(return_val.tag_name);
    level.vh_town_square_apc hms_util::function_b5da96ca(v_end_pos, 0, 0);
    earthquake(0.3, 0.3, v_end_pos, 600);
    var_ba051ef5++;

    if(var_ba051ef5 < a_targets.size) {
      level.vh_town_square_apc turret::set_target(a_targets[var_ba051ef5], undefined, 0);
    }

    var_51b8d0b4 = distance2dsquared(level.player.origin, v_end_pos);

    if(var_51b8d0b4 < sqr(600)) {
      level.player playrumbleonentity("damage_light");

      if(var_afa4f4f6 == 0) {
        level.player thread function_f94da504(var_43182387, v_end_pos);
        var_afa4f4f6 = 1;
      }
    }

    waitframe(1);
  }
}

function function_f94da504(var_43182387 = 0, v_end_pos) {
  weapon = getweapon(#"hash_161ca1bfb05ce95c");
  var_7444953c = getstatuseffect(#"explosive_damage");
  var_da14b792 = getstatuseffect(#"hash_18a614e9da539cfc");
  var_c459838 = getstatuseffect(#"hash_43002ea60b520663");
  level.player util::blend_movespeedscale(0.85, 0.5);

  if(var_43182387 == 1) {
    level.player status_effect::status_effect_apply(var_da14b792, weapon, level.vh_town_square_apc, undefined, 1000, undefined, v_end_pos);
    level function_b8b3d2aa();
  } else {
    wait 1;
  }

  level.player util::blend_movespeedscale(0.9, 1);
}

function function_b8b3d2aa(var_ab3e25a2) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  snd::client_msg("sfx_explode_reaction");
  level.player playgestureviewmodel(#"hash_122fc8a38a46356a");
  level.player val::set("facades_flinch", "allow_sprint", 0);
  var_711343eb = level.player getnormalhealth() * 0.8;
  level.player setnormalhealth(var_711343eb);
  wait 0.5;
  level.player waittilltimeout(1, #"sprint");
  level.player stopgestureviewmodel(#"hash_122fc8a38a46356a");
  wait 0.5;
  level.player val::reset("facades_flinch", "allow_sprint");
}

function function_7afbb8d0() {
  level flag::wait_till("flg_amk_player_spawned");
  level endon(#"flg_facades_end");
  callback::function_c046382d(&function_453ac55b);
  level flag::wait_till("flg_facades_end");
  callback::function_489cbdb4(&function_453ac55b);
}

function function_453ac55b(s_info) {
  attacker = s_info.eattacker;
  weapon = s_info.weapon;

  if(attacker === level.vh_town_square_apc || weapon === getweapon(#"hash_161ca1bfb05ce95c")) {
    level.var_85b00b2b = # "hash_2369a83a48c6a89b";
    level.var_30eb363 = # "hash_4396a9df7f2650e6";
  }
}

function function_3c9f8a88(str_objective) {
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_rooftops", 0, 0);
  level flag::set("flg_facades_enemies_most_dead");
  level flag::set("flg_facades_dropdown");
  level thread namespace_fc3e8cb::function_f87024e0("nd_vh_town_square_apc_rooftops_start", "los_player");
  namespace_b61bbd82::music("12.1_exit");
}

function rooftops_main(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  if(!var_50cc0d4f) {
    savegame::checkpoint_save(1);
  }

  level thread function_c691e305("s_obj_rooftops_breadcrumb");
  level thread function_842a66a1();
  level thread function_da6ccedc();
  level thread function_999d0913();
  level thread function_b3e9c19d();
  level flag::wait_till("flg_rooftops_end");
  skipto::function_4e3ab877(str_objective);
}

function function_21fbbfb2(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(!isDefined(level.vh_escape_apc)) {
    level.vh_escape_apc = vehicle::simple_spawn_single("vh_escape_apc");
    level.vh_escape_apc util::magic_bullet_shield();
    level.vh_escape_apc setCanDamage(0);
  }
}

function function_842a66a1() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.player util::blend_movespeedscale_default(1);
  level namespace_fc3e8cb::function_5c5b6ea7("nd_rooftops_woods_start");
  level flag::wait_till("flg_rooftops_start");
  level.woods clearforcedgoal();
  level thread namespace_4bd68414::function_c948bfdd();
  level scene::play("sc_facades_woods_jump_down", "jump_down", [level.woods]);
  level.woods colors::set_force_color("blue");
  level flag::wait_till("flg_rooftops_approaching_exit");
  level.woods colors::disable();
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_bank_woods_start");
}

function function_da6ccedc() {
  level thread scene::init("rooftops_rappel_scene", "targetname");
  level flag::wait_till("flg_rooftops_start");
  level thread scene::play("rooftops_rappel_scene", "targetname");
  level thread namespace_fc3e8cb::function_fa5905d0("s_rooftops_heli_lights");
  println("<dev string:x51>");
  var_653186e7 = spawner::simple_spawn("ai_enemy_rooftops");
  var_1ea2c1da = getaiarray("ai_rooftops_rappel_group", "targetname");
  level thread function_266d11ca(var_1ea2c1da);
  var_653186e7 = arraycombine(var_653186e7, var_1ea2c1da);
  level thread namespace_fc3e8cb::function_85939627(var_653186e7, "flg_rooftops_enemies_most_dead_1", var_653186e7.size - 2);
  var_63d2d7ec = level flag::wait_till_any(["flg_rooftops_advance_right_high", "flg_rooftops_advance_right_low", "flg_rooftops_advance_center", "flg_rooftops_advance_left", "flg_rooftops_enemies_most_dead_1"]);
  println("<dev string:x6b>");
  var_41419b58 = spawner::simple_spawn("ai_enemy_rooftops_add_1", &function_bd70a66d);
  var_4c08b0e6 = spawner::simple_spawn("ai_enemy_rooftops_add_2");
  var_653186e7 = arraycombine(var_653186e7, var_41419b58);
  var_653186e7 = arraycombine(var_653186e7, var_4c08b0e6);
  level thread namespace_fc3e8cb::function_85939627(var_653186e7, "flg_rooftops_enemies_dead", var_653186e7.size);
  level thread namespace_fc3e8cb::function_85939627(var_653186e7, "flg_rooftops_enemies_most_dead_2", var_653186e7.size - 2);
  level thread namespace_fc3e8cb::function_18e5080e("flg_storage_advance_1", var_653186e7);
  level thread namespace_fc3e8cb::function_940ffdb0(["flg_rooftops_advance_right_end", "flg_rooftops_advance_left_end"], var_653186e7, "vol_rooftops_enemy_exit", 2);

  if(var_63d2d7ec._notify === # "flg_rooftops_advance_right_high") {
    level thread namespace_fc3e8cb::function_8e158d78(var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0);
    level thread namespace_fc3e8cb::function_8e158d78(var_4c08b0e6, "vol_rooftops_enemy_left", undefined, 0);
  } else if(var_63d2d7ec._notify === # "flg_rooftops_advance_right_low" || var_63d2d7ec._notify === # "flg_rooftops_advance_left") {
    level thread namespace_fc3e8cb::function_8e158d78(var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0);
    level thread namespace_fc3e8cb::function_8e158d78(var_4c08b0e6, "vol_rooftops_enemy_right", undefined, 0);
  } else {
    level thread namespace_fc3e8cb::function_8e158d78(var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0);
    level thread namespace_fc3e8cb::function_8e158d78(var_4c08b0e6, "vol_rooftops_enemy_exit", undefined, 0);
  }

  var_78d92c9 = getEntArray("t_rooftops_advance_2", "targetname");
  array::delete_all(var_78d92c9);
  wait 1;
  function_1eaaceab(var_653186e7);
  level thread namespace_fc3e8cb::function_940ffdb0(["flg_rooftops_approaching_exit", "flg_rooftops_enemies_most_dead_2"], var_653186e7);
}

function function_266d11ca(var_1ea2c1da) {
  function_1eaaceab(var_1ea2c1da);

  foreach(index, ai in var_1ea2c1da) {
    switch (index) {
      case 0:
        vol = getent("vol_rooftops_enemy_right", "targetname");
        break;
      case 1:
        vol = getent("vol_rooftops_enemy_left", "targetname");
        break;
      default:
        vol = getent("vol_rooftops_enemy_back", "targetname");
        break;
    }

    ai thread namespace_fc3e8cb::function_a7c9ed68(vol, 1);
  }

  wait 1;
  s_rooftops_smoke = struct::get("s_rooftops_smoke", "targetname");
  level.player magicgrenadeplayer(getweapon(#"willy_pete"), s_rooftops_smoke.origin, (0, 0, 0));
}

function function_bd70a66d() {
  self endon(#"death");
  level flag::wait_till_any(["flg_rooftops_advance_right_end", "flg_rooftops_advance_left_end"]);
  self ai::set_goal("vol_rooftops_enemy_exit", "targetname", 1);
}

function function_b3e9c19d() {
  level flag::wait_till("flg_rooftops_start");
  s_mb_start = struct::get("s_rooftops_mannequin_mb_start", "targetname");
  var_ea066846 = struct::get("s_rooftops_mannequin_mb_end", "targetname");
  var_a75f2965 = getweapon(#"frag_grenade");
  var_1da2248f = spawn("script_model", s_mb_start.origin);
  var_38ffd5df = vectornormalize(var_ea066846.origin - s_mb_start.origin) * 400;
  e_grenade = var_1da2248f magicgrenadetype(var_a75f2965, s_mb_start.origin, var_38ffd5df, 1.5);
  var_1da2248f deletedelay();
}

function function_999d0913() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.vh_town_square_apc hms_util::function_c21ef1d8("los_player");
}

function function_a5be8514() {
  self flashlight::function_7c2f623b();
}

function function_69d1435d(str_objective) {
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_storage", 0, 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_townsquare_keys_static", 1);
  level thread namespace_fc3e8cb::function_f87024e0("nd_vh_town_square_apc_storage_start");
  namespace_b61bbd82::music("12.1_exit");
}

function function_f13abd77(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  if(!var_50cc0d4f) {
    savegame::checkpoint_save(1);
  }

  level thread cp_rus_amerika::function_f6b6f426("apc_townsquare");
  level thread function_c691e305("s_obj_storage_breadcrumb");
  level thread function_832279f3();
  level thread function_502e3f72();
  level thread function_502e1c27();
  level thread function_d505ce28();
  level flag::wait_till("flg_storage_end");
  skipto::function_4e3ab877(str_objective);
}

function function_80555a03(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level thread namespace_fc3e8cb::function_6fe40e14("storage_gun_rack4", "storage_gun_rack5", "storage_gun_rack6");
}

function function_832279f3() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level thread namespace_4bd68414::function_be7fb8d0();
  level.woods.grenadeammo = 0;
  nd_target = getnode("nd_motor_pool_woods_start", "targetname");
  level.woods thread hms_util::function_2f50100e("stay_even", nd_target.origin, "end_woods_storage_follow");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_storage_woods_bank");
  level flag::wait_till("flg_storage_advance_1");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_storage_woods_corridor");
  level flag::wait_till("flg_storage_advance_2");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_storage_woods_end");
  level.woods notify(#"end_woods_storage_follow");
  level.woods.grenadeammo = 99;
}

function function_502e3f72() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  var_b8e95930 = struct::get_array("s_storage_apc_bank_target", "targetname");
  var_b8e95930 = array::sort_by_script_int(var_b8e95930, 1);
  level.vh_town_square_apc hms_util::function_c21ef1d8("scripted", var_b8e95930[0].origin);
  level.vh_town_square_apc.aim_only_no_shooting = 1;
  level flag::wait_till("flg_bank_destruction_play");
  level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_d6d8868f();
  level.vh_town_square_apc.aim_only_no_shooting = undefined;
  level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d(var_b8e95930, "end_facades_intro_fake_shooting");
  level.vh_town_square_apc turret::function_aecc6bed(var_b8e95930, 1, 0, 0.2);
  level.vh_town_square_apc notify(#"end_facades_intro_fake_shooting");
  exploder::exploder("fx_bank_lingering_dust");
  level.vh_town_square_apc hms_util::function_c21ef1d8("shoot_player");
  var_e2720fa8 = struct::get_array("s_bank_apc_target_mannequin", "targetname");
  array::thread_all(var_e2720fa8, &namespace_fc3e8cb::function_649019cf, "flg_storage_end");
  level flag::wait_till("flg_storage_advance_1");
  wait 1;
  level.vh_town_square_apc hms_util::function_c21ef1d8("los_player");
}

function function_36c18ca(str_objective) {
  level thread function_502e1c27();
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_motor_pool", 0, 0);
  level thread function_d505ce28();
  level thread namespace_fc3e8cb::function_f87024e0("nd_vh_town_square_apc_storage_start");
  namespace_b61bbd82::music("12.1_exit");
}

function function_3b55ec61(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  if(var_50cc0d4f) {
    level thread cp_rus_amerika::function_f6b6f426("apc_townsquare");
  }

  level thread function_1ec720d1();
  level thread function_f197858e();
  level thread function_b415da85();
  level thread function_c8c76a4f();
  level thread function_7f87d6ab();
  level thread function_7824cd0c();
  level thread function_14fb9b43();
  level flag::wait_till_any(["flg_escape_apc_interact_triggered", "flg_motor_pool_all_enemies_dead"]);
  level flag::set("flg_motor_pool_end");
  skipto::function_4e3ab877(str_objective);
}

function function_b78a9ad4(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_facades", 1);

  if(player) {
    level scene::init("sc_motor_pool_entry_door");
    level thread function_d505ce28(1);
    level flag::set("flg_motor_pool_giant_doors_closed");
  }
}

function function_1ec720d1() {
  s_obj_motor_pool_exit = struct::get("s_obj_motor_pool_exit", "targetname");
  objectives::goto("obj_motor_pool_exit", s_obj_motor_pool_exit.origin, #"hash_25ceb846d38703d", 0);
  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  wait 3;
  objectives::complete("obj_motor_pool_exit");
  var_cb754cc9 = getaiarray("ai_juggernaut_motor_pool", "targetname");
  function_1eaaceab(var_cb754cc9);
  level thread namespace_fc3e8cb::function_85939627(var_cb754cc9, "flg_motor_pool_first_enemies_dead");
  objectives::kill("obj_motor_pool_kill_all", var_cb754cc9, #"hash_5139e3b2c7df628", 0, 0);
  level flag::wait_till_any(["flg_motor_pool_first_enemies_dead", "flg_motor_pool_end"]);
  var_e6bbe965 = getaiarray("ai_juggernaut_motor_pool_2", "targetname");
  function_1eaaceab(var_e6bbe965);
  level thread namespace_fc3e8cb::function_85939627(var_e6bbe965, "flg_motor_pool_objective_enemies_dead");
  objectives::kill("obj_motor_pool_kill_all", var_e6bbe965, #"hash_5139e3b2c7df628", 0, 0);
  level flag::wait_till_any(["flg_motor_pool_objective_enemies_dead", "flg_motor_pool_end"]);
  objectives::complete("obj_motor_pool_kill_all");

  if(level flag::get("flg_escape_apc_interact_triggered") == 0) {
    s_obj_motor_pool_apc = struct::get("s_obj_motor_pool_apc", "targetname");
    objectives::goto("obj_motor_pool_apc", s_obj_motor_pool_apc.origin, #"hash_1ef0e93b7e6fa136", 0);
    level flag::wait_till("flg_escape_apc_interact_triggered");
    objectives::complete("obj_motor_pool_apc");
  }
}

function function_f197858e() {
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_alarm", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_townsquare_keys_static", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_townsquare_keys", 1);
  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_alarm", 0);
  level waittill(#"hash_2bce2e22f84ebf05");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_closed_state", 0);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_motorpool_intermediate_state", 0);
}

function function_b415da85() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level thread namespace_4bd68414::function_7dec07c8();
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_storage_woods_end");
  level.woods ai::function_3a5e9945(1);
  level.woods.grenadeammo = 0;
  level.woods val::set(#"hash_7f4af3d9057acdb8", "ignoreme", 1);
  level.woods ai::set_pacifist(1);
  level.woods battlechatter::function_2ab9360b(0);
  level flag::wait_till("flg_motor_pool_door_player_interact");

  if(level flag::get("flg_storage_woods_at_exit") == 0) {
    nd_storage_woods_end = getnode("nd_storage_woods_end", "targetname");
    level.woods forceteleport(nd_storage_woods_end.origin, nd_storage_woods_end.angles);
  } else {
    level.woods ai::set_behavior_attribute("demeanor", "cqb");
  }

  level flag::wait_till("flg_motor_pool_entry_door_open");
  savegame::function_7790f03(1);
  level thread namespace_4bd68414::function_bd85f877();
  level.woods ai::function_3a5e9945(0);
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_motor_pool_woods_door");
  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  level.woods namespace_fc3e8cb::function_d74bffa7();
  level.woods clearforcedgoal();
  level.woods ai::enable_careful();
  level.woods colors::set_force_color("blue");
  level thread function_1363e7a3();
  level thread function_41ffe14();
  level thread namespace_4bd68414::function_6e5fd7a7();
  level flag::wait_till("flg_motor_pool_close_doors");
  level thread namespace_4bd68414::function_3bcf30f9();
  snd::client_msg("flg_audio_motorpool_huge_door_close");
  level thread function_d48996da();
  level flag::wait_till_any(["flg_motor_pool_all_enemies_dead", "flg_escape_apc_interact_triggered"]);
  level.woods colors::disable();
  level.woods ai::disable_careful();
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_apc_turret_woods_start", 0, 1);
}

function function_1363e7a3() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"hash_6ebbd9a42d92d5c6");
  wait randomfloatrange(1, 3);
  level hms_util::function_53531f27("t_motor_pool_start");
}

function function_41ffe14() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_motor_pool_end");
  level flag::wait_till_any(["flg_motor_pool_left_path", "flg_motor_pool_right_path"]);

  if(level flag::get("flg_motor_pool_right_path") == 1) {
    level flag::wait_till("flg_motor_pool_advance_1");
    level hms_util::function_53531f27("t_motor_pool_right_path_1");
    level flag::wait_till("flg_motor_pool_advance_2");
    level hms_util::function_53531f27("t_motor_pool_right_path_2");
    level flag::wait_till("flg_motor_pool_advance_3");
    level hms_util::function_53531f27("t_motor_pool_right_path_3");
    level flag::wait_till("flg_motor_pool_advance_4");
    level hms_util::function_53531f27("t_motor_pool_right_path_4");
    level flag::wait_till("flg_motor_pool_all_juggernauts_dead");
    level hms_util::function_53531f27("t_motor_pool_right_path_5");
    return;
  }

  level flag::wait_till("flg_motor_pool_advance_1");
  level hms_util::function_53531f27("t_motor_pool_left_path_1");
  level flag::wait_till("flg_motor_pool_advance_2");
  level hms_util::function_53531f27("t_motor_pool_left_path_2");
  level flag::wait_till("flg_motor_pool_advance_3");
  level hms_util::function_53531f27("t_motor_pool_left_path_3");
  level flag::wait_till("flg_motor_pool_advance_4");
  level hms_util::function_53531f27("t_motor_pool_left_path_4");
  level flag::wait_till("flg_motor_pool_all_juggernauts_dead");
  level hms_util::function_53531f27("t_motor_pool_left_path_5");
}

function function_d48996da() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_motor_pool_end");
  level flag::wait_till("flg_escape_player_in_apc");

  if(level flag::get("flg_escape_woods_driving_apc") == 0) {
    level thread namespace_4bd68414::function_1569400a();
  }
}

function function_c8c76a4f() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_escape_apc_interact_triggered");
  vol_motor_pool_badplace = getEntArray("vol_motor_pool_badplace", "targetname");
  array::thread_all(vol_motor_pool_badplace, &function_66da7c94);
  level flag::wait_till("flg_motor_pool_entry_door_open");
  println("<dev string:x89>");
  var_892fa6d3 = spawner::simple_spawn("ai_enemy_motor_jugg_escort", &function_748fc350);
  level thread function_db7a929();
  var_b1c1e2d0 = getaiteamarray("axis");

  foreach(index, ai in var_b1c1e2d0) {
    if(isDefined(ai)) {
      if(ai.targetname === "ai_juggernaut_motor_pool") {
        arrayremoveindex(var_b1c1e2d0, index);
      }
    }
  }

  level thread function_289fa2e0();
  level thread namespace_fc3e8cb::function_85939627(var_b1c1e2d0, "flg_motor_pool_initial_enemies_dead", var_b1c1e2d0.size);
  level flag::wait_till("flg_motor_pool_car_1_reached_end");
  var_9323e12d = getaiarray("sp_enemy_motor_pool_car_1", "targetname");
  array::thread_all(var_9323e12d, &function_759dc847);
  level flag::wait_till("flg_motor_pool_car_2_reached_end");
  var_2e4a977c = getaiarray("sp_enemy_motor_pool_car_2", "targetname");
  array::thread_all(var_2e4a977c, &function_759dc847);
  var_18e8eb55 = arraycombine(var_b1c1e2d0, var_9323e12d);
  var_18e8eb55 = arraycombine(var_18e8eb55, var_2e4a977c);
  function_1eaaceab(var_18e8eb55);
  level thread namespace_fc3e8cb::function_18e5080e("flg_apc_ride_town_square_crash", var_18e8eb55);
  level thread function_ec4b436e(var_18e8eb55);
  level flag::wait_till_any_timeout(20, ["flg_motor_pool_advance_1"]);
  level flag::set("flg_motor_pool_enemies_notice_player");
  var_b1c1e2d0 = getaiteamarray("axis");

  foreach(index, ai in var_b1c1e2d0) {
    if(ai.targetname === "ai_juggernaut_motor_pool") {
      arrayremoveindex(var_b1c1e2d0, index);
    }

    if(isvehicle(ai)) {
      arrayremoveindex(var_b1c1e2d0, index);
    }
  }

  level thread namespace_fc3e8cb::function_85939627(var_b1c1e2d0, "flg_motor_pool_most_enemies_dead", int(var_b1c1e2d0.size * 0.5));
  level thread namespace_fc3e8cb::function_940ffdb0("flg_motor_pool_most_enemies_dead", var_b1c1e2d0);
  var_b1c1e2d0 = array::get_all_closest(level.player.origin, var_b1c1e2d0);

  foreach(index, ai in var_b1c1e2d0) {
    if(isDefined(ai)) {
      if(index <= 3) {
        ai ai::set_goal("vol_motor_pool_front", "targetname");
      }

      if(index > 3) {
        ai ai::set_goal("vol_motor_pool_apc", "targetname");
      }

      ai getenemyinfo(level.player);
      ai val::set(#"hash_3721168b725155fc", "ignoreme", 0);
      ai val::set(#"hash_3721168b725155fc", "ignoreall", 0);
      ai ai::set_behavior_attribute("demeanor", "combat");
      ai ai::set_pacifist(0);
      ai ai::function_3a5e9945(0);
      wait randomfloatrange(0.5, 1.5);
    }
  }

  level thread function_debf8314(var_b1c1e2d0);
  level flag::wait_till_all(["flg_motor_pool_advance_3", "flg_motor_pool_all_juggernauts_dead", "flg_motor_pool_reinforcements_dead", "flg_motor_pool_initial_enemies_dead"]);
  level flag::set("flg_motor_pool_all_enemies_dead");
}

function function_ec4b436e(var_18e8eb55) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level flag::wait_till("flg_escape_apc_interact_triggered");
  function_1eaaceab(var_18e8eb55);

  foreach(index, ai in var_18e8eb55) {
    if(ai.targetname === "ai_juggernaut_motor_pool") {
      arrayremoveindex(var_18e8eb55, index);
    }

    if(isvehicle(ai)) {
      arrayremoveindex(var_18e8eb55, index);
    }
  }

  var_abeb3258 = arraysortclosest(var_18e8eb55, level.player.origin, 3);
  var_b7c3b3b2 = array::exclude(var_18e8eb55, var_abeb3258);
  array::delete_all(var_b7c3b3b2);
}

function function_66da7c94() {
  name = self.script_noteworthy;
  x = self.var_57e27c13;
  y = self.var_112f6eae;
  z = self.var_fb714332;
  badplace_box(name, 0, self.origin, (x, y, z), "axis");
  level flag::wait_till("flg_motor_pool_end");
  badplace_delete(name);
}

function function_debf8314(ai_array) {
  level flag::wait_till_any(["flg_motor_pool_most_enemies_dead", "flg_motor_pool_advance_3", "flg_motor_pool_one_juggernaut_dead"]);
  function_1eaaceab(ai_array);

  foreach(ai in ai_array) {
    vol_fallback = getent("vol_motor_pool_left", "targetname");
    ai thread ai::force_goal(vol_fallback);
  }
}

function function_289fa2e0() {
  var_caac7c01 = vehicle::simple_spawn_single("veh01");
  var_73da4e5e = vehicle::simple_spawn_single("veh02");
  snd::play("evt_enemy_jeep_01_drive_up", var_caac7c01);
  snd::play("evt_enemy_jeep_02_drive_up", var_73da4e5e);
  var_caac7c01 thread function_c71ae0c4("veh1_enter");
  var_73da4e5e thread function_c71ae0c4("veh2_enter");
}

function function_c71ae0c4(str_shot) {
  self endon(#"death");
  level thread scene::play("scene_amk_7010_mot_garage_trucks", str_shot, self);
  self waittill(#"unload");
  self vehicle::unload();
}

function function_db7a929() {
  level endon(#"flg_escape_player_in_apc");
  level flag::wait_till_any(["flg_motor_pool_advance_3", "flg_motor_pool_one_juggernaut_dead"]);
  wait 2;
  var_c9ec79c6 = getent("sm_motor_pool_reinforcements_smoke", "targetname");
  e_grenade = level.player magicgrenadeplayer(getweapon(#"willy_pete"), var_c9ec79c6.origin, (0, 0, 0));
  e_grenade.var_3791d005 = 0;
  var_f201782a = spawner::simple_spawn("ai_enemy_motor_pool_reinforcements", &function_25ec03fc);

  foreach(ai in var_f201782a) {
    switch (level.gameskill) {
      case 0:
        ai.script_accuracy = 0.4;
        break;
      case 1:
        ai.script_accuracy = 0.5;
        break;
      case 2:
        ai.script_accuracy = 0.6;
        break;
      case 3:
        ai.script_accuracy = 0.7;
        break;
      default:
        ai.script_accuracy = 1;
        break;
    }
  }

  level flag::wait_till("flg_motor_pool_one_juggernaut_dead");
  level thread namespace_fc3e8cb::function_85939627(var_f201782a, "flg_motor_pool_reinforcements_dead");
  level thread namespace_fc3e8cb::function_18e5080e("flg_apc_ride_town_square_crash", var_f201782a);
  function_1eaaceab(var_f201782a);

  foreach(ai in var_f201782a) {
    ai.script_accuracy = 1;
  }
}

function function_748fc350() {
  self endon(#"death");
  self.grenadeammo = 0;
  self thread function_759dc847("patrol");
  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  wait randomfloatrange(0, 0.75);
  self val::set(#"hash_3721168b725155fc", "ignoreme", 0);
  self val::set(#"hash_3721168b725155fc", "ignoreall", 0);
  self ai::set_behavior_attribute("demeanor", "combat");
  self ai::set_pacifist(0);
  self notify(#"stop_going_to_node");
  self ai::set_goal("vol_motor_pool_front");
  level flag::wait_till("flg_escape_apc_interact_triggered");
  self ai::set_goal("vol_motor_pool_gate");
  self thread namespace_fc3e8cb::function_a9674e4a();
}

function function_25ec03fc() {
  self endon(#"death");
  self.grenadeammo = 0;
  level flag::wait_till("flg_escape_apc_interact_triggered");
  self ai::set_goal("vol_motor_pool_gate");
  self thread namespace_fc3e8cb::function_a9674e4a();
}

function function_d505ce28(var_67ce64a8 = 0) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level scene::init("sc_motor_pool_giant_doors", "targetname");
  level thread function_8d7a1baa();

  if(var_67ce64a8 == 1) {
    level scene::play_from_time("sc_motor_pool_giant_doors", "targetname", undefined, 0.99, 1);
  } else {
    level flag::wait_till("flg_motor_pool_close_doors");
    s_obj_motor_pool_exit = struct::get("s_obj_motor_pool_exit", "targetname");
    var_416224db = spawn("script_model", s_obj_motor_pool_exit.origin);
    var_416224db.origin = s_obj_motor_pool_exit.origin;
    level.player playrumbleonentity("anim_light");
    var_416224db playrumblelooponentity("cp_rus_amerika_apc_driveby");
    level scene::play("sc_motor_pool_giant_doors", "targetname");
    level.player playrumbleonentity("anim_med");
    earthquake(0.5, 1, s_obj_motor_pool_exit.origin, 1600);
    var_416224db delete();
  }

  level flag::set("flg_motor_pool_giant_doors_closed");
}

function function_8d7a1baa() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_motor_pool_giant_doors_closed");
  level flag::wait_till("flg_motor_pool_exit_kill");
  v_fwd = anglesToForward(level.player getplayerangles());
  var_1c8839e = level.player getEye() + v_fwd * -80;
  a_enemies = getaiarray("ai_juggernaut_motor_pool", "targetname");

  if(a_enemies.size <= 0) {
    a_enemies = getaiteamarray("axis");

    foreach(index, ai in a_enemies) {
      if(isvehicle(ai)) {
        arrayremoveindex(a_enemies, index);
      }
    }
  }

  if(a_enemies.size > 0) {
    a_enemies = arraysortclosest(a_enemies, level.player.origin);
    magicbullet(getweapon(#"hash_228ab35af2dae712"), var_1c8839e, level.player getEye(), a_enemies[0]);
  }

  level.player util::stop_magic_bullet_shield();
  level.player disableinvulnerability();
  waitframe(1);

  if(level.player util::function_a1d6293() == 0) {
    while(!level.player.allowdeath) {
      waitframe(1);
    }

    level.player kill();
  }
}

function function_14fb9b43() {
  assert(isDefined(level.vh_escape_apc));
  a_scene_ents[# "apc"] = level.vh_escape_apc;
  level thread scene::init("scene_amk_7010_esc_apc_enter", a_scene_ents);
  var_f9b7abd8 = struct::get("s_escape_apc_player_interact");
  var_f9b7abd8 util::create_cursor_hint(undefined, undefined, #"hash_394eef05c5d5cf3b", 90, 0.5, undefined, #"use", 400, undefined, 0, 0);
  var_f9b7abd8 prompts::set_objective("obj_motor_pool_apc");
  var_f9b7abd8 prompts::function_5698d1c9(#"use", 45);
  var_f9b7abd8 waittill(#"trigger");
  level flag::set("flg_escape_apc_interact_triggered");
  level.player flag::set("no_deaths_door_warning");
  level thread function_8ac4bc54();
  var_f9b7abd8 util::delay(0.2, undefined, &util::remove_cursor_hint);
  objectives::complete("obj_motor_pool_apc");
}

function function_8ac4bc54() {
  wait 0.9;
  level.player playrumbleonentity("status_effect_dot");
  wait 0.7;
  level.player playrumbleonentity("status_effect_dot");
  wait 0.7;
  level.player playrumbleonentity("status_effect_dot");
  wait 1.5;
  level.player playrumbleonentity("damage_light");
}

function function_7f87d6ab() {
  level flag::wait_till("flg_motor_pool_entry_door_open");
  var_69297501 = spawner::simple_spawn("ai_juggernaut_motor_pool");
  level thread namespace_fc3e8cb::function_85939627(var_69297501, "flg_motor_pool_one_juggernaut_dead", 1);
  level thread namespace_fc3e8cb::function_18e5080e("flg_apc_ride_town_square_crash", var_69297501);
  level array::thread_all(var_69297501, &function_1b30661c);
  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  level flag::wait_till_any(["flg_motor_pool_most_enemies_dead", "flg_motor_pool_advance_3", "flg_motor_pool_one_juggernaut_dead"]);
  wait 2;
  var_7813aed0 = spawner::simple_spawn("ai_juggernaut_motor_pool_2");
  var_69297501 = arraycombine(var_69297501, var_7813aed0);
  function_1eaaceab(var_69297501);
  s_motor_pool_jugpos_mid = struct::get("s_motor_pool_jugpos_mid");
  s_motor_pool_jugpos_paths = struct::get("s_motor_pool_jugpos_paths");

  foreach(ai in var_69297501) {
    if(ai.script_noteworthy == "ai_juggernaut_motor_pool_front") {
      ai namespace_631d466b::function_6aedb63(s_motor_pool_jugpos_paths.origin, s_motor_pool_jugpos_paths.radius, s_motor_pool_jugpos_paths.var_ed151f4c);
      continue;
    }

    ai namespace_631d466b::function_6aedb63(s_motor_pool_jugpos_mid.origin, s_motor_pool_jugpos_mid.radius, s_motor_pool_jugpos_mid.var_ed151f4c);
    self.favoriteenemy = level.player;
  }

  level thread namespace_fc3e8cb::function_85939627(var_69297501, "flg_motor_pool_all_juggernauts_dead", var_69297501.size);
}

function function_1b30661c() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death");
  self namespace_631d466b::function_712776a6(1);
  s_motor_pool_jugpos_front = struct::get("s_motor_pool_jugpos_front");
  s_motor_pool_jugpos_mid = struct::get("s_motor_pool_jugpos_mid");
  s_motor_pool_jugpos_back = struct::get("s_motor_pool_jugpos_back");
  s_motor_pool_jugpos_turret = struct::get("s_motor_pool_jugpos_turret");
  s_motor_pool_jugpos_paths = struct::get("s_motor_pool_jugpos_paths");
  s_motor_pool_jugpos_intro = struct::get("s_motor_pool_jugpos_intro");
  var_63f3845d = struct::get("motor_pool_jugpos_intro_mid");

  if(self.script_noteworthy === "ai_juggernaut_motor_pool_front") {
    self setgoal(s_motor_pool_jugpos_intro.origin, 1, 48, 128);
  } else {
    self setgoal(var_63f3845d.origin, 1, undefined, undefined, var_63f3845d.angles);
  }

  level flag::wait_till("flg_motor_pool_enemies_notice_player");
  self namespace_631d466b::function_712776a6(0);

  if(self.script_noteworthy == "ai_juggernaut_motor_pool_front") {
    self namespace_631d466b::function_6aedb63(s_motor_pool_jugpos_paths.origin, s_motor_pool_jugpos_paths.radius, s_motor_pool_jugpos_paths.var_ed151f4c);
  }

  self.favoriteenemy = level.player;
}

function function_1edc596e() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"death", #"damage", #"flg_motor_pool_enemies_notice_player");

  while(true) {
    if(self cansee(level.player)) {
      break;
    }

    wait 0.5;
  }

  wait 1;
  level flag::set("flg_motor_pool_enemies_notice_player");
}

function function_7824cd0c() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  self endon(#"flg_motor_pool_enemies_notice_player");
  var_b4767ac9 = level.player waittill(#"weapon_fired", #"grenade_fire", #"offhand_fire");

  if(var_b4767ac9._notify === # "grenade_fire") {
    wait 2;
  } else if(var_b4767ac9._notify === # "offhand_fire") {
    wait 1;
  }

  level flag::set("flg_motor_pool_enemies_notice_player");
}

function function_759dc847(var_5207b7a8 = "cqb") {
  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  self ai::set_behavior_attribute("demeanor", var_5207b7a8);
  self ai::set_pacifist(1);

  switch (level.gameskill) {
    case 0:
      self.script_accuracy = 0.4;
      break;
    case 1:
      self.script_accuracy = 0.5;
      break;
    case 2:
      self.script_accuracy = 0.6;
      break;
    case 3:
      self.script_accuracy = 0.7;
      break;
    default:
      self.script_accuracy = 1;
      break;
  }

  s_goal = struct::get(self.script_noteworthy, "targetname");

  if(isDefined(s_goal)) {
    self spawner::go_to_struct(s_goal);
  }

  level flag::wait_till("flg_motor_pool_one_juggernaut_dead");
  self.script_accuracy = 1;
}

function function_502e1c27() {
  level scene::init("sc_motor_pool_entry_door");
  s_obj_motor_pool_door_interact = struct::get("s_obj_motor_pool_door_interact", "targetname");
  objectives::goto("obj_motor_pool_interact", s_obj_motor_pool_door_interact.origin);
  s_obj_motor_pool_door_interact util::create_cursor_hint(undefined, undefined, #"hash_737d6de260985ae3", 60);
  s_obj_motor_pool_door_interact prompts::set_objective("obj_motor_pool_exit");
  s_obj_motor_pool_door_interact prompts::function_5698d1c9(#"use", 45);
  s_obj_motor_pool_door_interact waittill(#"trigger");
  objectives::complete("obj_motor_pool_interact");

  hms_util::print("<dev string:xa5>");

  level thread function_3297dd11();
  level.player playrumbleonentity("anim_light");
  level namespace_2977687d::scene_amk_6090_stg_garage();
  snd::client_msg("audio_motor_pool_rollup_door");
  level flag::set("flg_motor_pool_door_player_interact");
  var_6c4841fb = getent("sm_motor_pool_entry_door", "targetname");
  var_6c4841fb util::delay(2, undefined, &movey, 256, 0.1, 0.05, 0.05);
  level scene::play("sc_motor_pool_entry_door", "Open");
  s_obj_motor_pool_door_interact util::delay(0.2, undefined, &util::remove_cursor_hint);
  level flag::set("flg_motor_pool_entry_door_open");
  var_6c4841fb connectpaths();
  level flag::wait_till("flg_motor_pool_close_doors");
  var_6c4841fb movey(-256, 0.1, 0.05, 0.05);
  var_6c4841fb disconnectpaths();
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_facades", 1);
  level scene::play("sc_motor_pool_entry_door", "Close");
}

function function_3297dd11() {
  ai_guard = spawner::simple_spawn_single("motor_pool_entry_guard");
  ai_guard.grenadeammo = 0;
  ai_guard.health = 10;
  ai_guard.script_accuracy = 0.5;
  ai_guard endoncallback(&function_217b2fe2, #"death", #"takedown_executed");
  ai_guard ai::set_behavior_attribute("demeanor", "patrol");
  ai_guard thread function_1edc596e();
  level waittilltimeout(10, #"flg_motor_pool_enemies_notice_player");
  s_goal = struct::get("motor_pool_entry_guard_dest");
  ai_guard notify(#"stop_going_to_node");
  ai_guard setgoal(level.player, 0, 16);
  s_waitresult = level waittilltimeout(2, #"flg_motor_pool_enemies_notice_player");
  ai_guard ai::set_behavior_attribute("demeanor", "combat");
  ai_guard setgoal(level.player, 0, 1000);
}

function function_217b2fe2(str_notify) {
  if(str_notify == "takedown_executed") {
    var_2878dc27 = ["vox_cp_amrk_01200_svs1_intruder_6e", "vox_cp_amrk_01200_svs1_ineedbackup_dc", "vox_cp_amrk_01200_svs1_enemyspotted_42", "vox_cp_amrk_01200_svs1_callforbackup_9a", "vox_cp_amrk_01200_svs1_anintruder_5d"];
    wait 1;
    self hms_util::dialogue(array::random(var_2878dc27));
    wait 0.5;
  } else {
    wait 2;
  }

  level flag::set("flg_motor_pool_enemies_notice_player");
}