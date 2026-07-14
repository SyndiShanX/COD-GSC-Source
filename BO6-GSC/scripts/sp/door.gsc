/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\door.gsc
**************************************/

#using scripts\engine\math;
#using scripts\engine\scriptable_door;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\door_ai;
#using scripts\sp\door_internal;
#using scripts\sp\player\cursor_hint;
#namespace door_sp;

function init() {
  level.player notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "\xa8\x94\xb5Ls\x10");
  level.player notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "\x18\xf77d\x8e\\\x1fjq\xbd(");
  level.player notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "_\x05\xd7\xb5\xed\r\xdb'<\x98\xd0\x01\xbf");

  if(!isDefined(level.interactive_doors)) {
    level.interactive_doors = spawnStruct();
  }

  level.interactive_doors.ents = [];
  level.interactive_doors.got_hint = 0;
  level.interactive_doors.close_prompt = 0;
  level.interactive_doors.close_check = 1;
  level.interactive_doors.process_damage = 0;
  level.interactive_doors.fndoorinit = &door_internal::init_door_internal;
  level.interactive_doors.fnshoulddogesture = &door_internal::should_do_gesture;
  level.interactive_doors.gesture_door = "\xe5\x12s\xe5|lpR\x87i\xf6\x06tH\x18p.\xd4Hub\xaa\x1e\xefA";
  level.interactive_doors.gesture_door_hard = "\x8f\xa3\xa9g\xa8[\x1f\xbb\xff\xb80\xcd\x14\xe4\xf9\xe2}\xfe\xae\x0fk\xcb\xe8\xe7\x19|_9@\x96";
  level.interactive_doors.gesture_window = "avq\xda*V'\af\xebz\"\xf7\xa8\x17!\x91\xd8\x89\xe4\xce\x02\xe9&\x85\xe9F6\xf5";
  level.interactive_doors.count = 0;
  level.interactive_doors.fnunlockdoor = &unlock_door;
  level.interactive_doors.hint_dist_scale = 1;

  if(isDefined(level.door_hint_dist_scale)) {
    level.interactive_doors.hint_dist_scale = level.door_hint_dist_scale;
  }

  setdvarifuninitialized(@ "hash_6985e82f27803483", 0);

  setdvarifuninitialized(@ "hash_e4715899ce74d8ee", 0);

  utility::flag_init("p\xf9q\xacW\x06C\xa6\xc8m$\xb9\"\xc6\xc6M\x87\xfd\xba");
  utility::flag_init("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93");
  utility::flag_init("b\xa7-l\xd1\xf68U\xfc,v");
  utility::flag_init("\xd7]T\x18\xa0\x10\"\v\f\b\x10\xca\xd6");
  utility::flag_init("\x02\xd7\xfa\x8a*L\xb3(c\xcam\xc8\xc4\xba\xb0)\x16/\xa8/\x91N\x1cs\x02\xe0%g\x89%.\xc4");
  utility::flag_init("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
  utility::flag_init("X\xca\xe6\xa6\xfdQ\xc7\x16v\x16E\xfd\x05\x86\xeaA\xf3J\x86\xb0O");
  utility_sp::add_hint_string("W\xc9\xaf\f\xd3\xdb\xc1\x9c\xa4>(", &"script/door_hint_bash");
  utility_sp::add_hint_string("\xd6\xaeN+\xa5@\xbe\f\fr\xcf$\xbfm\n\xb6\x9c?Q@", &"script/door_hint_obstructed");
  level thread scriptable_door::system_init();
  level.player thread door_internal::door_watch_unresolved_collision_count();
  level.player thread function_f3d425933f41aa70();
  door::init();
  thread door_internal::door_post_load();
  windowstructs = utility::getStructArray("\xb8O\xda\xb1\t\xbe\xce\xfat\xb4\xbc\x9f\xb8TO>\xbb\xc3", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  utility::array_thread(windowstructs, &door_internal::init_window);
}

function function_4e1d4b63c253589c(suspicious) {
  if(!isDefined(level.interactive_doors)) {
    level.interactive_doors = spawnStruct();
  }

  level.interactive_doors.var_1c2fb6a9190a2421 = suspicious;
}

function function_1c2fb6a9190a2421() {
  return isDefined(level.interactive_doors) && istrue(level.interactive_doors.var_1c2fb6a9190a2421);
}

function function_78297e920c634b99(use_gesture) {
  if(!isDefined(level.interactive_doors)) {
    level.interactive_doors = spawnStruct();
  }

  level.interactive_doors.var_e0494ec0b55af688 = use_gesture;
}

function function_e0494ec0b55af688() {
  return isDefined(level.interactive_doors) && istrue(level.interactive_doors.var_e0494ec0b55af688);
}

function function_5a4135a6a658032(require_use) {
  if(!isDefined(level.interactive_doors)) {
    level.interactive_doors = spawnStruct();
  }

  level.interactive_doors.door_bash_requires_use = require_use;
}

function bash_requires_use() {
  return isDefined(level.interactive_doors) && istrue(level.interactive_doors.door_bash_requires_use);
}

function get_interactive_door(targetname) {
  utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
  doors = [];

  foreach(door in level.interactive_doors.ents) {
    if(isDefined(door.targetname) && door.targetname == targetname) {
      doors[doors.size] = door;
    }
  }

  if(!doors.size) {
    return undefined;
  }

  assert(doors.size == 1, "<dev string:x24>" + targetname + "<dev string:x51>");

  if(doors.size == 1) {
    return doors[0];
  }
}

function get_interactive_door_array(targetname) {
  utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
  doors = [];

  foreach(door in level.interactive_doors.ents) {
    if(!isDefined(door.targetname)) {
      continue;
    }

    if(door.targetname != targetname) {
      continue;
    }

    doors[doors.size] = door;
  }

  if(!doors.size) {
    return [];
  }

  return doors;
}

function unlock_all_doors(allowopening) {
  utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");

  foreach(door in level.interactive_doors.ents) {
    if(door.locked) {
      door unlock_door(allowopening);
    }
  }
}

function unlock_door(allowopening, openent, var_840e2995e7b6511d) {
  if(isDefined(allowopening) && !allowopening) {
    return;
  }

  self notify("\xbe,\x9f\x94_\x87k\xa7u\xd8\x1e\x13\x85\x9d\xaf:\xba*");
  self notify("\xc8\xdb\xdbN\xfa]\xcdc\xb7\xb1\xd6");
  self.locked = 0;
  self.lockedforai = 0;

  if(door_is_open()) {
    return;
  }

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct remove_open_interact_hint();
    self.open_struct.no_open_interact = undefined;

    if(isDefined(openent)) {
      thread door_ajar(openent, var_840e2995e7b6511d);
      thread door_internal::monitor_door_push();
    } else {
      self.open_struct utility::delaythread(0.05, &door_internal::open_struct_logic);
      self.open_struct utility::delaythread(0.05, &door_internal::refresh_open_struct);
    }
  }

  clear_navobstacle();

  if(isDefined(self.doubledoorother) && self.doubledoorother.locked) {
    self.doubledoorother unlock_door(allowopening);
  }
}

function lock_door() {
  self notify("\xbe,\x9f\x94_\x87k\xa7u\xd8\x1e\x13\x85\x9d\xaf:\xba*");
  self notify("\x0e \x90\xd8=a\xe0\x1f$");
  self.locked = 1;
  self.lockedforai = 1;

  if(isDefined(self.unlock_volume) && !istrue(self.unlock_volume.active)) {
    self.unlock_volume thread door_internal::unlock_volume_logic();
  }

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct utility::delaythread(0.05, &door_internal::open_struct_logic);
  }

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
    self.navobstacle = undefined;
  }

  create_navobstacle();

  if(isDefined(self.doubledoorother) && !self.doubledoorother.locked) {
    self.doubledoorother lock_door();
  }
}

function init_max_yaws() {
  door_internal::get_max_yaw(1);
  door_internal::get_max_yaw(0);
  utility::ent_flag_set("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd");
}

function remove_open_ability() {
  println("<dev string:x70>" + self getentnum() + "<dev string:xa0>" + self.origin);
  self notify("F\xcd\x0f\x9d\x05=(r\xed\x9b\x19\x0fv\x16l\xc6\xe1");
  self notify("M\xa2\xf9\xb2\xbc\xf5\xcc@\x817\x1c\xb4\x80^<\xb5c");
  remove_open_prompts();
}

function should_open_left(angles, opener) {
  if(!isDefined(opener)) {
    opener = isDefined(self.opener) ? self.opener : level.player;
  }

  open_left = undefined;
  origin = self.origin;

  if(!isDefined(angles)) {
    angles = vectortoangles(self.forward);
  }

  if(isDefined(self.pivot_ent)) {
    origin = self.pivot_ent.origin;
    angles = self.pivot_ent.angles;
  }

  right = anglestoright(angles);
  normal = vectorNormalize(opener.origin - origin);
  dot = vectordot(right, normal);

  if(dot > 0) {
    return 1;
  }

  return 0;
}

function create_open_interact_hint(custom_hint_text) {
  hint_text = custom_hint_text;

  if(!isDefined(hint_text)) {
    hint_text = self.custom_hint_text;

    if(!isDefined(hint_text)) {
      if(self.door door_internal::door_bashable_by_player(1)) {
        hint_text = &"script/door_hint_use";
      } else {
        hint_text = &"script/door_hint_use_no_bash";
      }
    }
  }

  if(!isDefined(self.cursor_hint_ent)) {
    if(!istrue(self.no_open_interact)) {
      cursor_hint::create_cursor_hint(undefined, (0, 0, 0), hint_text, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
      self.cursor_hint_ent setusewhenhandsoccupied(1);
      self.cursor_hint_ent.door = self.door;
    }
  } else if(!utility_sp::in_realism_mode()) {
    self.cursor_hint_ent setHintString(hint_text);
  }

  if(isDefined(level.interactive_doors.var_851437213af94971)) {
    [[level.interactive_doors.var_851437213af94971]](self, custom_hint_text);
  }

  if(isDefined(custom_hint_text)) {
    self.custom_hint_text = custom_hint_text;
  }
}

function remove_open_interact_hint() {
  assert(isstruct(self), "<dev string:xa8>");

  if(isDefined(self.cursor_hint_ent)) {
    cursor_hint::remove_cursor_hint();
    self.custom_hint_text = undefined;
    self.cursor_hint_ent = undefined;
  }

  self.no_open_interact = 1;
}

function door_ajar(opener, var_840e2995e7b6511d) {
  if(isDefined(self.door_ajar_custom_func)) {
    [[self.door_ajar_custom_func]]();
  }

  self.ajar = 1;

  self.debug_activity = "<dev string:xd7>";

  if(isDefined(self.ajar_opener)) {
    opener = self.ajar_opener;
  } else if(!isDefined(opener)) {
    opener = level.player;
  }

  if(isPlayer(opener) && !isDefined(var_840e2995e7b6511d)) {
    door_internal::stealth_broadcast("G\xa0>\a\x83\xca\xf8\xdeF\xbf1", opener, 40);
  }

  self notify("\xc9\x98\x04\x94\x9fw\xa7");
  self.opener = opener;

  if(isDefined(var_840e2995e7b6511d)) {
    self.open_left = var_840e2995e7b6511d;
  } else {
    self.open_left = should_open_left();
  }

  door_internal::set_pivot_point(self.open_left);

  if(isDefined(self.ajar_opener)) {
    self.opener = undefined;
  }

  if(isDefined(self.script_spawn_open_yaw)) {
    self.pivot_ent.angles += (0, self.script_spawn_open_yaw, 0);
    self notify("X5,\x9c");

    if(self.script_spawn_open_yaw > 0) {
      self.hinge_side = "L&\"y\xa0|\xb1\x9dI";
      self.open_left = 1;
    } else {
      self.hinge_side = "Nf\xf9\xc9VsI\x92VL";
      self.open_left = 0;
    }

    return;
  }

  time = 1.5;
  yaw_angle = 9;

  if(isDefined(self.script_forceyaw)) {
    yaw_angle = self.max_yaw_left;
  }

  if(!self.open_left) {
    if(isDefined(self.script_forceyaw)) {
      yaw_angle = self.max_yaw_right;
    }

    yaw_angle *= -1;
  }

  doororigin = door_internal::get_door_bottom_center();

  if(distancesquared(level.player.origin, doororigin) < 10000) {
    level.player playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  }

  var_f40ec9f42c68168f = door_internal::get_door_audio_material();
  alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\x9f\xbe\x8b\x86\xa9\xb1@$\xa0L";

  if(soundexists(alias)) {
    playsoundatpos(self.origin + (0, 0, 42), alias);
  }

  self.pivoting = 1;
  self.pivot_ent rotateYaw(yaw_angle, time, time * 0.25, time * 0.75);
  thread utility_sp::notify_delay("X5,\x9c", time);
  wait time;
  self.pivoting = undefined;
}

function get_door_angles() {
  if(isDefined(self.pivot_ent)) {
    return self.pivot_ent.angles;
  }

  return self.true_start_angles;
}

function angle_diff(value1, value2) {
  diff = angleclamp180(value1 - value2);
  return diff;
}

function door_bash_open(opener, bashtime) {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(istrue(self.bashed_full)) {
    return;
  }

  if(istrue(self.bash_opening)) {
    return;
  }

  if(!isDefined(opener)) {
    opener = level.player;
  }

  self.opener = opener;

  if(opener == level.player && door_internal::function_e0e17b36200bbd2(self)) {
    door_internal::bashed_locked_door(level.player getvelocity());
    return;
  }

  self.bash_opening = 1;

  if(!utility::flag("b\xa7-l\xd1\xf68U\xfc,v")) {
    utility::flag_set("b\xa7-l\xd1\xf68U\xfc,v");
  }

  self notify("\xc9\x98\x04\x94\x9fw\xa7");
  thread remove_open_prompts();
  self.open_left = should_open_left();
  door_internal::set_pivot_point(self.open_left);

  if(opener == level.player) {
    thread door_internal::door_bash_presentation();
    level.player notify("b\xa7-l\xd1\xf68U\xfc,v", self);

    if(!self.bashed && !self.was_opened_halfway) {
      thread door_internal::suspicious_door_stealth_check(1);
    }
  } else {
    self notify("\x85i_o8\xca\xdc\x952");
  }

  openscale = 1;

  if(isDefined(self.bashscale) && self.bashscale < 1) {
    openscale = self.bashscale;
  }

  self.bashed = 1;
  self notify("\xb4\x8b~\xec\x8b\xfb", opener);
  bash_yaw = door_internal::get_bash_yaw(openscale);

  if(openscale == 1 && !istrue(self.bashblocked)) {
    self notify("]\x87\xd9\xb9\xc7\x1f}\x1dX\x84\x81");
    self.bashed_full = 1;
  }

  anglediff = bash_yaw - self.true_start_angles[1];

  if(!isDefined(bashtime)) {
    if(openscale == 1) {
      minbashtime = 0.25;
      maxbashtime = 0.5;
    } else {
      minbashtime = 0.4;
      maxbashtime = 0.75;
    }

    timefactor = math::normalize_value(0, 170, abs(anglediff));
    bashtime = math::factor_value(minbashtime, maxbashtime, timefactor);
  }

  self.bashtime = bashtime;
  current_angles = get_door_angles();
  open_angles = (current_angles[0], bash_yaw, current_angles[2]);

  self.debug_activity = "<dev string:xdf>" + self.opener getentitynumber() + "<dev string:xe7>" + bash_yaw;

  var_f40ec9f42c68168f = door_internal::get_door_audio_material();
  alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xb3\xaex4\x96";

  if(soundexists(alias)) {
    playsoundatpos(self.origin + (0, 0, 30), alias);
  }

  self.pivoting = 1;

  if(openscale == 1) {
    self.pivot_ent rotateTo(open_angles, bashtime);
  } else {
    self.pivot_ent rotateTo(open_angles, bashtime, 0, bashtime);
  }

  thread utility_sp::notify_delay("o\x1ce\xb9", bashtime);
  wait bashtime;
  self.opener notify("\xb1)\x12s/\xea\x86\xbfy\x8c\xe8");
  thread updatenavobstacle();
  door_internal::updatenodelookpeek();

  if(opener == level.player) {
    eventradius = 450;

    if(isDefined(level.var_bcaae13bc8183d53)) {
      eventradius = level.var_bcaae13bc8183d53;
    }

    if(isDefined(level.stealth)) {
      thread door_internal::stealth_broadcast("\x8c& 0gM$\xa5\x8f<", level.player, eventradius);
    } else {
      thread door_internal::combat_getinfoinradius(eventradius);
    }
  }

  if(openscale == 1 && abs(anglediff) > 100 && !istrue(self.disable_bounceback)) {
    self playSound("Rk\xe8\xd8\x1c&\t\xaf\xffP\xfd\t\xcb");
    self.active = 0;
    bounceback_time = randomfloatrange(3, 5);
    bounceback_yaw = self.open_left ? -3 : 3;
    alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xbcP\xdb:(\x8f\xff\x05\xc5";

    if(soundexists(alias)) {
      self playLoopSound(alias);
    }

    self scalevolume(0, bounceback_time);
    self.pivot_ent rotateTo(open_angles + (0, bounceback_yaw, 0), bounceback_time, 0.5, bounceback_time - 0.5);
    wait bounceback_time;
    self stoploopsound();
    thread updatenavobstacle();
  } else {
    wait 0.05;
  }

  if(!istrue(self.closing)) {
    self.pivoting = undefined;
    thread door_internal::close_prompt();
  }

  self.bash_opening = undefined;
  self.bashblocked = undefined;
}

function remove_open_prompts() {
  self.open_struct remove_open_interact_hint();
}

function door_rotate(opener, yaw_angle, time) {
  if(istrue(self.open_complete)) {
    return;
  }

  if(!isDefined(self.pivot_ent)) {
    if(isDefined(opener)) {
      self.opener = opener;
      self.ajar_opener = opener;
    }

    self notify("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
    remove_open_prompts();

    while(!isDefined(self.pivot_ent)) {
      wait 0.05;
    }
  }

  if(!self.open_left) {
    yaw_angle *= -1;
  }

  self.pivot_ent rotateYaw(yaw_angle, time, time * 0.25, time * 0.75);
  remove_open_prompts();
}

function door_open_completely(opener, time) {
  utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
  self notify("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
  self notify("F\xcd\x0f\x9d\x05=(r\xed\x9b\x19\x0fv\x16l\xc6\xe1");
  self notify("\xb4\x02\xdf\xdd$g\x06|f\xc3\xa7\xfe");
  self notify("\xbe,\x9f\x94_\x87k\xa7u\xd8\x1e\x13\x85\x9d\xaf:\xba*");
  self notify("\xc9\x98\x04\x94\x9fw\xa7");
  self endon("\x8b\r\xcf\x06Q\xc7[\x98Z\xbc-\x02\x88~TI\xbdp\x8d\x11QH\x1bE\x0f\xa1\x9a\xb3\xc4H\x13");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  remove_open_prompts();
  self.open_completely = 1;

  if(!utility::flag("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93") && isDefined(opener) && opener == level.player) {
    utility::flag_set("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93");
  }

  if(isDefined(opener)) {
    self.opener = opener;
  }

  self notify("\xe5\xed\x90\x19\xefB\xbc\n>r\x91\xbb:\xdc\xf9\xe9<", opener);
  var_49146a6181e4c628 = isPlayer(opener) ? 1 : 0;

  if(isai(self.opener)) {
    self notify("\x85i_o8\xca\xdc\x952");
  }

  if(isDefined(opener) || !isDefined(self.open_left)) {
    self.open_left = should_open_left();
  }

  door_internal::set_pivot_point(self.open_left);
  max_yaw = undefined;

  if(self.open_left) {
    max_yaw = self.true_start_angles[1] + self.max_yaw_left;
  } else {
    max_yaw = self.true_start_angles[1] - self.max_yaw_right;
  }

  if(isDefined(self.opener) && isent(self.opener)) {
    self.debug_activity = "<dev string:xdf>" + self.opener getentitynumber() + "<dev string:xff>" + max_yaw;
  }

  var_f40ec9f42c68168f = door_internal::get_door_audio_material();
  alias = isPlayer(opener) ? "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xd9\xd5\x02y\x91\x1cQ\xba\xac\xe9" : "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xa9\xe4R\x90?\xf2i1r\xed\xf2'V\x8e";

  if(soundexists(alias)) {
    playsoundatpos(self.origin + (0, 0, 42), alias);
  }

  self.pivoting = 1;

  if(!isDefined(time)) {
    time = 1.5;
  }

  if(time < 0.05) {
    self.pivot_ent.angles = (self.angles[0], max_yaw, self.angles[2]);
  } else {
    if(time > 0.05) {
      accel = time * 0.25;
      decel = time * 0.75;

      if(!var_49146a6181e4c628) {
        accel = 0;
      }
    } else {
      accel = 0;
      decel = 0;
    }

    self.pivot_ent rotateTo((self.angles[0], max_yaw, self.angles[2]), time, accel, decel);
  }

  self notify("\xa6\xed\nm\x93\x999x\x87\xe9[{\x1b\x9e\x13");
  thread utility_sp::notify_delay("o\x1ce\xb9", time);

  if(isDefined(self.opener)) {
    self.opener notify("\xb1)\x12s/\xea\x86\xbfy\x8c\xe8");
  }

  if(time >= 0.05) {
    wait time;
  }

  self.pivoting = undefined;
  thread door_internal::suspicious_door_stealth_check(var_49146a6181e4c628);
  thread updatenavobstacle();
  door_internal::updatenodelookpeek();
  self.active = 0;

  if(var_49146a6181e4c628) {
    door_internal::stealth_broadcast("G\xa0>\a\x83\xca\xf8\xdeF\xbf1", level.player, 128);
  }

  thread door_internal::close_prompt();
}

function door_close(user, time = 1.5, accel = 0.375, decel = 0.375, bclosedoubledoor = 0) {
  self notify("\xc4\x87W\x9a=\x9bGM\xb0\xd9");

  if(isDefined(self.doubledoorother) && istrue(bclosedoubledoor)) {
    self.doubledoorother thread _door_close(user, time, accel, decel);
  }

  _door_close(user, time, accel, decel);
}

function private _door_close(user, time, accel, decel) {
  if(!isDefined(self.pivot_ent)) {
    return;
  }

  var_f40ec9f42c68168f = door_internal::get_door_audio_material();

  if(isDefined(var_f40ec9f42c68168f)) {
    alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xbc\x06\xd8z}\x9c";

    if(soundexists(alias)) {
      playsoundatpos(self.origin + (0, 0, 42), alias);
    }
  }

  self.closing = 1;
  self.pivoting = 1;
  self.pivot_ent rotateTo((self.angles[0], self.true_start_angles[1], self.angles[2]), time, accel, decel);
  wait time;
  self.pivoting = undefined;
  self.closing = undefined;
  thread updatenavobstacle();
  door_internal::updatenodelookpeek();
  door_internal::suspicious_door_stealth_check(0);
}

function reset_door() {
  self notify("\xa6\xed\nm\x93\x999x\x87\xe9[{\x1b\x9e\x13");
  self notify("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");

  if(isDefined(self.pivot_ent)) {
    self.pivot_ent.angles = (self.pivot_ent.angles[0], self.true_start_angles[1], self.pivot_ent.angles[2]);
  }

  thread updatenavobstacle();
  door_internal::suspicious_door_stealth_check(0);
  utility::flag_clear("b\xa7-l\xd1\xf68U\xfc,v");
  utility::flag_clear("\xd7]T\x18\xa0\x10\"\v\f\b\x10\xca\xd6");
  utility::flag_clear("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93");
  self.var_5cd93ffbade05706 = undefined;
  self thread[[level.interactive_doors.fndoorinit]](1);
}

function updatenavobstacle(bforce) {
  if(isDefined(self.updatingnavobstacle)) {
    return;
  }

  waitframe();
  self.updatingnavobstacle = 1;

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
    println("<dev string:x11d>" + self.doorid + "<dev string:x151>" + self.origin);
  }

  if(istrue(self.locked) && isDefined(self.clip)) {
    clear_navobstacle();
    create_navobstacle();
  } else if(istrue(self.bashed_full) || istrue(self.open_completely) || istrue(bforce)) {
    if(isDefined(self.clip)) {
      self.navobstacle = createnavbadplacebyent(self.clip, 14);
    }

    if(isDefined(self.navobstacle)) {
      println("<dev string:x161>" + self.doorid + "<dev string:x151>" + self.origin);
    } else {
      println("<dev string:x18e>");
      line((0, 0, 0), self.origin, (1, 0, 0), 1, 0, 100);
    }

    doorangles = get_door_angles();
    self.nav_lastupdatetime = gettime();
    self.nav_lastupdateangle = doorangles[1];
  }

  self.updatingnavobstacle = undefined;
}

function clear_navobstacle() {
  if(!isDefined(self.navobstacleid)) {
    return;
  }

  destroynavobstacle(self.navobstacleid);
  self.navobstacleid = undefined;

  if(isDefined(level.stealth) && isDefined(self.opener) && self.opener == level.player) {
    door_internal::suspicious_door_stealth_check(1);
  }
}

function create_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    return;
  }

  switch (self.team) {
    case #"hash_5f54b9bf7583687f":
      self.navobstacleid = createnavbadplacebyent(self.clip, "?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1", "\xba\xa5\x1f\xc9m\x80i");
      break;
    case #"hash_7c2d091e6337bf54":
      self.navobstacleid = createnavbadplacebyent(self.clip, "O\x15\x1b\xad\x9ff", "\x8c\x1b\xab)\xd1", "\xba\xa5\x1f\xc9m\x80i");
      break;
    case #"hash_a571cacc018623b8":
      self.navobstacleid = createnavbadplacebyent(self.clip, "?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1", "O\x15\x1b\xad\x9ff");
      break;
    case #"hash_24b14065e10b1f8d":
      self.navobstacleid = createnavbadplacebyent(self.clip, "?\xb1\xc0\x9a", "O\x15\x1b\xad\x9ff", "\xba\xa5\x1f\xc9m\x80i");
      break;
    case #"hash_8e26538d066f6ebb":
    case #"hash_e5078707e2696229":
      self.navobstacleid = createnavbadplacebyent(self.clip, "O\x15\x1b\xad\x9ff", "\x8c\x1b\xab)\xd1");
      break;
    default:
      self.navobstacleid = createnavobstaclebyent(self.clip);
      break;
  }
}

function delete_door() {
  self notify("\x83\xa2\x0f\x16\b%>\xb0");
  remove_open_ability();

  if(isDefined(self.clip_nosight)) {
    self.clip_nosight delete();
  }

  if(self.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
    self.clip delete();
  }

  if(isDefined(self.pivot_ent)) {
    self.pivot_ent delete();
  }

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
    self.navmodifer = undefined;
    println("<dev string:x1b2>" + self getentitynumber() + "<dev string:x151>" + self.origin);
  }

  if(isDefined(self.linked_ents)) {
    foreach(ent in self.linked_ents) {
      ent delete();
    }

    self.linked_ents = [];
  }

  level.interactive_doors.ents = arrayremove(level.interactive_doors.ents, self);
  self delete();
}

function get_all_bashable_doors() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(!door utility::ent_flag("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd")) {
      continue;
    }

    if(door.bashed || door.open_completely || door.breached || door door_internal::door_is_half_open()) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_doors_ai_should_open() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(!door utility::ent_flag("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd")) {
      continue;
    }

    if(door.bashed || door.open_completely || door.breached || door door_internal::door_is_open_at_least(60)) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_closed_doors() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(door.bashed || door.ajar || door.open_completely || door.breached) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_interactive_doors() {
  return level.interactive_doors.ents;
}

function function_f6d6d983d0dc1194(entity) {
  return arraycontains(level.interactive_doors.ents, entity);
}

function get_all_interactive_doors_blocking_paths(team) {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(isDefined(door.navobstacleid) && !issubstr(door.team, team)) {
      a[a.size] = door;
    }
  }

  return a;
}

function bash_monitor() {
  self notify("\x15.\x14\x98\xd1h\xac\xe5\x95j \xfe");
  self endon("\x15.\x14\x98\xd1h\xac\xe5\x95j \xfe");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("F\xcd\x0f\x9d\x05=(r\xed\x9b\x19\x0fv\x16l\xc6\xe1");
  level.player thread function_aedf2c5fa9041063();

  while(true) {
    waitframe();

    if(bash_door_isplayerclose()) {
      canbash = door_internal::door_bashable_by_player();

      if(isDefined(self.open_struct.cursor_hint_ent)) {
        if(self.open_struct.cursorhintstring == &"script/door_hint_use" && !canbash) {
          self.open_struct.cursorhintstring = &"script/door_hint_use_no_bash";
          self.open_struct.cursor_hint_ent setHintString(self.open_struct.cursorhintstring);
        } else if(self.open_struct.cursorhintstring == &"script/door_hint_use_no_bash" && canbash) {
          self.open_struct.cursorhintstring = &"script/door_hint_use";
          self.open_struct.cursor_hint_ent setHintString(self.open_struct.cursorhintstring);
        }
      }

      if(canbash && door_internal::should_bash_open()) {
        self notify("\xb7\xc9\x92\x8fZ|\x17\xb4\xa6\xbe\xdf0", level.player);
        thread door_bash_open();

        if(!self.locked) {
          return;
        }
      }
    }
  }
}

function function_aedf2c5fa9041063() {
  self notify("\xdd\xbb5\xe2\x8d\x97\xeak\xce\x0f\b\xb6\xf3H\xd7\xf1");
  self endon("\xdd\xbb5\xe2\x8d\x97\xeak\xce\x0f\b\xb6\xf3H\xd7\xf1");
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player.var_91b19092698a5e84 = undefined;

  while(true) {
    player waittill("qynX\xfd\xe1\x85\xf0\xd8k\x1d\x9f_X\xa2\xee2");
    player.var_91b19092698a5e84 = gettime();
    wait 0.1;
    player.var_91b19092698a5e84 = undefined;
  }
}

function interact_door_ispushentclose() {
  pushent = door_internal::get_pushent();
  z = abs(pushent.origin[2] - self.origin[2]);

  if(z < 20) {
    endpoint = door_internal::interact_door_get_endpoint();
    d = distancesquared(pushent.origin, endpoint);

    if(d < pushent door_internal::function_91f50279890cbda3()) {
      return true;
    }
  }

  return false;
}

function interact_door_dopusheffects() {
  z = abs(level.player.origin[2] - self.origin[2]);

  if(z < 20) {
    endpoint = door_internal::interact_door_get_endpoint();
    d = distancesquared(level.player.origin, endpoint);

    if(d < 14400) {
      return true;
    }
  }

  return false;
}

function interact_door_isplayerfacing() {
  endpoint = door_internal::interact_door_get_endpoint();
  closest_point = pointonsegmentnearesttopoint(endpoint, self.origin, level.player.origin);
  door_dir = vectorNormalize(closest_point - level.player.origin);
  player_dir = anglesToForward(level.player.angles);

  if(vectordot(door_dir, player_dir) > 0.7) {
    return true;
  }

  return false;
}

function bash_door_isplayerclose() {
  now = gettime();

  if(now >= (self.bashclosenext ?? 0)) {
    self.bashclose = undefined;
    endpoint = self.doorbottomcenter;

    if(!isDefined(endpoint)) {
      endpoint = self.origin;
    }

    d = distancesquared(level.player.origin, endpoint);
    z = abs(level.player.origin[2] - self.origin[2]);

    if(z < 20) {
      range = self.locked == 1 ? 60 : 60;

      if(d < range * range) {
        self.bashclose = 1;
      }
    }

    if(d < 10000) {
      self.bashclosenext = 0;
    } else if(d < 90000) {
      self.bashclosenext = now + 250;
    } else if(d < 1000000) {
      self.bashclosenext = now + 500;
    } else {
      self.bashclosenext = now + randomintrange(750, 1250);
    }
  }

  return istrue(self.bashclose);
}

function function_e3dc42ee4d94f40b() {
  utility::flag_wait("\x02\xd7\xfa\x8a*L\xb3(c\xcam\xc8\xc4\xba\xb0)\x16/\xa8/\x91N\x1cs\x02\xe0%g\x89%.\xc4");
  other_door = undefined;

  if(!isDefined(self.doubledoorother)) {
    close_doors = utility_sp::get_within_range(self.origin, level.interactive_doors.ents, 100);

    if(close_doors.size > 0) {
      var_73f92256d0c9d118 = [];

      foreach(close_door in close_doors) {
        if(close_door != self && !isDefined(close_door.doubledoorother)) {
          var_73f92256d0c9d118[var_73f92256d0c9d118.size] = close_door;
        }
      }

      if(var_73f92256d0c9d118.size > 0) {
        endpoint = door_internal::interact_door_get_endpoint();
        var_73f92256d0c9d118 = utility_sp::function_b2b8b8abf81b417e(self.origin, endpoint, var_73f92256d0c9d118, 0);

        if(var_73f92256d0c9d118.size > 0) {
          other_door = sortbydistance(var_73f92256d0c9d118, endpoint)[0];
          thread double_doors_init(self, other_door);
        }
      }
    }
  }
}

function double_doors_init_targetname(targetname) {
  door_main = get_interactive_door(targetname);
  door_other = get_interactive_door(targetname + " \xe0\x96\xd0\xf9\x1e");
  return double_doors_init(door_main, door_other);
}

function double_doors_init(door_main, door_other) {
  doors = [];
  doors[0] = door_main;
  doors[1] = door_other;
  thread double_doors_init_thread(door_main, door_other);
  return doors;
}

function double_doors_init_thread(door_main, door_other) {
  door_main notify("d\xfe\xadK/\xde\x15\xe9\xfb\x97\xd1\xfe\x97\xe6\x85V\x9f\xfa\xb58\xa6\x9b\xf4\xe2");
  door_other notify("d\xfe\xadK/\xde\x15\xe9\xfb\x97\xd1\xfe\x97\xe6\x85V\x9f\xfa\xb58\xa6\x9b\xf4\xe2");
  door_main endon("d\xfe\xadK/\xde\x15\xe9\xfb\x97\xd1\xfe\x97\xe6\x85V\x9f\xfa\xb58\xa6\x9b\xf4\xe2");
  door_other endon("d\xfe\xadK/\xde\x15\xe9\xfb\x97\xd1\xfe\x97\xe6\x85V\x9f\xfa\xb58\xa6\x9b\xf4\xe2");
  door_main.doubledoorother = door_other;
  door_other.doubledoorother = door_main;
  waittillframeend();
  doors[0] = door_main;
  doors[1] = door_other;
  door_main.doubledoors = doors;
  door_main thread door_internal::double_doors_waittill_interact();
  door_main thread door_internal::double_doors_waittill_bashed();
  door_main thread door_internal::double_doors_hint_pos(door_other);
  door_main thread door_internal::double_doors_waittill_open_completely();
  door_other remove_open_prompts();
  door_other.doubledoors = doors;
  door_other thread door_internal::double_doors_waittill_bashed();
  door_other thread door_internal::double_doors_waittill_open_completely();

  if(door_other.locked && isDefined(door_other.unlock_volume)) {
    door_other notify("\x90L\x0e\xde\x89Z\xdcN\xab\xaf\xbb\x1a\xbc;^\xc8\xd8S\xfa");
    door_other.unlock_volume thread door_internal::unlock_volume_logic();
  }

  return door_main.doubledoors;
}

function door_is_open() {
  angle_diff = angle_diff(get_door_angles()[1], self.true_start_angles[1]);

  if(abs(angle_diff) > 0) {
    return true;
  }

  return false;
}

function ai_monitor_doors() {
  self endon("\x1e\xfd\xd1\xa2\a");

  thread door_ai::function_80260d52e7e24ff0();

  while(true) {
    result = utility::waittill_any_return("n\x95\xf0x[\x10\xc7\xb9\xb1\xda\xaes\xd3", "\xb1)\x12s/\xea\x86\xbfy\x8c\xe8", "R\x1f\xa8\xd6\x01\xc0\xf0T\x95\xa4\xb6\xd9]\xf8\xe4\\\x02", "pQ\xcf\x05r\xe1<\xb7\xf7\xc4c\x1f\x952Oj");
    utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
    self notify("\x1f\x1cqU\xa8\xdf\x13%N\xf5\"P\xbf\xee\x885:");

    if(istrue(self.isopeningdoor)) {
      continue;
    }

    if(isDefined(self.waitingfordoor)) {
      if(isDefined(result) && result == "\"}nLZ\x9b\xb7w" && isDefined(self.doornode) && isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.doornode.origin) < 4) {
        continue;
      }

      door_ai::stop_waiting_for_door();
    }

    door_ai::remove_as_opener();
    var_2eff0f6abe212502 = 0;
    doorloc = undefined;
    possibledoor = undefined;

    while(true) {
      doorloc = self getmodifierlocationonpath("\xe2\xc0Qo");

      if(isDefined(doorloc)) {
        possibledoor = door_ai::get_closed_door_closest_to_nav_modifier(doorloc);

        if(isDefined(possibledoor)) {
          doororigin = possibledoor door_internal::get_door_bottom_center();

          if(distancesquared(self.origin, doororigin) < 400) {
            var_26fb733dad7884eb = vectorNormalize(doororigin - self.origin);

            if(vectordot(self.lookaheaddir, var_26fb733dad7884eb) < -0.707) {
              wait 2;
              continue;
            }
          }

          self notify("<dev string:x1df>", "<dev string:x1ed>");

          var_2eff0f6abe212502 = 1;
          break;
        } else {
          wait 0.2;
          continue;
        }
      } else {
        break;
      }

      if(var_2eff0f6abe212502) {
        break;
      }

      wait 0.05;
    }

    if(!var_2eff0f6abe212502) {
      continue;
    }

    door_ai::door_add_opener(possibledoor);
    possibledoor thread door_ai::door_manage_openers();
  }
}

function add_pushent(ent) {
  if(!isDefined(self.pushents)) {
    self.pushents = [];
  }

  self.pushents[self.pushents.size] = ent;
}

function private function_f3d425933f41aa70() {
  self endon("\x1e\xfd\xd1\xa2\a");
  time_interval = 1;
  var_cee248cdfd4614e2 = pow(528 * time_interval, 2);

  while(true) {
    last_pos = self.origin;
    wait time_interval;

    if(distancesquared(self.origin, last_pos) > var_cee248cdfd4614e2) {
      self notify(":V\xd8\xac8\xf6\xc9Ge2");
    }
  }
}