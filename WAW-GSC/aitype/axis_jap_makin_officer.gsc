/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_jap_makin_officer.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "type100_smg";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeWeapon = "type97_frag";
  self.grenadeAmmo = 0;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_jap_makin_officer::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_makin_officer::precache();
  precacheItem("type100_smg");
  precacheItem("type97_frag");
}