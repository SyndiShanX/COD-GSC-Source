/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\angola_2_fx.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\angola_2_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_ango_heli_fire"] = loadfx("maps/angola/fx_ango_heli_fire");
  level._effect["fx_ango_fire_hut"] = loadfx("maps/angola/fx_ango_fire_hut");
  level._effect["fx_elec_ember_shower_os_int_runner"] = loadfx("electrical/fx_elec_ember_shower_os_int_runner");
  level._effect["fx_ango_fire_sm"] = loadfx("maps/angola/fx_ango_fire_sm");
  level._effect["fx_ango_fire_xsm"] = loadfx("maps/angola/fx_ango_fire_xsm");
  level._effect["fx_ango_falling_fire"] = loadfx("maps/angola/fx_ango_falling_fire");
  level._effect["fx_ango_godray_smoke_large"] = loadfx("maps/angola/fx_ango_godray_smoke_large");
  level._effect["fx_ango_godray_md"] = loadfx("maps/angola/fx_ango_godray_md");
  level._effect["fx_ango_godray_sml"] = loadfx("maps/angola/fx_ango_godray_sml");
  level._effect["fx_ango_godray_long"] = loadfx("maps/angola/fx_ango_godray_long");
  level._effect["fx_ango_falling_ash"] = loadfx("maps/angola/fx_ango_falling_ash");
  level._effect["fx_ango_steam_body"] = loadfx("maps/angola/fx_ango_steam_body");
  level._effect["fx_ango_lingering_dust_sml"] = loadfx("maps/angola/fx_ango_lingering_dust_sml");
  level._effect["fx_ango_waterfall_bottom"] = loadfx("maps/angola/fx_ango_waterfall_bottom");
  level._effect["fx_ango_water_ripples"] = loadfx("maps/angola/fx_ango_water_ripples");
  level._effect["fx_birds_circling"] = loadfx("bio/animals/fx_vultures_circling");
  level._effect["fx_ango_birds_circling_jungle"] = loadfx("maps/angola/fx_ango_birds_circling_jungle");
  level._effect["fx_ango_birds_runner"] = loadfx("maps/angola/fx_ango_birds_runner");
  level._effect["fx_ango_birds_runner_single"] = loadfx("maps/angola/fx_ango_birds_runner_single");
  level._effect["fx_ango_leaves_falling_exploder"] = loadfx("maps/angola/fx_ango_leaves_falling_exploder");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_leaves_falling_lite_sm"] = loadfx("maps/angola/fx_ango_leaves_falling");
  level._effect["fx_ango_grass_blowing"] = loadfx("maps/angola/fx_ango_grass_blowing");
  level._effect["fx_insects_dragonflies_ambient"] = loadfx("bio/insects/fx_insects_dragonflies_ambient");
  level._effect["fx_insects_butterfly_flutter"] = loadfx("bio/insects/fx_insects_butterfly_flutter");
  level._effect["fx_insects_moths_flutter"] = loadfx("bio/insects/fx_insects_moths_flutter");
  level._effect["fx_ango_river_wake_lrg"] = loadfx("maps/angola/fx_ango_river_wake_lrg");
  level._effect["fx_ango_river_wake_med"] = loadfx("maps/angola/fx_ango_river_wake_med");
  level._effect["fx_ango_river_wake_sml"] = loadfx("maps/angola/fx_ango_river_wake_sml");
  level._effect["fx_ango_exp_rock_wall"] = loadfx("maps/angola/fx_ango_exp_rock_wall");
  level._effect["fx_ango_exp_village_wall"] = loadfx("maps/angola/fx_ango_exp_village_wall");
  level._effect["fx_ango_exp_village_wall_2"] = loadfx("maps/angola/fx_ango_exp_village_wall_2");
  level._effect["fx_ango_exp_village_glass"] = loadfx("maps/angola/fx_ango_exp_village_glass");
  level._effect["fx_ango_exp_rock_water_impact"] = loadfx("maps/angola/fx_ango_exp_rock_water_impact");
  level._effect["fx_ango_exp_rock_dirt_impact"] = loadfx("maps/angola/fx_ango_exp_rock_dirt_impact");
  level._effect["fx_ango_waterfall_sm"] = loadfx("maps/angola/fx_ango_waterfall_sm");
  level._effect["fx_ango_waterfall_med"] = loadfx("maps/angola/fx_ango_waterfall_med");
  level._effect["fx_ango_water_splash_player"] = loadfx("maps/angola/fx_ango_water_splash_player");
  level._effect["fx_ango_shore_water"] = loadfx("maps/angola/fx_ango_shore_water");
  level._effect["fx_ango_water_barge_sink_ext"] = loadfx("maps/angola/fx_ango_water_barge_sink_ext");
  level._effect["fx_lf_angola2_sun1"] = loadfx("lens_flares/fx_lf_angola2_sun1");
  level._effect["fx_ango_stealth_mist"] = loadfx("maps/angola/fx_ango_stealth_mist");
  level._effect["fx_ango_birds_os"] = loadfx("maps/angola/fx_ango_birds_os");
  level._effect["fx_ango_heli_hut_crash"] = loadfx("maps/angola/fx_ango_heli_hut_crash");
  level._effect["fx_ango_watersplash_jungle"] = loadfx("maps/angola/fx_ango_watersplash_jungle");
  level._effect["fx_ango_heli_water_kickup_intro"] = loadfx("maps/angola/fx_ango_heli_water_kickup_intro");
  level._effect["fx_ango_radio_sparks"] = loadfx("maps/angola/fx_ango_radio_sparks");
  level._effect["fx_ango_outro_leaf_exploder"] = loadfx("maps/angola/fx_ango_outro_leaf_exploder");
  level._effect["fx_ango_outro_tree_foliage"] = loadfx("maps/angola/fx_ango_outro_tree_foliage");
  level._effect["fx_ango_outro_missile_foliage"] = loadfx("maps/angola/fx_ango_outro_missile_foliage");
  level._effect["fx_ango_outro_impact_foliage"] = loadfx("maps/angola/fx_ango_outro_impact_foliage");
  level._effect["fx_ango_outro_impact_tree"] = loadfx("maps/angola/fx_ango_outro_impact_tree");
  level._effect["fx_ango_heli_dust_outro"] = loadfx("maps/angola/fx_ango_heli_dust_outro");
  level._effect["fx_ango_river_fog"] = loadfx("maps/angola/fx_ango_river_fog");
  level._effect["fx_ango_river_fog_2"] = loadfx("maps/angola/fx_ango_river_fog_2");
  level._effect["fx_ango_river_intro_birds"] = loadfx("maps/angola/fx_ango_river_intro_birds");
  level._effect["fx_ango_river_intro_birds_near"] = loadfx("maps/angola/fx_ango_river_intro_birds_near");
  level._effect["fx_ango_river_waterfall_giant"] = loadfx("maps/angola/fx_ango_river_waterfall_giant");
  level._effect["fx_ango_river_waterfall_giant_2"] = loadfx("maps/angola/fx_ango_river_waterfall_giant_2");
  level._effect["fx_ango_water_woods"] = loadfx("maps/angola/fx_ango_water_woods");
}

main() {
  clientscripts\createfx\angola_2_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}