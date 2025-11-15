/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\test_enemy_shark_dog.gsc
*******************************************/

main() {
  self.animtree = "animals.atr";
  self.additionalassets = "common_sharks.csv";
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
  character\character_enemy_shark::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_enemy_shark::precache();
  precacheitem("dog_bite");
  precacheitem("dog_bite");
  precacheitem("fraggrenade");
  animscripts\dog\dog_init::initdoganimations();
}