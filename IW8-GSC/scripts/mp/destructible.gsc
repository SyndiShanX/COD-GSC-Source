/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructible.gsc
***********************************************/

function init() {}

function script_model_anims() {}

#using_animtree("script_model");

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0.player_rig = spawn("script_model", var0.origin);
  var0.player_rig setModel(var2);
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var1 = var0 getdroptofloorposition(var0.origin);

  if(isDefined(var1)) {
    var0 setOrigin(var1);
  } else {
    var0 setOrigin(var0.origin + (0, 0, 100));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}

function add_destructible_array(var0, var1) {
  var2 = getEntArray(var0, var1);

  foreach(var4 in var2) {
    var5 = spawnStruct();
    add_destructible(var5, var4);
    assigninteractteam(var5, level.teamnamelist);

    if(!isDefined(level.destructibles[var0])) {
      level.destructibles[var0] = [];
    }

    level.destructibles[var0][level.destructibles[var0].size] = var5;
    process_action(var5, "init");
  }
}

function add_destructible(var0, var1) {
  if(!isDefined(var0.ents)) {
    var0.ents = [];
  }

  read_properties(var0, var1);
  read_actions(var0, var1);
  var0.ents[var0.ents.size] = var1;
  var1.parent = var0;

  if(isDefined(var1.target)) {
    var2 = getEntArray(var1.target, "targetname");

    if(isDefined(var2) && var2.size > 0) {
      foreach(var4 in var2) {
        add_destructible(var0, var4);
      }

      return;
    }

    return;
  }
}

function read_properties(var0) {
  if(!isDefined(var0)) {
    return;
  }

  switch (var0.classname) {
    case "trigger_use_touch":
      self.use_trigger = var0;
      break;
    case "script_origin":
      var1 = var0.script_label;

      if(isDefined(var1)) {
        switch (var1) {
          case "usePrompt_front":
            if(!isDefined(self.useobjects)) {
              self.useobjects = [];
            }

            self.useobjects["front"] = setup_bomb_object(var0.origin);
            self.useobjects["front"].scenenodekey = "front";
            break;
          case "sceneNode_front":
            if(!isDefined(self.scenenodes)) {
              self.scenenodes = [];
            }

            self.scenenodes["front"] = var0;
            break;
          case "usePrompt_back":
            if(!isDefined(self.useobjects)) {
              self.useobjects = [];
            }

            self.useobjects["back"] = setup_bomb_object(var0.origin);
            self.useobjects["back"].scenenodekey = "back";
            break;
          case "sceneNode_back":
            if(!isDefined(self.scenenodes)) {
              self.scenenodes = [];
            }

            self.scenenodes["back"] = var0;
            break;
        }
      }

      break;
    case "scriptable":
      self.scriptable = var0;
      break;
  }
}

function read_actions(var0) {
  if(!isDefined(var0.script_noteworthy)) {
    return;
  }

  var1 = strtok(var0.script_noteworthy, ",");

  foreach(var3 in var1) {
    var4 = strtok(var3, "|");

    if(!isDefined(var4)) {
      return;
    }

    if(var4.size < 2) {
      return;
    }

    var3 = var4[0];

    if(!isDefined(var0.actions)) {
      var0.actions = [];
    }

    if(!isDefined(var0.actions[var3])) {
      var0.actions[var3] = [];
    }

    for(var5 = 1; var5 < var4.size; var5++) {
      var0.actions[var3][var0.actions[var3].size] = var4[var5];
    }
  }
}

function waittime_process_action(var0, var1) {
  level endon("game_ended");
  wait var1;
  process_action(var0);
}

function waitmsg_process_action(var0) {
  level endon("game_ended");
  self waittill(var0);
  process_action(var0);
}

function process_action(var0) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var2 in self.ents) {
    if(isDefined(var2.actions) && isDefined(var2.actions[var0])) {
      foreach(var4 in var2.actions[var0]) {
        actionmap(var2, var4);
      }
    }
  }

  self.state = var0;
}

function actionmap(var0) {
  switch (var0) {
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
      var1 = self.origin;
      var2 = self.angles;
      var3 = spawnfx(level._effect["breach_explode"], var1, anglesToForward(var2) * -1, (0, 0, 1));
      triggerfx(var3);
      physicsexplosionsphere(var1, 200, 100, 3);
      playrumbleonposition("grenade_rumble", var1);
      earthquake(0.5, 1, var1, 1500);
      self.parent.plantedbomb setscriptablepartstate("bomb", "destroy");
      break;
  }
}

function setup_bomb_object(var0) {
  var1 = scripts\mp\gameobjects::createhintobject(var0, "HINT_BUTTON", "hud_icon_c4_plant", &"MP/BREACH", undefined, undefined, undefined, 800, 120, 72, 120);

  if(!isDefined(level.breachusetriggers)) {
    level.breachusetriggers = [];
  }

  level.breachusetriggers[level.breachusetriggers.size] = var1;
  self.defused = 0;
  thread usetriggerthink(var1);
  return var1;
}

function bomb_planted_think(var0, var1) {
  var2 = var1.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var2);

  if(!self.defused) {
    process_action("destroyed");
    var3 = self.useobjects[var0].origin;

    if(isDefined(self.scriptable)) {
      if(var0 == "front") {
        self.scriptable setscriptablepartstate("base", "destroyFront");
      } else {
        self.scriptable setscriptablepartstate("base", "destroyBack");
      }
    } else {
      var4 = self.useobjects[var0].angles;
      var5 = spawnfx(level._effect["breach_explode"], var3, anglesToForward(var4) * -1, (0, 0, 1));
      triggerfx(var5);
      self.plantedbomb setscriptablepartstate("bomb", "destroy");
    }

    physicsexplosionsphere(var3, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var3);
    earthquake(0.5, 1, var3, 1500);

    foreach(var7 in self.useobjects) {
      var7 delete();
      level.breachusetriggers = scripts\engine\utility::array_remove(level.breachusetriggers, var7);
    }

    wait 0.1;

    if(isDefined(var1)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 120, 10, var1, "MOD_EXPLOSIVE", "bomb_site_mp");
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
    foreach(var7 in self.useobjects) {
      var7 setHintString(&"MP/BREACH");
    }

    assigninteractteam(level.teamnamelist);
    process_action("init");
    return;
  }
}

function playhostagehelp(var0) {
  wait 1;

  if(distance2d(level.hostages[0].origin, var0) < 500) {
    level.hostages[0] playSound("dx_mpb_us3_hvt_up");
    return;
  }
}

function bomb_fuse_think(var0) {
  self endon("defused");

  foreach(var2 in self.useobjects) {
    var2 setHintString(&"MP/BREACH_DEFUSE");
  }

  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  self.timerobject makeusable();
  assigninteractteam(scripts\mp\utility\teams::getenemyteams(var0));
  var4 = gettime();
  var5 = int(var4 + 5000);
  setomnvar("ui_ingame_timer_" + self.breachindex, var5);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  var6 = var5 - var4;

  while(!self.defused && var6 > 0) {
    var4 = gettime();
    var6 = var5 - var4;

    if(var6 < 1500) {
      if(var6 <= 250) {
        self.plantedbomb playSound("breach_warning_beep_05");
      } else if(var6 < 500) {
        self.plantedbomb playSound("breach_warning_beep_04");
      } else if(var6 < 1500) {
        self.plantedbomb playSound("breach_warning_beep_03");
      } else {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var6 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1;
    }

    if(var6 < 0) {
      break;
    }
  }
}

function usetriggerthink(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(!scripts\engine\utility::array_contains(self.interactteams, var1.team)) {
      continue;
    }

    if(var1 scripts\mp\utility\weapon::grenadeinpullback()) {
      return 0;
    }

    if(var1 meleeButtonPressed()) {
      return 0;
    }

    if(var1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!isDefined(self.plantedbomb)) {
      plantbreachc4(var0, var1);
      continue;
    }

    defusec4(var1);
  }
}

#using_animtree("");

function plantbreachc4(var0, var1) {
  thread watchplayerdeath(var1);
  var1.linktoent = var1 scripts\engine\utility::spawn_tag_origin();
  var1 playerlinktodelta(var1.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var1.linktoent moveTo(self.scenenodes[var0.scenenodekey].origin, 0.25, 0.1, 0.1);
  var1.linktoent rotateTo(self.scenenodes[var0.scenenodekey].angles, 0.25, 0.1, 0.1);
  var1 setstance("stand");

  if(!givegunless(var1)) {
    var1 unlink();
    var1.linktoent delete();
    var1.linktoent = undefined;
    return false;
  }

  if(istrue(self.cancelplant)) {
    return false;
  }

  var1 unlink();
  var1.linktoent delete();
  var1.linktoent = undefined;
  var1 setOrigin(self.scenenodes[var0.scenenodekey].origin);
  var1 setplayerangles(self.scenenodes[var0.scenenodekey].angles);

  foreach(var3 in self.useobjects) {
    var3 hide();
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var1, "c4_plant");
  var5 = scripts\engine\utility::ter_op(var1.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var5 = scripts\engine\utility::ter_op(var1.team == "allies", "ukp1", "abp1");
  }

  var1 queuedialogforplayer("dx_mpp_" + var5 + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(var1, "planter");
  var1 thread scripts\mp\anim::anim_player_solo(var1, var1.player_rig, "plant");
  var6 = spawn("script_model", self.scenenodes[var0.scenenodekey].origin);
  var6 setModel("offhand_wm_c4");
  var6.animname = "c4";
  var6 useanimtree(#animtree);
  self.plantedbomb = var6;
  self.plantedkey = var0.scenenodekey;
  self.scenenodes[var0.scenenodekey] thread scripts\common\anim::anim_single_solo(var6, "plant");
  var7 = getanimlength(level.scr_anim["planter"]["plant"]);
  var8 = 0.5;
  wait var7 - var8;

  if(istrue(self.cancelplant)) {
    return false;
  }

  thread bomb_planted_think(var0.scenenodekey, var1);
  givebreachscore(var1);
  wait var8 - 0.1;
  thread takegunless();
  remove_player_rig(var1);
  process_action("onuse");
  self notify("breach_complete");
  return true;
}

function watchplayerdeath(var0) {
  self endon("breach_complete");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
      foreach(var2 in self.useobjects) {
        var2 show();
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

function allowplayertobreach(var0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var2 in level.breachusetriggers) {
      var2 enableplayeruse(var0);
    }

    return;
  }
}

function disallowplayertobreach(var0) {
  if(isDefined(level.breachusetriggers)) {
    foreach(var2 in level.breachusetriggers) {
      var2 disableplayeruse(var0);
    }

    return;
  }
}

function defusec4(var0) {
  self.defused = 1;
  self notify("defused");
  givedefusescore(var0);
}

function onplayerjoinedteam(var0) {
  foreach(var2 in level.destructibles) {
    foreach(var4 in var2) {
      applyinteractteam(var4, var0);
    }
  }
}

function assigninteractteam(var0) {
  self.interactteams = var0;

  foreach(var2 in level.players) {
    applyinteractteam(var2);
  }
}

function applyinteractteam(var0) {
  if(self.state == "destroyed") {
    return;
  }

  if(!isDefined(self.useobjects)) {
    return;
  }

  if(scripts\engine\utility::array_contains(self.interactteams, var0.team)) {
    jumpiffalse(isDefined(self.plantedbomb)) LOC_0000009d;
    self.timerobject hidefromplayer(var0);

    foreach(var3, var2 in self.useobjects) {
      if(var3 == self.plantedkey) {
        var2 setuseholdduration("duration_medium");
        var2 enableplayeruse(var0);
        var2 showtoplayer(var0);
        continue;
      }

      var2 disableplayeruse(var0);
      var2 hidefromplayer(var0);
    }

    return;
  }

  jumpiffalse(isDefined(self.plantedbomb)) LOC_000000f0;
  self.timerobject showtoplayer(var3);

  foreach(var2 in self.useobjects) {
    var2 disableplayeruse(var3);
    var2 hidefromplayer(var3);
  }
}

function givebreachscore(var0) {
  var1 = "breach";
  var2 = scripts\mp\rank::getscoreinfovalue(var1);
  var0 thread scripts\mp\rank::giverankxp(var1, var2);
  var0 thread scripts\mp\rank::scoreeventpopup(var1);
}

function givedefusescore(var0) {
  var1 = "breach_defuse";
  var2 = scripts\mp\rank::getscoreinfovalue(var1);
  var0 thread scripts\mp\rank::giverankxp(var1, var2);
  var0 thread scripts\mp\rank::scoreeventpopup(var1);
}

function givegunless() {
  self endon("death_or_disconnect");
  var0 = getcompleteweaponname("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  var1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 0);

  if(var1) {
    self.gunnlessweapon = var0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var1;
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
    foreach(var1 in level.rockablecars.cars) {
      if(!isDefined(var1)) {
        continue;
      }

      var2 = [];

      foreach(var4 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var4)) {
          continue;
        }

        var5 = var4 getentitynumber();

        if(isDefined(var1.players[var5])) {
          continue;
        }

        if(var4 ismantling()) {
          continue;
        }

        var6 = var4 getmovingplatformparent();

        if(!isDefined(var6) || var6 != var1) {
          continue;
        }

        var7 = var4.origin - var1.toppoint;

        if(vectordot(var7, var1.up) < 0) {
          continue;
        }

        var8 = vectordot(var7, var1.forward);
        var9 = abs(var8);
        var10 = var9 / var1.halflength;

        if(var10 > 1) {
          continue;
        }

        var11 = vectordot(var7, var1.right);
        var12 = abs(var11);
        var13 = var12 / var1.halfwidth;

        if(var13 > 1) {
          continue;
        }

        var5 = var4 getentitynumber();
        var2 = var4;
        rockable_car_rock(var1, var4, var10, var13, var8, var11);
      }

      foreach(var5, var4 in var1.players) {
        var16 = gettime() - var1.touchtimes[var5];

        if(!isDefined(var4) || !scripts\mp\utility\player::isreallyalive(var4)) {
          rockable_car_remove_player(var1, var5, undefined, 0);
          continue;
        }

        if(var4 ismantling()) {
          rockable_car_remove_player(var1, var5, var16, 1);
          continue;
        }

        var6 = var4 getmovingplatformparent();

        if(!isDefined(var6) || var6 != var1) {
          rockable_car_remove_player(var1, var5, var16, 1);
          continue;
        }

        var7 = var4.origin - var1.toppoint;

        if(vectordot(var7, var1.up) < 0) {
          rockable_car_remove_player(var1, var5, var16, 1);
          continue;
        }

        var8 = vectordot(var7, var1.forward);
        var9 = abs(var8);
        var10 = var9 / var1.halflength;

        if(var10 > 1) {
          rockable_car_remove_player(var1, var5, var16, 1);
          continue;
        }

        var11 = vectordot(var7, var1.right);
        var12 = abs(var11);
        var13 = var12 / var1.halfwidth;

        if(var13 > 1) {
          rockable_car_remove_player(var1, var5, var16, 1);
          continue;
        }

        var1.touchtimes[var5] = gettime();
      }

      foreach(var5, var4 in var2) {
        rockable_car_add_player(var1, var4);
      }
    }

    waitframe();
  }
}

function rockable_car_add_player(var0) {
  var1 = var0 getentitynumber();
  self.players[var1] = var0;
  self.touchtimes[var1] = gettime();
}

function rockable_car_remove_player(var0, var1, var2) {
  if(var2) {
    if(isDefined(var1) && var1 >= 200) {
      self.players[var0] = undefined;
      self.touchtimes[var0] = undefined;
      self.rocktimes[var0] = undefined;
      self.rockstrings[var0] = undefined;
      return;
    }

    return;
  }

  self.players[var0] = undefined;
  self.touchtimes[var0] = undefined;
  self.rocktimes[var0] = undefined;
  self.rockstrings[var0] = undefined;
}

function rockable_car_rock(var0, var1, var2, var3, var4) {
  if(var1 > 0.3 && var2 > 0) {
    var5 = scripts\engine\utility::ter_op(var3 >= 0, "front", "back");
    var6 = scripts\engine\utility::ter_op(var4 >= 0, "right", "left");
    self setscriptablepartstate("Anim_PlayerStandRock", var5 + "_" + var6, 0);
    var7 = var0 getentitynumber();
    self.rocktimes[var7] = gettime();
    self.rockstrings[var7] = var5 + var6;
    return;
  }
}