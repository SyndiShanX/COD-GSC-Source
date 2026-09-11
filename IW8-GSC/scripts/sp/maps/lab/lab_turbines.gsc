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
  var0 = getEntArray("van_scene_lights", "targetname");

  foreach(var2 in var0) {
    var2.og_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
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
    self waittill("bulletwhizby", var0);

    if(scripts\engine\utility::is_equal(var0, level.player)) {
      scripts\engine\utility::flag_set("cp_2_scene_start");
      break;
    }
  }
}

function notify_if_player_can_see_me() {
  level endon("cp_2_scene_start");
  self endon("death");
  var0 = cos(12);

  while(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var0)) {
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
  var0 = getnode(self.target, "targetname");
  teleport_ai_to_cover_node(var0);
  var1 = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 32;
  self.fixednode = 1;
  self.dropweapon = 0;
  self.damage_functions[self.damage_functions.size] = &group1_damage_func;

  if(isDefined(var0.script_parameters)) {
    var1 = float(var0.script_parameters);
    wait var1 - 0.15;
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
}

function teleport_ai_to_cover_node(var0) {
  var1 = var0.angles;
  var2 = var0.origin;

  if(!issubstr(var0.type, "Prone")) {
    if(issubstr(var0.type, "Left")) {
      var1 += (0, 90, 0);
    } else if(issubstr(var0.type, "Right") || issubstr(var0.type, "Cover Crouch") || issubstr(var0.type, "Conceal") || issubstr(var0.type, "Cover Stand")) {
      var1 -= (0, 90, 0);
    }
  }

  self forceteleport(var2, var1);
  self usecovernode(var0, 1);
  self setgoalnode(var0);
}

function group1_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::flag("ambush1_start")) {
    self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &group1_damage_func);
  }

  if(scripts\engine\utility::is_equal(var1, level.player)) {
    scripts\engine\utility::flag_set("inside_lab");
    scripts\engine\utility::flag_set("ambush1_start");
    self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &group1_damage_func);
    return;
  }
}

function lab_entrance_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("dam_intro_outside_start", [level.farah, level.price, level.kyle, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5, level.player]);
  var0 = getEnt("gl_intro_door", "script_noteworthy");
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
  var0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var0, &alarm_audio);
  var1 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var1, &turbine_spin);
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
    level.player waittill("weapon_taken", var0);
    var1 = level.player getcurrentweapon();

    while(var1 == level.player getcurrentweapon()) {
      waitframe();
    }

    if(level.player getcurrentweapon().basename != "iw8_lm_pkilo") {
      continue;
    }

    var2 = level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_ambush_lmgpickup_10", 0, 2);

    if(!istrue(var2)) {
      continue;
    }

    break;
  }
}

function move_to_entrance_new() {
  var0 = getEnt("gl_intro_door", "script_noteworthy");
  scripts\engine\utility::array_thread(level.heroes, &scripts\engine\sp\utility::disable_ai_color);
  door_scene_init();
  var1 = scripts\engine\utility::getStruct("gl_intro_door_struct", "targetname");
  var2 = scripts\engine\utility::getStructArray("actor_warp_structs", "targetname");
  var2 = sortbydistance(var2, var1.origin);
  var3 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.kyle, level.rebel_4, level.rebel_5];
  reach_door_check(level.price, var1, var2);

  foreach(var5 in var3) {
    thread reach_door_check(var5, var1);
  }

  wait 1;

  if(!scripts\engine\utility::flag("price_waiting")) {
    var1 notify("stop_price_idle");
    level.price notify("stop_single_loop");
    move_price(var1);
    scripts\engine\utility::flag_set("price_waiting");
  }

  if(distance2dsquared(level.player.origin, var1.origin) > 40000) {
    GscBinSkip4(0x6e, var1, var2);
  }

  scripts\engine\utility::flag_wait("player_at_entrance_door");
  scripts\engine\utility::flag_set("price_nag_stop");
  var1 notify("stop_price_idle");
  level.price notify("stop_single_loop");
  thread lab_door_move();
  thread lab_halligan_anim();
  thread lab_entrance_dialog();
  var1 scripts\common\anim::anim_single_solo(level.price, "lab_door_enter");
  var1 thread scripts\common\anim::anim_loop_solo(level.price, "lab_door_enter_idle", "stop_exit_idle");
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
  scripts\sp\maps\lab\lab_util::array_thread_safe(var3, &scripts\engine\sp\utility::enable_ai_color);
  var1 scripts\common\anim::anim_first_frame_solo(var0, "lab_door_enter");
  thread scripts\engine\sp\utility::transient_unload_array(["lab_hill_main_tr", "lab_hill_bottom_tr"]);
  scripts\sp\maps\lab\lab_util::array_thread_safe(scripts\engine\utility::array_remove(level.heroes, level.farah), &scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe);
  var7 = [level.kyle, level.rebel_4, level.rebel_5, level.price];

  foreach(var9 in var7) {
    if(isDefined(var9)) {
      var9 delete();
    }
  }
}

function move_price() {
  var0 = scripts\engine\utility::getStruct("price_door_path", "targetname");
  level.price.doavoidanceblocking = 0;
  level.price scripts\sp\maps\lab\lab_util::move_to_lab_node(var0);
  scripts\sp\maps\lab\lab_util::anim_reach_and_loop_solo(level.price, "lab_door_arrive", "lab_door_idle", "stop_price_idle");
  level.price.doavoidanceblocking = 1;
}

function door_scene_init() {
  lab_door_init();
  level.follow_ent = undefined;

  foreach(var1 in level.heroes) {
    var1 scripts\sp\maps\lab\lab_util::stop_ai_movement_control();
  }

  var3 = [level.rebel_4, level.rebel_5];

  foreach(var1 in var3) {
    var1.fixednode = 1;
    thread scripts\sp\maps\lab\lab_util::move_lab_allies("lab_entrance_rebel", var1);
  }
}

function door_bash_thread(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    self endon(var1);
  }

  var2 = spawn("script_origin", self.origin);
  var2.origin += rotatevector(var0, self.angles);

  while(isDefined(self)) {
    if(door_check_base(var2) && (level.player issprinting() || level.player ismeleeing())) {
      thread scripts\sp\door_internal::bashed_locked_door_sfx();
      level.player viewkick(10, var2.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player playRumbleOnEntity("heavy_1s");
      self notify("trigger", level.player);
      wait 1;
    }

    waitframe();
  }
}

function door_check_base(var0) {
  if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos60, var0.origin) && distance2dsquared(var0.origin, level.player.origin) < 625) {
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
  var0 = squared(300);

  while(!scripts\engine\utility::flag("price_waiting")) {
    thread scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (30, -5, 35), &"SCRIPT/DOOR_HINT_USE", 800, 400, 64, 1);
    var1 = scripts\engine\utility::waittill_any_return("trigger", "remove_door_prompt");

    if(!scripts\engine\utility::flag("price_waiting")) {
      scripts\sp\player\cursor_hint::remove_cursor_hint();
    }

    if(var1 == "remove_door_prompt") {
      break;
    } else {
      var2 = getaiarray("axis");

      if(var2.size == 0) {
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

function reach_door_check(var0, var1, var2) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  if(scripts\engine\utility::distance_2d_squared(self.origin, var0.origin) > 1000000) {
    var3 = check_warp_struct(var0, var1);

    if(isDefined(var3)) {
      self teleport(var3.origin, var3.angles);
      warp_struct_cooldown(var3);
    } else {
      self teleport(var1[0].origin, var1[0].angles);
    }
  }

  if(!scripts\engine\utility::is_equal(self, level.price)) {
    thread scripts\sp\maps\lab\lab_util::move_lab_allies("lab_entrance_main", [self]);
    return;
  }
}

function check_warp_struct(var0, var1) {
  foreach(var3 in var1) {
    if(!scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var1[1].origin) && !istrue(var3.on_cooldown)) {
      return var3;
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.farah, "dx_vom_far_hill_top_transition_10"]);
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_far_entrance_transition_10");
}

function lab_civ_vo() {
  var0 = getEntArray("lab_civs", "targetname");
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);

  if(!isDefined(var1)) {
    return;
  }

  var1 scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm1_entrance_civs_10");
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);

  if(!isDefined(var1)) {
    return;
  }

  var1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm1_entrance_civs_20");
  var0 = scripts\engine\utility::array_remove(var0, var1);
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);

  if(!isDefined(var1)) {
    return;
  }

  var1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm2_entrance_civs_30");
  var0 = scripts\engine\utility::array_remove(var0, var1);
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);

  if(!isDefined(var1)) {
    return;
  }

  var1 thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_rcm3_entrance_civs_40");
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.price, "dx_vom_pri_hill_top_carpark_80"]);
}

function lab_door_move() {
  var0 = getEnt("gl_intro_door", "script_noteworthy");
  var0 notify("remove_door_prompt");
  scripts\common\anim::anim_single_solo(var0, "lab_door_enter");
  var0.collision connectpaths();
  scripts\engine\utility::flag_set("open_lab_door");
}

function lab_halligan_anim() {
  level.price detach(level.price.halligan, "TAG_STOWED_BACK3");
  var0 = scripts\engine\sp\utility::spawn_anim_model("halligan");
  var0 dontinterpolate();
  scripts\common\anim::anim_first_frame_solo(var0, "lab_door_enter");
  scripts\common\anim::anim_single_solo(var0, "lab_door_enter");
  var0 delete();
  level.price attach("misc_wm_halligan_tool", "TAG_STOWED_BACK3");
  level.price.halligan = "misc_wm_halligan_tool";
}

function lab_door_init() {
  var0 = getEnt("gl_intro_door", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("gl_intro_door_struct", "targetname");
  var0.collision = getEnt(var0.target, "targetname");
  var0.collision linkTo(var0);
  var0.collision connectpaths();
  var0 scripts\engine\sp\utility::assign_animtree("gl_intro_door");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "lab_door_enter");
}

function clear_hill_apcs() {
  if(!isDefined(level.hill_apcs)) {
    return;
  }

  foreach(var1 in level.hill_apcs) {
    if(isDefined(var1)) {
      var1 kill();
    }
  }
}

function lab_ambush_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  thread allies_hold_fire();
  scripts\engine\sp\utility::set_start_location("ambush_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  var0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var0, &alarm_audio);
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var1 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var1, &turbine_spin);
}

function turbine_spin() {
  level endon("switch_to_kyle");
  var0 = 0.1 + randomfloatrange(0.5, 1.5);

  for(;;) {
    self rotatepitch(360, var0);
    wait var0;
  }
}

function lab_ambush_main() {
  thread scripts\sp\maps\lab\lab_util::sun_flare_off();
  thread allies_hold_fire();
  thread ambush1_logic();
  thread vo_ambush_enter();
  var0 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3];
  var1 = cos(70);
  scripts\engine\utility::flag_wait_any("ambush_tele_lower", "ambush_tele_upper");
  var2 = getEntArray("hill_color_trigs", "targetname");
  scripts\engine\utility::array_delete(var2);
  var0 = scripts\engine\utility::array_removedead(var0);
  var0 = scripts\engine\utility::array_removeundefined(var0);

  if(var0.size >= 3) {
    var3 = scripts\engine\utility::getclosest(level.player.origin, var0);
    var0 = scripts\engine\utility::array_remove(var0, var3);
  }

  if(scripts\engine\utility::flag("ambush_tele_lower")) {
    cleanup_area(level.ambush["lower"]);
    scripts\engine\utility::array_thread(var0, &ambush_teleport_to_cover, var1);
  } else {
    cleanup_area(level.ambush["upper"]);
    scripts\engine\utility::array_thread(var0, &ambush_teleport_to_struct, var1);
  }

  thread farah_to_van_start();
  thread enable_van_lights();
}

function enable_van_lights() {
  var0 = getEntArray("van_scene_lights", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.og_intensity);
  }
}

function lab_ambush_catchup() {
  scripts\engine\utility::flag_set("ambush1_start");
  scripts\sp\maps\lab\lab_util::sun_flare_off();
}

function farah_to_van_start() {
  level endon("jumpDown_start");
  var0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  scripts\engine\utility::flag_wait("farah_moves_up");
  scripts\engine\sp\utility::disable_ai_color();
  thread reach_to_idle_farah(var0, "jumpDown_start");
}

function ambush_teleport_to_cover(var0) {
  while(!isDefined(self)) {
    waitframe();
  }

  if(scripts\sp\maps\lab\lab_util::in_player_fov(var0, self.origin)) {
    return;
  }

  var1 = getnode("ambush_tele_lower_" + self.animname, "targetname");
  thread teleport_ai_to_cover_node(var1);
}

function ambush_teleport_to_struct(var0) {
  while(!isDefined(self)) {
    waitframe();
  }

  if(scripts\sp\maps\lab\lab_util::in_player_fov(var0, self.origin)) {
    return;
  }

  var1 = scripts\engine\utility::getStruct("ambush_tele_upper_" + self.animname, "targetname");
  scripts\engine\sp\utility::teleport_ent(var1);
}

function cleanup_area(var0) {
  if(isDefined(var0) && var0.size > 0) {
    var0 = scripts\engine\utility::array_removedead(var0);
    var0 = scripts\engine\utility::array_removeundefined(var0);
    scripts\engine\utility::array_call(var0, &delete);
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
  var0 = (2966, -251, -120);

  while(distance2dsquared(level.player.origin, var0) > 1156 || level.player.origin[2] < -100) {
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
  var1 = gettime();

  while(!scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_left() && !scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_forward() && !scripts\engine\utility::time_has_passed(var1, 6)) {
    level waittill("dam_intro_fallback_1");
  }

  if(scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_forward()) {
    level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_ambush_transition_10");
  }

  var1 = gettime();

  while(!scripts\sp\maps\lab\lab_vo_util::ambush_is_looking_left() && !scripts\engine\utility::time_has_passed(var1, 12)) {
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
  var0 = (3610, 142, 56);
  var1 = (3051, 56, 56);
  var2 = distance2dsquared(level.player.origin, var0) < 1600;

  for(var3 = distance2dsquared(level.player.origin, var1) < 2116; !var2 && !var3 || level.player.origin[2] < 56; var3 = distance2dsquared(level.player.origin, var1) < 2116) {
    waitframe();
    var2 = distance2dsquared(level.player.origin, var0) < 1600;
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
  var0 = getspawnerarray("group1");

  foreach(var2 in var0) {
    var3 = var2 stalingradspawn();
    level.upperguys[level.upperguys.size] = var3;
  }

  var2 = getspawner("group2", "targetname");
  var2 scripts\engine\sp\utility::spawn_ai(1);
}

function guy_up_stairs_watcher() {
  var0 = scripts\engine\utility::getStruct("ambush_run_up_stairs", "targetname");
  var1 = squared(350);

  for(;;) {
    var2 = distancesquared(level.player.origin, var0.origin);

    if(var2 <= var1) {
      break;
    }

    waitframe();
  }

  var1 = squared(200);
  var3 = cos(40);

  for(;;) {
    var2 = distancesquared(level.player.origin, var0.origin);

    if(var2 <= var1) {
      break;
    } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var3, var0.origin, [level.player])) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("guy_running_up_stairs");
}

function ambush_save(var0) {
  for(;;) {
    var0 = scripts\engine\utility::array_removedead(var0);

    if(var0.size < 3) {
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

  var0 = level.player getcurrentweapon();
  var1 = var0 getaltweapon();

  if(scripts\engine\utility::is_equal(var0.underbarrel, "ub_mike203_sp") && isDefined(var1) && level.player getammocount(var1) > 0) {
    if(level.player usinggamepad()) {
      scripts\engine\sp\utility::display_hint("gl_hint", 7);
      return;
    }

    scripts\engine\sp\utility::display_hint("gl_hint_kbm", 7);
    return;
  }
}

function is_using_gl() {
  var0 = level.player getcurrentweapon();
  return scripts\engine\utility::is_equal(var0.underbarrel, "ub_mike203_sp") && istrue(var0.isalternate) && level.player getammocount(var0) > 0;
}

function lights_out_alarm_off() {
  var0 = scripts\engine\utility::getStructArray("alarm", "targetname");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::notify_delay, "stop_alarm", 0.1);
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

function fog_fx_check(var0, var1) {
  level.player endon("death");
  var2 = getEnt(var0, "targetname");

  if(level.player istouching(var2)) {
    scripts\engine\utility::exploder(var1);
  }

  var3 = gettime() + 2000;

  while(gettime() < var3) {
    wait 0.1;

    if(!level.player istouching(var2)) {
      scripts\engine\utility::stop_exploder(var1);
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
  var0 = scripts\engine\sp\utility::get_ai_group_ai("sniper_targets");
  var1 = [];

  foreach(var3 in var0) {
    var3.dropweapon = 0;
    var3 scripts\sp\nvg\nvg_ai::flashlight_on(1);

    if(var3.weapon.classname == "rocketlauncher") {
      var1 = var3;
    }
  }

  for(;;) {
    var1 = scripts\engine\utility::array_removedead(var1);

    if(!var1.size) {
      return;
    }

    foreach(var3 in var1) {
      if(var3 scripts\sp\maps\lab\lab_util::is_aimed_at_enemy(level.cos30)) {
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
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(var3 >= 3) {
      var2.diequietly = 1;
    }
  }

  scripts\engine\utility::array_call(getaiarray("axis"), &delete);
}

function lab_jumpdown_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  scripts\engine\sp\utility::set_start_location("jumpdown_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var0, &turbine_spin);
  var1 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  thread reach_to_idle_farah(level.farah, var1);
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
  var0 = scripts\engine\sp\utility::array_spawn_targetname("van_scene_deadbody", 1, 1);

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
    var3 thread scripts\common\anim::anim_loop_solo(var2, "van_jumpdown_deadguy");
    var2.dropweapon = 0;
    var2.skipdeathanim = 1;
    var2 scripts\common\ai::stop_magic_bullet_shield();
    var2.ragdoll_immediate = 1;
    var2.allowdeath = 1;
    var2.diequietly = 1;
    var2 scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::die);
  }
}

function van_scene_init() {
  level.nikolai_van = nik_van_init();
  player_bomb_init();
  thread dock_door_init();
  var0 = getspawner("hero_Nikolai", "targetname");
  level.nikolai = var0 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.nikolai.animname = "nikolai";
  level.nikolai setModel("body_hero_nikolai_lab");
  level.nikolai scripts\common\ai::magic_bullet_shield();
  thread damage_watcher();
}

function damage_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var2, var2, var2, var2, var2, var2, var3);

    if(isDefined(var3) && var3.basename == "flash") {
      continue;
    }

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  scripts\sp\player_death::set_custom_death_quote(10);
  scripts\sp\utility::missionfailedwrapper();
}

function dock_door_init() {
  var0 = getEntArray("jumpdown_doors", "targetname");

  foreach(var2 in var0) {
    var2.animname = "van_intro_doors";
    var2 scripts\engine\sp\utility::assign_animtree();
    var3 = getEnt(var2.target, "targetname");
    var2.clip = var3;
    var2.clip linkTo(var2);
    var2.clip disconnectPaths();
    var4 = scripts\engine\utility::getStruct(var2.target, "targetname");
    var2.struct = var4;
  }
}

function dock_doors_move() {
  var0 = getEntArray("jumpdown_doors", "targetname");
  move_the_door(var0[0]);
  move_the_door(var0[1]);
  var0[0] waittill("rotatedone");
  var0[0].clip disconnectPaths();
  var0[1].clip disconnectPaths();
}

function move_the_door() {
  self.clip connectpaths();

  if(isDefined(self.og_angles)) {
    var0 = self.og_angles;
  } else {
    self.og_angles = self.angles;
    var0 = self.struct.angles;
  }

  self rotateTo(var0, 1, 0.5, 0.5);
}

function van_scene() {
  setmusicstate("");
  var0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");
  scripts\engine\utility::flag_wait_any("jumpDown_start", "van_scene_start");
  var0 notify("stop_loop");
  scripts\engine\sp\utility::autosave_by_name("van_scene");
  var1 = spawn_van_guys();

  if(scripts\engine\utility::flag("van_scene_start")) {
    var2 = scripts\engine\utility::array_add(var1, level.farah);
  } else {
    var2 = var2;
  }

  scripts\sp\maps\lab\lab_util::array_thread_safe(var2, &scripts\engine\sp\utility::disable_ai_color);
  thread dock_doors_move();
  scripts\engine\utility::delaythread(2, &dock_doors_move);
  thread jumpdown_reach_idle(var1, var2, "van_jumpdown_idle");
  scripts\engine\utility::flag_wait("van_scene_start");
  thread van_dead_guys();
  var1 scripts\common\anim::anim_first_frame_solo(level.bomb, "van_bomb_pickup");
  var3 = getEnt("van_jumpdown_vol", "targetname");
  var4 = gettime() + 3000;

  while(var3 scripts\engine\sp\utility::get_ai_touching_volume("allies").size < 3 && gettime() < var4) {
    waitframe();
  }

  foreach(var6 in level.heroes) {
    var6 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  if(!scripts\engine\utility::flag("van_guys_ready")) {
    scripts\engine\utility::array_thread(level.nikolai_van.bombs, &setup_ally_bombs, var1);
    thread van_scene_a(var1);
    var8 = scripts\engine\utility::flag_wait_any_return("ambush1_outside_dropdown", "van_guys_ready");

    if(var8 == "ambush1_outside_dropdown") {
      level notify("van_rushed");
      var9 = scripts\engine\utility::getStruct("van_scene_start", "targetname");

      while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var9.origin)) {
        waitframe();
      }
    }

    var1 notify("van_jumpdown_idle_stop");
    thread van_scene_a(var1);
  } else {
    var10 = scripts\engine\utility::array_combine([level.nikolai_van, level.nikolai], level.heroes);
    thread van_scene_a(var1);
  }

  GscBinSkip4(0x6e, var1, var10, level.heroes, [level.nikolai_van, level.nikolai], "van_jumpdown_idle_stop");
}

function remove_van_lights() {
  var0 = getEntArray("van_scene_lights", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }

  wait 0.1;

  foreach(var2 in var0) {
    var2 delete();
  }
}

function animated_van_scene(var0) {
  self endon("death");
  var0 scripts\common\anim::anim_single_solo(self, "van_scene");
  var0 thread scripts\common\anim::anim_loop_solo(self, "van_door_idle");
}

function delete_old_rebels() {
  scripts\engine\utility::flag_wait("ambush1_outside_dropdown");

  foreach(var1 in level.old_rebels) {
    if(isDefined(var1.magic_bullet_shield)) {
      var1 scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(level.old_rebels, 50);
}

function setup_ally_bombs(var0) {
  var0 scripts\common\anim::anim_first_frame_solo(self, "van_jumpdown_start");
}

function van_scene_dialog() {
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_jumpdown_intro_20");
  wait 2;
  level.nikolai scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_nik_jumpdown_intro_30");
  var0 = distance(level.player.origin, level.nikolai.origin) > 500;

  if(!var0 && level.player scripts\engine\trace::can_see_origin(level.nikolai getEye(), 0)) {
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_jumpdown_intro_40");
  } else if(var0 && level.player scripts\engine\trace::can_see_origin(level.nikolai getEye(), 0)) {
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_jumpdown_intro_41");
  } else {
    wait 1;
  }

  level.nikolai scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_nik_jumpdown_charges_10");
}

function jumpdown_reach_idle(var0, var1, var2) {
  scripts\engine\utility::flag_set("van_guys_ready");

  foreach(var4 in var0) {
    thread reach_to_idle(var4, self);
  }
}

function reach_to_idle(var0, var1) {
  var0 endon(var1);
  var0 scripts\common\anim::anim_single_solo(self, "van_jumpdown_arrival");
  var0 childthread scripts\common\anim::anim_loop_solo(self, "van_jumpdown_idle");
}

function reach_to_idle_farah(var0, var1) {
  self endon(var1);
  self.ignoreall = 1;
  self.ignoreme = 1;
  var2 = scripts\engine\utility::getanim("van_jumpdown_arrival");
  var3 = getstartorigin(var0.origin, var0.angles, var2);
  self setgoalpos(var3);
  var4 = squared(110);

  for(;;) {
    var5 = distancesquared(self.origin, var3);

    if(var5 <= var4) {
      break;
    }

    waitframe();
  }

  self.startingjumpdownanim = "started";
  var0 scripts\sp\anim::anim_reach_solo(self, "van_jumpdown_arrival");
  var0 scripts\common\anim::anim_single_solo(self, "van_jumpdown_arrival");
  self.startingjumpdownanim = "inPosition";
  var0 childthread scripts\common\anim::anim_loop_solo(self, "van_jumpdown_idle", "van_jumpdown_idle");
}

function spawn_van_guys() {
  level.old_rebels = [level.rebel_1, level.rebel_2, level.rebel_3];
  strip_old_ai(level.old_rebels);
  var0 = scripts\engine\utility::getStruct("doorbash_test", "targetname");

  foreach(var2 in level.old_rebels) {
    var2 notify("entitydeleted");
    level.heroes = scripts\engine\utility::array_remove(level.heroes, var2);
  }

  level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
  level.heroes[level.heroes.size] = level.rebel_1;
  getspawner("redshirt_rebel_1", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_1, 1);
  var0 scripts\common\anim::anim_first_frame_solo(level.rebel_1, "van_jumpdown_arrival");
  level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
  level.heroes[level.heroes.size] = level.rebel_2;
  getspawner("redshirt_rebel_2", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_2, 1);
  var0 scripts\common\anim::anim_first_frame_solo(level.rebel_2, "van_jumpdown_arrival");
  level.rebel_3 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_4", 1);
  level.rebel_3.animname = "rebel_3";
  level.heroes[level.heroes.size] = level.rebel_3;
  getspawner("redshirt_rebel_3", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_3, 1);
  var0 scripts\common\anim::anim_first_frame_solo(level.rebel_3, "van_jumpdown_arrival");
  var4 = [level.rebel_1, level.rebel_2, level.rebel_3];
  scripts\engine\utility::array_thread(var4, &scripts\sp\maps\lab\lab_util::ai_gas_mask, 1);
  scripts\engine\utility::array_thread(var4, &scripts\anim\shared::forceuseweapon, "iw8_ar_akilo47", "primary");
  scripts\engine\utility::array_thread(var4, &scripts\common\ai::magic_bullet_shield);
  scripts\sp\maps\lab\lab_util::rebuild_heroes_array();
  return [level.rebel_1, level.rebel_2, level.rebel_3];
}

function strip_old_ai() {
  foreach(var1 in self) {
    var1.animname = undefined;

    if(isDefined(var1.my_spawner)) {
      var1.my_spawner notify("stop_rebel_flood");
    }
  }

  level.rebel_1 = undefined;
  level.rebel_2 = undefined;
  level.rebel_3 = undefined;
  waitframe();
}

function anim_reach_safe(var0, var1) {
  while(!isalive(var0)) {
    waitframe();
  }

  scripts\sp\anim::anim_reach_solo(var0, var1);
}

function van_scene_a(var0) {
  level endon("bomb_pickup");
  var0 = scripts\engine\utility::array_removeundefined(var0);
  self notify("van_jumpdown_idle_stop");
  self notify("stop_loop");

  if(isarray(var0)) {
    var1 = var0;
    var3 = getfirstarraykey(var1);

    if(isDefined(var3)) {
      var2 = var1[var3];
      GscBinSkip4(0x35, var2);
    }

    var1 = undefined;
    var3 = undefined;
    return;
  }

  play_scene_safe(var0);
}

function play_scene_safe(var0) {
  wait_on_living(var0);

  if(var0.animname == "rebel_1") {
    thread play_c4_anims();
    scripts\common\anim::anim_single_solo(var0, "van_jumpdown_start");
  } else if(var0.animname == "farah") {
    var1 = scripts\engine\utility::getStructArray("farah_teleport_struct", "targetname");

    if(isDefined(var0.startingjumpdownanim)) {
      while(var0.startingjumpdownanim == "started") {
        waitframe();
      }

      level.farah notify("jumpDown_start");
    } else {
      var2 = cos(70);

      while(farah_teleport_in_player_fov(var0, var2, var1)) {
        waitframe();
      }

      level.farah notify("jumpDown_start");

      if(isDefined(var0.startingjumpdownanim) && var0.startingjumpdownanim == "inPosition") {} else {
        scripts\common\anim::anim_single_solo(var0, "van_jumpdown_arrival");
        thread scripts\common\anim::anim_loop_solo(var0, "van_jumpdown_idle", "stop_farah_jumpdown_idle");
        wait 1.5;
      }

      self notify("stop_farah_jumpdown_idle");
    }

    var0.ignoreall = 0;
    var0.ignoreme = 0;
    self notify("van_jumpdown_idle");
    scripts\common\anim::anim_single_solo(var0, "van_jumpdown_start");
  } else {
    scripts\common\anim::anim_single_solo(var0, "van_jumpdown_start");
  }

  wait_on_living(var0);

  if(isai(var0)) {
    if(var0.animname == "nikolai") {
      var3 = ["dx_vom_nik_jumpdown_charges_20", "dx_vom_nik_jumpdown_charges_40", "dx_vom_nik_jumpdown_charges_10"];
      var0 thread scripts\sp\maps\lab\lab_util::notetrack_nag(var3, "grab_charges");
      thread scripts\common\anim::anim_loop_solo_with_nags(var0, "van_start_idle", "stop_van_idle");
      return;
    }

    thread scripts\common\anim::anim_loop_solo(var0, "van_start_idle", "stop_van_idle");
    return;
  }
}

function farah_teleport_in_player_fov(var0, var1) {
  var2 = 0;

  if(isDefined(self.startingjumpdownanim) && self.startingjumpdownanim == "inPosition") {
    var2 = 0;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var0, self gettagorigin("j_spine4"), [self, level.player])) {
    var2 = 1;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var0, var1[0].origin, [level.player, level.rebel_1, level.rebel_2, level.rebel_3])) {
    var2 = 1;
  } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var0, var1[1].origin, [level.player, level.rebel_1, level.rebel_2, level.rebel_3])) {
    var2 = 1;
  }

  return var2;
}

function play_c4_anims() {
  scripts\common\anim::anim_single(level.nikolai_van.bombs, "van_jumpdown_start");

  foreach(var1 in level.nikolai_van.bombs) {
    if(isDefined(var1)) {
      var1 delete();
    }
  }
}

function wait_on_living(var0) {
  while(isai(var0) && !isalive(var0)) {
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
  var0 = scripts\engine\utility::getStruct("van_bomb_struct", "targetname");
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (5, -1, -1.5), &"SCRIPT/PICKUP", 600, 300, 64, 0, undefined, undefined, undefined, undefined, undefined, undefined, 65, 60);
  var0 waittill("trigger");
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  scripts\sp\player_rig::link_player_to_rig("van_bomb_pickup", undefined, 1, 0.3, 0, 0, 0, 0, 0, 1);
  thread setup_detonator_swap();
  childthread scripts\common\anim::anim_single([level.bomb, level.player_rig, level.player_rig.detonator], "van_bomb_pickup");
  level notify("bomb_pickup");
  thread scripts\sp\maps\lab\lab_lighting::c4_pickup_dof();
  var1 = scripts\engine\utility::array_add(level.heroes, level.nikolai);
  scripts\sp\maps\lab\lab_util::array_thread_safe(var1, &scripts\engine\sp\utility::anim_stopanimscripted);
  self notify("stop_van_idle");
}

function setup_detonator_swap() {
  level.player_rig.detonator = scripts\engine\sp\utility::spawn_anim_model("van_detonator");
  level.player_rig.detonator hide();
  level.nikolai attach("offhand_vm_clacker_tactical_sp_cinematic", "tag_accessory_right");
}

function nik_van_init() {
  var0 = getEnt("interrogation_van", "script_noteworthy");
  var0 scripts\engine\sp\utility::assign_animtree("nik_van");
  var0.extras = [];
  var0.bombs = [];
  var1 = getEnt("van_door_left", "targetname");
  var1 linkTo(var0, "tag_door_rear_left");
  var2 = getEnt("van_door_right", "targetname");
  var2 linkTo(var0, "tag_door_rear_right");
  var3 = getEntArray("van_extras", "targetname");

  foreach(var5 in var3) {
    var0.extras[var0.extras.size] = var5;
  }

  var3 = getEntArray("van_cargo", "targetname");

  foreach(var5 in var3) {
    var0.extras[var0.extras.size] = var5;
  }

  var3 = getEntArray("van_bombs", "targetname");

  foreach(var5 in var3) {
    var5 scripts\engine\sp\utility::assign_animtree(var5.script_noteworthy);
    var0.bombs[var0.bombs.size] = var5;
  }

  return var0;
}

function cp_3_doors_scene() {
  scripts\engine\utility::flag_wait("ambush2_entrance_go");
  thread farah_move_up();
  thread mus_outside_door_breach();
  dragons_breath_scene();
}

function farah_move_up() {
  wait 1.5;
  var0 = getnode("jump_down_farah", "targetname");
  level.farah scripts\sp\spawner::go_to_node(var0);
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

function dragons_breath_scene() {
  scripts\sp\maps\lab\lab_util::array_thread_safe(getaiarray("allies"), &scripts\engine\sp\utility::enable_ai_color);
  cp_3_enemy_setup();
  var0 = scripts\engine\utility::array_removedead([level.rebel_1, level.rebel_2, level.rebel_3]);
  var1 = scripts\engine\utility::getStruct("chokepoint_3_animnode", "targetname");
  var2 = getEntArray("cp_3_doors", "script_noteworthy");
  level notify("reached_t2");

  foreach(var4 in var0) {
    if(var4.animname == "rebel_2") {
      var4.bypassdbcheck = 1;
    }

    var4.dropweapon = 0;
    var4.attackeraccuracy = 5;
  }

  var1 thread scripts\common\anim::anim_single_solo(level.cp_3_enemy, "cp_3_buddy_door_push");
  var1 thread scripts\common\anim::anim_single(var0, "cp_3_buddy_door_push");
  var1 scripts\common\anim::anim_single(var2, "cp_3_buddy_door_push");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("db_color_trigger_1");
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::activate_trigger_with_noteworthy, "db_color_trigger_2");

  foreach(var4 in var0) {
    if(isDefined(var4)) {
      var4 scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    }
  }

  foreach(var9 in var2) {
    var9.collision connectpaths();
    var9.collision disconnectPaths();
  }

  scripts\sp\maps\lab\lab_util::array_thread_safe(var0, &scripts\common\utility::disable_cqbwalk);
  wait 2.5;

  if(isalive(level.cp_3_enemy)) {
    level.cp_3_enemy scripts\engine\sp\utility::set_attackeraccuracy(0.7);
  }

  level.db_2_enemy = scripts\engine\sp\utility::spawn_targetname("cp_3_enemy_2", 1);
  scripts\engine\utility::flag_wait("db_enemy_dead");
  thread turbines_dialog();
  var0 = [level.rebel_1, level.rebel_2, level.rebel_3, level.cp_3_enemy];
  var0 = scripts\engine\utility::array_removedead(var0);

  foreach(var12 in var0) {
    var12.attackeraccuracy = 1;
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
  var0 = scripts\sp\maps\lab\lab_util::make_incendiary_shottie();
  level.cp_3_enemy thread scripts\anim\shared::forceuseweapon(var0, "primary");
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
  var0 = getEntArray("cp_3_doors", "script_noteworthy");

  foreach(var2 in var0) {
    scripts\sp\maps\lab\lab_util::assign_door_ents(var2);
    var2 scripts\engine\sp\utility::assign_animtree(var2.targetname);
    var2.collision connectpaths();
  }

  var4 = scripts\engine\utility::getStruct("chokepoint_3_animnode", "targetname");
  var4 scripts\common\anim::anim_first_frame(var0, "van_door_push");
  wait 0.05;

  foreach(var2 in var0) {
    var2.collision disconnectPaths();
  }
}

function incendiary_attacker_logic() {
  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && var1 == level.player) {
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

  foreach(var1 in [level.rebel_1, level.rebel_2, level.rebel_3]) {
    var1 scripts\engine\sp\utility::disable_ai_color();
  }

  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var3 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var3, &turbine_spin);
  scripts\engine\utility::flag_set("ambush2_entrance_go");
  thread cp_3_doors_scene();
}

function dragons_breath_main() {
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 0);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\maps\lab\lab_util::laser_discipline);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::laser_discipline);
  thread t2_flood_init();
  var0 = getEntArray("jugg_bomb", "script_noteworthy");
  scripts\engine\utility::array_call(var0, &hide);
  thread t2_manager();
  thread barrel_thread_setup();
  thread vo_dragons_breath();
  thread turbine_enemies_seek();
  thread juggernaut_fire_suppression();
  thread disconnect_jumpdown_traversal();
  thread scripts\engine\utility::array_delete(getEntArray("ambush_triggers", "script_noteworthy"));
  thread turbines_clear_thread();
  thread dragons_breath_hit_farah();
  var1 = scripts\engine\utility::flag_wait_any_return("turbines_clear", "turbines_rushed");

  if(var1 == "turbines_rushed") {
    var2 = getaiarray("axis");

    if(isDefined(var2)) {
      foreach(var4 in var2) {
        if(var5 >= 3) {
          var4.diequietly = 1;
        }
      }

      scripts\engine\utility::array_call(getaiarray("axis"), &delete);
    }

    scripts\engine\utility::flag_set("turbines_clear");
  }

  scripts\engine\sp\utility::autosave_by_name("turbines_clear");
  var6 = getEntArray("turbine2_spawn_trigs", "script_noteworthy");
  scripts\engine\utility::array_delete(var6);
}

function barrel_thread_setup() {
  level endon("juggernaut_dead");
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("scriptable_decor_barrels_gameplay_flammable", "classname");
  var1 = var0;
  var3 = getfirstarraykey(var1);

  if(isDefined(var3)) {
    var2 = var1[var3];
    GscBinSkip4(0x6e, var2);
  }

  var1 = undefined;
  var3 = undefined;
}

function barrelbarrel_damage_thread() {
  var0 = self.origin;

  while(!scripts\engine\utility::flag("juggernaut_dead")) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(isDefined(var10) && getweaponbasename(var10) == "iw8_sh_dpapa12_incendiary" && var5 != "MOD_MELEE") {
      self radiusdamage(var0, 10, 25, 20, var2, var5, var10);
    }
  }
}

function t2_flood_init() {
  scripts\engine\utility::flag_wait("start_t2_flood");
  var0 = getspawnerarray("t2_flood_enemies");

  foreach(var2 in var0) {
    thread t2_floods();
  }

  scripts\engine\utility::flag_wait("stop_t2_flood");
  scripts\engine\utility::array_delete(var0);
}

function t2_floods() {
  self endon("death");
  wait 2;
  self.count += 1;
  var0 = scripts\engine\sp\utility::spawn_ai();
  level endon("stop_t2_flood");

  while(isDefined(self)) {
    if(isDefined(var0)) {
      self.count += 1;
      var0 endon("entitydeleted");
      var0 waittill("death");
      wait 5;

      while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin, [level.player])) {
        wait 0.15;
      }

      var0 = self stalingradspawn();
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
  level.farah waittill("damage", var0, var1, var0, var0, var0, var0, var0, var0, var0, var2);

  if(scripts\engine\utility::is_equal(var1, level.player) && isDefined(var2) && getweaponbasename(var2) == "iw8_sh_dpapa12_incendiary") {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }
}

function dragons_breath_catchup() {
  scripts\engine\utility::flag_set("turbines_clear");
  thread scripts\sp\maps\lab\lab_util::remove_animated_door("t2_doors");
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::remove_animated_door, "cp_3_doors");
  var0 = getEntArray("turbine2_spawn_trigs", "script_noteworthy");
  var1 = getEntArray("turbine2_spawn_trigs_rightside", "script_noteworthy");
  var2 = scripts\engine\utility::array_combine(var0, var1);

  if(var2.size) {
    scripts\engine\utility::array_delete(var2);
  }

  var3 = getEntArray("ambush_triggers", "script_noteworthy");
  thread scripts\engine\utility::array_delete(var3);
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
  var0 = "t2" + level.t2_manager["fallback"] + level.t2_manager["player_pos"];
  var1 = getEnt(var0, "targetname");
  return var1;
}

function t2_player_pos() {
  level endon("t2_stop_trigger_watch");
  var0 = getEnt("t2_player_left", "targetname");
  var1 = getEnt("t2_player_right", "targetname");
  var2 = "left";

  for(;;) {
    if(var2 != "left" && level.player istouching(var0)) {
      level.t2_manager["player_pos"] = "_left";
      wait 0.2;
      level notify("t2_update_volume");
      var2 = "left";
    } else if(var2 != "right" && level.player istouching(var1)) {
      level.t2_manager["player_pos"] = "_right";
      wait 0.2;
      level notify("t2_update_volume");
      var2 = "right";
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
  var0 = getEntArray("turbine2_spawn_trigs_rightside", "script_noteworthy");

  if(var0.size) {
    scripts\engine\utility::array_delete(var0);
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
    var0 = scripts\engine\sp\utility::get_ai_group_ai("turbine_end_guys");
    scripts\engine\utility::array_call(var0, &cleargoalvolume);

    foreach(var2 in var0) {
      var2 setgoalpos(var2.origin);
    }

    level.t2_manager["volume"] = t2_update_volume();
    scripts\engine\utility::array_call(var0, &setgoalvolumeauto, level.t2_manager["volume"]);
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

  var0 = scripts\engine\sp\utility::get_ai_group_ai("turbine_end_guys");

  foreach(var2 in var0) {
    var2.goalradius = 64;
    var2 setgoalentity(level.player);
  }
}

function juggernaut_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_farah(1);
  scripts\engine\sp\utility::set_start_location("juggernaut_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\sp\maps\lab\lab_lighting::ambush_lighting_change();
  scripts\engine\utility::delaythread(1, &scripts\sp\maps\lab\lab_util::player_gas_mask, 1);
  var0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var0, &turbine_spin);
  thread juggernaut_fire_suppression();
  thread disconnect_jumpdown_traversal();
  var1 = getEntArray("jugg_bomb", "script_noteworthy");
  scripts\engine\utility::array_call(var1, &hide);
}

function juggernaut_main() {
  scripts\engine\sp\utility::activate_trigger_with_targetname("t2_finished");
  setmusicstate("mx_lab_jugg_tension");
  var0 = level.friendlyfire["friend_kill_points"];
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
  var1 = [97, 98, 73, 75];
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize(var1)[0]);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  level.friendlyfire["friend_kill_points"] = var0;
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
  var0 = scripts\engine\utility::getStruct("jugg_door_struct", "targetname");
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE", 45, 200, 55, 1);
  level waittill("jugg_started");
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function fan_spin() {
  level endon("reached_final_room");
  var0 = 0.1 + randomfloatrange(0.3, 1.1);
  var1 = getEnt("spinning_fan", "targetname");

  for(;;) {
    var1 rotatepitch(360, var0);
    wait var0;
  }
}

function juggernaut_post_death_cleanup() {
  setsaveddvar("SLMRSNOSK", 1);
  scripts\engine\utility::delaythread(0.5, &post_jugg_allies_plant_bombs);
  scripts\engine\utility::delaythread(0.1, &juggernaut_allies_cleanup);
  wait 2.5;

  foreach(var1 in getaiarray("allies")) {
    var1.dontmelee = undefined;
  }
}

function post_jugg_allies_plant_bombs() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = getnodearray("post_jugg_nodes", "script_noteworthy");

  foreach(var6 in level.jugg_allies) {
    if(isDefined(var6) && isalive(var6)) {
      if(!isDefined(var0)) {
        var0 = var6;
        var6.animname = "jugg_ally1";
        var7 = scripts\engine\utility::getStruct("post_jugg_plant1", "targetname");
        var8 = scripts\engine\utility::getStruct("post_jugg_plant2", "targetname");
        thread post_jugg_plant_ally(var6, [var7, var8], var4[0]);
        continue;
      }

      if(!isDefined(var1)) {
        var1 = var6;
        var6.animname = "jugg_ally2";
        var7 = scripts\engine\utility::getStruct("post_jugg_plant3", "targetname");
        var8 = scripts\engine\utility::getStruct("post_jugg_plant4", "targetname");
        thread post_jugg_plant_ally(var6, [var7, var8], var4[1]);
        continue;
      }

      if(!isDefined(var2)) {
        var2 = var6;
        var6 scripts\engine\utility::delaythread(1.2, &post_jugg_ally_node, "post_jugg_node3");
        continue;
      }

      if(!isDefined(var3)) {
        var3 = var6;
        var6 scripts\engine\utility::delaythread(1.6, &post_jugg_ally_node, "post_jugg_node4");
      }
    }
  }

  var10 = cos(70);

  if(!isDefined(var0)) {
    var0 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_4");
    var0.animname = "jugg_ally1";
    var7 = scripts\engine\utility::getStruct("post_jugg_plant1", "targetname");
    var8 = scripts\engine\utility::getStruct("post_jugg_plant2", "targetname");
    var11 = scripts\engine\utility::getStruct("jugg_extra1", "targetname");
    var12 = getEnt("t2_parking_vol", "targetname");

    if(scripts\engine\utility::within_fov(var11.origin, var11.angles, level.player getEye(), var10) && scripts\engine\trace::ray_trace_passed(var11.origin, level.player getEye(), [level.player])) {
      var11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    } else if(var0 istouching(var12)) {
      var11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    }

    var0 forceteleport(var11.origin, var11.angles);
    thread post_jugg_plant_ally(var0, [var7, var8], var4[0]);
  }

  if(!isDefined(var1)) {
    wait 1;
    var1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_5");
    var1.animname = "jugg_ally2";
    var7 = scripts\engine\utility::getStruct("post_jugg_plant3", "targetname");
    var8 = scripts\engine\utility::getStruct("post_jugg_plant4", "targetname");
    var11 = scripts\engine\utility::getStruct("jugg_extra1", "targetname");
    var12 = getEnt("t2_parking_vol", "targetname");

    if(scripts\engine\utility::within_fov(var11.origin, var11.angles, level.player getEye(), var10) && scripts\engine\trace::ray_trace_passed(var11.origin, level.player getEye(), [level.player])) {
      var11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    } else if(var1 istouching(var12)) {
      var11 = scripts\engine\utility::getStruct("jugg_extra2", "targetname");
    }

    var1 forceteleport(var11.origin, var11.angles);
    thread post_jugg_plant_ally(var1, [var7, var8], var4[1]);
    return;
  }
}

function post_jugg_ally_node(var0) {
  self notify("became_ally");
  var1 = getnode(var0, "targetname");
  self setgoalnode(var1);
}

function post_jugg_plant_ally(var0, var1, var2) {
  self endon("death");
  wait var2;
  var0 = sortbydistance(var0, self.origin);
  var3 = var0[0];
  self notify("became_ally");
  self.goalradius = 4;
  self setgoalpos(var3.origin);
  var4 = squared(100);

  for(;;) {
    var5 = distance2dsquared(self.origin, var3.origin);

    if(var5 <= var4) {
      break;
    }

    wait 0.1;
  }

  var3 scripts\sp\anim::anim_reach_and_arrive(self, "cp_4_plant");
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\lab\lab_offices::rebel_plant_bomb, var3);
  self attach("offhand_wm_c4_bomb", "tag_accessory_right");
  var3 scripts\common\anim::anim_single_solo(self, "cp_4_plant");
  var3 = var0[1];
  self setgoalpos(var3.origin);

  for(;;) {
    var5 = distance2dsquared(self.origin, var3.origin);

    if(var5 <= var4) {
      break;
    }

    wait 0.1;
  }

  var3 scripts\sp\anim::anim_reach_and_arrive(self, "cp_4_plant");
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\lab\lab_offices::rebel_plant_bomb, var3);
  self attach("offhand_wm_c4_bomb", "tag_accessory_right");
  var3 scripts\common\anim::anim_single_solo(self, "cp_4_plant");
  self setgoalnode(var1);
}

function juggernaut_allies_cleanup() {
  level scripts\engine\sp\utility::notify_delay("stop_jugg_smoke", 0.1);
  level.player setthreatbiasgroup("allies");
  scripts\engine\utility::flag_clear("pause_rebel_respawning");

  foreach(var1 in level.heroes) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\common\utility::clear_movement_speed();

    if(!isDefined(var1.magic_bullet_shield)) {
      var1.attackeraccuracy = 1;

      if(isDefined(var1.og_health)) {
        var1.health = var1.og_health;
      }
    }
  }
}

function init_cp_5_doors() {
  wait 0.1;
  var0 = getEntArray("cp_5_doors", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("chokepoint_5_animnode", "targetname");

  foreach(var3 in var0) {
    scripts\sp\maps\lab\lab_util::assign_door_ents(var3);
    var3.animname = var3.targetname;
    var3 scripts\engine\sp\utility::assign_animtree();
    var3.collision connectpaths();
  }

  var1 scripts\common\anim::anim_first_frame(var0, "cp_5_juggernaut");
  wait 0.05;

  foreach(var3 in var0) {
    var3.collision disconnectPaths();
  }
}

function juggernaut_fx() {
  scripts\engine\utility::flag_wait("turbines_clear");
  wait 0.5;
  scripts\engine\utility::exploder("doorsmoke");
}

function juggernaut_intro_fx() {
  var0 = scripts\engine\utility::getStruct("juggernaut_smoke_1", "targetname");
  var1 = spawnfx(level._effect["vfx_smoke_gren_start"], var0.origin);
  triggerfx(var1);
  var2 = spawnfx(level._effect["vfx_smoke_gren_loop"], var0.origin);
  triggerfx(var2);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  var1 delete();
  var2 delete();
}

function vo_juggernaut_back_room_nag() {
  level endon("jugg_started");
  level.farah waittill("goal");
  var0 = ["dx_vom_far_dragons_breath_clear_40", "dx_vom_far_dragons_breath_clear_50", "dx_vom_far_dragons_breath_clear_60", "dx_vom_far_dragons_breath_clear_70"];
  var1 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    scripts\engine\utility::flag_wait("in_turbine_room");
    wait 6;
    level.farah scripts\sp\maps\lab\lab_vo_util::nagtill_open("in_turbine_room", var1, 12, 2, 1.2, 1.2, 45);
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
  var0 = ["dx_vom_lff1_juggernaut_allies_80", "dx_vom_lff1_juggernaut_allies_50", "dx_vom_lff1_juggernaut_allies_60"];
  var1 = ["dx_vom_lff2_juggernaut_allies_210", "dx_vom_lff2_juggernaut_allies_170", "dx_vom_lff2_juggernaut_allies_180"];
  var2 = [scripts\engine\sp\utility::create_deck(var0), scripts\engine\sp\utility::create_deck(var1)];
  var3 = 0;

  for(;;) {
    wait randomfloatrange(2, 4);

    if(getaiarray("axis").size == 0 || scripts\engine\utility::flag("fire_suppression_active")) {
      continue;
    }

    var4 = [];

    foreach(var6 in getaiarray("allies")) {
      if(isalive(var6) && var6.voice == "fsafemale" && var6 != level.farah) {
        var4 = var6;
      }
    }

    if(var4.size == 0) {
      continue;
    }

    var8 = scripts\engine\utility::getclosest(level.player.origin, var4);

    if(!isDefined(var8.nag_id)) {
      var8.nag_id = var3;
      var3 = !var3;
    }

    var8 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var2[var8.nag_id] scripts\engine\sp\utility::deck_draw());
    wait randomfloatrange(8, 10);
  }
}

function jugg_combat_nags() {
  if(scripts\engine\utility::flag("juggernaut_dead")) {
    return;
  }

  level endon("juggernaut_dead");
  var0 = ["dx_vom_lff1_juggernaut_allies_80", "dx_vom_lff1_juggernaut_allies_70", "dx_vom_lff1_juggernaut_allies_40"];
  var1 = ["dx_vom_lff2_juggernaut_allies_210", "dx_vom_lff2_juggernaut_allies_200", "dx_vom_lff2_juggernaut_allies_190"];
  var2 = [scripts\engine\sp\utility::create_deck(var0), scripts\engine\sp\utility::create_deck(var1)];
  var0 = ["dx_vom_lff1_juggernaut_allies_90", "dx_vom_lff1_juggernaut_allies_100", "dx_vom_lff1_juggernaut_allies_110", "dx_vom_lff1_juggernaut_allies_120"];
  var1 = ["dx_vom_lff2_juggernaut_allies_220", "dx_vom_lff2_juggernaut_allies_230", "dx_vom_lff2_juggernaut_allies_240", "dx_vom_lff2_juggernaut_allies_250"];
  var3 = [scripts\engine\sp\utility::create_deck(var0), scripts\engine\sp\utility::create_deck(var1)];
  var4 = 0;
  var5 = 0;

  for(;;) {
    wait randomfloatrange(2, 4);

    if(getaiarray("axis").size == 0 || scripts\engine\utility::flag("fire_suppression_active")) {
      continue;
    }

    var6 = [];

    foreach(var8 in getaiarray("allies")) {
      if(isalive(var8) && var8.voice == "fsafemale" && var8 != level.farah) {
        var6 = var8;
      }
    }

    if(var6.size == 0) {
      continue;
    }

    var10 = scripts\engine\utility::getclosest(level.player.origin, var6);

    if(!isDefined(var10.nag_id)) {
      var10.nag_id = var5;
      var5 = !var5;
    }

    if(var4) {
      var10 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var2[var10.nag_id] scripts\engine\sp\utility::deck_draw());
    } else {
      var10 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var3[var10.nag_id] scripts\engine\sp\utility::deck_draw());
    }

    var4 = !var4;
    wait randomfloatrange(8, 10);
  }
}

function post_jugg_nags() {
  level endon("post_jugg_reached_farah");
  wait 16;
  var0 = ["dx_vom_far_juggernaut_outro_41", "dx_vom_far_juggernaut_outro_42"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  level.farah scripts\sp\maps\lab\lab_vo_util::nagtill(undefined, var1, 12, 2, 1.5, 1.2, 45, 5);
}

function vo_juggernaut_kills() {
  level.juggernaut_1 endon("death");
  var0 = 0;
  var1 = getaiarray("allies");
  var2 = var1.size + 1;
  var3 = ["dx_vom_jugg_juggernaut_shootplayer_40", "dx_vom_jugg_juggernaut_shootplayer_50"];
  var4 = scripts\engine\sp\utility::create_deck(var3);

  for(;;) {
    level waittill("ai_killed", var5, var6);

    if(!scripts\engine\utility::is_equal(level.juggernaut_1, var6)) {
      continue;
    }

    var0++;

    if(var0 == 1) {
      level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_jugg_juggernaut_killfighter_10");
      continue;
    }

    if(level.jugg_allies.size == 1) {
      level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_jugg_juggernaut_killfighter_20");
      continue;
    }

    level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var4 scripts\engine\sp\utility::deck_draw());
  }
}

function vo_juggernaut_damage() {
  level.juggernaut_1 endon("death");
  var0 = -1;
  var1 = -1;
  var2 = level.juggernaut_1.maxhealth;
  var3 = [];
  GscBinSkip0(0x2e, var3.size, "dx_vom_jugg_juggernaut_shootjug_highhealth_10");
}

function vo_juggernaut_fire() {
  level.juggernaut_1 endon("death");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_jugg_juggernaut_shootplayer_10");
}

function juggernaut_intro_scene() {
  scripts\engine\utility::flag_wait("turbines_clear");
  var0 = scripts\engine\utility::getStruct("t2_end_obj_struct", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("cp_5_juggernaut_start") && scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, var0.origin)) {
      break;
    }

    waitframe();
  }

  setmusicstate("mx_lab_jugg_combat");
  setsaveddvar("SLMRSNOSK", 0);
  thread juggernaut_allies_setup();
  juggernaut_spawn();
  var1 = getEntArray("cp_5_doors", "script_noteworthy");
  var2 = scripts\engine\utility::getStruct("chokepoint_5_animnode", "targetname");
  var3 = scripts\engine\utility::array_combine([level.juggernaut_1], var1);
  var2 thread scripts\common\anim::anim_first_frame_solo(level.juggernaut_1, "cp_5_juggernaut");

  foreach(var5 in getaiarray("allies")) {
    var5.dontmelee = 1;
  }

  scripts\engine\utility::flag_set("jugg_started");
  thread juggernaut_intro_fx();

  if(isDefined(level.player) && level.player.health > 40) {
    level.player scripts\engine\utility::delaythread(0.5, &scripts\sp\utility::do_damage, 25, level.juggernaut_1.origin, level.juggernaut_1);
  }

  level.player allowmelee(0);
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  var2 scripts\sp\player_rig::link_player_to_rig("cp_5_juggernaut", "stand", undefined, 0, 0, 0, 0, 0, 0);
  setup_detonator();
  thread juggernaut_scene_setup();
  thread juggernaut_door_anims(var2, var1);
  level.jugg_detonator scripts\engine\utility::delaythread(2.5, &fake_jugg_detonator_lights_off);
  scripts\sp\utility::delete_live_grenades();
  thread stop_player_anim_on_death();
  clearallcorpses();
  var2 thread scripts\common\anim::anim_single_solo(level.juggernaut_1, "cp_5_juggernaut");
  var2 scripts\common\anim::anim_single([level.player_rig, level.jugg_detonator], "cp_5_juggernaut");
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

function fake_jugg_detonator_lights_off(var0) {
  self endon("entitydeleted");
  var1 = [0.3, 0.2, 0.2, 0.4, 0.2, 0.5, 0.3, 0.2, 0.4, 0.2, 0.3, 0.3, 0.3, 0.2, 0.2, 0.4];

  for(var2 = 0; var2 < var1.size; var2++) {
    wait var1[var2];
    self setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed_off");
    var2++;
    wait var1[var2];
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
  var0 = getEntArray("jugg_lights", "targetname");

  foreach(var2 in var0) {
    var2.og_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }

  var2 = getEnt("jugg_lights_02", "targetname");
  var2.og_intensity = var2 getlightintensity();
  var2 setlightintensity(0);
}

function juggernaut_lighting() {
  var0 = getEntArray("jugg_lights", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.og_intensity);
  }

  var2 = getEnt("jugg_lights_02", "targetname");
  var2 setlightintensity(var2.og_intensity);
  level waittill("jugg_anim_over");
  var0 = getEntArray("jugg_lights", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function juggernaut_door_anims(var0, var1) {
  var0 scripts\common\anim::anim_single(var1, "cp_5_juggernaut");

  foreach(var3 in var1) {
    var3.collision connectpaths();
    var3.collision disconnectPaths();
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

  foreach(var1 in level.heroes) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\engine\utility::set_movement_speed(250);

    if(!isDefined(var1.magic_bullet_shield)) {
      var2 = 10;
      var1.og_health = var1.health;
      var1.health = 20;
      var1.dontmelee = 1;
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
  var0 = self.maxhealth / 4;
  self.d1_health = var0 * 3;
  self.d2_health = var0 * 2;
  self.d3_health = var0;
  self.d4_health = var0 * 0.5;
  self.starting_health = self.maxhealth;
  self getenemyinfo(level.player);
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
}

function jugg_dmg_modifier(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isalive(self)) {
    return;
  }

  self endon("death");

  if(!istrue(self.allowpain) && isDefined(var9) && scripts\engine\utility::is_equal(getweaponbasename(var9), "flash")) {
    self.allowpain = 1;
  }

  if(isDefined(var0) && isDefined(var1)) {
    if(!scripts\engine\utility::is_equal(var1, level.player)) {
      var10 = int(var0 * 0.7);
      self.health += var10;
    } else if(scripts\engine\utility::is_equal(var1, level.player)) {
      if(scripts\engine\utility::is_equal(var4, "MOD_MELEE")) {
        var10 = int(var0 * 0.8);
        self.health += var10;
        self notify("melee_damage_taken");
      }

      if(scripts\engine\utility::is_equal(level.player.currentweapon.basename, "iw8_sh_oscar12")) {
        var10 = int(var0 * 0.6);
        self.health += var10;
      }

      if(isDefined(var9) && getweaponbasename(var9) == "iw8_sh_dpapa12_incendiary" && var4 != "MOD_MELEE") {
        var11 = int(var0 * 0.2);

        if(self.health > var11) {
          self.health -= var11;
        }
      }
    }
  }

  if(var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE" || var4 == "MOD_GRENADE_SPLASH") {
    if(istrue(self.allowpain) && (!isDefined(var9) || !scripts\engine\utility::is_equal(var9.basename, "flash"))) {
      self notify("jugg_stunned");
    }

    self.minpaindamage = 0;

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      var12 = var0 / 2;

      if(var12 < 50) {
        var12 = 50;
      } else if(var12 > 150) {
        var12 = 100;
      }
    } else {
      var12 = 25;
    }

    scripts\sp\utility::do_damage(var12, var4, var2);
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

function debug_state_print(var0) {
  if(getdvarint("scr_jugg_debug")) {
    iprintln("State: " + self.state + " -- health: " + self.health + " -- range: < " + var0);
    return;
  }
}

function jugg_rebel_respawn() {
  if(!isalive(self)) {
    return;
  }

  var0 = self.state;
  var1 = 1;

  while(isalive(self) && var0 == self.state) {
    var2 = 0;
    level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);

    if(var1 && isDefined(level.jugg_allies) && level.jugg_allies.size < 3) {
      var2 = 1;
    }

    var1 = 0;

    if(!var2 && isDefined(level.jugg_allies) && !level.jugg_allies.size) {
      wait 7;

      if(!isalive(self) || var0 != self.state) {
        return;
      }

      var2 = 1;
    }

    if(var2) {
      var3 = getspawnerarray("jugg_ally_respawn");
      var4 = var3[randomintrange(0, 1)];
      var5 = var4 scripts\engine\sp\utility::spawn_ai(1);
      var6 = get_rebel_spawn_struct();
      var5 teleport(var6.origin, var6.angles);
      level.jugg_allies[level.jugg_allies.size] = var5;
      var4.count += 1;
      wait 0.1;
      var7 = getEnt("t2_jugg_fallback", "targetname");
      var5 setgoalvolumeauto(var7);
      var5.fixednode = 0;
    }

    waitframe();
  }
}

function get_rebel_spawn_struct() {
  var0 = getEnt("t2_parking_vol", "targetname");
  var1 = undefined;

  if(level.player istouching(var0)) {
    var2 = scripts\engine\utility::getStructArray("t2_inside_spawn", "targetname");
  } else {}

  for(var2 = scripts\engine\utility::getStructArray("t2_parking_spawn", "targetname"); !isDefined(var2); var2 = var2[0]) {
    if(var2.size <= 1) {
      var2 = var2[0];
      break;
    }

    var2 = sortbydistance(var2, level.player.origin);

    if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos15, var2[0].origin)) {
      var2 = scripts\engine\utility::array_remove(var2, var2[0]);
      continue;
    }
  }

  return var2;
}

function can_weapon_stun_juggernaut(var0, var1) {
  if(var0 == level.player) {
    if(scripts\engine\utility::is_equal(getweaponbasename(var1), "iw8_sh_dpapa12_incendiary")) {
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
  var0 = getEnt("fire_suppression", "targetname");
  thread juggernaut_fire_suppression_setup();
}

function juggernaut_fire_suppression_setup() {
  var0 = [];
  GscBinSkip0(0x2e, "trigger", self);
}

function fire_suppression_logic() {
  var0 = ["dx_vom_jugg_juggernaut_halon_10", "dx_vom_jugg_juggernaut_halon_20", "dx_vom_jugg_juggernaut_halon_30", "dx_vom_jugg_juggernaut_halon_40"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  var0 = ["dx_vom_lff1_juggernaut_allies_10", "dx_vom_lff1_juggernaut_allies_20", "dx_vom_lff1_juggernaut_allies_30"];
  var2 = scripts\engine\sp\utility::create_deck(var0);
  var0 = ["dx_vom_jugg_juggernaut_explosion_dmg_10", "dx_vom_jugg_juggernaut_explosion_dmg_20", "dx_vom_jugg_juggernaut_explosion_dmg_30", "dx_vom_jugg_juggernaut_explosion_dmg_40"];
  var3 = scripts\engine\sp\utility::create_deck(var0);
  scripts\engine\utility::flag_clear("fire_suppression_active");
  fire_suppression_button_on();
  scripts\engine\utility::waittill_any_ents_array(self["buttons"], "trigger");
  scripts\engine\utility::flag_set("fire_suppression_active");
  level.fs_systemactive = 1;
  var4 = scripts\engine\utility::getclosest(level.player.origin, self["buttons"]);
  GscBinSkip4(0x6e, var4, "lab_vm_button_push_plr_c");
}

function reset_all_ai_sight() {
  var0 = getaiarray();

  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    if(isDefined(var2.og_maxvis)) {
      var2 scripts\engine\sp\utility::set_maxvisibledist(var2.og_maxvis);
    }

    if(isDefined(var2.og_maxsightdistsqr)) {
      var2 scripts\engine\sp\utility::set_maxsightdistsquared(var2.og_maxsightdistsqr);
    }
  }
}

function play_fire_system_sound(var0) {
  var1 = getEntArray("turbines_speakers", "script_noteworthy");
  var2 = scripts\engine\utility::getclosest(level.player.origin, var1);
  var2 scripts\engine\utility::playsoundonentity(var0);
}

function play_button_sound(var0) {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  scripts\engine\utility::play_sound_in_space(var0, self.origin);
}

function play_fire_system_sound_loop(var0, var1) {
  var2 = 0;

  if(var2 < var1) {
    GscBinSkip4(0x35, var0);
  }
}

function play_smoke_start_sounds() {
  var0 = scripts\engine\utility::getStructArray("fire_system_structs", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var3 = spawn("script_origin", var3.origin);
    var3.angles = (0, 0, 0);
    var1 = var3;
    var3 childthread scripts\engine\sp\utility::play_sound_on_entity("fire_system_start");
    var3 childthread scripts\engine\utility::play_loop_sound_on_entity("fire_system_hiss");
  }

  wait 19;
  scripts\engine\utility::array_delete(var1);
}

function fire_suppression_jugg_vo(var0, var1) {
  level endon("juggernaut_dead");
  wait 1;
  level.juggernaut_1 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var0 scripts\engine\sp\utility::deck_draw(), 1);
  wait 0.5;
  var2 = getaiarray("allies");
  var3 = scripts\engine\utility::getclosest(level.player.origin, var2);
  var3 scripts\sp\maps\lab\lab_vo_util::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw(), 1, 0.5);
}

function fire_suppression_button_on() {
  foreach(var1 in self["models"]) {
    var1 setModel("electrical_cell_door_button_green");
  }

  foreach(var1 in self["buttons"]) {
    var1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), undefined, 220, 350, 80, 0);
    thread button_interaction_thread(var1);
  }
}

function button_interaction_thread(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    self endon(var1);
  }

  var2 = spawn("script_origin", self.origin);
  var2.origin += rotatevector(var0, self.angles);

  while(isDefined(self)) {
    if(door_check_base(var2) && level.player ismeleeing()) {
      thread scripts\sp\door_internal::bashed_locked_door_sfx();
      level.player viewkick(10, var2.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player playRumbleOnEntity("heavy_1s");
      self notify("trigger");
      break;
    }

    waitframe();
  }
}

function fire_suppression_button_off() {
  foreach(var1 in self["buttons"]) {
    if(isDefined(var1.cursor_hint_ent)) {
      var1 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
  }

  foreach(var1 in self["models"]) {
    var1 setModel("electrical_cell_door_button_red");
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

function player_in_trigger(var0) {
  level endon("end_vision_change");
  wait 0.1;

  while(level.player istouching(var0)) {
    waitframe();
  }

  level notify("player_is_out_of_trigger");
}

function ai_fire_suppression_postspawn() {
  self endon("death");

  if(level.fs_systemactive) {
    GscBinSkip4(0x35);
  }

  var0 = getaiarray("allies");
  var1 = scripts\engine\utility::getclosest(self.origin, var0);
  self getenemyinfo(var1);
  scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
}

function ai_fire_suppression_logic() {
  self endon("death");
  level endon("fire_system_clear");
  self.og_maxvis = self.maxvisibledist;
  self.og_maxsightdistsqr = self.maxsightdistsqrd;
  var0 = 100;
  scripts\engine\sp\utility::set_maxvisibledist(var0);
  scripts\engine\sp\utility::set_maxsightdistsquared(var0 * var0);
  self clearenemy();
  wait 0.2;
  var1 = scripts\engine\utility::waittill_any_timeout(19, "damage", "player_flash", "player_frag", "player_fired_weapon");
  scripts\engine\sp\utility::set_maxvisibledist(self.og_maxvis);
  scripts\engine\sp\utility::set_maxsightdistsquared(self.og_maxsightdistsqr);
}

function juggernaut_fire_suppression_logic(var0, var1) {
  var0 endon("death");
  GscBinSkip4(0x6e, var0, self);
}

function juggernaut_vision_obstructed(var0) {
  self.juggernautvisionobscured = 1;
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0["fs_targets"]);
  var2 = 100;
  scripts\engine\sp\utility::set_maxvisibledist(var2);
  scripts\engine\sp\utility::set_maxsightdistsquared(var2 * var2);
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

    var0 = scripts\engine\utility::getclosest(self.origin, level.jugg_allies);
    self getenemyinfo(var0);
    scripts\engine\sp\utility::set_favoriteenemy(var0);
    var0 scripts\engine\sp\utility::set_favoriteenemy(self);
    var0 waittill("death");
    self clearentitytarget();
  }
}

function juggernaut_player_fired(var0) {
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
  var0 = 0;

  while(isalive(self)) {
    var1 = scripts\engine\utility::flag("ambush_backtrack");

    if(!var0 && var1) {
      GscBinSkip4(0x35);
    }

    if(var0 && !var1) {
      GscBinSkip4(0x35);
    }

    var0 = var1;
    wait 1;
  }
}

function jugg_hide_logic() {
  level notify("stop_patrolling");
  var0 = scripts\engine\utility::getStruct("jugg_wait_struct", "script_noteworthy");
  scripts\engine\utility::flag_set("t2_jugg_fallback_2");
  self clearenemy();
  level.player.ignoreme = 1;
  self.grenadeawareness = 0;

  while(isDefined(level.jugg_allies) && level.jugg_allies.size >= 1) {
    level.jugg_allies = scripts\engine\utility::array_removedead_or_dying(level.jugg_allies);
    waitframe();
  }

  self clearenemy();
  level.jugg_goal = var0 scripts\engine\utility::spawn_script_origin(var0.origin + (0, 0, 20));
  level.jugg_goal makeentitysentient("allies");
  self getenemyinfo(level.jugg_goal);
  scripts\engine\sp\utility::set_favoriteenemy(level.jugg_goal);
  thread scripts\sp\spawner::go_to_node(var0);

  while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin)) {
    waitframe();
  }

  while(scripts\engine\utility::flag("ambush_backtrack")) {
    self teleport(var0.origin, var0.angles);
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
    var0 = scripts\engine\utility::getStructArray("jugg_patroll_structs", "targetname");
    self setgoalpos(self.origin);
    var1 = select_jugg_node(var0);
    thread player_spotted_thread();
    childthread scripts\sp\spawner::go_to_node(var1);

    while(distance2dsquared(self.origin, var1.origin) > 900) {
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

function select_jugg_node(var0) {
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);
  var2 = scripts\engine\utility::getclosest(self.origin, var0);
  var0 scripts\engine\utility::array_remove_array(var0, [var1, var2]);

  if(isDefined(self.current_node)) {
    scripts\engine\utility::array_remove(var0, self.current_node);
  }

  self.current_node = undefined;
  var0 = sortbydistance(var0, level.player.origin);
  var3 = 2;
  var4 = 6;
  var5 = var0[randomintrange(var3, var4)];
  self.current_node = var5;
  return var5;
}

function jugg_can_see_player(var0) {
  if(!jugg_sight_check()) {
    self clearenemy();
    self.goal_radius = 80;
    scripts\sp\spawner::go_to_node(var0);
    return;
  }

  level notify("stop_patrolling");
}

function jugg_sight_check() {
  var0 = level.player getEye();
  return scripts\engine\utility::within_fov(self getEye(), self.angles, var0, level.cos30) && scripts\engine\trace::ray_trace_passed(self getEye(), var0, [self, level.player]);
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

function ai_move_away(var0) {
  level endon("juggernaut_dead");

  if(isDefined(self.my_spawner)) {
    self.my_spawner notify("stop_rebel_flood");
  }

  self notify("entitydeleted");

  if(isDefined(var0)) {
    var1 = am_i_alive(var0);
  } else {
    var1 = self;
  }

  if(!isDefined(var1)) {
    return;
  }

  var1 scripts\engine\sp\utility::disable_ai_color();
  var1 clearpath();
  var1.ignoreme = 1;
  var1.ignoreall = 1;
  var2 = getnode("offices_hold_" + var1.animname, "targetname");
  var1 forceteleport(var2.origin, var2.angles);
  var1 setgoalnode(var2);
  waitframe();

  if(!isDefined(var1)) {
    return;
  }

  var1 allowedstances("stand");
  var1 scripts\anim\notetracks_sp::setpose("stand");
  var1 scripts\sp\maps\lab\lab_util::magic_bullet_safe();
}

function am_i_alive(var0) {
  if(isDefined(self)) {
    return self;
  }

  self notify("entitydeleted");
  self notify("stop_rebel_flood");
  var1 = undefined;

  switch (var0) {
    case "rebel_1":
      level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
      level.heroes[level.heroes.size] = level.rebel_1;
      getspawner("redshirt_rebel_1", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_1, 1);
      var1 = level.rebel_1;
      break;
    case "rebel_2":
      level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
      level.heroes[level.heroes.size] = level.rebel_2;
      getspawner("redshirt_rebel_2", "targetname") thread scripts\sp\maps\lab\lab_util::rebel_flood_spawner(level.rebel_2, 1);
      var1 = level.rebel_2;
      break;
  }

  return var1;
}

function allies_juggernaut_spawn() {
  scripts\engine\utility::flag_clear("jugg_approach");
  level.jugg_allies = [];
  var0 = scripts\engine\sp\utility::array_spawn_targetname("jugg_ally", 1, 1);
  scripts\engine\utility::array_thread(var0, &allies_juggernaut_setup);

  if(isDefined(level.rebel_3)) {
    level.rebel_3 delete();
  }

  self endon("became_ally");
  scripts\engine\utility::flag_wait("jugg_approach");
  var0 = scripts\engine\sp\utility::array_spawn_targetname("jugg_ally_flee", 1, 1);
  scripts\engine\utility::array_thread(var0, &allies_juggernaut_flee);
  thread jugg_rebel_respawn();
  GscBinSkip4(0x35, level.juggernaut_1);
}

function allies_fallback_thread() {
  var0 = getEnt("t2_jugg_fallback", "targetname");
  scripts\engine\utility::flag_wait("t2_jugg_fallback_2");

  foreach(var2 in level.jugg_allies) {
    var2 scripts\engine\sp\utility::disable_ai_color();
    var2 setgoalvolumeauto(var0);
    var2.fixednode = 0;
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
  var0 = [level.player, self];
  self waittill("death");
  var1 = scripts\engine\utility::spawn_script_origin(self.origin + (0, 0, 50));
  scripts\sp\maps\lab\lab_vo_util::wait_combat_cooldown(0.8, 3);

  if(scripts\sp\maps\lab\lab_util::in_player_fov(cos(75), var1.origin, var0)) {
    wait 0.3;
    level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_juggernaut_outro_10");
  } else {
    wait 0.3;
    level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_juggernaut_outro_11");
  }

  wait 2;
  var1 delete();
}

function custom_ammo_function() {
  self.disablereload = 1;
  var0 = self.weapon.clipsize;

  for(;;) {
    self waittill("shooting");

    if(self.bulletsinclip < var0) {
      self.bulletsinclip = var0;
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

  var0 = getEntArray("trigger_multiple_autosave", "classname");

  foreach(var2 in var0) {
    var2 scripts\engine\utility::trigger_off();
  }

  level.dopickyautosavechecks = 1;
  scripts\engine\sp\utility::autosave_by_name("pre_juggernaut_save");

  while(scripts\engine\utility::flag("game_saving")) {
    waitframe();
  }

  level.dopickyautosavechecks = 0;
  scripts\engine\utility::flag_wait("juggernaut_dead");
  scripts\engine\sp\utility::autosave_by_name("post_juggernaut_save");

  foreach(var2 in var0) {
    var2 scripts\engine\utility::trigger_on();
  }
}

function is_jugg_dead() {
  return scripts\engine\utility::flag("juggernaut_dead");
}

function connect_jumpdown_traversal() {
  level endon("juggernaut_dead");
  scripts\engine\utility::flag_wait("player_in_turbine_lower");
  var0 = getnode("ambush_jumpdown", "script_noteworthy");
  var1 = getnode("ambush_jumpdown_end", "script_noteworthy");
  createnavlink(var0.targetname + "_traversal", var0.origin, var1.origin, var0, "axis_combat");
  var0 = getnode("ambush_jumpdown_c", "script_noteworthy");
  var1 = getnode("ambush_jumpdown_end_c", "script_noteworthy");
  createnavlink(var0.targetname + "_traversal", var0.origin, var1.origin, var0, "axis_combat");
}

function disconnect_jumpdown_traversal() {
  var0 = getnode("ambush_jumpdown_b", "script_noteworthy");
  destroynavlink(var0);
  var0 = getnode("ambush_jumpdown_c", "script_noteworthy");
  destroynavlink(var0);
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
  var0 = level.juggernaut_1;
  var1 = vectortoangles(var0.origin - level.player.origin);
  var2 = anglesToForward(var1) * -1;
  var2 *= 100;

  while(length(var2) > 0.02) {
    self pushplayervector(var2, 0);
    var2 *= 0.5;
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
  var0 = getanimlength(level.player_rig scripts\engine\utility::getanim("cp_5_juggernaut"));
  thread scripts\engine\sp\utility::notify_delay("animation_stop_monitoring", 5);
  GscBinSkip4(0x35);
}

function jugg_anim_monitor_dmg() {
  for(;;) {
    self waittill("damage", var0, var1, var0, var0, var0, var0, var0, var0, var0, var2);

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      self notify("stop_animation");

      if(isDefined(var2) && scripts\engine\utility::is_equal(var2.basename, "flash")) {
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
  var0 = self.meleechargedistvsplayer;

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= var0 * var0) {
      self notify("stop_animation");
      return;
    }

    wait 0.05;
  }
}

function cp_5_fastforward_anim() {
  waitframe();
  var0 = scripts\engine\utility::getanim("cp_5_juggernaut");
  var1 = getanimlength(var0);
  self setanimtime(var0, 0.37);
}

function juggernaut_debug() {
  if(getdvarint("scr_jugg_debug")) {
    thread scripts\sp\maps\lab\lab_util::display_enemy_lasknown_pos();
    self.damage_functions[self.damage_functions.size] = &scripts\sp\maps\lab\lab_util::ai_display_dmg;
    return;
  }
}

function pre_office_door_open() {
  var0 = 0;
  var1 = getEnt("jugg_dead_door", "script_noteworthy");
  var1.struct = var1 scripts\engine\sp\utility::get_linked_struct();
  scripts\sp\maps\lab\lab_util::assign_door_ents(var1);
  var1.fakeknob = scripts\engine\utility::getStruct("offices_fake_door_prompt", "targetname");
  thread offices_fake_door_prompt(var1.fakeknob);
  scripts\engine\utility::flag_wait("juggernaut_dead");
  setmusicstate("");
  scripts\engine\sp\utility::transient_load("lab_office_tr");
  var2 = getEnt("offices_event_check", "targetname");

  if(level.player istouching(var2)) {
    var0 = 1;
  }

  if(var0) {
    office_branch_player(var1);
    return;
  }

  office_branch_allies(var1);
}

function offices_fake_door_prompt(var0) {
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE", 45, 200, 55, 1);
  thread door_bash_thread(var0, (5, -10, 10));
  var0 scripts\engine\utility::waittill_any("openning_offices_door", "trigger");
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function office_branch_allies(var0) {
  thread pre_office_teleport_allies(0);

  if(scripts\engine\utility::flag("past_jugg_door")) {
    scripts\engine\utility::flag_clear("past_jugg_door");
  }

  var1 = cos(70);

  for(;;) {
    if(scripts\engine\utility::flag("past_jugg_door")) {
      break;
    } else if(scripts\sp\maps\lab\lab_util::in_player_fov(var1, level.farah.origin + (0, 0, 55))) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("door_guy_started");
  var0 playSound("scrpt_door_metal_heavy_bash_npc");
  var0.fakeknob notify("openning_offices_door");
  var0 rotateTo(var0.struct.angles, 1, 0.5, 0.5);
  var0.collision scripts\engine\utility::delaycall(0.6, &connectpaths);
  var2 = getspawner("post_jugg_door", "targetname");
  level.doorguy = var2 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.doorguy thread scripts\engine\sp\utility::flag_on_death("door_guy_dead");
  wait 1.5;

  if(isDefined(level.doorguy) && isalive(level.doorguy)) {
    level.doorguy kill();
    return;
  }
}

function office_branch_player(var0) {
  thread pre_office_teleport_allies(1);
  var1 = getspawner("post_jugg_door", "targetname");
  level.doorguy = var1 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.doorguy thread scripts\engine\sp\utility::flag_on_death("door_guy_dead");
  var2 = scripts\engine\utility::getStruct("pre_office_obj_struct", "targetname");

  while(!scripts\sp\maps\lab\lab_util::in_player_fov(level.cos15, var2.origin) && !scripts\engine\utility::flag("pre_office_door_flag")) {
    waitframe();
  }

  scripts\engine\utility::flag_set("post_jugg_door");
  var0 playSound("scrpt_door_metal_heavy_bash_npc");
  var0.fakeknob notify("openning_offices_door");
  var0 rotateTo(var0.struct.angles, 1, 0.5, 0.5);
  var0.collision scripts\engine\utility::delaycall(0.6, &connectpaths);
}

function pre_office_teleport_allies(var0) {
  level.farah notify("stop_going_to_node");
  var1 = [level.farah, level.rebel_1, level.rebel_2];

  if(var0) {
    scripts\engine\utility::array_thread(var1, &tele_and_setgoalpos, "post_jugg2_", var0);
    return;
  }

  scripts\engine\utility::array_thread(var1, &tele_and_setgoalpos, "post_jugg1_", var0);
}

function tele_and_setgoalpos(var0, var1) {
  scripts\engine\sp\utility::disable_ai_color();
  var2 = scripts\engine\utility::getStruct(var0 + self.animname, "targetname");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::teleport_ent(var2);
  self.script_pushable = 0;

  if(var1) {
    var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
    self setgoalpos(var3.origin);
    self allowedstances("stand");
    self.ignoreall = 0;
    self.ignoreme = 0;
    return;
  }

  if(self.animname == "farah") {
    scripts\common\ai::disable_arrivals();
    var3 = getnode(var2.target, "targetname");
    self setgoalpos(var2.origin);
    self allowedstances("stand");
    self enableavoidance(0);
    self setgoalnode(var3);

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
    var3 = getnode(var2.target, "targetname");
    self setgoalpos(var2.origin);
    self allowedstances("stand");
    self enableavoidance(0);
    var2 = scripts\engine\utility::getStruct("pre_office_obj_struct", "targetname");
    scripts\common\ai::poi_enable(1, var2);

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
    self setgoalnode(var3);
    return;
  }

  if(self.animname == "rebel_2") {
    scripts\common\ai::disable_arrivals();
    var3 = getnode(var2.target, "targetname");
    self allowedstances("stand");
    self enableavoidance(0);
    var4 = scripts\engine\utility::getStruct("rebel_2_plant0", "targetname");
    var4 thread scripts\common\anim::anim_single_solo(self, "cp_4_plant");
    var5 = scripts\engine\utility::getanim("cp_4_plant");
    waitframe();
    self setanimtime(var5, 0.75);
    self setanimrate(var5, 0);
    var6 = getEnt(var4.targetname + "_bomb", "targetname");
    var6 show();

    while(!isDefined(level.doorguy)) {
      waitframe();
    }

    self setanimrate(var5, 1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_c4_light"), var6, "tag_fx");
    self waittillmatch("single anim", "end");
    self setgoalnode(var3);
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

function turbine_pa_line(var0) {
  var1 = scripts\engine\utility::getStructArray("alarm", "targetname");
  var2 = sortbydistance(var1, level.player.origin)[0];
  scripts\engine\utility::play_sound_in_space(var0, var2.origin);
}