/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_favela_snpr.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "sniper_glint_and_rambo.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.15;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(1250.000000, 1024.000000);
    self setEngagementMaxDist(1600.000000, 2400.000000);
  }

  self.weapon = "dragunov";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_op_militia_sniper::main();
      break;
    case 1:
      character\character_opf_militia_assault_aa_wht::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_op_militia_sniper::precache();
    character\character_opf_militia_assault_aa_wht::precache();

    precacheItem("dragunov");
    precacheItem("glock");
    precacheItem("fraggrenade");

    maps\_sniper_glint::main();