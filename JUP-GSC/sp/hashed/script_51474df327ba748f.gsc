/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_51474df327ba748f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a189c26b1a75cb35;

function private autoexec init() {
  character = #"hash_9d5d05c5a86f4a09";

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
  self.voice = #"sas";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_soap_nvm");
  self attach("head_c_jup_sp_hero_soap_nvm", "", 1);
  self.headmodel = "head_c_jup_sp_hero_soap_nvm";
  self setclothtype(#"nylon");
  self function_8abe5a968cc3c220(#"milmedgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_hero_soap_nvm");
  precachemodel("head_c_jup_sp_hero_soap_nvm");
}

function precache_cpmp() {
  precache();
}