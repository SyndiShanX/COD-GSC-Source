/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\screens.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace screens;

function init() {
  setdvarifuninitialized(@ "debug_screens", 0);
  waitframe();
  level.screens = spawnStruct();
  level.screens.screens = getStructArray("screens_system", "script_noteworthy");

  if(!isDefined(level.screens.screens) || level.screens.screens.size <= 0) {
    return;
  }

  level.screens.screens_flagged = [];
  level thread screens_debug_counter();

  foreach(screen in level.screens.screens) {
    screen.state = "off";
    screen group_by_flag();
    screen thread watch_scriptable();
  }

  if(isDefined(level.screens_think_func)) {
    array_thread(level.screens.screens, level.screens_think_func);
    return;
  }

  array_thread(level.screens.screens, &screens_think);
}

function group_by_flag() {
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.screens.screens_flagged[self.script_flag])) {
      level.screens.screens_flagged[self.script_flag] = [];
      level thread screens_wait_for_flag(self.script_flag);
    }

    level.screens.screens_flagged[self.script_flag] = array_add(level.screens.screens_flagged[self.script_flag], self);
    level.screens.screens = array_remove(level.screens.screens, self);
  }
}

function screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }

  self endon("death");
  screens_create();
  state = get_state();

  if(isDefined(state)) {
    do_state(state);
    return;
  }

  screens_fixed();
}

function do_state(state) {
  self endon("death");

  if(issubstr(state, "screen")) {
    childthread screens_fixed(state);
    return;
  }

  switch (state) {
    case #"hash_8fc81026b8b609d9":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x1c>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_fixed();
      break;
    case #"hash_f4b6b015232fe2c6":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x29>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_flip();
      break;
    case #"hash_21d2e67993db5d96":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x35>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_fliprnd();
      break;
    case #"hash_b196217e12b52a9b":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x44>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_static();
      break;
    case #"hash_97430f6c58e61cbc":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x52>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_red();
      break;
    case #"hash_8c1dea2ed75f68af":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x5d>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_bink();
      break;
    case #"hash_c217e57b0068891a":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x69>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_alertflip();
      break;
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

function screens_fixed(screen_override) {
  if(!isDefined(self.screens_fixed) && !isDefined(screen_override)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_fixed");

  if(isDefined(screen_override)) {
    screen = screen_override;
  } else {
    screen = "screen_fixed" + randomint(self.screens_fixed.size) + 1;
  }

  if(debug()) {
    display_screen = screen;

    if(isDefined(screen_override)) {
      display_screen = "override " + display_screen;
    }

    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);

  if(isDefined(self.screens_widget) && !isDefined(screen_override)) {
    if(randomint(3) == 0) {
      screen = "screen_widget" + randomint(self.screens_widget.size) + 1;
      self.screen_model showpart(screen);
    }
  }
}

function screens_static() {
  if(!isDefined(self.screens_static)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_static");
  screen = "screen_static" + randomint(self.screens_static.size) + 1;

  if(debug()) {
    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

function screens_flip() {
  if(!isDefined(self.screens_flip)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_flip");

  for(start_screen = randomint(self.screens_flip.size) + 1; true; start_screen = 1) {
    for(i = start_screen; i < self.screens_flip.size + 1; i++) {
      delay = 3;
      screen = "screen_flip" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait delay;
    }
  }
}

function screens_fliprnd() {
  if(!isDefined(self.screens_fliprnd)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_fliprnd");

  for(start_screen = randomint(self.screens_fliprnd.size) + 1; true; start_screen = 1) {
    for(i = start_screen; i < self.screens_fliprnd.size + 1; i++) {
      delay = randomfloatrange(1.5, 4);
      screen = "screen_fliprnd" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait delay;
    }
  }
}

function screens_bink() {
  if(!isDefined(self.screens_bink)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_bink");
  screen = "screen_bink" + randomint(self.screens_bink.size) + 1;

  if(debug()) {
    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

function screens_red() {
  if(!isDefined(self.screens_red)) {
    return;
  }

  self endon("stop_screens");
  self endon("stop_screens_red");
  self.reversed = 0;

  for(start_screen = randomint(self.screens_red.size) + 1; true; start_screen = 1) {
    for(i = 1; i < self.screens_red.size + 1; i++) {
      delay = randomfloatrange(0.25, 0.5);

      if(randomint(6) == 0 && !self.reversed) {
        self.reversed = 1;

        if(i <= 2) {
          i += self.screens_red.size;
        }

        i -= 2;
        delay = 0.1;
      } else {
        self.reversed = 0;
      }

      screen = "screen_red" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait delay;
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

  while(true) {
    delay = randomfloatrange(0.5, 1);

    if(debug()) {
      print3d(self.origin, "<dev string:x7a>", (1, 1, 1), 1, 0.1, int(delay / 0.05));
    }

    self.state = "on";
    self.screen_model hidepart("screen_alertflip1");
    self.screen_model showpart("screen_alertflip2");
    wait delay;
    self.screen_model showpart("screen_alertflip1");
    self.screen_model hidepart("screen_alertflip2");
    wait delay;
  }
}

function get_screens() {
  parts = getnumparts(self.screen_model.model);

  for(i = 0; i < parts; i++) {
    part_name = getpartname(self.screen_model.model, i);

    if(issubstr(part_name, "screen_")) {
      if(issubstr(part_name, "screen_red")) {
        if(!isDefined(self.screens_red)) {
          self.screens_red = [];
        }

        self.screens_red = array_add(self.screens_red, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_fixed")) {
        if(!isDefined(self.screens_fixed)) {
          self.screens_fixed = [];
        }

        self.screens_fixed = array_add(self.screens_fixed, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_static")) {
        if(!isDefined(self.screens_static)) {
          self.screens_static = [];
        }

        self.screens_static = array_add(self.screens_static, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_fliprnd")) {
        if(!isDefined(self.screens_fliprnd)) {
          self.screens_fliprnd = [];
        }

        self.screens_fliprnd = array_add(self.screens_fliprnd, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_flip")) {
        if(!isDefined(self.screens_flip)) {
          self.screens_flip = [];
        }

        self.screens_flip = array_add(self.screens_flip, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_bink")) {
        if(!isDefined(self.screens_bink)) {
          self.screens_bink = [];
        }

        self.screens_bink = array_add(self.screens_bink, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_alertflip")) {
        if(!isDefined(self.screens_alertflip)) {
          self.screens_alertflip = [];
        }

        self.screens_alertflip = array_add(self.screens_alertflip, part_name);
        continue;
      }

      if(issubstr(part_name, "screen_widget")) {
        if(!isDefined(self.screens_widget)) {
          self.screens_widget = [];
        }

        self.screens_widget = array_add(self.screens_widget, part_name);
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
  }
}

function get_state() {
  if(isDefined(self.script_parameters)) {
    tokens = strtok(self.script_parameters, " ");

    foreach(token in tokens) {
      if(issubstr(token, "screen")) {
        return token;
      }
    }

    foreach(token in tokens) {
      if(issubstr(token, "state")) {
        switch (token) {
          case #"hash_b69937ed5fc0dda7":
            return "fixed";
          case #"hash_61d72a335da10598":
            return "flip";
          case #"hash_b30cc7411319f81c":
            return "fliprnd";
          case #"hash_f872b3e5dcf09621":
            return "static";
          case #"hash_b2c7cbae5e07461a":
            return "red";
          case #"hash_df190818a771f549":
            return "bink";
          case #"hash_d32cec26f4e68bfc":
            return "alertflip";
          default:
            assertmsg("Invalid state! " + token);
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

  scriptables = getscriptablearray(self.target, "targetname");

  if(isDefined(scriptables[0])) {
    if(debug()) {
      print3d(self.origin + (0, 0, 3), "<dev string:x8e>", (1, 1, 1), 1, 0.1, 10000);
    }

    scriptables[0] waittill("death");
    screens_delete();
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      foreach(screen in level.screens.screens_flagged[key]) {
        if(self == screen) {
          level.screens.screens_flagged[key] = array_remove(level.screens.screens_flagged[key], self);
          return;
        }
      }
    }
  }
}

function debug() {
  if(getdvarint(@ "debug_screens") > 0) {
    return true;
  }

  return false;
}

function set_screens_to_red() {}

function screens_debug_counter() {
  if(!debug()) {
    return;
  }

  while(true) {
    active_screens = 0;
    var_ec0e4105bdc56e33 = 0;
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      var_ec0e4105bdc56e33 += level.screens.screens_flagged[key].size;

      foreach(screen in level.screens.screens_flagged[key]) {
        if(isDefined(screen.state) && screen.state == "on") {
          active_screens += 1;
        }
      }
    }

    foreach(screen in level.screens.screens) {
      if(isDefined(screen.state) && screen.state == "on") {
        active_screens += 1;
      }
    }

    total_count = level.screens.screens.size + var_ec0e4105bdc56e33;

    printtoscreen2d(1000, 70, "<dev string:x9d>" + total_count, (1, 1, 1), 2);

    printtoscreen2d(1000, 100, "<dev string:xb2>" + active_screens, (1, 1, 1), 2);

    waitframe();
  }
}

function screens_wait_for_flag(flag) {
  if(!flag_exist(flag)) {
    flag_init(flag);
  }

  while(true) {
    flag_wait(flag);

    if(debug()) {
      iprintln(level.screens.screens_flagged[flag].size + " flagged screens activated: " + flag);
    }

    if(!istrue(level.screens_off_test)) {
      if(isDefined(level.screens_think_func)) {
        array_thread(level.screens.screens_flagged[flag], level.screens_think_func);
      } else {
        array_thread(level.screens.screens_flagged[flag], &screens_think);
      }
    }

    flag_waitopen(flag);

    if(debug()) {
      iprintln(level.screens.screens_flagged[flag].size + " flagged screens deactivated: " + flag);
    }

    if(!istrue(level.screens_off_test)) {
      array_thread(level.screens.screens_flagged[flag], &screens_delete);
    }
  }
}