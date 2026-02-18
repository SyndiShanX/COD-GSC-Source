/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7acbc809be32d8ba.csc
***********************************************/

#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_1e7573ec;

function private autoexec __init__system__() {
  system::register(#"hash_538411714a272c00", &preinit, &postinit, undefined, "zm_weapons");
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_4bd7cbe3f7fd44dd", 24000, 2, "int", &function_a1e57b34, 0, 0);
  clientfield::register("missile", "" + # "hash_3ec6598e8ba9406a", 24000, 1, "int", &function_2fa08804, 0, 0);
  clientfield::register("toplayer", "" + # "hash_74134fadeeb8b692", 24000, 1, "counter", &function_61987d28, 0, 0);
  clientfield::register("toplayer", "" + # "hash_713a0ba5968a3bde", 24000, 1, "int", &function_53bb1917, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4aec08923edd6a40", 24000, 2, "int", &function_778e494b, 0, 0);
  clientfield::register("actor", "" + # "hash_5366f39f1aca2e65", 24000, 3, "int", &function_e688ee7c, 0, 0);
  callback::on_weapon_change(&on_weapon_change);
  level.var_282dc0af = &function_af4c580b;
}

function private postinit() {
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  zm_weapons::function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
}

function function_6b945d59(var_ee6bcd51) {
  if(isPlayer(self)) {
    self zm_utility::function_f933b697(var_ee6bcd51);
  }

  self stoprenderoverridebundle(var_ee6bcd51);
}

function function_4e818189(var_ee6bcd51) {
  if(isPlayer(self)) {
    if(self zm_utility::function_10df0b9c(var_ee6bcd51)) {
      self playrenderoverridebundle(var_ee6bcd51);
    }

    self zm_utility::function_8065ace2(var_ee6bcd51);
    return;
  }

  self playrenderoverridebundle(var_ee6bcd51);
}

function function_af4c580b(localclientnum, itementry) {
  if(!isDefined(itementry)) {
    return 0;
  }

  data = item_world::function_a7e98a1a(itementry);

  if(function_3efc58e4(self item_inventory_util::function_2b83d3ff(data.inventory.items[17 + 1]))) {
    return 1;
  }

  if(function_3efc58e4(self item_inventory_util::function_2b83d3ff(data.inventory.items[17 + 1 + 8 + 1]))) {
    return 1;
  }

  if(function_3efc58e4(self item_inventory_util::function_2b83d3ff(data.inventory.items[17 + 1 + 8 + 1 + 8 + 1]))) {
    return 1;
  }

  return 0;
}

function on_weapon_change(params) {
  if(self == level || !isPlayer(self)) {
    return;
  }

  localclientnum = params.localclientnum;
  weapon = self function_d2c2b168();

  if(function_3efc58e4(weapon)) {
    self.var_960d365a = 0;
    self thread watch_mega_barrel_ammo_change(localclientnum, weapon);
    self thread watch_mega_barrel_mag_out_notetrack(localclientnum, weapon);
    self thread watch_mega_barrel_mag_in_notetrack(localclientnum, weapon);
    self thread watch_mega_barrel_mag_throw_notetrack(localclientnum, weapon);
    return;
  }

  if(isDefined(self.var_49d95be6)) {
    self function_6b945d59(#"hash_8c1c803276508fe" + self.var_49d95be6);
    self.var_49d95be6 = undefined;
    self function_88a55cb8(localclientnum);
  }
}

function watch_mega_barrel_mag_out_notetrack(localclientnum, weapon) {
  self endon(#"death", #"weapon_change");
  var_17b7891d = "51273cd61d1e6f07" + "watch_mega_barrel_mag_out_notetrack";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittillmatch({
      #notetrack: "mag_out"}, #"notetrack");
    self.var_960d365a = 1;

    if(isDefined(self.var_49d95be6)) {
      self function_6b945d59(#"hash_8c1c803276508fe" + self.var_49d95be6);
      self.var_49d95be6 = 0;
      self function_4e818189(#"hash_8c1c803276508fe" + self.var_49d95be6);
    }

    var_a1796c91 = self function_6fff5014(localclientnum, weapon);

    if(isDefined(self.var_5f39ac11)) {
      if(self.var_5f39ac11 != var_a1796c91) {
        self function_6b945d59(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
        self.var_5f39ac11 = var_a1796c91;
        self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
      }

      continue;
    }

    self.var_5f39ac11 = var_a1796c91;
    self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
  }
}

function watch_mega_barrel_mag_throw_notetrack(localclientnum, weapon) {
  self endon(#"death", #"weapon_change");
  var_17b7891d = "bb81bf554d144e6" + "watch_mega_barrel_mag_throw_notetrack";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittillmatch({
      #notetrack: "mag_thrown"}, #"notetrack");
    currentammostock = self getweaponammostock(localclientnum, weapon);
    currentclipammo = getweaponammoclip(localclientnum, weapon);
    totalammo = currentammostock + currentclipammo;
    clip_size = weapon.clipsize;
    var_a1796c91 = int(ceil(float(totalammo) / float(clip_size) * 5));

    if(var_a1796c91 > 5) {
      var_a1796c91 = 5;
    }

    if(isDefined(self.var_5f39ac11)) {
      if(self.var_5f39ac11 != var_a1796c91) {
        self function_6b945d59(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
        self.var_5f39ac11 = var_a1796c91;
        self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
      }

      continue;
    }

    self.var_5f39ac11 = var_a1796c91;
    self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
  }
}

function watch_mega_barrel_mag_in_notetrack(localclientnum, weapon) {
  self endon(#"death", #"weapon_change");
  var_17b7891d = "72c40ea1ad927740" + "watch_mega_barrel_mag_in_notetrack";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    self waittillmatch({
      #notetrack: "mag_in"}, #"notetrack");
    self.var_960d365a = 0;
  }
}

function watch_mega_barrel_ammo_change(localclientnum, weapon) {
  self endon(#"death", #"weapon_change");
  var_17b7891d = "54ae0da6d02ad59f" + "watch_mega_barrel_ammo_change";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    if(!is_true(self.var_960d365a)) {
      var_a1796c91 = self function_6fff5014(localclientnum, weapon);

      if(isDefined(self.var_49d95be6)) {
        if(self.var_49d95be6 != var_a1796c91) {
          self function_6b945d59(#"hash_8c1c803276508fe" + self.var_49d95be6);
          self.var_49d95be6 = var_a1796c91;
          self function_4e818189(#"hash_8c1c803276508fe" + self.var_49d95be6);
        }
      } else {
        self.var_49d95be6 = var_a1796c91;
        self function_4e818189(#"hash_8c1c803276508fe" + self.var_49d95be6);
      }

      if(isDefined(self.var_5f39ac11)) {
        if(self.var_5f39ac11 != var_a1796c91) {
          self function_6b945d59(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
          self.var_5f39ac11 = var_a1796c91;
          self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
        }
      } else {
        self.var_5f39ac11 = var_a1796c91;
        self function_4e818189(#"hash_20afad7abab6c3cd" + self.var_5f39ac11);
      }
    }

    if(!is_true(self.var_960d365a) && !isDefined(self.var_a0d6f528)) {
      self function_88a55cb8(localclientnum, weapon, var_a1796c91);
    } else {
      self function_88a55cb8(localclientnum);
    }

    waitframe(1);
  }
}

function function_6fff5014(localclientnum, weapon) {
  ammo_clip = getweaponammoclip(localclientnum, weapon);
  clip_size = weapon.clipsize;
  var_bb894354 = int(ceil(float(ammo_clip) / float(clip_size) * 5));
  return var_bb894354;
}

function function_88a55cb8(localclientnum, weapon, var_bb894354 = 0) {
  if(self.var_42662764 !== weapon.name) {
    if(isDefined(self.var_42662764)) {
      switch (self.var_42662764) {
        case # "ww_mega_barrel_fullauto_micro_missile_t9_upgraded":
        case # "ww_mega_barrel_fullauto_micro_missile_t9":
          self function_d64a2c25(localclientnum);
          break;
        default:
          break;
      }
    }

    self.var_42662764 = weapon.name;
  }

  if(!isDefined(weapon.name)) {
    return;
  }

  switch (weapon.name) {
    case # "ww_mega_barrel_fullauto_micro_missile_t9":
      self function_d64a2c25(localclientnum, var_bb894354 > 0, 0);
      break;
    case # "ww_mega_barrel_fullauto_micro_missile_t9_upgraded":
      self function_d64a2c25(localclientnum, var_bb894354 > 0, 1);
      break;
    default:
      break;
  }
}

function function_d64a2c25(localclientnum, enable = 0, is_upgraded = 0) {
  if(enable && self zm_utility::function_f8796df3(localclientnum) && viewmodelhastag(localclientnum, "tag_missile_ri_fx1") && viewmodelhastag(localclientnum, "tag_missile_le_fx1")) {
    if(!isDefined(self.var_6ccae77f)) {
      self.var_6ccae77f = playviewmodelfx(localclientnum, is_upgraded ? # "hash_58dea3d4f20164fe" : # "hash_4c9c7c4f5b319ca5", "tag_missile_ri_fx1");
    }

    if(!isDefined(self.var_86290a61)) {
      self.var_86290a61 = playviewmodelfx(localclientnum, is_upgraded ? # "hash_7b19173c4cd204c2" : # "hash_5d4a11460d001591", "tag_missile_le_fx1");
    }

    return;
  }

  if(isDefined(self.var_6ccae77f)) {
    killfx(localclientnum, self.var_6ccae77f);
    self.var_6ccae77f = undefined;
  }

  if(isDefined(self.var_86290a61)) {
    killfx(localclientnum, self.var_86290a61);
    self.var_86290a61 = undefined;
  }
}

function function_3efc58e4(weapon) {
  if(isDefined(weapon)) {
    switch (weapon.name) {
      case # "ww_mega_barrel_fullauto_blazer_beam_t9":
      case # "ww_mega_barrel_fullauto_diffusion_beam_t9_upgraded":
      case # "ww_mega_barrel_fullauto_diffusion_beam_t9":
      case # "ww_mega_barrel_fullauto_blazer_beam_t9_upgraded":
      case # "ww_mega_barrel_fullauto_micro_missile_t9_upgraded":
      case # "ww_mega_barrel_fullauto_copycat_t9_upgraded":
      case # "ww_mega_barrel_fullauto_copycat_t9":
      case # "ww_mega_barrel_fullauto_micro_missile_t9":
        return true;
    }
  }

  return false;
}

function function_a1e57b34(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!isDefined(self.owner)) {
      return;
    }

    if(!isDefined(self.var_31574a7)) {
      self.var_31574a7 = util::spawn_model(fieldname, "tag_origin");
      self.var_31574a7 thread function_2ed768c7(self);
    }

    if(!isDefined(self.var_de6c5ff9)) {
      self.var_de6c5ff9 = util::spawn_model(fieldname, "tag_origin");
      self.var_de6c5ff9 thread function_2ed768c7(self);
    }

    if(isDefined(self.var_6152b139)) {
      beam::function_47deed80(fieldname, self.var_6152b139);
    }

    weapon = self.owner function_d2c2b168().rootweapon;

    if(weapon.name === # "ww_mega_barrel_fullauto_blazer_beam_t9_upgraded") {
      self.var_d34c8bb = self.owner zm_utility::function_f8796df3(fieldname) ? "beam9_zm_mega_barrel_blazer_upgraded" : "beam9_zm_mega_barrel_blazer_3p_upgraded";
    } else {
      self.var_d34c8bb = self.owner zm_utility::function_f8796df3(fieldname) ? "beam9_zm_mega_barrel_blazer" : "beam9_zm_mega_barrel_blazer_3p";
    }

    self.var_31574a7 unlink();
    self.var_de6c5ff9 unlink();
    self.var_6152b139 = level beam::function_cfb2f62a(fieldname, self.owner, "tag_flash", self.var_de6c5ff9, "tag_origin", self.var_d34c8bb);
    self thread function_c57b04f7(fieldname);
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_31574a7) && isDefined(self.var_de6c5ff9)) {
      beam::function_47deed80(fieldname, self.var_6152b139);
      self.var_6152b139 = level beam::function_cfb2f62a(fieldname, self.var_31574a7, "tag_origin", self.var_de6c5ff9, "tag_origin", self.var_d34c8bb);
      self.var_31574a7 linkto(self);
      self.var_de6c5ff9 linkto(self);
      self notify(#"hash_2196551ad754e921");
    }

    return;
  }

  if(bwastimejump == 3) {
    if(isDefined(self.var_de6c5ff9) && isDefined(self.var_31574a7) && isDefined(self.move_dir)) {
      self notify(#"hash_2196551ad754e921");
      self.var_31574a7 unlink();
      self.var_de6c5ff9 unlink();
      v_target_pos = self.var_31574a7.origin + self.move_dir * (500 + self.beam_length);
      trace = beamtrace(self.var_31574a7.origin, v_target_pos, 0, self.owner);

      if(trace[# "fraction"] < 1) {
        v_target_pos = trace[# "position"] - trace[# "normal"];
        self.var_de6c5ff9 moveto(v_target_pos, 0.1);
      }

      time = distance(self.var_31574a7.origin, v_target_pos) / 1200;

      if(time > 0) {
        self.var_31574a7 moveto(v_target_pos, time);
      }
    }

    return;
  }

  if(isDefined(self.var_31574a7)) {
    self.var_31574a7 delete();
  }

  if(isDefined(self.var_de6c5ff9)) {
    self.var_de6c5ff9 delete();
  }

  self.var_6152b139 = undefined;
}

function function_c57b04f7(localclientnum) {
  level endon(#"end_game");
  self endon(#"death", #"hash_2196551ad754e921");
  self.var_31574a7 endon(#"death");
  self.var_de6c5ff9 endon(#"death");
  self notify("db1d1a3509841a7");
  self endon("db1d1a3509841a7");
  self.beam_length = 20;

  while(isalive(self.owner)) {
    if(self.owner zm_utility::function_f8796df3(localclientnum)) {
      tag_pos = function_8cb7ea7(localclientnum, "tag_flash");
    } else {
      tag_pos = self.owner gettagorigin("tag_flash");
    }

    if(!isDefined(tag_pos)) {
      println("<dev string:x38>");
      waitframe(1);
      continue;
    }

    self.var_31574a7.origin = tag_pos;
    var_1e65372b = isDefined(self.owner getcampos()) ? self.owner getcampos() : tag_pos;

    if(self.beam_length < 800) {
      self.beam_length += 19.2;
    }

    self.move_dir = anglesToForward(self.owner getplayerangles());
    v_target_pos = var_1e65372b + self.move_dir * self.beam_length;
    trace = beamtrace(var_1e65372b, v_target_pos, 0, self.owner);

    if(trace[# "fraction"] < 1) {
      v_target_pos = trace[# "position"] - trace[# "normal"];
      self.beam_length = distance(v_target_pos, var_1e65372b);
    }

    self.var_de6c5ff9.origin = v_target_pos;
    self.var_de6c5ff9.angles = vectortoangles(tag_pos - v_target_pos);
    waitframe(1);
  }
}

function function_2ed768c7(parent, var_543c7862) {
  self endon(#"death");
  parent waittill(#"death");

  if(isDefined(self) && isDefined(var_543c7862)) {
    self scene::stop(var_543c7862, undefined, undefined, undefined, undefined, 1);
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_2fa08804(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_d4d3f6c4 = util::playFXOnTag(fieldname, #"hash_6eeaf3e3b5a7477a", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_d4d3f6c4)) {
    killfx(fieldname, self.var_d4d3f6c4);
    self.var_d4d3f6c4 = undefined;
  }
}

function function_61987d28(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_accb4770)) {
    util::playFXOnTag(bwastimejump, self.var_accb4770.var_515e20e6 ? # "hash_77e7d9c6c1c5cb2b" : # "hash_52f32fbd7a1126ba", self.var_accb4770, "tag_flash");
  }
}

function function_53bb1917(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_accb4770)) {
      weapon = self function_d2c2b168().rootweapon;
      var_accb4770 = util::spawn_model(fieldname, #"p9_fxanim_ww_mega_barrel_fullauto_copycat_circle_mod");
      var_accb4770.var_515e20e6 = weapon.name === # "ww_mega_barrel_fullauto_copycat_t9_upgraded";
      var_accb4770 linktocamera();
      var_accb4770 setforcenocull();
      var_accb4770 thread scene::play(#"p9_fxanim_ww_mega_barrel_fullauto_copycat_circle_bundle", var_accb4770);
      var_accb4770 thread function_2ed768c7(self, #"p9_fxanim_ww_mega_barrel_fullauto_copycat_circle_bundle");
      var_accb4770 playrenderoverridebundle(#"hash_225a66106179e9bb");
      util::playFXOnTag(fieldname, var_accb4770.var_515e20e6 ? # "hash_2eabcf6f328bb46b" : # "hash_2ac49f49b148a4fa", var_accb4770, "tag_flash");
      self.var_accb4770 = var_accb4770;
    }

    return;
  }

  if(isDefined(self.var_accb4770)) {
    self.var_accb4770 scene::stop(#"p9_fxanim_ww_mega_barrel_fullauto_copycat_circle_bundle", undefined, undefined, undefined, undefined, 1);

    if(isDefined(self.var_accb4770)) {
      self.var_accb4770 delete();
    }
  }
}

function function_778e494b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 2) {
    self function_4e818189(#"hash_23e50ec84718e9aa");
    self function_6b945d59(#"hash_225a66106179e9bb");

    if(isDefined(self.var_accb4770)) {
      self.var_accb4770 playrenderoverridebundle(#"hash_23e50ec84718e9aa");
      self.var_accb4770 stoprenderoverridebundle(#"hash_225a66106179e9bb");
    }

    return;
  }

  if(bwastimejump == 1) {
    self function_4e818189(#"hash_225a66106179e9bb");
    self function_6b945d59(#"hash_23e50ec84718e9aa");

    if(isDefined(self.var_accb4770)) {
      self.var_accb4770 playrenderoverridebundle(#"hash_225a66106179e9bb");
      self.var_accb4770 stoprenderoverridebundle(#"hash_23e50ec84718e9aa");
    }

    return;
  }

  self function_6b945d59(#"hash_225a66106179e9bb");
  self function_6b945d59(#"hash_23e50ec84718e9aa");

  if(isDefined(self.var_accb4770)) {
    self.var_accb4770 playrenderoverridebundle(#"hash_225a66106179e9bb");
    self.var_accb4770 stoprenderoverridebundle(#"hash_23e50ec84718e9aa");
  }
}

function function_e688ee7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_b159952f)) {
    self function_f6e99a8d(self.var_b159952f);
    self.var_b159952f = undefined;
  }

  if(isDefined(self.var_12b59dee)) {
    self function_f6e99a8d(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  var_2ddbe94 = [# "hash_16d59f099e418f4f", #"hash_7417f2cd52314463", #"hash_726534103985846c", #"hash_16d59f099e418f4f", #"hash_16d59f099e418f4f"];

  if(bwastimejump && bwastimejump < var_2ddbe94.size + 1) {
    self.var_b159952f = var_2ddbe94[bwastimejump - 1];
    self playrenderoverridebundle(self.var_b159952f);
  }
}