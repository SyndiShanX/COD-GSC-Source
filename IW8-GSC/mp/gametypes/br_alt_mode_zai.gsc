/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_zai.gsc
***********************************************/

init() {
  level thread setup_target_anims();

  if(getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) < 1) {
    return;
  }
  level._id_14687 = spawnStruct();
  level._id_14687._id_146DA = getdvarint("_encstr_99C92BE6B14EAF314EEBA7BDB6984B95D7E0D85DDC32CAE47DED377D462BC23A0DFA0BB6BDEA378E7D980BDCAC", 1);
  level._id_14687._id_146DB = getdvarint("_encstr_9B782A325E15019AB3F9E3AF7069596AF76F7D2BB051FAB23E90BB6710E109C3711086A5A8AB82FC46F84FE3", 2);
  level._id_14687._id_146DC = getdvarint("_encstr_855E30CD8DC9BE4C9C7DA7EDB689D2B2F50E1BEA9B199527EBED37EB8C9516E80DEB85B6DBAE371DD7ACE107D8BDDC96B7DC", 2);
  level._id_14687._id_146DD = getdvarint("_encstr_8C782A5A366D79F2DB614B17D8F1A1825FD7E55328F9122A86F823CFE849615BE9F82ECDB7331A54AE501777", 2);
  level._id_14687._id_146DE = getdvarint("_encstr_BA0230CDC693D78939D7F4B76B26B456F507C6AB9B19CA27FADE37EBC8562C3A43D7C2ADB7EA378EAFDDCA0BAD07B7D2CD47", 3);
  level._id_14687._id_146D8 = getdvarint("_encstr_A52B213380A271124E78BA7220F38765C7082875580BF7B6FF4FFD0A75D83119940566", 50);
  level._id_14687._id_145A8 = getdvarint("_encstr_AAD81DBF323BE982523942786060C4510EBB7B11804D093F09F0D573E5C773", 1);
  level._id_14687._id_12377 = getdvarfloat("_encstr_9ABE184BFE5AD11E1347B597E77AD358DF92B060678F4043DAB7", 0.5);
  level._id_14687._id_12378 = getdvarfloat("_encstr_8E5F1DB9C64EFA8993FAD3DE5B135AB2BE075A9B3BD7EEC25AE8EB8ED26B95", 2.5);
  level._id_14687.onuseitem = getdvarfloat("_encstr_8E8A1FF7FF0EC152B8CE80CDA01091BA701B237379384B0128F0F117D9B0A1D235", 35);
  level._id_14687.onusethanksbc = getdvarfloat("_encstr_87912FB91BE47D89E4FA4FEDDA26A5CAAFAC870E36BD37A5BDDCEB9158B5163BCAEBD959A14B36C659D7C1CAE4C6B2E63A", 0.95);
  level._id_14687.mortar_cooldown = getdvarfloat("_encstr_BAB9191F9B6A09DE231192381A4B038049F55B913FD23015B7AB8B", 275);
  level._id_14687.packs = 1;
  level._id_14687._id_146B7 = getdvarint("_encstr_B1B02457D33251966B69DA6052F3DB48812DE5EB7A1DD87013A2D3A87ADB01302993216BE547", 1);
  level._id_14687._id_146B6 = getdvarint("_encstr_87FA25DCC639EBC4937DD3B76B894B56F556E6C23136B2FAD985E4B45898D82BFA869585C61D34", 1);
  level._id_14687._id_146B5 = getdvarint("_encstr_8382250AB9408FEAFE7F530F73AE02ED81C1C51671487DF1D41B0B0F53469A25D989BE9D89B805", 1);
  level._id_14687._id_11A55 = getdvarint("_encstr_AAAC1C70D983FE2905C703C7A3885167577F44B0E96A6310EF20F769BFEF", 15);
  level._id_14687._id_11BDC = getdvarint("_encstr_BDAC1C3656AB37C9F207A010D73A608BC17EA3A8EFF20B91CF078108EF54", 20);
  level._id_14687.spawn_entity_carriable = getdvarint("_encstr_8D681DE66CE4BE134E7DE9EDB689A52BBE162DEB3216DA583B59D7435A3B43", 35);
  level._id_14687._id_146A5 = getdvarfloat("_encstr_BE82234790C3CFB27D30387501055ABD0EF8B7A758DE27BACFB5C7EEF539F1433050C31790", 0.4);
  level._id_14687._id_146A7 = getdvarfloat("_encstr_8C06240BBFE8A90BBE66336A089E1F9F2923826DCFB0E1F7689ECAF291ED53D9309909E66FE0", 0.25);
  level._id_14687._id_146A6 = getdvarint("_encstr_ACED239F9776B92AD0D6A8F588087952582B7FB77B9E42EFF8BE27BAE07087AA295FB7FBC9", 1);
  level._id_14687.open_close_initial = getdvarfloat("_encstr_AC212FAB1EBA31FEF3A7153747DAB3387F7610A6070883A15A0F0B1D9FD189201C4139F9AD793BED711F0F31872AC388A2", 5.0);
  level._id_14687._id_146C7 = 0;
  level._id_14687._id_11AEA = undefined;
  level._id_14687._id_11AE9 = undefined;

  switch (level._id_14687._id_145A8) {
    case 2:
    case 1:
      level._id_14687._id_11AEA = "_encstr_96CA0ACFC9BB28FFB327F30A";
      level._id_14687._id_11AE9 = "_encstr_AD7609B6149AE9EE747FE8";
      break;
    case 3:
      level._id_14687._id_11AEA = "_encstr_8E1B07A0F6E0071D1D";
      level._id_14687._id_11AE9 = "_encstr_B2EE0AF2285926E79E550903";
      break;
    case 4:
      level._id_14687._id_11AEA = "_encstr_883E0978CAE2A1689B3161";
      level._id_14687._id_11AE9 = "_encstr_B2780D2238237849794229F0900687";
      break;
    case 5:
      level._id_14687._id_11AEA = "_encstr_883009BD28232B4B688B98";
      level._id_14687._id_11AE9 = "_encstr_A7E80DA0184803B338FB43575D4170";
      break;
    case 6:
      level._id_14687._id_11AEA = "_encstr_834E0AFD036B7C39A427F282";
      level._id_14687._id_11AE9 = "_encstr_A3B70EC31340ACC2F51B7F030F9D8AF3";
      break;
    case 7:
      level._id_14687._id_11AEA = "_encstr_8BA10B7710B3A5E32FF50D4255";
      level._id_14687._id_11AE9 = "_encstr_8AC20A4B7B582B16C1EB838F";
      break;
    case 8:
      level._id_14687._id_11AEA = "_encstr_971804ED3712";
      level._id_14687._id_11AE9 = "_encstr_81B40817BFCBE16C3138";
      break;
  }

  level._id_146A0 = "_encstr_ABE20DEFA71388505EE1B1E9162C20";
  level._id_1469F = "_encstr_ACD3134D1B2B93C5FF58FAE2012F7DA7410DD1D4BB";
  level._id_1469E = "_encstr_8B1804DF2043";
  level._id_146A2 = "_encstr_A39C0A5BEFD9E087326F0D31";
  level._id_1469D = "_encstr_A29B05E9400E5D";
  level._effect["_encstr_8FAD1EDAA062B990110F4E7B0FB4C4EB6DE1B1E8D0600FED213604AA4F93EDE7"] = loadfx("_encstr_968E37D9CCE1CBD2EE0EAF9827F27658ADB2E0D88597F29EF6B613A5B2EB0BB45ED9660FEB9E585AAFCDE08577B9AFEC9CDB5DE6C8C5EC333C");
  level._effect["_encstr_82681C7A11CA2EB99029D1CBCF0FCDB9CDB7B1E7F3E537CA660F13D03879"] = loadfx("_encstr_92343593857BB6298032F9BE536A6FEA592B137373237E0218E0AE44A911B1229795C3DBA7CAC2D9710B224E03B0C70B8DCD330A6D7C9B");
  level._effect["_encstr_83AF1222351289C7EAFF4D5357F2AF98AD8E6BF8"] = loadfx("_encstr_B4FF379B8D03CE51882AEDC3B90B7006480B7F7B6B26C35F68C877CAF09ABECAB3CFF787F140AAC4A8332CD929B0E47201B76F3FB150738668");
  level._effect["_encstr_85AD118850CE67D6EA6777539347C1E3615BAB"] = loadfx("_encstr_A909346ED5D8D5879C2AC11A0BD8C73E184BE0CC73081D0348B80AD2F1D817F4B2056E50F7B8D6177811327B9EAD5FAE8081AEC62DD0");
  level._effect["_encstr_8448179EDA31F50B2DAF563CE063DB6EA5ED73FAC85916A31A"] = loadfx("_encstr_BD8938D999F0E596BBC1AF134ECBCEC2B6B21C63855EE5D3DED64C5A2B7DB02D79D933877DD316B4D7951E0EC6F64695D73295B0D134719D66F0");
  level._effect["_encstr_996A125305D241F1289F2D902149D15837AB3C75"] = loadfx("_encstr_8C3D41B062185720CF20B0164286A993053AF8E88AF09F9A576D269B2D1F514B7DB3C0D0C1C8BBB0BF8DB90F3F0F1825D93BC0F8FBA78F093BB13E8C1D67E375FBC220");
  level._effect["_encstr_834E11FAB27A5739B9FF52B2F9091AD3634651"] = loadfx("_encstr_B24B38FB102A07BADF2BE9DE76071211D0A05B1BB0E2CF53D7A9AE14D53F8AD130408BD3A93AF92A5FB5754AD06B0262C6D85F0B70B17EE375D3");
  level._effect["_encstr_B27F11D3B5C4F585B47DACAD1CAF3256581D1A"] = loadfx("_encstr_B49C34F4574B97E8B75A49B86BB76143A23F6F716EB34FB28767A8E81F2F79EBEE63EC8349DB9B184F7FA8180F2CB133838C700C9F53");
  level._effect["_encstr_A1FA1722752BE643781793BDEA57986A9180FBB13FC2E063B8"] = loadfx("_encstr_B4FF379B8D03CE51882AEDC3B90B7006480B7F7B6B26C35F68C877CAF09ABECAB3CFF787F140AAC4A8332CD929B0E47201B76F3FB150738668");
  level.activeuavs["_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8"] = 0;
  level.activeadvanceduavs["_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8"] = 0;
  level.activecounteruavs["_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8"] = 0;
  thread _id_11FFA();
  thread hostvictimdamagefactorlow();
  thread _id_13D99();
  thread _id_146AA();
  thread _id_1468C();
  thread deploy_emp_drone();
  thread _id_1468E();
}

_id_1468E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(tableexists("_encstr_BD5025FD9FF77AD1BB414F4FB05087A3E9B6D57507EF2217403AC75FE0884CCAB34D4A3D661F7B"))
    var_0 = int(tablelookup("_encstr_BD5025FD9FF77AD1BB414F4FB05087A3E9B6D57507EF2217403AC75FE0884CCAB34D4A3D661F7B", 1, level._id_14687._id_11AE9, 0));
  else
    var_0 = -1;

  setomnvar("_encstr_830715C3B061FAB3207D3707ABD77B3B68B9F14E4BD881", var_0);
}

setup_target_anims() {
  wait 0.1;

  if(getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) < 1)
    play_missile_target_marker_vfx_on_missile_target_ent();
  else
    play_missile_target_marker_vfx_on_missile_target_ent(level._id_146B8);
}

play_missile_target_marker_vfx_on_missile_target_ent(var_0) {
  if(!isDefined(var_0)) {
    level thread _id_14688();
    return;
  }

  switch (var_0) {
    case "_encstr_AF9411358239385057FAF861F3C792D80DED1B":
      break;
    case "_encstr_A2941126C9BEF4B75B984BAC37D7E9F6CD956E":
    case "_encstr_B1941198C97DA7DBB589D259DCF5E9BD9BB263":
    case "_encstr_8A511AF1229F10701A5B0B2B2701C270767FDECBCB1BD83FE31F0F35":
    case "_encstr_BA94119827BED3EDB64C5A56B9FA3DB7DC2BD4":
    case "_encstr_A99411D562D9D8B0B7DAD841D3A7F2B82DCDF1":
    case "_encstr_8C9411AE02696D78FD03C850BF37128FA26FBE":
    default:
      level thread _id_14688();
      break;
  }
}

_id_11FFA() {
  for(;;)
    level waittill("_encstr_B1750C47E049978B0F78C3BF5F23", var_0);
}

_id_146EB(var_0) {
  level notify("_encstr_A74A0F6AD358C1D3A88BCA72D6F08B07F8");
  level._id_146AD _id_13D97();
  level._id_146AD = undefined;
  _id_14708();
  thread _id_146ED(var_0);
}

_id_146EE() {
  _id_146EB();

  foreach(var_1 in level._id_146EF) {
    if(isalive(var_1)) {
      var_1.shutdown = 1;
      var_1 suicide();
    }
  }
}

_id_146EC(var_0) {
  if(getdvarint("_encstr_ACCA22E6364EFA26397D9EF65B4CD22BAF164BBECA9B58898D95FAC8937B38EBC6DEBD1D", 1)) {
    var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_0.origin, var_0.angles, var_0);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_936A19313963B7B71DD7856CB1CACDCDF536B09323BE7627ACCA37", var_2);
  }

  var_3 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 6000);

  if(level._id_14687.packs == 1) {
    foreach(var_5 in var_3)
    var_5 scripts\mp\hud_message::showsplash("_encstr_AD9612894E7DA70B4B7D9CDBAEDC23EB7B675939");
  } else if(level._id_14687.packs == 2) {
    foreach(var_5 in var_3)
    var_5 scripts\mp\hud_message::showsplash("_encstr_A7B81BEA83603B8E905F9A9F1370176790FB12738EC15F85101B9094DB");
  }

  level._id_14687.packs = 0;
  _id_146EB(6);

  switch (level._id_146B8) {
    case "_encstr_AF9411358239385057FAF861F3C792D80DED1B":
      thread _id_14689();

      if(getdvarint("_encstr_86D91DB96CE4F51327BEE9B7B5C4B459FADEE0CA37D7C26363F523B7ED4EE6", 1))
        thread _id_14689();

      break;
    case "_encstr_A2941126C9BEF4B75B984BAC37D7E9F6CD956E":
    case "_encstr_B1941198C97DA7DBB589D259DCF5E9BD9BB263":
    case "_encstr_8A511AF1229F10701A5B0B2B2701C270767FDECBCB1BD83FE31F0F35":
    case "_encstr_BA94119827BED3EDB64C5A56B9FA3DB7DC2BD4":
    case "_encstr_A99411D562D9D8B0B7DAD841D3A7F2B82DCDF1":
    case "_encstr_8C9411AE02696D78FD03C850BF37128FA26FBE":
    default:
      break;
  }
}

_id_146ED(var_0) {
  if(isDefined(var_0)) {
    level endon("_encstr_9B1D0BC7932875276230426AA1");
    level endon("_encstr_8765123D2C96FAC6B76B83D5D159C9BE5DB9958C");
    wait(var_0);
  }

  foreach(var_2 in level.players) {
    var_2.unsetbettermissionrewards = 0;
    var_2 _id_126DC(level._id_14687._id_146C7);
  }
}

_id_146BA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8765123D2C96FAC6B76B83D5D159C9BE5DB9958C");

  for(;;) {
    if(getdvarint("_encstr_9B8A1CAECE33AF417A7F28F84FBF19179B762D20E29AB3885467785847CA", 0)) {
      var_0 = level.player;

      foreach(var_2 in level._id_146EF) {
        if(isalive(var_2)) {
          var_0 = var_2;
          break;
        }
      }

      setDvar("_encstr_9B8A1CAECE33AF417A7F28F84FBF19179B762D20E29AB3885467785847CA", 0);
      _id_146EC(var_0);
    }

    wait 2;
  }
}

_id_14706(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_14704))
    var_1._id_14704 = "_encstr_A29B05E9400E5D";

  var_2 = level._id_14687._id_146DA;

  switch (var_1._id_14704) {
    case "_encstr_ABE20DEFA71388505EE1B1E9162C20":
      thread scripts\mp\equipment\gas_grenade::gas_createtrigger(self.origin, undefined, 5.5, 0.5);
      playFX(level._effect["_encstr_85AD118850CE67D6EA6777539347C1E3615BAB"], var_1 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"));
      var_2 = level._id_14687._id_146DD;
      break;
    case "_encstr_ACD3134D1B2B93C5FF58FAE2012F7DA7410DD1D4BB":
      playFX(level._effect["_encstr_8448179EDA31F50B2DAF563CE063DB6EA5ED73FAC85916A31A"], var_1 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"));
      var_3 = scripts\mp\utility\player::getplayersinradius(var_1.origin, 200);

      foreach(var_5 in var_3) {
        if(var_5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          if(var_5.vehicle.health > var_5.vehicle.maxhealth * 0.05) {
            var_6 = var_5.vehicle.maxhealth * level._id_14687.onusethanksbc;
            var_5.vehicle dodamage(var_6, var_5.vehicle.origin, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
          }
        }

        if(var_5 scripts\mp\utility\perk::_hasperk("_encstr_8AEA113783CA36A50B36E8BCEB9893BEB2BD46"))
          var_5 dodamage(int(level._id_14687.onuseitem * 0.85), var_1.origin, var_1, var_5, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
        else
          var_5 dodamage(level._id_14687.onuseitem, var_1.origin, var_1, var_5, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

        var_5 earthquakeforplayer(0.35, 0.9, self.origin, 200);
      }

      var_2 = level._id_14687._id_146DC;
      break;
    case "_encstr_8B1804DF2043":
      playFX(level._effect["_encstr_B27F11D3B5C4F585B47DACAD1CAF3256581D1A"], var_1 gettagorigin("_encstr_8EEC09159F6238030BFA23"));
      var_2 = level._id_14687._id_146DB;
      break;
    case "_encstr_A39C0A5BEFD9E087326F0D31":
      playFX(level._effect["_encstr_A1FA1722752BE643781793BDEA57986A9180FBB13FC2E063B8"], var_1 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"));
      var_2 = level._id_14687._id_146DE;
      break;
    default:
      playFX(level._effect["_encstr_83AF1222351289C7EAFF4D5357F2AF98AD8E6BF8"], var_1 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"));
      var_2 = level._id_14687._id_146DA;
      break;
  }

  var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  if(var_2 > 0) {
    if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9")
      var_2 = var_2 * level._id_14687._id_146D8;

    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_2, var_8);
  }

  if(isalive(var_0) && isPlayer(var_0) && randomfloat(1.0) < level._id_14687._id_146A5) {
    var_9 = var_0 getcurrentprimaryweapon();
    var_10 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_9);

    if(!isDefined(var_10)) {
      return;
    }
    foreach(var_12 in level.br_ammo_types)
    var_1.br_ammo[var_12] = 0;

    var_1.br_ammo[var_10] = level.br_ammo_clipsize[var_10];
    var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::minplunderextractions(var_8);
  }

  if(isalive(var_0) && isPlayer(var_0) && randomfloat(1.0) < level._id_14687._id_146A7) {
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_8, var_1.origin, var_1.angles, var_1);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", var_14, level._id_14687._id_146A6, 1);
  }
}

_id_14708() {
  level._id_146F0 = 0;

  if(isDefined(level._id_14687))
    level._id_14687._id_146C7 = 0;

  level.deploy_subway_cars_on_track = getdvarint("_encstr_88DF1297B6D34703700FA20805C6D35BD6369B15", -1);
  level.deploy_suicide_truck_in_lumber_yard = getdvarint("_encstr_952E21E6867BE71922379040874A30DBF1EB50ED9E721F400DD7B190FF704977DAD6D6", -1);
  level.deploy_suicide_truck_in_farm = getdvarint("_encstr_816B2783DA2348F042872517AD2EE02DEFC398EB42F380685B9D6729D19258F8AF9BF3504A57C328B5", -1);
  level.deploy_suicide_truck_in_blockade = getdvarint("_encstr_8D2E217378B628A17AAFEB9F7B351337C945D73457619F38488FFFED9F925DA7AD2A9B", -1);
  level.deployable_cover_cancel = getdvarint("_encstr_B1B22757D33251966B69DA6052F3DB48813CE7C1791D09E81F62760BFB9385E123850377F085702023", -1);
}

_id_146D4() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level._id_14687._id_12377);
    var_0 unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level._id_14687._id_12378);
  }
}

_id_146F5(var_0) {
  var_1 = self;

  if(!level._id_14687._id_146B7) {
    return;
  }
  if(!isDefined(var_1._id_13174) || !isDefined(var_1._id_131BC)) {
    return;
  }
  var_2 = randomfloat(2.0);

  if(var_0 == level._id_146A0 || var_0 == level._id_1469F) {
    var_1[[var_1._id_13174]]("_encstr_92100762872552A643");
    var_2 = randomfloat(1.0);
  } else if(var_0 == level._id_1469E || var_0 == level._id_1469D)
    var_1[[var_1._id_13174]]("_encstr_B4190493D573");
  else if(var_0 == level._id_146A2)
    var_1[[var_1._id_13174]]("_encstr_99F605EE16B1DA");

  var_1[[var_1._id_131BC]](var_2);
}

_id_146F3(var_0) {
  var_1 = self;

  if(!level._id_14687._id_146B6) {
    return;
  }
  if(var_0 == level._id_146A0 || var_0 == level._id_1469F)
    var_1.health = 120;
}

_id_146F4(var_0) {
  var_1 = self;

  if(!level._id_14687._id_146B5) {
    return;
  }
  if(var_0 == level._id_146A2)
    var_1._id_11BBD = level._id_14687.spawn_entity_carriable;
  else if(var_0 == level._id_1469D)
    var_1._id_11BBD = level._id_14687._id_11BDC;
  else if(var_0 == level._id_1469E || var_0 == level._id_146A0 || var_0 == level._id_1469F)
    var_1._id_11BBD = level._id_14687._id_11A55;
}

_id_146AF(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_4._id_14704) && isDefined(var_0) && isDefined(var_1)) {
    if(istrue(var_3)) {
      if(isDefined(var_2) && var_2 == "_encstr_81CC0586952C91")
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_BA1A129877094830430AE74AC815EA8048581D93", var_0 >= self.health, 1, "_encstr_BA1A129877094830430AE74AC815EA8048581D93");
      else
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_BA1A129877094830430AE74AC815EA8048581D93", var_0 >= self.health, 0, "_encstr_BA1A129877094830430AE74AC815EA8048581D93");
    } else if(var_4._id_14704 == level._id_146A2) {
      if(isDefined(var_2) && var_2 == "_encstr_81CC0586952C91")
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5D20E0DD2E8C2C9D6F627D09516675E", var_0 >= self.health, 1);
      else
        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5D20E0DD2E8C2C9D6F627D09516675E", var_0 >= self.health);
    } else if(isDefined(var_2) && var_2 == "_encstr_81CC0586952C91")
      var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", var_0 >= self.health, 1);
    else
      var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", var_0 >= self.health);
  }
}

_id_1468C() {
  waittillframeend;
  level._id_14687.max_rpg_groups = _id_1468B();

  foreach(var_1 in level._id_14687.max_rpg_groups) {
    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == level._id_146B8)
        continue;
    }

    var_1 delete();
  }

  if(level.mapname == "_encstr_B1D508B607F591B7CD33" && getdvarint("_encstr_88E91A83F2AB86A36BB0A7F8CB9F613781A0C0F803B84390911A8C73", 0)) {
    var_3 = getdvarvector("_encstr_AC0221234FEAEE019AB6D9B7733B01FA84D103A99777583C6958931359E0CBA28D26D1", (39256, -42265, -506));
    var_4 = getdvarvector("_encstr_B80221FA96CDD9527BC1D3F7203B3743513B82798713A390E6109FB391EBC9FA13588E", (39348, -42251, -508));
    var_5 = (0, vectortoyaw(var_4 - var_3), 0);
    var_6 = spawncovernode(var_3, var_5, "_encstr_845E066577577837", 0, undefined, undefined, "_encstr_BACB074025B01AAA28");
    createnavlink("_encstr_B2B00C8AD0D806F1F59903396E0F", var_3, var_4, var_6);
    var_5 = (0, vectortoyaw(var_3 - var_4), 0);
    var_6 = spawncovernode(var_4, var_5, "_encstr_845E066577577837", 0, undefined, undefined, "_encstr_BACB074025B01AAA28");
    createnavlink("_encstr_B2B00C8AD0D806F1F59903396E0F", var_4, var_3, var_6);
  }

  if(level.mapname == "_encstr_B1D508B607F591B7CD33") {
    if(getdvarint("_encstr_A35A268F8706C95AA0C6B8C5B81869A248070B2F7538921C38AE37CD1070BB593F992FFFF95FEBDC", 1))
      _id_14689();
    else {
      var_7 = getdvarfloat("_encstr_9A54244FCB3A59AE536101689ABEC8C05429D19F742590EEBF5AD91323CF9E70AF875F4B020F", 0.0);

      if(var_7 > 0.0) {
        if(level._id_146B8 == "_encstr_AF9411358239385057FAF861F3C792D80DED1B" || level._id_146B8 == "_encstr_AF9411358239385057FAF861F3C792D80DED1B") {
          var_8 = _id_1468B("_encstr_83D8121DB78E70605B3250FB9BDFAEF0231EA933");

          foreach(var_10 in var_8) {
            var_11 = anglesToForward(var_10.angles) * 26.0;
            var_10._id_11F9A = createnavbadplacebyshape(var_10.origin + var_11, 6, var_7, 20);
          }
        }
      }
    }
  }
}

_id_1468B(var_0) {
  var_1 = getEntArray(level._id_146B8, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0))
    return var_1;

  if(!var_1.size)
    return undefined;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1468D(var_0) {
  if(isDefined(var_0.script_linkto)) {
    if(isDefined(var_0._id_11F9A))
      destroynavobstacle(var_0._id_11F9A);

    var_0 setscriptablepartstate("_encstr_99090C307DE1E0FF1BF8917077D8", "_encstr_ADB405071B8AE8");
    var_0 moveTo(scripts\engine\utility::getStruct(var_0.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2").origin, 2.5, 0.5, 0.5);
  }
}

_id_126DC(var_0) {
  if(getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) < 1) {
    return;
  }
  var_1 = self;

  if(!isDefined(var_1.unsetbettermissionrewards))
    var_1.unsetbettermissionrewards = 0;

  var_2 = _id_1468A(var_1.unsetbettermissionrewards, level._id_14687.packs, var_0);
  var_1 setclientomnvar("_encstr_8A8D128BC79156F82FE851A859FBD8155A1B130D", var_2);
}

_id_1468A(var_0, var_1, var_2) {
  var_3 = int(var_0) & 1;
  var_3 = var_3 + ((int(var_1) & 3) << 1);
  var_3 = var_3 + ((int(var_2) & 63) << 3);
  return var_3;
}

_id_12666(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A74A0F6AD358C1D3A88BCA72D6F08B07F8");

  for(;;) {
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0, 6000);

    foreach(var_3 in level.players) {
      if(!isalive(var_3) || var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
        continue;
      }
      if(scripts\engine\utility::array_contains(var_1, var_3)) {
        if(!istrue(var_3.unsetbettermissionrewards))
          var_3 _id_1253E();

        var_3.unsetbettermissionrewards = 1;
      }

      var_3 _id_126DC(level._id_14687._id_146C7);
    }

    wait 3;
  }
}

_id_1253E() {
  var_0 = self;

  if(level._id_14687.packs == 1)
    var_0 scripts\mp\hud_message::showsplash("_encstr_A5D51C4CE4BEF48596F556DCD156275A733BD785C6D1D2ECB2FAC2275616");
  else if(level._id_14687.packs == 2)
    var_0 scripts\mp\hud_message::showsplash("_encstr_B1FB25432D6863A1F05EF73D13B8FAEA58AF2FC7F7259A8EC826EE0229600FE2AD210B1F794102");
}

_id_146B3() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");

  for(;;) {
    var_1 = randomint(5);
    wait(5 + var_1 - 2);
    playFXOnTag(level._effect["_encstr_996A125305D241F1289F2D902149D15837AB3C75"], var_0, "_encstr_8EEC09159F6238030BFA23");
    wait 2;
    var_0 _id_146B4();
  }
}

_id_146B4() {
  var_0 = 60;
  var_1 = 1;
  var_2 = 64;
  var_3 = var_2 * var_2;
  var_4 = level._id_14687.mortar_cooldown * level._id_14687.mortar_cooldown;
  var_5 = "_encstr_8E0B110A40FBD68B1D4BA968F2F2B36E53CC96";
  var_6 = self;
  var_7 = anglesToForward(var_6.angles);
  playFX(level._effect["_encstr_834E11FAB27A5739B9FF52B2F9091AD3634651"], var_6 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), var_7);
  var_8 = getcompleteweaponname("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
  var_9 = getcompleteweaponname("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E");
  var_10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_12 in var_10) {
    var_13 = var_12.owner;

    if(isDefined(var_13)) {
      if(var_13 != var_6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_6, var_13))
        continue;
    }

    var_14 = distancesquared(var_6.origin, var_12.origin);

    if(var_14 > var_4) {
      continue;
    }
    var_15 = scripts\engine\utility::ter_op(var_14 > var_3, var_8, var_9);
    var_12 dodamage(1, var_6.origin, var_6, var_6, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_15);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_6, var_12, 1, var_15, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_6, var_6.origin);
    thread _id_126F9(var_16);
  }

  var_18 = getcompleteweaponname("_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  var_19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_6.origin, level._id_14687.mortar_cooldown);

  foreach(var_21 in var_19) {
    if(!var_21 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_21 != var_6 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_6, var_21)) {
      continue;
    }
    var_21 dodamage(1, var_6.origin, var_6, var_6, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_18);
    var_21 earthquakeforplayer(0.2, 0.7, self.origin, level._id_14687.mortar_cooldown);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_6, var_21, 1, var_18, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_6, var_6.origin);
    thread _id_126F9(var_16);
  }
}

_id_126F9(var_0) {
  var_1 = 5;
  var_2 = 2;
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_3 = var_1;

  if(isPlayer(var_0.victim)) {
    var_0.victim.unmark_on_death = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(var_0.victim != self && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93")) {
        var_3 = var_2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_8D760DB8F77343CF62BEB7E3D01013");
      }
    }
  }

  moraleslaptopthink(var_0, var_3);

  if(isDefined(var_0.victim)) {
    var_0.victim.unmark_on_death = undefined;
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
  }
}

moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);

  if(var_2 != "_encstr_99C40CA749E1F16B80389FEB2BB9")
    var_0.empremoved = 1;
}

hostvictimdamagefactorlow() {
  level._id_14696 = spawnStruct();
  level._id_14696._id_12F41 = ["_encstr_BA19049F4B2D", "_encstr_BDEB08D53CDDD271D008", "_encstr_BE19041BDEDD", "_encstr_AB5E07609A5B7368E5", "_encstr_9ACC05B41B7F32", "_encstr_99CC09DA9020C4ECD149AD"];
  level._id_14696._id_1403B = ["_encstr_921D09D9D9C0090D7275B4", "_encstr_A18008BD35E222F01BD0"];
  level._id_14696._id_12F44 = getdvarfloat("_encstr_84E52A889F62E6CD2329CA58BDFA0369E727E0F8070BB89B2BC1465652E253B03F97A02067B431C71374B16D", 10.0);
  level._id_14696._id_13334 = getdvarint("_encstr_8E412A37C69CFA9839BEF4B7DA892D95F58DBD73D736ED5B1CAFB9A1DBBBF52396E6C2C4D89591FAA15AB9A3", 1);
  waittillframeend;
  level._id_14696.holoeffect = getentitylessscriptablearrayinradius("_encstr_9927330BBE1A205733FF4551076916C8AED3F1C0657D08370B1FBF4F1FC365587DAABE73DAE7404E03DFBB45BFDBA6D01982435137", "_encstr_AC110A7F14873B5B3D073009");
  scripts\engine\scriptable::_id_12F5B("_encstr_86DF1C36B7B93AC22D73ADCA73A3EBC67B6B38BA475627BE57CDC226D8AC", ::hostvictimdefensefactormod);
  var_0 = getdvarint("_encstr_859E278EEE138F615A5FC868BF62D8232916089849BAA7C82047B8103BBD117D717A7E955DF229F110", 0);
  var_1 = getdvarint("_encstr_B49E277616EB7789B2C760D017FAA04B81BEE070E112CF5098AF10380F12D8F3E9E2E60DC56AB15978", 0);
  hostvictimdamagepercentlow(var_0, var_1);

  if(!getdvarint("_encstr_852025F3D8256933FBAFCDCE27C1332FD7885AAAD1DD5B235370DEC7CBA83732F5D802A230B754", 0))
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  var_0 = getdvarint("_encstr_BD3D1E6EC639D789E4EB4FBDB613B495BE8DDB37AF8DF6D6C1BE9B36272B2BB9", 2);
  var_1 = getdvarint("_encstr_81C21EE61B4E7D13C9AF3DEDDA312D95D78DB79BF5D8DBB51CD75DE6B0313656", 0);
  hostvictimdamagepercentlow(var_0, var_1);
}

hostvictimdamagepercentlow(var_0, var_1) {
  level._id_14696._id_12F42 = var_0;

  foreach(var_3 in level._id_14696.holoeffect) {
    var_3 notify("_encstr_BDF6224B90E8F346CB60DA52881936676087C5D43D33A78287B842AA906DF75FFBE04A7D");
    hostvictimdamagepercenthigh(var_3, var_0, var_1);
  }
}

hostvictimdamagepercenthigh(var_0, var_1, var_2) {
  var_0._id_12F43 = var_1;
  var_3 = level._id_14696._id_12F41[var_1];
  var_0 setscriptablepartstate("_encstr_A7B51CFA20F8038E903D859525A0D99790984303EBC54349280F929DDB58", var_3);

  if(isDefined(var_2)) {
    var_0._id_1403C = var_2;
    var_4 = level._id_14696._id_1403B[var_2];
    var_0 setscriptablepartstate("_encstr_86DF1C36B7B93AC22D73ADCA73A3EBC67B6B38BA475627BE57CDC226D8AC", var_4);

    if(level._id_14696._id_13334)
      var_0 setscriptablepartstate("_encstr_8856209160E51B87119A333D6873B12FB01B736364F53B2995D0B95FAF9B201068EF", var_4);
  }
}

hostvictimdefensefactormod(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.br_circle))
    var_5 = 2;
  else
    var_5 = 3;

  var_3 setclientomnvar("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B", var_5);
  var_3 thread _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_runpurchasemenu(var_0, 1);
  var_3 waittill("_encstr_8F6615C1AEE4B1A158B959F56B5937ABF58D637BDCAC91", var_6);

  if(var_6 == 1)
    hostvictimdamagefactorhigh(var_0);
}

hostvictimattackfactormod(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1)
  hostskipburndownmedium(var_3);
}

hostskipburndownmedium(var_0) {
  if(!isDefined(var_0.delay_kick_inactive_player)) {
    return;
  }
  if(var_0.delay_kick_inactive_player.classname != "_encstr_9927330BBE1A205733FF4551076916C8AED3F1C0657D08370B1FBF4F1FC365587DAABE73DAE7404E03DFBB45BFDBA6D01982435137") {
    return;
  }
  var_0 notify("_encstr_97050B93D73E32650159F0BC53");
}

hostvictimdamagefactorhigh(var_0) {
  if(var_0._id_12F43 <= 1) {
    return;
  }
  hostvictimdamagepercenthigh(var_0, var_0._id_12F43 - 1);
  hostvictimdamagefactormedium(var_0);
}

hostvictimdamagefactormedium(var_0) {
  var_0 notify("_encstr_BDF6224B90E8F346CB60DA52881936676087C5D43D33A78287B842AA906DF75FFBE04A7D");
  var_0 endon("_encstr_BDF6224B90E8F346CB60DA52881936676087C5D43D33A78287B842AA906DF75FFBE04A7D");

  while(var_0._id_12F43 < level._id_14696._id_12F42) {
    wait(level._id_14696._id_12F44);
    hostvictimdamagepercenthigh(var_0, var_0._id_12F43 + 1);
  }
}

hostvictimdamagepercentmedium(var_0) {
  var_1 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_936A19313963B7B71DD7856CB1CACDCDF536B09323BE7627ACCA37");

  foreach(var_3 in level._id_14696.holoeffect) {
    if(var_1) {
      var_3 enablescriptablepartplayeruse("_encstr_86DF1C36B7B93AC22D73ADCA73A3EBC67B6B38BA475627BE57CDC226D8AC", var_0);
      var_3 disablescriptablepartplayeruse("_encstr_8856209160E51B87119A333D6873B12FB01B736364F53B2995D0B95FAF9B201068EF", var_0);
      continue;
    }

    var_3 disablescriptablepartplayeruse("_encstr_86DF1C36B7B93AC22D73ADCA73A3EBC67B6B38BA475627BE57CDC226D8AC", var_0);
    var_3 enablescriptablepartplayeruse("_encstr_8856209160E51B87119A333D6873B12FB01B736364F53B2995D0B95FAF9B201068EF", var_0);
  }
}

_id_11FF9(var_0) {
  var_1 = self;

  if(!isDefined(level._id_14687)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_936A19313963B7B71DD7856CB1CACDCDF536B09323BE7627ACCA37") {
    var_2 = 225000000;

    for(var_3 = 0; var_3 < level._id_14687.force_teleport_downedplayer.size; var_3++) {
      if(distancesquared(level._id_14687.forced_aitype_armored[var_3].origin, var_1.origin) < var_2) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_14687.force_teleport_downedplayer[var_3], var_1);
        return;
      }
    }
  }
}

_id_1207D(var_0) {
  if(!isDefined(level._id_14687)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_936A19313963B7B71DD7856CB1CACDCDF536B09323BE7627ACCA37") {
    foreach(var_2 in level._id_14687.force_teleport_downedplayer)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, self);
  }
}

_id_13D99() {
  var_0 = getentitylessscriptablearrayinradius("_encstr_B1402F7BCF9854D32D3102EA9990878EF0A3F0E463A0DD4F408B4A03C3C85BC4A031976A8770E337F063E11ACBB56B3D60", "_encstr_AC110A7F14873B5B3D073009");

  if(!getdvarint("_encstr_852025F3D8256933FBAFCDCE27C1332FD7885AAAD1DD5B235370DEC7CBA83732F5D802A230B754", 0))
    scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  wait 4;

  foreach(var_2 in var_0) {
    if(var_2.targetname == level._id_146B8) {
      var_2 setscriptablepartstate("_encstr_A65C075AD0916BCFA0", "_encstr_8E8607AB603B6E4341");
      var_3 = anglesToForward(var_2.angles);
      var_2._id_12F40 = easepower("_encstr_8FB92B03DE23CF7A8950728A688733B77B3DA79E63A963456D890A232BCDEBA7F125F41488D0870A7718326A60", var_2.origin + var_3, var_2.angles);
      var_2 _id_13D97();
    }
  }
}

_id_13D97() {
  if(isDefined(self._id_12F40))
    self._id_12F40 setscriptablepartstate("_encstr_852907B9D8C959B2CD", "_encstr_932906F74A6F1818");
}

_id_13D96() {
  if(isDefined(self._id_12F40))
    self._id_12F40 setscriptablepartstate("_encstr_852907B9D8C959B2CD", "_encstr_A29A08EB6085675FAA2B");
}

_id_146AA() {
  level._id_14687.force_thermites = scripts\engine\utility::getStructArray("_encstr_8F291170B7153D01ED4EE85FB8F96379E28733", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  switch (level.script) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      break;
    default:
      break;
  }

  level._id_14687.forced_aitype_armored = [];
  level._id_14687.force_teleport_downedplayer = [];
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level._id_14687.force_thermites) {
    if(isDefined(var_1.script_noteworthy) && level._id_146B8 != var_1.script_noteworthy) {
      continue;
    }
    if(!isDefined(var_1.angles))
      var_1.angles = (0, 0, 0);

    var_2 = easepower("_encstr_AA5F12F2B6663B5D5FD8815A689F54D7DE1A7765", var_1.origin, var_1.angles);
    var_2.get_circle_back_nodes_on_same_side = ::_id_146A9;
    var_2._id_1406C = ::_id_146AB;
    var_2._id_12F7F = "_encstr_93590A1B0B8D34CAEBF4DBB6";
    var_2._id_11A48 = 1;
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_AF5A081BBAC993AC73A3", var_2.origin + (0, 0, 15), "_encstr_A52C28F3D0E9FD70D8E6BB7120FFE361B3F8E060601775B8FF13E5EAE0593D9D5514F0DB1297FB8B875B");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3);
      level._id_14687.force_teleport_downedplayer[level._id_14687.force_teleport_downedplayer.size] = var_3;
    } else {}

    level._id_14687.forced_aitype_armored[level._id_14687.forced_aitype_armored.size] = var_2;
  }
}

_id_146A8(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.script_noteworthy = var_2;
  level._id_14687.force_thermites[level._id_14687.force_thermites.size] = var_3;
}

_id_146A9(var_0, var_1, var_2, var_3, var_4) {
  if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_936A19313963B7B71DD7856CB1CACDCDF536B09323BE7627ACCA37")) {
    var_3 scripts\mp\hud_message::showerrormessage("_encstr_879624E33B895E11D7DC5C75F6FD915071DF6B853770985121A6840D699CD928B937EF0BE388");
    var_3 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    return 0;
  }

  return 1;
}

_id_146AB(var_0, var_1, var_2, var_3, var_4) {
  var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12BFC();

  if(!isDefined(var_0._id_12F80))
    var_0._id_12F80 = 0;
  else
    var_0._id_12F80 = (var_0._id_12F80 + 1) % 10;

  for(var_5 = 0; var_5 < level._id_14687.force_teleport_downedplayer.size; var_5++) {
    if(var_0 == level._id_14687.forced_aitype_armored[var_5])
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level._id_14687.force_teleport_downedplayer[var_5], var_3);
  }

  applyminigunrestrictions(var_0.origin);

  if(getdvarint("_encstr_8B6F1BA0462287BD4FDA301ACDF4DB13C8199E0AFBB8246F4BC0B8A950", 0) == 0)
    var_0 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11AA0("_encstr_8CEA1A1DAACDA8781B3191D99A372E10A913A3B524F998BD3BDB4801");

  wait(getdvarfloat("_encstr_8F2C19B9C69CD72639AF3D7BDAC4D2B2F5B116B13456EBBB85968E", 5.0));
  var_0 setscriptablepartstate(var_1, "_encstr_BEE608BF50D84BAA9DF4");
}

applyminigunrestrictions(var_0) {
  var_1 = getdvarint("_encstr_B42C2E0726A838B5F25788D86238D2E56F3B106AD09DC7340F28EFE501A95BEF305BB37361A04A2F3419E286C18303CA", 128);

  if(var_1 == 0) {
    return;
  }
  var_2 = canceljoins(undefined, undefined, var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::update_gamebattles_char_loc(var_4, 0)) {
        continue;
      }
      if(var_4 getscriptableisreserved() && !isDefined(var_4.embassy_main)) {
        continue;
      }
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_4);
    }
  }
}

_id_14689() {
  if(!isDefined(level._id_14687.player_disable_invulnerability))
    level._id_14687.player_disable_invulnerability = 1;

  if(!isDefined(level._id_14687.maxbetarank))
    level._id_14687.maxbetarank = 0;

  var_0 = [];

  if(!level._id_14687.maxbetarank) {
    if(level._id_14687.player_disable_invulnerability) {
      var_0 = _id_1468B("_encstr_83D8121DB78E70605B3250FB9BDFAEF0231EA933");
      level._id_14687.player_disable_invulnerability = 0;
    } else {
      var_0 = _id_1468B("_encstr_ABD8121AD08F9391688F37128F89E2372D68F2E7");
      level._id_14687.maxbetarank = 1;
    }

    if(isDefined(var_0)) {
      foreach(var_2 in var_0)
      thread _id_1468D(var_2);
    }
  }
}

_id_14688() {
  var_0 = getEntArray("_encstr_83D8121DB78E70605B3250FB9BDFAEF0231EA933", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0 scripts\engine\utility::array_combine(var_0, getEntArray("_encstr_ABD8121AD08F9391688F37128F89E2372D68F2E7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));

  foreach(var_2 in var_0)
  var_2 delete();
}

deploy_emp_drone() {
  wait 5.0;
  scripts\mp\utility\sound::besttime("_encstr_BEEA0BFA7D619E17964683DACA");
}