/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1772.gsc
*************************************************/

main(var_0) {
  if(!scripts\common\utility::issp()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "script_vehicle_m1a1_abrams_player_tm":
    case "script_vehicle_m1a1_abrams_minigun":
      _id_D46C(var_0, "vfx/core/tread/tread_dust_hamburg_cheap.vfx");
      _id_D8DD(var_0, "water");
      _id_D8DD(var_0, "paintedmetal");
      _id_D8DD(var_0, "riotshield");
      break;
    case "script_vehicle_uk_utility_truck":
    case "script_vehicle_uk_utility_truck_no_rail_player":
    case "script_vehicle_uk_utility_truck_no_rail":
      _id_D46C(var_0, "vfx/core/tread/tread_dust_default.vfx");
      _id_D8DD(var_0, "water");
      _id_D8DD(var_0, "rock", undefined);
      _id_D8DD(var_0, "metal", undefined);
      _id_D8DD(var_0, "brick", undefined);
      _id_D8DD(var_0, "plaster", undefined);
      _id_D8DD(var_0, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      _id_D8DD(var_0, "paintedmetal", undefined);
      _id_D8DD(var_0, "riotshield", undefined);
      _id_D8DD(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    case "script_vehicle_pavelow":
    case "script_vehicle_mi24p_hind_woodland_opened_door":
    case "script_vehicle_cobra_helicopter_fly_player":
    case "script_vehicle_ny_blackhawk":
    case "script_vehicle_mi17_woodland_fly_cheap_noai":
    case "script_vehicle_mi17_woodland_landing_noai":
    case "script_vehicle_b2":
    case "script_vehicle_pavelow_noai":
    case "script_vehicle_ny_harbor_hind":
    case "script_vehicle_mi24p_hind_blackice":
    case "script_vehicle_apache":
    case "script_vehicle_apache_mg":
    case "script_vehicle_apache_dark":
    case "script_vehicle_ch46e_ny_harbor":
    case "script_vehicle_mi17_woodland_fly":
    case "script_vehicle_mi17_woodland":
    case "script_vehicle_cobra_helicopter_fly":
    case "script_vehicle_cobra_helicopter_fly_low":
    case "script_vehicle_cobra_helicopter_low":
    case "script_vehicle_harrier":
    case "script_vehicle_blackhawk_minigun_low":
    case "script_vehicle_blackhawk_low_thermal":
    case "script_vehicle_cobra_helicopter_player":
    case "script_vehicle_blackhawk_hero_hamburg":
    case "script_vehicle_osprey":
    case "script_vehicle_littlebird_bench":
    case "script_vehicle_mi28_flying":
    case "script_vehicle_littlebird_armed":
    case "script_vehicle_blackhawk":
    case "script_vehicle_littlebird_player":
    case "script_vehicle_blackhawk_hero_sas_night":
    case "script_vehicle_littlebird_md500":
    case "script_vehicle_mi17_woodland_landing":
    case "script_vehicle_blackhawk_low":
    case "script_vehicle_mi17_woodland_fly_cheap":
    case "script_vehicle_cobra_helicopter":
    case "script_vehicle_mi17_woodland_landing_so":
    case "script_vehicle_ch46e_notsolid":
    case "script_vehicle_mi28_flying_low":
    case "script_vehicle_ch46e":
    case "script_vehicle_ch46e_low":
    case "script_vehicle_osprey_fly":
    case "script_vehicle_mi17_woodland_noai":
    case "script_vehicle_mi17_woodland_fly_noai":
      _id_D46C(var_0, "vfx/code/tread/heli_dust_default.vfx");
      _id_D8DD(var_0, "water", "vfx/code/tread/heli_water.vfx");
      _id_D8DD(var_0, "snow", "vfx/core/tread/heli_snow_default.vfx");
      _id_D8DD(var_0, "slush", "vfx/core/tread/heli_snow_default.vfx");
      _id_D8DD(var_0, "ice", "vfx/core/tread/heli_snow_default.vfx");
      break;
    case "script_vehicle_warrior_physics_turret":
      _id_D46C(var_0, "vfx/core/tread/tread_dust_default.vfx");
      _id_D8DD(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
    default:
      _id_D46C(var_0, "vfx/core/tread/tread_dust_default.vfx");
      _id_D8DD(var_0, "water");
      _id_D8DD(var_0, "concrete");
      _id_D8DD(var_0, "rock");
      _id_D8DD(var_0, "metal");
      _id_D8DD(var_0, "brick");
      _id_D8DD(var_0, "plaster");
      _id_D8DD(var_0, "asphalt", "vfx/core/tread/tread_asphalt_default.vfx");
      _id_D8DD(var_0, "paintedmetal");
      _id_D8DD(var_0, "riotshield");
      _id_D8DD(var_0, "snow", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "slush", "vfx/core/tread/tread_snow_default.vfx");
      _id_D8DD(var_0, "ice", "vfx/core/tread/tread_ice_default.vfx");
      break;
  }
}

_id_D8DD(var_0, var_1, var_2) {
  _id_06E8::_id_D42A(var_0, var_1, var_2);
}

_id_D46C(var_0, var_1) {
  var_2 = _id_67E1();
  _id_D8DD(var_0, "none");

  foreach(var_4 in var_2) {
    _id_D8DD(var_0, var_4, var_1);
  }
}

_id_67E1() {
  var_0 = [];
  var_0[var_0.size] = "brick";
  var_0[var_0.size] = "bark";
  var_0[var_0.size] = "carpet";
  var_0[var_0.size] = "cloth";
  var_0[var_0.size] = "concrete";
  var_0[var_0.size] = "dirt";
  var_0[var_0.size] = "flesh";
  var_0[var_0.size] = "foliage";
  var_0[var_0.size] = "glass";
  var_0[var_0.size] = "grass";
  var_0[var_0.size] = "gravel";
  var_0[var_0.size] = "ice";
  var_0[var_0.size] = "metal";
  var_0[var_0.size] = "mud";
  var_0[var_0.size] = "paper";
  var_0[var_0.size] = "plaster";
  var_0[var_0.size] = "rock";
  var_0[var_0.size] = "sand";
  var_0[var_0.size] = "snow";
  var_0[var_0.size] = "water";
  var_0[var_0.size] = "wood";
  var_0[var_0.size] = "asphalt";
  var_0[var_0.size] = "ceramic";
  var_0[var_0.size] = "plastic";
  var_0[var_0.size] = "rubber";
  var_0[var_0.size] = "cushion";
  var_0[var_0.size] = "fruit";
  var_0[var_0.size] = "paintedmetal";
  var_0[var_0.size] = "riotshield";
  var_0[var_0.size] = "slush";
  var_0[var_0.size] = "default";
  return var_0;
}