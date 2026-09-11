/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\scripted.gsc
***********************************************/

function main() {
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
      var0 = scripts\asm\asm::asm_getheadlookknobifexists();

      if(isDefined(var0)) {
        self.lookatatrnode = self.codescripted["lookat_atr_node"];
        self setanimlookatranges(self.codescripted["pitch_min"], self.codescripted["pitch_max"], self.codescripted["yaw_min"], self.codescripted["yaw_max"]);
        self setanim(var0, 1, 0.2, 1, self.lookatatrnode);
      }
    }
  }

  self endon("end_sequence");

  if(isDefined(self.scriptedthread)) {
    self thread[[self.scriptedthread]]();
  }

  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"], self.codescripted["goalTime"], self.codescripted["animRate"]);
  self.codescripted = undefined;

  if(isDefined(self.scripted_dialogue)) {
    scripts\anim\face::sayspecificdialogue(self.scripted_dialogue, "scripted_anim_facedone");
    self.scripted_dialogue = undefined;
  }

  if(isDefined(self.deathstring_passed)) {
    self.deathstring = self.deathstring_passed;
  }

  self waittill("killanimscript");
}

function init(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  self.codescripted["notifyName"] = var0;
  self.codescripted["origin"] = var1;
  self.codescripted["angles"] = var2;
  self.codescripted["anim"] = var3;

  if(isDefined(var4)) {
    self.codescripted["animMode"] = var4;
  } else {
    self.codescripted["animMode"] = "normal";
  }

  self.codescripted["goalTime"] = var6;
  self.codescripted["animRate"] = var7;
  self.codescripted["root"] = var5;
  self.codescripted["pitch_min"] = var8;
  self.codescripted["pitch_max"] = var9;
  self.codescripted["yaw_min"] = var10;
  self.codescripted["yaw_max"] = var11;
  self.codescripted["lookat_atr_node"] = var12;

  switch (self.unittype) {
    case "dog":
      init_dog();
      break;
    default:
      if(self.asm.archetype == "c6") {
        init_c6();
      } else {
        init_human();
      }

      break;
  }
}

#using_animtree("generic_human");

function init_human() {
  if(!isDefined(self.codescripted["root"])) {
    self.codescripted["root"] = % body;
    return;
  }
}

#using_animtree("dog");

function init_dog() {
  if(!isDefined(self.codescripted["root"])) {
    self.codescripted["root"] = % body;
    return;
  }
}

#using_animtree("c6");

function init_c6() {
  if(!isDefined(self.codescripted["root"])) {
    self.codescripted["root"] = % body;
    return;
  }
}