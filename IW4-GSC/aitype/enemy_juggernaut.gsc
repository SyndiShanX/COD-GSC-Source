/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_juggernaut.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "juggernaut.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "juggernaut";
  self.accuracy = 0.2;
  self.health = 3600;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(0.000000, 0.000000);
    self setEngagementMaxDist(256.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "m240";
      break;
    case 1:
      self.weapon = "m240_eotech";
      break;
    case 2:
      self.weapon = "m240_acog";
      break;
    case 3:
      self.weapon = "m240_reflex";
      break;
  }

  character\character_sp_juggernaut::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_sp_juggernaut::precache();

    precacheItem("m240");
    precacheItem("m240_eotech");
    precacheItem("m240_acog");
    precacheItem("m240_reflex");
    precacheItem("beretta");
    precacheItem("beretta");
    precacheItem("fraggrenade");