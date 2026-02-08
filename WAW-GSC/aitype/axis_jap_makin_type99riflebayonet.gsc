/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\axis_jap_makin_type99riflebayonet.gsc
********************************************************/

main() {
  self.animTree = "";
  self.team = "axis";
  self.type = "human";
  self.accuracy = 0.2;
  self.health = 150;
  self.weapon = "type99_rifle_bayonet";
  self.secondaryweapon = "";
  self.sidearm = "nambu";
  self.grenadeWeapon = "type97_frag";
  self.grenadeAmmo = 3;

  self setEngagementMinDist(256.000000, 0.000000);
  self setEngagementMaxDist(768.000000, 1024.000000);

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\char_jap_makonly_rifle::main();
      break;
    case 1:
      character\char_jap_makonly_rifle_camo::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\char_jap_makonly_rifle::precache();
  character\char_jap_makonly_rifle_camo::precache();

  precacheItem("type99_rifle_bayonet");
  precacheItem("nambu");
  precacheItem("type97_frag");
}