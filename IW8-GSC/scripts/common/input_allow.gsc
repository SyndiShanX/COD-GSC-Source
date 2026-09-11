/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\input_allow.gsc
***********************************************/

function allow_input_internal(var_0, var_1, var_2, var_3) {
  var_4 = ref_132d8();

  if(!isDefined(self.allows)) {
    self.allows = [];
  }

  if(var_1) {
    if(var_4) {} else {
      if(!isDefined(self.allows[var_0])) {
        self.allows[var_0] = 0;
      }

      if(istrue(var_3)) {
        return 1;
      }

      self.allows[var_0]--;

      if(!self.allows[var_0]) {
        self.allows[var_0] = undefined;
        return 1;
      }
    }
  } else if(var_4) {} else {
    if(!isDefined(self.allows[var_0])) {
      self.allows[var_0] = 0;
    }

    if(istrue(var_3)) {
      return 0;
    }

    self.allows[var_0]++;

    if(self.allows[var_0] == 1) {
      return 0;
    }
  }

  return undefined;
}

function is_input_allowed_internal(var_0) {
  if(!isDefined(self.allows)) {
    self.allows = [];
  }

  if(!isDefined(self.allows) || !isDefined(self.allows[var_0]) || !self.allows[var_0]) {
    return 1;
  }

  return 0;
}

function clear_allow_info(var_0) {
  if(isDefined(self.allows) && isDefined(self.allows[var_0])) {
    self.allows[var_0] = undefined;
    return;
  }
}

function clear_all_allow_info() {
  if(isDefined(self.allows)) {
    foreach(var_1 in self.allows) {
      var_1 = undefined;
    }

    self.allows = undefined;
  }

  self notify("clearedAllows");
}

function ref_132d8() {
  return false;
}