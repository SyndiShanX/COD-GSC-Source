/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_death_dash.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_death_dash;

autoexec __init__system__() {
  system::register(#"zm_perk_death_dash", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_1c1a8ed8d0bf271c", 0)) {
    function_27473e44();
  }
}

function_27473e44() {
  zm_perks::register_perk_clientfields(#"specialty_death_dash", &client_field_func, &code_callback_func);
  zm_perks::register_perk_init_thread(#"specialty_death_dash", &init);
  zm_perks::function_b60f4a9f(#"specialty_death_dash", #"p8_zm_vapor_altar_icon_01_blaze_phase", "zombie/fx8_perk_altar_symbol_ambient_blaze_phase", #"zmperksdeathdash");
  zm_perks::function_f3c80d73("zombie_perk_bottle_death_dash", "zombie_perk_totem_death_dash");
}

init() {}

client_field_func() {
  clientfield::register("allplayers", "death_dash_charging", 24000, 1, "int", &function_bfd817c1, 0, 0);
  clientfield::register("allplayers", "death_dash_charged", 24000, 1, "int", &function_fe2634b2, 0, 0);
  clientfield::register("allplayers", "death_dash_charged_mod", 24000, 1, "int", &function_237b1f1e, 0, 0);
  clientfield::register("allplayers", "death_dash_trail", 24000, 1, "int", &function_dced8aba, 0, 0);
  clientfield::register("toplayer", "death_dash_charging_postfx", 24000, 1, "int", &function_fbdede2b, 0, 0);
  clientfield::register("toplayer", "death_dash_dash_postfx", 24000, 1, "int", &function_c8a1ee6b, 0, 0);
  clientfield::register("toplayer", "death_dash_charged_mod_postfx", 24000, 1, "int", &function_cc24f836, 0, 0);
}

code_callback_func() {}

function_bfd817c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.death_dash_charging_fx = util::playFXOnTag(localclientnum, "zombie/fx8_perk_blaze_phase_charging", self, "tag_origin");

    if(!isDefined(self.var_51a4a975)) {
      self.var_51a4a975 = self playLoopSound(#"hash_4d72f993ab3784d0");
    }

    self playrumbleonentity(localclientnum, #"damage_light");
    return;
  }

  if(isDefined(self.death_dash_charging_fx)) {
    stopfx(localclientnum, self.death_dash_charging_fx);
    self.death_dash_charging_fx = undefined;
  }

  if(isDefined(self.var_51a4a975)) {
    self stoploopsound(self.var_51a4a975);
    self.var_51a4a975 = undefined;
  }
}

function_fe2634b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.death_dash_charged_fx = util::playFXOnTag(localclientnum, "zombie/fx8_perk_blaze_phase_charged", self, "tag_origin");

    if(!isDefined(self.var_202e9919)) {
      self.var_202e9919 = self playLoopSound(#"hash_1bd81725dee72cb");
    }

    if(isDefined(self.var_51a4a975)) {
      self stoploopsound(self.var_51a4a975);
      self.var_51a4a975 = undefined;
    }

    self playrumbleonentity(localclientnum, #"damage_light");
    return;
  }

  if(isDefined(self.death_dash_charged_fx)) {
    stopfx(localclientnum, self.death_dash_charged_fx);
    self.death_dash_charged_fx = undefined;
  }

  if(isDefined(self.var_202e9919)) {
    self stoploopsound(self.var_202e9919);
    self.var_202e9919 = undefined;
  }
}

function_237b1f1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.death_dash_charged_mod_fx = util::playFXOnTag(localclientnum, "zombie/fx8_perk_blaze_phase_charged_stretch", self, "tag_origin");

    if(!isDefined(self.var_202e9919)) {
      self.var_202e9919 = self playLoopSound(#"hash_1bd81725dee72cb");
    }

    if(isDefined(self.var_51a4a975)) {
      self stoploopsound(self.var_51a4a975);
      self.var_51a4a975 = undefined;
    }

    self playrumbleonentity(localclientnum, #"damage_heavy");
    return;
  }

  if(isDefined(self.death_dash_charged_mod_fx)) {
    stopfx(localclientnum, self.death_dash_charged_mod_fx);
    self.death_dash_charged_mod_fx = undefined;
  }

  if(isDefined(self.var_202e9919)) {
    self stoploopsound(self.var_202e9919);
    self.var_202e9919 = undefined;
  }
}

function_dced8aba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.death_dash_trail_fx = util::playFXOnTag(localclientnum, "zombie/fx8_perk_blaze_phase_trail", self, "tag_origin");

    if(!isDefined(self.var_884925ad)) {
      self playSound(localclientnum, #"hash_1075f6d6c2524599");
      self.var_884925ad = self playLoopSound(#"hash_fa14d87437616df");
    }

    return;
  }

  if(isDefined(self.death_dash_trail_fx)) {
    stopfx(localclientnum, self.death_dash_trail_fx);
    self.death_dash_trail_fx = undefined;
  }

  if(isDefined(self.var_884925ad)) {
    self playSound(localclientnum, #"hash_42cb90d7c4d6ad08");
    self stoploopsound(self.var_884925ad);
    self.var_884925ad = undefined;
  }

  self playrumbleonentity(localclientnum, "damage_heavy");
}

function_fbdede2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self postfx::playpostfxbundle("pstfx_burn_loop_blaze_phaze");
    return;
  }

  self postfx::stoppostfxbundle("pstfx_burn_loop_blaze_phaze");
}

function_c8a1ee6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self postfx::stoppostfxbundle("pstfx_zm_chakram_speedblur");
    self postfx::playpostfxbundle("pstfx_zm_chakram_speedblur");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_zm_chakram_speedblur");
}

function_cc24f836(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self postfx::stoppostfxbundle("pstfx_zm_fire_blue_trap");
    self postfx::playpostfxbundle("pstfx_zm_fire_blue_trap");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_zm_fire_blue_trap");
}