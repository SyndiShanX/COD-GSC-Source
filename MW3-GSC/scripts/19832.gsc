/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\19832.gsc
**************************************/

_id_4CBC() {
  level._id_4CBD = 0;
  level._id_4BC4 = 3.5;
  level._id_4BB1 = 0;
  level._id_4CBE = 0;
  level._id_4BCA = undefined;
  level._id_4BB2 = 0;
  level._id_4CBF = [];
  level._id_4CC0 = 0;
  _id_4D67();
  setdvarifuninitialized("breach_debug", "0");
  setdvarifuninitialized("breach_requires_friendlies_in_position", "1");
  setdvarifuninitialized("hostage_missionfail", "0");
  precacheitem("usp_scripted");
  precacheshader("breach_icon");
  precachemodel("weapon_parabolic_knife");
  precachestring(&"SCRIPT_WAYPOINT_BREACH");
  precachestring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
  precachestring(&"SCRIPT_BREACH_NEED_PLAYER");
  precachestring(&"SCRIPT_BREACH_NEED_FRIENDLY");
  precachestring(&"SCRIPT_BREACH_TOO_MANY_ENEMIES");
  precachestring(&"SCRIPT_BREACH_ILLEGAL_WEAPON");
  precachestring(&"SCRIPT_BREACH_PARTNER_NOT_READY");
  precachestring(&"SCRIPT_BREACH_YOU_NOT_READY");
  precachestring(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE_THROUGH_ENEMY");
  precachestring(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
  precachestring(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
  precachestring(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR");
  precachestring(&"SCRIPT_BREACH_RELOADING");
  level._id_4CC1 = [];
  level._effect["breach_door"] = loadfx("explosions/breach_door");
  level._effect["breach_room"] = loadfx("explosions/breach_room");
  level._effect["breach_room_residual"] = loadfx("explosions/breach_room_residual");
  level._effect["breach_knife_execution"] = loadfx("impacts/flesh_hit_knife");
  _id_4443();
  _id_4444();
  _id_4CCC();
  _id_4CCA();
  _id_4CCF();
  var_0 = getEntArray("trigger_multiple_breachIcon", "classname");
  common_scripts\utility::array_thread(var_0, ::_id_4CE1);
  var_1 = getEntArray("breach_solid_delete", "targetname");
  common_scripts\utility::array_call(var_1, ::connectpaths);
  common_scripts\utility::array_thread(var_1, maps\_utility::_id_2705);
  var_1 = getEntArray("breach_delete", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::_id_2705);
  var_2 = getEntArray("breach_fx", "targetname");
  common_scripts\utility::array_thread(var_2, ::_id_4CCD);
  level._id_4CBF["aa12"] = 1;
  level._id_4CBF["aa12_reflex"] = 1;
  level._id_4CBF["aa12_hb"] = 1;
  level._id_4CBF["aug_reflex"] = 1;
  level._id_4CBF["aug_scope"] = 1;
  level._id_4CBF["barrett"] = 1;
  level._id_4CBF["beretta"] = 1;
  level._id_4CBF["beretta393"] = 1;
  level._id_4CBF["cheytac_silencer"] = 1;
  level._id_4CBF["fal"] = 1;
  level._id_4CBF["fal_acog"] = 1;
  level._id_4CBF["fal_reflex"] = 1;
  level._id_4CBF["fal_shotgun"] = 1;
  level._id_4CBF["fal_shotgun_attach"] = 1;
  level._id_4CBF["famas"] = 1;
  level._id_4CBF["famas_arctic"] = 1;
  level._id_4CBF["famas_arctic_eotech"] = 1;
  level._id_4CBF["famas_arctic_reflex"] = 1;
  level._id_4CBF["famas_mp2"] = 1;
  level._id_4CBF["famas_shotgun"] = 1;
  level._id_4CBF["famas_shotgun_attach"] = 1;
  level._id_4CBF["famas_woodland"] = 1;
  level._id_4CBF["famas_woodland_eotech"] = 1;
  level._id_4CBF["famas_woodland_acog"] = 1;
  level._id_4CBF["famas_woodland_reflex"] = 1;
  level._id_4CBF["famas_woodland_shotgun"] = 1;
  level._id_4CBF["famas_woodland_shotgun_attach"] = 1;
  level._id_4CBF["fn2000"] = 1;
  level._id_4CBF["fn2000_acog"] = 1;
  level._id_4CBF["fn2000_eotech"] = 1;
  level._id_4CBF["fn2000_reflex"] = 1;
  level._id_4CBF["fn2000_scope"] = 1;
  level._id_4CBF["fn2000_shotgun"] = 1;
  level._id_4CBF["fn2000_shotgun_attach"] = 1;
  level._id_4CBF["fn2000_silencer"] = 1;
  level._id_4CBF["fn2000_thermal"] = 1;
  level._id_4CBF["glock"] = 1;
  level._id_4CBF["kriss"] = 1;
  level._id_4CBF["kriss_reflex"] = 1;
  level._id_4CBF["kriss_eotech"] = 1;
  level._id_4CBF["kriss_acog_silencer"] = 1;
  level._id_4CBF["m1014"] = 1;
  level._id_4CBF["m14_scoped"] = 1;
  level._id_4CBF["m14_scoped_arctic"] = 1;
  level._id_4CBF["m14_scoped_ghil"] = 1;
  level._id_4CBF["m14_scoped_silencer"] = 1;
  level._id_4CBF["m14_scoped_silencer_woodland"] = 1;
  level._id_4CBF["m14_scoped_woodland"] = 1;
  level._id_4CBF["m14ebr"] = 1;
  level._id_4CBF["m14ebr_thermal"] = 1;
  level._id_4CBF["m203"] = 1;
  level._id_4CBF["m16_acog"] = 1;
  level._id_4CBF["m16_basic"] = 1;
  level._id_4CBF["m16_grenadier"] = 1;
  level._id_4CBF["m16_reflex"] = 1;
  level._id_4CBF["m16_silencer"] = 1;
  level._id_4CBF["m21_baseasset"] = 1;
  level._id_4CBF["m21_scoped_arctic_silenced"] = 1;
  level._id_4CBF["mp5"] = 1;
  level._id_4CBF["mp5_arctic"] = 1;
  level._id_4CBF["mp5_arctic_reflex"] = 1;
  level._id_4CBF["mp5_eotech"] = 1;
  level._id_4CBF["mp5_reflex"] = 1;
  level._id_4CBF["mp5_silencer"] = 1;
  level._id_4CBF["mp5_silencer_reflex"] = 1;
  level._id_4CBF["ranger"] = 1;
  level._id_4CBF["striker"] = 1;
  level._id_4CBF["striker_reflex"] = 1;
  level._id_4CBF["striker_woodland"] = 1;
  level._id_4CBF["striker_woodland_reflex"] = 1;
  level._id_4CBF["tavor_acog"] = 1;
  level._id_4CBF["tavor_digital_acog"] = 1;
  level._id_4CBF["tavor_digital_eotech"] = 1;
  level._id_4CBF["tavor_digital_mars"] = 1;
  level._id_4CBF["tavor_digital_reflex"] = 1;
  level._id_4CBF["tavor_eotech"] = 1;
  level._id_4CBF["tavor_mars"] = 1;
  level._id_4CBF["tavor_reflex"] = 1;
  level._id_4CBF["tavor_woodland_acog"] = 1;
  level._id_4CBF["tavor_woodland_eotech"] = 1;
  level._id_4CBF["tavor_woodland_mars"] = 1;
  level._id_4CBF["tavor_woodland_reflex"] = 1;
  level._id_4CBF["tmp"] = 1;
  level._id_4CBF["tmp_reflex"] = 1;
  level._id_4CBF["tmp_silencer"] = 1;
  level._id_4CBF["ump45"] = 1;
  level._id_4CBF["ump45_acog"] = 1;
  level._id_4CBF["ump45_arctic"] = 1;
  level._id_4CBF["ump45_arctic_acog"] = 1;
  level._id_4CBF["ump45_arctic_reflex"] = 1;
  level._id_4CBF["ump45_reflex"] = 1;
  level._id_4CBF["ump45_silencer"] = 1;
  level._id_4CBF["ump45_eotech"] = 1;
  level._id_4CBF["wa2000"] = 1;
  level._id_4CBF["wa2000_thermal"] = 1;
  level._id_4CBF["g36c"] = 1;
  level._id_4CBF["g36c_acog"] = 1;
  level._id_4CBF["g36c_reflex"] = 1;
  level._id_4CBF["g36c_grenadier"] = 1;
  level._id_4CBF["pecheneg"] = 1;
  level._id_4CBF["pecheneg_reflex"] = 1;
  level._id_4CBF["gl_g36c"] = 1;
  level._id_4CBF["m240"] = 1;
  level._id_4CBF["m240_reflex"] = 1;
  level._id_4CBF["m240_acog"] = 1;
  level._id_4CBF["m4_grenadier"] = 1;
  level._id_4CBF["m4_grunt"] = 1;
  level._id_4CBF["m4_grunt_acog"] = 1;
  level._id_4CBF["m4_grunt_reflex"] = 1;
  level._id_4CBF["m4_shotgun"] = 1;
  level._id_4CBF["m4_shotgun_attach"] = 1;
  level._id_4CBF["m4_silencer"] = 1;
  level._id_4CBF["m4_silencer_acog"] = 1;
  level._id_4CBF["alt_m4m203_acog"] = 1;
  level._id_4CBF["m4m203_acog"] = 1;
  level._id_4CBF["alt_m4m203_acog_payback"] = 1;
  level._id_4CBF["m4m203_acog_payback"] = 1;
  level._id_4CBF["m4m203_reflex"] = 1;
  level._id_4CBF["m4m203_reflex_arctic"] = 1;
  level._id_4CBF["m4m203_silencer"] = 1;
  level._id_4CBF["m4m203_silencer_reflex"] = 1;
  level._id_4CBF["m4m203_eotech"] = 1;
  level._id_4CBF["scar_h"] = 1;
  level._id_4CBF["scar_h_fgrip"] = 1;
  level._id_4CBF["scar_h_acog"] = 1;
  level._id_4CBF["scar_h_grenadier"] = 1;
  level._id_4CBF["scar_h_reflex"] = 1;
  level._id_4CBF["scar_h_shotgun"] = 1;
  level._id_4CBF["scar_h_shotgun_attach"] = 1;
  level._id_4CBF["scar_h_silencer"] = 1;
  level._id_4CBF["scar_h_thermal_silencer"] = 1;
  level._id_4CBF["scar_h_thermal"] = 1;
  level._id_4CBF["scar_h_m203"] = 1;
  level._id_4CBF["m203_m4"] = 1;
  level._id_4CBF["m203_m4_acog"] = 1;
  level._id_4CBF["m203_m4_eotech"] = 1;
  level._id_4CBF["m203_m4_reflex"] = 1;
  level._id_4CBF["m203_m4_silencer"] = 1;
  level._id_4CBF["m203_m4_silencer_reflex"] = 1;
  level._id_4CBF["m203_m4_reflex_arctic"] = 1;
  level._id_4CBF["coltanaconda"] = 1;
  level._id_4CBF["deserteagle"] = 1;
  level._id_4CBF["pp2000"] = 1;
  level._id_4CBF["pp2000_reflex"] = 1;
  level._id_4CBF["pp2000_silencer"] = 1;
  level._id_4CBF["pp2000_thermal"] = 1;
  level._id_4CBF["ak47"] = 1;
  level._id_4CBF["ak47_acog"] = 1;
  level._id_4CBF["ak47_arctic"] = 1;
  level._id_4CBF["ak47_arctic_acog"] = 1;
  level._id_4CBF["ak47_arctic_eotech"] = 1;
  level._id_4CBF["ak47_arctic_grenadier"] = 1;
  level._id_4CBF["ak47_arctic_reflex"] = 1;
  level._id_4CBF["ak47_desert"] = 1;
  level._id_4CBF["ak47_desert_acog"] = 1;
  level._id_4CBF["ak47_desert_eotech"] = 1;
  level._id_4CBF["ak47_desert_grenadier"] = 1;
  level._id_4CBF["ak47_desert_reflex"] = 1;
  level._id_4CBF["ak47_digital"] = 1;
  level._id_4CBF["ak47_digital_acog"] = 1;
  level._id_4CBF["ak47_digital_eotech"] = 1;
  level._id_4CBF["ak47_digital_grenadier"] = 1;
  level._id_4CBF["ak47_digital_reflex"] = 1;
  level._id_4CBF["ak47_eotech"] = 1;
  level._id_4CBF["ak47_fall"] = 1;
  level._id_4CBF["ak47_fall_acog"] = 1;
  level._id_4CBF["ak47_fall_eotech"] = 1;
  level._id_4CBF["ak47_fall_grenadier"] = 1;
  level._id_4CBF["ak47_fall_reflex"] = 1;
  level._id_4CBF["ak47_grenadier"] = 1;
  level._id_4CBF["ak47_reflex"] = 1;
  level._id_4CBF["ak47_shotgun"] = 1;
  level._id_4CBF["ak47_shotgun_attach"] = 1;
  level._id_4CBF["ak47_silencer"] = 1;
  level._id_4CBF["ak47_thermal"] = 1;
  level._id_4CBF["ak47_woodland"] = 1;
  level._id_4CBF["ak47_woodland_acog"] = 1;
  level._id_4CBF["ak47_woodland_eotech"] = 1;
  level._id_4CBF["ak47_woodland_grenadier"] = 1;
  level._id_4CBF["ak47_woodland_reflex"] = 1;
  level._id_4CBF["gl_ak47"] = 1;
  level._id_4CBF["gl_ak47_arctic"] = 1;
  level._id_4CBF["masada"] = 1;
  level._id_4CBF["masada_acog"] = 1;
  level._id_4CBF["masada_dcburn_mt_black_off"] = 1;
  level._id_4CBF["masada_dcburn_mt_black_on"] = 1;
  level._id_4CBF["masada_digital"] = 1;
  level._id_4CBF["masada_digital_acog"] = 1;
  level._id_4CBF["masada_digital_eotech"] = 1;
  level._id_4CBF["masada_digital_grenadier_eotech"] = 1;
  level._id_4CBF["gl_masada_digital_eotech"] = 1;
  level._id_4CBF["masada_digital_reflex"] = 1;
  level._id_4CBF["masada_eotech"] = 1;
  level._id_4CBF["masada_grenadier_acog"] = 1;
  level._id_4CBF["masada_reflex"] = 1;
  level._id_4CBF["masada_silencer_motion_tracker_off"] = 1;
  level._id_4CBF["masada_silencer_motion_tracker_on"] = 1;
  level._id_4CBF["masada_silencer_mt_black_off"] = 1;
  level._id_4CBF["masada_silencer_mt_black_on"] = 1;
  level._id_4CBF["masada_silencer_mt_camo_off"] = 1;
  level._id_4CBF["masada_silencer_mt_camo_on"] = 1;
  level._id_4CBF["masada_silencer_mt_dust_off"] = 1;
  level._id_4CBF["masada_silencer_mt_dust_on"] = 1;
  level._id_4CBF["uzi"] = 1;
  level._id_4CBF["uzi_sd"] = 1;
  level._id_4CBF["uzi_silencer"] = 1;
  level._id_4CBF["uzi_akimbo"] = 1;
  level._id_4CBF["p90"] = 1;
  level._id_4CBF["p90_acog"] = 1;
  level._id_4CBF["p90_eotech"] = 1;
  level._id_4CBF["p90_reflex"] = 1;
  level._id_4CBF["p90_silencer"] = 1;
  level._id_4CBF["p90_arctic"] = 1;
  level._id_4CBF["p90_arctic_acog"] = 1;
  level._id_4CBF["p90_arctic_eotech"] = 1;
  level._id_4CBF["p90_arctic_reflex"] = 1;
  level._id_4CBF["rpd"] = 1;
  level._id_4CBF["rpd_acog"] = 1;
  level._id_4CBF["rpd_grip"] = 1;
  level._id_4CBF["rpd_reflex"] = 1;
  level._id_4CBF["sa80"] = 1;
  level._id_4CBF["sa80_scope"] = 1;
  level._id_4CBF["sa80lmg"] = 1;
  level._id_4CBF["sa80lmg_reflex"] = 1;
  level._id_4CBF["sa80lmg_scope"] = 1;
  level._id_4CBF["at4"] = 1;
  level._id_4CBF["at4_straight"] = 1;
  level._id_4CBF["model1887"] = 1;
  level._id_4CBF["usp"] = 1;
  level._id_4CBF["usp_airport"] = 1;
  level._id_4CBF["usp_silencer"] = 1;
  level._id_4CBF["dragunov"] = 1;
  level._id_4CBF["dragunov_arctic"] = 1;
  level._id_4CBF["dragunov_desert"] = 1;
  level._id_4CBF["dragunov_fall"] = 1;
  level._id_4CBF["dragunov_woodland"] = 1;
  level._id_4CBF["mg4"] = 1;
  level._id_4CBF["mg4_acog"] = 1;
  level._id_4CBF["mg4_arctic"] = 1;
  level._id_4CBF["mg4_arctic_reflex"] = 1;
  level._id_4CBF["mg4_arctic_thermal"] = 1;
  level._id_4CBF["mg4_reflex"] = 1;
  level._id_4CBF["mg4_thermal"] = 1;
  level._id_4CBF["spas12"] = 1;
  level._id_4CBF["spas12_arctic"] = 1;
  level._id_4CBF["spas12_arctic_eotech"] = 1;
  level._id_4CBF["spas12_arctic_grip"] = 1;
  level._id_4CBF["spas12_arctic_heartbeat"] = 1;
  level._id_4CBF["spas12_arctic_heartbeat_attach"] = 1;
  level._id_4CBF["spas12_arctic_reflex"] = 1;
  level._id_4CBF["spas12_eotech"] = 1;
  level._id_4CBF["spas12_grip"] = 1;
  level._id_4CBF["spas12_heartbeat"] = 1;
  level._id_4CBF["spas12_heartbeat_attach"] = 1;
  level._id_4CBF["spas12_reflex"] = 1;
  level._id_4CBF["spas12_silencer"] = 1;
  level._id_4CBF["paw20_eotech"] = 1;
  level._id_4CBF["acr_hybrid"] = 1;
  level._id_4CBF["acr_hybrid_silenced"] = 1;
  level._id_4CBF["alt_acr_hybrid"] = 1;
  level._id_4CBF["alt_acr_hybrid_silenced"] = 1;
  level._id_4CBF["p99"] = 1;
  level._id_4CBF["rsass"] = 1;
  level._id_4CBF["fnfiveseven"] = 1;
  level._id_4CBF["pp90m1"] = 1;
  level._id_4CBF["pp90m1_acog"] = 1;
  level._id_4CBF["pp90m1_eotech"] = 1;
  level._id_4CBF["pp90m1_reflex"] = 1;
  level._id_4CBF["pp90m1_silencer"] = 1;
  common_scripts\utility::flag_init("breaching_on");
  common_scripts\utility::flag_init("no_mercy");
}

_id_4CC2() {
  if(!isDefined(self.animation)) {
    return;
  }
  if(_id_4D51() && self.script_noteworthy == "manhandled") {
    var_0 = getent(self.target, "targetname");
    level._id_4CC3[self.export] = var_0;
  }

  var_1 = self._id_164F;

  if(isDefined(var_1)) {
    level._id_4CC4[var_1] = 1;
  }
  level._id_4CC5[self.animation] = 1;
}

_id_4CC6(var_0, var_1, var_2) {
  if(!isDefined(level._id_0C59["generic"][var_0])) {
    return 0;
  }
  if(!isDefined(level._id_0C59["generic"][var_0][var_1])) {
    return 0;
  }
  return 1;
}

_id_4CC7(var_0, var_1) {
  if(!isDefined(level._id_0C59["generic"][var_0])) {
    return 0;
  }
  return 1;
}

_id_4CC8() {
  if(!level._id_4CC5.size) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "_survives";
  var_0[var_0.size] = "_death";
  var_0[var_0.size] = "_death2";
  var_0[var_0.size] = "_idle";
  var_0[var_0.size] = "_manhandled_guarded";
  var_0[var_0.size] = "_manhandled";
  var_0[var_0.size] = "_manhandled_guarded_idle";
  var_0[var_0.size] = "_manhandled_idle";
  var_0[var_0.size] = "_manhandled_guarded_prepare_idle";
  var_0[var_0.size] = "_manhandled_prepare_idle";
  var_0[var_0.size] = "_manhandled_guarded_prepare";
  var_0[var_0.size] = "_manhandled_prepare";
  var_1 = [];

  foreach(var_7, var_3 in level._id_4CC4) {
    foreach(var_5 in var_0) {}
    var_1[var_1.size] = var_5 + var_7;
  }

  var_0 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_17, var_3 in level._id_4CC5) {
    var_9 = 0;

    if(isDefined(level._id_4CC9["generic"][var_17])) {
      if(isarray(level._id_4CC9["generic"][var_17])) {
        foreach(var_12, var_11 in level._id_4CC9["generic"][var_17]) {
          if(!_id_4CC6(var_17, var_12, var_11)) {
            var_9 = 1;
          }
        }
      } else if(!_id_4CC7(var_17, level._id_4CC9["generic"][var_17])) {
        var_9 = 1;
      }
    }

    foreach(var_5 in var_0) {
      var_14 = var_17 + var_5;

      if(!isDefined(level._id_4CC9["generic"][var_14])) {
        continue;
      }
      if(isarray(level._id_4CC9["generic"][var_14])) {
        foreach(var_12, var_11 in level._id_4CC9["generic"][var_14]) {
          if(!_id_4CC6(var_14, var_12, var_11)) {
            var_9 = 1;
          }
        }

        continue;
      }

      if(!_id_4CC7(var_14, level._id_4CC9["generic"][var_14])) {
        var_9 = 1;
      }
    }

    if(var_9) {
      level._id_4CC5[var_17] = undefined;
    }
  }

  level._id_4CC4 = undefined;
  level._id_4CC5 = undefined;
}

#using_animtree("generic_human");

_id_4CCA() {
  level._id_4CCB = [];
  maps\_anim::_id_1261("generic", "attach knife right", "weapon_parabolic_knife", "TAG_INHAND");
  maps\_anim::_id_1262("generic", "detach knife right", "weapon_parabolic_knife", "TAG_INHAND", "breach_react_knife_charge");
  level._id_4CC9["generic"]["takedown_room2B_soldier"] = "takedown_room2B_soldier";
  level._id_4CC9["generic"]["takedown_room2B_soldier_idle"][0] = "takedown_room2B_soldier_idle";
  level._id_4CC9["generic"]["takedown_room1Alt_soldier"] = "takedown_room1Alt_soldier";
  level._id_4CC9["generic"]["takedown_room1Alt_soldier_idle"][0] = "takedown_room1Alt_soldier_idle";
  level._id_4CC9["generic"]["takedown_room2A_soldier"] = "takedown_room2A_soldier";
  level._id_4CC9["generic"]["takedown_room2A_soldier_idle"][0] = "takedown_room2A_soldier_end_idle";
  level._id_4CC9["generic"]["takedown_room1B_soldier"] = "takedown_room1B_soldier";
  level._id_4CC9["generic"]["takedown_room1B_soldier_idle"][0] = "takedown_room1B_soldier_idle";
  level._id_4CC9["generic"]["takedown_room1A_soldier"] = "takedown_room1A_soldier";
  level._id_4CC9["generic"]["takedown_room1A_soldier_idle"][0] = "takedown_room1A_soldier_idle";
  level._id_4CC9["generic"]["hostage_chair_twitch2"] = "hostage_chair_twitch2";
  level._id_4CC9["generic"]["hostage_chair_twitch2_idle"][0] = "hostage_chair_idle";
  level._id_4CC9["generic"]["hostage_chair_twitch"] = "hostage_chair_twitch";
  level._id_4CC9["generic"]["hostage_chair_twitch_idle"][0] = "hostage_chair_idle";
  _id_4D62("hostage_chair_twitch2", ::_id_4D41);
  _id_4D62("hostage_chair_twitch", ::_id_4D41);
  level._id_4CC9["generic"]["execution_shield_soldier"] = "execution_shield_soldier";
  level._id_4CC9["generic"]["execution_shield_hostage"] = "execution_shield_hostage";
  level._id_4CC9["generic"]["execution_shield_hostage_death"] = "execution_shield_hostage_death";
  level._id_4CC9["generic"]["execution_shield_hostage_survives"] = "execution_shield_hostage_survives";
  level._id_4CC9["generic"]["execution_shield_hostage_idle"][0] = "hostage_knees_idle";
  _id_4D62("execution_shield_soldier", ::_id_4D3B);
  _id_4D62("execution_shield_hostage", ::_id_4D3E);
  level._id_4CC9["generic"]["execution_knife_soldier"] = "execution_knife_soldier";
  level._id_4CC9["generic"]["execution_knife_hostage"] = "execution_knife_hostage";
  level._id_4CC9["generic"]["execution_knife_hostage_death"] = "execution_knife_hostage_death";
  level._id_4CC9["generic"]["execution_knife_hostage_idle"][0] = "hostage_knees_idle";
  level._id_4CC9["generic"]["execution_knife_hostage_manhandled"] = "takedown_room2B_hostageA";
  level._id_4CC9["generic"]["execution_knife_hostage_manhandled_idle"][0] = "takedown_room2B_hostageA_idle";
  _id_4D62("execution_knife_hostage", ::_id_4D3E);
  _id_4D62("execution_knife_soldier", ::_id_4D3A);
  level._id_4CC9["generic"]["execution_knife2_soldier"] = "execution_knife2_soldier";
  level._id_4CC9["generic"]["execution_knife2_hostage"] = "execution_knife2_hostage";
  level._id_4CC9["generic"]["execution_knife2_hostage_death"] = "execution_knife2_hostage_death";
  level._id_4CC9["generic"]["execution_knife2_hostage_idle"][0] = "hostage_stand_idle";
  _id_4D62("execution_knife2_hostage", ::_id_4D3E);
  _id_4D62("execution_knife2_soldier", ::_id_4D3A);
  level._id_4CC9["generic"]["execution_onknees_soldier"] = "execution_onknees_soldier";
  level._id_4CC9["generic"]["execution_onknees_hostage"] = "execution_onknees_hostage";
  level._id_4CC9["generic"]["execution_onknees_hostage_idle"][0] = "execution_onknees_hostage_survives";
  level._id_4CC9["generic"]["execution_onknees_hostage_death"] = "execution_onknees_hostage_death";
  level._id_4CC9["generic"]["execution_onknees_hostage_manhandled_guarded"] = "takedown_room1A_hostageB";
  level._id_4CC9["generic"]["execution_onknees_hostage_manhandled_guarded_idle"][0] = "takedown_room1A_hostageB_idle";
  _id_4D62("execution_onknees_soldier", ::_id_4D3B);
  _id_4D62("execution_onknees_hostage", ::_id_4D3E);
  level._id_4CC9["generic"]["execution_onknees2_soldier"] = "execution_onknees2_soldier";
  level._id_4CC9["generic"]["execution_onknees2_hostage"] = "execution_onknees2_hostage";
  level._id_4CC9["generic"]["execution_onknees2_hostage_survives"] = "execution_onknees2_hostage_survives";
  level._id_4CC9["generic"]["execution_onknees2_hostage_death"] = "execution_onknees2_hostage_death";
  level._id_4CC9["generic"]["execution_onknees2_hostage_manhandled_guarded"] = "takedown_room2B_hostageB";
  level._id_4CC9["generic"]["execution_onknees2_hostage_manhandled_guarded_idle"][0] = "takedown_room2B_hostageB_idle";
  level._id_4CC9["generic"]["execution_onknees2_hostage_manhandled_guarded_prepare_idleV2"][0] = "takedown_room2A_hostageB_start_idle";
  level._id_4CC9["generic"]["execution_onknees2_hostage_manhandled_guardedV2"] = "takedown_room2A_hostageB";
  level._id_4CC9["generic"]["execution_onknees2_hostage_manhandled_guarded_idleV2"][0] = "takedown_room2A_hostageB_end_idle";
  _id_4D62("execution_onknees2_soldier", ::_id_4D3B);
  _id_4D62("execution_onknees2_hostage", ::_id_4D43);
  level._id_4CC9["generic"]["execution_slamwall_soldier"] = "execution_slamwall_soldier";
  level._id_4CC9["generic"]["execution_slamwall_hostage"] = "execution_slamwall_hostage";
  level._id_4CC9["generic"]["execution_slamwall_hostage_idle"][0] = "hostage_stand_idle";
  level._id_4CC9["generic"]["execution_slamwall_hostage_death"] = "execution_slamwall_hostage_death";
  level._id_4CC9["generic"]["execution_slamwall_hostage_manhandled_prepare"] = "takedown_room2A_hostageA_flee";
  level._id_4CC9["generic"]["execution_slamwall_hostage_manhandled_prepare_idle"][0] = "takedown_room2A_hostageA_hide_idle";
  level._id_4CC9["generic"]["execution_slamwall_hostage_manhandled"] = "takedown_room2A_hostageA";
  level._id_4CC9["generic"]["execution_slamwall_hostage_manhandled_idle"][0] = "takedown_room2A_hostageA_end_idle";
  _id_4D62("execution_slamwall_soldier", ::_id_4D3B);
  _id_4D62("execution_slamwall_hostage", ::_id_4D3E);
  level._id_4CC9["generic"]["execution_fightback_guy1_03"] = "execution_fightback_guy1_03";
  level._id_4CC9["generic"]["execution_fightback_guy2_03"] = "execution_fightback_guy2_03";
  level._id_4CC9["generic"]["execution_fightback_guy2_03_death"] = "execution_fightback_guy2_03_death";
  level._id_4CC9["generic"]["execution_fightback_guy2_03_survives"] = "execution_fightback_guy2_03_survives";
  _id_4D62("execution_fightback_guy1_03", ::_id_4D3B);
  _id_4D62("execution_fightback_guy2_03", ::_id_4D43);
  level._id_4CC9["generic"]["patrol_bored_react"] = "patrol_bored_react_walkstop";
  level._id_4CC9["generic"]["exposed_idle_react"] = "exposed_idle_reactA";
  level._id_4CC9["generic"]["chess_surprise"] = "parabolic_chessgame_surprise_b";
  level._id_4CC9["generic"]["breach_chair_reaction_v1"] = "breach_chair_reaction_v1";
  level._id_4CC9["generic"]["patrol_bored_react_walkstop"] = "patrol_bored_react_walkstop";
  level._id_4CC9["generic"]["exposed_idle_reactA"] = "exposed_idle_reactA";
  level._id_4CC9["generic"]["hostage_stand_react_front"] = "hostage_stand_react_front";
  level._id_4CC9["generic"]["hostage_stand_react_front_idle"][0] = "hostage_stand_idle";
  level._id_4CC9["generic"]["hostage_stand_react_front_manhandled"] = "takedown_room1Alt_hostage";
  level._id_4CC9["generic"]["hostage_stand_react_front_manhandled_idle"][0] = "takedown_room1Alt_hostage_idle";
  level._id_4CC9["generic"]["death_explosion_stand_B_v3"] = "death_explosion_stand_B_v3";
  level._id_4CC9["generic"]["breach_stackL_approach"] = "breach_stackL_approach";
  level._id_4CC9["generic"]["react_stand_2_run_R45"] = "react_stand_2_run_R45";
  level._id_4CCB["death_explosion_stand_B_v3"] = 1;
  _id_4D62("hostage_stand_react_front", ::_id_4D40);
  level._id_4CC9["generic"]["hostage_stand_fall"] = "hostage_stand_fall";
  level._id_4CC9["generic"]["hostage_stand_fall_idle"][0] = "hostage_knees_idle";
  level._id_4CC9["generic"]["hostage_stand_fall_idle"][1] = "hostage_knees_twitch";
  level._id_4CC9["generic"]["hostage_stand_fall_manhandled"] = "takedown_room1A_hostageA";
  level._id_4CC9["generic"]["hostage_stand_fall_manhandled_idle"][0] = "takedown_room1A_hostageA_idle";
  level._id_4CC9["generic"]["hostage_stand_fall_manhandledV2"] = "takedown_room1B_hostage";
  level._id_4CC9["generic"]["hostage_stand_fall_manhandled_idleV2"][0] = "takedown_room1B_hostage_idle";
  _id_4D62("hostage_stand_fall", ::_id_4D40);
  level._id_4CC9["generic"]["breach_react_knife_idle"] = "breach_react_knife_idle";
  level._id_4CC9["generic"]["breach_react_knife_charge"] = "breach_react_knife_charge";
  level._id_4CC9["generic"]["breach_react_knife_charge_death"] = "death_shotgun_back_v1";
  _id_4D62("breach_react_knife_charge", ::_id_4D45);
  level._id_4CC9["generic"]["breach_react_blowback_v1"] = "breach_react_blowback_v1";
  level._id_4CC9["generic"]["breach_react_blowback_v2"] = "breach_react_blowback_v1";
  level._id_4CC9["generic"]["breach_react_blowback_v3"] = "breach_react_blowback_v1";
  level._id_4CC9["generic"]["dying_crawl_back"] = "dying_crawl_back";
  _id_4D62("breach_react_blowback_v1", ::_id_4D3D);
  _id_4D62("breach_react_blowback_v2", ::_id_4D3D);
  level._id_4CC9["generic"]["breach_react_desk_v1"] = "breach_react_desk_v1";
  level._id_4CC9["generic"]["breach_react_desk_v2"] = "breach_react_desk_v2";
  level._id_4CC9["generic"]["breach_react_desk_v3"] = "breach_react_desk_v3";
  level._id_4CC9["generic"]["breach_react_desk_v4"] = "breach_react_desk_v4";
  level._id_4CC9["generic"]["breach_react_desk_v5"] = "breach_react_desk_v5";
  level._id_4CC9["generic"]["breach_react_desk_v6"] = "breach_react_desk_v6";
  level._id_4CC9["generic"]["breach_react_desk_v7"] = "breach_react_desk_v7";
  _id_4D62("breach_react_desk_v7", ::_id_4D4A);
  level._id_4CC9["generic"]["breach_react_push_guy1"] = "breach_react_push_guy1";
  level._id_4CC9["generic"]["breach_react_push_guy2"] = "breach_react_push_guy2";
  level._id_4CC9["generic"]["breach_react_guntoss_v1_guy1"] = "breach_react_guntoss_v1_guy1";
  level._id_4CC9["generic"]["breach_react_guntoss_v1_guy2"] = "breach_react_guntoss_v1_guy2";
  level._id_4CC9["generic"]["breach_react_guntoss_v2_guy1"] = "breach_react_guntoss_v2_guy1";
  level._id_4CC9["generic"]["breach_react_guntoss_v2_guy2"] = "breach_react_guntoss_v2_guy2";
  level._id_4CC9["generic"]["breach_chair_hide_reaction_v1"] = "breach_chair_hide_reaction_v1";
  level._id_4CC9["generic"]["breach_chair_hide_reaction_v1_death"] = "covercrouch_death_1";
  level._id_4CC9["generic"]["breach_chair_hide_reaction_v1_death2"] = "covercrouch_death_2";
  level._id_4CC9["generic"]["breach_chair_hide_reaction_v2"] = "breach_chair_hide_reaction_v2";
  level._id_4CC9["generic"]["breach_chair_hide_reaction_v2_death"] = "breach_chair_hide_reaction_death_v2";
  _id_4D62("breach_chair_hide_reaction_v1", ::_id_4D47);
  _id_4D62("breach_chair_hide_reaction_v2", ::_id_4D48);
  level._id_4CC9["generic"]["execution_fightback_guy1_02"] = "execution_fightback_guy1_02";
  level._id_4CC9["generic"]["execution_fightback_guy2_02"] = "execution_fightback_guy2_02";
  level._id_0C59["generic"]["hostage_knees_loop"][0] = % hostage_knees_idle;
  level._id_0C59["generic"]["hostage_knees_loop"][1] = % hostage_knees_twitch;
}

_id_4CCC() {
  level._id_0C59["generic"]["breach_friend_idle_01"][0] = % breach_flash_r1_idle;
  level._id_0C59["generic"]["breach_friend_enter_01"] = % breach_flash_r1_enter;
  level._id_0C59["generic"]["breach_friend_idle_02"][0] = % breach_flash_r2_idle;
  level._id_0C59["generic"]["breach_friend_enter_02"] = % breach_flash_r2_enter;
}

_id_4CCD() {
  var_0 = self.script_fxid;
  var_1 = self._id_4CCE;
  var_2 = common_scripts\utility::createexploder(var_0);
  var_2.v["origin"] = self.origin;
  var_2.v["angles"] = self.angles;
  var_2.v["fxid"] = var_0;
  var_2.v["delay"] = 0;
  var_2.v["exploder"] = "breach_" + var_1;
  var_2.v["soundalias"] = "nil";
}

_id_4CCF() {
  var_0 = [];
  var_1 = getEntArray("breach_left_org", "targetname");
  var_2 = getEntArray("breach_right_org", "targetname");
  var_3 = getEntArray("breach_enemy_spawner", "targetname");
  var_4 = getEntArray("breach_hostage_spawner", "targetname");
  var_5 = getEntArray("breach_friendlyenemy_spawner", "targetname");
  var_6 = getEntArray("breach_friendlyhostage_spawner", "targetname");
  var_7 = getEntArray("breach_coopenemy_spawner", "targetname");
  var_8 = getEntArray("breach_coophostage_spawner", "targetname");
  var_9 = getEntArray("breach_solid", "targetname");
  var_10 = getEntArray("breach_door_volume", "targetname");
  var_11 = getEntArray("breach_safe_volume", "targetname");
  var_12 = getEntArray("trigger_use_breach", "classname");
  var_13 = getEntArray("trigger_multiple_breachIcon", "classname");
  var_14 = getEntArray("trigger_use_breach", "classname");
  var_15 = getEntArray("breach_damage_trigger", "targetname");
  level._id_4CC9 = undefined;

  foreach(var_17 in var_1) {
    var_18 = var_17._id_4CCE;
    var_19 = "wood";

    if(isDefined(var_17._id_4CD0)) {
      switch (var_17._id_4CD0) {
        case "payback_wood":
        case "caves_wood":
        case "estate_wood_backwards":
        case "estate_wood":
        case "wood":
        case "metal":
        case "none":
          var_19 = var_17._id_4CD0;
          break;
        default:
      }
    }

    var_20 = spawnStruct();
    var_20._id_4CD1 = var_17;
    var_20._id_4CD2 = var_19;
    var_20._id_222D = [];
    var_20._id_222D["enemy"] = [];
    var_20._id_222D["hostage"] = [];
    var_20._id_222D["friendlyenemy"] = [];
    var_20._id_222D["friendlyhostage"] = [];
    var_20._id_222D["coopenemy"] = [];
    var_20._id_222D["coophostage"] = [];
    var_20._id_4CD3 = [];
    var_20._id_4CD4 = [];
    var_20.enabled = 1;
    var_20._id_4CD5 = [];
    var_20._id_4CD6 = [];
    var_20._id_4CD7 = undefined;
    var_20._id_4CD8 = [];
    var_0[var_18] = var_20;
  }

  foreach(var_17 in var_2) {
    var_18 = var_17._id_4CCE;
    var_0[var_18]._id_4CD9 = var_17;
    var_23 = spawn("script_origin", var_17.origin);
    var_23.angles = var_17.angles;
    var_20 = spawnStruct();
    var_20.entity = var_23;
    var_20._id_13FE = -90;
    var_20 maps\_utility::_id_18B9();
    var_0[var_18]._id_4CD8 = var_23;
  }

  foreach(var_26 in var_3) {}
  var_0 = var_26 _id_4CE3(var_0, "enemy");

  foreach(var_26 in var_4) {}
  var_0 = var_26 _id_4CE3(var_0, "hostage");

  foreach(var_26 in var_5) {}
  var_0 = var_26 _id_4CE3(var_0, "friendlyenemy");

  foreach(var_26 in var_6) {}
  var_0 = var_26 _id_4CE3(var_0, "friendlyhostage");

  foreach(var_26 in var_7) {}
  var_0 = var_26 _id_4CE3(var_0, "coopenemy");

  foreach(var_26 in var_8) {}
  var_0 = var_26 _id_4CE3(var_0, "coophostage");

  foreach(var_39 in var_13) {
    var_18 = var_39._id_4CCE;
    var_0[var_18]._id_4CD3[var_0[var_18]._id_4CD3.size] = var_39;
    var_40 = getent(var_39.target, "targetname");
    var_39._id_4CDA = var_40.origin;
    var_41 = getent(var_40.target, "targetname");
    var_41._id_4014 = 0;
    var_0[var_18]._id_4CD6 = var_41;
    var_40 thread _id_4CE2(var_39, var_18, var_41);
    var_42 = var_41._id_1692;
    common_scripts\utility::flag_init(var_42);
  }

  foreach(var_39 in var_14) {
    var_39 usetriggerrequirelookat();
    var_18 = var_39._id_4CCE;
    var_0[var_18].trigger = var_39;

    if(isDefined(var_39._id_4CDB)) {
      var_39 thread _id_4D1F();
    }
  }

  foreach(var_47 in var_10) {
    var_18 = var_47._id_4CCE;
    var_0[var_18]._id_4CD5 = var_47;
  }

  foreach(var_47 in var_11) {
    var_18 = var_47._id_4CCE;
    var_0[var_18]._id_4CD7 = var_47;
  }

  foreach(var_52 in var_9) {
    var_18 = var_52._id_4CCE;
    var_0[var_18]._id_4CD4[var_0[var_18]._id_4CD4.size] = var_52;
  }

  foreach(var_18, var_55 in var_0) {}
  level thread _id_4CE5(var_55, var_18);

  foreach(var_39 in var_15) {
    var_18 = var_39._id_4CCE;
    var_39 thread _id_4CE0(var_18);
  }

  level._id_4CDC = var_0;
}

_id_4CDD(var_0, var_1, var_2, var_3, var_4) {
  objective_setpointertextoverride(var_0, &"SCRIPT_WAYPOINT_BREACH");
  objective_position(var_0, (0, 0, 0));
  var_5 = [];

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_5[var_5.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_5[var_5.size] = var_3;
  }
  if(isDefined(var_4)) {
    var_5[var_5.size] = var_4;
  }
  var_6 = 0;

  foreach(var_8 in var_5) {
    var_9 = level._id_4CDC[var_8]._id_4CD1;

    if(!isDefined(var_9)) {
      return;
    }
    var_10 = anglestoright(var_9.angles);
    var_11 = var_9.origin + var_10 * -22.5 + (0, 0, 56);
    objective_additionalposition(var_0, var_6, var_11);
    var_6++;
  }
}

_id_4CDE(var_0) {
  foreach(var_2 in var_0) {
    var_3 = 0;

    foreach(var_9, var_5 in level._id_4CDC) {
      foreach(var_7 in var_5._id_4CD3) {
        if(distance(var_2.origin, var_7._id_4CDA) > 80) {
          continue;
        }
        var_2._id_4CCE = var_9;
        var_3 = 1;
        break;
      }

      if(var_3) {
        break;
      }
    }
  }
}

_id_4CDF(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1[var_1.size] = var_3._id_4CCE;

  return var_1;
}

_id_4CE0(var_0) {
  level waittill("breaching_number_" + var_0);
  wait 3;
  var_1 = getaiarray();
  var_1 = maps\_utility::_id_1843(var_1, level.players);

  foreach(var_3 in var_1) {
    if(var_3 istouching(self)) {
      return;
    }
  }

  radiusdamage(self.origin, self.radius, 500, 500);
  self delete();
}

_id_4CE1() {
  self._id_1692 = "breach_door_icon_" + self._id_4CCE;
  level thread maps\_load::_id_1F0F(self);
}

_id_4CE2(var_0, var_1, var_2) {
  thread _id_4D50(var_2);
  var_3 = newhudelem();
  var_3 setshader("breach_icon", 1, 1);
  var_3.alpha = 0;
  var_3.color = (1, 1, 1);
  var_3.x = self.origin[0];
  var_3.y = self.origin[1];
  var_3.z = self.origin[2];
  var_3 setwaypoint(1, 1);
  var_4 = spawn("script_model", self.origin);
  var_4 setModel("mil_frame_charge");
  var_4 hidepart("j_frame_charge");
  wait 0.05;
  var_5 = "breach_door_icon_" + var_1;
  common_scripts\utility::flag_wait(var_5);

  while(!var_2._id_4014) {
    wait 0.05;
  }
  var_3 destroy();
  var_4 delete();
}

_id_4CE3(var_0, var_1) {
  var_2 = self._id_4CCE;
  var_3 = 0;

  if(isDefined(self._id_4CE4)) {
    if(var_1 == "enemy" || var_1 == "hostage") {
      var_3 = self._id_4CE4;
    }
  }

  if(!isDefined(var_0[var_2]._id_222D[var_1][var_3])) {
    var_0[var_2]._id_222D[var_1][var_3] = [];
  }
  var_4 = var_0[var_2]._id_222D[var_1][var_3];
  var_4[var_4.size] = self;
  var_0[var_2]._id_222D[var_1][var_3] = var_4;

  if(var_0.size) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_4CE5(var_0, var_1) {
  var_2 = var_0._id_4CD1;
  var_3 = var_0._id_4CD9;
  var_4 = var_0._id_222D["enemy"];
  var_5 = var_0._id_222D["hostage"];
  var_6 = var_0.trigger;
  var_7 = var_0._id_4CD4;
  var_8 = var_0._id_4CD5;
  var_9 = var_0._id_4CD6;
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];

  if(isDefined(var_0._id_222D["friendlyenemy"][0])) {
    var_10 = var_0._id_222D["friendlyenemy"][0];
    var_0._id_222D["friendlyenemy"] = var_10;
  }

  if(isDefined(var_0._id_222D["friendlyhostage"][0])) {
    var_11 = var_0._id_222D["friendlyhostage"][0];
    var_0._id_222D["friendlyhostage"] = var_11;
  }

  if(isDefined(var_0._id_222D["coopenemy"][0])) {
    var_12 = var_0._id_222D["coopenemy"][0];
    var_0._id_222D["coopenemy"] = var_12;
  }

  if(isDefined(var_0._id_222D["coophostage"][0])) {
    var_13 = var_0._id_222D["coophostage"][0];
    var_0._id_222D["coophostage"] = var_13;
  }

  var_14 = spawnStruct();
  var_14.entity = var_2;
  var_14.forward = 5;
  var_14.right = 6;
  var_14._id_13FE = -90;
  var_14 maps\_utility::_id_18B9();
  var_14 = spawnStruct();
  var_14.entity = var_3;
  var_14.right = -2;
  var_14._id_13FE = 90;
  var_14 maps\_utility::_id_18B9();
  var_15 = [];

  foreach(var_18, var_17 in var_4) {}
  var_15[var_18] = var_18;

  foreach(var_18, var_17 in var_5) {}
  var_15[var_18] = var_18;

  if(var_15.size) {
    var_20 = common_scripts\utility::random(var_15);

    if(isDefined(var_4[var_20])) {
      var_4 = var_4[var_20];
    } else {
      var_4 = [];
    }
    if(isDefined(var_5[var_20])) {
      var_5 = var_5[var_20];
    } else {
      var_5 = [];
    }
  }

  var_0._id_222D["enemy"] = var_4;
  var_0._id_222D["hostage"] = var_5;
  common_scripts\utility::array_thread(var_4, maps\_utility::add_spawn_function, ::_id_4D25);
  common_scripts\utility::array_thread(var_5, maps\_utility::add_spawn_function, ::_id_4D2A);
  common_scripts\utility::array_thread(var_10, maps\_utility::add_spawn_function, ::_id_4D25);
  common_scripts\utility::array_thread(var_11, maps\_utility::add_spawn_function, ::_id_4D2A);
  common_scripts\utility::array_thread(var_12, maps\_utility::add_spawn_function, ::_id_4D25);
  common_scripts\utility::array_thread(var_13, maps\_utility::add_spawn_function, ::_id_4D2A);
  var_6 sethintstring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");

  if(!isDefined(level._id_4CE6)) {
    level._id_4CE6 = [];
  }
  level._id_4CE6 = maps\_utility::_id_0BC3(level._id_4CE6, var_6);
  var_21 = "breach_door_charge";
  var_22 = undefined;

  switch (var_0._id_4CD2) {
    case "metal":
      var_22 = "breach_door_model_metal";
      break;
    case "estate_wood":
      var_22 = "breach_door_model_estate";
      break;
    case "estate_wood_backwards":
      var_22 = "breach_door_model_estate";
      break;
    case "caves_wood":
      var_22 = "breach_door_model_caves";
      break;
    case "payback_wood":
      var_22 = "breach_door_model_payback";
      var_21 = "breach_door_charge_payback";
      break;
    case "wood":
    case "none":
      var_22 = "breach_door_model";
      break;
    default:
      break;
  }

  var_23 = maps\_utility::_id_1287(var_22);

  if(var_0._id_4CD2 == "none" || var_0._id_4CD2 == "estate_wood_backwards") {
    var_23 hide();
  }
  level._id_4CE7 = [];
  level._id_4CE7[var_1] = var_23;
  var_24 = maps\_utility::_id_1287(var_21);
  var_24 maps\_utility::_id_2807();
  var_2._id_4CE8 = [];
  var_2 _id_4D04("active_breacher_rig");
  var_25 = var_2._id_4CE8["active_breacher_rig"];
  var_25 hide();
  var_26 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_2 _id_4D03();
    var_26 = var_2._id_4CE8["passive_breacher_rig"];
    var_26 hide();
  }

  var_2._id_4CAD = var_23;
  var_2._id_4CE9 = var_24;
  var_2._id_4CEA = var_3;
  var_2._id_4CEB = var_1;
  var_2 maps\_anim::_id_11CF(var_23, "breach");
  var_2 maps\_anim::_id_11CF(var_24, "breach");
  var_2 maps\_anim::_id_11CF(var_25, "breach_player_anim");

  if(maps\_utility::_id_12C1()) {
    var_2 maps\_anim::_id_11CF(var_26, "breach_player_anim");
  }
  var_2 _id_4CF1(var_0);

  foreach(var_28 in var_2._id_4CE8) {}
  var_28 delete();

  if(isDefined(var_6)) {
    var_6 delete();
  }
  if(isDefined(var_23)) {
    var_23 delete();
  }
  if(isDefined(var_24)) {
    var_24 delete();
  }
  if(isDefined(var_2)) {
    var_2 delete();
  }
  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_4CEC(var_0) {
  if(!isDefined(level._id_4CED)) {
    return 0;
  }
  if(!isDefined(level._id_4CED[var_0])) {
    return 0;
  }
  return 1;
}

_id_4CEE(var_0, var_1) {
  var_2 = [];
  var_2[0] = var_0;

  if(isDefined(var_0._id_4CDB)) {
    var_2 = _id_4CEF(var_0._id_4CDB);
  }
  foreach(var_4 in var_2) {
    if(var_1 istouching(var_4)) {
      return 1;
    }
  }

  return 0;
}

_id_4CEF(var_0) {
  var_1 = [];
  var_2 = getEntArray("breach_door_volume", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_4CDB) && var_4._id_4CDB == var_0) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

_id_4CF0(var_0, var_1, var_2) {
  if(maps\_utility::_id_12C1()) {
    var_3 = maps\_utility::_id_133A(var_0);

    if(var_3 maps\_utility::_id_133C("laststand_downed") && var_3 maps\_utility::_id_1008("laststand_downed")) {
      return 0;
    }
    if(_id_4CEE(var_2, var_3)) {
      return 1;
    } else {
      return 0;
    }
  }

  if(var_1.size == 0) {
    return 1;
  }
  if(!_id_4CFC(var_2)) {
    return 1;
  }
  if(!_id_4D02(var_2, 1)) {
    if(getDvar("breach_requires_friendlies_in_position") == "1") {
      if(!_id_4CF3(var_1, var_2)) {
        return 0;
      }
    }
  }

  return 1;
}

_id_4CF1(var_0) {
  var_1 = var_0.trigger;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_0._id_4CD5;
  var_1 endon("death");

  for(;;) {
    var_1 waittill("trigger", var_3, var_4);

    if(gettime() == level._id_4CC0) {
      var_4 = level._id_4CF2;
    }
    var_5 = isDefined(var_4);

    if(!var_0.enabled) {
      return;
    }
    if(isalive(var_3) && !var_5) {
      if(_id_4D65()) {
        continue;
      }
    }

    if(isDefined(var_0._id_4CD7) && !maps\_utility::_id_0A36()) {
      if(isPlayer(var_3) && isalive(var_3)) {
        var_6 = var_0._id_4CD7 maps\_utility::_id_2789("axis");

        if(var_6.size) {
          thread _id_4CF6();
          continue;
        }
      }
    }

    var_7 = _id_4D1D(var_2);

    if(isPlayer(var_3) && isalive(var_3)) {
      if(_id_4CEC(var_1._id_4CCE)) {
        break;
      }

      if(_id_4CF0(var_3, var_7, var_2)) {
        if(_id_4D0F(var_0, var_3)) {
          break;
        }
      } else {
        thread _id_4CF5();
      }
      continue;
    }

    if(var_7.size) {
      _id_4D07(var_0, var_7);
      break;
    } else {
      _id_4D06(var_0);
      break;
    }
  }
}

_id_4CF3(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_4D09(var_1);

  foreach(var_5 in var_0) {
    if(isDefined(var_3)) {
      if(var_5 _id_4D0B(var_3)) {
        continue;
      }
    }

    if(!var_5 _id_4CF4()) {
      continue;
    }
    var_2++;
  }

  if(var_2 >= 2) {
    return 1;
  }
  return 0;
}

_id_4CF4() {
  if(maps\_utility::_id_0B20(self)) {
    return 0;
  }
  if(distance(level.player.origin, self.origin) < 96) {
    return 0;
  }
  return 1;
}

_id_4CF5() {
  if(maps\_utility::_id_12C1()) {
    thread _id_4CFA(&"SCRIPT_BREACH_NEED_PLAYER");
  } else {
    thread _id_4CFA(&"SCRIPT_BREACH_NEED_FRIENDLY");
  }
}

_id_4CF6() {
  thread _id_4CFA(&"SCRIPT_BREACH_TOO_MANY_ENEMIES");
}

_id_4CF7() {
  thread _id_4CFA(&"SCRIPT_BREACH_RELOADING");
}

_id_4CF8() {
  thread _id_4CFA(&"SCRIPT_BREACH_ILLEGAL_WEAPON");
}

_id_4CF9() {
  if(maps\_utility::_id_12C1()) {
    thread _id_4CFA(&"SCRIPT_BREACH_PARTNER_NOT_READY");
    return;
  }

  thread _id_4CFA(&"SCRIPT_BREACH_YOU_NOT_READY");
}

_id_4CFA(var_0) {
  level notify("breach_hint_cleanup");
  level endon("breach_hint_cleanup");
  var_1 = 20;

  if(issplitscreen()) {
    var_1 = -23;
  }
  thread maps\_utility::_id_27BB(var_0, 3, var_1);
  thread _id_4CFB();
}

_id_4CFB() {
  level notify("breach_hint_cleanup");
  level endon("breach_hint_cleanup");

  foreach(var_1 in level._id_4CE6) {
    if(isDefined(var_1)) {
      var_1 sethintstring("");
    }
  }

  level common_scripts\utility::waittill_notify_or_timeout("breaching", 3);
  maps\_utility::_id_27BD();

  foreach(var_1 in level._id_4CE6) {
    if(isDefined(var_1)) {
      var_1 sethintstring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
    }
  }
}

_id_4CFC(var_0) {
  if(isDefined(var_0._id_4CDB)) {
    return 1;
  }
  return 0;
}

_id_4CFD() {
  if(!isDefined(level._id_4CFE)) {
    return;
  }
  level._id_4CFF = 1;

  foreach(var_1 in level._id_4CFE) {
    var_1._id_4D00 = var_1.grenadeammo;
    var_1.grenadeammo = 0;
  }
}

_id_4D01() {
  if(!isDefined(level._id_4CFE)) {
    return;
  }
  if(!isDefined(level._id_4CFF)) {
    return;
  }
  foreach(var_1 in level._id_4CFE) {
    var_1.grenadeammo = var_1._id_4D00;
    var_1._id_4D00 = undefined;
  }

  level._id_4CFF = undefined;
}

_id_4D02(var_0, var_1) {
  var_2 = var_0._id_4CDB;
  var_3 = _id_4CEF(var_0._id_4CDB);
  var_3 = common_scripts\utility::array_remove(var_3, var_0);
  var_4 = var_3[0];

  foreach(var_6 in level._id_4CFE) {
    if(isDefined(var_1) && var_1) {
      if(var_6 _id_4D0B(var_4)) {
        if(var_6 _id_4CF4()) {
          return 1;
        }
      }
    }

    if(var_6 istouching(var_4)) {
      return 1;
    }
  }

  return 0;
}

_id_4D03() {
  _id_4D04("passive_breacher_rig");
  _id_4D04("active_breacher_3rd_person");
  _id_4D04("passive_breacher_3rd_person");
}

_id_4D04(var_0) {
  self._id_4CE8[var_0] = maps\_utility::_id_1287(var_0);
  self._id_4CE8[var_0] hide();
}

_id_4D05(var_0, var_1) {
  var_1._id_4014 = 1;
  var_2 = _id_4D1E(var_0._id_4CDB);

  if(isDefined(var_0._id_4CDB)) {
    level notify(var_2);
  }
  var_1 notify("breached");
  var_0 common_scripts\utility::trigger_off();
}

_id_4D06(var_0) {
  var_1 = var_0.trigger;
  var_2 = var_0._id_4CD6;
  var_3 = var_0._id_4CD4;
  var_4 = self._id_4CAD;
  var_5 = self._id_4CE9;
  _id_4D05(var_1, var_2);
  common_scripts\utility::array_call(var_3, ::connectpaths);
  common_scripts\utility::array_thread(var_3, maps\_utility::_id_2705);
  var_6 = spawnStruct();
  var_6.entity = var_4;
  var_6.forward = 4;
  var_6.right = 10;
  var_6._id_13FE = -170;
  var_6 maps\_utility::_id_18B9();
  var_5 delete();

  if(!maps\_utility::_id_12C1()) {
    return;
  }
  while(!var_2._id_4014) {
    wait 0.05;
  }
  var_7 = undefined;
  var_8 = undefined;

  if(var_0._id_222D["coopenemy"].size) {
    var_7 = var_0._id_222D["coopenemy"];
    var_8 = var_0._id_222D["coophostage"];
  } else {
    var_7 = var_0._id_222D["enemy"];
    var_8 = var_0._id_222D["hostage"];
  }

  if(var_7.size) {
    common_scripts\utility::array_call(var_7, ::stalingradspawn);
  }
  if(var_8.size) {
    common_scripts\utility::array_call(var_8, ::stalingradspawn);
  }
}

_id_4D07(var_0, var_1) {
  var_2 = var_0.trigger;
  var_3 = var_0._id_4CD5;
  var_4 = var_0._id_4CD6;
  var_5 = var_0._id_222D["enemy"];
  var_6 = var_0._id_222D["hostage"];
  var_7 = var_0._id_222D["friendlyenemy"];
  var_8 = var_0._id_222D["friendlyhostage"];
  var_9 = var_0._id_4CD4;
  var_10 = self._id_4CE9;
  var_11 = self._id_4CE8["active_breacher_rig"];
  _id_4D05(var_2, var_4);
  var_12 = var_0._id_4CD8;
  var_13 = _id_4D09(var_3);
  var_14 = getDvar("breach_requires_friendlies_in_position") == "1";

  if(!var_14) {
    if(isDefined(var_13) && _id_4D02(var_13)) {
      foreach(var_16 in var_1) {
        if(!var_16 istouching(var_3)) {
          var_1 = common_scripts\utility::array_remove(var_1, var_16);
        }
      }

      var_14 = 1;
    }
  }

  if(var_14) {
    var_18 = maps\_utility::_id_0AE9(var_12.origin, var_1);
  } else {
    var_18 = _id_4D0A(var_12.origin, var_3, var_1, var_13);
  }
  var_1 = common_scripts\utility::array_remove(var_1, var_18);

  if(var_7.size) {
    level._id_4D08 = maps\_utility::_id_272B(var_7, 1);
  }
  if(var_8.size) {
    common_scripts\utility::array_call(var_8, ::stalingradspawn);
  }
  common_scripts\utility::array_call(var_9, ::connectpaths);
  common_scripts\utility::array_thread(var_9, maps\_utility::_id_2705);
  var_18 thread _id_4D1B(1, var_12, var_4);

  if(var_1.size) {
    if(var_14) {
      var_19 = maps\_utility::_id_0AE9(var_12.origin, var_1);
    } else {
      var_19 = _id_4D0A(var_12.origin, var_3, var_1, var_13);
    }
    if(isDefined(var_19)) {
      var_19 thread _id_4D1B(2, var_12, var_4);
    } else {}
  }

  wait 1;
  _id_4CFD();
  maps\_anim::_id_1246(var_11, "breach_player_anim");
}

_id_4D09(var_0) {
  var_1 = undefined;
  var_2 = _id_4D0D(var_0);

  foreach(var_4 in var_2) {
    if(level.player istouching(var_4)) {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}

_id_4D0A(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in var_2) {
    if(isDefined(var_3)) {
      if(var_6 _id_4D0B(var_3)) {
        continue;
      }
    }

    if(!var_6 _id_4CF4()) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  if(!var_4.size) {
    return undefined;
  }
  var_4 = maps\_utility::_id_0AEC(var_0, var_4);
  var_8 = var_4[0];

  foreach(var_6 in var_4) {
    if(var_6 _id_4D0B(var_1)) {
      var_8 = var_6;
      break;
    }
  }

  return var_8;
}

_id_4D0B(var_0) {
  if(isDefined(self.goalpos)) {
    if(_id_4D0C(self.goalpos + (0, 0, 40), var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_4D0C(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;

  if(var_2 istouching(var_1)) {
    var_3 = 1;
  }
  var_2 delete();
  return var_3;
}

_id_4D0D(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  if(isDefined(var_0._id_4CDB)) {
    foreach(var_3 in level._id_4CDC) {
      if(!isDefined(var_3._id_4CD5)) {
        continue;
      }
      if(var_3._id_4CD5 == var_0) {
        continue;
      }
      if(!isDefined(var_3._id_4CD5._id_4CDB)) {
        continue;
      }
      if(isDefined(var_3._id_4CD5._id_4CDB) && var_3._id_4CD5._id_4CDB == var_0._id_4CDB) {
        var_1[var_1.size] = var_3._id_4CD5;
      }
    }
  }

  return var_1;
}

_id_4D0E(var_0, var_1) {
  var_2 = var_1["active"];
  var_3 = anglestoright(self.angles);
  var_4 = vectornormalize(var_2.origin - var_0.trigger.origin);
  var_5 = vectordot(var_3, var_4);

  if(var_5 < 0) {
    var_1["active"] = var_1["passive"];
    var_1["passive"] = var_2;
  }

  return var_1;
}

_id_4D0F(var_0, var_1) {
  var_2 = [];
  var_2["active"] = var_1;
  var_3 = self._id_4CE8["active_breacher_rig"];
  var_4 = 0;
  var_5 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_2["passive"] = maps\_utility::_id_133A(var_2["active"]);
    var_5 = self._id_4CE8["passive_breacher_rig"];
    var_6 = _id_4D4C(var_2["passive"]);

    if(var_6 == var_0) {
      var_4 = 1;
      var_6._id_4CD6._id_4D10 = 1;
      var_2 = _id_4D0E(var_0, var_2);
    } else {
      level._id_4CF2 = var_2["passive"];
      level._id_4CC0 = gettime();
      var_6.trigger notify("trigger", var_2["passive"], "passive");
    }
  }

  var_2["active"] enablebreaching();

  if(var_4) {
    var_2["passive"] disableweapons();
  }
  foreach(var_1 in var_2) {
    if(!isDefined(level._id_4D11)) {
      var_1 enableinvulnerability();
      var_1 disableweaponswitch();
      var_1 disableoffhandweapons();
      var_1 allowcrouch(0);
      var_1 allowprone(0);
      var_1 allowsprint(0);
      var_1 allowjump(0);
    }

    var_1 common_scripts\utility::_disableusability();

    if(!isDefined(var_1._id_4D12)) {
      var_1._id_4D12 = var_1 getcurrentweapon();
    }
  }

  level notify("breaching");
  level notify("breaching_number_" + self._id_4CCE);
  setsaveddvar("objectiveHide", 1);
  var_9 = var_0._id_4CD6;
  _id_4D05(var_0.trigger, var_9);
  var_10 = undefined;
  var_11 = isDefined(level._id_4CBF[var_2["active"]._id_4D12]);

  if(var_11) {
    level._id_4D13 = 2.25;
    _id_4D33();
    var_10 = 0.5;
  } else {
    level._id_4D13 = 2.15;
    _id_4D32();
    var_10 = 0.2;
  }

  var_2["active"] thread _id_4D15(var_10);

  if(maps\_utility::_id_12C1()) {
    if(!isDefined(level._id_4BCA)) {
      level._id_4BB2 = 0;
      level._id_4BB1 = 0;
      level._id_4BCA = 1;
    }
  } else {
    level._id_4BB2 = 0;
    level._id_4BB1 = 0;
  }

  var_12 = var_0._id_222D["enemy"];
  common_scripts\utility::array_call(var_12, ::stalingradspawn);
  var_13 = var_0._id_222D["hostage"];
  common_scripts\utility::array_call(var_13, ::stalingradspawn);
  var_2["active"] playerlinktoblend(var_3, "tag_player", 0.2, 0.1, 0.1);

  if(isDefined(var_2["active"]._id_4D14)) {
    thread maps\_utility::_id_2788(0.2, var_3, "tag_player", 45, 45, 90, 45);
  }
  if(var_4) {
    var_2["passive"] playerlinktoblend(var_5, "tag_player", 0.2, 0.1, 0.1);

    if(isDefined(var_2["passive"]._id_4D14)) {
      thread maps\_utility::_id_2788(0.2, var_5, "tag_player", 45, 45, 90, 45);
    }
  }

  var_2["active"] thread _id_4D17();

  if(!var_11) {
    wait 0.05;
  }
  var_14 = self._id_4CE9;
  thread maps\_anim::_id_1246(var_14, "breach");
  var_14 show();
  var_2["active"] thread _id_4D18();
  var_15 = 0;

  if(var_4) {
    thread maps\_anim::_id_1246(var_5, "breach_player_anim");
    var_2["passive"]._id_1032 = "passive_breacher_3rd_person";
    var_2["passive"] thread maps\_anim::_id_1246(var_2["passive"], "breach_player_anim");
    var_2["passive"] thread _id_4D19();
    var_2["passive"] thread _id_4D18();
    var_2["active"]._id_1032 = "active_breacher_3rd_person";
    var_2["active"] thread maps\_anim::_id_1246(var_2["active"], "breach_player_anim");
  }

  maps\_anim::_id_1246(var_3, "breach_player_anim");
  level notify("sp_slowmo_breachanim_done");
  thread _id_4D16(var_9);
  var_16 = var_0._id_4CD4;
  common_scripts\utility::array_call(var_16, ::connectpaths);
  common_scripts\utility::array_thread(var_16, maps\_utility::_id_2705);

  foreach(var_1 in var_2) {
    if(isDefined(var_1._id_4D14)) {
      var_15 = 1;
      _id_4D59();
    } else {
      var_1 unlink();
    }
    var_1 show();
  }

  if(var_15) {
    level waittill("breach_concludes");
  }
  var_2["active"] disablebreaching();

  foreach(var_1 in var_2) {
    if(!isDefined(level._id_4D11)) {
      var_1 disableinvulnerability();
      var_1 enableweaponswitch();
      var_1 enableoffhandweapons();
      var_1 allowcrouch(1);
      var_1 allowprone(1);
      var_1 allowsprint(1);
      var_1 allowjump(1);
    }

    var_1 common_scripts\utility::_enableusability();
  }

  return 1;
}

_id_4D15(var_0) {
  self endon("death");
  wait(var_0);
  self playSound("detpack_wall_plant");
}

_id_4D16(var_0) {
  var_1 = var_0._id_1692;
  level endon(var_1);
  var_2 = var_0 maps\_utility::_id_2789("bad_guys");
  maps\_utility::_id_2635(var_2);
  level notify("breach_room_has_been_cleared");
  level._id_4D08 = undefined;
  common_scripts\utility::flag_set(var_1);
}

_id_4D17() {
  self giveweapon("usp_scripted");
  self switchtoweaponimmediate("usp_scripted");

  if(isDefined(level._id_4CBF[self._id_4D12])) {
    self switchtoweaponimmediate(self._id_4D12);
  }
}

_id_4D18() {
  wait 0.5;
  self takeweapon("usp_scripted");

  if(isDefined(self._id_4D12)) {
    var_0 = self._id_4D12;
    self switchtoweapon(var_0);

    if(_id_4BBE(var_0)) {
      var_1 = weaponclipsize(var_0);

      if(self getweaponammoclip(var_0) < var_1) {
        self setweaponammoclip(var_0, var_1);
      }
    }

    self._id_4D12 = undefined;
  }
}

_id_4D19() {
  wait 2.2;
  self enableweapons();
}

_id_4BBE(var_0) {
  if(level.gameskill > 1) {
    return 0;
  }
  if(isDefined(level._id_4D1A)) {
    return !level._id_4D1A;
  }
  if(!isDefined(self._id_4D12)) {
    return 0;
  }
  if(var_0 != self._id_4D12) {
    return 0;
  }
  return 1;
}

_id_4D1B(var_0, var_1, var_2) {
  var_3 = var_2._id_1692;

  if(var_0 == 2) {
    var_4 = "breach_friend_idle_02";
    var_5 = "breach_friend_enter_02";
  } else {
    var_4 = "breach_friend_idle_01";
    var_5 = "breach_friend_enter_01";
  }

  self._id_402B = 1;
  var_6 = 1;

  if(!isDefined(self._id_0D04)) {
    var_6 = 0;
    thread maps\_utility::_id_0D04();
  }

  wait 0.5;
  self forceteleport(var_1.origin, var_1.angles);
  var_1 thread maps\_anim::_id_11C8(self, var_4, "stop_idle");
  self setgoalpos(self.origin);
  wait 3;
  thread _id_4D1C(var_0);
  var_1 notify("stop_idle");
  var_1 maps\_anim::_id_11C1(self, var_5);
  self setgoalpos(self.origin);
  level notify("friendlies_finished_breach");
  common_scripts\utility::flag_wait(var_3);

  if(!var_6) {
    maps\_utility::_id_1902();
  }
  self._id_402B = undefined;
}

_id_4D1C(var_0) {
  if(var_0 == 1) {
    wait 1;
  } else {
    wait 2;
  }
  level endon("friendlies_finished_breach");
  level endon("breach_room_has_been_cleared");

  while(!isDefined(level._id_4D08)) {
    wait 0.05;
  }
  while(isDefined(level._id_4D08) && level._id_4D08.size) {
    wait 0.05;

    if(!isDefined(level._id_4D08)) {
      break;
    }

    level._id_4D08 = maps\_utility::_id_1228(level._id_4D08);

    foreach(var_2 in level._id_4D08) {
      if(!isalive(var_2) || !isDefined(var_2)) {
        continue;
      }
      var_3 = var_2 gettagorigin("tag_eye");
      var_4 = self getmuzzlepos();
      var_5 = self getshootatpos() - var_4;

      if(self canshoot(var_3, var_5)) {
        magicbullet(self.weapon, self getmuzzlepos(), var_3);
        bullettracer(self getmuzzlepos(), var_3, 1);
        wait 0.5;
      }
    }
  }
}

_id_4D1D(var_0) {
  var_1 = [];

  if(!isDefined(level._id_4CFE)) {
    return var_1;
  }
  var_1 = maps\_utility::_id_1361(level._id_4CFE);
  var_2 = getDvar("breach_requires_friendlies_in_position") == "1";

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_402B) && var_4._id_402B == 1) {
      var_1 = common_scripts\utility::array_remove(var_1, var_4);
      continue;
    }

    if(var_2 && !var_4 istouching(var_0)) {
      var_1 = common_scripts\utility::array_remove(var_1, var_4);
      continue;
    }
  }

  return var_1;
}

_id_4D1E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }
  return "A door in breach group " + var_0 + " has been activated.";
}

_id_4D1F() {
  var_0 = self._id_4CDB;
  var_1 = _id_4D1E(var_0);
  level waittill(var_1);
  waittillframeend;
  self notify("trigger");
}

_id_4BCE() {
  if(isDefined(level._id_4BCF)) {
    self setmovespeedscale(level._id_4BCF);
  } else {
    self setmovespeedscale(1);
  }
}

_id_4BC3(var_0) {
  if(isDefined(level._id_402B) && level._id_402B == 1) {
    return;
  }
  level._id_402B = 1;
  common_scripts\utility::flag_set("breaching_on");
  level notify("slowmo_go");
  level endon("slowmo_go");
  var_1 = 0.5;
  var_2 = 0.75;
  var_3 = 0.2;

  if(isDefined(level._id_4BC5)) {
    var_3 = level._id_4BC5;
  }
  var_4 = level.player;
  var_5 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_5 = maps\_utility::_id_133A(var_4);
  }
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  var_4 thread _id_4BCB();
  thread _id_4D23(var_1 * 2, var_2 / 2);
  thread _id_4D22();
  common_scripts\utility::flag_clear("can_save");
  maps\_utility::_id_2771();
  var_4 thread _id_4D20();

  if(isDefined(var_5)) {
    var_5 thread _id_4D20();
  }
  var_4 allowmelee(0);

  if(isDefined(var_5)) {
    var_5 allowmelee(0);
  }
  maps\_utility::_id_2772(0.25);
  maps\_utility::_id_2774(var_1);
  maps\_utility::_id_2775();
  var_4 setmovespeedscale(var_3);

  if(isDefined(var_5)) {
    var_5 setmovespeedscale(var_3);
  }
  var_6 = gettime();
  var_7 = var_6 + level._id_4BC4 * 1000;

  if(!maps\_utility::_id_12C1()) {
    var_4 thread _id_4BCC();
  }
  var_4 thread _id_4BCD();

  if(isDefined(var_5)) {
    var_5 thread _id_4BCD();
  }
  var_8 = 500;
  var_9 = 1000;

  for(;;) {
    if(isDefined(level._id_4BC6)) {
      if(!level._id_4BC6) {
        if(isDefined(level._id_4BC7)) {
          var_2 = level._id_4BC7;
        }
        break;
      }

      wait 0.05;
      continue;
    }

    if(gettime() >= var_7) {
      break;
    }

    if(level._id_4BB1 <= 0 && level._id_4CBE == 0) {
      var_2 = 1.15;
      break;
    }

    if(!maps\_utility::_id_12C1()) {
      if(var_4._id_23B4 >= var_6 + var_8) {
        break;
      }

      if(var_4._id_4BC8 && gettime() - var_6 > var_9) {
        break;
      }
    }

    if(maps\_utility::_id_0A36() && common_scripts\utility::flag("special_op_terminated")) {
      break;
    }

    if(var_4._id_4BC9 || maps\_utility::_id_12C1() && var_5._id_4BC9) {
      var_2 = 0.5;
      break;
    }

    wait 0.05;
  }

  level notify("slowmo_breach_ending", var_2);
  level notify("stop_player_heartbeat");
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  maps\_utility::_id_0A16(var_2);
  maps\_utility::_id_0A17();
  var_4 allowmelee(1);

  if(isDefined(var_5)) {
    var_5 allowmelee(1);
  }
  var_4 maps\_utility::delaythread(var_2, ::_id_4D21);

  if(isDefined(var_5)) {
    var_5 maps\_utility::delaythread(var_2, ::_id_4D21);
  }
  maps\_utility::_id_0A18();
  common_scripts\utility::flag_set("can_save");
  level._id_4BCA = undefined;
  var_4 _id_4BCE();

  if(isDefined(var_5)) {
    var_5 _id_4BCE();
  }
  level notify("slomo_breach_over");
  level._id_402B = 0;
  common_scripts\utility::flag_clear("breaching_on");
  setsaveddvar("objectiveHide", 0);
}

_id_4D20() {
  self endon("clear_breaching_variable");
  self._id_2262 = 1;
  self._id_2263 = 0;
  self._id_2261 = undefined;
  var_0 = self getcurrentweaponclipammo();
  self notifyonplayercommand("player_shot_fired", "+attack");
  self notifyonplayercommand("player_shot_fired", "+attack_akimbo_accessible");

  while(isDefined(self._id_2262)) {
    self waittill("player_shot_fired");
    self._id_2263 = var_0 - self getcurrentweaponclipammo();
    wait 0.05;

    while(self isfiring()) {
      self._id_2263 = var_0 - self getcurrentweaponclipammo();
      wait 0.05;
    }
  }
}

_id_4D21() {
  self._id_2262 = undefined;
  thread maps\_utility::_id_1424("clear_breaching_variable", 0.25);
}

_id_4D22() {
  var_0 = getDvar("bg_viewKickScale");
  var_1 = getDvar("bg_viewKickMax");
  setsaveddvar("bg_viewKickScale", 0.3);
  setsaveddvar("bg_viewKickMax", "15");
  setsaveddvar("bullet_penetration_damage", 0);
  level waittill("slowmo_breach_ending");
  setsaveddvar("bg_viewKickScale", var_0);
  setsaveddvar("bg_viewKickMax", var_1);
  wait 2;
  setsaveddvar("bullet_penetration_damage", 1);
}

_id_4D23(var_0, var_1) {
  if(!isDefined(level._id_4D24)) {
    return;
  }
  visionsetnaked("slomo_breach", var_0);
  level waittill("slowmo_breach_ending", var_2);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }
  wait 1;
  visionsetnaked(level._id_4D24, var_1);
}

_id_4BCB() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

_id_4BCC() {
  level endon("slowmo_breach_ending");
  self._id_4BC8 = 0;
  common_scripts\utility::waittill_any("weapon_switch_started", "night_vision_on", "night_vision_off");
  self._id_4BC8 = 1;
}

_id_4BCD() {
  level endon("slowmo_breach_ending");
  self._id_4BC9 = 0;
  level waittill("mission failed");
  self._id_4BC9 = 1;
}

_id_4D25() {
  var_0 = self.spawner;
  self endon("death");
  maps\_utility::_id_12E2(::_id_4D28);
  thread _id_4D29();
  thread _id_4BEB();
  level thread _id_4BD0(self);

  if(isDefined(self._id_164F) && common_scripts\utility::string_starts_with(self._id_164F, "reference")) {
    var_0 = getent(self._id_164F, "targetname");
  }
  self._id_4D26 = var_0;
  var_0 maps\_anim::_id_11C0(self, self.animation);

  if(isDefined(level._id_4CC1[self.animation])) {
    var_1 = level._id_4CC1[self.animation];
    self thread[[var_1]]();
  }

  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self._id_20AF = 5000;

  if(isDefined(self._id_4D27)) {
    self.threatbias = self._id_4D27;
  }
  if(isDefined(level._id_4CCB[self.animation])) {
    self._id_0EC3 = 1;
  }
  wait(level._id_4D13);
  maps\_utility::script_delay();
  self notify("starting_breach_reaction");
  level notify("breach_enemy_anims");
  var_0 maps\_anim::_id_11C1(self, self.animation);
  self notify("finished_breach_start_anim");
}

_id_4D28(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isalive(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(!self isbadguy()) {
    return;
  }
  level._id_4CBD = gettime();
}

_id_4D29() {
  self endon("death");

  if(!common_scripts\utility::flag("no_mercy")) {
    self.ignoreme = 1;
  }
  level common_scripts\utility::waittill_either("slomo_breach_over", "friendlies_finished_breach");

  if(isDefined(self)) {
    self.ignoreme = 0;
  }
}

_id_4BEB() {
  self endon("breach_enemy_cancel_ragdoll_death");
  self._id_0EC0 = 1;
  var_0 = common_scripts\utility::waittill_any_return("death", "finished_breach_start_anim");

  if(var_0 == "finished_breach_start_anim") {
    self._id_0EC0 = undefined;
  }
}

_id_4BEC() {
  self notify("breach_enemy_cancel_ragdoll_death");
  self._id_0EC0 = undefined;
}

_id_4BD0(var_0) {
  level._id_4BB1++;
  var_1 = spawnStruct();
  var_1.enemy = var_0;
  var_1 thread _id_4BD2(var_0);
  var_1 thread _id_4BD3(var_0);
  var_1 thread _id_4BD4(var_0);
  var_1 thread _id_4BD5();
  var_1 waittill("breach_status_change", var_2);
  level._id_4BB1--;
  var_1 = undefined;
}

_id_4BD2(var_0) {
  self endon("breach_status_change");
  var_0 waittill("death");
  self notify("breach_status_change", "death");
}

_id_4BD3(var_0) {
  level._id_4BB2++;
  var_0 waittill("death");
  level._id_4BB2--;

  if(level._id_4BB2 <= 0) {
    _id_4D01();
  }
  level notify("breach_all_enemies_dead");
}

_id_4BD4(var_0) {
  self endon("breach_status_change");

  while(isalive(var_0)) {
    wait 0.05;
  }
  self notify("breach_status_change", "exception");
}

_id_4BD5() {
  self endon("breach_status_change");
  level waittill("slowmo_breach_ending");
  self notify("breach_status_change", "breach_ending");
}

_id_4D2A() {
  self endon("death");
  self._id_4D2B = 0;
  var_0 = self.spawner;
  self._id_4D26 = var_0;
  self endon("cancel_breach_behavior");
  thread _id_4D2F();
  maps\_anim::_id_11C0(self, self.animation);
  self.health = 10;
  self._id_17D3 = 1;
  self.ignorerandombulletdamage = 1;
  wait(level._id_4D13);

  if(isDefined(level._id_4CC1[self.animation])) {
    var_1 = level._id_4CC1[self.animation];
    self thread[[var_1]]();
  }

  self.allowdeath = 1;
  var_0 maps\_anim::_id_11C1(self, self.animation);
  self notify("finished_breach_start_anim");

  if(isDefined(self._id_4D2C)) {
    return;
  }
  if(_id_4D61(self.animation + "_idle")) {
    thread maps\_anim::_id_11C8(self, self.animation + "_idle", "stop_idle");
  } else {
    var_2 = "hostage_knees_loop";
    thread maps\_anim::_id_11C8(self, var_2, "stop_idle");
  }

  self._id_4D2B = 1;
}

_id_4D2D() {
  var_0 = self.health;
  self endon("death");
  self endon("saved");

  while(isDefined(self)) {
    self waittill("damage", var_1, var_2);

    if(isDefined(var_2)) {
      if(isPlayer(var_2)) {
        self kill(self.origin, level.player);
        break;
      } else if(isDefined(var_2.team) && var_2.team == "allies") {
        self.health = var_0;
      }
    }
  }
}

_id_4D2E(var_0) {
  return level._id_4CDC[var_0]._id_4CD6;
}

_id_4D2F() {
  if(maps\_utility::_id_0A36()) {
    level endon("special_op_terminated");
  }
  level endon("mission failed");
  var_0 = self.health;
  var_1 = 0;
  thread _id_4D2D();
  var_2 = _id_4D2E(self._id_4CCE);

  if(getDvar("hostage_missionfail") == "0") {
    return;
  }
  while(isDefined(self)) {
    self waittill("death", var_3);

    if(isDefined(var_3)) {
      if(isPlayer(var_3)) {
        level notify("player_shot_a_hostage");
        waittillframeend;

        if(level._id_4CBD == gettime()) {
          _id_4D30(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE", "@SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
        } else {
          _id_4D30(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE", "@SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
        }
        var_1 = 1;
      } else if(isDefined(var_3.team) && var_3.team == "allies" && !isPlayer(var_3)) {
        _id_4D30(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED", "@SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
        var_1 = 1;
      } else {
        if(_id_4D31(var_2)) {
          _id_4D30(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR", "@SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR");
        } else {
          _id_4D30(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED", "@SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
        }
        var_1 = 1;
      }
    }

    if(var_1 == 1) {
      thread maps\_utility::_id_1826();
      level notify("mission failed");
    }
  }
}

_id_4D30(var_0, var_1) {
  if(maps\_utility::_id_0A36()) {
    maps\_specialops::_id_183F(var_1);
  } else {
    setDvar("ui_deadquote", var_0);
  }
}

_id_4D31(var_0) {
  if(!maps\_utility::_id_0A36()) {
    return 0;
  }
  if(!maps\_utility::_id_12C1()) {
    return 0;
  }
  if(isDefined(var_0._id_4D10)) {
    return 1;
  } else {
    return 0;
  }
}

#using_animtree("script_model");

_id_4443() {
  level._id_0C59["breach_door_model"]["breach"] = % breach_player_door_v2;
  level._id_1245["breach_door_model"] = #animtree;
  level._id_1F90["breach_door_model"] = "com_door_01_handleright";
  level._id_0C59["breach_door_hinge"]["breach"] = % breach_player_door_hinge_v1;
  level._id_1245["breach_door_hinge"] = #animtree;
  level._id_1F90["breach_door_hinge"] = "com_door_piece_hinge";
  level._id_0C59["breach_door_model_metal"]["breach"] = % breach_player_door_v2;
  level._id_1245["breach_door_model_metal"] = #animtree;
  level._id_1F90["breach_door_model_metal"] = "breach_door_metal_right";
  level._id_0C59["breach_door_hinge_metal"]["breach"] = % breach_player_door_metal;
  level._id_1245["breach_door_hinge_metal"] = #animtree;
  level._id_1F90["breach_door_hinge_metal"] = "breach_door_metal_right_dst";
  level._id_0C59["breach_door_charge"]["breach"] = % breach_player_frame_charge_v3;
  level._id_1245["breach_door_charge"] = #animtree;
  level._id_1F90["breach_door_charge"] = "mil_frame_charge";
  level._id_1245["desk"] = #animtree;
  level._id_0C59["desk"]["breach_react_desk_v7_desk"] = % breach_react_desk_v7_desk;
  level._id_1245["chair"] = #animtree;
  level._id_0C59["chair"]["breach_chair_hide_reaction_v2_chair"] = % breach_chair_hide_reaction_v2_chair;
  level._id_0C59["chair"]["breach_chair_hide_reaction_death_v2_chair"] = % breach_chair_hide_reaction_death_v2_chair;
}

_id_4D32() {
  level._id_0C59["breach_door_charge"]["breach"] = % breach_player_frame_charge_v3;
}

_id_4D33() {
  level._id_0C59["breach_door_charge"]["breach"] = % breach_player_frame_charge;
}

#using_animtree("multiplayer");

_id_4444() {
  if(!isDefined(level._id_4D34)) {
    level._id_4D34 = "viewhands_player_sas_woodland";
  }
  level._id_1245["active_breacher_rig"] = #animtree;
  level._id_1F90["active_breacher_rig"] = level._id_4D34;
  level._id_0C59["active_breacher_rig"]["breach_player_anim"] = % breach_coop_player_1;

  if(maps\_utility::_id_12C1()) {
    level._id_0C59["active_breacher_rig"]["breach_player_anim"] = % breach_coop_player_1;
    level._id_1245["active_breacher_3rd_person"] = #animtree;
    level._id_1F90["active_breacher_3rd_person"] = level._id_4D34;
    level._id_0C59["active_breacher_3rd_person"]["breach_player_anim"] = % breach_coop_player_1_3rdperson;
    level._id_0C59["active_breacher_3rd_person"]["root"] = % code;
    level._id_1245["passive_breacher_rig"] = #animtree;
    level._id_1F90["passive_breacher_rig"] = level._id_4D34;
    level._id_0C59["passive_breacher_rig"]["breach_player_anim"] = % breach_coop_player_2;
    level._id_1245["passive_breacher_3rd_person"] = #animtree;
    level._id_1F90["passive_breacher_3rd_person"] = level._id_4D34;
    level._id_0C59["passive_breacher_3rd_person"]["breach_player_anim"] = % breach_coop_player_2_3rdperson;
    level._id_0C59["passive_breacher_3rd_person"]["root"] = % code;
  }

  level._id_4D35 = [];
  _id_4D36(::_id_4D38);
  maps\_anim::_id_1264("active_breacher_rig", "explode", ::_id_4D37);
  maps\_anim::_id_1264("active_breacher_rig", "slowmo", ::_id_4BC3);
}

_id_4D36(var_0) {
  level._id_4D35[level._id_4D35.size] = var_0;
}

_id_4D37(var_0) {
  foreach(var_2 in level._id_4D35) {}
  thread[[var_2]](var_0);
}

_id_4D38(var_0) {
  var_1 = level._id_4CDC[self._id_4CEB];
  var_2 = undefined;
  var_3 = undefined;

  switch (var_1._id_4CD2) {
    case "wood":
      var_2 = "detpack_explo_wood";
      var_3 = "breach_door_hinge";
      break;
    case "estate_wood":
      var_2 = "detpack_explo_wood";
      var_3 = "breach_door_hinge_estate";
      break;
    case "estate_wood_backwards":
      var_2 = "detpack_explo_wood";
      var_3 = undefined;
      break;
    case "caves_wood":
      var_2 = "detpack_explo_wood";
      var_3 = "breach_door_hinge_caves";
      break;
    case "payback_wood":
      var_2 = "pybk_breach_blast";
      var_3 = "breach_door_hinge_payback";
      break;
    case "metal":
      var_2 = "detpack_explo_metal";
      var_3 = "breach_door_hinge_metal";
      break;
    case "none":
      var_2 = "detpack_explo_concrete";
      break;
    default:
      break;
  }

  if(isDefined(var_2)) {
    thread common_scripts\utility::play_sound_in_space(var_2, self._id_4CE9.origin);
  }
  common_scripts\utility::exploder("breach_" + self._id_4CEB);
  thread _id_4D39(self._id_4CE9.origin);
  self._id_4CE9 delete();
  level notify("breach_explosion");

  if(isDefined(var_3)) {
    var_4 = maps\_utility::_id_1287(var_3);
    self._id_4CEA thread maps\_anim::_id_1246(var_4, "breach");
  }

  wait 0.05;

  if(isDefined(self._id_4CAD)) {
    self._id_4CAD delete();
  }
}

_id_4D39(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1.origin = var_0;
  var_1 playrumbleonentity("grenade_rumble");
  wait 4;
  var_1 delete();
}

_id_4D3A() {
  self endon("death");
  self.dodamagetoall = 1;
  thread _id_4D46();
}

_id_4D3B() {
  self endon("death");
  self.dodamagetoall = 1;
  thread _id_4D3C();
}

_id_4D3C() {
  animscripts\notetracks::_id_23F2();
}

_id_4D3D() {
  self endon("death");

  if(!common_scripts\utility::flag("no_mercy")) {
    self.ignoreme = 1;
  }
  self._id_0D41 = 1;
  maps\_utility::_id_263F("bodyfall large");
  self waittill("finished_breach_start_anim");
  self dodamage(self.health - 1, self.origin);
}

_id_4D3E() {
  if(self.animation == "execution_knife_hostage" || self.animation == "execution_knife2_hostage") {
    thread _id_4D42();
  }
  if(_id_4D51()) {
    thread _id_4D55();
  }
  self._id_4D2C = 1;
  self endon("death");
  maps\_utility::_id_2739(self.animation + "_death");
  self waittill("finished_breach_start_anim");

  if(isDefined(self._id_4D3F)) {
    return;
  }
  if(_id_4D61(self.animation + "_survives")) {
    self._id_4D26 maps\_anim::_id_11C1(self, self.animation + "_survives");
  }
  thread maps\_anim::_id_11C8(self, self.animation + "_idle", "stop_idle");
  self._id_4D2B = 1;
}

_id_4D40() {
  if(_id_4D51()) {
    thread _id_4D55();
  }
  self._id_4D2C = 1;
  self waittill("finished_breach_start_anim");

  if(isDefined(self._id_4D3F)) {
    return;
  }
  if(_id_4D61(self.animation + "_idle")) {
    thread maps\_anim::_id_11C8(self, self.animation + "_idle", "stop_idle");
  }
  self._id_4D2B = 1;
}

_id_4D41() {
  var_0 = spawn("script_model", self._id_4D26.origin);
  var_0 setModel("com_restaurantchair_2");
  var_0.angles = self._id_4D26.angles + (0, 90, 0);
  var_0.origin = self._id_4D26.origin;
}

_id_4D42() {
  var_0 = maps\_utility::_id_1EE9(self.origin, "bad_guys");
  self waittill("finished_breach_start_anim");

  if(isDefined(var_0) && isalive(var_0)) {
    playFXOnTag(common_scripts\utility::getfx("breach_knife_execution"), self, "J_neck");
    thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
    self kill();
  }
}

_id_4D43() {
  self._id_4D2C = 1;
  self endon("death");

  if(_id_4D51()) {
    thread _id_4D55();
  }
  self waittillmatch("single anim", "bodyfall large");
  maps\_utility::_id_2739(self.animation + "_death");
  self waittill("finished_breach_start_anim");
  maps\_anim::_id_11C1(self, self.animation + "_survives");

  if(isDefined(self._id_4D3F)) {
    return;
  }
  thread maps\_anim::_id_11C8(self, "hostage_knees_loop", "stop_idle");
  self._id_4D2B = 1;
}

_id_4D44() {
  self._id_4D2C = 1;
  self endon("death");
  self waittill("finished_breach_start_anim");
  maps\_utility::_id_2739(self.animation + "_death");
  maps\_anim::_id_11C1(self, self.animation + "_survives");
  thread maps\_anim::_id_11C8(self, "hostage_knees_loop", "stop_idle");
  self._id_4D2B = 1;
}

_id_4D45() {
  self endon("death");
  _id_4BEC();
  maps\_utility::_id_2739(self.animation + "_death");
  self waittillmatch("single anim", "stab");
  wait 0.1;
  thread _id_4BEA();
  self waittill("finished_breach_start_anim");
}

_id_4BEA() {
  var_0 = maps\_utility::_id_2608(self.origin);
  var_1 = distance(var_0.origin, self.origin);

  if(var_1 <= 50) {
    var_0 playrumbleonentity("grenade_rumble");
    var_0 thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
    var_0 enablehealthshield(0);
    var_0 enabledeathshield(0);
    waittillframeend;
    var_0 dodamage(var_0.health + 50000, self gettagorigin("tag_weapon_right"), self);
    var_0._id_4BC9 = 1;
  }
}

_id_4D46() {
  wait 0.5;
  common_scripts\utility::waittill_either("damage", "finished_breach_start_anim");

  if(isDefined(self)) {
    self detach("weapon_parabolic_knife", "TAG_INHAND");
  }
}

_id_4D47() {
  self endon("death");
  _id_4BEC();
  var_0 = randomintrange(1, 3);

  if(common_scripts\utility::cointoss()) {
    maps\_utility::_id_2739(self.animation + "_death");
  } else {
    maps\_utility::_id_2739(self.animation + "_death2");
  }
}

_id_4D48() {
  self endon("death");
  _id_4BEC();
  maps\_utility::_id_2739(self.animation + "_death");
  thread _id_4D49();
  self waittill("finished_breach_start_anim");
  thread _id_4D47();
}

_id_4D49() {
  var_0 = spawn("script_model", self._id_4D26.origin);
  var_0 setModel("furniture_chair_metal01");
  var_0._id_1032 = "chair";
  var_0 maps\_utility::_id_2629();
  var_0._id_4D26 = spawn("script_origin", self._id_4D26.origin);
  var_0._id_4D26.angles = self._id_4D26.angles;
  self waittill("starting_breach_reaction");
  var_0._id_4D26 thread maps\_anim::_id_1246(var_0, "breach_chair_hide_reaction_v2_chair");
  self endon("finished_breach_start_anim");

  if(isalive(self)) {
    self waittill("death");
    var_0._id_4D26 thread maps\_anim::_id_1246(var_0, "breach_chair_hide_reaction_death_v2_chair");
  }
}

_id_4D4A() {
  self endon("death");
  thread _id_4D4B();
  self waittill("finished_breach_start_anim");
}

_id_4D4B() {
  var_0 = spawn("script_model", self._id_4D26.origin);
  var_0 setModel("furniture_long_desk_animate");
  var_0._id_1032 = "desk";
  var_0 maps\_utility::_id_2629();
  var_0._id_4D26 = spawn("script_origin", self._id_4D26.origin);
  var_0._id_4D26.angles = self._id_4D26.angles;
  self waittill("starting_breach_reaction");
  var_0._id_4D26 thread maps\_anim::_id_1246(var_0, "breach_react_desk_v7_desk");
}

_id_4D4C(var_0) {
  foreach(var_2 in level._id_4CDC) {
    if(var_0 istouching(var_2._id_4CD5)) {
      return var_2;
    }
  }
}

_id_4D4D() {
  var_0 = getarraykeys(level._id_4CDC);
  return var_0;
}

_id_4D4E(var_0) {
  level._id_4CDC[var_0].enabled = 0;
}

_id_4D4F(var_0) {
  level._id_4CDC[var_0].trigger delete();
  var_1 = level._id_4CDC[var_0]._id_4CD4;
  common_scripts\utility::array_call(var_1, ::connectpaths);
  common_scripts\utility::array_thread(var_1, maps\_utility::_id_2705);

  foreach(var_3 in level._id_4CDC[var_0]._id_4CD3) {}
  var_3 delete();
}

_id_4D50(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = self.origin;
  wait 0.05;

  if(getDvar("breach_debug") == "0") {
    return;
  }
  var_2 = [];
  var_3 = getEntArray("breach_enemy_spawner", "targetname");
  var_4 = getEntArray("breach_hostage_spawner", "targetname");
  var_2 = maps\_utility::_id_1843(var_3, var_4);

  foreach(var_6 in var_2) {
    if(!var_6 istouching(var_0)) {
      var_2 = common_scripts\utility::array_remove(var_2, var_6);
    }
  }

  while(!var_0._id_4014) {
    var_8 = var_1;

    foreach(var_6 in var_2) {
      if(isDefined(var_6.animation)) {
        thread maps\_utility::_id_1B94(var_6.animation, var_8, 1);
        var_8 = var_8 - (0, 0, 10);
      }
    }

    wait 1;
  }
}

_id_4D51() {
  if(maps\_utility::_id_12C1()) {
    return 0;
  }
  if(isDefined(level._id_4D52) && level._id_4D52 == 0) {
    return 0;
  }
  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy == "manhandled" || self.script_noteworthy == "manhandled_guarded";
  }
  return 0;
}

_id_4D53() {
  if(level._id_4BB2 > 0) {
    return 1;
  }
  if(!self._id_4D54) {
    return 1;
  }
  return 0;
}

_id_4D55() {
  self endon("death");
  self._id_4D3F = 1;
  self._id_4D56 = 0;
  self._id_4D54 = 0;
  var_0 = undefined;

  if(self.script_noteworthy == "manhandled") {
    var_0 = getent(self.target, "targetname");
  }
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = "";

  if(isDefined(self._id_164F)) {
    var_6 = self._id_164F;
  }
  switch (self.script_noteworthy) {
    case "manhandled":
      var_4 = self.animation + "_manhandled";
      break;
    case "manhandled_guarded":
      var_4 = self.animation + "_manhandled_guarded";
      break;
  }

  var_5 = var_4 + "_idle" + var_6;
  var_2 = var_4 + "_prepare" + var_6;
  var_3 = var_4 + "_prepare_idle" + var_6;
  var_4 = var_4 + var_6;
  _id_4D60(var_4);
  _id_4D60(var_5);

  if(self.script_noteworthy == "manhandled") {
    var_1 = var_0 maps\_utility::_id_166F(1);
    var_1 hide();
    self._id_4D26 maps\_anim::_id_11C0(var_1, var_1.animation);
    var_1 pushplayer(1);
    level._id_4D57 = var_1;
    var_1._id_4D58 = 0;
    var_1 thread _id_4D5F();
  }

  wait 1;

  if(self.script_noteworthy == "manhandled") {
    var_1 show();
  }
  self waittill("finished_breach_start_anim");

  if(_id_4D61(var_2)) {
    self._id_4D26 maps\_anim::_id_11C1(self, var_2);
  }
  if(_id_4D61(var_3)) {
    self._id_4D26 thread maps\_anim::_id_11C8(self, var_3, "stop_idle");
  } else {
    var_3 = undefined;
  }
  self._id_4D56 = 1;

  if(isDefined(var_3)) {
    while(_id_4D53()) {
      wait 0.05;
    }
  }

  self._id_4D26 notify("stop_idle");
  self notify("stop_idle");

  if(self.script_noteworthy == "manhandled") {
    self._id_4D26 thread maps\_anim::_id_11C1(var_1, var_1.animation);
  }
  self._id_4D26 maps\_anim::_id_11C1(self, var_4);

  if(isDefined(var_1) && isDefined(level._id_0C59["generic"][var_1.animation + "_idle"])) {
    self._id_4D26 thread maps\_anim::_id_11C8(var_1, var_1.animation + "_idle", "stop_idle");
  }
  if(isDefined(level._id_0C59["generic"][var_5])) {
    self._id_4D26 thread maps\_anim::_id_11C8(self, var_5, "stop_idle");
  }
}

_id_4D59() {
  var_0 = level.player getplayerangles();
  var_0 = (0, var_0[1], 0);
  var_1 = anglesToForward(var_0);
  var_2 = anglestoup(var_0);
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = level.player.origin;
  var_3.angles = var_0;
  level.player playerlinktodelta(var_3, "tag_origin", 1, 45, 45, 90, 45, 1);
  var_4 = 0.45;
  var_3 moveto(var_3.origin + var_1 * 32 + var_2 * -14, var_4, var_4 * 0.4, var_4 * 0.4);
  wait(var_4);
  level.player setmovespeedscale(0.5);
  thread _id_4D5B();
  level.player unlink();
  level._id_4D5A thread _id_4D5D();
  level._id_4D5A thread _id_4D5C();
}

_id_4D5B() {
  wait 0.25;
  var_0 = level maps\_utility::_id_27C1(::_id_4D5E, 0.5, 0);
  var_0.time = 1.5;
}

_id_4D5C() {
  self endon("stop_following_player");
  wait 1.5;

  for(;;) {
    self moveto(level.player.origin, 2, 0, 0);
    wait 0.05;
  }
}

_id_4D5D() {
  self endon("stop_following_player");
  var_0 = spawn("script_origin", (0, 0, 0));

  for(;;) {
    var_1 = level.player.origin;
    var_1 = maps\_utility::_id_27A7(var_1, 0);
    var_2 = self.origin;
    var_2 = maps\_utility::_id_27A7(var_2, 0);
    var_3 = vectortoangles(var_1 - var_2);
    var_4 = anglesToForward(var_3);
    var_5 = anglesToForward(self.angles);
    var_6 = anglestoright(self.angles);
    var_7 = vectordot(var_4, var_6);
    var_0.angles = self.angles;
    var_8 = abs(acos(var_7));
    var_9 = 2;

    if(var_9 > var_8) {
      var_9 = var_8;
    }
    if(var_7 < 0) {
      var_0 addyaw(var_9);
    } else {
      var_0 addyaw(var_9 * -1);
    }
    self rotateto(var_0.angles, 0.15);
    wait 0.15;
  }
}

_id_4D5E(var_0, var_1, var_2) {
  level.player setmovespeedscale(var_1 * (1 - var_0) + var_2 * var_0);
}

_id_4D5F() {
  level endon("mission failed");

  if(getDvar("hostage_missionfail") == "1") {
    level endon("player_shot_a_hostage");
  }
  thread maps\_utility::_id_0D04();
  maps\_utility::_id_1058(1);

  if(!common_scripts\utility::flag("no_mercy")) {
    self.ignoreme = 1;
  }
  self.grenadeawareness = 0;
  wait 1;
  var_0 = [];
  var_1 = getaispeciesarray("neutral", "civilian");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_4D56)) {
      continue;
    }
    if(isDefined(var_3._id_4CCE) && var_3._id_4CCE == self._id_4CCE) {
      if(isDefined(var_3.script_noteworthy) && issubstr(var_3.script_noteworthy, "manhandled")) {
        var_0 = maps\_utility::_id_0BC3(var_0, var_3);
      }
    }
  }

  var_5 = var_0.size;
  var_6 = var_0;

  while(var_5 > 0) {
    wait 0.05;

    foreach(var_3 in var_6) {
      if(!isDefined(var_3) || var_3._id_4D56 == 1) {
        var_6 = common_scripts\utility::array_remove(var_6, var_3);
        var_5--;
      }
    }
  }

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      var_3._id_4D54 = 1;
    }
  }
}

_id_4D60(var_0) {}

_id_4D61(var_0) {
  if(isDefined(level._id_0C59["generic"][var_0])) {
    return 1;
  } else {
    return 0;
  }
}

_id_4D62(var_0, var_1) {
  level._id_4CC1[var_0] = var_1;
}

_id_4D63() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(level._id_4CFE)) {
    level._id_4CFE = [];
    level._id_4CFE[0] = self;
  } else if(maps\_utility::is_in_array(level._id_4CFE, self)) {
    return;
  } else {
    level._id_4CFE = maps\_utility::_id_0BC3(level._id_4CFE, self);
  }
}

_id_4D64() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(level._id_4CFE)) {
    return;
  }
  if(maps\_utility::is_in_array(level._id_4CFE, self)) {
    level._id_4CFE = common_scripts\utility::array_remove(level._id_4CFE, self);
  }
}

_id_4D65() {
  var_0 = [];
  var_0[var_0.size] = ::ismeleeing;
  var_0[var_0.size] = ::isswitchingweapon;
  var_0[var_0.size] = ::isthrowinggrenade;

  foreach(var_2 in level.players) {
    if(var_2 isreloading()) {
      thread _id_4CF7();
      return 1;
    }

    if(var_2 _id_4D66()) {
      thread _id_4CF8();
      return 1;
    }

    foreach(var_4 in var_0) {
      if(var_2 call[[var_4]]()) {
        thread _id_4CF9();
        return 1;
      }
    }
  }

  return 0;
}

_id_4D66() {
  var_0 = [];
  var_0["riotshield"] = 1;
  var_0["claymore"] = 1;
  var_0["c4"] = 1;
  var_0["none"] = 1;
  var_1 = self getcurrentweapon();
  return isDefined(var_0[var_1]);
}

_id_4D67() {
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.4);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.4);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
}