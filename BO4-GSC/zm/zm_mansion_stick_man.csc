/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_stick_man.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_b6ca3ccc;

init_clientfields() {
  clientfield::register("scriptmover", "" + #"falling_leaves", 8000, 1, "int", &function_664898b6, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_34321e7ca580e772", 8000, 1, "int", &function_f6c7ad1b, 0, 0);
  clientfield::register("scriptmover", "" + #"stick_fire", 8000, 2, "int", &function_959fcbff, 0, 0);
  clientfield::register("scriptmover", "" + #"stone_rise", 8000, 1, "counter", &function_a7012457, 0, 0);
  clientfield::register("toplayer", "" + #"player_dragged", 8000, 1, "int", &function_a5f32c8f, 0, 0);
  clientfield::register("toplayer", "" + #"hash_4be98315796ad666", 8000, 1, "int", &function_f568352e, 0, 0);
  clientfield::register("allplayers", "" + #"sacrifice_player", 8000, 1, "int", &function_d61c8c59, 0, 0);
  clientfield::register("allplayers", "" + #"hash_30aa04edc476253f", 8000, 1, "int", &function_3c4642b1, 0, 0);
  level._effect[#"stick_fire"] = #"hash_31d36dbca458b0dd";
  level._effect[#"falling_leaves"] = #"hash_6d3c039680511839";
  level._effect[#"hash_dea2f3dceff7569"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect[#"player_afterlife"] = #"hash_6484874c383f70f9";
  level._effect[#"hash_418533e3f4de4e1a"] = #"hash_5586bb7a838e870a";
}

function_a7012457(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect[#"hash_dea2f3dceff7569"], self.origin);
  }
}

function_f6c7ad1b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle(#"hash_2db85fc8b73a1571");
    return;
  }

  self stoprenderoverridebundle(#"hash_2db85fc8b73a1571");
}

function_664898b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.var_f65805a8)) {
      stopfx(localclientnum, self.var_f65805a8);
    }

    self.var_f65805a8 = util::playFXOnTag(localclientnum, level._effect[#"falling_leaves"], self, "tag_origin");
  }
}

function_959fcbff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(isDefined(self.var_d8243293)) {
    stopfx(localclientnum, self.var_d8243293);
    self.var_d8243293 = undefined;
  }

  if(isDefined(self.var_f756621f)) {
    stopfx(localclientnum, self.var_f756621f);
    self.var_f756621f = undefined;
  }

  if(isDefined(self.var_a0bfa25b)) {
    self playSound(localclientnum, #"hash_7afee3f791f6bfa2");
    self stoploopsound(self.var_a0bfa25b);
  }

  if(newval == 1) {
    self.var_d8243293 = util::playFXOnTag(localclientnum, level._effect[#"stick_fire"], self, "tag_origin");

    if(!isDefined(self.var_a0bfa25b)) {
      self playSound(localclientnum, #"hash_4c82cdad375db1a2");
      self.var_a0bfa25b = self playLoopSound(#"hash_7449f6af6a74ea36");
    }

    return;
  }

  if(newval == 2) {
    forcestreamxmodel(#"p8_zm_man_dead_tree_branches_burned");
    util::delay(2, undefined, &stopforcestreamingxmodel, #"p8_zm_man_dead_tree_branches_burned");
    self.var_d8243293 = util::playFXOnTag(localclientnum, level._effect[#"stick_fire"], self, "tag_origin");

    if(!isDefined(self.var_a0bfa25b)) {
      self playSound(localclientnum, #"hash_4c82cdad375db1a2");
      self.var_a0bfa25b = self playLoopSound(#"hash_7449f6af6a74ea36");
    }

    wait 2;
    self.var_f756621f = util::playFXOnTag(localclientnum, level._effect[#"hash_418533e3f4de4e1a"], self, "tag_origin");
  }
}

function_a5f32c8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(isDefined(self.var_fe11bb61)) {
    deletefx(localclientnum, self.var_fe11bb61, 1);
    self.var_fe11bb61 = undefined;
  }

  if(newval == 1) {
    self.var_fe11bb61 = playfxoncamera(localclientnum, level._effect[#"player_afterlife"]);
    self postfx::playpostfxbundle(#"hash_66a9fee7028a1e13");

    if(!isDefined(self.var_9096803d)) {
      self playSound(localclientnum, #"hash_6395d64b5a8efc03");
      self.var_9096803d = self playLoopSound(#"hash_6e133362b9af5877");
    }

    return;
  }

  self postfx::stoppostfxbundle(#"hash_66a9fee7028a1e13");

  if(isDefined(self.var_9096803d)) {
    self playSound(localclientnum, #"hash_3ca6c0d3ecd48de2");
    self stoploopsound(self.var_9096803d);
    self.var_9096803d = undefined;
  }
}

function_f568352e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval) {
    self postfx::playpostfxbundle(#"hash_2b222dbd1ad76165");

    if(!isDefined(self.var_eb29cb6e)) {
      self playSound(localclientnum, #"hash_414c95206d51679c");
      self.var_eb29cb6e = self playLoopSound(#"hash_1d748b5f5528a66a");
    }

    return;
  }

  self postfx::stoppostfxbundle(#"hash_2b222dbd1ad76165");

  if(isDefined(self.var_eb29cb6e)) {
    self playSound(localclientnum, #"hash_6560ce0b7a4a80c9");
    self stoploopsound(self.var_eb29cb6e);
    self.var_eb29cb6e = undefined;
  }
}

function_d61c8c59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_b196c692)) {
    self.var_b196c692 = [];
  }

  if(!isDefined(self.var_b196c692[localclientnum])) {
    self.var_b196c692[localclientnum] = [];
  }

  if(newval == 1) {
    if(self getlocalclientnumber() === localclientnum) {
      self thread postfx::playpostfxbundle(#"hash_33e699252aac7a7e");

      if(!isDefined(self.var_637d4665)) {
        self playSound(localclientnum, #"hash_4ce4fa4f56e4698d");
        self.var_637d4665 = self playLoopSound(#"hash_43bc941f5e61242d");
      }

      a_e_players = getlocalplayers();

      foreach(e_player in a_e_players) {
        if(!e_player util::function_50ed1561(localclientnum)) {
          e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_33e699252aac7a7e", #"hash_3ac1c56d5f920a24");
        }
      }
    } else {
      if(self hasdobj(localclientnum)) {
        self.var_b196c692[localclientnum] = playtagfxset(localclientnum, "weapon_katana_smoke_3p", self);
      }

      if(!isDefined(self.var_5d816fd0)) {
        self playSound(localclientnum, #"hash_50cea74fea1f3dcc");
        self.var_637d4665 = self playLoopSound(#"hash_47a7411ff19dab6c");
      }
    }

    return;
  }

  if(self getlocalclientnumber() === localclientnum) {
    self postfx::stoppostfxbundle(#"hash_33e699252aac7a7e");
    a_e_players = getlocalplayers();

    foreach(e_player in a_e_players) {
      if(!e_player util::function_50ed1561(localclientnum)) {
        e_player notify(#"hash_3ac1c56d5f920a24");
      }
    }

    if(isDefined(self.var_637d4665)) {
      self playSound(localclientnum, #"hash_db54c67c5697558");
      self stoploopsound(self.var_637d4665);
      self.var_637d4665 = undefined;
    }

    return;
  }

  if(isDefined(self.var_b196c692[localclientnum])) {
    foreach(fx in self.var_b196c692[localclientnum]) {
      stopfx(localclientnum, fx);
    }

    self.var_b196c692[localclientnum] = undefined;
  }

  if(isDefined(self.var_5d816fd0)) {
    self playSound(localclientnum, #"hash_28d41f681d0c4371");
    self stoploopsound(self.var_5d816fd0);
    self.var_5d816fd0 = undefined;
  }
}

function_3c4642b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_928ceb18)) {
    stopfx(localclientnum, self.var_928ceb18);
    self.var_928ceb18 = undefined;
    self notify(#"hash_ac788aea26a8b23");
  }

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(newval == 1) {
    self.var_928ceb18 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_torso", self, "j_spinelower");
    self thread function_443d6ae(localclientnum);
    self playSound(localclientnum, #"hash_71ccbe40ffaafe22");
  }
}

function_443d6ae(localclientnum) {
  self endon(#"death", #"hash_ac788aea26a8b23");
  wait 0.15;
  self playrenderoverridebundle(#"hash_429426f01ad84c8b");
}