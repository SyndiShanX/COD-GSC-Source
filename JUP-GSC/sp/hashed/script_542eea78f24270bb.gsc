/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_542eea78f24270bb.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6af09e8e60d8bcd1;

function private autoexec init() {
  character = #"hash_37cb17ae051b1ead";

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
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_civ_stpeterburg_male_5_1");
  self attach("head_sc_m_bruce", "", 1);
  self.headmodel = "head_sc_m_bruce";
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
  precachemodel("body_civ_stpeterburg_male_5_1");
  precachemodel("head_sc_m_bruce");
}

function precache_cpmp() {
  precache();
}