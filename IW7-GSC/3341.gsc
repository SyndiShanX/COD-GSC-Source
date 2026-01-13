/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3341.gsc
*********************************************/

init() {
  level._effect["slam_sml"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_s");
  level._effect["slam_lrg"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_l");
}

stoplocalsound(var_0) {
  thread func_102C9(var_0);
}

func_E16C(var_0) {
  var_0 notify("removeSlam");
}

func_102C9(var_0) {
  if(isbot(var_0)) {
    return;
  }

  var_0 endon("removeSlam");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("slamButtonPressed", "+stance");
  for(;;) {
    var_0 waittill("slamButtonPressed");
    if(!func_102CB(var_0)) {
      continue;
    }

    var_1 = func_102C5(var_0);
    slam_execute(var_0, var_1);
  }
}

func_102CB(var_0) {
  return var_0 isonground() == 0 && var_0 getstance() != "prone";
}

func_102C5(var_0) {
  var_1 = anglestoright(var_0.angles);
  var_2 = rotatepointaroundvector(var_1, (0, 0, -1), 45);
  var_3 = var_0.origin + var_2 * 600;
  return var_0 aiphysicstrace(var_0.origin, var_3, 16, 80, 1, 0);
}

slam_execute(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = lengthsquared(var_0.origin - var_1);
    if(var_3 < 576) {
      return;
    }

    if(var_3 > squared(600)) {
      return;
    }
  }

  var_4 = var_0 scripts\engine\utility::spawn_tag_origin();
  thread slam_delent(var_0, var_4);
  slam_executeinternal(var_0, var_1, var_4, var_2);
  var_0 notify("slam_finished");
}

slam_executeinternal(var_0, var_1, var_2, var_3) {
  var_4 = lengthsquared(var_0.origin - var_1);
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  if(var_4 >= 28224) {
    var_6 = 20736;
    var_5 = 1;
  } else if(var_4 >= 7056) {
    var_6 = 5184;
    var_7 = 20736;
  } else {
    var_7 = 11664;
  }

  var_0 setstance("crouch");
  var_0 playerlinkto(var_2, "tag_origin");
  var_2 moveto(var_1, 0.25, 0.1, 0);
  wait(0.25);
  var_0 thread scripts\cp\cp_weapon::grenade_earthquake(0);
  if(!isDefined(var_3)) {
    var_0 playSound("detpack_explo_metal");
    var_8 = scripts\engine\utility::ter_op(var_5, scripts\engine\utility::getfx("slam_lrg"), scripts\engine\utility::getfx("slam_sml"));
    playFX(var_8, var_1);
  }

  thread slam_physicspulse(var_1);
  var_9 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_0B in var_9) {
    if(!isDefined(var_0B) || var_0B == var_0 || !scripts\cp\utility::isreallyalive(var_0B)) {
      continue;
    }

    var_0C = undefined;
    var_0D = distancesquared(var_1, var_0B.origin);
    if(var_0D <= var_6) {
      var_0C = 250;
    } else if(var_0D <= var_7) {
      var_0C = 100;
    } else {
      continue;
    }

    var_0B scripts\cp\cp_weapon::shellshockondamage("MOD_EXPLOSIVE", var_0C);
    if(var_0C >= var_0B.health) {
      var_0B.customdeath = 1;
    }

    var_0B dodamage(var_0C, var_1, var_0, var_0, "MOD_CRUSH");
  }

  wait(0.5);
  var_0 unlink();
  var_0 setstance("stand");
}

slam_physicspulse(var_0) {
  wait(0.1);
  physicsexplosionsphere(var_0 - (0, 0, 60), 240, 140, 3.5);
}

slam_delent(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "slam_finished");
  scripts\engine\utility::waitframe();
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_102CC(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("death");
  wait(var_1);
  return 1;
}