/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\scripted.gsc
**************************************/

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a._id_112CB = 0;

  if(getdvarint("ai_iw7") == 1) {
    _id_0A1E::_id_2318();
    scripts\asm\asm_bb::bb_clearanimScripted();
    _id_0A1E::_id_230A();
  }

  self endon("end_sequence");
  self _meth_839C(self._id_433C["notifyName"], self._id_433C["origin"], self._id_433C["angles"], self._id_433C["anim"], self._id_433C["animMode"], self._id_433C["root"], self._id_433C["goalTime"], self._id_433C["animRate"]);
  self._id_433C = undefined;

  if(isDefined(self._id_EF4D)) {
    scripts\anim\face::sayspecificdialogue(self._id_EF4D, "scripted_anim_facedone");
    self._id_EF4D = undefined;
  }

  if(isDefined(self._id_4E70)) {
    self._id_4E6F = self._id_4E70;
  }

  self waittill("killanimscript");
}

init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self._id_433C["notifyName"] = var_0;
  self._id_433C["origin"] = var_1;
  self._id_433C["angles"] = var_2;
  self._id_433C["anim"] = var_3;

  if(isDefined(var_4)) {
    self._id_433C["animMode"] = var_4;
  } else {
    self._id_433C["animMode"] = "normal";
  }

  self._id_433C["goalTime"] = var_6;
  self._id_433C["animRate"] = var_7;
  self._id_433C["root"] = var_5;

  switch (self.subclass) {
    case "C6":
      _id_9563();
      break;
    case "C8":
      _id_9567();
      break;
    case "C12":
      _id_9568();
      break;
    default:
      _id_962B();
  }
}

#using_animtree("generic_human");

_id_962B() {
  if(!isDefined(self._id_433C["root"])) {
    self._id_433C["root"] = % body;
  }
}

#using_animtree("c6");

_id_9563() {
  if(!isDefined(self._id_433C["root"])) {
    self._id_433C["root"] = % body;
  }
}

#using_animtree("c8");

_id_9567() {
  if(!isDefined(self._id_433C["root"])) {
    self._id_433C["root"] = % body;
  }
}

#using_animtree("c12");

_id_9568() {
  if(!isDefined(self._id_433C["root"])) {
    self._id_433C["root"] = % body;
  }
}