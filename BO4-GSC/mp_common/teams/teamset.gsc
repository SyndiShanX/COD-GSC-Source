/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset.gsc
***********************************************/

#namespace teamset;

init() {
  if(!isDefined(game.flagmodels)) {
    game.flagmodels = [];
  }

  if(!isDefined(game.carry_flagmodels)) {
    game.carry_flagmodels = [];
  }

  if(!isDefined(game.carry_icon)) {
    game.carry_icon = [];
  }

  game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}

customteam_init() {
  if(getdvarstring(#"g_customteamname_allies") != "") {
    setdvar(#"g_teamname_allies", getdvarstring(#"g_customteamname_allies"));
  }

  if(getdvarstring(#"g_customteamname_axis") != "") {
    setdvar(#"g_teamname_axis", getdvarstring(#"g_customteamname_axis"));
  }
}