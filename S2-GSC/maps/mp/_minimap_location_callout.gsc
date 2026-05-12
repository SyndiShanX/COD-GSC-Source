/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_minimap_location_callout.gsc
*************************************************/

func_00D5() {
  level.var_620F = getEntArray("minimap_location_callout", "targetname");
}

func_63C2() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.var_2942 = -1;
  self setclientomnvar("ui_minimap_location_callout", -1);
  wait 0.05;
  func_21D1(1);
  while(isDefined(self)) {
    wait(0.1);
    func_21D1(0);
  }
}

func_21D1(param_00) {
  var_01 = 0;
  var_02 = -1;
  foreach(var_04 in level.var_620F) {
    if(var_04 method_858B(self.var_0116)) {
      var_01 = 1;
      var_02 = int(var_04.var_0165);
      continue;
    }
  }

  if(var_01) {
    if(param_00 || var_02 != self.var_2942) {
      self.var_2942 = var_02;
      self setclientomnvar("ui_minimap_location_callout", self.var_2942);
    }

    self.var_99F2 = gettime();
  }

  if(!var_01 && self.var_2942 != -1 && !isDefined(self.var_99F2) || self.var_99F2 + 2000 < gettime()) {
    self.var_2942 = -1;
    self setclientomnvar("ui_minimap_location_callout", -1);
  }
}