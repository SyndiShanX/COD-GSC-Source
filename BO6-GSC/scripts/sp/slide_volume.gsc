/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\slide_volume.gsc
***************************************/

#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace slide_volume;

function slidetriggerplayerthink(trig) {
  if(!isDefined(self.var_a0422cdb9620ddb0)) {
    self.var_a0422cdb9620ddb0 = 0;
  }

  if(self.var_a0422cdb9620ddb0) {
    return;
  }

  if(isDefined(self.vehicle)) {
    return;
  }

  if(self issprintsliding() || self isjumping()) {
    return;
  }

  if(isDefined(self.player_view)) {
    return;
  }

  if(function_7063b61e3bdedcf0()) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  if(self isparachuting()) {
    self skydive_interrupt();
  }

  if(soundexists("\xb8\xab:g'\xbb\xd7\xbe\xbe\xe3\xc4-g\xf0mx\x96\x17qI%\xb4\x1f\x9f\x0e\xc3\x830Ts1\xdf")) {
    self playSound("\xb8\xab:g'\xbb\xd7\xbe\xbe\xe3\xc4-g\xf0mx\x96\x17qI%\xb4\x1f\x9f\x0e\xc3\x830Ts1\xdf");
  }

  accel = undefined;

  if(isDefined(trig.script_accel)) {
    accel = trig.script_accel;
  }

  self endon("d\xeck\xfbm\x9c\x9c\x1e\xd3y\xddhvY");
  level.slidesurface = "\x91\xca\xcc\v\xab\xd8:";

  if(getdvarint(@ "hash_69fdaf7cc701b6b", 0) > 0) {
    thread function_12d139c97a1b712c();
  }

  if(getdvarint(@ "hash_4c481f7e26afb913") > 0) {
    thread beginslidinglegacy();
  } else {
    thread beginsliding(undefined, accel, undefined, trig.script_gesture, trig.script_noteworthy);
  }

  while(true) {
    if(!self istouching(trig)) {
      break;
    }

    if(self.var_a0422cdb9620ddb0) {
      thread function_f529968ecf3c2d89(trig);
      break;
    }

    waitframe();
  }

  if(isDefined(level.end_slide_delay)) {
    wait level.end_slide_delay;
  }

  if(getdvarint(@ "hash_4c481f7e26afb913") > 0) {
    endslidinglegacy();
    return;
  }

  endsliding(trig.script_stance, trig.script_damage, trig.script_gesture, trig.script_noteworthy);
}

function doslide(slidemodel, allowedacceleration, var_66ecd364519ab05d) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");
  player = self;
  last_pos = slidemodel.origin;
  current_pos = slidemodel.origin;
  angle_vec = undefined;
  thread function_864b1942290d53b8();

  while(true) {
    movement = player getnormalizedmovement();
    forward = anglesToForward(player.angles);
    right = anglestoright(player.angles);
    movement = (movement[1] * right[0] + movement[0] * forward[0], movement[1] * right[1] + movement[0] * forward[1], 0);
    slidemodel.slidevelocity += movement * allowedacceleration;
    player.fx_tag.origin = slidemodel.origin + anglesToForward(slidemodel.gesture_target.angles) * 400;
    waitframe();
    slidemodel.slidevelocity *= 1 - var_66ecd364519ab05d;
  }
}

function function_7063b61e3bdedcf0() {
  return utility::ent_flag_exist("C\b\xca\xc0V\xa8\xb5;E\xb7") && utility::ent_flag("C\b\xca\xc0V\xa8\xb5;E\xb7");
}

function function_569475ec2a687128() {
  self endon("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(self.slidemodel)) {
    trace_contents = trace::create_contents(0, 1, 0, 0, 0, 0);
    trace = trace::ray_trace(self getEye(), self getEye() - (0, 0, 100), self, trace_contents);
    normal = trace["<dev string:x24>"];
    var_571e878ddac8cd11 = vectorNormalize(vectorcross(normal, (0, 1, 0)));
    var_9b8dae28a4f9f0a2 = vectorNormalize(vectorcross(normal, var_571e878ddac8cd11));
    thread utility::draw_line_for_time(trace["<dev string:x2e>"], trace["<dev string:x2e>"] + normal * 50, 1, 0, 0, 10);
    thread utility::draw_line_for_time(trace["<dev string:x2e>"], trace["<dev string:x2e>"] + var_571e878ddac8cd11 * 50, 0, 1, 0, 10);
    thread utility::draw_line_for_time(trace["<dev string:x2e>"], trace["<dev string:x2e>"] + var_9b8dae28a4f9f0a2 * 50, 0, 0, 1, 10);
    thread utility::draw_line_for_time(self.origin, self.origin + anglesToForward(self.angles) * 50, 1, 1, 0, 10);

    waitframe();
  }
}

function function_f529968ecf3c2d89(slidevolume) {
  self endon("\x1e\xfd\xd1\xa2\a");
  stuckpos = self.origin;

  while(self istouching(slidevolume) && distancesquared(stuckpos, self.origin) < squared(30)) {
    waitframe();
  }

  self.var_a0422cdb9620ddb0 = 0;
}

function function_864b1942290d53b8() {
  self endon("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");
  self endon("\x1e\xfd\xd1\xa2\a");
  numframestocheck = 4;
  prevpositions = [];

  for(i = 0; i < numframestocheck; i++) {
    prevpositions[i] = self.slidemodel.origin;
    waitframe();
  }

  stagnant = 0;

  while(!stagnant && isDefined(self.slidemodel)) {
    stagnant = 1;

    for(i = 0; i < numframestocheck - 1; i++) {
      if(prevpositions[i] != prevpositions[i + 1]) {
        stagnant = 0;
        prevpositions[i] = prevpositions[i + 1];
      }
    }

    prevpositions[numframestocheck - 1] = self.slidemodel.origin;
    waitframe();
  }

  self.var_a0422cdb9620ddb0 = 1;
}

function beginsliding(velocity, allowedacceleration, var_66ecd364519ab05d, gesture, surfacetype) {
  self endon("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isPlayer(self));
  player = self;

  if(player utility::ent_flag_exist("C\b\xca\xc0V\xa8\xb5;E\xb7")) {
    player utility::ent_flag_clear("C\b\xca\xc0V\xa8\xb5;E\xb7");
  } else {
    player utility::ent_flag_init("C\b\xca\xc0V\xa8\xb5;E\xb7");
  }

  player utility::ent_flag_set("C\b\xca\xc0V\xa8\xb5;E\xb7");
  var_8ee298221546ae1b = isDefined(level.custom_linkto_slide);
  assert(!isDefined(player.slidemodel));
  slidemodel = player utility::spawn_tag_origin();
  player.slidemodel = slidemodel;
  fx_tag = player utility::spawn_tag_origin();
  player.fx_tag = fx_tag;
  trace_contents = trace::create_contents(0, 1, 0, 0, 0, 0);
  trace = trace::ray_trace(player getEye(), player getEye() - (0, 0, 100), player, trace_contents);
  angle = 0;
  point = (0, 0, 0);
  normal = trace["+0a<s,"];

  while(true) {
    if(!player isjumping()) {
      trace = trace::ray_trace(player getEye(), player getEye() - (0, 0, 100), player, trace_contents);
      normal = trace["+0a<s,"];

      if(isDefined(normal)) {
        dot_value = vectordot(normal, (0, 0, 1));

        if(dot_value <= 0.95) {
          angle = acos(dot_value);
          point = trace["\xc1\xbd\xdci\xe8i{7"];
          break;
        }
      }
    }

    wait 0.05;
  }

  normal = vectorNormalize(utility::flatten_vector(normal, (0, 0, 1)));
  var_571e878ddac8cd11 = vectorNormalize(vectorcross(normal, (0, 1, 0)));
  var_9b8dae28a4f9f0a2 = vectorNormalize(vectorcross(normal, var_571e878ddac8cd11));
  slidemodel.angles = player.angles;
  slidemodel.origin = player.origin;
  var_b2e9825855265cfc = vectortoangles(normal) + normal * angle;
  slidemodel.gesture_target = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", slidemodel.origin + anglesToForward(var_b2e9825855265cfc) * 2000);
  slidemodel.gesture_target.angles = var_b2e9825855265cfc;
  player.fx_tag.angles = var_b2e9825855265cfc;

  if(!isDefined(velocity)) {
    velocity = player getvelocity() + (0, 0, -10);
  }

  if(!isDefined(allowedacceleration)) {
    allowedacceleration = 10;
  }

  if(!isDefined(var_66ecd364519ab05d)) {
    var_66ecd364519ab05d = 0.035;
  }

  slidemodel moveslide((0, 0, 15), 15, velocity);

  if(isDefined(surfacetype) && getdvarint(@ "hash_94150a895cddf69d", 0)) {
    player childthread function_23086920f10b4f74(surfacetype);
  } else {
    player thread utility::playsoundonentity("l\a\xdb\f\x1f\xf5\x91.\x97m\xfa1\xd7\xce\f?\xe1|\\\x10");
  }

  if(getdvarint(@ "hash_e7c074c9ef3fd481", 1)) {
    player hidelegsandshadow();
  }

  weapons = player getweaponslistprimaries();

  if(weapons.size > 0 && player isweaponsenabled() && isDefined(player.currentweapon) && !istrue(player.currentweapon.basename == "\r+x5")) {
    if(!isDefined(gesture)) {
      gesture = "\x83\x98w\f2\xd0\x18^\x04";
    }

    if(gesture != "\x87\x16\x82\xeb\x15\xcf\xd8\xaa\x8a\xb8" && !player isgestureplaying(gesture)) {
      player forceplaygestureviewmodel(gesture, slidemodel.gesture_target, 0.2, undefined, 1, 1);
    }
  }

  if(isDefined(level._effect["r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M"])) {
    effect = utility::getfx("r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M");
    playFXOnTag(utility::getfx("r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M"), player.fx_tag, "\xec\xbfK|\au\xcd\xc2\x19<");
    player.fx_tag show();
  }

  if(var_8ee298221546ae1b) {
    player playerlinktoblend(slidemodel, undefined, 1);
    wait 1;
    player playerlinktodelta(slidemodel, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 180, 180, 180, 180, 1);
  } else {
    player playerlinktodelta(slidemodel, "\xec\xbfK|\au\xcd\xc2\x19<", 0, 180, 180, 180, 180);
  }

  if(getdvarint(@ "hash_2f40a2e9ae1a9a47", 1)) {
    utility::noself_func("\b+\xc4\xf4\x06V`\xd8\xf5\v\x84S", @ "depthsortviewmodel", 1);
  }

  player val::set("\x1d\xf5\x131\xf8", "\xcciN\xca", 0);
  player val::set("\x1d\xf5\x131\xf8", "GX\xa9]\x82", 0);
  player val::set("\x1d\xf5\x131\xf8", "\x8b\x90\xb5\xc4W", 0);
  player val::set("\x1d\xf5\x131\xf8", "\xc9\xca\x1boX\x8c", 0);

  if(istrue(level.var_671e01ff55b8c624)) {
    player val::set("\x1d\xf5\x131\xf8", "\x05\xb1\x1c\x86\x11\xc7", 0);
  }

  player thread doslide(slidemodel, allowedacceleration, var_66ecd364519ab05d);

  if(isDefined(surfacetype) && getdvarint(@ "hash_94150a895cddf69d", 0)) {
    player childthread function_fdc4b81967300e8(surfacetype);
  } else {
    player thread utility::play_loop_sound_on_tag("\xc9CD\xc5H\x84\xfa\x1a\xdc\xff\x9c_\xc0js\xd0I{k");
  }

  if(utility::issharedfuncdefined(#"player", #"get_rumble_ent")) {
    player.rumble_ent = utility::callsharedfunc(#"player", #"get_rumble_ent");
    player.rumble_ent thread utility::callsharedfunc(#"player", #"rumble_ramp_to", 0.6, 3);
  }
}

function endsliding(endingstance, endingdamage, gesture, surfacetype) {
  assert(isPlayer(self));
  player = self;
  assert(isDefined(player.slidemodel));

  if(!isDefined(gesture)) {
    gesture = "\x83\x98w\f2\xd0\x18^\x04";
  }

  if(gesture != "\x87\x16\x82\xeb\x15\xcf\xd8\xaa\x8a\xb8" && player isgestureplaying(gesture)) {
    player stopgestureviewmodel(gesture);
  }

  if(isDefined(player.rumble_ent)) {
    player.rumble_ent delete();
  }

  if(isDefined(surfacetype) && getdvarint(@ "hash_94150a895cddf69d", 0)) {
    player childthread function_34dc74bf1a34999(surfacetype);
  } else {
    player notify("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + "\xc9CD\xc5H\x84\xfa\x1a\xdc\xff\x9c_\xc0js\xd0I{k");
    player thread utility::playsoundonentity("\xc8\x88\x86\xcf0\xe5Z\xfd\x95\x12\xc49\x8f~i0h\x90");
  }

  if(getdvarint(@ "hash_e7c074c9ef3fd481", 1)) {
    player utility::delaycall(0.2, &showlegsandshadow);
  }

  if(player islinked()) {
    player unlink();
    player setvelocity(player.slidemodel.slidevelocity);
  }

  if(isDefined(player.fx_tag)) {
    if(isDefined(level._effect["r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M"])) {
      effect = utility::getfx("r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M");

      if(isDefined(effect)) {
        stopFXOnTag(utility::getfx("r\x8b\x10\xbc\x183\xa8y\n\xed\xe4`\x90M"), player.fx_tag, "\xec\xbfK|\au\xcd\xc2\x19<");
      }
    }

    player.fx_tag delete();
  }

  if(player function_7063b61e3bdedcf0()) {
    player utility::ent_flag_clear("C\b\xca\xc0V\xa8\xb5;E\xb7");
  }

  player val::reset_all("\x1d\xf5\x131\xf8");

  if(isDefined(endingstance)) {
    player setstance(endingstance);
  }

  if(isDefined(endingdamage)) {
    player utility::delaycall(0.2, &dodamage, endingdamage, player.origin);
  }

  player.slidemodel delete();

  if(getdvarint(@ "hash_2f40a2e9ae1a9a47", 1)) {
    utility::noself_func("\b+\xc4\xf4\x06V`\xd8\xf5\v\x84S", @ "depthsortviewmodel", 0);
  }

  player notify("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");
}

function beginslidinglegacy(velocity, allowedacceleration, var_66ecd364519ab05d) {
  assert(isPlayer(self));
  player = self;

  if(player utility::ent_flag_exist("C\b\xca\xc0V\xa8\xb5;E\xb7")) {
    player utility::ent_flag_clear("C\b\xca\xc0V\xa8\xb5;E\xb7");
  } else {
    player utility::ent_flag_init("C\b\xca\xc0V\xa8\xb5;E\xb7");
  }

  player utility::ent_flag_set("C\b\xca\xc0V\xa8\xb5;E\xb7");
  player thread utility::playsoundonentity("l\a\xdb\f\x1f\xf5\x91.\x97m\xfa1\xd7\xce\f?\xe1|\\\x10");
  player thread utility::play_loop_sound_on_tag("\xc9CD\xc5H\x84\xfa\x1a\xdc\xff\x9c_\xc0js\xd0I{k");
  var_8ee298221546ae1b = isDefined(level.custom_linkto_slide);

  if(!isDefined(velocity)) {
    velocity = player getvelocity() + (0, 0, -10);
  }

  if(!isDefined(allowedacceleration)) {
    allowedacceleration = 10;
  }

  if(!isDefined(var_66ecd364519ab05d)) {
    var_66ecd364519ab05d = 0.035;
  }

  assert(!isDefined(player.slidemodel));
  slidemodel = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", player.origin);
  slidemodel.angles = player.angles;
  player.slidemodel = slidemodel;
  slidemodel moveslide((0, 0, 15), 15, velocity);

  if(var_8ee298221546ae1b) {
    player playerlinktoblend(slidemodel, undefined, 1);
  } else {
    player playerlinkTo(slidemodel);
  }

  player val::set("\x9b\xae\x80\xa1\x01\vI\x10\x82\xb4\xc2\xf3", "\xe5\x06\xb0\bE\x16", 0);
  player val::set("\x9b\xae\x80\xa1\x01\vI\x10\x82\xb4\xc2\xf3", "GX\xa9]\x82", 0);
  player val::set("\x9b\xae\x80\xa1\x01\vI\x10\x82\xb4\xc2\xf3", "1x\xc5\xb4\xabx", 1);
  player val::set("\x9b\xae\x80\xa1\x01\vI\x10\x82\xb4\xc2\xf3", "\x8b\x90\xb5\xc4W", 0);
  player thread doslide(slidemodel, allowedacceleration, var_66ecd364519ab05d);
}

function endslidinglegacy() {
  assert(isPlayer(self));
  player = self;
  assert(isDefined(player.slidemodel));
  player notify("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + "\xc9CD\xc5H\x84\xfa\x1a\xdc\xff\x9c_\xc0js\xd0I{k");
  player thread utility::playsoundonentity("\xc8\x88\x86\xcf0\xe5Z\xfd\x95\x12\xc49\x8f~i0h\x90");
  player unlink();
  player setvelocity(player.slidemodel.slidevelocity);
  player.slidemodel delete();
  player val::reset_all("\x9b\xae\x80\xa1\x01\vI\x10\x82\xb4\xc2\xf3");
  player notify("\xb7\x83\xfa\x1b?U\xea\x19\xa2\x80\n;");

  if(player function_7063b61e3bdedcf0()) {
    player utility::ent_flag_clear("C\b\xca\xc0V\xa8\xb5;E\xb7");
  }
}

function trigger_slide(trigger) {
  setdvarifuninitialized(@ "hash_4c481f7e26afb913", 0);

  setdvarifuninitialized(@ "hash_69fdaf7cc701b6b", 0);

  if(!isDefined(trigger.script_gesture)) {
    trigger.script_gesture = "\x83\x98w\f2\xd0\x18^\x04";
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", player);

    if(!isDefined(player)) {
      continue;
    }

    if(!isPlayer(player)) {
      continue;
    }

    player thread slidetriggerplayerthink(trigger);
  }
}

function function_23086920f10b4f74(surfacetype) {
  slidestartsound = "\x9a\xc8\b$j\x98\xd7\xfb\xa7\xfd5\xf1\x88\x88\x93";

  if(isDefined(surfacetype)) {
    if(surfacetype == "\x97\"a") {
      slidestartsound = "6\xad\",\x9b\xe2\xa5J\xfa\xbfW8T\xc7\x06\x1c\x83\x15\xfb\"\xfac<\xdeR?\x9fu";
    } else if(surfacetype == "c\xa1\xa9") {
      slidestartsound = "%8\x99\x19\x88\x977\x9ajF\xcd\xa8QHAv\x9d\xd8\b\x190 NrZ\xbf\xf8\xa3";
    }

    if(soundexists(slidestartsound)) {
      thread utility::playsoundonentity(slidestartsound);
    }

    return;
  }

  var_7d91939c44d7b3b8 = trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1);
  surface_trace = trace::ray_trace(level.player getEye() + (0, 0, 200), level.player getEye() - (0, 0, 100), level.player, var_7d91939c44d7b3b8, 1);

  if(isDefined(surface_trace)) {
    surface = function_b602d47674a133f(surface_trace["I\xf8\x17\x03\x90\x81\xd3\xf0]e\x11"], "\x03\xfbL\xdf\xa6~\xf3vU");

    if(isDefined(surface)) {
      level.slidesurface = surface;
    }
  }

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slidestartsound, level.slidesurface);
  }
}

function function_fdc4b81967300e8(surfacetype) {
  slideloopsound = "\xbb\v\x06^\xab\xa2A\xa8S8y\x10U\xcc";

  if(isDefined(surfacetype)) {
    if(surfacetype == "\x97\"a") {
      slideloopsound = "l(\xb9\x1d{\xe04B\x88\xf3\x10\x1b?\x82oVN\t\xe1\xe6=\v";
    } else if(surfacetype == "c\xa1\xa9") {
      slideloopsound = "\xb8\a\xaf\xacf<\b\xcd\xa9\xbcK?\xcc\xa6\x99\x8f\xf1\xb5R\x806]";
    }

    if(soundexists(slideloopsound)) {
      thread utility::play_loop_sound_on_entity(slideloopsound);
    }

    return;
  }

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slideloopsound, level.slidesurface);
  }
}

function function_34dc74bf1a34999(surfacetype) {
  slideloopsound = "\xbb\v\x06^\xab\xa2A\xa8S8y\x10U\xcc";
  slideendsound = "k\x1c\xaf~\x9dS\xd2@\x02+\x8b\xf6\x13\x1bx\xef\a=";

  if(isDefined(surfacetype)) {
    if(surfacetype == "\x97\"a") {
      slideloopsound = "l(\xb9\x1d{\xe04B\x88\xf3\x10\x1b?\x82oVN\t\xe1\xe6=\v";
      slideendsound = "\xff\x8b\xe8C\xbdUD\xb0\xf7;\xa4\x95\xdd3\xc6\xa05up\r)B\xe6G=}\xa7\xc5\xa1\x91\xfa";
    } else if(surfacetype == "c\xa1\xa9") {
      slideloopsound = "\xb8\a\xaf\xacf<\b\xcd\xa9\xbcK?\xcc\xa6\x99\x8f\xf1\xb5R\x806]";
      slideendsound = "\xb19@\xe6\xfa\x7fx\x19\xf2d\x88iw^\xc1\xfc\x93\xa0\xe8\x1e*o\x9eU\xcbP\xb7\x82\xf8\xf3\x14";
    }

    thread utility::stop_loop_sound_on_entity(slideloopsound);

    if(soundexists(slideendsound)) {
      thread utility::playsoundonentity(slideendsound);
    }

    return;
  }

  thread utility::stop_loop_sound_on_entity(slideloopsound);

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slideendsound, level.slidesurface);
  }
}

function function_12d139c97a1b712c() {
  last_pos = (0, 0, 0);
  last_entnum = "";
  text = "";
  pos_array = [];

  while(true) {
    if(isDefined(self.slidemodel)) {
      parent = self getlinkedparent();
      last_pos = self.slidemodel.origin;
      pos_array[pos_array.size] = last_pos;

      last_entnum = "<dev string:x3a>" + self.slidemodel getentitynumber();

      text = last_entnum;
    } else {
      text = last_entnum + "\b\"\x15L\xa2\x8a\xa8D";
    }

    debugstar(last_pos, (1, 1, 0), 1, text);

    if(pos_array.size >= 2) {
      for(i = 1; i < pos_array.size; i++) {
        if(i % 2) {
          color = (1, 1, 0);
        } else {
          color = (1, 0, 1);
        }

        line(pos_array[i - 1], pos_array[i], color);
      }
    }

    waitframe();
  }
}