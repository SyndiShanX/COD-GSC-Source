/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_hijacker_ak74u.gsc
***************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak74u";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      stopusingheroonlylighting::main();
      break;
    case 1:
      startusinglessfrequentlighting::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  stopusingheroonlylighting::precache();
  startusinglessfrequentlighting::precache();
  precacheitem("ak74u");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}