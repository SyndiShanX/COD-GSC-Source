/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_dynamic_world.gsc
**********************************************/

init() {
  common_scripts\utility::_id_0FB2(getEntArray("com_wall_fan_blade_rotate_slow", "targetname"), ::_id_3A1E, "veryslow");
  common_scripts\utility::_id_0FB2(getEntArray("com_wall_fan_blade_rotate", "targetname"), ::_id_3A1E, "slow");
  common_scripts\utility::_id_0FB2(getEntArray("com_wall_fan_blade_rotate_fast", "targetname"), ::_id_3A1E, "fast");
  var_0 = [];
  var_0["trigger_multiple_dyn_metal_detector"] = ::_id_6121;
  var_0["trigger_multiple_dyn_creaky_board"] = ::_id_2776;
  var_0["trigger_multiple_dyn_photo_copier"] = ::_id_6F8C;
  var_0["trigger_multiple_dyn_copier_no_light"] = ::_id_6F90;
  var_0["trigger_radius_motion_light"] = ::_id_6462;
  var_0["trigger_radius_dyn_motion_dlight"] = ::_id_6C69;
  var_0["trigger_multiple_dyn_dog_bark"] = ::_id_3198;
  var_0["trigger_radius_bird_startle"] = ::_id_1762;
  var_0["trigger_multiple_dyn_motion_light"] = ::_id_6462;
  var_0["trigger_multiple_dyn_door"] = ::_id_9D70;
  _id_72B0();

  foreach(var_4, var_2 in var_0) {
    var_3 = getEntArray(var_4, "classname");
    common_scripts\utility::_id_0FB2(var_3, ::_id_9DC3);
    common_scripts\utility::_id_0FB2(var_3, var_2);
  }

  common_scripts\utility::_id_0FB2(getEntArray("vending_machine", "targetname"), ::_id_A403);
  common_scripts\utility::_id_0FB2(getEntArray("toggle", "targetname"), ::_id_A1F6);
  common_scripts\utility::_id_0FB2(getEntArray("sliding_door", "targetname"), ::_id_8CA1);
  level thread onplayerconnect();
  var_5 = _getent("civilian_jet_origin", "targetname");

  if(isDefined(var_5))
    var_5 thread _id_2301();

  thread _id_5409();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", var_0);
    var_0 thread _id_64B5();
  }
}

_id_72B0() {
  if(common_scripts\utility::issp()) {
    foreach(var_1 in level.players) {
      var_1._id_9AC5 = [];
      var_1 thread _id_64B5();
    }
  }
}

_id_0AAB() {
  self._id_9AC5 = [];
  thread _id_64B5();
}

_id_2301() {
  level endon("game_ended");
  _id_5963();
  level waittill("prematch_over");

  for(;;) {
    thread _id_5967();
    self waittill("start_flyby");
    thread _id_5961();
    self waittill("flyby_done");
    _id_5966();
  }
}

_id_5963() {
  self._id_5964 = getEntArray(self.target, "targetname");
  self._id_5962 = _getent("civilian_jet_flyto", "targetname");
  self._id_3776 = getEntArray("engine_fx", "targetname");
  self._id_3D3F = getEntArray("flash_fx", "targetname");
  self._id_595B = loadfx("vfx/test/test_fx");
  self._id_595E = loadfx("vfx/lights/aircraft_light_wingtip_red");
  self._id_595D = loadfx("vfx/lights/aircraft_light_wingtip_green");
  self._id_595C = loadfx("vfx/lights/aircraft_light_red_blink");
  level._id_2304 = undefined;
  var_0 = vectorNormalize(self.origin - self._id_5962.origin) * 20000;
  self._id_5962.origin = self._id_5962.origin - var_0;
  self.origin = self.origin + var_0;

  foreach(var_2 in self._id_5964) {
    var_2.origin = var_2.origin + var_0;
    var_2._id_6A43 = var_2.origin;
    var_2 hide();
  }

  foreach(var_5 in self._id_3776)
  var_5.origin = var_5.origin + var_0;

  foreach(var_8 in self._id_3D3F)
  var_8.origin = var_8.origin + var_0;

  var_10 = self.origin;
  var_11 = self._id_5962.origin;
  self._id_5960 = var_11 - var_10;
  var_12 = 2000;
  var_13 = _abs(distance(var_10, var_11));
  self._id_595F = var_13 / var_12;
}

_id_5966() {
  foreach(var_1 in self._id_5964) {
    var_1.origin = var_1._id_6A43;
    var_1 hide();
  }
}

_id_5967() {
  level endon("game_ended");
  var_0 = _id_46E1();
  var_1 = max(10, var_0);
  var_1 = _min(var_1, 100);

  if(getDvar("jet_flyby_timer") != "")
    level._id_2305 = 5 + getdvarint("jet_flyby_timer");
  else
    level._id_2305 = (0.25 + _randomfloatrange(0.3, 0.7)) * 60 * var_1;

  wait(level._id_2305);

  while(isDefined(level._id_0B97) || isDefined(level._id_084B) || isDefined(level._id_2210) || isDefined(level._id_7C66))
    waitframe();

  self notify("start_flyby");
  level._id_2304 = 1;
  self waittill("flyby_done");
  level._id_2304 = undefined;
}

_id_46E1() {
  if(common_scripts\utility::issp())
    return 10.0;

  if(isDefined(game["status"]) && game["status"] == "overtime")
    return 1.0;
  else
    return getwatcheddvar("timelimit");
}

getwatcheddvar(var_0) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(isDefined(level._id_6CC8) && isDefined(level._id_6CC8[var_0]))
    return level._id_6CC8[var_0];

  return level.watchdvars[var_0].value;
}

_id_5961() {
  foreach(var_1 in self._id_5964)
  var_1 show();

  var_3 = [];
  var_4 = [];

  foreach(var_6 in self._id_3776) {
    var_7 = spawn("script_model", var_6.origin);
    var_7 setModel("tag_origin");
    var_7.angles = var_6.angles;
    var_3[var_3.size] = var_7;
  }

  foreach(var_10 in self._id_3D3F) {
    var_11 = spawn("script_model", var_10.origin);
    var_11 setModel("tag_origin");
    var_11.color = var_10._id_0165;
    var_11.angles = var_10.angles;
    var_4[var_4.size] = var_11;
  }

  thread _id_5965(self._id_5964[0], level._id_5FEB);
  waitframe();

  foreach(var_7 in var_3)
  _playfxontag(self._id_595B, var_7, "tag_origin");

  foreach(var_11 in var_4) {
    if(isDefined(var_11.color) && var_11.color == "blink") {
      _playfxontag(self._id_595C, var_11, "tag_origin");
      continue;
    }

    if(isDefined(var_11.color) && var_11.color == "red") {
      _playfxontag(self._id_595E, var_11, "tag_origin");
      continue;
    }

    _playfxontag(self._id_595D, var_11, "tag_origin");
  }

  foreach(var_1 in self._id_5964)
  var_1 moveto(var_1.origin + self._id_5960, self._id_595F);

  foreach(var_7 in var_3)
  var_7 moveto(var_7.origin + self._id_5960, self._id_595F);

  foreach(var_11 in var_4)
  var_11 moveto(var_11.origin + self._id_5960, self._id_595F);

  wait(self._id_595F + 1);

  foreach(var_7 in var_3)
  var_7 delete();

  foreach(var_11 in var_4)
  var_11 delete();

  self notify("flyby_done");
}

_id_5965(var_0, var_1) {
  var_0 thread _id_74D6("veh_mig29_dist_loop");

  while(!_id_982B(var_0, var_1))
    waitframe();

  var_0 thread _id_74D6("veh_mig29_close_loop");

  while(_id_982C(var_0, var_1))
    waitframe();

  wait 0.5;
  var_0 thread _id_74D5("veh_mig29_sonic_boom");

  while(_id_982B(var_0, var_1))
    waitframe();

  var_0 notify("stop soundveh_mig29_close_loop");
  self waittill("flyby_done");
  var_0 notify("stop soundveh_mig29_dist_loop");
}

_id_74D5(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 1));
  var_3 hide();

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_3.origin = var_1;

  if(isDefined(var_2) && var_2)
    var_3 playsoundasmaster(var_0);
  else
    var_3 playSound(var_0);

  wait 10.0;
  var_3 delete();
}

_id_74D6(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();
  var_2 endon("death");
  thread common_scripts\utility::_id_2D18(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linkto(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkto(self);
  }

  var_2 playloopsound(var_0);
  self waittill("stop sound" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

_id_982C(var_0, var_1) {
  var_2 = anglesToForward(common_scripts\utility::_id_3D5C(var_0.angles));
  var_3 = vectorNormalize(common_scripts\utility::_id_3D5D(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0)
    return 1;
  else
    return 0;
}

_id_982B(var_0, var_1) {
  var_2 = _id_982C(var_0, var_1);

  if(var_2)
    var_3 = 1;
  else
    var_3 = -1;

  var_4 = common_scripts\utility::_id_3D5D(var_0.origin);
  var_5 = var_4 + anglesToForward(common_scripts\utility::_id_3D5C(var_0.angles)) * (var_3 * 100000);
  var_6 = _pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);

  if(var_7 < 3000)
    return 1;
  else
    return 0;
}

_id_A403() {
  level endon("game_ended");
  self endon("death");
  self setcursorhint("HINT_ACTIVATE");
  self._id_A5B1 = _getent(self.target, "targetname");
  var_0 = _getent(self._id_A5B1.target, "targetname");
  var_1 = _getent(var_0.target, "targetname");
  var_2 = _getent(var_1.target, "targetname");
  self._id_A5AC = var_2.origin;
  var_3 = _getent(var_2.target, "targetname");
  self._id_A5AD = var_3.origin;

  if(isDefined(var_3.target))
    self._id_A5A7 = _getent(var_3.target, "targetname").origin;

  self._id_A5B1 setcandamage(1);
  self._id_A5B2 = self._id_A5B1.model;
  self._id_A5A5 = self._id_A5B1._id_0165;
  self._id_A5C0 = var_0.model;
  self._id_A5C2 = var_0.origin;
  self._id_A5C1 = var_0.angles;
  self._id_A5C4 = var_1.origin;
  self._id_A5C3 = var_1.angles;
  precachemodel(self._id_A5A5);
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  self._id_8ED8 = [];
  self._id_8EDB = 12;
  self._id_8EDC = undefined;
  self._id_4F00 = 400;
  thread _id_A404(self._id_A5B1);
  self playloopsound("vending_machine_hum");

  for(;;) {
    self waittill("trigger", var_4);
    self playSound("vending_machine_button_press");

    if(!self._id_8EDB) {
      continue;
    }
    if(isDefined(self._id_8EDC))
      _id_8EDA();

    _id_8ED9(_id_8FF4());
    waitframe();
  }
}

_id_A404(var_0) {
  level endon("game_ended");
  var_1 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
  var_2 = loadfx("vfx/test/test_fx");

  for(;;) {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_0 waittill("damage", var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_7)) {
      if(issubstr(var_1, _tolower(var_7)))
        var_3 = var_3 * 3;

      self._id_4F00 = self._id_4F00 - var_3;

      if(self._id_4F00 > 0) {
        continue;
      }
      self notify("death");
      self.origin = self.origin + (0, 0, 10000);

      if(!isDefined(self._id_A5A7))
        var_8 = self._id_A5B1.origin + (37, -31, 52);
      else
        var_8 = self._id_A5A7;

      playFX(var_2, var_8);
      self._id_A5B1 setModel(self._id_A5A5);

      while(self._id_8EDB > 0) {
        if(isDefined(self._id_8EDC))
          _id_8EDA();

        _id_8ED9(_id_8FF4());
        waitframe();
      }

      self stoploopsound("vending_machine_hum");
      return;
    }
  }
}

_id_8FF4() {
  var_0 = spawn("script_model", self._id_A5C2);
  var_0 setModel(self._id_A5C0);
  var_0.origin = self._id_A5C2;
  var_0.angles = self._id_A5C1;
  return var_0;
}

_id_8ED9(var_0) {
  var_0 moveto(self._id_A5C4, 0.2);
  var_0 playSound("vending_machine_soda_drop");
  wait 0.2;
  self._id_8EDC = var_0;
  self._id_8EDB--;
}

_id_8EDA() {
  self endon("death");

  if(isDefined(self._id_8EDC._id_35AB) && self._id_8EDC._id_35AB == 1) {
    return;
  }
  var_0 = 1;
  var_1 = var_0 * -999;
  var_2 = int(40000);
  var_3 = (int(var_2 / 2), int(var_2 / 2), 0) - (randomint(var_2), randomint(var_2), 0);
  var_4 = vectorNormalize(self._id_A5AD - self._id_A5AC + var_3);
  var_5 = var_4 * _randomfloatrange(var_1, var_0);
  self._id_8EDC physicslaunchclient(self._id_A5AC, var_5);
  self._id_8EDC._id_35AB = 1;
}

_id_3E88() {
  level endon("game_ended");
  var_0 = "briefcase_bomb_mp";

  for(;;) {
    self waittill("trigger_enter", var_1);

    if(!var_1 hasweapon(var_0)) {
      var_1 playSound("freefall_death");
      var_1 maps\mp\_utility::_giveweapon(var_0);
      var_1 setweaponammostock(var_0, 0);
      var_1 setweaponammoclip(var_0, 0);
      var_1 switchtoweapon(var_0);
    }
  }
}

_id_6121() {
  level endon("game_ended");
  var_0 = _getent(self.target, "targetname");
  var_0 enablegrenadetouchdamage();
  var_1 = _getent(var_0.target, "targetname");
  var_2 = _getent(var_1.target, "targetname");
  var_3 = _getent(var_2.target, "targetname");
  var_4 = _getent(var_3.target, "targetname");
  var_5 = [];
  var_6 = _min(var_1.origin[0], var_2.origin[0]);
  var_5[0] = var_6;
  var_7 = max(var_1.origin[0], var_2.origin[0]);
  var_5[1] = var_7;
  var_8 = _min(var_1.origin[1], var_2.origin[1]);
  var_5[2] = var_8;
  var_9 = max(var_1.origin[1], var_2.origin[1]);
  var_5[3] = var_9;
  var_10 = _min(var_1.origin[2], var_2.origin[2]);
  var_5[4] = var_10;
  var_11 = max(var_1.origin[2], var_2.origin[2]);
  var_5[5] = var_11;
  var_1 delete();
  var_2 delete();

  if(!common_scripts\utility::issp())
    self._id_0BAB = 7;
  else
    self._id_0BAB = 2;

  self._id_0BAC = 0;
  self._id_0BAA = 0;
  self._id_9A89 = 0;
  thread _id_6122(var_0);
  thread _id_6123();
  thread _id_6124(var_5, "weapon_claymore", "weapon_c4");
  var_12 = (var_3.origin[0], var_3.origin[1], var_11);
  var_13 = (var_4.origin[0], var_4.origin[1], var_11);
  var_14 = loadfx("vfx/test/test_fx");

  for(;;) {
    common_scripts\utility::_id_A70A("dmg_triggered", "touch_triggered", "weapon_triggered");
    thread _id_74D4("alarm_metal_detector", var_14, var_12, var_13);
  }
}

_id_74D4(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!self._id_0BAC) {
    self._id_0BAC = 1;
    thread _id_0F06();

    if(!self._id_0BAA)
      self playSound(var_0);

    playFX(var_1, var_2);
    playFX(var_1, var_3);
    wait(self._id_0BAB);
    self._id_0BAC = 0;
  }
}

_id_0F06() {
  level endon("game_ended");

  if(!self._id_9A89) {
    return;
  }
  var_0 = self._id_0BAB + 0.15;

  if(self._id_9A89)
    self._id_9A89--;
  else
    self._id_0BAA = 1;

  var_1 = gettime();
  var_2 = 7;

  if(common_scripts\utility::issp())
    var_2 = 2;

  _id_A714("dmg_triggered", "touch_triggered", "weapon_triggered", var_2 + 2);
  var_3 = gettime() - var_1;

  if(var_3 > var_2 * 1000 + 1150) {
    self._id_0BAA = 0;
    self._id_9A89 = 0;
  }
}

_id_A714(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon(var_0);
  self endon(var_1);
  self endon(var_2);
  wait(var_3);
}

_id_6124(var_0, var_1, var_2) {
  level endon("game_ended");

  for(;;) {
    _id_A773();
    var_3 = getEntArray("grenade", "classname");

    foreach(var_5 in var_3) {
      if(isDefined(var_5.model) && (var_5.model == var_1 || var_5.model == var_2)) {
        if(_id_5719(var_5, var_0))
          thread _id_A9AE(var_5, var_0);
      }
    }
  }
}

_id_A773() {
  level endon("game_ended");
  self endon("dmg_triggered");
  self waittill("touch_triggered");
}

_id_A9AE(var_0, var_1) {
  var_0 endon("death");

  while(_id_5719(var_0, var_1)) {
    self notify("weapon_triggered");
    wait(self._id_0BAB);
  }
}

_id_5719(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_5 = var_1[3];
  var_6 = var_1[4];
  var_7 = var_1[5];
  var_8 = var_0.origin[0];
  var_9 = var_0.origin[1];
  var_10 = var_0.origin[2];

  if(_id_571A(var_8, var_2, var_3)) {
    if(_id_571A(var_9, var_4, var_5)) {
      if(_id_571A(var_10, var_6, var_7))
        return 1;
    }
  }

  return 0;
}

_id_571A(var_0, var_1, var_2) {
  if(var_0 > var_1 && var_0 < var_2)
    return 1;

  return 0;
}

_id_6122(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_5) && _id_0BAD(var_5))
      self notify("dmg_triggered");
  }
}

_id_6123() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger_enter");

    while(_id_0F13(self)) {
      self notify("touch_triggered");
      wait(self._id_0BAB);
    }
  }
}

_id_0BAD(var_0) {
  var_1 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
  var_2 = strtok(var_1, " ");

  foreach(var_4 in var_2) {
    if(_tolower(var_4) == _tolower(var_0))
      return 1;
  }

  return 0;
}

_id_2776() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger_enter", var_0);
    var_0 thread _id_30A4(self);
  }
}

_id_30A4(var_0) {
  self endon("disconnect");
  self endon("death");
  self playSound("step_walk_plr_woodcreak_on");

  for(;;) {
    self waittill("trigger_leave", var_1);

    if(var_0 != var_1) {
      continue;
    }
    self playSound("step_walk_plr_woodcreak_off");
    return;
  }
}

_id_6462() {
  level endon("game_ended");
  self._id_64DD = 1;
  self._id_5D7C = 0;
  var_0 = getEntArray(self.target, "targetname");
  common_scripts\utility::_id_6753(["com_two_light_fixture_off", "com_two_light_fixture_on"], ::precachemodel);

  foreach(var_2 in var_0) {
    var_2._id_5D71 = [];
    var_3 = _getent(var_2.target, "targetname");

    if(!isDefined(var_3.target)) {
      continue;
    }
    var_2._id_5D71 = getEntArray(var_3.target, "targetname");
  }

  for(;;) {
    self waittill("trigger_enter");

    while(_id_0F13(self)) {
      var_5 = 0;

      foreach(var_7 in self._id_9AC3) {
        if(isDefined(var_7._id_3040) && var_7._id_3040 > 5.0)
          var_5 = 1;
      }

      if(var_5) {
        if(!self._id_5D7C) {
          self._id_5D7C = 1;
          var_0[0] playSound("switch_auto_lights_on");

          foreach(var_2 in var_0) {
            var_2 setlightintensity(1.0);

            if(isDefined(var_2._id_5D71)) {
              foreach(var_11 in var_2._id_5D71)
              var_11 setModel("com_two_light_fixture_on");
            }
          }
        }

        thread _id_6463(var_0, 10.0);
      }

      waitframe();
    }
  }
}

_id_6463(var_0, var_1) {
  self notify("motion_light_timeout");
  self endon("motion_light_timeout");
  wait(var_1);

  foreach(var_3 in var_0) {
    var_3 setlightintensity(0);

    if(isDefined(var_3._id_5D71)) {
      foreach(var_5 in var_3._id_5D71)
      var_5 setModel("com_two_light_fixture_off");
    }
  }

  var_0[0] playSound("switch_auto_lights_off");
  self._id_5D7C = 0;
}

_id_6C69() {
  if(!isDefined(level._id_6C6B))
    level._id_6C6B = loadfx("vfx/lights/outdoor_motion_light");

  level endon("game_ended");
  self._id_64DD = 1;
  self._id_5D7C = 0;
  var_0 = _getent(self.target, "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::_id_6753(["com_two_light_fixture_off", "com_two_light_fixture_on"], ::precachemodel);

  for(;;) {
    self waittill("trigger_enter");

    while(_id_0F13(self)) {
      var_2 = 0;

      foreach(var_4 in self._id_9AC3) {
        if(isDefined(var_4._id_3040) && var_4._id_3040 > 5.0)
          var_2 = 1;
      }

      if(var_2) {
        if(!self._id_5D7C) {
          self._id_5D7C = 1;
          var_0 playSound("switch_auto_lights_on");
          var_0 setModel("com_two_light_fixture_on");

          foreach(var_7 in var_1) {
            var_7._id_5D2F = spawn("script_model", var_7.origin);
            var_7._id_5D2F setModel("tag_origin");
            _playfxontag(level._id_6C6B, var_7._id_5D2F, "tag_origin");
          }
        }

        thread _id_6C6A(var_0, var_1, 10.0);
      }

      waitframe();
    }
  }
}

_id_6C6A(var_0, var_1, var_2) {
  self notify("motion_light_timeout");
  self endon("motion_light_timeout");
  wait(var_2);

  foreach(var_4 in var_1)
  var_4._id_5D2F delete();

  var_0 playSound("switch_auto_lights_off");
  var_0 setModel("com_two_light_fixture_off");
  self._id_5D7C = 0;
}

_id_3198() {
  level endon("game_ended");
  self._id_64DD = 1;
  var_0 = _getent(self.target, "targetname");

  for(;;) {
    self waittill("trigger_enter", var_1);

    while(_id_0F13(self)) {
      var_2 = 0;

      foreach(var_4 in self._id_9AC3) {
        if(isDefined(var_4._id_3040) && var_4._id_3040 > var_2)
          var_2 = var_4._id_3040;
      }

      if(var_2 > 6.0) {
        var_0 playSound("dyn_anml_dog_bark");
        wait(_randomfloatrange(16 / var_2, 16 / var_2 + _randomfloat(1.0)));
        continue;
      }

      waitframe();
    }
  }
}

_id_9D70() {
  var_0 = _getent(self.target, "targetname");
  self._id_3288 = var_0;
  self._id_3282 = _id_4710(vectorNormalize(self getorigin() - var_0 getorigin()));
  var_0._id_1631 = var_0.angles[1];
  var_1 = 1.0;

  for(;;) {
    self waittill("trigger_enter", var_2);
    var_0 thread _id_328D(var_1, _id_44A7(var_2));

    if(_id_0F13(self))
      self waittill("trigger_empty");

    wait 3.0;

    if(_id_0F13(self))
      self waittill("trigger_empty");

    var_0 thread _id_3285(var_1);
  }
}

_id_328D(var_0, var_1) {
  if(var_1)
    self rotateto((0, self._id_1631 + 90, 1), var_0, 0.1, 0.75);
  else
    self rotateto((0, self._id_1631 - 90, 1), var_0, 0.1, 0.75);

  self playSound("door_generic_house_open");
  wait(var_0 + 0.05);
}

_id_3285(var_0) {
  self rotateto((0, self._id_1631, 1), var_0);
  self playSound("door_generic_house_close");
  wait(var_0 + 0.05);
}

_id_44A7(var_0) {
  return vectordot(self._id_3282, vectorNormalize(var_0.origin - self._id_3288 getorigin())) > 0;
}

_id_4710(var_0) {
  return (var_0[1], 0 - var_0[0], var_0[2]);
}

_id_A1F6() {
  if(self.classname != "trigger_use_touch") {
    return;
  }
  var_0 = getEntArray(self.target, "targetname");
  self._id_5D7C = 1;

  foreach(var_2 in var_0)
  var_2 setlightintensity(1.5 * self._id_5D7C);

  for(;;) {
    self waittill("trigger");
    self._id_5D7C = !self._id_5D7C;

    if(self._id_5D7C) {
      foreach(var_2 in var_0)
      var_2 setlightintensity(1.5);

      self playSound("switch_auto_lights_on");
      continue;
    }

    foreach(var_2 in var_0)
    var_2 setlightintensity(0);

    self playSound("switch_auto_lights_off");
  }
}

_id_1762() {}

_id_6F8E(var_0) {
  self._id_2660 = _id_4290(var_0);

  if(isDefined(self._id_2660)) {
    var_1 = _getent(self._id_2660.target, "targetname");

    if(isDefined(var_1)) {
      var_2 = _getent(var_1.target, "targetname");

      if(isDefined(var_2)) {
        var_2.intensity = var_2 getlightintensity();
        var_2 setlightintensity(0);
        var_0._id_2664 = var_1;
        var_0._id_9269 = var_1.origin;
        var_0._id_5CCE = var_2;
        var_3 = self._id_2660.angles + (0, 90, 0);
        var_4 = anglesToForward(var_3);
        var_0._id_369A = var_0._id_9269 + var_4 * 30;
      }
    }
  }
}

_id_4290(var_0) {
  if(!isDefined(var_0.target)) {
    var_1 = getEntArray("destructible_toy", "targetname");
    var_2 = var_1[0];

    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_0075) && var_4._id_0075 == "toy_copier") {
        if(distance(var_0.origin, var_2.origin) > distance(var_0.origin, var_4.origin))
          var_2 = var_4;
      }
    }
  } else {
    var_2 = _getent(var_0.target, "targetname");

    if(isDefined(var_2))
      var_2 setcandamage(1);
  }

  return var_2;
}

_id_A724() {
  if(!isDefined(self._id_2660)) {
    return;
  }
  self._id_2660 endon("FX_State_Change0");
  self._id_2660 endon("death");
  self waittill("trigger_enter");
}

_id_6F8C() {
  level endon("game_ended");
  _id_6F8E(self);

  if(!isDefined(self._id_2660)) {
    return;
  }
  self._id_2660 endon("FX_State_Change0");
  thread _id_6F91();

  for(;;) {
    _id_A724();
    self playSound("mach_copier_run");

    if(isDefined(self._id_2664)) {
      _id_7D2E(self);
      thread _id_6F8D();
      thread _id_6F8F();
    }

    wait 3;
  }
}

_id_6F90() {
  level endon("game_ended");
  self endon("death");

  if(common_scripts\utility::get_template_level() == "hamburg") {
    return;
  }
  self._id_2660 = _id_4290(self);

  if(!isDefined(self._id_2660)) {
    return;
  }
  self._id_2660 endon("FX_State_Change0");

  for(;;) {
    _id_A724();
    self playSound("mach_copier_run");
    wait 3;
  }
}

_id_7D2E(var_0) {
  var_0._id_2664 moveto(var_0._id_9269, 0.2);
  var_0._id_5CCE setlightintensity(0);
}

_id_6F8D() {
  self._id_2660 notify("bar_goes");
  self._id_2660 endon("bar_goes");
  self._id_2660 endon("FX_State_Change0");
  self._id_2660 endon("death");
  var_0 = self._id_2664;
  wait 2.0;
  var_0 moveto(self._id_369A, 1.6);
  wait 1.8;
  var_0 moveto(self._id_9269, 1.6);
  wait 1.6;
  var_1 = self._id_5CCE;
  var_2 = 0.2;
  var_3 = var_2 / 0.05;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_4 * 0.05;
    var_5 = var_5 / var_2;
    var_5 = 1 - var_5 * var_1.intensity;

    if(var_5 > 0)
      var_1 setlightintensity(var_5);

    waitframe();
  }
}

_id_6F8F() {
  self._id_2660 notify("light_on");
  self._id_2660 endon("light_on");
  self._id_2660 endon("FX_State_Change0");
  self._id_2660 endon("death");
  var_0 = self._id_5CCE;
  var_1 = 0.2;
  var_2 = var_1 / 0.05;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_3 * 0.05;
    var_4 = var_4 / var_1;
    var_0 setlightintensity(var_4 * var_0.intensity);
    waitframe();
  }

  _id_6F92(var_0);
}

_id_6F91() {
  self._id_2660 waittill("FX_State_Change0");
  self._id_2660 endon("death");
  _id_7D2E(self);
}

_id_6F92(var_0) {
  var_0 setlightintensity(1);
  waitframe();
  var_0 setlightintensity(0);
  wait 0.1;
  var_0 setlightintensity(1);
  waitframe();
  var_0 setlightintensity(0);
  wait 0.1;
  var_0 setlightintensity(1);
}

_id_3A1E(var_0) {
  var_1 = 0;
  var_2 = 20000;
  var_3 = 1.0;

  if(isDefined(self._id_018A))
    var_3 = self._id_018A;

  if(var_0 == "slow") {
    if(isDefined(self._id_0165) && self._id_0165 == "lockedspeed")
      var_1 = 180;
    else
      var_1 = _randomfloatrange(100 * var_3, 360 * var_3);
  } else if(var_0 == "fast")
    var_1 = _randomfloatrange(720 * var_3, 1000 * var_3);
  else if(var_0 == "veryslow")
    var_1 = _randomfloatrange(1 * var_3, 2 * var_3);
  else {}

  if(isDefined(self._id_0165) && self._id_0165 == "lockedspeed")
    wait 0;
  else
    wait(_randomfloatrange(0, 1));

  if(!isDefined(self)) {
    return;
  }
  var_4 = self.angles;
  var_5 = anglestoright(self.angles) * 100;
  var_5 = vectorNormalize(var_5);

  for(;;) {
    var_6 = _abs(vectordot(var_5, (1, 0, 0)));
    var_7 = _abs(vectordot(var_5, (0, 1, 0)));
    var_8 = _abs(vectordot(var_5, (0, 0, 1)));

    if(var_6 > 0.9)
      self rotatevelocity((var_1, 0, 0), var_2);
    else if(var_7 > 0.9)
      self rotatevelocity((var_1, 0, 0), var_2);
    else if(var_8 > 0.9)
      self rotatevelocity((0, var_1, 0), var_2);
    else
      self rotatevelocity((0, var_1, 0), var_2);

    wait(var_2);
  }
}

_id_9DC3(var_0, var_1) {
  level endon("game_ended");
  self endon("deleted");
  self._id_37D8 = self getentitynumber();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2) && !isDefined(var_2._id_3BAA)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_9AC5) && !isDefined(var_2._id_9AC5[self._id_37D8]))
      var_2 thread _id_7477(self, var_0, var_1);
  }
}

_id_7477(var_0, var_1, var_2) {
  var_0 endon("deleted");

  if(!isPlayer(self))
    self endon("death");

  if(!common_scripts\utility::issp())
    var_3 = self.guid;
  else
    var_3 = "player" + gettime();

  var_0._id_9AC3[var_3] = self;

  if(isDefined(var_0._id_64DD))
    self._id_64DE++;

  var_0 notify("trigger_enter", self);
  self notify("trigger_enter", var_0);

  if(isDefined(var_1))
    self thread[[var_1]](var_0);

  self._id_9AC5[var_0._id_37D8] = var_0;

  while(isalive(self) && self istouching(var_0) && (common_scripts\utility::issp() || !level.gameended))
    waitframe();

  if(isDefined(self)) {
    self._id_9AC5[var_0._id_37D8] = undefined;

    if(isDefined(var_0._id_64DD))
      self._id_64DE--;

    self notify("trigger_leave", var_0);

    if(isDefined(var_2))
      self thread[[var_2]](var_0);
  }

  if(!common_scripts\utility::issp() && level.gameended) {
    return;
  }
  var_0._id_9AC3[var_3] = undefined;
  var_0 notify("trigger_leave", self);

  if(!_id_0F13(var_0))
    var_0 notify("trigger_empty");
}

_id_64B5() {
  if(isDefined(level._id_2F91)) {
    return;
  }
  self endon("disconnect");

  if(!isPlayer(self))
    self endon("death");

  self._id_64DE = 0;
  self._id_3040 = 0;

  for(;;) {
    self waittill("trigger_enter");
    var_0 = self.origin;

    while(self._id_64DE) {
      self._id_3040 = distance(var_0, self.origin);
      var_0 = self.origin;
      waitframe();
    }

    self._id_3040 = 0;
  }
}

_id_0F13(var_0) {
  return var_0._id_9AC3.size;
}

_id_7476(var_0, var_1) {
  return isDefined(var_0._id_9AC5[var_1._id_37D8]);
}

_id_5409() {
  var_0 = getEntArray("interactive_tv", "targetname");

  if(var_0.size) {
    common_scripts\utility::_id_6753(["com_tv2_d", "com_tv1_d", "com_tv1", "com_tv2", "com_tv1_testpattern", "com_tv2_testpattern"], ::precachemodel);
    level._id_1BB0["tv_explode"] = loadfx("vfx/test/test_fx");
  }

  level._id_9FB8 = getEntArray("interactive_tv_light", "targetname");
  common_scripts\utility::_id_0FB2(getEntArray("interactive_tv", "targetname"), ::_id_9FB9);
}

_id_9FB9() {
  self setcandamage(1);
  self._id_29D1 = undefined;
  self._id_6A14 = undefined;
  self._id_29D1 = "com_tv2_d";
  self._id_6A14 = "com_tv2";
  self._id_6B58 = "com_tv2_testpattern";

  if(issubstr(self.model, "1")) {
    self._id_6A14 = "com_tv1";
    self._id_6B58 = "com_tv1_testpattern";
  }

  if(isDefined(self.target)) {
    if(isDefined(level._id_2F49)) {
      var_0 = _getent(self.target, "targetname");

      if(isDefined(var_0))
        var_0 delete();
    } else {
      self._id_A241 = _getent(self.target, "targetname");
      self._id_A241 usetriggerrequirelookat();
      self._id_A241 setcursorhint("HINT_NOICON");
    }
  }

  var_1 = common_scripts\utility::_id_40B0(self.origin, level._id_9FB8, undefined, undefined, 64);

  if(var_1.size) {
    self._id_5DD4 = var_1[0];
    level._id_9FB8 = common_scripts\utility::_id_0F93(level._id_9FB8, self._id_5DD4);
    self._id_5DD6 = self._id_5DD4 getlightintensity();
  }

  thread _id_9FB7();

  if(isDefined(self._id_A241))
    thread _id_9FBA();
}

_id_9FBA() {
  self._id_A241 endon("death");

  for(;;) {
    wait 0.2;
    self._id_A241 waittill("trigger");
    self notify("off");

    if(self.model == self._id_6A14) {
      self setModel(self._id_6B58);

      if(isDefined(self._id_5DD4))
        self._id_5DD4 setlightintensity(self._id_5DD6);

      continue;
    }

    self setModel(self._id_6A14);

    if(isDefined(self._id_5DD4))
      self._id_5DD4 setlightintensity(0);
  }
}

_id_9FB7() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  self notify("off");

  if(isDefined(self._id_A241))
    self._id_A241 notify("death");

  self setModel(self._id_29D1);

  if(isDefined(self._id_5DD4))
    self._id_5DD4 setlightintensity(0);

  _playfxontag(level._id_1BB0["tv_explode"], self, "tag_fx");
  self playSound("tv_shot_burst");

  if(isDefined(self._id_A241))
    self._id_A241 delete();
}

_id_8CA1() {
  if(!isDefined(self._id_6BF5))
    self._id_6BF5 = 1;

  var_0 = getEntArray(self.target, "script_linkname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_origin") {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_3 _id_3265(self._id_6BF5);
  }

  var_0 = common_scripts\utility::_id_0F94(var_0, var_1);

  for(;;) {
    if(!isDefined(_func_2D1())) {
      wait 1;
      continue;
    }

    var_5 = _vehicle_getarray();
    var_6 = common_scripts\utility::_id_0F73(_func_2D1(), var_5);
    var_7 = 0;

    foreach(var_9 in var_6) {
      if(isDefined(var_9.team) && var_9.team == "spectator" || isDefined(var_9.sessionstate) && var_9.sessionstate == "spectator") {
        continue;
      }
      if(var_9 istouching(self)) {
        var_7++;
        break;
      }
    }

    if(var_7 > 0)
      _id_6BE2(var_0);
    else {
      var_11 = 1;
      thread _id_2430(var_0, var_11);
    }

    waitframe();
  }
}

_id_3265(var_0) {
  self._id_926A = self.origin;
  self._id_8CA2 = "closed";
  var_1 = _getent(self.target, "targetname");
  self._id_6BF3 = var_1.origin;
  self._id_6BF8 = distance(self._id_6BF3, self.origin) / var_0;
}

_id_6BE2(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_8CA2 == "open" || var_2._id_8CA2 == "opening") {
      continue;
    }
    var_2 thread _id_6BE8();
  }
}

_id_6BE8() {
  self._id_8CA2 = "opening";
  var_0 = distance(self.origin, self._id_6BF3) / self._id_6BF8;

  if(var_0 < 0.05)
    var_0 = 0.05;

  self moveto(self._id_6BF3, var_0);
  self playSound("glass_door_open");
  wait(var_0);
  self._id_8CA2 = "open";
}

_id_2430(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3._id_8CA2 == "closed" || var_3._id_8CA2 == "opening") {
      continue;
    }
    var_3 moveto(var_3._id_926A, var_1);
    self playSound("glass_door_close");
    var_3._id_8CA2 = "closed";
  }
}