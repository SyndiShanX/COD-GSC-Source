/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_navy_wet_sailor.gsc
*****************************************************/

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
  switch (codescripts\character::get_random_character(4)) {
    case 0:
      character\char_usa_navy_wetsailor1::main();
      break;
    case 1:
      character\char_usa_navy_wetsailor2::main();
      break;
    case 2:
      character\char_usa_navy_wetsailor3::main();
      break;
    case 3:
      character\char_usa_navy_wetsailor4::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_usa_navy_wetsailor1::precache();
  character\char_usa_navy_wetsailor2::precache();
  character\char_usa_navy_wetsailor3::precache();
  character\char_usa_navy_wetsailor4::precache();
  precacheItem("m1garand_sailor");
  precacheItem("colt");
  precacheItem("fraggrenade");
}