/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_17c1a9a711e9953.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_30c1d6d3862b38b1;

function private autoexec init() {
  character = #"hash_938bd83cc9ead2e5";

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
  self setModel("c_jup_body_civ_embassy_office_worker_male_1_2");
  self attach("head_c_jup_sc_m_perez_civ", "", 1);
  self.headmodel = "head_c_jup_sc_m_perez_civ";
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
  precachemodel("c_jup_body_civ_embassy_office_worker_male_1_2");
  precachemodel("head_c_jup_sc_m_perez_civ");
}

function precache_cpmp() {
  precache();
}