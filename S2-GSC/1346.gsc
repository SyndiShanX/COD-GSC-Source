/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1346.gsc
*********************************************/

lib_0542::func_5329() {
  initpairedmeleealignmenthelper();
  lib_0542::func_52C1();
  level.var_6DF8 = [];
  var_00 = getEntArray("paired_melee_clip", "targetname");
  foreach(var_02 in var_00) {
    level.var_6DF8[var_02.var_81E1] = var_02;
    var_03 = getEntArray(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      if(isDefined(var_05.var_0165)) {
        switch (var_05.var_0165) {
          case "clip_old":
            var_05 notsolid();
            var_05 linkto(var_02);
            var_05 method_805C();
            break;

          case "clip_vis":
            var_05 notsolid();
            var_02.var_A55B = var_05;
            var_05 method_805C();
            var_05 linkto(var_02);
            break;

          case "clip":
            var_02.var_4033 = var_05;
            var_05 linkto(var_02);
            break;
        }
      }
    }

    var_02.var_6C4E = var_02.var_0116;
    var_02.var_6C48 = var_02.var_001D;
  }

  setdvarifuninitialized("paired_death_debug", 0);
  setdvarifuninitialized("cancel_anim_delta", 1);
  setdvarifuninitialized("paired_death_clip", 1);
  setdvarifuninitialized("paired_death_obstacle", 0);
  setdvarifuninitialized("paired_death_obstacle_ent", 1);
  setdvarifuninitialized("paired_death_validate_navmesh", 1);
  setdvarifuninitialized("paried_death_block_length_offset", 30);
  setdvarifuninitialized("paired_death_block_h_length", 30);
  setdvarifuninitialized("paired_death_block_h_width", 15);
  setdvarifuninitialized("paired_death_block_nav_dist", 12);
}

initpairedmeleealignmenthelper() {
  level.paired_melee_model = spawn("script_model", (0, 0, 0));
  level.paired_melee_model common_scripts\utility::func_4CEB();
  level.paired_melee_model setModel("tag_sync");
}

solvepairedmeleefatalpositioning(param_00) {
  if(isDefined(param_00["fatal_worldmodel_anim"])) {
    level.paired_melee_model scriptmodelplayanim(param_00["fatal_worldmodel_anim"], "meleeAlign", 0.5);
    level.paired_melee_model scriptmodelpauseanim(1);
    var_01 = level.paired_melee_model gettagorigin("TAG_SYNC", 0);
    param_00["fatal_zombie_pos"] = (var_01[0], var_01[1], 0);
    param_00["fatal_zombie_dist"] = length(param_00["fatal_zombie_pos"]);
  }

  return param_00;
}

lib_0542::func_52C1() {
  if(!isDefined(level.var_6DF9)) {
    level.var_6DF9 = [];
  }

  var_00 = [];
  var_00[16]["noGib"] = 1;
  level.var_4BEC["zom_head_fdr02_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_02";
  level.var_4BEC["zom_head_fdr02_org1"]["default"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_head_fdr03_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_03";
  level.var_4BEC["zom_head_fdr03_org1"]["default"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_head_fdr04_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_04";
  level.var_4BEC["zom_head_fdr04_org1"]["default"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_head_fdr02_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_02";
  level.var_4BEC["zom_head_fdr02_org1"]["heavy"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_head_fdr03_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_03";
  level.var_4BEC["zom_head_fdr03_org1"]["heavy"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_head_fdr04_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_04";
  level.var_4BEC["zom_head_fdr04_org1"]["heavy"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_sprinter_head"]["default"]["torsoFX"] = "torso_loss_head_p_melee_spr_01";
  level.var_4BEC["zom_sprinter_head"]["default"]["fxTagName"] = "j_neck";
  level.var_4BEC["zom_sprinter_head"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_spr_01";
  level.var_4BEC["zom_sprinter_head"]["heavy"]["fxTagName"] = "j_neck";
  var_01 = (34.222, -0.23, 0);
  var_02 = length(var_01);
  level.var_6DF9["default"]["shovel_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level.var_6DF9["default"]["shovel_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level.var_6DF9["default"]["shovel_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level.var_6DF9["default"]["shovel_zm"]["fatal_zombie_action"] = "death_melee_shovel_zm";
  level.var_6DF9["default"]["shovel_zm"]["dismemberment_override"] = var_00;
  level.var_6DF9["default"]["shovel_zm"]["fatal_zombie_pos"] = var_01;
  level.var_6DF9["default"]["shovel_zm"]["fatal_zombie_dist"] = var_02;
  level.var_6DF9["heavy"]["shovel_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level.var_6DF9["heavy"]["shovel_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level.var_6DF9["heavy"]["shovel_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level.var_6DF9["heavy"]["shovel_zm"]["fatal_zombie_action"] = "death_melee_heavy_shovel_zm";
  level.var_6DF9["heavy"]["shovel_zm"]["dismemberment_override"] = var_00;
  level.var_6DF9["heavy"]["shovel_zm"]["fatal_zombie_pos"] = var_01;
  level.var_6DF9["heavy"]["shovel_zm"]["fatal_zombie_dist"] = var_02;
  level.var_6DF9["heavy"]["shovel_zm"]["no_flinch_time"] = 4;
}

lib_0542::func_457F(param_00, param_01) {
  var_02 = param_01 getentitynumber();
  var_03 = level.var_6DF8[var_02];
  return var_03;
}

attemptheavymeleekill(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!param_00 method_864D(param_02) || !param_02 method_8661() || !param_02 lib_0547::func_1F54(param_00, param_05)) {
    return 0;
  }

  var_0A = (34, 8, 0);
  var_0B = 24;
  var_0C = 21;
  var_0D = rotatevector(var_0A, param_02.var_001D);
  var_0E = getgroundposition(param_02.var_0116 + var_0D, var_0B, 64, 64, 0);
  if(!isDefined(var_0E) || abs(var_0E[2] - param_02.var_0116[2]) > var_0C) {
    return 0;
  }

  return 1;
}

lib_0542::func_4ADD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = 1;
  wait(0);
  if(!isDefined(param_00) || !isDefined(param_05)) {
    return;
  }

  param_00 thread lib_0542::func_4AB2(param_00, param_01, param_02, var_0B, param_03, param_05, param_08);
  var_0B = 1;
  var_0C = getanimlength(param_02);
  var_0D = common_scripts\utility::func_A2BE();
  var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(param_02, "melee_stop_pairing", 1) * var_0C - param_03;
  var_0E = max(0, var_0E);
  var_0F = 0;
  if(var_0F) {
    var_10 = spawn("script_model", param_05.var_0116 + anglesToForward(param_05.var_001D) * 1);
    var_10 setModel(param_05.var_0106);
    var_10.var_001D = param_05.var_001D;
    var_10 scriptmodelplayanim(param_01["fatal_worldmodel_anim"], "actually play this anim please", max(0, param_03));
    var_10 scriptmodelplayanim(param_01["fatal_worldmodel_anim"], "actually play this anim please", 0);
    var_11 = var_10 gettagorigin("tag_sync");
    thread lib_0542::func_4AB1(param_00, param_05, var_0E, var_11);
    var_12 = 0;
    while(var_12 < var_0C && isDefined(param_00)) {
      if(!isDefined(param_00) || !isDefined(param_05)) {
        break;
      }

      var_13 = param_03 + var_12;
      var_10 scriptmodelclearanim();
      var_10 scriptmodelplayanim(param_01["fatal_worldmodel_anim"], "actually play this anim please", max(0, var_13));
      param_00.var_0116 = var_10 gettagorigin("tag_sync");
      param_00.var_001D = var_10 gettagangles("tag_sync");
      wait 0.05;
      var_12 = var_12 + 0.05;
    }

    var_10 delete();
    return;
  }

  var_14 = param_01["fatal_zombie_pos"];
  var_15 = param_01["fatal_zombie_dist"];
  var_18 = anglesToForward(param_05.var_001D) * var_14[0] + anglestoright(param_05.var_001D) * var_14[1];
  var_19 = param_05.var_001D + (0, 180, 0);
  var_1A = getgroundposition(param_05.var_0116 + var_18, 16);
  var_1B = vectornormalize(var_1A - param_05.var_0116);
  var_1C = param_05.var_0116 + var_1B * var_15;
  var_1D = gettime() * 0.001 + param_03;
  var_1E = 0.2;
  var_1F = "fatal_zombie_snd";
  if(param_05 method_8661() && !common_scripts\utility::func_562E(self.var_0103)) {
    var_1F = "hit_zombie_snd";
  }

  if(isDefined(param_01[var_1F])) {
    var_20 = spawnStruct();
    var_20.var_721C = param_05;
    var_20.var_ABE6 = var_1C;
    var_20.var_4DCF = param_0A;
    var_20.var_60B8 = param_07;
    var_20.var_01D0 = param_08;
    var_20.delaysec = param_03;
    if(var_1F == "fatal_zombie_snd" && isDefined(param_01["fatal_zombie_snd_delay"])) {
      var_20.delaysec = var_20.delaysec + param_01["fatal_zombie_snd_delay"];
    }

    param_00 lib_0378::func_8D74(param_01[var_1F], var_20);
  }

  thread lib_0542::func_4AB1(param_00, param_05, var_0E, var_1C);
  var_21 = common_scripts\utility::func_562E(param_00.too_far_for_melee_pairing);
  if(!var_21) {
    param_00 thread lib_0542::func_2678(param_02, 0, var_0B, var_1D, var_1C, var_19, var_1E);
  }
}

lib_0542::func_2678(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self endon("entityDeleted");
  level notify("paired_death_lerp_start");
  var_07 = getanimlength(param_00);
  var_08 = self.var_0116;
  var_09 = self.var_001D;
  var_0A = gettime();
  var_0B = var_08;
  if(getdvarint("paired_death_debug", 0)) {
    thread maps\mp\_utility::func_33C0(var_0B, param_04, (1, 0, 0), "paired_death_lerp_start");
  }

  var_0C = var_0A;
  var_0D = 0;
  while(var_0D <= 1) {
    if(getdvarint("paired_death_debug", 0)) {
      thread maps\mp\_utility::func_33C0(var_0B, self.var_0116, (0, 1, 0), "paired_death_lerp_start");
    }

    var_0E = var_0C * 0.001 - param_03 * param_02;
    if(common_scripts\utility::func_562E(param_01)) {
      var_0F = common_scripts\utility::func_627D(var_0E, var_07) / var_07;
    } else {
      var_0F = clamp(var_0E / var_07, 0, 1);
    }

    var_10 = common_scripts\utility::func_A2BE();
    if(!getdvarint("cancel_anim_delta", 0)) {
      var_10 = getmovedelta(param_00, 0, var_0F);
    }

    var_11 = getangledelta(param_00, 0, var_0F);
    var_12 = transformmove(param_04, param_05, common_scripts\utility::func_A2BE(), common_scripts\utility::func_A2BE(), var_10, (0, var_11, 0));
    var_0D = var_0C - var_0A * 0.001 / param_06;
    var_13 = min(var_0D, 1);
    self.var_0116 = vectorlerp(var_08, var_12["origin"], var_13);
    self.var_001D = angleslerp(var_09, var_12["angles"], var_13);
    if(getdvarint("paired_death_debug", 0)) {
      thread maps\mp\_utility::func_33C0(var_0B, self.var_0116, (0, 0, 1), "paired_death_lerp_start");
    }

    var_0B = self.var_0116;
    wait 0.05;
    var_0C = gettime();
  }
}

lib_0542::func_4AB1(param_00, param_01, param_02, param_03) {
  var_04 = "heavyMeleeCorpseBlocker";
  level notify(var_04);
  if(getdvarint("paired_death_clip", 0) == 0) {
    return;
  }

  if(getdvarint("paired_death_debug", 0)) {
    wait(0);
  }

  var_05 = getdvarint("paried_death_block_length_offset", 30);
  var_06 = getdvarint("paired_death_block_h_length", 30);
  var_07 = getdvarint("paired_death_block_h_width", 15);
  var_08 = param_01.var_0116 - param_03;
  var_09 = vectortoangles(var_08);
  var_0A = lib_0542::func_457F(param_00, param_01);
  if(!isDefined(var_0A)) {
    return;
  }

  var_0A.var_0116 = param_03;
  var_0A.var_001D = (0, var_09[1], 0);
  var_0A method_808C();
  var_0B = getdvarint("paired_death_obstacle", 0);
  if(var_0B) {
    var_0C = undefined;
    if(getdvarint("paired_death_obstacle_ent", 0)) {
      wait 0.05;
      var_0C = function_02E3(var_0A.var_4033);
    } else {
      var_0D = param_03 + vectornormalize(var_08) * var_05;
      var_0C = function_02E2(var_0D, (var_06, var_07, 100), var_09);
    }

    level.var_08CE[var_04] = var_0C;
  }

  if(getdvarint("paired_death_debug", 0)) {
    maps\mp\_utility::func_33C0(var_04, var_04 + (0, 0, 100), (1, 0, 0), var_05);
  }

  wait(param_03);
  if(getdvarint("paired_death_debug", 0)) {
    level waittill("blockerName");
  }

  if(var_0C) {
    if(isDefined(level.var_08CE) && isDefined(level.var_08CE[var_05])) {
      function_02E4(level.var_08CE[var_05]);
    }
  }

  var_0B.var_0116 = var_0B.var_6C4E;
  var_0B.var_001D = var_0B.var_6C48;
  var_0B method_808C();
}

lib_0542::func_4AB2(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 endon("entitydeleted");
  if(!animhasnotetrack(param_02, "dismember_head")) {
    return;
  }

  var_07 = lib_0547::func_4584(param_06, param_05);
  var_08 = var_07[0];
  var_09 = var_07[1];
  var_0A = maps\mp\agents\_scripted_agent_anim_util::func_45B9(param_02, "dismember_head");
  if(!isDefined(var_0A)) {
    return;
  }

  if(isDefined(param_01["dismemberment_override"])) {
    param_00.var_2FE3 = param_01["dismemberment_override"];
    if(isDefined(var_08)) {
      var_0B = lib_0547::func_4744(16);
      if(isDefined(var_0B) && isDefined(level.var_4BEC[var_0B])) {
        var_0C = level.var_4BEC[var_0B][var_08];
        if(isDefined(var_0C)) {
          param_00.var_2FE3[16]["torsoFX"] = var_0C["torsoFX"];
          param_00.var_2FE3[16]["fxTagName"] = var_0C["fxTagName"];
        }
      }
    }
  }

  var_0D = getanimlength(param_02);
  var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(param_02, "helmet_pop", -1);
  if(var_0E >= 0) {
    var_0F = var_0E * var_0D / param_03 - param_04;
    if(var_0F < 0) {
      var_0F = 0;
    }

    thread lib_0541::func_AC26(anglestoright(self.var_001D) + anglestoup(self.var_001D), var_0F);
  }

  var_10 = max(0, var_0D * var_0A / param_03 - param_04);
  wait(var_10);
  var_11 = 16;
  param_00 lib_0541::func_65D0(var_11, 1, 1, anglesToForward(param_00.var_001D) * -1, 1);
  lib_054D::func_90B0(param_00, var_11);
}

onplayerheavymeleekillstart(param_00, param_01) {
  thread hackhandleflinching(param_01);
  thread handlethirdpersonalignment();
}

handlethirdpersonalignment() {
  self endon("paired_heavy_melee_kill");
  self endon("disconnect");
  self method_85C9(1);
  while(self method_8661()) {
    wait 0.05;
  }

  self method_85C9(0);
}

hackhandleflinching(param_00) {
  self endon("paired_heavy_melee_kill");
  self endon("disconnect");
  var_01 = maps\mp\agents\humanoid\_humanoid::func_45FB(param_00, self);
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01["no_flinch_time"];
  if(!isDefined(var_02) || var_02 <= 0) {
    return;
  }

  if(!isDefined(self.premeleeflinchscale)) {
    self.premeleeflinchscale = self getviewkickscale();
  }

  self setviewkickscale(0);
  wait(var_02);
  self setviewkickscale(self.premeleeflinchscale);
  self.premeleeflinchscale = undefined;
}

set_invalid_melee_pairing_reason(param_00, param_01) {
  var_02 = self;
  if(!isDefined(var_02.invalidmeleepairingreasons)) {
    var_02.invalidmeleepairingreasons = [];
  }

  if(common_scripts\utility::func_562E(param_01)) {
    var_02.invalidmeleepairingreasons[param_00] = 1;
  } else {
    var_02.invalidmeleepairingreasons[param_00] = undefined;
  }

  var_03 = var_02.invalidmeleepairingreasons.size == 0;
  var_02 setexomeleechargevalid(var_03);
}

set_zombie_too_far_for_pairing(param_00) {
  var_01 = self;
  var_02 = param_00 getentitynumber();
  var_01 set_invalid_melee_pairing_reason("melee_too_far_" + var_02, 1);
  var_01.too_far_for_melee_pairing = 1;
  var_01 thread zombie_too_far_for_pairing_cleanup(param_00, var_02);
}

zombie_too_far_for_pairing_cleanup(param_00, param_01) {
  var_02 = self;
  if(!isalive(var_02)) {
    return;
  }

  var_02 endon("death");
  var_02 endon("zombie_too_far_for_pairing_cleanup_" + param_01);
  if(isPlayer(param_00)) {
    var_02 thread zombie_too_far_watch_player_disconnect(param_00, param_01);
  }

  for(;;) {
    wait 0.05;
    if(!isDefined(param_00)) {
      break;
    }

    if(!var_02 method_864D(param_00)) {
      break;
    }
  }

  var_02 thread zombie_too_far_for_pairing_cleanup_internal(param_00, param_01);
}

zombie_too_far_for_pairing_cleanup_internal(param_00, param_01) {
  var_02 = self;
  var_02.too_far_for_melee_pairing = undefined;
  var_02 set_invalid_melee_pairing_reason("melee_too_far_" + param_01, 0);
  var_02 notify("zombie_too_far_for_pairing_cleanup_" + param_01);
}

zombie_too_far_watch_player_disconnect(param_00, param_01) {
  var_02 = self;
  var_02 endon("zombie_too_far_for_pairing_cleanup_" + param_01);
  var_02 endon("death");
  param_00 waittill("disconnect");
  var_02 thread zombie_too_far_for_pairing_cleanup_internal(param_00);
}