/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1366.gsc
*********************************************/

lib_0556::func_00D5() {
  level thread maps\mp\_utility::func_6F74(::lib_0556::func_5330);
}

lib_0556::func_5330() {
  if(!isbot(self)) {
    self.var_7871 = [];
    thread lib_0556::func_63A0();
    thread lib_0556::func_63FA();
  }
}

lib_0556::func_A6B8() {
  while(!isDefined(self.var_7871)) {
    wait 0.05;
  }

  wait 0.05;
}

lib_0556::func_63A0() {
  self endon("disconnect");
  self.var_293A = -1;
  self setclientomnvar("ui_zm_selected_quest_item", self.var_293A);
  self setclientomnvar("ui_zm_owns_quest_items", 0);
}

lib_0556::func_63FA() {
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_change", var_00);
    var_01 = 0;
    var_02 = -1;
    foreach(var_05, var_04 in self.var_7871) {
      if(var_04.var_0109 == var_00) {
        self.var_293A = var_05;
        var_02 = var_04.var_502A;
        var_01 = 1;
        break;
      }
    }

    if(!var_01) {
      self.var_293A = -1;
    }

    self setclientomnvar("ui_zm_selected_quest_item", var_02);
  }
}

lib_0556::func_4B71(param_00) {
  var_01 = 0;
  if(isDefined(self.var_7871)) {
    foreach(var_03 in self.var_7871) {
      if(var_03.var_7B79 == param_00) {
        var_01 = 1;
      }
    }
  }

  return var_01;
}

getbasequestitemname(param_00) {
  if(!lib_0547::func_5843(param_00)) {
    return param_00;
  }

  var_01 = lib_0547::func_AAF9(param_00, 0, 0);
  return var_01;
}

lib_0556::func_24DD(param_00, param_01, param_02) {
  param_00 = getbasequestitemname(param_00);
  if(lib_0556::func_4B71(param_00)) {
    return;
  }

  var_03 = spawnStruct();
  var_03.var_0109 = param_01;
  var_03.var_7B79 = param_00;
  var_03.var_0CAF = param_02;
  self.var_7871 = common_scripts\utility::func_0F6F(self.var_7871, var_03);
  var_04 = int(tablelookup("mp/zombieUsableQuestItems.csv", 1, param_00, 0));
  var_03.var_502A = var_04;
  self setclientomnvar("ui_zm_owns_quest_items", var_04);
}

lib_0556::func_5F16(param_00) {
  param_00 = getbasequestitemname(param_00);
  if(isDefined(self.var_7871)) {
    foreach(var_04, var_02 in self.var_7871) {
      if(var_02.var_7B79 == param_00 || isDefined(var_02.var_0CAF) && param_00 == var_02.var_0CAF) {
        self.var_7871 = common_scripts\utility::func_0F9A(self.var_7871, var_04);
        var_03 = int(tablelookup("mp/zombieUsableQuestItems.csv", 1, param_00, 0));
        self setclientomnvar("ui_zm_owns_quest_items", var_03);
        self.var_293A = -1;
        self setclientomnvar("ui_zm_selected_quest_item", self.var_293A);
        break;
      }
    }
  }
}