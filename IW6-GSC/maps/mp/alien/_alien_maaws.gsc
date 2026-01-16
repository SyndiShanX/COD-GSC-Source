/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_alien_maaws.gsc
******************************************/

alien_maaws_init() {
  level.alternate_trinity_weapon_try_use = ::tryuse_dpad_maaws;
  level.alternate_trinity_weapon_use = ::use_dpad_maaws;
  level.alternate_trinity_weapon_cancel_use = ::canceluse_dpad_maaws;
  level._effect["maaws_burst"] = loadfx("vfx/gameplay/alien/vfx_alien_maaws_burst");
}

tryuse_dpad_maaws(var_0, var_1) {
  thread tryuse_dpad_maaws_internal(var_0, var_1);
}

tryuse_dpad_maaws_internal(var_0, var_1) {
  waittillframeend;
  maps\mp\alien\_utility::store_weapons_status();
  self.last_weapon = self getcurrentweapon();
  var_2 = "iw6_alienmaaws_mp";

  if(!isDefined(level.cosine)) {
    level.cosine = [];
    level.cosine["90"] = cos(90);
    level.cosine["89"] = cos(89);
    level.cosine["45"] = cos(45);
    level.cosine["25"] = cos(25);
    level.cosine["15"] = cos(15);
    level.cosine["10"] = cos(10);
    level.cosine["5"] = cos(5);
  }

  maps\mp\_utility::_giveweapon(var_2);
  wait 0.05;
  self switchtoweapon(var_2);
  self disableweaponswitch();

  if(var_1 > 3)
    self setweaponammoclip(var_2, 3);
  else if(var_1 > 0)
    self setweaponammoclip(var_2, 2);

  thread handle_missile_logic(var_2, var_1);
}

use_dpad_maaws(var_0, var_1) {
  if(maps\mp\alien\_utility::is_in_laststand()) {
    return;
  }
  var_2 = "iw6_alienmaaws_mp";

  switch (var_1) {
    case 0:
      var_2 = "iw6_alienmaaws_mp";
      break;
    case 1:
      var_2 = "iw6_alienmaaws_mp";
      break;
    case 2:
      var_2 = "iw6_alienmaaws_mp";
      break;
    case 3:
      var_2 = "iw6_alienmaaws_mp";
      break;
    case 4:
      var_2 = "iw6_alienmaaws_mp";
      break;
  }

  thread maps\mp\alien\_combat_resources::watch_ammo(var_2);
  wait 0.1;
}

watch_rank_for_fof(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("fof_cancel");
  self endon("fof_cancel");

  if(var_1 > 0) {
    while(self getcurrentweapon() != var_0)
      wait 0.05;

    self thermalvisionfofoverlayon();

    while(self getcurrentweapon() == var_0)
      wait 0.05;

    self thermalvisionfofoverlayoff();
  }
}

within_fov_set_dot(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_alien_origin(var_2);

  if(!isDefined(var_5))
    return 0;

  var_6 = vectornormalize(var_5 - var_0);

  if(!isDefined(var_4) || var_4 == "forward")
    var_7 = anglesToForward(var_1);
  else
    var_7 = anglestoright(var_1);

  var_8 = vectordot(var_7, var_6);
  var_2.dot = var_8;
  return var_8 >= var_3;
}

missile_bullet_trace(var_0, var_1, var_2, var_3) {
  var_4 = bulletTrace(var_0, var_1, 1, level.player, 1, 0, 1);

  if(!isDefined(var_4["entity"]))
    return 0;

  if(var_4["entity"] != var_2)
    return 0;
  else
    return 1;
}

get_forward_point(var_0, var_1) {
  var_2 = anglesToForward(var_1);
  var_2 = vectornormalize(var_2);
  var_2 = (var_2[0] * 2, var_2[1] * 2, var_2[2] * 2);
  var_2 = var_2 + var_0;
  return var_2;
}

handle_missile_logic(var_0, var_1) {
  self endon("cancel_maaws");
  self endon("death");
  self endon("disconnect");
  var_2 = "iw6_alienmaawschild_mp";
  self.maaws_done = 0;

  if(!isDefined(self.trace_available))
    thread manage_bullet_trace_queue(var_0);

  while(self getammocount(var_0)) {
    level.alien_on_drill = undefined;
    self waittill("missile_fire", var_3, var_4);

    if(!isDefined(level.outlined_aliens))
      level.outlined_aliens = [];

    level.outlined_aliens common_scripts\utility::array_removeundefined(level.outlined_aliens);
    var_5 = 10000;
    var_6 = 0;
    var_7 = var_3.origin;

    while(isDefined(var_3) && var_6 < var_5) {
      var_8 = var_3.origin;
      var_6 = distancesquared(var_8, var_7);
      wait 0.1;
    }

    if(isDefined(var_3)) {
      var_3 thread alien_maaws_initial_projectile_death_fx();
      var_9 = var_3.origin;
      var_10 = var_3.angles;
      var_11 = 45;
      thread fire_missile_at_angles(var_9, var_10, var_2, 0, (1, 0, 0));
      common_scripts\utility::waitframe();
      var_12 = (var_10[0] - var_11 / 10, var_10[1] - var_11 / 4, var_10[2]);

      if(isDefined(var_3))
        thread fire_missile_at_angles(var_9, var_12, var_2, var_1, (0, 1, 0));

      common_scripts\utility::waitframe();
      var_13 = (var_10[0] - var_11 / 10, var_10[1] + var_11 / 4, var_10[2]);

      if(isDefined(var_3))
        thread fire_missile_at_angles(var_9, var_13, var_2, var_1, (0, 0, 1));

      common_scripts\utility::waitframe();

      if(var_1 > 2) {
        var_13 = (var_10[0], var_10[1] + var_11 / 2, var_10[2]);

        if(isDefined(var_3))
          thread fire_missile_at_angles(var_9, var_13, var_2, var_1, (1, 1, 0));

        common_scripts\utility::waitframe();
        var_14 = (var_10[0], var_10[1] - var_11 / 2, var_10[2]);

        if(isDefined(var_3))
          thread fire_missile_at_angles(var_9, var_14, var_2, var_1, (1, 0, 1));

        common_scripts\utility::waitframe();
      }
    }

    if(isDefined(var_3))
      var_3 delete();
  }

  self.maaws_done = 1;
}

fire_missile_at_angles(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_5 = get_forward_point(var_0, var_1);
  var_6 = magicbullet(var_2, var_0, var_5, self);
  var_6 endon("death");
  self.player_missiles[self.player_missiles.size] = var_6;
  thread damage_alien_on_drill(var_6);

  if(isDefined(var_3) && var_3 > 1) {
    var_7 = maps\mp\alien\_spawnlogic::get_alive_agents();

    if(level.script == "mp_alien_last" && isDefined(level.active_ancestors))
      var_7 = common_scripts\utility::array_combine(var_7, level.active_ancestors);

    if(isDefined(level.seeder_active_turrets))
      var_7 = common_scripts\utility::array_combine(var_7, level.seeder_active_turrets);

    var_7 = get_alien_targets_in_fov(self.origin, self.angles, "10");
    var_8 = get_missile_target(var_6, var_7, var_4);

    if(isDefined(var_8)) {
      var_6.target_ent = var_8;
      var_9 = (0, 0, 10);

      if(isalive(var_6.target_ent) && isDefined(var_6.target_ent.alien_type) && var_6.target_ent.alien_type == "ancestor")
        var_9 = (0, 0, 110);

      var_6 missile_settargetent(var_8, var_9);
    } else {
      wait 0.1;
      thread scan_for_targets(var_6, var_4);
    }
  }
}

damage_alien_on_drill(var_0) {
  self endon("disconnect");
  self endon("death");
  var_1 = undefined;
  var_0 waittill("death");
  var_1 = var_0.origin;

  if(isDefined(var_1) && isDefined(level.alien_on_drill) && isalive(level.alien_on_drill)) {
    if(distancesquared(level.alien_on_drill.origin, var_1) < 10000)
      level.alien_on_drill dodamage(275, var_1, self, var_0, "MOD_PROJECTILE");
    else if(distancesquared(level.alien_on_drill.origin, var_1) < 62500)
      level.alien_on_drill dodamage(125, var_1, self, var_0, "MOD_PROJECTILE");
  }
}

scan_for_targets(var_0, var_1) {
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");
  var_2 = undefined;

  while(!isDefined(var_2)) {
    var_2 = get_missile_target(var_0, undefined, var_1);

    if(isDefined(var_2)) {
      var_0.target_ent = var_2;
      var_3 = (0, 0, 10);

      if(isalive(var_0.target_ent) && isDefined(var_0.target_ent.alien_type) && var_0.target_ent.alien_type == "ancestor")
        var_3 = (0, 0, 110);

      var_0 missile_settargetent(var_2, var_3);
      break;
    }

    wait 0.25;
  }
}

get_missile_target(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(var_0))
    return undefined;

  var_3 = get_array_of_targets(var_0, "5", var_1, var_2);

  if(var_3.size == 0) {
    var_3 = get_array_of_targets(var_0, "45", var_1, var_2);

    if(var_3.size == 0)
      var_3 = get_array_of_targets(var_0, "89", var_1, var_2);
  }

  if(var_3.size > 0) {
    var_4 = var_3[0];

    foreach(var_6 in var_3) {
      if(isDefined(var_6.alien_type) && (var_6.alien_type == "gargoyle" || var_6.alien_type == "bomber")) {
        var_4 = var_6;
        break;
      }
    }

    if(!is_in_array(level.outlined_aliens, var_4))
      level.outlined_aliens[level.outlined_aliens.size] = var_4;

    return var_4;
  }

  return undefined;
}

get_array_of_targets(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");

  if(!isDefined(var_0))
    return undefined;

  var_4 = 0;
  var_5 = [];
  var_6 = [];

  if(isDefined(var_2))
    var_6 = get_alien_targets_in_fov(self.origin, self.angles, var_1, var_2);
  else
    var_6 = get_alien_targets_in_fov(var_0.origin, var_0.angles, var_1);

  if(var_6.size > 0) {
    var_6 = common_scripts\utility::get_array_of_closest(var_0.origin, var_6);

    foreach(var_8 in var_6) {
      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_8)) {
        continue;
      }
      var_9 = get_alien_origin(var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      if(var_8 alien_is_on_drill()) {
        var_5[var_5.size] = var_8;
        level.alien_on_drill = var_8;
        continue;
      }

      self.trace_available[self.trace_available.size] = var_0;
      var_0 waittill("my_turn_to_trace");

      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_8)) {
        continue;
      }
      var_9 = get_alien_origin(var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      if(isDefined(var_8.coll_model))
        var_8 = var_8.coll_model;

      if(missile_bullet_trace(var_0.origin, var_9, var_8, var_3)) {
        var_5[var_5.size] = var_8;
        break;
      }

      common_scripts\utility::waitframe();
    }
  }

  return var_5;
}

get_alien_targets_in_fov(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_3)) {
    var_5 = maps\mp\alien\_spawnlogic::get_alive_agents();

    if(level.script == "mp_alien_last" && isDefined(level.active_ancestors))
      var_5 = common_scripts\utility::array_combine(var_5, level.active_ancestors);

    if(isDefined(level.seeder_active_turrets))
      var_5 = common_scripts\utility::array_combine(var_5, level.seeder_active_turrets);
  } else
    var_5 = var_3;

  foreach(var_7 in var_5) {
    if(maps\mp\alien\_utility::is_true(var_7.pet)) {
      continue;
    }
    if(isDefined(var_7.agent_type) && (var_7.agent_type == "kraken" || var_7.agent_type == "kraken_tentacle")) {
      continue;
    }
    if(within_fov_set_dot(var_0, var_1, var_7, level.cosine[var_2]))
      var_4[var_4.size] = var_7;
  }

  return var_4;
}

manage_bullet_trace_queue(var_0) {
  self endon("death");
  self endon("disconnect");
  self.trace_available = [];
  self.player_missiles = [];

  for(;;) {
    self.player_missiles = common_scripts\utility::array_removeundefined(self.player_missiles);

    if(self.maaws_done && self.player_missiles.size == 0) {
      break;
    }

    if(self.trace_available.size > 0) {
      while(!isDefined(self.trace_available[0]))
        self.trace_available = common_scripts\utility::array_remove(self.trace_available, self.trace_available[0]);

      self.trace_available[0] notify("my_turn_to_trace");
      self.trace_available = common_scripts\utility::array_remove(self.trace_available, self.trace_available[0]);
    }

    common_scripts\utility::waitframe();
  }

  self.trace_available = undefined;
}

get_alien_origin(var_0) {
  if(isalive(var_0) && isDefined(var_0.alien_type) && (var_0.alien_type == "seeder" || var_0.alien_type == "elite"))
    var_1 = var_0 gettagorigin("TAG_ORIGIN");
  else if(isDefined(var_0.alien_type) && var_0.alien_type == "seeder_spore") {
    if(!isDefined(var_0.coll_model))
      return undefined;

    var_1 = var_0 gettagorigin("J_Spore_46");
    var_0 = var_0.coll_model;
  } else if(isalive(var_0) && isDefined(var_0.alien_type) && var_0.alien_type == "ancestor")
    var_1 = var_0.origin + (0, 0, 110);
  else if(isalive(var_0) && isDefined(var_0.model) && maps\mp\alien\_utility::has_tag(var_0.model, "J_SpineUpper"))
    var_1 = var_0 gettagorigin("J_SpineUpper");
  else
    var_1 = var_0.origin + (0, 0, 10);

  return var_1;
}

alien_is_on_drill() {
  if(isDefined(self.melee_type) && self.melee_type == "synch" && (isDefined(self.synch_anim_state) && issubstr(self.synch_anim_state, "attack_drill")))
    return 1;

  return 0;
}

alien_maaws_initial_projectile_death_fx() {
  playFX(level._effect["maaws_burst"], self.origin);
}

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

canceluse_dpad_maaws(var_0, var_1) {
  self endon("disconnect");
  maps\mp\alien\_combat_resources::wait_to_cancel_dpad_weapon();
  self notify("cancel_maaws");
  self takeweapon("iw6_alienmaaws_mp");
  self.maaws_done = 1;

  if(isDefined(self.last_weapon) && player_not_carrying_drill_or_cortex()) {
    self switchtoweapon(self.last_weapon);
    self enableweaponswitch();
  }

  return 1;
}

player_not_carrying_drill_or_cortex() {
  if(!isDefined(level.drill_carrier) || isDefined(level.drill_carrier) && self != level.drill_carrier)
    return 1;
  else if(!isDefined(level.cortex_carrier) || isDefined(level.cortex_carrier) && self != level.cortex_carrier)
    return 1;

  return 0;
}