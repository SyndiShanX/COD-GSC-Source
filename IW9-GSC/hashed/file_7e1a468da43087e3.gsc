/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e1a468da43087e3.gsc
***********************************************/

watch_for_objective_reached() {
  self notify("watch_for_objective_reached");
  self endon("watch_for_objective_reached");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      continue;
    }
    break;
  }
}

_id_1CE91B89FF356883(center, radius, color, alpha, _id_FFB74DFE2FDAD3BE, duration, _id_851DF4CD0132B5FA) {
  if(!isDefined(_id_851DF4CD0132B5FA) || !isint(_id_851DF4CD0132B5FA))
    _id_851DF4CD0132B5FA = 16;

  _id_7062EA7309FA49C4 = 360 / _id_851DF4CD0132B5FA;
  _id_8AF33769F877B5D6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_851DF4CD0132B5FA; _id_AC0E594AC96AA3A8++) {
    angle = _id_7062EA7309FA49C4 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * radius;
    _id_D867033AB311670B = sin(angle) * radius;
    x = center[0] + _id_8A9F895755FD607E;
    y = center[1] + _id_D867033AB311670B;
    z = center[2];
    _id_8AF33769F877B5D6[_id_8AF33769F877B5D6.size] = (x, y, z);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AF33769F877B5D6.size; _id_AC0E594AC96AA3A8++) {
    start = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 + 1 >= _id_8AF33769F877B5D6.size) {
      end = _id_8AF33769F877B5D6[0];
      continue;
    }

    end = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8 + 1];
  }
}

_id_D0639583BB16FB16(center, radius, color, alpha, _id_FFB74DFE2FDAD3BE, duration, _id_F734CA98957F765E) {
  if(!isDefined(_id_F734CA98957F765E) || !isint(_id_F734CA98957F765E))
    _id_F734CA98957F765E = 16;

  _id_7062EA7309FA49C4 = 360 / _id_F734CA98957F765E;
  _id_8AF33769F877B5D6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F734CA98957F765E; _id_AC0E594AC96AA3A8++) {
    angle = _id_7062EA7309FA49C4 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * radius;
    _id_D867033AB311670B = sin(angle) * radius;
    x = center[0] + _id_8A9F895755FD607E;
    y = center[1] + _id_D867033AB311670B;
    z = center[2];
    _id_8AF33769F877B5D6[_id_8AF33769F877B5D6.size] = (x, y, z);
  }

  return _id_8AF33769F877B5D6;
}

_id_7CD97A856163B260() {}

spawn_infil_lbravo(_id_34824E3FA636BB1A) {
  level.player_infil_lbravo = _id_34824E3FA636BB1A;
  _id_34824E3FA636BB1A thread infil_lbravo_damage_monitor(_id_34824E3FA636BB1A);
}

infil_lbravo_damage_monitor(_id_34824E3FA636BB1A) {
  _id_34824E3FA636BB1A endon("death");
  _id_34824E3FA636BB1A setCanDamage(1);
  _id_34824E3FA636BB1A.health = 999999;
  _id_34824E3FA636BB1A.maxhealth = 999999;

  for(;;) {
    _id_34824E3FA636BB1A waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    _id_34824E3FA636BB1A.health = 999999;
    _id_34824E3FA636BB1A.maxhealth = 999999;

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "homing_rpg_missile_cp") {
      break;
    }
  }

  playFX(level._effect["little_bird_explode"], _id_34824E3FA636BB1A.origin);
  _id_34824E3FA636BB1A delete();
}

lbravo_actor_keep_anim_loop(infil) {
  infil thread actorloopanim(infil.actors[0]);
  infil thread actorloopanim(infil.actors[1]);
}

actorloopanim(actor) {
  self.linktoent endon("death");
  actor endon("death");
  _id_E11057BBCCD7BFAE = "lbravo_infil";
  _id_1A1E63D299B926C8 = "origin_animate_jnt";

  for(;;)
    self.linktoent scripts\common\anim::anim_single_solo(actor, _id_E11057BBCCD7BFAE + "_" + self.subtype + "_loop", _id_1A1E63D299B926C8);
}

_id_9D782122BC985AED() {
  level endon("game_ended");
  level waittill("intro_1");
  level waittill("intro_2");
  level waittill("intro_3");
  level waittill("intro_4");
  level waittill("price_debrief_1");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_1");
  level waittill("price_debrief_2");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_2");
  level waittill("price_debrief_3");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_3");
  level waittill("price_debrief_4");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_4");
  level waittill("price_debrief_5");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_5");
  level waittill("price_debrief_6");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_6");
  level waittill("price_debrief_7");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_7");
  level waittill("price_debrief_8");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_8");
  level waittill("price_debrief_9");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_DEBRIEF_9");
}

waittill_vehicle_node_reached(_id_3C33BB53CA196020) {
  _id_C9B725FEA190868E = getvehiclenodearray(_id_3C33BB53CA196020, "script_noteworthy");
  _id_5E1777E704DBA360 = _id_C9B725FEA190868E[0];
  _id_5E1777E704DBA360 waittill("trigger");
}

waittill_vehicle_node_reached_targetname(_id_D68857EDCCFB97D3) {
  _id_5E1777E704DBA360 = getvehiclenode(_id_D68857EDCCFB97D3, "targetname");
  _id_5E1777E704DBA360 waittill("trigger");
}

player_infil_played_or_skipped() {
  return istrue(game["player_infil_already_played"]) || getdvarint("dvar_C55DC89EF275CDAA", 0) == 1;
}

try_start_fake_infil_chopper() {
  if(player_infil_played_or_skipped()) {
    lbravo_spawn_after_level_restart();
    waitframe();
    level notify("infil_started");
  }
}

lbravo_spawn_after_level_restart() {
  init_lbravo_spawn_after_level_restart();
  scene_node = scripts\engine\utility::getStruct("lbravoStartAfterLevelRestart", "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.path = scripts\engine\utility::getStruct("lbravoStartAfterLevelRestart", "targetname");
  infil.subtype = "alpha";
  infil.type = "infil_lbravo";
  infil thread infilthink("allies", "alpha");
  level.infil_struct = infil;
  return infil;
}

infilthink(team, _id_CA85A0DE365C6A63) {
  level endon("game_ended");

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread scripts\cp\infilexfil\lbravo_infil_cp::vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread scripts\cp\infilexfil\lbravo_infil_cp::actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\engine\utility::waittill_any_ents(level, "infil_started", self, "infil_started");
  level notify("start_scene");
  self notify("start_scene");

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  self delete();
}

init_lbravo_spawn_after_level_restart() {
  scripts\cp\infilexfil\lbravo_infil_cp::initanims("alpha");
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [4, 5];
  _id_453E4FC2C649FEA4[2] = [2];
  _id_453E4FC2C649FEA4[3] = [3];
}

delete_ai() {
  self.nocorpse = 1;
  self.diequietly = 1;
  self kill();
}

round_smoke_semtex_logic() {
  level endon("kill_semtex_thread");
  wait 5;
  _id_F4E34D8FC8416066 = level.players;
  _id_203F3DC2CB2D0BEF = 12;
  _id_201C2BC2CB069CA1 = 30;
  frequency = max(_id_203F3DC2CB2D0BEF, _id_201C2BC2CB069CA1 / _id_F4E34D8FC8416066.size);
  _id_DBAA0AF7EF8C4B88 = 7;
  _id_B05F5046E322A80D = 1;
  _id_B03C3A46E2FC2FF3 = 3;

  for(;;) {
    enemies = getaiarray("axis");

    if(enemies.size < _id_DBAA0AF7EF8C4B88) {
      waitframe();
      continue;
    }

    _id_C7FA1DED90140057 = scripts\engine\utility::random(_id_F4E34D8FC8416066);
    _id_F1D11CF1514CB71B = randomintrange(_id_B05F5046E322A80D, _id_B03C3A46E2FC2FF3);

    for(index = 0; index < _id_F1D11CF1514CB71B; index++) {
      _id_A88F435ECE696FF5 = _id_C7FA1DED90140057.origin + (0, 0, 300) + scripts\engine\utility::randomvectorrange(15, 30);
      enemies[0].grenadeweapon = makeweapon("semtex_mp");
      enemies[0] magicgrenademanual(_id_A88F435ECE696FF5, (0, 0, -5), 2);
    }

    _id_F4E34D8FC8416066 = scripts\engine\utility::array_remove(_id_F4E34D8FC8416066, _id_C7FA1DED90140057);

    if(!_id_F4E34D8FC8416066.size)
      _id_F4E34D8FC8416066 = level.players;

    wait(frequency);
  }
}

round_smoke_molotov_logic() {
  wait 8;
  _id_F4E34D8FC8416066 = level.players;
  _id_203F3DC2CB2D0BEF = 14;
  _id_201C2BC2CB069CA1 = 33;
  frequency = max(_id_203F3DC2CB2D0BEF, _id_201C2BC2CB069CA1 / _id_F4E34D8FC8416066.size);
  _id_D08704718C442864 = [(-648.919, -1298.07, 1746.41), (-538.559, -1801.64, 2024), (-1434.56, -1993.64, 2056), (-1402.56, -1497.64, 2024)];
  _id_5062D45FD9F116A1 = [(19.625, 267.558, 0), (90, 0, 90), (90, 0, 90), (90, 0, 90)];
  _id_ABCDC27D2F3D65F3 = [5000, 1, 1, 1];
  _id_DBAA0AF7EF8C4B88 = 7;

  for(;;) {
    enemies = getaiarray("axis");

    if(enemies.size < _id_DBAA0AF7EF8C4B88) {
      waitframe();
      continue;
    }

    for(index = 0; index < _id_D08704718C442864.size; index++) {
      _id_2ACFB5DE8DA9BA7F = _id_D08704718C442864[index];
      _id_F801B47712656753 = anglesToForward(_id_5062D45FD9F116A1[index]) * _id_ABCDC27D2F3D65F3[index];
      enemies[0].grenadeweapon = makeweapon("molotov_mp");
      _id_08368EBFD49369EA = enemies[0] magicgrenademanual(_id_2ACFB5DE8DA9BA7F, _id_F801B47712656753);
      enemies[0] scripts\cp\powers\coop_molotov::molotov_used(_id_08368EBFD49369EA);
    }

    wait(frequency);
  }
}

round_enemies_fallback_logic() {
  level notify("level_enemies_fallback");
  enemies = getaiarray("axis");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("enemy_retreat_struct", "targetname");

  foreach(enemy in enemies) {
    if(istrue(enemy.ignorefallback)) {
      continue;
    }
    _id_9E4E1482CB40C9C5 = sortbydistance(_id_9E4E1482CB40C9C5, enemy.origin);
    enemy thread enemy_fallback_logic(_id_9E4E1482CB40C9C5[0]);
  }
}

enemy_fallback_logic(struct) {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreall = 1;
  self.script_pushable = 1;
  self.goalradius = 80;
  self setgoalpos(struct.origin);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 20.0);
  delete_ai();
}

#using_animtree("script_model");

init_usb_animations() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["hack"] = % cp_player_usb_hack;
  level.scr_animname["player"]["hack"] = "cp_player_usb_hack";
  level.scr_eventanim["player"]["hack"] = "player_usb_hack";
}

create_usb_anim_rig(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  player_rig = spawn("script_arms", spawnpos, 0, 0, self);
  player_rig.angles = _id_B7850001037AA074;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "cancelled_usb_anim");

  if(isDefined(self)) {
    self unlink();
    thread takegunless();
  }

  if(isDefined(player_rig))
    player_rig delete();
}

takegunless() {
  self endon("death_or_disconnect");

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }
}

_id_A9B8DD7261DE2FAD() {}

playoverwatch_dialogue(alias) {
  if(!isDefined(level.overwatchent))
    level.overwatchent = spawn("script_origin", (0, 0, 0));

  level.overwatchent stopsounds();
  time = lookupsoundlength(alias) * 0.001;
  level.overwatchent playSound(alias);
  wait(time);
}

set_look_at_ent(pavelow_boss, ent) {
  pavelow_boss setlookatent(ent);
  pavelow_boss.look_at_ent = ent;
}

clear_look_at_ent(pavelow_boss) {
  if(isDefined(pavelow_boss.look_at_ent))
    pavelow_boss.look_at_ent delete();
}

make_chopper_boss_look_at_ent(_id_89AD6FF9F6D7583A) {
  _id_4893BC2653755B4E = scripts\engine\utility::getStruct(_id_89AD6FF9F6D7583A, "script_noteworthy");
  look_at_ent = spawn("script_model", _id_4893BC2653755B4E.origin);
  look_at_ent setModel("tag_origin");
  return look_at_ent;
}

mph_travel_time(speed, dist) {
  speed = speed * 17.6;
  time = dist / speed;
  return time;
}

get_mph_speed(node) {
  return node.speed * 3600 / 63360;
}

get_forest_combat_logic(pavelow_boss, _id_2465C35C543F5C38) {
  if(1)
    return "search";
}

_id_F0AACBE05ACE1594(origin, radius) {
  _id_EAA7250AA6C397A2 = ["scriptable_door_metal_04_flat_painted_mp_tan", "scriptable_door_metal_panel_03_right_mp", "door_wooden_hollow_mp_01_rnd", "scriptable_door_wooden_panel_03_painted_mp", "scriptable_door_metal_panel_03_left_mp", "scriptable_door_wooden_panel_mp_01_white", "scriptable_construction_doors_metal_b_02_mp", "scriptable_door_wooden_office_01_mp", "scriptable_door_metal_single_b_02_grey", "scriptable_door_wooden_hollow_mp_01", "scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_panel_03_painted_mp_tint", "scriptable_door_wood_ornate_01_green_double_r", "scriptable_door_wood_ornate_01_green_double_l"];
  _id_8C73C4ADD30BB4B2 = [];

  foreach(name in _id_EAA7250AA6C397A2)
  _id_8C73C4ADD30BB4B2 = scripts\engine\utility::array_combine(getentitylessscriptablearray("scriptable_" + name, "classname", origin, radius), _id_8C73C4ADD30BB4B2);

  return _id_8C73C4ADD30BB4B2;
}

level_offhand_spawn(_id_9E4E1482CB40C9C5) {
  if(getdvarint("dvar_1E6BD52A700677D7", 0) != 0) {
    return;
  }
  offset = (0, -90, 0);

  foreach(struct in _id_9E4E1482CB40C9C5) {
    switch (struct.script_parameters) {
      case "ammo":
        _id_B1AD25AD91B2627D = ammo_crate_spawn(struct.origin, struct.angles + offset);
        _id_B1AD25AD91B2627D setHintString(&"COOP_CRAFTING/AMMO_CRATE_TAKE");
        break;
      case "claymore":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::claymore_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_CLAYMORE", undefined, ::claymore_crate_update_hint_logic_alt);
        break;
      case "flash":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::flash_crate_use, struct, &"CP_SO_FINALE/PICKUP_FLASH", undefined, ::flash_crate_update_hint_logic_alt);
        break;
      case "c4":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::c4_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_C4", undefined, ::c4_crate_update_hint_logic_alt);
        break;
      case "stim":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::stim_crate_use_alt, struct, &"CP_SO_FINALE/PICKUP_STIMS", undefined, ::stim_crate_update_hint_logic);
        break;
      case "molotov":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::molotov_crate_use, struct, &"CP_SO_FINALE/PICKUP_MOLOTOV", undefined, ::molotov_crate_update_hint_logic_alt);
        break;
      case "snapshot":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::snapshot_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_SNAPSHOT", undefined, ::_id_0D7178547C687190);
        break;
      case "decoy":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_DE561C1CD30D79FB, struct, &"EQUIPMENT_HINTS/PICKUP_DECOY", undefined, ::_id_9F50F7E2890AC3D6);
        break;
      case "hb_sensor":
        _id_B1AD25AD91B2627D = script_model_spawn_and_use(struct.origin, struct.angles, ::_id_61B64A8DD9B2B4A1, struct, &"EQUIPMENT_HINTS/PICKUP_HBSENSOR", undefined, ::_id_8C12C8772102DA1C);
        break;
    }
  }
}

_id_8C12C8772102DA1C(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_hb_sensor");
}

ammo_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::ammo_crate_use, "offhand_wm_supportbox_ammunition", &"COOP_CRAFTING/AMMO_CRATE_TAKE", "hud_icon_fieldupgrade_ammo_box", "cp_crate_icon_ammo_red", ::player_has_primary_weapons_max_stock_ammo);
}

player_has_primary_weapons_max_stock_ammo(player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primaryweapon in primaryweapons) {
    if(weapontype(primaryweapon) == "riotshield") {
      continue;
    }
    _id_D1AD88BF84DAA67F = player getweaponammostock(primaryweapon);

    if(_id_D1AD88BF84DAA67F < weaponmaxammo(primaryweapon))
      return 0;
  }

  return 1;
}

ammo_crate_use(_id_B1AD25AD91B2627D, player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primaryweapon in primaryweapons) {
    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(primaryweapon) == "riotshield") {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(primaryweapon)) {
      continue;
    }
    player givemaxammo(primaryweapon);
  }

  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

claymore_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_claymore");
}

flash_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_flash");
}

c4_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_c4");
}

_id_0D7178547C687190(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_snapshot_grenade");
}

_id_9F50F7E2890AC3D6(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_decoy");
}

stim_crate_use_alt(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_adrenaline", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_adrenaline", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

stim_crate_update_hint_logic(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_adrenaline");
}

molotov_crate_update_hint_logic_alt(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  thread update_hint_logic_offhand(_id_B1AD25AD91B2627D, "equip_molotov");
}

update_hint_logic_offhand(_id_B1AD25AD91B2627D, type) {
  _id_2BDF748326F9F18C = [];

  foreach(player in level.players) {
    _id_8A03A7434EDA56FC = player _id_7EF95BBA57DC4B82::hasequipment(type) && player _id_7EF95BBA57DC4B82::getequipmentammo(type) < player _id_7EF95BBA57DC4B82::getequipmentmaxammo(type);

    if(_id_8A03A7434EDA56FC) {
      _id_B1AD25AD91B2627D disableplayeruse(player);

      if(isDefined(_id_B1AD25AD91B2627D.ent_model))
        _id_B1AD25AD91B2627D.ent_model hidefromplayer(player);

      continue;
    }

    _id_2BDF748326F9F18C = scripts\engine\utility::array_add(_id_2BDF748326F9F18C, player);
  }

  for(;;) {
    _id_C32DCE49091803F5 = [];

    foreach(player in level.players) {
      _id_8A03A7434EDA56FC = player _id_7EF95BBA57DC4B82::hasequipment(type) && player _id_7EF95BBA57DC4B82::getequipmentammo(type) < player _id_7EF95BBA57DC4B82::getequipmentmaxammo(type);

      if(_id_8A03A7434EDA56FC) {
        if(scripts\engine\utility::array_contains(_id_2BDF748326F9F18C, player)) {
          _id_B1AD25AD91B2627D disableplayeruse(player);

          if(isDefined(_id_B1AD25AD91B2627D.ent_model))
            _id_B1AD25AD91B2627D.ent_model hidefromplayer(player);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(_id_2BDF748326F9F18C, player)) {
        _id_B1AD25AD91B2627D enableplayeruse(player);

        if(isDefined(_id_B1AD25AD91B2627D.ent_model))
          _id_B1AD25AD91B2627D.ent_model showtoplayer(player);
      }

      _id_C32DCE49091803F5 = scripts\engine\utility::array_add(_id_C32DCE49091803F5, player);
    }

    _id_2BDF748326F9F18C = _id_C32DCE49091803F5;
    wait 0.1;
  }
}

script_model_spawn_and_use(origin, angles, _id_45CFCB352A9B4A37, boxmodel, hintstring, headicon, _id_EC2D1026AD0C63AD, _id_4EA123D69D1C0EB9) {
  _id_B1AD25AD91B2627D = spawn("script_model", origin);

  if(isDefined(angles))
    _id_B1AD25AD91B2627D.angles = angles;
  else
    _id_B1AD25AD91B2627D.angles = (0, 0, 0);

  if(isDefined(boxmodel)) {
    if(isstring(boxmodel))
      _id_B1AD25AD91B2627D setModel(boxmodel);
    else if(isstruct(boxmodel) && isDefined(boxmodel.target))
      _id_B1AD25AD91B2627D.ent_model = getEnt(boxmodel.target, "targetname");
  }

  scripts\cp\cp_outline_utility::outlineenableforall(_id_B1AD25AD91B2627D, "outline_depth_white", "equipment");

  if(isDefined(headicon)) {
    _id_B1AD25AD91B2627D.headicon = thread scripts\cp\utility::ent_createheadicon(_id_B1AD25AD91B2627D, 15, "allies", headicon, 1);
    setheadiconmaxdistance(_id_B1AD25AD91B2627D.headicon, 1500);
    setheadiconnaturaldistance(_id_B1AD25AD91B2627D.headicon, 15);
  }

  _id_B1AD25AD91B2627D makeusable();
  _id_B1AD25AD91B2627D _meth_DFB78B3E724AD620(1);
  _id_B1AD25AD91B2627D setCursorHint("HINT_BUTTON");
  _id_B1AD25AD91B2627D sethintdisplayrange(200);
  _id_B1AD25AD91B2627D sethintdisplayfov(45);
  _id_B1AD25AD91B2627D setuserange(100);
  _id_B1AD25AD91B2627D setusefov(40);
  _id_B1AD25AD91B2627D sethintonobstruction("show");
  _id_B1AD25AD91B2627D setuseholdduration("duration_none");

  if(isDefined(hintstring))
    _id_B1AD25AD91B2627D setHintString(hintstring);

  _id_B1AD25AD91B2627D.isused = 0;

  if(isDefined(_id_EC2D1026AD0C63AD))
    thread[[_id_EC2D1026AD0C63AD]](_id_B1AD25AD91B2627D);

  thread script_model_spawn_and_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_4EA123D69D1C0EB9);
  return _id_B1AD25AD91B2627D;
}

script_model_spawn_and_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_4EA123D69D1C0EB9) {
  _id_B1AD25AD91B2627D endon("entitydeleted");

  for(;;) {
    _id_B1AD25AD91B2627D waittill("trigger", _id_6DFB045EE2B42AAD);

    if(!isPlayer(_id_6DFB045EE2B42AAD)) {
      continue;
    }
    thread[[_id_45CFCB352A9B4A37]](_id_B1AD25AD91B2627D, _id_6DFB045EE2B42AAD);

    if(istrue(_id_4EA123D69D1C0EB9) && istrue(_id_B1AD25AD91B2627D.isused)) {
      if(isDefined(_id_B1AD25AD91B2627D.ent_model)) {
        _id_B1AD25AD91B2627D.ent_model delete();
        wait 0.05;
      }

      _id_B1AD25AD91B2627D delete();
      break;
    }
  }
}

claymore_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::claymore_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/CLAYMORE", "hud_icon_equipment_claymore", "hud_icon_equipment_claymore_red", ::claymore_crate_player_at_max_ammo);
}

claymore_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_claymore", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_claymore", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

claymore_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_claymore");
}

adrenaline_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::adrenaline_crate_use, "lm_heal_first_aid_kit_01", &"CP_SO_FINALE/PICKUP_STIMS", "hud_icon_equipment_stim", "hud_icon_equipment_stim_red", ::adrenaline_crate_player_at_max_ammo);
}

adrenaline_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_adrenaline", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_adrenaline", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

adrenaline_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_adrenaline");
}

molotov_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::molotov_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/MOLOTOV", "hud_icon_equipment_molotov", "hud_icon_equipment_molotov_red", ::molotov_crate_player_at_max_ammo);
}

molotov_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_molotov", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_molotov", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

molotov_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_molotov");
}

frag_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, ::frag_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/FRAG", "hud_icon_equipment_frag", "hud_icon_equipment_frag_red", ::frag_crate_player_at_max_ammo);
}

frag_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_frag", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_frag", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

frag_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_frag");
}

c4_crate_spawn(origin, angles, _id_166611133C8F7524) {
  return support_box_spawn(origin, angles, ::c4_crate_use, "offhand_wm_supportbox_explosives", &"EQUIPMENT_HINTS/PICKUP_C4", "hud_icon_equipment_c4", "hud_icon_equipment_c4_red", ::c4_crate_player_at_max_ammo);
}

c4_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_c4", "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_c4", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

c4_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_c4");
}

flash_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_flash", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_flash", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

flash_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_flash");
}

_id_61B64A8DD9B2B4A1(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_hb_sensor", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_hb_sensor", 1);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

_id_DE561C1CD30D79FB(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_decoy", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_decoy", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

snapshot_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_snapshot_grenade", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_snapshot_grenade", 4);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

snapshot_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_snapshot_grenade");
}

gasgrenade_crate_use(_id_B1AD25AD91B2627D, player) {
  player _id_7EF95BBA57DC4B82::giveequipment("equip_gas_grenade", "secondary");
  player _id_7EF95BBA57DC4B82::setequipmentammo("equip_gas_grenade", 2);
  player forceplaygestureviewmodel("ges_swipe", _id_B1AD25AD91B2627D);
  player playlocalsound("weap_ammo_pickup");
}

gasgrenade_crate_player_at_max_ammo(player) {
  return player _id_1DB8D0E02A99C5E2::_id_06CB0B5230400C66("equip_gas_grenade");
}

support_box_spawn(origin, angles, _id_45CFCB352A9B4A37, _id_3474B4E818850C46, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_166611133C8F7524, _id_F7848454BCD0D7AA) {
  _id_B1AD25AD91B2627D = spawn("script_model", origin);
  _id_B1AD25AD91B2627D.angles = angles;

  if(isDefined(_id_3474B4E818850C46))
    _id_B1AD25AD91B2627D setModel(_id_3474B4E818850C46);
  else
    _id_B1AD25AD91B2627D setModel("offhand_wm_supportbox");

  support_box_make_entity_usable(_id_B1AD25AD91B2627D);
  thread support_box_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_166611133C8F7524);
  thread support_box_update_hint_logic(_id_B1AD25AD91B2627D, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_F7848454BCD0D7AA);
  return _id_B1AD25AD91B2627D;
}

support_box_make_entity_usable(entity) {
  entity makeusable();
  entity setCursorHint("HINT_NOICON");
  entity sethintdisplayrange(256);
  entity setuserange(84);
  entity setusefov(180);
  entity sethintdisplayfov(180);
  entity sethintonobstruction("show");
  entity setuseholdduration("duration_short");
  entity sethintrequiresholding(0);
  entity setusepriority(0);
}

support_box_use_logic(_id_B1AD25AD91B2627D, _id_45CFCB352A9B4A37, _id_166611133C8F7524) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  _id_9CDA4693FBC64277 = 0;

  for(;;) {
    _id_B1AD25AD91B2627D waittill("trigger", _id_6DFB045EE2B42AAD);

    if(!isPlayer(_id_6DFB045EE2B42AAD)) {
      continue;
    }
    thread[[_id_45CFCB352A9B4A37]](_id_B1AD25AD91B2627D, _id_6DFB045EE2B42AAD);

    if(support_box_is_scriptable_model(_id_B1AD25AD91B2627D.model)) {
      _id_B1AD25AD91B2627D setscriptablepartstate("anims", "open_no_pause", 0);
      wait(support_box_get_open_anim_length());
      _id_B1AD25AD91B2627D setscriptablepartstate("anims", "close_no_pause", 0);
      wait(support_box_get_close_anim_length());
    }

    _id_9CDA4693FBC64277++;

    if(isDefined(_id_166611133C8F7524) && _id_9CDA4693FBC64277 >= _id_166611133C8F7524)
      _id_B1AD25AD91B2627D delete();
  }
}

#using_animtree("scriptables");

support_box_get_open_anim_length() {
  return getanimlength(%wm_supportbox_ground_open);
}

support_box_get_close_anim_length() {
  return getanimlength(%wm_supportbox_ground_close);
}

support_box_is_scriptable_model(modelname) {
  if(modelname == "offhand_wm_supportbox")
    return 1;

  if(modelname == "offhand_wm_supportbox_ammunition")
    return 1;

  if(modelname == "offhand_wm_supportbox_explosives")
    return 1;

  return 0;
}

support_box_update_hint_logic(_id_B1AD25AD91B2627D, hintstring, headicon, _id_29CAD18B7B5A8BD0, _id_9A999C2EF8CE6CBF, _id_F7848454BCD0D7AA) {
  _id_B1AD25AD91B2627D endon("entitydeleted");

  if(!isDefined(_id_F7848454BCD0D7AA))
    _id_F7848454BCD0D7AA = &"COOP_GAME_PLAY/AMMO_MAX_RED";

  _id_B1AD25AD91B2627D setHintString(hintstring);
  _id_0CE91B3BEFD99F4D = spawn("script_origin", _id_B1AD25AD91B2627D.origin);
  support_box_make_entity_usable(_id_0CE91B3BEFD99F4D);
  _id_0CE91B3BEFD99F4D setHintString(_id_F7848454BCD0D7AA);
  _id_B1AD25AD91B2627D.headiconid = scripts\cp\utility::ent_createheadicon(_id_B1AD25AD91B2627D, 15, "allies", headicon, 1);
  setheadiconmaxdistance(_id_B1AD25AD91B2627D.headiconid, 1500);
  setheadiconnaturaldistance(_id_B1AD25AD91B2627D.headiconid, 15);
  _id_EC5983A2C8991A18 = _id_B1AD25AD91B2627D getentitynumber();
  _id_B291FA39EF7C3A62 = 0.1;

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player.supportboxmaxammo))
        player.supportboxmaxammo = [];

      if(_id_467F0FDFDD155A45::gamealreadyended()) {
        foreach(player in level.players) {
          removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
          return 1;
        }
      }

      _id_68756F14D1F443DE = !isDefined(player.supportboxmaxammo[_id_EC5983A2C8991A18]) || !player.supportboxmaxammo[_id_EC5983A2C8991A18];
      _id_E035DAA502312B39 = !isDefined(player.supportboxmaxammo[_id_EC5983A2C8991A18]) || player.supportboxmaxammo[_id_EC5983A2C8991A18];

      if(_id_68756F14D1F443DE && [[_id_9A999C2EF8CE6CBF]](player)) {
        player notify("support_box_update_player" + _id_EC5983A2C8991A18);
        removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
        _id_B1AD25AD91B2627D disableplayeruse(player);
        childthread support_box_delay_max_ammo_hint(player, _id_B1AD25AD91B2627D, _id_0CE91B3BEFD99F4D, _id_EC5983A2C8991A18);
        player.supportboxmaxammo[_id_B1AD25AD91B2627D getentitynumber()] = 1;
        continue;
      }

      if(_id_E035DAA502312B39 && ![[_id_9A999C2EF8CE6CBF]](player)) {
        player notify("support_box_update_player" + _id_EC5983A2C8991A18);
        addclienttoheadiconmask(_id_B1AD25AD91B2627D.headiconid, player);
        _id_B1AD25AD91B2627D enableplayeruse(player);
        _id_0CE91B3BEFD99F4D disableplayeruse(player);
        player.supportboxmaxammo[_id_B1AD25AD91B2627D getentitynumber()] = 0;
      }
    }

    wait(_id_B291FA39EF7C3A62);
  }
}

support_box_delay_max_ammo_hint(player, _id_B1AD25AD91B2627D, _id_0CE91B3BEFD99F4D, _id_EC5983A2C8991A18) {
  player endon("support_box_update_player" + _id_EC5983A2C8991A18);
  wait 2.0;
  _id_0CE91B3BEFD99F4D enableplayeruse(player);
}

_id_E6BCE649B1F466C2() {
  scripts\engine\utility::waittill_any_4("death", "unloaded", "driverdeath", "player_entered_enemy_vehicle");

  if(scripts\engine\utility::array_contains(level._id_24A25C6BE881BE0C, self))
    level._id_24A25C6BE881BE0C = scripts\engine\utility::array_remove(level._id_24A25C6BE881BE0C, self);

  if(level._id_24A25C6BE881BE0C.size == 0)
    scripts\engine\utility::flag_set("hover_lz");
}

_id_0DE018603BD4D720() {
  _id_4EECDCB9F4EFE6EF = scripts\engine\utility::getStructArray("door_close", "script_noteworthy");

  foreach(struct in _id_4EECDCB9F4EFE6EF) {
    _id_9DCC00E566F425F6 = _id_F0AACBE05ACE1594(struct.origin, 500);

    foreach(door in _id_9DCC00E566F425F6) {
      scripts\asm\asm_mp::doorclose(door);
      door scriptabledoorfreeze(1);
    }
  }
}

_id_30F7459EFB07516F() {
  _id_4EECDCB9F4EFE6EF = scripts\engine\utility::getStructArray("door_close", "script_noteworthy");

  foreach(struct in _id_4EECDCB9F4EFE6EF) {
    _id_9DCC00E566F425F6 = _id_F0AACBE05ACE1594(struct.origin, 500);

    foreach(door in _id_9DCC00E566F425F6) {
      scripts\asm\asm_mp::doorclose(door);
      door scriptabledoorfreeze(0);
    }
  }
}

_id_3703DAD2AF353FB0() {
  _id_6BBDC106C74E7C90 = scripts\engine\utility::getStructArray("door_freeze", "targetname");

  foreach(struct in _id_6BBDC106C74E7C90) {
    _id_9DCC00E566F425F6 = _id_F0AACBE05ACE1594(struct.origin, 128);

    foreach(door in _id_9DCC00E566F425F6)
    door scriptabledooropen("away", struct.origin);

    wait 1;

    foreach(door in _id_9DCC00E566F425F6)
    door scriptabledoorfreeze(1);
  }
}

_id_775CD164C569E279(alias, player, priority) {
  level endon("game_ended");
  _id_166B4F052DA169A7::_id_775CD164C569E279(alias, player, priority);
}

_id_40F96D73C66367ED(alias) {
  timeout = gettime() + 1000;

  while(gettime() < timeout && (istrue(level._id_BFE5BB3BA83502E3) || istrue(level._id_7BCA58EBC45C1D47)))
    wait 0.05;

  if(gettime() >= timeout) {
    return;
  }
  if(getdvarint("dvar_884081E00DE21B0C", 0) != 0) {
    _id_DE0C04C7F580D2F7 = 0;

    while(scripts\stealth\manager::anyone_in_combat()) {
      if(!istrue(_id_DE0C04C7F580D2F7))
        timeout = gettime() + 10000;

      wait 0.5;
    }

    if(gettime() >= timeout)
      return;
  }

  level._id_7BCA58EBC45C1D47 = 1;

  foreach(player in level.players)
  player.bcdisabled = 1;

  _id_166B4F052DA169A7::try_to_play_vo_on_team(alias);
  wait 0.25;

  foreach(player in level.players)
  player.bcdisabled = undefined;

  level._id_7BCA58EBC45C1D47 = 0;
}

_id_D18D54D06A474398() {
  if(isai(self))
    return 0;

  return isstruct(self) || isent(self) && self.classname == "script_origin";
}

_id_5151C9A51BB8C91E() {
  return scripts\common\vehicle::_id_9308A42C596B3BF4();
}

_id_F60B16BD3CA5FA28(target) {
  if(isai(target) && isalive(target))
    return 1;

  if(target _id_5151C9A51BB8C91E())
    return 1;

  return 0;
}

_id_D6C65A66F59242A4(target) {
  if(isagent(target))
    return 0;

  if(isvector(target))
    return 1;

  if(target _id_D18D54D06A474398())
    return 1;

  return 0;
}

_id_E36D49E7BA544F23(guys, anime, tag, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6) {
  pos = scripts\common\anim::get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);
    guy moveTo(_id_D917428537562C1F, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6);
    guy rotateTo(startang, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6);
  }
}

_id_929BB46251E5E4F2(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F) {
  if(scripts\cp\cp_objectives::is_objective_active("exfil_area"))
    thread _id_E493A78EECF60856(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F);
  else {
    if(scripts\cp_mp\calloutmarkerping::_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
      return;
    }
    if(scripts\cp_mp\calloutmarkerping::_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
      ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

      if(isDefined(ent)) {
        if(scripts\cp_mp\calloutmarkerping::_calloutmarkerping_isenemy(ent, self)) {
          _id_5F2CBFBAB811D7A4(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F, ent);
          return;
        }

        if(!isPlayer(ent)) {
          if(_id_394466C2DDB208CB == 6) {
            thread _id_559787D0D1081680();
            return;
          }

          return;
        }

        return;
        return;
      }
    } else {
      if(scripts\cp_mp\calloutmarkerping::_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D)) {
        return;
      }
      switch (_id_A1823E6B1CB4B46D) {
        case 6:
          thread _id_559787D0D1081680();
          break;
        case 5:
          break;
        case 2:
          break;
        case 4:
          break;
      }

      return;
    }
  }
}

_id_559787D0D1081680() {
  if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    return;
  }
  if(!isDefined(level._id_41DC72AD7677C882))
    level._id_41DC72AD7677C882 = gettime();

  if(gettime() >= level._id_41DC72AD7677C882)
    level._id_41DC72AD7677C882 = gettime() + 30000;
  else
    return;

  _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_thetruckisntthemissi");

  if(scripts\engine\utility::cointoss())
    _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_checkfireonthetruckd");
  else
    _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_stayhiddenstealthyou");
}

_id_B7148080659216FE() {
  level endon("game_ended");
  level endon("end_laswell_stealth_vo_threads");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_wait("stealth_spotted");
    level notify("back_in_combat");
    thread _id_85DBC601CA85387C();

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level notify("back_in_stealth");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    thread _id_F16C2604B0235097();
    waittillframeend;
  }
}

_id_85DBC601CA85387C() {
  level endon("back_in_stealth");
  level notify("vo_combatReactionLaswell");
  level endon("vo_combatReactionLaswell");
  level endon("end_laswell_stealth_vo_threads");

  foreach(player in level.players) {
    if(_func_8CE5803B7D377D72(player) == 1) {
      if(!isDefined(level._id_CB6D9943E51D8131))
        level._id_CB6D9943E51D8131 = gettime();

      if(gettime() >= level._id_CB6D9943E51D8131)
        level._id_CB6D9943E51D8131 = gettime() + 30000;
      else
        return;

      _id_6F1C6A80392D6BD4 = 0;

      foreach(vol in level._id_94D52412489D4DE7) {
        if(player istouching(vol))
          _id_6F1C6A80392D6BD4 = 1;
      }

      if(istrue(_id_6F1C6A80392D6BD4)) {
        if(scripts\engine\utility::cointoss()) {
          if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_findcovertrytobreakc");
          else
            _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_getoutoftheireyeline");
        } else
          _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_thatbuildingslikelyc");
      } else if(isDefined(player._id_3DB3AC8C06039207)) {
        objname = player._id_3DB3AC8C06039207.script_noteworthy;

        if(objname == "stealth_b") {
          if(scripts\engine\utility::cointoss()) {
            if(scripts\engine\utility::cointoss())
              _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_usethewatertogetouto");
            else
              _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_hideyourselfintheriv");
          } else if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_theymightloseyouinth");
          else
            _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_theriveruseit");
        } else {
          _id_2ADBA961C731BAF6 = randomintrange(1, 6);
          alias = "";

          switch (_id_2ADBA961C731BAF6) {
            case 1:
              alias = "dx_cp_cphy_ntro_lasw_breakcontact";
              break;
            case 2:
              alias = "dx_cp_cphy_ntro_lasw_usethedarkgetoutofth";
              break;
            case 3:
              alias = "dx_cp_cphy_ntro_lasw_fallbackgettotheshad";
              break;
            case 4:
              alias = "dx_cp_cphy_ntro_lasw_11godark";
              break;
            case 5:
              alias = "dx_cp_cphy_ntro_lasw_12godark";
              break;
          }

          if(alias != "")
            _id_775CD164C569E279(alias);
        }

        return;
      }
    }
  }
}

_id_F16C2604B0235097() {
  level endon("back_in_combat");
  level notify("vo_stealthReactionLaswell");
  level endon("vo_stealthReactionLaswell");

  if(!isDefined(level._id_8F4391F91A75EFF0))
    level._id_8F4391F91A75EFF0 = gettime();

  if(gettime() >= level._id_8F4391F91A75EFF0)
    level._id_8F4391F91A75EFF0 = gettime() + 30000;
  else
    return;

  waittime = 2;

  foreach(player in level.players)
  waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_2F4FCDB5F53AF5CA");

  if(isDefined(waittime))
    wait(waittime + 1.5);

  foreach(player in level.players) {
    if(_func_8CE5803B7D377D72(player) != 1) {
      _id_6F1C6A80392D6BD4 = 0;

      foreach(vol in level._id_94D52412489D4DE7) {
        if(player istouching(vol))
          _id_6F1C6A80392D6BD4 = 1;
      }

      if(istrue(_id_6F1C6A80392D6BD4)) {
        if(scripts\engine\utility::cointoss())
          _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_nowyouknowwhatnottod");
        else if(scripts\engine\utility::cointoss())
          _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_westillneedtosecuret");
        else
          _id_775CD164C569E279("dx_cp_cphy_aclo_lasw_aqsgotthisplacelocke");

        return;
      }
    }
  }

  _id_2ADBA961C731BAF6 = randomintrange(1, 6);
  alias = "";

  switch (_id_2ADBA961C731BAF6) {
    case 1:
      alias = "dx_cp_cphy_ntro_lasw_soundedlikethatwasal";
      break;
    case 2:
      alias = "dx_cp_cphy_ntro_lasw_seizingthosematerial";
      break;
    case 3:
      alias = "dx_cp_cphy_ntro_lasw_themissionisnttofigh";
      break;
    case 4:
      alias = "dx_cp_cphy_ntro_lasw_youdyingdowntheredoe";
      break;
    case 5:
      alias = "dx_cp_cphy_ntro_lasw_sticktothemissionfoc";
      break;
  }

  if(alias != "")
    _id_775CD164C569E279(alias);
}

_id_41CEEE366F058F64() {}

_id_5F2CBFBAB811D7A4(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F, ent) {
  self endon("disconnect");
  self notify("vo_processPingEventEnemy");
  self endon("vo_processPingEventEnemy");

  if(istrue(level._id_BFE5BB3BA83502E3)) {
    return;
  }
  wait 1;

  if(_func_8CE5803B7D377D72(self) == 1) {
    if(isDefined(self._id_3DB3AC8C06039207)) {
      objname = self._id_3DB3AC8C06039207.script_noteworthy;

      if(!isDefined(level._id_341BE79AC37F3E5D))
        level._id_341BE79AC37F3E5D = gettime();

      if(gettime() >= level._id_341BE79AC37F3E5D)
        level._id_341BE79AC37F3E5D = gettime() + 30000;
      else
        return;

      if(objname == "stealth_b") {
        if(scripts\engine\utility::cointoss()) {
          if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_usethewatertogetouto");
          else
            _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_hideyourselfintheriv");
        } else if(scripts\engine\utility::cointoss())
          _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_theymightloseyouinth");
        else
          _id_775CD164C569E279("dx_cp_cphy_ntro_lasw_theriveruseit");
      } else {
        _id_2ADBA961C731BAF6 = randomintrange(1, 6);
        alias = "";

        switch (_id_2ADBA961C731BAF6) {
          case 1:
            alias = "dx_cp_cphy_ntro_lasw_breakcontact";
            break;
          case 2:
            alias = "dx_cp_cphy_ntro_lasw_usethedarkgetoutofth";
            break;
          case 3:
            alias = "dx_cp_cphy_ntro_lasw_fallbackgettotheshad";
            break;
          case 4:
            alias = "dx_cp_cphy_ntro_lasw_11godark";
            break;
          case 5:
            alias = "dx_cp_cphy_ntro_lasw_12godark";
            break;
        }

        if(alias != "")
          _id_775CD164C569E279(alias);
      }
    }

    return;
  } else {
    if(ent scripts\cp\utility::isjuggernaut()) {
      if(!isDefined(level._id_5B8C59F49D7AC63D))
        level._id_5B8C59F49D7AC63D = gettime();

      if(gettime() >= level._id_5B8C59F49D7AC63D)
        level._id_5B8C59F49D7AC63D = gettime() + 30000;
      else
        return;

      _id_2ADBA961C731BAF6 = randomintrange(1, 4);
      alias = "";

      switch (_id_2ADBA961C731BAF6) {
        case 1:
          alias = "dx_cp_cphy_ntro_lasw_donotengagebreakerdo";
          break;
        case 2:
          alias = "dx_cp_cphy_ntro_lasw_donotengagethejugger";
          break;
        case 3:
          alias = "dx_cp_cphy_ntro_lasw_tryandslippastthatbi";
          break;
      }

      if(alias != "")
        _id_775CD164C569E279(alias);

      return;
    }

    level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
    _id_D34CD6F0897A5D61 = scripts\engine\utility::get_array_of_closest(self.origin, level._id_E7B157FD6CF95460, undefined, undefined, 1024);

    if(isDefined(_id_D34CD6F0897A5D61)) {
      if(!isDefined(level._id_C9EEA5BD32554C1D))
        level._id_C9EEA5BD32554C1D = gettime();

      if(gettime() >= level._id_C9EEA5BD32554C1D)
        level._id_C9EEA5BD32554C1D = gettime() + 30000;
      else
        return;

      _id_775CD164C569E279("dx_cp_cphy_clra_lasw_stayquietifyoucanbut");
      return;
    }

    if(!isDefined(level._id_64EB85D84F9373B6))
      level._id_64EB85D84F9373B6 = gettime();

    if(gettime() >= level._id_64EB85D84F9373B6)
      level._id_64EB85D84F9373B6 = gettime() + 30000;
    else
      return;

    _id_2ADBA961C731BAF6 = randomintrange(1, 9);
    alias = "";

    switch (_id_2ADBA961C731BAF6) {
      case 1:
        alias = "dx_cp_cphy_ntro_lasw_avoidcontactifpossib";
        break;
      case 2:
        alias = "dx_cp_cphy_ntro_lasw_trytoavoidcontactsta";
        break;
      case 3:
        alias = "dx_cp_cphy_ntro_lasw_evadecontactwherepos";
        break;
      case 4:
        alias = "dx_cp_cphy_ntro_lasw_onlymakecontactasala";
        break;
      case 5:
        alias = "dx_cp_cphy_ntro_lasw_onlyengageifyouhavet";
        break;
      case 6:
        alias = "dx_cp_cphy_ntro_lasw_avoidcontactifyoucan";
        break;
      case 7:
        alias = "dx_cp_cphy_ntro_lasw_weneedtorollunderthe";
        break;
      case 8:
        alias = "dx_cp_cphy_ntro_lasw_avoiddetectionbreake";
        break;
    }

    if(alias != "")
      _id_775CD164C569E279(alias);
  }
}

_id_E493A78EECF60856(_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F) {
  if(scripts\cp_mp\calloutmarkerping::_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    return;
  }
  if(scripts\cp_mp\calloutmarkerping::_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent)) {
      if(scripts\cp_mp\calloutmarkerping::_calloutmarkerping_isenemy(ent, self)) {
        return;
      }
      if(!isPlayer(ent)) {
        return;
      }
      return;
      return;
    }
  } else {
    if(scripts\cp_mp\calloutmarkerping::_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D)) {
      return;
    }
    switch (_id_A1823E6B1CB4B46D) {
      case 6:
        break;
      case 5:
        break;
      case 2:
        break;
      case 4:
        break;
    }

    return;
    return;
  }
}

_id_2DD223C2D3A19995() {
  if(scripts\engine\utility::flag_exist("safe_to_start_exfil_briefing"))
    scripts\engine\utility::flag_wait("safe_to_start_exfil_briefing");

  wait 4;

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_breaker1getoutofther");
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_movetoextraction");
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_breakcontactandgetou");
    scripts\engine\utility::flag_set("exfil_briefing_done");
  } else {
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_letsnotcelebratejust");
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_movetohlzsparrowfore");
    _id_775CD164C569E279("dx_cp_cphy_allo_lasw_andbreakersaqdeploye");
    wait 1.5;
    _id_613662165F17A93A::_id_57A8C25A4A5F3B82();
    scripts\engine\utility::flag_set("exfil_briefing_done");
  }

  for(;;) {
    foreach(player in level.players) {
      foreach(ai in getaiarrayinradius(player.origin, 2048)) {
        if(_id_2B79931B08683E0A::player_can_see_ai(player, ai)) {
          player _id_3519FCCC6F382F7F();
          return;
        }
      }
    }

    wait 1;
  }
}

_id_3519FCCC6F382F7F() {
  waittime = scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_CAFA7AD7442C35D5", undefined, 0.2);

  if(isDefined(waittime))
    wait(waittime);

  _id_CEB1FF9428033CFD = _id_1F35F09BD3F3DC51(self);
  alias = "stat_0000000000000000";

  if(scripts\engine\utility::cointoss())
    alias = "stat_52B2ADECC602D95C";
  else
    alias = "stat_0CD1D2547E61FB1E";

  waittime = 2;

  foreach(player in _id_CEB1FF9428033CFD)
  waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, alias);

  if(isDefined(waittime))
    wait(waittime);

  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_damnit");
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_breaker1canyoudiseng");
  waittime = 1;

  foreach(player in _id_CEB1FF9428033CFD)
  waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_14F86AF7D651B93F");

  if(isDefined(waittime))
    wait(waittime);

  waittime = scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_69EB281E78451991", undefined, 0.2);

  foreach(player in _id_CEB1FF9428033CFD)
  waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_69EB281E78451991");

  if(isDefined(waittime))
    wait(waittime);

  wait 1;
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_negativeitstoofarwer");
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_warlock11sparrowisco");
  _id_775CD164C569E279("dx_cp_cphy_rche_sggp_copythatwarlock11ise");
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_breakersmovetohlzfal");
  scripts\engine\utility::flag_set("exfil_intro_vo_done");
}

_id_1F35F09BD3F3DC51(_id_4245ED6808EE4864) {
  _id_50F783A5617F8940 = [];

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(level.players, _id_4245ED6808EE4864)) {
      continue;
    }
    _id_50F783A5617F8940 = scripts\engine\utility::array_add(_id_50F783A5617F8940, player);
  }

  return _id_50F783A5617F8940;
}

_id_F7A83698420E4D76() {
  scripts\engine\utility::flag_wait("exfil_briefing_done");
  scripts\engine\utility::flag_wait("exfil_intro_vo_done");
  wait 2;
  _id_775CD164C569E279("dx_cp_cphy_rche_sggp_allstationswarlock11");
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_warlockgetclearoffir");
  _id_775CD164C569E279("dx_cp_cphy_rche_sggp_copywarlock11holding");
  wait 6;
  scripts\engine\utility::flag_set("spawn_and_send_escort_chopper");
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_24whatsyourstatuswen");
  wait 2;
  _id_775CD164C569E279("dx_cp_cphy_rche_sgcp_thunder24isinboundno");
  scripts\engine\utility::flag_set("exfil_lz_heli_vo_done");
}

_id_5EDC9105AB852308() {
  if(!isDefined(level._id_C29CC0D54FF7F569))
    level._id_C29CC0D54FF7F569 = gettime();

  if(level._id_C29CC0D54FF7F569 > gettime()) {
    return;
  }
  alias = "";

  if(scripts\engine\utility::cointoss()) {
    if(scripts\engine\utility::cointoss())
      alias = "dx_cp_cphy_rche_sgcp_goodkill";
    else
      alias = "dx_cp_cphy_rche_sgcp_goodgunsgoodguns";
  } else if(scripts\engine\utility::cointoss())
    alias = "dx_cp_cphy_rche_sgcp_goodhitgoodhits";
  else
    alias = "dx_cp_cphy_rche_sgcp_targetsdown";

  if(scripts\engine\utility::cointoss())
    alias = "dx_cp_cphy_rche_sgcp_targetsdown";

  _id_46F432042B3473D8 = _id_166B4F052DA169A7::get_sound_length(alias);
  waittime = gettime() + _id_46F432042B3473D8 + 1000;

  while(istrue(level._id_BFE5BB3BA83502E3))
    waitframe();

  if(gettime() <= waittime) {
    level._id_C29CC0D54FF7F569 = level._id_C29CC0D54FF7F569 + 15000;
    _id_775CD164C569E279(alias);
  }
}

_id_17955A30568AFCBF() {
  _id_775CD164C569E279("dx_cp_cphy_rche_lasw_breaker1gettothelzth");
  wait 1;

  foreach(player in level.players)
  thread _id_FD02674F06C6ADA0(player);

  wait 1.5;
  scripts\engine\utility::flag_set("lz_heli_start_landing_vo_done");
}

_id_FD02674F06C6ADA0(player) {
  waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BCA5E472447F8C73");
  wait(waittime + 1);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_950A284047C4C938");
}

_id_65157E0C594D9F8D() {
  scripts\engine\utility::flag_wait("exfil_lz_heli_vo_done");
  scripts\engine\utility::flag_wait("lz_heli_start_landing_vo_done");
  wait 3;

  if(scripts\engine\utility::cointoss())
    _id_775CD164C569E279("dx_cp_cphy_rche_lasw_birdslandedletsgetyo");
  else if(scripts\engine\utility::cointoss())
    _id_775CD164C569E279("dx_cp_cphy_rche_lasw_getinthebirdletsgety");
  else
    _id_775CD164C569E279("dx_cp_cphy_rche_lasw_mountupandunassthatt");

  scripts\engine\utility::flag_set("lz_heli_landing_vo_done");
}

_id_4F3FE1EF4C48406D(_id_3045B0EF9A62916D) {
  level endon("both_players_entered_lz");

  if(scripts\engine\utility::flag("both_players_entered_lz")) {
    return;
  }
  if(!istrue(_id_3045B0EF9A62916D._id_74F0D6092D38DA9E)) {
    _id_3045B0EF9A62916D._id_74F0D6092D38DA9E = 1;
    scripts\engine\utility::flag_set("both_players_entered_lz");

    if(scripts\engine\utility::cointoss())
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_werenotouttathisyetw");
    else if(scripts\engine\utility::cointoss()) {
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_itsnotoveryet");
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11gettothelzwecantho");
    } else if(scripts\engine\utility::cointoss())
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12gettothelzwecantho");
    else
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_allbreakersgettoextr");

    thread _id_A27DF847C003F9F9(_id_3045B0EF9A62916D);
    thread _id_17E2EBDD350575FC(_id_3045B0EF9A62916D);
  } else {}
}

_id_17E2EBDD350575FC(_id_3045B0EF9A62916D) {
  _id_3045B0EF9A62916D notify("vo_watchForPlayerLeavingHeli");
  _id_3045B0EF9A62916D endon("vo_watchForPlayerLeavingHeli");
  _id_3045B0EF9A62916D endon("disconnect");
  level endon("both_players_entered_lz");

  while(_id_3045B0EF9A62916D istouching(level._id_DF588BF29C7FF9BC))
    waitframe();

  scripts\engine\utility::flag_clear("both_players_entered_lz");
}

_id_DF4629AF9E490831() {
  level notify("vo_watchForPlayersLingeringNearTheExfil");
  level endon("vo_watchForPlayersLingeringNearTheExfil");
  scripts\engine\utility::flag_wait("exfil_lz_heli_vo_done");
  scripts\engine\utility::flag_wait("lz_heli_landing_vo_done");
  waittime = 15;
  _id_CC4B9CFA93202799 = level._id_2D101818F128EF41;

  for(;;) {
    wait(waittime);
    pos = scripts\cp\utility\entity::getaverageorigin(level.players);

    if(isDefined(_id_CC4B9CFA93202799)) {
      _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 2048);

      if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size == 0) {
        if(_func_EAC0CD99C9C6D8EE() == "spotted") {
          _id_F96F73327D7355B2 = scripts\engine\utility::random(level.players);
          level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_F96F73327D7355B2, "stat_29C83D721F765AB4", undefined, 0.75);
          _id_CEB1FF9428033CFD = _id_1F35F09BD3F3DC51(_id_F96F73327D7355B2);

          foreach(player in _id_CEB1FF9428033CFD)
          waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_7CB1A871B292B051");

          wait(waittime);

          if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11weneedtoextracttho");
          else
            _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12gettothelzweneedto");
        } else {
          _id_775CD164C569E279("dx_cp_cphy_rche_sgcp_allstationsthunder24");

          if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11gettofalcon");
          else if(scripts\engine\utility::cointoss())
            _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12movetothelz");
          else
            _id_775CD164C569E279("dx_cp_cphy_rche_lasw_breakersgettothelz");
        }

        waittime = 15;
        continue;
      }

      _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 1024);

      if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size == 0) {
        if(scripts\engine\utility::cointoss()) {
          _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11gettothelzcoordina");
          continue;
        }

        if(scripts\engine\utility::cointoss()) {
          _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12getbackontargetcoo");
          continue;
        }

        _id_775CD164C569E279("dx_cp_cphy_rche_lasw_lzcoordinatesaremark");
      }
    }
  }
}

_id_A27DF847C003F9F9(_id_3045B0EF9A62916D) {
  level endon("both_players_entered_lz");
  level notify("vo_watchForOtherPlayerLingering");
  level endon("vo_watchForOtherPlayerLingering");
  _id_CEB1FF9428033CFD = _id_1F35F09BD3F3DC51(_id_3045B0EF9A62916D);

  for(;;) {
    wait 30;
    waittime = 3;
    waittime = _id_3045B0EF9A62916D thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_3045B0EF9A62916D, "stat_F458C331E69877ED", undefined, 0.2);
    wait(waittime);
    waittime = _id_3045B0EF9A62916D thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_3045B0EF9A62916D, "stat_9CFD046971856D0E", undefined, 0.2);
    wait(waittime);

    if(scripts\engine\utility::cointoss())
      _id_775CD164C569E279("dx_cp_cphy_rche_sggp_watcher1thisposition");
    else if(scripts\engine\utility::cointoss())
      _id_775CD164C569E279("dx_cp_cphy_rche_sggp_wecantsitheremuchlon");
    else
      _id_775CD164C569E279("dx_cp_cphy_rche_sggp_whatsthecallwatcher1");

    _id_775CD164C569E279("dx_cp_cphy_rche_lasw_holdforbreakertheyll");

    if(scripts\engine\utility::cointoss()) {
      if(scripts\engine\utility::cointoss())
        _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11secureyourteammate");
      else
        _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12secureyourteammate");

      continue;
    }

    if(scripts\engine\utility::cointoss()) {
      _id_775CD164C569E279("dx_cp_cphy_rche_lasw_11getyourteammatetot");
      continue;
    }

    _id_775CD164C569E279("dx_cp_cphy_rche_lasw_12getyourteammatetot");
  }
}

_id_A990CCB6B2523CB3() {
  _id_266043D5419A7A94 = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_DF588BF29C7FF9BC)) {
      _id_266043D5419A7A94 = 1;
      break;
    }
  }

  if(istrue(_id_266043D5419A7A94)) {
    _id_775CD164C569E279("dx_cp_cphy_rche_sgcp_thunder24iswincheste_01");
    _id_775CD164C569E279("dx_cp_cphy_rche_sggp_shitwecantsitherewit");
  } else
    _id_775CD164C569E279("dx_cp_cphy_rche_sgcp_thunder24iswincheste_01");
}

_id_9DC1F66EA9B70CFE() {
  _id_775CD164C569E279("dx_cp_cphy_cmms_sggp_watcher1warlock11all");
  wait 1;
  waittime = 3;

  foreach(player in level.players)
  waittime = thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_7CB1A871B292B051", undefined, 0.2);

  wait(waittime + 1);
  _id_775CD164C569E279("dx_cp_cphy_cmms_lasw_excellentworkbreaker");
  _id_775CD164C569E279("dx_cp_cphy_cmms_lasw_cargosecuremissionac");
}

_id_5EF48BFD0E04E23A(player) {
  while(!_id_73709F2B96C09080(getaiarray("axis"), 1, player))
    waitframe();
}

_id_73709F2B96C09080(array, _id_01ED762217419B34, player) {
  array = scripts\engine\utility::_id_53C4C53197386572(array, getaiarray("axis"));

  foreach(guy in array) {
    if(scripts\engine\utility::is_dead_or_dying(guy) || istrue(guy._id_776F2137854DF85E) || istrue(guy.in_melee_death)) {
      continue;
    }
    if(!isDefined(player))
      player = scripts\engine\utility::getclosest(guy.origin, level.players);

    if(!isDefined(guy.enemy) || !scripts\engine\utility::is_equal(guy.enemy, player)) {
      continue;
    }
    if(istrue(_id_01ED762217419B34) && scripts\engine\utility::time_has_passed(guy._blackboard._id_060DCAA3D3BE97AB, 6)) {
      continue;
    }
    if(guy._id_FE5EBEFA740C7106 == 3)
      return 1;
  }

  return 0;
}

_id_D53CBA5E1D4C7E49(array, _id_CC748B6D457627FE) {
  array = scripts\engine\utility::_id_53C4C53197386572(array, getaiarray("axis"));
  _id_CC748B6D457627FE = scripts\engine\utility::_id_53C4C53197386572(10);

  foreach(guy in array) {
    if(scripts\engine\utility::is_dead_or_dying(guy) || istrue(guy._id_776F2137854DF85E) || istrue(guy.in_melee_death)) {
      continue;
    }
    lastshoottime = guy._blackboard._id_060DCAA3D3BE97AB;

    if(isDefined(lastshoottime) && !scripts\engine\utility::time_has_passed(lastshoottime, _id_CC748B6D457627FE))
      return 1;
  }

  return 0;
}