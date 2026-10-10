/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_619b2bdd818c427d.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_de41a4e7c0568035;

function private autoexec init() {
  character = #"hash_6ab583060b8d75a9";

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
  self.animationarchetype = "zombie_disciple_pet";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_disciple";
  self setModel("c_jup_zmb_disciple_body");
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
  precachemodel("c_jup_zmb_disciple_body");
}

function precache_cpmp() {
  precache();
}