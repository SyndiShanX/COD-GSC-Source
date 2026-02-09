/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_usa_zombie_officeworker.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "zombie";
  self.accuracy = 1;
  self.health = 150;
  self.weapon = "ak47_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "frag_grenade_zm";
  self.grenadeAmmo = 0;
  self.csvInclude = "";
  self setEngagementMinDist(250.000000, 0.000000);
  self setEngagementMaxDist(700.000000, 1000.000000);
  character\c_usa_pent_zombie_officeworker::main();
}
spawner() {
  self setspawnerteam("axis");
}
precache() {
  character\c_usa_pent_zombie_officeworker::precache();
  precacheItem("ak47_zm");
  precacheItem("m1911_zm");
  precacheItem("frag_grenade_zm");
}