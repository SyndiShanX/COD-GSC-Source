/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2733.gsc
***************************************/

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
    wait 5;
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
  var_00 = scripts\mp\utility\game::getintproperty("scr_drawfriend", level.drawfriend);

  if(level.drawfriend != var_00) {
    level.drawfriend = var_00;
    updatefriendicons();
  }
}

updatefriendicons() {
  var_00 = level.players;

  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01];

    if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
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

      var_00 = level.players;

      for(var_01 = 0; var_01 < var_0.size; var_1++) {
        var_02 = var_0[var_01];

        if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
          var_2.headicon = "";
        }
      }
    }
  }
}