/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4b5426386821012b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_d882bcb2a2c94cf9;

function private autoexec init() {
  character = #"hash_af729ce3b6306035";

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
  self setModel("body_c_jup_civ_plane_attendant_01_jump");
  self attach("head_sc_m_konstantin_lod0", "", 1);
  self.headmodel = "head_sc_m_konstantin_lod0";
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
  precachemodel("body_c_jup_civ_plane_attendant_01_jump");
  precachemodel("head_sc_m_konstantin_lod0");
}

function precache_cpmp() {
  precache();
}