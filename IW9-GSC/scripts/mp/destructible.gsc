/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructible.gsc
***********************************************/

init() {}

script_model_anims() {}

#using_animtree("script_model");

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player.player_rig = spawn("script_model", player.origin);
  player.player_rig setModel(_id_486DB5FA512A3B6B);
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  player watch_remove_rig();
  remove_player_rig(player);
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  _id_5BF3E22BDB650432 = player getdroptofloorposition(player.origin);

  if(isDefined(_id_5BF3E22BDB650432))
    player setOrigin(_id_5BF3E22BDB650432);
  else
    player setOrigin(player.origin + (0, 0, 100));

  player.player_rig delete();
  player.player_rig = undefined;
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}

add_destructible_array(value, type) {
  array = getEntArray(value, type);

  foreach(ent in array) {
    destructible = spawnStruct();
    add_destructible(destructible, ent);
    destructible assigninteractteam(level.teamnamelist);

    if(!isDefined(level.destructibles[value]))
      level.destructibles[value] = [];

    level.destructibles[value][level.destructibles[value].size] = destructible;
    destructible process_action("init");
  }
}

add_destructible(struct, ent) {
  if(!isDefined(struct.ents))
    struct.ents = [];

  struct read_properties(ent);
  struct read_actions(ent);
  struct.ents[struct.ents.size] = ent;
  ent.parent = struct;

  if(isDefined(ent.target)) {
    targets = getEntArray(ent.target, "targetname");

    if(isDefined(targets) && targets.size > 0) {
      foreach(target in targets)
      add_destructible(struct, target);
    }
  }
}

read_properties(ent) {
  if(!isDefined(ent)) {
    return;
  }
  switch (ent.classname) {
    case "trigger_use_touch":
      self.use_trigger = ent;
      break;
    case "script_origin":
      label = ent.script_label;

      if(isDefined(label)) {
        switch (label) {
          case "usePrompt_front":
            if(!isDefined(self.useobjects))
              self.useobjects = [];

            self.useobjects["front"] = setup_bomb_object(ent.origin);
            self.useobjects["front"].scenenodekey = "front";
            break;
          case "sceneNode_front":
            if(!isDefined(self.scenenodes))
              self.scenenodes = [];

            self.scenenodes["front"] = ent;
            break;
          case "usePrompt_back":
            if(!isDefined(self.useobjects))
              self.useobjects = [];

            self.useobjects["back"] = setup_bomb_object(ent.origin);
            self.useobjects["back"].scenenodekey = "back";
            break;
          case "sceneNode_back":
            if(!isDefined(self.scenenodes))
              self.scenenodes = [];

            self.scenenodes["back"] = ent;
            break;
        }
      }

      break;
    case "scriptable":
      self.scriptable = ent;
      break;
  }
}

read_actions(ent) {
  if(!isDefined(ent.script_noteworthy)) {
    return;
  }
  types = strtok(ent.script_noteworthy, ",");

  foreach(type in types) {
    actions = strtok(type, "|");

    if(!isDefined(actions)) {
      return;
    }
    if(actions.size < 2) {
      return;
    }
    type = actions[0];

    if(!isDefined(ent.actions))
      ent.actions = [];

    if(!isDefined(ent.actions[type]))
      ent.actions[type] = [];

    for(index = 1; index < actions.size; index++)
      ent.actions[type][ent.actions[type].size] = actions[index];
  }
}

waittime_process_action(type, time) {
  level endon("game_ended");
  wait(time);
  process_action(type);
}

waitmsg_process_action(waitmsg) {
  level endon("game_ended");
  self waittill(waitmsg);
  process_action(waitmsg);
}

process_action(type) {
  if(!isDefined(self.ents)) {
    return;
  }
  foreach(ent in self.ents) {
    if(isDefined(ent.actions) && isDefined(ent.actions[type])) {
      foreach(action in ent.actions[type])
      ent actionmap(action);
    }
  }

  self.state = type;
}

actionmap(action) {
  switch (action) {
    case "show":
      self show();
      break;
    case "hide":
      self hide();
      break;
    case "solid":
      self solid();
      break;
    case "notsolid":
      self notsolid();
      break;
    case "disconnectpaths":
      self disconnectPaths();
      break;
    case "connectpaths":
      self connectpaths();
      break;
    case "bomb_explosion":
      _id_B085E4DE6D22E286 = self.origin;
      _id_CB89120314447D62 = self.angles;
      _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["breach_explode"], _id_B085E4DE6D22E286, anglesToForward(_id_CB89120314447D62) * -1.0, (0, 0, 1));
      triggerfx(_id_EFDFC6EBE7A152C5);
      physicsexplosionsphere(_id_B085E4DE6D22E286, 200, 100, 3);
      playrumbleonposition("grenade_rumble", _id_B085E4DE6D22E286);
      earthquake(0.5, 1.0, _id_B085E4DE6D22E286, 1500);
      self.parent.plantedbomb setscriptablepartstate("bomb", "destroy");
      break;
  }
}

setup_bomb_object(position) {
  useobject = scripts\mp\gameobjects::createhintobject(position, "HINT_BUTTON", "hud_icon_c4_plant", &"MP/BREACH", undefined, undefined, undefined, 800, 120, 72, 120);

  if(!isDefined(level.breachusetriggers))
    level.breachusetriggers = [];

  level.breachusetriggers[level.breachusetriggers.size] = useobject;
  self.defused = 0;
  thread usetriggerthink(useobject);
  return useobject;
}

bomb_planted_think(scenenodekey, player) {
  _id_09D423F29A3F3FFE = player.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(_id_09D423F29A3F3FFE);

  if(!self.defused) {
    process_action("destroyed");
    _id_B085E4DE6D22E286 = self.useobjects[scenenodekey].origin;

    if(isDefined(self.scriptable)) {
      if(scenenodekey == "front")
        self.scriptable setscriptablepartstate("base", "destroyFront");
      else
        self.scriptable setscriptablepartstate("base", "destroyBack");
    } else {
      _id_CB89120314447D62 = self.useobjects[scenenodekey].angles;
      _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["breach_explode"], _id_B085E4DE6D22E286, anglesToForward(_id_CB89120314447D62) * -1.0, (0, 0, 1));
      triggerfx(_id_EFDFC6EBE7A152C5);
      self.plantedbomb setscriptablepartstate("bomb", "destroy");
    }

    physicsexplosionsphere(_id_B085E4DE6D22E286, 200, 100, 3);
    playrumbleonposition("grenade_rumble", _id_B085E4DE6D22E286);
    earthquake(0.5, 1.0, _id_B085E4DE6D22E286, 1500);

    foreach(_id_F90358454413407F in self.useobjects) {
      _id_F90358454413407F delete();
      level.breachusetriggers = scripts\engine\utility::array_remove(level.breachusetriggers, _id_F90358454413407F);
    }

    wait 0.1;

    if(isDefined(player))
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, player, "MOD_EXPLOSIVE", "bomb_site_mp");
    else
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

    if(isDefined(level.hostages))
      thread playhostagehelp(self.plantedbomb.origin);
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  self.plantedkey = undefined;
  setomnvar("ui_ingame_timer_" + self.breachindex, 0);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, undefined);

  if(self.defused) {
    foreach(_id_F90358454413407F in self.useobjects)
    _id_F90358454413407F setHintString(&"MP/BREACH");

    assigninteractteam(level.teamnamelist);
    process_action("init");
  }
}

playhostagehelp(origin) {
  wait 1;

  if(distance2d(level.hostages[0].origin, origin) < 500)
    level.hostages[0] playSound("dx_mpb_us3_hvt_up");
}

bomb_fuse_think(team) {
  self endon("defused");

  foreach(_id_F90358454413407F in self.useobjects)
  _id_F90358454413407F setHintString(&"MP/BREACH_DEFUSE");

  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  self.timerobject makeusable();
  assigninteractteam(scripts\mp\utility\teams::getenemyteams(team));
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 5000);
  setomnvar("ui_ingame_timer_" + self.breachindex, _id_F28399727742EB23);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(!self.defused && _id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 1500) {
      if(_id_C301D652D9A73075 <= 250)
        self.plantedbomb playSound("breach_warning_beep_05");
      else if(_id_C301D652D9A73075 < 500)
        self.plantedbomb playSound("breach_warning_beep_04");
      else if(_id_C301D652D9A73075 < 1500)
        self.plantedbomb playSound("breach_warning_beep_03");
      else
        self.plantedbomb playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1.0;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }
}

usetriggerthink(trigger) {
  for(;;) {
    trigger waittill("trigger", player);

    if(!scripts\engine\utility::array_contains(self.interactteams, player.team)) {
      continue;
    }
    if(player scripts\mp\utility\weapon::grenadeinpullback())
      return 0;

    if(player meleeButtonPressed())
      return 0;

    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!isDefined(self.plantedbomb)) {
      plantbreachc4(trigger, player);
      continue;
    }

    defusec4(player);
  }
}

plantbreachc4(trigger, player) {
  thread watchplayerdeath(player);
  player.linktoent = player scripts\engine\utility::spawn_tag_origin();
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  player.linktoent moveTo(self.scenenodes[trigger.scenenodekey].origin, 0.25, 0.1, 0.1);
  player.linktoent rotateTo(self.scenenodes[trigger.scenenodekey].angles, 0.25, 0.1, 0.1);
  player setstance("stand");

  if(!player givegunless()) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    return 0;
  }

  if(istrue(self.cancelplant))
    return 0;

  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(self.scenenodes[trigger.scenenodekey].origin);
  player setplayerangles(self.scenenodes[trigger.scenenodekey].angles);

  foreach(_id_F90358454413407F in self.useobjects)
  _id_F90358454413407F hide();

  faction = scripts\engine\utility::ter_op(player.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard")
    faction = scripts\engine\utility::ter_op(player.team == "allies", "ukp1", "abp1");

  player queuedialogforplayer("dx_mpp_" + faction + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(player, "planter");
  player thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "plant");
  _id_F9FAEFD9721CAE01 = spawn("script_model", self.scenenodes[trigger.scenenodekey].origin);
  _id_F9FAEFD9721CAE01 setModel("offhand_wm_c4");
  _id_F9FAEFD9721CAE01.animname = "c4";
  _id_F9FAEFD9721CAE01 useanimtree(#animtree);
  self.plantedbomb = _id_F9FAEFD9721CAE01;
  self.plantedkey = trigger.scenenodekey;
  self.scenenodes[trigger.scenenodekey] thread scripts\common\anim::anim_single_solo(_id_F9FAEFD9721CAE01, "plant");
  animlength = getanimlength(level.scr_anim["planter"]["plant"]);
  _id_84D825D7E4A24FDE = 0.5;
  wait(animlength - _id_84D825D7E4A24FDE);

  if(istrue(self.cancelplant))
    return 0;

  thread bomb_planted_think(trigger.scenenodekey, player);
  givebreachscore(player);
  wait(_id_84D825D7E4A24FDE - 0.1);
  player thread takegunless();
  remove_player_rig(player);
  process_action("onuse");
  self notify("breach_complete");
  return 1;
}

watchplayerdeath(player) {
  self endon("breach_complete");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
      foreach(_id_F90358454413407F in self.useobjects)
      _id_F90358454413407F show();

      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
        self.plantedkey = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

allowplayertobreach(player) {
  if(isDefined(level.breachusetriggers)) {
    foreach(trigger in level.breachusetriggers)
    trigger enableplayeruse(player);
  }
}

disallowplayertobreach(player) {
  if(isDefined(level.breachusetriggers)) {
    foreach(trigger in level.breachusetriggers)
    trigger disableplayeruse(player);
  }
}

defusec4(player) {
  self.defused = 1;
  self notify("defused");
  givedefusescore(player);
}

onplayerjoinedteam(player) {
  foreach(array in level.destructibles) {
    foreach(_id_AC0E564AC96A9D0F in array)
    _id_AC0E564AC96A9D0F applyinteractteam(player);
  }
}

assigninteractteam(teams) {
  self.interactteams = teams;

  foreach(player in level.players)
  applyinteractteam(player);
}

applyinteractteam(player) {
  if(self.state == "destroyed") {
    return;
  }
  if(!isDefined(self.useobjects)) {
    return;
  }
  if(scripts\engine\utility::array_contains(self.interactteams, player.team)) {
    if(isDefined(self.plantedbomb)) {
      self.timerobject hidefromplayer(player);

      foreach(key, _id_F90358454413407F in self.useobjects) {
        if(key == self.plantedkey) {
          _id_F90358454413407F setuseholdduration("duration_medium");
          _id_F90358454413407F enableplayeruse(player);
          _id_F90358454413407F showtoplayer(player);
          continue;
        }

        _id_F90358454413407F disableplayeruse(player);
        _id_F90358454413407F hidefromplayer(player);
      }

      return;
    }

    foreach(key, _id_F90358454413407F in self.useobjects) {
      _id_F90358454413407F setuseholdduration("duration_short");
      _id_F90358454413407F enableplayeruse(player);
      _id_F90358454413407F showtoplayer(player);
    }

    return;
  } else {
    if(isDefined(self.plantedbomb))
      self.timerobject showtoplayer(player);

    foreach(_id_F90358454413407F in self.useobjects) {
      _id_F90358454413407F disableplayeruse(player);
      _id_F90358454413407F hidefromplayer(player);
    }
  }
}

givebreachscore(player) {
  event = "stat_C83F9DD7A46C93D8";
  points = scripts\mp\rank::getscoreinfovalue(event);
  player thread scripts\mp\rank::giverankxp(event, points);
  player thread scripts\mp\rank::scoreeventpopup(event);
}

givedefusescore(player) {
  event = "stat_44F52653C35F1C07";
  points = scripts\mp\rank::getscoreinfovalue(event);
  player thread scripts\mp\rank::giverankxp(event, points);
  player thread scripts\mp\rank::scoreeventpopup(event);
}

givegunless() {
  self endon("death_or_disconnect");
  gunless = makeweapon("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);

  if(success) {
    self.gunnlessweapon = gunless;
    _id_3B64EB40368C1450::set("gunless", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("gunless", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("gunless", "melee", 0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(gunless);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return success;
}

takegunless() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self.takinggunless = 1;

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gunless");
}

rockable_cars_init() {
  waitframe();
  scripts\common\rockable_vehicles::rockable_cars_init();
  level thread rockable_cars_watch_players();
}

rockable_cars_watch_players() {
  if(!isDefined(level.rockablecars) || !isDefined(level.rockablecars.cars) || level.rockablecars.cars.size == 0) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      if(player ismantling() || !player isonground()) {
        continue;
      }
      car = player getmovingplatformparent();

      if(!isDefined(car) || !istrue(car._id_743EBAB8013B6CDE)) {
        continue;
      }
      _id_340D59422336E85A = player.origin - car.toppoint;

      if(vectordot(_id_340D59422336E85A, car.up) < 0) {
        continue;
      }
      _id_68E32EDB50F84A85 = vectordot(_id_340D59422336E85A, car.forward);
      _id_4261B9974DEE3BDB = abs(_id_68E32EDB50F84A85);
      _id_60BC4CE4BC1694B7 = _id_4261B9974DEE3BDB / car.halflength;

      if(_id_60BC4CE4BC1694B7 > 1) {
        continue;
      }
      _id_6B16895685C64534 = vectordot(_id_340D59422336E85A, car.right);
      _id_92BFBB64D47DFEEC = abs(_id_6B16895685C64534);
      _id_1D2F8DBF170357C7 = _id_92BFBB64D47DFEEC / car.halfwidth;

      if(_id_1D2F8DBF170357C7 > 1) {
        continue;
      }
      _id_4D5C2819CBF3D194 = scripts\engine\utility::ter_op(_id_68E32EDB50F84A85 >= 0, "front", "back");
      _id_8169B248BE4D2462 = scripts\engine\utility::ter_op(_id_6B16895685C64534 >= 0, "right", "left");
      _id_B6B4451B4FD94B27 = _id_4D5C2819CBF3D194 + "_" + _id_8169B248BE4D2462;

      if(isDefined(player._id_4005D3C144ACD854) && player._id_4005D3C144ACD854 == _id_B6B4451B4FD94B27) {
        continue;
      }
      id = player getentitynumber();

      if(!isDefined(car.players[id]))
        car rockable_car_add_player(player);

      car rockable_car_rock(player, _id_60BC4CE4BC1694B7, _id_1D2F8DBF170357C7, _id_68E32EDB50F84A85, _id_6B16895685C64534, _id_B6B4451B4FD94B27);
    }

    foreach(car in level.rockablecars.cars) {
      if(!isDefined(car)) {
        continue;
      }
      foreach(id, player in car.players) {
        _id_D360B01D9A8CA0C3 = gettime() - car.touchtimes[id];

        if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
          car rockable_car_remove_player(player, id, undefined, 0);
          continue;
        }

        if(player ismantling() || !player isonground()) {
          car rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, 1);
          continue;
        }

        _id_088CCE618C00D03C = player getmovingplatformparent();

        if(!isDefined(_id_088CCE618C00D03C) || _id_088CCE618C00D03C != car) {
          car rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, 1);
          continue;
        }

        _id_340D59422336E85A = player.origin - car.toppoint;

        if(vectordot(_id_340D59422336E85A, car.up) < 0) {
          car rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, 1);
          continue;
        }

        _id_68E32EDB50F84A85 = vectordot(_id_340D59422336E85A, car.forward);
        _id_4261B9974DEE3BDB = abs(_id_68E32EDB50F84A85);
        _id_60BC4CE4BC1694B7 = _id_4261B9974DEE3BDB / car.halflength;

        if(_id_60BC4CE4BC1694B7 > 1) {
          car rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, 1);
          continue;
        }

        _id_6B16895685C64534 = vectordot(_id_340D59422336E85A, car.right);
        _id_92BFBB64D47DFEEC = abs(_id_6B16895685C64534);
        _id_1D2F8DBF170357C7 = _id_92BFBB64D47DFEEC / car.halfwidth;

        if(_id_1D2F8DBF170357C7 > 1) {
          car rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, 1);
          continue;
        }

        car.touchtimes[id] = gettime();
      }
    }

    waitframe();
  }
}

rockable_car_add_player(player) {
  id = player getentitynumber();
  self.players[id] = player;
  self.touchtimes[id] = gettime();
}

rockable_car_remove_player(player, id, _id_D360B01D9A8CA0C3, _id_BD8DBAF4DD9CA95D) {
  if(_id_BD8DBAF4DD9CA95D) {
    if(isDefined(_id_D360B01D9A8CA0C3) && _id_D360B01D9A8CA0C3 >= 200) {
      self.players[id] = undefined;
      self.touchtimes[id] = undefined;
      self.rocktimes[id] = undefined;

      if(isDefined(player))
        player._id_4005D3C144ACD854 = undefined;
    }
  } else {
    self.players[id] = undefined;
    self.touchtimes[id] = undefined;
    self.rocktimes[id] = undefined;

    if(isDefined(player))
      player._id_4005D3C144ACD854 = undefined;
  }
}

rockable_car_rock(player, _id_60BC4CE4BC1694B7, _id_1D2F8DBF170357C7, _id_68E32EDB50F84A85, _id_6B16895685C64534, _id_B6B4451B4FD94B27) {
  if(_id_60BC4CE4BC1694B7 > 0.4 && _id_1D2F8DBF170357C7 > 0) {
    self setscriptablepartstate("Anim_PlayerStandRock", _id_B6B4451B4FD94B27, 0);
    id = player getentitynumber();
    self.rocktimes[id] = gettime();
    player._id_4005D3C144ACD854 = _id_B6B4451B4FD94B27;
  }
}