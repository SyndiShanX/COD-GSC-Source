/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\321.gsc
**************************************/

main() {
  if(maps\_utility::_id_1E25()) {
    return;
  }
  precachestring(&"SCRIPT_INTELLIGENCE_OF_FOURTYSIX");
  precachestring(&"SCRIPT_INTELLIGENCE_PREV_FOUND");
  level._id_1E26 = _id_1E32();
  setdvar("ui_level_cheatpoints", level._id_1E26.size);
  level._id_1E27 = 0;
  setdvar("ui_level_player_cheatpoints", level._id_1E27);
  level._id_1E28 = _id_1E34();
  _id_1E2D();

  if(maps\_utility::_id_0A36()) {
    _id_1E29();
    return;
  }

  _id_1E2F();
  wait 0.05;
}

_id_1E29() {
  foreach(var_2, var_1 in level._id_1E26) {
    if(!isDefined(var_1._id_1E2A)) {
      var_1 _id_1E2B();
    }
  }
}

_id_1E2B() {
  self._id_1E2A = 1;
  self.item hide();
  self.item notsolid();
  common_scripts\utility::trigger_off();
  level._id_1E27++;
  setdvar("ui_level_player_cheatpoints", level._id_1E27);
  self notify("end_trigger_thread");
}

_id_1E2D() {
  foreach(var_3, var_1 in level._id_1E26) {
    var_2 = var_1.origin;
    var_1._id_1E2E = _id_1E3C(var_2);
  }
}

_id_1E2F() {
  foreach(var_2, var_1 in level._id_1E26) {
    if(var_1 _id_1E31()) {
      var_1 _id_1E2B();
      continue;
    }

    var_1 thread _id_1E35();
    var_1 thread _id_1E30();
  }
}

_id_1E30() {
  self endon("end_loop_thread");

  while(!_id_1E31()) {
    wait 0.1;

  }
  _id_1E2B();
}

_id_1E31() {
  foreach(var_1 in level.players) {
    if(!var_1 getplayerintelisfound(self._id_1E2E)) {
      return 0;
    }
  }

  return 1;
}

_id_1E32() {
  var_0 = getEntArray("intelligence_item", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].item = getent(var_0[var_1].target, "targetname");
    var_0[var_1]._id_1E33 = 0;
  }

  return var_0;
}

_id_1E34() {
  var_0 = [];

  for(var_1 = 1; var_1 <= 64; var_1++) {
    var_2 = tablelookup("maps/_intel_items.csv", 0, var_1, 4);

    if(isDefined(var_2) && var_2 != "undefined") {
      var_3 = strtok(var_2, ",");

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_3[var_4] = int(var_3[var_4]);

      }
      var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
      continue;
    }

    var_0[var_1] = undefined;
  }

  return var_0;
}

_id_1E35() {
  self endon("end_trigger_thread");

  if(self.classname == "trigger_use") {
    self sethintstring(&"SCRIPT_INTELLIGENCE_PICKUP");
    self usetriggerrequirelookat();
  }

  self waittill("trigger", var_0);
  self notify("end_loop_thread");
  _id_1E38(var_0);
  _id_1E36();
  updategamerprofileall();
  waittillframeend;
  _id_1E2B();
}

_id_1E36() {
  foreach(var_1 in level.players) {
    if(var_1 getplayerintelisfound(self._id_1E2E)) {
      continue;
    }
    var_1 setplayerintelfound(self._id_1E2E);
  }

  logstring("found intel item " + self._id_1E2E);
  maps\_endmission::_id_195E();
}

_id_1E37() {
  var_0 = self getlocalplayerprofiledata("cheatPoints");
  self setlocalplayerprofiledata("cheatPoints", var_0 + 1);
}

_id_1E38(var_0) {
  self.item hide();
  self.item notsolid();
  level thread common_scripts\utility::play_sound_in_space("intelligence_pickup", self.item.origin);
  var_1 = 3000;
  var_2 = 700;
  var_3 = var_1 + var_2 / 1000;

  foreach(var_5 in level.players) {
    if(var_0 != var_5 && var_5 getplayerintelisfound(self._id_1E2E)) {
      continue;
    }
    var_6 = var_5 maps\_hud_util::createserverclientfontstring("objective", 1.5);
    var_6.glowcolor = (0.7, 0.7, 0.3);
    var_6.glowalpha = 1;
    var_6 _id_1E3A();
    var_6.y = -60;
    var_6 setpulsefx(60, var_1, var_2);
    var_7 = 0;

    if(var_0 == var_5 && var_5 getplayerintelisfound(self._id_1E2E)) {
      var_6.label = &"SCRIPT_INTELLIGENCE_PREV_FOUND";
    } else {
      var_6.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYSIX";
      var_5 _id_1E37();
      var_7 = var_5 getlocalplayerprofiledata("cheatPoints");
      var_6 setvalue(var_7);
    }

    if(var_7 >= 22) {
      var_5 maps\_utility::_id_1E39("INFORMANT");

    }
    if(var_7 == 46) {
      var_5 maps\_utility::_id_1E39("SCOUT_LEADER");

    }
    var_6 common_scripts\utility::delaycall(var_3, ::destroy);
  }
}

_id_1E3A() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.foreground = 1;
}

_id_1E3B() {
  var_0 = [];

  for(var_1 = 1; var_1 < 65; var_1++) {
    var_2 = tablelookup("maps/_intel_items.csv", 0, var_1, 4);
    var_3 = strtok(var_2, ",");

    for(var_1 = 0; var_1 < var_3.size; var_1++) {
      var_3[var_1] = int(var_3[var_1]);

    }
    var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1])) {
      continue;
    }
    if(var_0[var_1] == "undefined") {
      continue;
    }
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      if(!isDefined(var_0[var_4])) {
        continue;
      }
      if(var_0[var_4] == "undefined") {
        continue;
      }
      if(var_1 == var_4) {
        continue;
      }
      if(var_0[var_1] == var_0[var_4]) {}
    }
  }
}

_id_1E3C(var_0) {
  for(var_1 = 1; var_1 < level._id_1E28.size + 1; var_1++) {
    if(!isDefined(level._id_1E28[var_1])) {
      continue;
    }
    if(distancesquared(var_0, level._id_1E28[var_1]) < squared(75)) {
      return var_1;
    }
  }
}