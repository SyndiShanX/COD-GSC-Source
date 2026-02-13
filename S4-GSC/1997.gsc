/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1997.gsc
*************************************************/

_id_555E() {
  level._id_FE98 = [];
  _id_07A1::_id_CECC("hack_usable", ::_id_5589);
  thread _id_0DB1();
}

_id_5589(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_558B(var_0._id_019B, var_3);
}

_id_558B(var_0, var_1) {
  var_2 = var_0;
  var_2._id_877F = 1;

  if(isDefined(var_1)) {
    var_1._id_87A4 = 0;
    var_1._id_888B = 1;
    var_1 thread _id_0BB9(var_2, 0);
  }
}

_id_0DB1() {
  level endon("game_ended");

  for(;;) {
    wait 0.2;

    foreach(var_1 in level._id_FE98) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = scripts\common\utility::_id_B7C7(var_1.origin, 300);

      foreach(var_4 in var_2) {
        if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_4, var_1.owner) || getdvarint("#x350f321a89fac78f0", 0) == 1) || isDefined(var_1._id_888A) && var_1._id_888A || istrue(var_1._id_877F) || !var_4 scripts\mp\utility\perk::_hasperk("specialty_hack") || var_4 _id_078D::_id_85B3() || level.gameended || isDefined(var_1.owner) && var_1.owner scripts\mp\utility\perk::_hasperk("specialty_armory")) {
          var_1 _meth_86A8(var_4);
          continue;
        }

        var_1 _meth_86A7(var_4);
      }
    }
  }
}

_id_C33E(var_0, var_1, var_2) {
  if(isDefined(var_2) || var_2) {
    thread _id_0C18(var_0);
  }
}

_id_0C18(var_0) {
  level._id_FE98[self getentitynumber()] = self;
  self setscriptablepartstate("hack_usable", "on");

  foreach(var_2 in level.players) {
    self _meth_86A8(var_2);
  }
}

_id_0CA2(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("mine_triggered");
  self endon("death_or_disconnect");
  self endon("emp_started");
  var_1 = getdvarfloat("#x3de686ca19936f7e1", 0.1) * 1000;
  var_2 = gettime() + var_1;

  while(var_2 > gettime()) {
    if(!self usebuttonpressed()) {
      return 0;
    }

    waitframe();
  }

  return 1;
}

_id_0D87(var_0, var_1) {
  var_0._id_877F = 1;
  self._id_87A4 = 1;
  self._id_888B = 1;
  var_1._id_83B2 = 0;
  self notify("interact_started");
  var_2 = istrue(_id_0CA2(var_0));

  if(var_2) {
    var_1._id_83B2 = 2;
    self playsoundtoplayer("ui_frontend_unselect_killstreak", self);
    var_3 = scripts\mp\supers::getcurrentsuper();

    if(var_3._id_E76B._id_C189 == "super_hijack") {
      self._id_793D = 1;
      var_4 = spawnStruct();
      var_4.basename = "s4_super_default_mp";
      self notify("special_weapon_fired", var_4);
    }
  } else
    self notify("interact_cancelled");

  self notify("interact_finished");

  if(isDefined(var_0)) {
    var_0._id_877F = 0;
  }

  if(isDefined(self)) {
    self._id_87A4 = 0;
    self._id_888B = undefined;

    if(!istrue(var_2)) {
      return;
    }
    if(isDefined(var_0)) {
      var_0 scripts\mp\equipment::_id_735E(self);
    }
  }
}

_id_0BB9(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = makeweapon("ks_remote_hack_mp");
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_4056("", self);
  var_3._id_83B2 = var_1;
  thread _id_0DA9(var_0, var_1);
  var_4 = 1;

  if(istrue(var_4) && isDefined(var_0)) {
    thread _id_0D87(var_0, var_3);
  } else {
    self notify("interact_cancelled");

    if(isDefined(var_0)) {
      var_0._id_877F = 0;
    }
  }
}

_id_0DA9(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = -1;

  if(isDefined(var_0._id_5562)) {
    var_3 = tolower(var_0._id_5562);
    var_2 = scripts\mp\equipment::_id_6A17(var_3)._id_7C8C;
  } else if(isDefined(var_0.streakinfo)) {
    var_2 = scripts\mp\utility\killstreak::_id_6AE3(var_0.streakinfo.streakname);
    var_2 = var_2 + 100;
  }

  _id_0DAA(var_0);

  if(var_1 == 2) {
    self setclientomnvar("ui_hack_progress", 1);
  } else {
    self setclientomnvar("ui_hack_progress", 0);
  }
}

_id_0DAA(var_0) {
  self endon("interact_cancelled");
  self waittill("interact_started");
}

_id_0C85(var_0, var_1) {
  _id_0D98(1);
  thread _id_0B9B();
  thread _id_0B92(var_0);
  return 1;
}

_id_0B92(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 endon("deploy_weapon_switch_ended");

  for(;;) {
    if(!self usebuttonpressed()) {
      break;
    }

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");
}

_id_0C87(var_0) {
  self notify("tabletPutAway");
}

_id_0DC9(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(var_0._id_83B2 != 0) {
    return;
  }
  self waittill("interact_finished");
}

_id_0B9B() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "tabletPutAway");
  _id_0D98(0);
}

_id_0D98(var_0) {
  scripts\mp\utility\player::_id_0BEE(var_0);

  if(isalive(self)) {
    scripts\common\utility::_id_1559(!var_0);
    scripts\common\utility::_id_154E(!var_0);
    scripts\common\utility::_id_158A(!var_0);
    scripts\common\utility::_id_1554(!var_0);
    scripts\common\utility::_id_1562(!var_0);
  }
}