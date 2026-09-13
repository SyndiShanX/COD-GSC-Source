/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3f67385f8f80eb4c.gsc
***********************************************/

_id_609C4A9EDF17904E() {
  if(isDefined(level._id_422E732809F58989)) {
    level[[level._id_422E732809F58989]]();
    return;
  }

  canceljoins();
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level thread scripts\cp\utility::play_music_to_team("mx_cp_observatory_exfil");
  _id_23548C8BFAF1ED94 = scripts\engine\utility::getStructArray("heli_end_struct", "targetname");

  if(_id_23548C8BFAF1ED94.size == 0) {
    return;
  }
  level._id_97C6C62423E472B5 = [];

  foreach(_id_EA0FBAC82EEC8FC1 in _id_23548C8BFAF1ED94) {
    if(!isDefined(_id_EA0FBAC82EEC8FC1.angles))
      _id_EA0FBAC82EEC8FC1.angles = (0, 0, 0);

    nearbyplayer = _id_EA0FBAC82EEC8FC1 scripts\cp\utility::get_closest_living_player();
    heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(nearbyplayer, _id_EA0FBAC82EEC8FC1.origin, _id_EA0FBAC82EEC8FC1.angles, "mindia8_cp", "veh9_mil_air_heli_palfa_doors_open_vehphys_mp");
    heli.classname_mp = "script_vehicle_iw8_mindia8";
    thread scripts\common\vehicle_paths::gopath(heli);
    path = scripts\engine\utility::getStruct(_id_EA0FBAC82EEC8FC1.target, "targetname");
    heli _id_322B633FA4B5F675(_id_EA0FBAC82EEC8FC1);
    heli vehicle_setspeed(24, 5, 5);
    heli thread _id_91AAF446346613DA(heli.pathing_array);
    heli.unload_land_offset = 260;
    heli.script_disconnectpaths = 1;
    heli.cpvehiclename = "exfil_heli";
    level._id_97C6C62423E472B5[level._id_97C6C62423E472B5.size] = heli;
    heli sethoverparams(0, 0, 0);
    heli setvehicleteam("allies");
  }

  level thread _id_48F20B0FE71DD6DF::_id_C63936225A54FFF7();
  level thread endgame_camera(24);
  level thread _id_605555BC5B80EF07();
  wait 24;

  foreach(heli in level._id_97C6C62423E472B5) {
    heli vehicle_setspeed(1, 5, 5);
    wait 0.5;
  }

  wait 2.5;
}

_id_322B633FA4B5F675(struct) {
  for(self.pathing_array = []; isDefined(struct.target); struct = target) {
    target = scripts\engine\utility::getStruct(struct.target, "targetname");
    self.pathing_array[self.pathing_array.size] = target;
  }
}

_id_91AAF446346613DA(points) {
  self endon("flyaway");
  self endon("death");
  self endon("stop_circling");
  self endon("crashing");
  self notify("circle");
  level endon("hover_lz");
  self._id_7C8EBCD9C1AFA8D2 = 1;
  self clearlookatent();
  _id_E3502859684922D5 = 0;

  if(level._id_97C6C62423E472B5.size == 1) {
    _id_E3502859684922D5 = 1;
    wait 1;
  }

  circle_radius = 2500;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  nextnode = points[1];
  target_ent = scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

  if(!isDefined(target_ent))
    target_ent = self;

  chopper_height = scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B();
  target = (target_ent.origin[0], target_ent.origin[1], chopper_height);
  _id_2F05FDC372F83530 = 0;
  start_point = points[0];
  self setvehgoalpos(points[_id_2F05FDC372F83530].origin, 1);
  self.goalpos = points[_id_2F05FDC372F83530].origin;
  speed = 70;

  if(istrue(_id_E3502859684922D5))
    speed = 60;

  self setneargoalnotifydist(2000);
  self vehicle_setspeed(speed, 20, 30);
  scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");
  _id_0DB715BCDE296BEC = 0;
  index = _id_2F05FDC372F83530 + 1;

  for(;;) {
    if(!isDefined(nextnode)) {
      break;
    }

    self setvehgoalpos(nextnode.origin);
    self.goalpos = nextnode.origin;

    if(index == points.size - 2) {
      self setneargoalnotifydist(200);
      self vehicle_setspeed(20, 10, 60);
    }

    scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");
    _id_0DB715BCDE296BEC++;
    index++;

    if(!isDefined(nextnode.target)) {
      break;
    }

    nextnode = scripts\engine\utility::getStruct(nextnode.target, "targetname");

    if(!isDefined(nextnode)) {
      break;
    }
  }
}

endgame_camera(delay) {
  if(isDefined(delay))
    wait(delay);

  level thread set_player_camera();
}

set_player_camera() {
  foreach(player in level.players)
  player thread _id_C0540638113312ED(1, 1, 1);

  wait 1;

  foreach(player in level.players) {
    _id_693EC2852A7DE810 = scripts\engine\utility::getStruct("camera_ending", "targetname");
    pos = _id_693EC2852A7DE810.origin;
    _id_E50DC87B2DB8A9A0 = scripts\engine\utility::getStruct(_id_693EC2852A7DE810.target, "targetname");
    cam = spawn("script_model", pos);
    cam setModel("tag_origin");
    cam.angles = _id_693EC2852A7DE810.angles;
    cam moveTo(_id_E50DC87B2DB8A9A0.origin, 20, 1, 1);
    player allowfire(0);
    player disableoffhandweapons();
    player disableusability();
    player allowmovement(0);
    player setclientomnvar("ui_hide_hud", 1);
    player spawn_endgame_camera(cam);
    player lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(_id_5940F376A254619D) {
  self.ignoreme = 1;
  self cameralinkTo(_id_5940F376A254619D, "tag_origin", 1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("cg_fov", "50");
}

_id_C0540638113312ED(_id_AD4DD16F29E24B77, _id_F61019386E1B1034, _id_DFAB0807D83A77FE) {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.foreground = 1;

  if(isDefined(_id_AD4DD16F29E24B77) && _id_AD4DD16F29E24B77 > 0)
    overlay.alpha = 0;
  else
    overlay.alpha = 1;

  overlay setshader("black", 640, 480);

  if(isDefined(_id_AD4DD16F29E24B77) && _id_AD4DD16F29E24B77 > 0) {
    self notify("fadeDown_start");
    overlay fadeovertime(_id_AD4DD16F29E24B77);
    overlay.alpha = 1.0;
    wait(_id_AD4DD16F29E24B77);
    self notify("fadeDown_complete");
  }

  if(isDefined(_id_F61019386E1B1034) && _id_F61019386E1B1034 > 0)
    wait(_id_F61019386E1B1034);

  self notify("fadeUp_start");

  if(!isDefined(_id_DFAB0807D83A77FE))
    _id_DFAB0807D83A77FE = 0.5;

  if(_id_DFAB0807D83A77FE > 0) {
    overlay fadeovertime(_id_DFAB0807D83A77FE);
    overlay.alpha = 0.0;
    wait(_id_DFAB0807D83A77FE);
  }

  self notify("fadeUp_complete");

  if(isDefined(overlay))
    overlay destroy();
}

_id_605555BC5B80EF07() {
  wait 24;

  foreach(player in level.players) {}
}