/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_arena.gsc
***************************************************/

main() {
  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  setup_bot_arena();
}

setup_callbacks() {
  if(_id_3686609F08F20087::ispickuploadouts()) {
    level.bot_funcs["dropped_weapon_think"] = ::arena_bot_think_seek_dropped_weapons;
    level.bot_funcs["dropped_weapon_cancel"] = ::arena_should_stop_seeking_weapon;
  }

  level.bot_funcs["gametype_think"] = ::bot_arena_think;
}

setup_bot_arena() {
  if(!_id_3686609F08F20087::_id_18F22ECED61C5F6F())
    level.bots_gametype_handles_class_choice = 1;

  while(!isDefined(level.arenaflag))
    waitframe();

  bot_fixup_pathnode_issues();

  if(istrue(game["isLaunchChunk"])) {
    if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3)
      return;
  }

  _id_FEFD545EDD4B2B36 = scripts\engine\utility::ter_op(level.objmodifier == 1, 3, 1);
  _id_35F1C253181907B1::setup_bot_dom(_id_FEFD545EDD4B2B36, 3);
}

bot_arena_think() {
  self notify("bot_arena_think");
  self endon("bot_arena_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.pers["bot_original_personality"]))
    self.pers["bot_original_personality"] = self.personality;

  wait 0.1;

  if(!_id_3686609F08F20087::_id_18F22ECED61C5F6F()) {
    if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0)
      _id_5DE9067B193F86A7::bot_gun_pick_personality_from_weapon(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
  }

  self._id_51E08EE04EF3BDBC = 0;

  for(;;) {
    if(isDefined(level.arenaflag) && level.arenaflag.visibleteam == "any") {
      self notify("bot_dom_think");

      if(!scripts\mp\bots\bots_util::bot_is_capturing() || !self._id_51E08EE04EF3BDBC)
        scripts\mp\bots\bots_strategy::bot_capture_zone(level.arenaflag.trigger.origin, level.arenaflag.nodes, level.arenaflag.trigger);

      self._id_51E08EE04EF3BDBC = 1;
    } else {
      self[[self.personality_update_function]]();
      thread bot_dom_think();
    }

    wait 0.05;
  }
}

arena_bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_7BA262CC7AB5E283 = "throwingknife_mp";

  for(;;) {
    _id_6FE7E4707CD33327 = 0;

    if(arena_bot_out_of_ammo() || scripts\mp\bots\bots_util::bot_get_low_on_all_ammo(0.33)) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        dropped_weapons = getEntArray("dropped_weapon", "targetname");
        _id_6AC6EE221E4D7361 = scripts\engine\utility::get_array_of_closest(self.origin, dropped_weapons);

        if(_id_6AC6EE221E4D7361.size > 0) {
          dropped_weapon = _id_6AC6EE221E4D7361[0];
          level.dropped_weapon = dropped_weapon;
          arena_bot_seek_dropped_weapon(dropped_weapon);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      _id_4B40839AD49E4F31 = self hasweapon(_id_7BA262CC7AB5E283);
      _id_82086A598C0CE6F9 = _id_4B40839AD49E4F31 && self getammocount(_id_7BA262CC7AB5E283) == 0;

      if(_id_82086A598C0CE6F9) {
        if(isDefined(self.going_for_knife)) {
          wait 5.0;
          continue;
        }

        _id_908F2E093410EE48 = getEntArray("dropped_knife", "targetname");
        _id_D22A29017F63AE78 = scripts\engine\utility::get_array_of_closest(self.origin, _id_908F2E093410EE48);

        foreach(knife in _id_D22A29017F63AE78) {
          if(!isDefined(knife)) {
            continue;
          }
          if(!isDefined(knife.calculated_closest_point)) {
            result = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, knife.origin, 32, self);

            if(isDefined(knife)) {
              knife.closest_point_on_grid = result;
              knife.calculated_closest_point = 1;
            } else
              continue;
          }

          if(isDefined(knife.closest_point_on_grid)) {
            self.going_for_knife = 1;
            arena_bot_seek_dropped_weapon(knife);
          }
        }
      } else if(_id_4B40839AD49E4F31)
        self.going_for_knife = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

arena_bot_seek_dropped_weapon(dropped_weapon) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", dropped_weapon) == 0) {
    if(istrue(level.snowballfight)) {
      _id_3956B7BB38700F0D = self botfirstavailablegrenade("lethal");
      _id_63B63448C8A71B0E = self botfirstavailablegrenade("tactical");

      if(isDefined(_id_3956B7BB38700F0D) && _id_3956B7BB38700F0D.basename == "snowball_mp") {
        eq = scripts\mp\equipment::getcurrentequipment("primary");
        _id_0BD0EAD7AE63D86D = scripts\mp\equipment::getequipmentammo(eq);

        if(_id_3956B7BB38700F0D.basename == "snowball_mp" && _id_0BD0EAD7AE63D86D > 3)
          return;
      }

      if(isDefined(_id_63B63448C8A71B0E) && _id_63B63448C8A71B0E.basename == "pball_mp") {
        eq = scripts\mp\equipment::getcurrentequipment("secondary");
        _id_0BD0EAD7AE63D86D = scripts\mp\equipment::getequipmentammo(eq);

        if(_id_63B63448C8A71B0E.basename == "pball_mp")
          return;
      }
    }

    action_thread = undefined;

    if(dropped_weapon.targetname == "dropped_weapon") {
      _id_00661C34EC270A10 = 1;
      _id_BCA88BEB35879353 = self getweaponslistprimaries();

      foreach(_id_CE408E508DCC5197 in _id_BCA88BEB35879353) {
        if(dropped_weapon.model == getweaponmodel(_id_CE408E508DCC5197))
          _id_00661C34EC270A10 = 0;
      }

      if(_id_00661C34EC270A10)
        action_thread = ::arena_bot_pickup_weapon;
    }

    _id_4F3B05E382BB8C7C = spawnStruct();
    _id_4F3B05E382BB8C7C.object = dropped_weapon;
    _id_4F3B05E382BB8C7C.script_goal_radius = 12;
    _id_4F3B05E382BB8C7C.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    _id_4F3B05E382BB8C7C.action_thread = action_thread;
    result = undefined;
    _id_E6874E9B453D7005 = dropped_weapon.origin;

    if(isDefined(dropped_weapon.bot_pickup_origin))
      _id_E6874E9B453D7005 = dropped_weapon.bot_pickup_origin;

    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", _id_E6874E9B453D7005, 100, _id_4F3B05E382BB8C7C);
  }
}

arena_bot_pickup_weapon(goal) {
  self botpressbutton("use", 0.5);
  thread updatebotpersonalitybasedonweapon();
}

updatebotpersonalitybasedonweapon() {
  self notify("updateBotWeaponBehavior");
  self endon("updateBotWeaponBehavior");
  wait 2;

  if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0)
    _id_5DE9067B193F86A7::bot_gun_pick_personality_from_weapon(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
}

arena_should_stop_seeking_weapon(goal) {
  if(arena_bot_get_total_gun_ammo() > 0) {
    _id_2DA1AA903372D531 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(goal.object)) {
      _id_462B87BDB6F81DB4 = goal.object.classname;

      if(scripts\engine\utility::string_starts_with(_id_462B87BDB6F81DB4, "weapon_"))
        _id_462B87BDB6F81DB4 = getsubstr(_id_462B87BDB6F81DB4, 7);

      _id_3A88DF1A7869A537 = scripts\mp\utility\weapon::getweapongroup(_id_462B87BDB6F81DB4);

      if(!bot_weapon_is_better_class(_id_2DA1AA903372D531, _id_3A88DF1A7869A537))
        return 1;
    }
  }

  if(!isDefined(goal.object))
    return 1;

  if(goal.object.targetname == "dropped_weapon") {
    foreach(weapon in self.weaponlist) {
      if(weapon.basename == "iw9_me_fists_mp")
        return 0;
    }

    if(arena_bot_get_total_gun_ammo() > 0)
      return 1;
  } else if(goal.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

arena_bot_get_total_gun_ammo() {
  _id_DEAB3AF8D6303B6C = 0;
  _id_BC9DA38A4BAB4CE2 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    _id_BC9DA38A4BAB4CE2 = self.weaponlist;
  else
    _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    _id_DEAB3AF8D6303B6C = _id_DEAB3AF8D6303B6C + self getweaponammoclip(weapon);
    _id_DEAB3AF8D6303B6C = _id_DEAB3AF8D6303B6C + self getweaponammostock(weapon);
  }

  if(_id_BC9DA38A4BAB4CE2.size == 1 && _id_BC9DA38A4BAB4CE2[0].basename == "iw9_me_fists_mp")
    _id_DEAB3AF8D6303B6C = 0;

  return _id_DEAB3AF8D6303B6C;
}

arena_bot_out_of_ammo() {
  _id_BC9DA38A4BAB4CE2 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    _id_BC9DA38A4BAB4CE2 = self.weaponlist;
  else
    _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

  if(_id_BC9DA38A4BAB4CE2.size == 1 && _id_BC9DA38A4BAB4CE2[0].basename == "iw9_me_fists_mp")
    return 1;

  foreach(weapon in _id_BC9DA38A4BAB4CE2) {
    if(self getweaponammoclip(weapon) > 0)
      return 0;

    if(self getweaponammostock(weapon) > 0)
      return 0;
  }

  return 1;
}

bot_rank_weapon_class(_id_3A88DF1A7869A537) {
  _id_530F611D71678B7A = 0;

  switch (_id_3A88DF1A7869A537) {
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
    case "weapon_other":
      break;
    case "weapon_pistol":
      _id_530F611D71678B7A = 1;
      break;
    case "weapon_sniper":
    case "weapon_dmr":
      _id_530F611D71678B7A = 2;
      break;
    case "weapon_battle":
    case "weapon_smg":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_assault":
      _id_530F611D71678B7A = 3;
      break;
  }

  return _id_530F611D71678B7A;
}

bot_weapon_is_better_class(_id_4C10CC06A42FBE99, _id_6C92F7F3D3607CA8) {
  _id_6340E02C42637715 = bot_rank_weapon_class(_id_4C10CC06A42FBE99);
  _id_0E197AEBBB030A0E = bot_rank_weapon_class(_id_6C92F7F3D3607CA8);
  return _id_0E197AEBBB030A0E > _id_6340E02C42637715;
}

iw8_ship_hack_add_flag_node(origin) {
  _id_A83A127241BE2CB0 = spawncovernode(origin, (0, randomint(360), 0), "Cover Stand");

  if(!isDefined(level.arenaflag.nodes))
    level.arenaflag.nodes = [];

  level.arenaflag.nodes[level.arenaflag.nodes.size] = _id_A83A127241BE2CB0;

  if(!isDefined(level.objectives["_a"].bottargets))
    level.objectives["_a"].bottargets = [];

  level.objectives["_a"].bottargets[level.objectives["_a"].bottargets.size] = _id_A83A127241BE2CB0;
}

bot_fixup_pathnode_issues() {
  if(level.mapname == "mp_m_pine") {
    origin = (22, 12, 0);
    thread iw8_ship_hack_add_flag_node(origin);
    origin = (-4, 1, 0);
    thread iw8_ship_hack_add_flag_node(origin);
    origin = (0, -33, 0);
    thread iw8_ship_hack_add_flag_node(origin);
    origin = (35, -23, 0);
    thread iw8_ship_hack_add_flag_node(origin);
  }
}

bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
    _id_4FB72B720667636B = gettime();

    if(_id_4FB72B720667636B > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(_id_4FB72B720667636B > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision())
        self.new_goal_time = _id_4FB72B720667636B + 5000;
      else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = _id_4FB72B720667636B + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1.0);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  if(self.current_flag _id_2DC3A143158CEC7C::getflagteam() == self.team)
    return 0;

  _id_3498229C5A4F8731 = get_flag_capture_radius();

  if(isDefined(self.current_flag.trigger) && distancesquared(self.origin, self.current_flag.trigger.origin) < _id_3498229C5A4F8731 * 2 * (_id_3498229C5A4F8731 * 2)) {
    _id_0F54364C67CFABC7 = get_ally_flags(self.team);

    if(_id_0F54364C67CFABC7.size == 2 && !scripts\engine\utility::array_contains(_id_0F54364C67CFABC7, self.current_flag) && !bot_allowed_to_3_cap())
      return 0;

    return 1;
  }

  return 0;
}

get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

has_override_flag_targets() {
  _id_88619EBFA03B1898 = get_override_flag_targets();
  return _id_88619EBFA03B1898.size > 0;
}

flag_has_been_captured_before(flag) {
  return !flag_has_never_been_captured(flag);
}

flag_has_never_been_captured(flag) {
  return flag.firstcapture;
}

bot_choose_flag() {
  flag = undefined;
  _id_7BA2208479205CF2 = [];
  _id_023B9E499D084CAD = [];
  _id_88619EBFA03B1898 = get_override_flag_targets();

  if(_id_88619EBFA03B1898.size > 0)
    _id_A9DDBDF62EA00196 = _id_88619EBFA03B1898;
  else
    _id_A9DDBDF62EA00196 = level.objectives;

  foreach(flag in _id_A9DDBDF62EA00196) {
    if(flag.objectivekey == "_a") {
      continue;
    }
    team = flag _id_2DC3A143158CEC7C::getflagteam();

    if(flag_has_been_captured_before(flag))
      _id_39C262926FFA6A00 = 0;

    if(team != self.team) {
      _id_7BA2208479205CF2[_id_7BA2208479205CF2.size] = flag;
      continue;
    }

    _id_023B9E499D084CAD[_id_023B9E499D084CAD.size] = flag;
  }

  _id_6EF72F11FC796DD7 = undefined;

  if(_id_023B9E499D084CAD.size == 1) {
    if(!bot_should_defend_flag(_id_023B9E499D084CAD[0], 1))
      _id_6EF72F11FC796DD7 = 1;
    else
      _id_6EF72F11FC796DD7 = !bot_should_defend(0.34);
  } else
    return;

  if(_id_6EF72F11FC796DD7) {
    _id_7727A8A4F4A2E7FE = _id_7BA2208479205CF2;

    if(_id_7727A8A4F4A2E7FE.size == 1)
      flag = _id_7727A8A4F4A2E7FE[0];
  } else {
    _id_F9E86F3C87AB9F97 = _id_023B9E499D084CAD;

    foreach(_id_D0076018172F593C in _id_F9E86F3C87AB9F97) {
      if(bot_should_defend_flag(_id_D0076018172F593C, _id_023B9E499D084CAD.size)) {
        flag = _id_D0076018172F593C;
        break;
      }
    }
  }

  if(_id_6EF72F11FC796DD7)
    capture_flag(flag);
  else
    defend_flag(flag);
}

bot_allowed_to_3_cap() {
  return 1;
}

bot_should_defend(_id_E8D030A9FA5114EE) {
  if(randomfloat(1) < _id_E8D030A9FA5114EE)
    return 1;

  _id_30F9CA2FA8449648 = level.bot_personality_type[self.personality];

  if(_id_30F9CA2FA8449648 == "stationary")
    return 1;
  else if(_id_30F9CA2FA8449648 == "active")
    return 0;
}

capture_flag(_id_F0B1A2262B2F7DFC, _id_1FCE7EA6F52B937E, _id_119041CDA5E9ADF2) {
  self.current_flag = _id_F0B1A2262B2F7DFC;

  if(isDefined(_id_F0B1A2262B2F7DFC.trigger)) {
    if(bot_dom_debug_should_protect_all()) {
      optional_params["override_goal_type"] = _id_1FCE7EA6F52B937E;
      optional_params["entrance_points_index"] = get_flag_label(_id_F0B1A2262B2F7DFC);
      scripts\mp\bots\bots_strategy::bot_protect_point(_id_F0B1A2262B2F7DFC.trigger.origin, get_flag_protect_radius(), optional_params);
    } else {
      optional_params["override_goal_type"] = _id_1FCE7EA6F52B937E;
      optional_params["entrance_points_index"] = get_flag_label(_id_F0B1A2262B2F7DFC);
      scripts\mp\bots\bots_strategy::bot_capture_zone(_id_F0B1A2262B2F7DFC.trigger.origin, _id_F0B1A2262B2F7DFC.nodes, _id_F0B1A2262B2F7DFC.trigger, optional_params);
    }

    if(!isDefined(_id_119041CDA5E9ADF2) || !_id_119041CDA5E9ADF2)
      thread monitor_flag_status(_id_F0B1A2262B2F7DFC);
  }
}

defend_flag(_id_3E376080E8DC9E3A) {
  self.current_flag = _id_3E376080E8DC9E3A;

  if(isDefined(_id_3E376080E8DC9E3A.trigger)) {
    if(bot_dom_debug_should_capture_all()) {
      optional_params["entrance_points_index"] = get_flag_label(_id_3E376080E8DC9E3A);
      scripts\mp\bots\bots_strategy::bot_capture_zone(_id_3E376080E8DC9E3A.trigger.origin, _id_3E376080E8DC9E3A.nodes, _id_3E376080E8DC9E3A.trigger, optional_params);
    } else {
      optional_params["entrance_points_index"] = get_flag_label(_id_3E376080E8DC9E3A);
      optional_params["nearest_node_to_center"] = _id_3E376080E8DC9E3A.nearest_node;
      scripts\mp\bots\bots_strategy::bot_protect_point(_id_3E376080E8DC9E3A.trigger.origin, get_flag_protect_radius(), optional_params);
    }

    thread monitor_flag_status(_id_3E376080E8DC9E3A);
  }
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius))
    level.capture_radius = 158;

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    _id_FA52693CF4679C62 = self botgetworldsize();
    _id_DD6786927BDE6332 = (_id_FA52693CF4679C62[0] + _id_FA52693CF4679C62[1]) / 2;
    level.protect_radius = min(1000, _id_DD6786927BDE6332 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(dialog, location) {
  if(issubstr(dialog, "losing") && dialog != "losing_score" && dialog != "losing_time" && dialog != "gamestate_domlosing") {
    _id_F666BE4A2ABC34F6 = getsubstr(dialog, dialog.size - 2);
    _id_9460C9E466ED3306 = get_specific_flag_by_label(_id_F666BE4A2ABC34F6);

    if(isDefined(_id_9460C9E466ED3306) && bot_allow_to_capture_flag(_id_9460C9E466ED3306)) {
      self botmemoryevent("known_enemy", undefined, _id_9460C9E466ED3306.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          _id_D493BD9F5A8ADF45 = distancesquared(self.origin, _id_9460C9E466ED3306.trigger.origin) < 490000;
          _id_CBA76C2FA6170699 = bot_is_protecting_flag(_id_9460C9E466ED3306);

          if(_id_D493BD9F5A8ADF45 || _id_CBA76C2FA6170699) {
            capture_flag(_id_9460C9E466ED3306);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(dialog, "secured")) {
    _id_F666BE4A2ABC34F6 = getsubstr(dialog, dialog.size - 2);
    _id_88AC1AB3287F7093 = get_specific_flag_by_label(_id_F666BE4A2ABC34F6);
    _id_88AC1AB3287F7093.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(dialog, location);
}

bot_allow_to_capture_flag(flag) {
  _id_88619EBFA03B1898 = get_override_flag_targets();

  if(_id_88619EBFA03B1898.size == 0)
    return 1;

  if(scripts\engine\utility::array_contains(_id_88619EBFA03B1898, flag))
    return 1;

  return 0;
}

monitor_flag_status(flag) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_F2B47E412166C272 = get_num_ally_flags(self.team);
  _id_82FE1C44F0E59DD5 = get_flag_capture_radius() * get_flag_capture_radius();
  _id_9A86288B6E984514 = get_flag_capture_radius() * 3 * (get_flag_capture_radius() * 3);
  _id_278595174C3B888B = 1;

  while(_id_278595174C3B888B) {
    _id_6E24445AC4C031BF = 0;
    _id_A78B2B0EBF2F977F = flag _id_2DC3A143158CEC7C::getflagteam();
    _id_0877F0C734271995 = get_num_ally_flags(self.team);
    _id_EB9BB8ACEEDA2DA3 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(_id_A78B2B0EBF2F977F == self.team && flag.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all())
          _id_6E24445AC4C031BF = 1;
      }

      if(_id_0877F0C734271995 == 2 && _id_A78B2B0EBF2F977F != self.team && !bot_allowed_to_3_cap()) {
        if(isDefined(flag.trigger) && distancesquared(self.origin, flag.trigger.origin) > _id_82FE1C44F0E59DD5)
          _id_6E24445AC4C031BF = 1;
      }

      foreach(_id_5607F7513EB816A2 in _id_EB9BB8ACEEDA2DA3) {
        if(isDefined(_id_5607F7513EB816A2.trigger) && _id_5607F7513EB816A2 != flag && bot_allow_to_capture_flag(_id_5607F7513EB816A2)) {
          if(distancesquared(self.origin, _id_5607F7513EB816A2.trigger.origin) < _id_9A86288B6E984514)
            _id_6E24445AC4C031BF = 1;
        }
      }

      if(isDefined(flag.trigger) && self istouching(flag.trigger) && flag.userate <= 0) {
        if(self bothasscriptgoal()) {
          _id_4CBD8AE83804749C = self botgetscriptgoal();
          script_goal_radius = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, _id_4CBD8AE83804749C) < squared(script_goal_radius)) {
            _id_B6F1DEB8E946E67C = self getnearestnode();

            if(isDefined(_id_B6F1DEB8E946E67C)) {
              _id_1AAF2917E47371A3 = undefined;

              foreach(_id_72F9A5CA05BB7422 in flag.nodes) {
                if(!nodesvisible(_id_72F9A5CA05BB7422, _id_B6F1DEB8E946E67C, 1)) {
                  _id_1AAF2917E47371A3 = _id_72F9A5CA05BB7422.origin;
                  break;
                }
              }

              if(isDefined(_id_1AAF2917E47371A3)) {
                self.defense_investigate_specific_point = _id_1AAF2917E47371A3;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(_id_A78B2B0EBF2F977F != self.team) {
        if(!bot_dom_debug_should_protect_all())
          _id_6E24445AC4C031BF = 1;
      } else if(_id_0877F0C734271995 == 1 && _id_F2B47E412166C272 > 1)
        _id_6E24445AC4C031BF = 1;
    }

    _id_F2B47E412166C272 = _id_0877F0C734271995;

    if(_id_6E24445AC4C031BF) {
      self.force_new_goal = 1;
      _id_278595174C3B888B = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    result = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    _id_A862627B64E75A21 = isDefined(result) && result == "timeout";

    if(!_id_A862627B64E75A21) {
      wait_time = max((3 - self.strategy_level) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(wait_time);
    }
  }
}

bot_dom_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center)
    return 1.0;

  if(!isDefined(self.current_flag))
    return 1.0;

  _id_F43FB0E14CCFB9E1 = 0;
  _id_A7FF1FE77B4291E1 = get_flag_label(self.current_flag);
  _id_0F54364C67CFABC7 = get_ally_flags(self.team);

  foreach(_id_61733D6E2CBEE46E in _id_0F54364C67CFABC7) {
    if(_id_61733D6E2CBEE46E != self.current_flag) {
      _id_F43FB0E14CCFB9E1 = node scripts\mp\bots\bots_util::node_is_on_path_from_labels(_id_A7FF1FE77B4291E1, get_flag_label(_id_61733D6E2CBEE46E));

      if(_id_F43FB0E14CCFB9E1) {
        _id_8CB7CD2C3C2F7779 = get_other_flag(self.current_flag, _id_61733D6E2CBEE46E);
        _id_08EB11236AC48CE3 = _id_8CB7CD2C3C2F7779 _id_2DC3A143158CEC7C::getflagteam();

        if(_id_08EB11236AC48CE3 != self.team) {
          if(node scripts\mp\bots\bots_util::node_is_on_path_from_labels(_id_A7FF1FE77B4291E1, get_flag_label(_id_8CB7CD2C3C2F7779)))
            _id_F43FB0E14CCFB9E1 = 0;
        }
      }
    }
  }

  if(_id_F43FB0E14CCFB9E1)
    return 0.2;

  return 1.0;
}

get_flag_label(flag) {
  _id_043EF966DEAAD58A = "";

  if(isDefined(flag.teleport_zone))
    _id_043EF966DEAAD58A = _id_043EF966DEAAD58A + (flag.teleport_zone + "_");

  _id_043EF966DEAAD58A = _id_043EF966DEAAD58A + ("flag" + flag.objectivekey);
  return _id_043EF966DEAAD58A;
}

get_other_flag(flag1, _id_5228090A1CF6F05B) {
  foreach(objective in level.objectives) {
    if(objective != flag1 && objective != _id_5228090A1CF6F05B)
      return objective;
  }
}

get_specific_flag_by_letter(_id_607390FDA882B564) {
  _id_043EF966DEAAD58A = "_" + tolower(_id_607390FDA882B564);
  return get_specific_flag_by_label(_id_043EF966DEAAD58A);
}

get_specific_flag_by_label(_id_043EF966DEAAD58A) {
  foreach(objective in level.objectives) {
    if(objective.objectivekey == _id_043EF966DEAAD58A)
      return objective;
  }
}

get_closest_flag(origin) {
  _id_345442A441F6669F = undefined;
  _id_D7E79A673C0D8D21 = undefined;

  foreach(objective in level.objectives) {
    _id_4EA84B05D2E463A4 = distancesquared(objective.trigger.origin, origin);

    if(!isDefined(_id_D7E79A673C0D8D21) || _id_4EA84B05D2E463A4 < _id_D7E79A673C0D8D21) {
      _id_345442A441F6669F = objective;
      _id_D7E79A673C0D8D21 = _id_4EA84B05D2E463A4;
    }
  }

  return _id_345442A441F6669F;
}

get_num_allies_capturing_flag(flag, _id_38C7DA45D31E930E) {
  _id_6FD52C0A557B6A40 = 0;
  _id_3498229C5A4F8731 = get_flag_capture_radius();

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(!isDefined(_id_5ECABDFE40A96663.team)) {
      continue;
    }
    if(_id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663)) {
      if(isai(_id_5ECABDFE40A96663)) {
        if(_id_5ECABDFE40A96663 bot_is_capturing_flag(flag))
          _id_6FD52C0A557B6A40++;

        continue;
      }

      if(!isDefined(_id_38C7DA45D31E930E) || !_id_38C7DA45D31E930E) {
        if(_id_5ECABDFE40A96663 istouching(flag))
          _id_6FD52C0A557B6A40++;
      }
    }
  }

  return _id_6FD52C0A557B6A40;
}

bot_is_capturing_flag(flag) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return bot_target_is_flag(flag);
}

bot_is_protecting_flag(flag) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return bot_target_is_flag(flag);
}

bot_target_is_flag(flag) {
  return self.current_flag == flag;
}

get_num_ally_flags(team) {
  count = 0;

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_2DC3A143158CEC7C::getflagteam();

    if(_id_ECEBC47387DC7C2D == team)
      count++;
  }

  return count;
}

get_enemy_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_2DC3A143158CEC7C::getflagteam();

    if(_id_ECEBC47387DC7C2D == scripts\engine\utility::get_enemy_team(team))
      flags = scripts\engine\utility::array_add(flags, objective);
  }

  return flags;
}

get_ally_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_2DC3A143158CEC7C::getflagteam();

    if(_id_ECEBC47387DC7C2D == team)
      flags = scripts\engine\utility::array_add(flags, objective);
  }

  return flags;
}

bot_should_defend_flag(_id_4A39DA8BBB554C2C, _id_2D7337CDF8F706C0) {
  _id_26D0FE30296086C4 = get_max_num_defenders_wanted_per_flag(_id_2D7337CDF8F706C0);
  _id_89D5717BF18A21ED = get_players_defending_flag(_id_4A39DA8BBB554C2C);
  return _id_89D5717BF18A21ED.size < _id_26D0FE30296086C4;
}

get_max_num_defenders_wanted_per_flag(_id_2D7337CDF8F706C0) {
  _id_6ACE8681F94CDC7C = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(_id_2D7337CDF8F706C0 == 1)
    return ceil(_id_6ACE8681F94CDC7C / 6);
  else
    return ceil(_id_6ACE8681F94CDC7C / 3);
}

get_players_defending_flag(_id_4A39DA8BBB554C2C) {
  _id_20B890E2DD5949FA = get_flag_protect_radius();
  _id_017C8F3BCDA25F80 = [];

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(!isDefined(_id_5ECABDFE40A96663.team)) {
      continue;
    }
    if(_id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663)) {
      if(isai(_id_5ECABDFE40A96663)) {
        if(_id_5ECABDFE40A96663 bot_is_protecting_flag(_id_4A39DA8BBB554C2C))
          _id_017C8F3BCDA25F80 = scripts\engine\utility::array_add(_id_017C8F3BCDA25F80, _id_5ECABDFE40A96663);

        continue;
      }

      _id_C3D8550CA7E24E40 = gettime() - _id_4A39DA8BBB554C2C.last_time_secured[self.team];

      if(_id_C3D8550CA7E24E40 < 10000) {
        continue;
      }
      if(isDefined(_id_4A39DA8BBB554C2C.trigger) && distancesquared(_id_4A39DA8BBB554C2C.trigger.origin, _id_5ECABDFE40A96663.origin) < _id_20B890E2DD5949FA * _id_20B890E2DD5949FA)
        _id_017C8F3BCDA25F80 = scripts\engine\utility::array_add(_id_017C8F3BCDA25F80, _id_5ECABDFE40A96663);
    }
  }

  return _id_017C8F3BCDA25F80;
}

bot_dom_debug_should_capture_all() {
  return 0;
}

bot_dom_debug_should_protect_all() {
  return 0;
}