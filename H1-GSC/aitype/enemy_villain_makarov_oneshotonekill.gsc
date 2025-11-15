/***********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_villain_makarov_oneshotonekill.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  character\character_vil_makarov_oneshotonekill::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_vil_makarov_oneshotonekill::precache();
  precacheitem("fraggrenade");
}