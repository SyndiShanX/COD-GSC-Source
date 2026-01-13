/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\friendicons.gsc
*********************************************/

init() {
  level.drawfriend = 0;
  game["headicon_allies"] = ::scripts\mp\teams::_meth_81B0("allies");
  game["headicon_axis"] = ::scripts\mp\teams::_meth_81B0("axis");
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
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread onplayerkilled();
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
  var_0 = scripts\mp\utility::getintproperty("scr_drawfriend", level.drawfriend);
  if(level.drawfriend != var_0) {
    level.drawfriend = var_0;
    updatefriendicons();
  }
}

updatefriendicons() {
  var_0 = level.players;
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
      if(level.drawfriend) {
        if(var_2.pers["team"] == "allies") {
          var_2.playerphysicstrace = game["headicon_allies"];
          var_2.playfx = "allies";
        } else {
          var_2.playerphysicstrace = game["headicon_axis"];
          var_2.playfx = "axis";
        }

        continue;
      }

      var_0 = level.players;
      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];
        if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
          var_2.playerphysicstrace = "";
        }
      }
    }
  }
}