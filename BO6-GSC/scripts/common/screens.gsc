/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\screens.gsc
**************************************/

#using scripts\engine\utility;
#namespace screens;

function init() {
  setdvarifuninitialized(@ "debug_screens", 0);
  waitframe();
  level.screens = spawnStruct();
  level.screens.screens = utility::getStructArray("n\xaet_\xb8\x1a\xfe\x9f\xd4\xbf\a\xfd\x7f\xe9", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  if(!isDefined(level.screens.screens) || level.screens.screens.size <= 0) {
    return;
  }

  level.screens.screens_flagged = [];
  level thread screens_debug_counter();

  foreach(screen in level.screens.screens) {
    screen.state = "\xf8\x88m";
    screen group_by_flag();
    screen thread watch_scriptable();
  }

  if(isDefined(level.screens_think_func)) {
    utility::array_thread(level.screens.screens, level.screens_think_func);
    return;
  }

  utility::array_thread(level.screens.screens, &screens_think);
}

function group_by_flag() {
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.screens.screens_flagged[self.script_flag])) {
      level.screens.screens_flagged[self.script_flag] = [];
      level thread screens_wait_for_flag(self.script_flag);
    }

    level.screens.screens_flagged[self.script_flag][level.screens.screens_flagged[self.script_flag].size] = self;
    level.screens.screens = arrayremove(level.screens.screens, self);
  }
}

function screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  screens_create();
  state = get_state();

  if(isDefined(state)) {
    do_state(state);
    return;
  }

  screens_fixed();
}

function do_state(state) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(issubstr(state, "\x15PV!\x95?")) {
    childthread screens_fixed(state);
    return;
  }

  switch (state) {
    case #"hash_8fc81026b8b609d9":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x24>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_fixed();
      break;
    case #"hash_f4b6b015232fe2c6":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x34>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_flip();
      break;
    case #"hash_21d2e67993db5d96":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x43>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_fliprnd();
      break;
    case #"hash_b196217e12b52a9b":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x55>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_static();
      break;
    case #"hash_97430f6c58e61cbc":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x66>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_red();
      break;
    case #"hash_8c1dea2ed75f68af":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x74>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_bink();
      break;
    case #"hash_c217e57b0068891a":
      if(debug()) {
        print3d(self.origin + (0, 0, 1.5), "<dev string:x83>", (1, 1, 1), 1, 0.1, 2000);
      }

      childthread screens_alertflip();
      break;
  }
}

function screens_create() {
  self.screen_model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
  self.screen_model.angles = self.angles;
  self.screen_model setModel(self.script_modelname);
  self.screen_model hideallparts();
  get_screens();
}

function screens_damage_think() {
  self.screen_model setCanDamage(1);
  self.screen_model waittill("\fU`\xc0y\x95");
  self notify("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self.screen_model delete();
}

function screens_delete() {
  self.state = "\xf8\x88m";
  self notify("u\xeb\xc7\xa8J\x7f:48\xb9\x859");

  if(isDefined(self.screen_model)) {
    self.screen_model delete();
  }

  delete_screens();
}

function screens_fixed(screen_override) {
  if(!isDefined(self.screens_fixed) && !isDefined(screen_override)) {
    return;
  }

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("w\x1c~dO\xd1\xc6e\xe0S\xb8N\x93\xee\\\x8cA1");

  if(isDefined(screen_override)) {
    screen = screen_override;
  } else {
    screen = "\x9d0%#\xaa(|\x9a\x9e\xaf$\xd2" + randomint(self.screens_fixed.size) + 1;
  }

  if(debug()) {
    display_screen = screen;

    if(isDefined(screen_override)) {
      display_screen = "\xe0`\x8b\x18=t\x91\x9b\x03" + display_screen;
    }

    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "\xb8\"";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);

  if(isDefined(self.screens_widget) && !isDefined(screen_override)) {
    if(randomint(3) == 0) {
      screen = "\f\xe6\xb3J\xc4\xecw\xc8\xa1T\x9f\x15H" + randomint(self.screens_widget.size) + 1;
      self.screen_model showpart(screen);
    }
  }
}

function screens_static() {
  if(!isDefined(self.screens_static)) {
    return;
  }

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("\xb5BW;\x9f\xb7\xce\xf9r=9\x89\xacYB\xbc6\xccQ");
  screen = "\x1b\x86\x14\xf0A/\xf0Q\x8f\x8d\xe8;\x19" + randomint(self.screens_static.size) + 1;

  if(debug()) {
    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "\xb8\"";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

function screens_flip() {
  if(!isDefined(self.screens_flip)) {
    return;
  }

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("\x95\xfd\xb8a\a\x1eLN\x16R\xe9\xc7\xd2\x94\xdd\xfd\x18");

  for(start_screen = randomint(self.screens_flip.size) + 1; true; start_screen = 1) {
    for(i = start_screen; i < self.screens_flip.size + 1; i++) {
      delay = 3;
      screen = "&\x18\xf9B\xdd\xb7/ `[j" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "\xb8\"";
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

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("cm4\xf3\x8a\xe6{\x1a\xfe\xd4\xceQ\xd1\xf7\xfa\x11\xa01\x15\xd3");

  for(start_screen = randomint(self.screens_fliprnd.size) + 1; true; start_screen = 1) {
    for(i = start_screen; i < self.screens_fliprnd.size + 1; i++) {
      delay = randomfloatrange(1.5, 4);
      screen = "\x0e\x89s\xc2\xf5\x16F@D4\x8d\x0f\xbe1" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "\xb8\"";
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

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("\x05A\x8dCR\xe3\x19\xa3j\xb5a|&%$\x1d\xd8");
  screen = "]\xd9P\\!\xf3U\x9a[\x18\xb8" + randomint(self.screens_bink.size) + 1;

  if(debug()) {
    print3d(self.origin, screen, (1, 1, 1), 1, 0.1, 1000);
  }

  self.state = "\xb8\"";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

function screens_red() {
  if(!isDefined(self.screens_red)) {
    return;
  }

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("\x05\xa1&\x9f\xd5\xc9\x15\xe48\xb3I\x9e\x15\xd5\xf7#");
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

      screen = "s\xb1\x93\xacV\xe6_r\xca\x91" + i;

      if(debug()) {
        print3d(self.origin, screen, (1, 1, 1), 1, 0.1, int(delay / 0.05));
      }

      self.state = "\xb8\"";
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

  self endon("u\xeb\xc7\xa8J\x7f:48\xb9\x859");
  self endon("\x14\x13\xdf\xc8NO\xe1\xb5P7\xe0X\xf5'\xc2\x83\x9d \xf4\xee\xf5N");
  self.screen_model hideallparts();

  while(true) {
    delay = randomfloatrange(0.5, 1);

    if(debug()) {
      print3d(self.origin, "<dev string:x97>", (1, 1, 1), 1, 0.1, int(delay / 0.05));
    }

    self.state = "\xb8\"";
    self.screen_model hidepart("\x0f\xd3Q`\xd4\x1eD\xc3\xea\xc4\xa3\x8e\x89\xd1\x81P\x13");
    self.screen_model showpart("\x19\x8c\x9bT\"\xcb\x83\xbe]&\xacZ\x12\xd1\xa2\x15\xae");
    wait delay;
    self.screen_model showpart("\x0f\xd3Q`\xd4\x1eD\xc3\xea\xc4\xa3\x8e\x89\xd1\x81P\x13");
    self.screen_model hidepart("\x19\x8c\x9bT\"\xcb\x83\xbe]&\xacZ\x12\xd1\xa2\x15\xae");
    wait delay;
  }
}

function get_screens() {
  parts = getnumparts(self.screen_model.model);

  for(i = 0; i < parts; i++) {
    part_name = getpartname(self.screen_model.model, i);

    if(issubstr(part_name, "?\xd8\xea\x85w\xf4\x8c")) {
      if(issubstr(part_name, "s\xb1\x93\xacV\xe6_r\xca\x91")) {
        if(!isDefined(self.screens_red)) {
          self.screens_red = [];
        }

        self.screens_red[self.screens_red.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "\x9d0%#\xaa(|\x9a\x9e\xaf$\xd2")) {
        if(!isDefined(self.screens_fixed)) {
          self.screens_fixed = [];
        }

        self.screens_fixed[self.screens_fixed.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "\x1b\x86\x14\xf0A/\xf0Q\x8f\x8d\xe8;\x19")) {
        if(!isDefined(self.screens_static)) {
          self.screens_static = [];
        }

        self.screens_static[self.screens_static.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "\x0e\x89s\xc2\xf5\x16F@D4\x8d\x0f\xbe1")) {
        if(!isDefined(self.screens_fliprnd)) {
          self.screens_fliprnd = [];
        }

        self.screens_fliprnd[self.screens_fliprnd.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "&\x18\xf9B\xdd\xb7/ `[j")) {
        if(!isDefined(self.screens_flip)) {
          self.screens_flip = [];
        }

        self.screens_flip[self.screens_flip.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "]\xd9P\\!\xf3U\x9a[\x18\xb8")) {
        if(!isDefined(self.screens_bink)) {
          self.screens_bink = [];
        }

        self.screens_bink[self.screens_bink.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "Y\xf3|\xba\xaet\xceb\xcf\xa8|cJ\x04\x12u")) {
        if(!isDefined(self.screens_alertflip)) {
          self.screens_alertflip = [];
        }

        self.screens_alertflip[self.screens_alertflip.size] = part_name;
        continue;
      }

      if(issubstr(part_name, "\f\xe6\xb3J\xc4\xecw\xc8\xa1T\x9f\x15H")) {
        if(!isDefined(self.screens_widget)) {
          self.screens_widget = [];
        }

        self.screens_widget[self.screens_widget.size] = part_name;
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
    tokens = strtok(self.script_parameters, "\xda");

    foreach(token in tokens) {
      if(issubstr(token, "\x15PV!\x95?")) {
        return token;
      }
    }

    foreach(token in tokens) {
      if(issubstr(token, "\xa3\xe3\x93C\xfc")) {
        switch (token) {
          case #"hash_b69937ed5fc0dda7":
            return "\xf7\xb0a]\xc4";
          case #"hash_61d72a335da10598":
            return "V<\x92\xf3";
          case #"hash_b30cc7411319f81c":
            return "\xb1WDy9{)";
          case #"hash_f872b3e5dcf09621":
            return "\xfd\xfe\x9a\x16>C";
          case #"hash_b2c7cbae5e07461a":
            return "\x9b\x9b\v";
          case #"hash_df190818a771f549":
            return "\x1d(\x81@";
          case #"hash_d32cec26f4e68bfc":
            return "\xdc\xf4.\xf9\x84@>\xfd\x99";
          default:
            assertmsg("<dev string:xae>" + token);
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

  scriptables = getscriptablearray(self.target, #targetname);

  if(isDefined(scriptables[0])) {
    if(debug()) {
      print3d(self.origin + (0, 0, 3), "<dev string:xc1>", (1, 1, 1), 1, 0.1, 10000);
    }

    scriptables[0] waittill("\x1e\xfd\xd1\xa2\a");
    screens_delete();
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      foreach(screen in level.screens.screens_flagged[key]) {
        if(self == screen) {
          level.screens.screens_flagged[key] = arrayremove(level.screens.screens_flagged[key], self);
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
    flagged_screens = 0;
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      flagged_screens += level.screens.screens_flagged[key].size;

      foreach(screen in level.screens.screens_flagged[key]) {
        if(isDefined(screen.state) && screen.state == "\xb8\"") {
          active_screens += 1;
        }
      }
    }

    foreach(screen in level.screens.screens) {
      if(isDefined(screen.state) && screen.state == "\xb8\"") {
        active_screens += 1;
      }
    }

    total_count = level.screens.screens.size + flagged_screens;

    printtoscreen2d(1000, 70, "<dev string:xd3>" + total_count, (1, 1, 1), 2);

    printtoscreen2d(1000, 100, "<dev string:xeb>" + active_screens, (1, 1, 1), 2);

    waitframe();
  }
}

function screens_wait_for_flag(flag) {
  if(!utility::flag_exist(flag)) {
    utility::flag_init(flag);
  }

  while(true) {
    utility::flag_wait(flag);

    if(debug()) {
      iprintln(level.screens.screens_flagged[flag].size + "\xeb\xc1\xc1 \xe7\xebA\xe1\x9a\xf5n\x14\x9a\x06\x06\xa7<q\x86\xb4\tB\xbc\x18\x1b\x01\x95\x98" + flag);
    }

    if(!istrue(level.screens_off_test)) {
      if(isDefined(level.screens_think_func)) {
        utility::array_thread(level.screens.screens_flagged[flag], level.screens_think_func);
      } else {
        utility::array_thread(level.screens.screens_flagged[flag], &screens_think);
      }
    }

    utility::flag_waitopen(flag);

    if(debug()) {
      iprintln(level.screens.screens_flagged[flag].size + "\x06\xd8<\x97q\xfc\xfc\xfe~\x17\xd8\xab\xbf\x8ch\x1a\xa0L,\xa0&\xef\xf8\xfb\xd0\xfe\xd0\xc4R\x84" + flag);
    }

    if(!istrue(level.screens_off_test)) {
      utility::array_thread(level.screens.screens_flagged[flag], &screens_delete);
    }
  }
}