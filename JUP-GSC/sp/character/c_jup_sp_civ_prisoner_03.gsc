/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\c_jup_sp_civ_prisoner_03.gsc
**************************************************/



#using scripts\common\utility;
#namespace c_jup_sp_civ_prisoner_03;

function private autoexec init() {
  character = #"c_jup_sp_civ_prisoner_03";

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
  self.animationarchetype = "civilian_react";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_civ_prisoner_03");
  self attach("head_c_jup_sc_m_orlovszki_civ_tattoo", "", 1);
  self.headmodel = "head_c_jup_sc_m_orlovszki_civ_tattoo";
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
  precachemodel("body_c_jup_sp_civ_prisoner_03");
  precachemodel("head_c_jup_sc_m_orlovszki_civ_tattoo");
}

function precache_cpmp() {
  precache();
}