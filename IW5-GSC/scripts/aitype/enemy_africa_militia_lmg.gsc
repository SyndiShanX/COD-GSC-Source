/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_lmg.gsc
*******************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(512.0, 400.0);
    self setengagementmaxdist(1024.0, 1250.0);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "m60e4";
      break;
    case 1:
      self.weapon = "pecheneg";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      _id_5B9B::main();
      break;
    case 1:
      _id_5B9C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_5B9B::precache();
  _id_5B9C::precache();
  precacheitem("m60e4");
  precacheitem("pecheneg");
  precacheitem("glock");
  precacheitem("fraggrenade");
  _id_05C2::main();
}