/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_usmc_wet_comoff.gsc
**********************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "thompson_wet";
  self.secondaryweapon = "";
  self.sidearm = "colt_wet";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_usa_marine_h_comoff::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_marine_h_comoff::precache();

  precacheItem("thompson_wet");
  precacheItem("colt_wet");
  precacheItem("fraggrenade");
}