/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_jap_guard_camo_type99riflescoped.gsc
************************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "type99_rifle_scoped";
  self.secondaryweapon = "";
  self.sidearm = "nambu";
  self.grenadeWeapon = "type97_frag";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_jap_oki_rifle_camo::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_oki_rifle_camo::precache();

  precacheItem("type99_rifle_scoped");
  precacheItem("nambu");
  precacheItem("type97_frag");
}