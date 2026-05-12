/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_sizzler.gsc
**********************************************/

func_00D5() {
  level.var_A41["zombie_sizzler"] = level.var_A41["zombie"];
  level.var_A41["zombie_sizzler"]["think"] = ::zombie_sizzler_think;
  level.var_A41["zombie_sizzler"]["move_mode"] = ::zombie_sizzler_move_mode_func;
  level.var_A41["zombie_sizzler"]["post_model"] = ::zombie_sizzler_vfx;
  level.var_A41["zombie_sizzler"]["on_killed"] = ::zombie_sizzler_on_killed;
  level.var_A41["zombie_sizzler"]["get_action_params"] = ::zombiesizzlergetactionparams;
  var_00 = spawnStruct();
  var_00.var_A4B = "zombie_sizzler";
  var_00.var_EAE = "zombie_animclass";
  var_00.var_E88 = "zombie_generic";
  var_00.var_879 = "zombie_generic";
  var_00.var_4C12 = 1;
  var_00.var_60E2 = 40;
  var_00.var_8302 = 65;
  var_00.var_8303 = 15;
  var_00.parenttype = "zombie_generic";
  var_00.suppressive_fire_speed_multiplier = 0.3;
  var_00.tacklebymelee = 1;
  var_00.tacklebycharge = 1;
  var_00.knockbyravensword = 1;
  var_00.shockbyteslablood = 1;
  var_00.energyhold = 1;
  var_00.energyholdsecondary = 1;
  var_00.throwable = 1;
  var_00.var_5ED2["sizzler"]["whole_body"] = "zom_sizzler_body_org1";
  var_00.var_5ED2["sizzler"]["heads"] = ["zom_sizzler_head_org1"];
  lib_0547::func_A52(var_00, "zombie_sizzler");
  lib_0541::func_2F92("crawl", ["zombie_sizzler"]);
  level.numactivesizzlers = 0;
  level.numpendingsizzlers = 0;
  level.maxactivesizzlers = 2;
  common_scripts\utility::func_92C("zmb_sizzler_zombie_smoldering", "vfx/map/mp_zombie_berlin/zmb_sizzler_zombie_smoldering");
  common_scripts\utility::func_92C("zmb_sizzler_head", "vfx/map/mp_zombie_berlin/zmb_sizzler_head");
  common_scripts\utility::func_92C("zmb_sizzler_flames", "vfx/map/mp_zombie_berlin/zmb_sizzler_flames");
  common_scripts\utility::func_92C("zmb_sizzler_mouth", "vfx/map/mp_zombie_berlin/zmb_sizzler_mouth");
}

zombiesizzlergetactionparams() {
  var_00 = lib_054D::func_AC22();
  var_00["script_var"] = "sizzler_dlc2";
  return var_00;
}

zombie_sizzler_think_setup() {
  lib_0566::func_ABB5();
  var_00 = 0.08722223;
  self method_85E0(1);
  self method_85DE(var_00);
  self.var_2FA4 = 0;
  self.cornerlessturnmindegreeoverride = 70;
  self method_85A1("zombie_sizzler");
  self.stuckfortraversalthreshold = 16;
}

zombie_sizzler_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  zombie_sizzler_think_setup();
  for(;;) {
    wait(0.2);
    if(lib_053C::func_4F8C()) {
      continue;
    }

    if(lib_053C::func_4F84()) {
      continue;
    }

    if(lib_053C::func_4F9B()) {
      continue;
    }

    if(lib_053C::func_4F9A()) {
      continue;
    }

    lib_053C::func_647();
  }
}

zombie_sizzler_move_mode_func() {
  self.var_64C2 = 1 * lib_054D::func_4440();
  var_00 = gettime() * 0.001;
  if(isDefined(self.var_92EA) && var_00 - self.var_92EA > 2) {
    return "sprint";
  }

  return "run";
}

zombie_make_sizzler(param_00, param_01) {
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = "stand_change_react";
  var_03 = "s2_zom_sizzler_stand_change_react";
  if(param_01) {
    var_02 = var_02 + "_sky";
    var_03 = var_03 + "_sky";
    var_04 = "J_SpineUpper";
  } else {
    var_04 = "J_SpineLower";
  }

  var_05 = "sizzler_transform";
  var_06 = spawnStruct();
  var_06.var_81C7 = "ignoreRealign";
  var_06.var_8109 = var_02;
  var_07 = self method_83DB(var_03);
  if(isDefined(param_00)) {
    var_09 = anglesToForward(self.var_1D);
    var_0A = vectordot(var_09, param_00);
    if(var_0A > -0.707 && var_0A < 0.707) {
      var_0B = anglestoright(self.var_1D);
      var_0A = vectordot(var_0B, param_00);
      if(var_0A > 0) {
        var_0C = 2;
      } else {
        var_0C = 0;
      }
    } else if(var_0A > 0) {
      var_0C = 1;
    } else {
      var_0C = 3;
    }
  } else {
    var_0C = 1;
  }

  if(param_01) {
    var_06.optional_script_anim_index = int(var_0C / 2);
  } else {
    var_06.optional_script_anim_index = var_0C;
  }

  var_0D = self method_83D8(var_03, var_06.optional_script_anim_index);
  var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_0D, var_05, 0);
  var_0F = getmovedelta(var_0D, 0, var_0E);
  var_10 = self localtoworldcoords(var_0F);
  if(!lib_0547::func_1F5B(self.var_116, var_10)) {
    if(param_01) {
      var_06.optional_script_anim_index = 2;
    } else {
      var_06.optional_script_anim_index = 4;
    }

    var_0D = self method_83D8(var_03, var_06.optional_script_anim_index);
    var_0E = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_0D, var_05, 0);
  }

  var_12 = getsizzlerboltoffsets(param_01, var_0C);
  var_13 = var_12[0];
  var_14 = var_12[1];
  var_15 = getsizzlerbolt();
  var_15.var_54F5 = 1;
  var_15.posoffset = var_13;
  var_15.anglesoffset = var_14;
  var_15.var_5DBE = var_04;
  var_15 linkto(self, var_04, var_13, var_14);
  playFXOnTag(level.var_611["zmb_ber_bolt_rod_gk_attach"], var_15, "TAG_ORIGIN");
  var_15 scriptmodelplayanim("s2_zom_ww_bolt_extend");
  var_15 thread monitor_sizzler_bolt(self);
  var_16 = getanimlength(var_0D);
  var_06.optional_timeoffset = var_0E * var_16;
  var_17 = [];
  var_17["end_notetrack"] = var_05;
  self.transformingtosizzler = 1;
  thread maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_03, var_06.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_17);
  lib_0378::func_8D74("vox_request", "transform");
  var_18 = self.var_116;
  wait(var_06.optional_timeoffset - 0.05);
  level notify("spawn_sizzler_start");
  playFX(common_scripts\utility::func_44F5("zmb_ber_szlr_burst_1"), self.var_116);
  lib_0378::func_8D74("zmb_siz_trans_fx_burst", var_18);
  killfxontag(level.var_611["zmb_ber_bolt_rod_gk_attach"], var_15, "TAG_ORIGIN");
  var_06.var_116 = self gettagorigin("tag_origin");
  var_06.var_1D = self gettagangles("tag_origin");
  var_06.ignoreforcedzombietype = 1;
  var_19 = lib_054D::func_90BA("zombie_sizzler", var_06, "zombie sizzler spawn", 1, 0, 1);
  level notify("spawn_sizzler_complete");
  var_15 unlink();
  if(isDefined(var_19)) {
    var_15 linkto(var_19, var_04, var_13, var_14);
    playFXOnTag(level.var_611["zmb_ber_bolt_rod_gk_attach"], var_15, "TAG_ORIGIN");
    var_15 thread monitor_sizzler_bolt(var_19);
    thread maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_03, var_06.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_17);
    level.numactivesizzlers++;
  }

  self.var_6734 = 1;
  self.var_1DEB = 1;
  self suicide();
}

zombie_make_sizzler_simple() {
  self endon("death");
  var_00 = "stand_change_react";
  var_01 = "s2_zom_sizzler_stand_change_react";
  var_02 = "sizzler_transform";
  var_03 = spawnStruct();
  var_03.var_81C7 = "ignoreRealign";
  var_03.var_8109 = var_00;
  var_04 = self method_83DB(var_01);
  var_05 = 1;
  var_03.optional_script_anim_index = var_05;
  var_06 = self method_83D8(var_01, var_03.optional_script_anim_index);
  var_07 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_06, var_02, 0);
  var_08 = getmovedelta(var_06, 0, var_07);
  var_09 = self localtoworldcoords(var_08);
  if(!lib_0547::func_1F5B(self.var_116, var_09)) {
    var_03.optional_script_anim_index = 4;
    var_06 = self method_83D8(var_01, var_03.optional_script_anim_index);
    var_07 = maps\mp\agents\_scripted_agent_anim_util::func_45B9(var_06, var_02, 0);
  }

  var_0B = getanimlength(var_06);
  var_03.optional_timeoffset = var_07 * var_0B;
  var_0C = [];
  var_0C["end_notetrack"] = var_02;
  self.transformingtosizzler = 1;
  thread maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_01, var_03.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_0C);
  lib_0378::func_8D74("vox_request", "transform");
  var_0D = self.var_116;
  wait(var_03.optional_timeoffset - 0.05);
  level notify("spawn_sizzler_start");
  playFX(common_scripts\utility::func_44F5("zmb_ber_szlr_burst_1"), self.var_116);
  lib_0378::func_8D74("zmb_siz_trans_fx_burst", var_0D);
  var_03.var_116 = self gettagorigin("tag_origin");
  var_03.var_1D = self gettagangles("tag_origin");
  var_0E = lib_054D::func_90BA("zombie_sizzler", var_03, "zombie sizzler spawn", 1, 0, 1);
  level notify("spawn_sizzler_complete", var_0E, self);
  if(isDefined(var_0E)) {
    thread maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_01, var_03.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_0C);
    level.numactivesizzlers++;
  }

  self.var_6734 = 1;
  self.var_1DEB = 1;
  self suicide();
}

zombie_sizzler_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level.numactivesizzlers--;
  lib_054D::func_6BD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

zombie_sizzler_vfx() {
  self endon("death");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sizzler_zombie_smoldering"), self, "J_Spine4");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sizzler_head"), self, "J_head");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sizzler_flames"), self, "J_Knee_LE");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sizzler_flames"), self, "J_Knee_RI");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_sizzler_mouth"), self, "jnt_mandible");
}

zombie_sizzler_slot_available() {
  return level.numactivesizzlers < level.maxactivesizzlers;
}

noofsizzlerscanspawn() {
  var_00 = lib_0547::func_4090("zombie_sizzler");
  var_01 = var_00.size;
  while(!isDefined(var_01)) {
    wait 0.05;
  }

  if(var_01 >= level.maxactivesizzlers) {
    return 0;
  }

  return level.maxactivesizzlers - var_01;
}

monitor_sizzler_bolt(param_00) {
  var_01 = self;
  var_01 notify("bolt_link_changed");
  var_01 endon("bolt_link_changed");
  var_01 childthread monitor_bolt_damage(param_00);
  param_00 waittill("body_spawned", var_02);
  killfxontag(level.var_611["zmb_ber_bolt_rod_gk_attach"], var_01, "TAG_ORIGIN");
  wait 0.05;
  var_01 notsolid();
  var_01 lib_0547::cleanup_damageable_script_model();
  self.boltdamageinit = undefined;
  var_01.var_54F5 = 0;
  var_01.posoffset = undefined;
  var_01.anglesoffset = undefined;
  var_01.var_5DBE = undefined;
  var_01 unlink();
  var_01 method_8511();
}

monitor_bolt_damage(param_00) {
  if(!isDefined(self.boltdamageinit)) {
    lib_0547::init_damageable_script_model();
    self.boltdamageinit = 1;
  }

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    playFXOnTag(level.var_611["zmb_ber_szlr_geistkraftexplode_1"], self, "TAG_ORIGIN");
    param_00 dodamage(param_00.var_BC, var_02.var_116, var_02, self, var_05, var_0A, var_04);
  }
}

getsizzlerbolt() {
  if(!isDefined(level.sizzlerbolts)) {
    level.sizzlerbolts = [];
  }

  var_00 = undefined;
  if(level.sizzlerbolts.size < 14) {
    var_00 = spawn("script_model", self.var_116);
    level.sizzlerbolts[level.sizzlerbolts.size] = var_00;
    var_00 setModel("npc_zom_wonderweapon_bolt");
  } else {
    var_01 = 0;
    var_00 = level.sizzlerbolts[var_01];
    var_00 unlink();
    level.sizzlerbolts = common_scripts\utility::func_F9A(level.sizzlerbolts, var_01);
    level.sizzlerbolts[level.sizzlerbolts.size] = var_00;
  }

  var_00 solid();
  var_00 method_805B();
  return var_00;
}

getsizzlerboltoffsets(param_00, param_01) {
  var_02 = (0, 0, 1);
  var_03 = (0, 1, 0);
  var_04 = (1, 0, 0);
  var_05 = 4 * var_04;
  if(!param_00) {
    switch (param_01) {
      case 0:
        var_06 = (230, 70, 0);
        var_05 = 0.5 * var_02 + 0.35 * var_03 + 4 * var_04;
        break;

      case 1:
        var_06 = (0, 100, 0);
        break;

      case 2:
        var_06 = (130, 70, 0);
        var_05 = -0.5 * var_02 + 0.35 * var_03 + 4 * var_04;
        break;

      case 3:
        var_06 = (180, 70, 0);
        break;

      default:
        var_06 = (0, 100, 0);
        break;
    }
  } else {
    switch (var_02) {
      case 0:
        var_06 = (230, 60, 0);
        var_05 = 0.5 * var_02 + 0.35 * var_03 + 4 * var_04;
        break;

      case 1:
        var_06 = (0, 120, 0);
        break;

      case 2:
        var_06 = (130, 60, 0);
        var_05 = -0.5 * var_02 + 0.35 * var_03 + 4 * var_04;
        break;

      case 3:
        var_06 = (180, 60, 0);
        break;

      default:
        var_06 = (0, 120, 0);
        break;
    }
  }

  return [var_05, var_06];
}