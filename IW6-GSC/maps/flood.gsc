/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood.gsc
*****************************************************/

main() {
  checkpoint_setup();
  maps\_utility::template_level("flood");
  maps\createart\flood_art::main();
  maps\flood_fx::main();
  maps\flood_precache::main();
  thread common_scripts\_pipes::main();
  maps\_utility::transient_init("flood_intro_tr");
  maps\_utility::transient_init("flood_mid_tr");
  maps\_utility::transient_init("flood_end_tr");
  maps\_load::main();
  maps\_utility::set_console_status();
  maps\flood_audio::main();
  maps\flood_anim::main();
  maps\flood_fx::treadfx_override();
  mission_flag_inits();
  mission_precache();
  mission_mains();
  thread maps\flood_fx::fx_checkpoint_states();
  maps\_utility::set_wind(100, 0.1, 0.1);
  thread maps\flood_util::setup_palm_trees_in_rushing_water();
  thread maps\flood_coverwater::init_coverwater();
  thread maps\flood_util::setup_water_death();
  level.jkudebug = 0;
  level.cw_waterwipe_above = "waterline_above";
  level.cw_waterwipe_under = "waterline_under";
  level.player visionsetwaterforplayer("flood_underwater", 0);
  level.player maps\flood_util::set_water_fog("flood_underwater_murky");
  flood_default_water_transion_fx();
  thread mission_objectives();
  thread mission_object_control();
  level maps\_utility::delaythread(1.0, maps\_utility::set_team_bcvoice, "allies", "delta");
  level maps\_utility::delaythread(1.0, maps\_utility::set_team_bcvoice, "axis", "shadowcompany");
  setdvar("music_enable", 1);

  if(level.start_point == "infil")
    level thread flood_intro_screen();
}

checkpoint_setup() {
  maps\_utility::default_start(::infil_start);
  maps\_utility::set_default_start("infil");
  maps\_utility::add_start("infil", ::infil_start, "Infil", ::infil, "flood_intro_tr");
  maps\_utility::add_start("streets_to_dam", ::streets_to_dam_start, "Streets to Dam", ::streets_to_dam, "flood_intro_tr");
  maps\_utility::add_start("streets_to_dam_2", ::streets_to_dam_2_start, "Streets to Dam 2", ::streets_to_dam_2, "flood_intro_tr");
  maps\_utility::add_start("dam", ::dam_start, "Dam", ::dam, "flood_intro_tr");
  maps\_utility::add_start("flooding_ext", ::flooding_ext_start, "Exterior Flood", ::flooding_ext, "flood_intro_tr");
  maps\_utility::add_start("flooding_int", ::flooding_int_start, "Interior Flood", ::flooding_int, "flood_intro_tr");
  maps\_utility::add_start("mall", ::mall_start, "Mall", ::mall, "flood_mid_tr");
  maps\_utility::add_start("swept", ::swept_start, "Swept Away Event", ::swept, "flood_mid_tr");
  maps\_utility::add_start("roof_stealth", ::roof_stealth_start, "Stealth Moment", ::roof_stealth, "flood_mid_tr");
  maps\_utility::add_start("skybridge", ::skybridge_start, "Skybridge Event", ::skybridge, "flood_mid_tr");
  maps\_utility::add_start("rooftops", ::rooftops_start, "Rooftops", ::rooftops, "flood_mid_tr");
  maps\_utility::add_start("rooftop_water", ::rooftop_water_start, "Rooftop Water", ::rooftop_water, "flood_mid_tr");
  maps\_utility::add_start("debrisbridge", ::debrisbridge_start, "Debris Bridge", ::debrisbridge, "flood_mid_tr");
  maps\_utility::add_start("garage", ::garage_start, "Garage", ::garage, "flood_mid_tr");
  maps\_utility::add_start("ending", ::ending_start, "Ending", ::ending, "flood_mid_tr");
  maps\_utility::add_start("fly_around", ::fly_around_start, "Fly Around", ::fly_around, "flood_intro_tr");
}

mission_mains() {
  level thread maps\flood_infil::section_main();
  level thread maps\flood_streets::section_main();
  level thread maps\flood_chopper::section_main();
  level thread maps\flood_flooding::section_main();
  level thread maps\flood_mall::section_main();
  level thread maps\flood_swept::section_main();
  level thread maps\flood_roof_stealth::section_main();
  level thread maps\flood_rooftops::section_main();
  level thread maps\flood_garage::section_main();
  level thread maps\flood_ending::section_main();
}

mission_precache() {
  precacheitem("r5rgp");
  precacheitem("m9a1");
  precacheshader("cinematic");
  precacheshader("black");
  objective_string_precache();
  level thread maps\flood_infil::section_precache();
  level thread maps\flood_streets::section_precache();
  level thread maps\flood_chopper::section_precache();
  level thread maps\flood_flooding::section_precache();
  level thread maps\flood_mall::section_precache();
  level thread maps\flood_swept::section_precache();
  level thread maps\flood_roof_stealth::section_precache();
  level thread maps\flood_rooftops::section_precache();
  level thread maps\flood_garage::section_precache();
  level thread maps\flood_ending::section_precache();
  level thread maps\flood_anim::anim_precache();
}

mission_flag_inits() {
  level thread maps\flood_infil::section_flag_inits();
  level thread maps\flood_streets::section_flag_inits();
  level thread maps\flood_chopper::section_flag_inits();
  level thread maps\flood_flooding::section_flag_inits();
  level thread maps\flood_mall::section_flag_inits();
  level thread maps\flood_swept::section_flag_inits();
  level thread maps\flood_roof_stealth::section_flag_inits();
  level thread maps\flood_rooftops::section_flag_inits();
  level thread maps\flood_garage::section_flag_inits();
  level thread maps\flood_ending::section_flag_inits();
  common_scripts\utility::flag_init("intro_show_introtext");
  common_scripts\utility::flag_init("start_intro_sequence");
}

objective_string_precache() {
  precachestring(&"FLOOD_OBJ_FIND_LAUNCHERS");
  precachestring(&"FLOOD_OBJ_DISABLE_LAUNCHER");
  precachestring(&"FLOOD_OBJ_HIGHER_GROUND");
  precachestring(&"FLOOD_OBJ_REGROUP");
  precachestring(&"FLOOD_OBJ_FIND_BOSS");
  precachestring(&"FLOOD_OBJ_GET_TO_HOTEL");
  precachestring(&"FLOOD_OBJ_CAPTURE_BOSS");
  precachestring(&"FLOOD_INTROSCREEN_12_YEARS");
}

mission_objectives() {
  switch (level.start_point) {
    case "infil":
      wait 18.5;
      objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
    case "streets":
    case "streets_to_dam":
      if(level.start_point == "streets_to_dam")
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");

      common_scripts\utility::flag_wait_either("player_out_of_garage", "launcher_objective_given");
      objective_add(maps\_utility::obj("obj_disable_launcher"), "current", & "FLOOD_OBJ_DISABLE_LAUNCHER");
      level waittill("end_of_streets_to_dam");
      maps\_utility::objective_complete(maps\_utility::obj("obj_disable_launcher"));
    case "streets_to_dam_2":
      if(level.start_point == "streets_to_dam_2") {
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
        objective_add(maps\_utility::obj("obj_disable_launcher"), "done", & "FLOOD_OBJ_DISABLE_LAUNCHER");
      }
    case "dam":
      if(level.start_point == "dam") {
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
        objective_add(maps\_utility::obj("obj_disable_launcher"), "done", & "FLOOD_OBJ_DISABLE_LAUNCHER");
        common_scripts\utility::flag_init("launcher_2_objective_given");
      }

      common_scripts\utility::flag_wait_either("missiles_ready", "launcher_2_objective_given");
      objective_add(maps\_utility::obj("obj_disable_launcher_2"), "current", & "FLOOD_OBJ_DISABLE_NEXT_LAUNCHER");
      common_scripts\utility::flag_wait("start_flood");
      objective_state(maps\_utility::obj("obj_disable_launcher_2"), "failed");
      objective_delete(maps\_utility::obj("obj_find_boss"));
      wait 3.0;
      objective_add(maps\_utility::obj("obj_higher_ground"), "current", & "FLOOD_OBJ_HIGHER_GROUND");
    case "flooding_ext":
      if(level.start_point == "flooding_ext")
        objective_add(maps\_utility::obj("obj_higher_ground"), "current", & "FLOOD_OBJ_HIGHER_GROUND");
    case "flooding_int":
      if(level.start_point == "flooding_int")
        objective_add(maps\_utility::obj("obj_higher_ground"), "current", & "FLOOD_OBJ_HIGHER_GROUND");

      common_scripts\utility::flag_wait("player_at_stairs");
      objective_delete(maps\_utility::obj("obj_higher_ground"));
    case "mall":
      common_scripts\utility::flag_wait("stair_post_quake_vo_done");
      objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
    case "swept":
      if(level.start_point == "swept")
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
    case "roof_stealth":
      if(level.start_point == "roof_stealth")
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
    case "skybridge":
      if(level.start_point == "skybridge")
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
    case "rooftops":
      if(level.start_point == "rooftops")
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");

      common_scripts\utility::flag_wait("rooftops_vo_check_drop");
      wait 1.0;
      objective_add(maps\_utility::obj("obj_regroup"), "current", & "FLOOD_OBJ_REGROUP");
    case "rooftop_water":
      if(level.start_point == "rooftop_water") {
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
        objective_add(maps\_utility::obj("obj_regroup"), "current", & "FLOOD_OBJ_REGROUP");
      }
    case "debrisbridge":
      if(level.start_point == "debrisbridge") {
        objective_add(maps\_utility::obj("obj_find_boss"), "current", & "FLOOD_OBJ_FIND_BOSS");
        objective_add(maps\_utility::obj("obj_regroup"), "current", & "FLOOD_OBJ_REGROUP");
      }

      maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_1_trigger");
      wait 1.0;
      maps\_utility::objective_complete(maps\_utility::obj("obj_regroup"));
      wait 6.0;
      maps\_utility::objective_complete(maps\_utility::obj("obj_find_boss"));
      wait 1.0;
      objective_add(maps\_utility::obj("obj_get_to_hotel"), "current", & "FLOOD_OBJ_GET_TO_HOTEL");
    case "garage":
      if(level.start_point == "garage")
        objective_add(maps\_utility::obj("obj_get_to_hotel"), "current", & "FLOOD_OBJ_GET_TO_HOTEL");

      maps\_utility::wait_for_targetname_trigger("ending_heli_path");
      wait 4.0;
      maps\_utility::objective_complete(maps\_utility::obj("obj_get_to_hotel"));
    case "ending":
      wait 1.0;
      objective_add(maps\_utility::obj("obj_capture_boss"), "current", & "FLOOD_OBJ_CAPTURE_BOSS");
      common_scripts\utility::flag_wait("vignette_ending_qte_pickup_gun");
      common_scripts\utility::flag_wait("vignette_ending_qte_success");
      maps\_utility::objective_complete(maps\_utility::obj("obj_capture_boss"));
  }
}

mission_object_control() {
  mission_hide_at_start();
  thread maps\flood_rooftops::rooftops_cleanup_jumpto();
  setsaveddvar("r_hudoutlineenable", 1);
  setsaveddvar("r_hudOutlineWidth", 2);

  switch (level.start_point) {
    case "infil":
      thread maps\flood_util::hide_scriptmodel_by_targetname_array("embassy_hide");
      thread palm_tree_control(1);
      thread infil_object_hide();
      thread maps\flood_flooding::runback_death_toggle("off");
      level waittill("infil_done");
    case "streets":
      if(level.start_point == "streets") {
        thread maps\flood_util::hide_scriptmodel_by_targetname_array("embassy_hide");
        thread palm_tree_control();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      thread maps\flood_infil::infil_cleanup();
      thread maps\flood_util::hide_models_by_targetname("angry_flood_backstop", 1);
      level waittill("end_streets");
    case "streets_to_dam":
      if(level.start_point == "streets_to_dam") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_util::hide_models_by_targetname("angry_flood_backstop", 1);
        thread palm_tree_control();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      thread maps\flood_infil::tanks_cleanup_early();
      thread maps\flood_util::show_models_by_targetname("embassy_hide");
      level waittill("end_of_streets_to_dam");
    case "streets_to_dam_2":
      if(level.start_point == "streets_to_dam_2") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_util::hide_models_by_targetname("angry_flood_backstop", 1);
        thread palm_tree_control();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      thread maps\flood_streets::remove_streets_ents();
      thread streets_vehicle_show_after_knife_kill();
      thread infil_optimize_tree_cleanup();
      level waittill("end_of_streets_to_dam_2");
    case "dam":
      if(level.start_point == "dam") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_util::hide_models_by_targetname("angry_flood_backstop", 1);
        thread palm_tree_control();
        thread streets_vehicle_show_after_knife_kill();
        thread infil_optimize_tree_cleanup();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      common_scripts\utility::flag_wait("end_of_dam");
    case "flooding_ext":
      if(level.start_point == "flooding_ext") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread palm_tree_control();
        thread streets_vehicle_show_after_knife_kill();
        thread infil_optimize_tree_cleanup();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      thread maps\flood_infil::tanks_cleanup();
      thread maps\flood_util::show_models_by_targetname("angry_flood_backstop", 1);
      common_scripts\utility::flag_wait("player_warehouse_mantle");
    case "flooding_int":
      if(level.start_point == "flooding_int") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::show_models_by_targetname("angry_flood_backstop", 1);
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread palm_tree_control();
        thread maps\flood_flooding::runback_death_toggle("off");
      }

      thread mall_rooftop_object_hide();
      thread maps\flood_util::hide_scriptmodel_by_targetname("angry_flood_water_model");
      thread maps\flood_util::hide_models_by_targetname("embassy_hide");
      common_scripts\utility::flag_wait("player_at_stairs_stop_nag");
    case "mall":
      if(level.start_point == "mall") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_util::show_models_by_targetname("angry_flood_backstop", 1);
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread embassy_palms_cleanup();
      }

      thread hotel_parking_car_hide();
      wait 0.05;
      var_0 = vehicle_getarray();
      maps\_utility::array_delete(var_0);
      streets_script_vehicle_cleanup();

      if(!common_scripts\utility::flag("flood_mid_tr_loaded")) {
        thread maps\_utility::transient_unloadall_and_load("flood_mid_tr");
        common_scripts\utility::flag_wait("mall_breach_start");
        common_scripts\utility::flag_wait("flood_mid_tr_loaded");
      }

      level waittill("swept_away");
    case "swept":
      if(level.start_point == "swept") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread hotel_parking_car_hide();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread embassy_palms_cleanup();
        thread mall_rooftop_object_hide();
      }

      thread show_rushing_water_trees_infil_trees_cleanup(1);
      thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
      thread maps\flood_util::show_models_by_targetname("swept_underwater_cleanup");
      thread maps\flood_flooding::flooding_cleanup();
      thread maps\flood_mall::mall_delete_warehouse_ents();
      thread maps\flood_mall::mall_delete_rooftop_ents();
      thread maps\flood_util::hide_models_by_targetname("garage_facade");
      level waittill("swept_success");
    case "roof_stealth":
      if(level.start_point == "roof_stealth") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread hotel_parking_car_hide();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
      } else
        thread maps\flood_util::show_models_by_targetname("garage_facade");

      var_1 = getEntArray("script_vehicle_iveco_lynx", "classname");
      maps\_utility::array_delete(var_1);

      if(isDefined(level.skybridge_sections)) {
        maps\_utility::array_delete(level.skybridge_sections);
        level.skybridge_sections = [];
      }

      level.player waittill("mantle_used");
      var_2 = getcorpsearray();
      maps\_utility::array_delete(var_2);
      common_scripts\utility::flag_wait("skybridge_heli_go");
      common_scripts\utility::flag_wait("flood_mid_tr_loaded");
    case "skybridge":
      if(level.start_point == "skybridge") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread hotel_parking_car_hide();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
      }

      thread swept_cleanup();
      common_scripts\utility::flag_wait("skybridge_done");
    case "rooftops":
      if(level.start_point == "rooftops") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread hotel_parking_car_hide();
        thread swept_cleanup();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
      }

      thread maps\flood_roof_stealth::roof_stealth_cleanup();
      thread maps\flood_util::show_models_by_targetname("com_wall_fan_blade_rotate");
      common_scripts\utility::flag_wait("rooftops_done");
    case "rooftop_water":
      if(level.start_point == "rooftop_water") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread maps\flood_roof_stealth::roof_stealth_cleanup();
        thread hotel_parking_car_hide();
        thread swept_cleanup();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
        thread maps\flood_util::show_models_by_targetname("com_wall_fan_blade_rotate");
      }

      common_scripts\utility::flag_wait("rooftop_water_done");
    case "debrisbridge":
      if(level.start_point == "debrisbridge") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread maps\flood_roof_stealth::roof_stealth_cleanup();
        thread maps\flood_util::hide_models_by_targetname("garage_facade");
        thread swept_cleanup();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
        thread maps\flood_util::show_models_by_targetname("com_wall_fan_blade_rotate");
      }

      common_scripts\utility::flag_wait("debrisbridge_done");
    case "garage":
      if(level.start_point == "garage") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread maps\flood_roof_stealth::roof_stealth_cleanup();
        thread maps\flood_util::hide_models_by_targetname("garage_facade");
        thread swept_cleanup();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
        thread maps\flood_util::show_models_by_targetname("com_wall_fan_blade_rotate");
      }
    case "ending":
      if(level.start_point == "ending") {
        thread maps\flood_infil::infil_cleanup();
        thread maps\flood_infil::tanks_cleanup();
        thread maps\flood_infil::tanks_cleanup_early();
        thread maps\flood_streets::remove_streets_ents();
        thread maps\flood_streets::remove_streets_to_dam_ents();
        thread maps\flood_flooding::flooding_cleanup();
        thread maps\flood_mall::mall_delete_warehouse_ents();
        thread maps\flood_mall::mall_delete_rooftop_ents();
        thread maps\flood_roof_stealth::roof_stealth_cleanup();
        thread maps\flood_util::hide_models_by_targetname("embassy_hide");
        thread maps\flood_util::hide_models_by_targetname("garage_facade");
        thread swept_cleanup();
        thread maps\flood_flooding::angry_flood_cleanup();
        thread infil_optimize_tree_cleanup();
        thread show_rushing_water_trees_infil_trees_cleanup();
        thread embassy_palms_cleanup();
        thread maps\flood_util::show_models_by_targetname("rooftops_ambient_cars");
        thread maps\flood_util::show_models_by_targetname("com_wall_fan_blade_rotate");
      }

      common_scripts\utility::flag_wait("ending_transient_trigger");
      var_3 = getEntArray("script_model_garage_post_stuff_01", "targetname");

      foreach(var_5 in var_3)
      var_5 hide();

      maps\_utility::flavorbursts_off("allies");

      if(!(level.start_point == "ending")) {
        var_7 = getaiarray("axis");
        maps\_utility::array_delete(var_7);
      }

      var_8 = getEntArray("rooftops_ambient_cars", "targetname");
      maps\_utility::array_delete(var_8);
      var_9 = [];

      for(var_10 = 0; var_10 < 5; var_10++) {
        var_11 = getent("debris_bridge_car_" + var_10, "targetname");
        var_9 = common_scripts\utility::add_to_array(var_9, var_11);
      }

      maps\_utility::array_delete(var_9);
      var_0 = vehicle_getarray();
      maps\_utility::array_delete(var_0);
      thread maps\_utility::transient_unloadall_and_load("flood_end_tr");
      thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
      thread maps\flood_swept::swept_water_toggle("swim", "hide");
      thread maps\flood_swept::swept_water_toggle("ending_water", "hide");
      thread maps\flood_util::show_models_by_targetname("ending_window_frame");
      var_12 = getent("debris_ending_show", "targetname");
      var_12 show();
      common_scripts\utility::flag_wait("vignette_ending_crash_flag");
      thread maps\flood_swept::swept_water_toggle("ending_water", "show");
    case "fly_around":
      thread maps\flood_infil::tanks_cleanup();
      thread maps\flood_infil::tanks_cleanup_early();
  }
}

mission_hide_at_start() {
  thread streets_vehicle_hide_at_start();
  thread maps\flood_mall::mallroof_firstframe("hide");
  thread maps\flood_util::hide_scriptmodel_by_targetname_array("missile_launcher_2");
  thread maps\flood_util::hide_scriptmodel_by_targetname_array("ending_window_frame");
  thread maps\flood_util::hide_scriptmodel_by_targetname_array("com_wall_fan_blade_rotate");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
  thread maps\flood_swept::swept_water_toggle("ending_water", "hide");
  thread maps\flood_util::hide_models_by_targetname("swept_underwater_cleanup");
  thread maps\flood_util::hide_models_by_targetname("rooftops_ambient_cars");
  var_0 = getent("debris_ending_show", "targetname");
  var_0 hide();
}

infil_object_hide() {
  thread maps\flood_util::hide_models_by_targetname("infil_cleanup");
  thread maps\flood_util::hide_models_by_targetname("pipe_shootable");
  thread maps\flood_util::hide_models_by_targetname("stealth_bob");
  thread maps\flood_util::hide_models_by_targetname("warevolumes");
  thread maps\flood_util::hide_models_by_targetname("mall_ware_brush_hide");
  thread maps\flood_util::hide_models_by_targetname("mall_ware_model_hide");
  thread maps\flood_util::hide_models_by_targetname("garage_door_l");
  thread maps\flood_util::hide_models_by_targetname("garage_door_r");
  thread maps\flood_util::hide_models_by_targetname("upper_garage_door_l");
  thread maps\flood_util::hide_models_by_targetname("upper_garage_door_r");
  thread maps\flood_util::hide_models_by_targetname("garage_facade");
  thread maps\flood_util::hide_models_by_targetname("checkpoint_gate");
  thread maps\flood_util::hide_models_by_targetname("script_model_garage_post_stuff_01");
  thread maps\flood_util::hide_models_by_targetname("checkpoint_concrete_swap_barrier_1");
  thread maps\flood_util::hide_models_by_targetname("checkpoint_concrete_swap_barrier_2");
  thread maps\flood_util::hide_models_by_targetname("checkpoint_concrete_swap_barrier_3");
  thread maps\flood_util::hide_models_by_targetname("dam_break_delete");
  thread maps\flood_util::hide_models_by_targetname("destructible_vehicle");
  thread script_noteworthy_hide_and_show("infil_optimize");
  thread script_noteworthy_hide_and_show("infil_optimize_delay_delete");
  var_0 = getent("coverwater_rooftop_above", "targetname");
  var_0 hide();
  thread planter_hide_and_show("planter_06");
  thread planter_hide_and_show("planter_08");
  thread script_noteworthy_hide_and_show("floating_container");
  thread hotel_parking_car_hide();
  level waittill("infil_done");
  thread maps\flood_util::show_models_by_targetname("infil_cleanup");
  thread maps\flood_util::show_models_by_targetname("pipe_shootable");
  thread maps\flood_util::show_models_by_targetname("stealth_bob");
  thread maps\flood_util::show_models_by_targetname("warevolumes");
  thread maps\flood_util::show_models_by_targetname("mall_ware_brush_hide");
  thread maps\flood_util::show_models_by_targetname("mall_ware_model_hide");
  thread maps\flood_util::show_models_by_targetname("garage_door_l");
  thread maps\flood_util::show_models_by_targetname("garage_door_r");
  thread maps\flood_util::show_models_by_targetname("upper_garage_door_l");
  thread maps\flood_util::show_models_by_targetname("upper_garage_door_r");
  thread maps\flood_util::show_models_by_targetname("garage_facade");
  thread maps\flood_util::show_models_by_targetname("checkpoint_gate");
  thread maps\flood_util::show_models_by_targetname("destructible_vehicle");
  thread maps\flood_util::show_models_by_targetname("script_model_garage_post_stuff_01");
  thread maps\flood_util::show_models_by_targetname("checkpoint_concrete_swap_barrier_1");
  thread maps\flood_util::show_models_by_targetname("checkpoint_concrete_swap_barrier_2");
  thread maps\flood_util::show_models_by_targetname("checkpoint_concrete_swap_barrier_3");
  thread maps\flood_util::show_models_by_targetname("dam_break_delete");
  thread script_noteworthy_hide_and_show("infil_optimize", 1);
  thread script_noteworthy_hide_and_show("infil_optimize_delay_delete", 1);
  var_0 = getent("coverwater_rooftop_above", "targetname");
  var_0 show();
  thread planter_hide_and_show("planter_06", 1);
  thread planter_hide_and_show("planter_08", 1);
  thread script_noteworthy_hide_and_show("floating_container", 1);
}

planter_hide_and_show(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  if(!isDefined(var_1)) {
    foreach(var_4 in var_2) {
      if(!isDefined(var_4.targetname))
        var_4 hide();
    }
  } else {
    foreach(var_4 in var_2) {
      if(!isDefined(var_4.targetname))
        var_4 show();
    }
  }
}

script_noteworthy_hide_and_show(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  if(!isDefined(var_1)) {
    foreach(var_4 in var_2)
    var_4 hide();
  } else {
    foreach(var_4 in var_2)
    var_4 show();
  }
}

streets_vehicle_hide_at_start() {
  var_0 = [];
  var_0 = common_scripts\utility::add_to_array(var_0, getent("streets_static_iveco_01", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_car_5", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("crashed_truck", "targetname"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_truck_01", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_car_1_cleanup", "targetname"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_ally_car", "script_noteworthy"));
  var_1 = getEntArray("flood_street_car_1", "script_noteworthy");

  foreach(var_3 in var_1)
  var_0 = common_scripts\utility::add_to_array(var_0, var_3);

  foreach(var_3 in var_0)
  var_3 hide();
}

streets_vehicle_show_after_knife_kill() {
  var_0 = [];
  var_0 = common_scripts\utility::add_to_array(var_0, getent("streets_static_iveco_01", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_car_5", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("crashed_truck", "targetname"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_truck_01", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_street_car_1_cleanup", "targetname"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("flood_ally_car", "script_noteworthy"));
  var_1 = getEntArray("flood_street_car_1", "script_noteworthy");

  foreach(var_3 in var_1)
  var_0 = common_scripts\utility::add_to_array(var_0, var_3);

  foreach(var_3 in var_0)
  var_3 show();
}

streets_script_vehicle_cleanup() {
  var_0 = [];
  var_0 = common_scripts\utility::add_to_array(var_0, getent("streets_static_iveco_01", "script_noteworthy"));
  var_0 = common_scripts\utility::add_to_array(var_0, getent("crashed_truck", "targetname"));
  maps\_utility::array_delete(var_0);
}

swept_cleanup() {
  var_0 = getEntArray("swept_underwater_cleanup", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

palm_tree_control(var_0) {
  var_1 = getEntArray("palm_tree_in_rushing_water", "script_noteworthy");
  var_2 = getEntArray("embassy_palms", "script_noteworthy");
  var_3 = [];
  var_3[var_3.size] = "flood_shake_tree_left_1";
  var_3[var_3.size] = "flood_shake_tree_left_2";
  var_3[var_3.size] = "flood_shake_tree_left_3";
  var_3[var_3.size] = "flood_shake_tree_left_4";
  var_3[var_3.size] = "flood_shake_tree_left_5";
  var_3[var_3.size] = "flood_shake_tree_right_1";
  var_3[var_3.size] = "flood_shake_tree_right_2";
  var_3[var_3.size] = "flood_shake_tree_right_3";
  var_3[var_3.size] = "flood_shake_tree_right_4";
  var_3[var_3.size] = "flood_shake_tree_right_5";
  var_3[var_3.size] = "flood_shake_tree_right_6";

  foreach(var_5 in var_1)
  var_5 hide();

  if(isDefined(var_0)) {
    foreach(var_5 in var_3) {
      var_5 = getent(var_5, "script_noteworthy");

      if(isDefined(var_5))
        var_5 hide();
    }

    foreach(var_5 in var_2)
    var_5 hide();

    level waittill("end_streets");

    foreach(var_5 in var_3) {
      var_5 = getent(var_5, "script_noteworthy");

      if(isDefined(var_5))
        var_5 show();
    }

    foreach(var_5 in var_2)
    var_5 show();
  }

  common_scripts\utility::flag_wait("player_warehouse_mantle");
  thread embassy_palms_cleanup();
}

mall_rooftop_object_hide() {}

show_rushing_water_trees_infil_trees_cleanup(var_0) {
  if(isDefined(var_0)) {
    var_1 = getEntArray("infil_optimize_delay_delete", "script_noteworthy");

    foreach(var_3 in var_1)
    var_3 delete();
  }

  var_5 = getEntArray("palm_tree_in_rushing_water", "script_noteworthy");

  foreach(var_3 in var_5)
  var_3 show();
}

infil_optimize_tree_cleanup() {
  var_0 = getEntArray("infil_optimize", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();
}

embassy_palms_cleanup() {
  var_0 = getEntArray("embassy_palms", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();
}

hotel_parking_car_hide() {
  for(var_0 = 0; var_0 < 5; var_0++)
    thread maps\flood_util::hide_models_by_targetname("debris_bridge_car_" + var_0);
}

hotel_parking_facade() {
  var_0 = getent("rooftops_encounter_b_vo_3", "targetname");
  var_0 waittill("trigger");
  thread maps\flood_util::hide_models_by_targetname("garage_facade");

  for(var_1 = 0; var_1 < 5; var_1++)
    thread maps\flood_util::show_models_by_targetname("debris_bridge_car_" + var_1);
}

flood_createfx_cleanup() {
  level endon("load_finished");

  while(!isDefined(level.stop_load))
    wait 0.05;

  if(level.createfx_enabled) {
    common_scripts\utility::array_call(getaiarray(), ::delete);
    common_scripts\utility::array_call(getspawnerarray(), ::delete);
  }
}

flood_interactives_cleanup(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  maps\_utility::delete_destructibles_in_volumes(var_1);
  maps\_utility::delete_exploders_in_volumes(var_1);
  maps\_utility::delete_interactives_in_volumes(var_1);
}

introscreen() {
  var_0 = 1;
  maps\_introscreen::introscreen();
}

flood_intro_screen() {
  level.player allowjump(0);
  var_0 = 4;
  var_1 = 9;
  thread introscreen_generic_fade_in(var_1, var_0);
  wait 0.05;
  thread flood_intro_text();
  wait 5.0;
  thread maps\_utility::stylized_center_text([ & "FLOOD_INTROSCREEN_12_YEARS"], 3.5);
  common_scripts\utility::flag_set("start_intro_sequence");
  level maps\_utility::delaythread(1.5, maps\flood_infil::player_ride_rumble);
}

introscreen_generic_fade_in(var_0, var_1) {
  var_2 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  var_2.foreground = 0;
  level.player freezecontrols(1);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("cg_drawCrosshair", 0);
  wait(var_0);
  level.player freezecontrols(0);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("cg_drawCrosshair", 1);
  common_scripts\utility::flag_set("intro_show_introtext");
  wait 2.5;
  var_2 fadeovertime(0.5);
  var_2.alpha = 0;
  wait(var_1);
  level.player allowjump(1);
}

flood_intro_text() {
  level.introscreen = spawnStruct();
  level.introscreen.completed_delay = 4;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = 0.5;
  level.introscreen.lines = [ & "FLOOD_INTROSCREEN_LINE_1", & "FLOOD_INTROSCREEN_LINE_2", & "FLOOD_INTROSCREEN_LINE_5", & "FLOOD_INTROSCREEN_LINE_6"];
  thread maps\_introscreen::introscreen(1);
}

intro_screen_text_end() {
  return 0;
}

e3_section_start() {
  level.player setclienttriggeraudiozone("flood_fade_e3", 0.01);
  level.start_point = "dam";
  maps\flood_streets::dam_start();
  level.e3_demo = 1;
}

e3_section() {
  var_0 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  level thread e3_fadein(var_0);
  level thread maps\_introscreen::introscreen(1, 5);
  maps\flood_streets::dam();
  maps\flood_flooding::flooding_ext();
  maps\flood_flooding::flooding_int();
  maps\flood_mall::mall();
  level thread maps\flood_swept::swept();
  wait 24.0;
  e3_fadeout(var_0);
  wait 2.0;
  level.e3_demo = undefined;
  maps\_utility::nextmission();

  for(;;)
    wait 1.0;
}

e3_fadein(var_0) {
  level.player enableinvulnerability();
  level.allies[0] thread maps\flood_streets::ignore_everything(3.25);
  level.allies[1] thread maps\flood_streets::ignore_everything(5.79);
  level.allies[2] thread maps\flood_streets::ignore_everything(7);
  wait 2.0;
  level.player clearclienttriggeraudiozone(4);
  wait 3.0;
  level.player disableinvulnerability();
}

e3_fadeout(var_0) {
  level.player enableinvulnerability();
  level.player setclienttriggeraudiozone("flood_fade_e3", 1.8);
  var_0 fadeovertime(1.0);
  var_0.alpha = 1;
}

infil_start() {
  maps\flood_infil::infil_start();
}

infil() {
  maps\flood_infil::infil();
}

streets_start() {
  maps\flood_infil::streets_start();
}

streets() {
  maps\flood_infil::streets();
}

streets_to_dam_start() {
  maps\flood_streets::streets_to_dam_start();
}

streets_to_dam() {
  maps\flood_streets::streets_to_dam();
}

streets_to_dam_2_start() {
  maps\flood_streets::streets_to_dam_2_start();
}

streets_to_dam_2() {
  maps\flood_streets::streets_to_dam_2();
}

dam_start() {
  maps\flood_streets::dam_start();
}

dam() {
  maps\flood_streets::dam();
}

flooding_ext_start() {
  maps\flood_flooding::flooding_ext_start();
}

flooding_ext() {
  maps\flood_flooding::flooding_ext();
}

flooding_int_start() {
  maps\flood_flooding::flooding_int_start();
}

flooding_int() {
  maps\flood_flooding::flooding_int();
}

mall_start() {
  maps\flood_mall::mall_start();
}

mall() {
  maps\flood_mall::mall();
}

swept_start() {
  maps\flood_swept::swept_start();
}

swept() {
  maps\flood_swept::swept();
}

roof_stealth_start() {
  maps\flood_roof_stealth::roof_stealth_start();
}

roof_stealth() {
  maps\flood_roof_stealth::roof_stealth();
}

skybridge_start() {
  maps\flood_rooftops::skybridge_start();
}

skybridge() {
  maps\flood_rooftops::skybridge();
}

rooftops_start() {
  maps\flood_rooftops::rooftops_start();
}

rooftops() {
  maps\flood_rooftops::rooftops();
}

rooftop_water_start() {
  maps\flood_rooftops::rooftop_water_start();
}

rooftop_water() {
  maps\flood_rooftops::rooftop_water();
}

debrisbridge_start() {
  maps\flood_rooftops::debrisbridge_start();
}

debrisbridge() {
  maps\flood_rooftops::debrisbridge();
}

garage_start() {
  maps\flood_garage::garage_start();
}

garage() {
  maps\flood_garage::garage();
}

ending_start() {
  maps\flood_ending::ending_start();
}

ending() {
  maps\flood_ending::ending();
}

fly_around_start() {
  iprintlnbold("Press X to cycle transient fastfiles");
  maps\flood_util::player_move_to_checkpoint_start("flyaround_start");
  common_scripts\utility::array_call(getaiarray(), ::delete);
  common_scripts\utility::array_call(getspawnerarray(), ::delete);
  maps\flood_util::delete_all_triggers();
}

fly_around() {
  iprintln("flood_intro_tr transient fastfile loaded landing zone");

  for(;;) {
    thread maps\flood_swept::swept_water_toggle("swim", "hide");
    thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
    thread maps\flood_util::hide_scriptmodel_by_targetname_array("embassy_hide");

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    iprintln("flood_intro_tr transient fastfile dam");
    thread maps\flood_util::show_models_by_targetname("embassy_hide");
    wait 1.0;

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    thread maps\_utility::transient_unloadall_and_load("flood_mid_tr");
    common_scripts\utility::flag_wait("flood_mid_tr_loaded");
    common_scripts\utility::flag_clear("flood_mid_tr_loaded");
    wait 1.0;
    iprintln("flood_mid_tr transient fastfile loaded mall");
    thread maps\flood_util::hide_scriptmodel_by_targetname_array("embassy_hide");
    thread maps\flood_mall::mallroof_firstframe();

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    wait 1.0;
    thread maps\flood_swept::swept_water_toggle("swim", "show");
    thread maps\flood_util::show_models_by_targetname("swept_underwater_cleanup");
    thread maps\flood_util::show_models_by_targetname("garage_facade");
    iprintln("flood_mid_tr transient fastfile loaded swept");

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    wait 1.0;
    iprintln("flood_mid_tr transient fastfile loaded rooftops");
    thread maps\flood_swept::swept_water_toggle("swim", "hide");
    thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
    thread maps\flood_util::hide_models_by_targetname("swept_underwater_cleanup");
    thread maps\flood_util::hide_models_by_targetname("garage_facade");

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    thread maps\_utility::transient_unloadall_and_load("flood_end_tr");
    common_scripts\utility::flag_wait("flood_end_tr_loaded");
    common_scripts\utility::flag_clear("flood_end_tr_loaded");
    wait 1.0;
    iprintln("flood_end_tr transient fastfile loaded");

    while(!level.player buttonpressed("BUTTON_X"))
      wait 0.05;

    thread maps\_utility::transient_unloadall_and_load("flood_intro_tr");
    common_scripts\utility::flag_wait("flood_intro_tr_loaded");
    common_scripts\utility::flag_clear("flood_intro_tr_loaded");
    wait 1.0;
    iprintln("flood_intro_tr transient fastfile loaded");
  }
}

flood_default_water_transion_fx() {
  level.player setwatersurfacetransitionfx(common_scripts\utility::getfx("player_water_surface_plunge"), common_scripts\utility::getfx("scrnfx_water_splash_low"), common_scripts\utility::getfx("player_water_surface_plunge_fast"), common_scripts\utility::getfx("scrnfx_water_splash_low"));
}