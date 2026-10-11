/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_25a007fae78eef2.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_9c763fd9e32b1686;

function private autoexec init() {
  character = #"hash_756e096fd90fbe0a";

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
  self.animationarchetype = "rebel";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_civ_prisoner_02_b_riot");
  self attach("c_jup_head_sc_m_bansal_beard", "", 1);
  self.headmodel = "c_jup_head_sc_m_bansal_beard";
  self setclothtype(#"cloth");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_civ_prisoner_02_b_riot");
  precachemodel("c_jup_head_sc_m_bansal_beard");
}

function precache_cpmp() {
  precache();
}