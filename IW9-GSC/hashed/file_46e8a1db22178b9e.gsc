/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_46e8a1db22178b9e.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["cap_solo_interaction"])) {
    return;
  }
  anim.asmfuncs["cap_solo_interaction"] = [];
  anim.asmfuncs["cap_solo_interaction"][0] = _id_2A23525B482401E3::_id_3C2BC94B2ABF6FAD;
  anim.asmfuncs["cap_solo_interaction"][1] = _id_4E1D4DD23699A8A4::_id_2BD39480AE487049;
  anim.asmfuncs["cap_solo_interaction"][2] = _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64;
  anim.asmfuncs["cap_solo_interaction"][3] = _id_4E1D4DD23699A8A4::_id_B6AF4ADE50626E90;
  anim.asmfuncs["cap_solo_interaction"][4] = _id_4E1D4DD23699A8A4::_id_DA3D5E34EB93790A;
  anim.asmfuncs["cap_solo_interaction"][5] = scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["cap_solo_interaction"][6] = _id_4E1D4DD23699A8A4::_id_59308D53CABCDFDB;
  anim.asmfuncs["cap_solo_interaction"][7] = scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["cap_solo_interaction"][8] = scripts\asm\soldier\patrol_idle::patrol_playidlereact;
  anim.asmfuncs["cap_solo_interaction"][9] = scripts\asm\soldier\patrol_idle::patrol_chooseidlereact;
}