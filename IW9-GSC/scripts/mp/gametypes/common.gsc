/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\common.gsc
***********************************************/

setupcommoncallbacks() {
  level.onnormaldeath = ::oncommonnormaldeath;
  level.onsuicidedeath = ::oncommonsuicidedeath;
  level.onteamchangedeath = ::oncommonteamchangedeath;
  addspecialistdialog();

  if(isusingmatchrulesdata()) {
    level._id_6B6AB19619B97010 = ::_id_6B6AB19619B97010;
    [[level._id_6B6AB19619B97010]]();
  }

  _id_9081E2D33D0B53F9();
  _id_E9AD38AF5A6BEDCD();
  _id_8D478840C4E44366();
  _id_36532A1506F2C161();
  _id_030DD74B21BFFFE6();
  _id_52343D5C1B190CF0();
  _id_1513C3F71E935D73();
  level.spawnprotectionexception = undefined;
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onplayerjointeamcommon);
  scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 0);
  level._effect["cranked_explode"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
}

_id_6B6AB19619B97010() {
  setdynamicdvar("scr_game_aiagentsinmp", getmatchrulesdata("commonOption", "aiSpawnOnDeath"));
  setdynamicdvar("scr_game_aispawnondeath", getmatchrulesdata("commonOption", "aiSpawnOnDeath"));
  setdynamicdvar("scr_game_buymode", getmatchrulesdata("commonOption", "buyMode"));
  setdynamicdvar("dvar_4E33F79A5437AA5C", getmatchrulesdata("commonOption", "classForceLoadouts"));
  setdynamicdvar("dvar_A88F1329561BC6E1", getmatchrulesdata("commonOption", "carePackageDropTime"));
  setdynamicdvar("dvar_127490A7577F169F", getmatchrulesdata("commonOption", "tier1ModeEnabled"));
  setdynamicdvar("dvar_A2C2C2007177185E", getmatchrulesdata("commonOption", "hardcoreModeEnabled"));
  setdynamicdvar("calloutmarkerping_enabled", getmatchrulesdata("commonOption", "allowCalloutMarkerPing"));
  setdynamicdvar("calloutmarkerping_wheel_enabled", getmatchrulesdata("commonOption", "allowCalloutMarkerPing"));
}

_id_3149B2E03CE13DD9() {
  level.usepingsystem = getdvarint("calloutmarkerping_enabled", 1);

  if(istrue(level.usepingsystem))
    scripts\mp\calloutmarkerping_mp::calloutmarkerping_init();

  level _id_451A1A9BD9613164::_id_8ECE37593311858A(_id_07C40FA80892A721::initarmor);
  level scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_07C40FA80892A721::givestartingarmor);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_07C40FA80892A721::_id_13CAA305C839A278);
}

updatecommongametypedvars() {
  level.dogtagsenabled = scripts\mp\utility\dvars::dvarintvalue("dogtags", 0, 0, 1);

  if(level.dogtagsenabled)
    _id_1CEA1B70A5AAD392::init();

  level._id_249CDFC0F19C1B42 = scripts\mp\utility\dvars::dvarintvalue("mtxKillThresholdStage1", 10, 1, 20);
  level._id_249CDEC0F19C190F = scripts\mp\utility\dvars::dvarintvalue("mtxKillThresholdStage2", 20, 1, 20);
}

oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  score = 0;

  if(isbot(self) && isDefined(self.isbotmedicrole))
    self.isbotmedicrole = undefined;

  if(istrue(level.flashpointactive) && isDefined(attacker) && isDefined(attacker.team))
    scripts\mp\flashpoint::flashpoint_processnewevent(attacker, victim, gettime(), "kill_by_" + attacker.team);

  if(isDefined(attacker._id_ACB55A437C3145C0) && isDefined(attacker._id_ACB55A437C3145C0.objweapon) && attacker._id_ACB55A437C3145C0.objweapon.basename == "iw9_racecar_mp")
    return 1;

  _id_E67514BA22EEC9CB = scripts\mp\utility\game::islaststandenabled() && istrue(victim.playergoingintols);

  if(!_id_E67514BA22EEC9CB && attacker.team != self.team) {
    _id_605B9986CE6166A1 = level.scoremod["death"] * -1;

    if(_id_605B9986CE6166A1 != 0) {
      if(level.teambased)
        level scripts\mp\gamescore::giveteamscoreforobjective(victim.pers["team"], _id_605B9986CE6166A1, 0);
      else
        attacker scripts\mp\gamescore::giveplayerscore("stat_EF9582D72160F199", _id_605B9986CE6166A1);
    }

    score = level.scoremod["kill"];

    if(istrue(iskillstreakweapon))
      score = score + level.scoremod["kskill"];

    if(meansofdeath == "MOD_HEAD_SHOT")
      score = score + level.scoremod["headshot"];

    if(level.dogtagsenabled && scripts\mp\flags::gameflag("prematch_done"))
      level thread _id_1CEA1B70A5AAD392::spawndogtags(victim, attacker, "new_tag_spawned", meansofdeath);
  }

  if(level.gametype != "havoc" && (scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(attacker) || scripts\mp\utility\game::_id_E9F3A160BBEFE208(victim))) {
    if(scripts\mp\utility\game::matchmakinggame() && isDefined(attacker.cranked)) {
      if(!_id_E67514BA22EEC9CB && score != 0) {
        score = score + 1;
        attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", score));
      }
    }

    attacker scripts\mp\cranked::oncranked(victim, attacker, lifeid);
  }

  if(score != 0) {
    if(level.teambased)
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    else
      attacker scripts\mp\gamescore::giveplayerscore("stat_EF9582D72160F199", score, victim);
  }

  _id_F4143542F608E034 = 1;

  if(isDefined(level._id_5DF506226294AA65))
    level thread[[level._id_5DF506226294AA65]](victim, attacker);

  if(istrue(level._id_36304CC9071BF738)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    victim _id_7E52B56769FA7774::dropbrhealthpack(dropstruct);
  }

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19() && getdvarint("dvar_6CE02FDC43B4F5CF", 0) != 0)
    victim _id_7BAC8EE72285298E();

  if(isPlayer(attacker)) {
    _id_4DA4CB52D0BF5B05 = meansofdeath == "MOD_HEAD_SHOT";
    _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + (level.scoremod["kill"] << 4);
    attacker _id_0417749E099F041F(_id_4DA4CB52D0BF5B05, victim getentitynumber());
  }
}

oncommonsuicidedeath(victim) {
  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(victim))
    victim scripts\mp\cranked::cleanupcrankedplayertimer();

  if(isDefined(level.scoremod)) {
    _id_605B9986CE6166A1 = level.scoremod["death"] * -1;

    if(_id_605B9986CE6166A1 != 0) {
      if(level.teambased)
        level scripts\mp\gamescore::giveteamscoreforobjective(victim.pers["team"], _id_605B9986CE6166A1, 0);
    }
  }

  if(isDefined(level.modeonsuicidedeath))
    [[level.modeonsuicidedeath]](victim);
}

oncommonteamchangedeath(victim) {
  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(victim))
    victim scripts\mp\cranked::cleanupcrankedplayertimer();

  if(isDefined(level.modeonteamchangedeath))
    [[level.modeonteamchangedeath]](victim);
}

dogtagcommonallyonusecb(player) {}

dogtagcommonenemyonusecb(player) {}

onspawnplayercommon(_id_9156B53BCF7CE573) {
  if(istrue(game["inLiveLobby"])) {
    _id_949548949727D77E = istrue(level.allowprematchdamage) && istrue(level.spawnprotectiontimer);
    thread managespawnprotection(_id_949548949727D77E);
  } else if(istrue(level.spawnprotectiontimer) && !istrue(_id_9156B53BCF7CE573)) {
    if(isDefined(level.spawnprotectionexception)) {
      if([[level.spawnprotectionexception]]())
        thread managespawnprotection(1);
    } else
      thread managespawnprotection(1);
  }

  if(scripts\mp\utility\game::isteamreviveenabled())
    thread scripts\mp\teamrevive::updaterevivetriggerspawnposition();

  if(istrue(level.disablesupersprint))
    self allowsupersprint(0);

  if(istrue(level.disablemount)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  if(isDefined(level.modeonspawnplayer))
    [[level.modeonspawnplayer]](_id_9156B53BCF7CE573);
  else
    thread updatematchstatushintonspawncommon();

  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    updatealiveomnvars();

  if(istrue(game["practiceRound"])) {
    if(istrue(level.snowballfight))
      thread snowballfighthint();
    else
      self sethudtutorialmessage("MP_INGAME_ONLY/PRACTICE_ROUND", 1);
  } else if(!isagent(self))
    self clearhudtutorialmessage();

  if(isDefined(level._id_ADB18014BBFC01A8))
    self[[level._id_ADB18014BBFC01A8]]();
}

nvghintnotify(_id_E9DEF77708D779B7) {
  self endon("disconnect");
  self notify("nvg_spawn_tutorial");
  self endon("nvg_spawn_tutorial");
  _id_63366D9D88CE51F8 = 1;

  if(!isDefined(_id_E9DEF77708D779B7))
    _id_E9DEF77708D779B7 = 0;

  for(;;) {
    if(_id_63366D9D88CE51F8)
      self waittill("giveLoadout");
    else
      self waittill("spawned");

    if(_id_E9DEF77708D779B7 < 2) {
      if(self usinggamepad())
        msg = "hint_use_nvg";
      else
        msg = "hint_use_nvg_kb";

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
        level waittill("prematch_done");
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(msg);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      } else {
        if(!_id_E9DEF77708D779B7)
          wait 5;

        scripts\mp\utility\lower_message::setlowermessageomnvar(msg);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      }

      _id_E9DEF77708D779B7++;
      continue;
    }

    break;
  }
}

_id_72646E9A09D68970() {
  _id_4B86A4E17C656399 = getdvarint("dvar_7B6A932574C43DB8", 0);
  self _meth_86AF48E06C94360A(_id_4B86A4E17C656399);
}

_id_59A736FFFDDC7C05(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  _id_CF4E298F83EA9B6F = getdvarint("dvar_7B6A932574C43DB8", 0);
  _id_8CB91548BA73DD05 = getdvarint("dvar_A82DA6C4BFC1360A", 9000);

  if(_id_4B86A4E17C656399 == _id_CF4E298F83EA9B6F) {
    if(progress >= _id_8CB91548BA73DD05)
      kick(self getentitynumber(), "EXE/PLAYERKICKED", 1);
  }
}

onplayerkilledcommon(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00, iskillstreakweapon) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    updatealiveomnvars();

  if(isDefined(level.onplayerkilled))
    [[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(isDefined(level._id_9ABCA503637351B3))
    [[level._id_9ABCA503637351B3]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(_id_2009718B681222C2()) {
    if(isbot(self))
      self.classcallback = "gamemode";
  }
}

onplayerconnectcommon() {
  for(;;) {
    level waittill("connected", player);

    if(isDefined(level.onplayerconnect))
      level thread[[level.onplayerconnect]](player);

    if(istrue(level._id_36304CC9071BF738))
      player._id_D2DBB2FA012E6D9C = [];

    if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
      player thread _id_9BAEAFA29FCF15F9();

    if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4() && !_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
      player thread nvghintnotify();

    if(_id_2009718B681222C2()) {
      level.denyclasschoice = 1;
      player scripts\mp\class::_id_A16868D4DCD81A4B();
      player.pers["gamemodeLoadout"] = game["forceRandomLoadout"][game["forceRandomLoadoutIndex"]];
    }

    if(istrue(level.usepingsystem))
      player scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();

    if(isDefined(player) && scripts\common\utility::_id_A10967D736DC56E5())
      level thread _id_70C67FA95F4222C1(player);

    if(!player _meth_1CB874DFC01DE80D()) {
      if(getdvarint("dvar_7B6A932574C43DB8", 0) != 0)
        player _id_72646E9A09D68970();
    }
  }
}

_id_70C67FA95F4222C1(player) {
  player endon("disconnect");

  if(!isDefined(level.difficultytype))
    level _id_48814951E916AF89::_id_C8393014DD7F8AB6();

  player.gameskill = _id_53DA3333B83B3527::get_gameskill();
  player _id_53DA3333B83B3527::set_difficulty_from_locked_settings();
  player.owner = undefined;
  scripts\engine\utility::flag_wait("level_stealth_initialized");

  while(!isDefined(player.team))
    waitframe();

  player scripts\stealth\player::main();
}

onplayerdisconnectcommon(player) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    player updatealiveomnvars();

  if(isDefined(level.onplayerdisconnect))
    player thread[[level.onplayerdisconnect]](player);
}

onplayerjointeamcommon(player) {
  if(isDefined(level.onplayerjointeam))
    [[level.onplayerjointeam]](self);

  if(istrue(level.dogtagsenabled))
    _id_1CEA1B70A5AAD392::onplayerjoinedteam(player);

  if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4())
    player thread nvghintnotify(1);
}

managespawnprotection(_id_AC20F98EA430A859) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_spawn_protection");
  thread applyspawnprotection();

  if(!istrue(level.allowprematchdamage))
    scripts\mp\flags::gameflagwait("prematch_done");

  if(_id_AC20F98EA430A859)
    wait(level.spawnprotectiontimer);

  thread removespawnprotection();
}

applyspawnprotection() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  self waittill("spawned_player");
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
}

removespawnprotection() {
  self endon("disconnect");

  if(isDefined(self))
    self.spawnprotection = 0;

  scripts\mp\lightarmor::lightarmor_unset(self);
  self notify("remove_spawn_protection");
}

updatealiveomnvars() {
  if(isDefined(level.updatealiveomnvars))
    self[[level.updatealiveomnvars]]();
  else {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_856DC7D9133C0369 = 0;
      totalplayers = 0;

      foreach(_id_F90358454413407F in level.teamnamelist) {
        _id_856DC7D9133C0369 = _id_856DC7D9133C0369 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");
        totalplayers = totalplayers + scripts\mp\utility\teams::getteamcount(_id_F90358454413407F);
      }

      setomnvar("ui_allies_alive", 0);
      setomnvar("ui_axis_alive", _id_856DC7D9133C0369);
      setomnvar("ui_allies_team_size", 0);
      setomnvar("ui_axis_team_size", totalplayers);
      return;
    }

    setomnvar("ui_allies_alive", scripts\mp\utility\teams::getteamdata("allies", "aliveCount"));
    setomnvar("ui_axis_alive", scripts\mp\utility\teams::getteamdata("axis", "aliveCount"));
    setomnvar("ui_allies_team_size", scripts\mp\utility\teams::getteamcount("allies"));
    setomnvar("ui_axis_team_size", scripts\mp\utility\teams::getteamcount("axis"));
  }
}

updatematchstatushintonspawncommon() {
  level endon("game_ended");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");
}

ffmessageonspawn() {
  wait 1;

  if(isDefined(self))
    scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
}

addspecialistdialog() {
  game["dialog"]["specialty_warhead"] = "perk_amped";
  game["dialog"]["specialty_tac_resist"] = "perk_amped";
  game["dialog"]["specialty_covert_ops"] = "perk_coldblooded";
  game["dialog"]["specialty_hustle"] = "perk_doubletime";
  game["dialog"]["specialty_eod"] = "perk_eod";
  game["dialog"]["specialty_guerrilla"] = "perk_ghost";
  game["dialog"]["specialty_surveillance"] = "perk_highalert";
  game["dialog"]["specialty_heavy_metal"] = "perk_killchain";
  game["dialog"]["specialty_munitions_2"] = "perk_overkill";
  game["dialog"]["specialty_strategist"] = "perk_pointman";
  game["dialog"]["specialty_quick_fix"] = "perk_quickfix";
  game["dialog"]["specialty_restock"] = "perk_restock";
  game["dialog"]["specialty_scavenger_plus"] = "perk_scavenger";
  game["dialog"]["specialty_extra_shrapnel"] = "perk_shrapnel";
  game["dialog"]["specialty_specialist_bonus"] = "perk_specialistbonus";
  game["dialog"]["specialty_tactical_recon"] = "perk_spotter";
  game["dialog"]["specialty_huntmaster"] = "perk_tracker";
  game["dialog"]["specialty_tune_up"] = "perk_tuneup";
}

_id_E9AD38AF5A6BEDCD() {
  if(getdvarint("scr_game_buymode", 0) == 1)
    _id_88B47710BECE931F();
}

_id_88B47710BECE931F() {
  _id_FDC32B02A967AA99();
  setomnvar("ui_buy_mode", 1);
  level._id_9CDAADFDDEDA4D7A = 1;
  level._id_8EC1A1CA587A6487 = ::_id_8EC1A1CA587A6487;
  level._id_C59C301EAABC2E32 = 1;
  level.br_plunder_enabled = 1;
  level._id_1E17E3480B1D264D = 1;
  level.armoronweaponswitchlongpress = 1;
  setDvar("dvar_ED6E4FFA933AF621", 1);
  setDvar("scr_game_allow_loot", 1);
  setDvar("loot_table_name", "mp/loot/br/default/loot_item_defs.csv");
  setDvar("loot_table_zones", " mp/loot/core/risk/loot_table_zones.csv");
  setDvar("bg_piggybackArmorOnNVG", 1);
  setDvar("dvar_6D36F3E8FBC43781", "2,5");
  _id_4384ABBF498DF6A7::_id_B38F5FFE645943C3("core");

  if(level._id_1E17E3480B1D264D)
    level._id_9C1E3C18B99409E9 = scripts\mp\utility\points::_id_9C1E3C18B99409E9;

  level thread _id_D05C9BF671A28D2D();
  level thread _id_88822B4598FF1773();
}

_id_D05C9BF671A28D2D() {
  waitframe();
  level scripts\common\ui::lui_registercallback("buy_menu_open", _id_4384ABBF498DF6A7::armorykioskused);
  level scripts\common\ui::lui_registercallback("buy_menu_close", ::_id_CD2DB96CA42742E6);
  _id_4384ABBF498DF6A7::init();
  level._id_8E9DABA162280A8E = 1;
  level._id_6BEFF7B631AB7E18 = ::_id_6BEFF7B631AB7E18;
}

_id_CD2DB96CA42742E6(value) {
  self notify("buy_menu_close");
}

_id_FDC32B02A967AA99() {
  _id_4D43EB408252DAA0 = [];
  _id_4D43EB408252DAA0[_id_4D43EB408252DAA0.size] = getEnt("cyber_empzone_axis", "targetname");
  _id_4D43EB408252DAA0[_id_4D43EB408252DAA0.size] = getEnt("cyber_empzone_allies", "targetname");
  _id_58553518A66CEBE9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in _id_58553518A66CEBE9)
  _id_4D43EB408252DAA0[_id_4D43EB408252DAA0.size] = trig;

  if(_id_4D43EB408252DAA0.size == 0) {
    primaryflags = getEntArray("flag_primary", "targetname");

    foreach(flag in primaryflags) {
      _id_4D43EB408252DAA0[_id_4D43EB408252DAA0.size] = flag;
      break;
    }
  }

  _id_C9050C643D9FCEAC = [];

  foreach(temp in _id_4D43EB408252DAA0) {
    _id_EAF4A038607A8C2F = spawnStruct();
    _id_EAF4A038607A8C2F.origin = temp.origin;
    _id_EAF4A038607A8C2F.angles = temp.angles;
    _id_C9050C643D9FCEAC[_id_C9050C643D9FCEAC.size] = _id_EAF4A038607A8C2F;
  }

  level thread _id_BDC6D23A3189EC1F(_id_C9050C643D9FCEAC);
}

_id_BDC6D23A3189EC1F(_id_BAAF67A759D54315) {
  waitframe();
  level._id_5B25E7620E424CB2 = [];
  _id_EADBD277474BB8BD = scripts\engine\utility::getStructArray("buystation_loc", "targetname");

  foreach(loc in _id_EADBD277474BB8BD)
  _id_EADBD277474BB8BD[_id_EADBD277474BB8BD.size] = _id_EADBD277474BB8BD;

  if(_id_EADBD277474BB8BD.size > 0)
    _id_BAAF67A759D54315 = _id_EADBD277474BB8BD;

  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);

  foreach(loc in _id_BAAF67A759D54315) {
    if(_id_EADBD277474BB8BD.size == 0) {
      groundorigin = scripts\engine\utility::drop_to_ground(loc.origin + anglesToForward(loc.angles) * 50, 50, -200, undefined, _id_FBCABD62B8F66EB8);
      spawnangles = loc.angles;
    } else {
      groundorigin = loc.origin;
      spawnangles = loc.angles;
    }

    _id_2FA65F34EB9042F5 = spawnscriptable("br_plunder_box", groundorigin, spawnangles);
    _id_2FA65F34EB9042F5 setscriptablepartstate("br_plunder_box", "visible");
    _id_2FA65F34EB9042F5._id_5CFA621EBF61D8AA = 0;
    level._id_5B25E7620E424CB2[level._id_5B25E7620E424CB2.size] = _id_2FA65F34EB9042F5;
  }
}

_id_88822B4598FF1773() {
  level._id_068A1353068460D1 = scripts\mp\cranked::_id_068A1353068460D1;
  waitframe();

  if(level.crankedbombtimer == 0)
    level.crankedbombtimer = 30;
}

_id_D19636A80151B35D(squadindex) {
  player = self;
  player.br_squadindex = squadindex;
  _id_573AA6BE0B25ACD9 = player.game_extrainfo & 65528;
  _id_573AA6BE0B25ACD9 = _id_573AA6BE0B25ACD9 | squadindex;
  player.game_extrainfo = _id_573AA6BE0B25ACD9;
  player setclientomnvar("ui_client_squad_index", 1);
}

_id_6BEFF7B631AB7E18(instance, player) {
  if(isint(instance)) {
    instance = player;
    instance._id_5CFA621EBF61D8AA = 0;
    instance.objectivekey = "_a";
  } else {}

  if(istrue(instance._id_5CFA621EBF61D8AA) || istrue(level._id_8E9DABA162280A8E))
    player setclientomnvar("ui_buystation_override", _id_600B944A95C3A7BF::_id_54B046AA3BA2678A("core"));
}

_id_8EC1A1CA587A6487(_id_CB325DDB4A764623) {
  switch (_id_CB325DDB4A764623) {
    case "armor_plate":
    case "armor":
      self.pers["armor_buy_plates"]++;
      break;
    case "armor_plate_instant":
      if(scripts\mp\utility\player::isreallyalive(self)) {
        if(isDefined(self.armorhealth) && self.armorhealth < self._id_8790C077C95DB752)
          _id_07C40FA80892A721::_id_AC7803D45979135C(int(clamp(self.armorhealth + level._id_4B78859BACC88808, 0, self._id_8790C077C95DB752)));
      } else {
        self.pers["armor_buy_plates_instant"]++;
        thread _id_07C40FA80892A721::_id_4F88731347251184();
      }
    default:
      break;
  }
}

_id_9BAEAFA29FCF15F9() {
  _id_03F1B6713CA4C9C7::_id_6DA8B65579348D0B();
  _id_D19636A80151B35D(1);

  if(!isDefined(self.pers["armor_buy_plates"])) {
    self.pers["armor_buy_plates"] = 0;
    self.pers["armor_buy_plates_instant"] = 0;
  }
}

_id_8D478840C4E44366() {
  level._id_726494DF62567093 = scripts\engine\utility::ter_op(getdvarint("dvar_4E33F79A5437AA5C", 0) > 0, getdvarint("dvar_4E33F79A5437AA5C", 0), undefined);

  if(_id_2009718B681222C2())
    level thread _id_5E789E0461BC3A69();
}

_id_2009718B681222C2() {
  return isDefined(level._id_726494DF62567093) && level._id_726494DF62567093 > 0;
}

_id_5E789E0461BC3A69() {
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.bots_gametype_handles_class_choice = 1;
  waitframe();
  thread _id_943A60C848E07E13();
  _id_09EF19AF8915EBB2();
}

_id_943A60C848E07E13() {
  if(!isDefined(game["roundsPlayed"]))
    game["roundsPlayed"] = 0;

  if(game["roundsPlayed"] == 0) {
    if(istrue(game["practiceRound"])) {
      _id_0BE8C4476E2E599F();
      game["forceRandomLoadoutIndex"] = 0;
    } else if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
      if(istrue(game["didSnowFight"]))
        game["didSnowFight"] = undefined;

      _id_0BE8C4476E2E599F();
      game["forceRandomLoadoutIndex"] = 0;
    }
  } else {
    level.loadoutchangeround = level._id_726494DF62567093;

    if(level.loadoutchangeround != 0) {
      if(game["roundsPlayed"] % level.loadoutchangeround == 0)
        game["forceRandomLoadoutIndex"]++;

      if(game["forceRandomLoadoutIndex"] == game["forceRandomLoadout"].size)
        game["forceRandomLoadoutIndex"] = 0;
    } else
      game["forceRandomLoadoutIndex"] = 0;
  }
}

_id_0BE8C4476E2E599F() {
  game["forceRandomLoadout"] = [];
  loadouts = [];
  _id_D6F262BBEC7B0CAA = 0;
  table = "classtable:classtable_force_loadouts";

  for(_id_A300FA75277719EE = scripts\mp\class::_id_DF2933F96D726D71(table); _id_D6F262BBEC7B0CAA < _id_A300FA75277719EE; _id_D6F262BBEC7B0CAA++)
    loadouts[loadouts.size] = _id_E2302479CA960E45(table, _id_D6F262BBEC7B0CAA);

  _id_B51C1B732564E22A = undefined;
  _id_E08CB9BBD6F3241D = undefined;
  _id_7EA3494E3DA2FBA5 = getDvar("dvar_76BC70AAC09A0054", "");
  _id_8831B759B9F84BE1 = getdvarfloat("dvar_680F5C2690E8D15F", 0.0);

  if(_id_7EA3494E3DA2FBA5 != "" && _id_8831B759B9F84BE1 > 0.0) {
    _id_F684B277677B66EB = strtok(_id_7EA3494E3DA2FBA5, ",");

    foreach(_id_A6ED1602A5107749 in _id_F684B277677B66EB) {
      _id_094B8DA0083DAE53 = strtok(_id_A6ED1602A5107749, "|");

      if(_id_094B8DA0083DAE53.size == 2) {
        rootweapon = _id_094B8DA0083DAE53[0];
        variantid = int(_id_094B8DA0083DAE53[1]);
        _id_3F57E7EDDC8A4779 = scripts\mp\utility\weapon::weaponisValid(rootweapon, variantid);

        if(_id_3F57E7EDDC8A4779) {
          if(!isDefined(_id_B51C1B732564E22A)) {
            _id_B51C1B732564E22A = [];
            _id_E08CB9BBD6F3241D = _id_8831B759B9F84BE1;
          }

          struct = spawnStruct();
          struct.rootweapon = rootweapon;
          struct.variantid = variantid;
          _id_B51C1B732564E22A[_id_B51C1B732564E22A.size] = struct;
        }
      }
    }
  }

  loadouts = _id_A8FC18DF76D1AA2F(loadouts, 99, _id_B51C1B732564E22A, _id_E08CB9BBD6F3241D);
  game["forceRandomLoadout"] = scripts\engine\utility::array_randomize(loadouts);
}

_id_E2302479CA960E45(table, _id_089688461C79EF11) {
  _id_E698DF1EC0933CE4 = [];
  _id_E698DF1EC0933CE4["loadoutArchetype"] = "archetype_assault";
  _id_E698DF1EC0933CE4["loadoutPrimaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_089688461C79EF11, 0);
  _id_E698DF1EC0933CE4["loadoutPrimary"] = scripts\mp\class::table_getweapon(table, _id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutPrimaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_089688461C79EF11, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_089688461C79EF11, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryVariantID"] = 0;
  _id_E698DF1EC0933CE4["loadoutSecondaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_089688461C79EF11, 1);
  _id_E698DF1EC0933CE4["loadoutSecondary"] = scripts\mp\class::table_getweapon(table, _id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
  }

  if(istrue(level.specialdayloadouts))
    _id_E698DF1EC0933CE4["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_089688461C79EF11, 1);
  else
    _id_E698DF1EC0933CE4["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_089688461C79EF11, 1);

  _id_E698DF1EC0933CE4["loadoutSecondaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_089688461C79EF11, 1);
  _id_E698DF1EC0933CE4["loadoutSecondaryVariantID"] = 0;
  _id_E698DF1EC0933CE4["loadoutEquipmentPrimary"] = scripts\mp\class::table_getequipmentprimary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = scripts\mp\class::table_getextraequipmentprimary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] = scripts\mp\class::table_getequipmentsecondary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = scripts\mp\class::table_getextraequipmentsecondary(table, _id_089688461C79EF11);
  _id_E698DF1EC0933CE4["loadoutPerks"] = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    perk = scripts\mp\class::table_getperk(table, _id_089688461C79EF11, _id_AC0E594AC96AA3A8);

    if(perk != "specialty_null")
      _id_E698DF1EC0933CE4["loadoutPerks"][_id_E698DF1EC0933CE4["loadoutPerks"].size] = perk;
  }

  _id_E698DF1EC0933CE4["loadoutGesture"] = "playerData";
  _id_E698DF1EC0933CE4["loadoutExecution"] = "playerData";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade1"] = "none";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade2"] = "none";
  return _id_E698DF1EC0933CE4;
}

_id_A8FC18DF76D1AA2F(loadouts, count, _id_B51C1B732564E22A, _id_E08CB9BBD6F3241D) {
  _id_92F35FCFAE58B4EB = [];
  _id_B0BC46F3BA5DB389 = [];

  for(num = 0; num < count && loadouts.size > 0; num++) {
    loadout = loadouts[randomint(loadouts.size)];
    _id_ACFE7336F59B3D76 = loadout["loadoutPrimary"];

    if(isDefined(_id_B51C1B732564E22A) && isDefined(_id_E08CB9BBD6F3241D)) {
      _id_53877F59F7445553 = _id_01AC1E1C43D4CEBC(_id_ACFE7336F59B3D76);
      _id_208F46D708A99CC3 = _id_828B81C9F2465841(_id_B51C1B732564E22A, _id_53877F59F7445553);

      if(_id_208F46D708A99CC3.size > 0) {
        if(randomfloat(1.0) < _id_E08CB9BBD6F3241D) {
          _id_920D33641E200BDB = randomint(_id_208F46D708A99CC3.size);
          _id_4FC88DFDBD8DDB28 = _id_208F46D708A99CC3[_id_920D33641E200BDB];
          _id_B51C1B732564E22A = scripts\engine\utility::array_remove_index(_id_B51C1B732564E22A, _id_920D33641E200BDB);
          loadout["loadoutPrimaryAddBlueprintAttachments"] = 1;
          loadout["loadoutPrimary"] = _id_4FC88DFDBD8DDB28.rootweapon;
          loadout["loadoutPrimaryVariantID"] = _id_4FC88DFDBD8DDB28.variantid;
          loadout["loadoutPrimaryCamo"] = "none";
          loadout["loadoutPrimaryReticle"] = "none";

          for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
            _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");
            loadout[_id_EFBDCD88107AF5F9] = "none";
          }
        }
      }
    }

    _id_B0BC46F3BA5DB389[_id_B0BC46F3BA5DB389.size] = loadout;
    loadouts = _id_F76C0948F37C7855(loadouts, _id_ACFE7336F59B3D76);
  }

  return _id_B0BC46F3BA5DB389;
}

_id_828B81C9F2465841(_id_855A91067674D651, _id_53877F59F7445553) {
  _id_7CB19F95DBC68942 = [];

  foreach(struct in _id_855A91067674D651) {
    if(_id_01AC1E1C43D4CEBC(struct.rootweapon) == _id_53877F59F7445553)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942;
}

_id_F76C0948F37C7855(loadouts, _id_ACFE7336F59B3D76) {
  _id_7CB19F95DBC68942 = [];
  group = _id_01AC1E1C43D4CEBC(_id_ACFE7336F59B3D76);

  foreach(loadout in loadouts) {
    _id_EDCF839453192090 = _id_01AC1E1C43D4CEBC(loadout["loadoutPrimary"]);

    if(group != _id_EDCF839453192090)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = loadout;
  }

  return _id_7CB19F95DBC68942;
}

_id_01AC1E1C43D4CEBC(rootweapon) {
  group = "none";

  if(rootweapon != "none") {
    group = scripts\mp\utility\weapon::getweapongroup(rootweapon);

    if(group == "weapon_dmr")
      group = "weapon_sniper";
  }

  return group;
}

updatehighpriorityweapons() {
  self loadweaponsforplayer(level.loadweapons, 1);
}

_id_09EF19AF8915EBB2() {
  level.loadweapons = [];
  _id_BC002676438672C9 = [];
  _id_2AEE5A9B1A165F09 = [];
  loadout = game["forceRandomLoadout"][game["forceRandomLoadoutIndex"]];
  primary = loadout["loadoutPrimary"];
  _id_D7B9856A19F9B6B5 = loadout["loadoutSecondary"];

  if(primary != "none")
    _id_BC002676438672C9[_id_BC002676438672C9.size] = _id_D08DB0C19DAACC9C(primary, loadout, 1);

  if(_id_D7B9856A19F9B6B5 != "none")
    _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = _id_5C5F49069EB558EC(_id_D7B9856A19F9B6B5, loadout, 1);

  if(!isDefined(level.loadoutchangeround))
    level.loadoutchangeround = 1;

  if(level.loadoutchangeround != 0) {
    _id_A9C56228C41ECDA0 = game["forceRandomLoadoutIndex"] + 1;

    if(game["forceRandomLoadoutIndex"] == game["forceRandomLoadout"].size - 1)
      _id_A9C56228C41ECDA0 = 0;

    _id_C3D433AF5F864E84 = game["forceRandomLoadout"][_id_A9C56228C41ECDA0];
    _id_C03D6DD4BFB14C5A = _id_C3D433AF5F864E84["loadoutPrimary"];
    _id_FCCB1D1573E7F2A6 = _id_C3D433AF5F864E84["loadoutSecondary"];

    if(_id_C03D6DD4BFB14C5A != "none")
      _id_BC002676438672C9[_id_BC002676438672C9.size] = _id_D08DB0C19DAACC9C(_id_C03D6DD4BFB14C5A, _id_C3D433AF5F864E84);

    if(_id_FCCB1D1573E7F2A6 != "none")
      _id_2AEE5A9B1A165F09[_id_2AEE5A9B1A165F09.size] = _id_5C5F49069EB558EC(_id_FCCB1D1573E7F2A6, _id_C3D433AF5F864E84);
  }

  level.loadweapons = scripts\engine\utility::array_combine(_id_BC002676438672C9, _id_2AEE5A9B1A165F09);
}

_id_D08DB0C19DAACC9C(primary, loadout, _id_995DC1BB9AC37BF2) {
  _id_AC82E189F4D06152 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_AB0F600188412CF1 = "";

    attachment = loadout["loadoutPrimaryAttachment" + _id_AB0F600188412CF1];

    if(attachment != "none")
      _id_AC82E189F4D06152[_id_AC82E189F4D06152.size] = attachment;
  }

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(primary);
  camoname = "none";
  _id_6A42D475DFB96A31 = "none";
  variantid = undefined;
  _id_F3464D71F01F614E = undefined;
  cosmeticattachment = undefined;
  stickers = undefined;
  _id_2CF0771420522CB6 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_AC82E189F4D06152, camoname, _id_6A42D475DFB96A31, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers);
  _id_DD515FCF025B2E79 = getcompleteweaponname(_id_2CF0771420522CB6);
  return _id_DD515FCF025B2E79;
}

_id_5C5F49069EB558EC(_id_D7B9856A19F9B6B5, loadout, _id_995DC1BB9AC37BF2) {
  _id_AC82E189F4D06152 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_AB0F600188412CF1 = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_AB0F600188412CF1 = "";

    attachment = loadout["loadoutSecondaryAttachment" + _id_AB0F600188412CF1];

    if(attachment != "none")
      _id_AC82E189F4D06152[_id_AC82E189F4D06152.size] = attachment;
  }

  camoname = "none";
  _id_6A42D475DFB96A31 = "none";
  variantid = undefined;
  _id_F3464D71F01F614E = undefined;
  cosmeticattachment = undefined;
  stickers = undefined;
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_D7B9856A19F9B6B5);
  _id_2CF0771420522CB6 = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, _id_AC82E189F4D06152, camoname, _id_6A42D475DFB96A31);
  _id_DD515FCF025B2E79 = getcompleteweaponname(_id_2CF0771420522CB6);
  return _id_DD515FCF025B2E79;
}

_id_9081E2D33D0B53F9() {
  if(getdvarint("scr_game_aiagentsinmp", 0) == 1) {
    level._id_D0D511BA6517842A = 1;

    if(getdvarint("scr_game_aispawnondeath", 0) == 1) {
      level._id_5DF506226294AA65 = ::_id_5DF506226294AA65;
      level._id_484F1A4BDB5CDA1E = ::_id_484F1A4BDB5CDA1E;
    }

    level thread _id_7ABA1069126EB717();
    scripts\engine\utility::flag_init("stealth_enabled");
    scripts\engine\utility::flag_init("level_stealth_initialized");
    scripts\engine\utility::flag_init("stealth_spotted");
  }
}

_id_7ABA1069126EB717() {
  level._id_72E8A99508B7BE1B = getdvarint("dvar_742EC92F3F5C3B41", 12);
  _id_48814951E916AF89::init();

  if(!isDefined(level.difficultytype))
    level _id_48814951E916AF89::_id_C8393014DD7F8AB6();

  scripts\cp_mp\utility\script_utility::registersharedfunc("ai", "dropLootOnAgentDeath", ::_id_9A4C44116474133A);

  while(!isDefined(level.teamnamelist))
    waitframe();

  foreach(team in level.teamnamelist) {
    _id_B5B1784D5A1327C7 = team + "_agents";
    _id_48814951E916AF89::_id_BA4022744DCE59F6(_id_B5B1784D5A1327C7, level._id_72E8A99508B7BE1B);
  }
}

_id_5DF506226294AA65(victim, attacker) {
  if(victim.deaths % 5 == 0)
    victim._id_8308E73A11DCA140 = 1;

  _id_B5B1784D5A1327C7 = victim.team + "_agents";
  _id_3D2E4B298E935C8D = _id_48814951E916AF89::_id_9368FB9261E4CD0A(_id_B5B1784D5A1327C7);
  _id_0644D90DE7685F75 = level._id_72E8A99508B7BE1B - _id_3D2E4B298E935C8D;

  if(_id_0644D90DE7685F75 <= 0) {
    return;
  }
  goalpos = undefined;
  spawnpoint = victim[[level.getspawnpoint]]();
  team = victim.team;
  wait 0.15;

  if(isDefined(spawnpoint)) {
    if(isDefined(attacker))
      goalpos = attacker.origin;
    else
      goalpos = spawnpoint.origin;

    if(istrue(victim._id_8308E73A11DCA140)) {
      _id_40E875A042B82875 = getdvarint("dvar_04EC508AA0002244", 1);

      if(_id_40E875A042B82875 > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40E875A042B82875; _id_AC0E594AC96AA3A8++) {
          agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", spawnpoint.origin, spawnpoint.angles, "absolute", _id_B5B1784D5A1327C7, "jugg", _id_B5B1784D5A1327C7, team);

          if(isDefined(agent)) {
            agent thread _id_35C195DF2BA46725(agent, team);
            _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
            agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, goalpos);
            agent.doavoidanceblocking = 0;
          }
        }
      }

      victim._id_8308E73A11DCA140 = undefined;
    } else {
      numagents = getdvarint("dvar_65D94DDFEF09716A", 1);

      if(numagents > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
          aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
          agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnpoint.origin, spawnpoint.angles, "absolute", _id_B5B1784D5A1327C7, "jugg", _id_B5B1784D5A1327C7, team);

          if(isDefined(agent)) {
            agent thread _id_35C195DF2BA46725(agent, team);
            agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, goalpos);

            if(team == "allies")
              agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1");
            else
              agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_spetsnaz_cqc", "head_spetsnaz_cqc");

            agent.doavoidanceblocking = 0;
          }
        }
      }
    }
  }
}

_id_35C195DF2BA46725(agent, team) {
  waitframe();
  agent.gameskill = _id_53DA3333B83B3527::get_gameskill();
  agent _id_53DA3333B83B3527::apply_difficulty_settings(1);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "team", team);
}

_id_DF3E6EE36363E610(agent) {
  if(agent.team == "axis") {
    body = "body_spetsnaz_cqc";
    head = "head_spetsnaz_cqc";
  } else {
    body = "body_mp_eastern_geist_1_1_lod1";
    head = "head_mp_eastern_bale_1_1";
  }

  weapon = undefined;
  _id_A664AAD02EE98BD2 = _id_371B4C2AB5861E62::_id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_CE85F7CC40B562F5", 0);
  armor = 0;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor);
  agent.baseaccuracy = getdvarfloat("dvar_949A1D9903E71C7A", 0.4);
}

_id_9A4C44116474133A(agent, _id_DCF5E15C58C4152A, groupname) {
  agent notify("endLootDropThread");
  agent endon("endLootDropThread");
  agent waittill("death");
  agent[[level.weapondropfunction]](scripts\engine\utility::ter_op(isDefined(self.attacker), self.attacker, undefined), scripts\engine\utility::ter_op(isDefined(self.damagemod), self.damagemod, "MOD_RIFLE_BULLET"));
}

_id_484F1A4BDB5CDA1E(attacker, victim) {
  score = level.scoremod["kill"];

  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(attacker) || scripts\mp\utility\game::_id_E9F3A160BBEFE208(victim)) {
    if(scripts\mp\utility\game::matchmakinggame() && isDefined(attacker.cranked)) {
      if(score != 0) {
        score = score + 1;
        attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", score));
      }
    }

    attacker scripts\mp\cranked::oncranked(victim, attacker);
  }

  if(score != 0) {
    if(level.teambased)
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    else
      attacker scripts\mp\gamescore::giveplayerscore("stat_EF9582D72160F199", score, victim);
  }
}

_id_36532A1506F2C161() {
  _id_EC3DE47AC260EA33 = undefined;

  if(getDvar("ui_gametype") == "arena") {
    objmodifier = 0;

    if(isusingmatchrulesdata())
      objmodifier = getmatchrulesdata("arenaData", "objModifier");
    else
      objmodifier = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 3);

    if(objmodifier == 3)
      _id_EC3DE47AC260EA33 = 1;
  }

  level._id_C3A5ECC6DB827A75 = 0;
  matchmakingmatch = getdvarint("onlinegame") && !getdvarint("xblive_privatematch");

  if(matchmakingmatch)
    level._id_C3A5ECC6DB827A75 = getdvarint("dvar_750E151E9A3727E7", 0);

  if(level._id_C3A5ECC6DB827A75 || istrue(_id_EC3DE47AC260EA33)) {
    _id_E55C6985B99A0D78();
    level.setupsoccerball = ::setupsoccerball;
    level thread[[level.setupsoccerball]]();
    level thread scripts\mp\utility\entity::global_physics_sound_monitor();

    if(getdvarint("dvar_C8724EBC0F08EC3E", 1) == 1) {
      _id_DAED1651833FB1A2();
      level _id_08F38B7A29DAD82F();

      if(getdvarint("dvar_71C708CA0182656B", 3) > 0) {
        if(!isDefined(game["multiBall"]))
          game["multiBall"] = 0;
      }
    }
  } else
    level._id_C3A5ECC6DB827A75 = undefined;

  if(getdvarint("dvar_CE8358082DFAB9E9", 0) == 1) {
    level._id_B6E1C0B3C715B0DF["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
    level._id_DD7AF80C3EB2C1E0 = 1;
  }
}

setupsoccerball() {
  level._id_1B6B55EFA67BA7A8 = [];
  _id_22CE7236B68B2334 = [];
  spawnpos = undefined;

  if(scripts\mp\utility\game::getgametype() == "arena") {
    arenaflag = getEntArray("flag_arena", "targetname");
    spawnpos = arenaflag[0].origin + (0, 0, 30);
  } else {
    _id_22CE7236B68B2334 = [];
    primaryflags = getEntArray("flag_primary", "targetname");

    foreach(flag in primaryflags) {
      if(flag.script_label == "_b") {
        _id_22CE7236B68B2334[_id_22CE7236B68B2334.size] = flag.origin;
        break;
      }
    }

    if(_id_22CE7236B68B2334.size == 0) {
      return;
    }
    _id_22CE7236B68B2334 = scripts\engine\utility::array_randomize(_id_22CE7236B68B2334);
    spawnpos = _id_22CE7236B68B2334[0];

    if(getDvar("ui_mapname") == "mp_firingrange")
      spawnpos = (-194, -858, 90);
  }

  _id_288D5564A47D230A = [];
  _id_58553518A66CEBE9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in _id_58553518A66CEBE9)
  _id_288D5564A47D230A[_id_288D5564A47D230A.size] = trig.origin;

  level._id_288D5564A47D230A = _id_288D5564A47D230A;
  _id_2C677CECD807F43E = undefined;

  if(getdvarint("dvar_23E676668434D769", 0) == 1 && _id_288D5564A47D230A.size > 0) {
    _id_2C677CECD807F43E = 1;
    _id_22CE7236B68B2334 = scripts\engine\utility::array_combine(_id_22CE7236B68B2334, _id_288D5564A47D230A);
    _id_22CE7236B68B2334 = scripts\engine\utility::array_randomize(_id_22CE7236B68B2334);
    spawnpos = _id_22CE7236B68B2334[0];
  }

  level thread _id_EC48A99C32F94620(spawnpos, 1);
}

_id_EC48A99C32F94620(spawnpos, waittime) {
  if(isDefined(waittime))
    wait(waittime);

  tracestart = spawnpos + (0, 0, 64);
  _id_8B39E5984DA1FFAF = spawnpos + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  spawnpos = trace["position"] + (0, 0, 30);
  _id_5D055C219E88A1CB = spawnStruct();
  _id_5D055C219E88A1CB.angles = (0, 0, 0);
  _id_5D055C219E88A1CB.visuals = spawn("script_model", spawnpos);
  _id_5D055C219E88A1CB.visuals setModel("art_stadium_ball");
  _id_5D055C219E88A1CB.visuals dontinterpolate();
  _id_5D055C219E88A1CB.resetposition = spawnpos;
  _id_5D055C219E88A1CB._id_2BBF24623E85009B = 1;
  _id_5D055C219E88A1CB.onreset = ::onsoccerballreset;
  _id_5D055C219E88A1CB._id_7AB15A1BE4CB821B = ::_id_7AB15A1BE4CB821B;
  _id_5D055C219E88A1CB._id_5C83A6B4C46D2FF5 = ::_id_AD9983F20F50CF14;
  angles = (0, 30, 0);
  up = anglestoup(angles);
  forward = anglesToForward(angles);

  if(getDvar("ui_mapname") == "mp_m_stadium")
    _id_F8048727716242B0 = up * 500 + (0, 0, 80);
  else
    _id_F8048727716242B0 = up * 50 + (0, 0, 80);

  waittillframeend;
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_5D055C219E88A1CB.visuals physicslaunchserver(_id_5D055C219E88A1CB.visuals.origin, _id_F8048727716242B0);
  _id_5D055C219E88A1CB thread outofboundswatcher();
  _id_5D055C219E88A1CB thread _id_5E8D33789DD33052();

  if(getdvarint("dvar_C8724EBC0F08EC3E", 1) == 1)
    _id_5D055C219E88A1CB thread _id_A21AD1174231D156();

  if(isDefined(_id_5D055C219E88A1CB._id_5C83A6B4C46D2FF5))
    _id_5D055C219E88A1CB[[_id_5D055C219E88A1CB._id_5C83A6B4C46D2FF5]]();

  level._id_1B6B55EFA67BA7A8[level._id_1B6B55EFA67BA7A8.size] = _id_5D055C219E88A1CB;
}

_id_AD9983F20F50CF14() {
  self.visuals thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals, ::ball_impact_sounds);
}

ball_impact_sounds(_id_C92EF281C1D335FC, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, _id_0B941BAEEBCA428D) {
  _id_212A44A5393C3B34 = _id_C92EF281C1D335FC physics_getbodyid(0);
  vel = physics_getbodylinvel(_id_212A44A5393C3B34);
  _id_324845ADC7297688 = length(vel);

  if(isDefined(_id_C92EF281C1D335FC.playing_sound) || _id_324845ADC7297688 < 70) {
    return;
  }
  _id_C92EF281C1D335FC endon("death");
  _id_C92EF281C1D335FC.playing_sound = 1;
  _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
  surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

  if(surfacetype == "user_terrain1")
    _id_C92EF281C1D335FC playSound("soc_ball_bounce_small");
  else if(_id_324845ADC7297688 < 180)
    _id_C92EF281C1D335FC playsurfacesound("soc_ball_bounce_small", surfacetype);
  else if(_id_324845ADC7297688 < 260)
    _id_C92EF281C1D335FC playsurfacesound("soc_ball_bounce_med", surfacetype);
  else
    _id_C92EF281C1D335FC playsurfacesound("soc_ball_bounce_large", surfacetype);

  wait 0.1;
  _id_C92EF281C1D335FC.playing_sound = undefined;
}

onsoccerballreset(_id_8FA61D7D6CED991D) {
  self.ignorereset = 1;

  if(!istrue(_id_8FA61D7D6CED991D)) {
    wait 0.5;
    self.visuals playSound("soc_ball_vanish");
    playFX(level._id_F851D61F84F9A7B9["vanish"], self.visuals.origin);
  } else {
    wait 0.1;
    playFX(level._id_F851D61F84F9A7B9["vanish"], self.visuals.origin);
  }

  self.visuals hide();
  wait 1;
  self.visuals.origin = self.resetposition;
  angles = (0, 30, 0);
  up = anglestoup(angles);
  forward = anglesToForward(angles);

  if(level.mapname == "mp_m_stadium")
    _id_F8048727716242B0 = up * 500 + (0, 0, 80);
  else
    _id_F8048727716242B0 = up * 50 + (0, 0, 80);

  self.visuals show();
  self.visuals physicslaunchserver(self.visuals.origin, _id_F8048727716242B0);
  self.ignorereset = 0;

  if(isDefined(self._id_5C83A6B4C46D2FF5))
    self[[self._id_5C83A6B4C46D2FF5]]();
}

_id_7AB15A1BE4CB821B(goal) {
  if(istrue(self.ignorereset)) {
    self.ignorereset = 0;
    return;
  }

  if(game["switchedsides"]) {
    _id_200A113A1E7807EB = scripts\mp\utility\game::getotherteam(goal.team)[0];

    if(_id_200A113A1E7807EB == "allies") {
      game["axisGoals"]++;
      _id_2724EA192F3E906D = "goal_1";
    } else {
      game["alliesGoals"]++;
      _id_2724EA192F3E906D = "goal_2";
    }
  } else {
    _id_200A113A1E7807EB = goal.team;

    if(_id_200A113A1E7807EB == "allies") {
      game["alliesGoals"]++;
      _id_2724EA192F3E906D = "goal_2";
    } else {
      game["axisGoals"]++;
      _id_2724EA192F3E906D = "goal_1";
    }
  }

  if(isDefined(_id_2724EA192F3E906D))
    scripts\engine\utility::exploder(_id_2724EA192F3E906D);

  _id_CD96AFF84BCC3247 = "tv_goal";

  if(isDefined(_id_CD96AFF84BCC3247))
    scripts\engine\utility::exploder(_id_CD96AFF84BCC3247);

  goal._id_4F853E8E6740B229++;
  level _id_2CEFFEF2D682C49E(goal);
  goal thread _id_F0B4B85FD224BCE2();

  if(scripts\mp\utility\game::getgametype() == "arena") {
    foreach(player in level.players) {
      if(player.team == _id_200A113A1E7807EB) {
        if(player.team == "allies")
          player thread _id_B6B6CAB8242EB686("dx_mpa_rutl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_them");
        else
          player thread _id_B6B6CAB8242EB686("dx_mpa_uktl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_them");

        continue;
      }

      if(player.team == "allies") {
        player thread _id_B6B6CAB8242EB686("dx_mpa_uktl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_us");
        continue;
      }

      player thread _id_B6B6CAB8242EB686("dx_mpa_rutl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_us");
    }
  } else {
    foreach(player in level.players) {
      if(player.team == "allies") {
        player thread _id_B6B6CAB8242EB686("dx_mpa_uktl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_us");
        continue;
      }

      player thread _id_B6B6CAB8242EB686("dx_mpa_rutl_summer_game_goal" + scripts\engine\utility::random(level._id_17B1839CA513E9BA), "summer_game_goal", 2, "soccer_goal_us");
    }
  }

  self.visuals thread _id_F0F8E34F2D693727();
  _id_915E8FB432A95DFB = self.visuals getlinkedchildren();

  foreach(item in _id_915E8FB432A95DFB) {
    if(isDefined(item))
      item unlink(1);
  }

  if(isDefined(self.onreset))
    self thread[[self.onreset]](1);

  if(goal._id_4F853E8E6740B229 >= 10 && isDefined(game["multiBall"]) && !game["multiBall"] || getdvarint("dvar_9FC6CEDB80CFD5F7", 0) == 1 && isDefined(game["multiBall"]) && !game["multiBall"]) {
    game["multiBall"] = 1;

    foreach(player in level.players)
    player thread scripts\mp\hud_message::showsplash("soccer_multiball");

    if(level._id_288D5564A47D230A.size > 0) {
      _id_5523D1E44F1BEB9C = getdvarint("dvar_71C708CA0182656B", 3);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5523D1E44F1BEB9C; _id_AC0E594AC96AA3A8++)
        _id_EC48A99C32F94620(level._id_288D5564A47D230A[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_F0F8E34F2D693727() {
  self playSound("soc_ball_explode");
  wait 1.5;
  self playSound("soc_ball_goal_music");
}

_id_F0B4B85FD224BCE2(_id_578A7FA223BECDE2, waittime) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < min(self._id_4F853E8E6740B229, 10); _id_AC0E594AC96AA3A8++) {
    playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], self.trigger.origin + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-25, 60)), anglesToForward(self.trigger.angles + (randomintrange(int(max(clamp(0 - _id_AC0E594AC96AA3A8 * 5, -19, 0), -20)), int(min(20, 1 + _id_AC0E594AC96AA3A8 * 5))), randomintrange(int(max(clamp(0 - _id_AC0E594AC96AA3A8 * 5, -19, 0), -20)), int(min(20, 1 + _id_AC0E594AC96AA3A8 * 5))), 0)), anglestoup(self.trigger.angles + (randomintrange(int(max(clamp(0 - _id_AC0E594AC96AA3A8 * 5, -19, 0), -20)), int(min(20, 1 + _id_AC0E594AC96AA3A8 * 5))), randomintrange(int(max(clamp(0 - _id_AC0E594AC96AA3A8 * 5, -19, 0), -20)), int(min(20, 1 + _id_AC0E594AC96AA3A8 * 5))), 0)));

    if(istrue(_id_578A7FA223BECDE2))
      level thread _id_2C3362A9F434FD8D(self.trigger.origin);

    if(isDefined(waittime))
      wait(waittime);
  }
}

_id_2CEFFEF2D682C49E(goal) {
  foreach(struct in level._id_8BA3A46D0F5089A4) {
    if(struct._id_A160EB484AC5E768 == goal.team) {
      if(goal._id_4F853E8E6740B229 >= 10) {
        struct.scriptable setscriptablepartstate("score", "10");
        continue;
      }

      struct.scriptable setscriptablepartstate("score", "0" + scripts\engine\utility::string(goal._id_4F853E8E6740B229));
    }
  }
}

outofboundswatcher() {
  level endon("game_ended");

  for(;;) {
    wait 0.5;

    if(istrue(self.ignorereset)) {
      continue;
    }
    if(isDefined(self.resetnow)) {
      self.resetnow = undefined;

      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(index = 0; index < level.radtriggers.size; index++) {
      if(!self.visuals istouching(level.radtriggers[index])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(index = 0; index < level.minetriggers.size; index++) {
      if(!self.visuals istouching(level.minetriggers[index])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(index = 0; index < level.hurttriggers.size; index++) {
      if(!self.visuals istouching(level.hurttriggers[index])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    if(istrue(level.ballallowedtriggers.size)) {
      self.allowedintrigger = 0;

      foreach(trigger in level.ballallowedtriggers) {
        if(self.visuals istouching(trigger)) {
          self.allowedintrigger = 1;
          break;
        }
      }
    }

    if(isDefined(level.outofboundstriggers)) {
      foreach(trigger in level.outofboundstriggers) {
        if(istrue(self.allowedintrigger)) {
          break;
        }

        if(!self.visuals istouching(trigger)) {
          continue;
        }
        if(isDefined(self.onreset))
          self thread[[self.onreset]]();

        continue;
      }
    }

    if(isDefined(self.autoresettime)) {
      wait(self.autoresettime);

      if(!isDefined(self.carrier)) {
        if(isDefined(self.onreset))
          self thread[[self.onreset]]();
      }
    }
  }
}

_id_5E8D33789DD33052() {
  level endon("game_ended");

  for(;;) {
    wait 0.25;

    if(istrue(self.ignorereset)) {
      continue;
    }
    if(distancesquared(self.visuals.origin, self.resetposition) > 9000000) {
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();
    }
  }
}

_id_08F38B7A29DAD82F() {
  _id_1D564BE0354953B0 = getEntArray("allies_goal", "targetname");
  _id_9F9CBF678FD4238D = getEntArray("axis_goal", "targetname");

  if(_id_1D564BE0354953B0.size > 0 && _id_9F9CBF678FD4238D.size > 0) {
    level._id_758EA12ADC8B098C = spawnStruct();
    level._id_758EA12ADC8B098C.team = "allies";
    level._id_758EA12ADC8B098C.trigger = _id_1D564BE0354953B0[0];
    level._id_758EA12ADC8B098C.entsinside = [];
    level._id_FE3A223CE9F0DC43 = spawnStruct();
    level._id_FE3A223CE9F0DC43.team = "axis";
    level._id_FE3A223CE9F0DC43.trigger = _id_9F9CBF678FD4238D[0];
    level._id_FE3A223CE9F0DC43.entsinside = [];
    level._id_FE3A223CE9F0DC43._id_4F853E8E6740B229 = 0;

    if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      game["alliesGoals"] = 0;
      level._id_758EA12ADC8B098C._id_4F853E8E6740B229 = 0;
      game["axisGoals"] = 0;
      level._id_FE3A223CE9F0DC43._id_4F853E8E6740B229 = 0;
    } else if(game["switchedsides"]) {
      level._id_FE3A223CE9F0DC43._id_4F853E8E6740B229 = game["alliesGoals"];
      level._id_758EA12ADC8B098C._id_4F853E8E6740B229 = game["axisGoals"];
    } else {
      level._id_758EA12ADC8B098C._id_4F853E8E6740B229 = game["alliesGoals"];
      level._id_FE3A223CE9F0DC43._id_4F853E8E6740B229 = game["axisGoals"];
    }

    level._id_6FFD40B85F9BDC80 = [level._id_FE3A223CE9F0DC43, level._id_758EA12ADC8B098C];
    level thread _id_C3DE6082AD64DC54();
  } else
    level notify("stop_soccer_goal");
}

_id_C3DE6082AD64DC54() {
  wait 1;
  level._id_3FF95947A34D0317 = scripts\engine\utility::getStructArray("home", "targetname");
  level._id_F8C5A6F236996C7C = scripts\engine\utility::getStructArray("away", "targetname");
  level._id_8BA3A46D0F5089A4 = scripts\engine\utility::array_combine(level._id_3FF95947A34D0317, level._id_F8C5A6F236996C7C);

  foreach(struct in level._id_3FF95947A34D0317) {
    struct.scriptable = spawn("script_model", struct.origin);
    struct.scriptable.angles = struct.angles;
    struct.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    struct._id_A160EB484AC5E768 = "allies";
  }

  foreach(struct in level._id_F8C5A6F236996C7C) {
    struct.scriptable = spawn("script_model", struct.origin);
    struct.scriptable.angles = struct.angles;
    struct.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    struct._id_A160EB484AC5E768 = "axis";
  }

  level _id_2CEFFEF2D682C49E(level._id_758EA12ADC8B098C);
  level _id_2CEFFEF2D682C49E(level._id_FE3A223CE9F0DC43);
}

_id_A21AD1174231D156(_id_633ED0D009B54036) {
  level endon("game_ended");
  level endon("stop_soccer_goal");

  while(!isDefined(level._id_6FFD40B85F9BDC80))
    waitframe();

  for(;;) {
    wait 0.05;

    if(istrue(self.ignorereset)) {
      continue;
    }
    for(index = 0; index < level._id_6FFD40B85F9BDC80.size; index++) {
      if(!_id_6A55687E0AC4A408(level._id_6FFD40B85F9BDC80[index], self.visuals)) {
        continue;
      }
      if(!_id_4D41453B43A4E638(level._id_6FFD40B85F9BDC80[index], self.visuals)) {
        continue;
      }
      entnum = self.visuals getentitynumber();
      level._id_6FFD40B85F9BDC80[index].entsinside[entnum] = self.visuals;
      self.visuals._id_D98176DB59CCA89A = level._id_6FFD40B85F9BDC80[index];

      if(isDefined(self._id_7AB15A1BE4CB821B))
        [[self._id_7AB15A1BE4CB821B]](level._id_6FFD40B85F9BDC80[index]);

      continue;
    }
  }
}

_id_4D41453B43A4E638(_id_633ED0D009B54036, ent) {
  entnum = ent getentitynumber();

  if(isDefined(_id_633ED0D009B54036.entsinside[entnum]))
    return 0;

  return 1;
}

_id_6A55687E0AC4A408(_id_633ED0D009B54036, ent) {
  if(!ent istouching(_id_633ED0D009B54036.trigger)) {
    entnum = ent getentitynumber();
    _id_633ED0D009B54036.entsinside[entnum] = undefined;

    if(isDefined(ent._id_D98176DB59CCA89A) && ent._id_D98176DB59CCA89A == _id_633ED0D009B54036)
      ent._id_D98176DB59CCA89A = undefined;

    return 0;
  }

  return 1;
}

_id_2C3362A9F434FD8D(origin) {
  sound = "gos_firework_scream_sfx";
  playsoundatpos(origin, sound);
  _id_1499E7C2D69E0074 = lookupsoundlength(sound);
  wait 1.5;
  playsoundatpos(origin + (0, 0, 600), "gos_firework_explo_sfx");
}

_id_E55C6985B99A0D78() {
  level._id_B6E1C0B3C715B0DF["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
  level._id_F851D61F84F9A7B9["vanish"] = loadfx("vfx/iw8_mp/gamemode/vfx_soccer_ball_burst.vfx");
  level._id_F851D61F84F9A7B9["score_00"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_00.vfx");
  level._id_F851D61F84F9A7B9["score_01"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_01.vfx");
  level._id_F851D61F84F9A7B9["score_02"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_02.vfx");
  level._id_F851D61F84F9A7B9["score_03"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_03.vfx");
  level._id_F851D61F84F9A7B9["score_04"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_04.vfx");
  level._id_F851D61F84F9A7B9["score_05"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_05.vfx");
  level._id_F851D61F84F9A7B9["score_06"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_06.vfx");
  level._id_F851D61F84F9A7B9["score_07"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_07.vfx");
  level._id_F851D61F84F9A7B9["score_08"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_08.vfx");
  level._id_F851D61F84F9A7B9["score_09"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_09.vfx");
  level._id_F851D61F84F9A7B9["score_10"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_10.vfx");
}

_id_DAED1651833FB1A2() {
  game["dialog"]["summer_game_goal_1"] = "summer_game_goal_1";
  game["dialog"]["summer_game_goal_2"] = "summer_game_goal_2";
  game["dialog"]["summer_game_goal_3"] = "summer_game_goal_3";
  level._id_17B1839CA513E9BA = ["_1", "_2", "_3"];
}

_id_B6B6CAB8242EB686(dialog, _id_D653377138D5EFF2, time, _id_1B4ADA49A21B51CA) {
  self notify("goal_scored");
  self endon("goal_scored");

  if(!isDefined(level.lastteamstatustime["allies"][_id_D653377138D5EFF2]))
    level.lastteamstatustime["allies"][_id_D653377138D5EFF2] = 0;

  if(gettime() < level.lastteamstatustime["allies"][_id_D653377138D5EFF2] + time * 1000) {
    return;
  }
  self queuedialogforplayer(dialog, _id_D653377138D5EFF2, time);
  level.lastteamstatustime["allies"][_id_D653377138D5EFF2] = gettime();
  thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA);
}

snowballfighthint() {
  self endon("death");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/PRACTICE_ROUND", 5);
    wait 6;
    scripts\mp\flags::gameflagwait("prematch_done");
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
  } else
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
}

_id_030DD74B21BFFFE6() {
  if(getdvarint("dvar_A88F1329561BC6E1", 0) > 0) {
    level._id_8CE8010175FB9787 = getdvarint("dvar_A88F1329561BC6E1", 0);
    level thread randomcarepackagedrops();
  }
}

randomcarepackagedrops() {
  level endon("game_ended");
  level._id_E1619C97E3FD8A87 = [];
  level thread _id_49E45907B10122E4();
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_done");
  wait(level._id_8CE8010175FB9787);
  level.grnd_previouscratetypes = [];

  for(;;) {
    owner = undefined;
    _id_4440147083ABAF0A = 1;

    if(scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + _id_4440147083ABAF0A < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      cratetype = getdropzonecratetype();
      position = _id_043C1D665B215618();

      if(!isDefined(position)) {
        return;
      }
      if(cratetype == "mega") {
        streakinfo = spawnStruct();
        streakinfo.cratetype = undefined;
        streakinfo.numcrates = undefined;
        streakinfo.usephysics = undefined;
        streakinfo.streakname = "airdrop_multiple";
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(owner, undefined, position, randomfloat(360), position, 1, streakinfo);
      } else {
        vehicleisreserved = scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(owner, undefined, cratetype, position, randomfloat(360), position, vehicleisreserved);
      }

      waittime = level._id_8CE8010175FB9787;
    } else
      waittime = 0.5;

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
  }
}

getdropzonecratetype() {
  cratetype = undefined;

  if(!isDefined(level.grnd_previouscratetypes["mega"]) && randomintrange(0, 100) < 5)
    cratetype = "mega";
  else {
    if(level.grnd_previouscratetypes.size) {
      for(_id_2C28BA9A9A351DC6 = 200; _id_2C28BA9A9A351DC6; _id_2C28BA9A9A351DC6--) {
        cratetype = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level.grnd_previouscratetypes[cratetype])) {
          cratetype = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(cratetype))
      cratetype = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
  }

  level.grnd_previouscratetypes[cratetype] = 1;

  if(level.grnd_previouscratetypes.size == 15)
    level.grnd_previouscratetypes = [];

  return cratetype;
}

_id_043C1D665B215618() {
  dropposition = level._id_E1619C97E3FD8A87[0];
  level._id_E1619C97E3FD8A87[level._id_E1619C97E3FD8A87.size] = level._id_E1619C97E3FD8A87[0];
  level._id_E1619C97E3FD8A87[0] = undefined;
  level._id_E1619C97E3FD8A87 = scripts\engine\utility::array_removeundefined(level._id_E1619C97E3FD8A87);
  return dropposition;
}

_id_49E45907B10122E4() {
  switch (level.mapname) {
    case "mp_downtown_gw":
      level._id_E1619C97E3FD8A87 = [(21298, -15989, 1970), (22131, -18582, 690), (17264, -17920, 1066), (16682, -23069, 230), (21664, -23061, -108), (16208, -13686, -158), (19920, -18069, 157), (25150, -17449, -150), (27173, -14625, -200), (22696, -12784, -158), (22115, -12162, -106), (22278, -10595, 1610), (19963, -14131, 149), (20019, -11243, -194), (16711, -8999, -326), (15772, -5966, -390), (15501, -1873, -446), (19760, -1172, -449), (20464, -2047, -450), (23814, -5888, -382), (26210, -9404, -318), (30288, -8981, -358), (20781, -7208, -366), (18773, -13037, 9), (20091, -21421, -78), (23574, -14769, -134)];
      break;
    case "mp_quarry2":
      level._id_E1619C97E3FD8A87 = [(25008, 32313, 826), (29171, 32156, 659), (25021, 37011, 841), (30305, 35572, 526), (30779, 33427, 1009), (28913, 38886, 888), (25888, 40248, 1680), (27533, 43285, 1792), (31199, 37768, 722), (33534, 35968, 1103), (34872, 33255, 664), (33704, 39718, 1395), (35903, 39512, 879), (32265, 46424, 1450), (35084, 43008, 960), (38700, 43064, 1087), (36348, 44694, 481), (34805, 48469, 1317), (32313, 39712, 767)];
      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      level._id_E1619C97E3FD8A87 = [(51478, -24749, -55), (50222, -21762, -335), (46165, -20091, -409), (49089, -18057, -359), (54074, -16693, -307), (52289, -14523, -335), (48361, -13952, -1), (43445, -16524, -405), (43634, -13100, -51), (47714, -14136, 141), (50498, -12784, -199), (53744, -11930, -510), (52284, -7268, -672), (49723, -7122, 438), (47540, -10295, 266), (48403, -7548, 291), (53225, -3832, -456), (49419, -4336, 141), (49419, -4336, 141), (47101, -1784, 116), (43600, -3193, 340), (42522, -6972, 30), (45959, -5516, 328), (46058, -8625, 136)];
      break;
    case "mp_port2_gw":
      level._id_E1619C97E3FD8A87 = [(40724, -13376, -58), (37115, -14577, -152), (35766, -19268, -508), (38572, -18749, -508), (42023, -19947, -500), (40116, -25824, -247), (38056, -23083, 240), (35024, -24401, -508), (36958, -26270, -112), (36264, -28611, -36), (38229, -28438, -452), (38304, -30376, -172), (33276, -26940, -116), (30526, -27712, -508), (29810, -29730, -508), (33689, -28898, -507), (36498, -33452, -508), (37219, -37142, -506), (34863, -34724, -318), (34304, -36576, -506), (31116, -35074, -508), (32797, -32582, -372)];
      break;
    case "mp_boneyard_gw":
      level._id_E1619C97E3FD8A87 = [(-28661, -17966, -177), (-30406, -15324, -159), (-26858, -14816, 3), (-26567, -8261, 17), (-23466, -14624, -12), (-24687, -11527, 238), (-24492, -10369, 148), (-25965, -11096, 27), (-29884, -12919, -43), (-30458, -10020, -136), (-28564, -9301, 248), (-29994, -6709, -208), (-28156, -5883, -119), (-30522, -3889, -247), (-28220, -3171, -255), (-25333, -4300, -242), (-28106, -1937, -255), (-30823, -2351, -248), (-29121, -11011, -61)];
      break;
    case "mp_aniyah":
      level._id_E1619C97E3FD8A87 = [(2716, -158, 708), (8215, 874, 342), (6524, 1561, 316), (5827, -860, 357), (4268, -47, 452), (2305, -1994, 386), (5172, 2587, 231), (2691, 3096, 302), (-910, 3497, 318), (-3579, -544, 320), (2591, 1659, 545), (1033, -514, 447), (-93, -2789, 169), (-1301, 924, 315), (-2843, 2779, 316)];
      break;
    default:
      level._id_E1619C97E3FD8A87 = getcoremapdropzones();
      break;
  }

  level._id_E1619C97E3FD8A87 = scripts\engine\utility::array_randomize(level._id_E1619C97E3FD8A87);
}

getcoremapdropzones() {
  _id_BC115BC1BAC87A51 = [];
  _id_261D73DEE9F7F35C = getEntArray("grnd", "targetname");

  if(level.mapname == "mp_shipment") {
    _id_49E04F87F5702F8C = [];

    foreach(trig in _id_261D73DEE9F7F35C) {
      if(trig.script_label == "1" && distance(trig.origin, (-333, 1999, 119)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "2" && distance(trig.origin, (189, 1564, 75)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "3" && distance(trig.origin, (-751, 2416, 81)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "4" && distance(trig.origin, (165, 2420, 79)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "5" && distance(trig.origin, (-823, 1536, 68)) < 5)
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
    }

    _id_261D73DEE9F7F35C = scripts\engine\utility::array_remove_array(_id_261D73DEE9F7F35C, _id_49E04F87F5702F8C);
  }

  if(_id_261D73DEE9F7F35C.size > 0) {
    foreach(trig in _id_261D73DEE9F7F35C)
    _id_BC115BC1BAC87A51[_id_BC115BC1BAC87A51.size] = trig.origin;
  }

  return _id_BC115BC1BAC87A51;
}

_id_89D441B8CCA6251D() {
  return isDefined(level._id_8CE8010175FB9787) && level._id_8CE8010175FB9787 > 0;
}

_id_52343D5C1B190CF0() {
  level._id_12226443217B5474 = getdvarint("dvar_127490A7577F169F", 0);
  level._id_EE05489A095DF4D1 = getdvarint("dvar_509B01D1370107AF", 0) == 1;
  level._id_11D8636343EAE20C = getdvarint("dvar_E05A6970966D8552", 0);
  level._id_0ACCB27010DAA82D = getdvarint("dvar_4A592B7D1EFA862D", 0);
  level._id_1921CB8DD51A8F73 = getdvarint("dvar_4C748C9425636394", 0);
  level.testrandomrealismclients = getdvarint("dvar_596700A25033A832", 0) == 1;
  setomnvar("ui_realism_mode", scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924());

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

    setDvar("jump_slowdownenable", 1);
    setDvar("sprintleap_enabled", 0);

    if(!scripts\mp\spawnselection::_id_167619FE3D0CFF00())
      level.disablespawncamera = 1;

    if(istrue(level._id_1921CB8DD51A8F73)) {
      level._id_26109C02A53CEA84 = [];
      level._id_26109C02A53CEA84["rocketlauncher"] = getdvarfloat("dvar_02B6CEEF99F7C775", 0.75);
      level._id_26109C02A53CEA84["sniper"] = getdvarfloat("dvar_02B2AAEF99F38272", 0.8);
      level._id_26109C02A53CEA84["mg"] = getdvarfloat("dvar_0263C3EF999D0B4F", 0.85);
      level._id_26109C02A53CEA84["rifle"] = getdvarfloat("dvar_0274C6EF99AF1C44", 0.9);
      level._id_26109C02A53CEA84["smg"] = getdvarfloat("dvar_02B2A9EF99F3803F", 0.95);
      level._id_26109C02A53CEA84["spread"] = getdvarfloat("dvar_02B2B3EF99F3963D", 0.95);
      level._id_26109C02A53CEA84["grenade"] = getdvarfloat("dvar_027DB6EF99B917C2", 1.0);
      level._id_26109C02A53CEA84["melee"] = getdvarfloat("dvar_0263C5EF999D0FB5", 1.0);
      level._id_26109C02A53CEA84["pistol"] = getdvarfloat("dvar_02BFA5EF9A018BF8", 1.0);
    }

    if(!isusingmatchrulesdata()) {
      setDvar("scr_game_enableMinimap", 0);
      setDvar("scr_player_maxhealth", 50);
      setDvar("scr_team_fftype", 4);
      setDvar("scr_game_allowkillcam", 0);
      setDvar("scr_player_allowarmor", 0);
      setDvar("scr_player_spawnarmor", 0);
      setDvar("dvar_08AD1AB9436BCCCA", 0);
      setDvar("dvar_28D450F7F28644B7", 0);
      setDvar("scr_game_allow_loot", 0);
    }

    _id_451A1A9BD9613164::_id_8ECE37593311858A(::_id_3708850EAB3864C2);
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_3708850EAB3864C2);
  }
}

_id_3708850EAB3864C2() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(scripts\engine\utility::cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self.isrealismenabled = 1;
      } else {
        self setclientomnvar("ui_realism_hud", 0);
        self.isrealismenabled = 0;
      }
    }
  } else
    self setclientomnvar("ui_realism_hud", scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924());
}

_id_7BAC8EE72285298E() {
  _id_76A22C18960F72AF = self.origin;
  startpos = _id_76A22C18960F72AF + (0, 0, 14);
  stance = self getstance();
  zoffset = 35;

  if(stance == "prone")
    zoffset = 14;

  if(stance == "crouch")
    zoffset = 25;

  _id_9C19496CE8106E6B = _id_76A22C18960F72AF + (0, 0, zoffset);
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);
  _id_A73587155F07BD39 = randomfloatrange(30, 150);
  _id_90128D0639A1315D = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_B809B8F732448A84 = playerphysicstrace(startpos, _id_90128D0639A1315D);

  if(!isDefined(self._id_A25375A5AB23EACB)) {
    visuals = [];
    visuals[0] = spawn("script_model", _id_9C19496CE8106E6B);
    visuals[0] setModel("noglow::lm_heal_first_aid_kit_vfx");
    trigger = spawn("trigger_radius", _id_9C19496CE8106E6B, 0, 32, 32);
    trigger scripts\engine\utility::trigger_off();
    pickup = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, undefined, undefined, 1);
    pickup.onuse = ::_id_75C517D33CD52B54;
    pickup.usetime = 0;
    pickup scripts\mp\gameobjects::allowuse("any");
    pickup.owner = self;
    self._id_A25375A5AB23EACB = pickup;
    self._id_A25375A5AB23EACB thread monitordisconnect();
  } else {
    self._id_A25375A5AB23EACB.curorigin = _id_9C19496CE8106E6B;
    self._id_A25375A5AB23EACB.visuals[0].origin = _id_9C19496CE8106E6B;
    self._id_A25375A5AB23EACB.trigger.origin = _id_9C19496CE8106E6B;
  }

  self._id_A25375A5AB23EACB thread _id_5C5358EF41543DA6(_id_9C19496CE8106E6B, _id_B809B8F732448A84);

  if(level._id_0ACCB27010DAA82D > 0)
    self._id_A25375A5AB23EACB thread monitortimeout();
}

_id_5C5358EF41543DA6(startpos, endpos) {
  self endon("death");
  _id_C9DFC53C7CC5876A = (endpos - startpos) * 25;
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, _id_C9DFC53C7CC5876A);
  wait 1.0;

  if(isDefined(self.trigger) && isDefined(self.visuals[0])) {
    self.trigger.origin = self.visuals[0].origin;
    self.curorigin = self.visuals[0].origin;
    self.visuals[0] physicsstopserver();
    self.trigger scripts\engine\utility::trigger_on();
  }
}

_id_75C517D33CD52B54(player, team) {
  if(player.health <= 0 || player.health == player.maxhealth) {
    return;
  }
  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  player playsoundtoplayer("br_pickup_generic", player);
  player thread _id_427B6F3ADC1B7A7D();

  if(level._id_EE05489A095DF4D1) {
    if(level._id_11D8636343EAE20C == 0)
      player.health = player.maxhealth;
    else
      player.health = min(player.health + level._id_11D8636343EAE20C, player.maxhealth);
  } else
    player notify("force_regeneration");

  _id_5DC0C80460E6C6BB();
}

_id_427B6F3ADC1B7A7D() {
  self endon("death_or_disconnect");
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();
  _id_F344626B0E399E64 = scripts\mp\supers::issuperinuse() && isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "super_deadsilence";

  if(!_id_F344626B0E399E64)
    self lerpfovbypreset("zombiedefault");

  wait 0.5;
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();
  _id_F344626B0E399E64 = scripts\mp\supers::issuperinuse() && isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "super_deadsilence";

  if(!_id_F344626B0E399E64)
    self lerpfovbypreset("default_2seconds");
}

monitordisconnect() {
  self waittill("disconnect");
  _id_5DC0C80460E6C6BB();
}

monitortimeout() {
  self endon("death");
  self notify("monitorTimeOut");
  self endon("monitorTimeOut");
  wait(level._id_0ACCB27010DAA82D);
  _id_5DC0C80460E6C6BB();
}

_id_5DC0C80460E6C6BB() {
  if(isDefined(self.owner))
    self.owner._id_A25375A5AB23EACB = undefined;

  self.visuals[0] delete();
  scripts\mp\gameobjects::deleteuseobject();
}

_id_1513C3F71E935D73() {
  level._id_1AF27F387B8D3369 = getdvarint("dvar_A2C2C2007177185E", 0);

  if(!scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
    return;
  }
  if(!isusingmatchrulesdata()) {
    setDvar("scr_game_allowkillcam", 0);
    setDvar("scr_player_healthregentime", 0);
    setDvar("scr_player_maxhealth", 30);
    setDvar("scr_team_fftype", 4);
  }
}

_id_0417749E099F041F(_id_4DA4CB52D0BF5B05, _id_48B7B944A7A02B2C) {
  struct = spawnStruct();
  struct._id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05;
  struct._id_48B7B944A7A02B2C = _id_48B7B944A7A02B2C;

  if(!isDefined(self._id_B35C5EA3127572D8))
    self._id_B35C5EA3127572D8 = scripts\engine\utility::_id_79C374AB1CA30CC9(32);

  self._id_B35C5EA3127572D8 = scripts\engine\utility::_id_6CF786A6CF335CB9(self._id_B35C5EA3127572D8, struct);
  thread _id_8D27A912F4BC9A16();

  if(scripts\mp\utility\game::getgametype() == "gwtdm")
    thread _id_1372270AEFCDCA98();
}

_id_8D27A912F4BC9A16() {
  self endon("disconnect");
  self notify("processKillEventFeed");
  self endon("processKillEventFeed");
  waittillframeend;

  while(isDefined(self._id_B35C5EA3127572D8) && self._id_B35C5EA3127572D8.array.size > 0) {
    struct = scripts\engine\utility::_id_73D8A9394FC5EDA2(self._id_B35C5EA3127572D8);
    self._id_B35C5EA3127572D8 = scripts\engine\utility::_id_93DEF91A50927481(self._id_B35C5EA3127572D8);
    self setclientomnvar("ui_killfeed_victim_id", struct._id_48B7B944A7A02B2C);
    self setclientomnvar("ui_killfeed_data", struct._id_4DA4CB52D0BF5B05);
    self setclientomnvar("ui_killfeed_notify", gettime());
    waitframe();
  }
}

_id_1372270AEFCDCA98() {
  self endon("disconnect");
  self notify("awardBonusAfterTime");
  self endon("awardBonusAfterTime");

  if(!isDefined(self._id_A4DCDA08906719E4))
    self._id_A4DCDA08906719E4 = 0;

  self._id_A4DCDA08906719E4++;
  _id_0ABEE7F4DD68A47C = getdvarfloat("dvar_A44760277D3FE8A5", 5.0);
  wait(_id_0ABEE7F4DD68A47C);
  _id_24D22C13C6FECE21 = 0;

  if(self._id_A4DCDA08906719E4 > 15)
    _id_24D22C13C6FECE21 = 15;
  else if(self._id_A4DCDA08906719E4 > 10)
    _id_24D22C13C6FECE21 = 10;
  else if(self._id_A4DCDA08906719E4 > 7)
    _id_24D22C13C6FECE21 = 5;
  else if(self._id_A4DCDA08906719E4 > 5)
    _id_24D22C13C6FECE21 = 3;
  else if(self._id_A4DCDA08906719E4 > 3)
    _id_24D22C13C6FECE21 = 1;

  self._id_A4DCDA08906719E4 = 0;

  if(_id_24D22C13C6FECE21 == 0) {
    return;
  }
  scripts\mp\gamescore::giveteamscoreforobjective(self.team, _id_24D22C13C6FECE21, 0);

  if(getdvarint("dvar_2E405E2912DC4A44", 0) == 1)
    thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", _id_24D22C13C6FECE21));

  scripts\mp\utility\stats::incpersstat("contribution", _id_24D22C13C6FECE21);
  scripts\mp\utility\stats::setextrascore0(self.pers["contribution"]);
  _id_4DA4CB52D0BF5B05 = 0;
  _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + 6;
  _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + (_id_24D22C13C6FECE21 << 4);
  struct = spawnStruct();
  struct._id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05;
  struct._id_48B7B944A7A02B2C = -1;
  self._id_B35C5EA3127572D8 = scripts\engine\utility::_id_6CF786A6CF335CB9(self._id_B35C5EA3127572D8, struct);
  thread _id_8D27A912F4BC9A16();
}