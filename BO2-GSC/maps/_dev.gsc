/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dev.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  thread equipment_dev_gui();
  thread perk_dev_gui();
  thread testdvars();
}

testdvars() {
  wait 5;

  for(;;) {
    if(getDvar(#"scr_testdvar") != "") {
      break;
    }

    wait 1;
  }

  tokens = strtok(getDvar(#"scr_testdvar"), " ");
  dvarname = tokens[0];
  dvarvalue = tokens[1];
  setDvar(dvarname, dvarvalue);
  setDvar("scr_testdvar", "");
  thread testdvars();
}

equipment_dev_gui() {
  equipment = [];
  equipment[1] = "satchel_charge_sp";
  setDvar("scr_give_equipment", "");

  while(true) {
    wait 0.5;
    devgui_int = getdvarint(#"scr_give_equipment");

    if(devgui_int != 0) {
      players = get_players();

      for(i = 0; i < players.size; i++) {
        players[i] takeweapon(equipment[devgui_int]);
        players[i] giveweapon(equipment[devgui_int]);
        players[i] setactionslot(1, "weapon", equipment[devgui_int]);
      }

      setDvar("scr_give_equipment", "0");
    }
  }

}

perk_dev_gui() {
  setDvar("scr_give_perk", "");

  while(true) {
    wait 0.5;

    if(getDvar(#"scr_giveperk") != "") {
      players = get_players();

      for(i = 0; i < players.size; i++) {
        players[i] setperk(getDvar(#"scr_giveperk"));
      }

      setDvar("scr_giveperk", "");
    }
  }

}