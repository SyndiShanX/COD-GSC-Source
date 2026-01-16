/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_friendicons.gsc
**********************************************/

init() {
  level.drawfriend = 0;
  game["headicon_allies"] = maps\mp\gametypes\_teams::getteamheadicon("allies");
  game["headicon_axis"] = maps\mp\gametypes\_teams::getteamheadicon("axis");
  level thread onplayerconnect();

  for (;;) {
    updatefriendiconsettings();
    wait 5;
  }
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread onplayerkilled();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    self waittill("spawned_player");
    thread showfriendicon();
  }
}

onplayerkilled() {
  self endon("disconnect");

  for (;;) {
    self waittill("killed_player");
    self.headicon = "";
  }
}

showfriendicon() {
  if(level.drawfriend) {
    if(self.pers["team"] == "allies") {
      self.headicon = game["headicon_allies"];
      self.headiconteam = "allies";
    } else {
      self.headicon = game["headicon_axis"];
      self.headiconteam = "axis";
    }
  }
}

updatefriendiconsettings() {
  var_0 = maps\mp\_utility::getintproperty("scr_drawfriend", level.drawfriend);

  if(level.drawfriend != var_0) {
    level.drawfriend = var_0;
    updatefriendicons();
  }
}

updatefriendicons() {
  var_0 = level.players;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isdefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
      if(level.drawfriend) {
        if(var_2.pers["team"] == "allies") {
          var_2.headicon = game["headicon_allies"];
          var_2.headiconteam = "allies";
        } else {
          var_2.headicon = game["headicon_axis"];
          var_2.headiconteam = "axis";
        }

        continue;
      }

      var_0 = level.players;

      for (var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];

        if(isdefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing")
          var_2.headicon = "";
      }
    }
  }
}