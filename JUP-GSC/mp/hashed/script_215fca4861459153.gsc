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
  self.animationarchetype = "zombie_entity";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_entity";
  self setModel("body_c_jup_zmb_npc_entity");
  self attach("head_c_jup_zmb_npc_entity", "", 1);
  self.headmodel = "head_c_jup_zmb_npc_entity";
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

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