/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_flamethrower.csc
***********************************************/

#include script_70ab01a7690ea256;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_flamethrower;

autoexec __init__system__() {
  system::register(#"zm_weap_flamethrower", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int", &flamethrower_tornado_fx, 0, 0);
  clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
  clientfield::register("toplayer", "flamethrower_wind_blast_flash", -1, 1, "counter", &flamethrower_wind_blast_flash, 0, 0);
  clientfield::register("allplayers", "flamethrower_wind_blast_tu16", 16000, 1, "counter", &flamethrower_wind_blast_flash, 0, 0);
  clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter", &flamethrower_tornado_blast_flash, 0, 0);
  level._effect[#"flamethrower_tornado"] = #"hash_2f45879d2658065c";
  level._effect[#"wind_blast_flash"] = #"hash_312fc9707e06f6f4";
  level._effect[#"hash_34db403668f7f353"] = #"hash_52e3de5257e268c2";
  level._effect[#"tornado_blast_flash"] = #"hash_5c5ffb835c39dce3";
}

flamethrower_tornado_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.n_tornado_fx)) {
      stopfx(localclientnum, self.n_tornado_fx);
    }

    self.n_tornado_fx = util::playFXOnTag(localclientnum, level._effect[#"flamethrower_tornado"], self, "tag_origin");

    if(!isDefined(self.var_180064c2)) {
      self thread function_ea05550b(localclientnum);
    }

    self thread function_4e325cd6(localclientnum);
    return;
  }

  if(isDefined(self.n_tornado_fx)) {
    stopfx(localclientnum, self.n_tornado_fx);
    self.n_tornado_fx = undefined;
  }

  if(isDefined(self.var_180064c2)) {
    self playSound(localclientnum, #"hash_51812161eb23c96f");
    self stoploopsound(self.var_180064c2);
    self.var_180064c2 = undefined;
  }

  self notify(#"hash_4a10e61d27734104");
}

function_ea05550b(localclientnum) {
  self endon(#"death", #"hash_4a10e61d27734104");
  wait 0.1;
  self playSound(localclientnum, #"hash_2e4b3d95b5a51afa");
  self.var_180064c2 = self playLoopSound(#"hash_468cabb7402e170e");
}

function_4e325cd6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death", #"hash_4a10e61d27734104");

  while(true) {
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        continue;
      }

      if(distance(e_player.origin, self.origin) <= 128) {
        e_player playrumbleonentity(localclientnum, "damage_heavy");
      }
    }

    wait 0.25;
  }
}

private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue && !namespace_a6aea2c6::is_active(#"silent_film")) {
    self thread postfx::playpostfxbundle(#"hash_28d2c6df1a547302");
  }
}

flamethrower_wind_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self zm_utility::function_f8796df3(localclientnum)) {
    playviewmodelfx(localclientnum, level._effect[#"wind_blast_flash"], "tag_flash");
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"hash_34db403668f7f353"], self, "tag_flash");
}

flamethrower_tornado_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self zm_utility::function_f8796df3(localclientnum)) {
    playviewmodelfx(localclientnum, level._effect[#"tornado_blast_flash"], "tag_flash");
    return;
  }

  util::playFXOnTag(localclientnum, level._effect[#"tornado_blast_flash"], self, "tag_flash");
}