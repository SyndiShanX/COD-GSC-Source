/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\villain_rorke_basic_vest_nogun.gsc
*****************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  character\character_rorke_basic_b::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_rorke_basic_b::precache();
}