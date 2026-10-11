/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1de2f51a016b4302.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_b2c3d40575f5ea8;

function private autoexec init() {
  character = #"hash_860b83e9cdee776c";

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
  self.animationarchetype = "riotshield";
  self.voice = #"unitednations";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_ally_sas_urban");
  self attach("c_jup_head_sc_m_alexander", "", 1);
  self.headmodel = "c_jup_head_sc_m_alexander";
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
  precachemodel("body_c_jup_sp_ally_sas_urban");
  precachemodel("c_jup_head_sc_m_alexander");
}

function precache_cpmp() {
  precache();
}