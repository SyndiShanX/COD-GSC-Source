/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\gibbing.gsc
***********************************************/

function init_gibbing() {
  precachemodel("ui_bullet_armor_piercing");
  precachemodel("space_suit_chunks_03");
  precachemodel("space_suit_chunks_04");
  precachemodel("gib_chunk_huge");
  precachemodel("gib_torso");
  precachemodel("gib_arm_upper");
  precachemodel("gib_leg_upper");
  precachemodel("fullbody_dog_c_gibbed");
  precachemodel("body_spetsnaz_ar_gibbed");
  precachemodel("p7_skulls_bones_arm_lower");
  setsaveddvar("NLKQTSPTKQ", 1);
  level.g_effect["vfx_gib_explode"] = loadfx("vfx/iw8/weap/_explo/gib/vfx_body_explode_gib.vfx");
  level.g_effect["vfx_gib_dismember"] = loadfx("vfx/test/vfx_test_dismemberment_flesh_chunk_01.vfx");
  level.g_effect["vfx_blood_spurt"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_gushing.vfx");
}

function gibbing_shouldgibai(var0) {
  if(scripts\engine\utility::is_equal(var0.script_parameters, "gib_force")) {
    return true;
  }

  if(randomint(100) < 100) {
    return true;
  }

  if(isDefined(var0.ridingvehicle)) {
    return true;
  }

  return false;
}

function gibbing_gibai(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  if(isPlayer(self) && istrue(var0.magic_bullet_shield) && scripts\engine\utility::is_equal(self.team, var0.team)) {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }

  var0 endon("death");
  var0 endon("entitydeleted");
  thread gibbing_codeversion(var0, var1, var2);

  if(!isDefined(var2)) {
    var2 = "MOD_RIFLE_BULLET";
  }

  var0 stopanimScripted();
  var0 notify("stop_loop");
  var0 scripts\anim\shared::dropaiweapon();
  var0 scripts\engine\sp\utility::disable_long_death();
  var0 scripts\common\ai::gun_remove();
  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var0.origin);

  if(var0.classname == "actor_enemy_dog") {
    var0 setModel("fullbody_dog_c_gibbed");
    playFX(level.g_effect["vfx_gib_explode"], var1);
    var0 kill(var1, self, self, var2);
    return;
  }

  if(isDefined(var0.ridingvehicle)) {
    playFX(level.g_effect["vfx_gib_explode"], var1, anglestoup(var0.angles));
    var0 delete();
    return;
  }

  if(scripts\common\utility::iswegameplatform()) {
    var0 scripts\sp\utility::do_damage(var0.health + 9999, var1, self, undefined, var2, "iw8_sh_oscar12");
    return;
  }

  var0 scripts\sp\utility::do_damage(var0.health + 9999, var1, self, undefined, var2, "iw8_sh_oscar12");
}

function gibbing_codeversion(var0, var1, var2) {
  var0 endon("entitydeleted");

  if(!getdvarint("NTMLLPTNLT")) {
    return;
  }

  var0 waittill("death");
  var3 = 23;
  var4 = squared(var3);
  var5 = ["j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri"];
  var6 = ["j_knee_le", "j_knee_ri", "j_elbow_le", "j_elbow_ri"];
  var7 = 2147483647;
  var8 = undefined;

  foreach(var10 in var5) {
    if(!var0 tagexists(var10)) {
      continue;
    }

    var11 = var6[var13];

    if(!var0 tagexists(var11)) {
      continue;
    }

    var12 = distancesquared(var0 gettagorigin(var11), var1);

    if(var12 > var4) {
      continue;
    }

    if(var12 >= var7) {
      continue;
    }

    var7 = var12;
    var8 = var10;
  }

  waitframe();

  if(isDefined(var8)) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], var0, var8);
    var14 = var0 gettagorigin(var8);
    var15 = anglesToForward(var0 gettagangles(var8));
    var16 = var14 + var15 * 5;
    var17 = var14 + var15 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var16, var17);
  }

  var18 = "j_head";
  var19 = 13;

  if(distance(var0 gettagorigin(var18), var1) < var19) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], var0, var18);
    var15 = anglesToForward(var0 gettagangles(var18));
    var14 = var0 gettagorigin(var18);
    var16 = var14 + var15 * 5;
    var17 = var14 + var15 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var16, var17);

    if(isDefined(var0.headmodel)) {
      var0 detach(var0.headmodel);
    }

    if(isDefined(var0.hatmodel)) {
      var0 detach(var0.hatmodel);
      return;
    }

    return;
  }
}

function gibbing_scriptversion(var0, var1, var2) {
  var0 setModel("body_spetsnaz_ar_gibbed");
  var3 = spawnStruct();
  var3.tags = ["J_SpineUpper", "J_Spine4", "J_Shoulder_LE", "J_Shoulder_RI", "J_Clavicle_LE", "J_Clavicle_RI", "J_ShoulderTwist_LE", "J_ShoulderTwist_RI", "J_Chest", "J_Wrist_LE", "J_Wrist_RI", "J_Elbow_LE", "J_Elbow_RI", "J_ElbowDQ_LE", "J_ElbowDQ_RI", "J_WristFrontTwist1_LE", "J_WristFrontTwist1_RI", "J_Neck", "J_Helmet", "J_Head", "J_Visor", "J_Visor_Inner", "J_Shield_LE", "J_Shield_RI", "J_Teres_LE", "J_Teres_RI", "J_PelvisHelper_LE", "J_PelvisHelper_RI", "j_hipholster_ri", "tag_reflector_arm_le", "j_proc_spinelower", "j_proc_spinelower2", "j_proc_spineupper", "j_proc_clavicle_re", "j_proc_clavicle_le", "j_sling_target", "j_sling_clavicle", "j_sling_pivot", "j_sling_spine", "j_dummy_sling_spline", "j_dummy_slingcenteraim"];
  var4 = 50;

  for(var5 = 1; var5 <= var4; var5++) {
    var3.tags = scripts\engine\utility::array_add(var3.tags, "j_cosmetic_" + var5);
  }

  var3.stub = spawnStruct();
  var3.stub.tag = "J_SpineLower";
  var3.stub.model = "gib_chunk_huge";
  var6 = spawnStruct();
  var6.tags = ["J_Hip_RI", "J_Hip_LE", "J_Knee_RI", "J_Knee_LE", "J_KneeDQ_RI", "J_KneeDQ_LE", "J_Ankle_RI", "J_Ankle_LE", "J_Ball_RI", "J_Ball_LE", "J_hipholster_ri", "J_hip_proc_le", "j_hip_proc_ri"];
  var6.stub = spawnStruct();
  var6.stub.tag = "J_SpineLower";
  var6.stub.model = "gib_chunk_huge";
  var7 = var0 getEye();
  var8 = scripts\engine\math::get_mid_point(var0 gettagorigin("J_Ankle_LE"), var0 gettagorigin("J_Ankle_RI"));
  var9 = var7 - var8;
  var10 = 0.58;
  var11 = length(var9) * var10;
  var12 = var8 + vectorNormalize(var9) * var11;
  var13 = var7 - var12;
  var14 = var8 - var12;
  var15 = var1 - var12;
  var16 = scripts\engine\math::scalar_projection(var13, var15);
  var17 = scripts\engine\math::scalar_projection(var14, var15);
  var18 = max(var16, var17);

  if(var18 == var16) {
    var19 = "J_SpineUpper";
    playFX(level.g_effect["vfx_gib_explode"], var0 gettagorigin(var19), vectorNormalize(var13));
    jumpiffalse(isDefined(var0.headmodel)) LOC_000002a8;
    var0 detach(var0.headmodel);

    foreach(var21 in var3.tags) {
      if(scripts\engine\utility::hastag(var0.model, var21)) {
        var0 hidepart(var21);
      }
    }

    gibbing_buildskeletonupper(var0);
  } else {
    var19 = "J_SpineLower";
    playFX(level.g_effect["vfx_gib_explode"], var2 gettagorigin(var19), vectorNormalize(var15));

    foreach(var21 in var8.tags) {
      if(scripts\engine\utility::hastag(var2.model, var21)) {
        var2 hidepart(var21);
      }
    }

    gibbing_buildskeletonlower(var2);
  }

  var2 scripts\sp\utility::do_damage(var2.health + 9999, var3, self, undefined, var4, "iw8_sh_oscar12");
}

function gibbing_buildskeletonupper(var0) {
  var1 = "J_SpineLower";
  var2 = (6, 0, 0);
  var3 = (0, 270, -90);
  var4 = var0 gettagorigin(var1);
  var5 = spawn("script_model", var4);
  var5 setModel("gib_torso");
  var5 linkTo(var0, var1, var2, var3);
  var5 notsolid();
  playFXOnTag(level.g_effect["vfx_blood_spurt"], var5, "tag_origin");
  var6 = (0, 1.5, 4.5);
  var7 = (0, 270, 34.499);
  var8 = spawn("script_model", var5.origin);
  var8.angles = var5.angles;
  var8 setModel("gib_chunk_huge");
  var8 linkTo(var5, "tag_origin", var6, var7);
  var8 notsolid();
  var9 = (0.5, 0.5, -5.5);
  var10 = (0, 0, -85.0004);
  var11 = spawn("script_model", var5.origin);
  var11.angles = var5.angles;
  var11 setModel("gib_chunk_huge");
  var11 linkTo(var5, "tag_origin", var9, var10);
  var11 notsolid();
  var12 = (0.5, -4.5, -2.5);
  var13 = (354.269, 220.73, 100.942);
  var14 = spawn("script_model", var5.origin);
  var14.angles = var5.angles;
  var14 setModel("space_suit_chunks_03");
  var14 linkTo(var5, "tag_origin", var12, var13);
  var14 notsolid();
  gibbing_skeltonbuildpart(var5, "gib_arm_upper", (-0.2, -9.5, 4), (354.959, 19.7917, 152.819), "space_suit_chunks_03", (1.5, -15.5, -3.5), (38.0104, 130.724, 95.635));
  var15 = [var5, var8, var11, var14];
  thread gibbing_cleanupgibmodels(var15);
}

function gibbing_buildskeletonlower(var0) {
  var1 = "J_SpineLower";
  var2 = var0 gettagorigin(var1);
  var3 = (0, 0, 0);
  var4 = (0, 270, -90);
  var5 = spawn("script_model", var2);
  var5 setModel("gib_torso");
  var5 linkTo(var0, var1, var3, var4);
  var5 notsolid();
  playFXOnTag(level.g_effect["vfx_blood_spurt"], var5, "tag_origin");
  var6 = (0, 2, -3);
  var7 = (360, 270, 21.7995);
  var8 = spawn("script_model", var5.origin);
  var8.angles = var5.angles;
  var8 setModel("gib_chunk_huge");
  var8 linkTo(var5, "tag_origin", var6, var7);
  var8 notsolid();
  gibbing_skeltonbuildpart(var5, "gib_leg_upper", (-6, -5, -19.5), (39.9994, 0, -12.3017), "space_suit_chunks_03", (1, -1.5, -8), (329.052, 229.202, -104.932));
  gibbing_skeltonbuildpart(var5, "gib_leg_upper", (-2, 4.5, -20.5), (338.2, 180, -12.3017), "space_suit_chunks_04", (-0.5, 2, -14.5), (359.768, 279.452, 148.512));
  thread gibbing_cleanupgibmodels([var5, var8]);
}

function gibbing_skeltonbuildpart(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_model", self.origin);
  var6.angles = self.angles;
  var6 setModel(var0);
  var6 linkTo(self, "tag_origin", var1, var2);
  var6 notsolid();
  thread gibbing_cleanupgibmodels([var6]);

  if(isDefined(var3)) {
    var7 = spawn("script_model", self.origin);
    var7.angles = self.angles;
    var7 setModel(var3);
    var7 linkTo(self, "tag_origin", var4, var5);
    var7 notsolid();
    thread gibbing_cleanupgibmodels([var7]);
    return;
  }
}

function gibbing_cleanupgibmodels(var0) {
  wait 30;

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}