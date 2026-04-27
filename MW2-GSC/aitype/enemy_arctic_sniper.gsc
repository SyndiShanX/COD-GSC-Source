/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_arctic_sniper.gsc
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
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(1024.000000, 825.000000);
    self setEngagementMaxDist(1450.000000, 2100.000000);
  }

  self.weapon = "dragunov_arctic";

  character\character_op_arctic_sniper::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_op_arctic_sniper::precache();

    precacheItem("dragunov_arctic");
    precacheItem("usp");
    precacheItem("fraggrenade");