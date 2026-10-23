/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_zipline.gsc
****************************************/

init() {
  var_0 = [];
  var_1 = getEntArray("zipline", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = _id_04D1::createuseobject("neutral", var_1[var_2], var_0, (0, 0, 0));
    var_3 _id_04D1::_id_0C30("any");
    var_3 _id_04D1::setusetime(0.25);
    var_3 _id_04D1::setusetext(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::setusehinttext(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::setvisibleteam("any");
    var_3.onbeginuse = ::onbeginuse;
    var_3.onuse = ::onuse;
    var_4 = [];
    var_5 = _getEnt(var_1[var_2].target, "targetname");

    if(!isDefined(var_5)) {}

    while(isDefined(var_5)) {
      var_4[var_4.size] = var_5;

      if(isDefined(var_5.target)) {
        var_5 = _getEnt(var_5.target, "targetname");
        continue;
      }

      break;
    }

    var_3.targets = var_4;
  }

  precachemodel("tag_player");
  init_elevator();
}

onbeginuse(var_0) {
  var_0 playSound("scrambler_pullout_lift_plr");
}

onuse(var_0) {
  var_0 thread zip(self);
}

zip(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("zipline_drop");
  level endon("game_ended");
  var_1 = spawn("script_origin", var_0.trigger.origin);
  var_1.origin = var_0.trigger.origin;
  var_1.angles = self.angles;
  var_1 setModel("tag_player");
  self playerlinktodelta(var_1, "tag_player", 1, 180, 180, 180, 180);
  thread watchdeath(var_1);
  thread watchdrop(var_1);
  var_2 = var_0.targets;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = distance(var_1.origin, var_2[var_3].origin) / 600;
    var_5 = 0.0;

    if(var_3 == 0) {
      var_5 = var_4 * 0.2;
    }

    var_1 moveTo(var_2[var_3].origin, var_4, var_5);

    if(var_1.angles != var_2[var_3].angles) {
      var_1 rotateTo(var_2[var_3].angles, var_4 * 0.8);
    }

    wait(var_4);
  }

  self notify("destination");
  self unlink();
  var_1 delete();
}

watchdrop(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("destination");
  level endon("game_ended");
  self notifyonplayercommand("zipline_drop", "+gostand");
  self waittill("zipline_drop");
  self unlink();
  var_0 delete();
}

watchdeath(var_0) {
  self endon("disconnect");
  self endon("destination");
  self endon("zipline_drop");
  level endon("game_ended");
  self waittill("death");
  self unlink();
  var_0 delete();
}

init_elevator() {
  var_0 = [];
  var_1 = getEntArray("elevator_button", "targetname");
  level.elevator = spawnStruct();
  level.elevator.location = "floor1";
  level.elevator.states = [];
  level.elevator.states["elevator"] = "closed";
  level.elevator.destinations = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = _id_04D1::createuseobject("neutral", var_1[var_2], var_0, (0, 0, 0));
    var_3 _id_04D1::_id_0C30("any");
    var_3 _id_04D1::setusetime(0.25);
    var_3 _id_04D1::setusetext(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::setusehinttext(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::setvisibleteam("any");
    var_3.onbeginuse = ::onbeginuse_elevator;
    var_3.onuse = ::onuse_elevator;
    var_3.location = var_1[var_2].shootblank;
    level.elevator.states[var_1[var_2].shootblank] = "closed";

    if(isDefined(var_1[var_2].target)) {
      var_4 = common_scripts\utility::getstruct(var_1[var_2].target, "targetname");

      if(isDefined(var_4)) {
        level.elevator.destinations[var_1[var_2].shootblank] = var_4;
      }
    }
  }
}

onbeginuse_elevator(var_0) {}

onuse_elevator(var_0) {
  switch (self.location) {
    case "floor1":
      if(level.elevator.states["floor1"] == "closed") {
        if(level.elevator.location == "floor1") {
          if(level.elevator.states["elevator"] == "closed") {
            level thread open("floor1");
            level thread open("elevator");
          }
        } else if(level.elevator.location == "floor2") {
          if(level.elevator.states["elevator"] == "opened") {
            level notify("stop_autoClose");
            level thread close("floor2");
            level close("elevator");
          }

          if(level.elevator.states["elevator"] == "closed") {
            level move();
            level thread open("floor1");
            level thread open("elevator");
          }
        }
      }

      break;
    case "floor2":
      if(level.elevator.states["floor2"] == "closed") {
        if(level.elevator.location == "floor2") {
          if(level.elevator.states["elevator"] == "closed") {
            level thread open("floor2");
            level thread open("elevator");
          }
        } else if(level.elevator.location == "floor1") {
          if(level.elevator.states["elevator"] == "opened") {
            level notify("stop_autoClose");
            level thread close("floor1");
            level close("elevator");
          }

          if(level.elevator.states["elevator"] == "closed") {
            level move();
            level thread open("floor2");
            level thread open("elevator");
          }
        }
      }

      break;
    case "elevator":
      if(level.elevator.states["elevator"] == "opened") {
        level notify("stop_autoClose");
        level thread close(level.elevator.location);
        level close("elevator");
      }

      if(level.elevator.states["elevator"] == "closed") {
        level move();
        level thread open(level.elevator.location);
        level thread open("elevator");
      }

      break;
  }
}

open(var_0) {
  level.elevator.states[var_0] = "opening";
  var_1 = _getEnt("e_door_" + var_0 + "_left", "targetname");
  var_2 = _getEnt("e_door_" + var_0 + "_right", "targetname");

  if(isDefined(var_1._id_0165) && var_1._id_0165 == "fahrenheit") {
    var_1 moveTo(var_1.origin - anglesToForward(var_1.angles) * 35, 2);
    var_2 moveTo(var_2.origin + anglesToForward(var_2.angles) * 35, 2);
    var_1 playSound("elev_door_open");
  } else {
    var_1 moveTo(var_1.origin - anglestoright(var_1.angles) * 35, 2);
    var_2 moveTo(var_2.origin + anglestoright(var_2.angles) * 35, 2);
  }

  wait 2;
  level.elevator.states[var_0] = "opened";

  if(var_0 == "elevator") {
    level thread autoclose();
  }
}

close(var_0) {
  level.elevator.states[var_0] = "closing";
  var_1 = _getEnt("e_door_" + var_0 + "_left", "targetname");
  var_2 = _getEnt("e_door_" + var_0 + "_right", "targetname");

  if(isDefined(var_1._id_0165) && var_1._id_0165 == "fahrenheit") {
    var_1 moveTo(var_1.origin + anglesToForward(var_1.angles) * 35, 2);
    var_2 moveTo(var_2.origin - anglesToForward(var_2.angles) * 35, 2);
    var_1 playSound("elev_door_close");
  } else {
    var_1 moveTo(var_1.origin + anglestoright(var_1.angles) * 35, 2);
    var_2 moveTo(var_2.origin - anglestoright(var_2.angles) * 35, 2);
  }

  wait 2;
  level.elevator.states[var_0] = "closed";
}

autoclose() {
  level endon("stop_autoClose");
  wait 10;
  level thread close(level.elevator.location);
  level thread close("elevator");
}

move() {
  level.elevator.states["elevator"] = "moving";
  var_0 = _getEnt("e_door_elevator_left", "targetname");
  var_1 = _getEnt("e_door_elevator_right", "targetname");
  var_2 = _getEnt("elevator", "targetname");

  if(level.elevator.location == "floor1") {
    level.elevator.location = "floor2";
    var_3 = var_0.origin[2] - level.elevator.destinations["floor1"].origin[2];
    var_0 moveTo((var_0.origin[0], var_0.origin[1], level.elevator.destinations["floor2"].origin[2] + var_3), 5);
    var_3 = var_1.origin[2] - level.elevator.destinations["floor1"].origin[2];
    var_1 moveTo((var_1.origin[0], var_1.origin[1], level.elevator.destinations["floor2"].origin[2] + var_3), 5);
    var_2 moveTo(level.elevator.destinations["floor2"].origin, 5);
  } else {
    level.elevator.location = "floor1";
    var_3 = var_0.origin[2] - level.elevator.destinations["floor2"].origin[2];
    var_0 moveTo((var_0.origin[0], var_0.origin[1], level.elevator.destinations["floor1"].origin[2] + var_3), 5);
    var_3 = var_1.origin[2] - level.elevator.destinations["floor2"].origin[2];
    var_1 moveTo((var_1.origin[0], var_1.origin[1], level.elevator.destinations["floor1"].origin[2] + var_3), 5);
    var_2 moveTo(level.elevator.destinations["floor1"].origin, 5);
  }

  wait 5;
  var_2 playSound("elev_bell_ding");
  level.elevator.states["elevator"] = "closed";
}