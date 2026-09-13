/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1e9bf201ea44567c.gsc
***********************************************/

_id_57F2802F8F41E497() {
  door = getEnt("nums_intro_door_1", "targetname");

  if(isent(door))
    door delete();
}

_id_80DC43014F80E68B() {
  scripts\engine\utility::flag_init("armory_gate_opened");
  doors = getEntArray("nums_intro_door_1", "script_noteworthy");

  if(isDefined(doors)) {
    level thread _id_74554FBFC085A53F();
    level thread _id_E2310918080B7BEF();
    _id_C5D3D8FF129F88BA = getEnt("armory_keypad", "script_noteworthy");
    location = _id_C5D3D8FF129F88BA.origin + rotatevector((0, -3, 0), _id_C5D3D8FF129F88BA.angles);
    level._id_E688351D24B0B0DC = scripts\cp\utility::createhintobject(location, "HINT_BUTTON", undefined, &"CP_RAID1_NUMSPUZZLE/REGROUP_INTRO_GATE_0", undefined, "duration_short", "show", 200, 70, 64, 40, undefined);
    _id_830905E5C2645826 = "nums_intro_door_open";
    childthread _id_CE8DECAE733F48C7(_id_830905E5C2645826);
    childthread _id_408DCF643CE51DA2(_id_830905E5C2645826);
    level waittill(_id_830905E5C2645826);
    scripts\engine\utility::flag_set("armory_gate_opened");
    thread _id_669C0F6CB0B7F0CD::_id_52CE5631A404B7E2();
    thread _id_E2DC7A050E62439D();
    level._id_E688351D24B0B0DC delete();
    level thread _id_100B1FC9F474FF5C();

    if(soundexists("cp_raid_armory_garage_door_open"))
      playsoundatpos(doors[0].origin + (0, 24, 80), "cp_raid_armory_garage_door_open");

    foreach(door in doors)
    door moveTo(door.origin + (0, 0, 130), 7, 1, 1);

    wait 7.25;

    foreach(door in doors)
    door delete();
  }
}

_id_E2DC7A050E62439D() {
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  scripts\cp\cp_objectives::run_objective("raid1_clear_armory", "primary", "allies", 1);
}

_id_CE8DECAE733F48C7(_id_830905E5C2645826) {
  level endon(_id_830905E5C2645826);
  _id_88F7BC4C4C26E93D = [];

  for(;;) {
    level._id_E688351D24B0B0DC waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(scripts\engine\utility::array_find(_id_88F7BC4C4C26E93D, player))) {
      _id_88F7BC4C4C26E93D = scripts\engine\utility::array_add(_id_88F7BC4C4C26E93D, player);

      if(_id_88F7BC4C4C26E93D.size == 1)
        level._id_E688351D24B0B0DC setHintString(&"CP_RAID1_NUMSPUZZLE/REGROUP_INTRO_GATE_1");
      else if(_id_88F7BC4C4C26E93D.size == 2)
        level._id_E688351D24B0B0DC setHintString(&"CP_RAID1_NUMSPUZZLE/REGROUP_INTRO_GATE_2");
      else if(_id_88F7BC4C4C26E93D.size == 3)
        level._id_E688351D24B0B0DC setHintString(&"CP_RAID1_NUMSPUZZLE/REGROUP_INTRO_GATE_3");
    }

    maximum = level.players.size;

    if(_id_88F7BC4C4C26E93D.size == maximum) {
      level notify(_id_830905E5C2645826);
      return;
    }
  }
}

_id_408DCF643CE51DA2(_id_830905E5C2645826) {
  level endon(_id_830905E5C2645826);
  _id_76FC9C72CBF75ECA = squared(250);
  _id_C5D3D8FF129F88BA = getEnt("armory_keypad", "script_noteworthy");
  maximum = 3;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(_id_C5D3D8FF129F88BA.origin, _id_76FC9C72CBF75ECA)) {
      wait 2;
      _id_6F5BB071BC59B63A = scripts\cp\utility::give_all_players_nearby(_id_C5D3D8FF129F88BA.origin, _id_76FC9C72CBF75ECA);

      if(isDefined(_id_6F5BB071BC59B63A) && _id_6F5BB071BC59B63A.size == maximum) {
        level notify(_id_830905E5C2645826);
        return;
      }
    }

    wait 2;
  }
}

_id_E2310918080B7BEF() {
  level endon("game_ended");
  level endon("nums_intro_door_open");
  level endon("players_approaching_puzzle_entrance");
  struct = scripts\engine\utility::getStruct("start_wpn_riotshield", "script_noteworthy");

  for(;;) {
    if(soundexists("emt_cp_raid_intro_door_distant_metal_squeal"))
      level thread scripts\cp\utility::playsoundatpos_safe(struct.origin, "emt_cp_raid_intro_door_distant_metal_squeal");

    wait(randomfloatrange(5, 18));
  }
}

_id_74554FBFC085A53F() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_weapon_me_riotshield", ::_id_C5939CEFEEE75928);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_weapon_generic_me", ::_id_C5939CEFEEE75928);
}

_id_C5939CEFEEE75928(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(instance.origin)) {
    return;
  }
  _id_B5F25CACDBB5012A = (-4006.8, 9112.16, 725.627);

  if(isDefined(instance.customweaponname) && instance.customweaponname == "iw9_me_riotshield_mp") {
    if(distance(instance.origin, _id_B5F25CACDBB5012A) > 100) {
      return;
    }
    if(istrue(level._id_68193A7A320B3149)) {
      return;
    }
    instance freescriptable();
    level._id_68193A7A320B3149 = 1;
  }
}

_id_100B1FC9F474FF5C() {
  level thread scripts\cp\tripwire_cp::_id_7BDA4E577B34A556();
  level thread _id_71717E6C4597A196::_id_34E54622B902890B();
  level thread _id_1DB8D0E02A99C5E2::_id_D0E0B1A0DC489379();

  foreach(player in level.players)
  player _id_4D5D872A7BD5C0C3::_id_8FC85383E9F1B6E6();
}

_id_5A52715BF68D9C6C(_id_C48A8DA587D19F4B) {
  level endon("game_ended");
  _id_9215D834F0060ABD = getaiarray("axis");
  maxdist = 128;

  if(isDefined(_id_C48A8DA587D19F4B))
    maxdist = _id_C48A8DA587D19F4B;

  _id_CDC5DD6C28C9709D = squared(maxdist);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9215D834F0060ABD.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8])) {
      _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].dontkilloff = 0;
      _id_D26C161386B2B083 = 0;

      foreach(player in level.players) {
        if(distancesquared(player.origin, _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].origin) < _id_CDC5DD6C28C9709D)
          _id_D26C161386B2B083 = 1;

        if(_id_2B79931B08683E0A::player_can_see_ai(player, _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8]))
          _id_D26C161386B2B083 = 1;
      }

      if(!_id_D26C161386B2B083)
        _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::script_kill_ai();
    }
  }
}

_id_BF184D4BA504434F() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("armory_button_pressed");
  level thread _id_9BEA92557B123AEF();
  _id_51E00DEAD921083B = scripts\engine\utility::getStruct("maze_armory_switch", "targetname");
  level._id_4739CCC734313EC0 = scripts\cp\utility::createhintobject(_id_51E00DEAD921083B.origin, "HINT_BUTTON", undefined, &"CP_RAID_WATERMAZE/ARMORY_BUTTON", undefined, "duration_short", "hide", 500, 120, 64, 40, undefined);

  for(;;) {
    level._id_4739CCC734313EC0 waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  level thread scripts\cp\utility::playsoundatpos_safe(_id_51E00DEAD921083B.origin, "cp_puzzledoor_open");
  level._id_4739CCC734313EC0 delete();
  scripts\engine\utility::flag_set("armory_button_pressed");
  level thread _id_07D6609DA63E8C1E();
}

_id_9BEA92557B123AEF() {
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_31C405AA2D21F0B5);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_CAF2FF37D9662097);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);
  _id_9792640B164CDEB1 = scripts\engine\utility::getStructArray("maze_armory_doorlock", "targetname");
  level._id_E13BCE1B40F148FC = [];

  foreach(_id_1E92D8D3755A9FF8 in _id_9792640B164CDEB1) {
    _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = getentitylessscriptablearray(undefined, undefined, _id_1E92D8D3755A9FF8.origin, 128, "door");

    foreach(door in _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC) {
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = door;
      level._id_E13BCE1B40F148FC = scripts\engine\utility::array_add(level._id_E13BCE1B40F148FC, _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC _id_FBBFE6F05EDA5EB1(_id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
    }
  }
}

_id_07D6609DA63E8C1E() {
  wait 1;

  foreach(door in level._id_E13BCE1B40F148FC) {
    level thread scripts\cp\utility::playsoundatpos_safe(door.origin, "cp_puzzledoor_armory_open");
    wait 0.2;
  }

  foreach(door in level._id_E13BCE1B40F148FC) {
    if(!istrue(door._id_A16669FDD0578E00)) {
      _id_B092780F9EC4496E(door);

      foreach(player in level.players)
      door enablescriptableplayeruse(player);
    }
  }

  wait 2;
  _id_8333FA30B9E4BB93 = scripts\engine\utility::getStructArray("maze_armory_smoke", "targetname");

  foreach(smoke in _id_8333FA30B9E4BB93) {
    wait(0.1 + randomfloat(0.4));
    magicgrenademanual("smoke_grenade_mp", smoke.origin, (0, 0, 0), 0.3);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", smoke.origin);
  }
}

_id_FBBFE6F05EDA5EB1(door) {
  door _meth_9AF4C9B2CC1BF989(1);
  door.blocked = 1;
}

_id_B092780F9EC4496E(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();

  door.blocked = undefined;
  door._id_A16669FDD0578E00 = 1;
}

_id_20381C7B081C3F54(scriptable, player) {}

_id_31C405AA2D21F0B5(scriptable, player) {
  return &"SCRIPT/DOOR_HINT_LOCKED";
}

_id_42974A5D66E156B8(instance, player, _id_85E3240D30E184E7) {
  return 0;
}

_id_CAF2FF37D9662097(instance, player, _id_85E3240D30E184E7) {
  if(_id_85E3240D30E184E7) {
    if(scripts\engine\utility::flag("armory_gate_opened") && !scripts\engine\utility::flag("armory_button_pressed"))
      player thread _id_669C0F6CB0B7F0CD::_id_9CE3A54106B97F35();
  }

  return 0;
}

_id_4DB7383FC4ED369C(_id_8F326AB0287421A3) {
  level endon("game_ended");
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("maze_spawners_armory_intro", 2, 2, 2, 0.1, 0, "maze_spawners_armory_intro", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_armory_intro", ::run_stealth_funcs);
  [[spawnfunc]]("maze_spawners_armory", 10, 10, 10, 0.1, 0, "maze_spawners_armory", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_armory", ::_id_DE47CBD63B1DF96B);
  [[spawnfunc]]("maze_spawners_armory_corner", 1, 1, 1, 0.1, 0, "maze_spawners_armory_corner", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_armory_corner", ::_id_DB3CD68878F2BDC8);
  [[spawnfunc]]("maze_spawners_armory_deep", 6, 6, 6, 0.1, 0, "maze_spawners_armory_deep", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_armory_deep", ::_id_DB3CD68878F2BDC8);
  [[spawnfunc]]("maze_spawners_armory_deep_special", 2, 2, 2, 0.1, 0, "maze_spawners_armory_deep_special", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("maze_spawners_armory_deep_special", ::_id_DB3CD68878F2BDC8);
  trigger = getEnt("maze_armory_soldier_spawn", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  trigger delete();
  level thread _id_56C1E7E989F1901F(_id_8F326AB0287421A3);
  level thread _id_7D0345219486BF2D();
  level thread _id_B6160EB7D30C93AE();
}

_id_56C1E7E989F1901F(_id_8F326AB0287421A3) {
  level endon("game_ended");
  level thread _id_CD24105424BFA41C();

  if(!istrue(_id_8F326AB0287421A3))
    level._id_5BF7305A7B90D2F2 = _id_18A73A64992DD07D::run_spawn_module("maze_spawners_armory_intro");

  level._id_3E40D3C71E631A6F = _id_18A73A64992DD07D::run_spawn_module("maze_spawners_armory");
  level waittill("kill_armory_soldiers");

  foreach(ai in level._id_5BF7305A7B90D2F2.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);

  foreach(ai in level._id_3E40D3C71E631A6F.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);
}

_id_7D0345219486BF2D() {
  level endon("game_ended");
  trigger = getEnt("maze_armory_trigger_corner", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }
  }

  trigger delete();
  level._id_09BC7D37082182BD = _id_18A73A64992DD07D::run_spawn_module("maze_spawners_armory_corner");
  level waittill("kill_armory_soldiers");

  foreach(ai in level._id_09BC7D37082182BD.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);
}

_id_B6160EB7D30C93AE() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("armory_button_pressed");
  level._id_3EC9FB0B6DB3F9F0 = _id_18A73A64992DD07D::run_spawn_module("maze_spawners_armory_deep");
  level._id_82047D3399019BB8 = _id_18A73A64992DD07D::run_spawn_module("maze_spawners_armory_deep_special");
  level thread _id_9BF4F23EC8172BB2();
  level waittill("kill_armory_soldiers");

  foreach(ai in level._id_3EC9FB0B6DB3F9F0.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);

  foreach(ai in level._id_82047D3399019BB8.ai_spawned)
  ai _id_18A73A64992DD07D::script_kill_ai(0);
}

_id_9BF4F23EC8172BB2() {
  level endon("game_ended");
  wait 3;

  while(level._id_3EC9FB0B6DB3F9F0.ai_spawned.size > 0)
    wait 1;

  while(level._id_82047D3399019BB8.ai_spawned.size > 0)
    wait 1;

  while(level._id_3E40D3C71E631A6F.ai_spawned.size > 0)
    wait 1;

  wait 4;
}

_id_DE47CBD63B1DF96B(group_name, func) {
  thread _id_2A652AD9B5366695();
  run_stealth_funcs(group_name, func);
}

_id_2A652AD9B5366695(group_name, func) {
  self endon("death");

  if(!scripts\engine\utility::flag("armory_gate_opened")) {
    self.ignoreall = 1;
    scripts\engine\utility::flag_wait("armory_gate_opened");
    self.ignoreall = 0;
  }
}

_id_DB3CD68878F2BDC8(group_name, func) {
  player = scripts\cp\utility::get_closest_living_player();

  if(isDefined(player)) {
    self getenemyinfo(player);
    _id_F0D0842E8A7BD953 = getclosestpointonnavmesh(player.origin);
    self setgoalpos(_id_F0D0842E8A7BD953);
    radius = 2048;
    _id_18A73A64992DD07D::set_goal_radius(radius);
  }

  if(scripts\cp\utility::isjuggernaut()) {
    if(self.meleemaxzdiff > 32)
      self.meleemaxzdiff = 32;
  }
}

run_stealth_funcs(_id_8AA2609E46B64970, func) {
  _id_F0D0842E8A7BD953 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(_id_F0D0842E8A7BD953);
  radius = 256;

  if(randomint(10) > 3)
    radius = 1024;

  _id_18A73A64992DD07D::set_goal_radius(radius);
  self.goalheight = 64;
  self.script_origin_other = _id_F0D0842E8A7BD953;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, squared(radius));

  if(_id_8AA2609E46B64970.group_name == "maze_spawners_armory_intro" || _id_8AA2609E46B64970.group_name == "maze_spawners_armory") {
    self _meth_D493E7FE15E5EAF4("cp_raid1_intro");
    scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_333AB90A2A2307F7);
    scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_333AB90A2A2307F7);
    scripts\stealth\utility::set_stealth_func("event_combat", ::_id_333AB90A2A2307F7);
  }
}

_id_333AB90A2A2307F7(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1))
        return 1;
      else {}
    }
  }

  if(isDefined(event.type) && event.type == "combat" || event.type == "cover_blown")
    return 0;

  return 0;
}

_id_CD24105424BFA41C() {
  level._id_F57B5DB263860330 = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_A4977696D3393DD8 = 1;
  level._id_7194135F0D48546E = 0.25;
  _id_7DC093FB71342953["prone"] = level._id_7194135F0D48546E * 800;
  _id_7DC093FB71342953["crouch"] = level._id_7194135F0D48546E * 1200;
  _id_7DC093FB71342953["stand"] = level._id_7194135F0D48546E * 2500;
  _id_7DC093FB71342953["shadow_prone"] = 0.05;
  _id_7DC093FB71342953["shadow_crouch"] = 0.05;
  _id_7DC093FB71342953["shadow_stand"] = 0.3;
  _id_3B0034EB96B13650["prone"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["crouch"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["stand"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["shadow_prone"] = 0.01;
  _id_3B0034EB96B13650["shadow_crouch"] = 0.02;
  _id_3B0034EB96B13650["shadow_stand"] = 0.38;
  _id_8F3F480583606401["prone"] = 1.1;
  _id_8F3F480583606401["crouch"] = 1.15;
  _id_8F3F480583606401["stand"] = 1.4;
  scripts\stealth\utility::set_detect_ranges(_id_7DC093FB71342953, _id_3B0034EB96B13650, _id_8F3F480583606401);
  _id_B6B642CBEFF52B88["prone"] = level._id_7194135F0D48546E * 150;
  _id_B6B642CBEFF52B88["crouch"] = level._id_7194135F0D48546E * 350;
  _id_B6B642CBEFF52B88["stand"] = level._id_7194135F0D48546E * 1000;
  _id_D0F35FC0A5C3DF79["prone"] = level._id_7194135F0D48546E * 250;
  _id_D0F35FC0A5C3DF79["crouch"] = level._id_7194135F0D48546E * 1000;
  _id_D0F35FC0A5C3DF79["stand"] = level._id_7194135F0D48546E * 1800;
  scripts\stealth\utility::set_min_detect_range_darkness(_id_B6B642CBEFF52B88, _id_D0F35FC0A5C3DF79);
  _id_FAC370D058479827["prone"] = 0;
  _id_FAC370D058479827["crouch"] = 0;
  _id_FAC370D058479827["stand"] = 0;
  _id_FB574B7959625BF0["prone"] = 0;
  _id_FB574B7959625BF0["crouch"] = 0;
  _id_FB574B7959625BF0["stand"] = 0;
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_FAC370D058479827, _id_FB574B7959625BF0);
  _id_04E4F703E8EA149C["spotted"]["explosion"] = level._id_7194135F0D48546E * 2500;
  _id_04E4F703E8EA149C["hidden"]["explosion"] = level._id_7194135F0D48546E * 2500;
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = level._id_7194135F0D48546E * 2000;
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = level._id_7194135F0D48546E * 1000;
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);
  scripts\stealth\utility::group_setcombatgoalRadius("maze_spawners_armory_intro", 1024);
  scripts\stealth\utility::group_setcombatgoalRadius("maze_spawners_armory", 1024);
}