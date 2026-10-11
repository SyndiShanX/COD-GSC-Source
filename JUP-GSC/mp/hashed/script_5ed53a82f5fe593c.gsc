/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5ed53a82f5fe593c.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_55f3a09d1f7bdc6e;

function private autoexec init() {
  character = #"hash_3ac1b6aafebbd832";

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
  self setModel("body_c_jup_sp_enemy_pmc_grunt_grey");
  self attach("head_c_jup_sp_enemy_pmc_grunt_05_olive_01", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_05_olive_01";
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
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_grey");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_05_olive_01");
}

function precache_cpmp() {
  precache();
}