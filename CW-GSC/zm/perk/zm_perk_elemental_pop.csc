/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_elemental_pop.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_elemental_pop;

function private autoexec __init__system__() {
  system::register(#"zm_perk_elemental_pop", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_27473e44();
}

function function_27473e44() {
  zm_perks::register_perk_clientfields(#"talent_elemental_pop", &client_field_func, &callback_func);
  zm_perks::register_perk_effects(#"talent_elemental_pop", "elemental_pop_light");
  zm_perks::register_perk_init_thread(#"talent_elemental_pop", &init_perk);
  zm_perks::function_f3c80d73("zombie_perk_bottle_elemental_pop");
  clientfield::register("allplayers", "elemental_pop_reload_fx", 1, 2, "int", &function_7f805dac, 0, 0);
  clientfield::register("actor", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
  clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
}

function init_perk() {
  if(is_true(level.enable_magic)) {
    level._effect[# "elemental_pop_light"] = # "hash_17afc35bb449d1c2";
  }
}

function client_field_func() {
  clientfield::register("scriptmover", "" + # "hash_2bc83061af453e44", 1, 1, "counter", &function_9717930f, 0, 0);
  clientfield::register("toplayer", "" + # "hash_12c6e46c315cd43b", 1, 1, "counter", &function_2d190a32, 0, 0);
}

function callback_func() {}

function function_9717930f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, #"hash_35c5a29b4a86b5fb", self, "tag_origin");
  util::playFXOnTag(bwastimejump, #"hash_250adc9af94491d1", self, "tag_origin");
  util::playFXOnTag(bwastimejump, #"hash_4bbd9da4b24f7552", self, "tag_origin");
  playSound(bwastimejump, #"hash_67d6791052a84d2a", self.origin + (0, 0, 75));
}

function private function_2d190a32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(zm_utility::function_f8796df3(bwastimejump)) {
    playfxoncamera(bwastimejump, #"hash_b471a5df94f45b7", undefined, (1, 0, 0), (0, 0, 1));
  }
}

function function_7f805dac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.elemental_pop_reload_fx)) {
    stopfx(fieldname, self.elemental_pop_reload_fx);
    self.elemental_pop_reload_fx = undefined;
  }

  switch (bwastimejump) {
    case 1:
    case 2:
    case 3:
      self.elemental_pop_reload_fx = util::playFXOnTag(fieldname, #"hash_70912cde462752a8", self, "tag_origin");
      break;
  }
}

function tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    str_tag = "J_SpineUpper";

    if(isDefined(self.str_tag_tesla_death_fx)) {
      str_tag = self.str_tag_tesla_death_fx;
    } else if(is_true(self.isdog)) {
      str_tag = "J_Spine1";
    }

    if(!isDefined(self.var_16e53a57)) {
      self playSound(fieldname, #"hash_444d07230f4c95bf");
      self.var_16e53a57 = self playLoopSound(#"hash_b02589e63759483");
    }

    self.n_death_fx = util::playFXOnTag(fieldname, #"hash_43be23bab63afdc6", self, str_tag);

    if(isDefined(self.n_death_fx)) {
      setfxignorepause(fieldname, self.n_death_fx, 1);
    }

    return;
  }

  if(isDefined(self.n_death_fx)) {
    deletefx(fieldname, self.n_death_fx, 1);
    self.n_death_fx = undefined;
  }

  if(isDefined(self.var_16e53a57)) {
    self stoploopsound(self.var_16e53a57);
    self.var_16e53a57 = undefined;
  }
}

function tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    str_tag = "J_SpineUpper";

    if(isDefined(self.str_tag_tesla_shock_eyes_fx)) {
      str_tag = self.str_tag_tesla_shock_eyes_fx;
    } else if(is_true(self.isdog)) {
      str_tag = "J_Spine1";
    }

    if(!isDefined(self.var_16e53a57)) {
      self playSound(fieldname, #"hash_3b277f4572603015");
      self.var_16e53a57 = self playLoopSound(#"hash_2f0f235f7f6fc84d");
    }

    self.n_shock_eyes_fx = util::playFXOnTag(fieldname, #"hash_335e2bb9ccc18354", self, "J_Eyeball_LE");

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(fieldname, self.n_shock_eyes_fx, 1);
    }

    self.n_shock_fx = util::playFXOnTag(fieldname, #"hash_43be23bab63afdc6", self, str_tag);

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(fieldname, self.n_shock_fx, 1);
    }

    return;
  }

  if(isDefined(self.n_shock_eyes_fx)) {
    deletefx(fieldname, self.n_shock_eyes_fx, 1);
    self.n_shock_eyes_fx = undefined;
  }

  if(isDefined(self.n_shock_fx)) {
    deletefx(fieldname, self.n_shock_fx, 1);
    self.n_shock_fx = undefined;
  }

  if(isDefined(self.var_16e53a57)) {
    self stoploopsound(self.var_16e53a57);
    self.var_16e53a57 = undefined;
  }
}