/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_jap_guard_type99lmg.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "type99_lmg";
  self.secondaryweapon = "";
  self.sidearm = "nambu";
  self.grenadeWeapon = "type97_frag";
  self.grenadeAmmo = 0;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_jap_oki_rifle::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_oki_rifle::precache();
  precacheItem("type99_lmg");
  precacheItem("nambu");
  precacheItem("type97_frag");
}