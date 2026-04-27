/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_cobrapilot.gsc
********************************************************/

#include maps\_utility;
#include maps\_helicopter_globals;
#include common_scripts\utility;
#using_animtree("vehicles");
init() {
  setDvarIfUninitialized("cobrapilot_unlimited_ammo", "0");

  setDvarIfUninitialized("cobrapilot_farp_mode", "0");

  setDvarIfUninitialized("cobrapilot_edge_of_world_type", "2");

  setDvarIfUninitialized("cobrapilot_gunner_enabled", "0");

  setDvarIfUninitialized("cobrapilot_wingman_enabled", "0");

  setDvar("cobrapilot_difficulty", "easy");

  setDvarIfUninitialized("cobrapilot_debug", "0");

  setDvarIfUninitialized("cobrapilot_sounds_enabled", "0");

  level.cobra_weapon_tags = [];
  level.cobra_weapon_tags["cobra_20mm"][0] = "tag_minigun_attach_left";
  level.cobra_weapon_tags["cobra_20mm"][1] = "tag_minigun_attach_right";
  level.cobra_weapon_tags["cobra_FFAR"][0] = "tag_missile_left";
  level.cobra_weapon_tags["cobra_FFAR"][1] = "tag_missile_right";
  level.cobra_weapon_tags["cobra_Hellfire"][0] = "tag_missile_left";
  level.cobra_weapon_tags["cobra_Hellfire"][1] = "tag_missile_right";
  level.cobra_weapon_tags["cobra_Sidewinder"][0] = "tag_missile_left";
  level.cobra_weapon_tags["cobra_Sidewinder"][1] = "tag_missile_right";

  level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
  level.cobra_missile_models["cobra_Sidewinder"] = "projectile_sidewinder_missile";

  weapon = weaponsSystems_Create_Weapon();
  weapon.v["weapon"] = "cobra_20mm";

  weapon.v["realWeaponName"] = &"COBRAPILOT_20MM";
  weapon.v["weaponNameLocationX"] = 573;
  weapon.v["weaponNameLocationY"] = 149;
  weapon.v["equipButton"] = "BUTTON_A";
  weapon.v["equipShader"] = "cobra_controls_a";
  weapon.v["singleShot"] = false;
  weapon.v["targetType"] = "dummy";
  weapon.v["requireLock"] = false;
  weapon.v["maxAmmo"] = 750;
  weapon.v["ammoPickupIncrement"] = 50;
  weapon.v["tags"] = level.cobra_weapon_tags["cobra_20mm"];
  weaponsSystems_Add_Weapon(weapon);

  weapon = weaponsSystems_Create_Weapon();
  weapon.v["weapon"] = "cobra_FFAR";

  weapon.v["realWeaponName"] = &"COBRAPILOT_FFAR";
  weapon.v["weaponNameLocationX"] = 573;
  weapon.v["weaponNameLocationY"] = 167;
  weapon.v["equipButton"] = "BUTTON_B";
  weapon.v["equipShader"] = "cobra_controls_b";
  weapon.v["singleShot"] = false;
  weapon.v["targetType"] = "dummy";
  weapon.v["requireLock"] = false;
  weapon.v["maxAmmo"] = 38;
  weapon.v["ammoPickupIncrement"] = 4;
  weapon.v["tags"] = level.cobra_weapon_tags["cobra_FFAR"];
  weaponsSystems_Add_Weapon(weapon);

  weapon = weaponsSystems_Create_Weapon();
  weapon.v["weapon"] = "cobra_Hellfire";

  weapon.v["realWeaponName"] = &"COBRAPILOT_HELLFIRE";
  weapon.v["weaponNameLocationX"] = 573;
  weapon.v["weaponNameLocationY"] = 185;
  weapon.v["equipButton"] = "BUTTON_X";
  weapon.v["equipShader"] = "cobra_controls_x";
  weapon.v["hudShader"] = "veh_hud_hellfire";
  weapon.v["hudShader_size_x"] = 200;
  weapon.v["hudShader_size_y"] = 200;
  weapon.v["singleShot"] = true;
  weapon.v["targetType"] = "ground";
  weapon.v["requireLock"] = true;
  weapon.v["lockonTime"] = 1500;
  weapon.v["maxAmmo"] = 8;
  weapon.v["ammoPickupIncrement"] = 1;
  weapon.v["tags"] = level.cobra_weapon_tags["cobra_Hellfire"];
  weaponsSystems_Add_Weapon(weapon);

  weapon = weaponsSystems_Create_Weapon();
  weapon.v["weapon"] = "cobra_Sidewinder";

  weapon.v["realWeaponName"] = &"COBRAPILOT_SIDEWINDER";
  weapon.v["sound_armed_loop"] = "weap_aim9_growl4";
  weapon.v["weaponNameLocationX"] = 573;
  weapon.v["weaponNameLocationY"] = 203;
  weapon.v["equipButton"] = "BUTTON_Y";
  weapon.v["equipShader"] = "cobra_controls_y";
  weapon.v["hudShader"] = "veh_hud_sidewinder";
  weapon.v["hudShader_size_x"] = 200;
  weapon.v["hudShader_size_y"] = 200;
  weapon.v["singleShot"] = true;
  weapon.v["targetType"] = "air";
  weapon.v["requireLock"] = true;
  weapon.v["lockonTime"] = 3000;
  weapon.v["maxAmmo"] = 2;
  weapon.v["ammoPickupIncrement"] = 1;
  weapon.v["ammoPickupDelay_Min"] = 1.0;
  weapon.v["ammoPickupDelay_Max"] = 2.0;
  weapon.v["tags"] = level.cobra_weapon_tags["cobra_Sidewinder"];
  weaponsSystems_Add_Weapon(weapon);

  precacheString(&"COBRAPILOT_EDGE_OF_WORLD_WARNING");

  precacheString(&"COBRAPILOT_EDGE_OF_WORLD_FAIL");

  precacheString(&"COBRAPILOT_NO_AMMO");

  precacheString(&"COBRAPILOT_NO_LOCK");

  precacheString(&"COBRAPILOT_OBJECTIVE_AMMO_RELOAD_POINT");

  level.vehicleSpawnCallbackThread = ::vehicle_Spawn_Callback_Thread;

  level.cobraHealth = [];
  level.cobraHealth["easy"] = 9000;
  level.cobraHealth["medium"] = 7000;
  level.cobraHealth["hard"] = 3000;
  level.cobraHealth["insane"] = 1500;

  level.flareButton1 = "BUTTON_LSHLDR";
  level.flareButton2 = "BUTTON_RSHLDR";

  level.stats = [];
  level.stats["enemies_killed"] = 0;
  level.stats["damage_taken"] = 0;
  level.stats["cobra_20mm"] = 0;
  level.stats["cobra_FFAR"] = 0;
  level.stats["cobra_Hellfire"] = 0;
  level.stats["cobra_Sidewinder"] = 0;
  level.stats["flares_used"] = 0;

  level.cosine = [];
  level.cosine["45"] = cos(45);
  level.cosine["55"] = cos(55);

  level.GunnerTargetRange = 16000;
  level.GunnerTargetFOV = level.cosine["55"];
  level.GunnerWeapon = "cobra_20mm_copilot";
  level.GunnerWeaponPlayerEquiv = "cobra_20mm";
  precacheItem(level.GunnerWeapon);

  level.flare_fx = [];
  level.flare_fx["cobra"] = loadfx("misc/flares_cobra");
  level.flare_fx["cobra_player"] = loadfx("misc/flares_cobra");
  level.flare_fx["hind"] = loadfx("misc/flares_cobra");

  level.player_death_fx = loadfx("explosions/cobrapilot_vehicle_explosion");

  level.initialFOV = 65;
  level.weaponZoomFOV = 35;

  precacheShader("compass_waypoint_farp");
  precacheShader("cobra_health");

  precacheModel("body_complete_sp_cobra_pilot_desert_zack");

  level.missileHintIndicator_Missile = "veh_hud_missile";
  level.missileHintIndicator_Missile_Flash = "veh_hud_missile_flash";
  level.missileHintIndicator_Missile_Offscreen = "veh_hud_missile_offscreen";
  level.missileHintIndicator_Arrow = [];
  level.missileHintIndicator_Arrow["left"] = "veh_hud_missile_arrow_left";
  level.missileHintIndicator_Arrow["right"] = "veh_hud_missile_arrow_right";
  level.missileHintIndicator_Arrow["forward"] = "veh_hud_missile_arrow_forward";
  level.missileHintIndicator_Arrow["back"] = "veh_hud_missile_arrow_back";
  precacheShader(level.missileHintIndicator_Missile);
  precacheShader(level.missileHintIndicator_Missile_Flash);
  precacheShader(level.missileHintIndicator_Missile_Offscreen);
  precacheShader(level.missileHintIndicator_Arrow["left"]);
  precacheShader(level.missileHintIndicator_Arrow["right"]);
  precacheShader(level.missileHintIndicator_Arrow["forward"]);
  precacheShader(level.missileHintIndicator_Arrow["back"]);

  level.cobrapilot_difficulty = getDvar("cobrapilot_difficulty");
  assert(isDefined(level.cobraHealth[level.cobrapilot_difficulty]));
  level.flyablecobra_starting_health = level.cobraHealth[level.cobrapilot_difficulty];
  level.flyablecobra_healthWarning_value = 1000;
  level.flyablecobra_healthRegenIncrement = int(level.flyablecobra_starting_health / 6);
  level.flyablecobra_healthRegenRate = 1.0;
  level.flyablecobra_healthLeakIncrement = 30;
  level.flyablecobra_healthLeakRate = 1.0;

  array_thread(getEntArray("cobra", "targetname"), ::setup_player_usable_vehicle);
  array_thread(getEntArray("flyable_heli", "targetname"), ::setup_player_usable_vehicle);
}

setup_player_usable_vehicle() {
  assert(isDefined(self));
  assert(isDefined(self.target));
  self.trigger = getent(self.target, "targetname");
  assert(isDefined(self.trigger));

  self.script_targetoffset_z = -100;

  self makeUnusable();

  self thread wait_player_enter();

  self notify("stop_kicking_up_dust");
}

wait_player_enter() {
  for(;;) {
    self.trigger waittill("trigger", pilot);
    if(pilot.classname == "player") {
      break;
    }
    wait 0.05;
  }

  level thread player_enter_chopper(self, pilot);
}

player_enter_chopper(chopper, pilot) {
  chopper useby(pilot);
  chopper setjitterparams((3, 3, 3), 0.5, 1.5);
  chopper.hudelems = spawnStruct();

  pilot.ignoreme = true;

  chopper.pilot = pilot;
  chopper.pilot.currentWeapon = 0;
  chopper.playercontrolled = true;

  thread player_becomes_pilot_model(chopper);
  chopper thread startRotors();
  chopper thread maps\_vehicle::aircraft_dust_kickup();

  chopper.gunner_use_turret = false;
  if(level.cobraWeapon[chopper.pilot.currentWeapon].v["weapon"] != level.GunnerWeaponPlayerEquiv)
    chopper.gunner_use_turret = true;

  if((isDefined(level.cobraWeapon)) && (level.cobraWeapon.size > 0))
    chopper setVehWeapon(level.cobraWeapon[chopper.pilot.currentWeapon].v["weapon"]);

  chopper notify("nodeath_thread");
  chopper notify("no_regen_health");
  chopper notify("stop_turret_shoot");
  chopper notify("stop_friendlyfire_shield");
  chopper notify("stop_vehicle_wait");

  chopper thread globalThink();
  chopper thread weaponsSystems();

  chopper.pilot freezeControls(true);
  chopper waittill("takeoff");
  chopper thread setChopperHealth();
  chopper setGoalYaw(chopper.angles[1]);
  chopper setVehGoalPos(chopper.origin + (0, 0, 40), 1);
  chopper waittill("goal");
  chopper returnPlayerControl();
  chopper.pilot freezeControls(false);
}

player_becomes_pilot_model(chopper) {
  if(chopper.vehicletype != "cobra_player") {
    return;
  }
  assert(isDefined(chopper.pilot));
  chopper.pilot hide();

  chopper.pilotModel = spawn("script_model", chopper getTagOrigin("tag_pilot"));
  chopper.pilotModel.angles = chopper getTagAngles("tag_pilot");
  chopper.pilotModel setModel("body_complete_sp_cobra_pilot_desert_zack");
  chopper.pilotModel linkto(chopper, "tag_pilot", (0, 0, -40), (0, 0, 0));
  chopper.pilotModel useAnimTree(#animtree);

  while(isDefined(chopper)) {
    chopper.pilotModel setFlaggedAnim("pilot_idle_anim", %cobra_copilot_idle);
    chopper.pilotModel waittillmatch("pilot_idle_anim", "end");
  }
}

startRotors() {
  self useAnimTree(#animtree);

  startUp = true;
  rate = 0.2;
  rate_inc = 0.2;
  rate_time = 0.2;

  while(isDefined(self)) {
    self setFlaggedAnim("rotor_anim", %bh_rotors, 1.0, 0.1, rate);
    if(startUp) {
      wait rate_time;
      rate += rate_inc;
      if(rate >= 4.0) {
        rate = 1.0;
        startUp = false;
        self notify("takeoff");
        if(self.vehicletype == "cobra_player")
          self setModel("vehicle_cobra_helicopter_fly");
      }
    } else
      self waittillmatch("rotor_anim", "end");
  }
}

setChopperHealth() {
  assert(isDefined(self.pilot));

  self.health = level.flyablecobra_starting_health;
  self.currenthealth = level.flyablecobra_starting_health;
  self.maxhealth = level.flyablecobra_starting_health;

  self health_indicator_create();
  self thread health_indicator_damageWait();
  self thread health_think();
}

vehicle_Spawn_Callback_Thread(vehicle) {
  vehicle thread globalThink();

  if(!isDefined(vehicle.script_cobratarget)) {
    return;
  }
  if(vehicle.script_cobratarget != 1) {
    return;
  }
  assert(isDefined(vehicle.script_targettype));
  if(!isDefined(vehicle.script_targetoffset_z))
    vehicle.script_targetoffset_z = 0;
  offset = (0, 0, vehicle.script_targetoffset_z);

  cobraTarget_Add(level.player, vehicle, vehicle.script_targettype, offset);
}

weaponsSystems_Create_Weapon() {
  ent = spawnStruct();
  ent.v = [];

  ent.v["weapon"] = undefined;
  ent.v["realWeaponName"] = undefined;
  ent.v["sound_armed"] = "cobra_weapon_change";
  ent.v["sound_armed_loop"] = undefined;
  ent.v["weaponNameLocationX"] = undefined;
  ent.v["weaponNameLocationY"] = undefined;
  ent.v["equipButton"] = undefined;
  ent.v["equipShader"] = undefined;
  ent.v["hudShader"] = undefined;
  ent.v["hudShader_size_x"] = undefined;
  ent.v["hudShader_size_y"] = undefined;
  ent.v["singleShot"] = false;
  ent.v["targetType"] = undefined;
  ent.v["requireLock"] = false;
  ent.v["lockonTime"] = undefined;
  ent.v["shader_target"] = "veh_hud_target";
  ent.v["shader_target_offscreen"] = "veh_hud_target_offscreen";
  ent.v["shader_lock"] = "veh_hud_target_lock";
  ent.v["shader_locking"] = "veh_hud_target_locking";
  ent.v["shader_invalid"] = "veh_hud_target_invalid";
  ent.v["shader_invalid_offscreen"] = "veh_hud_target_invalid_offscreen";
  ent.v["maxAmmo"] = undefined;
  ent.v["ammoPickupIncrement"] = undefined;
  ent.v["ammoPickupDelay_Min"] = 0.5;
  ent.v["ammoPickupDelay_Max"] = 1.2;
  ent.v["tags"] = undefined;

  return ent;
}

weaponsSystems_Add_Weapon(weapon) {
  if(!isDefined(level.cobraWeapon))
    level.cobraWeapon = [];

  assert(isDefined(level.cobraWeapon));
  assert(isDefined(weapon.v["weapon"]));
  assert(isDefined(weapon.v["realWeaponName"]));
  assert(isDefined(weapon.v["sound_armed"]));
  assert(isDefined(weapon.v["weaponNameLocationX"]));
  assert(isDefined(weapon.v["weaponNameLocationY"]));
  assert(isDefined(weapon.v["equipButton"]));
  assert(isDefined(weapon.v["equipShader"]));
  assert(isDefined(weapon.v["singleShot"]));
  assert(isDefined(weapon.v["targetType"]));
  assert(isDefined(weapon.v["shader_target"]));
  assert(isDefined(weapon.v["shader_target_offscreen"]));
  assert(isDefined(weapon.v["shader_lock"]));
  assert(isDefined(weapon.v["shader_locking"]));
  assert(isDefined(weapon.v["shader_invalid"]));
  assert(isDefined(weapon.v["shader_invalid_offscreen"]));
  assert(isDefined(weapon.v["maxAmmo"]));
  assert(isDefined(weapon.v["ammoPickupIncrement"]));
  assert(isDefined(weapon.v["ammoPickupDelay_Min"]));
  assert(isDefined(weapon.v["ammoPickupDelay_Max"]));
  assert(isDefined(weapon.v["tags"]));
  assert(weapon.v["tags"].size > 0);

  index = level.cobraWeapon.size;
  level.cobraWeapon[index] = weapon;
  level.cobraWeapon[index].v["currentAmmo"] = level.cobraWeapon[index].v["maxAmmo"];
  level.cobraWeapon[index].v["nextTag"] = 0;

  precacheString(level.cobraWeapon[index].v["realWeaponName"]);

  precacheItem(level.cobraWeapon[index].v["weapon"]);

  if(isDefined(level.cobraWeapon[index].v["hudShader"]))
    precacheShader(level.cobraWeapon[index].v["hudShader"]);
  precacheShader(level.cobraWeapon[index].v["equipShader"]);
  precacheShader(level.cobraWeapon[index].v["shader_target"]);
  precacheShader(level.cobraWeapon[index].v["shader_target_offscreen"]);
  precacheShader(level.cobraWeapon[index].v["shader_lock"]);
  precacheShader(level.cobraWeapon[index].v["shader_locking"]);
  precacheShader(level.cobraWeapon[index].v["shader_invalid"]);
  precacheShader(level.cobraWeapon[index].v["shader_invalid_offscreen"]);

  level.cobraWeapon[index].v["weaponNameHUD"] = newHudElem();
  level.cobraWeapon[index].v["weaponNameHUD"].x = level.cobraWeapon[index].v["weaponNameLocationX"];
  level.cobraWeapon[index].v["weaponNameHUD"].y = level.cobraWeapon[index].v["weaponNameLocationY"];
  level.cobraWeapon[index].v["weaponNameHUD"].alignX = "left";
  level.cobraWeapon[index].v["weaponNameHUD"].alignY = "middle";
  level.cobraWeapon[index].v["weaponNameHUD"].horzAlign = "left";
  level.cobraWeapon[index].v["weaponNameHUD"].vertAlign = "middle";
  level.cobraWeapon[index].v["weaponNameHUD"].foreground = true;
  level.cobraWeapon[index].v["weaponNameHUD"].fontscale = 1.0;
  level.cobraWeapon[index].v["weaponNameHUD"].color = (0, 1, 0);
  level.cobraWeapon[index].v["weaponNameHUD"] setText(level.cobraWeapon[index].v["realWeaponName"]);

  if(getDvar("cobrapilot_unlimited_ammo") == "0") {
    level.cobraWeapon[index].v["ammoCounter"] = newHudElem();
    level.cobraWeapon[index].v["ammoCounter"].x = level.cobraWeapon[index].v["weaponNameLocationX"] + 160;
    level.cobraWeapon[index].v["ammoCounter"].y = level.cobraWeapon[index].v["weaponNameLocationY"];
    level.cobraWeapon[index].v["ammoCounter"].alignX = "center";
    level.cobraWeapon[index].v["ammoCounter"].alignY = "middle";
    level.cobraWeapon[index].v["ammoCounter"].horzAlign = "left";
    level.cobraWeapon[index].v["ammoCounter"].vertAlign = "middle";
    level.cobraWeapon[index].v["ammoCounter"].foreground = true;
    level.cobraWeapon[index].v["ammoCounter"].fontscale = 1.0;
    level.cobraWeapon[index].v["ammoCounter"].color = (0, 1, 0);
    level.cobraWeapon[index].v["ammoCounter"] setValue(level.cobraWeapon[index].v["currentAmmo"]);
  }
}

weaponsSystems() {
  assert(isDefined(self));
  assert(isDefined(self.pilot));
  assert(self.pilot.classname == "player");

  if(!isDefined(level.cobraWeapon))
    return;
  if(level.cobraWeapon.size == 0) {
    return;
  }
  level endon("cobra_death");

  self thread weaponsSystems_HUD();
  self thread weaponsSystems_Fire_Missile();
  self thread weaponsSystems_zoom();

  for(;;) {
    for(i = 0; i < level.cobraWeapon.size; i++) {
      if(self.pilot buttonPressed(level.cobraWeapon[i].v["equipButton"])) {
        weaponSystems_EquipLoopSound_Stop();

        if(self.pilot.currentWeapon == i) {
          self.pilot weaponsSystems_buttonRelease_Wait(level.cobraWeapon[self.pilot.currentWeapon].v["equipButton"]);
          continue;
        }

        self.pilot.currentWeapon = i;

        if(level.cobraWeapon[self.pilot.currentWeapon].v["weapon"] == level.GunnerWeaponPlayerEquiv) {
          self.gunner_use_turret = false;
          self notify("gunner_stop_firing");
          self clearTurretTarget();
        } else
          self.gunner_use_turret = true;

        self setVehWeapon(level.cobraWeapon[self.pilot.currentWeapon].v["weapon"]);

        level notify("weapon_armed");

        if((isDefined(level.cobraTarget)) && (level.cobraTarget.size > 0)) {
          for(i = 0; i < level.cobraTarget.size; i++)
            self thread cobraTarget_holdWait_missileLock_Sound_Stop(level.cobraTarget[i]);
        }

        if(getDvar("cobrapilot_sounds_enabled") == "1") {
          self.pilot playLocalSound(level.cobraWeapon[self.pilot.currentWeapon].v["sound_armed"]);
          self thread weaponSystems_EquipLoopSound_Start();
        }

        cobraTarget_unlockAllTargets();
        cobraTarget_UpdateShaders_All(self.pilot);

        self.pilot weaponsSystems_buttonRelease_Wait(level.cobraWeapon[self.pilot.currentWeapon].v["equipButton"]);
      }
    }
    wait 0.05;
  }
}

weaponSystems_EquipLoopSound_Start() {
  if(getDvar("cobrapilot_sounds_enabled") != "1") {
    return;
  }
  if(!isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["sound_armed_loop"])) {
    return;
  }
  if(isDefined(level.weaponEquipLoopSoundPlaying)) {
    return;
  }
  level.weaponEquipLoopSoundPlaying = true;

  self.pilot thread playLoopSoundForSeeking(level.cobraWeapon[self.pilot.currentWeapon].v["sound_armed_loop"]);
}

weaponSystems_EquipLoopSound_Stop() {
  if(getDvar("cobrapilot_sounds_enabled") != "1") {
    return;
  }
  level.weaponEquipLoopSoundPlaying = undefined;

  if(!isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["sound_armed_loop"]))
    return;
  self.pilot notify("stop sound" + level.cobraWeapon[self.pilot.currentWeapon].v["sound_armed_loop"]);
}

weaponsSystems_buttonRelease_Wait(button) {
  assert(isDefined(self));
  assert(self.classname == "player");

  level endon("cobra_death");

  prof_begin("cobrapilot_weapons_systems");
  while(self buttonPressed(button))
    wait 0.05;
  prof_end("cobrapilot_weapons_systems");
}

weaponsSystems_HUD() {
  assert(isDefined(self));

  if(!isDefined(level.cobraWeapon))
    return;
  if(level.cobraWeapon.size == 0) {
    return;
  }

  controller_layout_size_x = 300;
  controller_layout_size_y = 75;
  self.hudelems.controller_layout = newClientHudElem(self.pilot);
  self.hudelems.controller_layout.x = 25;
  self.hudelems.controller_layout.y = 10;
  self.hudelems.controller_layout.alignX = "right";
  self.hudelems.controller_layout.alignY = "bottom";
  self.hudelems.controller_layout.horzAlign = "right";
  self.hudelems.controller_layout.vertAlign = "bottom";
  self.hudelems.controller_layout.foreground = true;

  self.hudelems.weapon_hud = newClientHudElem(self.pilot);
  self.hudelems.weapon_hud.x = 0;
  self.hudelems.weapon_hud.y = 0;
  self.hudelems.weapon_hud.alignX = "center";
  self.hudelems.weapon_hud.alignY = "middle";
  self.hudelems.weapon_hud.horzAlign = "center";
  self.hudelems.weapon_hud.vertAlign = "middle";
  self.hudelems.weapon_hud.foreground = true;
  self.hudelems.weapon_hud.alpha = 0;

  level endon("cobra_death");
  for(;;) {
    prof_begin("cobrapilot_weapons_systems");
    assert(isDefined(self.pilot.currentWeapon));

    assert(isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["equipShader"]));
    self.hudelems.controller_layout setshader(level.cobraWeapon[self.pilot.currentWeapon].v["equipShader"], controller_layout_size_x, controller_layout_size_y);

    if(isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["hudShader"])) {
      assert(isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["hudShader_size_x"]));
      assert(isDefined(level.cobraWeapon[self.pilot.currentWeapon].v["hudShader_size_y"]));
      self.hudelems.weapon_hud setshader(level.cobraWeapon[self.pilot.currentWeapon].v["hudShader"], level.cobraWeapon[self.pilot.currentWeapon].v["hudShader_size_x"], level.cobraWeapon[self.pilot.currentWeapon].v["hudShader_size_y"]);
      self.hudelems.weapon_hud.alpha = 1;
    } else
      self.hudelems.weapon_hud.alpha = 0;

    prof_end("cobrapilot_weapons_systems");

    level waittill("weapon_armed");
  }
}

weaponsSystems_Fire_Missile() {
  self endon("death");
  level endon("cobra_death");

  for(;;) {
    self waittill("turret_fire");

    if(getDvar("cobrapilot_unlimited_ammo") != "1") {
      if(level.cobraWeapon[self.pilot.currentWeapon].v["currentAmmo"] <= 0) {
        self thread weaponsSystems_noAmmo_Warning();
        continue;
      }
    }

    missileTarget = weaponsSystems_Get_Missile_Target();

    if((level.cobraWeapon[self.pilot.currentWeapon].v["requireLock"] == true) && (!isDefined(missileTarget))) {
      thread weaponsSystems_noLock_Warning();
      continue;
    }

    eMissile = undefined;
    if(isDefined(missileTarget)) {
      eMissile = self fireWeapon(level.cobraWeapon[self.pilot.currentWeapon].v["tags"][level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"]], missileTarget.targetEntity);
      missileTarget.targetEntity notify("incomming_missile", eMissile);
      if(!isDefined(missileTarget.targetEntity.incomming_Missiles))
        missileTarget.targetEntity.incomming_Missiles = [];
      missileTarget.targetEntity.incomming_Missiles = array_add(missileTarget.targetEntity.incomming_Missiles, eMissile);
      thread missile_deathWait(eMissile, missileTarget.targetEntity);
    } else
      eMissile = self fireWeapon(level.cobraWeapon[self.pilot.currentWeapon].v["tags"][level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"]]);

    assert(isDefined(eMissile));

    assert(isDefined(level.stats[level.cobraWeapon[self.pilot.currentWeapon].v["weapon"]]));
    level.stats[level.cobraWeapon[self.pilot.currentWeapon].v["weapon"]]++;

    if(isDefined(self.hasAttachedWeapons)) {
      if((isDefined(level.cobra_missile_models)) && (isDefined(level.cobra_missile_models[level.cobraWeapon[self.pilot.currentWeapon].v["weapon"]]))) {
        modelname = level.cobra_missile_models[level.cobraWeapon[self.pilot.currentWeapon].v["weapon"]];
        tagname = level.cobraWeapon[self.pilot.currentWeapon].v["tags"][level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"]];
        self weaponsSystems_Detach_Weapon(modelname, tagname);
      }
    }

    level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"]++;
    if(level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"] >= level.cobraWeapon[self.pilot.currentWeapon].v["tags"].size)
      level.cobraWeapon[self.pilot.currentWeapon].v["nextTag"] = 0;

    if(getDvar("cobrapilot_unlimited_ammo") == "0") {
      level.cobraWeapon[self.pilot.currentWeapon].v["currentAmmo"]--;
      level.cobraWeapon[self.pilot.currentWeapon].v["ammoCounter"] setValue(level.cobraWeapon[self.pilot.currentWeapon].v["currentAmmo"]);
    }

    if(level.cobraWeapon[self.pilot.currentWeapon].v["singleShot"])
      self.pilot weaponsSystems_buttonRelease_Wait("BUTTON_RTRIG");
  }
}

weaponsSystems_Detach_Weapon(modelname, tagname) {
  if(getDvar("cobrapilot_unlimited_ammo") == "1") {
    return;
  }

  attachedModelCount = self getattachsize();
  attachedModels = [];
  for(i = 0; i < attachedModelCount; i++)
    attachedModels[i] = self getattachmodelname(i);

  qAttached = false;
  for(i = 0; i < attachedModels.size; i++) {
    if(attachedModels[i] != modelname) {
      continue;
    }
    sName = self getattachtagname(i);
    if(tolower(tagname) != tolower(sName)) {
      continue;
    }
    qAttached = true;
    break;
  }

  if(qAttached)
    self detach(modelname, tagname);
  else
    println("FAILED TO DETACH MODEL: " + modelname + " from tag: " + tagname);
}

weaponsSystems_Attach_Weapon(weapon) {
  if(getDvar("cobrapilot_unlimited_ammo") == "1") {
    return;
  }

  attachedModelCount = self getattachsize();

  if(!isDefined(level.cobra_missile_models[weapon]))
    return;
  missileModel = level.cobra_missile_models[weapon];
  attachToTag = undefined;
  for(i = 0; i < level.cobra_weapon_tags[weapon].size; i++) {
    tag = level.cobra_weapon_tags[weapon][i];

    if(weaponsSystems_Model_Attached_To_Tag(tag)) {
      continue;
    }
    attachToTag = tag;
    break;
  }

  if(isDefined(attachToTag))
    self attach(missileModel, attachToTag);
}

weaponsSystems_Model_Attached_To_Tag(tagname) {
  attachedModelCount = self getattachsize();
  for(i = 0; i < attachedModelCount; i++) {
    if(self getattachtagname(i) == tagname)
      return true;
  }
  return false;
}

weaponsSystems_Get_Missile_Target() {
  level endon("cobra_death");

  missileTarget = undefined;

  if(!isDefined(level.cobraTarget))
    return missileTarget;

  if(!isDefined(level.cobraTarget.size))
    return missileTarget;

  prof_begin("cobrapilot_weapons_systems");

  for(i = 0; i < level.cobraTarget.size; i++) {
    if(!isDefined(level.cobraTarget[i].locked)) {
      continue;
    }
    if(!isDefined(missileTarget))
      missileTarget = level.cobraTarget[i];

    if(level.cobraTarget[i].locked < missileTarget.locked)
      missileTarget = level.cobraTarget[i];
  }

  prof_end("cobrapilot_weapons_systems");

  if(isDefined(missileTarget))
    missileTarget.locked = getTime();

  return missileTarget;
}

weaponsSystems_noAmmo_Warning() {
  self notify("noammo_warning");
  self endon("noammo_warning");

  if(isDefined(self.hudelems.noammo_warning))
    self.hudelems.noammo_warning destroy();

  self.hudelems.noammo_warning = newClientHudElem(self.pilot);
  self.hudelems.noammo_warning.x = 0;
  self.hudelems.noammo_warning.y = 40;
  self.hudelems.noammo_warning.alignX = "center";
  self.hudelems.noammo_warning.alignY = "middle";
  self.hudelems.noammo_warning.horzAlign = "center";
  self.hudelems.noammo_warning.vertAlign = "middle";
  self.hudelems.noammo_warning.foreground = true;

  self.hudelems.noammo_warning setText(&"COBRAPILOT_NO_AMMO");
  self.hudelems.noammo_warning.fontscale = 1.5;

  if(getDvar("cobrapilot_sounds_enabled") == "1")
    self.pilot playLocalSound("cobra_no_ammo");

  self.hudelems.noammo_warning.alpha = 1;
  wait 0.5;
  self.hudelems.noammo_warning fadeOverTime(1.0);
  self.hudelems.noammo_warning.alpha = 0;
  wait 1.0;
  self.hudelems.noammo_warning destroy();
}

weaponsSystems_noLock_Warning() {
  self notify("nolock_warning");
  self endon("nolock_warning");

  if(isDefined(self.hudelems.nolock_warning))
    self.hudelems.nolock_warning destroy();

  self.hudelems.nolock_warning = newClientHudElem(self.pilot);
  self.hudelems.nolock_warning.x = 0;
  self.hudelems.nolock_warning.y = 40;
  self.hudelems.nolock_warning.alignX = "center";
  self.hudelems.nolock_warning.alignY = "middle";
  self.hudelems.nolock_warning.horzAlign = "center";
  self.hudelems.nolock_warning.vertAlign = "middle";
  self.hudelems.nolock_warning.foreground = true;

  self.hudelems.nolock_warning setText(&"COBRAPILOT_NO_LOCK");
  self.hudelems.nolock_warning.fontscale = 1.5;

  if(getDvar("cobrapilot_sounds_enabled") == "1")
    self.pilot playLocalSound("cobra_no_ammo");

  self.hudelems.nolock_warning.alpha = 1;
  wait 0.5;
  self.hudelems.nolock_warning fadeOverTime(1.0);
  self.hudelems.nolock_warning.alpha = 0;
  wait 1.0;
  self.hudelems.nolock_warning destroy();
}

weaponsSystems_zoom() {
  assert(isDefined(self));
  assert(isDefined(self.pilot));
  assert(self.pilot.classname == "player");

  level endon("cobra_death");
  self.pilot endon("death");

  wait 0.05;

  self.pilot reset_fov_for_player();

  for(;;) {
    while(!self.pilot buttonPressed("BUTTON_LSTICK"))
      wait 0.05;
    self.pilot change_fov_for_player(level.weaponZoomFOV);

    while(self.pilot buttonPressed("BUTTON_LSTICK"))
      wait 0.05;
    self.pilot reset_fov_for_player();
  }
}

change_fov_for_player(targetFOV) {
  targetFOV = int(targetFOV);

  fov = int(getDvar("cg_fov"));
  if(isDefined(fov) && fov > 0)
    level.initialFOV = fov;

  fovFraction = targetFOV / level.initialFOV;
  fovFraction = cap_value(fovFraction, 0.2, 2.0);
  self change_fov_scale_for_player(fovFraction);
}

reset_fov_for_player() {
  self change_fov_scale_for_player(1.0);
}

change_fov_scale_for_player(scale) {
  if(self == level.player)
    setsaveddvar("cg_playerFovScale0", scale);
  else if(self == level.player2)
    setsaveddvar("cg_playerFovScale1", scale);
  else
    assertMsg("Flyable helicopters currently only supports single player or coop with 2 players. Playing with more than 2 players is not yet supported");
}

cobraTarget_Add(player, targetEntity, targetType, targetOffset) {
  assert(isDefined(player));
  assert(player.classname == "player");
  assert(isDefined(targetEntity));
  assert(isDefined(targetType));
  assert(targetType == "air" || targetType == "ground" || targetType == "dummy");

  prof_begin("cobrapilot_weapons_systems");

  if(!isDefined(targetOffset))
    targetOffset = (0, 0, 0);

  if(!isDefined(level.cobraTarget))
    level.cobraTarget = [];

  index = level.cobraTarget.size;

  level.cobraTarget[index] = spawnStruct();
  level.cobraTarget[index].targetEntity = targetEntity;
  level.cobraTarget[index].targetType = targetType;
  level.cobraTarget[index].targetOffset = targetOffset;
  level.cobraTarget[index].playerOwner = player;

  target_set(level.cobraTarget[index].targetEntity, level.cobraTarget[index].targetOffset);

  level.cobraTarget[index].targetEntity.target_initilized = true;
  thread cobraTarget_Death(level.cobraTarget[index]);

  level notify("targets_updated");

  prof_end("cobrapilot_weapons_systems");

  cobraTarget_UpdateShaders_All(player);
  thread cobraTarget_check_missileLock_All(player);
}

cobraTarget_Death(targetStruct) {
  targetStruct.targetEntity waittill("death");
  cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);

  if(isDefined(targetStruct.sideWinder_targeted))
    cobraTarget_Sidewinder_ReticleLockOn_Stop(targetStruct);

  level.stats["enemies_killed"]++;

  cobraTarget_Remove(targetStruct);
}

cobraTarget_Remove(targetStruct) {
  prof_begin("cobrapilot_weapons_systems");

  level.cobraTarget = array_remove(level.cobraTarget, targetStruct);
  target_remove(targetStruct.targetEntity);

  level notify("targets_updated");

  prof_end("cobrapilot_weapons_systems");
}

cobraTarget_UpdateShaders_All(player) {
  assert(isDefined(player));
  assert(player.classname == "player");

  if(!isDefined(player.currentWeapon)) {
    return;
  }
  if(!isDefined(level.cobraTarget))
    return;
  if(!isDefined(level.cobraTarget.size))
    return;
  if(!isDefined(level.cobraWeapon))
    return;
  if(level.cobraWeapon.size == 0) {
    return;
  }
  prof_begin("cobrapilot_weapons_systems");

  for(i = 0; i < level.cobraTarget.size; i++) {
    if(level.cobraTarget[i].playerOwner != player) {
      continue;
    }
    if(level.cobraWeapon[player.currentWeapon].v["targetType"] == "dummy")
      cobraTarget_UpdateShader(player, level.cobraTarget[i], "target");
    else if(level.cobraTarget[i].targetType == level.cobraWeapon[player.currentWeapon].v["targetType"])
      cobraTarget_UpdateShader(player, level.cobraTarget[i], "target");
    else
      cobraTarget_UpdateShader(player, level.cobraTarget[i], "invalid");
  }

  prof_end("cobrapilot_weapons_systems");
}

cobraTarget_UpdateShader(player, targetStruct, shader) {
  assert(isDefined(player));
  assert(player.classname == "player");
  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(shader));

  assertEx(isDefined(targetStruct.targetEntity.target_initilized), "Script is trying to do setShader on a target that hasn't run target_set. This is supposed to be impossible");

  switch (shader) {
    case "target":

      target_setShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_target"]);
      target_setOffscreenShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_target_offscreen"]);
      break;
    case "lock":

      target_setShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_lock"]);
      target_setOffscreenShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_target_offscreen"]);
      break;
    case "locking":

      target_setShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_locking"]);
      target_setOffscreenShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_target_offscreen"]);
      break;
    case "invalid":

      target_setShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_invalid"]);
      target_setOffscreenShader(targetStruct.targetEntity, level.cobraWeapon[player.currentWeapon].v["shader_invalid_offscreen"]);
      break;
    default:
      assertMsg("shader must be target, lock, locking, or invalid");
      break;
  }
}

cobraTarget_unlockAllTargets() {
  if(!isDefined(level.cobraTarget))
    return;
  if(!isDefined(level.cobraTarget.size)) {
    return;
  }
  prof_begin("cobrapilot_weapons_systems");

  for(i = 0; i < level.cobraTarget.size; i++) {
    cobraTarget_Sidewinder_ReticleLockOn_Stop(level.cobraTarget[i]);
    level.cobraTarget[i].sideWinder_targeted = undefined;
    level.cobraTarget[i].locking = undefined;
    level.cobraTarget[i].locked = undefined;
  }

  prof_end("cobrapilot_weapons_systems");
}

cobraTarget_check_missileLock_All(player) {
  wait 0.05;
  assert(isDefined(player) && (player.classname == "player"));

  if(!isDefined(level.cobraWeapon))
    return;
  if(level.cobraWeapon.size == 0)
    return;
  if(!isDefined(player.currentWeapon)) {
    return;
  }
  level notify("checking for missile locks");
  level endon("checking for missile locks");
  level endon("cobra_death");

  for(;;) {
    prof_begin("cobrapilot_weapons_systems");

    assert(isDefined(level.cobraTarget));

    if(!isDefined(level.cobraTarget.size)) {
      level waittill("targets_updated");
      continue;
    }

    if(!isDefined(level.cobraTarget.size)) {
      continue;
    }
    if(level.cobraWeapon[player.currentWeapon].v["targetType"] == "ground") {
      boxHalfWidth = (level.cobraWeapon[player.currentWeapon].v["hudShader_size_x"] / 2) - 25;
      boxHalfHeight = (level.cobraWeapon[player.currentWeapon].v["hudShader_size_y"] / 2) - 25;

      for(i = 0; i < level.cobraTarget.size; i++) {
        z_type = level.cobraTarget[i].targetType;
        z_weap = player.currentWeapon;
        z_weaponmode = level.cobraWeapon[player.currentWeapon].v["targetType"];

        if(level.cobraTarget[i].targetType != level.cobraWeapon[player.currentWeapon].v["targetType"]) {
          prof_end("cobrapilot_weapons_systems");
          continue;
        }
        cobraTarget_check_missileLock_Ground(level.cobraTarget[i], boxHalfWidth, boxHalfHeight);
      }
    } else if(level.cobraWeapon[player.currentWeapon].v["targetType"] == "air") {
      circleRadius = (level.cobraWeapon[player.currentWeapon].v["hudShader_size_x"] / 2) - 10;

      for(i = 0; i < level.cobraTarget.size; i++) {
        if(level.cobraTarget[i].targetType != level.cobraWeapon[player.currentWeapon].v["targetType"]) {
          prof_end("cobrapilot_weapons_systems");
          continue;
        }
        cobraTarget_check_missileLock_Air(level.cobraTarget[i], circleRadius);
      }
    } else {
      prof_end("cobrapilot_weapons_systems");
      level waittill("weapon_armed");
    }

    prof_end("cobrapilot_weapons_systems");
    wait 0.05;
  }
}

cobraTarget_isLockingOn(targetStruct, boxHalfWidth, boxHalfHeight, circleRadius) {
  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));

  if(isDefined(boxHalfWidth))
    assert(isDefined(boxHalfHeight));

  if((!isDefined(boxHalfWidth)) && (!isDefined(boxHalfHeight)))
    assert(isDefined(circleRadius));

  inReticle = false;
  sightTrace = false;

  prof_begin("cobrapilot_weapons_systems");

  inReticle = target_isinrect(targetStruct.targetEntity, level.player, int(getDvar("cg_fov")), boxHalfWidth, boxHalfHeight);
  if(inReticle)
    sightTrace = sighttracepassed(level.player getEye() + (0, 0, 100), targetStruct.targetEntity.origin + targetStruct.targetOffset + (0, 0, 100), false, undefined);

  prof_end("cobrapilot_weapons_systems");

  if(inReticle && sightTrace)
    return true;

  return false;
}

cobraTarget_check_missileLock_Ground(targetStruct, boxHalfWidth, boxHalfHeight) {
  level endon("weapon_armed");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(boxHalfWidth));
  assert(isDefined(boxHalfHeight));

  if(cobraTarget_isLockingOn(targetStruct, boxHalfWidth, boxHalfHeight))
    thread cobraTarget_holdWait_missileLock_Ground(targetStruct, boxHalfWidth, boxHalfHeight);
  else
    cobraTarget_UpdateShader(level.player, targetStruct, "target");
}

cobraTarget_holdWait_missileLock_Ground(targetStruct, boxHalfWidth, boxHalfHeight) {
  level endon("weapon_armed");
  level endon("cobra_death");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(boxHalfWidth));
  assert(isDefined(boxHalfHeight));

  targetStruct.targetEntity endon("death");

  if(isDefined(targetStruct.locking))
    return;
  if(isDefined(targetStruct.locked))
    return;
  targetStruct.locking = getTime();

  lockStartTime = getTime();

  prof_begin("cobrapilot_weapons_systems");
  thread cobraTarget_holdWait_missileLock_Sound_Start(targetStruct, "weap_hellfire_seeking");
  while(cobraTarget_isLockingOn(targetStruct, boxHalfWidth, boxHalfHeight)) {
    cobraTarget_UpdateShader(level.player, targetStruct, "locking");
    wait 0.4;
    cobraTarget_UpdateShader(level.player, targetStruct, "target");
    wait 0.4;

    currentTime = getTime();
    elapsedTime = currentTime - lockStartTime;

    if(elapsedTime > level.cobraWeapon[level.player.currentWeapon].v["lockonTime"]) {
      thread cobraTarget_holdLock_missileLock_Ground(targetStruct, boxHalfWidth, boxHalfHeight);
      prof_end("cobrapilot_weapons_systems");
      return;
    }
  }
  thread cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);
  prof_end("cobrapilot_weapons_systems");

  targetStruct.locking = undefined;
}

cobraTarget_holdLock_missileLock_Ground(targetStruct, boxHalfWidth, boxHalfHeight) {
  level endon("weapon_armed");
  level endon("cobra_death");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(boxHalfWidth));
  assert(isDefined(boxHalfHeight));

  targetStruct.targetEntity endon("death");

  cobraTarget_UpdateShader(level.player, targetStruct, "lock");

  prof_begin("cobrapilot_weapons_systems");

  targetStruct.locked = targetStruct.locking;
  targetStruct.locking = undefined;

  thread cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);
  if(getDvar("cobrapilot_sounds_enabled") == "1")
    level.player playLocalSound("weap_hellfire_lock");

  while(cobraTarget_isLockingOn(targetStruct, boxHalfWidth, boxHalfHeight))
    wait 0.05;
  targetStruct.locked = undefined;

  prof_end("cobrapilot_weapons_systems");
}

cobraTarget_holdWait_missileLock_Sound_Start(targetStruct, alias) {
  if(getDvar("cobrapilot_sounds_enabled") != "1") {
    return;
  }
  level endon("cobra_death");
  level endon("stop_cobra_hellfire_locking_sound");

  assert(isDefined(targetStruct));
  assert(isDefined(alias));

  if(isDefined(targetStruct.locking_sound_playing))
    return;
  targetStruct.locking_sound_playing = alias;

  targetStruct thread playLoopSoundForSeeking(alias);
}

cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct) {
  if(getDvar("cobrapilot_sounds_enabled") != "1") {
    return;
  }
  assert(isDefined(targetStruct));

  if(!isDefined(targetStruct.locking_sound_playing)) {
    return;
  }
  targetStruct notify("stop sound" + targetStruct.locking_sound_playing);
  targetStruct.locking_sound_playing = undefined;
}

cobraTarget_check_missileLock_Air(targetStruct, circleRadius) {
  level endon("weapon_armed");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(circleRadius));

  if(cobraTarget_Sidewinder_Has_Target()) {
    return;
  }
  if(target_isincircle(targetStruct.targetEntity, level.player, int(getDvar("cg_fov")), circleRadius)) {
    targetStruct.sideWinder_targeted = true;
    thread cobraTarget_holdWait_missileLock_Air(targetStruct, circleRadius);
    return;
  }

  cobraTarget_UpdateShader(level.player, targetStruct, "target");
}

cobraTarget_holdWait_missileLock_Air(targetStruct, circleRadius) {
  level endon("weapon_armed");
  level endon("cobra_death");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(targetStruct.sideWinder_targeted));
  assert(isDefined(circleRadius));

  targetStruct.targetEntity endon("death");

  if(isDefined(targetStruct.locking))
    return;
  if(isDefined(targetStruct.locked))
    return;
  targetStruct.locking = getTime();

  lockStartTime = getTime();

  prof_begin("cobrapilot_weapons_systems");

  thread cobraTarget_Sidewinder_ReticleLockOn_Start(targetStruct);

  while(target_isincircle(targetStruct.targetEntity, level.player, int(getDvar("cg_fov")), circleRadius)) {
    cobraTarget_UpdateShader(level.player, targetStruct, "locking");
    wait 0.4;
    cobraTarget_UpdateShader(level.player, targetStruct, "target");
    wait 0.4;

    currentTime = getTime();
    elapsedTime = currentTime - lockStartTime;

    if(elapsedTime > level.cobraWeapon[level.player.currentWeapon].v["lockonTime"]) {
      thread cobraTarget_holdLock_missileLock_Air(targetStruct, circleRadius);
      prof_end("cobrapilot_weapons_systems");
      return;
    }
  }
  prof_end("cobrapilot_weapons_systems");

  cobraTarget_Sidewinder_ReticleLockOn_Stop(targetStruct);
  targetStruct.locking = undefined;
}

cobraTarget_holdLock_missileLock_Air(targetStruct, circleRadius) {
  level endon("weapon_armed");
  level endon("cobra_death");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));
  assert(isDefined(circleRadius));

  targetStruct.targetEntity endon("death");

  cobraTarget_UpdateShader(level.player, targetStruct, "lock");

  targetStruct.targetEntity notify("missile_lock", level.playervehicle);

  prof_begin("cobrapilot_weapons_systems");

  targetStruct.locked = targetStruct.locking;
  targetStruct.locking = undefined;

  thread cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);
  thread cobraTarget_holdWait_missileLock_Sound_Start(targetStruct, "weap_aim9_lock");

  while(target_isincircle(targetStruct.targetEntity, level.player, int(getDvar("cg_fov")), circleRadius))
    wait 0.05;

  cobraTarget_Sidewinder_ReticleLockOn_Stop(targetStruct);

  targetStruct.locked = undefined;
  cobraTarget_UpdateShader(level.player, targetStruct, "target");
  prof_end("cobrapilot_weapons_systems");
}

cobraTarget_Sidewinder_Has_Target() {
  for(i = 0; i < level.cobraTarget.size; i++) {
    if(isDefined(level.cobraTarget[i].sideWinder_targeted))
      return true;
  }
  return false;
}

cobraTarget_Sidewinder_ReticleLockOn_Start(targetStruct) {
  targetStruct endon("Sidewinder_ReticleLockOn_Stop");

  assert(isDefined(targetStruct));
  assert(isDefined(targetStruct.targetEntity));

  targetStruct.targetEntity endon("death");

  weaponSystems_EquipLoopSound_Stop();

  segmentLength = (level.cobraWeapon[level.player.currentWeapon].v["lockonTime"] / 3);
  lockOnTime = (level.cobraWeapon[level.player.currentWeapon].v["lockonTime"] / 1000);

  target_startreticlelockon(targetStruct.targetEntity, lockOnTime);

  lockonAliasList = [];
  lockonAliasList[0] = "weap_aim9_growl1";
  lockonAliasList[1] = "weap_aim9_growl2";
  lockonAliasList[2] = "weap_aim9_growl3";

  for(i = 0; i < lockonAliasList.size; i++) {
    thread cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);
    thread cobraTarget_holdWait_missileLock_Sound_Start(targetStruct, lockonAliasList[i]);

    lastPhaseTime = getTime();

    while((getTime() - lastPhaseTime) < segmentLength)
      wait 0.05;
  }
}

cobraTarget_Sidewinder_ReticleLockOn_Stop(targetStruct) {
  target_clearreticlelockon();

  assert(isDefined(targetStruct));

  targetStruct.targetEntity notify("missile_lock_ended", level.playervehicle);

  targetStruct notify("Sidewinder_ReticleLockOn_Stop");

  targetStruct.sideWinder_targeted = undefined;
  thread cobraTarget_holdWait_missileLock_Sound_Stop(targetStruct);

  thread weaponSystems_EquipLoopSound_Start();
}

health_indicator_create(pilot) {
  assert(isDefined(self));
  assert(isDefined(self.pilot));

  self.hudelems.cobra_health_overlay = newClientHudElem(self.pilot);
  self.hudelems.cobra_health_overlay.x = 0;
  self.hudelems.cobra_health_overlay.y = 0;
  self.hudelems.cobra_health_overlay setshader("splatter_alt_sp", 640, 480);
  self.hudelems.cobra_health_overlay.alignX = "left";
  self.hudelems.cobra_health_overlay.alignY = "top";
  self.hudelems.cobra_health_overlay.horzAlign = "fullscreen";
  self.hudelems.cobra_health_overlay.vertAlign = "fullscreen";
  self.hudelems.cobra_health_overlay.alpha = 0;

  self.hudelems.cobra_health_icon = newClientHudElem(self.pilot);
  self.hudelems.cobra_health_icon.x = -10;
  self.hudelems.cobra_health_icon.y = -65;
  self.hudelems.cobra_health_icon.alignX = "right";
  self.hudelems.cobra_health_icon.alignY = "bottom";
  self.hudelems.cobra_health_icon.horzAlign = "right";
  self.hudelems.cobra_health_icon.vertAlign = "bottom";
  self.hudelems.cobra_health_icon.foreground = true;
  self.hudelems.cobra_health_icon setshader("cobra_health", 128, 48);
  self.hudelems.cobra_health_icon.alpha = 1;
  self.hudelems.cobra_health_icon.color = (0, 1, 0);
}

health_indicator_damageWait() {
  level endon("cobra_death");
  for(;;) {
    self waittill("damage");

    thread health_indicator_redScreenFlash(self.hudelems.cobra_health_overlay);

    newColor = self health_indicator_getColor();
    self.hudelems.cobra_health_icon.color = (newColor[0], newColor[1], newColor[2]);
  }
}

health_indicator_getColor() {
  color = (1, 0, 0);

  color_severe = [];
  color_severe[0] = 1.0;
  color_severe[1] = 0.0;
  color_severe[2] = 0.0;
  color_moderate = [];
  color_moderate[0] = 1.0;
  color_moderate[1] = 0.5;
  color_moderate[2] = 0.0;
  color_repaired = [];
  color_repaired[0] = 0.0;
  color_repaired[1] = 1.0;
  color_repaired[2] = 0.0;

  SetValue = [];
  SetValue[0] = color_severe[0];
  SetValue[1] = color_severe[1];
  SetValue[2] = color_severe[2];

  severe = 0;
  moderate = (level.flyablecobra_starting_health / 2);
  repaired = level.flyablecobra_starting_health;

  iPercentage = undefined;
  difference = undefined;
  increment = undefined;

  value = self.health;

  if((value > severe) && (value <= moderate)) {
    iPercentage = int(value * (100 / moderate));
    for(colorIndex = 0; colorIndex < SetValue.size; colorIndex++) {
      difference = (color_moderate[colorIndex] - color_severe[colorIndex]);
      increment = (difference / 100);
      SetValue[colorIndex] = color_severe[colorIndex] + (increment * iPercentage);
    }
  } else if((value > moderate) && (value <= repaired)) {
    iPercentage = int((value - moderate) * (100 / (repaired - moderate)));
    for(colorIndex = 0; colorIndex < SetValue.size; colorIndex++) {
      difference = (color_repaired[colorIndex] - color_moderate[colorIndex]);
      increment = (difference / 100);
      SetValue[colorIndex] = color_moderate[colorIndex] + (increment * iPercentage);
    }
  }

  return SetValue;
}

health_warningSound_Start() {
  level endon("cobra_death");

  if(isDefined(level.lowhealth_warning_playing))
    return;
  level.lowhealth_warning_playing = true;

  if(getDvar("cobrapilot_sounds_enabled") == "1")
    self.pilot thread play_loop_sound_on_entity("alarm_cobra_death_imminent");
}

health_warningSound_Stop() {
  self.pilot notify("stop sound" + "alarm_cobra_death_imminent");
  level.lowhealth_warning_playing = undefined;
}

health_leak() {
  level endon("cobra_death");
  self endon("stop_health_leak");

  for(;;) {
    if(self.health - level.flyablecobra_healthLeakIncrement <= 0) {
      self thread cobra_death();
      return;
    }
    self.health -= level.flyablecobra_healthLeakIncrement;

    level.stats["damage_taken"] += level.flyablecobra_healthLeakIncrement;

    self notify("damage");
    wait level.flyablecobra_healthLeakRate;
  }
}

health_indicator_redScreenFlash(overlay) {
  level notify("redScreenFlash");
  level endon("redScreenFlash");

  overlay fadeOverTime(0.1);
  overlay.alpha = 1;
  wait 0.2;
  overlay fadeOverTime(0.5);
  overlay.alpha = 0;
}

health_removeHudElems() {
  level waittill("cobra_death");

  self.hudelems.controller_layout destroy();
  self.hudelems.weapon_hud destroy();
}

health_Regen_Station() {
  level endon("cobra_death");

  for(;;) {
    level waittill("health_regen");

    if(self.health >= level.flyablecobra_starting_health) {
      continue;
    }

    self.health += level.flyablecobra_healthRegenIncrement;
    if(self.health > level.flyablecobra_starting_health)
      self.health = level.flyablecobra_starting_health;

    if(self.health > level.flyablecobra_healthWarning_value) {
      self thread health_warningSound_Stop();
      self notify("stop_health_leak");
    }

    newColor = health_indicator_getColor();
    self.hudelems.cobra_health_icon.color = (newColor[0], newColor[1], newColor[2]);

    if(getDvar("cobrapilot_sounds_enabled") == "1")
      self.pilot playLocalSound("cobra_health_pickup");

    wait level.flyablecobra_healthRegenRate;
  }
}

health_think() {
  self thread health_removeHudElems();
  fatalImpactRate = 1500;
  self thread health_Regen_Station();
  for(;;) {
    self waittill("veh_collision", velocity, collisionNormal);

    prof_begin("cobrapilot_health_system");

    impactVelocity = vectordot(velocity, collisionNormal);
    slideVelocity = length(velocity - (vector_multiply(collisionNormal, impactVelocity)));
    impactVelocity = abs(impactVelocity);

    slideVelocity = (slideVelocity / 2);

    impactAmount = impactVelocity;
    if(slideVelocity > impactVelocity)
      impactAmount = slideVelocity;

    if(impactAmount > fatalImpactRate)
      impactAmount = fatalImpactRate;

    damage = int(impactAmount * (level.flyablecobra_starting_health / fatalImpactRate));

    if(damage <= 200) {
      prof_end("cobrapilot_health_system");
      continue;
    }

    directionOfImpact = vector_multiply(collisionNormal, -1);
    directionOfImpact = self.origin + directionOfImpact;

    prof_end("cobrapilot_health_system");

    level.stats["damage_taken"] += damage;

    bDeath = false;
    if((self.health - damage) <= 0)
      bDeath = true;
    else {
      if(getDvar("cobrapilot_sounds_enabled") == "1")
        self.pilot playLocalSound("helicopter_collide");

      self.health -= damage;

      if(self.health <= level.flyablecobra_healthWarning_value) {
        self thread health_warningSound_Start();
        self thread health_leak();
      }

      self joltbody(directionOfImpact, (damage / 1900));
    }

    self notify("damage");

    if(bDeath) {
      self cobra_death();
      return;
    }

    wait 0.25;
  }
}

cobra_death() {
  if(getDvar("cobrapilot_sounds_enabled") == "1")
    self.pilot playLocalSound("helicopter_crash");

  self.health = 1;

  self useby(self.pilot);
  self hide();
  self.pilot enablehealthshield(false);

  level notify("cobra_death");

  fxOrigin = self.pilot.origin;

  playFX(level.player_death_fx, fxOrigin);
  self.pilot kill(self.pilot.origin);
  self.pilot enablehealthshield(true);
}

incommingMissile_Think() {
  level endon("cobra_death");

  thread missileIndicator_MissileFlashNotifies();

  for(;;) {
    level.playervehicle waittill("incomming_missile", eMissile);
    assert(isDefined(eMissile));
    thread missileIndicator(eMissile);
    thread incommingMissile_Missile_Death(eMissile);
    thread incommingMissile_Sound_Start();
  }
}

incommingMissile_Missile_Death(eMissile) {
  level endon("cobra_death");

  eMissile waittill("death");
  incommingMissile_Sound_Stop();
}

incommingMissile_Sound_Start() {
  if(!isDefined(level.missile_launched_warning_playing))
    level.missile_launched_warning_playing = 0;

  level.missile_launched_warning_playing++;

  if(level.missile_launched_warning_playing > 1) {
    return;
  }
  if(getDvar("cobrapilot_sounds_enabled") == "1")
    level.player thread play_loop_sound_on_entity("alarm_cobra_enemy_launch");
}

incommingMissile_Sound_Stop() {
  level.missile_launched_warning_playing--;

  if(level.missile_launched_warning_playing > 0) {
    return;
  }
  level.player notify("stop sound" + "alarm_cobra_enemy_launch");
}

ammo_Reload_Station() {
  if(!isDefined(level.cobraWeapon))
    return;
  if(level.cobraWeapon.size == 0) {
    return;
  }
  level endon("cobra_death");

  array_thread(getEntArray("ammo_reload", "targetname"), ::ammo_Reload_Station_Notify, "ammo_reload");

  if(getDvar("cobrapilot_unlimited_ammo") == "1") {
    return;
  }
  for(;;) {
    regenPoint = undefined;
    level waittill("ammo_reload", regenPoint, trigger);

    if(getDvar("cobrapilot_farp_mode") == "0") {
      for(i = 0; i < level.cobraWeapon.size; i++)
        thread ammo_Reload_Station_Add_Ammo(level.cobraWeapon[i]);
      wait 0.05;
    } else if(getDvar("cobrapilot_farp_mode") == "1") {
      thread ammo_Reload_Station_AutoLand_HintPrint(regenPoint, trigger);
      ammo_Reload_Station_Cinematic_Reload(regenPoint, trigger);
    }
  }
}

ammo_Reload_Station_Cinematic_Reload(regenPoint, trigger) {
  assert(isDefined(regenPoint));
  hoverPoint = regenPoint + (0, 0, 300);
  level.player freezeControls(true);
  level.playervehicle Vehicle_SetSpeed(30, 5);
  level.playervehicle setVehGoalPos(hoverPoint, 1);
  level.playervehicle waittill("goal");

  level.player unlink();
  level.playervehicle useby(level.player);
  level.player takeAllWeapons();
  viewingEnt = undefined;
  viewingEnt = trigger ammo_Reload_Station_Get_Viewing_Ent();
  assert(isDefined(viewingEnt));
  assert(viewingEnt.classname == "script_model");
  assert(viewingEnt.model == "tag_origin");
  level.player playerlinktodelta(viewingEnt, "tag_origin", 1.0);
  wait 0.05;
  level.player setPlayerAngles(vectorToAngles((level.playervehicle.origin - (0, 0, 56)) - viewingEnt.origin));

  wait 5;

  level.player linkto(level.playervehicle);

  level.playervehicle useby(level.player);

  level.playervehicle returnplayercontrol();
  level.player freezeControls(false);
}

ammo_Reload_Station_Get_Viewing_Ent() {
  viewingEnt = undefined;
  ents = getEntArray("ammo_viewpoint", "targetname");
  viewingEnt = getClosest(self.origin, ents);
  assert(isDefined(viewingEnt));
  return viewingEnt;
}

ammo_Reload_Station_AutoLand_HintPrint(hoverPoint, trigger) {
  if(isDefined(level.playervehicle.farp_autoland_print_on))
    return;
  level.playervehicle.farp_autoland_print_on = true;

  while(level.playervehicle isTouching(trigger))
    wait 0.05;

  level.playervehicle.farp_autoland_print_on = undefined;
}

ammo_Reload_Station_Notify(notifyString) {
  assert(isDefined(notifyString));
  level endon("cobra_death");

  farpicon = newHudElem();
  farpicon setShader("compass_waypoint_farp", 6, 6);
  farpicon.x = self.origin[0];
  farpicon.y = self.origin[1];
  farpicon.z = self.origin[2];
  farpicon.alpha = .75;
  farpicon SetWayPoint(true, false);

  trig = undefined;
  if(getDvar("cobrapilot_farp_mode") == "1") {
    trig = spawn("trigger_radius", self.origin, 16, 1500, 1000);
  }

  for(;;) {
    vehicle = undefined;
    if(getDvar("cobrapilot_farp_mode") == "0")
      self waittill("trigger", vehicle);
    else if(getDvar("cobrapilot_farp_mode") == "1") {
      assert(isDefined(trig));
      trig waittill("trigger", vehicle);
    }
    if(!isDefined(vehicle)) {
      continue;
    }
    if(vehicle != level.playervehicle) {
      continue;
    }
    regenPoint = self.origin;
    if(isDefined(self.target)) {
      ent = getent(self.target, "targetname");
      if(isDefined(ent))
        regenPoint = ent.origin;
    }

    if(isDefined(trig))
      level notify(notifyString, regenPoint, trig);
    else
      level notify(notifyString, regenPoint, self);
    level notify("health_regen");

    if(getDvar("cobrapilot_farp_mode") == "1") {
      while(vehicle isTouching(trig))
        wait 0.05;
    }
  }
}

ammo_Reload_Station_Add_Ammo(weapon) {
  level endon("cobra_death");

  if(isDefined(weapon.reloading)) {
    return;
  }
  weapon.reloading = true;

  wait randomFloatRange(weapon.v["ammoPickupDelay_Min"], weapon.v["ammoPickupDelay_Max"]);

  if(weapon.v["currentAmmo"] >= weapon.v["maxAmmo"]) {
    weapon.reloading = undefined;
    return;
  }

  weapon.v["currentAmmo"] += weapon.v["ammoPickupIncrement"];
  if(weapon.v["currentAmmo"] > weapon.v["maxAmmo"])
    weapon.v["currentAmmo"] = weapon.v["maxAmmo"];

  for(i = 0; i < weapon.v["ammoPickupIncrement"]; i++)
    level.playervehicle weaponsSystems_Attach_Weapon(weapon.v["weapon"]);

  if(getDvar("cobrapilot_sounds_enabled") == "1")
    level.player playLocalSound("cobra_ammo_reload");

  weapon.v["ammoCounter"] setValue(weapon.v["currentAmmo"]);

  weapon.reloading = undefined;
}

playLoopSoundForSeeking(alias) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death(org);
  org.origin = level.player.origin;
  org.angles = level.player.angles;
  org linkto(level.player);
  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(alias);
  org delete();
}

gunner_spawn(chopper) {
  gunner = spawn("script_model", level.playervehicle getTagOrigin("tag_gunner"));
  gunner.angles = level.playervehicle getTagAngles("tag_gunner");
  gunner linkto(level.playervehicle, "tag_gunner");
  gunner setModel("body_complete_sp_cobra_pilot_desert_zack");

  gunner useAnimTree(#animtree);

  chopper thread gunner_think(gunner);
}

gunner_think(gunner) {
  level.playervehicle endon("death");
  level.player endon("death");

  gunner thread gunner_lookAtTarget();

  for(;;) {
    if(self.gunner_use_turret == false) {
      while(self.gunner_use_turret == false)
        wait 0.1;
      wait randomfloatrange(0.5, 1.2);
      continue;
    }

    eTarget = level.playervehicle getEnemyTarget(level.GunnerTargetRange, level.GunnerTargetFOV, true, true);
    if(isDefined(eTarget)) {
      gunner thread gunner_lookAtTarget(eTarget);
      level.playervehicle thread shootEnemyTarget_Bullets(eTarget);
    } else if(getDvar("cobrapilot_debug") == "1") {
      iprintln("no valid targets");
      gunner thread gunner_lookAtTarget();
    }
    wait 2;
  }
}

gunner_lookAtTarget(eTarget) {
  level.playervehicle endon("death");
  level.player endon("death");

  self notify("stop_looking_at_target");
  self endon("stop_looking_at_target");
  if(isDefined(eTarget))
    eTarget endon("death");

  for(;;) {
    if(isDefined(self.lookingAtTarget) && isDefined(eTarget))
      blendTime = 0.1;
    else
      blendTime = 1.0;

    self.lookingAtTarget = true;

    blendAmount = self gunner_getBlendNumber(eTarget);

    self setanim(%cobra_copilot_idle_l, blendAmount[0], blendTime);
    self setanim(%cobra_copilot_idle, blendAmount[1], blendTime);
    self setanim(%cobra_copilot_idle_r, blendAmount[2], blendTime);

    if(!isDefined(eTarget)) {
      self.lookingAtTarget = undefined;
      return;
    }

    wait blendTime;
  }
}

gunner_getBlendNumber(eTarget) {
  blendAmount = [];
  blendAmount[0] = 0.0;
  blendAmount[1] = 1.0;
  blendAmount[2] = 0.0;

  if(!isDefined(eTarget))
    return blendAmount;

  forward = anglesToForward(level.playervehicle.angles);
  right = anglesToRight(level.playervehicle.angles);
  t = (eTarget.origin - level.playervehicle.origin);
  s = vectorDot(t, right);
  f = vectorDot(t, forward);
  assert(f != 0);
  value = (s / f);

  if(value < 0) {
    value = abs(value);
    if(value > 1.0)
      value = 1.0;
    blendAmount[0] = value;
    blendAmount[1] = 1 - value;
    blendAmount[2] = 0.0;
  } else if(value > 0) {
    value = abs(value);
    if(value > 1.0)
      value = 1.0;
    blendAmount[0] = 0.0;
    blendAmount[1] = 1 - value;
    blendAmount[2] = value;
  }

  return blendAmount;
}

missileIndicator(eMissile) {
  missileIndicator = spawnStruct();

  missileIndicator.eMissile = eMissile;
  target_set(missileIndicator.eMissile);
  target_setShader(missileIndicator.eMissile, level.missileHintIndicator_Missile);
  target_setOffscreenShader(missileIndicator.eMissile, level.missileHintIndicator_Missile_Offscreen);

  missileIndicator.arrowLeft = newHudElem();
  missileIndicator.arrowLeft.x = -160;
  missileIndicator.arrowLeft.y = 0;
  missileIndicator.arrowLeft.alignX = "center";
  missileIndicator.arrowLeft.alignY = "middle";
  missileIndicator.arrowLeft.horzAlign = "center";
  missileIndicator.arrowLeft.vertAlign = "middle";
  missileIndicator.arrowLeft.foreground = true;
  missileIndicator.arrowLeft.alpha = 0;
  missileIndicator.arrowLeft setshader(level.missileHintIndicator_Arrow["left"], 80, 160);

  missileIndicator.arrowRight = newHudElem();
  missileIndicator.arrowRight.x = 160;
  missileIndicator.arrowRight.y = 0;
  missileIndicator.arrowRight.alignX = "center";
  missileIndicator.arrowRight.alignY = "middle";
  missileIndicator.arrowRight.horzAlign = "center";
  missileIndicator.arrowRight.vertAlign = "middle";
  missileIndicator.arrowRight.foreground = true;
  missileIndicator.arrowRight.alpha = 0;
  missileIndicator.arrowRight setshader(level.missileHintIndicator_Arrow["right"], 80, 160);

  missileIndicator.arrowForward = newHudElem();
  missileIndicator.arrowForward.x = 0;
  missileIndicator.arrowForward.y = -160;
  missileIndicator.arrowForward.alignX = "center";
  missileIndicator.arrowForward.alignY = "middle";
  missileIndicator.arrowForward.horzAlign = "center";
  missileIndicator.arrowForward.vertAlign = "middle";
  missileIndicator.arrowForward.foreground = true;
  missileIndicator.arrowForward.alpha = 0;
  missileIndicator.arrowForward setshader(level.missileHintIndicator_Arrow["forward"], 160, 80);

  missileIndicator.arrowBack = newHudElem();
  missileIndicator.arrowBack.x = 0;
  missileIndicator.arrowBack.y = 160;
  missileIndicator.arrowBack.alignX = "center";
  missileIndicator.arrowBack.alignY = "middle";
  missileIndicator.arrowBack.horzAlign = "center";
  missileIndicator.arrowBack.vertAlign = "middle";
  missileIndicator.arrowBack.foreground = true;
  missileIndicator.arrowBack.alpha = 0;
  missileIndicator.arrowBack setshader(level.missileHintIndicator_Arrow["back"], 160, 80);

  thread missileIndicator_MissileDeath(missileIndicator);
  thread missileIndicator_MissileFlash(missileIndicator);

  eMissile endon("death");
  level.player endon("death");
  level.playervehicle endon("death");
  for(;;) {
    level waittill("incomming_missile_blink_on");

    prof_begin("cobrapilot_weapons_systems");

    forwardvec = anglesToForward(level.player.angles);
    backvec = vector_multiply(forwardvec, -1);
    rightvec = anglestoright(level.player.angles);
    leftvec = vector_multiply(rightVec, -1);
    vecToMissile = vectorNormalize(missileIndicator.eMissile.origin - (level.player getOrigin()));

    missileIndicator.arrowForward.alpha = 0;
    vecdot = vectordot(forwardvec, vecToMissile);
    if(vecdot > level.cosine["45"])
      missileIndicator.arrowForward.alpha = 1;

    missileIndicator.arrowBack.alpha = 0;
    vecdot = vectordot(backvec, vecToMissile);
    if(vecdot > level.cosine["45"])
      missileIndicator.arrowBack.alpha = 1;

    missileIndicator.arrowLeft.alpha = 0;
    vecdot = vectordot(leftvec, vecToMissile);
    if(vecdot > level.cosine["45"])
      missileIndicator.arrowLeft.alpha = 1;

    missileIndicator.arrowRight.alpha = 0;
    vecdot = vectordot(rightvec, vecToMissile);
    if(vecdot > level.cosine["45"])
      missileIndicator.arrowRight.alpha = 1;

    prof_end("cobrapilot_weapons_systems");

    level waittill("incomming_missile_blink_off");

    missileIndicator.arrowForward.alpha = 0;
    missileIndicator.arrowBack.alpha = 0;
    missileIndicator.arrowLeft.alpha = 0;
    missileIndicator.arrowRight.alpha = 0;
  }
}

missileIndicator_MissileFlash(missileIndicator) {
  level.playervehicle endon("death");

  assert(isDefined(missileIndicator.eMissile));

  missileIndicator.eMissile endon("death");

  for(;;) {
    level waittill("incomming_missile_blink_off");
    target_setShader(missileIndicator.eMissile, level.missileHintIndicator_Missile_Flash);
    target_setOffscreenShader(missileIndicator.eMissile, level.missileHintIndicator_Missile_Flash);

    level waittill("incomming_missile_blink_on");
    target_setShader(missileIndicator.eMissile, level.missileHintIndicator_Missile);
    target_setOffscreenShader(missileIndicator.eMissile, level.missileHintIndicator_Missile_Offscreen);
  }
}

missileIndicator_MissileDeath(missileIndicator) {
  level.playervehicle endon("death");

  assert(isDefined(missileIndicator.eMissile));

  missileIndicator.eMissile waittill("death");

  if(isDefined(missileIndicator.arrowLeft))
    missileIndicator.arrowLeft destroy();
  if(isDefined(missileIndicator.arrowRight))
    missileIndicator.arrowRight destroy();
  if(isDefined(missileIndicator.arrowForward))
    missileIndicator.arrowForward destroy();
  if(isDefined(missileIndicator.arrowBack))
    missileIndicator.arrowBack destroy();
}

missileIndicator_MissileFlashNotifies() {
  level.playervehicle endon("death");
  level.player endon("death");

  for(;;) {
    wait 0.2;
    level notify("incomming_missile_blink_off");
    wait 0.1;
    level notify("incomming_missile_blink_on");
  }
}