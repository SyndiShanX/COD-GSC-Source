/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3a954b97058821b3.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_e0274e37aaa962ed;

function private autoexec init() {
  character = #"hash_f7463efed058b719";

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
  self.voice = #"fsa";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("civ_amsterdam_male_3_1");
  self attach("head_sc_m_vozhyuk_bg_civ", "", 1);
  self.headmodel = "head_sc_m_vozhyuk_bg_civ";
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
  precachemodel("civ_amsterdam_male_3_1");
  precachemodel("head_sc_m_vozhyuk_bg_civ");
}

function precache_cpmp() {
  precache();
}