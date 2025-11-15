/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_raid_reg_sniper.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "springfield_scoped";
  self.secondaryweapon = "";
  self.sidearm = "colt";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(2000.000000, 3000.000000);
  character\char_usa_raider_r_rifle::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_raider_r_rifle::precache();
  precacheItem("springfield_scoped");
  precacheItem("colt");
  precacheItem("fraggrenade");
}