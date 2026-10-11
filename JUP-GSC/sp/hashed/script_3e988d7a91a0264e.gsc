/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3e988d7a91a0264e.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_64e5941b6334debc;

function private autoexec init() {
  character = #"hash_b72f0bf255cad200";

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
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("c_jup_body_civ_embassy_office_worker_female_2_1");
  self attach("head_c_jup_sc_f_page_civ", "", 1);
  self.headmodel = "head_c_jup_sc_f_page_civ";
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
  precachemodel("c_jup_body_civ_embassy_office_worker_female_2_1");
  precachemodel("head_c_jup_sc_f_page_civ");
}

function precache_cpmp() {
  precache();
}