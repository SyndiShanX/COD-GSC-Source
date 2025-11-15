/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_oil_worker_shotgun.gsc
***********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "mts255";
      break;
    case 1:
      self.weapon = "mts255";
      break;
    case 2:
      self.weapon = "mts255";
      break;
    case 3:
      self.weapon = "mts255";
      break;
  }

  character\character_oil_worker::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_oil_worker::precache();
  precacheitem("mts255");
  precacheitem("mts255");
  precacheitem("mts255");
  precacheitem("mts255");
  precacheitem("p226");
  precacheitem("fraggrenade");
}