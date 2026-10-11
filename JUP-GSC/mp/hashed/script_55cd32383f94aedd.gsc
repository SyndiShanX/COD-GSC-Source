/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_55cd32383f94aedd.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_5d5e26f1181f6e77;

function private autoexec init() {
  character = #"hash_54ebc2aa2d93488b";

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
  self.animationarchetype = "zombie_hellhound";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_hellhound";
  self setModel("c_jup_zmb_zod_hellhound");
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
  precachemodel("c_jup_zmb_zod_hellhound");
}

function precache_cpmp() {
  precache();
}