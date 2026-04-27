/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_favela_grabteam_guy2.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "ak47";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "beretta";

  character\character_opf_militia_smg_aa_wht::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_opf_militia_smg_aa_wht::precache();

  precacheItem("beretta");
  precacheItem("ak47");
  precacheItem("fraggrenade");
}