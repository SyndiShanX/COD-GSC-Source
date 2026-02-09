/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_friendicons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace friendicons;

function autoexec __init__sytem__() {
  system::register("friendicons", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
  if(!level.teambased) {
    return;
  }
  if(getdvarstring("scr_drawfriend") == "") {
    setDvar("scr_drawfriend", "0");
  }
  level.drawfriend = getdvarint("scr_drawfriend");
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  for(;;) {
    updatefriendiconsettings();
    wait(5);
  }
}

function on_player_spawned() {
  self endon("disconnect");
  self thread showfriendicon();
}

function on_player_killed() {
  self endon("disconnect");
  self.headicon = "";
}

function showfriendicon() {
  if(level.drawfriend) {
    team = self.pers["team"];
    self.headicon = game["headicon_" + team];
    self.headiconteam = team;
  }
}

function updatefriendiconsettings() {
  drawfriend = getdvarfloat("scr_drawfriend");
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
        team = self.pers["team"];
        self.headicon = game["headicon_" + team];
        self.headiconteam = team;
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