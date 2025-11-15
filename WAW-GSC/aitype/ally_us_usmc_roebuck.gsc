/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_usmc_roebuck.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "thompson";
  self.secondaryweapon = "";
  self.sidearm = "colt";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_usa_marine_h_miller::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_marine_h_miller::precache();
  precacheItem("thompson");
  precacheItem("colt");
  precacheItem("fraggrenade");
}