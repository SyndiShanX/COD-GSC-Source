/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1320.gsc
**************************************/

_id_52F3() {
  level._id_9854["allies"] = 0;
  level._id_9854["axis"] = 0;
  level._id_9850["allies"] = 0;
  level._id_9850["axis"] = 0;
  level._id_3CE0 = undefined;
  level._id_2694 = undefined;
}

_id_A0E0() {
  foreach(var_1 in level.players) {
    if(level.teambased) {
      var_1 _id_A150();
      continue;
    }

    var_1 _id_A14F();
  }
}

_id_A150() {
  var_0 = 0;
  var_1 = "allies";

  if(self.team == "axis")
    var_1 = "axis";

  if(level._id_9854[var_1])
    var_0 = -2;
  else if(level._id_9850[var_1])
    var_0 = -1;
  else if(level._id_9854[maps\mp\_utility::getotherteam(var_1)])
    var_0 = 2;
  else if(level._id_9850[maps\mp\_utility::getotherteam(var_1)])
    var_0 = 1;

  self setclientomnvar("ui_minimap_antiair_state", var_0);
}

_id_A14F() {
  var_0 = 0;

  if(isDefined(level._id_3CE0)) {
    var_0 = 2;

    if(level._id_3CE0 != self)
      var_0 = var_0 * -1;
  } else if(isDefined(level._id_2694)) {
    var_0 = 1;

    if(level._id_2694 != self)
      var_0 = var_0 * -1;
  }

  self setclientomnvar("ui_minimap_antiair_state", var_0);
}