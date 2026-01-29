/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_payback_smg.gsc
***************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "usp";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "pp90m1";

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
  precacheitem("pp90m1");
  precacheitem("usp");
  precacheitem("fraggrenade");
  _id_05C2::main();
}