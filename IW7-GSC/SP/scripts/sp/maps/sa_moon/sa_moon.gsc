/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon.gsc
***********************************************/

main() {
  scripts\sp\utility::_id_116CB("sa_moon");
  setdvarifuninitialized("e3_no_music", 0);
  setdvarifuninitialized("no_helmet", 2);
  scripts\sp\maps\sa_moon\gen\sa_moon_art::main();
  scripts\sp\maps\sa_moon\sa_moon_anim::main();
  scripts\sp\maps\sa_moon\sa_moon_breach::_id_E8FC();
  scripts\sp\maps\sa_moon\sa_moon_breach::_id_E8FD();
  scripts\sp\maps\sa_moon\sa_moon_breach::_id_E8FB();
  scripts\sp\maps\sa_moon\sa_moon_stealth_kill::_id_E969();
  scripts\sp\maps\sa_moon\sa_moon_stealth_kill::_id_E96A();
  scripts\sp\maps\sa_moon\sa_moon_fleet_data::_id_E92B();
  scripts\sp\maps\sa_moon\sa_moon_fleet_data::_id_E92D();
  scripts\sp\maps\sa_moon\sa_moon_fleet_data::_id_E92C();
  scripts\sp\maps\sa_moon\sa_moon_fx::main();
  scripts\sp\maps\sa_moon\sa_moon_precache::main();
  scripts\sp\maps\sa_moon\sa_moon_audio::main();
  _id_0F00::_id_25D8(24);
  _id_0EFE::_id_FD0B();
  _id_0F05::_id_FCF3();
  _id_0F10::_id_FCFE();
  _id_0F0B::_id_D7F7();
  setsaveddvar("r_umbraShadowCasters", 1);
  setsaveddvar("r_umbraMinObjectContribution", 4);
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("player_isInZeroGLevel", 1);
  setsaveddvar("objectiveFadeTooFar", 100);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  init_flags();
  _id_96F8();
  _id_0F0E::_id_D7F8();
  scripts\sp\maps\sa_moon\sa_moon_lighting::main();
  scripts\sp\maps\sa_moon\sa_moon_breach::_id_E966();
  scripts\sp\maps\sa_moon\sa_moon_lighting::_id_138F3(0);
  level._id_9334 = 1;
  _id_FA53();
  scripts\sp\utility::_id_1263F("sa_moon_exterior_tr");
  scripts\sp\utility::_id_1263F("sa_moon_exterior_ship_tr");
  scripts\sp\utility::_id_1263F("sa_moon_hull_tr");
  scripts\sp\utility::_id_1263F("sa_moon_bridge_tr");
  scripts\sp\utility::_id_1263F("sa_moon_interior_tr");
  scripts\sp\utility::_id_1263F("sa_moon_elevator_tr");
  scripts\sp\utility::_id_1263F("sa_moon_hallway_tr");
  scripts\sp\utility::_id_1263F("sa_moon_cargobay_tr");
  scripts\sp\utility::_id_1263F("sa_moon_exfil_tr");
  scripts\sp\utility::_id_1263F("sa_moon_ret_land_tr");
  scripts\sp\utility::_id_1263F("sa_moon_prime_tr");

  if(getDvar("createfx") != "") {
    level thread _id_0F16::_id_88CA("carrier_hull_rig");
    level thread _id_88CB();
  }

  scripts\sp\load::main();
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_E9C9();
  level._id_98C4 = scripts\sp\maps\sa_moon\sa_moon_util::_id_9716;
  level._id_241D = 0;
  level._id_5A3E = 1;
  _id_0F0C::_id_E9BF();
  level._id_3A94 = getEnt("cargobay_view_blocker", "targetname");
  level._id_3A94 hide();
  _id_0EFE::main();
  _id_0F05::_id_95B6();
  _id_0F04::_id_9587();
  _id_0F0B::_id_F8E7();
  _id_0F21::main();
  _id_0F00::_id_DED5();
  _id_0F0E::_id_F901();
  scripts\engine\utility::waitframe();
  _id_0F0E::_id_F900("carrier_hull_rig", "cannon_small_ca,1,1,amb_turret_ts_l_1:160:90:90:10,amb_turret_ts_l_3:90:90:90:10,amb_turret_ts_l_4:90:90:90:10,amb_turret_ts_l_5:90:90:90:10,amb_turret_ts_l_6:90:90:90:10,amb_turret_ts_l_7:90:90:90:10,amb_turret_ts_l_8:90:90:90:10,amb_turret_ts_r_2:90:90:90:10,amb_turret_ts_r_3:90:90:90:10,amb_turret_ts_r_4:90:90:90:10,amb_turret_ts_r_5:90:90:90:10,amb_turret_ts_r_6:90:90:90:10,amb_turret_ts_r_7:90:90:90:10,amb_turret_ts_r_8:90:90:90:10 cannon_flak_ca,1,1,amb_turret_l_1:90:90:75:10,amb_turret_l_3:1:1:1:1,amb_turret_l_4:90:90:75:10,amb_turret_l_5:90:90:75:10,amb_turret_l_6:90:90:75:10,amb_turret_r_1:90:90:75:10,amb_turret_r_2:90:90:75:10,amb_turret_r_3:90:90:75:10,amb_turret_r_4:90:90:75:10,amb_turret_r_5:90:90:75:10,amb_turret_r_6:90:90:75:10");
  thread _id_FA6B();
  _id_0B51::_id_B8CA("ret_land");
  level._id_FD6E._id_E35D hide();
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("hide");
  scripts\engine\utility::flag_set("hide_hull");

  if(isDefined(level._id_9DD0))
    level.player _meth_84FE();

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_C0B3();
  thread _id_0F16::_id_FA47();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF7();
}

init_flags() {
  scripts\engine\utility::flag_init("allies_spawned");
  scripts\engine\utility::flag_init("allies_spawned_zerog");
  scripts\engine\utility::flag_init("forever");
  scripts\engine\utility::flag_init("volumetrics_on");
  scripts\sp\maps\sa_moon\sa_moon_intro::_id_E94F();
  scripts\sp\maps\sa_moon\sa_moon_hull::_id_E93C();
  scripts\engine\utility::flag_init("breach_begin");
  scripts\engine\utility::flag_init("moon_breach_ender");
  scripts\engine\utility::flag_init("breach_detonation");
  scripts\engine\utility::flag_init("bridge_breach_started");
  scripts\engine\utility::flag_init("bridge_breach_anim_started");
  scripts\engine\utility::flag_init("bridge_breach_finished");
  scripts\engine\utility::flag_init("breach_end");
  scripts\engine\utility::flag_init("raising_the_shields");
  scripts\engine\utility::flag_init("breach_enemies_dead");
  scripts\engine\utility::flag_init("captain_key_card_spawned");
  scripts\engine\utility::flag_init("bridge_gravity_restoring");
  scripts\engine\utility::flag_init("bridge_gravity_restored");
  scripts\engine\utility::flag_init("interior_zg_begin");
  scripts\engine\utility::flag_init("interior_zg_end");
  scripts\engine\utility::flag_init("player_finished_breach_enter");
  scripts\engine\utility::flag_init("captain_key_card_pickup_started");
  scripts\engine\utility::flag_init("captain_key_card_picked_up");
  scripts\engine\utility::flag_init("breach_entry_ethan_inside");
  scripts\engine\utility::flag_init("move_to_elevator");
  scripts\engine\utility::flag_init("ethan_at_elevator");
  scripts\engine\utility::flag_init("omar_at_elevator");
  scripts\engine\utility::flag_init("salter_at_elevator");
  scripts\engine\utility::flag_init("move_allies_into_maintenance_tunnel");
  scripts\engine\utility::flag_init("salter_in_maintenance_tunnel");
  scripts\engine\utility::flag_init("omar_in_maintenance_tunnel");
  scripts\engine\utility::flag_init("ethan_in_maintenance_tunnel");
  scripts\engine\utility::flag_init("sealing_the_room_vo_done");
  scripts\engine\utility::flag_init("ethan_elevator_exit_finished");
  scripts\engine\utility::flag_init("omar_elevator_exit_finished");
  scripts\engine\utility::flag_init("salter_elevator_exit_finished");
  scripts\engine\utility::flag_init("e3_grapple_guy_dead");
  scripts\engine\utility::flag_init("e3_grapple_kill_wait");
  scripts\engine\utility::flag_init("player_started_elevator_scene");
  scripts\engine\utility::flag_init("player_wait_elevator_scene");
  scripts\engine\utility::flag_init("ethan_spawned");
  scripts\engine\utility::flag_init("omar_spawned");
  scripts\engine\utility::flag_init("salter_spawned");
  scripts\engine\utility::flag_init("maintenance_begin");
  scripts\engine\utility::flag_init("maintenance_end");
  scripts\engine\utility::flag_init("maintenance_hatch_01_opened");
  scripts\engine\utility::flag_init("maintenance_hatch_02_opened");
  scripts\engine\utility::flag_init("maintenance_tunnel_runners_alerted");
  scripts\engine\utility::flag_init("stealth_kill_begin");
  scripts\engine\utility::flag_init("stealth_kill_end");
  scripts\engine\utility::flag_init("stealth_kill_got_movement");
  scripts\engine\utility::flag_init("stealth_kill_guys_alerted");
  scripts\engine\utility::flag_init("stealth_kill_done");
  scripts\engine\utility::flag_init("stealth_kill_checkpoint_start");
  scripts\engine\utility::flag_init("fleet_data_begin");
  scripts\engine\utility::flag_init("fleet_data_end");
  scripts\engine\utility::flag_init("start_fleet_data_enabled");
  scripts\engine\utility::flag_init("fleet_data_patch_in");
  scripts\engine\utility::flag_init("fleet_data_patched_in");
  scripts\engine\utility::flag_init("fleet_data_downloaded");
  scripts\engine\utility::flag_init("fleet_data_move_out");
  scripts\engine\utility::flag_init("fleet_data_checkpoint_start");
  scripts\engine\utility::flag_init("fleet_data_bink_start");
  scripts\engine\utility::flag_init("fleet_data_ethan_done");
  scripts\engine\utility::flag_init("fleet_data_player_done");
  scripts\engine\utility::flag_init("fleet_data_player_unlinked");
  scripts\engine\utility::flag_init("hallway_wave2");
  scripts\engine\utility::flag_init("hallway_wave3");
  scripts\engine\utility::flag_init("hallway_guys_alerted");
  scripts\engine\utility::flag_init("hero_kill_start");
  scripts\engine\utility::flag_init("hallway_door_close");
  scripts\engine\utility::flag_init("hero_kill_over");
  scripts\engine\utility::flag_init("start_e3_from_hallway");
  scripts\engine\utility::flag_init("door_mal_2_start");
  scripts\engine\utility::flag_init("point_anim_vo_done");
  scripts\engine\utility::flag_init("cargobay_kickoff");
  scripts\engine\utility::flag_init("cargobay_anim_start");
  scripts\engine\utility::flag_init("turkeyshoot_alerted");
  scripts\engine\utility::flag_init("turkeyshoot_grenade");
  scripts\engine\utility::flag_init("turkeyshoot_over");
  scripts\engine\utility::flag_init("door_peek_reaction_over");
  scripts\engine\utility::flag_init("turkey_shoot_vo_done");
  scripts\engine\utility::flag_init("start_cargobay_wave2");
  scripts\engine\utility::flag_init("start_cargobay_wave3");
  scripts\engine\utility::flag_init("cargobay_amb_end");
  scripts\engine\utility::flag_init("cargobay_door_close");
  scripts\engine\utility::flag_init("cargo_move_out");
  scripts\engine\utility::flag_init("cargobay_main_waves_clear");
  scripts\engine\utility::flag_init("cargobay_checkpoint_start");
  scripts\engine\utility::flag_init("dropbay_triggered");
  scripts\engine\utility::flag_init("player_pressed_the_button");
  scripts\engine\utility::flag_init("spawn_anim_enemies");
  scripts\engine\utility::flag_init("start_c12_anim");
  scripts\engine\utility::flag_init("stop_fake_player_gunfire");
  scripts\engine\utility::flag_init("turn_exfil_gravity_off");
  scripts\engine\utility::flag_init("cargobay_zerog_active");
  scripts\engine\utility::flag_init("exfil_player_clear");
  scripts\engine\utility::flag_init("button_press_done");
  scripts\engine\utility::flag_init("zerog_enemies_dead");
  scripts\engine\utility::flag_init("player_using_grapple");
  scripts\engine\utility::flag_init("player_in_exfil_jackal");
  scripts\engine\utility::flag_init("carrier_dead");
  scripts\engine\utility::flag_init("player_jackal_grapple");
  scripts\engine\utility::flag_init("omar_salter_anim_arrival");
  scripts\engine\utility::flag_init("exfil_at_ret");
  scripts\engine\utility::flag_init("player_jackal_ready");
  scripts\engine\utility::flag_init("exfil_flyout_checkpoint_start");
  scripts\engine\utility::flag_init("flag_scipted_jackal_landing");
  scripts\engine\utility::flag_init("flag_end_cargobay_obj");
  scripts\engine\utility::flag_init("flag_acquire_lifesupport_obj");
  scripts\engine\utility::flag_init("flag_at_network_obj");
  scripts\engine\utility::flag_init("flag_exfil_obj");
  scripts\engine\utility::flag_init("flag_cargobay_exit_door_enabled");
  scripts\engine\utility::flag_init("flag_cargobay_exit_door");
  scripts\engine\utility::flag_init("flag_allies_landing");
  scripts\engine\utility::flag_init("sa01_hub_enemies_dead");
  scripts\engine\utility::flag_init("sickbay_enemies_spawned");
  scripts\engine\utility::flag_init("ethan_sickbay_hack");
  scripts\engine\utility::flag_init("sa01_flag_hub_combat_start");
  scripts\engine\utility::flag_init("sa01_flag_armory_wave2");
  scripts\engine\utility::flag_init("sa01_post_armory_start");
  scripts\engine\utility::flag_init("sa01_flag_start_exfil");
  _id_0F0E::_id_F902();

  if(!scripts\engine\utility::flag_exist("flag_armory_defend"))
    scripts\engine\utility::flag_init("flag_armory_defend");
}

_id_96F8() {
  precachemodel("generic_prop_x3");
  precachemodel("weapon_kb_m4_mag_zerog");
  precachemodel("vm_hero_protagonist_helmet_zerog");
  precachemodel("vm_hero_protagonist_helmet_zerog_empty");
  precachemodel("veh_mil_air_un_jackal_02_sa_moon");
  precachemodel("veh_mil_air_un_jackal_drone_atmos_periph");
  precachemodel("veh_mil_air_ca_jackal_drone_atmos_periph");
  precachemodel("weapon_handheld_hacking_device_vm");
  precachemodel("sdf_bridge_window_break_01_static");
  precachemodel("sdf_bridge_window_break_02_static");
  precachemodel("sdf_bridge_windows_rig");
  precachemodel("sdf_bridge_window_breach_01");
  precachemodel("sdf_bridge_window_breach_02");
  precachemodel("sdf_helmet_crew_01");
  precachemodel("oxygen_tank_gascanister_01");
  precachemodel("oxygen_tank_gascanister_01_zerog_to_gravity");
  precachemodel("un_dropship_first_aid_01");
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("p7_desk_metal_military_03_tablet_europa");
  precachemodel("fire_extinguisher_digital");
  precachemodel("weapon_ar57_wm");
  precachemodel("ammo_crate_01_sa_moon");
  precachemodel("coffee_cup");
  precachemodel("captains_quarters_cabinet_03_sa_moon");
  precachemodel("pallet_plastic_01_black");
  precachemodel("veh_mil_air_un_jackal_02_player_sa_moon");
  precachemodel("sdf_captain_keycard_01");
  precachemodel("sdf_maintenance_vent_cover");
  precachemodel("sdf_window_interior_broken_01_rig");
  precachemodel("veh_mil_air_un_retribution_rig");
  precachemodel("veh_mil_air_un_retribution_ftl_a");
  precachemodel("veh_mil_air_un_retribution_ftl_a_r");
  precachemodel("veh_mil_air_un_retribution_ftl_b");
  precachemodel("veh_mil_air_un_retribution_ftl_b_r");
  precacherumble("light_steady");
  precacherumble("tank_rumble");
  precacherumble("subtle_tank_rumble");
  precacherumble("damage_light");
  precacherumble("steady_rumble");
  precacheitem("iw7_m8");
  _id_0B53::_id_B908("veh_mil_air_ca_carrier", "sp/model_damage_tables/veh_mil_air_ca_carrier_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_carrier_fx.csv");
}

_id_FA53() {
  scripts\sp\utility::_id_F343("sa01_jackal");
  scripts\sp\utility::_id_1749("sa01_jackal", scripts\sp\maps\sa_moon\sa_moon_intro::_id_E951, "Jackal intro", scripts\sp\maps\sa_moon\sa_moon_intro::_id_E94C, ["sa_moon_exterior_tr", "sa_moon_exterior_ship_tr"], ::_id_E94D);
  scripts\sp\utility::_id_1749("sa01_hull", scripts\sp\maps\sa_moon\sa_moon_hull::_id_E93E, "Hull fight", scripts\sp\maps\sa_moon\sa_moon_hull::_id_E93A, ["sa_moon_prime_tr", "sa_moon_exterior_tr", "sa_moon_exterior_ship_tr", "sa_moon_hull_tr", "sa_moon_bridge_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_breach", scripts\sp\maps\sa_moon\sa_moon_breach::_id_E90A, "Breach into Bridge", scripts\sp\maps\sa_moon\sa_moon_breach::_id_E904, ["sa_moon_prime_tr", "sa_moon_exterior_tr", "sa_moon_exterior_ship_tr", "sa_moon_hull_tr", "sa_moon_bridge_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_interior_zg", scripts\sp\maps\sa_moon\sa_moon_interior_zg::_id_E948, "Bridge ZG", scripts\sp\maps\sa_moon\sa_moon_interior_zg::_id_E941, ["sa_moon_prime_tr", "sa_moon_exterior_tr", "sa_moon_exterior_ship_tr", "sa_moon_hull_tr", "sa_moon_bridge_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_maintenance", scripts\sp\maps\sa_moon\sa_moon_maintenance::_id_E95F, "Entering Maintenance", scripts\sp\maps\sa_moon\sa_moon_maintenance::_id_E956, ["sa_moon_prime_tr", "sa_moon_elevator_tr", "sa_moon_interior_tr"], scripts\sp\maps\sa_moon\sa_moon_maintenance::_id_E957);
  scripts\sp\utility::_id_1749("sa01_stealth_kill", scripts\sp\maps\sa_moon\sa_moon_stealth_kill::_id_E971, "Stealth Kill", scripts\sp\maps\sa_moon\sa_moon_stealth_kill::_id_E967, ["sa_moon_prime_tr", "sa_moon_elevator_tr", "sa_moon_interior_tr", "sa_moon_hallway_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_fleet_data", scripts\sp\maps\sa_moon\sa_moon_fleet_data::_id_E934, "Acquire Fleet Data", scripts\sp\maps\sa_moon\sa_moon_fleet_data::_id_E92A, ["sa_moon_prime_tr", "sa_moon_elevator_tr", "sa_moon_interior_tr", "sa_moon_hallway_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_hallway", scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_E938, "Fight through hallway", scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_E936, ["sa_moon_prime_tr", "sa_moon_hallway_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_cargobay_intro", scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_E913, "Fight through Cargo bay", scripts\sp\maps\sa_moon\sa_moon_cargobay::_id_E90F, ["sa_moon_prime_tr", "sa_moon_hallway_tr", "sa_moon_cargobay_tr", "sa_moon_exfil_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_exfil", scripts\sp\maps\sa_moon\sa_moon_exfil::_id_E924, "Exfil Destroyer", scripts\sp\maps\sa_moon\sa_moon_exfil::_id_E91D, ["sa_moon_prime_tr", "sa_moon_cargobay_tr", "sa_moon_exfil_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_exfil_flyout", scripts\sp\maps\sa_moon\sa_moon_exfil::_id_E921, "Exfil Flyout", scripts\sp\maps\sa_moon\sa_moon_exfil::_id_E91F, ["sa_moon_prime_tr", "sa_moon_cargobay_tr", "sa_moon_exfil_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_loot_room", ::_id_E955, "Loot Room", ::_id_E954, ["sa_moon_prime_tr", "sa_moon_hallway_tr", "sa_moon_cargobay_tr", "sa_moon_exfil_tr"], undefined);
  scripts\sp\utility::_id_1749("sa01_bink_intro", scripts\sp\maps\sa_moon\sa_moon_intro::_id_E951, "Long intro for bink video", scripts\sp\maps\sa_moon\sa_moon_intro::_id_E94A, ["sa_moon_prime_tr", "sa_moon_exterior_tr", "sa_moon_exterior_ship_tr"], undefined);
}

_id_FA6B() {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  var_0 = getEnt("mg_cannon_clip", "targetname");
  var_1 = getEnt("flak_cannon_clip", "targetname");
  var_2 = undefined;

  foreach(var_4 in level._id_3965.turrets) {
    foreach(var_6 in var_4) {
      if(var_6.type == "cap_turret_small_constant") {
        var_7 = spawn("script_model", var_6.origin);
        var_7.angles = var_6.angles;
        var_7 linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
        var_7 clonebrushmodeltoscriptmodel(var_0);
        thread _id_40D5(var_7);
        continue;
      }

      var_7 = spawn("script_model", var_6.origin);
      var_7.angles = var_6.angles;
      var_7 linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_7 clonebrushmodeltoscriptmodel(var_1);
      thread _id_40D5(var_7);
    }
  }
}

_id_40D5(var_0) {
  scripts\engine\utility::flag_wait("captain_key_card_pickup_started");
  var_0 delete();
}

_id_88CB() {
  var_0 = scripts\engine\utility::getStruct("zerog_start", "targetname");
  var_1 = _id_0BDC::_id_1079F("player_jackal", "jackal_start_point");
  level._id_D127 = var_1;
  var_1._id_1FBB = "player_jackal";
  var_1.ignoreall = 1;
  var_1 notsolid();
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  var_2 notsolid();
  var_3 = scripts\sp\utility::_id_10639("intro_debris", var_0.origin, var_0.angles);
  var_4 = scripts\sp\utility::_id_10639("intro_debris_fx", var_0.origin, var_0.angles);
  thread scripts\sp\maps\sa_moon\sa_moon_intro::_id_88A9(var_3);
  thread scripts\sp\maps\sa_moon\sa_moon_intro::_id_FA60(var_0);
  level._id_118A8 = scripts\sp\vehicle::_id_1080C("tigris");
  var_5 = scripts\sp\utility::_id_10639("tigris", var_0.origin, var_0.angles);
  var_6 = [];
  var_6[0] = var_1;
  var_6[1] = var_3;
  var_6[2] = var_5;
  var_0 thread scripts\sp\anim::_id_1EC1(var_6, "intro");
}

_id_E955() {
  thread _id_0F16::_id_3E3E("loot_room_start");
  thread _id_0F16::_id_8EA3();
}

_id_E954() {
  scripts\engine\utility::flag_wait("forever");
}

_id_E94D() {
  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F53C(0);
}