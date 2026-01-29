/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\shared.gsc
*******************************************/

#using_animtree("generic_human");

_id_3FE6(var_0, var_1) {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2._id_1EFA - var_2.origin[2];
  thread _id_3FE7(var_3 - var_1);
  var_4 = 0.15;
  self clearanim( % body, var_4);
  self setflaggedanimknoballrestart("traverse", var_0, % root, 1, var_4, 1);
  var_5 = 0.2;
  var_6 = 0.2;
  thread animscripts\notetracks::_id_239E("traverse", "no clear");

  if(!animhasnotetrack(var_0, "gravity on")) {
    var_7 = 1.23;
    wait(var_7 - var_5);
    self traversemode("gravity");
    wait(var_5);
  } else {
    self waittillmatch("traverse", "gravity on");
    self traversemode("gravity");

    if(!animhasnotetrack(var_0, "blend")) {
      wait(var_5);
    } else {
      self waittillmatch("traverse", "blend");
    }
  }
}

_id_3FE7(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self forceteleport(self.origin + var_2);
    wait 0.05;
  }
}

_id_3FE8(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0) {
    wait(var_1);

  }
  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0) {
    self setflaggedanimknoball("traverseAnim", self._id_3FEA, self._id_3FE9, 1, 0.2, var_3);

  }
  for(var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    wait 0.05;
  }

  if(isDefined(var_3) && var_3 < 1.0) {
    self setflaggedanimknoball("traverseAnim", self._id_3FEA, self._id_3FE9, 1, 0.2, 1.0);
  }
}

_id_3FEB(var_0) {
  self endon("killanimscript");
  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  var_1 = self getnegotiationstartnode();
  var_2 = self getnegotiationendnode();
  self orientmode("face angle", var_1.angles[1]);
  self._id_3FEC = var_0["traverseHeight"];
  self._id_3FED = var_1;
  var_3 = var_0["traverseAnim"];
  var_4 = var_0["traverseToCoverAnim"];
  self traversemode("nogravity");
  self traversemode("noclip");
  self._id_3FEE = self.origin[2];

  if(!animhasnotetrack(var_3, "traverse_align")) {
    _id_3FF3();

  }
  var_5 = 0;

  if(isDefined(var_4) && isDefined(self.node) && self.node.type == var_0["coverType"] && distancesquared(self.node.origin, var_2.origin) < 625) {
    if(animscripts\utility::_id_0D61(self.node.angles[1] - var_2.angles[1]) > 160) {
      var_5 = 1;
      var_3 = var_4;
    }
  }

  if(var_5) {
    if(isDefined(var_0["traverseToCoverSound"])) {
      thread maps\_utility::play_sound_on_entity(var_0["traverseToCoverSound"]);
    }
  } else if(isDefined(var_0["traverseSound"])) {
    thread maps\_utility::play_sound_on_entity(var_0["traverseSound"]);

  }
  self._id_3FEA = var_3;
  self._id_3FE9 = % body;
  self setflaggedanimknoballrestart("traverseAnim", var_3, % body, 1, 0.2, 1);
  self._id_3FEF = 0;
  self._id_3FF0 = var_0["interruptDeathAnim"];
  animscripts\shared::_id_0C51("traverseAnim", ::_id_3FF1);
  self traversemode("gravity");

  if(self.delayeddeath) {
    return;
  }
  self.a._id_0D55 = 0;

  if(var_5 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a._id_0D2B = "stop";
    self teleport(self.node.origin);
  } else if(isDefined(var_0["traverseStopsAtEnd"])) {
    self.a._id_0D2B = "stop";
  } else {
    self.a._id_0D2B = "run";
    self clearanim(var_3, 0.2);
  }

  self._id_3FE9 = undefined;
  self._id_3FEA = undefined;
  self._id_0D50 = undefined;
}

_id_3FF1(var_0) {
  if(var_0 == "traverse_death") {
    return _id_3FF2();
  } else if(var_0 == "traverse_align") {
    return _id_3FF3();
  } else if(var_0 == "traverse_drop") {
    return _id_3FF4();
  }
}

_id_3FF2() {
  if(isDefined(self._id_3FF0)) {
    var_0 = self._id_3FF0[self._id_3FEF];
    self._id_0D50 = var_0[randomint(var_0.size)];
    self._id_3FEF++;
  }
}

_id_3FF3() {
  self traversemode("nogravity");
  self traversemode("noclip");

  if(isDefined(self._id_3FEC) && isDefined(self._id_3FED._id_1EFA)) {
    var_0 = self._id_3FED._id_1EFA - self._id_3FEE;
    thread _id_3FE7(var_0 - self._id_3FEC);
  }
}

_id_3FF4() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = bulletTrace(var_0, self.origin + (0, 0, -512), 0, undefined);
  var_2 = var_1["position"];
  var_3 = distance(var_0, var_2);
  var_4 = var_3 - 32 - 0.5;
  var_5 = self getanimtime(self._id_3FEA);
  var_6 = getmovedelta(self._id_3FEA, var_5, 1.0);
  var_7 = getanimlength(self._id_3FEA);
  var_8 = 0 - var_6[2];
  var_9 = var_8 - var_4;

  if(var_8 < var_4) {
    var_10 = var_8 / var_4;
  } else {
    var_10 = 1;

  }
  var_11 = (var_7 - var_5) / 3.0;
  var_12 = ceil(var_11 * 20);
  thread _id_3FE8(var_9, 0, var_12, var_10);
  thread _id_3FF5(var_2[2]);
}

_id_3FF5(var_0) {
  self endon("killanimscript");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self traversemode("gravity");
      break;
    }

    wait 0.05;
  }
}

_id_3FF6() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

#using_animtree("dog");

_id_3FF7(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2._id_1EFA - var_2.origin[2];
  thread _id_3FE7(var_3 - var_1);
  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_traverse", anim._id_3AF6[var_0], 1, 0.2, 1);
  animscripts\shared::_id_0C51("dog_traverse");
  self._id_3B58 = 1;
}

_id_3FF8(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = self getnegotiationstartnode().origin[2] - self getnegotiationendnode().origin[2];
  self._id_3FEA = anim._id_3AF6["jump_down_40"];
  self._id_3FE9 = % root;
  thread _id_3FE8(40.0 - var_3, 0.1, var_0, var_1);
  self clearanim( % root, 0.2);
  self setflaggedanimrestart("traverseAnim", self._id_3FEA, 1, 0.2, 1);
  animscripts\shared::_id_0C51("traverseAnim");
  self clearanim(self._id_3FEA, 0);
  self traversemode("gravity");
  self._id_3B58 = 1;
  self._id_3FE9 = undefined;
  self._id_3FEA = undefined;
}

_id_3FF9(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  thread _id_3FE8(var_0 - 40.0, 0.2, var_1);
  self clearanim( % root, 0.25);
  self setflaggedanimrestart("traverseAnim", anim._id_3AF6["jump_up_40"], 1, 0.2, 1);
  animscripts\shared::_id_0C51("traverseAnim");
  self clearanim(anim._id_3AF6["jump_up_40"], 0);
  self traversemode("gravity");
  self._id_3B58 = 1;
}

_id_0176(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);

  if(!isDefined(var_2._id_1EFA)) {
    var_2._id_1EFA = var_2.origin[2];

  }
  var_3 = var_2._id_1EFA - var_2.origin[2];
  thread _id_3FE7(var_3 - var_1);
  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_traverse", anim._id_3AF6[var_0], 1, 0.2, 1);
  animscripts\shared::_id_0C51("dog_traverse");
  self._id_3B58 = 1;
}