/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_38c7426a6d5f6fd4.gsc
***********************************************/

_id_A78DEBAC92A88923() {
  return getdvarint("dvar_484421B3752A1B9D", 0);
}

_id_805F1F0B22CA5026(_id_0BF7CEBBB38BDF01) {
  _id_5A904F463705AE66 = undefined;
  _id_F118DA0AF461C7E1 = undefined;

  switch (_id_0BF7CEBBB38BDF01) {
    case 1:
      _id_5A904F463705AE66 = _id_1B3369A1ECDEC98F::_id_B24A36667938B8D4;
      _id_F118DA0AF461C7E1 = _id_1B3369A1ECDEC98F::_id_B831CCF10A32A4B1;
      break;
    case 2:
      _id_5A904F463705AE66 = _id_47EEACCD43121E82::_id_B24A36667938B8D4;
      _id_F118DA0AF461C7E1 = _id_47EEACCD43121E82::_id_B831CCF10A32A4B1;
      break;
  }

  _id_921FED896A534721(_id_5A904F463705AE66, _id_F118DA0AF461C7E1);
}

_id_921FED896A534721(_id_5A904F463705AE66, _id_F118DA0AF461C7E1) {
  if(!isDefined(_id_5A904F463705AE66) || !isDefined(_id_F118DA0AF461C7E1)) {
    logprint("Orientation override launch function is not defined!");
    return;
  }

  if([[_id_F118DA0AF461C7E1]]() != 1) {
    logprint("Orientation match variant file is not at head of base!");
    return;
  }

  [[_id_5A904F463705AE66]]();
}