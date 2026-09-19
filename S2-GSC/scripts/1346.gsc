/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1346.gsc
**************************************/

_id_5329() {
  initpairedmeleealignmenthelper();
  _id_52C1();
  level._id_6DF8 = [];
  var_0 = getEntArray("paired_melee_clip", "targetname");

  foreach(var_2 in var_0) {
    level._id_6DF8[var_2._id_81E1] = var_2;
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(isDefined(var_5._id_0165)) {
        switch (var_5._id_0165) {
          case "clip_old":
            var_5 _meth_82C2();
            var_5 _meth_8055(var_2);
            var_5 _meth_805C();
            break;
          case "clip_vis":
            var_5 _meth_82C2();
            var_2._id_A55B = var_5;
            var_5 _meth_805C();
            var_5 _meth_8055(var_2);
            break;
          case "clip":
            var_2._id_4033 = var_5;
            var_5 _meth_8055(var_2);
            break;
        }
      }
    }

    var_2._id_6C4E = var_2.origin;
    var_2._id_6C48 = var_2.angles;
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
  level.paired_melee_model common_scripts\utility::_id_4CEB();
  level.paired_melee_model setModel("tag_sync");
}

solvepairedmeleefatalpositioning(var_0) {
  if(isDefined(var_0["fatal_worldmodel_anim"])) {
    level.paired_melee_model _meth_8276(var_0["fatal_worldmodel_anim"], "meleeAlign", 0.5);
    level.paired_melee_model _meth_84CA(1);
    var_1 = level.paired_melee_model gettagorigin("TAG_SYNC", 0);
    var_0["fatal_zombie_pos"] = (var_1[0], var_1[1], 0);
    var_0["fatal_zombie_dist"] = length(var_0["fatal_zombie_pos"]);
  }

  return var_0;
}

_id_52C1() {
  if(!isDefined(level._id_6DF9))
    level._id_6DF9 = [];

  var_0 = [];
  var_0[16]["noGib"] = 1;
  level._id_4BEC["zom_head_fdr02_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_02";
  level._id_4BEC["zom_head_fdr02_org1"]["default"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_head_fdr03_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_03";
  level._id_4BEC["zom_head_fdr03_org1"]["default"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_head_fdr04_org1"]["default"]["torsoFX"] = "torso_head_loss_p_melee_fdr_04";
  level._id_4BEC["zom_head_fdr04_org1"]["default"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_head_fdr02_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_02";
  level._id_4BEC["zom_head_fdr02_org1"]["heavy"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_head_fdr03_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_03";
  level._id_4BEC["zom_head_fdr03_org1"]["heavy"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_head_fdr04_org1"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_fdr_04";
  level._id_4BEC["zom_head_fdr04_org1"]["heavy"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_sprinter_head"]["default"]["torsoFX"] = "torso_loss_head_p_melee_spr_01";
  level._id_4BEC["zom_sprinter_head"]["default"]["fxTagName"] = "j_neck";
  level._id_4BEC["zom_sprinter_head"]["heavy"]["torsoFX"] = "zmb_paired_melee_head_pop_spr_01";
  level._id_4BEC["zom_sprinter_head"]["heavy"]["fxTagName"] = "j_neck";
  var_1 = (34.222, -0.23, 0);
  var_2 = length(var_1);
  level._id_6DF9["default"]["shovel_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level._id_6DF9["default"]["shovel_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level._id_6DF9["default"]["shovel_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level._id_6DF9["default"]["shovel_zm"]["fatal_zombie_action"] = "death_melee_shovel_zm";
  level._id_6DF9["default"]["shovel_zm"]["dismemberment_override"] = var_0;
  level._id_6DF9["default"]["shovel_zm"]["fatal_zombie_pos"] = var_1;
  level._id_6DF9["default"]["shovel_zm"]["fatal_zombie_dist"] = var_2;
  level._id_6DF9["heavy"]["shovel_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level._id_6DF9["heavy"]["shovel_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level._id_6DF9["heavy"]["shovel_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level._id_6DF9["heavy"]["shovel_zm"]["fatal_zombie_action"] = "death_melee_heavy_shovel_zm";
  level._id_6DF9["heavy"]["shovel_zm"]["dismemberment_override"] = var_0;
  level._id_6DF9["heavy"]["shovel_zm"]["fatal_zombie_pos"] = var_1;
  level._id_6DF9["heavy"]["shovel_zm"]["fatal_zombie_dist"] = var_2;
  level._id_6DF9["heavy"]["shovel_zm"]["no_flinch_time"] = 4;
}

_id_457F(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = level._id_6DF8[var_2];
  return var_3;
}

attemptheavymeleekill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!var_0 _meth_864D(var_2) || !var_2 _meth_8661() || !var_2 _id_0547::_id_1F54(var_0, var_5))
    return 0;

  var_10 = (34, 8, 0);
  var_11 = 24;
  var_12 = 21;
  var_13 = _func_112(var_10, var_2.angles);
  var_14 = _func_082(var_2.origin + var_13, var_11, 64, 64, 0);

  if(!isDefined(var_14) || _func_0AE(var_14[2] - var_2.origin[2]) > var_12)
    return 0;

  return 1;
}

_id_4ADD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = 1;
  wait 0;

  if(!isDefined(var_0) || !isDefined(var_5)) {
    return;
  }
  var_0 thread _id_4AB2(var_0, var_1, var_2, var_11, var_3, var_5, var_8);
  var_11 = 1;
  var_12 = _func_065(var_2);
  var_13 = common_scripts\utility::_id_A2BE();
  var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_2, "melee_stop_pairing", 1.0) * var_12 - var_3;
  var_14 = max(0, var_14);
  var_15 = 0;

  if(var_15) {
    var_16 = spawn("script_model", var_5.origin + anglesToForward(var_5.angles) * 1);
    var_16 setModel(var_5.model);
    var_16.angles = var_5.angles;
    var_16 _meth_8276(var_1["fatal_worldmodel_anim"], "actually play this anim please", max(0, var_3));
    var_16 _meth_8276(var_1["fatal_worldmodel_anim"], "actually play this anim please", 0);
    var_17 = var_16 gettagorigin("tag_sync");
    thread _id_4AB1(var_0, var_5, var_14, var_17);

    for(var_18 = 0; var_18 < var_12 && isDefined(var_0); var_18 = var_18 + 0.05) {
      if(!isDefined(var_0) || !isDefined(var_5)) {
        break;
      }

      var_19 = var_3 + var_18;
      var_16 _meth_8277();
      var_16 _meth_8276(var_1["fatal_worldmodel_anim"], "actually play this anim please", max(0, var_19));
      var_0.origin = var_16 gettagorigin("tag_sync");
      var_0.angles = var_16 _meth_8181("tag_sync");
      waitframe();
    }

    var_16 delete();
  } else {
    var_20 = var_1["fatal_zombie_pos"];
    var_21 = var_1["fatal_zombie_dist"];
    var_24 = anglesToForward(var_5.angles) * var_20[0] + anglestoright(var_5.angles) * var_20[1];
    var_25 = var_5.angles + (0, 180, 0);
    var_26 = _func_082(var_5.origin + var_24, 16);
    var_27 = vectorNormalize(var_26 - var_5.origin);
    var_28 = var_5.origin + var_27 * var_21;
    var_29 = gettime() * 0.001 + var_3;
    var_30 = 0.2;
    var_31 = "fatal_zombie_snd";

    if(var_5 _meth_8661() && !common_scripts\utility::_id_562E(self._id_0103))
      var_31 = "hit_zombie_snd";

    if(isDefined(var_1[var_31])) {
      var_32 = spawnStruct();
      var_32.player = var_5;
      var_32._id_ABE6 = var_28;
      var_32._id_4DCF = var_10;
      var_32._id_60B8 = var_7;
      var_32._id_01D0 = var_8;
      var_32.delaysec = var_3;

      if(var_31 == "fatal_zombie_snd" && isDefined(var_1["fatal_zombie_snd_delay"]))
        var_32.delaysec = var_32.delaysec + var_1["fatal_zombie_snd_delay"];

      var_0 _id_0378::_id_8D74(var_1[var_31], var_32);
    }

    thread _id_4AB1(var_0, var_5, var_14, var_28);
    var_33 = common_scripts\utility::_id_562E(var_0.too_far_for_melee_pairing);

    if(!var_33)
      var_0 thread _id_2678(var_2, 0, var_11, var_29, var_28, var_25, var_30);
  }
}

_id_2678(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("entityDeleted");
  level notify("paired_death_lerp_start");
  var_7 = _func_065(var_0);
  var_8 = self.origin;
  var_9 = self.angles;
  var_10 = gettime();
  var_11 = var_8;

  if(getdvarint("paired_death_debug", 0))
    thread maps\mp\_utility::_id_33C0(var_11, var_4, (1, 0, 0), "paired_death_lerp_start");

  var_12 = var_10;

  for(var_13 = 0; var_13 <= 1.0; var_12 = gettime()) {
    if(getdvarint("paired_death_debug", 0))
      thread maps\mp\_utility::_id_33C0(var_11, self.origin, (0, 1, 0), "paired_death_lerp_start");

    var_14 = var_12 * 0.001 - var_3 * var_2;

    if(common_scripts\utility::_id_562E(var_1))
      var_15 = common_scripts\utility::_id_627D(var_14, var_7) / var_7;
    else
      var_15 = clamp(var_14 / var_7, 0, 1);

    var_16 = common_scripts\utility::_id_A2BE();

    if(!getdvarint("cancel_anim_delta", 0))
      var_16 = _func_083(var_0, 0, var_15);

    var_17 = _func_084(var_0, 0, var_15);
    var_18 = _func_111(var_4, var_5, common_scripts\utility::_id_A2BE(), common_scripts\utility::_id_A2BE(), var_16, (0, var_17, 0));
    var_13 = (var_12 - var_10) * 0.001 / var_6;
    var_19 = _func_0AF(var_13, 1.0);
    self.origin = _func_10A(var_8, var_18["origin"], var_19);
    self.angles = _func_10B(var_9, var_18["angles"], var_19);

    if(getdvarint("paired_death_debug", 0))
      thread maps\mp\_utility::_id_33C0(var_11, self.origin, (0, 0, 1), "paired_death_lerp_start");

    var_11 = self.origin;
    waitframe();
  }
}

_id_4AB1(var_0, var_1, var_2, var_3) {
  var_4 = "heavyMeleeCorpseBlocker";
  level notify(var_4);

  if(getdvarint("paired_death_clip", 0) == 0) {
    return;
  }
  if(getdvarint("paired_death_debug", 0))
    wait 0;

  var_5 = getdvarint("paried_death_block_length_offset", 30);
  var_6 = getdvarint("paired_death_block_h_length", 30);
  var_7 = getdvarint("paired_death_block_h_width", 15);
  var_8 = var_1.origin - var_3;
  var_9 = vectortoangles(var_8);
  var_10 = _id_457F(var_0, var_1);

  if(!isDefined(var_10)) {
    return;
  }
  var_10.origin = var_3;
  var_10.angles = (0, var_9[1], 0);
  var_10 _meth_808C();
  var_11 = getdvarint("paired_death_obstacle", 0);

  if(var_11) {
    var_12 = undefined;

    if(getdvarint("paired_death_obstacle_ent", 0)) {
      waitframe();
      var_12 = _func_2E3(var_10._id_4033);
    } else {
      var_13 = var_3 + vectorNormalize(var_8) * var_5;
      var_12 = _func_2E2(var_13, (var_6, var_7, 100), var_9);
    }

    level._id_08CE[var_4] = var_12;
  }

  if(getdvarint("paired_death_debug", 0))
    maps\mp\_utility::_id_33C0(var_3, var_3 + (0, 0, 100), (1, 0, 0), var_4);

  wait(var_2);

  if(getdvarint("paired_death_debug", 0))
    level waittill("blockerName");

  if(var_11) {
    if(isDefined(level._id_08CE) && isDefined(level._id_08CE[var_4]))
      _func_2E4(level._id_08CE[var_4]);
  }

  var_10.origin = var_10._id_6C4E;
  var_10.angles = var_10._id_6C48;
  var_10 _meth_808C();
}

_id_4AB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("entitydeleted");

  if(!_func_066(var_2, "dismember_head")) {
    return;
  }
  [var_8, var_9] = _id_0547::_id_4584(var_6, var_5);
  var_10 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_2, "dismember_head");

  if(!isDefined(var_10)) {
    return;
  }
  if(isDefined(var_1["dismemberment_override"])) {
    var_0._id_2FE3 = var_1["dismemberment_override"];

    if(isDefined(var_8)) {
      var_11 = _id_0547::_id_4744(16);

      if(isDefined(var_11) && isDefined(level._id_4BEC[var_11])) {
        var_12 = level._id_4BEC[var_11][var_8];

        if(isDefined(var_12)) {
          var_0._id_2FE3[16]["torsoFX"] = var_12["torsoFX"];
          var_0._id_2FE3[16]["fxTagName"] = var_12["fxTagName"];
        }
      }
    }
  }

  var_13 = _func_065(var_2);
  var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_2, "helmet_pop", -1.0);

  if(var_14 >= 0.0) {
    var_15 = var_14 * var_13 / var_3 - var_4;

    if(var_15 < 0.0)
      var_15 = 0.0;

    thread _id_0541::_id_AC26(anglestoright(self.angles) + anglestoup(self.angles), var_15);
  }

  var_16 = max(0, var_13 * var_10 / var_3 - var_4);
  wait(var_16);
  var_17 = 16;
  var_0 _id_0541::_id_65D0(var_17, 1, 1, anglesToForward(var_0.angles) * -1, 1);
  _id_054D::_id_90B0(var_0, var_17);
}

onplayerheavymeleekillstart(var_0, var_1) {
  thread hackhandleflinching(var_1);
  thread handlethirdpersonalignment();
}

handlethirdpersonalignment() {
  self endon("paired_heavy_melee_kill");
  self endon("disconnect");
  self _meth_85C9(1);

  while(self _meth_8661())
    waitframe();

  self _meth_85C9(0);
}

hackhandleflinching(var_0) {
  self endon("paired_heavy_melee_kill");
  self endon("disconnect");
  var_1 = maps\mp\agents\humanoid\_humanoid::_id_45FB(var_0, self);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1["no_flinch_time"];

  if(!isDefined(var_2) || var_2 <= 0.0) {
    return;
  }
  if(!isDefined(self.premeleeflinchscale))
    self.premeleeflinchscale = self _meth_830F();

  self _meth_830E(0);
  wait(var_2);
  self _meth_830E(self.premeleeflinchscale);
  self.premeleeflinchscale = undefined;
}

set_invalid_melee_pairing_reason(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.invalidmeleepairingreasons))
    var_2.invalidmeleepairingreasons = [];

  if(common_scripts\utility::_id_562E(var_1))
    var_2.invalidmeleepairingreasons[var_0] = 1;
  else
    var_2.invalidmeleepairingreasons[var_0] = undefined;

  var_3 = var_2.invalidmeleepairingreasons.size == 0;
  var_2 _meth_854A(var_3);
}

set_zombie_too_far_for_pairing(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();
  var_1 set_invalid_melee_pairing_reason("melee_too_far_" + var_2, 1);
  var_1.too_far_for_melee_pairing = 1;
  var_1 thread zombie_too_far_for_pairing_cleanup(var_0, var_2);
}

zombie_too_far_for_pairing_cleanup(var_0, var_1) {
  var_2 = self;

  if(!isalive(var_2)) {
    return;
  }
  var_2 endon("death");
  var_2 endon("zombie_too_far_for_pairing_cleanup_" + var_1);

  if(isPlayer(var_0))
    var_2 thread zombie_too_far_watch_player_disconnect(var_0, var_1);

  for(;;) {
    waitframe();

    if(!isDefined(var_0)) {
      break;
    }

    if(!var_2 _meth_864D(var_0)) {
      break;
    }
  }

  var_2 thread zombie_too_far_for_pairing_cleanup_internal(var_0, var_1);
}

zombie_too_far_for_pairing_cleanup_internal(var_0, var_1) {
  var_2 = self;
  var_2.too_far_for_melee_pairing = undefined;
  var_2 set_invalid_melee_pairing_reason("melee_too_far_" + var_1, 0);
  var_2 notify("zombie_too_far_for_pairing_cleanup_" + var_1);
}

zombie_too_far_watch_player_disconnect(var_0, var_1) {
  var_2 = self;
  var_2 endon("zombie_too_far_for_pairing_cleanup_" + var_1);
  var_2 endon("death");
  var_0 waittill("disconnect");
  var_2 thread zombie_too_far_for_pairing_cleanup_internal(var_0);
}