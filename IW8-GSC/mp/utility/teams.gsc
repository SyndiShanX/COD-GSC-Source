/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\teams.gsc
***********************************************/

getteamdata(var_0, var_1) {
  return level.teamdata[var_0][var_1];
}

setteamdata(var_0, var_1, var_2) {
  level.teamdata[var_0][var_1] = var_2;
}

modifyteamdata(var_0, var_1, var_2) {
  level.teamdata[var_0][var_1] = level.teamdata[var_0][var_1] + var_2;
}

addplayertoteam(var_0, var_1, var_2) {
  level.teamdata[var_1]["_encstr_AB580A05672AE35D5FFF50B8"]++;
  level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"] = scripts\engine\utility::array_add(level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"], var_0);

  if(var_2)
    addtoteamlives(var_0, var_1, 0, "_encstr_930B10BB1C6FF159EFF3F11B09FF1D2B467D");
}

removeplayerfromteam(var_0, var_1) {
  level.teamdata[var_1]["_encstr_AB580A05672AE35D5FFF50B8"]--;
  level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"] = scripts\engine\utility::array_remove(level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"], var_0);
}

addtoteamlives(var_0, var_1, var_2, var_3) {
  level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"]++;
  level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"] = scripts\engine\utility::array_add(level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], var_0);

  if(level.multiteambased)
    level.teamdata[var_1]["_encstr_8B340BAAD957B3BA5DD33DBB1B"] = 0;

  _id_140C9("_encstr_931904467462", var_1, var_0);

  if(isDefined(level._id_11C65))
    [[level._id_11C65]](var_0, var_1, var_3);

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }
  if(istrue(var_2) && isgameplayteam(var_1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    foreach(var_0 in level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"])
    var_0 playlocalsound("_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559");

    var_6 = getenemyplayers(var_1);

    foreach(var_0 in var_6)
    var_0 playlocalsound("_encstr_8C321BB60EBE98DB46BC8DB7EACD3AD73AB4C65BEBCD59D9B0D196B3CA");
  }
}

removefromteamlives(var_0, var_1, var_2, var_3) {
  level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"]--;
  level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"] = scripts\engine\utility::array_remove(level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], var_0);
  _id_140C9("_encstr_A353071677FAF7EB45", var_1, var_0);

  if(isDefined(level._id_11C7E))
    [[level._id_11C7E]](var_0, var_1, var_3);

  if(istrue(var_2) && isgameplayteam(var_1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_4 = "_encstr_8C321BB60EBE98DB46BC8DB7EACD3AD73AB4C65BEBCD59D9B0D196B3CA";
    var_5 = "_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559";

    if(level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"] == 1) {
      var_4 = "_encstr_99A921CDA776134D5940B28AD8B5432FCB834B73A83877177BA31A1370FFBFAF207FDC";
      var_5 = "_encstr_95DE21ADE0FA98DE19F2B17B57E6D1D7E89636ADFA38B7CD4BE8B43BACAFCC5AB9B036";
    }

    var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, var_0.squadindex);

    foreach(var_0 in var_6)
    var_0 playlocalsound(var_4);

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      var_9 = getenemyplayers(var_1);

      foreach(var_0 in var_9)
      var_0 playlocalsound(var_5);
    }
  }
}

_id_140C9(var_0, var_1, var_2) {
  var_3 = getdvarint("_encstr_B2D8147B77AD67BFB9E3FB873F62D008B0E87958D980", 1);
  var_4 = 0;
  var_5 = 0;

  if(var_0 == "_encstr_8D820B49520F0EC02DDE6367EC") {
    var_4 = scripts\engine\utility::array_contains(level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], var_2);

    if(var_4 && var_3)
      var_2 scripts\mp\playerlogic::removefromalivecount(1, "_encstr_9949134B20F17CB3312D7549C9D8338757B8E34230");
  } else if(var_0 == "_encstr_931904467462") {
    var_6 = scripts\engine\utility::array_remove_duplicates(level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]);

    if(var_6.size < level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size) {
      var_5 = 1;
      var_0 = var_0 + "_encstr_9B110B4019EAC11BA5B1163A95";
    }
  }

  var_7 = level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size;
  var_8 = level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"];

  if(var_7 != var_8 || var_4 || var_5) {
    var_9 = "_encstr_B40101";

    if(var_5)
      var_9 = "_encstr_970C312F87A1A0C1DE47DAA1BFCD40F94A673BE18F2E0730092039E31AC0B02036D7A9436B82E7982C3EA21942283866AB3F1B";
    else if(var_4)
      var_9 = "_encstr_AB1131D5A0A4729439E81D040E632CF2B29304A5DC10C2D8A5CEAC0458E49385CB04859947959C08912DE66CBDB99BCAD8E809";
    else
      var_9 = "_encstr_993736EA0A492729933A8E10C236D2CECA0A362CBC2B4ECD1016373240B0D84BD9B234BDEACDE80885392B807BAB8E10DE3301E6E5B9D812";

    getentitylessscriptablearray("_encstr_B2112069C82FC7E903B832189D68AF62585BFDFF10708BB87119E723C8530B9BB201", ["_encstr_BE190E58D8A5672BAF07D8B0CBB2C96E", var_7, "_encstr_8EC00C17493BEBED7911AD33A8F8", var_8, "_encstr_A101062B6759E68E", var_0, "_encstr_8AEF05472BC2D6", var_1, "_encstr_84E90C90A37122C32329CB55BC9A", var_2 getxuid(), "_encstr_B1540CA9FB5AF3782A89A8412DE5", var_2.name]);
    scripts\mp\utility\script::laststand_dogtags(var_9);

    if(var_3) {
      level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"] = scripts\engine\utility::array_remove_duplicates(level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]);
      level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"] = level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size;
      [[level.updategameevents]]();
    }
  }
}

getteamcount(var_0, var_1) {
  if(istrue(var_1))
    return level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size;
  else
    return level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"].size;
}

resetchallengetimer() {
  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    var_3 = getteamcount(var_2, 1);

    if(var_3 > 0)
      var_0++;
  }

  return var_0;
}

getenemyteams(var_0) {
  var_1 = level.teamnamelist;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);

  if(isDefined(level._id_14687) || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe())
    var_1 = scripts\engine\utility::array_remove(var_1, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");

  return var_1;
}

getfriendlyplayers(var_0, var_1) {
  var_2 = [];

  if(istrue(var_1)) {
    foreach(var_4 in level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
      if(isDefined(var_4) && isalive(var_4) && !isDefined(var_4.fauxdead))
        var_2[var_2.size] = var_4;
    }
  } else {
    foreach(var_4 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

getenemyplayers(var_0, var_1) {
  var_2 = [];
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level.teamdata[var_5]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7.fauxdead))
          var_2[var_2.size] = var_7;
      }

      continue;
    }

    foreach(var_7 in level.teamdata[var_5]["_encstr_9775086022BE1B413B8B"])
    var_2[var_2.size] = var_7;
  }

  return var_2;
}

getenemycount(var_0, var_1) {
  var_2 = 0;
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3)
  var_2 = var_2 + getteamcount(var_5, istrue(var_1));

  return var_2;
}

isgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}

getfaction(var_0) {
  return game[var_0];
}

getteamname(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_8A56098B52874989AE9D23"]))
    level.teamdata[var_0]["_encstr_8A56098B52874989AE9D23"] = tablelookupistring("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 1);

  return level.teamdata[var_0]["_encstr_8A56098B52874989AE9D23"];
}

getteamshortname(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_86C00AA69C7BFB0D830A5BF9"]))
    level.teamdata[var_0]["_encstr_86C00AA69C7BFB0D830A5BF9"] = tablelookupistring("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 2);

  return level.teamdata[var_0]["_encstr_86C00AA69C7BFB0D830A5BF9"];
}

getteamicon(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_A96F097BAF99905B32B7CD"]))
    level.teamdata[var_0]["_encstr_A96F097BAF99905B32B7CD"] = tablelookup("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 5);

  return level.teamdata[var_0]["_encstr_A96F097BAF99905B32B7CD"];
}

getteamheadicon(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_8B5909E3BD5F51733E1A80"]))
    level.teamdata[var_0]["_encstr_8B5909E3BD5F51733E1A80"] = tablelookup("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 7);

  return level.teamdata[var_0]["_encstr_8B5909E3BD5F51733E1A80"];
}

getteamvoiceinfix(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_8D2B0B731835B061416B9B8751"]))
    level.teamdata[var_0]["_encstr_8D2B0B731835B061416B9B8751"] = tablelookup("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 8);

  return level.teamdata[var_0]["_encstr_8D2B0B731835B061416B9B8751"];
}

getcustomizationprefix(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_AACE13C6D5E6A3DB6B5A4F588EA57B7329E666A5E1"]))
    level.teamdata[var_0]["_encstr_AACE13C6D5E6A3DB6B5A4F588EA57B7329E666A5E1"] = tablelookup("_encstr_AAC7145B0797CC161B1D5A7B9B5116C41BB28B8DCD67", 0, game[var_0], 10);

  return level.teamdata[var_0]["_encstr_AACE13C6D5E6A3DB6B5A4F588EA57B7329E666A5E1"];
}

rpgafterspawnfunc(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"])) {
    switch (var_0) {
      case "_encstr_8E8405EA382B2A":
        var_1 = 10;
        break;
      case "_encstr_9A8507BA4040188D08":
        var_1 = 11;
        break;
      case "_encstr_9B920B8EAC166BFAD186E49595":
        var_1 = 12;
        break;
      case "_encstr_8DB30A47B216ADEB99EDAE39":
        var_1 = 13;
        break;
      case "_encstr_B6B30A098586B0784B5A0B11":
        var_1 = 14;
        break;
      case "_encstr_93ED097B8081DD415F0BD8":
        var_1 = 15;
        break;
      default:
        var_1 = 11;
        break;
    }

    level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"] = tablelookup("_encstr_A2E20FB8A08F601808984D9A75265E3ABB", 0, scripts\cp_mp\utility\game_utility::getmapname(), var_1);

    if(level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"] == "_encstr_B40101")
      level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"] = "_encstr_83E4052BCF5026";

    game[var_0] = level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"];
  }

  return level.teamdata[var_0]["_encstr_A9900CF97556602487CA7BC01263"];
}

getcustomgametypeteammax() {
  var_0 = scripts\mp\utility\game::getgametype();
  return getdvarint("_encstr_AF1805EFE726E9" + var_0 + "_encstr_8C040BBEA3CAB0B5C6B7D5373A", -1);
}

_id_13A9F() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E570DE81A168BBE8F14D3591153A2", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53", ::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E570DE81A168BBE8F14D3591153A2", "_encstr_8109104A2DEB99C539550A3A11D1D2ADA52A", ::getenemyplayers);
}