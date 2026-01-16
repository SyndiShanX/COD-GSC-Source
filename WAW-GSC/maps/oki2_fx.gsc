/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki2_fx.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  maps\createart\oki2_art::main();
  precachefx();
  spawnfx();
  footsteps();
  level thread water_drops_init(50);
  thread weather_settings();
}

weather_settings() {
  SetSavedDvar("wind_global_vector", "0 -220 0");
  SetSavedDvar("wind_global_low_altitude", -1000);
  SetSavedDvar("wind_global_hi_altitude", 1000);
  SetSavedDvar("wind_global_low_strength_percent", 0.1);
}

footsteps() {
  animscripts\utility::setFootstepEffect("asphalt", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("brick", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("carpet", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("cloth", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("concrete", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("dirt", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("foliage", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("gravel", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("grass", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("ice", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("metal", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("mud", LoadFx("bio/player/fx_footstep_mud"));
  animscripts\utility::setFootstepEffect("paper", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("plaster", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("rock", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("sand", LoadFx("bio/player/fx_footstep_sand"));
  animscripts\utility::setFootstepEffect("water", LoadFx("bio/player/fx_footstep_water"));
  animscripts\utility::setFootstepEffect("wood", LoadFx("bio/player/fx_footstep_dust"));
  animscripts\utility::setFootstepEffect("fire", LoadFx("bio/player/fx_footstep_fire"));
}

precacheFX() {
  level.mortar = loadfx("weapon/mortar/fx_mortar_exp_mud_medium");
  level._effect["tracerfire"] = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
  level._effect["falling_rocks"] = loadfx("maps/oki2/fx_artillery_strike_falling_rocks");
  level._effect["arty_strike_rock"] = loadfx("weapon/artillery/fx_artillery_exp_strike_rock");
  level._effect["rain"] = loadfx("env/weather/fx_rain_lght");
  level._effect["gunsmoke"] = loadfx("env/smoke/thin_black_smoke_M");
  level._effect["gunflash"] = loadfx("weapon/artillery/fx_artillery_jap_200mm_no_smoke");
  level._effect["flesh_hit"] = LoadFX("impacts/flesh_hit");
  level._effect["sniper_leaf_loop"] = loadfx("destructibles/fx_dest_tree_palm_snipe_leaf01");
  level._effect["sniper_leaf_canned"] = loadfx("destructibles/fx_dest_tree_palm_snipe_leaf02");
  level._effect["character_fire_pain_sm"] = loadfx("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = loadfx("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = loadfx("env/fire/fx_fire_player_torso");
  level._effect["rocket_launch"] = loadfx("weapon/rocket/fx_LCI_rocket_ignite_launch");
  level._effect["rocket_trail"] = loadfx("weapon/rocket/fx_lci_rocket_geotrail");
  level._effect["lci_rocket_impact"] = loadfx("weapon/rocket/fx_lci_rocket_explosion_mud");
  level._effect["default_explosion"] = loadfx("explosions/default_explosion");
  level._effect["flame_death1"] = loadfx("env/fire/fx_fire_player_sm");
  level._effect["flame_death2"] = loadfx("env/fire/fx_fire_player_torso");
  level._effect["flame_death3"] = loadfx("env/fire/fx_fire_player_sm");
  level._effect["a_cave_drip"] = loadfx("maps/oki2/fx_rain_drip_cave_tunnel");
  level._effect["a_entrance_drip"] = loadfx("maps/oki2/fx_drip_entrance");
  level._effect["a_cave_entrance_drip"] = loadfx("maps/oki2/fx_rain_drip_cave_entrance");
  level._effect["a_wtrfall_sm"] = loadfx("env/water/fx_wtrfall_sm");
  level._effect["a_wtrfall_splash_sm"] = loadfx("env/water/fx_wtrfall_splash_sm");
  level._effect["a_wtrfall_splash_sm_puddle"] = loadfx("env/water/fx_wtrfall_splash_sm_puddle");
  level._effect["a_wtrfall_md"] = loadfx("env/water/fx_wtrfall_md");
  level._effect["a_wtr_spill_sm"] = loadfx("env/water/fx_wtr_spill_sm");
  level._effect["a_wtr_spill_sm_int"] = loadfx("env/water/fx_wtr_spill_sm_int");
  level._effect["a_wtr_spill_sm_splash"] = loadfx("env/water/fx_wtr_spill_sm_splash");
  level._effect["a_wtr_spill_sm_splash_puddle"] = loadfx("env/water/fx_wtr_spill_sm_splash_puddle");
  level._effect["a_wtr_flow_sm"] = loadfx("env/water/fx_wtr_flow_sm");
  level._effect["a_wtr_flow_md"] = loadfx("env/water/fx_wtr_flow_md");
  level._effect["a_water_wake_flow_sm"] = loadfx("env/water/fx_water_wake_flow_sm");
  level._effect["a_water_wake_flow_md"] = loadfx("env/water/fx_water_wake_flow_md");
  level._effect["a_water_ripple"] = loadfx("env/water/fx_water_splash_ripple_puddle");
  level._effect["a_water_ripple_md"] = loadfx("env/water/fx_water_splash_ripple_puddle_med");
  level._effect["a_water_ripple_aisle"] = loadfx("env/water/fx_water_splash_ripple_puddle_aisle");
  level._effect["a_water_ripple_line"] = loadfx("env/water/fx_water_splash_ripple_line");
  level._effect["a_rain_cave_ceiling_hole"] = loadfx("maps/oki2/fx_rain_cave_ceiling_hole");
  level._effect["bunker_explosion"] = loadfx("maps/oki2/fx_explo_bunker_window");
  level._effect["bunker_side_explosion"] = loadfx("maps/oki2/fx_explo_bunker_side");
  level._effect["cave_flame_gout"] = loadfx("maps/oki2/fx_bunker_cave_flame_gout");
  level._effect["bunker_explosion_big"] = loadfx("maps/oki2/fx_explo_bunker_big");
  level._effect["a_godray_sm"] = loadfx("env/light/fx_light_godray_overcast_sm");
  level._effect["a_godray_md"] = loadfx("env/light/fx_light_godray_overcast_md");
  level._effect["a_godray_lg"] = loadfx("env/light/fx_light_godray_overcast_lg");
  level._effect["a_godray_md_1side"] = loadfx("env/light/fx_light_godray_overcast_md_1sd");
  level._effect["a_godray_lg_1side"] = loadfx("env/light/fx_light_godray_overcast_lg_1sd");
  level._effect["a_fire_smoke_med"] = loadfx("env/fire/fx_fire_house_md_jp");
  level._effect["a_fire_smoke_med_dist"] = loadfx("env/fire/fx_fire_smoke_md_dist_jp");
  level._effect["a_fire_smoke_sm_dist"] = loadfx("env/fire/fx_fire_smoke_sm_dist_jp");
  level._effect["a_fire_smoke_med_int"] = loadfx("env/fire/fx_fire_md_low_smk_jp");
  level._effect["a_fire_brush_smldr_sm"] = loadfx("env/fire/fx_fire_brush_smolder_sm_jp");
  level._effect["a_fire_rubble_sm_jp"] = loadfx("env/fire/fx_fire_rubble_sm_jp");
  level._effect["a_fire_rubble_detail_md"] = loadfx("env/fire/fx_fire_rubble_detail_md_jp");
  level._effect["a_fire_rubble_smolder_sm_jp"] = loadfx("env/fire/fx_fire_rubble_smolder_sm_jp");
  level._effect["a_fire_brush_detail"] = loadfx("env/fire/fx_fire_rubble_detail_jp");
  level._effect["a_fire_150x600_distant"] = loadfx("env/fire/fx_fire_150x600_tall_distant_jp");
  level._effect["a_ground_fog"] = loadfx("env/smoke/fx_battlefield_smokebank_ling_foggy_w");
  level._effect["a_ground_smoke"] = loadfx("env/smoke/fx_battlefield_smokebank_ling_foggy");
  level._effect["a_cratersmoke"] = loadfx("env/smoke/fx_smoke_crater_w");
  level._effect["a_smoke_smolder"] = loadfx("env/smoke/fx_smoke_impact_smolder");
  level._effect["a_background_smoke"] = loadfx("maps/oki2/fx_smoke_slow_black_windblown");
  level._effect["a_smk_column_md_blk_dir"] = loadfx("env/smoke/fx_smk_column_md_blk_dir");
  level._effect["a_smoke_plume_lg_slow_def"] = loadfx("env/smoke/fx_smoke_plume_lg_slow_def");
  level._effect["a_smoke_smolder_md_gry"] = loadfx("env/smoke/fx_smoke_smolder_md_gry");
  level._effect["a_rainbow"] = loadfx("env/weather/fx_rainbow");
}

spawnFX() {
  maps\createfx\oki2_fx::main();
}

player_rain() {
  self endon("death");
  self endon("disconnect");
  for (;;) {
    if(getdvar("oki2_rain") == "") {
      playfx(level._effect["rain"], self.origin + (0, 0, 0));
    }
    wait(0.1);
  }
}

cliffside_ambient_fire() {
  level endon("stop cliffside fire");
  level thread cliff_fire("grotto_gun_upper", "upper");
  level thread cliff_fire("grotto_gun_1", "1");
  level thread cliff_fire("grotto_gun_2", "2");
  level thread cliff_fire("grotto_gun_4", "4");
  level thread battleship_artillery_fire();
}

battleship_artillery_fire() {
  level endon("stop firing");
  fire_starts = getstructarray("14inch", "targetname");
  for (i = 0; i < fire_starts.size; i++) {
    level.battleship_firing_states[i] = "not_firing";
  }
  while (1) {
    start_num = randomint(fire_starts.size);
    fire_point = fire_starts[start_num];
    start_point = fire_point;
    while (level.battleship_firing_states[start_num] == "firing") {
      start_num = randomint(fire_starts.size);
      fire_point = fire_starts[start_num];
      start_point = fire_point;
      wait(0.05);
    }
    level.battleship_firing_states[start_num] = "firing";
    firetimes = randomint(3) + 1;
    for (i = 0; i < firetimes; i++) {
      fire_point = start_point;
      while (1) {
        thread fire_arty_gun(fire_point.origin);
        if(isDefined(fire_point.target)) {
          fire_point = getstruct(fire_point.target, "targetname");
        } else {
          break;
        }
        wait(randomfloatrange(.1, .5));
      }
      wait(1.5);
    }
    level.battleship_firing_states[start_num] = "not_firing";
    wait(randomintrange(1, 5));
  }
}

fire_arty_gun(org) {
  thread play_fire_sound(org);
  thread arty_launch();
}

arty_launch() {
  targets = getstructarray("ridge_arty", "targetname");
  target = targets[randomint(targets.size)];
  if(target.script_fxid != "rock" && level.event_1_finished) {
    return;
  }
  ent = spawn("script_model", target.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0));
  wait(randomfloatrange(4, 5));
  if(target.script_fxid == "rock") {
    playfx(level._effect["arty_strike_rock"], ent.origin);
  } else {
    playfx(level.mortar, ent.origin);
  }
  ent do_earthquake();
  ent playsound("naval_gun_impact");
  if(target.script_fxid == "Rock") {
    wait(.5);
    playfx(level._effect["falling_rocks"], ent.origin);
  }
  wait(1);
  ent delete();
}

do_earthquake() {
  players = get_players();
  close = false;
  for (i = 0; i < players.size; i++) {
    if(distancesquared(players[i].origin, self.origin) < (10000)) {
      close = true;
    }
  }
  if(close && (!level.event_1_finished)) {
    earthquake(randomfloatrange(.20, .35), 3, self.origin, 10000);
  } else {
    earthquake(randomfloatrange(.05, .15), 3, self.origin, 10000);
  }
}

play_fire_sound(org) {
  ent = spawn("script_model", org);
  wait(.1);
  ent playsound("naval_gun_fire", "fired");
  ent waittill("fired");
  ent delete();
}

cliff_fire(fx_firepoint, gun) {
  level endon("stop_" + gun);
  while (1) {
    thread model3_tracerfire(fx_firepoint, gun);
    wait(randomfloatrange(2, 5));
  }
}

model3_tracerfire(fx_firepoint, gun) {
  ent = getstruct(fx_firepoint, "targetname");
  playfx(level._effect["gunflash"], ent.origin, AnglesToForward(ent.angles));
  snd = spawn("script_model", ent.origin);
  wait(.1);
  snd playsound("model3_fire", "firedone");
  snd waittill("firedone");
  snd delete();
}

water_drops_init(startCount) {
  trigs = GetEntArray("trigger_water_drops", "targetname");
  ASSERTEX(isDefined(trigs) && trigs.size > 0, "Can't find any water drop fx triggers.");
  array_thread(trigs, ::water_drops_trigger_think);
  if(isDefined(startCount) && startCount > 0) {
    level waittill("introscreen_complete");
    array_thread(get_players(), ::scr_set_water_drops, startCount);
  }
}

water_drops_trigger_think() {
  if(!isDefined(self.script_int)) {
    ASSERTMSG("Water drop fx trigger at origin " + self.origin + " does not have script_int set.You need to set this to specify the amount of water drops that will be generated.");
    return;
  }
  while (1) {
    self waittill("trigger", player);
    if(IsPlayer(player)) {
      player SetWaterDrops(self.script_int);
    }
  }
}

scr_set_water_drops(count) {
  if(isDefined(self)) {
    self SetWaterDrops(count);
  }
}