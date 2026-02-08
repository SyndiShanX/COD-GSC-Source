/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_rus_sarge_nocoat.gsc
********************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "ppsh";
  self.secondaryweapon = "";
  self.sidearm = "mosin_rifle_scoped";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 3;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_rus_h_reznov::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_rus_h_reznov::precache();

  precacheItem("ppsh");
  precacheItem("mosin_rifle_scoped");
  precacheItem("fraggrenade");
}