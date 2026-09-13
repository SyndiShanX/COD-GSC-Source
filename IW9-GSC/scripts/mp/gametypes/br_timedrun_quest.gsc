/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_timedrun_quest.gsc
******************************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_8F97A050F8203DAB = spawnStruct();
  level._id_8F97A050F8203DAB.time = getdvarint("dvar_71EDE8BA370404C2", 120);
  level._id_8F97A050F8203DAB.maxrange = getdvarint("dvar_B572422CDEA70219", 23000);
  level._id_8F97A050F8203DAB._id_5D186451F21D7020 = getdvarint("dvar_1F550799F4E3BD93", 5000);
  level._id_8F97A050F8203DAB._id_8F7C18F3DCCE9DFF = getdvarint("dvar_E1260EEE3FC09C9F", 20000);
  level._id_8F97A050F8203DAB._id_908D1B90E147E411 = getdvarint("dvar_8B3ECACA4442E5CD", 17000);
  level._id_8F97A050F8203DAB.radius = getdvarint("dvar_E74F977D917A9849", 150);
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
  data.funcs["onInit"] = ::_id_F95DF4809DFA1D7F;
  data.funcs["onTeamAssigned"] = ::_id_FBC4E1BC931264A8;
}

_id_F95DF4809DFA1D7F() {
  _id_15B89FF206500554 = self.tablet _id_3948B71D8C04B5B8();

  if(!isDefined(_id_15B89FF206500554))
    return 0;

  self._id_15B89FF206500554 = _id_15B89FF206500554;
  return 1;
}

_id_FBC4E1BC931264A8() {
  if(!isDefined(self._id_15B89FF206500554)) {
    _id_15B89FF206500554 = self.tablet _id_3948B71D8C04B5B8();

    if(!isDefined(_id_15B89FF206500554)) {
      return;
    }
    self._id_15B89FF206500554 = _id_15B89FF206500554;
  }

  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("timedrun", self.teams[0]);
  time = level._id_8F97A050F8203DAB.time;
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_FE13E6DC6FE958B8(time);
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_timedrun_quest_start_team_notify");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_timedrun_accept", self.teams[0], 1, 1);
  self.curorigin = self._id_15B89FF206500554.origin;
  _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_timedrun_objective", "current", self.curorigin + (0, 0, 65));
  thread timedrun_finishlinevfx(self._id_15B89FF206500554.origin, self.teams[0]);
  players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

  foreach(player in players)
  _id_64ACB6CE534155B7::showquestobjicontoplayer(player);

  thread tr_detectwinners();
}

_id_701B9420CA853766(success) {
  self notify("task_ended");
  _id_64ACB6CE534155B7::deletequestobjicon();
  wait 1.0;
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));
}

_id_FE13E6DC6FE958B8(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait(time);
  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_timedrun_quest_timer_expired", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_timedrun_fail", self.teams[0], 1, 1);
  thread _id_701B9420CA853766(0);
}

_id_3948B71D8C04B5B8() {
  _id_86EEDE4334852D70 = _id_4384ABBF498DF6A7::getallspawninstances();
  _id_CED8A1F62AE2956B = [];

  foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
    if(!istrue(_id_15B89FF206500554.disabled))
      _id_CED8A1F62AE2956B[_id_CED8A1F62AE2956B.size] = _id_15B89FF206500554;
  }

  locations = scripts\engine\utility::array_randomize(_id_CED8A1F62AE2956B);
  _id_FDC6EE1B91EBB7BF = _id_2695A20D4011076D::getmintimetillpointindangercircle(self.origin);
  _id_15B89FF206500554 = undefined;
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = level._id_8F97A050F8203DAB.maxrange;

  foreach(_id_AC0E594AC96AA3A8, node in locations) {
    dist = distance2d(node.origin, self.origin);

    if(dist > level._id_8F97A050F8203DAB.maxrange || dist < level._id_8F97A050F8203DAB._id_5D186451F21D7020) {
      continue;
    }
    if(!level.br_circle_disabled) {
      _id_28DEB7FF62E281D3 = _id_2695A20D4011076D::getmintimetillpointindangercircle(node.origin);

      if(_id_28DEB7FF62E281D3 < _id_FDC6EE1B91EBB7BF) {
        continue;
      }
      _id_42F65B4B53C1F5D4 = dist / 190;
      _id_28DEB7FF62E281D3 = _id_28DEB7FF62E281D3 - _id_42F65B4B53C1F5D4;

      if(_id_28DEB7FF62E281D3 < 45) {
        continue;
      }
      _id_5435995E95681B89 = 0;

      if(dist < level._id_8F97A050F8203DAB._id_8F7C18F3DCCE9DFF) {
        if(dist < level._id_8F97A050F8203DAB._id_908D1B90E147E411)
          _id_5435995E95681B89 = level._id_8F97A050F8203DAB._id_908D1B90E147E411 - dist;
      } else
        _id_5435995E95681B89 = dist - level._id_8F97A050F8203DAB._id_8F7C18F3DCCE9DFF;

      if(_id_5435995E95681B89 < _id_BE0F4D48FA40793F) {
        _id_BE0F4D48FA40793F = _id_5435995E95681B89;
        _id_02ED718E1DA0B965 = _id_AC0E594AC96AA3A8;
        _id_15B89FF206500554 = node;

        if(_id_5435995E95681B89 <= 0) {
          break;
        }
      }
    }
  }

  return _id_15B89FF206500554;
}

timedrun_finishlinevfx(spawn_origin, team) {
  finishlinevfx = spawnfx(level._effect["vfx_marker_base_orange_pulse"], spawn_origin + (0, 0, 10));
  finishlinevfx.angles = vectortoangles((0, 0, 1));
  finishlinevfx hide();
  wait 0.5;
  triggerfx(finishlinevfx);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  finishlinevfx showtoplayer(player);

  self.finishlinevfx = finishlinevfx;
}

tr_detectwinners() {
  self endon("task_ended");
  level endon("game_ended");

  for(;;) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
      if(distance(player.origin, self._id_15B89FF206500554.origin) < level._id_8F97A050F8203DAB.radius) {
        rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("timedrun", self.teams[0]);

        if(isDefined(rewards) && isDefined(rewards[0]))
          _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_timedrun_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("timedrun"), rewards[0], self.teams[0]);

        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_misc_success", self.teams[0], 1, 1);
        _id_51F2B611A0573B40 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

        foreach(player in _id_51F2B611A0573B40) {
          if(isDefined(player) && !istrue(player.br_iseliminated))
            _id_4384ABBF498DF6A7::kiosksetupfiresaleforplayer(self._id_15B89FF206500554, player);
        }

        self.rewardmodifier = undefined;
        self.result = "success";
        thread _id_701B9420CA853766(1);
        return;
      }
    }

    waitframe();
  }
}

hidetimedrunhudfromplayer(player) {
  _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  player _id_64ACB6CE534155B7::uiobjectivehide();
}

deletetimedrunhud() {
  foreach(player in self.playerlist)
  hidetimedrunhudfromplayer(player);

  _id_64ACB6CE534155B7::deletequestobjicon();
}