/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_523a88e0a98bed6f.gsc
***********************************************/

#using script_3b2905ec05ed796;
#using script_3dc93ca9902a9cda;
#using script_41e8adffbda93483;
#using script_4489198b8bcf36e8;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_c34cd176;

function function_25a6167c(str_objective) {
  exploder::exploder("lgt_exp_pre_nuke_ext_lights");
  namespace_534279a::spawn_allies("catacombs_start");
  level thread namespace_9e5ef376::function_b7e649c0(1);
  var_dbdb0082 = getEntArray("veh_courtyard_static", "targetname");
  array::run_all(var_dbdb0082, &val::set, #"hash_7d97d109d0838d04", "ignoreme", 1);
  var_fd4c649f = getent("aa_courtyard", "targetname");
  var_fd4c649f namespace_534279a::function_86201bb7();
}

function function_41e4735f(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    exploder::exploder("fxexp_env_fx_set_courtyard");
    objectives::set(#"cp_scripted", undefined, undefined, #"hash_7956ac3690b300bb", #"hash_74dd5a3afb4c014e");
  }

  namespace_95f223d5::music("3.0_catacombs");
  level thread hms_util::function_eaa0342e("catacombs_containment_warn", "catacombs_containment_fail");
  level.mason val::set(#"hash_427e34b7109385d2", "ignoreme", 1);
  level.woods val::set(#"hash_427e34b7109385d2", "ignoreme", 1);
  level thread function_861ceb4d(0);
  level thread function_9583a1e8();
  level thread function_5fc8eb8b();
  level thread function_b4aff85c();
  level thread function_7376de2a();
  level thread catacombs_adler_catchup();
  level thread function_116c72af();
  level.player namespace_534279a::function_a3c3a2b0();
  namespace_534279a::function_4f981a25("right_path_catacombs_juggernaut_group", 1, "flg_catacombs_complete");
  level flag::wait_till("flg_catacombs_complete");
  level thread skipto::function_4e3ab877("catacombs");
}

function function_fa1a97a3(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_116c72af() {
  level.adler ai::set_behavior_attribute("disablelean", 1);
  level namespace_604e2e22::scene_sge_5020_cat_stairway();
  level.adler notify(#"stop_going_to_node");
  level.adler thread spawner::go_to_struct(struct::get("s_catacomb_advance_3"));
  level.adler ai::set_behavior_attribute("disablelean", 0);
}

function function_7376de2a() {
  level endon(#"game_ended");
  level flag::wait_till("flg_catacombs_fx_event");
  exploder::exploder("fxexp_catacomb_tunnel_debris_falling");
  level.player playrumbleonentity("grenade_rumble");
  snd::client_msg("audio_catacombs_bomb_rumble");
}

function catacombs_adler_catchup() {
  level flag::wait_till("flg_catacombs_adler_catchup");
  var_fe52e195 = getent("catacombs_adler_catchup_volume", "targetname");

  if(!level.adler istouching(var_fe52e195)) {
    var_57d1bda8 = struct::get("catacombs_adler_catchup");
    level.adler teleport(var_57d1bda8.origin, var_57d1bda8.angles);
  }
}

function function_2cd9c163(params) {
  self endon(#"death");
  self endon(#"disconnected");
  var_2406aadb = getent("vol_catacombs_advance_5", "targetname");
  var_2406aadb trigger::use();
  self callback::remove_on_weapon_fired(&function_2cd9c163);
  self callback::remove_on_grenade_fired(&function_2cd9c163);
}

function function_861ceb4d(b_enabled) {
  var_c0d91128 = getent("catacomb_backtrack_door", "targetname");
  var_a1c2e28e = getent("catacomb_backtrack_door_collision", "targetname");

  if(!isDefined(b_enabled)) {
    b_enabled = 0;
  }

  if(b_enabled) {
    var_c0d91128 show();
    var_c0d91128 solid();
    var_c0d91128 disconnectpaths();
    var_a1c2e28e show();
    var_a1c2e28e solid();
    var_a1c2e28e disconnectpaths();
    return;
  }

  var_c0d91128 hide();
  var_c0d91128 notsolid();
  var_c0d91128 connectpaths();
  var_a1c2e28e hide();
  var_a1c2e28e notsolid();
  var_a1c2e28e connectpaths();
}

function function_5fc8eb8b() {
  level flag::wait_till("flg_catacombs_dialog_start");
  level.player hms_util::dialogue("vox_cp_seig_01800_hdsn_adlerthisishuds_38", 1);
  level.adler hms_util::dialogue("vox_cp_seig_01800_adlr_wegotoneaaclear_3b");
  level.player hms_util::dialogue("vox_cp_seig_01800_hdsn_youknowthatsnot_b4", 1);
  level.adler hms_util::dialogue("vox_cp_seig_01800_adlr_youdontthinkikn_a3");
  wait 0.4;
  level.adler hms_util::dialogue("vox_cp_seig_01800_adlr_justbereadytola_c7");
  level flag::wait_till("flg_catacomb_hallway_fallback");
}

function private function_b4aff85c() {
  level flag::wait_till("flg_obj_follow_adler");
  objectives::follow(#"obj_follow_adler", level.adler, undefined, 0, 0);
  level thread function_842a2f86();
  level flag::wait_till("flg_obj_catacomb_exit");
  objectives::remove(#"obj_follow_adler", level.adler);
  var_1bad8a77 = struct::get("catacomb_obj_exit");
  level flag::wait_till("flg_catacombs_juggernaut_entered");
  objectives::kill(#"hash_6a76199349df3e74", level.var_161f8862, #"hash_1198f1848ee374e7");
  level flag::wait_till("flg_catacomb_all_juggernauts_killed");
  objectives::complete(#"hash_6a76199349df3e74");
  objectives::follow(#"obj_follow_adler", level.adler, undefined, 0, 0);
}

function private function_9583a1e8() {
  level thread function_cf9cf841();
  level thread function_7867c8a3();
  level flag::wait_till("flg_right_path_drop_down");
  level.adler val::set(#"catacombs_start", "ignoreall", 1);
  var_1af5ef75 = spawner::get_ai_group_ai("right_path_catacomb_hallway_group");
  array::run_all(var_1af5ef75, &val::set, #"catacombs_start", "ignoreall", 1);
  a_ai = spawner::simple_spawn("catacomb_shotgunner");
  level flag::wait_till("flg_catacomb_advance_4");
  savegame::checkpoint_save();
  level flag::wait_till("flg_catacomb_contact");
  a_ai[0] val::set(#"hash_37d308b6e4cf5e98", "ignoreall", 1);
  level.adler val::reset(#"catacombs_start", "ignoreall");
  var_1af5ef75 = spawner::get_ai_group_ai("right_path_catacomb_hallway_group");
  array::run_all(var_1af5ef75, &val::reset, #"catacombs_start", "ignoreall");
  level.adler thread hms_util::dialogue("vox_cp_seig_01400_adlr_contact_ed");
  level thread function_95668a8c();
  namespace_534279a::function_4f981a25("right_path_catacomb_hallway_group", 1, "flg_catacomb_hallway_fallback");
  namespace_534279a::function_b5e4f3bc("right_path_catacomb_hallway_group", "right_path_catacombs_back_volume", "script_noteworthy");
  level flag::wait_till("flg_right_path_catacomb_stair_sighting");
  function_d044d1e1("ar", "vol_fallback_1_ar");
  wait 1.5;
  function_1eaaceab(a_ai);

  if(a_ai.size > 0 && isDefined(a_ai[0])) {
    a_ai[0] val::reset(#"hash_37d308b6e4cf5e98", "ignoreall");
  }

  array::thread_all(a_ai, &ai::force_goal, level.player);
  array::thread_all(a_ai, &ai::set_behavior_attribute, "demeanor", "cqb");

  foreach(ai in a_ai) {
    ai.grenadeammo = 0;
  }

  namespace_534279a::function_bd1a75b("right_path_catacomb_group", 2, "flg_catacombs_fallback_1");
  function_d044d1e1("ar", "vol_fallback_1_ar");
  namespace_534279a::function_bd1a75b("right_path_catacomb_group", 1, "flg_catacombs_fallback_2");
  function_d044d1e1("ar", "vol_fallback_2_ar");
  level flag::wait_till("flg_catacomb_first_juggernaut_killed");
  function_d044d1e1("shotgun", "right_path_catacombs_back_volume");
  function_d044d1e1("smg", "right_path_catacombs_back_volume");
  function_d044d1e1("ar", "right_path_catacombs_back_volume");
  savegame::checkpoint_save();
}

function private function_d044d1e1(var_14b6bdf, var_dab80c52) {
  a_ai = getaiarray(var_14b6bdf, "script_string");

  if(isDefined(a_ai)) {
    function_1eaaceab(a_ai);

    if(a_ai.size > 0) {
      vol_goal = getent(var_dab80c52, "targetname");
      array::thread_all(a_ai, &ai::force_goal, vol_goal);
    }
  }
}

function private function_95668a8c() {
  wait 2;
  level flag::set("flg_catacomb_hallway_fallback");
}

function private function_cf9cf841() {
  level endon(#"game_ended");
  level.player endon(#"death");
  level thread function_b12347a2();
  level flag::wait_till_any(["flg_catacomb_molotov_reveal", "flg_catacomb_jugg_spawn_failsafe"]);
  level thread function_861ceb4d(1);
  exploder::stop_exploder("fxexp_env_fx_set_courtyard");
  exploder::exploder("fxexp_env_fx_set_graveyard");
  exploder::exploder("fxexp_env_fx_set_graveyard_2");
  function_d044d1e1("ar", "vol_fallback_1_ar");
  level thread function_bb281e43();
  level flag::wait_till_timeout(2, "flg_catacomb_jugg_spawn_failsafe");
  level.var_161f8862 = spawner::simple_spawn("catacombs_juggernaut");
  var_973037b3 = struct::get("catacomb_juggernaut_tether_back");
  var_65a28c66 = struct::get("catacomb_juggernaut_tether_mid");
  wait 0.1;
  level.var_161f8862[0] thread function_7711f534(var_973037b3, "jugg_intro_complete");
  level flag::wait_till("flg_catacombs_juggernaut_entered");
  level.adler.canmelee = 0;

  if(isalive(level.var_161f8862[0])) {
    level.var_161f8862[0].favoriteenemy = level.player;
    level.var_161f8862[0] namespace_631d466b::function_6aedb63(var_65a28c66.origin, var_65a28c66.radius);
    level.var_161f8862[0] namespace_631d466b::function_90791fca(level.adler);
    var_47acec0 = getent("catacomb_door", "targetname");
    var_47acec0 movez(96 * -1, 0.5);
    snd::client_targetname(var_47acec0, "juggernaut_door_close");
    level thread function_22082c46();
    level thread function_7f9c110c(level.var_161f8862[0], var_973037b3);
    spawner::waittill_ai_group_amount_killed("right_path_catacombs_juggernaut_group", 1);
  } else {
    level flag::set("flg_catacombs_juggernaut_killed_early");
  }

  level flag::set("flg_catacomb_first_juggernaut_killed");
  level flag::set("flg_catacomb_all_juggernauts_killed");
  level.adler.canmelee = 1;
  level.adler thread function_69abda79();
  level thread function_d64774a5();

  if(!level flag::get("flg_catacombs_juggernaut_killed_early")) {
    wait 3.5;
    var_47acec0 movez(96, 2);
    snd::client_targetname(var_47acec0, "juggernaut_door_open");
    var_a861d028 = getent("catacomb_door_clip", "targetname");
    var_a861d028 notsolid();
  }

  function_d044d1e1("smg", "right_path_catacombs_far_back_volume");
  function_d044d1e1("ar", "right_path_catacombs_far_back_volume");
  level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_wegotmaybefivem_94");
  wait 0.5;
  level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_pickupthepace_c7");
}

function function_7f9c110c(var_f6ee0, var_3c2ac608) {
  while(isalive(var_f6ee0)) {
    var_11423a93 = var_f6ee0.health / var_f6ee0.maxhealth;

    if(var_11423a93 < 0.4) {
      var_f6ee0 namespace_631d466b::function_6aedb63(var_3c2ac608.origin, var_3c2ac608.radius);
      break;
    }

    wait 0.25;
  }
}

function function_d64774a5() {
  wait 0.5;
  spawner::simple_spawn("catacombs_juggernaut_support");
  ai = spawner::simple_spawn_single("catacombs_juggernaut_support_shotgunner");
  ai thread ai::force_goal(level.player);
  ai.grenadeammo = 0;
  ai.goalradius = 128;
  ai.favoriteenemy = level.player;
  wait 2;
  spawner::simple_spawn("catacombs_juggernaut_support_delay");
  spawner::waittill_ai_group_ai_count("right_path_catacomb_group", 1);
  namespace_534279a::function_b5e4f3bc("right_path_catacomb_group", "catacombs_exit_fallback", "script_noteworthy");
}

function function_b12347a2() {
  var_9717fa06 = getent("jugg_spawn", "targetname");
  level thread trigger::look_trigger(var_9717fa06);
  var_9717fa06 waittill(#"trigger_look");
  var_9717fa06 notify(#"death");
  level flag::set("flg_catacomb_molotov_reveal");
}

function private function_bb281e43() {
  var_372d4d9 = struct::get("catacomb_grenade_origin");
  var_ba9bc2d9 = util::spawn_model("tag_origin");
  var_f0dacf8a = getweapon(#"hash_34fa23e332e34886");
  w_grenade = var_ba9bc2d9 magicgrenadetype(var_f0dacf8a, var_372d4d9.origin, (0, 0, 0), 1);
  w_grenade.var_3791d005 = 0;
  var_ba9bc2d9 delete();
}

function private function_7711f534(var_477935fc, str_notify) {
  self.var_8ef7113a = 1;
  level thread function_e369720f(self);
  self namespace_631d466b::function_efd568bc(str_notify.origin, 32);
  level flag::set("flg_catacombs_juggernaut_entered");
}

function function_e369720f(var_fed62d00) {
  var_b853736f = getent("catacombs_juggernaut_entrance_trigger", "targetname");

  while(!level flag::get("flg_catacombs_juggernaut_entered")) {
    s_notify = var_b853736f waittill(#"trigger");

    if(s_notify.activator === var_fed62d00) {
      var_fed62d00 notify(#"goal");
      level flag::set("flg_catacombs_juggernaut_entered");
      level thread function_45fc7e20();
    }
  }
}

function private function_45fc7e20() {
  var_b4ce85e2 = getEntArray("t_catacombs_jugg_adler_movement", "targetname");
  array::thread_all(var_b4ce85e2, &function_59a85291);
  level.adler colors::function_4156cb7d("c", #"allies");
}

function private function_59a85291() {
  self endon(#"flg_catacomb_first_juggernaut_killed");
  level.var_161f8862[0] endon(#"death");
  v_goal = getent(self.target, "targetname");

  while(true) {
    self waittill(#"trigger");
    level.adler ai::force_goal(v_goal, 0, undefined, 0, 1);

    while(level.var_161f8862[0] istouching(self)) {
      waitframe(1);
    }
  }
}

function private function_22082c46() {
  wait 1;
  level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_shitihatetheseg_31");
  level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_takeemdownquick_f1");
  wait 15;

  if(!level flag::get("flg_catacomb_first_juggernaut_killed")) {
    level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_aimfortheheadai_84");
  }

  wait 15;

  if(!level flag::get("flg_catacomb_first_juggernaut_killed")) {
    level.adler hms_util::dialogue("vox_cp_seig_01400_adlr_finishhimwerelo_2a");
  }
}

function private function_69abda79() {
  level endon(#"game_ended");
  level.adler endon(#"death");

  if(isDefined(level.adler)) {
    var_ecd1d2eb = level.adler.script_accuracy;
    level.adler.script_accuracy = 0.9;
    level flag::wait_till("flg_catacombs_complete");
    level.adler.script_accuracy = var_ecd1d2eb;
  }
}

function function_7867c8a3() {
  level flag::wait_till("flg_graveyard_unignore");
  var_c3d060a6 = [];
  var_c3d060a6 = arraycombine(var_c3d060a6, spawner::get_ai_group_ai("right_path_catacomb_hallway_group"));
  var_c3d060a6 = arraycombine(var_c3d060a6, spawner::get_ai_group_ai("right_path_catacomb_group"));
  var_c3d060a6 = arraycombine(var_c3d060a6, spawner::get_ai_group_ai("right_path_catacombs_juggernaut_group"));
  array::run_all(var_c3d060a6, &deletedelay);
}

function function_fa8268b8() {
  a_ai = spawner::get_ai_group_ai("right_path_catacomb_group");

  foreach(ai in a_ai) {
    ai function_794e687();
  }

  spawner::add_spawn_function_ai_group("right_path_catacomb_group", &function_794e687);
}

function function_794e687() {
  self flashlight::function_32fb7a97("tag_flash");
  self flashlight::function_65e5c8c8(1);
}

function function_842a2f86() {
  var_ce25a17e = getplayers()[0];
  var_9499e890 = ["chapel", "st_nicholas_church_02", "west_wall_blockout", "bell_tower_complete", "church_back_tower_01", "west_wall_blockout", "interior_cathedral_01"];
  level thread function_b43558fa(var_ce25a17e, var_9499e890);
  level flag::wait_till("flg_catacomb_all_juggernauts_killed");
  var_ce25a17e districts::function_a7d79fcb("graveyard");
}

function private function_b43558fa(var_9621dba4, var_a90002e2) {
  level flag::wait_till("flg_district_on_inside_catacomb");

  foreach(ent in var_a90002e2) {
    var_9621dba4 districts::function_a7d79fcb(ent);
  }

  level flag::clear("flg_district_on_inside_catacomb");
  wait 0.8;
  level thread function_837a3813(var_9621dba4, var_a90002e2);
}

function private function_837a3813(var_22d3a57f, var_2ff2cc90) {
  level flag::wait_till("flg_district_off_inside_catacomb");

  foreach(ent in var_2ff2cc90) {
    var_22d3a57f districts::function_930f8c81(ent);
  }

  level flag::clear("flg_district_off_inside_catacomb");
  wait 0.8;
  level thread function_b43558fa(var_22d3a57f, var_2ff2cc90);
}