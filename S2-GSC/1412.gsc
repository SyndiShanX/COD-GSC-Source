/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1412.gsc
*********************************************/

func_9434() {
  common_scripts\utility::func_92C("storm_plasma_stable", "vfx/trail/zmb_tesla_storm_trail");
  common_scripts\utility::func_92C("storm_plasma_unstable", "vfx/trail/zmb_tesla_storm_trail_unstable");
  common_scripts\utility::func_92C("head_sparks", "vfx/explosion/zmb_tesla_storm_body_gib");
  common_scripts\utility::func_92C("tesla_storm_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_storm_idle");
  lib_0580::func_98FA("teslagun_zm_storm", ::func_433D, ::func_433F, ::func_4210, ::func_9431);
}

func_4134() {
  var_00 = self;
  var_01 = func_43EB();
  var_02 = var_00.origin - (0, 0, var_01 * 0.5);
  return var_02;
}

func_AAED() {
  var_00 = self;
  var_00 endon("death");
  var_01 = "tag_origin";
  for(;;) {
    wait(func_4218());
    var_02 = lib_0547::func_43F0(var_00 func_4134(), func_43EB(), func_43EC(), 0);
    if(!var_02.size) {
      continue;
    }

    var_03 = var_02[randomint(var_02.size)];
    var_04 = "j_head";
    playFXOnTag(common_scripts\utility::func_44F5("storm_plasma_unstable"), var_00, "tag_origin");
    var_00 lib_0378::func_8D74("aud_ww_projectile_zap");
    physicsexplosioncylinder(var_00.origin, func_43EC(), 0, 1);
    var_00 lib_0580::func_98F7(var_03);
    var_00 lib_0580::func_98F8(var_03, "head_sparks");
    var_00 func_9430();
    var_00 notify("scr_storm_slow_speed");
  }
}

func_9430() {
  var_00 = self;
  var_01 = func_4345();
  var_02 = distance(var_00.origin, var_00.var_2DA7);
  var_03 = var_02 / var_01;
  var_04 = func_405C();
  if(var_04 > var_03) {
    var_04 = var_03;
  }

  if(var_03 > 0) {
    var_00 moveTo(var_00.var_2DA7, var_03, var_04, 0);
  }

  var_00.var_2A92 = lib_0580::func_4385() + var_03;
}

func_9435() {
  var_00 = self;
  for(;;) {
    var_01 = lib_0580::func_4385();
    if(var_00.var_2A92 <= var_01) {
      break;
    }

    var_02 = var_00.var_2A92 - var_01;
    var_00.var_2A92 = var_00.var_2A92 - var_02;
    wait(var_02);
  }

  lib_0580::func_98E9(var_00.origin, func_43EC(), var_00.player, undefined, var_00.sweapon, (0.1686275, 0.2941177, 0.4352941));
  playFXOnTag(common_scripts\utility::func_44F5("storm_plasma_unstable"), var_00, "tag_origin");
  var_00 lib_0378::func_8D74("aud_storm_proj_loop_end");
  if(var_00.var_9B7F < 1) {
    wait(func_4192());
  }

  var_00 delete();
}

func_9431() {
  var_00 = self;
  playFXOnTag(common_scripts\utility::func_44F5("storm_plasma_stable"), var_00, "tag_origin");
  var_00 lib_0378::func_8D74("aud_storm_proj_loop_strt");
  var_00 func_9430();
  var_00 thread func_AAED();
  var_00 thread func_9435();
}

func_43EC() {
  return 130;
}

func_43EB() {
  return 150;
}

func_4210() {
  return 1000;
}

func_4218() {
  return 0.45;
}

func_433D() {
  return 42;
}

func_433F() {
  return -8;
}

func_4345() {
  return 130;
}

func_405C() {
  return 1;
}

func_4192() {
  return 1.6;
}