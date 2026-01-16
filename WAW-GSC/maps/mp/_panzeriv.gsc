/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_panzeriv.gsc
*****************************************************/

#include maps\mp\_vehicles;

main(model, type) {
  model = "vehicle_ger_tracked_panzer4_mp";
  build_template("panzeriv", model, type);
  build_exhaust("vehicle/exhaust/fx_exhaust_panzerIV");
  build_treadfx(type);
  build_rumble("tank_rumble_mp", 0.1, 2, 500, 0.1, 0);
  loadfx("destructibles/fx_dest_tank_panzer_tread_lf_0");
  loadfx("destructibles/fx_dest_tank_panzer_tread_lf_1");
  loadfx("destructibles/fx_dest_tank_panzer_tread_lf_grind");
  loadfx("destructibles/fx_dest_tank_panzer_tread_rt_grind");
  loadfx("destructibles/fx_dest_tank_panzer_tread_rt_0");
  loadfx("destructibles/fx_dest_tank_panzer_tread_rt_1");
  loadfx("destructibles/fx_dest_tank_tread_lf_exp");
  loadfx("destructibles/fx_dest_tank_tread_rt_exp");
}

build_damage_states() {
  k_mild_damage_index = 0;
  k_moderate_damage_index = 1;
  k_severe_damage_index = 2;
  k_total_damage_index = 3;
  k_mild_damage_health_percentage = 0.75;
  k_moderate_damage_health_percentage = 0.5;
  k_severe_damage_health_percentage = 0.25;
  k_total_damage_health_percentage = 0;
  vehicle_name = "panzer4_mp";
  {
    level.vehicles_damage_states[vehicle_name] = [];
    level.vehicles_damage_treadfx[vehicle_name] = [];
    {
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].health_percentage = k_mild_damage_health_percentage;
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array = [];
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].damage_effect = loadFX("vehicle/vfire/fx_vdamage_ger_panzer4_mp01");
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].sound_effect = undefined;
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].vehicle_tag = "tag_origin";
      level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].damage_effect_loop_time = 0.2;
    } {
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].health_percentage = k_moderate_damage_health_percentage;
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array = [];
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].damage_effect = loadFX("vehicle/vfire/fx_vdamage_ger_panzer4_mp02");
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].sound_effect = undefined;
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].vehicle_tag = "tag_origin";
      level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].damage_effect_loop_time = 0.2;
    } {
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].health_percentage = k_severe_damage_health_percentage;
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array = [];
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].damage_effect = loadFX("vehicle/vfire/fx_vdamage_ger_panzer4_mp03");
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].sound_effect = undefined;
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].vehicle_tag = "tag_origin";
      level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].damage_effect_loop_time = 0.2;
    } {
      level.vehicles_damage_states[vehicle_name][k_total_damage_index] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].health_percentage = k_total_damage_health_percentage;
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array = [];
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].damage_effect = loadFX("vehicle/vfire/fx_vdamage_ger_panzer4_mp04");
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].sound_effect = undefined;
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].vehicle_tag = "tag_origin";
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].damage_effect_loop_time = 0.2;
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[1] = SpawnStruct();
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[1].damage_effect = loadFX("vehicle/vfire/fx_vexplode_ger_panzer4_mp");
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[1].sound_effect = "exp_suitcase_bomb_main";
      level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[1].vehicle_tag = "tag_origin";
    } {
      default_husk_effects = SpawnStruct();
      default_husk_effects.damage_effect = undefined;
      default_husk_effects.sound_effect = undefined;
      default_husk_effects.vehicle_tag = "tag_origin";
      level.vehicles_husk_effects[vehicle_name] = default_husk_effects;
    }
  }
}