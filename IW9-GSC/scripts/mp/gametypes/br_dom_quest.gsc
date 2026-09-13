/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dom_quest.gsc
*************************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_3C9AD0FEE1A9350B = spawnStruct();
  level._id_3C9AD0FEE1A9350B.capturetime = getdvarint("dvar_D1BA52FB82CF7653", 30);
  level._id_3C9AD0FEE1A9350B.time = getdvarint("dvar_BE42880C860992EC", 240);
  level._id_3C9AD0FEE1A9350B._id_029A79D378C70E0B = getdvarint("dvar_51711B96C9B3EEC0", 128);
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
  data.funcs["onInit"] = ::_id_9088FFE8CB64311F;
  data.funcs["onTeamAssigned"] = ::_id_E387EFB61AD86B48;
  setupdom();
}

_id_9088FFE8CB64311F() {
  placement = self.tablet _id_8BAAD4BD99E782A3();

  if(!isDefined(placement))
    return 0;

  self.reservedplacement = placement;
  return 1;
}

_id_E387EFB61AD86B48() {
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("domination", self.teams[0]);
  time = level._id_3C9AD0FEE1A9350B.time;
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_A859560671DE3158(time);

  if(!isDefined(self.reservedplacement)) {
    placement = self.tablet _id_8BAAD4BD99E782A3();

    if(!isDefined(placement)) {
      return;
    }
    self.reservedplacement = placement;
  }

  _id_A5ECBC99B54D31DA(self.reservedplacement);
  domflagupdateicons();
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("domination", self.teams[0]);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  player thread scripts\mp\hud_message::showsplash("br_domination_quest_start_team");

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_accept", self.teams[0], 1);
}

_id_034A295960F3D086(success) {
  self notify("task_ended");
  self.ended = 1;
  self.domflag scripts\mp\gameobjects::releaseid();
  wait 1.0;
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));
}

_id_A859560671DE3158(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait(time);
  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_domination_quest_timer_expired", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.teams[0], 1);
  thread _id_034A295960F3D086(0);
}

_id_8BAAD4BD99E782A3() {
  locations = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_dom_tower", "script_noteworthy"));
  _id_FDC6EE1B91EBB7BF = _id_2695A20D4011076D::getmintimetillpointindangercircle(self.origin);
  placement = undefined;
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = 12000;

  foreach(_id_AC0E594AC96AA3A8, node in locations) {
    dist = distance2d(node.origin, self.origin);

    if(dist > _id_BE0F4D48FA40793F) {
      continue;
    }
    if(!level.br_circle_disabled) {
      _id_28DEB7FF62E281D3 = _id_2695A20D4011076D::getmintimetillpointindangercircle(node.origin);

      if(_id_28DEB7FF62E281D3 < _id_FDC6EE1B91EBB7BF) {
        continue;
      }
      _id_42F65B4B53C1F5D4 = dist / 190;
      _id_28DEB7FF62E281D3 = _id_28DEB7FF62E281D3 - _id_42F65B4B53C1F5D4;

      if(_id_28DEB7FF62E281D3 < 30) {
        continue;
      }
      _id_5435995E95681B89 = 0;

      if(dist < 8000) {
        if(dist < 6000)
          _id_5435995E95681B89 = 6000 - dist;
      } else
        _id_5435995E95681B89 = dist - 8000;

      if(_id_5435995E95681B89 < _id_BE0F4D48FA40793F) {
        _id_BE0F4D48FA40793F = _id_5435995E95681B89;
        _id_02ED718E1DA0B965 = _id_AC0E594AC96AA3A8;
        placement = node;

        if(_id_5435995E95681B89 <= 0) {
          break;
        }
      }
    }
  }

  return placement;
}

_id_A5ECBC99B54D31DA(placement) {
  _id_1606F84A9B5BD33B = placement.origin;
  radius = level._id_3C9AD0FEE1A9350B._id_029A79D378C70E0B;
  trigger = spawn("trigger_radius", _id_1606F84A9B5BD33B, 0, int(radius), int(level.br_domheight));
  trigger.angles = placement.angles;
  trigger.script_label = "_a";
  level.setdomscriptablepartstatefunc = ::domflag_setdomscriptablepartstate;
  domflag = _id_6663215F917210AE::setupobjective(trigger);
  domflag.flagmodel setModel("lm_domination_point_01");
  domflag.onuse = ::domflag_onuse;
  domflag.onbeginuse = ::domflag_onbeginuse;
  domflag.onuseupdate = ::domflag_onuseupdate;
  domflag.onenduse = ::domflag_onenduse;
  domflag.usecondition = ::domflag_usecondition;
  domflag.lockupdatingicons = 1;
  domflag.checkuseconditioninthink = 1;
  scripts\mp\objidpoolmanager::update_objective_position(domflag.objidnum, domflag.curorigin + (0, 0, 60));
  level.flagcapturetime = level._id_3C9AD0FEE1A9350B.capturetime;
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  self.lastcircletick = -1;
  self.domflag = domflag;
  self.curorigin = domflag.curorigin;
  domflag._id_B8EBE3F71A08AB40 = self;
  self.radius = radius;
}

domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
      objective_addclienttomask(self.domflag.objidnum, player);
  }
}

domflag_hideiconfromplayer(player) {
  objective_removeclientfrommask(self.domflag.objidnum, player);
}

domflag_showicontoplayer(player) {
  objective_addclienttomask(self.domflag.objidnum, player);
}

domflagupdateiconsframeend() {
  self endon("removed");
  waittillframeend;
  domflagupdateicons();
}

deletedomflaggameobject() {
  foreach(_id_06D8B9034036E075 in self.domflag.visuals)
  _id_06D8B9034036E075 delete();

  if(isDefined(self.domflag.flagmodel))
    self.domflag.flagmodel delete();

  if(isDefined(self.domflag.scriptable))
    self.domflag.scriptable delete();

  if(isDefined(self.domflag.trigger)) {
    self.domflag.trigger delete();
    self.domflag.trigger = undefined;
  }

  self.domflag thread gameobjectreleaseid_delayed();
  self.domflag notify("deleted");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

setupdom() {
  if(isDefined(level.br_domheight)) {
    return;
  }
  level.disableinitplayergameobjects = 0;
  level.br_domheight = 120;
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  level.iconovertime = "icon_waypoint_ot";
  _setdomflagiconinfo("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _setdomflagiconinfo("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _setdomflagiconinfo("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

_setdomflagiconinfo(name, colors, string, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointstring[name] = string;
  level.waypointshader[name] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

domflag_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  if(progress < 1.0 && !level.gameended)
    play_spotrep_capture_sfx(progress, team);

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

domflag_onbeginuse(_id_22282E7D48CA3400) {
  if(!isDefined(self.obj_icon_revealed) || !self.obj_icon_revealed) {
    self.obj_icon_revealed = 1;
    level thread _id_64ACB6CE534155B7::utilflare_shootflare(self.curorigin, "dom");
    playerteam = scripts\mp\utility\player::getteamarray(_id_22282E7D48CA3400.team);
    playersinrange = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, playerteam);

    foreach(player in playersinrange) {
      if(isDefined(player) && isalive(player))
        player thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
    }

    _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(_id_22282E7D48CA3400.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

domflag_onuse(_id_22282E7D48CA3400) {
  if(self._id_B8EBE3F71A08AB40.teams[0] == _id_22282E7D48CA3400.team) {
    missionid = _id_64ACB6CE534155B7::getquestindex("domination");
    _id_64ACB6CE534155B7::questrewardcirclepeek(self._id_B8EBE3F71A08AB40.teams[0]);
    rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("dom", self._id_B8EBE3F71A08AB40.teams[0]);

    if(rewards && rewards[0])
      _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_domination_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("dom"), rewards[0], self._id_B8EBE3F71A08AB40.teams[0]);

    _id_64ACB6CE534155B7::displaysquadmessagetoteam(self._id_B8EBE3F71A08AB40.teams[0], _id_22282E7D48CA3400, 8, missionid);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_success", self._id_B8EBE3F71A08AB40.teams[0], 1, 1);
    self._id_B8EBE3F71A08AB40.rewardorigin = self.flagmodel.origin;
    self._id_B8EBE3F71A08AB40.rewardangles = self.flagmodel.angles;
    self._id_B8EBE3F71A08AB40.result = "success";
    self._id_B8EBE3F71A08AB40 thread _id_034A295960F3D086(1);
  } else {
    _id_64ACB6CE534155B7::displayteamsplash(self._id_B8EBE3F71A08AB40.teams[0], "br_domination_quest_failure");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self._id_B8EBE3F71A08AB40.teams[0], 1);
    self._id_B8EBE3F71A08AB40.result = "fail";
  }
}

domflag_onenduse(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

domflag_setdomscriptablepartstate(part, state, _id_BA360E4FF7BE8D96) {
  switch (state) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      state = "using";

      if(isDefined(_id_BA360E4FF7BE8D96))
        state = state + _id_BA360E4FF7BE8D96;

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse")
        self.scriptable setscriptablepartstate("flag", state);

      return 1;
  }
}

domflag_usecondition(player) {
  return self._id_B8EBE3F71A08AB40.teams[0] == player.team && !istrue(self._id_B8EBE3F71A08AB40.ended);
}