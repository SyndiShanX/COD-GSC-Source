/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\zombie_ger_zombietron.gsc
********************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "zombie";
  self.accuracy = 1;
  self.health = 150;
  self.weapon = "ak47_zm";
  self.secondaryweapon = "";
  self.sidearm = "m1911_zm";
  self.grenadeWeapon = "frag_grenade_zm";
  self.grenadeAmmo = 0;
  self.csvInclude = "";
  self setEngagementMinDist(250.000000, 0.000000);
  self setEngagementMaxDist(700.000000, 1000.000000);
  character\c_ger_honorguard_zombietron::main();
}
spawner() {
  self setspawnerteam("axis");
}
precache() {
  character\c_ger_honorguard_zombietron::precache();
  precacheItem("ak47_zm");
  precacheItem("m1911_zm");
  precacheItem("frag_grenade_zm");
}