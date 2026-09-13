/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_45f403e1732217d3.gsc
***********************************************/

init() {
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_start", ::_id_393BAF20DB478C0D);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_end", ::_id_F5F91665FE4DBA94);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_round_start", ::_id_8EEEA3969DF7E964);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_round_end", ::_id_D9D3A382EBBF5EDD);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_server_exit_level", ::_id_69DDF7A3E512A18A);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_first_connect", ::on_player_connect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_spawned", ::_id_061A6648C0A01CAD);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_death", ::_id_5F84AFC437FF71F9);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_disconnect", ::on_player_disconnect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_new_loadout_used", ::_id_60912F12EDBAE676);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_update_weapon_stats", ::_id_6A347A3138EC63E1);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_score_event", ::_id_AC6B649326F4B17E);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_game_event", ::_id_C72337759677531C);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_armor_auto_apply", ::_id_1879CE4FBA1CD65D);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_reload_cancel", ::_id_6A9AA1D51A6BACC3);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_dmz_on_exfil", ::_id_675FEB1C926F55A3);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_dmz_on_reinforce", ::_id_A884632EDEBE7D1E);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_dmz_on_lpcon_alert", ::_id_532119A556885727);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_dmz_on_container", ::_id_4FC7F0119FC38D0C);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_dmz_contract", ::_id_89D4104DBACB6AEF);
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_3D5389E7BAE53CE5, level);
  setdvarifuninitialized("dvar_817F686503CCDECF", 5);
}

_id_393BAF20DB478C0D() {
  _id_BBB1DABA2B06CB38 = getsystemtime();
  setmatchdata("commonMatchData", "utc_start_time_s", _id_BBB1DABA2B06CB38);
  setmatchdata("commonMatchData", "player_count_start", level.players.size);

  if(isDefined(game["telemetry"]))
    game["telemetry"]._id_BBB1DABA2B06CB38 = _id_BBB1DABA2B06CB38;

  _id_C8F690457A04A764 = scripts\mp\utility\game::getgametype();

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_C8F690457A04A764 = _id_C8F690457A04A764 + " hc";

  _id_32AE710BD6009C5D = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "";

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  _id_FA5B633F7DF67D3D = 0;

  if(istrue(level._id_EC2FB549B15AD827) || istrue(level._id_77907D733ABE8B63))
    _id_FA5B633F7DF67D3D = 1;

  _id_ACF2F1A05BFEA87F = getdvarint("party_maxplayers", -1);
  _id_527BEDD9C6434673 = _func_676CFE2AB64EA758();
  dlog_recordevent("dlog_event_mp_server_match_start", ["utc_start_time_s", _id_BBB1DABA2B06CB38, "map", level.script, "game_type", _id_C8F690457A04A764, "is_playtest", getdvarint("dvar_2E58447FA1CA4F20") && getdvarint("dvar_051F11C2E135ABC7"), "experiment_name", getDvar("experiment_name"), "dedi_server_guid", getdediserverguid(), "sub_game_type", _id_32AE710BD6009C5D, "playlist_id", _id_76C6444F1C3454AD, "playlist_name", _id_8F3E1B856A8C20B3, "is_offline", !level.onlinegame, "max_players_allowed", _id_ACF2F1A05BFEA87F, "frame_duration", _id_527BEDD9C6434673, "is_ranked", _id_FA5B633F7DF67D3D]);
  _id_37AAB353FE84A505 = "{\"game_type\":\"" + _id_C8F690457A04A764 + "\",\"sub_game_type\":\"" + _id_32AE710BD6009C5D + "\",\"map\":\"" + level.script + "\"}";
  _func_7BCD667FC073FC12("server_match_start", _id_37AAB353FE84A505);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\common\utility::trycall(level.matchdata_br_onmatchstart);

  onmatchbegin();
}

_id_F5F91665FE4DBA94(data) {
  _id_BBB1DABA2B06CB38 = 0;
  _id_AF0F7BFFF116DFE5 = 0;
  _id_BF9667D999B5EA7B = 0;
  _id_C8F690457A04A764 = scripts\mp\utility\game::getgametype();
  _id_19EB71D207A4B2B8 = 0;

  if(isDefined(game["telemetry"]._id_BBB1DABA2B06CB38))
    _id_BBB1DABA2B06CB38 = game["telemetry"]._id_BBB1DABA2B06CB38;

  if(isDefined(game["telemetry"]._id_AF0F7BFFF116DFE5))
    _id_AF0F7BFFF116DFE5 = game["telemetry"]._id_AF0F7BFFF116DFE5;

  if(isDefined(game["telemetry"]._id_BF9667D999B5EA7B))
    _id_BF9667D999B5EA7B = game["telemetry"]._id_BF9667D999B5EA7B;

  if(isDefined(game["telemetry"]._id_19EB71D207A4B2B8))
    _id_19EB71D207A4B2B8 = game["telemetry"]._id_19EB71D207A4B2B8;

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_C8F690457A04A764 = _id_C8F690457A04A764 + " hc";

  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "";

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  _id_E19CF53A2B0BC17E = 0;
  _id_A0FF08200C2D1BAD = 0;

  if(level.teambased) {
    _id_E19CF53A2B0BC17E = getteamscore("allies");
    _id_A0FF08200C2D1BAD = getteamscore("axis");
  }

  _id_ACF2F1A05BFEA87F = getdvarint("party_maxplayers", -1);
  _id_FA5B633F7DF67D3D = 0;

  if(istrue(level._id_EC2FB549B15AD827) || istrue(level._id_77907D733ABE8B63))
    _id_FA5B633F7DF67D3D = 1;

  _id_D4687BB3ED2B03B3 = _func_6B9F8406E6153597();
  dlog_recordevent("dlog_event_mp_server_match_end", ["utc_start_time_s", _id_BBB1DABA2B06CB38, "utc_end_time_s", getsystemtime(), "total_player_connections", _id_AF0F7BFFF116DFE5, "life_count", _id_BF9667D999B5EA7B, "playlist_id", _id_76C6444F1C3454AD, "playlist_name", _id_8F3E1B856A8C20B3, "game_type", _id_C8F690457A04A764, "map", level.script, "is_offline", !level.onlinegame, "allies_score", _id_E19CF53A2B0BC17E, "axis_score", _id_A0FF08200C2D1BAD, "game_event_count", _id_19EB71D207A4B2B8, "weapon_map_watermark", _func_949690BFCBCDC8CF(), "max_players_allowed", _id_ACF2F1A05BFEA87F, "is_ranked", _id_FA5B633F7DF67D3D, "is_archive_replay_recorded", _id_D4687BB3ED2B03B3]);
}

_id_8EEEA3969DF7E964(data) {
  if(isDefined(game["telemetry"]))
    game["telemetry"]._id_D780068F14AD2FB9 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
}

_id_D9D3A382EBBF5EDD(data) {
  _id_D780068F14AD2FB9 = 0;

  if(isDefined(game["telemetry"]._id_D780068F14AD2FB9))
    _id_D780068F14AD2FB9 = game["telemetry"]._id_D780068F14AD2FB9;

  _id_E19CF53A2B0BC17E = 0;
  _id_A0FF08200C2D1BAD = 0;

  if(level.teambased) {
    _id_E19CF53A2B0BC17E = getteamscore("allies");
    _id_A0FF08200C2D1BAD = getteamscore("axis");
  }

  dlog_recordevent("dlog_event_mp_server_round_end", ["round_start_time_ms", _id_D780068F14AD2FB9, "round_end_time_ms", _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime()), "allies_score", _id_E19CF53A2B0BC17E, "axis_score", _id_A0FF08200C2D1BAD]);
}

on_player_connect(player) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(!isDefined(player.pers["telemetry"]) || !isDefined(player.pers["telemetry"].connected)) {
    if(!isDefined(player.pers["telemetry"]))
      player.pers["telemetry"] = spawnStruct();

    if(isDefined(game["telemetry"]) && isDefined(game["telemetry"]._id_AF0F7BFFF116DFE5)) {
      player.pers["telemetry"]._id_37C32B4614072292 = game["telemetry"]._id_AF0F7BFFF116DFE5;
      game["telemetry"]._id_AF0F7BFFF116DFE5++;
    } else
      return;

    player.pers["telemetry"]._id_72AC055B0A1C5D26 = getsystemtime();
    player.pers["telemetry"].connected = 1;
    player.pers["telemetry"]._id_58E50AEE46852766 = 0;
    player.pers["telemetry"].hits = 0;
    _id_AD6A55B6A00B8585 = 0;

    if(level.onlinegame)
      _id_AD6A55B6A00B8585 = player isfireteamleader();

    _id_6D03EF228B7E0824 = "";
    _id_4F3F455FBAB30757 = "";
    _id_D04E9E6CE92647CC = -1;
    _id_31001B9803280DD1 = -1;
    _id_FC1B84C86013220B = "none";
    _id_3EA0196476741EAC = "none";
    _id_C8F690457A04A764 = scripts\mp\utility\game::getgametype();

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
      _id_C8F690457A04A764 = _id_C8F690457A04A764 + " hc";

    _id_32AE710BD6009C5D = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
    _id_76C6444F1C3454AD = 0;
    _id_8F3E1B856A8C20B3 = "";

    if(scripts\mp\utility\game::matchmakinggame()) {
      _id_76C6444F1C3454AD = getplaylistid();
      _id_8F3E1B856A8C20B3 = getplaylistname();
    }

    _id_37C32B4614072292 = 0;

    if(isDefined(player.pers["telemetry"]._id_37C32B4614072292))
      _id_37C32B4614072292 = player.pers["telemetry"]._id_37C32B4614072292;

    _id_C94B316C15AE2E15 = _func_4F9373A1227DB35C();

    if(!isDefined(_id_C94B316C15AE2E15))
      _id_C94B316C15AE2E15 = "";

    _id_5A0FC1D304E970EA = "unset";

    if(isDefined(player.sessionteam))
      _id_5A0FC1D304E970EA = player.sessionteam;

    if(isDefined(player.team))
      _id_5A0FC1D304E970EA = player.team;

    _id_FA5B633F7DF67D3D = 0;
    _id_5AF59BFE5A04A544 = 0;

    if(istrue(level._id_EC2FB549B15AD827)) {
      _id_FA5B633F7DF67D3D = 1;
      xuid = player getxuid();
      _id_5AF59BFE5A04A544 = _func_904672268EB8E3FE(xuid);
    } else if(istrue(level._id_77907D733ABE8B63))
      _id_FA5B633F7DF67D3D = 1;

    _id_D7E14469F82BA2E2 = player usinggamepad();
    _id_C779A0E1C7371EA3 = player _meth_C4EFA5F2C5066AA3();
    _id_6657412BBFE1F4E9 = _id_C779A0E1C7371EA3[0] + "." + _id_C779A0E1C7371EA3[1] + "." + _id_C779A0E1C7371EA3[2] + "." + _id_C779A0E1C7371EA3[3];
    player dlog_recordplayerevent("dlog_event_mp_player_match_start", ["utc_connect_time_s", player.pers["telemetry"]._id_72AC055B0A1C5D26, "team", _id_5A0FC1D304E970EA, "join_type", player getjointype(), "skill", player getskill(), "party_id", player getpartyid(), "is_party_host", _id_AD6A55B6A00B8585, "was_keyboardmouse", player _meth_989FAA3E2F2D8C47() != 1, "operator_allies", _id_6D03EF228B7E0824, "operator_axis", _id_4F3F455FBAB30757, "operator_allies_skin", _id_D04E9E6CE92647CC, "operator_axis_skin", _id_31001B9803280DD1, "operator_allies_execution_ref", _id_FC1B84C86013220B, "operator_axis_execution_ref", _id_3EA0196476741EAC, "map", level.script, "playlist_id", _id_76C6444F1C3454AD, "playlist_name", _id_8F3E1B856A8C20B3, "game_type", _id_C8F690457A04A764, "sub_game_type", _id_32AE710BD6009C5D, "connect_index", _id_37C32B4614072292, "lobby_id", _id_C94B316C15AE2E15, "is_ranked", _id_FA5B633F7DF67D3D, "ranked_skill_rating", _id_5AF59BFE5A04A544, "is_controller", _id_D7E14469F82BA2E2, "client_ip_address", _id_6657412BBFE1F4E9]);
    _func_7BCD667FC073FC12("player_match_start", "");

    if(!isDefined(player.pers["telemetry"]._id_B08F0F34CBD0C21A))
      player.pers["telemetry"]._id_B08F0F34CBD0C21A = 0;

    if(!isDefined(player.pers["telemetry"]._id_37C6C5876B1A64CD))
      player.pers["telemetry"]._id_37C6C5876B1A64CD = 0;

    if(!isDefined(player.pers["telemetry"]._id_6BE038725A124802))
      player.pers["telemetry"]._id_6BE038725A124802 = 0;

    if(!isDefined(player.pers["telemetry"]._id_438F1DC9B1F52A7F))
      player.pers["telemetry"]._id_438F1DC9B1F52A7F = 0;

    if(!isDefined(player.pers["telemetry"]._id_44E6F7522AE08173))
      player.pers["telemetry"]._id_44E6F7522AE08173 = 0;

    if(!isDefined(player.pers["telemetry"]._id_D5E1E009ED9EB9A8))
      player.pers["telemetry"]._id_D5E1E009ED9EB9A8 = 0;

    if(!isDefined(player.pers["telemetry"]._id_9BC5683C9FE914F0))
      player.pers["telemetry"]._id_9BC5683C9FE914F0 = 0;

    if(!isDefined(player.pers["telemetry"]._id_5E444DBA2B86C3AC))
      player.pers["telemetry"]._id_5E444DBA2B86C3AC = 0;

    if(!isDefined(player.pers["telemetry"]._id_A04E1E3880A078A8))
      player.pers["telemetry"]._id_A04E1E3880A078A8 = 0;

    if(!isDefined(player.pers["telemetry"]._id_2C0070B8E9CD250F))
      player.pers["telemetry"]._id_2C0070B8E9CD250F = 0;

    if(!isDefined(player.pers["telemetry"]._id_C60EFB14A77D9DB8))
      player.pers["telemetry"]._id_C60EFB14A77D9DB8 = 0;

    if(!isDefined(player.pers["telemetry"]._id_7FF2028C00F8827D))
      player.pers["telemetry"]._id_7FF2028C00F8827D = 0;

    if(!isDefined(player.pers["telemetry"]._id_4ECAC4D4233CECA4))
      player.pers["telemetry"]._id_4ECAC4D4233CECA4 = 1;
  }
}

_id_061A6648C0A01CAD(player) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(!isDefined(player.pers["telemetry"]))
    player.pers["telemetry"] = spawnStruct();

  if(!isDefined(player.pers["telemetry"].life))
    player.pers["telemetry"].life = spawnStruct();

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"]._id_BF9667D999B5EA7B)) {
    player.pers["telemetry"].life._id_6F9BBED303902680 = game["telemetry"]._id_BF9667D999B5EA7B;
    game["telemetry"]._id_BF9667D999B5EA7B++;
  }

  if(isDefined(player.pers["summary"]["xp"]))
    player.pers["telemetry"].life._id_2148FB703835EC1F = player.pers["summary"]["xp"];
  else
    player.pers["telemetry"].life._id_2148FB703835EC1F = 0;

  if(isDefined(player.score))
    player.pers["telemetry"].life._id_7E5250B5700DF037 = player.score;
  else
    player.pers["telemetry"].life._id_7E5250B5700DF037 = 0;

  if(isDefined(player.pers["telemetry"])) {
    if(player scripts\mp\utility\game::rankingenabled() && player hasplayerdata()) {
      _id_0E34D7C876B7BA0C = player getplayerdata("common", "mpProgression", "playerLevel", "xp");

      if(!isDefined(player.pers["telemetry"]._id_0E34D7C876B7BA0C))
        player.pers["telemetry"]._id_0E34D7C876B7BA0C = _id_0E34D7C876B7BA0C;

      if(!isDefined(player.pers["telemetry"]._id_9FEEF25FBCDCB32A))
        player.pers["telemetry"]._id_9FEEF25FBCDCB32A = player scripts\mp\rank::getrankforxp(_id_0E34D7C876B7BA0C);

      if(!isDefined(player.pers["telemetry"]._id_6BCB3D0DAF2B3334))
        player.pers["telemetry"]._id_6BCB3D0DAF2B3334 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "score");

      if(!isDefined(player.pers["telemetry"]._id_AED23C903E19C77B)) {
        player.pers["telemetry"]._id_AED23C903E19C77B = player getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
        return;
      }
    } else {
      player.pers["telemetry"]._id_0E34D7C876B7BA0C = 0;
      player.pers["telemetry"]._id_9FEEF25FBCDCB32A = 0;
      player.pers["telemetry"]._id_6BCB3D0DAF2B3334 = 0;
      player.pers["telemetry"]._id_AED23C903E19C77B = 0;
    }
  }
}

_id_69DDF7A3E512A18A() {
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    _id_4A6760982B403BAD::_id_766155419D15C501(player);
    player thread _id_6447F24ADDC0137E(data);
  }
}

_id_6447F24ADDC0137E(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"]._id_D6CAA636BC3FCE32)) {
    if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
      return;
    }
    if(istrue(player._id_06A91D0E80CC504E) && !istrue(level.gameended)) {
      return;
    }
    _id_FDF9B22D16276454 = 0;

    if(isDefined(player.pers["telemetry"]._id_72AC055B0A1C5D26))
      _id_FDF9B22D16276454 = player.pers["telemetry"]._id_72AC055B0A1C5D26;

    _id_1EEC5A842769CF24 = "stat_0000000000000000";

    if(isDefined(data._id_934DC135AAF6F953))
      _id_1EEC5A842769CF24 = data._id_934DC135AAF6F953;

    _id_9C38515978AEB24B = 0;

    if(level.teambased)
      _id_9C38515978AEB24B = int(player scripts\mp\rank::getteamrankxpmultiplier(player.team));

    _id_37C32B4614072292 = 0;

    if(isDefined(player.pers["telemetry"]._id_37C32B4614072292))
      _id_37C32B4614072292 = player.pers["telemetry"]._id_37C32B4614072292;

    _id_C202E23208D31722 = 0;
    _id_209230A2967FA7AA = 0;
    _id_330EB62149C07007 = 0;
    _id_AB693FD45098759F = 0;
    _id_6F5617C7AF942C8D = 0;
    _id_E03B6057466FBE8D = 0;
    _id_A53EEC6C068828EE = 0;
    _id_2676FBF905B33538 = 0;
    _id_DE29895DCA8987CE = 0;
    _id_47993E74569F91AA = 0;
    _id_6094A5433A14BD7A = 0;
    _id_0888938CD9E128CB = 0;

    if(player scripts\mp\utility\game::onlinestatsenabled()) {
      if(isDefined(player.pers["summary"]["xp"]))
        _id_C202E23208D31722 = player.pers["summary"]["xp"];

      if(isDefined(player.pers["summary"]["score"]))
        _id_209230A2967FA7AA = player.pers["summary"]["score"];

      if(isDefined(player.pers["summary"]["challenge"]))
        _id_330EB62149C07007 = player.pers["summary"]["challenge"];

      if(isDefined(player.pers["summary"]["match"]))
        _id_AB693FD45098759F = player.pers["summary"]["match"];

      if(isDefined(player.pers["summary"]["medal"]))
        _id_6F5617C7AF942C8D = player.pers["summary"]["medal"];

      if(isDefined(player.pers["summary"]["bonusXP"]))
        _id_E03B6057466FBE8D = player.pers["summary"]["bonusXP"];

      if(isDefined(player.pers["summary"]["misc"]))
        _id_A53EEC6C068828EE = player.pers["summary"]["misc"];

      if(isDefined(player.pers["summary"]["accolade"]))
        _id_2676FBF905B33538 = player.pers["summary"]["accolade"];

      if(isDefined(player.pers["summary"]["weaponXP"]))
        _id_DE29895DCA8987CE = player.pers["summary"]["weaponXP"];

      if(isDefined(player.pers["summary"]["operatorXP"]))
        _id_47993E74569F91AA = player.pers["summary"]["operatorXP"];

      if(isDefined(player.pers["summary"]["clanXP"]))
        _id_6094A5433A14BD7A = player.pers["summary"]["clanXP"];

      if(isDefined(player.pers["summary"]["battlepassXP"]))
        _id_0888938CD9E128CB = int(player.pers["summary"]["battlepassXP"]);
    }

    _id_B0F8F036D47C34BA = spawnStruct();
    _id_B0F8F036D47C34BA._id_9FEEF25FBCDCB32A = 0;

    if(isDefined(player.pers["telemetry"]._id_9FEEF25FBCDCB32A))
      _id_B0F8F036D47C34BA._id_9FEEF25FBCDCB32A = player.pers["telemetry"]._id_9FEEF25FBCDCB32A;

    _id_B0F8F036D47C34BA._id_0E34D7C876B7BA0C = 0;

    if(isDefined(player.pers["telemetry"]._id_0E34D7C876B7BA0C))
      _id_B0F8F036D47C34BA._id_0E34D7C876B7BA0C = player.pers["telemetry"]._id_0E34D7C876B7BA0C;

    _id_B0F8F036D47C34BA._id_6BCB3D0DAF2B3334 = 0;

    if(isDefined(player.pers["telemetry"]._id_6BCB3D0DAF2B3334))
      _id_B0F8F036D47C34BA._id_6BCB3D0DAF2B3334 = player.pers["telemetry"]._id_6BCB3D0DAF2B3334;

    _id_B0F8F036D47C34BA._id_AED23C903E19C77B = 0;

    if(isDefined(player.pers["telemetry"]._id_AED23C903E19C77B))
      _id_B0F8F036D47C34BA._id_AED23C903E19C77B = player.pers["telemetry"]._id_AED23C903E19C77B;

    if(player scripts\mp\utility\game::rankingenabled() && player hasplayerdata()) {
      _id_B0F8F036D47C34BA._id_3A6757BA728AE8D5 = player getplayerdata("common", "mpProgression", "playerLevel", "xp");
      _id_B0F8F036D47C34BA._id_55B6F45E3BE122DF = player scripts\mp\rank::getrankforxp(_id_B0F8F036D47C34BA._id_3A6757BA728AE8D5);
      _id_B0F8F036D47C34BA._id_25645BA4FF5CDA6D = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "score");
      _id_B0F8F036D47C34BA._id_10F2DE9195564ADE = player getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
      _id_B0F8F036D47C34BA._id_D61560EFC278B7A4 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "kills");
      _id_B0F8F036D47C34BA._id_A0CD1C855A1250C0 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "deaths");
      _id_B0F8F036D47C34BA._id_C0D3C62EC53C28FC = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "wins");
      _id_B0F8F036D47C34BA._id_669752B7B918F434 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "losses");
      _id_B0F8F036D47C34BA._id_9D19049F02571AD9 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "hits");
      _id_B0F8F036D47C34BA._id_B5C7BCDDE58256AB = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "misses");
      _id_B0F8F036D47C34BA._id_D3C98DD0C60A3D47 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "wallbangs");
      _id_B0F8F036D47C34BA._id_B38FD08DE2BF9452 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "combatStats", "nearMisses");
      _id_B0F8F036D47C34BA._id_24D2457257A7795C = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "gamesPlayed");
      _id_B0F8F036D47C34BA._id_593F59C512901CD5 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "matchStats", "timePlayedTotal");
    } else {
      _id_B0F8F036D47C34BA._id_3A6757BA728AE8D5 = 0;
      _id_B0F8F036D47C34BA._id_55B6F45E3BE122DF = 0;
      _id_B0F8F036D47C34BA._id_25645BA4FF5CDA6D = 0;
      _id_B0F8F036D47C34BA._id_10F2DE9195564ADE = 0;
      _id_B0F8F036D47C34BA._id_D61560EFC278B7A4 = 0;
      _id_B0F8F036D47C34BA._id_A0CD1C855A1250C0 = 0;
      _id_B0F8F036D47C34BA._id_C0D3C62EC53C28FC = 0;
      _id_B0F8F036D47C34BA._id_669752B7B918F434 = 0;
      _id_B0F8F036D47C34BA._id_9D19049F02571AD9 = 0;
      _id_B0F8F036D47C34BA._id_B5C7BCDDE58256AB = 0;
      _id_B0F8F036D47C34BA._id_D3C98DD0C60A3D47 = 0;
      _id_B0F8F036D47C34BA._id_B38FD08DE2BF9452 = 0;
      _id_B0F8F036D47C34BA._id_24D2457257A7795C = 0;
      _id_B0F8F036D47C34BA._id_593F59C512901CD5 = 0;
    }

    _id_7E130E201FB47CA3 = -1;
    _id_DDC1CBCF13DE68DF = 0;
    _id_F6DFD9CA21BE2BDB = 0;

    if(isDefined(data._id_934DC135AAF6F953)) {
      if(scripts\mp\utility\game::isroundbased())
        _id_7E130E201FB47CA3 = game["roundsPlayed"];

      if(level.teambased) {
        if(isDefined(player.team)) {
          if(player.team == "allies") {
            _id_DDC1CBCF13DE68DF = getteamscore("allies");
            _id_F6DFD9CA21BE2BDB = getteamscore("axis");
          } else if(player.team == "axis") {
            _id_DDC1CBCF13DE68DF = getteamscore("axis");
            _id_F6DFD9CA21BE2BDB = getteamscore("allies");
          }
        }
      }
    }

    _id_3ECB392A578C4F31 = 0.0;
    _id_D0A6F986AE2AB0CA = 0.0;

    if(isDefined(player.pers["movementUpdateCount"]) && player.pers["movementUpdateCount"] >= 30) {
      _id_3ECB392A578C4F31 = player.pers["movingTotal"] / (player.pers["movementUpdateCount"] / 5) * 100;
      _id_D0A6F986AE2AB0CA = player.pers["distanceTotal"] / player.pers["movementUpdateCount"];
    }

    damage_done = player scripts\mp\utility\stats::getpersstat("damage");

    if(!isDefined(damage_done))
      damage_done = 0;

    damage_taken = player scripts\mp\utility\stats::getpersstat("damageTaken");

    if(!isDefined(damage_taken))
      damage_taken = 0;

    _id_3D1EA5C9BF625DE6 = 0.0;

    if(isDefined(player.pers["totalDistTraveled"]))
      _id_3D1EA5C9BF625DE6 = float(player.pers["totalDistTraveled"]);

    _id_4D1DB612C5B9184B = 0.0;
    _id_C1480A81B0387196 = player scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
    _id_18E9670604A31D9F = player scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits");

    if(isDefined(_id_C1480A81B0387196) && isDefined(_id_18E9670604A31D9F) && _id_C1480A81B0387196 > 0)
      _id_4D1DB612C5B9184B = float(_id_18E9670604A31D9F / _id_C1480A81B0387196 * 100);

    _id_05E5C27FCED1B958 = 0;

    if(isDefined(player.pers["suicides"]))
      _id_05E5C27FCED1B958 = player scripts\mp\utility\stats::getpersstat("suicides");

    _id_D9A7691F8001CDA8 = 0;
    _id_C46A8614FBAC5A8A = 0;
    _id_12BB78802E80B7D3 = 0;
    _id_3C3C194620E3EB80 = 0;

    if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && isDefined(player.gwinputtypesused)) {
      _id_D9A7691F8001CDA8 = istrue(player.gwinputtypesused["rightmouseup"]);
      _id_C46A8614FBAC5A8A = istrue(player.gwinputtypesused["leftmouseup"]);
      _id_12BB78802E80B7D3 = istrue(player.gwinputtypesused["activate"]);
      _id_3C3C194620E3EB80 = istrue(player.gwinputtypesused["gostand"]);
    }

    _id_C8F690457A04A764 = scripts\mp\utility\game::getgametype();

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
      _id_C8F690457A04A764 = _id_C8F690457A04A764 + " hc";

    _id_76C6444F1C3454AD = 0;
    _id_8F3E1B856A8C20B3 = "";

    if(scripts\mp\utility\game::matchmakinggame()) {
      _id_76C6444F1C3454AD = getplaylistid();
      _id_8F3E1B856A8C20B3 = getplaylistname();
    }

    _id_EE506D24ECEB8915 = "loss";

    if(isDefined(player.pers["match_outcome"]))
      _id_EE506D24ECEB8915 = player.pers["match_outcome"];

    _id_58E50AEE46852766 = 0;

    if(isDefined(player.pers["telemetry"]._id_58E50AEE46852766))
      _id_58E50AEE46852766 = player.pers["telemetry"]._id_58E50AEE46852766;

    hits = 0;

    if(isDefined(player.pers["telemetry"].hits))
      hits = player.pers["telemetry"].hits;

    _id_0AFBDFAA766BB101 = spawnStruct();
    _id_0AFBDFAA766BB101._id_B08F0F34CBD0C21A = 0;

    if(isDefined(player.pers["telemetry"]._id_B08F0F34CBD0C21A))
      _id_0AFBDFAA766BB101._id_B08F0F34CBD0C21A = player.pers["telemetry"]._id_B08F0F34CBD0C21A;

    player scripts\mp\weapons::_id_C49A0D832ACE8E5E();
    player scripts\mp\persistence::updateweaponbufferedstats();
    _id_8076B5556F48A6CD(player);
    _id_0AFBDFAA766BB101._id_37C6C5876B1A64CD = 0;

    if(isDefined(player.pers["telemetry"]._id_37C6C5876B1A64CD))
      _id_0AFBDFAA766BB101._id_37C6C5876B1A64CD = player.pers["telemetry"]._id_37C6C5876B1A64CD;

    _id_0AFBDFAA766BB101._id_6BE038725A124802 = 0;

    if(isDefined(player.pers["telemetry"]._id_6BE038725A124802))
      _id_0AFBDFAA766BB101._id_6BE038725A124802 = player.pers["telemetry"]._id_6BE038725A124802;

    _id_0AFBDFAA766BB101._id_438F1DC9B1F52A7F = 0;

    if(isDefined(player.pers["telemetry"]._id_438F1DC9B1F52A7F))
      _id_0AFBDFAA766BB101._id_438F1DC9B1F52A7F = player.pers["telemetry"]._id_438F1DC9B1F52A7F;

    _id_0AFBDFAA766BB101._id_44E6F7522AE08173 = 0;

    if(isDefined(player.pers["telemetry"]._id_44E6F7522AE08173))
      _id_0AFBDFAA766BB101._id_44E6F7522AE08173 = player.pers["telemetry"]._id_44E6F7522AE08173;

    _id_93136A376F20DE5C = spawnStruct();
    _id_93136A376F20DE5C.operator = "";
    _id_93136A376F20DE5C._id_EAFA01BD30F04007 = -1;
    _id_93136A376F20DE5C._id_FB60BA315DD3D2CA = "none";

    if(!isbot(player)) {
      _id_93136A376F20DE5C.operator = player scripts\mp\teams::lookupcurrentoperator(player.team);
      _id_93136A376F20DE5C._id_EAFA01BD30F04007 = player scripts\mp\teams::_id_ED273E317490CB02(_id_93136A376F20DE5C.operator);
      _id_93136A376F20DE5C.execution = player scripts\mp\teams::getoperatorexecution(_id_93136A376F20DE5C.operator);

      if(isDefined(_id_93136A376F20DE5C.execution))
        _id_93136A376F20DE5C._id_FB60BA315DD3D2CA = _id_93136A376F20DE5C.execution;
    }

    _id_C94B316C15AE2E15 = _func_4F9373A1227DB35C();

    if(!isDefined(_id_C94B316C15AE2E15))
      _id_C94B316C15AE2E15 = "";

    _id_CE5E1C3A9C1157B6 = getdvarint("current_season", -1);
    _id_5A0FC1D304E970EA = "unset";

    if(isDefined(player.sessionteam))
      _id_5A0FC1D304E970EA = player.sessionteam;

    if(isDefined(player.team))
      _id_5A0FC1D304E970EA = player.team;

    _id_71F672111BBA973C = -1;

    if(isDefined(player.pers["telemetry"].teamplacement))
      _id_71F672111BBA973C = player.pers["telemetry"].teamplacement;

    _id_FA5B633F7DF67D3D = 0;

    if(istrue(level._id_EC2FB549B15AD827) || istrue(level._id_77907D733ABE8B63))
      _id_FA5B633F7DF67D3D = 1;

    _id_D5E1E009ED9EB9A8 = 0;

    if(isDefined(player.pers["telemetry"]._id_D5E1E009ED9EB9A8))
      _id_D5E1E009ED9EB9A8 = player.pers["telemetry"]._id_D5E1E009ED9EB9A8;

    _id_9BC5683C9FE914F0 = 0;

    if(isDefined(player.pers["telemetry"]._id_9BC5683C9FE914F0))
      _id_9BC5683C9FE914F0 = player.pers["telemetry"]._id_9BC5683C9FE914F0;

    _id_5E444DBA2B86C3AC = 0;

    if(isDefined(player.pers["telemetry"]._id_5E444DBA2B86C3AC))
      _id_5E444DBA2B86C3AC = player.pers["telemetry"]._id_5E444DBA2B86C3AC;

    _id_A04E1E3880A078A8 = 0;

    if(isDefined(player.pers["telemetry"]._id_A04E1E3880A078A8))
      _id_A04E1E3880A078A8 = player.pers["telemetry"]._id_A04E1E3880A078A8;

    _id_2C0070B8E9CD250F = 0;

    if(isDefined(player.pers["telemetry"]._id_2C0070B8E9CD250F))
      _id_2C0070B8E9CD250F = player.pers["telemetry"]._id_2C0070B8E9CD250F;

    _id_C60EFB14A77D9DB8 = 0;

    if(isDefined(player.pers["telemetry"]._id_C60EFB14A77D9DB8))
      _id_C60EFB14A77D9DB8 = player.pers["telemetry"]._id_C60EFB14A77D9DB8;

    _id_7FF2028C00F8827D = 0;

    if(isDefined(player.pers["telemetry"]._id_7FF2028C00F8827D)) {
      _id_7FF2028C00F8827D = player.pers["telemetry"]._id_7FF2028C00F8827D;

      if(_id_7FF2028C00F8827D == 1)
        player.pers["telemetry"]._id_4ECAC4D4233CECA4 = 0;
    }

    _id_4ECAC4D4233CECA4 = 1;

    if(isDefined(player.pers["telemetry"]._id_4ECAC4D4233CECA4))
      _id_4ECAC4D4233CECA4 = player.pers["telemetry"]._id_4ECAC4D4233CECA4;

    _id_D7E14469F82BA2E2 = player usinggamepad();
    player dlog_recordplayerevent("dlog_event_mp_player_match_end", ["utc_connect_time_s", _id_FDF9B22D16276454, "utc_disconnect_time_s", getsystemtime(), "team", _id_5A0FC1D304E970EA, "score", player scripts\mp\utility\stats::getpersstat("score"), "placement", _id_71F672111BBA973C, "assists", player scripts\mp\utility\stats::getpersstat("assists"), "longest_streak", player scripts\mp\utility\stats::getpersstat("longestStreak"), "kills", player scripts\mp\utility\stats::getpersstat("kills"), "ai_agent_kills", _id_0AFBDFAA766BB101._id_44E6F7522AE08173, "deaths", player scripts\mp\utility\stats::getpersstat("deaths"), "headshots", player scripts\mp\utility\stats::getpersstat("headshots"), "executions", player scripts\mp\utility\stats::getpersstat("executions"), "player_xp_modifier", int(player scripts\mp\rank::getrankxpmultiplier()), "team_xp_modifier", _id_9C38515978AEB24B, "weapon_xp_modifier", int(player scripts\mp\weaponrank::getweaponrankxpmultiplier()), "disconnect_reason", _id_1EEC5A842769CF24, "player_quit_round_number", _id_7E130E201FB47CA3, "player_quit_team_score", _id_DDC1CBCF13DE68DF, "player_quit_opposing_team_score", _id_F6DFD9CA21BE2BDB, "average_speed_during_match", _id_D0A6F986AE2AB0CA, "percent_time_moving", _id_3ECB392A578C4F31, "damage_done", damage_done, "damage_taken", damage_taken, "distance_traveled", _id_3D1EA5C9BF625DE6, "weapon_accuracy", _id_4D1DB612C5B9184B, "suicides", _id_05E5C27FCED1B958, "game_type", _id_C8F690457A04A764, "gw_spawn_method_press_activate", _id_12BB78802E80B7D3, "gw_spawn_method_press_gostand", _id_3C3C194620E3EB80, "gw_spawn_method_press_lclick", _id_C46A8614FBAC5A8A, "gw_spawn_method_press_rclick", _id_D9A7691F8001CDA8, "playlist_id", _id_76C6444F1C3454AD, "playlist_name", _id_8F3E1B856A8C20B3, "map", level.script, "connect_index", _id_37C32B4614072292, "match_outcome", _id_EE506D24ECEB8915, "rank_at_start", _id_B0F8F036D47C34BA._id_9FEEF25FBCDCB32A, "rank_at_end", _id_B0F8F036D47C34BA._id_55B6F45E3BE122DF, "xp_at_start", _id_B0F8F036D47C34BA._id_0E34D7C876B7BA0C, "xp_at_end", _id_B0F8F036D47C34BA._id_3A6757BA728AE8D5, "score_at_start", _id_B0F8F036D47C34BA._id_6BCB3D0DAF2B3334, "score_at_end", _id_B0F8F036D47C34BA._id_25645BA4FF5CDA6D, "prestige_at_start", _id_B0F8F036D47C34BA._id_AED23C903E19C77B, "prestige_at_end", _id_B0F8F036D47C34BA._id_10F2DE9195564ADE, "lifetime_kills", _id_B0F8F036D47C34BA._id_D61560EFC278B7A4, "lifetime_deaths", _id_B0F8F036D47C34BA._id_A0CD1C855A1250C0, "lifetime_wins", _id_B0F8F036D47C34BA._id_C0D3C62EC53C28FC, "lifetime_losses", _id_B0F8F036D47C34BA._id_669752B7B918F434, "lifetime_hits", _id_B0F8F036D47C34BA._id_9D19049F02571AD9, "lifetime_misses", _id_B0F8F036D47C34BA._id_B5C7BCDDE58256AB, "lifetime_wall_bangs", _id_B0F8F036D47C34BA._id_D3C98DD0C60A3D47, "lifetime_near_misses", _id_B0F8F036D47C34BA._id_B38FD08DE2BF9452, "lifetime_games_played", _id_B0F8F036D47C34BA._id_24D2457257A7795C, "lifetime_time_played_total", _id_B0F8F036D47C34BA._id_593F59C512901CD5, "total_xp", _id_C202E23208D31722, "score_xp", _id_209230A2967FA7AA, "challenge_xp", _id_330EB62149C07007, "match_xp", _id_AB693FD45098759F, "medal_xp", _id_6F5617C7AF942C8D, "bonus_xp", _id_E03B6057466FBE8D, "misc_xp", _id_A53EEC6C068828EE, "accolade_xp", _id_2676FBF905B33538, "weapon_xp", _id_DE29895DCA8987CE, "operator_xp", _id_47993E74569F91AA, "clan_xp", _id_6094A5433A14BD7A, "battlepass_xp", _id_0888938CD9E128CB, "shots", _id_58E50AEE46852766, "hits", hits, "player_score_event_count", _id_0AFBDFAA766BB101._id_B08F0F34CBD0C21A, "player_weapon_stats_count", _id_0AFBDFAA766BB101._id_37C6C5876B1A64CD, "kill_streak_expired_count", _id_0AFBDFAA766BB101._id_6BE038725A124802, "player_loadout_count", _id_0AFBDFAA766BB101._id_438F1DC9B1F52A7F, "operator", _id_93136A376F20DE5C.operator, "operator_skin", _id_93136A376F20DE5C._id_EAFA01BD30F04007, "operator_execution_ref", _id_93136A376F20DE5C._id_FB60BA315DD3D2CA, "lobby_id", _id_C94B316C15AE2E15, "current_season", _id_CE5E1C3A9C1157B6, "voice_chat_used", player _meth_ 5 FE468C5D49CE7C(), "is_ranked", _id_FA5B633F7DF67D3D, "armor_collected", _id_D5E1E009ED9EB9A8, "armor_equipped", _id_9BC5683C9FE914F0, "armor_destroyed", _id_5E444DBA2B86C3AC, "vehicle_autofwd_count", _id_A04E1E3880A078A8, "ground_vehicle_used_count", _id_2C0070B8E9CD250F, "air_vehicle_used_count", _id_C60EFB14A77D9DB8, "is_controller", _id_D7E14469F82BA2E2, "reached_match_end", _id_7FF2028C00F8827D, "is_early_disconnect", _id_4ECAC4D4233CECA4]);
    _id_D45168DF05638ABC = "";

    if(isDefined(data._id_934DC135AAF6F953)) {
      if(_func_D03495FE6418377B(data._id_934DC135AAF6F953) || _func_73E183E02834309D(data._id_934DC135AAF6F953) || _func_28EEFFCB2337321E(data._id_934DC135AAF6F953))
        _id_D45168DF05638ABC = _func_0F28FD66285FA2C9(data._id_934DC135AAF6F953);
      else
        _id_D45168DF05638ABC = data._id_934DC135AAF6F953;
    }

    _id_37AAB353FE84A505 = "{\"disconnect_reason\":\"" + _id_D45168DF05638ABC + "\"}";
    _func_7BCD667FC073FC12("player_match_end", _id_37AAB353FE84A505);
    player.pers["telemetry"]._id_D6CAA636BC3FCE32 = 1;
  }
}

_id_3D5389E7BAE53CE5(agent, _id_6181DE250AFA5BB6) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(_id_6181DE250AFA5BB6)) {
    return;
  }
  if(isDefined(agent) && istrue(agent._id_41DD84F26963FA85)) {
    if(isagent(agent) && issubstr(agent.agent_type, "jugg")) {
      if(isDefined(level._id_051A2BB76D3B72B7._id_1C04285256C6E1BA))
        level._id_051A2BB76D3B72B7._id_1C04285256C6E1BA++;
    } else if(isagent(agent)) {
      if(isDefined(level._id_051A2BB76D3B72B7._id_8F75D3FD9CDA0E4D))
        level._id_051A2BB76D3B72B7._id_8F75D3FD9CDA0E4D++;
    }
  }

  if(isDefined(_id_6181DE250AFA5BB6.pers["telemetry"]._id_44E6F7522AE08173))
    _id_6181DE250AFA5BB6.pers["telemetry"]._id_44E6F7522AE08173++;
}

_id_5F84AFC437FF71F9(data) {
  attacker = data.attacker;
  victim = data.victim;

  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(victim)) {
    return;
  }
  _id_132360A247A77FA7 = "";

  if(isDefined(data.weaponfullstring))
    _id_132360A247A77FA7 = data.weaponfullstring;

  _id_6DD5C3ACB6BB048E = "";

  if(isDefined(data.meansofdeath))
    _id_6DD5C3ACB6BB048E = data.meansofdeath;

  if(_id_132360A247A77FA7 == "agent_mp")
    _id_661047BDF7F094B2 = [];
  else {
    _id_BA6F272FE15EF31B = getweaponattachments(_id_132360A247A77FA7);
    _id_661047BDF7F094B2 = scripts\mp\utility\weapon::attachmentsfilterforstats(_id_BA6F272FE15EF31B, _id_132360A247A77FA7);
  }

  spawntime = 0;

  if(isDefined(victim.spawntime))
    spawntime = victim.spawntime;

  _id_1F67A99F6BC87CAD = _id_4A6760982B403BAD::_id_1B15450E092933CF(spawntime);
  _id_4A3C5BB1E56C5C36 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  _id_6F9BBED303902680 = -1;

  if(isDefined(victim.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = victim.pers["telemetry"].life._id_6F9BBED303902680;

  if(isDefined(victim.pers["telemetry"].life._id_D8BAE1F0E4D5E27E) && victim.pers["telemetry"].life._id_D8BAE1F0E4D5E27E == _id_6F9BBED303902680) {
    return;
  }
  _id_819D28312EF4EECA = -1;
  _id_EFD587862DCD957E = -1;
  _id_B3CD8B7C666F139A = [];
  _id_35A10A060032D847 = 0;
  _id_6605A411EA2EF8F0 = "";

  if(isDefined(_id_132360A247A77FA7) && _id_132360A247A77FA7 == "chopper_gunner_turret_ufo_mp") {
    if(isDefined(level._id_051A2BB76D3B72B7._id_435D49B38DAFF18A))
      level._id_051A2BB76D3B72B7._id_435D49B38DAFF18A++;
  } else if(isDefined(_id_132360A247A77FA7) && _id_132360A247A77FA7 == "chopper_gunner_turret_ufo_lg_mp") {
    if(isDefined(level._id_051A2BB76D3B72B7) && isDefined(level._id_051A2BB76D3B72B7._id_558D87704AA90AF1))
      level._id_051A2BB76D3B72B7._id_558D87704AA90AF1++;
  }

  if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(attacker)) {
    _id_2A8DBAD5E36EBD27 = getweaponbasename(_id_132360A247A77FA7);
    _id_41FB323B39C88DB5 = attacker;
    _id_FD7FCF00E12C8DC0 = attacker scripts\mp\utility\weapon::ispickedupweapon(_id_132360A247A77FA7);
    _id_AF32031D98CD3E97 = attacker isalternatemode(_id_132360A247A77FA7);
    _id_C733469D19CEDFCD = 0.0;

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(_id_132360A247A77FA7))
      _id_C733469D19CEDFCD = attacker playerads();

    _id_A5E0E61619C9FE47 = scripts\engine\utility::within_fov(victim.origin, victim.angles, attacker.origin, 0.4226);
    _id_DF87E66BB0CF05BB = scripts\engine\utility::within_fov(attacker.origin, attacker.angles, victim.origin, 0.4226);
    _id_601BE12F0D05C1F5 = attacker _id_4A6760982B403BAD::_id_50989A55805A440B();
    _id_198C8EA3B4D37527 = attacker.origin;
    _id_522FED3F783C2E47 = attacker.angles;

    if(isDefined(attacker.pers["telemetry"].life._id_6F9BBED303902680))
      _id_819D28312EF4EECA = attacker.pers["telemetry"].life._id_6F9BBED303902680;

    if(isDefined(attacker.loadoutindex))
      _id_EFD587862DCD957E = attacker.loadoutindex;

    _id_B3CD8B7C666F139A = attacker _id_3E784A4247CEA64B::_id_1C355F42FAF7F4BB();
  } else {
    _id_41FB323B39C88DB5 = undefined;

    if(isDefined(attacker) && isagent(attacker)) {
      _id_35A10A060032D847 = 1;
      _id_6605A411EA2EF8F0 = attacker.agent_type;
      _id_2A8DBAD5E36EBD27 = "";
      _id_FD7FCF00E12C8DC0 = 0;
      _id_AF32031D98CD3E97 = 0;
      _id_C733469D19CEDFCD = 0.0;
      _id_A5E0E61619C9FE47 = scripts\engine\utility::within_fov(victim.origin, victim.angles, attacker.origin, 0.4226);
      _id_DF87E66BB0CF05BB = scripts\engine\utility::within_fov(attacker.origin, attacker.angles, victim.origin, 0.4226);
      _id_601BE12F0D05C1F5 = "MOUNT_NONE";
      _id_198C8EA3B4D37527 = attacker.origin;
      _id_522FED3F783C2E47 = attacker.angles;
    } else {
      _id_2A8DBAD5E36EBD27 = "";
      _id_FD7FCF00E12C8DC0 = 0;
      _id_AF32031D98CD3E97 = 0;
      _id_C733469D19CEDFCD = 0.0;
      _id_A5E0E61619C9FE47 = 0;
      _id_DF87E66BB0CF05BB = 0;
      _id_601BE12F0D05C1F5 = "MOUNT_NONE";
      _id_198C8EA3B4D37527 = (0, 0, 0);
      _id_522FED3F783C2E47 = (0, 0, 0);
    }
  }

  _id_E2413CB673297201 = victim _id_3E784A4247CEA64B::_id_1C355F42FAF7F4BB();
  _id_D98C93E50380FB53 = [];
  _id_8367DC8C497F4C02 = "";
  _id_520D9A7C62087EB6 = scripts\engine\utility::ter_op(scripts\mp\utility\player::isinlaststand(victim) && isDefined(victim.laststandoldweaponobj), victim.laststandoldweaponobj, victim.lastweaponused);

  if(isDefined(_id_520D9A7C62087EB6)) {
    _id_FB475EF768B518C0 = getweaponattachments(_id_520D9A7C62087EB6);
    _id_D98C93E50380FB53 = scripts\mp\utility\weapon::attachmentsfilterforstats(_id_FB475EF768B518C0, _id_520D9A7C62087EB6);
    _id_8367DC8C497F4C02 = getweaponbasename(_id_520D9A7C62087EB6);

    if(_id_8367DC8C497F4C02 == "iw8_gunless") {}

    _id_074ABB77F5961401 = victim scripts\mp\utility\weapon::ispickedupweapon(_id_520D9A7C62087EB6);
    _id_2F29CE7BE7004808 = victim isalternatemode(_id_520D9A7C62087EB6, 0, 1);
    _id_39FDA2EB6033A526 = victim playerads();
  } else {
    _id_074ABB77F5961401 = 0;
    _id_2F29CE7BE7004808 = 0;
    _id_39FDA2EB6033A526 = 0.0;
  }

  _id_1C227B5E3C5BB40C = victim _id_4A6760982B403BAD::_id_50989A55805A440B();
  _id_41F759EC1FC925F9 = -1;

  if(isDefined(victim.loadoutindex))
    _id_41F759EC1FC925F9 = victim.loadoutindex;

  _id_CBC3FCC6B1097835 = 0;

  if(isDefined(victim.pers["summary"]["xp"])) {
    _id_1822F368857BC036 = victim.pers["summary"]["xp"];
    _id_CBC3FCC6B1097835 = _id_1822F368857BC036 - victim.pers["telemetry"].life._id_2148FB703835EC1F;
  }

  score_earned = victim.score - victim.pers["telemetry"].life._id_7E5250B5700DF037;
  _id_C5CF558181E12D1F = -1;

  if(scripts\mp\utility\game::isroundbased()) {
    _id_C5CF558181E12D1F = game["roundsPlayed"];

    if(_id_6DD5C3ACB6BB048E == "MOD_GAME_ENDED" || _id_6DD5C3ACB6BB048E == "MOD_ROUND_ENDED") {
      _id_C5CF558181E12D1F--;

      if(_id_C5CF558181E12D1F < 0)
        _id_C5CF558181E12D1F = 0;
    }
  }

  _id_42C10B28679EB263 = 0;

  if(isDefined(attacker) && isDefined(attacker.modifiers))
    _id_42C10B28679EB263 = istrue(attacker.modifiers["hipfire"]);

  spawn_pos = (0, 0, 0);

  if(isDefined(victim.spawnpos))
    spawn_pos = victim.spawnpos;

  _id_2DE5C222F3C53910 = 0;

  if(isDefined(victim.wasti))
    _id_2DE5C222F3C53910 = victim.wasti;

  _id_CD7D693A33117821 = 0;

  if(isDefined(victim.spawndata) && isDefined(victim.spawndata.spawnpoint) && isDefined(victim.spawndata.spawnpoint._id_59A3C934F709A06E))
    _id_CD7D693A33117821 = victim.spawndata.spawnpoint._id_59A3C934F709A06E;

  _id_6A579A482A1B066C = "1st";

  if(isDefined(attacker) && isDefined(attacker.pers) && isDefined(attacker.pers["shootingMode"]))
    _id_6A579A482A1B066C = attacker.pers["shootingMode"];

  _id_2F5832DCBFE84873 = "1st";

  if(isDefined(victim.pers["shootingMode"]))
    _id_2F5832DCBFE84873 = victim.pers["shootingMode"];

  _id_D624EA2E0CE2D1C1 = 0;

  if(isDefined(victim._id_198B774C93C48891))
    _id_D624EA2E0CE2D1C1 = _id_4A6760982B403BAD::_id_1B15450E092933CF(victim._id_198B774C93C48891);

  _id_3F1E35E0CFBEBEBA = 0;

  if(isDefined(victim._id_9691E7D8CDE294F2))
    _id_3F1E35E0CFBEBEBA = _id_4A6760982B403BAD::_id_1B15450E092933CF(victim._id_9691E7D8CDE294F2);

  if(isstring(_id_6DD5C3ACB6BB048E))
    _id_20E794EE21CCC0C3 = _func_1823FF50BB28148D(_id_6DD5C3ACB6BB048E);
  else
    _id_20E794EE21CCC0C3 = _id_6DD5C3ACB6BB048E;

  _id_431BD3E5830D66F8 = -1;
  _id_51334E7082B98CBE = -1;

  if(isDefined(victim._id_489F22C08F63BC0F))
    _id_431BD3E5830D66F8 = victim._id_489F22C08F63BC0F;

  if(isDefined(victim._id_91FF03702332CC07))
    _id_51334E7082B98CBE = victim._id_91FF03702332CC07;

  victim dlog_recordplayerevent("dlog_event_mp_life", ["attacker", _id_41FB323B39C88DB5, "spawn_time_from_match_start_ms", _id_1F67A99F6BC87CAD, "life_index", _id_6F9BBED303902680, "spawn_evaluation_id", _id_CD7D693A33117821, "spawn_pos_x", spawn_pos[0], "spawn_pos_y", spawn_pos[1], "spawn_pos_z", spawn_pos[2], "team", victim.team, "is_host", victim ishost(), "was_tactical_insertion", _id_2DE5C222F3C53910, "death_time_from_match_start_ms", _id_4A3C5BB1E56C5C36, "victim_weapon", _id_8367DC8C497F4C02, "victim_weapon_attachments", _id_D98C93E50380FB53, "attacker_weapon", _id_2A8DBAD5E36EBD27, "attacker_weapon_attachments", _id_661047BDF7F094B2, "victim_death_modifiers", _id_E2413CB673297201, "attacker_death_modifiers", _id_B3CD8B7C666F139A, "death_pos_x", victim.origin[0], "death_pos_y", victim.origin[1], "death_pos_z", victim.origin[2], "death_angle_x", victim.angles[0], "death_angle_y", victim.angles[1], "death_angle_z", victim.angles[2], "attacker_pos_x", _id_198C8EA3B4D37527[0], "attacker_pos_y", _id_198C8EA3B4D37527[1], "attacker_pos_z", _id_198C8EA3B4D37527[2], "attacker_angle_x", _id_522FED3F783C2E47[0], "attacker_angle_y", _id_522FED3F783C2E47[1], "attacker_angle_z", _id_522FED3F783C2E47[2], "means_of_death", _id_20E794EE21CCC0C3, "attacker_weapon_alt_mode", _id_AF32031D98CD3E97, "attacker_weapon_picked_up", _id_FD7FCF00E12C8DC0, "victim_weapon_alt_mode", _id_2F29CE7BE7004808, "victim_weapon_picked_up", _id_074ABB77F5961401, "attacker_ads_value", _id_C733469D19CEDFCD, "victim_ads_value", _id_39FDA2EB6033A526, "attacker_was_in_victim_fov", _id_A5E0E61619C9FE47, "victim_was_in_attacker_fov", _id_DF87E66BB0CF05BB, "attacker_mount_type", _id_601BE12F0D05C1F5, "victim_mount_type", _id_1C227B5E3C5BB40C, "xp_earned", _id_CBC3FCC6B1097835, "score_earned", score_earned, "victim_loadout_index", _id_41F759EC1FC925F9, "attacker_life_index", _id_819D28312EF4EECA, "attacker_loadout_index", _id_EFD587862DCD957E, "victim_was_reloading", victim isreloading(), "victim_was_executing", victim isinexecutionattack(), "round", _id_C5CF558181E12D1F, "is_hipfire", _id_42C10B28679EB263, "attacker_shooting_mode", _id_6A579A482A1B066C, "victim_shooting_mode", _id_2F5832DCBFE84873, "first_damage_delivered_time_ms", _id_D624EA2E0CE2D1C1, "first_damage_received_time_ms", _id_3F1E35E0CFBEBEBA, "attacker_was_ai", _id_35A10A060032D847, "lifetime_damage_dealt", float(_id_51334E7082B98CBE), "lifetime_damage_received", float(_id_431BD3E5830D66F8), "ai_tier", _id_6605A411EA2EF8F0]);
  victim.pers["telemetry"].life._id_D8BAE1F0E4D5E27E = _id_6F9BBED303902680;

  if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(attacker)) {
    logtournamentdeath(victim getxuid(), attacker getxuid(), _id_132360A247A77FA7, _id_6DD5C3ACB6BB048E == "MOD_HEAD_SHOT");

    if(isDefined(level.matchrecording_logevent)) {
      time = gettime();
      [[level.matchrecording_logevent]](victim.clientid, victim.team, "DEATH", victim.origin[0], victim.origin[1], time);

      if(issubstr(tolower(_id_6DD5C3ACB6BB048E), "bullet") && isDefined(_id_132360A247A77FA7) && !_id_2669878CF5A1B6BC::iskillstreakweapon(_id_132360A247A77FA7))
        [[level.matchrecording_logevent]](attacker.clientid, attacker.team, "BULLET", attacker.origin[0], attacker.origin[1], time, undefined, victim.origin[0], victim.origin[1]);
    }
  }
}

on_player_disconnect(data) {
  if(istrue(data.player.hasseenendgamesplash))
    _id_4A6760982B403BAD::_id_766155419D15C501(data.player);

  _id_6447F24ADDC0137E(data);
  _id_A4772A08B422271F = -1;

  if(_id_4A6760982B403BAD::_id_4B974D822D418A06(data) && isDefined(data.player.pers["telemetry"].life._id_D8BAE1F0E4D5E27E))
    _id_A4772A08B422271F = data.player.pers["telemetry"].life._id_D8BAE1F0E4D5E27E;

  _id_59A52BFE186A64C9 = -1;

  if(_id_4A6760982B403BAD::_id_4B974D822D418A06(data) && isDefined(data.player.pers["telemetry"].life._id_6F9BBED303902680))
    _id_59A52BFE186A64C9 = data.player.pers["telemetry"].life._id_6F9BBED303902680;

  if(_id_A4772A08B422271F != _id_59A52BFE186A64C9) {
    _id_94529CAAA418B01B = spawnStruct();
    _id_94529CAAA418B01B.victim = data.player;
    _id_94529CAAA418B01B.attacker = undefined;
    _id_94529CAAA418B01B.weaponfullstring = "none";
    _id_94529CAAA418B01B.meansofdeath = "";

    if(isDefined(data._id_934DC135AAF6F953))
      _id_94529CAAA418B01B.meansofdeath = "MOD_DISCONNECTED";

    _id_5F84AFC437FF71F9(_id_94529CAAA418B01B);
  }
}

_id_60912F12EDBAE676(data) {
  if(isDefined(data._id_59A52BFE186A64C9))
    _id_8F7E680AC270ABC2 = data._id_59A52BFE186A64C9;
  else
    _id_8F7E680AC270ABC2 = -1;

  _id_23C8431F71E1530F = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  _id_B98A554F5FC058C2 = data.classstruct.loadoutprimary;
  primaryweaponobj = data.classstruct.loadoutprimaryobject;
  _id_7DA5C09E8CC677D1 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_C130CD8C126C9AAD = "";

    if(isDefined(data.classstruct.loadoutprimaryattachments[_id_DF6D8E005B4B8020])) {
      _id_2549F2DC1923CD0B = _func_1823FF50BB28148D(data.classstruct.loadoutprimaryattachments[_id_DF6D8E005B4B8020]);

      if(isDefined(_id_2549F2DC1923CD0B))
        _id_C130CD8C126C9AAD = _id_2549F2DC1923CD0B;
    }

    _id_7DA5C09E8CC677D1[_id_DF6D8E005B4B8020] = _id_C130CD8C126C9AAD;
  }

  _id_D4D89BEAF7DCFA0A = data.classstruct.loadoutprimarycamo;
  _id_684A28861C742B36 = data.classstruct.loadoutprimaryreticle;
  _id_267CEE921DEAB64E = data.classstruct.loadoutprimarylootitemid;
  _id_3A7820A8CA123ECE = data.classstruct.loadoutprimaryvariantid;
  _id_0E86B5FF35057C02 = data.classstruct.loadoutsecondary;
  secondaryweaponobj = data.classstruct.loadoutsecondaryobject;
  _id_F67A501A2BA8C411 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_3595C5A4BEF8F5ED = "";

    if(isDefined(data.classstruct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020])) {
      _id_B7FAD9CD59457A4B = _func_1823FF50BB28148D(data.classstruct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020]);

      if(isDefined(_id_B7FAD9CD59457A4B))
        _id_3595C5A4BEF8F5ED = _id_B7FAD9CD59457A4B;
    }

    _id_F67A501A2BA8C411[_id_DF6D8E005B4B8020] = _id_3595C5A4BEF8F5ED;
  }

  _id_9B18F02999B23B4A = data.classstruct.loadoutsecondarycamo;
  _id_F3F8FD2658D0A576 = data.classstruct.loadoutsecondaryreticle;
  _id_D063E05308A9DA8E = data.classstruct.loadoutsecondarylootitemid;
  _id_DD47D5B37F1B770E = data.classstruct.loadoutsecondaryvariantid;
  primarygrenade = data.classstruct.loadoutequipmentprimary;
  _id_646AFA6AB25EE7EB = data.classstruct.loadoutequipmentsecondary;
  _id_0CDA5F3D036862EE = 3;
  _id_5E16B98FC67F9D0A = "stat_F198629C5775CD5D";
  _id_1135208ED2C7CB70 = "stat_F198629C5775CD5D";

  for(index = 0; index < _id_0CDA5F3D036862EE; index++) {
    if(isDefined(data.classstruct.loadoutstandardperks[index])) {
      if(index == 0)
        _id_5E16B98FC67F9D0A = data.classstruct.loadoutstandardperks[index];

      if(index == 1)
        _id_1135208ED2C7CB70 = data.classstruct.loadoutstandardperks[index];
    }
  }

  _id_13DB3CA1AD2DB644 = "stat_F198629C5775CD5D";
  _id_34FDCA49E62D81EE = "stat_F198629C5775CD5D";

  if(isDefined(data.classstruct._id_15F3E6DF722FB1CF))
    _id_13DB3CA1AD2DB644 = data.classstruct._id_15F3E6DF722FB1CF;

  if(isDefined(data.classstruct._id_15F3E5DF722FAF9C))
    _id_34FDCA49E62D81EE = data.classstruct._id_15F3E5DF722FAF9C;

  _id_DD0209CDA2EB2BDA = data.classstruct.loadoutextraperks.size;
  _id_8B7691D4C7422713 = "stat_208442E5E74E8368";
  _id_8B7692D4C7422946 = "stat_208442E5E74E8368";

  if(_id_DD0209CDA2EB2BDA > 3)
    _id_DD0209CDA2EB2BDA = 3;

  for(index = 0; index < _id_DD0209CDA2EB2BDA; index++) {
    if(isDefined(data.classstruct.loadoutextraperks[index])) {
      if(index == 0)
        _id_8B7691D4C7422713 = data.classstruct.loadoutextraperks[index];

      if(index == 1)
        _id_8B7692D4C7422946 = data.classstruct.loadoutextraperks[index];
    }
  }

  _id_8ECF289C70DD61EB = "stat_3C0D17BAD169557B";
  _id_F5BB419CBCCEBBE5 = "stat_3C0D17BAD169557B";

  if(isDefined(data.player.loadoutfieldupgrade1))
    _id_8ECF289C70DD61EB = data.player.loadoutfieldupgrade1;

  if(isDefined(data.player.loadoutfieldupgrade2))
    _id_F5BB419CBCCEBBE5 = data.player.loadoutfieldupgrade2;

  _id_90E8BBDBA663D7C6 = "1st";

  if(isDefined(self.pers["shootingMode"]))
    _id_90E8BBDBA663D7C6 = self.pers["shootingMode"];

  _id_85598E67455E57C4 = _id_B4ED203552F83BCA(primaryweaponobj);
  _id_79DD046C94822604 = _id_B4ED203552F83BCA(secondaryweaponobj);
  _id_39C82234627F4021 = "stat_0000000000000000";
  _id_E2D36E4CCDAFB38D = 0;
  _id_2AD1AD717553A993 = "stat_0000000000000000";
  _id_7A6106E50E8ED5E7 = 0;

  if(isDefined(data._id_D445F727570E7250)) {
    _id_39C82234627F4021 = data._id_D445F727570E7250._id_2A169C65850E1A47;
    _id_2AD1AD717553A993 = _id_39C82234627F4021;
    _id_E2D36E4CCDAFB38D = data._id_D445F727570E7250.lootid;
    _id_7A6106E50E8ED5E7 = 1;
  }

  _id_0258D28B22E72C61 = "stat_0000000000000000";
  _id_1C313515279349CD = 0;
  _id_E334663A75CC67D3 = "stat_0000000000000000";
  _id_35BC7057DB6BA727 = 0;

  if(isDefined(data._id_425DDBA200712090)) {
    _id_0258D28B22E72C61 = data._id_425DDBA200712090._id_2A169C65850E1A47;
    _id_E334663A75CC67D3 = _id_0258D28B22E72C61;
    _id_1C313515279349CD = data._id_425DDBA200712090.lootid;
    _id_35BC7057DB6BA727 = 1;
  }

  _id_8AF798E2F33C8F7E = 0;

  if(isDefined(self._id_36EA89EADC674509))
    _id_8AF798E2F33C8F7E = getsubstr(self._id_36EA89EADC674509, 0, 7) == "default";

  _id_8A4FFEE432CA8D5E = 0;
  _id_6DFA4CCE4CE056B6 = 0;

  if(isDefined(primaryweaponobj)) {
    if(isDefined(primaryweaponobj._id_75A7008E426D90DB)) {
      if(primaryweaponobj._id_75A7008E426D90DB.size > 0)
        _id_8A4FFEE432CA8D5E = 1;
    }

    if(isDefined(primaryweaponobj._id_1A7D88BF68585CAA))
      _id_6DFA4CCE4CE056B6 = 1;
  }

  _id_DC067331D5EEE29E = 0;
  _id_D5539868AAEF02F6 = 0;

  if(isDefined(secondaryweaponobj)) {
    if(isDefined(secondaryweaponobj._id_75A7008E426D90DB)) {
      if(secondaryweaponobj._id_75A7008E426D90DB.size > 0)
        _id_DC067331D5EEE29E = 1;
    }

    if(isDefined(secondaryweaponobj._id_1A7D88BF68585CAA))
      _id_D5539868AAEF02F6 = 1;
  }

  streaktype = "Killstreaks";

  if(istrue(self._id_8BC1DDAD56AB00BF))
    streaktype = "Points";

  _id_D3CF11436C80A43E = data.player dlog_recordplayerevent("dlog_event_mp_player_loadout", ["loadout_index", data.loadoutindex, "class_type", _func_1823FF50BB28148D(data._id_FD84DF04ADEAD383), "mid_match_edit_count", data._id_15BAB3EAA5DF4C14, "first_use_life_index", _id_8F7E680AC270ABC2, "time_from_match_start_ms", _id_23C8431F71E1530F, "primary_weapon_setup_camo", _func_1823FF50BB28148D(_id_D4D89BEAF7DCFA0A), "primary_weapon_setup_reticle", _id_684A28861C742B36, "primary_weapon_setup_loot_item_id", _id_267CEE921DEAB64E, "primary_weapon_setup_variant_id", _id_3A7820A8CA123ECE, "secondary_weapon_setup_camo", _func_1823FF50BB28148D(_id_9B18F02999B23B4A), "secondary_weapon_setup_reticle", _id_F3F8FD2658D0A576, "secondary_weapon_setup_loot_item_id", _id_D063E05308A9DA8E, "secondary_weapon_setup_variant_id", _id_DD47D5B37F1B770E, "primary_grenade", _func_1823FF50BB28148D(primarygrenade), "tactical_gear", _func_1823FF50BB28148D(_id_646AFA6AB25EE7EB), "base_perk_1", _func_1823FF50BB28148D(_id_5E16B98FC67F9D0A), "base_perk_2", _func_1823FF50BB28148D(_id_1135208ED2C7CB70), "bonus_perk", _func_1823FF50BB28148D(_id_13DB3CA1AD2DB644), "ultimate_perk", _func_1823FF50BB28148D(_id_34FDCA49E62D81EE), "extra_loadout_perk_1", _func_1823FF50BB28148D(_id_8B7691D4C7422713), "extra_loadout_perk_2", _func_1823FF50BB28148D(_id_8B7692D4C7422946), "killstreak_0", _func_1823FF50BB28148D(data.classstruct.loadoutkillstreak1), "killstreak_1", _func_1823FF50BB28148D(data.classstruct.loadoutkillstreak2), "killstreak_2", _func_1823FF50BB28148D(data.classstruct.loadoutkillstreak3), "field_upgrade_0", _func_1823FF50BB28148D(_id_8ECF289C70DD61EB), "field_upgrade_1", _func_1823FF50BB28148D(_id_F5BB419CBCCEBBE5), "shooting_mode", _func_1823FF50BB28148D(_id_90E8BBDBA663D7C6), "primary_blueprint", _func_1823FF50BB28148D(_id_39C82234627F4021), "secondary_blueprint", _func_1823FF50BB28148D(_id_0258D28B22E72C61), "primary_weapon_receiver", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_A03DDD0D0225B263), "primary_weapon_front_piece", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_8B043EABC16B00B4), "primary_weapon_back_piece", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_D6EFE963BDA0A080), "primary_weapon_magazine", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_B7D2E220B07DBAD8), "primary_weapon_optic", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_AEB6A391017838B3), "primary_weapon_underbarrel", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_349604C14927DB04), "primary_weapon_modifier", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_62593976EFDA2B1B), "primary_weapon_muzzle", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_FAA4002F92DB269B), "primary_weapon_rear_grip", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_A2BF51FBB4438A81), "primary_weapon_trigger", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_319E593017C07BFE), "primary_weapon_extra", _func_1823FF50BB28148D(_id_85598E67455E57C4._id_4C8CBAF983AD420C), "primary_lid_receiver", _id_85598E67455E57C4._id_230A9E4B47172A82, "primary_lid_front_piece", _id_85598E67455E57C4._id_E5D800552E426FFB, "primary_lid_back_piece", _id_85598E67455E57C4._id_B14B1E17A70A4EF5, "primary_lid_magazine", _id_85598E67455E57C4._id_B6717D21185B3C59, "primary_lid_optic", _id_85598E67455E57C4._id_07C25C6724C108F4, "primary_lid_underbarrel", _id_85598E67455E57C4._id_431219808B1B28FB, "primary_lid_modifier", _id_85598E67455E57C4._id_9C52B25A65573476, "primary_lid_muzzle", _id_85598E67455E57C4._id_CB7042EB5BB68FEE, "primary_lid_rear_grip", _id_85598E67455E57C4._id_CA2F4A84799BFC82, "primary_lid_trigger", _id_85598E67455E57C4._id_792C55F863E07071, "primary_lid_extra", _id_85598E67455E57C4._id_C596750E1DFB9873, "primary_tv_receiver", _id_85598E67455E57C4._id_DEF32C4A258195B9, "primary_tv_front_piece", _id_85598E67455E57C4._id_F0802681DA395BFE, "primary_tv_back_piece", _id_85598E67455E57C4._id_FEB38F6B0627DD52, "primary_tv_magazine", _id_85598E67455E57C4._id_5347CF04D65E699A, "primary_tv_optic", _id_85598E67455E57C4._id_A189C936E207A6AD, "primary_tv_underbarrel", _id_85598E67455E57C4._id_78309ECB7C6C1F12, "primary_tv_modifier", _id_85598E67455E57C4._id_E4A2F6B057AD85AD, "primary_tv_muzzle", _id_85598E67455E57C4._id_CCA4852BF2C81C11, "primary_tv_rear_grip", _id_85598E67455E57C4._id_B437EE6ECC505CF7, "primary_tv_trigger", _id_85598E67455E57C4._id_E4CEFFC67FBB1FC0, "primary_tv_extra", _id_85598E67455E57C4._id_2BCDCFCB2CD5465A, "primary_is_bp_tuned", _id_85598E67455E57C4._id_F58B539A89B0BC91, "secondary_weapon_receiver", _func_1823FF50BB28148D(_id_79DD046C94822604._id_A03DDD0D0225B263), "secondary_weapon_front_piece", _func_1823FF50BB28148D(_id_79DD046C94822604._id_8B043EABC16B00B4), "secondary_weapon_back_piece", _func_1823FF50BB28148D(_id_79DD046C94822604._id_D6EFE963BDA0A080), "secondary_weapon_magazine", _func_1823FF50BB28148D(_id_79DD046C94822604._id_B7D2E220B07DBAD8), "secondary_weapon_optic", _func_1823FF50BB28148D(_id_79DD046C94822604._id_AEB6A391017838B3), "secondary_weapon_underbarrel", _func_1823FF50BB28148D(_id_79DD046C94822604._id_349604C14927DB04), "secondary_weapon_modifier", _func_1823FF50BB28148D(_id_79DD046C94822604._id_62593976EFDA2B1B), "secondary_weapon_muzzle", _func_1823FF50BB28148D(_id_79DD046C94822604._id_FAA4002F92DB269B), "secondary_weapon_rear_grip", _func_1823FF50BB28148D(_id_79DD046C94822604._id_A2BF51FBB4438A81), "secondary_weapon_trigger", _func_1823FF50BB28148D(_id_79DD046C94822604._id_319E593017C07BFE), "secondary_weapon_extra", _func_1823FF50BB28148D(_id_79DD046C94822604._id_4C8CBAF983AD420C), "secondary_lid_receiver", _id_79DD046C94822604._id_230A9E4B47172A82, "secondary_lid_front_piece", _id_79DD046C94822604._id_E5D800552E426FFB, "secondary_lid_back_piece", _id_79DD046C94822604._id_B14B1E17A70A4EF5, "secondary_lid_magazine", _id_79DD046C94822604._id_B6717D21185B3C59, "secondary_lid_optic", _id_79DD046C94822604._id_07C25C6724C108F4, "secondary_lid_underbarrel", _id_79DD046C94822604._id_431219808B1B28FB, "secondary_lid_modifier", _id_79DD046C94822604._id_9C52B25A65573476, "secondary_lid_muzzle", _id_79DD046C94822604._id_CB7042EB5BB68FEE, "secondary_lid_rear_grip", _id_79DD046C94822604._id_CA2F4A84799BFC82, "secondary_lid_trigger", _id_79DD046C94822604._id_792C55F863E07071, "secondary_lid_extra", _id_79DD046C94822604._id_C596750E1DFB9873, "secondary_tv_receiver", _id_79DD046C94822604._id_DEF32C4A258195B9, "secondary_tv_front_piece", _id_79DD046C94822604._id_F0802681DA395BFE, "secondary_tv_back_piece", _id_79DD046C94822604._id_FEB38F6B0627DD52, "secondary_tv_magazine", _id_79DD046C94822604._id_5347CF04D65E699A, "secondary_tv_optic", _id_79DD046C94822604._id_A189C936E207A6AD, "secondary_tv_underbarrel", _id_79DD046C94822604._id_78309ECB7C6C1F12, "secondary_tv_modifier", _id_79DD046C94822604._id_E4A2F6B057AD85AD, "secondary_tv_muzzle", _id_79DD046C94822604._id_CCA4852BF2C81C11, "secondary_tv_rear_grip", _id_79DD046C94822604._id_B437EE6ECC505CF7, "secondary_tv_trigger", _id_79DD046C94822604._id_E4CEFFC67FBB1FC0, "secondary_tv_extra", _id_79DD046C94822604._id_2BCDCFCB2CD5465A, "secondary_is_bp_tuned", _id_79DD046C94822604._id_F58B539A89B0BC91, "is_default_loadout", _id_8AF798E2F33C8F7E, "primary_is_a_blueprint_weapon", _id_7A6106E50E8ED5E7, "primary_blueprint_name", _func_1823FF50BB28148D(_id_2AD1AD717553A993), "primary_blueprint_id", _id_E2D36E4CCDAFB38D, "primary_is_pro_tuned", _id_6DFA4CCE4CE056B6, "primary_is_player_tuned", _id_8A4FFEE432CA8D5E, "primary_weapon_setup_attachment_0", _id_7DA5C09E8CC677D1[0], "primary_weapon_setup_attachment_1", _id_7DA5C09E8CC677D1[1], "primary_weapon_setup_attachment_2", _id_7DA5C09E8CC677D1[2], "primary_weapon_setup_attachment_3", _id_7DA5C09E8CC677D1[3], "primary_weapon_setup_attachment_4", _id_7DA5C09E8CC677D1[4], "secondary_is_a_blueprint_weapon", _id_35BC7057DB6BA727, "secondary_blueprint_name", _func_1823FF50BB28148D(_id_E334663A75CC67D3), "secondary_blueprint_id", _id_1C313515279349CD, "secondary_is_pro_tuned", _id_D5539868AAEF02F6, "secondary_is_player_tuned", _id_DC067331D5EEE29E, "secondary_weapon_setup_attachment_0", _id_F67A501A2BA8C411[0], "secondary_weapon_setup_attachment_1", _id_F67A501A2BA8C411[1], "secondary_weapon_setup_attachment_2", _id_F67A501A2BA8C411[2], "secondary_weapon_setup_attachment_3", _id_F67A501A2BA8C411[3], "secondary_weapon_setup_attachment_4", _id_F67A501A2BA8C411[4], "streak_type", _func_1823FF50BB28148D(streaktype)]);

  if(isDefined(data.player.pers["telemetry"]._id_438F1DC9B1F52A7F) && istrue(_id_D3CF11436C80A43E))
    data.player.pers["telemetry"]._id_438F1DC9B1F52A7F++;
}

_id_8076B5556F48A6CD(player) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }
  player_xp = player getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");

  foreach(key, _id_5842E592DDCEF384 in player.pers["weaponStats"]) {
    _id_021812D5F48574E1 = 0;
    _id_A02C59F5F82EFECA = 0;
    deaths = 0;
    _id_D79146A63F668527 = 0;
    _id_AC573A0F36FE2146 = 0;
    headshots = 0;
    _id_D1EB7A4FC352F04F = 0;
    _id_48DC005771258DCC = 0;
    hits = 0;
    _id_749FEB3E0E88F3A6 = 0;
    _id_23BF7AE046A489D7 = 0;
    kills = 0;
    _id_44E6F7522AE08173 = 0;
    _id_1FECF19AB359CC3B = 0;
    _id_2A4A58EDCE876550 = 0;
    _id_F16939132B58FF83 = 0;
    _id_58E50AEE46852766 = 0;
    _id_23B90B34FECC58CD = 0;
    damage = 0;
    _id_3B2E31AB33C26F0D = 0;
    _id_51F5DE3CB7D369D4 = 0;
    _id_9EEFFF5886BCCDB9 = 0;

    if(isenumvaluevalid("common", "LoadoutWeapon", _id_5842E592DDCEF384.weapon)) {
      _id_021812D5F48574E1 = player getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", _id_5842E592DDCEF384.weapon);
      _id_9EEFFF5886BCCDB9 = scripts\mp\weaponrank::getweaponrankforxp(_id_021812D5F48574E1);
    }

    foreach(_id_629757F5C9E770D8, value in _id_5842E592DDCEF384.stats) {
      switch (_id_629757F5C9E770D8) {
        case "xp_earned":
          _id_A02C59F5F82EFECA = _id_A02C59F5F82EFECA + value;
          break;
        case "deaths":
          deaths = deaths + value;
          break;
        case "ai_deaths":
          _id_D79146A63F668527 = _id_D79146A63F668527 + value;
          break;
        case "player_deaths":
          _id_AC573A0F36FE2146 = _id_AC573A0F36FE2146 + value;
          break;
        case "headshots":
          headshots = headshots + value;
          break;
        case "ai_headshots":
          _id_D1EB7A4FC352F04F = _id_D1EB7A4FC352F04F + value;
          break;
        case "player_headshots":
          _id_48DC005771258DCC = _id_48DC005771258DCC + value;
          break;
        case "hits":
          hits = hits + value;
          break;
        case "ai_hits":
          _id_749FEB3E0E88F3A6 = _id_749FEB3E0E88F3A6 + value;
          break;
        case "player_hits":
          _id_23BF7AE046A489D7 = _id_23BF7AE046A489D7 + value;
          break;
        case "kills":
          kills = kills + value;
          break;
        case "ads_kills":
          _id_1FECF19AB359CC3B = _id_1FECF19AB359CC3B + value;
          break;
        case "ai_ads_kills":
          _id_2A4A58EDCE876550 = _id_2A4A58EDCE876550 + value;
          break;
        case "player_ads_kills":
          _id_F16939132B58FF83 = _id_F16939132B58FF83 + value;
          break;
        case "shots":
          _id_58E50AEE46852766 = _id_58E50AEE46852766 + value;
          break;
        case "timeUsed":
          _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + value;
          break;
        case "damage":
          damage = damage + value;
          break;
        case "ai_damage":
          _id_3B2E31AB33C26F0D = _id_3B2E31AB33C26F0D + value;
          break;
        case "player_damage":
          _id_51F5DE3CB7D369D4 = _id_51F5DE3CB7D369D4 + value;
          break;
        case "ai_agent_kills":
          _id_44E6F7522AE08173 = _id_44E6F7522AE08173 + value;
          break;
      }
    }

    _id_160345544D655DE0 = _id_B4ED203552F83BCA(_id_5842E592DDCEF384.weaponobj);
    _id_904C82687DDFEB02 = _id_CCB453B7EF932CEA(_id_5842E592DDCEF384.weaponobj);
    _id_E96A2497012E529B = 0;
    _id_6CEC5443C5A603C1 = 0;
    _id_2A169C65850E1A47 = "";
    _id_C0C48DB16BAB2FCA = 0;
    _id_23F43530281513A2 = 0;
    _id_67E0508F0CC1E07D = "none";

    if(isDefined(_id_5842E592DDCEF384.weaponobj)) {
      if(isDefined(_id_5842E592DDCEF384.weaponobj.camo))
        _id_67E0508F0CC1E07D = _id_5842E592DDCEF384.weaponobj.camo;

      if(isDefined(_id_5842E592DDCEF384.weaponobj._id_75A7008E426D90DB)) {
        if(_id_5842E592DDCEF384.weaponobj._id_75A7008E426D90DB.size > 0)
          _id_C0C48DB16BAB2FCA = 1;
      }

      if(isDefined(_id_5842E592DDCEF384.weaponobj._id_1A7D88BF68585CAA))
        _id_23F43530281513A2 = 1;

      _id_FEDB77AAD2340743 = getweaponvariantindex(_id_5842E592DDCEF384.weaponobj);

      if(isDefined(_id_FEDB77AAD2340743)) {
        _id_A6ED1602A5107749 = _id_2669878CF5A1B6BC::getweaponrootname(_id_5842E592DDCEF384.weaponobj) + "|" + _id_FEDB77AAD2340743;

        if(isDefined(_id_A6ED1602A5107749)) {
          _id_134C70A5C6DE474C = level.weaponlootmapdata[_id_A6ED1602A5107749];

          if(isDefined(_id_134C70A5C6DE474C)) {
            _id_E96A2497012E529B = 1;
            _id_6CEC5443C5A603C1 = _id_134C70A5C6DE474C.lootid;
            _id_2A169C65850E1A47 = _id_A6ED1602A5107749;
          }
        }
      }
    }

    _id_B67DDC26C0A0609D = [];

    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
      _id_B67DDC26C0A0609D[_id_DF6D8E005B4B8020] = "";

      if(isDefined(_id_5842E592DDCEF384.weaponobj)) {
        if(isDefined(_id_5842E592DDCEF384.weaponobj.attachments[_id_DF6D8E005B4B8020]))
          _id_B67DDC26C0A0609D[_id_DF6D8E005B4B8020] = _id_5842E592DDCEF384.weaponobj.attachments[_id_DF6D8E005B4B8020];
      }
    }

    _id_B96152CB873A0080 = 0;

    if(isDefined(_id_5842E592DDCEF384.stats) && isDefined(_id_5842E592DDCEF384.stats["xp_earned"])) {
      if(isenumvaluevalid("common", "LoadoutWeapon", _id_5842E592DDCEF384.weapon)) {
        _id_021812D5F48574E1 = player getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", _id_5842E592DDCEF384.weapon);
        _id_20022A4D67CB2A26 = _id_5842E592DDCEF384.stats["xp_earned"];
        _id_63A461789FCA386A = _id_021812D5F48574E1 + _id_20022A4D67CB2A26;
        _id_B96152CB873A0080 = scripts\mp\weaponrank::getweaponrankforxp(_id_63A461789FCA386A);
      }

      if(!isDefined(_id_B96152CB873A0080) && !isint(_id_B96152CB873A0080))
        _id_B96152CB873A0080 = 0;
    }

    _id_D3CF11436C80A43E = player dlog_recordplayerevent("dlog_event_mp_player_weapon_stats", ["weapon", _id_5842E592DDCEF384.weapon, "variant_id", _id_5842E592DDCEF384.variantid, "attachments", _id_5842E592DDCEF384.weaponattachments, "loadout_index", _id_5842E592DDCEF384.loadoutindex, "is_picked_up", _id_5842E592DDCEF384._id_61022CD5389D83D0, "starting_weapon_xp", _id_021812D5F48574E1, "xp_earned", _id_A02C59F5F82EFECA, "deaths", deaths, "ai_deaths", _id_D79146A63F668527, "player_deaths", _id_AC573A0F36FE2146, "headshots", headshots, "ai_headshots", _id_D1EB7A4FC352F04F, "player_headshots", _id_48DC005771258DCC, "hits", hits, "ai_hits", _id_749FEB3E0E88F3A6, "player_hits", _id_23BF7AE046A489D7, "kills", kills, "ai_agent_kills", _id_44E6F7522AE08173, "ads_kills", _id_1FECF19AB359CC3B, "ai_ads_kills", _id_2A4A58EDCE876550, "player_ads_kills", _id_F16939132B58FF83, "shots", _id_58E50AEE46852766, "time_used_s", float(_id_23B90B34FECC58CD), "damage", damage, "ai_damage", _id_3B2E31AB33C26F0D, "player_damage", _id_51F5DE3CB7D369D4, "weapon_receiver", _id_160345544D655DE0._id_A03DDD0D0225B263, "weapon_front_piece", _id_160345544D655DE0._id_8B043EABC16B00B4, "weapon_back_piece", _id_160345544D655DE0._id_D6EFE963BDA0A080, "weapon_magazine", _id_160345544D655DE0._id_B7D2E220B07DBAD8, "weapon_optic", _id_160345544D655DE0._id_AEB6A391017838B3, "weapon_underbarrel", _id_160345544D655DE0._id_349604C14927DB04, "weapon_modifier", _id_160345544D655DE0._id_62593976EFDA2B1B, "weapon_muzzle", _id_160345544D655DE0._id_FAA4002F92DB269B, "weapon_rear_grip", _id_160345544D655DE0._id_A2BF51FBB4438A81, "weapon_trigger", _id_160345544D655DE0._id_319E593017C07BFE, "weapon_extra", _id_160345544D655DE0._id_4C8CBAF983AD420C, "lid_receiver", _id_160345544D655DE0._id_230A9E4B47172A82, "lid_front_piece", _id_160345544D655DE0._id_E5D800552E426FFB, "lid_back_piece", _id_160345544D655DE0._id_B14B1E17A70A4EF5, "lid_magazine", _id_160345544D655DE0._id_B6717D21185B3C59, "lid_optic", _id_160345544D655DE0._id_07C25C6724C108F4, "lid_underbarrel", _id_160345544D655DE0._id_431219808B1B28FB, "lid_modifier", _id_160345544D655DE0._id_9C52B25A65573476, "lid_muzzle", _id_160345544D655DE0._id_CB7042EB5BB68FEE, "lid_rear_grip", _id_160345544D655DE0._id_CA2F4A84799BFC82, "lid_trigger", _id_160345544D655DE0._id_792C55F863E07071, "lid_extra", _id_160345544D655DE0._id_C596750E1DFB9873, "tv_receiver", _id_160345544D655DE0._id_DEF32C4A258195B9, "tv_front_piece", _id_160345544D655DE0._id_F0802681DA395BFE, "tv_back_piece", _id_160345544D655DE0._id_FEB38F6B0627DD52, "tv_magazine", _id_160345544D655DE0._id_5347CF04D65E699A, "tv_optic", _id_160345544D655DE0._id_A189C936E207A6AD, "tv_underbarrel", _id_160345544D655DE0._id_78309ECB7C6C1F12, "tv_modifier", _id_160345544D655DE0._id_E4A2F6B057AD85AD, "tv_muzzle", _id_160345544D655DE0._id_CCA4852BF2C81C11, "tv_rear_grip", _id_160345544D655DE0._id_B437EE6ECC505CF7, "tv_trigger", _id_160345544D655DE0._id_E4CEFFC67FBB1FC0, "tv_extra", _id_160345544D655DE0._id_2BCDCFCB2CD5465A, "is_bp_tuned", _id_160345544D655DE0._id_F58B539A89B0BC91, "weapon_lootid", _id_904C82687DDFEB02, "is_a_blueprint_weapon", _id_E96A2497012E529B, "blueprint_id", _id_6CEC5443C5A603C1, "blueprint_name", _id_2A169C65850E1A47, "is_player_tuned", _id_C0C48DB16BAB2FCA, "is_pro_tuned", _id_23F43530281513A2, "camo_equipped_id", _id_67E0508F0CC1E07D, "weapon_setup_attachment_0", _id_B67DDC26C0A0609D[0], "weapon_setup_attachment_1", _id_B67DDC26C0A0609D[1], "weapon_setup_attachment_2", _id_B67DDC26C0A0609D[2], "weapon_setup_attachment_3", _id_B67DDC26C0A0609D[3], "weapon_setup_attachment_4", _id_B67DDC26C0A0609D[4], "is_dual_wielding", _id_5842E592DDCEF384.isdualwielding, "weapon_rank_start", _id_9EEFFF5886BCCDB9, "weapon_rank_end", _id_B96152CB873A0080]);

    if(isDefined(player.pers["telemetry"]._id_37C6C5876B1A64CD) && istrue(_id_D3CF11436C80A43E))
      player.pers["telemetry"]._id_37C6C5876B1A64CD++;
  }
}

_id_B4ED203552F83BCA(weapon) {
  data = spawnStruct();
  data._id_F58B539A89B0BC91 = 0;
  data._id_A03DDD0D0225B263 = "";
  data._id_230A9E4B47172A82 = 0;
  data._id_DEF32C4A258195B9 = [0.0, 0.0];
  data._id_8B043EABC16B00B4 = "";
  data._id_E5D800552E426FFB = 0;
  data._id_F0802681DA395BFE = [0.0, 0.0];
  data._id_D6EFE963BDA0A080 = "";
  data._id_B14B1E17A70A4EF5 = 0;
  data._id_FEB38F6B0627DD52 = [0.0, 0.0];
  data._id_B7D2E220B07DBAD8 = "";
  data._id_B6717D21185B3C59 = 0;
  data._id_5347CF04D65E699A = [0.0, 0.0];
  data._id_AEB6A391017838B3 = "";
  data._id_07C25C6724C108F4 = 0;
  data._id_A189C936E207A6AD = [0.0, 0.0];
  data._id_349604C14927DB04 = "";
  data._id_431219808B1B28FB = 0;
  data._id_78309ECB7C6C1F12 = [0.0, 0.0];
  data._id_62593976EFDA2B1B = "";
  data._id_9C52B25A65573476 = 0;
  data._id_E4A2F6B057AD85AD = [0.0, 0.0];
  data._id_FAA4002F92DB269B = "";
  data._id_CB7042EB5BB68FEE = 0;
  data._id_CCA4852BF2C81C11 = [0.0, 0.0];
  data._id_A2BF51FBB4438A81 = "";
  data._id_CA2F4A84799BFC82 = 0;
  data._id_B437EE6ECC505CF7 = [0.0, 0.0];
  data._id_319E593017C07BFE = "";
  data._id_792C55F863E07071 = 0;
  data._id_E4CEFFC67FBB1FC0 = [0.0, 0.0];
  data._id_4C8CBAF983AD420C = "";
  data._id_C596750E1DFB9873 = 0;
  data._id_2BCDCFCB2CD5465A = [0.0, 0.0];

  if(!isDefined(weapon))
    return data;

  if(isDefined(weapon._id_1A7D88BF68585CAA))
    data._id_F58B539A89B0BC91 = weapon._id_1A7D88BF68585CAA;

  if(isDefined(weapon.receiver)) {
    data._id_A03DDD0D0225B263 = weapon.receiver;
    data._id_230A9E4B47172A82 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.receiver);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.receiver])) {
      data._id_DEF32C4A258195B9[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.receiver][0]);
      data._id_DEF32C4A258195B9[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.receiver][1]);
    }
  }

  if(isDefined(weapon.frontpiece)) {
    data._id_8B043EABC16B00B4 = weapon.frontpiece;
    data._id_E5D800552E426FFB = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.frontpiece);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.frontpiece])) {
      data._id_F0802681DA395BFE[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.frontpiece][0]);
      data._id_F0802681DA395BFE[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.frontpiece][1]);
    }
  }

  if(isDefined(weapon.backpiece)) {
    data._id_D6EFE963BDA0A080 = weapon.backpiece;
    data._id_B14B1E17A70A4EF5 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.backpiece);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.backpiece])) {
      data._id_FEB38F6B0627DD52[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.backpiece][0]);
      data._id_FEB38F6B0627DD52[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.backpiece][1]);
    }
  }

  if(isDefined(weapon.magazine)) {
    data._id_B7D2E220B07DBAD8 = weapon.magazine;
    data._id_B6717D21185B3C59 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.magazine);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.magazine])) {
      data._id_5347CF04D65E699A[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.magazine][0]);
      data._id_5347CF04D65E699A[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.magazine][1]);
    }
  }

  if(isDefined(weapon.scope)) {
    data._id_AEB6A391017838B3 = weapon.scope;
    data._id_07C25C6724C108F4 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.scope);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.scope])) {
      data._id_A189C936E207A6AD[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.scope][0]);
      data._id_A189C936E207A6AD[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.scope][1]);
    }
  }

  if(isDefined(weapon.underbarrel)) {
    data._id_349604C14927DB04 = weapon.underbarrel;
    data._id_431219808B1B28FB = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.underbarrel);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.underbarrel])) {
      data._id_78309ECB7C6C1F12[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.underbarrel][0]);
      data._id_78309ECB7C6C1F12[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.underbarrel][1]);
    }
  }

  if(isDefined(weapon.modifier)) {
    data._id_62593976EFDA2B1B = weapon.modifier;
    data._id_9C52B25A65573476 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.modifier);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.modifier])) {
      data._id_E4A2F6B057AD85AD[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.modifier][0]);
      data._id_E4A2F6B057AD85AD[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.modifier][1]);
    }
  }

  if(isDefined(weapon.muzzle)) {
    data._id_FAA4002F92DB269B = weapon.muzzle;
    data._id_CB7042EB5BB68FEE = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.muzzle);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.muzzle])) {
      data._id_CCA4852BF2C81C11[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.muzzle][0]);
      data._id_CCA4852BF2C81C11[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.muzzle][1]);
    }
  }

  if(isDefined(weapon.reargrip)) {
    data._id_D8276D9EB2E2C788 = weapon.reargrip;
    data._id_ED3583AB0834EA1D = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.reargrip);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.reargrip])) {
      data._id_F3A41B9191DFCB0E[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.reargrip][0]);
      data._id_F3A41B9191DFCB0E[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.reargrip][1]);
    }
  }

  if(isDefined(weapon.trigger)) {
    data._id_319E593017C07BFE = weapon.trigger;
    data._id_792C55F863E07071 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.trigger);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.trigger])) {
      data._id_E4CEFFC67FBB1FC0[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.trigger][0]);
      data._id_E4CEFFC67FBB1FC0[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.trigger][1]);
    }
  }

  if(isDefined(weapon.extra)) {
    data._id_4C8CBAF983AD420C = weapon.extra;
    data._id_C596750E1DFB9873 = _id_2669878CF5A1B6BC::_id_693E108CB61CEEB5(weapon.basename, weapon.extra);

    if(isDefined(weapon._id_75A7008E426D90DB[weapon.extra])) {
      data._id_2BCDCFCB2CD5465A[0] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.extra][0]);
      data._id_2BCDCFCB2CD5465A[1] = _id_4A6760982B403BAD::_id_86D327084EEBF87A(weapon._id_75A7008E426D90DB[weapon.extra][1]);
    }
  }

  return data;
}

_id_6A347A3138EC63E1(data) {
  currenttime = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());

  if(currenttime <= 0 && (!isDefined(self.loadoutindex) || self.loadoutindex == -1)) {
    return;
  }
  if(!isDefined(self.pers) || !isDefined(self.pers["weaponStats"])) {
    return;
  }
  if(_id_2669878CF5A1B6BC::iskillstreakweapon(data.weaponname) || scripts\mp\utility\weapon::isvehicleweapon(data.weaponname) || scripts\mp\utility\weapon::isfistsonly(data.weaponname)) {
    return;
  }
  key = data.fullweaponname;

  if(data.fullweaponname == "agent_mp")
    weaponattachments = [];
  else {
    _id_2BA4A91944E009E8 = getweaponattachments(data.fullweaponname);
    weaponattachments = scripts\mp\utility\weapon::attachmentsfilterforstats(_id_2BA4A91944E009E8, data.fullweaponname);
  }

  _id_61022CD5389D83D0 = -1;

  if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(self))
    _id_61022CD5389D83D0 = scripts\mp\utility\weapon::ispickedupweapon(data.fullweaponname);

  loadoutindex = -1;

  if(isDefined(self.loadoutindex) && !_id_61022CD5389D83D0)
    loadoutindex = self.loadoutindex;

  if(!isDefined(self.pers["weaponStats"][key])) {
    _id_FC0C136F54847D43 = getdvarint("dvar_817F686503CCDECF", 5);

    if(self.pers["weaponStats"].size >= _id_FC0C136F54847D43) {
      _id_8076B5556F48A6CD(self);
      self.pers["weaponStats"] = [];
    }

    _id_CCECEB2BB681FBEE = 0;

    if(isDefined(self) && isDefined(data)) {
      if(isDefined(data.weaponobj))
        _id_CCECEB2BB681FBEE = self _meth_341246F8888F2A(data.weaponobj);
      else if(isDefined(data.fullweaponname))
        _id_CCECEB2BB681FBEE = self _meth_341246F8888F2A(data.fullweaponname);
    }

    self.pers["weaponStats"][key] = spawnStruct();
    self.pers["weaponStats"][key].stats = [];
    self.pers["weaponStats"][key].weapon = data.weaponname;
    self.pers["weaponStats"][key].weaponattachments = weaponattachments;
    self.pers["weaponStats"][key].loadoutindex = loadoutindex;
    self.pers["weaponStats"][key]._id_61022CD5389D83D0 = _id_61022CD5389D83D0;
    self.pers["weaponStats"][key].weaponobj = data.weaponobj;
    self.pers["weaponStats"][key].isdualwielding = _id_CCECEB2BB681FBEE;

    if(isDefined(data.variantid))
      self.pers["weaponStats"][key].variantid = data.variantid;
    else
      self.pers["weaponStats"][key].variantid = -1;
  }

  if(!isDefined(self.pers["weaponStats"][key].stats[data._id_629757F5C9E770D8]))
    self.pers["weaponStats"][key].stats[data._id_629757F5C9E770D8] = data._id_A1D4E7D5EF9DA660;
  else
    self.pers["weaponStats"][key].stats[data._id_629757F5C9E770D8] = self.pers["weaponStats"][key].stats[data._id_629757F5C9E770D8] + data._id_A1D4E7D5EF9DA660;

  if(data._id_629757F5C9E770D8 == "shots")
    self.pers["telemetry"]._id_58E50AEE46852766 = self.pers["telemetry"]._id_58E50AEE46852766 + data._id_A1D4E7D5EF9DA660;
  else if(data._id_629757F5C9E770D8 == "hits")
    self.pers["telemetry"].hits = self.pers["telemetry"].hits + data._id_A1D4E7D5EF9DA660;
}

_id_AC6B649326F4B17E(data) {
  player = data.player;

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(player) == 0) {
    return;
  }
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }
  _id_ED6C4157FEEA476B = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  _id_F0FA3B7B27926553 = data._id_F0FA3B7B27926553;

  if(_func_D03495FE6418377B(_id_F0FA3B7B27926553))
    _id_F0FA3B7B27926553 = _func_0F28FD66285FA2C9(_id_F0FA3B7B27926553);

  _id_D3CF11436C80A43E = player dlog_recordplayerevent("dlog_event_mp_player_score_event", ["time_from_match_start_ms", _id_ED6C4157FEEA476B, "score_event", _id_F0FA3B7B27926553]);

  if(isDefined(player.pers["telemetry"]._id_B08F0F34CBD0C21A) && istrue(_id_D3CF11436C80A43E))
    player.pers["telemetry"]._id_B08F0F34CBD0C21A++;
}

_id_6A9AA1D51A6BACC3(data) {
  player = data.player;
  _id_C198F7CA473378FB = data._id_C198F7CA473378FB;
  _id_FC40287339BFE643 = data._id_C739BA1EB6635B73;
  _id_0F325FE524D4336B = player _meth_3B6BBFEC65CC4EE3();

  if(!_id_0F325FE524D4336B) {
    return;
  }
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }
  if(!isDefined(_id_C198F7CA473378FB))
    _id_C198F7CA473378FB = "DEFAULT";

  player dlog_recordplayerevent("dlog_event_reload_cancel_reason", ["reload_cancel_time", _id_FC40287339BFE643, "reload_canceled", 1, "reload_cancel_type", _id_C198F7CA473378FB]);
}

_id_C72337759677531C(data) {
  player = undefined;
  _id_59A52BFE186A64C9 = -1;

  if(isDefined(data.player) && _id_4A6760982B403BAD::_id_0892570944F6B6A2(data.player) && scripts\cp_mp\utility\game_utility::isgameparticipant(data.player)) {
    player = data.player;

    if(isDefined(data.player.pers["telemetry"].life._id_6F9BBED303902680))
      _id_59A52BFE186A64C9 = data.player.pers["telemetry"].life._id_6F9BBED303902680;
  }

  _id_ED6C4157FEEA476B = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  dlog_recordevent("dlog_event_mp_game_event", ["client", player, "event_name", data.eventname, "time_from_match_start_ms", _id_ED6C4157FEEA476B, "player_life_index", _id_59A52BFE186A64C9, "pos_x", data.position[0], "pos_y", data.position[1], "pos_z", data.position[2]]);

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"]._id_19EB71D207A4B2B8))
    game["telemetry"]._id_19EB71D207A4B2B8++;
}

_id_1A88D4DAA0CB7E1F(_id_E75F0523BC1DBDE8, _id_AD20D588BCE2CE99) {
  _id_57549ABBD404FEB4 = [];
  _id_57549ABBD404FEB4["armor_plate_done"] = "NONE";
  _id_57549ABBD404FEB4["death"] = "DEATH";
  _id_57549ABBD404FEB4["mantle_start"] = "MANTLE_STARTED";
  _id_57549ABBD404FEB4["last_stand_start"] = "LAST_STAND_STARTED";
  _id_57549ABBD404FEB4["scr_change_swim_state"] = "SWIM_STATE_CHANGED";
  _id_57549ABBD404FEB4["special_weapon_fired"] = "SPECIAL_WEAPON_FIRED";
  _id_57549ABBD404FEB4["try_armor_cancel"] = [];
  _id_57549ABBD404FEB4["try_armor_cancel"]["damage_received"] = "DAMAGE_RECEIVED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["parachuting"] = "PARACHUTING";
  _id_57549ABBD404FEB4["try_armor_cancel"]["last_stand_reviver_start"] = "LAST_STAND_REVIVER_STARTED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["armory_kiosk_used"] = "ARMORY_KIOSK_USED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["interrogation_interrogator_start"] = "INTERROGATION_INTERROGATOR_STARTED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["vehicle_enter"] = "VEHICLE_ENTER";
  _id_57549ABBD404FEB4["try_armor_cancel"]["game_end"] = "GAME_END";
  _id_57549ABBD404FEB4["try_armor_cancel"]["all_armor_plates_dropped"] = "ALL_ARMOR_PLATES_DROPPED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["loadout_open"] = "LOADOUT_OPEN";
  _id_57549ABBD404FEB4["try_armor_cancel"]["ladder_used"] = "LADDER_USED";
  _id_57549ABBD404FEB4["try_armor_cancel"]["player_switched_weapon"] = "PLAYER_SWITCHED_WEAPON";
  _id_57549ABBD404FEB4["try_armor_cancel"]["player_switched_to_grenade"] = "PLAYER_SWITCHED_TO_GRENADE";
  _id_57549ABBD404FEB4["try_armor_cancel"]["player_interaction"] = "PLAYER_DIRECT_ACTION";
  _id_57549ABBD404FEB4["try_armor_cancel"]["armor_unselected"] = "OTHER_ARMOR_UNSELECTED";
  _id_6058620EE3A64145 = _id_57549ABBD404FEB4[_id_E75F0523BC1DBDE8];

  if(isDefined(_id_6058620EE3A64145) && isarray(_id_6058620EE3A64145))
    _id_6058620EE3A64145 = _id_57549ABBD404FEB4[_id_E75F0523BC1DBDE8][_id_AD20D588BCE2CE99];

  if(!isDefined(_id_6058620EE3A64145))
    _id_6058620EE3A64145 = "OTHER";

  return _id_6058620EE3A64145;
}

_id_1879CE4FBA1CD65D(data) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(data.player)) {
    return;
  }
  data.player dlog_recordplayerevent("dlog_event_player_armor_auto_equip_cancel", ["cancel_reason", _id_1A88D4DAA0CB7E1F(data._id_E75F0523BC1DBDE8, data._id_AD20D588BCE2CE99)]);
}

_id_675FEB1C926F55A3(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_player_extraction_complete", ["team", data._id_5A0FC1D304E970EA, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data._id_6437FC57F57C9AD8, "player_yaw", data._id_FE76A03A13318315, "player_roll", data._id_868460883D5CE6A2, "lpcon_level", data._id_9C02E895E4DBDC3B, "match_time_elapsed", data._id_C983D3ABB7EC13D9, "extraction_type", data._id_FCC975EE4C8B02CC, "cash_total", data._id_42623C2865853280, "backpack_items", data._id_8003724EAD57BA09, "stowed_weapon", data._id_1C78E184E8E6AE71, "loadout_items", data._id_8919314D1DF8D669, "mission_1_status", data._id_3D1611A538E77206, "mission_2_status", data._id_3E8D5A83AE37A4FF, "mission_3_status", data._id_D9BB11BFF39D0BAC, "new_items_unlocked", data._id_D35C23115990E1CE, "exfilstreak", data._id_BC4AE9E25D0666C5]);
}

_id_4FC7F0119FC38D0C(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_container_open", ["team", data._id_5A0FC1D304E970EA, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data._id_6437FC57F57C9AD8, "player_yaw", data._id_FE76A03A13318315, "player_roll", data._id_868460883D5CE6A2, "lpcon_level", data._id_9C02E895E4DBDC3B, "match_time_elapsed", data._id_C983D3ABB7EC13D9, "item_ids", data._id_9846F3DA68A7D5BC, "item_counts", data._id_CF765966D1EE56D6, "container_type", data._id_FA77CD787F3091D9]);
}

_id_89D4104DBACB6AEF(data) {
  data.player dlog_recordplayerevent("dlog_event_dmz_contract_complete", ["contract_name", data._id_68DEAE7CBF3A47BE, "result", data.result, "team", data._id_0672820B647EC78D, "endx", data.x, "endy", data.y, "endz", data.z, "startx", data._id_3ADDC209D947FB9B, "starty", data._id_3ADDC109D947F968, "startz", data._id_3ADDC409D9480001, "poi", data._id_B205D90302DA2F07]);
}

_id_260DF5DDBFEBAC5F(player) {
  _id_5A0FC1D304E970EA = "unset";

  if(isDefined(player.sessionteam))
    _id_5A0FC1D304E970EA = player.sessionteam;

  if(isDefined(player.team))
    _id_5A0FC1D304E970EA = player.team;

  return _id_5A0FC1D304E970EA;
}

_id_1EF65D2654424502(_id_EFA8EF05B190D7D0, result, _id_5E671FC71E72D5E8) {
  if(!isDefined(_id_EFA8EF05B190D7D0)) {
    return;
  }
  if(!isDefined(_id_EFA8EF05B190D7D0.name)) {
    return;
  }
  if(!isDefined(result))
    result = "fail";

  players = scripts\mp\utility\teams::getteamdata(_id_5E671FC71E72D5E8, "players");

  foreach(player in players) {
    _id_5A0FC1D304E970EA = _id_260DF5DDBFEBAC5F(player);
    data = spawnStruct();
    data._id_68DEAE7CBF3A47BE = _id_EFA8EF05B190D7D0.name;
    data.player = player;
    data.result = result;
    data._id_0672820B647EC78D = _id_5A0FC1D304E970EA;
    data.x = player.origin[0];
    data.y = player.origin[1];
    data.z = player.origin[2];
    data._id_3ADDC209D947FB9B = _id_EFA8EF05B190D7D0.origin[0];
    data._id_3ADDC109D947F968 = _id_EFA8EF05B190D7D0.origin[1];
    data._id_3ADDC409D9480001 = _id_EFA8EF05B190D7D0.origin[2];
    data._id_B205D90302DA2F07 = _id_EFA8EF05B190D7D0._id_B205D90302DA2F07;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_dmz_contract", data);
  }
}

_id_A884632EDEBE7D1E(data) {
  if(!isDefined(data)) {
    return;
  }
  if(!isDefined(data.agents)) {
    return;
  }
  _id_FF9358B3AC96C7AB = int(scripts\mp\utility\game::getsecondspassed());
  location = data._id_C5E7FCE963586EC0;

  if(!isDefined(location))
    location = (0, 0, 0);

  _id_B205D90302DA2F07 = data._id_B205D90302DA2F07;

  if(!isDefined(_id_B205D90302DA2F07))
    _id_B205D90302DA2F07 = "none";

  _id_D3D06E31985486A6 = [];

  foreach(agent in data.agents) {
    if(isDefined(agent.agent_type))
      _id_D3D06E31985486A6[_id_D3D06E31985486A6.size] = agent.agent_type;
  }

  _id_9C02E895E4DBDC3B = "0";

  if(isDefined(level._id_A7B62649C81B481A) && isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2))
    _id_9C02E895E4DBDC3B = scripts\engine\utility::string(level._id_A7B62649C81B481A._id_ACC161DE36707DE2);

  dlog_recordevent("dlog_event_dmz_reinforcement_triggered", ["time_elapsed", _id_FF9358B3AC96C7AB, "lpcon_level", _id_9C02E895E4DBDC3B, "pos_x", location[0], "pos_y", location[1], "pos_z", location[2], "poi", _id_B205D90302DA2F07, "agents", _id_D3D06E31985486A6]);
}

_id_532119A556885727(data) {
  _id_C983D3ABB7EC13D9 = -1;

  if(isDefined(data._id_C983D3ABB7EC13D9))
    _id_C983D3ABB7EC13D9 = data._id_C983D3ABB7EC13D9;

  _id_75A8EB8AF196B837 = -1;

  if(isDefined(data._id_75A8EB8AF196B837))
    _id_75A8EB8AF196B837 = data._id_75A8EB8AF196B837;

  agentskilled = -1;

  if(isDefined(data.agentskilled))
    agentskilled = data.agentskilled;

  _id_9C02E895E4DBDC3B = "stat_22A0E850ADD468A3";

  if(isDefined(data._id_9C02E895E4DBDC3B))
    _id_9C02E895E4DBDC3B = _id_2892A7E13357D95B::_id_C43F9411E4146FBD();

  dlog_recordevent("dlog_event_dmz_biolab_lpcon", ["match_time_elapsed", _id_C983D3ABB7EC13D9, "teams_remaining", _id_75A8EB8AF196B837, "agents_killed", agentskilled, "lpcon_level", _id_9C02E895E4DBDC3B]);
}

_id_CCB453B7EF932CEA(weaponobj) {
  if(!isDefined(weaponobj))
    return "invalid";

  _id_37F8240C95553C33 = undefined;
  _id_14C43408F194343F = weaponobj._id_4C23F392C9061568;

  if(isDefined(_id_14C43408F194343F))
    _id_37F8240C95553C33 = _id_14C43408F194343F.lootid;
  else {
    _id_91D8918EBD312E43 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
    _id_6D9AC92E86DAAE8E = _func_E4F08713DC9C53B3(_id_91D8918EBD312E43);

    if(isDefined(_id_6D9AC92E86DAAE8E) && isDefined(_id_6D9AC92E86DAAE8E._id_DB35956D84816F27))
      _id_37F8240C95553C33 = _id_6D9AC92E86DAAE8E._id_DB35956D84816F27;
  }

  if(!isDefined(_id_37F8240C95553C33))
    _id_37F8240C95553C33 = "invalid";
  else
    _id_37F8240C95553C33 = scripts\engine\utility::string(_id_37F8240C95553C33);

  return _id_37F8240C95553C33;
}