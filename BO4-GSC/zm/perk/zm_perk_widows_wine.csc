/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_widows_wine.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_widows_wine;

autoexec __init__system__() {
  system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

__init__() {
  zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_client_field_func, &widows_wine_code_callback_func);
  zm_perks::register_perk_effects(#"specialty_widowswine", "widow_light");
  zm_perks::register_perk_init_thread(#"specialty_widowswine", &init_widows_wine);
  zm_perks::function_b60f4a9f(#"specialty_widowswine", #"p8_zm_vapor_altar_icon_01_winterswail", "zombie/fx8_perk_altar_symbol_ambient_widows_wine", #"zmperkswidowswail");
  zm_perks::function_f3c80d73("zombie_perk_bottle_widows_wine", "zombie_perk_totem_winters_wail");
}

init_widows_wine() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
    level._effect[#"winters_wail_freeze"] = "zombie/fx8_perk_winters_wail_freeze";
    level._effect[#"winters_wail_explosion"] = "zombie/fx8_perk_winters_wail_exp";
    level._effect[#"winters_wail_slow_field"] = "zombie/fx8_perk_winters_wail_aoe";
  }
}

widows_wine_client_field_func() {
  clientfield::register("actor", "winters_wail_freeze", 1, 1, "int", &function_fd02d096, 0, 1);
  clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int", &function_fd02d096, 0, 0);
  clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter", &widows_wine_explosion, 0, 0);
  clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int", &function_c6366dbe, 0, 0);
}

widows_wine_code_callback_func() {}

function_fd02d096(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isalive(self)) {
      if(!isDefined(self.var_ba239a31)) {
        if(isDefined(self gettagorigin("j_spineupper"))) {
          str_tag = "j_spineupper";
        } else {
          str_tag = "j_spine4";
        }

        self.var_ba239a31 = util::playFXOnTag(localclientnum, level._effect[#"winters_wail_freeze"], self, str_tag);
      }

      if(!isDefined(self.sndwidowswine)) {
        self playSound(localclientnum, #"hash_21bfd3813003fd44");
        self.sndwidowswine = self playLoopSound(#"hash_199de7173fb36de6", 0.1);
      }
    }

    return;
  }

  if(isDefined(self.var_ba239a31)) {
    stopfx(localclientnum, self.var_ba239a31);
    self.var_ba239a31 = undefined;
  }

  if(isDefined(self.sndwidowswine)) {
    self stoploopsound(self.sndwidowswine, 1);
  }
}

widows_wine_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && isDefined(self) && isDefined(level._effect[#"winters_wail_explosion"])) {
    origin = self gettagorigin("j_spine4");

    if(!isDefined(origin)) {
      origin = self.origin;
    }

    playFX(localclientnum, level._effect[#"winters_wail_explosion"], origin, anglesToForward(self.angles));
    self playSound(localclientnum, #"hash_3b59d3c99bac4071");
  }
}

function_c6366dbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_e7addfc4)) {
    self.var_e7addfc4 = [];
  }

  if(isDefined(self.var_e7addfc4[localclientnum])) {
    stopfx(localclientnum, self.var_e7addfc4[localclientnum]);
    self.var_e7addfc4[localclientnum] = undefined;
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      e_player notify(#"hash_517b3e71a56dcfcb");
    }
  }

  if(newval) {
    self.var_e7addfc4[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"winters_wail_slow_field"], self, "j_spine");
    self playSound(localclientnum, #"hash_2d956dd01a5a8800");
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player thread zm_utility::function_ae3780f1(localclientnum, self.var_e7addfc4[localclientnum], #"hash_517b3e71a56dcfcb");
      }
    }
  }
}