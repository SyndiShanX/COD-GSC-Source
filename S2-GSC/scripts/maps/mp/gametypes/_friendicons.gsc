/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_friendicons.gsc
******************************************************/

init() {
  level._id_33D6 = 0;
  game["headicon_allies"] = _id_0510::_id_46D1("allies");
  game["headicon_axis"] = _id_0510::_id_46D1("axis");
  level thread onplayerconnect();

  for(;;) {
    _id_A117();
    wait 5;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread _id_6B7B();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread _id_8BFA();
  }
}

_id_6B7B() {
  self endon("disconnect");

  for(;;) {
    self waittill("killed_player");
    self._id_00BA = "";
  }
}

_id_8BFA() {
  if(level._id_33D6) {
    if(self.pers["team"] == "allies") {
      self._id_00BA = game["headicon_allies"];
      self._id_00BB = "allies";
    } else {
      self._id_00BA = game["headicon_axis"];
      self._id_00BB = "axis";
    }
  }
}

_id_A117() {
  var_0 = maps\mp\_utility::getintproperty("scr_drawfriend", level._id_33D6);

  if(level._id_33D6 != var_0) {
    level._id_33D6 = var_0;
    _id_A116();
  }
}

_id_A116() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
      if(level._id_33D6) {
        if(var_2.pers["team"] == "allies") {
          var_2._id_00BA = game["headicon_allies"];
          var_2._id_00BB = "allies";
        } else {
          var_2._id_00BA = game["headicon_axis"];
          var_2._id_00BB = "axis";
        }

        continue;
      }

      var_0 = level.players;

      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];

        if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
          var_2._id_00BA = "";
        }
      }
    }
  }
}