/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\elevator.gsc
***************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace elevator;

function init() {
  if(getDvar(@ "hash_74714610a987a982") == "\x87") {
    return;
  }

  elevator_groups = getEntArray("%H\xe2\x88\a\xb5|\x1b\xbf~\x96\x83\xc6\xf5", #targetname);

  if(!isDefined(elevator_groups)) {
    return;
  }

  if(!elevator_groups.size) {
    return;
  }

  precachestring(&"elevator_call_hint");
  precachestring(&"elevator_use_hint");
  precachestring(&"elevator_floor_select_hint");
  thread elevator_update_global_dvars();
  level.elevators = [];
  level.elevator_callbutton_link_v = elevator_get_dvar_int(@ "scr_elevator_callbutton_link_v", "rl");
  level.elevator_callbutton_link_h = elevator_get_dvar_int(@ "scr_elevator_callbutton_link_h", "\x1aew");
  build_elevators();
  position_elevators();
  elevator_call();

  if(!level.elevators.size) {
    return;
  }

  foreach(elevator in level.elevators) {
    elevator thread elevator_think();
    elevator thread elevator_sound_think();
  }

  thread elevator_debug();
}

function elevator_update_global_dvars() {
  while(true) {
    level.elevator_accel = elevator_get_dvar(@ "scr_elevator_accel", "\xa2\xa1,");
    level.elevator_decel = elevator_get_dvar(@ "scr_elevator_decel", "\xa2\xa1,");
    level.elevator_music = elevator_get_dvar_int(@ "scr_elevator_music", "\x87");
    level.elevator_speed = elevator_get_dvar_int(@ "scr_elevator_speed", "rl");
    level.elevator_innerdoorspeed = elevator_get_dvar_int(@ "scr_elevator_innerdoorspeed", "{z");
    level.elevator_outterdoorspeed = elevator_get_dvar_int(@ "scr_elevator_outterdoorspeed", "\xc4l");
    level.elevator_return = elevator_get_dvar_int(@ "scr_elevator_return", "\xfe");
    level.elevator_waittime = elevator_get_dvar_int(@ "scr_elevator_waittime", "\xbb");
    level.elevator_aggressive_call = elevator_get_dvar_int(@ "scr_elevator_aggressive_call", "\xfe");
    level.elevator_debug = elevator_get_dvar_int(@ "debug_elevator", "\xfe");

    if(utility::issp()) {
      level.elevator_motion_detection = elevator_get_dvar_int(@ "scr_elevator_motion_detection", "\xfe");
    } else {
      level.elevator_motion_detection = elevator_get_dvar_int(@ "scr_elevator_motion_detection", "\x87");
    }

    wait 1;
  }
}

function elevator_think() {
  elevator_fsm("\xa2\x7f\xc9");
}

function elevator_call() {
  foreach(callbutton in level.elevator_callbuttons) {
    callbutton thread monitor_callbutton();
  }
}

function floor_override(inside_trig) {
  self endon("=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb");
  self.floor_override = 0;
  self.overrider = undefined;

  while(true) {
    inside_trig waittill("\x91`\xb1\xe7T\x97>", player);
    self.floor_override = 1;
    self.overrider = player;
    break;
  }

  self notify("\x01l\xf0\x9e\x0f\x06\x957\xd0m\x82#\x82\xb4");
}

function elevator_fsm(state) {
  self.estate = state;
  door_trig = get_housing_door_trigger();
  inside_trig = get_housing_inside_trigger();

  while(true) {
    if(self.estate == "\xa2\x7f\xc9") {
      if(level.elevator_return && get_curfloor() != get_initfloor()) {
        self.moveto_floor = get_initfloor();
        thread floor_override(inside_trig);
        waittill_or_timeout("\x01l\xf0\x9e\x0f\x06\x957\xd0m\x82#\x82\xb4", level.elevator_waittime);

        if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider)) {
          get_floor(self.overrider);
        }

        self.estate = "\xdf\x8c\xe2";
        continue;
      }

      while(true) {
        if(self.moveto_floor == get_curfloor()) {
          param = inside_trig discrete_waittill("\x91`\xb1\xe7T\x97>");
        } else {
          param = "\x100\x94\x84N\x14C\x019\xf2 \x86t7\xe1";
        }

        if(isstring(param) && param == "\x100\x94\x84N\x14C\x019\xf2 \x86t7\xe1" && self.moveto_floor != get_curfloor()) {
          self.estate = "\xdf\x8c\xe2";
          break;
        }

        if(isDefined(param) && isPlayer(param) && isalive(param)) {
          istouching_trigger = param istouching(inside_trig);
          var_c12c49e1ebcd5c39 = isDefined(inside_trig.motion_trigger) && param istouching(inside_trig.motion_trigger);
          var_fe55d914d8cdc926 = istouching_trigger || var_c12c49e1ebcd5c39;

          if(var_fe55d914d8cdc926) {
            player = param;
            get_floor(player);

            if(self.moveto_floor == get_curfloor()) {
              continue;
            }

            self.estate = "\xdf\x8c\xe2";
            break;
          }
        }
      }
    }

    if(self.estate == "\xdf\x8c\xe2") {
      thread elevator_interrupt(door_trig);
      floor_num = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(floor_num);
      utility::waittill_any("\xdd\x04\x9f\x85\x929\xc6\xef>@\a\n\\\xb2A\xd5\"\x9d", "\xd4\xd3e\xf3\xc9y\t(\x8b M");

      if(self.elevator_interrupted) {
        self.estate = "\xedE\xef";
        continue;
      }

      self.estate = "a\xa5 ";
      continue;
    }

    if(self.estate == "\xedE\xef") {
      floor_num = get_curfloor();
      thread open_inner_doors();
      thread open_outer_doors(floor_num);
      self waittill("\xb1\x99\xa7\x81\xac\xcf\xfbW'\x9d\x92\x06\x90" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");

      if(self.elevator_interrupted) {
        self.estate = "\xdf\x8c\xe2";
        continue;
      }

      self.estate = "\xa2\x7f\xc9";
      continue;
    }

    if(self.estate == "a\xa5 ") {
      assert(isDefined(self.moveto_floor), "<dev string:x24>");

      if(self.moveto_floor != get_curfloor()) {
        thread elevator_move(self.moveto_floor);
        self waittill("\xb0\xefl?rJ\x80\nA`\x8a\xf7\xf7\f");
      }

      self.estate = "\xedE\xef";
      continue;
    }
  }
}

function monitor_callbutton() {
  while(true) {
    player = discrete_waittill("\x91`\xb1\xe7T\x97>");
    call_floor = undefined;
    call_elevators = [];

    foreach(linked_elevators in self.e) {
      call_floor = idx;
      call_elevators = linked_elevators;
    }

    assert(isDefined(call_floor) && isDefined(call_elevators) && call_elevators.size);
    elevator_called = 0;

    foreach(elevator in call_elevators) {
      moving = elevator elevator_floor_update();

      if(!level.elevator_aggressive_call && !moving) {
        if(elevator get_curfloor() == call_floor) {
          elevator_called = 1;
          call_elevators = [];
          break;
        }
      }
    }

    foreach(elevator in call_elevators) {
      if(elevator.estate == "\xa2\x7f\xc9") {
        elevator call_elevator(call_floor);
        elevator_called = 1;

        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(elevator_called) {
      self playSound("d2W\a\xf3v.\xcd\xed\xc6\xf7\xd0\x817");
    }
  }
}

function call_elevator(call_floor) {
  self.moveto_floor = call_floor;
  inside_trigger = get_housing_inside_trigger();
  inside_trigger notify("\x91`\xb1\xe7T\x97>", "\x100\x94\x84N\x14C\x019\xf2 \x86t7\xe1");

  if(level.elevator_motion_detection) {
    inside_trigger.motion_trigger notify("\x91`\xb1\xe7T\x97>", "\x100\x94\x84N\x14C\x019\xf2 \x86t7\xe1");
  }
}

function get_floor(player) {
  bifloor = get_outer_doorsets();

  if(bifloor.size == 2) {
    curfloor = get_curfloor();
    self.moveto_floor = !curfloor;
    return;
  }

  player setclientdvar(@ "player_current_floor", get_curfloor());

  while(true) {
    player waittill("\x9b]\xbaw\x7f:LT\x84\xad\xd4\xcd", menu, response);

    if(menu == "&z\xe2s\xb6qP\xf8\x1c\xc7\xbc0\xd7)@j]\xf1\xc7\xd3r\x9d\xab") {
      if(response != "\r+x5") {
        self.moveto_floor = int(response);
      }

      break;
    }
  }
}

function elevator_interrupt(door_trig) {
  self notify("8=xsm\x935b`\xba\xc6\x04\xe7\b\xcc");
  level notify("\rJ&U\xd7\xe3\xf4S\xf5\x10\x1bTR[0\x0f@\xed\xafqZ\"U\xb1\x97Zt\xe0\xb8\x92\xe5\x1c");
  self endon("8=xsm\x935b`\xba\xc6\x04\xe7\b\xcc");
  self endon("=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb");
  self.elevator_interrupted = 0;
  wait 0.5;
  door_trig waittill("\x91`\xb1\xe7T\x97>", player);
  self notify("\xd4\xd3e\xf3\xc9y\t(\x8b M");
  self.elevator_interrupted = 1;
}

function elevator_floor_update() {
  mainframe = get_housing_mainframe();
  cur_pos = mainframe.origin;
  moving = 1;

  foreach(idx, efloor in get_outer_doorsets()) {
    floor_pos = self.e["\x9e\x93\xa9\x84{" + idx + "\x9b;\x99?"];

    if(cur_pos == floor_pos) {
      self.e[";\xa6p{\xc1\xa9\xf4\xb1\xcb=\x88\x1f\xe5"] = idx;
      moving = 0;
    }
  }

  return moving;
}

function elevator_sound_think() {
  musak_model = get_housing_musak_model();

  if(level.elevator_music && isDefined(musak_model)) {
    musak_model playLoopSound("\xa6R\n\xccL\x9b,\xf4\xc7\xae\v\xd9E\x1b\b");
  }

  thread listen_for("\xdf\xaf\xe1\xf5\xb4^\xb5{\xe5\xf6k\xb5\x16Sn\x99\xc2\x04?");
  thread listen_for("\xf6\xc1\xb2\xe6\x96\x9b\xec}\xd2s\xdcV\xe4\xf5#\xedoNs");
  thread listen_for("\xdd\x04\x9f\x85\x929\xc6\xef>@\a\n\\\xb2A\xd5\"\x9d");
  thread listen_for("\xf3z\x98\xc8\x9fe\\\x12\x9as:a\xe5'\x01tS\xfa");

  foreach(idx, efloor in get_outer_doorsets()) {
    thread listen_for("\xb16{\xb9K\xe6\xd9\xaf3\x8d{{N\xaf" + idx + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
    thread listen_for("\b\x1de\n\x0e\xf7\x94\x93\xfd\xce}\xd0\xa7\xc9" + idx + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
    thread listen_for("\x8f\x06\xff\x9c&\x86\xe2\x1bq\xf4}\x9b\xe9" + idx + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
    thread listen_for("\xb1\x99\xa7\x81\xac\xcf\xfbW'\x9d\x92\x06\x90" + idx + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  }

  thread listen_for("\xd4\xd3e\xf3\xc9y\t(\x8b M");
  thread listen_for("=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb");
  thread listen_for("\xb0\xefl?rJ\x80\nA`\x8a\xf7\xf7\f");
}

function listen_for(msg) {
  while(true) {
    self waittill(msg);
    mainframe = get_housing_mainframe();

    if(issubstr(msg, "\xdf\xaf\xe1\xf5\xb4^\xb5{")) {
      mainframe playSound("N\x9d\xc1\xee\xaf5C$u\xd2\x05\x99\x0e\xc5$");
    }

    if(issubstr(msg, "\r\v*\x82>_\xabr")) {
      mainframe playSound("\x18W\xfe\xc1;8w\xe7\xbd\xafiC\xd6\xd6");
    }

    if(msg == "=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb") {
      mainframe playSound("V\x1b\x95\x9d}'un\xbe7\xe8a\xe4\xa3");
      mainframe playLoopSound("\x8bp\x82l-\x142\xeb<N!i<");
    }

    if(msg == "\xd4\xd3e\xf3\xc9y\t(\x8b M") {
      mainframe playSound("\xdd6s\xa9\xeaR@oU\x01M\xa0\xaf\x13\x0e\xfd\xf5\x1e");
    }

    if(msg == "\xb0\xefl?rJ\x80\nA`\x8a\xf7\xf7\f") {
      mainframe stoploopsound("\x8bp\x82l-\x142\xeb<N!i<");
      mainframe playSound("%H\xe2\x88\x18u\x14k\xbfz\xae\x06");
      mainframe playSound("d2W\a\xf3v.\xcd\xed\xc6\xf7\xd0\x817");
    }
  }
}

function position_elevators() {
  foreach(elevator in level.elevators) {
    elevator.moveto_floor = elevator get_curfloor();

    foreach(floor_num, outer_doorset in elevator get_outer_doorsets()) {
      if(elevator get_curfloor() != floor_num) {
        elevator thread close_outer_doors(floor_num);
      }
    }
  }
}

function elevator_move(floor_num) {
  self notify("=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb");
  self endon("=\x02\xca\x9d\x1b4PD\v[\xb1\xee\rB\xfb");
  mainframe = get_housing_mainframe();
  delta_vec = self.e["\x9e\x93\xa9\x84{" + floor_num + "\x9b;\x99?"] - mainframe.origin;
  speed = level.elevator_speed;
  dist = abs(distance(self.e["\x9e\x93\xa9\x84{" + floor_num + "\x9b;\x99?"], mainframe.origin));
  movetime = dist / speed;
  mainframe moveTo(mainframe.origin + delta_vec, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);

  foreach(part in get_housing_children()) {
    moveto_pos = part.origin + delta_vec;

    if(!issubstr(part.classname, "|I\x1d\x01\x93\xfe\xc0\x95")) {
      part moveTo(moveto_pos, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);
      continue;
    }

    part.origin = moveto_pos;
  }

  waittill_finish_moving(mainframe, self.e["\x9e\x93\xa9\x84{" + floor_num + "\x9b;\x99?"]);
  self notify("\xb0\xefl?rJ\x80\nA`\x8a\xf7\xf7\f");
}

function close_inner_doors() {
  self notify("\xdf\xaf\xe1\xf5\xb4^\xb5{\xe5\xf6k\xb5\x16Sn\x99\xc2\x04?");
  self endon("\xdf\xaf\xe1\xf5\xb4^\xb5{\xe5\xf6k\xb5\x16Sn\x99\xc2\x04?");
  self endon("\xf6\xc1\xb2\xe6\x96\x9b\xec}\xd2s\xdcV\xe4\xf5#\xedoNs");
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  mainframe = get_housing_mainframe();
  var_3f2c435d1f7f452f = get_housing_closedpos();
  closed_pos = (var_3f2c435d1f7f452f[0], var_3f2c435d1f7f452f[1], mainframe.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(left_door.origin, closed_pos));
  movetime = dist / speed;
  left_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("\xdd\x04\x9f\x85\x929\xc6\xef>@\a\n\\\xb2A\xd5\"\x9d");
}

function open_inner_doors() {
  self notify("\xf6\xc1\xb2\xe6\x96\x9b\xec}\xd2s\xdcV\xe4\xf5#\xedoNs");
  self endon("\xf6\xc1\xb2\xe6\x96\x9b\xec}\xd2s\xdcV\xe4\xf5#\xedoNs");
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  mainframe = get_housing_mainframe();
  var_1d5ad6c23cf4f65e = get_housing_leftdoor_opened_pos();
  var_6da670809ec95729 = get_housing_rightdoor_opened_pos();
  var_9315a08785a2fe0c = (var_1d5ad6c23cf4f65e[0], var_1d5ad6c23cf4f65e[1], mainframe.origin[2]);
  var_64dc4eb7712c14df = (var_6da670809ec95729[0], var_6da670809ec95729[1], mainframe.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(var_9315a08785a2fe0c, var_64dc4eb7712c14df) * 0.5);
  movetime = dist / speed * 0.5;
  left_door moveTo(var_9315a08785a2fe0c, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(var_64dc4eb7712c14df, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, var_9315a08785a2fe0c, right_door, var_64dc4eb7712c14df);
  self notify("\xf3z\x98\xc8\x9fe\\\x12\x9as:a\xe5'\x01tS\xfa");
}

function close_outer_doors(floor_num) {
  self notify("\xb16{\xb9K\xe6\xd9\xaf3\x8d{{N\xaf" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  self endon("\xb16{\xb9K\xe6\xd9\xaf3\x8d{{N\xaf" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  self endon("\b\x1de\n\x0e\xf7\x94\x93\xfd\xce}\xd0\xa7\xc9" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  left_door = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  var_9315a08785a2fe0c = get_outer_leftdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(var_9315a08785a2fe0c, closed_pos));
  movetime = dist / speed;
  left_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("\x8f\x06\xff\x9c&\x86\xe2\x1bq\xf4}\x9b\xe9" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
}

function open_outer_doors(floor_num) {
  level notify("\x99\xac\x95\x05\xde\xdf\xd7\xfa\x9b@j\"\x04\xc0\xdc\"\xf2\xd0g\xb2\x1c\x1e");
  self notify("\b\x1de\n\x0e\xf7\x94\x93\xfd\xce}\xd0\xa7\xc9" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  self endon("\b\x1de\n\x0e\xf7\x94\x93\xfd\xce}\xd0\xa7\xc9" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
  left_door = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  var_9315a08785a2fe0c = get_outer_leftdoor_openedpos(floor_num);
  var_64dc4eb7712c14df = get_outer_rightdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(var_9315a08785a2fe0c, closed_pos));
  movetime = dist / speed * 0.5;
  left_door moveTo(var_9315a08785a2fe0c, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(var_64dc4eb7712c14df, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, var_9315a08785a2fe0c, right_door, var_64dc4eb7712c14df);
  self notify("\xb1\x99\xa7\x81\xac\xcf\xfbW'\x9d\x92\x06\x90" + floor_num + "\xaf\xf6\xea\x8e\xb2'}Fo\xb7r\xcd");
}

function build_elevators() {
  elevator_groups = getEntArray("%H\xe2\x88\a\xb5|\x1b\xbf~\x96\x83\xc6\xf5", #targetname);
  assert(isDefined(elevator_groups) && elevator_groups.size, "<dev string:x48>");
  var_d85db71b5809552d = getEntArray("\xbc]\\\b_\xebVU\xfck\x98\xa8\xb4\xdc\xe7M", #targetname);
  assert(isDefined(var_d85db71b5809552d) && var_d85db71b5809552d.size >= elevator_groups.size, "<dev string:x76>");
  elevator_doorsets = getEntArray("\x03W\xbf\xc1\xa0\xc0\xbb\xd7\xde\x91\x96\t\xcd|J\xd9", #targetname);
  assert(isDefined(elevator_doorsets) && elevator_doorsets.size >= elevator_groups.size, "<dev string:xeb>");

  foreach(elevator_bound in elevator_groups) {
    var_52a54a8a83a2483 = getEnt(elevator_bound.target, #targetname);
    var_211c5c52a9520cbd = [];
    var_211c5c52a9520cbd[0] = min(elevator_bound.origin[0], var_52a54a8a83a2483.origin[0]);
    var_211c5c52a9520cbd[1] = max(elevator_bound.origin[0], var_52a54a8a83a2483.origin[0]);
    var_211c5c52a9520cbd[2] = min(elevator_bound.origin[1], var_52a54a8a83a2483.origin[1]);
    var_211c5c52a9520cbd[3] = max(elevator_bound.origin[1], var_52a54a8a83a2483.origin[1]);
    parts = spawnStruct();
    parts.e["1\xcd"] = level.elevators.size;
    parts.e["\xc2\xe27\xb7I\x1d&"] = [];
    parts.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"] = [];

    foreach(elevator_housing in var_d85db71b5809552d) {
      if(elevator_housing isinbound(var_211c5c52a9520cbd)) {
        parts.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"][parts.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"].size] = elevator_housing;

        if(elevator_housing.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
          continue;
        }

        if(elevator_housing.code_classname == "T\xf2\xa4:K") {
          continue;
        }

        inner_leftdoor = getEnt(elevator_housing.target, #targetname);
        parts.e["\xc2\xe27\xb7I\x1d&"]["\x8dV3\xe8}d\xdb\xb7\xe4"] = inner_leftdoor;
        parts.e["\xc2\xe27\xb7I\x1d&"]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"] = inner_leftdoor.origin;
        inner_rightdoor = getEnt(inner_leftdoor.target, #targetname);
        parts.e["\xc2\xe27\xb7I\x1d&"]["N1\x02ctN\x10\xfb\xbdA"] = inner_rightdoor;
        parts.e["\xc2\xe27\xb7I\x1d&"]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"] = inner_rightdoor.origin;
        var_11b6a466cf1c9d29 = (inner_leftdoor.origin - inner_rightdoor.origin) * (0.5, 0.5, 0.5) + inner_rightdoor.origin;
        parts.e["\xc2\xe27\xb7I\x1d&"]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"] = var_11b6a466cf1c9d29;
        door_trigger = getEnt(inner_rightdoor.target, #targetname);
        parts.e["\xc2\xe27\xb7I\x1d&"]["}~\xfbt[5\x01\xba&\xe0|\xbe"] = door_trigger;
        inside_trigger = getEnt(door_trigger.target, #targetname);
        parts.e["\xc2\xe27\xb7I\x1d&"]["\x194\xe1\x87\xdb\xc4\x83\xd2\xea\xc0\xc1\xe7\xb36"] = inside_trigger;
        inside_trigger make_discrete_trigger();
        inside_trigger.motion_trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", elevator_housing.origin, 0, 64, 128);
        assert(isDefined(inside_trigger.motion_trigger));
      }
    }

    assert(isDefined(parts.e["<dev string:x110>"]));
    parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"] = [];

    foreach(elevator_doorset in elevator_doorsets) {
      if(elevator_doorset isinbound(var_211c5c52a9520cbd)) {
        var_971113b83599f561 = isDefined(elevator_doorset.script_noteworthy) && elevator_doorset.script_noteworthy == "\xc73/_\x05\x99'\xa1\x17\xfa\xf6Y\xdbg(\xa3+\xc6\x99";
        var_ce6a64c93db22c03 = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"].size;
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03] = [];
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"] = elevator_doorset.origin;
        leftdoor = getEnt(elevator_doorset.target, #targetname);
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["\x8dV3\xe8}d\xdb\xb7\xe4"] = leftdoor;
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"] = leftdoor.origin;
        rightdoor = getEnt(leftdoor.target, #targetname);
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["N1\x02ctN\x10\xfb\xbdA"] = rightdoor;
        parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"] = rightdoor.origin;

        if(var_971113b83599f561) {
          var_a5291bcb79c22dbd = elevator_doorset.origin - leftdoor.origin;
          elevator_doorset.origin = leftdoor.origin;
          leftdoor.origin += var_a5291bcb79c22dbd;
          rightdoor.origin -= var_a5291bcb79c22dbd;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"] = elevator_doorset.origin;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"] = leftdoor.origin;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][var_ce6a64c93db22c03]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"] = rightdoor.origin;
        }
      }
    }

    assert(isDefined(parts.e["<dev string:x11b>"]));

    for(i = 0; i < parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"].size - 1; i++) {
      for(j = 0; j < parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"].size - 1 - i; j++) {
        if(parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"][2] < parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"][2]) {
          var_c10ce1b5b88896a3 = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x8dV3\xe8}d\xdb\xb7\xe4"];
          var_a3c1587ca5724ce6 = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"];
          var_8c824bbcc1cac3e = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["N1\x02ctN\x10\xfb\xbdA"];
          var_a15eca4baa0025d5 = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"];
          var_c92119d64cb4ab64 = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x8dV3\xe8}d\xdb\xb7\xe4"] = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x8dV3\xe8}d\xdb\xb7\xe4"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"] = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["N1\x02ctN\x10\xfb\xbdA"] = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["N1\x02ctN\x10\xfb\xbdA"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"] = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"] = parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"];
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x8dV3\xe8}d\xdb\xb7\xe4"] = var_c10ce1b5b88896a3;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"] = var_a3c1587ca5724ce6;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["N1\x02ctN\x10\xfb\xbdA"] = var_8c824bbcc1cac3e;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"] = var_a15eca4baa0025d5;
          parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][j + 1]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"] = var_c92119d64cb4ab64;
        }
      }
    }

    floor_pos = [];

    foreach(i, doorset in parts.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"]) {
      mainframe = parts get_housing_mainframe();
      floor_pos = (mainframe.origin[0], mainframe.origin[1], doorset["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"][2]);
      parts.e["\x9e\x93\xa9\x84{" + i + "\x9b;\x99?"] = floor_pos;

      if(mainframe.origin == floor_pos) {
        parts.e["O\xeb\x02\xc2\xdc/\xee=\xd9t\x9dzN"] = i;
        parts.e[";\xa6p{\xc1\xa9\xf4\xb1\xcb=\x88\x1f\xe5"] = i;
      }
    }

    level.elevators[level.elevators.size] = parts;
    elevator_bound delete();
    var_52a54a8a83a2483 delete();
  }

  foreach(elevator_doorset in elevator_doorsets) {
    elevator_doorset delete();
  }

  build_call_buttons();

  if(!level.elevator_motion_detection) {
    setup_hints();
  }

  foreach(elevator in level.elevators) {
    plights = elevator get_housing_primarylight();

    if(isDefined(plights) && plights.size) {
      foreach(plight in plights) {
        plight setlightintensity(0.75);
      }
    }
  }
}

function build_call_buttons() {
  level.elevator_callbuttons = getEntArray("\x9c\xda/\x01 \xb4\xa8\xcb]\x19\xa2\xc8\xd9", #targetname);
  assert(isDefined(level.elevator_callbuttons) && level.elevator_callbuttons.size > 1, "<dev string:x12c>");

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton.e = [];
    var_4469d02ee5585044 = (0, 0, callbutton.origin[2]);
    var_99b43482663ce482 = (callbutton.origin[0], callbutton.origin[1], 0);
    var_51d87bbdef790c4e = [];

    foreach(elevator in level.elevators) {
      foreach(f_idx, efloor in elevator get_outer_doorsets()) {
        v_vec = (0, 0, elevator.e["\x9e\x93\xa9\x84{" + f_idx + "\x9b;\x99?"][2]);
        h_vec = (elevator.e["\x9e\x93\xa9\x84{" + f_idx + "\x9b;\x99?"][0], elevator.e["\x9e\x93\xa9\x84{" + f_idx + "\x9b;\x99?"][1], 0);

        if(abs(distance(var_4469d02ee5585044, v_vec)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(var_99b43482663ce482, h_vec)) <= level.elevator_callbutton_link_h) {
            var_51d87bbdef790c4e[var_51d87bbdef790c4e.size] = elevator;
            callbutton.e[f_idx] = var_51d87bbdef790c4e;
          }
        }
      }
    }

    callbutton make_discrete_trigger();
    assert(isDefined(callbutton.e) && callbutton.e.size, "<dev string:x15b>" + callbutton.origin + "<dev string:x177>");
    callbutton.motion_trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", callbutton.origin + (0, 0, -32), 0, 32, 64);
  }
}

function setup_hints() {
  foreach(elevator in level.elevators) {
    use_trig = elevator get_housing_inside_trigger();
    floors = elevator get_outer_doorsets();
    var_c5345a33f1c6f448 = floors.size;
    use_trig setCursorHint("\xda\xc1Tx]8\xc1y1\x1fe");

    if(var_c5345a33f1c6f448 > 2) {
      use_trig setHintString(&"elevator_floor_select_hint");
      continue;
    }

    use_trig setHintString(&"elevator_use_hint");
  }

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton setCursorHint("\xda\xc1Tx]8\xc1y1\x1fe");
    callbutton setHintString(&"elevator_call_hint");
  }
}

function make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

function discrete_waittill(msg) {
  assert(isDefined(self.motion_trigger));
  enable_trigger();

  if(level.elevator_motion_detection) {
    self.motion_trigger waittill(msg, param);
  } else {
    self waittill(msg, param);
  }

  disable_trigger();
  return param;
}

function enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin += (0, 0, 10000);

    if(isDefined(self.motion_trigger)) {
      self.motion_trigger.origin += (0, 0, 10000);
    }
  }
}

function disable_trigger() {
  self notify("d\xf2\xabM\xacZ\xb60\x98\xad`\xbf\x8b\xfe\x82");

  if(self.enabled) {
    thread disable_trigger_helper();
  }
}

function disable_trigger_helper() {
  self endon("d\xf2\xabM\xacZ\xb60\x98\xad`\xbf\x8b\xfe\x82");
  self.enabled = 0;
  wait 1.5;
  self.origin += (0, 0, -10000);

  if(isDefined(self.motion_trigger)) {
    self.motion_trigger.origin += (0, 0, -10000);
  }
}

function get_outer_doorset(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num];
}

function get_outer_doorsets() {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"];
}

function get_outer_closedpos(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"];
}

function get_outer_leftdoor(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num]["\x8dV3\xe8}d\xdb\xb7\xe4"];
}

function get_outer_rightdoor(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num]["N1\x02ctN\x10\xfb\xbdA"];
}

function get_outer_leftdoor_openedpos(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"];
}

function get_outer_rightdoor_openedpos(floor_num) {
  return self.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"][floor_num]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"];
}

function get_housing_children() {
  children = [];
  door_trig = get_housing_door_trigger();
  use_trig = get_housing_inside_trigger();
  motion_trig = use_trig.motion_trigger;
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  children[children.size] = door_trig;
  children[children.size] = use_trig;
  children[children.size] = left_door;
  children[children.size] = right_door;

  if(isDefined(motion_trig)) {
    children[children.size] = motion_trig;
  }

  script_models = get_housing_models();

  foreach(emodel in script_models) {
    children[children.size] = emodel;
  }

  primarylights = get_housing_primarylight();

  foreach(plight in primarylights) {
    children[children.size] = plight;
  }

  return children;
}

function get_housing_mainframe() {
  parts = self.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"];
  housing_model = undefined;

  foreach(part in parts) {
    if(part.classname != "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6" && part.code_classname != "T\xf2\xa4:K") {
      assert(!isDefined(housing_model), "<dev string:x1ad>");
      housing_model = part;
    }
  }

  assert(isDefined(housing_model), "<dev string:x1fb>");
  return housing_model;
}

function get_housing_models() {
  parts = self.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"];
  var_57a21582207d8a7a = [];

  foreach(part in parts) {
    if(part.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
      var_57a21582207d8a7a[var_57a21582207d8a7a.size] = part;
    }
  }

  return var_57a21582207d8a7a;
}

function get_housing_primarylight() {
  parts = self.e["\xc2\xe27\xb7I\x1d&"]["x\x1f\xe3\x16\xeaW\xde\xe4q"];
  temp_primarylights = [];

  foreach(part in parts) {
    if(part.code_classname == "T\xf2\xa4:K") {
      temp_primarylights[temp_primarylights.size] = part;
    }
  }

  return temp_primarylights;
}

function get_housing_musak_model() {
  models = get_housing_models();
  musak_model = undefined;

  foreach(emodel in models) {
    if(isDefined(emodel.script_noteworthy) && emodel.script_noteworthy == "wG\x10\xae\xf0\xba\x13\xe5z\xc5") {
      musak_model = emodel;
    }
  }

  return musak_model;
}

function get_housing_door_trigger() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["}~\xfbt[5\x01\xba&\xe0|\xbe"];
}

function get_housing_inside_trigger() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["\x194\xe1\x87\xdb\xc4\x83\xd2\xea\xc0\xc1\xe7\xb36"];
}

function get_housing_closedpos() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["\x80\xd0\xc0\xd4p\xe0!-\xdb\xe2Uz\xbf\xfaq"];
}

function get_housing_leftdoor() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["\x8dV3\xe8}d\xdb\xb7\xe4"];
}

function get_housing_rightdoor() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["N1\x02ctN\x10\xfb\xbdA"];
}

function get_housing_leftdoor_opened_pos() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["p\xba\x94\xfa\x83A\x89\xc9/\x91\x0f\x16V\x81;x\xf9X\x80]"];
}

function get_housing_rightdoor_opened_pos() {
  return self.e["\xc2\xe27\xb7I\x1d&"]["\x91\x89\x98\x01\xab\xaeP:>\x0e-\xb7n\x98\xd5\xcdHQ\xdc\x1c\xc7"];
}

function get_curfloor() {
  moving = elevator_floor_update();
  return self.e[";\xa6p{\xc1\xa9\xf4\xb1\xcb=\x88\x1f\xe5"];
}

function get_initfloor() {
  return self.e["O\xeb\x02\xc2\xdc/\xee=\xd9t\x9dzN"];
}

function waittill_finish_moving(ent1, var_d30f8bacb673942, ent2, var_464c2e26c1ef0a2d) {
  if(!isDefined(ent2) && !isDefined(var_464c2e26c1ef0a2d)) {
    ent2 = ent1;
    var_464c2e26c1ef0a2d = var_d30f8bacb673942;
  }

  while(true) {
    var_9d59f0f8f436356f = ent1.origin;
    var_41f8492e4a3b6162 = ent2.origin;

    if(var_9d59f0f8f436356f == var_d30f8bacb673942 && var_41f8492e4a3b6162 == var_464c2e26c1ef0a2d) {
      break;
    }

    wait 0.05;
  }
}

function isinbound(bounding_box) {
  assert(isDefined(self) && isDefined(self.origin), "<dev string:x235>");
  v_x = self.origin[0];
  v_y = self.origin[1];
  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];
  return v_x >= min_x && v_x <= max_x && v_y >= min_y && v_y <= max_y;
}

function isinboundingspere(bounding_box) {
  v_x = self.origin[0];
  v_y = self.origin[1];
  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];
  mid_x = (min_x + max_x) / 2;
  mid_y = (min_y + max_y) / 2;
  radius = abs(distance((min_x, min_y, 0), (mid_x, mid_y, 0)));
  return abs(distance((v_x, v_y, 0), (mid_x, mid_y, 0))) < radius;
}

function waittill_or_timeout(msg, timer) {
  self endon(msg);
  wait timer;
}

function elevator_get_dvar_int(dvar, def) {
  return int(elevator_get_dvar(dvar, def));
}

function elevator_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return getdvarfloat(dvar);
  }

  setDvar(dvar, def);
  return def;
}

function elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }

  while(true) {
    if(level.elevator_debug != 2) {
      continue;
    }

    foreach(i, elevator in level.elevators) {
      mainframe = elevator get_housing_mainframe();
      musak_model = elevator get_housing_musak_model();

      print3d(musak_model.origin, "<dev string:x26c>" + i + "<dev string:x272>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(mainframe.origin, "<dev string:x26c>" + i + "<dev string:x283>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x110>"]["<dev string:x291>"].origin, "<dev string:x26c>" + i + "<dev string:x29e>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x110>"]["<dev string:x2ac>"].origin, "<dev string:x26c>" + i + "<dev string:x2ba>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x110>"]["<dev string:x2c9>"], "<dev string:x26c>" + i + "<dev string:x2dc>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x110>"]["<dev string:x2e6>"].origin, "<dev string:x26c>" + i + "<dev string:x2f8>", (0.75, 0.75, 1), 1, 0.25, 20);

      foreach(j, efloor in elevator.e["O\xba=6 \x84\xcaT\x05\x8c;\x8b\xc6"]) {
        print3d(efloor["<dev string:x291>"].origin + (0, 0, 8), "<dev string:x26c>" + i + "<dev string:x300>" + j + "<dev string:x29e>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(efloor["<dev string:x2ac>"].origin + (0, 0, 8), "<dev string:x26c>" + i + "<dev string:x300>" + j + "<dev string:x2ba>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(efloor["<dev string:x2c9>"] + (0, 0, 8), "<dev string:x26c>" + i + "<dev string:x300>" + j + "<dev string:x2dc>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(elevator.e["<dev string:x307>" + j + "<dev string:x310>"] + (0, 0, 8), "<dev string:x26c>" + i + "<dev string:x300>" + j + "<dev string:x318>", (1, 0.75, 0.75), 1, 0.25, 20);
      }
    }

    foreach(callbutton in level.elevator_callbuttons) {
      print3d(callbutton.origin, "<dev string:x321>", (0.75, 0.75, 1), 1, 0.25, 20);

      foreach(efloor in callbutton.e) {
        printoffset = 0;

        foreach(elinked in efloor) {
          printoffset++;
          print_pos = callbutton.origin + (0, 0, printoffset * -4);

          print3d(print_pos, "<dev string:x32f>" + f_idx + "<dev string:x335>" + elinked.e["<dev string:x33c>"] + "<dev string:x342>", (0.75, 0.75, 1), 1, 0.25, 20);
        }
      }
    }

    wait 0.05;
  }
}

function function_7b80813c793cafb8(movingplatforment) {
  if(!isDefined(movingplatforment)) {
    return false;
  }

  if(isDefined(level.elevators)) {
    foreach(elevatorstruct in level.elevators) {
      if(!isDefined(elevatorstruct.car)) {
        continue;
      }

      if(elevatorstruct.car == movingplatforment) {
        return true;
      }
    }
  }

  return false;
}