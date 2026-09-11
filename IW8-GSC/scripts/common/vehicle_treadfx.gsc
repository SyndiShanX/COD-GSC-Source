/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_treadfx.gsc
***********************************************/

function main(var_0) {
  if(!scripts\common\utility::issp()) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "script_vehicle_m1a1_abrams_player_tm":
    case "script_vehicle_m1a1_abrams_minigun":
      setallvehiclefx(var_0, "vfx/core/tread/tread_dust_hamburg_cheap.vfx");
      setvehiclefx(var_0, "water");
      setvehiclefx(var_0, "paintedmetal");
      setvehiclefx(var_0, "riotshield");
      break;
    case "script_vehicle_uk_utility_truck_no_rail_player":
    case "script_vehicle_uk_utility_truck_no_rail":
    case "script_vehicle_uk_utility_truck":
      setallvehiclefx(var_0, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(var_0, "water");
      setvehiclefx(var_0, "rock", undefined);
      setvehiclefx(var_0, "metal", undefined);
      setvehiclefx(var_0, "brick", undefined);
      setvehiclefx(var_0, "plaster", undefined);
      setvehiclefx(var_0, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      setvehiclefx(var_0, "paintedmetal", undefined);
      setvehiclefx(var_0, "riotshield", undefined);
      setvehiclefx(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    case "script_vehicle_mi28_flying_low":
    case "script_vehicle_osprey_fly":
    case "script_vehicle_mi17_woodland_landing_noai":
    case "script_vehicle_mi28_flying":
    case "script_vehicle_ch46e_ny_harbor":
    case "script_vehicle_ch46e_low":
    case "script_vehicle_ch46e_notsolid":
    case "script_vehicle_ch46e":
    case "script_vehicle_mi17_woodland_fly_cheap_noai":
    case "script_vehicle_mi17_woodland_fly_noai":
    case "script_vehicle_mi17_woodland_noai":
    case "script_vehicle_mi17_woodland_landing_so":
    case "script_vehicle_mi17_woodland_landing":
    case "script_vehicle_mi17_woodland_fly_cheap":
    case "script_vehicle_mi17_woodland_fly":
    case "script_vehicle_mi17_woodland":
    case "script_vehicle_harrier":
    case "script_vehicle_blackhawk_minigun_low":
    case "script_vehicle_blackhawk_hero_hamburg":
    case "script_vehicle_blackhawk_low_thermal":
    case "script_vehicle_blackhawk_low":
    case "script_vehicle_blackhawk_hero_sas_night":
    case "script_vehicle_blackhawk":
    case "script_vehicle_littlebird_player":
    case "script_vehicle_littlebird_bench":
    case "script_vehicle_littlebird_md500":
    case "script_vehicle_littlebird_armed":
    case "script_vehicle_cobra_helicopter_fly_player":
    case "script_vehicle_cobra_helicopter_player":
    case "script_vehicle_cobra_helicopter_low":
    case "script_vehicle_cobra_helicopter_fly_low":
    case "script_vehicle_cobra_helicopter_fly":
    case "script_vehicle_cobra_helicopter":
    case "script_vehicle_apache_dark":
    case "script_vehicle_apache_mg":
    case "script_vehicle_apache":
    case "script_vehicle_mi24p_hind_woodland_opened_door":
    case "script_vehicle_mi24p_hind_blackice":
    case "script_vehicle_ny_harbor_hind":
    case "script_vehicle_ny_blackhawk":
    case "script_vehicle_osprey":
    case "script_vehicle_b2":
    case "script_vehicle_pavelow_noai":
    case "script_vehicle_pavelow":
      setallvehiclefx(var_0, "vfx/code/tread/heli_dust_default.vfx");
      setvehiclefx(var_0, "water", "vfx/code/tread/heli_water.vfx");
      setvehiclefx(var_0, "snow", "vfx/core/tread/heli_snow_default.vfx");
      setvehiclefx(var_0, "slush", "vfx/core/tread/heli_snow_default.vfx");
      setvehiclefx(var_0, "ice", "vfx/core/tread/heli_snow_default.vfx");
      break;
    case "script_vehicle_warrior_physics_turret":
      setallvehiclefx(var_0, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    default:
      setallvehiclefx(var_0, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(var_0, "water");
      setvehiclefx(var_0, "concrete");
      setvehiclefx(var_0, "rock");
      setvehiclefx(var_0, "metal");
      setvehiclefx(var_0, "brick");
      setvehiclefx(var_0, "plaster");
      setvehiclefx(var_0, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      setvehiclefx(var_0, "paintedmetal");
      setvehiclefx(var_0, "riotshield");
      setvehiclefx(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
  }
}

function setvehiclefx(var_0, var_1, var_2) {
  scripts\common\vehicle_build::set_vehicle_effect(var_0, var_1, var_2);
}

function setallvehiclefx(var_0, var_1) {
  var_2 = get_trace_types();
  setvehiclefx(var_0, "none");

  foreach(var_4 in var_2) {
    setvehiclefx(var_0, var_4, var_1);
  }
}

function get_trace_types() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "brick");
}