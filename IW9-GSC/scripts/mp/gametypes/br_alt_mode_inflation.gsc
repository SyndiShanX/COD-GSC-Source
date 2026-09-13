/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_inflation.gsc
**********************************************************/

init() {
  if(!getdvarint("scr_br_alt_mode_inflation", 0)) {
    return;
  }
  level.br_alt_mode_inflation = spawnStruct();
  level.br_alt_mode_inflation.disabled = 0;
  level.br_alt_mode_inflation.cost = getdvarint("dvar_EC3657BEE62B649E", 45);
  level.br_alt_mode_inflation.drop_percent = getdvarfloat("scr_br_alt_mode_inflation_drop_percent", 1.0);
  level.br_alt_mode_inflation.drop_max = getdvarint("scr_br_alt_mode_inflation_drop_max", -1);
  level.br_alt_mode_inflation.respawn_delay = getdvarfloat("dvar_82A04F5B65ED7D09", 10.0);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onStartGameType", ::onstartgametype);

  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimer", ::circletimer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("postPlunder", ::postplunder);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", ::markplayeraseliminatedonkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerGulagAutoWinWait", ::playergulagautowinwait);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("triggerRespawnOverlay", ::triggerrespawnoverlay);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("assignSpectatorToSpectatePlayer", ::assignspectatortospectateplayer);

  if(!getdvarint("dvar_83FC1574C6A65EFD", 0))
    _id_362C58E8BB39BCDA::disablefeature("gulag");

  _id_362C58E8BB39BCDA::disablefeature("useTokenToReviveTeammate");
  _id_362C58E8BB39BCDA::disablefeature("gulagWinnerRestoreLoadoutUseGulag");
  thread initcallbacks();
}

onstartgametype() {
  if(getdvarint("dvar_970AF3DF7A79F0DE", 0)) {
    _id_3D20EFF1D409BD00::_id_97B175CEC5B685BE(getDvar("dvar_63C14B4D114A59EF", "mp/classtable_br_resurgence_mgl.csv"));
    _id_3D20EFF1D409BD00::_id_97B175CEC5B685BE(getDvar("dvar_63C14C4D114A5C22", "mp/classtable_br_resurgence_mgl_circle2.csv"));
    _id_3D20EFF1D409BD00::_id_97B175CEC5B685BE(getDvar("dvar_63C14D4D114A5E55", "mp/classtable_br_resurgence_mgl_circle3.csv"));
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("playerNakedDropLoadout");
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::playernakeddroploadout);
  }

  if(getdvarint("dvar_2F7E5613CEBA7AB3", 1)) {
    _id_995645F317111541 = scripts\mp\hud_message::getsplashtablename();
    scripts\mp\events::_id_C9147B02D8B3DD0A("stat_9A53FCA16067806B", _id_995645F317111541);
  }

  if(getdvarint("dvar_124CACEDF61FAC57", 1))
    thread _id_93714B099036E7B6();
}

playernakeddroploadout() {
  if(!istrue(self._id_3D7067BB35742D0D) || !isDefined(level.br_standard_loadout))
    level.br_standard_loadout = _id_4A0D1F5F6BE0F8C7::_id_391B372CD3C0DDDC();

  loadout = level.br_standard_loadout;

  if(isDefined(level._id_C04B5EDF3F9EA340) && istrue(self._id_3D7067BB35742D0D)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
      circleindex = min(level.br_circle.circleindex, level._id_C04B5EDF3F9EA340.size);

    if(_id_2695A20D4011076D::_id_FC0F865DDCF551AD())
      circleindex = circleindex - 1;

    _id_1292261F2F456346 = [getdvarint("dvar_9F16257CD6B2ED38", 1), getdvarint("dvar_9F16287CD6B2F3D1", 3)];
    _id_BFA18214A2CD5FDF = _id_1292261F2F456346.size;

    for(index = 0; index < _id_1292261F2F456346.size; index++) {
      if(circleindex < _id_1292261F2F456346[index]) {
        _id_BFA18214A2CD5FDF = index;
        break;
      }
    }

    if(isDefined(level._id_77C121D31E587BA8[_id_BFA18214A2CD5FDF]))
      loadout = level._id_C04B5EDF3F9EA340[_id_BFA18214A2CD5FDF][level._id_77C121D31E587BA8[_id_BFA18214A2CD5FDF]];
  }

  self._id_3D7067BB35742D0D = 1;
  level.br_standard_loadout = loadout;
  _id_1E4A61DB11011446::givestandardtableloadout(0, 1, 0);
  _id_07C40FA80892A721::givestartingarmor();
}

_id_93714B099036E7B6() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_6B3FE6B83B1C6B9E = _id_67708F418B1FAC79::getgulagclosedcircleindex();
  totaltime = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6B3FE6B83B1C6B9E; _id_AC0E594AC96AA3A8++)
    totaltime = totaltime + (level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8]);

  _id_F9F04F141AE1E4D4 = int(totaltime * 1000);
  _id_7BF1255A3715A632 = gettime();
  _id_3112E3DE7BF7F005 = _id_7BF1255A3715A632 + _id_F9F04F141AE1E4D4;
  thread _id_9A5CDFD1C2923154(_id_3112E3DE7BF7F005);
  wait(totaltime);
  setomnvarforallclients("ui_br_timed_feature_end_time", 0);
}

_id_9A5CDFD1C2923154(_id_3112E3DE7BF7F005) {
  level waittill("infils_ready");
  setomnvarforallclients("ui_br_resurgence_will_disable", 1);
  setomnvarforallclients("ui_br_timed_feature_end_time", int(_id_3112E3DE7BF7F005));
}

initcallbacks() {
  while(!isDefined(level.onplayerspawncallbacks))
    waitframe();

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  updaterespawnstatus();
}

playercanbuyrespawn() {
  return istrue(level.br_prematchstarted) && !istrue(self.br_iseliminated) && !level.br_alt_mode_inflation.disabled && self.plundercount >= level.br_alt_mode_inflation.cost;
}

playerdropplunderondeath(dropstruct, attacker) {
  if(!isDefined(self)) {
    return;
  }
  _id_43E1B640EEC49671 = self.plundercount;

  if(istrue(self.respawningfromtoken)) {
    _id_43E1B640EEC49671 = _id_43E1B640EEC49671 - level.br_alt_mode_inflation.cost;

    if(_id_43E1B640EEC49671 < 0)
      _id_43E1B640EEC49671 = 0;
  }

  if(!isDefined(_id_43E1B640EEC49671) || _id_43E1B640EEC49671 < 0)
    _id_43E1B640EEC49671 = 0;

  _id_B64F283113C99581 = int(_id_43E1B640EEC49671 * level.br_alt_mode_inflation.drop_percent);
  _id_43E1B640EEC49671 = _id_43E1B640EEC49671 - _id_B64F283113C99581;

  if(_id_43E1B640EEC49671 < 0)
    _id_43E1B640EEC49671 = 0;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    if(istrue(self.respawningfromtoken))
      self setclientomnvar("ui_br_alt_mode_inflation_respawn_state", 1);
    else
      self setclientomnvar("ui_br_alt_mode_inflation_respawn_state", 2);

    if(_id_B64F283113C99581 > 0) {
      self setclientomnvar("ui_br_alt_mode_inflation_plunder_lost", _id_B64F283113C99581);
      thread scripts\mp\rank::scoreeventpopup("stat_9A53FCA16067806B");
    }
  }

  _id_6AFF3948CF4CCA03::playersetplundercount(_id_43E1B640EEC49671, getsetplundercountdatanosplash());

  if(level.br_alt_mode_inflation.drop_max >= 0)
    _id_B64F283113C99581 = int(min(level.br_alt_mode_inflation.drop_max, _id_B64F283113C99581));

  if(isDefined(level.minplunderdropondeath) && level.minplunderdropondeath >= 0)
    _id_B64F283113C99581 = int(max(level.minplunderdropondeath, _id_B64F283113C99581));

  if(_id_B64F283113C99581 > 0)
    _id_6AFF3948CF4CCA03::dropcondensedplunder(_id_B64F283113C99581, dropstruct);

  return 1;
}

circletimer(circleindex) {
  if(!circleindex)
    _id_67708F418B1FAC79::setupgulagtimer();

  _id_6B3FE6B83B1C6B9E = _id_67708F418B1FAC79::getgulagclosedcircleindex();

  if(!level.br_alt_mode_inflation.disabled && circleindex >= _id_6B3FE6B83B1C6B9E) {
    level.br_alt_mode_inflation.disabled = 1;

    foreach(player in level.players) {
      if(!isDefined(player) || !isalive(player)) {
        continue;
      }
      skipsplash = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
      player updaterespawnstatus(skipsplash);
      _id_1671F48D05259D22::dangernotifyplayer(player, "cash_deploy_closed", 3);
    }
  }

  return 0;
}

postplunder(data) {
  skipsplash = 0;

  if(isDefined(data))
    skipsplash = data.skipsplash;

  updaterespawnstatus(skipsplash);
}

updaterespawnstatus(skipsplash) {
  if(playercanbuyrespawn()) {
    if(!_id_2CEDCC356F1B9FC8::hasrespawntoken()) {
      _id_7E52B56769FA7774::addrespawntoken(1);

      if(!istrue(skipsplash))
        thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_pickup");
    }
  } else if(_id_2CEDCC356F1B9FC8::hasrespawntoken()) {
    _id_7E52B56769FA7774::removerespawntoken();

    if(!istrue(skipsplash))
      thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_lost");
  }
}

_id_C879DA6A153928E8(timer) {
  _id_14183DF6F9AF8737::_id_FFF107D76EB56064();
  _id_14183DF6F9AF8737::_id_B12988FDF64EFE98(timer);
  _id_14183DF6F9AF8737::_id_230EA867CD69C598(0);
  _id_14183DF6F9AF8737::_id_1F013990C19FCD88();

  while(timer > 0) {
    if(isalive(self))
      timer = 0;
    else
      _id_14183DF6F9AF8737::_id_B12988FDF64EFE98(timer);

    wait 1;
    timer--;
  }

  _id_14183DF6F9AF8737::_id_BBEE565C7645EA29();
  _id_14183DF6F9AF8737::_id_B12988FDF64EFE98(0);
  _id_14183DF6F9AF8737::_id_230EA867CD69C598(0);
  self setclientomnvar("ui_br_alt_mode_inflation_respawn_state", 0);
}

showrespawntimer(timer) {
  waittillframeend;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

    if(_id_FAF0D2FAC3F47583 == "mini_mgl" || _id_FAF0D2FAC3F47583 == "vanilla") {
      thread _id_C879DA6A153928E8(int(timer));
      return;
    }
  } else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + timer * 1000));
    _id_67708F418B1FAC79::setplayeringulagjailextrainfo(1);
    thread hiderespawntimer(timer);
  }
}

hiderespawntimer(waittime) {
  self endon("disconnect");

  if(isDefined(waittime))
    wait(waittime);

  _id_67708F418B1FAC79::setplayeringulagjailextrainfo(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
}

getsetplundercountdatanosplash() {
  data = spawnStruct();
  data.skipsplash = 1;
  return data;
}

markplayeraseliminatedonkilled() {
  return 0;
}

playergulagautowinwait(_id_4AC881E2A39322A5, _id_57D71760971F748F) {
  if(!isDefined(_id_4AC881E2A39322A5)) {
    if(level.br_alt_mode_inflation.respawn_delay) {
      respawndelay = level.br_alt_mode_inflation.respawn_delay;
      thread showrespawntimer(respawndelay);
      wait(respawndelay);
      return 1;
    }
  }

  return 0;
}

triggerrespawnoverlay(_id_8D90BD1972A435BF) {
  return 1;
}

assignspectatortospectateplayer(spectator, playertospectate) {
  spectator notify("assignSpectatorToSpectatePlayerWaitForTeam");

  if(istrue(level.brspawnplayersending))
    return 0;

  if(!isDefined(playertospectate) || !isPlayer(playertospectate) || !isalive(playertospectate) && !isDefined(playertospectate.streampoint))
    return 0;

  if(spectator.team == playertospectate.team)
    return 0;

  if(!scripts\mp\utility\teams::getteamdata(spectator.team, "aliveCount"))
    return 0;

  thread assignspectatortospectatetryagain(spectator);
  return 1;
}

assignspectatortospectatetryagain(spectator) {
  level endon("brSpawnPlayersEnding");
  spectator endon("assignSpectatorToSpectatePlayerWaitForTeam");
  spectator endon("death_or_disconnect");
  spectator _id_6489FCDFE6FA2E36::playerspawnintermissionifneeded();
  spectator setclientomnvar("ui_show_spectateHud", spectator getentitynumber());
  wait 1.0;
  playertospectate = _id_6489FCDFE6FA2E36::getbestspectatecandidate(spectator);
  thread _id_6489FCDFE6FA2E36::assignspectatortospectateplayer(spectator, playertospectate);
}