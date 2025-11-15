/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_carentan.gsc
********************************/

main() {
  maps\mp\mp_carentan_precache::main();
  maps\createart\mp_carentan_art::main();
  maps\mp\mp_carentan_fx::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_carentan");
  level.airstrikeheightscale = 1.4;
  game["allies"] = "sas";
  game["axis"] = "russian";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "urban";
  game["axis_soldiertype"] = "urban";
  maps\mp\_global_fx_code::global_fx("ct_street_lamp_glow_FX_origin", "fx\misc\ct_street_lamp_glow", undefined, "light_street_lamp");
  maps\mp\_global_fx_code::global_fx("vent_small_FX_origin", "vfx\steam\steam_vent_small", undefined, "steam_vent_small");
  maps\mp\_global_fx_code::global_fx("utility_light_FX_origin", "vfx\lights\spotlight_yellow_mp_carentan", undefined, "light_utilities");
  maps\mp\_global_fx_code::global_fx("street_wall_light_FX_origin", "vfx\lights\light_spotlight_long_mp_carentan", undefined, "light_street_wall");
  maps\mp\_global_fx_code::global_fx("street_wall_light_sml_FX_origin", "vfx\lights\light_spotlight_mp_carentan", undefined, "light_street_wall_sml");
  maps\mp\_global_fx_code::global_fx("com_studio_light_FX_origin", "vfx\lights\light_studiolight_mp_carentan", undefined, "com_studio_light");
  setdvar("compassmaxrange", "2500");

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_med_carentanb";
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_med_carentanb";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_w_mid";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_med_carentanb";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_w_mid";
  }

  maps\mp\gametypes\_teams::setfactiontableoverride("marines", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_marines_night");
  maps\mp\gametypes\_teams::setfactiontableoverride("opfor", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_opfor_night");
  maps\mp\gametypes\_teams::setfactiontableoverride("sas", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_sas_night");
  maps\mp\gametypes\_teams::setfactiontableoverride("russian", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_russian_night");
  level.killconfirmeddogtagenemy = "h1_dogtag_enemy_animated_night";
  level.killconfirmeddogtagfriend = "h1_dogtag_friend_animated_night";
  level.bombsquadmodelc4 = "weapon_c4_bombsquad_mw1_night";
  level.bombsquadmodelclaymore = "weapon_claymore_bombsquad_mw1_night";
  level.oldschoolfxtype = "unlit";
}