/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58340.gsc
***********************************************/

main() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) < 1) {
    _id_146FD("_encstr_9A8C1969BDDA265AB2044D83B0EE375A73CE02882D37584C1B568C");
    return;
  }

  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\engine\scriptable::_id_12F5B("_encstr_A65C075AD0916BCFA0", ::_id_146AE);
  _encstr_BA3C14793820DB98DF90D27AC835960B9817FAE4C50B();
  level.disable_oob_immunity_on_riders = 1;
  level.playerexitlaststand = ::_id_146F7;
  level.playerclearjailtimeouthud = ::_id_146BB;
  level._id_146B8 = getDvar("_encstr_95371D2328860F254B5FCB88B541D85956C9B593306BF22109ADBF0D389832", "_encstr_AF9411358239385057FAF861F3C792D80DED1B");
  level._id_146E9 = getdvarint("_encstr_AFAF2E371B4EEBC4E4BED3B76B89A5CAAF56CDD8B75D37D1CAC9F537EDFA3A8527D95647BED9F6FA3A7BAFDC07B0BBCD", 1);
  level._id_146CA = getdvarint("_encstr_923621D7DF2EE17298EE602D40F0B19A106B27733F580B25C9309D39F941D272DD95BB", 40);
  level._id_146AD = undefined;
  _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_14708();
  level.deployed = getdvarfloat("_encstr_8BF021436895B9E32BF0223FF171977FA790FBFA6015EC1B61D817299B9B87C313C8D2", 1.5);
  level.deploy_subway_car_at_station = getdvarint("_encstr_8E401637C69CFA19B2CCC2BAD8D1EBB516E1853B59E68EDC", 10);
  _id_146FD("_encstr_A5771D4AE8FBC6C313867399736022730B97725BF0A2029B180DA172B7204A" + level._id_146B8);

  while(!scripts\mp\flags::playerzombiethermalcleanup("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    wait 1;

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

_encstr_BA3C14793820DB98DF90D27AC835960B9817FAE4C50B() {
  level._id_14687 = spawnStruct();
  level._id_14687._id_146DA = getdvarint("_encstr_99C92BE6B14EAF314EEBA7BDB6984B95D7E0D85DDC32CAE47DED377D462BC23A0DFA0BB6BDEA378E7D980BDCAC", 1);
  level._id_14687._id_146DB = getdvarint("_encstr_9B782A325E15019AB3F9E3AF7069596AF76F7D2BB051FAB23E90BB6710E109C3711086A5A8AB82FC46F84FE3", 2);
  level._id_14687._id_146DC = getdvarint("_encstr_855E30CD8DC9BE4C9C7DA7EDB689D2B2F50E1BEA9B199527EBED37EB8C9516E80DEB85B6DBAE371DD7ACE107D8BDDC96B7DC", 2);
  level._id_14687._id_146DD = getdvarint("_encstr_8C782A5A366D79F2DB614B17D8F1A1825FD7E55328F9122A86F823CFE849615BE9F82ECDB7331A54AE501777", 2);
  level._id_14687._id_146DE = getdvarint("_encstr_BA0230CDC693D78939D7F4B76B26B456F507C6AB9B19CA27FADE37EBC8562C3A43D7C2ADB7EA378EAFDDCA0BAD07B7D2CD47", 3);
  level._id_14687._id_146D8 = getdvarint("_encstr_A52B213380A271124E78BA7220F38765C7082875580BF7B6FF4FFD0A75D83119940566", 50);
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
  level._id_146A0 = "_encstr_ABE20DEFA71388505EE1B1E9162C20";
  level._id_1469F = "_encstr_ACD3134D1B2B93C5FF58FAE2012F7DA7410DD1D4BB";
  level._id_1469E = "_encstr_8B1804DF2043";
  level._id_146A2 = "_encstr_A39C0A5BEFD9E087326F0D31";
  level._encstr_914A13E9B76B134B957D3AF2072BFA9358739DB24E = "_encstr_9A12079C85E676CA4E";
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
  scripts\mp\utility\sound::besttime("_encstr_BEEA0BFA7D619E17964683DACA");
}

_id_146B0() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  var_0 hide();
  wait 0.2;
  var_0 show();
  wait 2;

  if(getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) >= 1 && isDefined(level._id_14687))
    var_0 thread _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146D4();
}

_id_146F7() {
  return 0;
}

_id_146FE() {
  return getdvarint("_encstr_BADF126E369CD726C9FAA7DEB5C42DB2F563B7CE", 0) > 0;
}

_id_146FA(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::string_starts_with(var_0, "_encstr_880B07DFB62BB72B3F"))
    var_0 = "_encstr_880B07DFB62BB72B3F" + var_0;

  if(!isDefined(level.agent_definition[var_0]))
    return undefined;

  if(!isDefined(var_3) || !isDefined(var_3.script_animation)) {
    var_3 = spawnStruct();
    var_3.script_animation = "_encstr_A6D70D9B3858DDCDFA9D4E7BD59B46";
    var_3.targetname = "_encstr_9B660CEB598A8B3DDFDD1BBD9FB3";
    var_3.origin = var_1;
  }

  if(isDefined(var_3) && isDefined(var_3.targetname))
    _id_146FD("_encstr_8E8D1653E78112592B21C34C8060D8DBE7131F0BE12F3B48" + var_3.targetname);

  var_5 = scripts\mp\mp_agent::spawnnewagent(var_0, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8", var_1, var_2, undefined, var_3);

  if(isDefined(var_5)) {
    _id_146FD("_encstr_9A3C12F75907C3DE8029960860E81AFAED11AAB2" + var_0);
    var_5 thread _id_146B0();

    if(isDefined(var_4)) {
      var_5._id_14704 = var_4;

      switch (var_4) {
        case "_encstr_A29B05E9400E5D":
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_AC2B0A31C2CDB2AFD8F6BD38");
          playsoundatpos(var_5.origin, "_encstr_914D17E9B613FA9BC185BBDCF5A3CB8359FA91B2CC16571B47");
          break;
        case "_encstr_9A12079C85E676CA4E":
        case "_encstr_ABE20DEFA71388505EE1B1E9162C20":
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_BAE809E40E63EFC027FFB8");
          playsoundatpos(var_5.origin, "_encstr_8B0313BAC1CD71CF5BAAEB98E988EBF9DDEEAFE957");
          break;
        case "_encstr_ACD3134D1B2B93C5FF58FAE2012F7DA7410DD1D4BB":
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_A2920956E1E0BE36DBDB83");
          playsoundatpos(var_5.origin, "_encstr_B2031348CD35C77B38B307F0216BEB03E208B8AB51");
          break;
        case "_encstr_8B1804DF2043":
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_8B3509BAD8DF79FA489528");
          playsoundatpos(var_5.origin, "_encstr_8F0313F45B98FA37380BDDE6FA47BC1CB2EB2BB5C1");
          break;
        case "_encstr_A39C0A5BEFD9E087326F0D31":
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_841E0ABBB22CDABEB1F6DB07");
          var_5 thread carriablemagicgrenades("_encstr_B85E2DD8FA1D277DE9AD13F537C85DAFE9DEB64C5AAC7D437BB9B74ECE5D0BE423FA8656635B56A3EB982C274C2B46", "_encstr_9ABB0968F1402B19E2AFA9");
          playsoundatpos(var_5.origin, "_encstr_874D15CB6BADB1AF53E7272690BBCF02DBF9E2C3B81F32");
          break;
        default:
          var_5 setscriptablepartstate("_encstr_A93208074151E9418067", "_encstr_AC2B0A31C2CDB2AFD8F6BD38");
          break;
      }
    }

    if(!isDefined(var_3._id_146EA))
      var_3._id_146EA = getclosestpointonnavmesh(var_3.origin);

    switch (var_3.script_animation) {
      case "_encstr_A6D70D9B3858DDCDFA9D4E7BD59B46":
        if(isDefined(level._effect["_encstr_8FAD1EDAA062B990110F4E7B0FB4C4EB6DE1B1E8D0600FED213604AA4F93EDE7"]))
          playFX(scripts\engine\utility::getfx("_encstr_8FAD1EDAA062B990110F4E7B0FB4C4EB6DE1B1E8D0600FED213604AA4F93EDE7"), var_5.origin);

        break;
      case "_encstr_8B380F5A8B88F79AD89FEFD381E0825790":
        if(isDefined(level._effect["_encstr_82681C7A11CA2EB99029D1CBCF0FCDB9CDB7B1E7F3E537CA660F13D03879"]))
          playFX(level._effect["_encstr_82681C7A11CA2EB99029D1CBCF0FCDB9CDB7B1E7F3E537CA660F13D03879"], var_5.origin);

        break;
      default:
        if(isDefined(level._effect["_encstr_8FAD1EDAA062B990110F4E7B0FB4C4EB6DE1B1E8D0600FED213604AA4F93EDE7"]))
          playFX(scripts\engine\utility::getfx("_encstr_8FAD1EDAA062B990110F4E7B0FB4C4EB6DE1B1E8D0600FED213604AA4F93EDE7"), var_5.origin);

        break;
    }
  } else
    _id_146FD("_encstr_B2D70E6953EFBFFD6AFD19E951B8872A" + var_0);

  return var_5;
}

carriablemagicgrenades(var_0, var_1, var_2) {
  level endon("_encstr_A74A0F6AD358C1D3A88BCA72D6F08B07F8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");

  if(!istrue(var_2))
    wait 0.25;

  self attach(var_0, var_1);
  self.hashelmet = 1;
  self._encstr_952410E6DB537883206282F7DBAFBB7F9F44 = spawnStruct();
  self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.model = var_0;
  self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.tag = var_1;
}

_encstr_ABF9178C95A3B0C6438695B16BCA47CCE4BDAD9EF65B98B4CA(var_0, var_1) {
  self detach(self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.model, self._encstr_952410E6DB537883206282F7DBAFBB7F9F44.tag);
  self.hashelmet = 0;
  self._encstr_952410E6DB537883206282F7DBAFBB7F9F44 = undefined;
}

_id_1470E(var_0) {
  return !accesscard::_id_13303(var_0, 1);
}

_id_146A4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = _id_14711(getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  for(;;) {
    level._id_146D7 = 0;

    foreach(var_3 in level.players)
    var_3.trial_targs = 0;

    foreach(var_6 in var_1) {
      var_6.isactive = 0;
      var_6._id_1252F = 0;
    }

    var_8 = [];

    foreach(var_3 in level.players) {
      if(_id_1470E(var_3))
        var_8[var_8.size] = var_3;
    }

    foreach(var_6 in var_1) {
      foreach(var_3 in var_8) {
        if(var_3 istouching(var_6)) {
          if(!istrue(var_3.trial_targs)) {
            var_3.trial_targs = 1;
            level._id_146D7 = level._id_146D7 + 1;
          }

          var_6.isactive = 1;
          var_6._id_1252F = var_6._id_1252F + 1;
        }
      }
    }

    level._id_146A3 = [];

    foreach(var_6 in var_1) {
      if(var_6.isactive) {
        level._id_146A3[level._id_146A3.size] = var_6;

        foreach(var_17 in level.vehicle.instances) {
          foreach(var_19 in var_17) {
            if(var_19 istouching(var_6))
              var_19 thread _id_14701();
          }
        }

        foreach(var_23 in level.mines) {
          if(isDefined(var_23) && isDefined(var_23.equipmentref) && var_23.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
            if(var_23 istouching(var_6))
              var_23 thread _id_14701();
          }
        }
      }
    }

    foreach(var_3 in level.players) {}

    var_28 = _id_14710();
    wait(var_28);
  }
}

_id_14701() {
  var_0 = createnavobstaclebyent(self, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");
  wait(_id_14710() - 0.05);

  if(isDefined(var_0))
    destroynavobstacle(var_0);
}

_id_14710() {
  return getdvarfloat("_encstr_82471FB2BE0597E88A96E8378D2A03E76130B0812387B0E17FDFA0E34738BB7551", 1.0);
}

_id_146AC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A74A0F6AD358C1D3A88BCA72D6F08B07F8");

  for(;;) {
    if(level._id_146AD vehicle_collision_init()) {
      thread _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146EE();
      return;
    }

    wait 1;
  }
}

_id_14711(var_0) {
  foreach(var_2 in var_0) {
    var_2._id_14723 = [];

    if(!isDefined(var_2.script_linkname)) {
      continue;
    }
    if(!isDefined(var_2.script_linkto)) {
      continue;
    }
    var_3 = var_2 scripts\engine\utility::get_linked_ents();

    if(var_3.size > 0) {
      foreach(var_5 in var_3)
      var_2._id_14723[var_2._id_14723.size] = var_5;
    }
  }

  return var_0;
}

_id_146FF(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A74A0F6AD358C1D3A88BCA72D6F08B07F8");
  var_1 = getdvarint("_encstr_8E941B26EBE63981A361E56F35AAE8EF4FBBDD2B5B677F6BA8A98FB813", 5);
  _id_146FD("_encstr_860817B56FA5E84367EE8FD3C21788F83DFFC9CD07CD683F86" + var_0.target + "_encstr_B25E0C82106EE04DF30CDA6ADC50" + level.deploy_subway_cars_on_track + "_encstr_8CDE082601305CB224D3");
  level._id_146EF = [];
  level._id_146AD = var_0;
  level._id_146D7 = 0;
  level._id_146A3 = [];
  var_2 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2.size == 0) {
    _id_146FD("_encstr_860817B56FA5E84367EE8FD3C21788F83DFFC9CD07CD683F86" + var_0.target + "_encstr_B8071147C0500B605675FF46B817F99F6F439B");
    return;
  }

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8"))
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");

  level thread _id_146A4(var_0);
  level thread _id_146AC();
  level thread _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146BA();
  _id_14707();
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 6000);

  foreach(var_5 in var_3)
  var_5.unsetbettermissionrewards = 1;

  if(level._id_14687.packs == 1) {
    foreach(var_5 in var_3)
    var_5 scripts\mp\hud_message::showsplash("_encstr_95210D5E020F3ABB247198B8EAFC6D");
  } else if(level._id_14687.packs == 2) {
    foreach(var_5 in var_3)
    var_5 scripts\mp\hud_message::showsplash("_encstr_88BB16FAFBE94D9F808678378FB05B976B9B09F391F9C9E7");
  }

  level thread _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_12666(var_0.origin);

  for(;;) {
    if(level._id_146D7 > 0) {
      var_11 = [];

      foreach(var_13 in level._id_146EF) {
        if(isalive(var_13)) {
          var_11[var_11.size] = var_13;
          continue;
        }

        if(isDefined(var_13))
          var_13 notify("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
      }

      level._id_146EF = var_11;

      if(get_checking_area_alias()) {
        var_15 = [];
        var_16 = getdvarint("_encstr_85061BF7FF0EC152B8CE80CDA01091BA701D7F7B673D890FC0D07B9579", 0);
        var_17 = getdvarint("_encstr_97EC19CDB1E4FA9839AFF4BD6B265AB2D7997BE4C656AF9D59B93A", 0);
        var_18 = [];

        foreach(var_20 in level._id_146A3) {
          var_18[var_18.size] = var_20;
          var_18 = scripts\engine\utility::array_combine(var_18, var_20._id_14723);
        }

        var_18 = scripts\engine\utility::array_remove_duplicates(var_18);

        foreach(var_20 in var_18) {
          var_23 = scripts\engine\utility::getStructArray(var_20.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

          foreach(var_25 in var_23) {
            if(!istrue(var_25.disabled)) {
              if(var_16) {
                if(isDefined(var_25.script_animation) && var_25.script_animation == "_encstr_A6D70D9B3858DDCDFA9D4E7BD59B46")
                  var_15[var_15.size] = var_25;

                continue;
              }

              if(var_17) {
                if(isDefined(var_25.script_animation) && var_25.script_animation == "_encstr_8B380F5A8B88F79AD89FEFD381E0825790")
                  var_15[var_15.size] = var_25;

                continue;
              }

              var_15[var_15.size] = var_25;
            }
          }
        }

        var_15 = scripts\engine\utility::array_randomize(var_15);

        for(var_28 = 0; var_28 < var_15.size && get_checking_area_alias(); var_28++) {
          var_25 = var_15[var_28];
          var_29 = level._id_14709[level._id_146F0];
          var_13 = _id_146FA("_encstr_BD8D1587E82B32910690277F1839537A877A8D3D465BCA", var_25.origin, var_25.angles, var_25, var_29);

          if(!isDefined(var_13)) {
            break;
          }

          level._id_146EF[level._id_146EF.size] = var_13;

          if(var_29 == level._id_146A0)
            level.deploy_suicide_truck_in_lumber_yard--;
          else if(var_29 == level._id_1469F)
            level.deploy_suicide_truck_in_farm--;
          else if(var_29 == level._id_1469E) {
            level.deploy_suicide_truck_in_blockade--;
            var_13 thread _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146B3();
          } else if(var_29 == level._id_146A2)
            level.deployable_cover_cancel--;
          else if(var_29 == level._id_1469D)
            level.deploy_subway_cars_on_track--;

          var_13 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146F5(var_29);
          var_13 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146F3(var_29);
          var_13 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_146F4(var_29);
          level._id_146F0++;
          wait(level.deployed);
        }
      }
    }

    wait(var_1);
  }
}

_id_14707() {
  level._id_14709 = [];
  level._id_14687.packs = 1;
  var_0 = [];
  var_1 = 0;
  var_2 = 0;

  if(level._id_14687._id_145A8 > 0) {
    switch (level._id_14687._id_145A8) {
      case 2:
        if(level.deploy_suicide_truck_in_lumber_yard < 0)
          level.deploy_suicide_truck_in_lumber_yard = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.05);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 3);
        break;
      case 3:
        if(level.deploy_suicide_truck_in_farm < 0)
          level.deploy_suicide_truck_in_farm = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.1);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 3);
        break;
      case 4:
        if(level.deploy_suicide_truck_in_blockade < 0)
          level.deploy_suicide_truck_in_blockade = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.1);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 5);
        break;
      case 5:
        if(level.deploy_suicide_truck_in_lumber_yard < 0)
          level.deploy_suicide_truck_in_lumber_yard = 6;

        if(level.deploy_suicide_truck_in_farm < 0)
          level.deploy_suicide_truck_in_farm = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.2);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 5);
        break;
      case 6:
        if(level.deploy_suicide_truck_in_lumber_yard < 0)
          level.deploy_suicide_truck_in_lumber_yard = 6;

        if(level.deploy_suicide_truck_in_blockade < 0)
          level.deploy_suicide_truck_in_blockade = 6;

        var_0 = [level._id_146A2];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.2);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 5);
        break;
      case 7:
        if(level.deploy_suicide_truck_in_lumber_yard < 0)
          level.deploy_suicide_truck_in_lumber_yard = 6;

        if(level.deployable_cover_cancel < 0)
          level.deployable_cover_cancel = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E, level._id_146A2, level._id_1469D];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.3);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 5);
        break;
      case 8:
        if(level.deploy_suicide_truck_in_farm < 0)
          level.deploy_suicide_truck_in_farm = 6;

        if(level.deployable_cover_cancel < 0)
          level.deployable_cover_cancel = 6;

        var_0 = [level._id_146A0, level._id_1469F, level._id_1469E, level._id_146A2, level._id_1469D];
        var_1 = getdvarfloat("_encstr_86552B7E1EE37FF1CACF78D82FF2A8B39906FB90779BE1BB81B760E0370A60FBE12AEF074B92EF416067C888FF", 0.3);
        var_2 = getdvarint("_encstr_86CA2D878F7EB122A8DEB0FDB01361AA402377BF7BA3CB0A68A6A8C5A8F8B9E2389F9BBFF7C021C12049A50BC060E1", 5);
        break;
      default:
        break;
    }

    if(var_0.size > 0) {
      if(randomfloat(1.0) < var_1) {
        level._id_14687.packs = 2;
        var_3 = randomint(var_0.size);

        for(var_4 = 0; var_4 < var_2; var_4++)
          level._id_14709[level._id_14709.size] = var_0[var_3];
      }
    }
  }

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_lumber_yard; var_4++)
    level._id_14709[level._id_14709.size] = level._id_146A0;

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_farm; var_4++)
    level._id_14709[level._id_14709.size] = level._id_1469F;

  for(var_4 = 0; var_4 < level.deploy_suicide_truck_in_blockade; var_4++)
    level._id_14709[level._id_14709.size] = level._id_1469E;

  for(var_4 = 0; var_4 < level.deployable_cover_cancel; var_4++)
    level._id_14709[level._id_14709.size] = level._id_146A2;

  if(level.deploy_subway_cars_on_track < 0)
    level.deploy_subway_cars_on_track = level._id_146CA - level._id_14709.size;

  for(var_4 = 0; var_4 < level.deploy_subway_cars_on_track; var_4++)
    level._id_14709[level._id_14709.size] = level._id_1469D;

  level._id_14709 = scripts\engine\utility::array_randomize(level._id_14709);
}

_id_146AE(var_0, var_1, var_2, var_3, var_4) {
  level notify("_encstr_8765123D2C96FAC6B76B83D5D159C9BE5DB9958C");

  if(!getdvarint("_encstr_852025F3D8256933FBAFCDCE27C1332FD7885AAAD1DD5B235370DEC7CBA83732F5D802A230B754", 0) && !isDefined(level.prematchstarted)) {
    return;
  }
  if(!issubstr(var_0.targetname, "_encstr_BACB074025B01AAA28")) {
    return;
  }
  if(var_0 vehicle_collision_init()) {
    return;
  }
  if(isDefined(level._id_146AD)) {
    var_3 scripts\mp\hud_message::showerrormessage("_encstr_B40E2C7DD957B85269C808195EADFB3D52A7014579E9487315F710A9C66377D7BBE1F1ED059FE9CEF8A191CC96FB");
    var_3 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    return 0;
  }

  if(!isDefined(var_0.targetname) || !isDefined(level._id_146B8) || var_0.targetname != level._id_146B8) {
    return;
  }
  level._id_146AD = var_0.targetname;
  level._id_146F0 = 0;
  level.create_ai_type_override = var_0.origin;
  var_0 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_13D96();
  level thread _id_146FF(var_0);
}

_id_146BB() {
  if(level._id_146E9)
    return self.spawner._id_146EA;
  else
    return undefined;
}

get_checking_area_alias() {
  if(level._id_146F0 < level._id_14709.size && level._id_146EF.size < level.deploy_subway_car_at_station)
    return 1;

  return 0;
}

vehicle_collision_init() {
  var_0 = self;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_3 = var_2 * var_2;

  if(distance2dsquared(var_0.origin, var_1) > var_3)
    return 1;
  else
    return 0;
}

_id_146FD(var_0) {}