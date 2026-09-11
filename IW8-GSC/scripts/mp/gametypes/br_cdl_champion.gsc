/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_cdl_champion.gsc
****************************************************/

function init() {
  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  ref_12800();
}

function ref_12800() {
  var_0 = getdvarint("scr_br_cdl_trophy_show", 0);
  var_1 = relic_amped_explosion_time();
  var_2 = "lm_decor_stadium_codl_trophy_cover";
  var_3 = ["lm_decor_stadium_codl_banner_01", "lm_decor_stadium_codl_banner_02", "lm_decor_stadium_codl_banner_03", "lm_decor_stadium_codl_banner_04", "lm_decor_stadium_codl_banner_05"];
  var_4 = ["trophy_cover_off", "foliage_on", "banner_on"];
  var_5 = ["codl_trophy_cover", "codl_banner"];
  var_6 = relic_amped_in_warning(var_2, var_4[0]);

  if(isDefined(var_6)) {
    if(istrue(var_0)) {
      ref_13136(var_6, var_5[0], 0);
    } else {
      ref_13136(var_6, var_5[0], 1);
    }
  }

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    var_8 = relic_amped_in_warning(var_3[var_7], var_4[2]);

    if(isDefined(var_8)) {
      if(scripts\engine\utility::array_contains(var_1, var_7)) {
        ref_13136(var_8, var_5[1], 1);
        continue;
      }

      ref_13136(var_8, var_5[1], 0);
    }
  }
}

function ref_13136(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_0 setscriptablepartstate(var_1, "visible");
    return;
  }

  var_0 setscriptablepartstate(var_1, "hidden");
}

function relic_amped_in_warning(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }

  foreach(var_4 in var_2) {
    if(var_4.type == var_0) {
      return var_4;
    }
  }
}

function relic_amped_explosion_time() {
  var_0 = [];

  if(getDvar("scr_br_cdl_banners_show") != "") {
    var_1 = strtok(getDvar("scr_br_cdl_banners_show"), " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(int(var_1[var_2]) == 0) {
        return [];
      }

      var_0 = int(var_1[var_2]) - 1;
    }
  }

  return var_0;
}