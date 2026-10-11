/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_68a5d7921b3adc43.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_646627d08deffb05;

function private autoexec init() {
  character = #"hash_ae819c7bf69468f9";

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
  self setModel("body_c_jup_sp_enemy_pmc_grunt_female_01_desert");
  self attach("head_c_jup_sp_enemy_pmc_grunt_female_04", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_female_04";
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
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_female_01_desert");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_female_04");
}

function precache_cpmp() {
  precache();
}