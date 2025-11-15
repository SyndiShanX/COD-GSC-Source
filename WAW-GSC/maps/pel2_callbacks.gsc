/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel2_callbacks.gsc
*****************************************************/

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
    player SetWeaponAmmoStock("colt", 80);
    player setthreatbiasgroup("players");
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
    println("Player spawned in to game at " + self.origin);
  }
}

onPlayerKilled() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
    println("Player killed at " + self.origin);
  }
}