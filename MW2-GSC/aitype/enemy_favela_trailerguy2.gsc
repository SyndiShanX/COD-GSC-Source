/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_favela_trailerguy2.gsc
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
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ak47_reflex";
      break;
    case 2:
      self.weapon = "ak47_grenadier";
      break;
    case 3:
      self.weapon = "ak47_acog";
      break;
  }

  character\character_opf_militia_assault_ab_blk::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_opf_militia_assault_ab_blk::precache();

    precacheItem("ak47");
    precacheItem("ak47_reflex");
    precacheItem("ak47_grenadier");
    precacheItem("gl_ak47");
    precacheItem("ak47_acog");
    precacheItem("beretta");
    precacheItem("fraggrenade");