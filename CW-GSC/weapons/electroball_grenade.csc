/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\electroball_grenade.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace electroball_grenade;

function private autoexec __init__system__() {
  system::register("electroball_grenade", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("toplayer", "electroball_tazered", 1, 1, "int", undefined, 0, 0);
  clientfield::register("allplayers", "electroball_shock", 1, 1, "int", &function_7ec61d7a, 0, 0);
  clientfield::register("missile", "electroball_stop_trail", 1, 1, "int", &function_7b605b7b, 0, 0);
  clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int", &electroball_play_landed_fx, 0, 0);
  level._effect[# "fx9_mech_wpn_115_blob"] = "zm_ai/fx9_mech_wpn_115_blob";
  level._effect[# "fx9_mech_wpn_115_bul_trail"] = "zm_ai/fx9_mech_wpn_115_bul_trail";
  level._effect[# "fx9_mech_wpn_115_canister"] = "zm_ai/fx9_mech_wpn_115_canister";
  level._effect[# "hash_3a6575aae8a7ccd4"] = "weapon/fx_prox_grenade_impact_player_spwner";
  level._effect[# "hash_58bd536e46d7c711"] = "weapon/fx_prox_grenade_exp";
  callback::add_weapon_type("electroball_grenade", &proximity_spawned);
}

function proximity_spawned(localclientnum) {
  self util::waittill_dobj(localclientnum);

  if(self isgrenadedud()) {
    return;
  }

  self.var_78b154ef = util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_wpn_115_bul_trail"], self, "j_grenade_front");
  self.var_de70e6e2 = util::playFXOnTag(localclientnum, level._effect[# "fx9_mech_wpn_115_canister"], self, "j_grenade_back");
}

function function_7ec61d7a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  fx = util::playFXOnTag(bwastimejump, level._effect[# "hash_3a6575aae8a7ccd4"], self, "J_SpineUpper");
}

function function_7b605b7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_542ac835)) {
    level.var_542ac835 = [];
  }

  array::add(level.var_542ac835, self);
  self callback::on_shutdown(&function_76787bb);

  if(isDefined(self.var_78b154ef)) {
    stopfx(bwastimejump, self.var_78b154ef);
  }

  if(isDefined(self.var_87f9f380)) {
    stopfx(bwastimejump, self.var_87f9f380);
  }

  if(isDefined(self.var_d026ca4e)) {
    stopfx(bwastimejump, self.var_d026ca4e);
  }

  if(isDefined(self.var_de70e6e2)) {
    stopfx(bwastimejump, self.var_de70e6e2);
  }
}

function function_76787bb(params) {
  arrayremovevalue(level.var_542ac835, undefined);
}

function electroball_play_landed_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_ac6e3a4d = util::playFXOnTag(bwastimejump, level._effect[# "fx9_mech_wpn_115_blob"], self, "tag_origin");
  dynent = createdynentandlaunch(bwastimejump, "p7_zm_ctl_115_grenade_broken", self.origin, self.angles, self.origin, (0, 0, 0));
}