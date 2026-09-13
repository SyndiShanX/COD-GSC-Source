/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\havoc.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  level._id_46E88D936DB0725C = [];
  level._id_374E02799AE6CE92 = getdvarint("dvar_229F46B375F83420", 75);
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_704789086C9AD943(scripts\mp\utility\game::getgametype(), 1);
  }

  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), level._id_374E02799AE6CE92);
  updategametypedvars();
  _id_C153B3BE3A868971();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onsuicidedeath = ::onsuicidedeath;
  level.onteamchangedeath = ::onsuicidedeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level._id_16AA7CE5EFACBCCB = 1;

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;
}

_id_C153B3BE3A868971() {
  game["dialog"]["gametype"] = "iw9_havc_mode_uktl_name";
  game["dialog"]["mod_incoming"] = "havoc_mod_incoming";
  game["dialog"]["mod_activated"] = "havoc_mod_activated";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/HAVOC");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/HAVOC");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/HAVOC_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/HAVOC_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  level.disablepersonalnuke = 1;
  level._id_C423C2360CA0DAC5 = 1;
  _id_B7752DE07EA1870C();
  _id_8C14093FB58B4E65();
  _id_C2A7EA1687DFD306();
  _id_905B2F805251E716();
  _id_EEE04FF98CCC9115();
  level thread _id_4A3F65052DC511B2();
  level thread _id_3C5CBE539052EA87();
}

_id_B7752DE07EA1870C() {
  level._id_0275F722DE69E61A = [];
  _id_722A88B02B9C6A83("game", "loadoutperksoff", 1);
  _id_722A88B02B9C6A83("game", "perkpackage", 0);
  _id_722A88B02B9C6A83("game", "showperksonspawn", 0);
  _id_722A88B02B9C6A83("game", "minfalldamageheight", 225, 1);
  _id_722A88B02B9C6A83("game", "herodrop", 0, 1);
  _id_722A88B02B9C6A83("game", "one_tap_headshot", 0, 1);
  _id_722A88B02B9C6A83("game", "lowgravity", 0, 1);
  _id_722A88B02B9C6A83("game", "lowgravitystrength", 125, 1);
  _id_722A88B02B9C6A83("team", "fftype", 0, 1);
  _id_722A88B02B9C6A83("team", "teamkillspawndelay", 0, 1);
}

_id_8C14093FB58B4E65() {
  level._id_02F3A1A97F388712 = [];
  level._id_3E4609E79EC16D7A = [];
  level._id_5C710278DD543E5C = [];
  level._id_31504A1B9E6CBDEF = 0;
  level._id_DD052853F1CD3164 = [];
  level._id_DC4DA78DB330C5B5 = getdvarint("dvar_2F01A491B1940657", 5);
  level._id_CFB17092BBC28B8B = int(level._id_374E02799AE6CE92 - level._id_374E02799AE6CE92 / level._id_DC4DA78DB330C5B5);
  level._id_E757FCF09FBB5EC0 = getdvarint("dvar_C8F0AB916692BFBB", int(level._id_CFB17092BBC28B8B / level._id_DC4DA78DB330C5B5));
  _id_BA0BC366802F8C30 = level._id_E757FCF09FBB5EC0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01CC9618AAE9BBC8(); _id_AC0E594AC96AA3A8++) {
    level._id_DD052853F1CD3164[level._id_DD052853F1CD3164.size] = _id_BA0BC366802F8C30;
    _id_BA0BC366802F8C30 = _id_BA0BC366802F8C30 + level._id_E757FCF09FBB5EC0;
  }

  setomnvar("ui_havoc_show_mod", -1);
  setomnvar("ui_havoc_threshold_progress", 0);
  setomnvar("ui_havoc_score_threshold", level._id_31504A1B9E6CBDEF);
  setomnvar("ui_havoc_mod_status_1", -1);
  setomnvar("ui_havoc_mod_status_2", -1);
  setomnvar("ui_havoc_mod_status_3", -1);
  setomnvar("ui_havoc_mod_status_4", -1);
  setomnvar("ui_havoc_mod_status_5", -1);
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/havoc_mods.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    _id_DED220FE49414105 = tablelookupbyrow("mp/havoc_mods.csv", index, 0);

    if(_id_DED220FE49414105 == "") {
      continue;
    }
    _id_D9BEFB3C1C446153 = tablelookupbyrow("mp/havoc_mods.csv", index, 1);
    _id_24574657DF24DA70 = tablelookupbyrow("mp/havoc_mods.csv", index, 2);
    _id_86C1A6BC32729067 = tablelookupbyrow("mp/havoc_mods.csv", index, 5);
    _id_6F6FD32D3DD289E0 = tablelookupbyrow("mp/havoc_mods.csv", index, 6);
    _id_3804A6D6DBF6FDDB = tablelookupbyrow("mp/havoc_mods.csv", index, 7);
    _id_D7D6624794CCBDED(_id_DED220FE49414105, _id_D9BEFB3C1C446153, _id_24574657DF24DA70, _id_86C1A6BC32729067, _id_6F6FD32D3DD289E0, _id_3804A6D6DBF6FDDB);
  }
}

_id_C2A7EA1687DFD306() {
  level._id_719290BA2CA20FDC = ["specialty_fastreload", "specialty_third_person", "specialty_commando"];
}

_id_905B2F805251E716() {
  level.ladderindex = scripts\mp\utility\dvars::dvarintvalue("ladderIndex", 1, 1, 6);
  _id_6A9843AC9E1D10C2::_id_6B7AFEFDBEEEEC0A();
  level._id_3DE0640C640E8EE0 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    _id_C69DA2D2FFF3AAC5 = _id_6149C1C60FCE42B3();
    _id_8C7CBD4FA9A20866 = _id_C69DA2D2FFF3AAC5[randomint(_id_C69DA2D2FFF3AAC5.size)];
    _id_BAE77D8848F4D84D = _id_6A9843AC9E1D10C2::_id_05F97F15E9CA6CB6(_id_8C7CBD4FA9A20866);
    weaponobj = _id_6A9843AC9E1D10C2::_id_96D23570114BC7B6(_id_BAE77D8848F4D84D);

    if(isnullweapon(weaponobj)) {
      continue;
    }
    level._id_3DE0640C640E8EE0[level._id_3DE0640C640E8EE0.size] = weaponobj;
  }
}

_id_6149C1C60FCE42B3() {
  _id_EF5F8952FE9BE185 = [];

  foreach(_id_F8F00BED55A25EBA, category in level.weaponcategories) {
    if(category.size > 0 && _id_F8F00BED55A25EBA != "rand_knife_end")
      _id_EF5F8952FE9BE185[_id_EF5F8952FE9BE185.size] = _id_F8F00BED55A25EBA;
  }

  return _id_EF5F8952FE9BE185;
}

_id_EEE04FF98CCC9115() {
  _id_5BDA1250FEA48E36("havoc_ammo_feeder", ::_id_66ECF48CD956AC04);
  _id_5BDA1250FEA48E36("havoc_cranked", ::_id_A0E75971D087C74C);
  _id_5BDA1250FEA48E36("havoc_equip_mayhem", ::_id_B90124CF1CEA34AB);
  _id_5BDA1250FEA48E36("havoc_kill_snap", ::_id_9C2E0F5F612D29B6);
  _id_5BDA1250FEA48E36("havoc_lucky_killstreak", ::_id_F28A76FAFBA3E83C);
  _id_5BDA1250FEA48E36("havoc_semtex_surprise", ::_id_14816C4A16BF3C7D);
  _id_5BDA1250FEA48E36("havoc_hero_drop", ::_id_3317CCE4D3B5F4D3);
  _id_5BDA1250FEA48E36("havoc_eyes_on", ::_id_98619BDDCCD9A695);
  _id_5BDA1250FEA48E36("havoc_headshot_only", ::_id_75934EAE9944EFEA);
  _id_5BDA1250FEA48E36("havoc_low_gravity", ::_id_A8D2D573000C15F2);
  _id_5BDA1250FEA48E36("havoc_third_person", ::_id_3D1B533130FA8E4A);
  _id_5BDA1250FEA48E36("havoc_gun_cycle", ::_id_530BE69F39D0F7D2);
  _id_5BDA1250FEA48E36("havoc_flame_on", ::_id_6DC42C579EE9815C);
  _id_5BDA1250FEA48E36("havoc_system_reroll", ::_id_8CDAB0C0CF731E79);

  foreach(_id_13751CE30E58B249, _id_D9BEFB3C1C446153 in level._id_02F3A1A97F388712) {
    foreach(_id_87E48F43A5B5F24C, _id_B39BBB3A0E35C61E in _id_D9BEFB3C1C446153) {
      if(isDefined(_id_B39BBB3A0E35C61E.func)) {
        continue;
      }
      level._id_02F3A1A97F388712[_id_13751CE30E58B249][_id_87E48F43A5B5F24C] = undefined;
    }
  }
}

_id_5BDA1250FEA48E36(ref, triggerfunc) {
  if(_id_2D4DCF9441A36EA0(ref)) {
    return;
  }
  category = _id_84CA23F2EF144201(ref);

  if(!isDefined(category))
    _id_D7D6624794CCBDED(level._id_02F3A1A97F388712[category][ref].size, "player", ref, 0, "none");

  level._id_02F3A1A97F388712[category][ref].func = triggerfunc;
}

_id_2D4DCF9441A36EA0(_id_24574657DF24DA70) {
  _id_71AFEBAC8FB1E1C2 = getDvar("dvar_D3324E2ADAFBCFA9", "");

  if(_id_71AFEBAC8FB1E1C2 != "") {
    _id_0E04329AC881D885 = strtok(_id_71AFEBAC8FB1E1C2, ",");

    foreach(mod in _id_0E04329AC881D885) {
      if(issubstr(_id_24574657DF24DA70, mod))
        return 1;
    }
  }

  return 0;
}

_id_BFF609C8046EDA89(category, ref, _id_F1E7600AE8F8A94B) {
  if(!(isDefined(category) && isDefined(ref))) {
    return;
  }
  _id_813E589C3A58684C(_id_F1E7600AE8F8A94B);

  if(category == "weapon" || category == "end")
    level._id_02F3A1A97F388712[category] = [];
  else
    level._id_02F3A1A97F388712[category] = scripts\engine\utility::array_remove_index(level._id_02F3A1A97F388712[category], ref, 1);
}

_id_33DE3BB74C6F9F68(_id_F1E7600AE8F8A94B) {
  if(!istrue(_id_F1E7600AE8F8A94B._id_CB661D99CCDA33BF)) {
    return;
  }
  level._id_3E4609E79EC16D7A[level._id_3E4609E79EC16D7A.size] = _id_F1E7600AE8F8A94B;
}

_id_813E589C3A58684C(_id_F1E7600AE8F8A94B) {
  if(level._id_31504A1B9E6CBDEF > 0)
    setomnvar("ui_havoc_mod_status_" + level._id_31504A1B9E6CBDEF, _id_F1E7600AE8F8A94B.id);

  level._id_5C710278DD543E5C[level._id_5C710278DD543E5C.size] = _id_F1E7600AE8F8A94B;
}

_id_4A3F65052DC511B2() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;
  _id_8B460428CB7E01AC(0, 0, 1);
  _id_A25E53A4D71828EA = 0;
  _id_19429F26834E5ED7 = 0;

  for(;;) {
    [_id_01FF67BA127220E2, _id_C7761B0132ABCFA7] = scripts\mp\gamescore::gethighestscore();

    if(_id_C7761B0132ABCFA7 > _id_A25E53A4D71828EA) {
      _id_4FCA91C462F41CE6 = _id_C7761B0132ABCFA7 - _id_A25E53A4D71828EA;
      _id_19429F26834E5ED7 = _id_19429F26834E5ED7 + _id_4FCA91C462F41CE6;
      _id_A25E53A4D71828EA = _id_C7761B0132ABCFA7;
    }

    _id_EF573163DE7E46AF = _id_19429F26834E5ED7 / _id_9D7788358C73DB40();
    setomnvar("ui_havoc_threshold_progress", _id_EF573163DE7E46AF);
    _id_C6F714345D79ACF7 = _id_9D7788358C73DB40();

    if(_id_19429F26834E5ED7 >= _id_C6F714345D79ACF7) {
      _id_4FCA91C462F41CE6 = _id_19429F26834E5ED7 - _id_C6F714345D79ACF7;
      _id_19429F26834E5ED7 = _id_4FCA91C462F41CE6;
      _id_8B460428CB7E01AC(0, 1, 0);

      if(_id_3D4F5744F1D73929() >= _id_01CC9618AAE9BBC8()) {
        break;
      }
    }

    waitframe();
  }
}

_id_01CC9618AAE9BBC8() {
  return level._id_DC4DA78DB330C5B5;
}

_id_9D7788358C73DB40() {
  return level._id_E757FCF09FBB5EC0;
}

_id_75C691AE431D4DD1() {
  return level._id_DD052853F1CD3164[level._id_31504A1B9E6CBDEF];
}

_id_1E7D37861AAA2BB8() {
  return level._id_CFB17092BBC28B8B;
}

_id_3D4F5744F1D73929() {
  return level._id_31504A1B9E6CBDEF;
}

_id_B39B72EB28EAE363(_id_DDA8ACD20A27AFEF) {
  level._id_31504A1B9E6CBDEF++;

  if(istrue(_id_DDA8ACD20A27AFEF))
    level._id_31504A1B9E6CBDEF = 0;

  setomnvar("ui_havoc_score_threshold", level._id_31504A1B9E6CBDEF);
}

_id_E7425D53CBE0C754(_id_5B1BC86C3C8C20B9) {
  _id_CD4331DD65CBCDE1 = level._id_DD052853F1CD3164[level._id_31504A1B9E6CBDEF];
  return _id_5B1BC86C3C8C20B9 >= _id_CD4331DD65CBCDE1;
}

_id_8B460428CB7E01AC(_id_BEFA49910D2A94D6, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6) {
  _id_B39B72EB28EAE363();
  _id_DBD7CDAB4CE361A3(_id_BEFA49910D2A94D6, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6);
}

_id_DBD7CDAB4CE361A3(_id_BEFA49910D2A94D6, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6) {
  _id_D9BEFB3C1C446153 = _id_18FFA8C868BF9576();

  if(isDefined(_id_D9BEFB3C1C446153)) {
    _id_DB61A9C69AB388A7 = level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153];
    _id_24574657DF24DA70 = undefined;

    if(isDefined(_id_DB61A9C69AB388A7))
      _id_24574657DF24DA70 = _id_3C00ACCA6C837A62(_id_D9BEFB3C1C446153);
    else {}

    level thread _id_A0F58F6A04807697(_id_D9BEFB3C1C446153, _id_24574657DF24DA70, _id_BEFA49910D2A94D6, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6);
  } else {}
}

_id_A0F58F6A04807697(_id_D9BEFB3C1C446153, _id_24574657DF24DA70, _id_BEFA49910D2A94D6, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6) {
  level endon("game_ended");

  if(!(isDefined(_id_D9BEFB3C1C446153) && isDefined(_id_24574657DF24DA70))) {
    return;
  }
  _id_89209396F51E191A = _id_08318B76D2EEDF2F(_id_D9BEFB3C1C446153, _id_24574657DF24DA70);

  if(isDefined(_id_89209396F51E191A)) {
    _id_3A927C89EED3A0B2 = _id_47630CCD4C2F3FC6(_id_24574657DF24DA70);
    _id_BFF609C8046EDA89(_id_D9BEFB3C1C446153, _id_24574657DF24DA70, _id_89209396F51E191A);
    _id_33DE3BB74C6F9F68(_id_89209396F51E191A);
    _id_E3F97D38936F8E5B = spawn("script_origin", (0, 0, 0));
    _id_E3F97D38936F8E5B hide();

    if(!istrue(_id_BEFA49910D2A94D6)) {
      timer = 3;

      if(istrue(_id_58B112A46ED059BA))
        _id_059A66532CE69BA0("mod_incoming");

      setomnvar("ui_havoc_countdown_time", gettime() + timer * 1000);
      _id_FFB74C1047266E6F = 0;
      _id_A8DF161F525C4CCE = 0;
      _id_E3F97D38936F8E5B playSound("ui_mp_havoc_timer");

      while(_id_A8DF161F525C4CCE < timer) {
        _id_FFB74C1047266E6F = _id_FFB74C1047266E6F + level.framedurationseconds;
        _id_A8DF161F525C4CCE = _id_A8DF161F525C4CCE + level.framedurationseconds;
        progress = clamp(1.0 - _id_A8DF161F525C4CCE / timer, 0.0, 1.0);
        setomnvar("ui_havoc_countdown_progress", progress);

        if(_id_FFB74C1047266E6F >= 1) {
          _id_FFB74C1047266E6F = 0;
          _id_E3F97D38936F8E5B playSound("ui_mp_havoc_timer");
        }

        waitframe();
      }
    }

    if(isDefined(_id_E3F97D38936F8E5B))
      _id_E3F97D38936F8E5B delete();

    setomnvar("ui_havoc_show_mod", _id_3A927C89EED3A0B2);
    scripts\mp\hud_util::showsplashtoall(_id_24574657DF24DA70);

    if(istrue(_id_A45AEDB0CB5A5FF6))
      _id_059A66532CE69BA0("mod_activated");

    switch (_id_D9BEFB3C1C446153) {
      case "kill":
        _id_EDCEBBA57EF459B7(_id_89209396F51E191A.func);
        break;
      case "weapon":
        if(_id_24574657DF24DA70 == "havoc_gun_cycle") {
          _id_EDCEBBA57EF459B7(_id_89209396F51E191A.func);
          break;
        }
      case "world":
      case "player":
      case "end":
        level[[_id_89209396F51E191A.func]]();
        break;
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player setclientomnvar("ui_match_start_countdown", 0);
    }
  } else {}
}

_id_EDCEBBA57EF459B7(_id_847D2A046CAA4B54) {
  level._id_46E88D936DB0725C[level._id_46E88D936DB0725C.size] = _id_847D2A046CAA4B54;
}

_id_66ECF48CD956AC04(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }
  if(istrue(iskillstreakweapon)) {
    return;
  }
  if(!scripts\mp\utility\weapon::isprimaryweapon(objweapon)) {
    return;
  }
  _id_D0BAE9FA43B9E424 = attacker getweaponammoclip(objweapon);
  _id_2B9ACC695ED83F64 = attacker getweaponammostock(objweapon);
  _id_E21A1FE75EA20307 = weaponclipsize(objweapon);
  _id_09FDB767D664B093 = int(_id_E21A1FE75EA20307 - _id_D0BAE9FA43B9E424);
  _id_482A583CFA393392 = int(min(_id_2B9ACC695ED83F64, _id_09FDB767D664B093));

  if(_id_482A583CFA393392 > 0) {
    attacker setweaponammoclip(objweapon, _id_E21A1FE75EA20307);
    attacker setweaponammostock(objweapon, _id_2B9ACC695ED83F64 - _id_482A583CFA393392);
    attacker _id_5762AC2F22202BA2::hudicontype("ammofeeder");
    attacker playlocalsound("iw9_support_box_use");
  }
}

_id_BCFDC9507307CE2D(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(victim))
    return;
}

_id_68E97386DAD8427D(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {}

_id_A0E75971D087C74C(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }
  if(isDefined(attacker.cranked) && attacker.cranked)
    attacker scripts\mp\cranked::setcrankedplayerbombtimer("kill");
  else
    attacker scripts\mp\cranked::oncranked(undefined, attacker);

  attacker thread _id_3456261D6A6256A6();
}

_id_3456261D6A6256A6() {
  self endon("disconnect");
  self notify("havoc_cranked_remove");
  self endon("havoc_cranked_remove");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "last_stand_start");
  scripts\mp\cranked::cleanupcrankedplayertimer();
}

_id_B90124CF1CEA34AB(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(attacker)) {
    return;
  }
  _id_F5C0017750F207A3 = attacker _id_7EF95BBA57DC4B82::getcurrentequipment("primary");
  _id_702915CBE6AD0CE3 = attacker _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
  attacker scripts\mp\equipment::giveequipment(_id_F5C0017750F207A3, "primary");
  attacker scripts\mp\equipment::giveequipment(_id_702915CBE6AD0CE3, "secondary");
}

_id_9C2E0F5F612D29B6(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(victim) || !isDefined(attacker)) {
    return;
  }
  attacker thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_watch_flight(victim.origin);
}

_id_F28A76FAFBA3E83C(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(attacker._id_C115C6E4D9EEE7CA))
    attacker._id_C115C6E4D9EEE7CA = 1;
  else
    attacker._id_C115C6E4D9EEE7CA++;

  if(attacker._id_C115C6E4D9EEE7CA < 3) {
    return;
  }
  _id_D73E6320986149FA = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73(), 1, 0);

  if(isDefined(attacker._id_1275922708964790))
    attacker scripts\mp\killstreaks\killstreaks::removekillstreak(_id_D73E6320986149FA);

  _id_EDC5F3CCA53740B3 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
  attacker scripts\mp\killstreaks\killstreaks::awardkillstreak(_id_EDC5F3CCA53740B3, "other", undefined, undefined, undefined, _id_D73E6320986149FA);
  attacker scripts\mp\hud_message::showkillstreaksplash(_id_EDC5F3CCA53740B3, 4);
  attacker._id_C115C6E4D9EEE7CA = undefined;
  attacker._id_1275922708964790 = _id_EDC5F3CCA53740B3;
  attacker thread _id_81D2AA21BD0D79E1();
}

_id_81D2AA21BD0D79E1() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("lucky_killstreak_watch");
  self endon("lucky_killstreak_watch");
  self waittill("streak_activated");
  self._id_1275922708964790 = undefined;
}

_id_14816C4A16BF3C7D(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!isDefined(victim) && !isDefined(attacker)) {
    return;
  }
  victim thread _id_494C5C17D43E7E5B(attacker);
}

_id_494C5C17D43E7E5B(attacker) {
  self endon("disconnected");
  level endon("game_ended");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_F3E5EC9ECAAF8E1B = self gettagorigin("j_mainroot");
    _id_A0A41BA05E16FFE6 = randomint(300);
    _id_9E5D403038E4C071 = randomint(360);
    x = _id_F3E5EC9ECAAF8E1B[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
    y = _id_F3E5EC9ECAAF8E1B[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
    z = _id_F3E5EC9ECAAF8E1B[2];
    _id_503B97808F1CB382 = (x, y, z);
    _id_7331D469160F6A41 = _id_503B97808F1CB382 - _id_F3E5EC9ECAAF8E1B;
    attacker scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("weapons", "_launchGrenade", "semtex_mp", _id_F3E5EC9ECAAF8E1B, _id_7331D469160F6A41, randomfloatrange(2, 2.25));
    wait 0.05;
  }
}

_id_530BE69F39D0F7D2(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!scripts\cp_mp\utility\weapon_utility::isbulletweapon(objweapon) && !scripts\cp_mp\utility\weapon_utility::_id_102D677621400199(objweapon)) {
    return;
  }
  _id_B8215055A946EEBB = attacker _id_26FEC210A06242EE();
  attacker scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_B8215055A946EEBB, undefined, undefined, 1);
  _id_62377657B0592C22 = attacker getcurrentweapon();

  if(!isnullweapon(_id_62377657B0592C22))
    attacker scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_62377657B0592C22);

  attacker thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_B8215055A946EEBB);
}

_id_26FEC210A06242EE() {
  _id_D89A1A1C041A3AFE = [];

  foreach(weapon in level._id_3DE0640C640E8EE0) {
    if(weapon.basename == "none") {
      continue;
    }
    if(self getcurrentweapon() == weapon) {
      continue;
    }
    _id_D89A1A1C041A3AFE[_id_D89A1A1C041A3AFE.size] = weapon;
  }

  return _id_D89A1A1C041A3AFE[randomint(_id_D89A1A1C041A3AFE.size)];
}

_id_6DC42C579EE9815C(_id_32D402D0CF52B9E4) {
  if(isDefined(_id_32D402D0CF52B9E4))
    _id_32D402D0CF52B9E4 _id_2B7A7DDD1506153C();
  else {
    foreach(player in level.players) {
      if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      player _id_2B7A7DDD1506153C();
    }
  }
}

_id_2B7A7DDD1506153C() {
  _id_849C1DF4114E0A37 = self getweaponslistprimaries();

  foreach(weapon in _id_849C1DF4114E0A37) {
    if(isDefined(weapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
  }

  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  thread _id_F97E80320A07C84C();
}

_id_F97E80320A07C84C(weaponobj) {
  self endon("death_or_disconnect");
  weaponobj = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_crossbow", ["ammo_bolt_mol"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj);
  thread _id_6753E15B1AA1FD7A(weaponobj);
  thread _id_BED1816B8632A262(weaponobj);
}

_id_6753E15B1AA1FD7A(_id_9B990C49CD9CFDB1) {
  self endon("death_or_disconnect");
  stockammo = self getweaponammostock(_id_9B990C49CD9CFDB1);

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(isDefined(objweapon) && objweapon != _id_9B990C49CD9CFDB1) {
      continue;
    }
    self setweaponammostock(_id_9B990C49CD9CFDB1, stockammo);
  }
}

_id_0A08D6C53A446D62(_id_32D402D0CF52B9E4) {
  if(isDefined(_id_32D402D0CF52B9E4)) {
    return;
  }
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\perk::giveperk("specialty_commando");
  }

  return;
}

_id_D7C7AB3572DEB50A(_id_32D402D0CF52B9E4) {
  if(isDefined(_id_32D402D0CF52B9E4))
    _id_32D402D0CF52B9E4 _id_666F6C8F489CA946();
  else {
    level.blastshieldclamp = scripts\mp\utility\dvars::getfloatproperty("perk_blastshieldclamphp", 0.8) * 30;
    level.maxallowedteamkills = -1;
    _id_722A88B02B9C6A83("team", "fftype", 1);
    _id_722A88B02B9C6A83("team", "teamkillspawndelay", 0);

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player _id_666F6C8F489CA946();
    }
  }
}

_id_666F6C8F489CA946() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    currenthealth = self.health;

    if(self.health > 30)
      self.health = 30;

    self.maxhealth = 30;
  }
}

_id_3317CCE4D3B5F4D3(_id_32D402D0CF52B9E4) {
  if(isDefined(_id_32D402D0CF52B9E4))
    _id_32D402D0CF52B9E4 thread _id_997EAA1FABFC52CD();
  else {
    _id_722A88B02B9C6A83("game", "minfalldamageheight", 50);
    _id_722A88B02B9C6A83("game", "herodrop", 1);

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player thread _id_997EAA1FABFC52CD();
    }
  }
}

_id_997EAA1FABFC52CD() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("perform_hero_drop");
    self radiusdamage(self.origin, 256, 100, 100, self, "MOD_CRUSH", "high_jump_mp");
    thread _id_798EBFFF41139CA1();
  }
}

_id_798EBFFF41139CA1() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  scripts\engine\utility::waittill_any_timeout_1(1, "death");
  self setscriptablepartstate("heroDiveVfx", "off", 0);
}

_id_A1274DA8BA78FF0F() {}

_id_98619BDDCCD9A695() {
  scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526("allies", level.uavdirectionalid);
  level.activeadvanceduavs["allies"]++;
  scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526("axis", level.uavdirectionalid);
  level.activeadvanceduavs["axis"]++;
}

_id_75934EAE9944EFEA() {
  _id_722A88B02B9C6A83("game", "one_tap_headshot", 1);
}

_id_A8D2D573000C15F2() {
  _id_722A88B02B9C6A83("game", "lowgravity", 1);
  _id_722A88B02B9C6A83("game", "lowgravitystrength", 300);
}

_id_8821A9B9A89A609D() {}

_id_3D1B533130FA8E4A(_id_32D402D0CF52B9E4) {
  if(isDefined(_id_32D402D0CF52B9E4))
    _id_32D402D0CF52B9E4 scripts\mp\utility\perk::giveperk("specialty_third_person");
  else {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player scripts\mp\utility\perk::giveperk("specialty_third_person");
    }
  }
}

_id_8CDAB0C0CF731E79() {
  _id_03660568F097FA7E(1);
  level thread _id_855274D0EFFBF75F();
}

_id_855274D0EFFBF75F() {
  level endon("game_ended");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    wait 4;
    _id_8B460428CB7E01AC(1, 0, 0);
  }
}

_id_D7D6624794CCBDED(_id_DED220FE49414105, _id_D9BEFB3C1C446153, _id_24574657DF24DA70, _id_86C1A6BC32729067, _id_6F6FD32D3DD289E0, _id_3804A6D6DBF6FDDB) {
  _id_96FF4659F479920B = spawnStruct();
  _id_96FF4659F479920B.id = int(_id_DED220FE49414105);
  _id_96FF4659F479920B.category = _id_D9BEFB3C1C446153;
  _id_96FF4659F479920B.ref = _id_24574657DF24DA70;
  _id_96FF4659F479920B._id_CB661D99CCDA33BF = scripts\engine\utility::ter_op(isstring(_id_86C1A6BC32729067), scripts\engine\utility::string_to_bool(_id_86C1A6BC32729067), _id_86C1A6BC32729067);
  _id_96FF4659F479920B.threshold = _id_1F1AFE7A22FE62F9(_id_D9BEFB3C1C446153, _id_24574657DF24DA70);
  _id_96FF4659F479920B._id_1C85B88373BA6A3E = _id_6F6FD32D3DD289E0;
  _id_96FF4659F479920B._id_9B8B3826BD61044F = _id_3804A6D6DBF6FDDB;
  _id_96FF4659F479920B._id_887D42B1410C39FE = 0;
  level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153][_id_24574657DF24DA70] = _id_96FF4659F479920B;
}

_id_1F1AFE7A22FE62F9(_id_D9BEFB3C1C446153, _id_24574657DF24DA70) {
  _id_BF4187D4E43EB09A = 0;

  if(_id_24574657DF24DA70 == "havoc_third_person")
    return 4;

  switch (_id_D9BEFB3C1C446153) {
    case "world":
    case "kill":
    case "player":
      _id_BF4187D4E43EB09A = 0;
      break;
    case "weapon":
      _id_BF4187D4E43EB09A = 4;
      break;
    case "end":
      _id_BF4187D4E43EB09A = 5;
      break;
  }

  return _id_BF4187D4E43EB09A;
}

_id_84CA23F2EF144201(_id_35A900E065EA5A7F) {
  _id_FABFBD36AE78F479 = undefined;
  _id_2078F053E1A92113 = level._id_02F3A1A97F388712;

  foreach(_id_3EFE02D070802093, category in _id_2078F053E1A92113) {
    _id_10C9B63FBE0B7499 = _id_2078F053E1A92113[_id_3EFE02D070802093];

    foreach(_id_DED220FE49414105, ref in _id_10C9B63FBE0B7499) {
      if(_id_35A900E065EA5A7F == _id_DED220FE49414105) {
        _id_FABFBD36AE78F479 = _id_3EFE02D070802093;
        break;
      }
    }

    if(isDefined(_id_FABFBD36AE78F479)) {
      break;
    }
  }

  return _id_FABFBD36AE78F479;
}

_id_47630CCD4C2F3FC6(_id_35A900E065EA5A7F) {
  _id_D9BEFB3C1C446153 = _id_84CA23F2EF144201(_id_35A900E065EA5A7F);

  if(!isDefined(_id_D9BEFB3C1C446153)) {
    return;
  }
  return level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153][_id_35A900E065EA5A7F].id;
}

_id_08318B76D2EEDF2F(_id_D9BEFB3C1C446153, _id_24574657DF24DA70) {
  if(!isDefined(_id_D9BEFB3C1C446153) || !isDefined(_id_24574657DF24DA70)) {
    return;
  }
  return level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153][_id_24574657DF24DA70];
}

_id_18FFA8C868BF9576() {
  _id_2078F053E1A92113 = level._id_02F3A1A97F388712;
  _id_CE9F595467D50327 = [];

  foreach(_id_13751CE30E58B249, category in _id_2078F053E1A92113) {
    if(category.size > 0) {
      if(_id_88D9DA83AA05B571(_id_13751CE30E58B249))
        _id_CE9F595467D50327[_id_CE9F595467D50327.size] = _id_13751CE30E58B249;
    }
  }

  _id_8C7CBD4FA9A20866 = undefined;

  if(_id_CE9F595467D50327.size > 0)
    _id_8C7CBD4FA9A20866 = _id_CE9F595467D50327[randomint(_id_CE9F595467D50327.size)];

  return _id_8C7CBD4FA9A20866;
}

_id_88D9DA83AA05B571(_id_D9BEFB3C1C446153) {
  _id_DB61A9C69AB388A7 = level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153];
  _id_A6F1763860AC8EE8 = [];

  foreach(_id_87E48F43A5B5F24C, ref in _id_DB61A9C69AB388A7) {
    _id_11AD757F6E375867 = _id_08318B76D2EEDF2F(_id_D9BEFB3C1C446153, _id_87E48F43A5B5F24C);

    if(_id_A5FA76C74C473333(_id_11AD757F6E375867)) {
      _id_A6F1763860AC8EE8[_id_A6F1763860AC8EE8.size] = _id_11AD757F6E375867;

      if(istrue(_id_11AD757F6E375867._id_887D42B1410C39FE))
        _id_11AD757F6E375867._id_887D42B1410C39FE = 0;

      continue;
    }

    _id_11AD757F6E375867._id_887D42B1410C39FE = 1;
  }

  return _id_A6F1763860AC8EE8.size > 0;
}

_id_3C00ACCA6C837A62(_id_D9BEFB3C1C446153) {
  _id_DB61A9C69AB388A7 = level._id_02F3A1A97F388712[_id_D9BEFB3C1C446153];
  _id_12F119851BCA9DA5 = [];

  foreach(_id_87E48F43A5B5F24C, ref in _id_DB61A9C69AB388A7) {
    _id_11AD757F6E375867 = _id_08318B76D2EEDF2F(_id_D9BEFB3C1C446153, _id_87E48F43A5B5F24C);

    if(!istrue(_id_11AD757F6E375867._id_887D42B1410C39FE))
      _id_12F119851BCA9DA5[_id_12F119851BCA9DA5.size] = _id_87E48F43A5B5F24C;
  }

  _id_452E5615187761D2 = undefined;

  if(_id_12F119851BCA9DA5.size > 0) {
    if(_id_D9BEFB3C1C446153 == "world") {
      if(_id_12F119851BCA9DA5.size > 1 && scripts\engine\utility::array_contains(_id_12F119851BCA9DA5, "havoc_third_person"))
        _id_452E5615187761D2 = _id_22091D6A866EA9C5(_id_12F119851BCA9DA5);
      else
        _id_452E5615187761D2 = _id_12F119851BCA9DA5[randomint(_id_12F119851BCA9DA5.size)];
    } else
      _id_452E5615187761D2 = _id_12F119851BCA9DA5[randomint(_id_12F119851BCA9DA5.size)];
  }

  return _id_452E5615187761D2;
}

_id_22091D6A866EA9C5(_id_12F119851BCA9DA5) {
  _id_8DB1D4FFC13B5F87 = 25;
  _id_83377FE188EA5189 = 100;
  _id_D4B9E030F49735D5 = 0;
  _id_2EFB5DB5EA1ED5B8 = [];

  foreach(mod in _id_12F119851BCA9DA5) {
    _id_091FADDF8609303B = scripts\engine\utility::ter_op(mod == "havoc_third_person", _id_8DB1D4FFC13B5F87, _id_83377FE188EA5189);
    _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + _id_091FADDF8609303B;
    _id_2EFB5DB5EA1ED5B8[mod] = _id_D4B9E030F49735D5;
  }

  _id_162B86F62CD92B56 = randomint(_id_D4B9E030F49735D5);
  _id_1009E8199D46BE10 = undefined;

  foreach(_id_87E48F43A5B5F24C, _id_091FADDF8609303B in _id_2EFB5DB5EA1ED5B8) {
    if(_id_091FADDF8609303B > _id_162B86F62CD92B56) {
      _id_1009E8199D46BE10 = _id_87E48F43A5B5F24C;
      break;
    }
  }

  return _id_1009E8199D46BE10;
}

_id_A5FA76C74C473333(_id_89209396F51E191A) {
  _id_CA0D813D8FA8BB1D = _id_7469C072B8C751FC(_id_89209396F51E191A);

  if(!istrue(_id_CA0D813D8FA8BB1D))
    return 0;

  if(_id_89209396F51E191A._id_1C85B88373BA6A3E == "none" && _id_89209396F51E191A._id_9B8B3826BD61044F == "none")
    return 1;

  if(_id_89209396F51E191A._id_1C85B88373BA6A3E != "none")
    _id_CA0D813D8FA8BB1D = _id_C6A1E26057464B5F(_id_89209396F51E191A);

  if(_id_89209396F51E191A._id_9B8B3826BD61044F != "none")
    _id_CA0D813D8FA8BB1D = _id_08CA343BC8BBB9BC(_id_89209396F51E191A);

  return _id_CA0D813D8FA8BB1D;
}

_id_7469C072B8C751FC(_id_653659FC71620BEA) {
  return _id_653659FC71620BEA.threshold <= level._id_31504A1B9E6CBDEF;
}

_id_C6A1E26057464B5F(_id_653659FC71620BEA) {
  if(level._id_5C710278DD543E5C.size > 0) {
    foreach(_id_61A6016A17726221 in level._id_5C710278DD543E5C) {
      if(_id_653659FC71620BEA._id_1C85B88373BA6A3E == _id_61A6016A17726221.ref)
        return 1;
    }
  }

  return 0;
}

_id_08CA343BC8BBB9BC(_id_653659FC71620BEA) {
  if(level._id_5C710278DD543E5C.size > 0) {
    foreach(_id_61A6016A17726221 in level._id_5C710278DD543E5C) {
      if(_id_653659FC71620BEA._id_9B8B3826BD61044F == _id_61A6016A17726221.ref)
        return 0;
    }
  }

  return 1;
}

_id_722A88B02B9C6A83(category, name, value, _id_2DD220C4D334A359) {
  if(!istrue(_id_2DD220C4D334A359)) {
    _id_77335123603443B3 = spawnStruct();
    _id_77335123603443B3.category = category;
    _id_77335123603443B3.name = name;
    _id_77335123603443B3._id_E25764E59872B2B3 = scripts\mp\tweakables::gettweakabledvarvalue(category, name);
    level._id_0275F722DE69E61A[level._id_0275F722DE69E61A.size] = _id_77335123603443B3;
  }

  scripts\mp\tweakables::settweakabledvar(category, name, value);
  scripts\mp\tweakables::settweakablevalue(category, name, value);
}

_id_6E97354A9CA962DB(_id_45DF8C4441E75FDD) {
  if(level._id_0275F722DE69E61A.size > 0) {
    foreach(_id_EAEF819EF6E642C7 in level._id_0275F722DE69E61A) {
      if(istrue(_id_45DF8C4441E75FDD) && (_id_EAEF819EF6E642C7.name == "loadoutperksoff" || _id_EAEF819EF6E642C7.name == "perkpackage" || _id_EAEF819EF6E642C7.name == "showperksonspawn")) {
        continue;
      }
      _id_722A88B02B9C6A83(_id_EAEF819EF6E642C7.category, _id_EAEF819EF6E642C7.name, _id_EAEF819EF6E642C7._id_E25764E59872B2B3, 1);
    }
  }
}

_id_0D6CAFB83C2FA3BB() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    foreach(perk in level._id_719290BA2CA20FDC) {
      if(player scripts\mp\utility\perk::_hasperk(perk))
        player scripts\mp\utility\perk::removeperk(perk);
    }
  }
}

_id_D367D2AD15DC84CF() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    foreach(mod in level._id_5C710278DD543E5C) {
      _id_28F2A57C49DC3DC1 = player _id_AD12CDC21552B243();

      if(mod.category == "weapon" && istrue(_id_28F2A57C49DC3DC1)) {
        player scripts\cp_mp\utility\inventory_utility::_takeweapon(player getcurrentweapon());
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.primaryweaponobj);
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.secondaryweaponobj);
        player thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.primaryweaponobj, 1);
        break;
      }
    }
  }
}

_id_3ED044FFE00F170A() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\cranked::cleanupcrankedplayertimer();
  }
}

_id_AD12CDC21552B243() {
  _id_28F2A57C49DC3DC1 = 0;
  _id_C5108B06F2083214 = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_crossbow", ["ammo_bolt_mol"]);
  return self hasweapon(_id_C5108B06F2083214);
}

_id_03660568F097FA7E(_id_45DF8C4441E75FDD) {
  setomnvar("ui_havoc_show_mod", -1);
  setomnvar("ui_havoc_mod_status_1", -1);
  setomnvar("ui_havoc_mod_status_2", -1);
  setomnvar("ui_havoc_mod_status_3", -1);
  setomnvar("ui_havoc_mod_status_4", -1);
  setomnvar("ui_havoc_mod_status_5", -1);

  if(level._id_5C710278DD543E5C.size > 0) {
    foreach(mod in level._id_5C710278DD543E5C) {
      if(mod.ref == "havoc_eyes_on") {
        level.activeadvanceduavs["allies"]--;
        scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526("allies");
        level.activeadvanceduavs["axis"]--;
        scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526("axis");
        break;
      }
    }
  }

  _id_B39B72EB28EAE363(1);
  _id_6E97354A9CA962DB(_id_45DF8C4441E75FDD);
  _id_0D6CAFB83C2FA3BB();
  _id_D367D2AD15DC84CF();
  _id_3ED044FFE00F170A();
  level._id_46E88D936DB0725C = [];
  level._id_3E4609E79EC16D7A = [];
  level._id_5C710278DD543E5C = [];
}

_id_3C5CBE539052EA87() {
  level waittill("game_ended");
  _id_03660568F097FA7E();
}

_id_BAD07401641FD228() {
  playerowner = undefined;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    playerowner = player;
    break;
  }

  return playerowner;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

initspawns() {
  if(getdvarint("dvar_742CAA13B3C2E685")) {
    return;
  }
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(getdvarint("t10", 0) > 0)
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");
  thread _id_4D6A6309EDA44C4E();
  thread _id_31CA71112F5442E0();
}

_id_4D6A6309EDA44C4E() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("equipKillstreaksFinished");

    if(isPlayer(self) && !isbot(self)) {
      scripts\mp\killstreaks\killstreaks::clearkillstreaks();

      if(isDefined(self._id_1275922708964790))
        scripts\mp\killstreaks\killstreaks::awardkillstreak(self._id_1275922708964790, "other");
    }
  }
}

_id_31CA71112F5442E0() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("giveLoadout");
    scripts\mp\class::loadout_clearperks(1);
    _id_96E16459D5114277 = scripts\mp\class::_id_87C3B562F2B366EE(self);

    foreach(perk in _id_96E16459D5114277)
    scripts\mp\class::loadout_giveperk(perk);

    foreach(_id_B39BBB3A0E35C61E in level._id_3E4609E79EC16D7A) {
      if(!isDefined(_id_B39BBB3A0E35C61E.func)) {
        continue;
      }
      level[[_id_B39BBB3A0E35C61E.func]](self);
    }
  }
}

_id_BED1816B8632A262(weaponobj) {
  self endon("death_or_disconnect");

  for(;;) {
    currentweapon = self getcurrentweapon();

    if(currentweapon != weaponobj)
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weaponobj);
    else
      break;

    wait 0.1;
  }
}

_id_059A66532CE69BA0(_id_555748DE5727B94F) {
  _id_E78607DBD5BFA3B0 = _id_6B71256E2C7B2060(game["dialog"][_id_555748DE5727B94F], "allies");
  scripts\cp_mp\utility\dialog_utility::_id_3B08BE23BF113FCF(_id_555748DE5727B94F, "allies", "killstreak_earned", undefined, _id_E78607DBD5BFA3B0);
  _id_E78607DBD5BFA3B0 = _id_6B71256E2C7B2060(game["dialog"][_id_555748DE5727B94F], "axis");
  scripts\cp_mp\utility\dialog_utility::_id_3B08BE23BF113FCF(_id_555748DE5727B94F, "axis", "killstreak_earned", undefined, _id_E78607DBD5BFA3B0);
}

_id_6B71256E2C7B2060(event, team) {
  _id_A6461DE9055834B5 = spawnStruct();
  _id_A6461DE9055834B5.mode = "mp";
  _id_A6461DE9055834B5._id_365929041E4386ED = "havc";
  _id_A6461DE9055834B5.scene = "mode";
  _id_A6461DE9055834B5._id_7DC3241E7F3C6B24 = tolower(scripts\cp_mp\utility\dialog_utility::_id_592C1F6B3E44AC25(team));

  if(event == "havoc_mod_incoming")
    _id_A6461DE9055834B5.event = "havi";
  else
    _id_A6461DE9055834B5.event = "hava";

  return _id_A6461DE9055834B5;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  level notify("havoc_player_killed", attacker);

  foreach(_id_847D2A046CAA4B54 in level._id_46E88D936DB0725C)[[_id_847D2A046CAA4B54]](victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  victim._id_C115C6E4D9EEE7CA = undefined;
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

onsuicidedeath(victim) {
  victim._id_C115C6E4D9EEE7CA = undefined;
}

ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime")
    winner = "forfeit";
  else if("tie")
    winner = "overtime";

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

shouldgamelobbyremainintact() {
  _id_18A3FAB290E780C2 = int(game["teamScores"]["axis"]);
  _id_43A41488C3C487DF = int(game["teamScores"]["allies"]);
  _id_F9C7AAE8C6ACD600 = _id_18A3FAB290E780C2 - _id_43A41488C3C487DF;
  return _id_F9C7AAE8C6ACD600 < 10;
}