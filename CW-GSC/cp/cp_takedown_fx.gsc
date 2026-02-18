/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_fx.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace cp_takedown_fx;

function private autoexec __init__system__() {
  system::register(#"cp_takedown_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  function_bc948200();
  function_7c9b0132();
}

function private function_fa076c68() {}

function private function_bc948200() {
  clientfield::register("scriptmover", "clf_billiardslight_client_register", 1, 1, "int");
  clientfield::register("scriptmover", "clf_billiardslight_fx", 1, 1, "int");
  clientfield::register("scriptmover", "clf_cargoplane_client_register", 1, 1, "int");
  clientfield::register("scriptmover", "clf_cargoplane_landing_lights", 1, 1, "int");
  clientfield::register("scriptmover", "clf_cargoplane_nav_lights", 1, 1, "int");
  clientfield::register("scriptmover", "clf_cargoplane_door_sparks", 1, 1, "int");
  clientfield::register("vehicle", "clf_rccar_fxstate", 1, 8, "int");
  clientfield::register("vehicle", "clf_bronco_roof_lights", 1, 1, "int");
  clientfield::register("vehicle", "clf_bronco_cab_lights", 1, 1, "int");
  clientfield::register("vehicle", "clf_whizbyfx_bronco", 1, 1, "int");
  clientfield::register("toplayer", "clf_postfx_rccar", 1, 1, "int");
  clientfield::register("toplayer", "clf_postfx_transition", 1, 1, "int");
  clientfield::register("toplayer", "clf_postfx_rooftop_slide", 1, 1, "int");
  clientfield::register("toplayer", "clf_footstep_override", 1, 1, "int");
  clientfield::register("actor", "clf_rob_snipercam_blood", 1, 2, "int");
}

function private function_7c9b0132() {
  function_5ac4dc99("<dev string:x38>", 0);
  function_cd140ee9("<dev string:x38>", &function_7db8d681);
  function_5ac4dc99("<dev string:x50>", 2);
}

function private function_7db8d681(parms) {
  level.rc_car thread function_256335fe(parms.value);
}

function private function_256335fe(value) {
  self notify("<dev string:x6e>");
  self endon("<dev string:x6e>");
  wait getdvarfloat(#"hash_6aa37454960fce7a", 2);
  var_9ce32949 = self clientfield::get("<dev string:x82>");
  var_9ce32949 &= ~112;

  switch (value) {
    case 1:
      iprintlnbold("<dev string:x97>");
      var_9ce32949 |= 16;
      break;
    case 2:
      iprintlnbold("<dev string:xb2>");
      var_9ce32949 = var_9ce32949 | 16 | 32;
      break;
    case 3:
      iprintlnbold("<dev string:xce>");
      var_9ce32949 = var_9ce32949 | 16 | 32 | 64;
      break;
  }

  self clientfield::set("<dev string:x82>", var_9ce32949);
}

function function_c8bc54e4() {
  if(is_true(self.var_fa325a51)) {
    return;
  }

  self.var_fa325a51 = 1;
  self clientfield::set_to_player("clf_footstep_override", 1);
}

function function_ec0a577() {
  if(!is_true(self.var_fa325a51)) {
    return;
  }

  self.var_fa325a51 = undefined;
  self clientfield::set_to_player("clf_footstep_override", 0);
}

function function_d1dc8e50() {
  self clientfield::set("clf_billiardslight_client_register", 1);
}

function function_7eba1826() {
  if(is_true(self.var_47d689f3)) {
    return;
  }

  self.var_47d689f3 = 1;
  self clientfield::set("clf_billiardslight_fx", 1);
}

function function_20d8e1fa() {
  if(!is_true(self.var_47d689f3)) {
    return;
  }

  self.var_47d689f3 = undefined;
  self clientfield::set("clf_billiardslight_fx", 0);
}

function function_f0ecd8() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 1 || var_9ce32949 & 128) {
    return;
  }

  println("<dev string:xe9>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 1);
}

function function_85afc2fb() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(!(var_9ce32949 & 1)) {
    return;
  }

  var_9ce32949 &= ~14;
  println("<dev string:xf7>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 &~1);
}

function function_3419411b() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 2 || var_9ce32949 & 128) {
    return;
  }

  println("<dev string:x106>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 2);
}

function function_98db0a95() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 2 && !(var_9ce32949 & 128)) {
    println("<dev string:x11f>");
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 &~2);
  }
}

function function_323b6e10() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 4 || var_9ce32949 & 128) {
    return;
  }

  var_9ce32949 &= ~8;
  println("<dev string:x139>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 4);
}

function function_a66b2882() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 4 && !(var_9ce32949 & 128)) {
    println("<dev string:x151>");
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 &~4);
  }
}

function function_53bd0317() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 8 || var_9ce32949 & 128) {
    return;
  }

  var_9ce32949 &= ~4;
  println("<dev string:x16a>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 8);
}

function function_f2cb4cab() {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 8 && !(var_9ce32949 & 128)) {
    println("<dev string:x182>");
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 &~8);
  }
}

function function_6bd3950d(var_7737e6aa) {
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 128) {
    return;
  }

  if(!isDefined(self.var_e32d3cab)) {
    self.var_e32d3cab = 100;
  }

  self.var_e32d3cab -= var_7737e6aa;

  if(self.var_e32d3cab <= 0) {
    self function_fe8be1e0();
    return;
  }

  if(self.var_e32d3cab <= 25 && !(var_9ce32949 & 64)) {
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 64);
    return;
  }

  if(self.var_e32d3cab <= 50 && !(var_9ce32949 & 32)) {
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 32);
    return;
  }

  if(self.var_e32d3cab <= 75 && !(var_9ce32949 & 16)) {
    self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 16);
  }
}

function function_fe8be1e0() {
  self notify(#"killed");
  var_9ce32949 = self clientfield::get("clf_rccar_fxstate");

  if(var_9ce32949 & 128) {
    return;
  }

  var_9ce32949 &= ~126;
  println("<dev string:x19b>");
  self clientfield::set("clf_rccar_fxstate", var_9ce32949 | 128);
}

function function_c5bbfcb8() {
  self clientfield::set("clf_cargoplane_client_register", 1);
}

function function_b6cccb8() {
  if(is_true(self.var_1b0a7080)) {
    return;
  }

  self.var_1b0a7080 = 1;
  self clientfield::set("clf_cargoplane_nav_lights", 1);
}

function function_ee23b003() {
  if(!is_true(self.var_1b0a7080)) {
    return;
  }

  self.var_1b0a7080 = undefined;
  self clientfield::set("clf_cargoplane_nav_lights", 0);
}

function function_8e4c996d() {
  if(is_true(self.var_fd00d4f8)) {
    return;
  }

  self.var_fd00d4f8 = 1;
  self clientfield::set("clf_cargoplane_landing_lights", 1);
}

function function_675a8b8c() {
  if(!is_true(self.var_fd00d4f8)) {
    return;
  }

  self.var_fd00d4f8 = undefined;
  self clientfield::set("clf_cargoplane_landing_lights", 0);
}

function function_4c265dee() {
  if(is_true(self.var_25333943)) {
    return;
  }

  self.var_25333943 = 1;
  self clientfield::set("clf_bronco_roof_lights", 1);
}

function function_2c185955() {
  if(!is_true(self.var_25333943)) {
    return;
  }

  self.var_25333943 = undefined;
  self clientfield::set("clf_bronco_roof_lights", 0);
}

function function_4b711786() {
  if(is_true(self.var_c7ccb16c)) {
    return;
  }

  self.var_c7ccb16c = 1;
  self clientfield::set("clf_bronco_cab_lights", 1);
}

function function_b21aeabe() {
  if(!is_true(self.var_c7ccb16c)) {
    return;
  }

  self.var_c7ccb16c = undefined;
  self clientfield::set("clf_bronco_cab_lights", 0);
}

function function_59e9c6f4() {
  if(is_true(self.var_3bfbcde4)) {
    return;
  }

  self.var_3bfbcde4 = 1;
  self clientfield::set("clf_whizbyfx_bronco", 1);
}

function function_733ed949() {
  if(!is_true(self.var_3bfbcde4)) {
    return;
  }

  self.var_3bfbcde4 = undefined;
  self clientfield::set_to_player("clf_whizbyfx_bronco", 0);
}

function function_2be1d5b0() {
  if(is_true(self.var_c7ace249)) {
    return;
  }

  self.var_c7ace249 = 1;
  self clientfield::set_to_player("clf_postfx_rccar", 1);
}

function function_6539055f() {
  if(!is_true(self.var_c7ace249)) {
    return;
  }

  self.var_c7ace249 = undefined;
  self clientfield::set_to_player("clf_postfx_rccar", 0);
}

function function_701c25a5() {
  if(is_true(self.var_947d8f8b)) {
    return;
  }

  self.var_947d8f8b = 1;
  self clientfield::set_to_player("clf_postfx_transition", 1);
}

function function_a31136d8() {
  if(!is_true(self.var_947d8f8b)) {
    return;
  }

  self.var_947d8f8b = undefined;
  self clientfield::set_to_player("clf_postfx_transition", 0);
}

function function_febff01e() {
  if(is_true(self.var_70a967fd)) {
    return;
  }

  self.var_70a967fd = 1;
  self clientfield::set_to_player("clf_postfx_rooftop_slide", 1);
}

function function_d413059b() {
  if(!is_true(self.var_70a967fd)) {
    return;
  }

  self.var_70a967fd = undefined;
  self clientfield::set_to_player("clf_postfx_rooftop_slide", 0);
}

function function_f60520a9(waittime = 0, var_b47dc8ef = 0, end = 0) {
  var_37dc93e2 = 0;

  if(is_true(var_b47dc8ef)) {
    var_37dc93e2 = 2;
  }

  if(waittime > 0) {
    wait waittime;
  }

  if(is_false(end)) {
    self clientfield::set("clf_rob_snipercam_blood", 1 + var_37dc93e2);
    return;
  }

  self clientfield::set("clf_rob_snipercam_blood", 0 + var_37dc93e2);
}