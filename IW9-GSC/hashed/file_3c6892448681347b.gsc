/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3c6892448681347b.gsc
***********************************************/

_id_A16975AD999570BF(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1));
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

  if(endnote == "code_move")
    endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}