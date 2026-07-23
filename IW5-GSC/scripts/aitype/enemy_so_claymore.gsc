/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_so_claymore.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(350.0, 600.0);
  }

  self.weapon = "none";
  character/character_so_russian_naval_assault::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_so_russian_naval_assault::precache();
  precacheitem("fraggrenade");
  maps/_rambo::main();
}