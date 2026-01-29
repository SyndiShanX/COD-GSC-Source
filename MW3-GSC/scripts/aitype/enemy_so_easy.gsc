/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_so_easy.gsc
********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      _id_05BD::main();
      break;
    case 1:
      _id_05BE::main();
      break;
    case 2:
      _id_05BF::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_05BD::precache();
  _id_05BE::precache();
  _id_05BF::precache();
  precacheitem("fraggrenade");
}