/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_72936e9d89227eaf.gsc
***********************************************/

register_spawners() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("strike_init_done");

  if(!scripts\engine\utility::flag_exist("cp_raid1_nums_puzzle_cs_completed"))
    scripts\engine\utility::flag_init("cp_raid1_nums_puzzle_cs_completed");

  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  level._id_A367B001F499E660 = 250;
  level._id_38B8D41AA0C9B2B2 = 0.05;
  level._id_381058397007C792 = ::_id_9F21E0004DAD2995;
  level thread _id_41328D99A64A9813::elevator_manager();
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  register_outer_room_spawners("2");
  register_outer_room_spawners("3");
  register_outer_room_spawners("4");
  [[spawnfunc]]("seq3_group_finale", 6, 6, 350, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_1", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_finale", ::_id_E6FCA12D85FE23C4);
  _id_F5BCFD69E0D0A30F = 25;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_F5BCFD69E0D0A30F = 20;

  [[spawnfunc]]("seq3_group_finale_door_1", 4, 4, 4, [scripts\cp\cp_wave_spawning::module_wave_spawn, _id_F5BCFD69E0D0A30F, 2], 0, "seq3_group_finale_door_1", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_finale_door_1", ::_id_3573BA205A97DF13);
  [[spawnfunc]]("seq3_group_finale_door_2", 4, 4, 4, [scripts\cp\cp_wave_spawning::module_wave_spawn, _id_F5BCFD69E0D0A30F, 2], 0, "seq3_group_finale_door_2", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_finale_door_2", ::_id_3573BA205A97DF13);
  [[spawnfunc]]("seq3_spawners_intro", 14, 14, 14, 0.1, 0, "seq3_spawners_intro", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_spawners_intro", ::_id_4B19B5470E125A8D);
  [[spawnfunc]]("seq3_spawners_intro_ambush", 7, 7, 7, 0.1, 0, "seq3_spawners_intro_ambush", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_spawners_intro_ambush", ::run_stealth_funcs);
  [[spawnfunc]]("seq3_group_intro_jugg", 2, 2, 2, 0.1, 0, "seq3_group_intro_jugg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_intro_jugg", ::_id_388ED9C4B4EEEA63);
  [[spawnfunc]]("seq3_group_killwave_a", 2, 2, 2, 0.1, 0, "seq3_group_killwave_a", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_a", ::_id_98C0B52D2EFB98DE);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_a", ::_id_3F317306C97C6EC1);
  [[spawnfunc]]("seq3_group_killwave_b", 2, 2, 2, 0.1, 0, "seq3_group_killwave_b", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_b", ::_id_98C0B52D2EFB98DE);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_b", ::_id_3F317306C97C6EC1);
  [[spawnfunc]]("seq3_group_killwave_jugg_1", 1, 1, 1, 0.1, 0, "seq3_group_killwave_jugg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_jugg_1", ::_id_A00C832EF50A4396);
  [[spawnfunc]]("seq3_group_killwave_jugg_2", 1, 1, 1, 0.1, 0, "seq3_group_killwave_jugg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_jugg_2", ::_id_A00C832EF50A4396);
  [[spawnfunc]]("seq3_group_killwave_jugg_3", 1, 1, 1, 0.1, 0, "seq3_group_killwave_jugg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_jugg_3", ::_id_A00C832EF50A4396);
  [[spawnfunc]]("seq3_group_killwave_jugg_4", 1, 1, 1, 0.1, 0, "seq3_group_killwave_jugg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_killwave_jugg_4", ::_id_A00C832EF50A4396);
  groups = [];
  groups[groups.size] = "seq3_group_2_easy_ar";
  groups[groups.size] = "seq3_group_3_easy_ar";
  groups[groups.size] = "seq3_group_4_easy_ar";
  groups[groups.size] = "seq3_group_2_easy_smg";
  groups[groups.size] = "seq3_group_3_easy_smg";
  groups[groups.size] = "seq3_group_4_easy_smg";
  groups[groups.size] = "seq3_group_2_easy_shotgun";
  groups[groups.size] = "seq3_group_3_easy_shotgun";
  groups[groups.size] = "seq3_group_4_easy_shotgun";
  groups[groups.size] = "seq3_group_2_med_ar";
  groups[groups.size] = "seq3_group_3_med_ar";
  groups[groups.size] = "seq3_group_4_med_ar";
  groups[groups.size] = "seq3_group_2_med_smg";
  groups[groups.size] = "seq3_group_3_med_smg";
  groups[groups.size] = "seq3_group_4_med_smg";
  groups[groups.size] = "seq3_group_2_med_shotgun";
  groups[groups.size] = "seq3_group_3_med_shotgun";
  groups[groups.size] = "seq3_group_4_med_shotgun";
  groups[groups.size] = "seq3_group_2_med_riotshield";
  groups[groups.size] = "seq3_group_3_med_riotshield";
  groups[groups.size] = "seq3_group_4_med_riotshield";
  groups[groups.size] = "seq3_group_2_hard_lmg";
  groups[groups.size] = "seq3_group_3_hard_lmg";
  groups[groups.size] = "seq3_group_4_hard_lmg";
  level thread set_distances_for_groups(groups);
}

register_outer_room_spawners(_id_D1FAA34F45A4DB29) {
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  _id_26A19DF65B1901CD = 14;
  _id_DAFE7EC756B48FAA = 28;
  _id_27870846EAF75448 = 0;
  _id_75B4EBE6956BC0B2 = 0;
  _id_C56E06FB1B4076C6 = 0;
  _id_96ECBF21C9797176 = 0;
  _id_58D5BC5509988BDC = 0;
  _id_0B7211E6F20C62C4 = 0;
  _id_083B6A5580D642FD = 0;
  _id_4BDEDE51D0EEC9D7 = 0;
  _id_304B639F71BEFEA7 = 0;
  _id_73907B0C4FC36BBA = _id_75B4EBE6956BC0B2 + _id_58D5BC5509988BDC + _id_4BDEDE51D0EEC9D7;
  _id_125BC4611BB63C53 = 0;
  _id_FBBB9F42F123AF09 = 0;
  _id_2A6A943028526EED = 0;
  _id_2A3A04A58BFAF01F = 4;
  _id_7B4270CE89CDDA15 = 4;
  _id_A2A5EDA6C6320B41 = 4;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2A3A04A58BFAF01F = 8;
    _id_7B4270CE89CDDA15 = 8;
    _id_A2A5EDA6C6320B41 = 8;
  }

  _id_4BAA4EFDDE2A6010 = 0;
  _id_C30AA85D895AC4EA = 0;
  _id_AF3736FF90E8BB1E = 0;
  _id_F2C5CAADC5B7A9CF = 0;
  _id_081172B16FB45385 = 0;
  _id_801FDB6F48939911 = 0;
  _id_7F321694ECEB6A37 = _id_FBBB9F42F123AF09 + _id_7B4270CE89CDDA15 + _id_C30AA85D895AC4EA + _id_081172B16FB45385;
  _id_42FD23F343A52BEC = 2;
  _id_7F68EBFE839A9256 = 2;
  _id_77695A9970FB8C42 = 2;
  _id_EF3A85F15DF65902 = 3;
  _id_B5DB6E864613C988 = 3;
  _id_0E7C299DC6C72ED8 = 3;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_42FD23F343A52BEC = 6;
    _id_7F68EBFE839A9256 = 6;
    _id_77695A9970FB8C42 = 6;
    _id_EF3A85F15DF65902 = 5;
    _id_B5DB6E864613C988 = 5;
    _id_0E7C299DC6C72ED8 = 5;
  }

  _id_77CC1CE9E582C045 = _id_7F68EBFE839A9256 + _id_B5DB6E864613C988;
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_ar", _id_27870846EAF75448, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_73907B0C4FC36BBA, _id_75B4EBE6956BC0B2], _id_C56E06FB1B4076C6, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_ar", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_ar", ::_id_CDEF776C1BB34E83);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_smg", _id_96ECBF21C9797176, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_73907B0C4FC36BBA, _id_58D5BC5509988BDC], _id_0B7211E6F20C62C4, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_smg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_smg", ::_id_CDEF776C1BB34E83);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_shotgun", _id_083B6A5580D642FD, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_73907B0C4FC36BBA, _id_4BDEDE51D0EEC9D7], _id_304B639F71BEFEA7, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_shotgun", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_easy_shotgun", ::onspawn_fastspeed);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_ar", _id_125BC4611BB63C53, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_7F321694ECEB6A37, _id_FBBB9F42F123AF09], _id_2A6A943028526EED, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_ar", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_ar", ::_id_CDEF776C1BB34E83);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_smg", _id_2A3A04A58BFAF01F, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_7F321694ECEB6A37, _id_7B4270CE89CDDA15], _id_A2A5EDA6C6320B41, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_smg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_smg", ::_id_CDEF776C1BB34E83);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_shotgun", _id_4BAA4EFDDE2A6010, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_7F321694ECEB6A37, _id_C30AA85D895AC4EA], _id_AF3736FF90E8BB1E, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_shotgun", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_shotgun", ::onspawn_fastspeed);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_riotshield", _id_F2C5CAADC5B7A9CF, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_7F321694ECEB6A37, _id_081172B16FB45385], _id_801FDB6F48939911, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_riotshield", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_med_riotshield", ::_id_CDEF776C1BB34E83);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_lmg", _id_42FD23F343A52BEC, [_id_18A73A64992DD07D::set_count_based_on_grouped_modules, "group_" + _id_D1FAA34F45A4DB29, _id_77CC1CE9E582C045, _id_7F68EBFE839A9256], _id_77695A9970FB8C42, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20, 2], 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_lmg", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_lmg", ::_id_3E445C90223589B7);
  [[spawnfunc]]("seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_shotgun", _id_EF3A85F15DF65902, _id_B5DB6E864613C988, _id_0E7C299DC6C72ED8, randomfloatrange(0.2, 1.5), 0, "seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_shotgun", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("seq3_group_" + _id_D1FAA34F45A4DB29 + "_hard_shotgun", ::_id_29EF7B5AC92A56E9);
}

run_stealth_funcs(group_name, func) {
  _id_F0D0842E8A7BD953 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(_id_F0D0842E8A7BD953);

  if(!scripts\engine\utility::flag("seq3_poweron"))
    _id_18A73A64992DD07D::set_goal_radius(32);
  else
    _id_18A73A64992DD07D::set_goal_radius(384);

  self.goalheight = 64;
  self.script_origin_other = _id_F0D0842E8A7BD953;

  if(getdvarint("dvar_040A971D0C661A20", -1) > 0)
    self allowedstances("stand");

  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self _meth_D493E7FE15E5EAF4("cp_raid1_intro");
  _id_CDEF776C1BB34E83();
}

_id_4B19B5470E125A8D(group_name, func) {
  self._id_521B323847D55E32 = 1;
  thread _id_A38435264A615C5F();
  thread run_stealth_funcs(group_name, func);
}

_id_A38435264A615C5F() {
  self endon("death");
  scripts\engine\utility::waittill_any_2("damage", "nearby_intro_damaged");
  _id_01D4621C77C9108F = getaiarray("axis");
  _id_310236DBF257FBB5 = scripts\engine\utility::get_array_of_closest(self.origin, _id_01D4621C77C9108F, [self], undefined, 512);

  foreach(ai in _id_310236DBF257FBB5)
  ai notify("nearby_intro_damaged");

  _id_18A73A64992DD07D::set_goal_radius(512);
}

_id_CDEF776C1BB34E83(group_name, func) {
  _id_18A73A64992DD07D::_id_9426D24DFB73528D();
  thread _id_B574E8A369EE441C();
}

_id_A00C832EF50A4396(group_name, func) {
  _id_18A73A64992DD07D::set_goal_radius(192);

  foreach(player in level.players)
  self getenemyinfo(player);

  thread _id_603A4B9137D257C8();
}

_id_603A4B9137D257C8() {
  level endon("game_ended");
  self endon("death");
  _id_18A73A64992DD07D::set_goal_radius(192);

  foreach(player in level.players)
  self getenemyinfo(player);

  for(;;) {
    wait 5;
    nearbyplayer = scripts\cp\utility::get_closest_living_player();
    _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(nearbyplayer.origin));

    foreach(player in level.players)
    self getenemyinfo(player);
  }
}

_id_388ED9C4B4EEEA63(group_name, func) {
  thread _id_E8B634FE05EC8804(1200);
  thread run_stealth_funcs(group_name, func);
}

_id_E8B634FE05EC8804(radius) {
  self endon("death");
  _id_1A96B3062BB2C598 = radius * radius;
  self.ignoreall = 1;

  while(!scripts\cp\utility::any_player_nearby(self.origin, _id_1A96B3062BB2C598))
    wait 0.5;

  self.ignoreall = 0;
  target = scripts\cp\utility::get_closest_living_player();

  if(isDefined(target)) {
    self getenemyinfo(target);
    _id_18A73A64992DD07D::set_goal_pos(target.origin);
  }
}

_id_98C0B52D2EFB98DE(group_name, func) {
  _id_41328D99A64A9813::trigger_elevator_spawners(group_name);
  thread _id_4888D135F9234C00();
}

_id_4888D135F9234C00() {
  self endon("death");
  wait 5;
  _id_18A73A64992DD07D::_id_9426D24DFB73528D();
  _id_18A73A64992DD07D::set_goal_radius(150);
  wait 0.25;
  event = undefined;
  _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(_id_C729D49D406ACED8)) {
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = _id_C729D49D406ACED8.origin;
    event.investigate_pos = _id_C729D49D406ACED8.origin;
  }

  scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_0B4A9539864D5B09);
  self._id_5323A94889EFF1DE = 1;

  if(isDefined(self.fnsetstealthstate))
    self[[self.fnsetstealthstate]]("combat", event);

  for(;;) {
    foreach(player in level.players)
    self getenemyinfo(player);

    target = scripts\cp\utility::get_closest_living_player();

    if(isDefined(target))
      _id_18A73A64992DD07D::set_goal_pos(target.origin);

    wait 10;
  }
}

_id_B574E8A369EE441C() {
  self endon("death");

  while(!scripts\engine\utility::ent_flag_exist("stealth_enabled"))
    wait 1;

  scripts\engine\utility::ent_flag_wait("stealth_enabled");

  if(scripts\engine\utility::flag("seq3_poweron") && isDefined(self.fnsetstealthstate)) {
    _id_18A73A64992DD07D::set_goal_radius(1024);
    self[[self.fnsetstealthstate]]("combat");
  }
}

onspawn_slowspeed(group_name, func) {
  scripts\engine\utility::set_movement_speed(75);
  _id_CDEF776C1BB34E83();
}

onspawn_fastspeed(group_name, func) {
  scripts\engine\utility::set_movement_speed(110);
  scripts\common\utility::demeanor_override("sprint");
  _id_CDEF776C1BB34E83();
}

_id_29EF7B5AC92A56E9(group_name, func) {
  scripts\engine\utility::set_movement_speed(110);
  scripts\common\utility::demeanor_override("sprint");
  _id_CDEF776C1BB34E83();
  thread _id_6A002407E8D3E6EB(1);
  _id_34607869F39097EC = scripts\engine\utility::getStructArray("red_hard_smokepoint", "targetname");
  _id_C257C7A710CD5417 = scripts\engine\utility::getclosest(self.origin, _id_34607869F39097EC);
  level thread smoke_wheelson_chosen_spawn(1, self.origin);
  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 4;
  self.script_forcegrenade = 1;
}

_id_3E445C90223589B7(group_name, func) {
  scripts\engine\utility::set_movement_speed(75);
  _id_CDEF776C1BB34E83();
  _id_046ED662485EA221(self);
  weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_A664AAD02EE98BD2 = "gas_mp";
  self.allowpain = 0;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = 840;
  self.goalradius = 720;
  self._id_ED331803DB44891B = 1;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
}

_id_046ED662485EA221(agent) {
  if(istrue(agent._id_102A9D2CF99AB325)) {
    return;
  }
  agent._id_65771500F49956C1 = 1;
  agent._id_102A9D2CF99AB325 = 1;
  agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_CD6A3A50F09688B9 = ::_id_6950EC92C0AB0545;
}

_id_6950EC92C0AB0545(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_65771500F49956C1 = 0;
  _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(agent, attacker);
}

set_distances_for_groups(groups) {
  foreach(group_name in groups) {
    _id_18A73A64992DD07D::set_spawn_scoring_params_for_group(group_name, undefined, 20000, 30000);
    _id_18A73A64992DD07D::register_module_ai_spawn_func(group_name, ::_id_3F317306C97C6EC1);
  }
}

_id_3F317306C97C6EC1(group_name) {
  _id_F651103B71C9508F = scripts\engine\utility::getclosest(self.origin, level.spawn_elevators, level._id_A367B001F499E660);

  if(isDefined(_id_F651103B71C9508F)) {
    _id_18A73A64992DD07D::set_goal_radius(8);
    self setgoalpos(self getclosestreachablepointonnavmesh(self.origin));
    _id_41328D99A64A9813::trigger_elevator_spawners(group_name);
  } else
    _id_18A73A64992DD07D::set_goal_radius(1024);
}

_id_9F21E0004DAD2995(group_name) {
  wait 2;
}

watchforstopwaves(group) {
  level endon("game_ended");
  level thread _watchforstopwaves(group);
}

_watchforstopwaves(group) {
  level endon("game_ended");
  level waittill("end_wave_seq3_spawners");
  level notify("spawn_module_" + group.moduleid + "_completed");
}

wake_everyone_up() {
  if(istrue(level.global_stealth_broken)) {
    return;
  }
  level.global_stealth_broken = 1;
  level notify("weapons_free");
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(_id_2E90373C39823C95 in _id_CCC9F9C05ABCFDE9)
  _id_2E90373C39823C95 thread _id_18A73A64992DD07D::enter_combat();

  level thread scripts\cp\coop_stealth::deactivate_stealth_settings();
  level notify("stealth_settings_activated");
}

spawn_enemies_intro() {
  if(getdvarint("dvar_649AC2B55F8F5FD5", 0) > 0) {
    return;
  }
  if(istrue(level._id_E13D1DE65E306886)) {
    return;
  }
  _id_1E9BF201EA44567C::_id_5A52715BF68D9C6C();
  waitframe();
  level.seq3_spawners_intro = _id_18A73A64992DD07D::run_spawn_module("seq3_spawners_intro");
  level._id_184BFD79352836A7 = _id_18A73A64992DD07D::run_spawn_module("seq3_spawners_intro_ambush");
  level._id_946D88DCD09BDA96 = _id_18A73A64992DD07D::run_spawn_module("seq3_group_intro_jugg");
  level thread _id_D8749A08C683E2CB();
  level thread _id_2F67B659D3A964F8();
}

_id_D8749A08C683E2CB() {
  level._id_7AE7CCFF11823A4B = 1;
  _id_43C8CCE084D817D2 = 1;
  max_drones = 20;
  spawnpoint = scripts\engine\utility::getStruct("seq3_bombdrone_spawn_intro", "targetname");
  spawnfunc = _id_6E2CD47141F9745B::_id_CB2C1DF00BD5E191;

  if(level.drone_turrets.size > max_drones) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_43C8CCE084D817D2; _id_AC0E594AC96AA3A8++) {
    drone = level thread[[spawnfunc]](spawnpoint, undefined, "intro");
    wait 0.1;
  }
}

_id_2F67B659D3A964F8() {
  level endon("game_ended");
  wait 2;
  struct = scripts\engine\utility::getStruct("seq3_intro_ambush", "targetname");
  radius = int(struct.radius) * 1.25;
  _id_1A96B3062BB2C598 = radius * radius;
  _id_1B184BB7C1D45F8D = 99980001;
  _id_575250F0985C9DA7 = getaiarrayinradius(struct.origin, radius);

  foreach(ai in _id_575250F0985C9DA7) {
    if(!isalive(ai)) {
      continue;
    }
    ai.ignoreall = 1;
    ai allowedstances("crouch");
    ai thread spawn_in_cover(level._id_184BFD79352836A7);
    ai thread _id_F80A311E41CF2969();
    ai thread _id_36546ACB9564550C();
    ai scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_72BDCEE8226BA1A0);

    if(isDefined(ai.fnsetstealthstate))
      ai[[ai.fnsetstealthstate]]("combat");
  }

  _id_C729D49D406ACED8 = undefined;

  for(;;) {
    _id_C729D49D406ACED8 = scripts\cp\utility::give_closest_player_nearby(struct.origin, _id_1A96B3062BB2C598);

    if(isDefined(_id_C729D49D406ACED8)) {
      break;
    }

    if(istrue(level._id_79A6E03F5749AD73)) {
      break;
    }

    wait 0.1;
  }

  level._id_92EF95DF929D6234 = 1;

  if(!isDefined(_id_C729D49D406ACED8))
    _id_C729D49D406ACED8 = scripts\cp\utility::give_closest_player_nearby(struct.origin, _id_1B184BB7C1D45F8D);

  _id_E338D86DC3095BE7 = undefined;
  _id_64AB71814D4D6A08 = 9999;

  foreach(ai in _id_575250F0985C9DA7) {
    if(!isalive(ai)) {
      continue;
    }
    ai.ignoreall = 0;
    ai allowedstances("stand", "crouch");

    if(isDefined(_id_C729D49D406ACED8))
      ai getenemyinfo(_id_C729D49D406ACED8);

    _id_BA24644BC773A903 = distance2d(ai.origin, _id_C729D49D406ACED8.origin);

    if(_id_BA24644BC773A903 < _id_64AB71814D4D6A08) {
      _id_64AB71814D4D6A08 = _id_BA24644BC773A903;
      _id_E338D86DC3095BE7 = ai;
    }
  }

  if(isDefined(_id_E338D86DC3095BE7))
    _id_E338D86DC3095BE7 thread _id_76216813B2785BAF();
}

_id_72BDCEE8226BA1A0() {
  if(istrue(level._id_92EF95DF929D6234))
    return 1;

  return 0;
}

_id_0B4A9539864D5B09() {
  return 0;
}

_id_76216813B2785BAF() {
  self endon("death");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("nums_dx_ambush_shout", "targetname");
  _id_66FBACFA7822D8B8 = scripts\engine\utility::getclosest(self.origin, _id_9E4E1482CB40C9C5);
  wait 0.6;
  level thread scripts\cp\utility::playsoundatpos_safe(_id_66FBACFA7822D8B8.origin, "dx_bc_raid1nums_shout");
}

spawn_in_cover(group) {
  self.dontkilloff = 1;
  _id_0386C209C4BE9E91 = self getnearestnode();
  _id_5EE5A07D7D8DC443 = 999;

  if(isDefined(_id_0386C209C4BE9E91))
    _id_5EE5A07D7D8DC443 = distance(self.origin, _id_0386C209C4BE9E91.origin);

  if(isDefined(_id_0386C209C4BE9E91) && _id_5EE5A07D7D8DC443 < 128) {
    _id_D38A5EB1292B482C = _id_0386C209C4BE9E91.angles;
    _id_CEE7A3C264A91076 = _id_0386C209C4BE9E91.origin;

    if(!issubstr(_id_0386C209C4BE9E91.type, "Prone")) {
      if(issubstr(_id_0386C209C4BE9E91.type, "Left"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C + (0, 90, 0);
      else if(issubstr(_id_0386C209C4BE9E91.type, "Right") || issubstr(_id_0386C209C4BE9E91.type, "Cover Crouch") || issubstr(_id_0386C209C4BE9E91.type, "Conceal") || issubstr(_id_0386C209C4BE9E91.type, "Cover Stand"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C - (0, 90, 0);
    }

    self forceteleport(_id_CEE7A3C264A91076, _id_D38A5EB1292B482C);
    self _meth_30377946FC33F8A7(_id_0386C209C4BE9E91);
    self setgoalnode(_id_0386C209C4BE9E91);
    self.goalradius = 8;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}

  self.script_origin_other = self.origin;
  _id_18A73A64992DD07D::set_goal_pos(self.origin);
  _id_18A73A64992DD07D::set_goal_radius(64);
}

_id_F80A311E41CF2969() {
  self endon("death");

  for(;;) {
    self waittill("damage", damage, attacker);

    if(isPlayer(attacker)) {
      self.shot_by_player = 1;
      level._id_79A6E03F5749AD73 = 1;
      return;
    }
  }
}

_id_36546ACB9564550C() {
  self waittill("death");
  self.shot_by_player = 1;
  level._id_79A6E03F5749AD73 = 1;
}

delay_spawn_room_soldiers(_id_0756027674083730, _id_09D294094DD8C5F1, _id_81E8E81612BAE9BF) {
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  _id_0CF1441229A2390C = 5 + level.seq3_wave_delay;
  wait(_id_0CF1441229A2390C);
  _id_C6BAE0A3744B7D25 = undefined;

  switch (_id_0756027674083730) {
    case "a":
      _id_C6BAE0A3744B7D25 = "2";
      break;
    case "b":
      _id_C6BAE0A3744B7D25 = "3";
      break;
    case "c":
      _id_C6BAE0A3744B7D25 = "4";
      break;
  }

  _id_5DB2DE478EFAAC52 = [];

  switch (_id_09D294094DD8C5F1) {
    case "med":
      _id_5DB2DE478EFAAC52[_id_5DB2DE478EFAAC52.size] = "smg";
      break;
    case "hard":
      if(isDefined(_id_81E8E81612BAE9BF) && _id_81E8E81612BAE9BF == "red")
        _id_5DB2DE478EFAAC52[_id_5DB2DE478EFAAC52.size] = "shotgun";
      else
        _id_5DB2DE478EFAAC52[_id_5DB2DE478EFAAC52.size] = "lmg";

      break;
  }

  _id_6F3A94C7B5852720 = scripts\engine\utility::getStruct("seq3_center", "targetname").origin;
  playrumbleonposition("grenade_rumble", _id_6F3A94C7B5852720);
  earthquake(0.1, 0.75, _id_6F3A94C7B5852720, 5000);

  foreach(type in _id_5DB2DE478EFAAC52) {
    group = "seq3_group_" + _id_C6BAE0A3744B7D25 + "_" + _id_09D294094DD8C5F1 + "_" + type;

    if(!_id_E2BDD5EAB03E7A30(group, 0.8)) {
      continue;
    }
    if(!_id_E55F4C46BA54C270(group, _id_0756027674083730, 70)) {
      continue;
    }
    _id_8AA2609E46B64970 = _id_18A73A64992DD07D::run_spawn_module(group);
    level.spawn_module_current = _id_8AA2609E46B64970;
  }

  level thread delay_end_soldiers_spawns(10);
}

delay_end_soldiers_spawns(_id_78797A2C7ABEB1CC) {
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  wait(_id_78797A2C7ABEB1CC);
  level notify("end_wave_seq3_spawners");
}

_id_E2BDD5EAB03E7A30(group_name, _id_1ADA018553583002) {
  if(!isDefined(level.spawn_module_structs_memory) || !isDefined(level.spawn_module_structs_memory[group_name]))
    return 1;

  _id_99637F1582E29199 = level.spawn_module_structs_memory[group_name];
  _id_292782DDD72D2E82 = 0;
  _id_3D2E4B298E935C8D = 0;

  foreach(group in _id_99637F1582E29199) {
    _id_292782DDD72D2E82 = _id_292782DDD72D2E82 + group.activecount;
    _id_3D2E4B298E935C8D = _id_3D2E4B298E935C8D + group.totalspawns;
  }

  if(!isDefined(_id_1ADA018553583002))
    _id_1ADA018553583002 = 0.8;

  _id_E4EE38259A172B84 = _id_3D2E4B298E935C8D * _id_1ADA018553583002;

  if(_id_292782DDD72D2E82 > _id_E4EE38259A172B84)
    return 0;
  else
    return 1;
}

_id_E55F4C46BA54C270(group_name, _id_0756027674083730, timeout) {
  _id_3EAE80C4777CE60B = 0;
  _id_C51ED7285268820E = strtok(group_name, "_");

  foreach(str in _id_C51ED7285268820E) {
    if(str == "riotshield")
      _id_3EAE80C4777CE60B = 1;
  }

  if(!_id_3EAE80C4777CE60B)
    return 1;

  if(!isDefined(level._id_3D593DBE27A81D54))
    level._id_3D593DBE27A81D54 = [];

  _id_3E3E6E1DE3B9A61C = group_name + "_" + _id_0756027674083730;

  if(!isDefined(level._id_3D593DBE27A81D54[_id_3E3E6E1DE3B9A61C])) {
    scripts\engine\utility::array_add(level._id_3D593DBE27A81D54, _id_3E3E6E1DE3B9A61C);
    level thread _id_EBFF3A6A7FD84974(_id_3E3E6E1DE3B9A61C, timeout);
    return 1;
  } else if(level._id_3D593DBE27A81D54[_id_3E3E6E1DE3B9A61C] == 0) {
    level thread _id_EBFF3A6A7FD84974(_id_3E3E6E1DE3B9A61C, timeout);
    return 1;
  } else if(level._id_3D593DBE27A81D54[_id_3E3E6E1DE3B9A61C] == 1)
    return 0;
}

_id_EBFF3A6A7FD84974(_id_3E3E6E1DE3B9A61C, timeout) {
  level._id_3D593DBE27A81D54[_id_3E3E6E1DE3B9A61C] = 1;
  wait(timeout);
  level._id_3D593DBE27A81D54[_id_3E3E6E1DE3B9A61C] = 0;
}

_id_6739CAD53E0EB3E2(id, _id_43C8CCE084D817D2, _id_1E4767402B92746D, _id_BFB642DF3AF67591) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  level endon("stop_swarm_drones");

  if(!isDefined(_id_43C8CCE084D817D2))
    _id_43C8CCE084D817D2 = 1;

  if(isDefined(_id_BFB642DF3AF67591)) {
    if(level.drone_turrets.size + _id_43C8CCE084D817D2 > _id_BFB642DF3AF67591) {
      _id_43C8CCE084D817D2 = 2;

      if(isDefined(_id_1E4767402B92746D))
        _id_1E4767402B92746D = _id_1E4767402B92746D + "_" + gettime();
    }
  }

  _id_F7778080C6DDA41D = int(_id_43C8CCE084D817D2 * 0.25);
  _id_F7778080C6DDA41D = min(1, _id_F7778080C6DDA41D);

  foreach(group in level._id_EF94125F71754B2F) {
    if(group.id == id) {
      if(group.drones.size > _id_F7778080C6DDA41D)
        return;
    }
  }

  spawnfunc = _id_6E2CD47141F9745B::_id_CB2C1DF00BD5E191;
  _id_40ADF3976BB3C32A = "seq3_bombdrone_spawn_" + id;
  _id_26312840E0E05273 = scripts\engine\utility::getStructArray(_id_40ADF3976BB3C32A, "targetname");
  spawnpoint = scripts\engine\utility::random(_id_26312840E0E05273);
  max_drones = 21;

  if(isDefined(level._id_9A478B5F4F67D5CD))
    max_drones = level._id_9A478B5F4F67D5CD;

  if(_id_26312840E0E05273.size == 0) {
    return;
  }
  if(level.drone_turrets.size >= max_drones) {
    return;
  }
  if(isDefined(_id_1E4767402B92746D) && isstring(_id_1E4767402B92746D))
    id = id + _id_1E4767402B92746D;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_43C8CCE084D817D2; _id_AC0E594AC96AA3A8++) {
    drone = level thread[[spawnfunc]](spawnpoint, undefined, id);
    wait 0.1;
  }
}

_id_86BE9288A43C423C() {
  level._id_414592408DF6A273 = [];
}

_id_D2C1401BEA9CD6A1(id) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");

  if(id == "b")
    wait 0.1;

  level thread _id_6739CAD53E0EB3E2(id, undefined, "1");
  wait 0.5;
  level thread _id_6739CAD53E0EB3E2(id, undefined, "2");
  _id_BCA9B52EC21D02C4 = 40;

  switch (level.seq3_tier) {
    case 1:
      _id_BCA9B52EC21D02C4 = 40;
      break;
    case 2:
      _id_BCA9B52EC21D02C4 = 30;
      break;
    case 3:
      _id_BCA9B52EC21D02C4 = 10;
      break;
  }

  wait(_id_BCA9B52EC21D02C4);
  level thread _id_6739CAD53E0EB3E2(id, undefined, "3");
  wait 0.5;
  level thread _id_6739CAD53E0EB3E2(id, undefined, "4");
}

_id_A3A54D549FF6E2BF(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  level._id_5F964CB0340D1267 = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_a");
  level._id_5F964DB0340D149A = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_b");
  wait 0.1;
  level thread _id_436044C46BEA395E(level._id_5F964CB0340D1267);
  level thread _id_436044C46BEA395E(level._id_5F964DB0340D149A);
}

_id_436044C46BEA395E(group) {
  level endon("game_ended");

  while(group.ai_spawned.size < 2)
    wait 0.05;

  _id_BFE291B401A9BF2A = [];

  foreach(ai_spawned in group.ai_spawned) {
    _id_CD760946A66E1F27 = ai_spawned.spawner;
    _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = _id_CD760946A66E1F27;
  }

  _id_BFE291B401A9BF2A = scripts\engine\utility::array_remove_duplicates(_id_BFE291B401A9BF2A);

  foreach(spawnstruct in _id_BFE291B401A9BF2A)
  level thread smoke_wheelson_chosen_spawn(0.1, spawnstruct.origin);
}

_id_3AE5F9B05F0B2523(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  level._id_6C1453FCC200CBDF = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_jugg_1");
}

_id_3AE5FAB05F0B2756(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  level._id_6C1454FCC200CE12 = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_jugg_2");
}

_id_3AE5FBB05F0B2989(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  level._id_6C1455FCC200D045 = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_jugg_3");
}

_id_3AE5FCB05F0B2BBC(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  level._id_6C144EFCC200C0E0 = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_jugg_4");
}

_id_9868B574FF995881() {
  _id_D700B218F78E2546 = getEnt("nums_enemy_door_2", "targetname");
  _id_D700B218F78E2546 connectpaths();
  level thread scripts\cp\utility::playsoundatpos_safe(_id_D700B218F78E2546.origin, "cp_puzzledoor_open");

  if(isent(_id_D700B218F78E2546))
    _id_D700B218F78E2546 moveTo(_id_D700B218F78E2546.origin + (0, 0, 500), 6, 0.5, 0.5);

  wait 3;
  level._id_5F964DB0340D149A = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_killwave_b");
}

_id_0DF8F59541BDDD28() {
  level endon("game_ended");
  level endon("stop_finale_drones");
  level._id_9A478B5F4F67D5CD = 18;
  level._id_F753D22AE87B557B = 0;
  _id_D0212FDCCA97006C = 30;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_D0212FDCCA97006C = 25;

  for(;;) {
    level thread _id_6739CAD53E0EB3E2("a", 6, "finale:" + gettime());
    level thread _id_6739CAD53E0EB3E2("b", 6, "finale:" + gettime());
    wait(_id_D0212FDCCA97006C + randomint(5));
  }
}

_id_3573BA205A97DF13(group_name, func) {
  thread _id_C374898975F5F54D(group_name);
}

_id_C374898975F5F54D(group) {
  self endon("death");
  _id_41328D99A64A9813::trigger_elevator_spawners(group);
  wait 10;
  thread _id_6A002407E8D3E6EB(undefined, 750);
}

_id_E6FCA12D85FE23C4(group_name, func) {
  self._id_ED331803DB44891B = 1;
  _id_046ED662485EA221(self);
  thread _id_6A002407E8D3E6EB(undefined, 400);
}

_id_6A002407E8D3E6EB(_id_039484257AA65D17, _id_921B9D1AB6394420) {
  self endon("death");
  wait 0.25;
  _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();
  event = undefined;

  if(isDefined(_id_C729D49D406ACED8)) {
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = _id_C729D49D406ACED8.origin;
    event.investigate_pos = _id_C729D49D406ACED8.origin;
  }

  scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_0B4A9539864D5B09);
  self._id_5323A94889EFF1DE = 1;

  if(isDefined(self.fnsetstealthstate))
    self[[self.fnsetstealthstate]]("combat", event);

  _id_4F0FC1C36324AFFB = squared(500);

  for(;;) {
    _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(_id_C729D49D406ACED8)) {
      if(isDefined(self._id_BF04523BCF587D68) && self._id_BF04523BCF587D68 == _id_C729D49D406ACED8) {
        if(isDefined(self.last_set_goalpos) && distancesquared(self.last_set_goalpos, _id_C729D49D406ACED8.origin) < _id_4F0FC1C36324AFFB) {
          wait 3;
          continue;
        }
      }

      if(isDefined(level._id_15F2D97EE1ACECD4) && level._id_15F2D97EE1ACECD4 == self) {
        wait 5;
        continue;
      }

      radius = 150;

      if(isDefined(_id_921B9D1AB6394420))
        radius = _id_921B9D1AB6394420;

      self getenemyinfo(_id_C729D49D406ACED8);
      _id_18A73A64992DD07D::set_goal_pos(_id_C729D49D406ACED8.origin);
      _id_18A73A64992DD07D::set_goal_radius(radius);
      self._id_BF04523BCF587D68 = _id_C729D49D406ACED8;
    }

    if(istrue(_id_039484257AA65D17)) {
      return;
    }
    wait 5;
  }
}

_id_49C4EEBA5A55A46D(delay) {
  level endon("game_ended");
  level endon("end_wave_seq3_spawners");
  wait(delay);
  _id_0A640C62C53D5703("nums_enemy_door_1_struct");
  wait 3;

  for(;;) {
    level._id_C8F022A7642CB5C8 = _id_18A73A64992DD07D::run_spawn_module("seq3_group_finale_door_2");
    wait 60;
  }
}

_id_49C4EBBA5A559DD4(delay) {
  level endon("game_ended");
  level endon("end_wave_seq3_spawners");
  wait(delay);
  _id_0A640C62C53D5703("nums_enemy_door_2_struct");
  wait 3;

  for(;;) {
    level._id_C8F025A7642CBC61 = _id_18A73A64992DD07D::run_spawn_module("seq3_group_finale_door_1");
    wait 60;
  }
}

_id_0A640C62C53D5703(targetname) {
  _id_FF4F9D9B05389F8D = scripts\engine\utility::getStruct(targetname, "targetname");
  _id_CC92B48C1E1EDC4A = getEntArray("nums_enemy_door_1_left", "targetname");
  _id_E13350EDCD4FBEB7 = getEntArray("nums_enemy_door_1_right", "targetname");
  _id_7D5B9D084CFD7A88 = getEntArray("nums_enemy_door_1_model_left", "targetname");
  _id_87661883CDAA487D = getEntArray("nums_enemy_door_1_model_right", "targetname");
  _id_B336973E05F1A142 = scripts\engine\utility::getclosest(_id_FF4F9D9B05389F8D.origin, _id_CC92B48C1E1EDC4A);
  _id_84E4101C638AA0CF = scripts\engine\utility::getclosest(_id_FF4F9D9B05389F8D.origin, _id_E13350EDCD4FBEB7);
  _id_67A2077AC4631525 = scripts\engine\utility::getclosest(_id_FF4F9D9B05389F8D.origin, _id_7D5B9D084CFD7A88);
  _id_30F47A105C1C433E = scripts\engine\utility::getclosest(_id_FF4F9D9B05389F8D.origin, _id_87661883CDAA487D);
  _id_67A2077AC4631525 linkTo(_id_B336973E05F1A142);
  _id_30F47A105C1C433E linkTo(_id_84E4101C638AA0CF);
  _id_B336973E05F1A142 connectpaths();
  _id_84E4101C638AA0CF connectpaths();
  level thread scripts\cp\utility::playsoundatpos_safe(_id_B336973E05F1A142.origin, "cp_puzzledoor_open");

  if(isent(_id_B336973E05F1A142) && isent(_id_84E4101C638AA0CF)) {
    _id_B336973E05F1A142 moveTo(_id_B336973E05F1A142.origin + (0, 0, 500), 6, 0.5, 0.5);
    _id_84E4101C638AA0CF moveTo(_id_84E4101C638AA0CF.origin + (0, 0, 500), 6, 0.5, 0.5);
  }
}

destroy_intro_tank() {
  tank = level.remote_tanks["tank_intro"];

  if(isDefined(tank) && isent(tank))
    tank dodamage(tank.health + 1, tank.origin, tank);
}

spawn_wheelson_redroom(id, num) {
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");

  if(!isDefined(level.seq3_wheelson_starts))
    level.seq3_wheelson_starts = [];

  if(!isDefined(level.seq3_wheelson_starts[id]))
    level.seq3_wheelson_starts[id] = scripts\engine\utility::getStructArray("seq3_wheelson_start_" + id, "targetname");

  if(isDefined(level.assaultdrones) && level.assaultdrones.size + 1 > 5) {
    return;
  }
  _id_CD760946A66E1F27 = scripts\engine\utility::random(level.seq3_wheelson_starts[id]);

  if(!isDefined(_id_CD760946A66E1F27)) {
    return;
  }
  _id_5A7555099AB9C8CC = 3 + level.seq3_wave_delay;
  _id_CD760946A66E1F27 thread blink_wheelson_chosen_spawn(5);
  level thread smoke_wheelson_chosen_spawn(_id_5A7555099AB9C8CC - 4, _id_CD760946A66E1F27.origin);
  wait(_id_5A7555099AB9C8CC);
  level thread destroy_intro_tank();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < num; _id_AC0E594AC96AA3A8++) {
    level.seq3_wheelson_starts[id] = scripts\engine\utility::array_remove(level.seq3_wheelson_starts[id], _id_CD760946A66E1F27);
    level thread spawn_remote_tank_thermite(_id_CD760946A66E1F27, "tank" + _id_AC0E594AC96AA3A8, undefined, 0);
  }
}

smoke_wheelson_chosen_spawn(delay, origin) {
  level endon("game_ended");
  wait(delay);
  magicgrenademanual("smoke_grenade_mp", origin, (0, 0, 0), 0.3);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", origin);
}

blink_wheelson_chosen_spawn(time) {
  level endon("game_ended");
  _id_475292231B21B05B = getEntArray("seq3_rotating_lights", "script_noteworthy");

  if(!isDefined(_id_475292231B21B05B) || _id_475292231B21B05B.size == 0) {
    return;
  }
  _id_BB5FDEF0C0501A94 = scripts\engine\utility::getclosest(self.origin, _id_475292231B21B05B);
  _id_BB5FDEF0C0501A94 setscriptablepartstate("onoff", "on");
  wait(time);
  _id_BB5FDEF0C0501A94 setscriptablepartstate("onoff", "off");
}

spawn_wheelson_blinking_lights() {
  noteworthy = "seq3_rotating_lights";
  _id_6E68567219FBAB68 = scripts\engine\utility::getStructArray(noteworthy, "targetname");
  level.seq3_emergency_lights = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6E68567219FBAB68.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_6E68567219FBAB68[_id_AC0E594AC96AA3A8].angles))
      _id_6E68567219FBAB68[_id_AC0E594AC96AA3A8].angles = (0, 0, 0);

    _id_A4B81C6FDEE56B3A = spawn("script_model", _id_6E68567219FBAB68[_id_AC0E594AC96AA3A8].origin);
    _id_A4B81C6FDEE56B3A.angles = _id_6E68567219FBAB68[_id_AC0E594AC96AA3A8].angles;
    _id_A4B81C6FDEE56B3A setModel("cp_rotating_emergency_light_on");
    _id_A4B81C6FDEE56B3A.script_noteworthy = noteworthy;
    level.seq3_emergency_lights[level.seq3_emergency_lights.size] = _id_A4B81C6FDEE56B3A;
  }
}

spawn_remote_tank_thermite(start_struct, _id_7E575A74E9251B7D, _id_41988250FF663092, _id_1208CA5973245D19, speed) {
  _id_61EE04CD86F17F18 = start_struct;
  _id_560D946EB4F8828C = undefined;

  if(isDefined(_id_61EE04CD86F17F18)) {
    if(!isDefined(_id_61EE04CD86F17F18.angles))
      _id_61EE04CD86F17F18.angles = (0, 0, 0);

    _id_560D946EB4F8828C = scripts\cp\cp_remote_tank::spawn_remote_tank(_id_61EE04CD86F17F18, _id_7E575A74E9251B7D, level.seq3_tanksettings);
    _id_560D946EB4F8828C.enemy_notify_range = 2000;
    _id_560D946EB4F8828C.max_detection_sq = 2250000;
    _id_560D946EB4F8828C.mine_damage_override = 800;
    _id_560D946EB4F8828C.time_before_shoot = 0.25;
    _id_560D946EB4F8828C.time_after_shoot = 0.25;
    _id_560D946EB4F8828C.mgturret setconvergencetime(0, "yaw");
    _id_560D946EB4F8828C.mgturret setconvergencetime(0, "pitch");
    fov = cos(90);

    if(istrue(_id_1208CA5973245D19))
      fov = cos(60);

    _id_3F045BF2F8E1C851 = 2;

    if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1) {
      _id_560D946EB4F8828C thread scripts\cp\cp_remote_tank::flicker_tank_lights();
      _id_3F045BF2F8E1C851 = 60;
      _id_560D946EB4F8828C scripts\engine\utility::delaycall(60, ::vehicle_setspeed, 0, 1, 1);
    }

    _id_560D946EB4F8828C thread wheelson_delay_allow_attack(_id_3F045BF2F8E1C851, fov);
    _id_560D946EB4F8828C makeunusable();
    _id_560D946EB4F8828C.mgturret makeunusable();
    _id_560D946EB4F8828C thread wheelson_damage_monitor();
    _id_560D946EB4F8828C thread create_nav_obstacle_for_wheelson();
    _id_560D946EB4F8828C thread wheelson_remote_tank_think(start_struct, _id_41988250FF663092, _id_1208CA5973245D19, speed);

    if(isDefined(speed))
      _id_560D946EB4F8828C hudoutlineenable("outlinefill_nodepth_white");
  }
}

wheelson_delay_allow_attack(delay, fov) {
  self endon("death");
  wait(delay);
  thread scripts\cp\cp_remote_tank::fire_on_nearby_players(fov);
}

wheelson_remote_tank_think(start_struct, _id_41988250FF663092, _id_1208CA5973245D19, speed) {
  self endon("death");

  if(isDefined(_id_41988250FF663092))
    scripts\engine\utility::flag_wait(_id_41988250FF663092);

  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1) {
    speed = 6;

    if(getdvarfloat("dvar_96062CFAAD0D66B8", 0) > 0)
      speed = getdvarfloat("dvar_96062CFAAD0D66B8", 0);

    _id_20E92A969F8CEB76 = 8;

    if(getdvarfloat("dvar_CB75F6427AF27E02", _id_20E92A969F8CEB76) > 0)
      wait(getdvarfloat("dvar_CB75F6427AF27E02", _id_20E92A969F8CEB76));
  } else
    self vehicle_setspeed(4, 1, 1);

  thread wheelson_remote_tank_follow_path(start_struct, _id_1208CA5973245D19, speed);
}

_id_E1E014017E48882A() {
  self endon("death");
  currentstate = "go";

  for(;;) {
    if(isDefined(self.last_target)) {
      if(currentstate != "stop") {
        currentstate = "stop";
        _id_3890E8E832271137();
        announcement("tank stop");
      }
    } else if(currentstate != "go") {
      currentstate = "go";
      _id_3B0F01842CA0BE46();
      announcement("tank go");
    }

    wait 0.1;
  }
}

_id_3890E8E832271137() {
  self vehicle_setspeed(0, 1, 1);
  self stoppath();
}

_id_3B0F01842CA0BE46() {
  _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray("seq3_central_tank_path", "script_noteworthy");
  _id_9E5635D634A2C671 = scripts\cp\utility::get_within_range(self.origin, _id_5D99A225CB875DDA, 1000);
  _id_80748E218E355549 = undefined;
  _id_5D35BEBE19AC9B0D = 9999;

  foreach(_id_66FBACFA7822D8B8 in _id_9E5635D634A2C671) {
    if(_id_00356889E6F4B5EB(_id_66FBACFA7822D8B8)) {
      _id_4CA8C61530E2F293 = distance(_id_66FBACFA7822D8B8.origin, self.origin);

      if(_id_4CA8C61530E2F293 < _id_5D35BEBE19AC9B0D) {
        _id_80748E218E355549 = _id_66FBACFA7822D8B8;
        _id_5D35BEBE19AC9B0D = _id_4CA8C61530E2F293;
      }
    }
  }

  if(isDefined(_id_80748E218E355549)) {
    self vehicle_setspeed(4, 1, 1);
    thread wheelson_remote_tank_follow_path(_id_80748E218E355549, 1);
  }
}

_id_00356889E6F4B5EB(_id_A5C195715679676E, _id_3B37CA6EC4D56E75) {
  dir = vectorNormalize(_id_A5C195715679676E.origin - self.origin);
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(_id_3B37CA6EC4D56E75))
    return dot > 0;

  return dot > _id_3B37CA6EC4D56E75;
}

create_nav_obstacle_for_wheelson() {
  navobstacleid = createnavobstaclebyent(self);
  self waittill("death");

  if(isDefined(navobstacleid))
    destroynavobstacle(navobstacleid);
}

wheelson_remote_tank_follow_path(start_struct, _id_1208CA5973245D19, speed) {
  self endon("death");
  self notify("tank_path");
  self endon("tank_path");
  path = wheelson_build_path(start_struct);

  if(path.size < 2) {
    return;
  }
  _id_473D8BDF00AA1996 = build_wheelson_duration(path, speed);
  _id_703E9FC257D523F1 = 0;

  foreach(duration in _id_473D8BDF00AA1996)
  _id_703E9FC257D523F1 = _id_703E9FC257D523F1 + duration;

  if(!isDefined(_id_1208CA5973245D19))
    _id_1208CA5973245D19 = 0;

  for(;;) {
    if(_id_1208CA5973245D19)
      self startpathnodes(path, _id_473D8BDF00AA1996, _id_1208CA5973245D19, 0.5, 0.5, 0);
    else {
      self startpathnodes(path, _id_473D8BDF00AA1996, _id_1208CA5973245D19, 0.1, 0.5, 0);
      return;
    }

    wait(_id_703E9FC257D523F1);
  }
}

wheelson_build_path(start_struct) {
  self endon("death");
  path = [];
  cur_node = start_struct;

  while(isDefined(cur_node) && isDefined(cur_node.target)) {
    cur_node = scripts\engine\utility::getStruct(cur_node.target, "targetname");

    if(!scripts\engine\utility::array_contains(path, cur_node.origin)) {
      path[path.size] = cur_node.origin;
      continue;
    }

    return path;
  }

  return path;
}

build_wheelson_duration(path, speed) {
  self endon("death");
  _id_473D8BDF00AA1996 = [];
  _id_776BE63DCBC6B552 = 5;

  if(isDefined(speed))
    _id_776BE63DCBC6B552 = speed;

  if(path.size < 2) {
    return;
  }
  _id_473D8BDF00AA1996[_id_473D8BDF00AA1996.size] = _id_776BE63DCBC6B552;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < path.size; _id_AC0E594AC96AA3A8++) {
    dist = distance2d(path[_id_AC0E594AC96AA3A8 - 1], path[_id_AC0E594AC96AA3A8]);
    time = 1900 / dist;

    if(isDefined(speed))
      time = speed;

    if(time < 0.1)
      time = 0.1;

    _id_473D8BDF00AA1996[_id_473D8BDF00AA1996.size] = time;
  }

  return _id_473D8BDF00AA1996;
}

wheelson_fire_thermite(_id_0D9E5028F8ED076F) {
  level thread wake_everyone_up();
  _id_AB10A6B52E9C15B3 = self.mgturret gettagorigin("tag_flash");
  _id_788A14B5C618C821 = self.mgturret gettagangles("tag_flash");
  fwd = anglesToForward(_id_788A14B5C618C821);
  _id_AB10A6B52E9C15B3 = _id_AB10A6B52E9C15B3 + fwd * 4;
  _id_A2DFD9E318FCEEC6 = fwd * 4000;
  grenade = magicgrenademanual("thermite_cp_tank", _id_AB10A6B52E9C15B3 + fwd * 4, _id_A2DFD9E318FCEEC6);
  grenade thread scripts\cp\equipment\cp_thermite::thermite_watchstuck(undefined, 1);
}

wheelson_damage_monitor() {
  self endon("stop_damage_monitor");
  self endon("death");
  thread wheelson_tank_death();
  _id_6DA37E0E07826838 = self.maxhealth;
  self setCanDamage(1);
  self.health = 100000;
  self.currenthealth = _id_6DA37E0E07826838;
  self.tracking_max_health = _id_6DA37E0E07826838;
  self.currentdamagestate = 0;
  bullet_damage_scalar = 0.25;

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);
    _id_D7198CEB7D51DB5B = undefined;
    _id_CDCEDB142F61B43E = "standard";

    if(isDefined(objweapon)) {
      if(objweapon.basename == "cruise_proj_mp")
        idamage = 1000;

      if(objweapon.classname == "rocketlauncher")
        idamage = max(idamage, self.tracking_max_health / 2 + 10);
    }

    if(self.currenthealth - idamage < 0)
      _id_D7198CEB7D51DB5B = 1;

    if(isDefined(eattacker) && !isvector(eattacker)) {
      if(isDefined(objweapon)) {
        switch (objweapon.basename) {
          case "molotov_mp":
            thread wheelson_molotov_damage_over_time(6, eattacker, point);
            break;
          case "thermite_mp":
            thread wheelson_thermite_damage_over_time(7, eattacker, point);
            break;
          default:
            break;
        }

        idamage = _id_25845ACA699D038D::handleapdamage(objweapon, smeansofdeath, idamage, eattacker);
      }

      self.last_attacker = eattacker;
      self.last_attack_time = gettime();

      if(isDefined(eattacker.owner))
        eattacker.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, idamage, 0);
      else
        eattacker thread scripts\cp\cp_damagefeedback::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, idamage, 0);
    }

    if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
      level notify("enemy_spotted", self);
      idamage = idamage * bullet_damage_scalar;
    }

    if(istrue(_id_D7198CEB7D51DB5B)) {
      if(isDefined(eattacker) && isPlayer(eattacker)) {
        eattacker thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1, idamage, 0);
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(eattacker, "stat_97BBA72A073DDA5A");
      }

      self notify("death");
      return;
    }

    self.currenthealth = self.currenthealth - idamage;

    if(self.currenthealth <= int(self.tracking_max_health / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
      continue;
    }

    if(self.currenthealth <= int(self.tracking_max_health / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_medium", "on");
    }
  }
}

wheelson_molotov_damage_over_time(_id_67732F7267D0E028, eattacker, point) {
  self endon("death");
  _id_ABD9EE4725B96FC2 = 2025;

  if(isDefined(point)) {
    if(distancesquared(point, self.origin) > _id_ABD9EE4725B96FC2)
      return;
  }

  _id_42711D92310F902F = gettime() + _id_67732F7267D0E028 * 1000;

  while(_id_42711D92310F902F > gettime()) {
    self dodamage(15, self.origin, eattacker);
    wait 1;
  }
}

wheelson_thermite_damage_over_time(_id_67732F7267D0E028, eattacker, point) {
  self endon("death");
  _id_ABD9EE4725B96FC2 = 2025;

  if(isDefined(point)) {
    if(distancesquared(point, self.origin) > _id_ABD9EE4725B96FC2)
      return;
  }

  _id_42711D92310F902F = gettime() + _id_67732F7267D0E028 * 1000;

  while(_id_42711D92310F902F > gettime()) {
    self dodamage(125, self.origin, eattacker);
    wait 1;
  }
}

wheelson_tank_death() {
  self waittill("death");
  playFX(level._effect["remote_tank_explode"], self.origin);
  self.mgturret delete();
  self delete();
}