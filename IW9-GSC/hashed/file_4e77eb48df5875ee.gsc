/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e77eb48df5875ee.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_F330CDB3A4738B38 = spawnStruct();
  level._id_F330CDB3A4738B38._id_70FC6EFCAE372EDE = getdvarint("dvar_FDE84813012BBA7D", 300);
  level._id_F330CDB3A4738B38._id_5B4471E9EFDE87C3 = getdvarint("dvar_8D4D8D285E849CCB", 45);
  level._id_F330CDB3A4738B38.planttime = getdvarint("dvar_E64F2457394EE5FB", 5);
  level._id_F330CDB3A4738B38.defusetime = getdvarint("dvar_6802C4A92950D2E6", 5);
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
  level._effect["samsite_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  _id_25DD3020969AA0F6 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_supply_site", "script_noteworthy"));
  _id_78E1E12738C48FD3 = [];

  foreach(node in _id_25DD3020969AA0F6) {
    if(!isDefined(_id_78E1E12738C48FD3[node._id_B205D90302DA2F07]))
      _id_78E1E12738C48FD3[node._id_B205D90302DA2F07] = [];

    _id_78E1E12738C48FD3[node._id_B205D90302DA2F07][_id_78E1E12738C48FD3[node._id_B205D90302DA2F07].size] = node;
  }

  level._id_364DC596F40B8927 = [];

  foreach(_id_B205D90302DA2F07, _id_8B462903A1F84F9C in _id_78E1E12738C48FD3) {
    foreach(node in _id_8B462903A1F84F9C) {
      if(istrue(node.inuse)) {
        continue;
      }
      foreach(_id_1A7683A86F43BFF9 in _id_8B462903A1F84F9C) {
        if(node == _id_1A7683A86F43BFF9) {
          continue;
        }
        if(istrue(_id_1A7683A86F43BFF9.inuse)) {
          continue;
        }
        distance = distancesquared(node.origin, _id_1A7683A86F43BFF9.origin);

        if(distance < 4000000 || distance > 144000000) {
          continue;
        }
        node.end = _id_1A7683A86F43BFF9;
        node.inuse = 1;
        _id_1A7683A86F43BFF9.inuse = 1;
        level._id_364DC596F40B8927[level._id_364DC596F40B8927.size] = node;
      }
    }
  }

  scripts\engine\scriptable::scriptable_addusedcallback(::_id_4CADBB00EF649EE1);
  data.funcs["onInit"] = ::_id_A5B36AFC40A950F8;
  data.funcs["onTeamAssigned"] = ::_id_0914B17F8974317B;
}

_id_1044844917E715C5(node) {
  self.node = node;
  self.end = self.node.end;
  self.node._id_B8EBE3F71A08AB40 = self;
  self.end._id_B8EBE3F71A08AB40 = self;
  level._id_364DC596F40B8927 = scripts\engine\utility::array_remove(level._id_364DC596F40B8927, self.node);
  self.node _id_58FE895FD0FBE620::_id_402EBB691260E816();
  self.end _id_58FE895FD0FBE620::_id_402EBB691260E816();
}

_id_A5B36AFC40A950F8() {
  placement = self.tablet _id_BC9367AEE36E166B();
  self.bombsplanted = 0;
  self._id_8F0A9767E7A155A1 = 0;

  if(!isDefined(placement))
    return 0;

  _id_1044844917E715C5(placement);
  return 1;
}

_id_0914B17F8974317B() {
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("br_demo_first", self.teams[0]);
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(level._id_F330CDB3A4738B38._id_70FC6EFCAE372EDE);

  if(!isDefined(self.node)) {
    placement = self.tablet _id_BC9367AEE36E166B();

    if(!isDefined(placement)) {
      return;
    }
    _id_1044844917E715C5(placement);
  }

  self.curorigin = self.node.origin;
  self.offset3d = (0, 0, 100);
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_map_icon_obj_bomb_collect");
  _id_88BC5CA990516A9F = sortbydistance([self.node, self.end], self.tablet.origin)[0];
  objective_position(self.objidnum, _id_88BC5CA990516A9F.origin + self.offset3d);
  _id_BDBEEFC9F251434B();
  thread _id_B9E2920F98ADBE0F(time);
  self.node _id_6C4E8CEA70BF4B6D::_id_8CD2AC82037F025C("Hostage_Dmz", self.node.origin, 1000);
  self.end _id_6C4E8CEA70BF4B6D::_id_8CD2AC82037F025C("Hostage_Dmz", self.end.origin, 1000);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("br_demo_first", self.teams[0]);

  foreach(player in _id_E2B2BBD9E6539F11) {
    player thread scripts\mp\hud_message::showsplash("br_demolition_quest_start_team");
    self.node _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
    self.end _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
  }

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_accept", self.teams[0], 1);
  self.node thread _id_D78ACA20601416CD();
  self.end thread _id_D78ACA20601416CD();
}

_id_2B3BF2D2CE4B86FF(success) {
  self notify("task_ended");
  self.ended = 1;
  scripts\mp\gameobjects::releaseid();
  self.node _id_58FE895FD0FBE620::_id_274106FC5A44C464();
  self.end _id_58FE895FD0FBE620::_id_274106FC5A44C464();
  wait 1.0;
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));
}

_id_B9E2920F98ADBE0F(time) {
  self endon("task_ended");
  level endon("game_ended");
  waitframe();
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  wait(time);
  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_demolition_quest_timer_expired", params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.teams[0], 1);
  thread _id_2B3BF2D2CE4B86FF(0);
}

_id_D78ACA20601416CD() {
  _id_58FE895FD0FBE620::_id_DDA2D720BBB26623();
  self waittill("bomb_planted");
  self._id_B8EBE3F71A08AB40.bombsplanted++;
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  if(self._id_B8EBE3F71A08AB40.bombsplanted == 2) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_second_plant", self._id_06036CD81FE22627.team);
    objective_position(self._id_B8EBE3F71A08AB40.objidnum, self.plantedbomb.origin + (0, 0, 50));
    self._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_473AB9452660E60F("br_demo_defend");
  } else if(self._id_B8EBE3F71A08AB40.bombsplanted == 1) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_first_plant", self._id_06036CD81FE22627.team);
    node = scripts\engine\utility::ter_op(self == self._id_B8EBE3F71A08AB40.node, self._id_B8EBE3F71A08AB40.end, self._id_B8EBE3F71A08AB40.node);
    objective_position(self._id_B8EBE3F71A08AB40.objidnum, node.origin + self._id_B8EBE3F71A08AB40.offset3d);
    self._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_473AB9452660E60F("br_demo_second");
  }

  _id_58FE895FD0FBE620::_id_EBAA4417A40158F5();
  thread _id_ADB1B940D140CDE0();
  thread _id_5666E11B17254D43(level._id_F330CDB3A4738B38._id_5B4471E9EFDE87C3);
}

_id_ADB1B940D140CDE0() {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_exploded");
  self waittill("bomb_defused");
  self.scriptable freescriptable();
  _id_03060D27FFB03AD2 = self._id_285292A6695A1FCA.team;
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_defused_others", _id_03060D27FFB03AD2, 1.5);
  thread scripts\mp\music_and_dialog::_id_F139A00330157E01(scripts\mp\utility\teams::getteamdata(_id_03060D27FFB03AD2, "players"));
  _id_379D6BAD84E53438 = self._id_B8EBE3F71A08AB40.teams[0];
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_defused", _id_379D6BAD84E53438, 1.5);
  thread scripts\mp\music_and_dialog::_id_4FE255A72526EA50(scripts\mp\utility\teams::getteamdata(_id_379D6BAD84E53438, "players"));
  params = spawnStruct();
  missionid = _id_64ACB6CE534155B7::getquestindex("br_demo_first");
  _id_501265B5FE210821 = _id_64ACB6CE534155B7::_id_D282041688C032B5("br_demo_first");
  params.intvar = _id_501265B5FE210821;

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_03060D27FFB03AD2, "players")) {
    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_501265B5FE210821);
    player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_501265B5FE210821);
  }

  rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("demo", _id_03060D27FFB03AD2);

  if(isDefined(rewards) && isDefined(rewards[0]))
    _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_demolition_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("demo"), rewards[0], _id_03060D27FFB03AD2);

  _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_demolition_quest_failure", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("demo"), 0, _id_379D6BAD84E53438);
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(self._id_B8EBE3F71A08AB40.teams[0], self._id_285292A6695A1FCA, 8, missionid);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_success", _id_03060D27FFB03AD2, 1, 1);
  self._id_B8EBE3F71A08AB40 thread _id_2B3BF2D2CE4B86FF(0);
  wait 10.0;
  self.plantedbomb delete();
}

_id_5666E11B17254D43(time) {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_defused");
  _id_58FE895FD0FBE620::_id_B73C05A413966AB2(time);
  _id_58FE895FD0FBE620::_id_ACCEAD05B2C47CB7();
  wait 0.1;
  self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1++;
  _id_58FE895FD0FBE620::_id_274106FC5A44C464();
  team = self._id_B8EBE3F71A08AB40.teams[0];

  if(self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1 == 2) {
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_second_exploded", team, 1.5);
    thread scripts\mp\music_and_dialog::_id_F139A00330157E01(scripts\mp\utility\teams::getteamdata(team, "players"));
    missionid = _id_64ACB6CE534155B7::getquestindex("br_demo_first");
    rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("demo", self._id_B8EBE3F71A08AB40.teams[0]);

    if(isDefined(rewards) && isDefined(rewards[0]))
      _id_64ACB6CE534155B7::_id_878EBCC241B54505("dmz_demo_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("demo"), rewards[0], self._id_B8EBE3F71A08AB40.teams[0]);

    _id_64ACB6CE534155B7::displaysquadmessagetoteam(self._id_B8EBE3F71A08AB40.teams[0], self._id_06036CD81FE22627, 8, missionid);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_dom_success", self._id_B8EBE3F71A08AB40.teams[0], 1, 1);
    self._id_B8EBE3F71A08AB40 thread _id_2B3BF2D2CE4B86FF(1);
  } else if(self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1 == 1) {
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_first_exploded", team, 1.5);
    _id_64ACB6CE534155B7::displayteamsplash(team, "dmz_demo_first_explosion");
  }
}

_id_4CADBB00EF649EE1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part != "dmz_supply_site") {
    return;
  }
  if(state == "usable") {
    instance setscriptablepartstate("dmz_supply_site", "unusable");
    node = instance.node;

    if(isDefined(node._id_8E977040CC228632) && istrue(node._id_8E977040CC228632)) {
      return;
    }
    node._id_8E977040CC228632 = 1;
    bomb = _id_58FE895FD0FBE620::_id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.planttime) {
      if(node._id_A4CF15C49F3E9EEF || !isalive(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
        node._id_8E977040CC228632 = 0;
        _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
        instance setscriptablepartstate("dmz_supply_site", "usable");
        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
    _id_EEB138FAE3842A92 = spawn("script_model", player.origin);
    _id_EEB138FAE3842A92 setModel("offhand_2h_wm_briefcase_bomb_v0");
    _id_EEB138FAE3842A92.visuals = [];
    _id_EEB138FAE3842A92.visuals[0] = spawn("script_model", player.origin);
    _id_EEB138FAE3842A92.visuals[0] setModel("tag_origin");
    _id_EEB138FAE3842A92.curorigin = _id_EEB138FAE3842A92.origin;
    _id_EEB138FAE3842A92.offset3d = (0, 0, 15);
    _id_EEB138FAE3842A92.safeorigin = _id_EEB138FAE3842A92.origin;
    _id_EEB138FAE3842A92.trigger = spawnStruct();
    _id_EEB138FAE3842A92.objidnum = -1;
    _id_EEB138FAE3842A92 scripts\mp\gameobjects::setdropped(undefined, undefined);
    node.plantedbomb = _id_EEB138FAE3842A92;
    node.plantedbomb.node = node;
    node.bombplanted = 1;
    node._id_06036CD81FE22627 = player;
    node notify("bomb_planted");
  } else if(state == "defusable") {
    instance setscriptablepartstate("dmz_supply_site", "unusable");
    node = instance.node;

    if(isDefined(node._id_482C2428A4E2FDDC) && istrue(node._id_482C2428A4E2FDDC)) {
      return;
    }
    node._id_482C2428A4E2FDDC = 1;
    node.plantedbomb hide();
    bomb = _id_58FE895FD0FBE620::_id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.defusetime) {
      if(node._id_A4CF15C49F3E9EEF || !isalive(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
        node._id_482C2428A4E2FDDC = 0;
        _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
        node.plantedbomb show();
        instance setscriptablepartstate("dmz_supply_site", "defusable");
        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    node notify("bomb_defused");
    node._id_285292A6695A1FCA = player;
    _id_58FE895FD0FBE620::_id_0DB896F4486CA187(player, bomb);
    node.plantedbomb show();
  }
}

_id_BC9367AEE36E166B() {
  _id_FDC6EE1B91EBB7BF = _id_2695A20D4011076D::getmintimetillpointindangercircle(self.origin);
  placement = undefined;
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = 24000;

  foreach(_id_AC0E594AC96AA3A8, node in level._id_364DC596F40B8927) {
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

_id_BDBEEFC9F251434B() {
  objective_showtoplayersinmask(self.objidnum);
  objective_removeallfrommask(self.objidnum);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
      objective_addclienttomask(self.objidnum, player);
  }
}