/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_treadfx.gsc
***********************************************/

main(classname) {
  if(!scripts\common\utility::issp()) {
    return;
  }
  if(!isDefined(classname)) {
    return;
  }
  switch (classname) {
    case "script_vehicle_m1a1_abrams_player_tm":
    case "script_vehicle_m1a1_abrams_minigun":
      setallvehiclefx(classname, "vfx/core/tread/tread_dust_hamburg_cheap.vfx");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "paintedmetal");
      setvehiclefx(classname, "riotshield");
      break;
    case "script_vehicle_uk_utility_truck_no_rail":
    case "script_vehicle_uk_utility_truck":
    case "script_vehicle_uk_utility_truck_no_rail_player":
      setallvehiclefx(classname, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "rock", undefined);
      setvehiclefx(classname, "metal", undefined);
      setvehiclefx(classname, "brick", undefined);
      setvehiclefx(classname, "plaster", undefined);
      setvehiclefx(classname, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      setvehiclefx(classname, "paintedmetal", undefined);
      setvehiclefx(classname, "riotshield", undefined);
      setvehiclefx(classname, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    case "script_vehicle_mi28_flying":
    case "script_vehicle_apache_dark":
    case "script_vehicle_cobra_helicopter":
    case "script_vehicle_mi24p_hind_blackice":
    case "script_vehicle_apache":
    case "script_vehicle_mi17_woodland":
    case "script_vehicle_pavelow_noai":
    case "script_vehicle_ny_blackhawk":
    case "script_vehicle_ny_harbor_hind":
    case "script_vehicle_harrier":
    case "script_vehicle_blackhawk_low":
    case "script_vehicle_ch46e":
    case "script_vehicle_cobra_helicopter_fly_player":
    case "script_vehicle_mi17_woodland_landing_so":
    case "script_vehicle_osprey_fly":
    case "script_vehicle_mi17_woodland_fly_cheap_noai":
    case "script_vehicle_osprey":
    case "script_vehicle_b2":
    case "script_vehicle_cobra_helicopter_fly":
    case "script_vehicle_cobra_helicopter_low":
    case "script_vehicle_mi28_flying_low":
    case "script_vehicle_littlebird_md500":
    case "script_vehicle_mi24p_hind_woodland_opened_door":
    case "script_vehicle_littlebird_player":
    case "script_vehicle_apache_mg":
    case "script_vehicle_blackhawk_hero_hamburg":
    case "script_vehicle_ch46e_ny_harbor":
    case "script_vehicle_mi17_woodland_landing_noai":
    case "script_vehicle_blackhawk_low_thermal":
    case "script_vehicle_cobra_helicopter_fly_low":
    case "script_vehicle_cobra_helicopter_player":
    case "script_vehicle_mi17_woodland_landing":
    case "script_vehicle_mi17_woodland_fly":
    case "script_vehicle_littlebird_bench":
    case "script_vehicle_blackhawk_minigun_low":
    case "script_vehicle_mi17_woodland_fly_cheap":
    case "script_vehicle_littlebird_armed":
    case "script_vehicle_ch46e_low":
    case "script_vehicle_mi17_woodland_fly_noai":
    case "script_vehicle_blackhawk":
    case "script_vehicle_ch46e_notsolid":
    case "script_vehicle_pavelow":
    case "script_vehicle_blackhawk_hero_sas_night":
    case "script_vehicle_mi17_woodland_noai":
      setallvehiclefx(classname, "vfx/code/tread/heli_dust_default.vfx");
      setvehiclefx(classname, "water", "vfx/code/tread/heli_water.vfx");
      setvehiclefx(classname, "snow", "vfx/core/tread/heli_snow_default.vfx");
      setvehiclefx(classname, "slush", "vfx/core/tread/heli_snow_default.vfx");
      setvehiclefx(classname, "ice", "vfx/core/tread/heli_snow_default.vfx");
      break;
    case "script_vehicle_warrior_physics_turret":
      setallvehiclefx(classname, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(classname, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    default:
      setallvehiclefx(classname, "vfx/core/tread/tread_dust_default.vfx");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "concrete");
      setvehiclefx(classname, "rock");
      setvehiclefx(classname, "metal");
      setvehiclefx(classname, "brick");
      setvehiclefx(classname, "plaster");
      setvehiclefx(classname, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      setvehiclefx(classname, "paintedmetal");
      setvehiclefx(classname, "riotshield");
      setvehiclefx(classname, "snow", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "slush", "vfx/core/tread/tread_snow_default.vfx");
      setvehiclefx(classname, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
  }
}

setvehiclefx(classname, material, fx) {
  scripts\common\vehicle_build::set_vehicle_effect(classname, material, fx);
}

setallvehiclefx(classname, fx) {
  types = get_trace_types();
  setvehiclefx(classname, "none");

  foreach(type in types)
  setvehiclefx(classname, type, fx);
}

get_trace_types() {
  types = [];
  types[types.size] = "brick";
  types[types.size] = "bark";
  types[types.size] = "carpet";
  types[types.size] = "cloth";
  types[types.size] = "concrete";
  types[types.size] = "dirt";
  types[types.size] = "flesh";
  types[types.size] = "foliage";
  types[types.size] = "glass";
  types[types.size] = "grass";
  types[types.size] = "gravel";
  types[types.size] = "ice";
  types[types.size] = "metal";
  types[types.size] = "mud";
  types[types.size] = "paper";
  types[types.size] = "plaster";
  types[types.size] = "rock";
  types[types.size] = "sand";
  types[types.size] = "snow";
  types[types.size] = "water";
  types[types.size] = "wood";
  types[types.size] = "asphalt";
  types[types.size] = "ceramic";
  types[types.size] = "plastic";
  types[types.size] = "rubber";
  types[types.size] = "cushion";
  types[types.size] = "fruit";
  types[types.size] = "paintedmetal";
  types[types.size] = "riotshield";
  types[types.size] = "slush";
  types[types.size] = "default";
  return types;
}