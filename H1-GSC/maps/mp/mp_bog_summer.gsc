/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_bog_summer.gsc
********************************/

main() {
  maps\mp\mp_bog_summer_precache::main();
  maps\mp\mp_bog_summer_fx::main();
  maps\createart\mp_bog_summer_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_bog_summer");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  setdvar("compassmaxrange", "1800");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom";
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_bogsumrb";
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom";
    level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_bogsumrb";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red";
    level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_white";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_bogsumrb";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_white";
  }

  thread misc_rotate_ceilingfans();
  maps\mp\_utility::demolitiontriggermove((3559, 1308, 2), undefined, (357.835, 99.7969, 1.82364));
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin", "targetname"), ::ceilingfan_rotate_custom);
}

ceilingfan_rotate_custom() {
  var_0 = 500;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}