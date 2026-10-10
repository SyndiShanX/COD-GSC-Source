/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c53c4276223d748.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_19618770ea797a04;

function private autoexec init() {
  character = #"hash_6ff7915d27301448";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "warlord_chemist";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_ext_chemist");
  self attach("head_c_jup_ext_chemist", "", 1);
  self.headmodel = "head_c_jup_ext_chemist";
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"milmedgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_ext_chemist");
  precachemodel("head_c_jup_ext_chemist");
}

function precache_cpmp() {
  precache();
}