/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3341.gsc
************************/

init() {
  level._effect["slam_sml"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_s");
  level._effect["slam_lrg"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_l");
}

stoplocalsound(param_00) {
  thread func_102C9(param_00);
}

func_E16C(param_00) {
  param_00 notify("removeSlam");
}

func_102C9(param_00) {
  if(isbot(param_00)) {
    return;
  }

  param_00 endon("removeSlam");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 notifyonplayercommand("slamButtonPressed", "+stance");
  for(;;) {
    param_00 waittill("slamButtonPressed");
    if(!func_102CB(param_00)) {
      continue;
    }

    var_01 = func_102C5(param_00);
    slam_execute(param_00, var_01);
  }
}

func_102CB(param_00) {
  return param_00 isonground() == 0 && param_00 getstance() != "prone";
}

func_102C5(param_00) {
  var_01 = anglestoright(param_00.angles);
  var_02 = rotatepointaroundvector(var_01, (0, 0, -1), 45);
  var_03 = param_00.origin + var_02 * 600;
  return param_00 aiphysicstrace(param_00.origin, var_03, 16, 80, 1, 0);
}

slam_execute(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    var_03 = lengthsquared(param_00.origin - param_01);
    if(var_03 < 576) {
      return;
    }

    if(var_03 > squared(600)) {
      return;
    }
  }

  var_04 = param_00 scripts\engine\utility::spawn_tag_origin();
  thread slam_delent(param_00, var_04);
  slam_executeinternal(param_00, param_01, var_04, param_02);
  param_00 notify("slam_finished");
}

slam_executeinternal(param_00, param_01, param_02, param_03) {
  var_04 = lengthsquared(param_00.origin - param_01);
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  if(var_04 >= 28224) {
    var_06 = 20736;
    var_05 = 1;
  } else if(var_04 >= 7056) {
    var_06 = 5184;
    var_07 = 20736;
  } else {
    var_07 = 11664;
  }

  param_00 setstance("crouch");
  param_00 playerlinkto(param_02, "tag_origin");
  param_02 moveto(param_01, 0.25, 0.1, 0);
  wait(0.25);
  param_00 thread scripts\cp\cp_weapon::grenade_earthquake(0);
  if(!isDefined(param_03)) {
    param_00 playSound("detpack_explo_metal");
    var_08 = scripts\engine\utility::ter_op(var_05, scripts\engine\utility::getfx("slam_lrg"), scripts\engine\utility::getfx("slam_sml"));
    playFX(var_08, param_01);
  } else {}

  thread slam_physicspulse(param_01);
  var_09 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_0B in var_09) {
    if(!isDefined(var_0B) || var_0B == param_00 || !scripts\cp\utility::isreallyalive(var_0B)) {
      continue;
    }

    var_0C = undefined;
    var_0D = distancesquared(param_01, var_0B.origin);
    if(var_0D <= var_06) {
      var_0C = 250;
    } else if(var_0D <= var_07) {
      var_0C = 100;
    } else {
      continue;
    }

    var_0B scripts\cp\cp_weapon::shellshockondamage("MOD_EXPLOSIVE", var_0C);
    if(var_0C >= var_0B.health) {
      var_0B.customdeath = 1;
    }

    var_0B dodamage(var_0C, param_01, param_00, param_00, "MOD_CRUSH");
  }

  wait(0.5);
  param_00 unlink();
  param_00 setstance("stand");
}

slam_physicspulse(param_00) {
  wait(0.1);
  physicsexplosionsphere(param_00 - (0, 0, 60), 240, 140, 3.5);
}

slam_delent(param_00, param_01) {
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect", "slam_finished");
  scripts\engine\utility::waitframe();
  if(isDefined(param_01)) {
    param_01 delete();
  }
}

func_102CC(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("death");
  wait(param_01);
  return 1;
}