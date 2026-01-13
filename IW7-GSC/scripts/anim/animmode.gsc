/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\animmode.gsc
*********************************************/

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self.var_141C endon(self.var_117E);
  if(isDefined(self.var_11BC)) {
    self thread[[self.var_11BC]]();
    self.var_11BC = undefined;
  }

  var_0 = isDefined(self.var_11BB) && self.var_11BB;
  if(var_0) {
    self endon("stop_loop");
    self.var_11BB = undefined;
  } else {
    thread func_C141(self.var_117E);
  }

  var_1 = self.var_117E;
  self.var_117E = undefined;
  var_2 = 0;
  if(var_0) {
    var_2 = level.var_EC85[self.var_1180][var_1].size;
    var_3 = level.var_EC85[self.var_1180][var_1][randomint(var_2)];
  } else {
    var_3 = level.var_EC85[self.var_1180][var_2];
  }

  var_4 = getstartorigin(self.var_141C.origin, self.var_141C.angles, var_3);
  var_5 = getstartangles(self.var_141C.origin, self.var_141C.angles, var_3);
  var_6 = self func_811F(var_4);
  if(isDefined(var_6)) {
    var_4 = var_6;
  }

  if(!isDefined(self.var_C0C1)) {
    self func_83B9(var_4, var_5);
  }

  self.closefile = 0;
  var_7 = 0.3;
  var_8 = 0.2;
  if(isDefined(self.var_1EA2)) {
    var_7 = self.var_1EA2;
    var_8 = self.var_1EA2;
  }

  self animmode(self.var_117F);
  if(getdvarint("ai_iw7") == 1) {
    self clearanim(lib_0A1E::func_2342(), 0.3);
  } else {
    self clearanim(self.var_E6E6, var_7);
  }

  self orientmode("face angle", var_5[1]);
  var_9 = "custom_animmode";
  self func_82EA(var_9, var_3, 1, var_8, 1);
  self.var_141C thread scripts\sp\anim::func_10CBF(self, var_9, var_1, self.var_1180, var_3);
  self.var_141C thread scripts\sp\anim::func_1FCA(self, var_9, var_1);
  var_0A = self.var_141C;
  self.var_141C = undefined;
  self.var_117F = undefined;
  self endon("killanimscript");
  var_0B = "end";
  if(!var_0) {
    if(animhasnotetrack(var_3, "finish")) {
      var_0B = "finish";
    } else if(animhasnotetrack(var_3, "stop anim")) {
      var_0B = "stop anim";
    }
  }

  for(;;) {
    self waittillmatch(var_0B, var_9);
    if(var_0) {
      var_3 = level.var_EC85[self.var_1180][var_1][randomint(var_2)];
      self func_82E6(var_9, var_3, 1, 0.2, 1);
      if(isDefined(var_0A)) {
        var_0A thread scripts\sp\anim::func_10CBF(self, var_9, var_1, self.var_1180, var_3);
        var_0A thread scripts\sp\anim::func_1FCA(self, var_9, var_1);
      }

      continue;
    }

    break;
  }

  if(var_0B != "end") {
    self orientmode("face motion");
  }

  self notify("finished_custom_animmode" + var_1);
}

func_C141(var_0) {
  self endon("death");
  self endon("finished_custom_animmode" + var_0);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + var_0);
}