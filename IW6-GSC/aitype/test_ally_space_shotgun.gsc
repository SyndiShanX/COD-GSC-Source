/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\test_ally_space_shotgun.gsc
**********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "spaceshotgun";
  character\character_us_space_assault_b::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_space_assault_b::precache();
  precacheitem("spaceshotgun");
  precacheitem("fraggrenade");
}