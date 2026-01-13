/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\shared.gsc
*********************************************/

func_18D1(var_0, var_1) {
  self.var_5270 = "crouch";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_2 = self getspectatepoint();
  self orientmode("face angle", var_2.angles[1]);
  var_2.var_126D4 = var_2.origin[2] + var_2.var_126D5;
  var_3 = var_2.var_126D4 - var_2.origin[2];
  thread func_11661(var_3 - var_1);
  var_4 = 0.15;
  self clearanim( % body, var_4);
  self _meth_82E4("traverse", var_0, % root, 1, var_4, 1);
  var_5 = 0.2;
  var_6 = 0.2;
  thread scripts\anim\notetracks::donotetracksforever("traverse", "no clear");
  if(!animhasnotetrack(var_0, "gravity on")) {
    var_7 = 1.23;
    wait(var_7 - var_5);
    self _meth_83C4("gravity");
    wait(var_5);
    return;
  }

  self waittillmatch("gravity on", "traverse");
  self _meth_83C4("gravity");
  if(!animhasnotetrack(var_0, "blend")) {
    wait(var_5);
    return;
  }

  self waittillmatch("blend", "traverse");
}

func_11661(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);
  for(var_3 = 0; var_3 < var_1; var_3++) {
    self _meth_80F1(self.origin + var_2);
    wait(0.05);
  }
}

func_11662(var_0, var_1, var_2, var_3) {
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
  if(isDefined(var_3) && var_3 < 1) {
    self _meth_82E3("traverseAnim", self.var_126DB, self.var_126DD, 1, 0.2, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self _meth_80F1(self.origin + var_4);
    wait(0.05);
  }

  if(isDefined(var_3) && var_3 < 1) {
    self _meth_82E3("traverseAnim", self.var_126DB, self.var_126DD, 1, 0.2, 1);
  }
}

func_5AC3(var_0) {
  self endon("killanimscript");
  var_1 = getdvarint("ai_iw7", 0) != 0;
  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  var_2 = self getspectatepoint();
  var_2.var_126D4 = var_2.origin[2];
  if(isDefined(var_2.var_126D5)) {
    var_2.var_126D4 = var_2.var_126D4 + var_2.var_126D5;
  }

  var_3 = self _meth_8145();
  self orientmode("face angle", var_2.angles[1]);
  self.var_126E6 = var_0["traverseHeight"];
  self.var_126EB = var_2;
  var_4 = var_0["traverseAnim"];
  var_5 = var_0["traverseToCoverAnim"];
  if(var_1) {
    self animmode("noclip");
  } else {
    self _meth_83C4("nogravity");
    self _meth_83C4("noclip");
  }

  self.var_126EC = self.origin[2];
  if(!animhasnotetrack(var_4, "traverse_align")) {
    func_89F5();
  }

  var_6 = 0;
  if(isDefined(var_5) && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == var_0["coverType"] && distancesquared(self.target_getindexoftarget.origin, var_3.origin) < 625) {
    if(scripts\engine\utility::absangleclamp180(self.target_getindexoftarget.angles[1] - var_3.angles[1]) > 160) {
      var_6 = 1;
      var_4 = var_5;
    }
  }

  if(var_6) {
    if(isDefined(var_0["traverseToCoverSound"])) {
      thread scripts\sp\utility::play_sound_on_entity(var_0["traverseToCoverSound"]);
    }
  } else if(isDefined(var_0["traverseSound"])) {
    thread scripts\sp\utility::play_sound_on_entity(var_0["traverseSound"]);
  }

  var_7 = undefined;
  if(var_1) {
    var_7 = lib_0A1E::asm_getbodyknob();
  } else {
    var_7 = % body;
  }

  self.var_126DB = var_4;
  self.var_126DD = var_7;
  self _meth_82E4("traverseAnim", var_4, var_7, 1, 0.2, 1);
  self.var_126E3 = 0;
  self.var_126E2 = var_0["interruptDeathAnim"];
  scripts\anim\shared::donotetracks("traverseAnim", ::func_89F8);
  if(var_1) {
    self animmode("gravity");
  } else {
    self _meth_83C4("gravity");
  }

  if(self.var_EB) {
    if(var_1) {
      self notify("external_traverse_complete");
    }

    return;
  }

  self.a.nodeath = 0;
  if(var_6 && isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 256) {
    self.a.movement = "stop";
    self _meth_83B9(self.target_getindexoftarget.origin);
  } else if(isDefined(var_0["traverseStopsAtEnd"])) {
    self.a.movement = "stop";
  } else {
    self.a.movement = "run";
    self clearanim(var_4, 0.2);
  }

  self.var_126DD = undefined;
  self.var_126DB = undefined;
  self.var_4E2A = undefined;
  self.var_126EB = undefined;
  if(var_1) {
    self notify("external_traverse_complete");
  }
}

func_89F8(var_0) {
  if(var_0 == "traverse_death") {
    return func_89F6();
  }

  if(var_0 == "traverse_align") {
    return func_89F5();
  }

  if(var_0 == "traverse_drop") {
    return func_89F7();
  }
}

func_89F6() {
  if(isDefined(self.var_126E2)) {
    var_0 = self.var_126E2[self.var_126E3];
    self.var_4E2A = var_0[randomint(var_0.size)];
    self.var_126E3++;
  }
}

func_89F5() {
  if(getdvarint("ai_iw7", 0) != 0) {
    self animmode("noclip");
  } else {
    self _meth_83C4("nogravity");
    self _meth_83C4("noclip");
  }

  if(isDefined(self.var_126E6) && isDefined(self.var_126EB.var_126D4)) {
    var_0 = self.var_126EB.var_126D4 - self.var_126EC;
    thread func_11661(var_0 - self.var_126E6);
  }
}

func_89F7() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self getscoreinfocategory(self.var_126DB);
  var_5 = getmovedelta(self.var_126DB, var_4, 1);
  var_6 = getanimlength(self.var_126DB);
  var_7 = 0 - var_5[2];
  var_8 = var_7 - var_3;
  if(var_7 < var_3) {
    var_9 = var_7 / var_3;
  } else {
    var_9 = 1;
  }

  var_0A = var_6 - var_4 / 3;
  var_0B = ceil(var_0A * 20);
  thread func_11662(var_8, 0, var_0B, var_9);
  thread func_6CE5(var_1[2]);
}

func_6CE5(var_0) {
  self endon("killanimscript");
  var_0 = var_0 + 4;
  for(;;) {
    if(self.origin[2] < var_0) {
      if(getdvarint("ai_iw7", 0) != 0) {
        self animmode("gravity");
      } else {
        self _meth_83C4("gravity");
      }

      break;
    }

    wait(0.05);
  }
}

func_593C() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

func_5864(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;
  if(var_0 == "traverse_jump_start") {
    var_2 = 1;
    var_4 = getnotetracktimes(self.var_126DB, "traverse_align");
    if(var_4.size > 0) {
      var_1 = var_4;
    } else {
      var_1 = getnotetracktimes(self.var_126DB, "traverse_jump_end");
      var_3 = 1;
    }
  } else if(var_0 == "gravity on") {
    var_2 = 1;
    var_1 = getnotetracktimes(self.var_126DB, "traverse_jump_end");
    var_3 = 1;
  }

  if(var_2) {
    var_5 = getnotetracktimes(self.var_126DB, var_0);
    var_6 = var_5[0];
    var_7 = getmovedelta(self.var_126DB, 0, var_5[0]);
    var_8 = var_7[2];
    var_7 = getmovedelta(self.var_126DB, 0, var_1[0]);
    var_9 = var_7[2];
    var_0A = var_1[0];
    var_0B = getanimlength(self.var_126DB);
    var_0C = int(var_0A - var_6 * var_0B * 30);
    var_0D = max(1, var_0C - 2);
    var_0E = var_9 - var_8;
    if(var_3) {
      var_7 = getmovedelta(self.var_126DB, 0, 1);
      var_0F = var_7[2] - var_9;
      var_10 = self.var_126E4.origin[2] - self.origin[2] - var_0F;
    } else {
      var_11 = self.var_126EB;
      var_10 = var_11.var_126D5 - self.origin[2] - var_11.origin[2];
    }

    thread func_11662(var_10 - var_0E, 0, var_0D);
    return 1;
  }
}

func_586C() {
  self waittill("killanimscript");
  self.var_126EB = undefined;
  self.var_126E4 = undefined;
}

func_586D(var_0, var_1, var_2) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread func_586C();
  var_3 = self getspectatepoint();
  self orientmode("face angle", var_3.angles[1]);
  if(!isDefined(var_2)) {
    var_4 = var_3.var_126D4 - var_3.origin[2];
    thread func_11661(var_4 - var_1);
  }

  self.var_126DB = level.var_58C7[var_0];
  self.var_126EB = var_3;
  self.var_126E4 = self _meth_8145();
  self clearanim( % body, 0.2);
  self _meth_82EA("dog_traverse", self.var_126DB, 1, 0.2, 1);
  self.var_BCA6 = "land";
  scripts\anim\notetracks::donotetracksintercept("dog_traverse", ::func_5864);
  self.var_BCA6 = undefined;
  self.var_126DB = undefined;
}

func_5867(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread func_586C();
  var_4 = self getspectatepoint();
  var_5 = self _meth_8145();
  self orientmode("face angle", var_4.angles[1]);
  if(!isDefined(var_2)) {
    var_2 = "jump_down_40";
  }

  self.var_126DB = level.var_58C7[var_2];
  self.var_126DD = % body;
  self.var_126EB = var_4;
  self.var_126E4 = var_5;
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    var_6 = var_4.origin[2] - var_5.origin[2];
    thread func_11662(40 - var_6, 0.1, var_0, var_1);
  }

  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82EA("traverseAnim", self.var_126DB, 1, 0.2, 1);
  if(!var_3) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::func_5864);
  }

  self.var_BCA6 = undefined;
  self _meth_83C4("gravity");
  self.var_126DD = undefined;
  self.var_126DB = undefined;
}

func_5868(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread func_586C();
  var_4 = self getspectatepoint();
  self orientmode("face angle", var_4.angles[1]);
  if(!isDefined(var_2)) {
    var_2 = "jump_up_40";
  }

  self.var_126DB = level.var_58C7[var_2];
  self.var_126DD = % body;
  self.var_126EB = var_4;
  self.var_126E4 = self _meth_8145();
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    thread func_11662(var_0 - 40, 0.2, var_1);
  }

  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82EA("traverseAnim", self.var_126DB, 1, 0.2, 1);
  if(!var_3) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::func_5864);
  }

  self.var_BCA6 = undefined;
  self _meth_83C4("gravity");
  self.var_126DB = undefined;
  self.var_126DD = undefined;
}

func_5869(var_0, var_1) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread func_586C();
  var_2 = self getspectatepoint();
  self orientmode("face angle", var_2.angles[1]);
  if(!isDefined(var_2.var_126D4)) {
    var_2.var_126D4 = var_2.origin[2];
  }

  var_3 = var_2.var_126D4 - var_2.origin[2];
  thread func_11661(var_3 - var_1);
  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82E4("dog_traverse", level.var_58C7[var_0], 1, 0.2, 1);
  scripts\anim\shared::donotetracks("dog_traverse");
  self.var_BCA6 = undefined;
}

func_F163() {
  self waittill("killanimscript");
}

func_F9C6() {
  foreach(var_1 in getnodearray("traverse", "targetname")) {
    var_1 thread func_126ED();
  }
}

func_D999(var_0) {
  self.var_5AE2 = var_0.origin;
  self.var_10DCE = self.angles;
  if(isent(var_0)) {
    var_0 delete();
    return;
  }

  scripts\sp\utility::func_51D4(var_0);
}

func_D9BD(var_0) {
  var_1 = getent(var_0.target, "targetname");
  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  }

  self.var_138A6 = spawnStruct();
  var_3 = var_0;
  var_4 = 0;
  self.var_138A6.var_10DCE = self.angles;
  var_6 = undefined;
  while(isDefined(var_3)) {
    self.var_138A6.var_C050[var_4] = var_3.origin - self.origin;
    var_4++;
    var_7 = scripts\engine\utility::getstruct(var_3.target, "targetname");
    scripts\sp\utility::func_51D4(var_3);
    var_3 = var_7;
    self.var_138A6.var_C050[var_4] = var_3.origin - self.origin;
    var_4++;
    if(isDefined(var_3.target)) {
      var_0A = scripts\engine\utility::getstruct(var_3.target, "targetname");
    } else {
      var_0A = undefined;
    }

    scripts\sp\utility::func_51D4(var_3);
    var_3 = var_0A;
    if(isDefined(var_3) && isDefined(var_3.var_EF1D)) {
      if(var_3.var_EF1D == "wallrun_mantle") {
        self.var_138A6.var_B313 = var_3.origin - self.origin;
        if(isDefined(var_3.angles)) {
          self.var_138A6.var_B312 = var_3.angles;
        }

        scripts\sp\utility::func_51D4(var_3);
        break;
      } else if(var_3.var_EF1D == "wallrun_vault") {
        self.var_138A6.var_B313 = var_3.origin - self.origin;
        self.var_138A6.var_331A = 1;
        scripts\sp\utility::func_51D4(var_3);
        break;
      }
    }
  }
}

func_126ED() {
  var_0 = getent(self.target, "targetname");
  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getstruct(self.target, "targetname");
  }

  switch (self.opcode::OP_ScriptMethodCallPointer) {
    case "wall_run":
      func_D9BD(var_0);
      break;

    case "double_jump_mantle":
    case "double_jump_vault":
      func_D999(var_0);
      break;

    case "double_jump":
      self.var_10DCE = self.angles;
      if(!isDefined(var_0)) {
        return;
      }

      self.var_A4C9 = var_0.origin - self.origin;
      self.var_A4C8 = var_0.origin;
      break;

    case "rail_hop_double_jump_down":
      self.var_10DCE = self.angles;
      break;

    default:
      break;
  }

  self.var_126D4 = var_0.origin[2];
  self.var_126D5 = var_0.origin[2] - self.origin[2];
  if(isent(var_0)) {
    var_0 delete();
    return;
  }

  scripts\sp\utility::func_51D4(var_0);
}