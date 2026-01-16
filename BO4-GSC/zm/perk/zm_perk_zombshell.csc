/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_zombshell.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_zombshell;

autoexec __init__system__() {
  system::register(#"zm_perk_zombshell", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_49ef5478510b5af3", 0)) {
    zm_perks::register_perk_clientfields(#"specialty_zombshell", &function_9e1d9985, &function_d0ba0d3);
    zm_perks::register_perk_effects(#"specialty_zombshell", "zombshell_light");
    zm_perks::register_perk_init_thread(#"specialty_zombshell", &function_efe56acb);
    zm_perks::function_b60f4a9f(#"specialty_zombshell", #"p8_zm_vapor_altar_icon_01_zombshell", "zombie/fx8_perk_altar_symbol_ambient_zombshell", #"zmperkszombshell");
    zm_perks::function_f3c80d73("zombie_perk_bottle_zombshell", "zombie_perk_totem_zombshell");
    clientfield::register("scriptmover", "" + #"zombshell_aoe", 15000, 1, "int", &zombshell_aoe, 0, 0);
    clientfield::register("toplayer", "" + #"hash_5f545b88ba3e2938", 15000, 1, "int", &function_1e112e5f, 0, 1);
    clientfield::register("actor", "" + #"zombshell_explosion", 15000, 1, "counter", &zombshell_explosion, 0, 0);
  }
}

function_efe56acb() {
  level._effect[#"zombshell_aoe"] = #"hash_3d2e7548c7dfc406";
  level._effect[#"zombshell_explosion"] = #"hash_1900ec48b2f264fe";
  level._effect[#"zombie_blood_1st"] = #"player/fx8_plyr_pstfx_katana_rush_loop";
}

function_9e1d9985() {}

function_d0ba0d3() {}

zombshell_aoe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.var_a6da95e6)) {
      deletefx(localclientnum, self.var_a6da95e6, 1);
    }

    self.var_a6da95e6 = util::playFXOnTag(localclientnum, level._effect[#"zombshell_aoe"], self, "tag_origin");

    if(!isDefined(self.var_e3d27e69)) {
      self playSound(localclientnum, #"hash_6aa32cc737673479");
      self.var_e3d27e69 = self playLoopSound(#"hash_d377c202c27be3f");
    }

    return;
  }

  if(isDefined(self.var_a6da95e6)) {
    deletefx(localclientnum, self.var_a6da95e6, 0);
    self.var_a6da95e6 = undefined;
  }

  if(isDefined(self.var_e3d27e69)) {
    self playSound(localclientnum, #"hash_5aa45eab2ab681e8");
    self stoploopsound(self.var_e3d27e69);
    self.var_e3d27e69 = undefined;
  }
}

function_1e112e5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(!isDefined(self.var_5b8b57b9)) {
    self.var_5b8b57b9 = [];
  }

  if(!isDefined(self.var_5b8b57b9[localclientnum])) {
    self.var_5b8b57b9[localclientnum] = [];
  }

  if(self.var_5b8b57b9[localclientnum].size) {
    self postfx::stoppostfxbundle(#"hash_4c9c4b6464bd9a1c");

    foreach(n_fx_id in self.var_5b8b57b9[localclientnum]) {
      stopfx(localclientnum, n_fx_id);
      n_fx_id = undefined;
    }

    if(newval == 0) {
      self.var_5b8b57b9[localclientnum] = undefined;
    }
  }

  if(newval == 1) {
    if(self getlocalclientnumber() === localclientnum) {
      self thread postfx::playpostfxbundle(#"hash_4c9c4b6464bd9a1c");
      self.var_5b8b57b9[localclientnum][self.var_5b8b57b9[localclientnum].size] = playfxoncamera(localclientnum, level._effect[#"zombie_blood_1st"]);
    }
  }
}

zombshell_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"zombshell_explosion"], self, "j_spineupper");
}