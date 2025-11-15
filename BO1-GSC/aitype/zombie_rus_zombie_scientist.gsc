/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_rus_zombie_scientist.gsc
**************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "zombie";
  self.accuracy = 1;
  self.health = 150;
  self.weapon = "m1911_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "frag_grenade_zm";
  self.grenadeAmmo = 0;
  self.csvInclude = "";
  self setEngagementMinDist(250.000000, 0.000000);
  self setEngagementMaxDist(700.000000, 1000.000000);
  character\c_zom_cosmo_scientist::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\c_zom_cosmo_scientist::precache();
  precacheItem("m1911_zm");
  precacheItem("m1911_zm");
  precacheItem("frag_grenade_zm");
}