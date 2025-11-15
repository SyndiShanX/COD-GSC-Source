/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_dog.gsc
********************************/

main() {
  self.animtree = "dog.atr";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "dog";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "dog_bite";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "dog_bite";
  character\character_sp_german_sheperd_dog::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_german_sheperd_dog::precache();
  precacheitem("dog_bite");
  precacheitem("dog_bite");
  precacheitem("fraggrenade");
}