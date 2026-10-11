/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_41b8c4e8b8f5a09b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a48eda28e914b029;

function private autoexec init() {
  character = #"hash_5030d72c95ba3a75";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_airstrip_03");
  self attach("head_c_jup_sp_enemy_pmc_airstrip_03", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_airstrip_03";
  self setclothtype(#"vestheavy");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_airstrip_03");
  precachemodel("head_c_jup_sp_enemy_pmc_airstrip_03");
}

function precache_cpmp() {
  precache();
}