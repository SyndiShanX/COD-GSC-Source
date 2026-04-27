/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_afghan_smg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
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
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 768.000000);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "uzi";
      break;
    case 1:
      self.weapon = "tmp";
      break;
    case 2:
      self.weapon = "mp5";
      break;
    case 3:
      self.weapon = "uzi";
      break;
  }

  character\character_opforce_arab_smg_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_arab_smg_a::precache();

  precacheItem("uzi");
  precacheItem("tmp");
  precacheItem("mp5");
  precacheItem("uzi");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}