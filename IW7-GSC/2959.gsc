/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2959.gsc
************************/

main(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  switch (param_00) {
    case "script_vehicle_m1a1_abrams_player_tm":
    case "script_vehicle_m1a1_abrams_minigun":
      func_F63D(param_00, "vfx\core\tread\tread_dust_hamburg_cheap.vfx");
      func_FB0B(param_00, "water");
      func_FB0B(param_00, "paintedmetal");
      func_FB0B(param_00, "riotshield");
      break;

    case "script_vehicle_uk_utility_truck_no_rail_player":
    case "script_vehicle_uk_utility_truck_no_rail":
    case "script_vehicle_uk_utility_truck":
      func_F63D(param_00, "vfx\core\tread\tread_dust_default.vfx");
      func_FB0B(param_00, "water");
      func_FB0B(param_00, "rock", undefined);
      func_FB0B(param_00, "metal", undefined);
      func_FB0B(param_00, "brick", undefined);
      func_FB0B(param_00, "plaster", undefined);
      func_FB0B(param_00, "asphalt", "vfx\core\tread\tread_asphalt_default.vfx");
      func_FB0B(param_00, "paintedmetal", undefined);
      func_FB0B(param_00, "riotshield", undefined);
      func_FB0B(param_00, "snow", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "slush", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "ice", "vfx\core\tread\tread_ice_default.vfx");
      break;

    case "script_vehicle_b2":
    case "script_vehicle_pavelow_noai":
    case "script_vehicle_pavelow":
    case "script_vehicle_mi28_flying_low":
    case "script_vehicle_osprey_fly":
    case "script_vehicle_osprey":
    case "script_vehicle_mi28_flying":
    case "script_vehicle_ch46e_ny_harbor":
    case "script_vehicle_ch46e_low":
    case "script_vehicle_ch46e_notsolid":
    case "script_vehicle_ch46e":
    case "script_vehicle_mi17_woodland_landing_noai":
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
      func_F63D(param_00, "vfx\code\tread\heli_dust_default.vfx");
      func_FB0B(param_00, "water", "vfx\code\tread\heli_water.vfx");
      func_FB0B(param_00, "snow", "vfx\core\tread\heli_snow_default.vfx");
      func_FB0B(param_00, "slush", "vfx\core\tread\heli_snow_default.vfx");
      func_FB0B(param_00, "ice", "vfx\core\tread\heli_snow_default.vfx");
      break;

    case "script_vehicle_warrior_physics_turret":
      func_F63D(param_00, "vfx\core\tread\tread_dust_default.vfx");
      func_FB0B(param_00, "snow", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "slush", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "ice", "vfx\core\tread\tread_ice_default.vfx");
      break;

    default:
      func_F63D(param_00, "vfx\core\tread\tread_dust_default.vfx");
      func_FB0B(param_00, "water");
      func_FB0B(param_00, "concrete");
      func_FB0B(param_00, "rock");
      func_FB0B(param_00, "metal");
      func_FB0B(param_00, "brick");
      func_FB0B(param_00, "plaster");
      func_FB0B(param_00, "asphalt", "vfx\core\tread\tread_asphalt_default.vfx");
      func_FB0B(param_00, "paintedmetal");
      func_FB0B(param_00, "riotshield");
      func_FB0B(param_00, "snow", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "slush", "vfx\core\tread\tread_snow_default.vfx");
      func_FB0B(param_00, "ice", "vfx\core\tread\tread_ice_default.vfx");
      break;
  }
}

func_FB0B(param_00, param_01, param_02) {
  scripts\sp\vehicle_build::func_F5FB(param_00, param_01, param_02);
}

func_F63D(param_00, param_01) {
  var_02 = func_7D14();
  func_FB0B(param_00, "none");
  foreach(var_04 in var_02) {
    func_FB0B(param_00, var_04, param_01);
  }
}

func_7D14() {
  var_00 = [];
  var_00[var_00.size] = "brick";
  var_00[var_00.size] = "bark";
  var_00[var_00.size] = "carpet";
  var_00[var_00.size] = "cloth";
  var_00[var_00.size] = "concrete";
  var_00[var_00.size] = "dirt";
  var_00[var_00.size] = "flesh";
  var_00[var_00.size] = "foliage";
  var_00[var_00.size] = "glass";
  var_00[var_00.size] = "grass";
  var_00[var_00.size] = "gravel";
  var_00[var_00.size] = "ice";
  var_00[var_00.size] = "metal";
  var_00[var_00.size] = "mud";
  var_00[var_00.size] = "paper";
  var_00[var_00.size] = "plaster";
  var_00[var_00.size] = "rock";
  var_00[var_00.size] = "sand";
  var_00[var_00.size] = "snow";
  var_00[var_00.size] = "water";
  var_00[var_00.size] = "wood";
  var_00[var_00.size] = "asphalt";
  var_00[var_00.size] = "ceramic";
  var_00[var_00.size] = "plastic";
  var_00[var_00.size] = "rubber";
  var_00[var_00.size] = "cushion";
  var_00[var_00.size] = "fruit";
  var_00[var_00.size] = "paintedmetal";
  var_00[var_00.size] = "riotshield";
  var_00[var_00.size] = "slush";
  var_00[var_00.size] = "default";
  return var_00;
}