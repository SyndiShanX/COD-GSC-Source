/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\teams\_teamset.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace _teamset;

function init() {
  if(!isDefined(game["flagmodels"])) {
    game["flagmodels"] = [];
  }
  if(!isDefined(game["carry_flagmodels"])) {
    game["carry_flagmodels"] = [];
  }
  if(!isDefined(game["carry_icon"])) {
    game["carry_icon"] = [];
  }
  game["flagmodels"]["neutral"] = "p7_mp_flag_neutral";
}

function customteam_init() {
  if(getdvarstring("g_customTeamName_Allies") != "") {
    setdvar("g_TeamName_Allies", getdvarstring("g_customTeamName_Allies"));
  }
  if(getdvarstring("g_customTeamName_Axis") != "") {
    setdvar("g_TeamName_Axis", getdvarstring("g_customTeamName_Axis"));
  }
}