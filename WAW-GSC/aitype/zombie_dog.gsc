/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_dog.gsc
**************************************/

main() {
  self.animTree = "dog.atr";
  self.team = "axis";
  self.type = "dog";
  self.accuracy = 0.2;
  self.health = 200;
  self.weapon = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_sp_zombie_dog::main();
      break;
    case 1:
      character\character_sp_zombie_dog_black_fur::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_zombie_dog::precache();
  character\character_sp_zombie_dog_black_fur::precache();

  precacheItem("fraggrenade");
}