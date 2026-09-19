/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1406.gsc
**************************************/

_id_51CF() {
  var_0 = spawnStruct();
  var_0._id_6F9A = (0, 0, 0);
  var_0._id_6F9C = 500;
  var_0._id_6F9B = 360;
  common_scripts\utility::_id_092C("vision_beam", "vfx/lights/mp_zombie_nest/zmb_sentry_vision_light");
  level._id_6FBF["Fireman Head"]["func"] = ::_id_3C09;
  level._id_6FBF["Fireman Head"]["model"] = "npc_zom_fireman_head";
  level._id_6FBF["Fireman Head"]["canBeDroppedByZombies"] = maps\mp\gametypes\zombies::_id_6FC7;
  level._id_6FBF["Fireman Head"]["phys_overrides"] = var_0;
  level._id_6FBF["Fireman Head"]["posOffset"] = (0, 0, 0);
  level._id_6FBF["Fireman Head"]["extraTimeoutSecs"] = 180;
  level._id_6FBF["Fireman Head"]["outline"] = 1;

  if(!isDefined(level._id_4BDF))
    level._id_4BDF = [];

  level thread maps\mp\_utility::_id_6F74(::_id_AC25);
}

_id_AC25(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 childthread _id_6312();
}

_id_314D(var_0) {
  var_1 = var_0 getweaponlistall();
  return common_scripts\utility::_id_0F79(var_1, "sentryhead_zm");
}

_id_6312() {
  var_0 = self;
  var_0._id_5605 = 0;
  var_1 = 0.2;
  var_2 = int(20 * var_1);
  var_3 = (0, 1, 0);

  for(;;) {
    wait(var_1);
    var_4 = var_0 _meth_8345() > 0.3 && var_0 getcurrentweapon() == "sentryhead_zm";

    if(var_0._id_5605 != var_4) {
      var_0._id_5605 = var_4;

      if(var_4) {
        var_5 = common_scripts\utility::_id_44F5("vision_beam");
        var_6 = _func_2A8(var_5, var_0, "tag_fx", 1);
        _func_14C(var_6);
        var_0._id_3BF4 = var_6;
      } else {
        var_0._id_3BF4 delete();
        var_0._id_3BF4 = undefined;
      }
    }

    if(!var_4) {
      continue;
    }
    foreach(var_10 in level._id_4BDF) {
      if(!var_0 _id_5626(var_10)) {
        continue;
      }
      level thread[[var_10._id_7E39]](var_10, var_0);
      _id_7CC2(var_10);
    }
  }
}

_id_437B(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0._id_218D))
    var_1 = var_0._id_218D;

  return var_1;
}

_id_5626(var_0) {
  var_1 = self;
  var_2 = _id_437B(var_0);
  var_3 = var_1 getEye();

  if(distancesquared(var_3, var_2) > _func_0DA(300))
    return 0;

  var_4 = var_2 - var_3;
  var_5 = length(var_4);

  if(var_5 < 1)
    return 1;

  var_6 = var_4 / var_5;
  var_7 = anglesToForward(var_1 getplayerangles());
  var_8 = _func_0AA(vectordot(var_7, var_6));

  if(var_8 > 30)
    return 0;

  if(!common_scripts\utility::_id_562E(var_0._id_8C80) && !_func_07F(var_3, var_2, 0, var_0))
    return 0;

  return 1;
}

_id_0984(var_0, var_1, var_2) {
  var_3 = var_0.origin;

  if(isDefined(var_1))
    var_3 = var_1.origin;

  var_0._id_218D = var_3;
  var_0._id_7E39 = var_2;

  if(!isDefined(level._id_4BDF))
    level._id_4BDF = [];

  level._id_4BDF = common_scripts\utility::_id_0F6F(level._id_4BDF, var_0);
}

_id_7CC2(var_0) {
  level._id_4BDF = common_scripts\utility::_id_0F93(level._id_4BDF, var_0);
}

_id_3C09(var_0) {
  var_1 = self;

  if(common_scripts\utility::_id_562E(var_1._id_558F) || _id_314D(var_0) || var_0 _id_0586::_id_72C3()) {
    return;
  }
  var_1._id_558F = 1;
  var_0 _id_0586::_id_078C("sentryhead_zm");
  var_0 _id_0586::_id_078E("sentryhead_zm");
  level thread maps\mp\gametypes\zombies::_id_7CED(var_1);
}

_id_418D() {
  return "sentryhead_zm";
}

_id_4758() {
  _id_0586::_id_078C("sentryhead_zm");
  _id_0586::_id_078E("sentryhead_zm");
  maps\mp\_utility::giveperk("specialty_ballcarrier");
  self _meth_8112(1);
  self _meth_8113(0);
  self _meth_8114(0);
  thread _id_6360();
}

_id_95CB() {
  if(self getcurrentweapon() == "sentryhead_zm") {
    var_0 = self._id_5B98;

    if(!isDefined(var_0) || var_0 == "none") {
      var_1 = self getweaponlistprimaries();

      foreach(var_3 in var_1) {
        if(_id_0547::_id_5836(var_3)) {
          var_0 = var_3;
          break;
        }
      }
    }

    _id_0586::_id_078E(var_0);
  }

  _id_0586::_id_0790("sentryhead_zm");
  maps\mp\_utility::_id_0735("specialty_ballcarrier");
  self _meth_8112(1);
  self _meth_8113(1);
  self _meth_8114(1);
  level thread _id_8FA7(self.origin + (0, 0, 10), "respawning on drop");
}

_id_6360() {
  for(;;) {
    common_scripts\utility::_id_A70A("weapon_change", "begin_last_stand");

    if(self getcurrentweapon() == "sentryhead_zm") {
      continue;
    }
    if(_id_314D(self))
      _id_95CB();
  }
}

_id_8FA7(var_0, var_1) {
  if(!isDefined(level._id_3C0A)) {
    level._id_3C0A = [];
    level thread _id_633A();
  }

  var_2 = undefined;

  if(level._id_3C0A.size == 4) {
    var_3 = 0;

    for(var_3 = 0; var_3 < 4; var_3++) {
      if(common_scripts\utility::_id_562E(level._id_3C0A[var_3]._id_558F)) {
        break;
      }
    }

    if(var_3 == 4)
      var_3 = 0;

    var_2 = level._id_3C0A[var_3];
    level._id_3C0A = common_scripts\utility::_id_0F9A(level._id_3C0A, var_3);
    level._id_3C0A[level._id_3C0A.size] = var_2;
  } else {
    var_2 = spawn("script_model", var_0);
    var_2 setModel("npc_zom_fireman_head");
    level._id_3C0A[level._id_3C0A.size] = var_2;
  }

  var_4 = (0, 0, 500);
  var_5 = 2000;
  var_6 = 0.1;
  var_7 = (0, 0, 5);
  var_2 _meth_808C();
  var_2.origin = var_0;
  var_2 makeusable();
  var_2 _meth_805B();
  var_2 _meth_80CE(&"ZOMBIE_NEST_PICKUP_HEAD");
  var_2 _meth_8272(var_2.origin + var_7, var_4, var_5, var_6);
  var_2._id_558F = 0;
  var_2 notify("recycle_fireman_head");
  var_2 endon("recycle_fireman_head");

  for(;;) {
    var_2 waittill("trigger", var_8);

    if(_id_314D(var_8) || var_8 _id_0586::_id_72C3()) {
      wait 0.25;
      continue;
    }

    break;
  }

  var_8 _id_4758();
  var_2._id_558F = 1;
  var_2 _meth_84E0();
  var_2 _meth_80B3();
  var_2 _meth_83FF();
  var_2 _meth_80CE(&"ZOMBIES_EMPTY_STRING");
  var_2 _meth_805B();
  var_2 _meth_8511();
}

_id_633A() {
  for(;;) {
    level waittill("on togglescore");
    var_0 = _id_0557::_id_42B9();

    foreach(var_2 in level._id_3C0A) {
      if(!common_scripts\utility::_id_562E(var_2._id_558F)) {
        if(var_0.size == 0) {
          if(isDefined(var_2))
            var_2 _meth_83FF();

          continue;
        }

        if(isDefined(var_2))
          var_2 _meth_8429(var_0, 0, 1);
      }
    }
  }
}