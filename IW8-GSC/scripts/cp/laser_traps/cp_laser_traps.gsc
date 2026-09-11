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
  level.spawnloopupdatefunc = &ref_135c0;
  add_global_spawn_function("allies", &avoidclosetodefenderflagspawn);
  add_global_spawn_function("axis", &ref_13dfa);
  add_global_spawn_function("axis", &scripts\mp\mp_agent_damage::stoppingpower_clearhcrdata);
}

function avoidclosetodefenderflagspawn() {
  self.headicon = thread scripts\cp\utility::ent_createheadicon(self, 10, "allies", "hud_icon_head_equipment_friendly", 0);
  setheadiconsnaptoedges(self.headicon, 2000);
  setheadiconmaxdistance(self.headicon, 25);
}

function ref_13dfa() {
  var0 = vehicle_getarray();

  foreach(var2 in var0) {
    if(isDefined(var2.enemytargetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(self, var2.enemytargetmarkergroup, 1);
    }
  }
}

function add_global_spawn_function(var0, var1, var2, var3, var4) {
  var5 = [];
  GscBinSkip0(0x2e, "function", var1);
}

function remove_global_spawn_function(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.spawn_funcs[var0].size; var3++) {
    if(level.spawn_funcs[var0][var3]["function"] != var1) {
      var2 = level.spawn_funcs[var0][var3];
    }
  }

  level.spawn_funcs[var0] = var2;
}

function exists_global_spawn_function(var0, var1) {
  if(!isDefined(level.spawn_funcs)) {
    return false;
  }

  for(var2 = 0; var2 < level.spawn_funcs[var0].size; var2++) {
    if(level.spawn_funcs[var0][var2]["function"] == var1) {
      return true;
    }
  }

  return false;
}

function remove_spawn_function(var0) {
  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }

  var1 = [];

  foreach(var3 in self.spawn_functions) {
    if(var3["function"] == var0) {
      continue;
    }

    var1 = var3;
  }

  self.spawn_functions = var1;
}

function add_spawn_function(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }

  foreach(var7 in self.spawn_functions) {
    if(var7["function"] == var0) {
      return;
    }
  }

  var9 = [];
  GscBinSkip0(0x2e, "function", var0);
}

function array_spawn_function(var0, var1, var2, var3, var4, var5) {
  foreach(var7 in var0) {
    thread add_spawn_function(var7, var1, var2, var3, var4);
  }
}

function array_spawn_function_targetname(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::getStructArray(var0, "targetname");
  array_spawn_function(var6, var1, var2, var3, var4, var5);
}

function array_spawn_function_noteworthy(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  array_spawn_function(var6, var1, var2, var3, var4, var5);
}

function array_spawn_targetname(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");
  return can_spawn_extras(var3, var1, var2);
}

function array_spawn_noteworthy(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  return can_spawn_extras(var3, var1, var2);
}

function can_spawn_extras(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 10;
  }

  var4 = [];
  var5 = 0;

  foreach(var7 in var0) {
    var7.count = 1;

    if(isDefined(var7.classname) && getsubstr(var7.classname, 7, 10) == "veh") {
      var8 = var7 scripts\common\utility::spawn_vehicle();

      if(isDefined(var8.target) && !isDefined(var8.script_moveoverride)) {
        var8 thread scripts\common\vehicle_paths::gopath();
      }

      var4 = var8;
    } else {
      var8 = spawn_ai(var7);

      if(var2) {}

      var4 = var8;
    }

    if(var5 < var0.size - 1) {
      wait 1 / var3;
    }

    var5++;
  }

  if(var2) {}

  return var4;
}

function spawn_ai(var0) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait self.script_delay_spawn;
  }

  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = 1;
  var5 = ref_134f1(self.script_type, self.origin, self.angles, var2, var3);

  if(isalive(var5)) {
    if(isDefined(var0) && var0 && isalive(var5)) {
      var5 scripts\common\ai::magic_bullet_shield();
    }
  }

  return var5;
}

function put_headicon_on_tv_station_boss() {
  var0 = getaiarray();
  var1 = [];

  foreach(var3 in var0) {
    if(!isalive(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function pushpointoutofkothattractions() {
  var0 = put_headicon_on_tv_station_boss();
  return var0.size;
}

function ref_134f1(var0, var1, var2, var3, var4) {
  if(pushpointoutofkothattractions() >= level.ref_11b51) {
    return undefined;
  }

  var5 = scripts\mp\mp_agent::spawnnewagentaitype(var0, var1, var2);

  if(isDefined(var5)) {
    ref_134e8(var5);
    var5 scripts\cp\stealth\manager::spawn_think(self);
    var5 thread scripts\cp\stealth\manager::run_spawn_functions(self.spawn_functions);

    if(var5.unittype != "civilian") {
      var5 thread scripts\cp\cp_battlechatter_ai::addtosystem();
      var5 thread scripts\cp\cp_squadmanager::addtosquad();
    }
  }

  return var5;
}

function ref_134e8() {
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

function ref_135c0(var0, var1) {
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

function go_to_node(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = scripts\cp\stealth\manager::get_target_goals(self.target);

    if(var0.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(var0)) {
    var0 = [var0];
  }

  scripts\cp\stealth\manager::go_to_node_internal(var0, var1, var2);
}

function get_least_used_from_array(var0) {
  if(var0.size == 1) {
    return var0[0];
  }

  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0[0];

  if(!isDefined(var1.used_time)) {
    var1.used_time = 0;
  }

  foreach(var3 in var0) {
    if(!isDefined(var3.used_time)) {
      var3.used_time = 0;
    }

    if(var3.used_time < var1.used_time) {
      var1 = var3;
    }
  }

  var1.used_time = gettime();
  return var1;
}

function disable_long_death() {
  self.a.disablelongdeath = 1;
}

function enable_long_death() {
  self.a.disablelongdeath = 0;
}

function set_goal_pos(var0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var0;
  self.last_set_goalent = undefined;
  self setgoalpos(var0);
}

function set_goal_ent(var0) {
  set_goal_pos(var0.origin);
  self.last_set_goalent = var0;

  if(isstruct(var0) && !isDefined(var0.type)) {
    var0.type = "struct";
    return;
  }
}

function set_goal_volume() {
  self endon("death");
  waittillframeend();

  if(isDefined(self.team) && self.team == "allies") {
    self.fixednode = 0;
  }

  var0 = level.goalvolumes[self.script_goalvolume];

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.target)) {
    var1 = getnode(var0.target, "targetname");
    var2 = getEnt(var0.target, "targetname");
    var3 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var4 = undefined;

    if(isDefined(var1)) {
      var4 = var1;
      set_goal_node(var4);
    } else if(isDefined(var2)) {
      var4 = var2;
      set_goal_pos(var4.origin);
    } else if(isDefined(var3)) {
      var4 = var3;
      set_goal_pos(var4.origin);
    }

    if(isDefined(var4.radius) && var4.radius != 0) {
      self.goalradius = var4.radius;
    }

    if(isDefined(var4.goalheight) && var4.goalheight != 0) {
      self.goalheight = var4.goalheight;
    }
  }

  if(isDefined(self.target)) {
    self setgoalvolume(var0);
    return;
  }

  self setgoalvolumeauto(var0, get_cover_volume_forward(var0));
}

function set_goal_node(var0) {
  self.last_set_goalnode = var0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var0);
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

function set_moveplaybackrate(var0, var1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(var1)) {
    var2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var3 = var0 - var2;
    var4 = 0.05;
    var5 = var1 / var4;
    var6 = var3 / var5;

    while(abs(var0 - var2) > abs(var6 * 1.1)) {
      scripts\asm\asm::asm_setmoveplaybackrate(var2 + var6);
      wait var4;
      var2 = scripts\asm\asm::asm_getmoveplaybackrate();
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(var0);
}

function teamanchoredwidgetinstances() {
  var0 = scripts\engine\utility::getStructArray("weapon_spawn", "targetname");

  foreach(var2 in var0) {
    var3 = strtok(var2.weaponinfo, "+");
    var4 = var3[0];
    var5 = scripts\engine\utility::array_remove(var3, var4);
    var6 = scripts\cp\cp_weapon::buildweapon(var4, var5);
    var7 = "weapon_" + var4;
    var8 = scripts\cp\utility::array_merge(var6.attachments, var5);

    foreach(var10 in var8) {
      var7 += "+" + var10;
    }

    var12 = spawn(var7, var2.origin, 1);
    var12.angles = var2.angles;
    var12 scripts\anim\shared::setscriptammo(var4, var2);
  }
}

function ref_139aa(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = spawn("script_model", var0);
  var10.angles = var1;

  if(isDefined(var3)) {
    var10 setModel(var3);
  } else {
    var10 setModel("offhand_wm_supportbox");
  }

  ref_139a9(var10);
  thread ref_139ac(var10, var2, var8);
  thread ref_139ab(var10, var4, var5, var6, var7, var9);
  return var10;
}

function ref_139a9(var0) {
  var0 setCursorHint("HINT_NOICON");
  var0 sethintdisplayrange(256);
  var0 setuserange(84);
  var0 setusefov(180);
  var0 sethintdisplayfov(180);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_short");
  var0 sethintrequiresholding(0);
  var0 setusepriority(0);
  var0 makeusable();
}

function ref_139ac(var0, var1, var2) {
  var0 endon("entitydeleted");
  var3 = 0;

  for(;;) {
    var0 waittill("trigger", var4);

    if(!isPlayer(var4)) {
      continue;
    }

    GscBinSkip1(0x74, var1, var0, var4);
  }
}

function ref_139a8(var0) {
  if(var0 == "offhand_wm_supportbox") {
    return true;
  }

  if(var0 == "offhand_wm_supportbox_ammunition") {
    return true;
  }

  if(var0 == "offhand_wm_supportbox_explosives") {
    return true;
  }

  return false;
}

function ref_139ab(var0, var1, var2, var3, var4, var5) {
  var0 endon("entitydeleted");

  if(!isDefined(var5)) {
    var5 = &"COOP_GAME_PLAY/AMMO_MAX_RED";
  }

  var0 setHintString(var1);
  var6 = spawn("script_origin", var0.origin);
  ref_139a9(var6);
  var6 setHintString(var5);
  var0.headiconid = scripts\cp\utility::ent_createheadicon(var0, 15, "allies", var2, 1);
  setheadiconsnaptoedges(var0.headiconid, 1500);
  setheadiconmaxdistance(var0.headiconid, 15);
  var7 = var0 getentitynumber();
  var8 = 0.1;

  for(;;) {
    foreach(var10 in level.players) {
      if(!isDefined(var10.ref_139b4)) {
        var10.ref_139b4 = [];
      }

      if(scripts\cp\cp_endgame::gamealreadyended()) {
        foreach(var10 in level.players) {
          removeteamfromheadiconmask(var0.headiconid, var10);
          return 1;
        }
      }

      var13 = !isDefined(var10.ref_139b4[var7]) || !var10.ref_139b4[var7];
      var14 = !isDefined(var10.ref_139b4[var7]) || var10.ref_139b4[var7];

      if(var13 && [[var4]](var10)) {
        var10 notify("support_box_update_player" + var7);
        removeteamfromheadiconmask(var0.headiconid, var10);
        var0 disableplayeruse(var10);
        GscBinSkip4(0x35, var10, var0, var6, var7);
      }

      if(var14 && ![[var4]](var10)) {
        var10 notify("support_box_update_player" + var7);
        addteamtoheadiconmask(var0.headiconid, var10);
        var0 enableplayeruse(var10);
        var6 disableplayeruse(var10);
        var10.ref_139b4[var0 getentitynumber()] = 0;
      }
    }

    wait var8;
  }
}

function ref_139a5(var0, var1, var2, var3) {
  var0 endon("support_box_update_player" + var3);
  wait 2;
  var2 enableplayeruse(var0);
}

function brplayerhudoutlineforteammatesupdate(var0, var1) {
  return ref_139aa(var0, var1, &brpreplayerdamaged, "offhand_wm_supportbox_ammunition", &"COOP_CRAFTING/AMMO_CRATE_TAKE", "cp_crate_icon_ammo", "cp_crate_icon_ammo_red", &ref_124b0);
}

function brpreplayerdamaged(var0, var1) {
  var2 = var1 getweaponslistprimaries();

  foreach(var4 in var2) {
    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var4) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var4)) {
      continue;
    }

    var1 givemaxammo(var4);
  }

  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function handle_leads_collected_hideiconbuilding(var0, var1) {
  return ref_139aa(var0, var1, &handle_no_ammo_mun, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/CLAYMORE", "hud_icon_equipment_claymore", "hud_icon_equipment_claymore_red", &handle_just_keep_moving);
}

function handle_no_ammo_mun(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_claymore", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function handle_just_keep_moving(var0) {
  return ref_12470(var0, "power_claymore");
}

function binoculars_getpendingtime(var0, var1) {
  return ref_139aa(var0, var1, &binoculars_giveassistpoints, "lm_heal_first_aid_kit_01", &"CP_SO_FINALE/PICKUP_STIMS", "hud_icon_equipment_stim", "hud_icon_equipment_stim_red", &binoculars_getpendingendtime);
}

function binoculars_giveassistpoints(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("equip_adrenaline", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function binoculars_getpendingendtime(var0) {
  return ref_12470(var0, "equip_adrenaline");
}

function ref_11cb8(var0, var1) {
  return ref_139aa(var0, var1, &ref_11cba, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/MOLOTOV", "hud_icon_equipment_molotov", "hud_icon_equipment_molotov_red", &ref_11cb7);
}

function ref_11cba(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_molotov", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function ref_11cb7(var0) {
  return ref_12470(var0, "power_molotov");
}

function playerplunderlosedepositcallback(var0, var1) {
  return ref_139aa(var0, var1, &playerplunderpickup, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/FRAG", "hud_icon_equipment_frag", "hud_icon_equipment_frag_red", &playerplunderlosedeposit);
}

function playerplunderpickup(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_frag", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function playerplunderlosedeposit(var0) {
  return ref_12470(var0, "power_frag");
}

function focus_fire_outline_enabled(var0, var1, var2) {
  return ref_139aa(var0, var1, &fogenabled, "offhand_wm_supportbox_explosives", &"EQUIPMENT_HINTS/PICKUP_C4", "hud_icon_equipment_c4", "hud_icon_equipment_c4_red", &focus_fire_is_activated);
}

function fogenabled(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_c4", "primary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function focus_fire_is_activated(var0) {
  return ref_12470(var0, "power_c4");
}

function player_limitedammo(var0, var1) {
  return ref_139aa(var0, var1, &player_max_exposure_time, "offhand_wm_supportbox", &"COOP_CRAFTING/FLASH", "hud_icon_equipment_flash", "hud_icon_equipment_flash_red", &player_latespawn_safehouse);
}

function player_max_exposure_time(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_flash", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function player_latespawn_safehouse(var0) {
  return ref_12470(var0, "power_flash");
}

function ref_13433(var0, var1) {
  return ref_139aa(var0, var1, &ref_13434, "offhand_wm_supportbox", &"EQUIPMENT/SNAPSHOT_GRENADE", "hud_icon_equipment_snapshot", "hud_icon_equipment_snapshot_red", &ref_13432);
}

function ref_13434(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("power_snapshotGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function ref_13432(var0) {
  return ref_12470(var0, "power_snapshotGrenade");
}

function plunderfxondropthreashold(var0, var1) {
  return ref_139aa(var0, var1, &plunderinstanceid, "offhand_wm_supportbox", &"EQUIPMENT/GAS", "hud_icon_equipment_gas", "hud_icon_equipment_gas", &plunderforextract);
}

function plunderinstanceid(var0, var1) {
  var1 thread scripts\cp\cp_powers::givepower("equip_gas_grenade", "secondary", undefined, undefined, undefined, undefined, 1, 2);
  var1 forceplaygestureviewmodel("ges_swipe", var0);
  var1 playlocalsound("weap_ammo_pickup");
}

function plunderforextract(var0) {
  return ref_12470(var0, "equip_gas_grenade");
}

function trial_active_fob(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var4 = "device_laptop_01_open";

  if(isDefined(var1)) {
    var3.angles = var1;
  } else {
    var3.angles = (0, 0, 0);
  }

  var3 setModel(var4);
  var3 setCursorHint("HINT_BUTTON");
  var3 setHintString(&"CP_SO_ANIYAH/OBJ_GATHER_INTEL");
  var3 sethintdisplayrange(200);
  var3 sethintdisplayfov(45);
  var3 setuserange(100);
  var3 setusefov(40);
  var3 sethintonobstruction("show");
  var3 setuseholdduration("duration_none");
  var3 setusepriority(1);
  var3 makeusable();
  thread trial_end_flares(var3, var2);
  return var3;
}

function trial_end_flares(var0, var1) {
  var0 endon("entitydeleted");

  for(;;) {
    var0 waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    GscBinSkip1(0x74, var1, var2, var0);
  }

  var0 makeunusable();
  var0 delete();
}

function get_driver_interaction_hint_string(var0, var1, var2, var3, var4, var5) {
  var6 = var3;
  var7 = var6 + (0, 0, -8000);
  var8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var9 = physics_raycast(var6, var7, var8, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var9) && var9.size > 0) {
    var10 = var9[0]["position"];
  } else {
    var10 = var4;
  }

  var11 = var4 + -1 * anglesToForward(var3) * var1;
  var12 = var4 + anglesToForward(var3) * var2;
  var13 = scripts\cp_mp\killstreaks\airdrop::createheli(undefined, "allies", var11, var3, 0);
  var13 scripts\common\vehicle::godon();
  var13 setCanDamage(0);
  var13 vehicle_setspeed(200, 100);
  var13 setmaxpitchroll(15, 15);
  var14 = get_enter_leave_station_time(var11, var3);
  var15 = get_ending_struct(var14);
  var16 = get_emp_effect_duration(var14);
  var15 linkTo(var14);
  var16 linkTo(var14);
  var14 linkTo(var13, "tag_origin", (16, 0, -156), (0, 0, 0));
  var13 setvehgoalpos(var4, 1);
  wait 2;
  var13 setyawspeed(40, 20, 20, 0.3);
  var13 waittill("goal");
  wait 0.25;
  thread get_evade_start_structs_in_front(var14, var15, var16, var5, var6);
  wait 0.5;
  var13 vehicle_setspeed(150, 50);
  var13 setvehgoalpos(var12, 1);
  var13 waittill("goal");
  var13 thread scripts\cp_mp\killstreaks\airdrop::destroyheli();
}

function get_evade_start_structs_in_front(var0, var1, var2, var3, var4) {
  var0 unlink();
  var0 physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var5 = var0 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var5, (0, 0, -1));
  var0 physics_registerforcollisioncallback();
  get_explosion_alias(var0);
  var0 physicsstopserver();
  var0 physics_unregisterforcollisioncallback();
  thread get_end_ang(var0, var1, var2, var3, var4);
}

function get_explosion_alias(var0) {
  wait 1;
  var1 = gettime() + 10000;

  while(gettime() < var1) {
    var2 = var0 physics_getbodyid(0);
    var3 = physics_getbodylinvel(var2);

    if(lengthsquared(var3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function get_end_ang(var0, var1, var2, var3, var4) {
  var5 = createnavobstaclebybounds(var0.origin, (30, 10, 64), var0.angles);
  var6 = var0 scripts\cp\utility::killstreak_createobjective("icon_minimap_carepackage", "allies", 1, 1, 0);
  var7 = deleteheadicon(var0);
  setheadiconfriendlyimage(var7, "hud_icon_head_killstreak_carepackage");
  addclienttoheadiconmask(var7, -7);
  setheadiconmaxdistance(var7, 0);
  setheadiconsnaptoedges(var7, 6250);
  setheadiconowner(var7, undefined);
  setheadiconzoffset(var7, 1);
  hideheadiconfromplayersinmask(var7);
  var0.headicon = var7;
  var0 playSound("mp_care_package_med_impact");
  var0 setCursorHint("HINT_NOICON");
  var0 sethintdisplayrange(256);
  var0 setuserange(100);
  var0 setusefov(180);
  var0 sethintdisplayfov(180);
  var0 setuseholdduration("duration_short");
  var0 setusepriority(0);
  var0 sethintonobstruction("show");
  var0 sethinttag("tag_use");
  var0 makeusable();
  var0 setHintString(&"KILLSTREAKS_HINTS/CRATE_PICKUP");

  for(;;) {
    var0 waittill("trigger", var8);

    if(!isPlayer(var8)) {
      continue;
    }

    if(ref_124d0(var8)) {
      thread logevent_givecpweaponxp(var8, &"CP_BR/MUN_SLOTS_FULL", 3);
      continue;
    }

    if(isDefined(var3)) {
      ref_124a5(var8, var3);
    }

    if(isDefined(var4)) {
      GscBinSkip1(0x74, var4, var8, var0.origin, var3);
    }

    break;
  }

  var9 = (0, 0, -44);
  var2 unlink();
  var2.origin += var9;
  var0 unlink();
  var0.origin += var9;
  var1 unlink();
  var0 makeunusable();
  setheadiconimage(var7);
  var0.headicon = undefined;
  var1 setscriptablepartstate("anims", "capture", 0);
  var1 setscriptablepartstate("capture", "start", 0);
  objective_state(var6, "done");
  scripts\cp\utility::nonobjective_returnobjectiveid(var6);
  wait 2;
  destroynavobstacle(var5);
  var2 delete();
  var1 delete();
  var0 delete();
}

function get_enter_leave_station_time(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("military_carepackage_01_dummy");
  var2 setnodeploy(1);
  var2 setCanDamage(0);
  var2 makeunusable();
  var2.targetname = "carepackage";
  return var2;
}

function get_drone_target_loc() {
  return getEntArray("carepackage", "targetname");
}

function get_ending_struct(var0) {
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1 setModel("military_carepackage_01_friendly");
  var1 setnodeploy(1);
  var1 setCanDamage(0);
  var1 makeunusable();
  var1 linkTo(var0);
  return var1;
}

function get_emp_effect_duration(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 dontinterpolate();
  var1.angles = var0.angles;
  var2 = getEnt("care_package_col", "targetname");
  var1 clonebrushmodeltoscriptmodel(var2);
  var1 linkTo(var0);
  return var1;
}

function ref_124a5(var0, var1) {
  var2 = scripts\cp\loot_system::get_empty_munition_slot(var0);

  if(isDefined(var2)) {
    var3 = var2;
    var0 scripts\cp\cp_munitions::give_munition_to_slot(var1, var3);
    return;
  }

  var0 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
}

function ref_124af(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(weapontype(var3) == "riotshield") {
      continue;
    }

    var4 = var0 getweaponammostock(var3);

    if(var4 < weaponmaxammo(var3)) {
      return false;
    }

    var5 = var0 getweaponammoclip(var3);

    if(var5 < weaponclipsize(var3)) {
      return false;
    }
  }

  return true;
}

function ref_124b0(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(weapontype(var3) == "riotshield") {
      continue;
    }

    var4 = var0 getweaponammostock(var3);

    if(var4 < weaponmaxammo(var3)) {
      return false;
    }
  }

  return true;
}

function can_play_ending(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    foreach(var4 in var0) {
      if(scripts\engine\utility::is_equal(var4.script_index, var2)) {
        var1 = scripts\engine\utility::array_add(var1, var4);
      }
    }
  }

  var6 = scripts\engine\utility::array_remove_array(var0, var1);
  var1 = scripts\cp\utility::array_merge(var1, var6);
  return var1;
}

function ref_12f55(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;

  if(isDefined(var1)) {
    var2.angles = var1;
  }

  level.struct[level.struct.size] = var2;
  return var2;
}

function ref_12f56(var0) {
  if(!isDefined(level.checkpoint_player_spawns)) {
    level.checkpoint_player_spawns = 0;
  } else {
    level.checkpoint_player_spawns++;
  }

  var1 = "autoStruct" + level.checkpoint_player_spawns;
  self.target = var1;
  var0.targetname = var1;
}

function ref_12486(var0) {
  var0.ability_invulnerable = 1;
}

function ref_12484(var0) {
  var0.ability_invulnerable = undefined;
}

function print_spawner_score_for_factor() {
  return self.baseaccuracy;
}

function set_baseaccuracy(var0) {
  self.baseaccuracy = var0;
}

function ref_143a1() {
  while(pushpointoutofkothattractions() > 0) {
    waitframe();
  }
}

function logevent_downed(var0, var1) {
  foreach(var3 in level.players) {
    thread logevent_givecpweaponxp(var3, var0, var1);
  }
}

function logevent_givecpweaponxp(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 sethudtutorialmessage(var1);
  wait var2;
  var0 clearhudtutorialmessage();
}

function ref_124d0(var0) {
  var1 = var0 getplayerdata("cp", "inventorySlots", "totalSlots");
  var2 = 0;

  for(var3 = 0; var3 < var1; var3++) {
    if(!isDefined(var0.munition_slots)) {
      continue;
    }

    if(!isDefined(var0.munition_slots[var3])) {
      continue;
    }

    if(var0 scripts\cp\loot_system::is_empty_or_none(var3)) {
      continue;
    }

    var2++;
  }

  return var1 == var2;
}

function ref_12470(var0, var1) {
  return isDefined(var0.powers) && isDefined(var0.powers[var1]) && var0.powers[var1].charges == var0.powers[var1].maxcharges;
}

#using_animtree("script_model");

function ref_124e9(var0, var1) {
  var0.animname = var1;
  var2 = spawn("script_arms", var0.origin, 0, 0, var0);
  var2 hide();
  var2.animname = var1;
  var2 useanimtree(#animtree);
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  return var2;
}

#using_animtree("scriptables");

function ref_139a7() {
  return getanimlength(%wm_supportbox_ground_open);
}

#using_animtree("");

function ref_139a6() {
  return getanimlength(%wm_supportbox_ground_close);
}

function ref_13067() {
  level.autoassignlowteamconsistent = gettime();
}

function init_minigun_lifetime_shot_count(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawncovernode(var1, var3, "begin", 0, var0, undefined, var4);
  var8 = undefined;

  if(isDefined(var5)) {
    var8 = spawn("script_origin", var5);
    var8.angles = var3;
  }

  var9 = spawncovernode(var1, var3, "end", 0, var0 + "_end", var0, var4);

  if(isDefined(var6)) {
    var7.animation = var6;
  }

  var7.usagecost = 15;
  createnavlink("traverse_" + var4, var1, var2, var7, "soldier");
  ref_1363c(var7, var9, var8);
  return var7;
}

function ref_1363c(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  scripts\asm\asm::calculate_traverse_data(var1.origin, var0.origin);

  if(isDefined(self.parentname)) {
    scripts\asm\asm::store_original_traverse_data();
  }

  if(isent(var1)) {
    var1 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var1);
}

function ref_14309() {
  if(!isDefined(self.ref_1430c)) {
    self.ref_1430c = [];
    return;
  }
}

function ref_1430a(var0) {
  ref_14309();
  self.ref_1430c[var0] = undefined;
}

function ref_1430b(var0, var1) {
  if(isDefined(self.ref_1430c[var0])) {
    return;
  }

  self.ref_1430c[var0] = var1;
}

function ref_1430d() {
  level.ref_14312 = [];
}

function ref_1430e(var0, var1) {
  if(isDefined(level.ref_14312[var0])) {
    return;
  }

  foreach(var3 in level.players) {
    ref_1430a(var3, var0);
  }

  level.ref_14312[var0] = 1;
  thread ref_1430f(level, var0);
}

function ref_1430f(var0, var1) {
  var2 = 0;
  var3 = gettime() + var1 * 1000;
  var4 = -1;
  var5 = -1;
  var6 = -1;
  waitframe();

  while(gettime() < var3) {
    if(level.gameended) {
      var2 = 0;
      break;
    }

    var7 = int((var3 - gettime()) * 0.001);

    if(var7 != var5) {
      var5 = var7;
      ref_14311(var7);
    }

    foreach(var9 in level.players) {
      if(!isDefined(var9.ref_1430c)) {
        ref_1430a(var9, var0);
      }
    }

    var11 = 0;

    foreach(var9 in level.players) {
      if(!isDefined(var9.ref_1430c)) {
        ref_1430a(var9, var0);
      }

      if(istrue(var9.ref_1430c[var0])) {
        var11++;
      }
    }

    if(var11 != var4 || var6 != level.players.size + 1) {
      var4 = var11;
      var6 = level.players.size;
      ref_14310(var11, var6);
    }

    if(var11 == level.players.size) {
      var2 = 1;
      break;
    }

    waitframe();
  }

  if(level.gameended) {
    var2 = 0;
  }

  level.ref_14312[var0] = undefined;
  ref_14311(0);
  ref_14310(0, 0);

  foreach(var9 in level.players) {
    ref_1430a(var9, "retry");
  }

  if(var2) {
    scripts\cp\cp_endgame::restart_map(0);
    return;
  }
}

function ref_14311(var0) {
  setomnvar("ui_votesys_time", var0);
}

function ref_14310(var0, var1) {
  setomnvar("ui_votesys_playervotes", var0);
  setomnvar("ui_votesys_playercount", var1);
}

function little_bird_mg_cp_ondeathrespawncallback() {
  if(!istrue(level.nojip)) {
    level.nojip = 1;
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    return;
  }
}

function ref_13542(var0, var1, var2) {
  var3 = magicgrenademanual("claymore_mp", var0 + (0, 0, 10), (0, 0, 10));
  GscBinSkip4(0x6e, var3, var0, var1, var2);
}

function ref_123b2(var0, var1, var2) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = var1;
  self.owner = spawnStruct();
  self.owner.angles = var1;
  self.owner.team = "axis";
  self.team = "axis";
  var3 = self.owner;
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
  thread intermissionspawnorigin(var0);
  thread next_subway_track_hurt_time(var2);
}

function intermissionspawnorigin(var0) {
  var1 = var0 + (0, 0, 50) + anglesToForward(self.angles) * 95;
  var2 = var0 + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  var3 = getaiarray("axis")[0];
  radiusdamage(var2, 30, 1000, 200, var3, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(var1, 100, 1000, 20, var3, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

function minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var0 = undefined;
  self waittill("damage", var1, var0, var2, var3, var4, var5, var6, var7, var8, var9);
  self notify("mine_destroyed");

  if(isDefined(var4) && (issubstr(var4, "MOD_GRENADE") || issubstr(var4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var8) && var8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var0)) {
    self.damagedby = var0;
  }

  self notify("detonateExplosive", var0);
}

function next_subway_track_hurt_time(var0) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  var1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    var2 = level.players;
    var3 = anglesToForward(self.angles);
    var4 = anglestoup(self.angles);
    var5 = self.origin + var4 * 0;
    var6 = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(var8 in level.dynamicladders) {
        var6 = var8.ents[0];
      }
    }

    if(istrue(var0)) {
      var2 = scripts\engine\utility::array_combine(var2, getaiarray("allies"));
    }

    foreach(var11 in var2) {
      if(!isDefined(var11)) {
        continue;
      }

      if(isPlayer(var11) && scripts\cp\cp_laststand::player_in_laststand(var11) || isagent(var11) && !isalive(var11)) {
        continue;
      }

      if(lengthsquared(var11 getentityvelocity()) < 10) {
        continue;
      }

      if(distance2dsquared(var11.origin, self.origin) > 50625) {
        continue;
      }

      var12 = var11 gettagorigin("j_mainroot");
      var13 = [var12];
      var14 = var5 - var12;

      if(vectordot(var14, (0, 0, 1)) >= 0) {
        var13 = var11 gettagorigin("j_spineupper");
      } else {
        var13 = var11.origin;
      }

      foreach(var16 in var13) {
        var14 = var16 - self.origin;
        var17 = vectordot(var14, var3);

        if(var17 > 192 || var17 < 20) {
          continue;
        }

        var18 = vectordot(var14, var4);

        if(abs(var18) > 32) {
          continue;
        }

        var19 = vectorNormalize(var14);
        var20 = vectordot(var19, var3);

        if(var20 < 0.86602) {
          continue;
        }

        var21 = physics_raycast(var5, var16, var1, var6, 0, "physicsquery_closest", 1);

        if(isDefined(var21) && var21.size > 0) {
          continue;
        }

        thread scripts\cp\cp_claymore::claymore_trigger(var11);
      }
    }

    wait 0.05;
  }
}

function ref_131f6() {
  initnightvisionheadoverrides();
}

function initnightvisionheadoverrides() {
  if(!scripts\cp\gametypes\cp_survival::allow_nvg()) {
    return;
  }

  level.nvgheadoverrides = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("operatorskins.csv", var0, 5);
    var2 = tablelookupbyrow("operatorskins.csv", var0, 17);
    var3 = tablelookupbyrow("operatorskins.csv", var0, 16);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    if(var2 != "") {
      level.nvgheadoverrides[var1]["up"] = var2;
    }

    if(var3 != "") {
      level.nvgheadoverrides[var1]["down"] = var3;
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
    scripts\engine\utility::ref_143a5("spawned_player", "fadeUp_start");
  }

  while(!isDefined(self.operatorcustomization)) {
    waitframe();
  }

  thread scripts\cp\equipment\nvg::runnvg();
  self nightvisionviewon(1);
}

function ref_1437a(var0, var1) {
  level notify("so_prematch_countdown_started");

  if(!isDefined(var0)) {
    var0 = 30;
  }

  var2 = getdvarint("NKSQNMMRRQ");
  var3 = 1;
  var4 = 0;
  var5 = undefined;
  jumpiftrue(istrue(var1)) LOC_00000033;
  var5 = ref_11b41();

  while(var0 > -1) {
    if(level.hostdamagefactorlow >= var2) {
      if(!var4 && var0 > 5) {
        var4 = 1;
        var0 = 5;
      }
    }

    foreach(var7 in level.players) {
      var7 setclientomnvar("ui_hide_hud", 1);
      var7 setclientomnvar("ui_match_start_countdown", var0);
    }

    wait 1;
    var0--;
  }

  scripts\engine\utility::flag_set("so_connect_timer_finished");

  foreach(var7 in level.players) {
    var7 setclientomnvar("ui_hide_hud", 0);
    var7 setclientomnvar("ui_match_start_countdown", 0);
  }

  if(!istrue(var1)) {
    var5 fadeovertime(var3);
    var5.alpha = 0;
    var5 scripts\engine\utility::delaycall(var3, &destroy);
  }

  scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  level notify("so_prematch_countdown_finished");
}

function ref_11b41() {
  var0 = newhudelem();
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 20;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0 setshader("black", 640, 480);
  return var0;
}

function ref_13f98() {
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

    var0 = vehicle_damage_setvehiclehitdamagedataforweapon();

    if(!isDefined(var0)) {
      continue;
    }

    self getenemyinfo(var0);
    self setgoalpos(var0.origin);
  }
}

function vehicle_damage_setvehiclehitdamagedataforweapon() {
  var0 = undefined;

  if(isDefined(self.attacker)) {
    var0 = self.attacker;
    self.attacker = undefined;
  } else {
    var0 = vehicle_damage_setvehiclehitdamagedata(self.origin);
  }

  return var0;
}

function vehicle_damage_setvehiclehitdamagedata(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!isalive(var3) || var3.inlaststand) {
      continue;
    }

    var1 = var3;
  }

  var3 = scripts\engine\utility::getclosest(var0, var1);
  return var3;
}