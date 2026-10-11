/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4f5166f6cdfcea92.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_3c415aa64c2c0c8e;

function private autoexec init() {
  character = #"hash_89a5bfeae6f4d402";

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
  self setModel("body_c_jup_sp_enemy_oligarch_patroller_02b");
  self attach("head_c_jup_sc_m_sharipov", "", 1);
  self.headmodel = "head_c_jup_sc_m_sharipov";
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
  precachemodel("body_c_jup_sp_enemy_oligarch_patroller_02b");
  precachemodel("head_c_jup_sc_m_sharipov");
}

function precache_cpmp() {
  precache();
}