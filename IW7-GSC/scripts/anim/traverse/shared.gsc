/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\shared.gsc
********************************************/

func_18D1(param_00, param_01) {
  self.var_5270 = "crouch";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_02 = self getspectatepoint();
  self orientmode("face angle", var_02.angles[1]);
  var_02.var_126D4 = var_02.origin[2] + var_02.var_126D5;
  var_03 = var_02.var_126D4 - var_02.origin[2];
  thread func_11661(var_03 - param_01);
  var_04 = 0.15;
  self clearanim( % body, var_04);
  self _meth_82E4("traverse", param_00, % root, 1, var_04, 1);
  var_05 = 0.2;
  var_06 = 0.2;
  thread scripts\anim\notetracks::donotetracksforever("traverse", "no clear");
  if(!animhasnotetrack(param_00, "gravity on")) {
    var_07 = 1.23;
    wait(var_07 - var_05);
    self _meth_83C4("gravity");
    wait(var_05);
    return;
  }

  self waittillmatch("gravity on", "traverse");
  self _meth_83C4("gravity");
  if(!animhasnotetrack(param_00, "blend")) {
    wait(var_05);
    return;
  }

  self waittillmatch("blend", "traverse");
}

func_11661(param_00) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_01 = 5;
  var_02 = (0, 0, param_00 / var_01);
  for(var_03 = 0; var_03 < var_01; var_03++) {
    self _meth_80F1(self.origin + var_02);
    wait(0.05);
  }
}

func_11662(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  if(param_00 == 0 || param_02 <= 0) {
    return;
  }

  if(param_01 > 0) {
    wait(param_01);
  }

  var_04 = (0, 0, param_00 / param_02);
  if(isDefined(param_03) && param_03 < 1) {
    self _meth_82E3("traverseAnim", self.var_126DB, self.var_126DD, 1, 0.2, param_03);
  }

  for(var_05 = 0; var_05 < param_02; var_05++) {
    self _meth_80F1(self.origin + var_04);
    wait(0.05);
  }

  if(isDefined(param_03) && param_03 < 1) {
    self _meth_82E3("traverseAnim", self.var_126DB, self.var_126DD, 1, 0.2, 1);
  }
}

func_5AC3(param_00) {
  self endon("killanimscript");
  var_01 = getdvarint("ai_iw7", 0) != 0;
  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  var_02 = self getspectatepoint();
  var_02.var_126D4 = var_02.origin[2];
  if(isDefined(var_02.var_126D5)) {
    var_02.var_126D4 = var_02.var_126D4 + var_02.var_126D5;
  }

  var_03 = self _meth_8145();
  self orientmode("face angle", var_02.angles[1]);
  self.var_126E6 = param_00["traverseHeight"];
  self.var_126EB = var_02;
  var_04 = param_00["traverseAnim"];
  var_05 = param_00["traverseToCoverAnim"];
  if(var_01) {
    self animmode("noclip");
  } else {
    self _meth_83C4("nogravity");
    self _meth_83C4("noclip");
  }

  self.var_126EC = self.origin[2];
  if(!animhasnotetrack(var_04, "traverse_align")) {
    func_89F5();
  }

  var_06 = 0;
  if(isDefined(var_05) && isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == param_00["coverType"] && distancesquared(self.target_getindexoftarget.origin, var_03.origin) < 625) {
    if(scripts\engine\utility::absangleclamp180(self.target_getindexoftarget.angles[1] - var_03.angles[1]) > 160) {
      var_06 = 1;
      var_04 = var_05;
    }
  }

  if(var_06) {
    if(isDefined(param_00["traverseToCoverSound"])) {
      thread scripts\sp\utility::play_sound_on_entity(param_00["traverseToCoverSound"]);
    }
  } else if(isDefined(param_00["traverseSound"])) {
    thread scripts\sp\utility::play_sound_on_entity(param_00["traverseSound"]);
  }

  var_07 = undefined;
  if(var_01) {
    var_07 = lib_0A1E::asm_getbodyknob();
  } else {
    var_07 = % body;
  }

  self.var_126DB = var_04;
  self.var_126DD = var_07;
  self _meth_82E4("traverseAnim", var_04, var_07, 1, 0.2, 1);
  self.var_126E3 = 0;
  self.var_126E2 = param_00["interruptDeathAnim"];
  scripts\anim\shared::donotetracks("traverseAnim", ::func_89F8);
  if(var_01) {
    self animmode("gravity");
  } else {
    self _meth_83C4("gravity");
  }

  if(self.var_EB) {
    if(var_01) {
      self notify("external_traverse_complete");
    }

    return;
  }

  self.a.nodeath = 0;
  if(var_06 && isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 256) {
    self.a.movement = "stop";
    self _meth_83B9(self.target_getindexoftarget.origin);
  } else if(isDefined(param_00["traverseStopsAtEnd"])) {
    self.a.movement = "stop";
  } else {
    self.a.movement = "run";
    self clearanim(var_04, 0.2);
  }

  self.var_126DD = undefined;
  self.var_126DB = undefined;
  self.var_4E2A = undefined;
  self.var_126EB = undefined;
  if(var_01) {
    self notify("external_traverse_complete");
  }
}

func_89F8(param_00) {
  if(param_00 == "traverse_death") {
    return func_89F6();
  }

  if(param_00 == "traverse_align") {
    return func_89F5();
  }

  if(param_00 == "traverse_drop") {
    return func_89F7();
  }
}

func_89F6() {
  if(isDefined(self.var_126E2)) {
    var_00 = self.var_126E2[self.var_126E3];
    self.var_4E2A = var_00[randomint(var_00.size)];
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
    var_00 = self.var_126EB.var_126D4 - self.var_126EC;
    thread func_11661(var_00 - self.var_126E6);
  }
}

func_89F7() {
  var_00 = self.origin + (0, 0, 32);
  var_01 = physicstrace(var_00, self.origin + (0, 0, -512));
  var_02 = distance(var_00, var_01);
  var_03 = var_02 - 32 - 0.5;
  var_04 = self getscoreinfocategory(self.var_126DB);
  var_05 = getmovedelta(self.var_126DB, var_04, 1);
  var_06 = getanimlength(self.var_126DB);
  var_07 = 0 - var_05[2];
  var_08 = var_07 - var_03;
  if(var_07 < var_03) {
    var_09 = var_07 / var_03;
  } else {
    var_09 = 1;
  }

  var_0A = var_06 - var_04 / 3;
  var_0B = ceil(var_0A * 20);
  thread func_11662(var_08, 0, var_0B, var_09);
  thread func_6CE5(var_01[2]);
}

func_6CE5(param_00) {
  self endon("killanimscript");
  param_00 = param_00 + 4;
  for(;;) {
    if(self.origin[2] < param_00) {
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

func_5864(param_00) {
  var_01 = undefined;
  var_02 = 0;
  var_03 = 0;
  if(param_00 == "traverse_jump_start") {
    var_02 = 1;
    var_04 = getnotetracktimes(self.var_126DB, "traverse_align");
    if(var_04.size > 0) {
      var_01 = var_04;
    } else {
      var_01 = getnotetracktimes(self.var_126DB, "traverse_jump_end");
      var_03 = 1;
    }
  } else if(param_00 == "gravity on") {
    var_02 = 1;
    var_01 = getnotetracktimes(self.var_126DB, "traverse_jump_end");
    var_03 = 1;
  }

  if(var_02) {
    var_05 = getnotetracktimes(self.var_126DB, param_00);
    var_06 = var_05[0];
    var_07 = getmovedelta(self.var_126DB, 0, var_05[0]);
    var_08 = var_07[2];
    var_07 = getmovedelta(self.var_126DB, 0, var_01[0]);
    var_09 = var_07[2];
    var_0A = var_01[0];
    var_0B = getanimlength(self.var_126DB);
    var_0C = int(var_0A - var_06 * var_0B * 30);
    var_0D = max(1, var_0C - 2);
    var_0E = var_09 - var_08;
    if(var_03) {
      var_07 = getmovedelta(self.var_126DB, 0, 1);
      var_0F = var_07[2] - var_09;
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

func_586D(param_00, param_01, param_02) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread func_586C();
  var_03 = self getspectatepoint();
  self orientmode("face angle", var_03.angles[1]);
  if(!isDefined(param_02)) {
    var_04 = var_03.var_126D4 - var_03.origin[2];
    thread func_11661(var_04 - param_01);
  }

  self.var_126DB = level.var_58C7[param_00];
  self.var_126EB = var_03;
  self.var_126E4 = self _meth_8145();
  self clearanim( % body, 0.2);
  self _meth_82EA("dog_traverse", self.var_126DB, 1, 0.2, 1);
  self.var_BCA6 = "land";
  scripts\anim\notetracks::donotetracksintercept("dog_traverse", ::func_5864);
  self.var_BCA6 = undefined;
  self.var_126DB = undefined;
}

func_5867(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread func_586C();
  var_04 = self getspectatepoint();
  var_05 = self _meth_8145();
  self orientmode("face angle", var_04.angles[1]);
  if(!isDefined(param_02)) {
    param_02 = "jump_down_40";
  }

  self.var_126DB = level.var_58C7[param_02];
  self.var_126DD = % body;
  self.var_126EB = var_04;
  self.var_126E4 = var_05;
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!param_03) {
    var_06 = var_04.origin[2] - var_05.origin[2];
    thread func_11662(40 - var_06, 0.1, param_00, param_01);
  }

  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82EA("traverseAnim", self.var_126DB, 1, 0.2, 1);
  if(!param_03) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::func_5864);
  }

  self.var_BCA6 = undefined;
  self _meth_83C4("gravity");
  self.var_126DD = undefined;
  self.var_126DB = undefined;
}

func_5868(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  thread func_586C();
  var_04 = self getspectatepoint();
  self orientmode("face angle", var_04.angles[1]);
  if(!isDefined(param_02)) {
    param_02 = "jump_up_40";
  }

  self.var_126DB = level.var_58C7[param_02];
  self.var_126DD = % body;
  self.var_126EB = var_04;
  self.var_126E4 = self _meth_8145();
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!param_03) {
    thread func_11662(param_00 - 40, 0.2, param_01);
  }

  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82EA("traverseAnim", self.var_126DB, 1, 0.2, 1);
  if(!param_03) {
    scripts\anim\shared::donotetracks("traverseAnim");
  } else {
    scripts\anim\notetracks::donotetracksintercept("traverseAnim", ::func_5864);
  }

  self.var_BCA6 = undefined;
  self _meth_83C4("gravity");
  self.var_126DB = undefined;
  self.var_126DD = undefined;
}

func_5869(param_00, param_01) {
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  thread func_586C();
  var_02 = self getspectatepoint();
  self orientmode("face angle", var_02.angles[1]);
  if(!isDefined(var_02.var_126D4)) {
    var_02.var_126D4 = var_02.origin[2];
  }

  var_03 = var_02.var_126D4 - var_02.origin[2];
  thread func_11661(var_03 - param_01);
  self.var_BCA6 = "land";
  self clearanim( % body, 0.2);
  self _meth_82E4("dog_traverse", level.var_58C7[param_00], 1, 0.2, 1);
  scripts\anim\shared::donotetracks("dog_traverse");
  self.var_BCA6 = undefined;
}

func_F163() {
  self waittill("killanimscript");
}

func_F9C6() {
  foreach(var_01 in getnodearray("traverse", "targetname")) {
    var_01 thread func_126ED();
  }
}

func_D999(param_00) {
  self.var_5AE2 = param_00.origin;
  self.var_10DCE = self.angles;
  if(isent(param_00)) {
    param_00 delete();
    return;
  }

  scripts\sp\utility::func_51D4(param_00);
}

func_D9BD(param_00) {
  var_01 = getent(param_00.target, "targetname");
  if(!isDefined(var_01)) {
    var_01 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  }

  self.var_138A6 = spawnStruct();
  var_03 = param_00;
  var_04 = 0;
  self.var_138A6.var_10DCE = self.angles;
  var_06 = undefined;
  while(isDefined(var_03)) {
    self.var_138A6.var_C050[var_04] = var_03.origin - self.origin;
    var_04++;
    var_07 = scripts\engine\utility::getstruct(var_03.target, "targetname");
    scripts\sp\utility::func_51D4(var_03);
    var_03 = var_07;
    self.var_138A6.var_C050[var_04] = var_03.origin - self.origin;
    var_04++;
    if(isDefined(var_03.target)) {
      var_0A = scripts\engine\utility::getstruct(var_03.target, "targetname");
    } else {
      var_0A = undefined;
    }

    scripts\sp\utility::func_51D4(var_03);
    var_03 = var_0A;
    if(isDefined(var_03) && isDefined(var_03.var_EF1D)) {
      if(var_03.var_EF1D == "wallrun_mantle") {
        self.var_138A6.var_B313 = var_03.origin - self.origin;
        if(isDefined(var_03.angles)) {
          self.var_138A6.var_B312 = var_03.angles;
        }

        scripts\sp\utility::func_51D4(var_03);
        break;
      } else if(var_03.var_EF1D == "wallrun_vault") {
        self.var_138A6.var_B313 = var_03.origin - self.origin;
        self.var_138A6.var_331A = 1;
        scripts\sp\utility::func_51D4(var_03);
        break;
      }
    }
  }
}

func_126ED() {
  var_00 = getent(self.target, "targetname");
  if(!isDefined(var_00)) {
    var_00 = scripts\engine\utility::getstruct(self.target, "targetname");
  }

  switch (self.opcode::OP_ScriptMethodCallPointer) {
    case "wall_run":
      func_D9BD(var_00);
      break;

    case "double_jump_mantle":
    case "double_jump_vault":
      func_D999(var_00);
      break;

    case "double_jump":
      self.var_10DCE = self.angles;
      if(!isDefined(var_00)) {
        return;
      }

      self.var_A4C9 = var_00.origin - self.origin;
      self.var_A4C8 = var_00.origin;
      break;

    case "rail_hop_double_jump_down":
      self.var_10DCE = self.angles;
      break;

    default:
      break;
  }

  self.var_126D4 = var_00.origin[2];
  self.var_126D5 = var_00.origin[2] - self.origin[2];
  if(isent(var_00)) {
    var_00 delete();
    return;
  }

  scripts\sp\utility::func_51D4(var_00);
}