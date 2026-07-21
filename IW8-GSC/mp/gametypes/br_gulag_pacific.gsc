/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gulag_pacific.gsc
***********************************************/

thermite_damage_over_time() {
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::_id_12F5A(::_id_12F64);
  waitframe();
  all_players_skip_last_stand();
  ally_initial_spawners();
  allownvgsatmatchstart();
  activenumber();
  thread _id_144CE();
  thread apc_rus_monitordriverturretfire();
}

all_players_skip_last_stand() {
  var_0 = [];
  var_0[var_0.size] = allow_nvgs("_encstr_B4B50C287AE7FF099F246DE806B6", "_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A2180537AC8E89", "_encstr_8EF30B8694205762B334B81B62");
  var_0[var_0.size] = allow_nvgs("_encstr_B2B50C70CAA4D9DE25EB0BED2B4A", "_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A2180537AC8E89", "_encstr_BEF30B5E2099514CF0B730034B");
  var_0[var_0.size] = allow_nvgs("_encstr_A6B50C3B9059E79A2BFDD30DE88F", "_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A2180537AC8E89", "_encstr_92F30B8991CEEBB14B3BA13A99");
  var_0[var_0.size] = allow_nvgs("_encstr_B1B50CE6CFA26F81BD1318C81394", "_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A2180537AC8E89", "_encstr_A3F30B2922FFF0380C3799A90C");
  var_0[var_0.size] = allow_nvgs("_encstr_BAB50C3D9C2F09DE3FA353382A16", "_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A2180537AC8E89", "_encstr_8FF30BB231CF791933F76354FF");
  var_0[var_0.size] = allow_nvgs("_encstr_95B50C038A6F292355EB414DC8C6", "_encstr_9B6D15DCB127EB37BB96D11BA1AF6CF53A164E76AC3ADC", undefined, undefined, undefined, 2.5);
  var_0[var_0.size] = allow_nvgs("_encstr_A2B50C4C8C3B7D9857A3D17B376E", "_encstr_AD821537364E7D9BBB2D47D8D0AF6E7D3AB093EC2B479B", undefined, undefined, undefined, 2.5);
  var_1 = [];
  var_1[var_1.size] = allow_offhand_throwback("_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_AB4226D187C759159B3F711F77F341D8991D7B893D2A78DC71537B0177FB25483FF22A61969C8885", 30);

  foreach(var_3 in var_0) {
    var_4 = getentitylessscriptablearrayinradius(var_3.name, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    foreach(var_6 in var_4) {
      var_6._id_13A7B = var_3._id_13A7B;

      if(isDefined(var_3.timer)) {
        var_7 = getentitylessscriptablearrayinradius(var_3.timer, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_6.position, 1200);

        if(isDefined(var_7))
          var_6.timer = var_7[0];
      }

      var_6.flightyaw = var_3.flightyaw;
      var_6.stack_patch_waittill_context = var_3.stack_patch_waittill_context;
      var_6._id_12029 = var_3._id_12029;

      if(isDefined(var_3.light)) {
        var_8 = getentitylessscriptablearrayinradius(var_3.light, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_6.position, 1200);

        if(isDefined(var_8))
          var_6.light = var_8[0];
      }
    }
  }

  foreach(var_12 in var_1) {
    var_4 = getentitylessscriptablearrayinradius(var_12.name, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    foreach(var_6 in var_4) {
      var_6._id_12C7E = var_12._id_12C7E;
      var_6.timeout = var_12.timeout;
      var_6.lights = [];
    }
  }
}

apc_rus_monitordriverturretfire() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_874C161AC0B13EFFB666352F8BF85785DBB80182980FB44B", var_0);
    var_1 = getdvarint("_encstr_B6D01837B14EF52BCDC658E0B2D7C9F6BAA395EBB1430B9B6C56", "_encstr_AC4C024A");

    if(randomint(100) < var_1)
      thread activeintelchallengekeys(var_0);
  }
}

recentghostridekillcount(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = var_0.origin;

  if(!isDefined(var_2))
    var_2 = 1200;

  var_3 = getentitylessscriptablearrayinradius("_encstr_87A522D71B534923C19FAE25F5EF6B0B3BC85373B889B4BABF25F59D66C7B2C54348B793", "_encstr_AC110A7F14873B5B3D073009", var_1, var_2);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6.timer) && var_6.timer == var_0)
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

processcashpileovertimemultiplier(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_0) && isDefined(var_0._id_13A7B) && isDefined(level.set_relic_martyrdom[var_0._id_13A7B])) {
    if(!isDefined(var_1))
      var_1 = var_0.origin;

    if(!isDefined(var_2))
      var_2 = 1200;

    var_4 = level.set_relic_martyrdom[var_0._id_13A7B];

    foreach(var_6 in var_4) {
      var_7 = getentitylessscriptablearrayinradius(var_6, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1, var_2);

      foreach(var_9 in var_7)
      var_3[var_3.size] = var_9;
    }
  }

  return var_3;
}

activeintelchallengekeys(var_0) {
  var_1 = var_0.origin;
  var_2 = getentitylessscriptablearrayinradius("_encstr_8FC60C3191CEF556E6C6467BED93", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1, 1200);

  if(isDefined(var_2.size) &var_2.size > 0)
    var_2 = var_2[0];
  else
    return;

  ammobox_tryuse(var_2, 1);
  var_3 = getentitylessscriptablearrayinradius("_encstr_A3101808D7D80C98CB515642CBF1E283F0DB5B3BA91BDBAFDB80", "_encstr_AC110A7F14873B5B3D073009", var_1, 1200);

  foreach(var_5 in var_3)
  var_5 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_930B07BB1B6B3854FF");

  var_7 = getentitylessscriptablearrayinradius("_encstr_AAF71772C138C1A3A55B1B3B4BD81A153069EFF19B489D8AFE", "_encstr_AC110A7F14873B5B3D073009", var_1, 1200);

  if(isDefined(var_7) && isDefined(var_7[0])) {
    var_7 = var_7[0];
    var_8 = recentghostridekillcount(var_7, var_1);

    foreach(var_10 in var_8)
    var_10.stack_patch_waittill_context = 0;

    if(var_7 getscriptablepartstate("_encstr_9A6C06E43B201F1A") != "_encstr_AB0703DBB9") {
      var_7 setscriptablepartstate("_encstr_9A6C06E43B201F1A", "_encstr_AB0703DBB9");
      wait(var_7.timeout);
      var_7 setscriptablepartstate("_encstr_9A6C06E43B201F1A", "_encstr_BA19049F4B2D");
      ammobox_canweaponacceptmoreattachments(var_7);

      foreach(var_5 in var_3)
      var_5 setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_8882099673858D1D4B6756");

      foreach(var_10 in var_8)
      var_10.stack_patch_waittill_context = 1;
    }
  }
}

allow_nvgs(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.name = var_0;
  var_6._id_13A7B = var_1;
  var_6.timer = var_2;
  var_6.flightyaw = var_3;
  var_6.light = var_4;
  var_6.stack_patch_waittill_context = 0;
  var_6._id_12029 = var_5;
  return var_6;
}

allow_offhand_throwback(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3._id_12C7E = var_1;
  var_3.timeout = var_2;
  return var_3;
}

ally_initial_spawners() {
  var_0 = getentitylessscriptablearrayinradius("_encstr_AAF71772C138C1A3A55B1B3B4BD81A153069EFF19B489D8AFE", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0) {
    var_3 = getentitylessscriptablearrayinradius("_encstr_87A522D71B534923C19FAE25F5EF6B0B3BC85373B889B4BABF25F59D66C7B2C54348B793", "_encstr_AC110A7F14873B5B3D073009", var_2.position, 1200);
    var_4 = [];

    foreach(var_6 in var_3) {
      var_7 = var_6.flightyaw;

      if(!isDefined(var_7)) {
        continue;
      }
      if(!isDefined(var_4[var_7]))
        var_4[var_7] = [];

      var_4[var_7][var_4[var_7].size] = var_6;
    }

    foreach(var_10 in var_4) {
      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        var_10[var_11].enabled = 0;
        var_10[var_11].stack_patch_waittill_context = 1;
      }

      var_12 = randomintrange(0, var_10.size);
      var_10[var_12].enabled = 1;
    }
  }
}

activenumber() {
  var_0 = getentitylessscriptablearrayinradius("_encstr_A5B20BCED9680F0BF39BAFFB4B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0)
  ammobox_canweaponacceptmoreattachments(var_2);
}

allassassin_initteamlist(var_0) {
  if(isDefined(var_0._id_1202A) && var_0._id_1202A == 1)
    return 1;

  return 0;
}

analytics_init(var_0, var_1) {
  if(allassassin_initteamlist(var_0)) {
    return;
  }
  var_0._id_1202A = 1;
  wait(var_1);
  ammobox_tryuse(var_0, 0);
  var_0._id_1202A = 0;
}

ammobox_canweaponacceptmoreattachments(var_0) {
  level.set_relic_mythic = [];

  if(!isDefined(var_0._id_12C7E)) {
    return;
  }
  var_1 = strtok(var_0._id_12C7E, "_encstr_964C0249");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = strtok(var_4, "_encstr_AB4C0246");

    if(var_5[1] == "_encstr_AAEF05B83B43EB") {
      var_2[var_2.size] = [var_5[0], 1];
      continue;
    }

    var_2[var_2.size] = [var_5[0], 0];
  }

  foreach(var_4 in var_2) {
    var_8 = var_4[0];
    var_9 = var_4[1];

    if(isDefined(var_0))
      var_1 = getentitylessscriptablearrayinradius(var_8, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_0.position, 1200);
    else
      var_1 = getentitylessscriptablearrayinradius(var_8, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    foreach(var_11 in var_1) {
      var_12 = aigroundturret_dismountcompleted(var_11);

      if(var_12 != var_9)
        ammobox_tryuse(var_11, var_9);
    }
  }
}

allownvgsatmatchstart() {
  var_0 = getDvar("_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943", "_encstr_8CE90E8991CEEB9C2B46B238327BF64E");
  var_1 = strtok(var_0, "_encstr_964C0249");
  level.set_relic_martyrdom["_encstr_A514156A065D49B32B800357A006C9F1F9AFB2E7FD8943"] = var_1;
  var_2 = getDvar("_encstr_A67115DEBE43DF332FF7E8589B6F63A74BA6D66C97FB4F", "_encstr_ACAB06E147B05B31");
  var_1 = strtok(var_2, "_encstr_964C0249");
  level.set_relic_martyrdom["_encstr_A67115DEBE43DF332FF7E8589B6F63A74BA6D66C97FB4F"] = var_1;
  var_3 = getDvar("_encstr_B62015731890304F3FB073367CD0C30FCCB6C6C71B88B6", "_encstr_93FD0C6A50F7BAEA98257F67C693");
  var_1 = strtok(var_3, "_encstr_964C0249");
  level.set_relic_martyrdom["_encstr_B62015731890304F3FB073367CD0C30FCCB6C6C71B88B6"] = var_1;
  var_4 = getDvar("_encstr_9B6D15DCB127EB37BB96D11BA1AF6CF53A164E76AC3ADC", "_encstr_96901431919DFAD959CD1D4C169891CEEB9D56DC3A19");
  var_1 = strtok(var_4, "_encstr_964C0249");
  level.set_relic_martyrdom["_encstr_9B6D15DCB127EB37BB96D11BA1AF6CF53A164E76AC3ADC"] = var_1;
  var_5 = getDvar("_encstr_AD821537364E7D9BBB2D47D8D0AF6E7D3AB093EC2B479B", "_encstr_96901431919DFAD959CD1D4C169891CEEB9D56DC3A19");
  var_1 = strtok(var_5, "_encstr_964C0249");
  level.set_relic_martyrdom["_encstr_AD821537364E7D9BBB2D47D8D0AF6E7D3AB093EC2B479B"] = var_1;
}

aigroundturret_dismountcompleted(var_0) {
  var_1 = var_0.set_relic_mythic;

  if(!isDefined(var_1)) {
    if(var_0 scriptableisdoor())
      var_1 = !var_0 scriptabledoorisclosed();
    else {
      var_2 = var_0 getscriptablepartstate("_encstr_83F10B83ADFD63774390AFC720");

      if(isDefined(var_2))
        var_1 = var_2 == "_encstr_930B07BB1B6B3854FF";
    }
  }

  return var_1;
}

ammobox_tryuse(var_0, var_1) {
  var_0.set_relic_mythic = var_1;

  if(var_0 scriptableisdoor()) {
    if(var_1)
      var_0 constraintoscriptgoalRadius();
    else
      var_0 vehicle_getinputvalue();
  } else {
    var_2 = var_0 getscriptablepartstate("_encstr_83F10B83ADFD63774390AFC720");

    if(isDefined(var_2)) {
      if(var_1)
        var_0 setscriptablepartstate("_encstr_83F10B83ADFD63774390AFC720", "_encstr_930B07BB1B6B3854FF");
      else
        var_0 setscriptablepartstate("_encstr_83F10B83ADFD63774390AFC720", "_encstr_A7C5056BD931D1");
    }
  }
}

any_player_in_laststand(var_0) {
  var_1 = aigroundturret_dismountcompleted(var_0);

  if(isDefined(var_1))
    ammobox_tryuse(var_0, !var_1);
}

_id_12F64(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2.classname == "_encstr_87A522D71B534923C19FAE25F5EF6B0B3BC85373B889B4BABF25F59D66C7B2C54348B793")
    scriptable_used(var_2, "_encstr_A65C075AD0916BCFA0", "_encstr_8E8607AB603B6E4341", var_1, 0);
}

scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.classname == "_encstr_87A522D71B534923C19FAE25F5EF6B0B3BC85373B889B4BABF25F59D66C7B2C54348B793") {
    if(var_0.stack_patch_waittill_context == 1) {
      return;
    }
    if(isDefined(var_0.enabled) && var_0.enabled == 0) {
      if(isDefined(var_0.light) && var_0.light getscriptablepartstate("_encstr_8FA906CC80677438") != "_encstr_AFAD09350190C9E32B7507")
        var_0.light setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_AFAD09350190C9E32B7507");

      return;
    }

    var_5 = processcashpileovertimemultiplier(var_0);

    foreach(var_7 in var_5) {
      var_2 = aigroundturret_dismountcompleted(var_7);

      if(!allassassin_initteamlist(var_7)) {
        ammobox_tryuse(var_7, !var_2);

        if(isDefined(var_0._id_12029))
          thread analytics_init(var_7, var_0._id_12029);
      }
    }

    if(var_5.size > 0) {
      var_0 setscriptablepartstate(var_1, "_encstr_88F605735BEF40");

      if(isDefined(var_0.light) && var_0.light getscriptablepartstate("_encstr_8FA906CC80677438") != "_encstr_AC260979F74AD8B52FE3D1")
        var_0.light setscriptablepartstate("_encstr_8FA906CC80677438", "_encstr_AC260979F74AD8B52FE3D1");
    }
  }
}

_id_144CE() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = scripts\engine\utility::getent_or_struct("_encstr_A63F0F712727B9F57BDFB185CF02CCA0EA", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_0)) {
      var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

      if(var_1 == level.player)
        var_1 _id_12AB1();

      waitframe();
    }

    wait 0.05;
  }
}

_id_12AB1() {
  if(!isDefined(self.arena)) {
    var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergetnextarena();
    self.arena = var_0;
  }

  if(isalive(self) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12642(self, "_encstr_8E75065022EE9391");
}