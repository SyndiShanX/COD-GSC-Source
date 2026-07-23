/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_hijacker_shgn.gsc
**************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.18;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(140.0, 200.0);
  }

  self.weapon = "aa12";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      setthermalfog::main();
      break;
    case 1:
      setnightvisionfog::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  setthermalfog::precache();
  setnightvisionfog::precache();
  precacheitem("aa12");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}