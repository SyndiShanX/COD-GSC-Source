/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\door.gsc
**************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\hud_util;
#using scripts\sp\outline;
#using scripts\sp\player\cursor_hint;
#namespace door;

function init() {
  level.interactive_doors.snakecamvision = "\xe2\rS\x94*\xe5\x0e\xa3\x12";
  level.interactive_doors.fndoorinit = &_init_door_internal;

  if(isDefined(level.lockpicking) && isDefined(level.lockpicking.var_9dc2904a19139318)) {
    level.interactive_doors.var_9dc2904a19139318 = level.lockpicking.var_9dc2904a19139318;
  }

  precacheshader("\xb7r\xcf\xaaD\x7f\xc1\xf8\xbf\x05\x127(\xb6z\b\xdaxF\"\xe7\x1c\xc0\xf4\xc7 \xbe\xff\xcaO\xd1&k");
  precachemodel("\x80\xcf\v\xc5\x1b{\xc0\xc5\a\xfc\xf2\x12\x89");
  utility_sp::hudoutline_add_channel("\xe2\rS\x94*\xe5\x0e\xa3\x12");
  utility::flag_init("1\xc1\x9ax;\xa6\xdb}?;\xc4\x86\xbeZ-\fbtz");
  utility::flag_init("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0");
  level.player utility::ent_flag_init("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT");
  level._effect["/L\xc7\x973\xf1\x97\x87\x06\xb5\xfb"] = loadfxasset("\"\xb5\xaeegK\xe7[!L\x837\xe1\x80\xcb$\x1c\xc9\xf4\x93\t&X");
  level._effect["T1\xbf\x80\xb7-Bm\x10\xf5\xda\xddN\xc6"] = loadfxasset("\x05\xa1u\x82\x97\x8c\xdf\x91p9\xb6p\x8e\x82\xeb\\\xd5\xa0\x8b\x198\xe4:\xffAz\x86");
  level._effect["_\x1a=\x8dX\xfdT\xf5\x98\xb0Z@"] = loadfxasset("4MU>\xcc\xa8Y}~\x86k\xcf=\x838>q/\x92\xf4\xab#\xd1\xf7\xa3");
  level._effect["85\x9d\xc3N_\xce\xbed\xad\xd3\xb3"] = loadfxasset("\x95='\xdfm\x8bb\x91\xf4\xde\x1d\xa2\xc0\xafT\xc6\r\xbf\\\xcd\xbd\xe3\xab\xfa\x93\x82ab\xbb\xc7\xfb\xd1");
}

function _init_door_internal(reset) {
  door_internal::init_door_internal(reset);
  doc4 = undefined;
  docam = undefined;

  if(isDefined(self.script_parameters)) {
    values = strtok(self.script_parameters, "\xda");

    foreach(value in values) {
      switch (value) {
        case #"hash_fa1e80f6bd5b8e72":
          doc4 = 1;
          self.c4_breachable = 0;
          break;
        case #"hash_34ee66c45897bc9b":
          docam = 1;
          self.cam_structs = [];
          self.snakecam_active = 0;
          break;
        case #"hash_4683ba2754c4bcb3":
          if(isDefined(level.interactive_doors.var_9dc2904a19139318)) {
            self[[level.interactive_doors.var_9dc2904a19139318]](self.script_parameters);
          }

          break;
      }
    }
  }

  if(isDefined(doc4) || isDefined(docam) || isDefined(self.lockpick)) {
    structs = utility::get_linked_structs();
    c4_structs = [];

    foreach(struct in structs) {
      if(isDefined(struct.script_noteworthy)) {
        struct.door = self;

        switch (struct.script_noteworthy) {
          case #"hash_3377515bbda6817c":
            if(!isDefined(docam)) {
              break;
            }

            if(!isDefined(struct.radius)) {
              struct.radius = 2.5;
            }

            struct thread snake_cam_logic();
            self.cam_structs[self.cam_structs.size] = struct;
            break;
          case #"hash_fa1e80f6bd5b8e72":
            if(!isDefined(doc4)) {
              break;
            }

            if(!isDefined(struct.radius)) {
              struct.radius = 2.5;
            }

            c4_structs[c4_structs.size] = struct;
            break;
        }
      }

      thread door_event_wait();
    }

    if(c4_structs.size > 0) {
      self.c4_struct = utility::spawn_script_origin();
      self.c4_struct.origin = (0, 0, 0);
      self.c4_struct.radius = 0;
      self.c4_struct.door = self;

      if(isDefined(self.angles)) {
        self.c4_struct.angles = self.angles;
      } else {
        self.c4_struct.angles = (0, 0, 0);
      }

      foreach(struct in c4_structs) {
        self.c4_struct.origin += struct.origin * 1 / c4_structs.size;
        self.c4_struct.radius += struct.radius * 1 / c4_structs.size;
      }

      self.c4_struct.breachpoints = c4_structs;
    }

    if(isDefined(self.lockpick) && istrue(self.locked)) {
      thread enable_lockpicking();
    }
  }

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread door_internal::cursor_hint_thread();
  }
}

function door_event_wait() {
  self notify("(\xf0\x98\xbf45\v\x84\xc2\x1a\xe4}'\xb48");
  self endon("(\xf0\x98\xbf45\v\x84\xc2\x1a\xe4}'\xb48");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(true) {
    event = utility::waittill_any_return("!\x90l\x94\xcfU", "\xc8\xdb\xdbN\xfa]\xcdc\xb7\xb1\xd6", "\x83\xa2\x0f\x16\b%>\xb0", "\xc9\x98\x04\x94\x9fw\xa7");

    if(event == "!\x90l\x94\xcfU") {
      thread enable_lockpicking();
      thread enable_c4_on_locked();
      continue;
    }

    if(event == "\x83\xa2\x0f\x16\b%>\xb0" || event == "\xc9\x98\x04\x94\x9fw\xa7") {
      thread remove_door_snake_cam_ability();
      thread remove_door_c4_ability();
      thread disable_lockpicking();
      continue;
    }

    if(event == "\xc8\xdb\xdbN\xfa]\xcdc\xb7\xb1\xd6") {
      thread remove_door_c4_ability();
      thread disable_lockpicking();
    }
  }
}

function enable_lockpicking() {
  if(!isDefined(self.lockpick)) {
    return;
  }

  if(!istrue(self.isbashing)) {
    self thread[[self.lockpick.enable_callback]]();
  }
}

function disable_lockpicking() {
  if(!isDefined(self.lockpick)) {
    return;
  }

  self thread[[self.lockpick.disable_callback]]();
}

function enable_c4_on_locked() {
  self endon("\xbe,\x9f\x94_\x87k\xa7u\xd8\x1e\x13\x85\x9d\xaf:\xba*");

  if(!isDefined(self.c4_struct)) {
    return;
  }

  self.c4_struct thread c4_breach();
  self.open_struct door_sp::remove_open_interact_hint();
  self.c4_struct endon("\xe3\xe1\xda<\xac\xbf\x17\xea\xbf#");

  while(distancesquared(level.player.origin, self.origin) < squared(200)) {
    waitframe();
  }

  remove_door_c4_ability();
  self.open_struct utility::delaythread(0.05, &door_internal::open_struct_logic);
}

function set_snake_cam_ignore_ents(ents) {
  if(!isarray(ents)) {
    ents = [ents];
  }

  door = self;
  cam_struct = door.cam_structs[0];
  cam_struct.ignoremarkedents = ents;
}

function remove_from_snakecam_immediate() {
  if(!utility::ent_flag("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT")) {
    return;
  }

  if(utility::flag("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0")) {
    return;
  }

  utility::flag_set("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0");
  utility::function_18e9f1084badc1c7("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT");
  utility::flag_clear("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0");
}

function set_snake_cam_vision(vision) {
  if(!isDefined(vision)) {
    vision = "\xe2\rS\x94*\xe5\x0e\xa3\x12";
  }

  level.interactive_doors.snakecamvision = vision;

  if(level.player utility::ent_flag("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT")) {
    visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  }
}

function remove_door_snake_cam_ability() {
  println("<dev string:x24>" + self getentnum() + "<dev string:x59>" + self.origin);

  if(!isDefined(self.cam_structs)) {
    return;
  }

  foreach(struct in self.cam_structs) {
    if(isDefined(struct)) {
      struct notify("\x82\xa5\xad\x9avN`\xe7:\xab\r\xb7\x91&");
      struct cursor_hint::remove_cursor_hint();
    }
  }
}

function snake_cam_logic() {
  self endon("\x82\xa5\xad\x9avN`\xe7:\xab\r\xb7\x91&");
  dwn = anglestoup(self.angles * -1);
  nvg_was_on = 0;

  while(true) {
    cursor_hint::create_cursor_hint(undefined, undefined, &"script/door_hint_snake_cam", undefined, 120 * level.interactive_doors.hint_dist_scale, 100 * level.interactive_doors.hint_dist_scale, 0, undefined, undefined, undefined, undefined, undefined, undefined, 15);
    self.door door_internal::adjust_cursor_hint_side(self);
    self waittill("\x91`\xb1\xe7T\x97>");
    var_efccf34e55fa88fb = self.door.lockedforai;
    level.player utility::ent_flag_set("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT");
    self.door notify("\xe2\rS\x94*\xe5\x0e\xa3\x12");
    outline::outline_fade_alpha_for_index(6, 0, 0);

    if(level.player isnightvisionon()) {
      nvg_was_on = 1;
      level.player nightvisiongogglesforceoff();
    }

    level.player val::set("\x1b;\xd70\x19\xa3_w", "\x18\xaa\b", -1);

    if(isDefined(self.door)) {
      self.door.snakecam_active = 1;

      self.door.debug_activity = "<dev string:x61>";
    }

    level.player modifybasefov(115, 0.4);
    level thread static_burst(0.1);
    level.player notify("\xcanGV\xc9\xf5\xd8\xc2m");
    level.player.og_origin = level.player.origin;
    level.player.og_angles = level.player getplayerangles();
    level.player.og_stance = level.player getstance();
    level.player freezecontrols(1);
    level.player disableweapons();

    if(utility::flag_exist("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b")) {
      utility::flag_set("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b");
    }

    level.player.ignore_stealth_sight = 1;
    level.player.ignoreme = 1;
    utility::flag_wait_or_timeout("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0", 0.5);
    fwd = anglesToForward(self.angles);
    to_door = vectorNormalize(self.origin - level.player getorigin());
    dot = vectordot(fwd, to_door);
    tag = level.player utility::spawn_tag_origin();
    tag.origin = self.origin;
    tag.angles = self.angles;

    if(isDefined(self.target)) {
      offset_struct = utility::getStruct(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

      if(!isDefined(offset_struct)) {
        offset_struct = getEnt(self.target, #targetname);
      }

      if(isDefined(offset_struct)) {
        tag.origin = offset_struct.origin;
        tag.angles = offset_struct.angles;
      }
    }

    if(dot < 0) {
      tag.angles += (0, 180, 0);
    }

    put_player_on_cam(tag);
    temp = level.player utility::spawn_script_origin();
    tag.tempmovesoundent = level.player utility::spawn_script_origin();
    tag.rumbleent = level.player utility::spawn_script_origin();
    temp scalevolume(0, 0);
    temp playLoopSound("\xf1\xd0W5}\xac\x10\x96\xb5\x10\xf8\xc7\x04\xd9\x10@\xce\xd4");
    temp scalevolume(1, 1);
    tag.tempmovesoundent playLoopSound("\xaa\x9dR\xb0\xfe\xe9\x04\xce\x90b\x90g\x88\x83\xde");
    tag thread snake_cam_control();
    level.cam_hud = snake_door_cam_hud();

    while(level.player useButtonPressed()) {
      if(utility::flag("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0")) {
        break;
      }

      wait 0.05;
    }

    utility::flag_wait("1\xc1\x9ax;\xa6\xdb}?;\xc4\x86\xbeZ-\fbtz");
    waittill_player_exits_cam();
    nudge_spot = tag.origin + anglesToForward(tag.angles) * -20;

    if(utility::flag("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0")) {
      tag moveTo(nudge_spot, 0.05);
    } else {
      tag moveTo(nudge_spot, 0.5, 0.125);
    }

    utility::flag_wait_or_timeout("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0", 0.25);
    level.player notify("6Y\x85\xec\xb2\xfa\x8d,\xad");

    foreach(thing in level.cam_hud) {
      thing destroy();
    }

    level thread static_burst(0.125);
    level utility_sp::add_wait(&utility::flag_wait, "\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0");
    level utility_sp::add_wait(&utility_sp::waittill_msg, "\xd4\xad\xa9T\xeb\xd6\xbd\xe1\nT\xe5\x86\xf5#\x86");
    utility_sp::do_wait_any();
    outline::outline_fade_alpha_for_index(6, 0.8, 0);
    temp stoploopsound("\xf1\xd0W5}\xac\x10\x96\xb5\x10\xf8\xc7\x04\xd9\x10@\xce\xd4");
    tag.tempmovesoundent stoploopsound("\xaa\x9dR\xb0\xfe\xe9\x04\xce\x90b\x90g\x88\x83\xde");
    visionsetfadetoblack("", 0.05);
    setsaveddvar(@ "r_mbradialoverridechromaticaberration", 0);
    setsaveddvar(@ "r_mbradialoverridedistortion", 0);
    setsaveddvar(@ "r_mbradialoverrideradius", 0);
    setsaveddvar(@ "r_mbradialoverridestrength", 0);

    if(nvg_was_on) {
      level.player nightvisiongogglesforceon();
    }

    utility::flag_wait_or_timeout("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0", 0.1);

    if(!isDefined(level.fov_default)) {
      level.fov_default = 65;
    }

    level.player modifybasefov(level.fov_default, 0.05);
    remove_player_from_cam();

    if(utility::flag_exist("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b")) {
      utility::flag_clear("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b");
    }

    level.player.ignore_stealth_sight = undefined;
    level.player.ignoreme = 0;
    tag.tempmovesoundent delete();
    tag.rumbleent delete();
    tag delete();
    temp delete();

    if(isDefined(self.door)) {
      self.door.snakecam_active = 0;
    }

    while(level.player useButtonPressed()) {
      if(utility::flag("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0")) {
        break;
      }

      wait 0.05;
    }

    self.door.lockedforai = var_efccf34e55fa88fb;
    level.player utility::ent_flag_clear("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT");
    outline::outline_fade_alpha_for_index(6, 0, 6);
  }
}

function snake_cam_control(tempmovesoundent) {
  level.player endon("6Y\x85\xec\xb2\xfa\x8d,\xad");
  og_angles = self.angles;
  minpitch = -24;
  maxpitch = 0;
  yawdeltamax = 55;
  minyaw = og_angles[1] - yawdeltamax;
  maxyaw = og_angles[1] + yawdeltamax;
  minroll = og_angles[2] - 10;
  maxroll = og_angles[2] + 10;
  ddeadzone = 20;
  dmaxroll = 10;
  var_f588a5fe73671491 = 0.6;
  var_c327b708f814a32a = 0.8;
  dmaxangle = 10;
  dyaw = 4;
  dpitch = 1.2;
  var_4a587fb7042ed3ce = [0, 0];
  var_8ce450bf1113fc3a = 0.2;
  var_c74b11aa66ca226d = 0.2;
  rumble_playing = 0;

  while(true) {
    currentangles = self.angles;
    currentcamangles = level.player.cam_ent.angles;
    input = level.player getnormalizedcameramovement();
    multiplier = 0;
    normalinput = (input[0], input[1], 0);
    normalinput = length(normalinput);
    inputlerprate = math::factor_value(var_c74b11aa66ca226d, var_8ce450bf1113fc3a, normalinput);
    var_4a587fb7042ed3ce[0] = math::lerp(var_4a587fb7042ed3ce[0], input[0], inputlerprate);
    var_4a587fb7042ed3ce[1] = math::lerp(var_4a587fb7042ed3ce[1], input[1], inputlerprate);

    if(currentangles[0] > 0 && var_4a587fb7042ed3ce[0] < 0) {
      var_78bbb3a76e1eb32 = 1 - math::normalize_value(maxpitch * var_f588a5fe73671491, maxpitch, currentangles[0]);
    } else if(currentangles[0] < 0 && var_4a587fb7042ed3ce[0] > 0) {
      var_78bbb3a76e1eb32 = math::normalize_value(minpitch, minpitch * var_f588a5fe73671491, currentangles[0]);
    } else {
      var_78bbb3a76e1eb32 = 1;
    }

    if(currentangles[1] > og_angles[1] && var_4a587fb7042ed3ce[1] < 0) {
      var_326b6af09af4e2db = 1 - math::normalize_value(maxyaw - yawdeltamax * var_c327b708f814a32a, maxyaw, currentangles[1]);
    } else if(currentangles[1] < og_angles[1] && var_4a587fb7042ed3ce[1] > 0) {
      var_326b6af09af4e2db = math::normalize_value(minyaw, minyaw + yawdeltamax * var_c327b708f814a32a, currentangles[1]);
    } else {
      var_326b6af09af4e2db = 1;
    }

    inputyaw = var_4a587fb7042ed3ce[1] * -1;
    nextyaw = currentangles[1] + dyaw * inputyaw * var_326b6af09af4e2db;

    if(nextyaw > og_angles[1]) {
      multiplier = math::normalized_float_smooth_out(math::normalize_value(og_angles[1], maxyaw, nextyaw)) * -1;
    }

    if(nextyaw < og_angles[1]) {
      multiplier = 1 - math::normalized_float_smooth_in(math::normalize_value(minyaw, og_angles[1], nextyaw));
    }

    inputroll = input[1];
    nextroll = og_angles[2] + dmaxroll * multiplier;
    maxroll *= multiplier;
    nextyaw = clamp(nextyaw, minyaw, maxyaw);
    inputpitch = var_4a587fb7042ed3ce[0] * -1;
    nextpitch = currentangles[0] + dpitch * inputpitch * var_78bbb3a76e1eb32;
    minpitchclamp = minpitch;
    maxpitchclamp = maxpitch;
    nextpitch = clamp(nextpitch, minpitchclamp, maxpitchclamp);
    snakeangles = (nextpitch, nextyaw, nextroll);
    movementfactor = length(snakeangles - self.angles);
    movementfactor = math::normalize_value(0, 1.5, movementfactor);
    quake = math::factor_value(0, 0.105, movementfactor);
    rumble = math::factor_value(0, 0.08, movementfactor);
    volume = math::factor_value(0, 0.2, movementfactor);

    if(quake > 0.005) {
      earthquake(quake, 0.07, level.player.origin, 2000);
    }

    if(rumble > 0.0001) {
      if(!rumble_playing) {
        self.rumbleent playrumblelooponentity("\x8e\xc3\"\xb2\x80\xe5x\x18\xb1\x96\xebC\xff");
        rumble_playing = 1;
      }
    } else if(rumble_playing) {
      self.rumbleent stoprumble("\x8e\xc3\"\xb2\x80\xe5x\x18\xb1\x96\xebC\xff");
      rumble_playing = 0;
    }

    height = 1 - rumble;
    height *= 1000;
    self.rumbleent.origin = level.player getEye() + (0, 0, height);
    self.tempmovesoundent scalevolume(volume, 0.05);
    self.angles = snakeangles;
    nudge_spot = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    level.player.cam_ent.origin = nudge_spot;
    level.player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

function put_player_on_cam(tag) {
  nudge_spot = tag.origin + anglesToForward(tag.angles) * 12 - (0, 0, 55);
  level.player.cam_ent = utility::spawn_tag_origin(nudge_spot, tag.angles);
  level.player val::set("\x1b;\xd70\x19\xa3_w", "\x8b\x90\xb5\xc4W", 1);
  level.player val::set("\x1b;\xd70\x19\xa3_w", "1x\xc5\xb4\xabx", 0);
  level.player val::set("\x1b;\xd70\x19\xa3_w", "GX\xa9]\x82", 0);
  level.player val::set("\x1b;\xd70\x19\xa3_w", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
  level.player val::set("\x1b;\xd70\x19\xa3_w", "\xe5\x06\xb0\bE\x16", 0);
  level.player utility::function_7796cb25a4c0b81b(0);
  level.player playerdisabletriggers();
  level.player setstance("\x8b\x90\xb5\xc4W", 1, 1, 1);
  level.player setOrigin(level.player.cam_ent.origin);
  level.player playerlinktodelta(level.player.cam_ent, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 20, 20, 20, 20, 1);
  level.player springcamenabled(0, 2, 1);
  level.player setplayerangles(tag.angles);
  level.player freezecontrols(0);
}

function snakecam_allow_exit() {
  utility::flag_set("1\xc1\x9ax;\xa6\xdb}?;\xc4\x86\xbeZ-\fbtz");
}

function snakecam_allow_exit_prompt() {
  level.cam_hud[2] settext("\x7f\xd7\xb2\xc8\xfc\xa2\xfa\\\x1f}\x11\x96\f\xd3Z\xc6\xc7\xe8t\x13\xd5\xef\xfa\x94\x06i\xf9");
}

function snakecam_force_exit() {
  utility::flag_set("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0");
}

function remove_player_from_cam() {
  level.player unlink();
  level.player.cam_ent delete();
  level.player setOrigin(level.player.og_origin);
  level.player setplayerangles(level.player.og_angles);
  level.player setstance(level.player.og_stance);
  utility::flag_wait_or_timeout("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0", 0.25);
  level.player.ignoreme = 0;
  level.player val::reset_all("\x1b;\xd70\x19\xa3_w");
  level.player playerenabletriggers();
  level.player utility::function_7796cb25a4c0b81b(1);
}

function waittill_player_exits_cam() {
  while(true) {
    if(player_is_trying_to_exit_camera()) {
      break;
    }

    if(utility::flag("\x9apS\"\xe18\xd4\x1d :\xd5\xc8\xd6T3\xc4\x0e\xfc\x90N\b\x8d\xbcD\xc0")) {
      break;
    }

    waitframe();
  }
}

function player_is_trying_to_exit_camera() {
  return level.player useButtonPressed() || level.player fragButtonPressed() || level.player meleeButtonPressed() || level.player buttonPressed("5\xee\xb7\xe0\x1e\nK6") || level.player jumpbuttonPressed() || level.player buttonPressed("\xca\xad\xcb\x97\xc1\xfa\xc91_\xc7\xc7\xe3\x93") || level.player buttonPressed("\x14\xd5\xd7\xd4\xfb\x0e\x1c!fS\xaa\xd3\xf6");
}

function static_burst(duration) {
  fade_time = 0.25;

  if(!isDefined(duration)) {
    duration = 0.5;
  }

  level.player playSound("mi{\xbc\xbcm\x01\xbe}U\x04xY\f3\x17");
  static = hud_util::create_client_overlay("cwy\xb6\x94g}Ht\xf2h\xed\xd0X", 1);
  static.alpha = 0;
  static fadeovertime(fade_time);
  static.alpha = 1;
  wait fade_time;
  level notify("\xd4\xad\xa9T\xeb\xd6\xbd\xe1\nT\xe5\x86\xf5#\x86");
  wait duration;
  static fadeovertime(fade_time);
  static.alpha = 0;
  wait fade_time;
  level notify("A\xacG\x91@\x02b\xf8pEN1\x95v\xbe^");
  static destroy();
}

function cam_enemy_marking() {
  level.player endon("6Y\x85\xec\xb2\xfa\x8d,\xad");
  level.player notifyonplayercommand("\xd9}\x8a\xdd\b)\x1e\xc0\x9e\xbd{\x05_\xedR", "\xaaQ\xf1{\xf3\x97\xba");

  while(true) {
    level.player waittill("\xd9}\x8a\xdd\b)\x1e\xc0\x9e\xbd{\x05_\xedR");
    ignore_ents = [self.door, level.player];

    if(isDefined(self.ignoremarkedents)) {
      ignore_ents = utility::array_combine(ignore_ents, self.ignoremarkedents);
    }

    fwd = anglesToForward(level.player getplayerangles());
    endorigin = level.player getEye() + fwd * 1000;
    trace = trace::sphere_trace(level.player getEye(), endorigin, 2, ignore_ents);
    ent = trace["\x1f\xa8\x10WP\xa9"];

    if(isDefined(ent)) {
      if(isai(ent) && isalive(ent) && ent.team == "?\xb1\xc0\x9a") {
        ent thread handle_cam_enemy_marking();
      }
    }
  }
}

function snake_door_cam_hud() {
  crosshair = newhudelem();
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "O\xd5!\xe8\xd4\x9d";
  crosshair.aligny = "#\xb8\xfd\xf5\x1a@";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 0.7;
  crosshair.y = 233;
  crosshair settext("H");
  overlay = newhudelem();
  overlay.x = 292;
  overlay.y = 60;
  overlay.alignx = "O\xd5!\xe8\xd4\x9d";
  overlay.aligny = "#\xb8\xfd\xf5\x1a@";
  overlay.font = "}\nK(OP\x17C\xfe\xfc";
  overlay.fontscale = 0.75;
  goggles = hud_util::create_client_overlay("\xb7r\xcf\xaaD\x7f\xc1\xf8\xbf\x05\x127(\xb6z\b\xdaxF\"\xe7\x1c\xc0\xf4\xc7 \xbe\xff\xcaO\xd1&k", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar(@ "r_mbradialoverridechromaticaberration", 0.5);
  setsaveddvar(@ "r_mbradialoverridedistortion", 0.2);
  setsaveddvar(@ "r_mbradialoverrideradius", -0.75);
  setsaveddvar(@ "r_mbradialoverridestrength", 0.011);
  return [crosshair, goggles, overlay];
}

function snake_door_cam_hud_blur_v2() {
  crosshair = newhudelem();
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "O\xd5!\xe8\xd4\x9d";
  crosshair.aligny = "#\xb8\xfd\xf5\x1a@";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 0.7;
  crosshair.y = 233;
  crosshair settext("H");
  overlay = newhudelem();
  overlay.x = 400;
  overlay.y = 180;
  overlay.alignx = "O\xd5!\xe8\xd4\x9d";
  overlay.aligny = "#\xb8\xfd\xf5\x1a@";
  overlay.font = "}\nK(OP\x17C\xfe\xfc";
  overlay.fontscale = 0.75;
  goggles = hud_util::create_client_overlay("\xb7r\xcf\xaaD\x7f\xc1\xf8\xbf\x05\x127(\xb6z\b\xdaxF\"\xe7\x1c\xc0\xf4\xc7 \xbe\xff\xcaO\xd1&k", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar(@ "r_mbradialoverridechromaticaberration", 0.5);
  setsaveddvar(@ "r_mbradialoverridedistortion", 0.2);
  setsaveddvar(@ "r_mbradialoverrideradius", -0.75);
  setsaveddvar(@ "r_mbradialoverridestrength", 0.011);
  return [crosshair, goggles, overlay];
}

function handle_cam_enemy_marking() {
  if(!utility::ent_flag_exist("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D")) {
    utility::ent_flag_init("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D");
  }

  if(utility::ent_flag("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D")) {
    return;
  }

  utility::ent_flag_set("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D");
  handle_cam_enemy_caret();

  if(isalive(self) && utility::ent_flag("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D")) {
    utility_sp::hudoutline_enable_new("t])#\x0e\x89)\xe2P\xfe\b\xab,\xb9\xd4bK\xe2\x05", "\xe2\rS\x94*\xe5\x0e\xa3\x12");
    utility::ent_flag_clear("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D");
  }
}

function handle_cam_enemy_caret() {
  caret = utility::spawn_tag_origin();
  level.player playSound("YC~\xaf\x0e\xf7|\x1e\xcb\xd9an\xcbb\xb11Q5.\x85\xf6\xa7_");
  playFXOnTag(utility::getfx("85\x9d\xc3N_\xce\xbed\xad\xd3\xb3"), caret, "\xec\xbfK|\au\xcd\xc2\x19<");
  cam_enemy_caret_follow_target_til_cleanup(caret);
  caret delete();
}

function cam_enemy_caret_follow_target_til_cleanup(caret) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(level.player utility::ent_flag("\x1fC\xf5\x1a\x91\tvC\x9c\xba\xe8\x15\xcbT") && utility::ent_flag("\x1f\x93\xda\xd5MD\xfe7\x99\x1a\x01\x84\xbe\xe1\x12D")) {
    org = self gettagorigin("\xa6\xeb\x1ae\x85#");
    caret.origin = org + (0, 0, 18);
    wait 0.05;
  }
}

function c4_breach() {
  self.door endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self.door endon("\xebe\xd6\xee\xb7\xc1/\xc7\xd3Kz\x1e\xb9z\x98");
  self.door.c4_breachable = 1;

  if(!isbreachableinit()) {
    return;
  }

  cursor_hint::create_cursor_hint(undefined, undefined, "Z-\xc5\xdc\xc1\f", undefined, 110 * level.interactive_doors.hint_dist_scale, 60 * level.interactive_doors.hint_dist_scale, 0);
  self.door door_internal::adjust_cursor_hint_side(self);
  self waittill("\x91`\xb1\xe7T\x97>");
  self notify("s\xe8{8}\xd8\xeaN\xb9\xbd9\xfa\xd0K\xe6G}\x1d\x86\x9c\x95\x16\x19");

  self.door.debug_activity = "<dev string:x6e>";

  self notify("\xe3\xe1\xda<\xac\xbf\x17\xea\xbf#");
  self.door door_sp::create_navobstacle();
  self.breached = 1;
  self.door door_sp::remove_open_ability();
  self.door remove_door_snake_cam_ability();
  c4_on_door();
  c4_countdown();
  c4_detonate();
  self.door door_sp::clear_navobstacle();
  self.door door_sp::delete_door();
}

function isbreachableinit() {
  if(self.door.locked) {
    return 1;
  }

  return 0;
}

function c4_on_door() {
  self.breachpoints = sortbydistance(self.breachpoints, level.player.origin);
  breachpoint = self.breachpoints[0];
  level.player playgestureviewmodel("\xe1\xae\xeb\x12\x1ch\xe5!\\\xa5z:\xef9Qe\a2\xfd\xb4");
  wait 0.5;
  self.door.c4 = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", breachpoint.origin);
  self.door.c4.angles = breachpoint.angles;
  self.door.c4 setModel("\x80\xcf\v\xc5\x1b{\xc0\xc5\a\xfc\xf2\x12\x89");
  playsoundatpos(self.origin, "'\xbf\x15\xc6\xacw_\xd9\xf5\xb5m");
  self.door notify("\xe3\xe1\xda<\xac\xbf\x17\xea\xbf#");
}

function c4_monitor_dmg() {
  self endon("#\xacG\xb7\xcd\vt\xac");
  self.door.c4 setCanDamage(1);

  while(true) {
    self.door.c4 waittill("\fU`\xc0y\x95", unused, attacker, unused, unused, type);

    if(isDefined(attacker) && attacker == level.player && isDefined(type)) {
      if(type == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
        continue;
      }

      self notify("\xa4\xbc\xc8M65y\x11E$");
    }
  }
}

function c4_detonate() {
  self.door notify("#\xacG\xb7\xcd\vt\xac");
  playsoundatpos(self.origin, "L\xc3\xac\xeb\xc4t\xc1\xab\xcb\xbf\x17\x85P\xdf\xa0\xc8\x1b%\xbe~\bd\xcc\x8a-\x1e\xa8");
  playFX(level._effect["/L\xc7\x973\xf1\x97\x87\x06\xb5\xfb"], self.origin);
  self.door.c4 delete();
  self.door hide();
  earthquake(0.7, 0.8, self.origin, 600);
  radiusdamage(self.origin, 120, 150, 30, level.player, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
  self.door.clip notsolid();

  if(isDefined(self.door.navmodifier)) {
    destroynavobstacle(self.door.navmodifier);
  }

  utility::delaythread(0.5, &door_internal::stealth_broadcast, 500, "\xa3^6\xd74#\xbd");
}

function c4_countdown() {
  self endon("\xa4\xbc\xc8M65y\x11E$");
  thread c4_monitor_dmg();
  wait 0.7;

  for(i = 0; i < 3; i++) {
    playsoundatpos(self.origin, "\r\x85c\xda}9\xf6L\xb7\x8e_\xac\xe1\xc1\xc6o\x19\xac_\x89\xb2Y\x83");
    playFXOnTag(level._effect["T1\xbf\x80\xb7-Bm\x10\xf5\xda\xddN\xc6"], self.door.c4, "I\x01^\x89\x9f\xca");
    wait 0.5;
  }

  for(i = 0; i < 6; i++) {
    playsoundatpos(self.origin, "\r\x85c\xda}9\xf6L\xb7\x8e_\xac\xe1\xc1\xc6o\x19\xac_\x89\xb2Y\x83");
    playFXOnTag(level._effect["T1\xbf\x80\xb7-Bm\x10\xf5\xda\xddN\xc6"], self.door.c4, "I\x01^\x89\x9f\xca");
    wait 0.25;
  }

  for(i = 0; i < 20; i++) {
    playsoundatpos(self.origin, "\r\x85c\xda}9\xf6L\xb7\x8e_\xac\xe1\xc1\xc6o\x19\xac_\x89\xb2Y\x83");
    playFXOnTag(level._effect["_\x1a=\x8dX\xfdT\xf5\x98\xb0Z@"], self.door.c4, "I\x01^\x89\x9f\xca");
    wait 0.1;
  }

  self notify("#\xacG\xb7\xcd\vt\xac");
}

function remove_door_c4_ability() {
  println("<dev string:x7b>" + self getentnum() + "<dev string:x59>" + self.origin);

  if(!istrue(self.c4_breachable)) {
    return;
  }

  self.c4_breachable = 0;
  self notify("\xebe\xd6\xee\xb7\xc1/\xc7\xd3Kz\x1e\xb9z\x98");

  if(isDefined(self.c4_struct)) {
    self.c4_struct cursor_hint::remove_cursor_hint();
  }
}