/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_215fca4861459153.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_de59c502415156af;

function private autoexec init() {
  character = #"hash_9b9cebd8eb5eb803";

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
  self.animationarchetype = "zombie_entity";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_entity";
  self setModel("body_c_jup_zmb_npc_entity");
  self attach("head_c_jup_zmb_npc_entity", "", 1);
  self.headmodel = "head_c_jup_zmb_npc_entity";
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
  precachemodel("body_c_jup_zmb_npc_entity");
  precachemodel("head_c_jup_zmb_npc_entity");
}

function precache_cpmp() {
  precache();
}