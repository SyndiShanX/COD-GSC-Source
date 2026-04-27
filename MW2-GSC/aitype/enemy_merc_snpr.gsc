/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_merc_snpr.gsc
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

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "dragunov";
      break;
    case 1:
      self.weapon = "dragunov_woodland";
      break;
  }

  character\character_opforce_merc_sniper_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_opforce_merc_sniper_a::precache();

    precacheItem("dragunov");
    precacheItem("dragunov_woodland");
    precacheItem("pp2000");
    precacheItem("fraggrenade");