/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_capshoot_quest.gsc
***********************************************/

init() {
  var_0 = revivent_watchfordeath_safety(game["_encstr_991C0AB9ED5B57161FE89B83"]);

  foreach(var_2 in var_0)
  alwayssnowfight(var_2);

  var_4 = revivent_watchfordeath_safety(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  foreach(var_2 in var_4)
  alwayssnowfight(var_2);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestlocale("_encstr_92A70BB9C21360A81DA37B69CD");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercreatequestlocale("_encstr_92A70BB9C21360A81DA37B69CD", ::get_consecutive_def);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercheckiflocaleisavailable("_encstr_92A70BB9C21360A81DA37B69CD", ::get_comp_dist_for_info_loop);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_92A70BB9C21360A81DA37B69CD", ::get_corpse_array);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_92A70BB9C21360A81DA37B69CD", ::get_connected_nodes_targetname_array);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_92A70BB9C21360A81DA37B69CD", ::get_control_station_side_array);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_92A70BB9C21360A81DA37B69CD", ::get_convoy_vehicle_get_in_scene_name);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A70BB9C21360A81DA37B69CD").nextid = 0;
  _id_1322D();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8503121B0B7315C25B9528B436ADAB83897BDEA3", ::get_chopperexfil_transient);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87E013D696CDCD5ADE9BEBD8C2C1BE0BB1362B071D"] = "_encstr_9ADA22D6D26EB9D2B7E6F5AD4B6E37B4B773EB19F6B5D7B06C1BAC0E8EFA372B36ABC9AC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BA5142D0A837F313845EF19C76B8FAFB5EF527F765F"] = "_encstr_81C91C0D78C823DAF09D4787FBA62361802009D750C0C7B3D59FCFBFF74E";
}

revivent_watchfordeath_safety(var_0) {
  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    return registermovequestlocale();
  else
    return relic_nuketimer_playvo();
}

registermovequestlocale() {
  return ["_encstr_9A031498929A6F802FF7A508DB1F480902AB68200AF4"];
}

relic_nuketimer_playvo() {
  return ["_encstr_BE2616CB6B287213B7508339B86B5BED98F952558308B1EB"];
}

alwayssnowfight(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory(var_0, 1);

  if(!var_1) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2A(var_0, "_encstr_BE1E194A0E91B877C347FD581559B387ADBB77AD4E8CDFA55822FB");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D(var_0, ::get_current_ai_cap);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance(var_0, ::get_correct_bomb_wire_pair);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C(var_0, 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31(var_0, ::get_closest_available_player_new);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13180(var_0);
}

get_correct_bomb_wire_pair() {
  if(isDefined(level._id_13AC8[self.team]))
    level._id_13AC8[self.team] = scripts\engine\utility::array_remove(level._id_13AC8[self.team], self.squadindex);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehidefromteam(self.team);
  self._id_1393B thread get_combat_station_next_combat_action();
}

get_corpse_array() {
  foreach(var_1 in self.subscribedinstances)
  var_1 thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();

  last_vampire_feedback();
  self.get_closest_living_player_not_in_laststand = undefined;
}

get_current_ai_cap() {
  self.questcategory = "_encstr_B601090EE6BB5FB8DF17A3";
  return 1;
}

get_consecutive_def(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A70BB9C21360A81DA37B69CD").nextid++;
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createlocaleinstance("_encstr_92A70BB9C21360A81DA37B69CD", self.questcategory, "_encstr_95B80A87DA4151175B6D4118" + _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A70BB9C21360A81DA37B69CD").nextid);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_2 = var_0.origin;

  if(!(var_0.spawnflags & 23)) {}

  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12971(var_0);
  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, int(var_3), int(level.debugpayloadobjectivesstart_infil));
  var_4.script_label = "_encstr_B40101";
  level._id_13135 = ::get_closest_valid_player;
  var_5 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_4);
  var_5.onuse = ::get_closest_spawns;
  var_5.onbeginuse = ::get_closest_origin_index;
  var_5.onuseupdate = ::get_closest_unclaimed_destination;
  var_5.onenduse = ::get_closest_player_dist;
  var_5.usecondition = ::get_combat_action;
  var_5.lockupdatingicons = 1;
  var_5.getrandompointincirclewithindistance = 1;
  var_5.flagmodel setModel("_encstr_AD751E3382F9D3286C5F50E02BA1261F72BF38BE2F528FF077DF58E81BD978A5");
  scripts\mp\objidpoolmanager::update_objective_position(var_5.objidnum, var_5.curorigin + (0, 0, 60));
  level.flagcapturetime = getdvarfloat("_encstr_B84A1E676F9E51C2087E56DE7389190BFDA7E35FD74FEBAC68E3CFA9EB4B5D42", 30);
  var_5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_1.lastcircletick = -1;
  var_1.get_closest_living_player_not_in_laststand = var_5;
  var_1.curorigin = var_5.curorigin;
  var_1.team = self.team;
  var_5.locale = var_1;
  var_5.squadindex = self.squadindex;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_92A70BB9C21360A81DA37B69CD", var_1);
  return var_1;
}

get_comp_dist_for_info_loop(var_0) {
  var_1 = getdvarfloat("_encstr_8D0225DCD8C9FA899CAF8D58E0F58BEA5937D1F56BC2C3D71B58E08EBAC9ACEBE0959CB1ACE6E8", 0.2);
  var_2 = getdvarfloat("_encstr_83BE1B3BF60B3FA6DDC91A3298AF5A2F4166A49F19B16BA1896022CA98", 4);
  var_3 = 0;

  if(isDefined(self.get_closest_living_player_not_in_laststand.curprogress))
    var_3 = self.get_closest_living_player_not_in_laststand.curprogress / self.get_closest_living_player_not_in_laststand.usetime;

  if(var_3 > var_1)
    return 0;

  if(self.subscribedinstances.size >= var_2)
    return 0;

  return 1;
}

get_connected_nodes_targetname_array(var_0, var_1) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand)) {
    return;
  }
  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }
  self.lastcircletick = var_2;

  if(isDefined(self.get_closest_living_player_not_in_laststand) && isDefined(self.get_closest_living_player_not_in_laststand.traincar))
    self.curorigin = self.get_closest_living_player_not_in_laststand.traincar.origin;

  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      if(isDefined(var_5)) {
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_5.team, "_encstr_8EA121899CD7360B83DC43EDDBE8F5B8EACA378ED78D4BC91B36B27D9916B4C6D59CAC");
        var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_5.team, var_5.squadindex);
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8EA121899CD7360B83DC43EDDBE8F5B8EACA378ED78D4BC91B36B27D9916B4C6D59CAC", 1, var_6);
      }

      var_5.result = "_encstr_A78F076CA54E1B1B56";
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  }
}

get_control_station_side_array(var_0) {
  get_closest_munitions(var_0);
}

get_convoy_vehicle_get_in_scene_name(var_0) {
  foreach(var_2 in self.teams) {
    if(var_0.team == self.subscribedinstances[0].team)
      get_closest_visible_drone(var_0);
  }
}

get_chopperexfil_transient(var_0) {
  if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::usb(var_0.scriptablename))
    return undefined;

  var_1 = var_0.tracknonoobplayerlocation;

  if(isDefined(var_1.questcategory) && var_1.questcategory == "_encstr_B601090EE6BB5FB8DF17A3") {
    if(self.team == var_1.team) {
      var_2 = revivent_watchfordeath_safety(self.team);

      foreach(var_4 in var_2) {
        if(isDefined(level.questinfo.quests[var_4])) {
          foreach(var_6 in level.questinfo.quests[var_4].instances) {
            if(isDefined(var_6) && self.squadindex == var_6.squadindex)
              return 10;
          }
        }
      }

      return 1;
    } else
      return 22;
  }

  return undefined;
}

takequestitem(var_0) {
  var_1 = search(var_0._id_139EB, self, 1, var_0);

  if(!isDefined(var_1)) {
    return;
  }
  _id_1336D(var_0._id_139EB, [self]);
  var_1 _id_13742([self]);

  if(istrue(level.disable_super_in_turret._id_12273) && isDefined(var_0._id_12157)) {
    var_2 = [[var_0._id_12157]](var_0);

    if(isDefined(var_2) && isDefined(var_0._id_12158)) {
      if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) == 1)
        search(var_0._id_12158, var_2, 0, var_0, var_1);
      else
        search(var_0._id_12158, var_2, 0, var_0);

      _id_1336D(var_0._id_12158, [var_2]);
      var_1 _id_13742([var_2]);
    }
  }

  if(isDefined(level.disable_super_in_turret._id_12979) && isDefined(var_1._id_12978))
    level.disable_super_in_turret._id_12979 = scripts\engine\utility::array_remove(level.disable_super_in_turret._id_12979, var_1._id_12978);
}

search(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getdvarint("_encstr_84C815D3F80509539B608B819F4667CB43E02B194BE37F", 240);
  var_6 = adjust_angles_for_heli_path(var_0, var_1, var_5, var_3);
  var_7 = undefined;
  var_8 = spawnStruct();
  var_8 = var_1 rocket_missile(var_0);

  if(isDefined(var_3) && isDefined(var_3._id_12395)) {
    var_9 = [[var_3._id_12395]](var_1, var_3);

    if(isDefined(var_9)) {
      var_8._id_12C4A = var_9;
      var_7 = var_9._id_12978;
    }
  }

  if(!isDefined(var_4))
    var_4 = var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::requestquestlocale("_encstr_92A70BB9C21360A81DA37B69CD", var_8, var_2);

  if(!isDefined(var_4) || !istrue(var_4.enabled)) {
    var_6.result = "_encstr_A6270A37B7BED87B8D2C36AC";
    var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(var_1.team);
  } else {
    if(isDefined(var_4.get_closest_living_player_not_in_laststand))
      var_3.stadium_three_death_func = var_4.get_closest_living_player_not_in_laststand.flagmodel;

    var_4._id_12978 = var_7;
    var_4.squadindex = var_1.squadindex;
    var_4 get_combat_alias();
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance(var_0, var_6);
  }
}

rocket_missile(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_2._id_12FA3 = "_encstr_9A17115CD55637E80AB7B473E8B9509393B097";
  var_2._id_12F9F = (var_1.origin[0], var_1.origin[1], 0);
  var_2._id_12FA6 = getdvarfloat("_encstr_8EE91D83DA2348F04287170BB061302D17A31968A1F79FD8D1821B09C1D3E8", 7500);
  var_2._id_12FA7 = 0;
  var_2._id_12FA4 = getdvarfloat("_encstr_A11723E66C39BE4C397D1B8583AF9B59854E1BD07D4B46565863AFB50B87AF275819A5BAB9", 5000);
  var_2._id_12FA5 = getdvarfloat("_encstr_8F75238231C8077276F7CFBFD1882B7508BB3ECC2EF8C4DAC7B93787CBC811BAA001341343", 2500);
  var_2._id_1297F = 7;
  var_2.mintime = getdvarfloat("_encstr_B84A1E676F9E51C2087E56DE7389190BFDA7E35FD74FEBAC68E3CFA9EB4B5D42", 30);
  var_2._id_12FA1 = 1;
  var_2._id_12C4A = var_1._id_12C4A;

  if(playlinkfx(var_0)) {
    if(var_2._id_12FA6 < level._id_12965)
      var_2._id_12FA6 = level._id_12965;

    var_2._id_12FA4 = level._id_12965;
    var_2._id_12FA5 = level._id_12966;
  }

  if(istrue(var_1._id_11FF8)) {
    var_2._id_12FA3 = "_encstr_AD1C182B5B6D903511A7F3F5E30BE7C01236526708E450677ABB";
    var_2._id_1407E = 1;
  }

  var_3 = getdvarint("_encstr_8220171FB0AB5FB2FB5813D3CD9BCB3B33C027CBBE68CBE0A3", -1);
  var_4 = getdvarint("_encstr_A52017CF512311B658464BF3575B9D6E739BC948CBC1ED5962", -1);

  if(var_3 >= 0)
    var_2._id_12FA5 = var_3;

  if(var_4 >= 0)
    var_2._id_12FA4 = var_4;

  return var_2;
}

usageloop() {
  var_0 = revivent_watchfordeath_safety(game["_encstr_991C0AB9ED5B57161FE89B83"]);

  foreach(var_2 in var_0) {
    if(isDefined(level.questinfo.quests[var_2].instances[game["_encstr_991C0AB9ED5B57161FE89B83"]]))
      return 1;
  }

  var_4 = revivent_watchfordeath_safety(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  foreach(var_2 in var_4) {
    if(isDefined(level.questinfo.quests[var_2].instances[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]))
      return 1;
  }

  return 0;
}

adjust_angles_for_heli_path(var_0, var_1, var_2, var_3) {
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance(var_0, var_1.team, "_encstr_B40101", var_3, var_1.squadindex);
  var_4.squadindex = var_1.squadindex;
  var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(var_1.team, var_1);
  var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(var_1);
  var_4.team = var_1.team;
  var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(var_2, 4);
  return var_4;
}

_id_1336D(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam(var_0, var_3.team);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879(var_0, var_3, var_3.team);
  }

  var_5 = spawnStruct();
  var_5.excludedplayers = [];

  foreach(var_3 in var_1) {
    var_5.excludedplayers[0] = var_3;
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_3, "_encstr_A1413013E4BEB185079B34BDBDD1D717572B9B47FA6EE8B0931DEB47C2C4D8B2D1F5995ACD3259277DB9ED388DBACD23B29C", var_5);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_3.team, "_encstr_BD0A278D3A91588FFB0320C8EAC3A870B3853729EF4228C7AB0BDE93526F79490D17B9E16D6DF01D43", var_5);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_3.team, var_3, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex(var_0));
    var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_3.team, var_3.squadindex);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8A77125E350A01AB8157703147DB834B021AC555", 1, var_7);
  }
}

_id_13742(var_0) {
  if(isDefined(self.get_closest_living_player_not_in_laststand)) {
    foreach(var_2 in var_0)
    self.get_closest_living_player_not_in_laststand scripts\mp\gameobjects::squadallowuse(var_2.team, var_2.squadindex);
  }
}

get_combat_alias() {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }
  objective_showtoplayersinmask(self.get_closest_living_player_not_in_laststand.objidnum);
  objective_removeallfrommask(self.get_closest_living_player_not_in_laststand.objidnum);

  foreach(var_1 in self.subscribedinstances) {
    foreach(var_3 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1.team, var_1.squadindex)) {
      if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
        objective_addclienttomask(self.get_closest_living_player_not_in_laststand.objidnum, var_3);
    }
  }
}

get_closest_munitions(var_0) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }
  objective_removeclientfrommask(self.get_closest_living_player_not_in_laststand.objidnum, var_0);
}

get_closest_visible_drone(var_0) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }
  objective_addclienttomask(self.get_closest_living_player_not_in_laststand.objidnum, var_0);
}

get_combat_station_next_combat_action() {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  waittillframeend;
  get_combat_alias();
}

last_vampire_feedback() {
  foreach(var_1 in self.get_closest_living_player_not_in_laststand.visuals)
  var_1 delete();

  if(isDefined(self.get_closest_living_player_not_in_laststand.flagmodel))
    self.get_closest_living_player_not_in_laststand.flagmodel delete();

  if(isDefined(self.get_closest_living_player_not_in_laststand.scriptable))
    self.get_closest_living_player_not_in_laststand.scriptable delete();

  if(isDefined(self.get_closest_living_player_not_in_laststand.trigger)) {
    self.get_closest_living_player_not_in_laststand.trigger delete();
    self.get_closest_living_player_not_in_laststand.trigger = undefined;
  }

  self.get_closest_living_player_not_in_laststand thread gameobjectreleaseid_delayed();
  self.get_closest_living_player_not_in_laststand notify("_encstr_8BE208E31FA8E1631D65");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

_id_1322D() {
  if(isDefined(level.debugpayloadobjectivesstart_infil)) {
    return;
  }
  level.disableinitplayergameobjects = 0;
  level.debugpayloadobjectivesstart_infil = 120;
  level.iconneutral = "_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992";
  level.iconcapture = "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6";
  level.icondefend = "_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E";
  level.icondefending = "_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9";
  level.iconcontested = "_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B";
  level.icontaking = "_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA";
  level.iconlosing = "_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39";
  level.squadspawndebug = "_encstr_8C1211AFCFB0E25F40D9B0FA3098A6FBAF7F43";
  ammobox_checkclearbufferedattachmentweapon("_encstr_8B99155A36DB9BD7DDC2970E7B2DE63AAF19BDB5FA2693", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  ammobox_checkclearbufferedattachmentweapon("_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_A2D015BBB0BCC1DB5AE647D713C6DBD8B6B4DC3BD789E4", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_966014DF178A63454BE0CB7168A9BDD7208D547F3EB3", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  ammobox_checkclearbufferedattachmentweapon("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  ammobox_checkclearbufferedattachmentweapon("_encstr_81A5177FCBC012AFA3D063D9B988FF81C0B3F2F76B101153D6", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_8C4418A5D8BDCDF5DD58CB387BA5E647BED12C39D9CAA3FA9839", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
  ammobox_checkclearbufferedattachmentweapon("_encstr_8C1211AFCFB0E25F40D9B0FA3098A6FBAF7F43", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_BAEC2251A887D49DD7187931D1FDA5CC374FC85EDADF5C614F300119F885F766A789CFAE", 0);
}

ammobox_checkclearbufferedattachmentweapon(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_B679245D2DF5B507D7319CFA6BB0E0DAACCDEAEBB41BDBE6EB46F6ADEBB74C4D591B1DB4EC2B";
  level.waypointpulses[var_0] = var_3;
}

get_closest_unclaimed_destination(var_0, var_1, var_2, var_3) {
  if(var_1 < 1.0 && !level.gameended)
    _id_12427(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

get_closest_origin_index(var_0) {
  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;

    if(isDefined(self.traincar)) {
      if(isDefined(level._id_145F1) && istrue(level._id_145F1.get_closest_destination)) {
        var_1 = self.traincar.get_closest_attackable_player + (200, 0, 0);
        var_2 = self.traincar.origin + rotatevector(var_1, self.traincar.angles);
        level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_2, "_encstr_8218041DF5FA", 3);
      }
    } else
      level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.curorigin, "_encstr_8218041DF5FA");

    foreach(var_4 in level.players) {
      if(isDefined(var_4) && isalive(var_4) && (var_4.team != var_0.team || var_4.squadindex != var_0.squadindex))
        var_4 thread scripts\mp\hud_message::showsplash("_encstr_A3E4185AC001FA370B43D0A8FF15C15B2DA9D6EB01787812EAD9");
    }

    var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

    foreach(var_8 in var_6)
    var_8 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

get_closest_spawns(var_0) {
  foreach(var_2 in self.locale.subscribedinstances) {
    var_3 = var_2.team;

    if(var_3 == var_0.team) {
      var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(var_0.team);
      var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex(var_2.questcategory);
      var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype(var_2.questcategory));
      var_7 = spawnStruct();
      var_7._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_5, var_4, var_6);
      self.squadindex = var_2.squadindex;
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_3, "_encstr_A68A25C49CAF6CC20EE60DDB7BD1EBB8BA566E8EFA1BF6B538B1CA8E56BE73F6E0C6BADC8C5693", var_7);
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_3, var_0, 8, var_5);
      var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BDF2124A9048531A8057ECFF6FC8E50BE149B352", 1, var_8, 0, 1);
      var_2._id_12D2E = self.flagmodel.origin;
      var_2._id_12D2B = self.flagmodel.angles;
      var_2.result = "_encstr_88E30897BDF1B71F7823";

      if(isDefined(self.assisttouchlist)) {
        if(isDefined(self.assisttouchlist[var_3])) {
          var_9 = getarraykeys(self.assisttouchlist[var_3]);

          foreach(var_11 in var_9) {
            var_12 = self.assisttouchlist[var_3][var_11].player;

            if(isDefined(var_12.owner))
              var_12 = var_12.owner;

            if(!isPlayer(var_12)) {
              continue;
            }
            var_12 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_8B9D3B6B7256A342777CCD05D6333A577958878330C90CDA1F8E973E48C5C13F21D83F4748204602C7AC1D72B89F6BFD8BF8F3EF105E858AB73EE42D18", 1);
            var_12 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A3F63F9161A993101E0F81DA3B4FDA7666C710635C780B65F0E0DB0FDF8037B708927F07CB4BB4F5A954554BA66880FDDA07E47BABDEA062FACBB928EDAF4848BA", 1);
            var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(var_12);
          }
        }
      }

      continue;
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_3, "_encstr_8A6F1A31E4F5C685E06E437B7B1DD7E2AEACE6A3F5660BA58D5739AC", undefined, var_2.squadindex);
    var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_3, var_2.squadindex);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A6C60ED8EDB9E8C9B08DD1AF33C2D236", 1, var_8);
    var_2.result = "_encstr_BD79059C51C351";
  }

  self.locale thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

get_closest_player_dist(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

_id_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

get_closest_valid_player(var_0, var_1, var_2) {
  switch (var_1) {
    case "_encstr_B85C0AD87B9B8E95CD8E2B46":
    case "_encstr_A7C5056BD931D1":
    case "_encstr_BA19049F4B2D":
      return 0;
    default:
      var_1 = "_encstr_8F7106EACDD273CE";

      if(isDefined(var_2))
        var_1 = var_1 + var_2;

      self.scriptable setscriptablepartstate(var_0, var_1);

      if(var_0 == "_encstr_8A0C06B1E08832D3")
        self.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", var_1);

      return 1;
  }
}

get_combat_action(var_0) {
  var_1 = var_0.team;

  foreach(var_3 in self.locale.subscribedinstances) {
    if(isDefined(var_3)) {
      if(var_3.team == var_1)
        return 1;
    }
  }

  return 0;
}

get_closest_available_player_new() {
  if(isDefined(self._id_1393B.get_closest_living_player_not_in_laststand.numtouching)) {
    while(self._id_1393B.get_closest_living_player_not_in_laststand.numtouching[self.id])
      waitframe();
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_BA38205DFBA9FF7BE722F8873FA1294BC5F8EB11876B0A12B08B593040EAB00AF769");
  var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A6C60ED8EDB9E8C9B08DD1AF33C2D236", 1, var_0);
}

playlinkfx(var_0) {
  var_1 = 0;
  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_88AB1A158BDF6B1548D18F7F35459A290B27CFEAE26BB0DBB00ABD20", var_0);

  if(isDefined(var_2))
    return var_2;

  var_3 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_3) {
    case "_encstr_87A205AF50D049":
    case "_encstr_9B1F05BE4B9B52":
    case "_encstr_8AE1099A0B999F2D28AF15":
    case "_encstr_BE180419DAE9":
      var_1 = 1;
      break;
  }

  return var_1;
}