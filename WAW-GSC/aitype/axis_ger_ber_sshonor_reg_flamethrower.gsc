/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_ger_ber_sshonor_reg_flamethrower.gsc
************************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "m2_flamethrower";
  self.secondaryweapon = "";
  self.sidearm = "walther";
  self.grenadeWeapon = "Stielhandgranate";
  self.grenadeAmmo = 0;
  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);
  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\char_ger_honorguard_flamethrower::main();
      break;
    case 1:
      character\char_ger_honorguard2_flamethrower::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_ger_honorguard_flamethrower::precache();
  character\char_ger_honorguard2_flamethrower::precache();
  precacheItem("m2_flamethrower");
  precacheItem("walther");
  precacheItem("Stielhandgranate");
}