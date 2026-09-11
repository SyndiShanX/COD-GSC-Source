/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\screens.gsc
***********************************************/

function init() {
  setdvarifuninitialized("debug_screens", 0);
  waitframe();
  level.screens = spawnStruct();
  level.screens.screens = scripts\engine\utility::getStructArray("screens_system", "script_noteworthy");

  if(!isDefined(level.screens.screens) || level.screens.screens.size <= 0) {
    return;
  }

  level.screens.screens_flagged = [];
  thread screens_debug_counter();

  foreach(var1 in level.screens.screens) {
    var1.state = "off";
    group_by_flag(var1);
    thread watch_scriptable();
  }

  if(isDefined(level.screens_think_func)) {
    scripts\engine\utility::array_thread(level.screens.screens, level.screens_think_func);
    return;
  }

  scripts\engine\utility::array_thread(level.screens.screens, &screens_think);
}

function group_by_flag() {
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.screens.screens_flagged[self.script_flag])) {
      level.screens.screens_flagged[self.script_flag] = [];
      thread screens_wait_for_flag(level);
    }

    level.screens.screens_flagged[self.script_flag] = scripts\engine\utility::array_add(level.screens.screens_flagged[self.script_flag], self);
    level.screens.screens = scripts\engine\utility::array_remove(level.screens.screens, self);
    return;
  }
}

function screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }

  self endon("death");
  screens_create();
  var0 = get_state();

  if(isDefined(var0)) {
    do_state(var0);
    return;
  }

  screens_fixed();
}

function do_state(var0) {
  self endon("death");

  if(issubstr(var0, "screen")) {
    GscBinSkip4(0x35, var0);
  }

  switch (var0) {
    case "fixed":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "flip":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "fliprnd":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "static":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "red":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "bink":
      if(debug()) {}

      GscBinSkip4(0x35);

    case "alertflip":
      if(debug()) {}

      GscBinSkip4(0x35);
  }
}

function screens_create() {
  self.screen_model = spawn("script_model", self.origin);
  self.screen_model.angles = self.angles;
  self.screen_model setModel(self.script_modelname);
  self.screen_model hideallparts();
  get_screens();
}

function screens_damage_think() {
  self.screen_model setCanDamage(1);
  self.screen_model waittill("damage");
  self notify("stop_screens");
  self.screen_model delete();
}

function screens_delete() {
  self.state = "off";
  self notify("stop_screens");

  if(isDefined(self.screen_model)) {
    self.screen_model delete();
  }

  delete_screens();
}

function screens_fixed(var0) {
  if(!isDefined(self.screens_fixed) && !isDefined(var0)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_fixed");

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = "screen_fixed" + randomint(self.screens_fixed.size) + 1;
  }

  if(debug()) {
    var2 = var1;

    if(isDefined(var1)) {
      var2 = "override " + var2;
    }
  }

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(var1);

  if(isDefined(self.screens_widget) && !isDefined(var1)) {
    if(randomint(3) == 0) {
      var1 = "screen_widget" + randomint(self.screens_widget.size) + 1;
      self.screen_model showpart(var1);
      return;
    }

    return;
  }
}

function screens_static() {
  if(!isDefined(self.screens_static)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_static");
  var0 = "screen_static" + randomint(self.screens_static.size) + 1;

  if(debug()) {}

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(var0);
}

function screens_flip() {
  if(!isDefined(self.screens_flip)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_flip");

  for(var0 = randomint(self.screens_flip.size) + 1;; var0 = 1) {
    for(var1 = var0; var1 < self.screens_flip.size + 1; var1++) {
      var2 = 3;
      var3 = "screen_flip" + var1;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(var3);
      wait var2;
    }
  }
}

function screens_fliprnd() {
  if(!isDefined(self.screens_fliprnd)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_fliprnd");

  for(var0 = randomint(self.screens_fliprnd.size) + 1;; var0 = 1) {
    for(var1 = var0; var1 < self.screens_fliprnd.size + 1; var1++) {
      var2 = randomfloatrange(1.5, 4);
      var3 = "screen_fliprnd" + var1;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(var3);
      wait var2;
    }
  }
}

function screens_bink() {
  if(!isDefined(self.screens_bink)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_bink");
  var0 = "screen_bink" + randomint(self.screens_bink.size) + 1;

  if(debug()) {}

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(var0);
}

function screens_red() {
  if(!isDefined(self.screens_red)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_red");
  self.reversed = 0;

  for(var0 = randomint(self.screens_red.size) + 1;; var0 = 1) {
    for(var1 = 1; var1 < self.screens_red.size + 1; var1++) {
      var2 = randomfloatrange(0.25, 0.5);

      if(randomint(6) == 0 && !self.reversed) {
        self.reversed = 1;

        if(var1 <= 2) {
          var1 += self.screens_red.size;
        }

        var1 -= 2;
        var2 = 0.1;
      } else {
        self.reversed = 0;
      }

      var3 = "screen_red" + var1;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(var3);
      wait var2;
    }
  }
}

function screens_alertflip() {
  if(!isDefined(self.screens_alertflip)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_alertflip");
  self.screen_model hideallparts();

  for(;;) {
    var0 = randomfloatrange(0.5, 1);

    if(debug()) {}

    self.state = "on";
    self.screen_model hidepart("screen_alertflip1");
    self.screen_model showpart("screen_alertflip2");
    wait var0;
    self.screen_model showpart("screen_alertflip1");
    self.screen_model hidepart("screen_alertflip2");
    wait var0;
  }
}

function get_screens() {
  var0 = getnumparts(self.screen_model.model);

  for(var1 = 0; var1 < var0; var1++) {
    var2 = getpartname(self.screen_model.model, var1);

    if(issubstr(var2, "screen_")) {
      if(issubstr(var2, "screen_red")) {
        if(!isDefined(self.screens_red)) {
          self.screens_red = [];
        }

        self.screens_red = scripts\engine\utility::array_add(self.screens_red, var2);
        continue;
      }

      if(issubstr(var2, "screen_fixed")) {
        if(!isDefined(self.screens_fixed)) {
          self.screens_fixed = [];
        }

        self.screens_fixed = scripts\engine\utility::array_add(self.screens_fixed, var2);
        continue;
      }

      if(issubstr(var2, "screen_static")) {
        if(!isDefined(self.screens_static)) {
          self.screens_static = [];
        }

        self.screens_static = scripts\engine\utility::array_add(self.screens_static, var2);
        continue;
      }

      if(issubstr(var2, "screen_fliprnd")) {
        if(!isDefined(self.screens_fliprnd)) {
          self.screens_fliprnd = [];
        }

        self.screens_fliprnd = scripts\engine\utility::array_add(self.screens_fliprnd, var2);
        continue;
      }

      if(issubstr(var2, "screen_flip")) {
        if(!isDefined(self.screens_flip)) {
          self.screens_flip = [];
        }

        self.screens_flip = scripts\engine\utility::array_add(self.screens_flip, var2);
        continue;
      }

      if(issubstr(var2, "screen_bink")) {
        if(!isDefined(self.screens_bink)) {
          self.screens_bink = [];
        }

        self.screens_bink = scripts\engine\utility::array_add(self.screens_bink, var2);
        continue;
      }

      if(issubstr(var2, "screen_alertflip")) {
        if(!isDefined(self.screens_alertflip)) {
          self.screens_alertflip = [];
        }

        self.screens_alertflip = scripts\engine\utility::array_add(self.screens_alertflip, var2);
        continue;
      }

      if(issubstr(var2, "screen_widget")) {
        if(!isDefined(self.screens_widget)) {
          self.screens_widget = [];
        }

        self.screens_widget = scripts\engine\utility::array_add(self.screens_widget, var2);
      }
    }
  }
}

function delete_screens() {
  if(isDefined(self.screens_red)) {
    self.screens_red = [];
  }

  if(isDefined(self.screens_fixed)) {
    self.screens_fixed = [];
  }

  if(isDefined(self.screens_static)) {
    self.screens_static = [];
  }

  if(isDefined(self.screens_flip)) {
    self.screens_flip = [];
  }

  if(isDefined(self.screens_fliprnd)) {
    self.screens_fliprnd = [];
  }

  if(isDefined(self.screens_bink)) {
    self.screens_bink = [];
  }

  if(isDefined(self.screens_alertflip)) {
    self.screens_alertflip = [];
  }

  if(isDefined(self.screens_widget)) {
    self.screens_widget = [];
    return;
  }
}

function get_state() {
  if(isDefined(self.script_parameters)) {
    var0 = strtok(self.script_parameters, " ");

    foreach(var2 in var0) {
      if(issubstr(var2, "screen")) {
        return var2;
      }
    }

    foreach(var2 in var0) {
      if(issubstr(var2, "state")) {
        switch (var2) {
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
            break;
        }
      }
    }
  }

  return undefined;
}

function watch_scriptable() {
  if(!isDefined(self.target)) {
    return;
  }

  var0 = getscriptablearray(self.target, "targetname");

  if(isDefined(var0[0])) {
    if(debug()) {}

    var0[0] waittill("death");
    screens_delete();
    var1 = getarraykeys(level.screens.screens_flagged);

    foreach(var3 in var1) {
      foreach(var5 in level.screens.screens_flagged[var3]) {
        if(self == var5) {
          level.screens.screens_flagged[var3] = scripts\engine\utility::array_remove(level.screens.screens_flagged[var3], self);
          return;
        }
      }
    }

    return;
  }
}

function debug() {
  if(getdvarint("debug_screens") > 0) {
    return true;
  }

  return false;
}

function set_screens_to_red() {}

function screens_debug_counter() {
  jumpiftrue(debug()) LOC_00000009;
  return;
}

function screens_wait_for_flag(var0) {
  if(!scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_init(var0);
  }

  for(;;) {
    scripts\engine\utility::flag_wait(var0);

    if(debug()) {
      iprintln(level.screens.screens_flagged[var0].size + " flagged screens activated: " + var0);
    }

    if(!istrue(level.screens_off_test)) {
      if(isDefined(level.screens_think_func)) {
        scripts\engine\utility::array_thread(level.screens.screens_flagged[var0], level.screens_think_func);
      } else {
        scripts\engine\utility::array_thread(level.screens.screens_flagged[var0], &screens_think);
      }
    }

    scripts\engine\utility::flag_waitopen(var0);

    if(debug()) {
      iprintln(level.screens.screens_flagged[var0].size + " flagged screens deactivated: " + var0);
    }

    if(!istrue(level.screens_off_test)) {
      scripts\engine\utility::array_thread(level.screens.screens_flagged[var0], &screens_delete);
    }
  }
}