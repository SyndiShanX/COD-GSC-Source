/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_pe_dom.gsc
*********************************************************/

init() {
  superonunset();
  level.start_reach_exhaust_waste.setupteamplunderhud = spawnStruct();
  level.start_reach_exhaust_waste.setupteamplunderhud.active = 0;
  level.start_reach_exhaust_waste.setupteamplunderhud.duration = getdvarint("_encstr_AF3D1DAE3BEAC92681178038DF73178AE1432FB07358E81A43C3704B041048", 120);
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_AA171B6E36C9AF934BD78359AF860B9C91E0BDB4B93AEB7795A576433A", 1.0);
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0._id_11B78 = getdvarint("_encstr_83BD1E3BF60B3FA2EBC92B72E1C15E3361E7BFA99813F72DA388C15B4833977F", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_BEC4276A7866BEA0F6D69E1052694159C2C176D16A0621BE17F9FE120899D969D169B11FAA6A21FA08");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(101, var_0);
}

_id_140CF() {
  return 0;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  var_0 = forest_combat();
  wait(var_0);
}

forest_combat() {
  var_0 = getdvarfloat("_encstr_B14D22CD36397D392DD7C1B2FAD058C923C17BB49B8EEBCD8E169C47A3B4B5CAAF5B9673", 795);
  var_1 = getdvarfloat("_encstr_924D22AB807D415BA028F01DC068DFD289B0D282701909073B2FFA046D10975F57A0BA0B", 1110);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

attackerswaittime() {
  var_0 = randomint(level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions.size);
  _id_122C0(var_0);
}

superonunset() {
  level.start_reach_exhaust_waste.setupteamplunderleaderboard = [];

  for(var_0 = 0; var_0 < 7; var_0++) {
    var_1 = scripts\engine\utility::getStructArray("_encstr_8D831C89E38B05D02EDC6333F6137943EF7BC133DABF305009B26F45E5BA" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size < 0) {
      continue;
    }
    var_2 = [];

    foreach(var_4 in var_1)
    var_2[var_2.size] = var_4.origin;

    level.start_reach_exhaust_waste.setupteamplunderleaderboard = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.setupteamplunderleaderboard, var_2);
  }

  if(level.start_reach_exhaust_waste.setupteamplunderleaderboard.size < 0) {
    var_6 = [[(1517, 643, 3154)], [(-16156, -12766, 946)], [(35718, 35730, 2010)], [(3109, 38466, 714)], [(-26003, 14132, 2286)], [(5385, -26020, 2630)], [(35361, -1082, 1226)]];
    level.start_reach_exhaust_waste.setupteamplunderleaderboard = var_6;
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    for(var_8 = 0; var_8 < level.start_reach_exhaust_waste.setupteamplunderleaderboard.size; var_8++) {
      if(level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_8].size > 0)
        level.start_reach_exhaust_waste._id_12E2C _id_12AF0(var_7, race_ui_checkpoint(var_8));
    }
  }
}

_id_12AF0(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level.start_reach_exhaust_waste.maphints;

  if(!isDefined(self.manualturret_toggleallowuseactions))
    self.manualturret_toggleallowuseactions = [];

  if(!isDefined(self.manualturret_toggleallowuseactions[var_0]))
    self.manualturret_toggleallowuseactions[var_0] = [];

  var_3 = spawnStruct();
  var_3._id_135CE = var_0;
  var_3.location = getgroundposition(var_1, 5);
  var_3.get_current_building_obj_struct = var_2;
  self.manualturret_toggleallowuseactions[var_0] = scripts\engine\utility::array_add(self.manualturret_toggleallowuseactions[var_0], var_3);
}

_id_122C0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions))
    level.start_reach_exhaust_waste._id_12E2C _id_12AF0(var_0, level.start_reach_exhaust_waste._id_12E2C.ground_detection_think);

  var_1 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_0];
  level.start_reach_exhaust_waste._id_12E2C._id_122B5 = var_0;

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }
  level.maphint_cheesescriptableused = var_1.size;
  _id_122BF();

  if(getdvarint("_encstr_85981DC399CE876248B76373F3A8E1D774F18A3B6624379C784F7C49E378B2", 0) == 0) {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BA911319F6DAFA0EB72D9B47AF4B37B1DE6BA573CE", 0);
    _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_12424("_encstr_97F81C8939EB934BBE83CAFA91B75BF5991B16B3DCAF4B73B1DED6B4B976");
    wait 20;
  }

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_ACC612C8F6ADFA07B7A59B47D76EE80B39472BC8", 0);
  _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_12424("_encstr_82E11A229E49B043271AEB4F171DE02FD869199FF2F93F6DC080BB07");
  wait 3.0;
  level thread _id_122BE();
}

_id_122BC() {
  var_0 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[level.start_reach_exhaust_waste._id_12E2C._id_122B5];

  foreach(var_2 in var_0) {
    var_3 = var_2.manned_turret_operator_validation_func;
    var_3 notify("_encstr_AC1B1071F559A8303789B9E072C7E068AD4C");
    var_3 thread _id_122A3(var_3);
  }
}

_id_122BF() {
  var_0 = level.start_reach_exhaust_waste._id_12E2C._id_122B5;
  var_1 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_0];

  foreach(var_4, var_3 in var_1)
  var_3 thread _id_122B7();
}

_id_122BE() {
  var_0 = ["_encstr_B20703DFCF", "_encstr_B40703E96D", "_encstr_B6070359BA", "_encstr_A2070318DC", "_encstr_950703EBCA", "_encstr_BA07035941", "_encstr_B107034124"];

  if(!isDefined(level.start_reach_exhaust_waste.are_all_players_in_region)) {
    level.start_reach_exhaust_waste.are_all_players_in_region = [];
    level.start_reach_exhaust_waste.are_all_players_in_region["_encstr_9A8507BA4040188D08"] = 0;
    level.start_reach_exhaust_waste.are_all_players_in_region["_encstr_8E8405EA382B2A"] = 0;
  }

  if(!isDefined(level.start_reach_exhaust_waste.spawnsecretstashlootcache))
    level.start_reach_exhaust_waste.spawnsecretstashlootcache = 0;

  var_1 = level.start_reach_exhaust_waste._id_12E2C._id_122B5;
  var_2 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_1];

  foreach(var_8, var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_4.get_current_building_obj_struct), var_4.get_current_building_obj_struct, level.start_reach_exhaust_waste.maphints);
    var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4.location, 0, int(var_5), int(level.defend_wave_3));
    var_6.script_label = var_0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
    var_6.iconname = var_0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
    level.start_reach_exhaust_waste.spawnsecretstashlootcache++;
    var_2[var_8].trigger = var_6;
    var_7 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_2[var_8].trigger, "_encstr_A7A408B9CA5D1D4E2C63");
    var_7.onuse = ::_id_122B2;
    var_7.onbeginuse = ::_id_122A8;
    var_7.onuseupdate = ::_id_122B3;
    var_7.onenduse = ::_id_122AA;
    var_7.oncontested = ::_id_122A9;
    var_7.onuncontested = ::_id_122AF;
    var_7.onunoccupied = ::_id_122B0;
    var_7.onpinnedstate = ::_id_122AD;
    var_7.onunpinnedstate = ::_id_122B1;
    var_7._id_138B2 = ::_id_122AE;
    var_7.stompprogressreward = ::_id_122B8;
    var_7.id = "_encstr_87D9083A6F628DDB5F1F";
    var_7.pinobj = 1;
    var_7.lockupdatingicons = 1;
    var_7.trigger = var_6;
    var_7.get_current_bush_zone = 0;
    var_7.get_current_building_obj_struct = var_5;
    var_7.pos = var_4.location;
    var_7.vfxent = var_4.vfxent;
    var_7 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
    var_7 scripts\mp\gameobjects::setusetime(level.start_reach_exhaust_waste._id_122A1);
    playencryptedcinematicforall(var_7.objidnum, 1);
    var_7._id_11AD0 = [];
    var_7._id_11AD0["_encstr_AD830516C68DE5"] = spawnStruct();
    var_7._id_11AD0["_encstr_88BF06FD784A6393"] = spawnStruct();
    var_7._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"] = spawnStruct();
    var_7.waittill_pickup_or_timeout = "_encstr_8C500ABA9B23CACC2D37AC8C";
    var_7._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"] _id_122A4(9, var_7.curorigin, var_5);
    var_7._id_11AD0["_encstr_AD830516C68DE5"] _id_122A4(8, var_7.curorigin, var_5);
    var_7._id_11AD0["_encstr_88BF06FD784A6393"] _id_122A4(0, var_7.curorigin, var_5);
    var_7 _id_122BB("_encstr_A7A408B9CA5D1D4E2C63");
    var_7 thread _id_122B9();
    var_7 thread _id_122BA();
    var_2[var_8].manned_turret_operator_validation_func = var_7;
    wait 0.5;
  }
}

_id_122AB(var_0) {
  self._id_1265B = scripts\engine\utility::array_add(self._id_1265B, var_0);
  var_0.truck_04_node = 1;
}

_id_122AC(var_0) {
  self._id_1265B = scripts\engine\utility::array_remove(self._id_1265B, var_0);
  var_0.truck_04_node = 0;
}

_id_122B9() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_1265B = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self._id_1265B, var_0))
      _id_122AB(var_0);

    waitframe();
  }
}

_id_122BA() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!self.get_current_bush_zone) {
    foreach(var_1 in self._id_1265B) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1))
        _id_122AC(var_1);
    }

    wait 0.1;
  }

  foreach(var_1 in self._id_1265B)
  _id_122AC(var_1);
}

_id_122A7(var_0, var_1) {
  if(istrue(var_1.truck_04_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_97021BC3E3B1226CD01EF73D7029AE7A1F6FEF17ADED9A41D960ACC548", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_97021BC3E3B1226CD01EF73D7029AE7A1F6FEF17ADED9A41D960ACC548");
  }

  if(istrue(var_0.truck_04_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_96131C9B13094BDDE06FBC8F330967BBA7C9C102F954EF158007BB81D978", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_96131C9B13094BDDE06FBC8F330967BBA7C9C102F954EF158007BB81D978");
  }
}

_id_122A4(var_0, var_1, var_2) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(var_0, 0, 0, var_1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(int(var_2));
}

_id_122BB(var_0) {
  if(var_0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var_0;

    foreach(var_2 in self._id_11AD0)
    var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();

    var_4 = self.waittill_pickup_or_timeout != "_encstr_8E8405EA382B2A" && self.waittill_pickup_or_timeout != "_encstr_9A8507BA4040188D08";
    var_5 = undefined;

    foreach(var_7 in level.players) {
      var_8 = var_7.team == self.waittill_pickup_or_timeout;

      if(var_4)
        var_5 = self._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"];
      else
        var_5 = scripts\engine\utility::ter_op(var_8, self._id_11AD0["_encstr_AD830516C68DE5"], self._id_11AD0["_encstr_88BF06FD784A6393"]);

      if(isDefined(var_5))
        var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_7);
    }

    if(isDefined(var_5))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var_0);
  }
}

_id_122A5() {
  foreach(var_1 in self._id_11AD0) {
    if(isDefined(var_1))
      var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
  }
}

_id_122B2(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  self notify("_encstr_AC1B1071F559A8303789B9E072C7E068AD4C");
  thread _id_122A2(var_1);
}

_id_122A8(var_0) {
  self.userate = 1.0;

  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.curorigin, "_encstr_8218041DF5FA");
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1)
    var_3 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

_id_122B3(var_0, var_1, var_2, var_3) {
  self.userate = 1.0;

  if(var_1 < 1.0 && !level.gameended && !istrue(self.get_current_bush_zone))
    _id_12427(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;

  _id_122BB(var_0);
}

_id_122AA(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

_id_122A9() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D861089DB8FC7E017163810235367EB7553");
  var_0 = scripts\mp\gameobjects::getownerteam();
}

_id_122AF(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = _id_122A6();

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

    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");

    if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
      self.didstatusnotify = 0;
  }
}

_id_122B0() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");

  self.didstatusnotify = 0;
}

_id_122AD(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
}

_id_122B1(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6");
}

_id_122AE(var_0) {
  self.userate = level.start_reach_exhaust_waste.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0)
      var_2 = var_5 / self.usetime;
  }
}

_id_122B8(var_0) {
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

_id_122A2(var_0) {
  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    level.start_reach_exhaust_waste.are_all_players_in_region[var_0] = level.start_reach_exhaust_waste.are_all_players_in_region[var_0] + 1;

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0) {
        var_2 thread _id_122B4(1, var_0);
        var_2 thread scripts\mp\hud_message::showsplash("_encstr_8EA420E983DFA6D041E0433F1CB508F8D3FA01F1F9775750A3DD75B3049120394343");
        continue;
      }

      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team != var_0) {
        var_2 thread _id_122B4(0, var_0);
        var_2 thread scripts\mp\hud_message::showsplash("_encstr_BEFE210DBA11500BC7B3014EDA2F3181F70C938F6FC60BCF339BFB31C217FD404F952B");
      }
    }

    var_4 = undefined;

    foreach(var_6 in self.touchlist[var_0]) {
      var_2 = var_6.player;
      var_2 thread scripts\mp\rank::giverankxp("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61", 250, var_2 getcurrentprimaryweapon());
      var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61");

      if(!isDefined(var_4))
        var_4 = var_2;
    }

    thread _id_122B6();
    thread _id_122A3(self);
  }
}

_id_122B4(var_0, var_1) {
  var_2 = level.start_reach_exhaust_waste.are_all_players_in_region[var_1];

  switch (var_2) {
    case 1:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A1991D74B8A0771ADFB012AB191552671990FCE4CB8EDF66C9B0ABC3E00FDA", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A6B31A85E0C789AF1093F64B0793600573D8F9B3D9E013D57BF5EF2F", self);

      break;
    case 2:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8F991D57F88BA128B028D3A38149E20A6380DFCD5B473A413BE8B7B3B846FA", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8AB31A18CA65FF4BF739606537E7B043CD3349D8C2FA11A3EB5DE07E", self);

      break;
    case 3:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_834B1F19EDDAFAE07B5A37A3D7CCE49659B9231BBCAF362C1C8EBAC956FAB01B8D", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_838C1C856D620FA3C707E830F7E5B8A38A10909E460B114BA22F5980C334", self);

      break;
  }
}

_id_122A3(var_0) {
  if(isDefined(var_0.vfxent))
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_0.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  level.maphint_cheesescriptableused--;

  if(level.maphint_cheesescriptableused == 0) {
    var_1 = scripts\mp\gamelogic::gettimeremaining() / 1000;
    level.manifest_music_started = -1;
    level.manned_turret_createhintobject = ceil(var_1) - 60 + 20;
  }

  var_0 _id_122A5();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::removeobjective(var_0);
}

_id_122B7() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.location - (0, 0, 3));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.vfxent = var_0;
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_id_122B6() {
  level thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_119F7(self.pos, "_encstr_B84E213A1048D3D1A8D37A4CE3C927F7E18E1242B914C716E819645DA570A11F1FA36A", 25);
  level thread _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_119F7(self.pos, "_encstr_936E24D8BDB747AFE816988DACD791DEB6FA661B2C9D7D1BC21C475793567DBB2B58C17BCDB9", 5);
}

_id_122A6() {
  var_0 = 0;

  foreach(var_3, var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "_encstr_8BBA05185F8B99"))
      var_0++;
  }

  return var_0;
}

race_ui_checkpoint(var_0) {
  var_1 = randomint(level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_0].size);
  return level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_0][var_1];
}