/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\fresno\fresno_screamer.gsc
***************************************************/

_encstr_95582236E0177B45C5B2C880EB5D17534F9730A346A723A7EADAA8D08272C1899B09CE2D(var_0, var_1) {
  var_2 = _encstr_A5CB139799D0373853D70B5D67EDAD5A233B19E5E7(var_1 + (0, 0, 2500), var_1);
  var_3 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_2);
  var_3._id_140A0 = 4;
  level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA = var_2;
  level._id_11E18._encstr_844413E78F23B50B7D4F5309B25D48F87BCFB75B23 = var_0;
}

_encstr_84E62638AB74A1E55265CD40BDCA0909CD138028DF079893CACF465652E25BD0058B23283BA9F1B3() {
  if(isDefined(level._id_11E18._id_12F3F) && isDefined(level._id_11E18._id_12F3F.owner))
    level._id_11E18._id_12F3F.owner scripts\mp\killstreaks\killstreaks::awardkillstreak("_encstr_9B7310AFD59D7A46303148D96B5882726203", "_encstr_8261067B1D34AC27", undefined, undefined, undefined, 1);
}

_encstr_B18B10D58D2763152D6B98103347EB98D722() {
  level._id_11E18 notify("_encstr_8CFC11C37720EF3F0969EB2151DE4FE288D34C");
  level._id_11E18 notify("_encstr_A39513F79F724A319ABBCA66617148835258F32B65");

  if(isDefined(level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA)) {
    level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA = undefined;
  }

  level._id_11E18._encstr_844413E78F23B50B7D4F5309B25D48F87BCFB75B23 = undefined;

  if(isDefined(level._id_11E18._id_12F3F)) {
    level._id_11E18._id_12F3F _encstr_821A0F80F3DACDA844BF0870BB90C02982();

    if(isDefined(level._id_11E18._id_12F3F.owner)) {
      var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
      level._id_11E18._id_12F3F.owner _encstr_8CF816912AF2AF7BB7E3BE3DF917015D9C3240D8238DEBB0(var_0);
      level._id_11E18._id_12F3F setscriptablepartstate("_encstr_B60F1819CA3420E82317ABB33BCA20A3D169A3B1726518916A9B", "_encstr_921D09D9D9C0090D7275B4");
      wait 1.6;
    }

    thread _encstr_ADF411F19F700BD90AEF5D5E06F30391DD3793(level._id_11E18._id_12F3F.origin);

    if(isent(level._id_11E18._id_12F3F))
      level._id_11E18._id_12F3F delete();
    else
      level._id_11E18._id_12F3F freescriptable();

    level._id_11E18._id_12F3F = undefined;
  }
}

initcratedata(var_0) {
  var_1 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_91F61033C9959B37F6FACD1B4E2B58B6564E");
  var_1.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_1.dummymodel = "_encstr_AAD31BDAD21B2D3AB09CF2D7D8C29C953858B1B6859D95BE0C8CEB26C9";
  var_1.friendlymodel = undefined;
  var_1.enemymodel = undefined;
  var_1.mountmantlemodel = undefined;
  var_1.supportsownercapture = 0;
  var_1.headicon = undefined;
  var_1.usepriority = -1;
  var_1.usefov = 180;
  var_1.timeout = undefined;
  var_1.friendlyuseonly = 1;
  var_1.ownerusetime = 0.5;
  var_1.otherusetime = 0.5;
  var_1.capturecallback = ::_encstr_927616E108F556DBA94E9980DD731B9F7FA05A4A68AB8EEF;
  var_1.destroycallback = ::_encstr_997C16AF3693851D9523ACB947E4EDF28DB0B1D898B0D8DA;
  var_1.activatecallback = ::_encstr_ABF1170F683B193B4B37568B2B45A2B461C06F4B685151728F;
  var_1.ingame = ::_encstr_B48418CF7796BADC88938CD0EB301353E095B7AFC131D281D0D8;
  var_1._id_127FD = ::_encstr_956319D7B14E2CD1560EF69B3AB1E456C23ACA36581BB198B036DA;
  var_1.destroyoncapture = 1;
}

_encstr_82730F3BB0916B53E9B6CE8295F3EA2D1B(var_0) {
  var_1 = self.tracknonoobplayerlocation;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");

  foreach(var_3 in level.players) {
    if(var_3.team == var_0.team) {
      if(var_3 == var_0)
        var_3 scripts\mp\hud_message::showsplash("_encstr_ABA4219827FAE0CAAF33E456379B7BBEB9D8395958AD56C97DCDD158F27D6C36DE3759");
      else {}

      continue;
    }
  }

  var_1 _encstr_821A0F80F3DACDA844BF0870BB90C02982();
  var_1 _encstr_83C80F9E03CF56087F099F8F26E27090C7("_encstr_9A990A13739E149BF7605DD9", var_0);
  var_1 _encstr_A7040E2F7B4BBBBF336ADBE880BFFA1A();
  var_1.owner = var_0;
  var_0._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22 = 1;
  var_0 thread _encstr_8FCA16AF8DC22727F2E63693AC0B5BCA4E76B237E857C92B("_encstr_817D15E2C8EFD2DFE8884C5588F0DF1C2F90EB4A41738A");
}

_encstr_AFDE0DC8937B0EE6C69CCA0BD62BC9(var_0, var_1) {
  level._id_11E18 notify("_encstr_8CFC11C37720EF3F0969EB2151DE4FE288D34C");
  _encstr_8CF816912AF2AF7BB7E3BE3DF917015D9C3240D8238DEBB0(var_0, var_1);
  level._id_11E18._id_12F3F _encstr_83C80F9E03CF56087F099F8F26E27090C7("_encstr_81D60AEDCDFAB327F6D57319");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_AC861E5B403EA88A5FD472AF46D5E27F432083CF60D0F58307F6BF26A0DD1A1A");

  if(istrue(var_1))
    level._id_11E18._id_12F3F thread _encstr_960612497033C7CAC8435AB62B49FB8F6E684AC6();
}

_encstr_839F14BFE198DA5B0873CE92A9F09DB2EE211F7B5BB0() {
  var_0 = isDefined(level._id_11E18.setincomingremovedcallback._id_12930);
  var_1 = isDefined(level._id_11E18.wait_for_next_hack_complete._id_12930);
  level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1 = undefined;
  level._id_11E18._encstr_ABF70B6E8D93B2C26B56C9AD5B = undefined;

  if(var_0) {
    if(!var_1 || randomintrange(0, 2) == 0)
      level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1 = 1;
  }

  if(var_1 && !isDefined(level._id_11E18._encstr_81F70B73C7905F8FB9B93B52C1))
    level._id_11E18._encstr_ABF70B6E8D93B2C26B56C9AD5B = 1;
}

_encstr_8CF816912AF2AF7BB7E3BE3DF917015D9C3240D8238DEBB0(var_0, var_1) {
  if(isDefined(level._id_11E18._id_12F3F)) {
    var_2 = scripts\engine\utility::ter_op(isPlayer(self), self, level._id_11E18._id_12F3F.owner);

    if(isDefined(var_2))
      var_2._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22 = 0;

    if(isent(level._id_11E18._id_12F3F) == 0) {
      level._id_11E18._id_12F3F _encstr_821A0F80F3DACDA844BF0870BB90C02982();
      level._id_11E18._id_12F3F freescriptable();
      level._id_11E18._id_12F3F = undefined;
    }
  }

  if(isDefined(level._id_11E18._id_12F3F) == 0) {
    if(istrue(var_1))
      var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, self, 0, 0, 10, 1);
    else
      var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, self);

    level._id_11E18._id_12F3F = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_B60F1819CA3420E82317ABB33BCA20A3D169A3B1726518916A9B", var_3, 0, 1);
    level._id_11E18._id_12F3F.keepinmap = 1;
    level._id_11E18._id_12F3F.hidden = 0;
  }
}

_encstr_ADF411F19F700BD90AEF5D5E06F30391DD3793(var_0) {
  var_1 = var_0 + (0, 0, -96);
  var_2 = physicstrace(var_0, var_1);
  var_3 = var_2 == var_1;
  var_4 = "_encstr_A6030FE8D9A3D79807F8D72FB3EAEBE809";

  if(var_3)
    var_4 = "_encstr_8D7E0C49921308C8EEC46323F112";

  waitframe();
  var_5 = easepower("_encstr_994C1C0AB897FEA7532E7969CE787F091BC3B362E86734E788807A615E61", var_2, (0, 0, 0));
  var_5 setscriptablepartstate("_encstr_8304168D58939CA598D895F5B23C1CC6F6C8CAFA890BCD56", var_4);
  var_5 thread scripts\mp\equipment\binoculars::hanging_crate_think(5);
}

_encstr_960612497033C7CAC8435AB62B49FB8F6E684AC6() {
  var_0 = self;
  level._id_11E18 endon("_encstr_A39513F79F724A319ABBCA66617148835258F32B65");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 10.0;
  var_2 = 0.1;
  var_3 = -1;
  var_4 = float(level._id_11E18.playerredeploy * level._id_11E18.playerredeploy);

  for(;;) {
    wait(var_2);

    if(isDefined(level._id_11E18._id_12F3F) && isDefined(level._id_11E18._encstr_844413E78F23B50B7D4F5309B25D48F87BCFB75B23)) {
      var_5 = level._id_11E18._id_12F3F.origin;

      if(isDefined(level._id_11E18._id_12F3F.owner) && isDefined(level._id_11E18._id_12F3F.owner.origin))
        var_5 = level._id_11E18._id_12F3F.owner.origin;

      var_6 = distance2dsquared(var_5, level._id_11E18._encstr_844413E78F23B50B7D4F5309B25D48F87BCFB75B23);

      if(var_6 <= var_4) {
        if(var_3 >= 0) {
          level._id_11E18._id_12F3F notify("_encstr_8F9213DC1B93B2C25BB239AF2DB97D4CDE5DE623CD");
          var_3 = -1;
        }
      } else if(var_3 <= -1) {
        var_3 = var_1;
        level._id_11E18._id_12F3F thread _encstr_91F116573F8887A01FE8CBB2D00B9F734028F2E15971836D(var_3);
      } else if(var_3 >= 0) {
        var_7 = int(var_3);
        var_3 = var_3 - var_2;

        if(var_3 <= 0.0) {
          level thread _encstr_B18B10D58D2763152D6B98103347EB98D722();
          break;
        }
      }

      continue;
    }

    break;
  }
}

_encstr_A14E1686B311384D4B0F6D5B1F721D28A70DA9D91D79B889(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_11E18 endon("_encstr_A39513F79F724A319ABBCA66617148835258F32B65");
  level._id_11E18 endon("_encstr_8CFC11C37720EF3F0969EB2151DE4FE288D34C");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 scripts\engine\utility::waittill_notify_or_timeout("_encstr_8F9213DC1B93B2C25BB239AF2DB97D4CDE5DE623CD", var_0);
}

_encstr_91F116573F8887A01FE8CBB2D00B9F734028F2E15971836D(var_0) {
  var_1 = self;
  var_1 notify("_encstr_8F9213DC1B93B2C25BB239AF2DB97D4CDE5DE623CD");

  if(isDefined(var_1.owner)) {
    var_2 = var_1.owner;
    var_2 setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 4);
    var_2 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", int(gettime() + var_0 * 1000));
    var_1 _encstr_A14E1686B311384D4B0F6D5B1F721D28A70DA9D91D79B889(var_0);
    var_2 setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
    var_2 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
  }
}

_encstr_A7040E2F7B4BBBBF336ADBE880BFFA1A() {
  var_0 = self;
  var_0.hidden = 1;
  var_0 setscriptablepartstate("_encstr_B60F1819CA3420E82317ABB33BCA20A3D169A3B1726518916A9B", "_encstr_95DF070DD22319CA9B");
}

_encstr_83C80F9E03CF56087F099F8F26E27090C7(var_0, var_1) {
  var_2 = self;

  if(var_0 == "_encstr_9A990A13739E149BF7605DD9")
    var_2 _encstr_AD8F1A97BB78ABC32E83BA30A34B42897F2880BF6BDBFB5A87851BD7(var_1, "_encstr_A1EF2E68679F105941369E30CD9A61D80DE3E0C18F7BE82D291D9626269197617A67C8103706E1976242033DFD7AC9CA", "_encstr_BE1C2B5DD27DD683AF26E4AF6BB0C1AD59B9AEFAD21BF6B9AFB793B1B0BE7B319A566CD1A5CE56FACA73CAB5CB");
  else if(var_0 == "_encstr_81D60AEDCDFAB327F6D57319") {
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_AF5A081BBAC993AC73A3", var_2.origin + (0, 0, 50), "_encstr_B8C62DC7C3A0DA78F9B16A3948D0A01205754FF7ABD6A22ED1F8623EE149F75A6A8BAFD33384CA277063DDC2BBA004");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

      foreach(var_5 in level.players) {
        if(!var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
          objective_addclienttomask(var_3, var_5);
      }

      objective_showtoplayersinmask(var_3);
      var_2.icon = var_3;
      var_2 thread _encstr_B41F1CE79BF1D2F26B19EF227D319A897B28B7AF4888289A6723B39C6825();
    } else {}
  }
}

_encstr_821A0F80F3DACDA844BF0870BB90C02982() {
  var_0 = self;
  var_0 notify("_encstr_822C13B673DBB9DB4572B8C9AA9E8F90171033A5CD");

  if(isDefined(var_0.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.icon);
    var_0.icon = undefined;
  }

  if(isDefined(var_0.playersetattractionstateindex)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.playersetattractionstateindex);
    var_0.playersetattractionstateindex = undefined;
  }

  if(isDefined(var_0.nuke_cancel)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.nuke_cancel);
    var_0.nuke_cancel = undefined;
  }
}

_encstr_AD8F1A97BB78ABC32E83BA30A34B42897F2880BF6BDBFB5A87851BD7(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "_encstr_AF5A081BBAC993AC73A3", var_3.origin, var_1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    var_5 = 0.0;
    var_3 thread _encstr_A712142FF85B3C4A89D5B2AE464382CD01286F579030(var_0, var_4, var_5);
    objective_removeallfrommask(var_4);
    var_6 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_8 in var_6) {
      if(!var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
        objective_addclienttomask(var_4, var_8);
    }

    objective_showtoplayersinmask(var_4);
    var_3.playersetattractionstateindex = var_4;
  }

  var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_10 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "_encstr_AF5A081BBAC993AC73A3", var_3.origin, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10, 1);
    var_5 = 0.0;
    var_3 thread _encstr_A712142FF85B3C4A89D5B2AE464382CD01286F579030(var_0, var_10, var_5);
    objective_removeallfrommask(var_10);

    foreach(var_8 in level.players) {
      if(var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || var_8.team == var_0.team)
        objective_addclienttomask(var_10, var_8);
    }

    objective_hidefromplayersinmask(var_10);
    var_3.nuke_cancel = var_10;
  }
}

_encstr_A712142FF85B3C4A89D5B2AE464382CD01286F579030(var_0, var_1, var_2) {
  var_3 = self;
  level._id_11E18 endon("_encstr_8CFC11C37720EF3F0969EB2151DE4FE288D34C");
  level._id_11E18 endon("_encstr_A39513F79F724A319ABBCA66617148835258F32B65");

  if(var_2 <= 0.0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
  } else {
    for(;;) {
      if(isDefined(var_0)) {
        scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 50));

        if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          wait 0.1;
          continue;
        }

        wait(var_2);
      }
    }
  }
}

_encstr_B41F1CE79BF1D2F26B19EF227D319A897B28B7AF4888289A6723B39C6825() {
  self notify("_encstr_B41F1CE79BF1D2F26B19EF226D319A897B2837AF4888089A6723B39C6825");
  self endon("_encstr_B41F1CE79BF1D2F26B19EF226D319A897B2837AF4888089A6723B39C6825");
  self endon("_encstr_822C13B673DBB9DB4572B8C9AA9E8F90171033A5CD");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_position(self.icon, self.origin + (0, 0, 50));
    waitframe();
  }
}

_encstr_8FCA16AF8DC22727F2E63693AC0B5BCA4E76B237E857C92B(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 giveweapon(var_0);
  var_1 setweaponammostock(var_0, 0);
  var_1 setweaponammoclip(var_0, 0);
  var_1 scripts\mp\supers::allowsuperweaponstow();
  var_2 = var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0, 1);

  if(!istrue(var_2)) {
    var_1 scripts\mp\supers::unstowsuperweapon();

    if(var_1 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0))
      var_1 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    else
      var_1 takeweapon(var_0);
  }

  var_1 scripts\common\utility::allow_killstreaks(0);
  var_1 scripts\common\utility::allow_supers(0);

  while(istrue(var_1._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22)) {
    waitframe();

    if(!var_1 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0) || _encstr_B1F917B729F1D2B990FB76FE50D0E7BA5D87DF8BFBAFDA9D70(var_1) == 0) {
      if(!istrue(var_1._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22)) {
        var_1 thread scripts\mp\utility\inventory::switchtolastweapon();
        wait 0.5;
      }

      var_1 takeweapon(var_0);

      if(istrue(var_1._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22)) {
        var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
        var_1 _encstr_AFDE0DC8937B0EE6C69CCA0BD62BC9(var_3);
      }
    }
  }

  var_1 scripts\common\utility::allow_killstreaks(1);
  var_1 scripts\common\utility::allow_supers(1);
}

_encstr_B1F917B729F1D2B990FB76FE50D0E7BA5D87DF8BFBAFDA9D70(var_0) {
  if(istrue(var_0._encstr_9196133B9B3EE8E61343E008CA7F1608D7E1ABAB22) == 0)
    return 0;

  if(var_0 isinexecutionvictim())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(var_0.isreviving))
    return 0;

  if(istrue(var_0.isjuggernaut))
    return 0;

  if(var_0 ismantling())
    return 0;

  return 1;
}

_encstr_A5CB139799D0373853D70B5D67EDAD5A233B19E5E7(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_91F61033C9959B37F6FACD1B4E2B58B6564E", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 0;
    var_2 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95", 0);
    var_2._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
    var_2._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_2._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_A3BD0E23776F2803CA83A99B9391D808", 0);
  }

  return var_2;
}

_encstr_ABF1170F683B193B4B37568B2B45A2B461C06F4B685151728F(var_0) {}

_encstr_927616E108F556DBA94E9980DD731B9F7FA05A4A68AB8EEF(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA = undefined;
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_AFDE0DC8937B0EE6C69CCA0BD62BC9(var_1, 1);
}

_encstr_997C16AF3693851D9523ACB947E4EDF28DB0B1D898B0D8DA(var_0) {
  self setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level._id_11E18._encstr_ABA50EDC3693CAC2B62BE4362758A3CA = undefined;
}

_encstr_B48418CF7796BADC88938CD0EB301353E095B7AFC131D281D0D8(var_0, var_1) {
  self setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_A1A107973D7982FB90", 0);
}

_encstr_956319D7B14E2CD1560EF69B3AB1E456C23ACA36581BB198B036DA() {
  self setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_ACFC091AE8AB2FCBE15119", 0);
}