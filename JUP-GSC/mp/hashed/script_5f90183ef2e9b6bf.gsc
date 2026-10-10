/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5f90183ef2e9b6bf.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_e8865f4b26697e67;

function private autoexec init() {
  character = #"hash_f936c98b8d7aef6b";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "zombie_deathworm";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_deathworm";
  self setModel("c_jup_zmb_worm_boss");
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_worm_boss");
}

function precache_cpmp() {
  precache();
}