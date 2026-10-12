/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\friendicons.gsc
***********************************************/

#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;
#namespace friendicons;

function init() {
  level.drawfriend = 0;
  game["headicon_allies"] = getteamheadicon("allies");
  game["headicon_axis"] = getteamheadicon("axis");
  precacheshader("waypoint_revive");
  level thread onplayerconnect();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);

  for(;;) {
    updatefriendiconsettings();
    wait 5;
  }
}

function onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  for(;;) {
    level waittill("connected", player);
    player thread onplayerkilled();
  }
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
  }
}

function updatefriendiconsettings() {
  drawfriend = scripts\mp\utility\dvars::getintproperty("scr_drawfriend", level.drawfriend);

  if(level.drawfriend != drawfriend) {
    level.drawfriend = drawfriend;
    updatefriendicons();
  }
}

function updatefriendicons() {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing") {
      if(level.drawfriend) {
        if(player.pers["team"] == "allies") {
          player.headicon = game["headicon_allies"];
          player.headiconteam = "allies";
        } else {
          player.headicon = game["headicon_axis"];
          player.headiconteam = "axis";
        }

        continue;
      }

      players = level.players;

      for(i = 0; i < players.size; i++) {
        player = players[i];

        if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing") {
          player.headicon = "";
        }
      }
    }
  }
}