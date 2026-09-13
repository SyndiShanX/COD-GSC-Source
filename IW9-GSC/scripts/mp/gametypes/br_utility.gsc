/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_utility.gsc
***********************************************/

_id_1B5DA10393C9C50E(_id_3C0C203DF6F6B6C5) {
  player = self;
  level endon("game_ended");
  level endon("all_players_dead");
  player endon("squad_wiped");
  player endon("br_player_revived");
  player endon("disconnect");
  player notify("rankedQuitTimer_started");
  player endon("rankedQuitTimer_started");

  if(scripts\mp\teams::getactiveteamcount() > 1) {
    remainingtime = scripts\engine\utility::ter_op(istrue(_id_3C0C203DF6F6B6C5), 3000, 180000);
    _id_B87EDAF5A7D50525 = istrue(_id_3C0C203DF6F6B6C5);
    _id_071DF66B50009254 = gettime();
    _id_B47523A062A4238D = _id_071DF66B50009254 + remainingtime;

    while(remainingtime > 0) {
      player setclientomnvar("ui_league_play_br_leave_penalty_timer", remainingtime);
      remainingtime = _id_B47523A062A4238D - gettime();

      if(!istrue(_id_B87EDAF5A7D50525) && _id_1E4A61DB11011446::_id_F8167AAB51948BF0(player.team)) {
        _id_B87EDAF5A7D50525 = 1;
        _id_B47523A062A4238D = min(_id_B47523A062A4238D, _id_071DF66B50009254 + 3000);
      }

      wait 1;
    }
  }

  player setclientomnvar("ui_league_play_br_leave_penalty_timer", 0);
  player setclientomnvar("ui_league_play_br_can_leave_with_party", istrue(_id_3C0C203DF6F6B6C5));
}

_id_B5B049C4B47CF929() {
  return 3000;
}

markplayeraseliminated(player, context) {
  if(istrue(player.br_iseliminated)) {
    return;
  }
  player _id_B6371A65209A055F(1, context);
  player.br_iseliminated = 1;
  player._id_014110AD8D5069E7 = gettime();
  level notify("br_player_eliminated");

  if(istrue(level._id_77907D733ABE8B63)) {
    player setclientomnvar("ui_leagueplay_allow_quit", 0);
    player setclientomnvar("ui_league_play_br_leave_penalty_timer", 180000);
    player thread _id_1B5DA10393C9C50E(_id_1E4A61DB11011446::_id_F8167AAB51948BF0(player.team));
  }

  _id_72AF5A878A9D3397::_id_0F5CFF6DA44A3790(player, 1);
  _id_362C58E8BB39BCDA::runbrgametypefunc("onMarkPlayerAsEliminated", player);
  player updateplayereliminatedomnvar(context);
  player scripts\mp\gamelogic::updateplayerleaderboardstats();
}

unmarkplayeraseliminated(player, context) {
  player _id_B6371A65209A055F(0, context);
  player.br_iseliminated = 0;
  player._id_014110AD8D5069E7 = -1;
  _id_72AF5A878A9D3397::_id_0F5CFF6DA44A3790(player, 0);
  _id_362C58E8BB39BCDA::runbrgametypefunc("onUnmarkPlayerAsEliminated", player);
  player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  player notify("br_player_revived");
  player setclientomnvar("ui_leagueplay_allow_quit", 3);
  player setclientomnvar("ui_league_play_br_leave_penalty_timer", -1);
  player updateplayereliminatedomnvar(context);
}

updateplayereliminatedomnvar(context) {
  player = self;
  _id_081DAB8953B9DF82 = 0;

  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team, player._id_0FF97225579DE16A, 0);
    _id_BF873008EDC8415F = level.maxsquadsize;
  } else {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");
    _id_BF873008EDC8415F = level.maxteamsize;
  }

  foreach(_id_80EF668C09FFB70F in _id_6D5ED003AF1F9612) {
    if(getdvarint("dvar_F817C06D779EC53C", 0)) {
      if(!isDefined(context))
        context = "?";

      logstring("updatePlayerEliminatedOmnvar - time = " + gettime() + ", player = " + _id_80EF668C09FFB70F.name + ", team = " + _id_80EF668C09FFB70F.team + ", marked player = " + (_id_80EF668C09FFB70F == self) + ", br_isEliminated = " + istrue(_id_80EF668C09FFB70F.br_iseliminated) + ", context = " + context + ", sessionuimemberindex = " + _id_80EF668C09FFB70F._id_3F78C6A0862F9E25);
    }

    if(istrue(_id_80EF668C09FFB70F.br_iseliminated))
      _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 | 1 << _id_80EF668C09FFB70F._id_3F78C6A0862F9E25;
  }

  foreach(_id_80EF668C09FFB70F in _id_6D5ED003AF1F9612)
  _id_80EF668C09FFB70F setclientomnvar("ui_br_eliminated", _id_081DAB8953B9DF82);
}

_id_8311407EA8B66F9A(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(getdvarint("dvar_11FA4C3AB4C1653D", 1) && !_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    _id_F300F1FCF10A85C7 = "e?";
    meansofdeath = "m?";
    attackernum = "a?";
    _id_80A3EA58558D7D27 = "i?";

    if(isDefined(self))
      _id_F300F1FCF10A85C7 = self getentitynumber();

    if(isDefined(smeansofdeath))
      meansofdeath = smeansofdeath;

    if(isDefined(attacker) && !isstruct(attacker))
      attackernum = attacker getentitynumber();

    if(isDefined(einflictor))
      _id_80A3EA58558D7D27 = einflictor getentitynumber();

    stringref = "*-- Kill: " + gettime() + ", ";
    stringref = stringref + (_id_F300F1FCF10A85C7 + ", ");
    stringref = stringref + (meansofdeath + ", ");
    stringref = stringref + (attackernum + ", ");
    stringref = stringref + _id_80A3EA58558D7D27;
    logstring(stringref);
  }
}

_id_B6371A65209A055F(_id_D740DBB6749F0C7A, context) {
  if(getdvarint("dvar_11FA4C3AB4C1653D", 1) && !_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    stringref = scripts\engine\utility::ter_op(istrue(_id_D740DBB6749F0C7A), "*-- Mark: ", "*-- Unmark: ") + gettime() + ", ";
    stringref = stringref + (scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "?") + ", ");
    stringref = stringref + scripts\engine\utility::ter_op(isDefined(context), context, "?");
    logstring(stringref);
  }
}

_id_B5483AF58EE9F2C3(_id_AD8AEC47E1A86534, team, context) {
  if(getdvarint("dvar_11FA4C3AB4C1653D", 1) && !_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    stringref = scripts\engine\utility::ter_op(istrue(_id_AD8AEC47E1A86534), "*-- Add: ", "*-- Remove: ") + gettime() + ", ";
    stringref = stringref + (scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "?") + ", " + team + ", ");
    stringref = stringref + scripts\engine\utility::ter_op(isDefined(context), context, "none");
    logstring(stringref);
  }
}

_id_DEF20F6AA082FCF5(team) {
  if(getdvarint("dvar_11FA4C3AB4C1653D", 1) && !_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    stringref = "*-- Team Elim: " + gettime() + ", " + team;
    logstring(stringref);
  }
}

_id_22A0E95DD4174C81() {
  index = 0;
  _id_54B25677AAA042BD = [];

  foreach(player in level.players) {
    if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }
    _id_54B25677AAA042BD[index] = player;
    index++;
  }

  return _id_54B25677AAA042BD;
}