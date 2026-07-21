/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_infil.gsc
***********************************************/

embassy_infil_precache() {
  precachemodel("hat_prop_hero_price_boonie");
  precachemodel("body_hero_price_desert_wind");
  precachemodel("hat_hero_price_boonie_withStrap_wind");
  precachemodel("door_metal_roller_01_closed_large_01_emb");
  precachemodel("veh8_civ_lnd_skilo_lights");
  precachemodel("electrical_office_security_lock_01");
  precachemodel("electrical_office_security_lock_01_lock");
  precachemodel("un_office_paper_01");
  precachemodel("barrier_chain_link_fence_32_01");
  precachemodel("equipment_antenna_set_01_tall");
  precachemodel("head_villain_enforcer_blendshape");
  thread embassy_infil_precache_delay();
}

embassy_infil_precache_delay() {
  wait 0.3;

  if(!scripts\sp\starts::is_after_start("cctv_02")) {
    var_0 = getEntArray("alley_cars", "targetname");
    scripts\engine\utility::array_call(var_0, ::hide);
  }
}

embassy_infil_fx() {}

embassy_infil_init() {
  truck_office_setup_truck();
  truck_office_setup_walls();

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_scene"))
    truck_office_hide_all();

  thread embassy_infil_scriptables_grab();
  level.ap_infil_crash = getEnt("ap_infil_crash", "targetname");
  thread emb_roof_door_setup(!scripts\sp\starts::is_after_start("infil_offices"));

  if(scripts\sp\starts::is_after_start("infil_offices"))
    scripts\engine\utility::delaythread(0.05, ::emb_roof_door_remove);

  level.alley_life_kids_door = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("alley_life_kids_door", 1);
  level.alley_life_kids_door hide();

  if(!scripts\sp\starts::is_after_start("infil_stairwell"))
    showmayhem("vfx_mayh_embassy_flag_burn_right");
}

temp_print_screen_type() {
  for(;;)
    waitframe();
}

set_monitor_script_noteworthy() {
  if(scripts\engine\utility::array_contains(level.offices_scriptables, self)) {
    switch (randomint(10)) {
      case 1:
      case 0:
        self.script_noteworthy = "bink1";
        break;
      case 3:
      case 2:
        self.script_noteworthy = "bink3";
        break;
      case 6:
      case 5:
      case 4:
        self.script_noteworthy = "bink4";
        break;
      case 9:
      case 8:
      case 7:
      default:
        self.script_noteworthy = "off";
        break;
    }
  } else if(scripts\engine\utility::array_contains(level.lower_floors_scriptables, self)) {
    switch (randomint(10)) {
      case 3:
      case 2:
      case 1:
      case 0:
        self.script_noteworthy = "bink4";
        break;
      case 9:
      case 8:
      case 7:
      case 6:
      case 5:
      case 4:
      default:
        self.script_noteworthy = "off";
        break;
    }
  } else
    self.script_noteworthy = "full";
}

set_tv_script_noteworthy() {
  if(scripts\engine\utility::array_contains(level.offices_scriptables, self)) {
    switch (randomint(10)) {
      case 4:
      case 3:
      case 2:
      case 1:
      case 0:
        self.script_noteworthy = "bink2";
        break;
      default:
        self.script_noteworthy = "off";
        break;
    }
  } else if(scripts\engine\utility::array_contains(level.lower_floors_scriptables, self)) {
    switch (randomint(10)) {
      case 4:
      case 3:
      case 2:
      case 1:
      case 0:
        self.script_noteworthy = "bink2";
        break;
      default:
        self.script_noteworthy = "off";
        break;
    }
  } else
    self.script_noteworthy = "full";
}

embassy_infil_scriptables_grab() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  thread hide_defend_scriptables();

  if(isDefined(level.infil_heli))
    level.infil_heli setscriptablepartstate("engine", "off");

  level.offices_scriptables = [];
  level.lower_floors_scriptables = [];
  level.garage_scriptables = [];
  level.compound_scriptables = [];
  var_0 = getscriptablearray();
  var_1 = getEnt("offices_scriptable_hide", "targetname");
  var_2 = getEnt("lower_floors_scriptable_hide", "targetname");
  var_3 = getEnt("garage_scriptable_hide", "targetname");
  var_4 = getEnt("compound_scriptables_hide", "targetname");

  foreach(var_6 in var_0) {
    if(var_6 istouching(var_1))
      level.offices_scriptables[level.offices_scriptables.size] = var_6;

    if(var_6 istouching(var_2))
      level.lower_floors_scriptables[level.lower_floors_scriptables.size] = var_6;

    if(var_6 istouching(var_3))
      level.garage_scriptables[level.garage_scriptables.size] = var_6;

    if(var_6 istouching(var_4))
      level.compound_scriptables[level.compound_scriptables.size] = var_6;

    var_7 = scripts\engine\utility::is_equal(var_6.classname, "scriptable_un_office_computer_monitor_03_ent");
    var_8 = scripts\engine\utility::is_equal(var_6.classname, "scriptable_un_office_dual_wall_monitor_01_ent");

    if(var_7 || var_8) {
      if(!isDefined(var_6.script_noteworthy)) {
        if(var_7)
          var_6 set_monitor_script_noteworthy();
        else
          var_6 set_tv_script_noteworthy();
      }

      switch (var_6.script_noteworthy) {
        case "full":
          var_6 setscriptablepartstate("controller", "full");
          break;
        case "bink1":
          var_6 setscriptablepartstate("controller", "bink1");
          break;
        case "bink2":
          var_6 setscriptablepartstate("controller", "bink2");
          break;
        case "bink3":
          var_6 setscriptablepartstate("controller", "bink3");
          break;
        case "bink4":
          var_6 setscriptablepartstate("controller", "bink4");
          break;
        default:
          var_6 setscriptablepartstate("controller", "off");
          break;
      }

      if(getdvarint("scr_emb_draw_screen_type", 0))
        var_6 thread temp_print_screen_type();
    }
  }
}

hide_defend_scriptables() {
  var_0 = getscriptablearray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.model, "veh8_civ_lnd_secho_mp_black") || scripts\engine\utility::is_equal(var_3.model, "veh8_civ_lnd_secho_mp_blue") || scripts\engine\utility::is_equal(var_3.model, "veh8_civ_lnd_secho_mp_grey") || scripts\engine\utility::is_equal(var_3.model, "veh8_civ_lnd_secho_mp_red"))
      var_1[var_1.size] = var_3;
  }

  foreach(var_3 in var_1)
  var_3.origin = var_3.origin + (0, 0, -2500);

  scripts\engine\utility::flag_wait("office_door_closed");

  foreach(var_3 in var_1)
  var_3.origin = var_3.origin + (0, 0, 2500);
}

embassy_infil_flags() {
  scripts\engine\utility::flag_init("kill_crowd_shadows");
  scripts\engine\utility::flag_init("crash_crawl_succeeded");
  scripts\engine\utility::flag_init("fall_impact_done");
  scripts\engine\utility::flag_init("player_up");
  scripts\engine\utility::flag_init("near_roof_door");
  scripts\engine\utility::flag_init("near_office_door");
  scripts\engine\utility::flag_init("cue_exit_civs");
  scripts\engine\utility::flag_init("near_exit_to_stairs");
  scripts\engine\utility::flag_init("marines_dead");
  scripts\engine\utility::flag_init("passed_door_to_stairs");
  scripts\engine\utility::flag_init("office_door_closed");
  scripts\engine\utility::flag_init("stair_b");
  scripts\engine\utility::flag_init("price_passed_stair_c");
  scripts\engine\utility::flag_init("door_bust");
  scripts\engine\utility::flag_init("price_busting_through");
  scripts\engine\utility::flag_init("md_close_door");
  scripts\engine\utility::flag_init("bpg_scene_preload");
  scripts\engine\utility::flag_init("bpg_scene_near_start");
  scripts\engine\utility::flag_init("bpg_scene_player_tried_door");
  scripts\engine\utility::flag_init("bpg_scene_interact_success");
  scripts\engine\utility::flag_init("bpg_scene_door_inaccessible");
  scripts\engine\utility::flag_init("bpg_scene_enforcer_done");
  scripts\engine\utility::flag_init("kid_grabbed");
  scripts\engine\utility::flag_init("bpg_scene_complete");
  scripts\engine\utility::flag_init("bpg_scene_complete_exited");
  scripts\engine\utility::flag_init("bpg_scene_price_exiting");
  scripts\engine\utility::flag_init("bpg_scene_clear_exit_door");
  scripts\engine\utility::flag_init("bpg_scene_doors_closed");
  scripts\engine\utility::flag_init("bpg_scene_mar_cleared_door");
  scripts\engine\utility::flag_init("perfect_info");
  scripts\engine\utility::flag_init("allow_truck_wreck");
  scripts\engine\utility::flag_init("force_truck_wreck");
  scripts\engine\utility::flag_init("force_drop_ceiling");
  scripts\engine\utility::flag_init("truck_wreck_start");
  scripts\engine\utility::flag_init("bpgc_conf_aq_dead");
  scripts\engine\utility::flag_init("truck_cleared");
  scripts\engine\utility::flag_init("wall_truck_shotgun_enemies_defeated");
  scripts\engine\utility::flag_init("wall_truck_few_enemies_left");
  scripts\engine\utility::flag_init("wall_truck_enemies_defeated");
  scripts\engine\utility::flag_init("bpgc_conference_started");
  scripts\engine\utility::flag_init("bpgc_hostage_started");
  scripts\engine\utility::flag_init("bpgc_interrogation_started");
  scripts\engine\utility::flag_init("player_past_first_wave");
  scripts\engine\utility::flag_init("bpg_combat_first_wave_defeated");
  scripts\engine\utility::flag_init("bpg_combat_second_wave_defeated");
  scripts\engine\utility::flag_init("halligan_scene_done");
  scripts\engine\utility::flag_init("bpgc_price_1a");
  scripts\engine\utility::flag_init("bpgc_price_1b");
  scripts\engine\utility::flag_init("bpgc_price_2a");
  scripts\engine\utility::flag_init("bpgc_price_2b");
  scripts\engine\utility::flag_init("bpgc_price_to_basement");
  scripts\engine\utility::flag_init("bpgc_reached_hallway_to_basement");
  scripts\engine\utility::flag_init("reached_basement");
  scripts\engine\utility::flag_init("bas_price_stairs");
  scripts\engine\utility::flag_init("bas_price_hallway");
  scripts\engine\utility::flag_init("bas_price_boiler");
  scripts\engine\utility::flag_init("basement_aq_defeated");
  scripts\engine\utility::flag_init("reached_saferoom");
  scripts\engine\utility::flag_init("player_buzzing_saferoom");
  scripts\engine\utility::flag_init("price_reached_saferoom");
  scripts\engine\utility::flag_init("saferoom_door_closed");
  scripts\engine\utility::flag_init("obj_using_cctv");
  scripts\engine\utility::flag_init("reached_rendezvous");
  scripts\engine\utility::flag_init("heroes_at_exit");
  scripts\engine\utility::flag_init("reached_garage_exit");
  scripts\engine\utility::flag_init("esc_com_pushed_to_courtyard");
  scripts\engine\utility::flag_init("esc_com_pushed_to_courtyard_exit");
  scripts\engine\utility::flag_init("esc_com_pushed_to_alley_start");
  scripts\engine\utility::flag_init("reached_alley");
  scripts\engine\utility::flag_init("reached_alley_start");
  scripts\engine\utility::flag_init("cue_alley_life_kids");
  scripts\engine\utility::flag_init("kids_done_talking");
  scripts\engine\utility::flag_init("cue_alley_life_tv");
  scripts\engine\utility::flag_init("tv_civ_fleeing");
  scripts\engine\utility::flag_init("reached_alley_end");
  scripts\engine\utility::flag_init("reached_residence_arrival");
  scripts\engine\utility::flag_init("reached_wolf_escort_1");
  scripts\engine\utility::flag_init("reached_wolf_escort_2");
  scripts\engine\utility::flag_init("reached_wolf_escort_3");
  scripts\engine\utility::flag_init("reached_wolf_escort_4");
  scripts\engine\utility::flag_init("office_side_vo_1");
  scripts\engine\utility::flag_init("office_side_vo_2");
  scripts\engine\utility::flag_init("office_side_vo_3");
  scripts\engine\utility::flag_init("start_basement_enemy_vo");
  scripts\engine\utility::flag_init("ground_enemy_bypassed");
}

embassy_infil_hints() {
  scripts\engine\sp\utility::add_hint_string("hint_use_flashbang", &"EMBASSY/FLASHBANG_HINT", ::hide_flash_bang_hint);
  scripts\engine\sp\utility::add_hint_string("hint_crawl_forward", &"EMBASSY/CRAWL_FORWARD_HINT", ::hide_crawl_forward_hint);
  scripts\engine\sp\utility::add_hint_string("hint_jump", &"EMBASSY/JUMP_HINT", ::hide_jump_hint);
}

hide_flash_bang_hint() {
  return level.player secondaryoffhandbuttonPressed() || scripts\engine\utility::flag("reached_basement") || scripts\engine\utility::flag("bpg_combat_second_wave_defeated") || isDefined(level.flash_hint_timer) && scripts\engine\utility::time_has_passed(level.flash_hint_timer, 10);
}

hide_crawl_forward_hint() {
  return level.player scripts\sp\maps\embassy\embassy_util.gsc::moving_forward() || scripts\engine\utility::flag("missionfailed");
}

hide_jump_hint() {
  return level.player jumpbuttonPressed() || scripts\engine\utility::flag("missionfailed");
}

embassy_infil_objectives() {
  scripts\engine\sp\objectives::objective_add("main_objective", "current", (0, 0, 0), &"EMBASSY/OBJ_DSC_RENDEZVOUS", &"EMBASSY/OBJ_LBL_RENDEZVOUS");

  if(!scripts\sp\starts::is_after_start("infil_saferoom")) {
    if(!scripts\sp\starts::is_after_start("infil_embassy_rooftop")) {
      var_0 = scripts\engine\utility::getStruct("obj_infil_embassy", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      scripts\engine\sp\utility::wait_for_targetname_trigger("obj_infil_embassy_complete");
    }

    if(!scripts\sp\starts::is_after_start("infil_offices")) {
      var_0 = scripts\engine\utility::getStruct("obj_locate_the_wolf_stairs", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      scripts\engine\sp\utility::wait_for_targetname_trigger("obj_locate_the_wolf_stairs_complete");
    }

    if(!scripts\sp\starts::is_after_start("infil_bp_glass_scene")) {
      var_0 = scripts\engine\utility::getStruct("obj_locate_the_wolf_elevators", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      scripts\engine\sp\utility::wait_for_targetname_trigger("obj_locate_the_wolf_elevators_complete");
    }

    if(!scripts\sp\starts::is_after_start("infil_truck_office")) {
      var_0 = scripts\engine\utility::getStruct("obj_locate_the_wolf_bpg_combat", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      scripts\engine\sp\utility::wait_for_targetname_trigger("obj_locate_the_wolf_bpg_combat_complete");
    }

    if(!scripts\sp\starts::is_after_start("infil_bp_glass_combat")) {
      var_0 = scripts\engine\utility::getStruct("obj_locate_the_wolf_basement_stairs", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      scripts\engine\sp\utility::wait_for_targetname_trigger("obj_locate_the_wolf_basement_stairs_complete");
    }

    if(!scripts\sp\starts::is_after_start("infil_saferoom")) {
      var_0 = scripts\engine\utility::getStruct("obj_locate_the_wolf_saferoom", "targetname");
      scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
      level waittill("obj_found_wolf");
      var_0 = scripts\engine\utility::getStruct("obj_locate_ambassador", "targetname");
      scripts\engine\sp\objectives::objective_update("main_objective", "current", var_0.origin, &"EMBASSY/OBJ_DSC_AMBASSADOR", &"EMBASSY/OBJ_LBL_AMBASSADOR");
      level waittill("obj_using_cctv");
    }
  }

  scripts\engine\sp\objectives::objective_remove("main_objective");

  if(!scripts\sp\starts::is_after_start("cctv_02"))
    level waittill("obj_cctv_done");

  scripts\engine\sp\objectives::objective_add("main_objective", "current", (0, 0, 0), &"EMBASSY/OBJ_DSC_RENDEZVOUS", &"EMBASSY/OBJ_LBL_RENDEZVOUS");

  if(!scripts\sp\starts::is_after_start("escape")) {
    scripts\engine\sp\objectives::objective_update("main_objective", "current", (0, 0, 0), &"EMBASSY/OBJ_DSC_RENDEZVOUS", &"EMBASSY/OBJ_LBL_RENDEZVOUS");
    scripts\engine\sp\objectives::objective_set_on_entity("main_objective", "on_price", level.price);
    scripts\engine\sp\objectives::objective_set_z_offset("main_objective", 72);
    level waittill("obj_rendezvous_at_exit_complete");
    var_0 = scripts\engine\utility::getStruct("obj_escort_wolf_gar_exit", "targetname");
    scripts\engine\sp\objectives::objective_update("main_objective", "current", var_0.origin, &"EMBASSY/OBJ_DSC_ESCORT", &"EMBASSY/OBJ_LBL_ESCORT");
    scripts\engine\utility::flag_wait("reached_garage_exit");
  }

  if(!scripts\sp\starts::is_after_start("escape_combat")) {
    var_0 = scripts\engine\utility::getStruct("obj_escort_wolf_alley", "targetname");
    scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
    scripts\engine\utility::flag_wait("reached_alley");
  }

  if(!scripts\sp\starts::is_after_start("residence_arrival")) {
    var_0 = scripts\engine\utility::getStruct("obj_escort_wolf", "targetname");
    scripts\engine\sp\objectives::objective_set_position("main_objective", var_0.origin);
    level waittill("obj_escort_wolf_complete");
    var_0 = scripts\engine\utility::getStruct("obj_join_forces", "targetname");
    scripts\engine\sp\objectives::objective_update("main_objective", "current", var_0.origin, &"EMBASSY/OBJ_DSC_JOIN_FORCES", &"EMBASSY/OBJ_LBL_JOIN_FORCES");
    level waittill("obj_join_forces_complete");
  }

  scripts\engine\sp\objectives::objective_remove("main_objective");
}

heli_crash_debris_setup() {
  level.pre_crash_ents = getEntArray("infil_pre_heli_crash", "targetname");
  level.post_crash_ents = getEntArray("infil_post_heli_crash", "targetname");
  level.emb_rooftop_corner_clean = getEntArray("emb_rooftop_corner_clean", "targetname");
  level.emb_rooftop_corner_destructed = getEntArray("emb_rooftop_corner_destructed", "targetname");
}

heli_crash_debris_pre() {
  scripts\engine\utility::array_thread(level.pre_crash_ents, scripts\engine\sp\utility::show_entity);
  scripts\engine\utility::array_thread(level.post_crash_ents, scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(level.emb_rooftop_corner_clean, scripts\engine\sp\utility::show_entity);
  scripts\engine\utility::array_thread(level.emb_rooftop_corner_destructed, scripts\engine\sp\utility::hide_entity);
}

heli_crash_debris_post() {
  scripts\engine\utility::array_call(level.pre_crash_ents, ::delete);
  scripts\engine\utility::array_thread(level.post_crash_ents, scripts\engine\sp\utility::show_entity);
}

heli_crash_debris_post_roof() {
  scripts\engine\utility::array_call(level.emb_rooftop_corner_clean, ::delete);
  scripts\engine\utility::array_thread(level.emb_rooftop_corner_destructed, scripts\engine\sp\utility::show_entity);
}

infil_heli_setup() {
  level.infil_heli = getEnt("delivery_copter", "targetname");
  level.infil_heli scripts\engine\sp\utility::assign_animtree("infil_heli");
  level.infil_heli.interior = getEnt("delivery_copter_interior", "targetname");
  level.infil_heli.interior linkTo(level.infil_heli);
  playFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_red"), level.infil_heli, "tag_light_cargo01");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_red"), level.infil_heli, "tag_light_cargo02");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_blue"), level.infil_heli, "tag_light_cockpit01");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_white_blink_lit"), level.infil_heli, "tag_light_belly");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_red_blink_lit"), level.infil_heli, "tag_light_tail");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_red_lit"), level.infil_heli, "tag_light_L_wing");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_green_lit"), level.infil_heli, "tag_light_R_wing");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_vectorfield_blima"), level.infil_heli, "tag_origin");
  level.infil_heli.magic_heli_fire = infil_heli_under_fire_setup("magic_heli_fire");
  level.infil_heli.magic_heli_fire_target = infil_heli_under_fire_setup("magic_heli_fire_target");
  level.infil_heli.magic_heli_squibs = infil_heli_under_fire_setup_array("magic_heli_squib");
}

infil_heli_delete() {
  level.infil_heli.interior delete();
  level.infil_heli.magic_heli_fire delete();
  level.infil_heli.magic_heli_fire_target delete();
  scripts\engine\utility::array_delete(level.infil_heli.magic_heli_squibs);
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_red"), level.infil_heli, "tag_light_cargo01");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_red"), level.infil_heli, "tag_light_cargo02");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_blue"), level.infil_heli, "tag_light_cockpit01");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_white_blink_lit"), level.infil_heli, "tag_light_belly");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_red_blink_lit"), level.infil_heli, "tag_light_tail");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_red_lit"), level.infil_heli, "tag_light_L_wing");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_green_lit"), level.infil_heli, "tag_light_R_wing");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_vectorfield_blima"), level.infil_heli, "tag_origin");
  level.infil_heli delete();
}

infil_heli_under_fire_setup(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 linkTo(level.infil_heli);
  return var_1;
}

infil_heli_under_fire_setup_array(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 linkTo(level.infil_heli);

  return var_1;
}

helicopter_start() {}

helicopter_main() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.05);
  level.player scripts\engine\utility::delaycall(0.2, ::setclienttriggeraudiozone, "embassy_chopper", 0.1);
  level.og_zplanes = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 2 10000");
  setsaveddvar("LRTTMPMQOO", 0);
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  setsaveddvar("MRNRKKOPLN", 3);
  setsaveddvar("OLSKLTPPMR", 0.5);
  setsaveddvar("MQPQKNPQOK", 12);
  setsaveddvar("LQLSPQOPKM", 40);
  setsaveddvar("NQTLPTNSSO", 12);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  level.price.anim_playvo_func = scripts\engine\utility::playsoundontag;
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::halligan_draw();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\engine\sp\utility::set_start_location("helicopter_start", [level.player, level.price]);
  level.ap_infil_crash.og_origin = level.ap_infil_crash.origin;
  level.ap_infil_crash.og_angles = level.ap_infil_crash.angles;
  infil_heli_setup();
  level.player.rig linkTo(level.infil_heli);
  level.price linkTo(level.infil_heli);
  thread heli_pilot_setup();
  scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.0, 0, 0, 0, 0);
  thread audio_crowd_angry_outside();
  scripts\sp\maps\embassy\embassy_util.gsc::make_player_and_price_story_only();
  thread scripts\sp\analytics::analytics_kleenex_update("Cinematic");
  level.player lerpfovscalefactor(0, 0);
  scripts\engine\sp\utility::autosave_by_name("helicopter");
  scripts\engine\utility::exploder("hide_crowd");
  scripts\engine\utility::exploder("ent_field_fog");
  heli_crash_debris_setup();
  heli_crash_debris_pre();
  heli_wreckage_setup();
  heli_wreckage_first_frame();
  grab_and_store_gates();
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_infil_helicopter_start();
  thread gate_overrun();
  thread crowd();
  thread gate_climbers_setup();
  thread heli_shake_controller();
  thread audio_infil_crowd();
  thread audio_chopper_struggling();
  thread heli_letter_boxing();
  thread heli_under_fire();
  thread heli_gate_molotov();
  thread heli_windy_price(1);
  level.fast_rope = scripts\engine\sp\utility::spawn_anim_model("infil_fast_rope");
  level.fast_rope linkTo(level.infil_heli);
  level.infil_heli thread scripts\common\anim::anim_single_solo(level.fast_rope, "infil_crash_ride");
  var_0 = getspawnerarray("heli_rocket_guy");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::heli_rocketeer);
  scripts\engine\sp\utility::array_spawn(var_0);
  var_1 = scripts\engine\sp\utility::spawn_anim_model("infil_crash_rocket");
  var_1 thread heli_rocket(1);
  level.player scripts\engine\utility::delaycall(10.0, ::lerpviewangleclamp, 1, 0, 0, 15, 15, 15, 15);
  thread heli_kyle_third_person();
  level.infil_heli thread scripts\common\anim::anim_single_solo(level.pilot, "infil_crash_ride");
  level.infil_heli thread scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_ride");
  level.infil_heli thread scripts\common\anim::anim_single_solo(level.price, "infil_crash_ride");
  level.ap_infil_crash scripts\common\anim::anim_single_solo(level.infil_heli, "infil_crash_ride");
}

heli_letter_boxing() {
  setomnvar("ui_hide_hud", 1);
  hidecinematicletterboxing(0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  wait 8.5;
  getrandomnodedestination(1.5, 0);
  level.player scripts\common\utility::allow_cinematic_motion(1);
  wait 1.5;
  setomnvar("ui_hide_hud", 0);
  thread scripts\sp\introscreen::introscreen(1);
}

heli_kyle_third_person() {
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.kyle linkTo(level.infil_heli);
  level.kyle scripts\engine\sp\utility::name_hide();
  level.infil_heli scripts\common\anim::anim_single_solo(level.kyle, "infil_crash_ride");
  level.kyle delete();
}

heli_wreckage_setup() {
  level.roof_wreckage = [];
  level.roof_wreckage[0] = scripts\engine\sp\utility::spawn_anim_model("infil_crash_wreckage_01");
  level.roof_wreckage[1] = scripts\engine\sp\utility::spawn_anim_model("infil_crash_wreckage_02");
  level.roof_wreckage[2] = scripts\engine\sp\utility::spawn_anim_model("infil_crash_wreckage_03");
}

heli_wreckage_first_frame() {
  foreach(var_1 in level.roof_wreckage)
  level.ap_infil_crash scripts\common\anim::anim_first_frame_solo(var_1, "infil_crash_fall");
}

heli_pilot_setup() {
  level.pilot = scripts\engine\sp\utility::spawn_targetname("helicopter_pilot");
  level.pilot.animname = "pilot";

  if(!scripts\sp\starts::is_after_start("infil_helicopter"))
    level.pilot linkTo(level.infil_heli);
  else {
    while(!isDefined(level.infil_heli))
      waitframe();

    if(!scripts\sp\starts::is_after_start("infil_helicopter_crawl"))
      level.pilot linkTo(level.infil_heli);
  }

  level.pilot hide();
}

heli_rocketeer() {
  if(!isDefined(level.rocketeer_count))
    level.rocketeer_count = 1;
  else
    level.rocketeer_count++;

  self.animname = "rocketeer_" + level.rocketeer_count;
  level.ap_infil_crash scripts\common\anim::anim_single_solo(self, "infil_crash_ride");
  self delete();
}

heli_rocket(var_0) {
  level.ap_infil_crash thread scripts\common\anim::anim_single_solo(self, "infil_crash_ride");
  level waittill("rocket_fire");
  playFXOnTag(scripts\engine\utility::getfx("vfx_emb_infil_helirocket"), self, "tag_origin");
  var_1 = "embassy_infil_rpg_01_miss";

  if(var_0)
    var_1 = "embassy_infil_rpg_02_hit";

  self playSound(var_1);
  level waittill("rocket_hit");

  if(var_0) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_emb_infil_helismoke"), level.infil_heli, "tag_origin");
    level.player playRumbleOnEntity("heavy_3s");
    screenshake(level.player.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
    level.player modifybasefov(70, 0.25);
    level.player lerpviewangleclamp(0.1, 0.01, 0.01, 0, 0, 0, 0);
  }

  self delete();
}

heli_under_fire() {
  wait 29.5;
  level.player playSound("embassy_infil_bullet_hits_lr");
  heli_under_fire_magic_bullet();
  wait 0.1;
  playFX(scripts\engine\utility::getfx("vfx_imp_metal_thick_med"), level.infil_heli.magic_heli_squibs[0].origin);
  wait 0.2;
  heli_under_fire_magic_bullet();
  wait 0.1;
  playFX(scripts\engine\utility::getfx("vfx_imp_metal_thick_med"), level.infil_heli.magic_heli_squibs[1].origin);
  wait 0.2;
  heli_under_fire_magic_bullet();
  wait 0.1;
  playFX(scripts\engine\utility::getfx("vfx_imp_metal_thick_med"), level.infil_heli.magic_heli_squibs[2].origin);
}

heli_under_fire_magic_bullet() {
  for(var_0 = 0; var_0 < randomintrange(12, 18); var_0++) {
    var_1 = level.infil_heli.magic_heli_fire.origin;
    var_2 = level.infil_heli.magic_heli_fire_target.origin;
    var_3 = (0, 0, randomintrange(-300, 300));
    magicbullet("iw8_ar_akilo47", var_1, var_2 + var_3);
    wait(randomfloatrange(0.015, 0.05));
  }
}

heli_gate_molotov() {
  wait 18;
  heli_gate_molotov_helper("magic_molotov_start", "magic_molotov_end");
  scripts\engine\utility::exploder("magic_molotov_end_spot");
  wait 3;
  heli_gate_molotov_helper("magic_molotov_start_2", "magic_molotov_end_2");
  scripts\engine\utility::exploder("magic_molotov_end_spot_2");
}

heli_gate_molotov_helper(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = magicgrenade("molotov", var_2.origin, var_3.origin);
  var_4 endon("entitydeleted");
  scripts\sp\equipment\molotov::molotovfiremain(var_4);
  var_4 thread scripts\engine\sp\utility::play_sound_on_entity("embassy_infil_molotov_break");
}

audio_chopper_struggling() {
  level waittill("rocket_hit");
  level.embassy_helicopter_struggle_sound_ent = spawn("script_origin", level.player.origin);
  level.embassy_helicopter_struggle_tone_sound_ent = spawn("script_origin", level.player.origin);
  level.embassy_helicopter_struggle_sound_ent playLoopSound("embassy_infil_chopper_struggle_loop_lr");
  level.embassy_helicopter_struggle_tone_sound_ent playLoopSound("embassy_infil_chopper_crashing_tone");
  scripts\engine\utility::flag_wait("crash_crawl_succeeded");
  level.embassy_helicopter_struggle_tone_sound_ent thread scripts\engine\sp\utility::sound_fade_and_delete(0.3);
  wait 1.0;
  level.infil_heli thread scripts\engine\sp\utility::sound_fade_in("embassy_infil_jump_out_chopper_struggle_lr", 1, 0.25);
  level.embassy_helicopter_struggle_sound_ent thread scripts\engine\sp\utility::sound_fade_and_delete(0.8);
}

audio_infil_crowd() {
  wait 7.5;
  level.embassy_crowd_sound_ent_01 playSound("embassy_infil_crowd_01_short");
  level.embassy_crowd_sound_ent_02 playSound("embassy_infil_crowd_02_short");
  level waittill("rocket_hit");
  level.embassy_crowd_sound_ent_01 stopsounds(0.3);
  level.embassy_crowd_sound_ent_02 stopsounds(0.3);
}

audio_crowd_angry_outside(var_0) {
  if(isDefined(var_0))
    scripts\engine\utility::flag_set("audio_outside_crowd_loop");

  level.embassy_crowd_sound_ent_01 = spawn("script_origin", (-6127, -637, 268));
  level.embassy_crowd_sound_ent_02 = spawn("script_origin", (-7543, -707, 268));
  level.embassy_gate_sound_ent_01 = spawn("script_origin", (-5959, -1268, 167));
  scripts\engine\utility::flag_wait("audio_outside_crowd_loop");
  wait 2;
  level.embassy_crowd_sound_ent_01 playLoopSound("embassy_infil_crowd_01_angry_lp");
  level.embassy_crowd_sound_ent_02 playLoopSound("embassy_infil_crowd_02_angry_lp");
}

audio_office_alarm_loop_start() {
  level.embassy_alarm_sound_ent_01 = spawn("script_origin", (-6498, -3007, 640));
  level.embassy_alarm_sound_ent_02 = spawn("script_origin", (-7901, -2397, 646));
  level.embassy_alarm_sound_ent_03 = spawn("script_origin", (-7383, -2965, 642));
  wait 1;
  level.embassy_alarm_sound_ent_01 playLoopSound("embassy_upstairs_office_alarm_01_lp");
  level.embassy_alarm_sound_ent_02 playLoopSound("embassy_upstairs_office_alarm_01_lp");
  level.embassy_alarm_sound_ent_03 playLoopSound("embassy_upstairs_office_alarm_01_lp");
  level waittill("stop_upstairs_office_alarm_loops");
  level.embassy_alarm_sound_ent_01 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
  level.embassy_alarm_sound_ent_02 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
  level.embassy_alarm_sound_ent_03 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
}

audio_post_truck_office_alarm_loop_start() {
  level.embassy_post_truck_alarm_sound_ent_01 = spawn("script_origin", (-7409, -2949, 147));
  level.embassy_post_truck_alarm_sound_ent_02 = spawn("script_origin", (-8099, -2568, 147));
  wait 1;
  level.embassy_post_truck_alarm_sound_ent_01 playLoopSound("embassy_upstairs_office_alarm_02_lp");
  level.embassy_post_truck_alarm_sound_ent_02 playLoopSound("embassy_upstairs_office_alarm_02_lp");
  level waittill("stop_downstairs_office_alarm_loops");
  level.embassy_post_truck_alarm_sound_ent_01 thread scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  level.embassy_post_truck_alarm_sound_ent_02 thread scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

audio_bpg_entrance_alarm_loop_start() {
  level.embassy_alarm_sound_ent_04 = spawn("script_origin", (-6939, -2190, 149));
  wait 1;
  level.embassy_alarm_sound_ent_04 playLoopSound("embassy_upstairs_office_alarm_03_lp");
  level waittill("stop_bpg_entrance_alarm_loop");
  level.embassy_alarm_sound_ent_04 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
}

audio_crowd_cheer_at_end_of_infil_crash() {
  level waittill("heli_crash_done");
  wait 0.8;
  level.embassy_gate_sound_ent_01 playSound("embassy_infil_crowd_cheer_chopper_down");
}

crowd_get_and_store() {
  level.crowds = [];

  for(var_0 = 0; var_0 <= 34; var_0++) {
    if(!crowd_removed_for_skinned_verts(var_0 + 1)) {
      if(crowd_is_back_row(var_0 + 1)) {
        level.crowds[var_0] = scripts\engine\sp\utility::spawn_anim_model("crowd_low");
        level.crowds[var_0].front_row = 0;
        continue;
      }

      level.crowds[var_0] = scripts\engine\sp\utility::spawn_anim_model("crowd");
      level.crowds[var_0].front_row = crowd_is_front_row(var_0 + 1);
    }
  }
}

crowd_removed_for_skinned_verts(var_0) {
  return var_0 == 9 || var_0 == 18 || var_0 == 23 || var_0 == 24 || var_0 == 25 || var_0 == 26 || var_0 == 27 || var_0 == 28 || var_0 == 29 || var_0 == 32 || var_0 == 35;
}

crowd_is_front_row(var_0) {
  var_1 = [1, 2, 6, 10, 11];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

crowd_is_back_row(var_0) {
  var_1 = [3, 4, 34, 5, 30, 8, 7, 9, 12, 29, 13, 14, 15, 18, 19, 21, 23, 24, 25, 26, 27, 28];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

crowd_setup_ap() {
  level.crowd_ap = spawnStruct();
  level.crowd_ap.origin = level.ap_gate_overrun.origin;
  level.crowd_ap.angles = level.ap_gate_overrun.angles;
  level.crowd_ap.angles = level.crowd_ap.angles + (0, -90, 0);
}

temp_draw_crowd_num() {
  self endon("entitydeleted");

  for(;;)
    waitframe();
}

crowd() {
  crowd_get_and_store();
  crowd_setup_ap();
  thread crowd_vehicles();
  thread periph_traffic("md_close_door");

  foreach(var_2, var_1 in level.crowds) {
    var_1.animname = "crowd_" + (var_2 + 1);

    if(isDefined(level.scr_anim[var_1.animname]["crowd_enter"])) {
      var_1 thread crowd_enterer();
      continue;
    }

    level.crowd_ap thread scripts\common\anim::anim_loop_solo(var_1, "crowd_chant", "stop_loop_" + var_1.animname);

    if(var_2 < 2)
      var_1 thread crowd_change_anim_at_offices();
  }

  scripts\engine\utility::flag_wait("kill_crowd_shadows");

  foreach(var_1 in level.crowds)
  var_1 dontcastshadows();

  while(!scripts\engine\utility::flag("md_close_door")) {
    foreach(var_1 in level.crowds) {
      if(isDefined(level.scr_anim[var_1.animname]["crowd_chant"])) {
        var_6 = var_1 scripts\engine\utility::getanim("crowd_chant");
        var_1 setanimrate(var_6[0], 2);
      }
    }

    scripts\engine\sp\utility::wait_for_flag_or_timeout("md_close_door", 0.3);
  }

  foreach(var_1 in level.crowds) {
    if(!var_1.front_row) {
      var_1 delete();
      level.crowds = scripts\engine\utility::array_remove(level.crowds, var_1);
    }
  }

  while(!scripts\engine\utility::flag("bpg_scene_clear_exit_door")) {
    foreach(var_1 in level.crowds) {
      if(isDefined(level.scr_anim[var_1.animname]["crowd_chant"])) {
        var_6 = var_1 scripts\engine\utility::getanim("crowd_chant");
        var_1 setanimrate(var_6[0], 2);
      }
    }

    scripts\engine\sp\utility::wait_for_flag_or_timeout("bpg_scene_clear_exit_door", 0.3);
  }

  crowd_delete();
}

crowd_change_anim_at_offices() {
  scripts\engine\utility::flag_wait("near_office_door");
  level.crowd_ap notify("stop_loop_" + self.animname);
  level.crowd_ap thread scripts\common\anim::anim_loop_solo(self, "crowd_chant_offices", "stop_loop_" + self.animname);
}

crowd_enterer() {
  if(!scripts\sp\starts::is_after_start("infil_helicopter"))
    level.crowd_ap scripts\common\anim::anim_single_solo(self, "crowd_enter");

  if(isDefined(level.scr_anim[self.animname]["crowd_chant"]))
    level.crowd_ap thread scripts\common\anim::anim_loop_solo(self, "crowd_chant");
  else {
    level.crowds = scripts\engine\utility::array_remove(level.crowds, self);
    self delete();
  }
}

crowd_delete() {
  foreach(var_1 in level.crowds)
  var_1 delete();

  level.crowds = undefined;
}

crowd_vehicles() {
  for(var_0 = 1; var_0 <= 3; var_0++) {
    var_1 = scripts\engine\sp\utility::spawn_anim_model("crowd_veh_" + var_0);
    var_1 thread crowd_individual_vehicle();
  }
}

crowd_individual_vehicle() {
  level.crowd_ap scripts\common\anim::anim_single_solo(self, "crowd_enter");
  self delete();
}

periph_traffic(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_anim_model("periph_veh");
  level.crowd_ap thread scripts\common\anim::anim_first_frame_solo(var_1, "ambiance");
  level.crowd_ap thread scripts\common\anim::anim_loop_solo(var_1, "ambiance", "stop_ambiance");
  scripts\engine\utility::flag_wait(var_0);
  level.crowd_ap notify("stop_ambiance");
  var_1 delete();
}

spawn_gate_overrunners() {
  level.gate_mob_aq_spawners = getspawnerarray("front_gate_overrun_mob_aq");
  level.gate_mob_civ_spawners = getspawnerarray("front_gate_overrun_mob_civ");
  level.gate_aq_spawners = getspawnerarray("front_gate_overrun_fighters");
  level.gate_marine_spawners = getspawnerarray("gate_overrun_marines");
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 0, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 3, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 5, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 6, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 7, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 9, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 11, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 12, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 13, 0);
  level.gate_mob_aq_spawners = scripts\engine\utility::array_remove_index(level.gate_mob_aq_spawners, 15, 0);
  scripts\engine\utility::array_thread(level.gate_mob_aq_spawners, ::gate_overrun_respawner_mob_aq);
  scripts\engine\utility::array_thread(level.gate_mob_civ_spawners, ::gate_overrun_respawner_mob_civ);
  scripts\engine\utility::array_thread(level.gate_aq_spawners, ::gate_overrun_respawner_aq_fighters);
  scripts\engine\utility::array_thread(level.gate_marine_spawners, ::gate_overrun_respawner_marines);
  scripts\engine\utility::delaythread(0.3, ::check_marines);
}

grab_and_store_gates() {
  level.ap_gate_overrun = scripts\engine\utility::getStruct("ap_gate_overrun", "targetname");
  level.front_gate_l = getEnt("front_gate_l", "targetname");
  level.front_gate_l scripts\engine\sp\utility::assign_animtree("gate_l");
  level.front_gate_r = getEnt("front_gate_r", "targetname");
  level.front_gate_r scripts\engine\sp\utility::assign_animtree("gate_r");
  level.wolf_truck = getEnt("wolf_truck", "targetname");
}

gate_overrun() {
  spawn_gate_overrunners();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer();
  level.aq_enforcer hide();

  while(!isDefined(level.gate_overrunners_aq) || !isDefined(level.gate_overrunners_marine) || !isDefined(level.gate_overrunners_mob_aq) || !isDefined(level.gate_overrunners_mob_civ))
    waitframe();

  while(level.gate_overrunners_mob_aq.size != level.gate_mob_aq_spawners.size || level.gate_overrunners_mob_civ.size != level.gate_mob_civ_spawners.size || level.gate_overrunners_aq.size != level.gate_aq_spawners.size || level.gate_overrunners_marine.size != level.gate_marine_spawners.size)
    waitframe();

  foreach(var_2, var_1 in level.gate_overrunners_mob_aq) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.animname = "mob_aq_" + (var_2 + 1);
      var_1 scripts\sp\fakeactor::take_control();
      var_1 scripts\sp\fakeactor::set_do_arrivals(0);
      level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(var_1, "gate_overrun_idle", "overrun_gate");
    }
  }

  foreach(var_2, var_1 in level.gate_overrunners_mob_civ) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.animname = "mob_civ_" + (var_2 + 1);
      var_1 scripts\sp\fakeactor::take_control();
      var_1 scripts\sp\fakeactor::set_do_arrivals(0);
      level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(var_1, "gate_overrun_idle", "overrun_gate");
    }
  }

  foreach(var_2, var_1 in level.gate_overrunners_aq) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.animname = "mob_aq_fight_" + (var_2 + 1);
      level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(var_1, "gate_overrun_idle", "overrun_gate");
    }
  }

  foreach(var_1 in level.gate_overrunners_marine)
  var_1.dontevershoot = 1;

  level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(level.front_gate_l, "gate_overrun_idle", "overrun_gate");
  level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(level.front_gate_r, "gate_overrun_idle", "overrun_gate");
  level.ap_gate_overrun thread scripts\common\anim::anim_loop_solo(level.aq_enforcer, "gate_overrun_idle", "overrun_gate");
  wait 6;
  level.ap_gate_overrun notify("overrun_gate");
  thread gate_open_and_connect_paths(level.front_gate_l);
  thread gate_open_and_connect_paths(level.front_gate_r);
  scripts\engine\utility::array_thread(level.gate_overrunners_mob_aq, ::overrun_gate_mob, level.ap_gate_overrun);
  scripts\engine\utility::array_thread(level.gate_overrunners_mob_civ, ::overrun_gate_mob, level.ap_gate_overrun);

  foreach(var_1 in level.gate_overrunners_aq) {
    if(isDefined(var_1) && isalive(var_1))
      level.ap_gate_overrun thread scripts\common\anim::anim_single_solo(var_1, "gate_overrun");
  }

  level.ap_gate_overrun thread scripts\common\anim::anim_single_solo(level.aq_enforcer, "gate_overrun");
  wait 14;
  level.embassy_crowd_sound_ent_01 playSound("embassy_infil_crowd_cheer_gate");
  level.embassy_gate_sound_ent_01 playSound("embassy_infil_gate_opens");
  wait 1.3;
  thread gate_overrun_fire_rate_controller();
  wait 1;
  var_9 = getEnt("gate_light", "targetname");
  var_10 = scripts\engine\utility::getStruct("gate_light_shooter", "targetname");
  magicbullet("iw8_ar_akilo47", var_10.origin, var_9.origin);
  wait 0.3;
  var_9 setlightintensity(0);
  playFX(scripts\engine\utility::getfx("vfx_dynolight_omni_death_lrg"), var_9.origin);
}

gate_open_and_connect_paths(var_0) {
  level.ap_gate_overrun scripts\common\anim::anim_single_solo(var_0, "gate_overrun");
}

gate_already_open_and_connect_paths(var_0) {
  level.ap_gate_overrun scripts\common\anim::anim_last_frame_solo(var_0, "gate_overrun");
}

overrun_gate_mob(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self) && isalive(self)) {
    var_0 scripts\common\anim::anim_single_solo(self, "gate_overrun");
    scripts\sp\fakeactor::release_control(undefined);
  }
}

gate_overrun_respawner_mob_aq() {
  var_0 = undefined;

  while(!scripts\engine\utility::flag("md_close_door")) {
    self.count = 1;
    var_0 = scripts\engine\sp\utility::spawn_ai();
    var_0.ignoreme = 1;
    var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(1300);

    if(!isDefined(level.gate_overrunners_mob_aq))
      level.gate_overrunners_mob_aq = [];

    level.gate_overrunners_mob_aq[level.gate_overrunners_mob_aq.size] = var_0;

    if(!scripts\engine\utility::flag("md_close_door"))
      var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");

    scripts\engine\utility::array_remove(level.gate_overrunners_mob_aq, var_0);
    wait(randomfloatrange(1.5, 3.0));
  }

  if(isDefined(var_0))
    var_0 delete();
}

gate_overrun_respawner_mob_civ() {
  var_0 = undefined;

  while(!scripts\engine\utility::flag("md_close_door")) {
    self.count = 1;
    var_0 = scripts\engine\sp\utility::spawn_ai();
    var_0.ignoreme = 1;
    var_0.team = "axis";
    var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(1300);

    if(!isDefined(level.gate_overrunners_mob_civ))
      level.gate_overrunners_mob_civ = [];

    level.gate_overrunners_mob_civ[level.gate_overrunners_mob_civ.size] = var_0;

    if(!scripts\engine\utility::flag("md_close_door"))
      var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");

    scripts\engine\utility::array_remove(level.gate_overrunners_mob_civ, var_0);
    wait(randomfloatrange(1.5, 3.0));
  }

  if(isDefined(var_0))
    var_0 delete();
}

gate_overrun_respawner_aq_fighters() {
  var_0 = undefined;
  self.death_count = 0;

  for(self.max_deaths = 0; !scripts\engine\utility::flag("marines_dead"); self.death_count = self.death_count + 1) {
    self.count = 1;
    var_0 = scripts\engine\sp\utility::spawn_ai(1);
    var_0 scripts\engine\utility::script_func("anim_placeweaponon", var_0.secondaryweapon, "none");
    var_0 scripts\engine\utility::script_func("anim_placeweaponon", var_0.sidearm, "none");
    var_0.dontevershoot = 1;
    var_0.disablepistol = 1;
    var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(1300);

    if(self.death_count >= self.max_deaths)
      var_0 scripts\common\ai::magic_bullet_shield();

    if(!isDefined(level.gate_overrunners_aq))
      level.gate_overrunners_aq = [];

    level.gate_overrunners_aq[level.gate_overrunners_aq.size] = var_0;

    if(!scripts\engine\utility::flag("marines_dead"))
      level.passed = var_0 scripts\engine\utility::waittill_any_return("death", "entitydeleted", "marines_dead", "reached_path_end");

    if(!scripts\engine\utility::flag("marines_dead")) {
      var_0.goalradius = 100;
      level.passed_2 = var_0 scripts\engine\utility::waittill_any_return("death", "entitydeleted", "marines_dead");
    }

    scripts\engine\utility::array_remove(level.gate_overrunners_aq, var_0);

    if(!scripts\engine\utility::flag("marines_dead"))
      wait(randomfloatrange(1.5, 3.0));
  }

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.ignoreall = 1;
    var_0 scripts\engine\sp\utility::set_goal_radius(10);

    if(isDefined(var_0.magic_bullet_shield))
      var_0 scripts\common\ai::stop_magic_bullet_shield();

    var_1 = scripts\engine\utility::getStructArray("mobs_done_1", "targetname");
    var_1 = scripts\engine\utility::random(var_1);
    var_0 thread scripts\sp\spawner::go_to_node(var_1);
    var_0 scripts\engine\utility::waittill_any("reached_path_end", "death", "entitydeleted");

    if(isDefined(var_0) && isalive(var_0))
      var_0 delete();
  }
}

gate_overrun_respawner_marines() {
  var_0 = undefined;
  self.death_count = 0;

  for(self.max_deaths = 0; !scripts\engine\utility::flag("near_exit_to_stairs"); self.death_count = self.death_count + 1) {
    self.count = 1;
    var_0 = scripts\engine\sp\utility::spawn_ai();
    var_0 scripts\engine\utility::script_func("anim_placeweaponon", var_0.weapon, "none");
    var_0 scripts\engine\utility::script_func("anim_placeweaponon", var_0.secondaryweapon, "none");
    var_0 scripts\engine\utility::script_func("anim_placeweaponon", var_0.sidearm, "none");

    if(self.classname == "actor_ally_usmc_desert_smg")
      var_0 scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_sm_mpapa5"), "primary");
    else if(self.classname == "actor_ally_usmc_desert_shotgun")
      var_0 scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_sh_romeo870"), "primary");
    else
      var_0 scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_ar_mcharlie"), "primary");

    var_0.dontevershoot = 1;
    var_0.disablepistol = 1;
    var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(1300);
    var_0 scripts\engine\sp\utility::name_hide();

    if(self.death_count >= self.max_deaths)
      var_0 scripts\common\ai::magic_bullet_shield();

    if(!isDefined(level.gate_overrunners_marine))
      level.gate_overrunners_marine = [];

    level.gate_overrunners_marine[level.gate_overrunners_marine.size] = var_0;

    if(!scripts\engine\utility::flag("near_exit_to_stairs"))
      var_0 scripts\engine\utility::waittill_any("death", "entitydeleted", "player_at_stairwell");

    scripts\engine\utility::array_remove(level.gate_overrunners_marine, var_0);
    wait(randomfloatrange(1.5, 3.0));
  }

  if(isDefined(var_0) && isalive(var_0)) {
    if(isDefined(var_0.magic_bullet_shield))
      var_0 scripts\common\ai::stop_magic_bullet_shield();

    var_0.health = 1;
    var_0.attackeraccuracy = 10000;
    scripts\engine\utility::flag_wait("door_bust");

    if(isalive(var_0))
      var_0 scripts\engine\sp\utility::die();
  }
}

gate_overrun_fire_rate_controller() {
  while(!isDefined(level.gate_overrunners_marine) || !isDefined(level.gate_overrunners_aq))
    waitframe();

  while(!scripts\engine\utility::flag("marines_dead")) {
    var_0 = randomintrange(3, 6);
    var_1 = scripts\engine\utility::array_randomize(level.gate_overrunners_marine);
    gate_overrun_set_dont_shoot(var_1, var_0, 0);
    wait(randomfloatrange(3, 6));
    gate_overrun_set_dont_shoot(var_1, var_0, 1);
    wait(randomfloatrange(0.5, 1));
    var_2 = randomintrange(3, 6);
    var_3 = scripts\engine\utility::array_randomize(level.gate_overrunners_aq);
    gate_overrun_set_dont_shoot(var_3, var_2, 0);
    wait(randomfloatrange(3, 6));
    gate_overrun_set_dont_shoot(var_3, var_2, 1);

    if(scripts\engine\utility::flag("near_office_door") && !scripts\engine\utility::flag("near_exit_to_stairs")) {
      wait(randomfloatrange(5, 8));
      continue;
    }

    wait(randomfloatrange(1, 4));
  }
}

gate_overrun_set_dont_shoot(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_4) && isalive(var_4)) {
      var_4.ignoreall = var_2;
      var_4.dontevershoot = var_2;
    }
  }
}

check_marines() {
  scripts\engine\utility::flag_wait("near_exit_to_stairs");
  var_0 = 1;

  while(var_0) {
    var_0 = 0;

    foreach(var_2 in level.gate_overrunners_marine) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_2 notify("player_at_stairwell");
        var_0 = 1;
        break;
      }
    }

    wait 0.3;
  }

  scripts\engine\utility::flag_set("marines_dead");

  foreach(var_5 in level.gate_overrunners_aq)
  var_5 notify("marines_dead");
}

gate_climbers_setup() {
  var_0 = scripts\engine\utility::getStructArray("ap_crowd_fence_climb", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getspawner(var_2.target, "targetname");
    var_3 thread gate_climbers_respawner(var_2);
  }
}

gate_climbers_respawner(var_0) {
  scripts\engine\sp\utility::add_spawn_function(::gate_climber, var_0);
  wait(randomfloatrange(0, 8));

  while(!scripts\engine\utility::flag("md_close_door")) {
    self.count = 1;
    var_1 = scripts\engine\sp\utility::spawn_ai();
    var_1 scripts\engine\utility::waittill_any("entitydeleted", "death");
    waitframe();
  }
}

gate_climber(var_0) {
  self endon("entitydeleted");
  self endon("death");
  self.ignoreme = 1;
  self.animname = "mob_civ_gate_climber";
  scripts\sp\fakeactor::take_control();
  scripts\sp\fakeactor::set_do_arrivals(0);
  var_0 scripts\common\anim::anim_single_solo(self, var_0.script_noteworthy);
  scripts\sp\fakeactor::release_control(undefined);
}

heli_shake_controller() {
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_door_closed();
  level waittill("price_opens_door");
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_door_open();
  level waittill("rocket_fire");
  wait 1.5;
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_stop();
}

heli_windy_price(var_0) {
  if(var_0)
    level waittill("price_opens_door");

  level.price detach(level.price.hatmodel);
  level.price setModel("body_hero_price_desert_wind");
  level.price attach("hat_hero_price_boonie_withStrap_wind");
}

helicopter_catchup() {
  heli_crash_debris_setup();
  var_0 = getEnt("gate_light", "targetname");
  var_0 setlightintensity(0);
  level.ap_infil_crash = getEnt("ap_infil_crash", "targetname");
  level.ap_infil_crash.og_origin = level.ap_infil_crash.origin;
  level.ap_infil_crash.og_angles = level.ap_infil_crash.angles;
  infil_heli_setup();

  if(!scripts\sp\starts::is_after_start("infil_helicopter_crash")) {
    heli_crash_debris_pre();
    level.fast_rope = scripts\engine\sp\utility::spawn_anim_model("infil_fast_rope");
    scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.0, 0, 0, 0, 0);
    level.player.rig linkTo(level.infil_heli);
    level.price linkTo(level.infil_heli);
    level.fast_rope linkTo(level.infil_heli);
  } else
    infil_heli_delete();

  grab_and_store_gates();
  thread gate_already_open_and_connect_paths(level.front_gate_l);
  thread gate_already_open_and_connect_paths(level.front_gate_r);

  if(!scripts\sp\starts::is_after_start("infil_offices")) {
    scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer();
    level.aq_enforcer hide();
  }

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_metal_detectors")) {
    spawn_gate_overrunners();
    gate_climbers_setup();
    thread gate_overrun_fire_rate_controller();
  }

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_scene")) {
    scripts\sp\maps\embassy\embassy_util.gsc::make_player_and_price_story_only();
    thread crowd();
    scripts\engine\utility::exploder("hide_crowd");
    scripts\engine\utility::exploder("hide_crowd_filler");
    scripts\engine\utility::exploder("ent_field_fog");
  }

  if(scripts\sp\starts::is_after_start("infil_bp_glass_scene")) {
    level.wolf_truck delete();
    crowd_get_and_store();
    crowd_delete();
  }
}

wait_variables_initialized() {
  while(!isDefined(level.infil_heli) || !isDefined(level.fast_rope) || !isDefined(level.ap_infil_crash) || !isDefined(level.player.rig) || !isDefined(level.pilot))
    waitframe();
}

temp_draw_world_ap() {
  while(!isDefined(level.ap_infil_crash))
    waitframe();

  for(;;) {
    level.ap_infil_crash scripts\engine\utility::draw_ent_axis();
    waitframe();
  }
}

helicopter_crawl_start() {
  level.og_zplanes = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 2 10000");
  setsaveddvar("LRTTMPMQOO", 0);
  thread audio_crowd_angry_outside();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\engine\sp\utility::set_start_location("helicopter_start", [level.player, level.price]);
  heli_wreckage_setup();
  thread heli_pilot_setup();
  wait_variables_initialized();
  playFXOnTag(scripts\engine\utility::getfx("vfx_emb_infil_helismoke"), level.infil_heli, "tag_origin");
  heli_wreckage_first_frame();
  thread heli_windy_price(0);
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::halligan_draw();
}

helicopter_crawl_main() {
  scripts\engine\utility::flag_set("kill_crowd_shadows");
  level.aq_enforcer forceteleport((-5363.5, -707.5, 32), (0, 0, 0));
  level.aq_enforcer setgoalpos(level.aq_enforcer.origin);
  scripts\engine\sp\utility::autosave_by_name("helicopter_crawl");
  thread helicopter_spin_fail(level.ap_infil_crash, level.infil_heli);
  thread grab_rope_nags();
  thread heli_crawl_to_idle(level.price);
  thread heli_crawl_to_idle(level.pilot);
  thread heli_crawl_to_idle(level.fast_rope);
  level.player lerpviewangleclamp(0.25, 0.25, 0.5, 15, 15, 15, 15);
  level.player modifybasefov(65, 0.25);
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_spin();

  if(!level.player scripts\sp\maps\embassy\embassy_util.gsc::moving_forward()) {
    level.infil_heli thread scripts\common\anim::anim_loop_solo(level.player.rig, "infil_crash_crawl_a_idle", "stop_loop_player");
    level.infil_heli thread display_heli_hint("hint_crawl_forward", 3);
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_moving_forward();
    level.infil_heli notify("stop_loop_player");
  }

  level.heli_crash_timer = gettime();
  level.heli_crash_timeout = 6;
  level.infil_heli scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_crawl_a");

  if(!level.player scripts\sp\maps\embassy\embassy_util.gsc::moving_forward()) {
    level.infil_heli thread scripts\common\anim::anim_loop_solo(level.player.rig, "infil_crash_crawl_b_idle", "stop_loop_player");
    level notify("do_rope_nag");
    level.infil_heli thread display_heli_hint("hint_crawl_forward", 2);
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_moving_forward();
    level.infil_heli notify("stop_loop_player");
  }

  level.heli_crash_timer = gettime();
  level.infil_heli scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_crawl_b");

  if(!level.player scripts\sp\maps\embassy\embassy_util.gsc::moving_forward()) {
    level.infil_heli thread scripts\common\anim::anim_loop_solo(level.player.rig, "infil_crash_crawl_c_idle", "stop_loop_player");
    level notify("do_rope_nag");
    level.infil_heli thread display_heli_hint("hint_crawl_forward", 2);
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_moving_forward();
    level.infil_heli notify("stop_loop_player");
  }

  level.heli_crash_timer = gettime();
  level.infil_heli scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_crawl_c");

  if(!level.player jumpbuttonPressed() && !level.player useButtonPressed()) {
    level.infil_heli thread scripts\common\anim::anim_loop_solo(level.player.rig, "infil_crash_crawl_d_idle", "stop_loop_player");
    level notify("do_rope_nag");
    level.infil_heli thread display_heli_hint("hint_jump", 2);
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_player_jumping();
    level.infil_heli notify("stop_loop_player");
  }

  scripts\engine\utility::flag_set("crash_crawl_succeeded");
  scripts\engine\utility::flag_set("audio_outside_crowd_loop");
  level.infil_heli notify("stop_loop");
  level.pilot unlink();
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::halligan_stow();
}

grab_rope_nags() {
  level endon("crash_crawl_succeeded");
  level waittill("bailout_vo_start");
  wait(lookupsoundlength("dx_vom_pri_intro_flyin_170") / 1000);
  wait 1;
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("do_rope_nag", 3);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_intro_flyin_150");
  wait 1;
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("do_rope_nag", 3);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_intro_flyin_160");
}

heli_crawl_to_idle(var_0) {
  level.infil_heli endon("stop_loop");
  level.infil_heli scripts\common\anim::anim_single_solo(var_0, "infil_crash_crawl");
  level.infil_heli thread scripts\common\anim::anim_loop_solo(var_0, "infil_crash_crawl_idle", "stop_loop");
}

display_heli_hint(var_0, var_1) {
  self endon("stop_loop_player");
  wait(var_1);

  if(level.player getnormalizedmovement()[0] > 0.3)
    level.player notify("skip_jump");
  else
    scripts\engine\sp\utility::display_hint(var_0);
}

helicopter_spin_fail(var_0, var_1) {
  level endon("crash_crawl_succeeded");
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "infil_crash_crawl", "stop_loop");
  level.heli_crash_timeout = 10;
  level.heli_crash_timer = gettime();

  while(!scripts\engine\utility::flag("crash_crawl_succeeded") && heli_fail_time_within_limit())
    waitframe();

  if(!scripts\engine\utility::flag("crash_crawl_succeeded")) {
    thread scripts\sp\player_death::set_custom_death_quote(72);
    scripts\sp\utility::missionfailedwrapper();
  }
}

heli_fail_time_within_limit() {
  var_0 = scripts\engine\utility::time_has_passed(level.heli_crash_timer, level.heli_crash_timeout);
  var_1 = getdvarint("scr_emb_heli_crawl_fail", 1);
  return !var_0 && var_1 || !var_1;
}

helicopter_crawl_catchup() {
  scripts\engine\utility::flag_set("kill_crowd_shadows");
}

helicopter_crash_start() {
  level.og_zplanes = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 2 10000");
  level.crash_start_point = 1;
  setsaveddvar("LRTTMPMQOO", 0);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\engine\sp\utility::set_start_location("helicopter_start", [level.player, level.price]);
  heli_wreckage_setup();
  thread heli_pilot_setup();
  wait_variables_initialized();
  thread audio_crowd_angry_outside(1);
  thread heli_windy_price(0);
}

helicopter_crash_main() {
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("OLSKLTPPMR", 0.5);
  setsaveddvar("MQPQKNPQOK", 7);
  setsaveddvar("LQLSPQOPKM", 40);
  setsaveddvar("NQTLPTNSSO", 10);
  scripts\engine\sp\utility::autosave_by_name("helicopter_crash");
  scripts\engine\utility::exploder("rooftop_scene_vfx");
  level.infil_heli dontcastshadows();

  if(!istrue(level.crash_start_point)) {
    var_0 = level.infil_heli scripts\engine\utility::getanim("infil_crash_fall");
    var_1 = scripts\engine\utility::spawn_tag_origin();
    var_1.origin = getstartorigin(level.ap_infil_crash.origin, level.ap_infil_crash.angles, var_0);
    var_1.angles = getstartangles(level.ap_infil_crash.origin, level.ap_infil_crash.angles, var_0);
    level.ap_infil_crash linkTo(var_1);
    waitframe();
    var_1.origin = level.infil_heli.origin;
    var_1.angles = level.infil_heli.angles;
    waitframe();
    level.ap_infil_crash unlink(1);
    thread helicopter_crash_lerp_ap();
  } else
    level.scr_goaltime["infil_heli"]["infil_crash_fall"] = 0.0;

  thread helicopter_crash_pilot();
  thread helicopter_crash_fall(level.ap_infil_crash, level.infil_heli);
  thread helicopter_player_fall(level.ap_infil_crash);
  level.fast_rope thread helicopter_crash_fall_relative_to_world();
  level.price thread helicopter_crash_fall_relative_to_world();
  thread heli_player_damage_radius();
  thread price_hat_pickup();
  thread helicopter_fall_camera_control_locking();
  thread helicopter_crash_vfx();
  thread audio_crowd_cheer_at_end_of_infil_crash();
  thread reenable_dynents();
  thread heli_wreckage();
  level waittill("price_done");
}

helicopter_crash_pilot() {
  level.ap_infil_crash scripts\common\anim::anim_single_solo(level.pilot, "infil_crash_fall");
  level.pilot delete();
}

helicopter_crash_fall_relative_to_world() {
  if(self == level.fast_rope)
    level.infil_heli thread scripts\common\anim::anim_first_frame_solo(self, "infil_crash_fall_relative");

  level.infil_heli scripts\common\anim::anim_single_solo(self, "infil_crash_fall_relative");
  self dontinterpolate();
  self unlink(1);

  if(self == level.price) {
    level.price thread helicopter_crash_fall_price_gun();
    level.price detach("hat_hero_price_boonie_withStrap_wind");
    level.price setModel("body_hero_price_desert");
  }

  level.ap_infil_crash scripts\common\anim::anim_single_solo(self, "infil_crash_fall");

  if(self == level.price)
    level notify("price_done");
}

helicopter_crash_fall_price_gun() {
  scripts\engine\sp\utility::place_weapon_on(self.weapon, "none");
  self.dropweapon = 0;
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 scripts\common\utility::make_weapon_model(getweaponbasename(self.weapon), getweaponattachments(self.weapon), 0);
  var_0 scripts\engine\sp\utility::assign_animtree("price_crash_gun");
  level.ap_infil_crash scripts\common\anim::anim_single_solo(var_0, "infil_crash_fall");
  var_0 delete();
  self.dropweapon = 1;
  scripts\engine\sp\utility::place_weapon_on(self.weapon, "right");
}

helicopter_crash_lerp_ap() {
  wait 1.1;
  level.infil_heli dontinterpolate();
  level.price dontinterpolate();
  level.fast_rope dontinterpolate();
  level.ap_infil_crash.origin = level.ap_infil_crash.og_origin;
  level.ap_infil_crash.angles = level.ap_infil_crash.og_angles;
}

reenable_dynents() {
  wait 5;
  setsaveddvar("LRTTMPMQOO", 600);
}

helicopter_player_fall(var_0) {
  thread heli_player_prone();
  thread helicopter_player_fall_anim(var_0);
  level waittill("can_move");
  level notify("stop_damage_radius");
  thread scripts\sp\maps\embassy\embassy_util.gsc::flag_on_moving_forward("fall_impact_done");
  thread scripts\sp\maps\embassy\embassy_util.gsc::flag_on_crouch_pressed("fall_impact_done");
  thread scripts\sp\maps\embassy\embassy_util.gsc::flag_on_sprint_pressed("fall_impact_done");
  thread scripts\sp\maps\embassy\embassy_util.gsc::flag_on_jump_pressed("fall_impact_done");
  scripts\engine\utility::flag_wait("fall_impact_done");
  level notify("lock_view");
  var_0 scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_fall_go_prone");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\engine\utility::flag_set("player_up");
  level.player thread scripts\sp\player::player_movement_state("creep");
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(0.3, 0.05);
  wait 0.5;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(0.75, 2.5);
  level.player enableweapons();
  var_1 = scripts\sp\utility::make_weapon("iw8_pi_golf21");
  level.player giveweapon(var_1, 0, 0, 0, 0);
  level.player givemaxammo(var_1);
  level.player switchtoweapon(var_1);
  wait 2.5;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale_default(1);
  thread embassy_scale_speed_near_price();
  level.player allowsprint(1);
}

helicopter_player_fall_anim(var_0) {
  level.infil_heli scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_fall_relative");
  level.player.rig unlink(1);
  var_0 scripts\common\anim::anim_single_solo(level.player.rig, "infil_crash_fall");
  scripts\engine\utility::flag_set("fall_impact_done");
}

heli_player_prone() {
  level waittill("go_prone");
  level.player allowsprint(0);
}

helicopter_crash_fall(var_0, var_1) {
  level.player clearclienttriggeraudiozone(4.0);
  var_1 linkTo(var_0);
  var_0 scripts\common\anim::anim_single_solo(var_1, "infil_crash_fall");
  var_1 unlink();
  level notify("heli_crash_done");
  level waittill("fx_done");
  infil_heli_delete();
  heli_crash_debris_post();
}

helicopter_crash_vfx() {
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_rope();
  killfxontag(scripts\engine\utility::getfx("vfx_emb_infil_helismoke"), level.infil_heli, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_emb_infil_tailfire"), level.infil_heli, "tag_origin");
  level.infil_heli notify("stop_kicking_up_dust");
  scripts\engine\utility::exploder("ropetime");
  level waittill("player_lands");
  var_0 = getscriptablearray("roof_clutter_player", "targetname");

  foreach(var_2 in var_0)
  var_2 dodamage(20, level.player.origin);

  level.player modifybasefov(55, 0.25);
  scripts\engine\utility::exploder("roofland");
  thread scripts\sp\maps\embassy\embassy_util.gsc::heli_shake_stop();
  level.player playRumbleOnEntity("heavy_3s");
  screenshake(level.player.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
  level waittill("price_lands");
  level.player playRumbleOnEntity("light_3s");
  scripts\engine\utility::exploder("priceland");
  thread helicopter_crash_rack_focus();
  level waittill("heli_tail_hit");
  var_4 = getscriptablearray("roof_clutter_heli", "targetname");

  foreach(var_2 in var_4)
  var_2 dodamage(100, level.player.origin);

  scripts\engine\utility::exploder("tailhit");
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
  var_7 = scripts\engine\utility::getStructArray("heli_tail_hit_pos", "targetname");

  foreach(var_9 in var_7)
  radiusdamage(var_9.origin, 500, 100, 100);

  wait 0.2;
  heli_crash_debris_post_roof();
  level.player playRumbleOnEntity("heavy_2s");
  level waittill("heli_crash_done");
  scripts\engine\utility::exploder("heli_crash");
  scripts\engine\utility::exploder("heli_fire");
  scripts\engine\utility::exploder("hide_crowd_filler");
  scripts\engine\utility::exploder("heli_palm_fire");
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
  killfxontag(scripts\engine\utility::getfx("vfx_emb_infil_tailfire"), level.infil_heli, "tag_origin");
  level notify("fx_done");
}

helicopter_crash_rack_focus() {
  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(3.45, 42.5, 0.25, 0.5);
  level waittill("rack_to_helo");
  level.player setphysicaldepthoffield(1.75, 1800.0);
  level waittill("rack_to_price");
  level.player setphysicaldepthoffield(3.45, 42.5, 0.25, 0.5);
  level waittill("rack_to_zero");
  level.player setphysicaldepthoffield(22.0, 70.0, 0.5, 1.0);
  level.player disablephysicaldepthoffieldscripting();
}

price_hat_pickup() {
  level waittill("spawn_hat");
  var_0 = scripts\engine\sp\utility::spawn_anim_model("price_hat");
  level.ap_infil_crash scripts\common\anim::anim_single_solo(var_0, "infil_crash_hat_pickup");
  level.price attach(level.price.hatmodel);
  var_0 delete();
}

helicopter_fall_camera_control_locking() {
  level.player lerpviewangleclamp(0.3, 0, 0, 0, 0, 0, 0);
  wait 3.85;
  level.player lerpviewangleclamp(1, 0, 0, 30, 30, 30, 30);
  wait 3;
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  wait 2.5;
  level.player lerpviewangleclamp(1, 0, 0, 30, 30, 30, 30);
  level.player springcamenabled(0, 1, 1);
  level waittill("lock_view");
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  level.player springcamdisabled(0.5);
}

heli_player_damage_radius() {
  level endon("stop_damage_radius");

  for(;;) {
    physicsexplosionsphere(level.player.origin + anglestoleft(level.player.angles) * 1.0, 50, 50, 200);
    physicsexplosionsphere(level.price.origin, 50, 50, 200);
    wait 0.1;
  }
}

heli_wreckage() {
  foreach(var_1 in level.roof_wreckage)
  var_1 thread heli_wreckage_break();
}

heli_wreckage_break() {
  self endon("entitydeleted");
  level.ap_infil_crash scripts\common\anim::anim_single_solo(self, "infil_crash_fall");
  self delete();
}

helicopter_crash_catchup() {
  heli_crash_debris_post();
  heli_crash_debris_post_roof();
  scripts\engine\utility::exploder("heli_fire");
  scripts\engine\utility::exploder("heli_palm_fire");

  if(!scripts\sp\starts::is_after_start("infil_saferoom"))
    level.player modifybasefov(55, 0.01);
}

embassy_scale_speed_near_price() {
  var_0 = squared(150);

  while(!scripts\engine\utility::flag("bpg_scene_near_start")) {
    var_1 = scripts\engine\math::remap(distancesquared(level.player.origin, level.price.origin), 0, var_0, 0.1, 1.0);
    var_1 = clamp(var_1, 0.1, 1.0);
    level.player scripts\engine\sp\utility::blend_movespeedscale(var_1, 0.25);
    waitframe();
  }

  level.player scripts\engine\sp\utility::blend_movespeedscale_default(1.0);
}

embassy_roof_start() {
  level.og_zplanes = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 2 10000");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\engine\sp\utility::set_start_location("embassy_roof_start", [level.player, level.price]);
  scripts\engine\utility::flag_set("player_up");
  thread audio_crowd_angry_outside(1);
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21");
  level.player giveweapon(var_0, 0, 0, 0, 0);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_embassy_roof_start();
  level.player thread scripts\sp\player::player_movement_state("creep");
  thread embassy_scale_speed_near_price();
}

embassy_roof_main() {
  scripts\engine\sp\utility::autosave_by_name("embassy_roof");
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  level.price scripts\engine\sp\utility::name_show();

  if(!scripts\engine\utility::flag("near_roof_door")) {
    var_0 = ["dx_vom_pri_roof_crash_50", "dx_vom_pri_roof_crash_60", "dx_vom_pri_roof_crash_70", "dx_vom_pri_roof_crash_80"];
    level.price thread notetrack_nag(var_0, "near_roof_door");
    level.ap_infil_crash thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "roof_stair_idle", "loop_stop");
  }

  scripts\engine\utility::flag_wait("player_up");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  level.price.script_pushable = 0;
  level.price pushplayer(1);
  thread audio_office_alarm_loop_start();
  thread mus_rooftop_traverse();
  scripts\engine\utility::flag_wait("near_roof_door");
  level.ap_offices_chaos = scripts\engine\utility::getStruct("ap_offices_chaos", "targetname");
  offices_setup_door();
  level.ap_infil_crash notify("loop_stop");
  thread emb_roof_door_open();
  scripts\engine\utility::exploder("hole_dust");
  level.ap_infil_crash scripts\common\anim::anim_single_solo(level.price, "roof_stair_to_office");

  if(!scripts\engine\utility::flag("near_office_door")) {
    var_0 = ["dx_vom_pri_roof_stairwell_50", "dx_vom_pri_roof_stairwell_60", "dx_vom_pri_roof_stairwell_70"];
    level.price thread notetrack_nag(var_0, "near_office_door");
    level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "offices_idle", "loop_stop");
  }

  scripts\engine\utility::flag_wait("near_office_door");
  level.ap_offices_chaos notify("loop_stop");
}

mus_rooftop_traverse() {
  wait 0.2;
}

emb_roof_door_setup(var_0) {
  level.roof_door = getEnt("roof_door", "targetname");
  level.roof_door.clip = level.roof_door scripts\engine\utility::get_target_ent();
  level.roof_door.clip linkTo(level.roof_door);
  level.roof_door scripts\engine\sp\utility::assign_animtree("roof_door");
  level.roof_door.og_rot = level.roof_door.angles;

  if(var_0)
    level.ap_infil_crash scripts\common\anim::anim_first_frame_solo(level.roof_door, "roof_stair_to_office");
}

emb_roof_door_remove() {
  level.roof_door.clip unlink();
  level.roof_door.clip delete();
  level.roof_door delete();
  level.roof_door = undefined;
}

emb_roof_door_open() {
  level.ap_infil_crash scripts\common\anim::anim_single_solo(level.roof_door, "roof_stair_to_office");
  scripts\engine\utility::flag_wait("near_office_door");
  level.roof_door clearanim(level.roof_door scripts\engine\utility::getanim("roof_stair_to_office"), 0);
  level.roof_door rotateTo(level.roof_door.og_rot, 0.25, 0.01, 0.01);
  scripts\engine\utility::stop_exploder("rooftop_scene_vfx");
  scripts\engine\utility::flag_wait("passed_door_to_stairs");
  thread emb_roof_door_remove();
}

embassy_roof_catchup() {
  level.ap_offices_chaos = scripts\engine\utility::getStruct("ap_offices_chaos", "targetname");
  scripts\engine\utility::flag_set("near_office_door");

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_combat")) {
    level.price.script_pushable = 0;
    level.price pushplayer(1);
  }

  level.ap_infil_crash delete();
}

notetrack_nag(var_0, var_1) {
  level endon(var_1);
  var_2 = scripts\engine\sp\utility::create_deck(var_0, 0);

  for(;;) {
    level waittill("nag");

    if(scripts\sp\maps\embassy\embassy_util.gsc::player_moving_toward()) {
      continue;
    }
    scripts\engine\sp\utility::smart_dialogue(var_2 scripts\engine\sp\utility::deck_draw());

    if(var_2 scripts\engine\sp\utility::deck_is_empty())
      return;
  }
}

offices_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("offices_start", [level.player, level.price]);
  thread audio_crowd_angry_outside(1);
  thread audio_office_alarm_loop_start();
  level.player thread scripts\sp\player::player_movement_state("creep");
  thread embassy_scale_speed_near_price();
}

offices_main() {
  scripts\engine\sp\utility::autosave_by_name("offices");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  level.price scripts\common\utility::demeanor_override("casual_gun");
  thread gate_burning_cars();
  thread offices_fail_check();
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("office_card_reader");
  thread offices_door();
  thread offices_props();
  thread start_office_walla();
  thread offices_screens();
  scripts\engine\utility::exploder("stairwell_scene_vfx");
  var_0 = scripts\engine\sp\utility::spawn_targetname("office_chaos_keyguy");
  var_1 = scripts\engine\sp\utility::spawn_targetname("office_chaos_manager");
  var_2 = scripts\engine\sp\utility::spawn_targetname("office_chaos_idle_only_civ");
  var_3 = scripts\engine\sp\utility::array_spawn_targetname("office_chaos_civs");
  var_4 = scripts\engine\sp\utility::array_spawn_targetname("office_chaos_avoid_civs");
  level.ap_stairwell_door = scripts\engine\utility::getStruct("ap_stairwell_door", "targetname");
  thread offices_stairwell_door();
  var_0 thread offices_keyguy();
  var_1 thread offices_manager();
  var_2 thread offices_idle_only_civ();
  scripts\engine\utility::array_thread(var_3, ::offices_chaos_civs);

  foreach(var_7, var_6 in var_4)
  var_6 thread offices_avoid_civs(var_7 + 1);

  level.ap_offices_chaos scripts\common\anim::anim_single_solo(level.price, "offices_chaos");

  if(!scripts\engine\utility::flag("near_exit_to_stairs")) {
    level.ap_stairwell_door thread scripts\common\anim::anim_loop_solo(level.price, "stairwell_door_idle", "stop_loop_price");
    thread ap_stairwell_door_nag_vo();
    scripts\engine\utility::flag_wait("near_exit_to_stairs");
    level.ap_stairwell_door notify("stop_loop_price");
  }

  level notify("price_opening_door");
  level.ap_stairwell_door scripts\common\anim::anim_single_solo(level.price, "stairwell_door");
}

offices_fail_check() {
  level endon("office_door_closed");
  level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
  thread scripts\sp\player_death::set_custom_death_quote(13);
  scripts\sp\utility::missionfailedwrapper();
}

ap_stairwell_door_nag_vo() {
  level endon("near_exit_to_stairs");
  var_0 = 0;
  wait 13;

  while(!scripts\engine\utility::flag("near_exit_to_stairs")) {
    var_1 = ["dx_vom_pri_topfloor_office_280", "dx_vom_pri_topfloor_office_290", "dx_vom_pri_topfloor_office_300"];

    if(var_0 > 2)
      var_0 = 0;

    level.price scripts\engine\sp\utility::smart_dialogue(var_1[var_0]);
    var_0++;
    wait 13;
  }
}

offices_screens() {
  wait 1.0;
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_emb_screens_top_floor", 1, 1);
}

start_office_walla() {
  level.office_walla_1 = spawn("script_origin", (-6601, -2794, 624));
  level.office_walla_1 scripts\engine\sp\utility::sound_fade_in("embassy_office_int_busy_01", 1, 0.5, 1);
  level.office_walla_2 = spawn("script_origin", (-7330, -2549, 628));
  level.office_walla_2 scripts\engine\sp\utility::sound_fade_in("embassy_office_int_busy_02", 1, 0.5, 1);
}

stop_office_walla() {
  level.office_walla_1 scripts\engine\sp\utility::sound_fade_and_delete(2.0, 1);
  level.office_walla_2 scripts\engine\sp\utility::sound_fade_and_delete(2.0, 1);
}

offices_props() {
  var_0 = 33;
  level.office_props = [];

  for(var_1 = 1; var_1 <= var_0; var_1++) {
    level.office_props[var_1 - 1] = scripts\engine\sp\utility::spawn_anim_model("offices_prop_" + var_1);
    level.office_props[var_1 - 1] thread offices_individual_prop();
  }

  scripts\engine\utility::flag_wait("office_door_closed");

  foreach(var_3 in level.office_props)
  var_3 delete();

  level.office_props = undefined;
}

offices_individual_prop() {
  self endon("entitydeleted");
  self endon("death");

  if(self.animname == "offices_prop_29")
    wait(getanimlength(level.scr_anim["offices_prop_28"]["offices_chaos"]));

  if(self.animname == "offices_prop_17" || self.animname == "offices_prop_21") {
    level.ap_offices_chaos scripts\common\anim::anim_first_frame_solo(self, "offices_chaos");
    scripts\engine\utility::flag_wait("cue_exit_civs");
    self notify("stop_first_frame");
  } else if(self.animname == "offices_prop_30" || self.animname == "offices_prop_31") {
    level.ap_offices_chaos scripts\common\anim::anim_first_frame_solo(self, "offices_chaos_idle");
    wait 3.5;
    self notify("stop_first_frame");
  } else if(self.animname == "offices_prop_32") {
    level.ap_offices_chaos scripts\common\anim::anim_first_frame_solo(self, "offices_chaos_idle");
    wait 6.33;
    self notify("stop_first_frame");
  }

  if(isDefined(level.scr_anim[self.animname]["offices_chaos"])) {
    level.ap_offices_chaos scripts\common\anim::anim_first_frame_solo(self, "offices_chaos");
    level.ap_offices_chaos scripts\common\anim::anim_single_solo(self, "offices_chaos");
  }

  if(isDefined(level.scr_anim[self.animname]["offices_chaos_idle"]))
    level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_chaos_idle", "stop_loop_" + self.animname);

  if(self.animname == "offices_prop_18") {
    level waittill("key_guy_moving");
    self setanimrate(scripts\engine\utility::getanim("offices_chaos_idle")[0], 0.0);
    level waittill("key_guy_second_loop");
    self setanimrate(scripts\engine\utility::getanim("offices_chaos_idle")[0], 1.0);
    level.ap_offices_chaos notify("stop_loop_" + self.animname);
    level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_chaos_idle2", "stop_loop_" + self.animname);
  }
}

offices_idle_only_civ() {
  self.fakeactor_face_anim = 1;
  self.animname = "office_idle_only_civ";
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle_2");
  scripts\engine\utility::flag_wait("office_door_closed");
  self delete();
}

offices_setup_door() {
  level.offices_door = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("office_entrance_door");
  level.offices_door scripts\engine\sp\utility::assign_animtree("offices_door");
  level.ap_offices_chaos thread scripts\common\anim::anim_first_frame_solo(level.offices_door, "offices_chaos");
}

offices_door() {
  level.ap_offices_chaos scripts\common\anim::anim_single_solo(level.offices_door, "offices_chaos");
  level.offices_door scripts\sp\maps\embassy\embassy_util.gsc::connect_office_door_paths();
}

offices_chaos_civs() {
  self.fakeactor_face_anim = 1;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "office_civ_phone_lady"))
    self.animname = "office_civ_phone_lady";
  else {
    if(!isDefined(level.offices_civ_count))
      level.offices_civ_count = 1;
    else
      level.offices_civ_count = level.offices_civ_count + 1;

    self.animname = "office_civ_" + level.offices_civ_count;
  }

  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();

  if(isDefined(level.scr_anim[self.animname]["offices_chaos"]))
    level.ap_offices_chaos scripts\common\anim::anim_single_solo(self, "offices_chaos");

  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle");
  scripts\engine\utility::flag_wait("office_door_closed");
  self delete();
}

offices_manager() {
  self.fakeactor_face_anim = 1;
  self.animname = "office_manager";
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  level.ap_offices_chaos scripts\common\anim::anim_single_solo(self, "offices_chaos");
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle");
  scripts\engine\utility::flag_wait("office_door_closed");
  self delete();
}

offices_avoid_civs(var_0) {
  self.fakeactor_face_anim = 1;
  self.animname = "office_avoid_civ_" + var_0;
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle", "stop_avoid_civs");
  scripts\engine\utility::flag_wait("cue_exit_civs");
  level.ap_offices_chaos notify("stop_avoid_civs");
  level.ap_offices_chaos scripts\common\anim::anim_single_solo(self, "offices_chaos");
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle_2");

  if(self.animname == "office_avoid_civ_1") {
    var_1 = scripts\engine\sp\utility::spawn_anim_model("offices_prop_avoid");
    level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(var_1, "offices_chaos_idle", "entitydeleted");
  }

  scripts\engine\utility::flag_wait("office_door_closed");
  self delete();
}

offices_keyguy() {
  self.fakeactor_face_anim = 1;
  self.animname = "office_civ_key_guy";
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle", "keyguy_stop_loop");
  scripts\engine\utility::flag_wait("cue_exit_civs");
  level notify("key_guy_moving");
  level.ap_offices_chaos notify("keyguy_stop_loop");
  level.ap_offices_chaos scripts\common\anim::anim_single_solo(self, "offices_key");
  level notify("key_guy_second_loop");
  level.ap_offices_chaos thread scripts\common\anim::anim_loop_solo(self, "offices_idle_2", "keyguy_stop_loop");
  scripts\engine\utility::flag_wait("office_door_closed");
  self delete();
}

offices_stairwell_door() {
  var_0 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("stairwell_door");
  var_0 scripts\engine\sp\utility::assign_animtree("stairwell_door");
  var_0.og_angles = var_0.angles;
  level.ap_stairwell_door scripts\common\anim::anim_first_frame_solo(var_0, "stairwell_door");
  level waittill("price_opening_door");
  level.ap_stairwell_door thread scripts\common\anim::anim_single_solo(var_0, "stairwell_door");
  scripts\engine\utility::flag_wait("passed_door_to_stairs");
  var_0 stopanimScripted();
  var_0 clearanim(var_0 scripts\engine\utility::getanim("stairwell_door"), 0.01);
  var_0 rotateTo(var_0.og_angles, 0.25);
  scripts\engine\utility::flag_set("office_door_closed");
  thread stop_office_walla();
  level notify("stop_upstairs_office_alarm_loops");
  scripts\engine\sp\utility::autosave_by_name("stairwell");
  thread bpg_md_screens();
}

gate_burning_cars() {
  scripts\engine\utility::exploder("black_smoke");
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("gate_dst_cars", "targetname");

  foreach(var_3 in var_1)
  var_0[var_0.size] = scripts\engine\sp\utility::spawn_anim_model("gate_car", var_3.origin, var_3.angles);

  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  scripts\engine\utility::stop_exploder("black_smoke");

  foreach(var_6 in var_0)
  var_6 delete();
}

offices_catchup() {
  scripts\engine\utility::flag_set("near_exit_to_stairs");

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_scene")) {
    scripts\engine\utility::exploder("stairwell_scene_vfx");
    thread gate_burning_cars();
  }

  if(!scripts\sp\starts::is_after_start("infil_bp_glass_combat"))
    thread bpg_md_screens();
}

stairwell_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("stairwell_start", [level.player, level.price]);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer();
  thread audio_crowd_angry_outside(1);
  scripts\engine\utility::flag_set("office_door_closed");
  thread embassy_scale_speed_near_price();
  level.player thread scripts\sp\player::player_movement_state("creep");
}

stairwell_main() {
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("stairway_card_reader");
  thread offices_stairwell_door_vo();
  level.aq_enforcer show();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.price scripts\common\utility::demeanor_override("cqb");
  thread stairwell_second_window();
  thread stairwell_molotov();
  thread sfx_flag_burning();
  thread stairwell_price();
  scripts\engine\utility::flag_wait("door_bust");
}

stairwell_price() {
  var_0 = scripts\engine\utility::getStruct("ap_stairs_down_b", "targetname");
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::anim_reach_solo_skip_offscreen(level.price, "stairwell_b_down", undefined, "stair_b");

  if(!scripts\engine\utility::flag("stair_c")) {
    if(scripts\engine\utility::flag("stair_b"))
      var_0 scripts\common\anim::anim_single_solo(level.price, "stairwell_b_down");
    else {
      var_0 scripts\common\anim::anim_single_solo(level.price, "stairwell_b_intro");
      var_0 thread scripts\common\anim::anim_loop_solo(level.price, "stairwell_b_idle", "stop_loop");
      scripts\engine\utility::flag_wait("stair_b");
      var_0 notify("stop_loop");
      var_0 scripts\common\anim::anim_single_solo(level.price, "stairwell_b_outro");
    }
  }

  var_1 = scripts\engine\utility::getStruct("ap_stairs_down_c", "targetname");
  var_1 scripts\sp\maps\embassy\embassy_util.gsc::anim_reach_solo_skip_offscreen(level.price, "stairwell_c_down", undefined, "stair_c");

  if(!scripts\engine\utility::flag("door_bust")) {
    if(scripts\engine\utility::flag("stair_c"))
      var_1 scripts\common\anim::anim_single_solo(level.price, "stairwell_c_down");
    else {
      var_1 scripts\common\anim::anim_single_solo(level.price, "stairwell_c_intro");
      var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stairwell_c_idle", "stop_loop");
      scripts\engine\utility::flag_wait("stair_c");
      var_1 notify("stop_loop");
      var_1 scripts\common\anim::anim_single_solo(level.price, "stairwell_c_outro");
    }
  }

  scripts\engine\utility::flag_set("price_passed_stair_c");
}

sfx_flag_burning() {
  var_0 = spawn("script_origin", (-8106, -2080, 296));
  var_0 scripts\engine\sp\utility::sound_fade_in("emt_fire_flag_lp", 1, 3, 1);
  level waittill("stop_stairwell_loops");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
}

offices_stairwell_door_vo() {
  thread mus_beadvised();
  level waittill("car_explosion_finished");
  wait 4.5;
  var_0 = gettime();
  level thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_roof_stairwell_10");
  scripts\engine\utility::flag_wait("door_bust");
  var_1 = lookupsoundlength("dx_vom_alx_roof_stairwell_10") - (gettime() - var_0);
  wait(max(var_1 / 1000, 1.8));
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_roof_stairwell_20", 1);
  wait 0.85;
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_roof_stairwell_22");
}

mus_beadvised() {
  wait 0.5;
}

stairwell_molotov() {
  scripts\engine\utility::flag_wait("stair_b");
  thread scripts\engine\utility::play_sound_in_space("embassy_stairwell1_car_explode_lr", (-6374, -2015, 126));
  scripts\engine\utility::exploder("landing_car_explode");
  var_0 = getscriptablearray("veh_emb_stairwell_expl", "targetname")[0];
  var_0 setscriptablepartstate("rootModelManager", "dead");
  var_1 = scripts\engine\utility::getStruct("car_explosion", "targetname");
  var_1.angles = (0, 0, 0);
  createnavbadplacebybounds(var_1.origin, (70, 100, 70), var_1.angles);

  if(isDefined(level.gate_overrunners_marine)) {
    foreach(var_3 in level.gate_overrunners_marine) {
      if(isDefined(var_3) && isalive(var_3)) {
        if(distance2dsquared(var_1.origin, var_3.origin) < squared(150)) {
          if(istrue(var_3.magic_bullet_shield))
            var_3 scripts\common\ai::stop_magic_bullet_shield();

          var_3 kill(var_1.origin, level.aq_enforcer, level.aq_enforcer, "MOD_EXPLOSIVE");
        }
      }
    }
  }

  if(isDefined(level.gate_overrunners_aq)) {
    foreach(var_6 in level.gate_overrunners_aq) {
      if(isDefined(var_6) && isalive(var_6)) {
        if(distance2dsquared(var_1.origin, var_6.origin) < squared(150)) {
          if(istrue(var_6.magic_bullet_shield))
            var_6 scripts\common\ai::stop_magic_bullet_shield();

          var_6 kill(var_1.origin, level.price, level.price, "MOD_EXPLOSIVE");
        }
      }
    }
  }

  level notify("car_explosion_finished");
}

stairwell_second_window() {
  var_0 = scripts\engine\utility::getStruct("ap_stairwell_second_window", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("stair_car");
  var_1 attach("veh8_civ_lnd_skilo_lights", "tag_body_animate", 1);
  var_2 = scripts\engine\sp\utility::spawn_targetname("stairwell_second_window_civ");
  var_2.animname = "civ";
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "stairwell_second_window");
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "stairwell_second_window");
  scripts\engine\utility::flag_wait("office_door_closed");
  scripts\engine\utility::flag_wait("stair_b");
  playmayhem("vfx_mayh_embassy_flag_burn_right");
  scripts\engine\utility::exploder("flag_fire");
  var_3 = scripts\engine\sp\utility::spawn_targetname("stairwell_second_window_aq");
  var_3.animname = "aq";
  var_3 scripts\sp\fakeactor::set_do_arrivals(0);
  var_3 scripts\sp\fakeactor::take_control();
  var_0 scripts\common\anim::anim_first_frame_solo(var_3, "stairwell_second_window");
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_flag([var_3, var_2, var_1], "door_bust");
  thread audio_start_stairwell_car_scene();
  scripts\engine\utility::delaythread(6.15, scripts\engine\utility::exploder, "stairwell_bloodpool");
  thread stairwell_runners("stairwell_runner");
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "stairwell_second_window");
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "stairwell_second_window");
  var_0 scripts\common\anim::anim_single_solo(var_3, "stairwell_second_window");
  var_3 scripts\sp\fakeactor::release_control();
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  killmayhem("vfx_mayh_embassy_flag_burn_right");

  foreach(var_5 in [var_2, var_1])
  var_5 delete();
}

audio_start_stairwell_car_scene() {
  level.stairwell_crowd_car_sound = spawn("script_origin", (-7939, -2080, 163));
  level.stairwell_crowd_car_sound thread scripts\engine\sp\utility::sound_fade_in("embassy_stairwell2_auto_scene_lp", 1.0, 2.0, 1);
  level thread scripts\engine\utility::play_sound_in_space("embassy_stairwell2_auto_scene_01", (-7929, -2090, 150));
  level waittill("stop_stairwell_loops");
  level.stairwell_crowd_car_sound thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
}

stairwell_runners(var_0) {
  var_1 = getspawnerarray(var_0);

  foreach(var_3 in var_1)
  var_3 thread stairwell_runner_respawner();
}

stairwell_runner_respawner() {
  var_0 = undefined;

  while(!scripts\engine\utility::flag("md_close_door")) {
    self.count = 1;
    var_0 = scripts\engine\sp\utility::spawn_ai();
    var_0.ignoreme = 1;
    var_0 scripts\sp\fakeactor::set_do_arrivals(0);
    var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(1000);

    if(!scripts\engine\utility::flag("md_close_door")) {
      var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
      wait(randomfloatrange(0.5, 1.0));
    }
  }

  if(isDefined(var_0) && isalive(var_0))
    var_0 delete();
}

stairwell_catchup() {
  scripts\engine\utility::flag_set("office_door_closed");

  if(!scripts\sp\starts::is_after_start("infil_truck_office"))
    scripts\engine\utility::exploder("landing_car_explode");

  scripts\engine\utility::flag_set("stair_b");
  killmayhem("vfx_mayh_embassy_flag_burn_right");
}

bp_glass_metal_detectors_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("bpg_metal_detectors_start", [level.player, level.price]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer();
  level.price scripts\common\utility::demeanor_override("cqb");
  thread audio_crowd_angry_outside(1);
  scripts\engine\utility::flag_set("price_passed_stair_c");
  level.player thread scripts\sp\player::player_movement_state("creep");
  thread embassy_scale_speed_near_price();
}

bp_glass_metal_detectors_main() {
  playFX(scripts\engine\utility::getfx("vfx_embassy_office_gas"), (-6203.95, -2502.72, 34), anglesToForward((0, 90, 0)));
  level.ap_bpg_scene = scripts\engine\utility::getStruct("ap_bpg_scene", "targetname");
  var_0 = scripts\engine\utility::getStruct("ap_stairs_down_d", "targetname");
  thread bpg_md_aq();
  thread bpg_md_door(var_0);
  var_1 = getspawnerarray("bpg_md_door_bust");
  scripts\engine\sp\utility::array_spawn_function(var_1, ::bpg_md_door_civ, var_0);
  scripts\engine\sp\utility::array_spawn(var_1);
  var_2 = getspawnerarray("bpg_md_cowering");
  scripts\engine\sp\utility::array_spawn_function(var_2, ::bpg_md_cowering_civ);
  scripts\engine\sp\utility::array_spawn(var_2);
  scripts\engine\utility::flag_wait("price_passed_stair_c");
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "stairwell_d_break_door");
  scripts\engine\utility::flag_wait("door_bust");
  thread audio_aq_in_other_room_banging();
  thread audio_bpg_entrance_alarm_loop_start();
  scripts\engine\sp\utility::autosave_by_name("bpg_metal_detectors");
  scripts\engine\utility::flag_set("price_busting_through");
  level notify("card_reader_swap");
  var_0 scripts\common\anim::anim_single_solo(level.price, "stairwell_d_break_door");
  thread bpg_md_price();
  scripts\engine\utility::flag_wait("bpg_scene_preload");
  scripts\engine\sp\utility::transient_unload("embassy_streets_field_tr");
  thread bpg_scene_pre_vo();
}

audio_aq_in_other_room_banging() {
  var_0 = (-6544, -2691, 91);
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("scn_embassy_aq_banging_behind_door_lp");
  level waittill("audio_stop_banging");
  wait 0.8;
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

bpg_md_door(var_0) {
  var_1 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("md_stairwell_door");
  var_1 scripts\engine\sp\utility::assign_animtree("lower_stairwell_door");
  var_1.og_angles = var_1.angles;
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "stairwell_d_break_door");
  scripts\engine\utility::flag_wait("price_busting_through");
  var_0 scripts\common\anim::anim_single_solo(var_1, "stairwell_d_break_door");
  wait 0.2;
  scripts\engine\utility::flag_wait("md_close_door");
  level notify("stop_stairwell_loops");
  var_1 clearanim(var_1 scripts\engine\utility::getanim("stairwell_d_break_door"), 0);
  var_1 rotateTo(var_1.og_angles, 0.25, 0.01, 0.01);
}

bpg_md_screens() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_emb_screens_bottom_floor", 1, 1);
}

bpg_md_door_civ(var_0) {
  self.fakeactor_face_anim = 1;
  self.animname = self.script_animname;
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "stairwell_d_break_door");
  scripts\engine\utility::flag_wait("price_busting_through");
  var_0 scripts\common\anim::anim_single_solo(self, "stairwell_d_break_door");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "stairwell_d_break_door_idle");
  scripts\engine\utility::flag_wait("bpg_scene_clear_exit_door");
  self delete();
}

bpg_md_cowering_civ() {
  self.fakeactor_face_anim = 1;
  self.animname = "civ";
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  thread scripts\common\anim::anim_loop_solo(self, scripts\sp\maps\embassy\embassy_util.gsc::get_civ_cower_anim());
  scripts\engine\utility::flag_wait("bpg_scene_clear_exit_door");
  self delete();
}

bpg_md_aq() {
  level.ap_bpg_md = scripts\engine\utility::getStruct("ap_bpg_md", "targetname");
  thread bpg_md_first_wave_objects();
  scripts\engine\utility::flag_wait("door_bust");
  thread stairwell_runners("stairwell_runner_lower");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer_entourage();
  level.ap_bpg_md.stack_up_count = 0;
  thread scripts\engine\utility::play_sound_in_space("embassy_guys_rush_front_door", (-7021, -2075, 92));
  level.aq_enforcer thread scripts\engine\sp\utility::place_weapon_on(level.aq_enforcer.sidearm, "left");
  level.aq_enforcer thread bpg_md_aq_stack_up_at_door();
  scripts\engine\utility::array_thread(level.aq_enforcer_entourage, ::bpg_md_aq_stack_up_at_door);
  var_0 = 1 + level.aq_enforcer_entourage.size;

  while(level.ap_bpg_md.stack_up_count < var_0)
    waitframe();

  scripts\engine\utility::flag_wait("price_busting_through");
  level notify("aq_busting_through");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("security");

  foreach(var_4, var_3 in var_1) {
    var_3 scripts\engine\sp\utility::clear_deathanim();
    var_3.skipdeathanim = 1;
    var_3.a.nodeath = 1;
    var_3.noragdoll = 1;
    var_3.animname = "security_" + (var_4 + 1);
  }

  level.aq_enforcer thread bpg_md_aq_first_wave(0);
  scripts\engine\utility::array_thread(level.aq_enforcer_entourage, ::bpg_md_aq_first_wave, 0);
  scripts\engine\utility::array_thread(var_1, ::bpg_md_aq_first_wave, 1);
  scripts\engine\utility::delaythread(1.5, ::bpg_md_one_off_table);
}

bpg_md_aq_stack_up_at_door() {
  level.ap_bpg_md scripts\common\anim::anim_single_solo(self, "bpg_md_door_enter");
  level.ap_bpg_md thread scripts\common\anim::anim_loop_solo(self, "bpg_md_door_idle", "stop_loop" + self.animname);
  level.ap_bpg_md.stack_up_count++;
}

bpg_md_aq_first_wave(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(!var_0)
    level endon("bpg_scene_preload");

  level.ap_bpg_md notify("stop_loop" + self.animname);
  level.ap_bpg_md scripts\common\anim::anim_single_solo(self, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_last_frame_solo(self, "bpg_md_first_wave");
}

bpg_md_first_wave_objects() {
  level.bpg_md_table = getEnt("md_table", "targetname");
  level.bpg_md_table scripts\engine\sp\utility::assign_animtree("md_table");
  var_0 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("md_entrance_door_right");
  var_0 scripts\engine\sp\utility::assign_animtree("md_door_2");
  var_1 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("md_entrance_door_left");
  var_1 scripts\engine\sp\utility::assign_animtree("md_door_1");
  var_2 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("md_exit_door_right");
  var_2 scripts\engine\sp\utility::assign_animtree("md_door_3");
  var_3 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("md_exit_door_left");
  var_3 scripts\engine\sp\utility::assign_animtree("md_door_4");
  var_4 = getEnt("md_office_chair", "targetname");
  var_4 scripts\engine\sp\utility::assign_animtree("md_office_chair");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(level.bpg_md_table, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(var_0, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(var_1, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(var_2, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(var_3, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_first_frame_solo(var_4, "bpg_md_first_wave");
  level waittill("aq_busting_through");
  var_0 thread bpg_md_aq_first_wave(1);
  var_1 thread bpg_md_aq_first_wave(1);
  var_2 thread bpg_md_aq_first_wave(1);
  var_3 thread bpg_md_aq_first_wave(1);
  var_4 thread bpg_md_aq_first_wave(1);
  wait 1.5;
  thread scripts\engine\utility::play_sound_in_space("embassy_guys_break_into_lobby", (-6933, -2554, 92));
  setmusicstate("mx_embassy_lobby_invade");
  var_1 scripts\sp\maps\embassy\embassy_util.gsc::connect_office_door_paths();
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::connect_office_door_paths();
}

bpg_md_price() {
  level endon("bpg_scene_near_start");
  level.price scripts\common\ai::disable_arrivals();
  var_0 = scripts\engine\utility::getStruct("bpg_scene_price_entrance_lead_in", "targetname");
  var_1 = vectorNormalize(var_0.origin - level.price.origin);
  var_2 = vectorNormalize(level.player.origin - level.price.origin);
  level.price.og_turnrate = level.price.turnrate;

  if(vectordot(var_1, var_2) > 0) {
    level.price scripts\common\utility::clear_demeanor_override();
    level.price scripts\engine\utility::set_movement_speed(240);
    level.price.turnrate = 1.0;
  } else
    level.price.turnrate = 0.1;

  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_targetname_helper(var_0);
  level.price scripts\common\ai::enable_arrivals();
  level.price.turnrate = level.price.og_turnrate;
  level.price.og_turnrate = undefined;
  level.ap_bpg_scene scripts\sp\maps\embassy\embassy_util.gsc::anim_reach_solo_skip_offscreen(level.price, "bpg_scene_entrance", undefined, undefined, 0);
  level.price scripts\common\utility::clear_movement_speed();
  level.price scripts\common\utility::demeanor_override("cqb");
  thread bpg_md_nag();
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.price, "bpg_scene_entrance");
  level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "bpg_scene_entrance_idle", "stop_loop_price");
}

bpg_scene_pre_vo() {
  var_0 = scripts\engine\utility::getStruct("ap_bpg_scene", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_2 = spawn("script_origin", var_0.origin);
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level waittill("bpg_scene_enforcer_done");
  var_1 delete();
  var_2 delete();
}

bpg_md_nag() {
  level endon("bpg_scene_near_start");
  childthread forward_nag_notify();
  level.price waittill("do_nag");

  if(!scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.price.origin, level.player.origin, 300)) {
    var_0 = ["dx_vom_pri_entrance_overrun_100", "dx_vom_pri_entrance_overrun_110", "dx_vom_pri_entrance_overrun_120"];
    level.price childthread scripts\sp\maps\embassy\embassy_util.gsc::nagtill("near_price", var_0, "do_nag");
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_near(level.price, 300);
    level notify("near_price");
    level.price waittill("do_nag");
  }

  var_0 = ["dx_vom_pri_entrance_overrun_140", "dx_vom_pri_entrance_overrun_150", "dx_vom_pri_entrance_overrun_160"];
  level.price childthread scripts\sp\maps\embassy\embassy_util.gsc::nagtill("bpg_scene_near_start", var_0, "do_nag");
}

forward_nag_notify() {
  for(;;) {
    level.ap_bpg_scene waittill("do_nag");
    wait 1.0;
    level.price notify("do_nag");
  }
}

bpg_md_one_off_table() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("aq_one_off_table");
  var_0.animname = "aq_one_off_table";
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::make_ai_story_only();
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  level.ap_bpg_md scripts\sp\anim::anim_reach_solo(var_0, "bpg_md_first_wave");
  level.ap_bpg_md thread scripts\common\anim::anim_single_solo(level.bpg_md_table, "bpg_md_first_wave");
  level.ap_bpg_md scripts\common\anim::anim_single_solo(var_0, "bpg_md_first_wave");
  var_0 delete();
  scripts\engine\utility::flag_wait("bpg_scene_clear_exit_door");
  level.bpg_md_table delete();
  level.bpg_md_table = undefined;
}

bp_glass_metal_detectors_catchup() {
  scripts\engine\utility::flag_set("md_close_door");
}

civ_exit_door_store_enterers(var_0) {
  var_0.trigger = getEnt("truck_office_near_civilian_exit_door", "targetname");

  while(!scripts\engine\utility::flag("reached_basement")) {
    var_0.trigger waittill("trigger", var_1);
    var_0.civs[var_0.civs.size] = var_1;
    var_0 notify("civ_entered");
  }
}

handle_civ_exit_door() {
  var_0 = getEnt("door_civilian_exit", "targetname");
  var_0.civs = [];
  var_0.closed_angles = var_0.angles;
  var_0.open_angles = var_0.angles + (0, 120, 0);
  var_0.open_time = 0.5;
  var_0.close_time = 0.25;
  var_0.player_clip = getEnt("civ_exit_door_col", "targetname");
  var_0.player_clip.closed = var_0.player_clip.origin;
  var_0.player_clip.open = var_0.player_clip localtoworldcoords((64, 0, 0));
  thread civ_exit_door_store_enterers(var_0);

  while(!scripts\engine\utility::flag("reached_basement")) {
    while(var_0.civs.size == 0)
      wait 0.1;

    var_0.player_clip moveTo(var_0.player_clip.open, var_0.open_time, 0.1, 0.1);
    var_0 rotateTo(var_0.open_angles, var_0.open_time);
    wait(var_0.open_time);
    var_1 = 1;

    while(var_1) {
      foreach(var_3 in var_0.civs) {
        if(isDefined(var_3) && isalive(var_3)) {
          var_1 = var_3 istouching(var_0.trigger);

          if(var_1) {
            break;
          }
        }
      }

      wait 0.1;
    }

    var_0.civs = [];
    var_0.player_clip moveTo(var_0.player_clip.closed, var_0.close_time, 0.1, 0.1);
    var_0 rotateTo(var_0.closed_angles, var_0.close_time);
    wait(var_0.close_time);
  }
}

bp_glass_scene_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("bpg_scene_start", [level.player, level.price]);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_aq_enforcer_entourage();
  level.ap_bpg_scene = scripts\engine\utility::getStruct("ap_bpg_scene", "targetname");
  level.price scripts\common\utility::demeanor_override("cqb");
  level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "bpg_scene_entrance_idle", "stop_loop_price");
  thread audio_crowd_angry_outside(1);
  thread audio_bpg_entrance_alarm_loop_start();
  thread audio_aq_in_other_room_banging();
  level.player thread scripts\sp\player::player_movement_state("creep");
  playFX(scripts\engine\utility::getfx("vfx_embassy_office_gas"), (-6203.95, -2502.72, 34), anglesToForward((0, 90, 0)));
}

bp_glass_scene_main() {
  scripts\engine\sp\utility::autosave_by_name("bpg_scene");
  level.aq_enforcer thread scripts\engine\sp\utility::place_weapon_on(level.aq_enforcer.primaryweapon, "left");
  level.aq_enforcer thread scripts\engine\sp\utility::place_weapon_on(level.aq_enforcer.sidearm, "right");
  level.ap_bpg_scene.door_1 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("bpg_scene_sliding_door_l");
  level.ap_bpg_scene.door_1 scripts\engine\sp\utility::assign_animtree("safety_door");
  level.ap_bpg_scene.door_1.animname = "safety_door_1";
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(level.ap_bpg_scene.door_1, "bpg_scene_door_success");
  level.ap_bpg_scene.door_2 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("bpg_scene_sliding_door_r");
  level.ap_bpg_scene.door_2 scripts\engine\sp\utility::assign_animtree("safety_door");
  level.ap_bpg_scene.door_2.animname = "safety_door_2";
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(level.ap_bpg_scene.door_2, "bpg_scene_door_success");
  level.ap_bpg_scene.door_latch = getEnt("bpg_scene_door_latch", "targetname");
  level.ap_bpg_scene.door_latch scripts\engine\sp\utility::assign_animtree("bpg_scene_door_latch");
  level.ap_bpg_scene scripts\common\anim::anim_first_frame_solo(level.ap_bpg_scene.door_latch, "bpg_scene_door_enter");
  level.ap_bpg_scene.civs = [];
  level.wall_truck_civ_hiding_spots = scripts\engine\utility::getStructArray("civilian_exit", "targetname");
  thread handle_civ_exit_door();
  bpg_scene_marine_spawn();
  level.bpg_scene_marine thread bpg_scene_marine();
  var_0 = getspawner("bpg_scene_mother", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  var_1 thread bpg_scene_mother();
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("enforcer_card_reader");
  var_2 = getspawner("bpg_scene_key_civ", "targetname");
  var_2 scripts\engine\sp\utility::add_spawn_function(::bpg_scene_key_civ);
  var_3 = var_2 scripts\engine\sp\utility::spawn_ai();
  var_4 = getspawnerarray("bpg_scene_civs_otherside");
  scripts\engine\sp\utility::array_spawn_function(var_4, ::bpg_scene_civ_otherside);
  var_5 = scripts\engine\sp\utility::array_spawn(var_4);
  var_6 = getspawnerarray("bpg_scene_civs");
  scripts\engine\sp\utility::array_spawn_function(var_6, ::bpg_scene_civ_escape);
  var_7 = scripts\engine\sp\utility::array_spawn(var_6);
  var_7[var_7.size] = var_3;
  var_8 = getEntArray("bpg_scene_chair", "targetname");
  var_8[0] thread bpg_scene_chair_1();
  var_8[1] thread bpg_scene_chair_2();
  var_8[2] thread bpg_scene_chair_3();
  thread bpg_scene_handle_exit_doors();
  var_9 = getspawnerarray("bpg_scene_basher");
  scripts\engine\sp\utility::array_spawn_function(var_9, ::bpg_scene_aq_basher);
  var_10 = scripts\engine\sp\utility::array_spawn(var_9);
  thread bpg_scene_aq_basher_crowbar();
  level.aq_enforcer thread bpg_scene_enforcer();
  level.aq_enforcer_entourage[7] delete();
  level.aq_enforcer_entourage[6] delete();
  level.aq_enforcer_entourage = scripts\engine\utility::array_remove_index(level.aq_enforcer_entourage, 7, 1);
  level.aq_enforcer_entourage = scripts\engine\utility::array_remove_index(level.aq_enforcer_entourage, 6, 1);
  scripts\engine\utility::array_thread(level.aq_enforcer_entourage, ::bpg_scene_aq);
  var_11 = scripts\engine\utility::array_combine([level.aq_enforcer, var_1, level.bpg_scene_marine], level.aq_enforcer_entourage, var_10, var_5, var_7);
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_and_visible_flag(var_11, "bpg_scene_near_start");
  scripts\engine\utility::flag_set("bpg_scene_near_start");
  level.price scripts\common\ai::enable_arrivals();
  thread mus_enforcer_door();
  level.price thread bpg_scene_price();
  wait 6.5;
  level notify("door_prompt_displayed");
  var_12 = scripts\engine\utility::getStruct("int_bpg_scene_door", "targetname");
  var_12 thread bpg_scene_check_door_interact();
  level scripts\engine\utility::waittill_any("bpg_scene_player_tried_door", "kid_killed");
  scripts\engine\utility::flag_set("bpg_scene_door_inaccessible");
  var_12 scripts\sp\player\cursor_hint::remove_cursor_hint();
  level.ap_bpg_scene notify("stop_loop_price");

  if(scripts\engine\utility::flag("bpg_scene_player_tried_door"))
    bpg_scene_player_interact();

  scripts\engine\utility::flag_wait("bpg_scene_enforcer_done");
  level.aq_enforcer setentitysoundcontext("atmosphere", "", 0.1);

  while(!(scripts\engine\utility::flag("bpg_scene_complete") && scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(level.price.origin)) && !scripts\engine\utility::flag("bpg_scene_complete_exited"))
    waitframe();

  scripts\engine\utility::flag_set("bpg_scene_price_exiting");
  level.ap_bpg_scene notify("stop_loop_price");
}

mus_enforcer_door() {
  setmusicstate("mx_embassy_enforcer_dooropen");
}

bpg_scene_player_interact() {
  level.ap_bpg_scene scripts\common\anim::anim_first_frame_solo(level.player.rig, "bpg_scene_door_enter");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.3, 0, 0, 0, 0);
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.door_latch, "bpg_scene_door_enter");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.player.rig, "bpg_scene_door_enter");
  bpg_scene_player_interact_struggle();

  if(scripts\engine\utility::flag("bpg_scene_interact_success")) {
    foreach(var_1 in level.aq_enforcer_entourage) {
      var_2 = var_1 scripts\engine\utility::getanim("bpg_scene");
      var_1 setanimrate(var_2, 0.0);
    }

    foreach(var_5 in level.ap_bpg_scene.civs) {
      var_2 = var_5 scripts\engine\utility::getanim("bpg_scene");
      var_5 setanimrate(var_2, 0.0);

      if(var_5.animname == "bpg_scene_civ_mother" && var_5 iswaitingonsound())
        var_5 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_cf2_reception_bulletproof_33");
    }

    level.price setanimrate(level.price scripts\engine\utility::getanim("bpg_scene"), 0.0);
    level.price hide();
    thread bpg_scene_player_interact_aq_enforcer_entourage();
    thread bpg_scene_player_interact_death();
    level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.door_latch, "bpg_scene_door_success");
    level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.door_1, "bpg_scene_door_success");
    level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.door_2, "bpg_scene_door_success");

    if(scripts\engine\utility::flag("kid_grabbed")) {
      if(!istrue(level.ap_bpg_scene.kid_ran))
        level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.kid, "bpg_scene_door_success_branch");

      level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.aq_enforcer, "bpg_scene_door_success_branch");
      level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.player.rig, "bpg_scene_door_success_branch");
      level.ap_bpg_scene scripts\common\anim::anim_last_frame_solo(level.player.rig, "bpg_scene_door_success_branch");
      return;
    }

    level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.aq_enforcer, "bpg_scene_door_success");
    level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.player.rig, "bpg_scene_door_success");
    level.ap_bpg_scene scripts\common\anim::anim_last_frame_solo(level.player.rig, "bpg_scene_door_success");
    return;
  } else {
    level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.player.rig, "bpg_scene_door_release");
    thread scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  }
}

bpg_scene_player_interact_aq_enforcer_entourage() {
  level waittill("start_aq");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.aq_enforcer_entourage[0], "bpg_scene_door_success");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.aq_enforcer_entourage[2], "bpg_scene_door_success");
}

bpg_scene_player_interact_death() {
  level waittill("kill_plr");
  setDvar("player_death_animated", 0);
  level.player kill();
}

bpg_scene_player_interact_struggle() {
  level endon("kid_killed");
  var_0 = 15.3;
  var_1 = 18.56;
  var_2 = level.aq_enforcer scripts\engine\utility::getanim("bpg_scene");
  var_3 = level.aq_enforcer getanimtime(var_2);
  var_4 = getanimlength(var_2);
  var_5 = var_3 * var_4;
  var_6 = 0;

  if(var_5 > var_1) {
    var_6 = 1;
    var_0 = 21.8;
    var_1 = 26.3;
  }

  var_7 = 3;
  var_8 = getanimlength(level.player.rig scripts\engine\utility::getanim("bpg_scene_door_struggle")) / var_7;
  var_9 = var_5 + var_8;
  var_10 = var_7;

  if(var_9 > var_0 && var_9 < var_1) {
    if(var_6)
      level.ap_bpg_scene.kid_ran = 1;

    var_11 = var_1 - var_9 + var_8;
    var_10 = var_8 / var_11 * var_7;
  }

  level.ap_bpg_scene.door_latch scripts\engine\utility::delaycall(0.05, ::setanimrate, level.ap_bpg_scene.door_latch scripts\engine\utility::getanim("bpg_scene_door_struggle"), var_10);
  level.player.rig scripts\engine\utility::delaycall(0.05, ::setanimrate, level.player.rig scripts\engine\utility::getanim("bpg_scene_door_struggle"), var_10);
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(level.ap_bpg_scene.door_latch, "bpg_scene_door_struggle");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.player.rig, "bpg_scene_door_struggle");
  scripts\engine\utility::flag_set("bpg_scene_interact_success");
}

bpg_scene_price() {
  level.ap_bpg_scene notify("stop_loop_price");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.price, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "bpg_scene_escape_idle", "stop_loop_price");
  scripts\engine\utility::flag_set("bpg_scene_enforcer_done");
}

bpg_scene_enforcer() {
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  self detach(self.headmodel);
  self.headmodel = "head_villain_enforcer_blendshape";
  self attach(self.headmodel);
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  self setentitysoundcontext("atmosphere", "emb_enforcer", 0.1);
  level notify("audio_stop_banging");
  thread mus_enforcer_interact();
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  self delete();
}

mus_enforcer_interact() {}

bpg_scene_key_civ() {
  level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;
  self.animname = "bpg_scene_key_civ";
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::random(level.wall_truck_civ_hiding_spots));
  thread cleanup_wall_truck_civ();
  scripts\engine\utility::flag_wait("truck_wreck_start");

  if(isDefined(self) && isalive(self))
    self delete();
}

bpg_scene_aq() {
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo(self, "bpg_scene_escape_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  self delete();
}

bpg_scene_aq_basher() {
  if(isDefined(level.ap_bpg_scene.basher_count))
    level.ap_bpg_scene.basher_count++;
  else
    level.ap_bpg_scene.basher_count = 1;

  self.animname = "aq_basher_" + level.ap_bpg_scene.basher_count;
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  scripts\sp\fakeactor::take_control();
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  self delete();
}

bpg_scene_aq_basher_crowbar() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("bpg_scene_crowbar");
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(var_0, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(var_0, "bpg_scene");
  var_0 delete();
}

bpg_scene_marine_spawn() {
  var_0 = getspawner("bpg_scene_marine", "targetname");
  level.bpg_scene_marine = var_0 scripts\engine\sp\utility::spawn_ai(1);
}

bpg_scene_marine() {
  level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  self.animname = "bpg_scene_civ_marine";
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");

  if(!scripts\engine\utility::flag("bpg_scene_enforcer_done")) {
    level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo(self, "bpg_scene_escape_idle", "stop_loop_" + self.animname);
    scripts\engine\utility::flag_wait_any("bpg_scene_clear_exit_door", "bpg_scene_price_exiting");
    level.ap_bpg_scene notify("stop_loop_" + self.animname);
  }

  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene_exit");
  level notify("marine_and_mother_out");
  thread truck_office_bpg_scene_marine_move_to_marine();
}

skip_mother_and_marine() {
  level endon("marine_and_mother_out");
  var_0 = level.bpg_scene_marine scripts\engine\utility::getanim("bpg_scene_exit");
  var_1 = level.bpg_scene_marine getanimtime(var_0);
  var_2 = scripts\engine\utility::getStruct("bpg_scene_tele_marine_eye", "targetname").origin;
  var_3 = scripts\engine\utility::getStruct("bpg_scene_tele_mother_eye", "targetname").origin;

  while(var_1 < 0.68) {
    var_1 = level.bpg_scene_marine getanimtime(var_0);

    if(scripts\engine\utility::flag("bpg_scene_clear_exit_door") && !scripts\engine\sp\utility::player_looking_at(level.bpg_scene_marine getEye()) && !scripts\engine\sp\utility::player_looking_at(self getEye()) && !scripts\engine\sp\utility::player_looking_at(var_3) && !scripts\engine\sp\utility::player_looking_at(var_2)) {
      self setanimtime(scripts\engine\utility::getanim("bpg_scene_exit"), 0.68);
      level.bpg_scene_marine setanimtime(var_0, 0.68);
      var_1 = 0.68;
    }

    waitframe();
  }

  self setanimrate(scripts\engine\utility::getanim("bpg_scene_exit"), 1.5);
  level.bpg_scene_marine setanimrate(var_0, 1.5);
}

bpg_scene_mother() {
  level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  self.animname = "bpg_scene_civ_mother";
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");

  if(!scripts\engine\utility::flag("bpg_scene_enforcer_done")) {
    level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo(self, "bpg_scene_escape_idle", "stop_loop_" + self.animname);
    scripts\engine\utility::flag_wait_any("bpg_scene_clear_exit_door", "bpg_scene_price_exiting");
    level.ap_bpg_scene notify("stop_loop_" + self.animname);
  }

  scripts\engine\utility::delaythread(0.05, ::skip_mother_and_marine);
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene_exit");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::random(level.wall_truck_civ_hiding_spots));
  thread cleanup_wall_truck_civ();
  scripts\engine\utility::flag_wait("truck_wreck_start");

  if(isDefined(self) && isalive(self))
    self delete();
}

bpg_scene_civ_escape() {
  level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "mother"))
    self.animname = "bpg_scene_civ_mother";
  else {
    if(!isDefined(level.bpg_scene_civ_escape_count))
      level.bpg_scene_civ_escape_count = 1;
    else
      level.bpg_scene_civ_escape_count++;

    self.animname = "bpg_scene_civ_escape_" + level.bpg_scene_civ_escape_count;
  }

  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");

  if(!scripts\engine\utility::flag("bpg_scene_clear_exit_door") || !scripts\engine\utility::flag("bpg_scene_mar_cleared_door")) {
    level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo(self, "bpg_scene_escape_idle", "stop_loop_" + self.animname);
    scripts\engine\utility::flag_wait("bpg_scene_mar_cleared_door");
    scripts\engine\utility::flag_wait("bpg_scene_clear_exit_door");
    level.ap_bpg_scene notify("stop_loop_" + self.animname);
  }

  scripts\engine\utility::delaythread(0.1, ::skip_door_exiters, 0.885167);
  scripts\engine\utility::delaycall(0.05, ::setanimrate, scripts\engine\utility::getanim("bpg_scene_exit"), 1.5);
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene_exit");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::random(level.wall_truck_civ_hiding_spots));
  thread cleanup_wall_truck_civ();
  scripts\engine\utility::flag_wait("truck_wreck_start");

  if(isDefined(self) && isalive(self))
    self delete();
}

bpg_scene_civ_otherside() {
  thread scripts\sp\maps\embassy\embassy_util.gsc::hide_offscreen_shadow(800);
  self.fakeactor_face_anim = 1;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "child")) {
    self.animname = "bpg_scene_civ_kid";
    level.ap_bpg_scene.kid = self;
    level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;
  } else if(scripts\engine\utility::is_equal(self.script_noteworthy, "father"))
    self.animname = "bpg_scene_civ_father";
  else {
    level.ap_bpg_scene.civs[level.ap_bpg_scene.civs.size] = self;

    if(!isDefined(level.bpg_scene_civ_otherside_count))
      level.bpg_scene_civ_otherside_count = 1;
    else
      level.bpg_scene_civ_otherside_count++;

    self.animname = "bpg_scene_civ_" + level.bpg_scene_civ_otherside_count;
  }

  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_last_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  self delete();
}

bpg_scene_check_door_interact() {
  level endon("bpg_scene_door_inaccessible");
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EMBASSY/OPEN", 20, 500, 50, 0, 0, 0, undefined, "duration_medium");
  thread scripts\sp\maps\embassy\embassy_util.gsc::cursor_hint_unusable_think();
  self waittill("trigger");

  while(!isalive(level.player))
    waitframe();

  scripts\engine\utility::flag_set("bpg_scene_player_tried_door");
}

bpg_scene_chair_1() {
  scripts\engine\sp\utility::assign_animtree("bpg_scene_chair_1");
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(self, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_loop_solo(self, "bpg_scene_escape_idle");
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  self delete();
}

bpg_scene_chair_2() {
  scripts\engine\sp\utility::assign_animtree("bpg_scene_chair_2");
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  self delete();
}

bpg_scene_chair_3() {
  scripts\engine\sp\utility::assign_animtree("bpg_scene_chair_3");
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(self, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  self delete();
}

bpg_scene_handle_exit_doors() {
  var_0 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("bpg_scene_door_l");
  var_0 scripts\engine\sp\utility::assign_animtree("bpg_scene_door_l");
  var_1 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("bpg_scene_door_r");
  var_1 scripts\engine\sp\utility::assign_animtree("bpg_scene_door_r");
  level.ap_bpg_scene.right_door = var_1;
  var_2 = getEnt("bpg_scene_lock_out", "targetname");
  var_2.origin = var_2.origin + (0, 0, -100);
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(var_0, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_first_frame_solo(var_1, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_near_start");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(var_0, "bpg_scene");
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(var_1, "bpg_scene");
  scripts\engine\utility::flag_wait("bpg_scene_clear_exit_door");
  var_2.origin = var_2.origin + (0, 0, 100);
  scripts\engine\utility::flag_wait("bpg_scene_mar_cleared_door");
  var_1 scripts\engine\utility::delaythread(0.1, ::skip_door_exiters, 0.999);
  var_1 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_1 scripts\engine\utility::getanim("bpg_scene_exit"), 1.5);
  var_0 scripts\engine\utility::delaythread(0.1, ::skip_door_exiters, 0.999);
  var_0 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_0 scripts\engine\utility::getanim("bpg_scene_exit"), 1.5);
  level.ap_bpg_scene thread scripts\common\anim::anim_single_solo(var_0, "bpg_scene_exit");
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(var_1, "bpg_scene_exit");
  var_2 delete();
  scripts\engine\utility::flag_set("bpg_scene_doors_closed");
  scripts\engine\utility::stop_exploder("hide_crowd");
  scripts\engine\utility::stop_exploder("hide_crowd_filler");
  scripts\engine\utility::stop_exploder("ent_field_fog");
}

skip_door_exiters(var_0) {
  level endon("bpg_scene_doors_closed");

  while(!scripts\engine\utility::flag("bpg_scene_clear_exit_door") || !scripts\engine\utility::flag("bpg_scene_mar_cleared_door") || scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(level.ap_bpg_scene.right_door.origin))
    waitframe();

  self setanimtime(scripts\engine\utility::getanim("bpg_scene_exit"), var_0);
}

bp_glass_scene_catchup() {
  level.wall_truck_civ_hiding_spots = scripts\engine\utility::getStructArray("civilian_exit", "targetname");
  var_0 = getEnt("bpg_scene_lock_out", "targetname");
  var_0 delete();
  var_1 = getEntArray("bpg_scene_chair", "targetname");

  foreach(var_3 in var_1)
  var_3 delete();

  thread handle_civ_exit_door();
  scripts\engine\utility::flag_set("bpg_scene_doors_closed");
}

truck_office_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  bpg_scene_marine_spawn();
  scripts\engine\sp\utility::set_start_location("wall_truck_start", [level.player, level.price, level.bpg_scene_marine]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.ap_bpg_scene = scripts\engine\utility::getStruct("ap_bpg_scene", "targetname");
  thread audio_crowd_angry_outside(1);
  level.player thread scripts\sp\player::player_movement_state("creep");
  thread truck_office_bpg_scene_marine_move_to_marine();
}

pre_truck_office_cleanup() {
  scripts\sp\maps\embassy\embassy_util.gsc::make_player_and_price_non_story();

  if(isDefined(level.wolf_truck))
    level.wolf_truck delete();
}

truck_office_main() {
  level.player setsoundsubmix("sp_npc_steps_down", 4.0);
  pre_truck_office_cleanup();
  scripts\engine\sp\utility::autosave_by_name("truck_office_start");
  showmayhem("truck_crash_desk");
  scripts\engine\utility::stop_exploder("stairwell_scene_vfx");
  scripts\engine\utility::stop_exploder("landing_car_explode");
  level.ap_truck_office = scripts\engine\utility::getStruct("ap_truck_office", "targetname");
  var_0 = getspawner("truck_office_attack_civs_box_guy", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(::truck_office_civ_with_box);
  var_0 scripts\engine\sp\utility::spawn_ai();
  thread truck_office_flavor_truck_drive_by();
  thread truck_office_red_shirt();
  thread truck_office_bpg_scene_marine();
  thread truck_office_price();
  thread truck_office_civs();
  thread truck_office_enemies();
  thread truck_office_truck();
  thread truck_office_wall_collapse();
  thread truck_office_flavor_aq_run_through();
  thread audio_start_pre_impact_group_walla();
  scripts\engine\utility::flag_wait("allow_truck_wreck");
  thread scripts\sp\analytics::analytics_kleenex_update("Heli Infil to Truck Office");
  scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::flag_wait_any("wall_truck_enemies_defeated", "perfect_info");
  scripts\engine\utility::flag_wait("perfect_info");
  scripts\engine\utility::flag_clear("friendly_penalties_lowered");
}

truck_office_wall_collapse() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("truck_office_collapse_wall");
  level.ap_truck_office scripts\common\anim::anim_first_frame_solo(var_0, "wall_collapse");
  level waittill("allow_collapse");
  thread scripts\engine\utility::play_sound_in_space("embassy_truck_hole_debris_crash", (-7370, -3850, 114));
  level.ap_truck_office scripts\common\anim::anim_single_solo(var_0, "wall_collapse");
  scripts\engine\utility::flag_wait("reached_basement");
  var_0 delete();
}

truck_office_flavor_aq_run_through() {
  scripts\engine\utility::flag_wait("truck_wreck_start");
  scripts\engine\utility::flag_wait_any_timeout(25.0, "force_drop_ceiling", "wall_truck_shotgun_enemies_defeated");
  var_0 = getspawnerarray("truck_office_invader_flavor");
  thread audio_aq_run_behind_truck();

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\sp\utility::spawn_ai();
    var_3 setCanDamage(1);
    var_3 setCanRadiusDamage(0);
    wait(randomfloatrange(0.5, 0.75));
  }

  wait 1.5;
  level notify("allow_collapse");
}

audio_start_pre_impact_group_walla() {
  level.truck_crowd_walla_loop = spawn("script_origin", (-6814, -3750, 116));
  level.truck_crowd_walla_loop thread scripts\engine\sp\utility::sound_fade_in("embassy_truck_crowd_before_impact", 1.0, 3.0, 1);
  scripts\engine\utility::flag_wait("truck_wreck_start");
  level.truck_crowd_walla_loop thread scripts\engine\sp\utility::sound_fade_and_delete(0.8, 1);
  wait 0.5;
  thread scripts\engine\utility::play_sound_in_space("embassy_truck_crowd_after_impact_screams", (-6814, -3750, 116));
}

audio_aq_run_behind_truck() {
  wait 1.5;
  thread audio_aq_run_behind_truck_one_shots();
  level.aq_run_behind_truck = spawn("script_origin", (-7416, -3862, 92));
  level.aq_run_behind_truck playSound("embassy_guys_rush_front_door");
  level.aq_run_behind_truck thread scripts\engine\sp\utility::sound_fade_in("embassy_truck_guys_rushing_in_loop", 1.0, 1.5, 1);
  level.aq_run_behind_truck moveTo((-7401, -2978, 92), 12.0, 0.2, 0.2);
  wait 10.0;
  scripts\engine\utility::flag_wait_any("wall_truck_enemies_defeated", "perfect_info");
  level.aq_run_behind_truck moveTo((-7736, -2890, 92), 10.0, 0.2, 0.2);
  wait 10.0;
  audio_wait_until_player_close_enough_to_obj();
  level.aq_run_behind_truck moveTo((-7736, -2561, 92), 5.0, 0.2, 0.2);
  wait 3.0;
  audio_wait_until_player_close_enough_to_obj(485);
  level.aq_run_behind_truck moveTo((-8077, -2561, 92), 5.0, 0.2, 0.2);
  wait 3.0;
  audio_wait_until_player_close_enough_to_obj(450);
  level.aq_run_behind_truck moveTo((-8137, -2272, 92), 5.0, 0.2, 0.2);
  wait 2.0;
  level.aq_run_behind_truck stoploopsound(5.0);
  audio_wait_until_player_close_enough_to_obj(450);
  level.aq_run_behind_truck moveTo((-7675, -2242, 117), 5.0, 0.2, 0.2);
  wait 2.0;
  audio_wait_until_player_close_enough_to_obj(600);
  level notify("now_thru_basement_door");
}

audio_aq_run_behind_truck_one_shots() {
  level endon("now_thru_basement_door");

  for(;;) {
    wait(5 + randomfloat(3.5));

    if(isDefined(level.aq_run_behind_truck))
      level.aq_run_behind_truck playSound("embassy_truck_guys_rummaging");
  }
}

audio_wait_until_player_close_enough_to_obj(var_0) {
  if(!isDefined(var_0))
    var_0 = 750;

  level endon("player_is_close_enough_now");

  for(;;) {
    var_1 = distance(level.player.origin, level.aq_run_behind_truck.origin);

    if(var_1 < var_0)
      level notify("player_is_close_enough_now");

    wait 0.2;
  }
}

truck_office_flavor_truck_drive_by() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("flavor_truck");
  var_0 thread scripts\engine\sp\utility::play_sound_on_entity("embassy_truck_passby");
  level.player setclienttriggeraudiozonepartial("embassy_office_truck_passby", "occlusion", "filter");
  wait 1.5;
  level.player scripts\engine\utility::delaycall(1.0, ::clearclienttriggeraudiozone, 6.0);
  var_1 = scripts\engine\sp\utility::spawn_targetname("flavor_truck_driver");
  var_1.animname = "flavor_truck_driver";
  var_1 linkTo(var_0, "tag_driver");
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "flavor_truck_drive_by", "stop_loop_driver", "tag_driver");
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("flavor_truck_passenger");

  foreach(var_5, var_4 in var_2) {
    var_4.animname = "flavor_truck_passenger_" + (var_5 + 1);
    var_4 linkTo(var_0, "tag_body_animate");
    var_0 thread scripts\common\anim::anim_single_solo(var_4, "flavor_truck_drive_by", "tag_body_animate");
  }

  var_0 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_0 scripts\engine\utility::getanim("flavor_truck_drive_by"), 1.2);
  level.ap_truck_office scripts\common\anim::anim_single_solo(var_0, "flavor_truck_drive_by");
  scripts\engine\utility::array_delete(var_2);
  var_1 delete();
  var_0 delete();
}

truck_office_price() {
  level endon("truck_cleared");
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price.ignoreall = 1;
  level.ap_bpg_scene scripts\common\anim::anim_single_solo(level.price, "bpg_scene_escape_exit");
  level.price scripts\engine\sp\utility::set_force_color("p");
  thread truck_office_price_move_to_marine();
  thread bg_scene_post_vo();
  scripts\engine\utility::flag_wait("allow_truck_wreck");
  wait_ready_truck_wreck();
  level notify("stop_bpg_entrance_alarm_loop");
  level.wall_truck thread scripts\engine\sp\utility::play_sound_on_entity("embassy_truck_impact_lr");
  thread sfx_truck_crashed_loops();
  wait 1.5;
  scripts\engine\utility::flag_set("truck_wreck_start");
  wait 0.5;
  thread audio_post_truck_office_alarm_loop_start();
  level.price scripts\common\utility::demeanor_override("combat");
  level.price.ignoreall = 0;
  level.price.disableplayeradsloscheck = 0;
  level.price.cornerstepoutsdisabled = 1;
  scripts\engine\sp\utility::activate_trigger_with_targetname("price_cover_b4_truck");
  scripts\engine\utility::flag_wait_any("wall_truck_few_enemies_left", "perfect_info", "wall_truck_enemies_defeated");
  level.price.cornerstepoutsdisabled = 0;
  scripts\engine\sp\utility::activate_trigger_with_targetname("price_cover_at_truck");
}

sfx_truck_crashed_loops() {
  wait 4;
  var_0 = spawn("script_origin", (-7055, -3581, 112));
  var_1 = spawn("script_origin", (-7187, -3653, 112));
  var_2 = spawn("script_origin", (-7380, -3889, 92));
  var_0 playLoopSound("embassy_truck_crash_idle_lp");
  var_1 playLoopSound("embassy_truck_crash_dirt_debris_lp");
  var_2 playLoopSound("embassy_truck_bldng_wreckage_lp");
}

truck_office_price_move_to_marine() {
  level endon("truck_wreck_start");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("price_pre_truck");
  level.price waittill("path_end_reached");
  level.price scripts\common\utility::demeanor_override("casual_gun");
}

wait_ready_truck_wreck() {
  var_0 = gettime();
  var_1 = scripts\engine\utility::getStruct("truck_office_look_trigger", "targetname");

  while(!scripts\engine\utility::time_has_passed(var_0, 3.0) && !scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(var_1.origin) && !scripts\engine\utility::flag("force_truck_wreck"))
    waitframe();
}

bg_scene_post_vo() {
  level endon("allow_truck_wreck");
  level.price.escape_idle_nags = undefined;
  wait 0.6;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_breach_vehicle_10");
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_alx_breach_offices_40");
  wait 13;

  while(!scripts\engine\utility::flag("allow_truck_wreck")) {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_breach_vehicle_40");
    wait 13;
  }
}

truck_office_setup_truck() {
  level.wall_truck = getEnt("wall_truck", "targetname");
  level.wall_truck scripts\engine\sp\utility::assign_animtree("office_truck");
  level.wall_truck.clip = getEnt("wall_truck_clip", "targetname");
  level.wall_truck.clip linkTo(level.wall_truck);
}

truck_office_setup_walls() {
  level.wall_truck_wall_pre = getEntArray("wall_truck_wall_pre", "targetname");
  level.wall_truck_wall_post = getEntArray("wall_truck_wall_post", "targetname");
  level.wall_truck_wall_post_2 = getEntArray("wall_truck_wall_post_2", "targetname");
}

truck_office_hide_all() {
  level.wall_truck hide();
  scripts\engine\utility::array_thread(level.wall_truck_wall_pre, scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(level.wall_truck_wall_post, scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(level.wall_truck_wall_post_2, scripts\engine\sp\utility::hide_entity);
}

truck_office_delete_all() {
  level.wall_truck.clip delete();
  level.wall_truck delete();
  scripts\engine\utility::array_call(level.wall_truck_wall_pre, ::delete);
  scripts\engine\utility::array_call(level.wall_truck_wall_post, ::delete);
  scripts\engine\utility::array_call(level.wall_truck_wall_post_2, ::delete);
}

truck_office_walls_pre() {
  level.wall_truck show();
  scripts\engine\utility::array_thread(level.wall_truck_wall_pre, scripts\engine\sp\utility::show_entity);
  scripts\engine\utility::array_thread(level.wall_truck_wall_post, scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(level.wall_truck_wall_post_2, scripts\engine\sp\utility::hide_entity);
}

truck_office_walls_post(var_0) {
  scripts\engine\utility::array_call(level.wall_truck_wall_pre, ::delete);
  scripts\engine\utility::array_thread(level.wall_truck_wall_post, scripts\engine\sp\utility::show_entity);

  if(var_0)
    wait 1.55;

  scripts\engine\utility::array_thread(level.wall_truck_wall_post_2, scripts\engine\sp\utility::show_entity);
}

truck_office_truck() {
  truck_office_walls_pre();
  scripts\engine\utility::flag_wait("truck_wreck_start");
  thread truck_office_walls_post(1);
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_truck_crash_start();
  thread truck_office_wreck_vfx();

  if(scripts\engine\utility::flag("perfect_info"))
    level.player scripts\engine\utility::delaycall(0.3, ::shellshock, "default", 3);

  level.ap_truck_office scripts\common\anim::anim_single_solo(level.wall_truck, "to_attack_scene");
  level.wall_truck.clip disconnectPaths();
  level notify("truck_wreck_done");
}

truck_office_wreck_vfx() {
  thread truck_office_wreck_reaction_gesture();
  level.player scripts\engine\utility::delaycall(0.2, ::playrumbleonentity, "damage_heavy");
  scripts\engine\utility::exploder("truck");
  wait 0.75;
  screenshake(level.wall_truck.origin, 20, 2, 4, 0.75, 0, 0.5, 1500, 5, 50, 50);
  wait 0.7;
  playmayhem("truck_crash_desk");
  wait 0.1;
  level.player playRumbleOnEntity("damage_bullet");
  screenshake(level.wall_truck.origin, 10, 1, 2, 0.5, 0, 0.5, 1500, 5, 50, 50);
  wait 0.8;
  level.player playRumbleOnEntity("damage_heavy");
  screenshake(level.wall_truck.origin, 20, 2, 4, 0.5, 0, 0.5, 1500, 5, 50, 50);
}

truck_office_wreck_reaction_gesture() {
  wait 0.4;

  if(!level.player scripts\engine\sp\utility::isads()) {
    level.player scripts\common\utility::allow_weapon_pickup(0);
    level.player forceplaygestureviewmodel("ges_frag_block");
    waitframe();

    while(level.player isgestureplaying("ges_frag_block")) {
      if(level.player scripts\engine\sp\utility::isads())
        level.player stopgestureviewmodel("ges_frag_block", 0.1, 0);

      waitframe();
    }

    level.player scripts\common\utility::allow_weapon_pickup(1);
  }

  level.player thread scripts\sp\player::player_movement_state("default");
}

truck_office_civ_with_box() {
  self.fakeactor_face_anim = 1;
  self.animname = "civ_box_guy";
  var_0 = getEnt("truck_office_attack_civs_box", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("box");
  var_1 = getEnt("truck_office_attack_civs_box_lid", "targetname");
  var_1 scripts\engine\sp\utility::assign_animtree("box_lid");
  level.ap_truck_office thread scripts\common\anim::anim_loop_solo(var_0, "to_attack_idle", "stop_loop_box_guy");
  level.ap_truck_office thread scripts\common\anim::anim_loop_solo(var_1, "to_attack_idle", "stop_loop_box_guy");
  level.ap_truck_office thread scripts\common\anim::anim_loop_solo(self, "to_attack_idle", "stop_loop_box_guy");
  scripts\engine\utility::flag_wait("truck_wreck_start");
  level.ap_truck_office notify("stop_loop_box_guy");
  level.ap_truck_office thread scripts\common\anim::anim_single_solo(var_0, "to_attack_scene");
  level.ap_truck_office thread scripts\common\anim::anim_single_solo(var_1, "to_attack_scene");
  level.ap_truck_office scripts\common\anim::anim_single_solo(self, "to_attack_scene");
  self notsolid();
  self startragdoll();
  scripts\engine\utility::flag_wait("reached_basement");
  var_0 delete();
  var_1 delete();
  self delete();
}

truck_office_enemies() {
  level.truck_enemy_alive_count = 7;
  thread truck_office_shotgun_impedence();
  scripts\engine\utility::flag_wait("truck_wreck_start");
  scripts\engine\utility::flag_set("friendly_penalties_lowered");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("wall_truck_ai", 1);

  foreach(var_2 in var_0) {
    var_2 thread scripts\sp\maps\embassy\embassy_util.gsc::perfect_player_info();
    var_2 thread truck_office_enemy_death_counter();

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "aq_killer")) {
      if(isDefined(level.aq_killer_tag_taken)) {
        var_2.animname = "aq_2";
        var_2 thread truck_office_aq_rider();
      } else {
        var_2.animname = "aq_1";
        var_2 thread truck_office_aq_rider();
        level.aq_killer_tag_taken = 1;
      }
    }

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "desk_hopper")) {
      var_2.animname = "aq_1";
      var_2 thread truck_office_aq_killer();
    }
  }

  var_4 = scripts\engine\sp\utility::array_spawn_targetname("wall_truck_ai_shotties", 1);
  level.truck_enemy_alive_count = level.truck_enemy_alive_count + var_4.size;

  foreach(var_2 in var_4) {
    var_2 thread scripts\sp\maps\embassy\embassy_util.gsc::perfect_player_info();
    var_2 thread truck_office_enemy_death_counter();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "truck_driver") {
      var_2.animname = "aq_driver";
      var_2 thread truck_office_aq_driver();
    }
  }

  level scripts\engine\sp\utility::waittill_dead(var_4, 2);
  scripts\engine\utility::flag_set("wall_truck_shotgun_enemies_defeated");
  var_0 = scripts\engine\utility::array_removedead(var_0);

  if(var_0.size > 0)
    scripts\engine\sp\utility::waittill_dead(var_0);

  scripts\engine\utility::flag_set("wall_truck_enemies_defeated");
}

truck_office_enemy_death_counter() {
  self waittill("death");
  level.truck_enemy_alive_count--;

  if(!scripts\engine\utility::flag("wall_truck_few_enemies_left") && level.truck_enemy_alive_count <= 4)
    scripts\engine\utility::flag_set("wall_truck_few_enemies_left");
}

truck_office_shotgun_impedence() {
  var_0 = scripts\engine\utility::getStruct("truck_wall_collapse", "targetname").origin;
  var_1 = level.player.health / 2;

  while(level.truck_enemy_alive_count > 4) {
    scripts\engine\utility::flag_wait("perfect_info");

    while(scripts\engine\utility::flag("perfect_info") && level.truck_enemy_alive_count > 4) {
      level.player dodamage(var_1, var_0);
      wait 0.3;
    }
  }
}

truck_office_aq_driver() {
  self endon("death");
  scripts\engine\sp\utility::set_allowdeath(1);
  level.ap_truck_office scripts\common\anim::anim_single_solo(self, "to_attack_scene_ride");
  scripts\sp\spawner::go_to_node();
}

truck_office_aq_rider() {
  self endon("death");
  scripts\engine\sp\utility::set_allowdeath(1);
  level.ap_truck_office scripts\common\anim::anim_single_solo(self, "to_attack_scene_ride");
  scripts\sp\spawner::go_to_node();
}

truck_office_aq_killer() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("ap_truck_office_desk_hopper", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(self, "to_attack_scene");
  scripts\engine\utility::delaythread(0.79, scripts\engine\sp\utility::set_allowdeath, 1);
  var_0 scripts\common\anim::anim_single_solo(self, "to_attack_scene");
  scripts\sp\spawner::go_to_node();
}

truck_office_red_shirt() {
  scripts\engine\sp\utility::trigger_wait_targetname("wall_truck_civs_trigger");
  var_0 = scripts\engine\sp\utility::spawn_targetname("truck_office_red_shirts");
  var_0.animname = "red_shirt";
  var_0.health = int(var_0.health / 2);
  level.ap_truck_office thread scripts\common\anim::anim_loop_solo(var_0, "to_attack_idle", "stop_loop_red_shirt");

  while(!isDefined(level.wall_truck_civs))
    waitframe();

  var_1 = getEnt("cvm1_civilian", "script_noteworthy");
  var_0 thread truck_office_marine_vo(var_1);
  var_0 thread truck_office_crash_vo(var_1);
  scripts\engine\utility::flag_wait("truck_wreck_start");
  scripts\engine\sp\utility::activate_trigger_with_targetname("red_shirts_truck_start");
  level.ap_truck_office notify("stop_loop_red_shirt");
  level.ap_truck_office scripts\common\anim::anim_single_solo(var_0, "to_attack_react");
  level waittill("marine_dialogue_done");

  if(isDefined(var_0) && isalive(var_0)) {
    var_2 = scripts\engine\utility::getStruct("marine_death_magic_bullet", "targetname");
    magicbullet("iw8_sh_romeo870", var_2.origin, var_0 gettagorigin("j_spine4"));
    wait 0.3;
    var_0 scripts\engine\sp\utility::die();
  }
}

truck_office_bpg_scene_marine_move_to_marine() {
  level endon("truck_wreck_start");
  level.bpg_scene_marine scripts\common\utility::demeanor_override("cqb");
  level.bpg_scene_marine thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("bpg_scene_marine_pre_truck");
  level.bpg_scene_marine waittill("path_end_reached");
  level.bpg_scene_marine scripts\common\utility::demeanor_override("casual_gun");
}

truck_office_bpg_scene_marine() {
  scripts\engine\utility::flag_wait("truck_wreck_start");
  level.bpg_scene_marine.health = 1;
  level.bpg_scene_marine scripts\common\utility::demeanor_override("combat");
  level.bpg_scene_marine thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("bpg_scene_marine_post_truck");
  level waittill("marine_dialogue_done");
  wait 0.5;

  if(isDefined(level.bpg_scene_marine) && isalive(level.bpg_scene_marine)) {
    var_0 = scripts\engine\utility::getStruct("bpg_scene_marine_death_magic_bullet", "targetname");
    magicbullet("iw8_sh_romeo870", var_0.origin, level.bpg_scene_marine gettagorigin("j_spine4"));
    wait 0.3;
    level.bpg_scene_marine scripts\engine\sp\utility::die();
  }
}

truck_office_marine_vo(var_0) {
  level endon("truck_wreck_start");
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_us1_breach_vehicle_50");
  var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_cvm1_breach_vehicle_60");
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_us1_breach_vehicle_70");
  wait 1;
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_us1_breach_vehicle_71");
  wait 1.3;
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_uscm_breach_vehicle_72");
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::flag_set, "allow_truck_wreck");
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_us1_breach_vehicle_73");
}

truck_office_crash_vo(var_0) {
  level endon("bpg_combat_second_wave_defeated");
  level endon("reached_basement");
  scripts\engine\utility::flag_wait("truck_wreck_start");
  setmusicstate("mx_embassy_office_combat");
  level.price stopsounds();
  self stopsounds();

  if(isalive(var_0))
    var_0 stopsounds();

  truck_office_crash_marine_vo();
  thread truck_office_crash_price_vo();

  if(isalive(self))
    scripts\engine\sp\utility::set_battlechatter(1);

  scripts\engine\utility::flag_wait("perfect_info");

  if(isalive(self))
    scripts\engine\sp\utility::set_battlechatter(0);
}

truck_office_crash_marine_vo() {
  self endon("death");
  wait 2.4;
  thread interrupt_marine_vo();
  scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_breach_vehicle_74");
  wait 1;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_breach_vehicle_75");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_us1_breach_vehicle_76");
  level notify("marine_dialogue_done");
}

truck_office_crash_price_vo() {
  while(scripts\engine\utility::array_removedead_or_dying(getaiarray("axis")).size > 0)
    level waittill("ai_killed");

  wait 0.8;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.8, 2);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_breach_vehicle_90");
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_breach_vehicle_100");
  wait 0.2;
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_breach_vehicle_110");
  level.price thread scripts\engine\sp\utility::battlechatter_filter_on(["order", "reaction"]);
  level.price thread scripts\engine\sp\utility::battlechatter_probability(-10);
  level.price scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\utility::flag_wait("truck_cleared");
  wait 1.5;

  while(level.player.health > 85 && !scripts\engine\utility::flag("bpgc_reached_hallway_to_basement"))
    waitframe();

  if(!scripts\engine\utility::flag("bpgc_reached_hallway_to_basement"))
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_breach_offices_05");
}

interrupt_marine_vo() {
  self waittill("death");
  self stopsounds();
}

truck_office_civs() {
  scripts\engine\sp\utility::trigger_wait_targetname("wall_truck_civs_trigger");
  scripts\engine\utility::flag_wait("bpg_scene_doors_closed");
  level.player thread scripts\sp\player::player_movement_state("cqb");
  level.wall_truck_civs = scripts\engine\sp\utility::array_spawn_targetname("wall_truck_civs");

  foreach(var_2, var_1 in level.wall_truck_civs) {
    var_1.ignoreall = 1;
    var_1.animname = "civ";
    var_1.hiding_spot = undefined;
    var_1.hiding = 0;
    var_1 enableavoidance(0, 0);
    var_1 scripts\asm\asm_bb::bb_setcivilianstate("casual");
    var_1 thread truck_office_civ_idle_handler(var_2);
  }

  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::dont_shoot_through_civilians(level.wall_truck_civs, 150, "truck_cleared");
  level waittill("truck_wreck_start");

  foreach(var_1 in level.wall_truck_civs) {
    var_4 = randomfloatrange(0.0, 0.3);
    var_1 thread scripts\engine\sp\utility::notify_delay("stop_loop", var_4);
    var_1 scripts\engine\utility::delaycall(var_4, ::stopanimscripted);
    var_1 scripts\engine\utility::delaythread(var_4, scripts\asm\asm_bb::bb_setcivilianstate, "panic");
    var_5 = randomintrange(1, 3);
    var_1 scripts\engine\utility::delaythread(var_4 + 0.1, scripts\common\anim::anim_single_solo, var_1, "truck_react_" + var_5);
    var_1 scripts\engine\utility::delaycall(var_4 + 0.15, ::setanimrate, var_1 scripts\engine\utility::getanim("truck_react_" + var_5), 2.0);
    var_1 thread scripts\engine\utility::set_movement_speed(randomfloatrange(195, 225));
  }

  thread make_civs_flee();
}

truck_office_civ_idle_handler(var_0) {
  level endon("truck_wreck_start");
  thread scripts\common\anim::anim_loop_solo(self, "casual_idle", "stop_loop");
  self setanimrate(scripts\engine\utility::getanim("casual_idle")[0], var_0 / level.wall_truck_civs.size);
  var_1 = scripts\engine\utility::mod(var_0, 5);
  wait(randomfloatrange(1.0, 6.0));

  for(;;) {
    scripts\common\anim::anim_single_solo(self, "casual_idle_twitch_" + var_1);
    var_1 = var_1 + randomintrange(0, 5);
    var_1 = scripts\engine\utility::mod(var_1, 5);
    wait(randomfloatrange(3.0, 6.0));
  }
}

make_civs_flee() {
  level.wall_truck_civ_exit_points = scripts\engine\utility::getStructArray("flee_exits", "targetname");
  var_0 = getEntArray("flee_first", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("flee_lanes", "targetname");

  for(var_2 = 1; level.wall_truck_civs.size > 0 && !scripts\engine\utility::flag("truck_cleared"); var_2 = !var_2) {
    level.wall_truck_civs = scripts\engine\utility::array_removedead_or_dying(level.wall_truck_civs);

    if(var_0.size > 0) {
      var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
      var_3 = var_0[0];
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    } else if(var_2) {
      var_4 = -1;
      var_5 = undefined;

      foreach(var_7 in var_1) {
        var_8 = distance2dsquared(level.player.origin, var_7.origin);

        if(var_4 == -1 || var_8 < var_4) {
          var_4 = var_8;
          var_5 = var_7;
        }
      }

      var_3 = scripts\engine\sp\utility::get_closest_living(var_5.origin, level.wall_truck_civs);
    } else
      var_3 = scripts\engine\utility::random(level.wall_truck_civs);

    level.wall_truck_civs = scripts\engine\utility::array_remove(level.wall_truck_civs, var_3);

    if(isDefined(var_3) && isalive(var_3)) {
      var_3 thread civ_flee_to();

      if(var_0.size > 0) {
        wait 0.25;
        continue;
      }

      wait(randomfloatrange(0.25, 0.75));
    }
  }

  scripts\engine\utility::flag_wait_all("truck_cleared");

  if(level.wall_truck_civs.size > 0) {
    level.wall_truck_civs = scripts\engine\utility::array_removedead(level.wall_truck_civs);

    foreach(var_3 in level.wall_truck_civs)
    var_3 cleanup_wall_truck_civ();
  }
}

cleanup_wall_truck_civ() {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self)) {
    while(scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(self.origin) || distance2dsquared(level.player.origin, self.origin) < squared(200))
      wait 0.1;

    self delete();
  }
}

civ_flee_to() {
  self endon("death");
  var_0 = scripts\engine\utility::getclosest(self.origin, level.wall_truck_civ_exit_points);

  if(distance2dsquared(var_0.origin, self.origin) > squared(var_0.radius))
    var_0 = scripts\engine\utility::getclosest(level.player.origin, level.wall_truck_civ_exit_points);

  scripts\common\ai::disable_arrivals();
  scripts\sp\spawner::go_to_node(var_0);
  scripts\engine\utility::delaythread(1.5, scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think);
  scripts\sp\spawner::go_to_node(scripts\engine\utility::random(level.wall_truck_civ_hiding_spots));
  self delete();
}

truck_office_catchup() {
  if(!scripts\sp\starts::is_after_start("infil_basement")) {
    truck_office_walls_post(0);
    level.ap_truck_office = scripts\engine\utility::getStruct("ap_truck_office", "targetname");
    level.ap_truck_office scripts\common\anim::anim_last_frame_solo(level.wall_truck, "to_attack_scene");
  } else
    truck_office_delete_all();

  killmayhem("truck_crash_desk");
}

bp_glass_combat_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("bpg_combat_start", [level.player, level.price]);
  scripts\engine\utility::flag_set("perfect_info");
  thread audio_crowd_angry_outside(1);
  thread audio_post_truck_office_alarm_loop_start();
  thread audio_aq_run_behind_truck();
}

bp_glass_combat_main() {
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::setup_bpg_combat();
  thread bpg_combat_wait_autosave();
  thread bpg_combat_price();
  thread bp_glass_combat_enemies();
  thread bp_glass_hint_flash();
  thread bpgc_conference_room();
  thread bpgc_hostage();
  thread bpgc_interrogation();
  thread basement_bodies();
  thread sfx_basement_door_fire();
  thread bpgc_price_halligan_scene();
  scripts\engine\utility::flag_wait("player_past_first_wave");
  scripts\engine\sp\utility::autosave_by_name("bpg_combat_mid");
  scripts\engine\utility::flag_wait("reached_basement");
}

sfx_basement_door_fire() {
  var_0 = spawn("script_origin", (-7553, -2248, 87));
  var_0 scripts\engine\sp\utility::sound_fade_in("emt_fire_door_lp", 1, 1, 1);
  scripts\engine\utility::flag_wait("reached_basement");
  wait 3;
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
}

bpg_combat_price() {
  level.price.script_pushable = 1;
  level.price pushplayer(0);
  level.price.cornerstepoutsdisabled = 0;

  if(!scripts\engine\utility::flag("truck_cleared")) {
    scripts\engine\sp\utility::activate_trigger_with_targetname("price_cover_before_bpg");
    scripts\engine\utility::flag_wait("truck_cleared");
    wait 1.5;
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("price_cover_bpg_1_activate");
  scripts\engine\utility::flag_wait_any("bpgc_price_1a", "bpgc_price_1b");
  level.price scripts\engine\sp\utility::disable_ai_color();

  if(scripts\engine\utility::flag("bpgc_price_1a"))
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("price_1_right");
  else
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("price_1_left");

  scripts\engine\utility::flag_wait_any("bpgc_price_2a", "bpgc_price_2b");

  if(scripts\engine\utility::flag("bpgc_price_2a"))
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("price_2_right");
  else if(scripts\engine\utility::flag("bpgc_price_1b"))
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("price_2_left");
  else
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("price_2_left_cover");

  scripts\engine\utility::flag_wait_any("bpgc_reached_hallway_to_basement", "bpg_combat_first_wave_defeated");
  scripts\engine\utility::flag_wait_any("bpgc_reached_hallway_to_basement", "bpg_combat_second_wave_defeated");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("bpgc_price_basement_hallway");
}

bpg_combat_wait_autosave() {
  scripts\engine\utility::flag_wait("perfect_info");
  scripts\engine\sp\utility::autosave_by_name("bpg_combat_start");
}

bp_glass_hint_flash() {
  scripts\engine\utility::flag_wait("truck_cleared");

  if(level.player getammocount("flash") > 0) {
    var_0 = gettime();

    while(!scripts\engine\utility::time_has_passed(var_0, 15.0) && !level.player secondaryoffhandbuttonPressed())
      waitframe();

    if(scripts\engine\utility::time_has_passed(var_0, 6.0) && scripts\engine\utility::time_has_passed(level.player.offhands.lastusedoffhandtime, 300)) {
      level.flash_hint_timer = gettime();
      scripts\engine\sp\utility::display_hint("hint_use_flashbang");
    }
  }
}

bp_glass_combat_enemies() {
  scripts\engine\utility::flag_wait("bpgc_hostage_started");
  thread bp_glass_combat_wave("invaders", ::bpg_first_wave_enemy, "bpg_combat_first_wave_defeated");
  scripts\engine\utility::flag_wait_any("bpg_combat_first_wave_defeated", "player_past_first_wave");
  thread bp_glass_vo();
  thread bp_glass_combat_wave("invaders_reinforcements", ::bpg_window_break_through, "bpg_combat_second_wave_defeated");
}

bp_glass_combat_wave(var_0, var_1, var_2) {
  var_3 = scripts\engine\sp\utility::array_spawn_targetname(var_0);

  foreach(var_5 in var_3)
  var_5 thread[[var_1]]();

  level scripts\engine\sp\utility::waittill_dead(var_3);
  scripts\engine\utility::flag_set(var_2);
}

bpg_first_wave_enemy() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\embassy\embassy_util.gsc::dont_shoot_through_bp_glass();
  thread scripts\sp\maps\embassy\embassy_util.gsc::check_and_kill("bpgc_price_to_basement", "bpgc_kill_node");

  if(!scripts\engine\utility::is_equal(self.animname, "bpgc_conf_aq") && !scripts\engine\utility::is_equal(self.animname, "bpgc_hostage_aq"))
    self waittill("reached_path_end");

  if(self.classname == "actor_enemy_alq_urban_shotgun")
    thread bpg_closers();
  else {
    scripts\engine\sp\utility::set_goal_radius(400);
    self.minexposedmolotovdist = 150;

    if(!scripts\engine\utility::flag("bpgc_reached_hallway_to_basement"))
      scripts\engine\utility::waittill_any_ents(self, "damage", self, "bullethit", level, "bpgc_reached_hallway_to_basement");

    thread bpg_closers();
  }
}

bpg_window_break_through() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\embassy\embassy_util.gsc::dont_shoot_through_bp_glass();
  thread scripts\sp\maps\embassy\embassy_util.gsc::check_and_kill("bpgc_price_to_basement", "bpgc_kill_node");

  if(isDefined(self.script_noteworthy)) {
    self.minexposedgrenadedist = 500;
    self.target = self.script_noteworthy;
    scripts\sp\spawner::go_to_node();
    self waittill("reached_path_end");
    scripts\engine\sp\utility::set_goal_radius(200);
    scripts\engine\utility::flag_wait_any("bpgc_price_2a", "bpgc_price_2b");
    thread bpg_closers();
  } else
    thread bpg_closers();
}

bpgc_conference_room() {
  var_0 = scripts\engine\utility::getStruct("ap_bpgc_conference", "targetname");
  var_1 = getspawnerarray("bpgc_conf_civs");
  scripts\engine\sp\utility::array_spawn_function(var_1, ::bpgc_conf_civ, var_0);
  var_2 = getspawner("bpgc_conf_aq", "targetname");
  var_2 scripts\engine\sp\utility::add_spawn_function(::bpgc_conf_aq, var_0);
  var_3 = scripts\engine\sp\utility::array_spawn(var_1);
  var_3[var_3.size] = var_2 scripts\engine\sp\utility::spawn_ai();
  var_4 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("bpgc_conf_door");
  var_4 scripts\engine\sp\utility::assign_animtree("bpgc_conf_door");
  var_4 thread bpgc_conf_object(var_0);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("bpgc_conf_chair");
  var_5 thread bpgc_conf_object(var_0);
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_and_visible_flag(var_3, "truck_cleared");
  scripts\engine\utility::flag_set("bpgc_conference_started");
}

bpgc_conf_aq(var_0) {
  thread scripts\engine\sp\utility::flag_on_death("bpgc_conf_aq_dead");
  self endon("death");
  self endon("entitydeleted");
  self.animname = "bpgc_conf_aq";
  self.ignoreme = 1;
  scripts\common\ai::gun_remove();
  scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_sh_romeo870"), "primary");
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "bpgc_conference");
  scripts\engine\utility::flag_wait("bpgc_conference_started");
  scripts\engine\utility::delaythread(2.51, scripts\engine\sp\utility::set_allowdeath, 1);
  scripts\engine\utility::delaythread(2.51, scripts\engine\sp\utility::set_ignoreme, 0);
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_conference");
  bpg_first_wave_enemy();
}

bpgc_conf_civ(var_0) {
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;

  if(isDefined(var_0.civ_count))
    var_0.civ_count++;
  else
    var_0.civ_count = 1;

  self.animname = "bpgc_conf_civ_" + var_0.civ_count;
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "bpgc_conference");
  scripts\engine\utility::flag_wait("bpgc_conference_started");
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_conference");
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

bpgc_conf_object(var_0) {
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "bpgc_conference");
  scripts\engine\utility::flag_wait("bpgc_conference_started");
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_conference");

  if(self.animname == "bpgc_conf_door")
    scripts\sp\maps\embassy\embassy_util.gsc::connect_office_door_paths();

  scripts\engine\utility::flag_wait("reached_basement");
  self delete();
}

bpgc_hostage(var_0) {
  var_1 = scripts\engine\utility::getStruct("ap_bpgc_hostage", "targetname");
  var_2 = getspawner("bpgc_hostage_aq", "targetname");
  var_2 scripts\engine\sp\utility::add_spawn_function(::bpgc_hostage_aq, var_1);
  var_3 = getspawner("bpgc_hostage_civ", "targetname");
  var_3 scripts\engine\sp\utility::add_spawn_function(::bpgc_hostage_civ, var_1);
  var_4 = [];
  var_4[0] = var_2 scripts\engine\sp\utility::spawn_ai();
  var_4[1] = var_3 scripts\engine\sp\utility::spawn_ai();
  var_4[0].other = var_4[1];
  var_4[1].other = var_4[0];
  var_4[1] pushplayer(1);
  var_4[1].doavoidanceblocking = 0;
  scripts\engine\utility::flag_wait_any("truck_cleared", "bpgc_conf_aq_dead");
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_distance(var_4, var_1.origin, 150);
  scripts\engine\utility::flag_set("bpgc_hostage_started");
  setmusicstate("mx_embassy_basement");
}

bpgc_hostage_char(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(!isDefined(self.other))
    waitframe();

  self.other endon("death");
  thread bpgc_hostage_entrance(var_0);
  self waittill("start_checking_damage");
  thread bpgc_hostage_check_damage();

  while(!isDefined(self.idle_finished) && !isDefined(self.killed_early) && !isDefined(self.other.killed_early))
    waitframe();

  self notify("stop_checking_damage");
}

bpgc_hostage_entrance(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_checking_damage");
  self.other endon("death");
  scripts\engine\sp\utility::set_allowdeath(1);
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "bpgc_hostage_enter");
  scripts\engine\utility::flag_wait("bpgc_hostage_started");
  thread bpgc_hostage_bullet_shield();
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_enter");

  if(!isDefined(self.skip_idle)) {
    self.skip_idle = scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, 150);
    self.other.skip_idle = self.skip_idle;
  }

  if(!self.skip_idle)
    var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_idle");

  self.idle_finished = 1;
}

bpgc_hostage_bullet_shield() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_checking_damage");
  self.other endon("death");
  wait 3.0;

  if(isalive(self)) {
    scripts\common\ai::magic_bullet_shield();
    scripts\engine\sp\utility::set_allowdeath(0);
    self notify("start_checking_damage");
  }
}

bpgc_hostage_check_damage() {
  self endon("stop_checking_damage");
  scripts\engine\utility::waittill_any("damage", "bullethit");
  self.killed_early = 1;
}

bpgc_hostage_aq(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "bpgc_hostage_aq";
  self.ignoreme = 1;
  bpgc_hostage_char(var_0);

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  if(!isDefined(self.other) || !isalive(self.other) || isDefined(self.idle_finished) || isDefined(self.other.killed_early) && !isDefined(self.killed_early)) {
    scripts\engine\sp\utility::set_allowdeath(1);

    if(!isDefined(self.other) || !isalive(self.other))
      scripts\engine\sp\utility::anim_stopanimScripted();
    else
      var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_exit");

    self.ignoreme = 0;
    thread bpg_first_wave_enemy();
  } else {
    scripts\engine\sp\utility::clear_deathanim();
    self.skipdeathanim = 1;
    self.a.nodeath = 1;
    self.noragdoll = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_death");
    self.allowdeath = 1;
    scripts\engine\sp\utility::die();
  }
}

bpgc_hostage_civ(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "bpgc_hostage_civ";
  bpgc_hostage_char(var_0);

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  if(!isalive(self.other) || isDefined(self.other.killed_early) && !isDefined(self.killed_early)) {
    scripts\engine\utility::delaythread(0.25, scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think);
    self.allowdeath = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_exit");
    thread bpg_individual_civ_flee();
  } else {
    scripts\engine\sp\utility::clear_deathanim();
    self.skipdeathanim = 1;
    self.a.nodeath = 1;
    self.noragdoll = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "bpgc_hostage_death");
    self.allowdeath = 1;
    scripts\engine\sp\utility::die();
  }
}

bpgc_interrogation() {
  var_0 = scripts\engine\utility::getStruct("ap_bpgc_interrogation", "targetname");
  var_1 = getspawnerarray("bpgc_interrogation_civs");
  scripts\engine\sp\utility::array_spawn_function(var_1, ::bpgc_interrogation_civ, var_0);
  var_2 = getspawner("bpgc_interrogation_aq", "targetname");
  var_2 scripts\engine\sp\utility::add_spawn_function(::bpgc_interrogation_aq, var_0);
  var_3 = scripts\engine\sp\utility::array_spawn(var_1);
  var_3[var_3.size] = var_2 scripts\engine\sp\utility::spawn_ai();
  thread bpgc_interrogation_check_speed_up(var_3);
  scripts\engine\utility::flag_wait("bpgc_hostage_started");
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_and_visible_flag(var_3, "player_past_first_wave");
  scripts\engine\utility::flag_set("bpgc_interrogation_started");
}

bpgc_interrogation_civ(var_0) {
  if(!isDefined(var_0.civ_count))
    var_0.civ_count = 1;
  else
    var_0.civ_count++;

  self.animname = "bpgc_interrogation_civ_" + var_0.civ_count;
  var_0 scripts\common\anim::anim_first_frame_solo(self, "bpgc_interrogation");
  scripts\engine\utility::flag_wait("bpgc_interrogation_started");
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.no_friendly_fire_fail = 1;
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_interrogation");
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

bpgc_interrogation_aq(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "bpgc_interrogation_aq";
  var_0 scripts\common\anim::anim_first_frame_solo(self, "bpgc_interrogation");
  scripts\engine\utility::flag_wait("bpgc_interrogation_started");
  scripts\engine\sp\utility::set_allowdeath(1);
  var_0 scripts\common\anim::anim_single_solo(self, "bpgc_interrogation");
  level notify("bpgc_interrogation_anim_done");
  thread bpg_first_wave_enemy();
}

bpgc_interrogation_check_speed_up(var_0) {
  level endon("bpgc_interrogation_anim_done");
  var_0[2] endon("death");
  var_0[1] endon("death");
  var_0[0] endon("death");
  scripts\engine\utility::flag_wait("bpgc_interrogation_started");

  for(;;) {
    var_1 = distance2d(level.player.origin, var_0[2].origin);
    var_2 = scripts\engine\math::remap(var_1, 0, 600, 2.0, 1.0);
    scripts\sp\anim::anim_set_rate(var_0, "bpgc_interrogation", var_2);
    waitframe();
  }
}

bpg_closers() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    thread scripts\sp\maps\embassy\embassy_util.gsc::close_in_on_player();
    scripts\engine\utility::flag_waitopen("perfect_info");
    self notify("stop_closing");
    scripts\engine\sp\utility::set_goal_pos(self.origin);
    scripts\engine\sp\utility::set_goal_radius(level.default_goalradius);
    scripts\engine\utility::flag_wait("perfect_info");
    waitframe();
  }
}

bpg_individual_civ_flee() {
  self endon("death");
  self endon("entitydeleted");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::random(level.wall_truck_civ_hiding_spots));
  cleanup_wall_truck_civ();
}

bp_glass_vo() {
  level endon("reached_basement");
  scripts\engine\utility::flag_wait_any("bpg_combat_first_wave_defeated", "bpgc_reached_hallway_to_basement");
  scripts\engine\utility::flag_wait_any("bpg_combat_second_wave_defeated", "bpgc_reached_hallway_to_basement");
  thread bp_glass_price_vo();
  thread basement_vo();
}

bp_glass_price_vo() {
  level endon("halligan_scene_vo_start");
  scripts\engine\utility::flag_wait_all("bpg_combat_first_wave_defeated", "bpg_combat_second_wave_defeated");
  level.price thread scripts\engine\sp\utility::battlechatter_filter_off(["order", "reaction"]);
  level.price thread scripts\engine\sp\utility::battlechatter_probability(0);
  level.price scripts\engine\sp\utility::set_battlechatter(0);
  var_0 = scripts\sp\door::get_interactive_door("door_price_halligan");

  if(istrue(var_0.player_tried)) {
    return;
  }
  var_0 endon("trigger");
  wait 1.5;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_breach_offices_20");
  scripts\engine\utility::flag_wait("bpgc_price_to_basement");
}

basement_vo() {
  level endon("bas_price_stairs");
  level endon("reached_basement");
  scripts\engine\utility::flag_wait("halligan_scene_done");
  var_0 = ["dx_vom_pri_breach_offices_80", "dx_vom_pri_breach_offices_70", "dx_vom_pri_breach_offices_60"];

  for(;;) {
    foreach(var_2 in var_0) {
      wait 15;
      level.price thread scripts\engine\sp\utility::smart_dialogue(var_2);
      level.price notify("stop_loop_price");
      level.price scripts\common\anim::anim_single_solo(level.price, "halligan_end_nag");
      level.price thread scripts\common\anim::anim_loop_solo(level.price, "halligan_end_idle", "stop_loop_price");
    }
  }
}

laststand_bypassed() {
  scripts\engine\utility::flag_wait("ground_enemy_bypassed");
  level.player notify("ground_enemy_bypassed");
}

basement_price_vo() {
  scripts\engine\utility::waittill_any_ents(self, "death", level.player, "ground_enemy_bypassed");

  if(!scripts\engine\utility::flag("ground_enemy_bypassed"))
    wait 2;

  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_basement_traverse_42");
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_alx_basement_traverse_44");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_basement_traverse_46");
}

basement_enemy_vo() {
  scripts\engine\utility::flag_wait("start_basement_enemy_vo");
  thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_basement_traverse_06");
  level waittill("stop_basement_vo");
  self stopsounds();
}

mx_price_door() {
  wait 3.5;
  setmusicstate("mx_embassy_price_door");
}

basement_enemy_sfx() {
  scripts\engine\utility::flag_wait("start_basement_enemy_vo");
  var_0 = scripts\engine\utility::getStruct("int_saferoom_enter", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  wait 0.3;
  var_1 thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_us3_marine_execution_10");
  wait 1.1;
  var_1 playSound("scn_embassy_basement_execution_gunshots");
  wait 5;
  var_1 delete();
}

bpgc_price_halligan_pre_gesture(var_0, var_1) {
  wait(var_1);

  while(!var_0.player_tried) {
    level.price thread scripts\asm\gesture::ai_request_gesture("military_point", var_0, 10.0);
    level.price waittill("started_speaking");
  }

  level.price scripts\asm\gesture::ai_cancel_gesture();
}

bpgc_price_halligan_scene() {
  var_0 = scripts\engine\utility::getStruct("ap_price_halligan", "targetname");
  var_1 = scripts\sp\door::get_interactive_door("door_price_halligan");
  var_1.open_struct.radius = 0.0;
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::anim_first_frame_door(var_1, "halligan_scene");
  var_1.player_tried = 0;
  var_1 thread bpgc_price_halligan_scene_check_player_tries_door();
  scripts\engine\utility::flag_wait_all("bpg_combat_first_wave_defeated", "bpg_combat_second_wave_defeated");
  scripts\engine\utility::flag_wait("bpgc_price_to_basement");
  var_2 = 4;
  thread bpgc_price_halligan_pre_gesture(var_1, var_2);
  var_3 = ["dx_vom_pri_basement_traverse_23", "dx_vom_pri_basement_traverse_22", "dx_vom_pri_basement_traverse_21"];
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::nagtill_delayed(var_2, "basement_door_triggered", var_3, 10);

  if(!var_1.player_tried)
    var_1 waittill("trigger");

  level notify("basement_door_triggered");
  thread bpgc_halligan_scene_vo();
  level.price.disableplayeradsloscheck = 1;
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "halligan_scene");
  scripts\engine\sp\utility::autosave_by_name("basement_start");
  var_1 scripts\engine\utility::delaythread(1.3, scripts\sp\door::remove_open_prompts);
  var_1 scripts\engine\utility::delaythread(1.3, scripts\game\sp\door::remove_door_snake_cam_ability);
  var_4 = scripts\engine\sp\utility::spawn_targetname("aq_price_halligan", 1);
  var_4 scripts\engine\sp\utility::clear_deathanim();
  var_4.animname = "enemy";
  var_4.skipdeathanim = 1;
  var_4.a.nodeath = 1;
  var_4.noragdoll = 1;
  var_4.allowdeath = 0;
  var_4 scripts\sp\utility::context_melee_allow(0);
  var_4 scripts\common\ai::magic_bullet_shield();
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::anim_door(var_1, "halligan_scene");
  var_0 thread bpgc_price_halligan_scene_aq_death(var_4, "halligan_scene");
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::anim_single_solo_end_notify("price_anim_done", level.price, "halligan_scene");
  thread mx_price_door();
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::halligan_draw();

  while(!isDefined(level.halligan_breakout))
    waitframe();

  var_5 = scripts\engine\utility::waittill_any_ents_return(level.price, "price_anim_done", var_4, "damage");

  if(var_5 == "damage") {
    if(isDefined(level.halligan_breakout)) {
      var_4 notify("breaking_out");
      thread bpgc_halligan_breakout_vo();

      if(level.halligan_breakout == "breakout_a") {
        var_0 thread bpgc_price_halligan_scene_aq_death(var_4, "halligan_breakout_a");
        var_0 scripts\common\anim::anim_single_solo(level.price, "halligan_breakout_a");
      } else {
        var_0 thread bpgc_price_halligan_scene_aq_death(var_4, "halligan_breakout_b");
        var_0 scripts\common\anim::anim_single_solo(level.price, "halligan_breakout_b");
      }
    } else
      level.price waittill("price_anim_done");
  }

  scripts\engine\utility::flag_set("halligan_scene_done");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::halligan_stow();

  if(!scripts\engine\utility::flag("bas_price_stairs"))
    level.price thread scripts\common\anim::anim_loop_solo(level.price, "halligan_end_idle", "stop_loop_price");

  scripts\engine\utility::flag_wait("bas_price_stairs");
  var_6 = getEnt("bas_hal_player_blocker", "targetname");
  var_6.origin = var_6.origin + (0, 0, 160);
  var_7 = getnode("bas_price_stairs_cover", "targetname");

  while(!scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.price.origin, var_7.origin, 60))
    waitframe();

  var_0 scripts\sp\maps\embassy\embassy_util.gsc::anim_door(var_1, "halligan_scene_reverse");
  thread saferoom_screens();
  var_6 delete();
}

bpgc_halligan_breakout_vo() {
  wait 0.8;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_basement_halligan_60", 1);
}

bpgc_halligan_scene_vo() {
  level notify("halligan_scene_vo_start");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_basement_halligan_10");
  var_0 = scripts\sp\door::get_interactive_door("door_price_halligan");

  if(level.price.origin[1] < var_0.origin[1])
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_wolf_escapes_outro_40");

  while(level.price.origin[1] < var_0.origin[1])
    waitframe();

  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_basement_halligan_20");
}

bpgc_price_halligan_scene_aq_death(var_0, var_1) {
  var_0 endon("breaking_out");
  scripts\common\anim::anim_single_solo(var_0, var_1);
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0.allowdeath = 1;
  var_0 scripts\engine\sp\utility::die();
}

bpgc_price_halligan_scene_check_player_tries_door() {
  self waittill("trigger");
  self.player_tried = 1;
}

bp_glass_combat_catchup() {
  if(!scripts\sp\starts::is_after_start("infil_saferoom"))
    thread saferoom_screens();
}

basement_bodies() {
  var_0 = getspawnerarray("bas_dead_bodies");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai();
    var_4 scripts\sp\fakeactor::drop_weapon(0);
    var_4.animname = "dead_body";
    var_4 notsolid();
    var_3 thread scripts\common\anim::anim_last_frame_solo(var_4, var_4.animation);
    var_1[var_1.size] = var_4;
  }

  scripts\engine\utility::flag_wait("saferoom_door_closed");

  foreach(var_4 in var_1)
  var_4 delete();
}

basement_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("basement_start", [level.player, level.price]);
  thread basement_bodies();
  thread audio_crowd_angry_outside(1);
  thread audio_post_truck_office_alarm_loop_start();
  thread sfx_basement_door_fire();
}

basement_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("Truck Office to Basement");
  thread basement_override_price_demeanor();
  thread basement_price();
  thread basement_aq();
  thread saferoom_setup_doors_and_ap();
  scripts\engine\utility::flag_wait("bas_price_boiler");
  scripts\engine\sp\utility::autosave_by_name("basement_mid");
  scripts\engine\utility::flag_wait("basement_aq_defeated");
}

basement_override_price_demeanor() {
  if(!scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, level.price.origin, 250)) {
    level.price.ignoreme = 1;
    level.price.dontattackme = 1;
    waitframe();
    var_0 = scripts\engine\utility::getStruct("basement_price_catchup", "targetname");
    level.price forceteleport(var_0.origin, var_0.angles, 900000);
  }

  while(!scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, level.price.origin, 250))
    wait 0.1;

  level.price.ignoreme = 0;
  level.price.dontattackme = 0;
  level.price scripts\common\utility::demeanor_override("cqb");
}

basement_price() {
  level endon("basement_aq_defeated");
  scripts\engine\utility::flag_wait("bas_price_stairs");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("bas_price_stairs_cover");
  level.price notify("stop_loop_price");
  level.price scripts\common\anim::anim_single_solo(level.price, "halligan_end_exit");
  scripts\engine\utility::flag_wait("bas_price_hallway");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("bas_price_hallway_cover");
  scripts\engine\utility::flag_wait("bas_price_boiler");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("bas_price_boiler_cover");
}

basement_aq() {
  var_0 = getspawner("sr_invader_last_stand", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(::basement_sr_last_stand);
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_2 = getspawner("sr_invader_crowguy", "targetname");
  var_2 scripts\engine\sp\utility::add_spawn_function(::basement_sr_crowguy);
  var_3 = [var_2 scripts\engine\sp\utility::spawn_ai()];
  var_3[0] thread basement_enemy_vo();
  thread basement_enemy_sfx();
  level waittill("door_scene_triggered");
  var_3[1] = scripts\engine\sp\utility::spawn_targetname("sr_invader");
  var_3[1] setgoalentity(level.player);
  var_3[1].goalradius = 100;
  level scripts\engine\sp\utility::waittill_dead(var_3);
  scripts\engine\utility::flag_set("basement_aq_defeated");
}

basement_sr_crowguy() {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "sr_invader_crowguy";
  self.anim_start_pct = 0.6;
  self.ignoreme = 1;
  var_0 = scripts\engine\utility::getStruct("ap_sr_door_buster", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("sr_crowbar");
  var_1 thread basement_sr_crowbar(var_0, self);
  var_0 thread scripts\common\anim::anim_single_solo(self, "sr_door_buster");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("sr_door_buster"), self.anim_start_pct);
  self setanimrate(scripts\engine\utility::getanim("sr_door_buster"), 0.0);
  scripts\sp\maps\embassy\embassy_util.gsc::wait_scene_on_screen_and_visible_flag([self], "reached_saferoom");
  level notify("door_scene_triggered");
  self.ignoreme = 0;
  scripts\engine\sp\utility::set_allowdeath(1);
  self setanimrate(scripts\engine\utility::getanim("sr_door_buster"), 1.0);
  self waittill("sr_door_buster");
  self setgoalentity(level.player);
  self.goalradius = 100;
}

basement_sr_crowbar(var_0, var_1) {
  var_0 thread scripts\common\anim::anim_single_solo(self, "sr_door_buster");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("sr_door_buster"), var_1.anim_start_pct);
  self setanimrate(scripts\engine\utility::getanim("sr_door_buster"), 0.0);
  level waittill("door_scene_triggered");
  thread basement_check_crowguy_death(var_1);
  self setanimrate(scripts\engine\utility::getanim("sr_door_buster"), 1.0);
  scripts\engine\utility::flag_wait("saferoom_door_closed");
  self delete();
}

basement_check_crowguy_death(var_0) {
  self endon("sr_door_buster");
  var_0 waittill("death");
  self setanimrate(scripts\engine\utility::getanim("sr_door_buster"), 2.0);
}

basement_sr_last_stand() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\ai::force_long_death_on_back_with_pistol(0);
  thread laststand_bypassed();
  thread basement_price_vo();
  scripts\engine\utility::flag_wait("saferoom_door_closed");
  self delete();
}

basement_catchup() {}

saferoom_setup_doors_and_ap() {
  level.ap_saferoom = scripts\engine\utility::getStruct("ap_saferoom", "targetname");
  level.sr_entrance_door = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("sr_entrance_door");
  level.sr_entrance_door scripts\engine\sp\utility::assign_animtree("sr_door");
  level.ap_saferoom thread scripts\common\anim::anim_first_frame_solo(level.sr_entrance_door, "sr_scene");
  level.sr_exit_door = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("sr_exit_door");
  level.sr_door_buzzer = scripts\engine\sp\utility::spawn_anim_model("sr_door_buzzer");
  level.ap_saferoom thread scripts\common\anim::anim_first_frame_solo(level.sr_door_buzzer, "saferoom_enter");
}

saferoom_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\sp\utility::set_start_location("saferoom_start", [level.player, level.price]);
  level.price scripts\common\utility::demeanor_override("cqb");
  saferoom_setup_doors_and_ap();
}

saferoom_main() {
  level.ap_cctv = scripts\engine\utility::getStruct("ap_cctv", "targetname");
  thread load_cctv_transient();
  thread saferoom_setup_mic();
  thread saferoom_price();
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("saferoom_card_reader");
  var_0 = ["dx_vom_pri_basement_traverse_50", "dx_vom_pri_basement_traverse_60"];
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::nagtill_delayed(8, "player_buzzing_saferoom", var_0, 12);
  var_1 = scripts\engine\utility::getStruct("int_saferoom_enter", "targetname");
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EMBASSY/USE_INTERCOM", 20, 500, 80, 0);
  var_1 thread scripts\sp\maps\embassy\embassy_util.gsc::cursor_hint_unusable_think();
  var_1 waittill("trigger");
  scripts\sp\utility::notetrack_mission_failed_vo_disable();

  while(!isalive(level.player))
    waitframe();

  scripts\engine\utility::flag_set("player_buzzing_saferoom");
  level.player scripts\engine\utility::delaycall(0.3, ::playsound, "scn_embassy_saferoom_buzzer_press");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_saferoom_wolf_on();
  thread mus_saferoom();
  thread saferoom_player_uses_buzzer();
  wait 2.75;
  level notify("stop_downstairs_office_alarm_loops");
  scripts\engine\utility::stop_exploder("heli_palm_fire");
  scripts\engine\utility::exploder("heli_palm_fire_die");
  scripts\engine\sp\utility::autosave_by_name("saferoom_start");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_wolf();
  level.wolf.anim_playvo_func = scripts\engine\utility::playsoundontag;
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");
  level.wolf thread scripts\sp\maps\embassy\embassy_util.gsc::wolf_friendly_fire_think();
  level.saferoom_last_nagger = level.price;
  level.ap_saferoom notify("stop_loop_price");
  thread saferoom_door();
  level.farah thread saferoom_scene_then_idle(0);
  level.hadir thread saferoom_scene_then_idle(0);
  level.wolf thread saferoom_scene_then_idle(0);
  level.alex thread saferoom_scene_then_idle(1);
  level.price thread saferoom_scene_then_idle(1);
  wait 24.0;
  var_2 = getEnt("sr_player_blocker", "targetname");
  var_2 scripts\engine\utility::delaycall(6.0, ::delete);
  level notify("obj_found_wolf");
  var_3 = scripts\engine\utility::getStruct("cctv_begin_interact", "targetname");
  var_3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EMBASSY/USE_CCTV", 20, 500, 80, 0);
  var_3 thread scripts\sp\maps\embassy\embassy_util.gsc::cursor_hint_unusable_think();
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_saferoom_wolf_off();
  var_3 waittill("trigger");

  while(!isalive(level.player))
    waitframe();

  scripts\engine\utility::flag_set("obj_using_cctv");
  level.wolf.anim_playvo_func = undefined;
  level.price.anim_playvo_func = undefined;
  level scripts\engine\utility::delaythread(4.5, scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter, "dx_vom_amba_cctv_01_intro_20", 1);
  scripts\engine\utility::noself_delaycall(4.1, ::visionsetnaked, "rc_color_glitch", 0.5);
  level.ap_cctv scripts\common\anim::anim_first_frame_solo(level.player.rig, "cctv_enter");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.25, 0, 0, 0, 0);
  level.ap_cctv thread scripts\common\anim::anim_single_solo(level.cctv_mic, "cctv_enter");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_safehouse_mic();
  level.ap_cctv scripts\common\anim::anim_single_solo(level.player.rig, "cctv_enter");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.price delete();
  level.farah delete();
  level.alex delete();
  level.hadir delete();

  if(isDefined(level.wolf.handcuffs))
    level.wolf.handcuffs delete();

  level.wolf delete();
  var_4 = level.player.primaryweapons[0];
  var_5 = level.player getweaponammoclip(var_4);
  var_6 = weaponclipsize(var_4);
  var_7 = var_5 / var_6;

  if(var_7 < 0.5) {
    var_8 = 0.5 - var_7;
    level.player setweaponammoclip(var_4, int(var_8 * var_6));
  }

  thread scripts\sp\analytics::analytics_kleenex_update("Basement to CCTV");
  scripts\engine\utility::delaythread(3.0, ::saferoom_escape_screens);
  scripts\sp\utility::notetrack_mission_failed_vo_enable();
}

load_cctv_transient() {
  waitframe();
  loadtransient("embassy_building_cctv_tr");
}

saferoom_player_uses_buzzer() {
  level.ap_saferoom scripts\common\anim::anim_first_frame_solo(level.player.rig, "saferoom_enter");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.25, 0, 0, 0, 0);
  level.ap_saferoom thread scripts\common\anim::anim_single_solo(level.sr_door_buzzer, "saferoom_enter");
  level.ap_saferoom scripts\common\anim::anim_single_solo(level.player.rig, "saferoom_enter");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\engine\utility::flag_wait("obj_using_cctv");
  level.sr_door_buzzer delete();
  level.sr_door_buzzer = undefined;
}

saferoom_screens() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_cctv_enter", 1, 1);
}

saferoom_setup_mic() {
  level.cctv_mic = getEnt("cctv_mic", "targetname");
  level.cctv_mic scripts\engine\sp\utility::assign_animtree("cctv_mic");
  level.ap_cctv scripts\common\anim::anim_first_frame_solo(level.cctv_mic, "cctv_enter");
}

saferoom_price() {
  level.ap_saferoom endon("stop_loop_price");
  thread saferoom_teleport_price();
  thread saferoom_price_reach_or_skip();
  scripts\engine\utility::flag_wait_any("player_buzzing_saferoom", "price_reached_saferoom");
  level notify("price_starting_saferoom_enter");
  level.ap_saferoom scripts\common\anim::anim_single_solo(level.price, "sr_enter");
  level.ap_saferoom thread scripts\common\anim::anim_loop_solo(level.price, "sr_enter_idle", "stop_loop_price");
}

mus_saferoom() {
  wait 0.1;
  setmusicstate("");
}

saferoom_price_reach_or_skip() {
  level endon("player_buzzing_saferoom");
  level.ap_saferoom scripts\sp\anim::anim_reach_solo(level.price, "sr_enter");
  scripts\engine\utility::flag_set("price_reached_saferoom");
}

saferoom_teleport_price() {
  level endon("price_starting_saferoom_enter");
  level.catchup_struct = scripts\engine\utility::getStruct("saferoom_price_catchup", "targetname");

  while(saferoom_price_behind_catchup() && saferoom_player_aware_of_teleport())
    wait 0.1;

  if(saferoom_price_behind_catchup())
    level.price forceteleport(level.catchup_struct.origin, level.catchup_struct.angles, 900000);
}

saferoom_price_behind_catchup() {
  return !scripts\engine\utility::within_fov(level.catchup_struct.origin, level.catchup_struct.angles, level.price.origin, cos(90));
}

saferoom_player_aware_of_teleport() {
  var_0 = scripts\engine\utility::within_fov(level.catchup_struct.origin, level.catchup_struct.angles, level.player.origin, cos(90));
  var_1 = distance2dsquared(level.player.origin, level.catchup_struct.origin) < squared(280);
  var_2 = scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(level.catchup_struct.origin);
  return !var_0 || var_1 && var_2;
}

saferoom_scene_then_idle(var_0) {
  self endon("death");
  self endon("entitydeleted");
  level.ap_saferoom scripts\common\anim::anim_single_solo(self, "sr_scene");
  level.ap_saferoom thread scripts\common\anim::anim_loop_solo(self, "sr_scene_idle", "stop_loop_" + self.animname);

  if(var_0) {
    level.saferoom_last_nag_time = gettime();
    var_1 = 15;

    for(;;) {
      while(level.saferoom_last_nagger == self || !scripts\engine\utility::time_has_passed(level.saferoom_last_nag_time, var_1))
        wait 1;

      level.ap_saferoom notify("stop_loop_" + self.animname);
      level.ap_saferoom scripts\common\anim::anim_single_solo(self, "sr_scene_idle_nag");
      level.ap_saferoom thread scripts\common\anim::anim_loop_solo(self, "sr_scene_idle", "stop_loop_" + self.animname);
      level.saferoom_last_nag_time = gettime();
      level.saferoom_last_nagger = self;
      waitframe();
    }
  } else if(self != level.wolf) {
    for(;;) {
      if(scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, 50)) {
        level.ap_saferoom notify("stop_loop_" + self.animname);

        if(self == level.hadir) {
          level.ap_saferoom notify("stop_loop_" + level.wolf.animname);
          level.ap_saferoom thread scripts\common\anim::anim_single_solo(level.wolf, "sr_scene_react");
        }

        level.ap_saferoom scripts\common\anim::anim_single_solo(self, "sr_scene_react");

        if(self == level.hadir)
          level.ap_saferoom thread scripts\common\anim::anim_loop_solo(level.wolf, "sr_scene_idle", "stop_loop_" + level.wolf.animname);

        level.ap_saferoom thread scripts\common\anim::anim_loop_solo(self, "sr_scene_idle", "stop_loop_" + self.animname);
        wait(randomfloatrange(3.0, 6.0));
      }

      waitframe();
    }
  }
}

saferoom_door() {
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "scn_embassy_saferoom_door_open");
  thread saferoom_door_delay_notify_for_keypad();
  level.ap_saferoom scripts\common\anim::anim_single_solo(level.sr_entrance_door, "sr_scene");

  while(distance2dsquared(level.player.origin, level.ap_cctv.origin) > squared(250))
    waitframe();

  level.sr_entrance_door clearanim(level.sr_entrance_door scripts\engine\utility::getanim("sr_scene"), 0.2);
  waitframe();
  level.sr_entrance_door rotateTo((0, -270, 0), 0.5, 0.1, 0.1);
  wait 0.5;
  scripts\engine\utility::flag_set("saferoom_door_closed");
  killmayhem("truck_crash_desk");
}

saferoom_door_delay_notify_for_keypad() {
  wait 0.1;
  level notify("card_reader_swap");
}

saferoom_escape_screens() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_cctv_exit_loop", 1, 1);
}

saferoom_catchup() {
  level.sr_exit_door = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door("sr_exit_door");
  var_0 = getEnt("sr_player_blocker", "targetname");
  var_0 delete();

  if(!scripts\sp\starts::is_after_start("escape_combat"))
    thread saferoom_escape_screens();
}

escape_start() {}

escape_main() {
  if(!isDefined(level.ap_cctv))
    level.ap_cctv = scripts\engine\utility::getStruct("ap_cctv", "targetname");

  while(!isDefined(level.sr_exit_door))
    waitframe();

  thread scripts\sp\analytics::analytics_kleenex_update("CCTV");
  var_0 = getEntArray("alley_cars", "targetname");
  scripts\engine\utility::array_call(var_0, ::show);
  var_1 = getaiarray("axis");
  scripts\engine\utility::array_delete(var_1);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_wolf();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  thread audio_cctv_mix_clear();
  scripts\engine\utility::delaythread(2, ::disable_slow_aim);
  level.wolf thread scripts\sp\maps\embassy\embassy_util.gsc::wolf_friendly_fire_think();
  scripts\engine\sp\utility::set_start_location("escape_start", [level.player, level.price, level.farah, level.alex, level.hadir, level.wolf, level.stacy]);
  scripts\engine\utility::delaythread(0.05, scripts\engine\sp\utility::transient_unload, "embassy_building_cctv_tr");
  level.player thread scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player thread scripts\sp\player::player_movement_state("cqb");
  level.sr_exit_door.angles = level.sr_exit_door.angles + (0, 120, 0);
  level.ap_gar_meetup = scripts\engine\utility::getStruct("emb_gar_meetup", "targetname");
  thread escape_price_crew_door("es_price_rendezvous_door", "garage_enter_door");
  thread escape_price_crew_door("es_price_rendezvous_door2", "garage_enter_door2");
  thread escape_garage_exit_door();
  thread escape_garage_keycard();
  thread esc_garage_vo();
  scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::autosave_by_name, "escape");
  level notify("obj_cctv_done");
  thread mus_garage();
  thread escape_kyle_third_person();
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_escape_start();
  level.ap_cctv thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "cctv_exit");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0, 0, 0, 0, 0);
  level.ap_cctv scripts\common\anim::anim_single_solo(level.player.rig, "cctv_exit");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  var_2 = [level.price, level.farah, level.wolf, level.hadir, level.alex, level.stacy];
  scripts\engine\utility::array_thread(var_2, ::escape_enter_to_idle);
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");
  scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("es_price_rendezvous_door_reader");
  scripts\engine\utility::flag_wait("heroes_at_exit");
  var_3 = getEnt("bas_player_blocker", "targetname");
  var_3 delete();
  var_4 = scripts\engine\utility::getStruct("int_gar_exit", "targetname");
  var_4 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EMBASSY/USE_KEYCARD", 20, 500, 80, 0);
  var_4 thread scripts\sp\maps\embassy\embassy_util.gsc::cursor_hint_unusable_think();
  level notify("obj_rendezvous_at_exit_complete");
  var_4 waittill("trigger");

  while(!isalive(level.player))
    waitframe();

  scripts\engine\utility::flag_set("reached_garage_exit");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::lt_garage_keycard();
  level.sr_exit_door.angles = level.sr_exit_door.angles - (0, 120, 0);
}

audio_cctv_mix_clear() {
  level.player clearclienttriggeraudiozone(0.1);
  level.player clearsoundsubmix("embassy_cctv_filter", 0.5);
}

mus_garage() {
  wait 6.0;
  setmusicstate("mx_embassy_garage");
}

escape_kyle_third_person() {
  var_0 = getspawner("kyle", "targetname");
  var_0.count = 10;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.kyle scripts\engine\sp\utility::name_hide();
  hidecinematicletterboxing(0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  scripts\engine\utility::noself_delaycall(2.5, ::getrandomnodedestination, 1.5, 0);
  level.ap_cctv scripts\common\anim::anim_single_solo(level.kyle, "cctv_exit");
  level.player scripts\common\utility::allow_cinematic_motion(1);
  level.kyle delete();
}

disable_slow_aim() {
  level.player disableslowaim();
}

esc_embassy_fallen_vo() {
  wait 2;
  level scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_us1_basement_traverse_02");

  if(!istrue(level.price.skip_fallen_vo))
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_basement_traverse_10");

  if(!istrue(level.price.skip_fallen_vo))
    level scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_us1_basement_traverse_20");
}

esc_garage_vo() {
  level.player endon("death");
  level endon("reached_garage_exit");
  thread esc_embassy_fallen_vo();
  scripts\engine\utility::flag_wait("reached_rendezvous");
  wait 3;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_far_escape_garage_30");
  level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_stac_escape_garage_40");
  level.price.skip_fallen_vo = 1;
  wait 2;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_escape_garage_50");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_escape_garage_60");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_escape_garage_70");
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_had_escape_garage_80");
  wait 0.5;
  wait 2;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_far_escape_garage_110");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_escape_garage_120");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_escape_garage_130");
  level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_stac_escape_garage_140");
  scripts\engine\utility::flag_set("heroes_at_exit");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_alx_escape_garage_150");
  var_0 = ["dx_vom_pri_escape_garage_160", "dx_vom_pri_escape_garage_170", "dx_vom_pri_escape_garage_180"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  var_0 = ["dx_vom_pri_escape_garage_190", "dx_vom_pri_escape_garage_200", "dx_vom_pri_escape_garage_210", "dx_vom_pri_escape_garage_220"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_2.autoshuffle = 1;
  var_3 = 5;
  var_4 = 0.5;
  var_5 = 1.2;
  var_6 = 1.65;
  var_7 = 20;
  var_8 = 5;

  for(;;) {
    if(distance2dsquared(level.player.origin, level.price.origin) > squared(500))
      var_9 = var_1 scripts\engine\sp\utility::deck_draw();
    else
      var_9 = var_2 scripts\engine\sp\utility::deck_draw();

    level.price scripts\sp\maps\embassy\embassy_util.gsc::say(var_9);
    wait(randomfloatrange(var_3 - var_4, var_3 + var_4));
    var_3 = min(var_3 * var_5, var_7);
    var_4 = min(var_4 * var_6, var_8);
  }
}

escape_price_crew_door(var_0, var_1) {
  var_2 = scripts\sp\maps\embassy\embassy_util.gsc::setup_office_door(var_0);
  var_2 scripts\engine\sp\utility::assign_animtree(var_1);

  if(!isDefined(level.ap_gar_meetup.doors))
    level.ap_gar_meetup.doors = [];

  level.ap_gar_meetup.doors[level.ap_gar_meetup.doors.size] = var_2;
  level.ap_gar_meetup thread scripts\common\anim::anim_first_frame_solo(var_2, "gar_meetup_enter");
  scripts\engine\utility::flag_wait("reached_rendezvous");
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(var_2, "gar_meetup_enter");
}

escape_enter_to_idle() {
  level.ap_gar_meetup thread scripts\common\anim::anim_first_frame_solo(self, "gar_meetup_enter");
  scripts\engine\utility::flag_wait("reached_rendezvous");
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(self, "gar_meetup_enter");

  if(!scripts\engine\utility::flag("reached_garage_exit") || scripts\engine\utility::flag("reached_garage_exit") && (self != level.price && self != level.farah))
    level.ap_gar_meetup thread scripts\common\anim::anim_loop_solo(self, "gar_meetup_idle", "stop_loop_" + self.animname);
}

escape_garage_exit_door() {
  var_0 = scripts\engine\utility::getStruct("es_parking_door", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("garage_door", var_0.origin, var_0.angles);
  var_1.clip = getEnt("es_parking_door_clip", "targetname");
  var_1.clip linkTo(var_1);
  level.ap_gar_meetup scripts\common\anim::anim_first_frame_solo(var_1, "gar_meetup_exit");
  scripts\engine\utility::flag_wait("reached_garage_exit");
  var_1 thread audio_garage_door_roll_up();
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(var_1, "gar_meetup_exit");
  scripts\engine\utility::flag_wait("defend_entrance_door_closed");
  var_1 delete();
}

audio_garage_door_roll_up() {
  wait 4.1;
  self playSound("emb_garage_open_start");
  self playLoopSound("emb_garage_open_lp");
  wait 5.0;
  self playSound("emb_garage_open_stop");
  wait 0.25;
  self stoploopsound();
}

escape_garage_keycard() {
  level.ap_gar_meetup.keycard = scripts\engine\sp\utility::spawn_anim_model("keycard");
  level.ap_gar_meetup scripts\common\anim::anim_first_frame_solo(level.ap_gar_meetup.keycard, "gar_meetup_enter");
  scripts\engine\utility::flag_wait("reached_rendezvous");
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.ap_gar_meetup.keycard, "gar_meetup_enter");
  level.ap_gar_meetup scripts\common\anim::anim_loop_solo(level.ap_gar_meetup.keycard, "gar_meetup_idle", "stop_loop_" + level.ap_gar_meetup.keycard.animname);
}

escape_catchup() {
  if(!scripts\sp\starts::is_after_start("residence_arrival"))
    level.sr_exit_door rotateYaw(-110, 0.1, 0.01, 0.01);
  else
    level.sr_exit_door delete();

  var_0 = getEnt("bas_player_blocker", "targetname");
  var_0 delete();
  scripts\engine\utility::flag_set("reached_garage_exit");
}

escape_combat_start() {
  level.ap_gar_meetup = scripts\engine\utility::getStruct("emb_gar_meetup", "targetname");
  level.ap_gar_meetup.keycard = scripts\engine\sp\utility::spawn_anim_model("keycard");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_wolf();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  level.wolf thread scripts\sp\maps\embassy\embassy_util.gsc::wolf_friendly_fire_think();
  scripts\engine\sp\utility::set_start_location("escape_combat_start", [level.player, level.price, level.farah, level.alex, level.hadir, level.wolf, level.stacy]);

  foreach(var_1 in [level.wolf, level.hadir, level.stacy, level.alex])
  level.ap_gar_meetup thread scripts\common\anim::anim_loop_solo(var_1, "gar_meetup_idle", "stop_loop_" + var_1.animname);

  scripts\engine\utility::flag_set("reached_garage_exit");
  thread escape_garage_exit_door();
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");
}

escape_combat_main() {
  scripts\engine\sp\utility::autosave_by_name("escape_exit");
  setsaveddvar("MQPQKNPQOK", 3);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", (-1, 0, 0));
  scripts\engine\utility::exploder("landing_car_explode");
  var_0 = getEntArray("middle_cars", "targetname");
  scripts\engine\utility::array_call(var_0, ::show);
  setmusicstate("mx_embassy_ground");
  thread periph_traffic("defend_entrance_door_closed");
  level.ap_gar_meetup thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "gar_meetup_exit");
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("es_garage_exit_reader");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.5, 0, 0, 0, 0);
  thread esc_com_vo();
  thread esc_com_price();
  thread esc_com_farah();
  thread esc_com_stacy();
  thread esc_com_keycard();
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.player.rig, "gar_meetup_exit");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.player thread scripts\sp\player::player_movement_state("default");
  scripts\engine\sp\utility::autosave_by_name("escape_combat");
  level.esc_com_aq = [];
  thread esc_com_aq_garage_courtyard();
  thread esc_com_aq_courtyard();
  thread esc_com_aq_courtyard_exit();
  thread esc_com_aq_alley_start();
  thread alley_life_door();
  thread alley_life_kids();
  thread alley_life_tv();
  level waittill("final_aq_spawned");

  while(level.esc_com_aq.size > 0) {
    level waittill("aq_died");
    level.esc_com_aq = scripts\engine\utility::array_removedead(level.esc_com_aq);
  }

  level.esc_com_aq = undefined;
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\utility::flag_wait("reached_alley");
  level notify("combat_done");
}

esc_com_vo() {
  level.player endon("death");
  wait 4.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_pri_escape_combat_streets_30");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_escape_combat_streets_40");
  scripts\engine\utility::waittill_any_ents_array(getaiarray(), "weapon_fired");
  wait 0.2;
  level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_stac_escape_combat_streets_100");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_escape_combat_streets_20");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_courtyard");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_escape_combat_streets_50");
  thread price_rally_nags();
  thread esc_com_enemy_vo();
  var_0 = undefined;

  while(getaiarray("axis").size > 1)
    level waittill("ai_killed", var_0);

  level notify("esc_com_cleared");
  wait 0.4;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.6, 4);
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_alley_moving_10");
}

esc_com_enemy_vo() {
  level endon("esc_com_cleared");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_courtyard");
  wait 3;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.6, 4);
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_escape_combat_streets_90");
}

price_rally_nags() {
  level endon("reached_wolf_escort_4");
  var_0 = ["dx_vom_pri_alley_moving_40", "dx_vom_pri_alley_moving_50", "dx_vom_pri_alley_moving_60"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_pri_escape_combat_streets_60", "dx_vom_pri_escape_combat_streets_70", "dx_vom_pri_escape_combat_streets_80"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_3 = 3;
  var_4 = 0.5;
  var_5 = 1.2;
  var_6 = 1.65;
  var_7 = 20;
  var_8 = 5;

  for(;;) {
    for(;;) {
      var_9 = randomfloatrange(var_3 - var_4, var_3 + var_4);
      var_10 = wait_in_position_or_timeout(level.price, var_9);

      if(!var_10) {
        break;
      }

      waitframe();
    }

    if(istrue(level.price.dontrallynag)) {
      continue;
    }
    if(getaiarray("axis").size == 1)
      var_11 = var_1 scripts\engine\sp\utility::deck_draw();
    else
      var_11 = var_2 scripts\engine\sp\utility::deck_draw();

    level.price scripts\sp\maps\embassy\embassy_util.gsc::say(var_11);
    var_3 = min(var_3 * var_5, var_7);
    var_4 = min(var_4 * var_6, var_8);
  }
}

wait_in_position_or_timeout(var_0, var_1) {
  while(var_1 > 0) {
    var_2 = var_0 scripts\engine\math::is_point_in_front(level.player.origin);
    var_3 = distance2dsquared(level.player.origin, var_0.origin) < squared(500);
    var_4 = scripts\engine\utility::array_remove(getaiarrayinradius(level.player.origin, 300, "axis"), level.wolf).size > 0;

    if(var_2 || var_3 || var_4)
      return 1;

    waitframe();
    var_1 = var_1 - 0.05;
  }

  return 0;
}

esc_com_aq_handler() {
  level.esc_com_aq[level.esc_com_aq.size] = self;

  if(self.classname == "actor_enemy_alq_desert_rifle" || self.classname == "actor_enemy_alq_desert_dmr")
    self.disablesniperbehaviors = 1;

  self.grenadeammo = 3;
  self.grenadesafedist = 300;
  scripts\engine\sp\utility::set_grenadeweapon("molotov");
  scripts\engine\sp\utility::set_goal_radius(150);
  thread esc_com_aq_alley_health_drop();
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  level notify("aq_died");
}

esc_com_aq_alley_health_drop() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("reached_alley");
  self.health = 1;
}

esc_com_aq_garage_courtyard() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("aq_esc_garage_courtyard", 1);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 thread esc_com_aq_handler();
  var_0.animname = "aq";
  var_0.allowdeath = 1;
  var_0 scripts\common\anim::anim_first_frame_solo(var_0, "garage_react");
  var_1 = gettime();

  while(!scripts\engine\utility::time_has_passed(var_1, 10.5) && !(scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(var_0.origin) && scripts\sp\maps\embassy\embassy_util.gsc::is_visible_to_player(var_0.origin + (0, 0, 60))))
    waitframe();

  var_0 scripts\common\anim::anim_single_solo(var_0, "garage_react");
  var_2 = getnode("aq_esc_garage_courtyard_exposed", "targetname");
  var_0 thread scripts\sp\spawner::go_to_node(var_2);
  var_0 scripts\engine\utility::waittill_any("damage", "bullethit");
  var_2 = getnode("aq_esc_garage_courtyard_cover", "targetname");
  var_0 scripts\sp\spawner::go_to_node(var_2);
}

esc_com_aq_courtyard() {
  var_0 = getEnt("spawn_aq_esc_courtyard", "targetname");
  var_0 waittill("trigger");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("aq_esc_courtyard", 1);

  foreach(var_3 in var_1)
  var_3 thread esc_com_aq_handler();
}

esc_com_aq_courtyard_exit() {
  var_0 = getEnt("spawn_aq_esc_courtyard_exit", "targetname");
  var_0 waittill("trigger");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("aq_esc_courtyard_exit", 1);

  foreach(var_3 in var_1)
  var_3 thread esc_com_aq_handler();

  heli_gate_molotov_helper("esc_com_magic_molotov_start", "esc_com_magic_molotov_end");
}

esc_com_aq_alley_start() {
  var_0 = getEnt("spawn_aq_esc_alley_start", "targetname");
  var_0 waittill("trigger");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("aq_esc_alley_start", 1);

  foreach(var_3 in var_1)
  var_3 thread esc_com_aq_handler();

  level notify("final_aq_spawned");
}

esc_com_keycard() {
  level.ap_gar_meetup notify("stop_loop_" + level.ap_gar_meetup.keycard.animname);
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.ap_gar_meetup.keycard, "gar_meetup_exit");
  level.ap_gar_meetup.keycard delete();
  level.ap_gar_meetup.keycard = undefined;
}

esc_com_stacy() {
  level.ap_gar_meetup notify("stop_loop_" + level.stacy.animname);
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.stacy, "gar_meetup_exit");
  level.ap_gar_meetup scripts\common\anim::anim_loop_solo(level.stacy, "gar_meetup_exit_idle", "stop_loop_" + level.stacy.animname);
}

esc_com_price() {
  level endon("combat_done");
  level.ap_gar_meetup notify("stop_loop_" + level.price.animname);
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.price, "gar_meetup_exit");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_p_courtyard_start");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_courtyard_exit");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_p_courtyard_exit");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_alley_start");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_p_alley_start");
  scripts\engine\utility::flag_wait("reached_alley");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_p_alley_prep");
}

esc_com_farah() {
  level endon("combat_done");
  level.ap_gar_meetup notify("stop_loop_" + level.farah.animname);
  level.ap_gar_meetup scripts\common\anim::anim_single_solo(level.farah, "gar_meetup_exit");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_f_courtyard_start");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_courtyard_exit");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_f_courtyard_exit");
  scripts\engine\utility::flag_wait("esc_com_pushed_to_alley_start");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_f_alley_start");
  scripts\engine\utility::flag_wait("reached_alley");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("esc_com_f_alley_prep");
}

escape_combat_catchup() {
  if(!scripts\sp\starts::is_after_start("residence_arrival"))
    thread periph_traffic("defend_entrance_door_closed");

  setsaveddvar("MQPQKNPQOK", 3);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", (-1, 0, 0));

  if(!scripts\sp\starts::is_after_start("residence_arrival"))
    scripts\engine\utility::exploder("landing_car_explode");

  scripts\engine\utility::flag_set("reached_alley");
}

alley_start() {
  scripts\engine\utility::flag_set("reached_wolf_escort_1");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_wolf();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");
  level.wolf thread scripts\sp\maps\embassy\embassy_util.gsc::wolf_friendly_fire_think();
  scripts\engine\sp\utility::set_start_location("alley_start", [level.player, level.price, level.farah, level.alex, level.hadir, level.wolf, level.stacy]);
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.price scripts\engine\utility::set_movement_speed(120);
  level.farah scripts\engine\utility::set_movement_speed(120);
  thread alley_life_door();
  thread alley_life_kids();
  thread alley_life_tv();
}

alley_main() {
  scripts\engine\sp\utility::autosave_by_name("alley");
  thread load_compound_transient();
  thread alley_soccer_screens();
  thread scripts\sp\friendlyfire::reset_friendlyfire_participation();
  scripts\engine\utility::exploder("scaf_fires");
  level.ap_residence = scripts\engine\utility::getStruct("ap_residence", "targetname");
  thread alley_price();
  thread alley_farah();
  thread alley_wolf_escort();
  thread ally_vo();
  level.player thread scripts\sp\player::player_movement_state("cqb");
  var_0 = scripts\engine\utility::getStruct("int_residence_arrival", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("keycard", var_0.origin - (0, 0, 100), var_0.angles);
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EMBASSY/USE_KEYCARD", 20, 500, 80, 0);
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::cursor_hint_unusable_think();
  var_0 waittill("trigger");
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();

  while(!isalive(level.player))
    waitframe();

  scripts\engine\utility::flag_set("reached_residence_arrival");
  level.price scripts\engine\sp\utility::disable_dynamic_run_speed();
  level.farah scripts\engine\sp\utility::disable_dynamic_run_speed();
  level.price scripts\common\utility::clear_movement_speed();
  level.farah scripts\common\utility::clear_movement_speed();
  level.price.dontevershoot = 0;
  level.farah.dontevershoot = 0;
  level.price.disableplayeradsloscheck = 0;
  level.farah.disableplayeradsloscheck = 0;
  var_1 scripts\engine\utility::delaycall(30.0, ::delete);
}

alley_soccer_screens() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_soccer_tv", 1, 1);
}

ally_vo() {
  scripts\engine\utility::flag_wait("reached_alley_start");
  level.price.dontrallynag = 1;
  thread alley_children_vo();
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_alley_moving_20");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_alley_moving_30");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_alley_moving_70");
  scripts\engine\utility::flag_wait("reached_wolf_escort_4");
  wait 3;
  var_0 = ["dx_vom_pri_alley_compound_30", "dx_vom_pri_alley_compound_40", "dx_vom_pri_alley_compound_50", "dx_vom_pri_alley_compound_60"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("reached_residence_arrival", var_1, 12, 1.2);
}

alley_children_vo() {
  scripts\engine\utility::flag_wait("kids_done_talking");
  wait 1;
  level.alex thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_alley_moving_100");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_alley_moving_110");
  scripts\engine\utility::flag_wait("reached_alley_end");
  wait 1;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_alley_compound_10");
  level.price.dontrallynag = undefined;
}

load_compound_transient() {
  waitframe();
  loadtransient("embassy_compound_anims_tr");
  loadtransient("embassy_streets_field_tr");
}

alley_price() {
  level.ap_residence endon("stop_loop");
  level.price.disableplayeradsloscheck = 1;
  level.price scripts\engine\sp\utility::enable_dynamic_run_speed(level.farah, 50, 120, 250, 300, 200, -200);
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("alley_p_start");
  scripts\engine\utility::flag_wait("reached_alley_start");
  level notify("price_alley_life_door");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("alley_p_end");
  scripts\engine\utility::flag_wait("reached_alley_end");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("res_arrival_p_start");
  level.ap_residence scripts\sp\anim::anim_reach_solo(level.price, "res_arrival_enter");
  level.price scripts\engine\sp\utility::disable_dynamic_run_speed(170);
  level.ap_residence scripts\common\anim::anim_single_solo(level.price, "res_arrival_enter");
  level.ap_residence thread scripts\common\anim::anim_loop_solo(level.price, "res_arrival_idle", "stop_loop");
}

alley_price_life_door_aim(var_0) {
  wait 0.75;
  var_1 = level.price aigetdesiredspeed();

  if(var_1 < 200) {
    level.price.dontevershoot = 1;
    var_2 = level.player getEye();
    var_3 = vectorNormalize(var_0 getEye() - var_2) * 500;
    level.price scripts\sp\utility::aim_at(var_2 + var_3);
    wait(scripts\engine\math::remap(var_1, 0, 200, 1.5, 0.05));
    level.price scripts\sp\utility::stop_aiming();
    level.price.dontevershoot = 0;
  }
}

alley_price_arrival_aim() {
  level.price.dontevershoot = 1;
  var_0 = scripts\engine\utility::getStruct("res_arrival_p_aim_start", "targetname");
  level.price scripts\sp\utility::aim_at(var_0.origin);
  level.price scripts\sp\utility::move_aim_along_spline(var_0, 2.0);
  level.price scripts\sp\utility::stop_aiming();
  level.price.dontevershoot = 0;
}

alley_farah() {
  level.ap_residence endon("stop_loop");
  level.farah.disableplayeradsloscheck = 1;
  level.farah scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 50, 120, 250, 200, -200, -300);
  level.farah thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_node_targetname("alley_f_start");
  scripts\engine\utility::flag_wait("reached_alley_start");

  if(!scripts\engine\utility::flag("cue_alley_life_kids")) {
    var_0 = scripts\engine\utility::getStruct("ap_alley_life_kids", "targetname");
    var_0 scripts\sp\anim::anim_reach_solo(level.farah, "alley_life_kids");

    if(!scripts\engine\utility::flag("cue_alley_life_kids")) {
      scripts\engine\utility::flag_set("cue_alley_life_kids", level.farah);
      var_0 scripts\common\anim::anim_single_solo(level.farah, "alley_life_kids");
    }
  }

  level.farah thread scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("alley_f_end");
  scripts\engine\utility::flag_wait("reached_alley_end");

  if(level.farah aigetdesiredspeed() < 180)
    childthread alley_farah_aim();

  level.farah scripts\sp\maps\embassy\embassy_util.gsc::go_to_struct_targetname("res_arrival_f_start");
  level.ap_residence scripts\sp\anim::anim_reach_solo(level.farah, "res_arrival_enter");
  level.farah scripts\engine\sp\utility::disable_dynamic_run_speed(170);
  level.ap_residence scripts\common\anim::anim_single_solo(level.farah, "res_arrival_enter");
  level.ap_residence thread scripts\common\anim::anim_loop_solo(level.farah, "res_arrival_idle", "stop_loop");
}

alley_farah_aim() {
  wait 0.5;
  level.farah.dontevershoot = 1;
  var_0 = scripts\engine\utility::getStruct("res_arrival_f_aim_start", "targetname");
  level.farah scripts\sp\utility::aim_at(var_0.origin);
  level.farah scripts\sp\utility::move_aim_along_spline(var_0, 3.0);
  level.farah scripts\sp\utility::stop_aiming();
  level.farah.dontevershoot = 0;
}

alley_wolf_escort() {
  level.ap_residence endon("stop_loop");
  var_0 = [level.alex, level.wolf, level.stacy, level.hadir];
  scripts\engine\utility::flag_wait("reached_wolf_escort_1");
  var_1 = getEnt("player_blocker_wolf_traversal_1", "targetname");
  var_1.origin = var_1.origin + (0, 0, 256);

  if(isDefined(level.ap_gar_meetup)) {
    foreach(var_3 in var_0)
    level.ap_gar_meetup notify("stop_loop_" + var_3.animname);
  }

  childthread alley_wolf_escort_animate_then_idle(var_0, "ap_wolf_escort_1", "wolf_escort_1", "reached_wolf_escort_2");
  scripts\engine\utility::flag_wait("reached_wolf_escort_2");
  var_1 delete();
  childthread alley_wolf_escort_animate_then_idle(var_0, "ap_wolf_escort_2", "wolf_escort_2", "reached_wolf_escort_3");
  scripts\engine\utility::flag_wait("reached_wolf_escort_3");
  childthread alley_wolf_escort_animate_then_idle(var_0, "ap_wolf_escort_3", "wolf_escort_3", "reached_wolf_escort_4");
  scripts\engine\utility::flag_wait("reached_wolf_escort_4");
  childthread alley_wolf_escort_animate_then_idle(var_0, "ap_wolf_escort_4", "wolf_escort_4", "reached_residence_arrival");
  scripts\engine\utility::flag_wait("reached_residence_arrival");
  level.ap_wolf_escort notify("stop_loop");
}

alley_wolf_escort_animate_then_idle(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag(var_3)) {
    level endon(var_3);

    if(isDefined(level.ap_wolf_escort))
      level.ap_wolf_escort notify("stop_loop");

    level.ap_wolf_escort = scripts\engine\utility::getStruct(var_1, "targetname");
    level.ap_wolf_escort scripts\common\anim::anim_single(var_0, var_2 + "_enter");
    level.ap_wolf_escort thread scripts\common\anim::anim_loop(var_0, var_2 + "_idle", "stop_loop");
  }
}

alley_life_door() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("alley_life_door");
  var_1 = scripts\engine\utility::getStruct("ap_alley_life_door", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "alley_life_intro");
  level waittill("price_alley_life_door");
  var_2 = scripts\engine\sp\utility::spawn_targetname("civ_alley_life_door", 1);
  var_2.animname = "civ";
  var_2 thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  thread alley_price_life_door_aim(var_2);
  var_2 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_2 scripts\engine\utility::getanim("alley_life_intro"), 1.25);
  var_0 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_0 scripts\engine\utility::getanim("alley_life_intro"), 1.25);
  var_1 scripts\common\anim::anim_single([var_0, var_2], "alley_life_intro");
  var_2 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_2 scripts\engine\utility::getanim("alley_life"), 1.25);
  var_0 scripts\engine\utility::delaycall(0.05, ::setanimrate, var_0 scripts\engine\utility::getanim("alley_life"), 1.25);
  var_1 scripts\common\anim::anim_single([var_0, var_2], "alley_life");
  var_2 delete();
  scripts\engine\utility::flag_wait("defend_entrance_door_closed");
  var_0 delete();
}

alley_life_kids() {
  scripts\engine\utility::flag_wait("reached_alley");
  level.alley_life_kids_door show();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("kid_alley_life_kids", 1);

  foreach(var_3, var_2 in var_0) {
    var_2.animname = "kid_" + (var_3 + 1);
    var_2 thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  }

  var_4 = scripts\engine\utility::getStruct("ap_alley_life_kids", "targetname");
  level.alley_life_kids_door scripts\engine\sp\utility::assign_animtree("kids_gate");
  var_4 thread scripts\common\anim::anim_loop(var_0, "alley_life_kids_idle", "stop_loop");
  var_4 thread scripts\common\anim::anim_first_frame_solo(level.alley_life_kids_door, "alley_life_kids");
  thread alley_life_kids_player_firing_listener();
  thread alley_life_kids_player_distance_listener(var_4.origin);
  var_5 = scripts\engine\utility::flag_wait("cue_alley_life_kids");
  var_4 notify("stop_loop");
  var_4 thread scripts\common\anim::anim_single_solo(level.alley_life_kids_door, "alley_life_kids");
  scripts\engine\utility::array_thread(var_0, ::alley_life_kids_animate_then_delete, var_4);
  wait 0.8;

  if(isDefined(var_5) && var_5 == level.farah)
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_alley_moving_80", 1);
}

alley_life_kids_animate_then_delete(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "alley_life_kids");
  self delete();
}

alley_life_kids_player_firing_listener() {
  level endon("cue_alley_life_kids");
  scripts\engine\utility::flag_wait("reached_alley_start");
  level.player scripts\engine\utility::waittill_any("weapon_fired", "player_flash", "player_frag");
  scripts\engine\utility::flag_set("cue_alley_life_kids", level.player);
}

alley_life_kids_player_distance_listener(var_0) {
  level endon("cue_alley_life_kids");
  scripts\engine\utility::flag_wait("reached_alley_start");

  while(!alley_life_kids_player_within_distance(var_0))
    waitframe();

  scripts\engine\utility::flag_set("cue_alley_life_kids", level.player);
}

alley_life_kids_player_within_distance(var_0) {
  var_1 = 15625;
  var_2 = distance2dsquared(level.player.origin, var_0);
  var_3 = distance2dsquared(level.farah.origin, var_0);
  return var_2 < var_1 && var_3 > var_2;
}

alley_life_tv() {
  scripts\engine\utility::flag_wait("reached_alley_end");
  var_0 = scripts\engine\sp\utility::spawn_targetname("civ_alley_life_tv", 1);
  var_0.animname = "civ";
  var_0.player_fired = 0;
  var_0 thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  var_1 = scripts\engine\utility::getStruct("ap_alley_life_tv", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(var_0, "alley_life_tv_idle", "stop_loop");
  var_0 thread alley_life_tv_player_firing_listener();
  var_0 thread alley_life_tv_player_looking_listener(var_1.origin);
  scripts\engine\utility::flag_wait("cue_alley_life_tv");
  var_1 notify("stop_loop");
  var_1 thread scripts\common\anim::anim_single_solo(var_0, "alley_life_tv");

  if(!var_0.player_fired) {
    scripts\engine\utility::waittill_any_ents(var_1, "alley_life_tv", level, "tv_civ_fleeing");

    if(!var_0.player_fired)
      var_1 thread scripts\common\anim::anim_loop_solo(var_0, "alley_life_tv_idle", "stop_loop");
  }

  scripts\engine\utility::flag_wait_any("defend_entrance_door_closed", "tv_civ_fleeing");

  if(var_0.player_fired) {
    var_1 notify("stop_loop");
    var_1 thread scripts\common\anim::anim_loop_solo(var_0, "alley_life_tv_gun_react", "endor");
  }

  scripts\engine\utility::flag_wait("defend_entrance_door_closed");
  var_0 delete();
}

alley_life_tv_player_firing_listener() {
  level endon("tv_civ_fleeing");
  level endon("defend_entrance_door_closed");
  level.player scripts\engine\utility::waittill_any("weapon_fired", "player_flash", "player_frag");
  self.player_fired = 1;
  scripts\engine\utility::flag_set("cue_alley_life_tv");
  scripts\engine\utility::flag_set("tv_civ_fleeing");
  self stopanimScripted();
}

alley_life_tv_player_looking_listener(var_0) {
  level endon("cue_alley_life_tv");

  while(!(scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, var_0, 300) && scripts\sp\maps\embassy\embassy_util.gsc::within_player_fov(var_0)))
    waitframe();

  scripts\engine\utility::flag_set("cue_alley_life_tv");
}

alley_catchup() {}