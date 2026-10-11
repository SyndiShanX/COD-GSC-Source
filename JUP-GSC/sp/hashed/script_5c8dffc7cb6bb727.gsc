/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5c8dffc7cb6bb727.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_931798f6ad8673fb;

function private autoexec init() {
  character = #"hash_c27cd9f2c753073f";

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
  self setModel("body_c_jup_sp_civ_prisoner_03_b_riot");
  self attach("head_c_jup_sc_m_sharipov", "", 1);
  self.headmodel = "head_c_jup_sc_m_sharipov";
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
  precachemodel("body_c_jup_sp_civ_prisoner_03_b_riot");
  precachemodel("head_c_jup_sc_m_sharipov");
}

function precache_cpmp() {
  precache();
}