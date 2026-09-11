/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\friendicons.gsc
***********************************************/

function init() {
  level.drawfriend = 0;
  game["headicon_allies"] = scripts\mp\utility\teams::getteamheadicon("allies");
  game["headicon_axis"] = scripts\mp\utility\teams::getteamheadicon("axis");
  precacheshader("waypoint_revive");
  thread onplayerconnect();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);

  for(;;) {
    updatefriendiconsettings();
    wait 5;
  }
}

function onplayerconnect() {
  jumpiffalse(scripts\mp\utility\game::runleanthreadmode()) LOC_00000009;
  return;
}

function onplayerspawned() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  thread showfriendicon();
}

function onplayerkilled() {
  self endon("disconnect");

  for(;;) {
    self waittill("killed_player");
    self.headicon = "";
  }
}

function showfriendicon() {
  if(level.drawfriend) {
    if(self.pers["team"] == "allies") {
      self.headicon = game["headicon_allies"];
      self.headiconteam = "allies";
      return;
    }

    self.headicon = game["headicon_axis"];
    self.headiconteam = "axis";
    return;
  }
}

function updatefriendiconsettings() {
  var_0 = scripts\mp\utility\dvars::getintproperty("scr_drawfriend", level.drawfriend);

  if(level.drawfriend != var_0) {
    level.drawfriend = var_0;
    updatefriendicons();
    return;
  }
}

function updatefriendicons() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

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

      var_0 = level.players;

      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];

        if(isDefined(var_2.pers["team"]) && var_2.pers["team"] != "spectator" && var_2.sessionstate == "playing") {
          var_2.headicon = "";
        }
      }
    }
  }
}