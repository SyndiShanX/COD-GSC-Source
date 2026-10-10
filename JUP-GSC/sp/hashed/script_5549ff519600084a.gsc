/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5549ff519600084a.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_84ac6eea6babcf10;

function private autoexec init() {
  character = #"hash_996b429535b5721c";

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
  self.animationarchetype = "rebel";
  self.voice = #"sas";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_hero_kyle_marina");
  self attach("head_hero_kyle_marina_blendshape", "", 1);
  self.headmodel = "head_hero_kyle_marina_blendshape";
  self setclothtype(#"wetsuit");
  self function_8abe5a968cc3c220(#"milmedgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_hero_kyle_marina");
  precachemodel("head_hero_kyle_marina_blendshape");
}

function precache_cpmp() {
  precache();
}