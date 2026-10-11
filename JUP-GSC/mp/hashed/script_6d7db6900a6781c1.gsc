/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d7db6900a6781c1.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_646621d08defedd3;

function private autoexec init() {
  character = #"hash_ae819e7bf6946c5f";

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
  self.voice = #"russianfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_grunt_female_01");
  self attach("head_c_jup_sp_enemy_pmc_grunt_female_02", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_female_02";
  self setclothtype(#"nylon");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_female_01");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_female_02");
}

function precache_cpmp() {
  precache();
}