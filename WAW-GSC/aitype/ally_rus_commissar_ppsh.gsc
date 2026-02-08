/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_rus_commissar_ppsh.gsc
**********************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "ppsh";
  self.secondaryweapon = "";
  self.sidearm = "tokarev";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_rus_h_commissar::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_rus_h_commissar::precache();

  precacheItem("ppsh");
  precacheItem("tokarev");
  precacheItem("fraggrenade");
}