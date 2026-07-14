/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\nvg\nvg_ai.gsc
**************************************/

#using scripts\anim\shared;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#namespace nvg_ai;

function nvg_ai_init() {
  ai = getaiarray();

  foreach(guy in ai) {
    guy thread nvg_ai();
  }

  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &nvg_ai);
  utility_sp::add_global_spawn_function("O\x15\x1b\xad\x9ff", &nvg_ai);
  utility_sp::add_global_spawn_function("\xba\xa5\x1f\xc9m\x80i", &nvg_ai);

  setdvarifuninitialized(@ "hash_4249b712406badc9", 0);
  thread function_18876f44a08d8a57();

  utility::array_thread(getEntArray("\x185\xe0\x8fRH\xbbXYnM\x83\xc5{", #targetname), &dynolight_area_trigger_logic);
}

function nvg_ai() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 0.05;
  local_init();
  ai_nvg_player_update();
  thread nvg_death_cleanup();
}

function do_flir_footsteps(vfx_override) {}

function dont_do_flir_footsteps() {}

function local_init() {
  utility::ent_flag_init("\x1d\xbd#\x1d\x9b\x12\x9e\xfa\xeb\xb8\xb30 \x84\x06\x98\xe1\xe6\xbe");
  utility::ent_flag_init("{,\xfb-\xab\x9b\xb5_vd\xf3");

  if(istrue(level.is_dark)) {
    utility::ent_flag_set("{,\xfb-\xab\x9b\xb5_vd\xf3");
  }
}

function ai_nvg_player_update() {
  if(!should_update_ai_nvg_state()) {
    return;
  }

  nvg_state = level.player isnightvisionon();

  if(isDefined(self.custom_nvg_update_func)) {
    self thread[[self.custom_nvg_update_func]](nvg_state);
  }
}

function should_update_ai_nvg_state() {
  if(self.classname == "\xd6\xbc\x99\vL\xcd?\xc1]-\xfe\xf6\xad\xe5\xaf\xc8k\xd8\xec\x0f3\b\\\bjL") {
    return false;
  }

  return true;
}

function dynolight_area_trigger_logic() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", whom);

    if(!isai(whom)) {
      continue;
    }

    if(!isDefined(whom.in_dynolight_trigger) && !isDefined(whom.nvg_goggles)) {
      whom childthread dynolight_area_ai(self);
    }
  }
}

function dynolight_area_ai(trigger) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.in_dynolight_trigger = trigger;
  thread enable_ai_dynolight_behavior();

  while(self istouching(trigger)) {
    wait 0.05;
  }

  disable_ai_dynolight_behavior();
}

function enable_ai_dynolight_behavior() {
  utility::ent_flag_set("\x1d\xbd#\x1d\x9b\x12\x9e\xfa\xeb\xb8\xb30 \x84\x06\x98\xe1\xe6\xbe");
}

function updatelightmeter() {
  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]() && !istrue(self.reacttodynolightsinhunt)) {
    self.lightmeter = undefined;
    return;
  }

  if(distancesquared(self.origin, level.player.origin) > 4000000) {
    return;
  }

  if(!isDefined(level.castingdynolights) || level.castingdynolights.size == 0) {
    self.lightmeter = istrue(level.is_dark) ? 0 : 1;
    return;
  }

  curtime = gettime();

  if(!isDefined(level.lastdynolightcleantime) || curtime == level.lastdynolightcleantime) {
    level.castingdynolights = utility::array_removeundefined(level.castingdynolights);
    level.lastdynolightcleantime = curtime;
  }

  mylights = sortbydistance(level.castingdynolights, self.origin);
  myeyepos = self getapproxeyepos();
  var_ce407281e6810ba = 9999999;

  if(isDefined(self.lightmeter_lastcheckpos)) {
    var_ce407281e6810ba = distancesquared(self.lightmeter_lastcheckpos, self.origin);
  }

  if(!isDefined(self.lightmeter_lastchecktime)) {
    self.lightmeter_lastchecktime = -1000;
  }

  lightstocheck = [];
  distsqtocheck = [];
  radiitocheck = [];
  var_661e0dace343250d = var_ce407281e6810ba > 900;
  cmaxdistsq = 998001;
  numlights = mylights.size;

  for(ilight = 0; ilight < numlights; ilight++) {
    dynolight = mylights[ilight];
    dist_sq = distancesquared(myeyepos, dynolight.origin);

    if(dist_sq > cmaxdistsq) {
      break;
    }

    if(!var_661e0dace343250d && dynolight.timeoflaststatechange >= self.lightmeter_lastchecktime) {
      var_661e0dace343250d = 1;
    }

    if(!dynolight.alive) {
      continue;
    }

    if(dynolight getscriptablepartstate("\xa8\f\x95\xd1\x1d") == "\xf8\x88m") {
      continue;
    }

    radiustocheck = 650;

    if(isDefined(dynolight.data)) {
      if(istrue(dynolight.data.script_ignoreme)) {
        continue;
      }

      if(istrue(dynolight.data.script_radius)) {
        radiustocheck = dynolight.data.script_radius;

        if(dist_sq > radiustocheck * radiustocheck) {
          continue;
        }
      }

      if(dynolight.data.script_type == "\x02\x7f\xe0\v\xf3\xc3 \xb8\x1a\xd5") {
        if(getdvarint(@ "hash_4249b712406badc9")) {
          dynolight draw_spotlight_fov();
        }

        fov = dynolight.data.script_fov_inner;
        angles = dynolight.data.angles;
        start = dynolight.lightpos;

        if(!utility::within_fov(start, angles, myeyepos, cos(fov))) {
          continue;
        }
      }
    }

    if(!dynolight istouching(self.in_dynolight_trigger)) {
      continue;
    }

    var_a4908249deda37ef = lightstocheck.size;
    lightstocheck[var_a4908249deda37ef] = dynolight;
    radiitocheck[var_a4908249deda37ef] = radiustocheck;
    distsqtocheck[var_a4908249deda37ef] = dist_sq;
  }

  if(var_661e0dace343250d) {
    var_4319b96af8277759 = 0;
    tracedata = spawnStruct();
    disttogoal = self pathdisttogoal();
    var_83a0310bb0191ba8 = 32;
    tracedata.bmoving = lengthsquared(self.velocity) > 1 || disttogoal > var_83a0310bb0191ba8;
    eyeoffset = self getapproxeyepos() - self.origin;

    if(tracedata.bmoving) {
      tracedata.pointsonpath = [];
      tracedata.pointsonpath[0] = self.origin + eyeoffset;
      tracedata.pointsonpath[1] = self getposonpath(var_83a0310bb0191ba8) + eyeoffset;

      if(disttogoal > var_83a0310bb0191ba8 * 2) {
        tracedata.pointsonpath[2] = self getposonpath(var_83a0310bb0191ba8 * 2) + eyeoffset;
      }
    }

    numlights = lightstocheck.size;

    for(ilight = 0; ilight < numlights; ilight++) {
      dynolight = lightstocheck[ilight];
      dist = sqrt(distsqtocheck[ilight]);
      radiustocheck = radiitocheck[ilight];
      falloff_dist = 0;

      if(isDefined(dynolight.data) && isDefined(dynolight.data.script_percent)) {
        falloff_dist = dynolight.data.script_percent;
      } else if(isDefined(level.dynolight_falloff_dist)) {
        falloff_dist = level.dynolight_falloff_dist;
      }

      light_factor = (1 - math::normalize_value(radiustocheck * falloff_dist, radiustocheck, dist)) * dynolight.intensity;

      if(!dynolight_trace_passed(dynolight, tracedata)) {
        continue;
      }

      var_4319b96af8277759 += light_factor;

      if(getdvarint(@ "hash_4249b712406badc9")) {
        line(dynolight.lightpos, self.origin, (light_factor, light_factor, light_factor), 1, 0, 10);
      }

      if(var_4319b96af8277759 > 0.5) {
        break;
      }
    }

    self.lightmeter = var_4319b96af8277759;
    self.lightmeter_lastchecktime = gettime();
    self.lightmeter_lastcheckpos = self.origin;
  }
}

function dynolight_trace_passed(dynolight, tracedata) {
  ignorearray = [level.player];

  if(isDefined(dynolight.linked_ents)) {
    ignorearray = utility::array_combine(ignorearray, dynolight.linked_ents);
  }

  if(istrue(tracedata.bmoving)) {
    ignorearray = utility::array_combine(ignorearray, [dynolight, self]);
    assert(isDefined(tracedata.pointsonpath));
    var_9aa3006e622d0717 = tracedata.pointsonpath.size;

    for(i = 0; i < var_9aa3006e622d0717; i++) {
      pathpos = tracedata.pointsonpath[i];

      if(trace::ray_trace_passed(dynolight.lightpos, pathpos, ignorearray, level.dynolight_trace_contents)) {
        if(getdvarint(@ "hash_4249b712406badc9") && i != 0) {
          line(dynolight.lightpos, pathpos, (0, 1, 0.5), 1, 0, 20);
        }

        return 1;
      }
    }

    return 0;
  }

  return dynolight utility::can_trace_to_ai(dynolight.lightpos, self, ignorearray, level.dynolight_trace_contents);
}

function is_gun_raised() {
  if(isnullweapon(self.weapon)) {
    return false;
  }

  return self gettagorigin("\xc7\xae?f\x10\xbcr")[2] - self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84")[2] <= 15;
}

function draw_spotlight_fov() {
  fov_yaw = acos(cos(self.data.script_fov_inner));
  eye_yaw = self.data.angles[1];
  pitch = self.data.angles[0];
  color = (1, 0, 0);
  viewdist = self.data.script_radius;
  start = self.lightpos;
  arc_segs = 10;

  if(abs(pitch - 90) < 1) {
    thread utility::draw_circle(start, viewdist, (1, 0, 0), 1, 0, 4);
    return;
  }

  debug::draw_arc(start, -1 * fov_yaw, fov_yaw, (pitch, eye_yaw, 0), viewdist, 1, arc_segs, color);
}

function draw_flashlight_fov() {
  dot = cos(30);
  color = (1, 0, 0);
  fov_yaw = acos(dot);
  eye_yaw = self gettagangles("\xfd\xef\xc3\r\xb4\xad\x84p\x84")[1];
  viewdist = 500;
  start = self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84");
  arc_segs = 10;

  debug::draw_arc(start, -1 * fov_yaw, fov_yaw, self gettagangles("<dev string:x24>"), viewdist, 1, arc_segs, color);
}

function disable_ai_dynolight_behavior() {
  self.in_dynolight_trigger = undefined;
  self.lightmeter = undefined;
  self.maxsightdistsqrd = 67108864;
  level.player.dontmeleeme = 0;
  utility::ent_flag_clear("\x1d\xbd#\x1d\x9b\x12\x9e\xfa\xeb\xb8\xb30 \x84\x06\x98\xe1\xe6\xbe");

  if(istrue(level.is_dark)) {
    utility::ent_flag_set("{,\xfb-\xab\x9b\xb5_vd\xf3");
    return;
  }

  utility::ent_flag_clear("{,\xfb-\xab\x9b\xb5_vd\xf3");
}

function function_18876f44a08d8a57() {
  answer = "<dev string:x31>";

  while(true) {
    foreach(guy in getaiarray()) {
      if(isDefined(guy.lightmeter) && guy utility::ent_flag_exist("<dev string:x35>")) {
        num = guy getentitynumber();
        answer = guy.lightmeter < 0.5 ? "<dev string:x4c>" : "<dev string:x53>";

        if(getdvarint(@ "hash_4249b712406badc9")) {
          print3d(guy.origin + (0, 0, 85), "<dev string:x59>" + num + "<dev string:x61>" + distance2d(guy.origin, level.player.origin), (1, 1, 1), 1, 0.6, 1);
          print3d(guy.origin + (0, 0, 78), "<dev string:x59>" + num + "<dev string:x76>" + sqrt(guy.maxsightdistsqrd), (1, 1, 1), 1, 0.6, 1);
          print3d(guy.origin + (0, 0, 71), "<dev string:x59>" + num + "<dev string:x89>" + guy.lightmeter, (guy.lightmeter, guy.lightmeter, guy.lightmeter), 1, 0.6, 1);
          print3d(guy.origin + (0, 0, 64), "<dev string:x9b>" + answer, (1, 1, 1), 1, 0.6, 1);

          if(istrue(guy.flashlight) && guy is_gun_raised()) {
            guy thread draw_flashlight_fov();
          }
        }
      }
    }

    wait 0.05;
  }
}

function nvg_death_cleanup() {
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self)) {
    return;
  }

  if(is_using_flashlight()) {
    kill_flashlight_fx(0);
  }
}

function flashlight_on(bsafe) {
  if(!can_use_flashlight()) {
    return;
  }

  if(is_using_flashlight()) {
    return;
  }

  function_d82d591f9bca94e6();
  self.flashlight = 1;
  play_flashlight_fx(bsafe);

  if(isDefined(self.flashlightlaserweapon)) {
    flashlight_laser_on();
  }
}

function function_d82d591f9bca94e6() {
  attachments_names = ["\xeaqo\x82+<\xab\x1f\n\x83)\x1e\xbf\xf9b\xf9", "\x1fU-\xeb\x90\xb0\xe7\bh\xf3t\xb0~\xc8\xd5\xf4", "/m\x7f\x89\x89\xdd\x98*\xba\xb4MR6\xcf\xc8o\xbd", "\xaa\x91p8Q?\x15p\xd3\x1d1\xd0t\x16\xb3\xf0\xf6\xc2\x1f\x01%\xd5_\x15\xf3\xfdE;", "\\aqU\x8c}t\xe7\xf0xs\xccwC\xbc9[\x15\xb0E\x80FZ\xe2\xeedZ\xc7", "\xf6Y\xf8<8\x86 4\xa8z\x98S\x14x\x7f\x8fD\x9f\x10WN;;\x86\x9a\x83\xc8\xa4", "\x9e\b\xb5(\x94T\x18\xa6\xa2\x1e\x1c\xafP\f\x14k\x9b\x15\xb9\xec\x8fP0\xeb\x1a\xc0\xc1\xbd\xfa", "|\x9fm\x10\xe0\xafBP\x02V\ag\xb0C\xeah`MoHT\x13\xc6BvN\xaf\xe6\xa0n", "p4\x92\x89\xdas\x92\x16\x8bdFQ9\xa4\xb6\xb8\x9a$y0#):\x88yK\x9e", "\xa0\xe0\xf7k_\xdb\x02L=\"1.\x1c\xb3\xf5pQes{\xae\xeb\xc8\xac\xdcz\x95\x1a\xc9", "\xdf_Y`h\x16-\xdb\xd71\xa5R\x14\x9cs\xfa\xe0E\x17\xe1\x95\x7f5w\xc6\xcdu\xac", "\x9fG86\r\x19-q\xf4\xac\x98M\xba\n\x10\xe6ZB\x887/\x18\xa74\xf1\xa9\x9aj:\xad", "%dt\xbd\xd1\xe9\xd2\x87B3\xd1p\x9b\xe6\x1e#\xd5\xb4\xce\x102\xe9\xfft8D\x89\x1c\xc8!\xd1", "+\xd6\b?\x959\xec\x04X\xec\xe1\x99g9\xa7\xbe\xf4\x87\x01?\xbd(\x1c\\H\xe4L\x91\x8b", "\xd8\xa7\x01\xc2\xe8A\xfd\x7f4}\x86`|\xe9}j[\x7f\xa8\xcd\b\xc4%=\xf4\xc6\x85@\xa5\xe0\xd5", "\xee0\xd3 \x94gi\x99dq\xe7\xce\xd04\x9b\xd1\vB\xac\x84\xfbt\xda\xb1\xeb\xadH\xffHt\x11", "b'\xb7\xd7\xf5\x1a\xb9\xd2p\xb0\xcf\xab&\xfaK\xd0\x7f\xeft\x8d\xf1\xa45H\xbd:\xe6w>", "e~t\xc6y\xfc\xed\"\xbb\xe8\xfa\v\xc3\xc4\xc0\x1e\xefl\\;`\x1d{)\f;\xa2'", "\xa8\x02b\xd6\xad\x15#\x84\"\"\xe4\xadg<\xf8\xbe\x90Pt\xd6EUA2\xb8+UE\xb5b", "\x0e\xf4\xb3\xc6x\xb2\x965pe\x849C\xf4t\xa6\xbe\xd8\xa905MQ4C#\x8a\xd9\n", "\x89\xa48\xfbw\xc0{9\xb3\x99H\x82\xfd\x87\x8c\x82\xd5\xe3\xc6\x94\xe1xH\x1a\xfd\x05\xc3D\xaaw\xe0", "\x8eL\xc0\xfa\xc6ase\xc9n}\xb5\xd2\x1el\x85\xe6\x95\x9c\xbe\xdc\xd0\xbe\xd6\xbd\xb96\xdeM\x06\xc0", "\xe3\xbcU\x1b\xc2b\xf0ji\x10u@w\xb1SA\a\x1d7\v|\xf6\x91\b\xcaP\xec\xd1\xd7W", "w\xd9\x10W\xf0\xbdpY+\xf6\x1cEm&\x91\x8a\xf3/jU\x05\xac1\x9c\x7f\xfb\x1fq:", "A2B\x18O\x92tA\x99x\x01\xf0\xd7t\x91\xfe\x04\xbf\r\x88\xf0\x10+'s\xb9>\xfep", "V\xb4)z\xbe~\xf2\b\xd2\v\x94@\xfcp!\t\xf8-uw\x1f\b\x84\xaf\xa0\xd3+\xe5\xc9\xf2A", "\x9b-u\xf1p@\xae8gQ\xaf\xf1Y\xb2a\xb0\x9f\xfd\xbdP\xc5\xaa\x99YB\x9e\xab\xb0\x9f.", "\xee\xf9'\xca\xcdf\x04\xea\x06\x12l\v\x13\x8f\xc9#y6\xb6\x19X\x02V\xdd\xaelG,", "\xb8\xd2l\xef\xdf\xc1\xde&\x8c\xb8\xd3U\x16(\xf9\x80SD\x14O\x1fb\xbd\xad{\xba6\r\xdc ", "\x8d\xf6t>\xd70/\xa3y\xde\xd2\xb8\xf0\x17B,\xe9\x95|\xb3\xbc\xc0\xf9\xa0\xbe\xef\x10\xf1v", "\x94\x13\xcb\xd2J\xfa\xf0\x02\xdf\xb0\x19\x1a\xbfI^\xf0\x88_\xeb2\x81*\x9c\xa6*v\x9a\x13H", "\xfd^8V\xd9\x8b\xe8\xb9[\xe8D\xf9\xe01\xf5[\x01\xc4t\xa622l\xbb\x98\b\xca\xb0\xf1t"];
  currweapon = self.weapon;
  newweapon = undefined;

  foreach(attachment_name in attachments_names) {
    if(currweapon canuseattachment(attachment_name)) {
      newweapon = currweapon withattachment(attachment_name);
      self.flashlight_attachment = attachment_name;
      break;
    }
  }

  if(!isDefined(newweapon)) {
    return;
  }

  slot = "\xe6\xaa6=\x93`Y";

  if(self.secondaryweapon == currweapon) {
    slot = "\x1f^\xe8UA\nY\xd7!";
  }

  if(self.lastweapon == currweapon) {
    self.lastweapon = newweapon;
  }

  self.flashlightfxtag = "fJn\xc8\x10r\xf3\x94\xf6";
  self.flashlightfxoverridetag = "fJn\xc8\x10r\xf3\x94\xf6";
  self.flashlight_slot = slot;
  shared::detachweapon(currweapon);
  shared::forceuseweapon(newweapon, slot);
}

function flashlight_off(bsafe) {
  if(!is_using_flashlight()) {
    return;
  }

  self.flashlight = 0;
  kill_flashlight_fx(bsafe);

  if(isDefined(self.flashlightlaserweapon)) {
    flashlight_laser_off();
  }
}

function flashlight_laser_on() {
  if(isDefined(self.flashlightlaser)) {
    return;
  }

  laser = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
  laser linkTo(self, self.flashlightfxtag, (0, 0, 0), (0, 0, 0));
  laser setModel("fJn\xc8\x10r\xf3\x94\xf6");
  laser setmoverlaserweapon(self.flashlightlaserweapon);
  laser laserforceon();
  self.flashlightlaser = laser;
  thread flashlight_laser_cleanup();
}

function flashlight_laser_cleanup() {
  self endon("\xe63HbY\xa2\xf2\xd8\x0e\x98\xe3\x1aA\x19\x8f\xe3\xd0\xf7\xc9\xda");
  self waittill("\x1e\xfd\xd1\xa2\a");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
}

function flashlight_laser_off() {
  if(!isDefined(self.flashlightlaser)) {
    return;
  }

  self notify("\xe63HbY\xa2\xf2\xd8\x0e\x98\xe3\x1aA\x19\x8f\xe3\xd0\xf7\xc9\xda");
  self.flashlightlaser laserforceoff();
  self.flashlightlaser delete();
  self.flashlightlaser = undefined;
}

function play_flashlight_fx(bsafe) {
  tag = "\xfd\xef\xc3\r\xb4\xad\x84p\x84";

  if(isDefined(self.flashlightfxoverridetag)) {
    tag = self.flashlightfxoverridetag;
  }

  fx = "Au\x9b^\x132\xf5\x04\x19\xe5\x9e\xff\x9c\xf5";

  if(isDefined(self.flashlightfxoverride)) {
    fx = self.flashlightfxoverride;
  }

  self.flashlightfx = fx;
  self.flashlightfxtag = tag;

  if(!isDefined(bsafe)) {
    bsafe = 1;
  }

  if(bsafe) {
    utility_sp::fx_playontag_safe(self.flashlightfx, self.flashlightfxtag, undefined, undefined, 1);
    return;
  }

  playFXOnTag(utility::getfx(self.flashlightfx), self, self.flashlightfxtag);
}

function kill_flashlight_fx(bsafe) {
  if(!isDefined(self.flashlightfxtag) || self.flashlightfxtag == "\xfd\xef\xc3\r\xb4\xad\x84p\x84" || self.flashlightfxtag == "fJn\xc8\x10r\xf3\x94\xf6" || self.flashlightfxtag == "\xac\x83ZWb\xdc\x8bF\xb4g\xa2\xf4T3F\\") {
    if(isnullweapon(self.weapon)) {
      return;
    }
  }

  if(isDefined(self.flashlightfx)) {
    tag = "\xfd\xef\xc3\r\xb4\xad\x84p\x84";

    if(isDefined(self.flashlightfxtag)) {
      tag = self.flashlightfxtag;
    }

    if(!isDefined(bsafe)) {
      bsafe = 1;
    }

    if(bsafe) {
      utility_sp::fx_killontag_safe(self.flashlightfx, tag, undefined, undefined, 1);
    } else if(self tagexists(tag)) {
      killfxontag(utility::getfx(self.flashlightfx), self, tag);
    }
  }

  self.flashlightfx = undefined;
  self.flashlightfxtag = undefined;
}

function is_using_flashlight() {
  if(istrue(self.flashlight)) {
    return 1;
  }

  return 0;
}

function is_using_nvg() {
  if(istrue(self.nvg)) {
    return 1;
  }

  return 0;
}

function can_use_flashlight() {
  if(isDefined(self.noflashlight) && self.noflashlight) {
    return false;
  }

  if(!(isDefined(self.a) && isDefined(self.a.weaponpos)) || isundefinedweapon(self.a.weaponpos["o0\xee\xc1\x8c"])) {
    return false;
  }

  return true;
}