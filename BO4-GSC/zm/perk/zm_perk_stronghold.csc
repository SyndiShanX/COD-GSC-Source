/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_stronghold.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_stronghold;

autoexec __init__system__() {
  system::register(#"zm_perk_stronghold", &__init__, undefined, undefined);
}

__init__() {
  enable_stronghold_perk_for_level();
  level._effect[#"hash_24e322568c9492c5"] = #"hash_497cb15bcf6c05b1";
  callback::on_localclient_connect(&on_localclient_connect);
}

enable_stronghold_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_camper", &function_5a4557ee, &function_44bd921f);
  zm_perks::register_perk_effects(#"specialty_camper", "divetonuke_light");
  zm_perks::register_perk_init_thread(#"specialty_camper", &init_stronghold);
  zm_perks::function_b60f4a9f(#"specialty_camper", #"p8_zm_vapor_altar_icon_01_stonecoldstronghold", "zombie/fx8_perk_altar_symbol_ambient_stronghold", #"zmperksstonecold");
  zm_perks::function_f3c80d73("zombie_perk_bottle_stronghold", "zombie_perk_totem_stronghold");
}

init_stronghold() {}

function_5a4557ee() {
  clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int", &function_2400dd1d, 0, 1);
}

function_44bd921f() {}

function_2400dd1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_f9c892e3)) {
    self.var_f9c892e3 = [];
  }

  if(newval) {
    if(isDefined(self.var_f9c892e3[localclientnum])) {
      deletefx(localclientnum, self.var_f9c892e3[localclientnum], 1);
    }

    self.var_f9c892e3[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_24e322568c9492c5"], self, "j_spine");

    if(!isDefined(self.var_2ec16150)) {
      self playSound(localclientnum, #"hash_5e1e162af8490f1d");
      self.var_2ec16150 = self playLoopSound(#"hash_641286598a33d4e3");
    }

    return;
  }

  if(isDefined(self.var_f9c892e3[localclientnum])) {
    deletefx(localclientnum, self.var_f9c892e3[localclientnum], 0);
    self.var_f9c892e3[localclientnum] = undefined;
  }

  if(isDefined(self.var_2ec16150)) {
    self playSound(localclientnum, #"hash_73b66a25abec1fe4");
    self stoploopsound(self.var_2ec16150);
    self.var_2ec16150 = undefined;
  }
}

on_localclient_connect(localclientnum) {
  self callback::on_death(&on_death);
}

on_death(params) {
  if(!isplayer(self)) {
    return;
  }

  localclientnum = params.localclientnum;

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(isarray(self.var_f9c892e3) && isDefined(self.var_f9c892e3[localclientnum])) {
    deletefx(localclientnum, self.var_f9c892e3[localclientnum], 1);
  }
}