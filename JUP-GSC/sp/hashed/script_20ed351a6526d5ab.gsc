/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_20ed351a6526d5ab.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_66f9ccac660e8ebf;

function private autoexec init() {
  character = #"hash_d8ba4555a037ad3b";

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
  self setModel("body_c_jup_sp_enemy_pmc_capt_winter");
  self attach("head_c_jup_sp_enemy_pmc_capt_01", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_capt_01";
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_capt_winter");
  precachemodel("head_c_jup_sp_enemy_pmc_capt_01");
}

function precache_cpmp() {
  precache();
}