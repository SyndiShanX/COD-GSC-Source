/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_money.gsc
******************************************************/

init() {
  common_scripts\utility::_id_092C("pickup_share_money", "vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_money_gj");
  var_0 = [];
  var_0["func"] = ::_id_8ADC;
  var_0["fx"] = "pickup_share_money";
  var_0["onDestroyed"] = ::_id_8ADB;
  var_0["canBeDroppedByZombies"] = maps\mp\gametypes\zombies::_id_6FC7;
  level._id_6FBF["share_money"] = var_0;
  level._id_8AD2 = [];
  level._id_349D = [];
  level thread maps\mp\_utility::_id_6F74(::_id_A90B);
}

_id_8ADC(var_0) {
  var_1 = _id_4680();
  _id_0555::issprinting("take_share", var_0);
  _id_0378::_id_8D74("zmb_points_pickup", var_1.origin);
  var_0 _id_47BB(var_1._id_62D3);
  var_1 _id_8ADE(0);
  level thread maps\mp\gametypes\zombies::_id_7CED(self);
}

_id_8ADB() {
  var_0 = _id_4680();
  var_0 _id_8ADE();

  if(_id_A235()) {
    level thread _id_7CE3(var_0._id_4F6B);
    var_0._id_4F6B = undefined;
  }

  level._id_8AD2 = common_scripts\utility::_id_0F93(level._id_8AD2, var_0);
}

_id_8ADF(var_0, var_1, var_2) {
  var_3 = maps\mp\gametypes\zombies::_id_281C("share_money", var_0, var_1);

  if(_id_A235()) {
    var_4 = newhudelem();
    var_4 setshader("hud_share_money");
    var_4.alpha = 0;
    var_4 fadeovertime(0.3);
    var_4.alpha = 0.9;
    var_4.color = (0.654902, 0.635294, 0.564706);
    var_4.x = var_0[0];
    var_4.y = var_0[1];
    var_4._id_01D9 = var_0[2] + _id_4515();
    var_5 = 1;
    var_6 = 1;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = undefined;
    var_11 = 0;
    var_4 setwaypoint(var_5, var_6, var_7, var_8, var_9, var_10, var_10, var_11, var_10, var_10);
    var_3._id_4F6B = var_4;
  }

  var_3._id_62D1 = 0;
  var_3._id_8AD3 = [];
  var_3._id_62D3 = 0;
  var_3._id_0117 = var_2;
  level._id_8AD2 = common_scripts\utility::_id_0F6F(level._id_8AD2, var_3);
  level notify("spawned_money_share");
  return var_3;
}

_id_8AD9(var_0) {
  var_1 = _id_4680();
  var_1._id_62D1 = var_1._id_62D1 + var_0;
  var_1._id_62D3 = var_1._id_62D3 + var_0;
}

_id_8ADA(var_0, var_1) {
  var_2 = _id_4680();
  var_3 = var_2._id_8AD3[var_0 getentitynumber()];

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
    var_3._id_0DBD = 0;
    var_2._id_8AD3[var_0 getentitynumber()] = var_3;
  }

  var_3._id_0DBD = var_3._id_0DBD + var_1;
  var_3._id_8AD8 = gettime();
  var_2._id_62D3 = var_2._id_62D3 + var_1;

  if(!common_scripts\utility::_id_0F79(var_0._id_8AD2, var_2)) {
    var_0._id_8AD2 = common_scripts\utility::_id_0F6F(var_0._id_8AD2, var_2);
  }

  level._id_349D[var_0 getguid()] = level._id_349D[var_0 getguid()] + var_1;
}

_id_467F(var_0) {
  if(!isDefined(level._id_349D)) {
    return 0;
  }

  var_1 = level._id_349D[var_0 getguid()];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

getsharedmoneypickupsbyplayer(var_0) {
  if(!isDefined(var_0._id_8AD2)) {
    return [];
  }

  return var_0._id_8AD2;
}

getsharedmoneyinpickupbyplayer(var_0) {
  var_1 = _id_4680();

  if(!isDefined(var_1) || !isDefined(var_1._id_8AD3)) {
    return 0;
  }

  var_2 = var_1._id_8AD3[var_0 getentitynumber()];

  if(!isDefined(var_2)) {
    return 0;
  }

  return var_2._id_0DBD;
}

_id_2698() {
  if(!isDefined(level._id_349D)) {
    return 0;
  }

  var_0 = 0;

  foreach(var_2 in level._id_349D) {
    if(var_2 > 0) {
      var_0++;
    }
  }

  return var_0;
}

_id_A90C() {
  var_0 = self;
  var_1 = var_0 getentitynumber();
  var_0 waittill("disconnect");

  foreach(var_3 in var_0._id_8AD2) {
    var_3 _id_8ADD(var_1, 0);

    if(var_3._id_62D3 <= 0) {
      level thread maps\mp\gametypes\zombies::_id_7CED(var_3);
    }
  }
}

_id_A90B() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = "drop_money_notify";
  var_2 = 0.1;
  var_0 notifyonplayercommand(var_1, "+actionslot 3");
  var_0._id_8AD2 = [];
  var_0 thread _id_A90C();

  if(!isDefined(level._id_349D[var_0 getguid()])) {
    level._id_349D[var_0 getguid()] = 0;
  }

  for(;;) {
    wait(var_2);
    var_0 waittill(var_1);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!var_0 _meth_8648()) {
      continue;
    }
    if(isDefined(var_0.on_aa_gun) && var_0.on_aa_gun == 1) {
      continue;
    }
    var_3 = _id_467D();

    if(!var_0 maps\mp\gametypes\zombies::_id_11C2(var_3, 1, 1)) {
      var_0 playsoundtoplayer("zmb_ui_purchase_fail", var_0);
      _id_0555::issprinting("poor_share", var_0);
      continue;
    }

    var_4 = _id_4681(var_0);
    var_5 = common_scripts\utility::_id_4461(var_4, level._id_8AD2, _id_467A());
    _id_0555::issprinting("share", var_0);
    _id_0378::_id_8D74("zmb_points_share", var_0.origin);

    if(!isDefined(var_5)) {
      var_9 = "player share_money on notify " + var_1;
      var_5 = _id_8ADF(var_4, var_9, var_0);
    }

    var_0 thread _id_054E::_id_745A("give_money");
    var_5 _id_8ADA(var_0, var_3);

    if(var_0._id_8AD2.size >= _id_4606()) {
      var_10 = undefined;

      foreach(var_12 in var_0._id_8AD2) {
        if(!isDefined(var_10) || var_12._id_8AD3[var_0 getentitynumber()]._id_8AD8 < var_10._id_8AD3[var_0 getentitynumber()]._id_8AD8) {
          var_10 = var_12;
        }
      }

      var_10 _id_8ADD(var_0 getentitynumber());

      if(var_10._id_62D3 <= 0) {
        level thread maps\mp\gametypes\zombies::_id_7CED(var_10);
      }
    }

    var_0 notify("money_share_success");
  }
}

_id_4680() {
  var_0 = self;
  return var_0;
}

_id_8ADE(var_0) {
  var_1 = _id_4680();

  foreach(var_3 in getarraykeys(var_1._id_8AD3)) {
    _id_8ADD(var_3, var_0);
  }
}

_id_47BB(var_0) {
  var_1 = self;
  var_2 = 1;
  var_1 maps\mp\gametypes\zombies::_id_4798(var_0, var_2);
}

_id_4681(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_1 = common_scripts\utility::_id_3D5D(var_1);
  var_1 = vectorNormalize(var_1);
  var_2 = var_0.origin + var_1 * _id_467E() + (0, 0, 30);
  var_3 = _func_2E1(var_2, var_0);
  return var_3;
}

_id_8ADD(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = _id_7B92();
  }

  var_2 = _id_4680();
  var_3 = var_2._id_8AD3[var_0]._id_0DBD;
  var_4 = maps\mp\gametypes\_playerlogic::_id_4622(var_0);

  if(isDefined(var_4)) {
    if(var_1) {
      var_4 _id_47BB(var_3);
    }

    var_4._id_8AD2 = common_scripts\utility::_id_0F93(var_4._id_8AD2, var_2);
  }

  var_2._id_62D3 = var_2._id_62D3 - var_3;
  var_2._id_8AD3[var_0] = undefined;
}

sharemoneyremoveamountbyplayer(var_0, var_1) {
  var_2 = _id_4680();
  var_3 = var_0 getentitynumber();
  var_4 = var_2._id_8AD3[var_3]._id_0DBD;

  if(var_1 > var_4) {
    return 0;
  }

  var_2._id_62D3 = var_2._id_62D3 - var_1;

  if(var_1 == var_4) {
    var_0._id_8AD2 = common_scripts\utility::_id_0F93(var_0._id_8AD2, var_2);
    var_2._id_8AD3[var_3] = undefined;

    if(var_2._id_62D3 <= 0) {
      level thread maps\mp\gametypes\zombies::_id_7CED(var_2);
    }
  }

  return 1;
}

_id_7CE3(var_0) {
  var_0 fadeovertime(0.3);
  var_0.alpha = 0;
  wait 0.3;
  var_0 destroy();
}

_id_467E() {
  return 60;
}

_id_467D() {
  return 250;
}

_id_467A() {
  return 30;
}

_id_4606() {
  return 5;
}

_id_7B92() {
  return 1;
}

_id_A235() {
  return 1;
}

_id_4515() {
  return -8;
}