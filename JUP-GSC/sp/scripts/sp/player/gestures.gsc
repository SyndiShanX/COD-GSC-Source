/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\player\gestures.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player\gestures;
#using scripts\sp\utility;
#namespace gestures;

function enter_demeanor_normal() {
  thread set_demeanor_code_think("normal");
  thread demeanor_exit_func_wait(&exit_demeanor_normal);
}

function exit_demeanor_normal() {}

function enter_demeanor_relaxed() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_relaxed");
  thread demeanor_exit_func_wait(&exit_demeanor_relaxed);
}

function enter_demeanor_green_beam() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_green_laser_demeanor_relaxed");
  thread demeanor_exit_func_wait(&exit_demeanor_relaxed);
}

function exit_demeanor_relaxed() {}

function enter_demeanor_safe(var_5966e857c28e93c5) {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_safe");
  thread demeanor_exit_func_wait(&exit_demeanor_safe);
}

function exit_demeanor_safe(var_8b35ad057a83d7e7) {}

function safe_zoom_think() {
  self endon("entering_new_demeanor");
  self endon("death");
  self.gestures.safedefaultfov = getdvarint(@ "hash_b38fcf293d1e91a8");
  childthread safe_zoom_in_listen();
  childthread safe_zoom_out_listen();
  thread safe_zoom_end_think();
}

function safe_zoom_in_listen() {
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");

  while(true) {
    self waittill("safe_zoom_pressed");
    self modifybasefov(self.gestures.safedefaultfov - 9, 0.14);
  }
}

function safe_zoom_out_listen() {
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");

  while(true) {
    self waittill("safe_zoom_released");
    self modifybasefov(self.gestures.safedefaultfov, 0.1);
  }
}

function safe_zoom_end_think() {
  self endon("death");
  self waittill("entering_new_demeanor");
  self modifybasefov(self.gestures.safedefaultfov, 0.1);
}

function demeanor_exit_func_wait(exitfunction) {
  self waittill("entering_new_demeanor");
  self[[exitfunction]]();
}

function set_demeanor_code_think(demeanor, gestureoverride) {
  self endon("entering_new_demeanor");
  self endon("death");

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
  self endon("death");

  if(!isDefined(tag)) {
    tag = "gesture";
  }

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(pronemovement) && pronemovement == 1) {
    if(level.player getstance() == "prone") {
      blend_movespeedscale(0, 0, "gesture");
      thread scripts\sp\player\gestures::player_gestures_prone_getup_think(gesturename, tag);

      if(!isDefined(self.gestures.restrictingpronespeed)) {
        self.gestures.restrictingpronespeed = 0;
      }

      self.gestures.restrictingpronespeed++;
    } else {
      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "prone", 0);
    }

    self.gestures.restrictingpronemovement = 1;
  }

  if(isDefined(mantle) && mantle == 1) {
    if(!isDefined(self.gestures.restrictingmantle)) {
      self.gestures.restrictingmantle = 0;
    }

    self.gestures.restrictingmantle++;
    val::set(tag, "mantle", 0);
  }

  if(isDefined(sprint) && sprint == 1) {
    if(!isDefined(self.gestures.restrictingsprint)) {
      self.gestures.restrictingsprint = 0;
    }

    self.gestures.restrictingsprint++;
    val::set(tag, "sprint", 0);
  }

  if(isDefined(fire) && fire == 1) {
    if(!isDefined(self.gestures.restrictingfire)) {
      self.gestures.restrictingfire = 0;
    }

    self.gestures.restrictingfire++;
    val::set(tag, "fire", 0);
  }

  if(isDefined(reload) && reload == 1) {
    if(!isDefined(self.gestures.restrictingreload)) {
      self.gestures.restrictingreload = 0;
    }

    self.gestures.restrictingreload++;
    val::set(tag, "reload", 0);
  }

  if(isDefined(weaponswitch) && weaponswitch == 1) {
    if(!isDefined(self.gestures.restrictingweaponswitch)) {
      self.gestures.restrictingweaponswitch = 0;
    }

    self.gestures.restrictingweaponswitch++;
    val::set(tag, "weapon_switch", 0);
  }

  if(isDefined(ads) && ads == 1) {
    if(!isDefined(self.gestures.restrictingads)) {
      self.gestures.restrictingads = 0;
    }

    self.gestures.restrictingads++;
    val::set(tag, "ads", 0);
  }

  if(isDefined(wallrun) && wallrun == 1) {
    if(!isDefined(self.gestures.restrictingwallrun)) {
      self.gestures.restrictingwallrun = 0;
    }

    self.gestures.restrictingwallrun++;
    val::set(tag, "wallrun", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    if(!isDefined(self.gestures.restrictingdoublejump)) {
      self.gestures.restrictingdoublejump = 0;
    }

    self.gestures.restrictingdoublejump++;
    val::set(tag, "doublejump", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    if(!isDefined(self.gestures.restrictingmeleeattack)) {
      self.gestures.restrictingmeleeattack = 0;
    }

    self.gestures.restrictingmeleeattack++;
    val::set(tag, "melee", 0);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    if(!isDefined(self.gestures.restrictingoffhandweapons)) {
      self.gestures.restrictingoffhandweapons = 0;
    }

    self.gestures.restrictingoffhandweapons++;
    val::set(tag, "offhand_weapons", 0);
  }

  if(isDefined(disabletime)) {
    wait disabletime;
  } else {
    self waittill("gesture_stopped", stoppedgesturename);

    if(stoppedgesturename != gesturename) {
      while(true) {
        if(!self isgestureplaying(gesturename)) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self notify(gesturename + "gesture_stopped_internal");
  scripts\sp\player\gestures::player_gestures_input_enable(pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag);
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
          blend_movespeedscale(1, 0, "gesture");
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
    val::set(tag, "wallrun", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    val::set(tag, "doublejump", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    val::reset_all(tag);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    val::reset_all(tag);
  }
}

function player_gestures_prone_getup_think(gesturename, tag) {
  self endon("death");
  self endon(gesturename + "gesture_stopped_internal");
  stillprone = 1;

  while(stillprone) {
    if(self getstance() != "prone") {
      waittillframeend();

      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0) {
          blend_movespeedscale(1, 0, "gesture");
        }
      }

      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "prone", 0);
      stillprone = 0;
    }

    wait 0.05;
  }
}

function function_5231b0f285527a15() {
  level.player endon("death");

  while(true) {
    while(function_a233e21442860e82()) {
      waitframe();
    }

    if(!function_e4c009184c8a30e6()) {
      var_b173118a12ea61b0 = undefined;

      while(!time_has_passed(var_b173118a12ea61b0, 0.5)) {
        if(!function_e4c009184c8a30e6()) {
          var_b173118a12ea61b0 = gettime();
        }

        waitframe();
      }
    }

    level.player set_player_demeanor("relaxed");
    var_fbe80fd3686a42fd = undefined;

    while(!time_has_passed(var_fbe80fd3686a42fd, 1)) {
      if(function_a233e21442860e82()) {
        break;
      }

      if(function_e4c009184c8a30e6()) {
        var_fbe80fd3686a42fd = gettime();
      }

      waitframe();
    }

    level.player set_player_demeanor("normal");
  }
}

function function_a233e21442860e82() {
  if(level.player.currentweapon.type != "bullet" || istrue(level.player.incombat)) {
    return true;
  }

  return !getdvarint(@ "hash_92edcd4e782939e5", 0) || istrue(level.player.var_336db6c8b15ad3df);
}

function wait_combat_cooldown(cooltime, timeout, radius) {
  while(!isDefined(timeout) || timeout > 0) {
    if(!function_53f1cff70b5d2981(timeout, radius)) {
      return false;
    }

    waitframe();

    if(isDefined(timeout)) {
      timeout -= 0.05;
    }
  }

  return true;
}

function function_53f1cff70b5d2981(time, radius) {
  fired_recently = isDefined(level.player.last_fire_time) && !time_has_passed(level.player.last_fire_time, time);
  aimed_recently = isDefined(level.player.var_2216ecbcdd3468a4) && !time_has_passed(level.player.var_2216ecbcdd3468a4, time);
  var_d13b91a3e165b579 = isDefined(level.player.var_b4410f6c6f5b0f5) && !time_has_passed(level.player.var_b4410f6c6f5b0f5, time);
  damaged = level.player.health < level.player.maxhealth;

  if(level.player isfiring() || fired_recently || aimed_recently || damaged) {
    return true;
  }

  if(istrue(radius)) {
    radius_sq = radius * radius;
    nearby_ai = getaiarray();

    foreach(ai in nearby_ai) {
      if(!isalive(ai) || !isDefined(ai.team) || ai.team == "dead" || ai.team == "neutral") {
        continue;
      }

      if(!is_equal(ai.enemy, level.player) && distancesquared(ai.origin, level.player.origin) > radius_sq) {
        continue;
      }

      if(ai scripts\anim\battlechatter::function_45f570789ff9a0fd(time)) {
        return true;
      }
    }
  }

  return false;
}

function function_160704ee50b41fa() {
  level.player endon("death");
  childthread function_ca0fe6201120df5();

  setdevdvarifuninitialized(@ "hash_62f50e8fe08148c9", 0);

  var_f678598e33cef6a5 = 800;
  var_f7fb28bc06e2a38e = 900;
  var_4ab685c88f4b57ba = 1.5;

  while(true) {
    thread function_a71bc808f2d1aa2b("<dev string:x1c>");

    level.player.incombat = 0;
    setsaveddvar(@ "quickdraw_enabled", 0);

    while(!function_53f1cff70b5d2981(var_4ab685c88f4b57ba * 2, var_f678598e33cef6a5)) {
      wait var_4ab685c88f4b57ba;
    }

    thread function_a71bc808f2d1aa2b("<dev string:x2a>");

    level.player.incombat = 1;
    setsaveddvar(@ "quickdraw_enabled", 1);

    while(function_53f1cff70b5d2981(var_4ab685c88f4b57ba * 2, var_f7fb28bc06e2a38e)) {
      wait var_4ab685c88f4b57ba;
    }
  }
}

function function_a71bc808f2d1aa2b(state) {
  level notify("<dev string:x34>");
  level endon("<dev string:x34>");

  while(true) {
    if(getdvarint(@ "hash_62f50e8fe08148c9")) {
      printtoscreen2d(100, 800, state, (1, 1, 1), 2);
    }

    waitframe();
  }
}

function function_ca0fe6201120df5() {
  var_38c64aefbd73546a = -9999;

  while(true) {
    result = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "aim", "bulletwhizby", "damage");

    switch (result) {
      case #"hash_21a23ad4b32e4f8e":
        level.player.last_weapon_fire_time = gettime();
        continue;
      case #"hash_c57516c109cc3d6":
        if(gettime() - var_38c64aefbd73546a > 50) {
          level.player.var_2216ecbcdd3468a4 = gettime();
        }

        var_38c64aefbd73546a = gettime();
        continue;
      case #"hash_1cc8a923a608c2a0":
      case #"hash_de811d1d5fa7e6b4":
        level.player.var_b4410f6c6f5b0f5 = gettime();
        continue;
    }
  }
}

function function_e4c009184c8a30e6() {
  allies = getaiarrayinradius(level.player.origin, 1500, "allies");
  civs = getaiarrayinradius(level.player.origin, 1500, "neutral");

  foreach(civ in civs) {
    if(istrue(civ.forcegundown)) {
      allies[allies.size] = civ;
    }
  }

  player_eye = level.player getEye();
  player_forward = anglesToForward(level.player getplayerangles());
  end = player_eye + anglesToForward(level.player getplayerangles()) * 1500;
  result = scripts\engine\trace::ray_trace(player_eye, end, level.player);
  return isDefined(result["entity"]) && !istrue(result["entity"].bisincombat) && array_contains(allies, result["entity"]);
}

function function_b2385036531deb4d(ent, max_dist, player_eye, player_forward, var_b1edb654de127cc7) {
  ent_point = ent getapproxeyepos() - (0, 0, 15);
  in_front_of_player = vectordot(ent_point - player_eye, player_forward) > 0;
  var_5979848104c205bc = length(vectorfromlinetopoint(player_eye, player_eye + player_forward, ent_point));

  if(!in_front_of_player || var_5979848104c205bc > var_b1edb654de127cc7) {
    return 0;
  }

  return scripts\engine\trace::ray_trace_passed(player_eye, ent_point, ent);
}