/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\input_allow.gsc
***********************************************/

function allow_input_internal(var0, var1, var2, var3) {
  var4 = ref_132d8();

  if(!isDefined(self.allows)) {
    self.allows = [];
  }

  if(var1) {
    if(var4) {} else {
      if(!isDefined(self.allows[var0])) {
        self.allows[var0] = 0;
      }

      if(istrue(var3)) {
        return 1;
      }

      self.allows[var0]--;

      if(!self.allows[var0]) {
        self.allows[var0] = undefined;
        return 1;
      }
    }
  } else if(var4) {} else {
    if(!isDefined(self.allows[var0])) {
      self.allows[var0] = 0;
    }

    if(istrue(var3)) {
      return 0;
    }

    self.allows[var0]++;

    if(self.allows[var0] == 1) {
      return 0;
    }
  }

  return undefined;
}

function is_input_allowed_internal(var0) {
  if(!isDefined(self.allows)) {
    self.allows = [];
  }

  if(!isDefined(self.allows) || !isDefined(self.allows[var0]) || !self.allows[var0]) {
    return 1;
  }

  return 0;
}

function clear_allow_info(var0) {
  if(isDefined(self.allows) && isDefined(self.allows[var0])) {
    self.allows[var0] = undefined;
    return;
  }
}

function clear_all_allow_info() {
  if(isDefined(self.allows)) {
    foreach(var1 in self.allows) {
      var1 = undefined;
    }

    self.allows = undefined;
  }

  self notify("clearedAllows");
}

function ref_132d8() {
  return false;
}