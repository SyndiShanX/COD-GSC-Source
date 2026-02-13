/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2003.gsc
*************************************************/

init() {
  level._id_4F41 = 0;
  game["headicon_allies"] = ::scripts\mp\utility\teams::_id_6DCF("allies");
  game["headicon_axis"] = ::scripts\mp\utility\teams::_id_6DCF("axis");
  _func_01B2("waypoint_revive");
  level thread onplayerconnect();
  _id_0AA3::_id_C28D(::onplayerspawned);

  for(;;) {
    _id_FC6F();
    wait 5;
  }
}

onplayerconnect() {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_AB70();
  }
}

onplayerspawned() {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  thread _id_DCAB();
}

_id_AB70() {
  self endon("disconnect");

  for(;;) {
    self waittill("killed_player");
    self._id_75E9 = "";
  }
}

_id_DCAB() {
  if(level._id_4F41) {
    if(self.pers["team"] == "allies") {
      self._id_75E9 = game["headicon_allies"];
      self._id_75F7 = "allies";
    } else {
      self._id_75E9 = game["headicon_axis"];
      self._id_75F7 = "axis";
    }
  }
}

_id_FC6F() {
  var_0 = scripts\mp\utility\dvars::_id_6AC8("#x3a50090ef2655f71f", level._id_4F41);

  if(level._id_4F41 != var_0) {
    level._id_4F41 = var_0;
    _id_FC6E();
  }
}

_id_FC6E() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
      if(level._id_4F41) {
        if(var_2.pers["team"] == "allies") {
          var_2._id_75E9 = game["headicon_allies"];
          var_2._id_75F7 = "allies";
        } else {
          var_2._id_75E9 = game["headicon_axis"];
          var_2._id_75F7 = "axis";
        }

        continue;
      }

      var_0 = level.players;

      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];

        if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
          var_2._id_75E9 = "";
        }
      }
    }
  }
}