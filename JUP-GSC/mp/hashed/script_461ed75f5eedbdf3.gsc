/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_461ed75f5eedbdf3.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_d6090f35eb6efbf7;

function private autoexec init() {
  character = #"hash_7779fa543f4f836b";

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
  self.animationarchetype = "warlord_maestro_rainmaker";
  self.voice = #"shadowcompany";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_ext_maestro");
  self attach("head_c_jup_ext_maestro", "", 1);
  self.headmodel = "head_c_jup_ext_maestro";
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
  precachemodel("body_c_jup_ext_maestro");
  precachemodel("head_c_jup_ext_maestro");
}

function precache_cpmp() {
  precache();
}