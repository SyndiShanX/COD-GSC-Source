/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54275a8be95c832.gsc
************************************************/

#using scripts\common\utility;
#namespace character_jup_zombie_mimic_hvt;

function private autoexec init() {
  character = #"hash_e32f771e349a4ee0";

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
  self.animationarchetype = "zombie_mimic_hvt";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_mimic";
  self setModel("c_jup_zmb_mimic_hvt");
  self attach("c_jup_zmb_mimic_head_hvt", "", 1);
  self.headmodel = "c_jup_zmb_mimic_head_hvt";
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
  precachemodel("c_jup_zmb_mimic_hvt");
  precachemodel("c_jup_zmb_mimic_head_hvt");
}

function precache_cpmp() {
  precache();
}