/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3584.gsc
************************/

func_FCAF(param_00) {}

func_FCB6(param_00) {
  param_00.var_FCB9 = spawn("script_model", param_00.origin);
  param_00.var_FCB9 setModel("weapon_shinguard_wm");
  func_FCB7(param_00);
  param_00 notifyonplayercommand("shinGuard_crouchPress", "+stance");
  param_00 notifyonplayercommand("shinGuard_crouchRelease", "-stance");
  param_00 notifyonplayercommand("shinGuard_jumpPress", "+goStand");
  thread func_FCB1(param_00);
  thread func_FCB5(param_00);
  thread func_FCB3(param_00);
  thread func_FCB4(param_00);
  thread func_FCB2(param_00);
}

func_FCBB(param_00) {
  param_00 notify("shinGuard_abort");
  param_00 notify("shinGuard_unset");
  if(isDefined(param_00.var_FCB9)) {
    param_00.var_FCB9 delete();
  }
}

func_FCB1(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_unset");
  for(;;) {
    param_00 waittill("shinGuard_crouchPress");
    if(!func_FCB0(param_00)) {
      thread func_FCAD(param_00);
    }
  }
}

func_FCB5(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_unset");
  for(;;) {
    param_00 waittill("sprint_slide_begin");
    thread func_FCAE(param_00, "sprint_slide_end");
  }
}

func_FCB3(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_unset");
  var_01 = scripts\mp\equipment\ground_pound::func_8651(param_00);
  var_02 = undefined;
  for(;;) {
    var_02 = var_01;
    var_01 = scripts\mp\equipment\ground_pound::func_8651(param_00);
    if(var_01 == 1 && var_01 != var_02) {
      thread func_FCAE(param_00, "groundPoundLand");
    }

    scripts\engine\utility::waitframe();
  }
}

func_FCB4(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_unset");
  for(;;) {
    param_00 waittill("runPowerSiege");
    param_00 notify("shinGuard_abort");
  }
}

func_FCB2(param_00) {
  param_00 endon("shinguard_unset");
  var_01 = param_00.var_FCB9;
  param_00 waittill("disconnect");
  if(isDefined(var_01)) {
    var_01 delete();
  }
}

func_FCAE(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_crouchRelease");
  param_00 endon("shinGuard_abort");
  var_03 = gettime();
  param_00 waittill(param_01);
  scripts\engine\utility::waitframe();
  var_04 = gettime() - var_03 * 1000;
  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  param_00 notify("shinGuard_crouchPressOnNotify");
  thread func_FCAD(param_00, var_04);
}

func_FCAD(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_crouchRelease");
  param_00 endon("shinGuard_crouchPress");
  param_00 endon("shinGuard_crouchPressOnNotify");
  param_00 endon("shinGuard_abort");
  var_02 = 0;
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  while(var_02 < 0.5) {
    if(!func_FCAC(param_00)) {
      return;
    }

    var_02 = var_02 + 0.05;
    scripts\engine\utility::waitframe();
  }

  if(!func_FCAC(param_00)) {
    return;
  }

  thread func_FCAA(param_00);
}

func_FCAA(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shinGuard_abort");
  param_00 notify("shinGuard_begin");
  param_00 iprintln("Shin Guard Activated");
  param_00.var_FCB0 = 1;
  param_00.var_FCBA = 1;
  param_00 setstance("crouch");
  param_00 scripts\engine\utility::allow_sprint(0);
  param_00 scripts\engine\utility::allow_stances(0);
  param_00 scripts\engine\utility::allow_weapon(0);
  param_00 scripts\mp\powers::func_D729();
  func_FCB8(param_00);
  var_01 = param_00 scripts\engine\utility::spawn_tag_origin();
  param_00 playerlinkto(var_01, "tag_origin", 0, 32, 32);
  thread func_FCAB(param_00, var_01);
  wait(0.5);
  param_00.var_FCBA = undefined;
  param_00 scripts\engine\utility::allow_sprint(1);
  param_00 scripts\engine\utility::allow_stances(1);
  param_00 scripts\engine\utility::waittill_any_3("shinGuard_crouchPress", "shinGuard_jumpPress", "sprint_begin");
  param_00 notify("shinGuard_end");
}

func_FCAB(param_00, param_01) {
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect", "shinGuard_end", "shinGuard_abort");
  if(isDefined(param_00)) {
    param_00.var_FCB0 = undefined;
    if(isDefined(param_00.var_FCBA)) {
      param_00.var_FCBA = undefined;
      param_00 scripts\engine\utility::allow_sprint(1);
      param_00 scripts\engine\utility::allow_stances(1);
    }

    param_00 scripts\engine\utility::allow_weapon(1);
    param_00 scripts\mp\powers::func_D72F();
    func_FCB7(param_00);
    param_00 unlink();
  }

  if(isDefined(param_01)) {
    param_01 delete();
  }
}

func_FCB8(param_00) {
  param_00.var_FCB9.origin = param_00.origin;
  param_00.var_FCB9.origin = param_00.var_FCB9.origin + anglesToForward(param_00.angles) * 10;
  param_00.var_FCB9.angles = param_00.angles + (0, 90, 0);
  param_00.var_FCB9 setCanDamage(1);
  param_00.var_FCB9 _meth_847F(1);
  param_00 playlocalsound("heavy_shield_up");
  param_00 playsoundtoteam("heavy_shield_up_npc", "axis", param_00);
  param_00 playsoundtoteam("heavy_shield_up_npc", "allies", param_00);
  param_00.var_FCB9 show();
}

func_FCB7(param_00) {
  param_00.var_FCB9 setCanDamage(0);
  param_00.var_FCB9 _meth_847F(0);
  param_00 playlocalsound("heavy_shield_down");
  param_00 playsoundtoteam("heavy_shield_down_npc", "axis", param_00);
  param_00 playsoundtoteam("heavy_shield_down_npc", "allies", param_00);
  param_00.var_FCB9 hide();
}

func_FCAC(param_00) {
  var_01 = param_00 getstance();
  if(!param_00 isonground()) {
    return 0;
  } else if(var_01 != "crouch") {
    return 0;
  }

  if(scripts\mp\archetypes\archheavy::func_101CA(param_00)) {
    return 0;
  }

  return 1;
}

func_FCB0(param_00) {
  return isDefined(param_00.var_FCB0);
}

func_FCB9(param_00) {
  return param_00.var_FCB9;
}