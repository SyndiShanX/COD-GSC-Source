/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1851a30a104541b5.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_7f25b492196429e1;

function private autoexec init() {
  character = #"hash_d465b707ba7ce1d5";

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
  self setModel("body_c_jup_sp_civ_worker_03");
  self attach("head_sc_m_yurteri_beard", "", 1);
  self.headmodel = "head_sc_m_yurteri_beard";
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
  precachemodel("body_c_jup_sp_civ_worker_03");
  precachemodel("head_sc_m_yurteri_beard");
}

function precache_cpmp() {
  precache();
}