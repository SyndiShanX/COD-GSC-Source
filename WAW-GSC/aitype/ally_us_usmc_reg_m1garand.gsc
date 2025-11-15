/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_usmc_reg_m1garand.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "m1garand";
  self.secondaryweapon = "";
  self.sidearm = "colt";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\char_usa_marine_r_rifle::main();
      break;
    case 1:
      character\char_usa_marine2_r_rifle::main();
      break;
    case 2:
      character\char_usa_marine_r_rifle::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_marine_r_rifle::precache();
  character\char_usa_marine2_r_rifle::precache();
  character\char_usa_marine_r_rifle::precache();
  precacheItem("m1garand");
  precacheItem("colt");
  precacheItem("fraggrenade");
}