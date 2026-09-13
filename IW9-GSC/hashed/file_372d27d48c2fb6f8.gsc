/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_372d27d48c2fb6f8.gsc
***********************************************/

init() {
  thread _id_DF2A2308387C9994();
  thread _id_9A72BAC1BABDCCCC();
  thread _id_5B86F42674175045();
  thread _id_C504E6D76156FB46();
  thread _id_AE2EA71315FC286A();
}

_id_DF2A2308387C9994() {
  if(getdvarint("dvar_35B790D213133134", 1) == 0) {
    return;
  }
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "getMapSpecificCrateData", ::_id_7DB5B7E127ACC0F5);
  _id_0EFD07DCCBD93224();
  level waittill("prematch_fade_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("decoder", ::_id_755C5FB19345DB67);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("main_code", ::_id_0679971B74E7F8C0);
  level._id_BFC92D9FA408DCA1 = _id_4D4A9064F2C11053();
  _id_91527A9B851A1317 = _id_FC3B38C11C3B0DFC();
  _id_B579E6663D58E8FA = getdvarint("dvar_B7811D0F90A46ECD", 5);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B579E6663D58E8FA && _id_AC0E594AC96AA3A8 < _id_91527A9B851A1317.size; _id_AC0E594AC96AA3A8++)
    _id_7F013E3DE4D5700F(_id_91527A9B851A1317[_id_AC0E594AC96AA3A8]);
}

_id_0EFD07DCCBD93224() {
  game["dialog"]["main_scan_scanner_pickup"] = "cscn_wzan_scnp";
  game["dialog"]["main_scan_code_pickup_1"] = "cscn_wzan_frpu";
  game["dialog"]["main_scan_code_pickup_2"] = "cscn_wzan_scpu";
  game["dialog"]["main_scan_code_pickup_3"] = "cscn_wzan_scpu";
  game["dialog"]["main_scan_code_pickup_4"] = "cscn_wzan_fnlp";
  game["dialog"]["main_scan_supply_pickup"] = "cscn_wzan_sups";
}

_id_4D4A9064F2C11053() {
  _id_55E7F146B499A886 = [];
  _id_A83390477BAC23AC = strtok(getDvar("dvar_C6051D61AE800E07", "50 100 150 200"), " ");

  foreach(_id_EA41C182B21353EC in _id_A83390477BAC23AC)
  _id_55E7F146B499A886 = scripts\engine\utility::array_add(_id_55E7F146B499A886, int(_id_EA41C182B21353EC));

  return _id_55E7F146B499A886;
}

_id_FC3B38C11C3B0DFC() {
  _id_B94D4CB425E70B63 = [[(-2655, 9654, 1152), (0, 332, 0)], [(-9889, 11305, 1307), (0, 27, 0)], [(12550, 4363, 1157), (0, 185, 0)], [(1377, -122, 553), (0, 23, 0)], [(-6649, 2804, 349), (0, 132, 0)], [(-14375, -10163, 374), (0, 129, 0)], [(-7181, -8519, 334), (0, 241, 0)], [(4934, -13967, 692), (0, 265, 0)], [(13824, -5745, 812), (0, 195, 0)], [(1235, -11171, 614), (0, 105, 0)], [(-12861, -6251, 441), (0, 274, 0)], [(7621, 6382, 643), (0, 206, 0)], [(6885, 957, 606), (0, 280, 0)], [(4001, -2954, 874), (0, 240, 0)]];
  _id_B94D4CB425E70B63 = scripts\engine\utility::array_randomize(_id_B94D4CB425E70B63);
  return _id_B94D4CB425E70B63;
}

_id_7F013E3DE4D5700F(_id_91527A9B851A1317) {
  origin = _id_91527A9B851A1317[0];
  angles = _id_91527A9B851A1317[1];
  _id_042977DA7A36C7A3 = spawnscriptable("delta_ee_decoder", origin, angles);
  _id_042977DA7A36C7A3 setscriptablepartstate("decoder", "active");
}

_id_F488CD7F2F38EFDE() {
  _id_FB6A911BE19E125E = _id_4D91D66FCA0E45D2();
  _id_FB6A911BE19E125E = scripts\engine\utility::array_randomize(_id_FB6A911BE19E125E);
  _id_FF6110E865CD12DB = [];
  level._id_A48A04E9B07E3CBA = [];

  foreach(_id_E4B88618D8DBAD65 in _id_FB6A911BE19E125E) {
    _id_4281628FEA32B108 = undefined;

    if(istrue(_id_E4B88618D8DBAD65._id_6FD2D9A208CEF69B) || _id_E4B88618D8DBAD65._id_C2C20201957D14C3 == 0) {
      continue;
    }
    if(_id_FF6110E865CD12DB.size >= 1) {
      foreach(_id_5AF8FDEA692BC574 in _id_FF6110E865CD12DB) {
        if(_id_E4B88618D8DBAD65._id_C2C20201957D14C3 == _id_5AF8FDEA692BC574) {
          _id_4281628FEA32B108 = 1;
          break;
        }
      }
    }

    if(istrue(_id_4281628FEA32B108)) {
      continue;
    }
    _id_FF6110E865CD12DB[_id_FF6110E865CD12DB.size] = _id_E4B88618D8DBAD65._id_C2C20201957D14C3;
    level._id_A48A04E9B07E3CBA[level._id_A48A04E9B07E3CBA.size] = _id_E4B88618D8DBAD65;

    if(_id_FF6110E865CD12DB.size >= 4) {
      break;
    }
  }

  while(_id_FF6110E865CD12DB.size < 4)
    _id_FF6110E865CD12DB[_id_FF6110E865CD12DB.size] = 0;

  return _id_FF6110E865CD12DB;
}

_id_4D91D66FCA0E45D2() {
  _id_8C88FCA9173625BB = [[0, (0, 0, 0), (0, 0, 0)], [1, (-9215, 7896, -100), (0, 327, 0)], [1, (-5989, 7384, -79), (0, 242, 0)], [2, (-7809, 5128, -21), (0, -44, 4)], [2, (-9646, 3623, -90), (-10, -163, -15)], [3, (2220, 5631, -48), (0, 270, 0)], [3, (2716, 5198, -29), (0, 43, 0)], [4, (-9909, -260, -17), (-8, 1, 0)], [4, (-5664, 592, -40), (0, 0, 5)], [5, (-3550, -215, -68), (0, 0, 0)], [5, (-4940, -1892, -128), (270, 340, 0)], [5, (-3155.5, 791, -63), (0, 0, 0)], [6, (3889, -1078, -57), (0, 0, 1)], [7, (9263, -1369, -239), (0, 153, -12)], [8, (-2006, -3794, -75), (0, 242, -5)], [8, (-3938, -6181, -83), (0, 15, 2)], [9, (2958, -4290, -44), (0, 16, -2)], [9, (262, -5239, -10), (0, 283, 0)], [10, (-3938, -10559, -106), (0, -14, -7)]];
  _id_EF0E5B6D94B0D1DD = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8C88FCA9173625BB.size; _id_AC0E594AC96AA3A8++) {
    _id_C2C20201957D14C3 = _id_8C88FCA9173625BB[_id_AC0E594AC96AA3A8][0];
    org = _id_8C88FCA9173625BB[_id_AC0E594AC96AA3A8][1];
    _id_8BC14603A27FA3E7 = _id_8C88FCA9173625BB[_id_AC0E594AC96AA3A8][2];
    _id_EF0E5B6D94B0D1DD[_id_AC0E594AC96AA3A8] = _id_5B140F857A4A92BD(_id_C2C20201957D14C3, org, _id_8BC14603A27FA3E7);
  }

  return _id_EF0E5B6D94B0D1DD;
}

_id_5B140F857A4A92BD(_id_C2C20201957D14C3, org, _id_8BC14603A27FA3E7) {
  _id_48B11326257052F1 = spawnStruct();
  _id_48B11326257052F1.origin = org;
  _id_48B11326257052F1.angles = _id_8BC14603A27FA3E7;
  _id_48B11326257052F1._id_C2C20201957D14C3 = _id_C2C20201957D14C3;
  _id_48B11326257052F1._id_6FD2D9A208CEF69B = _id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(_id_48B11326257052F1.origin);
  return _id_48B11326257052F1;
}

_id_755C5FB19345DB67(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(level._id_1775EFA2B03CF567)) {
    level._id_1775EFA2B03CF567 = _id_F488CD7F2F38EFDE();
    _id_2E192AA7CEED6D35();
  }

  thread _id_0FAFFB45E4792301(instance, part, state, player);
}

_id_0FAFFB45E4792301(instance, part, state, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(istrue(instance._id_19A46ECE9DF08C22)) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  instance._id_19A46ECE9DF08C22 = 1;
  instance setscriptablepartstate("decoder", "unusable");
  thread _id_4A6C7A91E26BEB8E(player, instance);
  _id_F24F3237B7E83856 = player gettagorigin("tag_accessory_right");
  playsoundatpos(_id_F24F3237B7E83856, "iw9_code_scan_screen");

  if(istrue(level._id_DC65C33DFDD9EFE8))
    player setcamerathirdperson(0);

  if(!isDefined(level.teamdata[player.team]["mainScanProgressionStage"]))
    _id_FCB89765B81D1A5F(player.team);

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("main_scan_scanner_pickup", player.team, 1, 2, undefined, "dx_br_bds4_");
  player thread _id_7B7CFB69D462736F();
  player _id_6C4E8CEA70BF4B6D::_id_9BE29AD72A155EE1("intel_pickup_phone_long", 9);
  player _id_A52EEAF2F7F8FACA();
  instance notify("decoder_is_usable");

  if(istrue(level._id_DC65C33DFDD9EFE8))
    player setcamerathirdperson(1);
}

_id_5D38113C3637ACB5(instance, team) {
  if(scripts\engine\utility::array_contains(instance._id_4494D8206B4C6855, team)) {
    return;
  }
  instance._id_4494D8206B4C6855[instance._id_4494D8206B4C6855.size] = team;
  _id_813F4D64901CDAF6(instance);
}

_id_A3A1F124727BFFB3(instance, team) {
  instance._id_4494D8206B4C6855 = scripts\engine\utility::array_remove(instance._id_4494D8206B4C6855, team);
  _id_813F4D64901CDAF6(instance);
}

_id_813F4D64901CDAF6(instance) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    instance disablescriptablepartplayeruse("main_code", player);
  }

  if(instance._id_4494D8206B4C6855.size > 0) {
    foreach(team in instance._id_4494D8206B4C6855) {
      foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
        if(!isDefined(player)) {
          continue;
        }
        instance enablescriptablepartplayeruse("main_code", player);
      }
    }
  }
}

_id_FCB89765B81D1A5F(team) {
  if(isDefined(level.teamdata[team]["mainScanProgressionStage"]))
    _id_74FDBA6199C25799 = level.teamdata[team]["mainScanProgressionStage"] + 1;
  else
    _id_74FDBA6199C25799 = 0;

  level.teamdata[team]["mainScanProgressionStage"] = _id_74FDBA6199C25799;
  dlog_recordevent("dlog_event_main_scan", ["main_scan_progression", _id_74FDBA6199C25799]);
  return _id_74FDBA6199C25799;
}

_id_4A6C7A91E26BEB8E(player, instance) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(player, "death_or_disconnect", instance, "decoder_is_usable");
  instance._id_19A46ECE9DF08C22 = undefined;
  instance setscriptablepartstate("decoder", "active");
}

_id_7B7CFB69D462736F() {
  player = self;
  _id_64571E3AECCD1A07 = 0;

  foreach(_id_5AF8FDEA692BC574 in level._id_1775EFA2B03CF567) {
    player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_tablet_code", _id_64571E3AECCD1A07, 4, _id_5AF8FDEA692BC574);
    _id_64571E3AECCD1A07 = _id_64571E3AECCD1A07 + 4;
  }
}

_id_2E192AA7CEED6D35() {
  level._id_D0F372FF38FE9C6D = [];
  _id_294B7594CC420B90 = _id_4D91D66FCA0E45D2();

  foreach(_id_0E500870AFCA4845 in level._id_A48A04E9B07E3CBA) {
    _id_02034D09F9C78E02 = spawnscriptable("delta_ee_main_code", _id_0E500870AFCA4845.origin, _id_0E500870AFCA4845.angles);
    _id_9D4FAFFA9D3F9D3B(_id_02034D09F9C78E02);
  }
}

_id_9D4FAFFA9D3F9D3B(_id_02034D09F9C78E02) {
  _id_02034D09F9C78E02 setscriptablepartstate("main_code", "active");
  _id_02034D09F9C78E02._id_4494D8206B4C6855 = [];
  _id_813F4D64901CDAF6(_id_02034D09F9C78E02);
  _id_D942EE8BCC8CDBC6 = getdvarint("dvar_0DEB36FA69F319A5", 5);
  _id_02034D09F9C78E02.id = "scanning_code";
  _id_02034D09F9C78E02.usetime = _id_D942EE8BCC8CDBC6 * 1000;
  _id_02034D09F9C78E02.curprogress = 0;
  level._id_D0F372FF38FE9C6D[level._id_D0F372FF38FE9C6D.size] = _id_02034D09F9C78E02;
}

_id_A52EEAF2F7F8FACA() {
  player = self;

  foreach(scriptable in level._id_D0F372FF38FE9C6D)
  _id_5D38113C3637ACB5(scriptable, player.team);
}

_id_0679971B74E7F8C0(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_BDDC832DCD2B056B(instance, part, state, player);
}

_id_BDDC832DCD2B056B(instance, part, state, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(istrue(instance._id_19A46ECE9DF08C22)) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  instance._id_19A46ECE9DF08C22 = 1;
  instance setscriptablepartstate("main_code", "unusable");
  _id_813F4D64901CDAF6(instance);
  instance.curprogress = 0;
  thread _id_F69E103B974557C9(player, instance);

  while(player useButtonPressed() && instance.curprogress < instance.usetime && scripts\mp\utility\player::_id_AD443BBCDCF37B85(player) && distance2d(instance.origin, player.origin) <= 75) {
    instance.curprogress = instance.curprogress + level.frameduration;
    player scripts\mp\gameobjects::updateuiprogress(instance, 1);
    waitframe();
  }

  instance notify("scan_is_usable");
  _id_6CCAFC1509146DAA = instance.curprogress >= instance.usetime;

  if(istrue(_id_6CCAFC1509146DAA)) {
    _id_1A0C58A3888DCA70 = _id_FCB89765B81D1A5F(player.team);
    player playlocalsound("iw9_code_scan_succes");
    _id_02F8CAD7411F138B = "main_scan_code_pickup_" + _id_1A0C58A3888DCA70;

    if(isDefined(_id_02F8CAD7411F138B))
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_02F8CAD7411F138B, player.team, 1, 0, undefined, "dx_br_bds4_");

    _id_A3A1F124727BFFB3(instance, player.team);

    foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
      _id_B2810E8D06E0A042 thread scripts\mp\utility\points::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF("stat_13B47ECB38CD8291", _id_1A0C58A3888DCA70));
      _id_B2810E8D06E0A042 _id_6AFF3948CF4CCA03::playerplunderpickup(level._id_BFC92D9FA408DCA1[_id_1A0C58A3888DCA70 - 1]);

      if(istrue(_id_F4DE1BAF62E6F307(_id_B2810E8D06E0A042.team)))
        _id_B2810E8D06E0A042 scripts\mp\hud_message::showsplash("delta_ee_main_scan_code_completed", undefined, undefined, undefined, undefined, "splash_list_br_delta_sidequest_scan_codes");
    }

    if(istrue(_id_F4DE1BAF62E6F307(player.team)))
      thread _id_790681336416F768(player);
  }
}

_id_F69E103B974557C9(player, instance) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(player, "death_or_disconnect", instance, "scan_is_usable");
  instance._id_19A46ECE9DF08C22 = undefined;
  instance setscriptablepartstate("main_code", "active");
  _id_813F4D64901CDAF6(instance);
  instance.curprogress = 0;
  player scripts\mp\gameobjects::updateuiprogress(instance, 0);
}

_id_F4DE1BAF62E6F307(team) {
  return level.teamdata[team]["mainScanProgressionStage"] >= 4;
}

_id_790681336416F768(player) {
  level endon("game_ended");
  wait 7;
  _id_1534E5F02A11FD58 = _id_276448DC80AD7723();

  if(_id_1534E5F02A11FD58.size == 0) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
      _id_90438C7F217DC4A0 = _id_2695A20D4011076D::getrandompointinsafecircle();
    else
      _id_90438C7F217DC4A0 = player.origin;

    _id_1534E5F02A11FD58[_id_1534E5F02A11FD58.size] = _id_90438C7F217DC4A0;
  }

  _id_76A22C18960F72AF = scripts\engine\utility::random(_id_1534E5F02A11FD58);

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players"))
  _id_B2810E8D06E0A042 scripts\mp\hud_message::showsplash("delta_ee_main_scan_supply_drop_incoming", undefined, undefined, undefined, undefined, "splash_list_br_delta_sidequest_scan_codes");

  level thread dropdeliveryatpos(_id_76A22C18960F72AF, player);
}

_id_276448DC80AD7723() {
  _id_69063A97FC4F5ED0 = [];
  _id_81AF62927224AB9F = [(728, -9444, 137), (8825, -4953, 942), (4918, -2201, 144), (-210, -611, 136), (-6173, 3804, 70), (444, 8563, 994), (-9267, 10170, 124), (6636, 7352, 135), (-11794, -4763, 71), (4262, 2631, 370), (11084, 2608, 157), (-6828, -7156, 138)];

  foreach(location in _id_81AF62927224AB9F) {
    _id_7D9A6D00A336393B = _id_2695A20D4011076D::getmintimetillpointindangercircle(location);

    if(_id_7D9A6D00A336393B > 75)
      _id_69063A97FC4F5ED0[_id_69063A97FC4F5ED0.size] = location;
  }

  return _id_69063A97FC4F5ED0;
}

dropdeliveryatpos(droppoint, player) {
  level endon("game_ended");
  pathstruct = _id_2E385BC294259245::c130airdrop_createpath(undefined, droppoint, 1);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27.owner = player;
  _id_184D0A0CE31A2B27.team = player.team;
  _id_184D0A0CE31A2B27.dropfunc = ::_id_7F6EB18139891D99;
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(1, "delta_ee_final_reward", "inactive");
}

_id_7F6EB18139891D99(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  _id_0BD34ECAC3ADA85B = self.startpt;
  droppoint = self.centerpt;
  _id_5D55352ED330471C = self.speed;
  _id_800DF1B7C6E3AA60 = distance2d(_id_0BD34ECAC3ADA85B, droppoint) / _id_5D55352ED330471C;
  numcrates = 0;
  _id_71CAC1D48AB1C488 = 0;

  while(numcrates < _id_5EE94AE126526F2F) {
    wait(_id_800DF1B7C6E3AA60);
    _id_76A22C18960F72AF = _id_2E385BC294259245::c130airdrop_findvaliddroplocation(self.origin, 1);
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(_id_76A22C18960F72AF + (0, 0, level.c130airdrop_heightoverride - 100), _id_76A22C18960F72AF, self.angles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, undefined, self.team, "ks_airdrop_crate_sidequest_main_scan");
    crate setotherent(self.owner);
    numcrates++;
    level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
    _id_EF5D5141FDB51174.usetimeoverride = 10;
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", crate.origin, "ui_map_icon_drop_delta_reward");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
      scripts\mp\objidpoolmanager::update_objective_onentity(objid, crate);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 1);
      scripts\mp\objidpoolmanager::_id_098BA077848896A3(objid, 1);
      objective_setfadedisabled(objid, 1);
      objective_setlabel(objid, &"MP_BR_INGAME/SECRET_CRATE");
      objective_setdescription(objid, &"MP_BR_INGAME/SECRET_CRATE");
      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(objid, self);
      crate._id_7B5E5C2BBC8F9F79 = objid;
    }
  }
}

_id_7DB5B7E127ACC0F5() {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("delta_ee_final_reward");
  _id_962A30A9BB8C0F09.capturestring = &"MP/LOOT_CRATE_DECRYPT";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_01_sidequest_main_scan";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.isteamonlycrate = 1;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_D02DB091E57A2EDF;
  _id_962A30A9BB8C0F09.destroycallback = ::_id_F64C14121DCEB3E3;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_0182B7F33F403940;
  _id_962A30A9BB8C0F09.cratephysicsoncallback = ::_id_87DF02FFA731C83D;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
}

_id_0182B7F33F403940(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

_id_D02DB091E57A2EDF(player) {
  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  _id_EBB4919FE22AA408(player);

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

_id_F64C14121DCEB3E3(immediate) {
  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

_id_87DF02FFA731C83D(position, destination) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

_id_EBB4919FE22AA408(player) {
  _id_FCB89765B81D1A5F(player.team);
  self.itemsdropped = 0;
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_F2B8863302006284 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team, player._id_0FF97225579DE16A, 0).size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2B8863302006284; _id_AC0E594AC96AA3A8++) {
    _id_610520BE555433B2 = randomintrange(0, 10);
    _id_75EA56AC509FED3B = getscriptcachecontents("br_main_scan", _id_610520BE555433B2);
    _id_E05413A53B5D9167 = _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, _id_75EA56AC509FED3B, 0, player);
  }

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
    _id_B2810E8D06E0A042 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_BE8A05C24EADBC81");
    scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_B2810E8D06E0A042, "body_scan_ee", 1);
  }

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("main_scan_supply_pickup", player.team, 1, 0, undefined, "dx_br_bds4_");
}

_id_9A72BAC1BABDCCCC() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_DD7BFEA4EB1DA762 = scripts\engine\utility::getStructArray("emergency_supply_spawn", "script_noteworthy");

  foreach(loc in _id_DD7BFEA4EB1DA762)
  _func_71B02CB97BBC4655(loc.targetname);

  if(getdvarint("dvar_89B66FE653F6DDF8", 1) == 0) {
    return;
  }
  scripts\engine\scriptable::scriptable_addnotifycallback("moduledead", ::_id_0D17A3CE89DB4D69);
  _id_866880EFF524A58D = spawnStruct();
  _id_866880EFF524A58D.instance = undefined;
  _id_866880EFF524A58D._id_26B0E4F14D4C062E = [];
  _id_866880EFF524A58D._id_27690D9EE6E0E8D9 = getdvarint("dvar_F71116361CE5DDDF", 5);
  _id_866880EFF524A58D._id_9AD08BFF0BD94583 = 0;
  level._id_866880EFF524A58D = _id_866880EFF524A58D;
  index = getdvarint("dvar_D9233A2304F8F591", -1);

  if(index < 0)
    index = randomint(_id_DD7BFEA4EB1DA762.size);

  location = _id_DD7BFEA4EB1DA762[index];

  if(!isDefined(location)) {
    return;
  }
  if(!isDefined(location.angles))
    location.angles = (0, 0, 0);

  _id_8EA1C4862C10FEF8 = scripts\engine\utility::getStructArray(location.target, "targetname");

  if(_id_8EA1C4862C10FEF8.size <= 0) {
    return;
  }
  level waittill("prematch_fade_done");
  _id_EC7B12FA2390BDA3 = undefined;

  if(isDefined(level.brgametype._id_FC940842D42C2893) && isDefined(level.brgametype._id_FC940842D42C2893._id_6C073ECDC1C6DBA5)) {
    _id_EC7B12FA2390BDA3 = level.brgametype._id_FC940842D42C2893._id_6C073ECDC1C6DBA5;

    foreach(_id_6205F0A55CBE3E2C in _id_EC7B12FA2390BDA3) {
      if(issubstr(_id_6205F0A55CBE3E2C._id_D2D351BEAAB03413, "riotshield"))
        _id_EC7B12FA2390BDA3 = scripts\engine\utility::array_remove(_id_EC7B12FA2390BDA3, _id_6205F0A55CBE3E2C);
    }
  }

  instance = spawnscriptable("emergency_supply_crate", location.origin, location.angles);
  _id_D9910DA976DB8E48 = getEntArray("emergency_supply_sm", "script_noteworthy");
  instance._id_1F1EDE31505B0A10 = _id_F937273983AA99D1("emergency_supply_clip_body", location.origin, location.angles, _id_D9910DA976DB8E48);
  _func_57A327FDD5C7E498(location.targetname);
  instance.rewards = [];
  _id_90DAADF14C1D8C02 = [];

  foreach(struct in _id_8EA1C4862C10FEF8) {
    if(!isDefined(struct.angles))
      struct.angles = (0, 0, 0);

    if(struct.script_noteworthy == "emergency_supply_door_lf") {
      instance._id_5EBF7325BB8C6E68 = _id_8AFA5E7534783519("lf", struct.origin, struct.angles);
      instance.lock = spawnscriptable("emergency_supply_lock", struct.origin, struct.angles);
    }

    if(struct.script_noteworthy == "emergency_supply_door_rt")
      instance._id_5EEB6125BBBCAD38 = _id_8AFA5E7534783519("rt", struct.origin, struct.angles);

    if(struct.script_noteworthy == "emergency_supply_module")
      _id_90DAADF14C1D8C02 = scripts\engine\utility::array_add(_id_90DAADF14C1D8C02, struct);

    if(issubstr(struct.script_noteworthy, "weapon")) {
      if(isDefined(_id_EC7B12FA2390BDA3))
        instance _id_16769793EB62273A(_id_EC7B12FA2390BDA3[randomint(_id_EC7B12FA2390BDA3.size)]._id_D2D351BEAAB03413, struct);
    }

    if(issubstr(struct.script_noteworthy, "armorbox"))
      instance _id_16769793EB62273A("brloot_super_armorbox", struct);

    if(issubstr(struct.script_noteworthy, "munitionsbox"))
      instance _id_16769793EB62273A("brloot_super_munitionsbox", struct);

    if(issubstr(struct.script_noteworthy, "killstreak"))
      instance _id_16769793EB62273A("brloot_killstreak_uav", struct);
  }

  if(_id_866880EFF524A58D._id_27690D9EE6E0E8D9 > _id_90DAADF14C1D8C02.size)
    _id_866880EFF524A58D._id_27690D9EE6E0E8D9 = _id_90DAADF14C1D8C02.size;

  _id_90DAADF14C1D8C02 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_90DAADF14C1D8C02), 0, _id_866880EFF524A58D._id_27690D9EE6E0E8D9);

  foreach(loc in _id_90DAADF14C1D8C02) {
    _id_F564CE57BB79FF69 = spawnscriptable("emergency_supply_module", loc.origin, loc.angles);
    level._id_866880EFF524A58D._id_26B0E4F14D4C062E = scripts\engine\utility::array_add(level._id_866880EFF524A58D._id_26B0E4F14D4C062E, _id_F564CE57BB79FF69);
  }

  level._id_866880EFF524A58D.instance = instance;
}

_id_0D17A3CE89DB4D69(_id_4930CBCE302555B1, param) {
  instance = level._id_866880EFF524A58D.instance;
  level._id_866880EFF524A58D._id_9AD08BFF0BD94583++;

  if(isDefined(instance.lock))
    instance.lock setscriptablepartstate("base", scripts\engine\utility::string(level._id_866880EFF524A58D._id_9AD08BFF0BD94583));

  if(level._id_866880EFF524A58D._id_9AD08BFF0BD94583 == level._id_866880EFF524A58D._id_26B0E4F14D4C062E.size)
    _id_980A29075F57F794(instance);
}

_id_F937273983AA99D1(targetname, origin, angles, _id_E64D8419218C64E6) {
  ent = getEnt(targetname, "targetname");

  if(!isDefined(ent)) {
    return;
  }
  if(isDefined(_id_E64D8419218C64E6) && _id_E64D8419218C64E6.size > 0) {
    foreach(_id_CDD12878F51B4791 in _id_E64D8419218C64E6)
    _id_CDD12878F51B4791 linkTo(ent);
  }

  ent.origin = origin;
  ent.angles = angles;
  return ent;
}

_id_8AFA5E7534783519(name, origin, angles) {
  door = spawnscriptable("emergency_supply_door", origin, angles);
  door setscriptablepartstate("base", "door_" + name);
  door.name = name;
  door.collision = _id_F937273983AA99D1("emergency_supply_clip_" + door.name, origin, angles);
  return door;
}

_id_02165C6ED07291AA(door, _id_0944B1CC80DD0EED) {
  if(isDefined(door) && isDefined(door.collision)) {
    door setscriptablepartstate("base", "open_" + door.name);
    door.collision rotateYaw(_id_0944B1CC80DD0EED, 3);
  }
}

_id_16769793EB62273A(_id_0F0B26F5F8DB069E, struct) {
  loot = struct;
  loot.id = _id_0F0B26F5F8DB069E;
  self.rewards = scripts\engine\utility::array_add(self.rewards, loot);
}

_id_0F2ABB0644955274(_id_7957AE38C168F3DF, origin, angles) {
  count = _id_7D625073C6379D53::getitemcount(_id_7957AE38C168F3DF);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);
  scriptable._id_BBC200BC77C5DB2B = 1;
}

_id_980A29075F57F794(instance) {
  foreach(reward in instance.rewards)
  _id_0F2ABB0644955274(reward.id, reward.origin, reward.angles);

  instance setscriptablepartstate("base", "open");
  _id_02165C6ED07291AA(instance._id_5EBF7325BB8C6E68, -120);
  _id_02165C6ED07291AA(instance._id_5EEB6125BBBCAD38, 120);
  dlog_recordevent("dlog_event_emergency_supply_crate", ["game_time", gettime()]);
}

_id_5B86F42674175045() {
  if(getdvarint("dvar_0A5F945BD6ABF184", 1) == 1) {
    level waittill("scriptables_ready");
    ents = getentitylessscriptablearray("delta_ee_music", "targetname");
    level waittill("prematch_fade_done");

    foreach(ent in ents)
    ent setscriptablepartstate("base", "active");
  }
}

_id_C504E6D76156FB46() {
  _id_BBA135E6451071CC = getdvarint("dvar_096F7CCFBC0BA39B", 1);
  _id_9711CBC905B1CBE7 = _id_756F28F5B5040736();
  level waittill("scriptables_ready");
  thread _id_00E53B8BB3D279F3(_id_BBA135E6451071CC, _id_9711CBC905B1CBE7);

  if(!istrue(_id_BBA135E6451071CC)) {
    return;
  }
  thread _id_F79457459CECD96B();
  _id_36836F71F41CC020 = getentitylessscriptablearray("de_townhouse_armory_01_door", "targetname");
  door = _id_36836F71F41CC020[0];
  door scriptabledoorfreeze();
  _id_3C862FB9B02C9BCB = door.origin + (45, 20, 38);
  _id_8126DC86D8D830EE = door.origin + (50, 10, 38);
  _id_C3F087E78644BC98 = scripts\mp\gameobjects::createhintobject(_id_3C862FB9B02C9BCB, "HINT_BUTTON", undefined, &"MP_DMZ_LOCKS/UNSTUCK_DOOR", undefined, "duration_short", undefined, 150, 160, 75, 160);
  _id_C3F087E78644BC98.angles = door.angles;
  _id_F3F98BF8C305AC99 = scripts\mp\gameobjects::createhintobject(_id_8126DC86D8D830EE, "HINT_NOICON", undefined, &"MP_DMZ_LOCKS/STUCK", undefined, "duration_short", undefined, 150, 160, 75, 160);
  _id_F3F98BF8C305AC99.angles = door.angles;
  thread _id_E675CC32A3FB8FED(_id_F3F98BF8C305AC99);
  _id_C3F087E78644BC98 waittill("trigger");
  _id_BD91DEE9E8E1EB1D(door, _id_C3F087E78644BC98, _id_F3F98BF8C305AC99);
}

_id_E675CC32A3FB8FED(_id_F3F98BF8C305AC99) {
  level endon("delta_ee_armory_door_unstuck");

  for(;;) {
    _id_F3F98BF8C305AC99 waittill("trigger");
    playsoundatpos(_id_F3F98BF8C305AC99.origin, "mp_door_locked");
    waitframe();
  }
}

_id_BD91DEE9E8E1EB1D(door, _id_C3F087E78644BC98, _id_F3F98BF8C305AC99) {
  level notify("delta_ee_armory_door_unstuck");
  playsoundatpos(_id_C3F087E78644BC98.origin, "mp_door_unlock_deadbolt");
  _id_C3F087E78644BC98 delete();
  _id_F3F98BF8C305AC99 delete();
  door scriptabledoorfreeze(0);
}

_id_756F28F5B5040736() {
  _id_FD53C9FFDFF55373 = scripts\engine\utility::getStructArray("ee_armory_lootcrates", "targetname");
  _id_9711CBC905B1CBE7 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD53C9FFDFF55373.size; _id_AC0E594AC96AA3A8++) {
    _id_9711CBC905B1CBE7[_id_AC0E594AC96AA3A8] = spawnStruct();
    _id_9711CBC905B1CBE7[_id_AC0E594AC96AA3A8].origin = _id_FD53C9FFDFF55373[_id_AC0E594AC96AA3A8].origin;
    _id_9711CBC905B1CBE7[_id_AC0E594AC96AA3A8].angles = _id_FD53C9FFDFF55373[_id_AC0E594AC96AA3A8].angles;
  }

  _id_9711CBC905B1CBE7 = scripts\engine\utility::array_randomize(_id_9711CBC905B1CBE7);
  return _id_9711CBC905B1CBE7;
}

_id_00E53B8BB3D279F3(_id_05B0755AC7410573, _id_9711CBC905B1CBE7) {
  _id_3FB652D72C34A9A3 = scripts\engine\utility::ter_op(_id_05B0755AC7410573, getdvarint("dvar_FFC70B43865234E1", 2), 0);
  _id_B565E17C8E10168B = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9711CBC905B1CBE7.size; _id_AC0E594AC96AA3A8++) {
    type = "br_loot_cache";

    if(istrue(_id_05B0755AC7410573) && _id_3FB652D72C34A9A3 > 0) {
      if(_id_B565E17C8E10168B < _id_3FB652D72C34A9A3) {
        type = "br_loot_cache_lege";
        _id_B565E17C8E10168B++;
      }
    }

    scriptable = spawnscriptable(type, _id_9711CBC905B1CBE7[_id_AC0E594AC96AA3A8].origin, _id_9711CBC905B1CBE7[_id_AC0E594AC96AA3A8].angles);
    initialstate = undefined;

    if(scriptable getscriptableisloot())
      initialstate = _func_6F817B71C98D6307(_func_40FD49171FAD19D3(type));

    _id_C45009692B29CC64 = isDefined(initialstate) && initialstate == "enum_5DAB1D36DF0BE973";

    if(!_id_C45009692B29CC64 && scriptable getscriptablehaspart("body") && scriptable getscriptableparthasstate("body", "closed_usable_no_collision"))
      scriptable setscriptablepartstate("body", "closed_usable_no_collision");
    else if(isDefined(initialstate) && scriptable getscriptablehaspart("body") && scriptable getscriptableparthasstate("body", initialstate))
      scriptable setscriptablepartstate("body", initialstate);

    waitframe();
  }
}

_id_F79457459CECD96B() {
  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz") {
    level waittill("activitymanager_initActivityStarters_done");

    foreach(_id_5EA1BE154AEB609B in level._id_1B7407DFFE81E6E8._id_0915F0D3C3A61E38) {
      if(_id_5EA1BE154AEB609B _id_E17A1C04ED0AF4A8())
        _id_5EA1BE154AEB609B _id_03314ADD7998AB13::_id_66DA9365BBFEA8B7();
    }
  } else {
    level waittill("contractmanager_inittablets_done");

    foreach(type in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
      if(type.enabled) {
        _id_E0D1E3A2B6F5323A = getlootscriptablearray(type._id_A0CE8000D303764C);

        foreach(tablet in _id_E0D1E3A2B6F5323A) {
          if(tablet _id_E17A1C04ED0AF4A8())
            tablet _id_64ACB6CE534155B7::tablethide();
        }
      }
    }
  }
}

_id_E17A1C04ED0AF4A8() {
  return distance2d(self.origin, (-3113, -3113, 105)) <= 440;
}

_id_AE2EA71315FC286A() {
  if(!getdvarint("dvar_49B260F10E1C523C", 1)) {
    return;
  }
  level._id_DE491B1A94DE1867 = 0;
  level waittill("scriptables_ready");
  _id_4FC822BAE001EB49 = _id_60BCED60522D5E8A();

  if(!isDefined(_id_4FC822BAE001EB49) || _id_4FC822BAE001EB49.size == 0) {
    return;
  }
  _id_062839FFFDDB6240 = getdvarint("dvar_0FE8F85420BE08C2", 0) && getdvarint("scr_ssc_enabled", 0);

  if(_id_062839FFFDDB6240) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("cash_machine", ::_id_60BCED60522D5E8A);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("cash_machine", ::_id_83636311927C64B0);
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_E66EF7221285F187);

  if(_id_062839FFFDDB6240) {
    _id_4FC822BAE001EB49 = level._id_19980992B3216145;
    level._id_19980992B3216145 = undefined;
  }

  level._id_BC92D2AEE5F9E470 = getdvarint("dvar_351A2FA044D79856", 30);

  foreach(site in _id_4FC822BAE001EB49)
  site setscriptablepartstate("alive", "electronics_atm_health_reactive");
}

_id_E66EF7221285F187(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !isDefined(instance.classname) || instance.classname != "scriptable_electronics_atm_machine_delta" && instance.classname != "scriptable_ee_appliance_vending_machine_soda_delta") {
    return;
  }
  forward = anglesToForward(instance.angles);
  heightoffset = _id_735B71BE412CFCEC(instance.classname);
  offset = (forward[0] * 15, forward[1] * 15, heightoffset);
  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4.origin = instance.origin + offset;
  _id_CB4FAD49263E20C4.angles = instance.angles;
  _id_CB4FAD49263E20C4.itemsdropped = 0;
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  index = level._id_DE491B1A94DE1867 % 30;
  level._id_DE491B1A94DE1867++;
  _id_75EA56AC509FED3B = getscriptcachecontents("br_cash_machine", index);
  waittillframeend;
  _id_E05413A53B5D9167 = _id_CB4FAD49263E20C4 _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, _id_75EA56AC509FED3B, 0, eattacker);
  _id_61768E9727FFADEE = _id_C4DD059A420CC41A(instance.classname);

  if(isDefined(eattacker) && isDefined(_id_61768E9727FFADEE))
    eattacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_61768E9727FFADEE);

  instance thread _id_3A4CB4E213CB6C99();
}

_id_C4DD059A420CC41A(_id_D0AE90C45FA6124D) {
  switch (_id_D0AE90C45FA6124D) {
    case "scriptable_electronics_atm_machine_delta":
      return "br_cash_machine_atm";
    case "scriptable_ee_appliance_vending_machine_soda_delta":
      return "br_cash_machine_vending_machine";
    default:
      break;
  }
}

_id_735B71BE412CFCEC(_id_D0AE90C45FA6124D) {
  switch (_id_D0AE90C45FA6124D) {
    case "scriptable_electronics_atm_machine_delta":
      return 10;
    case "scriptable_ee_appliance_vending_machine_soda_delta":
      return -20;
    default:
      return 0;
  }
}

_id_3A4CB4E213CB6C99() {
  level endon("game_ended");

  if(!isDefined(level._id_BC92D2AEE5F9E470) || level._id_BC92D2AEE5F9E470 < 0) {
    return;
  }
  wait(level._id_BC92D2AEE5F9E470);
  self setscriptablepartstate("alive", "electronics_atm_health_reactive");
}

_id_60BCED60522D5E8A() {
  _id_306AD3046011E82B = getentitylessscriptablearray("ee_cash_machine", "script_noteworthy");
  return _id_306AD3046011E82B;
}

_id_83636311927C64B0(_id_231C417A04405C5F) {
  if(!isDefined(level._id_19980992B3216145))
    level._id_19980992B3216145 = [];

  level._id_19980992B3216145[level._id_19980992B3216145.size] = _id_231C417A04405C5F;
  return _id_231C417A04405C5F;
}