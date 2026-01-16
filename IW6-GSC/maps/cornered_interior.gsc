/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_interior.gsc
**************************************/

cornered_interior_pre_load() {
  common_scripts\utility::flag_init("courtyard_finished");
  common_scripts\utility::flag_init("bar_finished");
  common_scripts\utility::flag_init("junction_finished");
  common_scripts\utility::flag_init("stealth_enabled");
  common_scripts\utility::flag_init("stealth_broken");
  common_scripts\utility::flag_init("hvt_got_away");
  common_scripts\utility::flag_init("baker_at_hallway_exit");
  common_scripts\utility::flag_init("courtyard_intro_elevator_button");
  common_scripts\utility::flag_init("elevator_guy1_done");
  common_scripts\utility::flag_init("courtyard_intro_rorke_done");
  common_scripts\utility::flag_init("courtyard_intro_elevator_opening");
  common_scripts\utility::flag_init("cy_elevator_open");
  common_scripts\utility::flag_init("cy_elevator_closed");
  common_scripts\utility::flag_init("rorke_open_office_a");
  common_scripts\utility::flag_init("courtyard_office_id_vo");
  common_scripts\utility::flag_init("office_guy_killed");
  common_scripts\utility::flag_init("courtyard_reception_office_a_chopper_shine_spotlight");
  common_scripts\utility::flag_init("courtyard_reception_office_a_chopper_exit");
  common_scripts\utility::flag_init("office_a_chopper_spotlight_on");
  common_scripts\utility::flag_init("office_a_chopper_spotlight_off_and_exit");
  common_scripts\utility::flag_init("at_cy_exit_door");
  common_scripts\utility::flag_init("cy_office_stealth_broken");
  common_scripts\utility::flag_init("skipped_firework_office");
  common_scripts\utility::flag_init("bar_light_shot");
  common_scripts\utility::flag_init("rorke_shoot_tv");
  common_scripts\utility::flag_init("rorke_shot_tv");
  common_scripts\utility::flag_init("strobe_on");
  common_scripts\utility::flag_init("strobe_off");
  common_scripts\utility::flag_init("bar_wave2");
  common_scripts\utility::flag_init("activate_strobe_off_failsafe");
  common_scripts\utility::flag_init("starting_bar_reaction");
  common_scripts\utility::flag_init("bar_enemies_reacted");
  common_scripts\utility::flag_init("bar_guy_killed");
  common_scripts\utility::flag_init("player_touched_enemy");
  common_scripts\utility::flag_init("2nd_wave_standard");
  common_scripts\utility::flag_init("last_bar_enemy_reacted");
  common_scripts\utility::flag_init("player_started_bar_combat");
  common_scripts\utility::flag_init("player_broke_bar_combat");
  common_scripts\utility::flag_init("e09_path_done");
  common_scripts\utility::flag_init("e10_path_done");
  common_scripts\utility::flag_init("merrick_in_airlock");
  common_scripts\utility::flag_init("rorke_opening_junction_exit_door");
  common_scripts\utility::flag_init("rorke_starts_handoff_anim");
  common_scripts\utility::flag_init("start_junction_pip_scenario");
  common_scripts\utility::flag_init("hesh_elevator_vo_said");
  common_scripts\utility::flag_init("start_hesh_elevator_exit");
  common_scripts\utility::flag_init("player_shutting_down_elevators");
  common_scripts\utility::flag_init("start_disable_elevators");
  common_scripts\utility::flag_init("spawn_junction_enemies_wave_2");
  common_scripts\utility::flag_init("junction_enemies_wave_2");
  common_scripts\utility::flag_init("junction_enemies_dead");
  common_scripts\utility::flag_init("c4_vo_over");
  precachemodel("cnd_banner_sim");
  precachemodel("cnd_banner2_sim");
  precachemodel("cnd_server_control_panel_anim_obj");
  precachemodel("weapon_c4");
  precachemodel("cnd_rope_rappel_coil_04_obj");
  precachemodel("com_blackhawk_spotlight_on_mg_setup");
  precacheturret("heli_spotlight");
  precachemodel("cnd_controlpanel_elevator_grn_01");
  precachemodel("cnd_controlpanel_elevator_grn_02");
  precachemodel("cnd_controlpanel_elevator_grn_03");
  precachemodel("cnd_controlpanel_elevator_grn_04");
  precachemodel("cnd_controlpanel_elevator_grn_05");
  precachemodel("cnd_controlpanel_elevator_grn_06");
  precachemodel("cnd_controlpanel_elevator_red_07");
  precachemodel("cnd_controlpanel_elevator_red_08");
  precachemodel("cnd_controlpanel_elevator_red_09");
  precachemodel("cnd_controlpanel_elevator_red_10");
  precachemodel("cnd_controlpanel_elevator_red_11");
  precachemodel("cnd_controlpanel_elevator_red_12");
  precacheshader("hud_icon_strobe");
  precachestring(&"CORNERED_RORKE_WAS_KILLED");
  precachestring(&"CORNERED_BAKER_WAS_KILLED");
  precachestring(&"CORNERED_HVT_GOT_AWAY");
  precachestring(&"CORNERED_STROBE_ON");
  precachestring(&"CORNERED_STROBE_OFF");
  precachestring(&"CORNERED_DISABLE_ELEVATORS");
  precachestring(&"CORNERED_DISABLE_ELEVATORS_CONSOLE");
  maps\_utility::add_hint_string("turn_on_strobe", & "CORNERED_STROBE_ON", ::strobe_on_hide_hint);
  maps\_utility::add_hint_string("turn_off_strobe", & "CORNERED_STROBE_OFF", ::strobe_off_hide_hint);
  level.combat_rappel_rope_coil_rorke = getent("combat_rappel_rope_coil_rorke", "targetname");
  level.combat_rappel_rope_coil_rorke hide();
  level.combat_rappel_rope_coil_player = getent("combat_rappel_rope_coil_player", "targetname");
  level.combat_rappel_rope_coil_player hide();
  level.combat_rappel_rope_coil_baker = getent("combat_rappel_rope_coil_baker", "targetname");
  level.combat_rappel_rope_coil_baker hide();
}

setup_courtyard() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  level.started_courtyard_from_startpoint = 1;
  level.player switchtoweapon("imbel+acog_sp+silencer_sp");
  level.allies[level.const_baker] thread courtyard_intro_baker_exit();
  common_scripts\utility::flag_set("inverted_baker_done");
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("courtyard");
  thread maps\cornered_lighting::fireworks_courtyard();
  thread courtyard_intro_elevator();
  thread courtyard_directory();
  thread courtyard_intro_elevator_guys();
  thread maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::delete_window_reflectors();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  maps\cornered_lighting::do_specular_sun_lerp(1);
  level.player thread maps\cornered_building_entry::player_handle_outside_effects();
}

setup_bar() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  level.started_bar_from_startpoint = 1;
  maps\_utility::vision_set_fog_changes("cornered_04", 0.05);
  level.player switchtoweapon("imbel+acog_sp+silencer_sp");
  thread bar_prep();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_lighting::fireworks_courtyard_post();
  thread maps\cornered_audio::aud_check("bar");
  thread maps\cornered_audio::aud_bar("amb");
  thread maps\cornered_audio::aud_bar("stop");
  thread maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::delete_window_reflectors();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  maps\cornered_code::custom_cornered_stealth_settings();
  level.player maps\_stealth_utility::stealth_default();
  level.allies[level.const_rorke] maps\_stealth_utility::stealth_default();
  level.allies[level.const_rorke] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_rorke] maps\_utility::disable_ai_color();
  level.allies[level.const_rorke] maps\_utility::enable_arrivals();
  level.allies[level.const_rorke] maps\_utility::enable_exits();
  level.allies[level.const_baker] maps\_stealth_utility::stealth_default();
  level.allies[level.const_baker] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_baker] maps\_utility::disable_ai_color();
  level.allies[level.const_baker] maps\_utility::enable_arrivals();
  level.allies[level.const_baker] maps\_utility::enable_exits();
  thread maps\cornered_code::custom_bar_stealth_setting();
  thread maps\_stealth_utility::stealth_corpse_reset_time_custom(10);
}

setup_junction() {
  if(maps\cornered_code::is_e3()) {
    thread maps\cornered::e3_transition_start();
    return;
  }

  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  level.started_junction_from_startpoint = 1;
  level.player switchtoweapon("imbel+acog_sp+silencer_sp");
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("junction");
  maps\cornered_code::delete_building_glow();
  thread maps\cornered_code::cleanup_outside_ents_on_entry();
  maps\cornered_code::custom_cornered_stealth_settings();
  level.player maps\_stealth_utility::stealth_default();
  level.allies[level.const_rorke] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_rorke] maps\_utility::disable_ai_color();
  level.allies[level.const_rorke] maps\_utility::enable_arrivals();
  level.allies[level.const_rorke] maps\_utility::enable_exits();
  level.allies[level.const_baker] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_baker] maps\_utility::disable_ai_color();
  level.allies[level.const_baker] maps\_utility::enable_arrivals();
  level.allies[level.const_baker] maps\_utility::enable_exits();
  var_0 = getent("junction_entrance_player_clip", "targetname");
  var_0 delete();
}

begin_courtyard() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  thread courtyard_transient_unload();
  thread courtyard_transient_load();
  maps\cornered_code::take_away_offhands();
  maps\cornered_code::custom_cornered_stealth_settings();
  level.player maps\_stealth_utility::stealth_default();
  level.allies[level.const_rorke] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_rorke] maps\_utility::disable_ai_color();
  level.allies[level.const_rorke] maps\_utility::enable_arrivals();
  level.allies[level.const_rorke] maps\_utility::enable_exits();
  level.allies[level.const_baker] thread maps\cornered_code::ally_stealth_settings();
  level.allies[level.const_baker] maps\_utility::disable_ai_color();
  level.allies[level.const_baker] maps\_utility::enable_arrivals();
  level.allies[level.const_baker] maps\_utility::enable_exits();
  common_scripts\utility::waitframe();
  thread maps\cornered_lighting::cnd_reception_elevator();
  thread courtyard_intro_handler();
  common_scripts\utility::flag_wait("courtyard_finished");
}

begin_bar() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  maps\cornered_code::take_away_offhands();
  common_scripts\utility::exploder("light_halogen_bar");
  level.allies[level.const_rorke] thread bar_rorke();
  common_scripts\utility::flag_wait("bar_finished");
  thread maps\_utility::autosave_now();
}

begin_junction() {
  if(maps\cornered_code::is_e3()) {
    return;
  }
  maps\cornered_code::take_away_offhands();
  thread junction_handler();
  common_scripts\utility::flag_wait("junction_finished");
  thread maps\_utility::autosave_now();
}

junction_fireworks() {
  maps\cornered_lighting::fireworks_stop();
  common_scripts\utility::waitframe();
  maps\cornered_lighting::fireworks_junction();
}

courtyard_intro_handler() {
  level.allies[level.const_rorke] thread courtyard_intro_rorke();
  thread courtyard_intro_ally_vo();
  common_scripts\utility::flag_wait_all("courtyard_intro_rorke_done", "courtyard_intro_patrol_dead");
  common_scripts\utility::flag_clear("stealth_broken");

  while(!maps\_stealth_utility::stealth_is_everything_normal())
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_clear("_stealth_spotted");
  level.allies[level.const_rorke] thread courtyard_rorke();
}

courtyard_transient_unload() {
  common_scripts\utility::flag_wait("courtyard_transient_unload");
  maps\_utility::transient_unload("cornered_start_tr");
}

courtyard_directory() {
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingameloopresident("cornered_directory");
  common_scripts\utility::flag_wait("move_to_office_a_half_wall");
  stopcinematicingame();
}

courtyard_intro_rorke() {
  level endon("rorke_killed");
  level endon("rorke_killed_2");
  self endon("death");
  self.shootstyle = "single";
  self.oldgoalradius = self.goalradius;
  self.goalradius = 16;
  maps\_utility::set_battlechatter(0);
  var_0 = getnode("cy_rorke_01", "targetname");
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("courtyard_intro_check_stairs");
  var_1 = common_scripts\utility::getstruct("courtyard_entry_animnode", "targetname");
  var_1 maps\_anim::anim_reach_solo(self, "cornered_courtyard_rail_check");

  if(!common_scripts\utility::flag("move_to_courtyard_new"))
    var_1 maps\_anim::anim_single_solo(self, "cornered_courtyard_rail_check");

  var_0 = getnode("hallway_stairs_rorke", "targetname");
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("move_to_courtyard_entrance");
  var_0 = getnode("hallway_stairs2_rorke", "targetname");
  self setgoalnode(var_0);
  wait 5.0;

  if(!common_scripts\utility::flag("courtyard_intro_patrol_dead")) {
    level notify("rorke_stealth_end");
    self.maxsightdistsqrd = 64000000;
    self.ignoreall = 0;
    self.ignoresuppression = 1;
    self.dontevershoot = undefined;
    self.baseaccuracy = 5000000;
    var_2 = maps\_utility::get_living_ai("courtyard_intro_guys_elevator", "script_noteworthy");
    var_3 = maps\_utility::get_living_ai("courtyard_intro_guys_elevator_2", "script_noteworthy");

    if(isDefined(var_2) && isalive(var_2)) {
      while(isalive(var_2)) {
        self.favoriteenemy = var_2;
        var_2.threatbias = 20000;
        var_2.ignoreme = 0;
        var_2.dontattackme = undefined;
        var_2.health = 1;
        wait 0.25;
      }

      wait 0.5;
    }

    if(isDefined(var_3) && isalive(var_3)) {
      while(isalive(var_3)) {
        self.favoriteenemy = var_3;
        var_3.threatbias = 20000;
        var_3.ignoreme = 0;
        var_3.dontattackme = undefined;
        var_3.health = 1;
        wait 0.25;
      }
    }

    wait 0.5;
    common_scripts\utility::flag_clear("stealth_broken");
    thread maps\cornered_code::ally_stealth_settings();
  }

  common_scripts\utility::flag_set("courtyard_intro_rorke_done");
}

courtyard_intro_ally_vo() {
  common_scripts\utility::flag_wait("move_to_courtyard_new");

  if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("courtyard_intro_patrol_dead"))
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_dropem");

  common_scripts\utility::flag_wait("courtyard_intro_patrol_dead");
  wait 0.25;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_clear");
}

courtyard_intro_baker_exit() {
  level endon("baker_killed");
  self endon("death");
  var_0 = getnode("courtyard_baker_wait", "targetname");
  common_scripts\utility::flag_wait("inverted_baker_done");
  var_1 = common_scripts\utility::getstruct("elevator_script_node", "targetname");
  var_1.angles = (0, 0, 0);
  var_1 maps\_anim::anim_first_frame_solo(self, "baker_enter_junction");
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

courtyard_intro_elevator_guys() {
  maps\_utility::array_spawn_function_targetname("courtyard_intro_elevator_guy", ::courtyard_intro_elevator_guy);
  common_scripts\utility::flag_wait("courtyard_intro_goto_elevator");
  maps\_utility::array_spawn_targetname("courtyard_intro_elevator_guy", 1);
}

courtyard_intro_elevator_guy() {
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 1;
  thread courtyard_intro_elevator_guy_fail();
  maps\_stealth_utility::stealth_pre_spotted_function_custom(::bar_spotted_func);
  var_0 = [];
  var_0["hidden"] = maps\_stealth_behavior_enemy::enemy_state_hidden;
  var_0["spotted"] = maps\cornered_code::custom_bar_enemy_state_spotted;
  maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_0);
  self endon("damage");
  self endon("death");
  self endon("_stealth_spotted");
  self.animname = "generic";
  var_1 = common_scripts\utility::getstruct("courtyard_lobby_elevator_door_r_dest", "targetname");

  if(self.script_noteworthy == "courtyard_intro_guys_elevator") {
    var_1 thread maps\_anim::anim_single_solo(self, "cornered_courtyard_elevator_enter");
    common_scripts\utility::flag_set("courtyard_intro_elevator_button");
    self waittillmatch("single anim", "elevator_open");
    self waittillmatch("single anim", "elevator_close");
    common_scripts\utility::flag_set("elevator_guy1_done");
    thread maps\cornered_audio::aud_door("elevator_close");
  } else
    var_1 thread maps\_anim::anim_single_solo(self, "cornered_courtyard_elevator_enter_enemy2");

  self waittillmatch("single anim", "end");
  common_scripts\utility::flag_wait("cy_elevator_closed");

  if(isalive(self))
    self delete();
}

courtyard_intro_elevator_guy_fail() {
  self endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");

  if(common_scripts\utility::flag("cy_elevator_closed")) {
    self.ignoreall = 1;
    self.ignoreme = 1;
    self delete();
  } else if(common_scripts\utility::flag("elevator_guy1_done") && !common_scripts\utility::flag("cy_elevator_closed")) {
    maps\_stealth_utility::disable_stealth_for_ai();
    common_scripts\utility::flag_wait("cy_elevator_open");
    var_0 = getnodearray("elevator_guy_fail_node", "targetname");

    if(!isnodeoccupied(var_0[0]))
      self setgoalnode(var_0[0]);
    else
      self setgoalnode(var_0[1]);
  } else {
    self notify("end_patrol");
    maps\_stealth_utility::disable_stealth_for_ai();
    var_0 = getnodearray("elevator_guy_fail_node", "targetname");

    if(!isnodeoccupied(var_0[0]))
      self setgoalnode(var_0[0]);
    else
      self setgoalnode(var_0[1]);
  }
}

courtyard_intro_elevator() {
  level endon("cy_elevator_closed");
  var_0 = getent("courtyard_lobby_elevator_door_r", "targetname");
  var_1 = getent("courtyard_lobby_elevator_door_l", "targetname");
  var_2 = getent("courtyard_lobby_elevator_door_l_clip", "targetname");
  var_3 = getent("courtyard_lobby_elevator_door_r_clip", "targetname");
  var_4 = var_0.origin;
  var_5 = var_1.origin;
  var_6 = common_scripts\utility::getstruct("courtyard_lobby_elevator_door_r_dest", "targetname");
  var_7 = common_scripts\utility::getstruct("courtyard_lobby_elevator_door_l_dest", "targetname");
  var_2 linkto(var_1);
  var_3 linkto(var_0);
  var_8 = getent("courtyard_lobby_elevator_blocker", "targetname");
  common_scripts\utility::flag_wait("courtyard_intro_elevator_button");
  wait 2.25;
  wait 3.55;
  var_9 = getent("courtyard_lobby_elevator_door_r", "targetname");
  thread common_scripts\utility::play_sound_in_space("crnd_elev_bell", var_9.origin);
  wait 1;
  common_scripts\utility::flag_set("courtyard_intro_elevator_opening");
  thread maps\cornered_audio::aud_door("elevator_open");
  var_0 moveto(var_6.origin, 1.5, 0.25, 0.4);
  var_1 moveto(var_7.origin, 1.5, 0.25, 0.4);
  wait 0.95;
  var_8 notsolid();
  var_8 connectpaths();
  var_2 connectpaths();
  var_3 connectpaths();
}

courtyard_rorke() {
  level endon("rorke_killed");
  level endon("rorke_killed_2");
  level.allies[1] endon("death");
  level.player endon("death");
  thread maps\_stealth_visibility_system::system_event_change("hidden");
  thread maps\cornered_code::custom_bar_stealth_setting();
  var_0 = common_scripts\utility::getstruct("courtyard_office_entry_animnode", "targetname");
  thread add_magic_bullet_shield_if_off();
  thread courtyard_office_ally_vo();
  thread courtyard_office_a_doors();
  thread courtyard_office_enemies();
  thread courtyard_office_props();
  thread courtyard_office_stealth_end();
  var_1 = getnode("cy_rorke_02", "targetname");
  self setgoalnode(var_1);
  common_scripts\utility::flag_wait("move_to_office_door");
  common_scripts\utility::exploder(13);
  var_0 maps\_anim::anim_reach_solo(self, "cornered_courtyard_office_door_merrick_enter");
  var_0 maps\_anim::anim_single_solo(self, "cornered_courtyard_office_door_merrick_enter");

  if(!common_scripts\utility::flag("baker_security_vo"))
    var_0 thread maps\_anim::anim_loop_solo(self, "cornered_courtyard_office_door_merrick_idle", "stop_loop");

  common_scripts\utility::flag_wait("baker_security_vo");
  var_0 notify("stop_loop");
  common_scripts\utility::flag_set("rorke_open_office_a");
  thread maps\_utility::autosave_by_name("courtyard_office");
  var_0 thread maps\_anim::anim_single_solo(self, "cornered_courtyard_office_door_merrick_exit");
  common_scripts\utility::flag_set("courtyard_office_id_vo");
  thread bar_prep();
  maps\_utility::delaythread(0.5, ::courtyard_office_chopper);
  maps\_utility::delaythread(1, ::setup_office_enemy_vo);
  thread maps\cornered_audio::aud_door("carani");
  wait 3.0;
  maps\_utility::forceuseweapon("kriss+eotechsmg_sp+silencer_sp", "primary");
  self.lastweapon = self.weapon;

  if(!common_scripts\utility::flag("cy_office_stealth_broken"))
    self waittillmatch("single anim", "end");
  else
    self stopanimscripted();

  if(!common_scripts\utility::flag("move_to_office_a_half_wall")) {
    if(!common_scripts\utility::flag("cy_office_stealth_broken")) {
      var_1 = common_scripts\utility::spawn_tag_origin();
      var_1 thread maps\_anim::anim_loop_solo(self, "CornerCrR_alert_idle", "stop_loop");
      common_scripts\utility::flag_wait_or_timeout("move_to_office_a_half_wall", 3);
      var_1 notify("stop_loop");
      waittillframeend;
      var_1 delete();
    }
  }

  if(!common_scripts\utility::flag("cy_office_stealth_broken"))
    var_0 maps\_anim::anim_single_solo(self, "cornered_courtyard_office_sneak_merrick_exit");

  self.fixednode = 0;

  if(!common_scripts\utility::flag("cy_office_stealth_broken")) {
    var_2 = getent("office_rorke_gundown_volume", "targetname");
    self setgoalvolumeauto(var_2);
  } else {
    var_2 = getent("player_in_office", "targetname");
    self setgoalvolumeauto(var_2);
  }

  if(!common_scripts\utility::flag("_stealth_spotted"))
    wait 0.35;

  if(!common_scripts\utility::flag("office_guys_dead")) {
    thread courtyard_rorke_failsafe();
    level notify("rorke_stealth_end");
    self.maxsightdistsqrd = 64000000;
    self.ignoreall = 0;
    self.ignoresuppression = 1;
    self.dontevershoot = undefined;
    self.baseaccuracy = 5000000;
    add_magic_bullet_shield_if_off();
    var_3 = maps\_utility::get_living_ai_array("office_guys", "script_noteworthy");

    if(isalive(level.office_guy_c)) {
      if(!isalive(self.enemy))
        self.favoriteenemy = level.office_guy_c;

      while(isalive(level.office_guy_c)) {
        level.office_guy_c.dontattackme = undefined;
        level.office_guy_c.health = 1;
        level.office_guy_c.threatbias = 20000;
        level.office_guy_c.ignoreme = 0;
        wait 0.75;
      }
    }

    wait 1;

    while(!common_scripts\utility::flag("office_guys_dead")) {
      foreach(var_5 in var_3) {
        if(!isalive(var_5)) {
          continue;
        }
        if(!isalive(self.enemy))
          self.favoriteenemy = var_5;

        while(isalive(var_5)) {
          var_5.dontattackme = undefined;
          var_5.health = 1;
          var_5.threatbias = 20000;
          var_5.ignoreme = 0;
          wait 0.75;
        }

        wait 1;
      }
    }

    wait 0.5;
  }

  foreach(var_8 in level.players) {
    if(var_8 maps\_utility::ent_flag_exist("_stealth_enabled"))
      var_8 maps\_utility::ent_flag_set("_stealth_enabled");

    if(isalive(var_8))
      var_8 thread maps\_stealth_visibility_friendly::friendly_visibility_logic();
  }

  thread maps\cornered_code::ally_stealth_settings();
  common_scripts\utility::flag_wait("office_guys_dead");
  maps\_utility::enable_cqbwalk();
  self cleargoalvolume();
  self.fixednode = 1;

  if(!common_scripts\utility::flag("skipped_firework_office")) {
    thread maps\_stealth_visibility_system::system_event_change("hidden");
    maps\_utility::delaythread(0.1, maps\cornered_code::custom_bar_stealth_setting);
    maps\_utility::delaythread(0.1, maps\_stealth_utility::stealth_corpse_reset_time_custom, 10);
    var_0 = common_scripts\utility::getstruct("rorke_exit_office_approach", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "corner_standL_trans_CQB_IN_2");
  }

  if(!common_scripts\utility::flag("move_across_bridge") && !common_scripts\utility::flag("skipped_firework_office")) {
    var_0 maps\_anim::anim_single_solo(self, "corner_standL_trans_CQB_IN_2");
    common_scripts\utility::flag_set("at_cy_exit_door");
  }

  var_0 = common_scripts\utility::getstruct("courtyard_office_exit_animnode", "targetname");

  if(!common_scripts\utility::flag("move_across_bridge") && !common_scripts\utility::flag("skipped_firework_office")) {
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 thread maps\_anim::anim_loop_solo(self, "corner_standL_alert_idle", "stop_loop");
    common_scripts\utility::flag_wait("move_across_bridge");
    var_1 notify("stop_loop");
    waittillframeend;
    var_1 delete();
  } else
    common_scripts\utility::flag_wait("move_across_bridge");

  if(common_scripts\utility::flag("at_cy_exit_door"))
    var_0 maps\_anim::anim_single_solo(self, "cornered_courtyard_office_exit_merrick");

  thread maps\cornered_audio::aud_bar("amb");
  thread maps\cornered_audio::aud_bar("stop");
  var_0 = common_scripts\utility::getstruct("rorke_bridge_anim", "targetname");

  if(!common_scripts\utility::flag("skipped_firework_office")) {
    var_0 maps\_anim::anim_reach_solo(self, "cornered_courtyard_bridge_check");

    if(!common_scripts\utility::flag("go_bar_walker"))
      var_0 maps\_anim::anim_single_solo(self, "cornered_courtyard_bridge_check");

    var_1 = getnode("bar_entrance_stairs_rorke", "targetname");
    self setgoalnode(var_1);
    common_scripts\utility::flag_wait("rorke_bar_position");
  }

  common_scripts\utility::flag_set("courtyard_finished");
  thread maps\_utility::autosave_stealth();
}

courtyard_rorke_failsafe() {
  level endon("office_guys_dead");
  common_scripts\utility::flag_wait("rorke_shoot_tv");

  if(!common_scripts\utility::flag("office_guys_dead")) {
    common_scripts\utility::flag_set("skipped_firework_office");

    foreach(var_1 in level.firework_enemies) {
      if(isalive(var_1))
        var_1 kill();
    }
  }
}

courtyard_office_stealth_end() {
  level endon("cy_office_stealth");
  level waittill("cy_office_spotted");
  maps\_stealth_utility::disable_stealth_system();
  common_scripts\utility::flag_set("cy_office_stealth_broken");
  level notify("cy_office_stealth");
}

courtyard_office_enemies() {
  maps\_utility::array_spawn_function_targetname("office_guys_new", ::courtyard_office_death);
  maps\_utility::array_spawn_function_targetname("office_guys_new", ::courtyard_office_enemy_anim);
  common_scripts\utility::flag_wait("rorke_open_office_a");
  level.firework_enemies = maps\_utility::array_spawn_targetname("office_guys_new", 1);
}

courtyard_office_death() {
  self waittill("death");
  common_scripts\utility::flag_set("office_guy_killed");
}

courtyard_office_enemy_anim() {
  self endon("death");
  maps\_stealth_utility::stealth_pre_spotted_function_custom(::bar_spotted_func);
  var_0 = common_scripts\utility::getstruct("courtyard_office_animnode", "targetname");
  self.allowdeath = 1;
  self.animname = "generic";
  var_1 = [];
  var_1["hidden"] = maps\_stealth_behavior_enemy::enemy_state_hidden;
  var_1["spotted"] = maps\cornered_code::custom_bar_enemy_state_spotted;
  maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_1);

  if(self.script_parameters == "office_guy_a") {
    level.office_guy_a = self;
    self.health = 20;
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_office_fireworks_crowd_guard1");
    common_scripts\utility::flag_wait("rorke_open_office_a");
    var_0 thread maps\_anim::anim_single_solo(self, "cornered_office_fireworks_crowd_guard1");
  }

  if(self.script_parameters == "office_guy_b") {
    self.health = 20;
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_office_fireworks_crowd_guard2");
    common_scripts\utility::flag_wait("rorke_open_office_a");
    var_0 thread maps\_anim::anim_single_solo(self, "cornered_office_fireworks_crowd_guard2");
  }

  if(self.script_parameters == "office_guy_c") {
    level.office_guy_c = self;
    self.health = 1;
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_office_fireworks_crowd_guard3");
    common_scripts\utility::flag_wait("rorke_open_office_a");
    var_0 thread maps\_anim::anim_single_solo(self, "cornered_office_fireworks_crowd_guard3");
  }

  if(self.script_parameters == "office_guy_d") {
    level.office_guy_d = self;
    self.health = 20;
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_office_fireworks_crowd_guard4");
    common_scripts\utility::flag_wait("rorke_open_office_a");
    var_0 thread maps\_anim::anim_single_solo(self, "cornered_office_fireworks_crowd_guard4");
  }

  if(self.script_parameters == "office_guy_e") {
    level.office_guy_e = self;
    self.health = 20;
    var_0 maps\_anim::anim_first_frame_solo(self, "cornered_office_fireworks_crowd_guard5");
    common_scripts\utility::flag_wait("rorke_open_office_a");
    var_0 thread maps\_anim::anim_single_solo(self, "cornered_office_fireworks_crowd_guard5");
  }

  common_scripts\utility::flag_wait_either("office_guy_killed", "_stealth_spotted");
  level notify("cy_office_spotted");
  self.fixednode = 0;
  self stopanimscripted();
  maps\_stealth_utility::disable_stealth_for_ai();
  self.dontevershoot = undefined;
  thread maps\_utility::set_battlechatter(1);
  var_2 = getent("player_in_office", "targetname");

  if(self.script_parameters == "office_guy_d" || self.script_parameters == "office_guy_e") {
    if(level.player istouching(var_2)) {
      var_3 = getent("cy_office_enemy_volume", "targetname");
      self setgoalvolumeauto(var_3);
    } else
      thread maps\_utility::player_seek_enable();
  } else if(level.player istouching(var_2)) {
    var_3 = getent("cy_office_enemy_volume_2", "targetname");
    self setgoalvolumeauto(var_3);
  } else
    thread maps\_utility::player_seek_enable();
}

courtyard_office_props() {
  thread courtyard_office_chair();
  thread courtyard_office_glass();
}

courtyard_office_chair() {
  var_0 = common_scripts\utility::getstruct("courtyard_office_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("courtyard_office");
  var_2 = getent("office_a_conf_chair", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "cornered_office_fireworks_crowd_chair");
  var_3 = var_1 gettagorigin("J_prop_1");
  var_4 = var_1 gettagangles("J_prop_1");
  common_scripts\utility::waitframe();
  var_2.origin = var_3;
  var_2.angles = var_4;
  common_scripts\utility::waitframe();
  var_2 linkto(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("rorke_open_office_a");

  if(isalive(level.office_guy_c) && !common_scripts\utility::flag("_stealth_spotted")) {
    var_1 thread courtyard_rig_kill(level.office_guy_c);
    var_0 thread maps\_anim::anim_single_solo(var_1, "cornered_office_fireworks_crowd_chair");
    var_1 waittillmatch("single anim", "end");
  }

  var_2 unlink();
}

courtyard_rig_kill(var_0) {
  var_0 waittill("death");
  self stopanimscripted();
  self delete();
}

courtyard_office_glass() {
  var_0 = common_scripts\utility::getstruct("courtyard_office_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("courtyard_office");
  var_2 = getent("office_a_conf_glass", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "cornered_office_fireworks_crowd_drink");
  var_3 = var_1 gettagorigin("J_prop_1");
  var_4 = var_1 gettagangles("J_prop_1");
  common_scripts\utility::waitframe();
  var_2.origin = var_3;
  var_2.angles = var_4;
  common_scripts\utility::waitframe();
  var_2 linkto(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("rorke_open_office_a");

  if(isalive(level.office_guy_a) && !common_scripts\utility::flag("_stealth_spotted")) {
    var_1 thread courtyard_rig_kill(level.office_guy_a);
    var_0 thread maps\_anim::anim_single_solo(var_1, "cornered_office_fireworks_crowd_drink");
    var_2 thread courtyard_glass_drop();
    wait 11.15;

    if(isDefined(var_1) && common_scripts\utility::flag("_stealth_spotted"))
      var_1 stopanimscripted();
    else {
      wait 15.45;
      level notify("glass_on_table");

      if(isDefined(var_1))
        var_1 waittillmatch("single anim", "end");
    }
  }

  var_2 unlink();
}

courtyard_glass_drop() {
  level endon("glass_on_table");
  level.office_guy_a waittill("death");
  self unlink();
  self physicslaunchclient(self.origin + (0, 0, 4), (0, 0, -10));
}

courtyard_office_a_doors() {
  var_0 = getent("office_a_door_right", "targetname");
  var_1 = getent("office_a_door_left", "targetname");
  var_2 = getEntArray("office_a_door_right_hinges", "targetname");
  var_3 = getEntArray("office_a_door_left_hinges", "targetname");

  foreach(var_5 in var_2)
  var_5 linkto(var_0);

  foreach(var_5 in var_3)
  var_5 linkto(var_1);

  var_9 = common_scripts\utility::getstruct("courtyard_office_entry_animnode", "targetname");
  thread maps\cornered_code::generic_prop_raven_anim(var_9, "courtyard_office", "cornered_courtyard_office_door_door", "office_a_door_right", undefined, undefined, "rorke_open_office_a");
  common_scripts\utility::flag_wait("rorke_open_office_a");
  wait 0.65;
  wait 0.75;
  var_0 connectpaths();
}

courtyard_office_ally_vo() {
  level.allies[level.const_rorke] endon("death");
  common_scripts\utility::flag_wait("courtyard_office_id_vo");
  wait 8.75;

  if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("cy_office_stealth_broken"))
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_icount5tangos");

  common_scripts\utility::flag_wait_or_timeout("move_to_office_a_half_wall", 3);

  if(!common_scripts\utility::flag("office_guy_killed") || !common_scripts\utility::flag("cy_office_stealth_broken")) {
    wait 3.5;
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_dropem_2");
  }

  common_scripts\utility::flag_wait("office_guys_dead");
  wait 1.25;

  if(!common_scripts\utility::flag("starting_bar_reaction"))
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_kgn_lookslikeeliastraining");

  common_scripts\utility::flag_wait("move_across_bridge");
  wait 1.9;

  if(common_scripts\utility::flag("at_cy_exit_door"))
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_clearright");

  wait 2.25;

  if(!common_scripts\utility::flag("starting_bar_reaction")) {
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_heshcheckin");
    wait 0.1;
    maps\_utility::smart_radio_dialogue("cornered_hsh_mainelevatorsoffline");
  }

  if(!common_scripts\utility::flag("starting_bar_reaction")) {
    wait 0.1;
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_copyseeyain");
  }
}

setup_office_enemy_vo() {
  wait 2.0;

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  var_0 = maps\_utility::get_living_ai_array("office_guys", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isalive(var_2) && isDefined(var_2.script_parameters) && var_2.script_parameters == "office_guy_a") {
      level.office_guy_a = var_2;
      level.office_guy_a.animname = "generic";
    }

    if(isalive(var_2) && isDefined(var_2.script_parameters) && var_2.script_parameters == "office_guy_b") {
      level.office_guy_b = var_2;
      level.office_guy_b.animname = "generic";
    }

    var_2 thread stop_vo_on_event();
  }

  thread office_enemy_vo(level.office_guy_a, level.office_guy_b);
  level.office_guy_a thread stop_vo_on_spotted();
  level.office_guy_b thread stop_vo_on_spotted();
}

office_enemy_vo(var_0, var_1) {
  var_0 endon("stop_my_vo");
  var_1 endon("stop_my_vo");
  var_0 maps\_utility::smart_dialogue("cornered_saf1_wowwouldyoulook");
  wait 0.2;
  var_1 maps\_utility::smart_dialogue("cornered_saf2_theymakememiss");
  wait 0.1;
  var_0 maps\_utility::smart_dialogue("cornered_saf1_metooigo");
  wait 0.3;
  var_1 maps\_utility::smart_dialogue("cornered_saf2_youluckybastardi");
}

stop_vo_on_spotted() {
  self endon("death");
  level common_scripts\utility::waittill_either("_stealth_spotted", "enemy_office_hurt");
  self notify("stop_vo");
}

stop_vo_on_event() {
  common_scripts\utility::waittill_any("stop_vo", "death", "damage", "_stealth_spotted");
  level notify("enemy_office_hurt");

  if(isDefined(self)) {
    self notify("stop_my_vo");
    self stopsounds();
  }
}

courtyard_office_chopper() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("courtyard_reception_office_a_chopper");
  var_1 = getent("courtyard_reception_office_a_chopper_spotlight_target", "targetname");
  var_0 thread maps\cornered_code::littlebird_handle_spotlight(0.5, undefined, undefined, 50, var_1);
  common_scripts\utility::flag_wait("courtyard_reception_office_a_chopper_shine_spotlight");
  wait 4.0;
  common_scripts\utility::flag_set("courtyard_reception_office_a_chopper_exit");
  var_0 thread maps\cornered_code::littlebird_spotlight_off();
  var_0 notify("stop_littlebird_spotlight");
}

courtyard_transient_load() {
  common_scripts\utility::flag_wait("courtyard_transient_load");
  maps\_utility::transient_load("cornered_end_tr");
}

bar_prep() {
  if(!isDefined(level.started_bar_from_startpoint))
    common_scripts\utility::flag_wait("move_across_bridge");

  thread bar_props();
  thread bar_enemies();
  thread bar_light();
  thread bar_enemies_wave2();
  level.allies[level.const_rorke] thread bar_rorke_shoot_tv();
}

bar_rorke() {
  level endon("bar_strobe_starting");
  level endon("_stealth_spotted");
  level endon("bar_guy_killed");
  self endon("death");

  if(common_scripts\utility::flag("bar_guy_killed") || common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("player_bar_sneaking")) {
    return;
  }
  level notify("rorke_stealth_end");
  self.goalradius = 16;
  var_0 = getnode("rorke_bar_floor_1", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  self.disableplayeradsloscheck = 1;
  wait 0.5;
  thread maps\_utility::smart_dialogue("cornered_mrk_biggroupwellneed");
  wait 1.25;
  var_0 = getnode("bar_strobe_rorke", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  self.disableplayeradsloscheck = 0;
  common_scripts\utility::flag_wait("player_on_bar_floor");
  maps\_utility::smart_dialogue("cornered_mrk_takeoutthelight");
  maps\_utility::smart_dialogue("cornered_mrk_leftside");
  thread bar_rorke_warning_vo();
  wait 8;
  maps\_utility::smart_dialogue("cornered_mrk_ivegotit");
  wait 0.25;
  common_scripts\utility::flag_set("rorke_shoot_tv");
}

bar_rorke_shoot_tv() {
  self endon("death");
  common_scripts\utility::flag_wait("rorke_shoot_tv");

  if(!common_scripts\utility::flag("bar_light_shot")) {
    self.goalradius = 16;
    var_0 = getnode("bar_strobe_rorke_failsafe", "targetname");
    self setgoalnode(var_0);
    self waittill("goal");
    var_1 = getent("bar_light_origin", "targetname");
    self.baseaccuracy = 5000000;
    wait 0.4;
    self setlookatentity(var_1);
    wait 0.4;
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_1.origin);
    wait 0.05;
    self.baseaccuracy = 1;
    common_scripts\utility::flag_set("rorke_shot_tv");
    self setlookatentity();
  }

  thread bar_rorke_strobe_attack();
}

bar_rorke_warning_vo() {
  level endon("bar_strobe_starting");
  level endon("_stealth_spotted");
  level endon("bar_light_shot");
  self endon("death");
  self endon("gave_warning");
  var_0 = maps\_utility::get_living_ai_array("bar_guys", "script_noteworthy");

  for(;;) {
    foreach(var_2 in var_0) {
      var_3 = 4096.0;
      var_4 = level.player getEye();
      var_5 = level.player getplayerangles();
      var_6 = vectornormalize(anglesToForward(var_5));
      var_7 = bulletTrace(var_4, var_4 + var_6 * var_3, 1, level.player, 1);

      if(isDefined(var_7["entity"]) && var_7["entity"] == var_2) {
        maps\_utility::smart_dialogue("cornered_mrk_nohitthelight");
        self notify("gave_warning");
      }
    }

    wait 0.05;
  }
}

bar_rorke_strobe_attack() {
  self endon("death");
  level notify("bar_strobe_starting");
  wait 0.35;
  thread bar_strobe_player_on();
  thread bar_strobe_player_force_off();
  maps\_utility::smart_dialogue("cornered_mrk_strobeson");
  maps\_utility::smart_dialogue("cornered_mrk_takeemdown");
  thread maps\cornered_audio::aud_bar("stop2");

  if(!common_scripts\utility::flag("rorke_shot_tv"))
    common_scripts\utility::flag_wait_or_timeout("strobe_on", 6);

  thread bar_strobe_ally();
  wait 0.4;
  var_0 = getent("rorke_bar_volume", "targetname");
  self setgoalvolumeauto(var_0);
  add_magic_bullet_shield_if_off();
  self.maxsightdistsqrd = 64000000;
  self.ignoreall = 0;
  self.ignoresuppression = 1;
  self.dontevershoot = undefined;
  self.baseaccuracy = 5000000;
  self.allowpain = 0;
  var_1 = maps\_utility::get_living_ai_array("bar_guys", "script_noteworthy");

  while(!common_scripts\utility::flag("bar_guys_new_dead")) {
    var_1 = maps\_utility::array_removedead(var_1);
    var_2 = common_scripts\utility::getclosest(self.origin, var_1);

    if(!isalive(var_2)) {
      wait 0.05;
      continue;
    }

    if(!isalive(self.enemy))
      self.favoriteenemy = var_2;

    if(isalive(var_2)) {
      self.ignoreall = 0;
      var_2.dontattackme = undefined;
      var_2.health = 1;
      var_3 = [];
      var_3[0] = var_2;
      maps\_utility::waittill_dead(var_3, 1);
    }

    self.ignoreall = 1;
    wait 1.0;
  }

  level notify("bar_wave1_dead");
  self cleargoalvolume();
  wait 1;

  if(!common_scripts\utility::flag("2nd_wave_standard") && !common_scripts\utility::flag("bar_wave2_failsafe"))
    maps\_utility::smart_dialogue("cornered_mrk_checkyourcorners");

  var_4 = getnode("bar_corner_rorke", "targetname");
  self setgoalnode(var_4);
  self.ignoreall = 1;
  common_scripts\utility::flag_wait("bar_wave2_failsafe");
  wait 3.4;
  self.ignoreall = 0;
  var_1 = maps\_utility::get_living_ai_array("bar_guys_2", "script_noteworthy");

  while(!common_scripts\utility::flag("bar_guys_new_2_dead")) {
    var_1 = maps\_utility::array_removedead(var_1);
    var_2 = common_scripts\utility::getclosest(self.origin, var_1);

    if(!isalive(var_2)) {
      wait 0.05;
      continue;
    }

    if(!isalive(self.enemy))
      self.favoriteenemy = var_2;

    if(isalive(var_2)) {
      self.ignoreall = 0;
      var_2.dontattackme = undefined;
      var_2.health = 1;
      var_3 = [];
      var_3[0] = var_2;
      maps\_utility::waittill_dead(var_3, 1);
    }

    self.ignoreall = 1;
    wait 1.0;
  }

  level notify("bar_combat_done");
  wait 0.5;
  self.allowpain = 1;

  if(common_scripts\utility::flag("rorke_shot_tv") && common_scripts\utility::flag("player_started_bar_combat"))
    maps\_utility::smart_dialogue("cornered_mrk_thatwasntasmart");
  else
    maps\_utility::smart_dialogue("cornered_mrk_clear");

  wait 0.75;

  if(common_scripts\utility::flag("strobe_on"))
    maps\_utility::smart_dialogue("cornered_mrk_strobesoffthisway");
  else
    level.player setweaponhudiconoverride("actionslot1", "");

  common_scripts\utility::flag_set("activate_strobe_off_failsafe");
  thread bar_rorke_move_on();
  wait 1;

  if(common_scripts\utility::flag("strobe_on"))
    thread handle_strobe_off_hint();
}

bar_rorke_move_on() {
  var_0 = getnode("bar_rorke", "targetname");
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("move_to_junction_entrance");
  common_scripts\utility::flag_set("bar_finished");
}

tv_play(var_0) {
  var_0 endon("trigger");
  thread tv_stop(var_0);
  setsaveddvar("cg_cinematicFullScreen", "0");

  for(;;) {
    cinematicingame("cornered_concert");
    common_scripts\utility::waitframe();

    while(iscinematicplaying())
      common_scripts\utility::waitframe();
  }
}

tv_stop(var_0) {
  var_0 waittill("trigger");
  stopcinematicingame();
}

bar_light() {
  var_0 = getent("bar_light_volume", "targetname");
  var_1 = getent("bar_script_light", "targetname");
  var_2 = getent("bar_light_origin", "targetname");
  var_3 = var_2 common_scripts\utility::spawn_tag_origin();
  var_4 = getent("bar_light_aim_assist", "targetname");
  var_4 notsolid();
  thread tv_play(var_0);
  common_scripts\utility::exploder(1972);
  var_4 enableaimassist();
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("bar_light_shot");
  level notify("bar_light_shot");
  playFXOnTag(level._effect["spark_fall_shortrun_mp"], var_3, "tag_origin");
  thread maps\cornered_audio::aud_bar("light");
  thread maps\cornered_audio::aud_bar("panic");
  thread maps\cornered_audio::aud_bar("shuffle");
  var_1 setlightintensity(0);
  maps\_utility::stop_exploder(1972);
  var_4 disableaimassist();
  var_4 delete();
  wait 2;
  var_3 delete();
}

strobe_on_hide_hint() {
  if(common_scripts\utility::flag("strobe_on") || common_scripts\utility::flag("bar_guys_new_2_dead") || common_scripts\utility::flag("rorke_killed") || common_scripts\utility::flag("rorke_killed_2"))
    return 1;

  return 0;
}

handle_strobe_on_hint() {
  level endon("strobe_off_failsafe");
  level endon("activate_strobe_off_failsafe");
  level endon("bar_guys_new_2_dead");
  level endon("rorke_killed");
  level endon("rorke_killed_2");
  level.player endon("death");

  if(!isDefined(level.player) || !isalive(level.player)) {
    return;
  }
  var_0 = 2;
  var_1 = 2;
  var_2 = 1;

  for(;;) {
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");
    level.player thread maps\_utility::display_hint_timeout("turn_on_strobe", var_0);
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");

    if(common_scripts\utility::flag("strobe_on")) {
      common_scripts\utility::flag_wait("strobe_off");
      var_2 = 0;
    }

    if(!var_2)
      wait(var_1);

    if(var_1 == 2)
      var_1 = 5;

    wait 0.05;
  }
}

strobe_off_hide_hint() {
  if(common_scripts\utility::flag("strobe_off"))
    return 1;

  return 0;
}

handle_strobe_off_hint() {
  level endon("strobe_off");
  level endon("strobe_off_failsafe");
  level.player endon("death");

  if(!isDefined(level.player) || !isalive(level.player)) {
    return;
  }
  for(;;) {
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");
    common_scripts\utility::waitframe();
    level.player thread maps\_utility::display_hint("turn_off_strobe");
  }
}

bar_strobe_player_on() {
  level endon("strobe_off_failsafe");
  thread handle_strobe_on_hint();
  level.player setweaponhudiconoverride("actionslot1", "hud_icon_strobe");
  refreshhudammocounter();

  for(;;) {
    level.player notifyonplayercommand("activate_strobe", "+actionslot 1");
    level.player waittill("activate_strobe");
    common_scripts\utility::flag_set("strobe_on");
    level notify("strobe_on");
    thread maps\cornered_audio::aud_bar("strobe");
    maps\_utility::vision_set_fog_changes("cornered_strobe", 0.5);
    common_scripts\utility::flag_clear("strobe_off");
    level.strobe_tag = spawn("script_model", (0, 0, 0));
    level.strobe_tag setModel("tag_origin");
    level.strobe_tag.angles = level.player.angles;
    level.strobe_tag linktoplayerview(level.player, "tag_flash", (2, 0.5, 0.5), (0, 0, 0), 0);
    playFXOnTag(level._effect["cnd_spotlight_strobe"], level.strobe_tag, "tag_origin");
    wait 0.05;
    level.player notifyonplayercommand("deactivate_strobe", "+actionslot 1");
    level.player waittill("deactivate_strobe");
    common_scripts\utility::flag_set("strobe_off");
    thread maps\cornered_audio::aud_bar("strobe_stop");
    maps\_utility::vision_set_fog_changes("cornered_03", 0.5);
    common_scripts\utility::flag_clear("strobe_on");
    common_scripts\utility::waitframe();
    level.strobe_tag delete();
    wait 0.05;
  }
}

bar_strobe_player_force_off() {
  level waittill("strobe_off_failsafe");

  if(isDefined(level.strobe_tag)) {
    common_scripts\utility::flag_set("strobe_off");
    thread maps\cornered_audio::aud_bar("strobe_stop");
    common_scripts\utility::flag_clear("strobe_on");
    maps\_utility::vision_set_fog_changes("cornered_04", 1.5);
    level.strobe_tag delete();
  }

  level.player setweaponhudiconoverride("actionslot1", "");
}

bar_strobe_ally() {
  playFXOnTag(level._effect["cnd_ally_strobe"], level.allies[level.const_rorke], "tag_flash");
  thread bar_strobe_ally_force_off();
  common_scripts\utility::flag_wait_all("bar_guys_new_dead", "bar_guys_new_2_dead");
  wait 1.5;
  stopFXOnTag(level._effect["cnd_ally_strobe"], level.allies[level.const_rorke], "tag_flash");
}

bar_strobe_ally_force_off() {
  level waittill("strobe_off_failsafe");
  stopFXOnTag(level._effect["cnd_ally_strobe"], level.allies[level.const_rorke], "tag_flash");
}

bar_enemies() {
  level.bar_animnode = common_scripts\utility::getstruct("courtyard_bar_animnode", "targetname");
  maps\_utility::array_spawn_function_targetname("bar_guys", ::bar_enemy_setup);
  maps\_utility::array_spawn_function_targetname("bar_guys", ::bar_enemy_react);
  maps\_utility::array_spawn_function_targetname("bar_guys", ::bar_enemy_strobe_react);
  maps\_utility::array_spawn_function_targetname("bar_guys", ::bar_death);
  maps\_utility::array_spawn_targetname("bar_guys", 1);
  wait 1;
  thread bar_enemy_vo();
  thread bar_enemy_panic_vo();
  thread bar_enemy_strobe_vo();
  common_scripts\utility::flag_wait_any("strobe_on", "_stealth_spotted", "bar_light_shot", "bar_guy_killed", "player_bar_sneaking");
  var_0 = getEntArray("stealth_clipbrush_custom", "targetname");
  maps\_utility::array_delete(var_0);
  thread bar_enemy_seek_player();

  if(!common_scripts\utility::flag("rorke_shoot_tv")) {
    var_1 = getent("player_in_bar", "targetname");

    while(!level.player istouching(var_1) && !level.allies[level.const_rorke] istouching(var_1))
      common_scripts\utility::waitframe();

    common_scripts\utility::flag_set("rorke_shoot_tv");
  }

  foreach(var_3 in level.players) {
    var_3.maxvisibledist = 8192;

    if(var_3 maps\_utility::ent_flag_exist("_stealth_enabled"))
      var_3 maps\_utility::ent_flag_clear("_stealth_enabled");
  }

  wait 10;
  maps\_stealth_utility::disable_stealth_system();
  level.allies[level.const_baker].ignoreall = 1;
}

bar_death() {
  self waittill("death");
  common_scripts\utility::flag_set("bar_guy_killed");
}

bar_spotted_func() {
  wait 0.1;
}

bar_enemy_setup() {
  self endon("death");
  self.health = 10;
  self.allowdeath = 1;
  self.animname = "generic";
  maps\_stealth_utility::stealth_pre_spotted_function_custom(::bar_spotted_func);
  var_0 = [];
  var_0["hidden"] = maps\_stealth_behavior_enemy::enemy_state_hidden;
  var_0["spotted"] = maps\cornered_code::custom_bar_enemy_state_spotted;
  maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_0);

  if(isDefined(self.script_parameters) && self.script_parameters == "e09") {
    level.bar_guy9 = self;
    thread stop_vo_on_event();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "e10") {
    level.bar_guy10 = self;
    thread stop_vo_on_event();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "e11") {
    level.bar_guy11 = self;
    thread stop_vo_on_event();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "e01") {
    level.e01_glass = spawn("script_model", self.origin);
    level.e01_glass.origin = self gettagorigin("tag_weapon_chest");
    level.e01_glass.angles = self gettagangles("tag_weapon_chest");
    level.e01_glass setModel("cnd_glass_01");
    level.e01_glass linkto(self, "tag_weapon_chest");
    thread bar_enemy_glass_launch(level.e01_glass);
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "e02") {
    level.e02_glass = spawn("script_model", self.origin);
    level.e02_glass.origin = self gettagorigin("tag_weapon_chest");
    level.e02_glass.angles = self gettagangles("tag_weapon_chest");
    level.e02_glass setModel("cnd_glass_01");
    level.e02_glass linkto(self, "tag_weapon_chest");
    thread bar_enemy_glass_launch(level.e02_glass);
  }

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "e09" || self.script_parameters == "e10")
      bar_enemy_reach();
    else
      level.bar_animnode thread maps\_anim::anim_loop_solo(self, "cornered_bar_" + self.script_parameters + "_idle", "stop_loop");
  }
}

bar_enemy_reach() {
  self endon("death");
  self endon("enemy_spotted" + self.script_parameters);
  level endon("_stealth_spotted");
  level endon("strobe_on");
  level endon("bar_guy_killed");
  level endon("player_bar_sneaking");
  level endon("bar_light_shot");
  self.goalradius = 16;
  self waittill("_patrol_reached_path_end");
  level.bar_animnode maps\_anim::anim_reach_solo(self, "cornered_bar_" + self.script_parameters + "_idle");
  common_scripts\utility::flag_set(self.script_parameters + "_path_done");
  level.bar_animnode thread maps\_anim::anim_loop_solo(self, "cornered_bar_" + self.script_parameters + "_idle", "stop_loop");
}

bar_enemy_glass_launch(var_0) {
  common_scripts\utility::waittill_any("death", "damage", "starting_bar_reaction");
  var_0 unlink();
  var_0 physicslaunchclient(var_0.origin - (0, 0, 2), (50, -50, -500));
}

bar_enemy_react() {
  self endon("death");
  self endon("enemy_spotted" + self.script_parameters);
  maps\_utility::ent_flag_init("doing_bar_reaction");
  common_scripts\utility::flag_wait_any("_stealth_spotted", "bar_guy_killed", "player_bar_sneaking", "bar_light_shot");
  common_scripts\utility::flag_set("starting_bar_reaction");
  maps\_utility::ent_flag_set("doing_bar_reaction");

  if(!common_scripts\utility::flag("bar_light_shot"))
    common_scripts\utility::flag_set("player_started_bar_combat");

  self notify("stop_vo");
  self.ignoreall = 1;
  thread maps\_utility::set_battlechatter(1);

  if(self.script_parameters == "e01" || self.script_parameters == "e02" || self.script_parameters == "e03" || self.script_parameters == "e04" || self.script_parameters == "e07" || self.script_parameters == "e11") {
    level.bar_animnode notify("stop_loop");
    level.bar_animnode maps\_anim::anim_single_solo(self, "cornered_bar_" + self.script_parameters + "_react_shoot");
  } else if(self.script_parameters == "e09") {
    if(common_scripts\utility::flag(self.script_parameters + "_path_done")) {
      level.bar_animnode notify("stop_loop");
      level.bar_animnode maps\_anim::anim_single_solo(self, "cornered_bar_" + self.script_parameters + "_react_shoot");
    } else {
      self notify("end_patrol");
      self setgoalpos(self.origin);
      level.bar_animnode notify("stop_loop");
      maps\_utility::anim_stopanimscripted();
      common_scripts\utility::waitframe();
    }
  } else if(self.script_parameters == "e10") {
    self notify("end_patrol");
    self setgoalpos(self.origin);
    level.bar_animnode notify("stop_loop");
    maps\_utility::anim_stopanimscripted();
  } else {
    self notify("end_patrol");
    level.bar_animnode notify("stop_loop");
    maps\_utility::anim_stopanimscripted();
    common_scripts\utility::waitframe();
  }

  maps\_utility::ent_flag_clear("doing_bar_reaction");
  bar_react_variable_wait();
  self.ignoreall = 0;
  maps\_stealth_utility::disable_stealth_for_ai();
  self.dontevershoot = undefined;
  var_0 = getent("enemy_bar_volume", "targetname");

  if(!common_scripts\utility::flag("player_broke_bar_combat"))
    self setgoalvolumeauto(var_0);

  thread bar_enemy_lights_out_accuracy();
  common_scripts\utility::flag_set("bar_enemies_reacted");
}

bar_react_variable_wait() {
  level endon("strobe_on");
  self endon("death");
  level endon("player_bar_sneaking");

  if(common_scripts\utility::flag("player_bar_sneaking")) {
    return;
  }
  if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("bar_guy_killed"))
    wait(randomfloatrange(1.8, 2.5));
  else
    wait 6;
}

bar_enemy_lights_out_accuracy() {
  self endon("death");
  self endon("end_failsafe");

  for(;;) {
    if(common_scripts\utility::flag("bar_light_shot")) {
      self.oldaccuracy = self.baseaccuracy;
      self.baseaccuracy = 0.001;
      wait(randomfloatrange(2.5, 3.0));
      self.baseaccuracy = self.oldaccuracy;
      self notify("end_failsafe");
    }

    wait 0.05;
  }
}

bar_enemy_strobe_react() {
  self endon("death");
  var_0 = [];
  var_0[0] = level.player;
  var_0[1] = level.allies[level.const_rorke];
  common_scripts\utility::flag_wait("strobe_on");

  if(maps\_utility::ent_flag_exist("doing_bar_reaction")) {
    while(maps\_utility::ent_flag("doing_bar_reaction"))
      wait 0.05;
  }

  level.bar_animnode notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
  common_scripts\utility::waitframe();

  for(;;) {
    if(!common_scripts\utility::flag("strobe_on"))
      common_scripts\utility::flag_wait("strobe_on");

    var_1 = vectornormalize(level.player.origin - self.origin);
    var_2 = anglesToForward(self.angles);
    var_3 = vectordot(var_1, var_2);
    var_4 = vectorcross(var_1, var_2);
    var_5 = vectordot(var_4, var_2);
    self.ignoreall = 1;
    self.dontevershoot = 1;

    if(var_3 >= 0.7)
      thread maps\_anim::anim_custom_animmode_loop_solo(self, "gravity", "cornered_bar_react_front");
    else if(var_3 <= -0.7)
      thread maps\_anim::anim_custom_animmode_loop_solo(self, "gravity", "cornered_bar_react_rear");
    else if(var_5 >= 0.0)
      thread maps\_anim::anim_custom_animmode_loop_solo(self, "gravity", "cornered_bar_react_left");
    else
      thread maps\_anim::anim_custom_animmode_loop_solo(self, "gravity", "cornered_bar_react_right");

    common_scripts\utility::flag_wait("strobe_off");
    wait(randomfloatrange(0.75, 1.25));
    self notify("stop_animmode");
    self stopanimscripted();
    self.ignoreall = 0;
    self.dontevershoot = undefined;
    common_scripts\utility::waitframe();
  }
}

bar_enemies_wave2() {
  maps\_utility::array_spawn_function_targetname("bar_guys_new_2", ::bar_enemy_wave2_behavior);
  common_scripts\utility::flag_wait_any("bar_wave2_failsafe", "2nd_wave_standard");
  maps\_utility::array_spawn_targetname("bar_guys_new_2", 1);
}

bar_enemy_wave2_behavior() {
  self endon("death");
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.goalradius = 40;
  stop_magic_bullet_shield_if_on();
  self.allowdeath = 1;
  self.animname = "generic";

  while(!self cansee(level.player))
    wait 0.05;

  wait 0.75;
  thread bar_enemy_wave2_3_react();
}

bar_enemy_wave2_3_react() {
  self endon("death");

  if(common_scripts\utility::flag("bar_light_shot"))
    thread bar_enemy_strobe_react();
  else {
    self.ignoreall = 0;
    maps\_stealth_utility::disable_stealth_for_ai();
    self.dontevershoot = undefined;
    thread bar_enemy_lights_out_accuracy();
    common_scripts\utility::flag_set("bar_enemies_reacted");
    common_scripts\utility::flag_wait("strobe_on");
    thread bar_enemy_strobe_react();
    self.ignoreall = 1;
    self.dontevershoot = 1;
  }
}

bar_enemy_seek_player() {
  level endon("bar_combat_done");
  level.player endon("death");
  level.allies[level.const_rorke] endon("death");
  common_scripts\utility::flag_wait("bar_enemies_reacted");
  common_scripts\utility::flag_set("player_broke_bar_combat");
  thread bar_enemy_kill_rorke();
  var_0 = getent("player_in_bar", "targetname");

  for(;;) {
    if(!level.player istouching(var_0)) {
      var_1 = getaiarray("axis");

      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isalive(var_3)) {
          wait 0.1;
          var_3 cleargoalvolume();
          var_3.baseaccuracy = 100;
          var_3 thread maps\_utility::player_seek_enable();
          return;
        }
      }
    }

    wait 0.05;
  }
}

bar_enemy_kill_rorke() {
  level endon("bar_combat_done");
  level.player endon("death");
  level.allies[level.const_rorke] endon("death");
  var_0 = getent("player_in_office", "targetname");
  var_1 = getent("player_in_bar", "targetname");

  for(;;) {
    if(level.player istouching(var_0) && level.allies[level.const_rorke] istouching(var_1)) {
      level thread mission_failed_watcher();
      level.allies[level.const_rorke] stop_magic_bullet_shield_if_on();
      level.allies[level.const_rorke] kill();
    } else {}

    wait 0.05;
  }
}

bar_props() {
  thread bar_stool_anim("bar_01_1", "bar_01_2", "cornered_bar_chair_e01");
  thread bar_stool_anim("bar_02a_1", "bar_02a_2", "cornered_bar_chair_e02a");
  thread bar_stool_anim("bar_02b_1", undefined, "cornered_bar_chair_e02b");
  thread bar_stool_anim("bar_04_1", "bar_04_2", "cornered_bar_chair_e04");
}

bar_stool_anim(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct("courtyard_bar_animnode", "targetname");
  var_4 = maps\_utility::spawn_anim_model("bar_chair");
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_0)) {
    var_9 = getEntArray(var_0, "targetname");

    foreach(var_11 in var_9) {
      if(var_11.script_noteworthy == "stool")
        var_5 = var_11;

      if(var_11.script_noteworthy == "clip_stool")
        var_6 = var_11;
    }

    var_6 linkto(var_5);
  }

  if(isDefined(var_1)) {
    var_13 = getEntArray(var_1, "targetname");

    foreach(var_11 in var_13) {
      if(var_11.script_noteworthy == "stool")
        var_7 = var_11;

      if(var_11.script_noteworthy == "clip_stool")
        var_8 = var_11;
    }

    var_8 linkto(var_7);
  }

  var_3 maps\_anim::anim_first_frame_solo(var_4, var_2);
  var_16 = var_4 gettagorigin("J_prop_1");
  var_17 = var_4 gettagangles("J_prop_1");
  var_18 = var_4 gettagorigin("J_prop_2");
  var_19 = var_4 gettagangles("J_prop_2");
  common_scripts\utility::waitframe();

  if(isDefined(var_5)) {
    var_5.origin = var_16;
    var_5.angles = var_17;
    var_5 linkto(var_4, "J_prop_1");
  }

  if(isDefined(var_7)) {
    var_7.origin = var_18;
    var_7.angles = var_19;
    var_7 linkto(var_4, "J_prop_2");
  }

  common_scripts\utility::flag_wait("starting_bar_reaction");
  var_3 maps\_anim::anim_single_solo(var_4, var_2);
}

bar_guy_watch_death() {
  level endon("end_bar_vo");
  self waittill("death");
  level notify("end_bar_vo");
}

bar_enemy_vo() {
  level.bar_guy9 endon("stop_my_vo");
  level.bar_guy10 endon("stop_my_vo");
  level.bar_guy11 endon("stop_my_vo");
  level endon("end_bar_vo");
  level.bar_guy9 thread bar_guy_watch_death();
  level.bar_guy10 thread bar_guy_watch_death();
  level.bar_guy11 thread bar_guy_watch_death();
  level.bar_guy9 maps\_utility::smart_dialogue("cornered_saf1_tothefederation");
  level.bar_guy10 maps\_utility::smart_dialogue("cornered_saf2_thefederation");
  level.bar_guy11 maps\_utility::smart_dialogue("cornered_pmc3_yesthefederation");
  wait(randomfloatrange(3.5, 6.0));
  level.bar_guy11 maps\_utility::smart_dialogue("cornered_pmc3_whenarethelights");
  level.bar_guy9 maps\_utility::smart_dialogue("cornered_saf1_ihaventheard");
  level.bar_guy10 maps\_utility::smart_dialogue("cornered_saf2_thefireworkslookbetter");
  wait(randomfloatrange(3.5, 6.0));
  level.bar_guy10 maps\_utility::smart_dialogue("cornered_saf2_drinkupthebeer");
  level.bar_guy11 maps\_utility::smart_dialogue("cornered_pmc3_thatsthebestorder");
  level.bar_guy9 maps\_utility::smart_dialogue("cornered_saf1_laughing");
  wait(randomfloatrange(3.5, 6.0));
  level.bar_guy9 maps\_utility::smart_dialogue("cornered_saf1_thisamericantequilatastes");
  level.bar_guy10 maps\_utility::smart_dialogue("cornered_saf2_theirbeerisworse");
  level.bar_guy11 maps\_utility::smart_dialogue("cornered_pmc3_iknowitslike");
}

bar_enemy_panic_vo() {
  level endon("strobe_on");
  common_scripts\utility::flag_wait("bar_light_shot");
  wait 0.25;
  var_0 = maps\_utility::get_living_ai_array("bar_guys", "script_noteworthy");
  var_1 = [];
  var_1[0] = "cornered_saf1_whatthehellis";
  var_1[1] = "cornered_saf2_whoturnedoffthe";
  var_1[2] = "cornered_pmc3_whathappened";
  var_1[3] = "cornered_saf1_areweunderattack";
  var_1[4] = "cornered_saf2_getarepaircrew";
  var_1[5] = "cornered_pmc3_someonegetthelights";
  var_1[6] = "cornered_saf1_isanyonethere";
  var_2 = 0;

  for(;;) {
    var_0 = maps\_utility::array_removedead(var_0);
    common_scripts\utility::array_randomize(var_0);

    if(!isalive(var_0[0])) {
      wait 0.05;
      continue;
    }

    if(isalive(var_0[0])) {
      if(var_2 >= var_1.size)
        var_2 = 0;

      var_3 = var_1[var_2];
      var_0[0] maps\_utility::smart_dialogue(var_3);
      var_2++;
    }

    wait(randomfloatrange(0.5, 1.0));
  }
}

bar_enemy_strobe_vo() {
  level endon("bar_wave1_dead");
  common_scripts\utility::flag_wait("strobe_on");
  wait 0.25;
  var_0 = maps\_utility::get_living_ai_array("bar_guys", "script_noteworthy");
  var_1 = [];
  var_1[0] = "cornered_saf1_overthere";
  var_1[1] = "cornered_saf2_theretheyare";
  var_1[2] = "cornered_pmc3_icantseethem";
  var_1[3] = "cornered_saf1_howmanyarethere";
  var_1[4] = "cornered_saf2_whatthehellis_2";
  var_1[5] = "cornered_pmc3_getreinforcementsuphere";
  var_1[6] = "cornered_saf1_weneedthoselights";
  var_2 = 0;

  for(;;) {
    var_0 = maps\_utility::array_removedead(var_0);
    common_scripts\utility::array_randomize(var_0);

    if(!isalive(var_0[0])) {
      wait 0.05;
      continue;
    }

    if(isalive(var_0[0])) {
      if(var_2 >= var_1.size)
        var_2 = 0;

      var_3 = var_1[var_2];
      var_0[0] maps\_utility::smart_dialogue(var_3);
      var_2++;
    }

    wait(randomfloatrange(0.5, 1.0));
  }
}

courtyard_cleanup_enemies() {
  var_0 = getEntArray("stealth_clipbrush_custom", "targetname");
  maps\_utility::array_delete(var_0);
}

junction_handler() {
  level.allies[level.const_rorke] thread junction_airlock_rorke();
  level.allies[level.const_baker] thread junction_baker_open_elevator_control_room();
  thread junction_elevator_control_panel();
  thread junction_pip_init();
  thread junction_pip_scenario();
  var_0 = getent("send_in_junction_enemies_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("rorke_opening_junction_exit_door");
  maps\_stealth_utility::disable_stealth_system();
  var_1 = getent("combat_rappel_fall_volume", "targetname");
  var_1 thread maps\cornered_code::cornered_falling_death();
  maps\_utility::delaythread(1.5, ::junction_vo);
  level.allies[level.const_rorke] thread junction_rorke_window();
  common_scripts\utility::flag_wait("obj_disable_elevators_complete");
  thread maps\_utility::autosave_now();
  thread junction_enemies();
  var_0 common_scripts\utility::trigger_on();
  maps\cornered_code::give_back_offhands();
  level.allies[level.const_rorke] thread junction_ally_combat_state();
  level.allies[level.const_baker] thread junction_ally_combat_state();
  level.allies[level.const_baker] thread force_baker_to_node();
  var_2 = getnode("junction_backup_spot_rorke", "targetname");
  level.allies[level.const_rorke] setgoalnode(var_2);
  level.allies[level.const_rorke] maps\_utility::teleport_ai(var_2);
  common_scripts\utility::flag_wait("junction_enemies_dead");
  wait 1.5;
  level.allies[level.const_rorke] thread rorke_rappel_hookup();
  level.allies[level.const_baker] thread baker_rappel_hookup();
}

force_baker_to_node() {
  var_0 = getnode("junction_backup_spot_baker", "targetname");
  self setgoalnode(var_0);
  maps\_utility::set_goal_radius(16);
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.disablereactionanims = 1;
  self.ignoreall = 1;
  self waittill("goal");
  maps\_utility::enable_surprise();
  maps\_utility::enable_pain();
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  self.disablefriendlyfirereaction = 0;
  self.disablereactionanims = 0;
  self.ignoreall = 0;
}

rorke_rappel_hookup() {
  level endon("c_rappel_player_on_rope");
  level.rorke_and_combat_rappel_rope = [];
  level.rorke_and_combat_rappel_rope[0] = self;
  level.rorke_and_combat_rappel_rope[1] = level.combat_rappel_rope_rorke;
  level.player_start_rappel_struct thread maps\_anim::anim_single(level.rorke_and_combat_rappel_rope, "cornered_junction_c4_enter_rorke");
  self waittillmatch("single anim", "ps_cornered_mrk_hookuptothe_2");
  common_scripts\utility::flag_set("c4_vo_over");
  self waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("c_rappel_player_on_rope"))
    level.player_start_rappel_struct thread maps\_anim::anim_loop(level.rorke_and_combat_rappel_rope, "cornered_junction_c4_idle_rorke", "stop_loop_rorke");
}

baker_rappel_hookup() {
  level endon("c_rappel_player_on_rope");
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("weapon_c4");
  var_0.animname = "junction_baker_c4";
  var_0 maps\_anim::setanimtree();
  var_0 hide();
  var_0 thread maps\cornered_code::entity_cleanup("c_rappel_player_on_rope");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("weapon_c4");
  var_1.animname = "junction_rorke_c4";
  var_1 maps\_anim::setanimtree();
  var_1 hide();
  var_1 thread maps\cornered_code::entity_cleanup("c_rappel_player_on_rope");
  level.player_start_rappel_struct maps\_anim::anim_first_frame_solo(var_0, "cornered_junction_c4_enter_baker");
  level.player_start_rappel_struct maps\_anim::anim_first_frame_solo(var_1, "cornered_junction_c4_enter_baker");
  var_2 = [];
  var_2[0] = self;
  var_2[1] = var_0;
  var_2[2] = var_1;
  var_0 show();
  var_1 show();
  thread maps\cornered_audio::aud_c4_hesh(var_0);
  thread maps\cornered_audio::aud_c4_keegan(var_1);
  level.player_start_rappel_struct maps\_anim::anim_single(var_2, "cornered_junction_c4_enter_baker");

  if(!common_scripts\utility::flag("c_rappel_player_on_rope"))
    level.player_start_rappel_struct thread maps\_anim::anim_loop(var_2, "cornered_junction_c4_idle_" + self.animname, "stop_loop_" + self.animname);
}

junction_cameras() {
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingameloopresident("cornered_security_cam");
  common_scripts\utility::flag_wait("c_rappel_player_on_rope");
  stopcinematicingame();
}

junction_airlock_rorke() {
  var_0 = common_scripts\utility::getstruct("junction_entry_animnode", "targetname");

  if(!isDefined(level.started_junction_from_startpoint)) {
    var_1 = getent("junction_entrance_player_clip", "targetname");
    var_1 notsolid();
    var_0 maps\_anim::anim_reach_solo(self, "junction_door1_merrick_enter");
    thread maps\cornered_audio::aud_door("stealth1");
    thread junction_airlock_door_open("junction_door", "junction_door_handle", "junction_door1");
    var_0 maps\_anim::anim_single_solo(self, "junction_door1_merrick_enter");
    common_scripts\utility::flag_set("merrick_in_airlock");

    if(!common_scripts\utility::flag("junction_entrance_close"))
      var_0 thread maps\_anim::anim_loop_solo(self, "junction_door1_merrick_loop", "stop_loop");

    common_scripts\utility::flag_wait("junction_entrance_close");
    var_0 notify("stop_loop");
    thread maps\cornered_audio::aud_door("stealth1b");
    var_1 solid();
    var_0 maps\_anim::anim_single_solo(self, "junction_door1_merrick_exit");
    var_1 delete();
  }

  thread junction_banners();
  thread courtyard_cleanup_enemies();
  thread junction_fireworks();
  var_0 maps\_anim::anim_reach_solo(self, "junction_door2_merrick_enter");
  thread maps\cornered_audio::aud_door("stealth2");
  thread junction_airlock_door_open("junction_exit_door", "junction_door_exit_handle", "junction_door2");
  common_scripts\utility::flag_set("rorke_opening_junction_exit_door");
  var_0 maps\_anim::anim_single_solo(self, "junction_door2_merrick_enter");
}

junction_airlock_door_open(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_4 = getEntArray(var_1, "targetname");

  foreach(var_6 in var_4)
  var_6 linkto(var_3);

  var_8 = common_scripts\utility::getstruct("junction_entry_animnode", "targetname");
  var_9 = maps\_utility::spawn_anim_model("junction_airlock_door");
  var_8 maps\_anim::anim_first_frame_solo(var_9, var_2 + "_enter");
  var_3 linkto(var_9, "J_prop_1");
  var_8 thread maps\_anim::anim_single_solo(var_9, var_2 + "_enter");
  wait 2.5;
  var_3 connectpaths();
  var_9 waittillmatch("single anim", "end");

  if(var_3.targetname == "junction_door") {
    if(!common_scripts\utility::flag("junction_entrance_close"))
      var_8 thread maps\_anim::anim_loop_solo(var_9, var_2 + "_loop", "stop_loop");

    common_scripts\utility::flag_wait("junction_entrance_close");
    var_8 notify("stop_loop");
    var_3 disconnectpaths();
    var_8 maps\_anim::anim_single_solo(var_9, var_2 + "_exit");
  }

  var_3 unlink();

  if(isDefined(var_9))
    var_9 delete();

  common_scripts\utility::flag_wait("part_one_start");

  if(isDefined(var_4))
    maps\_utility::array_delete(var_4);
}

junction_rorke_window() {
  var_0 = common_scripts\utility::getstruct("elevator_script_node", "targetname");
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::anim_reach_solo(self, "rorke_enter_junction");
  common_scripts\utility::flag_set("rorke_starts_handoff_anim");
  var_0 maps\_anim::anim_single_solo(self, "rorke_enter_junction");
  self.dontavoidplayer = 1;

  if(!common_scripts\utility::flag("obj_disable_elevators_complete")) {
    var_1 = getnode("combat_rappel_hookup_spot_rorke", "targetname");
    level.allies[level.const_rorke] setgoalnode(var_1);
  }
}

junction_vo() {
  wait 0.05;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_heshwereenteringfrom");
  wait 0.2;
  level.allies[level.const_baker] maps\_utility::smart_dialogue("cornered_hsh_rogerthatimalmost");
  thread help_baker_control_panel_vo();
  common_scripts\utility::flag_wait("baker_open_elevator_control_room_doors");
  common_scripts\utility::flag_wait("hesh_elevator_vo_said");
  var_0 = maps\_utility::make_array("cornered_hsh_shutitdown", "cornered_hsh_goonshutem", "cornered_hsh_hurryupshutdown", "cornered_hsh_goontakeout");
  thread maps\cornered_code::nag_until_flag(var_0, "start_disable_elevators", 5, 10, 5);
  common_scripts\utility::flag_wait("start_hesh_elevator_exit");
  thread maps\_utility::battlechatter_on("axis");
  common_scripts\utility::flag_wait("obj_disable_elevators_complete");
  wait 2.0;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_theyvefoundusget");
  wait 1.0;
  maps\_utility::music_play("mus_cornered_combat_quick");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  thread maps\_utility::battlechatter_on("allies");
  common_scripts\utility::flag_wait("junction_enemies_wave_2");
  wait 1;
  level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_werelosingtimewe");
  common_scripts\utility::flag_wait("junction_enemies_dead");
  common_scripts\utility::flag_wait("c4_vo_over");
  wait 0.5;
  var_1 = getent("hesh_junction_vo_volume", "targetname");
  thread vo_by_volume(level.allies[level.const_baker], var_1, "cornered_hsh_gohookupadam");
  var_1 = getent("merrick_junction_vo_volume", "targetname");
  thread vo_by_volume(level.allies[level.const_rorke], var_1, "cornered_mrk_grabyourlinewe");
  common_scripts\utility::flag_set("junction_finished");
}

help_baker_control_panel_vo() {
  common_scripts\utility::flag_wait("rorke_starts_handoff_anim");
  wait 5;

  if(!common_scripts\utility::flag("baker_open_elevator_control_room_doors"))
    level.allies[level.const_rorke] maps\_utility::smart_dialogue("cornered_mrk_gogivehesha");
}

vo_by_volume(var_0, var_1, var_2) {
  level endon("c_rappel_player_on_rope");

  for(;;) {
    if(level.player istouching(var_1) && !isDefined(level.vo_by_volume)) {
      level.vo_by_volume = 1;
      var_0 maps\_utility::smart_dialogue(var_2);
      wait 1;
      level.vo_by_volume = undefined;
      break;
    }

    wait 0.05;
  }
}

junction_baker_open_elevator_control_room() {
  var_0 = common_scripts\utility::getstruct("elevator_script_node", "targetname");
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::anim_first_frame_solo(self, "baker_enter_junction");
  thread baker_junction_door_open(var_0);
  common_scripts\utility::flag_wait("baker_enter_junction");
  var_0 maps\_anim::anim_single_solo(self, "baker_enter_junction");
  var_0 thread maps\_anim::anim_loop_solo(self, "baker_keypad_loop", "stop_loop");
  common_scripts\utility::flag_wait("baker_open_elevator_control_room_doors");
  thread if_offhands_are_grabbed();
  thread junction_cameras();
  var_0 notify("stop_loop");
  waittillframeend;
  thread junction_elevator_control_doors_open(var_0);
  common_scripts\utility::flag_set("start_junction_pip_scenario");
  var_0 maps\_anim::anim_single_solo(self, "baker_elevator_enter");
  common_scripts\utility::flag_set("hesh_elevator_vo_said");
  var_0 thread maps\_anim::anim_loop_solo(self, "baker_elevator_loop", "stop_loop");
  common_scripts\utility::flag_wait("player_shutting_down_elevators");
  var_0 notify("stop_loop");
  self stopanimscripted();
  waittillframeend;
  var_0 maps\_anim::anim_first_frame_solo(self, "baker_elevator_exit");
  common_scripts\utility::flag_wait("start_hesh_elevator_exit");
  var_0 maps\_anim::anim_single_solo(self, "baker_elevator_exit");
  maps\_utility::disable_cqbwalk();
}

if_offhands_are_grabbed() {
  level endon("obj_disable_elevators_complete");

  for(;;) {
    var_0 = level.player getweaponammoclip("fraggrenade");

    if(var_0 > 0) {
      level.player enableoffhandweapons();
      break;
    }

    wait 0.05;
  }
}

baker_junction_door_open(var_0) {
  var_1 = getent("baker_junction_hallway_door_brushes", "targetname");
  var_2 = getent("baker_junction_hallway_door_model", "targetname");
  var_2 linkto(var_1);
  var_3 = maps\_utility::spawn_anim_model("baker_junction_door");
  var_0 maps\_anim::anim_first_frame_solo(var_3, "baker_enter_junction");
  var_1 linkto(var_3, "J_prop_1");
  common_scripts\utility::flag_wait("baker_enter_junction");
  thread maps\cornered_audio::aud_junction("hesh");
  var_0 maps\_anim::anim_single_solo(var_3, "baker_enter_junction");
  var_1 unlink();

  if(isDefined(var_3))
    var_3 delete();
}

junction_elevator_control_doors_open(var_0) {
  var_1 = maps\_utility::spawn_anim_model("junction_keypad_door");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "cornered_junction_keypad_door");
  var_2 = getent("elevator_control_room_door_left", "targetname");
  var_3 = getent("elevator_control_room_door_right", "targetname");
  var_4 = getent("elevator_control_room_door_clip", "targetname");
  common_scripts\utility::waitframe();
  var_3 linkto(var_1, "J_prop_1");
  var_2 linkto(var_1, "J_prop_2");
  thread maps\cornered_audio::aud_door("elevator_room");
  var_0 thread maps\_anim::anim_single_solo(var_1, "cornered_junction_keypad_door");
  wait 3.5;
  var_4 notsolid();
  var_4 connectpaths();
  var_4 delete();
}

junction_elevator_control_panel() {
  var_0 = getent("disable_elevators_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  var_1 = getent("disable_elevators_trigger_old", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  if(level.player common_scripts\utility::is_player_gamepad_enabled())
    var_0 sethintstring(&"CORNERED_DISABLE_ELEVATORS_CONSOLE");
  else
    var_0 sethintstring(&"CORNERED_DISABLE_ELEVATORS");

  var_2 = maps\_utility::spawn_anim_model("elevator_control_panel");
  var_3 = maps\_utility::spawn_anim_model("elevator_control_panel");
  var_4 = maps\_utility::spawn_anim_model("multi_tool");
  maps\cornered_code::hide_player_arms();
  var_4 hide();
  var_5 = common_scripts\utility::getstruct("elevator_script_node", "targetname");
  var_5.angles = (0, 0, 0);
  var_4 maps\_anim::anim_first_frame_solo(var_4, "cornered_elevator_junction_player_clippers");
  var_5 maps\_anim::anim_first_frame_solo(var_2, "cornered_elevator_junction_upper_panel");
  var_5 maps\_anim::anim_first_frame_solo(var_3, "cornered_elevator_junction_lower_panel");
  var_5 maps\_anim::anim_first_frame_solo(level.cornered_player_arms, "cornered_elevator_junction_player");
  var_3 thread control_panel_setup_lights();
  var_2 thread control_panel_setup_lights();
  var_2 setModel("cnd_server_control_panel_anim_obj");
  common_scripts\utility::flag_wait("start_junction_pip_scenario");
  wait 8;
  var_0 common_scripts\utility::trigger_on();
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, var_2, cos(40), 0, 1);
  common_scripts\utility::flag_set("start_disable_elevators");
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  level.combat_rappel_rope_coil_rorke show();
  level.combat_rappel_rope_coil_player show();
  level.combat_rappel_rope_coil_baker show();
  level.combat_rappel_rope_rorke = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
  level.combat_rappel_rope_rorke.animname = "combat_rappel_exit_rope_rorke";
  level.player_start_rappel_struct = common_scripts\utility::getstruct("player_start_rappel_struct", "targetname");
  level.player_start_rappel_struct maps\_anim::anim_first_frame_solo(level.combat_rappel_rope_rorke, "cornered_junction_c4_enter_rorke");
  var_2 setModel("cnd_server_control_panel_anim");
  level.player disableweapons();
  var_6 = 0.5;
  var_7 = 18;
  var_8 = 18;
  var_9 = 5;
  var_10 = 20;
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.5);
  wait 0.6;
  common_scripts\utility::flag_set("player_shutting_down_elevators");
  level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 1, var_7, 5, var_9, var_10, 1);
  maps\cornered_code::show_player_arms();
  var_4 show();
  thread maps\cornered_audio::aud_junction("panel");
  var_5 thread maps\_anim::anim_single_solo(var_4, "cornered_elevator_junction_player_clippers");
  var_5 thread maps\_anim::anim_single_solo(var_2, "cornered_elevator_junction_upper_panel");
  var_3 maps\_utility::delaythread(3.5, ::junction_elevator_control_panel_lights_off, var_3);
  var_5 thread maps\_anim::anim_single_solo(level.cornered_player_arms, "cornered_elevator_junction_player");
  var_2 thread waittill_control_panel_notetrack();
  var_3 thread waittill_control_panel_notetrack();
  level.cornered_player_arms waittillmatch("single anim", "start_hesh");
  common_scripts\utility::flag_set("start_hesh_elevator_exit");
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  level.cornered_player_arms waittillmatch("single anim", "gun_up");
  level.player enableweapons();
  level.cornered_player_arms waittillmatch("single anim", "end");
  var_4 delete();
  maps\cornered_code::hide_player_arms();
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  common_scripts\utility::flag_set("obj_disable_elevators_complete");
  var_11 = getent("junction_elevator_light", "targetname");
  var_11 setlightintensity(0);
  common_scripts\utility::flag_wait("c_rappel_player_on_rope");

  foreach(var_13 in var_2.green_lights)
  var_13 delete();

  foreach(var_13 in var_2.red_lights)
  var_13 delete();

  foreach(var_13 in var_3.green_lights)
  var_13 delete();

  foreach(var_13 in var_3.red_lights)
  var_13 delete();

  var_2 delete();
  var_3 delete();
}

waittill_control_panel_notetrack() {
  self waittillmatch("single anim", "wire_spark");
  playFXOnTag(level._effect["spark_flash_15"], self, "tag_fx");
}

junction_pip_init() {
  common_scripts\utility::flag_wait("baker_open_elevator_control_room_doors");
  level.pip.rendertotexture = 1;
  var_0 = common_scripts\utility::getstruct("pip_monitor_cam", "targetname");
  level.pip.entity = spawn("script_model", var_0.origin);
  level.pip.entity setModel("tag_origin");
  level.pip.entity.angles = var_0.angles;
  common_scripts\utility::waitframe();
  level.pip.tag = "tag_origin";
  level.pip.fov = 65;
  level.pip.freecamera = 1;
  level.pip.enableshadows = 0;
  level.pip.x = 50;
  level.pip.y = 50;
  level.pip.width = 240;
  level.pip.height = 120;
  level.pip.enable = 1;
  level.pip.opened_x = 50;
  level.pip.opened_y = 50;
  level.pip.opened_width = level.pip.width;
  level.pip.opened_height = level.pip.height;
  common_scripts\utility::flag_wait("send_in_junction_enemies");
  level.pip.entity delete();
  level.pip.entity = undefined;
  common_scripts\utility::waitframe();
  level.pip.enable = 0;
}

junction_pip_scenario() {
  common_scripts\utility::flag_wait("start_junction_pip_scenario");
  wait 2;
  thread junction_pip_waver_drone();
  wait 2;
  level.total_drones = 0;
  level.total_runner_drone_spawn_count = 0;
  level.total_times_without_waver = 0;
  var_0 = getEntArray("junction_pip_drone_far_right", "targetname");
  common_scripts\utility::array_thread(var_0, ::junction_pip_drone_think, "player_shutting_down_elevators");
  var_1 = getEntArray("junction_pip_drone_far_right_2", "targetname");
  common_scripts\utility::array_thread(var_1, ::junction_pip_drone_think, "player_shutting_down_elevators");
  var_2 = getEntArray("junction_pip_drone_close_right", "targetname");
  common_scripts\utility::array_thread(var_2, ::junction_pip_drone_think, "player_shutting_down_elevators");
  common_scripts\utility::flag_wait("start_hesh_elevator_exit");
  thread junction_pip_waver_drone();
  var_0 = getEntArray("junction_pip_drone_far_right", "targetname");
  common_scripts\utility::array_thread(var_0, ::junction_pip_drone_think, "send_in_junction_enemies");
  var_1 = getEntArray("junction_pip_drone_far_right_2", "targetname");
  common_scripts\utility::array_thread(var_1, ::junction_pip_drone_think, "send_in_junction_enemies");
  var_2 = getEntArray("junction_pip_drone_close_right", "targetname");
  common_scripts\utility::array_thread(var_2, ::junction_pip_drone_think, "send_in_junction_enemies");
}

junction_pip_drone_think(var_0) {
  wait(randomfloatrange(0.6, 0.8));
  spawn_junction_pip_drones(var_0);
}

spawn_junction_pip_drones(var_0) {
  level endon(var_0);

  for(;;) {
    var_1 = randomintrange(1, 3);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      thread spawn_a_drone();
      wait(randomfloatrange(0.4, 0.7));
    }

    wait(randomfloatrange(14, 18));
    level.total_runner_drone_spawn_count++;

    for(;;) {
      if(level.total_runner_drone_spawn_count == 3) {
        break;
      }

      wait 0.05;
    }

    wait 1;
    level.total_times_without_waver++;

    if(level.total_times_without_waver == 9) {
      thread junction_pip_waver_drone();
      level.total_times_without_waver = 0;
      wait 1;
    }

    level.total_runner_drone_spawn_count = 0;
  }
}

spawn_a_drone() {
  var_0 = 4;

  if(level.total_drones >= var_0) {
    return;
  }
  var_1 = maps\_utility::dronespawn();
  var_1 drone_count();
}

drone_count() {
  level.total_drones++;

  while(isDefined(self))
    wait 0.05;

  level.total_drones--;
}

junction_pip_waver_drone() {
  var_0 = "";

  if(common_scripts\utility::cointoss()) {
    var_0 = "left";
    var_1 = getent("junction_pip_scenario_drone_left_waver", "targetname");
    var_2 = var_1 maps\_utility::dronespawn();
  } else {
    var_0 = "right";
    var_1 = getent("junction_pip_scenario_drone_right_waver", "targetname");
    var_2 = var_1 maps\_utility::dronespawn();
  }

  var_2.animname = "generic";
  wait 1;
  var_3 = common_scripts\utility::getstruct(var_0 + "_wave_struct", "targetname");
  var_2 waittill("goal");
  var_3 maps\_anim::anim_generic_run(var_2, "wave_" + var_0);
  var_4 = common_scripts\utility::getstruct("after_" + var_0 + "_wave_struct", "targetname");
  var_2.target = var_4.targetname;
  var_2 thread maps\_drone::drone_move();
  var_2 waittill("goal");
  var_2 delete();
}

control_panel_setup_lights() {
  common_scripts\utility::waitframe();
  self.green_lights = [];
  self.red_lights = [];
  var_0 = 6;
  var_1 = 7;
  var_2 = 1;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel("cnd_controlpanel_elevator_grn_0" + var_2);
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_2++;
    self.green_lights[var_3] = var_4;
    var_5 = spawn("script_model", (0, 0, 0));

    if(var_1 < 10)
      var_5 setModel("cnd_controlpanel_elevator_red_0" + var_1);
    else
      var_5 setModel("cnd_controlpanel_elevator_red_" + var_1);

    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 hide();
    var_1++;
    self.red_lights[var_3] = var_5;
  }
}

junction_elevator_control_panel_lights_off(var_0) {
  var_1 = var_0.green_lights.size;
  var_2 = 0.2;

  for(var_3 = var_1 - 1; var_3 >= 0; var_3--) {
    var_0.green_lights[var_3] hide();
    var_0.red_lights[var_3] show();
    wait(var_2);
  }
}

junction_enemy_setup() {
  maps\_utility::set_baseaccuracy(0.1);
  common_scripts\utility::flag_wait("send_in_junction_enemies");

  if(isDefined(self))
    maps\_utility::set_baseaccuracy(1);
}

junction_enemies() {
  maps\_utility::array_spawn_function_targetname("junction_backup_guys_starters", ::junction_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("junction_backup_guys_starters", 1);
  common_scripts\utility::array_thread(var_0, ::magicbullet_spray);
  common_scripts\utility::flag_wait("send_in_junction_enemies");
  maps\_utility::array_spawn_function_targetname("junction_backup_guys1", ::junction_enemy_setup);
  var_1 = maps\_utility::array_spawn_targetname("junction_backup_guys1", 1);
  common_scripts\utility::waitframe();
  maps\_utility::remove_dead_from_array(var_0);
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  thread maps\cornered_code::ai_array_killcount_flag_set(var_2, 3, "spawn_junction_enemies_wave_2");
  common_scripts\utility::flag_wait_either("spawn_junction_enemies_wave_2", "spawn_junction_enemies_second_wave");
  common_scripts\utility::flag_set("junction_enemies_wave_2");
  var_3 = maps\_utility::array_spawn_targetname("junction_backup_guys2", 1);
  common_scripts\utility::waitframe();
  maps\_utility::remove_dead_from_array(var_2);
  var_2 = common_scripts\utility::array_combine(var_2, var_3);
  thread junction_last_stand(var_2);
  maps\_utility::waittill_dead_or_dying(var_2);
  common_scripts\utility::flag_set("junction_enemies_dead");
}

magicbullet_spray() {
  level endon("send_in_junction_enemies");
  self endon("death");

  for(;;) {
    var_0 = level.allies[level.const_rorke];
    var_1 = var_0 gettagorigin("j_head") + (0, 0, 20);
    var_2 = self gettagorigin("j_head");
    var_3 = vectornormalize(var_1 - var_2);
    var_4 = var_2 + var_3 * (distance(var_1, var_2) - 10);

    if(self.weapon != "none")
      magicbullet(self.weapon, var_4, var_1);

    wait(randomfloatrange(0.5, 2.2));
  }
}

junction_last_stand(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "upper") {
      continue;
    }
    var_1 = common_scripts\utility::add_to_array(var_1, var_3);
  }

  while(var_1.size > 3) {
    var_1 = maps\_utility::remove_dead_from_array(var_1);
    wait 0.05;
  }

  var_5 = getent("junction_backup_guys_last_stand_volume", "targetname");

  for(;;) {
    var_1 = maps\_utility::remove_dead_from_array(var_1);

    if(var_1.size == 0) {
      break;
    }

    foreach(var_7 in var_1) {
      wait(randomfloatrange(1, 2.5));

      if(isalive(var_7))
        var_7 setgoalvolumeauto(var_5);
    }

    wait 5;
  }
}

junction_ally_combat_state() {
  maps\_utility::set_ignoreall(0);
  maps\_utility::set_ignoreme(0);
  maps\_utility::set_baseaccuracy(0.1);
  maps\_utility::disable_dontevershoot();
  self.favoriteenemy = undefined;
  maps\_utility::forceuseweapon("p226", "secondary");
  maps\_utility::forceuseweapon("kriss+eotechsmg_sp+silencer_sp", "primary");
  self.lastweapon = self.weapon;

  if(self.animname == "rorke") {
    self stopanimscripted();
    self.dontavoidplayer = 0;
  }

  common_scripts\utility::flag_wait("send_in_junction_enemies");
  maps\_utility::set_baseaccuracy(1);
}

junction_banners() {
  var_0 = common_scripts\utility::getstruct("banner_org", "targetname");
  var_1 = maps\_utility::spawn_anim_model("elevator_junction_banner");
  var_2 = maps\_utility::spawn_anim_model("elevator_junction_banner_3");
  var_0 thread maps\_anim::anim_loop_solo(var_1, "banner_1_loop", "stop_banner_loop");
  var_0 thread maps\_anim::anim_loop_solo(var_2, "banner_3_loop", "stop_banner_loop");
  common_scripts\utility::flag_wait("rappel_finished");
  var_0 notify("stop_banner_loop");
  waittillframeend;
  var_1 delete();
  var_2 delete();
}

stop_magic_bullet_shield_if_on() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();
}

add_magic_bullet_shield_if_off() {
  if(!isDefined(self.magic_bullet_shield) && !self.delayeddeath)
    maps\_utility::magic_bullet_shield();
}

mission_failed_watcher() {
  var_0 = common_scripts\utility::flag_wait_any_return("rorke_killed", "rorke_killed_2", "baker_killed", "hvt_got_away");
  var_1 = undefined;

  switch (var_0) {
    case "rorke_killed":
      var_1 = & "CORNERED_RORKE_WAS_KILLED";
      break;
    case "rorke_killed_2":
      var_1 = & "CORNERED_RORKE_WAS_KILLED";
      break;
    case "baker_killed":
      var_1 = & "CORNERED_BAKER_WAS_KILLED";
      break;
    case "hvt_got_away":
      var_1 = & "CORNERED_HVT_GOT_AWAY";
      break;
  }

  setdvar("ui_deadquote", var_1);
  thread maps\_utility::missionfailedwrapper();
  level notify("stop_mission_failed_watcher");
}