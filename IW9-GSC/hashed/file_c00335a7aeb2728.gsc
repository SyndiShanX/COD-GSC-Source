/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_c00335a7aeb2728.gsc
***********************************************/

_id_2EDDEFE4D621123B() {
  if(!isDefined(level._id_963BA76EE083D599)) {
    level._id_24A15C328E009C6D = 1;
    level._id_963BA76EE083D599 = spawnStruct();
    level._id_963BA76EE083D599._id_D0EAD7E588A015C5 = getdvarint("dvar_71EDFFC21985CF3C", 128);
    level._id_963BA76EE083D599.capturetime = getdvarfloat("dvar_44A66B39CCCA38B1", 20.0);
    level._id_963BA76EE083D599._id_34EF5BF2EEBF19EB = getdvarfloat("dvar_0A10F5FB90206DBC", 6.0);
    level._id_963BA76EE083D599.circleradius = getdvarint("dvar_A3F5F94B78758C13", 1000);
    level._id_963BA76EE083D599._id_E3AA1DE9D96E0086 = getdvarint("dvar_D411B19DD9E74816", 250);
    level._id_963BA76EE083D599._id_F39B43569EDB3EB1 = getdvarint("dvar_2AA1EA2E4CB8C3D2", 15000);
    level._id_963BA76EE083D599._id_839E9139EE637B31 = getdvarint("dvar_9291026D90B23401", 0);
    level._id_963BA76EE083D599._id_B820CB1AC6257B4B = getdvarint("dvar_6E810109E7C6B4F2", 128);
    level._id_963BA76EE083D599._id_49E6EAFAF2335643 = getdvarint("dvar_6E6AD32F4DF0A3CD", 0);
  }
}

_id_80D68C9701E1AEA5(data) {
  _id_2EDDEFE4D621123B();
  _id_7828C1AFE3365DD2();
  _id_0FEE1C80AFE3E660 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "dmz_intel_laptop");
  level._id_D8DB1602C8BF473E["dmz_intel_laptop"] = ::_id_E76E3C2AAE1D1BE6;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_upload_station", ::_id_4E64A11D42D9B58A);
  _id_7626533FB4B71334 = scripts\engine\utility::getStructArray("dmz_dom_tower", "script_noteworthy");

  if(getdvarint("dvar_698D4FDC619D5572", 1))
    level._id_437C63BA5BC3452C = _id_7626533FB4B71334;
  else {
    level._id_437C63BA5BC3452C = [];

    foreach(node in _id_7626533FB4B71334) {
      _id_A00489812E5B037F = node._id_B205D90302DA2F07;

      if(!isDefined(_id_A00489812E5B037F))
        _id_A00489812E5B037F = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

      if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913() || isDefined(_id_A00489812E5B037F) && _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_A00489812E5B037F) && !_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin) && !_id_4948CDF739393D2D::_id_F59F68ADC71D49B3(node.origin))
        level._id_437C63BA5BC3452C[level._id_437C63BA5BC3452C.size] = node;
    }
  }

  if(getdvarint("dvar_9D58313058BB5CFD", 1)) {
    foreach(_id_6AD234DBF4573257 in level._id_437C63BA5BC3452C)
    spawnStruct() thread _id_443A192943945265(_id_6AD234DBF4573257, level._id_963BA76EE083D599._id_34EF5BF2EEBF19EB);
  }

  level._id_02C8F684C8DE8EA1 = [];

  foreach(node in _id_0FEE1C80AFE3E660) {
    node setscriptablepartstate("dmz_intel_laptop", "actually_hidden");
    _id_F649B1DA590A1250 = scripts\engine\utility::get_array_of_closest(node.origin, level._id_437C63BA5BC3452C, undefined, undefined, level._id_963BA76EE083D599._id_F39B43569EDB3EB1);

    if(!isDefined(_id_F649B1DA590A1250) || !isDefined(_id_F649B1DA590A1250[0])) {
      continue;
    }
    node._id_6AD234DBF4573257 = _id_F649B1DA590A1250[0];
    level._id_02C8F684C8DE8EA1[level._id_02C8F684C8DE8EA1.size] = node;
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_C2D2A192E013115A, level._id_02C8F684C8DE8EA1);
}

#using_animtree("script_model");

_id_7828C1AFE3365DD2() {
  level.scr_animtree["upload_station_player"] = #animtree;
  level.scr_anim["upload_station_player"]["upload_station_enter"] = % iw9_dmz_uploadstation_enter_sdr;
  level.scr_animname["upload_station_player"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_sdr";
  level.scr_eventanim["upload_station_player"]["upload_station_enter"] = "upload_station_enter";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_sdr";
  level.scr_anim["upload_station_player"]["upload_station_type"] = % iw9_dmz_uploadstation_type_sdr;
  level.scr_animname["upload_station_player"]["upload_station_type"] = "iw9_dmz_uploadstation_type_sdr";
  level.scr_eventanim["upload_station_player"]["upload_station_type"] = "upload_station_type";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_type"] = "iw9_dmz_uploadstation_type_sdr";
  level.scr_anim["upload_station_player"]["upload_station_exit"] = % iw9_dmz_uploadstation_exit_sdr;
  level.scr_animname["upload_station_player"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_sdr";
  level.scr_eventanim["upload_station_player"]["upload_station_exit"] = "upload_station_exit";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_sdr";
  level.scr_anim["upload_station_harddrive"]["upload_station_enter"] = % iw9_dmz_uploadstation_enter_hdd;
  level.scr_animname["upload_station_harddrive"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_hdd";
  level.scr_eventanim["upload_station_harddrive"]["upload_station_enter"] = "upload_station_enter";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_hdd";
  level.scr_anim["upload_station_harddrive"]["upload_station_type"] = % iw9_dmz_uploadstation_type_hdd;
  level.scr_animname["upload_station_harddrive"]["upload_station_type"] = "iw9_dmz_uploadstation_type_hdd";
  level.scr_eventanim["upload_station_harddrive"]["upload_station_type"] = "upload_station_type";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_type"] = "iw9_dmz_uploadstation_type_hdd";
  level.scr_anim["upload_station_harddrive"]["upload_station_exit"] = % iw9_dmz_uploadstation_exit_hdd;
  level.scr_animname["upload_station_harddrive"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_hdd";
  level.scr_eventanim["upload_station_harddrive"]["upload_station_exit"] = "upload_station_exit";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_hdd";
}

_id_C2D2A192E013115A(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_A090FD5DB1D41D09;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_5E492A2AE2C58516;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_0406FED676340E8B;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_4790AB669E14DBCA;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_FE978BB57C108C1E;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_8E8DE0DA459365E9;
  _id_B8EBE3F71A08AB40.ref = "dmz_domination_explore";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;

  if(!isDefined(level._id_5EF55B8E3822F67E))
    level._id_5EF55B8E3822F67E = 0;

  _id_B8EBE3F71A08AB40._id_6CD05F946A7917F7 = "domMission" + level._id_5EF55B8E3822F67E;
  level._id_5EF55B8E3822F67E++;
  return _id_B8EBE3F71A08AB40;
}

_id_A090FD5DB1D41D09() {
  self.item = self.node;
  self.item._id_B8EBE3F71A08AB40 = self;
  self.item setscriptablepartstate("dmz_intel_laptop", "unusable");
  self.item._id_C2FEE681E05824C8 = spawnscriptable("dmz_intel_harddrive", self.item.origin, self.item.angles);
  self.numagents = 0;
  self._id_6AD234DBF4573257 = self.node._id_6AD234DBF4573257;
  self._id_B0F4BF8621B96C0A = [];

  if(!isDefined(self._id_6AD234DBF4573257) || _id_4948CDF739393D2D::_id_F59F68ADC71D49B3(self.item.origin)) {
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  self._id_EFA8EF05B190D7D0.origin = self.item.origin;

  if(istrue(self._id_6AD234DBF4573257._id_AFD4C1E75AEE7F02)) {
    self.domflag = self._id_6AD234DBF4573257.flag;
    self.domflag._id_B7718B6E41108129[self.domflag._id_B7718B6E41108129.size] = self;
  } else
    thread _id_443A192943945265(self._id_6AD234DBF4573257, level._id_963BA76EE083D599._id_34EF5BF2EEBF19EB);

  self._id_7BE8B486A10B3DE8 = 0;
  _id_79B9C85900392AD6 = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self.item.origin, level._id_963BA76EE083D599.circleradius);
  self.circlecenter = _id_79B9C85900392AD6;
  self.circleradius = level._id_963BA76EE083D599.circleradius;
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Explore_Dmz", [_id_79B9C85900392AD6], level._id_963BA76EE083D599.circleradius + level._id_963BA76EE083D599._id_E3AA1DE9D96E0086);
  self.curorigin = _id_79B9C85900392AD6;
  self.offset3d = (0, 0, 50);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(_id_79B9C85900392AD6 + (0, 0, 750), "intel");
}

_id_443A192943945265(node, _id_34EF5BF2EEBF19EB) {
  if(!isDefined(self.domflag))
    self.domflag = spawnscriptable("dmz_upload_station", node.origin, node.angles);

  self.domflag._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin, 1);

  if(isDefined(self._id_EFA8EF05B190D7D0)) {}

  _id_D0EAD7E588A015C5 = _id_9258EDCE111428C2();
  self.domflag.trigger = spawn("trigger_radius", node.origin, 0, int(_id_D0EAD7E588A015C5), int(_id_D0EAD7E588A015C5));

  if(isDefined(self._id_EFA8EF05B190D7D0)) {}

  self.domflag.trigger scripts\engine\utility::trigger_on();
  self.domflag.playersintrigger = [];
  self.domflag thread _id_A93281D34421174F();
  self.domflag._id_34EF5BF2EEBF19EB = _id_34EF5BF2EEBF19EB;
  self.domflag._id_503F03871E7FD1CB = [];
  self.domflag._id_B7718B6E41108129 = [self];
  node._id_AFD4C1E75AEE7F02 = 1;
  node.flag = self.domflag;
  node.trigger = self.domflag.trigger;
}

_id_FE978BB57C108C1E(_id_FABF84450735DD93) {}

_id_0406FED676340E8B(player) {
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);

  if(!istrue(self._id_7BE8B486A10B3DE8)) {
    _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
    self.item enablescriptableplayeruse(player);
  }
}

_id_4790AB669E14DBCA(player) {
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);

  if(!istrue(self._id_7BE8B486A10B3DE8)) {
    _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
    self.item disablescriptableplayeruse(player);
  }
}

_id_5E492A2AE2C58516(_id_FABF84450735DD93) {
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);

  if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("secure_intel_assigned_generic", _id_FABF84450735DD93);
  else
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("secure_intel_assigned", _id_FABF84450735DD93);

  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_dom_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  self.item setscriptablepartstate("dmz_intel_laptop", "usable");
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in level.players)
  self.item disablescriptableplayeruse(player);

  foreach(player in players)
  self.item enablescriptableplayeruse(player);

  if(!isDefined(self._id_624B409E2A419CE6))
    self._id_624B409E2A419CE6 = 1;
}

_id_8E8DE0DA459365E9(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    if(isDefined(self.item))
      self.item disablescriptableplayeruse(player);
  }

  _id_1CA101629B43A466(players);
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_1CA101629B43A466(_id_E2B2BBD9E6539F11) {
  if(isDefined(_id_E2B2BBD9E6539F11)) {
    foreach(player in _id_E2B2BBD9E6539F11)
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
  }

  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  self.domflag setscriptablepartstate("upload_screen", "screen_off");

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_1C9FA9BFB0A2FD44::_id_9D25D9397C798607(self.domflag, self.teams[0]);

  self.domflag._id_B7718B6E41108129 = scripts\engine\utility::array_remove(self.domflag._id_B7718B6E41108129, self);
}

_id_804EB3448706C9BC(_id_FABF84450735DD93) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_1CA101629B43A466(_id_E2B2BBD9E6539F11);
  thread _id_8C550607FB966B6F(_id_FABF84450735DD93, self.domflag.origin);
  _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_upload_complete", "dom", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("secure_intel_win", _id_FABF84450735DD93, 1.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93, 1);
}

_id_E76E3C2AAE1D1BE6(struct, player) {
  instance = struct.instance;

  if(_id_7BF020DC824BDDB7(instance, player)) {
    _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;
    team = _id_B8EBE3F71A08AB40.teams[0];
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_domination");
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_located_intel", team);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_action", 1.5, "dmz_activity_action_classic");
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("secure_intel_found", team);

    if(istrue(level._id_963BA76EE083D599._id_49E6EAFAF2335643))
      _id_B8EBE3F71A08AB40 thread _id_BA861064E674A7CB();

    return 1;
  }

  return 2;
}

_id_7BF020DC824BDDB7(instance, player) {
  _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;

  if(isDefined(_id_B8EBE3F71A08AB40) && isDefined(_id_B8EBE3F71A08AB40.teams) && isDefined(_id_B8EBE3F71A08AB40.teams[0]) && _id_B8EBE3F71A08AB40.teams[0] == player.team) {
    instance setscriptablepartstate("dmz_intel_laptop", "hidden");
    instance._id_C2FEE681E05824C8 setscriptablepartstate("dmz_intel_harddrive", "closing");
    players = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(player in players)
    player setclientomnvar("ui_hard_drive_taken", 1);

    instance._id_C2FEE681E05824C8 thread _id_63863C633BFA3C96();
    level thread _id_2C2A32E879A2BCFD(players);
    team = _id_B8EBE3F71A08AB40.teams[0];
    _id_B8EBE3F71A08AB40 notify("item_found");
    _id_B8EBE3F71A08AB40._id_7BE8B486A10B3DE8 = 1;
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A92867E16C21DA22(team);
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(_id_B8EBE3F71A08AB40.domflag.origin + (0, 0, 75));

    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
    _id_B8EBE3F71A08AB40.domflag enablescriptableplayeruse(player);

    _id_B8EBE3F71A08AB40 thread _id_C63511286DB73AB1();
    return 1;
  }

  return 0;
}

_id_63863C633BFA3C96() {
  level endon("game_ended");
  wait 1.0;
  self freescriptable();
}

_id_2C2A32E879A2BCFD(players) {
  level endon("game_ended");
  wait 1.25;

  foreach(player in players) {
    if(isDefined(player))
      player setclientomnvar("ui_hard_drive_taken", 0);
  }
}

_id_BA861064E674A7CB() {
  level endon("game_ended");
  self endon("task_ended");
  _id_D280B3D2AD13E4DB = 10;
  _id_88CBF247FF1E11B1 = scripts\common\utility::_id_98A826B6B6D0D118(self.domflag.origin + (0, 0, -1000), 2500, undefined, 3000, 0).size;
  _id_5C362DCAAA44CDF0 = [];

  while(_id_88CBF247FF1E11B1 < _id_D280B3D2AD13E4DB) {
    _id_5C362DCAAA44CDF0 = _id_48814951E916AF89::_id_353FECD1549F5F42(self.domflag.origin, 4000, undefined, _id_D280B3D2AD13E4DB - _id_88CBF247FF1E11B1);
    _id_88CBF247FF1E11B1 = _id_88CBF247FF1E11B1 + _id_5C362DCAAA44CDF0.size;

    if(_id_88CBF247FF1E11B1 >= _id_D280B3D2AD13E4DB) {
      return;
    }
    _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.domflag.origin, "high", "mission", "domReinforcements", undefined, undefined, 1, self.node._id_B205D90302DA2F07);
    _id_88CBF247FF1E11B1 = _id_88CBF247FF1E11B1 + 5;
    wait(randomfloatrange(22, 28));
  }
}

_id_C373F127DAFC389A(team, _id_925BE0548554E3A0) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("item_found");
  _id_B820CB1AC6257B4B = _id_7F460FE8D509A260();
  _id_EF6C8282FDE1F7BB = _id_B820CB1AC6257B4B * _id_B820CB1AC6257B4B;
  _id_96477DA1695E035B = _id_133D4B6D206849D8();
  wait 5.0;

  if(isDefined(self.icon))
    objective_setplayintro(self.icon, 0);

  _id_19725AA1E0E97456 = 0;

  for(;;) {
    wait 1.0;
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    objective_showtoplayersinmask(self.icon);
    _id_19725AA1E0E97456 = 0;
    _id_500527A31CE67EA7 = 0.0;

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(istrue(_id_925BE0548554E3A0))
        _id_500527A31CE67EA7 = distance2dsquared(player.origin, _id_96477DA1695E035B.origin);
      else
        _id_500527A31CE67EA7 = distancesquared(player.origin, _id_96477DA1695E035B.origin);

      if(_id_500527A31CE67EA7 < _id_EF6C8282FDE1F7BB) {
        _id_19725AA1E0E97456 = 1;
        break;
      }
    }

    if(_id_19725AA1E0E97456) {
      objective_setplayintro(self.icon, 1);
      objective_position(self.icon, _id_96477DA1695E035B.origin + (0, 0, 10));

      foreach(player in players) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        objective_addclienttomask(self.icon, player);
      }

      continue;
    }

    objective_setplayintro(self.icon, 0);
    objective_position(self.icon, self.circlecenter + (0, 0, 750));

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      _id_8C64FAA69E531014 = distance2dsquared(player.origin, self.circlecenter);

      if(_id_8C64FAA69E531014 <= self.circleradius * self.circleradius) {
        objective_removeclientfrommask(self.icon, player);
        continue;
      }

      objective_addclienttomask(self.icon, player);
    }
  }
}

_id_C63511286DB73AB1() {
  level endon("game_ended");
  self endon("task_ended");
  _id_AE7FBC9B7B67D9B5 = 1000000;

  if(isDefined(level._id_D6AE5CC7B162C730) && isDefined(level._id_D6AE5CC7B162C730._id_30326E6A2F443451))
    _id_AE7FBC9B7B67D9B5 = level._id_D6AE5CC7B162C730._id_30326E6A2F443451;

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

    foreach(player in players) {
      distsq = distance2dsquared(player.origin, self.domflag.origin);

      if(distsq < _id_AE7FBC9B7B67D9B5) {
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("secure_intel_near_uav", players);
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
        return;
      }
    }

    wait 1.0;
  }
}

_id_4E64A11D42D9B58A(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance._id_331EAB03226799E6) || !isDefined(_id_FBA0376E0036DE8D.team) || isDefined(instance._id_503F03871E7FD1CB[_id_FBA0376E0036DE8D.team])) {
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  if(_id_FBA0376E0036DE8D isthrowinggrenade() || _id_FBA0376E0036DE8D isswitchingweapon() || isDefined(_id_FBA0376E0036DE8D getheldoffhand()) && !isnullweapon(_id_FBA0376E0036DE8D getheldoffhand())) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups._id_0859F4BD204F1259))
      _id_FBA0376E0036DE8D[[level.showerrormessagefunc]](level.br_pickups._id_0859F4BD204F1259);

    return;
  }

  _id_0AF8960E78793849 = _id_03314ADD7998AB13::_id_37416C14E9703FB6(_id_FBA0376E0036DE8D);

  if(isDefined(_id_0AF8960E78793849) && istrue(_id_0AF8960E78793849._id_7BE8B486A10B3DE8) && isDefined(instance._id_B7718B6E41108129) && scripts\engine\utility::array_contains(instance._id_B7718B6E41108129, _id_0AF8960E78793849)) {
    thread _id_A22AC2645C342456(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
    return;
  }

  _id_6A435791FDB09966 = istrue(instance scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onUseUploadStation", _id_FBA0376E0036DE8D));

  if(!_id_6A435791FDB09966)
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("DMZ/UPLOAD_STATION_USE_ERR");
}

_id_A22AC2645C342456(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_94F937F05D8740C8(instance, _id_FBA0376E0036DE8D);

  if(istrue(instance._id_B14A331BA425C286)) {
    _id_0AF8960E78793849 = undefined;

    foreach(_id_B8EBE3F71A08AB40 in instance._id_B7718B6E41108129) {
      if(_id_6C4E8CEA70BF4B6D::_id_8158903A6E2F32FD(_id_B8EBE3F71A08AB40, _id_FBA0376E0036DE8D)) {
        _id_0AF8960E78793849 = _id_B8EBE3F71A08AB40;
        break;
      }
    }

    if(isDefined(_id_0AF8960E78793849)) {
      if(scripts\mp\utility\game::getsubgametype() != "dmz") {
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_intel_upload", _id_FBA0376E0036DE8D.team, _id_FBA0376E0036DE8D, 1, undefined, 2);
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_intel_upload_first_person", _id_FBA0376E0036DE8D, 1, undefined, 2);

        if(getdvarint("dvar_91FB20E61355309F", 1) == 1)
          level thread _id_64ACB6CE534155B7::utilflare_shootflare(instance.origin, "dom");

        _id_0AF8960E78793849 thread _id_1C9FA9BFB0A2FD44::_id_9E9A76453CF89412(_id_FBA0376E0036DE8D.team, _id_0AF8960E78793849.domflag, _id_0AF8960E78793849.objidnum);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(_id_0AF8960E78793849.icon, _id_FBA0376E0036DE8D.team);
      }

      _id_0AF8960E78793849 thread _id_66998E5E0034B2BB(_id_0AF8960E78793849.teams[0], _id_0AF8960E78793849.domflag, _id_0AF8960E78793849.icon);
      return;
    }

    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage("DMZ/UPLOAD_STATION_USE_ERR");
    return;
  } else if(scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_1C9FA9BFB0A2FD44::_id_9D25D9397C798607(instance);
}

_id_94F937F05D8740C8(instance, _id_FBA0376E0036DE8D) {
  instance setscriptablepartstate("dmz_upload_station", "unusable");
  instance._id_B14A331BA425C286 = 0;
  instance._id_70FCA006DF7FD865 = _id_FBA0376E0036DE8D;
  instance _id_FB78F1CD45A31B9C(_id_FBA0376E0036DE8D);

  if(isDefined(instance.animstruct) && isDefined(instance.animstruct._id_C2FEE681E05824C8))
    instance.animstruct._id_C2FEE681E05824C8 delete();

  instance._id_70FCA006DF7FD865 = undefined;
  instance setscriptablepartstate("dmz_upload_station", "usable");

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    _id_1C9FA9BFB0A2FD44::_id_9D25D9397C798607(instance, _id_FBA0376E0036DE8D.team);
}

_id_FB78F1CD45A31B9C(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  thread _id_783F84B2AAF11D69(player);
  _id_21BF34FDB6A27D05(player);
  thread _id_A7ADF312E5D321B6(player);
  _id_40CF8163C7E23D93(player);
  _id_5D370C10D291B6A2(player);

  if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player))
    player notify("interact_finished");

  if(isDefined(self.animstruct) && isDefined(self.animstruct._id_C2FEE681E05824C8))
    self.animstruct._id_C2FEE681E05824C8 delete();

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(player)) {
    player notify("remove_rig");

    if(scripts\mp\utility\player::isreallyalive(player))
      player _id_662CBAC61C1AE7E2::_id_680B501EB7141C84(1);
  }
}

_id_21BF34FDB6A27D05(player) {
  player _id_662CBAC61C1AE7E2::_id_680B501EB7141C84(0);
  _id_A66FD1B124C32F51 = player getplayerangles();
  player.linktoent = player scripts\engine\utility::spawn_tag_origin(player.origin, player._id_A66FD1B124C32F51);
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
  _id_9A2E0B6F009D8682 = self.angles + (0, 180, 0);
  goalpos = self.origin + rotatevector((-37, 0.9, 3.5), _id_9A2E0B6F009D8682);
  forward = anglesToForward(_id_9A2E0B6F009D8682);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  _id_8003B0D4F9FBEE0E = axistoangles(forward, right, up);
  _id_57C87883AE437750 = 0.5;
  player.linktoent moveTo(goalpos, _id_57C87883AE437750, 0.1, 0.1);
  player.linktoent rotateTo(_id_8003B0D4F9FBEE0E, _id_57C87883AE437750, 0.1, 0.1);
  player setstance("stand");
  _id_CD9982ADB17761A8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  _id_698CC218E4ADE75F = gettime();
  _id_218F64CB035D54BE = _id_57C87883AE437750 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0;
  waittime = max(0, _id_218F64CB035D54BE);
  wait(waittime);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, undefined, 0.5);
  player setOrigin(goalpos);
  player setplayerangles(_id_8003B0D4F9FBEE0E);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("upload_station_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = goalpos;
  animstruct.angles = _id_9A2E0B6F009D8682;
  animstruct._id_C2FEE681E05824C8 = spawn("script_model", self.origin);
  animstruct._id_C2FEE681E05824C8 setModel("misc_hard_drive_v0_rig");
  animstruct._id_C2FEE681E05824C8 show();
  animstruct._id_C2FEE681E05824C8 useanimtree(#animtree);
  animstruct._id_C2FEE681E05824C8.animname = "upload_station_harddrive";
  self.animstruct = animstruct;
  self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_enter");
  self.animstruct scripts\common\anim::anim_single_solo(self.animstruct._id_C2FEE681E05824C8, "upload_station_enter");
}

_id_A7ADF312E5D321B6(player) {
  player endon("disconnect");
  player endon("interact_interrupt");
  waitframe();
  player notifyonplayercommand("interact_cancelled", "+weapnext");
  self._id_A4CF15C49F3E9EEF = 0;
  msg = player scripts\engine\utility::waittill_any_timeout_1(self._id_34EF5BF2EEBF19EB, "interact_cancelled");
  self._id_A4CF15C49F3E9EEF = 1;
  player notifyonplayercommandremove("interact_cancelled", "+weapnext");

  if(msg == "interact_cancelled")
    self._id_B14A331BA425C286 = 0;
  else {
    self._id_B14A331BA425C286 = 1;
    player notify("interact_begin_exit");
  }

  self notify("stop_loop");
}

_id_783F84B2AAF11D69(player) {
  player endon("interact_finished");
  linktoent = player.linktoent;
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");

  if(!isDefined(player)) {
    if(isDefined(linktoent))
      linktoent delete();

    return;
  }

  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player _id_662CBAC61C1AE7E2::_id_680B501EB7141C84(1);
}

_id_40CF8163C7E23D93(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_begin_exit");
  player endon("interact_cancelled");

  if(scripts\mp\utility\player::isreallyalive(player)) {
    self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_type");
    self.animstruct scripts\common\anim::anim_single_solo(self.animstruct._id_C2FEE681E05824C8, "upload_station_type");
  }
}

_id_5D370C10D291B6A2(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");

  if(scripts\mp\utility\player::isreallyalive(player)) {
    self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_exit");
    self.animstruct scripts\common\anim::anim_single_solo(self.animstruct._id_C2FEE681E05824C8, "upload_station_exit");
  }
}

_id_66998E5E0034B2BB(team, domflag, objidnum, _id_EA9A8C2F23231171) {
  domflag._id_503F03871E7FD1CB[team] = objidnum;
  _id_BD844A68A625E6CA(team, domflag, objidnum, _id_EA9A8C2F23231171);
  domflag._id_503F03871E7FD1CB[team] = undefined;
}

_id_BD844A68A625E6CA(team, domflag, objidnum, _id_EA9A8C2F23231171) {
  level endon("game_ended");
  self endon("task_ended");
  self._id_A29978B7F26D9210 = 1;
  objective_setpinned(objidnum, 1);
  domflag setscriptablepartstate("upload_screen", "screen_on");
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objidnum, player);

  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("secure_intel_uploading", _id_E2B2BBD9E6539F11);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, undefined, 0.0);
  timer = 0.0;
  duration = _id_D9A6BC7F39149CA7() * 1000;

  if(isDefined(_id_EA9A8C2F23231171))
    duration = _id_EA9A8C2F23231171;

  for(;;) {
    count = 0;

    foreach(player in domflag.playersintrigger) {
      if(scripts\engine\utility::is_equal(team, player.team)) {
        scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(objidnum, player, 2, 2, &"DMZ/UPLOAD_STATION_PROGRESS");
        count++;
      }
    }

    if(count > 0) {
      timer = timer + level.frameduration;
      progress = timer / duration;
      progress = clamp(progress, 0, 1);

      if(timer < duration) {
        objective_setprogress(objidnum, progress);
        domflag play_spotrep_capture_sfx(progress, team);
      } else {
        self._id_21280A92D9373B6F = domflag.playersintrigger[0];

        if(isDefined(self._id_BF7F7683EA10DA26))
          [[self._id_BF7F7683EA10DA26]](team);
        else
          _id_804EB3448706C9BC(team);
      }
    }

    waitframe();
  }
}

_id_A93281D34421174F() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self.playersintrigger, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.playersintrigger, player)) {
      self.playersintrigger[self.playersintrigger.size] = player;
      thread _id_CAF75FDE8E8C0A45(player);
    }
  }
}

_id_CAF75FDE8E8C0A45(player) {
  level endon("game_ended");
  _id_D0EAD7E588A015C5 = _id_9258EDCE111428C2();
  _id_452B0B790AA17D29 = _id_D0EAD7E588A015C5 * _id_D0EAD7E588A015C5;

  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distancesquared(self.trigger.origin, player.origin) < _id_452B0B790AA17D29)
    waitframe();

  if(isDefined(player)) {
    foreach(team, objicon in self._id_503F03871E7FD1CB) {
      if(scripts\engine\utility::is_equal(team, player.team)) {
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(objicon, player);
        break;
      }
    }
  }

  self.playersintrigger = scripts\engine\utility::array_remove(self.playersintrigger, player);
}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players)
    player playlocalsound(_id_C3DDFB0EAA8F761C, undefined, undefined, 1);
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

_id_8C550607FB966B6F(team, origin) {
  wait 4;
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  if(isDefined(players) && players.size > 0) {
    closestplayer = scripts\engine\utility::getclosest(origin, players);
    _id_93C69EAD55EB3F07 = _id_0B7A9CE0A2282B79::_id_E860C1BE7FF11F5B(team, 20);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1 + _id_93C69EAD55EB3F07; _id_AC0E594AC96AA3A8++) {
      _id_2FDEB8023287BE67::_id_B34CF3006201B016(closestplayer, 1, origin);
      wait 5.0;
    }
  }
}

_id_9258EDCE111428C2() {
  if(isDefined(level._id_D6AE5CC7B162C730))
    return level._id_D6AE5CC7B162C730._id_5F4A68D8FB9F45DD;

  return level._id_963BA76EE083D599._id_D0EAD7E588A015C5;
}

_id_D9A6BC7F39149CA7() {
  if(isDefined(level._id_D6AE5CC7B162C730))
    return level._id_D6AE5CC7B162C730._id_07383519BDE1C5CE;

  return level._id_963BA76EE083D599.capturetime;
}

_id_7F460FE8D509A260() {
  if(isDefined(level._id_D6AE5CC7B162C730))
    return level._id_D6AE5CC7B162C730._id_B820CB1AC6257B4B;

  return level._id_963BA76EE083D599._id_B820CB1AC6257B4B;
}

_id_133D4B6D206849D8() {
  if(isDefined(self._id_5E5710CA5B795C6B))
    return self._id_5E5710CA5B795C6B;

  return self.item;
}