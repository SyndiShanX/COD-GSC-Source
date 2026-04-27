/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_airborne_snpr.gsc
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
  self.sidearm = "pp2000";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(1250.000000, 1024.000000);
    self setEngagementMaxDist(1600.000000, 2400.000000);
  }

  self.weapon = "dragunov";

  character\character_op_airborne_sniper::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_op_airborne_sniper::precache();

    precacheItem("dragunov");
    precacheItem("pp2000");
    precacheItem("fraggrenade");