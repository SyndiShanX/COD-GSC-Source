/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\scripted.gsc
*************************************/

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a.var_112CB = 0;
  if(getdvarint("ai_iw7") == 1) {
    lib_0A1E::func_2318();
    scripts\asm\asm_bb::bb_clearanimscripted();
    lib_0A1E::func_230A();
  }

  self endon("end_sequence");
  self giverankxpafterwait(self.var_433C["notifyName"], self.var_433C["origin"], self.var_433C["angles"], self.var_433C["anim"], self.var_433C["animMode"], self.var_433C["root"], self.var_433C["goalTime"], self.var_433C["animRate"]);
  self.var_433C = undefined;
  if(isDefined(self.var_EF4D)) {
    scripts\anim\face::sayspecificdialogue(self.var_EF4D, "scripted_anim_facedone");
    self.var_EF4D = undefined;
  }

  if(isDefined(self.var_4E70)) {
    self.var_4E6F = self.var_4E70;
  }

  self waittill("killanimscript");
}

init(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self.var_433C["notifyName"] = param_00;
  self.var_433C["origin"] = param_01;
  self.var_433C["angles"] = param_02;
  self.var_433C["anim"] = param_03;
  if(isDefined(param_04)) {
    self.var_433C["animMode"] = param_04;
  } else {
    self.var_433C["animMode"] = "normal";
  }

  self.var_433C["goalTime"] = param_06;
  self.var_433C["animRate"] = param_07;
  self.var_433C["root"] = param_05;
  switch (self.subclass) {
    case "C6":
      func_9563();
      break;

    case "C8":
      func_9567();
      break;

    case "C12":
      func_9568();
      break;

    default:
      func_962B();
      break;
  }
}

func_962B() {
  if(!isDefined(self.var_433C["root"])) {
    self.var_433C["root"] = % body;
  }
}

func_9563() {
  if(!isDefined(self.var_433C["root"])) {
    self.var_433C["root"] = % body;
  }
}

func_9567() {
  if(!isDefined(self.var_433C["root"])) {
    self.var_433C["root"] = % body;
  }
}

func_9568() {
  if(!isDefined(self.var_433C["root"])) {
    self.var_433C["root"] = % body;
  }
}