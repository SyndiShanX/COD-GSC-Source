/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\friendicons.gsc
***********************************************/

init() {
  level.drawfriend = 0;
  game["headicon_allies"] = scripts\mp\utility\teams::getteamheadicon("allies");
  game["headicon_axis"] = scripts\mp\utility\teams::getteamheadicon("axis");
  precacheshader("waypoint_revive");
  level thread onplayerconnect();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);

  for(;;) {
    updatefriendiconsettings();
    wait 5;
  }
}

onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  for(;;) {
    level waittill("connected", player);
    player thread onplayerkilled();
  }
}

onplayerspawned() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  thread showfriendicon();
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
  drawfriend = scripts\mp\utility\dvars::getintproperty("scr_drawfriend", level.drawfriend);

  if(level.drawfriend != drawfriend) {
    level.drawfriend = drawfriend;
    updatefriendicons();
  }
}

updatefriendicons() {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

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

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
        player = players[_id_AC0E594AC96AA3A8];

        if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
          player.headicon = "";
      }
    }
  }
}