/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\infilexfil.gsc
***********************************************/

infil_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B"))
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B", ::get_all_infils);

  while(!isDefined(level.teamnamelist))
    waitframe();

  if(!isDefined(game["_encstr_9B8F06A38D72C380"])) {
    foreach(var_9 in level.teamnamelist)
    game["_encstr_9B8F06A38D72C380"][var_9] = [];

    game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"] = [];
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_11 = get_all_infils(var_0);

    foreach(var_13 in var_11) {
      if(var_13.name == var_1) {
        if(isDefined(var_13.script_label) && var_13.script_label == level.localeid) {
          break;
        }
      }
    }
  }

  if(isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0]) && isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1])) {
    if(isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"]))
      self[[game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"]]](var_0, var_1);

    return;
  }

  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1] = [];
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_88DB0B5803A1536541371DA84E"] = var_5;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_8F950C1C630BBCCA9CAF33BACD8D"] = var_7;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_8313107770350721394D190BA9C83E85303E"] = var_6;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_823006E62B0BA337"] = var_2;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_A77E0FE4B2C5D596939519F5CD2B2CE8CD"] = var_3;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_824E0B042B73F36988835CD308"] = var_4;
}

infil_is_interactive() {
  if(!isDefined(level.interactiveinfil))
    level.interactiveinfil = getdvarint("_encstr_87EB166FB8EBF73A6D84E4DD600B028451989FA798601622", 0) == 1;

  return level.interactiveinfil;
}

infil_init() {
  if(level.rankedmatch && !isdedicatedserver()) {
    game["_encstr_9B8F06A38D72C380"] = undefined;
    scripts\mp\flags::gameflagset("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
    return;
  }

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0 || getdvarint("_encstr_82BE108B3E9A1156425FE1B7B7FA14782C92", 0) == 1 || getdvarint("_encstr_A55013D38A731888F6C56B27F91D48DBD361281823", 0) == 1 || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || getdvarint("_encstr_85F6186F966321C7B788A810A5332B2B8053CC380BD9E150DDC5") < 15 || scripts\mp\utility\game::getgametype() == "_encstr_B41904BB8593" && scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    game["_encstr_9B8F06A38D72C380"] = undefined;
    level.requiredplayercount["_encstr_9A8507BA4040188D08"] = 0;
    level.requiredplayercount["_encstr_8E8405EA382B2A"] = 0;
    scripts\mp\flags::gameflagset("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
    return;
  }

  if(!isDefined(level.prematchperiodend) || level.prematchperiodend == 0) {
    game["_encstr_9B8F06A38D72C380"] = undefined;
    scripts\mp\flags::gameflagset("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
    return;
  }

  if(istrue(level._id_133D5)) {
    game["_encstr_9B8F06A38D72C380"] = undefined;
    scripts\mp\flags::gameflagset("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
    return;
  }

  while(!isDefined(level.teamnamelist))
    waitframe();

  if(scripts\mp\gamelogic::_id_1330A())
    logstring("_encstr_93E8384954F44E3A9342C74F4ABDB6B72CB6C93BC01F57A05960BAB390790DBBE19F7DBE7FAD1F759380B3CE18A9149359D7FE0137281F84A310");

  waitframe();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  level.prematchallowfunc = ::infil_player_allow;
  var_0 = undefined;
  level.stop_station_closed_vo = 0;

  foreach(var_2 in get_all_infils()) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_2.name;

    if(!var_2 infil_is_gamemode()) {
      continue;
    }
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(var_2.name == var_4) {
        if(!isDefined(var_2.script_label) || var_2.script_label != level.localeid)
          continue;
      }
    }

    if(var_2 infil_has_map_config())
      infil_init_spawn_selection();

    var_5 = var_2.script_team;

    if(var_2 infil_is_type(var_3) && var_2 infil_is_subtype(var_4) && scripts\mp\utility\teams::isgameplayteam(var_2.script_team)) {
      level.stop_station_closed_vo++;
      var_6 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_3][var_4];
      var_7 = var_4;
      var_8 = var_4;

      if(issubstr(var_8, "_encstr_BDBB0616C6C186C2"))
        var_8 = "_encstr_BDBB0616C6C186C2";

      if(issubstr(var_8, "_encstr_871D0613938567B7"))
        var_8 = "_encstr_871D0613938567B7";

      if(!isDefined(var_6))
        var_6 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_3][var_8];

      var_9 = var_2[[var_6["_encstr_88DB0B5803A1536541371DA84E"]]](var_2.script_team, var_2.target, var_8, var_7);
      var_9.players = [];
      var_9.type = var_3;
      var_9._id_1214C = var_7;
      var_9.subtype = var_8;
      var_9.infillength = var_9[[var_6["_encstr_8313107770350721394D190BA9C83E85303E"]]](var_8);

      if(!isDefined(var_0) || var_0 < var_9.infillength)
        var_0 = var_9.infillength + 1.0;

      var_5 = var_2.script_team;
      game["_encstr_9B8F06A38D72C380"][var_5]["_encstr_99EC06E297A25BEE"][var_3][var_4] = var_9;
      register_infil_spots(var_5, var_9, var_6["_encstr_823006E62B0BA337"], var_6["_encstr_A77E0FE4B2C5D596939519F5CD2B2CE8CD"], var_6["_encstr_824E0B042B73F36988835CD308"], var_6["_encstr_8F950C1C630BBCCA9CAF33BACD8D"]);

      if(var_2 infil_has_map_config())
        scripts\mp\tac_ops_map::adddynamicspawnarea("_encstr_924909DBE027CC2B4133EC", var_9, var_5, var_2.script_label);
    }
  }

  if(scripts\mp\utility\game::gamehasinfil() && isDefined(var_0)) {
    level thread onplayerspawned();
    level.prematchperiod = getdvarint("_encstr_96E9159EFE039FF179A720F96782C91F9AA21DA6D48AA1", 15);
    level.matchcountdowntime = var_0 + 2.0;
    level.prematchperiodend = var_0 + 2.0;
    thread scripts\mp\gamelogic::matchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", level.prematchperiod + level.prematchperiodend);
    level thread infil_setup_ui();
    level thread infil_wait_for_players();
    level thread _id_14367();
    scripts\mp\flags::gameflagset("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B");
  }

  scripts\mp\flags::gameflagset("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
}

onplayerspawned() {
  level endon("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    var_0 thread _id_1437E();
  }
}

_id_1437E() {
  level endon("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self.team)) {
    scripts\mp\flags::gameflagwait("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

    if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
      var_0 = (0, 0, 0);
      var_1 = 0;

      if(isDefined(game["_encstr_9B8F06A38D72C380"]) && isDefined(game["_encstr_9B8F06A38D72C380"][self.team]) && isDefined(game["_encstr_9B8F06A38D72C380"][self.team]["_encstr_99EC06E297A25BEE"])) {
        foreach(var_7, var_3 in game["_encstr_9B8F06A38D72C380"][self.team]["_encstr_99EC06E297A25BEE"]) {
          foreach(var_5 in var_3) {
            var_0 = var_0 + var_5.origin;
            var_1++;
          }
        }
      }

      if(var_1 > 0)
        var_0 = var_0 / var_1;

      self predictstreampos(var_0);
    }
  }

  while(!istrue(self.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]))
    waitframe();

  var_8 = get_spot_from_player(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  if(isDefined(var_8))
    player_free_spot(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  player_join_infil();
}

onjoinedteam(var_0) {
  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4")) {
    if(isDefined(var_0.team) && var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      var_0 thread infilspectatorview();
  }
}

infilspectatorview() {
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_ADC913C07596B8C1C9C3C3D7CB3215403AC348D95B");
  self endon("_encstr_ADC913C07596B8C1C9C3C3D7CB3215403AC348D95B");
  thread infil_scene_fade_in(0.0, 0.55);
}

onplayerdisconnect(var_0) {
  if(!isDefined(var_0.infil)) {
    return;
  }
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  player_free_spot(var_0, var_0.team);
}

onplayerchangeteams() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  var_0 = self.team;
  scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  player_free_spot(self, var_0);
}

get_all_infils(var_0) {
  if(isDefined(var_0))
    return scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  else
    return scripts\engine\utility::getStructArray("_encstr_8A6209D638F52D37334BC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

infil_is_type(var_0) {
  return self.script_noteworthy == var_0;
}

infil_is_subtype(var_0) {
  return self.name == var_0;
}

infil_is_gamemode() {
  if(!isDefined(self.spawnflags) || self.spawnflags == 0)
    return 0;

  if(!level.teambased)
    return 0;

  if(self.spawnflags & 1) {
    if(level.gametype == "_encstr_B807035284" && level.mapname == "_encstr_BA4D0DED61799A1FB5DB6AD2E30753" || level.gametype == "_encstr_B807035284" && level.mapname == "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3" || level.gametype == "_encstr_B60703EACA" && level.mapname == "_encstr_82670A6D9FF7A9AAD022B0CA")
      return 0;
    else
      return 1;
  }

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "_encstr_A7290676E4D2378C":
      case "_encstr_B41904BB8593":
      case "_encstr_8E65062BD0CFB4EC":
      case "_encstr_A20D05FBEB01F2":
      case "_encstr_959105B99040BD":
        return 1;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "_encstr_B60703EACA":
      case "_encstr_9B0703CD93":
      case "_encstr_B807035284":
        if(level.mapname == "_encstr_BA4D0DED61799A1FB5DB6AD2E30753" || level.mapname == "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3")
          return 0;
        else
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
      case "_encstr_9A7205B39CB919":
      case "_encstr_BDD705AD7BD143":
      case "_encstr_8E07030349":
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
      case "_encstr_B81904B04E6B":
        return 1;
    }
  }

  return 0;
}

infil_has_map_config() {
  return isDefined(self.script_label) && level.gametype == "_encstr_A53E0883E976B715503F";
}

infil_init_spawn_selection() {
  if(level.gametype == "_encstr_A53E0883E976B715503F" && !isDefined(game["_encstr_9B8F06A38D72C380"]["_encstr_A9A40BB971D3FEDFC5C218784A"])) {
    scripts\mp\tac_ops_map::init();
    scripts\mp\tac_ops_map::setactivemapconfig("_encstr_924909DBE027CC2B4133EC", "_encstr_9A8507BA4040188D08");
    scripts\mp\tac_ops_map::setactivemapconfig("_encstr_924909DBE027CC2B4133EC", "_encstr_8E8405EA382B2A");
    game["_encstr_9B8F06A38D72C380"]["_encstr_A9A40BB971D3FEDFC5C218784A"] = 1;
  }
}

infil_player_allow(var_0, var_1) {
  if(self ishost() && getdvarint("_encstr_9677144F98CBD71A4DA4C4BDAF5FC3B5B1487FDB6063") == 1) {
    scripts\common\utility::allow_weapon(var_0);
    return;
  }

  if(!scripts\mp\utility\game::teamhasinfil(self.team) && !istrue(var_1)) {
    scripts\mp\playerlogic::playerprematchallow(var_0);
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
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
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

  if(!istrue(level._id_12C49))
    level.requiredplayercount[var_0] = level.requiredplayercount[var_0] + var_3;
}

player_on_spot(var_0, var_1) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"])) {}

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1])) {}

  if(isDefined(game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"])) {}

  game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1]["_encstr_8BB007E03658CBCAE4"] = var_0;
  return game["_encstr_9B8F06A38D72C380"][var_0.team]["_encstr_B18A065E98576317"][var_1];
}

player_free_spot(var_0, var_1) {
  var_0 setclientomnvar("_encstr_A10F13083271492037C10DFE8F7F284FA4EA2860FA", 0);

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

get_spot_in_lane(var_0) {
  while(!isDefined(self.forcedavailablespawnlocation))
    waitframe();

  var_1 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_994C023A", "_encstr_8B4C024C") + getsubstr(self.forcedavailablespawnlocation, 5, 6);
  var_2 = [];

  foreach(var_5, var_4 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(issubstr(var_4["_encstr_9B8F06A38D72C380"].lane, var_1) && !is_spot_taken(var_0, var_5))
      var_2[var_2.size] = var_5;
  }

  if(var_2.size == 0)
    return undefined;

  var_6 = [];
  var_7 = -1;

  foreach(var_4 in var_2) {
    var_9 = game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_4]["_encstr_978C092BB8FBFDEB302D69"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6[var_6.size] = var_4;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7)
      var_6[var_6.size] = var_4;
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

get_random_spot_in_infil(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(var_5["_encstr_9B8F06A38D72C380"] != var_1) {
      continue;
    }
    if(!is_spot_taken(var_0, var_5))
      var_2[var_2.size] = var_5;
  }

  if(var_2.size == 0)
    return undefined;

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

infil_player_array_handler(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

player_join_infil() {
  if(scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4")) {
    return;
  }
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
    var_2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
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
  var_3["_encstr_9B8F06A38D72C380"] thread infil_player_array_handler(self);
  self notify("_encstr_AA2C160B1D69C0BD3367E3E1A36A75A914B596A005D688E1");
  self.infil = var_3["_encstr_9B8F06A38D72C380"];
  self thread[[var_3["_encstr_A7AA09C616D81B26586CB5"]]](var_3["_encstr_9B8F06A38D72C380"], var_3["_encstr_82180596773AC1"]);
  self setclientomnvar("_encstr_A10F13083271492037C10DFE8F7F284FA4EA2860FA", 1);
  thread onplayerchangeteams();
  thread headlessopindex();
  player_ai_fill();
}

headlessopindex() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  self setcinematicmotionoverride("_encstr_966114C11CA2DF8241981BD2E8ABBD8B60885E7FB9F3");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;

  while(!var_0) {
    var_0 = self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
    waitframe();
  }
}

blockswaploadouts() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.delayswaploadout = 1;
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self.delayswaploadout = 0;
}

player_ai_fill() {}

infil_setup_ui() {
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 3);
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_0 = getomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD");
  setomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD", 1);

  if(!isDefined(level.bypassclasschoicefunc)) {
    setomnvarforallclients("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 0);
    level.bypassclasschoicefunc = undefined;
  }

  level thread infil_show_countdown();
  var_1 = getdvarint("_encstr_9B550B98A728B4D494395151A6");
  var_2 = getdvarint("_encstr_97E60BFB592484E17DF6B2BD5F");
  var_3 = getdvarint("_encstr_92290B8D3A757F3039B7F3594F");
  setDvar("_encstr_9B550B98A728B4D494395151A6", 0);
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", 1);
  setDvar("_encstr_92290B8D3A757F3039B7F3594F", 1);
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_4 = scripts\mp\utility\player::alwaysshowminimap();

  foreach(var_6 in level.players) {
    if(var_4) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
        var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60"))
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60")]]();
  }

  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", -1);
  setomnvar("_encstr_8B4E1A57D2F516D8BB1697E6AF6E0DDBEEEB37B0B5591C1B2CA359CD", var_0);
  setDvar("_encstr_9B550B98A728B4D494395151A6", var_1);
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", var_2);
  setDvar("_encstr_92290B8D3A757F3039B7F3594F", var_3);
}

infil_show_countdown() {
  wait(level.prematchperiodend - 5);
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 2);
}

alwaysgamemodeclass() {
  var_0 = self getclantag();

  if(var_0 == "_encstr_AD07034839")
    var_1 = "_encstr_A5450947E0B60E5060CB6B";
  else if(var_0 == "_encstr_BE1904D49A1D")
    var_1 = "_encstr_8345096F85A579A798F922";
  else if(var_0 == "_encstr_9A190462A9A3")
    var_1 = "_encstr_8B45098A61FC578BB809DB";
  else {
    var_2 = [];
    var_2[0] = "_encstr_A5450947E0B60E5060CB6B";
    var_2[1] = "_encstr_8345096F85A579A798F922";
    var_2[2] = "_encstr_8B45098A61FC578BB809DB";
    var_1 = scripts\engine\utility::random(var_2);
  }

  self.pers["_encstr_959506B911C79707"] = var_1;
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  self.class = self.pers["_encstr_959506B911C79707"];
  self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
  return var_1;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig setModel(var_1);
  self.player_rig hide();
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2)
    self playersetgroundreferenceent(self.player_rig);

  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(isDefined(self)) {
    if(isDefined(var_2) && var_2)
      self playersetgroundreferenceent(undefined);

    self unlink();
  }

  if(isDefined(var_3))
    var_3 delete();
}

infil_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.players)
  var_4 playsoundtoplayer(var_0, var_4);
}

infil_wait_for_players() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level waittill("_encstr_924C1B4A90714E33663EF41956EB27D28B38E2E1182F83733BADE70760");
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 1);
  wait 2.0;
  scripts\mp\flags::gameflagset("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  if(getdvarint("_encstr_B82A1D06669B0798DE33E8F8EFE1B09932CAF7863B82ED41870FC8E8A70DA8", 0) == 1)
    level thread manageinteractiveslowmo();

  if(getdvarint("_encstr_AAA6164790C3CF0245ACFCB51821EBB128507FDF80193A1B", 0) == 1) {
    foreach(var_1 in level.players)
    iprintlnbold("_encstr_964D2053B8C7B0A3D8C11D71FB44107D2FCCD8F677FF993090375AC7FD11FD2125AE");
  }
}

infil_scene_fade_in(var_0, var_1) {
  if(scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4")) {
    return;
  }
  self notify("_encstr_BA4F14DCB0451AFC7E9B2F3FC01197B223DDA7D9ABED");
  self endon("_encstr_BA4F14DCB0451AFC7E9B2F3FC01197B223DDA7D9ABED");
  self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1.0);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_2 = gettime();
  var_3 = 1.0;

  while(var_3 > 0.0) {
    var_3 = var_3 - level.framedurationseconds;
    var_3 = max(var_3, 0.0);
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_3);
    waitframe();
  }
}

heli_path(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.hasstarted))
    return;
  else
    var_0.hasstarted = 1;

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("_encstr_BDB712B06B76D5BB4736F57B31EFE0B39A82A3F0");
  var_0 notify("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");
}

vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0))
    self.attachedpath = var_0;

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1)
    self waittill("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_parameters))
      readnodeevents(var_7);

    if(isDefined(var_7.script_linkto))
      set_lookat_from_dest(var_7);

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_7;
    var_7 notify("_encstr_8F5C086405E70FBA4B4A", self);

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "_encstr_BA2207BF09B8544A2E")
        self setmaxpitchroll(25, 50);
    }

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7.script_team))
      self.script_team = var_7.script_team;

    if(isDefined(var_7.script_unload)) {
      self notify("_encstr_81A8077D3088BFA631");
      scripts\engine\utility::waittill_notify_or_timeout("_encstr_BD82096B5DA4B07F924F29", self.unload_time);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype))
        self.veh_pathtype = var_7.script_pathtype;
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post))
        wait(var_7.script_delay_post);

      self notify("_encstr_8D910D32568D855EEB1C16E6E62B91");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");

  if(isDefined(self.script_vehicle_selfremove))
    self delete();
}

heli_wait_node(var_0, var_1, var_2) {
  self endon("_encstr_87DE08E656DDC158E81A");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("_encstr_9A93071D297064AAC5");

      if(isDefined(self.unload_land_offset))
        var_3 = self.unload_land_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset))
      var_3 = self.unload_hover_offset;
    else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max)
        var_3 = self.unload_hover_offset_max;
      else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height)
        var_3 = self.unload_hover_land_height;
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos))
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000)
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0.script_stopnode) && var_0.script_stopnode;
  var_11 = isDefined(var_0.script_unload);
  var_12 = isDefined(var_0.script_flag_wait) && !scripts\engine\utility::flag(var_0.script_flag_wait);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles))
    var_15 = var_0.angles[1];
  else
    var_15 = 0;

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2))
    var_16 = (var_16[0], var_16[1], var_16[2] + var_2);

  if(isDefined(self.heliheightoverride))
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);

  self vehicle_helisetai(var_16, var_7, var_8, var_9, var_0.script_goalyaw, var_0.script_anglevehicle, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  } else
    self waittill("_encstr_8B7205D9ED5958");

  if(isDefined(var_0.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](var_0);
  }

  var_0 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(var_0);

  self notify("_encstr_B4EC0D2F7FA8DBF1E023DF6259C808");
}

get_path_getfunc(var_0) {
  var_1 = ::get_from_vehicle_node;

  if(isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target)))
      var_1 = ::get_from_entity;

    if(isDefined(get_from_spawnStruct(var_0.target)))
      var_1 = ::get_from_spawnstruct;
  }

  return var_1;
}

get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

parsehelipathlength() {
  if(!isDefined(self.path))
    return 0.0;

  if(isDefined(self.pathduration))
    return self.pathduration;

  self.pathduration = 0.0;
  var_0 = self.path;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0.script_unload)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed))
      var_1 = var_0.speed;

    var_4 = 17.6;
    var_5 = 1.1;
    self.pathduration = self.pathduration + var_3 * var_5 / (var_1 * var_4);
    var_0 = var_2;
  }

  return self.pathduration;
}

readnodeevents(var_0) {
  var_1 = strtok(var_0.script_parameters, "_encstr_964C0249");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_encstr_8D4C02E8");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size != 2) {
      return;
    }
    thread processtimelineevent(var_4[0], float(var_4[1]));
  }
}

processtimelineevent(var_0, var_1) {
  if(!isDefined(self.timelineevents))
    self.timelineevents = [];

  if(var_1 > 0)
    wait(var_1);

  switch (var_0) {
    case "_encstr_A1940ACB83991FF717C06AE3":
      self.timelineevents["_encstr_914906CD340B5B2B"] = "_encstr_BE19041BDEDD";

      foreach(var_3 in self.infil.players)
      scripts\mp\utility\infilexfil::cam_shake_low(var_3);

      break;
    case "_encstr_87940AB943C2AD95BE7BCCCC":
      self.timelineevents["_encstr_914906CD340B5B2B"] = "_encstr_BA19049F4B2D";

      foreach(var_3 in self.infil.players)
      scripts\mp\utility\infilexfil::cam_shake_off(var_3);

      break;
    case "_encstr_AD150C59EC5673D1AF5ACD4793F6":
      self.infil notify("_encstr_AD150C59EC5673D1AF5ACD4793F6");
      break;
    case "_encstr_9B791AB7D43B128C1698ABAF60AB59DA87FC3CEDB547DB9F386897A3":
      self.infil notify("_encstr_9B791AB7D43B128C1698ABAF60AB59DA87FC3CEDB547DB9F386897A3");
      break;
    case "_encstr_A2551C974B25AB2BF9EB434FCF03B270CC5990F66A3FAF79313CC067525F":
      self.infil notify("_encstr_A2551C974B25AB2BF9EB434FCF03B270CC5990F66A3FAF79313CC067525F");
      break;
  }
}

manageinteractiveslowmo() {
  if(!isDefined(level.interactiveinfilstart) || !isDefined(level.interactiveinfilwindow)) {
    return;
  }
  wait(level.interactiveinfilstart);
  setslowmotion(1, 0.5, 1);
  wait(level.interactiveinfilwindow);
  setslowmotion(0.5, 1, 0.5);
}

_id_14367() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(level.stop_station_closed_vo != 0)
    waitframe();

  setspeedthreshold();
}