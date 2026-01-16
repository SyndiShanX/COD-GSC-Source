/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_electric_cherry.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_electric_cherry;

autoexec __init__system__() {
  system::register(#"zm_perk_electric_cherry", &__init__, undefined, undefined);
}

__init__() {
  zm_perks::register_perk_clientfields(#"specialty_electriccherry", &electric_cherry_client_field_func, &electric_cherry_code_callback_func);
  zm_perks::register_perk_effects(#"specialty_electriccherry", "electric_cherry_light");
  zm_perks::register_perk_init_thread(#"specialty_electriccherry", &init_electric_cherry);
  zm_perks::function_b60f4a9f(#"specialty_electriccherry", #"p8_zm_vapor_altar_icon_01_electricburst", "zombie/fx8_perk_altar_symbol_ambient_electric_cherry", #"zmperkselectricburst");
  zm_perks::function_f3c80d73("zombie_perk_bottle_cherry", "zombie_perk_totem_electric_burst");
}

init_electric_cherry() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"electric_cherry_light"] = #"hash_1442db17b83460ad";
  }

  clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int", &electric_cherry_reload_attack_fx, 0, 0);
  clientfield::register("actor", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_death_fx_veh", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
  clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
  level._effect[#"electric_cherry_explode"] = #"hash_413a313438a3a4e1";
  level._effect[#"electric_cherry_trail"] = #"hash_58c2d7d24c0d61a7";
  level._effect[#"tesla_death_cherry"] = #"zombie/fx_tesla_shock_zmb";
  level._effect[#"tesla_shock_eyes_cherry"] = #"zombie/fx_tesla_shock_eyes_zmb";
  level._effect[#"tesla_shock_cherry"] = #"zombie/fx_bmode_shock_os_zod_zmb";
}

electric_cherry_client_field_func() {}

electric_cherry_code_callback_func() {}

electric_cherry_reload_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.electric_cherry_reload_fx)) {
    stopfx(localclientnum, self.electric_cherry_reload_fx);
    self.electric_cherry_reload_fx = undefined;
  }

  switch (newval) {
    case 1:
    case 2:
    case 3:
      self.electric_cherry_reload_fx = util::playFXOnTag(localclientnum, level._effect[#"electric_cherry_explode"], self, "tag_origin");
      break;
  }
}

tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 1) {
    str_tag = "J_SpineUpper";

    if(isDefined(self.str_tag_tesla_death_fx)) {
      str_tag = self.str_tag_tesla_death_fx;
    } else if(isDefined(self.isdog) && self.isdog) {
      str_tag = "J_Spine1";
    }

    if(!isDefined(self.var_16e53a57)) {
      self playSound(localclientnum, #"hash_3b277f4572603015");
      self.var_16e53a57 = self playLoopSound(#"hash_2f0f235f7f6fc84d");
    }

    self.n_death_fx = util::playFXOnTag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);

    if(isDefined(self.n_death_fx)) {
      setfxignorepause(localclientnum, self.n_death_fx, 1);
    }

    return;
  }

  if(isDefined(self.n_death_fx)) {
    deletefx(localclientnum, self.n_death_fx, 1);
    self.n_death_fx = undefined;
  }

  if(isDefined(self.var_16e53a57)) {
    self stoploopsound(self.var_16e53a57);
    self.var_16e53a57 = undefined;
  }
}

tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 1) {
    str_tag = "J_SpineUpper";

    if(isDefined(self.str_tag_tesla_shock_eyes_fx)) {
      str_tag = self.str_tag_tesla_shock_eyes_fx;
    } else if(isDefined(self.isdog) && self.isdog) {
      str_tag = "J_Spine1";
    }

    if(!isDefined(self.var_16e53a57)) {
      self playSound(localclientnum, #"hash_3b277f4572603015");
      self.var_16e53a57 = self playLoopSound(#"hash_2f0f235f7f6fc84d");
    }

    self.n_shock_eyes_fx = util::playFXOnTag(localclientnum, level._effect[#"tesla_shock_eyes_cherry"], self, "J_Eyeball_LE");

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
    }

    self.n_shock_fx = util::playFXOnTag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(localclientnum, self.n_shock_fx, 1);
    }

    return;
  }

  if(isDefined(self.n_shock_eyes_fx)) {
    deletefx(localclientnum, self.n_shock_eyes_fx, 1);
    self.n_shock_eyes_fx = undefined;
  }

  if(isDefined(self.n_shock_fx)) {
    deletefx(localclientnum, self.n_shock_fx, 1);
    self.n_shock_fx = undefined;
  }

  if(isDefined(self.var_16e53a57)) {
    self stoploopsound(self.var_16e53a57);
    self.var_16e53a57 = undefined;
  }
}