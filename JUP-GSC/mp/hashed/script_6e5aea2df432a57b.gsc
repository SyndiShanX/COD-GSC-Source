/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6e5aea2df432a57b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_c9ff76798fb3bcdf;

function private autoexec init() {
  character = #"hash_b16e26ffff1fed8b";

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
  self setModel("body_c_jup_sp_enemy_pmc_grunt_olive");
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
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_olive");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_05_olive_01");
}

function precache_cpmp() {
  precache();
}