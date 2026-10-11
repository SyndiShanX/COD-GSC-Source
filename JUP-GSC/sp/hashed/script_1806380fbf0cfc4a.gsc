/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1806380fbf0cfc4a.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_90aa981b83618748;

function private autoexec init() {
  character = #"hash_d15b0ff264ab388c";

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
  self setModel("c_jup_body_civ_embassy_office_worker_female_1_2");
  self attach("head_c_jup_sc_f_stokes_civ", "", 1);
  self.headmodel = "head_c_jup_sc_f_stokes_civ";
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
  precachemodel("c_jup_body_civ_embassy_office_worker_female_1_2");
  precachemodel("head_c_jup_sc_f_stokes_civ");
}

function precache_cpmp() {
  precache();
}