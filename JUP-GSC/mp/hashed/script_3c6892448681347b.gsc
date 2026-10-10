/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3c6892448681347b.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace dodge;

function function_a16975ad999570bf(asmname, statename, params) {
  self endon(statename + "_finished");
  assert(isDefined(self.var_d920859fcc741412) && self.var_d920859fcc741412 >= 0);
  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

  if(endnote == "code_move") {
    endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  }
}