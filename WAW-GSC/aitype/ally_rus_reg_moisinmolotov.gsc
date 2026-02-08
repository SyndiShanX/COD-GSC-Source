/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_rus_reg_moisinmolotov.gsc
*************************************************/

main() {
  self.animTree = "";
  self.team = "allies";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 100;
  self.weapon = "mosin_rifle";
  self.secondaryweapon = "";
  self.sidearm = "tokarev";
  self.grenadeWeapon = "molotov";
  self.grenadeAmmo = 3;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  character\char_rus_r_rifle::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\char_rus_r_rifle::precache();

  precacheItem("mosin_rifle");
  precacheItem("tokarev");
  precacheItem("molotov");
}