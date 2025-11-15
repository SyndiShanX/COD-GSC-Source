/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\ally_navy_blackout_wounded.csc
*************************************************************************/

#include character\clientscripts\c_usa_navy_wounded_1;
#include character\clientscripts\c_usa_navy_wounded_2;
#include character\clientscripts\c_usa_navy_wounded_3;
#include character\clientscripts\c_usa_navy_wounded_4;

main() {
  switch (self getcharacterindex()) {
    case 0:
      character\clientscripts\c_usa_navy_wounded_1::main();
      break;
    case 1:
      character\clientscripts\c_usa_navy_wounded_2::main();
      break;
    case 2:
      character\clientscripts\c_usa_navy_wounded_3::main();
      break;
    case 3:
      character\clientscripts\c_usa_navy_wounded_4::main();
      break;
  }

  self._aitype = "Ally_Navy_Blackout_Wounded";
}

precache(ai_index) {
  character\clientscripts\c_usa_navy_wounded_1::precache();
  character\clientscripts\c_usa_navy_wounded_2::precache();
  character\clientscripts\c_usa_navy_wounded_3::precache();
  character\clientscripts\c_usa_navy_wounded_4::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}