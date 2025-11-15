/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_ger_ber_wehr_reg_gewehr43.gsc
*****************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "gewehr43";
  self.secondaryweapon = "";
  self.sidearm = "walther";
  self.grenadeWeapon = "Stielhandgranate";
  self.grenadeAmmo = 3;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  character\char_ger_wrmcht_k98::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_ger_wrmcht_k98::precache();
  precacheItem("gewehr43");
  precacheItem("walther");
  precacheItem("Stielhandgranate");
}