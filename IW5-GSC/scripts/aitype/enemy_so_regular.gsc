/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_so_regular.gsc
***********************************************/

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
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  character/character_so_regular_smg::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_so_regular_smg::precache();
  precacheitem("fraggrenade");
  maps/_rambo::main();
}