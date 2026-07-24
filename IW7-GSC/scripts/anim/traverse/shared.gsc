/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\shared.gsc
********************************************/

#using_animtree("generic_human");

_id_18D1(var_0, var_1) {
  self._id_5270 = "crouch";
  scripts\anim\utility::_id_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_2 = self _meth_8148();
  self orientmode("face angle", var_2.angles[1]);
  var_2._id_126D4 = var_2.origin[2] + var_2._id_126D5;
  var_3 = var_2._id_126D4 - var_2.origin[2];
  thread _id_11661(var_3 - var_1);
  var_4 = 0.15;
  self clearanim(%body, var_4);
  self _meth_82E4("traverse", var_0, %root, 1, var_4, 1);
  var_5 = 0.2;
  var_6 = 0.2;
  thread scripts\anim\notetracks::donotetracksforever("traverse", "no clear");

  if(!animhasnotetrack(var_0, "gravity on")) {
    var_7 = 1.23;
    wait(var_7 - var_5);
    self _meth_83C4("gravity");
    wait(var_5);
  } else {
    self waittillmatch("traverse", "gravity on");
    self _meth_83C4("gravity");

    if(!animhasnotetrack(var_0, "blend")) {
      wait(var_5);
    } else {
      self waittillmatch("traverse", "blend");
    }
  }
}

_id_11661(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self _meth_80F1(self.origin + var_2);
    wait 0.05;
  }
}

_id_11662(var_0, var_1, var_2, var_3) {
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
    self _meth_82E3("traverseAnim", self._id_126DB, self._id_126DD, 1, 0.2, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self _meth_80F1(self.origin + var_4);
    wait 0.05;
  }

  if(isDefined(var_3) && var_3 < 1.0) {
    self _meth_82E3("traverseAnim", self._id_126DB, self._id_126DD, 1, 0.2, 1.0);
  }
}

_id_5AC3(var_0) {
  self endon("killanimscript");
  var_1 = getdvarint("ai_iw7", 0) != 0;
  self._id_5270 = "stand";
  scripts\anim\utility::_id_12E5F();
  var_2 = self _meth_8148();
  var_2._id_126D4 = var_2.origin[2];

  if(isDefined(var_2._id_126D5)) {
    var_2._id_126D4 = var_2._id_126D4 + var_2._id_126D5;
  }

  var_3 = self _meth_8145();
  self orientmode("face angle", var_2.angles[1]);
  self._id_126E6 = var_0["traverseHeight"];
  self._id_126EB = var_2;
  var_4 = var_0["traverseAnim"];
  var_5 = var_0["traverseToCoverAnim"];

  if(var_1) {
    self animmode("noclip");
  } else {
    self _meth_83C4("nogravity");
    self _meth_83C4("noclip");
  }

  self._id_126EC = self.origin[2];

  if(!animhasnotetrack(var_4, "traverse_align")) {
    _id_89F5();
  }

  var_6 = 0;

  if(isDefined(var_5) && isDefined(self.node) && self.node.type == var_0["coverType"] && distancesquared(self.node.origin, var_3.origin) < 625) {
    if(scripts\engine\utility::absangleclamp180(self.node.angles[1] - var_3.angles[1]) > 160) {
      var_6 = 1;
      var_4 = var_5;
    }
  }

  if(var_6) {
    if(isDefined(var_0["traverseToCoverSound"])) {
      thread scripts\sp\utility::play_sound_on_entity(var_0["traverseToCoverSound"]);
    }
  } else if(isDefined(var_0["traverseSound"]))
    thread scripts\sp\utility::play_sound_on_entity(var_0["traverseSound"]);

  var_7 = undefined;

  if(var_1) {
    var_7 = _id_0A1E::asm_getbodyknob();
  } else {
    var_7 = % body;
  }

  self._id_126DB = var_4;
  self._id_126DD = var_7;
  self _meth_82E4("traverseAnim", var_4, var_7, 1, 0.2, 1);
  self._id_126E3 = 0;
  self._id_126E2 = var_0["interruptDeathAnim"];
  scripts\anim\shared::donotetracks("traverseAnim", ::_id_89F8);

  if(var_1) {
    self animmode("gravity");
  } else {
    self _meth_83C4("gravity");
  }

  if(self.delayeddeath) {
    if(var_1) {
      self notify("external_traverse_complete");
    }

    return;
  }

  self.a.nodeath = 0;

  if(var_6 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self _meth_83B9(self.node.origin);
  } else if(isDefined(var_0["traverseStopsAtEnd"]))
    self.a.movement = "stop";
  else {
    self.a.movement = "run";
    self clearanim(var_4, 0.2);
  }

  self._id_126DD = undefined;
  self._id_126DB = undefined;
  self._id_4E2A = undefined;
  self._id_126EB = undefined;

  if(var_1) {
    self notify("external_traverse_complete");
  }
}

_id_89F8(var_0) {
  if(var_0 == "traverse_death") {
    return _id_89F6();
  } else if(var_0 == "traverse_align") {
    return _id_89F5();
  } else if(var_0 == "traverse_drop") {
    return _id_89F7();
  }
}

_id_89F6() {
  if(isDefined(self._id_126E2)) {
    var_0 = self._id_126E2[self._id_126E3];
    self._id_4E2A = var_0[randomint(var_0.size)];
    self._id_126E3++;
  }
}

_id_89F5() {
  if(getdvarint("ai_iw7", 0) != 0) {
    self animmode("noclip");
  } else {
    self _meth_83C4("nogravity");
    self _meth_83C4("noclip");
  }

  if(isDefined(self._id_126E6) && isDefined(self._id_126EB._id_126D4)) {
    var_0 = self._id_126EB._id_126D4 - self._id_126EC;
    thread _id_11661(var_0 - self._id_126E6);
  }
}

_id_89F7() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self islegacyagent(self._id_126DB);
  var_5 = getmovedelta(self._id_126DB, var_4, 1.0);
  var_6 = getanimlength(self._id_126DB);
  var_7 = 0 - var_5[2];
  var_8 = var_7 - var_3;

  if(var_7 < var_3) {
    var_9 = var_7 / var_3;
  } else {
    var_9 = 1;
  }

  var_10 = (var_6 - var_4) / 3.0;
  var_11 = ceil(var_10 * 20);
  thread _id_11662(var_8, 0, var_11, var_9);
  thread _id_6CE5(var_1[2]);
}

_id_6CE5(var_0) {
  self endon("killanimscript");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      if(getdvarint("ai_iw7", 0) != 0) {
        self animmode("gravity");
      } else {
        self _meth_83C4("gravity");
      }

      break;
    }

    wait 0.05;
  }
}

_id_593C() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

_id_5864(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;

  if(var_0 == "traverse_jump_start") {
    var_2 = 1;
    var_4 = getnotetracktimes(self._id_126DB, "traverse_align");

    if(var_4.size > 0) {
      var_1 = var_4;
    } else {
      var_1 = getnotetracktimes(self._id_126DB, "traverse_jump_end");
      var_3 = 1;
    }
  } else if(var_0 == "gravity on") {
    var_2 = 1;
    var_1 = getnotetracktimes(self._id_126DB, "traverse_jump_end");
    var_3 = 1;
  }

  if(var_2) {
    var_5 = getnotetracktimes(self._id_126DB, var_0);
    var_6 = var_5[0];
    var_7 = getmovedelta(self._id_126DB, 0, var_5[0]);
    var_8 = var_7[2];
    var_7 = getmovedelta(self._id_126DB, 0, var_1[0]);
    var_9 = var_7[2];
    var_10 = var_1[0];
    var_11 = getanimlength(self._id_126DB);
    var_12 = int((var_10 - var_6) * var_11 * 30);
    var_13 = max(1, var_12 - 2);
    var_14 = var_9 - var_8;

    if(var_3) {
      var_7 = getmovedelta(self._id_126DB, 0, 1);
      var_15 = var_7[2] - var_9;
      var_16 = self._id_126E4.origin[2] - self.origin[2] - var_15;
    } else {
      var_17 = self._id_126EB;
      var_16 = var_17._id_126D5 - (self.origin[2] - var_17.origin[2]);
    }

    thread _id_11662(var_16 - var_14, 0, var_13);
    return 1;
  }
}

_id_586C() {
  self waittill("killanimscript");
  self._id_126EB = undefined;
  self._id_126E4 = undefined;
}

#using_animtree("dog");

_id_586D(var_0, var_1, var_2) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread _id_586C();
  var_3 = self _meth_8148();
  self orientmode("face angle", var_3.angles[1]);

  if(!isDefined(var_2)) {
    var_4 = var_3._id_126D4 - var_3.origin[2];
    thread _id_11661(var_4 - var_1);
  }

  self._id_126DB = anim._id_58C7[var_0];
  self._id_126EB = var_3;
  self._id_126E4 = self _meth_8145();
  self clearanim(%body, 0.2);
  self _meth_82EA("dog_traverse", self._id_126DB, 1, 0.2, 1);
  self._id_BCA6 = "land";
  scripts\anim\notetracks::donotetracksintercept("dog_traverse", ::_id_5864);
  self._id_BCA6 = undefined;
  self._id_126DB = undefined;
}

_id_5867(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread _id_586C();
  var_4 = self _meth_8148();
  var_5 = self _meth_8145();
  self orientmode("face angle", var_4.angles[1]);

  if(!isDefined(var_2)) {
    var_2 = "jump_down_40";
  }

  self._id_126DB = anim._id_58C7[var_2];
  self._id_126DD = % body;
  self._id_126EB = var_4;
  self._id_126E4 = var_5;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    var_6 = var_4.origin[2] - var_5.origin[2];
    thread _id_11662(40.0 - var_6, 0.1, var_0, var_1);
  }

  self._id_BCA6 = "land";
  self clearanim(%body, 0.2);
  self _meth_82EA("traverseAnim", self._id_126DB, 1, 0.2, 1);

  if(!var_3) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::_id_5864);
  }

  self._id_BCA6 = undefined;
  self _meth_83C4("gravity");
  self._id_126DD = undefined;
  self._id_126DB = undefined;
}

_id_5868(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread _id_586C();
  var_4 = self _meth_8148();
  self orientmode("face angle", var_4.angles[1]);

  if(!isDefined(var_2)) {
    var_2 = "jump_up_40";
  }

  self._id_126DB = anim._id_58C7[var_2];
  self._id_126DD = % body;
  self._id_126EB = var_4;
  self._id_126E4 = self _meth_8145();

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    thread _id_11662(var_0 - 40.0, 0.2, var_1);
  }

  self._id_BCA6 = "land";
  self clearanim(%body, 0.2);
  self _meth_82EA("traverseAnim", self._id_126DB, 1, 0.2, 1);

  if(!var_3) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::_id_5864);
  }

  self._id_BCA6 = undefined;
  self _meth_83C4("gravity");
  self._id_126DB = undefined;
  self._id_126DD = undefined;
}

_id_5869(var_0, var_1) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread _id_586C();
  var_2 = self _meth_8148();
  self orientmode("face angle", var_2.angles[1]);

  if(!isDefined(var_2._id_126D4)) {
    var_2._id_126D4 = var_2.origin[2];
  }

  var_3 = var_2._id_126D4 - var_2.origin[2];
  thread _id_11661(var_3 - var_1);
  self._id_BCA6 = "land";
  self clearanim(%body, 0.2);
  self _meth_82E4("dog_traverse", anim._id_58C7[var_0], 1, 0.2, 1);
  scripts\anim\shared::donotetracks("dog_traverse");
  self._id_BCA6 = undefined;
}

_id_F163() {
  self waittill("killanimscript");
}

_id_F9C6() {
  foreach(var_1 in getnodearray("traverse", "targetname")) {
    var_1 thread _id_126ED();
  }
}

_id_D999(var_0) {
  self._id_5AE2 = var_0.origin;
  self._id_10DCE = self.angles;

  if(isent(var_0)) {
    var_0 delete();
  } else {
    scripts\sp\utility::_id_51D4(var_0);
  }
}

_id_D9BD(var_0) {
  var_1 = getEnt(var_0.target, "targetname");

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  }

  self._id_138A6 = spawnStruct();
  var_3 = var_0;
  var_4 = 0;
  self._id_138A6._id_10DCE = self.angles;
  var_6 = undefined;

  while(isDefined(var_3)) {
    self._id_138A6._id_C050[var_4] = var_3.origin - self.origin;
    var_4++;
    var_7 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    scripts\sp\utility::_id_51D4(var_3);
    var_3 = var_7;
    self._id_138A6._id_C050[var_4] = var_3.origin - self.origin;
    var_4++;

    if(isDefined(var_3.target)) {
      var_10 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    } else {
      var_10 = undefined;
    }

    scripts\sp\utility::_id_51D4(var_3);
    var_3 = var_10;

    if(isDefined(var_3) && isDefined(var_3._id_EF1D)) {
      if(var_3._id_EF1D == "wallrun_mantle") {
        self._id_138A6._id_B313 = var_3.origin - self.origin;

        if(isDefined(var_3.angles)) {
          self._id_138A6._id_B312 = var_3.angles;
        }

        scripts\sp\utility::_id_51D4(var_3);
        break;
      } else if(var_3._id_EF1D == "wallrun_vault") {
        self._id_138A6._id_B313 = var_3.origin - self.origin;
        self._id_138A6._id_331A = 1;
        scripts\sp\utility::_id_51D4(var_3);
        break;
      }
    }
  }
}

_id_126ED() {
  var_0 = getEnt(self.target, "targetname");

  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  }

  switch (self.animscript) {
    case "wall_run":
      _id_D9BD(var_0);
      return;
    case "double_jump_mantle":
    case "double_jump_vault":
      _id_D999(var_0);
      return;
    case "double_jump":
      self._id_10DCE = self.angles;

      if(!isDefined(var_0)) {
        return;
      }
      self._id_A4C9 = var_0.origin - self.origin;
      self._id_A4C8 = var_0.origin;
      break;
    case "rail_hop_double_jump_down":
      self._id_10DCE = self.angles;
      break;
    default:
      break;
  }

  self._id_126D4 = var_0.origin[2];
  self._id_126D5 = var_0.origin[2] - self.origin[2];

  if(isent(var_0)) {
    var_0 delete();
  } else {
    scripts\sp\utility::_id_51D4(var_0);
  }
}