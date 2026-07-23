/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1357.gsc
**************************************/

ride_setup(var_0, var_1) {
  maps\_vehicle::godon();
  maps\_vehicle_aianim::getout_rigspawn(maps\_vehicle_aianim::getanimatemodel(), 3);

  if(!isDefined(var_1)) {
    var_1 = level.players;
  }
  foreach(var_3 in var_1) {}
  thread attach_player(var_3, 3);

  var_5 = 95;

  if(isDefined(var_0.speed)) {
    var_5 = var_0.speed;
  }
  self setairresistance(30);
  self vehicle_setspeed(var_5, 40, level.heli_default_decel);
  maps\_vehicle::vehicle_paths(var_0);
}

attach_player(var_0, var_1, var_2) {
  var_0 thread player_in_heli(self);

  if(getDvar("fastrope_arms") == "") {
    setDvar("fastrope_arms", "0");
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < self.riders.size; var_4++) {
    if(self.riders[var_4].vehicle_position == var_1) {
      var_3 = self.riders[var_4];
      var_3.drone_delete_on_unload = 1;
      var_3.playerpiggyback = 1;
      break;
    }
  }

  var_5 = maps\_vehicle_aianim::anim_pos(self, var_1);
  var_3 notify("newanim");
  var_3 detachall();
  var_3 setModel("fastrope_arms");
  var_3 useanimtree(var_5.player_animtree);
  thread maps\_vehicle_aianim::guy_idle(var_3, var_1);
  wait 0.1;

  if(isDefined(level.little_bird)) {
    var_0 playerlinkTo(var_3, "tag_player", 0.35, 120, 28, 30, 30, 0);
  } else {
    var_0 playerlinkTo(var_3, "tag_player", 0.35, 60, 28, 30, 30, 0);
  }
  var_0 freezecontrols(0);
  var_3 hide();
  var_6 = getanimlength(var_5.getout);
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

player_in_heli(var_0) {
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("g_friendlyfireDist", 0);
  maps\_utility::hide_player_model();
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
  maps\_utility::autosave_by_name("on_the_ground");
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
  maps\_utility::show_player_model();

  if(self == level.player) {
    for(var_1 = 0; var_1 < 24; var_1++) {
      self setOrigin(self.origin + (2, 0, 0));
      wait 0.05;
    }
  }

  setsaveddvar("g_friendlyNameDist", 15000);
  setsaveddvar("g_friendlyfireDist", 128);
}

player_heli_ropeanimoverride_idle(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    maps\_vehicle_aianim::animontag(var_0, var_1, var_2);
  }
}

ride_start(var_0, var_1) {
  var_2 = "heli_ride_in";
  var_3 = getEntArray(var_2, "targetname");

  if(!var_3.size) {
    var_3 = common_scripts\utility::getStructArray("heli_ride_in", "targetname");

    if(!var_3.size) {}
  }

  var_3 = var_3[0];

  if(isDefined(var_1)) {
    maps\_vehicle::vehicle_spawn_group_limit_riders(level.gag_heliride_spawner.script_vehicleride, var_1);
  }
  var_4 = maps\_vehicle::vehicle_spawn(level.gag_heliride_spawner);
  var_4 thread ride_setup(var_3, var_0);
  return var_4;
}