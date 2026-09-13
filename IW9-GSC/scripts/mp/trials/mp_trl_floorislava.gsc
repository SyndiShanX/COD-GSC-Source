/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_floorislava.gsc
****************************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["lava"] = ::init;
}

init() {
  analytics_init();
  precachemodel("tag_origin");
  precachemodel("head_russian_army_gasmask_1_alt");
  precachemodel("body_spetsnaz_cqc");
  precachemodel("offhand_wm_at_mine");
  level.waypoint_inactive_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_inactive_grey.vfx");
  level.waypoint_active_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_active_yellow.vfx");
  level.waypoint_completed_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_completed_blue.vfx");
  level.waypoint_endzone_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_flagbase.vfx");
  level.gas_emit_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_jet_start.vfx");
  level.gas_linger_large_vfx = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_cloud_linger_lg.vfx");
  level.gas_linger_vfx = loadfx("vfx/iw8/level/captive/vfx_cpt_gas_cloud_linger.vfx");
  level.mine_light_vfx = loadfx("vfx/core/equipment/vfx_at_mine_light_en.vfx");
  level.mine_launch_vfx = loadfx("vfx/iw8_mp/equipment/vfx_at_mine_launch.vfx");
  level.mine_destroyed_vfx = loadfx("vfx/iw8_mp/equipment/c4/vfx_gen_c4_exp_dud.vfx");
  level.mine_explosion_vfx = loadfx("vfx/iw8_mp/equipment/mine/vfx_at_mine_exp.vfx");

  if(!isDefined(game["trial"]))
    game["trial"] = [];

  if(!isDefined(game["trial"]["tries_remaining"]))
    game["trial"]["tries_remaining"] = level.trial["attempts"];

  if(!isDefined(game["trial"]["best_reward"]))
    game["trial"]["best_reward"] = 0;

  level.groundtriggers = [];
  level.waypoints_reached = 0;
  level.time_on_floor = 0;
  level.timeelapsed = 0;
  level.totaltime = 0;
  level.objectives_amount = 0;
  level.maxtimelimit = 59999900;
  level.battlechatterenabled = 0;
  level scripts\engine\utility::flag_init("trial_prestart");
  level scripts\engine\utility::flag_init("trial_in_progress");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_ready_for_endscreen");
  level scripts\engine\utility::flag_init("trial_player_death");

  if(!isDefined(level.enemy_spawners))
    level.enemy_spawners = getEntArray("enemy_spawner", "targetname");

  if(level.enemy_spawners.size != 0)
    level.enemyheadmodels = [];

  level.enemyheadmodels[0] = "head_russian_army_gasmask_1_alt";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "body_spetsnaz_cqc";
  waitframe();

  if(isDefined(level.trial_patch_finished)) {
    while(level.trial_patch_finished == 0)
      waitframe();
  }

  thread trial_start_init();
  thread player_init();
  thread hud_init();
  thread dialog_init();
  thread enemies_init();
  _id_7F4365E3B7281E17 = getEnt("clip8x8x256", "targetname");
  _id_D62A76A32F201064 = getnodearray("traverse", "targetname");
  _id_E2B1937C8F34D77B = [];

  foreach(node in _id_D62A76A32F201064)
  _id_E2B1937C8F34D77B[_id_E2B1937C8F34D77B.size] = getnode(node.target, "targetname");

  _id_2872F5DDE772621A = scripts\engine\utility::array_combine(_id_D62A76A32F201064, _id_E2B1937C8F34D77B);

  if(isDefined(_id_7F4365E3B7281E17)) {
    foreach(_id_EC1C5F02DF74FF1A in _id_2872F5DDE772621A) {
      if(isDefined(_id_EC1C5F02DF74FF1A.origin)) {
        scriptmodel = spawn("script_model", _id_EC1C5F02DF74FF1A.origin);
        scriptmodel clonebrushmodeltoscriptmodel(_id_7F4365E3B7281E17);
        scriptmodel disconnectPaths();
        _id_EC1C5F02DF74FF1A _meth_547AAB3C2787AC87();
        scriptmodel notsolid();
      }
    }
  }

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  level.nosuspensemusic = 1;
}

trial_start_init() {
  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  waypoints_creation();

  if(game["trial"]["tries_remaining"] == 3)
    wait 3.5;

  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  wait 7.5;
  level scripts\engine\utility::flag_set("trial_prestart");
  thread floor_gas();

  switch (level.trial["variant"]) {
    case "free":
      level.dogtags = scripts\engine\utility::getStructArray("trial_waypoint_free", "targetname");
      thread waypoints_free_flow();
      break;
    default:
      thread waypoints_linear_flow();
      break;
  }

  thread player_monitor_death();
  thread ground_detection_think();
  _id_EE32376B13801F98 = getEnt("trial_truck_door_left", "targetname");
  _id_7BF201849AE293CD = getEnt("trial_truck_door_right", "targetname");
  _id_E6A93FE2AD215A3A = getEnt("trial_truck_door_coll_l", "targetname");
  _id_4A443AE4A640FF9F = getEnt("trial_truck_door_coll_r", "targetname");
  _id_EE32376B13801F98 playsoundonmovingent("trial_sfx_door_truck_left");
  _id_7BF201849AE293CD playsoundonmovingent("trial_sfx_door_truck_right");
  _id_E6A93FE2AD215A3A linkTo(_id_EE32376B13801F98);
  _id_4A443AE4A640FF9F linkTo(_id_7BF201849AE293CD);
  _id_7BF201849AE293CD rotateYaw(150, 2);
  _id_EE32376B13801F98 rotateYaw(-150, 2);
}

waypoints_creation() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_132360A247A77FA7 = level.trial["variant"];

  if(!isDefined(level.waypoints_structs))
    level.waypoints_structs = scripts\engine\utility::getStructArray("trial_waypoint_" + _id_132360A247A77FA7, "targetname");

  level.waypoints = [];

  foreach(struct in level.waypoints_structs) {
    waypoint = spawn("script_model", struct.origin);
    waypoint.angles = struct.angles;
    waypoint.targetname = "floorislava_waypoint";

    if(isDefined(struct.script_index))
      waypoint.script_index = struct.script_index;
    else if(isDefined(struct.script_noteworthy))
      waypoint.script_index = struct.script_noteworthy;

    waypoint setModel("tag_origin");

    if(isDefined(struct.script_noteworthy))
      waypoint.script_noteworthy = struct.script_noteworthy;

    level.waypoints[int(waypoint.script_index)] = waypoint;
  }
}

waypoints_free_flow() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  index = 0;

  foreach(_id_5A2C726A884B09AA in level.dogtags) {
    _id_5A2C726A884B09AA thread spawn_dogtags(_id_5A2C726A884B09AA, level.player, index);
    _id_5A2C726A884B09AA thread spawn_objective();
    index++;
  }

  while(level.waypoints_reached < level.waypoints.size)
    wait 0.05;

  level scripts\engine\utility::flag_set("trial_completed");
}

waypoints_linear_flow() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  headicon = spawn_headicon();
  _id_95BD6A912DBA558A = undefined;
  waitframe();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.waypoints.size; _id_AC0E594AC96AA3A8++) {
    waitframe();

    if(_id_AC0E594AC96AA3A8 + 1 == level.waypoints.size) {
      _id_A46E49F23AB4EFF9 = spawn("script_model", level.waypoints[_id_AC0E594AC96AA3A8].origin);
      _id_A46E49F23AB4EFF9.angles = (level.waypoints[_id_AC0E594AC96AA3A8].angles[0] - 90, level.waypoints[_id_AC0E594AC96AA3A8].angles[1], level.waypoints[_id_AC0E594AC96AA3A8].angles[2]);
      _id_A46E49F23AB4EFF9 setModel("tag_origin");
      waitframe();
      playFXOnTag(level.waypoint_endzone_vfx, _id_A46E49F23AB4EFF9, "TAG_ORIGIN");
    }

    if(isDefined(level.waypoints[_id_AC0E594AC96AA3A8 + 1]))
      playFXOnTag(level.waypoint_inactive_vfx, level.waypoints[_id_AC0E594AC96AA3A8 + 1], "TAG_ORIGIN");

    waitframe();
    killfxontag(level.waypoint_inactive_vfx, level.waypoints[_id_AC0E594AC96AA3A8], "TAG_ORIGIN");
    playFXOnTag(level.waypoint_active_vfx, level.waypoints[_id_AC0E594AC96AA3A8], "TAG_ORIGIN");
    level.waypoints[_id_AC0E594AC96AA3A8] thread spawn_objective();
    waitframe();
    headicon moveTo((level.waypoints[_id_AC0E594AC96AA3A8].origin[0], level.waypoints[_id_AC0E594AC96AA3A8].origin[1], level.waypoints[_id_AC0E594AC96AA3A8].origin[2] + 30), 1, 0.1, 0.3);
    level.waypoints[_id_AC0E594AC96AA3A8] waypoint_radius_think();

    if(_id_AC0E594AC96AA3A8 == 0)
      killfxontag(level.waypoint_endzone_vfx, level.waypoints[0], "TAG_ORIGIN");
  }

  level scripts\engine\utility::flag_set("trial_completed");
  deleteheadicon(level.waypoint_icon);
}

waypoint_radius_think() {
  for(;;) {
    _id_89FD21279A147330 = distance(self.origin, level.player.origin);
    _id_7650F47A868A4E54 = abs(self.origin[2] - level.player.origin[2]);

    if(_id_89FD21279A147330 < 80 && _id_7650F47A868A4E54 < 24) {
      break;
    } else
      wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_in_progress"))
    level scripts\engine\utility::flag_set("trial_in_progress");

  level.waypoints_reached++;
  killfxontag(level.waypoint_active_vfx, self, "TAG_ORIGIN");
  playFXOnTag(level.waypoint_completed_vfx, self, "TAG_ORIGIN");

  if(level.waypoints_reached < level.waypoints.size)
    level.player playSound("trial_sfx_success");

  self notify("reached");
  thread hud_set_progress();
  _id_637EEEB8AE30D567 = isDefined(self.script_noteworthy) && self.script_noteworthy == "spawn_enemy";
  _id_BB3B253EFD1E0D5C = isDefined(self.script_index);

  if(_id_637EEEB8AE30D567 || _id_BB3B253EFD1E0D5C) {
    foreach(spawner in level.enemy_spawners) {
      if(int(spawner.script_index) == int(self.script_index))
        spawner notify("trigger");
    }
  }

  level.player setclientomnvar("ui_edge_glow_trials", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "ui_edge_glow_trials", 0);
}

spawn_dogtags(victim, attacker, index) {
  tagoffset = 14;
  upangles = (0, 0, 0);
  _id_650440C6A1642E7E = victim.angles;

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    _id_650440C6A1642E7E = victim getworldupreferenceangles();
    upangles = anglestoup(_id_650440C6A1642E7E);

    if(upangles[2] < 0)
      tagoffset = -14;
  }

  visuals[0] = spawn("script_model", (0, 0, 0));
  visuals[0] setModel("military_dogtags_iw8_blue");
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(upangles[2] < 0)
      visuals[0].angles = _id_650440C6A1642E7E;
  }

  useteam = "any";
  dogtag = scripts\mp\gameobjects::createuseobject(level.player.team, trigger, visuals, (0, 0, 16));
  dogtag.victim = victim;
  dogtag.victimteam = level.player.team;
  pos = victim.origin + (0, 0, tagoffset);
  dogtag.trigger.origin = pos;
  dogtag.visuals[0].origin = pos;
  dogtag.attacker = attacker;
  dogtag.attackerteam = attacker.team;
  dogtag.ownerteam = scripts\engine\utility::get_enemy_team(level.player.team);
  dogtag.visuals[0] scriptmodelplayanim("mp_dogtag_spin", undefined, index);
  scripts\mp\utility\outline::outlineenableforplayer(visuals[0], level.player, "outline_trial_vehicle", "level_script");
  trigger waittill("trigger");
  dogtag notify("willdelete");

  if(!scripts\engine\utility::flag("trial_in_progress"))
    level scripts\engine\utility::flag_set("trial_in_progress");

  level.waypoints_reached++;

  if(level.waypoints_reached < level.waypoints.size)
    level.player playSound("trial_sfx_success");

  self notify("reached");
  thread hud_set_progress();
  _id_637EEEB8AE30D567 = isDefined(self.script_noteworthy) && self.script_noteworthy == "spawn_enemy";
  _id_BB3B253EFD1E0D5C = isDefined(self.script_index);

  if(_id_637EEEB8AE30D567 || _id_BB3B253EFD1E0D5C) {
    foreach(spawner in level.enemy_spawners) {
      if(int(spawner.script_index) == int(self.script_index))
        spawner notify("trigger");
    }
  }

  level.player setclientomnvar("ui_edge_glow_trials", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "ui_edge_glow_trials", 0);
  level.player playSound("mp_killconfirm_tags_pickup");
  dogtag thread scripts\mp\gameobjects::deleteuseobject();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < dogtag.visuals.size; _id_AC0E594AC96AA3A8++)
    dogtag.visuals[_id_AC0E594AC96AA3A8] delete();
}

spawn_objective() {
  _id_2B23CD02088D1DA5 = undefined;

  switch (level.trial["variant"]) {
    case "free":
      _id_2B23CD02088D1DA5 = "hud_icon_minimap_misc_dog_tag";
      break;
    default:
      _id_2B23CD02088D1DA5 = "icon_waypoint_marker";
      break;
  }

  index = level.objectives_amount;
  level.objectives_amount++;
  objective_state(index, "active");
  objective_position(index, self.origin);
  objective_setplayintro(index, 0);
  objective_icon(index, _id_2B23CD02088D1DA5);
  objective_setbackground(index, 1);
  objective_setfadedisabled(index, 0);
  objective_setshowoncompass(index, 1);
  objective_setminimapiconsize(index, "icon_regular");
  objective_setshowdistance(index, 0);
  objective_ping(index);
  self waittill("reached");
  objective_delete(index);
}

spawn_headicon() {
  _id_0DA71A94C8A5A77E = spawn("script_model", (0, 0, 0));
  _id_0DA71A94C8A5A77E setModel("tag_origin");
  level.waypoint_icon = createheadicon(_id_0DA71A94C8A5A77E);
  setheadiconimage(level.waypoint_icon, "icon_waypoint_marker");
  setheadicondrawthroughgeo(level.waypoint_icon, 1);
  setheadiconmaxdistance(level.waypoint_icon, 0);
  setheadiconsnaptoedges(level.waypoint_icon, 1);
  return _id_0DA71A94C8A5A77E;
}

ground_detection_think() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  level.player endon("death");
  _id_D0B10636A086893D = spawn("script_model", level.player.origin);
  _id_D0B10636A086893D setModel("tag_origin");
  _id_D0B10636A086893D setentityowner(level.player);
  _id_D0B10636A086893D setotherent(level.player);
  level.groundtriggers = getEntArray("trigger_on_ground", "script_noteworthy");

  while(!scripts\engine\utility::flag("trial_completed")) {
    _id_9132ED5E750857B2 = 0;
    _id_564D7462C4CD30AA = isplayeronground();

    if(_id_564D7462C4CD30AA == 1) {
      if(!scripts\engine\utility::flag("trial_in_progress"))
        level scripts\engine\utility::flag_set("trial_in_progress");

      _id_C3AA5A1BC3847E16 = gettime();
      level.player playSound("trial_sfx_buzzer_bad_1");
      thread groundentrance_effects();
      _id_AC0E594AC96AA3A8 = 0;

      while(_id_564D7462C4CD30AA == 1) {
        if(_id_AC0E594AC96AA3A8 == 0) {
          level.player dodamage(22, level.player.origin, level.player, _id_D0B10636A086893D, "MOD_FIRE");
          level.player playRumbleOnEntity("damage_light");
        }

        wait 0.05;
        _id_564D7462C4CD30AA = isplayeronground();
        _id_AC0E594AC96AA3A8++;

        if(_id_AC0E594AC96AA3A8 >= 15) {
          _id_AC0E594AC96AA3A8 = 0;
          level.player notify("gas_warning_vo");
        }
      }

      level.player thread scripts\mp\equipment\gas_grenade::gas_removeblur();
      _id_127E4DBD3D914664 = gettime();
      _id_9132ED5E750857B2 = _id_127E4DBD3D914664 - _id_C3AA5A1BC3847E16;
      level.time_on_floor = level.time_on_floor + _id_9132ED5E750857B2;
    }

    waitframe();
  }
}

groundentrance_effects() {
  level.player playsoundtoplayer("gas_player_cough", level.player, level.player);
  level.player _id_3B64EB40368C1450::set("groundEntrance", "allow_jump", 0);
  level.player thread scripts\mp\equipment\gas_grenade::gas_applyblur();
  level.player thread scripts\mp\equipment\gas_grenade::gas_applycough();
  wait 1.25;
  level.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("groundEntrance");
  level.player thread scripts\mp\equipment\gas_grenade::gas_removecough(0);
}

isplayeronground() {
  _id_B749EA0AEB096D06 = 0;

  foreach(trigger in level.groundtriggers) {
    if(level.player istouching(trigger))
      _id_B749EA0AEB096D06 = 1;
  }

  if(_id_B749EA0AEB096D06 && level.player isonground())
    _id_EE04FC82FA87166F = 1;
  else
    _id_EE04FC82FA87166F = 0;

  return _id_EE04FC82FA87166F;
}

floor_gas() {
  _id_674486A1E4C98CC4 = scripts\engine\utility::getStructArray("trial_vfx_gas_emit", "script_noteworthy");
  _id_FC55371510EBFB14 = scripts\engine\utility::getStructArray("trial_vfx_gas_linger", "script_noteworthy");
  _id_08E8545814E06E60 = scripts\engine\utility::getStructArray("trial_vfx_gas_linger_lg", "script_noteworthy");
  _id_2B618777E91F5C63 = getEntArray("trial_vfx_gas_emit", "script_noteworthy");
  _id_C7459555CBD6E83B = getEntArray("trial_vfx_gas_linger", "script_noteworthy");
  _id_8C875823BF1A0205 = getEntArray("trial_vfx_gas_linger_lg", "script_noteworthy");
  _id_E88592E1DCE6EA3D = scripts\engine\utility::array_combine(_id_674486A1E4C98CC4, _id_2B618777E91F5C63);
  _id_0434376E6C3525D9 = scripts\engine\utility::array_combine(_id_FC55371510EBFB14, _id_C7459555CBD6E83B);
  _id_6B459C29797E5187 = scripts\engine\utility::array_combine(_id_08E8545814E06E60, _id_8C875823BF1A0205);

  foreach(spawner in _id_0434376E6C3525D9) {
    anchor = spawn("script_model", (spawner.origin[0], spawner.origin[1], spawner.origin[2] + 8));
    anchor setModel("tag_origin");
    wait 0.05;
    thread gas_vfx_range_think(level.gas_linger_vfx, anchor, "TAG_ORIGIN");
  }

  foreach(spawner in _id_6B459C29797E5187) {
    anchor = spawn("script_model", spawner.origin);
    anchor.angles = spawner.angles;
    anchor setModel("tag_origin");
    wait 0.05;
    thread gas_vfx_range_think(level.gas_linger_large_vfx, anchor, "TAG_ORIGIN");
  }

  foreach(spawner in _id_E88592E1DCE6EA3D) {
    anchor = spawn("script_model", spawner.origin);
    anchor.angles = spawner.angles;
    anchor setModel("tag_origin");
    wait 0.05;
    scripts\engine\utility::play_loopsound_in_space("trial_sfx_gas_hiss", anchor.origin);
    thread gas_vfx_range_think(level.gas_emit_vfx, anchor, "TAG_ORIGIN");
  }
}

gas_vfx_range_think(vfx, ent, tagname) {
  level endon("trial_completed");

  for(;;) {
    while(distance2d(ent.origin, level.player.origin) > 800)
      wait 0.25;

    playFXOnTag(vfx, ent, tagname);

    while(distance2d(ent.origin, level.player.origin) < 1000)
      wait 0.25;

    stopFXOnTag(vfx, ent, tagname);
  }
}

player_init() {
  if(istrue(level.trial_weapon_defined))
    _id_C094DB262CE4DFA0 = undefined;
  else {
    switch (level.trial["variant"]) {
      case "knife":
        _id_C094DB262CE4DFA0 = "iw8_knife";
        break;
      case "shield":
        _id_C094DB262CE4DFA0 = "iw8_me_riotshield";
        break;
      case "pistol":
        _id_C094DB262CE4DFA0 = "iw8_pi_decho";
        break;
      case "free":
        _id_C094DB262CE4DFA0 = "iw8_knife";
        break;
      default:
        _id_C094DB262CE4DFA0 = undefined;
        break;
    }

    level.trial_loadout["axis"]["loadoutPrimary"] = _id_C094DB262CE4DFA0;
  }

  while(!isDefined(level.player))
    waitframe();

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);

  while(!isalive(level.player))
    waitframe();

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 4.1);
  waitframe();
  level.player freezecontrols(1);

  if(istrue(level.playerhastknife)) {
    level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
    level.player scripts\mp\equipment::incrementequipmentslotammo("primary", 1);
  }

  if(istrue(level.playerhastrock)) {
    level.player scripts\mp\equipment::giveequipment("equip_rock", "primary");
    level.player scripts\mp\equipment::incrementequipmentslotammo("primary", 1);
  }

  level.player.maxhealth = 250;
  level.player.health = 250;
  waitframe();

  if(isDefined(level.playerspawndata)) {
    anchor = spawn("script_model", level.playerspawndata.origin);
    anchor setModel("tag_origin");
    anchor.angles = level.playerspawndata.angles;
    wait 0.5;
    level.player playerlinkTo(anchor, "tag_origin", 1, 0, 0, 0, 0);

    if(game["trial"]["tries_remaining"] >= 3)
      wait 8;
    else
      wait 0.5;

    level.player unlink();
  }

  level.player freezecontrols(1);
  level scripts\engine\utility::flag_wait("trial_prestart");
  wait 0.25;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.player.ignoreriotshieldxp = 1;
  level scripts\engine\utility::flag_wait("trial_completed");

  while(!level.player isonground())
    wait 0.05;

  level.player freezelookcontrols(1);
  level.player freezecontrols(1);
}

player_monitor_death() {
  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  setDvar("scr_death_scene_time", 6.2);
  setdynamicdvar("dvar_FA0A136294E75014", 0);
  level.player waittill("death");
  setDvar("scr_death_scene_time", 1.75);
  level.player setclientomnvar("ui_killcam_killedby_id", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("trial_player_death");
  level scripts\engine\utility::flag_set("trial_completed");
  level.player waittill("spawned_player");
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 4);

  if(isDefined(level.playerspawndata)) {
    anchor = spawn("script_model", level.playerspawndata.origin);
    anchor setModel("tag_origin");
    anchor.angles = level.playerspawndata.angles;
    wait 0.5;
    level.player playerlinkTo(anchor, "tag_origin", 1, 0, 0, 0, 0);

    if(game["trial"]["tries_remaining"] >= 3)
      wait 8;
    else
      wait 0.5;

    level.player unlink();
    level.player takeallweapons(0, 1);
    level.player giveweapon("iw9_me_fists_mp");
  }
}

enemies_init() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  foreach(script_model in level.enemy_spawners)
  script_model setModel("tag_origin");

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  if(level.player.team == "axis")
    level.enemyteam = "allies";
  else
    level.enemyteam = "axis";

  level.agent_definition["actor_enemy_mp_trial_fil"]["team"] = level.enemyteam;

  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  foreach(spawner in level.enemy_spawners) {
    if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy != "spawn_enemy")
      spawner.script_index = int(spawner.script_noteworthy);
  }

  thread enemy_mines_init();
  scripts\engine\utility::array_thread(level.enemy_spawners, ::enemy_individual_spawn);
}

enemy_individual_spawn() {
  self waittill("trigger");
  _id_F1DEDCCA27836AD7 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_mp_trial_fil", self.origin, self.angles);

  while(!isDefined(_id_F1DEDCCA27836AD7))
    wait 0.05;

  _id_F1DEDCCA27836AD7.grenadeammo = 0;
  _id_F1DEDCCA27836AD7._id_98ADD129A7ECB962 = 0;
  _id_F1DEDCCA27836AD7 agentsetfavoriteenemy(level.player);
  _id_F1DEDCCA27836AD7 thread enemy_damage_monitoring();
  _id_F1DEDCCA27836AD7 thread enemy_monitor_death();
  _id_F1DEDCCA27836AD7 thread enemy_monitor_reload();
  _id_F1DEDCCA27836AD7 thread enemy_monitor_trialending();
  head = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  body = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(_id_F1DEDCCA27836AD7.headmodel))
    _id_F1DEDCCA27836AD7 detach(_id_F1DEDCCA27836AD7.headmodel);

  _id_F1DEDCCA27836AD7 setModel(body);
  _id_F1DEDCCA27836AD7 attach(head, "", 1);
  _id_F1DEDCCA27836AD7.headmodel = head;
  _id_F1DEDCCA27836AD7 waittill("shooting");
  level notify("enemy_shooting");
}

enemy_damage_monitoring() {
  while(isalive(self)) {
    wait 0.05;
    self waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    scripts\engine\utility::array_contains(level.players, attacker);
    self kill();
    level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 1);
  }
}

enemy_monitor_death() {
  level endon("trial_completed");

  if(isalive(self)) {
    self waittill("death", _id_B4656BFA88D54617, attacker, cause, objweapon);

    if(isalive(level.player))
      _id_B4656BFA88D54617 = scripts\engine\utility::array_contains(level.players, attacker);
    else
      _id_B4656BFA88D54617 = 0;
  } else
    _id_B4656BFA88D54617 = 0;

  if(_id_B4656BFA88D54617)
    level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 1);

  level.player notify("enemy_killed");
}

enemy_monitor_reload() {
  self endon("death");
  level endon("trial_completed");

  while(isalive(self)) {
    self.dontevershoot = 0;
    self.bulletsinclip = 20;
    self.accuracy = 0.2;

    while(self.bulletsinclip > 12)
      wait 0.05;

    self.accuracy = 0.5;

    while(self.bulletsinclip > 3)
      wait 0.05;

    self.dontevershoot = 1;
    wait 0.5;

    if(isDefined(self))
      self playsoundonmovingent("trial_sfx_enemyreloading_us");

    wait 3.5;
  }
}

enemy_monitor_trialending() {
  self endon("death");

  while(!scripts\engine\utility::flag("trial_completed"))
    wait 0.5;

  self.dontevershoot = 1;
  wait 5;

  if(isalive(self))
    self despawnagent();
}

enemy_mines_init() {
  scripts\engine\utility::flag_wait("trial_prestart");
  _id_95270422AD340029 = getEntArray("enemy_mine", "targetname");

  foreach(mine in _id_95270422AD340029) {
    mine setModel("offhand_wm_at_mine");
    mine setCanDamage(1);
    mine thread enemy_mine_proximity_think();
    mine thread enemy_mine_damaged_think();
  }

  scripts\engine\utility::flag_wait("trial_in_progress");

  foreach(mine in _id_95270422AD340029) {
    if(isDefined(mine))
      playFXOnTag(level.mine_light_vfx, mine, "j_bomb");
  }
}

enemy_mine_proximity_think() {
  self endon("mine_neutralized");

  for(;;) {
    _id_89FD21279A147330 = distance2d(self.origin, level.player.origin);
    _id_7650F47A868A4E54 = abs(self.origin[2] - level.player.origin[2]);

    if(_id_89FD21279A147330 < 140 && _id_7650F47A868A4E54 < 50) {
      break;
    } else
      waitframe();
  }

  _id_2CA44F3134782E9D = self.origin + (0, 0, 55);
  _id_04C38D923A22CEB8 = 1;
  _id_7D5649DDF7A44EEE = magicgrenademanual("at_mine_ap_mp", _id_2CA44F3134782E9D, (0, 0, 0), _id_04C38D923A22CEB8);
  killfxontag(level.mine_light_vfx, self, "j_bomb");
  playFXOnTag(level.mine_launch_vfx, self, "tag_origin");
  self moveTo(_id_2CA44F3134782E9D, _id_04C38D923A22CEB8 / 2, 0, _id_04C38D923A22CEB8 / 3);
  self rotateby((0, 1080, 0), _id_04C38D923A22CEB8);
  self playsoundonmovingent("mine_betty_click");
  wait(_id_04C38D923A22CEB8);

  if(level.player getstance() != "prone") {
    _id_8516B2BF8F4DA6D7 = 140 * level.player.maxhealth / 100;
    _id_ED91F3EC33AF8C15 = 70 * level.player.maxhealth / 100;
    range = 175;
    radiusdamage(_id_2CA44F3134782E9D, range, _id_8516B2BF8F4DA6D7, _id_ED91F3EC33AF8C15, self, "MOD_GRENADE_SPLASH");
  }

  playFX(level.mine_explosion_vfx, _id_2CA44F3134782E9D);
  level.player playRumbleOnEntity("damage_heavy");
  self notify("mine_explosion");
  self setModel("tag_origin");
  wait 1;
  self delete();
}

enemy_mine_damaged_think() {
  self endon("mine_explosion");
  self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
  level.player _id_5762AC2F22202BA2::updatedamagefeedback("standard");
  killfxontag(level.mine_light_vfx, self, "j_bomb");
  playFX(level.mine_destroyed_vfx, self.origin);
  self playsoundonmovingent("mp_equip_destroyed");
  self notify("mine_neutralized");
  waitframe();
  self delete();
}

hud_init() {
  level.score = [];
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(game["trial"]["best_reward"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  level.player setclientomnvar("ui_match_in_progress", 1);
}

hud_objectives() {
  while(!isDefined(level.waypoints))
    waitframe();

  scripts\mp\trials\trial_utility::trial_ui_set_objective_icon_index(0);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.waypoints_reached, level.waypoints.size);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "floor_time", 0, 0);

  while(!isDefined(level.player))
    wait 0.05;

  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.waypoints_reached, level.waypoints.size);
  scripts\engine\utility::flag_wait("trial_prestart");

  while(level.waypoints_reached < level.waypoints.size) {
    hud_set_progress();
    wait 0.05;
  }

  hud_set_progress();
  level notify("stop_timer");
  level scripts\engine\utility::flag_set("trial_completed");
  level notify("course_ended");
}

hud_set_progress() {
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.waypoints_reached, level.waypoints.size);
  _id_9456ACCD8CA18BAC = scripts\mp\utility\script::limitdecimalplaces(level.time_on_floor / 1000, 1);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.time_on_floor, _id_9456ACCD8CA18BAC);
}

hud_set_timers() {
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.totaltime);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.timeelapsed);
}

hud_timer() {
  hud_set_timers();
  level scripts\engine\utility::flag_wait("trial_in_progress");
  level.player playSound("trial_sfx_start");
  starttime = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    time = gettime() - starttime;
    level.timeelapsed = int(time);
    hud_set_timers();
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    level.timeelapsed = scripts\engine\math::round_float(level.timeelapsed / 1000, 1, 0) * 1000;
    level.time_on_floor = scripts\engine\math::round_float(level.time_on_floor / 1000, 1, 0) * 1000;
    level.totaltime = level.timeelapsed + level.time_on_floor;
    hud_set_timers();

    if(game["trial"]["best_time"] <= 0 || level.totaltime < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = level.totaltime;
      hud_besttime_update();
      game["trial"]["analytics"]["best_floortime"] = level.time_on_floor;
    }
  } else {
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
    level.totaltime = -1;
  }

  if(istrue(level.trial_special_end)) {
    level.score["total"] = level.totaltime;
    wait 4;
  }

  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
}

hud_reward_tiers_tracking() {
  self endon("stop_timer");
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);
  self waittill("trial_in_progress");
  _id_72408207126E9282 = [];
  _id_72408207126E9282[0] = undefined;
  _id_72408207126E9282[1] = level.trial["tier1"];
  _id_72408207126E9282[2] = level.trial["tier2"];
  _id_72408207126E9282[3] = level.trial["tier3"];

  for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    level.attempttier = _id_AC0E594AC96AA3A8;
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(_id_AC0E594AC96AA3A8);

    if(isDefined(_id_72408207126E9282[_id_AC0E594AC96AA3A8])) {
      while(level.timeelapsed < _id_72408207126E9282[_id_AC0E594AC96AA3A8] - 5000)
        wait 0.05;

      for(t = 5; t > 0; t--) {
        level.player playSound("trial_sfx_failure_countdown");
        wait 1;
      }

      level.player playSound("trial_sfx_failure");
    }
  }
}

hud_attempt_over() {
  level scripts\engine\utility::flag_wait("trial_completed");
  setDvar("scr_death_scene_time", 1.75);

  while(!level.player isonground())
    wait 0.05;

  level.player freezecontrols(1);

  while(level.totaltime == 0)
    waitframe();

  _id_B2687459B6112394 = scripts\mp\trials\trial_utility::get_tier_reward_for_total_time();

  if(!scripts\engine\utility::flag("trial_player_death")) {
    _id_A691794C4E79B4C4 = game["trial"]["best_reward"];

    if(_id_B2687459B6112394 > _id_A691794C4E79B4C4) {
      game["trial"]["best_reward"] = _id_B2687459B6112394;
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(_id_B2687459B6112394);
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
    level.player playSound("trial_sfx_failure");
    setomnvar("ui_trial_failed", 1);
    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 1.25);
  }

  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  level scripts\engine\utility::flag_wait("trial_ready_for_endscreen");
  _id_9456ACCD8CA18BAC = scripts\mp\utility\script::limitdecimalplaces(level.time_on_floor / 1000, 1);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.time_on_floor, _id_9456ACCD8CA18BAC);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.time_on_floor, level.time_on_floor);
  thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  level.player freezecontrols(1);
  level.trial_restarting = 1;
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  _id_467003532BDC5C8A = game["trial"]["tries_remaining"];

  if(_id_467003532BDC5C8A > 0) {
    setDvar("dvar_87E6EBAF31BA0533", "true");
    level notify("game_cleanup");
    level notify("restarting");
    level notify("trial_retry");
    game["state"] = "playing";
    scripts\mp\trials\trial_utility::trial_restart();
  } else {}
}

hud_besttime_update() {
  besttime = game["trial"]["best_time"];
  _id_A691794C4E79B4C4 = game["trial"]["best_reward"];
  scripts\mp\trials\trial_utility::trial_ui_set_best_time(besttime);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(_id_A691794C4E79B4C4);
}

dialog_init() {
  game["dialog"]["trial_intro"] = "mp_petrograd_intro";
  game["dialog"]["trial_intro_short"] = "mp_petrograd_intro_short";
  game["dialog"]["trial_end_tier_0"] = "mp_petrograd_end_0star";
  game["dialog"]["trial_end_tier_0_alt"] = "mp_petrograd_obj_fail";
  game["dialog"]["trial_end_tier_1"] = "mp_petrograd_end_1star";
  game["dialog"]["trial_end_tier_2"] = "mp_petrograd_end_2star";
  game["dialog"]["trial_end_tier_3"] = "mp_petrograd_end_3star";
  game["dialog"]["trial_retry"] = "mp_petrograd_vo_retry";
  game["dialog"]["fil_start"] = "mp_petrograd_obj_nag_start";
  game["dialog"]["fil_hurry_up"] = "mp_petrograd_obj_nag_hurry";
  game["dialog"]["fil_shield_raise"] = "mp_petrograd_obj_shield";
  game["dialog"]["fil_shield_stow"] = "mp_petrograd_vo_clue";
  game["dialog"]["fil_wait_enemy_reload"] = "mp_petrograd_vo_clue2";
  game["dialog"]["fil_climb_back_up"] = "mp_petrograd_obj_nag_ingas";
  scripts\engine\utility::flag_wait("trial_in_progress");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_start");
  thread dialog_monitor_hurry();
  thread dialog_monitor_shieldraise();
  thread dialog_monitor_shieldstow();
  thread dialog_monitor_waitreload();
  thread dialog_monitor_getoffground();
}

dialog_monitor_hurry() {
  level endon("trial_completed");
  _id_AC0E594AC96AA3A8 = 0;
  _id_6AEC809BE13C61CC = 0;

  if(level.trial["variant"] == "free")
    _id_A4AEEFDC0706DFE4 = 14;
  else
    _id_A4AEEFDC0706DFE4 = 8;

  for(;;) {
    if(level.waypoints_reached == _id_6AEC809BE13C61CC)
      _id_AC0E594AC96AA3A8++;
    else
      _id_AC0E594AC96AA3A8 = 0;

    if(_id_AC0E594AC96AA3A8 > _id_A4AEEFDC0706DFE4) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_hurry_up");
      _id_AC0E594AC96AA3A8 = 0;
    }

    _id_6AEC809BE13C61CC = level.waypoints_reached;
    wait 1;
  }
}

dialog_monitor_shieldraise() {
  level endon("trial_completed");

  for(;;) {
    level waittill("enemy_shooting");
    wait 0.5;
    _id_89162A7340BA32F3 = level.player getcurrentweapon();

    if(_id_89162A7340BA32F3.basename != "iw8_me_riotshield_mp")
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_shield_raise");
  }
}

dialog_monitor_shieldstow() {
  level endon("trial_completed");

  if(istrue(level.playerhastknife)) {
    return;
  }
  for(;;) {
    level.player waittill("enemy_killed");
    dialog_play_shieldstow();
  }
}

dialog_play_shieldstow() {
  level endon("enemy_shooting");
  wait 1.5;
  _id_89162A7340BA32F3 = level.player getcurrentweapon();

  if(_id_89162A7340BA32F3.basename == "iw8_me_riotshield_mp")
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_shield_stow");
}

dialog_monitor_waitreload() {
  level endon("trial_completed");
  _id_AC391DDD4B0F0292 = undefined;
  allweapons = level.player getweaponslistall();

  foreach(weapon in allweapons) {
    if(weapon.basename == "iw8_me_riotshield_mp")
      _id_AC391DDD4B0F0292 = weapon;
  }

  if(isDefined(_id_AC391DDD4B0F0292)) {
    while(!scripts\engine\utility::flag("trial_completed")) {
      level.player waittill("shield_blocked");
      wait 0.3;
      _id_89162A7340BA32F3 = level.player getcurrentweapon();

      if(_id_89162A7340BA32F3.basename == "iw8_me_riotshield_mp") {
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_wait_enemy_reload");
        wait 41;
      }
    }
  }
}

dialog_monitor_getoffground() {
  level endon("trial_completed");

  while(!scripts\engine\utility::flag("trial_completed")) {
    level.player waittill("gas_warning_vo");
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_climb_back_up");
    wait 4;
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_lava;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_floortime"] = 0;
  }
}

trial_dlog_lava() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  time = getomnvar("ui_trial_best_time");
  _id_F7E3616498F563B8 = int(game["trial"]["analytics"]["best_floortime"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_lava", ["id", id, "tier", tier, "time", time, "floortime", _id_F7E3616498F563B8]);
}