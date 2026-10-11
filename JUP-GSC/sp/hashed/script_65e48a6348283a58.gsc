/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_65e48a6348283a58.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_7e5ca9f3245b0c2;

function private autoexec init() {
  character = #"hash_ebaf0721e4daa676";

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
  self setModel("body_c_jup_civ_paramedic_01");
  self attach("c_jup_head_sc_m_dunn", "", 1);
  self.headmodel = "c_jup_head_sc_m_dunn";
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
  precachemodel("body_c_jup_civ_paramedic_01");
  precachemodel("c_jup_head_sc_m_dunn");
}

function precache_cpmp() {
  precache();
}