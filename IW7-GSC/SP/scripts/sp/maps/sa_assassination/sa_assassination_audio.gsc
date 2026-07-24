/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_audio.gsc
***********************************************************************/

main() {
  _id_953A();
  _id_969E();
  level.player._id_13543 = 0.501187;
  level._id_2571._id_769A = ["asn_sdf1_copywereinthe", "asn_sdf1_statusreportsareon", "asn_sdf1_switchingoutnowteam", "asn_sdf1_thecaptainsbeenescorted", "asn_sdf1_ineedasituation", "asn_sdf2_maintenanceneedsanotherdc", "asn_sdf2_weneedanotherteam", "asn_sdf2_confirm09poweron", "asn_sdf2_ihaventheardanything", "asn_sdf2_givemeastatus", "asn_sdf3_hesheadingtherenow", "asn_sdf3_sendanotherteamto", "asn_sdf3_rerouteittothe", "asn_sdf3_wereworkingonit", "asn_sdf3_maintenancecrewrequiredon", "asn_sdf4_nosirtheteam", "asn_sdf4_alexiisonhis", "asn_sdf4_allstationsareaccounted", "asn_sdf4_wevegotanairlock"];
  level._id_2571._id_7699 = ["asn_sdf1_wefoundtheiraccess", "asn_sdf2_complysir", "asn_sdf1_primumteamwilltake", "asn_sdf1_lockthemalldown", "asn_sdf2_twomoredeadin", "asn_sdf3_reportsconflicttheremay", "asn_sdf1_perimeterestablishedoutsidethe", "asn_sdf1_wevegotonenear", "asn_sdf2_directalldcteams", "asn_sdf3_multiplecontainmentunitsneeded", "asn_sdf1_takeyourmenand", "asn_sdf2_aftfirecontrolis"];
}

_id_969E() {
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_8727, "guy1_barracks_kill");
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_A568, "keel_repair_guy_melee");
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_B5A3, "melee_neck_snap");
}

_id_953A() {
  level._id_2571._id_1D66 = ["breach_to_hallway", "breach_to_hallway_secondary", "barracks_to_hubstern", "barracks_to_hubstern_secondary", "barracks_to_bowupper", "barracks_to_bowupper_secondary"];

  foreach(var_1 in level._id_2571._id_1D66) {
    scripts\engine\utility::flag_init(var_1);
  }

  scripts\engine\utility::flag_init("random_ambience_started");
}

_id_104E1() {}

_id_2390() {
  level._id_C851[""] = spawnStruct();
  _id_0F00::_id_4931("war", "asn_paa_actionstationsactionstations");
  _id_0F00::_id_4931("war", "asn_paa_containmentteamsreportto");
  _id_0F00::_id_4931("war", "asn_vrc_combatpersonnelareordered");
  _id_0F00::_id_4931("war", "asn_paa_medicalteamsareneeded");
  _id_0F00::_id_4931("war", "asn_paa_attentionidentificationmustbe");
  _id_0F00::_id_4931("war", "asn_paa_securitybreachondeck");
  _id_0F00::_id_4931("war", "asn_paa_medicalteam4report");
  _id_0F00::_id_4931("war", "asn_paa_guardofficernegretereport");
  _id_0F00::_id_4931("war", "asn_paa_responseforceprotocolis");
  _id_0F00::_id_4931("war", "asn_paa_allpersonnelswitchinternal");
  _id_0F00::_id_4931("war", "asn_paa_medicalteamsreportto");
  _id_0F00::_id_4931("normal_operations", "sa_paa_thrust_correction");
  _id_0F00::_id_4931("normal_operations", "sa_paa_port_hangar_bay");
  _id_0F00::_id_4931("normal_operations", "sa_paa_starboard_control");
  _id_0F00::_id_4931("normal_operations", "sa_paa_engineering_cancel");
  _id_0F00::_id_4931("normal_operations", "sa_paa_bay_3_asap");
  _id_0F00::_id_4931("normal_operations", "sa_paa_airlock_6c");
  _id_0F00::_id_4931("normal_operations", "sa_paa_atmo_controls");
  _id_0F00::_id_4931("normal_operations", "sa_paa_inoperative");
  _id_0F00::_id_4931("normal_operations", "asn_paa_dct14reportto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_dct9reportto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_ordnanceteam3report");
  _id_0F00::_id_4931("normal_operations", "asn_paa_engineeringcancelprepfor");
  _id_0F00::_id_4931("normal_operations", "asn_paa_maintenancecrewneededin");
  _id_0F00::_id_4931("normal_operations", "asn_paa_airlock6cisdown");
  _id_0F00::_id_4931("normal_operations", "asn_paa_maintenanceteamreportto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_dct6reportto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_bay7prepareto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_attentionalldecksfacility");
  _id_0F00::_id_4931("normal_operations", "asn_paa_lieutenantmaksimreportto");
  _id_0F00::_id_4931("normal_operations", "asn_paa_starboardftteamscheck");
  _id_0F00::_id_4931("normal_operations", "asn_paa_attentiondeck2sealing");
}

_id_9433() {
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_airlock");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "entering_airlock");
}

_id_991A() {
  thread _id_DC6D();
  _id_9A63();
  wait 2;
}

_id_793E() {
  thread _id_DC6D();
  _id_4FC5();
}

_id_845C() {
  thread _id_769B("normal");
  thread _id_DC6D();
  _id_4FC5();
}

_id_4519() {
  thread _id_769B("normal");
  thread _id_DC6D();
  _id_4FC5();
}

_id_D7BE() {
  thread _id_769B("normal");
  thread _id_DC6D();
  _id_4FC5();
}

assist_onbeginuse() {
  thread _id_769B("chaos");
  thread _id_0F00::_id_CDD7("war", 10, 20);
  thread _id_DC6D();
  _id_4FC5();
}

_id_E886() {
  thread _id_769B("chaos");
  thread _id_0F00::_id_CDD7("war", 10, 20);
  thread _id_DC6D();
  _id_4FC5();
}

_id_68FD() {
  thread _id_DC6D();
  thread _id_DE0B();
  _id_4FC5();
}

_id_104E0() {
  setglobalsoundcontext("atmosphere", "space");
}

_id_395B() {}

_id_9431() {
  _id_9A63();
  thread _id_DC6D();
}

_id_9919() {
  wait 10;
  thread _id_0F00::_id_CDD7("normal_operations", 25, 35);
}

_id_68FB() {
  scripts\engine\utility::flag_wait("flag_at_salter");
}

_id_DC6D() {
  if(scripts\engine\utility::flag("random_ambience_started")) {
    return;
  }
  scripts\engine\utility::flag_set("random_ambience_started");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_in_array_return(level._id_2571._id_1D66);

    switch (var_0) {
      case "breach_to_hallway":
        scripts\engine\utility::flag_waitopen("breach_to_hallway");

        if(scripts\engine\utility::flag("breach_to_hallway_secondary")) {
          _id_4FC5();
        } else {
          _id_990F();
        }

        break;
      case "barracks_to_hubstern":
        scripts\engine\utility::flag_waitopen("barracks_to_hubstern");

        if(scripts\engine\utility::flag("barracks_to_hubstern_secondary")) {
          _id_9A63();
        } else {
          _id_4FC5();
        }

        break;
      case "barracks_to_bowupper":
        scripts\engine\utility::flag_waitopen("barracks_to_bowupper");

        if(scripts\engine\utility::flag("barracks_to_bowupper_secondary")) {
          _id_4FC5();
        } else {
          _id_9A63();
        }

        break;
      default:
        break;
    }
  }
}

_id_990F() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
}

_id_9A63() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 11, 16, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small", 12, 19, 8, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_close", 16, 29, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 14, 28, 15, 26, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium", 12, 20, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_close", 16, 26, 21, 23, 3000, 3001, 300, 180, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
}

_id_4FC5() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large_deep", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant_deep", 10, 20, 11, 16, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 16, 30, 15, 20, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small_deep", 12, 19, 8, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_close_deep", 16, 29, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist_deep", 14, 28, 15, 26, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant_deep", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant_deep", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long_deep", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short_deep", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant_deep", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist_deep", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant_deep", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium_deep", 12, 20, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_close_deep", 16, 26, 21, 23, 3000, 3001, 300, 180, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant_deep", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer_deep", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
}

_id_949E() {
  level.player playSound("infiltrate_hack");
}

_id_6624() {
  level.player _id_0F00::_id_CE24("ship_infil_open", 7.5);
  level.player _id_0F00::_id_CE24("ship_infil_boost", 11.1);
  level.player _id_0F00::_id_CE24("ship_infil_open_rumble", 15);
  level.player _id_0F00::_id_CE24("ship_infil_steam", 13.4);
  level.player _id_0F00::_id_CE24("ship_infil_close", 13.15);
  level.player _id_0F00::_id_CE24("ship_infil_shake_lr", 15.4);
  level.player _id_0F00::_id_CE24("ship_infil_land", 17.5);
  _id_0F33::_id_D048();
}

_id_D871() {
  _id_0F00::_id_CD7B("amb_ship_steam_wide_01", (-38, 131, -513), 0, "audio_keep_pressurized", 1.3);
  _id_0F00::_id_CD7B("amb_ship_steam_wide_02", (-38, -131, -513), 0, "audio_keep_pressurized", 1.3);
  setglobalsoundcontext("atmosphere", "helmet", 2);
  wait 2;
  level notify("audio_keep_pressurized");
}

_id_8479() {
  level.player playSound("grab_grenade");
  wait 4.2;
  level.player playSound("weap_raise_plr");
}

_id_6607() {
  level.player playSound("barracks_open_grate_1");
  level.player _id_0F00::_id_CE24("barracks_open_grate_2", 7.5);
}

_id_EA4C() {
  wait 3;
  scripts\sp\utility::_id_1034D("asn_slt_copy");
  wait 1;
  scripts\sp\utility::_id_10350("asn_slt_alertlevelisnormal");
}

_id_8727(var_0) {
  level.player playSound("guy1_barracks_kill");
}

_id_A568(var_0) {
  level.player playSound("context_melee_kill_02_back");
}

_id_B5A3(var_0) {
  level.player playSound("context_melee_kill_01_back");
}

_id_DB2A() {
  level.player playSound("put_on_disguise");
  wait 3;
  thread _id_769B("normal");
  setglobalsoundcontext("atmosphere", "", 1);
  wait 2.6;
  setglobalsoundcontext("atmosphere", "helmet", 1.5);
}

_id_769B(var_0) {
  level notify("garbled_vo_thread");
  level endon("garbled_vo_thread");
  var_1 = [];

  if(var_0 == "normal") {
    var_1 = level._id_2571._id_769A;
  } else if(var_0 == "chaos") {
    var_1 = level._id_2571._id_7699;
  }

  wait 5;
  var_2 = scripts\engine\utility::spawn_tag_origin(level.player.origin);

  while(!scripts\engine\utility::flag("flag_at_salter")) {
    var_2 playSound(scripts\engine\utility::random(var_1), "sounddone");
    var_2 waittill("sounddone");
    wait(randomfloatrange(2.0, 4.0));
  }

  var_2 delete();
}

_id_F0E4() {
  level.player playSound("security_door_open");
}

_id_CC4F() {
  level.player playSound("conference_room_grenade_plant");
}

_id_76C4() {
  thread scripts\engine\utility::play_sound_in_space("gas_lifesupport_off", (3020, -946, 278));
  _id_0F00::_id_CE21("gas_scene_ignite", (3020, -946, 278));
  wait 0.1;
  _id_0F00::_id_CD7B("gas_scene_gas", (3020, -946, 278));
}

_id_DE0B() {
  thread _id_DE0A();
  thread _id_769B("chaos");
  wait 6;
  thread _id_0F00::_id_CDD7("war", 10, 20);
}

_id_DE0A() {
  var_0 = getEntArray("alarm_sound_org", "targetname");

  foreach(var_2 in var_0) {
    var_2 playLoopSound("sa_hack_alarm_01");
  }

  level._id_E99E["exfil_door"] waittill("trigger");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_10460(1, 1);
  }
}

_id_6914() {
  scripts\engine\utility::delaythread(0.7, scripts\sp\utility::play_sound_on_entity, "sa_vip_hatch_open");
  wait 4;
  setglobalsoundcontext("atmosphere", "helmet", 2);
}

_id_6926() {
  scripts\engine\utility::delaythread(6, scripts\sp\utility::play_sound_on_entity, "exfil_footsteps");
  scripts\engine\utility::delaythread(0.35, scripts\sp\utility::play_sound_on_entity, "sa_vip_hatch_open");
}

_id_6911() {
  level.player notify("started_dynamic_ambience");
  level notify("end_pa_group");
}

_id_6904() {
  wait 2;
  level.player playSound("exfil_depressurize_airlock");
  setglobalsoundcontext("atmosphere", "space", 1.5);
}