/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_space_smg.gsc
******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 50;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "microtar_space_interior+acogsmg_sp+spaceshroud_sp";
  character\character_fed_space_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_space_assault_a::precache();
  precacheitem("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
  precacheitem("fraggrenade");
}