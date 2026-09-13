/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_122c94e0d5135583.gsc
***********************************************/

init() {
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_start", ::_id_393BAF20DB478C0D);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_end", ::_id_F5F91665FE4DBA94);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_server_exit_level", ::_id_69DDF7A3E512A18A);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_first_connect", ::on_player_connect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_spawned", ::_id_061A6648C0A01CAD);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_disconnect", ::on_player_disconnect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_death", ::_id_5F84AFC437FF71F9);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_update_weapon_stats", ::_id_6A347A3138EC63E1);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_score_event", ::_id_AC6B649326F4B17E);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_game_event", ::_id_C72337759677531C);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_award", ::_id_9670CC409126542A);
}

_id_393BAF20DB478C0D() {
  if(!isDefined(level._id_BBB1DABA2B06CB38))
    level._id_BBB1DABA2B06CB38 = 0;

  level._id_BBB1DABA2B06CB38 = getsystemtime();
  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "private_match";

  if(scripts\cp\utility::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  _id_527BEDD9C6434673 = _func_676CFE2AB64EA758();
  dlog_recordevent("dlog_event_cp_server_match_start", ["map", level.script, "game_type", scripts\cp\utility::getgametype(), "time_stamp", level._id_BBB1DABA2B06CB38, "player_count", level.players.size, "playlist_id", int(_id_76C6444F1C3454AD), "playlist_name", _id_8F3E1B856A8C20B3, "frame_duration", _id_527BEDD9C6434673]);
  onmatchbegin();
}

_id_F5F91665FE4DBA94(data) {
  _id_BBB1DABA2B06CB38 = 0;
  _id_AF0F7BFFF116DFE5 = 0;
  _id_BF9667D999B5EA7B = 0;
  _id_19EB71D207A4B2B8 = 0;

  if(isDefined(level._id_BBB1DABA2B06CB38))
    _id_BBB1DABA2B06CB38 = level._id_BBB1DABA2B06CB38;

  if(isDefined(game["telemetry"]._id_19EB71D207A4B2B8))
    _id_19EB71D207A4B2B8 = game["telemetry"]._id_19EB71D207A4B2B8;

  if(isDefined(game["telemetry"]._id_AF0F7BFFF116DFE5))
    _id_AF0F7BFFF116DFE5 = game["telemetry"]._id_AF0F7BFFF116DFE5;

  if(isDefined(game["telemetry"]._id_BF9667D999B5EA7B))
    _id_BF9667D999B5EA7B = game["telemetry"]._id_BF9667D999B5EA7B;

  _id_AA1F976689B6CA96 = data.result;

  if(_id_AA1F976689B6CA96 != "") {
    if(scripts\cp\utility::is_wave_gametype())
      _id_AA1F976689B6CA96 = "KIA";
  }

  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "private_match";

  if(scripts\cp\utility::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  dlog_recordevent("dlog_event_cp_server_match_end", ["map", level.script, "game_type", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "result", _id_AA1F976689B6CA96, "utc_start_time_s", _id_BBB1DABA2B06CB38, "player_count", level.players.size, "total_player_connections", _id_AF0F7BFFF116DFE5, "life_count", _id_BF9667D999B5EA7B, "game_event_count", _id_19EB71D207A4B2B8, "playlist_id", int(_id_76C6444F1C3454AD), "playlist_name", _id_8F3E1B856A8C20B3]);
}

on_player_connect(player) {
  if(!isDefined(player.pers["telemetry"]) || !isDefined(player.pers["telemetry"].connected)) {
    if(!isDefined(player.pers["telemetry"]))
      player.pers["telemetry"] = spawnStruct();

    if(isDefined(game["telemetry"]) && isDefined(game["telemetry"]._id_AF0F7BFFF116DFE5)) {
      player.pers["telemetry"]._id_37C32B4614072292 = game["telemetry"]._id_AF0F7BFFF116DFE5;
      game["telemetry"]._id_AF0F7BFFF116DFE5++;
    } else
      return;
  }

  player.pers["telemetry"]._id_72AC055B0A1C5D26 = getsystemtime();
  player.pers["telemetry"].connected = 1;
  player _id_97F88F577C57665F();
}

_id_97F88F577C57665F() {
  if(scripts\cp\utility::rankingenabled()) {
    _id_EE49C3848A3C97DC = self getplayerdata("cp", "progression", "playerLevel", "xp");
    _id_AFB3144A335134A4 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
    _id_0DF720ED8BEEC72D = self getplayerdata("cp", "progression", "playerLevel", "prestige");
  } else {
    _id_EE49C3848A3C97DC = 0;
    _id_AFB3144A335134A4 = 0;
    _id_0DF720ED8BEEC72D = 0;
  }

  self.pers["utc_connect_time_s"] = getsystemtime();
  _id_37C32B4614072292 = self.pers["telemetry"]._id_37C32B4614072292;
  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "private_match";

  if(scripts\cp\utility::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  self dlog_recordplayerevent("dlog_event_cp_player_match_start", ["utc_connect_time_s", self.pers["utc_connect_time_s"], "team", self.sessionteam, "join_type", self getjointype(), "skill", self getskill(), "start_xp", _id_EE49C3848A3C97DC, "start_time_played_total", _id_AFB3144A335134A4, "start_prestige", _id_0DF720ED8BEEC72D, "connect_index", _id_37C32B4614072292, "player_count", level.players.size, "party_id", self getpartyid(), "playlist_id", int(_id_76C6444F1C3454AD), "playlist_name", _id_8F3E1B856A8C20B3]);
  self.pers["telemetry"]._id_72C4294A35F33731 = undefined;
  self.pers["telemetry"]._id_C902B1ACA6729094 = undefined;
  self.pers["telemetry"]._id_475783A3BCAA05F3 = undefined;
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
}

_id_69DDF7A3E512A18A() {
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    _id_6447F24ADDC0137E(data);
  }
}

on_player_disconnect(data) {
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

_id_6447F24ADDC0137E(data) {
  player = data.player;
  _id_8F87C853B986D24A = "";

  if(isDefined(data._id_934DC135AAF6F953) && isstring(data._id_934DC135AAF6F953))
    _id_8F87C853B986D24A = data._id_934DC135AAF6F953;

  if(level.teambased)
    _id_8CC713FF16B24041 = int(player _id_187A04151C40FB72::getteamrankxpmultiplier(player.team));
  else
    _id_8CC713FF16B24041 = 0;

  _id_C202E23208D31722 = 0;
  _id_209230A2967FA7AA = 0;
  _id_330EB62149C07007 = 0;
  _id_AB693FD45098759F = 0;
  _id_6F5617C7AF942C8D = 0;
  _id_E03B6057466FBE8D = 0;
  _id_A53EEC6C068828EE = 0;
  _id_9E919A78B9496138 = player scripts\cp\utility::onlinestatsenabled();

  if(player scripts\cp\utility::onlinestatsenabled() && !scripts\cp\utility::is_specops_gametype()) {
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
  }

  _id_219EF42301AEAAC8 = player getplayerdata("cp", "progression", "playerLevel", "xp");
  player _id_3BCAA2CBAF54ABDD::set_player_xp(_id_C202E23208D31722 + _id_219EF42301AEAAC8);
  _id_C5732E73897E110B = player _id_187A04151C40FB72::getrankxp();
  _id_00AE17C5A8B1BC1B = player _id_187A04151C40FB72::getrankforxp(_id_C5732E73897E110B);

  if(player scripts\cp\utility::rankingenabled() && player hasplayerdata()) {
    _id_0244D1D08842E07B = player getplayerdata("cp", "progression", "playerLevel", "xp");
    _id_6D5CC01580FBEE79 = player getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
    _id_D8DCECB185E1414A = player getplayerdata("common", "mpProgression", "playerLevel", "prestige");
  } else {
    _id_0244D1D08842E07B = 0;
    _id_6D5CC01580FBEE79 = 0;
    _id_D8DCECB185E1414A = 0;
  }

  _id_D0A6F986AE2AB0CA = 0.0;
  _id_3ECB392A578C4F31 = 0.0;

  if(isDefined(player.segments)) {
    if(isDefined(player.segments["movementUpdateCount"])) {
      if(player.segments["movementUpdateCount"] >= 30) {
        _id_3ECB392A578C4F31 = player.segments["movingTotal"] / (player.segments["movementUpdateCount"] / 5) * 100;
        _id_D0A6F986AE2AB0CA = player.segments["distanceTotal"] / player.segments["movementUpdateCount"];
      }
    }
  }

  _id_7E01E835B5E9CB04 = 0;

  if(isDefined(player.pers["utc_connect_time_s"]))
    _id_7E01E835B5E9CB04 = player.pers["utc_connect_time_s"];

  if(isDefined(player.pers["essence"]))
    _id_32C75B7E74E94901 = player.pers["essence"];
  else
    _id_32C75B7E74E94901 = 0;

  if(isDefined(player._id_751641130E86B95F))
    _id_0A8CF8F66F06BD9E = player._id_751641130E86B95F;
  else
    _id_0A8CF8F66F06BD9E = 0;

  _id_7DD04438EDF2C021 = _id_8F87C853B986D24A;

  if(level.matchmakingmatch)
    _id_196ECCB3049E0C6A = "public";
  else if(level.onlinegame)
    _id_196ECCB3049E0C6A = "private";
  else
    _id_196ECCB3049E0C6A = "solo";

  _id_3DCDD2851C94A64E = _id_4A6760982B403BAD::get_objective_type();
  _id_37C32B4614072292 = player.pers["telemetry"]._id_37C32B4614072292;
  _id_72B7E79717D4C7BA = getsystemtime() - _id_7E01E835B5E9CB04;
  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "private_match";

  if(scripts\cp\utility::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  player dlog_recordplayerevent("dlog_event_cp_player_match_end", ["utc_connect_time_s", _id_7E01E835B5E9CB04, "utc_disconnect_time_s", getsystemtime(), "player_xp_modifier", int(player _id_187A04151C40FB72::getrankxpmultiplier()), "team_xp_modifier", _id_8CC713FF16B24041, "weapon_xp_modifier", int(player scripts\cp\cp_weaponrank::getweaponrankxpmultiplier()), "total_xp", _id_C202E23208D31722, "score_xp", _id_209230A2967FA7AA, "challenge_xp", _id_330EB62149C07007, "match_xp", _id_AB693FD45098759F, "medal_xp", _id_6F5617C7AF942C8D, "bonus_xp", _id_E03B6057466FBE8D, "misc_xp", _id_A53EEC6C068828EE, "rank", _id_00AE17C5A8B1BC1B, "end_xp", _id_0244D1D08842E07B, "end_time_played_total", _id_6D5CC01580FBEE79, "end_prestige", _id_D8DCECB185E1414A, "disconnect_reason", _id_8F87C853B986D24A, "average_speed_during_match", _id_D0A6F986AE2AB0CA, "percent_time_moving", _id_3ECB392A578C4F31, "result", _id_8F87C853B986D24A, "connected_time_s", _id_72B7E79717D4C7BA, "essence", _id_32C75B7E74E94901, "salvage", _id_0A8CF8F66F06BD9E, "means_of_end", _id_7DD04438EDF2C021, "match_type", _id_196ECCB3049E0C6A, "objective_type_on_death", _id_3DCDD2851C94A64E, "map", level.script, "active_objective", _id_4A6760982B403BAD::get_objective_type(), "player_count", level.players.size, "round", scripts\cp\utility::_id_F0D6ACF93C15BD59(), "connect_index", _id_37C32B4614072292, "party_id", player getpartyid(), "playlist_id", int(_id_76C6444F1C3454AD), "playlist_name", _id_8F3E1B856A8C20B3]);
  _id_8076B5556F48A6CD(player);
}

_id_5F84AFC437FF71F9(data) {
  attacker = data.attacker;
  victim = data.victim;
  _id_132360A247A77FA7 = data.weaponfullstring;

  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(victim)) {
    return;
  }
  _id_6DD5C3ACB6BB048E = "";

  if(isDefined(data.meansofdeath))
    _id_6DD5C3ACB6BB048E = data.meansofdeath;

  if(_id_132360A247A77FA7 == "agent_cp")
    _id_661047BDF7F094B2 = [];
  else {
    _id_BA6F272FE15EF31B = getweaponattachments(_id_132360A247A77FA7);
    _id_661047BDF7F094B2 = _id_74502A9E0EF1F19C::attachmentsfilterforstats(_id_BA6F272FE15EF31B, _id_132360A247A77FA7);
  }

  spawntime = 0;

  if(isDefined(victim.spawntime))
    spawntime = victim.spawntime;

  _id_1F67A99F6BC87CAD = _id_4A6760982B403BAD::_id_1B15450E092933CF(spawntime);
  _id_4A3C5BB1E56C5C36 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  _id_6F9BBED303902680 = -1;

  if(isDefined(victim.pers["telemetry"].life._id_6F9BBED303902680))
    _id_6F9BBED303902680 = victim.pers["telemetry"].life._id_6F9BBED303902680;

  _id_819D28312EF4EECA = -1;
  _id_EFD587862DCD957E = -1;
  _id_B3CD8B7C666F139A = [];

  if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(attacker)) {
    _id_2A8DBAD5E36EBD27 = getweaponbasename(_id_132360A247A77FA7);
    _id_41FB323B39C88DB5 = attacker;
    _id_FD7FCF00E12C8DC0 = attacker _id_74502A9E0EF1F19C::ispickedupweapon(_id_132360A247A77FA7);
    _id_AF32031D98CD3E97 = attacker isalternatemode(_id_132360A247A77FA7);
    _id_C733469D19CEDFCD = 0.0;

    if(_id_74502A9E0EF1F19C::iscacprimaryweapon(_id_132360A247A77FA7) || _id_74502A9E0EF1F19C::iscacsecondaryweapon(_id_132360A247A77FA7))
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

  _id_E2413CB673297201 = victim _id_3E784A4247CEA64B::_id_1C355F42FAF7F4BB();
  _id_D98C93E50380FB53 = [];
  _id_8367DC8C497F4C02 = "";

  if(isDefined(victim.lastweaponused)) {
    _id_520D9A7C62087EB6 = victim.lastweaponused;
    _id_FB475EF768B518C0 = getweaponattachments(_id_520D9A7C62087EB6);
    _id_D98C93E50380FB53 = _id_74502A9E0EF1F19C::attachmentsfilterforstats(_id_FB475EF768B518C0, _id_520D9A7C62087EB6);
    _id_8367DC8C497F4C02 = getweaponbasename(_id_520D9A7C62087EB6);
    _id_074ABB77F5961401 = victim _id_74502A9E0EF1F19C::ispickedupweapon(_id_520D9A7C62087EB6);
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

  victim dlog_recordplayerevent("dlog_event_cp_life", ["attacker", _id_41FB323B39C88DB5, "spawn_time_from_match_start_ms", _id_1F67A99F6BC87CAD, "life_index", _id_6F9BBED303902680, "spawn_evaluation_id", _id_CD7D693A33117821, "spawn_pos_x", spawn_pos[0], "spawn_pos_y", spawn_pos[1], "spawn_pos_z", spawn_pos[2], "team", victim.team, "is_host", victim ishost(), "was_tactical_insertion", _id_2DE5C222F3C53910, "death_time_from_match_start_ms", _id_4A3C5BB1E56C5C36, "victim_weapon", _id_8367DC8C497F4C02, "victim_weapon_attachments", _id_D98C93E50380FB53, "attacker_weapon", _id_2A8DBAD5E36EBD27, "attacker_weapon_attachments", _id_661047BDF7F094B2, "victim_death_modifiers", _id_E2413CB673297201, "attacker_death_modifiers", _id_B3CD8B7C666F139A, "death_pos_x", victim.origin[0], "death_pos_y", victim.origin[1], "death_pos_z", victim.origin[2], "death_angle_x", victim.angles[0], "death_angle_y", victim.angles[1], "death_angle_z", victim.angles[2], "attacker_pos_x", _id_198C8EA3B4D37527[0], "attacker_pos_y", _id_198C8EA3B4D37527[1], "attacker_pos_z", _id_198C8EA3B4D37527[2], "attacker_angle_x", _id_522FED3F783C2E47[0], "attacker_angle_y", _id_522FED3F783C2E47[1], "attacker_angle_z", _id_522FED3F783C2E47[2], "means_of_death", _id_6DD5C3ACB6BB048E, "attacker_weapon_alt_mode", _id_AF32031D98CD3E97, "attacker_weapon_picked_up", _id_FD7FCF00E12C8DC0, "victim_weapon_alt_mode", _id_2F29CE7BE7004808, "victim_weapon_picked_up", _id_074ABB77F5961401, "attacker_ads_value", _id_C733469D19CEDFCD, "victim_ads_value", _id_39FDA2EB6033A526, "attacker_was_in_victim_fov", _id_A5E0E61619C9FE47, "victim_was_in_attacker_fov", _id_DF87E66BB0CF05BB, "attacker_mount_type", _id_601BE12F0D05C1F5, "victim_mount_type", _id_1C227B5E3C5BB40C, "xp_earned", _id_CBC3FCC6B1097835, "score_earned", score_earned, "victim_loadout_index", _id_41F759EC1FC925F9, "attacker_life_index", _id_819D28312EF4EECA, "attacker_loadout_index", _id_EFD587862DCD957E, "victim_was_reloading", victim isreloading(), "victim_was_executing", victim isinexecutionattack(), "is_hipfire", _id_42C10B28679EB263, "attacker_shooting_mode", _id_6A579A482A1B066C, "victim_shooting_mode", _id_2F5832DCBFE84873, "first_damage_delivered_time_ms", _id_D624EA2E0CE2D1C1, "first_damage_received_time_ms", _id_3F1E35E0CFBEBEBA]);
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

_id_8076B5556F48A6CD(player) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player) || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }
  player_xp = player getplayerdata("cploadouts", "squadMembers", "player_xp");

  foreach(key, _id_5842E592DDCEF384 in player.pers["weaponStats"]) {
    _id_021812D5F48574E1 = 0;
    _id_A02C59F5F82EFECA = 0;
    deaths = 0;
    headshots = 0;
    hits = 0;
    kills = 0;
    _id_58E50AEE46852766 = 0;
    damage = 0;

    if(isenumvaluevalid("common", "LoadoutWeapon", _id_5842E592DDCEF384.weapon))
      _id_021812D5F48574E1 = player getplayerdata("cploadouts", "squadMembers", "weapon_xp", _id_5842E592DDCEF384.weapon);

    foreach(_id_629757F5C9E770D8, value in _id_5842E592DDCEF384.stats) {
      if(_id_629757F5C9E770D8 == "xp_earned")
        _id_A02C59F5F82EFECA = _id_A02C59F5F82EFECA + value;

      if(_id_629757F5C9E770D8 == "deaths")
        deaths = deaths + value;

      if(_id_629757F5C9E770D8 == "headshots")
        headshots = headshots + value;

      if(_id_629757F5C9E770D8 == "hits")
        hits = hits + value;

      if(_id_629757F5C9E770D8 == "kills")
        kills = kills + value;

      if(_id_629757F5C9E770D8 == "shots")
        _id_58E50AEE46852766 = _id_58E50AEE46852766 + value;

      if(_id_629757F5C9E770D8 == "damage")
        damage = damage + value;
    }

    player dlog_recordplayerevent("dlog_event_cp_player_weapon_stats", ["weapon", _id_5842E592DDCEF384.weapon, "variant_id", _id_5842E592DDCEF384.variantid, "loadout_index", _id_5842E592DDCEF384.loadoutindex, "starting_weapon_xp", _id_021812D5F48574E1, "xp_earned", _id_A02C59F5F82EFECA, "deaths", deaths, "headshots", headshots, "hits", hits, "kills", kills, "shots", _id_58E50AEE46852766, "damage", damage]);
  }
}

_id_6A347A3138EC63E1(data) {
  if(_id_2669878CF5A1B6BC::iskillstreakweapon(data.weaponname) || _id_74502A9E0EF1F19C::isvehicleweapon(data.weaponname)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  key = data.weaponname;

  if(isDefined(self.loadoutindex))
    key = key + "+loadoutIndex" + self.loadoutindex;
  else
    return;

  if(!isDefined(self.pers["weaponStats"][key])) {
    self.pers["weaponStats"][key] = spawnStruct();
    self.pers["weaponStats"][key].stats = [];
    self.pers["weaponStats"][key].weapon = data.weaponname;
    self.pers["weaponStats"][key].loadoutindex = self.loadoutindex;

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

  self dlog_recordplayerevent("dlog_event_cp_player_score_event", ["time_from_match_start_ms", _id_ED6C4157FEEA476B, "score_event", _id_F0FA3B7B27926553]);
}

_id_C72337759677531C(data) {
  _id_196EF0FA8094FCBA = undefined;
  _id_59A52BFE186A64C9 = -1;

  if(isDefined(data.player) && _id_4A6760982B403BAD::_id_0892570944F6B6A2(data.player) && scripts\cp_mp\utility\game_utility::isgameparticipant(data.player)) {
    _id_196EF0FA8094FCBA = data.player;

    if(isDefined(data.player.pers["telemetry"].life._id_6F9BBED303902680))
      _id_59A52BFE186A64C9 = data.player.pers["telemetry"].life._id_6F9BBED303902680;
  }

  _id_ED6C4157FEEA476B = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  position = [0, 0, 0];

  if(isDefined(data.position))
    position = data.position;

  dlog_recordevent("dlog_event_cp_game_event", ["event_player", _id_196EF0FA8094FCBA, "event_name", data.eventname, "time_from_match_start_ms", _id_ED6C4157FEEA476B, "player_life_index", _id_59A52BFE186A64C9, "pos_x", position[0], "pos_y", position[1], "pos_z", position[2]]);

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"]._id_19EB71D207A4B2B8))
    game["telemetry"]._id_19EB71D207A4B2B8++;
}

_id_9670CC409126542A(data) {
  player = data.player;
  _id_84EA5CF2793332C1 = data._id_84EA5CF2793332C1;

  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(isbot(player) || istestclient(player) || isai(player)) {
    return;
  }
  _id_16FBC6A2229D1D81 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
  player dlog_recordplayerevent("dlog_event_cp_player_award", ["time_ms_from_match_start", _id_16FBC6A2229D1D81, "award", _id_84EA5CF2793332C1]);
}