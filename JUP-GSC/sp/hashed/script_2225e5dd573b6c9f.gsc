/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2225e5dd573b6c9f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_3c4159a64c2c0a5b;

function private autoexec init() {
  character = #"hash_89a5beeae6f4d24f";

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
  self setModel("body_c_jup_sp_enemy_oligarch_patroller_02a");
  self attach("head_c_jup_sc_m_kindschi", "", 1);
  self.headmodel = "head_c_jup_sc_m_kindschi";
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
  precachemodel("body_c_jup_sp_enemy_oligarch_patroller_02a");
  precachemodel("head_c_jup_sc_m_kindschi");
}

function precache_cpmp() {
  precache();
}