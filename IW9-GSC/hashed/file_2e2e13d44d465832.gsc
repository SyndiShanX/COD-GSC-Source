/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2e2e13d44d465832.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  _id_79D4B1C751A51F03::_id_AD4172A44F169CB6();
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_60616E75BE26B24F, _id_79D4B1C751A51F03::_id_F14F2CD0267B6AB7());
}

_id_60616E75BE26B24F(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_129F1EF2E5686F84;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_65FCEECCC5C94E3D;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_59AE2A3ABCF5622F;
  _id_B8EBE3F71A08AB40.ref = "dmz_destroy_sam";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_C327ADFAD89EFC23 = node;

  if(!isDefined(level._id_264BFA04D0BEF161))
    level._id_264BFA04D0BEF161 = 0;

  _id_B8EBE3F71A08AB40._id_6CD05F946A7917F7 = "samMission" + level._id_264BFA04D0BEF161;
  level._id_264BFA04D0BEF161++;
  return _id_B8EBE3F71A08AB40;
}

_id_129F1EF2E5686F84() {
  self.teams = [];
  self._id_C327ADFAD89EFC23._id_B8EBE3F71A08AB40 = self;
  self.curorigin = self._id_C327ADFAD89EFC23.origin;
  self.offset3d = (0, 0, 100);
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_map_icon_obj_bomb_collect");
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 4);
  objective_setbackground(self.objidnum, 1);
  objective_addalltomask(self.objidnum);
  objective_hidefromplayersinmask(self.objidnum);
  _id_93383F767581B397 = randomintrange(level._id_D57C61FE001F1707._id_4BB2FF3E6E82C373, level._id_D57C61FE001F1707._id_FFB94540411249A9 + 1);
  thread _id_49C1DA07D69B6895(_id_93383F767581B397);
  self.initialized = 1;
  self notify("task_initialized");
}

_id_65FCEECCC5C94E3D(_id_FABF84450735DD93) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");
}

_id_59AE2A3ABCF5622F(_id_FABF84450735DD93) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");

  self._id_C327ADFAD89EFC23 thread _id_D67C0C4B6154B087();
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_assigned", _id_FABF84450735DD93, 5.0);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);
  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_destroy_sam_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

_id_930BC6DC39F516DB(_id_FABF84450735DD93) {
  self notify("end_task");
  players = scripts\common\utility::_id_2D7FD59D039FA69B(self._id_C327ADFAD89EFC23.origin, level._id_D57C61FE001F1707._id_176BB2898F619E87, 1);

  foreach(player in players)
  scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);

  _id_6C4E8CEA70BF4B6D::_id_D062142F367ED7B2();
  wait 2.5;
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_49C1DA07D69B6895(numagents) {
  self.numagents = 0;
  self.agents = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "overwatch");
    _id_0FB30E2E6ACA1D19 = randomfloatrange(144, 360);
    forward = anglesToForward(self._id_C327ADFAD89EFC23.angles) * _id_0FB30E2E6ACA1D19;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / numagents * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = self._id_C327ADFAD89EFC23.origin + offset;

    if(issubstr(aitype, "sniper") && isDefined(self._id_C327ADFAD89EFC23._id_594D7B859FDB06F7) && self._id_C327ADFAD89EFC23._id_594D7B859FDB06F7.size > 0) {
      node = scripts\engine\utility::random(self._id_C327ADFAD89EFC23._id_594D7B859FDB06F7);
      self._id_C327ADFAD89EFC23._id_594D7B859FDB06F7 = scripts\engine\utility::array_remove(self._id_C327ADFAD89EFC23._id_594D7B859FDB06F7, node);
      origin = node.origin;
      _id_CB88E484EB1A3A92 = node.angles;
    }

    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_CB88E484EB1A3A92, "medium", "mission", "samInitialGuards", undefined, undefined, undefined, self._id_B205D90302DA2F07);

    if(isDefined(agent)) {
      self.agents[_id_AC0E594AC96AA3A8] = agent;
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    }
  }

  if(isDefined(self.agents)) {
    foreach(agent in self.agents)
    thread _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "assignment", self._id_6CD05F946A7917F7);
  }

  self.numagents = self.agents.size;
}

_id_33B12655DEB4B72A(time) {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_defused");
  self.plantedbomb thread playtickingsound();
  starttime = gettime();
  self.timeremaining = level._id_D57C61FE001F1707._id_5B4471E9EFDE87C3;

  for(;;) {
    currenttime = gettime();
    duration = (currenttime - starttime) / 1000;
    _id_0DE2C2A1FD468B5F = 1 - duration / level._id_D57C61FE001F1707._id_5B4471E9EFDE87C3;
    progress = clamp(_id_0DE2C2A1FD468B5F, 0, 1);
    objective_setprogress(self._id_B8EBE3F71A08AB40.objidnum, progress);
    self.timeremaining = level._id_D57C61FE001F1707._id_5B4471E9EFDE87C3 - duration;

    if(_id_0DE2C2A1FD468B5F <= 0) {
      self notify("bomb_exploded");
      break;
    }

    waitframe();
  }

  foreach(team in self._id_B8EBE3F71A08AB40.teams)
  objective_hideprogressforteam(self._id_B8EBE3F71A08AB40.objidnum, team);

  if(isDefined(self.plantedbomb)) {
    _id_CB89120314447D62 = randomfloat(360);
    effect = "samsite_bomb_explosion";
    _id_408F3E834E201526 = self.plantedbomb.origin + (0, 0, 50);
    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[effect], _id_408F3E834E201526, (0, 0, 1), (cos(_id_CB89120314447D62), sin(_id_CB89120314447D62), 0));
    triggerfx(_id_EFDFC6EBE7A152C5);
    physicsexplosionsphere(_id_408F3E834E201526, 200, 100, 3);
    playrumbleonposition("grenade_rumble", self.plantedbomb.origin);
    earthquake(0.75, 2.0, self.plantedbomb.origin, 2000);
    playsoundatpos(_id_408F3E834E201526, "exp_bombsite_lr");
    self.plantedbomb._id_DBCE45A33308630D delete();
    self.plantedbomb delete();
  }

  self radiusdamage(self.origin + (0, 0, 50), 2750, 500, 10, self, "MOD_EXPLOSIVE", "bomb_site_mp");
  wait 0.1;
  self.health = 0;
  self setscriptablepartstate("base", "destroyed");
  thread scripts\engine\utility::play_loopsound_in_space("dst_sam_site_fire_lp", self.origin);

  foreach(missile in [self._id_692FC766D262881A, self._id_692FC666D26285E7, self._id_692FC566D26283B4]) {
    if(isDefined(missile) && !istrue(missile._id_DA169210CED21C6B)) {
      if(isDefined(level._effect["c4_explosion_convoy"]))
        playFX(level._effect["c4_explosion_convoy"], missile.origin);

      missile delete();
      waitframe();
    }
  }

  if(isDefined(self.soundent))
    self.soundent delete();

  if(isDefined(self._id_DBCE45A33308630D))
    self._id_DBCE45A33308630D delete();

  team = self._id_06036CD81FE22627.team;

  if(isDefined(team)) {
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_exploded", team, 1.5);
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_destroy_sam_exploded", team);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_win", 1.5);
  }

  self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(team, level._id_D57C61FE001F1707._id_9D1194F2136A106D);
  self._id_B8EBE3F71A08AB40 thread _id_930BC6DC39F516DB(team);
  waitframe();
  self._id_B8EBE3F71A08AB40._id_F8B5193E311E09F4 = spawn("script_model", self.origin);
  self._id_B8EBE3F71A08AB40._id_F8B5193E311E09F4.angles = self.angles;
  self._id_B8EBE3F71A08AB40._id_F8B5193E311E09F4 setModel("military_samsite_01_damaged_rig_skeleton_mp");
  self._id_B8EBE3F71A08AB40._id_F8B5193E311E09F4 setscriptablepartstate("base", "destroyed");
  self notify("samsite_dead", self._id_06036CD81FE22627);
  wait 10;
  self delete();
}

_id_D67C0C4B6154B087() {
  self._id_DBCE45A33308630D = spawn("script_model", self.origin + rotatevector((0, 0, 20), self.angles));
  self._id_DBCE45A33308630D setModel("tag_origin");
  self._id_DBCE45A33308630D setHintString(&"MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_SAMSITE_PLANT_HINT");
  self._id_DBCE45A33308630D sethinticon("hud_icon_c4_plant");
  self._id_DBCE45A33308630D sethintdisplayrange(512);
  self._id_DBCE45A33308630D setuserange(level._id_D57C61FE001F1707._id_A6B9F010E336100B);
  self._id_DBCE45A33308630D setCursorHint("HINT_BUTTON");
  self._id_DBCE45A33308630D sethintdisplayfov(65);
  self._id_DBCE45A33308630D sethintonobstruction("show");
  self._id_DBCE45A33308630D sethintrequiresholding(1);
  self._id_DBCE45A33308630D setuseholdduration("duration_short");

  for(;;) {
    if(_id_6FA1EF232E896897()) {
      break;
    }
  }

  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_planted", self._id_06036CD81FE22627.team);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self._id_06036CD81FE22627.team, "dmz_activity_action", 0.0, "dmz_activity_action_classic");
  self setscriptablepartstate("base", "attacked");
  self.icon setscriptablepartstate("icon", "attacked");
  objective_setpinned(self._id_B8EBE3F71A08AB40.objidnum, 1);
  objective_position(self._id_B8EBE3F71A08AB40.objidnum, self.plantedbomb.origin + (0, 0, 50));
  objective_removeallfrommask(self._id_B8EBE3F71A08AB40.objidnum);
  objective_showtoplayersinmask(self._id_B8EBE3F71A08AB40.objidnum);
  self.plantedbomb._id_DBCE45A33308630D = spawn("script_model", self.plantedbomb.origin + rotatevector((0, 0, 20), self.plantedbomb.angles));
  self.plantedbomb._id_DBCE45A33308630D setModel("tag_origin");
  self.plantedbomb._id_DBCE45A33308630D setHintString(&"MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_SAMSITE_DEFUSE_HINT");
  self.plantedbomb._id_DBCE45A33308630D sethinticon("hud_icon_c4_plant");
  self.plantedbomb._id_DBCE45A33308630D sethintdisplayrange(512);
  self.plantedbomb._id_DBCE45A33308630D setuserange(120);
  self.plantedbomb._id_DBCE45A33308630D setCursorHint("HINT_BUTTON");
  self.plantedbomb._id_DBCE45A33308630D sethintdisplayfov(65);
  self.plantedbomb._id_DBCE45A33308630D sethintonobstruction("show");
  self.plantedbomb._id_DBCE45A33308630D sethintrequiresholding(1);
  self.plantedbomb._id_DBCE45A33308630D setuseholdduration("duration_short");
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_06036CD81FE22627.team, "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  self.plantedbomb._id_DBCE45A33308630D disableplayeruse(player);

  thread _id_33B12655DEB4B72A(level._id_D57C61FE001F1707._id_5B4471E9EFDE87C3);
  thread _id_1839A40E099BB63F();
  thread _id_F2B5581EAAB77646();
  _id_7408ED52662703D3 = level._id_B205D90302DA2F07[self._id_B205D90302DA2F07]["players"];
  _id_7408ED52662703D3 = scripts\engine\utility::array_remove_array(_id_7408ED52662703D3, scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players"));
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_destroy_sam_invited", _id_7408ED52662703D3);
  thread _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("destroy_sam_invite", _id_7408ED52662703D3, 2.0);

  foreach(_id_BCC7FEC8B738D541 in self._id_B8EBE3F71A08AB40.agents)
  thread _id_120270BD0A747A35::_id_A5117518725DA028(_id_BCC7FEC8B738D541, self.plantedbomb.origin);

  self._id_7B45AAAC74192C14 = _id_48814951E916AF89::_id_353FECD1549F5F42(self.plantedbomb.origin, level._id_D57C61FE001F1707._id_D0F63034F54017E3);

  if(self._id_7B45AAAC74192C14.size < 5)
    thread _id_844DFE93476D59AB();
}

_id_1839A40E099BB63F() {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_exploded");

  for(;;) {
    if(_id_29CBBCBD8B278CF8()) {
      break;
    }
  }

  self notify("bomb_defused");
  self.plantedbomb._id_DBCE45A33308630D delete();
  self.plantedbomb delete();
  self setscriptablepartstate("base", "healthy");
  self.icon setscriptablepartstate("icon", "healthy");
  _id_03060D27FFB03AD2 = self._id_285292A6695A1FCA.team;
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_invite_win", _id_03060D27FFB03AD2, 1.5);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_destroy_sam_defused_win", _id_03060D27FFB03AD2);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_03060D27FFB03AD2, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  _id_379D6BAD84E53438 = self._id_06036CD81FE22627.team;
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_defused", _id_379D6BAD84E53438, 1.5);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_destroy_sam_defused_lose", _id_379D6BAD84E53438);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_379D6BAD84E53438, "dmz_activity_lose", 1.0, "dmz_activity_lose_classic");
  self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_03060D27FFB03AD2, level._id_D57C61FE001F1707._id_C5651897AC91F7AC);
  self._id_B8EBE3F71A08AB40 thread _id_930BC6DC39F516DB(undefined);
}

_id_6FA1EF232E896897() {
  self._id_DBCE45A33308630D makeusable();
  self._id_DBCE45A33308630D disableplayeruseforallplayers();
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  self._id_DBCE45A33308630D enableplayeruse(player);

  self._id_DBCE45A33308630D waittill("trigger", player);
  self._id_DBCE45A33308630D makeunusable();

  if(isDefined(self._id_8E977040CC228632) && istrue(self._id_8E977040CC228632))
    return 0;

  self._id_8E977040CC228632 = 1;
  bomb = _id_CADC5181C3B67E3F(player);
  thread _id_C01611FBD560866E(player);
  _id_8B07FA3892A3A8A4 = 0;

  while(_id_8B07FA3892A3A8A4 < level._id_D57C61FE001F1707.planttime) {
    if(self._id_A4CF15C49F3E9EEF || !isalive(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
      self._id_8E977040CC228632 = 0;
      _id_0DB896F4486CA187(player, bomb);
      return 0;
    }

    _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
    waitframe();
  }

  _id_0DB896F4486CA187(player, bomb);
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
  self.plantedbomb = _id_EEB138FAE3842A92;
  self._id_B8EBE3F71A08AB40.bombplanted = 1;
  self._id_06036CD81FE22627 = player;
  self._id_B8EBE3F71A08AB40 notify("bomb_planted");
  return 1;
}

_id_29CBBCBD8B278CF8(player) {
  self.plantedbomb._id_DBCE45A33308630D makeusable();
  self.plantedbomb._id_DBCE45A33308630D enableplayeruseforallplayers();
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  self.plantedbomb._id_DBCE45A33308630D disableplayeruse(player);

  self.plantedbomb._id_DBCE45A33308630D waittill("trigger", player);
  self.plantedbomb._id_DBCE45A33308630D makeunusable();

  if(isDefined(self._id_482C2428A4E2FDDC) && istrue(self._id_482C2428A4E2FDDC))
    return 0;

  if(isDefined(self.timeremaining) && self.timeremaining < level._id_D57C61FE001F1707.defusetime)
    return 0;

  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_defusing", self._id_06036CD81FE22627.team);
  self._id_482C2428A4E2FDDC = 1;
  self.plantedbomb hide();
  bomb = _id_CADC5181C3B67E3F(player);
  thread _id_C01611FBD560866E(player);
  _id_8B07FA3892A3A8A4 = 0;

  while(_id_8B07FA3892A3A8A4 < level._id_D57C61FE001F1707.defusetime) {
    if(self._id_A4CF15C49F3E9EEF || !isalive(player) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1 || self.timeremaining < level._id_D57C61FE001F1707.defusetime - _id_8B07FA3892A3A8A4) {
      self._id_482C2428A4E2FDDC = 0;
      _id_0DB896F4486CA187(player, bomb);
      self.plantedbomb show();
      return 0;
    }

    _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
    waitframe();
  }

  _id_0DB896F4486CA187(player, bomb);
  self._id_285292A6695A1FCA = player;
  self._id_B8EBE3F71A08AB40.bombdefused = 1;
  self._id_B8EBE3F71A08AB40 notify("bomb_defused");
  return 1;
}

_id_F2B5581EAAB77646() {
  self._id_B8EBE3F71A08AB40 endon("bomb_defused");
  self endon("bomb_exploded");
  objective_setplayintro(self._id_B8EBE3F71A08AB40.objidnum, 0);
  objective_removeallfrommask(self._id_B8EBE3F71A08AB40.objidnum);
  objective_showtoplayersinmask(self._id_B8EBE3F71A08AB40.objidnum);
  waitframe();
  objective_setplayintro(self._id_B8EBE3F71A08AB40.objidnum, 1);
  _id_F225C15DCA10FD0D = 0;

  for(;;) {
    _id_7408ED52662703D3 = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, level._id_D57C61FE001F1707._id_176BB2898F619E87, 1);
    objective_removeallfrommask(self._id_B8EBE3F71A08AB40.objidnum);

    foreach(player in _id_7408ED52662703D3) {
      objective_addclienttomask(self._id_B8EBE3F71A08AB40.objidnum, player);
      objective_showprogressforclient(self._id_B8EBE3F71A08AB40.objidnum, player);
      _func_8B71EB96E1636EDC("MP_DMZ_MISSIONS/DMZ_DESTROY_SAM_PROGRESS_TEXT", player);
      _func_D1B64C3D055CEEB0(2, player);

      if(!_id_F225C15DCA10FD0D) {
        if(player.team != self._id_06036CD81FE22627.team) {
          _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_hostiles", self._id_06036CD81FE22627.team);
          _id_F225C15DCA10FD0D = 1;
        }
      }
    }

    objective_showtoplayersinmask(self._id_B8EBE3F71A08AB40.objidnum);
    wait 1.0;
  }
}

_id_C01611FBD560866E(player) {
  self._id_B8EBE3F71A08AB40 endon("bomb_planted");
  self._id_B8EBE3F71A08AB40 endon("bomb_defused");
  player notifyonplayercommand("cancel", "+weapnext");
  self._id_A4CF15C49F3E9EEF = 0;
  player waittill("cancel");
  self._id_A4CF15C49F3E9EEF = 1;
  player notifyonplayercommandremove("cancel", "+weapnext");
}

_id_CADC5181C3B67E3F(player) {
  player _id_BF9EC93BEE75F88C(0);
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1);
  return bomb;
}

_id_0DB896F4486CA187(player, bomb) {
  lastweaponobj = player scripts\mp\utility\inventory::getlastweapon();

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
  else if(!player hasweapon(lastweaponobj))
    lastweaponobj = player scripts\mp\utility\inventory::getfirstprimaryweapon();

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 0);
  player takeweapon(bomb);
  player _id_BF9EC93BEE75F88C(1);
}

_id_844DFE93476D59AB() {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_exploded");
  agents = undefined;

  while(!isDefined(agents)) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.origin, "medium", "mission", "samReinforcements", undefined, undefined, 1, self._id_B205D90302DA2F07);

    if(!isDefined(agents))
      wait 1.0;
  }
}

_id_BF9EC93BEE75F88C(_id_BD138DE99B3B3507) {
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_movement", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "sprint", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "fire", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "reload", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_pickup", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_switch", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "gesture", _id_BD138DE99B3B3507);
  self _meth_35501B42058D4DE9();

  if(_id_BD138DE99B3B3507)
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");

  _id_3B64EB40368C1450::set("sam_holding_bomb", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "mantle", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "offhand_weapons", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sam_holding_bomb");
    self _meth_BB04491D50D9E43E();
  }
}

playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  time = level._id_D57C61FE001F1707._id_5B4471E9EFDE87C3;
  _id_8AA881DB64E772E5 = 45;
  _id_A46637C818D15DBF = 10;
  _id_F139DBCFCE7A127D = 2;

  for(;;) {
    if(time > _id_8AA881DB64E772E5) {
      scripts\mp\utility\sound::play_sound_on_entity("mp_iw9_dmz_sam_bomb_timer");
      time = time - 1;
      wait 1;
    } else if(time > _id_A46637C818D15DBF) {
      scripts\mp\utility\sound::play_sound_on_entity("mp_iw9_dmz_sam_bomb_timer_urgent");
      time = time - 1;
      wait 1;
    } else if(time > _id_F139DBCFCE7A127D) {
      scripts\mp\utility\sound::play_sound_on_entity("mp_iw9_dmz_sam_bomb_timer_finish_beep");
      time = time - 0.5;
      wait 0.5;
    } else {
      scripts\mp\utility\sound::play_sound_on_entity("mp_iw9_dmz_sam_bomb_timer_last_second");
      time = time - 0.25;
      wait 0.25;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_C373F127DAFC389A(team) {
  self endon("end_task");
  _id_27483A41D2410CC8 = 9000000;
  _id_B485E3529246A8DE = 90000;
  _id_44937005A0F57F50 = 0;

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_4F0FC1C36324AFFB = 10000000000;
    _id_0FA73C7E2D99FA15 = (0, 0, 0);

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      distsq = distance2dsquared(self._id_C327ADFAD89EFC23.origin, player.origin);

      if(_id_4F0FC1C36324AFFB > distsq) {
        _id_4F0FC1C36324AFFB = distsq;
        _id_0FA73C7E2D99FA15 = player.origin;
      }
    }

    if(!_id_44937005A0F57F50 && _id_4F0FC1C36324AFFB < _id_27483A41D2410CC8) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_near", team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
      _id_44937005A0F57F50 = 1;
    }

    if(_id_4F0FC1C36324AFFB < _id_B485E3529246A8DE) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("destroy_sam_approach", team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
      return;
    }

    wait 1.0;
  }
}