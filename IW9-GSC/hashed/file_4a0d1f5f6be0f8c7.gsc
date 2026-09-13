/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4a0d1f5f6be0f8c7.gsc
***********************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "vanilla") {
    return;
  }
  init();
}

init() {
  level._id_7D43CCDC62F43DB3 = _id_40E63DD222434655::_id_81A10B74BFE305A9;
  level._id_2C93542553C664F5 = 0;
  level._id_472D7A6D15E57940 = 0;
  level._id_1D814F83596D0A02 = 0;
  level.bots_gametype_handles_class_choice = !istrue(level._id_66113AA6FC12BE57);
  level._id_0C1D58BF29DCAE79 = 1;
  level.minplunderdropondeath = getdvarint("dvar_E0A487B88D0E4410", 1);
  level._id_CC9E990B6E83975B = getdvarint("dvar_0C39067C564E9BE9", 1);
  _id_3408B3BE04FF0639 = getdvarint("dvar_4C8E33496C92CD2E", 0);

  if(_id_3408B3BE04FF0639 == 1)
    _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");

  level._id_52BA18A9DC3B6BFD = getdvarint("dvar_5247511DC61265D3", 0) != 0;
  level._id_59E079836A49593E = level._id_52BA18A9DC3B6BFD && getdvarint("dvar_82008D9ECD77F702", 0) != 0;

  if(level._id_52BA18A9DC3B6BFD)
    _id_362C58E8BB39BCDA::registerbrgametypefunc("giveFavoriteLoadout", ::_id_471EBB7E7DBAD7B7);

  _id_362C58E8BB39BCDA::registerbrgametypefunc("onSpawnPlayer", ::onspawnplayer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", ::modifyplayerdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getBestSpectateCandidate", ::getbestspectatecandidate);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isValidSpectateTarget", ::isvalidspectatetarget);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", _id_26CCBFE3954CACF4::_id_FB4771E79218146B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onMarkPlayerAsEliminated", ::_id_0F5CFF6DA44A3790);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onUnmarkPlayerAsEliminated", ::_id_6029066AB0D7003B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getDefaultLoadout", ::_id_391B372CD3C0DDDC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", ::_id_B8CE7E76DC2DC587);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("GetRandomLoadout", ::_id_A6C8F6E16F9ACACC);

  if(_id_26CCBFE3954CACF4::_id_E60552DD6ABCC4AA()) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", _id_26CCBFE3954CACF4::onplayerconnect);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerDisconnect", _id_26CCBFE3954CACF4::onplayerdisconnect);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("isTeamEliminated", _id_26CCBFE3954CACF4::isteameliminated);
  }

  _id_642082E8EDBA5663::initialize(::_id_FB899558E6107F9E, ::_id_0BB8B7CDCE37CCAB, ::_id_EAC6CE0D8138984B);
  level._id_BDD92C05D3032F65 = ::_id_BDD92C05D3032F65;
  level._id_CB87DB3F189CF3F1 = ::_id_3363DE115C63751D;
  level.quest_domdistmin = getdvarint("dvar_A733BBFD9D9909FE", 500);
  level.quest_domdistmax = getdvarint("dvar_A710CDFD9D72E9DC", 7000);
  level.quest_assdistmin = getdvarint("dvar_0004512E59F0EAE9", 500);
  level.quest_assdistmax = getdvarint("dvar_FFE1432E59CA8467", 7000);
  level.quest_scavdistmin = getdvarint("dvar_A607164E2C76E4F1", 500);
  level.quest_scavdistmax = getdvarint("dvar_A62A284E2C9D543F", 7000);
  level.shownonspectatingwinnersplash = 1;

  if(scripts\mp\utility\game::matchmakinggame())
    level thread _id_40E63DD222434655::_id_F4CD8D89E37B4888();

  thread _id_CED5973479A0E03B();

  if(_id_0A661C5FAD6BEDD8::_id_BC586652AA211EE1())
    level thread _id_0A661C5FAD6BEDD8::_id_2CAFA6C0BC2D49A9(0, undefined, undefined);

  if(_id_4F0E283905A1B329::_id_B243F0FD0562BBFB())
    _id_4F0E283905A1B329::init();

  if(getdvarint("dvar_8B0F39DEAC448892", 0) == 1)
    level thread _id_3500D0E31F6EBEE5();
}

_id_CED5973479A0E03B() {
  if(getdvarint("dvar_D541BE8CE632EAC6", 0) == 0) {
    return;
  }
  level endon("game_ended");

  while(!isDefined(level.teamnamelist))
    waitframe();

  for(;;) {
    foreach(team in level.teamnamelist) {
      _id_A059CAB9DFE3D005 = level.teamdata[team]["plunderTeamTotal"];
      players = scripts\mp\utility\teams::getfriendlyplayers(team, 0);

      foreach(player in players)
      player setclientomnvar("ui_br_team_cash_pockets", _id_A059CAB9DFE3D005);
    }

    waitframe();
  }
}

_id_391B372CD3C0DDDC() {
  _id_DAB2D2EFDE751B62 = "classtable:classtable_br_vanilla";
  return _id_1E4A61DB11011446::initstandardloadout(_id_DAB2D2EFDE751B62, 0);
}

_id_471EBB7E7DBAD7B7() {
  _id_C7DAB7E6D3E3E3FD = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
  _id_0AC2E2DC79F3D177 = scripts\mp\menus::getclasschoice(_id_C7DAB7E6D3E3E3FD);
  self.pers["class"] = _id_0AC2E2DC79F3D177;
  self.class = _id_0AC2E2DC79F3D177;
  self takeallweapons();
  struct = scripts\mp\class::preloadandqueueclass(_id_0AC2E2DC79F3D177, 1);
  scripts\mp\class::swaploadout();
}

onspawnplayer() {
  _id_3B64EB40368C1450::_id_8B5F9E0014775208();

  if(!isbot(self) && isPlayer(self)) {
    vehicle_allowplayeruse(self, 1);
    thread _id_5120873D6D2BB7E2::_id_608AD5A3783431D9();
  }
}

modifyplayerdamage(damagedata) {
  _id_DFABE685A74F1B33 = isDefined(damagedata.victim) && isbot(damagedata.victim) && damagedata.victim _id_4C9BD9A3BF3F8CF7::_id_6F6C5CB39CD095B0();
  _id_702BFC08FABD86CB = _id_59FF79D681BB860C::_id_0D111733407F6518(damagedata.meansofdeath, damagedata.victim, damagedata.attacker, damagedata.damage, 1, _id_DFABE685A74F1B33);

  if(isDefined(damagedata.attacker) && damagedata.attacker scripts\mp\utility\killstreak::isjuggernaut())
    _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * getdvarfloat("dvar_44827DD333E801F5", 1);

  return _id_702BFC08FABD86CB;
}

_id_BDD92C05D3032F65() {
  if(istrue(level.skipprematch))
    return undefined;

  if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C() && isDefined(level._id_C360D548F96125F2) && level._id_C360D548F96125F2.size > 0) {
    _id_360EFB157EC1AA68 = level._id_C360D548F96125F2[randomint(level._id_C360D548F96125F2.size)];
    return vectortoangles(_id_360EFB157EC1AA68 - self getEye());
  }

  return undefined;
}

_id_7E904FF184E6794C(_id_9F4A3632D9F75D32, _id_D4884966C59032E3, spawnorigin, spawnangle, _id_5623FEABB8673FA2) {
  _id_060B36839D21113F = _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF();
  _id_580C0AB2F1D761BE = getdvarint("dvar_25AD2925D6075C8F", 0);

  if(_id_580C0AB2F1D761BE != 0) {
    level.skipprematch = 1;

    if(_id_580C0AB2F1D761BE == 2) {
      level.skipprematchdropspawn = 1;
      level.br_infils_disabled = 1;
      level thread _id_F6E343C0B9912601();
      spawnangle = scripts\engine\utility::_id_53C4C53197386572(spawnangle, (0, 60, 0));
      _id_29D9D2428185616D = [];
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", spawnorigin, spawnangle);
      scripts\mp\spawnlogic::addscriptedspawnpoints(_id_29D9D2428185616D);
    }
  } else {
    _id_D9D6C656A9FD19AC = 150.0;
    _id_054401A32BF2A02B = _id_1E4A61DB11011446::_id_CB40F77C51717EA1();
    _id_32C7D201A42335FF = _id_D9D6C656A9FD19AC / _id_054401A32BF2A02B;
    _id_78DE90A02FD7622B = _id_26CCBFE3954CACF4::_id_D6D3F0E8A701880F();
    level._id_2F78F22EDF92FAA9 = ceil(_id_78DE90A02FD7622B / _id_32C7D201A42335FF);
  }

  level.br_level._id_61321B51908D55CB = "classtable:classtable_br_bot_loadouts_phase1";
  level.br_level._id_61321C51908D57FE = "classtable:classtable_br_bot_loadouts_phase2";
  level.br_standard_loadout = _id_391B372CD3C0DDDC();
  level._id_5623FEABB8673FA2 = _id_5623FEABB8673FA2;
  _id_900EFE56E44A6C12();
  _id_26CCBFE3954CACF4::initialize(_id_9F4A3632D9F75D32);

  if(isDefined(_id_D4884966C59032E3) && _id_D4884966C59032E3 > 0)
    setDvar("dvar_749412E5DB698400", _id_D4884966C59032E3);

  level thread _id_40E63DD222434655::_id_C38398385AFC10FC();
}

_id_F6E343C0B9912601() {
  level waittill("player_spawned", player);
  player setclientomnvar("ui_br_infiled", 1);
  level waittill("infils_ready");
  level.br_c130spawndone = 1;
  player _id_724736FCF0FB6604::br_ammo_player_clear();
  player _id_724736FCF0FB6604::br_give_starting_ammo();
  _id_724736FCF0FB6604::br_ammo_update_weapons(player);
  player skydive_setdeploymentstatus(1);
  player skydive_setbasejumpingstatus(1);
}

_id_900EFE56E44A6C12() {
  _id_3E0899315F010884 = scripts\engine\utility::getStructArray("br_bot_landing_group", "script_noteworthy");
  zones = [];
  level._id_C360D548F96125F2 = [];

  foreach(_id_57C76A7B5032791F in _id_3E0899315F010884) {
    zone = spawnStruct();
    zone.name = _id_57C76A7B5032791F.target;
    zone._id_26910AE9F2257DF0 = _id_57C76A7B5032791F.origin;
    zone.weight = int(_id_57C76A7B5032791F.script_parameters);

    if(zone.weight <= 0)
      zone.weight = 1;

    zone._id_301D639DA97100C9 = [];
    zones[zones.size] = zone;
    _id_301D639DA97100C9 = _id_57C76A7B5032791F scripts\engine\utility::get_target_array();
    _id_301D639DA97100C9[_id_301D639DA97100C9.size] = _id_57C76A7B5032791F;

    foreach(_id_F3FCF5AF579ACD60 in _id_301D639DA97100C9) {
      struct = spawnStruct();
      struct.origin = getclosestpointonnavmesh(_id_F3FCF5AF579ACD60.origin);
      zone._id_301D639DA97100C9[zone._id_301D639DA97100C9.size] = struct;
      _id_49E421B4BF8CF977 = 0;

      if(_id_49E421B4BF8CF977)
        level._id_C360D548F96125F2[level._id_C360D548F96125F2.size] = _id_F3FCF5AF579ACD60.origin;
    }
  }

  level._id_0DBCB33D81F7D48D = spawnStruct();
  level._id_0DBCB33D81F7D48D.zones = zones;
  level thread _id_B0D6C85D2F044E95();
}

_id_B0D6C85D2F044E95() {
  _id_514703D9665F6F93();

  if(istrue(level.br_infils_disabled)) {
    return;
  }
  level waittill("br_c130_in_bounds");
  _id_74149D8336258367();
  level waittill("br_c130_left_bounds");
  _id_514703D9665F6F93();
}

_id_514703D9665F6F93() {
  zones = level._id_0DBCB33D81F7D48D.zones;
  _id_BE66DE030B25508C = 0;

  for(index = 0; index < zones.size; index++) {
    zone = zones[index];

    if(isDefined(zone)) {
      _id_BE66DE030B25508C = _id_BE66DE030B25508C + zone.weight;
      zone._id_68E87685AA19DA24 = _id_BE66DE030B25508C;
    }
  }

  level._id_0DBCB33D81F7D48D._id_F51F037FB790E57C = _id_BE66DE030B25508C;
}

_id_74149D8336258367() {
  _id_DA9D0B7A05252CE1 = 100;
  zones = level._id_0DBCB33D81F7D48D.zones;
  _id_F51F037FB790E57C = 0;
  startpoint = level.infilstruct.c130pathstruct.startpt;
  endpoint = level.infilstruct.c130pathstruct.endpt;
  maxdistance = level._id_5623FEABB8673FA2;

  if(isDefined(maxdistance))
    maxdistancesq = 1.0 * maxdistance * maxdistance;
  else
    maxdistancesq = undefined;

  for(index = 0; index < zones.size; index++) {
    zone = zones[index];
    weight = zone.weight;

    if(isDefined(maxdistancesq)) {
      _id_1FDB895A11EF0C58 = vectorfromlinetopoint(startpoint, endpoint, zone._id_26910AE9F2257DF0);
      _id_4EB801042B324702 = length2dsquared(_id_1FDB895A11EF0C58);

      if(_id_4EB801042B324702 <= maxdistancesq)
        weight = weight * _id_DA9D0B7A05252CE1;
    }

    if(_id_2695A20D4011076D::_id_C11714256F856E10(zone._id_26910AE9F2257DF0))
      weight = weight * _id_DA9D0B7A05252CE1;

    _id_F51F037FB790E57C = _id_F51F037FB790E57C + weight;
    zone._id_68E87685AA19DA24 = _id_F51F037FB790E57C;
  }

  level._id_0DBCB33D81F7D48D._id_F51F037FB790E57C = _id_F51F037FB790E57C;
}

getbestspectatecandidate(victim, attacker) {
  playertospectate = undefined;

  if(isvalidspectatetarget(victim.nextplayertospectate)) {
    playertospectate = victim.nextplayertospectate;
    victim.nextplayertospectate = undefined;
    return playertospectate;
  }

  playertospectate = _id_C041447B9139985B(victim);

  if(isvalidspectatetarget(playertospectate))
    return playertospectate;

  if(isvalidspectatetarget(attacker))
    return attacker;

  _id_B0DFEEB00D0ACF03 = _id_B78E0439FEC18199(victim);

  if(isDefined(_id_B0DFEEB00D0ACF03))
    return _id_B0DFEEB00D0ACF03;

  _id_1D17D55B8C1EC9CF = undefined;

  foreach(bot in level.players) {
    if(bot != victim && isvalidspectatetarget(bot)) {
      if(!bot _id_26CCBFE3954CACF4::_id_D012729EAC1E7053())
        return bot;
      else if(!isDefined(_id_1D17D55B8C1EC9CF))
        _id_1D17D55B8C1EC9CF = bot;
    }
  }

  if(isDefined(_id_1D17D55B8C1EC9CF))
    return _id_1D17D55B8C1EC9CF;

  return undefined;
}

isvalidspectatetarget(player) {
  if(!isDefined(player))
    return 0;

  if(player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014())
    return 0;

  if(!_id_59FF79D681BB860C::_id_DED80385EA7471DB(player))
    return 0;

  if(istrue(player._id_7CA8AC9793BC9C22))
    return 0;

  return !istrue(player.br_iseliminated);
}

_id_C041447B9139985B(victim) {
  if(istrue(level.onlinegame) && isDefined(victim) && victim getprivatepartysize()) {
    _id_AA90F92CE9F7F1DE = victim getfireteammembers();
    _id_CAD1692006EFD64A = undefined;

    foreach(player in _id_AA90F92CE9F7F1DE) {
      if(player == victim) {
        continue;
      }
      if(player isfireteamleader() && isvalidspectatetarget(player))
        return player;
    }

    _id_CAD1692006EFD64A = undefined;
    _id_42CA41C7DADAE0C0 = undefined;

    foreach(player in _id_AA90F92CE9F7F1DE) {
      if(victim != player && isvalidspectatetarget(player)) {
        if(isDefined(victim.lastdeathpos)) {
          _id_12810E24E83ACB1D = distance2dsquared(victim.lastdeathpos, player.origin);

          if(!isDefined(_id_42CA41C7DADAE0C0) || _id_12810E24E83ACB1D < _id_42CA41C7DADAE0C0) {
            _id_CAD1692006EFD64A = player;
            _id_42CA41C7DADAE0C0 = _id_12810E24E83ACB1D;
          }
        } else
          return player;
      }
    }

    if(isDefined(_id_CAD1692006EFD64A))
      return _id_CAD1692006EFD64A;
  }

  _id_8BE8967782F3E0E3 = undefined;

  if(isDefined(victim.team)) {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 1);

    if(isDefined(victim.lastdeathpos)) {
      _id_E9DC9ECBE66722FE = undefined;
      _id_2854E504EC9ED2BD = undefined;
      _id_42CA41C7DADAE0C0 = undefined;

      foreach(player in _id_6D5ED003AF1F9612) {
        _id_12810E24E83ACB1D = distance2dsquared(victim.lastdeathpos, player.origin);

        if(_id_78E25EB20DBFE396(player)) {
          if(!isDefined(_id_2854E504EC9ED2BD) || _id_12810E24E83ACB1D < _id_2854E504EC9ED2BD) {
            _id_E9DC9ECBE66722FE = player;
            _id_2854E504EC9ED2BD = _id_12810E24E83ACB1D;
          }

          continue;
        }

        if(!isDefined(_id_E9DC9ECBE66722FE) && isvalidspectatetarget(player)) {
          if(!isDefined(_id_42CA41C7DADAE0C0) || _id_12810E24E83ACB1D < _id_42CA41C7DADAE0C0) {
            _id_8BE8967782F3E0E3 = player;
            _id_42CA41C7DADAE0C0 = _id_12810E24E83ACB1D;
          }
        }
      }

      if(isDefined(_id_E9DC9ECBE66722FE))
        return _id_E9DC9ECBE66722FE;
    } else {
      foreach(player in _id_6D5ED003AF1F9612) {
        if(_id_78E25EB20DBFE396(player))
          return player;
        else if(isvalidspectatetarget(player))
          _id_8BE8967782F3E0E3 = player;
      }
    }
  }

  return _id_8BE8967782F3E0E3;
}

_id_B78E0439FEC18199(victim) {
  playertospectate = undefined;
  _id_45C781AA56FC57EC = level.players.size;

  foreach(player in level.players) {
    if(player != victim && _id_78E25EB20DBFE396(player)) {
      _id_721982228624D657 = _id_6489FCDFE6FA2E36::getspectatorsofplayer(player);

      if(_id_721982228624D657.size < _id_45C781AA56FC57EC) {
        _id_45C781AA56FC57EC = _id_721982228624D657.size;
        playertospectate = player;
      }
    }
  }

  return playertospectate;
}

_id_78E25EB20DBFE396(player) {
  if(!isDefined(player) || isai(player))
    return 0;

  if(!_id_59FF79D681BB860C::_id_DED80385EA7471DB(player))
    return 0;

  return !istrue(player.br_iseliminated);
}

_id_06F2A3C608D954D4(immediate) {
  _id_156F390A5362BC55 = _id_26CCBFE3954CACF4::_id_749723C2A45A0233();
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  if(!istrue(immediate)) {
    foreach(_id_80EF668C09FFB70F in _id_7273312620004BC3) {
      if(!_id_80EF668C09FFB70F _id_40E63DD222434655::_id_A9CBF557DC66D201() && _id_80EF668C09FFB70F != self)
        return;
    }

    foreach(_id_B4ADDE4C68BB0F24 in _id_156F390A5362BC55) {
      if(_id_B4ADDE4C68BB0F24.team == self.team)
        return;
    }
  }

  totalplayers = level.players.size;
  _id_A4C3A5AFE5B8DA9B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < totalplayers; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(!player _id_40E63DD222434655::_id_A9CBF557DC66D201() && player.team != self.team)
      _id_A4C3A5AFE5B8DA9B[player.team] = 1;
  }

  foreach(_id_B4ADDE4C68BB0F24 in _id_156F390A5362BC55) {
    if(_id_B4ADDE4C68BB0F24.team != self.team)
      _id_A4C3A5AFE5B8DA9B[_id_B4ADDE4C68BB0F24.team] = 1;
  }

  _id_E6D7DE89AE05A160 = _id_A4C3A5AFE5B8DA9B.size + 1;

  foreach(_id_80EF668C09FFB70F in _id_7273312620004BC3)
  _id_80EF668C09FFB70F.pers["br_place"] = _id_E6D7DE89AE05A160;

  self.pers["br_place"] = _id_E6D7DE89AE05A160;
}

_id_305F60799DC60D7C(player) {
  player _id_06F2A3C608D954D4();
  player.pers["br_survival_time"] = gettime() - level.starttime;

  if(isDefined(player.pers["telemetry"]._id_4ECAC4D4233CECA4))
    player.pers["telemetry"]._id_4ECAC4D4233CECA4 = 0;
}

_id_0F5CFF6DA44A3790(player) {
  _id_305F60799DC60D7C(player);

  if(isai(player))
    player thread _id_F6E88D354CB8D3CD();
}

_id_F6E88D354CB8D3CD() {
  _id_49A1F28198874781 = getdvarint("dvar_C794E905073B07A4", 10);
  _id_24770E5472FF8C0B = getdvarint("dvar_CFFA0859EF69D472", 35);
  wait(randomintrange(_id_49A1F28198874781, _id_24770E5472FF8C0B));

  if(isDefined(self) && (_id_40E63DD222434655::_id_A9CBF557DC66D201() || isDefined(self getspectatingplayer())))
    _id_40E63DD222434655::kickplayer();
}

_id_6029066AB0D7003B(player) {
  player.pers["br_place"] = 0;
  player.pers["br_survival_time"] = 0;
  player.pers["telemetry"]._id_4ECAC4D4233CECA4 = 1;
}

_id_A6C8F6E16F9ACACC() {
  _id_B84A7E9373DCBE39 = 10;
  _id_0AC2E2DC79F3D177 = randomint(_id_B84A7E9373DCBE39);

  if(getomnvar("ui_only_default_loadouts") == 1) {
    _id_D7D1C6C477AF4621 = 100;
    _id_0AC2E2DC79F3D177 = _id_0AC2E2DC79F3D177 + _id_D7D1C6C477AF4621;
  }

  _id_2D36749FDFFC49B4 = scripts\mp\menus::getclasschoice(_id_0AC2E2DC79F3D177);
  self.pers["class"] = _id_2D36749FDFFC49B4;
  self.class = _id_2D36749FDFFC49B4;
  scripts\mp\class::preloadandqueueclass(_id_2D36749FDFFC49B4);
  return 1;
}

_id_B8CE7E76DC2DC587(player, _id_4DFC1F5D7602B10D) {
  _id_67708F418B1FAC79::playergulagautowin("vanillaKioskRevive", player, _id_4DFC1F5D7602B10D);
  _id_6AFF3948CF4CCA03::playersetplundercount(0);
}

_id_3363DE115C63751D(_id_A37E3649CFB19F73, _id_AC0F8BE89FA21057) {
  _id_2A05C2D2D4716320 = getdvarint("dvar_2D936FB12B19CA30", 0);

  if(_id_2A05C2D2D4716320) {
    _id_B710552E5D79A601 = clamp(_id_A37E3649CFB19F73 - _id_AC0F8BE89FA21057, 0, 65535);
    setomnvar("ui_match_start_countdown_not_reach_minplayer", int(_id_B710552E5D79A601));
  }
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  gametype = scripts\mp\utility\game::getsubgametype();

  if(!istrue(level.br_infils_disabled)) {
    thread _id_79D674479A5744BB();
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_79D674479A5744BB() {
  self waittill("infil_move");
  gametype = scripts\mp\utility\game::getsubgametype();

  if(gametype == "mini_mgl")
    scripts\mp\hud_message::showsplash("br_gametype_mini_mgl_match_introduction");
  else if(gametype == "resurgence_mgl")
    scripts\mp\hud_message::showsplash("br_gametype_resurgence_match_introduction");
  else if(gametype == "champion")
    scripts\mp\hud_message::showsplash("br_gametype_champion_match_introduction");
  else
    scripts\mp\hud_message::showsplash("br_gametype_vanilla_match_introduction");
}

_id_FB899558E6107F9E() {
  return 1;
}

_id_0BB8B7CDCE37CCAB() {
  _id_7E816FA0720D38A1::_id_543A0A3113FF89F7();
  _id_59FF79D681BB860C::_id_21B2D65575E9C0CC("Combat");
  self botsetflag("allow_laststand_decision", 1);
  self.entity_number = self getentitynumber();
  self._id_A80AB26B5150A5EE = self botgetdifficulty();
  self.difficulty = self botgetdifficulty();
  self._id_AB5F5270CB22E3C8 = 1;
}

_id_EAC6CE0D8138984B() {
  self notify("bot_suspended");
  waitframe();
}

_id_3500D0E31F6EBEE5() {
  level endon("game_ended");
  level waittill("prematch_over");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("OnNormalDeath", ::onnormaldeath);
  level._id_46E88D936DB0725C = [];
  level._id_374E02799AE6CE92 = getdvarint("dvar_229F46B375F83420", 75);
  _id_13F6D1136F0A1B51::_id_C153B3BE3A868971();
  _id_13F6D1136F0A1B51::_id_B7752DE07EA1870C();
  _id_13F6D1136F0A1B51::_id_8C14093FB58B4E65();
  _id_13F6D1136F0A1B51::_id_C2A7EA1687DFD306();
  _id_13F6D1136F0A1B51::_id_EEE04FF98CCC9115();
  level thread _id_4867C96232E415F2();
}

_id_4867C96232E415F2() {
  level endon("game_ended");
  _id_27782B1982F9CF0B = getdvarint("dvar_2F01A491B1940657", 5);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_27782B1982F9CF0B; _id_AC0E594AC96AA3A8++) {
    _id_4641C1D0A73E0798 = getdvarint(_func_2EF675C13CA1C4AF("dvar_02E0F43ADF003F32", _id_AC0E594AC96AA3A8), -1);

    if(_id_4641C1D0A73E0798 < 0) {
      return;
    }
    wait(_id_4641C1D0A73E0798);
    _id_58B112A46ED059BA = _id_AC0E594AC96AA3A8 > 0;
    _id_A45AEDB0CB5A5FF6 = !_id_58B112A46ED059BA;
    _id_13F6D1136F0A1B51::_id_8B460428CB7E01AC(0, _id_58B112A46ED059BA, _id_A45AEDB0CB5A5FF6);
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  level notify("havoc_player_killed", attacker);

  foreach(_id_847D2A046CAA4B54 in level._id_46E88D936DB0725C)[[_id_847D2A046CAA4B54]](victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  victim._id_C115C6E4D9EEE7CA = undefined;
}