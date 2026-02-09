/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\teams\_teamset.gsc
**************************************/

init() {
  if(!isDefined(game["flagmodels"]))
    game["flagmodels"] = [];

  if(!isDefined(game["carry_flagmodels"]))
    game["carry_flagmodels"] = [];

  if(!isDefined(game["carry_icon"]))
    game["carry_icon"] = [];

  game["flagmodels"]["neutral"] = "mp_flag_neutral";
}

customteam_init() {
  if(getDvar(#"g_customTeamName_Allies") != "")
    setDvar("g_TeamName_Allies", getDvar(#"g_customTeamName_Allies"));

  if(getDvar(#"g_customTeamName_Axis") != "")
    setDvar("g_TeamName_Axis", getDvar(#"g_customTeamName_Axis"));
}