/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_bog.gsc
********************************/

main() {
  maps\mp\mp_bog_precache::main();
  maps\mp\mp_bog_fx::main();
  maps\createart\mp_bog_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_bog");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  setdvar("compassmaxrange", "1800");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_tonemapHighlightRange", 0);
  thread misc_rotate_ceilingfans();

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom_night";
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_night_bogb";
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom_night";
    level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red_night";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_night_bogb";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red_night";
    level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_w_night";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_night_bogb";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_w_night";
  } else if(level.gametype == "ctf")
    maps\mp\gametypes\ctf::flagbasefxdark();

  maps\mp\gametypes\_teams::setfactiontableoverride("marines", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_marines_night");
  maps\mp\gametypes\_teams::setfactiontableoverride("opfor", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_opfor_night");
  level.killconfirmeddogtagenemy = "h1_dogtag_enemy_animated_night";
  level.killconfirmeddogtagfriend = "h1_dogtag_friend_animated_night";
  level.bombsquadmodelc4 = "weapon_c4_bombsquad_mw1_night";
  level.bombsquadmodelclaymore = "weapon_claymore_bombsquad_mw1_night";
  level.oldschoolfxtype = "unlit";
  maps\mp\_utility::demolitiontriggermove((3559, 1308, 2), undefined, (357.835, 99.7969, 1.82364));
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin", "targetname"), ::ceilingfan_rotate_custom);
}

ceilingfan_rotate_custom() {
  var_0 = 50;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}