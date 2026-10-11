/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\scripted_weapon_assignment.gsc
********************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace scripted_weapon_assignment;

function getscriptedweapon(weaponname, weaponposition) {
  setdvarifuninitialized(@ "hash_45281f93550798", 0);

  if(!isDefined(weaponname)) {
    return nullweapon();
  }

  if(!isarray(weaponname) && weaponname == "") {
    return nullweapon();
  }

  if(isstring(weaponname) && issubstr(weaponname, "riotshield")) {
    return [[level.fnbuildweapon]](weaponname);
  }

  if(isDefined(weaponposition) && weaponposition == "sidearm") {
    weapon = getweapon(weaponname, "pistol");
  } else {
    weapon = getweapon(weaponname, self.scriptedweaponclassprimary);
  }

  return weapon;
}

function getweapon(weaponname, weapontype) {
  weaponarray = [];

  if(isarray(weaponname)) {
    weaponarray = weaponname;
    weaponname = weaponname[randomint(weaponname.size)];
  }

  low_classname = tolower(self.classname);

  if(!issubstr(low_classname, "_iw9_") && !issubstr(low_classname, "_jup_")) {
    function_3067ab4eb4ea11bc();

    return make_weapon(weaponname);
  }

  if(issubstr(low_classname, "_jup_")) {
    if(issubstr(low_classname, "_hero_") || issubstr(low_classname, "_villain_")) {
      return function_8235813c1c9d2f08(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_rus_pmc_") || issubstr(low_classname, "_security")) {
      return function_2fafb44aac177345(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_rus_kas")) {
      return function_212de1183c53e8(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_swat_")) {
      return function_ae38ecc687e7c901(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_uk_police_")) {
      return function_4ce97548a610e1bf(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_police_")) {
      return function_4441fee08ec94cdd(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_paramedic_")) {
      return function_ef52cc59c1b2e548(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_gulag_guard_") || issubstr(low_classname, "_prisoner_")) {
      return function_951704f451830a80(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_reb_")) {
      return function_ec3afdeda11b4349(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_sas_urban_")) {
      return function_1ad896c57dd5eac6(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "sas_bravo_")) {
      return function_dc545d7e8b75abc2(weapontype, weaponname, weaponarray);
    } else {
      function_3067ab4eb4ea11bc();

      return make_weapon(weaponname);
    }
  } else if(issubstr(low_classname, "_iw9_")) {
    if(issubstr(low_classname, "_hero_") || issubstr(low_classname, "_villain_")) {
      return function_58b6f3799af2dbbc(weaponname, weaponarray);
    } else if(issubstr(low_classname, "_mex_sf_")) {
      return function_599b2370665f8002(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_mex_police_")) {
      return function_599b2370665f8002(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_mex_")) {
      return function_53e5f63c1e2a01ee(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_reb_")) {
      return function_f6839b3d503efa3d(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_usmc_")) {
      return function_4b7d1f618622e1c4(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_cartel_guard_")) {
      return function_4088385bffccb0a1(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_cartel_")) {
      return function_58d868a0b0dac3bb(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_rus_pmc_")) {
      return function_d2e456774b5818b9(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_pmc_")) {
      return function_dccb603d3e9a2268(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_frogman_")) {
      return function_a6330cf7bdaa288e(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "_aq_")) {
      return function_5f405a21c1883ed2(weapontype, weaponname, weaponarray);
    } else {
      function_3067ab4eb4ea11bc();

      return make_weapon(weaponname);
    }
  } else {
    function_3067ab4eb4ea11bc();

    return make_weapon(weaponname);
  }

  return weaponname;
}

function function_8235813c1c9d2f08(type, weaponname, weaponarray) {
  if(self.classname == "actor_jup_ally_hero_farah" || self.classname == "actor_jup_ally_hero_farah_silo" || self.classname == "actor_jup_ally_hero_farah_tundra") {
    switch (weaponname) {
      case #"hash_a89739756fa439cf":
        return make_weapon_special("iw9_ar_akilo_v4");
    }
  } else if(self.classname == "actor_jup_ally_hero_ghost_urban") {
    switch (weaponname) {
      case #"hash_82d03e9871615139":
        return make_weapon_special("iw9_ar_mcbravo_v1");
    }
  } else if(self.classname == "actor_jup_ally_hero_price_tundra") {
    switch (weaponname) {
      case #"hash_aa1268e549fd317":
        return make_weapon_special("iw9_ar_mike4_v1");
    }
  } else if(self.classname == "actor_jup_ally_hero_soap_tundra") {
    switch (weaponname) {
      case #"hash_accc6d1d86e48732":
        return make_weapon_special("iw9_dm_xmike2010_v1");
    }
  } else if(self.classname == "actor_jup_ally_hero_alex") {
    switch (weaponname) {
      case #"hash_7e1d746d4a36491e":
        return make_weapon_special("iw9_dm_mike14_v1");
    }
  } else if(self.classname == "actor_jup_ally_hero_kyle_tundra") {
    switch (weaponname) {
      case #"hash_73753b6a3bde7482":
        return make_weapon_special("iw9_ar_mcharlie_v2");
    }
  }

  return make_weapon(weaponname, []);
}

function function_2fafb44aac177345(type, weaponname, weaponarray) {
  camos = getweapon_camos("rus_pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo_sp"] = 30;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 30;
      weaponprobabilities["jup_jp01_ar_golf36_sp"] = 40;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_a89739756fa439cf":
          possibilities["barrels"] = [50, "bar_ar_hvylong_p04_akilo", "bar_ar_long_p04", "bar_ar_heavy_p04", "bar_ar_hvyshort_p04_akilo"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_heavy_p04"];
          possibilities["mags"] = [50, "mag_ar_p04", "mag_ar_small_p04", "mag_ar_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "ub_gl_akilo"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_6558b7569b2f833c":
          possibilities["scopes"] = [75, "jup_twofivex_golf36", "jup_fourx01", "jup_fourx02", "jup_reflex01_tall", "jup_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "jup_jp01_ar_golf36_stock_tac", "jup_jp01_ar_golf36_stock_assault", "jup_jp01_ar_golf36_stock_skel"];
          possibilities["barrels"] = [50, "jup_jp01_ar_golf36_bar_short", "jup_jp01_ar_golf36_bar_short_heavy"];
          possibilities["mags"] = [50, "jup_jp01_ar_golf36_mag_30_556n", "jup_jp01_ar_golf36_mag_40_556n"];
          possibilities["grips"] = [30, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_ff9799d32cdfe811":
          possibilities["barrels"] = [50, "jup_jp06_lm_pkilop_bar_light", "jup_jp06_lm_pkilop_bar_heavy", "jup_jp06_lm_pkilop_bar_short"];
          possibilities["stocks"] = [50, "jup_jp06_lm_pkilop_stock_heavy2", "jup_jp06_lm_pkilop_stock_tac", "jup_jp06_lm_pkilop_stock_heavy3"];
          possibilities["mags"] = [40, "jup_jp06_lm_pkilop_belt_150_762n"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "hybrid05", "hybrid06"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
        case #"hash_9f2f7b2ffa667962":
          possibilities["barrels"] = [50, "jup_cp24_pi_glima21_bar_light", "jup_cp24_pi_glima21_bar_light"];
          possibilities["mags"] = [50, "jup_cp24_pi_glima21_mag_18_45acp"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
        case #"hash_f9a81f8a7ac2c955":
          possibilities["barrels"] = [50, "jup_jp16_sh_recho870_bartube_short", "jup_jp16_sh_recho870_bartube_hvyshort"];
          possibilities["scopes"] = [60, "jup_minireddot01_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_tac", "jup_jp16_sh_recho870_pgrip_tac"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_heavy", "jup_jp16_sh_recho870_pgrip"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_folding", "jup_jp16_sh_recho870_pgrip"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 30;
      weaponprobabilities["jup_jp02_sm_scharlie3_sp"] = 40;
      weaponprobabilities["jup_jp04_sm_umike_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_7b1f2fae55545887":
          possibilities["barrels"] = [50, "jup_jp02_sm_scharlie3_bar_lgtshort", "jup_jp02_sm_scharlie3_bar_light"];
          possibilities["stocks"] = [50, "jup_jp02_sm_scharlie3_stock_skel", "jup_jp02_sm_scharlie3_stock_skeltac", "jup_jp02_sm_scharlie3_stock_taclight", "jup_jp02_sm_scharlie3_stock_tac"];
          possibilities["mags"] = [50, "jup_jp02_sm_scharlie3_mag_40_9mm"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_e5ce91052a286344":
          possibilities["barrels"] = [50, "jup_jp04_sm_umike_bar_heavy"];
          possibilities["stocks"] = [50, "jup_jp04_sm_umike_stock_light", "jup_jp04_sm_umike_stock_folding", "jup_jp04_sm_umike_stock_precision", "jup_jp04_sm_umike_stock_hvyskel", "jup_jp04_sm_umike_stock_assault"];
          possibilities["mags"] = [50, "jup_jp04_sm_umike_mag_30_45acp"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 50;
      weaponprobabilities["jup_jp13_dm_svictork_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
        case #"hash_fa420c3b943390d7":
          possibilities["barrels"] = [50, "jup_jp13_dm_svictork_bar_short"];
          possibilities["stocks"] = [50, "jup_jp13_dm_svictork_stock_tac", "jup_jp13_dm_svictork_stock_mm", "jup_jp13_dm_svictork_stock_lmm"];
          possibilities["mags"] = [50, "jup_jp13_dm_svictork_mag_15_762r", "jup_jp13_dm_svictork_mag_20_762r"];
          possibilities["scopes"] = [100, "dmscope01", "dmscope02"];
          attachment_combos[attachment_combos.size] = ["jup_jp13_dm_svictork_bar_classic", "jup_jp13_dm_svictork_stock_ass", "jup_jp13_dm_svictork_pgrip_ass", "dmscope02"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_212de1183c53e8(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
        case #"hash_f9a81f8a7ac2c955":
          possibilities["barrels"] = [50, "jup_jp16_sh_recho870_bartube_short", "jup_jp16_sh_recho870_bartube_hvyshort"];
          possibilities["scopes"] = [60, "jup_minireddot01_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_tac", "jup_jp16_sh_recho870_pgrip_tac"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_heavy", "jup_jp16_sh_recho870_pgrip"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_folding", "jup_jp16_sh_recho870_pgrip"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 50;
      weaponprobabilities["iw9_sm_mpapax_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_252ac91b23d22c17":
          possibilities["barrels"] = [50, "bar_sm_p08", "bar_sm_short_p08"];
          possibilities["stocks"] = [50, "stock_sm_light_p08", "stock_ar_tactical_p08", "stock_sm_p08", "stockno_sm_p08", "stock_sm_p08_mpapax", "stock_sm_light_p08_mpapax", "stock_ar_tactical_p08_mpapax"];
          possibilities["mags"] = [50, "mag_sm_p08", "drum_sm_p08"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_4441fee08ec94cdd(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 50;
      weaponprobabilities["iw9_sm_beta_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_ae38ecc687e7c901(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
      }
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 50;
      weaponprobabilities["iw9_sm_beta_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_ef52cc59c1b2e548(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 50;
      weaponprobabilities["iw9_sm_beta_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_ec3afdeda11b4349(type, weaponname, weaponarray) {
  camos = getweapon_camos("reb");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      switch (weaponname) {
        case #"hash_d587b8872645b598":
          possibilities["endbarrel"] = [100, "silencer01_ar"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_4ce97548a610e1bf(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 30;
      weaponprobabilities["jup_jp01_ar_golf36_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_6558b7569b2f833c":
          possibilities["scopes"] = [75, "jup_twofivex_golf36", "jup_fourx01", "jup_fourx02", "jup_reflex01_tall", "jup_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "jup_jp01_ar_golf36_stock_tac", "jup_jp01_ar_golf36_stock_assault", "jup_jp01_ar_golf36_stock_skel"];
          possibilities["barrels"] = [50, "jup_jp01_ar_golf36_bar_short", "jup_jp01_ar_golf36_bar_short_heavy"];
          possibilities["mags"] = [50, "jup_jp01_ar_golf36_mag_30_556n", "jup_jp01_ar_golf36_mag_40_556n"];
          possibilities["grips"] = [30, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_3a85891c63542117":
          possibilities["barrels"] = [50, "jup_jp01_lm_mgolf36_bar_heavy"];
          possibilities["stocks"] = [50, "jup_jp01_lm_mgolf36_stock_tacheavy", "jup_jp01_lm_mgolf36_stock_tac", "jup_jp01_lm_mgolf36_stock_assault"];
          possibilities["mags"] = [50, "jup_jp01_lm_mgolf36_drum_100_556n", "jup_jp01_lm_mgolf36_mag_40_556n"];
          possibilities["scopes"] = [60, "jup_twofivex_mgolf36", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "jup_grip_angled_01", "jup_grip_angled_02"];
          possibilities["endbarrel"] = [50, "comp_ar_05", "comp_ar_08", "jup_comp_ar_01", "jup_flash_ar_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_9f2f7b2ffa667962":
          possibilities["barrels"] = [50, "jup_cp24_pi_glima21_bar_light", "jup_cp24_pi_glima21_bar_light"];
          possibilities["mags"] = [50, "jup_cp24_pi_glima21_mag_18_45acp"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_f9a81f8a7ac2c955":
          possibilities["barrels"] = [50, "jup_jp16_sh_recho870_bartube_short", "jup_jp16_sh_recho870_bartube_hvyshort"];
          possibilities["scopes"] = [60, "jup_minireddot01_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_tac", "jup_jp16_sh_recho870_pgrip_tac"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_heavy", "jup_jp16_sh_recho870_pgrip"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_folding", "jup_jp16_sh_recho870_pgrip"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapa5_sp"] = 50;
      weaponprobabilities["jup_jp04_sm_lwhiskey_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_175809755197c4da":
          possibilities["barrels"] = [50, "bar_sm_p02", "bar_sm_long_p02", "bar_sm_short_p02", "bar_sm_light_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02_mpapa5", "stock_ar_tactical_p02", "stock_sm_p02"];
          possibilities["mags"] = [50, "mag_sm_p02", "mag_sm_small_p02", "mag_sm_large_p02", "drum_sm_p02"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "selectburst_mpapa5"];
          possibilities["grips"] = [50, "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_26f99e329f475eb7":
          possibilities["barrels"] = [50, "jup_jp04_sm_lwhiskey_bar_heavy", "jup_jp04_sm_lwhiskey_bar_hvylong"];
          possibilities["stocks"] = [50, "jup_jp04_sm_lwhiskey_stock_folding", "jup_jp04_sm_lwhiskey_stock_light", "jup_jp04_sm_lwhiskey_stock_assault"];
          possibilities["mags"] = [50, "jup_jp04_sm_lwhiskey_mag_40_9mm"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_dc545d7e8b75abc2(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_9e82f4346600ccc5":
          possibilities["barrels"] = [50, "bar_lm_p01", "bar_lm_long_p01"];
          possibilities["stocks"] = [50, "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_ar_p01_foxtrot", "stock_ar_tactical_p01_foxtrot", "stock_ar_light_p01_foxtrot"];
          possibilities["mags"] = [50, "belt_lm_p01", "belt_lm_large_p01"];
          possibilities["scopes"] = [70, "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "reflex05_tall", "reflex06_tall", "reflex07_tall_p01", "reflex08_tall", "holo01", "holo02_p01", "holo03", "holo04", "holo05", "fourx01", "fourx02", "fourx04_p01", "fourx05", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06"];
          possibilities["grips"] = [75, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09_p01", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapa7_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_394fc57f759066f4":
          possibilities["barrels"] = [50, "bar_sm_p09", "bar_sm_hvyxlong_p09", "bar_sm_xlong_p09", "bar_sm_long_p09", "bar_sm_hvylong_p09", "bar_sm_heavy_p09", "bar_sm_short_p09", "bar_sm_hvyshort_p09"];
          possibilities["stocks"] = [50, "stock_sm_light_p09", "stock_sm_heavy_p09", "stock_sm_p09", "stock_sm_tactical_p09", "stockno_sm_p09"];
          possibilities["mags"] = [50, "mag_sm_p09", "mag_sm_small_p09", "mag_sm_large_p09", "mag_sm_xlarge_p09"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_1ad896c57dd5eac6(type, weaponname, weaponarray) {
  camos = getweapon_camos("sas_urban");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 30;
      weaponprobabilities["jup_jp19_ar_acharlie_sp"] = 30;
      weaponprobabilities["jup_cp08_br_xmike5_sp"] = 40;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_4239df718437dccd":
          possibilities["barrels"] = [50, "jup_jp19_ar_acharlie_bar_heavy", "jup_jp19_ar_acharlie_bar_hvyshort", "jup_jp19_ar_acharlie_bar_hvyshort2"];
          possibilities["stocks"] = [80, "jup_jp19_ar_acharlie_stock_light", "jup_jp19_ar_acharlie_stock_tac", "jup_jp19_ar_acharlie_stock_heavy"];
          possibilities["mags"] = [50, "jup_jp19_ar_acharlie_mag_40_556n"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
        case #"hash_32e8b17eac7d6589":
          possibilities["barrels"] = [50, "jup_cp08_br_xmike5_bar_short", "jup_cp08_br_xmike5_bar_light", "jup_cp08_br_xmike5_bar_lgtshort", "jup_cp08_br_xmike5_bar_short"];
          possibilities["stocks"] = [80, "jup_cp08_br_xmike5_stock_folding", "jup_cp08_br_xmike5_stock_light", "jup_cp08_br_xmike5_stock_lgtprecision", "jup_cp08_br_xmike5_stock_hvyprecision", "jup_cp08_br_xmike5_stock_heavy"];
          possibilities["mags"] = [50, "jup_cp08_br_xmike5_mag_30_277f", "jup_cp08_br_xmike5_mag_45_277f"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_3a85891c63542117":
          possibilities["barrels"] = [50, "jup_jp01_lm_mgolf36_bar_heavy"];
          possibilities["stocks"] = [50, "jup_jp01_lm_mgolf36_stock_tacheavy", "jup_jp01_lm_mgolf36_stock_tac", "jup_jp01_lm_mgolf36_stock_assault"];
          possibilities["mags"] = [50, "jup_jp01_lm_mgolf36_drum_100_556n", "jup_jp01_lm_mgolf36_mag_40_556n"];
          possibilities["scopes"] = [60, "jup_twofivex_mgolf36", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "jup_grip_angled_01", "jup_grip_angled_02"];
          possibilities["endbarrel"] = [50, "comp_ar_05", "comp_ar_08", "jup_comp_ar_01", "jup_flash_ar_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_9f2f7b2ffa667962":
          possibilities["barrels"] = [50, "jup_cp24_pi_glima21_bar_light", "jup_cp24_pi_glima21_bar_light"];
          possibilities["mags"] = [50, "jup_cp24_pi_glima21_mag_18_45acp"];
          possibilities["scopes"] = [30, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_f9a81f8a7ac2c955":
          possibilities["barrels"] = [50, "jup_jp16_sh_recho870_bartube_short", "jup_jp16_sh_recho870_bartube_hvyshort"];
          possibilities["scopes"] = [60, "jup_minireddot01_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "flash_sh_01"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_tac", "jup_jp16_sh_recho870_pgrip_tac"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_heavy", "jup_jp16_sh_recho870_pgrip"];
          attachment_combos[attachment_combos.size] = ["jup_jp16_sh_recho870_stock_folding", "jup_jp16_sh_recho870_pgrip"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["jup_jp04_sm_lwhiskey_sp"] = 50;
      weaponprobabilities["iw9_sm_mpapax_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_26f99e329f475eb7":
          possibilities["barrels"] = [50, "jup_jp04_sm_lwhiskey_bar_heavy", "jup_jp04_sm_lwhiskey_bar_hvylong"];
          possibilities["stocks"] = [50, "jup_jp04_sm_lwhiskey_stock_folding", "jup_jp04_sm_lwhiskey_stock_light", "jup_jp04_sm_lwhiskey_stock_assault"];
          possibilities["mags"] = [50, "jup_jp04_sm_lwhiskey_mag_40_9mm"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_252ac91b23d22c17":
          possibilities["barrels"] = [50, "bar_sm_p08", "bar_sm_short_p08"];
          possibilities["stocks"] = [50, "stock_sm_light_p08", "stock_ar_tactical_p08", "stock_sm_p08", "stockno_sm_p08", "stock_sm_p08_mpapax", "stock_sm_light_p08_mpapax", "stock_ar_tactical_p08_mpapax"];
          possibilities["mags"] = [50, "mag_sm_p08", "drum_sm_p08"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_951704f451830a80(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_ar_golf3_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [20, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [20, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [20, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
        case #"hash_127d6ae747a36c62":
          possibilities["barrels"] = [30, "bar_br_p02", "bar_lm_long_p02"];
          possibilities["stocks"] = [30, "stock_ar_p02", "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02"];
          possibilities["mags"] = [50, "mag_br_p02", "mag_br_large_p02"];
          possibilities["scopes"] = [30, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["endbarrel"] = [30, "comp_br_05", "comp_br_01"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_ff9799d32cdfe811":
          possibilities["barrels"] = [50, "jup_jp06_lm_pkilop_bar_light", "jup_jp06_lm_pkilop_bar_heavy", "jup_jp06_lm_pkilop_bar_short"];
          possibilities["stocks"] = [50, "jup_jp06_lm_pkilop_stock_heavy2", "jup_jp06_lm_pkilop_stock_tac", "jup_jp06_lm_pkilop_stock_heavy3"];
          possibilities["mags"] = [40, "jup_jp06_lm_pkilop_belt_150_762n"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "hybrid05", "hybrid06"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [10, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_568cc2d89894d1e4":
          possibilities["barrels"] = [50, "bartube_sh_p13", "bartube_sh_heavy_p13", "bartube_sh_light_p13", "bartube_sh_short_p13"];
          possibilities["stocks"] = [50, "stockr_sh_p13", "stockr_sh_heavy_p13", "stock_sh_tactical_p13", "stock_sh_light_p13", "stockno_sh_p13", "stockno_sh_light_p13"];
          possibilities["scopes"] = [30, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["underbarrels"] = [25, "guard_p13", "guard_tactical_p13", "guard_heavy_p13", "guard_light_p13"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapa5_sp"] = 50;
      weaponprobabilities["iw9_sm_beta_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_175809755197c4da":
          possibilities["barrels"] = [50, "bar_sm_p02", "bar_sm_long_p02", "bar_sm_short_p02", "bar_sm_light_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02_mpapa5", "stock_ar_tactical_p02", "stock_sm_p02"];
          possibilities["mags"] = [50, "mag_sm_p02", "mag_sm_small_p02", "mag_sm_large_p02", "drum_sm_p02"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "selectburst_mpapa5"];
          possibilities["grips"] = [50, "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_58b6f3799af2dbbc(weaponname, weaponarray) {
  if(self.classname == "actor_iw9_ally_hero_ghost_urban") {
    switch (weaponname) {
      case #"hash_4fd524ce5cfa34e4":
        return make_weapon_special("iw9_sn_mromeo_v1");
    }
  } else if(self.classname == "actor_iw9_ally_hero_soap_mexico" || self.classname == "actor_iw9_ally_hero_soap_gunship") {
    switch (weaponname) {
      case #"hash_accc6d1d86e48732":
        return make_weapon_special("iw9_dm_xmike2010_v1");
    }
  } else if(self.classname == "actor_iw9_ally_hero_graves_shipaf" || self.classname == "actor_iw9_ally_hero_graves_interdiction" || self.classname == "actor_iw9_ally_hero_graves_pmc") {
    switch (weaponname) {
      case #"hash_dd873e17fc65c845":
        return make_weapon_special("graves_br_schotel");
    }
  } else if(self.classname == "actor_iw9_ally_hero_ghost" || self.classname == "actor_iw9_ally_hero_ghost_desert" || self.classname == "actor_iw9_ally_hero_ghost_desert_gunship") {
    switch (weaponname) {
      case #"hash_82d03e9871615139":
        return make_weapon_special("iw9_ar_mcbravo_v1");
    }
  } else if(self.classname == "actor_iw9_ally_hero_price_desert" || self.classname == "actor_iw9_ally_hero_price_highrise") {
    switch (weaponname) {
      case #"hash_aa1268e549fd317":
        return make_weapon_special("iw9_ar_mike4_v1");
    }
  } else if(self.classname == "actor_iw9_ally_hero_alejandro" || self.classname == "actor_iw9_ally_hero_alejandro_urban" || self.classname == "actor_iw9_ally_hero_alejandro_gunship") {
    switch (weaponname) {
      case #"hash_252ac91b23d22c17":
        return make_weapon_special("alejandro_sm_mpapax");
    }
  } else if(self.classname == "actor_iw9_ally_hero_farah_convoy") {
    switch (weaponname) {
      case #"hash_a89739756fa439cf":
        return make_weapon_special("iw9_ar_akilo_v4");
    }
  } else if(self.classname == "actor_iw9_ally_hero_price" || self.classname == "actor_iw9_ally_hero_kyle") {
    switch (weaponname) {
      case #"hash_aa1268e549fd317":
        return make_weapon_special("iw9_ar_mike4_v9");
    }
  } else if(self.classname == "actor_iw9_ally_hero_rodolfo") {
    switch (weaponname) {
      case #"hash_73753b6a3bde7482":
        return make_weapon_special("iw9_ar_mcharlie_v1");
    }
  }

  if(getdvarint(@ "hash_45281f93550798")) {
    iprintln(self.classname + " " + weaponname + " not whitelisted!skipping scripted build.");
  }

  return make_weapon(weaponname, []);
}

function function_f6839b3d503efa3d(type, weaponname, weaponarray) {
  camos = getweapon_camos("reb");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo_sp"] = 50;
      weaponprobabilities["iw9_ar_mike16_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_a89739756fa439cf":
          possibilities["barrels"] = [50, "bar_ar_hvylong_p04_akilo", "bar_ar_long_p04", "bar_ar_heavy_p04", "bar_ar_hvyshort_p04_akilo"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_heavy_p04"];
          possibilities["mags"] = [50, "mag_ar_p04", "mag_ar_small_p04", "mag_ar_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "ub_gl_akilo"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_aa74a17ec13f0a08":
          possibilities["barrels"] = [100, "bar_ar_heavy_p01", "bar_ar_p01"];
          possibilities["stocks"] = [50, "stock_ar_assault_p01", "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sn_p01"];
          possibilities["mags"] = [50, "mag_ar_p01", "mag_ar_small_p01", "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "ub_sh01", "ub_gl01_p01", "ub_gl01_xmags"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      weaponprobabilities["iw9_ar_golf3_sp"] = 50;
      weaponprobabilities["iw9_br_soscar14_sp"] = 25;
      weaponprobabilities["iw9_dm_mike24_sp"] = 25;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_127d6ae747a36c62":
          possibilities["barrels"] = [50, "bar_br_p02", "bar_lm_long_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02", "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02"];
          possibilities["mags"] = [50, "mag_br_p02", "mag_br_large_p02"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["endbarrel"] = [50, "comp_br_05", "comp_br_01"];
          break;
        case #"hash_45c546e6f731646e":
          possibilities["barrels"] = [50, "bar_dm_p18_soscar14", "bar_dm_heavy_p18_soscar14", "bar_br_p18_soscar14", "bar_br_heavy_p18_soscar14"];
          possibilities["stocks"] = [50, "stock_dm_light_p18_soscar14", "stockr_dm_p18_soscar14"];
          possibilities["mags"] = [50, "drum_br_p18", "mag_br_large_p18", "mag_br_p18_soscar14"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_de04cb31d20ef327":
          possibilities["barrels"] = [50, "bar_dm_p20_mike24"];
          possibilities["stocks"] = [50, "stockr_dm_p20", "stockr_dm_heavy_p20", "stockr_dm_tactical_p20"];
          possibilities["mags"] = [50, "mag_dm_p20", "mag_dm_large_p20"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      weaponprobabilities["iw9_lm_kilo21_sp"] = 55;
      weaponprobabilities["iw9_lm_rkilo_sp"] = 45;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_62459cc0741ed82f":
          possibilities["barrels"] = [50, "bar_lm_p02", "bar_lm_long_p02", "bar_br_p02", "bar_br_light_p02", "bar_lm_short_p02"];
          possibilities["stocks"] = [50, "stock_lm_p02", "stock_ar_assault_p02", "stock_ar_p02", "stock_ar_tactical_p02"];
          possibilities["mags"] = [50, "belt_lm_p02", "belt_lm_large_p02"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "kilo21_sidegrip"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      weaponname = "iw9_pi_golf18_sp";

      switch (weaponname) {
        case #"hash_7e15428d3b55ef10":
          possibilities["barrels"] = [50, "bar_sm_heavy_p24", "bar_sm_p24"];
          possibilities["stocks"] = [50, "stockno_pi_p24"];
          possibilities["mags"] = [50, "mag_pi_p24", "mag_pi_large_p24"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      weaponprobabilities["iw9_sh_mbravo_sp"] = 50;
      weaponprobabilities["iw9_sh_charlie725_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_568cc2d89894d1e4":
          possibilities["barrels"] = [50, "bartube_sh_p13", "bartube_sh_heavy_p13", "bartube_sh_light_p13", "bartube_sh_short_p13"];
          possibilities["stocks"] = [50, "stockr_sh_p13", "stockr_sh_heavy_p13", "stock_sh_tactical_p13", "stock_sh_light_p13", "stockno_sh_p13", "stockno_sh_light_p13"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["underbarrels"] = [25, "guard_p13", "guard_tactical_p13", "guard_heavy_p13", "guard_light_p13"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sh_01"];
          break;
        case #"hash_81f38f52e4aaecf5":
          possibilities["barrels"] = [50, "bar_sh_p14", "bar_sh_short_p14", "bar_sh_long_p14"];
          possibilities["stocks"] = [50, "stockr_sh_p14", "stockr_sh_tactical_p14", "stockr_sh_heavy_p14", "stockno_sh_p14"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["underbarrels"] = [25, "guard_p14", "guard_heavy_p14", "guard_light_p14", "guard_tactical_p14"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 40;
      weaponprobabilities["iw9_sm_mpapa5_sp"] = 30;
      weaponprobabilities["iw9_sm_beta_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          break;
        case #"hash_175809755197c4da":
          possibilities["barrels"] = [50, "bar_sm_p02", "bar_sm_long_p02", "bar_sm_short_p02", "bar_sm_light_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02_mpapa5", "stock_ar_tactical_p02", "stock_sm_p02"];
          possibilities["mags"] = [50, "mag_sm_p02", "mag_sm_small_p02", "mag_sm_large_p02", "drum_sm_p02"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "selectburst_mpapa5"];
          possibilities["grips"] = [50, "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_dm_pgolf1_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_3fd5bba485c2aea6":
          possibilities["barrels"] = [50, "bar_sn_p02"];
          possibilities["stocks"] = [50, "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02_pgolf1", "stock_sm_p02", "stock_ar_p02"];
          possibilities["mags"] = [50, "mag_sn_p02", "mag_sn_large_p02"];
          possibilities["scopes"] = [100, "arscope_nvgvz01"];
          possibilities["underbarrels"] = [40, "bipod01"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_53e5f63c1e2a01ee(type, weaponname, weaponarray) {
  camos = getweapon_camos("mex_sf");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 50;
      weaponprobabilities["iw9_ar_golf3_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_127d6ae747a36c62":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02", "stock_lm_p02_golf3", "stock_ar_p02_golf3", "stock_ar_assault_p02_golf3", "stock_ar_tactical_p02_golf3"];
          possibilities["barrels"] = [100, "bar_br_light_p02", "bar_lm_short_p02", "bar_ar_p02_golf3", "bar_br_light_p02_golf3", "bar_lm_short_p02_golf3", "bar_ar_short_p02_golf3"];
          possibilities["mags"] = [50, "mag_br_p02", "mag_br_large_p02", "mag_br_large_p02_golf3", "mag_br_p02_golf3"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_br_01", "comp_br_02", "comp_br_03", "comp_br_04", "comp_br_05", "comp_br_06", "flash_br_01", "flash_br_02", "flash_br_03"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_2f2d546c2247838f":
      weaponprobabilities["iw9_lm_kilo21_sp"] = 50;
      weaponprobabilities["iw9_lm_foxtrot_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_62459cc0741ed82f":
          possibilities["barrels"] = [50, "bar_lm_p02", "bar_lm_long_p02", "bar_br_p02", "bar_br_light_p02"];
          possibilities["stocks"] = [50, "stock_lm_p02", "stock_ar_assault_p02", "stock_ar_p02", "stock_ar_tactical_p02"];
          possibilities["mags"] = [50, "belt_lm_p02", "belt_lm_large_p02"];
          possibilities["scopes"] = [70, "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "reflex05_tall", "reflex06_tall", "reflex07_tall", "reflex08_tall", "holo01", "holo02", "holo03", "holo04", "holo05", "fourx01", "fourx02", "fourx04", "fourx05", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "kilo21_sidegrip"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_9e82f4346600ccc5":
          possibilities["barrels"] = [50, "bar_lm_p01", "bar_lm_long_p01"];
          possibilities["stocks"] = [50, "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_ar_p01_foxtrot", "stock_ar_tactical_p01_foxtrot", "stock_ar_light_p01_foxtrot"];
          possibilities["mags"] = [50, "belt_lm_p01", "belt_lm_large_p01"];
          possibilities["scopes"] = [70, "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "reflex05_tall", "reflex06_tall", "reflex07_tall_p01", "reflex08_tall", "holo01", "holo02_p01", "holo03", "holo04", "holo05", "fourx01", "fourx02", "fourx04_p01", "fourx05", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06"];
          possibilities["grips"] = [75, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09_p01", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "flash_ar_01"];
          break;
      }
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_568cc2d89894d1e4":
          possibilities["barrels"] = [50, "bartube_sh_p13", "bartube_sh_heavy_p13", "bartube_sh_light_p13", "bartube_sh_short_p13"];
          possibilities["stocks"] = [50, "stockr_sh_p13", "stockr_sh_heavy_p13", "stock_sh_tactical_p13", "stock_sh_light_p13"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapa5_sp"] = 65;
      weaponprobabilities["iw9_sm_papa90_sp"] = 35;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_175809755197c4da":
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "iw9_minireddot05_tall", "iw9_minireddot06_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "reflex05_tall", "reflex06_tall", "reflex07_tall", "reflex08_tall", "holo01", "holo02", "holo03", "holo04", "holo05"];
          possibilities["barrels"] = [50, "bar_sm_p02", "bar_sm_short_p02", "bar_sm_light_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02_mpapa5", "stock_ar_assault_p02_mpapa5", "stock_ar_tactical_p02_mpapa5", "stock_sm_p02_mpapa5", "stock_ar_assault_p02", "stock_ar_tactical_p02", "stock_sm_p02", "stockno_sm_p02"];
          possibilities["mags"] = [50, "mag_sm_p02", "mag_sm_large_p02", "drum_sm_p02"];
          possibilities["underbarrels"] = [25, "selectburst_mpapa5"];
          possibilities["grips"] = [50, "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vert05", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05", "grip_vertshort06", "grip_vertshort07"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "flash_sm_01"];
          break;
        case #"hash_119b48de90786a23":
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "iw9_minireddot05_tall", "iw9_minireddot06_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "reflex05_tall", "reflex06_tall", "reflex07_tall", "reflex08_tall", "holo01", "holo02", "holo03", "holo04", "holo05"];
          possibilities["barrels"] = [50, "bar_sm_short_p07", "bar_sm_p07"];
          possibilities["stocks"] = [50, "stock_sm_light_p07", "stock_sm_p07", "stock_sm_tactical_p07", "stock_sm_assault_p07", "stock_sm_heavy_p07"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "flash_sm_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_599b2370665f8002(type, weaponname, weaponarray) {
  camos = getweapon_camos("mex_sf");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 50;
      weaponprobabilities["iw9_ar_scharlie_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_1902daff8e078b20":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p05", "stock_sn_p05", "stock_ar_heavy_p05", "stock_ar_tactical_p05", "stock_sm_p05"];
          possibilities["barrels"] = [50, "bar_ar_p05", "bar_ar_short_p05"];
          possibilities["mags"] = [50, "mag_ar_p05", "mag_ar_large_p05", "mag_ar_xlarge_p05"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_03", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_scharlie"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      switch (weaponname) {
        case #"hash_394fc57f759066f4":
          possibilities["barrels"] = [50, "bar_sm_p09", "bar_sm_hvyxlong_p09", "bar_sm_xlong_p09", "bar_sm_long_p09", "bar_sm_hvylong_p09", "bar_sm_heavy_p09", "bar_sm_short_p09", "bar_sm_hvyshort_p09"];
          possibilities["stocks"] = [50, "stock_sm_light_p09", "stock_sm_heavy_p09", "stock_sm_p09", "stock_sm_tactical_p09", "stockno_sm_p09"];
          possibilities["mags"] = [50, "mag_sm_p09", "mag_sm_small_p09", "mag_sm_large_p09", "mag_sm_xlarge_p09"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_4b7d1f618622e1c4(type, weaponname, weaponarray) {
  camos = getweapon_camos("usmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 40;
      weaponprobabilities["iw9_ar_scharlie_sp"] = 30;
      weaponprobabilities["iw9_ar_mcharlie_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_1902daff8e078b20":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p05", "stock_sn_p05", "stock_ar_heavy_p05", "stock_ar_tactical_p05", "stock_sm_p05"];
          possibilities["barrels"] = [50, "bar_ar_p05", "bar_ar_short_p05"];
          possibilities["mags"] = [50, "mag_ar_p05", "mag_ar_large_p05", "mag_ar_xlarge_p05"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_scharlie"];
          break;
        case #"hash_73753b6a3bde7482":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p08", "stock_ar_tactical_p08", "stock_sm_p08", "stock_sm_light_p08"];
          possibilities["barrels"] = [50, "bar_ar_p08", "bar_ar_long_p08"];
          possibilities["mags"] = [50, "mag_ar_p08", "mag_ar_xlarge_p08", "mag_ar_large_p08"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_9e82f4346600ccc5":
          possibilities["barrels"] = [50, "bar_lm_p01", "bar_lm_long_p01", "bar_lm_short_p01"];
          possibilities["stocks"] = [50, "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sn_p01"];
          possibilities["mags"] = [50, "belt_lm_p01", "belt_lm_large_p01"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo02_p01", "holo03", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "bipod01"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapa7_sp"] = 50;
      weaponprobabilities["iw9_sm_apapa_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_394fc57f759066f4":
          possibilities["barrels"] = [50, "bar_sm_p09", "bar_sm_hvyxlong_p09", "bar_sm_xlong_p09", "bar_sm_long_p09", "bar_sm_hvylong_p09", "bar_sm_heavy_p09", "bar_sm_short_p09", "bar_sm_hvyshort_p09"];
          possibilities["stocks"] = [50, "stock_sm_light_p09", "stock_sm_heavy_p09", "stock_sm_p09", "stock_sm_tactical_p09", "stockno_sm_p09"];
          possibilities["mags"] = [50, "mag_sm_p09", "mag_sm_small_p09", "mag_sm_large_p09", "mag_sm_xlarge_p09"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_de5d1bd3a9f86945":
          possibilities["barrels"] = [50, "bar_sm_short_p03", "bar_ar_p03"];
          possibilities["stocks"] = [50, "stock_sm_p03", "stock_ar_p03", "stock_lm_p03"];
          possibilities["mags"] = [50, "mag_sm_p03", "mag_sm_large_p03"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_4088385bffccb0a1(type, weaponname, weaponarray) {
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_719417cb1de832b6":
      weaponname = "iw9_pi_golf17_sp";

      switch (weaponname) {
        case #"hash_b2d9146c8c4f36fb":
          possibilities["barrels"] = [50, "bar_pi_p24", "bar_pi_heavy_p24", "bar_pi_light_p24"];
          possibilities["mags"] = [50, "mag_pi_p24", "mag_pi_large_p24"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, undefined);
}

function function_58d868a0b0dac3bb(type, weaponname, weaponarray) {
  camos = getweapon_camos("cartel");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo_sp"] = 30;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 15;
      weaponprobabilities["iw9_ar_akilo74_sp"] = 15;
      weaponprobabilities["iw9_ar_mike4_sp"] = 15;
      weaponprobabilities["iw9_ar_mike16_sp"] = 25;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_a89739756fa439cf":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_hvylong_p04_akilo", "bar_ar_heavy_p04", "bar_ar_hvyshort_p04_akilo"];
          possibilities["mags"] = [50, "mag_ar_small_p04", "mag_ar_large_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo_xmags"];
          break;
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_heavy_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_hvylong_p04_akilo105", "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_15d131b492bdb596":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_aa74a17ec13f0a08":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sn_p01"];
          possibilities["barrels"] = [100, "bar_ar_heavy_p01", "bar_ar_p01", "bar_ar_shorthvy_p01"];
          possibilities["mags"] = [50, "mag_ar_small_p01", "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      weaponprobabilities["iw9_br_msecho_sp"] = 40;
      weaponprobabilities["iw9_dm_scromeo_sp"] = 30;
      weaponprobabilities["iw9_dm_mike14_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_9f12123b6ecde9b3":
          possibilities["barrels"] = [50, "bar_br_heavy_p01", "bar_ar_light_p01_msecho", "bar_ar_p01_msecho", "bar_ar_long_p01_msecho"];
          possibilities["stocks"] = [50, "stock_sn_p01", "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_ar_assault_p01"];
          possibilities["mags"] = [50, "mag_br_p01", "mag_br_small_p01", "mag_br_large_p01"];
          possibilities["scopes"] = [80, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope_therm01_p01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_dm_01", "comp_dm_02", "comp_dm_05", "flash_dm_01"];
          break;
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [80, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_7e1d746d4a36491e":
          possibilities["barrels"] = [50, "bar_dm_p18_mike14", "bar_dm_heavy_p18_mike14", "bar_br_heavy_p18_mike14", "bar_br_p18_mike14"];
          possibilities["stocks"] = [50, "stock_dm_light_p18", "stock_dm_heavy_p18", "stock_dm_tac_p18"];
          possibilities["mags"] = [50, "mag_sn_p18", "mag_sn_large_p18", "mag_br_p18_mike14"];
          possibilities["scopes"] = [80, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      weaponprobabilities["iw9_lm_kilo21_sp"] = 55;
      weaponprobabilities["iw9_lm_rkilo_sp"] = 45;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_62459cc0741ed82f":
          possibilities["barrels"] = [50, "bar_lm_p02", "bar_lm_long_p02", "bar_br_p02", "bar_br_light_p02", "bar_lm_short_p02"];
          possibilities["stocks"] = [50, "stock_lm_p02", "stock_ar_assault_p02", "stock_ar_p02", "stock_ar_tactical_p02"];
          possibilities["mags"] = [50, "belt_lm_p02", "belt_lm_large_p02"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "kilo21_sidegrip"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      weaponname = "iw9_pi_decho_sp";

      switch (weaponname) {
        case #"hash_f9ce3b8ea4b8701e":
          possibilities["barrels"] = [50, "bar_pi_p25", "barbrake_pi_p25", "barcomp_pi_p25", "bar_pi_long_p25", "bar_pi_hvylong_p25"];
          possibilities["stocks"] = [50, "stockno_pi_p25"];
          possibilities["mags"] = [50, "mag_pi_p25", "mag_pi_large_p25", "mag_pi_xlarge_p25"];
          possibilities["scopes"] = [60, "iw9_minireddot01", "iw9_minireddot02", "iw9_minireddot03", "iw9_minireddot04"];
          possibilities["endbarrel"] = [50, "comp_decho_01", "comp_decho_02", "comp_decho_03", "comp_decho_04", "flash_decho_01"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      weaponprobabilities["iw9_sh_mike1014_sp"] = 50;
      weaponprobabilities["iw9_sh_mbravo_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
        case #"hash_568cc2d89894d1e4":
          possibilities["barrels"] = [50, "bartube_sh_p13", "bartube_sh_heavy_p13", "bartube_sh_light_p13", "bartube_sh_short_p13"];
          possibilities["stocks"] = [50, "stockr_sh_p13", "stockr_sh_heavy_p13", "stock_sh_tactical_p13", "stock_sh_light_p13"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 50;
      weaponprobabilities["iw9_sm_apapa_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
        case #"hash_394fc57f759066f4":
          possibilities["barrels"] = [50, "bar_sm_p09", "bar_sm_hvyxlong_p09", "bar_sm_xlong_p09", "bar_sm_long_p09", "bar_sm_hvylong_p09", "bar_sm_heavy_p09", "bar_sm_short_p09", "bar_sm_hvyshort_p09"];
          possibilities["stocks"] = [50, "stock_sm_light_p09", "stock_sm_heavy_p09", "stock_sm_p09", "stock_sm_tactical_p09", "stockno_sm_p09"];
          possibilities["mags"] = [50, "mag_sm_p09", "mag_sm_small_p09", "mag_sm_large_p09", "mag_sm_xlarge_p09"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_de5d1bd3a9f86945":
          possibilities["barrels"] = [50, "bar_sm_short_p03", "bar_ar_p03"];
          possibilities["stocks"] = [50, "stock_sm_p03", "stock_ar_p03", "stock_lm_p03"];
          possibilities["mags"] = [50, "mag_sm_p03", "mag_sm_large_p03"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_dm_pgolf1_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_3fd5bba485c2aea6":
          possibilities["barrels"] = [50, "bar_sn_p02"];
          possibilities["stocks"] = [50, "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02_pgolf1", "stock_sm_p02", "stock_ar_p02"];
          possibilities["mags"] = [50, "mag_sn_p02", "mag_sn_large_p02"];
          possibilities["scopes"] = [100, "arscope_nvg01"];
          possibilities["underbarrels"] = [40, "bipod01"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_a6330cf7bdaa288e(type, weaponname, weaponarray) {
  camos = getweapon_camos("usmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 50;
      weaponprobabilities["iw9_ar_scharlie_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_1902daff8e078b20":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p05", "stock_sn_p05", "stock_ar_heavy_p05", "stock_ar_tactical_p05", "stock_sm_p05"];
          possibilities["barrels"] = [50, "bar_ar_p05", "bar_ar_short_p05"];
          possibilities["mags"] = [50, "mag_ar_p05", "mag_ar_large_p05", "mag_ar_xlarge_p05"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_scharlie"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      switch (weaponname) {
        case #"hash_394fc57f759066f4":
          possibilities["barrels"] = [50, "bar_sm_p09", "bar_sm_hvyxlong_p09", "bar_sm_xlong_p09", "bar_sm_long_p09", "bar_sm_hvylong_p09", "bar_sm_heavy_p09", "bar_sm_short_p09", "bar_sm_hvyshort_p09"];
          possibilities["stocks"] = [50, "stock_sm_light_p09", "stock_sm_heavy_p09", "stock_sm_p09", "stock_sm_tactical_p09", "stockno_sm_p09"];
          possibilities["mags"] = [50, "mag_sm_p09", "mag_sm_small_p09", "mag_sm_large_p09", "mag_sm_xlarge_p09"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_d2e456774b5818b9(type, weaponname, weaponarray) {
  camos = [];
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 40;
      weaponprobabilities["iw9_ar_akilo105_sp"] = 60;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_light_p04"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p04", "bar_ar_hvyshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04", "mag_ar_lgtxlarge_p04"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_akilo"];
          break;
        case #"hash_15d131b492bdb596":
          possibilities["scopes"] = [75, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04"];
          possibilities["barrels"] = [100, "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["mags"] = [50, "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_aviktor_sp"] = 50;
      weaponprobabilities["iw9_sm_beta_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_bb0038e8e0e9d620":
          possibilities["barrels"] = [50, "bar_sm_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_sm_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_angled05", "grip_angled06", "grip_angled07", "grip_angled08", "grip_angled09", "grip_angled10", "grip_angled11", "grip_angled12", "grip_angled13", "grip_angled14", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vert04", "grip_vertshort01", "grip_vertshort02", "grip_vertshort03", "grip_vertshort04", "grip_vertshort05"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_dccb603d3e9a2268(type, weaponname, weaponarray) {
  camos = getweapon_camos("pmc");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_mike4_sp"] = 40;
      weaponprobabilities["iw9_ar_scharlie_sp"] = 60;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_aa1268e549fd317":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sm_p01", "stock_ar_assault_p01", "stock_sn_p01", "stockno_ar_p01"];
          possibilities["barrels"] = [50, "bar_ar_heavy_p01", "bar_ar_shorthvy_p01", "bar_ar_light_p01", "bar_ar_short_p01"];
          possibilities["mags"] = [50, "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02", "grip_angled03"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl01_xmags"];
          break;
        case #"hash_1902daff8e078b20":
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["stocks"] = [80, "stock_ar_p05", "stock_sn_p05", "stock_ar_heavy_p05", "stock_ar_tactical_p05", "stock_sm_p05"];
          possibilities["barrels"] = [50, "bar_ar_p05", "bar_ar_short_p05"];
          possibilities["mags"] = [50, "mag_ar_p05", "mag_ar_large_p05", "mag_ar_xlarge_p05"];
          possibilities["grips"] = [70, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [65, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          possibilities["underbarrels"] = [50, "ub_gl_scharlie"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      switch (weaponname) {
        case #"hash_63a6ddf69b9373c9":
          possibilities["barrels"] = [50, "bar_sn_p05", "bar_sn_long_p05"];
          possibilities["stocks"] = [50, "stock_sn_p05", "stock_sn_light_p05", "stock_ar_heavy_p05", "stock_ar_p05"];
          possibilities["mags"] = [50, "mag_sn_p05", "mag_sn_large_p05", "mag_sn_xlarge_p05"];
          possibilities["scopes"] = [90, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      switch (weaponname) {
        case #"hash_9e82f4346600ccc5":
          possibilities["barrels"] = [50, "bar_lm_p01", "bar_lm_long_p01", "bar_lm_short_p01"];
          possibilities["stocks"] = [50, "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sn_p01"];
          possibilities["mags"] = [50, "belt_lm_p01", "belt_lm_large_p01"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo02_p01", "holo03", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "bipod01"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      switch (weaponname) {
        case #"hash_67577d66829ce1b5":
          possibilities["barrels"] = [50, "bar_pi_p27", "bar_pi_long_p27", "bar_pi_light_p27", "bar_pi_short_p27"];
          possibilities["mags"] = [50, "mag_pi_p27", "mag_pi_large_p27"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl", "iw9_minireddot02_pstl", "iw9_minireddot03_pstl", "iw9_minireddot04_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      switch (weaponname) {
        case #"hash_9551957c74ed1495":
          possibilities["barrels"] = [50, "bar_sh_light_p12", "bar_sh_short_p12", "bartube_sh_short_p12", "bartube_sh_p12", "bar_sh_heavy_p12"];
          possibilities["stocks"] = [50, "stock_sh_light_p12", "stockno_sh_p12", "stockr_sh_heavy_p12", "stock_sh_p12"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["endbarrel"] = [50, "comp_sh_01", "comp_sh_02", "comp_sh_03", "flash_sh_01"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_sm_mpapax_sp"] = 50;
      weaponprobabilities["iw9_sm_apapa_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_252ac91b23d22c17":
          possibilities["barrels"] = [50, "bar_sm_p08", "bar_sm_short_p08"];
          possibilities["stocks"] = [50, "stock_sm_light_p08", "stock_ar_tactical_p08", "stock_sm_p08", "stockno_sm_p08", "stock_sm_p08_mpapax", "stock_sm_light_p08_mpapax", "stock_ar_tactical_p08_mpapax"];
          possibilities["mags"] = [50, "mag_sm_p08", "drum_sm_p08"];
          possibilities["scopes"] = [90, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_de5d1bd3a9f86945":
          possibilities["barrels"] = [50, "bar_sm_short_p03", "bar_ar_p03"];
          possibilities["stocks"] = [50, "stock_sm_p03", "stock_ar_p03", "stock_lm_p03"];
          possibilities["mags"] = [50, "mag_sm_p03", "mag_sm_large_p03"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_sn_mromeo_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_4fd524ce5cfa34e4":
          possibilities["barrels"] = [50, "bar_sn_p21", "bar_sn_long_p21", "barsil_sn_long_p21"];
          possibilities["stocks"] = [50, "stock_sn_p21", "stock_sn_heavy_p21", "stock_sn_light_p21", "stock_sn_tactical_p21"];
          possibilities["mags"] = [50, "mag_sn_p21", "mag_sn_small_p21", "mag_sn_large_p21"];
          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_5f405a21c1883ed2(type, weaponname, weaponarray) {
  camos = getweapon_camos("aq");
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["iw9_ar_akilo_sp"] = 50;
      weaponprobabilities["iw9_ar_mike16_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_a89739756fa439cf":
          possibilities["barrels"] = [50, "bar_ar_hvylong_p04_akilo", "bar_ar_long_p04", "bar_ar_heavy_p04", "bar_ar_hvyshort_p04_akilo"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_ar_heavy_p04"];
          possibilities["mags"] = [50, "mag_ar_p04", "mag_ar_small_p04", "mag_ar_large_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "ub_gl_akilo"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          possibilities["extra"] = [50, "laserir_box"];
          break;
        case #"hash_aa74a17ec13f0a08":
          possibilities["barrels"] = [100, "bar_ar_heavy_p01", "bar_ar_p01"];
          possibilities["stocks"] = [50, "stock_ar_assault_p01", "stock_ar_p01", "stock_ar_tactical_p01", "stock_ar_light_p01", "stock_sn_p01"];
          possibilities["mags"] = [50, "mag_ar_p01", "mag_ar_small_p01", "mag_ar_large_p01", "mag_ar_xlarge_p01"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall_p01", "iw9_minireddot04_tall", "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02_p01", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "ub_sh01", "ub_gl01_p01", "ub_gl01_xmags"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
      }

      break;
    case #"hash_f4b0076c03d93738":
      weaponprobabilities["iw9_ar_golf3_sp"] = 50;
      weaponprobabilities["iw9_br_soscar14_sp"] = 25;
      weaponprobabilities["iw9_dm_mike24_sp"] = 25;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_127d6ae747a36c62":
          possibilities["barrels"] = [50, "bar_br_p02", "bar_lm_long_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02", "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02"];
          possibilities["mags"] = [50, "mag_br_p02", "mag_br_large_p02"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_45c546e6f731646e":
          possibilities["barrels"] = [50, "bar_dm_p18_soscar14", "bar_dm_heavy_p18_soscar14", "bar_br_p18_soscar14", "bar_br_heavy_p18_soscar14"];
          possibilities["stocks"] = [50, "stock_dm_light_p18_soscar14", "stockr_dm_p18_soscar14"];
          possibilities["mags"] = [50, "drum_br_p18", "mag_br_large_p18", "mag_br_p18_soscar14"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid05", "hybrid06", "arscope01", "arscope02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_de04cb31d20ef327":
          possibilities["barrels"] = [50, "bar_dm_p20_mike24"];
          possibilities["stocks"] = [50, "stockr_dm_p20", "stockr_dm_heavy_p20", "stockr_dm_tactical_p20"];
          possibilities["mags"] = [50, "mag_dm_p20", "mag_dm_large_p20"];
          possibilities["scopes"] = [70, "fourx01", "fourx02", "fourx04", "fourx05", "fourxtherm01", "fourxtherm02", "fourxtherm03", "fourxtherm04", "hybrid01", "hybrid02", "hybrid03", "hybrid06", "arscope01", "arscope02", "dmscope01", "dmscope_vz01"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_ba39cac9c099d4f1":
      break;
    case #"hash_2f2d546c2247838f":
      weaponprobabilities["iw9_lm_kilo21_sp"] = 55;
      weaponprobabilities["iw9_lm_rkilo_sp"] = 45;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_62459cc0741ed82f":
          possibilities["barrels"] = [50, "bar_lm_p02", "bar_lm_long_p02", "bar_br_p02", "bar_br_light_p02", "bar_lm_short_p02"];
          possibilities["stocks"] = [50, "stock_lm_p02", "stock_ar_assault_p02", "stock_ar_p02", "stock_ar_tactical_p02"];
          possibilities["mags"] = [50, "belt_lm_p02", "belt_lm_large_p02"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "kilo21_sidegrip"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
        case #"hash_c82a1fa1c794832c":
          possibilities["barrels"] = [50, "bar_lm_p04", "bar_lm_long_p04", "bar_lm_light_p04", "bar_ar_hvylong_p04"];
          possibilities["stocks"] = [50, "stock_lmg_p04", "stock_lmg_heavy_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_ar_tactical_p04", "stock_ar_light_p04"];
          possibilities["mags"] = [50, "drum_lm_p04", "mag_ar_p04", "mag_ar_large_p04", "drum_lm_large_p04"];
          possibilities["scopes"] = [60, "fourx01", "fourx02", "hybrid01", "hybrid02", "hybrid03", "holo01", "holo02", "holo03", "arscope01", "hybrid05", "hybrid06"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02"];
          possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          break;
      }

      break;
    case #"hash_719417cb1de832b6":
      weaponname = "iw9_pi_golf18_sp";

      switch (weaponname) {
        case #"hash_7e15428d3b55ef10":
          possibilities["barrels"] = [50, "bar_sm_heavy_p24", "bar_sm_p24"];
          possibilities["stocks"] = [50, "stockno_pi_p24"];
          possibilities["mags"] = [50, "mag_pi_p24", "mag_pi_large_p24"];
          possibilities["scopes"] = [60, "iw9_minireddot01_pstl"];
          break;
      }

      break;
    case #"hash_23209741b93850b5":
      weaponprobabilities["iw9_sh_mbravo_sp"] = 50;
      weaponprobabilities["iw9_sh_charlie725_sp"] = 50;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_568cc2d89894d1e4":
          possibilities["barrels"] = [50, "bartube_sh_p13", "bartube_sh_heavy_p13", "bartube_sh_light_p13", "bartube_sh_short_p13"];
          possibilities["stocks"] = [50, "stockr_sh_p13", "stockr_sh_heavy_p13", "stock_sh_tactical_p13", "stock_sh_light_p13", "stockno_sh_p13", "stockno_sh_light_p13"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["underbarrels"] = [25, "guard_p13", "guard_tactical_p13", "guard_heavy_p13", "guard_light_p13"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_angled03", "grip_angled04", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sh_03"];
          break;
        case #"hash_81f38f52e4aaecf5":
          possibilities["barrels"] = [50, "bar_sh_p14", "bar_sh_short_p14", "bar_sh_long_p14"];
          possibilities["stocks"] = [50, "stockr_sh_p14", "stockr_sh_tactical_p14", "stockr_sh_heavy_p14", "stockno_sh_p14"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall", "holo01", "holo02", "holo03"];
          possibilities["underbarrels"] = [25, "guard_p14", "guard_heavy_p14", "guard_light_p14", "guard_tactical_p14"];
          possibilities["grips"] = [50, "grip_angled01", "grip_angled02", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          break;
      }

      break;
    case #"hash_900cb96c552c5e8e":
      weaponprobabilities["iw9_ar_akilo74_sp"] = 40;
      weaponprobabilities["iw9_sm_mpapa5_sp"] = 30;
      weaponprobabilities["iw9_sm_beta_sp"] = 30;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_15d131b492bdb596":
          possibilities["barrels"] = [50, "bar_ar_short_p04", "bar_ar_light_p04", "bar_ar_hvyshort2_p04", "bar_ar_lgtshort_p04"];
          possibilities["stocks"] = [50, "stock_sm_p04", "stock_ar_heavy_p04", "stock_ar_p04", "stock_sm_tactical_p04", "stock_sm_light_p04", "stockno_sm_p04"];
          possibilities["mags"] = [50, "mag_ar_light_p04", "mag_ar_lgtsmall_p04", "mag_ar_lgtlarge_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["grips"] = [50, "grip_angled08", "grip_angled09", "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_ar_01", "comp_ar_02", "comp_ar_05", "flash_ar_01"];
          break;
        case #"hash_175809755197c4da":
          possibilities["barrels"] = [50, "bar_sm_p02", "bar_sm_long_p02", "bar_sm_short_p02", "bar_sm_light_p02"];
          possibilities["stocks"] = [50, "stock_ar_p02_mpapa5", "stock_ar_tactical_p02", "stock_sm_p02"];
          possibilities["mags"] = [50, "mag_sm_p02", "mag_sm_small_p02", "mag_sm_large_p02", "drum_sm_p02"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["underbarrels"] = [25, "selectburst_mpapa5"];
          possibilities["grips"] = [50, "grip_vert01", "grip_vert02", "grip_vert03", "grip_vertshort01", "grip_vertshort02"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
        case #"hash_294ef3868701b31a":
          possibilities["barrels"] = [50, "bar_sm_lgtshort_p04", "bar_sm_short_p04"];
          possibilities["stocks"] = [50, "stock_ar_p04", "stock_ar_tactical_p04", "stock_sm_tactical_p04", "stock_sm_p04", "stock_sm_light_p04"];
          possibilities["mags"] = [50, "magheli_sm_p04", "magheligrip_sm_p04"];
          possibilities["scopes"] = [60, "iw9_minireddot01_tall", "iw9_minireddot02_tall", "iw9_minireddot03_tall", "iw9_minireddot04_tall", "holo01", "holo02", "holo03", "reflex01_tall", "reflex02_tall", "reflex03_tall", "reflex04_tall"];
          possibilities["endbarrel"] = [50, "comp_sm_01", "comp_sm_02", "comp_sm_08", "flash_sm_01"];
          break;
      }

      break;
    case #"hash_6191aaef9f922f96":
      weaponprobabilities["iw9_dm_pgolf1_sp"] = 100;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_3fd5bba485c2aea6":
          if(getDvar(@ "g_mapname") == "shipaf") {
            possibilities["barrels"] = [50, "bar_sn_p02"];
            possibilities["stocks"] = [50, "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02_pgolf1", "stock_sm_p02", "stock_ar_p02"];
            possibilities["mags"] = [50, "mag_sn_p02", "mag_sn_large_p02"];
            possibilities["scopes"] = [100, "pgolf1_scope"];
            possibilities["underbarrels"] = [40, "bipod01"];
            possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          } else {
            possibilities["barrels"] = [50, "bar_sn_p02"];
            possibilities["stocks"] = [50, "stock_sn_p02", "stock_lm_p02", "stock_ar_tactical_p02", "stock_ar_assault_p02_pgolf1", "stock_sm_p02", "stock_ar_p02"];
            possibilities["mags"] = [50, "mag_sn_p02", "mag_sn_large_p02"];
            possibilities["scopes"] = [100, "arscope_nvgvz01"];
            possibilities["underbarrels"] = [40, "bipod01"];
            possibilities["endbarrel"] = [50, "comp_br_01", "comp_br_02", "comp_br_05", "flash_br_01"];
          }

          break;
      }

      break;
  }

  return utility::make_weapon_random(weaponname, possibilities, attachment_combos, camos);
}

function function_3067ab4eb4ea11bc() {
  if(getdvarint(@ "hash_45281f93550798")) {
    iprintln("<dev string:x1c>");
  }
}

function getweapon_camos(type) {
  if(getdvarint(@ "hash_f9de3dfe4b6a8b1d") == 1) {
    return undefined;
  }

  if(!isDefined(type)) {
    type = "";
  }

  switch (type) {
    case #"hash_f25452037edd4426":
      camos = ["camo_g_15"];
      break;
    case #"hash_56d684365f7b7351":
      camos = ["camo_b_07", "camo_b_01", "camo_a_09", "camo_a_06"];
      break;
    case #"hash_fa18d1f6bd5790c7":
      camos = ["camo_a_15"];
      break;
    case #"hash_3931080a2ee4d716":
      camos = [];
      break;
    case #"hash_2ede1edb8e3a2efb":
      camos = ["camo_c_15"];
      break;
    case #"hash_8915246c51a3d9ff":
      camos = ["camo_g_15"];
      break;
    case #"hash_97430d6c58e61996":
    default:
      var_4ca63053485b6085 = ["camo_a_01", "camo_a_03", "camo_a_04", "camo_a_06", "camo_a_08", "camo_a_09"];
      var_4ca62d53485b59ec = ["camo_b_01", "camo_b_02", "camo_b_03", "camo_b_05", "camo_b_06", "camo_b_07", "camo_b_09", "camo_b_11"];
      camos = array_combine(var_4ca63053485b6085, var_4ca62d53485b59ec);
      break;
    case #"hash_8d7bc464d5bdd18d":
      camos = ["camo_b_07", "camo_b_01", "camo_a_09", "camo_a_06"];
      break;
  }

  return camos;
}