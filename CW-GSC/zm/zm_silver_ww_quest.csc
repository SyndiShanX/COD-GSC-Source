/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver_ww_quest.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_silver_ww_quest;

function init() {
  if(!getdvarint(#"hash_83c887746f9dfd", 1)) {
    return 0;
  }

  clientfield::register("scriptmover", "" + # "hash_7159facf785aad53", 1, 1, "int", &function_7bceb311, 0, 0);
  clientfield::register("toplayer", "" + # "hash_864ef374ea11ea7", 1, 1, "int", &function_37ba0961, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_18f64f139f905f76", 1, 1, "int", &function_f875612b, 0, 0);
  clientfield::register("scriptmover", "crystal_energy_fx", 1, 1, "int", &crystal_energy_fx, 0, 0);
  clientfield::register("allplayers", "ww_vacuum_crystal_fx", 1, 1, "int", &ww_vacuum_crystal_fx, 0, 0);
  clientfield::register("allplayers", "hold_crystal_energy", 1, 1, "int", &hold_crystal_energy, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_21ba194bb9030d0c", 1, 1, "int", &function_f0bc5344, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5e31ed9954a7a58a", 1, 2, "int", &function_29b9f19b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5020565243fa510a", 1, 1, "int", &function_c4793fe5, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4119827af45a4ba7", 1, 1, "int", &function_48124b82, 0, 0);
  clientfield::register("toplayer", "" + # "interact_rumble", 1, 1, "int", &interact_rumble, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6a198759db0810a6", 1, 1, "int", &function_1534626e, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7862b1e62306df36", 1, 1, "int", &function_408232a7, 0, 0);
  clientfield::register("allplayers", "" + # "hash_196eef041ba86f9a", 1, 1, "counter", &function_1385b26c, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5a932b901b9a5d0d", 1, 2, "int", &function_167bea22, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_20066374c799cb61", 1, 1, "int", &function_4c8d91b3, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7aeee79e85f9273c", 1, 3, "int", &function_cadc50d8, 0, 0);
  clientfield::register("world", "" + # "hash_31ddead700f0e24c", 1, 1, "int", &function_c35975ed, 0, 0);
}

function function_cadc50d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 0:
      if(isDefined(self.light_fx)) {
        stopfx(fieldname, self.light_fx);
      }

      break;
    case 1:
      self.light_fx = util::playFXOnTag(fieldname, #"hash_d208acedd2518ae", self, "tag_tank");
      break;
    case 2:
      self.light_fx = util::playFXOnTag(fieldname, #"hash_7a6a8f045e6c6b7e", self, "tag_tank");
      break;
    case 3:
      self.light_fx = util::playFXOnTag(fieldname, #"hash_1119b81f77cb3c61", self, "tag_tank");
      break;
    case 4:
      self.light_fx = util::playFXOnTag(fieldname, #"hash_6154a93403194405", self, "tag_tank");
      break;
  }
}

function function_4c8d91b3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.fx = util::playFXOnTag(fieldname, #"hash_23ae7ac84a5dafab", self, "tag_container_fx");
    return;
  }

  if(isDefined(self.fx)) {
    stopfx(fieldname, self.fx);
  }

  util::playFXOnTag(fieldname, #"hash_6068643b9cfb1958", self, "tag_container_fx");
}

function function_167bea22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1 || bwasdemojump == 2 || bwasdemojump == 3) {
    util::playFXOnTag(fieldname, #"hash_7e300a1fb308ae67", self, "tag_electric_0" + bwasdemojump + "_fx");
  }
}

function function_c4793fe5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    util::playFXOnTag(fieldname, #"hash_2ddd7e581a184f88", self, "tag_origin");
    self playrenderoverridebundle(#"hash_6116131e6c28b26e", "tag_chain_cryo");
  }
}

function function_408232a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self.smoke_fx = playFX(fieldname, #"zm_ai/fx9_hound_plague_dth_aoe", self.origin + (0, 0, 20));
    playSound(fieldname, #"hash_11a2fa9d6a695f96", self.origin + (0, 0, 20));
    audio::playloopat(#"hash_155791cb3cba6094", self.origin + (0, 0, 20));
    wait 2;

    if(isDefined(self.smoke_fx)) {
      stopfx(fieldname, self.smoke_fx);
    }

    if(isDefined(self)) {
      audio::stoploopat(#"hash_155791cb3cba6094", self.origin + (0, 0, 20));
    }
  }
}

function function_1534626e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    level waittill(#"power_on");
    util::playFXOnTag(fieldname, #"hash_286b9aef04023710", self, "tag_light");
  }
}

function function_48124b82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    earthquake(fieldname, 0.2, 2, self.origin, 100);
    self playrumbleonentity(fieldname, "damage_heavy");
  }
}

function interact_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrumbleonentity(fieldname, "damage_light");
  }
}

function function_f0bc5344(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self playrenderoverridebundle(#"hash_7930c9f965b0357b");
    self playSound(fieldname, #"hash_7b43e72a8c1d3334");
    return;
  }

  self playSound(fieldname, #"hash_2edd62f08d4adbd4");
  self stoprenderoverridebundle(#"hash_7930c9f965b0357b");
  self playrenderoverridebundle(#"hash_3dd7407a7104870e");
}

function function_29b9f19b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_29b9f19b)) {
    stopfx(fieldname, self.var_29b9f19b);
    self.var_29b9f19b = undefined;
  }

  if(isDefined(self.var_949340cf)) {
    stopfx(fieldname, self.var_949340cf);
    self.var_949340cf = undefined;
  }

  if(isDefined(self.var_c8661564)) {
    self stoploopsound(self.var_c8661564);
    self.var_c8661564 = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_29b9f19b = util::playFXOnTag(fieldname, #"hash_8887a20dd955a51", self, "tag_fungus_fx");
    self.var_949340cf = util::playFXOnTag(fieldname, #"hash_40a742cacdfc9a36", self, "tag_origin");
    self.var_c8661564 = self playLoopSound(#"hash_6dff86c60e6200a9");
    return;
  }

  if(bwasdemojump == 2) {
    self.var_29b9f19b = util::playFXOnTag(fieldname, #"hash_8887720dd955538", self, "tag_fungus_fx");
    self.var_949340cf = util::playFXOnTag(fieldname, #"hash_40a742cacdfc9a36", self, "tag_origin");
    self.var_c8661564 = self playLoopSound(#"hash_31f17a119e8993e6");
  }
}

function function_7bceb311(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    util::playFXOnTag(fieldname, #"hash_2a8007b7010b4734", self, "tag_origin");
  }
}

function function_c35975ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    playSound(fieldname, #"hash_69a9c234107d76f3", (-85, -408, 79));
    soundlineemitter(#"hash_7d00ba230936febe", (-85, -408, 79), (72, -413, 77));
    soundloopemitter(#"hash_1543c9e1aff0cf87", (-155, -410, 81));
    return;
  }

  playSound(fieldname, #"hash_541da0125d0a1261", (-85, -408, 79));
  soundstoplineemitter(#"hash_7d00ba230936febe", (-85, -408, 79), (72, -413, 77));
  soundstoploopemitter(#"hash_1543c9e1aff0cf87", (-155, -410, 81));
}

function function_37ba0961(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"disconnect");

  if(bwasdemojump == 1) {
    self thread function_5bd0643d(fieldname);
    return;
  }

  self notify(#"hash_7e008885ec855120");
}

function function_5bd0643d(localclientnum) {
  self notify(#"hash_7e008885ec855120");
  self endon(#"disconnect", #"hash_7e008885ec855120");

  while(true) {
    if(isDefined(self)) {
      earthquake(localclientnum, 0.2, 1, self.origin, 100);
      self playrumbleonentity(localclientnum, "damage_light");
    }

    waitframe(1);
  }
}

function function_f875612b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    mdl_fx = util::spawn_model(fieldname, "tag_origin", self.origin);
    playSound(fieldname, #"hash_58583b7b5bcacbbc", (-85, -408, 79));
    wait 1;
    mdl_fx moveto(mdl_fx.origin + (270, 0, 0), 0.5);
    util::playFXOnTag(fieldname, #"hash_47d98c0644ec2ecd", mdl_fx, "tag_origin");
    mdl_fx waittill(#"movedone");

    if(isDefined(mdl_fx)) {
      mdl_fx delete();
    }
  }
}

function crystal_energy_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_358ffe83 = playFX(fieldname, #"hash_498785d4883daa1", self.origin);

    if(!isDefined(self.var_a15fac69)) {
      self.var_a15fac69 = self playLoopSound(#"hash_30ea6b0883f216fd");
    }

    return;
  }

  if(isDefined(self.var_358ffe83)) {
    stopfx(fieldname, self.var_358ffe83);
    self.var_358ffe83 = undefined;
  }

  if(isDefined(self.var_a15fac69)) {
    self stoploopsound(self.var_a15fac69);
    self.var_a15fac69 = undefined;
  }
}

function ww_vacuum_crystal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.var_37d7e267)) {
    level.var_37d7e267 = [];
  }

  if(!isDefined(level.var_cca24823)) {
    level.var_cca24823 = [];
  }

  var_47c85523 = self getentitynumber();

  if(isDefined(level.var_37d7e267[var_47c85523])) {
    if(bwasdemojump == 0) {
      stopfx(fieldname, level.var_37d7e267[var_47c85523]);
    } else {
      killfx(fieldname, level.var_37d7e267[var_47c85523]);
    }

    level.var_37d7e267[var_47c85523] = undefined;
  }

  if(isDefined(level.var_cca24823[var_47c85523])) {
    self stoploopsound(level.var_cca24823[var_47c85523]);
    level.var_cca24823[var_47c85523] = undefined;
  }

  if(bwasdemojump) {
    if(self zm_utility::function_f8796df3(fieldname)) {
      if(viewmodelhastag(fieldname, "tag_flash")) {
        level.var_37d7e267[var_47c85523] = playviewmodelfx(fieldname, #"hash_2421d7984fb8e652", "tag_flash");
        level.var_cca24823[var_47c85523] = self playLoopSound(#"hash_4f03b4341d714c53");
      }

      return;
    }

    level.var_37d7e267[var_47c85523] = util::playFXOnTag(fieldname, #"hash_2421d7984fb8e652", self, "tag_flash");
    level.var_cca24823[var_47c85523] = self playLoopSound(#"hash_4f03b4341d714c53", undefined, (0, 0, 50));
  }
}

function hold_crystal_energy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.var_23b807cf)) {
    level.var_23b807cf = [];
  }

  if(!isDefined(level.var_23b807cf[fieldname])) {
    level.var_23b807cf[fieldname] = [];
  }

  var_47c85523 = self getentitynumber();
  function_564a4c6(fieldname, var_47c85523, bwasdemojump > 0);

  if(bwasdemojump) {
    self thread function_a6b2453b(fieldname, var_47c85523, self zm_utility::function_f8796df3(fieldname));
    return;
  }

  self notify(#"hash_5b93168ba86f708a");
}

function function_2a66952f(localclientnum, var_9b6b8f9a) {
  self notify("716f43f3d85a34bd");
  self endon("716f43f3d85a34bd");
  self endon(#"hash_5b93168ba86f708a");
  self waittill(#"death");
  function_564a4c6(localclientnum, var_9b6b8f9a, 1);
}

function function_a6b2453b(localclientnum, var_9b6b8f9a, var_a4f83274) {
  self notify("10060f28e0b094b1");
  self endon("10060f28e0b094b1");
  self endon(#"death", #"hash_5b93168ba86f708a");
  self thread function_2a66952f(localclientnum, var_9b6b8f9a);
  w_current = self function_d2c2b168();
  function_9dd39fc8(localclientnum, var_9b6b8f9a, var_a4f83274);

  while(isDefined(self)) {
    waitresult = self waittill(#"weapon_change");
    w_current = waitresult.weapon;
    w_previous = waitresult.last_weapon;

    if(function_7532a0ff(w_current.name)) {
      function_9dd39fc8(localclientnum, var_9b6b8f9a, var_a4f83274);
    } else if(function_7532a0ff(w_previous.name)) {
      function_564a4c6(localclientnum, var_9b6b8f9a, 1);
    }

    waitframe(1);
  }
}

function private function_9dd39fc8(localclientnum, var_9b6b8f9a, var_a4f83274) {
  if(isDefined(level.var_23b807cf[localclientnum][var_9b6b8f9a])) {
    return;
  }

  if(var_a4f83274) {
    level.var_23b807cf[localclientnum][var_9b6b8f9a] = playviewmodelfx(localclientnum, #"hash_75819450c7721a28", "tag_flash");
    return;
  }

  level.var_23b807cf[localclientnum][var_9b6b8f9a] = util::playFXOnTag(localclientnum, #"hash_7588a050c7784d3a", self, "tag_flash");
}

function private function_564a4c6(localclientnum, var_9b6b8f9a, var_d4ece4fd) {
  if(isDefined(level.var_23b807cf[localclientnum][var_9b6b8f9a])) {
    if(var_d4ece4fd) {
      killfx(localclientnum, level.var_23b807cf[localclientnum][var_9b6b8f9a]);
    } else {
      stopfx(localclientnum, level.var_23b807cf[localclientnum][var_9b6b8f9a]);
    }

    level.var_23b807cf[localclientnum][var_9b6b8f9a] = undefined;
  }
}

function function_1385b26c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self playrumbleonentity(bwasdemojump, #"hash_6fed0a32376b64b2");
}

function private function_7532a0ff(weapon_name) {
  if(isDefined(weapon_name)) {
    switch (weapon_name) {
      case # "ww_ieu_gas_t9_upgraded":
      case # "ww_ieu_plasma_t9_upgraded":
      case # "ww_ieu_acid_t9_upgraded":
      case # "ww_ieu_shockwave_t9_upgraded":
      case # "ww_ieu_shockwave_t9":
      case # "ww_ieu_electric_t9_upgraded":
      case # "ww_ieu_electric_t9":
      case # "ww_ieu_acid_t9":
      case # "ww_ieu_gas_t9":
      case # "ww_ieu_plasma_t9":
        return true;
      default:
        return false;
    }
  }

  return false;
}