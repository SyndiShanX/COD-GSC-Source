/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_movers.gsc
***************************************/

main() {
  if(getDvar("233") == "1") {
    return;
  }
  level.getpointinbounds = [];
  level.getpointinbounds["move_time"] = 5;
  level.getpointinbounds["accel_time"] = 0;
  level.getpointinbounds["decel_time"] = 0;
  level.getpointinbounds["wait_time"] = 0;
  level.getpointinbounds["delay_time"] = 0;
  level.getpointinbounds["usable"] = 0;
  level.getpointinbounds["hintstring"] = "activate";
  _id_820C("activate", &"MP_ACTIVATE_MOVER");
  getplayersetting("none", "");
  level.vehicle_isphysveh = [];
  level._id_8211 = [];
  waitframe();
  var_0 = [];
  var_1 = _id_8213();

  foreach(var_3 in var_1) {
    var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray(var_3, "classname"));
  }

  common_scripts\utility::_id_0FB2(var_0, ::_id_821E);
}

_id_8213() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

isturretready() {
  if(isDefined(self._id_820A)) {
    return self._id_820A;
  }

  var_0 = _id_8213();

  foreach(var_2 in var_0) {
    if(self.classname == var_2) {
      self._id_820A = 1;
      return 1;
    }
  }

  return 0;
}

_id_820C(var_0, var_1) {
  if(!isDefined(level.playersetatmosfog)) {
    level.playersetatmosfog = [];
  }

  level.playersetatmosfog[var_0] = var_1;
}

getplayersetting(var_0, var_1) {
  if(!isDefined(level.vehphys_disablecrashing)) {
    level.vehphys_disablecrashing = [];
  }

  level.vehphys_disablecrashing[var_0] = var_1;
}

_id_820B(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_8211)) {
    level._id_8211 = [];
  }

  if(!isDefined(var_3)) {
    var_3 = "default";
  }

  if(!isDefined(level._id_8211[var_0])) {
    level._id_8211[var_0] = [];
  }

  var_4 = spawnStruct();
  var_4._id_0EC4 = var_1;
  var_4._id_0ED1 = var_2;
  level._id_8211[var_0][var_3] = var_4;
}

_id_821E() {
  self._id_820A = 1;
  self._id_64E3 = 0;
  self._id_6C3E = self;
  self._id_A1F9 = [];
  self._id_5DAB = [];
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::_id_46B7(self.target, "targetname");
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    switch (var_2._id_0165) {
      case "origin":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self._id_6C3E = spawn("script_model", var_2.origin);
        self._id_6C3E.angles = var_2.angles;
        self._id_6C3E setModel("tag_origin");
        self._id_6C3E linkTo(self);
        break;
      case "scene_node":
      case "scripted_node":
        if(!isDefined(var_2.angles)) {
          var_2.angles = (0, 0, 0);
        }

        self.setviewkickscale = var_2;
        break;
      default:
        break;
    }
  }

  var_4 = [];

  if(isDefined(self.target)) {
    var_4 = getEntArray(self.target, "targetname");
  }

  foreach(var_2 in var_4) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    var_6 = strtok(var_2._id_0165, ";");

    foreach(var_8 in var_6) {
      switch (var_8) {
        case "use_trigger_link":
          var_2 enablelinkTo();
          var_2 linkTo(self);
        case "use_trigger":
          var_2 _id_822D();
          thread _id_823C(var_2);
          self._id_A1F9[self._id_A1F9.size] = var_2;
          break;
        case "link":
          var_2 linkTo(self);
          self._id_5DAB[self._id_5DAB.size] = var_2;
          break;
        default:
          break;
      }
    }
  }

  thread _id_822D();
  thread getplayerdata();
  thread playerlinkedvehicleanglesdisable();
  thread playersetstreamorigin();
  thread setmotiontrackervisible(self);
  thread playerlinkedvehicleanglesenable();
  painvisionoff();

  foreach(var_12 in self._id_A1F9) {
    nightvisionviewon(var_12, 1);
  }

  self._id_821E = 1;
  self notify("script_mover_init");
}

painvisionoff() {
  if(_id_8220()) {
    thread _id_8210();
  } else {
    thread vehicle_dospawn();
  }
}

playerlinkedvehicleanglesenable() {
  self._id_64C0 = self.origin;
  self._id_64BF = self.angles;
}

playerlinkedturretanglesdisable(var_0) {
  self notify("mover_reset");

  if(_id_8220()) {
    self scriptmodelclearanim();
  }

  self.origin = self._id_64C0;
  self.angles = self._id_64BF;
  self notify("new_path");
  waitframe();
  painvisionoff();
}

_id_823C(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger");

    if(var_0._id_480C.size > 0) {
      self notify("new_path");
      thread vehicle_dospawn(var_0);
      continue;
    }

    self notify("trigger");
  }
}

vehicledriveto(var_0) {
  if(isDefined(level.vehicle_isphysveh[var_0])) {
    self notify("new_path");
    self._id_480C = level.vehicle_isphysveh[var_0];
    thread vehicle_dospawn();
  }
}

_id_0DDE(var_0) {
  return (_angleclamp180(var_0[0]), _angleclamp180(var_0[1]), _angleclamp180(var_0[2]));
}

_id_822D() {
  if(isDefined(self._id_6E88) && self._id_6E88) {
    return;
  }
  self._id_6E88 = 1;
  self._id_480C = [];
  self._id_64C5 = [];
  var_0 = [];
  var_1 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::_id_46B7(self.target, "targetname");
    var_1 = getEntArray(self.target, "targetname");
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_0165)) {
      var_3._id_0165 = "goal";
    }

    switch (var_3._id_0165) {
      case "ignore":
        if(isDefined(var_3.target)) {
          var_4 = common_scripts\utility::_id_46B7(var_3.target, "targetname");

          foreach(var_6 in var_4) {
            var_0[var_0.size] = var_6;
          }
        }

        break;
      case "goal":
        var_3 getplayerdata();
        var_3 _id_822D();
        self._id_480C[self._id_480C.size] = var_3;

        if(isDefined(var_3._id_6E5C["name"])) {
          if(!isDefined(level.vehicle_isphysveh[var_3._id_6E5C["name"]])) {
            level.vehicle_isphysveh[var_3._id_6E5C["name"]] = [];
          }

          var_8 = level.vehicle_isphysveh[var_3._id_6E5C["name"]].size;
          level.vehicle_isphysveh[var_3._id_6E5C["name"]][var_8] = var_3;
        }

        break;
      default:
        break;
    }
  }

  foreach(var_10 in var_1) {
    if(var_10 isturretready()) {
      self._id_64C5[self._id_64C5.size] = var_10;
    }

    thread vehphys_enablecrashing(var_10);
  }
}

vehphys_enablecrashing(var_0) {
  if(!isDefined(var_0._id_0165)) {
    return;
  }
  if(var_0 isturretready() && !isDefined(var_0._id_821E)) {
    var_0 waittill("script_mover_init");
  }

  var_1 = strtok(var_0._id_0165, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_");

    if(var_4.size < 3 || var_4[1] != "on") {
      continue;
    }
    var_5 = _tolower(var_4[0]);
    var_6 = var_4[2];

    for(var_7 = 3; var_7 < var_4.size; var_7++) {
      var_6 = var_6 + "_" + var_4[var_7];
    }

    switch (var_5) {
      case "connectpaths":
        thread setweaponhudiconoverride(var_0, var_6, ::worldpointinreticle_rect, ::_id_8219);
        break;
      case "disconnectpaths":
        thread setweaponhudiconoverride(var_0, var_6, ::_id_8219, ::worldpointinreticle_rect);
        break;
      case "solid":
        var_0 notsolid();
        thread setweaponhudiconoverride(var_0, var_6, ::painvisionon, ::vehphys_launch);
        break;
      case "notsolid":
        thread setweaponhudiconoverride(var_0, var_6, ::vehphys_launch, ::painvisionon);
        break;
      case "delete":
        thread setweaponhudiconoverride(var_0, var_6, ::_id_8218);
        break;
      case "hide":
        thread setweaponhudiconoverride(var_0, var_6, ::_id_821C, ::nightvisionviewoff);
        break;
      case "show":
        var_0 hide();
        thread setweaponhudiconoverride(var_0, var_6, ::nightvisionviewoff, ::_id_821C);
        break;
      case "triggerhide":
        thread setweaponhudiconoverride(var_0, var_6, ::_id_8239, ::_id_823A);
        break;
      case "triggershow":
        var_0 common_scripts\utility::_id_9D9F();
        thread setweaponhudiconoverride(var_0, var_6, ::_id_823A, ::_id_8239);
        break;
      case "trigger":
        thread setweaponhudiconoverride(var_0, var_6, ::getplayerintelisfound, ::playerlinkedturretanglesdisable);
        break;
      default:
        break;
    }
  }
}

_id_8239(var_0) {
  self dontinterpolate();
  common_scripts\utility::_id_9D9F();
}

_id_823A(var_0) {
  self dontinterpolate();
  common_scripts\utility::_id_9DA3();
}

vehphys_crash(var_0, var_1) {
  var_0 notify(var_1);
}

vehicleturretcontroloff(var_0, var_1) {
  level notify(var_1);
}

worldpointinreticle_rect(var_0) {
  self connectpaths();
}

_id_8219(var_0) {
  self disconnectPaths(var_0);
}

painvisionon(var_0) {
  self solid();
}

vehphys_launch(var_0) {
  self notsolid();
}

_id_8218(var_0) {
  self delete();
}

_id_821C(var_0) {
  self hide();
}

nightvisionviewoff(var_0) {
  self show();
}

getplayerintelisfound(var_0) {
  self notify("trigger");
}

setweaponhudiconoverride(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill(var_1, var_4);
    var_0[[var_2]](var_4);

    if(isDefined(var_3) && isDefined(var_4)) {
      var_4 _id_823D(var_0, var_3);
      continue;
    }

    break;
  }
}

_id_823B() {
  var_0 = [];

  if(_id_8221()) {
    var_0[var_0.size] = self;
  }

  foreach(var_2 in self._id_5DAB) {
    if(var_2 _id_8221()) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size == 0) {
    return;
  }
  for(;;) {
    foreach(var_5 in var_0) {
      var_5 _id_8219();
    }

    self waittill("move_start");

    foreach(var_5 in var_0) {
      var_5 worldpointinreticle_rect();
    }

    self waittill("move_end");
  }
}

_id_8210() {
  childthread _id_823B();
  var_0 = self._id_6E5C["animation"];

  if(isDefined(level._id_8211[var_0]["idle"])) {
    playerlinkedturretanglesenable(level._id_8211[var_0]["idle"], 0);
  }

  _id_8217();
  self notify("move_start");
  self notify("start", self);
  var_1 = level._id_8211[var_0]["default"];

  if(isDefined(var_1)) {
    playerlinkedturretanglesenable(var_1, 1);
    self waittill("end");
  }

  self notify("move_end");
}

playerlinkedturretanglesenable(var_0, var_1) {
  self notify("play_animation");

  if(var_1) {
    thread _id_821B();
  }

  if(isDefined(self.setviewkickscale)) {
    self scriptmodelplayanimdeltamotionfrompos(var_0._id_0EC4, self.setviewkickscale.origin, self.setviewkickscale.angles, "script_mover_anim");
  } else {
    self scriptmodelplayanimdeltamotion(var_0._id_0EC4, "script_mover_anim");
  }
}

_id_821B() {
  self endon("play_animation");
  self endon("mover_reset");

  for(;;) {
    self waittill("script_mover_anim", var_0);
    self notify(var_0, self);
  }
}

_id_8217() {
  if(isDefined(self._id_6E5C["delay_till"])) {
    level waittill(self._id_6E5C["delay_till"]);
  }

  if(isDefined(self._id_6E5C["delay_till_trigger"]) && self._id_6E5C["delay_till_trigger"]) {
    self waittill("trigger");
  }

  if(self._id_6E5C["delay_time"] > 0) {
    wait(self._id_6E5C["delay_time"]);
  }
}

vehicle_dospawn(var_0) {
  self endon("death");
  self endon("new_path");
  childthread _id_823B();

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  while(var_0._id_480C.size != 0) {
    var_1 = common_scripts\utility::random(var_0._id_480C);
    var_2 = self;
    var_2 setmotiontrackervisible(var_1);
    var_2 _id_8217();
    var_3 = var_2._id_6E5C["move_time"];
    var_4 = var_2._id_6E5C["accel_time"];
    var_5 = var_2._id_6E5C["decel_time"];
    var_6 = 0;
    var_7 = 0;
    var_8 = _transformmove(var_1.origin, var_1.angles, self._id_6C3E.origin, self._id_6C3E.angles, self.origin, self.angles);

    if(var_2.origin != var_1.origin) {
      if(isDefined(var_2._id_6E5C["move_speed"])) {
        var_9 = distance(var_2.origin, var_1.origin);
        var_3 = var_9 / var_2._id_6E5C["move_speed"];
      }

      if(isDefined(var_2._id_6E5C["accel_frac"])) {
        var_4 = var_2._id_6E5C["accel_frac"] * var_3;
      }

      if(isDefined(var_2._id_6E5C["decel_frac"])) {
        var_5 = var_2._id_6E5C["decel_frac"] * var_3;
      }

      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.origin = var_8["origin"];
      } else
        var_2 moveTo(var_8["origin"], var_3, var_4, var_5);

      var_6 = 1;
    }

    if(_id_0DDE(var_8["angles"]) != _id_0DDE(var_2.angles)) {
      if(var_3 <= 0) {
        var_2 dontinterpolate();
        var_2.angles = var_8["angles"];
      } else
        var_2 rotateTo(var_8["angles"], var_3, var_4, var_5);

      var_7 = 1;
    }

    foreach(var_11 in var_2._id_64C5) {
      var_11 notify("trigger");
      _id_823D(var_11, ::playerlinkedturretanglesdisable);
    }

    var_2 notify("move_start");
    var_0 notify("depart", var_2);

    if(isDefined(var_2._id_6E5C["name"])) {
      var_13 = "mover_depart_" + var_2._id_6E5C["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    var_2 setlocalplayerprofiledata(0);

    if(var_3 <= 0) {} else if(var_6) {
      var_2 waittill("movedone");
    } else if(var_7) {
      var_2 waittill("rotatedone");
    } else {
      wait(var_3);
    }

    var_2 notify("move_end");
    var_1 notify("arrive", var_2);

    if(isDefined(var_2._id_6E5C["name"])) {
      var_13 = "mover_arrive_" + var_2._id_6E5C["name"];
      var_2 notify(var_13);
      level notify(var_13, var_2);
    }

    if(isDefined(var_2._id_6E5C["solid"])) {
      if(var_2._id_6E5C["solid"]) {
        var_2 solid();
      } else {
        var_2 notsolid();
      }
    }

    foreach(var_11 in var_1._id_64C5) {
      var_11 notify("trigger");
      _id_823D(var_11, ::playerlinkedturretanglesdisable);
    }

    if(isDefined(var_2._id_6E5C["wait_till"])) {
      level waittill(var_2._id_6E5C["wait_till"]);
    }

    if(var_2._id_6E5C["wait_time"] > 0) {
      wait(var_2._id_6E5C["wait_time"]);
    }

    var_2 setlocalplayerprofiledata(1);
    var_0 = var_1;
  }
}

_id_823D(var_0, var_1) {
  thread setweaponhudiconoverride(var_0, "mover_reset", var_1);
}

getplayerdata() {
  self._id_6E5C = [];

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.angles = _id_0DDE(self.angles);
  vehphys_setspeed(self.setlookatent);
}

vehphys_setspeed(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_1 = strtok(var_0, ";");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "=");

    if(var_4.size != 2) {
      continue;
    }
    if(var_4[1] == "undefined" || var_4[1] == "default") {
      self._id_6E5C[var_4[0]] = "<undefined>";
      continue;
    }

    switch (var_4[0]) {
      case "decel_frac":
      case "accel_frac":
      case "move_speed":
      case "delay_time":
      case "wait_time":
      case "decel_time":
      case "accel_time":
      case "move_time":
        self._id_6E5C[var_4[0]] = vehphys_setconveyorbelt(var_4[1]);
        break;
      case "wait_till":
      case "delay_till":
      case "hintstring":
      case "animation":
      case "name":
        self._id_6E5C[var_4[0]] = var_4[1];
        break;
      case "delay_till_trigger":
      case "usable":
      case "solid":
        self._id_6E5C[var_4[0]] = int(var_4[1]);
        break;
      case "script_params":
        var_5 = var_4[1];
        var_6 = level.vehphys_disablecrashing[var_5];

        if(isDefined(var_6)) {
          vehphys_setspeed(var_6);
        }

        break;
      default:
        break;
    }
  }
}

vehphys_setconveyorbelt(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, ",");

  if(var_2.size == 1) {
    var_1 = _float(var_2[0]);
  } else if(var_2.size == 2) {
    var_3 = _float(var_2[0]);
    var_4 = _float(var_2[1]);

    if(var_3 >= var_4) {
      var_1 = var_3;
    } else {
      var_1 = _randomfloatrange(var_3, var_4);
    }
  }

  return var_1;
}

setmotiontrackervisible(var_0) {
  foreach(var_3, var_2 in var_0._id_6E5C) {
    playerclearstreamorigin(var_3, var_2);
  }

  playersetstreamorigin();
}

playerclearstreamorigin(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "usable" && isDefined(var_1)) {
    nightvisionviewon(self, var_1);
  }

  if(isDefined(var_1) && _isstring(var_1) && var_1 == "<undefined>") {
    var_1 = undefined;
  }

  self._id_6E5C[var_0] = var_1;
}

setlocalplayerprofiledata(var_0) {
  if(self._id_6E5C["usable"]) {
    nightvisionviewon(self, var_0);
  }

  foreach(var_2 in self._id_A1F9) {
    nightvisionviewon(var_2, var_0);
  }
}

nightvisionviewon(var_0, var_1) {
  if(var_1) {
    var_0 makeusable();
    var_0 setCursorHint("HINT_ACTIVATE");
    var_0 setHintString(level.playersetatmosfog[self._id_6E5C["hintstring"]]);
  } else
    var_0 makeunusable();
}

playerlinkedvehicleanglesdisable() {
  self._id_6E5D = [];

  foreach(var_2, var_1 in self._id_6E5C) {
    self._id_6E5D[var_2] = var_1;
  }
}

playersetstreamorigin() {
  if(isDefined(self._id_6E5D)) {
    foreach(var_2, var_1 in self._id_6E5D) {
      if(!isDefined(self._id_6E5C[var_2])) {
        playerclearstreamorigin(var_2, var_1);
      }
    }
  }

  foreach(var_2, var_1 in level.getpointinbounds) {
    if(!isDefined(self._id_6E5C[var_2])) {
      playerclearstreamorigin(var_2, var_1);
    }
  }
}

_id_8221() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

_id_8220() {
  return isDefined(self._id_6E5C["animation"]);
}

init() {
  level thread worldpointinreticle_circle();
  level thread getlocalplayerprofiledata();
}

worldpointinreticle_circle() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_7388();
  }
}

getlocalplayerprofiledata() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    var_0 thread _id_7388();
  }
}

_id_7388() {
  self endon("disconnect");

  if(_isagent(self)) {
    self endon("death");
  }

  self._id_A043 = 0;

  for(;;) {
    self waittill("unresolved_collision", var_0);

    if(_isagent(self) && isDefined(self._id_0EAE)) {
      if(self scragentgetphysicsmode() == "noclip") {
        continue;
      }
    }

    self._id_A043++;
    thread _id_23D3();
    var_1 = 3;

    if(isDefined(var_0) && isDefined(var_0._id_A049)) {
      var_1 = var_0._id_A049;
    }

    if(self._id_A043 >= var_1) {
      if(isDefined(var_0)) {
        if(isDefined(var_0._id_A045)) {
          var_0[[var_0._id_A045]](self);
        } else if(isDefined(var_0._id_A046) && var_0._id_A046) {
          var_0 _id_A04A(self);
        } else {
          var_0 _id_A047(self);
        }
      } else
        _id_A047(self);

      self._id_A043 = 0;
    }
  }
}

_id_23D3() {
  self endon("unresolved_collision");
  waitframe();

  if(isDefined(self)) {
    self._id_A043 = 0;
  }
}

_id_A04A(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_0117)) {
    var_0 _id_64C1();
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_1._id_0117.team) && var_1._id_0117.team != var_0.team) {
      var_2 = 1;
    }
  } else if(var_0 != var_1._id_0117)
    var_2 = 1;

  if(!var_2) {
    var_0 _id_64C1();
    return;
  }

  var_3 = 1000;

  if(isDefined(var_1._id_A044)) {
    var_3 = var_1._id_A044;
  }

  var_0 dodamage(var_3, var_1.origin, var_1._id_0117, var_1, "MOD_CRUSH");
}

_id_A047(var_0, var_1) {
  var_2 = self._id_A048;
  var_3 = undefined;

  if(maps\mp\_utility::_id_585F() && common_scripts\utility::_id_562E(level.use_zombie_unresolved_collision)) {
    if(!isDefined(var_2)) {
      var_2 = [];
    }

    var_4 = _func_2E1(var_0.origin);

    if(isDefined(var_4)) {
      var_3 = spawnStruct();
      var_3.origin = _func_2E1(var_0.origin);
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_3);
    }

    var_2 = common_scripts\utility::_id_0F73(var_2, _getnodesinradius(var_0.origin, 300, 0, 200, "End 3D"));

    if(isDefined(level.failsafe_collision_nodes) && _isarray(level.failsafe_collision_nodes)) {
      var_2 = common_scripts\utility::_id_0F73(var_2, level.failsafe_collision_nodes);
    }
  }

  if(isDefined(var_2)) {
    var_2 = _sortbydistance(var_2, var_0.origin);
  } else {
    var_2 = _getnodesinradius(var_0.origin, 300, 0, 200);
    var_2 = _sortbydistance(var_2, var_0.origin);
  }

  var_5 = (0, 0, -100);
  var_0 cancelmantle();
  var_0 dontinterpolate();
  var_0 setOrigin(var_0.origin + var_5);

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];
    var_8 = var_7.origin;

    if(!_canspawn(var_8)) {
      continue;
    }
    if(_positionwouldtelefrag(var_8)) {
      continue;
    }
    if(var_0 _meth_803D()) {
      var_0 _id_028D::forcedismountweapon();
    }

    if(var_0 getstance() == "prone") {
      var_0 setstance("crouch");
    }

    var_0 setOrigin(var_8);
    return;
  }

  if(level._id_015D == "mp_hub_allies_slim" && var_2.size == 0) {
    if(var_0 _meth_803D()) {
      var_0 _id_028D::forcedismountweapon();
    }

    return;
  }

  var_0 setOrigin(var_0.origin - var_5);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_0 _id_64C1();
  }
}

_id_A04B(var_0) {}

_id_64C1() {
  maps\mp\_utility::_suicide();
}

_id_7305(var_0) {
  self endon("death");
  self endon("stop_player_pushed_kill");

  for(;;) {
    self waittill("player_pushed", var_1, var_2);

    if(isPlayer(var_1) || _isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0) {
        _id_A04A(var_1);
      }
    }
  }
}

_id_93E1() {
  self notify("stop_player_pushed_kill");
}

_id_67F9() {
  var_0 = self getlinkedchildren(0);

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_66F0) && var_2._id_66F0) {
      continue;
    }
    var_2 unlink();
    var_2 notify("invalid_parent", self);
  }
}

_id_774B(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_66EF) && var_1._id_66EF) {
    return;
  }
  if(isDefined(var_0._id_720F)) {
    playFX(common_scripts\utility::_id_44F5("airdrop_crate_destroy"), self.origin);
  }

  if(isDefined(var_0._id_2AA8)) {
    self thread[[var_0._id_2AA8]](var_0);
  } else {
    self delete();
  }
}

_id_4A26(var_0) {
  for(;;) {
    self waittill("touching_platform", var_1);

    if(isDefined(var_0._id_9AC2) && !self[[var_0._id_9AC2]](var_1)) {
      continue;
    }
    if(isDefined(var_0._id_A270) && var_0._id_A270) {
      if(!self istouching(var_1)) {
        waitframe();
        continue;
      }
    }

    thread _id_774B(var_0, var_1);
    break;
  }
}

_id_4A25(var_0) {
  self waittill("invalid_parent", var_1);

  if(isDefined(var_0._id_54FA)) {
    self thread[[var_0._id_54FA]](var_0);
  } else {
    thread _id_774B(var_0, var_1);
  }
}

_id_4A27(var_0) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(isDefined(var_0._id_36DE)) {
    self endon(var_0._id_36DE);
  }

  if(isDefined(var_0._id_5DB9)) {
    self linkTo(var_0._id_5DB9);
  }

  childthread _id_4A26(var_0);
  childthread _id_4A25(var_0);
}

_id_93CE() {
  self notify("stop_handling_moving_platforms");
}

_id_64E7(var_0) {}