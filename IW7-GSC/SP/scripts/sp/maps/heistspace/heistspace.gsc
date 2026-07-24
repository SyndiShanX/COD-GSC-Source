/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace.gsc
*****************************************************/

main() {
  scripts\sp\utility::_id_116CB("heistspace");
  scripts\sp\utility::_id_1263F("heistspace_om_bridge_tr");
  scripts\sp\utility::_id_1263F("heistspace_om_halls_tr");
  scripts\sp\utility::_id_1263F("heistspace_om_ordnance_tr");
  scripts\sp\utility::_id_1263F("heistspace_mons_ext_bridge_tr");
  scripts\sp\utility::_id_1263F("heistspace_base_tr");
  scripts\sp\utility::_id_1263F("heistspace_crash_tr");
  _id_6E3A();
  scripts\sp\maps\heistspace\gen\heistspace_art::main();
  scripts\sp\maps\heistspace\heistspace_fx::main();
  scripts\sp\maps\heistspace\heistspace_precache::main();
  scripts\sp\maps\heistspace\heistspace_anim::main();
  scripts\sp\maps\heistspace\heistspace_audio::main();
  scripts\sp\maps\heistspace\heistspace_lighting::main();
  setsaveddvar("r_umbraMinObjectContribution", 8);
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("r_umbraShadowCasters", 1);
  scripts\sp\maps\heistspace\heistspace_om130::_id_C453();
  _id_D7FE();
  _id_FA53();
  _id_AE35();
  _id_9771();

  if(getDvar("createfx") != "")
    level thread _id_88CA();

  scripts\sp\load::main();
  level thread _id_0F35::main();
  level thread _id_1078A();
  level thread _id_A11C();
  level.player _id_0E4B::_id_8E06(1);
  _id_9770();
  _id_8D26();
}

_id_FA53() {
  scripts\sp\utility::_id_F343("mons_130");
  scripts\sp\utility::_id_1749("mons_130", scripts\sp\maps\heistspace\heistspace_om130::_id_C461, "Mons 130", scripts\sp\maps\heistspace\heistspace_om130::_id_C448, ["heistspace_om_bridge_tr"], scripts\sp\maps\heistspace\heistspace_om130::_id_3B85);
  scripts\sp\utility::_id_1749("mons_guns_down", scripts\sp\maps\heistspace\heistspace_arrival::_id_BA8B, "Mons Guns Down", scripts\sp\maps\heistspace\heistspace_arrival::_id_BA87, ["heistspace_base_tr", "heistspace_om_bridge_tr", "heistspace_om_halls_tr"], scripts\sp\maps\heistspace\heistspace_arrival::_id_3B81);
  scripts\sp\utility::_id_1749("mons_halls", scripts\sp\maps\heistspace\heistspace_interior::_id_BA93, "Mons Halls", scripts\sp\maps\heistspace\heistspace_interior::_id_BA90, ["heistspace_base_tr", "heistspace_om_bridge_tr", "heistspace_om_halls_tr"], scripts\sp\maps\heistspace\heistspace_interior::_id_3B82);
  scripts\sp\utility::_id_1749("mons_navigation", scripts\sp\maps\heistspace\heistspace_interior::_id_BAD7, "Mons Navigation", scripts\sp\maps\heistspace\heistspace_interior::_id_BAD2, ["heistspace_base_tr", "heistspace_om_halls_tr", "heistspace_om_ordnance_tr"], scripts\sp\maps\heistspace\heistspace_interior::_id_3B83);
  scripts\sp\utility::_id_1749("mons_ordnance", scripts\sp\maps\heistspace\heistspace_interior::_id_BADC, "Mons Ordnance", scripts\sp\maps\heistspace\heistspace_interior::_id_BADA, ["heistspace_base_tr", "heistspace_om_halls_tr", "heistspace_om_ordnance_tr"], scripts\sp\maps\heistspace\heistspace_interior::_id_3B84);
  scripts\sp\utility::_id_1749("zero_g_combat", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_13E74, "Zero-G Combat", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_13E72, ["heistspace_base_tr", "heistspace_om_ordnance_tr", "heistspace_mons_ext_bridge_tr"], scripts\sp\maps\heistspace\heistspace_ext_combat::_id_3B93);
  scripts\sp\utility::_id_1749("retribution_arrives", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_E36D, "Retribution Arrives", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_E369, ["heistspace_base_tr", "heistspace_om_ordnance_tr", "heistspace_mons_ext_bridge_tr"], scripts\sp\maps\heistspace\heistspace_ext_combat::_id_3B87);
  scripts\sp\utility::_id_1749("defend_mons", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_506F, "Defend Mons", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_5068, ["heistspace_base_tr", "heistspace_om_ordnance_tr", "heistspace_mons_ext_bridge_tr"], scripts\sp\maps\heistspace\heistspace_ext_combat::_id_3B53);
  scripts\sp\utility::_id_1749("salter_jackal_hit", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_EAA2, "Salter Jackal Hit", scripts\sp\maps\heistspace\heistspace_ext_combat::_id_EA9F, ["heistspace_base_tr", "heistspace_om_ordnance_tr", "heistspace_mons_ext_bridge_tr", "heistspace_crash_tr"], scripts\sp\maps\heistspace\heistspace_ext_combat::_id_3B88);
  scripts\sp\utility::_id_1749("jackal_crash", scripts\sp\maps\heistspace\heistspace_crash::_id_A132, "Jackal Crash", scripts\sp\maps\heistspace\heistspace_crash::_id_A12F, ["heistspace_crash_tr"]);
}

_id_6E3A() {
  scripts\engine\utility::flag_init("mons_130_end");
  scripts\engine\utility::flag_init("mons_130_vo_end");
  scripts\engine\utility::flag_init("mons_guns_down_end");
  scripts\engine\utility::flag_init("mons_halls_end");
  scripts\engine\utility::flag_init("mons_ordnance_end");
  scripts\engine\utility::flag_init("zero_g_combat_begin");
  scripts\engine\utility::flag_init("zero_g_combat_end");
  scripts\engine\utility::flag_init("retribution_arrives_end");
  scripts\engine\utility::flag_init("defend_mons_begin");
  scripts\engine\utility::flag_init("defend_mons_end");
  scripts\engine\utility::flag_init("salter_jackal_hit_begin");
  scripts\engine\utility::flag_init("salter_jackal_hit_end");
  scripts\engine\utility::flag_init("jackal_crash_end");
  scripts\engine\utility::flag_init("player_on_bridge");
  scripts\engine\utility::flag_init("heistspace_start_objectives");
  scripts\engine\utility::flag_init("yard_obj_clear_path_done");
  scripts\engine\utility::flag_init("yard_obj_assess_ord_done");
  scripts\engine\utility::flag_init("yard_obj_defend_mons_done");
  scripts\engine\utility::flag_init("yard_obj_assist_salt_done");
  scripts\engine\utility::flag_init("olympus_mons_fully_spawned");
  scripts\engine\utility::flag_init("start_130_gameplay");
  scripts\engine\utility::flag_init("om130_activating");
  scripts\engine\utility::flag_init("om130_jackals_started");
  scripts\engine\utility::flag_init("om130_first_jackals_on_radar");
  scripts\engine\utility::flag_init("om130_intro_vo_done");
  scripts\engine\utility::flag_init("om130_fired_first_time");
  scripts\engine\utility::flag_init("om130_ending");
  scripts\engine\utility::flag_init("om_ambient_fire_starting");
  scripts\engine\utility::flag_init("om130_vital_vo");
  scripts\engine\utility::flag_init("start_capital_reinforcements");
  scripts\engine\utility::flag_init("fspar_down");
  scripts\engine\utility::flag_init("player_never_shot_fspar");
  scripts\engine\utility::flag_init("move_mars");
  scripts\engine\utility::flag_init("guns_down_vo_complete");
  scripts\engine\utility::flag_init("player_in_elevator");
  scripts\engine\utility::flag_init("elevator_can_move");
  scripts\engine\utility::flag_init("salter_elevator_ready");
  scripts\engine\utility::flag_init("elevator_done");
  scripts\engine\utility::flag_init("elevator_door_opening");
  scripts\engine\utility::flag_init("start_deploy_c6_anim");
  scripts\engine\utility::flag_init("hallways_done");
  scripts\engine\utility::flag_init("flag_c6_move_to_nav");
  scripts\engine\utility::flag_init("flag_mons_nav_combat_start");
  scripts\engine\utility::flag_init("flag_navi_wave2");
  scripts\engine\utility::flag_init("flag_c6allies_mbs_off");
  scripts\engine\utility::flag_init("flag_wave1_enemy_shift");
  scripts\engine\utility::flag_init("flag_navi_combat_reinforcements");
  scripts\engine\utility::flag_init("flag_navi_end_retreat");
  scripts\engine\utility::flag_init("navi_combat_complete");
  scripts\engine\utility::flag_init("flag_rpg_spot1");
  scripts\engine\utility::flag_init("flag_rpg_spot2");
  scripts\engine\utility::flag_init("flag_rpg_spot3");
  scripts\engine\utility::flag_init("ordnance_door_vo_complete");
  scripts\engine\utility::flag_init("salter_ready_for_ordnance_anim");
  scripts\engine\utility::flag_init("ordnance_player_anim_started");
  scripts\engine\utility::flag_init("ordnance_anim_start");
  scripts\engine\utility::flag_init("ordnance_vo_over");
  scripts\engine\utility::flag_init("ordnance_door_opened");
  scripts\engine\utility::flag_init("show_jackal_combat_debris");
  scripts\engine\utility::flag_init("retreat_to_zerog_enemies_volume1_enemy_death");
  scripts\engine\utility::flag_init("retreat_to_zerog_enemies_volume2_enemy_death");
  scripts\engine\utility::flag_init("retreat_to_zerog_enemies_volume3_enemy_death");
  scripts\engine\utility::flag_init("retreat_to_zerog_enemies_volume4_enemy_death");
  scripts\engine\utility::flag_init("ready_to_unload");
  scripts\engine\utility::flag_init("dropship_out_of_combat_zone");
  scripts\engine\utility::flag_init("dropship2_out_of_combat_zone");
  scripts\engine\utility::flag_init("spawn_zerog_dropship2");
  scripts\engine\utility::flag_init("zero_g_combat_enemies_dead");
  scripts\engine\utility::flag_init("start_zerog_drift");
  scripts\engine\utility::flag_init("player_jackal_stopped");
  scripts\engine\utility::flag_init("player_grapple_to_jackal");
  scripts\engine\utility::flag_init("player_entering_jackal");
  scripts\engine\utility::flag_init("retribution_ftl_in");
  scripts\engine\utility::flag_init("retribution_arrives_vo_over");
  scripts\engine\utility::flag_init("start_salter_chase_moment");
  scripts\engine\utility::flag_init("max_objective_kill_count_reached");
  scripts\engine\utility::flag_init("max_ace_kill_count_reached");
  scripts\engine\utility::flag_init("max_jackal_kill_count_reached");
  scripts\engine\utility::flag_init("max_destroyer_kill_count_reached");
  scripts\engine\utility::flag_init("saltar_jackal_hit");
  scripts\engine\utility::flag_init("salter_jackal_hit_vo_complete");
  scripts\engine\utility::flag_init("player_jackal_hit");
  scripts\engine\utility::flag_init("supply_drone_incoming");
  scripts\engine\utility::flag_init("defend_mons_vo_complete");
  scripts\engine\utility::flag_init("current_kill_objective_one");
  scripts\engine\utility::flag_init("current_kill_objective_two");
  scripts\engine\utility::flag_init("jackal_crash_begin");
  scripts\engine\utility::flag_init("crash_script_model_clean_up");
  scripts\engine\utility::flag_init("play_outro_mars_anim");
  scripts\engine\utility::flag_init("sunflare_position_02");
  scripts\engine\utility::flag_init("sunflare_position_03");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_bridge");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_a");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_b");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_navroom_a");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_navroom_b");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_dest_hallway_a");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_dest_hallway_b");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_dest_hallway_02_a");
  scripts\engine\utility::flag_init("set_vision_heistspace_int_ordinance");
  scripts\engine\utility::flag_init("set_vision_heistspace_zerog");
  scripts\engine\utility::flag_init("player_entering_jackal");
}

_id_D7FE() {
  precacheshader("veh_hud_missile_locked");
  precacheshader("veh_hud_missile");
  precacheshader("apache_reticle");
  precacheitem("cap_turret_phalanx");
  precacheitem("cap_turret_med");
  precacheitem("cap_turret_missile");
  precacheitem("cap_cannon_mons");
  precacheitem("magic_spaceship_20mm_bullet");
  precachemodel("ship_exterior_damage_int_wall_a01");
  precachemodel("ship_exterior_damage_int_wall_a02");
  precachemodel("ship_exterior_damage_int_wall_a03");
  precachemodel("ship_exterior_damage_int_wall_a04");
  precachemodel("ship_exterior_damage_int_wall_a05");
  precachemodel("ship_exterior_damage_int_wall_a06");
  precachemodel("ship_exterior_damage_int_wall_a07");
  precachemodel("ship_exterior_damage_int_wall_a08");
  precachemodel("bi_command_center_panel_19");
  precachemodel("container_space_barrel_01");
  precachemodel("cpt_pallete_container_01");
  precachemodel("hallway_frame_segment_single_32");
  precachemodel("hallway_frame_segment_single_corner");
  precachemodel("equipment_industrial_titan_console_01_screen_damaged");
  precachemodel("debris_exterior_damaged_metal_panel_05_piece_01");
  precachemodel("debris_exterior_damaged_metal_panel_05_piece_02");
  precachemodel("debris_exterior_damaged_metal_panel_05_piece_03");
  precachemodel("oxygen_tank_gascanister_01_zerog_playerclip");
  precachemodel("processing_facility_canister_zerog_playerclip");
  precachemodel("ind_debris_metal_scrap_01_zerog");
  precachemodel("ind_debris_metal_scrap_02_zerog");
  precachemodel("ind_debris_metal_scrap_04_zerog");
  precachemodel("equipment_industrial_hammer_01_zerog");
  precachemodel("equipment_industrial_hand_clamp_01_zerog");
  precachemodel("equipment_industrial_pliers_01_zerog");
  precachemodel("equipment_industrial_power_drill_01_zerog");
  precachemodel("equipment_industrial_rivet_tool_01_zerog");
  precachemodel("equipment_industrial_screwdriver_01_zerog");
  precachemodel("equipment_industrial_wrench_01_zerog");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_03_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_07_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_10_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_11_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_12_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_13_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_14_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_15_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_18_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_20_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_27_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_29_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_34_mat_rdc");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_35_mat_rdc");
  _id_0B53::_id_B908("veh_mil_air_ca_destroyer", "sp/model_damage_tables/veh_mil_air_ca_destroyer_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_destroyer_fx.csv");
  _id_0B53::_id_B90D(256);
  _id_0B53::_id_B908("veh_mil_air_ca_olympus_mons", "sp/model_damage_tables/veh_mil_air_ca_olympus_mons_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_olympus_mons_fx.csv");
  _id_0B53::_id_B90C("veh_mil_air_ca_olympus_mons", ::_id_C415);
  _id_0B53::_id_B90D(384);
  precachestring(&"HEIST_SPACE_OBJ_SHIPYARD");
  precachestring(&"HEIST_SPACE_OBJ_ASSESS_ORD");
  precachestring(&"HEIST_SPACE_OBJ_DEFEND_MONS");
  precachestring(&"HEIST_SPACE_OBJ_ASSIST_SALTER");
  precachestring(&"HEIST_SPACE_ELEVATOR_BUTTON");
  precachestring(&"HEIST_SPACE_SUPPORT");
}

_id_C415(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::flag("player_on_bridge") && distancesquared(var_1, level.player.origin) < 360000;
}

_id_1078A() {
  var_0 = getEnt("olympus_mons", "targetname");
  var_0._id_EEF9 = "none";
  level._id_C413 = scripts\sp\vehicle::_id_1080C("olympus_mons");
  level._id_C413._id_5020 = "off";
  level._id_C413._id_501F = "off";
  level._id_C413 thread scripts\sp\maps\heistspace\heistspace_util::_id_F051();
  level._id_C413 notsolid();
  wait 0.5;

  if(isDefined(level._id_C413))
    level._id_C413 thread _id_0BB8::_id_39CE("off");
}

_id_A11C() {
  scripts\engine\utility::waitframe();
  var_0 = getEntArray("rotating_roid", "script_noteworthy");
  var_1 = getEntArray("delete_for_crash", "targetname");
  var_2 = getEntArray("crash_vista", "targetname");
  var_3 = getEnt("debris_seen_from_ordnance_room_volume", "targetname");
  var_4 = getEnt("remove_debris_for_crash", "targetname");
  var_5 = [];

  foreach(var_7 in var_0) {
    if(var_7 istouching(var_3)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_7);
      var_5 = scripts\engine\utility::add_to_array(var_5, var_7);
    }
  }

  foreach(var_7 in var_1) {
    if(var_7 istouching(var_3)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_7);
      var_5 = scripts\engine\utility::add_to_array(var_5, var_7);
    }
  }

  if(!scripts\engine\utility::flag("show_jackal_combat_debris")) {
    scripts\engine\utility::array_call(var_0, ::hide);
    scripts\engine\utility::array_call(var_1, ::hide);
    scripts\engine\utility::array_call(var_2, ::hide);
    scripts\engine\utility::array_call(var_5, ::hide);
    scripts\engine\utility::flag_wait("show_jackal_combat_debris");
    scripts\engine\utility::array_call(var_0, ::show);
    scripts\engine\utility::array_call(var_1, ::show);
    scripts\engine\utility::array_call(var_2, ::show);
  }

  if(!scripts\engine\utility::flag("player_entering_jackal")) {
    scripts\engine\utility::array_call(var_5, ::hide);
    scripts\engine\utility::flag_wait("player_entering_jackal");
    scripts\engine\utility::array_call(var_5, ::show);
  }

  scripts\engine\utility::flag_wait("jackal_crash_begin");
  wait 2;
  var_11 = [];

  foreach(var_7 in var_0) {
    if(var_7 istouching(var_4)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_7);
      var_11 = scripts\engine\utility::add_to_array(var_11, var_7);
    }
  }

  foreach(var_7 in var_1) {
    if(var_7 istouching(var_4)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_7);
      var_11 = scripts\engine\utility::add_to_array(var_11, var_7);
    }
  }

  scripts\engine\utility::array_call(var_5, ::delete);
  scripts\engine\utility::array_call(var_11, ::delete);
}

_id_AE35() {}

_id_9771() {
  level._id_11937 = 0.05;
  _id_0F36::_id_D83F();
}

_id_9770() {
  level thread _id_0B20::_id_5A38();
  level._id_2FF1 = scripts\sp\maps\heistspace\heistspace_util::_id_102F0("bridge_door");
  level._id_B0D5 = scripts\sp\maps\heistspace\heistspace_util::_id_102F0("lower_elevator_door");
  level._id_DD6F = scripts\sp\maps\heistspace\heistspace_util::_id_102F0("ready_room_entry_door");
  level._id_DD71 = scripts\sp\maps\heistspace\heistspace_util::_id_102F0("ready_room_exit_door");
  _id_0B6C::_id_9717();
  level._id_10147 = 1;
  level.player _id_0BB6::_id_B7EA();
  level._id_13EC1 = getEnt("zerog_navinclusion3d_clip", "targetname");
  level._id_13EC1 notsolid();
  level._id_13EC1 connectpaths();
  level thread _id_DE5A();
  scripts\engine\utility::waitframe();
}

_id_DE5A() {
  var_0 = getEntArray("reflection_probe_door", "targetname");

  if(isDefined(var_0))
    scripts\sp\utility::_id_228A(var_0);
}

_id_1723(var_0, var_1, var_2, var_3) {
  if(!scripts\sp\utility::_id_C268(var_0))
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);
}

_id_8D26() {
  scripts\engine\utility::flag_wait("heistspace_start_objectives");
  _id_1723("obj_clear_path", "current", &"HEIST_SPACE_OBJ_SHIPYARD");
  scripts\engine\utility::flag_wait("yard_obj_clear_path_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_clear_path"));
  _id_1723("obj_assess_ord", "current", &"HEIST_SPACE_OBJ_ASSESS_ORD");
  scripts\engine\utility::flag_wait("yard_obj_assess_ord_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_assess_ord"));
  _id_1723("obj_defend_mons", "current", &"HEIST_SPACE_OBJ_DEFEND_MONS");
  scripts\engine\utility::flag_wait("yard_obj_defend_mons_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_defend_mons"));
  _id_1723("obj_assist_salt", "current", &"HEIST_SPACE_OBJ_ASSIST_SALTER");
  scripts\engine\utility::flag_wait("yard_obj_assist_salt_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_assist_salt"));
}

_id_88CA() {
  level._id_10CDA = "createfx";
  wait 8;
  _id_1078A();
  level._id_C413.script_disconnectpaths = 0;
  level._id_C413 notsolid();
  var_0 = getEnt("ext_bridge_geo", "targetname");
  var_0._id_C725 = var_0.origin;
  var_1 = getEntArray("ext_bridge_models", "targetname");
  var_0 = getEnt("ext_bridge_geo", "targetname");
  var_2 = getEnt("ext_bridge_pos", "targetname");

  foreach(var_4 in var_1)
  var_4 linkTo(var_0);

  for(;;) {
    while(getDvar("toggle_ship_visibility") == "0")
      wait 0.05;

    thread scripts\sp\utility::_id_1264E("heistspace_om_bridge_tr");
    thread scripts\sp\utility::_id_12641("heistspace_om_ordnance_tr");
    scripts\engine\utility::waitframe();
    var_0 moveTo(var_2.origin, 1);
    level._id_C413 _id_0BB8::_id_39CD("heavy");
    level._id_C413 _id_0BB8::_id_39D0("heavy");
    level._id_C413 _id_0BB8::_id_39CE("high");

    while(getDvar("toggle_ship_visibility") == "1")
      wait 0.05;

    thread scripts\sp\utility::_id_1264E("heistspace_om_ordnance_tr");
    thread scripts\sp\utility::_id_12641("heistspace_om_bridge_tr");
    scripts\engine\utility::waitframe();
    var_0 moveTo(var_0._id_C725, 1);
    level._id_C413 _id_0BB8::_id_39CD("off");
    level._id_C413 _id_0BB8::_id_39D0("off");
    level._id_C413 _id_0BB8::_id_39CE("off");
  }
}