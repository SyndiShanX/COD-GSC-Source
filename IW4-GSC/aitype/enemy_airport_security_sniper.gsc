/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_airport_security_sniper.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "sniper_glint.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m14_scoped";

  character\character_secret_service_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_secret_service_assault_a::precache();

    precacheItem("m14_scoped");
    precacheItem("beretta");
    precacheItem("fraggrenade");