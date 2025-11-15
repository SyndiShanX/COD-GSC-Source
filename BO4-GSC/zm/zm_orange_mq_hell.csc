/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_hell.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_sq_modules;

#namespace zm_orange_mq_hell;

preload() {
  level._effect[#"lantern_moving"] = #"hash_73e8d2cf76175901";
  level._effect[#"lantern_waiting"] = #"hash_4f1f3e18228ac0a0";
  level._effect[#"lantern_charging"] = #"hash_7af8fa2d13abeeb1";
  level._effect[#"lantern_explode"] = #"hash_306c49d67fca8485";
  level._effect[#"lantern_soul"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_7336b7a4cc9d2581"] = #"hash_1a06427eff8dfe13";
  clientfield::register("scriptmover", "" + #"hash_6aaf03a4358f45f5", 24000, 1, "counter", &function_f1749965, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_6a4317183d0ca452", 24000, 1, "counter", &function_44aa40e0, 0, 0);
  clientfield::register("world", "" + #"lava_init", 24000, 1, "int", &lava_init, 0, 0);
  clientfield::register("world", "" + #"lava_control", 24000, 2, "int", &lava_control, 0, 0);
  clientfield::register("world", "" + #"hash_72b5b0359ca48427", 24000, 1, "int", &function_bd0807f3, 0, 0);
  clientfield::register("world", "" + #"hash_5e69ee96304ec40b", 24000, 1, "int", &function_eb481d38, 0, 0);
  clientfield::register("vehicle", "" + #"lantern_fx", 24000, 2, "int", &function_f490f0e5, 0, 0);
  clientfield::register("vehicle", "" + #"lantern_explode_fx", 24000, 1, "counter", &play_lantern_explode_fx, 0, 0);
  clientfield::register("toplayer", "" + #"hash_78b8d89d34b32241", 24000, 2, "int", &function_19f2f0f2, 0, 0);
  clientfield::register("scriptmover", "" + #"lantern_outline", 24000, 1, "int", &function_cbc22c9d, 0, 0);
  zm_sq_modules::function_d8383812(#"sc_lantern_1", 24000, "sc_lantern_1", 400, level._effect[#"lantern_soul"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_lantern_2", 24000, "sc_lantern_2", 400, level._effect[#"lantern_soul"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_lantern_3", 24000, "sc_lantern_3", 400, level._effect[#"lantern_soul"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_lantern_4", 24000, "sc_lantern_4", 400, level._effect[#"lantern_soul"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"sc_lantern_end", 24000, "sc_lantern_end", 400, level._effect[#"lantern_soul"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
}

function_f1749965(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrenderoverridebundle(#"hash_75168376918f5ab7");
  self function_e378599(500);
  self.var_4156bf58 = 1;
}

function_44aa40e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_4156bf58)) {
    self function_e378599(self.n_radius - 1);
  }
}

function_e378599(n_radius) {
  self.n_radius = max(200, n_radius);
  n_scale = self.n_radius / 150000;
  self function_78233d29(#"hash_75168376918f5ab7", "", "Scale", n_scale);
}

lava_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_eb7fcc70 = getEntArray(localclientnum, "lava_entity", "targetname");

  foreach(var_59bd23de in level.var_eb7fcc70) {
    var_59bd23de hide();
    var_59bd23de notsolid();
  }
}

lava_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_eb7fcc70)) {
    level.var_eb7fcc70 = getEntArray(localclientnum, "lava_entity", "targetname");
  }

  if(newval == 1) {
    foreach(var_59bd23de in level.var_eb7fcc70) {
      var_59bd23de show();
      var_59bd23de solid();
    }

    exploder::exploder("exp_lava_event_ambient");
    exploder::exploder("exp_lava_event_ambient_2");
    return;
  }

  if(newval == 0) {
    foreach(var_59bd23de in level.var_eb7fcc70) {
      var_59bd23de hide();
      var_59bd23de notsolid();
    }

    exploder::stop_exploder("exp_lava_event_ambient");
    exploder::stop_exploder("exp_lava_event_ambient_2");
  }
}

function_f490f0e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_b75f11cd)) {
    stopfx(localclientnum, self.var_b75f11cd);
    self.var_b75f11cd = undefined;
  }

  if(newval == 1) {
    util::playFXOnTag(localclientnum, level._effect[#"lantern_moving"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    util::playFXOnTag(localclientnum, level._effect[#"lantern_waiting"], self, "tag_origin");
    return;
  }

  if(newval == 3) {
    util::playFXOnTag(localclientnum, level._effect[#"lantern_charging"], self, "tag_origin");
  }
}

function_19f2f0f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self postfx::function_556665f2(#"hash_470febc4af661700")) {
    self postfx::stoppostfxbundle(#"hash_470febc4af661700");
  } else if(self postfx::function_556665f2(#"hash_6864d9fc4517ec45")) {
    self postfx::stoppostfxbundle(#"hash_6864d9fc4517ec45");
  }

  if(newval == 1) {
    self postfx::playpostfxbundle(#"hash_470febc4af661700");
  } else if(newval == 2) {
    self postfx::playpostfxbundle(#"hash_6864d9fc4517ec45");
  }

  if(newval == 2) {
    if(!isDefined(self.var_9480d4b2)) {
      self.var_9480d4b2 = self playLoopSound(#"evt_death_circle_strong");
    }

    return;
  }

  if(isDefined(self.var_9480d4b2)) {
    self stoploopsound(self.var_9480d4b2);
    self.var_9480d4b2 = undefined;
  }
}

function_cbc22c9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrenderoverridebundle(#"rob_sonar_set_friendly_zm");
}

play_lantern_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"lantern_explode"], self, "tag_origin");
}

function_bd0807f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    audio::snd_set_snapshot("cmn_duck_aux_4");
    return;
  }

  audio::snd_set_snapshot("");
}

function_eb481d38(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setsoundcontext("orange_hell", "active");
    return;
  }

  setsoundcontext("orange_hell", "");
}