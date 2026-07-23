/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_ghillie_sniper.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "sniper_glint.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "pp2000_silencer";
  self.sidearm = "usp_silencer";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "wa2000";

  character\character_opforce_merc_sniper_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_opforce_merc_sniper_a::precache();

    precacheItem("wa2000");
    precacheItem("pp2000_silencer");
    precacheItem("usp_silencer");
    precacheItem("fraggrenade");