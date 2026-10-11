/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_703eff6ab1530ff6.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_2c05357be56d7dfc;

function private autoexec init() {
  character = #"hash_9157946c180c1330";

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
  self.animationarchetype = "zombie_mangler";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_mangler";
  self setModel("c_jup_zmb_mangler_hvt_emp");
  self setclothtype(#"vestheavy");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_mangler_hvt_emp");
}

function precache_cpmp() {
  precache();
}