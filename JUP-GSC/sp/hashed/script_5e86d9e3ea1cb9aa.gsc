/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5e86d9e3ea1cb9aa.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a48edb28e914b25c;

function private autoexec init() {
  character = #"hash_5030d02c95ba2e90";

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
  self setModel("body_c_jup_sp_enemy_pmc_airstrip_04");
  self attach("head_c_jup_sp_enemy_pmc_airstrip_04", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_airstrip_04";
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
  precachemodel("body_c_jup_sp_enemy_pmc_airstrip_04");
  precachemodel("head_c_jup_sp_enemy_pmc_airstrip_04");
}

function precache_cpmp() {
  precache();
}