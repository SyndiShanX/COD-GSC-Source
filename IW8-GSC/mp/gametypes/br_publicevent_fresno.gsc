/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_fresno.gsc
**************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_140CF = ::_id_140CF;
  var_0.weight = getdvarfloat("_encstr_83B31803B60289465BFF695BE7C29690BB4D081EDB7D608CD2BB", 100.0);
  var_0._id_14382 = ::_id_14382;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0.isfeaturedisabled = ::players_approach_puzzle_monitor;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0._id_11B78 = getdvarint("_encstr_95A31B6FB8EBF78A5518A29F6015C3959378A75750611881612BED975E", 2);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_AB8A07220BF587D528", "_encstr_A76627C00408100472538008C4810804B95310010202040101100401130C1880608040010301014060");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_AB8A07220BF587D528");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(16, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  var_0 = self;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C811B3358B9946AC7A8578BADF57333A668A3EF1050DF313FD55E820D"] = "_encstr_BE2615CF6BC0F7630BB39239596D272EF9F949448320BA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962620A9388A45F8369623B6EFE3CBA367075BEFA36EE8BFA440410FC2488B62A34B"] = "_encstr_BED10F9DFE99FA3F3B181FA35893E9B369";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFB81A02B3087482BEB797233BD09BA33959714A0B78073A85C59F63"] = "_encstr_B4FF17DFA58D6A56200178C99B4074E2D067032F41AED211F8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6101A5B0B3A38EB5217BB95176AAD38EF6426B3F36128946A9BA349"] = "_encstr_8C0F160471A8B7E3FB0BBF6B639D8AFE793B3F4B0B18414B";
  var_0.secondsbeforeplacementupdates = getdvarint("_encstr_97FB1CCDB14EFA13E4FAE02B7D339C56DC9BF6AF1AB20B633AD0F5389527", 2000);
  level._id_11E18.playerredeploy = getdvarint("_encstr_AF3F1FAE3BEAC92E9A178038DF4B5B9D03A22F014068F5BAB3A281CA0648CB7DBB", 11000);
  level._encstr_A3601745F2A9F8C50F1A2B7172C38F08F16BDF2B980BC81B4B = 0;
  setdvarifuninitialized("_encstr_AA4E1FC39AE897CE10DF998A4F850373307585B91B98AB6821C3B8F34F09938B7B", 5000);
  setdvarifuninitialized("_encstr_91E51DB96CE47D264EEB8359BECC3959E6E6B7FA1AEE6CF53358C82BACCD8C", 7000);
  var_0 thread _encstr_8BB414D85FAFE81DEA2B1D9083A257D31EB37038EF4E();
  level._id_11E18._encstr_885A0DCC39B29BF4F2D7B1DEEAB9E8 = 0;
  level._id_11E18._encstr_8D6315F675B80D73234EEB9390744F8778476176E11050 = getdvarint("_encstr_921B22F7D3C8CE0D934FA09F07E27B10FBCD5581C678423DF7A847E3A9C495B8A7873BB6", 0);
  thread strip_node_flag_wait();
  _encstr_952913E4B382D0BF6362B30FD6EF77475A5169C38F();
  thread _encstr_BA9D10B5B79BD28EF69CFA8DA54E8D639537();
  thread _encstr_B8E90E1A752139A279D0539750D06542();
}

_encstr_B8E90E1A752139A279D0539750D06542() {
  level._id_11E18.basetime = gettime();
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_11E18.basetime = gettime();
}

_encstr_84670E87C34BCF9AD56369A76BB8855F() {
  return (gettime() - level._id_11E18.basetime) / 1000;
}

_encstr_BA9D10B5B79BD28EF69CFA8DA54E8D639537() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
    var_1 = level.br_level.br_circledelaytimes[var_0 - 1];
    var_2 = level.br_level.br_circleclosetimes[var_0 - 1];
    var_3 = level.br_level.br_circledelaytimes[var_0];
    level._id_11E18._encstr_8C841503DFA1FFB1A710737A20F3F9B7D835A79C636827 = gettime() + 1000 * (var_1 + var_2 + var_3);
  }
}

_encstr_8BB414D85FAFE81DEA2B1D9083A257D31EB37038EF4E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_11E18._encstr_B61C10B2B3B29BE89B47B09347D1966BB2E6 = _encstr_82F019B307EF1A652DA0C96628B07E5D9B701380C8AF9B05D4B58F(getDvar("_encstr_ADE521979F424FB28B29777B69B69D0717ED47475AC0DB0AB3671DAFD75BD183ABF5E1", "_encstr_AD7C0C0B2330422F3E8A3B31E267"));
  level._id_11E18._encstr_8C3012B2CECA9B1D77B0C937D2CDB31DB4B6CA9B = _encstr_82F019B307EF1A652DA0C96628B07E5D9B701380C8AF9B05D4B58F(getDvar("_encstr_8B941F5A366D79F2DB61633F4971BA8207D825D9ABED7237C0C8232F316B69CAF3", "_encstr_A9350A2E180D03D9627A1592"));
  _encstr_8A5E16F86674AB700DFFA120CF2C47D87BF8FF26F9111D7F();
  _encstr_9B9E180F752572E4906823EDE340373B088F87ABE95DFBA6B810();
}

_encstr_82F019B307EF1A652DA0C96628B07E5D9B701380C8AF9B05D4B58F(var_0) {
  var_1 = [];

  if(var_0 != "_encstr_B40101") {
    var_2 = strtok(var_0, "_encstr_974C0246");

    foreach(var_4 in var_2)
    var_1[var_1.size] = float(var_4);
  }

  return var_1;
}

_encstr_8A5E16F86674AB700DFFA120CF2C47D87BF8FF26F9111D7F() {
  level._id_11E18._encstr_A60B0E3AA3DDCB6B8147E1E25FC0F777 = [];

  for(var_0 = 0; var_0 < level._id_11E18._encstr_B61C10B2B3B29BE89B47B09347D1966BB2E6.size; var_0++) {
    var_1 = level._id_11E18._encstr_B61C10B2B3B29BE89B47B09347D1966BB2E6[var_0];
    var_2 = 0;
    var_3 = -1;

    for(var_4 = 0; var_4 < level.br_level.br_circledelaytimes.size; var_4++) {
      var_2 = var_2 + (level.br_level.br_circledelaytimes[var_4] + level.br_level.br_circleclosetimes[var_4]);

      if(var_1 <= var_2) {
        var_3 = var_4;
        break;
      }
    }

    level._id_11E18._encstr_A60B0E3AA3DDCB6B8147E1E25FC0F777[var_0] = var_3;
  }
}

_encstr_9B9E180F752572E4906823EDE340373B088F87ABE95DFBA6B810() {
  for(var_0 = 0; var_0 < level._id_11E18._encstr_B61C10B2B3B29BE89B47B09347D1966BB2E6.size; var_0++) {
    var_1 = level._id_11E18._encstr_B61C10B2B3B29BE89B47B09347D1966BB2E6[var_0];
    var_2 = level._id_11E18._encstr_8C3012B2CECA9B1D77B0C937D2CDB31DB4B6CA9B[var_0];
    var_1 = var_1 - var_2;
    wait(var_1);
    _encstr_BAA90CF82E0D08CE021F7D531BEB(var_2);
  }
}

_encstr_BAA90CF82E0D08CE021F7D531BEB(var_0) {
  if(!isDefined(level._id_11E18)) {
    return;
  }
  if(isDefined(level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829)) {
    iprintln("_encstr_BECB4707B68280431A9F7D5103039DA0268D61585AB8E00C3257E5CB8B3A7788C3A3F033463428304A521DEB8F232D508C2D51A8ABC850F6863F29CDF78AE5D8701263C0D5F9A0A4BE");
    return;
  }

  if(isDefined(level._id_11E18.setincomingremovedcallback) && isDefined(level._id_11E18.setincomingremovedcallback._id_12930) || isDefined(level._id_11E18.wait_for_next_hack_complete) && isDefined(level._id_11E18.wait_for_next_hack_complete._id_12930)) {
    iprintln("_encstr_BECB4707B68280431A9F7D5103039DA0268D61585AB8E00C3257E5CB8B3A7788C3A3F033463428304A521DEB8F232D508C2D51A8ABC850F6863F29CDF78AE5D8701263C0D5F9A0A4BE");
    return;
  }

  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_86661198E4BE0759EB664E2B6E37ED7D4BB9D8");
  level notify("_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B");
  thread _encstr_AA1C0F16368E4BCEC247561DDB6BC2436E(var_0);
  wait 8.0;
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 0);
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 11);
  var_0 = var_0 - 8.0;
  var_1 = gettime() + var_0 * 1000;
  setomnvar("_encstr_974F15AEB4D783BAC4B1A56C563B95B947BE1DB4D6CAC9", var_1);
  wait(var_0);
  thread _encstr_AB2C0E29DE7C403402CBEBE3EB6A70F0();
}

attackerswaittime() {
  _encstr_BAA90CF82E0D08CE021F7D531BEB(14);
}

_id_140CF() {
  return scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9286085A21B8034D3863" && isDefined(level._id_11E18);
}

_id_14382() {}

_encstr_AA1C0F16368E4BCEC247561DDB6BC2436E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.active = 1;
  var_1 = gettime() + (var_0 + getdvarfloat("_encstr_838D1A0E6E930FE1DADF18B8F7E63BA36BD58880059A3549A41FC8A0", 120.0)) * 1000;
  level._id_11E18._encstr_BACB0B10A7216ADA2060F05525 = var_1;
  level._id_1406F = 1;
  level._id_11A1F = [];
  level._id_1395A = [];
  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_givehcrdata();

  if(isDefined(level._id_11E18.setincomingremovedcallback) && isDefined(level._id_11E18.wait_for_next_hack_complete)) {
    var_2 = getDvar("_encstr_9BD91A6E1BC9F5C427FA0E56BE9993B237CDDE7DC82DACBEE4DEB163");

    if(var_2.size == 0) {
      level._id_11E18.setincomingremovedcallback._id_12930 = ::sentry_init_done;
      level._id_11E18.wait_for_next_hack_complete._id_12930 = ::vehicle_rider_think;
      return;
    }

    var_3 = randomint(10);
    var_4 = int(var_2);

    if(var_4 > -1)
      var_3 = var_4;

    if(var_3 < 3 || var_3 >= 6)
      level._id_11E18.setincomingremovedcallback._id_12930 = ::sentry_init_done;

    if(var_3 >= 3) {
      level._id_11E18.wait_for_next_hack_complete._id_12930 = ::vehicle_rider_think;
      return;
    }

    return;
  } else {
    var_5 = "_encstr_838D26966DF361A9EE6BB00833EF71AB6A538816C20E1749A22FA220CB39F3E392FD77969D320339";

    if(isDefined(level._id_11E18.setincomingremovedcallback))
      level._id_11E18.setincomingremovedcallback._id_12930 = ::sentry_init_done;
    else if(isDefined(level._id_11E18.wait_for_next_hack_complete))
      level._id_11E18.wait_for_next_hack_complete._id_12930 = ::vehicle_rider_think;
  }
}

_encstr_AB2C0E29DE7C403402CBEBE3EB6A70F0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_11E18._id_12F14 = ::lootleadermarksizedynamic;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_885413B188871A97271A0D3D80D230DFBE29511364");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8C811B3358B9946AC7A8578BADF57333A668A3EF1050DF313FD55E820D");
  setomnvar("_encstr_838C1D0DEC415103CA13D0881FF6D9B51B99899B859A23C9A0C72020C32B91", 1);
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 8);
  setomnvar("_encstr_974F15AEB4D783BAC4B1A56C563B95B947BE1DB4D6CAC9", level._id_11E18._encstr_BACB0B10A7216ADA2060F05525);
  thread _id_11CDC(level._id_11E18._encstr_BACB0B10A7216ADA2060F05525);
  var_0 = register_vehicle_spawn_override();
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(istrue(level.disable_super_in_turret._id_12CA4))
      var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_3);
    else
      var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_3);

    var_1 = var_1 + var_4.size;
  }

  self.secondwindthink = var_1 * self.secondsbeforeplacementupdates;
  teamlist();
  totaldamage();
  thread _id_13FD0();
  level._id_11E18.players_grenade_fire_monitor = 0;

  if(level._id_11E18._encstr_8D6315F675B80D73234EEB9390744F8778476176E11050 != 0)
    _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_839F14BFE198DA5B0873CE92A9F09DB2EE211F7B5BB0();

  level._id_11E18._encstr_885A0DCC39B29BF4F2D7B1DEEAB9E8++;
  level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829 = 1;
  level waittill("_encstr_A9560B9993956E9B7BF595E691");
}

attackerisinflictorforradiusexplosiveweapon(var_0, var_1) {
  if(getdvarint("_encstr_A6F71F93EB0561537BB153953E914E22BE7880B7B3E786986A7CAF6635863D089B", 0)) {
    return;
  }
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, level._id_11E18.playerredeploy, 50000);
  var_2.radius = level._id_11E18.playerredeploy;
  var_1.cashtorefund = var_2;

  if(scripts\mp\outofbounds::unset_relic_rocket_kill_ammo(var_2.origin)) {
    _id_136B1(var_2);
    _id_136A3(var_2);
    _encstr_AD9F1BE07B8C0B2BCACA78F023E279B0F33358409B2F23DF92726689FF(var_2);
  }
}

_encstr_990815285F2B78740B6DB1F36FD8F7A69291036FDAA8C8(var_0, var_1) {
  if(level._id_11E18._encstr_8D6315F675B80D73234EEB9390744F8778476176E11050 < 0 || level._id_11E18._encstr_8D6315F675B80D73234EEB9390744F8778476176E11050 > 0 && level._id_11E18._encstr_8D6315F675B80D73234EEB9390744F8778476176E11050 == level._id_11E18._encstr_885A0DCC39B29BF4F2D7B1DEEAB9E8) {
    if(var_1 < var_0.radius) {
      var_2 = var_1 / var_0.radius;
      var_3 = max(var_2, 0.95);
      var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0.origin, var_0.radius, var_2, var_3, 0, 0);

      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius() > 0) {
        if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_4) == 0) {
          var_4 = (var_4[0] * -1, var_4[1], var_4[2]);

          if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_4) == 0) {
            var_4 = (var_4[0], var_4[1] * -1, var_4[2]);

            if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_4) == 0) {
              var_4 = (var_4[0] * -1, var_4[1], var_4[2]);

              if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_4) == 0) {
                var_4 = undefined;
                iprintln("_encstr_A3031F252F3A9998DCB64B20DE93684773AB61D7CF73D570FDFFF3D1367A28050A");
              }
            }
          }
        }
      }

      if(isDefined(var_4)) {
        var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_4);
        _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_95582236E0177B45C5B2C880EB5D17534F9730A346A723A7EADAA8D08272C1899B09CE2D(var_0.origin, var_4);
      }
    }
  }
}

_id_136B1(var_0) {
  level._id_11A1F[level._id_11A1F.size] = var_0;
  _encstr_AACB36DC3639D207A3DCCB6B1CBC76C25BB21DE5C156CDF289E4EBE057318DD26C59CE59DCD1F5C6B77B47B19C161DB2324EF6838B9DCD8D::aud_breached_exit_wind();
}

_id_136A3(var_0) {
  var_1 = getdvarint("_encstr_96E3144632B3476A5B27B260C6FACA57E766E0096639", 5);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawnStruct();
    var_3.origin = _encstr_AACB36DC3639D207A3DCCB6B1CBC76C25BB21DE5C156CDF289E4EBE057318DD26C59CE59DCD1F5C6B77B47B19C161DB2324EF6838B9DCD8D::return_same_module_as_next_module(var_0.origin, var_0.radius);
    var_3.origin = (var_3.origin[0], var_3.origin[1], var_3.origin[2] + getdvarfloat("_encstr_ACD01B9B1B27AF4C9CAFCC27569B73BDBE47395DB1B5EB1AB2B49DD0A3", 6000.0));
    var_3.angles = var_0.angles;
    var_4 = _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::tryspawnavehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_3, "_encstr_8E520CA189533FE85731A38A2855", undefined);

    if(isDefined(var_4))
      level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DE4(var_4, var_3.origin, var_3.angles, 1);
  }
}

table_parseweaponvariantidvalue() {
  if(istrue(level._id_11E18.players_grenade_fire_monitor)) {
    return;
  }
  level._id_11E18.players_grenade_fire_monitor = 1;
  var_0 = gettime() + getdvarfloat("_encstr_838D1A0E6E930FE1DADF18B8F7E63BA36BD58880059A3549A41FC8A0", 120.0) * 1000;
  level._id_11E18.playerregenhealthadd = var_0;
  _encstr_88A91E160DDF5A158BD39FFB2F4EDB0B3017CE6D825B92C7A02AB928F8450158();
}

strip_node_flag_wait() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  waittillframeend;
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC");
  var_0._encstr_A98414E0521A0B8163BD6EDE912BA9D982DAB8F83A70 = 1;
  var_0._encstr_930D0EB71B57A2DA30E80713B8C9837A = 1;
  var_0._encstr_850C166F3B1205A0B49C0379848B88C8FAC3E3DD83CA5DA8 = "_encstr_8265154359B0CE97D7EECAC20EDEE6D7B6599B8C7BE885";
  level._encstr_ABB31C8927FAE056AF1B93B03A95FAD59B561D96B5AC7BD9B227C996C8AC = var_0.ownerusetime;
  level.delaystreamtomovingplane = 1;
  level.shrink_poi_into_the_bank.besttimestate = 0;
  level.shrink_poi_into_the_bank._id_13EFF = [["_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_AD8A1DAAAB306DDFA5379B10BB61058E07A6D8FBFAEDECDB09812B407AACF3", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_9AB11CF6BA7B200FCB2958C0E2E2D7D85F428D7E09BB0B497902B0094B68", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"]];
  level.shrink_poi_into_the_bank.chopper_gunner = [["_encstr_8A19228A38717D1F1338E7EDCF7BD7C5EFD877D170C3391BE999E8E8D7CBFAC133582AAA", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"], ["_encstr_939E2013686C78BD79878F820192BF8B4F030B7E3529D7C901DCE15147DEE513A2EA", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"], ["_encstr_B4DC219636C9E27793D9F7A7304B3FBAD7CE8B41917B398DD318EBBFE080D78303E6A7", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"]];
  level.shrink_poi_into_the_bank.waypoints = [["_encstr_8D2021325B21A7C58097475D83C88DDBC013CF69AD0CAFFF78D358213DCA591B750952", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_8134219606F087B0A3811895928B2F7AF18B3B076DBF41032FCF0982F7FAE1B932F9C2", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_8AA223B1626C78B04B6FF7EBAF33883807BAF36ECDCF41F5737FCDFFD70AEF1AEFD541E177", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_9332225A33493F5D282FEFC56B306573788BB7F1B89447D6F0A7FDCD1F423B6F19E11ADA", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_886E22C44EB1B7B7A3AFBB598538EDB9AFB5599B23DBD1B0D737E67D87AD96ADCA4C03E4", "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6"], ["_encstr_8DEF22B6FA3B604F8B691880A2A217189F9D4D38448FCB9BB9520849CBFBC3D0A7376D0F", "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6"]];
  level.shrink_poi_into_the_bank.waypoint_icon = level.shrink_poi_into_the_bank.waypoints;
  level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911 = [["_encstr_B4C917454B4230F0E441706937D0C8F89A9723D7ABDA05281E", 2], ["_encstr_A7F5186B7A448F67735F2F9F072B617E6859A399D1552A585465", 2], ["_encstr_81D6144C4E63B7F6477D7B9933342CB9327D339358D9", 2]];
}

tac_cover_spawn_with_door() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_8D7E1429D2770D18E8C0631FEAD718CDA32AE1F01A8F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2140B22D9CD77E4F9C1756BE7"] = "_encstr_B29F19B14AEFE5F010388B87547F80BE7FD349BB937B2CA0ED0383";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3CC128B305334B193FFCD89DE996AE619E80B5F"] = "_encstr_BECC16DAFEAD3A0F3BD0B7EF5096E48247956996E923637D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4CE18E49513D24E47D07DB0B359CDECCAD7E89585B5D6858EAC"] = "_encstr_B4CE18E49513D24E47D07DB0B359CDECCAD7E89585B5D6858EAC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84A0116030A58FCA831B2E186558091BD878D0"] = "_encstr_84A0116030A58FCA831B2E186558091BD878D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9571117507B22308D4BC4639E4BBD8EE2A6FC1"] = "_encstr_82C61F5B5BBE1AFA2070A1F2C9103E2280CD979F235532B4511924BA612074AAED";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC030F2243FA28039C50BE0573D1B0BD47"] = "_encstr_8A4A1D9C2B265A4ED186BE93B2B4DC667B39B1CAADCA9BE8BEB2DC912DCDEC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ADC1927CA4CB4E43A86F58E2B2CD6B6B0A3ACD72795DC382CBBCD"] = "_encstr_9ADC1927CA4CB4E43A86F58E2B2CD6B6B0A3ACD72795DC382CBBCD";
}

_id_11CDC(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A9560B9993956E9B7BF595E691");

  for(;;) {
    var_1 = gettime();

    if(var_1 >= var_0) {
      break;
    }

    waitframe();
  }

  thread playerrespawncleanup();
}

vehicle_rider_think(var_0) {
  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::_encstr_886113FA08831ED3B380565AADD8E3A01198422210(var_0);
  var_0 thread _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::_encstr_97530D8E395D73B4C8B195EE16B4D1("_encstr_A983215069F9776901522725C7FB78DF710BE7D04F971287E8120B63C7D33569780277");

  while(!istrue(level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829))
    waitframe();

  table_parseweaponvariantidvalue();

  if(!isDefined(var_0.cashtorefund)) {
    var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.origin, 0, level._id_11E18.playerredeploy, 50000);
    var_1.radius = level._id_11E18.playerredeploy;
    var_0.cashtorefund = var_1;
  } else
    var_1 = var_0.cashtorefund;

  var_0._encstr_84DB0843055A4A5BE528 = undefined;

  if(isDefined(level._id_11E18._encstr_ABF70B6E8D93B2C26B56C9AD5B))
    level thread _encstr_990815285F2B78740B6DB1F36FD8F7A69291036FDAA8C8(var_1, var_0.agent_radius);

  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_885018500AB4FB59EB297CFD07F7A0BB1E528849828E3511875A", 0);
  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::wait_juggernaut_announce(var_0);

  while(_encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::vehicle_occupancy_showcashbag(var_0)) {
    _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::wait_for_tank_death(var_0);

    if(_encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::vehicle_occupancy_showcashbag(var_0))
      _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::wait_for_tanks_almost_gone(var_0);
  }

  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A5B511785EED15C75371209D282F480B9AF275", 0);
  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::_encstr_AACE10D6C9CAA35D939B8EDBCDBD936B2CC6(var_0);

  if(isDefined(level._id_11E18._encstr_ABF70B6E8D93B2C26B56C9AD5B)) {
    level._id_11E18._encstr_ABF70B6E8D93B2C26B56C9AD5B = undefined;
    level thread _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_B18B10D58D2763152D6B98103347EB98D722();
  }

  var_0._id_11EA7 = 1;
  var_0.cashtorefund = undefined;
  level._id_11E18.wait_for_next_hack_complete._id_12930 = undefined;

  if(!isDefined(level._id_11E18.setincomingremovedcallback._id_12930))
    level thread playerrespawncleanup();
}

sentry_init_done(var_0) {
  var_1 = getdvarfloat("_encstr_88291B9BE3ADF1A6131E77732F6BA39AF8CBA007A2B3797FD033431733", 1.16667);
  var_2 = vectorNormalize(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin() - var_0.origin);
  var_3 = level._id_11E18.playerredeploy * var_1;
  var_4 = var_0.origin + var_2 * var_3;
  level._id_11E18.score_event_headshot = undefined;
  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::_encstr_834B13D90DCA0BC8A3DB339359CDF4971CBD4B9B3A(var_0);
  var_0 thread _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::_encstr_97530D8E395D73B4C8B195EE16B4D1("_encstr_833E221A2B771D6FA9A23D2DE7CB6ABF3ABFB4FAC0DD778C7F0D8048637065F5EC50DF47");

  while(!istrue(level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829) && _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(16))
    waitframe();

  table_parseweaponvariantidvalue();
  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_885018500AB4FB59EB297CFD07F7A0BB1E528849828E3511875A", 0);

  if(!isDefined(var_0.cashtorefund)) {
    var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, level._id_11E18.playerredeploy, 50000);
    var_5.radius = level._id_11E18.playerredeploy;
    var_0.cashtorefund = var_5;
  } else
    var_5 = var_0.cashtorefund;

  var_0._encstr_84DB0843055A4A5BE528 = undefined;

  if(isDefined(level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1))
    level thread _encstr_990815285F2B78740B6DB1F36FD8F7A69291036FDAA8C8(var_5, 0);

  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::set_dvars(var_0);

  while(_encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::post_blockade_breadcrumb_struct(var_0)) {
    _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::select_woods_two_spawners(var_0);

    if(_encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::post_blockade_breadcrumb_struct(var_0))
      _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::send_munition_used_notify(var_0);
  }

  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A5B511785EED15C75371209D282F480B9AF275", 0);
  _encstr_92CA36CD6C394BC13A9BBCAD385E76B0D6B23A5E832BE6CB334ECAE6CDDBF266E4CADCB9DEFA6E47858E59EBDA0B6C1A969BAC9B5CECDCB1::set_door_open(var_0);

  if(isDefined(level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1)) {
    level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1 = undefined;
    level thread _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_B18B10D58D2763152D6B98103347EB98D722();
  }

  var_0._id_11EA7 = 1;
  var_0.cashtorefund = undefined;
  level._id_11E18.setincomingremovedcallback._id_12930 = undefined;

  if(!isDefined(level._id_11E18.wait_for_next_hack_complete._id_12930))
    level thread playerrespawncleanup();
}

playerrespawncleanup() {
  _id_11EC4();
  level._id_11E18._encstr_BACB0B10A7216ADA2060F05525 = undefined;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::neurotoxin_mask_monitor(16);
}

players_approach_puzzle_monitor() {
  setomnvar("_encstr_838C1D0DEC415103CA13D0881FF6D9B51B99899B859A23C9A0C72020C32B91", 0);
  setomnvar("_encstr_A2F81A5B20A0D34B08F94153F3F017E35D9EC3020805030950FB505D", 0);
  wait 0.1;
  mp_port2_gw_patch();
  _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_84E62638AB74A1E55265CD40BDCA0909CD138028DF079893CACF465652E25BD0058B23283BA9F1B3();
  _encstr_91A018C9AC6CBDC9C89567CAB94759CD8C85E68563F2A32D1B9B();
  _encstr_A5A6111A154C0895C66D90520283372117DF47();
  level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829 = undefined;
}

_id_11EC4() {
  level notify("_encstr_A9560B9993956E9B7BF595E691");
}

post_safeges_weapon() {
  var_0 = [];
  var_0[var_0.size] = (-6969, -62217, -628);
  var_0[var_0.size] = (35110, -65651, -628);
  var_0[var_0.size] = (49127, -52078, -628);
  var_0[var_0.size] = (57520, -35449, -628);
  var_0[var_0.size] = (60361, 48474, -628);
  var_0[var_0.size] = (22320, 64983, -628);
  var_0[var_0.size] = (-22917, 64110, -628);
  var_0[var_0.size] = (-34118, 57593, -628);
  var_0[var_0.size] = (-35796, 38018, -628);
  var_0[var_0.size] = (-53281, 23823, -628);
  var_0[var_0.size] = (-53567, 1284, -628);
  var_0[var_0.size] = (-57725, -12233, -628);
  var_0[var_0.size] = (-57067, -18613, -628);
  var_0[var_0.size] = (-28765, -49330, -628);
  level._id_11E18.setlethalonunresolvedcollision = var_0;
}

teamlist() {
  var_0 = getDvar("_encstr_867720AB1F48096B550692DBA9B6A3FDC9832414B3984CD70859AA33F60DD7F6E863", "_encstr_8E9E09CC0C08538101CD81");
  var_1 = strtok(var_0, "_encstr_974C0246");

  if(var_1.size != 3)
    var_1 = strtok("_encstr_8E9E09CC0C08538101CD81", "_encstr_974C0246");

  level._id_11E18.cave_barrels = [];
  level._id_11E18.cave_barrels["_encstr_A1270AE8AA22E9EEDB75A7A9"] = int(var_1[0]);
  level._id_11E18.cave_barrels["_encstr_9A310C088A0569481FEF8D0DA967"] = int(var_1[1]);
  level._id_11E18.cave_barrels["_encstr_B4A50CE03AD88753CF5698823516"] = int(var_1[2]);
}

propspectating(var_0, var_1) {
  if(!isDefined(level._id_11E18.cave_barrels))
    return undefined;

  level._id_11E18._id_12F14 = ::lootleadermarksizedynamic;
  var_2 = undefined;
  var_3 = randomint(100);
  var_3 = getdvarint("_encstr_964921F7716EFE25330E4A351FA10E3BC7EE9778E73370A75912C965B999614BB59BD9", var_3);

  if(var_3 < level._id_11E18.cave_barrels["_encstr_9A310C088A0569481FEF8D0DA967"]) {
    var_4 = _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::recharge_equipment_init(var_3 < level._id_11E18.cave_barrels["_encstr_A1270AE8AA22E9EEDB75A7A9"]);

    if(isDefined(var_4)) {
      var_5 = self.cashtorefund _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::quarry2_ambient_sound_load(var_4);

      if(isDefined(var_1)) {
        var_6 = var_1.team;
        var_7 = var_1 getsquadindex();
        var_8 = var_5;
        var_5 = [];

        foreach(var_10 in var_8) {
          if(var_10.team != var_6 || var_10 getsquadindex() != var_7)
            var_5[var_5.size] = var_10;
        }
      }

      if(var_5.size > 0) {
        var_12 = randomint(var_5.size);
        var_2 = var_5[var_12];
      } else {}
    }
  }

  if(!isDefined(var_2) && var_3 < level._id_11E18.cave_barrels["_encstr_B4A50CE03AD88753CF5698823516"]) {
    var_2 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_8210145BECC039CA45C0A3D9B87831332402638F185B(self);

    if(isDefined(var_2)) {}
  }

  if(!isDefined(var_2)) {
    var_2 = self.cashtorefund _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::printspawnmessage(var_0, level._id_11E18.playerredeploy, var_1);

    if(isDefined(var_2)) {}
  }

  if(!isDefined(var_2))
    var_2 = self.cashtorefund _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::pristinestatehealthadd(var_0, level._id_11E18.playerredeploy);

  return var_2;
}

totaldamage() {
  level._id_13AAA = [];

  foreach(var_1 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_1]) && isDefined(level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"]) && level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
      level._id_13AAA[var_1] = 0;
  }

  foreach(var_4 in level.players) {
    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5._id_13BEE = 0;
      var_5._id_14239 = 0;
      var_5.open_cac_slot = 0;
      var_5._id_1457E = 0;
      var_4._id_12532 = var_5;
    }
  }

  level._id_11E18._id_13BEF = [];
  level._id_11E18._id_13BEF["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"] = 0;
  level._id_11E18._id_13BEF["_encstr_86EA0F2767A56AEA69611A27D9180242FB"] = 0;
}

_id_13FD0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  level endon("_encstr_A9560B9993956E9B7BF595E691");
  var_0 = 0.1;
  var_1 = level.delayedeventtypes[16].secondwindthink * 2;
  var_2 = 1;

  for(;;) {
    var_3 = relic_mythic_should_do_pain();
    var_4 = var_3[0][0];
    var_5 = var_3[0][1];
    var_6 = var_3[1][0];
    var_7 = var_3[1][1];
    var_8 = level._id_11E18._id_13BEF["_encstr_86EA0F2767A56AEA69611A27D9180242FB"] + level._id_11E18._id_13BEF["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"];
    var_9 = var_8 / var_1;
    setomnvar("_encstr_8F7D1A4DAC011141B77B48F807AE5817DB5545DF45B9F1097D7FD8E0", var_9);
    var_2 = var_5 / var_1;
    setomnvar("_encstr_9A7326BA5A7D1C95AF33C95637DCDED7334B9CCDA3EB0EC6C23656D7372EBA1632EB91B06B58ECAC", var_2);

    foreach(var_11 in level.players) {
      var_12 = updateplayerandteamcountui(var_11);
      var_11 setclientomnvar("_encstr_AB731983E3578B8F5F2326156BF5B86F1307410BADBF1BD91827FF", 1);
      var_2 = 0;
      var_13 = level._id_13AAA[var_11.team];

      if(isDefined(var_13))
        var_2 = var_13 / var_1;

      var_11 setclientomnvar("_encstr_8EDC219F22CF0BBB2F7F93901F0A98E750CD17E0559827F7D1183E0578DAC05BFE44B7", var_2);
    }

    wait(var_0);
  }
}

sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = var_1;

  if(isDefined(var_1.classname) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")) {
    if(isDefined(var_1.owner))
      var_14 = var_1.owner;
  }

  if(isPlayer(var_14)) {
    var_14 _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_A2421838B185CBB227EA0E32B01DCAE8DBDAB0431958DAC27659(self, var_2, var_4, var_5, 1);

    if(!istrue(level._id_11E18._encstr_A73C0D0B753DBBE6F896EA37497829) || level._id_11E18._id_13BEF[self.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
      return;
    }
    if(!isDefined(level._id_13AAA[var_14.team]))
      level._id_13AAA[var_14.team] = 0;

    if(!isDefined(var_14._id_12532)) {
      var_15 = spawnStruct();
      var_15._id_13BEE = 0;
      var_15._id_14239 = 0;
      var_15.open_cac_slot = 0;
      var_15._id_1457E = 0;
      var_14._id_12532 = var_15;
    }

    if(vault_assault_infil(var_0, var_1)) {
      var_2 = _id_11CA1(var_2, var_0, var_1);
      var_2 = _encstr_BAC61588E5D0EA3B20C8D059241FF4DF55F07899A4EBD1(var_2);
      var_14._id_12532._id_14239 = var_14._id_12532._id_14239 + var_2;
    } else if(isexplosivedamage(var_4)) {
      var_2 = var_2 * getdvarfloat("_encstr_83741EDC1BE4FAC4E4BEE0ACEB3339596EB9BD7DB2871C36F5C8ADCEDABA3647", 5.0);
      var_2 = _encstr_BAC61588E5D0EA3B20C8D059241FF4DF55F07899A4EBD1(var_2);
      var_14._id_12532.open_cac_slot = var_14._id_12532.open_cac_slot + var_2;
    } else {
      var_2 = var_2 * getdvarfloat("_encstr_8CDB1E676F9E51C2087E92DF96401A0AF69D8F5FFF4DFAA83921CDA7C8E05C53", 1.0);
      var_2 = _encstr_BAC61588E5D0EA3B20C8D059241FF4DF55F07899A4EBD1(var_2);
      var_14._id_12532._id_1457E = var_14._id_12532._id_1457E + var_2;
    }

    level._id_13AAA[var_14.team] = level._id_13AAA[var_14.team] + var_2;
    var_14._id_12532._id_13BEE = var_14._id_12532._id_13BEE + var_2;
    var_14 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", 0, 0, "_encstr_A5AE098ADB583E0AF7A5AB", 0, 1);
    var_14.players_in_aggro = self.agent_type;
    level._id_11E18._id_13BEF[self.agent_type] = level._id_11E18._id_13BEF[self.agent_type] + var_2;

    if(level._id_11E18._id_13BEF[self.agent_type] > level.delayedeventtypes[16].secondwindthink)
      self notify("_encstr_B1920ED9AD7D469CA5D9CA9BD7F69999");

    var_16 = level._id_11E18._id_13BEF[self.agent_type] / level.delayedeventtypes[16].secondwindthink;

    if(self.agent_type == "_encstr_B6B00E2383C3A0EEAF7A69704267AB98")
      setomnvar("_encstr_B1A61EAB4BEB07B27D999CCA9B73B77DC139F6D92759B9377D6D2B9BED9B1AC2", var_16);
    else if(self.agent_type == "_encstr_86EA0F2767A56AEA69611A27D9180242FB")
      setomnvar("_encstr_9B911FAE2DF5832B7D66E495CDB97BEB0E39EDEC93566EDCF5EC93B259E64C582F", var_16);
  }
}

secondaryweaponbackup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {}

relic_mythic_should_do_pain() {
  if(!isDefined(self.is_wave_exist))
    self.is_wave_exist = [["_encstr_8BBA05185F8B99", -1], ["_encstr_8BBA05185F8B99", -1], ["_encstr_8BBA05185F8B99", -1], ["_encstr_8BBA05185F8B99", -1]];

  foreach(var_5, var_1 in level._id_13AAA) {
    for(var_2 = 0; var_2 < self.is_wave_exist.size; var_2++) {
      var_3 = self.is_wave_exist[var_2][0];
      var_4 = self.is_wave_exist[var_2][1];

      if(var_1 > var_4 || var_3 == var_5) {
        if(var_5 != var_3 && var_2 + 1 < self.is_wave_exist.size)
          self.is_wave_exist[var_2 + 1] = self.is_wave_exist[var_2];

        self.is_wave_exist[var_2][0] = var_5;
        self.is_wave_exist[var_2][1] = var_1;
        break;
      }
    }
  }

  return self.is_wave_exist;
}

_id_11CA1(var_0, var_1, var_2) {
  if(var_1.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && var_1.model == "_encstr_91D421989F89BAFF68CF4CB209FDCF032288F3430F7A56491FDBF9D8300DF062497883")
    var_0 = getdvarfloat("_encstr_AC831860CA62BF49C34F2FAD77AB73838A820879B2BB0741579F", 5000);
  else if(var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" && var_1.model == "_encstr_9BF6213B2B1AD7CD43FAB5B48DF536B98CF547D52793CAA3FAE25D1646AF0B85EBEE4F")
    var_0 = getdvarfloat("_encstr_B2A11A336A93F840D217A1F36FBF88BDCF12083EA2032FD0A10493FF", 100);
  else
    var_0 = var_0 * getdvarfloat("_encstr_AF3A1D177FD358E872D103B9C94EA08D7BE3B7C753CA9B39BCB5E9B06B3CC8", 1.0);

  return var_0;
}

_encstr_BAC61588E5D0EA3B20C8D059241FF4DF55F07899A4EBD1(var_0) {
  var_1 = level.delayedeventtypes[16].secondwindthink;
  var_2 = level._id_11E18._id_13BEF[self.agent_type];

  if(var_0 + var_2 > var_1)
    return var_1 - var_2;
  else
    return var_0;
}

mp_port2_gw_patch() {
  var_0 = relic_mythic_should_do_pain();
  var_1 = ["_encstr_832110432D68C3A5419372BB7610E46ADEAB", "_encstr_BDE910D1BBE7AFB859BA5DB12F7A38FFCF62", "_encstr_BE8D10E6AE39A7C351DAB28FC9237852A2A7", "_encstr_96F81083EDA803650173F3FC3650A4AA1E6B"];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2][0];

    if(var_3 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_3, 0);

    foreach(var_6 in var_4)
    var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_B427122BB4C9BFCDB70829102BC343D7C3CF924F");

    showsplashtoteam(var_3, var_1[var_2]);

    if(var_2 == 0) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_962620A9388A45F8369623B6EFE3CBA367075BEFA36EE8BFA440410FC2488B62A34B", var_3);
      level thread _encstr_88951A56E6C82B9D95B9D1AFDC0E0BEE7339CABBC2E4236C588D43B2("_encstr_96AB136639B29BB9B7F5C92BDD2C39C8FAC6AC9DB2", var_3);

      foreach(var_6 in var_4)
      var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_852611B69D7D593BACCDA3EBA573E85963BE73");

      continue;
    }

    level thread _encstr_88951A56E6C82B9D95B9D1AFDC0E0BEE7339CABBC2E4236C588D43B2("_encstr_A29A1369D8054BAA7DC623DA1B8AA31BD1055E1AB7", var_3);
  }

  foreach(var_6 in level.players) {
    if(isDefined(var_6) && isalive(var_6)) {
      var_11 = 0;

      for(var_2 = 0; var_2 < var_0.size; var_2++) {
        if(var_6.team == var_0[var_2][0]) {
          var_11 = 1;
          break;
        }
      }

      if(!var_11)
        var_6 thread scripts\mp\hud_message::showsplash("_encstr_A6850FA2CB284BD76973CEDA73C81C47ED");
    }
  }
}

_encstr_88951A56E6C82B9D95B9D1AFDC0E0BEE7339CABBC2E4236C588D43B2(var_0, var_1) {
  wait 2.0;
  var_2 = undefined;
  var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_1, 1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_2) || var_5._id_12532._id_13BEE > var_2._id_12532._id_13BEE && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_5.origin))
      var_2 = var_5;
  }

  if(isDefined(var_2)) {
    var_7 = getdvarfloat("_encstr_B8ED1F5780D3FF824DAFAAE7681DFB8D9B70AF5FA0E92F7A65A5791DEC352355C3", 2000);
    var_8 = vectorNormalize(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin() - var_2.origin);
    var_9 = var_2.origin + var_8 * var_7;
    var_10 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_9, 500, 0.5, 0.9, 1);
    var_10 = getclosestpointonnavmesh(var_10, var_2);
    var_11 = (var_10[0], var_10[1], var_10[2] + 2000);
    var_12 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_84720DCC2756E6DCB7D7B1C90B1D95", var_11, (0, randomint(360), 0), var_10);
    var_13 = getdvarfloat("_encstr_B89521CD6C9CBE9827BE07B2F566E456E6CDDED79359DDB0C9C8BE46D593581DD2EDDC", 90);
    var_12.expiretime = gettime() + var_13 * 1000;
    var_12._encstr_82990CCBDF08BEFBD0638B4850EB = var_0;
    var_12 thread _encstr_91AA10A6C7EB5BDBF4F798E8F71CF1EF2228();
    var_12 thread _encstr_820F123BED50130B4409B8CA59E031E13922B286();
    var_12 thread _encstr_850F155527C30728A411A19B869CD8503AABE3FBF30B57();
  }
}

_encstr_A7E20C97924F90D3DB24790145F4() {
  if(istrue(self._encstr_84DB0843055A4A5BE528)) {
    return;
  }
  self._encstr_84DB0843055A4A5BE528 = 1;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_A1011B1327D707ACAFCC39B26E37BDAFD993ACB273312CBC7D46ED779B");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AFB81A02B3087482BEB797233BD09BA33959714A0B78073A85C59F63");
  wait 1;
  thread _encstr_BA1A1084433F0B105FAAC7DACC151A98F843("_encstr_A30703972B");
  thread _encstr_AFBC11DCC1B0DD73D2B9E8561BD84EC21DCACD();
}

_encstr_AF4B0C5B5BD7DE9BB6A58D639532() {
  if(istrue(self._encstr_84DB0843055A4A5BE528)) {
    return;
  }
  self._encstr_84DB0843055A4A5BE528 = 1;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_93C61A4B502EB89A6FE442BF5625F24F702B83F7C060E16161080B75");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B6101A5B0B3A38EB5217BB95176AAD38EF6426B3F36128946A9BA349");
  wait 1;
  thread _encstr_BA1A1084433F0B105FAAC7DACC151A98F843("_encstr_83070344F0");
  thread _encstr_AFBC11DCC1B0DD73D2B9E8561BD84EC21DCACD();
}

_encstr_BA1A1084433F0B105FAAC7DACC151A98F843(var_0) {
  var_1 = "_encstr_A62712B63BBECAB395CD3AEBD237E85636BE8981";

  if(var_0 == "_encstr_83070344F0")
    var_1 = "_encstr_B2271235B5A107BBD5A03389A8B84BFFD07FE1D1";

  foreach(var_8, var_3 in level._id_13AAA) {
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_8, 0);

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_6 in var_4)
      var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12004(var_1);
    }
  }
}

_encstr_AFBC11DCC1B0DD73D2B9E8561BD84EC21DCACD() {
  var_0 = [];
  var_1 = getdvarint("_encstr_852E21FB43FB576A22E14F97914B129D131038A86D4B8D2E98EA2BD048DEF0DAB3D37D", 5);
  var_2 = undefined;

  if(isDefined(self.agent_type) && self.agent_type == "_encstr_B6B00E2383C3A0EEAF7A69704267AB98") {
    var_2 = "_encstr_A94C02B6";
    var_3 = level._id_11E18.wait_for_open;
  } else if(isDefined(self.agent_type) && self.agent_type == "_encstr_86EA0F2767A56AEA69611A27D9180242FB") {
    var_2 = "_encstr_A74C0277";
    var_3 = level._id_11E18.setlastdroppableweaponobj;
  } else
    return;

  if(isDefined(self.cashtorefund))
    var_4 = self.cashtorefund.origin;
  else
    var_4 = self.origin;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_4, level._id_11E18.playerredeploy, 0.1, 0.9, 1);
    var_7 = spawnStruct();
    var_7.origin = var_6;
    var_7.type = var_2;
    var_7.index = var_3;
    var_0[var_0.size] = var_7;
  }

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = randomint(360);

    for(var_10 = 0; var_10 < level._id_11BCE._id_11F1E; var_10++) {
      var_11 = var_9 + 90;
      var_12 = 0;
      var_13 = undefined;

      for(var_14 = 0; var_14 < 360; var_14 = var_14 + 10) {
        var_15 = (0, var_11 + var_14, 0);
        var_16 = anglesToForward(var_15);
        var_7 = var_0[var_8];
        var_13 = var_7.origin + var_16 * level._id_11BCE.train_get_num_of_anim_ents[var_7.type];

        if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_13) || _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::updatesquadleaderpassstateforteam(var_13)) {
          continue;
        }
        if(!isDefined(level.br_circle.dangercircleent) || _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_13)) {
          var_12 = 1;
          break;
        } else {}
      }

      if(!var_12) {
        break;
      }

      var_9 = var_11;
      var_17 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_13);
      var_17 = var_17 + (0, 0, 2000);
      var_18 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_B2C90C70705B9588598F42D30305", var_17, (0, randomint(360), 0));
      var_18.trial_flares = var_0[var_8];
      var_19 = randomfloatrange(level._id_11BCE.trial_fetch_mission_table, level._id_11BCE.trial_explosive_clear) * 1000;
      var_18.trial_flares.expiretime = gettime() + var_19;
      level.train_hurt_damage_watcher[level.train_hurt_damage_watcher.size] = var_18;
      var_18 thread _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::train_handle_collide_mines();
      var_18 thread _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::train_horn_sfx();
    }
  }
}

players_camera_fly_to_start_pos(var_0, var_1, var_2) {
  var_3 = getdvarint("_encstr_A1CF1BDCC6277D4C39EB83B2FACC39B237CDDBBE4B37E8B2D8AF5BB4B9", 3);
  var_4 = getdvarint("_encstr_ADCF1B1B70F00F38D531ABA7DF3B13B7EF488F91D020AD97A49EA71068", 6);
  var_5 = getdvarint("_encstr_95D9216BDE7AF13E3367C1E34F5A7E7813F59066C4DE60652A7FFFD9CF52CA61D58C38", 3);
  var_6 = getdvarint("_encstr_87D9214B6393AEE3D6115043F90216FB6F6A4069E1D5C3D058C95E43573A8BA9435AA8", 5);
  var_7 = randomintrange(var_3, var_4);
  var_8 = randomintrange(var_5, var_6);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_10 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", var_0, var_1, var_2, 0, 0);
    var_10.count = var_7;
  }
}

_encstr_952913E4B382D0BF6362B30FD6EF77475A5169C38F() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_84720DCC2756E6DCB7D7B1C90B1D95");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_AAD31BDAD21B2D3AB09CF2D7D8C29C953858B1B6859D95BE0C8CEB26C9";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::_encstr_A6691CF83AB3B33BEBE3BE3FEC37817FDB4250F8434FEF11E3044E27D367;
  var_0.capturecallback = ::_encstr_ADC61BA3B787F8CEBA8FEDD3CB729E30384BCB3BDFFBA0891263C3DF9F;
  var_0.destroyoncapture = 1;
}

_encstr_A6691CF83AB3B33BEBE3BE3FEC37817FDB4250F8434FEF11E3044E27D367(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

_encstr_ADC61BA3B787F8CEBA8FEDD3CB729E30384BCB3BDFFBA0891263C3DF9F(var_0) {
  self notify("_encstr_B1CF098D5838A3D5C95623");
  var_1 = randomint(10);
  var_2 = verifybunkercode(self._encstr_82990CCBDF08BEFBD0638B4850EB, var_1);
  var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_3._encstr_B4FF10DBA588EA4A18C37E82991072E2DD13 = 1;

  foreach(var_5 in var_2)
  var_6 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_5, var_3, self.origin, self.angles, 0, 1);

  if(isDefined(self.objectiveiconid))
    objective_delete(self.objectiveiconid);

  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

_encstr_91AA10A6C7EB5BDBF4F798E8F71CF1EF2228() {
  var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(self.origin, 50, -3000);
  self.molotov_delete_oldest_trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  wait 1.0;
  self.molotov_delete_oldest_trigger playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  self.molotov_delete_oldest_trigger setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
}

_encstr_820F123BED50130B4409B8CA59E031E13922B286() {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95", 0);
}

_encstr_850F155527C30728A411A19B869CD8503AABE3FBF30B57() {
  self endon("_encstr_B1CF098D5838A3D5C95623");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self) && !istrue(self.isdestroyed) && gettime() < self.expiretime)
    waitframe();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    self.molotov_delete_oldest_trigger delete();
    playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
  }
}

redeployspawns(var_0) {
  var_1 = gettime();
  var_2 = 1;

  if(!isDefined(level._id_11E18.waittill_player_collects_death_cash) || var_1 - level._id_11E18.waittill_player_collects_death_cash >= 1000.0)
    var_2 = 0;

  if(!isDefined(level._id_11E18._id_140C2)) {
    level._id_11E18._id_140C2 = [];
    var_2 = 0;
  }

  if(!var_2 || istrue(var_0)) {
    var_3 = self.origin;

    if(isDefined(self.cashtorefund))
      var_3 = self.cashtorefund.origin;

    level._id_11E18._id_140C2 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_3, level._id_11E18.playerredeploy);
    level._id_11E18.waittill_player_collects_death_cash = var_1;
  }

  return level._id_11E18._id_140C2;
}

sec_sys_struct_2(var_0) {
  var_1 = redeployspawns();
  var_2 = scripts\engine\utility::array_contains(var_1, var_0);

  if(!var_2 && getdvarint("_encstr_81AD297BB64B7F661D09EBB2211D5A2FC3A8FFDF5D70872BE378C28A396F94E73982479E673823F68B384A", 1)) {
    var_3 = self.origin;

    if(isDefined(self.cashtorefund))
      var_3 = self.cashtorefund.origin;

    var_2 = distance2d(var_0.origin, var_3) <= level._id_11E18.playerredeploy;

    if(var_2)
      level._id_11E18._id_140C2 = scripts\engine\utility::array_add(level._id_11E18._id_140C2, var_0);
  }

  if(var_2)
    var_0.players_in_aggro = self.agent_type;
  else
    var_0.players_in_aggro = undefined;

  return var_2;
}

updateplayerandteamcountui(var_0) {
  var_1 = 0;

  if(isDefined(level._id_11E18.setincomingremovedcallback))
    var_1 = var_1 || level._id_11E18.setincomingremovedcallback sec_sys_struct_2(var_0);

  if(isDefined(level._id_11E18.wait_for_next_hack_complete))
    var_1 = var_1 || level._id_11E18.wait_for_next_hack_complete sec_sys_struct_2(var_0);

  return var_1;
}

vault_assault_infil(var_0, var_1) {
  if(isDefined(var_1.classname) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E"))
    return 1;

  if(isDefined(var_0) && var_0 != var_1 && isDefined(var_0.classname)) {
    if(var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
      return 1;

    if(var_0.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && var_0.model == "_encstr_91D421989F89BAFF68CF4CB209FDCF032288F3430F7A56491FDBF9D8300DF062497883")
      return 1;
  }

  return 0;
}

isexplosivedamage(var_0) {
  return var_0 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_0 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_0 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" || var_0 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B";
}

unset_relic_nobulletdamage(var_0) {
  var_1 = createheadicon(var_0);
  var_2 = level.br_pickups.br_weapontoscriptable[var_1];

  if(isDefined(var_2)) {
    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank._id_13EFF, var_2))
      return 1;

    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank.chopper_gunner, var_2))
      return 1;

    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank.waypoints, var_2))
      return 1;
  }

  if(scripts\mp\utility\weapon::getweapongroup(var_0.basename) == "_encstr_A3710BEEACC2E0B737EB36B676")
    return 1;

  return 0;
}

can_be_seen_by_any_player(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(isarray(var_3)) {
      if(var_3[0] == var_1)
        return 1;
    } else if(var_3 == var_1)
      return 1;
  }

  return 0;
}

lootleadermarksizedynamic(var_0, var_1, var_2, var_3, var_4) {
  var_5 = randomfloatrange(0.5, 1.0);

  if(istrue(var_4))
    var_5 = var_5 * 1.5;

  return var_0 * var_5;
}

showsplashtoteam(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0, 1);

  foreach(var_4 in var_2)
  var_4 thread scripts\mp\hud_message::showsplash(var_1);
}

register_vehicle_spawn_override() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_2]) && isDefined(level.teamdata[var_2]["_encstr_8A2A0B936CCCC3078547970A8B"]) && level.teamdata[var_2]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_encstr_83200F6F2FF4E3A5207875FEF130E11BDD() {
  return isDefined(level._id_11E18.setincomingremovedcallback._id_12930) || isDefined(level._id_11E18.wait_for_next_hack_complete._id_12930);
}

_encstr_8F2517980553351AEDCB8067A3FB73DA03933DD9C37508D6E1() {
  if(!isDefined(level._id_11E18._encstr_BACB0B10A7216ADA2060F05525))
    return 0.0;

  var_0 = gettime();
  return (level._id_11E18._encstr_BACB0B10A7216ADA2060F05525 - var_0) / 1000.0;
}

_encstr_88A91E160DDF5A158BD39FFB2F4EDB0B3017CE6D825B92C7A02AB928F8450158() {
  if(isDefined(level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517)) {
    foreach(var_1 in level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517)
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
  }

  level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517 = [];
}

_encstr_AD9F1BE07B8C0B2BCACA78F023E279B0F33358409B2F23DF92726689FF(var_0) {
  if(!isDefined(level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517))
    level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517 = [];

  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(3, 0, 0, var_0.origin);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(var_0.radius);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517[level._id_11E18._encstr_AD8C19BFDA58AADFA893BA78AB47C58571A688B35ADBEA5EC50517.size] = var_0;
}

_encstr_91A018C9AC6CBDC9C89567CAB94759CD8C85E68563F2A32D1B9B() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isDefined(var_4._id_12532)) {
      var_0 = var_0 + var_4._id_12532._id_14239;
      var_1 = var_1 + var_4._id_12532.open_cac_slot;
      var_2 = var_2 + var_4._id_12532._id_1457E;
    }
  }

  getentitylessscriptablearray("_encstr_B1091C8FA147EAFF091827036026BAC34FC757C91CA5021BB0E8D757A879", ["_encstr_82050D4F10C9BBFFE292AD4790630B", level.delayedeventtypes[16].secondwindthink, "_encstr_8CEC0E1787CBA8F54F0231997A2724A0", int(level._id_11E18._id_13BEF["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]), "_encstr_85C00E38A183F8E81E2CF1F3454628B5", int(level._id_11E18._id_13BEF["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]), "_encstr_B2FB0C9741937AE741E3F57AF99B", int(var_1), "_encstr_A28C0BB3CA1A7D91B06BB09D95", int(var_0), "_encstr_9AAE0C7CAD4FC36FCFCA88E082A7", int(var_2)]);
}

_encstr_A5A6111A154C0895C66D90520283372117DF47() {
  if(getdvarint("_encstr_A66712584B3797B8C7DFB53DFA774107DD22D868", 0) == 0) {
    return;
  }
  var_0 = "_encstr_8730250F7A4116A9028BC53D73FA51DEA9E287B7D2196EE12AA3CD355BD21986110A1F3FAAB17A";
  var_1 = level.delayedeventtypes[16].secondwindthink;
  var_0 = var_0 + ("_encstr_A5850ED2FAB58FF8A167C331059BC232" + var_1 + "_encstr_AD4C02A0");
  var_0 = var_0 + ("_encstr_AD720ABC1F1AD329676F22EA" + level._id_11E18._id_13BEF["_encstr_86EA0F2767A56AEA69611A27D9180242FB"] + "_encstr_AD4C02A0");
  var_0 = var_0 + ("_encstr_A6BA0A42D9F710E2BFB27A0E" + level._id_11E18._id_13BEF["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"] + "_encstr_AD4C02A0");
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6) && isDefined(var_6._id_12532)) {
      var_2 = var_2 + var_6._id_12532._id_14239;
      var_3 = var_3 + var_6._id_12532.open_cac_slot;
      var_4 = var_4 + var_6._id_12532._id_1457E;
    }
  }

  var_0 = var_0 + ("_encstr_856B1799A0318E63C9ECA5D01BC92BD7C151728248FF47E2F1" + var_2 + "_encstr_AD4C02A0");
  var_0 = var_0 + ("_encstr_AA91198AB7E8586304A2F0C11BDB374B9D954011C25B16762BA340" + var_3 + "_encstr_AD4C02A0");
  var_0 = var_0 + ("_encstr_B17B16294FE33A1AA1CBE9DF3385154EFD27E19A77CDB751" + var_4 + "_encstr_AD4C02A0");
  var_8 = level.delayedeventtypes[16].is_wave_exist;

  for(var_9 = 0; var_9 < var_8.size; var_9++)
    var_0 = var_0 + ("_encstr_AD8B0F8C9A38EED72DCA2810BB498792F9" + (var_9 + 1) + "_encstr_A6D109EE34B5D012328258" + var_8[var_9][1] + "_encstr_AD4C02A0");

  _encstr_8CD6101B88CB8DC380305F8FD6C91BD20B20(var_0 + "_encstr_9269241E76A981EAA1B27179E963E30DEA2BEFD1A5555A9F61AD327EFAD9E25DF9E90AE10B5F");
}

_encstr_8CD6101B88CB8DC380305F8FD6C91BD20B20(var_0) {
  logstring("_encstr_836110DD1B54FE292F6EE5DDEEDDA9820F3A" + var_0);
}