/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_blight_father.csc
***********************************************/

#include scripts\core_common\ai\archetype_blight_father;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm_common\zm_grappler;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_blight_father;

autoexec __init__system__() {
  system::register(#"zm_ai_blight_father", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"fx8_blightfather_weakspot_sack_amb"] = "zm_ai/fx8_blightfather_weakspot_sack_amb";
  level._effect[#"fx8_blightfather_weakspot_elbow_amb"] = "zm_ai/fx8_blightfather_weakspot_elbow_amb";
  level._effect[#"fx8_blightfather_weakspot_jaw_amb"] = "zm_ai/fx8_blightfather_weakspot_jaw_amb";
  level._effect[#"fx8_plyr_pstfx_vomit_loop"] = "player/fx8_plyr_pstfx_vomit_loop";
  level._effect[#"fx8_blightfather_vomit"] = "zm_ai/fx8_blightfather_vomit";
  level._effect[#"fx8_blightfather_vomit_object"] = "zm_ai/fx8_blightfather_vomit_object";
  level._effect[#"fx8_blightfather_vomit_purchase"] = "zm_ai/fx8_blightfather_vomit_purchase";
  level._effect[#"fx8_blightfather_vomit_statue_purchase"] = "zm_ai/fx8_blightfather_vomit_statue_purchase";
  level._effect[#"fx8_blightfather_vomit_box_purchase"] = "zm_ai/fx8_blightfather_vomit_box_purchase";
  level._effect[#"fx8_blightfather_vomit_craft_purchase"] = "zm_ai/fx8_blightfather_vomit_craft_purchase";
  level._effect[#"fx8_blightfather_maggot_spawn_burst"] = "zm_ai/fx8_blightfather_maggot_spawn_burst";
  level._effect[#"fx8_blightfather_chaos_missle"] = "zm_ai/fx8_blightfather_chaos_missle";
  level._effect[#"fx8_blightfather_maggot_death_exp"] = "zm_ai/fx8_blightfather_maggot_death_exp";
  level.grappler_beam = "zod_blight_father_grapple_beam";
  footsteps::registeraitypefootstepcb(#"blight_father", &function_958ba8d1);
  clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int", &function_192c82f8, 0, 0);
  clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int", &function_c6aa29ea, 0, 0);
  clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int", &function_caf74103, 0, 0);
  clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int", &function_bc64a2a, 0, 0);
  clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int", &function_c4fff539, 0, 0);
  clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int", &function_de0a50df, 0, 0);
  clientfield::register("scriptmover", "blight_father_purchase_lockdown_vomit_fx", 1, 3, "int", &function_2c098ccc, 0, 0);
  clientfield::register("toplayer", "tongueGrabPostFx", 1, 1, "int", &tonguegrabpostfx, 0, 0);
  clientfield::register("toplayer", "tongueGrabRumble", 1, 1, "int", &tonguegrabrumble, 0, 0);
  clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int", &function_59f8f265, 0, 0);
  clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter", &function_67ad42f3, 0, 0);
  clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter", &function_f102952d, 0, 0);
  clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int", &function_75be2854, 0, 0);
  clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int", &function_e47c2324, 0, 0);
  clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int", &function_f02b0934, 0, 0);
  clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter", &function_7d5e27f4, 0, 0);
  clientfield::register("toplayer", "blight_father_vomit_postfx_clientfield", 1, 1, "int", &function_2d7f68ab, 0, 0);
  clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int", &function_7d5fa1ae, 0, 0);
  clientfield::register("actor", "blight_father_death_fx", 17000, 6, "int", &blightfatherdeathfx, 0, 0);
}

private blightfatherdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    death_fx = function_4b885950(newval, 2, 3);
    origin = self gettagorigin("J_Spine4");

    if(!isDefined(origin)) {
      origin = self.origin;
    }

    playFX(localclientnum, death_fx, origin);
  }
}

private function_7d5fa1ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    origin = self gettagorigin("J_Spine4");

    if(!isDefined(origin)) {
      origin = self.origin;
    }

    physicsexplosionsphere(localclientnum, origin, 200, 0, 2);
  }
}

private function_c6aa29ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_cc8c05d5 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_le");
    return;
  }

  if(isDefined(self.var_cc8c05d5)) {
    stopfx(localclientnum, self.var_cc8c05d5);
    self.var_cc8c05d5 = undefined;
  }
}

private function_caf74103(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_e844c6a2 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_ri");
    return;
  }

  if(isDefined(self.var_e844c6a2)) {
    stopfx(localclientnum, self.var_e844c6a2);
    self.var_e844c6a2 = undefined;
  }
}

private function_bc64a2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_81531422 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_le_fx");
    return;
  }

  if(isDefined(self.var_81531422)) {
    stopfx(localclientnum, self.var_81531422);
    self.var_81531422 = undefined;
  }
}

private function_c4fff539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_40cb39ba = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_ri_fx");
    return;
  }

  if(isDefined(self.var_40cb39ba)) {
    stopfx(localclientnum, self.var_40cb39ba);
    self.var_40cb39ba = undefined;
  }
}

private function_de0a50df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_2beadf7 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_weakspot_jaw_amb"], self, "tag_jaw");
    return;
  }

  if(isDefined(self.var_2beadf7)) {
    stopfx(localclientnum, self.var_2beadf7);
    self.var_2beadf7 = undefined;
  }
}

private function_2c098ccc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1:
      self.var_32caa02 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_purchase"], self, "tag_origin");
      break;
    case 2:
      self.var_32caa02 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_statue_purchase"], self, "tag_origin");
      break;
    case 3:
      self.var_32caa02 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_box_purchase"], self, "tag_origin");
      break;
    case 4:
      self.var_32caa02 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_craft_purchase"], self, "tag_origin");
      break;
    default:
      if(isDefined(self.var_32caa02)) {
        stopfx(localclientnum, self.var_32caa02);
        self.var_32caa02 = undefined;
      }

      break;
  }
}

private tonguegrabpostfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self thread postfx::playpostfxbundle(#"pstfx_zm_tongue_grab");
    return;
  }

  self postfx::stoppostfxbundle("pstfx_zm_tongue_grab");
}

private tonguegrabrumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    if(self function_21c0fa55()) {
      function_36e4ebd4(localclientnum, "grapple_collision");
      function_fe0ad36e(localclientnum, "grapple_reel");
    }

    return;
  }

  if(self function_21c0fa55()) {
    function_36e4ebd4(localclientnum, "grapple_detach");
    self stoprumble(localclientnum, "grapple_collision");
    self stoprumble(localclientnum, "grapple_reel");
  }
}

private function_59f8f265(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_b0d99f6 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit"], self, "tag_jaw");
    return;
  }

  if(newval == 2) {
    self.var_b0d99f6 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_jaw");
    return;
  }

  if(isDefined(self.var_b0d99f6)) {
    stopfx(localclientnum, self.var_b0d99f6);
    self.var_b0d99f6 = undefined;
  }
}

private function_67ad42f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_le");
}

private function_f102952d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_ri");
}

private function_192c82f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    if(newval) {
      self setanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 1, 0.1, 1);
      return;
    }

    self clearanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 0.2);
  }
}

private function_e47c2324(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_f2668f6d = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_chaos_missle"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_f2668f6d)) {
    stopfx(localclientnum, self.var_f2668f6d);
  }
}

private function_f02b0934(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  position = self.origin;
  angles = self.angles;

  if(isDefined(position) && isDefined(angles)) {
    playFX(localclientnum, level._effect[#"fx8_blightfather_maggot_death_exp"], position, anglesToForward(angles), anglestoup(angles));
    function_2a9101fe(localclientnum, #"hash_7867f8f9aaaa0c40", position);
  }

  earthquake(localclientnum, 0.4, 0.8, self.origin, 300);
}

private function_7d5e27f4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  function_36e4ebd4(localclientnum, "damage_heavy");
}

private function_75be2854(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
  }
}

function_958ba8d1(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  var_166f3552 = 1000000;

  if(var_166f3552 > 0) {
    n_scale = (var_166f3552 - n_dist) / var_166f3552;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale < 0) {
    return;
  }

  n_scale *= 0.25;

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(localclientnum, n_scale, 0.1, pos, n_dist);

  if(n_scale <= 0.25 && n_scale > 0.2) {
    function_36e4ebd4(localclientnum, "anim_med");
    return;
  }

  if(n_scale <= 0.2 && n_scale > 0.1) {
    function_36e4ebd4(localclientnum, "damage_light");
    return;
  }

  function_36e4ebd4(localclientnum, "damage_light");
}

private function_2d7f68ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self zm_utility::function_f8796df3(localclientnum)) {
    return;
  }

  if(newval) {
    self.var_185f551 = playfxoncamera(localclientnum, level._effect[#"fx8_plyr_pstfx_vomit_loop"]);
    self postfx::playpostfxbundle("pstfx_zm_caustic_glob");
    self thread function_1a4f64a();
    self notify(#"hash_6bc06e9af30f987");
    return;
  }

  if(isDefined(self.var_185f551)) {
    stopfx(localclientnum, self.var_185f551);
  }

  self postfx::exitpostfxbundle("pstfx_zm_caustic_glob");
  self notify(#"hash_3af6fe8d4a8fac02");
}

function_1a4f64a() {
  self notify("6dcd79d7489a1b1");
  self endon("6dcd79d7489a1b1");
  self endoncallback(&function_43ec7ca3, #"death");
  self.var_7fd3b200 = 0;
  self thread function_cf88b888();
  self waittill(#"hash_3af6fe8d4a8fac02");
  wait 1;
  self thread function_1ca2497b();
}

function_cf88b888() {
  self notify("77cd1973e51a1a17");
  self endon("77cd1973e51a1a17");
  self endoncallback(&function_43ec7ca3, #"death", #"hash_3af6fe8d4a8fac02");
  var_893a571 = 0;
  self playrenderoverridebundle("rob_zm_viewarm_vomit");

  while(!var_893a571) {
    var_37159c8c = self.var_7fd3b200;
    var_72840ba5 = min(var_37159c8c + 0.05, 1);
    self.var_7fd3b200 = var_72840ba5;
    self function_78233d29("rob_zm_viewarm_vomit", "", "Threshold", var_72840ba5);

    if(var_72840ba5 >= 1) {
      var_893a571 = 1;
      break;
    }

    wait 0.1;
  }
}

function_1ca2497b() {
  self notify("6b4310a91dda8e0b");
  self endon("6b4310a91dda8e0b");
  self endoncallback(&function_43ec7ca3, #"death", #"hash_6bc06e9af30f987");
  var_e935ecce = 0;

  while(!var_e935ecce) {
    var_37159c8c = self.var_7fd3b200;
    var_72840ba5 = max(var_37159c8c - 0.025, 0);
    self.var_7fd3b200 = var_72840ba5;
    self function_78233d29("rob_zm_viewarm_vomit", "", "Threshold", var_72840ba5);

    if(var_72840ba5 <= 0) {
      self stoprenderoverridebundle("rob_zm_viewarm_vomit");
      var_e935ecce = 1;
      break;
    }

    wait 0.1;
  }
}

function_43ec7ca3(str_notify) {
  if(isDefined(self) && str_notify === "death") {
    if(self function_d2503806("rob_zm_viewarm_vomit")) {
      self function_f6e99a8d("rob_zm_viewarm_vomit");
    }

    localclientnum = self getlocalclientnumber();

    if(isDefined(self.var_185f551) && isDefined(localclientnum)) {
      killfx(localclientnum, self.var_185f551);
      self.var_185f551 = undefined;
    }

    if(postfx::function_556665f2("pstfx_zm_caustic_glob")) {
      self postfx::stoppostfxbundle("pstfx_zm_caustic_glob");
    }
  }
}