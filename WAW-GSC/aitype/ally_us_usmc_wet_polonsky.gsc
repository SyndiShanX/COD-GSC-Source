/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_usmc_wet_polonsky.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "m1garand_wet";
  self.secondaryweapon = "";
  self.sidearm = "colt_wet";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_usa_marinewet_h_polonsky::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_marinewet_h_polonsky::precache();
  precacheItem("m1garand_wet");
  precacheItem("colt_wet");
  precacheItem("fraggrenade");
}