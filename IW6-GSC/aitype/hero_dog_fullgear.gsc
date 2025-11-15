/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_dog_fullgear.gsc
****************************************/

main() {
  self.animtree = "dog.atr";
  self.additionalassets = "common_dogs.csv";
  self.team = "allies";
  self.type = "dog";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "dog_bite";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "dog_bite";
  character\character_iw6_sp_german_shepherd_dog_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_iw6_sp_german_shepherd_dog_a::precache();
  precacheitem("dog_bite");
  precacheitem("dog_bite");
  animscripts\dog\dog_init::initdoganimations();
}