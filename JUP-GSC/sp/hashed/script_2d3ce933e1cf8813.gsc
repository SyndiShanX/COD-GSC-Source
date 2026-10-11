/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2d3ce933e1cf8813.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6c52abd8abb936e9;

function private autoexec init() {
  character = #"hash_8afcb61aeacb1735";

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
  self.voice = #"sas";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_grunt_02");
  self attach("head_c_jup_sp_enemy_pmc_grunt_02", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_02";
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
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_02");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_02");
}

function precache_cpmp() {
  precache();
}