/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_coalescence_root_singapore.csc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cp_mi_zurich_coalescence_util;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace root_singapore;

function main() {
  init_clientfields();
  level._effect["green_light"] = "light/fx_light_depth_charge_inactive";
  level._effect["yellow_light"] = "light/fx_light_depth_charge_warning";
}

function init_clientfields() {
  clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 1, "int", & set_depth_charge_fx, 0, 0);
  clientfield::register("scriptmover", "water_disturbance", 1, 1, "int", & function_f354307b, 0, 0);
  clientfield::register("toplayer", "umbra_tome_singapore", 1, 2, "counter", & function_2b6fcfd1, 0, 0);
}

function skipto_start(str_objective, b_starting) {
  level thread function_5f80268d();
  level thread function_b087f50();
  level thread function_69ec3f06();
  level thread function_320f5638();
  level thread function_a9bc976();
  setwavewaterenabled("sing_water", 1);
  level thread scene::play("root_singapore_shutters", "targetname");
}

function function_95b88092(str_objective, b_starting) {
  if(b_starting) {
    level thread function_5f80268d();
    level thread function_b087f50();
    level thread function_69ec3f06();
  }
}

function skipto_end(str_objective, b_starting) {
  level thread scene::stop("root_singapore_shutters", "targetname");
  setwavewaterenabled("sing_water", 0);
  level thread scene::stop("cin_zur_16_02_singapore_vign_bodies01");
  level thread scene::stop("cin_zur_16_02_singapore_vign_bodies02");
  level thread scene::stop("cin_zur_16_02_singapore_vign_bodies03");
  level thread scene::stop("cin_zur_16_02_singapore_vign_pulled01");
  level thread scene::stop("cin_zur_16_02_singapore_vign_pulled02");
  level thread scene::stop("cin_zur_16_02_singapore_vign_pulled03");
  level thread scene::stop("cin_zur_16_02_singapore_hanging_shortrope");
  level thread scene::stop("cin_zur_16_02_singapore_hanging_shortrope_2");
  level notify("hash_1c383277");
  level thread zurich_util::function_3bf27f88(str_objective);
}

function function_2b6fcfd1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  umbra_clearpersistenttometrigger(localclientnum);
}

function function_5f80268d() {
  scene::add_scene_func("p7_fxanim_cp_zurich_roots_water01_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("p7_fxanim_cp_zurich_roots_water02_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("p7_fxanim_gp_shutter_lt_02_red_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("p7_fxanim_gp_shutter_rt_02_red_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("p7_fxanim_gp_shutter_lt_10_red_white_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("p7_fxanim_gp_shutter_rt_10_red_white_bundle", & zurich_util::function_4dd02a03, "done", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies01", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies02", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies03", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled01", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled02", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled03", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_hanging_shortrope", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
  scene::add_scene_func("cin_zur_16_02_singapore_hanging_shortrope_2", & zurich_util::function_4dd02a03, "play", "root_singapore_cleanup");
}

function function_b087f50() {
  level thread scene::init("p7_fxanim_cp_zurich_roots_water01_bundle");
  level thread scene::init("p7_fxanim_cp_zurich_roots_water02_bundle");
  wait(2.5);
  level thread scene::play("p7_fxanim_cp_zurich_roots_water01_bundle");
  wait(2);
  level thread scene::play("p7_fxanim_cp_zurich_roots_water02_bundle");
}

function function_69ec3f06() {
  level thread scene::play("cin_zur_16_02_singapore_vign_bodies01");
  level thread scene::play("cin_zur_16_02_singapore_vign_bodies02");
  level thread scene::play("cin_zur_16_02_singapore_vign_bodies03");
}

function function_320f5638() {
  level thread scene::play("cin_zur_16_02_singapore_vign_pulled01");
  wait(randomfloatrange(2, 5));
  level thread scene::play("cin_zur_16_02_singapore_vign_pulled02");
  wait(randomfloatrange(2, 5));
  level thread scene::play("cin_zur_16_02_singapore_vign_pulled03");
}

function function_a9bc976() {
  level thread scene::play("cin_zur_16_02_singapore_hanging_shortrope");
  wait(randomfloatrange(2, 5));
  level thread scene::play("cin_zur_16_02_singapore_hanging_shortrope_2");
}

function function_f354307b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_2e7c1306)) {
    str_tag = "zur_wave_jnt";
    self.var_2e7c1306 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin(str_tag), self gettagangles(str_tag));
    self.var_2e7c1306 linkto(self, str_tag);
    self.var_2e7c1306 setwaterdisturbanceparams(0.4, 1000, 2500, 1, 0);
  }
  if(newval) {
    self.var_2e7c1306.waterdisturbance = 1;
  } else {
    self.var_2e7c1306.waterdisturbance = 0;
    wait(0.016);
    self.var_2e7c1306 delete();
  }
}

function set_depth_charge_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.light_fx)) {
    stopfx(localclientnum, self.light_fx);
    self.light_fx = undefined;
  }
  switch (newval) {
    case 0: {
      self.light_fx = playFXOnTag(localclientnum, level._effect["yellow_light"], self, "tag_origin");
      break;
    }
    case 1: {
      self.light_fx = playFXOnTag(localclientnum, level._effect["green_light"], self, "tag_origin");
      break;
    }
  }
}