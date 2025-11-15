/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_zombie_jp_swamp.gsc
*******************************************/

main() {
  self.animTree = "generic_human";
  self.team = "axis";
  self.type = "zombie";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "m1911_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "Stielhandgranate";
  self.grenadeAmmo = 3;
  self.csvInclude = "";
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\char_jap_zombie::main();
      break;
    case 1:
      character\char_jap_zombie_nocap::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_zombie::precache();
  character\char_jap_zombie_nocap::precache();
  precacheItem("m1911_zm");
  precacheItem("m1911_zm");
  precacheItem("Stielhandgranate");
}