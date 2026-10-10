/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3c3d6a77457a1e3f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_2582ba1a52053b55;

function private autoexec init() {
  character = #"hash_d2393444e3930941";

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
  self.animationarchetype = "soldier";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_heroe_nikolai_convoy");
  self attach("head_hero_nikolai", "", 1);
  self.headmodel = "head_hero_nikolai";
  self setclothtype(#"hash_1f62791cede09086");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_heroe_nikolai_convoy");
  precachemodel("head_hero_nikolai");
}

function precache_cpmp() {
  precache();
}