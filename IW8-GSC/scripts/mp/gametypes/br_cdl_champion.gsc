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
  var0 = getdvarint("scr_br_cdl_trophy_show", 0);
  var1 = relic_amped_explosion_time();
  var2 = "lm_decor_stadium_codl_trophy_cover";
  var3 = ["lm_decor_stadium_codl_banner_01", "lm_decor_stadium_codl_banner_02", "lm_decor_stadium_codl_banner_03", "lm_decor_stadium_codl_banner_04", "lm_decor_stadium_codl_banner_05"];
  var4 = ["trophy_cover_off", "foliage_on", "banner_on"];
  var5 = ["codl_trophy_cover", "codl_banner"];
  var6 = relic_amped_in_warning(var2, var4[0]);

  if(isDefined(var6)) {
    if(istrue(var0)) {
      ref_13136(var6, var5[0], 0);
    } else {
      ref_13136(var6, var5[0], 1);
    }
  }

  for(var7 = 0; var7 < var3.size; var7++) {
    var8 = relic_amped_in_warning(var3[var7], var4[2]);

    if(isDefined(var8)) {
      if(scripts\engine\utility::array_contains(var1, var7)) {
        ref_13136(var8, var5[1], 1);
        continue;
      }

      ref_13136(var8, var5[1], 0);
    }
  }
}

function ref_13136(var0, var1, var2) {
  if(istrue(var2)) {
    var0 setscriptablepartstate(var1, "visible");
    return;
  }

  var0 setscriptablepartstate(var1, "hidden");
}

function relic_amped_in_warning(var0, var1) {
  var2 = getentitylessscriptablearrayinradius(var1, "targetname");

  if(!isDefined(var2)) {
    return;
  }

  foreach(var4 in var2) {
    if(var4.type == var0) {
      return var4;
    }
  }
}

function relic_amped_explosion_time() {
  var0 = [];

  if(getDvar("scr_br_cdl_banners_show") != "") {
    var1 = strtok(getDvar("scr_br_cdl_banners_show"), " ");

    for(var2 = 0; var2 < var1.size; var2++) {
      if(int(var1[var2]) == 0) {
        return [];
      }

      var0 = int(var1[var2]) - 1;
    }
  }

  return var0;
}