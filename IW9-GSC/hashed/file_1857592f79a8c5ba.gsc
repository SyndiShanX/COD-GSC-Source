/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1857592f79a8c5ba.gsc
***********************************************/

_id_6C3D4156DEC73E1D(asmname, statename, params) {
  stance = scripts\asm\asm_bb::bb_getrequestedstance();
  coverstate = scripts\asm\asm_bb::bb_getrequestedcoverstate();
  animname = "default";

  if(coverstate == "exposed")
    animname = "exposed_" + stance;
  else {
    covernode = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(covernode)) {
      _id_15604D8704252FC4 = covernode.type;

      switch (_id_15604D8704252FC4) {
        case "Cover Right":
          animname = "cover_right_" + stance;
          break;
        case "Cover Left":
          animname = "cover_left_" + stance;
          break;
        case "Cover Crouch":
          animname = "cover_crouch";
          break;
        case "Cover Stand":
          animname = "cover_stand";
          break;
      }
    }
  }

  _id_18E57011E29F452D = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, animname);
  return _id_18E57011E29F452D;
}