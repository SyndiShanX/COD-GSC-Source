/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_seal_panama_launcher_base.gsc
*****************************************************/

#include codescripts\character;
#include character\c_usa_seal80s_heavy;
#include character\c_usa_seal80s_medium;
#include character\c_usa_seal80s_light;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "";
  self.footstepscriptcallback = 0;
  self.grenadeammo = 0;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "m1911_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "rpg_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  randchar = codescripts\character::get_random_character(3);

  switch (randchar) {
    case 0:
      character\c_usa_seal80s_heavy::main();
      break;
    case 1:
      character\c_usa_seal80s_medium::main();
      break;
    case 2:
      character\c_usa_seal80s_light::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_seal80s_heavy::precache();
  character\c_usa_seal80s_medium::precache();
  character\c_usa_seal80s_light::precache();
  precacheitem("rpg_sp");
  precacheitem("m1911_sp");
  precacheitem("frag_grenade_sp");
}