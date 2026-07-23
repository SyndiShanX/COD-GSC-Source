/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_drone_group_a.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeWeapon = "";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ump45";
      break;
  }

  character\character_enemy_drone_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_enemy_drone_a::precache();

  precacheItem("ak47");
  precacheItem("ump45");
}