/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\animmode.gsc
*************************************/

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self.var_141C endon(self.var_117E);
  if(isDefined(self.var_11BC)) {
    self thread[[self.var_11BC]]();
    self.var_11BC = undefined;
  }

  var_00 = isDefined(self.var_11BB) && self.var_11BB;
  if(var_00) {
    self endon("stop_loop");
    self.var_11BB = undefined;
  } else {
    thread func_C141(self.var_117E);
  }

  var_01 = self.var_117E;
  self.var_117E = undefined;
  var_02 = 0;
  if(var_00) {
    var_02 = level.var_EC85[self.var_1180][var_01].size;
    var_03 = level.var_EC85[self.var_1180][var_01][randomint(var_02)];
  } else {
    var_03 = level.var_EC85[self.var_1180][var_02];
  }

  var_04 = getstartorigin(self.var_141C.origin, self.var_141C.angles, var_03);
  var_05 = getstartangles(self.var_141C.origin, self.var_141C.angles, var_03);
  var_06 = self _meth_811F(var_04);
  if(isDefined(var_06)) {
    var_04 = var_06;
  } else {}

  if(!isDefined(self.var_C0C1)) {
    self _meth_83B9(var_04, var_05);
  }

  self.closefile = 0;
  var_07 = 0.3;
  var_08 = 0.2;
  if(isDefined(self.var_1EA2)) {
    var_07 = self.var_1EA2;
    var_08 = self.var_1EA2;
  }

  self animmode(self.var_117F);
  if(getdvarint("ai_iw7") == 1) {
    self clearanim(lib_0A1E::func_2342(), 0.3);
  } else {
    self clearanim(self.var_E6E6, var_07);
  }

  self orientmode("face angle", var_05[1]);
  var_09 = "custom_animmode";
  self _meth_82EA(var_09, var_03, 1, var_08, 1);
  self.var_141C thread scripts\sp\anim::func_10CBF(self, var_09, var_01, self.var_1180, var_03);
  self.var_141C thread scripts\sp\anim::func_1FCA(self, var_09, var_01);
  var_0A = self.var_141C;
  self.var_141C = undefined;
  self.var_117F = undefined;
  self endon("killanimscript");
  var_0B = "end";
  if(!var_00) {
    if(animhasnotetrack(var_03, "finish")) {
      var_0B = "finish";
    } else if(animhasnotetrack(var_03, "stop anim")) {
      var_0B = "stop anim";
    }
  }

  for(;;) {
    self waittillmatch(var_0B, var_09);
    if(var_00) {
      var_03 = level.var_EC85[self.var_1180][var_01][randomint(var_02)];
      self _meth_82E6(var_09, var_03, 1, 0.2, 1);
      if(isDefined(var_0A)) {
        var_0A thread scripts\sp\anim::func_10CBF(self, var_09, var_01, self.var_1180, var_03);
        var_0A thread scripts\sp\anim::func_1FCA(self, var_09, var_01);
      }

      continue;
    }

    break;
  }

  if(var_0B != "end") {
    self orientmode("face motion");
  }

  self notify("finished_custom_animmode" + var_01);
}

func_C141(param_00) {
  self endon("death");
  self endon("finished_custom_animmode" + param_00);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + param_00);
}