/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_space_kyra.gsc
**************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "microtar_space_interior+acogsmg_sp+spaceshroud_sp";
  character\character_kyra_us_space_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_kyra_us_space_a::precache();
  precacheitem("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
}