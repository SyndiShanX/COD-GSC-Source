/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki2_callbacks.gsc
**************************************/

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
    self thread maps\oki2_fx::player_rain();
  }
}

onPlayerKilled() {
  self endon("disconnect");

  for(;;) {
    self waittill("killed_player");
  }
}