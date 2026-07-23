/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_hero_grinch_delta.gsc
*****************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "usp_silencer";
  self.sidearm = "usp_silencer";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m14ebr";
  character/character_hero_delta_grinch::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character/character_hero_delta_grinch::precache();
  precacheitem("m14ebr");
  precacheitem("usp_silencer");
  precacheitem("usp_silencer");
  precacheitem("fraggrenade");
}