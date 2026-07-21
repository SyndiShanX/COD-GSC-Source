/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_wz_island\mp_wz_island_util.gsc
******************************************************/

_id_1326B() {
  var_0 = spawnStruct();
  var_0.playbattlechattersoundexpensive = getdvarint("_encstr_8E232ACD6C4EF5371A85361B7BDDF5DD858EB239BE33B4C956F52BF0D14B73CEBA4B6E86BEB2CD2C4CD895C8", 1);
  var_0.playdeathsoundph = getdvarint("_encstr_A3532596F60B974B489F7068BF8F060FC2DB059E41E2A3132D4F806857BB19272AC58F2EE58A71", 1);
  var_0._id_12ABC = getdvarint("_encstr_96B5306E1B4EBEE643583636DBEEFAEE161DCA397D93B28C5D1B5923EB8DB2470D58D8AF912C6B85B32BAF2BB9C298C62B23", 1);
  var_0._id_12ABD = getdvarfloat("_encstr_A25F33A802AA8753E32979610FB79E6FD6DB802839423B89CF53F56D27230121FC1240B922DE73E16F7D90D1E50B6BC322AAD0E0DB", 0.5);
  var_0._id_11EB8 = getdvarint("_encstr_B2342A8337602137CB29CAD2F09C4FE340B10D0A37E87503EEEDE24ADE74D79D081B85739F68FD0F9E58AA62", 1);
  var_0._id_13C4D = getdvarint("_encstr_BD7D2F16114E3796FA7E49502568AE1F6B7481C646983BE2F0B8CBDD574608D928AF75A0ABE33878C497A273719E6BEDAC", 1);
  var_0.helis_assault2 = getdvarint("_encstr_AC5C274F4746890B30417D45B8F01F4397F19F33576632DCB86EF64DD0586CBAFD0F07CB931ECA8DE0", 1);
  var_0.watch_for_owner_disconnect = getdvarint("_encstr_937530180FF2969FF23651698D3BFFDB49CB206897B4E957DB51D66D66C2C106A73730589B6F63035283D8FDBDEA15281DDB", 1);
  var_1 = spawnStruct();
  var_1.getheliflyheight = ::getquickdropammotype;
  var_1.gethelinextgroupafterwait = ::getquickdroparmorcount;
  var_1.make_control_station_interaction = ::maxtagradius;
  var_1.removelinkdamagemodifieronlaststand = ::roof_enemy_groups;
  var_1.lowpopallowtweaks = ::maxrangesq;
  var_1.setupbobbingboatmultiple = ::setuphunters;
  var_1.setupmission = ::setupinfectedairdroppositions;
  var_1.module_unpause_funcs = var_0;
  level._id_132A4 = var_1;
  level.playerdatafield = ::update_spot_limit;
  level.playerconnectwatcher = ::unset_relic_vampire;
  level.playercleanupinfilondisconnect = ::move_player_from_under_heli_and_kill;
  level.playercleargulagomnvars = ::move_window_light;
  level.playerexitcombatarea = ::_id_126D4;
  level.playerexecutionsenable = ::_id_126D3;

  if(getdvarint("_encstr_9762260BBFE8A94FB3A1525A4814C71BD8099572AF88EADFF0FBAB3251646792D1A507E443A0B7DF", 1))
    level thread throwingknifemelee();

  if(istrue(level._id_132A4.module_unpause_funcs._id_11EB8))
    level thread throwingknife_fire_clear_fx();

  level thread getlootteamleader();
  _id_1326C();
}

_id_1326C() {
  level._effect["_encstr_8F77168250503492F8A73FE7F31D4A62F9583DCD2810CFEB"] = loadfx("_encstr_A38E320381480F924F8A57087D57EBA6795FD583862773B521D39DB3B102118DDF837880FA18CF73912F59987A3BA06377DB5F4E");
  level._effect["_encstr_AA0F174873B1401132631814FEDB5BCB27BB1860F34538E9BA"] = loadfx("_encstr_ADB233DEE0E0C28B970AB1E1C38E09DB28BF92483789EA730F787263D161E79B90E1227848CBAD6967588E39498A5FCF17985B48AD");
}

throwingknifemelee() {
  level._id_132A5 = [];
  var_0 = getEntArray("_encstr_87FF14A383FC674127CA0668A75F6B3B62F940586A17", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    level._id_132A5[var_1] = var_2;
    level._id_132A5[var_1].occupants = [];
    var_3 = var_2.origin[2];

    if(isDefined(var_2.target)) {
      var_4 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_4))
        var_3 = var_4.origin[2];
    }

    level._id_132A5[var_1]._id_14513 = var_3;
    scripts\mp\utility\trigger::makeenterexittrigger(var_2, ::_id_132A0, ::_id_132A3);
  }

  level thread _id_1329F();
}

throwingknife_fire_clear_fx() {
  level._id_11EB7 = [];
  level._id_11EB7 = getEntArray("_encstr_AFFB1F939B634707C80DAF95EB680B8717B01AA983CF43FF286F9B68DB5055D73C", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_1 in level._id_11EB7)
  scripts\mp\utility\trigger::makeenterexittrigger(var_1, ::nuke_vault_oilfire_player_vision, ::onprematchfadedone);
}

nuke_vault_oilfire_player_vision(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  var_0.unset_relic_vampire = 1;

  if(isDefined(var_0.vehicle)) {
    return;
  }
  var_0 _id_126D4();
}

onprematchfadedone(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  var_0 notify("_encstr_BE5E15652894B3725FA793D96340F952D77774E048A863");
  var_0.unset_relic_vampire = undefined;

  if(isDefined(var_0.vehicle)) {
    return;
  }
  var_0 _id_126D3();
}

_id_126D4() {
  var_0 = self;

  if(istrue(var_0.inlaststand))
    var_0 move_player_from_under_heli_and_kill(1);

  var_0 move_window_light(0);

  if(!isbot(var_0)) {
    var_0 thread _id_144CC();
    var_0 notifyonplayercommand("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_A75407A4F05EE24E57");
    var_0 notifyonplayercommand("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_B20108A0CF117367C8BB");
    var_0 notifyonplayercommand("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_A38B0C43A0B047C20783E360451D");
    var_0 notifyonplayercommand("_encstr_B1C81BD7824F383329629868CAF1F773F72DD643D73F607F0BFAA03013", "_encstr_A6E308B2DCE8B0B936B2");
    var_0 notifyonplayercommand("_encstr_8D540F6BFFA162723779F037EDF340FA35", "_encstr_AA8B08A1EA73F3E04BB7");
  }
}

_id_126D3() {
  var_0 = self;

  if(istrue(var_0.inlaststand))
    var_0 move_player_from_under_heli_and_kill(0);
  else
    var_0 move_window_light(1);

  if(!isbot(var_0)) {
    var_0 notifyonplayercommandremove("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_A75407A4F05EE24E57");
    var_0 notifyonplayercommandremove("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_B20108A0CF117367C8BB");
    var_0 notifyonplayercommandremove("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_A38B0C43A0B047C20783E360451D");
    var_0 notifyonplayercommandremove("_encstr_B1C81BD7824F383329629868CAF1F773F72DD643D73F607F0BFAA03013", "_encstr_A6E308B2DCE8B0B936B2");
    var_0 notifyonplayercommandremove("_encstr_8D540F6BFFA162723779F037EDF340FA35", "_encstr_AA8B08A1EA73F3E04BB7");
  }
}

_id_144CC() {
  var_0 = self;
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_BE5E15652894B3725FA793D96340F952D77774E048A863");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_143AD("_encstr_87060F60F65AF64FAE8192B04C9933BD5B", "_encstr_B1C81BD7824F383329629868CAF1F773F72DD643D73F607F0BFAA03013");

    if(var_1 == "_encstr_B1C81BD7824F383329629868CAF1F773F72DD643D73F607F0BFAA03013") {
      if(var_0 getstance() != "_encstr_922406F1A6FD5E05") {
        var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_8D540F6BFFA162723779F037EDF340FA35", 0.5);

        if(var_1 == "_encstr_8D540F6BFFA162723779F037EDF340FA35")
          continue;
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AB4E1468D10A532A5EA025F49315D784899E0D2D2A88");
      wait 1;
    }
  }
}

unset_relic_vampire() {
  var_0 = self;

  if(!isPlayer(var_0))
    return 0;

  return istrue(var_0.unset_relic_vampire);
}

_id_1329F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 1;
  var_1 = 100;

  for(;;) {
    var_2 = getdvarfloat("_encstr_AAB418B9369CEBB9D0C21B8DB777EBDD58D12BE4F58C958D2CF2", var_0);
    var_3 = getdvarfloat("_encstr_B41E245780D3FF93791FADA5703F299FD9A087EBC9C8371B4BAE795E6813F254A6F04B3FE061", var_1);

    foreach(var_5 in level._id_132A5) {
      if(var_5.occupants.size == 0) {
        continue;
      }
      if(getdvarint("_encstr_9BB3189B8DE4F56E341636B1BD77FADD588E5693FA232BC45D3B", 0) == 1) {
        var_6 = "_encstr_B40101";

        foreach(var_8 in var_5.occupants) {
          if(!isDefined(var_8)) {
            continue;
          }
          var_6 = var_6 + (var_8.name + "_encstr_B817042077E1");
        }

        allsupportboxes(var_5.origin + "_encstr_81511630C38A6E8F6AABC966FD0ACF80B38DEB68A3A30F09" + var_6 + "_encstr_81F80A2041991A9FBD99BF26" + length(var_5.occupants[0] getvelocity()));
      }

      foreach(var_8 in var_5.occupants) {
        if(!isDefined(var_8)) {
          continue;
        }
        var_11 = var_8 getvelocity();
        var_12 = length(var_11);

        if(var_12 >= var_3)
          var_8 _meth_87D1(int(var_5._id_14513));
      }
    }

    wait(var_2);
  }
}

_id_132A0(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_2 = var_1.occupants.size;
  var_1.occupants[var_2] = var_0;
  allsupportboxes(var_1.origin + "_encstr_AFA31761181294B01EB51A979DEFC938CF87D793A1D2B58E9E" + var_0.name);
}

_id_132A3(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_1.occupants = scripts\engine\utility::array_remove(var_1.occupants, var_0);
  allsupportboxes(var_1.origin + "_encstr_8ED0165622C9759B51890B105FB988772FC0DB907D935A37" + var_0.name);
}

getlootteamleader() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = 0;

    if(!isDefined(level.players))
      level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !isalive(var_2)) {
        continue;
      }
      if(var_0 > getdvarint("_encstr_87BE24F347105147BBB95A62400CBF13D0019D7AA7A825D7DBD1B39B2EE76F8AC99D02F16BF8", 25)) {
        waitframe();
        var_0 = 0;
      }

      if(!isDefined(var_2._id_120AC) && update_restock_ui(var_2))
        _id_132A1(var_2);
      else if(isDefined(var_2._id_120AC) && !update_restock_ui(var_2))
        _id_132A2(var_2);

      var_0++;
    }

    waitframe();
  }
}

_id_1208A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(update_restock_ui(self)) {
    var_0 = self getstance();

    if(!isDefined(self.ui_damage_num_elems) && (var_0 == "_encstr_B13D076BED70539F23" || self issprintsliding()))
      _id_12088();

    if(isDefined(self.ui_damage_num_elems) && var_0 != "_encstr_B13D076BED70539F23" && !self issprintsliding())
      _id_12089();

    waitframe();
  }

  if(isDefined(self.ui_damage_num_elems))
    _id_12089();
}

_id_12088() {
  if(istrue(level._id_132A4.module_unpause_funcs.helis_assault2))
    scripts\mp\utility\perk::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");

  self.ui_damage_num_elems = 1;

  if(istrue(level._id_132A4.module_unpause_funcs.playbattlechattersoundexpensive)) {
    if(scripts\mp\equipment\molotov::molotov_is_burning())
      scripts\mp\equipment\molotov::molotov_clear_burning();
  }
}

_id_12089() {
  if(istrue(level._id_132A4.module_unpause_funcs.helis_assault2))
    scripts\mp\utility\perk::removeperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");

  self.ui_damage_num_elems = undefined;
}

_id_132A1(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(isDefined(var_0._id_120AC))
    var_0._id_120AC++;
  else {
    var_0._id_120AC = 1;

    if(istrue(level._id_132A4.module_unpause_funcs._id_13C4D))
      var_0 scripts\mp\utility\perk::giveperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");

    var_0 thread _id_1208A();
  }
}

_id_132A2(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(isDefined(var_0._id_120AC)) {
    var_0._id_120AC--;

    if(var_0._id_120AC == 0) {
      var_0._id_120AC = undefined;

      if(istrue(level._id_132A4.module_unpause_funcs._id_13C4D) && var_0 hasperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598"))
        var_0 scripts\mp\utility\perk::removeperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");
    }
  }
}

update_restock_ui(var_0) {
  var_1 = 0;

  if(isPlayer(var_0)) {
    var_2 = var_0 _meth_87CB();
    var_1 = var_2 == 49 || var_2 == 50 || var_2 == 51 || var_2 == 21 || _func_0437(var_0.origin);
  } else if(isDefined(var_0.surfacetype)) {
    var_2 = var_0.surfacetype;
    var_1 = var_2 == "_encstr_854C06DD0B8E959C" || var_2 == "_encstr_ACFC0B0B70912FBB86D20E3DFD" || var_2 == "_encstr_AC660CD00A93A3AA9F6355DAC977" || var_2 == "_encstr_8C100D8573F887F37B2557737515DA" || _func_0437(var_0.origin);
  }

  return var_1;
}

maxtagradius(var_0) {
  return level._id_132A4.module_unpause_funcs.playdeathsoundph && update_restock_ui(var_0);
}

setuphunters(var_0) {
  playFX(scripts\engine\utility::getfx("_encstr_8F77168250503492F8A73FE7F31D4A62F9583DCD2810CFEB"), var_0.origin, anglestoup((0, 90, 0)));
  var_0 delete();
}

setupinfectedairdroppositions(var_0) {
  playFX(scripts\engine\utility::getfx("_encstr_AA0F174873B1401132631814FEDB5BCB27BB1860F34538E9BA"), var_0.origin, anglestoup((0, 90, 0)));
  var_0 delete();
}

maxrangesq(var_0) {
  return update_restock_ui(var_0);
}

getquickdropammotype(var_0) {
  return level._id_132A4.module_unpause_funcs.playbattlechattersoundexpensive && istrue(var_0.ui_damage_num_elems);
}

getquickdroparmorcount(var_0) {
  return level._id_132A4.module_unpause_funcs.playbattlechattersoundexpensive && update_restock_ui(var_0);
}

roof_enemy_groups(var_0) {
  if(!level._id_132A4.module_unpause_funcs._id_12ABC || !isDefined(var_0) || !_func_0437(var_0.origin))
    return 1;
  else
    return level._id_132A4.module_unpause_funcs._id_12ABD;
}

_id_1450C() {
  waitframe();
  level.arena_turret_op = getEntArray("_encstr_91A019CD6C4EA5C1E87DD6DE91561BEBEE85479593BEBB0D2B2B36", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(level.arena_turret_op, ::_id_1450D);
}

_id_1450D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 0, -90);
  var_1 = (10, 0, 0);
  var_2 = 0.5;

  if(isDefined(self.script_rotation_amount))
    var_0 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    var_1 = self.script_rotation_speed;

  if(isDefined(self.target)) {
    var_3 = getEnt(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3) && var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
      var_3 linkTo(self);
  }

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);
    wait(var_1[0]);

    if(!cargo_truck_mg_cp_init("_encstr_88171C4F981BFDBB1F1CB4EF0D112192ED588FCB60D03E91A1387DA2C3A3", self))
      return;
  }
}

cargo_truck_mg_cp_init(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  return 1;
}

allsupportboxes(var_0) {
  if(getdvarint("_encstr_9BB3189B8DE4F56E341636B1BD77FADD588E5693FA232BC45D3B", 0) == 1)
    iprintlnbold("_encstr_8F3B10E7BCE3B96D3857EF8BE9A31F4D0A2E" + var_0);
}

_id_14510() {
  level.update2v2progress = getEntArray("_encstr_81691303FA3B557047B909119FAB382B0FF2D92B63", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.update2v2progress) || level.update2v2progress.size == 0) {
    return;
  }
  foreach(var_1 in level.update2v2progress)
  scripts\mp\utility\trigger::makeenterexittrigger(var_1, ::_id_14511, ::_id_14512);
}

_id_14511(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 notify("_encstr_92C410DD2CD1569C99C28D8DFAACCDE82B93");
  var_0 thread _id_12534();

  if(var_0 getscriptablehaspart("_encstr_8B91089C354BCAC65D59") && var_0 getscriptableparthasstate("_encstr_8B91089C354BCAC65D59", "_encstr_930C0C731F59E2CA77880777A028"))
    var_0 setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_930C0C731F59E2CA77880777A028");
}

_id_14512(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(var_0 getscriptablehaspart("_encstr_8B91089C354BCAC65D59"))
    var_0 setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");
}

_id_12534(var_0) {
  var_1 = self;

  if(!isPlayer(var_1)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_92C410DD2CD1569C99C28D8DFAACCDE82B93");
  var_1 waittill("_encstr_AD75063D571AE108");

  if(!isPlayer(var_1)) {
    return;
  }
  if(var_1 getscriptablehaspart("_encstr_8B91089C354BCAC65D59"))
    var_1 setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");
}

update_spot_limit() {
  var_0 = level.mapname;
  return var_0 == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319" || var_0 == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE" || var_0 == "_encstr_8FBF10DA03A0CF88E1C74D4487F8168BD53B" || var_0 == "_encstr_8F340F3992796F28DFDFE808E736C1FF27";
}

move_player_from_under_heli_and_kill(var_0) {
  if(!isDefined(level._id_132A4) || !isDefined(level._id_132A4.module_unpause_funcs) || !level._id_132A4.module_unpause_funcs.watch_for_owner_disconnect) {
    return;
  }
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_1 = self;

  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0 && !var_1 unset_relic_vampire()) {
    return;
  }
  if(var_0) {
    var_1.circleclosing = var_1.operatorcustomization.suit;

    if(!isDefined(var_1.circleclosing))
      var_1.circleclosing = "_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38";

    var_1 setsuit("_encstr_8FBA179AE3136F0D10C75C43D148D5CBC89B92D3098EB74660");
  } else {
    if(!isDefined(var_1.circleclosing)) {
      return;
    }
    var_1 setsuit(var_1.circleclosing);
    var_1.circleclosing = undefined;
  }
}

move_window_light(var_0) {
  var_1 = self;

  if(!var_0 && !var_1 unset_relic_vampire()) {
    return;
  }
  if(var_1 scripts\common\utility::is_prone_allowed() != var_0)
    var_1 scripts\common\utility::allow_prone(var_0);

  if(var_1 scripts\common\utility::is_slide_allowed() != var_0) {
    if(!var_0 && var_1 issprintsliding())
      var_1 setstance("_encstr_B13D076BED70539F23");

    var_1 scripts\common\utility::allow_slide(var_0);
  }
}