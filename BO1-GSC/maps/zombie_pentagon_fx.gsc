/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_pentagon_fx.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  scriptedFX();
  footsteps();
  maps\createart\zombie_pentagon_art::main();
  maps\createfx\zombie_pentagon_fx::main();
  precacheFX();
}

footsteps() {}
scriptedFX() {
  level._effect["large_ceiling_dust"] = loadfx("maps/zombie/fx_dust_ceiling_impact_lg_mdbrown");
  level._effect["poltergeist"] = loadfx("misc/fx_zombie_couch_effect");
  level._effect["switch_sparks"] = loadfx("env/electrical/fx_elec_wire_spark_burst");
  level._effect["dog_breath"] = loadfx("maps/zombie/fx_zombie_dog_breath");
  level._effect["rise_burst"] = loadfx("maps/mp_maps/fx_mp_zombie_hand_dirt_burst");
  level._effect["rise_billow"] = loadfx("maps/mp_maps/fx_mp_zombie_body_dirt_billowing");
  level._effect["rise_dust"] = loadfx("maps/mp_maps/fx_mp_zombie_body_dust_falling");
  level._effect["lght_marker"] = Loadfx("maps/zombie/fx_zombie_coast_marker");
  level._effect["lght_marker_flare"] = Loadfx("maps/zombie/fx_zombie_coast_marker_fl");
  level._effect["electric_current"] = loadfx("misc/fx_zombie_elec_trail");
  level._effect["zapper_fx"] = loadfx("misc/fx_zombie_zapper_powerbox_on");
  level._effect["zapper"] = loadfx("misc/fx_zombie_electric_trap");
  level._effect["zapper_wall"] = loadfx("misc/fx_zombie_zapper_wall_control_on");
  level._effect["zapper_light_ready"] = loadfx("misc/fx_zombie_zapper_light_green");
  level._effect["zapper_light_notready"] = loadfx("misc/fx_zombie_zapper_light_red");
  level._effect["elec_md"] = loadfx("maps/zombie/fx_elec_player_md");
  level._effect["elec_sm"] = loadfx("maps/zombie/fx_elec_player_sm");
  level._effect["elec_torso"] = loadfx("maps/zombie/fx_elec_player_torso");
  level._effect["fire_trap_med"] = loadfx("maps/zombie/fx_zombie_fire_trap_med");
  level._effect["quad_grnd_dust_spwnr"] = loadfx("maps/zombie/fx_zombie_crawler_grnd_dust_spwnr");
  level._effect["minigun_pickup"] = LoadFX("misc/fx_zombie_powerup_solo_grab");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  level._effect["test_spin_fx"] = LoadFX("env/light/fx_light_warning");
}

precachefx() {
  level._effect["zombie_packapunch"] = loadfx("maps/zombie/fx_zombie_packapunch");
  level._effect["boxlight_light_ready"] = loadfx("maps/zombie/fx_zombie_theater_lightboard_green");
  level._effect["boxlight_light_notready"] = loadfx("maps/zombie/fx_zombie_theater_lightboard_red");
  level._effect["zombie_pentagon_teleporter"] = loadfx("maps/zombie/fx_zombie_portal_nix_num");
  level._effect["zombie_pent_portal_pack"] = loadfx("maps/zombie/fx_zombie_portal_nix_num_pp");
  level._effect["zombie_pent_portal_cool"] = loadfx("maps/zombie/fx_zombie_portal_nix_num_pp_fd");
  level._effect["fx_zombie_portal_corona_lg"] = loadfx("maps/zombie/fx_zombie_portal_corona_lg");
  level._effect["fx_zombie_portal_corona_sm"] = loadfx("maps/zombie/fx_zombie_portal_corona_sm");
  level._effect["transporter_beam"] = loadfx("maps/zombie/fx_transporter_beam");
  level._effect["transporter_start"] = loadfx("maps/zombie/fx_transporter_start");
  level._effect["glass_break"] = loadfx("maps/zombie/fx_zombie_window_break");
  level._effect["wall_break"] = loadfx("destructibles/fx_dest_wooden_crate");
  level._effect["fx_pent_cigar_smoke"] = LoadFX("maps/zombie/fx_zombie_cigar_tip_smoke");
  level._effect["fx_pent_cigarette_tip_smoke"] = LoadFX("maps/zombie/fx_zombie_cigarette_tip_smoke");
  level._effect["fx_glo_studio_light"] = LoadFX("maps/pentagon/fx_glo_studio_light");
  level._effect["fx_pent_tinhat_light"] = LoadFX("maps/pentagon/fx_pent_tinhat_light");
  level._effect["fx_pent_lamp_desk_light"] = LoadFX("maps/pentagon/fx_pent_lamp_desk_light");
  level._effect["fx_pent_security_camera"] = LoadFX("maps/pentagon/fx_pent_security_camera");
  level._effect["fx_pent_globe_projector"] = LoadFX("maps/zombie/fx_zombie_globe_projector");
  level._effect["fx_pent_globe_projector_blue"] = LoadFX("maps/zombie/fx_zombie_globe_projector_blue");
  level._effect["fx_pent_movie_projector"] = LoadFX("maps/pentagon/fx_pent_movie_projector");
  level._effect["fx_pent_tv_glow"] = LoadFX("maps/zombie/fx_zombie_tv_glow");
  level._effect["fx_pent_tv_glow_sm"] = LoadFX("maps/zombie/fx_zombie_tv_glow_sm");
  level._effect["fx_pent_smk_ambient_room"] = LoadFX("maps/pentagon/fx_pent_smk_ambient_room");
  level._effect["fx_pent_smk_ambient_room_lg"] = LoadFX("maps/zombie/fx_zombie_pent_smk_ambient_room_lg");
  level._effect["fx_pent_smk_ambient_room_sm"] = LoadFX("maps/pentagon/fx_pent_smk_ambient_room_sm");
  level._effect["fx_light_overhead_int_amber"] = loadfx("maps/zombie/fx_zombie_light_overhead_amber");
  level._effect["fx_light_overhead_int_amber_short"] = loadfx("maps/zombie/fx_zombie_light_overhead_amber_short");
  level._effect["fx_light_overhead_cool"] = loadfx("maps/zombie/fx_zombie_light_overhead_cool");
  level._effect["fx_light_floodlight_bright"] = loadfx("maps/zombie/fx_zombie_light_floodlight_bright");
  level._effect["fx_quad_vent_break"] = LoadFX("maps/zombie/fx_zombie_crawler_vent_break");
  level._effect["fx_smk_linger_lit"] = loadfx("maps/mp_maps/fx_mp_smk_linger");
  level._effect["fx_water_drip_light_long"] = loadfx("env/water/fx_water_drip_light_long");
  level._effect["fx_water_drip_light_short"] = loadfx("env/water/fx_water_drip_light_short");
  level._effect["fx_mp_blood_drip_short"] = loadfx("maps/mp_maps/fx_mp_blood_drip_short");
  level._effect["fx_pipe_steam_md"] = loadfx("env/smoke/fx_pipe_steam_md");
  level._effect["fx_mp_fumes_vent_sm_int"] = loadfx("maps/mp_maps/fx_mp_fumes_vent_sm_int");
  level._effect["fx_mp_fumes_vent_xsm_int"] = loadfx("maps/mp_maps/fx_mp_fumes_vent_xsm_int");
  level._effect["fx_zombie_light_glow_telephone"] = loadfx("maps/zombie/fx_zombie_light_glow_telephone");
  level._effect["fx_light_pent_ceiling_light"] = loadfx("env/light/fx_light_pent_ceiling_light");
  level._effect["fx_light_pent_ceiling_light_flkr"] = loadfx("env/light/fx_light_pent_ceiling_light_flkr");
  level._effect["fx_light_office_light_03"] = loadfx("env/light/fx_light_office_light_03");
  level._effect["fx_mp_light_dust_motes_md"] = loadfx("maps/zombie/fx_zombie_light_dust_motes_md");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_insects_maggots"] = loadfx("bio/insects/fx_insects_maggots_sm");
  level._effect["fx_mp_elec_spark_burst_xsm_thin_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin_runner");
  level._effect["fx_mp_elec_spark_burst_sm_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_sm_runner");
  level._effect["fx_interrog_morgue_mist"] = loadfx("maps/zombie/fx_zombie_morgue_mist");
  level._effect["fx_interrog_morgue_mist_falling"] = loadfx("maps/zombie/fx_zombie_morgue_mist_falling");
}