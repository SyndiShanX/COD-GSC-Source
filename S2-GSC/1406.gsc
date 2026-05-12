/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1406.gsc
*********************************************/

lib_057E::func_51CF() {
  var_00 = spawnStruct();
  var_00.var_6F9A = (0, 0, 0);
  var_00.var_6F9C = 500;
  var_00.var_6F9B = 360;
  common_scripts\utility::func_092C("vision_beam", "vfx/lights/mp_zombie_nest/zmb_sentry_vision_light");
  level.var_6FBF["Fireman Head"]["func"] = ::lib_057E::func_3C09;
  level.var_6FBF["Fireman Head"]["model"] = "npc_zom_fireman_head";
  level.var_6FBF["Fireman Head"]["canBeDroppedByZombies"] = ::maps\mp\gametypes\zombies::func_6FC7;
  level.var_6FBF["Fireman Head"]["phys_overrides"] = var_00;
  level.var_6FBF["Fireman Head"]["posOffset"] = (0, 0, 0);
  level.var_6FBF["Fireman Head"]["extraTimeoutSecs"] = 180;
  level.var_6FBF["Fireman Head"]["outline"] = 1;
  if(!isDefined(level.var_4BDF)) {
    level.var_4BDF = [];
  }

  level thread maps\mp\_utility::func_6F74(::lib_057E::func_AC25);
}

lib_057E::func_AC25(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 childthread lib_057E::func_6312();
}

lib_057E::func_314D(param_00) {
  var_01 = param_00 getweaponslistall();
  return common_scripts\utility::func_0F79(var_01, "sentryhead_zm");
}

lib_057E::func_6312() {
  var_00 = self;
  var_00.var_5605 = 0;
  var_01 = 0.2;
  var_02 = int(20 * var_01);
  var_03 = (0, 1, 0);
  for(;;) {
    wait(var_01);
    var_04 = var_00 playerads() > 0.3 && var_00 getcurrentweapon() == "sentryhead_zm";
    if(var_00.var_5605 != var_04) {
      var_00.var_5605 = var_04;
      if(var_04) {
        var_05 = common_scripts\utility::func_44F5("vision_beam");
        var_06 = spawnlinkedfx(var_05, var_00, "tag_fx", 1);
        triggerfx(var_06);
        var_00.var_3BF4 = var_06;
      } else {
        var_00.var_3BF4 delete();
        var_00.var_3BF4 = undefined;
      }
    }

    if(!var_04) {
      continue;
    }

    foreach(var_0A in level.var_4BDF) {
      if(!var_00 lib_057E::func_5626(var_0A)) {
        continue;
      }

      level thread[[var_0A.var_7E39]](var_0A, var_00);
      lib_057E::func_7CC2(var_0A);
    }
  }
}

lib_057E::func_437B(param_00) {
  var_01 = param_00.var_0116;
  if(isDefined(param_00.var_218D)) {
    var_01 = param_00.var_218D;
  }

  return var_01;
}

lib_057E::func_5626(param_00) {
  var_01 = self;
  var_02 = lib_057E::func_437B(param_00);
  var_03 = var_01 getEye();
  if(distancesquared(var_03, var_02) > squared(300)) {
    return 0;
  }

  var_04 = var_02 - var_03;
  var_05 = length(var_04);
  if(var_05 < 1) {
    return 1;
  }

  var_06 = var_04 / var_05;
  var_07 = anglesToForward(var_01 getangles());
  var_08 = acos(vectordot(var_07, var_06));
  if(var_08 > 30) {
    return 0;
  }

  if(!common_scripts\utility::func_562E(param_00.var_8C80) && !sighttracepassed(var_03, var_02, 0, param_00)) {
    return 0;
  }

  return 1;
}

lib_057E::func_0984(param_00, param_01, param_02) {
  var_03 = param_00.var_0116;
  if(isDefined(param_01)) {
    var_03 = param_01.var_0116;
  }

  param_00.var_218D = var_03;
  param_00.var_7E39 = param_02;
  if(!isDefined(level.var_4BDF)) {
    level.var_4BDF = [];
  }

  level.var_4BDF = common_scripts\utility::func_0F6F(level.var_4BDF, param_00);
}

lib_057E::func_7CC2(param_00) {
  level.var_4BDF = common_scripts\utility::func_0F93(level.var_4BDF, param_00);
}

lib_057E::func_3C09(param_00) {
  var_01 = self;
  if(common_scripts\utility::func_562E(var_01.var_558F) || lib_057E::func_314D(param_00) || param_00 lib_0586::func_72C3()) {
    return;
  }

  var_01.var_558F = 1;
  param_00 lib_0586::func_078C("sentryhead_zm");
  param_00 lib_0586::func_078E("sentryhead_zm");
  level thread maps\mp\gametypes\zombies::func_7CED(var_01);
}

lib_057E::func_418D() {
  return "sentryhead_zm";
}

lib_057E::func_4758() {
  lib_0586::func_078C("sentryhead_zm");
  lib_0586::func_078E("sentryhead_zm");
  maps\mp\_utility::func_47A2("specialty_ballcarrier");
  self method_8112(1);
  self method_8113(0);
  self method_8114(0);
  thread lib_057E::func_6360();
}

lib_057E::func_95CB() {
  if(self getcurrentweapon() == "sentryhead_zm") {
    var_00 = self.var_5B98;
    if(!isDefined(var_00) || var_00 == "none") {
      var_01 = self getweaponslistprimaries();
      foreach(var_03 in var_01) {
        if(lib_0547::func_5836(var_03)) {
          var_00 = var_03;
          break;
        }
      }
    }

    lib_0586::func_078E(var_00);
  }

  lib_0586::func_0790("sentryhead_zm");
  maps\mp\_utility::func_0735("specialty_ballcarrier");
  self method_8112(1);
  self method_8113(1);
  self method_8114(1);
  level thread lib_057E::func_8FA7(self.var_0116 + (0, 0, 10), "respawning on drop");
}

lib_057E::func_6360() {
  for(;;) {
    common_scripts\utility::func_A70A("weapon_change", "begin_last_stand");
    if(self getcurrentweapon() == "sentryhead_zm") {
      continue;
    }

    if(lib_057E::func_314D(self)) {
      lib_057E::func_95CB();
    }
  }
}

lib_057E::func_8FA7(param_00, param_01) {
  if(!isDefined(level.var_3C0A)) {
    level.var_3C0A = [];
    level thread lib_057E::func_633A();
  }

  var_02 = undefined;
  if(level.var_3C0A.size == 4) {
    var_03 = 0;
    for(var_03 = 0; var_03 < 4; var_03++) {
      if(common_scripts\utility::func_562E(level.var_3C0A[var_03].var_558F)) {
        break;
      }
    }

    if(var_03 == 4) {
      var_03 = 0;
    }

    var_02 = level.var_3C0A[var_03];
    level.var_3C0A = common_scripts\utility::func_0F9A(level.var_3C0A, var_03);
    level.var_3C0A[level.var_3C0A.size] = var_02;
  } else {
    var_02 = spawn("script_model", param_00);
    var_02 setModel("npc_zom_fireman_head");
    level.var_3C0A[level.var_3C0A.size] = var_02;
  }

  var_04 = (0, 0, 500);
  var_05 = 2000;
  var_06 = 0.1;
  var_07 = (0, 0, 5);
  var_02 method_808C();
  var_02.var_0116 = param_00;
  var_02 makeusable();
  var_02 method_805B();
  var_02 sethintstring(&"ZOMBIE_NEST_PICKUP_HEAD");
  var_02 physicslaunchserver(var_02.var_0116 + var_07, var_04, var_05, var_06);
  var_02.var_558F = 0;
  var_02 notify("recycle_fireman_head");
  var_02 endon("recycle_fireman_head");
  for(;;) {
    var_02 waittill("trigger", var_08);
    if(lib_057E::func_314D(var_08) || var_08 lib_0586::func_72C3()) {
      wait(0.25);
      continue;
    }

    break;
  }

  var_08 lib_057E::func_4758();
  var_02.var_558F = 1;
  var_02 method_84E0();
  var_02 makeunusable();
  var_02 hudoutlinedisable();
  var_02 sethintstring(&"ZOMBIES_EMPTY_STRING");
  var_02 method_805B();
  var_02 method_8511();
}

lib_057E::func_633A() {
  for(;;) {
    level waittill("on togglescore");
    var_00 = lib_0557::func_42B9();
    foreach(var_02 in level.var_3C0A) {
      if(!common_scripts\utility::func_562E(var_02.var_558F)) {
        if(var_00.size == 0) {
          if(isDefined(var_02)) {
            var_02 hudoutlinedisable();
          }

          continue;
        }

        if(isDefined(var_02)) {
          var_02 hudoutlineenableforclients(var_00, 0, 1);
        }
      }
    }
  }
}