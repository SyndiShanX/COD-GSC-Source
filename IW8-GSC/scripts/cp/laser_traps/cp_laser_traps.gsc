/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\laser_traps\cp_laser_traps.gsc
*****************************************************/

function stopinteract() {
  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["team3"] = [];
  level.spawn_funcs["neutral"] = [];
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["axis"] = &spawn_team_axis;
  level.team_specific_spawn_functions["allies"] = &spawn_team_allies;
  level.team_specific_spawn_functions["team3"] = &spawn_team_team3;
  level.team_specific_spawn_functions["neutral"] = &spawn_team_neutral;
  level.default_goalradius = 2048;
  level.default_goalheight = 512;
  level.spawned_enemies = [];
  level.spawned_allies = [];
  level.spawnloopupdatefunc = &ref_135C0;
  add_global_spawn_function("allies", &avoidclosetodefenderflagspawn);
  add_global_spawn_function("axis", &ref_13DFA);
  add_global_spawn_function("axis", &scripts\mp\mp_agent_damage::stoppingpower_clearhcrdata);
}

function avoidclosetodefenderflagspawn() {
  self.headicon = thread scripts\cp\utility::ent_createheadicon(self, 10, "allies", "hud_icon_head_equipment_friendly", 0);
  setheadiconsnaptoedges(self.headicon, 2000);
  setheadiconmaxdistance(self.headicon, 25);
}

function ref_13DFA() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemytargetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(self, var_2.enemytargetmarkergroup, 1);
    }
  }
}

function add_global_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  GscBinSkip0(0x2e, "function", var_1);
}

function remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.spawn_funcs[var_0].size; var_3++) {
    if(level.spawn_funcs[var_0][var_3]["function"] != var_1) {
      var_2 = level.spawn_funcs[var_0][var_3];
    }
  }

  level.spawn_funcs[var_0] = var_2;
}

function exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.spawn_funcs)) {
    return false;
  }

  for(var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
    if(level.spawn_funcs[var_0][var_2]["function"] == var_1) {
      return true;
    }
  }

  return false;
}

function remove_spawn_function(var_0) {
  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }

  var_1 = [];

  foreach(var_3 in self.spawn_functions) {
    if(var_3["function"] == var_0) {
      continue;
    }

    var_1 = var_3;
  }

  self.spawn_functions = var_1;
}

function add_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }

  foreach(var_7 in self.spawn_functions) {
    if(var_7["function"] == var_0) {
      return;
    }
  }

  var_9 = [];
  GscBinSkip0(0x2e, "function", var_0);
}

function array_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0) {
    thread add_spawn_function(var_7, var_1, var_2, var_3, var_4);
  }
}

function array_spawn_function_targetname(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getStructArray(var_0, "targetname");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

function array_spawn_function_noteworthy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

function array_spawn_targetname(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  return can_spawn_extras(var_3, var_1, var_2);
}

function array_spawn_noteworthy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  return can_spawn_extras(var_3, var_1, var_2);
}

function can_spawn_extras(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 10;
  }

  var_4 = [];
  var_5 = 0;

  foreach(var_7 in var_0) {
    var_7.count = 1;

    if(isDefined(var_7.classname) && getsubstr(var_7.classname, 7, 10) == "veh") {
      var_8 = var_7 scripts\common\utility::spawn_vehicle();

      if(isDefined(var_8.target) && !isDefined(var_8.script_moveoverride)) {
        var_8 thread scripts\common\vehicle_paths::gopath();
      }

      var_4 = var_8;
    } else {
      var_8 = spawn_ai(var_7);

      if(var_2) {}

      var_4 = var_8;
    }

    if(var_5 < var_0.size - 1) {
      wait 1 / var_3;
    }

    var_5++;
  }

  if(var_2) {}

  return var_4;
}

function spawn_ai(var_0) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait self.script_delay_spawn;
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 1;
  var_5 = ref_134F1(self.script_type, self.origin, self.angles, var_2, var_3);

  if(isalive(var_5)) {
    if(isDefined(var_0) && var_0 && isalive(var_5)) {
      var_5 scripts\common\ai::magic_bullet_shield();
    }
  }

  return var_5;
}

function put_headicon_on_tv_station_boss() {
  var_0 = getaiarray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function pushpointoutofkothattractions() {
  var_0 = put_headicon_on_tv_station_boss();
  return var_0.size;
}

function ref_134F1(var_0, var_1, var_2, var_3, var_4) {
  if(pushpointoutofkothattractions() >= level.ref_11B51) {
    return undefined;
  }

  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_0, var_1, var_2);

  if(isDefined(var_5)) {
    ref_134E8(var_5);
    var_5 scripts\cp\stealth\manager::spawn_think(self);
    var_5 thread scripts\cp\stealth\manager::run_spawn_functions(self.spawn_functions);

    if(var_5.unittype != "civilian") {
      var_5 thread scripts\cp\cp_battlechatter_ai::addtosystem();
      var_5 thread scripts\cp\cp_squadmanager::addtosquad();
    }
  }

  return var_5;
}

function ref_134E8() {
  if(isDefined(self.team)) {
    if(self.team == "axis") {
      level.spawned_enemies[level.spawned_enemies.size] = self;
      return;
    }

    if(self.team == "allies") {
      level.spawned_allies[level.spawned_allies.size] = self;
      return;
    }

    return;
  }
}

function ref_135C0(var_0, var_1) {
  if(self.team == "axis") {
    level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
    return;
  }

  if(self.team == "allies") {
    level.spawned_allies = scripts\engine\utility::array_remove(level.spawned_allies, self);
    return;
  }
}

function spawn_team_allies() {
  self.usechokepoints = 0;
}

function spawn_team_axis() {
  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
    return;
  }
}

function spawn_team_team3() {
  spawn_team_axis();
}

function spawn_team_neutral() {}

function ks_pointstowin() {
  self.nocorpse = 1;
  self.diequietly = 1;
  self kill();
}

function go_to_node(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = scripts\cp\stealth\manager::get_target_goals(self.target);

    if(var_0.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  scripts\cp\stealth\manager::go_to_node_internal(var_0, var_1, var_2);
}

function get_least_used_from_array(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1.used_time)) {
    var_1.used_time = 0;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.used_time)) {
      var_3.used_time = 0;
    }

    if(var_3.used_time < var_1.used_time) {
      var_1 = var_3;
    }
  }

  var_1.used_time = gettime();
  return var_1;
}

function disable_long_death() {
  self.a.disablelongdeath = 1;
}

function enable_long_death() {
  self.a.disablelongdeath = 0;
}

function set_goal_pos(var_0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(var_0);
}

function set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;

  if(isstruct(var_0) && !isDefined(var_0.type)) {
    var_0.type = "struct";
    return;
  }
}

function set_goal_volume() {
  self endon("death");
  waittillframeend();

  if(isDefined(self.team) && self.team == "allies") {
    self.fixednode = 0;
  }

  var_0 = level.goalvolumes[self.script_goalvolume];

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getEnt(var_0.target, "targetname");
    var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_4 = undefined;

    if(isDefined(var_1)) {
      var_4 = var_1;
      set_goal_node(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      set_goal_pos(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      set_goal_pos(var_4.origin);
    }

    if(isDefined(var_4.radius) && var_4.radius != 0) {
      self.goalradius = var_4.radius;
    }

    if(isDefined(var_4.goalheight) && var_4.goalheight != 0) {
      self.goalheight = var_4.goalheight;
    }
  }

  if(isDefined(self.target)) {
    self setgoalvolume(var_0);
    return;
  }

  self setgoalvolumeauto(var_0, get_cover_volume_forward(var_0));
}

function set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

function disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

function get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw)) {
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  }

  return undefined;
}

function set_moveplaybackrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(var_1)) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_3 = var_0 - var_2;
    var_4 = 0.05;
    var_5 = var_1 / var_4;
    var_6 = var_3 / var_5;

    while(abs(var_0 - var_2) > abs(var_6 * 1.1)) {
      scripts\asm\asm::asm_setmoveplaybackrate(var_2 + var_6);
      wait var_4;
      var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(var_0);
}

function teamanchoredwidgetinstances() {
  var_0 = scripts\engine\utility::getStructArray("weapon_spawn", "targetname");

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2.weaponinfo, "+");
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_remove(var_3, var_4);
    var_6 = scripts\cp\cp_weapon::buildweapon(var_4, var_5);
    var_7 = "weapon_" + var_4;
    var_8 = scripts\cp\utility::array_merge(var_6.attachments, var_5);

    foreach(var_10 in var_8) {
      var_7 += "+" + var_10;
    }

    var_12 = spawn(var_7, var_2.origin, 1);
    var_12.angles = var_2.angles;
    var_12 scripts\anim\shared::setscriptammo(var_4, var_2);
  }
}

function ref_139AA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawn("script_model", var_0);
  var_10.angles = var_1;

  if(isDefined(var_3)) {
    var_10 setModel(var_3);
  } else {
    var_10 setModel("offhand_wm_supportbox");
  }

  ref_139A9(var_10);
  thread ref_139AC(var_10, var_2, var_8);
  thread ref_139AB(var_10, var_4, var_5, var_6, var_7, var_9);
  return var_10;
}

function ref_139A9(var_0) {
  var_0 setCursorHint("HINT_NOICON");
  var_0 sethintdisplayrange(256);
  var_0 setuserange(84);
  var_0 setusefov(180);
  var_0 sethintdisplayfov(180);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");
  var_0 sethintrequiresholding(0);
  var_0 setusepriority(0);
  var_0 makeusable();
}

function ref_139AC(var_0, var_1, var_2) {
  var_0 endon("entitydeleted");
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }

    GscBinSkip1(0x74, var_1, var_0, var_4);
  }
}

function ref_139A8(var_0) {
  if(var_0 == "offhand_wm_supportbox") {
    return true;
  }

  if(var_0 == "offhand_wm_supportbox_ammunition") {
    return true;
  }

  if(var_0 == "offhand_wm_supportbox_explosives") {
    return true;
  }

  return false;
}

function ref_139AB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("entitydeleted");

  if(!isDefined(var_5)) {
    var_5 = &"COOP_GAME_PLAY/AMMO_MAX_RED";
  }

  var_0 setHintString(var_1);
  var_6 = spawn("script_origin", var_0.origin);
  ref_139A9(var_6);
  var_6 setHintString(var_5);
  var_0.headiconid = scripts\cp\utility::ent_createheadicon(var_0, 15, "allies", var_2, 1);
  setheadiconsnaptoedges(var_0.headiconid, 1500);
  setheadiconmaxdistance(var_0.headiconid, 15);
  var_7 = var_0 getentitynumber();
  var_8 = 0.1;

  for(;;) {
    foreach(var_10 in level.players) {
      if(!isDefined(var_10.ref_139B4)) {
        var_10.ref_139B4 = [];
      }

      if(scripts\cp\cp_endgame::gamealreadyended()) {
        foreach(var_10 in level.players) {
          removeteamfromheadiconmask(var_0.headiconid, var_10);
          return 1;
        }
      }

      var_13 = !isDefined(var_10.ref_139B4[var_7]) || !var_10.ref_139B4[var_7];
      var_14 = !isDefined(var_10.ref_139B4[var_7]) || var_10.ref_139B4[var_7];

      if(var_13 && [[var_4]](var_10)) {
        var_10 notify("support_box_update_player" + var_7);
        removeteamfromheadiconmask(var_0.headiconid, var_10);
        var_0 disableplayeruse(var_10);
        GscBinSkip4(0x35, var_10, var_0, var_6, var_7);
      }

      if(var_14 && ![[var_4]](var_10)) {
        var_10 notify("support_box_update_player" + var_7);
        addteamtoheadiconmask(var_0.headiconid, var_10);
        var_0 enableplayeruse(var_10);
        var_6 disableplayeruse(var_10);
        var_10.ref_139B4[var_0 getentitynumber()] = 0;
      }
    }

    wait var_8;
  }
}

function ref_139A5(var_0, var_1, var_2, var_3) {
  var_0 endon("support_box_update_player" + var_3);
  wait 2;
  var_2 enableplayeruse(var_0);
}

function brplayerhudoutlineforteammatesupdate(var_0, var_1) {
  return ref_139AA(var_0, var_1, &brpreplayerdamaged, "offhand_wm_supportbox_ammunition", &"COOP_CRAFTING/AMMO_CRATE_TAKE", "cp_crate_icon_ammo", "cp_crate_icon_ammo_red", &ref_124B0);
}

function brpreplayerdamaged(var_0, var_1) {
  var_2 = var_1 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_4) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_4)) {
      continue;
    }

    var_1 givemaxammo(var_4);
  }

  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function handle_leads_collected_hideiconbuilding(var_0, var_1) {
  return ref_139AA(var_0, var_1, &handle_no_ammo_mun, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/CLAYMORE", "hud_icon_equipment_claymore", "hud_icon_equipment_claymore_red", &handle_just_keep_moving);
}

function handle_no_ammo_mun(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_claymore", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function handle_just_keep_moving(var_0) {
  return ref_12470(var_0, "power_claymore");
}

function binoculars_getpendingtime(var_0, var_1) {
  return ref_139AA(var_0, var_1, &binoculars_giveassistpoints, "lm_heal_first_aid_kit_01", &"CP_SO_FINALE/PICKUP_STIMS", "hud_icon_equipment_stim", "hud_icon_equipment_stim_red", &binoculars_getpendingendtime);
}

function binoculars_giveassistpoints(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("equip_adrenaline", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function binoculars_getpendingendtime(var_0) {
  return ref_12470(var_0, "equip_adrenaline");
}

function ref_11CB8(var_0, var_1) {
  return ref_139AA(var_0, var_1, &ref_11CBA, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/MOLOTOV", "hud_icon_equipment_molotov", "hud_icon_equipment_molotov_red", &ref_11CB7);
}

function ref_11CBA(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_molotov", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function ref_11CB7(var_0) {
  return ref_12470(var_0, "power_molotov");
}

function playerplunderlosedepositcallback(var_0, var_1) {
  return ref_139AA(var_0, var_1, &playerplunderpickup, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/FRAG", "hud_icon_equipment_frag", "hud_icon_equipment_frag_red", &playerplunderlosedeposit);
}

function playerplunderpickup(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_frag", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function playerplunderlosedeposit(var_0) {
  return ref_12470(var_0, "power_frag");
}

function focus_fire_outline_enabled(var_0, var_1, var_2) {
  return ref_139AA(var_0, var_1, &fogenabled, "offhand_wm_supportbox_explosives", &"EQUIPMENT_HINTS/PICKUP_C4", "hud_icon_equipment_c4", "hud_icon_equipment_c4_red", &focus_fire_is_activated);
}

function fogenabled(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_c4", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function focus_fire_is_activated(var_0) {
  return ref_12470(var_0, "power_c4");
}

function player_limitedammo(var_0, var_1) {
  return ref_139AA(var_0, var_1, &player_max_exposure_time, "offhand_wm_supportbox", &"COOP_CRAFTING/FLASH", "hud_icon_equipment_flash", "hud_icon_equipment_flash_red", &player_latespawn_safehouse);
}

function player_max_exposure_time(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_flash", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function player_latespawn_safehouse(var_0) {
  return ref_12470(var_0, "power_flash");
}

function ref_13433(var_0, var_1) {
  return ref_139AA(var_0, var_1, &ref_13434, "offhand_wm_supportbox", &"EQUIPMENT/SNAPSHOT_GRENADE", "hud_icon_equipment_snapshot", "hud_icon_equipment_snapshot_red", &ref_13432);
}

function ref_13434(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("power_snapshotGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function ref_13432(var_0) {
  return ref_12470(var_0, "power_snapshotGrenade");
}

function plunderfxondropthreashold(var_0, var_1) {
  return ref_139AA(var_0, var_1, &plunderinstanceid, "offhand_wm_supportbox", &"EQUIPMENT/GAS", "hud_icon_equipment_gas", "hud_icon_equipment_gas", &plunderforextract);
}

function plunderinstanceid(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("equip_gas_grenade", "secondary", undefined, undefined, undefined, undefined, 1, 2);
  var_1 forceplaygestureviewmodel("ges_swipe", var_0);
  var_1 playlocalsound("weap_ammo_pickup");
}

function plunderforextract(var_0) {
  return ref_12470(var_0, "equip_gas_grenade");
}

function trial_active_fob(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_4 = "device_laptop_01_open";

  if(isDefined(var_1)) {
    var_3.angles = var_1;
  } else {
    var_3.angles = (0, 0, 0);
  }

  var_3 setModel(var_4);
  var_3 setCursorHint("HINT_BUTTON");
  var_3 setHintString(&"CP_SO_ANIYAH/OBJ_GATHER_INTEL");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(45);
  var_3 setuserange(100);
  var_3 setusefov(40);
  var_3 sethintonobstruction("show");
  var_3 setuseholdduration("duration_none");
  var_3 setusepriority(1);
  var_3 makeusable();
  thread trial_end_flares(var_3, var_2);
  return var_3;
}

function trial_end_flares(var_0, var_1) {
  var_0 endon("entitydeleted");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    GscBinSkip1(0x74, var_1, var_2, var_0);
  }

  var_0 makeunusable();
  var_0 delete();
}

function get_driver_interaction_hint_string(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3;
  var_7 = var_6 + (0, 0, -8000);
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var_9 = physics_raycast(var_6, var_7, var_8, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_9) && var_9.size > 0) {
    var_10 = var_9[0]["position"];
  } else {
    var_10 = var_4;
  }

  var_11 = var_4 + -1 * anglesToForward(var_3) * var_1;
  var_12 = var_4 + anglesToForward(var_3) * var_2;
  var_13 = scripts\cp_mp\killstreaks\airdrop::createheli(undefined, "allies", var_11, var_3, 0);
  var_13 scripts\common\vehicle::godon();
  var_13 setCanDamage(0);
  var_13 vehicle_setspeed(200, 100);
  var_13 setmaxpitchroll(15, 15);
  var_14 = get_enter_leave_station_time(var_11, var_3);
  var_15 = get_ending_struct(var_14);
  var_16 = get_emp_effect_duration(var_14);
  var_15 linkTo(var_14);
  var_16 linkTo(var_14);
  var_14 linkTo(var_13, "tag_origin", (16, 0, -156), (0, 0, 0));
  var_13 setvehgoalpos(var_4, 1);
  wait 2;
  var_13 setyawspeed(40, 20, 20, 0.3);
  var_13 waittill("goal");
  wait 0.25;
  thread get_evade_start_structs_in_front(var_14, var_15, var_16, var_5, var_6);
  wait 0.5;
  var_13 vehicle_setspeed(150, 50);
  var_13 setvehgoalpos(var_12, 1);
  var_13 waittill("goal");
  var_13 thread scripts\cp_mp\killstreaks\airdrop::destroyheli();
}

function get_evade_start_structs_in_front(var_0, var_1, var_2, var_3, var_4) {
  var_0 unlink();
  var_0 physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_5 = var_0 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_5, (0, 0, -1));
  var_0 physics_registerforcollisioncallback();
  get_explosion_alias(var_0);
  var_0 physicsstopserver();
  var_0 physics_unregisterforcollisioncallback();
  thread get_end_ang(var_0, var_1, var_2, var_3, var_4);
}

function get_explosion_alias(var_0) {
  wait 1;
  var_1 = gettime() + 10000;

  while(gettime() < var_1) {
    var_2 = var_0 physics_getbodyid(0);
    var_3 = physics_getbodylinvel(var_2);

    if(lengthsquared(var_3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function get_end_ang(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createnavobstaclebybounds(var_0.origin, (30, 10, 64), var_0.angles);
  var_6 = var_0 scripts\cp\utility::killstreak_createobjective("icon_minimap_carepackage", "allies", 1, 1, 0);
  var_7 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_7, "hud_icon_head_killstreak_carepackage");
  addclienttoheadiconmask(var_7, -7);
  setheadiconmaxdistance(var_7, 0);
  setheadiconsnaptoedges(var_7, 6250);
  setheadiconowner(var_7, undefined);
  setheadiconzoffset(var_7, 1);
  hideheadiconfromplayersinmask(var_7);
  var_0.headicon = var_7;
  var_0 playSound("mp_care_package_med_impact");
  var_0 setCursorHint("HINT_NOICON");
  var_0 sethintdisplayrange(256);
  var_0 setuserange(100);
  var_0 setusefov(180);
  var_0 sethintdisplayfov(180);
  var_0 setuseholdduration("duration_short");
  var_0 setusepriority(0);
  var_0 sethintonobstruction("show");
  var_0 sethinttag("tag_use");
  var_0 makeusable();
  var_0 setHintString(&"KILLSTREAKS_HINTS/CRATE_PICKUP");

  for(;;) {
    var_0 waittill("trigger", var_8);

    if(!isPlayer(var_8)) {
      continue;
    }

    if(ref_124D0(var_8)) {
      thread logevent_givecpweaponxp(var_8, &"CP_BR/MUN_SLOTS_FULL", 3);
      continue;
    }

    if(isDefined(var_3)) {
      ref_124A5(var_8, var_3);
    }

    if(isDefined(var_4)) {
      GscBinSkip1(0x74, var_4, var_8, var_0.origin, var_3);
    }

    break;
  }

  var_9 = (0, 0, -44);
  var_2 unlink();
  var_2.origin += var_9;
  var_0 unlink();
  var_0.origin += var_9;
  var_1 unlink();
  var_0 makeunusable();
  setheadiconimage(var_7);
  var_0.headicon = undefined;
  var_1 setscriptablepartstate("anims", "capture", 0);
  var_1 setscriptablepartstate("capture", "start", 0);
  objective_state(var_6, "done");
  scripts\cp\utility::nonobjective_returnobjectiveid(var_6);
  wait 2;
  destroynavobstacle(var_5);
  var_2 delete();
  var_1 delete();
  var_0 delete();
}

function get_enter_leave_station_time(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("military_carepackage_01_dummy");
  var_2 setnodeploy(1);
  var_2 setCanDamage(0);
  var_2 makeunusable();
  var_2.targetname = "carepackage";
  return var_2;
}

function get_drone_target_loc() {
  return getEntArray("carepackage", "targetname");
}

function get_ending_struct(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("military_carepackage_01_friendly");
  var_1 setnodeploy(1);
  var_1 setCanDamage(0);
  var_1 makeunusable();
  var_1 linkTo(var_0);
  return var_1;
}

function get_emp_effect_duration(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0.angles;
  var_2 = getEnt("care_package_col", "targetname");
  var_1 clonebrushmodeltoscriptmodel(var_2);
  var_1 linkTo(var_0);
  return var_1;
}

function ref_124A5(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_0);

  if(isDefined(var_2)) {
    var_3 = var_2;
    var_0 scripts\cp\cp_munitions::give_munition_to_slot(var_1, var_3);
    return;
  }

  var_0 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function ref_124AF(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "riotshield") {
      continue;
    }

    var_4 = var_0 getweaponammostock(var_3);

    if(var_4 < weaponmaxammo(var_3)) {
      return false;
    }

    var_5 = var_0 getweaponammoclip(var_3);

    if(var_5 < weaponclipsize(var_3)) {
      return false;
    }
  }

  return true;
}

function ref_124B0(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "riotshield") {
      continue;
    }

    var_4 = var_0 getweaponammostock(var_3);

    if(var_4 < weaponmaxammo(var_3)) {
      return false;
    }
  }

  return true;
}

function can_play_ending(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    foreach(var_4 in var_0) {
      if(scripts\engine\utility::is_equal(var_4.script_index, var_2)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }
    }
  }

  var_6 = scripts\engine\utility::array_remove_array(var_0, var_1);
  var_1 = scripts\cp\utility::array_merge(var_1, var_6);
  return var_1;
}

function ref_12F55(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  level.struct[level.struct.size] = var_2;
  return var_2;
}

function ref_12F56(var_0) {
  if(!isDefined(level.checkpoint_player_spawns)) {
    level.checkpoint_player_spawns = 0;
  } else {
    level.checkpoint_player_spawns++;
  }

  var_1 = "autoStruct" + level.checkpoint_player_spawns;
  self.target = var_1;
  var_0.targetname = var_1;
}

function ref_12486(var_0) {
  var_0.ability_invulnerable = 1;
}

function ref_12484(var_0) {
  var_0.ability_invulnerable = undefined;
}

function print_spawner_score_for_factor() {
  return self.baseaccuracy;
}

function set_baseaccuracy(var_0) {
  self.baseaccuracy = var_0;
}

function ref_143A1() {
  while(pushpointoutofkothattractions() > 0) {
    waitframe();
  }
}

function logevent_downed(var_0, var_1) {
  foreach(var_3 in level.players) {
    thread logevent_givecpweaponxp(var_3, var_0, var_1);
  }
}

function logevent_givecpweaponxp(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 sethudtutorialmessage(var_1);
  wait var_2;
  var_0 clearhudtutorialmessage();
}

function ref_124D0(var_0) {
  var_1 = var_0 getplayerdata("cp", "inventorySlots", "totalSlots");
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(!isDefined(var_0.munition_slots)) {
      continue;
    }

    if(!isDefined(var_0.munition_slots[var_3])) {
      continue;
    }

    if(var_0 scripts\cp\loot_system::is_empty_or_none(var_3)) {
      continue;
    }

    var_2++;
  }

  return var_1 == var_2;
}

function ref_12470(var_0, var_1) {
  return isDefined(var_0.powers) && isDefined(var_0.powers[var_1]) && var_0.powers[var_1].charges == var_0.powers[var_1].maxcharges;
}

#using_animtree("script_model");

function ref_124E9(var_0, var_1) {
  var_0.animname = var_1;
  var_2 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_2 hide();
  var_2.animname = var_1;
  var_2 useanimtree(#animtree);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  return var_2;
}

#using_animtree("scriptables");

function ref_139A7() {
  return getanimlength(%wm_supportbox_ground_open);
}

#using_animtree("");

function ref_139A6() {
  return getanimlength(%wm_supportbox_ground_close);
}

function ref_13067() {
  level.autoassignlowteamconsistent = gettime();
}

function init_minigun_lifetime_shot_count(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawncovernode(var_1, var_3, "begin", 0, var_0, undefined, var_4);
  var_8 = undefined;

  if(isDefined(var_5)) {
    var_8 = spawn("script_origin", var_5);
    var_8.angles = var_3;
  }

  var_9 = spawncovernode(var_1, var_3, "end", 0, var_0 + "_end", var_0, var_4);

  if(isDefined(var_6)) {
    var_7.animation = var_6;
  }

  var_7.usagecost = 15;
  createnavlink("traverse_" + var_4, var_1, var_2, var_7, "soldier");
  ref_1363C(var_7, var_9, var_8);
  return var_7;
}

function ref_1363C(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  scripts\asm\asm::calculate_traverse_data(var_1.origin, var_0.origin);

  if(isDefined(self.parentname)) {
    scripts\asm\asm::store_original_traverse_data();
  }

  if(isent(var_1)) {
    var_1 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var_1);
}

function ref_14309() {
  if(!isDefined(self.ref_1430C)) {
    self.ref_1430C = [];
    return;
  }
}

function ref_1430A(var_0) {
  ref_14309();
  self.ref_1430C[var_0] = undefined;
}

function ref_1430B(var_0, var_1) {
  if(isDefined(self.ref_1430C[var_0])) {
    return;
  }

  self.ref_1430C[var_0] = var_1;
}

function ref_1430D() {
  level.ref_14312 = [];
}

function ref_1430E(var_0, var_1) {
  if(isDefined(level.ref_14312[var_0])) {
    return;
  }

  foreach(var_3 in level.players) {
    ref_1430A(var_3, var_0);
  }

  level.ref_14312[var_0] = 1;
  thread ref_1430F(level, var_0);
}

function ref_1430F(var_0, var_1) {
  var_2 = 0;
  var_3 = gettime() + var_1 * 1000;
  var_4 = -1;
  var_5 = -1;
  var_6 = -1;
  waitframe();

  while(gettime() < var_3) {
    if(level.gameended) {
      var_2 = 0;
      break;
    }

    var_7 = int((var_3 - gettime()) * 0.001);

    if(var_7 != var_5) {
      var_5 = var_7;
      ref_14311(var_7);
    }

    foreach(var_9 in level.players) {
      if(!isDefined(var_9.ref_1430C)) {
        ref_1430A(var_9, var_0);
      }
    }

    var_11 = 0;

    foreach(var_9 in level.players) {
      if(!isDefined(var_9.ref_1430C)) {
        ref_1430A(var_9, var_0);
      }

      if(istrue(var_9.ref_1430C[var_0])) {
        var_11++;
      }
    }

    if(var_11 != var_4 || var_6 != level.players.size + 1) {
      var_4 = var_11;
      var_6 = level.players.size;
      ref_14310(var_11, var_6);
    }

    if(var_11 == level.players.size) {
      var_2 = 1;
      break;
    }

    waitframe();
  }

  if(level.gameended) {
    var_2 = 0;
  }

  level.ref_14312[var_0] = undefined;
  ref_14311(0);
  ref_14310(0, 0);

  foreach(var_9 in level.players) {
    ref_1430A(var_9, "retry");
  }

  if(var_2) {
    scripts\cp\cp_endgame::restart_map(0);
    return;
  }
}

function ref_14311(var_0) {
  setomnvar("ui_votesys_time", var_0);
}

function ref_14310(var_0, var_1) {
  setomnvar("ui_votesys_playervotes", var_0);
  setomnvar("ui_votesys_playercount", var_1);
}

function little_bird_mg_cp_ondeathrespawncallback() {
  if(!istrue(level.nojip)) {
    level.nojip = 1;
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    return;
  }
}

function ref_13542(var_0, var_1, var_2) {
  var_3 = magicgrenademanual("claymore_mp", var_0 + (0, 0, 10), (0, 0, 10));
  GscBinSkip4(0x6e, var_3, var_0, var_1, var_2);
}

function ref_123B2(var_0, var_1, var_2) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = var_1;
  self.owner = spawnStruct();
  self.owner.angles = var_1;
  self.owner.team = "axis";
  self.team = "axis";
  var_3 = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread minedamagemonitor();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  wait 0.1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread intermissionspawnorigin(var_0);
  thread next_subway_track_hurt_time(var_2);
}

function intermissionspawnorigin(var_0) {
  var_1 = var_0 + (0, 0, 50) + anglesToForward(self.angles) * 95;
  var_2 = var_0 + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  var_3 = getaiarray("axis")[0];
  radiusdamage(var_2, 30, 1000, 200, var_3, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(var_1, 100, 1000, 20, var_3, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

function minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  self notify("detonateExplosive", var_0);
}

function next_subway_track_hurt_time(var_0) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    var_2 = level.players;
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoup(self.angles);
    var_5 = self.origin + var_4 * 0;
    var_6 = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(var_8 in level.dynamicladders) {
        var_6 = var_8.ents[0];
      }
    }

    if(istrue(var_0)) {
      var_2 = scripts\engine\utility::array_combine(var_2, getaiarray("allies"));
    }

    foreach(var_11 in var_2) {
      if(!isDefined(var_11)) {
        continue;
      }

      if(isPlayer(var_11) && scripts\cp\cp_laststand::player_in_laststand(var_11) || isagent(var_11) && !isalive(var_11)) {
        continue;
      }

      if(lengthsquared(var_11 getentityvelocity()) < 10) {
        continue;
      }

      if(distance2dsquared(var_11.origin, self.origin) > 50625) {
        continue;
      }

      var_12 = var_11 gettagorigin("j_mainroot");
      var_13 = [var_12];
      var_14 = var_5 - var_12;

      if(vectordot(var_14, (0, 0, 1)) >= 0) {
        var_13 = var_11 gettagorigin("j_spineupper");
      } else {
        var_13 = var_11.origin;
      }

      foreach(var_16 in var_13) {
        var_14 = var_16 - self.origin;
        var_17 = vectordot(var_14, var_3);

        if(var_17 > 192 || var_17 < 20) {
          continue;
        }

        var_18 = vectordot(var_14, var_4);

        if(abs(var_18) > 32) {
          continue;
        }

        var_19 = vectorNormalize(var_14);
        var_20 = vectordot(var_19, var_3);

        if(var_20 < 0.86602) {
          continue;
        }

        var_21 = physics_raycast(var_5, var_16, var_1, var_6, 0, "physicsquery_closest", 1);

        if(isDefined(var_21) && var_21.size > 0) {
          continue;
        }

        thread scripts\cp\cp_claymore::claymore_trigger(var_11);
      }
    }

    wait 0.05;
  }
}

function ref_131F6() {
  initnightvisionheadoverrides();
}

function initnightvisionheadoverrides() {
  if(!scripts\cp\gametypes\cp_survival::allow_nvg()) {
    return;
  }

  level.nvgheadoverrides = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("operatorskins.csv", var_0, 5);
    var_2 = tablelookupbyrow("operatorskins.csv", var_0, 17);
    var_3 = tablelookupbyrow("operatorskins.csv", var_0, 16);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_2 != "") {
      level.nvgheadoverrides[var_1]["up"] = var_2;
    }

    if(var_3 != "") {
      level.nvgheadoverrides[var_1]["down"] = var_3;
    }
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_3"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_4"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["down"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["up"] = "none";
}

function mountain_three_death_func() {
  if(istrue(self.inspawncamera)) {
    scripts\engine\utility::ref_143A5("spawned_player", "fadeUp_start");
  }

  while(!isDefined(self.operatorcustomization)) {
    waitframe();
  }

  thread scripts\cp\equipment\nvg::runnvg();
  self nightvisionviewon(1);
}

function ref_1437A(var_0, var_1) {
  level notify("so_prematch_countdown_started");

  if(!isDefined(var_0)) {
    var_0 = 30;
  }

  var_2 = getdvarint("party_partyPlayerCountNum");
  var_3 = 1;
  var_4 = 0;
  var_5 = undefined;
  jumpiftrue(istrue(var_1)) LOC_00000033;
  var_5 = ref_11B41();

  while(var_0 > -1) {
    if(level.hostdamagefactorlow >= var_2) {
      if(!var_4 && var_0 > 5) {
        var_4 = 1;
        var_0 = 5;
      }
    }

    foreach(var_7 in level.players) {
      var_7 setclientomnvar("ui_hide_hud", 1);
      var_7 setclientomnvar("ui_match_start_countdown", var_0);
    }

    wait 1;
    var_0--;
  }

  scripts\engine\utility::flag_set("so_connect_timer_finished");

  foreach(var_7 in level.players) {
    var_7 setclientomnvar("ui_hide_hud", 0);
    var_7 setclientomnvar("ui_match_start_countdown", 0);
  }

  if(!istrue(var_1)) {
    var_5 fadeovertime(var_3);
    var_5.alpha = 0;
    var_5 scripts\engine\utility::delaycall(var_3, &destroy);
  }

  scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  level notify("so_prematch_countdown_finished");
}

function ref_11B41() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 20;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("black", 640, 480);
  return var_0;
}

function ref_13F98() {
  for(;;) {
    wait 1;

    if(isDefined(self.favoriteenemy)) {
      self getenemyinfo(self.favoriteenemy);
      self setgoalpos(self.favoriteenemy.origin);
      continue;
    }

    if(isDefined(self.enemy)) {
      self getenemyinfo(self.enemy);
      self setgoalpos(self.enemy.origin);
      continue;
    }

    var_0 = vehicle_damage_setvehiclehitdamagedataforweapon();

    if(!isDefined(var_0)) {
      continue;
    }

    self getenemyinfo(var_0);
    self setgoalpos(var_0.origin);
  }
}

function vehicle_damage_setvehiclehitdamagedataforweapon() {
  var_0 = undefined;

  if(isDefined(self.attacker)) {
    var_0 = self.attacker;
    self.attacker = undefined;
  } else {
    var_0 = vehicle_damage_setvehiclehitdamagedata(self.origin);
  }

  return var_0;
}

function vehicle_damage_setvehiclehitdamagedata(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3) || var_3.inlaststand) {
      continue;
    }

    var_1 = var_3;
  }

  var_3 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_3;
}