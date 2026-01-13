/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3584.gsc
************************/

func_FCAF(var_0) {}

func_FCB6(var_0) {
  var_0.var_FCB9 = spawn("script_model", var_0.origin);
  var_0.var_FCB9 setModel("weapon_shinguard_wm");
  func_FCB7(var_0);
  var_0 notifyonplayercommand("shinGuard_crouchPress", "+stance");
  var_0 notifyonplayercommand("shinGuard_crouchRelease", "-stance");
  var_0 notifyonplayercommand("shinGuard_jumpPress", "+goStand");
  thread func_FCB1(var_0);
  thread func_FCB5(var_0);
  thread func_FCB3(var_0);
  thread func_FCB4(var_0);
  thread func_FCB2(var_0);
}

func_FCBB(var_0) {
  var_0 notify("shinGuard_abort");
  var_0 notify("shinGuard_unset");
  if(isDefined(var_0.var_FCB9)) {
    var_0.var_FCB9 delete();
  }
}

func_FCB1(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_unset");
  for(;;) {
    var_0 waittill("shinGuard_crouchPress");
    if(!func_FCB0(var_0)) {
      thread func_FCAD(var_0);
    }
  }
}

func_FCB5(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_unset");
  for(;;) {
    var_0 waittill("sprint_slide_begin");
    thread func_FCAE(var_0, "sprint_slide_end");
  }
}

func_FCB3(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_unset");
  var_1 = scripts\mp\equipment\ground_pound::func_8651(var_0);
  var_2 = undefined;
  for(;;) {
    var_2 = var_1;
    var_1 = scripts\mp\equipment\ground_pound::func_8651(var_0);
    if(var_1 == 1 && var_1 != var_2) {
      thread func_FCAE(var_0, "groundPoundLand");
    }

    scripts\engine\utility::waitframe();
  }
}

func_FCB4(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_unset");
  for(;;) {
    var_0 waittill("runPowerSiege");
    var_0 notify("shinGuard_abort");
  }
}

func_FCB2(var_0) {
  var_0 endon("shinguard_unset");
  var_1 = var_0.var_FCB9;
  var_0 waittill("disconnect");
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_FCAE(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_crouchRelease");
  var_0 endon("shinGuard_abort");
  var_3 = gettime();
  var_0 waittill(var_1);
  scripts\engine\utility::waitframe();
  var_4 = gettime() - var_3 * 1000;
  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_0 notify("shinGuard_crouchPressOnNotify");
  thread func_FCAD(var_0, var_4);
}

func_FCAD(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_crouchRelease");
  var_0 endon("shinGuard_crouchPress");
  var_0 endon("shinGuard_crouchPressOnNotify");
  var_0 endon("shinGuard_abort");
  var_2 = 0;
  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  while(var_2 < 0.5) {
    if(!func_FCAC(var_0)) {
      return;
    }

    var_2 = var_2 + 0.05;
    scripts\engine\utility::waitframe();
  }

  if(!func_FCAC(var_0)) {
    return;
  }

  thread func_FCAA(var_0);
}

func_FCAA(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shinGuard_abort");
  var_0 notify("shinGuard_begin");
  var_0 iprintln("Shin Guard Activated");
  var_0.var_FCB0 = 1;
  var_0.var_FCBA = 1;
  var_0 setstance("crouch");
  var_0 scripts\engine\utility::allow_sprint(0);
  var_0 scripts\engine\utility::allow_stances(0);
  var_0 scripts\engine\utility::allow_weapon(0);
  var_0 scripts\mp\powers::func_D729();
  func_FCB8(var_0);
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinkto(var_1, "tag_origin", 0, 32, 32);
  thread func_FCAB(var_0, var_1);
  wait(0.5);
  var_0.var_FCBA = undefined;
  var_0 scripts\engine\utility::allow_sprint(1);
  var_0 scripts\engine\utility::allow_stances(1);
  var_0 scripts\engine\utility::waittill_any_3("shinGuard_crouchPress", "shinGuard_jumpPress", "sprint_begin");
  var_0 notify("shinGuard_end");
}

func_FCAB(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "shinGuard_end", "shinGuard_abort");
  if(isDefined(var_0)) {
    var_0.var_FCB0 = undefined;
    if(isDefined(var_0.var_FCBA)) {
      var_0.var_FCBA = undefined;
      var_0 scripts\engine\utility::allow_sprint(1);
      var_0 scripts\engine\utility::allow_stances(1);
    }

    var_0 scripts\engine\utility::allow_weapon(1);
    var_0 scripts\mp\powers::func_D72F();
    func_FCB7(var_0);
    var_0 unlink();
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_FCB8(var_0) {
  var_0.var_FCB9.origin = var_0.origin;
  var_0.var_FCB9.origin = var_0.var_FCB9.origin + anglesToForward(var_0.angles) * 10;
  var_0.var_FCB9.angles = var_0.angles + (0, 90, 0);
  var_0.var_FCB9 setCanDamage(1);
  var_0.var_FCB9 _meth_847F(1);
  var_0 playlocalsound("heavy_shield_up");
  var_0 playsoundtoteam("heavy_shield_up_npc", "axis", var_0);
  var_0 playsoundtoteam("heavy_shield_up_npc", "allies", var_0);
  var_0.var_FCB9 show();
}

func_FCB7(var_0) {
  var_0.var_FCB9 setCanDamage(0);
  var_0.var_FCB9 _meth_847F(0);
  var_0 playlocalsound("heavy_shield_down");
  var_0 playsoundtoteam("heavy_shield_down_npc", "axis", var_0);
  var_0 playsoundtoteam("heavy_shield_down_npc", "allies", var_0);
  var_0.var_FCB9 hide();
}

func_FCAC(var_0) {
  var_1 = var_0 getstance();
  if(!var_0 isonground()) {
    return 0;
  } else if(var_1 != "crouch") {
    return 0;
  }

  if(scripts\mp\archetypes\archheavy::func_101CA(var_0)) {
    return 0;
  }

  return 1;
}

func_FCB0(var_0) {
  return isDefined(var_0.var_FCB0);
}

func_FCB9(var_0) {
  return var_0.var_FCB9;
}