/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_39ed2c8264bccc26.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_66f33a5713fab768;

function private autoexec init() {
  character = #"hash_e21bcbb205575704";

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
  self setModel("body_c_jup_sp_enemy_oligarch_shotgunner_03a");
  self attach("head_c_jup_sc_m_allen_shotgunner_03a", "", 1);
  self.headmodel = "head_c_jup_sc_m_allen_shotgunner_03a";
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
  precachemodel("body_c_jup_sp_enemy_oligarch_shotgunner_03a");
  precachemodel("head_c_jup_sc_m_allen_shotgunner_03a");
}

function precache_cpmp() {
  precache();
}