/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_399cf54386d2a876.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a5a6a3eec30ae18c;

function private autoexec init() {
  character = #"hash_25e0bd03329187f0";

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
  self setModel("body_c_jup_sp_enemy_pmc_rusher_04");
  self attach("head_c_jup_sp_enemy_pmc_rusher_04", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_rusher_04";
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
  precachemodel("body_c_jup_sp_enemy_pmc_rusher_04");
  precachemodel("head_c_jup_sp_enemy_pmc_rusher_04");
}

function precache_cpmp() {
  precache();
}