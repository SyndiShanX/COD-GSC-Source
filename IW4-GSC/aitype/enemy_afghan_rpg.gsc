/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_afghan_rpg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "rpg_player.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "ak47_reflex";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(768.000000, 512.000000);
    self setEngagementMaxDist(1024.000000, 1500.000000);
  }

  self.weapon = "rpg";

  character\character_opforce_arab_lmg_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_arab_lmg_a::precache();

  precacheItem("rpg");
  precacheItem("ak47_reflex");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}