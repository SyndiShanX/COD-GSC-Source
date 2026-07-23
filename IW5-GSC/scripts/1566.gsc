/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1566.gsc
**************************************/

_id_3E56(var_0) {
  return var_0 == "vehicle_little_bird_armed";
}

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  if(_id_3E56(var_0)) {
    vehicle_scripts\_attack_heli::preload();
  }
  maps\_vehicle::build_template("littlebird", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_little_bird_armed");
  maps\_vehicle::build_deathmodel("vehicle_little_bird_bench");
  maps\_vehicle::build_drive(%mi28_rotors, undefined, 0, 3.0);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine", "littlebird_helicopter_secondary_exp", undefined, undefined, undefined, 0.0, 1);
  maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L", "tag_engine", "littlebird_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine", undefined, undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_little_bird", undefined, "littlebird_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_rocket_deathfx("explosions/helicopter_explosion_little_bird_dcburn", "tag_deathfx", "littlebird_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::build_deathquake(0.8, 1.6, 2048);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(799);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  var_3 = randomfloatrange(0, 1);
  var_4 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_4, "white_blink", "TAG_LIGHT_BELLY", "misc/aircraft_light_white_blink", "running", var_3);
  maps\_vehicle::build_light(var_4, "red_blink1", "TAG_LIGHT_TAIL1", "misc/aircraft_light_red_blink_occ", "running", var_3);
  maps\_vehicle::build_light(var_4, "red_blink2", "TAG_LIGHT_TAIL2", "misc/aircraft_light_red_blink_occ", "running", var_3);
  var_5 = getDvar("mapname");

  if(!isDefined(level.script)) {
    level.script = tolower(var_5);
  }
  var_6 = "minigun_littlebird_spinnup";

  if(_id_3E57()) {
    var_6 = "minigun_littlebird";
  }
  maps\_vehicle::build_turret(var_6, "TAG_MINIGUN_ATTACH_LEFT", "vehicle_little_bird_minigun_left");
  maps\_vehicle::build_turret(var_6, "TAG_MINIGUN_ATTACH_RIGHT", "vehicle_little_bird_minigun_right");
}

_id_3E57() {
  return issubstr(level.script, "oilrig");
}

init_local() {
  self endon("death");
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.script_badplace = 0;
  self.dontdisconnectpaths = 1;
  thread maps\_vehicle::littlebird_landing();
  thread maps\_vehicle::lights_on("running");
  waittillframeend;

  if(!_id_3E57()) {
    foreach(var_1 in self.mgturret) {}
    var_1 setautorotationdelay(4);
  }

  if(_id_3E56(self.model)) {
    return;
  }
  maps\_vehicle::mgoff();

  foreach(var_1 in self.mgturret) {}
  var_1 hide();
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  level.scr_anim["generic"]["stage_littlebird_right"] = % little_bird_premount_guy3;
  level.scr_anim["generic"]["stage_littlebird_left"] = % little_bird_premount_guy3;
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0[var_1] = spawnStruct();
  }
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