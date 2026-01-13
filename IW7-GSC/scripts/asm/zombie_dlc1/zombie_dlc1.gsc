/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\zombie_dlc1\zombie_dlc1.gsc
***************************************************/

playtraverseanimz_dlc1(var_0, var_1, var_2, var_3) {
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoTraverse");
  var_4 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  dotraverseanim_dlc1(var_0, var_1, var_2, var_3);
  self.do_immediate_ragdoll = var_4;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

removezfromvec(var_0) {
  return (var_0[0], var_0[1], 0);
}

dotraverseanim_dlc1(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self func_8146();
  self.endnode_pos = var_5;
  if(!isDefined(var_4)) {
    return;
  }

  if(!isDefined(var_5)) {
    return;
  }

  self.var_6378 = var_5;
  self.traversalvector = vectornormalize(var_5 - var_4.origin);
  var_6 = undefined;
  var_6 = var_4.opcode::OP_ScriptMethodCallPointer;
  if(var_1 == "traverse_external") {
    var_6 = var_1;
  }

  if(needscrawlinganimstate_dlc1(var_6)) {
    var_6 = "crawling_" + var_6;
  }

  if(self.agent_type == "lumberjack") {
    var_6 = var_6 + "_norestart";
  }

  if(!isDefined(var_6)) {
    return;
  }

  self.is_traversing = 1;
  var_7 = scripts\asm\asm_mp::asm_getanim(var_0, var_6);
  var_8 = var_5 - var_4.origin;
  var_9 = (var_8[0], var_8[1], 0);
  var_0A = vectortoangles(var_9);
  var_0B = issubstr(var_6, "jump_across");
  var_0C = var_6 == "traverse_boost" && self.species == "humanoid" || self.species == "zombie";
  self orientmode("face angle abs", var_0A);
  self ghostlaunched("anim deltas");
  var_0D = self getsafecircleorigin(var_6, var_7);
  var_0E = "flex_height_up_start";
  var_0F = getnotetracktimes(var_0D, var_0E);
  if(var_0F.size == 0) {
    var_0E = "flex_height_start";
    var_0F = getnotetracktimes(var_0D, var_0E);
    if(var_0F.size == 0) {
      var_0E = "traverse_jump_start";
      var_0F = getnotetracktimes(var_0D, var_0E);
    }
  }

  var_10 = "flex_height_up_end";
  var_11 = getnotetracktimes(var_0D, var_10);
  if(var_11.size == 0) {
    var_10 = "flex_height_end";
    var_11 = getnotetracktimes(var_0D, var_10);
    if(var_11.size == 0) {
      var_10 = "traverse_jump_end";
      var_11 = getnotetracktimes(var_0D, var_10);
    }
  }

  var_12 = "highest_point";
  var_13 = getnotetracktimes(var_0D, var_12);
  var_14 = "flex_height_down_start";
  var_15 = getnotetracktimes(var_0D, var_14);
  var_16 = "flex_height_down_end";
  opcode::OP_SetNewLocalVariableFieldCached0 = getnotetracktimes(var_0D, var_16);
  opcode::OP_EvalSelfFieldVariable = "crawler_early_stop";
  opcode::OP_Return = getnotetracktimes(var_0D, opcode::OP_EvalSelfFieldVariable);
  opcode::OP_CallBuiltin0 = getnotetracktimes(var_0D, "code_move");
  if(var_1A.size > 0) {
    opcode::OP_CallBuiltin1 = getmovedelta(var_0D, 0, opcode::OP_CallBuiltin0[0]);
  } else {
    opcode::OP_CallBuiltin1 = getmovedelta(var_0E, 0, 1);
  }

  opcode::OP_CallBuiltin2 = scripts\mp\agents\_scriptedagents::func_7DC9(var_8, opcode::OP_CallBuiltin1);
  opcode::OP_CallBuiltin3 = animhasnotetrack(var_0D, "ignoreanimscaling");
  if(opcode::OP_CallBuiltin3) {
    var_1C.var_13E2B = 1;
  }

  self gib_fx_override("noclip");
  opcode::OP_CallBuiltin4 = self func_8145();
  if(isDefined(opcode::OP_CallBuiltin4) && isDefined(var_1E.target)) {
    self.endnode = opcode::OP_CallBuiltin4;
    opcode::OP_CallBuiltin5 = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
    if(var_13.size > 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6, var_7, var_0D, "traverse", var_0E, var_12, 0, ::zombietraversenotetrackhandler_dlc1);
      opcode::OP_CallBuiltin5 = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      if(isDefined(var_1F.script_noteworthy) && var_1F.script_noteworthy == "continue_flex_height") {
        scripts\mp\agents\_scriptedagents::func_5AC1(var_6, var_7, var_0D, "traverse", var_12, var_10, 1, ::zombietraversenotetrackhandler_dlc1);
      }

      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else if(var_15.size == 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6, var_7, var_0D, "traverse", var_0E, var_10, 0, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else if(var_0F.size == 0) {
      scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "flex_height_down_start", ::zombietraversenotetrackhandler_dlc1);
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6, var_7, var_0D, "traverse", var_14, var_16, 0, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else {
      opcode::OP_CallBuiltin = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      opcode::OP_CallBuiltin5 = var_20.origin;
      opcode::OP_BoolNot = var_11[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_6, var_7, "traverse", var_0D, var_0E, var_10, opcode::OP_CallBuiltin5, opcode::OP_BoolNot, ::zombietraversenotetrackhandler_dlc1);
      opcode::OP_ScriptFarMethodThreadCall = getanimlength(var_0D);
      if(var_15[0] - var_11[0] >= 0.05 / opcode::OP_ScriptFarMethodThreadCall) {
        self scragentsetanimscale(1, 1);
        scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", var_14, ::zombietraversenotetrackhandler_dlc1);
      }

      opcode::OP_CallBuiltin5 = self.endnode.origin;
      opcode::OP_BoolNot = opcode::OP_SetNewLocalVariableFieldCached0[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_6, var_7, "traverse", var_0D, var_14, var_16, opcode::OP_CallBuiltin5, opcode::OP_BoolNot, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1, 1);
      if(var_19.size == 0 || !scripts\engine\utility::istrue(self.dismember_crawl)) {
        scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
      }
    }

    self.endnode = undefined;
  } else if(var_15.size > 0 && var_17.size > 0 && self.agent_type != "zombie_brute") {
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", var_14, ::zombietraversenotetrackhandler_dlc1);
    opcode::OP_BoolNot = opcode::OP_SetNewLocalVariableFieldCached0[0];
    if(!isDefined(opcode::OP_CallBuiltin4)) {
      opcode::OP_CallBuiltin5 = var_5;
    } else {
      opcode::OP_CallBuiltin5 = var_21.origin;
    }

    scripts\mp\agents\_scriptedagents::func_5AC2(var_6, var_7, "traverse", var_0D, var_14, var_16, opcode::OP_CallBuiltin5, opcode::OP_BoolNot, ::zombietraversenotetrackhandler_dlc1);
    if(var_19.size == 0 || !scripts\engine\utility::istrue(self.dismember_crawl)) {
      scripts\mp\agents\_scriptedagents::func_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    }
  } else if(var_0B && abs(var_8[2]) < 64) {
    if(var_0F.size != 1) {
      var_0F = getnotetracktimes(var_0D, "flex_across_start");
    }

    if(var_11.size != 1) {
      var_11 = getnotetracktimes(var_0D, "flex_across_end");
    }

    opcode::OP_ScriptFarMethodThreadCall = getanimlength(var_0D);
    opcode::OP_JumpOnTrueExpr = var_0F[0] * opcode::OP_ScriptFarMethodThreadCall;
    opcode::OP_SetLevelFieldVariableField = var_11[0] * opcode::OP_ScriptFarMethodThreadCall;
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", "flex_across_start");
    opcode::OP_CastBool = removezfromvec(getmovedelta(var_0D, var_0F[0], var_11[0]));
    opcode::OP_EvalNewLocalArrayRefCached0 = distance2d(self.origin, var_5);
    opcode::OP_CallBuiltinPointer = getmovedelta(var_0D, var_0F[0], 1);
    opcode::OP_inequality = length2d(opcode::OP_CallBuiltinPointer);
    opcode::OP_GetThisthread = opcode::OP_EvalNewLocalArrayRefCached0 - opcode::OP_inequality;
    opcode::OP_ClearFieldVariable = length2d(opcode::OP_CastBool);
    if(opcode::OP_ClearFieldVariable < 0.01) {
      opcode::OP_ClearFieldVariable = 1;
    }

    opcode::OP_GetFloat = opcode::OP_GetThisthread + opcode::OP_ClearFieldVariable / opcode::OP_ClearFieldVariable;
    self scragentsetanimscale(opcode::OP_GetFloat, 0);
    childthread traverse_lerp_z_over_time_dlc1(var_4.origin[2], var_5[2], opcode::OP_SetLevelFieldVariableField - opcode::OP_JumpOnTrueExpr / self.traverseratescale);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", "flex_across_end");
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
  } else if(var_8[2] > 16) {
    if(opcode::OP_CallBuiltin1[2] > 0) {
      if(var_0C) {
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        opcode::OP_SafeCreateVariableFieldCached = clamp(2 / var_1C.var_3A6, 0.5, 1);
        if(var_11.size > 0) {
          scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, opcode::OP_SafeCreateVariableFieldCached * self.traverseratescale, "traverse", var_10);
          scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
          scripts\mp\agents\_scriptedagents::func_F2B1(var_6, var_7, self.traverseratescale);
          scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
        } else {
          scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
        }

        self scragentsetanimscale(1, 1);
      } else if(var_0F.size > 0) {
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        if(!opcode::OP_CallBuiltin3 && length2dsquared(var_9) < 0.64 * length2dsquared(opcode::OP_CallBuiltin1)) {
          var_1C.var_13E2B = 0.4;
        }

        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", var_0E);
        opcode::OP_ScriptFarFunctionCall2 = getmovedelta(var_0D, 0, var_0F[0]);
        opcode::OP_ScriptFarFunctionCall = getmovedelta(var_0D, 0, var_11[0]);
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        opcode::OP_ScriptFarChildThreadCall = var_5 - self.origin;
        opcode::OP_ClearLocalVariableFieldCached0 = opcode::OP_CallBuiltin1 - opcode::OP_ScriptFarFunctionCall2;
        if(!opcode::OP_CallBuiltin3 && length2dsquared(opcode::OP_ScriptFarChildThreadCall) < 0.5625 * length2dsquared(opcode::OP_ClearLocalVariableFieldCached0)) {
          var_1C.var_13E2B = 0.75;
        }

        opcode::OP_ClearLocalVariableFieldCached = opcode::OP_CallBuiltin1 - opcode::OP_ScriptFarFunctionCall;
        opcode::OP_checkclearparams = (opcode::OP_ClearLocalVariableFieldCached[0] * var_1C.var_13E2B, opcode::OP_ClearLocalVariableFieldCached[1] * var_1C.var_13E2B, opcode::OP_ClearLocalVariableFieldCached[2] * var_1C.var_3A6);
        opcode::OP_CastFieldObject = rotatevector(opcode::OP_checkclearparams, var_0A);
        opcode::OP_End = var_5 - opcode::OP_CastFieldObject;
        opcode::OP_size = opcode::OP_ScriptFarFunctionCall - opcode::OP_ScriptFarFunctionCall2;
        opcode::OP_EmptyArray = rotatevector(opcode::OP_size, var_0A);
        opcode::OP_bit_and = opcode::OP_End - self.origin;
        opcode::OP_less_equal = opcode::OP_CallBuiltin2;
        opcode::OP_CallBuiltin2 = scripts\mp\agents\_scriptedagents::func_7DC9(opcode::OP_bit_and, opcode::OP_EmptyArray, 1);
        if(opcode::OP_CallBuiltin3) {
          var_1C.var_13E2B = 1;
        }

        if(opcode::OP_bit_and[2] <= 0) {
          var_1C.var_3A6 = 0;
        }

        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", var_10);
        scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
        opcode::OP_CallBuiltin2 = opcode::OP_less_equal;
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
      } else {
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
      }
    } else {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6, var_7, var_0D, "traverse", "flex_height_start", "flex_height_end", 1, ::zombietraversenotetrackhandler_dlc1);
    }
  } else if(abs(var_8[2]) < 16 || opcode::OP_CallBuiltin1[2] == 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    opcode::OP_SafeCreateVariableFieldCached = clamp(2 / var_1C.var_3A6, 0.5, 1);
    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, opcode::OP_SafeCreateVariableFieldCached * self.traverseratescale, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      scripts\mp\agents\_scriptedagents::func_F2B1(var_6, var_7, self.traverseratescale);
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
    }

    self scragentsetanimscale(1, 1);
  } else if(opcode::OP_CallBuiltin1[2] < 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    opcode::OP_SafeCreateVariableFieldCached = clamp(2 / var_1C.var_3A6, 0.5, 1);
    if(var_0F.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", var_0E);
    }

    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, opcode::OP_SafeCreateVariableFieldCached * 1, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::func_F2B1(var_6, var_7, self.traverseratescale);
      if(animhasnotetrack(var_0D, "removestatelock")) {
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", "removestatelock");
      }

      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, 1, "traverse");
    }

    self scragentsetanimscale(1, 1);
  }

  lerptoabovegrounddlc1();
  self gib_fx_override("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  terminatetraverse_dlc1(var_0, var_1);
}

lerptoabovegrounddlc1() {
  var_0 = 0.1;
  var_1 = self.var_6378;
  var_2 = var_1[2];
  var_3 = self.origin[2];
  if(var_3 < var_2) {
    self setorigin((self.origin[0], self.origin[1], var_2 + var_0), 0);
  }
}

terminatetraverse_dlc1(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isDefined(var_2.var_116FB)) {
    if(isarray(var_2.var_116FB[0])) {
      var_3 = var_2.var_116FB[0];
    } else {
      var_3 = var_2.var_116FB;
    }
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_2, var_2.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

traverse_lerp_z_over_time_dlc1(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = gettime();
  for(;;) {
    var_4 = gettime() - var_3 / 1000;
    var_5 = var_4 / var_2;
    if(var_5 > 1) {
      break;
    }

    var_6 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_5, var_0, var_1);
    self setorigin((self.origin[0], self.origin[1], var_6), 0);
    wait(0.05);
  }
}

needscrawlinganimstate_dlc1(var_0) {
  if(self.dismember_crawl) {
    return 1;
  }

  return 0;
}

zombietraversenotetrackhandler_dlc1(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "apply_physics":
      self gib_fx_override("gravity");
      break;

    default:
      break;
  }
}

choosestandingdeathanim_dlc1(var_0, var_1, var_2, var_3) {
  return lib_0C71::func_3F00(var_0, var_1, var_2, var_3);
}

choosemovingdeathanim_dlc1(var_0, var_1, var_2) {
  return lib_0C71::func_3EE2(var_0, var_1, var_2);
}

chooseballoongrabanim(var_0, var_1, var_2) {
  if(scripts\asm\zombie\zombie::func_BE92()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "prone");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
}

handleballoonfloating() {
  self endon("death");
  wait(randomfloatrange(5, 5.9));
  self notify("reached_end");
  self unlink();
  self setvelocity((randomintrange(-10, 10), randomintrange(-10, 10), -50));
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  playFX(level._effect["balloon_death"], self.balloon_in_hand.origin + (0, 0, 50));
  playsoundatpos(self.origin, "craftable_balloon_zmb_explo");
  self dodamage(self.health + 100, self.origin, undefined, undefined, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
}

balloongrabnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "balloon_attach") {
    var_4 = ["decor_balloon_a_blue", "decor_balloon_a_blue_light", "decor_balloon_a_cyan", "decor_balloon_a_green", "decor_balloon_a_green_light", "decor_balloon_a_orange", "decor_balloon_a_pink", "decor_balloon_a_purple", "decor_balloon_a_purple_deep", "decor_balloon_a_red", "decor_balloon_a_yellow"];
    var_5 = self gettagorigin("j_shoulder_ri");
    self.balloon_in_hand = spawn("script_model", var_5);
    self.balloon_model = scripts\engine\utility::random(var_4);
    if(self.bholdingballooninleft) {
      self attach(self.balloon_model, "tag_accessory_left");
    } else {
      self attach(self.balloon_model, "tag_accessory_right");
    }

    self.balloon_in_hand.origin = var_5;
    self linkto(self.balloon_in_hand);
    self playerlinkedoffsetenable();
    var_6 = randomintrange(-50, 50);
    var_7 = randomintrange(-50, 50);
    self.balloon_in_hand moveto(self.origin + (var_6, var_7, self.detonate_height), 6, 3);
    self.balloon_in_hand rotateyaw(randomint(360), 6);
    thread handleballoonfloating();
  }
}

chooseballoonfloatanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.bholdingballooninleft)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
}

shouldballoongrableft(var_0, var_1, var_2, var_3) {
  self.bholdingballooninleft = undefined;
  if(lib_0C72::func_9EA5()) {
    self.bholdingballooninleft = 1;
  } else if(randomintrange(0, 100) < 50) {
    self.bholdingballooninleft = 1;
  } else {
    self.bholdingballooninleft = 0;
  }

  return self.bholdingballooninleft;
}

isdismembermentdisabled(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.var_55CF)) {
    return 1;
  }

  return 0;
}