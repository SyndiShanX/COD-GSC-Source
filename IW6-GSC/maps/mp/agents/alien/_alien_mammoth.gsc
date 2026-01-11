/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_mammoth.gsc
***************************************************/

mammoth_level_init() {
  if(!isDefined(level.alien_funcs)) {
    level.alien_funcs = [];
  }

  level.alien_funcs["mammoth"]["approach"] = ::mammoth_approach;
  level.alien_funcs["mammoth"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["mammoth"]["badpath"] = ::handle_badpath;
  level.donotburrowvolumes = getEntArray("donotburrow", "targetname");
}

mammoth_init() {
  self.last_charge_time = gettime();
  self.lastattacktime = gettime();
  self.fissurespawntimeout = get_fissure_spawn_timeout();
  self.burrowtimeout = get_burrow_timeout();
  self.currentphase = 0;
  self.canburrow = 1;
  self.canfissurespawn = 0;
  self.elite_angered = 1;
  self.burrowing = 0;
  self.lastburrowattacktime = gettime();
  self.lastfissurespawntime = gettime() + int(self.fissurespawntimeout * 0.5);
  maps\mp\agents\alien\_alien_think::set_alien_movemode("walk");
  self.fissurespawnlocs = [];
  self.cannothypno = 1;
  thread watch_for_immediate_abilities();
}

get_fissure_spawn_timeout() {
  switch (level.players.size) {
    case 1:
      return 20000;
    case 2:
      return 20000;
    case 3:
      return 20000;
    case 4:
      return 20000;
  }
}

get_burrow_timeout() {
  switch (level.players.size) {
    case 1:
      return 15000;
    case 2:
      return 15000;
    case 3:
      return 15000;
    case 4:
      return 15000;
  }
}

get_default_fissure_spawns() {
  switch (level.players.size) {
    case 1:
      return 1;
    case 2:
      return 1;
    case 3:
      return 2;
    case 4:
      return 2;
  }
}

burrow_attack(var_0) {
  self.melee_type = "burrow";
  maps\mp\agents\alien\_alien_think::alien_melee(var_0);
}

burrow(var_0) {
  level notify("dlc_vo_notify", "warn_dig", self);
  thread burrow_fx();

  if(isDefined(self.burrow_now) && self.burrow_now) {
    self.burrow_now = undefined;
  }

  self.lastburrowattacktime = gettime();
  self.burrowing = 1;
  self.last_burrow_location = self.origin;
  self.last_burrow_angles = self.angles;
  self scragentsetphysicsmode("noclip");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("burrow", 0, "burrow", "end", ::handleburrownotes);
  self hide();
  level notify("dlc_vo_notify", "warn_underground", self);
  wait(randomfloatrange(2.0, 6.0));
  var_1 = self getanimentry("burrow", 1);
  var_2 = getanimlength(var_1);
  var_3 = getmovedelta(var_1, 0.0, 1.0);
  var_4 = get_valid_burrow_emerge_location(self.enemy);

  if(isalive(self.enemy)) {
    var_5 = self.enemy.origin;
    var_6 = vectortoangles(var_5 - var_4);
  } else if(isDefined(self.emerge_angles))
    var_6 = self.emerge_angles;
  else {
    var_6 = self.last_burrow_angles;
  }

  self scragentsetorientmode("face angle abs", var_6);
  var_3 = rotatevector(var_3, var_6);
  var_7 = var_4 - var_3;
  self setorigin(var_7, 0);
  wait 0.1;
  level notify("dlc_vo_notify", "warn_emerge", self);
  self show();
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("burrow", 1, "burrow", "end", ::handleburrownotes);
  self.lastattacktime = gettime();
  self.burrowing = 0;
}

burrow_fx() {
  playFX(level._effect["mammoth_burrow"], self.origin + (0, 0, 0));
}

handleburrownotes(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "burrow_note":
      break;
  }
}

get_valid_burrow_emerge_location(var_0) {
  self endon("death");
  var_1 = 56;
  var_2 = 356;
  var_3 = 512;
  var_4 = undefined;

  if(isalive(var_0) && !is_enemy_vanguard(var_0)) {
    var_4 = find_emerge_node(var_0, var_1, var_2);

    if(!isDefined(var_4)) {
      var_4 = find_emerge_node(var_0, var_2, var_3);
    }
  }

  if(!isDefined(var_4)) {
    wait 0.05;
    var_4 = find_emerge_node(self, var_1, var_3);

    if(!isDefined(var_4)) {
      self.emerge_angles = undefined;
      return self.last_burrow_location;
    }
  }

  self.emerge_angles = var_4.angles;
  return var_4.origin;
}

find_emerge_node(var_0, var_1, var_2) {
  var_3 = getnodesinradiussorted(var_0.origin, var_2, var_1);
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(maps\mp\alien\_utility::is_normal_upright(anglestoup(var_6.angles))) {
      if(getpathdist(var_6.origin, var_0.origin, 256) != -1) {
        var_4 = var_6;
        break;
      }
    }

    wait 0.05;
  }

  return var_4;
}

mammoth_approach(var_0, var_1) {
  if(distancesquared(var_0.origin, self.origin) > 250000) {
    mammoth_approach_enemy(500, var_0);
  }

  for(;;) {
    if(!self.burrowing) {
      if(should_do_fissure_spawn()) {
        return "fissure_spawn";
      }

      if(should_do_new_phase()) {
        return "mammoth_angered";
      }
      else if(should_burrow(var_0)) {
        return "burrow";
      }
      else if(maps\mp\agents\alien\_alien_elite::can_do_charge_attack(var_0)) {
        return "charge";
      }
      else if(maps\mp\agents\alien\_alien_elite::run_to_slam(var_0)) {
        return "slam";
      }
    }

    wait 0.05;
  }
}

mammoth_approach_enemy(var_0, var_1) {
  self endon("stop_mammoth_approach");
  thread watch_for_immediate_abilities();
  maps\mp\agents\alien\_alien_think::run_near_enemy(var_0, var_1);
  self notify("stop_mammoth_approach");
}

should_burrow(var_0) {
  if(isDefined(self.burrow_now) && self.burrow_now) {
    return 1;
  }

  if(is_enemy_vanguard(var_0)) {
    return 0;
  }

  if(!self.canburrow) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  foreach(var_2 in level.donotburrowvolumes) {
    if(ispointinvolume(self.origin, var_2)) {
      return 0;
    }
  }

  var_4 = 0;

  if(distancesquared(self.origin, var_0.origin) > 262144.0) {
    var_4 = 1;
  }
  else if(attack_timer_expired() || burrow_timer_expired()) {
    var_4 = 1;
  }

  return var_4 && has_room_to_burrow();
}

is_enemy_vanguard(var_0) {
  return isDefined(var_0.helitype) && var_0.helitype == "remote_uav";
}

has_room_to_burrow() {
  var_0 = maps\mp\agents\_scriptedagents::droppostoground(self.origin + anglesToForward(self.angles) * 48.0);
  return isDefined(var_0);
}

attack_timer_expired() {
  if(gettime() - self.lastattacktime > 10000) {
    return 1;
  }

  return 0;
}

burrow_timer_expired() {
  if(gettime() - self.lastburrowattacktime > self.burrowtimeout) {
    return 1;
  }

  return 0;
}

should_do_new_phase() {
  var_0 = [0.85, 0.5, 0.25];

  if(self.currentphase >= var_0.size - 1) {
    return 0;
  }

  if(self.health / self.maxhealth > var_0[self.currentphase]) {
    return 0;
  }

  return 1;
}

should_do_fissure_spawn(var_0) {
  if(!self.canfissurespawn) {
    return 0;
  }

  if(!fissure_spawn_timer_expired()) {
    return 0;
  }

  if(!fissure_spawn_find_spawn_loc()) {
    return 0;
  }

  return 1;
}

fissure_spawn_timer_expired() {
  if(gettime() - self.lastfissurespawntime > self.fissurespawntimeout) {
    return 1;
  }

  return 0;
}

fissure_spawn_find_spawn_loc() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  self.fissurespawnlocs = [];
  var_2 = self.origin + var_0 * 56.0;
  var_2 = maps\mp\agents\_scriptedagents::droppostoground(var_2);

  if(isDefined(var_2) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_2, 12.0)) {
    self.fissurespawnlocs[self.fissurespawnlocs.size] = var_2;
  }

  var_3 = self.origin + var_1 * 56.0;
  var_3 = maps\mp\agents\_scriptedagents::droppostoground(var_3);

  if(isDefined(var_3) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_3, 12.0)) {
    self.fissurespawnlocs[self.fissurespawnlocs.size] = var_3;
  }

  var_4 = self.origin + var_1 * -56.0;
  var_4 = maps\mp\agents\_scriptedagents::droppostoground(var_4);

  if(isDefined(var_4) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_4, 12.0)) {
    self.fissurespawnlocs[self.fissurespawnlocs.size] = var_4;
  }

  if(self.fissurespawnlocs.size > 0) {
    return 1;
  }

  return 0;
}

fissure_spawn_attack(var_0) {
  self.melee_type = "fissure_spawn";
  self.numfissurespawns = get_default_fissure_spawns();
  maps\mp\agents\alien\_alien_think::alien_melee(var_0);
}

release_reserved_space_on_death() {
  self waittill("death");

  if(isDefined(self.reserved_space) && self.reserved_space > 0) {
    maps\mp\alien\_spawn_director::release_custom_spawn_space(self.reserved_space);
  }
}

fissure_spawn(var_0) {
  self endon("death");
  self.reserved_space = int(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(self.numfissurespawns, 1));
  thread release_reserved_space_on_death();
  self.lastfissurespawntime = gettime();

  while(self.reserved_space > 0) {
    var_1 = min(self.reserved_space, self.fissurespawnlocs.size);
    do_fissure_spawn(var_1, self.fissurespawnlocs);
  }

  if(self.reserved_space > 0) {
    maps\mp\alien\_spawn_director::release_custom_spawn_space(self.reserved_space);
    self.reserved_space = 0;
  }
}

do_fissure_spawn(var_0, var_1) {
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_melee_swipe", 2, "attack_melee", "alien_slam_big");
  var_2 = level.alien_types[self.alien_type].attributes["slam_min_damage"];
  var_3 = level.alien_types[self.alien_type].attributes["slam_max_damage"];
  maps\mp\agents\alien\_alien_elite::area_damage_and_impulse(250, var_2, var_3, 800);
  thread process_fissure_spawns(var_0, var_1);
  maps\mp\agents\_scriptedagents::waituntilnotetrack("attack_melee", "end");
  level notify("dlc_vo_notify", "phantom_backup", self);
}

process_fissure_spawns(var_0, var_1, var_2) {
  var_2 = spawnStruct();
  var_2.angles = self.angles;
  var_3 = level.cycle_data.spawn_node_info["chen_test"].vignetteinfo["brute"];
  var_4 = (0, 0, -100);

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = var_5 % var_1.size;
    var_2.origin = var_1[var_6] + var_4;
    var_7 = maps\mp\alien\_spawn_director::process_custom_spawn("brute", var_2, var_3);
    self.reserved_space--;
    wait(randomfloatrange(0.01, 0.14));
  }
}

mammoth_angered(var_0) {
  self.currentphase++;

  switch (self.currentphase) {
    case 1:
      self.moveplaybackrate = 1.4;
      self.defaultemissive = 0.2;
      self.maxemissive = 0.2;
      maps\mp\alien\_utility::set_alien_emissive_default(0.2);
      self.canfissurespawn = 1;
      self.damagescalar = 1.2;
      break;
    case 2:
      self.moveplaybackrate = 1.2;
      self.defaultemissive = 1.0;
      self.maxemissive = 1.0;
      maps\mp\alien\_utility::set_alien_emissive_default(0.2);
      self.damagescalar = 1.4;
      maps\mp\agents\alien\_alien_think::set_alien_movemode("run");
      break;
    default:
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("prepare_to_regen", 0, 2.0, "prepare_to_regen", "end");
  fissure_spawn_angered(var_0);
}

fissure_spawn_angered(var_0) {
  self.numfissurespawns = get_default_fissure_spawns() * 2;

  if(!fissure_spawn_find_spawn_loc()) {
    self.fissurespawnlocs[self.fissurespawnlocs.size] = self.origin;
  }

  fissure_spawn(var_0);
}

mammoth_angered_attack(var_0) {
  self.melee_type = "mammoth_angered";
  maps\mp\agents\alien\_alien_think::alien_melee(var_0);
}

handle_badpath(var_0) {
  self.badpath = 0;

  if(self.badpathcount > 3) {
    if(has_room_to_burrow() && !is_enemy_vanguard(var_0)) {
      self.badpathcount = 0;
      self.burrow_now = 1;
      self notify("alien_main_loop_restart");
    } else
      maps\mp\agents\alien\_alien_think::handle_badpath(var_0);
  }
}

watch_for_immediate_abilities() {
  self endon("death");
  self endon("stop_mammoth_approach");

  for(;;) {
    if(fissure_spawn_timer_expired() || should_do_new_phase() || isDefined(self.enemy) && should_burrow(self.enemy)) {
      self notify("stop_mammoth_approach");
      return;
    }

    wait 1.0;
  }
}