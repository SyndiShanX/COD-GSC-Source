/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\silenthawk.gsc
******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("silenthawk", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_silenthawk");
  var_3 = var_2 == "script_vehicle_silenthawk_flood_player" || var_2 == "script_vehicle_silenthawk_player_turret_left" || var_2 == "script_vehicle_silenthawk_open" || var_2 == "script_vehicle_silenthawk_oilrocks" || var_2 == "script_vehicle_silenthawk_open_lite";
  var_4 = var_2 == "script_vehicle_silenthawk_open_lite";

  if(var_3)
    maps\_vehicle::build_drive(%silenthawk_doors_open, undefined, 0);
  else
    maps\_vehicle::build_drive(%bh_rotors, undefined, 0);

  if(!var_4) {
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_end", undefined, "blackhawk_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_init", "tag_body", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.1, 1, undefined);
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_deathspin", "tag_body", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.1, 1, undefined);
    maps\_vehicle::build_rocket_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_init", "tag_body", "blackhawk_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
    maps\_vehicle::build_rocket_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_deathspin", "tag_body", "blackhawk_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
    maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
    maps\_vehicle::build_unload_groups(::unload_groups);
  }

  maps\_vehicle::build_treadfx(var_2, "default", "vfx/gameplay/tread_fx/vfx_heli_dust_sand", 1);
  maps\_vehicle::build_treadfx(var_2, "sand", "vfx/gameplay/tread_fx/vfx_heli_dust_sand", 1);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_white_blink", "running", 0.1);

  if(issubstr(var_2, "turret_left"))
    maps\_vehicle::build_turret("nym_blackhawk_minigun_close_stand", "tag_player1", "weapon_blackhawk_minigun", undefined, undefined, 0.2, 20, -14, (25, 0, 6));

  if(var_2 == "script_vehicle_silenthawk_oilrocks") {
    maps\_vehicle::build_turret("nym_blackhawk_minigun_close", "tag_turret_npc", "weapon_blackhawk_minigun", undefined, "auto_nonai", 0.2, 20, -14, (0, 12, -4));
    maps\_vehicle::build_turret("nym_blackhawk_minigun_close", "tag_gun_l", "weapon_blackhawk_minigun", undefined, "auto_nonai", 0.2, 20, -14, (0, 0, -4));
  }

  maps\_vehicle::build_is_helicopter();
}

init_local() {
  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");
  maps\_vehicle::vehicle_lights_on("interior");
  maps\_vehicle::vehicle_lights_on("exhaust");
  thread vehicle_scripts\silenthawk_landing::silenthawk_landing();

  if(self.classname != "script_vehicle_silenthawk_open_lite")
    thread vehicle_scripts\silenthawk_landing::listen_for_landing_gear_messages();
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  level.scr_anim["generic"]["stage_littlebird_right"] = % little_bird_premount_guy3;
  level.scr_anim["generic"]["stage_littlebird_left"] = % little_bird_premount_guy3;
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_pilot1";
  var_0[1].sittag = "tag_pilot2";
  var_0[2].sittag = "tag_detach_right";
  var_0[3].sittag = "tag_detach_right";
  var_0[4].sittag = "tag_detach_right";
  var_0[5].sittag = "tag_detach_left";
  var_0[6].sittag = "tag_detach_left";
  var_0[7].sittag = "tag_detach_left";
  var_0[0].idle[0] = % helicopter_pilot1_idle;
  var_0[0].idle[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0].idle[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0].idle[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0].idleoccurrence[0] = 500;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].idleoccurrence[2] = 100;
  var_0[0].idleoccurrence[3] = 100;
  var_0[1].idle[0] = % helicopter_pilot2_idle;
  var_0[1].idle[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1].idle[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1].idle[3] = % helicopter_pilot2_twitch_radio;
  var_0[1].idleoccurrence[0] = 450;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].idleoccurrence[2] = 100;
  var_0[1].idleoccurrence[3] = 100;
  var_0[2].idle[0] = % little_bird_casual_idle_guy1;
  var_0[3].idle[0] = % little_bird_casual_idle_guy3;
  var_0[4].idle[0] = % little_bird_casual_idle_guy2;
  var_0[5].idle[0] = % little_bird_casual_idle_guy1;
  var_0[6].idle[0] = % little_bird_casual_idle_guy3;
  var_0[7].idle[0] = % little_bird_casual_idle_guy2;
  var_0[2].idleoccurrence[0] = 100;
  var_0[3].idleoccurrence[0] = 166;
  var_0[4].idleoccurrence[0] = 122;
  var_0[5].idleoccurrence[0] = 177;
  var_0[6].idleoccurrence[0] = 136;
  var_0[7].idleoccurrence[0] = 188;
  var_0[2].idle[1] = % little_bird_aim_idle_guy1;
  var_0[3].idle[1] = % little_bird_aim_idle_guy3;
  var_0[4].idle[1] = % little_bird_aim_idle_guy2;
  var_0[5].idle[1] = % little_bird_aim_idle_guy1;
  var_0[7].idle[1] = % little_bird_aim_idle_guy2;
  var_0[2].idleoccurrence[1] = 200;
  var_0[3].idleoccurrence[1] = 266;
  var_0[4].idleoccurrence[1] = 156;
  var_0[5].idleoccurrence[1] = 277;
  var_0[7].idleoccurrence[1] = 288;
  var_0[2].idle_alert = % little_bird_alert_idle_guy1;
  var_0[3].idle_alert = % little_bird_alert_idle_guy3;
  var_0[4].idle_alert = % little_bird_alert_idle_guy2;
  var_0[5].idle_alert = % little_bird_alert_idle_guy1;
  var_0[6].idle_alert = % little_bird_alert_idle_guy3;
  var_0[7].idle_alert = % little_bird_alert_idle_guy2;
  var_0[2].idle_alert_to_casual = % little_bird_alert_2_aim_guy1;
  var_0[3].idle_alert_to_casual = % little_bird_alert_2_aim_guy3;
  var_0[4].idle_alert_to_casual = % little_bird_alert_2_aim_guy2;
  var_0[5].idle_alert_to_casual = % little_bird_alert_2_aim_guy1;
  var_0[6].idle_alert_to_casual = % little_bird_alert_2_aim_guy3;
  var_0[7].idle_alert_to_casual = % little_bird_alert_2_aim_guy2;
  var_0[2].getout = % little_bird_dismount_guy1;
  var_0[3].getout = % little_bird_dismount_guy3;
  var_0[4].getout = % little_bird_dismount_guy2;
  var_0[5].getout = % little_bird_dismount_guy1;
  var_0[6].getout = % little_bird_dismount_guy3;
  var_0[7].getout = % little_bird_dismount_guy2;
  var_0[2].littlebirde_getout_unlinks = 1;
  var_0[3].littlebirde_getout_unlinks = 1;
  var_0[4].littlebirde_getout_unlinks = 1;
  var_0[5].littlebirde_getout_unlinks = 1;
  var_0[6].littlebirde_getout_unlinks = 1;
  var_0[7].littlebirde_getout_unlinks = 1;
  var_0[2].getin = % little_bird_mount_guy1;
  var_0[2].getin_enteredvehicletrack = "mount_finish";
  var_0[3].getin = % little_bird_mount_guy3;
  var_0[3].getin_enteredvehicletrack = "mount_finish";
  var_0[4].getin = % little_bird_mount_guy2;
  var_0[4].getin_enteredvehicletrack = "mount_finish";
  var_0[5].getin = % little_bird_mount_guy1;
  var_0[5].getin_enteredvehicletrack = "mount_finish";
  var_0[6].getin = % little_bird_mount_guy3;
  var_0[6].getin_enteredvehicletrack = "mount_finish";
  var_0[7].getin = % little_bird_mount_guy2;
  var_0[7].getin_enteredvehicletrack = "mount_finish";
  var_0[2].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[3].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[4].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[5].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[6].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[7].getin_idle_func = maps\_vehicle_aianim::guy_idle_alert;
  var_0[2].pre_unload = % little_bird_aim_2_prelanding_guy1;
  var_0[3].pre_unload = % little_bird_aim_2_prelanding_guy3;
  var_0[4].pre_unload = % little_bird_aim_2_prelanding_guy2;
  var_0[5].pre_unload = % little_bird_aim_2_prelanding_guy1;
  var_0[6].pre_unload = % little_bird_aim_2_prelanding_guy3;
  var_0[7].pre_unload = % little_bird_aim_2_prelanding_guy2;
  var_0[2].pre_unload_idle = % little_bird_prelanding_idle_guy1;
  var_0[3].pre_unload_idle = % little_bird_prelanding_idle_guy3;
  var_0[4].pre_unload_idle = % little_bird_prelanding_idle_guy2;
  var_0[5].pre_unload_idle = % little_bird_prelanding_idle_guy1;
  var_0[6].pre_unload_idle = % little_bird_prelanding_idle_guy3;
  var_0[7].pre_unload_idle = % little_bird_prelanding_idle_guy2;
  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["first_guy_left"] = [];
  var_0["first_guy_right"] = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["passengers"] = [];
  var_0["default"] = [];
  var_0["first_guy_left"][0] = 5;
  var_0["first_guy_right"][0] = 2;
  var_0["stage_guy_left"][0] = 7;
  var_0["stage_guy_right"][0] = 4;
  var_0["left"][var_0["left"].size] = 5;
  var_0["left"][var_0["left"].size] = 6;
  var_0["left"][var_0["left"].size] = 7;
  var_0["right"][var_0["right"].size] = 2;
  var_0["right"][var_0["right"].size] = 3;
  var_0["right"][var_0["right"].size] = 4;
  var_0["passengers"][var_0["passengers"].size] = 2;
  var_0["passengers"][var_0["passengers"].size] = 3;
  var_0["passengers"][var_0["passengers"].size] = 4;
  var_0["passengers"][var_0["passengers"].size] = 5;
  var_0["passengers"][var_0["passengers"].size] = 6;
  var_0["passengers"][var_0["passengers"].size] = 7;
  var_0["default"] = var_0["passengers"];
  return var_0;
}