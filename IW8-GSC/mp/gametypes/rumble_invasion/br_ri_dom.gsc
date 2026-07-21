/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_dom.gsc
******************************************************/

maphint_computerscriptableused() {
  _encstr_85C33D3B629BFBC85B3367EB58D528B74FBA53E2BB3F2EFAF62AFFCD65ADC88937714888438766F04D1EF7E9979559C18BE903F279FF9E90E6E69945877A70::initstructs();
  level.defend_wave_3 = getdvarint("_encstr_8B2711B3069219D6CB8F31DFBF90AD605F5CDB", 250);
  var_0 = ["_encstr_B20703DFCF", "_encstr_B40703E96D", "_encstr_B6070359BA", "_encstr_A2070318DC", "_encstr_950703EBCA", "_encstr_BA07035941", "_encstr_B107034124"];

  if(!isDefined(level.start_reach_exhaust_waste.maphint_phonescriptableused))
    level.start_reach_exhaust_waste.maphint_phonescriptableused = scripts\engine\utility::getStructArray("_encstr_A9C21713E449AE5B26D856259B9DEBC8DEB57D83BDA5E6D1B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused))
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = [];

  foreach(var_6, var_2 in level.start_reach_exhaust_waste.maphint_phonescriptableused) {
    var_3 = level.start_reach_exhaust_waste.maphints;
    var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin, 0, int(var_3), int(level.defend_wave_3));
    var_4.script_label = var_0[var_6];
    var_4.iconname = var_0[var_6];
    var_5 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_4, "_encstr_A7A408B9CA5D1D4E2C63");
    var_5.onuse = ::manualturret_endturretuseonexecution;
    var_5.onbeginuse = ::manual_turret_allowpickupofturret;
    var_5.onuseupdate = ::manualturret_endturretuseonpush;
    var_5.onenduse = ::manual_turret_handlemovingplatform;
    var_5.oncontested = ::manual_turret_canpickup;
    var_5.onuncontested = ::manualturret_clearplacementinstructions;
    var_5.onunoccupied = ::manualturret_disablecrouchpronemantle;
    var_5.onpinnedstate = ::manual_turret_operate_by_nearby_enemies;
    var_5.onunpinnedstate = ::manualturret_domonitoredweaponswitch;
    var_5._id_138B2 = ::manualadjustlittlebirdlocs;
    var_5.stompprogressreward = ::manualturret_watchdeathongameend;
    var_5.id = "_encstr_87D9083A6F628DDB5F1F";
    var_5.pinobj = 1;
    var_5.lockupdatingicons = 0;
    var_5.trigger = var_4;
    var_5.get_current_bush_zone = 0;
    var_5._id_133A5 = 1;
    var_5.get_current_building_obj_struct = var_3;
    var_5.pos = var_2.origin;
    var_5.vfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.pos);
    var_5.vfxent setModel("_encstr_931C0B8376A3AF9378695D57CD");
    var_5.vfxent setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A7A408B9CA5D1D4E2C63");
    var_5 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
    var_5 scripts\mp\gameobjects::setusetime(level.start_reach_exhaust_waste._id_122A1);
    var_5 thread map_dev_name_to_actual_station_name();
    var_5 thread mapcalloutsready();
    playencryptedcinematicforall(var_5.objidnum, 1);
    _func_0442(var_5.objidnum, 1);
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.maphint_cheese2scriptableused, var_5);
  }

  level thread mapedgeextractionlocs();
}

manualturret_endturretuseonexecution(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  self notify("_encstr_B4650D6A50F3F1BB90A777574D387B");
  thread manned_turret_spawn_func(var_1);
  self.firstcapture = 0;
}

manual_turret_allowpickupofturret(var_0) {
  self.userate = 1.0;

  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.curorigin, "_encstr_8218041DF5FA");
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1)
    var_3 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }

  var_5 = scripts\mp\gameobjects::getownerteam();

  if(var_5 != self.claimteam)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39", "_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA");
}

manualturret_endturretuseonpush(var_0, var_1, var_2, var_3) {
  self.userate = 1.0;

  if(var_1 < 1.0 && !level.gameended && !istrue(self.get_current_bush_zone))
    _id_12427(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

manual_turret_handlemovingplatform(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_3, 0);
  }

  if(!var_2)
    self.neutralized = 0;
}

manual_turret_canpickup() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D861089DB8FC7E017163810235367EB7553");
  thread manned_turret_spawned_nodes();
}

manned_turret_spawned_nodes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AF2A0D6B094129A7B7A0FD138D36BB");
  self endon("_encstr_AF2A0D6B094129A7B7A0FD138D36BB");
  self endon("_encstr_AC5C0F1B59CF0A27D8A0BE8598E825031D");

  while(self.stalemate) {
    foreach(var_1 in self._id_1265B) {
      if(isDefined(var_1.waittill_track_is_operational) && gettime() - var_1.waittill_track_is_operational < 5000) {
        continue;
      }
      var_1 thread scripts\mp\rank::giverankxp("_encstr_888E14E45ABE917B6B7D99C6B09DBED8BD37D1B29BD1", 20, var_1.weapon, 0, 1);
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_888E14E45ABE917B6B7D99C6B09DBED8BD37D1B29BD1");
      var_1.waittill_track_is_operational = gettime();
    }

    wait 0.1;
  }
}

manualturret_clearplacementinstructions(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = mantlebrush();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    else if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    else if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);

    if(isDefined(self.get_current_station_signage_structs)) {
      if(self.get_current_station_signage_structs != var_0)
        scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39", "_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA");
      else
        scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
    } else
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992");

    if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
      self.didstatusnotify = 0;

    self notify("_encstr_AC5C0F1B59CF0A27D8A0BE8598E825031D");
  }
}

manualturret_disablecrouchpronemantle() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");

  self.didstatusnotify = 0;
}

manual_turret_operate_by_nearby_enemies(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
}

manualturret_domonitoredweaponswitch(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
}

manualadjustlittlebirdlocs(var_0) {
  self.userate = level.start_reach_exhaust_waste.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0)
      var_2 = var_5 / self.usetime;
  }
}

manualturret_watchdeathongameend(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E84100AE82D2133A3508787FD6923F77DB0");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");

  if(isDefined(self.lastprogressteam))
    self.lastprogressteam = undefined;
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

manualturret_moving_platform_death(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0, "_encstr_AAE70838F27E43E327DC", "_encstr_86AD05B1F6B9A3");
  var_4 = "_encstr_B10703CB22";
  var_5 = "_encstr_816908616B9751608687" + var_4 + "_encstr_931904037CD1" + var_3 + var_2;

  if(soundexists(var_5)) {
    var_6 = var_3 + var_2;
    var_7 = lookupsoundlength(var_5, 1) / 1000.0;
    self queuedialogforplayer(var_5, var_6, var_7);
  }
}

manned_turret_spawn_func(var_0) {
  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    var_1 = "_encstr_B40101";

    if(istrue(self.firstcapture))
      var_1 = var_1 + "_encstr_8C380768AE6F8337CB";
    else if(istrue(level.start_reach_exhaust_waste.inovertime))
      var_1 = var_1 + "_encstr_AC1A042FFF93";

    var_1 = var_1 + self.trigger.iconname;

    foreach(var_3 in level.players) {
      if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        var_3 thread scripts\mp\hud_message::showsplash("_encstr_B2201D31937DE4B4D78CF6DAAF99D8163BEB8D2CC1D1579356C8BE168DB15E" + var_1);
        var_3 thread manualturret_moving_platform_death(1, var_0, self.trigger.iconname);
        continue;
      }

      if(isDefined(var_3) && isDefined(var_3.team) && var_3.team != var_0) {
        var_3 thread scripts\mp\hud_message::showsplash("_encstr_A7E11ED6964F33CFEF67F80358F6148BF7111040407B75904849DFD7BDCB0521" + var_1);
        var_3 thread manualturret_moving_platform_death(0, var_0, self.trigger.iconname);
      }
    }

    var_5 = undefined;

    foreach(var_7 in self.touchlist[var_0]) {
      var_3 = var_7.player;
      var_3 thread scripts\mp\rank::giverankxp("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61", 250, var_3 getcurrentprimaryweapon());
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61");

      if(!isDefined(var_5))
        var_5 = var_3;
    }

    thread manualturret_toggleallowplacementactions();
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_setcaptured(var_0, var_5);
    self.vfxent setscriptablepartstate("_encstr_A29B05E9400E5D", var_0);

    if(istrue(self.firstcapture))
      var_9 = getdvarint("_encstr_872B1C0B52ABF0C80C0FA99F51B580AE77CAC1D38B6F9EB8A90E83DD531B", 5);
    else
      var_9 = getdvarint("_encstr_BA9516DC36E4FA4EB4EB1CF6B4733AB9BE1B8583E8AEE42B", 10);

    if(istrue(level.start_reach_exhaust_waste.inovertime))
      var_9 = var_9 * getdvarint("_encstr_970B146EB193EB932DD7F6ECCAE4A35ADA59D75BB791", 2);

    level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_9, 0);
  }
}

mapedgeextractionlocs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_8D6D17F8DB26408A4C09288F5F40631777C807E041B3A35383", 1);
  var_1 = getdvarint("_encstr_AF6D15F6366BCFD288FFCBAA807790898156AFA152415C", 5);

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    foreach(var_3 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var_3.ownerteam) && var_3.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
        level scripts\mp\gamescore::giveteamscoreforobjective(var_3.ownerteam, var_0, 0);
    }

    wait(var_1);
  }
}

manualturret_toggleallowplacementactions() {
  level thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_119F7(self.pos, "_encstr_B84E213A1048D3D1A8D37A4CE3C927F7E18E1242B914C716E819645DA570A11F1FA36A", 25);
  level thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_119F7(self.pos, "_encstr_936E24D8BDB747AFE816988DACD791DEB6FA661B2C9D7D1BC21C475793567DBB2B58C17BCDB9", 5);
}

mantlebrush() {
  var_0 = 0;

  foreach(var_3, var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "_encstr_8BBA05185F8B99"))
      var_0++;
  }

  return var_0;
}

map_dev_name_to_actual_station_name() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_1265B = [];

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self._id_1265B, var_0))
      manual_turret_laststandwatcher(var_0);

    waitframe();
  }
}

mapcalloutsready() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_1 in self._id_1265B) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1))
        manual_turret_munitionused(var_1);
    }

    wait 0.1;
  }
}

manual_turret_laststandwatcher(var_0) {
  self._id_1265B = scripts\engine\utility::array_add(self._id_1265B, var_0);
  var_0.truck_03_node = 1;
}

manual_turret_munitionused(var_0) {
  self._id_1265B = scripts\engine\utility::array_remove(self._id_1265B, var_0);
  var_0.truck_03_node = 0;
}

mantlekill(var_0, var_1) {
  if(istrue(var_1.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_926817232798D7A0B5FEA7D1C7D72755809BEAF3C703F88AC9", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_926817232798D7A0B5FEA7D1C7D72755809BEAF3C703F88AC9");
  }

  if(istrue(var_0.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_A91218D350F644D2F380AF25F79FA90CD9B0071B902EB37AD921", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A91218D350F644D2F380AF25F79FA90CD9B0071B902EB37AD921");
  }
}