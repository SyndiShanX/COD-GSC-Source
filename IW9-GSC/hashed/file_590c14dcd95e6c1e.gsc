/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_590c14dcd95e6c1e.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["cap_bark_orders"])) {
    return;
  }
  anim.asmfuncs["cap_bark_orders"] = [];
  anim.asmfuncs["cap_bark_orders"][0] = scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["cap_bark_orders"][1] = _id_4E1D4DD23699A8A4::_id_59308D53CABCDFDB;
  anim.asmfuncs["cap_bark_orders"][2] = _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64;
  anim.asmfuncs["cap_bark_orders"][3] = _id_4E1D4DD23699A8A4::_id_B6AF4ADE50626E90;
  anim.asmfuncs["cap_bark_orders"][4] = scripts\asm\soldier\pain::playpainanim_exposedstand;
}