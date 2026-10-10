/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\gibbing.gsc
***********************************************/

#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\friendlyfire;
#using scripts\sp\utility;
#namespace gibbing;

function function_dd6a6026798161b2() {
  level.g_effect["vfx_gib_explode"] = loadfx("vfx/iw8/weap/_explo/gib/vfx_body_explode_gib.vfx");
  level.g_effect["vfx_gib_dismember"] = loadfx("vfx/test/vfx_test_dismemberment_flesh_chunk_01.vfx");
}

function gibbing_shouldgibai(ai) {
  if(is_equal(ai.script_parameters, "gib_force")) {
    return true;
  }

  if(randomint(100) < 100) {
    return true;
  }

  if(isDefined(ai.ridingvehicle)) {
    return true;
  }

  return false;
}

function gibbing_gibai(ai, impactposition, meansofdeath) {
  ai endon("death");
  ai endon("entitydeleted");

  if(!isDefined(ai)) {
    return;
  }

  if(!isalive(ai)) {
    return;
  }

  if(isPlayer(self) && istrue(ai.magic_bullet_shield) && is_equal(self.team, ai.team)) {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }

  thread function_34e4b25a8ccb65d4(ai, impactposition);
  meansofdeath = default_to(meansofdeath, "MOD_RIFLE_BULLET");
  ai stopanimScripted();
  ai notify("stop_loop");
  ai scripts\anim\shared::dropaiweapon();
  ai ai::disable_long_death();
  ai scripts\common\ai::gun_remove();
  thread play_sound_in_space("gib_fullbody", ai.origin);

  if(ai.classname == "actor_enemy_dog") {
    ai setModel("fullbody_dog_c_gibbed");
    playFX(level.g_effect["vfx_gib_explode"], impactposition);
    ai kill(impactposition, self, self, meansofdeath);
    return;
  }

  if(isDefined(ai.ridingvehicle)) {
    playFX(level.g_effect["vfx_gib_explode"], impactposition, anglestoup(ai.angles));
    ai delete();
    return;
  }

  ai do_damage(ai.health + 9999, impactposition, self, undefined, meansofdeath, "iw8_sh_oscar12");
}

function function_34e4b25a8ccb65d4(ai, impactposition) {
  ai endon("entitydeleted");

  if(!isdismembermentenabled()) {
    return;
  }

  ai waittill("death");
  var_9042cc9863a39847 = 23;
  var_b3903f41173e70f7 = squared(var_9042cc9863a39847);
  var_ebb71387895b55d0 = ["j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri"];
  var_599c91df7e48c291 = ["j_knee_le", "j_knee_ri", "j_elbow_le", "j_elbow_ri"];
  var_8a792b293cdad489 = 2147483647;
  var_17c2f496cf9c27be = undefined;

  foreach(var_d7d9d723b537a283 in var_ebb71387895b55d0) {
    if(!ai tagexists(var_d7d9d723b537a283)) {
      continue;
    }

    var_72b2f4d0a71a0c58 = var_599c91df7e48c291[index];

    if(!ai tagexists(var_72b2f4d0a71a0c58)) {
      continue;
    }

    var_e0d05010cb066f8b = distancesquared(ai gettagorigin(var_72b2f4d0a71a0c58), impactposition);

    if(var_e0d05010cb066f8b > var_b3903f41173e70f7) {
      continue;
    }

    if(var_e0d05010cb066f8b >= var_8a792b293cdad489) {
      continue;
    }

    var_8a792b293cdad489 = var_e0d05010cb066f8b;
    var_17c2f496cf9c27be = var_d7d9d723b537a283;
  }

  waitframe();

  if(isDefined(var_17c2f496cf9c27be)) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], ai, var_17c2f496cf9c27be);
    tagorigin = ai gettagorigin(var_17c2f496cf9c27be);
    var_1dcf690711aca094 = anglesToForward(ai gettagangles(var_17c2f496cf9c27be));
    var_e84ad86715d85cc = tagorigin + var_1dcf690711aca094 * 5;
    var_6a862672391c9895 = tagorigin + var_1dcf690711aca094 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var_e84ad86715d85cc, var_6a862672391c9895);
  }

  var_f1ac81f044138375 = "j_head";
  var_f9be8ce0e09d7c9c = 13;

  if(distance(ai gettagorigin(var_f1ac81f044138375), impactposition) < var_f9be8ce0e09d7c9c) {
    playFXOnTag(level.g_effect["vfx_gib_dismember"], ai, var_f1ac81f044138375);
    var_1dcf690711aca094 = anglesToForward(ai gettagangles(var_f1ac81f044138375));
    tagorigin = ai gettagorigin(var_f1ac81f044138375);
    var_e84ad86715d85cc = tagorigin + var_1dcf690711aca094 * 5;
    var_6a862672391c9895 = tagorigin + var_1dcf690711aca094 * -50;
    magicbullet("iw8_sn_hdromeo_ballistics_impact", var_e84ad86715d85cc, var_6a862672391c9895);

    if(isDefined(ai.headmodel)) {
      ai detach(ai.headmodel);
    }

    if(isDefined(ai.hatmodel)) {
      ai detach(ai.hatmodel);
    }
  }
}