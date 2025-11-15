/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_dog.gsc
**************************************/

main() {
  self.animTree = "dog.atr";
  self.team = "axis";
  self.type = "zombie_dog";
  self.accuracy = 0.2;
  self.health = 200;
  self.weapon = "dog_bite_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "frag_grenade_zm";
  self.grenadeAmmo = 0;
  self.csvInclude = "";
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_sp_zombie_dog::main();
      break;
    case 1:
      character\character_sp_zombie_dog::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_zombie_dog::precache();
  character\character_sp_zombie_dog::precache();
  precacheItem("dog_bite_zm");
  precacheItem("m1911_zm");
  precacheItem("frag_grenade_zm");
}