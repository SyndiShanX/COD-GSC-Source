/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse_finale\safehouse_finale.gsc
*********************************************************/

main() {
  setsaveddvar("MMLNNQSTTL", 1);
  setDvar("VehicleContinuesOnDriverDeath", 1);
  init_precache();
  init_anims();
  init_vfx();
  setsaveddvar("MRNRKKOPLN", 5);
  setsaveddvar("MQPQKNPQOK", 7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("OLSKLTPPMR", 0.3);
  setsaveddvar("NQTLPTNSSO", 5);
  setsaveddvar("NTMMTOLQMQ", (-1, 0, 0));
  setsaveddvar("LTKPSMSTQO", 0);
  setdvarifuninitialized("scr_shf_invert", 0);
  createthreatbiasgroup("snipers");
  createthreatbiasgroup("shielded");
  scripts\engine\sp\utility::intro_screen_create(&"SAFEHOUSE_FINALE_LOC/FINALE_INTRO_TITLE", &"SAFEHOUSE_FINALE_LOC/FINALE_INTRO_DATE", &"SAFEHOUSE_FINALE_LOC/FINALE_INTRO_WHO", &"SAFEHOUSE_FINALE_LOC/FINALE_INTRO_SQUAD", &"SAFEHOUSE_FINALE_LOC/FINALE_INTRO_LOCATION");
  scripts\engine\sp\utility::intro_screen_custom_func(scripts\engine\sp\utility::empty_func);
  scripts\engine\sp\utility::add_hint_string("grenade_launcher", &"SAFEHOUSE_FINALE_LOC/GRENADE_LAUNCHER", ::player_usingprimaryweaponaltmode);
  scripts\engine\sp\utility::add_hint_string("pipe_bomb", &"SAFEHOUSE_FINALE_LOC/PIPE_BOMB");
  scripts\engine\sp\utility::add_hint_string("molotov", &"SAFEHOUSE_FINALE_LOC/MOLOTOV");
  scripts\engine\sp\utility::add_hint_string("signal", &"SAFEHOUSE_FINALE_LOC/SIGNAL");
  scripts\engine\sp\utility::add_hint_string("apache_fly", &"SAFEHOUSE_FINALE_LOC/APACHE_FLY", ::hide_apache_forward_hint);
  scripts\engine\sp\utility::add_hint_string("apache_leave", &"SAFEHOUSE_FINALE_LOC/RETREAT", ::hide_apache_retreat_hint);
  scripts\engine\sp\utility::add_hint_string("drone_control", &"SAFEHOUSE_FINALE_LOC/DRONE_CONTROL", ::hide_drone_hint);
  scripts\engine\sp\utility::add_hint_string("drone_pilot", &"SAFEHOUSE_FINALE_LOC/DRONE_PILOT");
  scripts\engine\sp\utility::add_hint_string("drone_sprint", &"SAFEHOUSE_FINALE_LOC/DRONE_SPRINT", ::hide_drone_sprint_hint);
  scripts\engine\sp\utility::add_hint_string("drone_detonate", &"SAFEHOUSE_FINALE_LOC/DETONATE", ::hide_drone_detonate_hint);
  scripts\engine\sp\utility::add_hint_string("molotov_hint", &"SAFEHOUSE_FINALE_LOC/THROW_MOLOTOVS", ::hide_molotov_hint);
  scripts\engine\sp\utility::add_hint_string("jump_hint", &"SAFEHOUSE_FINALE_LOC/JUMP");
  scripts\engine\sp\utility::add_hint_string("drones_coolingdown", &"SAFEHOUSE_FINALE_LOC/PLANES_INBOUND");
  scripts\engine\sp\utility::add_hint_string("drones_unavailable", &"SAFEHOUSE_FINALE_LOC/PLANES_UNAVAILABLE");
  scripts\engine\sp\utility::add_hint_string("air_support", &"SAFEHOUSE_FINALE_LOC/AIR_SUPPORT", ::hide_chopper_hint);
  scripts\engine\sp\utility::add_hint_string("apache_rockets", &"SAFEHOUSE_FINALE_LOC/ROCKET_HINT", ::hide_chopper_rocket_hint);
  scripts\engine\sp\utility::add_hint_string("apache_guns", &"SAFEHOUSE_FINALE_LOC/CHOPPER_GUNS_HINT", ::hide_chopper_guns_hint);
  scripts\engine\sp\utility::add_hint_string("apache_zoom", &"SAFEHOUSE_FINALE_LOC/CHOPPER_ZOOM_HINT", ::hide_chopper_zoom_hint);
  scripts\engine\sp\utility::add_hint_string("apache_zoom_hold", &"SAFEHOUSE_FINALE_LOC/CHOPPER_ZOOM_HINT_HOLD", ::hide_chopper_zoom_hint);
  scripts\engine\sp\utility::add_hint_string("flight_invert", &"SAFEHOUSE_FINALE_LOC/FLIGHT_INVERT");
  scripts\sp\maps\safehouse_finale\gen\safehouse_finale_art.gsc::main();
  scripts\sp\maps\safehouse_finale\safehouse_finale_fx.gsc::main();
  scripts\sp\maps\safehouse_finale\safehouse_finale_precache.gsc::main();
  scripts\sp\maps\safehouse_finale\safehouse_finale_lighting.gsc::main();
  scripts\engine\sp\utility::transient_init("safehouse_finale_intro_tr");
  scripts\engine\sp\utility::transient_init("safehouse_finale_fob_tr");
  scripts\engine\sp\utility::transient_init("safehouse_finale_town_tr");
  scripts\engine\sp\utility::add_start("safehouse_interior", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::safehouse_interior_start, "Prep", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::safehouse_interior_main, "shf_intro_only", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::safehouse_interior_catchup);
  scripts\engine\sp\utility::add_start("fly", ::fly_start, "Fly", ::fly_main, "safehouse_finale_all", ::fly_catchup);
  scripts\engine\sp\utility::add_start("rooftop", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::rooftops_start, "Rooftop", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::rooftops_main, "safehouse_finale_all", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::rooftops_catchup);
  scripts\engine\sp\utility::add_start("pre_charge", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::pre_charge_start, "Pre-Charge", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::pre_charge_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("charge", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::charge_start, "Charge", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::charge_main, "safehouse_finale_all", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::charge_catchup);
  scripts\engine\sp\utility::add_start("bunkers", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::bunkers_start, "Bunkers", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::bunkers_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("fob_center", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::fob_center_start, "Fob Center", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::fob_center_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("armory_01", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::armory_01_start, "armory 01", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::armory_01_main, "safehouse_finale_all", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::armory_01_catchup);
  scripts\engine\sp\utility::add_start("containers", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::containers_gate_start, "Containers", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::containers_gate_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("containers_truck", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::containers_truck_start, "DO NOT USE", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::containers_truck_main, "safehouse_finale_all", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::containers_truck_catchup);
  scripts\engine\sp\utility::add_start("tarmac", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::tarmac_start, "Tarmac", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::tarmac_main, "safehouse_finale_all", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::tarmac_catchup);
  scripts\engine\sp\utility::add_start("armory_02", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::armory_02_start, "Hangar Armory", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::armory_02_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("hangar_defend", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::hangar_defend_start, "hangar_defend", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::hangar_defend_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("killstreak_chopper", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::killstreak_chopper_start, "killstreak_chopper", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::killstreak_chopper_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("Ending", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::ending_scene_start, "Ending", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::ending_scene_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("bink", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::bink_start, "bink_start", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::bink_main, "safehouse_finale_all");
  scripts\engine\sp\utility::add_start("Hangar_Defend_VFX", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::hangar_defend_start, "Hangar Hangar_Defend_VFX", scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::hangar_defend_vfx_main, "safehouse_finale_all");
  scripts\engine\sp\utility::set_default_start("safehouse_interior");
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  init_level();
  init_player();
}

init_precache() {
  precachemodel("misc_propane_rocket");
  precachemodel("lighting_red_emergency_01_on");
  precachemodel("un_painters_light_01");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02");
  scripts\sp\player\ally_equipment::ally_equipment_init();
  scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::init_fob();
}

init_anims() {
  init_anims_script_model();
  init_anims_player();
  init_anims_vehicles();
  init_anims_generic_human();
  init_apache_vehicleanims();
  init_anims_scriptables();
}

#using_animtree("script_model");

init_anims_script_model() {
  level.scr_animtree["pumpjack"] = #animtree;
  level.scr_anim["pumpjack"]["pumpjack_idle"][0] = % hod_me_machinery_oil_pumpjack_01;
  level.scr_animtree["propane_tank"] = #animtree;
  level.scr_model["propane_tank"] = "misc_propane_rocket";
  level.scr_anim["propane_tank"]["cannon_load"] = % shf_020_rally_scene_missile02;
  level.scr_anim["propane_tank"]["intro_scene"] = % shf_010_infil_scenea_missile;
  level.scr_animtree["ks_apache_pilot"] = #animtree;
  level.scr_anim["ks_apache_pilot"]["pilot_intro"] = % mp_player_ahotel64_intro_01;
  level.scr_anim["ks_apache_pilot"]["pilot_outro"] = % mp_player_ahotel64_outro_01;
  level.scr_animtree["tablet_1"] = #animtree;
  level.scr_model["tablet_1"] = "offhand_vm_tablet";
  level.scr_anim["tablet_1"]["intro_scene_roof"] = % shf_010_infil_sceneb_tablet01;
  level.scr_goaltime["tablet_1"]["intro_scene_roof"] = 0;
  level.scr_anim["tablet_1"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_tablet01;
  level.scr_anim["tablet_1"]["intro_scene_roof_exit"] = % shf_010_infil_scenec_tablet01;
  level.scr_anim["tablet_1"]["intro_scene_roof_exit_idle"][0] = % shf_010_infil_idlec_tablet01;
  level.scr_anim["tablet_1"]["intro_scene_roof_idle_nag1"] = % shf_010_infil_idleb_nag_tablet01;
  level.scr_anim["tablet_1"]["intro_scene_roof_idle_nag2"] = % shf_010_infil_idleb_nag2_tablet01;
  level.scr_anim["tablet_1"]["intro_scene_roof_idle_nag3"] = % shf_010_infil_idleb_nag3_tablet01;
  level.scr_animtree["tablet_2"] = #animtree;
  level.scr_model["tablet_2"] = "offhand_vm_tablet";
  level.scr_anim["tablet_2"]["intro_scene_roof"] = % shf_010_infil_sceneb_tablet02;
  level.scr_anim["tablet_2"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_tablet02;
  level.scr_anim["tablet_2"]["intro_scene_roof_exit"] = % shf_010_infil_scenec_tablet02;
  level.scr_anim["tablet_2"]["intro_scene_roof_exit_idle"][0] = % shf_010_infil_idlec_tablet02;
  level.scr_animtree["tablet_3"] = #animtree;
  level.scr_model["tablet_3"] = "offhand_vm_tablet";
  level.scr_anim["tablet_3"]["intro_scene_roof"] = % shf_010_infil_sceneb_tablet03;
  level.scr_anim["tablet_3"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_tablet03;
  level.scr_animtree["bent_gate"] = #animtree;
  level.scr_model["bent_gate"] = "me_metal_panel_sliding_security_gate_256_bend";
  level.scr_anim["bent_gate"]["truck_smash"] = % shf_040_armored_truck_crushing_crushed_fence;
  scripts\common\anim::addnotetrack_notify("bent_gate", "gate_hit", "gate_hit", "truck_smash");
  scripts\common\anim::addnotetrack_notify("bent_gate", "gate_down", "gate_down", "truck_smash");
  level.scr_animtree["gate"] = #animtree;
  level.scr_anim["gate"]["truck_smash"] = % shf_040_armored_truck_crushing_clean_fence;
  level.scr_animtree["molotov"] = #animtree;
  level.scr_model["molotov"] = "offhand_vm_molotov";
  level.scr_anim["molotov"]["intro_scene"] = % shf_010_infil_scenea_molotov;
  level.scr_animtree["rc_plane"] = #animtree;
  level.scr_model["rc_plane"] = "offhand_wm_air_bombing_drone";
  level.scr_anim["rc_plane"]["intro_scene_roof"] = % shf_010_infil_sceneb_drone;
  level.scr_animtree["door"] = #animtree;
  level.scr_anim["door"]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen_rdoor;
  level.scr_anim["door"]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01_rdoor;
  level.scr_anim["door"]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02_rdoor;
  level.scr_anim["door"]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03_rdoor;
  level.scr_anim["door"]["faveladoor_kick"] = % reb_smtobj_door_r_kick01_rdoor;
  level.scr_anim["door"]["faveladoor_peak"] = % reb_smtobj_door_r_peak_rdoor;
  level.scr_animtree["hc_door"] = #animtree;
  level.scr_anim["hc_door"]["intro_scene"] = % shf_010_infil_scenea_door;
  level.scr_animtree["hatch"] = #animtree;
  level.scr_anim["hatch"]["armory_hatch"] = % shf_047_hadir_armory_scene_hatch;
  level.scr_animtree["gate_truck"] = #animtree;
  level.scr_model["gate_truck"] = "veh8_mil_lnd_umike";
  level.scr_anim["gate_truck"]["truck_enter"] = % shf_040_armored_truck_door;
  level.scr_anim["gate_truck"]["truck_smash"] = % shf_040_armored_truck;
  level.scr_anim["gate_truck"]["truck_exit"] = % vh_umike_driver_exit_combat_idle;
}

#using_animtree("scriptables");

init_anims_scriptables() {
  level.scr_animtree["door_scriptable"] = #animtree;
  level.scr_anim["door_scriptable"]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen_rdoor;
  level.scr_anim["door_scriptable"]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01_rdoor;
  level.scr_anim["door_scriptable"]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02_rdoor;
  level.scr_anim["door_scriptable"]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03_rdoor;
  level.scr_anim["door_scriptable"]["faveladoor_kick"] = % reb_smtobj_door_r_kick01_rdoor;
  level.scr_anim["door_scriptable"]["faveladoor_peak"] = % reb_smtobj_door_r_peak_rdoor;
  level.scr_anim["door_scriptable"]["door_bust"] = % sh_sch_060_doorbustl_door;
}

#using_animtree("player");

init_anims_player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  level.scr_anim["player_rig"]["intro_scene"] = % shf_010_infil_scenea_player;
  level.scr_anim["player_rig"]["outro_scene"] = % shf_050_3p_outro_cam;
  level.scr_anim["player_rig"]["bink_scene_roof"] = % shf_005_3p_intro_cam;
  level.scr_anim["player_rig"]["buddy_boost"] = % safehouse_nh_buddyboost_plr;
  level.scr_anim["player_rig"]["buddy_boost_restart"] = % shf_047_buddyboost_scene_plr;
}

#using_animtree("vehicles");

init_anims_vehicles() {
  level.scr_animtree["ks_apache_vehicle_camera"] = #animtree;
  level.scr_anim["ks_apache_vehicle_camera"]["vehicle_intro"] = % mp_ahotel64_intro_01;
  level.scr_anim["ks_apache_vehicle_camera"]["vehicle_outro"] = % mp_ahotel64_outro_01;
  level.scr_anim["ks_apache_vehicle_camera"]["outro_scene"] = % shf_050_3p_outro_heli;
}

init_apache_vehicleanims() {}

#using_animtree("generic_human");

init_anims_generic_human() {
  level.scr_anim["farah"]["bink_scene_roof"] = % shf_005_3p_intro_farah;
  level.scr_anim["hadir"]["intro_scene"] = % shf_010_infil_scenea_hadir_face;
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_start", "intro_mayhem_hadir_face", "intro_scene");
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_end", "intro_mayhem_hadir_face_off", "intro_scene");
  level.scr_anim["hadir"]["intro_scene"] = % shf_010_infil_scenea_hadir;
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_start", "intro_mayhem_hadir_face", "intro_scene");
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_end", "intro_mayhem_hadir_face_off", "intro_scene");
  scripts\common\anim::addnotetrack_notify("hadir", "vo_dx_vom_had_safehouse_interior_planeintro_10", "airforce_vo", "intro_scene");
  level.scr_anim["hadir"]["intro_scene_to_roof"] = % shf_010_infil_scenea_2_sceneb_hadir;
  scripts\common\anim::addnotetrack_notify("hadir", "start_scene_b", "start_scene_b", "intro_scene_to_roof");
  setmusicstate("mx_safehouse_finale_intro");
  level.scr_anim["hadir"]["intro_scene_to_idle"] = % shf_010_infil_2_idlea_hadir;
  level.scr_anim["hadir"]["intro_scene_idle"][0] = % shf_010_infil_idlea_hadir;
  level.scr_goaltime["hadir"]["intro_scene_idle"] = 0;
  level.scr_anim["hadir"]["intro_scene_idle_to_roof"] = % shf_010_infil_idlea_2_sceneb_hadir;
  level.scr_goaltime["hadir"]["intro_scene_idle_to_roof"] = 0;
  scripts\common\anim::addnotetrack_notify("hadir", "start_scene_b", "start_scene_b", "intro_scene_idle_to_roof");
  level.scr_face["hadir"]["dx_vom_had_safehouse_interior_intro_60"] = % dx_vom_had_safehouse_interior_intro_60_face;
  level.scr_face["hadir"]["dx_vom_had_safehouse_interior_planeintro_10"] = % dx_vom_had_safehouse_interior_planeintro_10_face;
  level.scr_face["farah"]["dx_vom_far_pre_charge_setup_190"] = % dx_vom_far_pre_charge_setup_190_face;
  level.scr_anim["hadir"]["intro_scene_idle_nag1"] = % shf_010_infil_idlea_nag_hadir;
  level.scr_goaltime["hadir"]["intro_scene_idle_nag1"] = 0;
  level.scr_anim["hadir"]["intro_scene_idle_nag2"] = % shf_010_infil_idlea_nag2_hadir;
  level.scr_anim["hadir"]["intro_scene_idle_nag3"] = % shf_010_infil_idlea_nag3_hadir;
  level.scr_anim["rebel"]["intro_scene"] = % shf_010_infil_scenea_man01;
  level.scr_anim["rebel"]["intro_scene_02"] = % shf_010_infil_scenea_man02;
  level.scr_anim["rebel"]["bink_scene"] = % shf_010_infil_scenea_man01;
  level.scr_anim["hadir"]["intro_scene_roof"] = % shf_010_infil_sceneb_hadir;
  level.scr_goaltime["hadir"]["intro_scene_roof"] = 0;
  scripts\common\anim::addnotetrack_notify("hadir", "vo_dx_vom_had_safehouse_interior_planeintro_130", "tablet_vo", "intro_scene_roof");
  level.scr_anim["hadir"]["intro_scene_roof_idle_nag1"] = % shf_010_infil_idleb_nag_hadir;
  level.scr_anim["hadir"]["intro_scene_roof_idle_nag2"] = % shf_010_infil_idleb_nag2_hadir;
  level.scr_anim["hadir"]["intro_scene_roof_idle_nag3"] = % shf_010_infil_idleb_nag3_hadir;
  level.scr_anim["hadir"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_hadir;
  level.scr_anim["farah"]["intro_scene_roof"] = % shf_010_infil_sceneb_farah;
  level.scr_anim["farah"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_farah;
  level.scr_anim["yasim"]["intro_scene_roof"] = % shf_010_infil_sceneb_woman01;
  level.scr_anim["yasim"]["intro_scene_roof_idle"][0] = % shf_010_infil_idleb_woman01;
  level.scr_anim["hadir"]["intro_scene_roof_exit"] = % shf_010_infil_scenec_hadir;
  level.scr_anim["hadir"]["intro_scene_roof_exit_idle"][0] = % shf_010_infil_idlec_hadir;
  level.scr_anim["farah"]["intro_scene_roof_exit"] = % shf_010_infil_scenec_farah;
  level.scr_anim["farah"]["intro_scene_roof_exit_idle"][0] = % shf_010_infil_idlec_farah;
  level.scr_anim["alex"]["drone_idle"][0] = % shf_drone_idle_alex;
  level.scr_anim["hadir"]["intro_scene_roof_jump"] = % shf_015_rooftop_exit_hadir;
  level.scr_anim["farah"]["intro_scene_roof_jump"] = % shf_015_rofftop_exit_farah;
  level.scr_anim["farah"]["tower_celebration"] = % emb_enemy_first_wave_gun_pump_01;
  level.scr_anim["farah"]["cannon_call"][0] = % hm_grnd_yel_patrol_idle_radio01_ar;
  level.scr_anim["firer"]["cannon_idle"][0] = % shf_020_rally_idle_rebel01;
  level.scr_anim["loader"]["cannon_idle"][0] = % shf_020_rally_idle_rebel02;
  level.scr_anim["firer"]["cannon_load"] = % shf_020_rally_scene_rebel01;
  level.scr_anim["loader"]["cannon_load"] = % shf_020_rally_scene_rebel02;
  level.scr_anim["firer"]["cannon_load_b"] = % shf_020_rally_scene_loadb_rebel01;
  level.scr_anim["loader"]["cannon_load_b"] = % shf_020_rally_scene_loadb_rebel02;
  level.scr_anim["farah"]["outro_scene"] = % shf_050_3p_outro_farah;
  scripts\common\anim::addnotetrack_notify("farah", "mayhem_start", "ending_mayhem_farah_face", "outro_scene");
  level.scr_anim["alex"]["outro_scene"] = % shf_050_3p_outro_alex;
  scripts\common\anim::addnotetrack_notify("alex", "mayhem_start", "ending_mayhem_alex_face", "outro_scene");
  level.scr_anim["hadir"]["outro_scene"] = % shf_050_3p_outro_hadir;
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_start", "ending_mayhem_hadir_face", "outro_scene");
  level.scr_anim["enemy_01"]["lookaround_05"] = % reb_smtobj_lookaround05;
  level.scr_anim["enemy_01"]["lookaround_04"] = % reb_smtobj_lookaround04;
  level.scr_anim["farah"]["peptalk_intro"] = % shf_025_peptalk_intro_farah;
  level.scr_anim["rebel_1"]["peptalk_intro"] = % shf_025_peptalk_intro_rebel01;
  level.scr_anim["rebel_2"]["peptalk_intro"] = % shf_025_peptalk_intro_rebel02;
  level.scr_anim["rebel_3"]["peptalk_intro"] = % shf_025_peptalk_intro_rebel03;
  level.scr_anim["rebel_4"]["peptalk_intro"] = % shf_025_peptalk_intro_rebel04;
  level.scr_anim["farah"]["peptalk_idle"][0] = % shf_025_peptalk_idle_farah;
  level.scr_anim["rebel_1"]["peptalk_idle"][0] = % shf_025_peptalk_idle_rebel01;
  level.scr_anim["rebel_2"]["peptalk_idle"][0] = % shf_025_peptalk_idle_rebel02;
  level.scr_anim["rebel_3"]["peptalk_idle"][0] = % shf_025_peptalk_idle_rebel03;
  level.scr_anim["rebel_4"]["peptalk_idle"][0] = % shf_025_peptalk_idle_rebel04;
  level.scr_anim["farah"]["peptalk_nag"] = % shf_025_peptalk_nag_farah;
  level.scr_anim["farah"]["peptalk_exit"] = % shf_025_peptalk_out_farah;
  level.scr_anim["rebel_1"]["peptalk_exit"] = % shf_025_peptalk_out_rebel01;
  level.scr_anim["rebel_2"]["peptalk_exit"] = % shf_025_peptalk_out_rebel02;
  level.scr_anim["rebel_3"]["peptalk_exit"] = % shf_025_peptalk_out_rebel03;
  level.scr_anim["rebel_4"]["peptalk_exit"] = % shf_025_peptalk_out_rebel04;
  level.scr_anim["rebel_1"]["outro_scene"] = % shf_050_3p_outro_rebel01;
  level.scr_anim["rebel_2"]["outro_scene"] = % shf_050_3p_outro_rebel02;
  level.scr_anim["rebel_3"]["outro_scene"] = % shf_050_3p_outro_rebel03;
  level.scr_anim["rebel_4"]["outro_scene"] = % shf_050_3p_outro_rebel04;
  level.scr_anim["rebel_5"]["outro_scene"] = % shf_050_3p_outro_rebel05;
  level.scr_anim["rebel_6"]["outro_scene"] = % shf_050_3p_outro_rebel06;
  level.scr_anim["rebel_7"]["outro_scene"] = % shf_050_3p_outro_rebel07;
  level.scr_anim["rebel_8"]["outro_scene"] = % shf_050_3p_outro_rebel08;
  level.scr_anim["rebel_9"]["outro_scene"] = % shf_050_3p_outro_rebel09;
  level.scr_anim["rebel_10"]["outro_scene"] = % shf_050_3p_outro_rebel10;
  var_0 = "generic";
  level.scr_anim[var_0]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen;
  level.scr_anim[var_0]["faveladoor_fire1"] = % shf_reb_smtobj_door_r_fire01;
  level.scr_anim[var_0]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02;
  level.scr_anim[var_0]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03;
  level.scr_anim[var_0]["faveladoor_idle"][0] = % reb_smtobj_door_r_loop;
  level.scr_anim[var_0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01;
  level.scr_anim[var_0]["faveladoor_peak"] = % reb_smtobj_door_r_peak;
  level.scr_anim["farah"]["gate_pull"] = % shf_035_gate_pull_farah;
  level.scr_anim["hadir"]["truck_enter"] = % shf_040_armored_truck_hadir_enter;
  level.scr_anim["body"]["truck_enter"] = % shf_040_armored_truck_body;
  level.scr_anim["hadir"]["truck_enter_idle"][0] = % reb_vh_umike_driver_idle_search01;
  level.scr_anim["hadir"]["truck_exit"] = % reb_vh_umike_driver_exit_combat_idle;
  level.scr_anim["enemy_01"]["door_bust"] = % sh_sch_060_doorbustl_enemy;
  level.scr_anim["enemy_01"]["door_bust_death"] = % sh_sch_060_doorbustl_death;
  level.scr_anim["enemy_01"]["drag_scene_drag"] = % shf_046_drag_drag_ally01;
  level.scr_anim["enemy_02"]["drag_scene_drag"] = % shf_046_drag_drag_ally02;
  level.scr_anim["enemy_00"]["directing_01"] = % shf_045_russian_directoring_long_ally;
  level.scr_anim["enemy_01"]["directing_01"] = % shf_045_russian_directing_right_ally;
  level.scr_anim["enemy_02"]["directing_02"] = % shf_045_russian_directing_left_ally;
  level.scr_anim["enemy_03"]["directing_03"] = % shf_045_russian_directoring_roof_ally;
  level.scr_anim["hadir"]["buddy_boost_enter"] = % shf_047_buddyboost_enter_hadir;
  level.scr_anim["hadir"]["buddy_boost_enter_idle"][0] = % shf_047_buddyboost_enter_idle_hadir;
  level.scr_anim["hadir"]["buddy_boost_nag"] = % shf_047_buddyboost_nag_hadir;
  level.scr_anim["hadir"]["buddy_boost"] = % safehouse_nh_buddyboost_ally01;
  level.scr_anim["hadir"]["buddy_boost_restart_enter"] = % shf_047_buddyboost_restart_hadir;
  level.scr_anim["hadir"]["buddy_boost_restart_idle"][0] = % shf_047_buddyboost_idle_hadir;
  level.scr_anim["hadir"]["buddy_boost_restart"] = % shf_047_buddyboost_scene_hadir;
  scripts\common\anim::addnotetrack_notify("hadir", "nag", "boost_jump_nag", "buddy_boost_restart_idle");
  level.scr_anim["hadir"]["armory_enter"] = % shf_047_hadir_armory_enter_hadir;
  level.scr_anim["hadir"]["armory_enter_idle"][0] = % shf_047_hadir_armory_idlea_hadir;
  level.scr_anim["hadir"]["armory_hatch"] = % shf_047_hadir_armory_scene_hadir;
  level.scr_anim["hadir"]["armory_hatch_idle"][0] = % shf_047_hadir_armory_idleb_hadir;
  level.scr_anim["hadir"]["armory_hatch_nag"] = % shf_047_hadir_armory_nagb_hadir;
  level.scr_anim["SHF_043_russians_armory_l"]["armory_surprise"] = % shf_043_russians_armory_l;
  level.scr_anim["SHF_043_russians_armory_r"]["armory_surprise"] = % shf_043_russians_armory_r;
  level.scr_anim["enemy_01"]["armory_surprise_toss"] = % shf_044_armory_gun_tossing_soldier1;
  level.scr_anim["enemy_02"]["armory_surprise_toss"] = % shf_044_armory_gun_tossing_soldier2;
  level.scr_anim["hangar_crouch"]["hangar_idles"][0] = % sdr_com_cover_left_crouch_hide_idle;
  level.scr_anim["soldier_01"]["deadbody_02"] = % deadbody_02;
  level.scr_anim["soldier_01"]["deadbody_07"] = % deadbody_07;
  level.scr_anim["soldier_01"]["deadbody_08"] = % deadbody_08;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_80"] = % dx_vom_had_armory_02_breach_80_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_90"] = % dx_vom_had_armory_02_breach_90_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_110"] = % dx_vom_had_armory_02_breach_110_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_120"] = % dx_vom_had_armory_02_breach_120_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_130"] = % dx_vom_had_armory_02_breach_130_face;
  level.scr_face["farah"]["dx_vom_far_containers_trucksmash_50"] = % dx_vom_far_containers_trucksmash_50_face;
  level.scr_face["farah"]["dx_vom_far_containers_trucksmash_60"] = % dx_vom_far_containers_trucksmash_60_face;
  level.scr_face["hadir"]["dx_vom_had_safehouse_interior_planestart_20"] = % dx_vom_had_safehouse_interior_planestart_20_face;
  level.scr_face["hadir"]["dx_vom_had_safehouse_interior_planestart_30"] = % dx_vom_had_safehouse_interior_planestart_30_face;
  level.scr_face["hadir"]["dx_vom_had_safehouse_interior_planestart_40"] = % dx_vom_had_safehouse_interior_planestart_40_face;
  level.scr_face["farah"]["dx_vom_far_pre_charge_setup_120"] = % dx_vom_far_pre_charge_setup_120_face;
  level.scr_face["farah"]["dx_vom_far_pre_charge_setup_140"] = % dx_vom_far_pre_charge_setup_140_face;
  level.scr_face["farah"]["dx_vom_far_pre_charge_prep_30"] = % dx_vom_far_pre_charge_prep_30_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_61"] = % dx_vom_had_armory_02_breach_61_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_62"] = % dx_vom_had_armory_02_breach_62_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_63"] = % dx_vom_had_armory_02_breach_63_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_100"] = % dx_vom_had_armory_02_breach_100_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_111"] = % dx_vom_had_armory_02_breach_111_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_112"] = % dx_vom_had_armory_02_breach_112_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_113"] = % dx_vom_had_armory_02_breach_113_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_120"] = % dx_vom_had_armory_02_breach_120_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_130"] = % dx_vom_had_armory_02_breach_130_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_161"] = % dx_vom_had_armory_02_breach_161_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_162"] = % dx_vom_had_armory_02_breach_162_face;
  level.scr_face["hadir"]["dx_vom_had_armory_02_breach_163"] = % dx_vom_had_armory_02_breach_163_face;
  level.scr_face["hadir"]["dx_vom_had_fly_success_10"] = % dx_vom_had_fly_success_10_face;
}

init_vfx() {}

init_level() {
  scripts\engine\utility::flag_init("fly_attack_done");
  scripts\engine\utility::flag_init("player_in_drone");
  level.allies = [];
  level.fob_enemies = [];
  level.drone_start_position = undefined;
  level.current_visionset = "";
  setsaveddvar("OMOLNOMPRO", 0);
  setsaveddvar("MKNNNONLSK", 4);
  setdvarifuninitialized("level_convoyVehiclesDebug", 0);
  setdvarifuninitialized("jump_enemyVehicleDebug", 0);
  var_0 = ["molotov", "frag", "flash"];
  level.player.offhands_list = var_0;
  scripts\engine\sp\utility::offhandprecache(var_0);
  scripts\engine\utility::noself_delaycall(0.2, ::visionsetmissilecam, "rc_plane", 0.5);
  scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::fob_spawn_funcs();
}

init_player() {
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::track_player_combat_time();
  level.player setviewmodel("viewmodel_arms_alex_desert");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_alex_desert");
  level.player setshadowmodel("default_character_shadow");

  foreach(var_1 in level.player.offhandinventory)
  level.player takeweapon(var_1);

  level.player setmovingplatformplayerturnrate(0);
  scripts\sp\equipment\incendiarylauncher::init();
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_droneinit();
}

intro_start() {
  player_giveprimaryweapon();
  player_givesecondaryweapon();
  player_givemolotovweapon();
}

intro_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("Intro to Rooftops");
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  var_1 = newclienthudelem(level.player);
  var_1.color = (1, 1, 1);
  var_1 settext("3 Hours Later");
  var_1.x = 0;
  var_1.y = -20;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 1;
  var_1.alpha = 1;
  var_1.fontscale = 3.0;
  var_1.hidewhendead = 1;
  var_1.sort = 3;
  var_2 = 4.0;
  wait(var_2);
  var_3 = 5.0;
  var_1 fadeovertime(var_3 * 0.25);
  var_1.alpha = 0;
  var_0 fadeovertime(var_3);
  var_0.alpha = 0;
}

fly_start() {
  player_giveprimaryweapon();
  player_givesecondaryweapon();
  player_givemolotovweapon();
  level.player.playeroriginalweapon = level.player.currentweapon;
  scripts\engine\utility::flag_set("intro_player_behind_hadir");
  scripts\engine\utility::flag_set("player_has_tablet");
}

fly_main() {
  thread inverted_pop_up();
  thread pumpjacks();
  setmusicstate("");
  level.player.fly_start = 1;
  var_0 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_thread(var_0, ::tarmac_model_init);
  var_1 = getEntArray("destroyed_tarmac_models", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::hide);
  thread fly_tarmac_blima_01();
  thread fly_tarmac_blima_02();
  wait 0.2;
  var_2 = fly_getplayerdronestartnode();
  var_3 = var_2.origin;
  var_4 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_usedrone(var_3, var_2.angles, 84, 100, 100);
  var_4.targetname = "fly_playerDrone";
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::dialogue_fly();
  level.allydrones = [];
  var_5 = fly_getallydronestartnodes();

  foreach(var_7 in var_5) {
    var_8 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::level_dronespawnVehicle(var_7.origin, var_7.angles);
    var_8.maxhealth = 30000;
    var_9 = scripts\engine\utility::is_equal(var_7.script_noteworthy, "fly_allyDroneNearPlayer");
    thread fly_allydronepathlogic(var_8, var_7, var_9);
    level.allydrones = scripts\engine\utility::array_add(level.allydrones, var_8);
  }

  thread tarmac_nav_obstacles();
  var_11 = fly_spawnenemies();
  thread fly_enemieslogic(var_11, undefined, level.allydrones, var_4);
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::tromeo_vehicle_tarmac_00();
  thread fly_hintlogic();
  var_4 thread player_drone_damage(var_11[0]);
  var_12 = gettime();
  level.player waittill("player_exitDrone", var_13);
  var_14 = fly_getplayerdronesuccessvolume();

  if(!ispointinvolume(var_13, var_14) && var_12 + 25000 > gettime()) {
    var_15 = ["dx_vom_had_fly_missfail_10", "dx_vom_had_fly_missfail_20", "dx_vom_had_fly_missfail_30"];
    level thread scripts\engine\sp\utility::smart_radio_dialogue_interrupt(scripts\engine\utility::random(var_15));
    level notify("fly_crash_missed");
    setDvar("scr_shf_invert", 1);
    level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
    level.blackoverlay fadeovertime(0.2);
    level.blackoverlay.alpha = 1;
    scripts\sp\player_death::set_custom_death_quote(51);
    scripts\sp\utility::missionfailedwrapper();
    level waittill("forever");
  }

  if(istrue(0))
    wait 0;

  scripts\engine\utility::flag_set("fly_attack_done");
  level.player.fly_start = undefined;
}

pumpjacks() {
  var_0 = getEntArray("pumpjacks", "targetname");

  foreach(var_2 in var_0) {
    var_2.animname = "pumpjack";
    var_2 scripts\engine\sp\utility::assign_animtree("pumpjack");
    var_2 thread scripts\common\anim::anim_loop_solo(var_2, "pumpjack_idle");
  }

  scripts\engine\utility::flag_wait("fly_attack_done");
  scripts\engine\utility::array_delete(var_0);
}

inverted_pop_up() {
  level endon("fly_attack_done");
  wait 0.5;
  var_0 = gettime() + 2000;

  if(level.player usinggamepad())
    var_1 = level.player getlocalplayerprofiledata("invertPitchGamepad") || level.player getlocalplayerprofiledata("invertPitchFlyingGamepad");
  else
    var_1 = level.player getlocalplayerprofiledata("invertPitchKBM");

  if(var_1 >= 1) {
    return;
  }
  while(gettime() < var_0) {
    if(level.pitchdelta < 0.1) {
      scripts\engine\sp\utility::display_hint_forced("flight_invert", 3, undefined, level.player, "invert_pressed");
      break;
    }

    if(level.pitchdelta >= 0.1) {
      break;
    }

    waitframe();
  }
}

fly_tarmac_blima_01() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("fly_blima_01");
  var_1 = scripts\engine\utility::getStruct("fly_blima_01_struct", "targetname");
  var_0 endon("death");
  var_0 scripts\common\vehicle::godon();
  var_0 thread fly_blima_god_mode_off();
  var_0 thread fly_blima_death();
  var_0.clip = getEnt("fly_blima_01_clip", "targetname");
  var_0.clip linkTo(var_0);
  var_0 thread scripts\engine\utility::delete_on_death(var_0.clip);
  level.choppers[level.choppers.size] = var_0;
  var_0 vehicle_setspeedimmediate(60, 10);
  var_0 vehicle_teleport(var_1.origin + (0, 0, 1500), var_1.angles);
  var_0 settargetyaw(var_1.angles[1]);
  var_0 hidepart("TAG_MAIN_ROTOR_STATIC");
  var_0 hidepart("TAG_TAIL_ROTOR_STATIC");
  var_1 = var_1 scripts\engine\utility::get_target_ent();
  var_0 setvehgoalpos(var_1.origin + (0, 0, 200), 0);
  var_0 thread blima_clean_up();
  var_0 vehicle_turnengineoff();
  var_0 thread blima_engine_sound();
  var_0 waittill("goal");
  var_1 = var_1 scripts\engine\utility::get_target_ent();
  var_0 setvehgoalpos(var_1.origin + (0, 0, 0), 1);
  var_0 vehicle_setspeed(10, 10, 5);
  var_0 setneargoalnotifydist(200);
  var_0 waittill("near_goal");
  var_0 vehicle_setspeed(10, 10, 5);
  var_0 setvehgoalpos(var_1.origin + (0, 500, 1000), 1);
  scripts\engine\utility::flag_wait("fly_attack_done");
  wait 0.75;
  var_0 scripts\common\vehicle::godoff();
  var_0 thread delete_fly_choppers();
  var_0 kill();
}

fly_blima_god_mode_off() {
  wait 1;
  self endon("entitydeleted");
  self endon("death");
  self endon("fly_attack_done");
  level.player_dronemodel endon("death");
  level.player_dronemodel endon("missile_stuck");
  level.player_dronemodel endon("entitydeleted");

  for(;;) {
    if(distance(self.origin, level.player_dronemodel.origin) < 1500) {
      break;
    }

    wait 0.1;
  }

  scripts\common\vehicle::godoff();
}

delete_fly_choppers() {
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("bunker_busted");
  self delete();
}

fly_blima_death() {
  self waittill("death", var_0);

  if(var_0 != level.player) {
    return;
  }
  level.fly_player_hit_helo = 1;
}

fly_tarmac_blima_02() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("fly_blima_02");
  var_1 = scripts\engine\utility::getStruct("fly_blima_02_struct", "targetname");
  var_0.clip = getEnt("fly_blima_02_clip", "targetname");
  var_0.clip linkTo(var_0);
  var_0 thread scripts\engine\utility::delete_on_death(var_0.clip);
  level.choppers[level.choppers.size] = var_0;
  var_0 endon("death");
  var_0 scripts\common\vehicle::godon();
  var_0 thread fly_blima_god_mode_off();
  var_0 thread fly_blima_death();
  var_0 vehicle_setspeedimmediate(55, 10);
  var_0 vehicle_teleport(var_1.origin + (0, 0, 500), var_1.angles);
  var_0 setneargoalnotifydist(500);
  var_0 hidepart("TAG_MAIN_ROTOR_STATIC");
  var_0 hidepart("TAG_TAIL_ROTOR_STATIC");
  var_1 = var_1 scripts\engine\utility::get_target_ent();
  var_0 setvehgoalpos(var_1.origin, 0);
  var_0 thread blima_clean_up();
  var_0 vehicle_turnengineoff();
  var_0 thread blima_engine_sound();
  var_0 waittill("goal");
  var_1 = var_1 scripts\engine\utility::get_target_ent();
  var_0 setvehgoalpos(var_1.origin + (0, 0, 400), 0);
  var_0 settargetyaw(var_1.angles[1]);
  var_0 setneargoalnotifydist(1000);
  var_0 waittill("near_goal");
  var_0 vehicle_setspeed(15, 10, 5);
  var_0 setvehgoalpos(var_1.origin + (0, 0, 150), 1);
  var_0 waittill("goal");
  var_0 sethoverparams(0, 0, 0);
  var_0 vehicle_setspeed(10, 10, 5);
  var_0 setvehgoalpos(var_1.origin + (0, 500, 800), 1);
  scripts\engine\utility::flag_wait("fly_attack_done");
  var_0 scripts\common\vehicle::godoff();
  var_0 thread delete_fly_choppers();
  var_0 kill();
}

blima_clean_up() {
  self waittill("death");
  waitframe();

  if(!istrue(self.vehiclecrashing)) {
    return;
  }
  self waittill("vehicle_crashDone");
  self delete();
}

blima_engine_sound() {
  var_0 = self gettagorigin("tag_origin");
  var_1 = spawn("script_model", var_0);
  var_1 linkTo(self, "tag_origin");
  var_1 playLoopSound("scn_safehouse_rc_plane_heli_lp");
  thread blima_engine_sound_death_watch();
  thread blima_engine_sound_done_watch();
  self waittill("stop_engine_sound");

  if(isDefined(self))
    self vehicle_turnengineon();

  if(isDefined(var_1)) {
    var_1 stopsounds();
    waitframe();
    var_1 delete();
  }
}

blima_engine_sound_done_watch() {
  scripts\engine\utility::flag_wait("fly_attack_done");
  self notify("stop_engine_sound");
}

blima_engine_sound_death_watch() {
  while(isDefined(self)) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_rc_plane_heli_death");
      self notify("stop_engine_sound");
    }
  }
}

fly_catchup() {
  scripts\engine\utility::noself_delaycall(0.2, ::visionsetmissilecam, "safehouse_finale_fob_missilecam", 0.5);
  scripts\engine\utility::flag_set("player_has_tablet");
  scripts\engine\utility::flag_set("intro_player_behind_hadir");
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\utility::flag_set("start_fly_countdown");
  thread pumpjacks();
}

player_drone_damage(var_0) {
  self endon("death");
  wait 16;
  magicbullet("iw8_lm_pkilo", (-40741, 30946, -604), self.origin + (0, 0, 30));
  wait 0.1;
  magicbullet("iw8_lm_pkilo", (-40741, 30946, -604), self.origin);
  wait 0.1;
  magicbullet("iw8_lm_pkilo", (-40741, 30946, -604), self.origin);
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dronedamagevisionlogic();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dronedamageeffectslogic();
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dronedamagerotatelogic(var_0);
}

tarmac_nav_obstacles() {
  level.tarmac_bad_places_ids = [];
  var_0 = getEntArray("tarmac_bad_places", "targetname");

  foreach(var_2 in var_0)
  level.tarmac_bad_places_ids[level.tarmac_bad_places_ids.size] = createnavbadplacebyent(var_2, "axis");

  scripts\engine\utility::flag_wait("fly_attack_done");

  foreach(var_5 in level.tarmac_bad_places_ids)
  destroynavobstacle(var_5);
}

tarmac_model_init() {
  self setCanDamage(1);
  thread tarmac_damaged_model_swaps();

  if(!scripts\engine\utility::is_equal(self.model, "veh8_mil_air_blima")) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_blue"), self, "tag_light_cockpit01");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_white_blink_lit"), self, "tag_light_belly");
  playFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_green_lit"), self, "tag_light_R_wing");
  thread fx_kill_watcher();
}

fx_kill_watcher() {
  scripts\engine\utility::flag_wait("fly_attack_done");
  self notify("kill_fx");
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_cockpit_blue"), self, "tag_light_cockpit01");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_white_blink_lit"), self, "tag_light_belly");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("blima_light_wingtip_green_lit"), self, "tag_light_R_wing");
}

tarmac_damaged_model_swaps() {
  self.dmg_models = scripts\engine\utility::get_target_array();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(scripts\engine\utility::is_equal(var_4, "MOD_PROJECTILE")) {
      break;
    }
  }

  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_pipe_bomb_explo"), self.dmg_models[0], "tag_origin");
  wait 0.1;
  self notify("kill_fx");
  scripts\engine\utility::array_call(self.dmg_models, ::show);
  self hide();
}

fly_hintlogic() {
  var_0 = fly_getplayerdrone();
  var_0 endon("death");
  var_1 = anglesToForward(var_0.angles);
  scripts\engine\sp\utility::display_hint("drone_pilot", undefined, 7);

  for(;;) {
    var_2 = anglesToForward(var_0.angles);
    var_3 = scripts\engine\math::anglebetweenvectors(var_2, var_1);

    if(var_3) {
      break;
    }

    waitframe();
  }

  level.player notify("new_hint");
}

fly_allydroneflynearplayerupdate(var_0) {
  var_1 = fly_getplayerdrone();
  var_1 endon("death");
  var_2 = 100;
  var_3 = var_2 + 20;
  var_4 = var_2 + -20;
  var_5 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::entity_getbehindforwarddistance(var_1, var_0);

  if(var_5 > 600)
    var_0 vehicle_setspeed(var_4, 20, 20);
  else if(var_5 < 400)
    var_0 vehicle_setspeed(var_3, 20, 20);
  else
    var_0 vehicle_setspeed(100, 20, 20);
}

fly_getplayerdrone() {
  return getEnt("fly_playerDrone", "targetname");
}

fly_getplayerdronestartnode() {
  return getvehiclenode("fly_playerDroneStartNode", "targetname");
}

fly_getallydronestartnodes() {
  return getvehiclenodearray("fly_allyDroneStartNode", "targetname");
}

fly_getplayerdronesuccessvolume() {
  return getEnt("fly_playerDroneSuccessVolume", "targetname");
}

fly_allydronepathlogic(var_0, var_1, var_2, var_3) {
  var_0 endon("entitydeleted");
  var_4 = fly_getplayerdrone();

  if(scripts\engine\utility::flag("player_has_tablet"))
    playFXOnTag(level._effect["vfx_safehouse_finale_drone_contrails"], var_0, "tag_origin");

  waitframe();
  playFXOnTag(level._effect["vfx_safehouse_finale_drone_heat_dist"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_safehouse_finale_drone_wingtip_red_lit"], var_0, "tag_origin");
  var_0 attachpath(var_1);
  var_0 thread scripts\common\vehicle::vehicle_paths(var_1);
  scripts\common\vehicle_paths::gopath(var_0);
  var_5 = var_0 scripts\common\vehicle::vehicle_get_path_array();
  var_6 = var_5.size - 1;
  var_7 = randomfloatrange(90.9091, 142.046);

  if(scripts\engine\utility::flag_exist("fob_center")) {
    if(scripts\engine\utility::flag("fob_center"))
      var_7 = var_7 / 4;
  }

  var_0 vehicle_setspeedimmediate(var_7, 100, 100);

  while(isDefined(var_4)) {
    fly_allydroneflynearplayerupdate(var_0);
    var_8 = getvehiclenode(var_0.currentnode.target, "targetname");

    if(!isDefined(var_8.target)) {
      var_0.nextnode = var_8;
      break;
    }

    waitframe();
  }

  var_0 vehicle_setspeed(var_7 * 50.0 * 0.0568182, 20);
  var_0 notsolid();
  var_0 scripts\engine\utility::waittill_any_timeout(8, "reached_end_node");
  radiusdamage(var_0.origin + (0, 0, 50), 250, 500, 500, level.player, "MOD_PROJECTILE", undefined, 0, 0);
  playFX(level._effect["vfx_safehouse_ally_drone_impact"], var_0.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_rc_plane_death", var_0.origin);
  var_0 delete();
}

drone_destroy_catcher() {}

fly_spawnenemies() {
  var_0 = fly_getenemyspawners();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_4 scripts\engine\sp\utility::set_maxsightdistsquared(225000000);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

fly_getenemyspawners() {
  return getspawnerarray("fly_enemySpawner");
}

fly_spawnenemyvehicles() {
  var_0 = fly_getenemyvehiclespawners();
  level.enemy_vehicles = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
    var_3.vehicle_skipdeathcrash = 1;
    var_3.vehicle_skipdeathmodel = 1;
    level.enemy_vehicles = scripts\engine\utility::array_add(level.enemy_vehicles, var_3);
  }

  return level.enemy_vehicles;
}

fly_getenemyvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("fly_enemyVehicleSpawner", "targetname");
}

fly_spawnallyvehicles() {
  var_0 = fly_getallyvehiclespawners();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_4 scripts\common\vehicle::godon();
    var_4 vehicle_setspeedimmediate(70, 9999);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

fly_getallyvehiclespawners() {
  return scripts\common\utility::getvehiclespawnerarray("fly_allyVehicleSpawner", "targetname");
}

fly_enemieslogic(var_0, var_1, var_2, var_3) {
  var_4 = fly_getplayerdrone();
  var_5 = fly_getenemynodes();
  var_4 endon("death");
  var_6 = (0, 0, 0);

  foreach(var_8 in var_5)
  var_6 = var_6 + var_8.origin;

  var_6 = var_6 / var_5.size;

  while(distancesquared(var_6, var_4.origin) > 100000000)
    waitframe();

  thread enemies_shoot_down_nearest(var_3);
  var_3 scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dronesetvehspeed(60, 62, 64, 2);

  while(distancesquared(var_6, var_4.origin) > 169000000)
    waitframe();

  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::array_removedeaddyingorundefined(var_0);

  foreach(var_11 in var_0) {
    var_11 scripts\engine\utility::set_movement_speed(240);
    var_11 scripts\engine\sp\utility::set_goalRadius(256);
    var_11 scripts\engine\sp\utility::set_ignoreall(1);
  }

  foreach(var_11 in var_0) {
    var_8 = sortbydistance(var_5, var_11.origin)[0];
    var_11 setgoalnode(var_8);
  }
}

enemies_shoot_down_nearest(var_0) {
  var_0 endon("death");
  wait 4;
  level.allydrones = scripts\engine\utility::array_removeundefined(level.allydrones);
  var_1 = level.allydrones[0];
  var_2 = -9999999;
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in level.allydrones) {
    var_6 = vectorNormalize(var_5.origin - var_0.origin);
    var_7 = vectordot(var_3, var_6);

    if(var_7 > var_2) {
      var_2 = var_7;
      var_1 = var_5;
    }
  }

  if(isDefined(var_1))
    var_1 kill();

  wait 1;
  level.allydrones = scripts\engine\utility::array_removeundefined(level.allydrones);
  var_1 = level.allydrones[0];
  var_2 = -9999999;
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in level.allydrones) {
    var_6 = vectorNormalize(var_5.origin - var_0.origin);
    var_7 = vectordot(var_3, var_6);

    if(var_7 > var_2) {
      var_2 = var_7;
      var_1 = var_5;
    }
  }

  if(isDefined(var_1))
    var_1 kill();

  wait 1;
  level.allydrones = scripts\engine\utility::array_removeundefined(level.allydrones);
  var_1 = level.allydrones[0];
  var_2 = -9999999;
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in level.allydrones) {
    var_6 = vectorNormalize(var_5.origin - var_0.origin);
    var_7 = vectordot(var_3, var_6);

    if(var_7 > var_2) {
      var_2 = var_7;
      var_1 = var_5;
    }
  }

  if(isDefined(var_1))
    var_1 kill();
}

fly_allydronesshotdownlogic(var_0) {
  var_1 = 0.25;
  var_2 = 1.0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(istrue(var_4.script_bulletshield)) {
      continue;
    }
    var_4.vehicle_skipdeathmodel = 1;
    var_4 kill();
    var_5 = randomfloatrange(var_1, var_2);
    wait(var_5);
  }
}

fly_getenemynodes() {
  return getnodearray("fly_enemyNode", "targetname");
}

explosion_gethellcannonstructs() {
  return scripts\engine\utility::getStructArray("explosion_hellCannonStruct", "targetname");
}

explosion_gethellcannontargetstructs() {
  return scripts\engine\utility::getStructArray("explosion_hellCannonTargetStruct", "targetname");
}

board_getallydronestartnodes() {
  return getvehiclenodearray("board_allyDroneStartNode", "targetname");
}

getallyspawners() {
  return getspawnerarray("allySpawner");
}

spawnallies(var_0) {
  var_1 = getallyspawners();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(isDefined(var_0) && var_0 < var_6 + 1) {
      continue;
    }
    var_5 = var_4 scripts\engine\sp\utility::spawn_ai(1);
    var_5.targetname = "allySpawner";
    var_5 thread scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::fob_allies_spawn_setup();
    var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  return var_2;
}

getallies() {
  return getEntArray("allySpawner", "targetname");
}

trench_spawnallies() {
  var_0 = trench_getallyspawners();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1, 1);
    var_4.targetname = "trench_ally";
    var_4 visiblenotsolid();
    var_4 thread scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc::fob_allies_spawn_setup();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

trench_getallyspawners() {
  var_0 = getspawnerarray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "trench_allySpawner"))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

trench_getrocketally() {
  return getEnt("trench_rocketAlly", "targetname");
}

rocket_deletepristinetargets() {
  var_0 = rocket_getpristinetargets();

  foreach(var_2 in var_0)
  var_2 delete();
}

rocket_getpristinetargets() {
  return getEntArray("rocket_targetPristine", "targetname");
}

rocket_setnotsolidtargets() {
  var_0 = getEntArray("not_solid", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 notsolid();
}

rocket_getdamagedtargets() {
  return getEntArray("rocket_targetDamaged", "targetname");
}

rocket_hidedamagedtargets() {
  var_0 = rocket_getdamagedtargets();

  foreach(var_2 in var_0)
  var_2 hide();
}

rocket_showdamagedtargets() {
  var_0 = rocket_getdamagedtargets();

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();

    if(var_2.spawnflags & 1)
      var_2 connectpaths();
  }
}

player_giveprimaryweapon() {
  var_0 = player_getprimaryweaponobject();
  level.player scripts\sp\utility::give_weapon(var_0);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
}

player_givemolotovweapon() {
  level.player scripts\engine\sp\utility::give_offhand("molotov");
  level.player givemaxammo("molotov");
}

player_givegunlessweapon() {
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
}

player_giverpgweapon() {
  level.player giveweapon("iw8_la_rpapa7_straight_slow");
  level.player switchtoweapon("iw8_la_rpapa7_straight_slow");
}

player_getprimaryweaponobject() {
  return scripts\sp\utility::make_weapon("iw8_sn_kilo98", ["snprscope_kilo98"]);
}

player_usingprimaryweaponaltmode() {
  if(!scripts\engine\utility::is_equal(level.player.currentweapon.inventorytype, "altmode"))
    return 0;

  return 1;
}

hide_molotov_hint() {
  return level.player fragButtonPressed() || scripts\engine\utility::flag("molotov_used");
}

ammo_count() {
  while(!scripts\engine\utility::flag("fob_center")) {
    if(level.player getammocount(getcompleteweaponname("molotov")) < 4) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("molotov_used");
}

hide_drone_hint() {
  return scripts\engine\utility::flag("player_in_drone");
}

autosave_block_in_drone() {
  return !scripts\engine\utility::flag("player_in_drone");
}

hide_chopper_hint() {
  return scripts\engine\utility::flag("air_support_inbound");
}

hide_chopper_rocket_hint() {
  return level.player fragButtonPressed() || scripts\engine\utility::flag("killstreak_complete") || scripts\engine\utility::flag("chopper_rockets_pressed");
}

hide_chopper_guns_hint() {
  return level.player attackButtonPressed() || scripts\engine\utility::flag("killstreak_complete") || scripts\engine\utility::flag("chopper_guns_pressed");
}

hide_chopper_zoom_hint() {
  return level.player adsButtonPressed() || scripts\engine\utility::flag("killstreak_complete") || scripts\engine\utility::flag("chopper_zoom_pressed");
}

hide_drone_sprint_hint() {
  return level.player attackButtonPressed();
}

hide_drone_detonate_hint() {
  return level.player useButtonPressed();
}

hide_apache_forward_hint() {
  return level.player stick_forward() || scripts\engine\utility::flag("killstreak_complete");
}

hide_apache_retreat_hint() {
  return level.player useButtonPressed() || scripts\engine\utility::flag("killstreak_complete") || scripts\engine\utility::flag("disengage_apache");
}

stick_forward() {
  return self getnormalizedmovement()[0] > 0.5;
}

player_givesecondaryweapon(var_0) {
  var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.player scripts\sp\utility::give_weapon(var_1);
  level.player givemaxammo(var_1);

  if(istrue(var_0))
    level.player switchtoweapon(var_1);
}

hero_battlechattteradjustments() {
  while(!isDefined(self.battlechatter))
    waitframe();

  self.battlechatter.overrides = spawnStruct();
  self.battlechatter.overrides.eventtypeminwait["reaction"]["casualty"] = 1000;
  self.battlechatter.overrides.eventpriority["reaction"]["casualty"] = 0.99;
  self.battlechatter.overrides.eventduration["reaction"]["casualty"] = 3000;
}

level_spawnfarah() {
  var_0 = level_getfarahspawner();
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "farah";
  var_1.targetname = "level_farah";
  var_1.name = "Farah";
  var_1.disableplayeradsloscheck = 1;
  var_1.nodropgrenade = 1;
  var_1.grenadeweapon = getcompleteweaponname("molotov");
  var_1.grenadeammo = 255;
  var_1.grenadesafedist = 400;
  var_1.allowdeath = 1;
  var_1 pushplayer(1);
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1.ignoreme = 0;
  var_1.support_equipment = 0;
  level.farah = var_1;
  level.player.molotov_take = create_molotov_take_deck();
  var_2 = ["dx_vom_far_bunkers_molotovgive_40", "dx_vom_far_bunkers_molotovgive_50", "dx_vom_far_bunkers_molotovgive_60"];
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(var_1, "molotov");
  var_1 thread level_vo_equipment_backpack(level.player.molotov_take, var_2);
  var_1 thread molotov_notify();
  var_1 thread hero_battlechattteradjustments();
  return var_1;
}

level_spawnarmen() {
  var_0 = level_getarmenspawner();
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "armen";
  var_1.allowdeath = 1;
  var_1.name = "Armen";
  var_1.disablebulletwhizbyreaction = 1;
  var_1 scripts\common\ai::magic_bullet_shield();
  level.armen = var_1;
  return var_1;
}

create_molotov_take_deck() {
  if(isDefined(level.player.molotov_take))
    return level.player.molotov_take;

  var_0 = ["dx_vom_alx_bunkers_molotovtake_10", "dx_vom_alx_bunkers_molotovtake_20", "dx_vom_alx_bunkers_molotovtake_30"];
  return scripts\engine\sp\utility::create_deck(var_0);
}

molotov_notify() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire");
    self.grenadeammo = 0;
    wait 5;
    self.grenadeammo = 255;
  }
}

level_getfarahspawner() {
  return getspawner("level_farahSpawner", "targetname");
}

level_getarmenspawner() {
  return getspawner("level_ArmenSpawner", "targetname");
}

level_getfarah() {
  return getEnt("level_farah", "targetname");
}

level_spawnhadir() {
  var_0 = level_gethadirspawner();
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "hadir";
  var_1.targetname = "level_hadir";
  var_1.name = "Hadir";
  var_1.disableplayeradsloscheck = 1;
  var_1.dontmelee = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.allowdeath = 1;
  var_1.nodropgrenade = 1;
  var_1.grenadeweapon = getcompleteweaponname("molotov");
  var_1.grenadeammo = 255;
  var_1.grenadesafedist = 400;
  var_1 thread molotov_notify();
  var_1 pushplayer(1);
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1.support_equipment = 0;
  level.hadir = var_1;
  level.player.molotov_take = create_molotov_take_deck();
  var_2 = ["dx_vom_had_bunkers_molotovgive_10", "dx_vom_had_bunkers_molotovgive_20", "dx_vom_had_bunkers_molotovgive_30"];
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(var_1, "molotov");
  var_1 thread level_vo_equipment_backpack(level.player.molotov_take, var_2);
  var_1 thread hero_battlechattteradjustments();
  return var_1;
}

level_vo_equipment_backpack(var_0, var_1) {
  level.player endon("death");
  self endon("death");
  self endon("remove_equipment");
  self endon("stop_equipment_vo");

  if(isarray(var_0))
    var_1 = scripts\engine\sp\utility::create_deck(var_0);

  if(isarray(var_1))
    var_1 = scripts\engine\sp\utility::create_deck(var_1);

  for(;;) {
    self.icon_spot waittill("trigger");
    level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_0 scripts\engine\sp\utility::deck_draw(), 0, 0.1);
    scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 0.15);
  }
}

level_droneambientspawnmanager() {
  wait 1;
  var_0 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var_1 = 2;
  var_2 = (-31234, 31084, -250);
  var_3 = 10;
  var_4 = 775;
  var_5 = 800;
  var_6 = 0.85;
  var_7 = 1.0;
  var_8 = [scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::math_pointoncircle, scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::math_pointonellipse, scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::math_pointonlemniscate];

  for(var_9 = 0; var_9 < var_1; var_9++) {
    var_10 = scripts\engine\utility::random(var_8);
    var_11 = (0, 0, var_3 * var_9);
    var_12 = randomintrange(var_4, var_5);
    var_13 = randomfloatrange(var_6, var_7);
    var_14 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::level_dronespawn(var_2 + var_11, (0, 0, 0));
    playFXOnTag(level._effect["vfx_safehouse_finale_drone_wingtip_red_lit"], var_14, "tag_origin");
    thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::level_droneambientmovementlogic(var_14, var_12, var_13, var_10);
  }
}

level_gethadirspawner() {
  return getspawner("level_hadirSpawner", "targetname");
}

level_gethadir() {
  return getEnt("level_hadir", "targetname");
}

level_hellcannonfire(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 setModel("misc_propane_rocket");
  var_3.sound_tag = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_3.sound_tag linkTo(var_3);
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_hellcannon_fire", var_0.origin);
  playFX(scripts\engine\utility::getfx("vfx_hellcannon_fire"), var_0.origin, anglestoup(var_0.angles));
  playFXOnTag(scripts\engine\utility::getfx("vfx_hellcannon_trail"), var_3, "tag_origin");
  playrumbleonposition("damage_light", level.player.origin);
  screenshake(level.player.origin, 4, 0, 0, 0.25);
  var_3.sound_tag scripts\engine\utility::delaythread(0.2, scripts\engine\utility::playsoundontag, "scn_safehouse_hellcannon_inc", "tag_origin");
  level_hellcannonmovetank(var_3, var_0.origin, var_1.origin, var_2);
  stopFXOnTag(scripts\engine\utility::getfx("vfx_hellcannon_trail"), var_3, "tag_origin");
  level_hellcannonimpactlogic(var_1.origin);
  var_3.sound_tag delete();
  var_3 delete();
}

level_hellcannonmovetank(var_0, var_1, var_2, var_3) {
  var_0 endon("impact");
  var_0.origin = var_1;
  var_4 = getdvarint("NPOQPMP");
  setsaveddvar("NPOQPMP", 500);
  var_5 = getdvarint("NPOQPMP");
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_5 * squared(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  var_0 movegravity(var_8, var_3);
  var_0 rotateby((0, 0, -40), var_3);
  wait(var_3 + 0.05);
  var_0.origin = var_2;
  setsaveddvar("NPOQPMP", var_4);
}

level_hellcannonimpactlogic(var_0) {
  level notify("level_hellCannonImpact");
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_hellcannon_impact", var_0 + (0, 0, 300));
  var_1 = "vfx_safehouse_finale_bunker_explosion";

  if(scripts\engine\utility::flag("second_cannon") && scripts\engine\utility::flag("bunker_busted"))
    var_1 = "vfx_safehouse_finale_bunker_explosion_2";

  playFX(scripts\engine\utility::getfx(var_1), var_0);
}

dialogue_hadirstruct(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.animname = "hadir";
  var_5.name = "Hadir";
  var_5 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dialogue(var_0, var_1, var_2, var_3, var_4);
}