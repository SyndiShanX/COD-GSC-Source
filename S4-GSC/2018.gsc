/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2018.gsc
*************************************************/

init() {
  game["round_end"]["draw"] = 1;
  game["round_end"]["round_draw"] = 2;
  game["round_end"]["round_win"] = 3;
  game["round_end"]["round_loss"] = 4;
  game["round_end"]["victory"] = 5;
  game["round_end"]["defeat"] = 6;
  game["round_end"]["halftime"] = 7;
  game["round_end"]["overtime"] = 8;
  game["round_end"]["roundend"] = 9;
  game["round_end"]["intermission"] = 10;
  game["round_end"]["side_switch"] = 11;
  game["round_end"]["match_bonus"] = 12;
  game["round_end"]["tie"] = 13;
  game["round_end"]["spectator"] = 14;
  game["round_end"]["final_round"] = 15;
  game["round_end"]["match_point"] = 16;
  game["round_end"]["practice_round"] = 17;
  game["round_end"]["cancelled"] = 18;
  game["end_reason"]["score_limit_reached"] = 1;
  game["end_reason"]["time_limit_reached"] = 2;
  game["end_reason"]["players_forfeited"] = 3;
  game["end_reason"]["target_destroyed"] = 4;
  game["end_reason"]["bomb_defused"] = 5;
  game["end_reason"]["rusf_eliminated"] = 6;
  game["end_reason"]["usmc_eliminated"] = 7;
  game["end_reason"]["sas_eliminated"] = 8;
  game["end_reason"]["sabf_eliminated"] = 9;
  game["end_reason"]["five_eliminated"] = 10;
  game["end_reason"]["six_eliminated"] = 11;
  game["end_reason"]["spetsnaz_forfeited"] = 12;
  game["end_reason"]["marines_forfeited"] = 13;
  game["end_reason"]["sas_forfeited"] = 14;
  game["end_reason"]["sabf_forfeited"] = 15;
  game["end_reason"]["five_forfeited"] = 16;
  game["end_reason"]["six_forfeited"] = 17;
  game["end_reason"]["enemies_eliminated"] = 18;
  game["end_reason"]["tie"] = 19;
  game["end_reason"]["objective_completed"] = 20;
  game["end_reason"]["objective_failed"] = 21;
  game["end_reason"]["switching_sides"] = 22;
  game["end_reason"]["round_limit_reached"] = 23;
  game["end_reason"]["ended_game"] = 24;
  game["end_reason"]["host_ended_game"] = 25;
  game["end_reason"]["loss_stat_prevented"] = 26;
  game["end_reason"]["time_to_beat_ctf_win"] = 27;
  game["end_reason"]["time_to_beat_ctf_loss"] = 28;
  game["end_reason"]["time_to_beat_uplink_win"] = 29;
  game["end_reason"]["time_to_beat_uplink_loss"] = 30;
  game["end_reason"]["nuke_end"] = 31;
  game["end_reason"]["enemies_forfeited"] = 32;
  game["end_reason"]["arena_time_health_win"] = 33;
  game["end_reason"]["arena_time_health_loss"] = 34;
  game["end_reason"]["arena_time_lives_win"] = 35;
  game["end_reason"]["arena_time_lives_loss"] = 36;
  game["end_reason"]["arena_otflag_completed"] = 37;
  game["end_reason"]["arena_otflag_failed"] = 38;
  game["end_reason"]["outpost_defended"] = 39;
  game["end_reason"]["practice_round_over"] = 40;
  game["end_reason"]["br_eliminated"] = 41;
  game["end_reason"]["cyber_tie"] = 42;
  game["end_reason"]["mercy_win"] = 43;
  game["end_reason"]["mercy_loss"] = 44;
  game["end_reason"]["blank"] = 45;
  game["end_reason"]["mlg_time_to_beat_ctf"] = 46;
  game["end_reason"]["mlg_time_to_beat_uplink"] = 47;
  game["end_reason"]["mlg_time_lives"] = 48;
  game["end_reason"]["mlg_time_health"] = 49;
  game["end_reason"]["mlg_eliminated"] = 50;
  game["end_reason"]["mlg_forfeited"] = 51;
  game["end_reason"]["siege_allflags_win"] = 52;
  game["end_reason"]["siege_allflags_loss"] = 53;
  game["end_reason"]["siege_flag_win"] = 54;
  game["end_reason"]["siege_flag_loss"] = 55;
  game["end_reason"]["arena_tournament_tie_win"] = 56;
  game["end_reason"]["arena_tournament_tie_loss"] = 57;
  game["end_reason"]["dmz_plunder_loss"] = 58;
  game["end_reason"]["dmz_plunder_win"] = 59;
  game["end_reason"]["enemy_forfeit"] = 60;
  game["end_reason"]["survivors_eliminated"] = 61;
  game["end_reason"]["friendlies_eliminated"] = 62;
  game["end_reason"]["control_allzones_win"] = 63;
  game["end_reason"]["control_allzones_loss"] = 64;
  game["end_reason"]["mlg_allzones_captured"] = 65;
  game["end_reason"]["mlg_otflag_captured"] = 66;
  game["end_reason"]["mlg_tournament_tie"] = 67;
  game["end_reason"]["lp_match_cancelled"] = 68;
  game["round_end_exmsg"]["intermission"] = 1;
  game["round_end_exmsg"]["switching_sides"] = 2;
  game["round_end_exmsg"]["match_point"] = 3;
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_win"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_loss"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_win"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_loss"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_win"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_loss"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_win"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_loss"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["rusf_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["usmc_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sabf_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["five_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["six_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["spetsnaz_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["marines_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sabf_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["five_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["six_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["enemies_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["enemies_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["friendlies_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_otflag_completed"]] = game["end_reason"]["mlg_otflag_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_otflag_failed"]] = game["end_reason"]["mlg_otflag_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_tournament_tie_win"]] = game["end_reason"]["mlg_tournament_tie"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_tournament_tie_loss"]] = game["end_reason"]["mlg_tournament_tie"];
  game["end_reason_mlg_mapping"][game["end_reason"]["control_allzones_win"]] = game["end_reason"]["mlg_allzones_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["control_allzones_loss"]] = game["end_reason"]["mlg_allzones_captured"];
  level._id_E41F = [];
  level thread onplayerconnect();
  _id_0A9A::_id_C287(::_id_E41D);
  level._id_DCA3 = ::_id_DCA2;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_98C7();
    var_0 thread eventsplashesthink();
  }
}

_id_DCBD(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  var_3 = undefined;

  if(istrue(var_2)) {
    var_3 = 1;
  }

  var_0 = _id_6D69(var_0);
  showsplash(var_0, var_1, undefined, var_3);

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    _id_0A8D::_id_B86E(var_0, "killstreak_earned", 1);
  }
}

_id_6D69(var_0) {
  var_1 = var_0;
  var_2 = scripts\mp\perks\perks::_id_6D68(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

_id_DCE9(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();

  if(isDefined(self._id_9000)) {
    var_5 = getdvarfloat("#x34b79232251f0b4ce", 0.5) * 1000;
    var_6 = int(max(var_5 - (gettime() - self._id_9000), 0));
    wait(var_6 / 1000.0);
  }

  showsplash(var_0, var_1, var_2, var_3, 1);
}

showsplash(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    thread _id_DCE9(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  if(getdvarint("#x33def60164323d0cb", 0) == 1) {
    if(_func_0222("mp/splashtable.csv", 0, var_0, 6) == "splash" && _func_0222("mp/splashtable.csv", 0, var_0, 7) == "skill") {
      var_5 = ["arena_evo_match_won", "arena_evo_teammate_left", "arena_evo_team_eliminated"];
      var_6 = 0;

      foreach(var_8 in var_5) {
        if(var_0 == var_8) {
          var_6 = 1;
          break;
        }
      }

      if(!var_6) {
        return;
      }
    }
  }

  var_10 = undefined;

  if(isDefined(var_2)) {
    var_10 = var_2 getentitynumber();
  }

  if(isDefined(self._id_C0FD) && self._id_C0FD >= 6) {
    _id_BED9(var_0, var_1, var_2, var_10, var_3);
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_81D3()) {
    _id_BED9(var_0, var_1, var_2, var_10, var_3);
    return;
  }

  _id_DCE4(var_0, var_1, var_2, var_10, var_3);
}

_id_DCE4(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(var_3)) {
    if(!isDefined(var_2)) {
      return;
    }
  }

  var_5 = _id_6D6D(var_0);

  if(!isDefined(var_5) || var_5 < 0) {
    return;
  }
  if(!isDefined(self._id_A4D7)) {
    self._id_A4D7 = 0;
  }

  if(!isDefined(self._id_E418)) {
    self._id_E418 = 1;
  }

  var_6 = var_5;

  if(self._id_E418) {
    var_6 = var_6 | 2048;
  }

  if(isDefined(var_1)) {
    self setclientomnvar("ui_player_splash_param_" + self._id_A4D7, var_1);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self._id_A4D7, -1);
  }

  if(isDefined(var_3)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_A4D7, var_3);
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_A4D7, -1);
  }

  if(isDefined(var_4)) {
    self setclientomnvar("ui_player_splash_use_alt_" + self._id_A4D7, var_4);
  } else {
    self setclientomnvar("ui_player_splash_use_alt_" + self._id_A4D7, 0);
  }

  self setclientomnvar("ui_player_splash_id_" + self._id_A4D7, var_6);

  if(!isDefined(self._id_C0FD)) {
    self._id_C0FD = 1;
  } else {
    self._id_C0FD++;
  }

  thread _id_388F();
  self._id_A4D7++;

  if(self._id_A4D7 >= 6) {
    self._id_A4D7 = 0;
    self._id_E418 = !self._id_E418;
  }
}

_id_BED9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_C189 = var_0;
  var_5._id_AC53 = var_1;
  var_5._id_B6AF = var_2;
  var_5._id_B726 = var_3;
  var_5._id_164E = var_4;

  if(!isDefined(self._id_E41B)) {
    self._id_E41B = var_5;
    self._id_E41C = var_5;
    thread _id_7495();
  } else {
    var_6 = self._id_E41C;
    var_6._id_A4D6 = var_5;
    self._id_E41C = var_5;
  }
}

_id_7495() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearSplashQueue");

  while(isDefined(self._id_E41B)) {
    if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_6D9E() == "dmz") {
      scripts\engine\utility::waittill_any_2("splash_list_cleared", "can_show_splashes");
    } else {
      scripts\engine\utility::waittill_any_2("splash_list_cleared", "spawned_player");
    }

    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = self._id_E41B;
      _id_DCE4(var_1._id_C189, var_1._id_AC53, var_1._id_B6AF, var_1._id_B726, var_1._id_164E);
      self._id_E41B = var_1._id_A4D6;

      if(!isDefined(self._id_E41B)) {
        break;
      }
    }
  }

  self._id_E41C = undefined;
}

_id_3983() {
  self notify("clearSplashQueue");

  for(var_0 = self._id_E41B; isDefined(var_0); var_1._id_A4D6 = undefined) {
    var_1 = var_0;
    var_0 = var_1._id_A4D6;
  }

  self._id_E41B = undefined;
  self._id_E41C = undefined;
}

_id_6D6D(var_0) {
  var_1 = level._id_E41F[var_0];

  if(!isDefined(var_1)) {
    var_1 = tablelookuprownum(_id_6D6F(), 0, var_0);
    level._id_E41F[var_0] = var_1;
  }

  return var_1;
}

_id_98C7() {
  self endon("disconnect");
  self._id_98C6 = [];
  var_0 = "default";

  if(isDefined(level._id_98C5)) {
    var_0 = level._id_98C5;
  }

  var_1 = level._id_98C9;
  var_2 = level._id_98C8;
  var_3 = 1.25;

  if(level.splitscreen || self _meth_81E2() && !isai(self)) {
    var_1 = var_1 - 40;
    var_2 = level._id_98C8 * 1.3;
    var_3 = var_3 * 1.5;
  }

  self._id_98C4 = scripts\mp\hud_util::createfontstring(var_0, var_2);
  self._id_98C4 settext("");
  self._id_98C4.archived = 0;
  self._id_98C4.sort = 10;
  self._id_98C4.showinkillcam = 0;
  self._id_98C4 scripts\mp\hud_util::setpoint("CENTER", level._id_98CA, 0, var_1);
  self._id_98CB = scripts\mp\hud_util::createfontstring("default", var_3);
  self._id_98CB scripts\mp\hud_util::setparent(self._id_98C4);
  self._id_98CB scripts\mp\hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self._id_98CB settext("");
  self._id_98CB.archived = 0;
  self._id_98CB.sort = 10;
  self._id_98CB.showinkillcam = 0;
}

_id_8808() {
  return 0;
}

_id_EF8B(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  var_5 = self _meth_81D3();
  var_6 = var_0;

  if(isDefined(var_4)) {
    self setclientomnvar("ui_round_end_extra_message", var_4);
  }

  var_7 = self.pers["team"];

  if(var_5) {
    var_7 = self _meth_8154();
  }

  if(!isDefined(var_7) || !scripts\engine\utility::array_contains(level._id_EF89, var_7)) {
    var_7 = "allies";
  }

  if(scripts\mp\utility\game::_id_875D() && isDefined(level._id_1AA5)) {
    var_8 = isDefined(self.pers["team"]) && scripts\engine\utility::array_contains(level._id_1AA5, var_7);
  } else {
    var_8 = isDefined(self.pers["team"]) && var_0 == var_7;
  }

  if(var_0 == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    var_6 = "allies";
  } else if(var_0 == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    var_6 = "allies";
  } else if(var_0 == "switching_sides") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["side_switch"]);
    var_6 = "allies";
  } else if(var_0 == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    var_6 = "allies";
  } else if(var_0 == "overtime") {
    if(scripts\mp\utility\game::_id_8B13() && !scripts\mp\utility\game::_id_15F1()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);
    }

    var_6 = "allies";
  } else if(var_0 == "match_point") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    var_6 = "allies";
  } else if(var_0 == "final_round") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    var_6 = "allies";
  } else if(var_0 == "tie") {
    if(istrue(level.leagueplaymatch) && istrue(level.leagueplaymatchcancelled)) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["cancelled"]);
    } else if(var_1 && !scripts\mp\utility\game::_id_10A16()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);
    }

    var_6 = "allies";
  } else if(var_5)
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  else if(var_8) {
    if(var_1 && !scripts\mp\utility\game::_id_10A16()) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    }
  } else if(var_1 && !scripts\mp\utility\game::_id_10A16())
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(istrue(self._id_8BD9) && scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  if(!var_5) {
    var_0 = var_6;
  }

  if(scripts\mp\utility\game::_id_875E() || scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "siege" || scripts\mp\utility\game::getgametype() == "control") {
    if(isDefined(var_3)) {
      if(isDefined(self.pers["team"]) && var_0 == var_7) {
        var_2 = var_2;
      } else {
        var_2 = var_3;
      }
    }
  } else if(scripts\mp\utility\game::_id_82D1() && scripts\mp\utility\game::_id_10A16() && scripts\mp\utility\game::_id_8AA1()) {
    if(scripts\mp\utility\game::getgametype() == "ctf") {
      if(isDefined(self.pers["team"]) && var_0 == var_7) {
        var_2 = game["end_reason"]["time_to_beat_ctf_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0]) {
        var_2 = game["end_reason"]["time_to_beat_ctf_loss"];
      }
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      if(isDefined(self.pers["team"]) && var_0 == var_7) {
        var_2 = game["end_reason"]["time_to_beat_uplink_win"];
      } else if(isDefined(self.pers["team"]) && var_0 == scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0]) {
        var_2 = game["end_reason"]["time_to_beat_uplink_loss"];
      }
    }
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "sd" && var_2 == game["end_reason"]["enemies_eliminated"] && var_7 != var_0) {
    var_2 = game["end_reason"]["friendlies_eliminated"];
  }

  if(var_5) {
    if(isDefined(game["end_reason_mlg_mapping"][var_2])) {
      var_2 = game["end_reason_mlg_mapping"][var_2];
    }
  }

  self setclientomnvar("ui_round_end_reason", var_2);

  if(var_5) {
    if(var_0 == "axis") {
      self setclientomnvar("ui_round_end_winner", 1);
    } else if(var_0 == "allies") {
      self setclientomnvar("ui_round_end_winner", 2);
    } else {
      self setclientomnvar("ui_round_end_winner", 0);
    }
  }

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::_id_8957() || scripts\mp\utility\game::_id_8935()) {
    var_9 = scripts\mp\gamescore::_id_0C0F(var_7);

    if(var_9 > 16000) {
      var_9 = 16000;
    }

    var_10 = scripts\mp\gamescore::_id_0C0F(scripts\mp\utility\game::_id_6BE2(var_7)[0]);

    if(var_10 > 16000) {
      var_10 = 16000;
    }

    self setclientomnvar("ui_round_end_friendly_score", var_9);
    self setclientomnvar("ui_round_end_enemy_score", var_10);
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][var_7]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][scripts\mp\utility\game::_id_6BE2(var_7)[0]]);
  }

  if(isDefined(self._id_9BA8)) {
    self setclientomnvar("ui_round_end_match_bonus", self._id_9BA8);
  }
}

_id_ACA7(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = level._id_B16C["all"];
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];

  if(_func_0121(var_0) && var_0 == "tie") {
    if(isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5 || isDefined(var_6) && self == var_6) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    }
  } else if(isDefined(var_4) && self == var_4 || isDefined(var_5) && self == var_5 || isDefined(var_6) && self == var_6)
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(istrue(self._id_8BD9) && scripts\mp\utility\game::onlinestatsenabled()) {
      var_1 = game["end_reason"]["loss_stat_prevented"];
    }
  }

  self setclientomnvar("ui_round_end_reason", var_1);

  if(isDefined(self._id_9BA8)) {
    self setclientomnvar("ui_round_end_match_bonus", self._id_9BA8);
  }
}

_id_6D6F() {
  return "mp/splashTable.csv";
}

_id_6D6E() {
  return 5;
}

_id_388F() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::_id_108F5("death", 0.5);

  while(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_81D3()) {
    wait 0.15;
  }

  self._id_C0FD = undefined;
  self notify("splash_list_cleared");
}

_id_E41D(var_0, var_1) {
  if(var_0 != "splash_shown") {
    return;
  }
  var_2 = tablelookupbyrow(_id_6D6F(), var_1, 0);
  var_3 = tablelookupbyrow(_id_6D6F(), var_1, 6);

  switch (var_3) {
    case "killstreak_splash":
      _id_AB19(var_2);
      break;
  }
}

_id_AB19(var_0) {
  _id_0A8D::_id_B86E(var_0, "killstreak_earned", 1);
  thread _id_350F(var_0);
}

_id_350F(var_0) {
  var_1 = scripts\mp\perks\perks::_id_6D68();

  if(var_0 == "specialist_perk_bonus") {
    wait 2.0;
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_positive");
  }
}

_id_DCA2(var_0, var_1) {
  var_2 = tablelookuprownum("mp/errorMessages.csv", 0, var_0);

  if(isDefined(var_1)) {
    self setclientomnvar("ui_mp_error_message_param", var_1);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", var_2);

  if(!isDefined(self._id_559A)) {
    self._id_559A = 0;
  }

  self._id_559A = !self._id_559A;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self._id_559A, 2, 1));
}

_id_DCA4(var_0, var_1) {
  foreach(var_3 in level.players) {
    _id_DCA2(var_0, var_1);
  }
}

_id_F0DB(var_0) {
  var_1 = tablelookuprownum("mp/miscMessages.csv", 0, var_0);

  if(isDefined(var_1) && var_1 >= 0) {
    return 1;
  }

  return 0;
}

_id_DCC6(var_0) {
  var_1 = tablelookuprownum("mp/miscMessages.csv", 0, var_0);
  var_2 = tablelookupbyrow("mp/miscMessages.csv", var_1, 3);

  if(isDefined(var_2) && var_2 != "") {
    self playlocalsound(var_2);
  }

  self setclientomnvar("ui_misc_message_id", var_1);
  self setclientomnvar("ui_misc_message_trigger", 1);
}

_id_DCC0(var_0) {
  var_1 = tablelookuprownum("mp/errorMessages.csv", 0, var_0);
  self setclientomnvar("ui_airspace_crowded_signaled", var_1);
}

showfieldkillstreakmessage(var_0) {
  var_1 = tablelookuprownum("mp/errorMessages.csv", 0, var_0);
  self setclientomnvar("ui_field_crowded_signaled", var_1);
}

eventsplashesthink() {
  self endon("disconnect");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  var_0 = 0;

  if(!isDefined(self.pers["hasSpawned"])) {
    var_0 = 1;
  }

  var_1 = getdvarint("#x3580980004274b38b", 0) == 1 || !isgamebattlematch();

  if(!var_1) {
    var_0 = 0;
  }

  if(_id_07D1::_id_60BE("infil_will_run")) {
    if(!_id_07D1::_id_60BE("prematch_done")) {
      level _id_07D1::_id_60C2("prematch_done");
    }
  }

  self waittill("loadout_class_selected");

  if(!isDefined(self)) {
    return;
  }
  var_2 = self getprivatepartysize() > 1;
  var_3 = _func_047A(self, 1);
  var_4 = isDefined(scripts\engine\utility::_id_1BAB(var_3, self));

  if(var_0) {
    if(getdvarint("#x3210420a7dc973e8c") == 2 || var_2 && getdvarint("#x36ffcac04370655e7") == 2 || var_4 && getdvarint("#x37ece014de673113d") == 2) {
      showsplash("event_double_xp");
    }

    if(getdvarint("#x3d4b34b03f860fb63") == 2 || var_2 && getdvarint("#x3b7dac4a1488a8d02") == 2) {
      showsplash("event_double_weapon_xp");
    }

    if(getdvarint("#x38a3274bf88cc97e3") == 2) {
      showsplash("event_double_operator_xp");
    }

    if(getdvarint("#x3e6db9b9123518ed7") == 2) {
      showsplash("event_double_clan_xp");
    }

    if(getdvarint("#x32a2a182348da7327") == 2) {
      showsplash("event_double_battle_xp");
    }

    if(getdvarint("#x35d8a45b02bade1e8") == 2 || var_2 && getdvarint("#x3d67051e252eaee73") == 2) {
      showsplash("event_double_xp_teams");
    }
  }
}

_id_A6B6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\utility\teams::_id_6A01(var_2);

  foreach(var_8 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_8)) {
      continue;
    }
    if(var_8.team == var_2) {
      if(isDefined(var_3)) {
        if(!scripts\engine\utility::array_contains(var_3, var_8)) {
          var_8 thread showsplash(var_0, var_4);
        }
      } else
        var_8 thread showsplash(var_0, var_4);

      continue;
    }

    foreach(var_10 in var_6) {
      if(var_8.team == var_10) {
        if(isDefined(var_3)) {
          if(!scripts\engine\utility::array_contains(var_3, var_8)) {
            var_8 thread showsplash(var_1, var_5);
          }

          continue;
        }

        var_8 thread showsplash(var_1, var_5);
      }
    }
  }
}

_id_FCBF(var_0, var_1, var_2, var_3, var_4) {
  level notify("updateHint");
  level endon("updateHint");

  foreach(var_6 in level.players) {
    if(isDefined(var_0) && var_6.team == var_0) {
      if(isDefined(var_3) && var_6 == var_3) {
        var_6 setclientomnvar("ui_match_status_hint_text", var_4);
      } else {
        var_6 setclientomnvar("ui_match_status_hint_text", var_1);
      }

      continue;
    }

    if(isDefined(var_2)) {
      var_6 setclientomnvar("ui_match_status_hint_text", var_2);
    }
  }
}