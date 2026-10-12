/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\c_jup_sp_enemy_pmc_rook.gsc
*************************************************/



#using scripts\common\utility;
#namespace c_jup_sp_enemy_pmc_rook;

function private autoexec init() {
  character = #"c_jup_sp_enemy_pmc_rook";

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
  self.voice = #"konni";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_rook");
  self attach("head_c_jup_sp_enemy_pmc_rook", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_rook";
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
  precachemodel("body_c_jup_sp_enemy_pmc_rook");
  precachemodel("head_c_jup_sp_enemy_pmc_rook");
}

function precache_cpmp() {
  precache();
}