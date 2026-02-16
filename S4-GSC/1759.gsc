/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1759.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x3c0cd1f9e5d943339", 0);
  waitframe();
  level._id_CC70 = spawnStruct();
  level._id_CC70._id_CC70 = scripts\engine\utility::getStructArray("screens_system", "script_noteworthy");

  if(!isDefined(level._id_CC70._id_CC70) || level._id_CC70._id_CC70.size <= 0) {
    return;
  }
  level._id_CC70._id_CC78 = [];
  level thread _id_CC75();

  foreach(var_1 in level._id_CC70._id_CC70) {
    var_1._id_E747 = "off";
    var_1 _id_71FC();
    var_1 thread _id_10A7F();
  }

  if(isDefined(level._id_CC7F)) {
    scripts\engine\utility::_id_1BE2(level._id_CC70._id_CC70, level._id_CC7F);
  } else {
    scripts\engine\utility::_id_1BE2(level._id_CC70._id_CC70, ::_id_CC7E);
  }
}

_id_71FC() {
  if(isDefined(self._id_CD45)) {
    if(!isDefined(level._id_CC70._id_CC78[self._id_CD45])) {
      level._id_CC70._id_CC78[self._id_CD45] = [];
      level thread _id_CC80(self._id_CD45);
    }

    level._id_CC70._id_CC78[self._id_CD45] = ::scripts\engine\utility::array_add(level._id_CC70._id_CC78[self._id_CD45], self);
    level._id_CC70._id_CC70 = scripts\engine\utility::array_remove(level._id_CC70._id_CC70, self);
  }
}

_id_CC7E() {
  if(istrue(level._id_CC7B)) {
    return;
  }
  self endon("death");
  _id_CC73();
  var_0 = _id_6789();

  if(isDefined(var_0)) {
    _id_4C26(var_0);
  } else {
    _id_CC77();
  }
}

_id_4C26(var_0) {
  self endon("death");

  if(issubstr(var_0, "screen")) {
    childthread _id_CC77(var_0);
    return;
  }

  switch (var_0) {
    case "fixed":
      if(_id_4428()) {}

      childthread _id_CC77();
      break;
    case "flip":
      if(_id_4428()) {}

      childthread _id_CC79();
      break;
    case "fliprnd":
      if(_id_4428()) {}

      childthread _id_CC7A();
      break;
    case "static":
      if(_id_4428()) {}

      childthread _id_CC7D();
      break;
    case "red":
      if(_id_4428()) {}

      childthread _id_CC7C();
      break;
    case "bink":
      if(_id_4428()) {}

      childthread _id_CC72();
      break;
    case "alertflip":
      if(_id_4428()) {}

      childthread _id_CC71();
      break;
  }
}

_id_CC73() {
  self._id_CC67 = spawn("script_model", self.origin);
  self._id_CC67.angles = self.angles;
  self._id_CC67 setModel(self._id_CDC1);
  self._id_CC67 _meth_81A6();
  _id_672A();
}

_id_CC74() {
  self._id_CC67 setCanDamage(1);
  self._id_CC67 waittill("damage");
  self notify("stop_screens");
  self._id_CC67 delete();
}

_id_CC76() {
  self._id_E747 = "off";
  self notify("stop_screens");

  if(isDefined(self._id_CC67)) {
    self._id_CC67 delete();
  }

  _id_4743();
}

_id_CC77(var_0) {
  if(!isDefined(self._id_CC77) && !isDefined(var_0)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_fixed");

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = "screen_fixed" + (randomint(self._id_CC77.size) + 1);
  }

  if(_id_4428()) {
    var_2 = var_1;

    if(isDefined(var_0)) {
      var_2 = "override " + var_2;
    }
  }

  self._id_E747 = "on";
  self._id_CC67 _meth_81A6();
  self._id_CC67 showpart(var_1);

  if(isDefined(self._id_CC81) && !isDefined(var_0)) {
    if(randomint(3) == 0) {
      var_1 = "screen_widget" + (randomint(self._id_CC81.size) + 1);
      self._id_CC67 showpart(var_1);
    }
  }
}

_id_CC7D() {
  if(!isDefined(self._id_CC7D)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_static");
  var_0 = "screen_static" + (randomint(self._id_CC7D.size) + 1);

  if(_id_4428()) {}

  self._id_E747 = "on";
  self._id_CC67 _meth_81A6();
  self._id_CC67 showpart(var_0);
}

_id_CC79() {
  if(!isDefined(self._id_CC79)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_flip");
  var_0 = randomint(self._id_CC79.size) + 1;

  for(;;) {
    for(var_1 = var_0; var_1 < self._id_CC79.size + 1; var_1++) {
      var_2 = 3;
      var_3 = "screen_flip" + var_1;

      if(_id_4428()) {}

      self._id_E747 = "on";
      self._id_CC67 _meth_81A6();
      self._id_CC67 showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

_id_CC7A() {
  if(!isDefined(self._id_CC7A)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_fliprnd");
  var_0 = randomint(self._id_CC7A.size) + 1;

  for(;;) {
    for(var_1 = var_0; var_1 < self._id_CC7A.size + 1; var_1++) {
      var_2 = randomfloatrange(1.5, 4);
      var_3 = "screen_fliprnd" + var_1;

      if(_id_4428()) {}

      self._id_E747 = "on";
      self._id_CC67 _meth_81A6();
      self._id_CC67 showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

_id_CC72() {
  if(!isDefined(self._id_CC72)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_bink");
  var_0 = "screen_bink" + (randomint(self._id_CC72.size) + 1);

  if(_id_4428()) {}

  self._id_E747 = "on";
  self._id_CC67 _meth_81A6();
  self._id_CC67 showpart(var_0);
}

_id_CC7C() {
  if(!isDefined(self._id_CC7C)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_red");
  self._id_C7B9 = 0;
  var_0 = randomint(self._id_CC7C.size) + 1;

  for(;;) {
    for(var_1 = 1; var_1 < self._id_CC7C.size + 1; var_1++) {
      var_2 = randomfloatrange(0.25, 0.5);

      if(randomint(6) == 0 && !self._id_C7B9) {
        self._id_C7B9 = 1;

        if(var_1 <= 2) {
          var_1 = var_1 + self._id_CC7C.size;
        }

        var_1 = var_1 - 2;
        var_2 = 0.1;
      } else
        self._id_C7B9 = 0;

      var_3 = "screen_red" + var_1;

      if(_id_4428()) {}

      self._id_E747 = "on";
      self._id_CC67 _meth_81A6();
      self._id_CC67 showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

_id_CC71() {
  if(!isDefined(self._id_CC71)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_alertflip");
  self._id_CC67 _meth_81A6();

  for(;;) {
    var_0 = randomfloatrange(0.5, 1);

    if(_id_4428()) {}

    self._id_E747 = "on";
    self._id_CC67 hidepart("screen_alertflip1");
    self._id_CC67 showpart("screen_alertflip2");
    wait(var_0);
    self._id_CC67 showpart("screen_alertflip1");
    self._id_CC67 hidepart("screen_alertflip2");
    wait(var_0);
  }
}

_id_672A() {
  var_0 = _func_00BC(self._id_CC67.model);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = _func_00BF(self._id_CC67.model, var_1);

    if(issubstr(var_2, "screen_")) {
      if(issubstr(var_2, "screen_red")) {
        if(!isDefined(self._id_CC7C)) {
          self._id_CC7C = [];
        }

        self._id_CC7C = scripts\engine\utility::array_add(self._id_CC7C, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_fixed")) {
        if(!isDefined(self._id_CC77)) {
          self._id_CC77 = [];
        }

        self._id_CC77 = scripts\engine\utility::array_add(self._id_CC77, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_static")) {
        if(!isDefined(self._id_CC7D)) {
          self._id_CC7D = [];
        }

        self._id_CC7D = scripts\engine\utility::array_add(self._id_CC7D, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_fliprnd")) {
        if(!isDefined(self._id_CC7A)) {
          self._id_CC7A = [];
        }

        self._id_CC7A = scripts\engine\utility::array_add(self._id_CC7A, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_flip")) {
        if(!isDefined(self._id_CC79)) {
          self._id_CC79 = [];
        }

        self._id_CC79 = scripts\engine\utility::array_add(self._id_CC79, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_bink")) {
        if(!isDefined(self._id_CC72)) {
          self._id_CC72 = [];
        }

        self._id_CC72 = scripts\engine\utility::array_add(self._id_CC72, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_alertflip")) {
        if(!isDefined(self._id_CC71)) {
          self._id_CC71 = [];
        }

        self._id_CC71 = scripts\engine\utility::array_add(self._id_CC71, var_2);
        continue;
      }

      if(issubstr(var_2, "screen_widget")) {
        if(!isDefined(self._id_CC81)) {
          self._id_CC81 = [];
        }

        self._id_CC81 = scripts\engine\utility::array_add(self._id_CC81, var_2);
      }
    }
  }
}

_id_4743() {
  if(isDefined(self._id_CC7C)) {
    self._id_CC7C = [];
  }

  if(isDefined(self._id_CC77)) {
    self._id_CC77 = [];
  }

  if(isDefined(self._id_CC7D)) {
    self._id_CC7D = [];
  }

  if(isDefined(self._id_CC79)) {
    self._id_CC79 = [];
  }

  if(isDefined(self._id_CC7A)) {
    self._id_CC7A = [];
  }

  if(isDefined(self._id_CC72)) {
    self._id_CC72 = [];
  }

  if(isDefined(self._id_CC71)) {
    self._id_CC71 = [];
  }

  if(isDefined(self._id_CC81)) {
    self._id_CC81 = [];
  }
}

_id_6789() {
  if(isDefined(self._id_CE18)) {
    var_0 = strtok(self._id_CE18, " ");

    foreach(var_2 in var_0) {
      if(issubstr(var_2, "screen")) {
        return var_2;
      }
    }

    foreach(var_2 in var_0) {
      if(issubstr(var_2, "state")) {
        switch (var_2) {
          case "state_fixed":
            return "fixed";
          case "state_flip":
            return "flip";
          case "state_fliprnd":
            return "fliprnd";
          case "state_static":
            return "static";
          case "state_red":
            return "red";
          case "state_bink":
            return "bink";
          case "state_alertflip":
            return "alertflip";
          default:
        }
      }
    }
  }

  return undefined;
}

_id_10A7F() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getscriptablearray(self.target, "targetname");

  if(isDefined(var_0[0])) {
    if(_id_4428()) {}

    var_0[0] waittill("death");
    _id_CC76();
    var_1 = getarraykeys(level._id_CC70._id_CC78);

    foreach(var_3 in var_1) {
      foreach(var_5 in level._id_CC70._id_CC78[var_3]) {
        if(self == var_5) {
          level._id_CC70._id_CC78[var_3] = ::scripts\engine\utility::array_remove(level._id_CC70._id_CC78[var_3], self);
          return;
        }
      }
    }
  }
}

_id_4428() {
  if(getdvarint("#x3c0cd1f9e5d943339") > 0) {
    return 1;
  }

  return 0;
}

_id_D393() {}

_id_CC75() {
  if(!_id_4428()) {
    return;
  }
  for(;;) {
    var_0 = 0;
    var_1 = 0;
    var_2 = getarraykeys(level._id_CC70._id_CC78);

    foreach(var_4 in var_2) {
      var_1 = var_1 + level._id_CC70._id_CC78[var_4].size;

      foreach(var_6 in level._id_CC70._id_CC78[var_4]) {
        if(isDefined(var_6._id_E747) && var_6._id_E747 == "on") {
          var_0 = var_0 + 1;
        }
      }
    }

    foreach(var_6 in level._id_CC70._id_CC70) {
      if(isDefined(var_6._id_E747) && var_6._id_E747 == "on") {
        var_0 = var_0 + 1;
      }
    }

    var_11 = level._id_CC70._id_CC70.size + var_1;
    waitframe();
  }
}

_id_CC80(var_0) {
  if(!scripts\engine\utility::_id_5C0C(var_0)) {
    scripts\engine\utility::_id_5C11(var_0);
  }

  for(;;) {
    scripts\engine\utility::_id_5C24(var_0);

    if(_id_4428()) {
      iprintln(level._id_CC70._id_CC78[var_0].size + " flagged screens activated: " + var_0);
    }

    if(!istrue(level._id_CC7B)) {
      if(isDefined(level._id_CC7F)) {
        scripts\engine\utility::_id_1BE2(level._id_CC70._id_CC78[var_0], level._id_CC7F);
      } else {
        scripts\engine\utility::_id_1BE2(level._id_CC70._id_CC78[var_0], ::_id_CC7E);
      }
    }

    scripts\engine\utility::_id_5C30(var_0);

    if(_id_4428()) {
      iprintln(level._id_CC70._id_CC78[var_0].size + " flagged screens deactivated: " + var_0);
    }

    if(!istrue(level._id_CC7B)) {
      scripts\engine\utility::_id_1BE2(level._id_CC70._id_CC78[var_0], ::_id_CC76);
    }
  }
}