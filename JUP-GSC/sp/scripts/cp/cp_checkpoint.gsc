/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_checkpoint.gsc
***********************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_objectives;
#using scripts\cp\loadout;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\cp_safehouse_util;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;
#namespace cp_checkpoint;

function checkpoints_init() {
  if(isDefined(level.registered_checkpoints)) {
    return;
  }

  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&checkpoint_onplayerconnect);

  if(!isDefined(game["checkpoint_attempts"])) {
    game["checkpoint_attempts"] = [];
  }

  if(!isDefined(game["checkpoints_completed"])) {
    game["checkpoints_completed"] = [];
  }

  cmd = "<dev string:x1c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x80>";
  addentrytodevgui(cmd);
  thread debug_activation(@ "hash_ab7abd921b71638d", &function_7d2ee45f1241a17a);

  level.registered_checkpoints = [];
  level.var_22ee4e8db4fd17f3 = [];
  level.checkpoint_spawnpoints = [];
  player_spawns = [];
  var_313cc72de0c10cde = [];
  player_spawns = [];

  if(isDefined(level.checkpoint_player_spawns_func)) {
    player_spawns = [[level.checkpoint_player_spawns_func]]();
  }

  var_313cc72de0c10cde = [];

  if(isDefined(level.checkpoint_carepkg_spawns_func)) {
    var_313cc72de0c10cde = [[level.checkpoint_carepkg_spawns_func]]();
  }

  if(player_spawns.size < 1 && var_313cc72de0c10cde.size < 1) {
    return;
  }

  items = array_combine(player_spawns, var_313cc72de0c10cde);

  foreach(item in items) {
    if(!isDefined(level.registered_checkpoints[item.checkpoint])) {
      level.registered_checkpoints[item.checkpoint] = [];
    }

    level.registered_checkpoints[item.checkpoint][index] = item;
  }
}

function checkpoint_onplayerconnect() {
  ddl_checkpoint = namespace_1170726b2799ea65::function_50f02a42c72031cb(level.mapname);

  if(isDefined(ddl_checkpoint) && ddl_checkpoint != "") {
    function_24490b05670afa23(ddl_checkpoint);
  }

  [origin, angles] = namespace_1170726b2799ea65::function_124086d0afefcee3();

  if(isDefined(origin) && origin != "") {
    if(!isDefined(angles)) {
      angles = (0, 0, 0);
    }

    if(isstring(angles)) {
      toks = strtok(angles, "(");
      toks = strtok(toks[0], ")");
      toks = strtok(toks[0], ",");
      angles = (float(toks[0]), float(toks[1]), float(toks[2]));
    }

    if(isstring(origin)) {
      toks = strtok(origin, "(");
      toks = strtok(toks[0], ")");
      toks = strtok(toks[0], ",");
      origin = (float(toks[0]), float(toks[1]), float(toks[2]));
    }

    struct = spawnStruct();
    struct.angles = angles;
    struct.origin = origin;
    self.pers["checkpoint_spawnpoint"] = struct;
  }

  thread function_ef6a255ad0d55f48();
}

function function_ef6a255ad0d55f48() {
  self endon("disconnect");
  level endon("game_ended");
  flag_wait("player_spawned_with_loadout");

  while(!istrue(self.armorinitialized)) {
    waitframe();
  }

  var_ec99da435b12b106 = namespace_1170726b2799ea65::function_a00ff86fba36d23e();

  if(isDefined(var_ec99da435b12b106) && var_ec99da435b12b106 > 0) {
    scripts\cp_mp\armor::setarmorhealth(var_ec99da435b12b106, 1);
  }

  var_c2dc97ae1544c42d = namespace_1170726b2799ea65::function_25ae243b0c56d3fc();

  if(isDefined(var_c2dc97ae1544c42d) && var_c2dc97ae1544c42d > 0) {
    scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(var_c2dc97ae1544c42d);
  }

  var_b194f832b48e63ce = namespace_1170726b2799ea65::function_beebc333010c5122();

  if(istrue(var_b194f832b48e63ce)) {
    scripts\cp\pickups::addselfrevivetoken(1, 1);
  }
}

function function_418cc3c8f49d765a(val) {
  level.var_8d39359d283b5d75 = val;
}

function checkpoint_register(checkpoint, func) {
  if(!isDefined(level.registered_checkpoint_funcs)) {
    level.registered_checkpoint_funcs = [];
  }

  level.registered_checkpoint_funcs[checkpoint] = func;
}

function function_17660e9c061a06db() {
  active_mission = undefined;
  start = function_704ff93a09415c5d();

  if(isDefined(level.var_2a02072872ccd8a1)) {
    keys = getarraykeys(level.var_2a02072872ccd8a1);

    for(i = 0; i < keys.size; i++) {
      if(isDefined(level.var_2a02072872ccd8a1[keys[i]].starts)) {
        j = 0;

        for(j = 0; j < level.var_2a02072872ccd8a1[keys[i]].starts.size; j++) {
          if(start == level.var_2a02072872ccd8a1[keys[i]].starts[j]) {
            active_mission = keys[i];
            break;
          }
        }
      }
    }
  }

  return active_mission;
}

function function_d37e0c86fbcf710b(objectives, checkpoints, var_7bd2543cb85e81d7) {
  if(function_51a0f44b99dc2fd3()) {
    if(!isDefined(level.var_9f966ce33c2acf74)) {
      level.var_9f966ce33c2acf74 = [];
    }

    array = level.var_9f966ce33c2acf74;

    if(!isarray(objectives)) {
      objectives = [objectives];
    }

    foreach(objective in objectives) {
      if(!isDefined(array[objective])) {
        array[objective] = [];
      }

      if(!isarray(checkpoints)) {
        checkpoints = [checkpoints];
      }

      foreach(checkpoint in checkpoints) {
        if(!isDefined(array[objective][checkpoint])) {
          array[objective][checkpoint] = spawnStruct();
        }

        array[objective][checkpoint].isvalid = 0;
        array[objective][checkpoint].var_7bd2543cb85e81d7 = var_7bd2543cb85e81d7;
      }
    }

    level.var_9f966ce33c2acf74 = array;
  }
}

function function_81066d5ad04fa613(checkpoint, objective) {
  if(isDefined(level.var_9f966ce33c2acf74) && isDefined(level.var_9f966ce33c2acf74[objective]) && isDefined(level.var_9f966ce33c2acf74[objective][checkpoint])) {
    return istrue(level.var_9f966ce33c2acf74[objective][checkpoint].isvalid);
  }

  return true;
}

function function_b6090c4fefd0c9a5(checkpoint, objective) {
  if(isDefined(level.var_9f966ce33c2acf74[objective][checkpoint].var_7bd2543cb85e81d7)) {
    struct = spawnStruct();
    struct.checkpoint = checkpoint;
    struct.objective = objective;
    struct[[level.var_9f966ce33c2acf74[objective][checkpoint].var_7bd2543cb85e81d7]]();
  }
}

function function_25958aa1ac22a73() {
  checkpoint = checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint])) {
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
  }
}

function function_d4cdc242233c15b3() {
  start = function_704ff93a09415c5d();
  active_mission = function_17660e9c061a06db();
  checkpoint = checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint])) {
    if(isDefined(active_mission) && isDefined(level.var_2a02072872ccd8a1) && isDefined(active_mission) && isDefined(level.var_2a02072872ccd8a1[active_mission])) {
      var_b62e28e3fbdfac20 = level.var_2a02072872ccd8a1[active_mission];

      if(isDefined(var_b62e28e3fbdfac20.checkpoints) && isDefined(var_b62e28e3fbdfac20.checkpoints[checkpoint]) && isDefined(var_b62e28e3fbdfac20.checkpoints[checkpoint].var_23c5a6352ce4150e)) {
        level.default_player_spawns = var_b62e28e3fbdfac20.checkpoints[checkpoint].var_23c5a6352ce4150e;
      }
    }

    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
    return;
  }

  if(isDefined(active_mission)) {
    function_ebc288fcc6cabbe4(active_mission);
  }
}

function function_ebc288fcc6cabbe4(mission_name) {
  mission_struct = level.var_2a02072872ccd8a1[mission_name];

  if(isDefined(mission_struct.var_97d01eef320789e)) {
    level.default_player_spawns = mission_struct.var_97d01eef320789e;
  }

  mission_struct.start = function_704ff93a09415c5d();
  mission_struct.checkpoint = checkpoint_get();
  mission_struct thread[[mission_struct.var_e0c23e69910a3ea0]]();
}

function private function_704ff93a09415c5d() {
  start = getDvar(@ "start");

  if(!isDefined(start) || isDefined(start) && start == "") {
    if(istrue(level.var_8d39359d283b5d75)) {
      if(flag("start_is_set")) {
        start = level.start_point;
      } else if(isDefined(level.default_start_override)) {
        start = level.default_start_override;
      } else if(scripts\cp\starts::level_has_start_points()) {
        start = level.start_functions[0]["name"];
      } else {
        start = "default";
      }
    }
  }

  return start;
}

function register_mission(mission_name, mission_starts, var_e0c23e69910a3ea0, var_7064a1a61989f0f5) {
  if(!isDefined(level.var_2a02072872ccd8a1)) {
    level.var_2a02072872ccd8a1 = [];
  }

  struct = spawnStruct();
  struct.starts = mission_starts;
  struct.checkpoints = [];
  struct.var_e0c23e69910a3ea0 = var_e0c23e69910a3ea0;
  struct.var_97d01eef320789e = var_7064a1a61989f0f5;
  level.var_2a02072872ccd8a1[mission_name] = struct;
}

function function_a83214ec9cbf5bc8(mission_name, checkpoint, checkpoint_func, var_49dc719a8aea08c8) {
  if(!isDefined(level.var_2a02072872ccd8a1) || !isDefined(level.var_2a02072872ccd8a1[mission_name])) {
    assert("attempted to register a checkpoint " + checkpoint + " for unregistered mission: " + mission_name);
    return;
  }

  var_b62e28e3fbdfac20 = level.var_2a02072872ccd8a1[mission_name];
  cp_struct = spawnStruct();
  cp_struct.cp_func = checkpoint_func;
  cp_struct.var_23c5a6352ce4150e = var_49dc719a8aea08c8;
  var_b62e28e3fbdfac20.checkpoints[checkpoint] = cp_struct;
  checkpoint_register(checkpoint, checkpoint_func);
}

function checkpoint_isset() {
  return isDefined(game["restart_checkpoint"]);
}

function function_f64efae7665a7baa(delay, checkpoint) {
  level endon("game_ended");
  wait delay;
  checkpoint_set(checkpoint);
}

function checkpoint_set(checkpoint, ignore_loadout, var_2072812d969955cb) {
  if(!istrue(var_2072812d969955cb)) {
    function_ee15fb8d39d4f4dd(checkpoint);
  }

  game["restart_checkpoint"] = checkpoint;

  if(checkpoint == "") {
    game["restart_checkpoint"] = undefined;
  }

  thread scripts\cp\cp_gameskill::function_71ec52011ff77954();
  var_4a0d987ac61bba3b = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", level.mapname));

  if(isDefined(var_4a0d987ac61bba3b) && var_4a0d987ac61bba3b != "") {
    setDvar(hashcat(@ "hash_287b3b75f2c14fe9", level.mapname), "");
  }

  if(checkpoint != "") {
    announcement("<dev string:xdc>" + checkpoint);

    setDvar(@ "hash_f004b2ccc04fdc8d", 1);
    function_24490b05670afa23(checkpoint);

    if(!istrue(var_2072812d969955cb)) {
      setomnvar("ui_cp_checkpoint", 1);
    }

    if(isDefined(game["checkpoint_attempts"]) && !isDefined(game["checkpoint_attempts"][checkpoint])) {
      game["checkpoint_attempts"][checkpoint] = 1;
    }
  }

  foreach(player in level.players) {
    player.pers["counting_stats"]["kills"] = player scripts\cp\persistence::function_c0480dc3a45ef6("kills");
    player.pers["counting_stats"]["downs"] = player scripts\cp\persistence::function_c0480dc3a45ef6("downs");
    player.pers["counting_stats"]["revives"] = player scripts\cp\persistence::function_c0480dc3a45ef6("revives");

    if(checkpoint != "" && !istrue(ignore_loadout)) {
      player thread scripts\cp\loadout::function_7da7bd24b280d295();
    }
  }

  scripts\cp\cp_gameskill::function_ffef4cfd9fec2e5b();
  thread function_57bb5cb576f3486e();
}

function function_705d572f010fb61c() {
  if(isDefined(game["checkpoints_completed"]) && game["checkpoints_completed"].size > 0) {
    var_eb92e89246b291b6 = getarraykeys(game["checkpoints_completed"]);

    foreach(checkpoint in var_eb92e89246b291b6) {
      function_e7991cd1beb1563f(checkpoint);
    }
  }
}

function function_87ce7c6cba6c393() {
  if(isDefined(game["checkpoints_completed"]) && game["checkpoints_completed"].size > 0) {
    var_eb92e89246b291b6 = getarraykeys(game["checkpoints_completed"]);
    return var_eb92e89246b291b6;
  }

  return [];
}

function function_24490b05670afa23(checkpoint) {
  difficulty = scripts\cp\cp_gameskill::get_gameskill();

  foreach(player in level.players) {
    player namespace_1170726b2799ea65::function_5de16de5f3a1776f(level.script, checkpoint, int(difficulty), player isnightvisionon(), getgroundposition(player getvieworigin(), 8), player getplayerangles(1));
  }

  function_e7991cd1beb1563f(checkpoint);
  game["checkpoints_completed"][checkpoint] = 1;
}

function function_e7991cd1beb1563f(checkpoint) {
  flag_set(checkpoint + "_completed");
}

function function_cd10e09e02e4eb07(checkpoint) {
  return istrue(game["checkpoints_completed"][checkpoint]);
}

function function_5ace495feba111d3() {
  level.player namespace_1170726b2799ea65::function_5de16de5f3a1776f();
  setDvar(@ "hash_f004b2ccc04fdc8d", 0);
  game["checkpoints_completed"] = [];
}

function function_57bb5cb576f3486e() {
  level endon("game_ended");
  waitframe();
  setomnvar("ui_cp_checkpoint", 0);
}

function checkpoint_get() {
  if(getdvarint(@ "hash_f1981b3f0cb1f449")) {
    return "";
  }

  if(isDefined(game["restart_checkpoint"])) {
    return game["restart_checkpoint"];
  }

  checkpoint = level.player namespace_1170726b2799ea65::function_50f02a42c72031cb(level.mapname);

  if(isDefined(checkpoint) && checkpoint != "" && !istrue(game["ddl_checkpoint_used"])) {
    game["ddl_checkpoint_used"] = 1;
    game["restart_checkpoint"] = checkpoint;
    return checkpoint;
  }

  return "";
}

function function_16083b03fbaa26b2(checkpoint, default_func, completed_func) {
  if(isDefined(checkpoint) && function_51a0f44b99dc2fd3()) {
    if(function_cd10e09e02e4eb07(checkpoint)) {
      thread[[completed_func]]();
    }

    return;
  }

  thread[[default_func]]();
}

function function_51a0f44b99dc2fd3() {
  if(getdvarint(@ "hash_ba52fc94cd52acad", 1)) {
    return 1;
  }

  return 0;
}

function checkpoint_get_item(checkpoint, item_type) {
  checkpoint_items = level.registered_checkpoints[checkpoint];

  if(!isDefined(checkpoint_items)) {
    return undefined;
  }

  foreach(item in checkpoint_items) {
    if(item.type != item_type) {
      continue;
    }

    if(item.checkpoint != checkpoint) {
      continue;
    }

    if(isDefined(item.inuse)) {
      continue;
    }

    switch (item_type) {
      case #"hash_765f4f5fb06286a0":
        item.inuse = 1;
        return item;
      case #"hash_2edfeb5cf47ba7b5":
      case #"hash_40ad539921f037a4":
        return item;
    }
  }
}

function function_ee15fb8d39d4f4dd(checkpoint) {
  scripts\engine\utility::callsharedfunc("game", "checkpoint_set", checkpoint);

  if(function_b4c58bbbae8c7412(checkpoint)) {
    return istrue(function_58beb11b01fb7b92(checkpoint));
  }

  return true;
}

function function_b4c58bbbae8c7412(checkpoint) {
  return isDefined(level.var_22ee4e8db4fd17f3[checkpoint]);
}

function function_58beb11b01fb7b92(checkpoint) {
  [[level.var_22ee4e8db4fd17f3[checkpoint]]]();
}

function function_63e1728c535014c9(checkpoint, func) {
  level.var_22ee4e8db4fd17f3[checkpoint] = func;
}

function checkpoint_release_spawnpoint(player) {
  player waittill_any_2("spawned_player", "disconnect");

  while(any_player_nearby(self.origin, 64)) {
    wait 1;
  }

  self.inuse = undefined;
}

function checkpoint_create_carepackage(checkpoint) {
  level endon("game_ended");

  if(!isDefined(level.registered_checkpoint_funcs[checkpoint])) {
    assertmsg("Using a checkpoint for wrong level: " + checkpoint);
    return;
  }

  spawnpoint = checkpoint_get_item(checkpoint, "carepackage");
  care_pkg = spawn("script_model", spawnpoint.origin);
  care_pkg.angles = spawnpoint.angles;
  care_pkg setModel("military_carepackage_01_friendly");
  brushmodel = getEnt("care_package_col", "targetname");
  collisionmodel = spawn("script_model", spawnpoint.origin);
  collisionmodel.angles = spawnpoint.angles;
  collisionmodel clonebrushmodeltoscriptmodel(brushmodel);
  collisionmodel linkTo(care_pkg);
  var_e88f6961175998ce = spawn("script_model", spawnpoint.origin + (0, 0, 35));
  var_e88f6961175998ce setModel("tag_origin");
  var_e88f6961175998ce sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var_e88f6961175998ce.headicon = createheadicon(care_pkg);
  setheadiconimage(var_e88f6961175998ce.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(var_e88f6961175998ce.headicon, 0);
  setheadiconmaxdistance(var_e88f6961175998ce.headicon, 1024);
  setheadiconnaturaldistance(var_e88f6961175998ce.headicon, 256);
  setheadiconzoffset(var_e88f6961175998ce.headicon, -5);
  care_pkg.collision = collisionmodel;
  care_pkg.interaction = var_e88f6961175998ce;
  var_e88f6961175998ce thread checkpoint_carepackage_think(care_pkg);
  return care_pkg;
}

function checkpoint_carepackage_think(carepackage) {
  self endon("death");
  carepackage endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    player thread checkpoint_edit_loadout(self);
  }
}

function checkpoint_edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  interaction disableplayeruse(self);
  level thread scripts\cp\utility\cp_safehouse_util::function_54dac17e1c475546(self, interaction);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  interaction enableplayeruse(self);
}

function checkpoint_create_carepackage_munitions(checkpoint, override_waittill, override_timer, use_milcrate) {
  level endon("game_ended");
  exit = 0;

  if(istrue(level.disable_map_munitions)) {
    switch (checkpoint) {
      case #"hash_375daee74272699":
      case #"hash_bdc72b8b1960fa5":
      case #"hash_53abaf23787c2d08":
      case #"hash_53abb023787c2e9b":
      case #"hash_53abb123787c302e":
      case #"hash_7010d957c8cd3663":
      case #"hash_c48403df9bace772":
      case #"hash_e62185dc1075bb84":
        exit = 1;
        break;
    }

    if(exit) {
      return;
    }
  }

  spawnpoint = checkpoint_get_item(checkpoint, "carepackage_munitions");

  if(!isDefined(spawnpoint) || !isDefined(spawnpoint.origin)) {
    return;
  }

  care_pkg = spawn("script_model", spawnpoint.origin);
  care_pkg.angles = spawnpoint.angles;
  interaction_offset = (0, 0, 35);
  var_f1b21d47f7e81f45 = "show";
  var_1fadb16c673c2c10 = undefined;
  var_fd0b63c63d9fcc8c = undefined;

  if(!istrue(use_milcrate)) {
    care_pkg setModel("military_carepackage_01_uk");
    brushmodel = getEnt("care_package_col", "targetname");
    collisionmodel = spawn("script_model", spawnpoint.origin);
    collisionmodel.angles = spawnpoint.angles;
    collisionmodel clonebrushmodeltoscriptmodel(brushmodel);
    collisionmodel linkTo(care_pkg);
    care_pkg.collision = collisionmodel;

    if(isDefined(checkpoint) && checkpoint == "strongbox") {
      level.checkpoint = "strongbox";
      interaction_offset += (-10, 25, 0);
      var_1fadb16c673c2c10 = (10, -25, 35);
    }
  } else {
    care_pkg setModel("military_hq_crate_01_proxy_cp_spawnable");
    care_pkg setscriptablepartstate("main", "on");
    care_pkg.use_milcrate = 1;
    interaction_offset += rotatevector((18.5, 16.6, 2), care_pkg.angles);
    var_f1b21d47f7e81f45 = "hide";
    var_1fadb16c673c2c10 = (0, 0, 35) + rotatevector((18.5, -14.6, 2), care_pkg.angles);
  }

  level thread checkpoint_carepackage_munitions_role_init(var_1fadb16c673c2c10, spawnpoint, care_pkg, override_waittill, override_timer, use_milcrate, var_f1b21d47f7e81f45);
  var_e88f6961175998ce = spawn("script_model", spawnpoint.origin + interaction_offset);
  var_e88f6961175998ce setModel("tag_origin");
  var_e88f6961175998ce sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_MUNITIONS", 1, "duration_short", var_f1b21d47f7e81f45, 256, 75, 128, 75);
  care_pkg.interaction = var_e88f6961175998ce;
  var_e88f6961175998ce.care_pkg = care_pkg;
  var_e88f6961175998ce.munitions_override_waittill = override_waittill;
  var_e88f6961175998ce.munitions_override_time = override_timer;
  var_e88f6961175998ce.use_milcrate = use_milcrate;
  var_e88f6961175998ce thread checkpoint_carepackage_munitions_think(care_pkg);
  return care_pkg;
}

function checkpoint_carepackage_munitions_role_init(var_1fadb16c673c2c10, spawnpoint, care_pkg, override_waittill, override_timer, use_milcrate, var_f1b21d47f7e81f45) {
  level endon("game_ended");

  if(isDefined(var_1fadb16c673c2c10)) {
    var_4bef6b7f5a69864f = spawn("script_model", spawnpoint.origin + var_1fadb16c673c2c10);
    var_4bef6b7f5a69864f setModel("tag_origin");

    if(!isDefined(var_f1b21d47f7e81f45)) {
      var_f1b21d47f7e81f45 = "hide";
    }

    var_4bef6b7f5a69864f sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_ROLE", 1, "duration_short", var_f1b21d47f7e81f45, 256, 75, 128, 75);
    care_pkg.role_interaction = var_4bef6b7f5a69864f;
    var_4bef6b7f5a69864f.care_pkg = care_pkg;
    var_4bef6b7f5a69864f.munitions_override_waittill = override_waittill;
    var_4bef6b7f5a69864f.munitions_override_time = override_timer;
    var_4bef6b7f5a69864f.use_milcrate = use_milcrate;
    var_4bef6b7f5a69864f thread checkpoint_carepackage_munitions_role_think(care_pkg);
  }
}

function checkpoint_carepackage_munitions_think(carepackage) {
  self endon("death");
  carepackage endon("death");
  thread checkpoint_edit_munitions_icon_init();
  thread checkpoint_edit_munitions_limit_init();

  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(istrue(player.disable_purchase_munitions)) {
      continue;
    }

    player thread checkpoint_edit_munitions(self);
  }
}

function checkpoint_carepackage_munitions_role_think(carepackage, type) {
  self endon("death");
  carepackage endon("death");
  thread checkpoint_edit_role_limiter();

  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(istrue(player.disable_purchase_munitions)) {
      continue;
    }

    player thread checkpoint_edit_role(self);
  }
}

function checkpoint_edit_role_limiter() {
  level endon("game_ended");
  level waittill("close_munitions_store");
  self makeunusable();
}

function checkpoint_edit_munitions_limit_init() {
  level endon("game_ended");
  level endon("close_munitions_store");

  while(true) {
    level waittill("player_spawned", player);
    level thread checkpoint_edit_munitions_limiter(player, self);
  }
}

function checkpoint_edit_munitions_icon_init() {
  level endon("game_ended");
  flag_wait("objectives_registered");
  flag_wait("strike_init_done");
  var_4c87400544dc7457 = 38;

  if(istrue(self.use_milcrate)) {
    var_4c87400544dc7457 = 22;
  }

  self.objicon = scripts\cp\cp_objectives::requestworldid("munitions_purchase", 25);
  objective_setplayintro(self.objicon, 0);
  objective_setbackground(self.objicon, 1);
  objective_state(self.objicon, "invisible");
  objective_icon(self.objicon, "hud_icon_survival_killstreak_small");
  org = self.origin;

  if(isDefined(level.checkpoint) && level.checkpoint == "strongbox") {
    var_4c87400544dc7457 = 75;
    org = self.care_pkg.origin;
  }

  objective_position(self.objicon, org + (0, 0, var_4c87400544dc7457));
  objective_setshowdistance(self.objicon, 0);
  objective_sethot(self.objicon, 0);
  objective_setpinned(self.objicon, 0);
  objective_hidefromplayersinmask(self.objicon);
  objective_removeallfrommask(self.objicon);
  flag_wait("player_spawned_with_loadout");
  wait 2.5;
  progress = 1;
  var_d19e041c9e06acbe = 60;
  waittime = 0.1;

  if(isDefined(self.munitions_override_time)) {
    var_d19e041c9e06acbe = self.munitions_override_time;
  }

  var_9a856ea56a94e11e = waittime / var_d19e041c9e06acbe;

  if(isDefined(self.munitions_override_waittill)) {
    level waittill(self.munitions_override_waittill);
  }

  objective_showprogressforteam(self.objicon, "allies");

  while(progress > 0) {
    objective_setprogress(self.objicon, progress);
    wait waittime;
    progress -= var_9a856ea56a94e11e;

    if(progress < 0) {
      progress = 0;
    }
  }

  level notify("close_munitions_store");
  self makeunusable();

  foreach(player in level.players) {
    if(player getclientomnvar("cp_open_cac") == 3) {
      player setclientomnvar("cp_open_cac", -2);
    }
  }

  if(istrue(self.use_milcrate)) {
    self.care_pkg setscriptablepartstate("main", "off");
  } else {
    self.care_pkg setscriptablepartstate("anims", "capture", 0);
    self.care_pkg setscriptablepartstate("capture", "start", 0);
    self.care_pkg.collision delete();
  }

  scripts\cp\cp_objectives::freeworldid("munitions_purchase");
}

function checkpoint_edit_munitions_limiter(player, carepackage_interaction) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  level endon("close_munitions_store");

  if(istrue(player.tracking_munitions_purchase)) {
    return;
  }

  player.tracking_munitions_purchase = 1;
  wait 3;

  while(true) {
    var_1652ce42e6fcf832 = distance2dsquared(player.origin, carepackage_interaction.origin);

    if(isDefined(var_1652ce42e6fcf832) && var_1652ce42e6fcf832 > 262144) {
      if(!istrue(player.hiding_munitions_purchase)) {
        objective_addclienttomask(carepackage_interaction.objicon, player);
        player.hiding_munitions_purchase = 1;
      }
    } else if(isDefined(var_1652ce42e6fcf832) && var_1652ce42e6fcf832 <= 262144) {
      if(isDefined(player.hiding_munitions_purchase)) {
        objective_removeclientfrommask(carepackage_interaction.objicon, player);
        player.hiding_munitions_purchase = undefined;
      }
    }

    wait 0.5;
  }
}

function checkpoint_edit_munitions(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  interaction disableplayeruse(self);
  self setclientomnvar("cp_open_cac", 3);
  wait 1;
  interaction enableplayeruse(self);
}

function checkpoint_edit_role(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  interaction disableplayeruse(self);
  self.role_edit = 1;
  self setclientomnvar("cp_open_cac", 5);
  wait 1;
  interaction enableplayeruse(self);
}

function checkpoint_add_spawnpoint(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "player_spawn";
  s.checkpoint = checkpoint;
  return s;
}

function function_51b0d14867f16470(mission, checkpoint, targetname) {
  if(!isDefined(level.var_2a02072872ccd8a1)) {
    return;
  }

  if(!isDefined(level.var_2a02072872ccd8a1[mission])) {
    return;
  }

  if(!isDefined(level.var_2a02072872ccd8a1[mission][checkpoint])) {
    return;
  }

  level.var_2a02072872ccd8a1[mission][checkpoint].var_23c5a6352ce4150e = targetname;
}

function checkpoint_addspawnpoints(checkpoint, targetname) {
  level.checkpoint_spawnpoints[checkpoint] = getStructArray(targetname, "targetname");
}

function function_16f5e35ccefe859e() {
  return self.pers["checkpoint_spawnpoint"];
}

function function_5b0a03741aa420d7() {
  foreach(player in level.players) {
    struct = spawnStruct();
    struct.angles = player getplayerangles(1);
    struct.origin = player getorigin();
    player.pers["checkpoint_spawnpoint"] = struct;
  }
}

function function_903f68999f98fa78() {
  self.pers["checkpoint_spawnpoint"] = undefined;
}

function checkpoint_getspawnpoint(checkpoint) {
  if(getdvarint(@ "hash_ef675b8b6b09b0f", 1)) {
    spawnpoint = function_16f5e35ccefe859e();

    if(isDefined(spawnpoint)) {
      spawnpoint.inuse = 1;
      return spawnpoint;
    }

    if(isDefined(level.checkpoint_spawnpoints[checkpoint])) {
      spawnpoints = level.checkpoint_spawnpoints[checkpoint];

      if(isfunction(level.checkpoint_spawnpoints[checkpoint])) {
        spawnpoints = [[level.checkpoint_spawnpoints[checkpoint]]]();
      }

      foreach(spawnpoint in spawnpoints) {
        if(!istrue(spawnpoint.inuse)) {
          spawnpoint.inuse = 1;
          return spawnpoint;
        }
      }
    }
  }

  return undefined;
}

function checkpoint_add_carepackage(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "carepackage";
  s.checkpoint = checkpoint;
  return s;
}

function checkpoint_add_carepackage_munitions(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "carepackage_munitions";
  s.checkpoint = checkpoint;
  return s;
}

function function_4bfef22c47a65be5(checkpoint) {
  cmd = "devgui_cmd \"CP Debug:2 / Checkpoints / " + checkpoint + "\" \"set scr_checkpoint_debug checkpoint_:" + checkpoint + "\" \n";
  addentrytodevgui(cmd);
}

function function_7d2ee45f1241a17a(debug_ref) {
  flag_wait("<dev string:xe8>");
  items = strtok(debug_ref, "<dev string:xff>");
  params = strtok(debug_ref, "<dev string:x101>");
  playertoks = strtok(debug_ref, "<dev string:x103>");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[1]);
    player = level.players[playerint];
  }

  switch (items[0]) {
    case #"hash_1da4229a165378a0":
      function_5ace495feba111d3();

      foreach(player in level.players) {
        player scripts\cp\cp_checkpoint::function_903f68999f98fa78();
      }

      break;
    case #"hash_c62ca67d7a04c8df":
      if(params.size > 1) {
        checkpoint_string = params[1];
      } else {
        if(!isDefined(level.var_3e7e946ee7aef4e8)) {
          level.var_3e7e946ee7aef4e8 = 0;
        }

        checkpoint_string = "<dev string:x116>" + level.var_3e7e946ee7aef4e8;
        level.var_3e7e946ee7aef4e8++;
      }

      checkpoint_set(checkpoint_string);
      break;
    default:
      break;
  }
}

# /