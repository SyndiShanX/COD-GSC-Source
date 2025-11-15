/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\friendicons.gsc
**************************************/

init() {
  level.drawfriend = 0;
  game["headicon_allies"] = scripts\mp\teams::_meth_81B0("allies");
  game["headicon_axis"] = scripts\mp\teams::_meth_81B0("axis");
  precacheheadicon(game["headicon_allies"]);
  precacheheadicon(game["headicon_axis"]);
  precacheshader("waypoint_revive");
  level thread onplayerconnect();
  for(;;) {
    updatefriendiconsettings();
    wait(5);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
    var_00 thread onplayerkilled();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    thread showfriendicon();
  }
}

onplayerkilled() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
    self.playerphysicstrace = "";
  }
}

showfriendicon() {
  if(level.drawfriend) {
    if(self.pers["team"] == "allies") {
      self.playerphysicstrace = game["headicon_allies"];
      self.playfx = "allies";
      return;
    }

    self.playerphysicstrace = game["headicon_axis"];
    self.playfx = "axis";
  }
}

updatefriendiconsettings() {
  var_00 = scripts\mp\utility::getintproperty("scr_drawfriend", level.drawfriend);
  if(level.drawfriend != var_00) {
    level.drawfriend = var_00;
    updatefriendicons();
  }
}

updatefriendicons() {
  var_00 = level.players;
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(isDefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing") {
      if(level.drawfriend) {
        if(var_02.pers["team"] == "allies") {
          var_02.playerphysicstrace = game["headicon_allies"];
          var_02.playfx = "allies";
        } else {
          var_02.playerphysicstrace = game["headicon_axis"];
          var_02.playfx = "axis";
        }

        continue;
      }

      var_00 = level.players;
      for(var_01 = 0; var_01 < var_00.size; var_01++) {
        var_02 = var_00[var_01];
        if(isDefined(var_02.pers["team"]) && var_02.pers["team"] != "spectator" && var_02.sessionstate == "playing") {
          var_02.playerphysicstrace = "";
        }
      }
    }
  }
}