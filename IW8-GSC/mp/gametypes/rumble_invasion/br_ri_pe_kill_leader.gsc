/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_pe_kill_leader.gsc
*****************************************************************/

init() {
  level.start_reach_exhaust_waste.verbal_clip = spawnStruct();
  level.start_reach_exhaust_waste.verbal_clip.active = 0;
  level.start_reach_exhaust_waste.verbal_clip.duration = getdvarint("_encstr_8FC11FBB0F58191B6336E3BA1E4AAF0D408F2C35A350DF53AF498BD3211DE78508", 120);
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_97551D93CF631781B251D307800BE3F993DF1C951933D576470B13A877DB2B", 1.0);
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0._id_11B78 = getdvarint("_encstr_A3A120DB6ECA418EE3B731139F5A43607CC9A091160458BE69070B1187539B200D5A", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_8BC00C0BB3637D1759D96AC221AE", "_encstr_BEC4276A7866BEA0F6D69E1052694159C2C176D16A0621BE17F9FE120899D969D169B11FAA6A21FA08");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(100, var_0);
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
  var_0 = getdvarfloat("_encstr_8EED2427A322418E1759AB316127CB107D0791F3490F28D6A7F323B95BB37D6055956F6BF9F5", 795);
  var_1 = getdvarfloat("_encstr_93ED2467B0E3EF936B10DA9778377A9488E993A748D90D5B2F1EA38ED6E16329F050E70FD0F2", 1110);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

attackerswaittime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(level.start_reach_exhaust_waste.verbal_clip.inited)) {
    level.start_reach_exhaust_waste.verbal_clip _id_12AF3();
    level.start_reach_exhaust_waste.verbal_clip.inited = 1;
  }

  if(getdvarint("_encstr_85981DC399CE876248B76373F3A8E1D774F18A3B6624379C784F7C49E378B2", 0) == 0) {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_83120D78E83507A3580E189AAB503F", 0);
    _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_A2D62426867FE3A126504F9FB0D86CCAA7116F1E65A35BCF09084753A0F651B2B738F594D8DF");
    wait 20;
  }

  level.start_reach_exhaust_waste.verbal_clip.active = 1;
  level.start_reach_exhaust_waste.verbal_clip._id_13009 = [];
  level.start_reach_exhaust_waste.verbal_clip _id_12338();
  wait 3.0;
  level.start_reach_exhaust_waste.verbal_clip thread _id_13EF0();
  level.start_reach_exhaust_waste.verbal_clip thread oceanrock();
}

onriskplayerdisconnect(var_0, var_1) {
  if(!isDefined(level.start_reach_exhaust_waste.verbal_clip._id_13009)) {
    return;
  }
  var_2 = 500;
  var_3 = undefined;

  foreach(var_5 in level.start_reach_exhaust_waste.verbal_clip._id_13009) {
    if(var_5.team == var_0.team && var_5 != var_0) {
      var_6 = distance2d(var_5.origin, var_1.origin) < var_2;
      var_7 = abs(var_5.origin[2] - var_1.origin[2]) < 500;
      var_8 = var_6 && var_7;
      var_9 = distance2d(var_5.origin, var_1.origin) < var_2;
      var_10 = abs(var_5.origin[2] - var_1.origin[2]) < 500;
      var_11 = var_9 && var_10;

      if(var_8 || var_11) {
        var_0 thread scripts\mp\rank::giverankxp("_encstr_ADC117128B08FEDBDD9EFAE3033833F78803B68C4750448371", int(50), var_0 getcurrentprimaryweapon());
        var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_ADC117128B08FEDBDD9EFAE3033833F78803B68C4750448371");
        break;
      }
    }
  }
}

oceanrock() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BFF0A32ABD5D37389B3EEEC");
  var_0 = gettime() + (level.start_reach_exhaust_waste.verbal_clip.duration - 3.0) * 1000;
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_1 hide();
  level.start_reach_exhaust_waste.verbal_clip.heli_arrived = var_1;
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 3);
  setomnvar("_encstr_974F15AEB4D783BAC4B1A56C563B95B947BE1DB4D6CAC9", var_0);
  wait(level.start_reach_exhaust_waste.verbal_clip.duration - 5 - 3.0);

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 playSound("_encstr_97D316BFD0B1F9B899E0E888AB198A9E8C176F7363585D5B");
    wait 1.0;
  }

  level.start_reach_exhaust_waste.verbal_clip thread obj_room_fire_10();
}

obj_room_fire_10(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.start_reach_exhaust_waste.verbal_clip.active = 0;

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  if(!isDefined(var_0))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(level.start_reach_exhaust_waste.verbal_clip.heli_arrived))
    level.start_reach_exhaust_waste.verbal_clip.heli_arrived delete();

  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 0);
  var_2 = obj_tugofwar_drain_speed();
  var_3 = "_encstr_99132F562DC94E29C717EF39F88779839169950F716FE3A88524A1ED70AF5F4B17AFF0EE73A92AFEC3F0354115EA28AF74";
  var_4 = var_0 == "_encstr_AA620F0D67D1FAA39558DA7DDD5AE02B23" && var_2 != "_encstr_B85C0AD87B9B8E95CD8E2B46";

  foreach(var_6 in level.players) {
    if(var_4) {
      if(var_6.team == var_2) {
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_87CE15A1D9E8FA168D8DD7B273CAD6D2B2B9F523EDEEB9", var_6, 0);
        var_3 = "_encstr_964E36314EFA39B4F583CAD7AD5AC663BE1B5916462B9CD7ACCE5973D1F5599B91EB560B9C8DBCD7B2B1D25BD273853A5646D795732BD6CB";
      } else {
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_97F918A13B8EFA0BD863BE33C9B459E6191B96B2DCAF237BBBDC", var_6, 0);
        var_3 = "_encstr_93B335B863F7EB73698A3D28A4E2B1D00FF318288365A367923325487BB9FBD89CA79090B3341AAFBADD2BC114C23B43C5E3B91853DC52";
      }
    }

    _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_12425(var_6, var_3);
  }

  level.start_reach_exhaust_waste obj_vindia();
  _id_13EE6();
  level.start_reach_exhaust_waste.verbal_clip._id_13009 = [];
  self notify("_encstr_8BFF0A32ABD5D37389B3EEEC");
}

obj_room_fire_07() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["_encstr_8E8405EA382B2A"];
  var_2 = var_0["_encstr_9A8507BA4040188D08"];

  if(var_1 == 0 || var_2 == 0 || level.start_reach_exhaust_waste.verbal_clip._id_13009.size == 0) {
    var_3 = 0;
    var_4 = undefined;
    level.start_reach_exhaust_waste.verbal_clip thread obj_room_fire_10("_encstr_AA620F0D67D1FAA39558DA7DDD5AE02B23", 2.0);
  }
}

obj_running_exfil_wave() {
  var_0 = 0;
  var_1 = 0;
  var_2 = [];
  var_2["_encstr_8E8405EA382B2A"] = 0;
  var_2["_encstr_9A8507BA4040188D08"] = 0;

  foreach(var_4 in level.start_reach_exhaust_waste.verbal_clip._id_13009) {
    switch (var_4.team) {
      case "_encstr_8E8405EA382B2A":
        var_2["_encstr_8E8405EA382B2A"]++;
        break;
      case "_encstr_9A8507BA4040188D08":
        var_2["_encstr_9A8507BA4040188D08"]++;
        break;
    }
  }

  return var_2;
}

obj_tugofwar_drain_speed() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["_encstr_8E8405EA382B2A"];
  var_2 = var_0["_encstr_9A8507BA4040188D08"];

  if(var_1 == var_2)
    return "_encstr_B85C0AD87B9B8E95CD8E2B46";

  return scripts\engine\utility::ter_op(var_1 > var_2, "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
}

obj_vindia() {
  foreach(var_1 in level.start_reach_exhaust_waste.verbal_clip._id_13009) {
    var_1 _id_12BD8();
    var_1 _id_12BD7();
    var_1.verbal_string.trial_thermite_watcher = 0;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1.team, 5, 0);
    var_1 thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(50);
    var_1 thread objectivetext();
  }
}

objectivetext() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 4;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BED20DF35B837FD3CD7B18E843F509", self, 0);
  _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_12425(self, "_encstr_99132B562DC94E29C717EF39F88779839169950F716FE3A88524A1ED70AFDA279294902B02ADEE1BCC80F06302", 5);
  thread scripts\mp\rank::giverankxp("_encstr_A58514831B9583FDC8E9D10505AF8898E8A497EB5F06", 250, self getcurrentprimaryweapon());
  thread scripts\mp\rank::scoreeventpopup("_encstr_A58514831B9583FDC8E9D10505AF8898E8A497EB5F06");
}

_id_13EF0() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["_encstr_8E8405EA382B2A"];
  var_2 = var_0["_encstr_9A8507BA4040188D08"];

  foreach(var_4 in level.players) {
    if(isDefined(var_4)) {
      switch (var_4.team) {
        case "_encstr_8E8405EA382B2A":
          var_5 = scripts\engine\utility::string(var_1) + scripts\engine\utility::string(var_2) + scripts\engine\utility::string(1);
          var_4 setclientomnvar("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017", int(var_5));
          break;
        case "_encstr_9A8507BA4040188D08":
          var_5 = scripts\engine\utility::string(var_2) + scripts\engine\utility::string(var_1) + scripts\engine\utility::string(1);
          var_4 setclientomnvar("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017", int(var_5));
          break;
      }
    }
  }
}

_id_13EE6() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1 setclientomnvar("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017", 0);
  }
}

_id_13F9A(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.start_reach_exhaust_waste.verbal_clip._id_13009) {
    switch (var_4.team) {
      case "_encstr_8E8405EA382B2A":
        var_1++;
        break;
      case "_encstr_9A8507BA4040188D08":
        var_2++;
        break;
    }
  }

  var_6 = [];
  var_6["_encstr_8E8405EA382B2A"] = var_1;
  var_6["_encstr_9A8507BA4040188D08"] = var_2;
  var_7 = var_6[self.team];
  var_8 = var_6[scripts\engine\utility::get_enemy_team(self.team)];
  var_9 = scripts\engine\utility::string(var_7) + scripts\engine\utility::string(var_8) + scripts\engine\utility::string(1);
  self setclientomnvar("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017", int(var_9));
}

_id_12AF1(var_0) {
  if(!isDefined(var_0.verbal_string)) {
    var_1 = spawnStruct();
    var_1.trial_thermite_watcher = 0;
    var_1._id_11F64 = undefined;
    var_0.verbal_string = var_1;
  }
}

_id_12AF3() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      _id_12AF1(var_1);
  }
}

_id_11FF1(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !isDefined(level.start_reach_exhaust_waste.verbal_clip) || !isDefined(level.start_reach_exhaust_waste.verbal_clip.inited) || !level.start_reach_exhaust_waste.verbal_clip.active) {
    return;
  }
  if(scripts\engine\utility::array_contains(level.start_reach_exhaust_waste.verbal_clip._id_13009, var_1)) {
    var_3 = isDefined(var_2) && (var_2 == "_encstr_AB590C99ED78875F650F3951034D" || var_2 == "_encstr_87A10C9D24E997A01F21838F3D34");
    var_1 cheeselocs(var_0, var_3);
    var_1 _id_12BD7();
    var_1 _id_12BD8();
    playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), var_1.origin);
    playsoundatpos(var_1.origin, "_encstr_B837198B90EE7B0BC9A7C23C80D5D220B640CB2FF080AEC2014D0F");

    if(level.start_reach_exhaust_waste.verbal_clip._id_13009.size > 1)
      level.start_reach_exhaust_waste.verbal_clip thread _id_12C41(var_1);

    var_1.verbal_string.trial_thermite_watcher = 0;
    level.start_reach_exhaust_waste.verbal_clip._id_13009 = scripts\engine\utility::array_remove(level.start_reach_exhaust_waste.verbal_clip._id_13009, var_1);

    foreach(var_5 in level.players)
    var_5 _id_13F9A(var_1);
  }

  obj_room_fire_07();
}

_id_12C41(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.start_reach_exhaust_waste.verbal_clip.vfx_struct))
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;

  if(!level.start_reach_exhaust_waste.verbal_clip.vfx_struct) {
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 1;
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_819D12793E3B468C0362BDC03D0113A99DD2CFA0", var_0.team);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_835B0F98CB0389832272C52F919D20AF20", scripts\engine\utility::get_enemy_team(var_0.team));
    wait 8.0;
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;
  }
}

cheeselocs(var_0, var_1) {
  var_2 = scripts\engine\utility::get_enemy_team(self.team);
  var_3 = 4;
  var_4 = 25;

  if(istrue(var_1)) {
    var_3 = var_3 + 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_2, var_3, 0);
    return;
  }

  if(isDefined(var_0) && istrue(var_0._id_12827)) {
    var_3 = var_3 * 2;
    var_4 = var_4 * 2;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var_2, var_3, 0);

  if(isDefined(var_0) && isPlayer(var_0))
    var_0 thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_4);
}

_id_12338() {
  var_0 = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08"];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");
    var_4 = 0;
    var_5 = [];

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_7 = undefined;
      var_8 = 0;

      foreach(var_10 in var_3) {
        if(!isDefined(var_10) || !scripts\mp\utility\player::isreallyalive(var_10) || istrue(var_10.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var_5, var_10.squadindex)) {
          continue;
        }
        if(var_10.pers["_encstr_8E8D0697EB01F243"] > var_8) {
          var_7 = var_10;
          var_8 = var_10.pers["_encstr_8E8D0697EB01F243"];
        }
      }

      if(isDefined(var_7)) {
        var_7 _id_11A91();
        var_5[var_5.size] = var_7.squadindex;
        var_4++;
        continue;
      }

      break;
    }

    var_12 = 5 - var_4;

    for(var_6 = 0; var_6 < var_12; var_6++) {
      var_3 = scripts\engine\utility::array_randomize(var_3);
      var_7 = undefined;

      foreach(var_14 in var_3) {
        if(istrue(var_14.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var_5, var_14.squadindex) || !scripts\mp\utility\player::isreallyalive(var_14)) {
          continue;
        }
        var_7 = var_14;
      }

      if(isDefined(var_7)) {
        var_7 _id_11A91();
        var_5[var_5.size] = var_7.squadindex;
        var_4++;
        continue;
      }

      break;
    }
  }

  foreach(var_10 in level.players) {
    if(!istrue(var_10.verbal_string.trial_thermite_watcher)) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8D7F0CC8A3131020ABD14D49FD97", var_10, 0);
      var_10 thread scripts\mp\hud_message::showsplash("_encstr_BE2B2B3A6EBE9B14F7C06AC170F30DBB16D985B18D015351BBE812CAB047021389BE1C17976B9FA473730B7268");
    }
  }
}

_id_11A91() {
  self.verbal_string.trial_thermite_watcher = 1;
  level.start_reach_exhaust_waste.verbal_clip._id_13009 = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.verbal_clip._id_13009, self);
  thread _id_1357A();
  thread _id_13F9E();
  thread scripts\mp\hud_message::showsplash("_encstr_A37B2B4B25109BD149A3FF49F8C0ECB2C881DFBFE1A523AFF00BF70DF3993B6BBF1503CF53D6B95C08936FD7EB");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B4860B135D9559C008508BD709", self, 0, 0);
}

_id_13F9E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 8;
  self.verbal_string._id_11C3E = [];
  self.verbal_string._id_11C3E[0] = spawnStruct();
  self.verbal_string._id_11C3E[1] = spawnStruct();
  self.verbal_string._id_11C3E[0] _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(3, 5, 0, self.origin);
  self.verbal_string._id_11C3E[1] _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(1, 5, 0, self.origin);
  var_0 = scripts\engine\utility::get_enemy_team(self.team);
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in level.players) {
    var_4 = self.team == var_3.team;
    self.verbal_string._id_11C3E[scripts\engine\utility::ter_op(var_4, 0, 1)] _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_3);
  }

  if(isDefined(self.verbal_string._id_11C3E[0]))
    self.verbal_string._id_11C3E[0] thread _id_13F9D(self);

  if(isDefined(self.verbal_string._id_11C3E[1]))
    self.verbal_string._id_11C3E[1] thread _id_13F9D(self, 8);
}

_id_13F9D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(!isDefined(var_0) || !isalive(var_0) || !isDefined(self.mapcircle)) {
      break;
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(0);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_0.origin);

    if(isDefined(var_1)) {
      wait(var_1);
      continue;
    }

    waitframe();
  }

  var_0 _id_12BD8();
}

_id_12BD8() {
  if(!isDefined(self.verbal_string._id_11C3E) || !isDefined(self.verbal_string._id_11C3E[0]) || !isDefined(self.verbal_string._id_11C3E[1])) {
    return;
  }
  foreach(var_2, var_1 in self.verbal_string._id_11C3E) {
    if(isDefined(var_1)) {
      var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
      self.verbal_string._id_11C3E[var_2] = undefined;
    }
  }
}

_id_1357A() {
  if(isDefined(self.verbal_string._id_11F64)) {
    return;
  }
  var_0 = "_encstr_B2CB25F390919D68598B42AF92013BA191428DB7F95E3AB08F7889D5CD57A102A1B11D5251DD5B";
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_position(var_1, self.origin + (0, 0, 100));
  objective_setplayintro(var_1, 0);
  objective_setshowoncompass(var_1, 0);
  objective_setshowdistance(var_1, 0);
  getbnetigrbattlepassxpmultiplier(var_1, 0, 1150);
  getscriptcachecontents(var_1, 0.2, 0.3);
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 100);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  var_2 = scripts\engine\utility::get_enemy_team(self.team);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 6);

  if(!isDefined(self.verbal_string._id_11F64))
    self.verbal_string._id_11F64 = [];

  self.verbal_string._id_11F64[self.verbal_string._id_11F64.size] = var_1;
}

_id_12BD7() {
  if(!isDefined(self.verbal_string._id_11F64)) {
    return;
  }
  foreach(var_1 in self.verbal_string._id_11F64)
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(var_1);

  self.verbal_string._id_11F64 = undefined;
}