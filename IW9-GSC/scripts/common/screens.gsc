/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\screens.gsc
***********************************************/

init() {
  setdvarifuninitialized("debug_screens", 0);
  waitframe();
  level.screens = spawnStruct();
  level.screens.screens = scripts\engine\utility::getStructArray("screens_system", "script_noteworthy");

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

  if(isDefined(level.screens_think_func))
    scripts\engine\utility::array_thread(level.screens.screens, level.screens_think_func);
  else
    scripts\engine\utility::array_thread(level.screens.screens, ::screens_think);
}

group_by_flag() {
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.screens.screens_flagged[self.script_flag])) {
      level.screens.screens_flagged[self.script_flag] = [];
      level thread screens_wait_for_flag(self.script_flag);
    }

    level.screens.screens_flagged[self.script_flag] = scripts\engine\utility::array_add(level.screens.screens_flagged[self.script_flag], self);
    level.screens.screens = scripts\engine\utility::array_remove(level.screens.screens, self);
  }
}

screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }
  self endon("death");
  screens_create();
  state = get_state();

  if(isDefined(state))
    do_state(state);
  else
    screens_fixed();
}

do_state(state) {
  self endon("death");

  if(issubstr(state, "screen")) {
    childthread screens_fixed(state);
    return;
  }

  switch (state) {
    case "fixed":
      if(debug()) {}

      childthread screens_fixed();
      break;
    case "flip":
      if(debug()) {}

      childthread screens_flip();
      break;
    case "fliprnd":
      if(debug()) {}

      childthread screens_fliprnd();
      break;
    case "static":
      if(debug()) {}

      childthread screens_static();
      break;
    case "red":
      if(debug()) {}

      childthread screens_red();
      break;
    case "bink":
      if(debug()) {}

      childthread screens_bink();
      break;
    case "alertflip":
      if(debug()) {}

      childthread screens_alertflip();
      break;
  }
}

screens_create() {
  self.screen_model = spawn("script_model", self.origin);
  self.screen_model.angles = self.angles;
  self.screen_model setModel(self.script_modelname);
  self.screen_model hideallparts();
  get_screens();
}

screens_damage_think() {
  self.screen_model setCanDamage(1);
  self.screen_model waittill("damage");
  self notify("stop_screens");
  self.screen_model delete();
}

screens_delete() {
  self.state = "off";
  self notify("stop_screens");

  if(isDefined(self.screen_model))
    self.screen_model delete();

  delete_screens();
}

screens_fixed(_id_1F32425DEF6F7B2E) {
  if(!isDefined(self.screens_fixed) && !isDefined(_id_1F32425DEF6F7B2E)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_fixed");

  if(isDefined(_id_1F32425DEF6F7B2E))
    screen = _id_1F32425DEF6F7B2E;
  else
    screen = "screen_fixed" + (randomint(self.screens_fixed.size) + 1);

  if(debug()) {
    _id_0C926D15B7DA67BE = screen;

    if(isDefined(_id_1F32425DEF6F7B2E))
      _id_0C926D15B7DA67BE = "override " + _id_0C926D15B7DA67BE;
  }

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);

  if(isDefined(self.screens_widget) && !isDefined(_id_1F32425DEF6F7B2E)) {
    if(randomint(3) == 0) {
      screen = "screen_widget" + (randomint(self.screens_widget.size) + 1);
      self.screen_model showpart(screen);
    }
  }
}

screens_static() {
  if(!isDefined(self.screens_static)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_static");
  screen = "screen_static" + (randomint(self.screens_static.size) + 1);

  if(debug()) {}

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

screens_flip() {
  if(!isDefined(self.screens_flip)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_flip");
  _id_E689AFA1A3E3D500 = randomint(self.screens_flip.size) + 1;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = _id_E689AFA1A3E3D500; _id_AC0E594AC96AA3A8 < self.screens_flip.size + 1; _id_AC0E594AC96AA3A8++) {
      delay = 3;
      screen = "screen_flip" + _id_AC0E594AC96AA3A8;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait(delay);
    }

    _id_E689AFA1A3E3D500 = 1;
  }
}

screens_fliprnd() {
  if(!isDefined(self.screens_fliprnd)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_fliprnd");
  _id_E689AFA1A3E3D500 = randomint(self.screens_fliprnd.size) + 1;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = _id_E689AFA1A3E3D500; _id_AC0E594AC96AA3A8 < self.screens_fliprnd.size + 1; _id_AC0E594AC96AA3A8++) {
      delay = randomfloatrange(1.5, 4);
      screen = "screen_fliprnd" + _id_AC0E594AC96AA3A8;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait(delay);
    }

    _id_E689AFA1A3E3D500 = 1;
  }
}

screens_bink() {
  if(!isDefined(self.screens_bink)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_bink");
  screen = "screen_bink" + (randomint(self.screens_bink.size) + 1);

  if(debug()) {}

  self.state = "on";
  self.screen_model hideallparts();
  self.screen_model showpart(screen);
}

screens_red() {
  if(!isDefined(self.screens_red)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_red");
  self.reversed = 0;
  _id_E689AFA1A3E3D500 = randomint(self.screens_red.size) + 1;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self.screens_red.size + 1; _id_AC0E594AC96AA3A8++) {
      delay = randomfloatrange(0.25, 0.5);

      if(randomint(6) == 0 && !self.reversed) {
        self.reversed = 1;

        if(_id_AC0E594AC96AA3A8 <= 2)
          _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + self.screens_red.size;

        _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 - 2;
        delay = 0.1;
      } else
        self.reversed = 0;

      screen = "screen_red" + _id_AC0E594AC96AA3A8;

      if(debug()) {}

      self.state = "on";
      self.screen_model hideallparts();
      self.screen_model showpart(screen);
      wait(delay);
    }

    _id_E689AFA1A3E3D500 = 1;
  }
}

screens_alertflip() {
  if(!isDefined(self.screens_alertflip)) {
    return;
  }
  self endon("stop_screens");
  self endon("stop_screens_alertflip");
  self.screen_model hideallparts();

  for(;;) {
    delay = randomfloatrange(0.5, 1);

    if(debug()) {}

    self.state = "on";
    self.screen_model hidepart("screen_alertflip1");
    self.screen_model showpart("screen_alertflip2");
    wait(delay);
    self.screen_model showpart("screen_alertflip1");
    self.screen_model hidepart("screen_alertflip2");
    wait(delay);
  }
}

get_screens() {
  parts = getnumparts(self.screen_model.model);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < parts; _id_AC0E594AC96AA3A8++) {
    _id_1080D6BB12D6A0D6 = getpartname(self.screen_model.model, _id_AC0E594AC96AA3A8);

    if(issubstr(_id_1080D6BB12D6A0D6, "screen_")) {
      if(issubstr(_id_1080D6BB12D6A0D6, "screen_red")) {
        if(!isDefined(self.screens_red))
          self.screens_red = [];

        self.screens_red = scripts\engine\utility::array_add(self.screens_red, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_fixed")) {
        if(!isDefined(self.screens_fixed))
          self.screens_fixed = [];

        self.screens_fixed = scripts\engine\utility::array_add(self.screens_fixed, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_static")) {
        if(!isDefined(self.screens_static))
          self.screens_static = [];

        self.screens_static = scripts\engine\utility::array_add(self.screens_static, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_fliprnd")) {
        if(!isDefined(self.screens_fliprnd))
          self.screens_fliprnd = [];

        self.screens_fliprnd = scripts\engine\utility::array_add(self.screens_fliprnd, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_flip")) {
        if(!isDefined(self.screens_flip))
          self.screens_flip = [];

        self.screens_flip = scripts\engine\utility::array_add(self.screens_flip, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_bink")) {
        if(!isDefined(self.screens_bink))
          self.screens_bink = [];

        self.screens_bink = scripts\engine\utility::array_add(self.screens_bink, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_alertflip")) {
        if(!isDefined(self.screens_alertflip))
          self.screens_alertflip = [];

        self.screens_alertflip = scripts\engine\utility::array_add(self.screens_alertflip, _id_1080D6BB12D6A0D6);
        continue;
      }

      if(issubstr(_id_1080D6BB12D6A0D6, "screen_widget")) {
        if(!isDefined(self.screens_widget))
          self.screens_widget = [];

        self.screens_widget = scripts\engine\utility::array_add(self.screens_widget, _id_1080D6BB12D6A0D6);
      }
    }
  }
}

delete_screens() {
  if(isDefined(self.screens_red))
    self.screens_red = [];

  if(isDefined(self.screens_fixed))
    self.screens_fixed = [];

  if(isDefined(self.screens_static))
    self.screens_static = [];

  if(isDefined(self.screens_flip))
    self.screens_flip = [];

  if(isDefined(self.screens_fliprnd))
    self.screens_fliprnd = [];

  if(isDefined(self.screens_bink))
    self.screens_bink = [];

  if(isDefined(self.screens_alertflip))
    self.screens_alertflip = [];

  if(isDefined(self.screens_widget))
    self.screens_widget = [];
}

get_state() {
  if(isDefined(self.script_parameters)) {
    _id_67F14F8315CB0F2F = strtok(self.script_parameters, " ");

    foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
      if(issubstr(_id_E921CD2D3FB29B66, "screen"))
        return _id_E921CD2D3FB29B66;
    }

    foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
      if(issubstr(_id_E921CD2D3FB29B66, "state")) {
        switch (_id_E921CD2D3FB29B66) {
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

watch_scriptable() {
  if(!isDefined(self.target)) {
    return;
  }
  scriptables = getscriptablearray(self.target, "targetname");

  if(isDefined(scriptables[0])) {
    if(debug()) {}

    scriptables[0] waittill("death");
    screens_delete();
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      foreach(screen in level.screens.screens_flagged[key]) {
        if(self == screen) {
          level.screens.screens_flagged[key] = scripts\engine\utility::array_remove(level.screens.screens_flagged[key], self);
          return;
        }
      }
    }
  }
}

debug() {
  if(getdvarint("debug_screens") > 0)
    return 1;

  return 0;
}

set_screens_to_red() {}

screens_debug_counter() {
  if(!debug()) {
    return;
  }
  for(;;) {
    _id_F7AA19C560BECEA9 = 0;
    _id_EC0E4105BDC56E33 = 0;
    keys = getarraykeys(level.screens.screens_flagged);

    foreach(key in keys) {
      _id_EC0E4105BDC56E33 = _id_EC0E4105BDC56E33 + level.screens.screens_flagged[key].size;

      foreach(screen in level.screens.screens_flagged[key]) {
        if(isDefined(screen.state) && screen.state == "on")
          _id_F7AA19C560BECEA9 = _id_F7AA19C560BECEA9 + 1;
      }
    }

    foreach(screen in level.screens.screens) {
      if(isDefined(screen.state) && screen.state == "on")
        _id_F7AA19C560BECEA9 = _id_F7AA19C560BECEA9 + 1;
    }

    _id_49F11CB535C18FD1 = level.screens.screens.size + _id_EC0E4105BDC56E33;
    waitframe();
  }
}

screens_wait_for_flag(flag) {
  if(!scripts\engine\utility::flag_exist(flag))
    scripts\engine\utility::flag_init(flag);

  for(;;) {
    scripts\engine\utility::flag_wait(flag);

    if(debug())
      iprintln(level.screens.screens_flagged[flag].size + " flagged screens activated: " + flag);

    if(!istrue(level.screens_off_test)) {
      if(isDefined(level.screens_think_func))
        scripts\engine\utility::array_thread(level.screens.screens_flagged[flag], level.screens_think_func);
      else
        scripts\engine\utility::array_thread(level.screens.screens_flagged[flag], ::screens_think);
    }

    scripts\engine\utility::flag_waitopen(flag);

    if(debug())
      iprintln(level.screens.screens_flagged[flag].size + " flagged screens deactivated: " + flag);

    if(!istrue(level.screens_off_test))
      scripts\engine\utility::array_thread(level.screens.screens_flagged[flag], ::screens_delete);
  }
}