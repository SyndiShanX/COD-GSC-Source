/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5cd5849266f9a962.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_da1544c60e506296;

function private autoexec init() {
  character = #"hash_d3231e9ea4e52042";

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
  self setModel("body_c_jup_sp_civ_worker_04");
  self attach("head_c_jup_sc_m_alameer", "", 1);
  self.headmodel = "head_c_jup_sc_m_alameer";
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
  precachemodel("body_c_jup_sp_civ_worker_04");
  precachemodel("head_c_jup_sc_m_alameer");
}

function precache_cpmp() {
  precache();
}