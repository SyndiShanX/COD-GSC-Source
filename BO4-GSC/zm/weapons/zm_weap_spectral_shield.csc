/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spectral_shield.csc
**************************************************/

#include script_70ab01a7690ea256;
#include scripts\core_common\array_shared;
#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_spectral_shield;

autoexec __init__system__() {
  system::register(#"zm_weap_spectral_shield", &__init__, &__main__, undefined);
}

__init__() {
  level.var_4e845c84 = getweapon(#"zhield_spectral_turret");
  level.var_22a393d4 = [];
  clientfield::register("allplayers", "" + #"afterlife_vision_play", 1, 1, "int", &afterlife_vision_play, 0, 0);
  clientfield::register("toplayer", "" + #"afterlife_window", 1, 1, "int", &afterlife_window, 0, 0);
  clientfield::register("scriptmover", "" + #"afterlife_entity_visibility", 1, 2, "int", &afterlife_entity_visibility, 0, 0);
  clientfield::register("allplayers", "" + #"spectral_key_beam_fire", 1, 1, "int", &spectral_key_beam_fire, 0, 1);
  clientfield::register("allplayers", "" + #"spectral_key_beam_flash", 1, 2, "int", &function_f9a03171, 0, 0);
  n_bits = getminbitcountfornum(4);
  clientfield::register("actor", "" + #"zombie_spectral_key_stun", 1, n_bits, "int", &function_b570d455, 0, 0);
  clientfield::register("vehicle", "" + #"zombie_spectral_key_stun", 1, n_bits, "int", &function_b570d455, 0, 0);
  clientfield::register("scriptmover", "" + #"zombie_spectral_key_stun", 1, n_bits, "int", &function_b570d455, 0, 0);
  clientfield::register("scriptmover", "" + #"spectral_key_essence", 1, 1, "int", &function_5655dc55, 0, 0);
  clientfield::register("allplayers", "" + #"hash_7663ae2eb866d2eb", 1, 1, "counter", &function_50119cc1, 0, 0);
  clientfield::register("allplayers", "" + #"spectral_key_charging", 1, 2, "int", &function_36c349d0, 0, 0);
  clientfield::register("allplayers", "" + #"spectral_shield_blast", 1, 1, "counter", &function_6b58c030, 0, 0);
  clientfield::register("scriptmover", "" + #"shield_crafting_fx", 1, 1, "counter", &shield_crafting_fx, 0, 0);
  clientfield::register("actor", "" + #"spectral_blast_death", 1, 1, "int", &spectral_blast_death, 0, 0);
  clientfield::register("allplayers", "" + #"zombie_spectral_heal", 1, 1, "counter", &function_3f83a22f, 0, 0);
  level._effect[#"spectral_key_muzzle_flash1p"] = #"hash_1897770e10623dab";
  level._effect[#"spectral_key_muzzle_flash3p"] = #"hash_18906b0e105c0a99";
  level._effect[#"spectral_key_muzzle_flash1p_idle"] = #"hash_74f3e07770b3c780";
  level._effect[#"spectral_key_muzzle_flash3p_idle"] = #"hash_74faec7770b9fa92";
  level._effect[#"hash_5a834a39ce281cef"] = #"hash_42b1e9abdde1d678";
  level._effect[#"hash_6ca5cf8a3ac2254a"] = #"hash_6894b23015ff2626";
  level._effect[#"hash_5e08e3b80445f6d7"] = #"hash_db890f21c0af009";
  level._effect[#"hash_5e01d7b8043fc3c5"] = #"hash_dbf9cf21c11231b";
  level._effect[#"hash_3ae08d08271270d6"] = #"hash_35b66c4bdba4f1a8";
  level._effect[#"hash_3ad9a108270c7424"] = #"hash_35bd784bdbab24ba";
  level._effect[#"hash_4a41e8484e30822e"] = #"hash_55a201e66dbc23d3";
  level._effect[#"hash_4a3bdc484e2c021c"] = #"hash_559b15e66db62721";
  level._effect[#"hash_29b0420a85baa71b"] = #"hash_4a8de7cdf2716f1b";
  level._effect[#"hash_28b1c64bd72686eb"] = #"hash_5e46c3cecd080eeb";
  level._effect[#"hash_a64dd624f3d5eff"] = #"hash_3a4825045da5aa1f";
  level._effect[#"hash_a5ef1624f39154d"] = #"hash_3a4139045d9fad6d";
  level._effect[#"air_blast"] = #"hash_70630dd76a790b4";
  level._effect[#"hash_3757ad652a2b0e54"] = #"hash_382d55804b58cfcb";
  level._effect[#"shield_crafting"] = #"hash_1e261e7fd620ac9e";
  level._effect[#"spectral_heal"] = #"zombie/fx_bgb_near_death_3p";
}

__main__() {}

afterlife_vision_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_1d12110c)) {
    self.var_1d12110c = [];
  }

  if(newval == 1) {
    if(!isDefined(self.weapon)) {
      return;
    }

    if(!function_98890cd8(self.weapon)) {
      return;
    }

    if(self getlocalclientnumber() === localclientnum) {
      if(!isdemoplaying() && !namespace_a6aea2c6::is_active(#"silent_film")) {
        self thread postfx::playpostfxbundle(#"hash_529f2ffb7f62ca50");
        a_e_players = getlocalplayers();

        foreach(e_player in a_e_players) {
          if(!e_player util::function_50ed1561(localclientnum)) {
            e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_529f2ffb7f62ca50", #"hash_242ff4bae72c27b3");
          }
        }
      }

      level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);

      foreach(e_vision in level.var_22a393d4) {
        if(isDefined(e_vision.show_function)) {
          e_vision.var_a5a0e616 = 1;
          e_vision thread[[e_vision.show_function]](localclientnum);
        }
      }

      self thread function_85e7adcf(localclientnum);
    } else {
      self.var_1d12110c[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_3757ad652a2b0e54"], self, "tag_window_fx");
    }

    return;
  }

  if(self getlocalclientnumber() === localclientnum) {
    self notify(#"hash_eefcf8215207987");
    self postfx::stoppostfxbundle(#"hash_529f2ffb7f62ca50");
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player notify(#"hash_242ff4bae72c27b3");
      }
    }

    level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);

    foreach(e_vision in level.var_22a393d4) {
      if(isDefined(e_vision.hide_function)) {
        e_vision.var_a5a0e616 = undefined;
        e_vision thread[[e_vision.hide_function]](localclientnum);
      }
    }

    return;
  }

  if(isDefined(self.var_1d12110c[localclientnum])) {
    stopfx(localclientnum, self.var_1d12110c[localclientnum]);
    self.var_1d12110c[localclientnum] = undefined;
  }
}

private function_85e7adcf(localclientnum) {
  self endon(#"death", #"hash_eefcf8215207987");
  var_61467197 = level.var_22a393d4.size;

  while(true) {
    if(var_61467197 !== level.var_22a393d4.size) {
      level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);

      foreach(e_vision in level.var_22a393d4) {
        if(isDefined(e_vision.show_function) && !(isDefined(e_vision.var_a5a0e616) && e_vision.var_a5a0e616)) {
          e_vision.var_a5a0e616 = 1;
          e_vision thread[[e_vision.show_function]](localclientnum);
        }
      }

      var_61467197 = level.var_22a393d4.size;
    }

    wait 0.1;
  }
}

afterlife_window(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrenderoverridebundle("rob_shield_window");
    return;
  }

  self stoprenderoverridebundle("rob_shield_window");
}

afterlife_entity_visibility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(!isDefined(level.var_22a393d4)) {
      level.var_22a393d4 = [];
    } else if(!isarray(level.var_22a393d4)) {
      level.var_22a393d4 = array(level.var_22a393d4);
    }

    if(!isinarray(level.var_22a393d4, self)) {
      level.var_22a393d4[level.var_22a393d4.size] = self;
    }

    self.show_function = &function_f66111c5;
    self.hide_function = &function_5681824;
    self hide();
    return;
  }

  if(newval == 2) {
    self notify(#"set_grabbed");
    self.b_seen = undefined;
    self.hide_function = undefined;
    self playrenderoverridebundle("rob_skull_grab");
    self show();
  }
}

function_f66111c5(localclientnum) {
  self endon(#"death", #"set_grabbed");
  self playrenderoverridebundle("rob_spectral_vision");
  self show();
}

function_5681824(localclientnum) {
  self endon(#"death", #"set_grabbed");
  self stoprenderoverridebundle("rob_spectral_vision");
}

spectral_blast_death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_39306eaa)) {
    deletefx(localclientnum, self.var_39306eaa, 1);
    self.var_39306eaa = undefined;
  }

  if(newval == 1) {
    str_tag = "j_spineupper";

    if(self.archetype == #"zombie_dog") {
      str_tag = "j_spine1";
    }

    self.var_39306eaa = util::playFXOnTag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], self, str_tag);
  }
}

spectral_key_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect", #"hash_3ed4154ad2e33ec3");

  if(!isDefined(self.var_2723e767)) {
    self.var_2723e767 = [];
  }

  if(!isDefined(self.var_3e52c79e)) {
    self.var_3e52c79e = [];
  }

  self function_4700b6cd(localclientnum);

  if(newval == 1) {
    self thread function_848179f5(localclientnum);
    self thread function_a950c92c(localclientnum);
    return;
  }

  self notify(#"hash_3ed4154ad2e33ec3");
}

function_a950c92c(localclientnum) {
  self endon(#"death", #"hash_3ed4154ad2e33ec3");

  while(true) {
    level.var_443d1164 = undefined;
    s_result = level waittill(#"hash_73ff8d0d706c332d", #"hash_527d9fdde8903b80");
    level.var_443d1164 = 1;
    self function_4700b6cd(localclientnum);

    if(s_result._notify === #"hash_73ff8d0d706c332d" && s_result.e_attacker === self && isDefined(s_result.e_target)) {
      var_3da509de = s_result.e_target;
      self thread function_5ab769d8(localclientnum);
      self thread function_28291f40(localclientnum, s_result.e_target);
      continue;
    }

    if(isDefined(var_3da509de) && var_3da509de !== s_result.e_target) {
      continue;
    }

    var_3da509de = undefined;
    self thread function_848179f5(localclientnum);
  }
}

function_4700b6cd(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_4ea2d9a0f785e09b");

  if(isDefined(self.var_3e52c79e[localclientnum])) {
    beamkill(localclientnum, self.var_3e52c79e[localclientnum]);
    self.var_3e52c79e[localclientnum] = undefined;
  }

  if(isDefined(self.var_2723e767[localclientnum])) {
    self.var_2723e767[localclientnum] delete();
    self.var_2723e767[localclientnum] = undefined;
  }

  if(isDefined(self.var_4cd8e6cb)) {
    self stoploopsound(self.var_4cd8e6cb);
    self.var_4cd8e6cb = undefined;
    self playSound(localclientnum, #"hash_3126b098b980b5a3");
  }
}

function_848179f5(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_4ea2d9a0f785e09b");

  if(!isDefined(self.var_4cd8e6cb)) {
    self playSound(localclientnum, #"hash_3765e25049981166");
    self.var_4cd8e6cb = self playLoopSound(#"hash_170aa1970243fc4a");
  }

  self thread function_64148d8e(localclientnum);
}

function_64148d8e(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_4ea2d9a0f785e09b");
  wait 0.5;

  if(isDefined(self) && isDefined(self.var_4cd8e6cb)) {
    self stoploopsound(self.var_4cd8e6cb);
    self.var_4cd8e6cb = undefined;
    self playSound(localclientnum, #"hash_3126b098b980b5a3");
  }
}

function_28291f40(localclientnum, e_target) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_4ea2d9a0f785e09b");

  if(!isDefined(self.var_4cd8e6cb)) {
    self playSound(localclientnum, #"hash_3765e25049981166");
    self.var_4cd8e6cb = self playLoopSound(#"hash_170aa1970243fc4a");
  }

  var_1f694afe = "j_spinelower";

  if(e_target isai()) {
    if(e_target.archetype == #"zombie_dog") {
      var_1f694afe = "j_spine1";
    } else if(!isDefined(e_target gettagorigin(var_1f694afe))) {
      var_1f694afe = "tag_origin";
    }

    self.var_2723e767[localclientnum] = util::spawn_model(localclientnum, "tag_origin", e_target gettagorigin(var_1f694afe));
  } else if(e_target.type == "scriptmover") {
    var_1f694afe = "tag_origin";
    self.var_2723e767[localclientnum] = util::spawn_model(localclientnum, "tag_origin", e_target.origin);
  }

  self.var_2723e767[localclientnum] linkto(e_target, var_1f694afe);
  self.var_3e52c79e[localclientnum] = level beam::function_cfb2f62a(localclientnum, self, "tag_shield_key_fx", self.var_2723e767[localclientnum], "tag_origin", "beam8_zm_shield_key_ray_targeted");
}

function_f9a03171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.fx_muzzle_flash)) {
    self.fx_muzzle_flash = [];
  }

  if(isDefined(self.fx_muzzle_flash[localclientnum])) {
    deletefx(localclientnum, self.fx_muzzle_flash[localclientnum]);
    self.fx_muzzle_flash[localclientnum] = undefined;
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      e_player notify(#"hash_52e05d0e2370536d");
    }
  }

  if(newval == 1) {
    var_27aa6343 = "spectral_key_muzzle_flash1p_idle";
    var_a1f103c8 = "spectral_key_muzzle_flash3p_idle";

    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_27aa6343], "tag_flash");
    } else {
      self.fx_muzzle_flash[localclientnum] = util::playFXOnTag(localclientnum, level._effect[var_a1f103c8], self, "tag_flash");
    }

    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player thread zm_utility::function_ae3780f1(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
      }
    }

    return;
  }

  if(newval == 2) {
    var_27aa6343 = "spectral_key_muzzle_flash1p";
    var_a1f103c8 = "spectral_key_muzzle_flash3p";

    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_27aa6343], "tag_flash");
    } else {
      self.fx_muzzle_flash[localclientnum] = util::playFXOnTag(localclientnum, level._effect[var_a1f103c8], self, "tag_flash");
    }

    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player thread zm_utility::function_ae3780f1(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
      }
    }
  }
}

function_3f83a22f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_local_player = function_5c10bd79(localclientnum);

  if(e_local_player != self) {
    if(!isDefined(self.var_aa9e07fe)) {
      self.var_aa9e07fe = [];
    }

    if(isDefined(self.var_aa9e07fe[localclientnum])) {
      return;
    }

    if(!(isDefined(self.var_5427d523) && self.var_5427d523)) {
      self.var_5427d523 = 1;
      self.var_aa9e07fe[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"spectral_heal"], self, "j_spine4");
      fxhandle = self.var_aa9e07fe[localclientnum];
      wait 0.5;

      if(isDefined(fxhandle)) {
        stopfx(localclientnum, fxhandle);

        if(isDefined(self)) {
          self.var_aa9e07fe[localclientnum] = undefined;
          self.var_5427d523 = undefined;
        }
      }
    }
  }
}

private function_5ab769d8(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_360be32d770a6eb2");
  self endon(#"death", #"hash_360be32d770a6eb2", #"hash_4ea2d9a0f785e09b");
  self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_hit_rumble");
  wait 0.5;

  while(true) {
    if(isplayer(self) && self function_21c0fa55()) {
      self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_rumble");
    }

    wait 0.5;
  }
}

function_b570d455(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 0) {
    if(self isai()) {
      if(isDefined(self.var_961fed16)) {
        deletefx(localclientnum, self.var_961fed16, 1);
      }

      self.var_961fed16 = undefined;

      if(isDefined(self.var_5024b58) && self.var_5024b58) {
        zm_utility::function_704f7c0e(localclientnum);
        self.var_5024b58 = undefined;
      }
    } else if(isDefined(self.var_961fed16)) {
      deletefx(localclientnum, self.var_961fed16, 1);
      self.var_961fed16 = undefined;
    }

    if(isDefined(self.var_3415a5d7)) {
      self stoploopsound(self.var_3415a5d7);
      self.var_3415a5d7 = undefined;
    }

    level thread function_3dec76cb(localclientnum, self, undefined, 0);
    return;
  }

  e_attacker = getentbynum(localclientnum, newval - 1);

  if(self isai() && !(isDefined(self.isvehicle) && self.isvehicle)) {
    if(!isDefined(self.var_961fed16)) {
      str_tag = self zm_utility::function_467efa7b();
      self.var_961fed16 = util::playFXOnTag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, str_tag);
    }

    if(!(isDefined(self.var_5024b58) && self.var_5024b58) && self.archetype !== #"ghost") {
      zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_blue", level._effect[#"hash_6ca5cf8a3ac2254a"]);
      self.var_5024b58 = 1;
    }
  } else if(!isDefined(self.var_961fed16)) {
    self.var_961fed16 = util::playFXOnTag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, "tag_origin");
  }

  if(!isDefined(self.var_3415a5d7)) {
    self.var_3415a5d7 = self playLoopSound(#"hash_4c803bdbf30dd7fc");
  }

  level thread function_3dec76cb(localclientnum, self, e_attacker, 1);
}

function_3dec76cb(localclientnum, e_target, e_attacker, var_19f39a16 = 1) {
  if(isDefined(var_19f39a16) && var_19f39a16) {
    waitframe(1);
  }

  while(isDefined(level.var_443d1164) && level.var_443d1164) {
    waitframe(1);
  }

  if(!isDefined(e_target)) {
    return;
  }

  if(var_19f39a16) {
    level notify(#"hash_73ff8d0d706c332d", {
      #e_target: e_target, 
      #e_attacker: e_attacker
    });

    if(e_target.archetype === #"zombie_dog") {
      level thread function_9c08e4b6(localclientnum, e_target, e_attacker);
    }

    return;
  }

  level notify(#"hash_527d9fdde8903b80", {
    #e_target: e_target, 
    #e_attacker: e_attacker
  });

  if(isDefined(e_target) && !isalive(e_target) && e_target.archetype === #"zombie") {
    util::playFXOnTag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], e_target, "j_spinelower");
    playSound(localclientnum, #"hash_5eb0bbabfbde1ce8", e_target.origin);
  }
}

function_9c08e4b6(localclientnum, e_target, e_attacker) {
  if(isDefined(e_target)) {
    var_545d6c28 = e_target gettagorigin("j_spine1");
  }

  while(isalive(e_target) && isDefined(e_target.var_961fed16)) {
    var_545d6c28 = e_target gettagorigin("j_spine1");
    waitframe(1);
  }

  level notify(#"hash_527d9fdde8903b80", {
    #e_target: e_target, 
    #e_attacker: e_attacker
  });

  if(!isalive(e_target) && isDefined(var_545d6c28)) {
    playSound(localclientnum, #"hash_5eb0bbabfbde1ce8", var_545d6c28);
  }
}

function_5655dc55(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.var_131284b6)) {
      deletefx(localclientnum, self.var_131284b6, 1);
    }

    self.var_131284b6 = util::playFXOnTag(localclientnum, level._effect[#"hash_29b0420a85baa71b"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_131284b6)) {
    deletefx(localclientnum, self.var_131284b6, 1);
    self.var_131284b6 = undefined;
  }
}

function_36c349d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_2a2f2afa)) {
    self.var_2a2f2afa = [];
  }

  if(!isDefined(self.var_b2b4e5eb)) {
    self.var_b2b4e5eb = [];
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      return;
    }
  }

  if(isDefined(self.var_2a2f2afa[localclientnum])) {
    deletefx(localclientnum, self.var_2a2f2afa[localclientnum], 1);
    self.var_2a2f2afa[localclientnum] = undefined;
    self function_f6e99a8d("rob_key_charging", "tag_weapon_right");
  }

  if(isDefined(self.var_b2b4e5eb[localclientnum])) {
    deletefx(localclientnum, self.var_b2b4e5eb[localclientnum], 1);
    self.var_b2b4e5eb[localclientnum] = undefined;
    self function_f6e99a8d("rob_key_charged", "tag_weapon_right");
  }

  if(!isDefined(self.weapon)) {
    return;
  }

  if(!function_98890cd8(self.weapon)) {
    return;
  }

  if(newval == 1) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_2a2f2afa[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_5e08e3b80445f6d7"], "tag_flash");
      self playrenderoverridebundle("rob_key_charging", "tag_weapon_right");
    } else {
      self.var_2a2f2afa[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_5e01d7b8043fc3c5"], self, "tag_flash");
    }

    self thread function_7203304d(localclientnum);
    return;
  }

  if(newval == 2) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_b2b4e5eb[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_3ae08d08271270d6"], "tag_flash");
      self playrenderoverridebundle("rob_key_charged", "tag_weapon_right");
    } else {
      self.var_2a2f2afa[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_3ad9a108270c7424"], self, "tag_flash");
    }

    self thread function_7203304d(localclientnum);
    return;
  }

  self notify(#"hash_479f7dbb037c00bc");
}

function_7203304d(localclientnum) {
  self endon(#"death", #"disconnect");

  while(true) {
    self waittill(#"weapon_change", #"hash_479f7dbb037c00bc");

    if(!function_98890cd8(self.weapon)) {
      if(isDefined(self.var_2a2f2afa[localclientnum])) {
        deletefx(localclientnum, self.var_2a2f2afa[localclientnum], 1);
        self.var_2a2f2afa[localclientnum] = undefined;
        self function_f6e99a8d("rob_key_charging", "tag_weapon_right");
      }

      if(isDefined(self.var_b2b4e5eb[localclientnum])) {
        deletefx(localclientnum, self.var_b2b4e5eb[localclientnum], 1);
        self.var_b2b4e5eb[localclientnum] = undefined;
        self function_f6e99a8d("rob_key_charged", "tag_weapon_right");
      }

      return;
    }
  }
}

function_50119cc1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!function_98890cd8(self.weapon)) {
    return;
  }

  str_tag = "tag_flash";

  if(!isDefined(self gettagorigin("tag_flash"))) {
    str_tag = "tag_weapon_right";
  }

  if(self zm_utility::function_f8796df3(localclientnum)) {
    playviewmodelfx(localclientnum, level._effect[#"hash_a64dd624f3d5eff"], str_tag);
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"hash_a5ef1624f39154d"], self, str_tag);
}

function_6b58c030(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_3e85852d)) {
    self.var_3e85852d = [];
  }

  w_current = self.weapon;

  if(w_current !== getweapon(#"zhield_spectral_turret") && w_current !== getweapon(#"zhield_spectral_turret_upgraded")) {
    return;
  }

  if(isDefined(self.var_3e85852d[localclientnum])) {
    deletefx(localclientnum, self.var_3e85852d[localclientnum], 1);
  }

  if(self zm_utility::function_f8796df3(localclientnum)) {
    self.var_3e85852d[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_4a41e8484e30822e"], "tag_body_window");
  } else {
    self.var_3e85852d[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_4a3bdc484e2c021c"], self, "tag_body_window");
  }

  util::playFXOnTag(localclientnum, level._effect[#"air_blast"], self, "tag_origin");
  var_d58aab0e = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("tag_flash_window"), self gettagangles("tag_flash_window"));
  var_d58aab0e linkto(self, "tag_flash_window");
  var_d58aab0e scene::play(#"p8_fxanim_zm_esc_blast_afterlife_bundle");
  var_d58aab0e unlink();
  var_d58aab0e delete();

  if(isDefined(self)) {
    if(isDefined(self.var_3e85852d[localclientnum])) {
      deletefx(localclientnum, self.var_3e85852d[localclientnum], 1);
    }

    self.var_3e85852d[localclientnum] = undefined;
  }
}

function_98890cd8(w_current, var_94c10bbd = 0) {
  if(!var_94c10bbd) {
    if(w_current == getweapon(#"zhield_spectral_dw") || w_current == getweapon(#"zhield_spectral_dw_upgraded")) {
      return true;
    }
  }

  if(w_current == getweapon(#"zhield_spectral_turret") || w_current == getweapon(#"zhield_spectral_turret_upgraded")) {
    return true;
  }

  return false;
}

shield_crafting_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"shield_crafting"], self, "tag_origin");
}