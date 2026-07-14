/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\scripted.gsc
**************************************/

#using scripts\anim\face;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#namespace anim_scripted;

function main() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self notify("\v\xce\xe8\xa2m#D\xb7R\x15\x13\x03\xb8\xf8\x8a\xc1\xb4\xb3\x06>\x8b\f");
  asm::asm_clearfacialanim();
  asm_bb::bb_clearanimScripted();
  asm_sp::asm_animScripted();
  applyheadlook = 1;

  if(istrue(self.var_da6d647ac76a5873)) {
    applyheadlook = 0;
  }

  if(applyheadlook && (isDefined(self.animsetname) || isDefined(self.animationarchetype))) {
    if(isDefined(self.codescripted["\x80\x88\xf3_+7{li"])) {
      headlook_graft_node = asm::asm_getheadlookknobifexists();

      if(isDefined(headlook_graft_node)) {
        self.lookatatrnode = self.codescripted["\xe2n8:D61\xb9\x04\xf1\xe7\xae\xe0D\xbf"];
        self setanim(headlook_graft_node, 1, 0.2, 1, self.lookatatrnode);
      }
    }
  }

  self endon("\xf0V\x98`n\x9a\xd9\xf1\xe3\xff\xd8\xf2");
  parentent = self.codescripted["\xc1\xf88\xd2\xef\x94"];

  if(isDefined(parentent)) {
    assert(parentent == self getlinkedparent(), "<dev string:x24>");
    self.codescripted["\xb0$R\x8b\xc9\x17"] = parentent.origin + rotatevector(self.codescripted["\xb0$R\x8b\xc9\x17"], parentent.angles);
    self.codescripted["\xc5\x94\x82H\x9a`"] = combineangles(parentent.angles, self.codescripted["\xc5\x94\x82H\x9a`"]);
  }

  if(isDefined(self.scriptedthread)) {
    self thread[[self.scriptedthread]]();
  }

  self startscriptedanim(self.codescripted["t\xce\xbd\xb2\x1d\n\\}\x80\xb6"], self.codescripted["\xb0$R\x8b\xc9\x17"], self.codescripted["\xc5\x94\x82H\x9a`"], self.codescripted[",U\xdf."], self.codescripted["\xda\x1b\xcf#r\xc9-\t"], self.codescripted["\x11\x9ag\xc4"], self.codescripted["\xb7\x88\xb3%\xcd\xa7\xb1\xab"], self.codescripted["Y5\x88\x15\xfbOp\xbd"], undefined, undefined, undefined, undefined, undefined, self.codescripted["\xdb`\xeb\x03y\x8dO\xd48D<\x9c\x1c\xf9\xa5(D"]);
  self notify("~w\xab\x8c\xc7\t,\xe2\x92\xf3\x1b\x82\x04", self.codescripted);
  self.codescripted = undefined;

  if(isDefined(self.scripted_dialogue)) {
    face::sayspecificdialogue(self.scripted_dialogue, "W8Jiqj\xb70\x93\x96\x02xL\xc6uqV\xb7\"Ns\xae");
    self.scripted_dialogue = undefined;
  }

  if(isDefined(self.deathstring_passed)) {
    self.deathstring = self.deathstring_passed;
  }

  self waittill("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
}

function init(notifyname, origin, angles, theanim, anim_mode, root, goaltime, animrate, pitch_min, pitch_max, yaw_min, yaw_max, lookat_atr_node, scripted_node_ent) {
  self.codescripted = undefined;
  self.codescripted["t\xce\xbd\xb2\x1d\n\\}\x80\xb6"] = notifyname;
  self.codescripted["\xb0$R\x8b\xc9\x17"] = origin;
  self.codescripted["\xc5\x94\x82H\x9a`"] = angles;
  self.codescripted[",U\xdf."] = theanim;

  if(isDefined(anim_mode)) {
    self.codescripted["\xda\x1b\xcf#r\xc9-\t"] = anim_mode;
  } else {
    self.codescripted["\xda\x1b\xcf#r\xc9-\t"] = "+0a<s,";
  }

  self.codescripted["\xb7\x88\xb3%\xcd\xa7\xb1\xab"] = goaltime;
  self.codescripted["Y5\x88\x15\xfbOp\xbd"] = animrate;
  self.codescripted["\x11\x9ag\xc4"] = root;
  self.codescripted["\x80\x88\xf3_+7{li"] = pitch_min;
  self.codescripted["\xf1\xc4\xec\xf1\xfao\x14\x7ff"] = pitch_max;
  self.codescripted["\xc7v\xefV\xef\xe3p"] = yaw_min;
  self.codescripted["\xc0\" \xd9.~\x9d"] = yaw_max;
  self.codescripted["\xe2n8:D61\xb9\x04\xf1\xe7\xae\xe0D\xbf"] = lookat_atr_node;
  self.codescripted["\xdb`\xeb\x03y\x8dO\xd48D<\x9c\x1c\xf9\xa5(D"] = scripted_node_ent;
  parentent = self getlinkedparent();

  if(isDefined(parentent)) {
    self.codescripted["\xc1\xf88\xd2\xef\x94"] = parentent;
    self.codescripted["\xb0$R\x8b\xc9\x17"] = rotatevectorinverted(origin - parentent.origin, parentent.angles);
    self.codescripted["\xc5\x94\x82H\x9a`"] = combineangles(invertangles(parentent.angles), angles);
  }

  switch (self.unittype) {
    case #"hash_f4a90c6c03d32ee9":
      init_dog();
      break;
    default:
      init_human();
      break;
  }

  assert(isDefined(self.codescripted["<dev string:x50>"]), "<dev string:x58>");
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function init_human() {
  if(!isDefined(self.codescripted["\x11\x9ag\xc4"])) {
    self.codescripted["\x11\x9ag\xc4"] = % \xb7\x1bs\xf8;
  }
}

#using_animtree("\xde\x9d\xa5");

function init_dog() {
  if(!isDefined(self.codescripted["\x11\x9ag\xc4"])) {
    self.codescripted["\x11\x9ag\xc4"] = % \x8c\x96\x87$ @\x8dA\xeb;
  }
}