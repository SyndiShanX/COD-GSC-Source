/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1357.gsc
**************************************/

_id_40A4(var_0, var_1) {
  maps\_vehicle::_id_2A12();
  maps\_vehicle_aianim::_id_2574(maps\_vehicle_aianim::_id_25C7(), 3);

  if(!isDefined(var_1)) {
    var_1 = level.players;
  }
  foreach(var_3 in var_1) {}
  thread _id_40A5(var_3, 3);

  var_5 = 95;

  if(isDefined(var_0.speed)) {
    var_5 = var_0.speed;
  }
  self setairresistance(30);
  self vehicle_setspeed(var_5, 40, level._id_28F3);
  maps\_vehicle::_id_26A1(var_0);
}

_id_40A5(var_0, var_1, var_2) {
  var_0 thread _id_40A7(self);

  if(getDvar("fastrope_arms") == "") {
    setDvar("fastrope_arms", "0");
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < self._id_0A39.size; var_4++) {
    if(self._id_0A39[var_4]._id_2252 == var_1) {
      var_3 = self._id_0A39[var_4];
      var_3._id_224F = 1;
      var_3._id_254E = 1;
      break;
    }
  }

  var_5 = maps\_vehicle_aianim::_id_2534(self, var_1);
  var_3 notify("newanim");
  var_3 detachall();
  var_3 setModel("fastrope_arms");
  var_3 useanimtree(var_5._id_2AA4);
  thread maps\_vehicle_aianim::_id_2549(var_3, var_1);
  wait 0.1;

  if(isDefined(level._id_40A6)) {
    var_0 playerlinkto(var_3, "tag_player", 0.35, 120, 28, 30, 30, 0);
  } else {
    var_0 playerlinkto(var_3, "tag_player", 0.35, 60, 28, 30, 30, 0);
  }
  var_0 freezecontrols(0);
  var_3 hide();
  var_6 = getanimlength(var_5._id_257C);
  var_6 = var_6 - var_2;
  self waittill("unloading");

  if(getDvar("fastrope_arms") != "0") {
    var_3 show();
  }
  var_0 disableweapons();
  wait(var_6);
  var_0 unlink();
  var_0 enableweapons();
  setsaveddvar("hud_drawhud", "1");
  level notify("stop_draw_hud_on_death");
}

_id_40A7(var_0) {
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("g_friendlyfireDist", 0);
  maps\_utility::_id_2785();
  self allowsprint(0);
  self allowprone(0);
  self allowstand(0);
  self enableinvulnerability();
  self.ignoreme = 1;
  wait 0.05;
  self setplayerangles((0, 35, 0));
  var_0 waittill("unloading");
  self notify("stop_quake");
  wait 6;
  maps\_utility::_id_1425("on_the_ground");
  self allowprone(0);
  self allowstand(1);
  self allowcrouch(0);
  wait 0.05;
  self allowprone(1);
  self allowcrouch(1);
  self disableinvulnerability();
  self.ignoreme = 0;
  self allowsprint(1);
  wait 4;
  maps\_utility::_id_2786();

  if(self == level.player) {
    for(var_1 = 0; var_1 < 24; var_1++) {
      self setorigin(self.origin + (2, 0, 0));
      wait 0.05;
    }
  }

  setsaveddvar("g_friendlyNameDist", 15000);
  setsaveddvar("g_friendlyfireDist", 128);
}

_id_40A8(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    maps\_vehicle_aianim::_id_259E(var_0, var_1, var_2);
  }
}

_id_40A9(var_0, var_1) {
  var_2 = "heli_ride_in";
  var_3 = getEntArray(var_2, "targetname");

  if(!var_3.size) {
    var_3 = common_scripts\utility::getstructarray("heli_ride_in", "targetname");

    if(!var_3.size) {}
  }

  var_3 = var_3[0];

  if(isDefined(var_1)) {
    maps\_vehicle::_id_2AF5(level._id_2AF1._id_250B, var_1);
  }
  var_4 = maps\_vehicle::_id_211F(level._id_2AF1);
  var_4 thread _id_40A4(var_3, var_0);
  return var_4;
}