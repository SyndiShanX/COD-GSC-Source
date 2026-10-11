/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_53fe46890cfd66c2.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_7e5c89f3245ac5c;

function private autoexec init() {
  character = #"hash_ebaf0521e4daa310";

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
  self attach("head_c_jup_sc_m_utnehmer", "", 1);
  self.headmodel = "head_c_jup_sc_m_utnehmer";
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
  precachemodel("head_c_jup_sc_m_utnehmer");
}

function precache_cpmp() {
  precache();
}