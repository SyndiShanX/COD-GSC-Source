/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\scripted.gsc
***********************************************/

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a.suppressingenemy = 0;

  if(getdvarint("LPNQTQRRP") == 1) {
    scripts\asm\asm::asm_clearfacialanim();
    scripts\asm\asm_bb::bb_clearanimScripted();
    scripts\asm\asm_sp::asm_animScripted();
  }

  if(isDefined(self.asm.archetype) || isDefined(self.animationarchetype)) {
    if(isDefined(self.codescripted["pitch_min"])) {
      var_0 = scripts\asm\asm::asm_getheadlookknobifexists();

      if(isDefined(var_0)) {
        self.lookatatrnode = self.codescripted["lookat_atr_node"];
        self setanimlookatranges(self.codescripted["pitch_min"], self.codescripted["pitch_max"], self.codescripted["yaw_min"], self.codescripted["yaw_max"]);
        self setanim(var_0, 1.0, 0.2, 1.0, self.lookatatrnode);
      }
    }
  }

  self endon("end_sequence");

  if(isDefined(self.scriptedthread))
    self thread[[self.scriptedthread]]();

  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"], self.codescripted["goalTime"], self.codescripted["animRate"]);
  self.codescripted = undefined;

  if(isDefined(self.scripted_dialogue)) {
    scripts\anim\face.gsc::sayspecificdialogue(self.scripted_dialogue, "scripted_anim_facedone");
    self.scripted_dialogue = undefined;
  }

  if(isDefined(self.deathstring_passed))
    self.deathstring = self.deathstring_passed;

  self waittill("killanimscript");
}

init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self.codescripted["notifyName"] = var_0;
  self.codescripted["origin"] = var_1;
  self.codescripted["angles"] = var_2;
  self.codescripted["anim"] = var_3;

  if(isDefined(var_4))
    self.codescripted["animMode"] = var_4;
  else
    self.codescripted["animMode"] = "normal";

  self.codescripted["goalTime"] = var_6;
  self.codescripted["animRate"] = var_7;
  self.codescripted["root"] = var_5;
  self.codescripted["pitch_min"] = var_8;
  self.codescripted["pitch_max"] = var_9;
  self.codescripted["yaw_min"] = var_10;
  self.codescripted["yaw_max"] = var_11;
  self.codescripted["lookat_atr_node"] = var_12;

  switch (self.unittype) {
    case "dog":
      init_dog();
      break;
    default:
      if(self.asm.archetype == "c6")
        init_c6();
      else
        init_human();

      break;
  }
}

#using_animtree("generic_human");

init_human() {
  if(!isDefined(self.codescripted["root"]))
    self.codescripted["root"] = % body;
}

#using_animtree("dog");

init_dog() {
  if(!isDefined(self.codescripted["root"]))
    self.codescripted["root"] = % body;
}

#using_animtree("c6");

init_c6() {
  if(!isDefined(self.codescripted["root"]))
    self.codescripted["root"] = % body;
}