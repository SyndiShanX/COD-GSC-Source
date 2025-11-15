/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_perks.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_utility;

#namespace zm_perks;

init() {
  if(!isDefined(level.var_c3e5c4cd)) {
    level.var_c3e5c4cd = zm_utility::get_story();
  }

  callback::on_start_gametype(&init_perk_machines_fx);
  level._effect[#"hash_57c8c9eff08ddf44"] = #"hash_56161fdf383c5fdc";
  level._effect[#"hash_7c3a9f5103c06ff6"] = #"hash_420040b9ccd8bd85";

  if(level.var_c3e5c4cd == 2) {
    level._effect[#"hash_223e3f9bde46f5b4"] = #"hash_1678d9a47030413d";
    level._effect[#"hash_10e42380c1009ee9"] = #"hash_6ecd7d04b43d3fde";
    level._effect[#"hash_110d9fbfd034c819"] = #"hash_3060d78224e9c44e";
    level._effect[#"hash_6e4e902b59a22662"] = #"hash_3bb50572a528b187";
    level._effect[#"hash_26247c4bfd6fed73"] = #"hash_57eb5602b41fa4db";
    level._effect[#"hash_46334db9e3c76275"] = #"hash_3a24f6e29267c4d7";
  }

  level._effect[#"altar_icon_ambient_fx"] = #"hash_2c9a36103f6cc1e9";
  init_custom_perks();
  perks_register_clientfield();
  init_perk_custom_threads();
}

function_f3c80d73(str_bottle, str_totem) {
  if(zm_utility::get_story() == 1) {
    w_perk = getweapon(str_bottle);
  } else {
    w_perk = getweapon(str_totem);
  }

  forcestreamxmodel(w_perk.viewmodel, -1, -1);
  forcestreamxmodel(w_perk.worldmodel, 1, 1);
}

perks_register_clientfield() {
  if(isDefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
    clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", &perk_meteor_fx, 0, 0);
  }

  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].clientfield_register)) {
        level[[level._custom_perks[a_keys[i]].clientfield_register]]();
      }
    }
  }

  for(i = 0; i < 4; i++) {
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".state", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".progress", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".chargeCount", 1, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".modifierActive", 6000, 1, "int", undefined, 0, 0);
  }

  clientfield::register("clientuimodel", "hudItems.perkVapor.bleedoutProgress", 9000, 8, "float", undefined, 0, 0);

  for(i = 0; i < 6; i++) {
    n_version = 1;

    if(i >= 4) {
      n_version = 8000;
    }

    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".itemIndex", n_version, 5, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".state", n_version, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".progress", n_version, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".chargeCount", n_version, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".timerActive", n_version, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".specialEffectActive", n_version, 1, "int", undefined, 0, 0);
  }

  clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int", &function_bb184fed, 0, 0);
  clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int", &_train_sd_bombexplode, 0, 1);
  clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int", &function_d5f2f6ac, 0, 1);
  clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int", &function_136826b0, 0, 1);
  clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int", &function_a4c33786, 0, 1);

  if(level.var_c3e5c4cd == 2) {
    clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int", &function_9b4bc8e7, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int", &function_52c149b2, 0, 0);
    clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int", &function_ab7cd429, 0, 0);
    clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter", &function_ccbdf992, 0, 0);
  }

  level thread perk_init_code_callbacks();
}

perk_init_code_callbacks() {
  wait 0.1;

  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].clientfield_code_callback)) {
        level[[level._custom_perks[a_keys[i]].clientfield_code_callback]]();
      }
    }
  }
}

init_custom_perks() {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }
}

register_perk_clientfields(str_perk, func_clientfield_register, func_code_callback) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
  level._custom_perks[str_perk].clientfield_code_callback = func_code_callback;
}

register_perk_effects(str_perk, str_light_effect) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].machine_light_effect = str_light_effect;
}

register_perk_init_thread(str_perk, func_init_thread) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].init_thread = func_init_thread;
}

function_b60f4a9f(str_perk, var_4fbc4ea9, var_347c72d2, var_51f1a532) {
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].var_4fbc4ea9 = var_4fbc4ea9;
  level._custom_perks[str_perk].var_347c72d2 = var_347c72d2;

  if(isDefined(var_51f1a532)) {
    level._custom_perks[str_perk].var_51f1a532 = var_51f1a532;
  }
}

init_perk_custom_threads() {
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].init_thread)) {
        level thread[[level._custom_perks[a_keys[i]].init_thread]]();
      }
    }
  }
}

_register_undefined_perk(str_perk) {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }

  if(!isDefined(level._custom_perks[str_perk])) {
    level._custom_perks[str_perk] = spawnStruct();
  }
}

perk_meteor_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.meteor_fx = util::playFXOnTag(localclientnum, level._effect[#"perk_meteor"], self, "tag_origin");
    return;
  }

  if(isDefined(self.meteor_fx)) {
    stopfx(localclientnum, self.meteor_fx);
  }
}

init_perk_machines_fx(localclientnum) {
  if(!level.enable_magic) {
    return;
  }

  wait 0.1;
  machines = struct::get_array("zm_perk_machine", "targetname");
  array::thread_all(machines, &perk_start_up);
}

perk_start_up() {
  if(isDefined(self.script_int)) {
    power_zone = self.script_int;

    for(int = undefined; int != power_zone; int = waitresult.is_on) {
      waitresult = level waittill(#"power_on");
    }
  } else {
    level waittill(#"power_on");
  }

  timer = 0;
  duration = 0.1;

  while(true) {
    if(isDefined(level._custom_perks[self.script_noteworthy]) && isDefined(level._custom_perks[self.script_noteworthy].machine_light_effect)) {
      self thread vending_machine_flicker_light(level._custom_perks[self.script_noteworthy].machine_light_effect, duration);
    }

    timer += duration;
    duration += 0.2;

    if(timer >= 3) {
      break;
    }

    wait duration;
  }
}

vending_machine_flicker_light(fx_light, duration) {
  players = level.localplayers;

  for(i = 0; i < players.size; i++) {
    self thread play_perk_fx_on_client(i, fx_light, duration);
  }
}

play_perk_fx_on_client(client_num, fx_light, duration) {
  fxobj = spawn(client_num, self.origin + (0, 0, -50), "script_model");
  fxobj setModel(#"tag_origin");
  util::playFXOnTag(client_num, level._effect[fx_light], fxobj, "tag_origin");
  wait duration;
  fxobj delete();
}

function_ccbdf992(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"hash_4659ecede94f0b38", "tag_accessory_left");
  }
}

function_bb184fed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (self.model) {
      case #"p8_fxanim_zm_vapor_altar_danu_mod":
      case #"p8_fxanim_zm_perk_vending_brew_mod":
        n_slot = 0;
        var_fe826f11 = level._effect[#"hash_223e3f9bde46f5b4"];
        var_7ad76c54 = 3;
        break;
      case #"p8_fxanim_zm_red_vapor_altar_ra_mod":
      case #"p8_fxanim_zm_vapor_altar_ra_mod":
      case #"p8_fxanim_zm_perk_vending_cola_mod":
        n_slot = 1;
        var_fe826f11 = level._effect[#"hash_10e42380c1009ee9"];
        var_7ad76c54 = 5;
        break;
      case #"p8_fxanim_zm_vapor_altar_zeus_mod":
      case #"p8_fxanim_zm_perk_vending_soda_mod":
        n_slot = 2;
        var_fe826f11 = level._effect[#"hash_110d9fbfd034c819"];
        break;
      case #"p8_fxanim_zm_perk_vending_tonic_mod":
      case #"p8_fxanim_zm_vapor_altar_odin_mod":
        n_slot = 3;
        var_fe826f11 = level._effect[#"hash_6e4e902b59a22662"];
        var_7ad76c54 = 2;
        break;
      default:
        return;
    }

    str_targetname = "altar_icon_" + n_slot;
    mdl_icon = getent(localclientnum, str_targetname, "targetname");

    if(isDefined(mdl_icon)) {
      mdl_icon delete();
    }

    e_player = function_5c10bd79(localclientnum);
    e_player endon(#"death");
    var_16c042b8 = e_player function_35ba0b0e(localclientnum, n_slot);

    if(isDefined(var_16c042b8) && isDefined(level._custom_perks[var_16c042b8])) {
      var_c1cbeea5 = level._custom_perks[var_16c042b8].var_4fbc4ea9;

      if(level.var_c3e5c4cd == 2) {
        var_fe0b737a = level._custom_perks[var_16c042b8].var_347c72d2;
      } else {
        var_fe0b737a = level._effect[#"altar_icon_ambient_fx"];
      }
    } else {
      var_c1cbeea5 = #"tag_origin";
      var_fe0b737a = level._effect[#"altar_icon_ambient_fx"];
    }

    assert(isDefined(var_c1cbeea5), "<dev string:x38>");
    assert(isDefined(var_fe0b737a), "<dev string:x50>");
    forcestreamxmodel(self.model, 1, 1);
    forcestreamxmodel(var_c1cbeea5, 1, -1);
    mdl_icon = util::spawn_model(localclientnum, var_c1cbeea5, self gettagorigin("tag_icon_link"), self.angles);
    mdl_icon linkto(self, "tag_icon_link");
    mdl_icon playrenderoverridebundle(#"hash_16b8b568a95931e7");
    mdl_icon.targetname = str_targetname;
    mdl_icon.mdl_altar = self;

    if(level.var_c3e5c4cd == 2) {
      self.var_874350df = var_fe826f11;
      self.var_be82764e = var_fe826f11;
      self.var_7ad76c54 = var_7ad76c54;
    }

    if(isDefined(var_16c042b8) && isDefined(level._custom_perks[var_16c042b8]) && isDefined(level._custom_perks[var_16c042b8].var_51f1a532) && !(isDefined(zm_custom::function_901b751c(level._custom_perks[var_16c042b8].var_51f1a532)) && zm_custom::function_901b751c(level._custom_perks[var_16c042b8].var_51f1a532))) {
      var_c809f6c1 = 6;
    } else if(isDefined(e_player.var_74eaa305)) {
      var_c809f6c1 = e_player.var_74eaa305;
    } else {
      var_c809f6c1 = e_player getentitynumber() + 1;
    }

    mdl_icon thread function_bde5bc78(localclientnum, var_fe0b737a, var_c809f6c1, 0);
  }
}

function_35ba0b0e(localclientnum, n_slot) {
  level endon(#"demo_jump");
  self endon(#"death");
  self zm_loadout::function_622d8349(localclientnum);
  n_perk = n_slot + 1;
  var_3e311473 = self zm_loadout::get_loadout_item(localclientnum, "specialty" + n_perk);

  if(!isdemoplaying() && !(isDefined(level.b_game_ended) && level.b_game_ended)) {
    assert(isDefined(var_3e311473), "<dev string:x79>");
  }

    if(!isDefined(var_3e311473)) {
      return;
    }

  s_perk = getunlockableiteminfofromindex(var_3e311473, 3);

  if(!isDefined(s_perk) || !isDefined(s_perk.specialties) || !isDefined(s_perk.specialties[0])) {
    return;
  }

  str_perk = s_perk.specialties[0];

  if(isstring(str_perk)) {
    var_16c042b8 = hash(str_perk);
  }

  return var_16c042b8;
}

_train_sd_bombexplode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_30bf6142(localclientnum, newval, oldval, 0);
}

function_d5f2f6ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_30bf6142(localclientnum, newval, oldval, 1);
}

function_136826b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_30bf6142(localclientnum, newval, oldval, 2);
}

function_a4c33786(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_30bf6142(localclientnum, newval, oldval, 3);
}

function_30bf6142(localclientnum, newval, oldval, n_slot) {
  if(newval == 0) {
    return;
  }

  e_player = function_5c10bd79(localclientnum);
  mdl_icon = getent(localclientnum, "altar_icon_" + n_slot, "targetname");

  if(!isDefined(mdl_icon)) {
    if(function_be3ae9c5(newval)) {
      e_player.var_74eaa305 = newval;
    }

    return;
  }

  if(!function_be3ae9c5(newval)) {
    e_player.var_74eaa305 = undefined;
    var_16c042b8 = e_player function_35ba0b0e(localclientnum, n_slot);

    if(isDefined(var_16c042b8) && isDefined(level._custom_perks[var_16c042b8])) {
      var_c1cbeea5 = level._custom_perks[var_16c042b8].var_4fbc4ea9;

      if(level.var_c3e5c4cd == 2) {
        var_fe0b737a = level._custom_perks[var_16c042b8].var_347c72d2;
      } else {
        var_fe0b737a = level._effect[#"altar_icon_ambient_fx"];
      }
    } else {
      var_c1cbeea5 = #"tag_origin";
      var_fe0b737a = level._effect[#"altar_icon_ambient_fx"];
    }

    mdl_icon setModel(var_c1cbeea5);

    if(!function_be3ae9c5(oldval, 1)) {
      return;
    }
  }

  mdl_icon thread function_bde5bc78(localclientnum, var_fe0b737a, newval, oldval);
}

function_bde5bc78(localclientnum, var_fe0b737a, newval, oldval) {
  level endon(#"demo_jump");
  n_start_time = gettime();
  n_end_time = n_start_time + int(0.5 * 1000);

  if(!function_be3ae9c5(newval)) {
    self setscale(1);

    if(!isDefined(self getlinkedent())) {
      self.origin = self.mdl_altar gettagorigin("tag_icon_link");
      self linkto(self.mdl_altar, "tag_icon_link");
    }

    if(level.var_c3e5c4cd == 2) {
      self.mdl_altar.var_be82764e = self.mdl_altar.var_874350df;
      self.mdl_altar function_5b123b68(localclientnum, 1);
    }

    if(isDefined(var_fe0b737a)) {
      self.var_2efc1a24 = util::playFXOnTag(localclientnum, var_fe0b737a, self, "tag_origin");
    }

    v_forward = anglesToForward(self.angles) * 5;
    v_fx_origin = self.origin + (v_forward[0], v_forward[1], 3);
    playFX(localclientnum, level._effect[#"hash_7c3a9f5103c06ff6"], v_fx_origin);

    while(isDefined(self)) {
      n_time = gettime();

      if(n_time >= n_end_time) {
        self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", 1);
        self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", 1);
        return;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }

      self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", n_shader_value);
      self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", n_shader_value);
      wait 0.01;
    }

    return;
  }

  if(level.var_c3e5c4cd == 2) {
    if(newval == 7) {
      self.mdl_altar function_5b123b68(localclientnum, 0);
    } else {
      self.mdl_altar.var_be82764e = level._effect[#"hash_26247c4bfd6fed73"];
      self.mdl_altar function_5b123b68(localclientnum, 1, 1);
    }
  }

  if(function_be3ae9c5(oldval)) {}

  if(isDefined(self.var_2efc1a24)) {
    killfx(localclientnum, self.var_2efc1a24);
    self.var_2efc1a24 = undefined;
  }

  if(newval == 6) {
    self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", 0);
    self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", 0);
    return;
  }

  self unlink();
  v_forward = anglesToForward(self.angles) * 5;
  v_fx_origin = self.origin + (v_forward[0], v_forward[1], 3);
  playFX(localclientnum, level._effect[#"hash_57c8c9eff08ddf44"], v_fx_origin);
  self moveto(self.origin - anglesToForward(self.angles) * 2, 0.5);

  while(isDefined(self)) {
    n_time = gettime();

    if(n_time >= n_end_time) {
      self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", 0);
      self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", 0);
      return;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      var_6da3d352 = mapfloat(n_start_time, n_end_time, 1, 1.5, n_time);
    }

    self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", n_shader_value);
    self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", n_shader_value);
    self setscale(var_6da3d352);
    wait 0.01;
  }
}

function_5b123b68(localclientnum, b_show, b_use_offset = 0) {
  if(isDefined(self.var_d67a4862)) {
    stopfx(localclientnum, self.var_d67a4862);
  }

  if(b_show) {
    v_angles = self gettagangles("fx_tag_base_emblem");
    v_origin = self gettagorigin("fx_tag_base_emblem");

    if(b_use_offset && isDefined(self.var_7ad76c54)) {
      v_origin -= anglesToForward(v_angles) * self.var_7ad76c54;
    }

    self.var_d67a4862 = playFX(localclientnum, self.var_be82764e, v_origin, anglesToForward(v_angles));
    return;
  }

  self.var_d67a4862 = undefined;
}

private function_be3ae9c5(n_value, var_51e3f61d = 0) {
  if(n_value < 5) {
    if(var_51e3f61d && n_value == 0) {
      return true;
    }

    return false;
  }

  return true;
}

function_9b4bc8e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"demo_jump");

  if(newval) {
    while(!isDefined(level.var_aaf8da70)) {
      waitframe(1);
      level.var_aaf8da70 = getent(localclientnum, "zeus_bird_head", "targetname");
    }

    util::playFXOnTag(localclientnum, level._effect[#"hash_46334db9e3c76275"], level.var_aaf8da70, "bird_follow_jnt");
    level.var_aaf8da70 thread function_6a0a572d(localclientnum);
  }
}

function_6a0a572d(localclientnum) {
  level endon(#"demo_jump");
  self endon(#"death");

  while(true) {
    wait randomintrange(5, 20);
    self playSound(localclientnum, #"hash_62f87027921fa5b4");
  }
}

function_52c149b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(level.var_aaf8da70)) {
      level.var_aaf8da70 = util::spawn_model(localclientnum, "p8_fxanim_zm_vapor_altar_zeus_bird_head_mod", self gettagorigin("tag_bird_head"), self gettagangles("tag_bird_head"));
      level.var_aaf8da70.targetname = "zeus_bird_head";
    }
  }
}

function_ab7cd429(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"demo_jump");

  if(!isDefined(level.var_aaf8da70)) {
    level.var_aaf8da70 = getent(localclientnum, "zeus_bird_head", "targetname");
  }

  var_aaf8da70 = level.var_aaf8da70;

  if(!isDefined(var_aaf8da70)) {
    return;
  }

  var_aaf8da70 endon(#"death");

  if(!isDefined(level.var_245eb09f)) {
    level.var_245eb09f = var_aaf8da70.angles;

    if(level.var_245eb09f[1] == 360) {
      level.var_245eb09f = (0, 0, 0);
    }
  }

  level notify(#"hash_4d8d403fdb281b69");
  wait 0.5;

  if(newval == 0) {
    var_6d877f48 = array::random(array((7, 7, 7), (-7, -7, -7), (-7, 7, 7), (7, -7, -7)));
    var_aaf8da70 rotateto(level.var_245eb09f + var_6d877f48, 0.2);
    wait 0.8;
    var_aaf8da70 rotateto(level.var_245eb09f, 0.1);
    return;
  }

  var_165f12bb = array::random(array((17, 30, 25), (-10, -30, -25), (-10, 30, 25), (17, -30, -25)));
  var_aaf8da70 rotateto(level.var_245eb09f + var_165f12bb, 0.15);
  var_aaf8da70 thread function_1625e105(self);
}

function_1625e105(e_player) {
  if(!isDefined(e_player)) {
    return;
  }

  level endon(#"demo_jump", #"hash_4d8d403fdb281b69");
  e_player endon(#"death");
  self endon(#"death");
  wait 1;

  while(isDefined(e_player)) {
    var_d1d1cc92 = e_player gettagorigin("j_head");

    if(!isDefined(var_d1d1cc92)) {
      var_d1d1cc92 = e_player.origin;
    }

    if(vectordot(vectornormalize(var_d1d1cc92 - self.origin), anglesToForward(level.var_245eb09f)) > 0.5) {
      var_a8dcfa = vectortoangles(var_d1d1cc92 - self.origin);
      self rotateto(var_a8dcfa, 0.15);
    }

    wait 0.15;
  }
}