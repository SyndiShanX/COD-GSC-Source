/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_trials.gsc
***********************************************/

#include script_23c01b321e642c31;
#include script_28bfe6df1650ab79;
#include script_30ba61ad5559c51d;
#include script_43642da1b2402e5c;
#include script_6951ea86fdae9ae0;
#include script_6f5e741b2bceba3a;
#include script_ddbbb750404a64b;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\zm\ai\zm_ai_avogadro;
#include scripts\zm\zm_white_mee;
#include scripts\zm\zm_white_special_rounds;
#include scripts\zm\zm_white_toast;
#include scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#include scripts\zm_common\trials\zm_trial_acquire_weapon;
#include scripts\zm_common\trials\zm_trial_defend_area;
#include scripts\zm_common\trials\zm_trial_flag_check;
#include scripts\zm_common\trials\zm_trial_restrict_loadout;
#include scripts\zm_common\trials\zm_trial_special_enemy;
#include scripts\zm_common\trials\zm_trial_upgrade_multiple;
#include scripts\zm_common\trials\zm_trial_white_electric_slide;
#include scripts\zm_common\trials\zm_trial_white_eyes_open;
#include scripts\zm_common\trials\zm_trial_white_mannequin_american;
#include scripts\zm_common\trials\zm_trial_white_minutemen;
#include scripts\zm_common\trials\zm_trial_white_mobile_plan;
#include scripts\zm_common\trials\zm_trial_white_nukerun;
#include scripts\zm_common\trials\zm_trial_white_population_control;
#include scripts\zm_common\zm_powerups;

#namespace zm_white_trials;

main() {
  level endon(#"end_game");
  level.var_4182b94e = struct::get_array("initial_spawn_points", "targetname");
  level flag::init(#"hash_18775b013e93e516");
  var_50f6b3f4 = getent("counter_tens", "targetname");
  var_50f6b3f4.start_angles = var_50f6b3f4.angles;
  var_d02e9cd = getent("counter_ones", "targetname");
  var_d02e9cd.start_angles = var_d02e9cd.angles;
  level.var_b691023c = 0;

  while(true) {
    if(isDefined(level.var_dc22f98)) {
      level.fn_custom_round_ai_spawn = level.var_dc22f98;
      level.var_dc22f98 = undefined;
    }

    if(level.round_number > 1) {
      level.var_b691023c = undefined;
    }

    level waittill(#"hash_5d42d8ee7a08b543");

    switch (level.round_number) {
      case 1:
        level thread function_1a2500e5();
        break;
      case 15:
        level thread function_439b486f();
        break;
      case 21:
        level thread head_hunter();
        break;
      case 30:
        level thread function_e478fb2a();
        level.var_dc22f98 = level.fn_custom_round_ai_spawn;
        level.fn_custom_round_ai_spawn = &function_1bc491ab;
        level thread spawn_boss();
        break;
    }

    level waittill(#"hash_7646638df88a3656");

    if(isDefined(level.e_avogadro)) {
      level.e_avogadro kill();
    }

    if(level flag::get(#"hash_639e8274a1b57729") && !level flag::get(#"hash_40856b65dff0f6eb") && level flag::get("round_reset")) {
      level zm_white_special_rounds::function_6acd363d(0);
    }
  }
}

function_1a2500e5() {
  level.var_806abe8f = level.var_f44e37f7;
  level.var_f44e37f7 = &function_c4d44a1b;

  foreach(player in getplayers()) {
    player thread teleport_player();
  }

  wait 0.5;
  level.var_f44e37f7 = level.var_806abe8f;
}

function_c4d44a1b(a_s_respawn_points) {
  n_script_int = self getentitynumber();
  s_point = level.var_4182b94e[n_script_int];
  return s_point;
}

teleport_player() {
  if(isalive(self) && self.zone_name != "zone_security_checkpoint") {
    if(self isusingoffhand()) {
      self forceoffhandend();
    }

    self zm_bgb_anywhere_but_here::activation(0);
  }
}

function_439b486f() {
  if(!level flag::get(#"hash_18775b013e93e516")) {
    level flag::set(#"hash_18775b013e93e516");
    exploder::exploder("fxexp_disco_lgt");
    var_51bef3af = spawn("script_model", (1, 1145, -350));
    var_51bef3af playSound(#"hash_c8d3a1557c42ab7");
    s_notify = level waittilltimeout(253, #"hash_7646638df88a3656");
    var_51bef3af stopsound(#"hash_c8d3a1557c42ab7");
    waitframe(1);
    var_51bef3af delete();
    exploder::stop_exploder("fxexp_disco_lgt");
    level flag::clear(#"hash_18775b013e93e516");
  }
}

head_hunter() {
  level flag::set(#"hash_502f2e83a538c679");
  level.a_mees = getEntArray("dummy", "targetname");
  level.var_561ae1f8 = level.a_mees.size;

  if(level.a_mees.size <= 0) {
    return;
  }

  foreach(m in level.a_mees) {
    if(isDefined(m)) {
      m thread zm_white_mee::function_edcadf04();
    }
  }
}

function_1bc491ab() {
  s_spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
  ai = zombie_utility::spawn_zombie(getEntArray("mannequin_zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);

  if(isDefined(ai)) {
    ai.health = int(ai.health * 2);
    level.zombie_total--;
    n_delay = isDefined(zombie_utility::get_zombie_var(#"zombie_spawn_delay")) ? zombie_utility::get_zombie_var(#"zombie_spawn_delay") : zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
    wait n_delay;
    return true;
  }

  return false;
}

spawn_boss() {
  level endon(#"end_game", #"hash_7646638df88a3656");
  exploder::exploder("fxexp_pyramid_open");
  var_1c91a56e = struct::get("apd_door_scene", "targetname");
  level waittill(#"zombie_total_set");
  n_threshold = level.total_zombies_killed - level.zombie_total_subtract + level.zombie_total;
  s_notify = level waittill(#"hash_715188521b564b16");
  var_1c91a56e scene::play("open");
  zm_white_toast::spawn_boss();

  if(isDefined(level.e_avogadro)) {
    level.e_avogadro thread spawn_done(n_threshold);
  }
}

function_e478fb2a() {
  var_1c91a56e = struct::get("apd_door_scene", "targetname");
  var_1c91a56e thread scene::play_from_time("close", undefined, undefined, 1, 1);
  exploder::exploder_stop("fxexp_pyramid_open");
  exploder::exploder_stop("fxexp_pyramid_capture");
}

spawn_done(n_threshold) {
  level endon(#"hash_7646638df88a3656");
  waitframe(1);

  if(isDefined(level.e_avogadro)) {
    self waittill(#"new_scripted_anim");
    self notify(#"intro_done");
    self zm_ai_avogadro::function_ed39491e(1);
  }

  while(n_threshold > level.total_zombies_killed - level.zombie_total_subtract) {
    wait 0.1;
  }

  if(isDefined(level.e_avogadro)) {
    self zm_ai_avogadro::function_ed39491e(4);
    exploder::exploder("fxexp_pyramid_capture");
    level.vol_toast_trap = getent("vol_toast_trap", "targetname");

    while(isDefined(level.e_avogadro) && !level.e_avogadro istouching(level.vol_toast_trap)) {
      wait 0.1;
    }

    while(isDefined(level.e_avogadro)) {
      wait 0.1;
    }

    level thread zm_white_toast::function_3418b6f6();
  }
}