/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_19321e6a67447f6.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_b4e2cf8d679fc964;

function private autoexec init() {
  character = #"hash_f41d6c90cd320ae0";

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
  self.animationarchetype = "riotshield";
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_police_kastovia_02");
  self attach("head_c_jup_sc_m_allen", "", 1);
  self.headmodel = "head_c_jup_sc_m_allen";
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
  precachemodel("body_c_jup_sp_enemy_police_kastovia_02");
  precachemodel("head_c_jup_sc_m_allen");
}

function precache_cpmp() {
  precache();
}