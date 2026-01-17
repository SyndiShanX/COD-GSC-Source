/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki3_callbacks.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;

onFirstPlayerConnect() {
  level waittill("connecting_first_player", player);
  println("First player connected to game.");
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerDisconnect();
    player thread onPlayerSpawned();
    player thread onPlayerKilled();
    println("Player connected to game.");
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
    self thread monitor_movement_speed();
    self thread maps\oki3_dpad_asset::airstrike_player_init();
  }
}

onPlayerKilled() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
  }
}

monitor_movement_speed() {
  self endon("disconnect");
  level.old_player_move_speed = 180;
  while(1) {
    if(level.player_move_speed != level.old_player_move_speed) {
      self maps\oki3_util::set_player_speed(level.player_move_speed, 5);
      level.player_old_move_speed = level.player_move_speed;
    }
    wait(1);
  }
}