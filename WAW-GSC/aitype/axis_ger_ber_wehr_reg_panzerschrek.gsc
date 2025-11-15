/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_ger_ber_wehr_reg_panzerschrek.gsc
*********************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "panzerschrek";
  self.secondaryweapon = "mp40";
  self.sidearm = "walther";
  self.grenadeWeapon = "Stielhandgranate";
  self.grenadeAmmo = 0;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_ger_wrmcht_k98::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_ger_wrmcht_k98::precache();
  precacheItem("panzerschrek");
  precacheItem("mp40");
  precacheItem("walther");
  precacheItem("Stielhandgranate");
}