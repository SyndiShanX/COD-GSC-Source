/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_75a22b42a13d8f69.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_c083b66e4e01119b;

function private autoexec init() {
  character = #"hash_2ab9e950b4d92baf";

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
  self.animationarchetype = "zombie_abom_mega";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_abom";
  self setModel("c_jup_zmb_abomination_megabomb_body_hvt");
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_abomination_megabomb_body_hvt");
}

function precache_cpmp() {
  precache();
}