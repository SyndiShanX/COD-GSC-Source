/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_pods.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_zod_quest;
#namespace zm_zod_pods;

function autoexec __init__sytem__() {
  system::register("zm_zod_pods", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "ZM_ZOD_UI_POD_SPRAYER_PICKUP", 1, 1, "int", & zm_utility::zm_ui_infotext, 0, 1);
  clientfield::register("scriptmover", "update_fungus_pod_level", 1, 3, "int", & update_fungus_pod_level, 0, 0);
  clientfield::register("scriptmover", "pod_sprayer_glint", 1, 1, "int", & pod_sprayer_glint, 0, 0);
  clientfield::register("scriptmover", "pod_miasma", 1, 1, "counter", & function_59408649, 0, 0);
  clientfield::register("scriptmover", "pod_harvest", 1, 1, "counter", & play_harvested_fx, 0, 0);
  clientfield::register("scriptmover", "pod_self_destruct", 1, 1, "counter", & pod_self_destruct, 0, 0);
  clientfield::register("toplayer", "pod_sprayer_held", 1, 1, "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "pod_sprayer_hint_range", 1, 1, "int", & zm_utility::setinventoryuimodels, 0, 0);
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage1_bundle");
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage1_death_bundle");
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage2_bundle");
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage2_death_bundle");
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage3_bundle");
  scene::init("p7_fxanim_zm_zod_fungus_pod_stage3_death_bundle");
}

function update_fungus_pod_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.ambient_fx)) {
    stopfx(localclientnum, self.ambient_fx);
    self stopallloopsounds();
  }
  if(!isDefined(level.var_63c365e9)) {
    level.var_63c365e9 = [];
  }
  if(!isDefined(level.var_63c365e9[localclientnum])) {
    level.var_63c365e9[localclientnum] = [];
  }
  if(!isDefined(level.var_63c365e9[localclientnum][self getentitynumber()])) {
    level.var_63c365e9[localclientnum][self getentitynumber()] = util::spawn_model(localclientnum, "p7_fxanim_zm_zod_fungus_pod_base_mod", self.origin, self.angles);
  }
  var_165d49f6 = level.var_63c365e9[localclientnum][self getentitynumber()];
  if(isdemoplaying() && getnumfreeentities(localclientnum) < 100) {
    var_2a6bebf9 = getnumfreeentities(localclientnum);
    if(!isDefined(self.n_pod_level)) {
      self.n_pod_level = 1;
    }
    return;
  }
  if(!isDefined(self.n_pod_level)) {
    self.n_pod_level = 1;
  }
  switch (newval) {
    case 0:
    case 4: {
      self thread scene_play(("p7_fxanim_zm_zod_fungus_pod_stage" + self.n_pod_level) + "_death_bundle", var_165d49f6);
      self.n_pod_level = 0;
      break;
    }
    case 1: {
      self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage1_bundle", var_165d49f6);
      self.ambient_fx = playFX(localclientnum, "zombie/fx_fungus_pod_ambient_sm_zod_zmb", self.origin);
      self.n_pod_level = newval;
      break;
    }
    case 2: {
      self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage2_bundle", var_165d49f6);
      self.ambient_fx = playFX(localclientnum, "zombie/fx_fungus_pod_ambient_md_zod_zmb", self.origin);
      self.n_pod_level = newval;
      break;
    }
    case 3: {
      self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage3_bundle", var_165d49f6);
      self.ambient_fx = playFX(localclientnum, "zombie/fx_fungus_pod_ambient_lg_zod_zmb", self.origin);
      self.n_pod_level = newval;
      break;
    }
  }
}

function scene_play(scene, var_165d49f6) {
  self notify("scene_play");
  self endon("scene_play");
  self scene::stop();
  self function_6221b6b9(scene, var_165d49f6);
  self scene::stop();
}

function function_6221b6b9(scene, var_165d49f6) {
  level endon("demo_jump");
  self scene::play(scene, var_165d49f6);
}

function play_harvested_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval === 0) {
    return;
  }
  v_origin = self.origin;
  v_angles = anglesToForward(self.angles);
  n_pod_level = self.n_pod_level;
  if(isDefined(self.ambient_fx)) {
    stopfx(localclientnum, self.ambient_fx);
  }
  switch (n_pod_level) {
    case 1: {
      var_9a5eae23 = "zombie/fx_fungus_pod_explo_sm_zod_zmb";
      var_ae4d7909 = "zombie/fx_fungus_pod_linger_sm_zod_zmb";
      break;
    }
    case 2: {
      var_9a5eae23 = "zombie/fx_fungus_pod_explo_md_zod_zmb";
      var_ae4d7909 = "zombie/fx_fungus_pod_linger_md_zod_zmb";
      break;
    }
    case 3: {
      var_9a5eae23 = "zombie/fx_fungus_pod_explo_lg_zod_zmb";
      var_ae4d7909 = "zombie/fx_fungus_pod_linger_lg_zod_zmb";
      break;
    }
  }
  level thread function_b77a78c9(localclientnum, "zombie/fx_sprayer_mist_zod_zmb", v_origin, 2, v_angles);
  wait(0.3);
  level thread function_b77a78c9(localclientnum, var_ae4d7909, v_origin, 8, v_angles);
}

function function_b77a78c9(localclientnum, str_fx, v_origin, n_duration, v_angles) {
  if(isDefined(v_angles)) {
    fx = playFX(localclientnum, str_fx, v_origin, v_angles);
  } else {
    fx = playFX(localclientnum, str_fx, v_origin);
  }
  wait(n_duration);
  stopfx(localclientnum, fx);
}

function function_59408649(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread function_b77a78c9(localclientnum, "zombie/fx_fungus_pod_miasma_zod_zmb", self.origin, 5);
  }
}

function pod_self_destruct(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread function_b77a78c9(localclientnum, "zombie/fx_fungus_pod_explo_maxevo_zod_zmb", self.origin, 5, vectorscale((0, 1, 0), 90));
  }
}

function pod_sprayer_glint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_eb0a02e9)) {
    stopfx(localclientnum, self.var_eb0a02e9);
  }
  if(newval) {
    self.var_eb0a02e9 = playFXOnTag(localclientnum, "zombie/fx_sprayer_glint_zod_zmb", self, "tag_origin");
  }
}