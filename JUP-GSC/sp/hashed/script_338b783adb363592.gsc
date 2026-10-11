/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_338b783adb363592.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_65facc7d9b877fce;

function private autoexec init() {
  character = #"hash_eec7e281261ac6ba";

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
  self setModel("c_jup_body_civ_western_boy_1_1");
  self attach("head_sc_m_kamalov_child", "", 1);
  self.headmodel = "head_sc_m_kamalov_child";
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
  precachemodel("c_jup_body_civ_western_boy_1_1");
  precachemodel("head_sc_m_kamalov_child");
}

function precache_cpmp() {
  precache();
}