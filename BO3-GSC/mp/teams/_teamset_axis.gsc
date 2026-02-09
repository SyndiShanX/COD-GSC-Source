/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\teams\_teamset_axis.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\teams\_teamset;
#namespace _teamset_axis;

function main() {
  init("axis");
  _teamset::customteam_init();
  precache();
}

function init(team) {
  _teamset::init();
  game[team] = "axis";
  game["defenders"] = team;
  game["entity_headicon_" + team] = "faction_axis";
  game["headicon_" + team] = "faction_axis";
  level.teamprefix[team] = "vox_pm";
  level.teampostfix[team] = "axis";
  setDvar("g_TeamName_" + team, &"MPUI_AXIS_SHORT");
  setDvar("g_FactionName_" + team, "axis");
  game["strings"][team + "_win"] = &"MP_CDP_WIN_MATCH";
  game["strings"][team + "_win_round"] = &"MP_CDP_WIN_ROUND";
  game["strings"][team + "_mission_accomplished"] = &"MP_CDP_MISSION_ACCOMPLISHED";
  game["strings"][team + "_eliminated"] = &"MP_CDP_ELIMINATED";
  game["strings"][team + "_forfeited"] = &"MP_CDP_FORFEITED";
  game["strings"][team + "_name"] = &"MP_CDP_NAME";
  game["music"]["spawn_" + team] = "SPAWN_PMC";
  game["music"]["spawn_short" + team] = "SPAWN_SHORT_PMC";
  game["music"]["victory_" + team] = "VICTORY_PMC";
  game["icons"][team] = "faction_axis";
  game["voice"][team] = "vox_pmc_";
  setDvar("scr_" + team, "ussr");
  level.heli_vo[team]["hit"] = "vox_rus_0_kls_attackheli_hit";
  game["flagmodels"][team] = "p7_mp_flag_axis";
  game["carry_flagmodels"][team] = "p7_mp_flag_axis_carry";
  game["flagmodels"]["neutral"] = "p7_mp_flag_neutral";
}

function precache() {}