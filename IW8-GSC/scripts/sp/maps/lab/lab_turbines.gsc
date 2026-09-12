/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_turbines.gsc
************************************************/

function turbines_preload() {
  precachemodel("hat_gasmask");
  precachemodel("prop_gasmask");
  precachemodel("prop_child_hadir_gas_mask");
  precachemodel("hat_hero_farah_sas_gasmask");
  precachemodel("accessory_wm_gas_mask_stow");
  precachemodel("electrical_cell_door_button_red");
  precacheshader("gasmask_overlay_delta2");
  precachemodel("offhand_vm_clacker_tactical_sp_cinematic");
  precachemodel("offhand_vm_clacker_tatical_sp_cinematic_destroyed");
  precachemodel("offhand_vm_clacker_tatical_sp_cinematic_destroyed_off");
  precachemodel("sign_emergency_exit_light_02");
  precachemodel("sign_emergency_exit_light_02_on_lab_right");
  precachemodel("sign_emergency_exit_light_02_on_lab_left");
  precachemodel("me_light_ceiling_fluorescent_tube");
  precachemodel("uk_industrial_light_01");
  precachemodel("lighting_fixtures_security_lamp_withcage_01_sm_lab_on");
  precachemodel("hat_sla_rebels_female_gasmask_1_1");
  precachemodel("hat_sla_rebels_female_gasmask_2_1");
  precachemodel("hat_sla_rebels_female_gasmask_3_1");
  precachemodel("hat_sla_rebels_female_gasmask_4_1");
  precachemodel("hat_sla_rebels_female_gasmask_5_1");
  precachemodel("hat_sla_rebels_female_gasmask_6_1");
  precachemodel("hat_sla_rebels_ar_gasmask_2_1");
  precachemodel("hat_sla_rebels_cqb_gasmask_2_1");
  precachemodel("hat_sla_rebels_lmg_gasmask_2_1");
  precachemodel("hat_sla_rebels_ar_gasmask");
  precachemodel("hat_sla_rebels_cqb_gasmask");
  precachemodel("hat_sla_rebels_lmg_gasmask");
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  scripts\engine\utility::flag_init("ambush1_start");
  scripts\engine\utility::flag_init("ambush_tele_lower");
  scripts\engine\utility::flag_init("ambush_tele_upper");
  scripts\engine\utility::flag_init("ambush_end");
  scripts\engine\utility::flag_init("dragons_breath_shot");
  scripts\engine\utility::flag_init("past_jugg_door");
  scripts\engine\utility::flag_init("door_guy_dead");
  scripts\engine\utility::flag_init("door_guy_started");
}

function turbines_postload() {
  thread init_cp_3_doors();
  turbines_level_vars();
  turbines_postspawns();
  scripts\engine\utility::flag_init("lab_entrance_allies");
  scripts\engine\utility::flag_init("open_lab_door");
  scripts\engine\utility::flag_init("price_waiting");
  scripts\engine\utility::flag_init("price_nag_stop");
  scripts\engine\utility::flag_init("guy_running_up_stairs");
  scripts\engine\utility::flag_init("van_guys_ready");
  scripts\engine\utility::flag_init("grab_charges");
  scripts\engine\utility::flag_init("t2_start");
  scripts\engine\utility::flag_init("t2_fallback1");
  scripts\engine\utility::flag_init("t2_fallback2");
  scripts\engine\utility::flag_init("fire_suppression_active");
  scripts\engine\utility::flag_init("lab_rebels_move");
  scripts\engine\utility::flag_init("jugg_started");
  scripts\engine\utility::flag_init("juggernaut_dead");
  scripts\engine\utility::flag_init("post_jugg_door");
  scripts\engine\utility::flag_init("state_change_busy");
  scripts\engine\sp\utility::add_hint_string("gl_hint", &"SCRIPT/LEARN_GRENADE_LAUNCHER", &is_using_gl);
  scripts\engine\sp\utility::add_hint_string("gl_hint_kbm", &"SCRIPT/LEARN_GRENADE_LAUNCHER_KBM", &is_using_gl);
  createthreatbiasgroup("juggernaut");
  setthreatbias("allies", "juggernaut", 8600);
  setthreatbias("player", "juggernaut", 9000);
  thread setup_van_lights();
}

function turbines_level_vars() {
  level.ambush["lower"] = [];
  level.ambush["upper"] = [];
  level.fs_systemactive = 0;
  level.blackout_delay = 0.8;
}

function turbines_postspawns() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("laser_guy", &scripts\sp\maps\lab\lab_util::ai_laser_always_on);
  scripts\engine\sp\utility::array_spawn_function_targetname("group1", &group1_guy_logic);
  scripts\engine\sp\utility::array_spawn_function_targetname("lab_civs", &lab_civs_logic);
  scripts\engine\sp\utility::array_spawn_function_targetname("ambush_2f", &ambush_2f_postspawn);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("ambush_tele_lower", &ambush_tele_lower_postspawn);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("ambush_tele_upper", &ambush_tele_upper_postspawn);
  scripts\engine\sp\utility::array_spawn_function_aigroup("turbine_end_guys", &t2_postspawn);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("t2_enemies", &ai_fire_suppression_postspawn);
}

function setup_van_lights() {
  var_0 = getEntArray("van_scene_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

function ambush_tele_lower_postspawn() {
  level.ambush["lower"][level.ambush["lower"].size] = self;
}

function ambush_tele_upper_postspawn() {
  level.ambush["upper"][level.ambush["upper"].size] = self;
}

function ambush_2f_postspawn() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread notify_if_player_can_see_me();
  thread notify_whizby_from_player();
  scripts\engine\utility::flag_wait("cp_2_scene_start");
  self.ignoreall = 0;
  self.ignoreme = 0;
}

function notify_whizby_from_player() {
  level endon("cp_2_scene_start");
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player)) {
      scripts\engine\utility::flag_set("cp_2_scene_start");
      break;
    }
  }
}

function notify_if_player_can_see_me() {
  level endon("cp_2_scene_start");
  self endon("death");
  var_0 = cos(12);

  while(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_0)) {
    waitframe();
  }

  scripts\engine\utility::flag_set("cp_2_scene_start");
}

function t2_postspawn() {
  self endon("death");
  scripts\engine\utility::flag_wait("t2_start");
  scripts\engine\utility::waittill_any_timeout(4, "goal", "goal_reached");
  self cleargoalvolume();
  self setgoalpos(self.origin);
  self setgoalvolumeauto(level.t2_manager["volume"]);
}

function group1_guy_logic() {
  self endon("death");
  var_0 = getnode(self.target, "targetname");
  teleport_ai_to_cover_node(var_0);
  var_1 = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 32;
  self.fixednode = 1;
  self.dropweapon = 0;
  self.damage_functions[self.damage_functions.size] = &group1_damage_func;

  if(isDefined(var_0.script_parameters)) {
    var_1 = float(var_0.script_parameters);
    wait var_1 - 0.15;
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
}

function teleport_ai_to_cover_node(var_0) {
  var_1 = var_0.angles;
  var_2 = var_0.origin;

  if(!issubstr(var_0.type, "Prone")) {
    if(issubstr(var_0.type, "Left")) {
      var_1 += (0, 90, 0);
    } else if(issubstr(var_0.type, "Right") || issubstr(var_0.type, "Cover Crouch") || issubstr(var_0.type, "Conceal") || issubstr(var_0.type, "Cover Stand")) {
      var_1 -= (0, 90, 0);
    }
  }

  self forceteleport(var_2, var_1);
  self usecovernode(var_0, 1);
  self setgoalnode(var_0);
}

function group1_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::flag("ambush1_start")) {
    self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &group1_damage_func);
  }

  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    scripts\engine\utility::flag_set("inside_lab");
    scripts\engine\utility::flag_set("ambush1_start");
    self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &group1_damage_func);
    return;
  }
}

function lab_entrance_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("dam_intro_outside_start", [level.farah, level.price, level.kyle, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5, level.player]);
  var_0 = getEnt("gl_intro_door", "script_noteworthy");
  thread lab_door_prompt();
}

function lab_entrance_main() {
  thread kill_the_window();

  if(istrue(level.onlydroneused)) {
    level thread scripts\sp\utility::giveachievement_wrapper("waronfore", 1);
  }

  thread move_to_entrance_new();
  thread scripts\sp\maps\lab\lab_lighting::init_lab_lights();
  scripts\engine\utility::flag_wait("open_lab_door");
  scripts\engine\sp\utility::remove_global_spawn_function("allies", &scripts\sp\maps\lab\lab_hill::gun_on_death);
  scripts\engine\sp\utility::remove_global_spawn_function("axis", &scripts\sp\maps\lab\lab_hill::gun_on_death);
  thread say_weapon_pickup_line();
  level.player.damage_functions = scripts\engine\utility::array_remove(level.player.damage_functions, &scripts\sp\maps\lab\lab_hill::hill_dmg_func);
  thread allies_hold_fire();
  scripts\engine\sp\utility::remove_global_spawn_function("axis", &scripts\engine\sp\utility::set_maxsightdistsquared);
  var_0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var_0, &alarm_audio);
  var_1 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_1, &turbine_spin);
}

function kill_the_window() {
  radiusdamage((1895.7, 783.974, 220.374), 50, 220, 200);
}

function lab_entrance_catchup() {
  scripts\engine\utility::flag_set("intro_drop_down_trig");
  scripts\engine\sp\utility::remove_global_spawn_function("axis", &scripts\engine\sp\utility::set_maxsightdistsquared);
  thread scripts\sp\maps\lab\lab_lighting::init_lab_lights();

  if(!scripts\sp\starts::is_after_start("gas_chambers")) {
    visionsetalternate(1, 2);
    return;
  }
}

function say_weapon_pickup_line() {
  level endon("switch_to_kyle");

  for(;;) {
    level.player waittill("weapon_taken", var_0);
    var_1 = level.player getcurrentweapon();

    while(var_1 == level.player getcurrentweapon()) {
      waitframe();
    }

    if(level.player getcurrentweapon().basename != "iw8_lm_pkilo") {
      continue;
    }

    var_2 = level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_lmgpickup_10", 0, 2);

    if(!istrue(var_2)) {
      continue;
    }

    break;
  }
}

function move_to_entrance_new() {
  var_0 = getEnt("gl_intro_door", "script_noteworthy");
  scripts\engine\utility::array_thread(level.heroes, &scripts\engine\sp\utility::disable_ai_color);
  door_scene_init();
  var_1 = scripts\engine\utility::getStruct("gl_intro_door_struct", "targetname");
  var_2 = scripts\engine\utility::getStructArray("actor_warp_structs", "targetname");
  var_2 = sortbydistance(var_2, var_1.origin);
  var_3 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.kyle, level.rebel_4, level.rebel_5];
  reach_door_check(level.price, var_1, var_2);

  foreach(var_5 in var_3) {
    thread reach_door_check(var_5, var_1);
  }

  wait 1;

  if(!scripts\engine\utility::flag("price_waiting")) {
    var_1 notify("stop_price_idle");
    level.price notify("stop_single_loop");
    move_price(var_1);
    scripts\engine\utility::flag_set("price_waiting");
  }

  if(distance2dsquared(level.player.origin, var_1.origin) > 40000) {
    GscBinSkip4(0x6e, var_1, var_2);
  }

  scripts\engine\utility::flag_wait("player_at_entrance_door");
  scripts\engine\utility::flag_set("price_nag_stop");
  var_1 notify("stop_price_idle");
  level.price notify("stop_single_loop");
  thread lab_door_move();
  thread lab_halligan_anim();
  thread lab_entrance_dialog();
  var_1 scripts\common\anim::anim_single_solo(level.price, "lab_door_enter");
  var_1 thread scripts\common\anim::anim_loop_solo(level.price, "lab_door_enter_idle", "stop_exit_idle");
  scripts\engine\utility::flag_wait("inside_waiting_flag");
  thread scripts\sp\maps\lab\lab_util::move_lab_allies("lab_ambush_door", level.rebel_1);
  scripts\engine\utility::delaythread(1.5, &scripts\sp\maps\lab\lab_util::move_lab_allies, "lab_ambush_door", level.farah);
  scripts\engine\utility::delaythread(2.5, &scripts\sp\maps\lab\lab_util::move_lab_allies, "lab_ambush_door", [level.rebel_2, level.rebel_3], 0.75);
  scripts\engine\utility::flag_wait("chokepoint_0_go_down");
  scripts\engine\sp\utility::autosave_by_name("lab_door_approach");
  scripts\engine\utility::flag_wait("inside_lab");
  clearallcorpses();
  level.rebel_1 scripts\engine\sp\utility::set_force_color("r");
  level.rebel_2 scripts\engine\sp\utility::set_force_color("b");
  level.rebel_3 scripts\engine\sp\utility::set_force_color("b");
  level.farah scripts\engine\sp\utility::set_force_color("g");
  scripts\sp\maps\lab\lab_util::array_thread_safe(var_3, &scripts\engine\sp\utility::enable_ai_color);
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "lab_door_enter");
  thread scripts\engine\sp\utility::transient_unload_array(["lab_hill_main_tr", "lab_hill_bottom_tr"]);
  scripts\sp\maps\lab\lab_util::array_thread_safe(scripts\engine\utility::array_remove(level.heroes, level.farah), &scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe);
  var_7 = [level.kyle, level.rebel_4, level.rebel_5, level.price];

  foreach(var_9 in var_7) {
    if(isDefined(var_9)) {
      var_9 delete();
    }
  }
}

function move_price() {
  var_0 = scripts\engine\utility::getStruct("price_door_path", "targetname");
  level.price.doavoidanceblocking = 0;
  level.price scripts\sp\maps\lab\lab_util::move_to_lab_node(var_0);
  scripts\sp\maps\lab\lab_util::anim_reach_and_loop_solo(level.price, "lab_door_arrive", "lab_door_idle", "stop_price_idle");
  level.price.doavoidanceblocking = 1;
}

function door_scene_init() {
  lab_door_init();
  level.follow_ent = undefined;

  foreach(var_1 in level.heroes) {
    var_1 scripts\sp\maps\lab\lab_util::stop_ai_movement_control();
  }

  var_3 = [level.rebel_4, level.rebel_5];

  foreach(var_1 in var_3) {
    var_1.fixednode = 1;
    thread scripts\sp\maps\lab\lab_util::move_lab_allies("lab_entrance_rebel", var_1);
  }
}

function door_bash_thread(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  var_2 = spawn("script_origin", self.origin);
  var_2.origin += rotatevector(var_0, self.angles);

  while(isDefined(self)) {
    if(door_check_base(var_2) && (level.player issprinting() || level.player ismeleeing())) {
      thread scripts\sp\door_internal::bashed_locked_door_sfx();
      level.player viewkick(10, var_2.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player playRumbleOnEntity("heavy_1s");
      self notify("trigger", level.player);
      wait 1;
    }

    waitframe();
  }
}

function door_check_base(var_0) {
  if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos60, var_0.origin) && distance2dsquared(var_0.origin, level.player.origin) < 625) {
    return 1;
  }

  return 0;
}

function lab_door_prompt() {
  lab_door_prompt_internal();
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function lab_door_prompt_internal() {
  level endon("price_waiting");
  thread door_bash_thread((20, -5, 50), "remove_door_prompt");
  var_0 = squared(300);

  while(!scripts\engine\utility::flag("price_waiting")) {
    thread scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (30, -5, 35), &"SCRIPT/DOOR_HINT_USE", 800, 400, 64, 1);
    var_1 = scripts\engine\utility::waittill_any_return("trigger", "remove_door_prompt");

    if(!scripts\engine\utility::flag("price_waiting")) {
      scripts\sp\player\cursor_hint::remove_cursor_hint();
    }

    if(var_1 == "remove_door_prompt") {
      break;
    } else {
      var_2 = getaiarray("axis");

      if(var_2.size == 0) {
        if(distance2dsquared(level.player.origin, level.price.origin) < < error > ) {
          break;
        }

        level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_hill_top_rally_03");

        if(distance2dsquared(level.player.origin, level.price.origin) < < error > ) {
          break;
        }

        level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_rally_04");
        break;
      } else {
        wait 0.65;
        level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_hill_top_rally_01", 1, 0.5);
        level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_rally_02");
        wait 5;
      }
    }

    break;
  }
}

function reach_door_check(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  if(scripts\engine\utility::distance_2d_squared(self.origin, var_0.origin) > 1000000) {
    var_3 = check_warp_struct(var_0, var_1);

    if(isDefined(var_3)) {
      self teleport(var_3.origin, var_3.angles);
      warp_struct_cooldown(var_3);
    } else {
      self teleport(var_1[0].origin, var_1[0].angles);
    }
  }

  if(!scripts\engine\utility::is_equal(self, level.price)) {
    thread scripts\sp\maps\lab\lab_util::move_lab_allies("lab_entrance_main", [self]);
    return;
  }
}

function check_warp_struct(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var_1[1].origin) && !istrue(var_3.on_cooldown)) {
      return var_3;
    }
  }
}

function warp_struct_cooldown() {
  self.on_cooldown = 1;
  wait 1;
  self.on_cooldown = 0;
}

function vo_enter_lab_nag() {
  if(scripts\engine\utility::flag("intro_drop_down_trig")) {
    return;
  }

  level endon("intro_drop_down_trig");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [level.farah, "dx_vom_far_hill_top_transition_10"]);
}

function lab_entrance_dialog() {
  wait 6;
  level.farah thread scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_entrance_maskon_30");
  wait 0.5;
  thread scripts\sp\maps\lab\lab_util::player_gas_mask(1);
  vo_enter_lab_nag();
  thread lab_civ_vo();
  thread walla_lab_civ_scientists();
  wait 0.5;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_entrance_maskon_20", 1, 2);
  scripts\sp\maps\lab\lab_vo_util::turbines_pa_chatter_say("dx_vom_bkv_entrance_intercom_10");
  scripts\engine\utility::flag_wait("inside_waiting_flag");
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_hill_top_rally_120");
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_top_rally_40");
  downstairs_nags();
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_entrance_lockers_10");
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_entrance_lockers_20");
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_intro_10");
  wait 0.2;
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_moving_40");
}

function walla_lab_civ_scientists() {
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("lab_walla_russian_scientists", (2400, 337, 100));
}

function downstairs_nags() {
  if(scripts\engine\utility::flag("ambush_room_approach")) {
    return;
  }

  level endon("ambush_room_approach");
  wait 8;
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_far_entrance_transition_10");
}

function lab_civ_vo() {
  var_0 = getEntArray("lab_civs", "targetname");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_1 scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm1_entrance_civs_10");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm1_entrance_civs_20");
  var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm2_entrance_civs_30");
  var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm3_entrance_civs_40");
}

function price_lab_nag() {
  level endon("price_nag_stop");
  GscBinSkip4(0x35);
}

function vo_price_lab_entrance_nags() {
  if(scripts\engine\utility::flag("price_nag_stop")) {
    return;
  }

  level endon("price_nag_stop");
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_carpark_70");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [level.price, "dx_vom_pri_hill_top_carpark_80"]);
}

function lab_door_move() {
  var_0 = getEnt("gl_intro_door", "script_noteworthy");
  var_0 notify("remove_door_prompt");
  scripts\common\anim::anim_single_solo(var_0, "lab_door_enter");
  var_0.collision connectpaths();
  scripts\engine\utility::flag_set("open_lab_door");
}

function lab_halligan_anim() {
  level.price detach(level.price.halligan, "TAG_STOWED_BACK3");
  var_0 = scripts\engine\sp\utility::spawn_anim_model("halligan");
  var_0 dontinterpolate();
  scripts\common\anim::anim_first_frame_solo(var_0, "lab_door_enter");
  scripts\common\anim::anim_single_solo(var_0, "lab_door_enter");
  var_0 delete();
  level.price attach("misc_wm_halligan_tool", "TAG_STOWED_BACK3");
  level.price.halligan = "misc_wm_halligan_tool";
}

function lab_door_init() {
  var_0 = getEnt("gl_intro_door", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("gl_intro_door_struct", "targetname");
  var_0.collision = getEnt(var_0.target, "targetname");
  var_0.collision linkTo(var_0);
  var_0.collision connectpaths();
  var_0 scripts\engine\sp\utility::assign_animtree("gl_intro_door");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "lab_door_enter");
}

function clear_hill_apcs() {
  if(!isDefined(level.hill_apcs)) {
    return;
  }

  foreach(var_1 in level.hill_apcs) {
    if(isDefined(var_1)) {
      var_1 kill();
    }
  }
}

function lab_ambush_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  thread allies_hold_fire();
  scripts\engine\sp\utility::set_start_location("ambush_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  var_0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var_0, &alarm_audio);
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var_1 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_1, &turbine_spin);
}

function turbine_spin() {
  level endon("switch_to_kyle");
  var_0 = 0.1 + randomfloatrange(0.5, 1.5);

  for(;;) {
    self rotatepitch(360, var_0);
    wait var_0;
  }
}

function lab_ambush_main() {
  thread scripts\sp\maps\lab\lab_util::sun_flare_off();
  thread allies_hold_fire();
  thread ambush1_logic();
  thread vo_ambush_enter();
  var_0 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3];
  var_1 = cos(70);
  scripts\engine\utility::flag_wait_any("ambush_tele_lower", "ambush_tele_upper");
  var_2 = getEntArray("hill_color_trigs", "targetname");
  scripts\engine\utility::array_delete(var_2);
  var_0 = scripts\engine\utility::array_removedead(var_0);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  if(var_0.size >= 3) {
    var_3 = scripts\engine\utility::getclosest(level.player.origin, var_0);
    var_0 = scripts\engine\utility::array_remove(var_0, var_3);
  }

  if(scripts\engine\utility::flag("ambush_tele_lower")) {
    cleanup_area(level.ambush["lower"]);
    scripts\engine\utility::array_thread(var_0, &ambush_teleport_to_cover, var_1);
  } else {
    cleanup_area(level.ambush["upper"]);
    scripts\engine\utility::array_thread(var_0, &ambush_teleport_to_struct, var_1);
  }

  thread farah_to_van_start();
  thread enable_van_lights();
}

function enable_van_lights() {
  var_0 = getEntArray("van_scene_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(var_2.og_intensity);
  }
}

function lab_ambush_catchup() {
  scripts\engine\utility::flag_set("ambush1_start");
  scripts\sp\maps\lab\lab_util::sun_flare_off();
}

function farah_to_van_start() {
  level endon("jumpDown_start");
  var_0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  scripts\engine\utility::flag_wait("farah_moves_up");
  scripts\engine\sp\utility::disable_ai_color();
  thread reach_to_idle_farah(var_0, "jumpDown_start");
}

function ambush_teleport_to_cover(var_0) {
  while(!isDefined(self)) {
    waitframe();
  }

  if(scripts\sp\maps\lab\lab_util::in_player_fov(var_0, self.origin)) {
    return;
  }

  var_1 = getnode("ambush_tele_lower_" + self.animname, "targetname");
  thread teleport_ai_to_cover_node(var_1);
}

function ambush_teleport_to_struct(var_0) {
  while(!isDefined(self)) {
    waitframe();
  }

  if(scripts\sp\maps\lab\lab_util::in_player_fov(var_0, self.origin)) {
    return;
  }

  var_1 = scripts\engine\utility::getStruct("ambush_tele_upper_" + self.animname, "targetname");
  scripts\engine\sp\utility::teleport_ent(var_1);
}

function cleanup_area(var_0) {
  if(isDefined(var_0) && var_0.size > 0) {
    var_0 = scripts\engine\utility::array_removedead(var_0);
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    scripts\engine\utility::array_call(var_0, &delete);
    return;
  }
}

function vo_ambush_callouts() {
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_callouts_10");
  wait 0.5;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_callouts_20");
  wait 0.85;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_callouts_30");
}

function vo_ambush_enter() {
  scripts\engine\utility::flag_wait("ambush1_start");
  wait 0.7;
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_blackout_10");
  wait 0.3;
  level.farah thread scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_blackout_20");
  thread vo_ambush_callouts();
  var_0 = (2966, -251, -120);

  while(distance2dsquared(level.player.origin, var_0) > 1156 || level.player.origin[2] < -100) {
    waitframe();
  }

  level notify("second_level");
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_moving_10");
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_moving_20");
  thread headed_to_level_3_vo();
  scripts\engine\utility::flag_wait("dam_intro_fallback_1");

  if(scripts\engine\utility::flag("van_scene_start")) {
    return;
  }

  level endon("van_scene_start");
  var_1 = gettime();

  while(!scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_left() && !scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_forward() && !scripts\engine\utility::time_has_passed(var_1, 6)) {
    level waittill("dam_intro_fallback_1");
  }

  if(scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_forward()) {
    level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_10");
  }

  var_1 = gettime();

  while(!scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_left() && !scripts\engine\utility::time_has_passed(var_1, 12)) {
    level waittill("dam_intro_fallback_1");
  }

  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_20");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_30");
  wait 10;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_40");
  wait 12;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_50");
}

function headed_to_level_3_vo() {
  var_0 = (3610, 142, 56);
  var_1 = (3051, 56, 56);
  var_2 = distance2dsquared(level.player.origin, var_0) < 1600;

  for(var_3 = distance2dsquared(level.player.origin, var_1) < 2116; !var_2 && !var_3 || level.player.origin[2] < 56; var_3 = distance2dsquared(level.player.origin, var_1) < 2116) {
    waitframe();
    var_2 = distance2dsquared(level.player.origin, var_0) < 1600;
  }

  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_moving_30");
}

function lab_civs_logic() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.team = "neutral";
  self.script_friendname = "";
  scripts\common\ai::gun_remove();
  self enableavoidance(0);
}

function ambush1_logic() {
  level.upperguys = [];
  scripts\engine\sp\utility::battlechatter_off();
  thread start_ambush_on_player_fire();
  scripts\engine\utility::flag_wait("ambush1_start");
  thread spawn_ambush_enemies();
  thread lights_out_alarm_off();
  thread guy_up_stairs_watcher();
  scripts\engine\sp\utility::autosave_by_name("lab_ambush");
  thread ambush_save(level.upperguys);
  wait 1;
  scripts\engine\sp\utility::activate_trigger_with_targetname("turbine_ambush_start");
  wait 1.5;
  scripts\engine\sp\utility::battlechatter_on();
  thread do_gl_hint();
}

function spawn_ambush_enemies() {
  var_0 = getspawnerarray("group1");

  foreach(var_2 in var_0) {
    var_3 = var_2 stalingradspawn();
    level.upperguys[level.upperguys.size] = var_3;
  }

  var_2 = getspawner("group2", "targetname");
  var_2 scripts\engine\sp\utility::spawn_ai(1);
}

function guy_up_stairs_watcher() {
  var_0 = scripts\engine\utility::getStruct("ambush_run_up_stairs", "targetname");
  var_1 = squared(350);

  for(;;) {
    var_2 = distancesquared(level.player.origin, var_0.origin);

    if(var_2 <= var_1) {
      break;
    }

    waitframe();
  }

  var_1 = squared(200);
  var_3 = cos(40);

  for(;;) {
    var_2 = distancesquared(level.player.origin, var_0.origin);

    if(var_2 <= var_1) {
      break;
    } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var_3, var_0.origin, [level.player])) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("guy_running_up_stairs");
}

function ambush_save(var_0) {
  for(;;) {
    var_0 = scripts\engine\utility::array_removedead(var_0);

    if(var_0.size < 3) {
      break;
    }

    wait 1.5;
  }

  if(!scripts\engine\utility::flag("cp_2_scene_start")) {
    scripts\engine\sp\utility::autosave_by_name("upper_guys_dead");
    return;
  }
}

function do_gl_hint() {
  wait 4;

  while(nullweapon(level.player getcurrentweapon())) {
    wait 0.1;
  }

  var_0 = level.player getcurrentweapon();
  var_1 = var_0 getaltweapon();

  if(scripts\engine\utility::is_equal(var_0.underbarrel, "ub_mike203_sp") && isDefined(var_1) && level.player getammocount(var_1) > 0) {
    if(level.player usinggamepad()) {
      scripts\engine\sp\utility::display_hint("gl_hint", 7);
      return;
    }

    scripts\engine\sp\utility::display_hint("gl_hint_kbm", 7);
    return;
  }
}

function is_using_gl() {
  var_0 = level.player getcurrentweapon();
  return scripts\engine\utility::is_equal(var_0.underbarrel, "ub_mike203_sp") && istrue(var_0.isalternate) && level.player getammocount(var_0) > 0;
}

function lights_out_alarm_off() {
  var_0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var_0, &scripts\engine\sp\utility::notify_delay, "stop_alarm", 0.1);
  thread scripts\engine\utility::play_sound_in_space("warehouse_lights_off", level.player.origin + (0, 0, 200));
  thread mus_lights_out();
  wait 0.1;
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();
  visionsetalternate(1, 2);
  thread ambush_halon_gas_control();
  wait 0.2;
  scripts\engine\utility::flag_wait("ambush1_start");
}

function ambush_halon_gas_control() {
  scripts\engine\utility::exploder("halon_gas");
  thread fog_fx_check("t1_fog_vol", "halon_gas_screen");
  wait level.blackout_delay;
  visionsetnaked("lab_interior_turbines_ambush_fog", 8);
  wait 12;
  visionsetnaked("", 3.5);
}

function fog_fx_check(var_0, var_1) {
  level.player endon("death");
  var_2 = getEnt(var_0, "targetname");

  if(level.player istouching(var_2)) {
    scripts\engine\utility::exploder(var_1);
  }

  var_3 = gettime() + 2000;

  while(gettime() < var_3) {
    wait 0.1;

    if(!level.player istouching(var_2)) {
      scripts\engine\utility::stop_exploder(var_1);
      break;
    }
  }
}

function mus_lights_out() {
  wait 0.2;
  setmusicstate("mx_lab_factory_infil");
}

function rpg_callout() {
  scripts\engine\sp\utility::trigger_wait_targetname("spawn_sniper_targets");
  wait 1;
  var_0 = scripts\engine\sp\utility::get_ai_group_ai("sniper_targets");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.dropweapon = 0;
    var_3 scripts\sp\nvg\nvg_ai::flashlight_on(1);

    if(var_3.weapon.classname == "rocketlauncher") {
      var_1 = var_3;
    }
  }

  for(;;) {
    var_1 = scripts\engine\utility::array_removedead(var_1);

    if(!var_1.size) {
      return;
    }

    foreach(var_3 in var_1) {
      if(var_3 scripts\sp\maps\lab\lab_util::is_aimed_at_enemy(level.cos30)) {
        return;
      }
    }

    wait 1;
  }
}

function start_ambush_on_player_fire() {
  level endon("ambush1_start");
  scripts\engine\utility::flag_wait_any("eyes_on_turbine_room", "player_in_turbine_lower");
  level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
  scripts\engine\utility::flag_set("ambush1_start");
}

function alarm_audio() {
  self endon("stop_alarm");

  for(;;) {
    scripts\engine\utility::play_sound_in_space("indoor_alarm");
    wait 2.5;
  }
}

function allies_hold_fire() {
  level.player.ignoreme = 1;
  level.farah.ignoreme = 1;
  level.farah.ignoreall = 1;
  level.farah.dontevershoot = 1;
  level.rebel_1.ignoreme = 1;
  level.rebel_1.ignoreall = 1;
  level.rebel_1.dontevershoot = 1;
  level.rebel_2.ignoreme = 1;
  level.rebel_2.ignoreall = 1;
  level.rebel_2.dontevershoot = 1;
  level.rebel_3.ignoreme = 1;
  level.rebel_3.ignoreall = 1;
  level.rebel_3.dontevershoot = 1;
  scripts\engine\utility::flag_wait("ambush1_start");
  level.player.ignoreme = 0;
  wait 2.5;
  level.farah.ignoreall = 0;
  level.farah.ignoreme = 0;
  level.farah.dontevershoot = 0;
  level.rebel_1.ignoreall = 0;
  level.rebel_1.ignoreme = 0;
  level.rebel_1.dontevershoot = 0;
  level.rebel_2.ignoreall = 0;
  level.rebel_2.ignoreme = 0;
  level.rebel_2.dontevershoot = 0;
  level.rebel_3.ignoreall = 0;
  level.rebel_3.ignoreme = 0;
  level.rebel_3.dontevershoot = 0;
}

function ambush1_cleanup() {
  scripts\engine\utility::flag_wait("ambush1_outside_dropdown");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(var_3 >= 3) {
      var_2.diequietly = 1;
    }
  }

  scripts\engine\utility::array_call(getaiarray("axis"), &delete);
}

function lab_jumpdown_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  scripts\engine\sp\utility::set_start_location("jumpdown_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var_0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_0, &turbine_spin);
  var_1 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  thread reach_to_idle_farah(level.farah, var_1);
}

function lab_jumpdown_main() {
  thread ambush1_cleanup();
  van_scene_init();
  van_scene();
  scripts\engine\sp\utility::remove_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::allies_molotov_toggle);
  scripts\engine\sp\utility::autosave_by_name("jump_down_done_b");
  scripts\engine\utility::flag_set("ambush2_entrance_go");
  cp_3_doors_scene();
}

function van_dead_guys() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("van_scene_deadbody", 1, 1);

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_3 thread scripts\common\anim::anim_loop_solo(var_2, "van_jumpdown_deadguy");
    var_2.dropweapon = 0;
    var_2.skipdeathanim = 1;
    var_2 scripts\common\ai::stop_magic_bullet_shield();
    var_2.ragdoll_immediate = 1;
    var_2.allowdeath = 1;
    var_2.diequietly = 1;
    var_2 scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::die);
  }
}

function van_scene_init() {
  level.nikolai_van = nik_van_init();
  player_bomb_init();
  thread dock_door_init();
  var_0 = getspawner("hero_Nikolai", "targetname");
  level.nikolai = var_0 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.nikolai.animname = "nikolai";
  level.nikolai setModel("body_hero_nikolai_lab");
  level.nikolai scripts\common\ai::magic_bullet_shield();
  thread damage_watcher();
}

function damage_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_2, var_2, var_2, var_2, var_2, var_3);

    if(isDefined(var_3) && var_3.basename == "flash") {
      continue;
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  scripts\sp\player_death::set_custom_death_quote(10);
  scripts\sp\utility::missionfailedwrapper();
}

function dock_door_init() {
  var_0 = getEntArray("jumpdown_doors", "targetname");

  foreach(var_2 in var_0) {
    var_2.animname = "van_intro_doors";
    var_2 scripts\engine\sp\utility::assign_animtree();
    var_3 = getEnt(var_2.target, "targetname");
    var_2.clip = var_3;
    var_2.clip linkTo(var_2);
    var_2.clip disconnectPaths();
    var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2.struct = var_4;
  }
}

function dock_doors_move() {
  var_0 = getEntArray("jumpdown_doors", "targetname");
  move_the_door(var_0[0]);
  move_the_door(var_0[1]);
  var_0[0] waittill("rotatedone");
  var_0[0].clip disconnectPaths();
  var_0[1].clip disconnectPaths();
}

function move_the_door() {
  self.clip connectpaths();

  if(isDefined(self.og_angles)) {
    var_0 = self.og_angles;
  } else {
    self.og_angles = self.angles;
    var_0 = self.struct.angles;
  }

  self rotateTo(var_0, 1, 0.5, 0.5);
}

function van_scene() {
  setmusicstate("");
  var_0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  scripts\engine\utility::flag_wait_any("jumpDown_start", "van_scene_start");
  var_0 notify("stop_loop");
  scripts\engine\sp\utility::autosave_by_name("van_scene");
  var_1 = spawn_van_guys();

  if(scripts\engine\utility::flag("van_scene_start")) {
    var_2 = scripts\engine\utility::array_add(var_1, level.farah);
  } else {
    var_2 = var_2;
  }

  scripts\sp\maps\lab\lab_util::array_thread_safe(var_2, &scripts\engine\sp\utility::disable_ai_color);
  thread dock_doors_move();
  scripts\engine\utility::delaythread(2, &dock_doors_move);
  thread jumpdown_reach_idle(var_1, var_2, "van_jumpdown_idle");
  scripts\engine\utility::flag_wait("van_scene_start");
  thread van_dead_guys();
  var_1 scripts\common\anim::anim_first_frame_solo(level.bomb, "van_bomb_pickup");
  var_3 = getEnt("van_jumpdown_vol", "targetname");
  var_4 = gettime() + 3000;

  while(var_3 scripts\engine\sp\utility::get_ai_touching_volume("allies").size < 3 && gettime() < var_4) {
    waitframe();
  }

  foreach(var_6 in level.heroes) {
    var_6 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  if(!scripts\engine\utility::flag("van_guys_ready")) {
    scripts\engine\utility::array_thread(level.nikolai_van.bombs, &setup_ally_bombs, var_1);
    thread van_scene_a(var_1);
    var_8 = scripts\engine\utility::flag_wait_any_return("ambush1_outside_dropdown", "van_guys_ready");

    if(var_8 == "ambush1_outside_dropdown") {
      level notify("van_rushed");
      var_9 = scripts\engine\utility::getStruct("van_scene_start", "targetname");

      while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var_9.origin)) {
        waitframe();
      }
    }

    var_1 notify("van_jumpdown_idle_stop");
    thread van_scene_a(var_1);
  } else {
    var_10 = scripts\engine\utility::array_combine([level.nikolai_van, level.nikolai], level.heroes);
    thread van_scene_a(var_1);
  }

  GscBinSkip4(0x6e, var_1, var_10, level.heroes, [level.nikolai_van, level.nikolai], "van_jumpdown_idle_stop");
}

function remove_van_lights() {
  var_0 = getEntArray("van_scene_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }

  wait 0.1;

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

function animated_van_scene(var_0) {
  self endon("death");
  var_0 scripts\common\anim::anim_single_solo(self, "van_scene");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "van_door_idle");
}

function delete_old_rebels() {
  scripts\engine\utility::flag_wait("ambush1_outside_dropdown");

  foreach(var_1 in level.old_rebels) {
    if(isDefined(var_1.magic_bullet_shield)) {
      var_1 scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(level.old_rebels, 50);
}

function setup_ally_bombs(var_0) {
  var_0 scripts\common\anim::anim_first_frame_solo(self, "van_jumpdown_start");
}

function van_scene_dialog() {
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_jumpdown_intro_20");
  wait 2;
  level.nikolai scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_nik_jumpdown_intro_30");
  var_0 = distance(level.player.origin, level.nikolai.origin) > 500;

  if(!var_0 && level.player scripts\engine\trace::can_see_origin(level.nikolai getEye(), 0)) {
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_jumpdown_intro_40");
  } else if(var_0 && level.player scripts\engine\trace::can_see_origin(level.nikolai getEye(), 0)) {
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_jumpdown_intro_41");
  } else {
    wait 1;
  }

  level.nikolai scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_nik_jumpdown_charges_10");
}

function jumpdown_reach_idle(var_0, var_1, var_2) {
  scripts\engine\utility::flag_set("van_guys_ready");

  foreach(var_4 in var_0) {
    thread reach_to_idle(var_4, self);
  }
}

function reach_to_idle(var_0, var_1) {
  var_0 endon(var_1);
  var_0 scripts\common\anim::anim_single_solo(self, "van_jumpdown_arrival");
  var_0 childthread scripts\common\anim::anim_loop_solo(self, "van_jumpdown_idle");
}

function reach_to_idle_farah(var_0, var_1) {
  self endon(var_1);
  self.ignoreall = 1;
  self.ignoreme = 1;
  var_2 = scripts\engine\utility::getanim("van_jumpdown_arrival");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  self setgoalpos(var_3);
  var_4 = squared(110);

  for(;;) {
    var_5 = distancesquared(self.origin, var_3);

    if(var_5 <= var_4) {
      break;
    }

    waitframe();
  }

  self.startingjumpdownanim = "started";
  var_0 scripts\sp\anim::anim_reach_solo(self, "van_jumpdown_arrival");
  var_0 scripts\common\anim::anim_single_solo(self, "van_jumpdown_arrival");
  self.startingjumpdownanim = "inPosition";
  var_0 childthread scripts\common\anim::anim_loop_solo(self, "van_jumpdown_idle", "van_jumpdown_idle");
}

function spawn_van_guys() {
  level.old_rebels = [level.rebel_1, level.rebel_2, level.rebel_3];
  strip_old_ai(level.old_rebels);
  var_0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");

  foreach(var_2 in level.old_rebels) {
    var_2 notify("entitydeleted");
    level.heroes = scripts\engine\utility::array_remove(level.heroes, var_2);
  }

  level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
  level.heroes[level.heroes.size] = level.rebel_1;
  getspawner("redshirt_rebel_1", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_1, 1);
  var_0 scripts\common\anim::anim_first_frame_solo(level.rebel_1, "van_jumpdown_arrival");
  level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
  level.heroes[level.heroes.size] = level.rebel_2;
  getspawner("redshirt_rebel_2", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_2, 1);
  var_0 scripts\common\anim::anim_first_frame_solo(level.rebel_2, "van_jumpdown_arrival");
  level.rebel_3 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_4", 1);
  level.rebel_3.animname = "rebel_3";
  level.heroes[level.heroes.size] = level.rebel_3;
  getspawner("redshirt_rebel_3", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_3, 1);
  var_0 scripts\common\anim::anim_first_frame_solo(level.rebel_3, "van_jumpdown_arrival");
  var_4 = [level.rebel_1, level.rebel_2, level.rebel_3];
  scripts\engine\utility::array_thread(var_4, &scripts\sp\maps\lab\lab_util::ai_gas_mask, 1);
  scripts\engine\utility::array_thread(var_4, &scripts\anim\shared::forceuseweapon, "iw8_ar_akilo47", "primary");
  scripts\engine\utility::array_thread(var_4, &scripts\common\ai::magic_bullet_shield);
  scripts\sp\maps\lab\lab_util::rebuild_heroes_array();
  return [level.rebel_1, level.rebel_2, level.rebel_3];
}

function strip_old_ai() {
  foreach(var_1 in self) {
    var_1.animname = undefined;

    if(isDefined(var_1.my_spawner)) {
      var_1.my_spawner notify("stop_rebel_flood");
    }
  }

  level.rebel_1 = undefined;
  level.rebel_2 = undefined;
  level.rebel_3 = undefined;
  waitframe();
}

function anim_reach_safe(var_0, var_1) {
  while(!isalive(var_0)) {
    waitframe();
  }

  scripts\sp\anim::anim_reach_solo(var_0, var_1);
}

function van_scene_a(var_0) {
  level endon("bomb_pickup");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  self notify("van_jumpdown_idle_stop");
  self notify("stop_loop");

  if(isarray(var_0)) {
    var_1 = var_0;
    var_3 = getfirstarraykey(var_1);

    if(isDefined(var_3)) {
      var_2 = var_1[var_3];
      GscBinSkip4(0x35, var_2);
    }

    var_1 = undefined;
    var_3 = undefined;
    return;
  }

  play_scene_safe(var_0);
}

function play_scene_safe(var_0) {
  wait_on_living(var_0);

  if(var_0.animname == "rebel_1") {
    thread play_c4_anims();
    scripts\common\anim::anim_single_solo(var_0, "van_jumpdown_start");
  } else if(var_0.animname == "farah") {
    var_1 = scripts\engine\utility::getStructArray("farah_teleport_struct", "targetname");

    if(isDefined(var_0.startingjumpdownanim)) {
      while(var_0.startingjumpdownanim == "started") {
        waitframe();
      }

      level.farah notify("jumpDown_start");
    } else {
      var_2 = cos(70);

      while(farah_teleport_in_player_fov(var_0, var_2, var_1)) {
        waitframe();
      }

      level.farah notify("jumpDown_start");

      if(isDefined(var_0.startingjumpdownanim) && var_0.startingjumpdownanim == "inPosition") {} else {
        scripts\common\anim::anim_single_solo(var_0, "van_jumpdown_arrival");
        thread scripts\common\anim::anim_loop_solo(var_0, "van_jumpdown_idle", "stop_farah_jumpdown_idle");
        wait 1.5;
      }

      self notify("stop_farah_jumpdown_idle");
    }

    var_0.ignoreall = 0;
    var_0.ignoreme = 0;
    self notify("van_jumpdown_idle");
    scripts\common\anim::anim_single_solo(var_0, "van_jumpdown_start");
  } else {
    scripts\common\anim::anim_single_solo(var_0, "van_jumpdown_start");
  }

  wait_on_living(var_0);

  if(isai(var_0)) {
    if(var_0.animname == "nikolai") {
      var_3 = ["dx_vom_nik_jumpdown_charges_20", "dx_vom_nik_jumpdown_charges_40", "dx_vom_nik_jumpdown_charges_10"];
      var_0 thread scripts\sp\maps\lab\lab_util::notetrack_nag(var_3, "grab_charges");
      thread scripts\common\anim::anim_loop_solo_with_nags(var_0, "van_start_idle", "stop_van_idle");
      return;
    }

    thread scripts\common\anim::anim_loop_solo(var_0, "van_start_idle", "stop_van_idle");
    return;
  }
}

function farah_teleport_in_player_fov(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self.startingjumpdownanim) && self.startingjumpdownanim == "inPosition") {
    var_2 = 0;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var_0, self gettagorigin("j_spine4"), [self, level.player])) {
    var_2 = 1;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var_0, var_1[0].origin, [level.player, level.rebel_1, level.rebel_2, level.rebel_3])) {
    var_2 = 1;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var_0, var_1[1].origin, [level.player, level.rebel_1, level.rebel_2, level.rebel_3])) {
    var_2 = 1;
  }

  return var_2;
}

function play_c4_anims() {
  scripts\common\anim::anim_single(level.nikolai_van.bombs, "van_jumpdown_start");

  foreach(var_1 in level.nikolai_van.bombs) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

function wait_on_living(var_0) {
  while(isai(var_0) && !isalive(var_0)) {
    waitframe();
  }
}

function player_bomb_init() {
  level.bomb = getEnt("van_bomb", "targetname");
  level.bomb scripts\engine\sp\utility::assign_animtree("van_bomb");
}

function player_pickup_bomb() {
  level.player endon("death");
  wait 7.5;
  var_0 = scripts\engine\utility::getStruct("van_bomb_struct", "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (5, -1, -1.5), &"SCRIPT/PICKUP", 600, 300, 64, 0, undefined, undefined, undefined, undefined, undefined, undefined, 65, 60);
  var_0 waittill("trigger");
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  scripts\sp\player_rig::link_player_to_rig("van_bomb_pickup", undefined, 1, 0.3, 0, 0, 0, 0, 0, 1);
  thread setup_detonator_swap();
  childthread scripts\common\anim::anim_single([level.bomb, level.player_rig, level.player_rig.detonator], "van_bomb_pickup");
  level notify("bomb_pickup");
  thread scripts\sp\maps\lab\lab_lighting::c4_pickup_dof();
  var_1 = scripts\engine\utility::array_add(level.heroes, level.nikolai);
  scripts\sp\maps\lab\lab_util::array_thread_safe(var_1, &scripts\engine\sp\utility::anim_stopanimscripted);
  self notify("stop_van_idle");
}

function setup_detonator_swap() {
  level.player_rig.detonator = scripts\engine\sp\utility::spawn_anim_model("van_detonator");
  level.player_rig.detonator hide();
  level.nikolai attach("offhand_vm_clacker_tactical_sp_cinematic", "tag_accessory_right");
}

function nik_van_init() {
  var_0 = getEnt("interrogation_van", "script_noteworthy");
  var_0 scripts\engine\sp\utility::assign_animtree("nik_van");
  var_0.extras = [];
  var_0.bombs = [];
  var_1 = getEnt("van_door_left", "targetname");
  var_1 linkTo(var_0, "tag_door_rear_left");
  var_2 = getEnt("van_door_right", "targetname");
  var_2 linkTo(var_0, "tag_door_rear_right");
  var_3 = getEntArray("van_extras", "targetname");

  foreach(var_5 in var_3) {
    var_0.extras[var_0.extras.size] = var_5;
  }

  var_3 = getEntArray("van_cargo", "targetname");

  foreach(var_5 in var_3) {
    var_0.extras[var_0.extras.size] = var_5;
  }

  var_3 = getEntArray("van_bombs", "targetname");

  foreach(var_5 in var_3) {
    var_5 scripts\engine\sp\utility::assign_animtree(var_5.script_noteworthy);
    var_0.bombs[var_0.bombs.size] = var_5;
  }

  return var_0;
}

function cp_3_doors_scene() {
  scripts\engine\utility::flag_wait("ambush2_entrance_go");
  thread farah_move_up();
  thread mus_outside_door_breach();
  dragons_breath_scene();
}

function farah_move_up() {
  wait 1.5;
  var_0 = getnode("jump_down_farah", "targetname");
  level.farah scripts\sp\spawner::go_to_node(var_0);
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

function dragons_breath_scene() {
  scripts\sp\maps\lab\lab_util::array_thread_safe(getaiarray("allies"), &scripts\engine\sp\utility::enable_ai_color);
  cp_3_enemy_setup();
  var_0 = scripts\engine\utility::array_removedead([level.rebel_1, level.rebel_2, level.rebel_3]);
  var_1 = scripts\engine\utility::getStruct("chokepoint_3_animnode", "targetname");
  var_2 = getEntArray("cp_3_doors", "script_noteworthy");
  level notify("reached_t2");

  foreach(var_4 in var_0) {
    if(var_4.animname == "rebel_2") {
      var_4.bypassdbcheck = 1;
    }

    var_4.dropweapon = 0;
    var_4.attackeraccuracy = 5;
  }

  var_1 thread scripts\common\anim::anim_single_solo(level.cp_3_enemy, "cp_3_buddy_door_push");
  var_1 thread scripts\common\anim::anim_single(var_0, "cp_3_buddy_door_push");
  var_1 scripts\common\anim::anim_single(var_2, "cp_3_buddy_door_push");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("db_color_trigger_1");
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::activate_trigger_with_noteworthy, "db_color_trigger_2");

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_4 scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    }
  }

  foreach(var_9 in var_2) {
    var_9.collision connectpaths();
    var_9.collision disconnectPaths();
  }

  scripts\sp\maps\lab\lab_util::array_thread_safe(var_0, &scripts\common\utility::disable_cqbwalk);
  wait 2.5;

  if(isalive(level.cp_3_enemy)) {
    level.cp_3_enemy scripts\engine\sp\utility::set_attackeraccuracy(0.7);
  }

  level.db_2_enemy = scripts\engine\sp\utility::spawn_targetname("cp_3_enemy_2", 1);
  scripts\engine\utility::flag_wait("db_enemy_dead");
  thread turbines_dialog();
  var_0 = [level.rebel_1, level.rebel_2, level.rebel_3, level.cp_3_enemy];
  var_0 = scripts\engine\utility::array_removedead(var_0);

  foreach(var_12 in var_0) {
    var_12.attackeraccuracy = 1;
  }

  scripts\sp\maps\lab\lab_util::array_thread_safe(scripts\engine\utility::array_remove(getaiarray("allies"), level.farah), &scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe);
}

function cp_3_enemy_setup() {
  level.cp_3_enemy = scripts\engine\sp\utility::spawn_targetname("cp_3_enemy", 1);
  thread redshirt_die();
  level.cp_3_enemy thread scripts\engine\sp\utility::flag_on_death("db_enemy_dead");
  level.cp_3_enemy.animname = "cp_3_enemy";
  thread incendiary_attacker_logic();
  level.cp_3_enemy.health = 250;
  level.cp_3_enemy.attackeraccuracy = 0;
  level.cp_3_enemy.dropweapon = 0;
  level.cp_3_enemy thread scripts\sp\maps\lab\lab_util::check_dropped_weapon();
  var_0 = scripts\sp\maps\lab\lab_util::make_incendiary_shottie();
  level.cp_3_enemy thread scripts\anim\shared::forceuseweapon(var_0, "primary");
}

function turbines_dialog() {
  wait 15;
  scripts\sp\maps\lab\lab_vo_util::wait_combat_cooldown(0.8, 10);
  scripts\sp\maps\lab\lab_vo_util::turbines_pa_chatter_say("dx_vom_bkv_dragons_breath_clear_10");
  scripts\sp\maps\lab\lab_vo_util::wait_combat_cooldown(0.8, 6);
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_dragons_breath_clear_20");
  wait 0.2;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_dragons_breath_clear_30");
}

function mus_outside_door_breach() {
  wait 1;
  setmusicstate("mx_lab_dragon");
  wait 45;
  setmusicstate("");
}

function lab_jumpdown_catchup() {
  scripts\engine\utility::flag_set("ambush2_entrance_go");
}

function init_cp_3_doors() {
  wait 0.1;
  var_0 = getEntArray("cp_3_doors", "script_noteworthy");

  foreach(var_2 in var_0) {
    scripts\sp\maps\lab\lab_util::assign_door_ents(var_2);
    var_2 scripts\engine\sp\utility::assign_animtree(var_2.targetname);
    var_2.collision connectpaths();
  }

  var_4 = scripts\engine\utility::getStruct("chokepoint_3_animnode", "targetname");
  var_4 scripts\common\anim::anim_first_frame(var_0, "van_door_push");
  wait 0.05;

  foreach(var_2 in var_0) {
    var_2.collision disconnectPaths();
  }
}

function incendiary_attacker_logic() {
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player) {
      scripts\engine\sp\utility::anim_stopanimScripted();
      self.allowdeath = 1;
      return;
    }
  }
}

function redshirt_die() {
  self waittillmatch("single anim", "end");

  if(scripts\engine\utility::flag("dragons_breath_shot")) {
    self.diequietly = 1;
    thread scripts\engine\sp\utility::clear_deathanim();
    self.skipdeathanim = 1;
    self.a.nodeath = 1;
    self.noragdoll = 1;
    scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    self.allowdeath = 1;
    scripts\engine\sp\utility::die();
    return;
  }
}

function dragons_breath_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  scripts\engine\sp\utility::set_start_location("turbine_room_one_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();

  foreach(var_1 in [level.rebel_1, level.rebel_2, level.rebel_3]) {
    var_1 scripts\engine\sp\utility::disable_ai_color();
  }

  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var_3 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_3, &turbine_spin);
  scripts\engine\utility::flag_set("ambush2_entrance_go");
  thread cp_3_doors_scene();
}

function dragons_breath_main() {
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 0);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\maps\lab\lab_util::laser_discipline);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::laser_discipline);
  thread t2_flood_init();
  var_0 = getEntArray("jugg_bomb", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, &hide);
  thread t2_manager();
  thread barrel_thread_setup();
  thread vo_dragons_breath();
  thread turbine_enemies_seek();
  thread juggernaut_fire_suppression();
  thread disconnect_jumpdown_traversal();
  thread scripts\engine\utility::array_delete(getEntArray("ambush_triggers", "script_noteworthy"));
  thread turbines_clear_thread();
  thread dragons_breath_hit_farah();
  var_1 = scripts\engine\utility::flag_wait_any_return("turbines_clear", "turbines_rushed");

  if(var_1 == "turbines_rushed") {
    var_2 = getaiarray("axis");

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(var_5 >= 3) {
          var_4.diequietly = 1;
        }
      }

      scripts\engine\utility::array_call(getaiarray("axis"), &delete);
    }

    scripts\engine\utility::flag_set("turbines_clear");
  }

  scripts\engine\sp\utility::autosave_by_name("turbines_clear");
  var_6 = getEntArray("turbine2_spawn_trigs", "script_noteworthy");
  scripts\engine\utility::array_delete(var_6);
}

function barrel_thread_setup() {
  level endon("juggernaut_dead");
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("scriptable_decor_barrels_gameplay_flammable", "classname");
  var_1 = var_0;
  var_3 = getfirstarraykey(var_1);

  if(isDefined(var_3)) {
    var_2 = var_1[var_3];
    GscBinSkip4(0x6e, var_2);
  }

  var_1 = undefined;
  var_3 = undefined;
}

function barrelbarrel_damage_thread() {
  var_0 = self.origin;

  while(!scripts\engine\utility::flag("juggernaut_dead")) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_10) && getweaponbasename(var_10) == "iw8_sh_dpapa12_incendiary" && var_5 != "MOD_MELEE") {
      self radiusdamage(var_0, 10, 25, 20, var_2, var_5, var_10);
    }
  }
}

function t2_flood_init() {
  scripts\engine\utility::flag_wait("start_t2_flood");
  var_0 = getspawnerarray("t2_flood_enemies");

  foreach(var_2 in var_0) {
    thread t2_floods();
  }

  scripts\engine\utility::flag_wait("stop_t2_flood");
  scripts\engine\utility::array_delete(var_0);
}

function t2_floods() {
  self endon("death");
  wait 2;
  self.count += 1;
  var_0 = scripts\engine\sp\utility::spawn_ai();
  level endon("stop_t2_flood");

  while(isDefined(self)) {
    if(isDefined(var_0)) {
      self.count += 1;
      var_0 endon("entitydeleted");
      var_0 waittill("death");
      wait 5;

      while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin, [level.player])) {
        wait 0.15;
      }

      var_0 = self stalingradspawn();
      continue;
    }

    wait 5;
  }
}

function turbines_clear_thread() {
  level endon("turbines_rushed");
  scripts\engine\sp\utility::waittill_ai_group_dead("turbine_end_guys");
  scripts\engine\utility::flag_set("turbines_clear");
}

function dragons_breath_hit_farah() {
  level.farah waittill("damage", var_0, var_1, var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_2);

  if(scripts\engine\utility::is_equal(var_1, level.player) && isDefined(var_2) && getweaponbasename(var_2) == "iw8_sh_dpapa12_incendiary") {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }
}

function dragons_breath_catchup() {
  scripts\engine\utility::flag_set("turbines_clear");
  thread scripts\sp\maps\lab\lab_util::remove_animated_door("t2_doors");
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::remove_animated_door, "cp_3_doors");
  var_0 = getEntArray("turbine2_spawn_trigs", "script_noteworthy");
  var_1 = getEntArray("turbine2_spawn_trigs_rightside", "script_noteworthy");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  if(var_2.size) {
    scripts\engine\utility::array_delete(var_2);
  }

  var_3 = getEntArray("ambush_triggers", "script_noteworthy");
  thread scripts\engine\utility::array_delete(var_3);
}

function t2_manager() {
  level endon("turbines_clear");
  level.t2_manager["player_pos"] = "_left";
  level.t2_manager["fallback"] = "_large";
  level.t2_manager["volume"] = t2_update_volume();
  scripts\engine\utility::flag_set("t2_start");
  GscBinSkip4(0x35);
}

function t2_update_volume() {
  var_0 = "t2" + level.t2_manager["fallback"] + level.t2_manager["player_pos"];
  var_1 = getEnt(var_0, "targetname");
  return var_1;
}

function t2_player_pos() {
  level endon("t2_stop_trigger_watch");
  var_0 = getEnt("t2_player_left", "targetname");
  var_1 = getEnt("t2_player_right", "targetname");
  var_2 = "left";

  for(;;) {
    if(var_2 != "left" && level.player istouching(var_0)) {
      level.t2_manager["player_pos"] = "_left";
      wait 0.2;
      level notify("t2_update_volume");
      var_2 = "left";
    } else if(var_2 != "right" && level.player istouching(var_1)) {
      level.t2_manager["player_pos"] = "_right";
      wait 0.2;
      level notify("t2_update_volume");
      var_2 = "right";
    }

    waitframe();
  }
}

function t2_enemy_fallback() {
  level notify("t2_update_volume");
  scripts\engine\utility::flag_wait("t2_fallback1");
  level.t2_manager["fallback"] = "_medium";
  waitframe();
  level notify("t2_update_volume");
  var_0 = getEntArray("turbine2_spawn_trigs_rightside", "script_noteworthy");

  if(var_0.size) {
    scripts\engine\utility::array_delete(var_0);
  }

  scripts\engine\utility::flag_wait("t2_fallback2");
  level.t2_doorbuster_enemy_2 = scripts\engine\sp\utility::spawn_targetname("turbine_last_2", 1);
  level.t2_doorbuster_enemy_3 = scripts\engine\sp\utility::spawn_targetname("turbine_last_3", 1);
  level notify("t2_stop_trigger_watch");
  level.t2_manager["player_pos"] = "_both";
  level.t2_manager["fallback"] = "_small";
  waitframe();
  level notify("t2_update_volume");
}

function t2_enemy_update_volume() {
  for(;;) {
    jumpiftrue(isDefined(level._ai_group["turbine_end_guys"])) LOC_00000014;
    waitframe();
  }

  for(;;) {
    level waittill("t2_update_volume");
    var_0 = scripts\engine\sp\utility::get_ai_group_ai("turbine_end_guys");
    scripts\engine\utility::array_call(var_0, &cleargoalvolume);

    foreach(var_2 in var_0) {
      var_2 setgoalpos(var_2.origin);
    }

    level.t2_manager["volume"] = t2_update_volume();
    scripts\engine\utility::array_call(var_0, &setgoalvolumeauto, level.t2_manager["volume"]);
  }
}

function vo_dragons_breath() {
  scripts\engine\utility::flag_wait("db_enemy_dead");
  wait 0.65;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_dragons_breath_entry_21");
  thread t2_combat_nags();
}

function turbine_enemies_seek() {
  while(scripts\engine\sp\utility::get_ai_group_count("turbine_end_guys") >= 3) {
    wait 0.1;
  }

  var_0 = scripts\engine\sp\utility::get_ai_group_ai("turbine_end_guys");

  foreach(var_2 in var_0) {
    var_2.goalradius = 64;
    var_2 setgoalentity(level.player);
  }
}

function juggernaut_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  scripts\engine\sp\utility::set_start_location("juggernaut_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var_0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_0, &turbine_spin);
  thread juggernaut_fire_suppression();
  thread disconnect_jumpdown_traversal();
  var_1 = getEntArray("jugg_bomb", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, &hide);
}

function juggernaut_main() {
  scripts\engine\sp\utility::activate_trigger_with_targetname("t2_finished");
  setmusicstate("mx_lab_jugg_tension");
  var_0 = level.friendlyfire["friend_kill_points"];
  level.friendlyfire["friend_kill_points"] = -250;
  thread van_scene_cleanup();
  thread fan_spin();
  thread init_cp_5_doors();
  thread pre_office_door_open();
  thread vo_juggernaut_back_room_nag();
  thread juggernaut_fx();
  thread juggernaut_save();
  thread juggernaut_fake_door_cursor_hint();
  thread juggernaut_lighting_setup();
  juggernaut_intro_scene();
  scripts\sp\player_death::clear_custom_death_quote();
  var_1 = [97, 98, 73, 75];
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize(var_1)[0]);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  level.friendlyfire["friend_kill_points"] = var_0;
  scripts\sp\player_death::clear_custom_death_quote();
  thread juggernaut_post_death_cleanup();
  scripts\engine\utility::flag_wait("pre_office_door_flag");
}

function van_scene_cleanup() {
  if(isDefined(level.nikolai)) {
    level.nikolai scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    level.nikolai delete();
  }

  if(isDefined(level.nikolai_van) && isDefined(level.nikolai_van.extras)) {
    scripts\engine\utility::array_delete(level.nikolai_van.extras);
  }

  if(isDefined(level.nikolai_van)) {
    level.nikolai_van delete();
    return;
  }
}

function juggernaut_fake_door_cursor_hint() {
  var_0 = scripts\engine\utility::getStruct("jugg_door_struct", "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE", 45, 200, 55, 1);
  level waittill("jugg_started");
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function fan_spin() {
  level endon("reached_final_room");
  var_0 = 0.1 + randomfloatrange(0.3, 1.1);
  var_1 = getEnt("spinning_fan", "targetname");

  for(;;) {
    var_1 rotatepitch(360, var_0);
    wait var_0;
  }
}

function juggernaut_post_death_cleanup() {
  setsaveddvar("player_meleeFinisherEnabled", 1);
  scripts\engine\utility::delaythread(0.5, &post_jugg_allies_plant_bombs);
  scripts\engine\utility::delaythread(0.1, &juggernaut_allies_cleanup);
  wait 2.5;

  foreach(var_1 in getaiarray("allies")) {
    var_1.dontmelee = undefined;
  }
}

function post_jugg_allies_plant_bombs() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getnodearray("post_jugg_nodes", "script_noteworthy");

  foreach(var_6 in level.jugg_allies) {
    if(isDefined(var_6) && isalive(var_6)) {
      if(!isDefined(var_0)) {
        var_0 = var_6;
        var_6.animname = "jugg_ally1";
        var_7 = scripts\engine\utility::getStruct("post_jugg_plant1", "targetname");
        var_8 = scripts\engine\utility::getStruct("post_jugg_plant2", "targetname");
        thread post_jugg_plant_ally(var_6, [var_7, var_8], var_4[0]);
        continue;
      }

      if(!isDefined(var_1)) {
        var_1 = var_6;
        var_6.animname = "jugg_ally2";
        var_7 = scripts\engine\utility::getStruct("post_jugg_plant3", "targetname");
        var_8 = scripts\engine\utility::getStruct("post_jugg_plant4", "targetname");
        thread post_jugg_plant_ally(var_6, [var_7, var_8], var_4[1]);
        continue;
      }

      if(!isDefined(var_2)) {
        var_2 = var_6;
        var_6 scripts\engine\utility::delaythread(1.2, &post_jugg_ally_node, "post_jugg_node3");
        continue;
      }

      if(!isDefined(var_3)) {
        var_3 = var_6;
        var_6 scripts\engine\utility::delaythread(1.6, &post_jugg_ally_node, "post_jugg_node4");
      }
    }
  }

  var_10 = cos(70);

  if(!isDefined(var_0)) {
    var_0 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_4");
    var_0.animname = "jugg_ally1";
    var_7 = scripts\engine\utility::getStruct("post_jugg_plant1", "targetname");
    var_8 = scripts\engine\utility::getStruct("post_jugg_plant2", "targetname");
    var_11 = scripts\engine\utility::getStruct("jugg_extra1", "targetname");
    var_12 = getEnt("t2_parking_vol", "targetname");

    if(scripts\engine\utility::within_fov(var_11.origin, var_11.angles, level.player getEye(), var_10) && scripts\engine\trace::ray_trace_passed(var_11.origin, level.player getEye(), [level.player])) {
      var_11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    } else if(var_0 istouching(var_12)) {
      var_11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    }

    var_0 forceteleport(var_11.origin, var_11.angles);
    thread post_jugg_plant_ally(var_0, [var_7, var_8], var_4[0]);
  }

  if(!isDefined(var_1)) {
    wait 1;
    var_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_5");
    var_1.animname = "jugg_ally2";
    var_7 = scripts\engine\utility::getStruct("post_jugg_plant3", "targetname");
    var_8 = scripts\engine\utility::getStruct("post_jugg_plant4", "targetname");
    var_11 = scripts\engine\utility::getStruct("jugg_extra1", "targetname");
    var_12 = getEnt("t2_parking_vol", "targetname");

    if(scripts\engine\utility::within_fov(var_11.origin, var_11.angles, level.player getEye(), var_10) && scripts\engine\trace::ray_trace_passed(var_11.origin, level.player getEye(), [level.player])) {
      var_11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    } else if(var_1 istouching(var_12)) {
      var_11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    }

    var_1 forceteleport(var_11.origin, var_11.angles);
    thread post_jugg_plant_ally(var_1, [var_7, var_8], var_4[1]);
    return;
  }
}

function post_jugg_ally_node(var_0) {
  self notify("became_ally");
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
}

function post_jugg_plant_ally(var_0, var_1, var_2) {
  self endon("death");
  wait var_2;
  var_0 = sortbydistance(var_0, self.origin);
  var_3 = var_0[0];
  self notify("became_ally");
  self.goalradius = 4;
  self setgoalpos(var_3.origin);
  var_4 = squared(100);

  for(;;) {
    var_5 = distance2dsquared(self.origin, var_3.origin);

    if(var_5 <= var_4) {
      break;
    }

    wait 0.1;
  }

  var_3 scripts\sp\anim::anim_reach_and_arrive(self, "cp_4_plant");
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\lab\lab_offices::rebel_plant_bomb, var_3);
  self attach("offhand_wm_c4_bomb", "tag_accessory_right");
  var_3 scripts\common\anim::anim_single_solo(self, "cp_4_plant");
  var_3 = var_0[1];
  self setgoalpos(var_3.origin);

  for(;;) {
    var_5 = distance2dsquared(self.origin, var_3.origin);

    if(var_5 <= var_4) {
      break;
    }

    wait 0.1;
  }

  var_3 scripts\sp\anim::anim_reach_and_arrive(self, "cp_4_plant");
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\lab\lab_offices::rebel_plant_bomb, var_3);
  self attach("offhand_wm_c4_bomb", "tag_accessory_right");
  var_3 scripts\common\anim::anim_single_solo(self, "cp_4_plant");
  self setgoalnode(var_1);
}

function juggernaut_allies_cleanup() {
  level scripts\engine\sp\utility::notify_delay("stop_jugg_smoke", 0.1);
  level.player setthreatbiasgroup("allies");
  scripts\engine\utility::flag_clear("pause_rebel_respawning");

  foreach(var_1 in level.heroes) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\common\utility::clear_movement_speed();

    if(!isDefined(var_1.magic_bullet_shield)) {
      var_1.attackeraccuracy = 1;

      if(isDefined(var_1.og_health)) {
        var_1.health = var_1.og_health;
      }
    }
  }
}

function init_cp_5_doors() {
  wait 0.1;
  var_0 = getEntArray("cp_5_doors", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("chokepoint_5_animnode", "targetname");

  foreach(var_3 in var_0) {
    scripts\sp\maps\lab\lab_util::assign_door_ents(var_3);
    var_3.animname = var_3.targetname;
    var_3 scripts\engine\sp\utility::assign_animtree();
    var_3.collision connectpaths();
  }

  var_1 scripts\common\anim::anim_first_frame(var_0, "cp_5_juggernaut");
  wait 0.05;

  foreach(var_3 in var_0) {
    var_3.collision disconnectPaths();
  }
}

function juggernaut_fx() {
  scripts\engine\utility::flag_wait("turbines_clear");
  wait 0.5;
  scripts\engine\utility::exploder("doorsmoke");
}

function juggernaut_intro_fx() {
  var_0 = scripts\engine\utility::getStruct("juggernaut_smoke_1", "targetname");
  var_1 = spawnfx(level._effect["vfx_smoke_gren_start"], var_0.origin);
  triggerfx(var_1);
  var_2 = spawnfx(level._effect["vfx_smoke_gren_loop"], var_0.origin);
  triggerfx(var_2);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  var_1 delete();
  var_2 delete();
}

function vo_juggernaut_back_room_nag() {
  level endon("jugg_started");
  level.farah waittill("goal");
  var_0 = ["dx_vom_far_dragons_breath_clear_40", "dx_vom_far_dragons_breath_clear_50", "dx_vom_far_dragons_breath_clear_60", "dx_vom_far_dragons_breath_clear_70"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    scripts\engine\utility::flag_wait("in_turbine_room");
    wait 6;
    level.farah scripts\sp\maps\lab\lab_vo_util::nagtill_open("in_turbine_room", var_1, 12, 2, 1.2, 1.2, 45);
  }
}

function vo_juggernaut() {
  scripts\engine\utility::flag_wait("jugg_started");
  wait 0.1;
  GscBinSkip4(0x35);
}

function t2_combat_nags() {
  if(scripts\engine\utility::flag("turbines_clear")) {
    return;
  }

  level endon("turbines_clear");
  var_0 = ["dx_vom_lff1_juggernaut_allies_80", "dx_vom_lff1_juggernaut_allies_50", "dx_vom_lff1_juggernaut_allies_60"];
  var_1 = ["dx_vom_lff2_juggernaut_allies_210", "dx_vom_lff2_juggernaut_allies_170", "dx_vom_lff2_juggernaut_allies_180"];
  var_2 = [scripts\engine\sp\utility::create_deck(var_0), scripts\engine\sp\utility::create_deck(var_1)];
  var_3 = 0;

  for(;;) {
    wait randomfloatrange(2, 4);

    if(getaiarray("axis").size == 0 || scripts\engine\utility::flag("fire_suppression_active")) {
      continue;
    }

    var_4 = [];

    foreach(var_6 in getaiarray("allies")) {
      if(isalive(var_6) && var_6.voice == "fsafemale" && var_6 != level.farah) {
        var_4 = var_6;
      }
    }

    if(var_4.size == 0) {
      continue;
    }

    var_8 = scripts\engine\utility::getclosest(level.player.origin, var_4);

    if(!isDefined(var_8.nag_id)) {
      var_8.nag_id = var_3;
      var_3 = !var_3;
    }

    var_8 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_2[var_8.nag_id] scripts\engine\sp\utility::deck_draw());
    wait randomfloatrange(8, 10);
  }
}

function jugg_combat_nags() {
  if(scripts\engine\utility::flag("juggernaut_dead")) {
    return;
  }

  level endon("juggernaut_dead");
  var_0 = ["dx_vom_lff1_juggernaut_allies_80", "dx_vom_lff1_juggernaut_allies_70", "dx_vom_lff1_juggernaut_allies_40"];
  var_1 = ["dx_vom_lff2_juggernaut_allies_210", "dx_vom_lff2_juggernaut_allies_200", "dx_vom_lff2_juggernaut_allies_190"];
  var_2 = [scripts\engine\sp\utility::create_deck(var_0), scripts\engine\sp\utility::create_deck(var_1)];
  var_0 = ["dx_vom_lff1_juggernaut_allies_90", "dx_vom_lff1_juggernaut_allies_100", "dx_vom_lff1_juggernaut_allies_110", "dx_vom_lff1_juggernaut_allies_120"];
  var_1 = ["dx_vom_lff2_juggernaut_allies_220", "dx_vom_lff2_juggernaut_allies_230", "dx_vom_lff2_juggernaut_allies_240", "dx_vom_lff2_juggernaut_allies_250"];
  var_3 = [scripts\engine\sp\utility::create_deck(var_0), scripts\engine\sp\utility::create_deck(var_1)];
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    wait randomfloatrange(2, 4);

    if(getaiarray("axis").size == 0 || scripts\engine\utility::flag("fire_suppression_active")) {
      continue;
    }

    var_6 = [];

    foreach(var_8 in getaiarray("allies")) {
      if(isalive(var_8) && var_8.voice == "fsafemale" && var_8 != level.farah) {
        var_6 = var_8;
      }
    }

    if(var_6.size == 0) {
      continue;
    }

    var_10 = scripts\engine\utility::getclosest(level.player.origin, var_6);

    if(!isDefined(var_10.nag_id)) {
      var_10.nag_id = var_5;
      var_5 = !var_5;
    }

    if(var_4) {
      var_10 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_2[var_10.nag_id] scripts\engine\sp\utility::deck_draw());
    } else {
      var_10 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_3[var_10.nag_id] scripts\engine\sp\utility::deck_draw());
    }

    var_4 = !var_4;
    wait randomfloatrange(8, 10);
  }
}

function post_jugg_nags() {
  level endon("post_jugg_reached_farah");
  wait 16;
  var_0 = ["dx_vom_far_juggernaut_outro_41", "dx_vom_far_juggernaut_outro_42"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  level.farah scripts\sp\maps\lab\lab_vo_util::nagtill(undefined, var_1, 12, 2, 1.5, 1.2, 45, 5);
}

function vo_juggernaut_kills() {
  level.juggernaut_1 endon("death");
  var_0 = 0;
  var_1 = getaiarray("allies");
  var_2 = var_1.size + 1;
  var_3 = ["dx_vom_jugg_juggernaut_shootplayer_40", "dx_vom_jugg_juggernaut_shootplayer_50"];
  var_4 = scripts\engine\sp\utility::create_deck(var_3);

  for(;;) {
    level waittill("ai_killed", var_5, var_6);

    if(!scripts\engine\utility::is_equal(level.juggernaut_1, var_6)) {
      continue;
    }

    var_0++;

    if(var_0 == 1) {
      level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_jugg_juggernaut_killfighter_10");
      continue;
    }

    if(level.jugg_allies.size == 1) {
      level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_jugg_juggernaut_killfighter_20");
      continue;
    }

    level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_4 scripts\engine\sp\utility::deck_draw());
  }
}

function vo_juggernaut_damage() {
  level.juggernaut_1 endon("death");
  var_0 = -1;
  var_1 = -1;
  var_2 = level.juggernaut_1.maxhealth;
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "dx_vom_jugg_juggernaut_shootjug_highhealth_10");
}

function vo_juggernaut_fire() {
  level.juggernaut_1 endon("death");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_jugg_juggernaut_shootplayer_10");
}

function juggernaut_intro_scene() {
  scripts\engine\utility::flag_wait("turbines_clear");
  var_0 = scripts\engine\utility::getStruct("t2_end_obj_struct", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("cp_5_juggernaut_start") && scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var_0.origin)) {
      break;
    }

    waitframe();
  }

  setmusicstate("mx_lab_jugg_combat");
  setsaveddvar("player_meleeFinisherEnabled", 0);
  thread juggernaut_allies_setup();
  juggernaut_spawn();
  var_1 = getEntArray("cp_5_doors", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("chokepoint_5_animnode", "targetname");
  var_3 = scripts\engine\utility::array_combine([level.juggernaut_1], var_1);
  var_2 thread scripts\common\anim::anim_first_frame_solo(level.juggernaut_1, "cp_5_juggernaut");

  foreach(var_5 in getaiarray("allies")) {
    var_5.dontmelee = 1;
  }

  scripts\engine\utility::flag_set("jugg_started");
  thread juggernaut_intro_fx();

  if(isDefined(level.player) && level.player.health > 40) {
    level.player scripts\engine\utility::delaythread(0.5, &scripts\sp\utility::do_damage, 25, level.juggernaut_1.origin, level.juggernaut_1);
  }

  level.player allowmelee(0);
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  var_2 scripts\sp\player_rig::link_player_to_rig("cp_5_juggernaut", "stand", undefined, 0, 0, 0, 0, 0, 0);
  setup_detonator();
  thread juggernaut_scene_setup();
  thread juggernaut_door_anims(var_2, var_1);
  level.jugg_detonator scripts\engine\utility::delaythread(2.5, &fake_jugg_detonator_lights_off);
  scripts\sp\utility::delete_live_grenades();
  thread stop_player_anim_on_death();
  clearallcorpses();
  var_2 thread scripts\common\anim::anim_single_solo(level.juggernaut_1, "cp_5_juggernaut");
  var_2 scripts\common\anim::anim_single([level.player_rig, level.jugg_detonator], "cp_5_juggernaut");
  level.jugg_detonator delete();
  scripts\sp\player_rig::unlink_player_from_rig();
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  level.player allowmelee(1);
  level notify("jugg_anim_over");
  level.juggernaut_1.ignoreall = 0;
  level.juggernaut_1.dontevershoot = 0;
  level.juggernaut_1 setthreatbiasgroup("juggernaut");
  createnavrepulsor("juggernaut", -1, level.juggernaut_1, 300, 1, "allies", "neutral");
  level.player setthreatbiasgroup("player");
  scripts\engine\sp\utility::activate_trigger_with_targetname("juggernaut_retreat");
  scripts\engine\utility::flag_set("screens_offices");
}

function fake_jugg_detonator_lights_off(var_0) {
  self endon("entitydeleted");
  var_1 = [0.3, 0.2, 0.2, 0.4, 0.2, 0.5, 0.3, 0.2, 0.4, 0.2, 0.3, 0.3, 0.3, 0.2, 0.2, 0.4];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    wait var_1[var_2];
    self setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed_off");
    var_2++;
    wait var_1[var_2];
    self setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed");
  }
}

function stop_player_anim_on_death() {
  level.player endon("jugg_anim_over");
  level.player waittill("death");
  level.player stopanimScripted();

  if(isDefined(level.player_rig)) {
    level.player_rig stopanimScripted();
    return;
  }
}

function juggernaut_scene_setup() {
  thread jugg_cowbell();
  thread juggernaut_player_adjustment();
  scripts\engine\utility::delaythread(0.2, &allies_move_away);
  scripts\engine\utility::delaythread(0.2, &allies_juggernaut_spawn);
  scripts\engine\utility::delaythread(0.5, &juggernaut_lighting);
}

function juggernaut_lighting_setup() {
  var_0 = getEntArray("jugg_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  var_2 = getEnt("jugg_lights_02", "targetname");
  var_2.og_intensity = var_2 getlightintensity();
  var_2 setlightintensity(0);
}

function juggernaut_lighting() {
  var_0 = getEntArray("jugg_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(var_2.og_intensity);
  }

  var_2 = getEnt("jugg_lights_02", "targetname");
  var_2 setlightintensity(var_2.og_intensity);
  level waittill("jugg_anim_over");
  var_0 = getEntArray("jugg_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }
}

function juggernaut_door_anims(var_0, var_1) {
  var_0 scripts\common\anim::anim_single(var_1, "cp_5_juggernaut");

  foreach(var_3 in var_1) {
    var_3.collision connectpaths();
    var_3.collision disconnectPaths();
  }
}

function juggernaut_player_adjustment() {
  if(level.gameskill == 3) {
    level.player scripts\sp\player::set_player_max_health(120);
    scripts\engine\utility::flag_wait("juggernaut_dead");
    level.player scripts\sp\player::set_player_max_health(level.player.maxhealth);
    return;
  }
}

function juggernaut_allies_setup() {
  scripts\engine\utility::flag_set("pause_rebel_respawning");

  foreach(var_1 in level.heroes) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\engine\utility::set_movement_speed(250);

    if(!isDefined(var_1.magic_bullet_shield)) {
      var_2 = 10;
      var_1.og_health = var_1.health;
      var_1.health = 20;
      var_1.dontmelee = 1;
    }
  }
}

function juggernaut_spawn() {
  level.juggernaut_1 = scripts\engine\sp\utility::spawn_targetname("juggernaut_1", 1);
  jugg_init(level.juggernaut_1);
  jugg_state_init(level.juggernaut_1);
  thread monitor_player_movement();
}

function jugg_init() {
  level.juggernaut_1.health = 4000;
  self.damage_functions[self.damage_functions.size] = &jugg_dmg_modifier;
  thread scripts\engine\sp\utility::flag_on_death("juggernaut_dead");
  thread custom_combat_jugg();
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.skip_intro_sound = 1;
  self.stuncooldown = 0;
  self.animname = "juggernaut_1";
  self.attackeraccuracy = 0.1;
  self.minpaindamage = 1000;
  self.minpainvalue = 1000;
  self.og_maxsightdistsqr = self.maxsightdistsqrd;
  self.og_maxvis = self.maxvisibledist;
  self.og_radius = self.juggernautgoalradius;
  self.runcooldown = 2000;
  self.cautiousnavigation = 0;
  self.juggernautwalkdist = 250;
  self.juggernautgoalradius = 25;
  self.goalheight = 25;
  self.juggernautacceleration = 100;
  self.juggernautcanseeenemydelaymin = 500;
  self.juggernautcanseeenemydelaymax = 1000;
  self.juggernautrundelaymin = 250;
  self.juggernautrundelaymax = 750;
  scripts\engine\sp\utility::disable_surprise();

  if(level.gameskill <= 2) {
    self.juggernautstopdistance = 500;
  } else {
    self.juggernautstopdistance = 600;
  }

  level.juggernaut_1.stealth.script_skiplookaroundanim = 1;
  level.juggernaut_1.stealth.script_huntlookaroundduration = 3000;
  level.juggernaut_1.stealth.breacting = "large";
}

function jugg_state_init() {
  self.state = "healthy";
  var_0 = self.maxhealth / 4;
  self.d1_health = var_0 * 3;
  self.d2_health = var_0 * 2;
  self.d3_health = var_0;
  self.d4_health = var_0 * 0.5;
  self.starting_health = self.maxhealth;
  self getenemyinfo(level.player);
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
}

function jugg_dmg_modifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isalive(self)) {
    return;
  }

  self endon("death");

  if(!istrue(self.allowpain) && isDefined(var_9) && scripts\engine\utility::is_equal(getweaponbasename(var_9), "flash")) {
    self.allowpain = 1;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    if(!scripts\engine\utility::is_equal(var_1, level.player)) {
      var_10 = int(var_0 * 0.7);
      self.health += var_10;
    } else if(scripts\engine\utility::is_equal(var_1, level.player)) {
      if(scripts\engine\utility::is_equal(var_4, "MOD_MELEE")) {
        var_10 = int(var_0 * 0.8);
        self.health += var_10;
        self notify("melee_damage_taken");
      }

      if(scripts\engine\utility::is_equal(level.player.currentweapon.basename, "iw8_sh_oscar12")) {
        var_10 = int(var_0 * 0.6);
        self.health += var_10;
      }

      if(isDefined(var_9) && getweaponbasename(var_9) == "iw8_sh_dpapa12_incendiary" && var_4 != "MOD_MELEE") {
        var_11 = int(var_0 * 0.2);

        if(self.health > var_11) {
          self.health -= var_11;
        }
      }
    }
  }

  if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH") {
    if(istrue(self.allowpain) && (!isDefined(var_9) || !scripts\engine\utility::is_equal(var_9.basename, "flash"))) {
      self notify("jugg_stunned");
    }

    self.minpaindamage = 0;

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
      var_12 = var_0 / 2;

      if(var_12 < 50) {
        var_12 = 50;
      } else if(var_12 > 150) {
        var_12 = 100;
      }
    } else {
      var_12 = 25;
    }

    scripts\sp\utility::do_damage(var_12, var_4, var_2);
    self.minpaindamage = self.minpainvalue;
  }

  GscBinSkip4(0x35);
}

function jugg_dam_state_change() {
  switch (self.state) {
    case "healthy":
      if(self.health <= 3500) {
        scripts\engine\utility::flag_set("state_change_busy");
        self.juggernautwalkdist = 350;
        self.juggernautacceleration = 80;
        self.juggernautcanseeenemydelaymin = 750;
        self.juggernautcanseeenemydelaymax = 1500;
        self.juggernautrundelaymin = 500;
        self.juggernautrundelaymax = 1000;
        self.state = "damaged_1";
        thread jugg_rebel_respawn();
      }

      break;
    case "damaged_1":
      if(self.health <= 2500) {
        scripts\engine\utility::flag_set("state_change_busy");
        self.runcooldown = 3000;
        self.juggernautwalkdist = 500;
        self.juggernautacceleration = 50;
        self.cautiousnavigation = 1;
        self.disablerunngun = 0;
        self.state = "damaged_2";
        thread jugg_rebel_respawn();
        scripts\engine\sp\utility::autosave_by_name("jugg_damage_save");
      }

      break;
    case "damaged_2":
      if(self.health < 1000) {
        scripts\engine\utility::flag_set("state_change_busy");
        self.runcooldown = 4000;
        self.juggernautwalkdist = 600;
        self.juggernautacceleration = 40;
        self.aggressivemode = 0;
        self.state = "near_dead";
        thread jugg_rebel_respawn();
      }

      break;
  }

  if(scripts\engine\utility::flag("state_change_busy")) {
    scripts\engine\utility::flag_clear("state_change_busy");
    return;
  }
}

function debug_state_print(var_0) {
  if(getdvarint("scr_jugg_debug")) {
    iprintln("State: " + self.state + " -- health: " + self.health + " -- range: < " + var_0);
    return;
  }
}

function jugg_rebel_respawn() {
  if(!isalive(self)) {
    return;
  }

  var_0 = self.state;
  var_1 = 1;

  while(isalive(self) && var_0 == self.state) {
    var_2 = 0;
    level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);

    if(var_1 && isDefined(level.jugg_allies) && level.jugg_allies.size < 3) {
      var_2 = 1;
    }

    var_1 = 0;

    if(!var_2 && isDefined(level.jugg_allies) && !level.jugg_allies.size) {
      wait 7;

      if(!isalive(self) || var_0 != self.state) {
        return;
      }

      var_2 = 1;
    }

    if(var_2) {
      var_3 = getspawnerarray("jugg_ally_respawn");
      var_4 = var_3[randomintrange(0, 1)];
      var_5 = var_4 scripts\engine\sp\utility::spawn_ai(1);
      var_6 = get_rebel_spawn_struct();
      var_5 teleport(var_6.origin, var_6.angles);
      level.jugg_allies[level.jugg_allies.size] = var_5;
      var_4.count += 1;
      wait 0.1;
      var_7 = getEnt("t2_jugg_fallback", "targetname");
      var_5 setgoalvolumeauto(var_7);
      var_5.fixednode = 0;
    }

    waitframe();
  }
}

function get_rebel_spawn_struct() {
  var_0 = getEnt("t2_parking_vol", "targetname");
  var_1 = undefined;

  if(level.player istouching(var_0)) {
    var_2 = scripts\engine\utility::getStructArray("t2_inside_spawn", "targetname");
  } else {}

  for(var_2 = scripts\engine\utility::getStructArray("t2_parking_spawn", "targetname"); !isDefined(var_2); var_2 = var_2[0]) {
    if(var_2.size <= 1) {
      var_2 = var_2[0];
      break;
    }

    var_2 = sortbydistance(var_2, level.player.origin);

    if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos15, var_2[0].origin)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[0]);
      continue;
    }
  }

  return var_2;
}

function can_weapon_stun_juggernaut(var_0, var_1) {
  if(var_0 == level.player) {
    if(scripts\engine\utility::is_equal(getweaponbasename(var_1), "iw8_sh_dpapa12_incendiary")) {
      return true;
    }
  }

  return false;
}

function juggernaut_pain_cooldown() {
  for(;;) {
    self waittill("jugg_stunned");
    self.stuncooldown = 1;
    self.allowpain = 0;
    wait 7;
    self.stuncooldown = 0;
    self.allowpain = 1;
  }
}

function juggernaut_fire_suppression() {
  var_0 = getEnt("fire_suppression", "targetname");
  thread juggernaut_fire_suppression_setup();
}

function juggernaut_fire_suppression_setup() {
  var_0 = [];
  GscBinSkip0(0x2e, "trigger", self);
}

function fire_suppression_logic() {
  var_0 = ["dx_vom_jugg_juggernaut_halon_10", "dx_vom_jugg_juggernaut_halon_20", "dx_vom_jugg_juggernaut_halon_30", "dx_vom_jugg_juggernaut_halon_40"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_lff1_juggernaut_allies_10", "dx_vom_lff1_juggernaut_allies_20", "dx_vom_lff1_juggernaut_allies_30"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_jugg_juggernaut_explosion_dmg_10", "dx_vom_jugg_juggernaut_explosion_dmg_20", "dx_vom_jugg_juggernaut_explosion_dmg_30", "dx_vom_jugg_juggernaut_explosion_dmg_40"];
  var_3 = scripts\engine\sp\utility::create_deck(var_0);
  scripts\engine\utility::flag_clear("fire_suppression_active");
  fire_suppression_button_on();
  scripts\engine\utility::waittill_any_ents_array(self["buttons"], "trigger");
  scripts\engine\utility::flag_set("fire_suppression_active");
  level.fs_systemactive = 1;
  var_4 = scripts\engine\utility::getclosest(level.player.origin, self["buttons"]);
  GscBinSkip4(0x6e, var_4, "lab_vm_button_push_plr_c");
}

function reset_all_ai_sight() {
  var_0 = getaiarray();

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(isDefined(var_2.og_maxvis)) {
      var_2 scripts\engine\sp\utility::set_maxvisibledist(var_2.og_maxvis);
    }

    if(isDefined(var_2.og_maxsightdistsqr)) {
      var_2 scripts\engine\sp\utility::set_maxsightdistsquared(var_2.og_maxsightdistsqr);
    }
  }
}

function play_fire_system_sound(var_0) {
  var_1 = getEntArray("turbines_speakers", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  var_2 scripts\engine\utility::playsoundonentity(var_0);
}

function play_button_sound(var_0) {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  scripts\engine\utility::play_sound_in_space(var_0, self.origin);
}

function play_fire_system_sound_loop(var_0, var_1) {
  var_2 = 0;

  if(var_2 < var_1) {
    GscBinSkip4(0x35, var_0);
  }
}

function play_smoke_start_sounds() {
  var_0 = scripts\engine\utility::getStructArray("fire_system_structs", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3 = spawn("script_origin", var_3.origin);
    var_3.angles = (0, 0, 0);
    var_1 = var_3;
    var_3 childthread scripts\engine\sp\utility::play_sound_on_entity("fire_system_start");
    var_3 childthread scripts\engine\utility::play_loop_sound_on_entity("fire_system_hiss");
  }

  wait 19;
  scripts\engine\utility::array_delete(var_1);
}

function fire_suppression_jugg_vo(var_0, var_1) {
  level endon("juggernaut_dead");
  wait 1;
  level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_0 scripts\engine\sp\utility::deck_draw(), 1);
  wait 0.5;
  var_2 = getaiarray("allies");
  var_3 = scripts\engine\utility::getclosest(level.player.origin, var_2);
  var_3 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 1, 0.5);
}

function fire_suppression_button_on() {
  foreach(var_1 in self["models"]) {
    var_1 setModel("electrical_cell_door_button_green");
  }

  foreach(var_1 in self["buttons"]) {
    var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), undefined, 220, 350, 80, 0);
    thread button_interaction_thread(var_1);
  }
}

function button_interaction_thread(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  var_2 = spawn("script_origin", self.origin);
  var_2.origin += rotatevector(var_0, self.angles);

  while(isDefined(self)) {
    if(door_check_base(var_2) && level.player ismeleeing()) {
      thread scripts\sp\door_internal::bashed_locked_door_sfx();
      level.player viewkick(10, var_2.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player playRumbleOnEntity("heavy_1s");
      self notify("trigger");
      break;
    }

    waitframe();
  }
}

function fire_suppression_button_off() {
  foreach(var_1 in self["buttons"]) {
    if(isDefined(var_1.cursor_hint_ent)) {
      var_1 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
  }

  foreach(var_1 in self["models"]) {
    var_1 setModel("electrical_cell_door_button_red");
  }
}

function fire_suppression_fx_on() {
  scripts\engine\utility::exploder("jugg_gas");
  thread fog_fx_check("t2_fog_vol", "jugg_gas_screen");
  visionsetnaked("lab_interior_turbines_dark_fog", 3.2);
  thread player_in_trigger(self["trigger"]);
  level thread scripts\engine\sp\utility::notify_delay("fire_system_clear", 20);
  level scripts\engine\utility::waittill_any("player_is_out_of_trigger", "fire_system_clear");
  level notify("end_vision_change");
  visionsetnaked("", 4);
  scripts\engine\utility::stop_exploder("jugg_gas");
}

function player_in_trigger(var_0) {
  level endon("end_vision_change");
  wait 0.1;

  while(level.player istouching(var_0)) {
    waitframe();
  }

  level notify("player_is_out_of_trigger");
}

function ai_fire_suppression_postspawn() {
  self endon("death");

  if(level.fs_systemactive) {
    GscBinSkip4(0x35);
  }

  var_0 = getaiarray("allies");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0);
  self getenemyinfo(var_1);
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
}

function ai_fire_suppression_logic() {
  self endon("death");
  level endon("fire_system_clear");
  self.og_maxvis = self.maxvisibledist;
  self.og_maxsightdistsqr = self.maxsightdistsqrd;
  var_0 = 100;
  scripts\engine\sp\utility::set_maxvisibledist(var_0);
  scripts\engine\sp\utility::set_maxsightdistsquared(var_0 * var_0);
  self clearenemy();
  wait 0.2;
  var_1 = scripts\engine\utility::waittill_any_timeout(19, "damage", "player_flash", "player_frag", "player_fired_weapon");
  scripts\engine\sp\utility::set_maxvisibledist(self.og_maxvis);
  scripts\engine\sp\utility::set_maxsightdistsquared(self.og_maxsightdistsqr);
}

function juggernaut_fire_suppression_logic(var_0, var_1) {
  var_0 endon("death");
  GscBinSkip4(0x6e, var_0, self);
}

function juggernaut_vision_obstructed(var_0) {
  self.juggernautvisionobscured = 1;
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0["fs_targets"]);
  var_2 = 100;
  scripts\engine\sp\utility::set_maxvisibledist(var_2);
  scripts\engine\sp\utility::set_maxsightdistsquared(var_2 * var_2);
  self clearenemy();
  level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);

  if(level.jugg_allies.size >= 1) {
    new_jugg_enemy();
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    return;
  }

  scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
}

function new_jugg_enemy() {
  level endon("fire_system_clear");
  level endon("jugg_alerted");
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);

  while(level.fs_systemactive) {
    level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);
    level.jugg_allies = scripts\engine\utility::array_removedead_or_dying(level.jugg_allies);

    if(!isDefined(level.jugg_allies) || level.jugg_allies.size < 1) {
      break;
    }

    var_0 = scripts\engine\utility::getclosest(self.origin, level.jugg_allies);
    self getenemyinfo(var_0);
    scripts\engine\sp\utility::set_favoriteenemy(var_0);
    var_0 scripts\engine\sp\utility::set_favoriteenemy(self);
    var_0 waittill("death");
    self clearentitytarget();
  }
}

function juggernaut_player_fired(var_0) {
  self endon("jugg_alerted");
  level.player waittill("weapon_fired");
  self notify("player_fired_weapon");
}

function juggernaut_vision_restored() {
  if(isDefined(self.favoriteenemy) && self.favoriteenemy != level.player) {
    self.juggernautforcewalk = 1;
  }

  thread juggernaut_finish_vision_restore();
}

function juggernaut_finish_vision_restore() {
  if(isDefined(self.favoriteenemy) && self.favoriteenemy != level.player) {
    if(!istrue(self.allowstrafe)) {
      wait 1;
    }

    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    wait 2;
  }

  self.juggernautforcewalk = 0;
  self.juggernautvisionobscured = 0;
  scripts\engine\sp\utility::set_maxvisibledist(self.og_maxvis);
  scripts\engine\sp\utility::set_maxsightdistsquared(self.og_maxsightdistsqr);
  level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
}

function monitor_player_movement() {
  level endon("juggernaut_dead");
  var_0 = 0;

  while(isalive(self)) {
    var_1 = scripts\engine\utility::flag("ambush_backtrack");

    if(!var_0 && var_1) {
      GscBinSkip4(0x35);
    }

    if(var_0 && !var_1) {
      GscBinSkip4(0x35);
    }

    var_0 = var_1;
    wait 1;
  }
}

function jugg_hide_logic() {
  level notify("stop_patrolling");
  var_0 = scripts\engine\utility::getStruct("jugg_wait_struct", "script_noteworthy");
  scripts\engine\utility::flag_set("t2_jugg_fallback_2");
  self clearenemy();
  level.player.ignoreme = 1;
  self.grenadeawareness = 0;

  while(isDefined(level.jugg_allies) && level.jugg_allies.size >= 1) {
    level.jugg_allies = scripts\engine\utility::array_removedead_or_dying(level.jugg_allies);
    waitframe();
  }

  self clearenemy();
  level.jugg_goal = var_0 scripts\engine\utility::spawn_script_origin(var_0.origin + (0, 0, 20));
  level.jugg_goal makeentitysentient("allies");
  self getenemyinfo(level.jugg_goal);
  scripts\engine\sp\utility::set_favoriteenemy(level.jugg_goal);
  thread scripts\sp\spawner::go_to_node(var_0);

  while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin)) {
    waitframe();
  }

  while(scripts\engine\utility::flag("ambush_backtrack")) {
    self teleport(var_0.origin, var_0.angles);
    waitframe();
  }
}

function start_jugg_patroll() {
  level notify("stop_patrolling");
  self.grenadeawareness = 1;
  level.player.ignoreme = 0;
  self setgoalpos(self.origin);

  if(isDefined(level.jugg_goal)) {
    level.jugg_goal delete();
  }

  self clearenemy();
  scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
}

function jugg_patroll_logic() {
  level endon("stop_patrolling");

  if(scripts\engine\utility::flag("ambush_backtrack")) {
    return;
  }

  self clearenemy();

  for(;;) {
    var_0 = scripts\engine\utility::getStructArray("jugg_patroll_structs", "targetname");
    self setgoalpos(self.origin);
    var_1 = select_jugg_node(var_0);
    thread player_spotted_thread();
    childthread scripts\sp\spawner::go_to_node(var_1);

    while(distance2dsquared(self.origin, var_1.origin) > 900) {
      waitframe();
    }

    waitframe();
  }
}

function player_spotted_thread() {
  level endon("stop_patrolling");

  for(;;) {
    if(jugg_sight_check()) {
      self.juggernautforcewalk = 0;
      level notify("stop_patrolling");
      break;
    }

    waitframe();
  }
}

function select_jugg_node(var_0) {
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);
  var_2 = scripts\engine\utility::getclosest(self.origin, var_0);
  var_0 scripts\engine\utility::array_remove_array(var_0, [var_1, var_2]);

  if(isDefined(self.current_node)) {
    scripts\engine\utility::array_remove(var_0, self.current_node);
  }

  self.current_node = undefined;
  var_0 = sortbydistance(var_0, level.player.origin);
  var_3 = 2;
  var_4 = 6;
  var_5 = var_0[randomintrange(var_3, var_4)];
  self.current_node = var_5;
  return var_5;
}

function jugg_can_see_player(var_0) {
  if(!jugg_sight_check()) {
    self clearenemy();
    self.goal_radius = 80;
    scripts\sp\spawner::go_to_node(var_0);
    return;
  }

  level notify("stop_patrolling");
}

function jugg_sight_check() {
  var_0 = level.player getEye();
  return scripts\engine\utility::within_fov(self getEye(), self.angles, var_0, level.cos30) && scripts\engine\trace::ray_trace_passed(self getEye(), var_0, [self, level.player]);
}

function setup_detonator() {
  level.jugg_detonator = spawn("script_model", level.player.origin);
  level.jugg_detonator setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed");
  level.jugg_detonator scripts\engine\sp\utility::assign_animtree("cp_5_detonator");
  level.jugg_detonator scripts\engine\utility::delaythread(3, &det_sparks_vfx);
}

function det_sparks_vfx() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_clacker_sparks"), self, "tag_origin");
}

function allies_move_away() {
  GscBinSkip4(0x6e, level.farah);
}

function ai_move_away(var_0) {
  level endon("juggernaut_dead");

  if(isDefined(self.my_spawner)) {
    self.my_spawner notify("stop_rebel_flood");
  }

  self notify("entitydeleted");

  if(isDefined(var_0)) {
    var_1 = am_i_alive(var_0);
  } else {
    var_1 = self;
  }

  if(!isDefined(var_1)) {
    return;
  }

  var_1 scripts\engine\sp\utility::disable_ai_color();
  var_1 clearpath();
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_2 = getnode("offices_hold_" + var_1.animname, "targetname");
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_1 setgoalnode(var_2);
  waitframe();

  if(!isDefined(var_1)) {
    return;
  }

  var_1 allowedstances("stand");
  var_1 scripts\anim\notetracks_sp::setpose("stand");
  var_1 scripts\sp\maps\lab\lab_util::magic_bullet_safe();
}

function am_i_alive(var_0) {
  if(isDefined(self)) {
    return self;
  }

  self notify("entitydeleted");
  self notify("stop_rebel_flood");
  var_1 = undefined;

  switch (var_0) {
    case "rebel_1":
      level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
      level.heroes[level.heroes.size] = level.rebel_1;
      getspawner("redshirt_rebel_1", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_1, 1);
      var_1 = level.rebel_1;
      break;
    case "rebel_2":
      level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
      level.heroes[level.heroes.size] = level.rebel_2;
      getspawner("redshirt_rebel_2", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_2, 1);
      var_1 = level.rebel_2;
      break;
  }

  return var_1;
}

function allies_juggernaut_spawn() {
  scripts\engine\utility::flag_clear("jugg_approach");
  level.jugg_allies = [];
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("jugg_ally", 1, 1);
  scripts\engine\utility::array_thread(var_0, &allies_juggernaut_setup);

  if(isDefined(level.rebel_3)) {
    level.rebel_3 delete();
  }

  self endon("became_ally");
  scripts\engine\utility::flag_wait("jugg_approach");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("jugg_ally_flee", 1, 1);
  scripts\engine\utility::array_thread(var_0, &allies_juggernaut_flee);
  thread jugg_rebel_respawn();
  GscBinSkip4(0x35, level.juggernaut_1);
}

function allies_fallback_thread() {
  var_0 = getEnt("t2_jugg_fallback", "targetname");
  scripts\engine\utility::flag_wait("t2_jugg_fallback_2");

  foreach(var_2 in level.jugg_allies) {
    var_2 scripts\engine\sp\utility::disable_ai_color();
    var_2 setgoalvolumeauto(var_0);
    var_2.fixednode = 0;
  }
}

function allies_juggernaut_setup() {
  self endon("death");
  level.jugg_allies[level.jugg_allies.size] = self;
  thread scripts\sp\maps\lab\lab_util::laser_discipline();
  self.fixednode = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  wait 4;
  self getenemyinfo(level.juggernaut_1);
  level.juggernaut_1 getenemyinfo(self);
  self.ignoreall = 0;
  self.ignoreme = 0;
  scripts\engine\utility::flag_wait("jugg_approach");
  self.attackeraccuracy = 10;
  self.og_health = self.health;
  self.health = 30;

  while(isDefined(level.juggernaut_1) && !scripts\engine\utility::can_trace_to_ai(self getEye(), level.juggernaut_1)) {
    waitframe();
  }

  self.fixednode = 0;
  scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\sp\utility::set_force_color("b");
}

function allies_juggernaut_flee() {
  self endon("death");
  self endon("became_ally");
  level.jugg_allies[level.jugg_allies.size] = self;
  thread scripts\sp\maps\lab\lab_util::laser_discipline();
}

function custom_combat_jugg() {
  self endon("death");
  GscBinSkip4(0x35);
}

function juggernaut_death_callout_vo() {
  var_0 = [level.player, self];
  self waittill("death");
  var_1 = scripts\engine\utility::spawn_script_origin(self.origin + (0, 0, 50));
  scripts\sp\maps\lab\lab_vo_util::wait_combat_cooldown(0.8, 3);

  if(scripts\sp\maps\lab\lab_util::in_player_fov(cos(75), var_1.origin, var_0)) {
    wait 0.3;
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_juggernaut_outro_10");
  } else {
    wait 0.3;
    level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_juggernaut_outro_11");
  }

  wait 2;
  var_1 delete();
}

function custom_ammo_function() {
  self.disablereload = 1;
  var_0 = self.weapon.clipsize;

  for(;;) {
    self waittill("shooting");

    if(self.bulletsinclip < var_0) {
      self.bulletsinclip = var_0;
    }

    wait 8;
  }
}

function juggernaut_save() {
  level waittill("jugg_started");
  wait 1;

  while(scripts\engine\utility::flag("game_saving")) {
    waitframe();
  }

  var_0 = getEntArray("trigger_multiple_autosave", "classname");

  foreach(var_2 in var_0) {
    var_2 scripts\engine\utility::trigger_off();
  }

  level.dopickyautosavechecks = 1;
  scripts\engine\sp\utility::autosave_by_name("pre_juggernaut_save");

  while(scripts\engine\utility::flag("game_saving")) {
    waitframe();
  }

  level.dopickyautosavechecks = 0;
  scripts\engine\utility::flag_wait("juggernaut_dead");
  scripts\engine\sp\utility::autosave_by_name("post_juggernaut_save");

  foreach(var_2 in var_0) {
    var_2 scripts\engine\utility::trigger_on();
  }
}

function is_jugg_dead() {
  return scripts\engine\utility::flag("juggernaut_dead");
}

function connect_jumpdown_traversal() {
  level endon("juggernaut_dead");
  scripts\engine\utility::flag_wait("player_in_turbine_lower");
  var_0 = getnode("ambush_jumpdown", "script_noteworthy");
  var_1 = getnode("ambush_jumpdown_end", "script_noteworthy");
  createnavlink(var_0.targetname + "_traversal", var_0.origin, var_1.origin, var_0, "axis_combat");
  var_0 = getnode("ambush_jumpdown_c", "script_noteworthy");
  var_1 = getnode("ambush_jumpdown_end_c", "script_noteworthy");
  createnavlink(var_0.targetname + "_traversal", var_0.origin, var_1.origin, var_0, "axis_combat");
}

function disconnect_jumpdown_traversal() {
  var_0 = getnode("ambush_jumpdown_b", "script_noteworthy");
  destroynavlink(var_0);
  var_0 = getnode("ambush_jumpdown_c", "script_noteworthy");
  destroynavlink(var_0);
}

function jugg_cowbell() {
  level.player playSound("scn_lab_juggernaut_door_lr");
  wait 0.2;
  earthquake(0.2, 0.35, level.player.origin, 350);
  level.player playRumbleOnEntity("damage_heavy");
  thread blur_burst();
  scripts\sp\maps\lab\lab_lighting::juggernaut_dof();
}

function push_player() {
  var_0 = level.juggernaut_1;
  var_1 = vectortoangles(var_0.origin - level.player.origin);
  var_2 = anglesToForward(var_1) * -1;
  var_2 *= 100;

  while(length(var_2) > 0.02) {
    self pushplayervector(var_2, 0);
    var_2 *= 0.5;
    wait 0.05;
  }

  wait 0.05;
  self pushplayervector((0, 0, 0), 0);
}

function blur_burst() {
  setblur(2, 0);
  scripts\engine\utility::noself_delaycall(0.15, &setblur, 0, 0);
}

function jugg_stop_anim_monitor() {
  self endon("animation_stop_monitoring");
  self endon("death");
  var_0 = getanimlength(level.player_rig scripts\engine\utility::getanim("cp_5_juggernaut"));
  thread scripts\engine\sp\utility::notify_delay("animation_stop_monitoring", 5);
  GscBinSkip4(0x35);
}

function jugg_anim_monitor_dmg() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_2);

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
      self notify("stop_animation");

      if(isDefined(var_2) && scripts\engine\utility::is_equal(var_2.basename, "flash")) {
        thread flashme();
      }

      return;
    }
  }
}

function flashme() {
  while(self isinscriptedstate()) {
    wait 0.05;
  }

  scripts\anim\combat_utility::flashbangstart(4);
}

function jugg_anim_monitor_dist() {
  var_0 = self.meleechargedistvsplayer;

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= var_0 * var_0) {
      self notify("stop_animation");
      return;
    }

    wait 0.05;
  }
}

function cp_5_fastforward_anim() {
  waitframe();
  var_0 = scripts\engine\utility::getanim("cp_5_juggernaut");
  var_1 = getanimlength(var_0);
  self setanimtime(var_0, 0.37);
}

function juggernaut_debug() {
  if(getdvarint("scr_jugg_debug")) {
    thread scripts\sp\maps\lab\lab_util::display_enemy_lasknown_pos();
    self.damage_functions[self.damage_functions.size] = &scripts\sp\maps\lab\lab_util::ai_display_dmg;
    return;
  }
}

function pre_office_door_open() {
  var_0 = 0;
  var_1 = getEnt("jugg_dead_door", "script_noteworthy");
  var_1.struct = var_1 scripts\engine\sp\utility::get_linked_struct();
  scripts\sp\maps\lab\lab_util::assign_door_ents(var_1);
  var_1.fakeknob = scripts\engine\utility::getStruct("offices_fake_door_prompt", "targetname");
  thread offices_fake_door_prompt(var_1.fakeknob);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  setmusicstate("");
  scripts\engine\sp\utility::transient_load("lab_office_tr");
  var_2 = getEnt("offices_event_check", "targetname");

  if(level.player istouching(var_2)) {
    var_0 = 1;
  }

  if(var_0) {
    office_branch_player(var_1);
    return;
  }

  office_branch_allies(var_1);
}

function offices_fake_door_prompt(var_0) {
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE", 45, 200, 55, 1);
  thread door_bash_thread(var_0, (5, -10, 10));
  var_0 scripts\engine\utility::waittill_any("openning_offices_door", "trigger");
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function office_branch_allies(var_0) {
  thread pre_office_teleport_allies(0);

  if(scripts\engine\utility::flag("past_jugg_door")) {
    scripts\engine\utility::flag_clear("past_jugg_door");
  }

  var_1 = cos(70);

  for(;;) {
    if(scripts\engine\utility::flag("past_jugg_door")) {
      break;
    } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var_1, level.farah.origin + (0, 0, 55))) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("door_guy_started");
  var_0 playSound("scrpt_door_metal_heavy_bash_npc");
  var_0.fakeknob notify("openning_offices_door");
  var_0 rotateTo(var_0.struct.angles, 1, 0.5, 0.5);
  var_0.collision scripts\engine\utility::delaycall(0.6, &connectpaths);
  var_2 = getspawner("post_jugg_door", "targetname");
  level.doorguy = var_2 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.doorguy thread scripts\engine\sp\utility::flag_on_death("door_guy_dead");
  wait 1.5;

  if(isDefined(level.doorguy) && isalive(level.doorguy)) {
    level.doorguy kill();
    return;
  }
}

function office_branch_player(var_0) {
  thread pre_office_teleport_allies(1);
  var_1 = getspawner("post_jugg_door", "targetname");
  level.doorguy = var_1 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.doorguy thread scripts\engine\sp\utility::flag_on_death("door_guy_dead");
  var_2 = scripts\engine\utility::getStruct("pre_office_obj_struct", "targetname");

  while(!scripts\sp\maps\lab\lab_util::in_player_fov(level.cos15, var_2.origin) && !scripts\engine\utility::flag("pre_office_door_flag")) {
    waitframe();
  }

  scripts\engine\utility::flag_set("post_jugg_door");
  var_0 playSound("scrpt_door_metal_heavy_bash_npc");
  var_0.fakeknob notify("openning_offices_door");
  var_0 rotateTo(var_0.struct.angles, 1, 0.5, 0.5);
  var_0.collision scripts\engine\utility::delaycall(0.6, &connectpaths);
}

function pre_office_teleport_allies(var_0) {
  level.farah notify("stop_going_to_node");
  var_1 = [level.farah, level.rebel_1, level.rebel_2];

  if(var_0) {
    scripts\engine\utility::array_thread(var_1, &tele_and_setgoalpos, "post_jugg2_", var_0);
    return;
  }

  scripts\engine\utility::array_thread(var_1, &tele_and_setgoalpos, "post_jugg1_", var_0);
}

function tele_and_setgoalpos(var_0, var_1) {
  scripts\engine\sp\utility::disable_ai_color();
  var_2 = scripts\engine\utility::getStruct(var_0 + self.animname, "targetname");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::teleport_ent(var_2);
  self.script_pushable = 0;

  if(var_1) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    self setgoalpos(var_3.origin);
    self allowedstances("stand");
    self.ignoreall = 0;
    self.ignoreme = 0;
    return;
  }

  if(self.animname == "farah") {
    scripts\common\ai::disable_arrivals();
    var_3 = getnode(var_2.target, "targetname");
    self setgoalpos(var_2.origin);
    self allowedstances("stand");
    self enableavoidance(0);
    self setgoalnode(var_3);

    while(!isDefined(level.doorguy)) {
      waitframe();
    }

    wait 3;
    self.ignoreall = 0;
    self.ignoreme = 0;
    return;
  }

  if(self.animname == "rebel_1") {
    scripts\common\ai::disable_arrivals();
    var_3 = getnode(var_2.target, "targetname");
    self setgoalpos(var_2.origin);
    self allowedstances("stand");
    self enableavoidance(0);
    var_2 = scripts\engine\utility::getStruct("pre_office_obj_struct", "targetname");
    scripts\common\ai::poi_enable(1, var_2);

    while(!isDefined(level.doorguy)) {
      waitframe();
    }

    self.ignoreall = 0;
    scripts\common\ai::poi_enable(0);

    if(isDefined(level.doorguy)) {
      self getenemyinfo(level.doorguy);
    }

    scripts\engine\utility::flag_wait("door_guy_dead");
    wait 0.3;
    self setgoalnode(var_3);
    return;
  }

  if(self.animname == "rebel_2") {
    scripts\common\ai::disable_arrivals();
    var_3 = getnode(var_2.target, "targetname");
    self allowedstances("stand");
    self enableavoidance(0);
    var_4 = scripts\engine\utility::getStruct("rebel_2_plant0", "targetname");
    var_4 thread scripts\common\anim::anim_single_solo(self, "cp_4_plant");
    var_5 = scripts\engine\utility::getanim("cp_4_plant");
    waitframe();
    self setanimtime(var_5, 0.75);
    self setanimrate(var_5, 0);
    var_6 = getEnt(var_4.targetname + "_bomb", "targetname");
    var_6 show();

    while(!isDefined(level.doorguy)) {
      waitframe();
    }

    self setanimrate(var_5, 1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_c4_light"), var_6, "tag_fx");
    self waittillmatch("single anim", "end");
    self setgoalnode(var_3);
    return;
  }
}

function cp_5_redshirt_die() {
  self waittillmatch("single anim", "end");
  scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

function juggernaut_catchup() {
  scripts\engine\utility::flag_set("turbines_clear");
  scripts\engine\utility::flag_set("offices_started_trig");
}

function turbine_pa_line(var_0) {
  var_1 = scripts\engine\utility::getStructArray("alarm", "targetname");
  var_2 = sortbydistance(var_1, level.player.origin)[0];
  scripts\engine\utility::play_sound_in_space(var_0, var_2.origin);
}