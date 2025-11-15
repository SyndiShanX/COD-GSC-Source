/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: core\gametypes\frontend_zm_bgb_chance.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#namespace zm_frontend_zm_bgb_chance;

function zm_frontend_bgb_slots_logic() {
  level thread zm_frontend_bgb_devgui();
}

function zm_frontend_bgb_devgui() {
  setdvar("", "");
  setdvar("", "");
  bgb_devgui_base = "";
  a_n_amounts = array(1, 5, 10, 100);
  for(i = 0; i < a_n_amounts.size; i++) {
    n_amount = a_n_amounts[i];
    adddebugcommand((((((bgb_devgui_base + i) + "") + n_amount) + "") + n_amount) + "");
  }
  adddebugcommand((((("" + "") + "") + "") + 1) + "");
  adddebugcommand((((("" + "") + "") + "") + 1) + "");
  level thread bgb_devgui_think();
}

function bgb_devgui_think() {
  b_powerboost_toggle = 0;
  b_successfail_toggle = 0;
  for(;;) {
    n_val_powerboost = getdvarstring("");
    n_val_successfail = getdvarstring("");
    if(n_val_powerboost != "") {
      b_powerboost_toggle = !b_powerboost_toggle;
      level clientfield::set("", b_powerboost_toggle);
      if(b_powerboost_toggle) {
        iprintlnbold("");
      } else {
        iprintlnbold("");
      }
    }
    if(n_val_successfail != "") {
      b_successfail_toggle = !b_successfail_toggle;
      level clientfield::set("", b_successfail_toggle);
      if(b_successfail_toggle) {
        iprintlnbold("");
      } else {
        iprintlnbold("");
      }
    }
    setdvar("", "");
    setdvar("", "");
    wait(0.5);
  }
}