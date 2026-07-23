/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_tf_141_arctic_shotgun.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "winchester1200";
      break;
    case 1:
      self.weapon = "m1014";
      break;
  }

  character\character_tf_141_arctic_shotgun::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_tf_141_arctic_shotgun::precache();

  precacheItem("winchester1200");
  precacheItem("m1014");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}