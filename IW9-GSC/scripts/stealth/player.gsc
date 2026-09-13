/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\player.gsc
***********************************************/

main() {
  if(isDefined(self.stealth)) {
    return;
  }
  self endon("death");
  self endon("stealth_disabled");
  self.stealth = spawnStruct();
  scripts\stealth\utility::group_flag_init("stealth_spotted");
  scripts\engine\utility::ent_flag_init("stealth_enabled");
  _id_E403865F115834A8("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_in_shadow");
  scripts\engine\utility::ent_flag_init("stealth_use_real_lighting");
  scripts\engine\utility::ent_flag_init("stealth_use_player_camera_movement");
  scripts\stealth\utility::group_add();

  if(scripts\common\utility::issp()) {
    thread stealthhints_thread();

    if(isDefined(level.stealth._id_84CC26FCABCAFCE7))
      [[level.stealth._id_84CC26FCABCAFCE7]]();
  } else {
    thread scripts\stealth\manager::player_grenade_check();

    if(isDefined(level._id_6CCEE8E6C00F06E6))
      self thread[[level._id_6CCEE8E6C00F06E6]]();
  }
}

_id_E403865F115834A8(message) {
  _func_31A67E5538887627(self, message, 1);
  scripts\engine\utility::ent_flag_set(message);
}

_id_03718FC282393305(message) {
  _func_31A67E5538887627(self, message, 0);
  scripts\engine\utility::ent_flag_clear(message);
}

combatstate_thread(enabled) {
  if(!isDefined(enabled))
    enabled = 1;

  if(!enabled) {
    self notify("stop_player_combat_state_thread");
    self.stealth.combatstate = undefined;
    return;
  } else if(isDefined(self.stealth.combatstate)) {
    return;
  }
  self endon("death");
  self endon("stealth_disabled");
  self endon("stop_player_combat_state_thread");
  self endon("disconnect");
  childthread playerattackedmonitor();
  childthread combatstate_updatethread();
  self.stealth.combatstate = spawnStruct();
  self.stealth.combatstate.name = "stealth";
  self.stealth.combatstate.type = "idle";
  self.stealth.combatstate.updatefuncs = [];
  _id_C6EDCE1B02951AA2 = [];
  _id_20BB85D7BCD0392D = [];

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    _id_C6EDCE1B02951AA2 = scripts\engine\utility::array_removeundefined(_id_C6EDCE1B02951AA2);
    _id_C6EDCE1B02951AA2 = scripts\engine\utility::array_removedead(_id_C6EDCE1B02951AA2);
    _id_20BB85D7BCD0392D = scripts\engine\utility::array_removeundefined(_id_20BB85D7BCD0392D);
    _id_20BB85D7BCD0392D = scripts\engine\utility::array_removedead(_id_20BB85D7BCD0392D);
    _id_FF7786B6619EB7EB = [];
    _id_67CED9344E835690 = [];
    _id_0D357C65B8336AAB = 0;

    if(isDefined(self.lastattackedtime) && !scripts\engine\utility::time_has_passed(self.lastattackedtime, 10))
      _id_0D357C65B8336AAB = 1;

    foreach(enemy in getaiarray("axis")) {
      if(!isalive(enemy)) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(_id_C6EDCE1B02951AA2, enemy)) {
        if(enemy scripts\engine\utility::doinglongdeath()) {
          continue;
        }
        if(scripts\engine\utility::is_equal(enemy.script, "pain"))
          continue;
      }

      if(enemy[[enemy.fnisinstealthcombat]]()) {
        if(isDefined(self.stealth.combatstate.maxcombatdist)) {
          dist = self.stealth.combatstate.maxcombatdist;

          if(distancesquared(self.origin, enemy.origin) > squared(dist)) {
            _id_67CED9344E835690[_id_67CED9344E835690.size] = enemy;
            continue;
          }
        }

        _id_FF7786B6619EB7EB[_id_FF7786B6619EB7EB.size] = enemy;

        if(_id_0D357C65B8336AAB) {
          continue;
        }
        if(!scripts\engine\utility::is_equal(enemy.enemy, self)) {
          continue;
        }
        if(enemy cansee(self))
          _id_0D357C65B8336AAB = 1;

        continue;
      }

      if(enemy[[enemy.fnisinstealthhunt]]())
        _id_67CED9344E835690[_id_67CED9344E835690.size] = enemy;
    }

    _id_B8346AA5A5E3A886 = self.stealth.combatstate.name;
    _id_9B2AF7384EEEAF2D = self.stealth.combatstate.type;
    name = _id_B8346AA5A5E3A886;
    type = undefined;

    if(_id_B8346AA5A5E3A886 == "combat") {
      if(_id_FF7786B6619EB7EB.size == 0) {
        name = "stealth";

        if(scripts\engine\utility::array_intersection(_id_C6EDCE1B02951AA2, _id_67CED9344E835690).size > 0)
          type = "hunt";
        else if(_id_67CED9344E835690.size == 0)
          type = "all_clear";
        else
          type = "combat_clear";
      } else if(scripts\engine\utility::is_equal(_id_9B2AF7384EEEAF2D, "unaware") && _id_0D357C65B8336AAB)
        type = "aware";
    } else if(_id_FF7786B6619EB7EB.size > 0) {
      name = "combat";

      if(_id_0D357C65B8336AAB)
        type = "aware";
      else
        type = "unaware";
    } else if(scripts\engine\utility::is_equal(_id_9B2AF7384EEEAF2D, "hunt") && _id_67CED9344E835690.size == 0)
      type = "all_clear";

    if(name != _id_B8346AA5A5E3A886 || isDefined(type) && !scripts\engine\utility::is_equal(type, _id_9B2AF7384EEEAF2D)) {
      self.stealth.combatstate.name = name;
      self.stealth.combatstate.type = type;
      self notify("player_combat_state_updated", name, type);
    }

    _id_C6EDCE1B02951AA2 = _id_FF7786B6619EB7EB;
    _id_20BB85D7BCD0392D = _id_67CED9344E835690;
    waitframe();
  }
}

combatstate_updatethread() {
  for(;;) {
    self waittill("player_combat_state_updated", name, type);

    foreach(func in self.stealth.combatstate.updatefuncs)
    self thread[[func]](name, type);
  }
}

combatstate_addupdatefunc(key, func) {
  self.stealth.combatstate.updatefuncs[key] = func;
}

combatstate_removeupdatefunc(key) {
  self.stealth.combatstate.updatefuncs = scripts\engine\utility::array_remove_key(self.stealth.combatstate.updatefuncs, key);
}

playerattackedmonitor() {
  for(;;) {
    level scripts\engine\utility::waittill_any_2("an_enemy_shot", "enemy_grenade_fire");
    self.lastattackedtime = gettime();
  }
}

_id_385496CB9CD5A920() {
  if(!scripts\engine\utility::ent_flag_exist("stealth_social_reveal"))
    scripts\engine\utility::ent_flag_init("stealth_social_reveal");

  thread _id_18C3FB058E462DAF();
}

_id_B66BA4277FBEDCEC() {
  self notify("playerSocialThread");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("playerSocialThread");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("playerSocialMonitorThread");
}

_id_18C3FB058E462DAF() {
  self endon("death_or_disconnect");
  self notify("playerSocialThread");
  self endon("playerSocialThread");
  childthread _id_D695E97A1E1C091F();

  for(;;) {
    if(!scripts\engine\utility::ent_flag("stealth_social_reveal"))
      _id_3B64EB40368C1450::set("playerSocialThread", "ignoreme", 1);

    scripts\engine\utility::ent_flag_wait("stealth_social_reveal");
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("playerSocialThread");
    scripts\engine\utility::ent_flag_waitopen("stealth_social_reveal");

    while(_func_910A912F327B8D34(self) > 0 || level scripts\engine\utility::flag("stealth_spotted"))
      wait 1;
  }
}

_id_D695E97A1E1C091F() {
  for(;;) {
    revealed = 0;
    weapon = self getcurrentweapon();

    if(scripts\engine\utility::_id_53C4C53197386572(weapon.classname, "item") != "item")
      revealed = 1;

    if(revealed)
      _id_3B64EB40368C1450::set("playerSocialMonitorThread", "stealth_social_reveal", 1);
    else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("playerSocialMonitorThread");

    waitframe();
  }
}

stealthhints_thread() {
  self endon("stealth_disabled");
  self.stealth.hints = spawnStruct();
  self.stealth.hints.causeofdeath = undefined;
  self.stealth.hints.investigators = [];
  self.stealth.hints.deathhints["footstep_sprint"] = 6;
  self.stealth.hints.deathhints["gunshot_suppressed"] = 8;
  self.stealth.hints.deathhints["proximity_speed"] = 16;
  self.stealth.hints.deathhints["sight_standing"] = 19;
  self.stealth.hints.deathhints["gunshot"] = 201;
  self.stealth.hints.deathhints["footstep_walk"] = 203;
  childthread stealthhints_eventmonitor();
  childthread stealthhints_deathmonitor();
  childthread stealthhints_combatmonitor();
}

stealthhints_eventmonitor() {
  self endon("death");

  while(isalive(self)) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    level waittill("stealth_event", event, receiver);

    if(!isalive(receiver)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(event.entity, level.player)) {
      continue;
    }
    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(scripts\stealth\utility::any_groups_in_combat()) {
      if(event.type != "combat") {
        continue;
      }
      _id_2728A62095970115 = 0;

      foreach(guy in getaiarray(receiver.team)) {
        if(guy == receiver) {
          continue;
        }
        if(guy[[guy.fnisinstealthcombat]]()) {
          _id_2728A62095970115 = 1;
          break;
        }
      }

      if(_id_2728A62095970115)
        continue;
    }

    eventtype = event.typeorig;

    if(eventtype == "gunshot" && istrue(level.hassuppressedweapons))
      eventtype = "gunshot_suppressed";
    else if((eventtype == "sight" || eventtype == "proximity") && self issprinting())
      eventtype = "footstep_sprint";
    else if(eventtype == "proximity" && length2dsquared(level.player getvelocity()) > 11025)
      eventtype = "proximity_speed";
    else if(eventtype == "sight" && self getstance() == "stand")
      eventtype = "sight_standing";

    if(!isDefined(self.stealth.hints.deathhints[eventtype])) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self.stealth.hints.investigators, receiver)) {
      continue;
    }
    childthread stealthhints_aimonitor(receiver, eventtype);
  }
}

stealthhints_aimonitor(ai, eventtype) {
  self endon("combat_started");
  self endon("stealth_enabled");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = ai;

  if(ai[[ai.fnisinstealthhunt]]()) {
    ai scripts\engine\utility::delaythread(10, scripts\engine\utility::send_notify, "stealthHints_timeout");
    ai scripts\engine\utility::waittill_any_3("stealth_combat", "death", "stealthHints_timeout");
  } else if(ai[[ai.fnisinstealthinvestigate]]())
    ai scripts\engine\utility::waittill_any_3("stealth_idle", "stealth_combat", "death");

  self.stealth.hints.investigators = scripts\engine\utility::array_remove(self.stealth.hints.investigators, ai);

  if(!isalive(ai) || !ai[[ai.fnisinstealthcombat]]()) {
    return;
  }
  self.stealth.hints.causeofdeath = eventtype;
  self.stealth.hints.investigators = [];
  self notify("combat_started");
}

stealthhints_deathmonitor() {
  self waittill("death");

  if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
    return;
  }
  if(isDefined(level.custom_death_quote)) {
    return;
  }
  if(!isDefined(self.stealth.hints.causeofdeath)) {
    return;
  }
  if(getdvarint("dvar_F9C8928CCEA1A275", 0)) {
    return;
  }
  level.custom_death_quote = self.stealth.hints.deathhints[self.stealth.hints.causeofdeath];
}

stealthhints_combatmonitor() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    while(!isDefined(self.stealth.hints.causeofdeath))
      waitframe();

    while(scripts\stealth\utility::any_groups_in_combat())
      waitframe();

    self.stealth.hints.causeofdeath = undefined;
  }
}