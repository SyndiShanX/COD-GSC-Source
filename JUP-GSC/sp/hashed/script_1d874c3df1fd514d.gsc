/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1d874c3df1fd514d.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_8168a0fd0cdca6ef;

function private autoexec init() {
  character = #"hash_3ae383f6f3b2ea83";

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
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_civ_london_male_10_1");
  self attach("head_c_jup_sc_m_haghighi_civ", "", 1);
  self.headmodel = "head_c_jup_sc_m_haghighi_civ";
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
  precachemodel("body_c_jup_civ_london_male_10_1");
  precachemodel("head_c_jup_sc_m_haghighi_civ");
}

function precache_cpmp() {
  precache();
}