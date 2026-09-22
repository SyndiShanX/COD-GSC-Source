/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_zipline.gsc
****************************************/

init() {
  var_0 = [];
  var_1 = getEntArray("zipline", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = _id_04D1::_id_2837("neutral", var_1[var_2], var_0, (0, 0, 0));
    var_3 _id_04D1::_id_0C30("any");
    var_3 _id_04D1::_id_8A5A(0.25);
    var_3 _id_04D1::_id_8A59(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::_id_8A57(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::_id_8A60("any");
    var_3._id_6ABC = ::_id_6ABC;
    var_3._id_6BBF = ::_id_6BBF;
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

    var_3._id_9835 = var_4;
  }

  precachemodel("tag_player");
  _id_51C7();
}

_id_6ABC(var_0) {
  var_0 playSound("scrambler_pullout_lift_plr");
}

_id_6BBF(var_0) {
  var_0 thread _id_AAF8(self);
}

_id_AAF8(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("zipline_drop");
  level endon("game_ended");
  var_1 = spawn("script_origin", var_0._id_9D65.origin);
  var_1.origin = var_0._id_9D65.origin;
  var_1.angles = self.angles;
  var_1 setModel("tag_player");
  self playerlinktodelta(var_1, "tag_player", 1, 180, 180, 180, 180);
  thread _id_A8F9(var_1);
  thread _id_A8FF(var_1);
  var_2 = var_0._id_9835;

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

_id_A8FF(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("destination");
  level endon("game_ended");
  self notifyonplayercommand("zipline_drop", "+gostand");
  self waittill("zipline_drop");
  self unlink();
  var_0 delete();
}

_id_A8F9(var_0) {
  self endon("disconnect");
  self endon("destination");
  self endon("zipline_drop");
  level endon("game_ended");
  self waittill("death");
  self unlink();
  var_0 delete();
}

_id_51C7() {
  var_0 = [];
  var_1 = getEntArray("elevator_button", "targetname");
  level._id_35B3 = spawnStruct();
  level._id_35B3.location = "floor1";
  level._id_35B3._id_932D = [];
  level._id_35B3._id_932D["elevator"] = "closed";
  level._id_35B3._id_2DAC = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = _id_04D1::_id_2837("neutral", var_1[var_2], var_0, (0, 0, 0));
    var_3 _id_04D1::_id_0C30("any");
    var_3 _id_04D1::_id_8A5A(0.25);
    var_3 _id_04D1::_id_8A59(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::_id_8A57(&"MP_ZIPLINE_USE");
    var_3 _id_04D1::_id_8A60("any");
    var_3._id_6ABC = ::_id_6ABD;
    var_3._id_6BBF = ::_id_6BC0;
    var_3.location = var_1[var_2].shootblank;
    level._id_35B3._id_932D[var_1[var_2].shootblank] = "closed";

    if(isDefined(var_1[var_2].target)) {
      var_4 = common_scripts\utility::_id_46B5(var_1[var_2].target, "targetname");

      if(isDefined(var_4)) {
        level._id_35B3._id_2DAC[var_1[var_2].shootblank] = var_4;
      }
    }
  }
}

_id_6ABD(var_0) {}

_id_6BC0(var_0) {
  switch (self.location) {
    case "floor1":
      if(level._id_35B3._id_932D["floor1"] == "closed") {
        if(level._id_35B3.location == "floor1") {
          if(level._id_35B3._id_932D["elevator"] == "closed") {
            level thread _id_6BE1("floor1");
            level thread _id_6BE1("elevator");
          }
        } else if(level._id_35B3.location == "floor2") {
          if(level._id_35B3._id_932D["elevator"] == "opened") {
            level notify("stop_autoClose");
            level thread _id_242F("floor2");
            level _id_242F("elevator");
          }

          if(level._id_35B3._id_932D["elevator"] == "closed") {
            level _id_646F();
            level thread _id_6BE1("floor1");
            level thread _id_6BE1("elevator");
          }
        }
      }

      break;
    case "floor2":
      if(level._id_35B3._id_932D["floor2"] == "closed") {
        if(level._id_35B3.location == "floor2") {
          if(level._id_35B3._id_932D["elevator"] == "closed") {
            level thread _id_6BE1("floor2");
            level thread _id_6BE1("elevator");
          }
        } else if(level._id_35B3.location == "floor1") {
          if(level._id_35B3._id_932D["elevator"] == "opened") {
            level notify("stop_autoClose");
            level thread _id_242F("floor1");
            level _id_242F("elevator");
          }

          if(level._id_35B3._id_932D["elevator"] == "closed") {
            level _id_646F();
            level thread _id_6BE1("floor2");
            level thread _id_6BE1("elevator");
          }
        }
      }

      break;
    case "elevator":
      if(level._id_35B3._id_932D["elevator"] == "opened") {
        level notify("stop_autoClose");
        level thread _id_242F(level._id_35B3.location);
        level _id_242F("elevator");
      }

      if(level._id_35B3._id_932D["elevator"] == "closed") {
        level _id_646F();
        level thread _id_6BE1(level._id_35B3.location);
        level thread _id_6BE1("elevator");
      }

      break;
  }
}

_id_6BE1(var_0) {
  level._id_35B3._id_932D[var_0] = "opening";
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
  level._id_35B3._id_932D[var_0] = "opened";

  if(var_0 == "elevator") {
    level thread _id_1386();
  }
}

_id_242F(var_0) {
  level._id_35B3._id_932D[var_0] = "closing";
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
  level._id_35B3._id_932D[var_0] = "closed";
}

_id_1386() {
  level endon("stop_autoClose");
  wait 10;
  level thread _id_242F(level._id_35B3.location);
  level thread _id_242F("elevator");
}

_id_646F() {
  level._id_35B3._id_932D["elevator"] = "moving";
  var_0 = _getEnt("e_door_elevator_left", "targetname");
  var_1 = _getEnt("e_door_elevator_right", "targetname");
  var_2 = _getEnt("elevator", "targetname");

  if(level._id_35B3.location == "floor1") {
    level._id_35B3.location = "floor2";
    var_3 = var_0.origin[2] - level._id_35B3._id_2DAC["floor1"].origin[2];
    var_0 moveTo((var_0.origin[0], var_0.origin[1], level._id_35B3._id_2DAC["floor2"].origin[2] + var_3), 5);
    var_3 = var_1.origin[2] - level._id_35B3._id_2DAC["floor1"].origin[2];
    var_1 moveTo((var_1.origin[0], var_1.origin[1], level._id_35B3._id_2DAC["floor2"].origin[2] + var_3), 5);
    var_2 moveTo(level._id_35B3._id_2DAC["floor2"].origin, 5);
  } else {
    level._id_35B3.location = "floor1";
    var_3 = var_0.origin[2] - level._id_35B3._id_2DAC["floor2"].origin[2];
    var_0 moveTo((var_0.origin[0], var_0.origin[1], level._id_35B3._id_2DAC["floor1"].origin[2] + var_3), 5);
    var_3 = var_1.origin[2] - level._id_35B3._id_2DAC["floor2"].origin[2];
    var_1 moveTo((var_1.origin[0], var_1.origin[1], level._id_35B3._id_2DAC["floor1"].origin[2] + var_3), 5);
    var_2 moveTo(level._id_35B3._id_2DAC["floor1"].origin, 5);
  }

  wait 5;
  var_2 playSound("elev_bell_ding");
  level._id_35B3._id_932D["elevator"] = "closed";
}