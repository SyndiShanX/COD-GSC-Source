/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\infilexfil\infilexfil.gsc
***********************************************/

infil_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(getdvarint("_encstr_82BE108B3E9A1156425FE1B7B7FA14782C92", 0) == 1) {
    if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");

    return;
  }

  level.prematchperiod = 10;

  while(!isDefined(level.teamnamelist))
    waitframe();

  level.requiredplayercount["_encstr_9A8507BA4040188D08"] = 0;
  level.requiredplayercount["_encstr_8E8405EA382B2A"] = 0;

  if(!isDefined(game["_encstr_9B8F06A38D72C380"])) {
    foreach(var_9 in level.teamnamelist)
    game["_encstr_9B8F06A38D72C380"][var_9] = [];

    game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"] = [];
  }

  if(isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0]) && isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1])) {
    if(isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"]))
      self[[game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"]]](var_0, var_1);

    if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");

    return;
  }

  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1] = [];
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_88DB0B5803A1536541371DA84E"] = var_5;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_8F950C1C630BBCCA9CAF33BACD8D"] = var_7;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_8313107770350721394D190BA9C83E85303E"] = var_6;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_823006E62B0BA337"] = var_2;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A77E0FE4B2C5D596939519F5CD2B2CE8CD"] = var_3;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_824E0B042B73F36988835CD308"] = var_4;
  level thread infil_init(var_0, var_1);
}

infil_init(var_0, var_1) {
  waittillframeend;

  if(!isDefined(level.prematchperiod) || level.prematchperiod == 0) {
    return;
  }
  scripts\cp\utility::gameflaginit("_encstr_8C0D0E8410E8B112602F133F559DCAF4", 0);

  if(!isDefined(level.infilinitonce)) {
    level.infilinitonce = 1;
    level thread onplayerspawned();
    level thread onjoinedteam();
  }

  level.prematchallowfunc = ::infil_player_allow_cp;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in get_all_infils()) {
    if(!var_5 infil_is_gamemode()) {
      continue;
    }
    if(var_5 infil_has_map_config())
      infil_init_spawn_selection();

    var_6 = var_5.script_team;

    if(var_5 scripts\cp\cp_infilexfil::infil_is_type(var_0) && var_5 scripts\cp\cp_infilexfil::infil_is_subtype(var_1) && isinfilgameplayteam(var_5.script_team)) {
      var_7 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1];
      var_8 = var_5[[var_7["_encstr_88DB0B5803A1536541371DA84E"]]](var_5.script_team, var_5.target, var_5.name);
      var_8.players = [];
      var_8.type = var_5.script_noteworthy;
      var_8.subtype = var_5.name;
      var_6 = var_5.script_team;
      game["_encstr_9B8F06A38D72C380"][var_6]["_encstr_99EC06E297A25BEE"][var_0][var_1] = var_8;
      register_infil_spots(var_6, var_8, var_7["_encstr_823006E62B0BA337"], var_7["_encstr_A77E0FE4B2C5D596939519F5CD2B2CE8CD"], var_7["_encstr_824E0B042B73F36988835CD308"], var_7["_encstr_8F950C1C630BBCCA9CAF33BACD8D"]);
      var_9 = var_8[[var_7["_encstr_8313107770350721394D190BA9C83E85303E"]]](var_1);

      if(!isDefined(var_2)) {
        var_9 = var_9 + 1.0;
        var_2 = var_9;
      } else
        var_9 = var_9 + 1.0;
    }
  }

  if(gamehasinfil() && isDefined(var_2)) {
    level.prematchperiod = 10;
    level.prematchperiodend = var_2 + 1.0;
    level thread infil_setup_ui();
    level thread infil_wait_for_all_players();
  }
}

onplayerspawned() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  for(;;) {
    level waittill("_encstr_859815B3BB4B5F6538B764779F78EDE778B6FA9A412B03", var_0);

    if(playerinfildisabled(var_0)) {
      continue;
    }
    var_1 = scripts\cp\utility::getotherteam(var_0.team);

    if(isarray(var_1))
      var_2 = var_1[0];
    else
      var_2 = var_1;

    var_3 = get_spot_from_player(var_0, var_2);

    if(isDefined(var_3))
      player_free_spot(var_0, scripts\cp\utility::getotherteam(var_2));

    if(!scripts\cp\utility::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4"))
      var_0 player_join_infil_cp();
  }
}

playerinfildisabled(var_0) {
  return istrue(var_0.infil_disabled);
}

disableplayerinfil(var_0) {
  var_0.infil_disabled = 1;
}

onjoinedteam() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_0);

    if(isDefined(var_0.team) && var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      var_0 thread infilspectatorview();
  }
}

infilspectatorview() {
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_ADC913C07596B8C1C9C3C3D7CB3215403AC348D95B");
  self endon("_encstr_ADC913C07596B8C1C9C3C3D7CB3215403AC348D95B");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0.0, 0.55, "_encstr_81A3086ECB28576FAD13");
  level waittill("_encstr_B2600CF8759933D3EE634E77CB7A");
  self notify("_encstr_81A3086ECB28576FAD13");
}

onplayerdisconnectinfil() {
  self endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_0 = self.team;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  player_free_spot(self, var_0);
}

get_all_infils(var_0) {
  if(isDefined(var_0))
    return scripts\engine\utility::getStructArray("_encstr_A2020B2882FFBBE00F0CC3BFF5", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  else
    return scripts\engine\utility::getStructArray("_encstr_B606099A8BB9EC5A283379", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

infil_is_gamemode() {
  self.spawnflags = int(self.spawnflags);

  if(!isDefined(self.spawnflags) || self.spawnflags == 0)
    return 0;

  if(!level.teambased)
    return 0;

  if(self.spawnflags & 1)
    return 1;

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "_encstr_A20D05FBEB01F2":
      case "_encstr_8E65062BD0CFB4EC":
      case "_encstr_A7290676E4D2378C":
      case "_encstr_959105B99040BD":
      case "_encstr_B41904BB8593":
      case "_encstr_B81904B04E6B":
        return 1;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "_encstr_B60703EACA":
      case "_encstr_9B0703CD93":
      case "_encstr_B807035284":
        return 1;
    }
  }

  if(self.spawnflags & 8) {
    switch (level.gametype) {
      case "_encstr_A54F06D32A2F0498":
      case "_encstr_8218041DF5FA":
        return 1;
    }
  }

  if(self.spawnflags & 16) {
    switch (level.gametype) {
      case "_encstr_BDD705AD7BD143":
      case "_encstr_9A7205B39CB919":
        return 1;
    }
  }

  if(self.spawnflags & 32) {
    switch (level.gametype) {
      case "_encstr_8E1904B3F501":
        return 1;
    }
  }

  if(self.spawnflags & 64) {
    switch (level.gametype) {
      case "_encstr_ACF906B79752C5E8":
        return 1;
    }
  }

  if(self.spawnflags & 128) {
    switch (level.gametype) {
      case "_encstr_9719046E3182":
        return 1;
    }
  }

  return 0;
}

infil_has_map_config() {
  return isDefined(self.script_label) && level.gametype == "_encstr_A53E0883E976B715503F";
}

infil_init_spawn_selection() {}

infil_player_allow_cp(var_0, var_1) {
  if(self ishost() && getdvarint("_encstr_9677144F98CBD71A4DA4C4BDAF5FC3B5B1487FDB6063") == 1) {
    scripts\common\utility::allow_weapon(var_0);
    return;
  }

  self allowmovement(var_0);
  scripts\common\utility::allow_prone(var_0);
  scripts\common\utility::allow_crouch(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_ads(var_0);
  scripts\common\utility::allow_sprint(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_reload(var_0);
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_script_weapon_switch(var_0);
}

register_infil_spots(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]))
    game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"] = [];

  var_6 = game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"].size;

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"].size;

    if(isDefined(var_4)) {
      var_9 = 0;

      foreach(var_15, var_11 in var_4) {
        foreach(var_13 in var_11) {
          if(var_13 == var_8 - var_6) {
            game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_8]["_encstr_978C092BB8FBFDEB302D69"] = var_15;
            var_9 = 1;
            break;
          }
        }

        if(var_9) {
          break;
        }
      }
    } else
      game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_8]["_encstr_978C092BB8FBFDEB302D69"] = -1;

    game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_8]["_encstr_82180596773AC1"] = var_7;
    game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_8]["_encstr_9B8F06A38D72C380"] = var_1;
    game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_8]["_encstr_A7AA09C616D81B26586CB5"] = var_5;
  }

  if(var_3 > level.requiredplayercount[var_0])
    level.requiredplayercount[var_0] = var_3;
}

player_on_spot(var_0, var_1) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"])) {}

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1])) {}

  if(isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"])) {}

  game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"] = var_0;
  return game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1];
}

player_free_spot(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.team;

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"])) {}

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"]) {
    if(is_spot_taken(var_1, var_4) && var_3["_encstr_8BB007E03658CBCAE4"] == var_0) {
      game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"][var_4]["_encstr_8BB007E03658CBCAE4"] = undefined;
      var_0 notify("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
      return;
    }
  }
}

get_player_at_spot(var_0, var_1) {
  return game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"];
}

get_spot_from_player(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0.team;

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"]))
    return undefined;

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"]) {
    if(isDefined(var_3["_encstr_8BB007E03658CBCAE4"]) && var_3["_encstr_8BB007E03658CBCAE4"] == var_0)
      return var_4;
  }

  return undefined;
}

is_spot_taken(var_0, var_1) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"])) {}

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_1])) {}

  return isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"]);
}

get_spot_taken_count(var_0) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"])) {}

  var_1 = 0;

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(is_spot_taken(var_0, var_4))
      var_1++;
  }

  return var_1;
}

get_spot_by_priority(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(!is_spot_taken(var_0, var_4))
      var_1[var_1.size] = var_4;
  }

  if(var_1.size == 0)
    return undefined;

  var_5 = getdvarint("_encstr_8ABA15EB69853FC3B008F0ACF72A128B8BBFE762B97F7D", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5))
    return var_5;

  var_6 = [];
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_3]["_encstr_978C092BB8FBFDEB302D69"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6[var_6.size] = var_3;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7)
      var_6[var_6.size] = var_3;
  }

  return var_6[randomint(var_6.size)];
}

get_random_spot(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(!is_spot_taken(var_0, var_4))
      var_1[var_1.size] = var_4;
  }

  if(var_1.size == 0)
    return undefined;

  var_3 = scripts\engine\utility::random(var_1);
  return var_3;
}

get_taken_spot_count(var_0) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]))
    return 0;

  var_1 = 0;

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(is_spot_taken(var_0, var_4))
      var_1++;
  }

  return var_1;
}

get_taken_spot_percent(var_0) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]))
    return 0;

  var_1 = 0;
  var_2 = 0;

  foreach(var_5, var_4 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    var_1++;

    if(is_spot_taken(var_0, var_5))
      var_2++;
  }

  return var_2 / var_1;
}

player_join_infil_cp() {
  if(game["_encstr_9B8F06A38D72C380"][self.team].size == 0) {
    return;
  }
  if(self ishost() && getdvarint("_encstr_9677144F98CBD71A4DA4C4BDAF5FC3B5B1487FDB6063") == 1) {
    player_ai_fill();
    return;
  }

  var_0 = 0;
  var_1 = game["_encstr_9B8F06A38D72C380"][self.team]["_encstr_B18A065E98576317"][0]["_encstr_978C092BB8FBFDEB302D69"] != -1;

  if(level.gametype == "_encstr_A53E0883E976B715503F" && isDefined(self.tacopsmapselectedarea.dynamicent))
    var_2 = scripts\cp\cp_infilexfil::get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  else if(var_0)
    var_2 = get_spot_taken_count(self.team);
  else if(var_1)
    var_2 = get_spot_by_priority(self.team);
  else
    var_2 = get_random_spot(self.team);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = player_on_spot(self, var_2);
  var_3["_encstr_9B8F06A38D72C380"] thread scripts\cp\cp_infilexfil::infil_player_array_handler(self);
  self notify("_encstr_AA2C160B1D69C0BD3367E3E1A36A75A914B596A005D688E1");
  self thread[[var_3["_encstr_A7AA09C616D81B26586CB5"]]](var_3["_encstr_9B8F06A38D72C380"], var_3["_encstr_82180596773AC1"]);
  thread blockswaploadouts();
  thread onplayerdisconnectinfil();
  player_ai_fill();
}

blockswaploadouts() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.delayswaploadout = 1;
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self.delayswaploadout = 0;
}

player_ai_fill() {}

infil_setup_ui() {
  foreach(var_1 in level.players)
  var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);

  level.bypassclasschoicefunc = scripts\cp\cp_infilexfil::alwaysgamemodeclass;
  level.infil_in_progress_buffer = 1;
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  foreach(var_1 in level.players)
  var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);

  var_5 = getomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD");
  setomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD", 1);
  level.bypassclasschoicefunc = undefined;
  level.infil_in_progress = 1;
  var_6 = getdvarint("_encstr_9B550B98A728B4D494395151A6");
  var_7 = getdvarint("_encstr_97E60BFB592484E17DF6B2BD5F");
  var_8 = getdvarint("_encstr_92290B8D3A757F3039B7F3594F");
  setDvar("_encstr_9B550B98A728B4D494395151A6", 0);
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", 1);
  setDvar("_encstr_92290B8D3A757F3039B7F3594F", 1);
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
    var_1 setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);
  }

  setomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD", var_5);
  setDvar("_encstr_9B550B98A728B4D494395151A6", var_6);
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", var_7);
  setDvar("_encstr_92290B8D3A757F3039B7F3594F", var_8);
  level.infil_in_progress = undefined;
  wait 2;
  level.infil_in_progress_buffer = undefined;

  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

infil_show_countdown() {
  wait(level.prematchperiodend - 5);
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 2);
}

infil_wait_for_all_players() {
  level waittill("_encstr_859815B3BB4B5F6538B764779F78EDE778B6FA9A412B03", var_0);
  level.num_of_player_ready_to_infil = 1;
  wait_for_all_players_or_timeout();
  scripts\cp\utility::gameflagset("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  if(getdvarint("_encstr_AAA6164790C3CF0245ACFCB51821EBB128507FDF80193A1B", 0) == 1) {
    foreach(var_0 in level.players)
    iprintlnbold("_encstr_964D2053B8C7B0A3D8C11D71FB44107D2FCCD8F677FF993090375AC7FD11FD2125AE");
  }
}

wait_for_all_players_or_timeout() {
  level thread player_trying_to_join_infil_monitor();
  level thread max_wait_for_infil_to_start();
  level waittill("_encstr_AC25157DFDCEB033F7C3909E5BB3E7D8236FF3CD66B4B8");
}

player_trying_to_join_infil_monitor() {
  level endon("_encstr_AC25157DFDCEB033F7C3909E5BB3E7D8236FF3CD66B4B8");

  for(;;) {
    level waittill("_encstr_859815B3BB4B5F6538B764779F78EDE778B6FA9A412B03", var_0);
    level.num_of_player_ready_to_infil++;

    if(level.num_of_player_ready_to_infil == 4)
      level notify("_encstr_AC25157DFDCEB033F7C3909E5BB3E7D8236FF3CD66B4B8");
  }
}

max_wait_for_infil_to_start() {
  level endon("_encstr_AC25157DFDCEB033F7C3909E5BB3E7D8236FF3CD66B4B8");
  var_0 = 5;
  wait(var_0);
  level notify("_encstr_AC25157DFDCEB033F7C3909E5BB3E7D8236FF3CD66B4B8");
}

gamehasinfil() {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"]))
    return 0;

  return 1;
}

isinfilgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}