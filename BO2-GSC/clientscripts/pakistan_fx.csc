/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_fx.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\pakistan_fx;
#include clientscripts\_fx;

main() {
  clientscripts\createfx\pakistan_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();

  footsteps();
}

precache_scripted_fx() {
  level._effect["water_loop"] = loadfx("water/fx_water_pak_player_wake");
}

precache_createfx_fx() {
  level._effect["fx_pak_exp_door_breach_intro"] = loadfx("explosions/fx_pak_exp_door_breach_intro");
  level._effect["fx_pak_smk_breach_intro"] = loadfx("smoke/fx_pak_smk_breach_intro");
  level._effect["fx_claw_intro_bootup_water_splash"] = loadfx("maps/pakistan/fx_claw_intro_bootup_water_splash");
  level._effect["fx_market_ceiling_collapse"] = loadfx("maps/pakistan/fx_market_ceiling_collapse");
  level._effect["fx_market_ceiling_water_impact"] = loadfx("maps/pakistan/fx_market_ceiling_water_impact");
  level._effect["fx_car_smash_impact"] = loadfx("maps/pakistan/fx_car_smash_impact");
  level._effect["fx_bus_smash_impact_column"] = loadfx("maps/pakistan/fx_bus_smash_impact_column");
  level._effect["fx_bus_smash_impact_column_splash"] = loadfx("maps/pakistan/fx_bus_smash_impact_column_splash");
  level._effect["fx_bus_smash_impact"] = loadfx("maps/pakistan/fx_bus_smash_impact");
  level._effect["fx_bus_wall_collapse"] = loadfx("maps/pakistan/fx_bus_wall_collapse");
  level._effect["fx_pak_bus_dam_pole_splash"] = loadfx("maps/pakistan/fx_pak_bus_dam_pole_splash");
  level._effect["fx_pak_bus_dam_bus_splash_1"] = loadfx("maps/pakistan/fx_pak_bus_dam_bus_splash_1");
  level._effect["fx_pak_water_splash_area_sm"] = loadfx("water/fx_pak_water_splash_area_sm");
  level._effect["fx_pak_archway_stone_crumble"] = loadfx("dirt/fx_pak_archway_stone_crumble");
  level._effect["fx_pak_water_stone_splash_sm"] = loadfx("water/fx_pak_water_stone_splash_sm");
  level._effect["fx_archway_collapse"] = loadfx("maps/pakistan/fx_archway_collapse");
  level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
  level._effect["fx_pak_water_gush_over_bus"] = loadfx("water/fx_pak_water_gush_over_bus");
  level._effect["fx_car_smash_corner_impact"] = loadfx("maps/pakistan/fx_car_smash_corner_impact");
  level._effect["fx_pak_concrete_pillar_crumble"] = loadfx("dirt/fx_pak_concrete_pillar_crumble");
  level._effect["fx_balcony_collapse_wood"] = loadfx("maps/pakistan/fx_pak1_balcony_collapse_wood");
  level._effect["fx_pak_light_glow_sign_kashmir"] = loadfx("light/fx_pak_light_glow_sign_kashmir");
  level._effect["fx_sign_kashmir_sparks_01"] = loadfx("maps/pakistan/fx_sign_kashmir_sparks_01");
  level._effect["fx_sign_kashmir_sparks_02"] = loadfx("maps/pakistan/fx_sign_kashmir_sparks_02");
  level._effect["fx_sign_dangle_break"] = loadfx("maps/pakistan/fx_sign_dangle_break");
  level._effect["fx_bank_wall_collapse"] = loadfx("maps/pakistan/fx_bank_wall_collapse");
  level._effect["fx_bank_wall_collapse_splash"] = loadfx("maps/pakistan/fx_bank_wall_collapse_splash");
  level._effect["fx_bank_wall_collapse_spark"] = loadfx("maps/pakistan/fx_bank_wall_collapse_spark");
  level._effect["fx_pak_dest_shelving_unit"] = loadfx("destructibles/fx_pak_dest_shelving_unit");
  level._effect["fx_rain_light_loop"] = loadfx("weather/fx_rain_light_loop");
  level._effect["fx_water_pipe_spill_sm_thin_short"] = loadfx("water/fx_water_pipe_spill_sm_thin_short");
  level._effect["fx_water_pipe_spill_sm_thin_tall"] = loadfx("water/fx_water_pipe_spill_sm_thin_tall");
  level._effect["fx_water_spill_sm"] = loadfx("water/fx_water_spill_sm");
  level._effect["fx_water_spill_sm_splash"] = loadfx("water/fx_water_spill_sm_splash");
  level._effect["fx_water_roof_spill_sm"] = loadfx("water/fx_water_roof_spill_sm");
  level._effect["fx_water_roof_spill_md"] = loadfx("water/fx_water_roof_spill_md");
  level._effect["fx_water_roof_spill_lg"] = loadfx("water/fx_water_roof_spill_lg");
  level._effect["fx_rain_spatter_06x30"] = loadfx("water/fx_rain_spatter_06x30");
  level._effect["fx_rain_spatter_06x60"] = loadfx("water/fx_rain_spatter_06x60");
  level._effect["fx_rain_spatter_06x120"] = loadfx("water/fx_rain_spatter_06x120");
  level._effect["fx_rain_spatter_06x200"] = loadfx("water/fx_rain_spatter_06x200");
  level._effect["fx_rain_spatter_06x300"] = loadfx("water/fx_rain_spatter_06x300");
  level._effect["fx_rain_spatter_25x25"] = loadfx("water/fx_rain_spatter_25x25");
  level._effect["fx_rain_spatter_25x50"] = loadfx("water/fx_rain_spatter_25x50");
  level._effect["fx_rain_spatter_25x120"] = loadfx("water/fx_rain_spatter_25x120");
  level._effect["fx_rain_spatter_50x50"] = loadfx("water/fx_rain_spatter_50x50");
  level._effect["fx_rain_spatter_50x120"] = loadfx("water/fx_rain_spatter_50x120");
  level._effect["fx_rain_spatter_50x200"] = loadfx("water/fx_rain_spatter_50x200");
  level._effect["fx_pak_water_pipe_spill_wake"] = loadfx("water/fx_pak_water_pipe_spill_wake");
  level._effect["fx_water_spill_splash_wide"] = loadfx("water/fx_water_spill_splash_wide");
  level._effect["fx_water_drips_light_30_long"] = loadfx("water/fx_water_drips_light_30_long");
  level._effect["fx_water_drips_hvy_30"] = loadfx("water/fx_water_drips_hvy_30");
  level._effect["fx_water_drips_hvy_120"] = loadfx("water/fx_water_drips_hvy_120");
  level._effect["fx_water_drips_hvy_120_tall"] = loadfx("water/fx_water_drips_hvy_120_tall");
  level._effect["fx_water_drips_hvy_200"] = loadfx("water/fx_water_drips_hvy_200");
  level._effect["fx_water_drips_hvy_200_tall"] = loadfx("water/fx_water_drips_hvy_200_tall");
  level._effect["fx_pak_water_froth_md_calm"] = loadfx("water/fx_pak_water_froth_md_calm");
  level._effect["fx_pak_water_froth_sm_front"] = loadfx("water/fx_pak_water_froth_sm_front");
  level._effect["fx_pak_water_froth_pole"] = loadfx("water/fx_pak_water_froth_pole");
  level._effect["fx_pak_water_froth_left_calm"] = loadfx("water/fx_pak_water_froth_left_calm");
  level._effect["fx_pak_water_froth_left_calm_sm"] = loadfx("water/fx_pak_water_froth_left_calm_sm");
  level._effect["fx_pak_water_froth_right_calm"] = loadfx("water/fx_pak_water_froth_right_calm");
  level._effect["fx_pak_water_froth_right_calm_sm"] = loadfx("water/fx_pak_water_froth_right_calm_sm");
  level._effect["fx_pak_water_froth_pole_calm"] = loadfx("water/fx_pak_water_froth_pole_calm");
  level._effect["fx_pak_water_froth_column_calm"] = loadfx("water/fx_pak_water_froth_column_calm");
  level._effect["fx_drain_pipes_flow"] = loadfx("maps/pakistan/fx_drain_pipes_flow");
  level._effect["fx_drain_pipes_splash"] = loadfx("maps/pakistan/fx_drain_pipes_splash");
  level._effect["fx_pak_water_slide_base_splash"] = loadfx("water/fx_pak_water_slide_base_splash");
  level._effect["fx_water_drips_light_120_w_splash"] = loadfx("water/fx_water_drips_light_120_w_splash");
  level._effect["fx_pak_sewer_drain_splash_thin"] = loadfx("water/fx_pak_sewer_drain_splash_thin");
  level._effect["fx_water_debris_dist"] = loadfx("maps/pakistan/fx_water_debris_dist");
  level._effect["fx_pak_light_overhead"] = loadfx("light/fx_pak_light_overhead");
  level._effect["fx_pak_light_overhead_blink"] = loadfx("light/fx_pak_light_overhead_blink");
  level._effect["fx_pak_light_overhead_rain"] = loadfx("light/fx_pak_light_overhead_rain");
  level._effect["fx_pak_light_overhead_rain_top"] = loadfx("light/fx_pak_light_overhead_rain_top");
  level._effect["fx_pak_light_single_thick"] = loadfx("light/fx_pak_light_single_thick");
  level._effect["fx_pak_light_ray_street_rain"] = loadfx("light/fx_pak_light_ray_street_rain");
  level._effect["fx_pak_light_square_flood"] = loadfx("light/fx_pak_light_square_flood");
  level._effect["fx_pak_light_glow_sign_red"] = loadfx("light/fx_pak_light_glow_sign_red");
  level._effect["fx_pak_light_glow_sign_red_wide"] = loadfx("light/fx_pak_light_glow_sign_red_wide");
  level._effect["fx_pak_light_glow_sign_white"] = loadfx("light/fx_pak_light_glow_sign_white");
  level._effect["fx_pak_light_glow_sign_white_wide"] = loadfx("light/fx_pak_light_glow_sign_white_wide");
  level._effect["fx_pak_light_glow_sign_white_lg"] = loadfx("light/fx_pak_light_glow_sign_white_lg");
  level._effect["fx_pak_light_window_glow"] = loadfx("light/fx_pak_light_window_glow");
  level._effect["fx_pak_light_fluorescent"] = loadfx("light/fx_pak_light_fluorescent");
  level._effect["fx_pak_light_fluorescent_cage"] = loadfx("light/fx_pak_light_fluorescent_cage");
  level._effect["fx_pak_light_fluorescent_double"] = loadfx("light/fx_pak_light_fluorescent_double");
  level._effect["fx_pak_light_fluorescent_double_flare"] = loadfx("light/fx_pak_light_fluorescent_double_flare");
  level._effect["fx_pak_light_fluorescent_ceiling_panel"] = loadfx("light/fx_pak_light_fluorescent_ceiling_panel");
  level._effect["fx_pak_light_overhead_warm"] = loadfx("light/fx_pak_light_overhead_warm");
  level._effect["fx_pak_light_overhead_warm_blink"] = loadfx("light/fx_pak_light_overhead_warm_blink");
  level._effect["fx_pak_light_glow_sign_drugs"] = loadfx("light/fx_pak_light_glow_sign_drugs");
  level._effect["fx_light_recessed"] = loadfx("light/fx_light_recessed");
  level._effect["fx_pak_light_emergency_flood"] = loadfx("light/fx_pak_light_emergency_flood");
  level._effect["fx_pak_vlight_car_bank"] = loadfx("light/fx_pak_vlight_car_bank");
  level._effect["fx_pak_light_ray_grate_warm"] = loadfx("light/fx_pak_light_ray_grate_warm");
  level._effect["fx_light_dust_motes_sm"] = loadfx("light/fx_light_dust_motes_sm");
  level._effect["fx_light_dust_motes_xsm_short"] = loadfx("light/fx_light_dust_motes_xsm_short");
  level._effect["fx_light_dust_motes_xsm_wide"] = loadfx("light/fx_light_dust_motes_xsm_wide");
  level._effect["fx_pak_light_wall_cage"] = loadfx("light/fx_pak_light_wall_cage");
  level._effect["fx_pak_vlight_car_bank_rain"] = loadfx("light/fx_pak_vlight_car_bank_rain");
  level._effect["fx_pak_light_glow_sign_hotel"] = loadfx("light/fx_pak_light_glow_sign_hotel");
  level._effect["fx_pak_light_ray_md"] = loadfx("light/fx_pak_light_ray_md");
  level._effect["fx_pak_light_ray_md_streak"] = loadfx("light/fx_pak_light_ray_md_streak");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_pak_debri_papers"] = loadfx("debris/fx_paper_falling");
  level._effect["fx_elec_transformer_sparks_runner"] = loadfx("electrical/fx_elec_transformer_sparks_runner");
  level._effect["fx_pak_fog_low"] = loadfx("fog/fx_pak_fog_low");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_linger_lit_slow"] = loadfx("smoke/fx_smk_linger_lit_slow");
  level._effect["fx_smk_tin_hat_sm"] = loadfx("smoke/fx_smk_tin_hat_sm");
}

footsteps() {
}

toggle_water_fx_actor(localclientnum, set, newent) {
  if(set)
    self thread _play_water_fx_actor(localclientnum);
  else
    self _kill_water_fx_actor(localclientnum);
}

_play_water_fx_actor(localclientnum) {
  self notify("stop_water_fx");
  self endon("stop_water_fx");

  if(!isDefined(self.e_water_fx)) {
    self.e_water_fx = spawn(localclientnum, self.origin, "script_model");
    self.e_water_fx setmodel("tag_origin");
  }

  self.playing_water_fx = 0;

  if(!self isplayer())
    self thread play_water_fx_audio();

  while(isDefined(self)) {
    v_start = self.origin + vectorscale((0, 0, 1), 50.0);
    v_end = self.origin - vectorscale((0, 0, 1), 150.0);
    a_trace = bullettrace(v_start, v_end, 0, undefined);

    if(a_trace["surfacetype"] == "water") {
      self.e_water_fx.origin = a_trace["position"];

      if(!self.playing_water_fx) {
        self.n_water_fx_id = playfxontag(localclientnum, level._effect["water_loop"], self.e_water_fx, "tag_origin");
        self.playing_water_fx = 1;
      }
    } else if(self.playing_water_fx) {
      deletefx(localclientnum, self.n_water_fx_id, 0);
      self.playing_water_fx = 0;
    }

    wait 0.1;
  }
}

_kill_water_fx_actor(localclientnum) {
  self notify("stop_water_fx");

  if(isDefined(self.n_water_fx_id)) {
    deletefx(localclientnum, self.n_water_fx_id, 0);
    wait 2;
  }

  if(isDefined(self.e_water_fx))
    self.e_water_fx delete();
}

toggle_water_fx_model(localclientnum, set, newent) {
  if(set)
    self thread _play_water_fx_model(localclientnum);
  else
    self _kill_water_fx_model(localclientnum);
}

_play_water_fx_model(localclientnum) {
  self notify("stop_water_fx");
  self endon("stop_water_fx");

  if(!isDefined(self.e_water_fx)) {
    self.e_water_fx = spawn(localclientnum, self.origin, "script_model");
    self.e_water_fx setmodel("tag_origin");
  }

  n_fx_id = level._effect["frogger_wake_" + self.model];

  if(isDefined(n_fx_id))
    self.n_water_fx_id = playfxontag(localclientnum, n_fx_id, self.e_water_fx, "tag_origin");
  else
    return;

  while(isDefined(self)) {
    v_start = self.origin + vectorscale((0, 0, 1), 50.0);
    v_end = self.origin - vectorscale((0, 0, 1), 150.0);
    a_trace = bullettrace(v_start, v_end, 0, undefined);

    if(a_trace["surfacetype"] == "water") {
      self.e_water_fx.origin = a_trace["position"];
      self.e_water_fx.angles = self _get_frogger_movement_direction_angles();
    }

    wait 0.05;
  }
}

_get_frogger_movement_direction_angles() {
  v_angles = vectorscale((0, 1, 0), 90.0);
  return v_angles;
}

_kill_water_fx_model(localclientnum) {
  self notify("stop_water_fx");

  if(isDefined(self.n_water_fx_id)) {
    deletefx(localclientnum, self.n_water_fx_id, 0);
    wait 2;
  }

  if(isDefined(self.e_water_fx))
    self.e_water_fx delete();
}

play_water_fx_audio() {
  self endon("death");
  self endon("stop_water_fx");
  self endon("entityshutdown");
  self.e_water_fx endon("death");
  level endon("aS_off");
  level waittill("aS_on");
  self.e_water_fx thread shutoff_swimming_loops();

  while(isDefined(self) && isDefined(self.playing_water_fx)) {
    while(isDefined(self)) {
      if(self getspeed() > 50)
        self.e_water_fx playloopsound("chr_swimming_swim_loop_npc", 0.1);
      else
        self.e_water_fx playloopsound("chr_swimming_float_loop_npc", 0.1);

      wait 0.25;
    }

    self.e_water_fx stoploopsound(1);
    wait 0.25;
  }
}

shutoff_swimming_loops() {
  self endon("death");
  level waittill("aS_off");
  self stoploopsound(1);
}