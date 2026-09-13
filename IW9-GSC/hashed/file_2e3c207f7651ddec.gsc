/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2e3c207f7651ddec.gsc
***********************************************/

_id_6A2FB36704651FC8() {
  level._effect["pipe_steam_off"] = loadfx("vfx/iw8_cp/vfx_large_pipe_steam_off.vfx");
  level._effect["pipe_steam_on"] = loadfx("vfx/iw8_cp/vfx_large_pipe_steam_on.vfx");
  level._effect["pipe_fire_on"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_pipe_flame.vfx");
  level._effect["pipe_fire_off"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_pipe_flame_turn_off.vfx");
}

_id_6BFBC5BA110A8CF6() {
  level._id_7B098327E305F16D = ::_id_6922A5BD6CB03F4B;
  level.modeplayerkilledspawn = ::playerkilledspawn;
  level._id_C121AA6DC74CCE91 = _id_0AFB7E332AEE4BF2::_id_2F75743C7FE59CFC;
  level._id_CAADFDA74F61A3CA = 1;
  _id_116171939929AF39::registerfalldamagedvars();
  _id_89770FE705541944 = scripts\engine\utility::getStructArray("pipe_room_player_spawns", "targetname");

  foreach(player in level.players) {
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8]) {
          player.respawn_index = _id_AC0E594AC96AA3A8;
          player.shouldskiplaststand = 1;
          level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
        }
      }
    }
  }

  if(isDefined(level.enter_spectator_func))
    level.old_spectator_func = level.enter_spectator_func;

  level.enter_spectator_func = ::pipe_room_dogtag_revive;
  level.skip_nav_check_on_spectate_respawn = 1;

  if(isDefined(level.getspawnpoint))
    level.old_getspawnpoint_func = level.getspawnpoint;

  level.getspawnpoint = ::get_pipe_room_spawnpoint;
  level.coop_gameshouldendfunc = _id_18AF78602B67B70C::_id_EDCE93CF6B7199A0;
  level.all_players_skip_last_stand = 1;
  level.fx_ents = [];
  level.fx_ent_index = 0;
  triggers = getEntArray("steam_trigger", "targetname");
  scripts\engine\utility::array_thread(triggers, ::steam_trigger_think);
  _id_51E791B4D5448C42 = getEntArray("steam_valve", "targetname");

  foreach(_id_05CE5B54E58D14C5 in _id_51E791B4D5448C42)
  _id_05CE5B54E58D14C5 thread steam_valve_think(undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);

  _id_18AF78602B67B70C::_id_55A28F2BA806FE97("pipe_room_respawn_point");
  level thread _id_0867E82AFC6C1037();
  level thread init_fan_blades();
  level thread _id_C8B9C39E26CD5A34();
  thread _id_8EEC471707A3C318();
  thread _id_8746FC82D50AE977();
}

_id_8EEC471707A3C318() {
  scripts\engine\utility::flag_wait("level_ready_for_script");

  for(;;) {
    _id_89770FE705541944 = scripts\engine\utility::getStructArray("pipe_room_player_spawns", "targetname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89770FE705541944.size; _id_AC0E594AC96AA3A8++) {}

    wait 1;
  }
}

playerkilledspawn(_id_642470E1ABC1BBF9) {
  return 0;
}

_id_6922A5BD6CB03F4B(player, damage_data) {
  return 0;
}

_id_6F04CAF5FBA8EEC2() {
  level._id_CAADFDA74F61A3CA = undefined;

  if(isDefined(level.old_spectator_func))
    level.enter_spectator_func = level.old_spectator_func;

  if(isDefined(level.old_getspawnpoint_func))
    level.getspawnpoint = level.old_getspawnpoint_func;

  level._id_C121AA6DC74CCE91 = undefined;
  level._id_7B098327E305F16D = undefined;
  level.modeplayerkilledspawn = _id_0AFB7E332AEE4BF2::playerkilledspawn;
  level.all_players_skip_last_stand = 0;
  level.player_respawn = undefined;
  level.coop_gameshouldendfunc = undefined;

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }

  setDvar("bg_fallDamageMinHeight", 560);
  setDvar("bg_fallDamageMaxHeight", 561);
  setDvar("bg_softLandingMinHeight", 560);
  setDvar("bg_softLandingMaxHeight", 561);
  level notify("cleanup_pipe_room");
}

_id_C8B9C39E26CD5A34() {
  level endon("game_ended");
  trigger = getEnt("pipe_room_end_volume", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      wait 2;

      if(isalive(player)) {
        break;
      }
    }

    waitframe();
  }

  thread _id_3496F89E047E7DA4(trigger);
  _id_AA10F47F706DDA93 = 0;

  while(!istrue(_id_AA10F47F706DDA93)) {
    _id_AA10F47F706DDA93 = 1;

    foreach(player in level.players) {
      if(!player istouching(trigger) || !isalive(player))
        _id_AA10F47F706DDA93 = 0;
    }

    wait 1;
  }

  level notify("pipe_room_done");
  level notify("traversal_section_done");
}

_id_EF08D23CDC305296(trigger) {
  foreach(player in level.players) {
    if(player istouching(trigger))
      return 1;
  }

  return 0;
}

_id_3496F89E047E7DA4(trigger) {
  level endon("game_ended");
  level endon("pipe_room_done");
  wait 3;

  for(;;) {
    if(_id_EF08D23CDC305296(trigger))
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID_PIPEROOM/PLAYERS_NEEDED_TO_PROGRESS", "allies", 5);

    wait 20;
  }
}

steam_valve_think(_id_CBBB011BB8803184, _id_3AD395ADB242930C, _id_852EE311FD6A1727, _id_2312D6385AE695A8, _id_40D4D7A8AD6420E3, _id_1683E3F8B41675B7, _id_81FEE161ED3B0CCD, _id_D153C3A40B959FE7, _id_43A057F93C1B1AAC) {
  self endon("death");
  hintdist = scripts\engine\utility::ter_op(isDefined(_id_3AD395ADB242930C), _id_3AD395ADB242930C, 256);
  hintfov = scripts\engine\utility::ter_op(isDefined(_id_852EE311FD6A1727), _id_852EE311FD6A1727, 65);
  usedist = scripts\engine\utility::ter_op(isDefined(_id_2312D6385AE695A8), _id_2312D6385AE695A8, 64);
  usefov = scripts\engine\utility::ter_op(isDefined(_id_40D4D7A8AD6420E3), _id_40D4D7A8AD6420E3, 65);
  priority = scripts\engine\utility::ter_op(isDefined(_id_81FEE161ED3B0CCD), _id_81FEE161ED3B0CCD, 25);
  tag = scripts\engine\utility::ter_op(isDefined(_id_1683E3F8B41675B7), _id_1683E3F8B41675B7, undefined);
  _id_D153C3A40B959FE7 = scripts\engine\utility::_id_53C4C53197386572(_id_D153C3A40B959FE7, 0);
  scripts\cp\utility::sethintobject(tag, "HINT_BUTTON", undefined, &"CP_RAID_COMPLEX_PIPE_ROOM/TURN_VALVE", priority, "duration_short", "show", hintdist, hintfov, usedist, usefov);
  state = "on";
  _id_9B311133D7148ED7(_id_43A057F93C1B1AAC);
  _id_AF508DD08DFDEF7F = self.angles;
  _id_3798629785A66F97 = _id_AF508DD08DFDEF7F;
  animnode = undefined;
  entity = undefined;
  animname = undefined;
  anime = undefined;

  if(!isDefined(level._id_14D12EBE579F0DF8))
    level._id_14D12EBE579F0DF8 = [];

  level._id_14D12EBE579F0DF8[level._id_14D12EBE579F0DF8.size] = self;

  if(!_id_D153C3A40B959FE7) {
    if(issubstr(self.targetname, "fire")) {
      animnode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("fire_valve_animnode", "targetname"));
      entity = scripts\engine\utility::getclosest(self.origin, getEntArray("fire_valve_console", "targetname"));
      animname = "fire_valve";
      anime = "fire_off";
    } else {
      animnode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("steam_valve_animnode", "targetname"));
      entity = self;
      animname = "steam_valve";
      anime = "steam_off";
    }

    entity.animname = animname;
    entity useanimtree(level.scr_animtree[animname]);
    animnode thread scripts\common\anim::anim_first_frame_solo(entity, anime);
  }

  self._id_98AABCA05601AA67 = 1;

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player() || !istrue(self._id_98AABCA05601AA67)) {
      continue;
    }
    _id_D8BFA9F061E50AE2(0);
    self _meth_DFB78B3E724AD620(0);
    level notify(self.targetname + "_valve_activate_start", player);

    if(!_id_D153C3A40B959FE7) {
      player _id_3B64EB40368C1450::set("valve_anim", "damage", 0);

      if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
        _id_66809387054FC02A = "plyr_valve_f";
      else
        _id_66809387054FC02A = "plyr_valve_m";

      actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, _id_66809387054FC02A, 1);
      _id_CDF199F06F0846F4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(entity, animname);
      animnode thread scripts\common\anim::anim_first_frame_solo(entity, anime);
      animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_CDF199F06F0846F4], anime, 1, 1);
      player _id_3B64EB40368C1450::set("valve_anim", "damage", 1);
    }

    _id_E12BCCBD5FF828F4();

    if(state == "on")
      state = "off";
    else
      state = "on";

    if(_id_D153C3A40B959FE7) {
      direction = 90;

      if(state == "on")
        direction = -90;

      total_time = 0;
      _id_6E600E386787EE6A = 1;
      _id_DB4E1E3F687838C8 = 10;
      direction = direction / _id_DB4E1E3F687838C8;

      for(_id_D6B998AD04A6225F = _id_6E600E386787EE6A / _id_DB4E1E3F687838C8; total_time < _id_6E600E386787EE6A; total_time = total_time + _id_D6B998AD04A6225F) {
        _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, direction, 0));
        self rotateTo(_id_3798629785A66F97, _id_D6B998AD04A6225F);
        self waittill("rotatedone");
      }
    } else if(isDefined(level.scr_anim[animname]["reset"])) {
      _id_CDF199F06F0846F4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(entity, animname);
      animnode scripts\cp_mp\anim_scene::anim_scene([_id_CDF199F06F0846F4], "reset", 0);
    } else
      wait 1;

    if(isDefined(_id_CBBB011BB8803184)) {
      wait(_id_CBBB011BB8803184);
      _id_E12BCCBD5FF828F4();
      waitframe();
      level notify(self.targetname + "_valve_activate_end", player);
    } else
      level notify(self.targetname + "_valve_activate_end", player);

    _id_D8BFA9F061E50AE2(1);
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_EAE5F70AEEB2DA52() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill(self.targetname + "_valve_activate_start");
    self _meth_DFB78B3E724AD620(0);
    level waittill(self.targetname + "_valve_activate_end");
    self _meth_DFB78B3E724AD620(1);
  }
}

steam_trigger_think() {
  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(struct in _id_5D99A225CB875DDA)
  struct thread steam_point_think();

  waitframe();
  self delete();
}

_id_C9FEFD0B407C72DB(point) {
  return isDefined(point.script_noteworthy) && point.script_noteworthy == "fire";
}

steam_point_think() {
  level endon("pipe_room_done");
  level endon("stop_steam");

  if(!isDefined(level.fx_ents))
    level.fx_ents = [];

  if(!isDefined(level.fx_ent_index))
    level.fx_ent_index = 0;

  if(!isDefined(self.off_max))
    self.off_max = 0;

  if(!isDefined(self.off_min))
    self.off_min = 0;

  if(!isDefined(self.on_max))
    self.on_max = 0;

  if(!isDefined(self.on_min))
    self.on_min = 0;

  off_max = float(self.off_max);
  off_min = float(self.off_min);
  on_max = float(self.on_max);
  on_min = float(self.on_min);
  self.soundent = spawn("script_model", self.origin);
  self.soundent setModel("tag_origin");

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
    _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_E4CA48B886F78652), self._id_E4CA48B886F78652, "evt_raid_fire_pipe_on");
    _id_8AAA4CB51D7A5D3F = scripts\engine\utility::ter_op(isDefined(self._id_F952D839211EF876), self._id_F952D839211EF876, "evt_raid_fire_pipe_lp_0" + randomintrange(1, 4));
    self.soundent playSound(_id_90E6BC3A37537C77);
    self.soundent playLoopSound(_id_8AAA4CB51D7A5D3F);

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_fire_on"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles) + (0, 0, 0));
  } else {
    if(soundexists("evt_raid2_steam_pipe_on")) {
      _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_E4CA48B886F78652), self._id_E4CA48B886F78652, "evt_raid2_steam_pipe_on");
      _id_8AAA4CB51D7A5D3F = scripts\engine\utility::ter_op(isDefined(self._id_F952D839211EF876), self._id_F952D839211EF876, "evt_raid2_steam_pipe_lp_0" + randomintrange(1, 4));
      self.soundent playSound(_id_90E6BC3A37537C77);
      self.soundent playLoopSound(_id_8AAA4CB51D7A5D3F);
    }

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_steam_on"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));
  }

  _id_CC96F4DA41E441C6 = level.fx_ent_index;

  if(!isDefined(self._id_DA362DEEABE0D729)) {
    level.fx_ents[_id_CC96F4DA41E441C6] = self.steam_fx_on;
    level.fx_ent_index++;
  }

  if(isDefined(self._id_C62142E3FF9FA745)) {
    scripts\engine\utility::stop_exploder(self._id_DA362DEEABE0D729);
    scripts\engine\utility::exploder(self._id_C62142E3FF9FA745);
  } else if(_id_C9FEFD0B407C72DB(self))
    self.steam_fx_off = spawnfx(level._effect["pipe_fire_off"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));
  else
    self.steam_fx_off = spawnfx(level._effect["pipe_steam_off"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

  self.trigger = undefined;

  if(!isDefined(self._id_C62142E3FF9FA745)) {
    _id_EF8C54D3684173A2 = level.fx_ent_index;
    level.fx_ents[_id_EF8C54D3684173A2] = self.steam_fx_off;
    level.fx_ent_index++;
  }

  level thread clean_up_ents(self);

  for(;;) {
    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      triggerfx(self.steam_fx_on);

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
      _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_E4CA48B886F78652), self._id_E4CA48B886F78652, "evt_raid_fire_pipe_on");
      _id_8AAA4CB51D7A5D3F = scripts\engine\utility::ter_op(isDefined(self._id_F952D839211EF876), self._id_F952D839211EF876, "evt_raid_fire_pipe_lp_0" + randomintrange(1, 4));
      self.soundent playSound(_id_90E6BC3A37537C77);
      self.soundent playLoopSound(_id_8AAA4CB51D7A5D3F);
    } else {
      _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_E4CA48B886F78652), self._id_E4CA48B886F78652, "evt_raid2_steam_pipe_on");
      _id_8AAA4CB51D7A5D3F = scripts\engine\utility::ter_op(isDefined(self._id_F952D839211EF876), self._id_F952D839211EF876, "evt_raid2_steam_pipe_lp_0" + randomintrange(1, 4));
      self.soundent playSound(_id_90E6BC3A37537C77);
      self.soundent playLoopSound(_id_8AAA4CB51D7A5D3F);
    }

    if(!isDefined(self.trigger))
      self.trigger = _id_954A706E0DA94CE9(self);
    else
      self.trigger scripts\engine\utility::trigger_on();

    if(on_max == 0 && on_min == 0 && off_min == 0 && off_max == 0)
      self waittill("forever");

    if(on_max > on_min)
      wait(randomfloatrange(on_min, on_max) - 1);
    else
      wait(on_max - 1);

    if(isDefined(self._id_C62142E3FF9FA745)) {
      scripts\engine\utility::stop_exploder(self._id_DA362DEEABE0D729);
      scripts\engine\utility::exploder(self._id_C62142E3FF9FA745);
    } else
      triggerfx(self.steam_fx_off);

    wait 0.5;

    if(isDefined(self.steam_fx_on))
      self.steam_fx_on delete();

    self.soundent stoploopsound();

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
      _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_08204D487A1F9ED8), self._id_08204D487A1F9ED8, "evt_raid_fire_pipe_off");
      self.soundent playSound(_id_90E6BC3A37537C77);
    } else
      self.soundent playSound("evt_raid2_steam_pipe_off");

    wait 0.5;
    self.trigger scripts\engine\utility::trigger_off();

    if(!isDefined(self._id_DA362DEEABE0D729)) {
      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire")
        self.steam_fx_on = spawnfx(level._effect["pipe_fire_on"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));
      else
        self.steam_fx_on = spawnfx(level._effect["pipe_steam_on"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

      level.fx_ents[_id_CC96F4DA41E441C6] = self.steam_fx_on;
    }

    if(off_max > off_min) {
      wait(randomfloatrange(off_min, off_max));
      continue;
    }

    wait(off_max);
  }
}

_id_33C410105D81535B(waittime, _id_05CE5B54E58D14C5) {
  level endon("game_ended");
  wait(waittime);
  scripts\engine\utility::exploder(_id_05CE5B54E58D14C5._id_DA362DEEABE0D729);
}

clean_up_ents(struct) {
  level scripts\engine\utility::waittill_any_2("pipe_room_done", "stop_steam");
  waitframe();

  if(isDefined(struct.trigger))
    struct.trigger delete();

  if(isDefined(struct.steam_fx_on))
    struct.steam_fx_on delete();

  if(isDefined(struct.steam_fx_off))
    struct.steam_fx_off delete();

  struct = undefined;
}

_id_954A706E0DA94CE9(loc) {
  loc endon("stop_steam");
  radius = 16;
  target = scripts\engine\utility::getStruct(loc.target, "targetname");
  _id_DB261FD54D348CA8 = vectortoangles(target.origin - loc.origin);
  _id_D3AEA09A7DBDFB1F = distance(target.origin, loc.origin);
  _id_A5266B79A90A9DDE = 4;

  if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "fire")
    _id_A5266B79A90A9DDE = 8;

  if(scripts\cp\utility::_id_AAE723485E3B0E9D())
    _id_A5266B79A90A9DDE = 16;

  _id_E600CEB02E61B16A = loc.origin;
  _id_85CC286ED5BA0688 = spawn("trigger_rotatable_radius", _id_E600CEB02E61B16A, 0, _id_A5266B79A90A9DDE, _id_D3AEA09A7DBDFB1F);
  _id_85CC286ED5BA0688.angles = _id_DB261FD54D348CA8 + (90, 0, 0);
  _id_85CC286ED5BA0688 thread steam_dmg_trigger_think(loc);
  return _id_85CC286ED5BA0688;
}

steam_dmg_trigger_think(loc) {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(player.steam_damaged)) {
      continue;
    }
    player thread steam_damage_player(self, loc);
  }
}

steam_damage_player(trigger, loc) {
  self endon("disconnect");
  _id_1F05B2547A6EA2BF = getdvarint("dvar_6FE4652F3A56CD33", 300);
  dmg = getdvarint("dvar_96C43A8E640E7826", 50);

  if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "fire") {
    dmg = 5000;
    self.shouldskipdeathsshield = 1;
    self.shouldskiplaststand = 1;
    self._id_1983AF7858AA2ABA = 1;

    if(isDefined(loc._id_13EE6EFB16352697))
      self setOrigin(loc._id_13EE6EFB16352697);

    self dodamage(dmg, self.origin, trigger, trigger, "MOD_TRIGGER_HURT");
  }

  self notify("steam_damage", trigger, loc);
  self.steam_damaged = 1;
  self shellshock("default", 2);
  thread remove_steam_damage();
  target = scripts\engine\utility::getStruct(loc.target, "targetname");
  _id_DB261FD54D348CA8 = vectortoangles(target.origin - loc.origin);
  _id_829CEAC2F5EC057B = anglesToForward(_id_DB261FD54D348CA8);
  self setvelocity(self getvelocity() + _id_829CEAC2F5EC057B * _id_1F05B2547A6EA2BF, 1);
}

remove_steam_damage() {
  self endon("disconnect");
  wait 0.5;
  self.steam_damaged = undefined;
}

_id_9B311133D7148ED7(_id_43A057F93C1B1AAC) {
  if(!isDefined(self._id_3AD974EE99198ECC))
    self._id_3AD974EE99198ECC = [];

  _id_9ABCEB48331D3424 = [];

  if(istrue(_id_43A057F93C1B1AAC))
    _id_9ABCEB48331D3424 = scripts\engine\utility::getStructArray("dogtag_loc", "script_noteworthy");

  _id_3E60AF10370D5C81 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_3E60AF10370D5C81) {
    if(!isDefined(_id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17))
      _id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17 = [];

    if(!scripts\engine\utility::array_contains(_id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17, self))
      _id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17[_id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17.size] = self;

    if(istrue(_id_0C3EA9B1A20FF199._id_2023AA46C6559FA3)) {
      continue;
    }
    if(istrue(_id_43A057F93C1B1AAC) && _id_9ABCEB48331D3424.size > 0) {
      _id_AA5010ECD52D1152 = scripts\engine\utility::getclosest(_id_0C3EA9B1A20FF199.origin, _id_9ABCEB48331D3424);
      _id_0C3EA9B1A20FF199._id_13EE6EFB16352697 = _id_AA5010ECD52D1152.origin;
    }

    if(isDefined(self._id_DA362DEEABE0D729) && isDefined(self._id_C62142E3FF9FA745)) {
      _id_0C3EA9B1A20FF199._id_C62142E3FF9FA745 = self._id_C62142E3FF9FA745;
      _id_0C3EA9B1A20FF199._id_DA362DEEABE0D729 = self._id_DA362DEEABE0D729;
    }

    _id_0C3EA9B1A20FF199.soundent = spawn("script_model", _id_0C3EA9B1A20FF199.origin);
    _id_0C3EA9B1A20FF199.soundent setModel("tag_origin");
    _id_0C3EA9B1A20FF199._id_2023AA46C6559FA3 = 1;
    self._id_3AD974EE99198ECC[self._id_3AD974EE99198ECC.size] = _id_0C3EA9B1A20FF199;

    if(!isDefined(_id_0C3EA9B1A20FF199.script_parameters))
      _id_0C3EA9B1A20FF199.script_parameters = "on";

    if(_id_0C3EA9B1A20FF199.script_parameters == "on") {
      _id_0C3EA9B1A20FF199 thread valve_steam_on();
      continue;
    }

    _id_0C3EA9B1A20FF199.script_parameters = "off";
  }
}

_id_D8BFA9F061E50AE2(_id_41D8BF229CF29051) {
  _id_3E60AF10370D5C81 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_3E60AF10370D5C81) {
    foreach(_id_05CE5B54E58D14C5 in _id_0C3EA9B1A20FF199._id_3C8FE11231DCFA17) {
      if(istrue(_id_41D8BF229CF29051)) {
        _id_05CE5B54E58D14C5._id_98AABCA05601AA67 = 1;
        _id_05CE5B54E58D14C5 setHintString(&"CP_RAID_COMPLEX_PIPE_ROOM/TURN_VALVE");
        continue;
      }

      _id_05CE5B54E58D14C5._id_98AABCA05601AA67 = 0;
      _id_05CE5B54E58D14C5 setHintString(&"CP_RAID_COMPLEX_PIPE_ROOM/VALVE_DISABLED");
    }
  }

  if(istrue(self._id_4D7BBD8D57D75E78))
    self._id_98AABCA05601AA67 = _id_41D8BF229CF29051;
}

_id_E12BCCBD5FF828F4() {
  _id_3E60AF10370D5C81 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_3E60AF10370D5C81) {
    if(_id_0C3EA9B1A20FF199.script_parameters == "on") {
      _id_0C3EA9B1A20FF199 thread valve_steam_off();
      _id_0C3EA9B1A20FF199.script_parameters = "off";
      continue;
    }

    _id_0C3EA9B1A20FF199 thread valve_steam_on();
    _id_0C3EA9B1A20FF199.script_parameters = "on";
  }
}

turn_off_steam() {
  _id_3E60AF10370D5C81 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_3E60AF10370D5C81)
  _id_0C3EA9B1A20FF199 thread valve_steam_off();
}

turn_on_steam() {
  _id_3E60AF10370D5C81 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_3E60AF10370D5C81)
  _id_0C3EA9B1A20FF199 thread valve_steam_on();
}

valve_steam_on() {
  self endon("death");

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
    if(scripts\cp\utility::_id_AAE723485E3B0E9D() && getdvarint("dvar_8E219ED34EE49E43", 0) == 0)
      self.soundent playSound("evt_raid_fire_pipe_on");

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_fire_on"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));

    self.soundent playLoopSound("evt_raid_fire_pipe_lp_0" + randomintrange(1, 4));
  } else {
    self.soundent playSound("evt_raid2_steam_pipe_on");

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_steam_on"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

    self.soundent playLoopSound("evt_raid2_steam_pipe_lp_0" + randomintrange(1, 4));
  }

  if(!isDefined(self._id_C62142E3FF9FA745)) {
    if(_id_C9FEFD0B407C72DB(self)) {
      if(!isDefined(self.steam_fx_off))
        self.steam_fx_off = spawnfx(level._effect["pipe_fire_off"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));
    } else if(!isDefined(self.steam_fx_off))
      self.steam_fx_off = spawnfx(level._effect["pipe_steam_off"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

    triggerfx(self.steam_fx_on);
  }

  self.steam_trigger = _id_954A706E0DA94CE9(self);
}

valve_steam_off() {
  if(!isDefined(self._id_C62142E3FF9FA745))
    triggerfx(self.steam_fx_off);

  self.soundent stoploopsound();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
    _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_08204D487A1F9ED8), self._id_08204D487A1F9ED8, "evt_raid_fire_pipe_off");
    self.soundent playSound(_id_90E6BC3A37537C77);
  } else
    self.soundent playSound("evt_raid2_steam_pipe_off");

  wait 0.5;

  if(isDefined(self._id_DA362DEEABE0D729)) {
    scripts\engine\utility::stop_exploder(self._id_DA362DEEABE0D729);
    scripts\engine\utility::exploder(self._id_C62142E3FF9FA745);
  } else
    self.steam_fx_on delete();

  wait 0.5;
  self.steam_trigger delete();
  self.steam_trigger = undefined;
}

_id_1C965B85334F4C41(_id_F267EB6D2D3EA580) {
  level endon("game_ended");
  level endon("stop_steam");
  _id_EF0DA79BC6D64DC0 = scripts\engine\utility::getStruct(_id_F267EB6D2D3EA580, "script_noteworthy");
  _id_B97CB0AA5C184EDA = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_EF0DA79BC6D64DC0, &"CP_TRAP_ROOM/PLATFORM_BTTN_LABEL", undefined, undefined, undefined, undefined, "show");
  _id_0F5D852C02AF039F = scripts\engine\utility::getStructArray(_id_EF0DA79BC6D64DC0.target, "targetname");
  _id_B97CB0AA5C184EDA thread _id_D02A0B63A6802AEE(_id_B97CB0AA5C184EDA);

  foreach(spout in _id_0F5D852C02AF039F) {
    spout._id_AB98B1B2CFECFCED = _id_B97CB0AA5C184EDA;
    spout thread _id_ED57075F32B9F031();
  }
}

_id_D02A0B63A6802AEE(button) {
  level endon("game_ended");

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);
    button _meth_DFB78B3E724AD620(0);

    if(!isPlayer(player)) {
      continue;
    }
    button notify("button_held");
    button._id_DF8DCC39FC051041 = 1;

    while(player useButtonPressed() && distance2d(player.origin, button.origin) < 64 && !istrue(player.inlaststand)) {
      button._id_DF8DCC39FC051041 = 1;
      waitframe();
    }

    button._id_DF8DCC39FC051041 = 0;
  }
}

_id_ED57075F32B9F031() {
  level endon("game_ended");
  level endon("pipe_room_done");
  level endon("stop_steam");

  if(!isDefined(level.fx_ents))
    level.fx_ents = [];

  if(!isDefined(level.fx_ent_index))
    level.fx_ent_index = 0;

  self.soundent = spawn("script_model", self.origin);
  self.soundent setModel("tag_origin");

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
    if(scripts\cp\utility::_id_AAE723485E3B0E9D() && getdvarint("dvar_8E219ED34EE49E43", 0) == 0)
      self.soundent playSound("evt_raid_fire_pipe_on");

    self.soundent playLoopSound("evt_raid_fire_pipe_lp_0" + randomintrange(1, 4));

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_fire_on"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles) + (0, 0, 0));
  } else {
    if(soundexists("evt_raid2_steam_pipe_on")) {
      self.soundent playSound("evt_raid2_steam_pipe_on");
      self.soundent playLoopSound("evt_raid2_steam_pipe_lp_0" + randomintrange(1, 4));
    }

    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      self.steam_fx_on = spawnfx(level._effect["pipe_steam_on"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));
  }

  _id_CC96F4DA41E441C6 = level.fx_ent_index;

  if(!isDefined(self._id_DA362DEEABE0D729)) {
    level.fx_ents[_id_CC96F4DA41E441C6] = self.steam_fx_on;
    level.fx_ent_index++;
  }

  if(!isDefined(self._id_C62142E3FF9FA745)) {
    if(_id_C9FEFD0B407C72DB(self))
      self.steam_fx_off = spawnfx(level._effect["pipe_fire_off"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));
    else
      self.steam_fx_off = spawnfx(level._effect["pipe_steam_off"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

    _id_EF8C54D3684173A2 = level.fx_ent_index;
    level.fx_ents[_id_EF8C54D3684173A2] = self.steam_fx_off;
    level.fx_ent_index++;
  }

  self.trigger = undefined;
  level thread clean_up_ents(self);

  for(;;) {
    if(isDefined(self._id_DA362DEEABE0D729))
      level thread _id_33C410105D81535B(0.2, self);
    else
      triggerfx(self.steam_fx_on);

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
      if(scripts\cp\utility::_id_AAE723485E3B0E9D() && getdvarint("dvar_8E219ED34EE49E43", 0) == 0)
        self.soundent playSound("evt_raid_fire_pipe_on");

      self.soundent playLoopSound("evt_raid_fire_pipe_lp_0" + randomintrange(1, 4));
    } else {
      self.soundent playSound("evt_raid2_steam_pipe_on");
      self.soundent playLoopSound("evt_raid2_steam_pipe_lp_0" + randomintrange(1, 4));
    }

    if(!isDefined(self.trigger))
      self.trigger = _id_954A706E0DA94CE9(self);
    else
      self.trigger scripts\engine\utility::trigger_on();

    self._id_AB98B1B2CFECFCED waittill("button_held");

    if(isDefined(self._id_C62142E3FF9FA745)) {
      scripts\engine\utility::stop_exploder(self._id_DA362DEEABE0D729);
      scripts\engine\utility::exploder(self._id_C62142E3FF9FA745);
      wait 0.5;
    } else {
      triggerfx(self.steam_fx_off);
      wait 0.5;
      self.steam_fx_on delete();
    }

    self.soundent stoploopsound();

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire") {
      _id_90E6BC3A37537C77 = scripts\engine\utility::ter_op(isDefined(self._id_08204D487A1F9ED8), self._id_08204D487A1F9ED8, "evt_raid_fire_pipe_off");
      self.soundent playSound(_id_90E6BC3A37537C77);
    } else
      self.soundent playSound("evt_raid2_steam_pipe_off");

    while(istrue(self._id_AB98B1B2CFECFCED._id_DF8DCC39FC051041))
      waitframe();

    self.trigger scripts\engine\utility::trigger_off();

    if(!isDefined(self._id_DA362DEEABE0D729)) {
      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fire")
        self.steam_fx_on = spawnfx(level._effect["pipe_fire_on"], self.origin, anglesToForward(self.angles + (0, 0, 0)), anglestoup(self.angles + (0, 0, 0)));
      else
        self.steam_fx_on = spawnfx(level._effect["pipe_steam_on"], self.origin, anglesToForward(self.angles + (90, 0, 0)), anglestoup(self.angles + (90, 0, 0)));

      level.fx_ents[_id_CC96F4DA41E441C6] = self.steam_fx_on;
    }

    waitframe();
  }
}

_id_0867E82AFC6C1037() {
  level endon("pipe_room_done");

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  _id_89770FE705541944 = scripts\engine\utility::getStructArray("pipe_room_player_spawns", "targetname");
  _id_D3CF746E0DF9ED86 = getEnt("pipe_room_respawn_default_trigger", "targetname");

  for(;;) {
    _id_D3CF746E0DF9ED86 waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8]) {
          player.respawn_index = _id_AC0E594AC96AA3A8;
          player.shouldskiplaststand = 1;
          level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
        }
      }
    }

    waitframe();
  }
}

init_fan_blades() {
  _id_664C952D3316DE85 = getEntArray("fan_blades", "targetname");
  _id_31CAF89E35AD5C08 = getEntArray("fan_blade_center", "targetname");

  foreach(center in _id_31CAF89E35AD5C08) {
    center thread spin_fan_blades();
    wait 0.5;
  }
}

spin_fan_blades() {
  level endon("pipe_room_done");

  if(getdvarint("dvar_44F39DDD14D034C6", 0) > 0)
    thread rotate_over_time(6);
  else if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    thread _id_D733D8955B8F5F27(randomfloatrange(0.3, 0.6), randomfloatrange(4, 5), 5, 1);
  else
    thread _id_D733D8955B8F5F27(randomfloatrange(0.3, 0.6), randomfloatrange(6, 7), 5, 1);

  thread _id_0B238F204E31EF89();
}

_id_D733D8955B8F5F27(_id_6A5C1D956EC59723, _id_B00FB16DEE5B40E7, _id_D4E2D77BD72891CF, _id_12FB549A1FDD4CC2) {
  level endon("pipe_room_done");
  _id_AF508DD08DFDEF7F = self.angles;
  self._id_CE35BC0885F04F6A = 0;
  _id_EA23EA0A721D136E = 360;
  _id_CD5A5F166CDB20FD = 0;
  _id_0EBB06FE2C2E0F43 = _id_6A5C1D956EC59723;
  current_speed = "quick";
  self._id_CE35BC0885F04F6A = 1;

  for(;;) {
    self.angles = _id_AF508DD08DFDEF7F;

    if(current_speed == "slow")
      wait(_id_B00FB16DEE5B40E7);

    if(current_speed == "quick") {
      _id_781FEF231F3CD60F = 8;
      _id_3798629785A66F97 = combineangles(_id_AF508DD08DFDEF7F, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, _id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      self._id_CE35BC0885F04F6A = 0;
      wait(_id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, _id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      self._id_CE35BC0885F04F6A = 1;
      wait(_id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 8;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, _id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      self._id_CE35BC0885F04F6A = 1;
      wait(_id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, _id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      self._id_CE35BC0885F04F6A = 1;
      wait(_id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, _id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      self._id_CE35BC0885F04F6A = 0;
      wait(_id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
    }

    _id_CD5A5F166CDB20FD++;

    if(current_speed == "quick" && _id_CD5A5F166CDB20FD >= _id_D4E2D77BD72891CF) {
      _id_CD5A5F166CDB20FD = 0;
      _id_0EBB06FE2C2E0F43 = _id_B00FB16DEE5B40E7;
      current_speed = "slow";
      self._id_CE35BC0885F04F6A = 0;
      continue;
    }

    if(current_speed == "slow" && _id_CD5A5F166CDB20FD >= _id_12FB549A1FDD4CC2) {
      _id_CD5A5F166CDB20FD = 0;
      _id_0EBB06FE2C2E0F43 = _id_6A5C1D956EC59723;
      current_speed = "quick";
      self._id_CE35BC0885F04F6A = 1;
    }
  }
}

rotate_over_time(total_time) {
  level endon("pipe_room_done");
  _id_AF508DD08DFDEF7F = self.angles;
  self._id_CE35BC0885F04F6A = 0;
  _id_EA23EA0A721D136E = 360;

  for(;;) {
    self.angles = _id_AF508DD08DFDEF7F;
    _id_781FEF231F3CD60F = 8;
    _id_3798629785A66F97 = combineangles(_id_AF508DD08DFDEF7F, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
    self rotateTo(_id_3798629785A66F97, total_time / _id_781FEF231F3CD60F);
    self._id_CE35BC0885F04F6A = 0;
    self waittill("rotatedone");
    _id_781FEF231F3CD60F = 4;
    _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
    self rotateTo(_id_3798629785A66F97, total_time / _id_781FEF231F3CD60F);
    self._id_CE35BC0885F04F6A = 1;
    self waittill("rotatedone");
    _id_781FEF231F3CD60F = 8;
    _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
    self rotateTo(_id_3798629785A66F97, total_time / _id_781FEF231F3CD60F);
    self._id_CE35BC0885F04F6A = 1;
    self waittill("rotatedone");
    _id_781FEF231F3CD60F = 4;
    _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
    self rotateTo(_id_3798629785A66F97, total_time / _id_781FEF231F3CD60F);
    self._id_CE35BC0885F04F6A = 1;
    self waittill("rotatedone");
    _id_781FEF231F3CD60F = 4;
    _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
    self rotateTo(_id_3798629785A66F97, total_time / _id_781FEF231F3CD60F);
    self._id_CE35BC0885F04F6A = 0;
    self waittill("rotatedone");
  }
}

_id_0B238F204E31EF89() {
  level endon("pipe_room_done");

  if(!isDefined(self.target)) {
    return;
  }
  self._id_85CC286ED5BA0688 = getEnt(self.target, "targetname");

  for(;;) {
    self._id_85CC286ED5BA0688 waittill("trigger", player);

    if(self._id_CE35BC0885F04F6A) {
      player.shouldskipdeathsshield = 1;
      player dodamage(10000, self.origin, self._id_85CC286ED5BA0688, self._id_85CC286ED5BA0688, "MOD_TRIGGER_HURT");
    }

    wait 0.1;
  }
}

delete_fan_blades() {
  _id_664C952D3316DE85 = getEntArray("fan_blades", "targetname");
  _id_31CAF89E35AD5C08 = getEntArray("fan_blade_center", "targetname");

  foreach(_id_60E99F3EF51BD9ED in _id_664C952D3316DE85) {
    _id_60E99F3EF51BD9ED unlink();
    _id_60E99F3EF51BD9ED delete();
  }

  foreach(center in _id_31CAF89E35AD5C08)
  center delete();
}

delete_pipe_ents() {
  wait 0.2;
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("cp_raid1_pipes_cs");
  triggers = getEntArray("steam_trigger", "targetname");
  scripts\engine\utility::array_thread(triggers, ::clean_up_steam_triggers);
  _id_51E791B4D5448C42 = getEntArray("steam_valve", "targetname");
  scripts\engine\utility::array_thread(_id_51E791B4D5448C42, ::delete_ent);
  _id_526D28D8642C8C69 = getEntArray("pipe_room_respawn_point", "targetname");
  scripts\engine\utility::array_thread(_id_526D28D8642C8C69, ::delete_ent);

  foreach(ent in level.fx_ents) {
    if(isDefined(ent))
      ent delete();
  }
}

clean_up_steam_triggers() {
  _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(struct in _id_5D99A225CB875DDA)
  struct thread clean_up_steam();

  wait 0.1;
  self delete();
}

clean_up_steam() {
  self notify("shutoff");
}

delete_ent() {
  self delete();
}

pipe_room_dogtag_revive(downed_player) {
  _id_E0CBA2B0A5510D09 = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  timer = 5;
  _id_19F0135BD917C05D = getdvarint("dvar_B4B6597A66C1EC75", 0);

  if(_id_19F0135BD917C05D != 0)
    timer = _id_19F0135BD917C05D;

  wait(timer);

  foreach(key, value in downed_player.br_ammo)
  downed_player.br_ammo[key] = 0;

  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

get_pipe_room_spawnpoint() {
  _id_89770FE705541944 = scripts\engine\utility::getStructArray("pipe_room_player_spawns", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8])) {
        self.respawn_index = _id_AC0E594AC96AA3A8;
        self.shouldskiplaststand = 1;
        level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
      }

      return level.player_respawn[_id_AC0E594AC96AA3A8];
    }
  }
}

respawn_trigger_think() {
  self endon("death");
  level endon("pipe_room_done");

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8])
          player.respawn_index = _id_AC0E594AC96AA3A8;
      }
    }

    if(level.player_respawn[player.respawn_index] != self)
      player thread _id_18AF78602B67B70C::set_respawn_loc_delayed(self);

    waitframe();
  }
}

_id_8746FC82D50AE977() {
  if(getdvarint("dvar_1CE0FCB456F5CFA2", 0) > 0) {
    return;
  }
  _id_B00C4E905E76C87A = _id_C6858AA109C9D708("pipe_room_lift");
  _id_8F13CD2671D5152C = getdvarint("dvar_278B0435EF9518EE", 6);
  _id_F60F53F75958341C = _id_18AF78602B67B70C::_id_050326CC21187D35("pipe_lift_button1", &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
  _id_F60F56F759583AB5 = _id_18AF78602B67B70C::_id_050326CC21187D35("pipe_lift_button2", &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
  level thread _id_A026959271A5B5E8(_id_B00C4E905E76C87A, 10, 1, "pipelift_lowmark", "pipelift_highmark", [_id_F60F53F75958341C, _id_F60F56F759583AB5], 0);
}

_id_C6858AA109C9D708(_id_92C4DE821390F609) {
  _id_222BBC8DE3DC3237 = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  _id_B00C4E905E76C87A = _id_222BBC8DE3DC3237[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_222BBC8DE3DC3237.size; _id_AC0E594AC96AA3A8++)
    _id_222BBC8DE3DC3237[_id_AC0E594AC96AA3A8] linkTo(_id_B00C4E905E76C87A);

  _id_67F14F8315CB0F2F = strtok(_id_92C4DE821390F609, "_");
  _id_EC563CFBB6350492 = getEnt("lift_trigger_" + _id_67F14F8315CB0F2F[_id_67F14F8315CB0F2F.size - 1], "script_noteworthy");

  if(isDefined(_id_EC563CFBB6350492))
    _id_B00C4E905E76C87A._id_EC563CFBB6350492 = _id_EC563CFBB6350492;

  _id_B00C4E905E76C87A.soundent = spawn("script_model", _id_B00C4E905E76C87A.origin);
  _id_B00C4E905E76C87A.soundent setModel("tag_origin");
  _id_B00C4E905E76C87A.soundent linkTo(_id_B00C4E905E76C87A);
  return _id_B00C4E905E76C87A;
}

_id_A026959271A5B5E8(_id_45C63E44E80A73DE, _id_1D9A4729A1DE52F0, _id_A43BF672B2E17585, _id_516807205A2E442D, _id_975676FB871A2301, _id_1AF980F72D516C94, _id_42044BD42909B8CF) {
  level endon("game_ended");
  level endon("cleanup_pipe_room");
  _id_F7F117B99ADCD32C = scripts\engine\utility::getStruct(_id_975676FB871A2301, "script_noteworthy");
  _id_7C88A5C1980A7558 = scripts\engine\utility::getStruct(_id_516807205A2E442D, "script_noteworthy");
  _id_45C63E44E80A73DE._id_6B7F7DC18AA04441 = _id_7C88A5C1980A7558.origin;
  _id_45C63E44E80A73DE._id_E72EEFB98DC16485 = (_id_7C88A5C1980A7558.origin[0], _id_7C88A5C1980A7558.origin[1], _id_F7F117B99ADCD32C.origin[2]);
  _id_45C63E44E80A73DE._id_4D12D9153651CB6D = "low";
  _id_D777457DC762CDBD = "pipe_lift_button_pressed";
  level thread _id_345B6C4BAABC923A(_id_1AF980F72D516C94, _id_D777457DC762CDBD);

  for(;;) {
    if(isDefined(_id_1AF980F72D516C94)) {
      level waittill(_id_D777457DC762CDBD, player);

      if(!isPlayer(player)) {
        continue;
      }
      foreach(button in _id_1AF980F72D516C94)
      button makeunusable();
    }

    _id_45C63E44E80A73DE.soundent playSound("scn_cp_elevator_in_use_start");
    _id_45C63E44E80A73DE.soundent playLoopSound("scn_cp_elevator_in_use_lp");

    if(_id_45C63E44E80A73DE._id_4D12D9153651CB6D == "low") {
      _id_45C63E44E80A73DE moveTo(_id_45C63E44E80A73DE._id_E72EEFB98DC16485, _id_1D9A4729A1DE52F0, 0.5, 0.5);
      wait(_id_1D9A4729A1DE52F0 + _id_A43BF672B2E17585);
      _id_45C63E44E80A73DE._id_4D12D9153651CB6D = "high";
    } else {
      _id_45C63E44E80A73DE moveTo(_id_45C63E44E80A73DE._id_6B7F7DC18AA04441, _id_1D9A4729A1DE52F0, 0.5, 0.5);
      wait(_id_1D9A4729A1DE52F0 + _id_A43BF672B2E17585);
      _id_45C63E44E80A73DE._id_4D12D9153651CB6D = "low";
    }

    _id_45C63E44E80A73DE.soundent playSound("scn_cp_elevator_in_use_stop");
    _id_45C63E44E80A73DE.soundent stoploopsound();

    if(isDefined(_id_1AF980F72D516C94)) {
      foreach(button in _id_1AF980F72D516C94)
      button makeusable();
    }
  }
}

_id_345B6C4BAABC923A(_id_1AF980F72D516C94, _id_D777457DC762CDBD) {
  level endon("game_ended");
  level endon("cleanup_pipe_room");

  foreach(button in _id_1AF980F72D516C94)
  button thread _id_883F0188DC82B5AD(button, _id_D777457DC762CDBD);
}

_id_883F0188DC82B5AD(button, notifystring) {
  level endon("game_ended");
  level endon("cleanup_pipe_room");

  for(;;) {
    button waittill("trigger", player);

    if(isPlayer(player)) {
      button playSound("scn_cp_elevator_button_press");
      level notify(notifystring, player);
    }

    waitframe();
    waitframe();
  }
}