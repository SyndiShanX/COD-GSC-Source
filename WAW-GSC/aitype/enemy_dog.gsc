/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_dog.gsc
**************************************/

main() {
  self.animTree = "dog.atr";
  self.team = "axis";
  self.type = "dog";
  self.accuracy = 0.2;
  self.health = 200;
  self.weapon = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\character_sp_german_sheperd_dog::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_german_sheperd_dog::precache();

  precacheItem("fraggrenade");
}