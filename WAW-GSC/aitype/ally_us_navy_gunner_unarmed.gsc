/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_navy_gunner_unarmed.gsc
**************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "m1garand_sailor";
  self.secondaryweapon = "";
  self.sidearm = "colt";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_usa_navy_r_gunner::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_navy_r_gunner::precache();

  precacheItem("m1garand_sailor");
  precacheItem("colt");
  precacheItem("fraggrenade");
}