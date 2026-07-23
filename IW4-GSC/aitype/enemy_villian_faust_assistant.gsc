/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_villian_faust_assistant.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "deserteagle";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  self.weapon = "ak47";

  character\character_vil_faust_assist::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_vil_faust_assist::precache();

    precacheItem("ak47");
    precacheItem("deserteagle");
    precacheItem("fraggrenade");