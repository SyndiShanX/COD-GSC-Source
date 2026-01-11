/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode.csc
*****************************************/

#include clientscripts\_music;
#include clientscripts\_utility;
#include clientscripts\_zombiemode_dissolve;

main() {
  level thread clientscripts\_zombiemode_ffotd::main_start();
  level.zombiemode = true;
  level.swimmingFeature = false;
  clientscripts\_load::main();
  clientscripts\_footsteps::SetAIFootstepPrepend("fly_step_zombie_");
  thread clientscripts\_audio::audio_init(0);
  init_client_flags();
  init_client_flag_callback_funcs();
  init_blocker_fx();
  init_riser_fx();
  level._zombieCBFunc = clientscripts\_zombiemode::on_zombie_spawn;
  level._playerCBFunc = clientscripts\_zombiemode::on_player_spawn;
  level._gibEventCBFunc = clientscripts\_zombiemode::on_gib_event;
  level thread ZPO_listener();
  level._BOX_INDICATOR_NO_LIGHTS = -1;
  level._BOX_INDICATOR_FLASH_LIGHTS_MOVING = 99;
  level._BOX_INDICATOR_FLASH_LIGHTS_FIRE_SALE = 98;
  level._box_indicator = level._BOX_INDICATOR_NO_LIGHTS;
  registerSystem("box_indicator", ::box_monitor);
  level._ZOMBIE_GIB_PIECE_INDEX_ALL = 0;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM = 1;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM = 2;
  level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG = 3;
  level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG = 4;
  level._ZOMBIE_GIB_PIECE_INDEX_HEAD = 5;
  level._ZOMBIE_GIB_PIECE_INDEX_GUTS = 6;
  OnPlayerConnect_Callback(::on_player_connect);
  clientscripts\_zombiemode_weap_freezegun::init();
  clientscripts\_zombiemode_weap_tesla::init();
  clientscripts\_zombiemode_weap_thundergun::init();
  level thread init_local_player_count();
  level thread clientscripts\_zombiemode_ffotd::main_end();
}

init_local_player_count() {
  waitforallclients();
  level._num_local_players = getLocalPlayers().size;
}

init_blocker_fx() {
  level._effect["wood_chunk_destory"] = LoadFX("impacts/fx_large_woodhit");
}

init_riser_fx() {
  if(isDefined(level.riser_fx_on_client) && level.riser_fx_on_client) {
    if(isDefined(level.use_new_riser_water) && level.use_new_riser_water) {
      level._effect["rise_burst_water"] = LoadFX("maps/zombie/fx_mp_zombie_hand_water_burst");
      level._effect["rise_billow_water"] = LoadFX("maps/zombie/fx_mp_zombie_body_water_billowing");
    }
    level._effect["rise_dust_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_falling");
    level._effect["rise_burst"] = LoadFX("maps/zombie/fx_mp_zombie_hand_dirt_burst");
    level._effect["rise_billow"] = LoadFX("maps/zombie/fx_mp_zombie_body_dirt_billowing");
    level._effect["rise_dust"] = LoadFX("maps/zombie/fx_mp_zombie_body_dust_falling");
    if(isDefined(level.riser_type) && level.riser_type == "snow") {
      level._effect["rise_burst_snow"] = loadfx("maps/zombie/fx_mp_zombie_hand_snow_burst");
      level._effect["rise_billow_snow"] = loadfx("maps/zombie/fx_mp_zombie_body_snow_billowing");
      level._effect["rise_dust_snow"] = LoadFX("maps/zombie/fx_mp_zombie_body_snow_falling");
    }
  }
}

init_client_flags() {
  level._ZOMBIE_SCRIPTMOVER_FLAG_BOX_RANDOM = 15;
  if(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
    level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_HORIZONTAL_FX = 14;
    level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_VERTICAL_FX = 13;
  }
  if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
    level._ZOMBIE_SCRIPTMOVER_FLAG_ROCK_FX = 12;
  }
  level._ZOMBIE_PLAYER_FLAG_CLOAK_WEAPON = 14;
  level._ZOMBIE_PLAYER_FLAG_DIVE2NUKE_VISION = 13;
  level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK = 12;
  if(isDefined(level.riser_fx_on_client) && level.riser_fx_on_client) {
    level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX = 8;
    if(!isDefined(level._no_water_risers)) {
      level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX_WATER = 9;
    }
    if(isDefined(level.risers_use_low_gravity_fx)) {
      level._ZOMBIE_ACTOR_ZOMBIE_RISER_LOWG_FX = 7;
    }
  }
}

init_client_flag_callback_funcs() {
  if(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
    register_clientflag_callback("scriptmover", level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_VERTICAL_FX, ::handle_vertical_board_clientside_fx);
    register_clientflag_callback("scriptmover", level._ZOMBIE_SCRIPTMOVER_FLAG_BOARD_HORIZONTAL_FX, ::handle_horizontal_board_clientside_fx);
  }
  if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
    register_clientflag_callback("scriptmover", level._ZOMBIE_SCRIPTMOVER_FLAG_ROCK_FX, ::handle_rock_clientside_fx);
  }
  register_clientflag_callback("scriptmover", level._ZOMBIE_SCRIPTMOVER_FLAG_BOX_RANDOM, clientscripts\_zombiemode_weapons::weapon_box_callback);
  register_clientflag_callback("player", level._ZOMBIE_PLAYER_FLAG_DIVE2NUKE_VISION, ::zombie_dive2nuke_visionset);
  register_clientflag_callback("player", level._ZOMBIE_PLAYER_FLAG_CLOAK_WEAPON, ::player_toggle_cloak_handler);
  register_clientflag_callback("player", level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK, ::player_deadshot_perk_handler);
  if(isDefined(level.riser_fx_on_client) && level.riser_fx_on_client) {
    register_clientflag_callback("actor", level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX, ::handle_zombie_risers);
    if(!isDefined(level._no_water_risers)) {
      register_clientflag_callback("actor", level._ZOMBIE_ACTOR_ZOMBIE_RISER_FX_WATER, ::handle_zombie_risers_water);
    }
    if(isDefined(level.risers_use_low_gravity_fx)) {
      register_clientflag_callback("actor", level._ZOMBIE_ACTOR_ZOMBIE_RISER_LOWG_FX, ::handle_zombie_lowg_risers);
    }
  }
}

handle_horizontal_board_clientside_fx(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (0, 0, 30));
      wait(randomfloat(0.3, 0.6));
      if(!snd_played) {
        self thread do_teardown_sound("plank");
        snd_played = true;
      }
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (0, 0, -30));
    }
  } else {
    playSound(0, "zmb_repair_boards", self.origin);
    localPlayers = getLocalPlayers();
    snd_played = 0;
    if(isDefined(level.override_board_repair_sound)) {
      sound = level.override_board_repair_sound;
    } else {
      sound = "zmb_repair_boards";
    }
    playSound(0, sound, self.origin);
    wait(.3);
    playSound(0, "zmb_board_slam", self.origin);
    for(i = 0; i < localPlayers.size; i++) {
      localPlayers[i] EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), self.origin, 150);
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (0, 0, 30));
      wait(randomfloat(0.3, 0.6));
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (0, 0, -30));
    }
  }
}

handle_vertical_board_clientside_fx(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      if(!snd_played) {
        self thread do_teardown_sound("plank");
        snd_played = true;
      }
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (-30, 0, 0));
    }
  } else {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    if(isDefined(level.override_board_repair_sound)) {
      sound = level.override_board_repair_sound;
    } else {
      sound = "zmb_repair_boards";
    }
    playSound(0, sound, self.origin);
    wait(.3);
    playSound(0, "zmb_board_slam", self.origin);
    for(i = 0; i < localPlayers.size; i++) {
      localPlayers[i] EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), self.origin, 150);
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (-30, 0, 0));
    }
  }
}

handle_rock_clientside_fx(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    for(i = 0; i < localPlayers.size; i++) {
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      if(!snd_played) {
        self thread do_teardown_sound("rock");
        snd_played = true;
      }
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (-30, 0, 0));
    }
  } else {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    playSound(0, "zmb_repair_boards", self.origin);
    for(i = 0; i < localPlayers.size; i++) {
      localPlayers[i] EarthQuake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.2, 0.4), self.origin, 150);
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (30, 0, 0));
      wait(randomfloat(0.3, 0.6));
      if(!snd_played) {
        playSound(0, "zmb_break_rock_barrier_fix", self.origin);
        snd_played = true;
      }
      playFX(i, level._effect["wood_chunk_destory"], self.origin + (-30, 0, 0));
    }
  }
}

do_teardown_sound(type) {
  switch (type) {
    case "rock":
      playSound(0, "zmb_break_rock_barrier", self.origin);
      wait(randomfloat(0.3, 0.6));
      playSound(0, "zmb_break_rock_barrier", self.origin);
      break;
    case "plank":
      if(isDefined(level.override_board_teardown_sound)) {
        sound = level.override_board_teardown_sound;
      } else {
        sound = "zmb_break_boards";
      }
      playSound(0, sound, self.origin);
      wait(randomfloat(0.3, 0.6));
      playSound(0, sound, self.origin);
      break;
  }
}

box_monitor(clientNum, state, oldState) {
  if(isDefined(level._custom_box_monitor)) {
    [[level._custom_box_monitor]](clientNum, state, oldState);
  }
}

ZPO_listener() {
  while(1) {
    level waittill("ZPO");
    level notify("power_on");
    level notify("revive_on");
    level notify("middle_door_open");
    level notify("fast_reload_on");
    level notify("doubletap_on");
    level notify("divetonuke_on");
    level notify("marathon_on");
    level notify("jugger_on");
    level notify("additionalprimaryweapon_on");
  }
}

player_deadshot_perk_handler(localClientNum, set, newEnt) {
  if(!self IsLocalPlayer() || self IsSpectating() || self getEntityNumber() != getLocalPlayers()[localClientNum] getEntityNumber()) {
    return;
  }
  if(set) {
    self UseAlternateAimParams();
  } else {
    self ClearAlternateAimParams();
  }
}

player_toggle_cloak_handler(localClientNum, set, newEnt) {
  if(set) {
    self thread cloak(localClientNum);
  } else {
    self thread uncloak(localClientNum);
  }
}

createZombieEyes(localClientNum) {
  if(isDefined(self._eyeArray)) {
    if(!isDefined(self._eyeArray[localClientNum])) {
      linkTag = "J_Eyeball_LE";
      fx_name = "eye_glow";
      if(isDefined(level._override_eye_fx)) {
        fx_name = level._override_eye_fx;
      }
      self._eyeArray[localClientNum] = playFXOnTag(localClientNum, level._effect[fx_name], self, linkTag);
    }
  }
}

deleteZombieEyes(localClientNum) {
  if(isDefined(self._eyeArray)) {
    if(isDefined(self._eyeArray[localClientNum])) {
      DeleteFx(localClientNum, self._eyeArray[localClientNum], true);
      self._eyeArray[localClientNum] = undefined;
    }
  }
}

on_player_connect(localClientNum) {
  ForceGameModeMappings(localClientNum, "default");
}

on_player_spawn(localClientNum) {
  ForceGameModeMappings(localClientNum, "default");
}

on_zombie_spawn(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(self._eyeArray)) {
    self._eyeArray = [];
  }
  wait(0.05);
  if(self haseyes()) {
    self createZombieEyes(localClientNum);
  }
  self mapshaderconstant(localClientNum, 0, "scriptVector0", -4.0, -1.0, 0.0, -1.0);
}

zombie_eye_callback(localClientNum, hasEyes) {
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(hasEyes) {
      self createZombieEyes(i);
    } else {
      self deleteZombieEyes(i);
    }
  }
}

init_perk_machines_fx() {
  if(getDvar(#"createfx") == "on" || getDvar(#"mutator_noPerks") == "1") {
    return;
  }
  level._effect["sleight_light"] = loadfx("misc/fx_zombie_cola_on");
  level._effect["doubletap_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  level._effect["divetonuke_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  level._effect["marathon_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  level._effect["jugger_light"] = loadfx("misc/fx_zombie_cola_jugg_on");
  level._effect["revive_light"] = loadfx("misc/fx_zombie_cola_revive_on");
  level._effect["additionalprimaryweapon_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  level thread perk_start_up();
}

perk_start_up() {
  level waittill("power_on");
  timer = 0;
  duration = 0.1;
  machines = GetStructArray("perksacola", "targetname");
  while(true) {
    for(i = 0; i < machines.size; i++) {
      switch (machines[i].script_sound) {
        case "mx_jugger_jingle":
          machines[i] thread vending_machine_flicker_light("jugger_light", duration);
          break;
        case "mx_speed_jingle":
          machines[i] thread vending_machine_flicker_light("sleight_light", duration);
          break;
        case "mx_doubletap_jingle":
          machines[i] thread vending_machine_flicker_light("doubletap_light", duration);
          break;
        case "mx_divetonuke_jingle":
          machines[i] thread vending_machine_flicker_light("divetonuke_light", duration);
          break;
        case "mx_marathon_jingle":
          machines[i] thread vending_machine_flicker_light("marathon_light", duration);
          break;
        case "mx_revive_jingle":
          machines[i] thread vending_machine_flicker_light("revive_light", duration);
          break;
        case "mx_additionalprimaryweapon_jingle":
          machines[i] thread vending_machine_flicker_light("additionalprimaryweapon_light", duration);
          break;
        default:
          machines[i] thread vending_machine_flicker_light("jugger_light", duration);
          break;
      }
    }
    timer += duration;
    duration += 0.2;
    if(timer >= 3) {
      break;
    }
    realwait(duration);
  }
}

vending_machine_flicker_light(fx_light, duration) {
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    self thread play_perk_fx_on_client(i, fx_light, duration);
  }
}

play_perk_fx_on_client(client_num, fx_light, duration) {
  fxObj = spawn(client_num, self.origin + (0, 0, -50), "script_model");
  fxobj setModel("tag_origin");
  playFXOnTag(client_num, level._effect[fx_light], fxObj, "tag_origin");
  realwait(duration);
  fxobj delete();
}

cloak(localClientNum) {
  self thread run_cloak_effect(localClientNum, true, 1500);
}

uncloak(localClientNum) {
  self thread run_cloak_effect(localClientNum, false, 1000);
}

run_cloak_effect(localClientNum, cloak, durationMsec) {
  self endon("entityshutdown");
  begin_time = GetRealTime();
  while(1) {
    age = GetRealTime() - begin_time;
    original_t = age / durationMsec;
    original_t = clamp(original_t, 0.0, 1.0);
    adjusted_t = original_t;
    if(!cloak) {
      adjusted_t = 1.0 - adjusted_t;
    }
    cloakMaskCompression = 1.0;
    cloakAmount = (adjusted_t - 0.5) * 2.0;
    cloakAmount = clamp(cloakAmount, -1.0, 1.0);
    cloakAmount = cloakAmount * cloakMaskCompression;
    self setshaderconstant(localClientNum, 0, cloakMaskCompression, cloakAmount, 0, 0);
    if(original_t == 1.0) {
      break;
    }
    realwait(0.05);
  }
}

mark_piece_gibbed(piece_index) {
  if(!isDefined(self.gibbed_pieces)) {
    self.gibbed_pieces = [];
  }
  self.gibbed_pieces[self.gibbed_pieces.size] = piece_index;
}

has_gibbed_piece(piece_index) {
  if(!isDefined(self.gibbed_pieces)) {
    return false;
  }
  for(i = 0; i < self.gibbed_pieces.size; i++) {
    if(self.gibbed_pieces[i] == piece_index) {
      return true;
    }
  }
  return false;
}

do_headshot_gib_fx() {
  fxTag = "j_neck";
  fxOrigin = self GetTagOrigin(fxTag);
  upVec = AnglesToUp(self GetTagAngles(fxTag));
  forwardVec = anglesToForward(self GetTagAngles(fxTag));
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    playFX(i, level._effect["headshot"], fxOrigin, forwardVec, upVec);
    playFX(i, level._effect["headshot_nochunks"], fxOrigin, forwardVec, upVec);
  }
  wait(0.3);
  if(isDefined(self)) {
    players = getLocalPlayers();
    for(i = 0; i < players.size; i++) {
      playFXOnTag(i, level._effect["bloodspurt"], self, fxTag);
    }
  }
}

do_gib_fx(tag) {
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    playFXOnTag(i, level._effect["animscript_gib_fx"], self, tag);
  }
  playSound(0, "zmb_death_gibs", self gettagorigin(tag));
}

do_gib(model, tag) {
  start_pos = self gettagorigin(tag);
  start_angles = self gettagangles(tag);
  wait(0.016);
  end_pos = undefined;
  angles = undefined;
  if(!isDefined(self)) {
    end_pos = start_pos + (anglesToForward(start_angles) * 10);
    angles = start_angles;
  } else {
    end_pos = self gettagorigin(tag);
    angles = self gettagangles(tag);
  }
  if(isDefined(self._gib_vel)) {
    forward = self._gib_vel;
    self._gib_vel = undefined;
  } else {
    forward = VectorNormalize(end_pos - start_pos);
    forward *= RandomIntRange(600, 1000);
    forward += (0, 0, RandomIntRange(400, 700));
  }
  CreateDynEntAndLaunch(0, model, end_pos, angles, start_pos, forward, level._effect["animscript_gibtrail_fx"], 1);
  if(isDefined(self)) {
    self do_gib_fx(tag);
  } else {
    playSound(0, "zmb_death_gibs", end_pos);
  }
}

on_gib_event(localClientNum, type, locations) {
  if(localClientNum != 0) {
    return;
  }
  if(!is_mature()) {
    return;
  }
  if(!isDefined(self._gib_def)) {
    return;
  }
  if(self._gib_def == -1) {
    return;
  }
  if(isDefined(level._gib_overload_func)) {
    PrintLn("type " + type);
    PrintLn("loc size " + locations.size);
    if(self[[level._gib_overload_func]](type, locations)) {
      return;
    }
  }
  for(i = 0; i < locations.size; i++) {
    if(isDefined(self.gibbed) && level._ZOMBIE_GIB_PIECE_INDEX_HEAD != locations[i]) {
      continue;
    }
    switch (locations[i]) {
      case 0:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn1) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag1)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn1, level._gibbing_actor_models[self._gib_def].gibSpawnTag1);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn2) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag2)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn2, level._gibbing_actor_models[self._gib_def].gibSpawnTag2);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn3) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag3)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn3, level._gibbing_actor_models[self._gib_def].gibSpawnTag3);
        }
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn4) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag4)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn4, level._gibbing_actor_models[self._gib_def].gibSpawnTag4);
        }
        self thread do_headshot_gib_fx();
        self thread do_gib_fx("J_SpineLower");
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG);
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_HEAD);
        break;
      case 1:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn1) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag1)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn1, level._gibbing_actor_models[self._gib_def].gibSpawnTag1);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_ARM);
        break;
      case 2:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn2) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag2)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn2, level._gibbing_actor_models[self._gib_def].gibSpawnTag2);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_ARM);
        break;
      case 3:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn3) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag3)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn3, level._gibbing_actor_models[self._gib_def].gibSpawnTag3);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_RIGHT_LEG);
        break;
      case 4:
        if(isDefined(level._gibbing_actor_models[self._gib_def].gibSpawn4) && isDefined(level._gibbing_actor_models[self._gib_def].gibSpawnTag4)) {
          self thread do_gib(level._gibbing_actor_models[self._gib_def].gibSpawn4, level._gibbing_actor_models[self._gib_def].gibSpawnTag4);
        }
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_LEFT_LEG);
        break;
      case 5:
        self thread do_headshot_gib_fx();
        mark_piece_gibbed(level._ZOMBIE_GIB_PIECE_INDEX_HEAD);
        break;
      case 6:
        self thread do_gib_fx("J_SpineLower");
        break;
    }
  }
  self.gibbed = true;
}

zombie_vision_set_apply(str_visionset, int_priority, flt_transition_time, int_clientnum) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self._zombie_visionset_list)) {
    self._zombie_visionset_list = [];
  }
  if(!isDefined(str_visionset) || !isDefined(int_priority)) {
    return;
  }
  if(!isDefined(flt_transition_time)) {
    flt_transition_time = 1;
  }
  if(!isDefined(int_clientnum)) {
    if(self IsLocalPlayer()) {
      int_clientnum = self GetLocalClientNumber();
    }
    if(!isDefined(int_clientnum)) {
      return;
    }
  }
  already_in_array = false;
  if(self._zombie_visionset_list.size != 0) {
    for(i = 0; i < self._zombie_visionset_list.size; i++) {
      if(isDefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
        already_in_array = true;
        if(self._zombie_visionset_list[i].priority != int_priority) {
          self._zombie_visionset_list[i].priority = int_priority;
        }
        break;
      }
    }
  }
  if(!already_in_array) {
    temp_struct = spawnStruct();
    temp_struct.vision_set = str_visionset;
    temp_struct.priority = int_priority;
    self._zombie_visionset_list = add_to_array(self._zombie_visionset_list, temp_struct, false);
  }
  vision_to_set = self zombie_highest_vision_set_apply();
  if(isDefined(vision_to_set)) {
    visionSetNaked(int_clientnum, vision_to_set, flt_transition_time);
  } else {
    visionSetNaked(int_clientnum, "undefined", flt_transition_time);
  }
}

zombie_vision_set_remove(str_visionset, flt_transition_time, int_clientnum) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(str_visionset)) {
    return;
  }
  if(!isDefined(flt_transition_time)) {
    flt_transition_time = 1;
  }
  if(!isDefined(self._zombie_visionset_list)) {
    self._zombie_visionset_list = [];
  }
  if(!isDefined(int_clientnum)) {
    if(self IsLocalPlayer()) {
      int_clientnum = self GetLocalClientNumber();
    }
    if(!isDefined(int_clientnum)) {
      return;
    }
  }
  temp_struct = undefined;
  for(i = 0; i < self._zombie_visionset_list.size; i++) {
    if(isDefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
      temp_struct = self._zombie_visionset_list[i];
    }
  }
  if(isDefined(temp_struct)) {
    self._zombie_visionset_list = array_remove(self._zombie_visionset_list, temp_struct);
  }
  vision_to_set = self zombie_highest_vision_set_apply();
  if(isDefined(vision_to_set)) {
    visionSetNaked(int_clientnum, vision_to_set, flt_transition_time);
  } else {
    visionSetNaked(int_clientnum, "undefined", flt_transition_time);
  }
}

zombie_highest_vision_set_apply() {
  if(!isDefined(self._zombie_visionset_list)) {
    return;
  }
  highest_score = 0;
  highest_score_vision = undefined;
  for(i = 0; i < self._zombie_visionset_list.size; i++) {
    if(isDefined(self._zombie_visionset_list[i].priority) && self._zombie_visionset_list[i].priority > highest_score) {
      highest_score = self._zombie_visionset_list[i].priority;
      highest_score_vision = self._zombie_visionset_list[i].vision_set;
    }
  }
  return highest_score_vision;
}

zombie_dive2nuke_visionset(local_client_num, set, newEnt) {
  self endon("disconnect");
  if(local_client_num != 0) {
    return;
  }
  if(set) {
    if(!isDefined(self._zombie_visionset_list)) {
      PrintLn("********************* zombie visionset array is not defined*******************************");
    }
    player = getLocalPlayers()[local_client_num];
    if(player getEntityNumber() != self getEntityNumber()) {
      return;
    }
    time_to_apply_vision = 0;
    time_to_remove_vision = 0.5;
    self thread zombie_vision_set_apply("zombie_cosmodrome_diveToNuke", 11, time_to_apply_vision, local_client_num);
    wait(0.5);
    self thread zombie_vision_set_remove("zombie_cosmodrome_diveToNuke", time_to_remove_vision, local_client_num);
  }
}

sidequest_solo_completed_watcher() {
  level endon("SQC");
  level waittill("SQS");
  SetCollectible(level.zombie_sidequest_solo_collectible);
}

sidequest_coop_completed_watcher() {
  level endon("SQS");
  level waittill("SQC");
  SetCollectible(level.zombie_sidequest_solo_collectible);
  SetCollectible(level.zombie_sidequest_coop_collectible);
}

register_sidequest(solo_collectible, coop_collectible) {
  level.zombie_sidequest_solo_collectible = solo_collectible;
  level.zombie_sidequest_coop_collectible = coop_collectible;
  level thread sidequest_solo_completed_watcher();
  level thread sidequest_coop_completed_watcher();
}

handle_zombie_risers_water(localClientNum, set, newEnt) {
  self endon("entityshutdown");
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    for(i = 0; i < localPlayers.size; i++) {
      if(!snd_played) {
        playSound(0, "zmb_zombie_spawn_water", self.origin);
        snd_played = 1;
      }
      playFX(i, level._effect["rise_burst_water"], self.origin + (0, 0, randomintrange(5, 10)));
      wait(.25);
      playFX(i, level._effect["rise_billow_water"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
      self thread rise_dust_fx(i, "water");
    }
  }
}

handle_zombie_lowg_risers(localClientNum, set, newEnt) {
  self endon("entityshutdown");
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    for(i = 0; i < localPlayers.size; i++) {
      if(!snd_played) {
        playSound(0, "zmb_zombie_spawn", self.origin);
        snd_played = 1;
      }
      playFX(i, level._effect["rise_burst_lg"], self.origin + (0, 0, randomintrange(5, 10)));
      wait(.25);
      playFX(i, level._effect["rise_billow_lg"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
      self thread rise_dust_fx(i, "lowg");
    }
  }
}

handle_zombie_risers(localClientNum, set, newEnt) {
  self endon("entityshutdown");
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    localPlayers = getLocalPlayers();
    snd_played = 0;
    sound = "zmb_zombie_spawn";
    burst_fx = level._effect["rise_burst"];
    billow_fx = level._effect["rise_billow"];
    type = "dirt";
    if(isDefined(level.riser_type) && level.riser_type == "snow") {
      sound = "zmb_zombie_spawn_snow";
      burst_fx = level._effect["rise_burst_snow"];
      billow_fx = level._effect["rise_billow_snow"];
      type = "snow";
    }
    for(i = 0; i < localPlayers.size; i++) {
      if(!snd_played) {
        playSound(0, sound, self.origin);
        snd_played = 1;
      }
      playFX(i, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
      wait(.25);
      playFX(i, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
      self thread rise_dust_fx(i, type);
    }
  }
}

rise_dust_fx(clientNum, type) {
  dust_tag = "J_SpineUpper";
  self endon("entityshutdown");
  if(!isDefined(self)) {
    return;
  }
  dust_time = 7.5;
  dust_interval = .1;
  player = getLocalPlayers()[clientnum];
  effect = level._effect["rise_dust"];
  switch (type) {
    case "water":
      effect = level._effect["rise_dust_water"];
      break;
    case "snow":
      effect = level._effect["rise_dust_snow"];
      break;
    case "lowg":
      effect = level._effect["rise_dust_lg"];
  }
  for(t = 0; t < dust_time; t += dust_interval) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(clientNum, effect, self, dust_tag);
    wait dust_interval;
  }
}