/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_jap_reg_camo_wet_type100smg.gsc
*******************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "type100_smg_wet";
  self.secondaryweapon = "";
  self.sidearm = "nambu_wet";
  self.grenadeWeapon = "type97_frag";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_jap_makpelwet_rifle_camo::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_makpelwet_rifle_camo::precache();
  precacheItem("type100_smg_wet");
  precacheItem("nambu_wet");
  precacheItem("type97_frag");
}