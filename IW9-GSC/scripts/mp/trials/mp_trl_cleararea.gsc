/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_cleararea.gsc
**************************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["clear"] = ::init;
}

init() {
  analytics_init();
  setdvarifuninitialized("dvar_671B60DEF011C822", "uav");
  setdvarifuninitialized("dvar_8DF9A6A3B1A92D7C", "30");

  if(!isDefined(game["trial"]))
    game["trial"] = [];

  if(!isDefined(game["trial"]["best_reward"]))
    game["trial"]["best_reward"] = 0;

  if(!isDefined(game["trial"]["tries_remaining"]))
    game["trial"]["tries_remaining"] = level.trial["attempts"];

  level.mapname = level.trial["zone"];
  level.enemies = [];
  level.enemiesactivenb = 0;
  level.enemiestotal = 0;
  level.enemieskilled = 0;
  level.totaltimeelapsed = 0;
  level.attempttier = 0;
  level.maxtimelimit = 59999900;
  level.modeonspawnplayer = ::player_onspawn;
  level scripts\engine\utility::flag_init("trial_start_zone_entered");
  level scripts\engine\utility::flag_init("trial_countdown");
  level scripts\engine\utility::flag_init("trial_starting");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_ready_for_endscreen");
  level scripts\engine\utility::flag_init("trial_player_death");
  precachemodel("tag_origin");
  precachemodel("player128x128x8");
  precachemodel("box_wooden_grenade_02_green");
  precachemodel("head_al_qatala_3_ar");
  precachemodel("head_al_qatala_desert_05");
  precachemodel("head_al_qatala_desert_08");
  precachemodel("head_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02");
  precachemodel("body_al_qatala_desert_03");
  precachemodel("body_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02_b");
  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "head_al_qatala_3_ar";
  level.enemyheadmodels[1] = "head_al_qatala_desert_05";
  level.enemyheadmodels[2] = "head_al_qatala_desert_08";
  level.enemyheadmodels[3] = "head_al_qatala_desert_09";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "body_al_qatala_desert_02";
  level.enemybodymodels[1] = "body_al_qatala_desert_03";
  level.enemybodymodels[2] = "body_al_qatala_desert_09";
  level.enemybodymodels[3] = "body_al_qatala_desert_02_b";
  thread trial_start_init();
  thread player_init();
  thread enemies_init();
  thread enemy_chatter();
  thread hud_init();
  thread dialog_init();
  level.battlechatterenabled = 0;

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  thread starting_trigger_fix();
  level.allnodes = getallnodes();
}

trial_start_init() {
  level endon("nuked");

  while(!isDefined(level.struct_class_names))
    waitframe();

  if(istrue(level.trial_explosive_clear)) {
    level.explosive_barrels = getEntArray("explosive_barrel", "targetname");
    level.explosive_cars = getEntArray("explosive_car", "targetname");
    level.ammo_crates = getEntArray("ammo_crate", "targetname");
    scripts\engine\utility::array_thread(level.explosive_cars, ::destructable_car);
    scripts\engine\utility::array_thread(level.explosive_barrels, ::barrel_think);
    scripts\engine\utility::array_thread(level.ammo_crates, ::ammo_crate_think);
  }

  _id_EE32376B13801F98 = getEnt("door_left", "targetname");
  _id_7BF201849AE293CD = getEnt("door_right", "targetname");
  _id_487962944033238B = getEnt("door_col_left", "targetname");
  _id_94B1984C7B2B2714 = getEnt("door_col_right", "targetname");
  _id_3E8864A4369971E3 = undefined;

  if(level.mapname == "mp_spear" || level.mapname == "mp_spear_pm") {
    _id_3E8864A4369971E3 = getEnt("door_coll", "targetname");
    _id_E6A93FE2AD215A3A = getEnt("door_left_coll", "targetname");
    _id_4A443AE4A640FF9F = getEnt("door_right_coll", "targetname");
    _id_E6A93FE2AD215A3A linkTo(_id_EE32376B13801F98);
    _id_4A443AE4A640FF9F linkTo(_id_7BF201849AE293CD);
  } else if(isDefined(_id_487962944033238B) || isDefined(_id_94B1984C7B2B2714)) {
    if(isDefined(_id_487962944033238B))
      _id_EE32376B13801F98.col = _id_487962944033238B;

    if(isDefined(_id_94B1984C7B2B2714))
      _id_7BF201849AE293CD.col = _id_94B1984C7B2B2714;
  } else {
    _id_1FA5B98D057C092A = spawn("script_model", _id_EE32376B13801F98.origin);
    _id_1FA5B98D057C092A.angles = _id_EE32376B13801F98.angles;
    _id_1FA5B88D057C06F7 = spawn("script_model", _id_EE32376B13801F98.origin);
    _id_1FA5B88D057C06F7.angles = _id_EE32376B13801F98.angles;
    _id_BEA1DB9CF533E183 = spawn("script_model", _id_7BF201849AE293CD.origin);
    _id_BEA1DB9CF533E183.angles = _id_7BF201849AE293CD.angles;
    _id_BEA1DC9CF533E3B6 = spawn("script_model", _id_7BF201849AE293CD.origin);
    _id_BEA1DC9CF533E3B6.angles = _id_7BF201849AE293CD.angles;
    _id_1FA5B98D057C092A setModel("player128x128x8");
    _id_1FA5B88D057C06F7 setModel("player128x128x8");
    _id_BEA1DB9CF533E183 setModel("player128x128x8");
    _id_BEA1DC9CF533E3B6 setModel("player128x128x8");
    _id_1FA5B98D057C092A linkTo(_id_EE32376B13801F98, "cp_disco_gate_01_left", (0, -44, 20), (90, 0, 0));
    _id_1FA5B88D057C06F7 linkTo(_id_EE32376B13801F98, "cp_disco_gate_01_left", (0, -44, 84), (90, 0, 0));
    _id_BEA1DB9CF533E183 linkTo(_id_7BF201849AE293CD, "cp_disco_gate_01_right", (0, -44, 20), (-90, 0, 0));
    _id_BEA1DC9CF533E3B6 linkTo(_id_7BF201849AE293CD, "cp_disco_gate_01_right", (0, -44, 84), (-90, 0, 0));
  }

  _id_907CD79AEECD9BA5 = scripts\mp\trials\mp_trials_patches::trial_chevron_init();

  while(!isDefined(level.player))
    wait 0.05;

  if(isDefined(level.trial_player_perks)) {
    foreach(perk in level.trial_player_perks)
    level.player setperk(perk, 1);
  }

  while(!isalive(level.player))
    wait 0.05;

  if(game["trial"]["tries_remaining"] > 2)
    wait 8;

  wait 2;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(_id_907CD79AEECD9BA5, "turn_on");
  level scripts\engine\utility::flag_wait("trial_start_zone_entered");
  level.started = 1;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(_id_907CD79AEECD9BA5, "turn_off");
  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  thread radar_think();
  wait 2;
  level scripts\engine\utility::flag_set("trial_countdown");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level scripts\engine\utility::flag_set("trial_starting");
  thread player_monitor_death();

  if(isDefined(_id_3E8864A4369971E3))
    _id_3E8864A4369971E3 notsolid();

  _id_7BF201849AE293CD playSound("trial_sfx_door_chainlink_fast");
  _id_EE32376B13801F98 playSound("trial_sfx_door_chainlink_fast");
  _id_7BF201849AE293CD rotateYaw(-150, 0.75);
  _id_EE32376B13801F98 rotateYaw(150, 0.75);

  if(isDefined(_id_EE32376B13801F98.col))
    _id_EE32376B13801F98.col delete();

  if(isDefined(_id_7BF201849AE293CD.col))
    _id_7BF201849AE293CD.col delete();
}

radar_think() {
  _id_2DBCBBE66AA95FAF = getDvar("dvar_671B60DEF011C822");

  if(_id_2DBCBBE66AA95FAF != "none") {
    _id_F5C0017750F207A3 = level.player scripts\mp\equipment::getcurrentequipment("primary");
    _id_88A4301996574201 = level.player scripts\mp\equipment::getequipmentammo("primary");
    _id_702915CBE6AD0CE3 = level.player scripts\mp\equipment::getcurrentequipment("secondary");
    _id_4B32EE4ED2E65841 = level.player scripts\mp\equipment::getequipmentammo("secondary");

    if(isDefined(_id_F5C0017750F207A3)) {
      level.player scripts\mp\equipment::takeequipment("primary");
      _id_CC676E5008419246 = 1;
    } else
      _id_CC676E5008419246 = 0;

    if(isDefined(_id_702915CBE6AD0CE3)) {
      level.player scripts\mp\equipment::takeequipment("secondary");
      _id_3FA3D8B1566D0742 = 1;
    } else
      _id_3FA3D8B1566D0742 = 0;

    level.player allowmelee(0);
    level.player allowsprint(0);
    level.player allowreload(0);
    level.player cancelreload();

    while(level.player ismeleeing())
      waitframe();

    level.uavsettings[_id_2DBCBBE66AA95FAF].timeout = 9999;
    level.player scripts\cp_mp\killstreaks\uav::tryuseuav(_id_2DBCBBE66AA95FAF);
    waitframe();
    level.player allowmelee(1);
    level.player allowsprint(1);
    level.player allowreload(1);

    if(isDefined(_id_F5C0017750F207A3) && istrue(_id_CC676E5008419246))
      level.player scripts\mp\equipment::giveequipment(_id_F5C0017750F207A3, "primary");

    if(isDefined(_id_702915CBE6AD0CE3) && istrue(_id_3FA3D8B1566D0742))
      level.player scripts\mp\equipment::giveequipment(_id_702915CBE6AD0CE3, "secondary");
  }
}

player_init() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  wait 0.5;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.enemyteam = scripts\engine\utility::get_enemy_team(level.player.team);
  level.playerteam = level.player.team;

  if(level.playerteam == "axis") {
    level.enemyteam = "allies";
    level.agent_definition["actor_enemy_mp_trial_clr"]["team"] = level.enemyteam;

    if(isDefined(level.nightmap) && level.nightmap == 1) {
      level.agent_definition["actor_enemy_mp_trial_clr_ar_night"]["team"] = level.enemyteam;
      level.agent_definition["actor_enemy_mp_trial_clr_smg_night"]["team"] = level.enemyteam;
    } else {
      level.agent_definition["actor_enemy_mp_trial_clr_ar"]["team"] = level.enemyteam;
      level.agent_definition["actor_enemy_mp_trial_clr_smg"]["team"] = level.enemyteam;
    }
  }

  thread grenadeboxes_init();
  thread player_equipment_init();
  thread player_ammo_think();
}

player_onspawn(_id_9156B53BCF7CE573) {
  level.player.maxhealth = 250;
  level.player.health = 250;
  scripts\engine\utility::delaythread(1, ::player_equipment_init);
  scripts\engine\utility::delaythread(1, ::player_ammo_think);
}

player_monitor_death() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  setDvar("scr_death_scene_time", 8);
  setdynamicdvar("dvar_FA0A136294E75014", 0);
  level.player waittill("death", attacker);
  setDvar("scr_death_scene_time", 1.75);
  level.player setclientomnvar("ui_killcam_killedby_id", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("trial_player_death");
  level scripts\engine\utility::flag_set("trial_completed");
}

player_equipment_init() {
  if(isDefined(level.player_equip_primary))
    level.player scripts\mp\equipment::giveequipment(level.player_equip_primary, "primary");

  if(isDefined(level.player_equip_secondary))
    level.player scripts\mp\equipment::giveequipment(level.player_equip_secondary, "secondary");

  if(istrue(level.player_equip_regen))
    thread recharge_equipment_init();
}

player_ammo_think() {
  _id_E626E2178EB7AB8F = level.player getweaponslistprimaries();

  if(istrue(level.player_limitedammo)) {
    foreach(weapon in _id_E626E2178EB7AB8F) {
      _id_AED95A39B937C353 = level.player getweaponammoclip(weapon) + level.player getweaponammostock(weapon);
      _id_D1AD88BF84DAA67F = level.enemiestotal - weaponclipsize(weapon);
      level.player setweaponammoclip(weapon, weaponclipsize(weapon));
      level.player setweaponammostock(weapon, _id_D1AD88BF84DAA67F);
    }

    foreach(spawner in level.trial_weapons) {
      if(isDefined(spawner.spawned_weapon)) {
        _id_AC9CAEBED426E625 = weaponclipsize(spawner.spawned_weapon);
        _id_D1AD88BF84DAA67F = level.enemiestotal - _id_AC9CAEBED426E625;
        spawner.spawned_weapon itemweaponsetammo(_id_AC9CAEBED426E625, _id_D1AD88BF84DAA67F);
      }
    }
  } else {
    foreach(weapon in _id_E626E2178EB7AB8F) {
      level.player setweaponammoclip(weapon, weaponclipsize(weapon));
      level.player givemaxammo(weapon);
    }

    foreach(spawner in level.trial_weapons) {
      if(isDefined(spawner.spawned_weapon)) {
        _id_AC9CAEBED426E625 = weaponclipsize(spawner.spawned_weapon);
        _id_D1AD88BF84DAA67F = weaponmaxammo(spawner.spawned_weapon);
        spawner.spawned_weapon itemweaponsetammo(_id_AC9CAEBED426E625, _id_D1AD88BF84DAA67F);
      }
    }
  }
}

grenadeboxes_init() {
  _id_B64F589D2AB297C8 = getEntArray("grenade_box", "targetname");
  scripts\engine\utility::array_thread(_id_B64F589D2AB297C8, ::grenadebox_think);
}

grenadebox_think() {
  switch (self.script_noteworthy) {
    case "frag":
      equipmentref = "equip_frag";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
    case "semtex":
      equipmentref = "equip_semtex";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_SEMTEX";
      break;
    case "c4":
      equipmentref = "equip_c4";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_C4";
      break;
    case "claymore":
      equipmentref = "equip_claymore";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
      break;
    case "atmine":
      equipmentref = "equip_at_mine";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_ATMINE";
      break;
    case "tknife":
      equipmentref = "equip_throwing_knife";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_TKNIFE";
      break;
    case "molotov":
      equipmentref = "equip_molotov";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
      break;
    case "thermite":
      equipmentref = "equip_thermite";
      slot = "primary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_THERMITE";
      break;
    case "flash":
      equipmentref = "equip_flash";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_FLASH";
      break;
    case "snapshot":
      equipmentref = "equip_snapshot_grenade";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
      break;
    case "smoke":
      equipmentref = "equip_smoke";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_SMOKE";
      break;
    case "stun":
      equipmentref = "equip_concussion";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_STUN";
      break;
    case "trophy":
      equipmentref = "equip_trophy";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_TROPHY_SYSTEM";
      break;
    case "decoy":
      equipmentref = "equip_decoy";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_DECOY";
      break;
    case "stim":
      equipmentref = "equip_adrenaline";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_STIM";
      break;
    case "scrambler":
      equipmentref = "equip_scramblerdrone";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_SCRAMBLER";
      break;
    default:
      equipmentref = "equip_frag";
      slot = "secondary";
      hintstring = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
  }

  interact = spawn("script_model", self.origin);
  interact linkTo(self, "tag_origin", (5, 0, 12), (0, 0, 0));
  interact setModel("tag_origin");

  while(!scripts\engine\utility::flag("trial_completed")) {
    interact makeusable();
    interact setHintString(hintstring);
    interact setCursorHint("hint_button");
    interact sethintdisplayrange(200);
    interact sethintdisplayfov(65);
    interact setuserange(72);
    interact setusefov(120);
    interact sethintonobstruction("show");
    interact setuseholdduration("duration_short");
    interact waittill("trigger");
    level.player scripts\mp\equipment::giveequipment(equipmentref, slot);
    interact makeunusable();
    wait 2.5;
  }

  interact makeunusable();
}

enemies_init() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_261D5FDEE9F7C760 = getEnt("starting_trigger", "targetname");
  _id_8A0DA49670997C6D = _id_261D5FDEE9F7C760 scripts\engine\utility::get_target_array();
  level.enemyspawners = [];
  _id_472B151D674F3B77 = getDvar("dvar_8DF9A6A3B1A92D7C");

  foreach(spawner in _id_8A0DA49670997C6D) {
    if(isDefined(spawner.script_index)) {
      if(int(spawner.script_index) <= int(_id_472B151D674F3B77))
        level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, spawner);

      continue;
    }

    level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, spawner);
  }

  level.enemiestotal = level.enemiestotal + level.enemyspawners.size;

  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  scripts\engine\utility::array_thread(level.enemyspawners, ::enemy_individual_spawn);
  thread enemies_spawnif_noactive();
  thread enemy_failsafe_ifonedidntspawn();
  thread enemies_validate_life();
}

enemy_model_setup(_id_609E0966D9232534) {
  head = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  body = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(body);
  self attach(head, "", 1);
  self.headmodel = head;
}

enemy_individual_spawn() {
  spawner = self;
  level scripts\engine\utility::flag_wait("trial_countdown");
  _id_D9CA876214BE1704 = "enemy_mp_trial_clr_";

  if(isDefined(level.nightmap) && level.nightmap == 1)
    _id_32000FB0DEEF88EF = "_night";
  else
    _id_32000FB0DEEF88EF = "";

  switch (spawner.script_noteworthy) {
    case "lmg":
    case "ar":
      aitype = _id_D9CA876214BE1704 + "ar" + _id_32000FB0DEEF88EF;
      break;
    case "smg":
      aitype = _id_D9CA876214BE1704 + "smg" + _id_32000FB0DEEF88EF;
      break;
    default:
      aitype = "enemy_mp_trial_clr";
      break;
  }

  triggers = getEntArray("spawning_zone", "targetname");
  spawner thread enemy_spawner_checkdist(triggers);
  spawner waittill("plz_spawn");
  level.enemiesactivenb++;
  level.enemyspawners = scripts\engine\utility::array_remove(level.enemyspawners, spawner);
  _id_F1DEDCCA27836AD7 = scripts\mp\mp_agent::spawnnewagentaitype(aitype, spawner.origin, spawner.angles);

  while(!isDefined(_id_F1DEDCCA27836AD7))
    wait 0.05;

  level.enemies[level.enemies.size] = _id_F1DEDCCA27836AD7;
  _id_F1DEDCCA27836AD7 thread enemy_monitor_death(level.enemyteam);
  _id_F1DEDCCA27836AD7 thread enemy_soldier_think();
  _id_F1DEDCCA27836AD7 thread enemy_model_setup();

  if(isDefined(spawner.target))
    spawner thread enemy_move_and_cover(_id_F1DEDCCA27836AD7);
}

enemy_spawner_checkdist(triggers) {
  self endon("plz_spawn");
  maxagents = getmaxagents() - 1;
  level scripts\engine\utility::flag_wait("trial_starting");

  if(isDefined(self.radius))
    _id_5078A08CC4EC9D12 = self.radius;
  else
    _id_5078A08CC4EC9D12 = 1400;

  _id_4600CF4971224C65 = [];
  _id_F0FFB87D0DB8C6C0 = spawn("script_origin", self.origin);

  foreach(trigger in triggers) {
    if(trigger istouching(_id_F0FFB87D0DB8C6C0))
      _id_4600CF4971224C65 = scripts\engine\utility::array_add(_id_4600CF4971224C65, trigger);
  }

  _id_F0FFB87D0DB8C6C0 delete();

  for(;;) {
    _id_B6070257CF20001E = 0;

    if(_id_4600CF4971224C65.size > 0) {
      foreach(trigger in _id_4600CF4971224C65)
      _id_B6070257CF20001E = level.player istouching(trigger);
    } else
      _id_B6070257CF20001E = 1;

    _id_2A76E479FB556A05 = distance2d(level.player.origin, self.origin);
    _id_32363473B223123A = _id_2A76E479FB556A05 < 250;
    _id_DEF88A7E3787BA2C = _id_2A76E479FB556A05 < _id_5078A08CC4EC9D12;
    _id_1B2E404A59BAF8A3 = level.enemiesactivenb < maxagents;
    _id_EF251C63729784BD = level.player gettagorigin("tag_eye");
    _id_42DE6DFE2AC25CE5 = (self.origin[0], self.origin[1], self.origin[2] + 40);
    _id_0020BF5B24840CC8 = spawnsighttrace(self, _id_EF251C63729784BD, _id_42DE6DFE2AC25CE5);

    if(!_id_0020BF5B24840CC8 && _id_B6070257CF20001E && _id_DEF88A7E3787BA2C && !_id_32363473B223123A && _id_1B2E404A59BAF8A3) {
      self notify("plz_spawn");
      continue;
    }

    wait 0.05;
  }
}

enemies_spawnif_noactive() {
  level scripts\engine\utility::flag_wait("trial_countdown");
  level endon("stop_timer");
  triggers = getEntArray("spawning_zone", "targetname");
  triggers = scripts\engine\utility::array_sort_with_func(triggers, ::check_script_noteworthy);

  while(!scripts\engine\utility::flag("trial_completed")) {
    _id_E276A300DDA49D9B = [];
    _id_DD778B8EE25ED172 = [];
    _id_EB629964517B0C20 = [];
    _id_1DED5251E319CA05 = [];
    _id_41B91FD2101F153A = undefined;

    while(level.enemies.size > 0)
      wait 0.25;

    foreach(trigger in triggers) {
      if(trigger istouching(level.player))
        _id_E276A300DDA49D9B = scripts\engine\utility::array_add(_id_E276A300DDA49D9B, trigger);
    }

    _id_DD778B8EE25ED172 = return_enemyspawners_in_zones(_id_E276A300DDA49D9B);

    if(_id_DD778B8EE25ED172.size == 0) {
      _id_FE8F7203F63133D5 = [];
      _id_880AFAB75682943B = [];

      foreach(trigger in _id_E276A300DDA49D9B) {
        _id_FE8F7203F63133D5[_id_FE8F7203F63133D5.size] = int(trigger.script_noteworthy) + 1;
        _id_FE8F7203F63133D5[_id_FE8F7203F63133D5.size] = int(trigger.script_noteworthy) + -1;
      }

      foreach(id in _id_FE8F7203F63133D5) {
        foreach(trigger in triggers) {
          if(int(trigger.script_noteworthy) == id)
            _id_880AFAB75682943B = scripts\engine\utility::array_add(_id_880AFAB75682943B, trigger);
        }
      }

      _id_DD778B8EE25ED172 = return_enemyspawners_in_zones(_id_880AFAB75682943B);
    }

    if(_id_DD778B8EE25ED172.size == 0)
      _id_DD778B8EE25ED172[0] = scripts\engine\utility::getclosest(level.player.origin, level.enemyspawners);

    _id_EB629964517B0C20 = _id_DD778B8EE25ED172;
    _id_1DED5251E319CA05 = scripts\engine\utility::get_array_of_closest(level.player.origin, _id_EB629964517B0C20);

    if(_id_1DED5251E319CA05.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1DED5251E319CA05.size; _id_AC0E594AC96AA3A8++) {
        _id_41B91FD2101F153A = scripts\engine\utility::random_weight_sorted(_id_1DED5251E319CA05);
        _id_EF251C63729784BD = level.player gettagorigin("tag_eye");
        _id_42DE6DFE2AC25CE5 = (_id_41B91FD2101F153A.origin[0], _id_41B91FD2101F153A.origin[1], _id_41B91FD2101F153A.origin[2] + 40);
        _id_0020BF5B24840CC8 = spawnsighttrace(_id_41B91FD2101F153A, _id_EF251C63729784BD, _id_42DE6DFE2AC25CE5);

        if(!_id_0020BF5B24840CC8) {
          _id_41B91FD2101F153A notify("plz_spawn");
          break;
        }
      }
    } else {
      _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
      _id_1B35250984372909 = scripts\engine\utility::getclosest(level.player.origin, _id_29D9D2428185616D);
      _id_F1DEDCCA27836AD7 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", _id_1B35250984372909.origin, _id_1B35250984372909.angles);

      while(!isDefined(_id_F1DEDCCA27836AD7))
        wait 0.05;

      level.enemies[level.enemies.size] = _id_F1DEDCCA27836AD7;
      _id_F1DEDCCA27836AD7 thread enemy_monitor_death(level.enemyteam);
      _id_F1DEDCCA27836AD7 thread enemy_soldier_think();
      _id_F1DEDCCA27836AD7 thread enemy_rushdown_player();
    }

    wait 0.05;
  }
}

enemy_failsafe_ifonedidntspawn() {
  level endon("trial_completed");
  level scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    _id_B54587CB5545B935 = _func_D501623AFE0C5749();

    if(_id_B54587CB5545B935 == level.agentarray.size) {
      wait 0.5;

      if(level.enemieskilled + level.enemyspawners.size + level.enemies.size < level.enemiestotal) {
        _id_F1DEDCCA27836AD7 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", (0, 0, 80), (0, 0, 0));

        while(!isDefined(_id_F1DEDCCA27836AD7))
          wait 0.05;

        level.enemies[level.enemies.size] = _id_F1DEDCCA27836AD7;
        _id_F1DEDCCA27836AD7 thread enemy_monitor_death(level.enemyteam);
        _id_F1DEDCCA27836AD7 thread enemy_soldier_think();
        _id_F1DEDCCA27836AD7 thread enemy_rushdown_player();
      }
    }

    wait 0.5;
  }
}

enemies_validate_life() {
  for(;;) {
    foreach(enemy in level.enemies) {
      if(!isalive(enemy))
        level.enemies = scripts\engine\utility::array_remove(level.enemies, enemy);
    }

    wait 0.25;
  }
}

enemy_rushdown_player() {
  while(isalive(self)) {
    self setgoalentity(level.player);
    self agentsetfavoriteenemy(level.player);
    wait 2.5;
  }
}

return_enemyspawners_in_zones(_id_C85C96521B9FA174) {
  zones = [];

  foreach(trigger in _id_C85C96521B9FA174) {
    foreach(spawner in level.enemyspawners) {
      _id_62E00765011018C2 = spawn("script_origin", spawner.origin);

      if(_id_62E00765011018C2 istouching(trigger))
        zones = scripts\engine\utility::array_add(zones, spawner);

      _id_62E00765011018C2 delete();
    }
  }

  return zones;
}

enemy_move_and_cover(agent) {
  agent endon("death");
  agent agentsetfavoriteenemy(level.player);
  spawner = self;
  nodes = getnodearray(spawner.target, "targetname");

  if(nodes.size == 0) {
    origins = getEntArray(spawner.target, "targetname");

    if(origins.size > 0) {
      goalent = origins[randomint(origins.size)];
      agent setgoalpos(goalent.origin);

      if(isDefined(self.script_speed) && self.script_speed == -1) {
        return;
      }
      if(isDefined(self.speed) && self.speed == -1) {
        return;
      }
      node = scripts\engine\utility::getclosest(goalent.origin, level.allnodes, 500);
      nodes[0] = node;
    } else
      nodes[0] = scripts\engine\utility::getclosest(agent.origin, level.allnodes, 1000);
  }

  _id_CADD946C5C39FBF7 = nodes[randomint(nodes.size)];
  _id_2130724EB75B3892 = 1;
  _id_1C1B2C03F59628CD = 1;

  while(isalive(agent)) {
    if(isDefined(_id_CADD946C5C39FBF7)) {
      agent setgoalnode(_id_CADD946C5C39FBF7);
      agent scripts\engine\utility::waittill_any_4("goal", "badpath", "grenade danger", "bullet_whizby");
      _id_1C1B2C03F59628CD = _id_CADD946C5C39FBF7 is_cover_node();
    }

    if(isDefined(_id_CADD946C5C39FBF7))
      _id_CE8AE29090B55BCD = agent enemy_already_near_node(_id_CADD946C5C39FBF7);
    else
      _id_CE8AE29090B55BCD = 0;

    _id_C5557E1351AA6E37 = agent enemy_validate_node_proximity(_id_CADD946C5C39FBF7);

    if(_id_2130724EB75B3892 && _id_C5557E1351AA6E37 && !_id_CE8AE29090B55BCD) {
      wait 5;
      _id_F9EAC2714EE33D66 = agent _meth_DC83DAA4D1EB7A5F(_id_CADD946C5C39FBF7);

      for(_id_C5557E1351AA6E37 = agent enemy_validate_node_proximity(_id_CADD946C5C39FBF7); _id_F9EAC2714EE33D66 && _id_C5557E1351AA6E37; _id_F9EAC2714EE33D66 = agent _meth_DC83DAA4D1EB7A5F(_id_CADD946C5C39FBF7))
        wait 1;
    }

    _id_D76B59299A263FE5 = agent _meth_C875728711D621DF(1);
    _id_80BF6212193E8983 = [];
    _id_80BF6212193E8983[0] = _id_CADD946C5C39FBF7;
    _id_BCB418497D44610B = scripts\engine\utility::get_array_of_closest(agent.origin, _id_D76B59299A263FE5, _id_80BF6212193E8983, 1400, 0);

    foreach(node in _id_BCB418497D44610B) {
      _id_CE8AE29090B55BCD = agent enemy_already_near_node(node);

      if(_id_CE8AE29090B55BCD == 0)
        scripts\engine\utility::array_remove(_id_BCB418497D44610B, node);
    }

    if(_id_BCB418497D44610B.size > 0) {
      _id_CADD946C5C39FBF7 = scripts\engine\utility::random(_id_BCB418497D44610B);
      _id_2130724EB75B3892 = _id_CADD946C5C39FBF7 is_cover_node();
      continue;
    }

    nodes = getnodesinradius(agent.origin, 512, 100, 100);
    _id_CADD946C5C39FBF7 = nodes[randomint(nodes.size)];
    _id_2130724EB75B3892 = _id_CADD946C5C39FBF7 is_cover_node();
    currentnode = agent getnearestnode();
    path = agent findpath(currentnode.origin, _id_CADD946C5C39FBF7.origin, 0, 1);

    if(path.size == 0 && _id_1C1B2C03F59628CD) {
      _id_CADD946C5C39FBF7 = currentnode;
      _id_2130724EB75B3892 = _id_CADD946C5C39FBF7 is_cover_node();
    } else if(path.size > 14) {
      nodes = getnodearray(spawner.target, "targetname");
      _id_CADD946C5C39FBF7 = nodes[randomint(nodes.size)];
      _id_2130724EB75B3892 = _id_CADD946C5C39FBF7 is_cover_node();
    }
  }
}

enemy_validate_node_proximity(node) {
  range = self.goalradius;
  dist = distance(node.origin, self.origin);
  return dist < range;
}

is_cover_node() {
  return scripts\engine\utility::string_starts_with(self.type, "cover");
}

enemy_already_near_node(node) {
  _id_CE8AE29090B55BCD = 0;
  _id_CA71F76D55C9E987 = scripts\engine\utility::array_remove(level.enemies, self);
  _id_8F42EE0350D4B14C = sortbydistance(_id_CA71F76D55C9E987, node.origin);

  if(isDefined(_id_8F42EE0350D4B14C[0]) && distance(_id_8F42EE0350D4B14C[0].origin, node.origin) < 50)
    _id_CE8AE29090B55BCD = 1;

  return _id_CE8AE29090B55BCD;
}

enemy_soldier_think() {
  level endon("trial_completed");
  self enabletraversals(0);
  self allowedstances("stand", "crouch");
  self.goalradius = 64;
  self.grenadeammo = 0;
  self.baseaccuracy = 0.3;
  self agentsetfavoriteenemy(level.player);
  thread scripts\engine\utility::set_movement_speed(200);
  self._id_98ADD129A7ECB962 = 0;
  thread enemy_accuracy_think();
  _id_556D0DA2E440827B = 0;

  while(isalive(self)) {
    wait 0.05;
    self waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    scripts\engine\utility::array_contains(level.players, attacker);
    _id_D13380BB17A918C0 = level.player getcurrentweapon();

    if(_id_D13380BB17A918C0.basename == "iw8_knife_mp") {
      self kill();
      _id_B3990D56E2779F79 = 1;
    } else
      _id_B3990D56E2779F79 = 0;

    level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, _id_B3990D56E2779F79, 0, 1);

    if(gettime() - _id_556D0DA2E440827B > 800) {
      self playSound("trial_sfx_enemy_pain");
      _id_556D0DA2E440827B = gettime();
    }
  }
}

enemy_accuracy_think() {
  self endon("death");

  while(isalive(self)) {
    dist = distance(self.origin, level.player.origin);

    if(dist < 250)
      self.baseaccuracy = 0.8;
    else if(dist < 500)
      self.baseaccuracy = 0.5;
    else
      self.baseaccuracy = 0.3;

    wait 0.25;
  }
}

enemy_monitor_death(team) {
  level endon("trial_completed");

  switch (self.primaryweapon.classname) {
    case "rifle":
      _id_84D2C31F492DEAE4 = "laserrange_bar";
      break;
    case "mg":
      _id_84D2C31F492DEAE4 = "laserrange_bar";
      break;
    case "smg":
      _id_84D2C31F492DEAE4 = "laserirsmg";
      break;
    default:
      _id_84D2C31F492DEAE4 = "";
  }

  if(isDefined(level.nightmap) && level.nightmap == 1)
    _id_2A7DBCFD845F7765 = "+" + _id_84D2C31F492DEAE4;
  else
    _id_2A7DBCFD845F7765 = "";

  weaponname = getcompleteweaponname(self.weapon) + _id_2A7DBCFD845F7765;
  _id_E42C947DBEB4C361 = self gettagorigin("tag_weapon_right");
  _id_C0EC6175A0F3FE1B = self gettagorigin("tag_weapon_right");
  _id_AC46F3819F6AC41D = spawn("script_origin", _id_E42C947DBEB4C361);
  _id_AC46F3819F6AC41D.angles = _id_C0EC6175A0F3FE1B;
  _id_AC46F3819F6AC41D linkTo(self, "tag_weapon_right");

  if(isalive(self)) {
    self waittill("death", _id_B4656BFA88D54617, attacker, cause, objweapon, meansofdeath);

    if(isalive(level.player))
      _id_B4656BFA88D54617 = scripts\engine\utility::array_contains(level.players, attacker);
    else
      _id_B4656BFA88D54617 = 0;
  } else
    _id_B4656BFA88D54617 = 0;

  _id_B92583B50E132AAD = team == level.enemyteam;

  if(_id_B92583B50E132AAD && _id_B4656BFA88D54617) {
    self playSound("trial_sfx_enemy_death");
    level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 1);
  }

  level notify("enemy_killed");
  level.enemieskilled++;
  level.enemiesactivenb--;
  level.enemies = scripts\engine\utility::array_removedead(level.enemies);

  if(istrue(level.trial_enemy_dont_drop_weapon)) {
    _id_AC46F3819F6AC41D delete();
    return;
  }

  weapon = spawn("weapon_" + weaponname, _id_AC46F3819F6AC41D.origin);
  weapon.angles = _id_AC46F3819F6AC41D.angles;
  _id_2747B42F992B3B8A = int(weaponclipsize(weapon) / 1);
  _id_58617170A6620E04 = int(weaponclipsize(weapon) / 3);

  if(_id_58617170A6620E04 == 0)
    _id_58617170A6620E04 = 1;

  weapon itemweaponsetammo(randomintrange(_id_58617170A6620E04, _id_2747B42F992B3B8A), 0);
  _id_AC46F3819F6AC41D delete();
}

enemy_chatter() {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.player endon("death");
  _id_261C2C4FFED5ADC1 = 2;
  _id_263F1E4FFEFBD6AF = 5;
  _id_7394DA87BE62D61C = 1;
  _id_7371C887BE3C66CE = 4;
  _id_1144DB13FE5E93CF = 1;
  _id_1121C913FE382481 = 3;
  level scripts\engine\utility::flag_wait("trial_starting");

  while(level.enemiesactivenb == 0)
    wait 0.05;

  for(;;) {
    _id_CE65D0038EBE24F8 = level.enemieskilled / level.enemiestotal;

    if(_id_CE65D0038EBE24F8 < 0.29) {
      status = "calm";
      _id_D2F6E42E0526BDD3 = _id_261C2C4FFED5ADC1;
      _id_D319FA2E054D35ED = _id_263F1E4FFEFBD6AF;
    } else if(_id_CE65D0038EBE24F8 < 0.79) {
      status = "aware";
      _id_D2F6E42E0526BDD3 = _id_7394DA87BE62D61C;
      _id_D319FA2E054D35ED = _id_7371C887BE3C66CE;
    } else {
      status = "panic";
      _id_D2F6E42E0526BDD3 = _id_1144DB13FE5E93CF;
      _id_D319FA2E054D35ED = _id_1121C913FE382481;
    }

    wait(randomfloatrange(_id_D2F6E42E0526BDD3, _id_D319FA2E054D35ED));
    _id_D4A6E517828E4764 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.enemies, undefined, 10, 1000);

    if(_id_D4A6E517828E4764.size > 0)
      _id_03127294B48A0B9D = scripts\engine\utility::random_weight_sorted(_id_D4A6E517828E4764);
    else
      _id_03127294B48A0B9D = scripts\engine\utility::getclosest(level.player.origin, level.enemies, 2500);

    if(isDefined(_id_03127294B48A0B9D) && isalive(_id_03127294B48A0B9D)) {
      _id_EF251C63729784BD = level.player gettagorigin("tag_eye");
      _id_9E1134A991C3B7E4 = spawnsighttrace(_id_03127294B48A0B9D, _id_EF251C63729784BD, _id_03127294B48A0B9D.origin);

      if(_id_9E1134A991C3B7E4)
        sound = "trial_sfx_enemy_radio";
      else
        sound = "trial_sfx_enemy_chatter";

      _id_03127294B48A0B9D playsoundonmovingent(sound);
      _id_141ECBC2D616AE5C = lookupsoundlength(sound) / 1000;

      if(isDefined(_id_141ECBC2D616AE5C) && _id_141ECBC2D616AE5C > 0)
        wait(_id_141ECBC2D616AE5C);
      else
        wait 4;
    }

    if(scripts\engine\utility::flag("trial_completed"))
      return;
  }
}

createscript_covernodes() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  origins = getEntArray("script_model", "classname");

  foreach(_id_F7806D4CF24AACD3 in origins) {
    if(_id_F7806D4CF24AACD3.model == "highway_flag0" && isDefined(_id_F7806D4CF24AACD3.script_noteworthy)) {
      switch (_id_F7806D4CF24AACD3.script_noteworthy) {
        case "Exposed":
          nodetype = "Exposed";
          break;
        case "CoverLeft":
          nodetype = "Cover Left";
          break;
        case "CoverRight":
          nodetype = "Cover Right";
          break;
        case "CoverCrouch":
          nodetype = "Cover Crouch";
          break;
        case "CoverStand":
          nodetype = "Cover Stand";
          break;
        case "CoverProne":
          nodetype = "Cover Prone";
          break;
        default:
          nodetype = undefined;
          break;
      }

      if(isDefined(nodetype)) {
        _id_F7806D4CF24AACD3 setModel("tag_origin");
        _id_F7806D4CF24AACD3 thread spawn_additional_covernode(nodetype);
      }
    }
  }
}

spawn_additional_covernode(nodetype) {
  level endon("trial_completed");
  _id_0C84F6220E6636C5 = spawncovernode(self.origin, self.angles, nodetype, 16, self.targetname);

  while(!isDefined(_id_0C84F6220E6636C5))
    waitframe();

  if(isDefined(self.radius))
    _id_0C84F6220E6636C5.radius = self.radius;
  else
    _id_0C84F6220E6636C5.radius = 24;
}

hud_init() {
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(game["trial"]["best_reward"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.player setclientomnvar("ui_match_in_progress", 1);
}

hud_objectives() {
  scripts\mp\trials\trial_utility::trial_ui_set_objective_icon_index(0);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);

  while(!isDefined(level.player))
    wait 0.05;

  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\engine\utility::flag_wait("trial_countdown");

  while(level.enemieskilled < level.enemiestotal) {
    scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
    wait 0.05;
  }

  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  level notify("stop_timer");
  level scripts\engine\utility::flag_set("trial_completed");
}

hud_timer() {
  level endon("max_time_limit_reached");
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
  level scripts\engine\utility::flag_wait("trial_starting");
  level.player playSound("trial_sfx_start");
  starttime = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    time = gettime() - starttime;
    level.totaltimeelapsed = int(time);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.totaltimeelapsed);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.totaltimeelapsed);
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    time = gettime() - starttime;
    level.totaltimeelapsed = int(time);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.totaltimeelapsed);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.totaltimeelapsed);

    if(game["trial"]["best_time"] <= 0 || time < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = time;
      hud_besttime_update();
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
    }
  } else {
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
  }

  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
}

hud_reward_tiers_tracking() {
  self endon("stop_timer");
  self waittill("trial_starting");
  _id_72408207126E9282 = [];
  _id_72408207126E9282[0] = undefined;
  _id_72408207126E9282[1] = level.trial["tier1"];
  _id_72408207126E9282[2] = level.trial["tier2"];
  _id_72408207126E9282[3] = level.trial["tier3"];

  for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    level.attempttier = _id_AC0E594AC96AA3A8;
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(_id_AC0E594AC96AA3A8);

    if(isDefined(_id_72408207126E9282[_id_AC0E594AC96AA3A8])) {
      while(level.totaltimeelapsed < _id_72408207126E9282[_id_AC0E594AC96AA3A8] - 5000)
        wait 0.05;

      for(t = 5; t > 0; t--) {
        level.player playSound("trial_sfx_failure_countdown");
        wait 1;
      }

      level.player playSound("trial_sfx_failure");
    }
  }

  while(level.totaltimeelapsed < level.maxtimelimit)
    wait 0.05;

  level notify("max_time_limit_reached");
  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.maxtimelimit);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.maxtimelimit);
}

hud_attempt_over() {
  level scripts\engine\utility::flag_wait("trial_completed");
  setDvar("scr_death_scene_time", 1.75);
  level.player freezecontrols(1);

  if(!scripts\engine\utility::flag("trial_player_death")) {
    _id_A691794C4E79B4C4 = game["trial"]["best_reward"];

    if(level.attempttier > _id_A691794C4E79B4C4) {
      game["trial"]["best_reward"] = level.attempttier;
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(level.attempttier);
    }

    if(level.attempttier >= 2) {
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    } else if(level.attempttier >= 1) {
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
    } else {
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
    level.player clearsoundsubmix("deaths_door_mp");
    level.player playSound("trial_sfx_failure");
    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    setomnvar("ui_trial_failed", 1);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 1);
    wait 1;
  }

  scripts\engine\utility::array_call(level.enemies, ::despawnagent);
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  level scripts\engine\utility::flag_wait("trial_ready_for_endscreen");
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  level.trial_restarting = 1;
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  _id_467003532BDC5C8A = game["trial"]["tries_remaining"];

  if(_id_467003532BDC5C8A > 0) {
    level notify("game_cleanup");
    level notify("restarting");
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

starting_trigger_fix() {
  _id_261D5FDEE9F7C760 = getEnt("starting_trigger", "targetname");
  _id_261D5FDEE9F7C760 waittill("trigger");
  level scripts\engine\utility::flag_set("trial_start_zone_entered");
}

check_script_noteworthy(_id_12B64F53558A1C92, _id_12B64E53558A1A5F) {
  _id_FE8F3003F630A2AF = int(_id_12B64F53558A1C92.script_noteworthy);
  _id_FE8F3103F630A4E2 = int(_id_12B64E53558A1A5F.script_noteworthy);
  return _id_FE8F3003F630A2AF < _id_FE8F3103F630A4E2;
}

dialog_init() {
  game["dialog"]["trial_intro"] = "kh_clear_intro";
  game["dialog"]["trial_intro_short"] = "kh_clear_intro_short";
  game["dialog"]["trial_end_tier_0"] = "kh_clear_star0_fail";
  game["dialog"]["trial_end_tier_0_alt"] = "kh_clear_star0_death";
  game["dialog"]["trial_end_tier_1"] = "kh_clear_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_clear_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_clear_star3";
  game["dialog"]["trial_retry"] = "kh_clear_retry";
  game["dialog"]["clear_start"] = "kh_clear_start";
  game["dialog"]["clear_search"] = "kh_clear_search";
  game["dialog"]["clear_good_kill"] = "kh_clear_goodkill";
  thread dialog_killstreak_acknowledgement();
  thread dialog_push_forward();
  scripts\engine\utility::flag_wait("trial_starting");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_start");
}

dialog_push_forward() {
  level endon("trial_completed");
  _id_AC0E594AC96AA3A8 = 0;
  _id_2FF1800EF77605AA = 0;
  scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    wait 1;
    _id_25509B00C1324512 = level.enemieskilled != _id_2FF1800EF77605AA;

    if(_id_25509B00C1324512 == 0 && level.enemies.size > 0) {
      _id_8F42EE0350D4B14C = sortbydistance(level.enemies, level.player.origin);

      if(distance2d(_id_8F42EE0350D4B14C[0].origin, level.player.origin) > 900)
        _id_AC0E594AC96AA3A8++;
    } else {
      _id_AC0E594AC96AA3A8 = 0;
      _id_2FF1800EF77605AA = level.enemieskilled;
    }

    if(_id_AC0E594AC96AA3A8 > 4) {
      _id_AC0E594AC96AA3A8 = 0;
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_search");
      wait 5;
    }
  }
}

dialog_killstreak_acknowledgement() {
  _id_153FDEE861E0F06F = 0;
  lastkilltime = 0;
  cooldowntime = 0;
  _id_D2D3E5CD5D40CB75 = 8000;
  level waittill("enemy_killed");
  _id_153FDEE861E0F06F++;
  lastkilltime = gettime();

  for(;;) {
    level waittill("enemy_killed");
    time = gettime();
    _id_4573A8725DD3748E = time - lastkilltime;

    if(_id_4573A8725DD3748E < 2600) {
      if(_id_153FDEE861E0F06F < 3)
        _id_153FDEE861E0F06F++;
    } else if(_id_4573A8725DD3748E < 4000) {} else if(_id_153FDEE861E0F06F > 0)
      _id_153FDEE861E0F06F--;

    if(_id_153FDEE861E0F06F > 2 && time > cooldowntime) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_good_kill");
      cooldowntime = time + _id_D2D3E5CD5D40CB75;
      _id_153FDEE861E0F06F = _id_153FDEE861E0F06F - 2;
    }

    lastkilltime = time;
  }
}

recharge_equipment_init() {
  for(;;) {
    while(isalive(level.player)) {
      recharge_equipment_update_state(level.player);
      wait 0.2;
    }

    waitframe();
  }
}

recharge_equipment_update_slot(player, slot) {
  state = player.rechargeequipmentstate;

  if(!isDefined(state.progress[slot]))
    state.progress[slot] = 0;

  state.recharged[slot] = undefined;
  equipment = player scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(equipment)) {
    return;
  }
  ammo = player scripts\mp\equipment::getequipmentammo(equipment);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipment);
  startammo = player scripts\mp\equipment::getequipmentstartammo(equipment);

  if(ammo < ammomax)
    state.progress[slot] = state.progress[slot] + 0.025;
  else
    state.progress[slot] = 0;

  if(state.progress[slot] >= 1) {
    player scripts\mp\equipment::incrementequipmentslotammo(slot, 1);
    state.progress[slot] = 0;
    state.recharged[slot] = 1;
  }
}

recharge_equipment_update_state(player) {
  if(!isDefined(player.rechargeequipmentstate)) {
    player.rechargeequipmentstate = spawnStruct();
    player.rechargeequipmentstate.progress = [];
    player.rechargeequipmentstate.recharged = [];
  }

  recharge_equipment_update_slot(player, "primary");
  recharge_equipment_update_slot(player, "secondary");
  recharge_equipment_update_ui(player);
}

recharge_equipment_update_ui(player) {
  _id_EA6C6F327A8C9B68 = 0;
  _id_A26D8AB03F8D1BCB = 0;
  _id_7732B71EB53C0AF1 = -1;

  if(isDefined(player) && isDefined(player.rechargeequipmentstate)) {
    player scripts\mp\utility\stats::initpersstat("restockCount");
    state = player.rechargeequipmentstate;

    if(isDefined(state.progress["primary"]))
      _id_EA6C6F327A8C9B68 = state.progress["primary"];

    if(isDefined(state.progress["secondary"]))
      _id_A26D8AB03F8D1BCB = state.progress["secondary"];

    foreach(slot, _ in state.recharged) {
      if(slot == "primary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 1;
        player playlocalsound("ui_restock_lethals");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(slot == "secondary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 2;
        player playlocalsound("ui_restock_tactical");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  player setclientomnvar("ui_lethal_recharge_progress", _id_EA6C6F327A8C9B68);
  player setclientomnvar("ui_tactical_recharge_progress", _id_A26D8AB03F8D1BCB);
  player setclientomnvar("ui_recharge_notify", _id_7732B71EB53C0AF1);
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_clear;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["weapon1"] = "DNF";
    game["trial"]["analytics"]["weapon2"] = "DNF";
  }
}

trial_dlog_clear() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  time = getomnvar("ui_trial_best_time");
  _id_A7756ABFED842C14 = "" + game["trial"]["analytics"]["weapon1"];
  _id_A7756DBFED8432AD = "" + game["trial"]["analytics"]["weapon2"];
  level.player dlog_recordplayerevent("dlog_event_trial_complete_clear", ["id", id, "tier", tier, "time", time, "weapon1", _id_A7756ABFED842C14, "weapon2", _id_A7756DBFED8432AD]);
}

barrel_think() {
  _id_80F58BC9C9180A95 = getentarrayinradius("barrel_col", "targetname", self.origin, 250);
  self disconnectPaths();
  self setCanDamage(1);
  self waittill("damage", damage, attacker, direction_vec, point, meansofdeath);

  if(meansofdeath == "MOD_EXPLOSIVE")
    wait 0.15;

  self radiusdamage(self.origin, 250, 250, 100, level.player, "MOD_EXPLOSIVE");

  if(isDefined(self.script_noteworthy) && !istrue(level.started)) {
    if(self.script_noteworthy == "big_explosion") {
      level notify("nuked");
      level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
      _id_D7EA0C53E00A2519 = 6;
      _id_FC0FFDF77AEEC040 = 0.1;
      nukegoalpoint = (1645.5, -21164, -2543.5);
      _id_FFBE59C9DB09BD91 = vectorNormalize((nukegoalpoint[0], nukegoalpoint[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
      _id_FFB179778403BED7 = nukegoalpoint + _id_FFBE59C9DB09BD91 * 15000;
      _id_FFB179778403BED7 = _id_FFB179778403BED7 + (0, 0, 30000) + _id_FFBE59C9DB09BD91 * 5000;
      streakinfo = spawnStruct();
      streakinfo.streakname = "trial_nuke";
      streakinfo.nukegoalpoint = nukegoalpoint;
      level.nuke_clockobject = spawn("script_origin", _id_FFB179778403BED7 + (0, 0, 100));
      playsoundatpos(_id_FFB179778403BED7, "iw8_nuke_dist_launch");
      level thread nuke_launchmissile(undefined, undefined, (1645.5, -21164, -2543.5), nukegoalpoint, _id_FC0FFDF77AEEC040);
      wait(_id_FC0FFDF77AEEC040);
      level thread scripts\cp_mp\killstreaks\nuke::setnuketimescalefactor();
      level thread scripts\cp_mp\killstreaks\nuke::nuke_explosion(undefined, streakinfo);
      level thread scripts\cp_mp\killstreaks\nuke::nuke_earthquake(undefined, streakinfo);
      visionsetnaked("nuke_global_flash", 0.05);
      setDvar("r_materialbloomhqscriptmasterenable", 0);
      wait 0.5;
      level thread scripts\cp_mp\killstreaks\nuke::nuke_fadeflashvision(1, 2);
      wait 3.5;
      playFX(scripts\engine\utility::getfx("nuke_rolling_death"), level.player.origin - (0, 0, 64), anglesToForward(self.angles) * -1, undefined, level.player);
      wait 1;
      scripts\cp_mp\killstreaks\nuke::_id_E6E629829270E1FA();
      wait 2;
      map_restart(1);
    }
  } else
    playFX(scripts\engine\utility::getfx(random_barrel_explosion()), self.origin);

  foreach(col in _id_80F58BC9C9180A95) {
    if(isDefined(col))
      col delete();
  }

  playsoundatpos(self.origin, "dst_propane_expl_atmo");
  level.player earthquakeforplayer(0.15, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("barrel_flame_small"), self.origin);
  playFX(scripts\engine\utility::getfx("barrel_fire"), self.origin);
  self hide();
  wait 5;
  self delete();
}

nuke_launchmissile(owner, streakinfo, _id_3EB0E5F5F61F0A10, _id_45292519459D6838, _id_42F65B4B53C1F5D4, weaponoverride) {
  level endon("game_ended");
  _id_05C06CA9338F3C12 = _id_42F65B4B53C1F5D4;
  _id_C9D3F58C83D60D18 = "nuke_mp";

  if(isDefined(weaponoverride))
    _id_C9D3F58C83D60D18 = weaponoverride;

  _id_A780020E8099CAB2 = (0, 0, -1 * getdvarint("bg_gravity", 800));
  _id_10AFA5659C39462F = (_id_45292519459D6838 - 0.5 * _id_A780020E8099CAB2 * squared(_id_42F65B4B53C1F5D4) - _id_3EB0E5F5F61F0A10) / _id_42F65B4B53C1F5D4;
  level.nuke_missile = magicgrenademanual(_id_C9D3F58C83D60D18, _id_3EB0E5F5F61F0A10, _id_10AFA5659C39462F, _id_42F65B4B53C1F5D4);
  level.nuke_missile setscriptablepartstate("launch", "on", 0);
}

random_barrel_explosion() {
  _id_00AE14C5A8B1B582 = randomint(2);

  switch (_id_00AE14C5A8B1B582) {
    case 0:
      return "barrel_explosion1";
    case 1:
      return "barrel_explosion2";
    case 2:
      return "vehicle_explosion";
  }
}

destructable_car() {
  self disconnectPaths();
  nodes = getnodesinradius(self.origin, 256, 0);

  foreach(node in nodes)
  node _meth_547AAB3C2787AC87();

  self setCanDamage(1);

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath);

    if(meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
      break;
    }

    waitframe();
  }

  self radiusdamage(self.origin, 250, 250, 10, level.player);
  playFX(scripts\engine\utility::getfx("vehicle_bomb_explosion"), self.origin);
  playsoundatpos(self.origin, "veh9_dmg_generic_explode");
  level.player earthquakeforplayer(0.45, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("vehicle_explosion2"), self.origin);
  playFX(scripts\engine\utility::getfx("vehicle_fire"), self.origin);
  self setModel("veh8_civ_lnd_hindia_static_dst");
  waitframe();
  self hidepart("TAG_DOOR_FRONT_LEFT", "veh8_civ_lnd_hindia_static_dst");
  self hidepart("TAG_DOOR_FRONT_RIGHT", "veh8_civ_lnd_hindia_static_dst");
}

ammo_crate_think() {
  self setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
  interact = spawn("script_model", self.origin);
  interact linkTo(self, "tag_origin", (0, 35, 44), (0, 0, 0));
  interact setModel("tag_origin");
  interact makeusable();
  interact setCursorHint("hint_button");
  interact setHintString(&"MP_INGAME_ONLY/REFILL_AMMO");
  interact sethintdisplayrange(200);
  interact sethintdisplayfov(120);
  interact setuserange(72);
  interact setusefov(120);
  interact sethintonobstruction("show");
  interact setuseholdduration("duration_short");
  interact.headicon = createheadicon(interact);
  setheadiconimage(interact.headicon, "cp_crate_icon_ammo");
  setheadiconnaturaldistance(interact.headicon, 800);
  setheadiconzoffset(interact.headicon, 5);
  interact waittill("trigger");
  weapons = level.player getweaponslistall();

  foreach(weapon in weapons)
  level.player setweaponammostock(weapon, weaponclipsize(weapon) * 2 + level.player getweaponammostock(weapon));

  level.player _id_5762AC2F22202BA2::hudicontype("br_ammo");
  level.player playlocalsound("iw9_support_box_use");
  interact makeunusable();
  hideheadiconfromplayersinmask(interact.headicon);
}