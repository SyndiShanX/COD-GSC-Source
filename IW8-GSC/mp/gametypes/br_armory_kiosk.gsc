/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_armory_kiosk.gsc
***********************************************/

init() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint("_encstr_B12314CAA6FDE9426BD1B7F328A02AF3CFCAD4451617", 1) != 0;
  level.delay_put_vehicles_on_compass = getdvarint("_encstr_BAED204E9B3316D9DD1A30607333874B8712DE4BF16F197742A290801B0CB7033FAC", 0);
  level._encstr_B6AD1F984EAFC293D6B7C9E5D75B5ADB9BD6FAB11BDBE659BE6BB2E6D5AF994B87 = getdvarint("_encstr_999F23033313A196933F4FC2923572E998FC70C5AF1A5F868B4D938231D349539BF1DE5BD3", 1);
  level._encstr_910823358239E0DE572A9BE231171BD84AE3C7AF349DA8AD77227108FBEF4D106545DF0BB4 = getdvarfloat("_encstr_834227AA838DBEFB5BAFF60885AF2AA72937105F3B47F8175257D28507BAD17B4B88BBBFB2733A4BA3", 0.5);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B48D064CB8E8E33A")) {
    level.br_armory_kiosk_enabled = 0;
    return;
  }

  if(level.br_armory_kiosk_enabled) {
    scripts\engine\scriptable::_id_12F5B("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", ::armorykioskused);
    scripts\engine\scriptable::_id_12F5B("_encstr_AC4D12130876D0524D95EE26F11B2983D878DF8F", ::armorykioskused);
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onarmorykioskpurchase);
    allassassin_applyquest();
    _parsepurchaseitemtables();
    level thread apc_shoot_at_target();
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_84E41C28876424C160624059728A1DECD6EB3018F76879A77A034FD6D5E2", ::_encstr_87130E28EF1F03438FFA30D062220319);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9941167A20E1D28FB343809C6D59DBE457B862D373891CAB", ::_encstr_8E441F8D2CD81B312C36ADF5762B1DE61B9CD21C8E563291D2E6B1F657E61DB48C);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A77416A740E323429DCB9A932569E8D1ABC85F27709B617A", ::_encstr_950F1F9F4BBA79583FA752B10B87EBF367508C807398C859946017AA6B0840EB38);
}

all_waves() {
  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    setDvar("_encstr_A9DC1A9E3EB7BA79F8808F5778D126A285DD6759A573E28720A8AFFF", "_encstr_AD1804430D3D");
  else
    setDvar("_encstr_A9DC1A9E3EB7BA79F8808F5778D126A285DD6759A573E28720A8AFFF", "_encstr_A9B60699B043B053");
}

allassassin_applyquest() {
  var_0 = getdvarint("_encstr_A36818BAEE3E7F9417580A4130638D1F13C004398641A75B2D78", 0);
  level.br_armory_kiosk._id_12E7B = int(clamp(var_0, 0, 100));
  var_1 = getDvar("_encstr_81181E216A706F2B27CE784E939A55731691C90B7FA9982F78E95F5058B290BA", "_encstr_B40101");
  level.br_armory_kiosk._id_12E7C = strtok(var_1, "_encstr_964C0249");
  var_2 = 20;
  var_3 = level.br_armory_kiosk._id_12E7B % var_2;

  if(var_3 > 0) {
    var_4 = int(floor(level.br_armory_kiosk._id_12E7B / var_2) * var_2);
    var_5 = var_3 / var_2 >= 0.5;

    if(var_5)
      var_4 = var_4 + var_2;

    level.br_armory_kiosk._id_12E7B = int(var_4);
  }

  if(var_0 != level.br_armory_kiosk._id_12E7B)
    setDvar("_encstr_A36818BAEE3E7F9417580A4130638D1F13C004398641A75B2D78", level.br_armory_kiosk._id_12E7B);
}

add_collision_to_hack_point(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == 0)
    return var_0;
  else if(var_1 == 100)
    return 0;

  var_2 = (100 - var_1) * 0.01;
  return int(ceil(var_0 * var_2 - 0.5));
}

_parsepurchaseitemtables() {
  var_0 = getDvar("_encstr_8BAA18629631F22D32DB8A5710995F987BFF870B28E51DCAAD4D", "_encstr_845A1880321F200E88E797B7F761D5E8EB8C89DB9FAB9A4E23F3");

  if(var_0 == "_encstr_B40101")
    var_0 = "_encstr_845A1880321F200E88E797B7F761D5E8EB8C89DB9FAB9A4E23F3";

  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) == 1) {
    if(getdvarint("_encstr_962012A2CE6571EAC369033B51F9B55B1D572EDC", 0) == 1 || getdvarint("_encstr_AC29167FFB0A69BE4371B1B999CFE3282543C9F565B6807E", 0) == 1)
      level.dialog_wait_ready_civ = 7;
  }

  level.br_armory_kiosk.items = [];
  var_1 = tablelookupgetnumrows(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = int(tablelookupbyrow(var_0, var_2, 0));
    var_4 = spawnStruct();
    var_4.type = tablelookupbyrow(var_0, var_2, 1);
    var_4.ref = tablelookupbyrow(var_0, var_2, 2);
    var_4.cost = int(tablelookupbyrow(var_0, var_2, 3));
    var_4.playboxuseanimation = int(tablelookupbyrow(var_0, var_2, 9));
    var_4._id_122FC = int(tablelookupbyrow(var_0, var_2, 10));
    var_4._encstr_9BD80F6C4BC936D856232D37C6BDAB3747 = int(tablelookupbyrow(var_0, var_2, 12));

    if(var_4.ref == "_encstr_93920C9E781BB33078D689330FA7") {
      var_5 = getdvarint("_encstr_A95819DC1BC9EB9893F5AD96BDE6DAFA9BBA1C469C7BE06CB7CDA3", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_AF8B101B6A1D60CB923B437F73598FE8A204") {
      var_6 = getdvarint("_encstr_93541C9B1BC9AFC44EBEDAB4B7B9B6BE6E38B2B1D2C28D2DB9D1D8ED9B3A", 500);

      if(var_6 != 0)
        var_4.cost = var_6;
    }

    if(var_4.ref == "_encstr_ADB216DEF8E4F09F8CA1B1E3B2AB09C4284733F8772BACB3") {
      var_5 = getdvarint("_encstr_93A829CD6CE4EB26E4AFB52D7B376DAF8E4ED58D5BBB584EEB2795CC2D8DB1FAE89CB7C11AE5AFC6DB37A3", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_84650F5E952887C6C138F923D011BE7F83") {
      var_5 = getdvarint("_encstr_995222C27188473236B7AF5F2F5E6A8F60FBFB4EE8C8016B98C59F331B0B83D770A0F213", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_B8AD10453F2A1BA8D4E72E838F9088473287") {
      var_5 = getdvarint("_encstr_8CC823BBA60D49C6D63173A97A4F8837533658BFB793E2B81F7BD94F591711D779622D03FC", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_821E160B80C369A28345F1D3D8DA4A1939D5E1DB3EA08F38") {
      var_5 = getdvarint("_encstr_B8D721F8E76E781B3ACF07CBAFB640B7F3CB030FE0FB0E4A99F952FB6032B1C1A04379", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_BE3517B89F6028C73AAF405DC2A22D91D4376920BB0F43E9B3") {
      var_5 = getdvarint("_encstr_BA69220328D5F9A36BB07379B0935F313158EB9AC0672EABA60D5267D7D85F4947187363", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_B2BF1418FAB463D90BA56875A87FA33B1F42D99852CB") {
      var_5 = getdvarint("_encstr_936A1FB9B193AF319CD7AD2DB7E6AD7D4727BA1B5BEE1627EBEAB0CE7DD8B7CDE8", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(var_4.ref == "_encstr_A58017EBC5A9EAE308A0EF4F2041CAD2196D3966BFC5132DD0") {
      var_5 = getdvarint("_encstr_B28C22B91B4E7D8939BE6DD2EDCDB5EB47275D1BADEE1693BE89C23927B28DEB1BDEDC8E", 0);

      if(var_5 != 0)
        var_4.cost = var_5;
    }

    if(level.br_armory_kiosk._id_12E7B > 0) {
      var_7 = level.br_armory_kiosk._id_12E7C.size == 0 || scripts\engine\utility::array_contains(level.br_armory_kiosk._id_12E7C, var_4.ref);

      if(var_7)
        var_4.cost = add_collision_to_hack_point(var_4.cost, level.br_armory_kiosk._id_12E7B);
    }

    if(var_4.type == "_encstr_81BF105107EFE1AF2B3B79A8C2076B1B73A4") {
      level.br_armory_kiosk._id_11958 = var_4.cost;
      level.br_armory_kiosk._id_11959 = var_4.playboxuseanimation;
      level.br_armory_kiosk._id_1195A = var_4._id_122FC;
      continue;
    }

    if(var_4.type == "_encstr_9ADC0FC6DE2C32DEBA47F56CAB6E47B7B6") {
      level.br_armory_kiosk._id_11955 = var_4.cost;
      level.br_armory_kiosk._id_11956 = var_4.playboxuseanimation;
      level.br_armory_kiosk._id_11957 = var_4._id_122FC;
      continue;
    }

    if(var_4.type == "_encstr_AB420B13C7C1C89EFA6B6B2D5F") {
      level.br_armory_kiosk._id_13AC2 = var_4.cost;
      level.br_armory_kiosk._id_13AC3 = var_4.playboxuseanimation;
      level.br_armory_kiosk._id_13AC4 = var_4._id_122FC;
      continue;
    }

    level.br_armory_kiosk.items[var_3] = var_4;
  }
}

ai_push_to_position(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [scripts\engine\utility::ter_op(isDefined(var_6), var_6, 0), scripts\engine\utility::ter_op(var_2, var_3, 0), scripts\engine\utility::ter_op(var_4, var_5, 0)];
  var_8 = _encstr_B8F811A7874A25304DF2BBB11C2340D0233B79(var_7);
  var_9 = add_collision_to_hack_point(var_1, var_8);

  if(isDefined(var_0) && var_0.ref == "_encstr_93920C9E781BB33078D689330FA7" && getdvarint("_encstr_BD5C1FCBD0AE3D7B9BF8863C56BF42F576282F03C0416E53970D0CB2367FEBB67B", 0) == 1) {
    var_10 = getomnvar("_encstr_9561115DB4EB4CC9F56C9693B136CAF5DCBADA") - 1;

    if(var_10 >= 1) {
      var_11 = var_0._encstr_9BD80F6C4BC936D856232D37C6BDAB3747;

      if(var_11 > 0) {
        var_11 = var_11 * var_10;
        var_9 = add_collision_to_hack_point(var_9, var_11);
      }
    }
  }

  return var_9;
}

_encstr_B8F811A7874A25304DF2BBB11C2340D0233B79(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 > var_1)
      var_1 = var_3;
  }

  return var_1;
}

apc_shoot_at_target() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setdvarifuninitialized("_encstr_82C81F5F57B679EA10966F340B5032828597B7AF275E629FB8BAA9BE60A07B3A6D", 0);

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
    var_0 = getdvarint("_encstr_82C81F5F57B679EA10966F340B5032828597B7AF275E629FB8BAA9BE60A07B3A6D", 0);

    if(var_0 == 0) {
      continue;
    }
    if(level.br_circle.circleindex + 1 >= var_0) {
      little_bird_mg_initomnvars();

      foreach(var_2 in level.players) {
        if(!isDefined(var_2) || !isalive(var_2)) {
          continue;
        }
        var_2 thread scripts\mp\hud_message::showsplash("_encstr_A7CC1356F66F62B13078473F0189792BEB065D0F55");
      }

      break;
    }
  }
}

_id_1334A(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(var_1.shoulddopublicevent)) {
    return;
  }
  if(!isDefined(level.br_armory_kiosk._id_12E7B)) {
    return;
  }
  if(level.br_armory_kiosk._id_12E7B == 0) {
    return;
  }
  var_1.shoulddopublicevent = 1;

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(level.br_armory_kiosk._id_12E7C.size == 0)
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_8E2D132A98B7DA87704583B76D1B5F255959824210");
  else
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_95DF194CE4FADCC21BCAB9FA5667959BE8F5379563B2B1D14BECB2");
}

onprematchdone() {
  if(level.delay_put_vehicles_on_compass) {
    _id_13169("_encstr_93920C9E781BB33078D689330FA7", 1);
    level._id_12931 = "_encstr_A7321980D01713798F5B8D31E94F6753A9A21BE8C8F19A988E4AC3";
  }

  foreach(var_1 in level.br_armory_kiosk.scriptables) {
    var_1 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_BE8B08E323FB2BCD6268");
    var_1.visible = 1;
  }
}

dangercircletick(var_0, var_1) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B48D064CB8E8E33A") || getdvarint("_encstr_ADE01BBBE21B60D85A9F6F63C742C828DF1A90A01BBFB818B4AA0771F5", 0) == 1) {
    return;
  }
  var_2 = var_1 * var_1;

  foreach(var_4 in level.br_armory_kiosk.scriptables) {
    if(isDefined(var_4.visible) && distance2dsquared(var_4.origin, var_0) > var_2)
      little_bird_mg_mp_initmines(var_4);
  }
}

little_bird_mg_initomnvars() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B48D064CB8E8E33A")) {
    return;
  }
  foreach(var_1 in level.br_armory_kiosk.scriptables) {
    if(isDefined(var_1.visible))
      little_bird_mg_mp_initmines(var_1);
  }
}

little_bird_mg_mp_initmines(var_0) {
  var_0 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_921D09D9D9C0090D7275B4");
  var_0.visible = undefined;
  var_0.disabled = 1;
  var_0 notify("_encstr_82430FB4BB3FBBA0A7F12C0F812A09E7AF");

  if(var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::gethelispawns())
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();
}

registeraccesscardlocs() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }
  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_93320D7BF0CF0FDFA807F1CF4FE862"))) {
    return;
  }
  var_0 = getentitylessscriptablearrayinradius("_encstr_B2DF1A9B3693D20E8EC289D895AF3127FA07B1D5CD91594EEB98BD0F", "_encstr_AC110A7F14873B5B3D073009");
  return var_0;
}

relic_bang_and_boom_wait_for_pickup(var_0) {
  var_1 = level.br_armory_kiosk.scriptables;
  var_2 = 1000000000000.0;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!istrue(var_5.disabled)) {
      var_6 = distance2dsquared(var_0, var_5.origin);

      if(var_6 < var_2) {
        var_3 = var_5;
        var_2 = var_6;
      }
    }
  }

  return var_3;
}

_id_131C0(var_0) {
  level.br_armory_kiosk.scriptables = var_0;
}

armorykioskused(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return;
  }
  if(istrue(var_3 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_99BF1329D1D1E75FE321F84309778B37879F3D33B2", var_0))) {
    return;
  }
  if(istrue(var_3.iscarrying) && !isDefined(var_3.get_search_turret_target_player))
    var_3 scripts\mp\hud_message::showerrormessage("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
  else {
    if(istrue(var_3.tracking_max_health))
      var_3 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

    scripts\cp\vehicles\vehicle_compass_cp::_id_120A8("_encstr_B48D064CB8E8E33A");

    if(var_2 == "_encstr_BE8B08E323FB2BCD6268") {
      if(var_0.type != "_encstr_AC4D12130876D0524D95EE26F11B2983D878DF8F")
        var_0 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_93CF08C7684F60BBB372");

      var_0 thread wait_for_anyone_nearby_hint();
      var_3 thread _runpurchasemenu(var_0);
      return;
    }

    if(var_2 == "_encstr_93CF08C7684F60BBB372" || var_2 == "_encstr_ADB405071B8AE8")
      var_3 thread _runpurchasemenu(var_0);
  }
}

wait_for_anyone_nearby_hint() {
  if(!getdvarint("_encstr_85891F93CA3358E072B7370BBF1AE0AF3B028A9E639B88584F5F0909D9C0A85E87", 1)) {
    return;
  }
  var_0 = getdvarfloat("_encstr_A554266E1B397D13E4D7B5A5BD6EB6EB332D0F7D1CE4DB372BAF38D885BCB2399BEB270BC896AEDC", 300);
  _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::player_give_intel_1_ks(var_0);
}

wait_for_enemies_inarea(var_0, var_1) {
  if(!isDefined(var_0.playdeathanim_groundturret))
    var_0.playdeathanim_groundturret = [var_1];
  else if(!scripts\engine\utility::array_contains(var_0.playdeathanim_groundturret, var_1))
    var_0.playdeathanim_groundturret = scripts\engine\utility::array_add(var_0.playdeathanim_groundturret, var_1);

  if(!var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::gethelispawns())
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations("_encstr_82102F4BEB110B2B7F4630E7D84893C235F213B77807604ED81FC241D93A508B8D0A5D46CFBA8AA9BE71131D234BB0312B", "_encstr_930B07BB1B6B3854FF", var_0.origin);

  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_1);
}

unstable_gauge_timer_active(var_0, var_1) {
  if(_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2))
    return 1;

  if(!isDefined(var_0) || !isDefined(var_0.playdeathanim_groundturret))
    return 0;

  return scripts\engine\utility::array_contains(var_0.playdeathanim_groundturret, var_1);
}

wait_for_all_traps_disabled(var_0, var_1) {
  if(!isDefined(var_0.playdeathanim_groundturret)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_1);
  var_0.playdeathanim_groundturret = scripts\engine\utility::array_remove(var_0.playdeathanim_groundturret, var_1);
}

removefromdismembermentlist() {
  return 180.0 + randomfloatrange(-10.0, 10.0);
}

_id_13169(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_4 = "_encstr_8D7011C8D1B0DE8AC14A318F37C2CF5349D689" + var_0;

    if(var_4 == "_encstr_950C1CB35B8965D8C78753BD0BBF47E263B00198633068499001197B28CB") {
      var_5 = scripts\engine\utility::ter_op(var_1, 1, 0);
      var_3 _id_1260D(var_4, var_5, 0, 1);
      continue;
    }

    var_3 setclientomnvar(var_4, var_1);
  }
}

_runpurchasemenu(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_AD75063D571AE108");
  var_2.delay_kick_inactive_player = var_0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    var_2 notify("_encstr_9A760BB55ABDDCADAFABCD5646");

  var_3 = unstable_gauge_timer_active(var_0, var_2);
  var_4 = var_2 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
  var_2 _encstr_AB9F1781AB6B916842FB755BF06B406DC3D25B49E2D7D8781A();

  if(istrue(var_1)) {
    var_3 = 0;
    var_4 = 0;
  }

  if(isDefined(level.dialog_wait_ready_civ) && !istrue(var_2.delete_silo_lights))
    var_2 setclientomnvar("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B", level.dialog_wait_ready_civ);

  var_2 setclientomnvar("_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2", 0);

  if(var_3)
    var_2 setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 2);
  else if(var_4)
    var_2 setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 3);
  else
    var_2 setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 1);

  var_2.armorykioskpurchaseallowed = 1;
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructable_car(var_2, "_encstr_B4FF0AF78B086B6748237F85");
  var_2 thread apc_target_enemies(var_0);
  var_2 setsoundsubmix("_encstr_B2441A027B8BE7063017C0D42BB8CF77D616BA8AC086FFB1105BC6B5");
}

addtop3brcharge(var_0) {
  var_1 = self;
  var_1 setclientomnvar("_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2", var_0);
  var_1 setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 0);
  var_1 setclientomnvar("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B", -1);
  var_1 clearsoundsubmix("_encstr_B2441A027B8BE7063017C0D42BB8CF77D616BA8AC086FFB1105BC6B5");
  scripts\cp_mp\vehicles\vehicle_interact::_id_141A8(var_1._id_1424D, var_1);
  var_1.delay_kick_inactive_player = undefined;
  var_1.delete_silo_lights = undefined;
  var_1._id_1424D = undefined;
  var_1.armorykioskpurchaseallowed = undefined;
  var_1 notify("_encstr_8F6615C1AEE4B1A158B959F56B5937ABF58D637BDCAC91", var_0);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructable_car(var_1, "_encstr_8F330B39D76A636EE3CB08F0F7", "_encstr_8CCF094EB2C2B9DB9B4708" + var_0);
}

ally_charge_dialogue(var_0) {
  var_0 addtop3brcharge(0);
  var_0 notify("_encstr_BE061A2944C3436B0DB1A72780BB2F7881D0AADF31635AA50ED0ABBB");
}

apc_target_enemies(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_BE061A2944C3436B0DB1A72780BB2F7881D0AADF31635AA50ED0ABBB");
  var_1 endon("_encstr_BE061A2944C3436B0DB1A72780BB2F7881D0AADF31635AA50ED0ABBB");
  var_1 childthread ally1_intro_dialogue(var_0);
  scripts\engine\utility::waittill_any_ents(var_1, "_encstr_AD75063D571AE108", var_1, "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", var_1, "_encstr_B1400F78E390148725F663DAD890D30EF0", var_1, "_encstr_97050B93D73E32650159F0BC53", level, "_encstr_9B1D0BC7932875276230426AA1", var_0, "_encstr_AD75063D571AE108");
  var_1 addtop3brcharge(2);
}

ally1_intro_dialogue(var_0) {
  var_1 = self;
  var_2 = 64;
  var_3 = getdvarfloat("_encstr_86CD0A710C4B7925595F8A3B", 128) + var_2;
  var_4 = var_3 * var_3;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }

    var_5 = distancesquared(var_1.origin, var_0.origin);

    if(isDefined(var_5) && var_5 > var_4) {
      var_1 notify("_encstr_B1400F78E390148725F663DAD890D30EF0");
      break;
    }
  }
}

ai_rush_players_thread(var_0) {
  var_1 = self;

  if(!isDefined(var_0))
    return 0;

  var_2 = var_1 scripts\mp\equipment::getequipmentammo(var_0);
  var_3 = var_1 scripts\mp\equipment::getequipmentmaxammo(var_0);
  return max(0, var_3 - var_2);
}

allowattackfromexposednonode(var_0) {
  var_1 = self;

  if(!isDefined(var_0))
    return 0;

  var_2 = var_1 scripts\mp\equipment::getequipmentammo(var_0);
  var_3 = var_1 scripts\mp\equipment::getequipmentmaxammo(var_0);

  if(var_2 < var_3)
    var_1 scripts\mp\equipment::setequipmentammo(var_0, var_3);
}

ai_molotov_swap(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = var_2 scripts\mp\equipment::getequipmentmaxammo("_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D");

  if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0))
    var_5 = 2;
  else
    var_5 = 5;

  var_6 = int(clamp(var_5, 0, var_4 - var_3));
  var_7 = var_5 - var_6;

  if(var_7 > 0 && !istrue(var_1)) {
    var_8 = undefined;

    if(istrue(var_0))
      var_8 = removefromdismembermentlist();

    var_9 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_10 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_9, var_2.origin, var_2.angles, var_2, var_8);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", var_10, var_7, 1);
  }

  return var_6;
}

apc_rus_initdamage(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = _encstr_8AAE183B6A2385E98724EEEE1AD77361CFE29088E33E27A39B4C(var_0.ref);
  var_5 = unstable_gauge_timer_active(var_3.delay_kick_inactive_player, var_3);
  var_6 = var_3 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
  var_7 = ai_push_to_position(var_0, var_0.cost, var_5, var_0.playboxuseanimation, var_6, var_0._id_122FC, var_4);

  if(!isDefined(var_3.plundercount))
    var_3.plundercount = 0;

  if(var_3.plundercount < var_7) {
    var_3 addtop3brcharge(3);
    return 0;
  }

  if(var_0.type == "_encstr_85CE0B9770B02C73A1760F06D2") {
    if(var_0.ref == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
        var_3 addtop3brcharge(4);
        return 0;
      } else if(var_3 scripts\mp\juggernaut::changecirclestateatlowtime()) {
        var_3 addtop3brcharge(27);
        return 0;
      }
    }

    if(!istrue(var_1)) {
      if(var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::haskillstreak(var_0.ref)) {
        var_3 addtop3brcharge(4);
        return 0;
      }
    }
  } else if(var_0.type == "_encstr_B6760D6431CFD0A93B6B48E8929753") {
    if(var_3 scripts\mp\supers::issuperinuse()) {
      var_3 addtop3brcharge(6);
      return 0;
    }

    if(!istrue(var_1)) {
      var_8 = var_3 scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_8) && var_0.ref == var_8) {
        var_3 addtop3brcharge(5);
        return 0;
      }
    }
  } else if(var_0.type == "_encstr_B85F08DC83596CA5858D") {
    switch (var_0.ref) {
      case "_encstr_97990DD95DD0650B6881833A69D96F":
      case "_encstr_A7B606DA83796F4A":
        break;
      case "_encstr_95DD09E95E7BF1B902D7F7":
        if(istrue(var_2))
          return 1;

        var_9 = spawnStruct();
        var_9.scriptablename = "_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28";
        var_10 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::cantakepickup(var_9);
        break;
      case "_encstr_A261113C1AE3575ACFF7FAD125B3CB88A24CEB":
        if(istrue(var_2))
          return 1;

        var_9 = spawnStruct();
        var_9.scriptablename = "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253";
        var_10 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::cantakepickup(var_9);
        break;
      case "_encstr_92360C9FC3A1E24F98A967AC6080":
        if(istrue(var_2))
          return 1;

        var_11 = 0;

        if(var_3 ai_rush_players_thread(var_3.equipment["_encstr_BA7F0830B3A7859B60B0"]) > 0)
          var_11 = 1;
        else if(var_3 ai_rush_players_thread(var_3.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]) > 0)
          var_11 = 1;
        else if(!var_3 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawnallaccesscards())
          var_11 = 1;

        if(!var_11) {
          var_3 addtop3brcharge(8);
          return 0;
        }

        break;
      case "_encstr_83540EE4959B072CEEE67DD1DBD62BB9":
        if(_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12CB6()) {
          var_3 addtop3brcharge(9);
          return 0;
        }

        if(istrue(var_2))
          return 1;

        if(istrue(var_3.hasrespawntoken)) {
          var_3 addtop3brcharge(10);
          return 0;
        }

        break;
      case "_encstr_97B21237CAB199EB4E2BD9A5B359F5E87BB595E6":
        if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
          var_3 addtop3brcharge(24);
          return 0;
        }

        if(istrue(var_2))
          return 1;

        if(var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint()) {
          var_3 addtop3brcharge(10);
          return 0;
        }

        break;
      case "_encstr_93920C9E781BB33078D689330FA7":
        if(istrue(var_2))
          return 1;

        var_9 = spawnStruct();
        var_9.scriptablename = "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768";
        var_9.count = 1;
        var_10 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::cantakepickup(var_9);

        if(var_10 != 1) {
          var_3 addtop3brcharge(7);
          return 0;
        }

        break;
      case "_encstr_A1830CBB3BD323F01B098B82FBF8":
        if(isDefined(level.br_circle)) {
          var_3 addtop3brcharge(17);
          return 0;
        }

        break;
      case "_encstr_81E7093272DCB353B86F77":
        if(!istrue(level.brking_initdialog) && (isDefined(level.br_circle) || istrue(level.disable_super_in_turret.gulagfixuparena))) {
          var_3 addtop3brcharge(9);
          return 0;
        }

        break;
      case "_encstr_84650F5E952887C6C138F923D011BE7F83":
        if(!var_3 addspecialistbonuspickup()) {
          var_3 addtop3brcharge(21);
          return 0;
        }

        break;
      case "_encstr_821E160B80C369A28345F1D3D8DA4A1939D5E1DB3EA08F38":
        if(!var_3 addteabagcharge("_encstr_A7B606DA83796F4A")) {
          var_3 addtop3brcharge(20);
          return 0;
        }

        break;
      case "_encstr_ADB216DEF8E4F09F8CA1B1E3B2AB09C4284733F8772BACB3":
        if(!var_3 addtenkillcharge()) {
          var_3 addtop3brcharge(19);
          return 0;
        }

        break;
      case "_encstr_BE3517B89F6028C73AAF405DC2A22D91D4376920BB0F43E9B3":
        if(!var_3 addteabagcharge("_encstr_9BB4074B8EEF3942D8")) {
          var_3 addtop3brcharge(20);
          return 0;
        }

        break;
      case "_encstr_B2BF1418FAB463D90BA56875A87FA33B1F42D99852CB":
        if(!var_3 addteabagcharge("_encstr_851904B59B34")) {
          var_3 addtop3brcharge(20);
          return 0;
        }

        break;
      case "_encstr_A58017EBC5A9EAE308A0EF4F2041CAD2196D3966BFC5132DD0":
        if(!var_3 addteabagcharge("_encstr_A19A0772BF43C35FD9")) {
          var_3 addtop3brcharge(20);
          return 0;
        }

        break;
      case "_encstr_B8AD10453F2A1BA8D4E72E838F9088473287":
        if(var_3 scripts\mp\supers::issuperinuse()) {
          var_3 addtop3brcharge(6);
          return 0;
        }

        if(var_3 announcedomplatespawns()) {
          var_3 addtop3brcharge(23);
          return 0;
        }

        if(!var_3 addspecialistdialog()) {
          var_3 addtop3brcharge(22);
          return 0;
        }

        break;
      case "_encstr_AF8B101B6A1D60CB923B437F73598FE8A204":
        if(var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
          var_3 addtop3brcharge(26);
          return 0;
        }

        break;
    }
  }

  return 1;
}

allow_ascender_use(var_0) {
  switch (var_0) {
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      return 1;
    case "_encstr_851904B59B34":
      return 0;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 0;
    default:
      return 0;
  }
}

allow_deleteme_path() {
  var_0 = self;
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_AD75063D571AE108", level, "_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
}

_encstr_9A691809F02B5320817A65D5595B51D2E357B679138BD1E1EFD4(var_0) {
  var_1 = "_encstr_9AFB11D44AC731585561E933943258F94783A8" + var_0;
  self notify(var_1);
  self endon(var_1);
  self._encstr_8A0A113822071B08FFC47F71E426E853931AF1 = var_0;
  wait 2.0;
  self._encstr_8A0A113822071B08FFC47F71E426E853931AF1 = undefined;
}

_encstr_964913AF7363F80F13EB4D3147600123BFE98C65F3(var_0) {
  var_1 = isDefined(self._encstr_8A0A113822071B08FFC47F71E426E853931AF1) && self._encstr_8A0A113822071B08FFC47F71E426E853931AF1 == var_0;
  thread _encstr_9A691809F02B5320817A65D5595B51D2E357B679138BD1E1EFD4(var_0);

  if(var_1) {
    return;
  }
  thread scripts\mp\hud_message::showsplash(var_0);
}

aigroundturret_shouldmountturret(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = getdvarint("_encstr_B2BE1C309A320FF9739F777EAC47233B1B4279A9B0CDC9D35BCB8B67839F", 0);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8D051D58D8D14BD9583A95D2D2C663E61D2795165B9E7314AB9CC60DB0CDAC")) {
    var_5 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8D051D58D8D14BD9583A95D2D2C663E61D2795165B9E7314AB9CC60DB0CDAC", var_0.ref);

    if(isDefined(var_5))
      var_4 = var_5;
  }

  if(!var_4) {
    var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(var_0.ref, var_1, 1, var_2);
    var_3 _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0._id_122FC, var_0._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0);
    var_3 thread scripts\mp\hud_message::showsplash("_encstr_9618183E92F9DF286C4B68482BBDE11741BA2DBEAEE293534D83");
    var_3 scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_0.cost, "_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
  } else {
    if(allow_ascender_use(var_0.ref)) {
      var_6 = var_3.delay_kick_inactive_player;
      var_3 addtop3brcharge(16);
      var_3 scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B48D064CB8E8E33A");
      var_3 beginlocationselection(0, 0, 0, 0, 4);
      var_3 childthread allow_deleteme_path();
      var_7 = var_3 scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", "_encstr_91A21017B155D07573493840921FB5C8AD06");
      var_3 endlocationselection();
      var_3 scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_B48D064CB8E8E33A");

      if(isDefined(var_7) && var_7.string == "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773") {
        var_8 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13C34(var_7.location);
        var_3.waitandunloadinfils = var_8["_encstr_BD260953AA97E3F014279D"];
        var_9 = var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forceusekillstreak(var_0.ref);

        if(istrue(var_9)) {
          var_3 _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0._id_122FC, var_0._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0);
          var_3 thread scripts\mp\hud_message::showsplash("_encstr_8C8826125686C73CB938630BD0F3768FFE3F8D9A66C837424350A95258D9215FD1A5E9168F936FCF");
          scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
          _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_0.cost, "_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
          return;
        }

        return;
      }

      var_3 thread _runpurchasemenu(var_6);
      return;
      return;
    }

    var_9 = var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forceusekillstreak(var_0.ref);

    if(istrue(var_9)) {
      var_3 _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0._id_122FC, var_0._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0);
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_8C8826125686C73CB938630BD0F3768FFE3F8D9A66C837424350A95258D9215FD1A5E9168F936FCF");
      scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_0.cost, "_encstr_85CE0B9770B02C73A1760F06D2", var_0.ref);
    }
  }
}

aigroundturret_shouldcompletedismount(var_0, var_1, var_2) {
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_0.ref, var_1, 1, var_2);
  _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0._id_122FC, var_0._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0);
  thread scripts\mp\hud_message::showsplash("_encstr_A98E1B4002F9FAC407D18C301807C70EE373A79642BBAB9FF05F8A17C1");
  scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_B6760D6431CFD0A9336B48E8929753", var_0.ref);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_0.cost, "_encstr_B6760D6431CFD0A9336B48E8929753", var_0.ref);

  if(level.allowsupers && !istrue(var_2))
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
}

aigroundturretref(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 1;
  var_5 = 1;
  var_6 = undefined;

  switch (var_0.ref) {
    case "_encstr_A7B606DA83796F4A":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", 1, undefined, 1, var_2);
      break;
    case "_encstr_97990DD95DD0650B6881833A69D96F":
      var_7 = var_3 ai_molotov_swap(1);

      if(var_7 <= 0)
        var_4 = 1;
      else
        var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", 1, var_7, 1, var_2);

      break;
    case "_encstr_95DD09E95E7BF1B902D7F7":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", 1, undefined, 1, var_2);
      break;
    case "_encstr_A261113C1AE3575ACFF7FAD125B3CB88A24CEB":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253", 1, undefined, 1, var_2);
      break;
    case "_encstr_92360C9FC3A1E24F98A967AC6080":
      var_3 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
      var_3 allowattackfromexposednonode(var_3.equipment["_encstr_BA7F0830B3A7859B60B0"]);
      var_3 allowattackfromexposednonode(var_3.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]);
      break;
    case "_encstr_83540EE4959B072CEEE67DD1DBD62BB9":
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken();
      var_5 = 0;
      break;
    case "_encstr_97B21237CAB199EB4E2BD9A5B359F5E87BB595E6":
      if(istrue(var_2))
        var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", 1, undefined, 1, var_2);
      else
        var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::bdroppingshield();

      var_5 = 0;
      break;
    case "_encstr_9BC309F2BB8BFFA29138BA":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_A378104B25894AD7104638C5D971F333D383", 1, undefined, 1, 1);
      break;
    case "_encstr_93920C9E781BB33078D689330FA7":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768", 1, undefined, 1, var_2);
      break;
    case "_encstr_A1830CBB3BD323F01B098B82FBF8":
      var_4 = var_3 _id_125C1();
      break;
    case "_encstr_81E7093272DCB353B86F77":
      var_4 = var_3 _id_125C4();
      break;
    case "_encstr_84650F5E952887C6C138F923D011BE7F83":
      var_4 = var_3 airdrop_applyimmediatejuggernaut();
      break;
    case "_encstr_821E160B80C369A28345F1D3D8DA4A1939D5E1DB3EA08F38":
      var_4 = var_3 airdrop_bronloadoutcratedestroyed("_encstr_A7B606DA83796F4A");
      break;
    case "_encstr_ADB216DEF8E4F09F8CA1B1E3B2AB09C4284733F8772BACB3":
      var_4 = var_3 airdop_brloadoutcratefirstactivation("_encstr_9BB4074B8EEF3942D8");
      break;
    case "_encstr_BE3517B89F6028C73AAF405DC2A22D91D4376920BB0F43E9B3":
      var_4 = var_3 airdrop_bronloadoutcratedestroyed("_encstr_9BB4074B8EEF3942D8");
      break;
    case "_encstr_B2BF1418FAB463D90BA56875A87FA33B1F42D99852CB":
      var_4 = var_3 airdrop_bronloadoutcratedestroyed("_encstr_851904B59B34");
      break;
    case "_encstr_A58017EBC5A9EAE308A0EF4F2041CAD2196D3966BFC5132DD0":
      var_4 = var_3 airdrop_bronloadoutcratedestroyed("_encstr_A19A0772BF43C35FD9");
      break;
    case "_encstr_B8AD10453F2A1BA8D4E72E838F9088473287":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_824D234B25894AD710467D0759C8E19255E7CFABC5A7E293F04933CF70282BEABD391B0F71", 1, undefined, 1, var_2);
      break;
    case "_encstr_8FF210B227E79003BEF477454A0B08ED9350":
      var_8 = getdvarfloat("_encstr_BAE519EE8E73EF0127F72838E344B8C31AF370FDE38B5B0B19E730", 60);
      var_9 = getdvarfloat("_encstr_AAA1179653FBDEFDE59258587B7FABD133EC088EA94BC0EBCA", 4112);

      if(isDefined(level.create_exfil_animstruct) && isDefined(level._id_14687) && isDefined(level._id_14687._id_11AE9)) {
        var_10 = undefined;

        foreach(var_12 in level.create_exfil_animstruct) {
          if(var_12.refname == level._id_14687._id_11AE9)
            var_10 = var_12;
        }

        if(isDefined(var_10)) {
          level.create_ai_type_override = var_10._id_119A7;
          var_9 = var_10._id_119A8;
        }
      }

      var_4 = level _hidesafecircleui::changetimertoovertimetimer(level.create_ai_type_override, var_3, var_8, var_9);

      if(var_4)
        var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12BFC();

      break;
    case "_encstr_85561103633342E48119743F310838CA9BFDC3":
      var_4 = _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::firesalediscount(var_3, var_3.delay_kick_inactive_player);
      break;
    case "_encstr_9A340C88CBC47929D7C4B704AD1B":
      var_4 = _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::fix_wall_traversal(var_3, var_3.delay_kick_inactive_player);
      break;
    case "_encstr_8EFF0F72C3701FB7B9FE1BD2C3858B13D8":
      var_3 _keypadscriptableused_bunkeralt::script_model_spawn_and_use_logic();
      var_5 = 0;
      break;
    case "_encstr_AF8B101B6A1D60CB923B437F73598FE8A204":
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::bearsetup(0);
      var_4 = 1;

      if(var_3 calloutmarkerping_entityzoffset("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B") == 8)
        var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BECD185F7E8B3A3F98C01FFB58B0D7B2791F66146933237381E0");

      break;
    case "_encstr_A354113F6987E6F74FFA80B8A3E99F78DF03CA":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_82FE1C325B21A7C580975B5199288AB356D19A2A4606477D58F55127B373", 1, undefined, 1, var_2);
      break;
    case "_encstr_978113B12DE4B163CAF5897BD613583991B5599B8E":
      if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
        var_4 = level _hidesafecircleui::changing_loadout(var_3);
      else {
        scripts\mp\utility\script::laststand_dogtags("_encstr_96AA1BE4B7109B853356801BA54EB1D82B02ACB93A80C895CC96E6B223");
        var_4 = 0;
      }

      if(!var_4)
        var_3 addtop3brcharge(28);

      break;
    case "_encstr_BAF90BD64BF637B67D3293DB07":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_87FD19B083BD774063E708F4B67BC92DE7F94060CA92B7F943CF8F", 1, undefined, 1, var_2);
      break;
    case "_encstr_8F0D1073EA5B13AC39377DD9C9599B1623CA":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_BAB91F3D8AED88583B113019AA6307D887CF5D9B0DD6101EDF090983E223CF401F", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B") == 8)
        var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BECD185F7E8B3A3F98C01FFB58B0D7B2791F66146933237381E0");

      break;
    case "_encstr_A5E7109DD762FD283181938EF21728B8DA67":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_960D1926A828D0072309D73F334716B668B5ED838190BFD3E277F3", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B") == 8)
        var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BECD185F7E8B3A3F98C01FFB58B0D7B2791F66146933237381E0");

      break;
    case "_encstr_9B1904D099EB":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B") == 8)
        var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BECD185F7E8B3A3F98C01FFB58B0D7B2791F66146933237381E0");

      break;
    case "_encstr_924C0CBBB051CE1F0335E427DF2B":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_868F2330EB4CF0C753D9BC4DAEEB3F1897770A610F0A8E930B7CBDCE42D2C10B2F8750B03B", 1, undefined, 1, var_2);
      break;
    case "_encstr_92BC0D488AC723893B95C5507BA7F1":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_AC6C22F8CBF52F182B5FBCBD79E3C0E59163C289B3CD17500F804BAE5BDF4A3FC37A7868", 1, undefined, 1, var_2);
      break;
    case "_encstr_A68D11E459322CC68ECA8CD79BA1ED3AB357CD":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_9B5921C43936F6DB1D7DDD95C238F6CDD79B1AEBDCD0FA89E4BD6B95DEA6EBEAB1D19C", 1, undefined, 1, var_2);
      break;
    case "_encstr_AFC8104BC15DF7AED84BECCF7FD0F47B759B":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_B12C20A89BA51F281B8F6C6D893310D5C11392B982FAC7201FCB7E5772679B8973AB", 1, undefined, 1, var_2);
      break;
    case "_encstr_A3BC0D63775438867BD781EFEBB2DC":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_BA042189E463DBBD3AD7EEB20B07B7E6F53743FA5BD9BED63BDE36CC6823EBBA631DE4", 1, undefined, 1, var_2);
      break;
    case "_encstr_B16011ADE752CD18E151437E42D8980E5A5F31":
      var_4 = _encstr_A77C2FBB906DDC43F3CE5F0567B0D766EB085393702B1206E9B6270271019F2C67D08A5B5BF30B8FE31DE52B15C0477247::_encstr_A50F19B3A76408B64B87D19FF7628FC837FD9E8BCBDAA0FBF237DB(var_3, "_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", 1, undefined, 1, var_2);
      break;
    case "_encstr_8B820C8D96391B1B59FAC1ACB2B6":
      var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_3, "_encstr_85C61EB6FA3B604F8B69F8E072A52F5B2B954FBA7FBF68BDB642B049CBBFCB70", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B") == 8)
        var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_BECD185F7E8B3A3F98C01FFB58B0D7B2791F66146933237381E0");

      break;
    case "_encstr_93921296A863A3C0F871ABF3053073F7A2A8C71E":
      var_5 = 0;
      var_3 _encstr_964913AF7363F80F13EB4D3147600123BFE98C65F3("_encstr_92400FB502B928D5ABAABE0113831D404F");
      break;
    case "_encstr_A7C4147FB830F35B9B9AA0E06838D3E808B2DE14E2AB":
      var_5 = 0;
      var_3 _encstr_964913AF7363F80F13EB4D3147600123BFE98C65F3("_encstr_912512E0D32115D0B364BFA34E5779ABD51A0850");
      break;
    case "_encstr_8DC408AED390E5087DC2":
      var_5 = 0;
      var_3 _encstr_964913AF7363F80F13EB4D3147600123BFE98C65F3("_encstr_912512E0D32115D0B364BFA34E5779ABD51A0850");
      break;
    case "_encstr_B20A0DE24696EB2FBDC0530A089B23":
      var_5 = 0;
      var_3 _encstr_964913AF7363F80F13EB4D3147600123BFE98C65F3("_encstr_92400FB502B928D5ABAABE0113831D404F");
      break;
    default:
      break;
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8174112FC868FB3A2F2005B2155DF2B8F1706F"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8174112FC868FB3A2F2005B2155DF2B8F1706F", var_3, var_0.ref);

  if(var_4) {
    var_3 _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0._id_122FC, var_0._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0);

    if(var_5)
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_B29312EA40010BFB02091FB3DBBB0A4B9F8FD8B3");

    scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_B85F08DC83596CA5858D", var_0.ref);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_0.cost, "_encstr_B85F08DC83596CA5858D", var_0.ref);
  }
}

aigroundturretstate(var_0, var_1) {
  var_2 = (1, 1, 1);
  var_3 = (1, 0, 0);
  var_4 = (0, 1, 0);
  var_5 = (0, 1, 1);
  var_6 = 3;
  var_7 = 8;
  var_8 = self.delay_kick_inactive_player.origin;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle())
    return 0;

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    return 0;

  var_9 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"]);
  var_10 = 300;
  var_11 = 90;
  var_12 = 300;
  var_13 = 150;
  var_14 = var_13 + var_10;
  var_15 = 0;
  var_16 = undefined;
  var_17 = undefined;

  for(var_18 = undefined; var_15 < 360; var_15 = var_15 + var_11) {
    var_19 = var_8 + (sin(var_15) * var_10, cos(var_15) * var_10, 0);
    var_16 = (var_19[0], var_19[1], var_19[2] + var_14);
    var_17 = (var_19[0], var_19[1], var_19[2] - var_14);
    var_20 = physics_spherecast(var_16, var_17, var_12, var_9, undefined, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

    if(var_20.size > 0) {
      var_21 = var_20[0]["_encstr_BD260953AA97E3F014279D"];
      var_17 = (var_16[0], var_16[1], var_20[0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"][2] - var_10);

      if(!isDefined(var_20[0]["_encstr_850E077B0BF30318B9"]) && abs(var_17[2] - var_19[2]) < var_13) {
        if(!isDefined(var_18)) {
          var_18 = var_17 + (0, 0, var_10);

          if(!getdvarint("_encstr_95011EE6C627BEB3AC43B48D63CAA5D2DE6E6D325ACD46A01B63A938C27773E6", 0) > 0) {
            break;
          }
        }
      } else {}

      continue;
    }
  }

  if(!isDefined(var_18))
    return 0;

  var_22 = 150;
  var_23 = spawnStruct();
  var_23.origin = var_18 + (0, 0, var_22);
  var_23.angles = (0, randomintrange(0, 360), 0);
  var_23.owner = self;
  var_23.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_24 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var_0.ref, var_23);

  if(!isDefined(var_24))
    return 0;

  var_25 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(var_24);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_24, var_25, self);
  scripts\cp_mp\vehicles\vehicle_spawn::_id_14219(var_24);
  return 1;
}

addspecialistbonuspickup() {
  var_0 = self;
  var_1 = var_0._id_1424D;

  if(isDefined(var_1)) {
    if(var_1.health == var_1.maxhealth)
      return 0;

    return 1;
  }

  return 0;
}

addtenkillcharge() {
  var_0 = self;
  var_1 = var_0._id_1424D;

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_13DDF) && isDefined(var_1._id_11B7B) && var_1._id_13DDF == var_1._id_11B7B)
      return 0;
    else
      return 1;
  }

  return 0;
}

addteabagcharge(var_0) {
  var_1 = self;
  var_2 = var_1._id_1424D;

  if(isDefined(var_2)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_2, var_0))
      return 0;
    else
      return 1;
  }

  return 0;
}

airdrop_applyimmediatejuggernaut(var_0, var_1) {
  var_2 = self;
  var_3 = var_2._id_1424D;

  if(isDefined(var_3)) {
    if(var_3.health == var_3.maxhealth)
      return 0;

    var_4 = getdvarfloat("_encstr_8FBE1C4B43B59FCCE1C54D40FB08D22753D992522B83B7C2D8ED435D8DC8", 0.25);
    var_5 = int(var_3.maxhealth * var_4);
    var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_1413C(var_5);
    var_6 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_2 in var_6) {
      if(getdvarint("_encstr_BDD929EB4E8D492BFA18FBBAABB27DB966ADE0BB9383E7DA8825D757787CC7BA997D4FABAFB9F19D595BA0", 1) == 1)
        var_2 scripts\mp\damagefeedback::hudicontype("_encstr_A53F0A838B7D471490138184");

      var_2 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", var_3.health);
      var_2 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", var_3.maxhealth);
    }

    return 1;
  }

  return 0;
}

airdop_brloadoutcratefirstactivation(var_0) {
  var_1 = self;
  var_2 = var_1._id_1424D;

  if(isDefined(var_2)) {
    scripts\cp_mp\vehicles\vehicle_interact::_id_141A4(var_2, var_0, var_1);
    return 1;
  }

  return 0;
}

airdrop_bronloadoutcratedestroyed(var_0) {
  var_1 = self;
  var_2 = var_1._id_1424D;

  if(isDefined(var_2)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_2, var_0))
      return 0;
    else {
      scripts\cp_mp\vehicles\vehicle_interact::_id_141A4(var_2, var_0, var_1);
      return 1;
    }
  }

  return 0;
}

announcedomplatespawns() {
  var_0 = self;
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_4 = var_3 scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_4) && var_4 == "_encstr_83FE13501FB86925492B1D93C4A251D12FF3C038F3") {
        if(var_3 getammocount(var_3.super.staticdata.weapon) > 0)
          return 1;
      }
    }
  }

  if(isDefined(level._id_13ACD) && istrue(level._id_13ACD[var_0.team]))
    return 1;

  return 0;
}

addspecialistdialog() {
  if(isDefined(level._id_13ACE) && !isDefined(level._id_13ACE[self.team]))
    return 1;

  return 0;
}

onarmorykioskpurchase(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.delay_kick_inactive_player;

  if(!istrue(var_2.armorykioskpurchaseallowed)) {
    return;
  }
  var_4 = "_encstr_95F50A023916A815D09C2278" + var_0;

  if(isDefined(var_1))
    var_4 = var_4 + "_encstr_81580A45B003531197BB7849" + var_1;

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructable_car(var_2, "_encstr_B2DD0E9A6F95CF4781DB7B065142DE88", var_4);
  var_5 = getdvarint("_encstr_A9701E9B2E8A01CE2377C7CB9F1B82C125C20170D6D398E5FB4FE9B3EB02D910", 1);
  var_6 = getdvarint("_encstr_B80826528380F1E8C239FBD2702FF70B0F6D8B1C1A627FF05AB8D78F35C39A6BEFE32781D36BFD28", 0);

  if(var_2 scripts\mp\utility\killstreak::isjuggernaut())
    var_6 = 1;

  if(var_0 == "_encstr_ACFD135AE8C7AEF7A0D60534E04BEFB2E75012C3C8")
    ally_charge_dialogue(var_2);
  else if(var_0 == "_encstr_B148118927AFA53AAC5B7D38ABE4D8A10BCD2B") {
    var_7 = var_1;
    var_8 = level.br_armory_kiosk.items[var_7];
    var_9 = var_2 apc_rus_initdamage(var_8, var_5, var_6);
    var_8._encstr_AC64111007FAA8613B2F5D5504638FD0459BB0 = var_2 _encstr_8AAE183B6A2385E98724EEEE1AD77361CFE29088E33E27A39B4C(var_8.ref);

    if(var_9) {
      if(var_8.type == "_encstr_85CE0B9770B02C73A1760F06D2")
        var_2 thread aigroundturret_shouldmountturret(var_8, var_5, var_6);
      else if(var_8.type == "_encstr_B6760D6431CFD0A93B6B48E8929753")
        var_2 aigroundturret_shouldcompletedismount(var_8, var_5, var_6);
      else if(var_8.type == "_encstr_B85F08DC83596CA5858D")
        var_2 aigroundturretref(var_8, var_5, var_6);
      else if(var_8.type == "_encstr_9A50080BA7292FFA0DA2") {
        var_10 = var_2 aigroundturretstate(var_8, var_5);

        if(var_10) {
          var_2 _makekioskpurchase(var_8, var_8.cost, var_8.playboxuseanimation, var_8._id_122FC, var_8._encstr_92D010C37908D8EB3D33F11F48415A2D56D9, var_0);
          var_2 thread scripts\mp\hud_message::showsplash("_encstr_A2B6154C4EFAD959864B8D63B2BE83BAC9D843C2B956C8");
          _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_8.cost, "_encstr_9A50080BA7292FFA0DA2", var_8.ref);
        } else
          var_2 scripts\mp\hud_message::showerrormessage("_encstr_87E51BD4A0795951249286988AF514AA49864205A615AF912892315422");
      }
    }
  } else if(var_0 == "_encstr_BE9714E5EBD11150512FD0EB5307E0D55B07496B779A") {
    var_7 = var_1;
    var_8 = level.br_armory_kiosk.items[var_7];
    var_11 = unstable_gauge_timer_active(var_2.delay_kick_inactive_player, var_2);
    var_12 = var_2 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
    var_13 = 0;
    var_14 = var_1;
    var_15 = level.br_armory_kiosk._id_11955;
    var_16 = level.br_armory_kiosk._id_11956;
    var_17 = level.br_armory_kiosk._id_11957;
    var_18 = var_2 _encstr_8AAE183B6A2385E98724EEEE1AD77361CFE29088E33E27A39B4C(var_8.ref);

    if(scripts\mp\menus::update_enemies_remaining(var_14)) {
      var_15 = level.br_armory_kiosk._id_11958;
      var_16 = level.br_armory_kiosk._id_11959;
      var_17 = level.br_armory_kiosk._id_1195A;
      var_13 = 1;
    }

    var_19 = ai_push_to_position(var_8, var_15, var_11, var_16, var_12, var_17, var_18);

    if(var_2.plundercount < var_19) {
      var_2 addtop3brcharge(3);
      return;
    }

    var_20 = scripts\mp\menus::getclasschoice(var_14);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyscorelaunchonly(self, "_encstr_83DD1739AD4AC8FB4FF39078DADFA0A0A32FB98F213760BD23");
    var_2.pers["_encstr_959506B911C79707"] = var_20;
    var_2.class = var_20;
    var_21 = var_2 scripts\mp\class::preloadandqueueclass(var_20);
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::delay_delete_reinforcement_called_icon(var_2, var_5);
    var_2 _makekioskpurchase(var_8, var_15, var_16, var_17, var_18, var_0);
    var_2 thread scripts\mp\hud_message::showsplash("_encstr_9B9615A22539DD777F592AB36358C35388EF5029BF4067");

    if(istrue(var_13))
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(self, var_19, "_encstr_99CF0FAA2858D1EB30EBA550916358D34D", "_encstr_87B309D042EE715017BC60" + var_14);
    else
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblevehiclesetup(self, var_19, var_21);
  } else if(var_0 == "_encstr_8C910FAE02697139F13F79E8E71E70BD12") {
    var_22 = var_1;
    var_11 = unstable_gauge_timer_active(var_2.delay_kick_inactive_player, var_2);
    var_16 = level.br_armory_kiosk._id_13AC3;
    var_12 = var_2 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
    var_17 = level.br_armory_kiosk._id_13AC4;
    var_23 = "_encstr_AB420B13C7C1C89EFA6B6B2D5F";
    var_18 = var_2 _encstr_8AAE183B6A2385E98724EEEE1AD77361CFE29088E33E27A39B4C(var_23);
    var_24 = ai_push_to_position(undefined, level.br_armory_kiosk._id_13AC2, var_11, var_16, var_12, var_17, var_18);
    var_25 = !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A9C319ABE6958ADBB6CAE651DB94ACECD2D995A29585D6B5B03AAC");
    var_26 = istrue(var_2.hasrespawntoken) && var_25 && var_2.plundercount < var_24;

    if(!var_26 && var_2.plundercount < var_24) {
      var_2 addtop3brcharge(3);
      return 0;
    }

    var_27 = undefined;
    var_28 = scripts\mp\utility\teams::getteamdata(var_2.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_30 in var_28) {
      if(!isDefined(var_30) || var_30 == var_2) {
        continue;
      }
      if(isDefined(var_30.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) && var_30.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] == var_22) {
        var_27 = var_30;
        break;
      }
    }

    if(!isDefined(var_27)) {
      var_2 addtop3brcharge(12);
      return;
    }

    if(!var_27 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::unlockscriptabledoors() && !getdvarint("_encstr_92FD1C6B801AEE65D8BFD9720B0E0A63AB735B3F4310593B62A3EED37BE0", 0)) {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::use_csm(var_27))
        var_2 addtop3brcharge(14);
      else if(isalive(var_27))
        var_2 addtop3brcharge(15);
      else
        var_2 addtop3brcharge(13);

      return;
    }

    var_32 = 0;

    if(!var_26) {
      var_33 = level.br_armory_kiosk._id_13AC2;
      var_16 = level.br_armory_kiosk._id_13AC3;
      var_17 = level.br_armory_kiosk._id_13AC4;
      var_2 _makekioskpurchase(undefined, var_33, var_16, var_17, var_18, var_0);

      if(istrue(var_2.hasrespawntoken))
        var_32 = 1;
      else
        var_2 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);

      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_AB420B13C7C1C89EFA6B6B2D5F", "_encstr_AB420B13C7C1C89EFA6B6B2D5F");
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(var_2, var_24, "_encstr_8AD811A395B0ADE4B2675ACEB2EBB5DE73562F", "_encstr_AB420B13C7C1C89EFA6B6B2D5F");
    } else {
      var_2 _makekioskpurchase(undefined, 0, 0, 0, 0, var_0);
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_1204B("_encstr_AB420B13C7C1C89EFA6B6B2D5F", "_encstr_AB420B13C7C1C89EFA6B6B2D5F");
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destructiblecarlightssetup(var_2, 0, "_encstr_8C6A114B92470928EFC67B4DFD5920C0C70A80", "_encstr_AB420B13C7C1C89EFA6B6B2D5F");
    }

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AB6E121F8B384F1A31424C9F0D0802380EE3B392"))
      var_27 thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AB6E121F8B384F1A31424C9F0D0802380EE3B392", var_2, var_26);
    else
      var_27 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_8C910FAE02697139F13F79E8E71E70BD12", var_2, var_26);

    if(var_32)
      var_2 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);

    level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_3.origin, "_encstr_9695073995D94BD959");
    var_2 thread scripts\mp\hud_message::showsplash("_encstr_A59215D2E33F9B57D0116250A7B5672E4BF9EB538B7D7D");

    if(getdvarint("_encstr_8F220B17E59FF1E9D15C692997", 0) && var_2 scripts\mp\utility\game::onlinestatsenabled())
      var_2 setplayerdata("_encstr_8C07031599", "_encstr_9B471567FA6267AAEB8398A2A8F778F710BC1FFCB0C843", 0, 1);
  }
}

_makekioskpurchase(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = unstable_gauge_timer_active(var_6.delay_kick_inactive_player, var_6);
  var_8 = var_6 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");

  if(var_7 && var_2 > 0)
    wait_for_all_traps_disabled(var_6.delay_kick_inactive_player, var_6);

  if(!(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B49086F374076B48192") || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::turret_headicon()))
    var_6 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_88860C1327D7D62DEDCD6D2457CB", undefined, _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::freeze_bomb_vest_timer(var_1), undefined, undefined, undefined, undefined, var_5);

  var_1 = ai_push_to_position(var_0, var_1, var_7, var_2, var_8, var_3, var_4);

  if(var_1 > 0)
    var_6 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12622(var_1);

  if(!isDefined(level.br_plunder))
    level.br_plunder = spawnStruct();

  if(!isDefined(level.br_plunder.wait_for_all_players_in_airlock))
    level.br_plunder.wait_for_all_players_in_airlock = 0;

  level.br_plunder.wait_for_all_players_in_airlock = level.br_plunder.wait_for_all_players_in_airlock + var_1;

  if(!isDefined(level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes))
    level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;

  level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes++;

  if(!level._encstr_B6AD1F984EAFC293D6B7C9E5D75B5ADB9BD6FAB11BDBE659BE6BB2E6D5AF994B87) {
    if(var_6 scripts\engine\utility::_id_12C44("_encstr_B1421EA8EBE0274B4FA4636886FF70D7CA725968B23BE740E3CDF656689F5B9B"))
      var_6 addtop3brcharge(1);
  } else
    var_6 thread _encstr_B19F1A1CD8C25E2BE48DB1DBCD2B26D5BC9B3A851D5AB7B9AD59E65D();
}

_encstr_B19F1A1CD8C25E2BE48DB1DBCD2B26D5BC9B3A851D5AB7B9AD59E65D() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B19F1A1CD8C25E2BE40DB1DBCD2B24D5BC9A3A851D5AB7B9A959E65D");
  self endon("_encstr_B19F1A1CD8C25E2BE40DB1DBCD2B24D5BC9A3A851D5AB7B9A959E65D");
  var_0 = _encstr_8A9D1B53532FC3F5100BA72EC0482A4B06EFBBB7D95D9BA1D8315D33DB("_encstr_B1421EA8EBE0274B4FA4636886FF70D7CA725968B23BE740E3CDF656689F5B9B", level._encstr_910823358239E0DE572A9BE231171BD84AE3C7AF349DA8AD77227108FBEF4D106545DF0BB4);

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    addtop3brcharge(1);
}

_encstr_8A9D1B53532FC3F5100BA72EC0482A4B06EFBBB7D95D9BA1D8315D33DB(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8A9D1B53532FC3F5100BAF2EC0482A4906EFBBB7D95D99A1D8315D33DB" + var_0);
  self setpredictedstreamloaddist(var_0);
  scripts\engine\utility::delaythread(var_1, scripts\engine\utility::send_notify, "_encstr_8A9D1B53532FC3F5100BAF2EC0482A4906EFBBB7D95D99A1D8315D33DB" + var_0);

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_2, var_3);

    if(var_2 == "_encstr_8BF1150278AB37A36B663736F3B0A7F1FD20EBBBF02FAB")
      return var_3;
  }
}

_id_125FD() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773");
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_AD75063D571AE108", level, "_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
}

_id_125C1() {
  self setclientomnvar("_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2", 1);
  self setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 0);
  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B48D064CB8E8E33A");
  self beginlocationselection(0, 0, 0, 0, 4);
  thread _id_125FD();
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", "_encstr_91A21017B155D07573493840921FB5C8AD06");
  var_1 = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773") {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_0.location, 1)) {
      var_2 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13C34(var_0.location);
      var_3 = var_2["_encstr_BD260953AA97E3F014279D"];

      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_3, 1)) {
        thread _id_12CBD(var_3);
        var_1 = 1;
      } else
        addtop3brcharge(18);
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_B48D064CB8E8E33A");
  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 0);
  return var_1;
}

_id_12CBD(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_97801939ACE63A0BE4470D4B271B1BB215B15A5B2D9B0BA3D2DBB9");
  var_1 = 60;
  var_2 = 4;
  var_3 = -1;
  var_4 = 15;
  var_5 = getdvarint("_encstr_8F061950FA526F9913BFD15F8C97E6DF7C13583032A1413103A963", var_1);
  var_6 = getdvarint("_encstr_BA6B190328D5F9A36BB074713D518F3E0B588A6AB0372CDBC18558", var_2);
  var_7 = getdvarint("_encstr_970B196EB193EB134ED7C6C2E8CAFAD8D29CD81BB27DB1C6BD6E2B", var_3);
  var_8 = getdvarint("_encstr_9BFD1827CF3A016D8A17AD48C0DF77AF9A72AAA835B73CD6887B", var_4);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_97801939ACE63A0BE4470D4B271B1BB215B15A5B2D9B0BA3D2DBB9"))
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_97801939ACE63A0BE4470D4B271B1BB215B15A5B2D9B0BA3D2DBB9", var_0, var_5);

  foreach(var_10 in level.players)
  var_10 scripts\mp\hud_message::showsplash("_encstr_8A2814319CD78D2C3A95EB36A59C366356D7CDEDF69B");

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A78F076CA54E1B1B56")) {
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::teleport_players_inside_subway_car(var_0, var_5, var_6, var_7);
    level.disable_super_in_turret.lmg_guys["_encstr_A78F076CA54E1B1B56"] = undefined;
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  var_12 = max(0, var_5 - var_8);
  wait(var_12);

  foreach(var_10 in level.players)
  var_10 scripts\mp\hud_message::showsplash("_encstr_8CA113581B5F940BB3FA2957E3531B296A7928087B");

  var_15 = var_5 - var_12;
  wait(var_15);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9")) {
    level thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spectate_init();
    level.disable_super_in_turret.lmg_guys["_encstr_838F0D8DEFA26BC7D83780300FF4D9"] = undefined;
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }
}

_id_125C4() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_81351512099891B53044A89EC2083BB97F9C6F596C9F70"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_81351512099891B53044A89EC2083BB97F9C6F596C9F70");

  self setclientomnvar("_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2", 1);
  self setclientomnvar("_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747", 0);
  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B48D064CB8E8E33A");
  self beginlocationselection(0, 0, 0, 0, 4);
  thread _id_125FD();
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", "_encstr_91A21017B155D07573493840921FB5C8AD06");
  var_1 = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773") {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_0.location, 1)) {
      var_2 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13C34(var_0.location);
      var_3 = var_2["_encstr_BD260953AA97E3F014279D"];

      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_3, 1)) {
        self notify("_encstr_BE061A2944C3436B0DB1A72780BB2F7881D0AADF31635AA50ED0ABBB");
        _id_12647(var_3);
        var_1 = 1;
      } else
        addtop3brcharge(18);
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_B48D064CB8E8E33A");
  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 0);
  return var_1;
}

resetarenaomnvardata() {
  var_0 = 0;

  foreach(var_2 in level.br_armory_kiosk.scriptables) {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_2.origin))
      var_0++;
  }

  return var_0;
}

_id_12647(var_0, var_1, var_2) {
  var_3 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = 12000;
  var_5 = var_1;

  if(!isDefined(var_5))
    var_5 = var_4;

  var_6 = var_2;

  if(!isDefined(var_6))
    var_6 = 0;

  var_7 = spawnStruct();
  var_7.origin = var_0 + (0, 0, var_5);
  var_7.angles = (0, var_6, 0);
  var_7.height = var_5;
  var_8 = var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_7);
  var_3.forcespawnorigin = var_8;
  var_9 = 1.0;
  var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  wait(var_9);
  var_10 = var_7.origin;
  var_11 = var_7.angles;
  var_12 = var_10;

  if(isDefined(var_8))
    var_12 = var_8;

  var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_scriptable_states();
  var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126C3(var_12, var_11);
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12);
  var_13 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_13.angles = var_11;
  var_13 hide();
  var_13 showtoplayer(var_3);
  var_3 playerlinktoabsolute(var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 playerhide();
  var_3 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12524(var_13);
  waitframe();
  var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();

  if(isDefined(var_8))
    var_13.origin = var_10;

  var_13 playsoundtoplayer("_encstr_85E90F214B17D778126B31F7262DE02EF7", var_3);
  wait 1.5;
  var_3 unlink();
  var_3 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
  var_3 clearclienttriggeraudiozone(1);
  var_3 playershow();
  var_14 = 0;

  if(isDefined(level._id_121CC))
    var_14 = level._id_121CC;

  var_3.use_armor = 1;
  var_3 thread scripts\cp_mp\parachute::startfreefall(var_14, 0, undefined, undefined, 1);
  var_3 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_3 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12C7A();
  wait 0.5;
  var_3 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  waitframe();
  var_13 delete();
}

_encstr_950F1F9F4BBA79583FA752B10B87EBF367508C807398C859946017AA6B0840EB38(var_0, var_1, var_2) {
  if(isDefined(var_0))
    var_0 _encstr_A5951B01C305EB531811B351EB367F8BFA5BAB55C9FDFBCF5F859D2388(var_1, var_2);
  else
    _encstr_AC6A1A912B82812DEB4D97AA466FAB84D78B589B8190BF2EAFDBADD0(var_1, var_2);
}

_encstr_8E441F8D2CD81B312C36ADF5762B1DE61B9CD21C8E563291D2E6B1F657E61DB48C(var_0, var_1) {
  return var_0 _encstr_AB8F17B1A9F59B9248BD091899509F032BC38A3A73D8D34C08(var_1);
}

_encstr_91E31C4F43458B17D3871B7BD721A99B3F0E7FAB50C863C1D383D294FAA1() {
  return getdvarint("_encstr_BE341C90877AEEC5DB215DD086F21111EF0320300F0460DF12D54DE8DB9B", 0) > 0;
}

_encstr_AB9F1781AB6B916842FB755BF06B406DC3D25B49E2D7D8781A() {
  for(var_0 = 0; var_0 < 3; var_0++)
    _encstr_842617BE58381C36CBB98D934B388ECA32462DE66CED57731D(var_0);
}

_encstr_8AAE183B6A2385E98724EEEE1AD77361CFE29088E33E27A39B4C(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = _encstr_AA531A01DA50BC46986BABDBE3836271E03286386F50BCFCC1D930F3(var_2, var_0);
    var_1 = max(var_1, var_3);
  }

  return var_1;
}

_encstr_842617BE58381C36CBB98D934B388ECA32462DE66CED57731D(var_0) {
  var_1 = _encstr_AB8F17B1A9F59B9248BD091899509F032BC38A3A73D8D34C08(var_0);
  var_2 = 1 + var_0 * 5;
  var_3 = 5;
  _id_1260D("_encstr_950C1CB35B8965D8C78753BD0BBF47E263B00198633068499001197B28CB", var_1, var_2, var_3);
}

_encstr_A5951B01C305EB531811B351EB367F8BFA5BAB55C9FDFBCF5F859D2388(var_0, var_1) {
  if(!isDefined(self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B))
    self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B = [];

  self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0] = var_1;
}

_encstr_AC6A1A912B82812DEB4D97AA466FAB84D78B589B8190BF2EAFDBADD0(var_0, var_1) {
  if(!isDefined(level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B))
    level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B = [];

  level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0] = var_1;
}

_encstr_AB8F17B1A9F59B9248BD091899509F032BC38A3A73D8D34C08(var_0) {
  if(isDefined(self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B)) {
    if(isDefined(self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0]))
      return self._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0];
  }

  if(isDefined(level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B)) {
    if(isDefined(level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0]))
      return level.disable_super_in_turret._encstr_A68D14E6D8392DE08ECA8C194BCD6CB7BAE68E2D239B[var_0];
  }

  return -1;
}

_encstr_AA531A01DA50BC46986BABDBE3836271E03286386F50BCFCC1D930F3(var_0, var_1) {
  var_2 = _encstr_A11814BE4BB99B369C960E8EAC46C82DB936BDD59BE8(var_0, var_1);

  if(!var_2)
    return 0;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_81971477BD8347DEE5B0F3ABC811DF67DB16F7FD40EB"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_81971477BD8347DEE5B0F3ABC811DF67DB16F7FD40EB", var_0, var_1);

  return 0;
}

_encstr_A11814BE4BB99B369C960E8EAC46C82DB936BDD59BE8(var_0, var_1) {
  var_2 = _encstr_87130E28EF1F03438FFA30D062220319(var_1);
  var_3 = _encstr_AB8F17B1A9F59B9248BD091899509F032BC38A3A73D8D34C08(var_0);
  return var_2 == var_3 && var_2 != -1;
}

_encstr_87130E28EF1F03438FFA30D062220319(var_0) {
  var_1 = getDvar("_encstr_8BAA18629631F22D32DB8A5710995F987BFF870B28E51DCAAD4D", "_encstr_845A1880321F200E88E797B7F761D5E8EB8C89DB9FAB9A4E23F3");

  if(var_1 == "_encstr_B40101")
    var_1 = "_encstr_845A1880321F200E88E797B7F761D5E8EB8C89DB9FAB9A4E23F3";

  return int(_encstr_A64409BEEC1BEDED5BD538(var_1, 2, 0, var_0, -1));
}

_encstr_A64409BEEC1BEDED5BD538(var_0, var_1, var_2, var_3, var_4) {
  var_5 = tablelookupgetnumrows(var_0);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow(var_0, var_6, var_1);

    if(var_7 != scripts\engine\utility::string(var_3)) {
      continue;
    }
    var_8 = tablelookupbyrow(var_0, var_6, var_2);
    return var_8;
  }

  return var_4;
}

_id_1260D(var_0, var_1, var_2, var_3) {
  if(var_1 == -1)
    var_1 = (1 << var_3) - 1;

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7)
    self setclientomnvar(var_0, var_9);
}