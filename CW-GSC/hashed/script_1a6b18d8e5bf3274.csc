/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1a6b18d8e5bf3274.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_a5ef5769;

function private autoexec __init__system__() {
  system::register(#"hash_52556758a0c8acfe", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_47e7d5219a26a786", 16000, 3, "int", &function_dd46bc90, 0, 0);
  clientfield::register("actor", "" + # "hash_3a47820a21ce3170", 16000, 2, "int", &function_219213be, 0, 0);
  clientfield::register("allplayers", "" + # "hash_7508e13e17dd1e3c", 16000, 4, "int", &function_95ad29e7, 0, 0);
}

function postinit() {
  zm_weapons::function_8389c033(#"ww_ray_rifle_t9", #"ww_ray_rifle_t9");
  zm_weapons::function_8389c033(#"ww_ray_rifle_t9", #"ray_gun");
  zm_weapons::function_8389c033(#"ray_gun", #"ww_ray_rifle_t9");
}

function function_dd46bc90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  b_upgraded = 0;

  if(bwastimejump >= 4) {
    b_upgraded = 1;
    bwastimejump -= 4;
  }

  if(bwastimejump == 1) {
    if(b_upgraded) {
      self.var_4334046f = util::playFXOnTag(fieldname, #"hash_72abf2bbd4080e1f", self, "tag_origin");
    } else {
      self.var_4334046f = util::playFXOnTag(fieldname, #"hash_3c2b3ed125f236e6", self, "tag_origin");
    }

    self playSound(fieldname, #"hash_15c9e639d18c2ca5");
    self.var_40c9b27f = self playLoopSound(#"hash_4a6b09eca7bf93b4");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_4334046f)) {
      killfx(fieldname, self.var_4334046f);
      self.var_4334046f = undefined;
    }

    if(isDefined(self.var_40c9b27f)) {
      self stoploopsound(self.var_40c9b27f);
      self.var_40c9b27f = undefined;
    }

    self.var_d5ddfab5 = self playLoopSound(#"hash_b13eb4ecd72cf20");

    if(b_upgraded) {
      self.var_3b5344ab = util::playFXOnTag(fieldname, #"hash_5a8d432da25c54e0", self, "tag_origin");
    } else {
      self.var_3b5344ab = util::playFXOnTag(fieldname, #"hash_2777321a54c631c7", self, "tag_origin");
    }

    return;
  }

  if(bwastimejump == 3) {
    if(b_upgraded) {
      util::playFXOnTag(fieldname, #"hash_6f9ddefafb791163", self, "tag_origin");
    } else {
      util::playFXOnTag(fieldname, #"hash_24ae623f3508b172", self, "tag_origin");
    }

    self playSound(0, "exp_vortex");

    if(isDefined(self.var_d5ddfab5)) {
      self stoploopsound(self.var_d5ddfab5);
      self.var_d5ddfab5 = undefined;
      self playSound(0, "evt_aether_dissipate");
    }

    if(isDefined(self.var_40c9b27f)) {
      self stoploopsound(self.var_40c9b27f);
      self.var_40c9b27f = undefined;
      self playSound(0, "evt_aether_dissipate");
    }

    if(isDefined(self.var_4334046f)) {
      killfx(fieldname, self.var_4334046f);
      self.var_4334046f = undefined;
    }

    if(isDefined(self.var_3b5344ab)) {
      killfx(fieldname, self.var_3b5344ab);
      self.var_3b5344ab = undefined;
    }

    return;
  }

  if(isDefined(self.var_4334046f)) {
    stopfx(fieldname, self.var_4334046f);
    self.var_4334046f = undefined;
  }

  if(isDefined(self.var_3b5344ab)) {
    stopfx(fieldname, self.var_3b5344ab);
    self.var_3b5344ab = undefined;
  }

  if(isDefined(self.var_d5ddfab5)) {
    self stoploopsound(self.var_d5ddfab5);
    self.var_d5ddfab5 = undefined;
    self playSound(0, "evt_aether_dissipate");
  }

  if(isDefined(self.var_40c9b27f)) {
    self stoploopsound(self.var_40c9b27f);
    self.var_40c9b27f = undefined;
    self playSound(0, "evt_aether_dissipate");
  }
}

function function_219213be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_b159952f)) {
    self function_f6e99a8d(self.var_b159952f);
    self.var_b159952f = undefined;
  }

  if(isDefined(self.var_12b59dee)) {
    self function_f6e99a8d(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  var_2ddbe94 = [# "hash_1f5f24e8240c291a", #"hash_16d59f099e418f4f"];

  if(bwastimejump && bwastimejump < var_2ddbe94.size + 1) {
    self.var_b159952f = var_2ddbe94[bwastimejump - 1];
    self playrenderoverridebundle(self.var_b159952f);
  }
}

function function_95ad29e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread wait_to_update_ammo_fx(binitialsnap, fieldname, bwastimejump, 1);
}

function wait_to_update_ammo_fx(localclientnum, oldval, newval, var_efe94974) {
  self endon(#"death");
  var_17b7891d = "1caff36fc9c05c75" + "wait_to_update_ammo_fx";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  if(newval === 1 && self flag::get(#"hash_7151daf10b79dc1")) {
    self flag::wait_till_clear_timeout(1, #"hash_7151daf10b79dc1");
  }

  self function_5962609c(localclientnum, oldval, newval, var_efe94974);
}

function function_5962609c(localclientnum, oldval, newval, var_efe94974) {
  if(oldval === newval) {
    return;
  }

  self.oldval = newval;
  var_ba3dd99f = 0;

  if(newval >= 8) {
    var_ba3dd99f = 1;
    newval -= 8;
  }

  b_upgraded = 0;

  if(newval >= 4) {
    b_upgraded = 1;
    newval -= 4;
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      e_player notify(#"hash_7508e13e17dd1e3c");
    }
  }

  if(newval == 2) {
    if(isDefined(self.var_6cb1af87)) {
      killfx(localclientnum, self.var_6cb1af87);
      self.var_6cb1af87 = undefined;
    }

    if(isDefined(self.var_88a9ebe4)) {
      killfx(localclientnum, self.var_88a9ebe4);
      self.var_88a9ebe4 = undefined;
    }

    if(var_efe94974) {
      self notify(#"hash_40fa6fe49a4e7333");
    }

    return;
  }

  if(newval == 1) {
    if(isDefined(self.var_6cb1af87)) {
      killfx(localclientnum, self.var_6cb1af87);
      self.var_6cb1af87 = undefined;
    }

    if(isDefined(self.var_88a9ebe4)) {
      killfx(localclientnum, self.var_88a9ebe4);
      self.var_88a9ebe4 = undefined;
    }

    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(var_ba3dd99f) {
        if(viewmodelhastag(localclientnum, "tag_flash_alt")) {
          if(b_upgraded) {
            self.var_6cb1af87 = playviewmodelfx(localclientnum, #"hash_1724dba4c939ce1f", "tag_flash_alt");
          } else {
            self.var_6cb1af87 = playviewmodelfx(localclientnum, #"hash_5e6ff48bf93176e6", "tag_flash_alt");
          }
        }
      } else if(viewmodelhastag(localclientnum, "tag_muzzle_animate")) {
        if(b_upgraded) {
          self.var_6cb1af87 = playviewmodelfx(localclientnum, #"hash_cd6b2820b219988", "tag_muzzle_animate");
        } else {
          self.var_6cb1af87 = playviewmodelfx(localclientnum, #"hash_2eb20c55a2a0a52f", "tag_muzzle_animate");
        }
      }

      if(viewmodelhastag(localclientnum, "tag_fx_core")) {
        if(b_upgraded) {
          self.var_88a9ebe4 = playviewmodelfx(localclientnum, #"hash_753de791b5ec331c", "tag_fx_core");
        } else {
          self.var_88a9ebe4 = playviewmodelfx(localclientnum, #"hash_ac1da62ac86630b", "tag_fx_core");
        }
      }
    } else {
      if(var_ba3dd99f) {
        if(isDefined(self gettagorigin("tag_flash_alt"))) {
          if(b_upgraded) {
            self.var_6cb1af87 = util::playFXOnTag(localclientnum, #"hash_407f223936d34c9d", self, "tag_flash_alt");
          } else {
            self.var_6cb1af87 = util::playFXOnTag(localclientnum, #"hash_5e6a088bf92d2d34", self, "tag_flash_alt");
          }
        }
      } else if(isDefined(self gettagorigin("tag_muzzle_animate"))) {
        if(b_upgraded) {
          self.var_6cb1af87 = util::playFXOnTag(localclientnum, #"hash_4a7a1f8b135d7b56", self, "tag_muzzle_animate");
        } else {
          self.var_6cb1af87 = util::playFXOnTag(localclientnum, #"hash_2eab2055a29aa87d", self, "tag_muzzle_animate");
        }
      }

      if(isDefined(self gettagorigin("tag_fx_core"))) {
        if(b_upgraded) {
          self.var_88a9ebe4 = util::playFXOnTag(localclientnum, #"hash_6d8466757fe01e4a", self, "tag_fx_core");
        } else {
          self.var_88a9ebe4 = util::playFXOnTag(localclientnum, #"hash_abace62ac802ff9", self, "tag_fx_core");
        }
      }
    }

    self thread function_8175cdcb(localclientnum);
    self thread function_b63cc0c6(localclientnum);
    self thread function_acb526aa(localclientnum);
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player thread zm_utility::function_ae3780f1(localclientnum, self.var_6cb1af87, #"hash_7508e13e17dd1e3c");
        e_player thread zm_utility::function_ae3780f1(localclientnum, self.var_88a9ebe4, #"hash_7508e13e17dd1e3c");
      }
    }

    return;
  }

  if(newval == 0) {
    if(isDefined(self.var_6cb1af87)) {
      killfx(localclientnum, self.var_6cb1af87);
      self.var_6cb1af87 = undefined;
    }

    if(isDefined(self.var_88a9ebe4)) {
      killfx(localclientnum, self.var_88a9ebe4);
      self.var_88a9ebe4 = undefined;
    }

    if(var_efe94974) {
      self notify(#"hash_40fa6fe49a4e7333");
    }
  }
}

function function_8175cdcb(localclientnum) {
  self endon(#"death", #"hash_40fa6fe49a4e7333");
  var_17b7891d = "5e3d1de3b7ce4390" + "ray_rifle_should_hide_vfx";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    if(!self function_f69ceea9(localclientnum) && !isDefined(self.var_a0d6f528) && !is_true(self.inspect_clip_out)) {
      waitframe(1);
      continue;
    }

    var_4695f796 = self.oldval;
    self function_5962609c(localclientnum, self.oldval, 2, 0);

    while(self function_f69ceea9(localclientnum) || isDefined(self.var_a0d6f528) || is_true(self.inspect_clip_out)) {
      waitframe(1);
    }

    self function_5962609c(localclientnum, 2, var_4695f796, 0);
    waitframe(1);
  }
}

function function_f69ceea9(localclientnum) {
  if(self zm_utility::function_f8796df3(localclientnum)) {
    return ismeleeing(localclientnum);
  }

  return 0;
}

function function_b63cc0c6(localclientnum) {
  self endon(#"death", #"hash_40fa6fe49a4e7333");
  var_17b7891d = "b45b4208f077951" + "ray_rifle_watch_inspect_clip_out_notetrack";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittillmatch({
      #notetrack: "inspect_clip_out"}, #"notetrack");
    self.inspect_clip_out = 1;
  }
}

function function_acb526aa(localclientnum) {
  self endon(#"death", #"hash_40fa6fe49a4e7333");
  var_17b7891d = "61acf9b6fb63642b" + "ray_rifle_watch_inspect_done_notetrack";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittillmatch({
      #notetrack: "inspect_done"}, #"notetrack");
    self.inspect_clip_out = 0;
  }
}