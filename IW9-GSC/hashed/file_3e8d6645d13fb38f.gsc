/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3e8d6645d13fb38f.gsc
***********************************************/

_id_B4DB142A841B2949(asmname, statename, params) {
  return isDefined(self.scene) && _id_4E1D4DD23699A8A4::_id_F179EDE0989E6734("scene", self.scene);
}

_id_7E3E49D37A35DAD6(asmname, statename, params) {
  return isDefined(self.scene) && _id_4E1D4DD23699A8A4::_id_F179EDE0989E6734("walk", self.scene);
}

_id_9F0C0C75B96EF721(asmname, statename, params) {
  return isDefined(self.scene) && self.scene == "idle";
}

_id_B2054F6D2F28CB44(asmname, statename, params) {
  chosen = _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, self.scene);
  self.scene = undefined;
  return chosen;
}

_id_7D262E91972FE8FB(asmname, statename, params) {
  return isDefined(self.scene) && self.scene == "exit";
}

_id_F9A2881485007A9F(asmname, statename, params) {
  self notify("scene_end");
}