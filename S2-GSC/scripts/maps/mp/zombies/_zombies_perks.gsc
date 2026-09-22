/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_perks.gsc
******************************************************/

init() {
  level._id_AB22 = [];
  level._id_AB23 = [];
  level._id_AB25 = [];
  level._id_AB22["specialty_class_armor_zm"] = 1;
  level._id_AB22["specialty_class_longlasting_zm"] = 1;
  level._id_AB22["specialty_class_resourceful_zm"] = 1;
  level._id_AB22["specialty_class_aftertaste_zm"] = 1;
  level._id_AB22["specialty_class_mugger_zm"] = 1;
  level._id_AB22["specialty_class_finishing_blow_zm"] = 1;
  level._id_AB22["specialty_class_fully_loaded_zm"] = 1;
  level._id_AB22["specialty_class_preventative_medicine_zm"] = 1;
  level._id_AB22["specialty_class_flak_jacket_zm"] = 1;
  level._id_AB22["specialty_class_grenadier_zm"] = 1;
  level._id_AB22["specialty_class_discipline_zm"] = 1;
  level._id_AB22["specialty_class_specialist_zm"] = 1;
  level._id_AB22["specialty_class_dutiful_medic_zm"] = 1;
  level._id_AB22["specialty_class_gungho_zm"] = 1;
  level._id_AB22["specialty_class_fast_hands_zm"] = 1;
  level._id_AB22["specialty_class_hoarder_zm"] = 1;
  level._id_AB22["specialty_class_lucky_crit_zm"] = 1;
  level._id_AB22["specialty_class_mule_kick_zm"] = 1;
  level._id_AB22["specialty_class_mobilization_zm"] = 1;
  level._id_AB22["specialty_class_survivalist_zm"] = 1;
  level._id_AB22["specialty_class_saboteur_zm"] = 1;
  level._id_AB22["specialty_class_recon_medic_zm"] = 1;
  level._id_AB22["specialty_class_covert_exfiltration_zm"] = 1;
  level._id_AB22["specialty_class_serrated_edge_zm"] = 1;
  level._id_AB22["specialty_class_charge_the_line_zm"] = 1;
  level._id_AB22["specialty_class_marksmanship_zm"] = 1;
  level._id_AB22["specialty_class_explosives_handler_zm"] = 1;
  level._id_AB22["specialty_class_ammo_carrier_zm"] = 1;
  level._id_AB22["specialty_class_frag_skull_zm"] = 1;
  level._id_AB22["specialty_class_squad_tactics_zm"] = 1;
  level._id_AB22["specialty_class_mk_ii_zm"] = 1;
  level._id_AB22["specialty_class_suppressive_fire_zm"] = 1;
  level._id_AB22["specialty_class_improvised_def_zm"] = 1;
  level._id_AB22["specialty_class_resilient_zm"] = 1;
  level._id_AB22["specialty_class_team_effort_zm"] = 1;
  level._id_AB22["specialty_class_counter_offensive_zm"] = 1;
  level._id_AB22["specialty_class_come_get_zm"] = 1;
  level._id_AB22["specialty_class_hit_em_hard_zm"] = 1;
  level._id_AB22["specialty_class_bolster_morale_zm"] = 1;
  level._id_AB22["specialty_class_exploit_weakness_zm"] = 1;
  level._id_AB22["specialty_class_on_your_feet_zm"] = 1;
  level._id_AB22["specialty_class_fiery_burst_zm"] = 1;
  level._id_AB22["specialty_class_breathing_room_zm"] = 1;
  level._id_AB22["specialty_class_sustain_zone_zm"] = 1;
  level._id_AB23["specialty_class_armor_zm"] = ::deactivatereverb;
  level._id_AB25["specialty_class_armor_zm"] = ::_id_A051;
  level._id_AB23["specialty_class_fully_loaded_zm"] = ::_id_868A;
  level._id_AB25["specialty_class_fully_loaded_zm"] = ::_id_A066;
  level._id_AB23["specialty_class_flak_jacket_zm"] = ::_id_8683;
  level._id_AB25["specialty_class_flak_jacket_zm"] = ::_id_A062;
  level._id_AB23["specialty_class_grenadier_zm"] = ::_id_8697;
  level._id_AB25["specialty_class_grenadier_zm"] = ::_id_A068;
  level._id_AB23["specialty_class_discipline_zm"] = ::_id_8665;
  level._id_AB25["specialty_class_discipline_zm"] = ::_id_A058;
  level._id_AB23["specialty_class_dutiful_medic_zm"] = ::_id_866F;
  level._id_AB25["specialty_class_dutiful_medic_zm"] = ::_id_A05A;
  level._id_AB23["specialty_class_gungho_zm"] = ::_id_869B;
  level._id_AB25["specialty_class_gungho_zm"] = ::_id_A069;
  level._id_AB23["specialty_class_fast_hands_zm"] = ::_id_867D;
  level._id_AB25["specialty_class_fast_hands_zm"] = ::_id_A05F;
  level._id_AB23["specialty_class_hoarder_zm"] = ::_id_86A8;
  level._id_AB25["specialty_class_hoarder_zm"] = ::_id_A06A;
  level._effect["zmb_moon_speed_down"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_speed_down");
}

_id_0F35(var_0) {}

_id_536E() {
  foreach(var_2, var_1 in level._id_AB22) {
    level.disableoffhandweapons[var_2] = var_1;
  }

  foreach(var_2, var_4 in level._id_AB23) {
    level._id_6F68[var_2] = var_4;
  }

  foreach(var_2, var_4 in level._id_AB25) {
    level._id_6F6C[var_2] = var_4;
  }
}

_id_0F39() {
  var_0 = _id_0547::_id_4BA7("specialty_class_armor_zm") || _id_0547::_id_4BA7("specialty_class_longlasting_zm") || _id_0547::_id_4BA7("specialty_class_resourceful_zm") || _id_0547::_id_4BA7("specialty_class_aftertaste_zm") || _id_0547::_id_4BA7("specialty_class_mugger_zm") || _id_0547::_id_4BA7("specialty_class_finishing_blow_zm") || _id_0547::_id_4BA7("specialty_class_fully_loaded_zm") || _id_0547::_id_4BA7("specialty_class_preventative_medicine_zm") || _id_0547::_id_4BA7("specialty_class_flak_jacket_zm") || _id_0547::_id_4BA7("specialty_class_grenadier_zm") || _id_0547::_id_4BA7("specialty_class_discipline_zm") || _id_0547::_id_4BA7("specialty_class_specialist_zm") || _id_0547::_id_4BA7("specialty_class_dutiful_medic_zm") || _id_0547::_id_4BA7("specialty_class_gungho_zm") || _id_0547::_id_4BA7("specialty_class_fast_hands_zm") || _id_0547::_id_4BA7("specialty_class_suppressive_fire_zm") || _id_0547::_id_4BA7("specialty_class_hoarder_zm") || _id_0547::_id_4BA7("specialty_class_lucky_crit_zm") || _id_0547::_id_4BA7("specialty_class_mule_kick_zm");

  if(var_0) {
    level._id_400E[level._id_400E.size] = ["assassin_set 4 -1", self];
    level._id_400E[level._id_400E.size] = ["bat_elite_set 4 -1", self];
  }
}

_id_A27B(var_0, var_1) {
  switch (var_1) {
    case "specialty_class_hoarder_zm":
    case "specialty_class_mk_ii_zm":
    case "specialty_class_hit_em_hard_zm":
    case "specialty_class_dutiful_medic_zm":
    case "specialty_class_specialist_zm":
    case "specialty_class_on_your_feet_zm":
    case "specialty_class_resilient_zm":
    case "specialty_class_improvised_def_zm":
    case "specialty_class_frag_skull_zm":
    case "specialty_class_explosives_handler_zm":
    case "specialty_class_marksmanship_zm":
    case "specialty_class_survivalist_zm":
    case "specialty_class_grenadier_zm":
    case "specialty_class_fully_loaded_zm":
    case "specialty_class_longlasting_zm":
    case "specialty_class_armor_zm":
    case "specialty_class_mule_kick_zm":
    case "specialty_class_recon_medic_zm":
    case "specialty_class_preventative_medicine_zm":
    case "specialty_class_aftertaste_zm":
    case "specialty_class_lucky_crit_zm":
    case "specialty_class_fast_hands_zm":
    case "specialty_class_gungho_zm":
    case "specialty_class_discipline_zm":
    case "specialty_class_flak_jacket_zm":
    case "specialty_class_finishing_blow_zm":
    case "specialty_class_mugger_zm":
    case "specialty_class_resourceful_zm":
    case "specialty_class_suppressive_fire_zm":
    case "specialty_class_serrated_edge_zm":
    case "specialty_class_sustain_zone_zm":
    case "specialty_class_come_get_zm":
    case "specialty_class_breathing_room_zm":
    case "specialty_class_fiery_burst_zm":
    case "specialty_class_exploit_weakness_zm":
    case "specialty_class_bolster_morale_zm":
    case "specialty_class_counter_offensive_zm":
    case "specialty_class_team_effort_zm":
    case "specialty_class_ammo_carrier_zm":
    case "specialty_class_covert_exfiltration_zm":
    case "specialty_class_saboteur_zm":
    case "specialty_class_squad_tactics_zm":
    case "specialty_class_charge_the_line_zm":
    case "specialty_class_mobilization_zm":
      return maps\mp\_utility::_id_452A(var_1);
    default:
      return 0;
  }
}

onplayerconnect(var_0) {
  var_0._id_AB24 = [];
}

_id_6B81() {
  var_0 = 0;

  if(_id_0547::_id_4BA7("specialty_class_armor_zm")) {
    var_0 = _id_0547::playergetmaxarmorcount();
  }

  _id_0547::_id_7454(var_0);
}

deactivatereverb() {}

_id_A051() {}

_id_868A() {
  maps\mp\_utility::giveperk("specialty_stockpile");
}

_id_A066() {
  maps\mp\_utility::_id_0735("specialty_stockpile");
}

_id_8683() {
  maps\mp\_utility::giveperk("specialty_immune_grenade_suicide");
}

_id_A062() {
  maps\mp\_utility::_id_0735("specialty_immune_grenade_suicide");
}

_id_0633() {
  if(_id_0547::_id_0F0F("specialty_class_longlasting_zm")) {
    return 5;
  } else {
    return 0;
  }
}

_id_8697() {
  maps\mp\_utility::giveperk("specialty_grenade_extra_zm");
}

_id_A068() {
  maps\mp\_utility::_id_0735("specialty_grenade_extra_zm");
}

_id_8665() {
  maps\mp\_utility::giveperk("specialty_discipline_zm");
}

_id_A058() {
  maps\mp\_utility::_id_0735("specialty_discipline_zm");
}

_id_866F() {
  self._id_3514 = 0;
}

_id_A05A() {
  self._id_3514 = undefined;
}

_id_21B2() {
  if(_id_0547::_id_4BA7("specialty_class_dutiful_medic_zm") && isDefined(self._id_57AB) && self._id_57AB && gettime() - self._id_3514 > 30000) {
    self _meth_866C(&"trigger_mod_proc_and_stop", 2, "specialty_class_dutiful_medic_zm", 30000);
    self._id_3514 = gettime();
    return 1;
  } else
    return 0;
}

_id_869B() {
  maps\mp\_utility::giveperk("specialty_sprintfire");
  maps\mp\_utility::giveperk("specialty_mantlefire");
}

_id_A069() {
  maps\mp\_utility::_id_0735("specialty_sprintfire");
  maps\mp\_utility::_id_0735("specialty_mantlefire");
}

_id_867D() {
  maps\mp\_utility::giveperk("specialty_quickswap");
  maps\mp\_utility::giveperk("specialty_fastoffhand");
}

_id_A05F() {
  maps\mp\_utility::_id_0735("specialty_quickswap");
  maps\mp\_utility::_id_0735("specialty_fastoffhand");
}

_id_86A8() {
  var_0 = _id_056A::_id_420E(1);
  self setclientomnvar("zm_blitz_items_limit", var_0);
}

_id_A06A() {
  var_0 = _id_056A::_id_420E(0);
  self setclientomnvar("zm_blitz_items_limit", var_0);
}

_id_466B(var_0) {
  switch (var_0) {
    case "throwingknife_zm":
      return 2.5;
    default:
      return 2.5;
  }
}

_id_0F38(var_0) {
  _id_054D::_id_099B("suppressive_fire", _id_46BB(var_0));

  if(isalive(self)) {
    _playFXOnTag(level._effect["zmb_moon_speed_down"], self, "J_Knee_RI");
    _playFXOnTag(level._effect["zmb_moon_speed_down"], self, "J_Knee_LE");
  }
}

_id_46BB(var_0) {
  var_1 = _id_054D::_id_443F("suppressive_fire");

  if(!isDefined(var_1)) {
    var_1 = _id_90A8();
  }

  var_1._id_5CC8 = 1.0;
  var_1.player = var_0;
  return var_1;
}

_id_90A8() {
  var_0 = spawnStruct();
  var_0._id_1CF0 = ::_id_7CFD;
  var_0._id_5CC8 = 1.0;
  var_1 = 1.0;
  var_2 = _id_0547::_id_0A51(self._id_0A4B);

  if(isDefined(var_2.suppressive_fire_speed_multiplier)) {
    var_1 = var_2.suppressive_fire_speed_multiplier;
  }

  var_0._id_90F0 = var_1;
  self notify("speed_debuffs_changed");
  return var_0;
}

_id_7CFD(var_0) {
  self notify("speed_debuffs_changed");
  _stopFXOnTag(level._effect["zmb_moon_speed_down"], self, "J_Knee_RI");
  _stopFXOnTag(level._effect["zmb_moon_speed_down"], self, "J_Knee_LE");
}