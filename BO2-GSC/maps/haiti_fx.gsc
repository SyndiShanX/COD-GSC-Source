/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_fx.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\createfx\haiti_fx;
#include maps\haiti_anim;
#include maps\haiti;

main() {
  precache_fxanim_props();
  precache_scripted_fx();
  precache_createfx_fx();
  wind_init();
  maps\createfx\haiti_fx::main();
}

precache_scripted_fx() {
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["light_flare1"] = loadfx("maps/haiti/fx_haiti_light_flare1");
  level._effect["jetwing_whoosh"] = loadfx("maps/haiti/fx_player_booster");
  level._effect["vtol_explode_intro"] = loadfx("maps/haiti/fx_haiti_vtol_exp1");
  level._effect["vtol_explode_fxanim1"] = loadfx("maps/haiti/fx_haiti_vtol_exp1_falling");
  level._effect["vtol_explode_fxanim2"] = loadfx("maps/haiti/fx_haiti_vtol_exp2_falling");
  level._effect["flak_explode"] = loadfx("maps/haiti/fx_haiti_flak_single_sm_local_immediate");
  level._effect["vtol_trail_cheap"] = loadfx("maps/haiti/fx_haiti_vtol_debris_pieces_trail2");
  level._effect["vtol_trail_cheap_nosmoke"] = loadfx("maps/haiti/fx_haiti_vtol_debris_pieces_trail3");
  level._effect["vtol_trail_local"] = loadfx("maps/haiti/fx_haiti_flametrail_lg_local");
  level._effect["aa_fire"] = loadfx("maps/haiti/fx_haiti_aa1");
  level._effect["sam_explode_cheap"] = loadfx("maps/haiti/fx_haiti_sam_exp1_cheap");
  level._effect["vtol_flock"] = loadfx("maps/haiti/fx_haiti_vtols_flock");
  level._effect["air_battle_1"] = loadfx("maps/haiti/fx_haiti_ambient_battle1");
  level._effect["vtol_exhaust"] = loadfx("maps/haiti/fx_haiti_vtol_exhaust_custom");
  level._effect["quadrotor_death"] = loadfx("destructibles/fx_quadrotor_death01");
  level._effect["cloud_spawner"] = loadfx("maps/haiti/fx_haiti_cloud__defined_puff1_spawner");
  level._effect["cloud_spawner_left"] = loadfx("maps/haiti/fx_haiti_cloud__defined_puff1_spawner");
  level._effect["cloud_spawner_right"] = loadfx("maps/haiti/fx_haiti_cloud__defined_puff1_spawner");
  level._effect["cloud_locked"] = loadfx("maps/haiti/fx_haiti_cloud_defined_puff_locked1");
  level._effect["cloud_locked_right"] = loadfx("maps/haiti/fx_haiti_cloud_defined_puff1_bb");
  level._effect["cloud_locked_left"] = loadfx("maps/haiti/fx_haiti_cloud_defined_puff1_bb");
  level._effect["missile_trail"] = loadfx("maps/haiti/fx_haiti_rocket_trail_custom2_child");
  level._effect["jetwing_hero_exhaust"] = loadfx("maps/haiti/fx_haiti_jetpack1");
  level._effect["vtol_chaff"] = loadfx("maps/haiti/fx_haiti_chaff");
  level._effect["wire_sparks"] = loadfx("maps/haiti/fx_haiti_intro_wire_sparks");
  level._effect["vtol_lights"] = loadfx("maps/haiti/fx_haiti_vtol_lights");
  level._effect["vtol_exhaust_cheap"] = loadfx("maps/haiti/fx_haiti_vtol_exhaust_custom_cheap");
  level._effect["laser_turret_shoot"] = loadfx("lens_flares/fx_lf_haiti_targeter");
  level._effect["crash_vtol_trail"] = loadfx("maps/haiti/fx_haiti_vtol_trail_plaza");
  level._effect["camo_transition"] = loadfx("misc/fx_camo_reveal_transition");
  level._effect["sco_smoke"] = loadfx("maps/haiti/fx_haiti_smoke_marker_yellow");
  level._effect["emergency_light"] = loadfx("maps/haiti/fx_haiti_end_emergency_light");
  level._effect["cutter_on"] = loadfx("props/fx_laser_cutter_on");
  level._effect["cutter_spark"] = loadfx("props/fx_laser_cutter_sparking");
  level._effect["headshot"] = loadfx("maps/haiti/fx_menendez_headshot");
  level._effect["headshot_decal"] = loadfx("maps/haiti/fx_menendez_headshot_decal");
  level._effect["fx_harper_decal"] = loadfx("maps/haiti/fx_haiti_harper_decal");
  level._effect["muzzle_flash"] = loadfx("maps/haiti/fx_haiti_muzzle_flash_menendez_death");
  level._effect["player_shot_blood"] = loadfx("maps/haiti/fx_player_shot_blood");
  level._effect["player_shot_blood2"] = loadfx("maps/haiti/fx_player_shot_blood2");
  level._effect["menendez_body_decal"] = loadfx("maps/haiti/fx_haiti_end_menendez_body_decal");
  level._effect["menendez_knife_stab"] = loadfx("maps/haiti/fx_menendez_knife_stab");
  level._effect["harper_blood_spurt"] = loadfx("maps/haiti/fx_harper_blood_spurt");
  level._effect["vtol_spotlight"] = loadfx("maps/haiti/fx_haiti_end_vtol_spotlight");
  level._effect["end_vtol_exhaust"] = loadfx("vehicle/exhaust/fx_exhaust_future_heli_vtol_single_d");
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
  level._effect["crash_vtol_trail"] = loadfx("maps/haiti/fx_haiti_vtol_trail_plaza");
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

wind_init() {
  setsaveddvar("wind_global_vector", "0 -300 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

#using_animtree("fxanim_props");

precache_fxanim_props() {
  level.scr_anim["fxanim_props"]["jetpack_vtol_explode_1"] = % fxanim_haiti_jetpack_vtol_01_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_explode_2"] = % fxanim_haiti_jetpack_vtol_02_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_explode_3"] = % fxanim_haiti_jetpack_vtol_03_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_explode_4"] = % fxanim_haiti_jetpack_vtol_04_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_debris_1"] = % fxanim_haiti_jetpack_vtol_debris_01_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_debris_2"] = % fxanim_haiti_jetpack_vtol_debris_02_anim;
  level.scr_anim["fxanim_props"]["jetpack_vtol_debris_3"] = % fxanim_haiti_jetpack_vtol_debris_03_anim;
  level.scr_anim["fxanim_props"]["vtol_int_close"] = % fxanim_haiti_vtol_int_close_idle_anim;
  level.scr_anim["fxanim_props"]["vtol_int_open_idle"] = % fxanim_haiti_vtol_int_open_idle_anim;
  level.scr_anim["fxanim_props"]["vtol_int_hit_idle"] = % fxanim_haiti_vtol_int_hit_idle_anim;
  level.scr_anim["fxanim_props"]["vtol_int_door_close"] = % fxanim_haiti_vtol_int_door_close_idle_anim;
  level.scr_anim["fxanim_props"]["vtol_int_door_open"] = % fxanim_haiti_vtol_int_door_open_anim;
  level.scr_anim["fxanim_props"]["vtol_int_door_open_idle"] = % fxanim_haiti_vtol_int_door_open_idle_anim;
  level.scr_anim["fxanim_props"]["vtol_int_debris"] = % fxanim_haiti_vtol_int_debris_anim;
  level.scr_anim["fxanim_props"]["closet_bomb"] = % fxanim_haiti_closet_bomb_anim;
  level.scr_anim["fxanim_props"]["apc_wall_divider_veh"] = % fxanim_haiti_apc_wall_divider_veh_anim;
  level.scr_anim["fxanim_props"]["apc_wall_divider"] = % fxanim_haiti_apc_wall_divider_anim;
  level.scr_anim["fxanim_props"]["parachutes_amb_wall"] = % fxanim_gp_parachute_amb_wall_anim;
  level.scr_anim["fxanim_props"]["parachutes_amb_corner"] = % fxanim_gp_parachute_amb_corner_anim;
  level.scr_anim["fxanim_props"]["catwalk_vtol"] = % fxanim_haiti_catwalk_vtol_anim;
  level.scr_anim["fxanim_props"]["catwalk_collapse"] = % fxanim_haiti_catwalk_anim;
  level.scr_anim["fxanim_props"]["catwalk_base"] = % fxanim_haiti_catwalk_base_anim;
  level.scr_anim["fxanim_props"]["ceiling_collapse_gp"] = % fxanim_haiti_ceiling_collapse_gp_anim;
  level.scr_anim["fxanim_props"]["stairwell_ceiling"] = % fxanim_haiti_stairwell_ceiling_anim;
  level.scr_anim["fxanim_props"]["ddm_ceiling"] = % fxanim_haiti_ddm_ceiling_anim;
  level.scr_anim["fxanim_props"]["emergency_light"] = % fxanim_gp_blk_emergency_light_anim;
  level.scr_anim["fxanim_props"]["floor_collapse"] = % fxanim_haiti_floor_collapse_anim;
  level.scr_anim["fxanim_props"]["floor_collapse_props"] = % fxanim_haiti_floor_collapse_props_anim;
  addnotetrack_fxontag("fxanim_props", "jetpack_vtol_explode_2", "exploder 10125 #two_vtols_collide", "vtol_explode_fxanim2", "tag_engine_l_link_jnt");
}

createfx_setup() {
  maps\haiti_anim::intro_anims();
  maps\haiti_anim::front_door_anims();
  maps\haiti_anim::endings_anims();
  level.skipto_point = tolower(getdvar(#"_id_1BEC029F"));

  if(level.skipto_point == "")
    level.skipto_point = "e1_intro";

  maps\haiti::load_gumps();
  level thread createfx_control_room_closet();
}

createfx_control_room_closet() {
  a_m_destroyed = getentarray("control_room_destroyed", "targetname");

  foreach(m_destroyed in a_m_destroyed)
  m_destroyed hide();

  m_door = getent("trappedinthecloset", "targetname");
  m_door delete();
  level waittill("bomb_exploded");

  foreach(m_destroyed in a_m_destroyed)
  m_destroyed show();

  a_m_clean = getentarray("control_room_clean", "targetname");

  foreach(m_clean in a_m_clean)
  m_clean delete();
}