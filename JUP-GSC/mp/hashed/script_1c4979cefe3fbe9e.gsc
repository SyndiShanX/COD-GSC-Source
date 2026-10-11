/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c4979cefe3fbe9e.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a8a6bdf462ce1892;

function private autoexec init() {
  character = #"hash_d04cca4791b96fae";

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
  self setModel("body_c_jup_sp_enemy_pmc_grunt_red");
  self attach("head_c_jup_sp_enemy_pmc_grunt_05_02", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_05_02";
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
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_red");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_05_02");
}

function precache_cpmp() {
  precache();
}