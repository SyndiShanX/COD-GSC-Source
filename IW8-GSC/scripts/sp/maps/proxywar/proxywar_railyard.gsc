/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar_railyard.gsc
**********************************************************/

function proxywar_railyard_precache() {
  precachemodel("burntbody_male");
}

function proxywar_railyard_flags() {
  scripts\engine\utility::flag_init("reached_tower_collapse");
  scripts\engine\utility::flag_init("cue_burning_guy");
  scripts\engine\utility::flag_init("cue_pistol_guy");
  scripts\engine\utility::flag_init("pistol_guy_firing");
  scripts\engine\utility::flag_init("pistol_guy_eliminated");
  scripts\engine\utility::flag_init("cue_crawling_guy");
  scripts\engine\utility::flag_init("cue_crawling_guy_death");
  scripts\engine\utility::flag_init("crawling_guy_idling");
  scripts\engine\utility::flag_init("crawling_guy_dead");
  scripts\engine\utility::flag_init("reached_breach");
  scripts\engine\utility::flag_init("alpha1_breach_ready");
  scripts\engine\utility::flag_init("alpha2_breach_ready");
  scripts\engine\utility::flag_init("breach_window_view");
  scripts\engine\utility::flag_init("animated_breach_started");
  scripts\engine\utility::flag_init("player_fired_at_breach");
  scripts\engine\utility::flag_init("player_looking_at_or_near_breach");
  scripts\engine\utility::flag_init("breach_door_open");
  scripts\engine\utility::flag_init("player_skipped_breach");
  scripts\engine\utility::flag_init("alpha1_breach_done");
  scripts\engine\utility::flag_init("alpha2_breach_done");
  scripts\engine\utility::flag_init("enemies_dead_breach_done");
  scripts\engine\utility::flag_init("player_near_combat_intro");
  scripts\engine\utility::flag_init("player_looking_at_combat_intro");
  scripts\engine\utility::flag_init("railyard_breach_vo_done");
  scripts\engine\utility::flag_init("hide_door_interact_combat_intro");
  scripts\engine\utility::flag_init("alpha1_railyard_enter_ready");
  scripts\engine\utility::flag_init("alpha2_railyard_enter_ready");
  scripts\engine\utility::flag_init("start_combat_intro_scene");
  scripts\engine\utility::flag_init("lmg_intro_done");
  scripts\engine\utility::flag_init("player_inside_intro_room");
  scripts\engine\utility::flag_init("cue_ally_suppression");
  scripts\engine\utility::flag_init("proxywar_lights_tower_collapse");
  scripts\engine\utility::flag_init("spawn_rus_railyard_start");
  scripts\engine\utility::flag_init("spawn_rus_railyard_right_traincar");
  scripts\engine\utility::flag_init("spawn_rus_railyard_right_traincar_surprise");
  scripts\engine\utility::flag_init("spawn_rus_railyard_right_room");
  scripts\engine\utility::flag_init("spawn_rus_railyard_left_start");
  scripts\engine\utility::flag_init("spawn_rus_railyard_left_traincars");
  scripts\engine\utility::flag_init("spawn_rus_railyard_mg_platform");
  scripts\engine\utility::flag_init("advance_to_start");
  scripts\engine\utility::flag_init("advance_to_right_traincar");
  scripts\engine\utility::flag_init("advance_to_right_traincar_surprise");
  scripts\engine\utility::flag_init("advance_to_right_room_1");
  scripts\engine\utility::flag_init("advance_to_right_room_2");
  scripts\engine\utility::flag_init("advance_to_right_room_3");
  scripts\engine\utility::flag_init("advance_to_left_platform");
  scripts\engine\utility::flag_init("advance_to_left_flatbed");
  scripts\engine\utility::flag_init("advance_to_left_traincars");
  scripts\engine\utility::flag_init("advance_to_mg_platform");
  scripts\engine\utility::flag_init("flanked_machine_gunner");
  scripts\engine\utility::flag_init("machine_gunner_notices_player");
  scripts\engine\utility::flag_init("machine_gunner_killed");
  scripts\engine\utility::flag_init("lmg_suppressed");
  scripts\engine\utility::flag_init("lmg_should_suppress");
  scripts\engine\utility::flag_init("lmg_suppressing_allies");
}

function proxywar_railyard_hints() {
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_toggle", &"PROXYWAR/TUT_MOUNT_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_sprint_toggle", &"PROXYWAR/TUT_MOUNT_SPRINT_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_hold_toggle", &"PROXYWAR/TUT_MOUNT_HOLD_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_double_toggle", &"PROXYWAR/TUT_MOUNT_DOUBLE_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint", &"PROXYWAR/TUT_MOUNT", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_sprint", &"PROXYWAR/TUT_MOUNT_SPRINT", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_hold", &"PROXYWAR/TUT_MOUNT_HOLD", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_double", &"PROXYWAR/TUT_MOUNT_DOUBLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_activate", &"PROXYWAR/TUT_MOUNT_ACTIVATE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_activate_toggle", &"PROXYWAR/TUT_MOUNT_ACTIVATE_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_binding", &"PROXYWAR/TUT_MOUNT_BINDING", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_mount_hint_binding_toggle", &"PROXYWAR/TUT_MOUNT_BINDING_TOGGLE", &check_mount);
  scripts\engine\sp\utility::add_hint_string("tut_alt_fire_hint", &"PROXYWAR/TUT_ALT_FIRE", &check_alt_fire);
  scripts\engine\sp\utility::add_hint_string("tut_alt_fire_hint_press", &"PROXYWAR/TUT_ALT_FIRE_PRESS", &check_alt_fire);
  scripts\engine\sp\utility::add_hint_string("tut_grenade_hint", &"PROXYWAR/TUT_GRENADE", &check_grenade);
}

function check_mount() {
  var0 = 0;

  if(isDefined(level.mount_tutorial_time) && level.player playermount() > 0.5) {
    var0 = 1;
  } else {
    level.mount_tutorial_time = gettime();
  }

  return var0 && scripts\engine\utility::time_has_passed(level.mount_tutorial_time, 2);
}

function check_alt_fire() {
  var0 = level.player getcurrentweapon();
  var1 = getweaponbasename(var0);
  return var1 == "iw8_ar_mike4" && !var0.isalternate;
}

function check_grenade() {
  return level.player_threw_grenade;
}

function proxywar_railyard_spawn_funcs() {
  scripts\engine\sp\utility::array_spawn_function_targetname("rus_breach_guys", &railyard_breach_enemy_individual);
  scripts\engine\sp\utility::array_spawn_function_targetname("rus_railyard_mg_platform", &railyard_combat_enemy_individual_platform);
}

function railyard_entrance_start() {
  scripts\sp\maps\proxywar\proxywar_util::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_railyard_entrance", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
}

function railyard_entrance_main() {
  level scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::transient_load_array, ["pw_trainyard_track_detail_tr", "pw_control_room_interior_tr", "pw_railyard_rear_detail_tr"]);
  scripts\engine\sp\utility::autosave_by_name("railyard_entrance");
  scripts\sp\maps\proxywar\proxywar_util::disable_allies_firing();

  foreach(var1 in level.alpha_and_bravo_team) {
    thread railyard_entrance_allies();
  }

  thread scripts\sp\maps\proxywar\proxywar_vo::vo_re_entrance_fire_damage();
  scripts\engine\utility::exploder("extinguisher_room");
  scripts\engine\utility::exploder("factory_ext_camcentr");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\utility::stop_exploder("aftermath_big_light");
  thread railyard_entrance_tower_collapse();
  thread railyard_entrance_burning_guy();
  thread railyard_entrance_pistol_guy();
  level.alpha1.scene_kill_target = ["rus_breach_guy_2", "rus_breach_guy_1"];
  level.alpha2.scene_kill_target = ["rus_re_crawling_guy", "rus_breach_guy_3"];
  scripts\engine\utility::flag_wait("pistol_guy_eliminated");
  scripts\engine\utility::flag_set("cue_crawling_guy");
  scripts\engine\utility::flag_wait("reached_breach");
}

function railyard_entrance_allies() {
  self notify("stop_previous_logic");
  self endon("stop_previous_logic");
  thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
  scripts\asm\shared\utility::toggle_poiauto(1);

  if(istrue(self.arrived_at_patrol_exit)) {
    wait randomfloatrange(0.3, 0.5);
  }

  thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_enter_" + self.script_noteworthy);
  scripts\engine\utility::flag_wait("cue_burning_guy");

  if(scripts\engine\utility::array_contains(level.alpha_team, self)) {
    scripts\common\ai::set_gunpose("disable");
    scripts\asm\shared\utility::toggle_poiauto(0);
    waitframe();
    scripts\sp\maps\proxywar\proxywar_util::enable_ally_vision();
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_firing();
  }

  thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
  thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_pistol_" + self.script_noteworthy);
  scripts\engine\utility::flag_wait_or_timeout("cue_pistol_guy", 3);

  if(!scripts\engine\utility::flag("cue_pistol_guy") && scripts\engine\utility::array_contains(level.alpha_team, self)) {
    scripts\asm\shared\utility::toggle_poiauto(1);
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_vision();
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_firing();
  }

  scripts\engine\utility::flag_wait("cue_pistol_guy");

  if(scripts\engine\utility::array_contains(level.alpha_team, self)) {
    scripts\asm\shared\utility::toggle_poiauto(0);
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_vision();
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_firing();
    scripts\common\ai::set_gunpose("disable");
    thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
    thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_pistol_react_" + self.script_noteworthy);
    scripts\engine\utility::flag_wait_any("pistol_guy_firing", "pistol_guy_eliminated");
    scripts\sp\maps\proxywar\proxywar_util::enable_ally_vision();

    if(self.script_noteworthy == "alpha1") {
      if(!scripts\engine\utility::flag("pistol_guy_eliminated")) {
        thread scripts\sp\maps\proxywar\proxywar_util::ally_track_and_kill_noteworthy("pistol_guy", "eliminate_pistol_guy");
        scripts\engine\utility::flag_wait_or_timeout("pistol_guy_eliminated", 6);
        level notify("eliminate_pistol_guy");
      }
    }
  }

  if(self.script_noteworthy == "alpha1") {
    scripts\engine\utility::flag_wait("pistol_guy_eliminated");
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_firing();
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_vision();
    scripts\asm\shared\utility::toggle_poiauto(1);
    scripts\engine\utility::flag_wait("cue_crawling_guy");
    thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
    thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_crawling_" + self.script_noteworthy);
    return;
  }

  if(self.script_noteworthy == "alpha2") {
    scripts\engine\utility::flag_wait("cue_crawling_guy");
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_firing();
    scripts\sp\maps\proxywar\proxywar_util::disable_ally_vision();
    scripts\asm\shared\utility::toggle_poiauto(1);
    thread railyard_entrance_crawling_guy_alpha2();
    return;
  }

  scripts\engine\utility::flag_wait("pistol_guy_eliminated");
  scripts\engine\utility::flag_wait("crawling_guy_dead");
  thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
  thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_crawling_" + self.script_noteworthy);
}

function railyard_entrance_tower_collapse() {
  scripts\engine\utility::flag_wait("reached_tower_collapse");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_re_tower_collapse();
  thread scripts\engine\utility::play_sound_in_space("scn_proxywar_guard_tower_collapse", (2917, 70, 330));
  getEnt("proxywar_tower_before", "targetname") delete();
  showmayhem("vfx_mayh_proxywar_tower");
  playmayhem("vfx_mayh_proxywar_tower");
  scripts\engine\utility::exploder("towerfire");
  scripts\engine\utility::stop_exploder("towerfire_start");
  wait 4;
  thread scripts\sp\maps\proxywar\proxywar_lighting::lights_on("proxywar_lights_tower_collapse");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.3, 3, level.player.origin, 400);
  scripts\engine\utility::flag_set("proxywar_lights_tower_collapse");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_4", "targetname").origin);
}

function railyard_entrance_setup_burned_rus(var0) {
  self.health = 1;
  self.diequietly = 1;
  scripts\sp\utility::context_melee_allow(0);
  self.dontmelee = 1;
  self.dontmeleeme = 1;
  self.dontsyncmelee = 1;
  self.attackeraccuracy = 0;
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.allowdeath = 1;

  if(istrue(var0)) {
    scripts\common\ai::gun_remove();
    return;
  }
}

function railyard_entrance_burning_guy() {
  scripts\engine\utility::flag_wait("reached_tower_collapse");
  wait 4;
  scripts\engine\utility::flag_wait("cue_burning_guy");
  var0 = scripts\engine\sp\utility::spawn_targetname("rus_re_burning_guy", 1);
  var0.animname = "burning_guy";
  railyard_entrance_setup_burned_rus(var0, 1);
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_re_entrance_burner(var0);
  var1 = scripts\engine\utility::getStruct("ap_burning_guy", "targetname");
  var1 thread scripts\common\anim::anim_single_solo(var0, "burning_guy_death");
  var0 scripts\engine\utility::delaythread(4, &scripts\engine\sp\utility::set_ignoreme, 1);
  var2 = scripts\engine\utility::waittill_any_ents_return(var0, "damage", var1, "burning_guy_death");

  if(isalive(var0)) {
    if(var2 == "burning_guy_death") {
      var0.noragdoll = 1;
    }

    var0 scripts\engine\sp\utility::die();
    return;
  }
}

function railyard_entrance_pistol_guy() {
  scripts\engine\utility::flag_wait("cue_pistol_guy");
  var0 = scripts\engine\sp\utility::spawn_targetname("rus_re_pistol_guy", 1);
  var0.script_noteworthy = "pistol_guy";
  var0.animname = "pistol_guy";
  thread railyard_entrance_setup_burned_rus(var0);
  var0.sidearm = var0.weapon;
  var1 = scripts\engine\utility::getStruct("ap_pistol_guy", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "back_crawl_fire");
  var2 = 0;

  while(!var2) {
    if(scripts\engine\utility::flag("cue_crawling_guy")) {
      var2 = 1;
    } else if(scripts\sp\maps\proxywar\proxywar_util::within_player_fov(var0.origin)) {
      if(level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), var0, level.alpha_and_bravo_team, scripts\engine\trace::create_ainosight_contents())) {
        var2 = 1;
      }
    }

    waitframe();
  }

  thread railyard_entrance_pistol_guy_burning_fx();
  scripts\engine\utility::flag_set("pistol_guy_firing");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_re_pistol_burner(var0);

  if(isalive(var0)) {
    var0 thread scripts\common\anim::anim_single_solo(var0, "back_crawl_fire");

    if(isalive(var0)) {
      var0 waittill("death");
    }
  }

  scripts\engine\utility::flag_set("pistol_guy_eliminated");
}

function railyard_entrance_pistol_guy_burning_fx() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_body_02"), self, "j_mainroot");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_shoulder_ri");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_shoulder_le");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_01"), self, "j_hip_ri");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_01"), self, "j_hip_le");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_elbow_ri");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_elbow_le");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_knee_ri");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_burning_limbs_02"), self, "j_knee_le");
}

function railyard_entrance_crawling_guy() {
  scripts\engine\utility::flag_wait("cue_crawling_guy");
  wait 1.5;
  var0 = scripts\engine\sp\utility::spawn_targetname("rus_re_crawling_guy", 1);
  var0.animname = "crawling_guy";
  var0.script_noteworthy = "rus_re_crawling_guy";
  railyard_entrance_setup_burned_rus(var0, 1);
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_re_crawling_burner(var0);
  var1 = scripts\engine\utility::getStruct("ap_crawling_guy", "targetname");
  var1 scripts\common\anim::anim_single_solo(var0, "crawling_guy_enter");

  if(isalive(var0)) {
    var1 thread scripts\common\anim::anim_loop_solo(var0, "crawling_guy_idle", "stop_loop_crawler");
  }

  scripts\engine\utility::flag_set("crawling_guy_idling");
  scripts\engine\utility::flag_wait("cue_crawling_guy_death");

  if(isalive(var0)) {
    var1 notify("stop_loop_crawler");
    var1 scripts\common\anim::anim_single_solo(var0, "crawling_guy_kill");
  }

  if(isalive(var0)) {
    var0.noragdoll = 1;
    var0 scripts\engine\sp\utility::die();
  }

  scripts\engine\utility::flag_set("crawling_guy_dead");
}

function railyard_entrance_crawling_guy_alpha2() {
  if(!scripts\engine\utility::flag("reached_breach")) {
    thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
    thread scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_crawling_" + self.script_noteworthy);
    return;
  }
}

function railyard_entrance_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_4", "targetname").origin);
  getEnt("proxywar_tower_before", "targetname") delete();
  showmayhem("vfx_mayh_proxywar_tower");
  playmayhem("vfx_mayh_proxywar_tower");

  if(!scripts\sp\starts::is_after_start("railyard_combat_intro")) {
    scripts\engine\utility::exploder("towerfire");
    return;
  }
}

function railyard_breach_start() {
  scripts\sp\maps\proxywar\proxywar_util::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_railyard_breach", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
  level.alpha1.scene_kill_target = ["rus_breach_guy_2", "rus_breach_guy_1"];
  level.alpha2.scene_kill_target = ["rus_breach_guy_3"];
  scripts\engine\utility::exploder("extinguisher_room");
}

function railyard_breach_main() {
  scripts\engine\sp\utility::autosave_by_name("railyard_breach");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\utility::stop_exploder("aftermath_big_light");
  thread audio_railyard_fires();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_breach_room", "targetname").origin);
  level.ap_breach = scripts\engine\utility::getStruct("ap_breach", "targetname");
  var0 = scripts\engine\sp\utility::array_spawn_targetname("rus_breach_guys", 1);
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rb_ru_breach_guys();
  scripts\engine\utility::array_thread(level.alpha_team, &railyard_breach_ally_alpha);
  scripts\engine\utility::array_thread(level.bravo_team, &railyard_breach_ally_bravo);
  thread railyard_breach_door_open_checker();
  thread railyard_breach_player_fire_checker();
  thread railyard_breach_player_flashlight_checker(var0);
  thread railyard_breach_player_looking_at_breach();
  thread railyard_player_near_breach();
  thread railyard_breach_breach_door();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rb_reached_breach();
  thread scripts\sp\maps\proxywar\proxywar_vo::mus_railyard_combat();
  scripts\engine\utility::flag_wait_any("alpha1_breach_ready", "breach_door_open", "player_fired_at_breach");
  scripts\engine\utility::flag_wait_any("alpha2_breach_ready", "breach_door_open", "player_fired_at_breach");
  scripts\engine\utility::flag_wait_any("player_fired_at_breach", "breach_door_open", "player_looking_at_or_near_breach");

  if(railyard_player_skipped_breach()) {
    scripts\engine\utility::flag_set("player_skipped_breach");
    thread railyard_breach_check_deaths(var0);
    thread scripts\sp\maps\proxywar\proxywar_vo::vo_rb_breaching();
    scripts\engine\utility::flag_wait("enemies_dead_breach_done");
    return;
  }

  scripts\engine\utility::flag_set("animated_breach_started");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rb_breaching();
  scripts\engine\utility::flag_wait_any("alpha1_breach_done", "alpha2_breach_done");
}

function railyard_breach_check_deaths(var0) {
  scripts\engine\sp\utility::waittill_dead_or_dying(var0);
  scripts\engine\utility::flag_set("enemies_dead_breach_done");
}

function railyard_breach_ally_alpha() {
  self notify("stop_previous_logic");
  level endon("player_skipped_breach");
  scripts\asm\shared\utility::toggle_poiauto(0);
  thread railyard_breach_skip_ally_alpha();
  scripts\common\ai::set_gunpose("disable");
  scripts\common\ai::disable_arrivals();
  self enableavoidance(0, 0);
  thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
  thread railyard_breach_ally_alpha_speed();
  scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_breach_approach_" + self.script_noteworthy);
  scripts\engine\utility::set_movement_speed(56);
  level.ap_breach scripts\sp\anim::anim_reach_solo(self, "breach_enter");
  self.og_anglelerprate = self.anglelerprate;
  self.anglelerprate = 180;
  level.ap_breach scripts\common\anim::anim_single_solo(self, "breach_enter");
  self.anglelerprate = self.og_anglelerprate;
  self.og_anglelerprate = undefined;
  scripts\common\ai::enable_arrivals();
  self enableavoidance(1, 1);

  if(self.script_noteworthy == "alpha1") {
    var0 = ["dx_vom_h71_railyard_breach_armory_10", "dx_vom_h71_railyard_breach_armory_20", "dx_vom_h71_railyard_breach_armory_30"];
    level.alpha1 childthread scripts\sp\maps\proxywar\proxywar_vo::nagtill_delayed(12, "animated_breach_started", var0, 15);
  }

  level.ap_breach thread scripts\common\anim::anim_loop_solo(self, "breach_idle", "stop_loop_" + self.script_noteworthy);
  scripts\engine\utility::flag_set(self.script_noteworthy + "_breach_ready");
  scripts\engine\utility::flag_wait("animated_breach_started");
  scripts\common\ai::set_gunpose("automatic");
  level.ap_breach notify("stop_loop_" + self.script_noteworthy);
  level.ap_breach scripts\common\anim::anim_single_solo(self, "breach_room");
  scripts\engine\utility::flag_set(self.script_noteworthy + "_breach_done");
}

function railyard_breach_ally_alpha_speed() {
  wait 0.1;
  scripts\engine\utility::waittill_any("subgoal", "goal");
  scripts\engine\utility::set_movement_speed(56);
}

function railyard_breach_skip_ally_alpha() {
  level endon("animated_breach_started");
  scripts\engine\utility::flag_wait("player_skipped_breach");
  scripts\common\ai::set_gunpose("automatic");
  level.ap_breach notify("stop_loop_" + self.script_noteworthy);
  self stopanimScripted();
  thread scripts\sp\maps\proxywar\proxywar_util::go_to_node_targetname("railyard_breach_" + self.script_noteworthy);
  scripts\common\utility::clear_movement_speed();
  scripts\common\ai::enable_arrivals();
  self enableavoidance(1, 1);
  scripts\sp\maps\proxywar\proxywar_util::enable_ally_vision();
  scripts\sp\maps\proxywar\proxywar_util::enable_ally_firing();

  if(isDefined(self.og_anglelerprate)) {
    self.anglelerprate = self.og_anglelerprate;
    self.og_anglelerprate = undefined;
    return;
  }
}

function railyard_player_skipped_breach() {
  return scripts\engine\utility::flag("breach_door_open") || scripts\engine\utility::flag("player_fired_at_breach") && (!scripts\engine\utility::flag("alpha1_breach_ready") || !scripts\engine\utility::flag("alpha2_breach_ready"));
}

function railyard_breach_ally_bravo() {
  self notify("stop_previous_logic");
  self endon("stop_previous_logic");
  scripts\asm\shared\utility::toggle_poiauto(0);
  thread scripts\sp\maps\proxywar\proxywar_util::set_ally_movement_pre_breach(1);
  scripts\sp\maps\proxywar\proxywar_util::go_to_targetname("railyard_breach_" + self.script_noteworthy);
  scripts\common\utility::clear_movement_speed();
  scripts\engine\utility::flag_wait("player_skipped_breach");
  scripts\sp\maps\proxywar\proxywar_util::enable_ally_vision();
  scripts\sp\maps\proxywar\proxywar_util::enable_ally_firing();
}

function railyard_breach_breach_door() {
  level endon("player_skipped_breach");
  var0 = scripts\sp\door::get_interactive_door("breach_door");
  scripts\engine\utility::flag_wait("alpha2_breach_ready");
  var0 scripts\sp\door::remove_open_ability();
  scripts\engine\utility::flag_wait("animated_breach_started");
  scripts\engine\utility::flag_set("breach_door_open");
  level.ap_breach scripts\sp\maps\proxywar\proxywar_util::anim_door(var0, "breach_room");
}

function railyard_breach_door_open_checker() {
  level endon("animated_breach_started");
  var0 = scripts\sp\door::get_interactive_door("breach_door");
  var1 = 15;
  var2 = angleclamp180(var0.angles[1]);

  while(angleclamp180(var0.angles[1] - var2) < var1) {
    waitframe();
  }

  scripts\engine\utility::flag_set("breach_door_open");
}

function railyard_breach_player_fire_checker() {
  level endon("animated_breach_started");
  level endon("player_fired_at_breach");
  var0 = scripts\engine\utility::getStruct("player_vision_check", "targetname").origin;
  var1 = 0;

  while(!var1) {
    level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
    var1 = level.player scripts\engine\trace::can_see_origin(var0);
    waitframe();
  }

  scripts\engine\utility::flag_set("player_fired_at_breach");
}

function railyard_breach_player_flashlight_checker(var0) {
  level endon("animated_breach_started");
  level endon("player_fired_at_breach");

  while(!scripts\engine\utility::flag("player_fired_at_breach")) {
    foreach(var2 in var0) {
      if(scripts\sp\maps\proxywar\proxywar_util::player_shining_light_at(var2, 300)) {
        scripts\engine\utility::flag_set("player_fired_at_breach");
        break;
      }
    }

    waitframe();
  }
}

function railyard_breach_player_looking_at_breach() {
  level endon("animated_breach_started");
  level endon("player_skipped_breach");
  scripts\engine\utility::flag_wait_all("alpha1_breach_ready", "alpha2_breach_ready");
  var0 = scripts\engine\utility::getStruct("player_vision_check", "targetname").origin;
  var1 = 0;

  if(!isDefined(level.breach_trigger_time)) {
    level.breach_trigger_time = 0;
  }

  while(level.breach_trigger_time < 6) {
    if(scripts\engine\utility::flag("breach_window_view")) {
      var1 = level.player scripts\engine\trace::can_see_origin(var0);

      if(var1) {
        level.breach_trigger_time += 0.05;
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("player_looking_at_or_near_breach");
}

function railyard_player_near_breach() {
  level endon("animated_breach_started");
  level endon("player_skipped_breach");
  scripts\engine\utility::flag_wait_all("alpha1_breach_ready", "alpha2_breach_ready");

  if(!isDefined(level.breach_trigger_time)) {
    level.breach_trigger_time = 0;
  }

  while(level.breach_trigger_time < 1) {
    if(scripts\sp\maps\proxywar\proxywar_util::within_distance2d(level.ap_breach.origin, level.player.origin, 400)) {
      level.breach_trigger_time += 0.05;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("player_looking_at_or_near_breach");
}

function railyard_breach_enemy_individual() {
  thread railyard_breach_stop_fx_on_death();
  self endon("death");
  level endon("player_skipped_breach");
  self.ignoreall = 1;
  self.diequietly = 1;
  self.health = 1;
  self.animname = self.script_noteworthy;
  self.allowdeath = 1;
  thread railyard_breach_skip_enemy();

  if(!scripts\engine\utility::flag("animated_breach_started")) {
    if(self.script_noteworthy == "rus_breach_guy_1") {
      self attach(scripts\engine\sp\utility::getmodel("extinguisher"), "tag_accessory_right", 1);
      thread railyard_breach_extinguisher_start_fx();
    }

    level.ap_breach thread scripts\sp\maps\proxywar\proxywar_util::anim_single_solo_end_notify("anim_done", self, "breach_enter");
    scripts\engine\utility::waittill_any_ents(self, "anim_done", level, "animated_breach_started");
  }

  if(!scripts\engine\utility::flag("animated_breach_started")) {
    level.ap_breach thread scripts\common\anim::anim_loop_solo(self, "breach_idle", "stop_loop_" + self.script_noteworthy);
  }

  scripts\engine\utility::flag_wait("animated_breach_started");

  if(self.script_noteworthy == "rus_breach_guy_1") {
    thread railyard_breach_extinguisher_stop_fx();
  }

  level.ap_breach notify("stop_loop_" + self.script_noteworthy);
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  scripts\sp\utility::context_melee_allow(0);
  level.ap_breach scripts\common\anim::anim_single_solo(self, "breach_room");
  self.a.nodeath = 1;
  self.noragdoll = 1;
  scripts\engine\sp\utility::die();
}

function railyard_breach_extinguisher_start_fx() {
  wait 2;

  if(isalive(self)) {
    self.extinguisher_fx = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_accessory_right"), self gettagangles("tag_accessory_right"));
    self.extinguisher_fx linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_fire_extinguisher"), self.extinguisher_fx, "tag_origin");
    self.extinguisher_fx playSound("scn_proxywar_yard_fire_extinguisher");
    wait 0.2;
    scripts\engine\utility::exploder("extinguisher_room_groundfx");
    return;
  }
}

function railyard_breach_extinguisher_stop_fx() {
  if(isDefined(self.extinguisher_fx)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_fire_extinguisher"), self.extinguisher_fx, "tag_origin");
    self.extinguisher_fx thread scripts\engine\sp\utility::sound_fade_and_delete(0.3);
    scripts\engine\utility::stop_exploder("extinguisher_room_groundfx");
    return;
  }
}

function railyard_breach_stop_fx_on_death() {
  self waittill("death");
  thread railyard_breach_extinguisher_stop_fx();
}

function railyard_breach_skip_enemy() {
  self endon("death");
  level endon("animated_breach_started");
  scripts\engine\utility::flag_wait("player_skipped_breach");

  if(self.script_noteworthy == "rus_breach_guy_1") {
    thread railyard_breach_extinguisher_stop_fx();
    self detach(scripts\engine\sp\utility::getmodel("extinguisher"), "tag_accessory_right");
  }

  level.ap_breach notify("stop_loop_" + self.script_noteworthy);
  self stopanimScripted();
  self.ignoreall = 0;
}

function railyard_breach_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_breach_room", "targetname").origin);
  scripts\engine\utility::flag_set("alpha1_breach_done");
  scripts\engine\utility::flag_set("alpha2_breach_done");
  scripts\engine\utility::flag_set("railyard_breach_vo_done");
  thread audio_railyard_fires();
}

function audio_railyard_fires() {
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_silo", (-895, -730, 576));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_boxcar", (1382, 1423, 409));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_metal_lp_02", (682, 582, 411));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_metal_lp_01", (1235, -335, 404));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_metal_lp_01", (485, -89, 501));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_small_warehouse_drip", (-1843, -206, 517));
}

function railyard_combat_intro_start() {
  scripts\sp\maps\proxywar\proxywar_util::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_railyard_combat_intro", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
}

function railyard_combat_intro_main() {
  scripts\engine\sp\utility::autosave_by_name("railyard_combat_intro");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\utility::stop_exploder("aftermath_big_light");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_enter_railyard", "targetname").origin);
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rci_rus_radio_trans();
  level.ap_combat_intro = scripts\engine\utility::getStruct("ap_combat_intro", "targetname");
  level.bravo1.script_pushable = 0;
  level.bravo1 pushplayer(1);
  level.bravo1.disableplayeradsloscheck = 1;
  level.bravo2.script_pushable = 0;
  level.bravo2 pushplayer(1);
  level.bravo2.disableplayeradsloscheck = 1;
  level.bravo3.script_pushable = 0;
  level.bravo3 pushplayer(1);
  level.bravo3.disableplayeradsloscheck = 1;
  level.bravo1 scripts\engine\utility::set_movement_speed(randomintrange(60, 80));
  level.bravo2 scripts\engine\utility::set_movement_speed(randomintrange(60, 80));
  level.bravo3 scripts\engine\utility::set_movement_speed(randomintrange(60, 80));
  level.bravo1 scripts\engine\utility::delaythread(2, &scripts\sp\maps\proxywar\proxywar_util::go_to_targetname, "railyard_combat_intro_bravo1");
  level.bravo2 scripts\engine\utility::delaythread(4, &scripts\sp\maps\proxywar\proxywar_util::go_to_targetname, "railyard_combat_intro_bravo2");
  level.bravo3 scripts\engine\utility::delaythread(6, &scripts\sp\maps\proxywar\proxywar_util::go_to_targetname, "railyard_combat_intro_bravo3");
  thread railyard_combat_intro_door();
  thread railyard_combat_intro_lmg();
  thread railyard_combat_intro_alpha2();
  thread railyard_combat_intro_alpha1();
  scripts\engine\utility::flag_wait("start_combat_intro_scene");
  scripts\engine\utility::flag_set("player_inside_intro_room");
}

function railyard_combat_intro_door() {
  var0 = scripts\sp\door::get_interactive_door("breach_door_exit_left");
  var1 = scripts\sp\door::get_interactive_door("breach_door_exit_right");
  var1 scripts\sp\door::remove_open_ability();
  thread railyard_combat_intro_player_looking(var0, var1);
  thread railyard_combat_intro_check_player_tries_door();
  scripts\engine\utility::flag_wait("hide_door_interact_combat_intro");
  var0 scripts\sp\door::remove_open_ability();
  scripts\engine\utility::flag_wait_all("alpha1_railyard_enter_ready", "alpha2_railyard_enter_ready", "player_near_combat_intro", "player_looking_at_combat_intro");
  scripts\engine\utility::exploder("wp_explo_aftermath_02");
  level.ap_combat_intro thread scripts\sp\maps\proxywar\proxywar_util::anim_door(var0, "combat_intro_halligan_door_l");
  level.ap_combat_intro scripts\sp\maps\proxywar\proxywar_util::anim_door(var1, "combat_intro_halligan_door_r");
  level.ap_combat_intro thread scripts\sp\maps\proxywar\proxywar_util::anim_door(var0, "combat_intro_scene_door_l");
  level.ap_combat_intro scripts\sp\maps\proxywar\proxywar_util::anim_door(var1, "combat_intro_scene_door_r");
}

function railyard_combat_intro_check_player_tries_door() {
  level endon("alpha1_railyard_enter_ready");
  self waittill("trigger");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rci_player_tries_door();
}

function railyard_combat_intro_player_looking(var0, var1) {
  while(!scripts\engine\utility::flag("alpha1_railyard_enter_ready") || !scripts\engine\utility::flag("alpha2_railyard_enter_ready") || !scripts\engine\utility::flag("player_near_combat_intro") || !scripts\engine\utility::flag("player_looking_at_combat_intro")) {
    if(scripts\sp\maps\proxywar\proxywar_util::within_player_fov_2d(var0.origin) || scripts\sp\maps\proxywar\proxywar_util::within_player_fov_2d(var1.origin)) {
      scripts\engine\utility::flag_set("player_looking_at_combat_intro");
    } else {
      scripts\engine\utility::flag_clear("player_looking_at_combat_intro");
    }

    waitframe();
  }
}

function railyard_combat_intro_alpha1() {
  if(scripts\engine\utility::flag("player_skipped_breach")) {
    scripts\engine\utility::set_movement_speed(90);
    self.disableplayeradsloscheck = 1;
    wait 1;
    self enableavoidance(0, 0);
    level.ap_combat_intro scripts\sp\anim::anim_reach_solo(self, "combat_intro_enter");
  } else {
    level.scr_goaltime["alpha1"]["combat_intro_enter"] = 0;
    scripts\engine\utility::flag_wait("alpha1_breach_done");
  }

  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_enter");
  self enableavoidance(1, 1);
  self.disableplayeradsloscheck = 0;
  scripts\engine\utility::flag_set("alpha1_railyard_enter_ready");

  if(!scripts\engine\utility::flag("alpha2_railyard_enter_ready") || !scripts\engine\utility::flag("player_near_combat_intro") || !scripts\engine\utility::flag("player_looking_at_combat_intro")) {
    level.ap_combat_intro thread scripts\common\anim::anim_loop_solo(self, "combat_intro_idle", "stop_loop_" + self.script_noteworthy);
  }

  scripts\engine\utility::flag_wait_all("alpha2_railyard_enter_ready", "player_near_combat_intro", "player_looking_at_combat_intro");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_combat_left_beginning");
  level.ap_combat_intro notify("stop_loop_" + self.script_noteworthy);
  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_halligan");
  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_scene");
}

function railyard_combat_intro_alpha2() {
  if(scripts\engine\utility::flag("player_skipped_breach")) {
    self.disableplayeradsloscheck = 1;
    self enableavoidance(0, 0);
    scripts\engine\utility::set_movement_speed(110);
    level.ap_combat_intro scripts\sp\anim::anim_reach_solo(self, "combat_intro_enter");
  } else {
    level.scr_goaltime["alpha2"]["combat_intro_enter"] = 0;
    scripts\engine\utility::flag_wait("alpha2_breach_done");
  }

  scripts\engine\utility::flag_set("hide_door_interact_combat_intro");
  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_enter");

  if(!scripts\engine\utility::flag("player_near_combat_intro")) {
    var0 = ["dx_vom_h71_railyard_breach_armory_230", "dx_vom_h71_railyard_breach_armory_240"];
    level.alpha1 thread scripts\sp\maps\proxywar\proxywar_vo::nagtill_delayed(6, "player_near_combat_intro", var0, 12);
  }

  scripts\engine\utility::flag_set("alpha2_railyard_enter_ready");

  if(!scripts\engine\utility::flag("alpha1_railyard_enter_ready") || !scripts\engine\utility::flag("player_near_combat_intro") || !scripts\engine\utility::flag("player_looking_at_combat_intro")) {
    level.ap_combat_intro thread scripts\common\anim::anim_loop_solo(self, "combat_intro_idle", "stop_loop_" + self.script_noteworthy);
  }

  scripts\engine\utility::flag_wait_all("alpha1_railyard_enter_ready", "player_near_combat_intro", "player_looking_at_combat_intro");
  level.ap_combat_intro notify("stop_loop_" + self.script_noteworthy);
  thread scripts\sp\maps\proxywar\proxywar_util::halligan_draw();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rci_mg_breach();
  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_halligan");
  thread scripts\sp\maps\proxywar\proxywar_util::halligan_stow();
  scripts\engine\utility::flag_set("start_combat_intro_scene");
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  level.ap_combat_intro scripts\common\anim::anim_single_solo(self, "combat_intro_scene");
  scripts\sp\maps\proxywar\proxywar_util::remove_ally(self);
  self.allowdeath = 1;
  scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\sp\utility::die();
}

function railyard_combat_intro_lmg() {
  scripts\engine\utility::flag_wait("start_combat_intro_scene");
  wait 4.9;
  railyard_combat_setup_lmg();
  var0 = level.alpha2 gettagorigin("j_spine4");
  level.railyard_lmg scripts\sp\maps\proxywar\proxywar_util::magic_gun_set_target(var0, 0);
  var1 = scripts\engine\utility::spawn_tag_origin(var0);
  var1 scripts\engine\sp\utility::assign_animtree("mg_target");
  level.railyard_lmg thread scripts\sp\maps\proxywar\proxywar_util::magic_gun_track_ent(var1);
  thread railyard_combat_intro_lmg_light(var0);
  wait 0.5;
  var2 = getEnt("combat_intro_player_blocker", "targetname");
  var2 scripts\engine\utility::delaycall(1, &delete);
  level.alpha2 scripts\engine\utility::delaycall(1, &visiblenotsolid);
  level.ap_combat_intro thread scripts\common\anim::anim_single_solo(var1, "combat_intro_scene");
  railyard_combat_lmg_fire(level.railyard_lmg, 100, 0.25);
  level.railyard_lmg thread scripts\sp\maps\proxywar\proxywar_util::magic_gun_stop_tracking();
  var1 delete();
  scripts\engine\utility::flag_set("lmg_intro_done");
}

function railyard_combat_intro_lmg_light(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  var1.angles = vectortoangles(vectorNormalize(var0 - level.railyard_lmg.og_origin));
  var1.origin = var0 + anglesToForward(var1.angles) * -1600;
  playFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_mg_searchlight_door"), var1, "tag_origin");
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_on", var1.origin);

  while(scripts\engine\utility::flag("player_inside_intro_room") && (!scripts\sp\maps\proxywar\proxywar_util::within_player_fov(var1.origin) || !scripts\engine\trace::ray_trace_passed(level.player getEye(), var1.origin, level.player, scripts\engine\trace::create_default_contents(1)))) {
    wait 0.1;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_mg_searchlight_door"), var1, "tag_origin");
  var1 delete();
}

function railyard_combat_intro_catchup() {
  scripts\engine\utility::exploder("wp_explo_aftermath_02");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_enter_railyard", "targetname").origin);
  thread railyard_combat_intro_door_catchup();
  var0 = getEnt("combat_intro_player_blocker", "targetname");
  var0 delete();
}

function railyard_combat_intro_door_catchup() {
  level.ap_combat_intro = scripts\engine\utility::getStruct("ap_combat_intro", "targetname");
  var0 = scripts\sp\door::get_interactive_door("breach_door_exit_left");
  var1 = scripts\sp\door::get_interactive_door("breach_door_exit_right");
  var0 scripts\sp\door::remove_open_ability();
  var1 scripts\sp\door::remove_open_ability();
  level.ap_combat_intro thread scripts\sp\maps\proxywar\proxywar_util::anim_last_frame_door(var0, "combat_intro_scene_door_l");
  level.ap_combat_intro thread scripts\sp\maps\proxywar\proxywar_util::anim_last_frame_door(var1, "combat_intro_scene_door_r");
}

function railyard_combat_start() {
  scripts\sp\maps\proxywar\proxywar_util::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_railyard_skirmish", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  railyard_combat_setup_lmg();
  scripts\engine\utility::flag_set("lmg_intro_done");
  scripts\engine\utility::flag_set("player_inside_intro_room");
  level.bravo1.script_pushable = 0;
  level.bravo1 pushplayer(1);
  level.bravo2.script_pushable = 0;
  level.bravo2 pushplayer(1);
  level.bravo3.script_pushable = 0;
  level.bravo3 pushplayer(1);
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_set_mg_suppress_goal();
}

function railyard_combat_main() {
  scripts\engine\sp\utility::autosave_by_name("railyard_combat");
  scripts\engine\utility::stop_exploder("big_smokes");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\utility::stop_exploder("aftermath_big_light");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_elminate_mg", "targetname").origin);
  scripts\sp\player::player_movement_state("default");
  thread railyard_combat_threat_think();
  thread railyard_combat_enemies();
  scripts\engine\utility::delaythread(7, &scripts\sp\maps\proxywar\proxywar_util::hint_mount);
  scripts\engine\utility::flag_wait("lmg_intro_done");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_set_mg_suppress_goal();
  thread railyard_vfx_fire_blocker();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_set_mg_goal();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_reminder();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_hint();
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_defeated();
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\sp\maps\proxywar\proxywar_util::enable_allies_firing();

  foreach(var1 in level.alpha_and_bravo_team) {
    var1 scripts\common\utility::clear_movement_speed();
    var1 scripts\engine\sp\utility::enable_ai_color();
    var1.disableplayeradsloscheck = 0;
  }

  thread railyard_combat_supressing_ally();
  thread railyard_combat_machine_gunner();
  thread railyard_combat_allies_left();
  thread railyard_combat_allies_right();
  scripts\engine\utility::flag_wait_any_timeout(20, "lmg_suppressed", "spawn_rus_railyard_start");

  if(!scripts\engine\utility::flag("lmg_suppressed")) {
    scripts\engine\utility::flag_set("cue_ally_suppression");
  }

  wait 10;
  level.bravo1.script_pushable = 1;
  level.bravo1 pushplayer(0);
  level.bravo1.disableplayeradsloscheck = 0;
  level.bravo2.script_pushable = 1;
  level.bravo2 pushplayer(0);
  level.bravo2.disableplayeradsloscheck = 0;
  level.bravo3.script_pushable = 1;
  level.bravo3 pushplayer(0);
  level.bravo3.disableplayeradsloscheck = 0;
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_suppress_reminder();
  scripts\engine\utility::flag_wait_any("machine_gunner_killed", "reached_courtyard_overlook");

  foreach(var1 in level.alpha_and_bravo_team) {
    var1 setthreatbiasgroup("allies");
  }

  level.bravo1.script_color_delay_override = undefined;
  level.bravo3.script_color_delay_override = undefined;
}

function railyard_combat_threat_think() {
  createthreatbiasgroup("axis_left");
  createthreatbiasgroup("axis_right");
  createthreatbiasgroup("allies_left");
  createthreatbiasgroup("allies_right");
  setignoremegroup("axis_left", "allies_right");
  setignoremegroup("axis_right", "allies_left");
  setignoremegroup("allies_left", "axis_right");
  setignoremegroup("allies_right", "axis_left");
  scripts\engine\utility::flag_wait("lmg_intro_done");
  var0 = 0;

  while(isDefined(level.railyard_lmg)) {
    var1 = anglestoright(level.railyard_lmg.og_angles + (0, -30, 0));
    var2 = scripts\engine\utility::flatten_vector(level.player.origin - level.railyard_lmg.og_origin);
    var3 = vectordot(var1, var2);

    if(!var0 && var3 > 0) {
      var0 = 1;
      setignoremegroup("player", "axis_right");
      setignoremegroup("axis_right", "player");
      setthreatbias("axis_left", "player", getthreatbias("axis", "player"));
      setthreatbias("player", "axis_left", getthreatbias("player", "axis"));
    } else if(var0 && var3 < 0) {
      var0 = 0;
      setignoremegroup("player", "axis_left");
      setignoremegroup("axis_left", "player");
      setthreatbias("axis_right", "player", getthreatbias("axis", "player"));
      setthreatbias("player", "axis_right", getthreatbias("player", "axis"));
    }

    waitframe();
  }

  setthreatbias("axis_left", "allies_left", getthreatbias("axis", "allies"));
  setthreatbias("allies_left", "axis_left", getthreatbias("allies", "axis"));
  setthreatbias("axis_right", "allies_right", getthreatbias("axis", "allies"));
  setthreatbias("allies_right", "axis_right", getthreatbias("allies", "axis"));
}

function railyard_combat_machine_gunner() {
  level endon("machine_gunner_killed");
  var0 = getEnt("mg_pickup", "targetname");
  var1 = getspawner("rus_railyard_mg", "targetname");
  thread railyard_combat_lmg();
  thread railyard_combat_mg_grenade_check(var1);
  scripts\engine\utility::flag_wait("flanked_machine_gunner");
  var1.count = 1;
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1);
  var2.disablepistol = 1;
  thread railyard_combat_machine_gunner_flag_on_death();
  thread railyard_combat_machine_gunner_lethal_on_bypass();
  thread railyard_combat_machine_gunner_attack_point();
  thread railyard_combat_machine_gunner_drop_weapon();
}

function railyard_combat_machine_gunner_flag_on_death() {
  self endon("machine_gunner_killed");
  self waittill("death", var0, var1);

  if(scripts\engine\utility::is_equal(var1, "MOD_GRENADE") || scripts\engine\utility::is_equal(var1, "MOD_GRENADE_SPLASH")) {
    scripts\sp\utility::giveachievement_wrapper("fogfrag");
  }

  scripts\engine\utility::flag_set("machine_gunner_killed");
}

function railyard_combat_machine_gunner_drop_weapon() {
  var0 = createheadicon(self.weapon);
  var1 = scripts\engine\utility::waittill_any_return("death", "weapon_dropped");

  if(var1 == "death") {
    var2 = self.origin;
    var1 = scripts\engine\utility::waittill_notify_or_timeout_return("weapon_dropped", 0.5);

    if(var1 == "timeout") {
      var3 = spawn("weapon_" + var0, var2 + (0, 0, 30));
      return;
    }

    return;
  }
}

function railyard_combat_machine_gunner_attack_point() {
  level endon("machine_gunner_killed");
  scripts\sp\utility::aim_at(scripts\engine\utility::getStruct("mg_fake_aim_target", "targetname").origin);
  GscBinSkip4(0x35);
}

function railyard_combat_machine_gunner_check_damage() {
  level endon("machine_gunner_notices_player");
  self waittill("damage");
  scripts\engine\utility::flag_set("machine_gunner_notices_player");
}

function railyard_combat_machine_gunner_check_player_near() {
  level endon("machine_gunner_notices_player");

  while(!scripts\sp\maps\proxywar\proxywar_util::within_distance(level.player.origin, self.origin, 200)) {
    waitframe();
  }

  scripts\engine\utility::flag_set("machine_gunner_notices_player");
}

function railyard_combat_machine_gunner_check_player_staring() {
  level endon("machine_gunner_notices_player");

  while(!scripts\sp\maps\proxywar\proxywar_util::within_distance(level.player.origin, self.origin, 230)) {
    waitframe();
  }

  wait 6;

  while(!(scripts\sp\maps\proxywar\proxywar_util::within_player_fov(self.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), self))) {
    waitframe();
  }

  scripts\engine\utility::flag_set("machine_gunner_notices_player");
}

function railyard_combat_machine_gunner_lethal_on_bypass() {
  self endon("death");
  scripts\engine\utility::flag_wait("reached_courtyard_overlook");
  scripts\engine\utility::flag_set("machine_gunner_notices_player");
  self setgoalentity(level.player);
  self.goalradius = 50;
  self.baseaccuracy = 1000;
  var0 = 0;

  while(var0 < 5) {
    var1 = level.player getEye();
    var2 = var1 + vectorNormalize(self gettagorigin("tag_flash") - var1) * 300;
    magicbullet("iw8_lm_pkilo", var2, var1, self);

    if(var0 == 4) {
      level.player scripts\engine\sp\utility::die();
    }

    var0++;
    wait randomfloatrange(0.1, 0.15);
  }
}

function railyard_combat_mg_grenade_check(var0) {
  while(!scripts\engine\utility::flag("machine_gunner_killed")) {
    level.player waittill("grenade_fire", var1, var2);

    if(var2.basename == "frag") {
      var1 waittill("explode", var3);

      if(ispointinvolume(var3, getEnt("mg_grenade_success", "targetname"))) {
        thread railyard_combat_mg_nest_destruction_fx();

        if(!scripts\engine\utility::flag("flanked_machine_gunner")) {
          var0.count = 1;
          var4 = var0 scripts\engine\sp\utility::spawn_ai(1);
          var4.diequietly = 1;
          var4 scripts\engine\sp\utility::die();
          scripts\sp\utility::giveachievement_wrapper("fogfrag");
          scripts\engine\utility::flag_set("machine_gunner_killed");
        }
      }
    }
  }
}

function railyard_combat_mg_nest_destruction_fx() {
  var0 = getEnt("lmg_destruction", "targetname");
  var0 setscriptablepartstate("base", "dead");
}

function railyard_combat_setup_lmg() {
  var0 = scripts\engine\utility::getStruct("lmg_railyard", "targetname");
  level.railyard_lmg = scripts\sp\maps\proxywar\proxywar_util::magic_gun_create_weapon("railyard_lmg", var0.origin, var0.angles, 200, 80, 50);
  var1 = scripts\engine\utility::spawn_tag_origin(level.railyard_lmg gettagorigin("tag_flash"), level.railyard_lmg gettagangles("tag_flash"));
  var1 linkTo(level.railyard_lmg, "tag_flash", (0, 0, 2), (0, 0, 0));
  level.railyard_lmg.light = var1;
  railyard_lmg_turn_on_light();
}

function railyard_lmg_turn_on_light() {
  level.railyard_lmg.light.on = 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_lmg_light"), level.railyard_lmg.light, "tag_origin");
}

function railyard_lmg_turn_off_light() {
  level.railyard_lmg.light.on = 0;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_lmg_light"), level.railyard_lmg.light, "tag_origin");
}

function railyard_combat_lmg() {
  level.railyard_lmg thread scripts\sp\maps\proxywar\proxywar_util::magic_gun_set_target(scripts\engine\utility::getStruct("mg_room_suppress", "targetname").origin, 0);
  thread railyard_combat_lmg_check_can_see_player();
  thread railyard_combat_lmg_check_being_suppressed();
  level.railyard_lmg.behavior = "none";

  while(!scripts\engine\utility::flag("flanked_machine_gunner") && !scripts\engine\utility::flag("machine_gunner_killed")) {
    if(!scripts\engine\utility::flag("advance_to_start") && level.railyard_lmg.behavior != "suppressing_door" && !scripts\engine\utility::flag("lmg_suppressed") && !level.railyard_lmg.can_see_player && scripts\engine\utility::time_has_passed(level.railyard_lmg.vis_changed_time, 3)) {
      if(!level.railyard_lmg.light.on) {
        railyard_lmg_turn_on_light();
      }

      thread railyard_combat_lmg_suppress_door_behavior();
    } else if(level.railyard_lmg.behavior != "tracking" && !scripts\engine\utility::flag("lmg_suppressed") && !scripts\engine\utility::flag("lmg_suppressing_allies") && (level.railyard_lmg.can_see_player && scripts\engine\utility::time_has_passed(level.railyard_lmg.vis_changed_time, 0.5) || !scripts\engine\utility::flag("advance_to_start") && !scripts\engine\utility::flag("player_inside_intro_room"))) {
      if(!level.railyard_lmg.light.on) {
        railyard_lmg_turn_on_light();
      }

      thread railyard_combat_lmg_track_player_behavior();
    } else if(scripts\engine\utility::flag("advance_to_start") && level.railyard_lmg.behavior != "searching" && !scripts\engine\utility::flag("lmg_suppressed") && !level.railyard_lmg.can_see_player && scripts\engine\utility::time_has_passed(level.railyard_lmg.vis_changed_time, 3)) {
      if(!level.railyard_lmg.light.on) {
        railyard_lmg_turn_on_light();
      }

      thread railyard_combat_lmg_search_behavior();
    } else if(level.railyard_lmg.behavior != "suppressed" && scripts\engine\utility::flag("lmg_should_suppress")) {
      if(level.railyard_lmg.light.on) {
        railyard_lmg_turn_off_light();
      }

      thread railyard_combat_lmg_suppressed_behavior();
    }

    waitframe();
  }

  railyard_lmg_turn_off_light();
  level.railyard_lmg.light delete();
  level.railyard_lmg scripts\sp\maps\proxywar\proxywar_util::magic_gun_delete();
}

function railyard_combat_lmg_suppress_door_behavior() {
  self endon("kill_magic_gun");
  self notify("stop_behaviors");
  self endon("stop_behaviors");
  self.behavior = "suppressing_door";
  var0 = scripts\engine\utility::getStruct("mg_room_suppress", "targetname");

  if(!isDefined(var0.ent)) {
    var0.left_dir = anglestoleft(var0.angles);
    var0.left_bound = var0.left_dir * 200 + var0.origin;
    var0.right_bound = var0.left_dir * -200 + var0.origin;
    var0.ent = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
    var0.ent thread scripts\sp\maps\proxywar\proxywar_util::delete_on_ent_notify(self, "kill_magic_gun");
  }

  var0.ent.origin = var0.origin;
  childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_set_tracking_speed(200);
  childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_track_ent(var0.ent);
  var1 = 0;
  var2 = 0;
  var3 = 6;

  for(;;) {
    if(scripts\engine\utility::time_has_passed(var1, var3)) {
      if(var2) {
        var0.ent moveTo(var0.right_bound, var3);
      } else {
        var0.ent moveTo(var0.left_bound, var3);
      }

      var1 = gettime();
      var2 = !var2;
    }

    railyard_combat_lmg_fire(level.railyard_lmg);
    waitframe();
  }
}

function railyard_combat_lmg_track_player_behavior() {
  self endon("kill_magic_gun");
  self notify("stop_behaviors");
  self endon("stop_behaviors");
  self.behavior = "tracking";
  childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_set_tracking_speed(200);
  childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_track_ent(level.player, undefined, 1);
  var0 = cos(5);

  for(;;) {
    if(scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), level.player getEye(), var0)) {
      if(!scripts\engine\utility::flag("advance_to_start") && !scripts\engine\utility::flag("player_inside_intro_room")) {
        railyard_combat_lmg_fire(level.railyard_lmg, 25, 0.9);
      } else {
        railyard_combat_lmg_fire(level.railyard_lmg);
      }
    }

    waitframe();
  }
}

function railyard_combat_lmg_search_behavior() {
  self endon("kill_magic_gun");
  self notify("stop_behaviors");
  self endon("stop_behaviors");
  self.behavior = "searching";
  var0 = scripts\engine\utility::getStruct("mg_room_suppress", "targetname");

  if(!isDefined(var0.ent)) {
    var0.ent = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
    var0.ent thread scripts\sp\maps\proxywar\proxywar_util::delete_on_ent_notify(self, "kill_magic_gun");
  }

  var0.ent.lmg_zero = scripts\engine\sp\utility::set_z(level.railyard_lmg.og_origin, 0);
  var0.ent.lmg_to_door = var0.origin - var0.ent.lmg_zero;
  var0.ent.origin = var0.ent.lmg_zero + var0.ent.lmg_to_door / 2;
  var0.ent.origin = scripts\engine\sp\utility::set_z(var0.ent.origin, 300);
  childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_set_tracking_speed(150);
  var1 = cos(5);

  for(;;) {
    childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_search_around_ent(var0.ent, 600);
    wait 3;
    scripts\engine\utility::flag_clear("lmg_suppressing_allies");
    wait 15;

    foreach(var3 in getaiarray("allies")) {
      if(scripts\engine\math::within_fov_2d(self.origin, self.angles, var3.origin, var1) && !scripts\engine\utility::can_trace_to_ai(self gettagorigin("tag_flash"), var3)) {
        scripts\engine\utility::flag_set("lmg_suppressing_allies");
        scripts\sp\maps\proxywar\proxywar_util::magic_gun_stop_search_around();
        childthread scripts\sp\maps\proxywar\proxywar_util::magic_gun_track_ent(var3, undefined, 1);

        for(var4 = 0; var4 < randomintrange(3, 6); var4++) {
          railyard_combat_lmg_fire();
        }

        scripts\sp\maps\proxywar\proxywar_util::magic_gun_stop_tracking();
        var3 notify("unsuppress_ally");
        break;
      }
    }
  }
}

function railyard_combat_lmg_suppress_ally() {
  self.dontevershoot = 1;
  self.ignoreall = 1;
  level.railyard_lmg scripts\engine\utility::waittill_any("stop_behaviors", "unsuppress_ally");
  self.dontevershoot = 0;
  self.ignoreall = 0;
}

function railyard_combat_lmg_suppressed_behavior() {
  self endon("kill_magic_gun");
  self notify("stop_behaviors");
  self endon("stop_behaviors");
  self.behavior = "suppressed";
  scripts\engine\utility::flag_set("lmg_suppressed");
  thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_suppressed();
  scripts\sp\maps\proxywar\proxywar_util::magic_gun_clear_target();
  wait 10;
  scripts\engine\utility::flag_clear("lmg_suppressed");
}

function railyard_combat_lmg_fire(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 30;
  }

  scripts\sp\maps\proxywar\proxywar_util::magic_gun_fire(10, 20, var0, 0.1, 0.15, 1.5, 2.5, var1);
}

function railyard_combat_lmg_check_can_see_player() {
  self endon("kill_magic_gun");
  self.can_see_player = 0;
  self.vis_changed_time = 0;

  for(;;) {
    var0 = self.can_see_player;
    var1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 1);
    var2 = level.player getEye();
    var3 = level.railyard_lmg.og_angles;
    var4 = scripts\sp\maps\proxywar\proxywar_util::within_bounds(level.railyard_lmg.og_origin, anglesToForward(var3), var2, level.railyard_lmg.max_angle_horiz, anglestoup(var3));
    var5 = scripts\sp\maps\proxywar\proxywar_util::within_bounds(level.railyard_lmg.og_origin, anglesToForward(var3), var2, level.railyard_lmg.max_angle_vert, anglestoleft(var3));

    if(var4 && var5) {
      self.can_see_player = scripts\engine\trace::ray_trace_passed(level.railyard_lmg gettagorigin("tag_flash"), var2, self, var1);
    } else {
      self.can_see_player = 0;
    }

    if(var0 != self.can_see_player) {
      self.vis_changed_time = gettime();
    }

    waitframe();
  }
}

function railyard_combat_lmg_check_being_suppressed() {
  self endon("kill_magic_gun");
  var0 = getEnt("mg_suppression_hit", "targetname");

  for(;;) {
    var0 waittill("trigger");
    scripts\engine\utility::flag_set("lmg_should_suppress");
    scripts\engine\utility::flag_wait("lmg_suppressed");
    scripts\engine\utility::flag_clear("lmg_should_suppress");
    scripts\engine\utility::flag_waitopen("lmg_suppressed");
    wait 3;
  }
}

function railyard_combat_supressing_ally() {
  level.railyard_lmg endon("kill_magic_gun");
  scripts\engine\utility::flag_wait_any("cue_ally_suppression", "lmg_suppressed");

  if(!scripts\engine\utility::flag("lmg_suppressed")) {
    var0 = level.railyard_lmg.og_origin + anglesToForward(level.railyard_lmg.og_angles) * 15;
    scripts\sp\utility::aim_at(var0, undefined, undefined, 0.5);
  }

  scripts\engine\utility::flag_wait("lmg_suppressed");
  wait 0.5;
  scripts\engine\utility::flag_set("advance_to_start");
  wait 0.5;
  scripts\sp\utility::stop_aiming();
}

function railyard_combat_allies_left() {
  level endon("machine_gunner_killed");
  level endon("reached_courtyard_overlook");
  level.alpha1 setthreatbiasgroup("allies_left");
  level.bravo1 setthreatbiasgroup("allies_left");
  level.bravo1.script_color_delay_override = 0.75;
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_combat_left_beginning");
  scripts\engine\utility::flag_wait("advance_to_start");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_start");
  railyard_combat_wait_dead_pct("rus_railyard_start", 1);
  scripts\engine\utility::flag_set("spawn_rus_railyard_right_traincar");
  scripts\engine\utility::flag_wait("advance_to_left_platform");
  scripts\engine\utility::flag_set("advance_to_right_traincar");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_platform");
  railyard_combat_wait_dead_pct("rus_railyard_left_start", 1);
  scripts\engine\utility::flag_wait("advance_to_left_flatbed");
  scripts\engine\utility::flag_set("advance_to_right_room_3");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_flatbed");
  railyard_combat_wait_dead_pct("rus_railyard_left_traincars", 0.5);
  scripts\engine\utility::flag_wait_any("advance_to_left_traincars", "advance_to_mg_platform");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_traincars");
  railyard_combat_wait_dead_pct("rus_railyard_left_traincars", 1);
  scripts\engine\utility::flag_wait("advance_to_mg_platform");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_mg_platform");
  railyard_combat_wait_dead_pct("rus_railyard_mg_platform", 1);
  scripts\engine\utility::flag_wait("flanked_machine_gunner");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_left_mg_platform_overrun");
}

function railyard_combat_allies_right() {
  level endon("machine_gunner_killed");
  level endon("reached_courtyard_overlook");
  level.bravo2 setthreatbiasgroup("allies_right");
  level.bravo3 setthreatbiasgroup("allies_right");
  level.bravo3.script_color_delay_override = 0.75;
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_combat_right_beginning");
  scripts\engine\utility::flag_wait("advance_to_start");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_start");
  railyard_combat_wait_dead_pct("rus_railyard_start", 1);
  scripts\engine\utility::flag_wait("advance_to_right_traincar");
  scripts\engine\utility::flag_set("advance_to_left_platform");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_traincar");
  railyard_combat_wait_dead_pct("rus_railyard_right_traincar", 1);
  scripts\engine\utility::flag_wait_any("advance_to_right_traincar_surprise", "advance_to_right_room_1", "advance_to_right_room_3");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_traincar_surprise");
  scripts\engine\utility::flag_wait_any("advance_to_right_room_1", "advance_to_right_room_2", "advance_to_right_room_3");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_room_1");
  railyard_combat_wait_dead_pct("rus_railyard_right_room", 0.33);
  scripts\engine\utility::flag_wait_any("advance_to_right_room_2", "advance_to_right_room_3");
  scripts\engine\utility::flag_set("advance_to_left_flatbed");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_room_2");
  railyard_combat_wait_dead_pct("rus_railyard_right_room", 0.66);
  scripts\engine\utility::flag_wait("advance_to_right_room_3");
  scripts\engine\utility::flag_set("advance_to_left_traincars");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_room_3");
  railyard_combat_wait_dead_pct("rus_railyard_right_room", 1);
  scripts\engine\utility::flag_wait("advance_to_mg_platform");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_mg_platform");
  scripts\engine\utility::flag_wait("flanked_machine_gunner");
  scripts\engine\sp\utility::activate_trigger_with_targetname("mar_railyard_right_mg_platform_overrun");
}

function railyard_combat_enemies() {
  level.railyard_enemies = [];
  thread railyard_combat_rus_railyard_start();
  thread railyard_combat_rus_railyard_right_traincar();
  thread railyard_combat_rus_railyard_right_traincar_surprise();
  thread railyard_combat_rus_railyard_right_room();
  thread railyard_combat_rus_railyard_left_start();
  thread railyard_combat_rus_railyard_left_traincars();
  thread railyard_combat_rus_railyard_mg_platform();
}

function railyard_combat_wait_dead_pct(var0, var1, var2) {
  while(!isDefined(level.railyard_enemies[var0])) {
    waitframe();
  }

  var3 = level.railyard_enemies[var0];
  var4 = 1;

  while(var4) {
    if(isDefined(var2)) {
      foreach(var6 in var2) {
        if(scripts\engine\utility::flag(var6)) {
          var4 = 0;
          break;
        }
      }
    }

    if(var4) {
      var8 = 0;

      foreach(var10 in var3) {
        if(!isalive(var10)) {
          var8++;
        }
      }

      var12 = var8 / var3.size;
      var4 = var12 < var1;
    }

    waitframe();
  }
}

function railyard_combat_enemy_individual_platform() {
  var0 = 0;

  if(isDefined(level.railyard_lmg)) {
    var1 = anglestoright(level.railyard_lmg.og_angles + (0, -30, 0));
    var2 = scripts\engine\utility::flatten_vector(level.player.origin - level.railyard_lmg.og_origin);
    var0 = vectordot(var1, var2);
  }

  if(var0 > 0) {
    self setgoalvolumeauto(getEnt("zn_rus_railyard_mg_platform_left", "targetname"));
    return;
  }

  self setgoalvolumeauto(getEnt("zn_rus_railyard_mg_platform_right", "targetname"));
}

function railyard_combat_enemy_individual(var0) {
  self endon("death");
  self setthreatbiasgroup(var0);
  thread railyard_combat_enemy_individual_player_near_check();

  for(;;) {
    self waittill("damage", var1, var2);

    if(var2 == level.player) {
      self setthreatbiasgroup("axis");
    }
  }
}

function railyard_combat_enemy_individual_player_near_check() {
  self endon("death");

  while(!scripts\sp\maps\proxywar\proxywar_util::within_distance(level.player.origin, self.origin, 200)) {
    wait 0.1;
  }

  self setthreatbiasgroup("axis");
}

function railyard_combat_rus_railyard_start() {
  scripts\engine\utility::flag_wait_any("advance_to_start", "spawn_rus_railyard_start");
  scripts\engine\utility::flag_wait_or_timeout("spawn_rus_railyard_start", 4);
  scripts\engine\sp\utility::autosave_by_name("railyard_combat_start");
  thread scripts\sp\maps\proxywar\proxywar_util::hint_alt_fire_swap(10);
  level.railyard_enemies["rus_railyard_start"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_right_start", 1);
  scripts\engine\utility::flag_wait_any("machine_gunner_killed", "reached_courtyard_overlook", "spawn_rus_railyard_right_traincar", "spawn_rus_railyard_left_start");

  foreach(var1 in level.railyard_enemies["rus_railyard_start"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_right_traincar() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_right_traincar");
  thread scripts\engine\utility::flag_set_delayed("spawn_rus_railyard_left_start", 20);
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_right_traincar");
  level.railyard_enemies["rus_railyard_right_traincar"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_right_traincar", 1);
  scripts\engine\utility::array_thread(level.railyard_enemies["rus_railyard_right_traincar"], &railyard_combat_enemy_individual, "axis_right");
  scripts\engine\utility::flag_wait_any("spawn_rus_railyard_right_room", "machine_gunner_killed", "spawn_rus_railyard_mg_platform");

  foreach(var1 in level.railyard_enemies["rus_railyard_right_traincar"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_right_traincar_surprise() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_right_traincar_surprise");
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_right_traincar_surprise");
  level.railyard_enemies["rus_railyard_right_traincar_surprise"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_right_traincar_surprise", 1);
  scripts\engine\utility::array_thread(level.railyard_enemies["rus_railyard_right_traincar_surprise"], &railyard_combat_enemy_individual, "axis_right");
  scripts\engine\utility::flag_wait_any("spawn_rus_railyard_right_room", "machine_gunner_killed", "spawn_rus_railyard_mg_platform");

  foreach(var1 in level.railyard_enemies["rus_railyard_right_traincar_surprise"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_right_room() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_right_room");
  scripts\engine\utility::flag_set("spawn_rus_railyard_left_traincars");
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_right_room");
  level.railyard_enemies["rus_railyard_right_room"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_right_room", 1);
  scripts\engine\utility::array_thread(level.railyard_enemies["rus_railyard_right_room"], &railyard_combat_enemy_individual, "axis_right");
  scripts\engine\utility::flag_wait_any("spawn_rus_railyard_mg_platform", "machine_gunner_killed");

  foreach(var1 in level.railyard_enemies["rus_railyard_right_room"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_left_start() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_left_start");
  scripts\engine\utility::flag_set("spawn_rus_railyard_right_traincar");
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_left_start");
  level.railyard_enemies["rus_railyard_left_start"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_left_start", 1);
  scripts\engine\utility::array_thread(level.railyard_enemies["rus_railyard_left_start"], &railyard_combat_enemy_individual, "axis_left");
  scripts\engine\utility::flag_wait_any("spawn_rus_railyard_left_traincars", "machine_gunner_killed", "spawn_rus_railyard_mg_platform");

  foreach(var1 in level.railyard_enemies["rus_railyard_left_start"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_left_traincars() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_left_traincars");
  scripts\engine\utility::flag_set("spawn_rus_railyard_right_room");
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_left_traincars");
  level.railyard_enemies["rus_railyard_left_traincars"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_left_traincars", 1);
  scripts\engine\utility::array_thread(level.railyard_enemies["rus_railyard_left_traincars"], &railyard_combat_enemy_individual, "axis_left");
  scripts\engine\utility::flag_wait_any("machine_gunner_killed", "spawn_rus_railyard_mg_platform");

  foreach(var1 in level.railyard_enemies["rus_railyard_left_traincars"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_combat_rus_railyard_mg_platform() {
  scripts\engine\utility::flag_wait("spawn_rus_railyard_mg_platform");
  thread scripts\sp\maps\proxywar\proxywar_util::hint_grenade_throw();
  scripts\engine\sp\utility::autosave_by_name("combat_rus_railyard_mg_platform");
  level.railyard_enemies["rus_railyard_mg_platform"] = scripts\engine\sp\utility::array_spawn_targetname("rus_railyard_mg_platform", 1);
  scripts\engine\utility::flag_wait_any("reached_courtyard_start", "reached_courtyard_overlook");

  foreach(var1 in level.railyard_enemies["rus_railyard_mg_platform"]) {
    if(isalive(var1)) {
      var1 thread scripts\sp\maps\proxywar\proxywar_util::die_when_offscreen_and_distant();
    }
  }
}

function railyard_vfx_fire_blocker() {
  scripts\engine\utility::flag_wait_any("spawn_rus_railyard_right_traincar", "spawn_rus_railyard_left_traincars");
  scripts\engine\utility::flag_waitopen("player_inside_intro_room");
  scripts\engine\utility::exploder("building_01_block");
  scripts\engine\utility::stop_exploder("towerfire");
  scripts\engine\utility::exploder("end_amb_fx");
  scripts\engine\utility::stop_exploder("wp_explo_aftermath_forest");
  var0 = scripts\sp\door::get_interactive_door("breach_door");
  var0 scripts\sp\door::door_close();
  var0 scripts\sp\door::remove_open_ability();
  var1 = getEnt("railyard_fire_blocker", "targetname");
  var1.origin += (0, 0, 150);
  scripts\engine\sp\utility::transient_unload("pw_trainyard_front_detail_tr");
  scripts\engine\sp\utility::transient_load_array(["pw_courtyard_top_detail_tr", "pw_courtyard_detail_tr", "pw_rearyard_detail_tr"]);
  hidemayhem("vfx_mayh_proxywar_tower");
}

function railyard_combat_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_elminate_mg", "targetname").origin);
  scripts\engine\utility::flag_set("spawn_rus_railyard_right_traincar");
  scripts\engine\utility::flag_set("spawn_rus_railyard_left_traincars");
  thread railyard_vfx_fire_blocker();
  scripts\engine\utility::exploder("end_amb_fx");
  scripts\engine\utility::stop_exploder("wp_explo_aftermath_forest");
  scripts\engine\utility::stop_exploder("big_smokes");
}