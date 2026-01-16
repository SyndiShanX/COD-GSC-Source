/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mak_net.gsc
*****************************************************/

main() {
  level thread onPlayerConnect();
}

onPlayerConnect() {
  for (;;) {
    level waittill("connecting", player);
    player thread onPlayerDisconnect();
    player thread onPlayerSpawned();
    player thread onPlayerKilled();
    println("Player connected to game.");
  }
}

onPlayerDisconnect() {
  self waittill("disconnect");
  if(isDefined(self.viewhands)) {
    self.viewhands Delete();
  }
  println("Player disconnected from the game.");
}

onPlayerSpawned() {
  self endon("disconnect");
  for (;;) {
    self waittill("spawned_player");
    self SetThreatBiasGroup("players");
    println("Player spawned in to game at " + self.origin);
    if(isDefined(level.player_speed)) {
      self maps\mak::set_player_speed(level.player_speed);
    }
    self maps\mak::set_onplayer_attribs();
  }
}

onPlayerKilled() {
  self endon("disconnect");
  for (;;) {
    self waittill("killed_player");
    println("Player killed at " + self.origin);
  }
}