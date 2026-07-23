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
    vehicle_scripts\_attack_heli::_id_2874();
  }
  maps\_vehicle::_id_2AC2("littlebird", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_little_bird_armed");
  maps\_vehicle::_id_2ABE("vehicle_little_bird_bench");
  maps\_vehicle::_id_2AC1(%mi28_rotors, undefined, 0, 3.0);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "tag_engine", "littlebird_helicopter_secondary_exp", undefined, undefined, undefined, 0.0, 1);
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "tag_engine", "littlebird_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "tag_engine", undefined, undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_little_bird", undefined, "littlebird_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2A04("explosions/helicopter_explosion_little_bird_dcburn", "tag_deathfx", "littlebird_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::_id_29F8(0.8, 1.6, 2048);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(799);
  maps\_vehicle::_id_2AC6("axis");
  maps\_vehicle::_id_2AC7();
  maps\_vehicle::_id_2ACD(::_id_3E58);
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  var_3 = randomfloatrange(0, 1);
  var_4 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_4, "white_blink", "TAG_LIGHT_BELLY", "misc/aircraft_light_white_blink", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "red_blink1", "TAG_LIGHT_TAIL1", "misc/aircraft_light_red_blink_occ", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "red_blink2", "TAG_LIGHT_TAIL2", "misc/aircraft_light_red_blink_occ", "running", var_3);
  var_5 = getDvar("mapname");

  if(!isDefined(level.script)) {
    level.script = tolower(var_5);
  }
  var_6 = "minigun_littlebird_spinnup";

  if(_id_3E57()) {
    var_6 = "minigun_littlebird";
  }
  maps\_vehicle::_id_2A4A(var_6, "TAG_MINIGUN_ATTACH_LEFT", "vehicle_little_bird_minigun_left");
  maps\_vehicle::_id_2A4A(var_6, "TAG_MINIGUN_ATTACH_RIGHT", "vehicle_little_bird_minigun_right");
}

_id_3E57() {
  return issubstr(level.script, "oilrig");
}

_id_2B1D() {
  self endon("death");
  self._id_295E = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self._id_2941 = 0;
  self._id_2998 = 1;
  thread maps\_vehicle::_id_2A89();
  thread maps\_vehicle::_id_2AB3("running");
  waittillframeend;

  if(!_id_3E57()) {
    foreach(var_1 in self.mgturret) {}
    var_1 setautorotationdelay(4);
  }

  if(_id_3E56(self.model)) {
    return;
  }
  maps\_vehicle::_id_2A3D();

  foreach(var_1 in self.mgturret) {}
  var_1 hide();
}

_id_3A9C(var_0) {
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  level._id_0C59["generic"]["stage_littlebird_right"] = % little_bird_premount_guy3;
  level._id_0C59["generic"]["stage_littlebird_left"] = % little_bird_premount_guy3;
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_24F2 = "tag_pilot1";
  var_0[1]._id_24F2 = "tag_pilot2";
  var_0[2]._id_24F2 = "tag_detach_right";
  var_0[3]._id_24F2 = "tag_detach_right";
  var_0[4]._id_24F2 = "tag_detach_right";
  var_0[5]._id_24F2 = "tag_detach_left";
  var_0[6]._id_24F2 = "tag_detach_left";
  var_0[7]._id_24F2 = "tag_detach_left";
  var_0[0]._id_0F59[0] = % helicopter_pilot1_idle;
  var_0[0]._id_0F59[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0]._id_0F59[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0]._id_0F59[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0]._id_254D[0] = 500;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_254D[2] = 100;
  var_0[0]._id_254D[3] = 100;
  var_0[1]._id_0F59[0] = % helicopter_pilot2_idle;
  var_0[1]._id_0F59[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1]._id_0F59[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1]._id_0F59[3] = % helicopter_pilot2_twitch_radio;
  var_0[1]._id_254D[0] = 450;
  var_0[1]._id_254D[1] = 100;
  var_0[1]._id_254D[2] = 100;
  var_0[1]._id_254D[3] = 100;
  var_0[2]._id_0F59[0] = % little_bird_casual_idle_guy1;
  var_0[3]._id_0F59[0] = % little_bird_casual_idle_guy3;
  var_0[4]._id_0F59[0] = % little_bird_casual_idle_guy2;
  var_0[5]._id_0F59[0] = % little_bird_casual_idle_guy1;
  var_0[6]._id_0F59[0] = % little_bird_casual_idle_guy3;
  var_0[7]._id_0F59[0] = % little_bird_casual_idle_guy2;
  var_0[2]._id_254D[0] = 100;
  var_0[3]._id_254D[0] = 166;
  var_0[4]._id_254D[0] = 122;
  var_0[5]._id_254D[0] = 177;
  var_0[6]._id_254D[0] = 136;
  var_0[7]._id_254D[0] = 188;
  var_0[2]._id_0F59[1] = % little_bird_aim_idle_guy1;
  var_0[3]._id_0F59[1] = % little_bird_aim_idle_guy3;
  var_0[4]._id_0F59[1] = % little_bird_aim_idle_guy2;
  var_0[5]._id_0F59[1] = % little_bird_aim_idle_guy1;
  var_0[7]._id_0F59[1] = % little_bird_aim_idle_guy2;
  var_0[2]._id_254D[1] = 200;
  var_0[3]._id_254D[1] = 266;
  var_0[4]._id_254D[1] = 156;
  var_0[5]._id_254D[1] = 277;
  var_0[7]._id_254D[1] = 288;
  var_0[2]._id_25CF = % little_bird_alert_idle_guy1;
  var_0[3]._id_25CF = % little_bird_alert_idle_guy3;
  var_0[4]._id_25CF = % little_bird_alert_idle_guy2;
  var_0[5]._id_25CF = % little_bird_alert_idle_guy1;
  var_0[6]._id_25CF = % little_bird_alert_idle_guy3;
  var_0[7]._id_25CF = % little_bird_alert_idle_guy2;
  var_0[2]._id_25D2 = % little_bird_alert_2_aim_guy1;
  var_0[3]._id_25D2 = % little_bird_alert_2_aim_guy3;
  var_0[4]._id_25D2 = % little_bird_alert_2_aim_guy2;
  var_0[5]._id_25D2 = % little_bird_alert_2_aim_guy1;
  var_0[6]._id_25D2 = % little_bird_alert_2_aim_guy3;
  var_0[7]._id_25D2 = % little_bird_alert_2_aim_guy2;
  var_0[2]._id_257C = % little_bird_dismount_guy1;
  var_0[3]._id_257C = % little_bird_dismount_guy3;
  var_0[4]._id_257C = % little_bird_dismount_guy2;
  var_0[5]._id_257C = % little_bird_dismount_guy1;
  var_0[6]._id_257C = % little_bird_dismount_guy3;
  var_0[7]._id_257C = % little_bird_dismount_guy2;
  var_0[2]._id_2593 = 1;
  var_0[3]._id_2593 = 1;
  var_0[4]._id_2593 = 1;
  var_0[5]._id_2593 = 1;
  var_0[6]._id_2593 = 1;
  var_0[7]._id_2593 = 1;
  var_0[2]._id_2519 = % little_bird_mount_guy1;
  var_0[2]._id_2528 = "mount_finish";
  var_0[3]._id_2519 = % little_bird_mount_guy3;
  var_0[3]._id_2528 = "mount_finish";
  var_0[4]._id_2519 = % little_bird_mount_guy2;
  var_0[4]._id_2528 = "mount_finish";
  var_0[5]._id_2519 = % little_bird_mount_guy1;
  var_0[5]._id_2528 = "mount_finish";
  var_0[6]._id_2519 = % little_bird_mount_guy3;
  var_0[6]._id_2528 = "mount_finish";
  var_0[7]._id_2519 = % little_bird_mount_guy2;
  var_0[7]._id_2528 = "mount_finish";
  var_0[2]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[3]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[4]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[5]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[6]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[7]._id_24F7 = maps\_vehicle_aianim::_id_25CE;
  var_0[2]._id_25CB = % little_bird_aim_2_prelanding_guy1;
  var_0[3]._id_25CB = % little_bird_aim_2_prelanding_guy3;
  var_0[4]._id_25CB = % little_bird_aim_2_prelanding_guy2;
  var_0[5]._id_25CB = % little_bird_aim_2_prelanding_guy1;
  var_0[6]._id_25CB = % little_bird_aim_2_prelanding_guy3;
  var_0[7]._id_25CB = % little_bird_aim_2_prelanding_guy2;
  var_0[2]._id_25CD = % little_bird_prelanding_idle_guy1;
  var_0[3]._id_25CD = % little_bird_prelanding_idle_guy3;
  var_0[4]._id_25CD = % little_bird_prelanding_idle_guy2;
  var_0[5]._id_25CD = % little_bird_prelanding_idle_guy1;
  var_0[6]._id_25CD = % little_bird_prelanding_idle_guy3;
  var_0[7]._id_25CD = % little_bird_prelanding_idle_guy2;
  var_0[0]._id_24F4 = 0;
  var_0[1]._id_24F4 = 0;
  return var_0;
}

_id_3E58() {
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