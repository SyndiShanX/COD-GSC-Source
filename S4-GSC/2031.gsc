/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2031.gsc
*************************************************/

_id_7FEF() {
  level._id_CC0A = ::_id_A000;
  level._id_9BC9 = spawnStruct();
  level._id_9BC9._id_FE20 = [10, 15, 20, 30, 40, 50, 60, 75, 80, 90, 100, 125, 150, 175, 200, 225, 250, 300];
  level._id_9BC9._id_832B = ["very_low", "low", "medium", "high", "very_high"];
  level._id_9BC9._id_832A = [];
  var_0 = 0;

  foreach(var_2 in level._id_9BC9._id_832B) {
    level._id_9BC9._id_832A[var_2] = var_0;
    var_0++;
  }

  level._id_9BC9._id_9AC9 = ["small", "medium", "large"];
  level._id_9BC9._id_9AC8 = [];
  var_0 = 0;

  foreach(var_2 in level._id_9BC9._id_9AC9) {
    level._id_9BC9._id_9AC8[var_2] = var_0;
    var_0++;
  }
}

_id_A000(var_0) {
  if(getdvarint("#x31c7a62a2b9f7cadb", 0)) {
    return var_0;
  }

  var_1 = ["very_low", "low", "medium", "high", "very_high"];
  var_2 = get_intensity_mode_list();
  var_3 = getDvar("#x315af23e89f368200");
  var_4 = getDvar("#x376847958d67972ef");
  var_6 = scripts\mp\utility\game::_id_6C73();
  var_8 = 1;
  var_9 = var_8 + 3;
  var_10 = 1.0;
  var_11 = level._id_9BC9._id_832A[var_6];
  var_12 = scripts\engine\utility::_id_1BAB(var_2, var_3);

  if(!isDefined(var_12) || var_12 < 0) {
    return level._id_CC09;
  }

  if(isDefined(var_11)) {
    var_13 = var_9 + var_11;
    var_14 = _func_0222("mp/matchIntensityTable.csv", 0, var_3, var_13);

    if(isDefined(var_14) && var_14 != "") {
      var_10 = float(var_14);
    } else {}

    game["dialog"]["matchIntensity"] = "mp_glob_inin_bchr_";
    var_15 = "";

    switch (var_6) {
      case "very_low":
        var_15 = "ivl";
        break;
      case "low":
        var_15 = "iil";
        break;
      case "medium":
        var_15 = "iim";
        break;
      case "high":
        var_15 = "iih";
        break;
      case "very_high":
        var_15 = "ivh";
        break;
    }

    var_16 = randomintrange(1, 10);

    if(var_16 == 10) {
      var_15 = _func_00D6(var_15, 1, 2);
    }

    game["dialog"]["matchIntensity"] = game["dialog"]["matchIntensity"] + (var_15 + var_16);
  } else {}

  if(!isDefined(var_3) || !isDefined(var_4) || !isDefined(var_6)) {
    return level._id_CC09;
  }

  var_3 = get_core_gametype(var_3);
  var_17 = get_max_team_size();

  if(!isDefined(var_17) || var_17 <= 0) {
    return level._id_CC09;
  }

  if(isDefined(var_3) && isDefined(var_6)) {
    var_18 = getdvarint(_func_0483("#x3ecead486797add6d", var_3, "_scorelimit_", var_6), 0);

    if(var_18 > 0) {
      return var_18;
    }
  }

  var_19 = scripts\engine\utility::_id_1BAB(var_2, var_3) + 2;
  var_20 = 0;
  var_18 = undefined;

  for(;;) {
    var_21 = tablelookupbyrow("mp/matchIntensityScoreTable.csv", var_20, 0);

    if(!isDefined(var_21) || var_21 == "") {
      break;
    }

    if(var_21 == var_4) {
      var_22 = tablelookupbyrow("mp/matchIntensityScoreTable.csv", var_20, 1);

      if(var_22 == var_6) {
        var_18 = int(tablelookupbyrow("mp/matchIntensityScoreTable.csv", var_20, var_19));
        break;
      }
    }

    var_20++;
  }

  if(!isDefined(var_18) || var_18 < 0) {
    return level._id_CC09;
  }

  return var_18;
}

get_max_team_size() {
  var_0 = getDvar("#x376847958d67972ef");
  var_1 = get_core_gametype(getDvar("#x315af23e89f368200"));
  var_2 = scripts\mp\utility\game::_id_6C73();
  var_3 = get_intensity_mode_list();
  var_4 = scripts\engine\utility::_id_1BAB(var_3, var_1);

  if(!isDefined(var_4) || var_4 < 0) {
    return 0;
  }

  var_5 = 3;
  var_6 = var_5 + var_4 * 2;
  var_7 = undefined;
  var_8 = 0;

  for(;;) {
    var_9 = tablelookupbyrow("mp/matchIntensityValuesTable.csv", var_8, 0);

    if(!isDefined(var_9) || var_9 == "") {
      break;
    }

    if(var_9 == var_0) {
      var_10 = tablelookupbyrow("mp/matchIntensityValuesTable.csv", var_8, 1);

      if(var_10 == var_2) {
        var_7 = int(tablelookupbyrow("mp/matchIntensityValuesTable.csv", var_8, var_6));
        break;
      }
    }

    var_8++;
  }

  if(getdvarint("#x34942bc719b3ea28f", 0) > 0) {
    var_7 = getdvarint("#x34942bc719b3ea28f", 0);
  }

  return var_7;
}

get_core_gametype(var_0) {
  switch (var_0) {
    case "conf_tdm":
      var_0 = "conf";
      break;
    case "hc_tdm":
      var_0 = "war";
      break;
    case "hc_dom":
      var_0 = "dom";
      break;
    case "hc_koth":
      var_0 = "koth";
      break;
    case "hc_sd":
      var_0 = "sd";
      break;
    case "hc_conf_tdm":
      var_0 = "conf";
      break;
    case "hc_conf":
      var_0 = "conf";
      break;
    case "hc_patrol":
      var_0 = "patrol";
      break;
    case "hc_dm":
      var_0 = "dm";
      break;
  }

  if(var_0 == "conf_tdm") {
    var_0 = "conf";
  }

  if(var_0 == "hc_conf") {
    var_0 = "hc_conf_tdm";
  }

  return var_0;
}

get_intensity_mode_list() {
  return ["war", "dom", "koth", "sd", "conf", "patrol", "dm", "control", "kspoint", "infect", "gun"];
}