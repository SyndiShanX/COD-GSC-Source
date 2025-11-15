/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\haiti_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\haiti_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_haiti_smk_closet_exp"] = loadfx("smoke/fx_haiti_smk_closet_exp");
  level._effect["fx_flak_single_sm_spawner"] = loadfx("maps/haiti/fx_haiti_flak_single_sm_spawner");
  level._effect["fx_flak_single_sm_spawner_short"] = loadfx("maps/haiti/fx_haiti_flak_single_sm_spawner_short");
  level._effect["fx_fast_embers_md"] = loadfx("maps/haiti/fx_haiti_fast_embers_md");
  level._effect["fx_fast_fire_md"] = loadfx("maps/haiti/fx_haiti_fast_fire_md");
  level._effect["fx_fast_sparks_runner"] = loadfx("maps/haiti/fx_haiti_fast_sparks_runner");
  level._effect["fx_debris_atplayer"] = loadfx("maps/haiti/fx_haiti_debris_atplayer");
  level._effect["fx_vtol_explode_player"] = loadfx("maps/haiti/fx_haiti_vtol_exp_player");
  level._effect["fx_lf_haiti_sun1"] = loadfx("lens_flares/fx_lf_haiti_sun1");
  level._effect["fx_lf_haiti_sun1_infinite"] = loadfx("lens_flares/fx_lf_haiti_sun1_infinite");
  level._effect["fx_fast_dust_md"] = loadfx("maps/haiti/fx_haiti_fast_dust_md");
  level._effect["fx_fast_dust_sm"] = loadfx("maps/haiti/fx_haiti_fast_dust_sm");
  level._effect["fx_ash_2000x1000"] = loadfx("maps/haiti/fx_haiti_ash_2000x1000");
  level._effect["fx_end_sliding_door_explosion"] = loadfx("maps/haiti/fx_haiti_end_sliding_door_explosion");
  level._effect["fx_end_sliding_door_explosion_follow"] = loadfx("maps/haiti/fx_haiti_end_sliding_door_explosion_follow");
  level._effect["fx_end_collapse_debris"] = loadfx("maps/haiti/fx_haiti_end_collapse_debris");
  level._effect["fx_end_fire_dropper"] = loadfx("maps/haiti/fx_haiti_end_fire_dropper");
  level._effect["fx_computer_fire_dropper"] = loadfx("maps/haiti/fx_haiti_computer_fire_dropper");
  level._effect["fx_spot_light_intro"] = loadfx("maps/haiti/fx_haiti_spot_light_intro");
  level._effect["fx_fire_sm_smolder"] = loadfx("maps/karma/fx_kar_fire_sm_smolder");
  level._effect["fx_embers_falling_sm"] = loadfx("env/fire/fx_embers_falling_sm");
  level._effect["fx_fire_xsm"] = loadfx("maps/karma/fx_kar_fire_xsm");
  level._effect["fx_fire_line_sm"] = loadfx("maps/karma/fx_kar_fire_line_sm");
  level._effect["fx_computer_fire_line_xsm"] = loadfx("maps/haiti/fx_haiti_computer_fire_line_xsm");
  level._effect["fx_trailer_smoke_custom1"] = loadfx("maps/haiti/fx_haiti_trailer_smoke_custom1");
  level._effect["fx_elec_spark_runner_sm"] = loadfx("electrical/fx_la2_elec_spark_runner_sm");
  level._effect["fx_ember_bed_md"] = loadfx("maps/haiti/fx_haiti_ember_bed_md");
  level._effect["fx_vehicle_fire1"] = loadfx("maps/haiti/fx_haiti_vehicle_fire1");
  level._effect["fx_vehicle_fire2"] = loadfx("maps/haiti/fx_haiti_vehicle_fire2");
  level._effect["fx_rubble_smolder_md"] = loadfx("maps/haiti/fx_haiti_rubble_smolder_md");
  level._effect["fx_rocks_impact"] = loadfx("maps/haiti/fx_haiti_rocks_impact");
  level._effect["fx_wall_crash"] = loadfx("maps/haiti/fx_haiti_wall_crash");
  level._effect["fx_vtol_pillar_dest"] = loadfx("maps/haiti/fx_haiti_vtol_pillar_dest");
  level._effect["fx_vtol_crash"] = loadfx("maps/haiti/fx_haiti_vtol_crash");
  level._effect["fx_catwalk_impact1"] = loadfx("maps/haiti/fx_haiti_catwalk_impact1");
  level._effect["fx_bridge_dust"] = loadfx("maps/haiti/fx_haiti_bridge_dust");
  level._effect["fx_catwalk_crack"] = loadfx("maps/haiti/fx_haiti_catwalk_crack");
  level._effect["fx_aa1_approach"] = loadfx("maps/haiti/fx_haiti_aa1_approach_parent");
  level._effect["fx_aa2_approach"] = loadfx("maps/haiti/fx_haiti_aa2_approach");
  level._effect["fx_rocket_trail_custom2_approach_parent"] = loadfx("maps/haiti/fx_haiti_rocket_trail_custom2_approach_parent");
  level._effect["fx_smoke_pillar_approach"] = loadfx("maps/haiti/fx_haiti_smoke_pillar_approach");
  level._effect["fx_smoke_pillar_approach_md"] = loadfx("maps/haiti/fx_haiti_smoke_pillar_approach_md");
  level._effect["fx_smoke_pillar_approach_sm"] = loadfx("maps/haiti/fx_haiti_smoke_pillar_approach_sm");
  level._effect["fx_smoke_pillar_approach_xsm"] = loadfx("maps/haiti/fx_haiti_smoke_pillar_approach_xsm");
  level._effect["fx_player_vtol_hit_sparks"] = loadfx("maps/haiti/fx_haiti_player_vtol_hit_sparks");
  level._effect["fx_smolder_steam_field"] = loadfx("maps/haiti/fx_haiti_smolder_steam_field");
  level._effect["fx_closet_explosion"] = loadfx("maps/haiti/fx_haiti_closet_explosion");
  level._effect["fx_hallway_exp1"] = loadfx("maps/haiti/fx_haiti_hallway_exp1");
  level._effect["fx_hallway_exp2"] = loadfx("maps/haiti/fx_haiti_hallway_exp2");
  level._effect["fx_hallway_exp3"] = loadfx("maps/haiti/fx_haiti_hallway_exp3");
  level._effect["fx_hallway_exp4"] = loadfx("maps/haiti/fx_haiti_hallway_exp4");
  level._effect["fx_hallway_exp5"] = loadfx("maps/haiti/fx_haiti_hallway_exp5");
  level._effect["fx_hallway_exp6"] = loadfx("maps/haiti/fx_haiti_hallway_exp6");
  level._effect["fx_hallway_exp7"] = loadfx("maps/haiti/fx_haiti_hallway_exp7");
  level._effect["fx_hallway_exp8"] = loadfx("maps/haiti/fx_haiti_hallway_exp8");
  level._effect["fx_steam_pipe1"] = loadfx("maps/haiti/fx_haiti_steam_pipe1");
  level._effect["fx_steam_vent1"] = loadfx("maps/haiti/fx_haiti_steam_vent1");
  level._effect["fx_mist1"] = loadfx("maps/haiti/fx_haiti_mist1");
  level._effect["fx_end_chamber_steam"] = loadfx("maps/haiti/fx_haiti_end_chamber_steam");
  level._effect["fx_end_chamber_spark_runner"] = loadfx("maps/haiti/fx_haiti_end_chamber_spark_runner");
  level._effect["fx_end_fire_pillar1"] = loadfx("maps/haiti/fx_haiti_end_fire_pillar1");
  level._effect["fx_menendez_headshot_decal"] = loadfx("maps/haiti/fx_menendez_headshot_decal");
  level._effect["fx_harper_decal"] = loadfx("maps/haiti/fx_haiti_harper_decal");
  level._effect["fx_intro_collision_sparks"] = loadfx("maps/haiti/fx_haiti_intro_collision_sparks");
  level._effect["fx_intro_vtol_dust"] = loadfx("maps/haiti/fx_haiti_vtol_dust");
  level._effect["fx_light_sphere_green"] = loadfx("maps/haiti/fx_haiti_light_sphere_green");
  level._effect["fx_light_sphere_red"] = loadfx("maps/haiti/fx_haiti_light_sphere_red");
  level._effect["fx_cloud_cover"] = loadfx("maps/haiti/fx_haiti_cloud_cover");
  level._effect["fx_end_spot_light_sun"] = loadfx("maps/haiti/fx_haiti_end_spot_light_sun");
  level._effect["fx_end_flame_falling"] = loadfx("maps/haiti/fx_haiti_end_flame_falling");
  level._effect["fx_end_embers_full"] = loadfx("maps/haiti/fx_haiti_end_embers_full");
  level._effect["fx_interior_gray_xlg"] = loadfx("maps/haiti/fx_haiti_interior_gray_xlg");
  level._effect["fx_vtol_rotorwash"] = loadfx("maps/haiti/fx_haiti_vtol_rotorwash");
  level._effect["fx_light_spot_flare"] = loadfx("lens_flares/fx_lf_haiti_light_spot_flare");
}

main() {
  clientscripts\createfx\haiti_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}