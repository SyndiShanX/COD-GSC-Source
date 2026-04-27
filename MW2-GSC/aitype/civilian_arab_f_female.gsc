/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\civilian_arab_f_female.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "neutral";
  self.type = "civilian";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 25;
  self.secondaryweapon = "beretta";
  self.sidearm = "colt45";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "ak47";

  character\character_arab_civilian_f_fem::main();
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_arab_civilian_f_fem::precache();

  precacheItem("ak47");
  precacheItem("beretta");
  precacheItem("colt45");
  precacheItem("fraggrenade");
}