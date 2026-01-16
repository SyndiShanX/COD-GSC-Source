/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_ley_line.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace namespace_a8113e97;

init_clientfields() {
  clientfield::register("allplayers", "" + #"hash_5370f4bc9fc25d13", 8000, 1, "int", &function_bdecc239, 0, 1);
  clientfield::register("scriptmover", "" + #"ley_lines", 8000, 2, "int", &ley_lines, 0, 0);
  clientfield::register("scriptmover", "" + #"power_beam", 8000, 2, "int", &power_beam, 0, 0);
  clientfield::register("scriptmover", "" + #"red_ray", 8000, 2, "int", &red_ray, 0, 0);
  clientfield::register("scriptmover", "" + #"green_ray", 8000, 2, "int", &green_ray, 0, 0);
  clientfield::register("scriptmover", "" + #"blue_ray", 8000, 2, "int", &blue_ray, 0, 0);
  clientfield::register("scriptmover", "" + #"stone_glow", 8000, 1, "int", &function_b75c6b4f, 0, 0);
  clientfield::register("scriptmover", "" + #"stone_despawn", 8000, 1, "counter", &function_dea9fad1, 0, 0);
  clientfield::register("scriptmover", "" + #"stone_soul", 8000, 1, "int", &function_6628d887, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_34c5ab29531f15f0", 8000, 1, "int", &crystal_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_546e7612359187c3", 8000, 1, "counter", &function_a0d4ae11, 0, 0);
  clientfield::register("toplayer", "" + #"mansion_mq_rumble", 8000, 1, "counter", &mansion_mq_rumble, 0, 0);
  clientfield::register("world", "" + #"skybox_stream", 8000, 1, "int", &function_bca55d4e, 0, 0);
  level._effect[#"red_ray"] = #"hash_7046110ad3c65161";
  level._effect[#"green_ray"] = #"hash_532ac819595d9bb5";
  level._effect[#"blue_ray"] = #"hash_4a495cef0ef4aee2";
  level._effect[#"hash_415a43ea0ce519d0"] = #"hash_6a1ab09280787b72";
  level._effect[#"hash_52032416326181f0"] = #"hash_2cd1f480eb43a66e";
  level._effect[#"hash_4588a89d6156133b"] = #"hash_547b680a63dd5023";
  level._effect[#"hash_250f495cbd75db2a"] = #"zombie/fx8_doorbuy_death";
  level._effect[#"hash_52d102bc9f3a4964"] = #"hash_1e6d673cdbbf3f40";
  level._effect[#"hash_52d7eebc9f404616"] = #"hash_1e74733cdbc57252";
}

function_a0d4ae11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self util::playFXOnTag(localclientnum, #"hash_71f448e1a71c505d", self, "tag_origin");
  }
}

mansion_mq_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrumbleonentity(localclientnum, "zm_mansion_mq_rumble");
  }
}

crystal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    if(isDefined(self.var_de4f1b63)) {
      stopfx(localclientnum, self.var_de4f1b63);
      self.var_de4f1b63 = undefined;
    } else {
      self.var_2efc1a24 = util::playFXOnTag(localclientnum, #"hash_4d334fce6095f749", self, "tag_origin");
    }

    if(isDefined(self.var_52baf800)) {
      self stoploopsound(self.var_52baf800);
    }

    return;
  }

  if(isDefined(self.var_2efc1a24)) {
    stopfx(localclientnum, self.var_2efc1a24);
    self.var_2efc1a24 = undefined;
  }

  self.var_de4f1b63 = util::playFXOnTag(localclientnum, #"hash_335e6ce4ca3a37b3", self, "tag_origin");

  if(!isDefined(self.var_52baf800)) {
    self.var_52baf800 = self playLoopSound(#"hash_67377acc9921b8fe");
  }

  self stoprenderoverridebundle(#"hash_309e494aade1703c");
  self playrenderoverridebundle(#"hash_591c2c7461c7beed");
}

function_6628d887(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_19fc85d = util::playFXOnTag(localclientnum, level._effect[#"pap_projectile"], self, "tag_origin");
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"pap_projectile_end"], self, "tag_origin");

  if(isDefined(self.var_19fc85d)) {
    stopfx(localclientnum, self.var_19fc85d);
    self.var_19fc85d = undefined;
  }
}

function_dea9fad1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect[#"hash_250f495cbd75db2a"], self.origin);
  }
}

function_b75c6b4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self function_f6e99a8d(#"hash_7f2b5509bb2ebd3f");
    self playrenderoverridebundle(#"hash_7f2b5509bb2ebd3f");
    return;
  }

  self stoprenderoverridebundle(#"hash_7f2b5509bb2ebd3f");
}

red_ray(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_c04854d8)) {
    stopfx(localclientnum, self.var_c04854d8);
    self.var_c04854d8 = undefined;
  }

  if(isDefined(self.var_a5575986)) {
    stopfx(localclientnum, self.var_a5575986);
    self.var_a5575986 = undefined;
    playSound(localclientnum, #"hash_7959a9d39417b936", self.origin);
  }

  if(newval == 1) {
    self.var_c04854d8 = util::playFXOnTag(localclientnum, level._effect[#"red_ray"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_a5575986 = util::playFXOnTag(localclientnum, level._effect[#"hash_415a43ea0ce519d0"], self, "tag_origin");
    playSound(localclientnum, #"hash_21707843209589cf", self.origin);
  }
}

green_ray(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_b3fcc406)) {
    stopfx(localclientnum, self.var_b3fcc406);
    self.var_b3fcc406 = undefined;
  }

  if(isDefined(self.var_5092defe)) {
    stopfx(localclientnum, self.var_5092defe);
    self.var_5092defe = undefined;
    playSound(localclientnum, #"hash_7959a9d39417b936", self.origin);
  }

  if(newval == 1) {
    self.var_b3fcc406 = util::playFXOnTag(localclientnum, level._effect[#"green_ray"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_5092defe = util::playFXOnTag(localclientnum, level._effect[#"hash_52032416326181f0"], self, "tag_origin");
    playSound(localclientnum, #"hash_2170794320958b82", self.origin);
  }
}

blue_ray(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_f17dcf6b)) {
    stopfx(localclientnum, self.var_f17dcf6b);
    self.var_f17dcf6b = undefined;
  }

  if(isDefined(self.var_47ae8f53)) {
    stopfx(localclientnum, self.var_47ae8f53);
    self.var_47ae8f53 = undefined;
    playSound(localclientnum, #"hash_7959a9d39417b936", self.origin);
  }

  if(newval == 1) {
    self.var_f17dcf6b = util::playFXOnTag(localclientnum, level._effect[#"blue_ray"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_47ae8f53 = util::playFXOnTag(localclientnum, level._effect[#"hash_4588a89d6156133b"], self, "tag_origin");
    playSound(localclientnum, #"hash_21707a4320958d35", self.origin);
  }
}

ley_lines(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_8709ee5a)) {
    level.var_8709ee5a = [];
  } else if(!isarray(level.var_8709ee5a)) {
    level.var_8709ee5a = array(level.var_8709ee5a);
  }

  if(newval == 1) {
    var_db37a1f6 = "beam_man_";

    if(!isDefined(level.var_8709ee5a)) {
      level.var_8709ee5a = [];
    } else if(!isarray(level.var_8709ee5a)) {
      level.var_8709ee5a = array(level.var_8709ee5a);
    }

    level.var_8709ee5a[level.var_8709ee5a.size] = util::playFXOnTag(localclientnum, #"hash_580bb2a71ac88814", self, "tag_origin");
  } else if(newval == 2) {
    var_79b95a68 = getent(localclientnum, "beam_man_2", "targetname");
    var_f1b20bef = getent(localclientnum, "beam_man_3", "targetname");
    level beam::kill(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", "beam8_zm_mansion_cemetery_observatory_sm");
    var_db37a1f6 = "beam_obs_";
  } else if(newval == 3) {
    var_db37a1f6 = "beam_obs_";
  } else {
    var_db37a1f6 = "beam_man_";
  }

  self function_81f056fe(localclientnum, newval, var_db37a1f6);

  if(newval == 0) {
    if(isDefined(level.var_8709ee5a)) {
      foreach(n_fx in level.var_8709ee5a) {
        stopfx(localclientnum, n_fx);
      }

      level.var_8709ee5a = undefined;
    }
  }
}

function_81f056fe(localclientnum, newval, var_db37a1f6) {
  if(!isDefined(level.var_8709ee5a)) {
    level.var_8709ee5a = [];
  } else if(!isarray(level.var_8709ee5a)) {
    level.var_8709ee5a = array(level.var_8709ee5a);
  }

  var_79b95a68 = self;

  for(i = 0; i < 3; i++) {
    if(!isDefined(var_79b95a68)) {
      var_79b95a68 = getent(localclientnum, var_db37a1f6 + i, "targetname");
    }

    var_f1b20bef = getent(localclientnum, var_db37a1f6 + i + 1, "targetname");

    if(isDefined(var_79b95a68) && isDefined(var_f1b20bef)) {
      if(i == 2 && var_db37a1f6 == "beam_man_" || i == 0 && var_db37a1f6 == "beam_obs_") {
        str_beam = "beam8_zm_mansion_cemetery_observatory_sm";
      } else {
        str_beam = "beam8_zm_mansion_cemetery_observatory";
      }

      if(newval == 1 || newval == 2) {
        level beam::launch(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", str_beam, 1);
        soundlineemitter(#"hash_1c73b17d13624a48", var_79b95a68.origin, var_f1b20bef.origin);

        if(var_f1b20bef.targetname === "beam_obs_3") {
          if(!isDefined(level.var_8709ee5a)) {
            level.var_8709ee5a = [];
          } else if(!isarray(level.var_8709ee5a)) {
            level.var_8709ee5a = array(level.var_8709ee5a);
          }

          level.var_8709ee5a[level.var_8709ee5a.size] = util::playFXOnTag(localclientnum, #"hash_c6b5dc9777950d8", var_f1b20bef, "tag_origin");
        } else if(var_f1b20bef.targetname === "beam_man_2" || var_f1b20bef.targetname === "beam_obs" || var_f1b20bef.targetname === "beam_obs_2") {
          if(!isDefined(level.var_8709ee5a)) {
            level.var_8709ee5a = [];
          } else if(!isarray(level.var_8709ee5a)) {
            level.var_8709ee5a = array(level.var_8709ee5a);
          }

          level.var_8709ee5a[level.var_8709ee5a.size] = util::playFXOnTag(localclientnum, #"hash_b87fed38a9f91a", var_f1b20bef, "tag_origin");
        } else if(var_f1b20bef.targetname === "beam_man_1" || var_f1b20bef.targetname === "beam_obs_1") {
          if(!isDefined(level.var_8709ee5a)) {
            level.var_8709ee5a = [];
          } else if(!isarray(level.var_8709ee5a)) {
            level.var_8709ee5a = array(level.var_8709ee5a);
          }

          level.var_8709ee5a[level.var_8709ee5a.size] = playFX(localclientnum, #"hash_b87fed38a9f91a", var_f1b20bef.origin, anglesToForward(var_f1b20bef.angles) * -1, anglestoup(var_f1b20bef.angles));
        }
      } else {
        level beam::kill(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", str_beam);
        soundstoplineemitter(#"hash_1c73b17d13624a48", var_79b95a68.origin, var_f1b20bef.origin);
      }
    }

    waitframe(5);

    if((newval == 0 || newval == 3) && var_79b95a68 !== self) {
      if(isDefined(var_79b95a68)) {
        var_79b95a68 delete();
      }

      continue;
    }

    var_79b95a68 = undefined;
  }

  if(newval == 0 || newval == 3) {
    if(isDefined(var_f1b20bef)) {
      var_f1b20bef delete();
    }
  }
}

function_bca55d4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    forcestreammaterial("mc/mtl_skybox_zm_mansion_exposed_moon");
    return;
  }

  stopforcestreamingmaterial("mc/mtl_skybox_zm_mansion_exposed_moon");
}

power_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.e_target = getent(localclientnum, "obs_target", "targetname");
    v_angles = self gettagangles("tag_fx_beam");
    v_end = self.origin + anglesToForward(v_angles) * 9999;
    self.e_target.origin = v_end;
    self.e_target.angles = v_angles;

    if(newval == 2) {
      self.var_f7aa5696 = util::playFXOnTag(localclientnum, #"hash_7fff0aac54c2724c", self, "tag_fx_beam");
    } else {
      self.var_f7aa5696 = util::playFXOnTag(localclientnum, #"hash_27c3041be4fa392e", self, "tag_fx_beam");
    }

    self.var_bd83c74d = util::playFXOnTag(localclientnum, #"hash_73298f54156f81e4", self.e_target, "tag_origin");
    return;
  }

  if(isDefined(self.var_f7aa5696)) {
    stopfx(localclientnum, self.var_f7aa5696);
    self.var_f7aa5696 = undefined;
  }

  if(isDefined(self.var_bd83c74d)) {
    stopfx(localclientnum, self.var_bd83c74d);
    self.var_bd83c74d = undefined;
  }
}

function_bdecc239(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(self.var_22364243)) {
      if(zm_utility::function_f8796df3(localclientnum)) {
        self.var_22364243 = playviewmodelfx(localclientnum, level._effect[#"hash_52d102bc9f3a4964"], "tag_weapon_left");
      } else {
        self.var_22364243 = util::playFXOnTag(localclientnum, level._effect[#"hash_52d7eebc9f404616"], self, "tag_weapon_left");
      }
    }

    if(!isDefined(self.var_1fd2907d)) {
      if(zm_utility::function_f8796df3(localclientnum)) {
        self.var_1fd2907d = self playLoopSound(#"hash_459db861d003fae1");
      } else {
        self.var_1fd2907d = self playLoopSound(#"hash_48e1d623c45d8a0");
      }
    }

    return;
  }

  if(isDefined(self.var_22364243)) {
    deletefx(localclientnum, self.var_22364243);
    self.var_22364243 = undefined;
  }

  if(isDefined(self.var_1fd2907d)) {
    self stoploopsound(self.var_1fd2907d);
    self.var_1fd2907d = undefined;
    self playSound(localclientnum, #"hash_7bf00147e0370d89");
  }
}