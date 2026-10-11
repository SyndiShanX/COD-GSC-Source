/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4ef07b90e2aeb7fe.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6af09b8e60d8b638;

function private autoexec init() {
  character = #"hash_37cb14ae051b1994";

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
  self setModel("body_civ_london_male_2_1");
  self attach("head_sc_m_cueto", "", 1);
  self.headmodel = "head_sc_m_cueto";
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
  precachemodel("body_civ_london_male_2_1");
  precachemodel("head_sc_m_cueto");
}

function precache_cpmp() {
  precache();
}