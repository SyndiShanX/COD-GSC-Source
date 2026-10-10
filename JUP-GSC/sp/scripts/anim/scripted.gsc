/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\scripted.gsc
***********************************************/

#using scripts\anim\face;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#namespace scripted;

function main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  asm_clearfacialanim();
  scripts\asm\asm_bb::bb_clearanimScripted();
  asm_animScripted();
  applyheadlook = 1;

  if(istrue(self.var_61eb9d2bd6f5f40a)) {
    applyheadlook = 0;
  }

  if(applyheadlook && (isDefined(self.animsetname) || isDefined(self.animationarchetype))) {
    if(isDefined(self.codescripted["pitch_min"])) {
      var_ae4bd9db62367d96 = asm_getheadlookknobifexists();

      if(isDefined(var_ae4bd9db62367d96)) {
        self.lookatatrnode = self.codescripted["lookat_atr_node"];
        self setanimlookatranges(self.codescripted["pitch_min"], self.codescripted["pitch_max"], self.codescripted["yaw_min"], self.codescripted["yaw_max"]);
        self setanim(var_ae4bd9db62367d96, 1, 0.2, 1, self.lookatatrnode);
      }
    }
  }

  self endon("end_sequence");
  parentent = self.codescripted["parent"];

  if(isDefined(parentent)) {
    assertex(parentent == self getlinkedparent(), "really, this linkto changed already? -_-");
    self.codescripted["origin"] = parentent.origin + rotatevector(self.codescripted["origin"], parentent.angles);
    self.codescripted["angles"] = combineangles(parentent.angles, self.codescripted["angles"]);
  }

  if(isDefined(self.scriptedthread)) {
    self thread[[self.scriptedthread]]();
  }

  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"], self.codescripted["goalTime"], self.codescripted["animRate"], undefined, undefined, undefined, undefined, undefined, self.codescripted["scripted_node_ent"]);
  self notify("scripted_anim", self.codescripted);
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

function init(notifyname, origin, angles, theanim, anim_mode, root, goaltime, animrate, pitch_min, pitch_max, yaw_min, yaw_max, lookat_atr_node, scripted_node_ent) {
  self.codescripted = undefined;
  self.codescripted["notifyName"] = notifyname;
  self.codescripted["origin"] = origin;
  self.codescripted["angles"] = angles;
  self.codescripted["anim"] = theanim;

  if(isDefined(anim_mode)) {
    self.codescripted["animMode"] = anim_mode;
  } else {
    self.codescripted["animMode"] = "normal";
  }

  self.codescripted["goalTime"] = goaltime;
  self.codescripted["animRate"] = animrate;
  self.codescripted["root"] = root;
  self.codescripted["pitch_min"] = pitch_min;
  self.codescripted["pitch_max"] = pitch_max;
  self.codescripted["yaw_min"] = yaw_min;
  self.codescripted["yaw_max"] = yaw_max;
  self.codescripted["lookat_atr_node"] = lookat_atr_node;
  self.codescripted["scripted_node_ent"] = scripted_node_ent;
  parentent = self getlinkedparent();

  if(isDefined(parentent)) {
    self.codescripted["parent"] = parentent;
    self.codescripted["origin"] = rotatevectorinverted(origin - parentent.origin, parentent.angles);
    self.codescripted["angles"] = combineangles(invertangles(parentent.angles), angles);
  }

  switch (self.unittype) {
    case #"hash_f4a90c6c03d32ee9":
      init_dog();
      break;
    default:
      init_human();
      break;
  }

  assertex(isDefined(self.codescripted["root"]), "this value should be inited in one of the subclass init functions if not otherwise set.");
}

#using_animtree("generic_human");

function init_human() {
  if(!isDefined(self.codescripted["root"])) {
    self.codescripted["root"] = % body;
  }
}

#using_animtree("dog");

function init_dog() {
  if(!isDefined(self.codescripted["root"])) {
    self.codescripted["root"] = % body;
  }
}