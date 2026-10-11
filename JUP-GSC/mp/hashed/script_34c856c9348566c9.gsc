/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_34c856c9348566c9.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_b721abb5c8329c49;

function private autoexec init() {
  character = #"hash_c3b36270e20407c5";

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
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self setModel("body_c_jup_mp_echo_22_mutant");
  self attach("head_c_jup_mp_echo_22_mutant", "", 1);
  self.headmodel = "head_c_jup_mp_echo_22_mutant";
  self setclothtype(#"vestheavy");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_mp_echo_22_mutant");
  precachemodel("head_c_jup_mp_echo_22_mutant");
}

function precache_cpmp() {
  precache();
}