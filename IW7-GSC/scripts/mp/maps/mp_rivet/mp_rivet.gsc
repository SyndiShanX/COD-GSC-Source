/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rivet\mp_rivet.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_rivet\mp_rivet_precache::main();
  scripts\mp\maps\mp_rivet\gen\mp_rivet_art::main();
  scripts\mp\maps\mp_rivet\mp_rivet_fx::main();
  level _id_D80C();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_rivet");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraaccurateocclusionthreshold", 500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  level thread _id_E563();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  thread patchoutofboundstrigger();
}

fix_collision() {
  var_0 = getEnt("clip256x256x8", "targetname");
  var_1 = spawn("script_model", (1142, -4840, -48));
  var_1.angles = (90, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip256x256x8", "targetname");
  var_3 = spawn("script_model", (1142, -4616, -48));
  var_3.angles = (90, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip256x256x8", "targetname");
  var_5 = spawn("script_model", (1357, -4293, 560));
  var_5.angles = (281.3, 0, -180);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("player128x128x128", "targetname");
  var_7 = spawn("script_model", (9.93846, 359.295, -10.0978));
  var_7.angles = (1048, -2334, 246);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

patchoutofboundstrigger() {
  level.outofboundstriggerpatches = [];
  var_0 = spawn("trigger_radius", (-334, -1727, 825), 0, 150, 20);
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_0;
  level waittill("game_ended");

  foreach(var_0 in level.outofboundstriggerpatches) {
    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}

_id_D80C() {
  precachemodel("crane_hangar_04");
  precachemodel("sdf_rivet_runwall_01");
  precachemodel("shipyard_drone_01");
  precachemodel("shipyard_drone_01_paths");
  level._id_1D93 = ["ship_wall_panel", "ship_wall_panel_a_32", "ship_wall_panel_a_32_clean", "ship_wall_panel_a_64", "ship_wall_panel_a_64_clean"];

  foreach(var_1 in level._id_1D93) {
    precachemodel(var_1);
  }

  precachempanim("mp_rivet_drone_path_01");
  precachempanim("mp_rivet_drone_path_02");
  precachempanim("mp_rivet_drone_path_03");
  precachempanim("mp_rivet_drone_path_04");
  precachempanim("mp_rivet_drone_path_05");
  precachempanim("mp_rivet_drone_path_06");
  precachempanim("mp_rivet_drone_path_07");
  precachempanim("mp_rivet_drone_path_08");
  precachempanim("mp_rivet_drone_path_09");
  precachempanim("mp_rivet_drone_path_10");
  precachempanim("mp_rivet_drone_path_11");
  precachempanim("mp_rivet_drone_path_12");
  precachempanim("mp_rivet_drone_path_13");
  precachempanim("mp_rivet_drone_path_14");
}

_id_E563() {
  if(getDvar("r_reflectionProbeGenerate") != "1") {
    level thread _id_FA3A();
    level thread _id_F03C();
    level thread _id_1DA5();
  } else {
    waittillframeend;
    var_0 = getscriptablearray("rivet_scriptable_light", "script_noteworthy");

    foreach(var_2 in var_0) {
      var_2 setscriptablepartstate("onoff", "off");
    }
  }
}

_id_FA3A() {
  waittillframeend;
  var_0 = getscriptablearray("mp_rivet_hanging_turret", "targetname");

  if(var_0.size != 0) {
    foreach(var_2 in var_0) {
      var_3 = spawn("script_model", var_2.origin);
      var_3.angles = var_2.angles;
      var_3 setModel("crane_hangar_04");
      var_3 linkTo(var_2, "j_prop_1");
      var_3 show();
    }
  }

  var_5 = getscriptablearray("mp_rivet_hanging_wall", "targetname");

  if(var_5.size != 0) {
    foreach(var_7 in var_5) {
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_1") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_1");
      var_3 setModel("sdf_rivet_runwall_01");
      var_3 linkTo(var_7, "j_prop_1");
      var_3 show();
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_2") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_2");
      var_3 setModel("shipyard_drone_01");
      var_3 linkTo(var_7, "j_prop_2");
      var_3 show();
      var_3 setscriptablepartstate("anims", "drone1");
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_3") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_3");
      var_3 setModel("shipyard_drone_01");
      var_3 linkTo(var_7, "j_prop_3");
      var_3 show();
      var_3 setscriptablepartstate("anims", "drone2");
    }
  }
}

_id_1DA5() {
  level._id_1D99 = _id_1D9F();

  if(level._id_1D99.size != 0) {
    level thread _id_1DA2();
  }
}

_id_1D9F() {
  level endon("game_ended");
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("ambient_drone_start_loc", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_parameters)) {
      continue;
    }
    var_4 = spawn("script_model", (0, 0, 0));
    var_4.angles = (0, 0, 0);
    var_4 setModel("shipyard_drone_01_paths");
    var_4._id_10DC1 = var_3.origin;
    var_4._id_10D6D = var_3.angles;
    var_4.running = 0;
    var_4.script_parameters = _id_1D92(var_3.script_parameters);

    if(isDefined(var_4.script_parameters)) {
      var_4._id_1FB8 = getanimlength(var_4.script_parameters);
      var_4._id_C891 = var_4 _id_1D9B();
      var_4._id_C891 linkTo(var_4, "tag_ship_wall_panel");
      var_4 _id_1D94();
      var_4 hide();
      var_4.origin = var_4._id_10DC1;
      var_4.angles = var_4._id_10D6D;
      var_4 scriptmodelplayanimdeltamotion(var_4.script_parameters);
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

#using_animtree("mp_script_model");

_id_1D92(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  switch (var_0) {
    case "mp_rivet_drone_path_01":
      return % mp_rivet_drone_path_01;
    case "mp_rivet_drone_path_02":
      return % mp_rivet_drone_path_02;
    case "mp_rivet_drone_path_03":
      return % mp_rivet_drone_path_03;
    case "mp_rivet_drone_path_04":
      return % mp_rivet_drone_path_04;
    case "mp_rivet_drone_path_05":
      return % mp_rivet_drone_path_05;
    case "mp_rivet_drone_path_06":
      return % mp_rivet_drone_path_06;
    case "mp_rivet_drone_path_07":
      return % mp_rivet_drone_path_07;
    case "mp_rivet_drone_path_08":
      return % mp_rivet_drone_path_08;
    case "mp_rivet_drone_path_09":
      return % mp_rivet_drone_path_09;
    case "mp_rivet_drone_path_10":
      return % mp_rivet_drone_path_10;
    case "mp_rivet_drone_path_11":
      return % mp_rivet_drone_path_11;
    case "mp_rivet_drone_path_12":
      return % mp_rivet_drone_path_12;
    case "mp_rivet_drone_path_13":
      return % mp_rivet_drone_path_13;
    case "mp_rivet_drone_path_14":
      return % mp_rivet_drone_path_14;
    default:
      return undefined;
  }

  return undefined;
}

_id_1DA2() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_1D99) {
      if(!isDefined(var_1.running)) {
        var_1.running = 0;
      }

      if(var_1.running == 0) {
        var_1 thread _id_1DA3();
      }
    }

    wait 10;
  }
}

_id_1DA3() {
  level endon("game_ended");
  self endon("death");
  self.running = 1;
  wait(randomfloat(8));
  self scriptmodelclearanim();
  self.origin = self._id_10DC1;
  self.angles = self._id_10D6D;

  if(_id_4346() == 1) {
    _id_1D95();
  }

  self show();
  thread scripts\mp\maps\mp_rivet\mp_rivet_fx::_id_CCEB();

  if(isDefined(self.script_parameters)) {
    self scriptmodelplayanimdeltamotion(self.script_parameters);
  }

  if(isDefined(self._id_1FB8)) {
    wait(self._id_1FB8);
  } else {
    wait 20;
  }

  _id_1D94();
  scripts\mp\maps\mp_rivet\mp_rivet_fx::_id_10FDF();
  self hide();
  self.running = 0;
}

_id_1D9B() {
  var_0 = spawn("script_model", self.origin + (-64, 1, 0));
  var_0 setModel("tag_origin");
  var_0.angles = self.angles + (90, 0, 0);
  return var_0;
}

_id_1D94() {
  self._id_10131 = 0;
  self._id_C891 hide();
}

_id_1D95() {
  self._id_10131 = 1;
  self._id_C891 setModel(scripts\engine\utility::random(level._id_1D93));
  self._id_C891 show();
}

_id_F03C() {
  waittillframeend;
  var_0 = getscriptablearray("mp_rivet_rocket", "targetname")[0];

  if(!isDefined(level._id_E5E1)) {
    level._id_E5E1 = 0;
  }

  if(isDefined(var_0)) {
    var_0._id_4D29 = getEnt("mp_rivet_rocket_damage_vol", "targetname");
    var_0 thread scripts\mp\maps\mp_rivet\mp_rivet_fx::_id_F03D();
    var_0 thread _id_F03F();
  }
}

_id_F03F() {
  thread _id_6D22();
  thread fire_rocket();
}

fire_rocket() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait(45 + randomint(30) - 5);
    level notify("rivet_rocket_firing_soon");
    wait 5;
    level._id_E5E1 = 1;
    level notify("rivet_rocket_firing");
    self setscriptablepartstate("base", "fire");

    foreach(var_1 in self._id_75A4) {
      var_1 setscriptablepartstate("onoff", "on");
    }

    wait 14.8;

    foreach(var_1 in self._id_75A4) {
      var_1 setscriptablepartstate("onoff", "off");
    }

    wait 0.2;
    self setscriptablepartstate("base", "idle");
    level._id_E5E1 = 0;
    level notify("rivet_rocket_done");
  }
}

_id_6D22() {
  level endon("game_ended");
  self endon("death");
  self._id_4D29 thread _id_6D26();

  for(;;) {
    level waittill("rivet_rocket_firing");

    while(level._id_E5E1 == 1) {
      self._id_4D29 waittill("trigger", var_0);

      if(level._id_E5E1 != 1) {
        break;
      }

      if(scripts\mp\utility::isreallyalive(var_0)) {
        var_0 dodamage(var_0.maxhealth, self.origin, var_0, undefined, "MOD_EXPLOSIVE");

        if(isPlayer(var_0) || isagent(var_0)) {
          thread _id_57D4(var_0 _meth_8113());
        }
      }
    }
  }
}

_id_6D26() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  for(;;) {
    level waittill("rivet_rocket_firing");

    while(level._id_E5E1 == 1) {
      var_0 = scripts\engine\utility::array_combine(self getistouchingentities(level.grenades), self getistouchingentities(level.missiles));
      var_0 = scripts\engine\utility::array_combine(self getistouchingentities(level.mines), var_0);

      foreach(var_2 in var_0) {
        var_2 scripts\mp\weapons::deleteexplosive();
      }

      scripts\engine\utility::waitframe();
    }
  }
}

_id_57D4(var_0) {
  waittillframeend;

  if(isDefined(var_0)) {
    var_0 hide();
  }
}

_id_4346() {
  if(randomint(100) > 50) {
    return -1;
  } else {
    return 1;
  }
}