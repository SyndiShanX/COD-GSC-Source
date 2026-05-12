/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1411.gsc
*********************************************/

lib_0583::func_6402() {
  common_scripts\utility::func_092C("moon_plasma", "vfx/trail/zmb_tesla_moon_trail");
  common_scripts\utility::func_092C("tesla_moon_explosion", "vfx/explosion/zmb_tesla_moon_body_gib");
  common_scripts\utility::func_092C("moon_plasma_unstable", "vfx/trail/zmb_tesla_moon_trail_unstable");
  common_scripts\utility::func_092C("tesla_moon_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_moon_idle");
  lib_0580::func_98FA("teslagun_zm_moon", ::lib_0583::func_433D, ::lib_0583::func_433F, ::lib_0583::func_4210, ::lib_0583::func_63FF);
}

lib_0583::func_63FF() {
  var_00 = self;
  var_00 endon("death");
  var_01 = lib_0583::func_4344();
  var_02 = distance(var_00.var_0116, var_00.var_2DA7);
  var_03 = var_02 / var_01;
  if(var_03 > 0) {
    var_00 moveto(var_00.var_2DA7, var_03, 0, 0);
  }

  playFXOnTag(common_scripts\utility::func_44F5("moon_plasma"), var_00, "tag_origin");
  var_00 lib_0378::func_8D74("aud_moon_projectile_strt");
  wait(var_03);
  var_00 notify("moon_travel_end");
  var_00 lib_0378::func_8D74("aud_moon_projectile_end");
  wait(lib_0583::func_4319());
  var_04 = lib_0583::func_40AA() / 2;
  lib_0580::func_98E9(var_00.var_0116, var_04, var_00.var_721C, undefined, var_00.var_953E, (0.1882353, 0.2352941, 0.454902));
  playFX(common_scripts\utility::func_44F5("tesla_moon_explosion"), var_00.var_0116);
  var_00 delete();
}

lib_0583::func_AAED() {
  var_00 = self;
  var_00 endon("moon_travel_end");
  for(;;) {
    var_01 = lib_0547::func_408F();
    var_02 = lib_0583::func_43EC();
    var_03 = common_scripts\utility::func_4461(var_00.var_0116, var_01, var_02);
    if(isDefined(var_03)) {
      var_00 lib_0580::func_98F7(var_03);
      playFX(common_scripts\utility::func_44F5("tesla_moon_explosion"), var_03.var_0116 + (0, 0, 54));
      playFXOnTag(common_scripts\utility::func_44F5("moon_plasma_unstable"), var_00, "tag_origin");
      var_03 lib_0378::func_8D74("aud_ww_projectile_zap");
      wait 0.05;
      lib_0580::func_98E9(var_03.var_0116, lib_0583::func_40AA(), var_00.var_721C, undefined, var_00.var_953E, (0.1882353, 0.2352941, 0.454902));
    }

    wait(max(0.05, lib_0583::func_4319()));
  }
}

lib_0583::func_63FC(param_00) {
  var_01 = self;
  var_01 lib_0580::func_98F7(param_00);
  playFX(common_scripts\utility::func_44F5("tesla_moon_explosion"), param_00.var_0116 + (0, 0, 54));
  playFXOnTag(common_scripts\utility::func_44F5("moon_plasma_unstable"), var_01, "tag_origin");
  param_00 lib_0378::func_8D74("aud_ww_projectile_zap");
  wait 0.05;
  var_02 = maps\mp\gametypes\zombies::func_1E59() * 2;
  lib_0580::func_98E9(param_00.var_0116, lib_0583::func_40AA(), var_01.var_721C, undefined, var_01.var_953E, (0.1882353, 0.2352941, 0.454902), var_02);
}

lib_0583::func_4319() {
  var_00 = lib_0583::func_4217();
  var_01 = lib_0583::func_4344();
  var_02 = var_00 / max(1, var_01);
  return var_02;
}

lib_0583::func_43EC() {
  return 50;
}

lib_0583::func_4210() {
  return 1000;
}

lib_0583::func_4217() {
  return 100;
}

lib_0583::func_433D() {
  return 45;
}

lib_0583::func_433F() {
  return -8;
}

lib_0583::func_4344() {
  return 350;
}

lib_0583::func_40AA() {
  return 120;
}