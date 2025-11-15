/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\powers\blink_knife.gsc
*********************************************/

blinkknifeinit() {
  scripts\mp\utility::initarbitraryuptriggers();
}

blinkknifedetonate(param_00, param_01, param_02) {
  var_03 = param_01.origin;
  var_04 = param_01.angles;
  var_05 = param_01 getplayerangles();
  var_06 = param_01 getstance();
  if(!blinkknife_validatestuckto(param_01)) {
    blinkknife_detonatefailed(param_02);
    return 0;
  }

  if(!blinkknife_validateplayer(param_02)) {
    blinkknife_detonatefailed(param_02);
    return 0;
  }

  var_07 = param_02 scripts\mp\utility::isinarbitraryup();
  var_08 = param_01 scripts\mp\utility::isinarbitraryup();
  if(var_07 && var_08) {
    blinkknife_detonatefailed(param_02);
    return 0;
  }

  if(var_08) {
    var_09 = param_01 scripts\mp\utility::getarbitraryuptriggerblinkloc();
    if(!isDefined(var_09)) {
      blinkknife_detonatefailed(param_02);
      return 0;
    }

    var_0A = spawnStruct();
    var_0A.origin = var_09;
    var_0A.var_10B53 = "stand";
    var_0A.cleararbup = 0;
    var_0B = anglesToForward(param_02 getplayerangles());
    var_0B = var_0B * (1, 1, 0);
    var_0C = vectortoangles(var_0B);
    var_0A.playerangles = var_0C;
    var_0A.angles = var_0C * (0, 1, 0);
    if(blinkknife_validatedestination(param_02, var_0A)) {
      thread blinkknife_detonatesuccess(param_02, param_01, var_0A, param_00);
      return 1;
    }
  } else if(var_0B) {
    var_0A = spawnStruct();
    var_0C.origin = var_05;
    var_0C.var_10B53 = "stand";
    var_0C.cleararbup = 1;
    var_0B = anglesToForward(var_04 getplayerangles());
    var_0C = var_0C * (1, 1, 0);
    var_0C = vectortoangles(var_0C);
    var_0A.playerangles = var_0C;
    var_0A.angles = var_0C * (0, 1, 0);
    if(blinkknife_validatedestination(param_02, var_0A)) {
      thread blinkknife_detonatesuccess(param_02, param_01, var_0A, param_00);
      return 1;
    }

    var_0A.var_10B53 = "crouch";
    if(blinkknife_validatedestination(param_02, var_0A)) {
      thread blinkknife_detonatesuccess(param_02, param_01, var_0A, param_00);
      return 1;
    }

    var_0A.var_10B53 = var_06;
    var_0B = anglesToForward(var_05);
    var_0B = var_0B * (1, 1, 0);
    var_0C = vectortoangles(var_0B);
    var_0A.playerangles = var_0C;
    var_0A.angles = var_0C * (0, 1, 0);
    if(blinkknife_validatedestination(param_02, var_0A)) {
      thread blinkknife_detonatesuccess(param_02, param_01, var_0A, param_00);
      return 1;
    }
  } else {
    var_0A = spawnStruct();
    var_0C.origin = var_05;
    var_0C.angles = var_04.angles;
    var_0C.playerangles = var_04 getplayerangles();
    var_0C.var_10B53 = "stand";
    var_0C.cleararbup = 0;
    if(blinkknife_validatedestination(var_04, var_0C)) {
      thread blinkknife_detonatesuccess(var_04, var_03, var_0C, param_02);
      return 1;
    }

    var_0C.var_10B53 = "crouch";
    if(blinkknife_validatedestination(var_04, var_0C)) {
      thread blinkknife_detonatesuccess(var_04, var_03, var_0C, param_02);
      return 1;
    }

    var_0C.var_10B53 = var_08;
    var_0B = anglesToForward(var_07);
    var_0C = var_0C * (1, 1, 0);
    var_0C = vectortoangles(var_0C);
    var_0A.playerangles = var_0C;
    var_0A.angles = var_0C * (0, 1, 0);
    if(blinkknife_validatedestination(param_02, var_0A)) {
      thread blinkknife_detonatesuccess(param_02, param_01, var_0A, param_00);
      return 1;
    }
  }

  blinkknife_detonatefailed(param_02);
  return 0;
}

blinkknife_detonatesuccess(param_00, param_01, param_02, param_03) {
  blinkknife_dropball(param_00);
  blinkknife_dropflag(param_00);
  thread blinkknife_watchteleport(param_00);
  thread blinkknife_victimfx(param_00, param_01);
  thread blinkknife_startfx(param_00, param_02);
  if(param_02.cleararbup) {
    param_00 setworldupreferenceangles((0, 0, 0), 0);
  }

  param_00 setorigin(param_02.origin, 1, 1);
  param_00 setplayerangles(param_02.playerangles);
  param_00 setstance(param_02.var_10B53);
  thread blinkknife_endfx(param_00);
  if(isDefined(param_03)) {
    param_03 endon("death");
    param_00 endon("death");
    param_00 endon("disconnect");
    waittillframeend;
    if(scripts\mp\weapons::throwingknifeused_trygiveknife(param_00, "power_blinkKnife")) {
      param_03 delete();
    }
  }
}

blinkknife_detonatefailed(param_00) {
  if(level.gameended) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return;
  }

  param_00 scripts\mp\hud_message::showerrormessage("MP_BLINK_KNIFE_FAILED");
}

blinkknife_watchteleport(param_00) {
  param_00 endon("disconnect");
  param_00.blinkknife_teleporting = 1;
  param_00 scripts\engine\utility::waittill_any_timeout_1(0.05, "death");
  param_00.blinkknife_teleporting = undefined;
}

blinkknife_validatestuckto(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isplayer(param_00)) {
    return 0;
  }

  if(scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(param_00 _meth_8568()) {
    return 0;
  }

  if(param_00 _meth_8569()) {
    return 0;
  }

  if(scripts\mp\utility::istrue(param_00.blinkknife_teleporting)) {
    return 0;
  }

  return 1;
}

blinkknife_validateplayer(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(param_00 _meth_84CA()) {
    return 0;
  }

  if(param_00 scripts\mp\supers\super_reaper::isusingreaper()) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(param_00 _meth_8568()) {
    return 0;
  }

  if(param_00 _meth_8569()) {
    return 0;
  }

  if(scripts\mp\utility::istrue(param_00.blinkknife_teleporting)) {
    return 0;
  }

  return 1;
}

blinkknife_validatedestination(param_00, param_01) {
  var_02 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_vehicle", "physicscontents_sky", "physicscontents_playerclip"]);
  var_03 = physics_getclosestpointtocharacter(param_01.origin, param_00, 0, param_01.angles, 0, var_02, [param_00], "physicsquery_closest", param_01.var_10B53);
  if(isDefined(var_03) && var_03.size > 0) {
    return 0;
  }

  return 1;
}

blinkknife_dropball(param_00) {
  if(param_00 scripts\mp\utility::_hasperk("specialty_ballcarrier")) {
    param_00 scripts\mp\gametypes\obj_ball::ball_drop_on_ability();
  }
}

blinkknife_dropflag(param_00) {
  if(isDefined(param_00.carryflag)) {
    var_01 = level.teamflags[scripts\mp\utility::getotherteam(param_00.team)];
    var_01 thread scripts\mp\gameobjects::setdropped();
  }
}

blinkknife_startfx(param_00, param_01) {
  if(!isDefined(param_00.blinkknife_startstateid)) {
    param_00.blinkknife_startstateid = 1;
  } else {
    param_00.blinkknife_startstateid = scripts\engine\utility::ter_op(param_00.blinkknife_startstateid == 1, 2, 1);
  }

  param_00 setscriptablepartstate("blinkKnifeStart", "active" + param_00.blinkknife_startstateid);
  var_02 = param_00 gettagorigin("j_spineupper");
  var_03 = vectortoangles(param_01.origin - param_00.origin);
  var_04 = spawn("script_model", var_02);
  var_04.angles = var_03;
  var_04 setModel("power_mp_blinkKnife_scr");
  var_04 setscriptablepartstate("effects", "activeBlinkStart");
  wait(0.2);
  var_04 delete();
}

blinkknife_endfx(param_00) {
  scripts\engine\utility::waitframe();
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.blinkknife_endstateid)) {
    param_00.blinkknife_endstateid = 1;
  } else {
    param_00.blinkknife_endstateid = scripts\engine\utility::ter_op(param_00.blinkknife_endstateid == 1, 2, 1);
  }

  param_00 setscriptablepartstate("blinkKnifeEnd", "active" + param_00.blinkknife_endstateid);
}

blinkknife_victimfx(param_00, param_01) {
  var_02 = param_01 _meth_8113();
  if(isDefined(var_02)) {
    var_02 hide();
  }

  var_03 = param_01 gettagorigin("j_spineupper");
  var_04 = param_01.angles;
  var_05 = spawn("script_model", var_03);
  var_05.angles = var_04;
  var_05 setModel("power_mp_blinkKnife_scr");
  if(param_01.loadoutarchetype == "archetype_scout") {
    var_05 setscriptablepartstate("effects", "activeVictimDeathRobot");
  } else {
    var_05 setscriptablepartstate("effects", "activeVictimDeath");
  }

  wait(1);
  var_05 delete();
}