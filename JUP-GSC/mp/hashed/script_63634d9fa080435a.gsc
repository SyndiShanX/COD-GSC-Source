/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_63634d9fa080435a.gsc
*************************************************/

#using script_63634d9fa080435a;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;
#namespace namespace_fdd19a154a441b5c;

function function_d45fd98510d7b7e9() {
  splashref = "super_high_jump" + "_activate";

  if(getdvarint(@ "hash_a6321fc4dc1000d7", 0)) {
    splashref += "_alt";
  }

  thread scripts\mp\hud_message::showsplash(splashref, undefined, self, undefined, undefined, undefined, 1);
  var_af06892358a3c2f4 = 200;
  powerstruct = spawnStruct();
  powerstruct.hudelem = playerpowersaddhudelem(&"MP_ZXP/CHARGED_JUMP", var_af06892358a3c2f4);
  powerstruct.cooldownsec = getdvarint(@ "hash_e45cb58aa0483dcf", 6);
  powerstruct.ref = "super_jump";
  self.powerstruct = powerstruct;
  function_bd0e084afb0d192f(1);
  thread function_6a991bfd08ea6fc5();
  thread function_1a0b6d22fd3a0ba();
  thread function_2a8b83e2773640c0();
  thread function_4291eedaa7d05e6d();
  return true;
}

function function_8bea7151cf43738d() {
  return function_e0a9daa14c0b948b();
}

function function_e0a9daa14c0b948b() {
  self endon("disconnect");

  while(!self isonground() && scripts\mp\utility\player::isreallyalive(self)) {
    wait 0.1;
  }

  thread function_e4470e4135f2aacc();
  self setclientomnvar("ui_field_upgrade_use", 0);
  self.powerstruct.hudelem.barelem scripts\mp\hud_util::destroyelem();
  self.powerstruct.hudelem scripts\mp\hud_util::destroyelem();
  self.powerstruct = undefined;
  function_bd0e084afb0d192f(0);
  self notify("superJump_end");
  thread scripts\mp\equipment\temp_v::function_269b97f3d86eb172(undefined, undefined, "super_use_finished");
}

function function_e4470e4135f2aacc() {
  self endon("disconnect");
  level endon("game_ended");

  if(!self isonground() && !self isswimming()) {
    self.var_b6aa5954bf6a457a = 1;

    while(scripts\mp\utility\player::isaliveandnotinlaststand(self)) {
      if(self isonground()) {
        waitframe();
        break;
      }

      waitframe();
    }
  }

  self.var_b6aa5954bf6a457a = undefined;
}

function function_4291eedaa7d05e6d() {
  waittill_any_5("death", "last_stand_start", "player_killed", "tempV_end");
}

function function_bd0e084afb0d192f(isactive) {
  if(isactive) {
    scripts\common\values::set("jump_superpower", "allow_jump", 0);
    return;
  }

  scripts\common\values::reset_all("jump_superpower");
}

function function_1a0b6d22fd3a0ba() {
  self endon("superJump_end");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    if(self jumpbuttonPressed() && self isonground() && !istrue(self.powerstruct.incooldown)) {
      function_567bde1e6acc007b();
      continue;
    }

    waitframe();
  }
}

function function_2a8b83e2773640c0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("superJump_end");

  while(true) {
    self waittill("perform_hero_drop");
    self radiusdamage(self.origin, 256, function_751f1fe07d7bf833(), 50, self, "MOD_CRUSH", "high_jump_mp");
    thread function_f5f070b3d96a1c1e();
  }
}

function function_751f1fe07d7bf833() {
  if(!isDefined(self.powerstruct) || !isDefined(self.powerstruct.airtime)) {
    return 50;
  }

  var_4ca7b6a31270c32a = getdvarfloat(@ "hash_710b8f0737994439", 3);
  multfactor = clamp(self.powerstruct.airtime / var_4ca7b6a31270c32a, 0, 1);
  return 500 * multfactor;
}

function function_f5f070b3d96a1c1e() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
}

function function_567bde1e6acc007b(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("tempV_end");
  var_2c602bb60dab6883 = 0.025;
  var_ea41c3f0bdbf3f3a = 0;
  var_a2d1e16b613b535c = 0;
  var_92b09cf3a4719720 = 1300;
  var_3b3681f0d6aae16e = 0.25;
  var_47784f0c32fa1ae1 = 1;
  var_4ca6e232b3a08ae5 = 3;
  var_943d5ecbd9a29e50 = getdvarint(@ "hash_5e1d6a08a06aab7a", var_ea41c3f0bdbf3f3a);
  var_57bd73d0ecaee169 = getdvarfloat(@ "hash_2fc6c2dc7f9c722a", var_2c602bb60dab6883);
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", var_3b3681f0d6aae16e);
  var_e5482b00771c4909 = getdvarint(@ "hash_2a5201ccbcd3b1a1", var_47784f0c32fa1ae1);
  var_6b00aa3867c7f0d9 = getdvarint(@ "hash_69111e35067f9d8f", getdvarfloat(@ "hash_fc090d66639284d3", var_4ca6e232b3a08ae5));
  maxjumpvelocity = getdvarfloat(@ "hash_fd6822a1c2607510", var_92b09cf3a4719720);

  while(!self jumpbuttonPressed()) {
    waitframe();
  }

  charge_lock = getdvarint(@ "hash_7c6a7ce1709f1eff", var_a2d1e16b613b535c);

  if(charge_lock) {
    self.jumplink = spawn("script_model", self.origin);
    self.jumplink setModel("tag_player");
    self playerlinkTo(self.jumplink, "tag_player");
  }

  self.superjumping = 1;
  jumpbar = self.powerstruct.hudelem.barelem;
  fraction = 0;
  up = 1;
  var_715d7709363e068c = undefined;

  while(self jumpbuttonPressed()) {
    jumpbar scripts\mp\hud_util::updatebar(fraction, 0);
    prevfrac = fraction;

    if(up) {
      if(function_eda9454efb18adfe()) {
        self setscriptablepartstate("heroDiveVfx", "charge_pause", 0);
        waitframe();
        continue;
      } else if(function_6653ad92a0329507()) {
        up = 0;
      } else {
        self setscriptablepartstate("heroDiveVfx", "charge_begin", 0);
        fraction += var_57bd73d0ecaee169;

        if(fraction >= 1) {
          fraction = 1;

          if(var_943d5ecbd9a29e50) {
            up = 0;
          } else if(var_6b00aa3867c7f0d9 >= 0) {
            if(!isDefined(var_715d7709363e068c)) {
              var_715d7709363e068c = gettime() + var_6b00aa3867c7f0d9 * 1000;
              thread playerzombiejumpmaxholdwarning(powerref, var_6b00aa3867c7f0d9);
            }

            if(gettime() >= var_715d7709363e068c) {
              break;
            }
          }
        }

        if(prevfrac < var_eec1ca5327266614 && fraction >= var_eec1ca5327266614) {
          jumpbar.bar.color = (0, 1, 0);
        }
      }
    } else {
      self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);
      fraction -= var_57bd73d0ecaee169;

      if(fraction <= 0) {
        fraction = 0;
        up = 1;
      }

      if(prevfrac > var_eec1ca5327266614 && fraction <= var_eec1ca5327266614) {
        jumpbar.bar.color = (1, 1, 1);
      }
    }

    waitframe();
  }

  self notify("jumpChargeEnd");

  if(charge_lock) {
    self unlink();
  }

  canjump = function_d2667047a1186849();

  if(fraction >= var_eec1ca5327266614 && canjump) {
    if(fraction < 0.33) {
      self setscriptablepartstate("heroDiveVfx", "jump_begin_small", 0);
    } else if(fraction < 0.66) {
      self setscriptablepartstate("heroDiveVfx", "jump_begin_med", 0);
    } else {
      self setscriptablepartstate("heroDiveVfx", "jump_begin_lrg", 0);
    }

    player_angles = self getplayerangles();
    self setscriptablepartstate("heroDiveVfx", "jump_begin", 0);
    thread function_856a49ad2900cff6();
    playerapplyjumpvelocity(player_angles, maxjumpvelocity, fraction);
  } else {
    self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);

    if(var_e5482b00771c4909) {
      jumpbar.bar.frac = 0;
    }
  }

  function_d59d137d348a395d(powerstruct, powerref, 1);
}

function function_55ce74e815a78a70() {
  return !function_d2667047a1186849();
}

function function_d2667047a1186849() {
  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return false;
  }

  if(self ismantling()) {
    return false;
  }

  if(!self isonground() || self isswimming()) {
    return false;
  }

  if(!scripts\mp\utility\player::isaliveandnotinlaststand(self)) {
    return false;
  }

  if(self getstance() == "prone") {
    return false;
  }

  if(isDefined(self.carryobject)) {
    return false;
  }

  raystart = scripts\mp\utility\player::getstancecenter();
  radius = 16;
  rayend = scripts\mp\utility\player::getstancetop() + anglestoup(self.angles) * 100;
  contents = scripts\engine\trace::create_default_contents(1);

  level thread scripts\mp\utility\debug::drawsphere(raystart, radius, 10, (0, 1, 0));
  level thread scripts\mp\utility\debug::drawsphere(rayend, radius, 10, (0, 1, 0));

  if(!scripts\engine\trace::sphere_trace_passed(raystart, rayend, radius, self, contents)) {
    return false;
  }

  return true;
}

function function_6653ad92a0329507() {
  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return true;
  }

  if(!self isonground() || self isswimming()) {
    return true;
  }

  if(!scripts\mp\utility\player::isaliveandnotinlaststand(self)) {
    return true;
  }

  if(isDefined(self.carryobject)) {
    return true;
  }

  return false;
}

function function_eda9454efb18adfe() {
  if(self ismantling()) {
    return true;
  }

  if(self getstance() == "prone") {
    return true;
  }

  return false;
}

function playerpowersaddhudelem(label, currenthudy) {
  hudelem = scripts\mp\hud_util::createfontstring("default", 1.5);
  hudelem.alignx = "left";
  hudelem.aligny = "top";
  hudelem.horzalign = "left_adjustable";
  hudelem.vertalign = "top_adjustable";
  hudelem.alpha = 1;
  hudelem.glowalpha = 0;
  hudelem.hidewheninmenu = 1;
  hudelem.archived = 0;

  if(isDefined(label)) {
    hudelem.label = label;
  }

  barelem = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  barelem.x = 13;
  barelem.y = currenthudy;
  barelem.alignx = "left";
  barelem.aligny = "top";
  barelem.horzalign = "left_adjustable";
  barelem.vertalign = "top_adjustable";
  barelem shiftbar();
  barelem.archived = 0;
  barelem.hidewheninmenu = 1;
  barelem.bar.archived = 0;
  barelem.bar.hidewheninmenu = 1;
  hudelem.barelem = barelem;
  return hudelem;
}

function shiftbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

function playerzombiejumpmaxholdwarning(powerref, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("jumpChargeEnd");

  if(time <= 0) {
    return;
  }

  jumpbar = self.powerstruct.hudelem.barelem;
  waittimes = scripts\mp\gametypes\br_circle::array_init_distribute(time, int(time * 5), 1);
  color = 1;

  for(i = 0; i < waittimes.size; i++) {
    if(color) {
      jumpbar.bar.color = (1, 0, 0);
    } else {
      jumpbar.bar.color = (0, 1, 0);
    }

    wait waittimes[i];
    color = !color;
  }
}

function playerapplyjumpvelocity(angledir, maxjumpvelocity, fraction) {
  var_355760d151d56e05 = 1;
  player_angles = angledir;
  movementdir = vectorNormalize(self getvelocity());
  forwarddir = anglesToForward(self.angles);
  dot = vectordot(movementdir, forwarddir);
  var_441b8b8d8d1bbe0 = dot > 0.875 || dot == 0;

  if(!var_441b8b8d8d1bbe0) {
    movementtoangles = vectortoangles(movementdir);
    player_angles = (player_angles[0], movementtoangles[1], movementtoangles[2]);
  }

  if(getdvarint(@ "hash_ce6d7d66848cdbcc", var_355760d151d56e05)) {
    ground_normal = get_ground_normal();

    if(!isDefined(ground_normal)) {
      ground_normal = (0, 0, 1);
    }

    yawangles = (0, player_angles[1], 0);
    right = anglestoright(yawangles);
    fwd = vectorcross(ground_normal, right);
    [ground_pitch] = vectortoangles(fwd);
    min_pitch = -85;
    max_pitch = ground_pitch;
    player_pitch = player_angles[0];

    if(ground_pitch > 90 || ground_pitch < -90) {
      ground_pitch = ground_pitch % 90 * -1;
    }

    if(player_pitch > ground_pitch) {
      player_pitch = ground_pitch;
    }

    var_e6bc250926c6d64d = getdvarfloat(@ "hash_9ec479015407c245", -45);
    var_e6980f09269e2b33 = getdvarfloat(@ "hash_9ee78301542e1ffb", 0);
    frac = (player_pitch - min_pitch) / (max_pitch - min_pitch);
    var_aee49e405bf58492 = var_e6980f09269e2b33 + frac * (var_e6bc250926c6d64d - var_e6980f09269e2b33);
    player_angles = (player_pitch + var_aee49e405bf58492, player_angles[1], player_angles[2]);
  }

  pitch_add = getdvarfloat(@ "hash_cf56037c34ea141f", 0);

  if(pitch_add != 0) {
    player_angles = (player_angles[0] + pitch_add, player_angles[1], player_angles[2]);
  }

  dir = anglesToForward(player_angles);
  velocity = dir * fraction * maxjumpvelocity;
  self setOrigin(self.origin + (0, 0, 20));
  self setvelocity(velocity);
}

function function_d59d137d348a395d(powerstruct, powerref, docooldown) {
  if(istrue(docooldown)) {
    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  if(isDefined(self.jumplink)) {
    self.jumplink delete();
  }

  self.superjumping = undefined;
}

function playerpowerstartcooldown(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("tempV_unset");
  self endon("tempV_set");
  self endon("superJump_end");
  self endon("disableCooldown");

  if(!isDefined(self.powerstruct) || istrue(self.powerstruct.incooldown)) {
    return;
  }

  powerbar = self.powerstruct.hudelem.barelem;

  if(powerbar.bar.frac > 0) {
    self.powerstruct.incooldown = 1;
    cooldownsec = self.powerstruct.cooldownsec;
    fraction = powerbar.bar.frac;
    cooldownsec *= fraction;
    powerbar.bar.color = (1, 0.6, 0);
    powerbar.bar scaleovertime(cooldownsec, 0, powerbar.height);
    self setclientomnvar("ui_super_high_jump_progress", int(fraction * 100));
    wait cooldownsec;
    namespace_1f2efdb89e5f3a6e::function_bd0e084afb0d192f(1);
    self.powerstruct.incooldown = 0;
    self notify("superJump_cooldownEnd");
  } else {
    powerbar scripts\mp\hud_util::updatebar(0, 0);
  }

  powerbar.bar.color = (1, 1, 1);
}

function get_ground_normal(traceignore, debug) {
  if(!isDefined(traceignore)) {
    ignore = self;
  } else {
    ignore = traceignore;
  }

  if(!isDefined(debug)) {
    debug = 0;
  }

  ignorelist = [ignore];
  tracepoints = [self.origin];
  i = -1;

  while(i <= 1) {
    j = -1;

    while(j <= 1) {
      corner = ignore getpointinbounds(i, j, 0);
      corner = (corner[0], corner[1], self.origin[2]);
      tracepoints[tracepoints.size] = corner;
      j += 2;
    }

    i += 2;
  }

  avgnormal = (0, 0, 0);
  tracehitcount = 0;

  foreach(point in tracepoints) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    tracehit = trace["fraction"] > 0 && trace["fraction"] < 1;

    if(tracehit) {
      avgnormal += trace["normal"];
      tracehitcount++;
    }

    if(debug) {
      if(tracehit) {
        line(point, point + trace["<dev string:x1c>"] * 30, (0, 1, 0));
        continue;
      }

      sphere(point, 3, (1, 0, 0));
    }
  }

  if(tracehitcount > 0) {
    avgnormal /= tracehitcount;

    if(debug) {
      line(self.origin, self.origin + avgnormal * 20, (1, 1, 1));
    }

    return avgnormal;
  }

  if(debug) {
    sphere(self.origin, 5, (1, 0, 0));
  }

  return undefined;
}

function function_c0d0374f0a3d354e() {
  level endon("game_ended");
  self endon("death_or_disconnect");
}

function function_95adb84c5ca51c36() {
  return isDefined(self.powerstruct) && isDefined(self.powerstruct.ref) && istrue(self.powerstruct.ref == "super_jump");
}

function function_3a307fd8eb4f27eb() {
  if(self isskydiving()) {
    self skydive_interrupt();
  }

  self notify("perform_hero_drop");
  return false;
}

function function_856a49ad2900cff6() {
  self endon("death_or_disconnect");
  self endon("superJump_end");
  level endon("game_ended");

  if(!isDefined(self.powerstruct)) {
    return;
  }

  self.powerstruct.airtime = 0;

  while(isDefined(self.powerstruct)) {
    if(self isonground()) {
      if(self.powerstruct.airtime > 0) {
        break;
      }
    } else {
      self.powerstruct.airtime += level.framedurationseconds;
    }

    waitframe();
  }

  namespace_1f2efdb89e5f3a6e::function_bd0e084afb0d192f(0);
}

function function_6a991bfd08ea6fc5() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("superJump_end");
  self endon("temp_v_finished");

  while(true) {
    if(self isonladder() || self ishanging()) {
      namespace_1f2efdb89e5f3a6e::function_bd0e084afb0d192f(0);
    } else {
      namespace_1f2efdb89e5f3a6e::function_bd0e084afb0d192f(1);
    }

    waitframe();
  }
}