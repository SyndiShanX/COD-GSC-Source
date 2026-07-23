/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1478.gsc
**************************************/

main() {
  if(isDefined(level.juggernaut_initialized)) {
    return;
  }
  level.juggernaut_initialized = 1;

  if(!isDefined(level.subclass_spawn_functions)) {
    level.subclass_spawn_functions = [];
  }
  level.subclass_spawn_functions["juggernaut"] = ::subclass_juggernaut;
  level.juggernaut_next_alert_time = 0;
}

subclass_juggernaut() {
  self.juggernaut = 1;
  self.minpaindamage = 200;
  self.grenadeammo = 0;
  self.doorflashchance = 0.05;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.no_pistol_switch = 1;
  self.norunngun = 1;
  self.dontmelee = 1;
  self.disableexits = 1;
  self.disablearrivals = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.neversprintforvariation = 1;
  self.a.disablelongdeath = 1;
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  init_juggernaut_animsets();
  maps\_utility::add_damage_function(animscripts\pain::additive_pain);
  maps\_utility::add_damage_function(maps\_spawner::pain_resistance);

  if(!self isbadguy()) {
    return;
  }
  self.bullet_resistance = 40;
  maps\_utility::add_damage_function(maps\_spawner::bullet_resistance);
  thread juggernaut_hunt_immediately_behavior();
  thread juggernaut_sound_when_player_close();
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  level notify("juggernaut_spawned");
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(self) && isDefined(self.nodrop)) {
    var_3 = [];
    var_3[var_3.size] = "left";
    var_3[var_3.size] = "right";
    var_3[var_3.size] = "chest";
    var_3[var_3.size] = "back";
    animscripts\shared::detachallweaponmodels();

    foreach(var_5 in var_3) {
      var_2 = self.a.weaponpos[var_5];

      if(var_2 == "none") {
        continue;
      }
      self.weaponinfo[var_2].position = "none";
      self.a.weaponpos[var_5] = "none";
    }

    self.weapon = "none";
    animscripts\shared::updateattachedweaponmodels();
  }

  level notify("juggernaut_died");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
}

juggernaut_hunt_immediately_behavior() {
  self endon("death");
  self endon("stop_hunting");
  self.usechokepoints = 0;

  for(;;) {
    wait 0.5;

    if(isDefined(self.enemy)) {
      self setgoalpos(self.enemy.origin);
      self.goalradius = 128;
      self.goalheight = 81;
    }
  }
}

juggernaut_sound_when_player_close() {
  self endon("death");
  level endon("special_op_terminated");

  if(isDefined(level.skip_juggernaut_intro_sound) && level.skip_juggernaut_intro_sound) {
    return;
  }
  var_0 = 2500;

  if(level.script == "ending") {
    common_scripts\utility::flag_wait("panic_button");
    var_0 = 750;
  }

  for(;;) {
    wait 0.05;

    if(gettime() < level.juggernaut_next_alert_time) {
      continue;
    }
    var_1 = maps\_utility::get_closest_player(self.origin);

    if(!isalive(var_1)) {
      continue;
    }
    if(distance(var_1.origin, self.origin) > var_0) {
      continue;
    }
    if(level.pmc_alljuggernauts) {
      var_2 = self gettagorigin("tag_flash");

      if(!bullettracepassed(self getEye(), var_1 getEye(), 0, undefined)) {
        wait 0.25;
        continue;
      }
    }

    break;
  }

  level.juggernaut_next_alert_time = gettime() + 15000;
  level notify("juggernaut_attacking");
  common_scripts\utility::array_thread(level.players, maps\_utility::playlocalsoundwrapper, "_juggernaut_attack");
}

#using_animtree("generic_human");

init_juggernaut_animsets() {
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  maps\_utility::set_move_animset("run", %juggernaut_runf, %juggernaut_sprint);
  maps\_utility::set_move_animset("walk", %juggernaut_walkf);
  maps\_utility::set_move_animset("cqb", %juggernaut_walkf);
  maps\_utility::set_combat_stand_animset(%juggernaut_stand_fire_burst, %juggernaut_aim5, %juggernaut_stand_idle, %juggernaut_stand_reload);
}