/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber1_callbacks.gsc
*****************************************************/

#include maps\_utility;
#include maps\ber1_util;
#include common_scripts\utility;

onFirstPlayerConnect() {
  level waittill("connecting_first_player", player);
  player thread onPlayerDisconnect();
  player thread onPlayerSpawned();
  player thread onPlayerKilled();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerDisconnect();
    player thread onPlayerSpawned();
    player thread onPlayerKilled();
  }
}

onPlayerDisconnect() {
  self waittill("disconnect");
  println("Player disconnected from the game.");
}

onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.drone_avoid = false;
    self setthreatbiasgroup("players");
    if(isDefined(level.startskip) && !level.startskip) {
      self thread AttachToTrain();
    }
  }
}

onPlayerKilled() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
  }
}

AttachToTrain() {
  if(isDefined(level.players_linked_to_train) && level.players_linked_to_train) {
    index = 0;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] == self) {
        index = i;
        break;
      }
    }
    link_to_origin = level.train_attach_points[index];
    ASSERTEX(isDefined(link_to_origin), "Could not locate script_origin train_player_link_origin");
    self setorigin(link_to_origin.origin);
    self PlayerLinkTo(link_to_origin);
    self flag_wait("loadout_given");
    self allowSprint(false);
    self setMoveSpeedScale(0.9);
    self disableWeapons();
  }
}