/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\gestures.gsc
******************************************/

#using scripts\anim\battlechatter;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace gestures;

function enter_demeanor(demeanorstruct) {
  assert(isDefined(demeanorstruct));
  thread set_demeanor_code_think(demeanorstruct.demeanor, demeanorstruct.gesture);
  thread demeanor_exit_func_wait(&exit_demeanor, demeanorstruct);
}

function exit_demeanor(demeanorstruct) {}

function safe_zoom_think() {
  self endon("I\x023mH\x8c\xbe\a\x7f\xd6\xf7\x188\x1b*\xc0\xf1Z\x83\x90\x80");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.gestures.safedefaultfov = getdvarfloat(@ "cg_targetbasefov");
  childthread safe_zoom_in_listen();
  childthread safe_zoom_out_listen();
  thread safe_zoom_end_think();
}

function safe_zoom_in_listen() {
  level.player notifyonplayercommand("n\v\x99\xb2_=\xbd\xbd\xb6\xaf\x0e\x9cens\xcaF", "\x18\xa9`\x13\x97\x9f\x1e\"?E[\xdb\xe4m\x9e;");
  level.player notifyonplayercommand("n\v\x99\xb2_=\xbd\xbd\xb6\xaf\x0e\x9cens\xcaF", "\xfa{\\\xcfik\xb7\x8d\xdb\xc8\x98\x99x\\\xb7\xb9\x8d\xbaZ>P\x9a");
  level.player notifyonplayercommand("n\v\x99\xb2_=\xbd\xbd\xb6\xaf\x0e\x9cens\xcaF", "\xcf\xa0Tt\xdc\x99\x95q\x96U2u");

  while(true) {
    self waittill("n\v\x99\xb2_=\xbd\xbd\xb6\xaf\x0e\x9cens\xcaF");
    self modifybasefov(self.gestures.safedefaultfov - 9, 0.14);
  }
}

function safe_zoom_out_listen() {
  level.player notifyonplayercommand("F\xc0J:g\xb2\xc2\xcd\xc1\xa5\xfb)\xb3\\ks\xe7\xab", "\xa4\x04\xf9\xc6\xcc\xe8ZO\x80i\xdfy\xd8\x82\x1b#");
  level.player notifyonplayercommand("F\xc0J:g\xb2\xc2\xcd\xc1\xa5\xfb)\xb3\\ks\xe7\xab", "!\x8d\xb1r$\xf7.s\xc4\"nf\xc6\xd1\xa95\x1e\x88\x94\xde|\x7f");
  level.player notifyonplayercommand("F\xc0J:g\xb2\xc2\xcd\xc1\xa5\xfb)\xb3\\ks\xe7\xab", "?y\xffRi\x89\xcb\xec\x97\xa7\xa3\xff");

  while(true) {
    self waittill("F\xc0J:g\xb2\xc2\xcd\xc1\xa5\xfb)\xb3\\ks\xe7\xab");
    self modifybasefov(self.gestures.safedefaultfov, 0.1);
  }
}

function safe_zoom_end_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("I\x023mH\x8c\xbe\a\x7f\xd6\xf7\x188\x1b*\xc0\xf1Z\x83\x90\x80");
  self modifybasefov(self.gestures.safedefaultfov, 0.1);
}

function demeanor_exit_func_wait(exitfunction, demeanorstruct) {
  self waittill("I\x023mH\x8c\xbe\a\x7f\xd6\xf7\x188\x1b*\xc0\xf1Z\x83\x90\x80");
  self[[exitfunction]](demeanorstruct);
}

function set_demeanor_code_think(demeanor, gestureoverride) {
  self endon("I\x023mH\x8c\xbe\a\x7f\xd6\xf7\x188\x1b*\xc0\xf1Z\x83\x90\x80");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(isDefined(gestureoverride)) {
      result = self setdemeanorviewmodel(demeanor, gestureoverride);
    } else {
      result = self setdemeanorviewmodel(demeanor);
    }

    if(result) {
      break;
    }

    wait 0.05;
  }
}

function player_gestures_input_disable(gesturename, pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, disabletime, tag) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(tag)) {
    tag = "\xd7\xd8\xae\xb6\x0ea\xab";
  }

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(pronemovement) && pronemovement == 1) {
    if(level.player getstance() == "GX\xa9]\x82") {
      utility_sp::blend_movespeedscale(0, 0, "\xd7\xd8\xae\xb6\x0ea\xab");
      thread player_gestures_prone_getup_think(gesturename, tag);

      if(!isDefined(self.gestures.restrictingpronespeed)) {
        self.gestures.restrictingpronespeed = 0;
      }

      self.gestures.restrictingpronespeed++;
    } else {
      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "GX\xa9]\x82", 0);
    }

    self.gestures.restrictingpronemovement = 1;
  }

  if(isDefined(mantle) && mantle == 1) {
    if(!isDefined(self.gestures.restrictingmantle)) {
      self.gestures.restrictingmantle = 0;
    }

    self.gestures.restrictingmantle++;
    val::set(tag, "\x9a\xe3\xe4\xff\x81%", 0);
  }

  if(isDefined(sprint) && sprint == 1) {
    if(!isDefined(self.gestures.restrictingsprint)) {
      self.gestures.restrictingsprint = 0;
    }

    self.gestures.restrictingsprint++;
    val::set(tag, "\x05\xb1\x1c\x86\x11\xc7", 0);
  }

  if(isDefined(fire) && fire == 1) {
    if(!isDefined(self.gestures.restrictingfire)) {
      self.gestures.restrictingfire = 0;
    }

    self.gestures.restrictingfire++;
    val::set(tag, "\xcciN\xca", 0);
  }

  if(isDefined(reload) && reload == 1) {
    if(!isDefined(self.gestures.restrictingreload)) {
      self.gestures.restrictingreload = 0;
    }

    self.gestures.restrictingreload++;
    val::set(tag, "\xc9\xca\x1boX\x8c", 0);
  }

  if(isDefined(weaponswitch) && weaponswitch == 1) {
    if(!isDefined(self.gestures.restrictingweaponswitch)) {
      self.gestures.restrictingweaponswitch = 0;
    }

    self.gestures.restrictingweaponswitch++;
    val::set(tag, "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
  }

  if(isDefined(ads) && ads == 1) {
    if(!isDefined(self.gestures.restrictingads)) {
      self.gestures.restrictingads = 0;
    }

    self.gestures.restrictingads++;
    val::set(tag, "\xe4\xf1G", 0);
  }

  if(isDefined(wallrun) && wallrun == 1) {
    if(!isDefined(self.gestures.restrictingwallrun)) {
      self.gestures.restrictingwallrun = 0;
    }

    self.gestures.restrictingwallrun++;
    val::set(tag, "\xe1\xab\xe9\xa8\x19;3", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    if(!isDefined(self.gestures.restrictingdoublejump)) {
      self.gestures.restrictingdoublejump = 0;
    }

    self.gestures.restrictingdoublejump++;
    val::set(tag, "\xc1]Pf\xfe\x04S\xd9\x01\xa8", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    if(!isDefined(self.gestures.restrictingmeleeattack)) {
      self.gestures.restrictingmeleeattack = 0;
    }

    self.gestures.restrictingmeleeattack++;
    val::set(tag, "mV\x8d+e", 0);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    if(!isDefined(self.gestures.restrictingoffhandweapons)) {
      self.gestures.restrictingoffhandweapons = 0;
    }

    self.gestures.restrictingoffhandweapons++;
    val::set(tag, "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
  }

  if(isDefined(disabletime)) {
    wait disabletime;
  } else {
    self waittill("\x9f\x02\x98?\xad\x96kb\x0e\x86(wT\xaf\xb1", stoppedgesturename);

    if(stoppedgesturename != gesturename) {
      while(true) {
        if(!self isgestureplaying(gesturename)) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self notify(gesturename + "\x9c:cq\xf6\xb6\xc2\xd3akc\x15\xc9L\x16Oc\xe1WF\xb3\x9e\x97\xb8");
  player_gestures_input_enable(pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag);
}

function player_gestures_input_enable(pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag) {
  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(pronemovement) && pronemovement > 0) {
    if(isDefined(self.gestures.restrictingpronespeed) && self.gestures.restrictingpronespeed > 0) {
      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0) {
          utility_sp::blend_movespeedscale(1, 0, "\xd7\xd8\xae\xb6\x0ea\xab");
        }
      }
    }

    if(isDefined(self.gestures.restrictingpronestance) && self.gestures.restrictingpronestance > 0) {
      self.gestures.restrictingpronestance--;
      val::reset_all(tag);
    }
  }

  if(isDefined(mantle) && mantle == 1) {
    val::reset_all(tag);
  }

  if(isDefined(sprint) && sprint == 1) {
    val::reset_all(tag);
  }

  if(isDefined(fire) && fire == 1) {
    val::reset_all(tag);
  }

  if(isDefined(reload) && reload == 1) {
    val::reset_all(tag);
  }

  if(isDefined(weaponswitch) && weaponswitch == 1) {
    val::reset_all(tag);
  }

  if(isDefined(ads) && ads == 1) {
    val::reset_all(tag);
  }

  if(isDefined(wallrun) && wallrun == 1) {
    val::set(tag, "\xe1\xab\xe9\xa8\x19;3", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    val::set(tag, "\xc1]Pf\xfe\x04S\xd9\x01\xa8", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    val::reset_all(tag);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    val::reset_all(tag);
  }
}

function player_gestures_prone_getup_think(gesturename, tag) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(gesturename + "\x9c:cq\xf6\xb6\xc2\xd3akc\x15\xc9L\x16Oc\xe1WF\xb3\x9e\x97\xb8");
  stillprone = 1;

  while(stillprone) {
    if(self getstance() != "GX\xa9]\x82") {
      waittillframeend();

      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0) {
          utility_sp::blend_movespeedscale(1, 0, "\xd7\xd8\xae\xb6\x0ea\xab");
        }
      }

      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "GX\xa9]\x82", 0);
      stillprone = 0;
    }

    wait 0.05;
  }
}

function function_5137bf0e8403f1e8() {
  level.player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    while(function_7806679f0a6f2bd7()) {
      waitframe();
    }

    if(!function_9cd92e555f4c053f()) {
      var_c9824604dacf3d9 = undefined;

      while(!utility::time_has_passed(var_c9824604dacf3d9, 0.5)) {
        if(!function_9cd92e555f4c053f()) {
          var_c9824604dacf3d9 = gettime();
        }

        waitframe();
      }
    }

    level.player utility_sp::set_player_demeanor("4}\xad\xb6z7\xa5");
    var_a0a51a3fa10bcbac = undefined;

    while(!utility::time_has_passed(var_a0a51a3fa10bcbac, 1)) {
      if(function_7806679f0a6f2bd7()) {
        break;
      }

      if(function_9cd92e555f4c053f()) {
        var_a0a51a3fa10bcbac = gettime();
      }

      waitframe();
    }

    level.player utility_sp::set_player_demeanor("+0a<s,");
  }
}

function function_7806679f0a6f2bd7() {
  if(level.player.currentweapon.type != "\xd7\xdb\xaaU\x82\xb0" || istrue(level.player.incombat)) {
    return true;
  }

  return !getdvarint(@ "hash_92edcd4e782939e5", 0) || istrue(level.player.var_114ce4bd8f873e4e);
}

function wait_combat_cooldown(cooltime, timeout, radius) {
  while(!isDefined(timeout) || timeout > 0) {
    if(!function_1f423357494614cc(timeout, radius)) {
      return false;
    }

    waitframe();

    if(isDefined(timeout)) {
      timeout -= 0.05;
    }
  }

  return true;
}

function function_1f423357494614cc(time, radius) {
  fired_recently = isDefined(level.player.var_c243789bf8d4895b) && !utility::time_has_passed(level.player.var_c243789bf8d4895b, time);
  aimed_recently = isDefined(level.player.var_762c3cd2777d0c3d) && !utility::time_has_passed(level.player.var_762c3cd2777d0c3d, time);
  var_78a8f2107d37003c = isDefined(level.player.var_a26c8110b43e2d28) && !utility::time_has_passed(level.player.var_a26c8110b43e2d28, time);
  damaged = level.player.health < level.player.maxhealth;

  if(level.player isfiring() || fired_recently || aimed_recently || damaged) {
    return true;
  }

  if(istrue(radius)) {
    radius_sq = radius * radius;
    nearby_ai = getaiarray();

    foreach(ai in nearby_ai) {
      if(!isalive(ai) || !isDefined(ai.team) || ai.team == "_Dz\xec" || ai.team == "\xba\xa5\x1f\xc9m\x80i") {
        continue;
      }

      if(ai.enemy != level.player && distancesquared(ai.origin, level.player.origin) > radius_sq) {
        continue;
      }

      if(ai battlechatter::function_41a2d126b05cce84(time)) {
        return true;
      }
    }
  }

  return false;
}

function function_a1e7ea89c16073eb() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  childthread function_89ca5a647e296648();

  setdevdvarifuninitialized(@ "hash_62f50e8fe08148c9", 0);

  var_45a8c6feb34ae364 = 800;
  var_c0ce4735bf2c3e73 = 900;
  var_95ce43de097a6b83 = 1.5;

  while(true) {
    thread function_75b0e1eeeae0d3b6("<dev string:x24>");

    level.player.incombat = 0;
    setsaveddvar(@ "quickdraw_enabled", 0);

    while(!function_1f423357494614cc(var_95ce43de097a6b83 * 2, var_45a8c6feb34ae364)) {
      wait var_95ce43de097a6b83;
    }

    thread function_75b0e1eeeae0d3b6("<dev string:x35>");

    level.player.incombat = 1;
    setsaveddvar(@ "quickdraw_enabled", 1);

    while(function_1f423357494614cc(var_95ce43de097a6b83 * 2, var_c0ce4735bf2c3e73)) {
      wait var_95ce43de097a6b83;
    }
  }
}

function function_75b0e1eeeae0d3b6(state) {
  level notify("<dev string:x42>");
  level endon("<dev string:x42>");

  while(true) {
    if(getdvarint(@ "hash_62f50e8fe08148c9")) {
      printtoscreen2d(100, 800, state, (1, 1, 1), 2);
    }

    waitframe();
  }
}

function function_89ca5a647e296648() {
  var_657424e8069f63d3 = -9999;

  while(true) {
    result = level.player utility::waittill_any_return("9\xfca\xad\f^Rj.\xe6\xc6$", "\xb5\x10\xb9", "\x9c\xae\x01\x94\xb8\xb5F\xc1\x94\row", "\fU`\xc0y\x95");

    switch (result) {
      case #"hash_21a23ad4b32e4f8e":
        level.player.last_weapon_fire_time = gettime();
        continue;
      case #"hash_c57516c109cc3d6":
        if(gettime() - var_657424e8069f63d3 > 50) {
          level.player.var_762c3cd2777d0c3d = gettime();
        }

        var_657424e8069f63d3 = gettime();
        continue;
      case #"hash_1cc8a923a608c2a0":
      case #"hash_de811d1d5fa7e6b4":
        level.player.var_a26c8110b43e2d28 = gettime();
        continue;
    }
  }
}

function function_9cd92e555f4c053f() {
  allies = getaiarrayinradius(level.player.origin, 1500, "O\x15\x1b\xad\x9ff");
  civs = getaiarrayinradius(level.player.origin, 1500, "\xba\xa5\x1f\xc9m\x80i");

  foreach(civ in civs) {
    if(istrue(civ.forcegundown)) {
      allies[allies.size] = civ;
    }
  }

  player_eye = level.player getEye();
  player_forward = anglesToForward(level.player getplayerangles());
  end = player_eye + anglesToForward(level.player getplayerangles()) * 1500;
  result = trace::ray_trace(player_eye, end, level.player);
  return isDefined(result["\x1f\xa8\x10WP\xa9"]) && !istrue(result["\x1f\xa8\x10WP\xa9"].bisincombat) && arraycontains(allies, result["\x1f\xa8\x10WP\xa9"]);
}

function function_3dfb7cf67fa3d92c(ent, max_dist, player_eye, player_forward, var_6a3039b3928f07f2) {
  ent_point = ent getapproxeyepos() - (0, 0, 15);
  var_6d764dec13b62287 = vectordot(ent_point - player_eye, player_forward) > 0;
  var_4e0a10c12efce0b9 = length(vectorfromlinetopoint(player_eye, player_eye + player_forward, ent_point));

  if(!var_6d764dec13b62287 || var_4e0a10c12efce0b9 > var_6a3039b3928f07f2) {
    return 0;
  }

  return trace::ray_trace_passed(player_eye, ent_point, ent);
}