/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\365.gsc
**************************************/

main(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level._id_28EE[var_0] = 1;

  switch (var_0) {
    case "script_vehicle_m1a1_abrams_player_tm":
    case "script_vehicle_m1a1_abrams_minigun":
      _id_28F1(var_0, "treadfx/tread_dust_hamburg_cheap");
      _id_28EF(var_0, "water");
      _id_28EF(var_0, "paintedmetal");
      _id_28EF(var_0, "riotshield");
      break;
    case "script_vehicle_uk_utility_truck_no_rail_player":
    case "script_vehicle_uk_utility_truck_no_rail":
    case "script_vehicle_uk_utility_truck":
      _id_28F1(var_0, "treadfx/tread_dust_default");
      _id_28EF(var_0, "water");
      _id_28EF(var_0, "rock");
      _id_28EF(var_0, "metal");
      _id_28EF(var_0, "brick");
      _id_28EF(var_0, "plaster");
      _id_28EF(var_0, "asphalt");
      _id_28EF(var_0, "paintedmetal");
      _id_28EF(var_0, "riotshield");
      _id_28EF(var_0, "snow", "treadfx/tread_snow_default");
      _id_28EF(var_0, "slush", "treadfx/tread_snow_default");
      _id_28EF(var_0, "ice", "treadfx/tread_ice_default");
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
    case "script_vehicle_ny_harbor_hind":
    case "script_vehicle_ny_blackhawk":
    case "script_vehicle_littlebird_md500":
    case "script_vehicle_littlebird_armed":
    case "b2":
    case "mig29":
    case "blackhawk_minigun_so":
    case "harrier":
    case "pavelow":
    case "mi28":
    case "littlebird":
    case "littlebird_player":
    case "cobra_player":
    case "cobra":
    case "mi17_noai":
    case "mi17":
    case "ny_harbor_hind":
    case "hind":
    case "seaknight":
    case "apache":
    case "blackhawk_minigun":
    case "blackhawk":
      _id_28F1(var_0, "treadfx/heli_dust_default");
      _id_28EF(var_0, "water", "treadfx/heli_water");
      _id_28EF(var_0, "snow", "treadfx/heli_snow_default");
      _id_28EF(var_0, "slush", "treadfx/heli_snow_default");
      _id_28EF(var_0, "ice", "treadfx/heli_snow_default");
      break;
    default:
      _id_28F1(var_0, "treadfx/tread_dust_default");
      _id_28EF(var_0, "water");
      _id_28EF(var_0, "concrete");
      _id_28EF(var_0, "rock");
      _id_28EF(var_0, "metal");
      _id_28EF(var_0, "brick");
      _id_28EF(var_0, "plaster");
      _id_28EF(var_0, "asphalt");
      _id_28EF(var_0, "paintedmetal");
      _id_28EF(var_0, "riotshield");
      _id_28EF(var_0, "snow", "treadfx/tread_snow_default");
      _id_28EF(var_0, "slush", "treadfx/tread_snow_default");
      _id_28EF(var_0, "ice", "treadfx/tread_ice_default");
      break;
  }
}

_id_28EF(var_0, var_1, var_2) {
  if(!isDefined(level._id_28F0)) {
    level._id_28F0 = [];

  }
  if(!isDefined(var_2)) {
    level._id_28F0[var_0][var_1] = -1;
  } else {
    level._id_28F0[var_0][var_1] = loadfx(var_2);
  }
}

_id_28F1(var_0, var_1) {
  _id_28EF(var_0, "brick", var_1);
  _id_28EF(var_0, "bark", var_1);
  _id_28EF(var_0, "carpet", var_1);
  _id_28EF(var_0, "cloth", var_1);
  _id_28EF(var_0, "concrete", var_1);
  _id_28EF(var_0, "dirt", var_1);
  _id_28EF(var_0, "flesh", var_1);
  _id_28EF(var_0, "foliage", var_1);
  _id_28EF(var_0, "glass", var_1);
  _id_28EF(var_0, "grass", var_1);
  _id_28EF(var_0, "gravel", var_1);
  _id_28EF(var_0, "ice", var_1);
  _id_28EF(var_0, "metal", var_1);
  _id_28EF(var_0, "mud", var_1);
  _id_28EF(var_0, "paper", var_1);
  _id_28EF(var_0, "plaster", var_1);
  _id_28EF(var_0, "rock", var_1);
  _id_28EF(var_0, "sand", var_1);
  _id_28EF(var_0, "snow", var_1);
  _id_28EF(var_0, "water", var_1);
  _id_28EF(var_0, "wood", var_1);
  _id_28EF(var_0, "asphalt", var_1);
  _id_28EF(var_0, "ceramic", var_1);
  _id_28EF(var_0, "plastic", var_1);
  _id_28EF(var_0, "rubber", var_1);
  _id_28EF(var_0, "cushion", var_1);
  _id_28EF(var_0, "fruit", var_1);
  _id_28EF(var_0, "paintedmetal", var_1);
  _id_28EF(var_0, "riotshield", var_1);
  _id_28EF(var_0, "slush", var_1);
  _id_28EF(var_0, "default", var_1);
  _id_28EF(var_0, "none");
}