/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_katana.csc
***********************************************/

#include script_70ab01a7690ea256;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_katana;

autoexec __init__system__() {
  system::register(#"zm_weap_katana", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "" + #"hero_katana_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
  clientfield::register("allplayers", "" + #"katana_rush_postfx", 1, 1, "int", &katana_rush_postfx, 0, 1);
  clientfield::register("allplayers", "" + #"katana_rush_sfx", 1, 1, "int", &katana_rush_sfx, 0, 1);
}

private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue && !namespace_a6aea2c6::is_active(#"silent_film")) {
    self thread postfx::playpostfxbundle(#"hash_4e5b35f770492ddb");
  }
}

katana_rush_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_d3d459f)) {
    self.var_d3d459f = [];
  }

  if(!isDefined(self.var_d3d459f[localclientnum])) {
    self.var_d3d459f[localclientnum] = [];
  }

  if(newval == 1) {
    if(self.weapon !== getweapon(#"hero_katana_t8_lv3")) {
      return;
    }

    if(self getlocalclientnumber() === localclientnum) {
      self thread postfx::playpostfxbundle(#"hash_34ce6f9f022458f8");
      self thread function_66752a96(localclientnum);
      a_e_players = getlocalplayers();

      foreach(e_player in a_e_players) {
        if(!e_player util::function_50ed1561(localclientnum)) {
          e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_34ce6f9f022458f8", #"hash_49e404aa0d33e9ac");
        }
      }
    } else if(self hasdobj(localclientnum)) {
      self.var_d3d459f[localclientnum] = playtagfxset(localclientnum, "weapon_katana_smoke_3p", self);
    }

    return;
  }

  if(self getlocalclientnumber() === localclientnum) {
    self postfx::stoppostfxbundle(#"hash_34ce6f9f022458f8");
    self thread function_82ee4d9d(localclientnum);
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player notify(#"hash_49e404aa0d33e9ac");
      }
    }

    return;
  }

  if(isDefined(self.var_d3d459f[localclientnum])) {
    foreach(fx in self.var_d3d459f[localclientnum]) {
      stopfx(localclientnum, fx);
    }

    self.var_d3d459f[localclientnum] = undefined;
  }
}

private function_66752a96(localclientnum) {
  ai::add_ai_spawn_function(&function_74541167);
  a_ai = getentarraybytype(localclientnum, 15);

  foreach(ai in a_ai) {
    ai thread function_74541167(localclientnum);
  }
}

private function_74541167(localclientnum) {
  if(!isDefined(self.var_1030ad00)) {
    self.var_1030ad00 = [];
  }

  if(!isDefined(self.var_1030ad00[localclientnum])) {
    self.var_1030ad00[localclientnum] = [];
  }

  if(!self.var_1030ad00[localclientnum].size && self hasdobj(localclientnum)) {
    self.var_1030ad00[localclientnum] = playtagfxset(localclientnum, "weapon_katana_zmb_smoke_3p", self);
  }
}

private function_82ee4d9d(localclientnum) {
  ai::function_932006d1(&function_74541167);
  a_ai = getentarraybytype(localclientnum, 15);

  foreach(ai in a_ai) {
    if(isDefined(ai.var_1030ad00) && isDefined(ai.var_1030ad00[localclientnum])) {
      foreach(fx in ai.var_1030ad00[localclientnum]) {
        killfx(localclientnum, fx);
      }

      ai.var_1030ad00[localclientnum] = undefined;
    }
  }
}

katana_rush_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_7804a42c)) {
      self playSound(localclientnum, #"hash_74fd1bb2db3d91ee");
      self.var_7804a42c = self playLoopSound(#"hash_4f7953dcf02e2ba7");
    }

    return;
  }

  if(isDefined(self.var_7804a42c)) {
    self playSound(localclientnum, #"hash_76e75d7b16257c11");
    self stoploopsound(self.var_7804a42c);
    self.var_7804a42c = undefined;
  }
}