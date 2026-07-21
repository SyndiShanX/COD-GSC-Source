/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\gibbing.gsc
***********************************************/

init_gibbing() {
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

gibbing_shouldgibai(var_0) {
  if(scripts\engine\utility::is_equal(var_0.script_parameters, "gib_force"))
    return 1;

  if(randomint(100) < 100)
    return 1;

  if(isDefined(var_0.ridingvehicle))
    return 1;

  return 0;
}

gibbing_gibai(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  if(isPlayer(self) && istrue(var_0.magic_bullet_shield) && scripts\engine\utility::is_equal(self.team, var_0.team)) {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }

  var_0 endon("death");
  var_0 endon("entitydeleted");
  thread gibbing_codeversion(var_0, var_1, var_2);

  if(!isDefined(var_2))
    var_2 = "MOD_RIFLE_BULLET";

  var_0 stopanimScripted();
  var_0 notify("stop_loop");
  var_0 scripts\anim\shared.gsc::dropaiweapon();
  var_0 scripts\engine\sp\utility::disable_long_death();
  var_0 scripts\common\ai::gun_remove();
  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var_0.origin);

  if(var_0.classname == "actor_enemy_dog") {
    var_0 setModel("fullbody_dog_c_gibbed");
    playFX(level.g_effect["vfx_gib_explode"], var_1);
    var_0 kill(var_1, self, self, var_2);
    return;
  }

  if(isDefined(var_0.ridingvehicle)) {
    playFX(level.g_effect["vfx_gib_explode"], var_1, anglestoup(var_0.angles));
    var_0 delete();
    return;
  }

  if(scripts\common\utility::iswegameplatform()) {
    var_0 scripts\sp\utility::do_damage(var_0.health + 9999, var_1, self, undefined, var_2, "iw8_sh_oscar12");
    return;
  }

  var_0 scripts\sp\utility::do_damage(var_0.health + 9999, var_1, self, undefined, var_2, "iw8_sh_oscar12");
}

gibbing_codeversion(var_0, var_1, var_2) {
  var_0 endon("entitydeleted");

  if(!getdvarint("NTMLLPTNLT")) {
    return;
  }
  var_0 waittill("death");
  var_3 = 23;
  var_4 = squared(var_3);
  var_5 = ["j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri"];
  var_6 = ["j_knee_le", "j_knee_ri", "j_elbow_le", "j_elbow_ri"];
  var_7 = 2147483647;
  var_8 = undefined;

  foreach(var_13, var_10 in var_5) {
    if(!var_0 tagexists(var_10)) {
      continue;
    }
    var_11 = var_6[var_13];

    if(!var_0 tagexists(var_11)) {
      continue;
    }
    var_12 = distancesquared(var_0 gettagorigin(var_11), var_1);

    if(var_12 > var_4) {
      continue;
    }
    if(var_12 >= var_7) {
      continue;
    }
    var_7 = var_12;
    var_8 = var_10;
  }

  waitframe();

  if(isDefined(var_8)) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], var_0, var_8);
    var_14 = var_0 gettagorigin(var_8);
    var_15 = anglesToForward(var_0 gettagangles(var_8));
    var_16 = var_14 + var_15 * 5;
    var_17 = var_14 + var_15 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var_16, var_17);
  }

  var_18 = "j_head";
  var_19 = 13;

  if(distance(var_0 gettagorigin(var_18), var_1) < var_19) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], var_0, var_18);
    var_15 = anglesToForward(var_0 gettagangles(var_18));
    var_14 = var_0 gettagorigin(var_18);
    var_16 = var_14 + var_15 * 5;
    var_17 = var_14 + var_15 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var_16, var_17);

    if(isDefined(var_0.headmodel))
      var_0 detach(var_0.headmodel);

    if(isDefined(var_0.hatmodel))
      var_0 detach(var_0.hatmodel);
  }
}

gibbing_scriptversion(var_0, var_1, var_2) {
  var_0 setModel("body_spetsnaz_ar_gibbed");
  var_3 = spawnStruct();
  var_3.tags = ["J_SpineUpper", "J_Spine4", "J_Shoulder_LE", "J_Shoulder_RI", "J_Clavicle_LE", "J_Clavicle_RI", "J_ShoulderTwist_LE", "J_ShoulderTwist_RI", "J_Chest", "J_Wrist_LE", "J_Wrist_RI", "J_Elbow_LE", "J_Elbow_RI", "J_ElbowDQ_LE", "J_ElbowDQ_RI", "J_WristFrontTwist1_LE", "J_WristFrontTwist1_RI", "J_Neck", "J_Helmet", "J_Head", "J_Visor", "J_Visor_Inner", "J_Shield_LE", "J_Shield_RI", "J_Teres_LE", "J_Teres_RI", "J_PelvisHelper_LE", "J_PelvisHelper_RI", "j_hipholster_ri", "tag_reflector_arm_le", "j_proc_spinelower", "j_proc_spinelower2", "j_proc_spineupper", "j_proc_clavicle_re", "j_proc_clavicle_le", "j_sling_target", "j_sling_clavicle", "j_sling_pivot", "j_sling_spine", "j_dummy_sling_spline", "j_dummy_slingcenteraim"];
  var_4 = 50;

  for(var_5 = 1; var_5 <= var_4; var_5++)
    var_3.tags = scripts\engine\utility::array_add(var_3.tags, "j_cosmetic_" + var_5);

  var_3.stub = spawnStruct();
  var_3.stub.tag = "J_SpineLower";
  var_3.stub.model = "gib_chunk_huge";
  var_6 = spawnStruct();
  var_6.tags = ["J_Hip_RI", "J_Hip_LE", "J_Knee_RI", "J_Knee_LE", "J_KneeDQ_RI", "J_KneeDQ_LE", "J_Ankle_RI", "J_Ankle_LE", "J_Ball_RI", "J_Ball_LE", "J_hipholster_ri", "J_hip_proc_le", "j_hip_proc_ri"];
  var_6.stub = spawnStruct();
  var_6.stub.tag = "J_SpineLower";
  var_6.stub.model = "gib_chunk_huge";
  var_7 = var_0 getEye();
  var_8 = scripts\engine\math::get_mid_point(var_0 gettagorigin("J_Ankle_LE"), var_0 gettagorigin("J_Ankle_RI"));
  var_9 = var_7 - var_8;
  var_10 = 0.58;
  var_11 = length(var_9) * var_10;
  var_12 = var_8 + vectorNormalize(var_9) * var_11;
  var_13 = var_7 - var_12;
  var_14 = var_8 - var_12;
  var_15 = var_1 - var_12;
  var_16 = scripts\engine\math::scalar_projection(var_13, var_15);
  var_17 = scripts\engine\math::scalar_projection(var_14, var_15);
  var_18 = max(var_16, var_17);

  if(var_18 == var_16) {
    var_19 = "J_SpineUpper";
    playFX(level.g_effect["vfx_gib_explode"], var_0 gettagorigin(var_19), vectorNormalize(var_13));

    if(isDefined(var_0.headmodel))
      var_0 detach(var_0.headmodel);

    foreach(var_21 in var_3.tags) {
      if(scripts\engine\utility::hastag(var_0.model, var_21))
        var_0 hidepart(var_21);
    }

    gibbing_buildskeletonupper(var_0);
  } else {
    var_19 = "J_SpineLower";
    playFX(level.g_effect["vfx_gib_explode"], var_0 gettagorigin(var_19), vectorNormalize(var_13));

    foreach(var_21 in var_6.tags) {
      if(scripts\engine\utility::hastag(var_0.model, var_21))
        var_0 hidepart(var_21);
    }

    gibbing_buildskeletonlower(var_0);
  }

  var_0 scripts\sp\utility::do_damage(var_0.health + 9999, var_1, self, undefined, var_2, "iw8_sh_oscar12");
}

gibbing_buildskeletonupper(var_0) {
  var_1 = "J_SpineLower";
  var_2 = (6, 0, 0);
  var_3 = (0, 270, -90);
  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawn("script_model", var_4);
  var_5 setModel("gib_torso");
  var_5 linkTo(var_0, var_1, var_2, var_3);
  var_5 notsolid();
  playFXOnTag(level.g_effect["vfx_blood_spurt"], var_5, "tag_origin");
  var_6 = (0, 1.5, 4.5);
  var_7 = (0, 270, 34.499);
  var_8 = spawn("script_model", var_5.origin);
  var_8.angles = var_5.angles;
  var_8 setModel("gib_chunk_huge");
  var_8 linkTo(var_5, "tag_origin", var_6, var_7);
  var_8 notsolid();
  var_9 = (0.5, 0.5, -5.5);
  var_10 = (0, 0, -85.0004);
  var_11 = spawn("script_model", var_5.origin);
  var_11.angles = var_5.angles;
  var_11 setModel("gib_chunk_huge");
  var_11 linkTo(var_5, "tag_origin", var_9, var_10);
  var_11 notsolid();
  var_12 = (0.5, -4.5, -2.5);
  var_13 = (354.269, 220.73, 100.942);
  var_14 = spawn("script_model", var_5.origin);
  var_14.angles = var_5.angles;
  var_14 setModel("space_suit_chunks_03");
  var_14 linkTo(var_5, "tag_origin", var_12, var_13);
  var_14 notsolid();
  var_5 gibbing_skeltonbuildpart("gib_arm_upper", (-0.2, -9.5, 4), (354.959, 19.7917, 152.819), "space_suit_chunks_03", (1.5, -15.5, -3.5), (38.0104, 130.724, 95.635));
  var_15 = [var_5, var_8, var_11, var_14];
  thread gibbing_cleanupgibmodels(var_15);
}

gibbing_buildskeletonlower(var_0) {
  var_1 = "J_SpineLower";
  var_2 = var_0 gettagorigin(var_1);
  var_3 = (0, 0, 0);
  var_4 = (0, 270, -90);
  var_5 = spawn("script_model", var_2);
  var_5 setModel("gib_torso");
  var_5 linkTo(var_0, var_1, var_3, var_4);
  var_5 notsolid();
  playFXOnTag(level.g_effect["vfx_blood_spurt"], var_5, "tag_origin");
  var_6 = (0, 2, -3);
  var_7 = (360, 270, 21.7995);
  var_8 = spawn("script_model", var_5.origin);
  var_8.angles = var_5.angles;
  var_8 setModel("gib_chunk_huge");
  var_8 linkTo(var_5, "tag_origin", var_6, var_7);
  var_8 notsolid();
  var_5 gibbing_skeltonbuildpart("gib_leg_upper", (-6, -5, -19.5), (39.9994, 0, -12.3017), "space_suit_chunks_03", (1, -1.5, -8), (329.052, 229.202, -104.932));
  var_5 gibbing_skeltonbuildpart("gib_leg_upper", (-2, 4.5, -20.5), (338.2, 180, -12.3017), "space_suit_chunks_04", (-0.5, 2, -14.5), (359.768, 279.452, 148.512));
  thread gibbing_cleanupgibmodels([var_5, var_8]);
}

gibbing_skeltonbuildpart(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", self.origin);
  var_6.angles = self.angles;
  var_6 setModel(var_0);
  var_6 linkTo(self, "tag_origin", var_1, var_2);
  var_6 notsolid();
  thread gibbing_cleanupgibmodels([var_6]);

  if(isDefined(var_3)) {
    var_7 = spawn("script_model", self.origin);
    var_7.angles = self.angles;
    var_7 setModel(var_3);
    var_7 linkTo(self, "tag_origin", var_4, var_5);
    var_7 notsolid();
    thread gibbing_cleanupgibmodels([var_7]);
  }
}

gibbing_cleanupgibmodels(var_0) {
  wait 30;

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}