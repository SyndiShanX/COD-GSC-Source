/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\advanced_supply_drop.gsc
*************************************************/

advanced_supply_drop_marker_used(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_1 thread vfx_htown_hadirj_blink(var_0);
  var_1 thread binoculars_onstatelospendingexit(var_0);
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  var_1 notify("_encstr_A10A1E9A01B4170D806BCCEF5F68D21BD1DAF1526B808B89405BCED137A85FB3");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  var_3 = _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::relic_punchbullets_fire_fists(0, 1, 0, 0, 0);
  var_1 _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_1363A(var_2, var_3);

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

vfx_htown_hadirj_blink(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  wait 10;

  if(isDefined(var_0))
    var_0 delete();

  var_1 notify("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
}

binoculars_onstatelospendingupdate(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_1 thread vfx_htown_hadirj_blink(var_0);
  var_1 thread binoculars_onstatelospendingexit(var_0);

  if(isDefined(level._id_13ACD))
    level thread _id_13AA0(var_1, var_0);

  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  var_1 notify("_encstr_A10A1E9A01B4170D806BCCEF5F68D21BD1DAF1526B808B89405BCED137A85FB3");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::sphere_trace(var_2 + (0, 0, 10000), var_2 - (0, 0, 20000), 256, undefined, var_4, 0);
  var_6 = getdvarint("_encstr_ADD1231B70F00F88D593C99F7F271339ED29B15D90482519AE59B7784F2960AEB31F0D0B20", 512);

  if(distancesquared(var_2, var_5["_encstr_BD260953AA97E3F014279D"]) > var_6 * var_6) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  if(isDefined(level._id_13ACE) && isDefined(level._id_13ACE[var_1.team])) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  var_7 = (var_2[0], var_2[1], var_5["_encstr_BD260953AA97E3F014279D"][2]);
  var_3.origin = var_7 + (0, 0, 50000);
  var_8 = _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_14263(var_3);

  if(isDefined(var_8)) {
    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_85EE090C9DD0A62F3CA1B3")
      _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::thrownoffhand(var_8, var_1.team, 1);

    level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DE4(var_8, var_7, var_8.angles, 1);
  }

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

_id_13AA0(var_0, var_1) {
  var_2 = var_0.team;
  level._id_13ACD[var_2] = 1;
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_8D820B49520F0EC02DDE6367EC", var_1, "_encstr_91A50C1BA8D2A87053EA5E01420B", var_1, "_encstr_860808CB78E2984063BA", var_1, "_encstr_AD75063D571AE108");
  level._id_13ACD[var_2] = undefined;
}

binoculars_onstatelospendingexit(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_A10A1E9A01B4170D806BCCEF5F68D21BD1DAF1526B808B89405BCED137A85FB3");
  var_0 waittill("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(1);
}

binoculars_onstatelospendingenter(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1 playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 21;
  var_1 playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  var_1 stoploopsound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 5;
  var_1 delete();
}

binoculars_onstateinvalidupdate(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_1 thread vfx_htown_hadirj_blink(var_0);
  var_1 thread binoculars_onstatelospendingexit(var_0);
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  var_1 notify("_encstr_A10A1E9A01B4170D806BCCEF5F68D21BD1DAF1526B808B89405BCED137A85FB3");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  var_3 = 4096;
  var_4 = scripts\engine\utility::getStruct("_encstr_8D5A1B37ED58AF8EB7775993AFAC8DCA9D85A3ED93F53363F6F6E4FA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(istrue(self.umbra) || isDefined(var_4) && distance2d(var_2, var_4.origin) < 5000)
    var_3 = 10000;

  var_5 = var_2 + (0, 0, var_3);
  var_6 = var_2 + (0, 0, 512);
  var_7 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, self.team, "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC", var_5, (0, randomfloat(360), 0), var_6);

  if(isDefined(var_7))
    var_7 thread shutdowngulagforalivecount(self);

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

shutdowngulagforalivecount(var_0) {
  self setotherent(var_0);
  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A2310D6127A28C709F1B61F9C28780");
}