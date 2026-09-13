/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4d81226a00832150.gsc
***********************************************/

_id_45DC5E082D9A020F(asmname, statename, params) {
  _id_371B4C2AB5861E62::_id_B535FE740F1CF507();
}

_id_D74C84CE78CDD2B4(_id_A234A65C378F3289) {
  _id_CBA415031462E005 = 1;
  _id_A9F996CAF54DD68C = getsubstr(_id_A234A65C378F3289, 7);

  if(isDefined(_id_A9F996CAF54DD68C) && _id_A9F996CAF54DD68C == "left")
    _id_CBA415031462E005 = 0;

  return _id_CBA415031462E005;
}

_id_45DC0311BB854741(_id_A234A65C378F3289, statename) {
  self endon("death");
  self endon(statename + "_finished");
  _id_8A46C62F0A756DD3 = "armor_plate";

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    if(_id_D74C84CE78CDD2B4(_id_A234A65C378F3289))
      self setscriptablepartstate(_id_8A46C62F0A756DD3, "active_right");
    else
      self setscriptablepartstate(_id_8A46C62F0A756DD3, "active_left");
  } else if(isstartstr(_id_A234A65C378F3289, "detach"))
    self setscriptablepartstate(_id_8A46C62F0A756DD3, "default");
}

_id_E05A85A79478670C(_id_A234A65C378F3289, params) {
  _id_8A46C62F0A756DD3 = "armor_plate";

  if(self isscriptable() && self getscriptablehaspart(_id_8A46C62F0A756DD3)) {
    statename = self asmgetcurrentstate(self.asmname);
    _id_45DC0311BB854741(_id_A234A65C378F3289, statename);
  }
}