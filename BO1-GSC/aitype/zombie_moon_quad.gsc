/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_moon_quad.gsc
***************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "zombie";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "m1911_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "frag_grenade_zm";
  self.grenadeAmmo = 0;
  self.csvInclude = "";
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\c_zom_moon_quad::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\c_zom_moon_quad::precache();
  precacheItem("m1911_zm");
  precacheItem("m1911_zm");
  precacheItem("frag_grenade_zm");
}