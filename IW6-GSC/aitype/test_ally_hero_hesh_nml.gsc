/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\test_ally_hero_hesh_nml.gsc
**********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "honeybadger+reflex_sp";
  character\character_hesh_ranger_assault_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_hesh_ranger_assault_a::precache();
  precacheitem("honeybadger+reflex_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}