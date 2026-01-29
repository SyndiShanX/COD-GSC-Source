/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_ak47.gsc
********************************************************/

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
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ak47_reflex";
      break;
    case 2:
      self.weapon = "ak47_grenadier";
      break;
    case 3:
      self.weapon = "ak47_acog";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      _id_5B95::main();
      break;
    case 1:
      _id_5B96::main();
      break;
    case 2:
      _id_5B97::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_5B95::precache();
  _id_5B96::precache();
  _id_5B97::precache();
  precacheitem("ak47");
  precacheitem("ak47_reflex");
  precacheitem("ak47_grenadier");
  precacheitem("gl_ak47");
  precacheitem("ak47_acog");
  precacheitem("glock");
  precacheitem("fraggrenade");
  _id_05C2::main();
}