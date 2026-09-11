/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructible.gsc
***********************************************/

function init() {}

function script_model_anims() {}

#using_animtree("script_model");

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0.player_rig = spawn("script_model", var_0.origin);
  var_0.player_rig setModel(var_2);
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}

function add_destructible_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    add_destructible(var_5, var_4);
    assigninteractteam(var_5, level.teamnamelist);

    if(!isDefined(level.destructibles[var_0])) {
      level.destructibles[var_0] = [];
    }

    level.destructibles[var_0][level.destructibles[var_0].size] = var_5;
    process_action(var_5, "init");
  }
}

function add_destructible(var_0, var_1) {
  if(!isDefined(var_0.ents)) {
    var_0.ents = [];
  }

  read_properties(var_0, var_1);
  read_actions(var_0, var_1);
  var_0.ents[var_0.ents.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        add_destructible(var_0, var_4);
      }

      return;
    }

    return;
  }
}

function read_properties(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0.classname) {
    case "trigger_use_touch":
      self.use_trigger = var_0;
      break;
    case "script_origin":
      var_1 = var_0.script_label;

      if(isDefined(var_1)) {
        switch (var_1) {
          case "usePrompt_front":
            if(!isDefined(self.useobjects)) {
              self.useobjects = [];
            }

            self.useobjects["front"] = setup_bomb_object(var_0.origin);
            self.useobjects["front"].scenenodekey = "front";
            break;
          case "sceneNode_front":
            if(!isDefined(self.scenenodes)) {
              self.scenenodes = [];
            }

            self.scenenodes["front"] = var_0;
            break;
          case "usePrompt_back":
            if(!isDefined(self.useobjects)) {
              self.useobjects = [];
            }

            self.useobjects["back"] = setup_bomb_object(var_0.origin);
            self.useobjects["back"].scenenodekey = "back";
            break;
          case "sceneNode_back":
            if(!isDefined(self.scenenodes)) {
              self.scenenodes = [];
            }

            self.scenenodes["back"] = var_0;
            break;
        }
      }

      break;
    case "scriptable":
      self.scriptable = var_0;
      break;
  }
}

function read_actions(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }

  var_1 = strtok(var_0.script_noteworthy, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "|");

    if(!isDefined(var_4)) {
      return;
    }

    if(var_4.size < 2) {
      return;
    }

    var_3 = var_4[0];

    if(!isDefined(var_0.actions)) {
      var_0.actions = [];
    }

    if(!isDefined(var_0.actions[var_3])) {
      var_0.actions[var_3] = [];
    }

    for(var_5 = 1; var_5 < var_4.size; var_5++) {
      var_0.actions[var_3][var_0.actions[var_3].size] = var_4[var_5];
    }
  }
}

function waittime_process_action(var_0, var_1) {
  level endon("game_ended");
  wait var_1;
  process_action(var_0);
}

function waitmsg_process_action(var_0) {
  level endon("game_ended");
  self waittill(var_0);
  process_action(var_0);
}

function process_action(var_0) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var_2 in self.ents) {
    if(isDefined(var_2.actions) && isDefined(var_2.actions[var_0])) {
      foreach(var_4 in var_2.actions[var_0]) {
        actionmap(var_2, var_4);
      }
    }
  }

  self.state = var_0;
}

function actionmap(var_0) {
  switch (var_0) {
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
      var_1 = self.origin;
      var_2 = self.angles;
      var_3 = spawnfx(level._effect["breach_explode"], var_1, anglesToForward(var_2) * -1, (0, 0, 1));
      triggerfx(var_3);
      physicsexplosionsphere(var_1, 200, 100, 3);
      playrumbleonposition("grenade_rumble", var_1);
      earthquake(0.5, 1, var_1, 1500);
      self.parent.plantedbomb setscriptablepartstate("bomb", "destroy");
      break;
  }
}

function setup_bomb_object(var_0) {
  var_1 = scripts\mp\gameobjects::createhintobject(var_0, "HINT_BUTTON", "hud_icon_c4_plant", &"MP/BREACH", undefined, undefined, undefined, 800, 120, 72, 120);

  if(!isDefined(level.breachusetriggers)) {
    level.breachusetriggers = [];
  }

  level.breachusetriggers[level.breachusetriggers.size] = var_1;
  self.defused = 0;
  thread usetriggerthink(var_1);
  return var_1;
}

function bomb_planted_think(var_0, var_1) {
  var_2 = var_1.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var_2);

  if(!self.defused) {
    process_action("destroyed");
    var_3 = self.useobjects[var_0].origin;

    if(isDefined(self.scriptable)) {
      if(var_0 == "front") {
        self.scriptable setscriptablepartstate("base", "destroyFront");
      } else {
        self.scriptable setscriptablepartstate("base", "destroyBack");
      }
    } else {
      var_4 = self.useobjects[var_0].angles;
      var_5 = spawnfx(level._effect["breach_explode"], var_3, anglesToForward(var_4) * -1, (0, 0, 1));
      triggerfx(var_5);
      self.plantedbomb setscriptablepartstate("bomb", "destroy");
    }

    physicsexplosionsphere(var_3, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var_3);
    earthquake(0.5, 1, var_3, 1500);

    foreach(var_7 in self.useobjects) {
      var_7 delete();
      level.breachusetriggers = scripts\engine\utility::array_remove(level.breachusetriggers, var_7);
    }

    wait 0.1;

    if(isDefined(var_1)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    if(isDefined(level.hostages)) {
      thread playhostagehelp(self.plantedbomb.origin);
    }
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  self.plantedkey = undefined;
  setomnvar("ui_ingame_timer_" + self.breachindex, 0);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, undefined);

  if(self.defused) {
    foreach(var_7 in self.useobjects) {
      var_7 setHintString(&"MP/BREACH");
    }

    assigninteractteam(level.teamnamelist);
    process_action("init");
    return;
  }
}

function playhostagehelp(var_0) {
  wait 1;

  if(distance2d(level.hostages[0].origin, var_0) < 500) {
    level.hostages[0] playSound("dx_mpb_us3_hvt_up");
    return;
  }
}

function bomb_fuse_think(var_0) {
  self endon("defused");

  foreach(var_2 in self.useobjects) {
    var_2 setHintString(&"MP/BREACH_DEFUSE");
  }

  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  self.timerobject makeusable();
  assigninteractteam(scripts\mp\utility\teams::getenemyteams(var_0));
  var_4 = gettime();
  var_5 = int(var_4 + 5000);
  setomnvar("ui_ingame_timer_" + self.breachindex, var_5);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  var_6 = var_5 - var_4;

  while(!self.defused && var_6 > 0) {
    var_4 = gettime();
    var_6 = var_5 - var_4;

    if(var_6 < 1500) {
      if(var_6 <= 250) {
        self.plantedbomb playSound("breach_warning_beep_05");
      } else if(var_6 < 500) {
        self.plantedbomb playSound("breach_warning_beep_04");
      } else if(var_6 < 1500) {
        self.plantedbomb playSound("breach_warning_beep_03");
      } else {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_6 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1;
    }

    if(var_6 < 0) {
      break;
    }
  }
}

function usetriggerthink(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!scripts\engine\utility::array_contains(self.interactteams, var_1.team)) {
      continue;
    }

    if(var_1 scripts\mp\utility\weapon::grenadeinpullback()) {
      return 0;
    }

    if(var_1 meleeButtonPressed()) {
      return 0;
    }

    if(var_1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!isDefined(self.plantedbomb)) {
      plantbreachc4(var_0, var_1);
      continue;
    }

    defusec4(var_1);
  }
}

#using_animtree("");

function plantbreachc4(var_0, var_1) {
  thread watchplayerdeath(var_1);
  var_1.linktoent = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1.linktoent moveTo(self.scenenodes[var_0.scenenodekey].origin, 0.25, 0.1, 0.1);
  var_1.linktoent rotateTo(self.scenenodes[var_0.scenenodekey].angles, 0.25, 0.1, 0.1);
  var_1 setstance("stand");

  if(!givegunless(var_1)) {
    var_1 unlink();
    var_1.linktoent delete();
    var_1.linktoent = undefined;
    return false;
  }

  if(istrue(self.cancelplant)) {
    return false;
  }

  var_1 unlink();
  var_1.linktoent delete();
  var_1.linktoent = undefined;
  var_1 setOrigin(self.scenenodes[var_0.scenenodekey].origin);
  var_1 setplayerangles(self.scenenodes[var_0.scenenodekey].angles);

  foreach(var_3 in self.useobjects) {
    var_3 hide();
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, "c4_plant");
  var_5 = scripts\engine\utility::ter_op(var_1.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var_5 = scripts\engine\utility::ter_op(var_1.team == "allies", "ukp1", "abp1");
  }

  var_1 queuedialogforplayer("dx_mpp_" + var_5 + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(var_1, "planter");
  var_1 thread scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, "plant");
  var_6 = spawn("script_model", self.scenenodes[var_0.scenenodekey].origin);
  var_6 setModel("offhand_wm_c4");
  var_6.animname = "c4";
  var_6 useanimtree(#animtree);
  self.plantedbomb = var_6;
  self.plantedkey = var_0.scenenodekey;
  self.scenenodes[var_0.scenenodekey] thread scripts\common\anim::anim_single_solo(var_6, "plant");
  var_7 = getanimlength(level.scr_anim["planter"]["plant"]);
  var_8 = 0.5;
  wait var_7 - var_8;

  if(istrue(self.cancelplant)) {
    return false;
  }

  thread bomb_planted_think(var_0.scenenodekey, var_1);
  givebreachscore(var_1);
  wait var_8 - 0.1;
  thread takegunless();
  remove_player_rig(var_1);
  process_action("onuse");
  self notify("breach_complete");
  return true;
}

function watchplayerdeath(var_0) {
  self endon("breach_complete");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      foreach(var_2 in self.useobjects) {
        var_2 show();
      }

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

function allowplayertobreach(var_0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var_2 in level.breachusetriggers) {
      var_2 enableplayeruse(var_0);
    }

    return;
  }
}

function disallowplayertobreach(var_0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var_2 in level.breachusetriggers) {
      var_2 disableplayeruse(var_0);
    }

    return;
  }
}

function defusec4(var_0) {
  self.defused = 1;
  self notify("defused");
  givedefusescore(var_0);
}

function onplayerjoinedteam(var_0) {
  foreach(var_2 in level.destructibles) {
    foreach(var_4 in var_2) {
      applyinteractteam(var_4, var_0);
    }
  }
}

function assigninteractteam(var_0) {
  self.interactteams = var_0;

  foreach(var_2 in level.players) {
    applyinteractteam(var_2);
  }
}

function applyinteractteam(var_0) {
  if(self.state == "destroyed") {
    return;
  }

  if(!isDefined(self.useobjects)) {
    return;
  }

  if(scripts\engine\utility::array_contains(self.interactteams, var_0.team)) {
    jumpiffalse(isDefined(self.plantedbomb)) LOC_0000009d;
    self.timerobject hidefromplayer(var_0);

    foreach(var_3, var_2 in self.useobjects) {
      if(var_3 == self.plantedkey) {
        var_2 setuseholdduration("duration_medium");
        var_2 enableplayeruse(var_0);
        var_2 showtoplayer(var_0);
        continue;
      }

      var_2 disableplayeruse(var_0);
      var_2 hidefromplayer(var_0);
    }

    return;
  }

  jumpiffalse(isDefined(self.plantedbomb)) LOC_000000f0;
  self.timerobject showtoplayer(var_3);

  foreach(var_2 in self.useobjects) {
    var_2 disableplayeruse(var_3);
    var_2 hidefromplayer(var_3);
  }
}

function givebreachscore(var_0) {
  var_1 = "breach";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

function givedefusescore(var_0) {
  var_1 = "breach_defuse";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

function givegunless() {
  self endon("death_or_disconnect");
  var_0 = getcompleteweaponname("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

function takegunless() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_melee(1);
}

function rockable_cars_init() {
  waitframe();
  scripts\common\rockable_vehicles::rockable_cars_init();
  scripts\engine\utility::array_thread(level.rockablecars.cars, &rockable_cars_watch_players);
}

function rockable_cars_watch_players() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.rockablecars.cars) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_2 = [];

      foreach(var_4 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_4)) {
          continue;
        }

        var_5 = var_4 getentitynumber();

        if(isDefined(var_1.players[var_5])) {
          continue;
        }

        if(var_4 ismantling()) {
          continue;
        }

        var_6 = var_4 getmovingplatformparent();

        if(!isDefined(var_6) || var_6 != var_1) {
          continue;
        }

        var_7 = var_4.origin - var_1.toppoint;

        if(vectordot(var_7, var_1.up) < 0) {
          continue;
        }

        var_8 = vectordot(var_7, var_1.forward);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1.halflength;

        if(var_10 > 1) {
          continue;
        }

        var_11 = vectordot(var_7, var_1.right);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1.halfwidth;

        if(var_13 > 1) {
          continue;
        }

        var_5 = var_4 getentitynumber();
        var_2 = var_4;
        rockable_car_rock(var_1, var_4, var_10, var_13, var_8, var_11);
      }

      foreach(var_5, var_4 in var_1.players) {
        var_16 = gettime() - var_1.touchtimes[var_5];

        if(!isDefined(var_4) || !scripts\mp\utility\player::isreallyalive(var_4)) {
          rockable_car_remove_player(var_1, var_5, undefined, 0);
          continue;
        }

        if(var_4 ismantling()) {
          rockable_car_remove_player(var_1, var_5, var_16, 1);
          continue;
        }

        var_6 = var_4 getmovingplatformparent();

        if(!isDefined(var_6) || var_6 != var_1) {
          rockable_car_remove_player(var_1, var_5, var_16, 1);
          continue;
        }

        var_7 = var_4.origin - var_1.toppoint;

        if(vectordot(var_7, var_1.up) < 0) {
          rockable_car_remove_player(var_1, var_5, var_16, 1);
          continue;
        }

        var_8 = vectordot(var_7, var_1.forward);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1.halflength;

        if(var_10 > 1) {
          rockable_car_remove_player(var_1, var_5, var_16, 1);
          continue;
        }

        var_11 = vectordot(var_7, var_1.right);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1.halfwidth;

        if(var_13 > 1) {
          rockable_car_remove_player(var_1, var_5, var_16, 1);
          continue;
        }

        var_1.touchtimes[var_5] = gettime();
      }

      foreach(var_5, var_4 in var_2) {
        rockable_car_add_player(var_1, var_4);
      }
    }

    waitframe();
  }
}

function rockable_car_add_player(var_0) {
  var_1 = var_0 getentitynumber();
  self.players[var_1] = var_0;
  self.touchtimes[var_1] = gettime();
}

function rockable_car_remove_player(var_0, var_1, var_2) {
  if(var_2) {
    if(isDefined(var_1) && var_1 >= 200) {
      self.players[var_0] = undefined;
      self.touchtimes[var_0] = undefined;
      self.rocktimes[var_0] = undefined;
      self.rockstrings[var_0] = undefined;
      return;
    }

    return;
  }

  self.players[var_0] = undefined;
  self.touchtimes[var_0] = undefined;
  self.rocktimes[var_0] = undefined;
  self.rockstrings[var_0] = undefined;
}

function rockable_car_rock(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 > 0.3 && var_2 > 0) {
    var_5 = scripts\engine\utility::ter_op(var_3 >= 0, "front", "back");
    var_6 = scripts\engine\utility::ter_op(var_4 >= 0, "right", "left");
    self setscriptablepartstate("Anim_PlayerStandRock", var_5 + "_" + var_6, 0);
    var_7 = var_0 getentitynumber();
    self.rocktimes[var_7] = gettime();
    self.rockstrings[var_7] = var_5 + var_6;
    return;
  }
}