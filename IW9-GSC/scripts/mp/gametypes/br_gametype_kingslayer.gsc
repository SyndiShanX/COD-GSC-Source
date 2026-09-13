/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_kingslayer.gsc
***********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "kingslayer") {
    return;
  }
  init();
}

init() {
  level thread _id_5A106BECAF77D864();
  level thread brking_initfeatures();
  level thread brking_initpostmain();
  level thread brking_initdialog();
  level thread brking_initexternalfeatures();
}

brking_initfeatures() {
  if(getdvarint("dvar_2F45AF91DFB7A5A0", 0) == 1)
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");

  setDvar("dvar_39A8907D7F184021", 1);
  setDvar("dvar_C0DBA6A7250AAD33", 1);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  level.forcedisablelaststand = getdvarint("dvar_B7D1EB5F054111C3", 0) == 1;
  level.giveloadouteverytime = getdvarint("dvar_2EFFF4C3F474F5C7", 1);
  level.instantbleedoutsquadwipe = getdvarint("dvar_C6ACAB01F606FF92", 1);
  level._id_4E9314220031815D = getdvarint("dvar_5B32C84486D02636", 1);
  level._id_7997826228637318 = getdvarint("dvar_5CF68437A2B713AB", 0);
  level.ks_pointstowin = getdvarint("dvar_230FE4AABF6546A1", 50);
  level.ks_pointbonusforteam = getdvarint("dvar_A410D2791FBF58D0", 1) == 1;
  level.ks_pointkingsgetnobonus = getdvarint("dvar_D577F5F614AA6BFB", 1) == 1;
  level.ks_pointsperkingslain = getdvarint("dvar_3D4C65CE5366EC58", 5);
  setDvar("dvar_5072385F6119FF87", level.ks_pointstowin);
  level.hideleaderhashuntilpercent = getdvarint("dvar_C124A7A4AFB14348", 0);
  level.dmzlootleaderupdateonpickup = getdvarint("dvar_9EFDB377E7AE2DFF", 0) == 1;
  level.showplacementsplashesandmusic = getdvarint("dvar_63908C5E06402524", 1);
  level.secondsbeforeplacementupdates = getdvarint("dvar_E616CB0E727859DD", 60);
  level.disablepercentageannouncements = getdvarint("dvar_69E6435403E5C322", 0);
  level.lootleadermarkcount = getdvarint("dvar_3ADA79B2236A5C12", 3);
  level.maxlootleadermarkcount = getdvarint("dvar_3ADA79B2236A5C12", 3);
  level.lootleadermarksize = getdvarint("dvar_1650346812659DF2", 1000);
  level.lootleaderoneperteam = getdvarint("dvar_5FD1126EC81D6B0B", 1) == 1;
  level.lootleadermarksizedynamic = getdvarint("dvar_1B7554A04B02683C", 0);
  level.lootleadermarkstrongsize = getdvarint("dvar_210471FB05950431", 2000);
  level.lootleadermarkstrongvalue = getdvarint("dvar_F53E6F6FDDBBBC11", 5000);
  level.lootleadermarkweaksize = getdvarint("dvar_FC8B22A888365974", 5000);
  level.lootleadermarkweakvalue = getdvarint("dvar_43D67F5054412E02", 1000);
  level.lootleadermarksontopteams = getdvarint("dvar_66CAF7F753F08487", 3);
  level._id_69F99BB835E36684 = getdvarint("dvar_2E8375198ED09E2A", 0);
  level.plundermusicfirst = getdvarfloat("dvar_24C7C305D1EAD986", 0.3);
  level.plundermusicsecond = getdvarfloat("dvar_3F1F73F0AEEC8FD4", 0.5);
  level.plundermusicthird = getdvarfloat("dvar_25360B6A507D1E21", 0.75);
  level.plundermusicfourth = getdvarfloat("dvar_11B704EDA4D01A78", 0.9);
  level._id_5A81CD5A6AE1C552 = getdvarfloat("dvar_3DCC41767CB14120", 20);
  level._id_ED3BBED90E848793 = [];
  level.useautorespawn = getdvarint("dvar_9EA6558E3FDC02D8", 1);
  level.autorespawnwaittime = getdvarint("dvar_4BEAC336193A373D", 1);
  level.tokenrespawnwaittime = getdvarint("dvar_728CBA7A2ADC64DB", level.autorespawnwaittime);
  level.incrementalrespawnpunish = getdvarint("dvar_FC3A0F4F0CDD615E", 0);
  level.incrementalrespawnpunishmax = getdvarfloat("dvar_5EB645F42926F53B", 15);
  level.respawnheightoverride = getdvarint("dvar_8495AD89C3580163", 5000);
  level.respawntimedisable = getdvarint("dvar_73DBC19AD4C85D57", 0);
  level.parachutedeploydelay = getdvarfloat("dvar_12027360B079C1DB", 0.5);
  level._id_94F0E9B9A73DFD18 = getdvarint("dvar_D851FF5831A4337F", 1) == 1;
  level._id_3EE36CA751BADAC8 = getdvarint("dvar_FCEF232621A4E4F1", 1) == 1;
  level._id_17DA67381DA39F91 = getdvarfloat("dvar_BC575BED6A3B9354", 0.5);
  level._id_A60EF7DB5A1859AE = getdvarfloat("dvar_EF6AE3F9FA140AB3", 0.5);
  level.skipweapondropondeath = getdvarint("dvar_8D982A8E8331B9F7", 1);
  level.skipequipmentdropondeath = getdvarint("dvar_370FB0965BAF2AD5", 1);
  level.ks_circlemovedist = getdvarint("dvar_10C20627FB5FC19D", 18000);
  level.ks_airdroppercircle = getdvarint("dvar_5ACB189FD9AE5CBF", 1);
  level.ks_airdropcrateusetime = getdvarint("dvar_34D1AA60202DB33B", 3);
  level.ks_airdropcratearmor = getdvarint("dvar_D613A3CFEB85158A", 3);
  level.ks_circlecount = getdvarint("dvar_A1A89C667F3C2E46", 20);
  level.ks_circleradius = getdvarfloat("dvar_51863E77181509FD", 10100);

  if(istrue(level._id_63A70FF2D38D8BEE))
    level.ks_circleradius = 12500;

  level.ks_circleclosetime = getdvarfloat("dvar_9595601506872564", 50);
  level.ks_circledelaytime = getdvarfloat("dvar_81044A2054D6EB77", 50);
  level.ks_circleminimapradius = getdvarint("dvar_87926F11B0DCEDA4", 4750);
  level.ks_circlemoving = getdvarint("dvar_70FBF384D2FF2B5D", 1) == 1;
  level._id_4E3F7E1ABE295225 = getdvarint("dvar_717B3F55F18C8D28", 1);
  level._id_8DC79635128DDA21 = getdvarint("dvar_720B0B024AE6A9D6", 1);
  level.modespawnendofgame = ::playerspawnendofgame;
  level.endmatchcameratransitions = getdvarint("dvar_EC4443371F0F6367", 1);
  level.topteamsever = [];
  level.lootleaders = [];
  level.called50percentprogress = 0;
  level.called75percentprogress = 0;
  level.called90percentprogress = 0;

  if(getdvarint("dvar_7379375B4C81548D", 0) == 1)
    _id_362C58E8BB39BCDA::disablefeature("kiosk");

  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("dropbag");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("missions");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");
  _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");

  if(getdvarint("dvar_1A792BD0A9A80C0B", 0) == 1)
    _id_362C58E8BB39BCDA::disablefeature("loot");

  if(getdvarint("dvar_CDE05F5F3924BE50", 0) == 1)
    _id_362C58E8BB39BCDA::disablefeature("armor");

  level.onstartgametype = ::onstartgametype;
  level.modespawnclient = ::modespawn;
  level.ononeleftevent = ::ononeleftevent;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::brking_onplayerconnect);
  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  level.br_circle_init_func = ::alternatebrcircle;
  level.ks_killleaders = [];
  level.shownonspectatingwinnersplash = 1;
}

spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

playershouldrespawn(data) {
  return 1;
}

_id_5A106BECAF77D864() {
  _id_D10EB69FAC2844DB = spawnStruct();
  _id_D10EB69FAC2844DB.weights = [];
  level._id_CB0F963CABFE88B4 = _id_D10EB69FAC2844DB;
  _id_2B40061B7748C487("toma_strike", getdvarint("dvar_F9549037967BAA32", 50));
  _id_2B40061B7748C487("precision_airstrike", getdvarint("dvar_2C0CA56D5F18DA83", 10));
  _id_2B40061B7748C487("directional_uav", getdvarint("dvar_77B6803E6319D004", 40));
}

brking_initpostmain() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::brking_createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::brking_addtoc130infil);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::brking_playerwelcomesplashes);
  scripts\cp_mp\utility\script_utility::registersharedfunc("kingslayer", "packClientMatchData", ::packclientmatchdata);
  waittillframeend;
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  level.ontimelimit = ::brking_ontimelimit;
  level.onplayerkilled = ::brking_onplayerkilled;
  level.modeplayerkilledspawn = ::playerkilledspawn;
  level.modifyplayerdamage = ::_id_D5BD74EDD796C519;
  level.assists_disabled = undefined;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", ::brking_oncrateuse);
  brking_cleanupents();
  initteamdatafields();
  level.lootleadermarks = [];
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level thread eomawardplayerxp();
  level thread _id_DBEEA5FBDD7F9D06();
  level thread brking_managecratedrops();
  level thread brking_managecircles();
  thread waitandstartscorepolling();
  level thread placementupdatewait();

  if(getdvarfloat("dvar_81BE161D3102CC0E", 15.0) > 0.0)
    level thread updatelootleadersonfixedinterval();

  if(istrue(level.endmatchcameratransitions))
    level thread initendcameralocations();
}

brking_initdialog() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["match_start"] = "gametype_tdm";
}

brking_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

brking_initexternalfeatures() {}

initteamdatafields() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["teamTotalScore"] = 0;
    level.teamdata[team]["tokensTeamTotal"] = 0;
  }
}

_id_2B40061B7748C487(streakname, weight) {
  level._id_CB0F963CABFE88B4.weights[streakname] = weight;
}

_id_4F5F6CAE4F562F48(player) {
  _id_6FB7DAF6138D07D0 = [];
  _id_B8A569BEF8F3AC2C = 0;

  foreach(key, weight in level._id_CB0F963CABFE88B4.weights) {
    _id_B8A569BEF8F3AC2C = _id_B8A569BEF8F3AC2C + weight;
    _id_6FB7DAF6138D07D0[key] = _id_B8A569BEF8F3AC2C;
  }

  _id_F4CAE9D2914CC11B = randomint(_id_B8A569BEF8F3AC2C);
  _id_BC3CB9ED0C7EC288 = undefined;

  foreach(key, _id_B8A569BEF8F3AC2C in _id_6FB7DAF6138D07D0) {
    if(_id_F4CAE9D2914CC11B < _id_B8A569BEF8F3AC2C) {
      _id_BC3CB9ED0C7EC288 = key;
      break;
    }
  }

  return _id_BC3CB9ED0C7EC288;
}

brking_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_kingslayer_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_kingslayer_welcome");
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0);
}

brking_ontimelimit() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

onstartgametype() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }
}

modespawn(_id_9156B53BCF7CE573) {
  thread playerrespawn();
  return 1;
}

playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  _id_642470E1ABC1BBF9.victim thread playerrespawn();
  return 1;
}

_id_56C0ECCD417D8458() {
  self endon("death_or_disconnect");
  self endon("ks_remove_spawn_protection");
  self._id_3EE36CA751BADAC8 = 1;

  while(!self isonground())
    waitframe();

  if(level._id_94F0E9B9A73DFD18)
    self._id_D6068507654A4B12 = 0;

  self._id_3EE36CA751BADAC8 = 0;
  self notify("ks_remove_spawn_protection");
}

_id_957EF1A1F915DCC1() {
  self endon("death_or_disconnect");
  self endon("ks_remove_spawn_protection");
  self._id_3EE36CA751BADAC8 = 1;
  self waittill("weapon_fired");

  if(level._id_94F0E9B9A73DFD18)
    self._id_D6068507654A4B12 = 0;

  self._id_3EE36CA751BADAC8 = 0;
  self notify("ks_remove_spawn_protection");
}

_id_1AC5CEA983D31C43() {
  self endon("death_or_disconnect");
  self._id_5503639FF31214B3 = 1;

  while(!self isonground())
    waitframe();

  self._id_5503639FF31214B3 = 0;
}

_id_D5BD74EDD796C519(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1, _id_1DA1A66B5C6A06A7) {
  if(level._id_3EE36CA751BADAC8) {
    if(isDefined(victim._id_3EE36CA751BADAC8) && victim._id_3EE36CA751BADAC8 == 1)
      idamage = idamage * level._id_17DA67381DA39F91;

    if(isDefined(eattacker) && isDefined(eattacker._id_5503639FF31214B3) && eattacker._id_5503639FF31214B3 == 1) {
      switch (smeansofdeath) {
        case "MOD_GRENADE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_PROJECTILE_SPLASH":
        case "MOD_EXPLOSIVE":
          idamage = idamage * level._id_A60EF7DB5A1859AE;
          break;
      }
    }
  }

  idamage = _id_1E4A61DB11011446::brmodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1, _id_1DA1A66B5C6A06A7);
  return idamage;
}

playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    _id_80365E25F6E3BEFD = 1.0;
    wait(_id_80365E25F6E3BEFD);
  }

  _id_30839284ADD41CED = level.autorespawnwaittime;
  _id_AC5CF023CA77DB21 = getdvarfloat("dvar_DE0DFC4549393BA2", 5.0);

  if(_id_30839284ADD41CED < _id_AC5CF023CA77DB21)
    _id_30839284ADD41CED = _id_AC5CF023CA77DB21;

  if(level.respawntimedisable != 0)
    _id_30839284ADD41CED = 0;

  _id_E343378B89E661FB = getdvarfloat("dvar_CC53A64FA6E4897B", 3.0);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;

  if(istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    spawnpoint = brking_getspawnpoint();
    _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    thread fadetogearingup(0.0, _id_652F47620AC4713F > 1);
    wait(_id_E343378B89E661FB);
  } else if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_30839284ADD41CED * 1000));
    _id_A294C35CBB452CBF = _id_30839284ADD41CED - _id_AC5CF023CA77DB21;
    _id_D2F5422694822652 = _id_30839284ADD41CED - _id_A294C35CBB452CBF;
    _id_C445F6D6BC71ED85 = _id_30839284ADD41CED - getdvarfloat("dvar_0879A2FDE5543837", 6.0);
    thread fadetogearingup(_id_C445F6D6BC71ED85);
    result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_A294C35CBB452CBF);

    if(result == "squad_wipe_death") {
      spawnpoint = brking_getspawnpoint();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      thread fadetogearingup(0.0, 1);
      wait(_id_E343378B89E661FB);
    } else {
      thread updateprestreamrespawn();
      result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_D2F5422694822652);

      if(result == "squad_wipe_death") {
        spawnpoint = brking_getspawnpoint();
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
        thread fadetogearingup(0.0, 1);
        wait(_id_E343378B89E661FB);
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  spawnpoint = brking_getspawnpoint();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);

  if(istrue(self.squadwiped)) {
    self.squadwiped = 0;

    if(_id_652F47620AC4713F > 1 && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
  }

  if(!brking_ispointinmovingcircle(spawnpoint.origin)) {
    _id_6C53D859D582A421 = brking_getrandompointinmovingcircle(0, 0.7);
    spawnpoint.origin = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], spawnpoint.origin[2]);
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && isDefined(level.player_respawn_struct))
    spawnpoint = scripts\engine\utility::getStruct(level.player_respawn_struct, "targetname");

  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1);
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B092E3259EC308D8");
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);

  if(level._id_3EE36CA751BADAC8) {
    thread _id_957EF1A1F915DCC1();
    thread _id_56C0ECCD417D8458();
    thread _id_1AC5CEA983D31C43();
  }

  self setclientomnvar("ui_flag_player_hud_icon", 0);

  foreach(player in level.lootleaders) {
    if(player == self) {
      _id_1E4A61DB11011446::_id_8D739EC62C568C41();
      break;
    }
  }
}

brking_getspawnpoint() {
  spawnorigin = undefined;
  spawnangles = undefined;
  height = undefined;
  _id_53480B10269770A5 = 1;

  if(isDefined(self.setspawnpoint)) {
    spawnorigin = self.setspawnpoint.playerspawnpos;
    spawnangles = self.setspawnpoint.playerspawnangles;
  }

  _id_8970EF161276A714 = getdvarfloat("dvar_4777C755B1ABD912", 0.8);
  _id_1848FFDBD8A2E93E = getdvarfloat("dvar_86074CD22447D704", 0.9);
  _id_F6AC3C609E85CB74 = getdvarfloat("dvar_EBAE131F0A852FDF", 100);

  if(!isDefined(spawnorigin) && _id_F6AC3C609E85CB74 >= 0) {
    _id_B4E45DBE012F4A40 = _id_5BAB271917698DC4::playergetbestrespawnteammate();

    if(isDefined(_id_B4E45DBE012F4A40)) {
      _id_ABB79C144A7EB425 = brking_getcenterofcircle();
      circleradius = _id_2695A20D4011076D::getsafecircleradius();
      _id_7D0D99F1231F6085 = vectorNormalize(_id_B4E45DBE012F4A40.origin - _id_ABB79C144A7EB425) * (circleradius * _id_8970EF161276A714) + _id_ABB79C144A7EB425;
      spawnorigin = _id_2695A20D4011076D::getrandompointincircle(_id_7D0D99F1231F6085, _id_F6AC3C609E85CB74, _id_8970EF161276A714, _id_1848FFDBD8A2E93E);

      if(isDefined(spawnorigin)) {
        spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);
        spawnangles = _id_5BAB271917698DC4::getanglesfacingorigin(spawnorigin, _id_B4E45DBE012F4A40.origin);
      }
    }
  }

  if(!isDefined(spawnorigin)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      origin = brking_getcenterofcircle();
      radius = _id_2695A20D4011076D::getsafecircleradius();
      _id_D5998E8874D77B02 = getdvarint("dvar_951C7B13FFDD6905", 1);
      _id_38A4C729748AD94C = getdvarint("dvar_7017AD29DBEDC8B1", 1);
      spawnorigin = _id_2695A20D4011076D::getrandompointincircle(origin, radius, _id_8970EF161276A714, _id_1848FFDBD8A2E93E);
      spawnangles = _id_5BAB271917698DC4::getanglesfacingorigin(spawnorigin, origin);
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.autorespawnwaittime) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.autorespawnwaittime * 1000 > gettime())
        spawnorigin = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
      else {
        _id_24A1D3CB9D6D7992 = [];

        foreach(struct in level.prematchspawnorigins) {
          if(distance2dsquared(struct.origin, self.origin) > _id_F6AC3C609E85CB74)
            _id_24A1D3CB9D6D7992[_id_24A1D3CB9D6D7992.size] = struct;
        }

        if(_id_24A1D3CB9D6D7992.size == 0)
          _id_24A1D3CB9D6D7992 = level.prematchspawnorigins;

        _id_24A1D3CB9D6D7992 = scripts\engine\utility::array_randomize(_id_24A1D3CB9D6D7992);
        spawnorigin = _id_24A1D3CB9D6D7992[0].origin;
        spawnorigin = spawnorigin + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = spawnorigin;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      spawnangles = (0, 0, 0);

      if(spawnorigin[2] > 10000) {
        _id_53480B10269770A5 = 0;
        height = _id_0930A1E7BD882C1D::getinfilspawnoffset();
      }
    } else {
      spawnorigin = (0, 0, 0);
      spawnangles = (0, 0, 0);
    }
  }

  if(!isDefined(spawnangles)) {
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
    _id_D097B5E68BAA10D1 = vectortoyaw(circleorigin - spawnorigin);
    spawnangles = (0, _id_D097B5E68BAA10D1, 0);
  }

  if(_id_53480B10269770A5) {
    if(!isDefined(height))
      height = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.br_circle)) {
      circleindex = level.br_circle.circleindex;
      _id_AE439BDE76B3E937 = _id_67708F418B1FAC79::getgulagclosedcircleindex();
      _id_F0B695BB4C38471B = isDefined(circleindex) && circleindex >= _id_AE439BDE76B3E937;

      if(_id_F0B695BB4C38471B)
        height = height * getdvarfloat("dvar_A1C2D6B19BB6A568", 0.55);
    }

    if(isDefined(level.respawnheightoverride))
      height = level.respawnheightoverride;

    _id_A6427A6A24F058DC = (0, 0, height);
    spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = spawnangles;
  spawnpoint.height = height;
  return spawnpoint;
}

fadetogearingup(waittime, squadwiped) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  _id_B59F471C2C064E56 = 1.0;
  thread fadeoutin();
  wait(_id_B59F471C2C064E56 - 0.25);
  _id_1E4A61DB11011446::_id_258C4F40DEE8189A();

  if(istrue(squadwiped))
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 6);
  else
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 2);

  wait 0.25;

  if(getdvarint("dvar_F006294EF8B720A4", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = brking_getspawnpoint();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  self waittill("spawned_player");
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = brking_getspawnpoint();
      currenttime = gettime();

      if(currenttime - self.intermissionspawntime >= getdvarfloat("dvar_57FBCC1BAE0F210A", 2.0) * 1000) {
        spawnpoint = brking_getspawnpoint();
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = brking_getspawnpoint();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1.0;
  }
}

brking_createc130pathstruct(_id_B2D2EEC29DBABA05) {
  if(istrue(level.ks_circlemoving)) {
    level.br_level.br_circlecenters[0] = _id_2695A20D4011076D::getrandompointincircle(level.br_level.br_circlecenters[0], 30000);
    brking_movenextcirclecenter(0);
  }

  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[0][0], level.br_level.br_circlecenters[0][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[0];
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05);
  return c130pathstruct;
}

brking_addtoc130infil() {
  thread brking_kickplayersatcircleedge();
}

brking_kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  _id_432421C6EC2BFCD9 = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  _id_42F65B4B53C1F5D4 = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() - 5;
  wait(_id_42F65B4B53C1F5D4);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

brking_managecratedrops() {
  level endon("game_ended");

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  level waittill("br_prematchEnded");
  wait 20;
  level thread startdeliveries();
}

startdeliveries() {
  level endon("game_ended");
  scripts\mp\hud_util::showsplashtoall("br_juggdrop_incoming");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ks_airdroppercircle; _id_AC0E594AC96AA3A8++) {
      loc = brking_getrandompointinmovingcircle(0, 0.6);
      dropcircle = spawnStruct();
      dropcircle.origin = loc;
      dropcircle.beacon = spawn("script_model", dropcircle.origin);
      dropcircle.beacon setModel("ks_airdrop_crate_br");
      level thread dropdeliveryatpos(dropcircle, "gametype_kingslayer");
    }

    wait(level.ks_circleclosetime + level.ks_circledelaytime);
  }
}

dropdeliveryatpos(dropcircle, source) {
  level endon("game_ended");

  if(!isDefined(dropcircle.dropradius))
    dropcircle.dropradius = level.ks_circleradius;

  droppoint = _id_2695A20D4011076D::getrandompointinboundscircle(dropcircle.origin, dropcircle.dropradius);
  pathstruct = _id_2E385BC294259245::c130airdrop_createpath(undefined, droppoint, 1);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27.dropfunc = ::dropfunc;
  _id_184D0A0CE31A2B27.source = source;
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(1, "battle_royale_c130_loot", "kingslayer_world", dropcircle);
}

dropfunc(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  _id_0BD34ECAC3ADA85B = self.startpt;
  droppoint = self.centerpt;
  _id_5D55352ED330471C = self.speed;
  _id_800DF1B7C6E3AA60 = distance2d(_id_0BD34ECAC3ADA85B, droppoint) / _id_5D55352ED330471C;
  numcrates = 0;
  _id_71CAC1D48AB1C488 = 0;

  for(level.numactivejuggdrops = level.numactivejuggdrops + _id_5EE94AE126526F2F; numcrates < _id_5EE94AE126526F2F; _id_EF5D5141FDB51174.usetimeoverride = getcrateusetime()) {
    wait(_id_800DF1B7C6E3AA60);
    _id_76A22C18960F72AF = _id_2E385BC294259245::c130airdrop_findvaliddroplocation(self.origin, 1);
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(_id_76A22C18960F72AF + (0, 0, level.c130airdrop_heightoverride - 100), _id_76A22C18960F72AF, self.angles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle.nodropanim);
    numcrates++;
    crate.dropcircle = dropcircle;
    crate.source = self.source;
    level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
  }
}

brking_oncrateuse(player) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_uav", _id_CB4FAD49263E20C4);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_clusterstrike", _id_CB4FAD49263E20C4);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_precision_airstrike", _id_CB4FAD49263E20C4);

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D9180CA5C5DC7B88");
}

getcrateusetime() {
  return level.ks_airdropcrateusetime;
}

alternatebrcircle() {
  level.br_level.br_circleclosetimes = [level.ks_circleclosetime, level.ks_circleclosetime];
  level.br_level.br_circledelaytimes = [level.ks_circledelaytime + 40, level.ks_circledelaytime];
  level.br_level.br_circleshowdelaydanger = [1, 0];
  level.br_level.br_circleshowdelaysafe = [0, 0];
  level.br_level.br_circleminimapradii = [level.ks_circleminimapradius, level.ks_circleminimapradius];
  level.br_level.br_circleradii = [level.ks_circleradius, level.ks_circleradius, level.ks_circleradius];

  if(istrue(level.ks_circlemoving)) {
    circleradius = [];
    _id_04F81729168C0B8A = [];
    _id_74B5B12BB6514385 = [];
    _id_1AFD23E03D011EC6 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ks_circlecount; _id_AC0E594AC96AA3A8++) {
      circleradius[circleradius.size] = level.ks_circleradius;
      _id_04F81729168C0B8A[_id_04F81729168C0B8A.size] = level.ks_circleclosetime;
      _id_74B5B12BB6514385[_id_74B5B12BB6514385.size] = level.ks_circledelaytime;
      _id_1AFD23E03D011EC6[_id_1AFD23E03D011EC6.size] = level.ks_circleminimapradius;
    }

    _id_2695A20D4011076D::extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
  } else
    level.br_level.staticcircle = 1;
}

waitandstartscorepolling() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread brking_rankupdate();
}

brking_onplayerconnect(player) {
  player.personalscorecount = 0;
  player.kingslayerkills = 0;
  player.kingslayerdeaths = 0;
}

brking_onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_1E4A61DB11011446::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(level._id_94F0E9B9A73DFD18)
    self._id_D6068507654A4B12 = 1;

  _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  if(isDefined(attacker) && isPlayer(self))
    brking_givepoints(attacker, self);
}

brking_givepoints(_id_6181DE250AFA5BB6, _id_6181D0250AFA3CEC) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(_id_6181DE250AFA5BB6 != _id_6181D0250AFA3CEC && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_8AF3C2A186DCFD47 = _id_6181DE250AFA5BB6.team;
    _id_45AB8896B9F3B36E = 1;
    _id_03A88FAE00B87599 = 1;

    if(level.ks_pointkingsgetnobonus) {
      foreach(player in level.lootleaders) {
        if(player.team == _id_8AF3C2A186DCFD47) {
          _id_03A88FAE00B87599 = 0;
          break;
        }
      }
    }

    if(level._id_7997826228637318 == 0 && !scripts\mp\flags::gameflag("placement_updates_allowed"))
      _id_03A88FAE00B87599 = 0;

    if(_id_03A88FAE00B87599 == 1) {
      foreach(player in level.lootleaders) {
        _id_0506E9B8096AB47F = scripts\engine\utility::ter_op(level.ks_pointbonusforteam, player.team == _id_6181D0250AFA3CEC.team, player == _id_6181D0250AFA3CEC);

        if(_id_0506E9B8096AB47F) {
          _id_45AB8896B9F3B36E = level.ks_pointsperkingslain;
          _id_6181DE250AFA5BB6.kingslayerkills++;
          _id_6181DE250AFA5BB6 packextrascore0();
          _id_6181D0250AFA3CEC.kingslayerdeaths++;
          _id_6181D0250AFA3CEC packextrascore0();
          haskillstreak = isDefined(_id_6181DE250AFA5BB6.streakdata.streaks[1]);
          _id_37F8907B432B5D1D = _id_4F5F6CAE4F562F48(_id_6181DE250AFA5BB6);
          _id_6181DE250AFA5BB6 _id_7E52B56769FA7774::forcegivekillstreak(_id_37F8907B432B5D1D, haskillstreak, 1);
          _id_6181DE250AFA5BB6 thread scripts\mp\hud_message::showsplash("kingslayer_" + _id_37F8907B432B5D1D);
          _id_6181DE250AFA5BB6 thread scripts\mp\rank::scoreeventpopup("stat_4B89B1D2E95E2012");
          _id_6181DE250AFA5BB6 thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", _id_45AB8896B9F3B36E));
          break;
        }
      }
    }

    level.teamdata[_id_8AF3C2A186DCFD47]["teamTotalScore"] = level.teamdata[_id_8AF3C2A186DCFD47]["teamTotalScore"] + _id_45AB8896B9F3B36E;
    _id_6181DE250AFA5BB6.personalscorecount = _id_6181DE250AFA5BB6.personalscorecount + _id_45AB8896B9F3B36E;

    if(level._id_4E9314220031815D > 0) {
      if(level.teamdata[_id_8AF3C2A186DCFD47]["teamTotalScore"] >= level._id_4E9314220031815D)
        level notify("brKing_startPlacements");
    }
  }
}

packextrascore0(data) {
  _id_081DAB8953B9DF82 = self.kingslayerkills;

  if(_id_081DAB8953B9DF82 > 255)
    _id_081DAB8953B9DF82 = 255;

  _id_6E4E3082845F01AF = self.kingslayerdeaths;

  if(_id_6E4E3082845F01AF > 255)
    _id_6E4E3082845F01AF = 255;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_6E4E3082845F01AF << 8);
  scripts\mp\utility\stats::setextrascore0(_id_081DAB8953B9DF82);
}

packclientmatchdata() {
  _id_081DAB8953B9DF82 = self.kingslayerkills;

  if(_id_081DAB8953B9DF82 > 255)
    _id_081DAB8953B9DF82 = 255;

  _id_6E4E3082845F01AF = self.kingslayerdeaths;

  if(_id_6E4E3082845F01AF > 255)
    _id_6E4E3082845F01AF = 255;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_6E4E3082845F01AF << 8);
  return _id_081DAB8953B9DF82;
}

eomawardplayerxp() {
  level waittill("give_match_bonus");
  waitframe();
  _id_7C3103094888139A = getdvarfloat("dvar_624DFF063FDC19E4", 1.0);
  _id_E7E8CA63000A1C32 = getdvarfloat("dvar_5776E92FC7E990F4", 1.0);
  _id_E649B857D1DF196F = getdvarint("dvar_A0C1B8638163484E", 10000);
  _id_BCDA60D01EDD703C = getdvarint("dvar_7845F9181D5707BA", 7500);
  _id_563B1704964ABC60 = getdvarint("dvar_163ACA343E614B6E", 5000);

  foreach(team in level.teamnamelist) {
    _id_4828ED9B88A47362 = 0;
    _id_9B88E8A64BD55390 = 0;
    placement = game["teamPlacements"][team];
    _id_8AE4367B9827D09E = 0;

    if(_id_9B88E8A64BD55390)
      _id_8AE4367B9827D09E = _id_BCDA60D01EDD703C;
    else if(placement <= 10)
      _id_8AE4367B9827D09E = _id_563B1704964ABC60;
    else
      _id_8AE4367B9827D09E = 2500;

    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      player _id_1E4A61DB11011446::stopchallengetimers();

      if(!player scripts\mp\utility\game::rankingenabled() || !player hasplayerdata()) {
        continue;
      }
      player scripts\mp\utility\stats::incpersstat("cash", int(_id_4828ED9B88A47362 / 10000));
      _id_6DAE31F85F556E55 = player.pers["combatXP"];

      if(!isDefined(_id_6DAE31F85F556E55))
        _id_6DAE31F85F556E55 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 0, _id_6DAE31F85F556E55);
      _id_54658E63E8FB96B5 = player.pers["missionXP"];

      if(!isDefined(_id_54658E63E8FB96B5))
        _id_54658E63E8FB96B5 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 1, _id_54658E63E8FB96B5);
      _id_737B512E4921C915 = player.pers["lootingXP"];

      if(!isDefined(_id_737B512E4921C915))
        _id_737B512E4921C915 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 2, _id_737B512E4921C915);
      _id_0D239A4DE12B2338 = 0;

      if(isDefined(player.plundercount))
        _id_0D239A4DE12B2338 = int(player.plundercount * _id_7C3103094888139A);

      _id_452885D9FFE85530 = 0;

      if(isDefined(player.plunderbanked))
        _id_452885D9FFE85530 = int(player.plunderbanked * _id_E7E8CA63000A1C32);

      score = _id_0D239A4DE12B2338 + _id_452885D9FFE85530;

      if(score > 0)
        player scripts\mp\rank::giverankxp("stat_31A9F06F2A47AEFF", score, undefined, 1, 1);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 3, 0);
      matchbonus = 0;

      if(isDefined(player.matchbonus))
        matchbonus = int(player.matchbonus);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 4, matchbonus);

      if(_id_8AE4367B9827D09E > 0)
        player scripts\mp\rank::giverankxp("stat_9353D15B3EA6B33C", _id_8AE4367B9827D09E, undefined, 1, 1);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 5, _id_8AE4367B9827D09E);
      _id_BF587C66B60EF10F = player getplayerdata(level._id_5D69837CF4DB0407, "aarValue", 6);
      _id_EFE4124EAA21EA43 = _id_BF587C66B60EF10F + player.pers["summary"]["xp"];
      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 7, _id_EFE4124EAA21EA43);
    }
  }
}

brking_updateteamscore(_id_9677841089350A6D, team, _id_C6544E2C82D62DFB) {
  _id_4BF0ADEE32BC3338 = int(game["teamScores"][team]);
  _id_3777ECE6A73EADA5 = _id_9677841089350A6D - _id_4BF0ADEE32BC3338;

  if(_id_3777ECE6A73EADA5 != 0) {
    _id_61A16DF4892DB7B5 = scripts\engine\utility::ter_op(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(team, _id_3777ECE6A73EADA5, 0, undefined, _id_61A16DF4892DB7B5, _id_C6544E2C82D62DFB);
  }

  return _id_3777ECE6A73EADA5;
}

_id_9B3F9A3379688335(_id_A9706ADAF7C52E27) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, _id_A9706ADAF7C52E27);
}

brking_rankupdate() {
  level endon("game_ended");
  _id_61A13391E0337903 = 0;
  _id_5A1B98786F638BB3 = [];
  _id_39926F7B2DE6C632 = level.hideleaderhashuntilpercent != 0;
  _id_AD5E6D3E7E4CC004 = 0;

  for(;;) {
    waittillframeend;
    _id_20085F3D87BAC60B = level.called50percentprogress && level.called75percentprogress && level.called90percentprogress;
    _id_4E21022C04D88E00 = level.ks_pointstowin;
    _id_61A13391E0337903 = _id_61A13391E0337903 + level.framedurationseconds;

    if(istrue(level.usemilestonephases))
      _id_1910592D7CD985FE = scripts\mp\flags::gameflag("placement_updates_allowed");
    else
      _id_1910592D7CD985FE = _id_61A13391E0337903 > level.secondsbeforeplacementupdates;

    _id_9C81A0995E8F1C76 = level.showplacementsplashesandmusic && _id_1910592D7CD985FE;
    _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
    _id_89F63B69F41AD35A = level.teamplunderscoremechanic;
    _id_0745AE0B656709A1 = undefined;
    _id_073D1D0B655DDF10 = undefined;
    _id_0734360B6553F75D = undefined;
    _id_44578707AF5385CE = [];
    _id_87B32CCA2597530F = [];
    _id_E3759B02F55695C2 = [];
    _id_EC15CE3E7A9D1D86 = "none";
    _id_276B54E205081271 = "none";
    _id_963524745F704899 = -1;
    _id_8ACBB0D8AC1FC9FA = 0;

    foreach(team in level.teamnamelist) {
      _id_9677841089350A6D = level.teamdata[team]["teamTotalScore"];
      _id_3777ECE6A73EADA5 = brking_updateteamscore(_id_9677841089350A6D, team, level.brgametype.firstteam);
      _id_BA2432A58DD7EBD3 = getpreviousplacement(team);
      placement = _id_C3E10A42A81ADE25[team];

      if(_id_9677841089350A6D > _id_963524745F704899) {
        if(_id_963524745F704899 > _id_8ACBB0D8AC1FC9FA) {
          _id_8ACBB0D8AC1FC9FA = _id_963524745F704899;
          _id_276B54E205081271 = _id_EC15CE3E7A9D1D86;
        }

        _id_963524745F704899 = _id_9677841089350A6D;
        _id_EC15CE3E7A9D1D86 = team;
      } else if(_id_EC15CE3E7A9D1D86 != "none") {
        if(_id_9677841089350A6D > _id_8ACBB0D8AC1FC9FA) {
          _id_8ACBB0D8AC1FC9FA = _id_9677841089350A6D;
          _id_276B54E205081271 = team;
        }
      }

      _id_BC8FBD02E2C5E2B8 = _id_9677841089350A6D;
      total = _id_9677841089350A6D;
      _id_D8FED4D7AD83256A = 0;

      if(total >= _id_4E21022C04D88E00 * 0.9)
        _id_0745AE0B656709A1 = team;
      else if(total >= _id_4E21022C04D88E00 * 0.75)
        _id_073D1D0B655DDF10 = team;
      else if(total >= _id_4E21022C04D88E00 * 0.5)
        _id_0734360B6553F75D = team;

      if(total >= _id_4E21022C04D88E00 * level.plundermusicfourth)
        thread scripts\mp\music_and_dialog::plunder_ninetypercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicthird)
        thread scripts\mp\music_and_dialog::plunder_seventyfivepercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicsecond)
        thread scripts\mp\music_and_dialog::plunder_fiftypercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicfirst)
        thread scripts\mp\music_and_dialog::plunder_thirtypercent_music();

      players = scripts\mp\utility\teams::getfriendlyplayers(team, 0);
      _id_B1D20734BC8E2C5C(_id_C3E10A42A81ADE25, players);

      foreach(player in players) {
        _id_87B32CCA2597530F[player.guid] = player.personalscorecount;
        _id_E3759B02F55695C2[player.guid] = player;
      }

      if(_id_9C81A0995E8F1C76) {
        if(placement == 1)
          _id_44578707AF5385CE[_id_44578707AF5385CE.size] = team;
        else if(placement <= 5) {
          if(_id_BA2432A58DD7EBD3 > 5)
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_5");
        } else if(placement <= 10) {
          if(_id_BA2432A58DD7EBD3 > 10)
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_10");
        }
      }

      if(total >= _id_4E21022C04D88E00)
        level thread givewincondition(team);
    }

    foreach(player in level.players) {
      _id_929A6DF466DC4F22 = level.teamdata[player.team]["teamTotalScore"];
      player setclientomnvar("ui_br_team_cash_banked", int(_id_929A6DF466DC4F22));
      player setclientomnvar("ui_br_team_cash_pockets", int(scripts\engine\utility::ter_op(_id_929A6DF466DC4F22 >= _id_963524745F704899, _id_8ACBB0D8AC1FC9FA, _id_963524745F704899)));
    }

    _id_DDD20D819A369A7D = [];
    _id_348AB76F83B33509 = [];

    if(level.lootleadermarksontopteams == 1)
      _id_DDD20D819A369A7D = tablesort(game["teamPlacements"], "up");
    else if(level.lootleadermarksontopteams == 2) {
      _id_DDD20D819A369A7D[0] = _id_EC15CE3E7A9D1D86;
      _id_348AB76F83B33509 = tablesort(_id_87B32CCA2597530F, "down");
    } else
      _id_348AB76F83B33509 = tablesort(_id_87B32CCA2597530F, "down");

    level.brgametype.firstteam = _id_EC15CE3E7A9D1D86;

    if(_id_EC15CE3E7A9D1D86 == "none") {
      _id_5A1B98786F638BB3 = [];
      waitframe();
      continue;
    }

    if(!_id_39926F7B2DE6C632 && _id_963524745F704899 >= _id_4E21022C04D88E00 * level.hideleaderhashuntilpercent * 0.1) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      _id_39926F7B2DE6C632 = 1;
    }

    if(!_id_9C81A0995E8F1C76 || _id_963524745F704899 == 0) {
      waitframe();
      continue;
    }

    if(level.lootleadermarksontopteams > 0) {
      if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
        updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2, _id_DDD20D819A369A7D);
        level.plunderupdatelootleadermarks = 0;
      }
    } else if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
      updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2);
      level.plunderupdatelootleadermarks = 0;
    }

    foreach(team in _id_44578707AF5385CE) {
      if(!scripts\engine\utility::array_contains(_id_5A1B98786F638BB3, team)) {
        if(istrue(level.topteamsever[team])) {
          if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team_regained");

          continue;
        }

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team");

        level.topteamsever[team] = 1;
      }
    }

    if(_id_44578707AF5385CE.size > 0) {
      foreach(team in _id_5A1B98786F638BB3) {
        if(!scripts\engine\utility::array_contains(_id_44578707AF5385CE, team))
          scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team_lost");
      }
    }

    _id_5A1B98786F638BB3 = _id_44578707AF5385CE;
    level.topteam = _id_EC15CE3E7A9D1D86;
    level.previousplacements = _id_C3E10A42A81ADE25;

    if(!_id_20085F3D87BAC60B) {
      if(!level.called90percentprogress && isDefined(_id_0745AE0B656709A1)) {
        level.called90percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_0745AE0B656709A1, "bm_first_to_90_them");
            scripts\mp\hud_util::showsplashtoteam(_id_0745AE0B656709A1, "bm_first_to_90_us");
            level thread _id_2CEDCC356F1B9FC8::brleaderdialog("final_circle", 0, undefined, undefined, 2);
          }
        }
      } else if(!level.called75percentprogress && isDefined(_id_073D1D0B655DDF10)) {
        level.called75percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_073D1D0B655DDF10, "bm_first_to_75_them");
            scripts\mp\hud_util::showsplashtoteam(_id_073D1D0B655DDF10, "bm_first_to_75_us");
          }
        }
      } else if(!level.called50percentprogress && isDefined(_id_0734360B6553F75D)) {
        level.called50percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_0734360B6553F75D, "bm_first_to_50_them");
            scripts\mp\hud_util::showsplashtoteam(_id_0734360B6553F75D, "bm_first_to_50_us");
          }
        }
      }
    }

    waitframe();
  }
}

_id_B1D20734BC8E2C5C(_id_C3E10A42A81ADE25, players) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    placement = _id_C3E10A42A81ADE25[player.team];
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_placement", placement);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_player_position", placement);
  }
}

getpreviousplacement(team) {
  if(isDefined(level.previousplacements))
    return level.previousplacements[team];

  return -1;
}

hackclientomnvarclamp(omnvar, val) {
  _id_68A4063209579D4F = int(min(val, 131072));
  self setclientomnvar(omnvar, _id_68A4063209579D4F);
}

hackomnvarclamp(omnvar, val) {
  _id_68A4063209579D4F = int(min(val, 131072));
  setomnvar(omnvar, _id_68A4063209579D4F);
}

updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2, _id_DDD20D819A369A7D) {
  level.lootleadersprev = level.lootleaders;
  level.lootleaders = [];

  if(level.lootleadermarksontopteams == 1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
      _id_D546F00EDC1B5FC7 = getlootteamleader(_id_AC0E594AC96AA3A8, _id_87B32CCA2597530F, _id_DDD20D819A369A7D);

      if(isDefined(_id_D546F00EDC1B5FC7))
        level.lootleaders[level.lootleaders.size] = _id_E3759B02F55695C2[_id_D546F00EDC1B5FC7];
    }
  } else if(level.lootleadermarksontopteams == 2) {
    _id_D546F00EDC1B5FC7 = getlootteamleader(0, _id_87B32CCA2597530F, _id_DDD20D819A369A7D);

    if(isDefined(_id_D546F00EDC1B5FC7))
      level.lootleaders[0] = _id_E3759B02F55695C2[_id_D546F00EDC1B5FC7];

    foreach(_id_B7739B4D7E762D6B in _id_348AB76F83B33509) {
      player = _id_E3759B02F55695C2[_id_B7739B4D7E762D6B];
      _id_67F14F8315CB0F2F = _id_87B32CCA2597530F[_id_B7739B4D7E762D6B];

      if(_id_67F14F8315CB0F2F == 0) {
        break;
      }

      if(_id_67F14F8315CB0F2F == level.risktokenstokeep) {
        continue;
      }
      if(scripts\engine\utility::array_contains(level.lootleaders, player)) {
        continue;
      }
      level.lootleaders[level.lootleaders.size] = player;

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  } else {
    foreach(player in _id_348AB76F83B33509) {
      _id_67F14F8315CB0F2F = _id_87B32CCA2597530F[player];

      if(_id_67F14F8315CB0F2F == 0) {
        break;
      }

      level.lootleaders[level.lootleaders.size] = _id_E3759B02F55695C2[player];

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  }

  foreach(player in level.lootleadersprev) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(level.lootleaders, player))
      removeplayeraslootleader(player);
  }

  level notify("update_loot_leaders");

  if(level.lootleadermarks.size < level.lootleadermarkcount) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
      instance = spawnStruct();
      instance.hidden = 0;
      instance _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active");
      level.lootleadermarks[_id_AC0E594AC96AA3A8] = instance;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
    instance = level.lootleadermarks[_id_AC0E594AC96AA3A8];

    if(isDefined(level.lootleaders[_id_AC0E594AC96AA3A8])) {
      instance.targetplayer = level.lootleaders[_id_AC0E594AC96AA3A8];
      instance.targetplayer.lootleaderinstance = instance;
      location = instance.targetplayer.origin;
      _id_BFF2D9D4105D9618 = scripts\engine\utility::array_contains(level.lootleaders, instance.targetplayer) && !scripts\engine\utility::array_contains(level.lootleadersprev, instance.targetplayer);

      if(instance.hidden == 0) {
        _id_BE4E32B47AD61C7D = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

        foreach(player in _id_BE4E32B47AD61C7D)
        instance _id_8B056A69EE30515B(player);

        _id_1E502B02D01CF98D = scripts\mp\utility\teams::getfriendlyplayers(instance.targetplayer.team, 0);

        foreach(player in _id_1E502B02D01CF98D)
        instance _id_635DC93D8060CB5F(player);
      }

      if(_id_BFF2D9D4105D9618)
        addplayeraslootleader(instance);

      continue;
    }

    instance.targetplayer = undefined;
    objective_removeallfrommask(instance.objectiveiconid);
  }
}

_id_DBEEA5FBDD7F9D06() {
  level endon("game_ended");
  level waittill("update_loot_leaders");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
      instance = level.lootleadermarks[_id_AC0E594AC96AA3A8];

      if(isDefined(instance.targetplayer)) {
        if(!scripts\mp\utility\player::isreallyalive(instance.targetplayer) && instance.hidden == 0) {
          instance.hidden = 1;
          objective_removeallfrommask(instance.objectiveiconid);
          level notify("Objective_Delete", instance.objectiveiconid);
        } else if(scripts\mp\utility\player::isreallyalive(instance.targetplayer) && instance.hidden == 1) {
          if(!level._id_94F0E9B9A73DFD18 || isDefined(instance.targetplayer._id_D6068507654A4B12) && instance.targetplayer._id_D6068507654A4B12 == 0) {
            instance.hidden = 0;
            _id_BE4E32B47AD61C7D = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

            foreach(player in _id_BE4E32B47AD61C7D)
            instance _id_8B056A69EE30515B(player);
          }
        }

        instance _id_9B3F9A3379688335(instance.targetplayer.origin);
        continue;
      }

      if(instance.hidden == 0) {
        instance.hidden = 1;
        objective_removeallfrommask(instance.objectiveiconid);
      }
    }

    if(level._id_69F99BB835E36684 > 0) {
      wait(level._id_69F99BB835E36684);
      continue;
    }

    waitframe();
  }
}

_id_8B056A69EE30515B(player) {
  _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
}

_id_635DC93D8060CB5F(player) {
  _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
}

getlootteamleader(index, _id_87B32CCA2597530F, _id_DDD20D819A369A7D) {
  team = _id_DDD20D819A369A7D[index];
  _id_9FB5DEF50E853261 = 0;
  plunder = 0;

  if(level.teamdata[team]["players"].size == 0)
    return undefined;

  _id_D546F00EDC1B5FC7 = level.teamdata[team]["players"][0].guid;

  foreach(player in level.teamdata[team]["players"]) {
    _id_9FB5DEF50E853261 = _id_87B32CCA2597530F[player.guid];

    if(_id_9FB5DEF50E853261 > plunder) {
      plunder = _id_9FB5DEF50E853261;
      _id_D546F00EDC1B5FC7 = player.guid;
    }
  }

  return _id_D546F00EDC1B5FC7;
}

addplayeraslootleader(instance) {
  player = instance.targetplayer;

  if(scripts\mp\utility\player::isreallyalive(player)) {
    player _id_1E4A61DB11011446::_id_8D739EC62C568C41();

    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      player scripts\mp\hud_message::showsplash("bm_player_marked");
  }
}

updatelootleadersonfixedinterval() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  interval = getdvarfloat("dvar_81BE161D3102CC0E", 15.0);
  _id_35D7D56101FB07A0 = getdvarfloat("dvar_B82244F91B963437", 5.0);
  _id_9C18968676DF1094 = getdvarint("dvar_114AA0DB563F4C19", 800);
  _id_32E688C1E2CF28C0 = getdvarint("dvar_4F47F4BD5CFEF308", 200);
  _id_1F88F11926C68559 = interval - _id_35D7D56101FB07A0;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");

  for(;;) {
    level.plunderupdatelootleadermarks = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", _id_1F88F11926C68559);
  }
}

placementupdatewait() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.secondsbeforeplacementupdates))
    wait(level.secondsbeforeplacementupdates);

  if(level._id_4E9314220031815D > 0)
    level waittill("brKing_startPlacements");

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

removeplayeraslootleader(player) {
  player _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();

  if(isDefined(player.lootleaderinstance)) {
    foreach(_id_F90358454413407F in level.players)
    player.lootleaderinstance _id_635DC93D8060CB5F(_id_F90358454413407F);

    player.lootleaderinstance.targetplayer = undefined;
    player.lootleaderinstance = undefined;
  }

  level.lootleaders = scripts\engine\utility::array_remove(level.lootleaders, player);
}

givewincondition(_id_65669339223F29B4) {
  waitframe();
  _id_B1D20734BC8E2C5C(scripts\mp\gamescore::getteamscoreplacements(), level.players);

  if(istrue(level.triggeredwincondition)) {
    return;
  }
  level.triggeredwincondition = 1;
  level thread scripts\mp\gamelogic::endgame(_id_65669339223F29B4, game["end_reason"]["objective_completed"]);
  _id_03784E17637539B8 = [];

  if(isDefined(_id_65669339223F29B4) && _id_65669339223F29B4 != "tie")
    _id_03784E17637539B8 = scripts\mp\utility\teams::getteamdata(_id_65669339223F29B4, "players");

  thread scripts\mp\music_and_dialog::plunder_endgame_music();
}

ononeleftevent(team) {}

playerspawnendofgame() {
  if(!istrue(self.controlsfrozen))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");

  spawnpoint = spawnStruct();
  player = self getspectatingplayer();

  if(!isDefined(player))
    player = self;

  spawnpoint.origin = player.origin;
  spawnpoint.angles = player.angles;

  if(!player isonground()) {
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    spawnpoint.origin = scripts\engine\utility::drop_to_ground(spawnpoint.origin, 0, -20000, undefined, _id_FBCABD62B8F66EB8);
  }

  spawnpoint.origin = spawnpoint.origin + (0, 0, 100);

  if(!isDefined(level.endmatchcamerastriggered)) {
    level.endmatchcamerastriggered = 1;
    level thread triggerbloodmoneyendcameras();
  }

  return 1;
}

initendcameralocations() {
  _id_6F0D91B3AB59B3E8 = [];
  level.endcameraorigins = [];
  level.endcameraangles = [];

  if(level.mapname == "mp_br_mechanics") {
    level.endcameraorigins[0] = (8682, -1036, 427);
    level.endcameraangles[0] = (14, 163, 0);
    level.endcameraorigins[1] = (-1139, -3425, 1116);
    level.endcameraangles[1] = (33, 75, 0);
    level.endcameraorigins[2] = (-5567, -4786, 1116);
    level.endcameraangles[2] = (37, 192, 0);
  } else {
    level.endcameraorigins[0] = (-36548, -31983, 2400);
    level.endcameraangles[0] = (12, 72, 0);
    level.endcameraorigins[1] = (-17592, -36440, 1379);
    level.endcameraangles[1] = (17, 90, 0);
    level.endcameraorigins[2] = (-3520, -34298, 1217);
    level.endcameraangles[2] = (11, 110, 0);
    level.endcameraorigins[3] = (-9577, -25957, 360);
    level.endcameraangles[3] = (357, 82, 0);
    level.endcameraorigins[4] = (23022, -26926, 1359);
    level.endcameraangles[4] = (16, 101, 0);
    level.endcameraorigins[5] = (31261, -29753, 1359);
    level.endcameraangles[5] = (27, 52, 0);
    level.endcameraorigins[6] = (44843, -41261, 3220);
    level.endcameraangles[6] = (16, 52, 0);
    level.endcameraorigins[7] = (44229, -15403, 1331);
    level.endcameraangles[7] = (13, 72, 0);
    level.endcameraorigins[8] = (44491, 3484, 1638);
    level.endcameraangles[8] = (23, 11, 0);
    level.endcameraorigins[9] = (16047, -3206, 2613);
    level.endcameraangles[9] = (27, 309, 0);
    level.endcameraorigins[10] = (5668, -5905, 1614);
    level.endcameraangles[10] = (23, 304, 0);
    level.endcameraorigins[11] = (-13412, -20443, 1033);
    level.endcameraangles[11] = (11, 109, 0);
    level.endcameraorigins[12] = (-30369, -7811, 1680);
    level.endcameraangles[12] = (31, 339, 0);
    level.endcameraorigins[13] = (-26278, 4081, 142);
    level.endcameraangles[13] = (6, 110, 0);
    level.endcameraorigins[14] = (-16429, 6021, 847);
    level.endcameraangles[14] = (21, 57, 0);
    level.endcameraorigins[15] = (-7525, 11672, 1082);
    level.endcameraangles[15] = (14, 46, 0);
    level.endcameraorigins[16] = (8356, 15296, 2021);
    level.endcameraangles[16] = (12, 38, 0);
    level.endcameraorigins[17] = (26010, 29975, 2716);
    level.endcameraangles[17] = (13, 68, 0);
    level.endcameraorigins[18] = (12043, 30910, 3081);
    level.endcameraangles[18] = (21, 88, 0);
    level.endcameraorigins[19] = (7127, 52592, 2100);
    level.endcameraangles[19] = (28, 241, 0);
    level.endcameraorigins[20] = (-6693, 56481, 4026);
    level.endcameraangles[20] = (16, 246, 0);
    level.endcameraorigins[21] = (-21394, 37175, 757);
    level.endcameraangles[21] = (2, 124, 0);
    level.endcameraorigins[22] = (-26151, 25577, 271);
    level.endcameraangles[22] = (357, 10, 0);
  }
}

triggerbloodmoneyendcameras() {
  _id_CDFA1020BBC3F969 = 0;

  foreach(player in level.players) {
    player thread playmatchendcamera(player, getbestcameraindex(player));
    _id_CDFA1020BBC3F969++;

    if(_id_CDFA1020BBC3F969 == 5) {
      waitframe();
      _id_CDFA1020BBC3F969 = 0;
    }
  }
}

getbestcameraindex(player) {
  _id_BCD1F02C15CF8F02 = undefined;
  _id_00BF97AF9158BCF3 = undefined;

  foreach(index, origin in level.endcameraorigins) {
    dist = distance2dsquared(player.origin, origin);

    if(dist <= 9000000)
      return index;

    if(!isDefined(_id_00BF97AF9158BCF3) || _id_00BF97AF9158BCF3 > dist) {
      _id_00BF97AF9158BCF3 = dist;
      _id_BCD1F02C15CF8F02 = index;
    }
  }

  return _id_BCD1F02C15CF8F02;
}

playmatchendcamera(player, _id_59D945F45B4733EE) {
  _id_E0134DCE95218ED1 = level.endcameraorigins[_id_59D945F45B4733EE];
  _id_06E88057A6FA92C7 = level.endcameraangles[_id_59D945F45B4733EE];
  _id_F0FFC87D0DB8E9F0 = _id_E0134DCE95218ED1 + anglestoright(_id_06E88057A6FA92C7) * 1000;
  _id_9A8CB976407AE8C2 = _id_06E88057A6FA92C7;
  _id_5940F376A254619D = spawn("script_model", _id_E0134DCE95218ED1);
  _id_5940F376A254619D setModel("tag_origin");
  _id_5940F376A254619D.angles = _id_06E88057A6FA92C7;
  player cameralinkTo(_id_5940F376A254619D, "tag_origin");
  _id_5940F376A254619D moveTo(_id_F0FFC87D0DB8E9F0, 60);
  _id_5940F376A254619D rotateTo(_id_9A8CB976407AE8C2, 60);
}

brking_managecircles() {
  level endon("game_ended");
  level thread brking_watchcircletimers();

  for(;;) {
    level waittill("br_circle_set");
    brking_movenextcirclecenter();
  }
}

brking_movenextcirclecenter(index) {
  if(!isDefined(index))
    index = level.br_circle.circleindex + 1;

  if(level.br_level.br_circlecenters.size <= index || !istrue(level.ks_circlemoving)) {
    return;
  }
  _id_D303E81057B8A554 = level.br_level.br_circlecenters[index];
  _id_B65A1BDA511E60AB = level.ks_circlemovedist;
  _id_DA9544331D11402C = _id_D303E81057B8A554;
  _id_332BFCF7ECA6F520 = _id_2695A20D4011076D::getrandompointincircle(_id_D303E81057B8A554, _id_B65A1BDA511E60AB, 0.8, 1.0);
  _id_71E7CDE0A5DBE9DA = _id_332BFCF7ECA6F520 - _id_D303E81057B8A554;

  if(level.lootleaders.size > 0)
    _id_71E7CDE0A5DBE9DA = scripts\engine\utility::ter_op(level._id_4E3F7E1ABE295225, _id_D303E81057B8A554 - level.lootleaders[0].origin, level.lootleaders[0].origin - _id_D303E81057B8A554);

  _id_71E7CDE0A5DBE9DA = vectorNormalize(_id_71E7CDE0A5DBE9DA) * _id_B65A1BDA511E60AB;
  _id_DA9544331D11402C = _id_DA9544331D11402C + _id_71E7CDE0A5DBE9DA;

  if(!_id_BE58CCBB0186E9F0(_id_DA9544331D11402C + _id_71E7CDE0A5DBE9DA)) {
    _id_71E7CDE0A5DBE9DA = vectorNormalize(level.br_level.br_mapcenter - _id_D303E81057B8A554) * _id_B65A1BDA511E60AB;
    _id_DA9544331D11402C = _id_D303E81057B8A554 + _id_71E7CDE0A5DBE9DA;
  }

  level.br_level.br_circlecenters[index + 1] = _id_DA9544331D11402C;
}

_id_BE58CCBB0186E9F0(_id_CDCD3178F5176585) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;
  _id_B1D9D00302A9B4D6 = level._id_8DC79635128DDA21;
  inmapbounds = _id_CDCD3178F5176585[0] < _id_DC8625458EE5ED14[0][0] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[0] > _id_DC8625458EE5ED14[1][0] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[1] < _id_DC8625458EE5ED14[0][1] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[1] > _id_DC8625458EE5ED14[1][1] * _id_B1D9D00302A9B4D6;
  return inmapbounds;
}

brking_watchcircletimers() {
  level endon("game_ended");
  level.circleclosestarttime = gettime();

  for(;;) {
    level waittill("br_circle_started");
    level.circleclosestarttime = gettime();
  }
}

brking_getcirclepercentmoved() {
  return (gettime() - level.circleclosestarttime) / 1000 / level.ks_circleclosetime;
}

brking_getcenterofcircle() {
  _id_4246CA4ED25D36CA = brking_getcirclepercentmoved();

  if(level.br_circle.circleindex < 0)
    return level.br_level.br_circlecenters[0];

  if(_id_4246CA4ED25D36CA > 1)
    return level.br_level.br_circlecenters[level.br_circle.circleindex];

  _id_1245375085E12535 = level.br_level.br_circlecenters[level.br_circle.circleindex + 1];
  _id_E5F29ACDDB11BD50 = level.br_level.br_circlecenters[level.br_circle.circleindex];
  return vectorlerp(_id_E5F29ACDDB11BD50, _id_1245375085E12535, brking_getcirclepercentmoved());
}

brking_ispointinmovingcircle(point) {
  center = brking_getcenterofcircle();
  _id_D496DBAFBA2BE4FA = distance2d(point, center);
  return _id_D496DBAFBA2BE4FA < level.ks_circleradius;
}

brking_getrandompointinmovingcircle(_id_8108B284F99B128A, _id_812BBC84F9C17040) {
  center = brking_getcenterofcircle();
  return _id_2695A20D4011076D::getrandompointincircle(center, level.ks_circleradius, _id_8108B284F99B128A, _id_812BBC84F9C17040);
}