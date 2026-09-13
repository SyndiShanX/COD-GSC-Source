/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\nvg.gsc
***********************************************/

runnvg(_id_24AD61B67A4E13E7) {
  if(!istrue(_id_24AD61B67A4E13E7)) {
    if(istrue(level.disable_nvg))
      return;
  }

  if(!isDefined(self.nvg)) {
    self.nvg = spawnStruct();
    self.nvg.lightmeter = 1;
    self.nvg.flir = 0;
    self.nvg._id_F4B7250E0B02733A = 1;
  }

  scripts\cp\utility\player::init_visionsetnight();
  thread track_player_light_meter();

  if(getdvarint("dvar_DA985A4B1321CC60", 0) != 0) {
    thread _id_2B33D97EDE70B8BC();
    return;
  }

  if(getdvarint("dvar_EBCB3F34320B715C", 0) != 0)
    thread _id_B45A0EF34FAAE45B();

  if(scripts\cp\utility::_id_DDAFEF2154FD19BB() || scripts\cp\utility::_id_A3577E8E6C88A56B()) {
    return;
  }
  if(!isai(self))
    _id_3B64EB40368C1450::set("runNVG", "nvg", 1);

  if(!isDefined(self.pers["useNVG"]))
    self.pers["useNVG"] = 0;

  if(!isDefined(self.pers["killstreak_forcedNVGOff"]))
    self.pers["killstreak_forcedNVGOff"] = 0;

  thread nvg_monitor();
}

track_player_light_meter() {
  self endon("stop_tracking_dynolights");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!scripts\engine\utility::ent_flag_exist("in_the_dark"))
    scripts\engine\utility::ent_flag_init("in_the_dark");

  if(isDefined(self.nvg)) {
    self.nvg.prevlightmeter = 1;
    self.nvg.lightmeter = 1;
  }

  _id_67E5C1D8A5710F95 = 1;
  _id_D21883E6746EBA1C = 0;
  thread light_meter_hud();
  _id_F22120FBFFB96467 = 0;
  start = (0, 0, 0);
  _id_CBBFB154C6F4FFFB = 0.45;

  for(;;) {
    _id_CBBFB154C6F4FFFB = 0.1;
    _id_67E5C1D8A5710F95 = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(_id_67E5C1D8A5710F95, _id_CBBFB154C6F4FFFB);

    if(self.nvg.lightmeter < 0.5 && !_id_D21883E6746EBA1C) {
      scripts\engine\utility::ent_flag_set("in_the_dark");
      _id_D21883E6746EBA1C = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && _id_D21883E6746EBA1C) {
      scripts\engine\utility::ent_flag_clear("in_the_dark");
      _id_D21883E6746EBA1C = 0;
    }
  }
}

light_meter_hud() {
  self endon("disconnect");
  level endon("game_ended");
  noise = spawnStruct();
  noise.mag = 0.02;
  noise.period_min = 0.05;
  noise.period_max = 0.15;
  noise.data = [];
  noise.data["old"] = 0;
  noise.data["period"] = 0;
  noise.data["target"] = 0;
  noise.data["val"] = 0;
  noise.data["time"] = 0;
  _id_E7C9C132EE82AD4F = 0;

  for(;;) {
    self.nvg waittill("update_nvg_hud");
    noise needle_noise();
    _id_F665C97965854720 = self.nvg.lightmeter;
    _id_F665C97965854720 = clamp(_id_F665C97965854720, noise.mag, 1 - noise.mag);
    _id_F665C97965854720 = _id_F665C97965854720 + noise.data["val"];
    self setclientomnvar("ui_nvg_light_meter_needle", _id_F665C97965854720);

    if(_id_F665C97965854720 >= 0.9 && is_nvg_on() && !_id_E7C9C132EE82AD4F) {
      self playSound("item_nightvision_lightmeter_warning");
      _id_E7C9C132EE82AD4F = 1;
      continue;
    }

    if(_id_F665C97965854720 < 0.9 && is_nvg_on() && _id_E7C9C132EE82AD4F)
      _id_E7C9C132EE82AD4F = 0;
  }
}

is_nvg_on() {
  return self isnightvisionon();
}

lightmeter_lerp_lightmeter(value, time) {
  curr = self.nvg.lightmeter;

  if(!isDefined(value))
    value = 0;

  if(!isDefined(time))
    time = 0;

  range = value - curr;
  interval = 0.05;
  count = int(time / interval);

  for(_id_3777ECE6A73EADA5 = range / count; count; count--) {
    if(isDefined(self.nvg.prevlightmeter)) {
      self.nvg.prevlightmeter = self.nvg.lightmeter;
      self.nvg.lightmeter = self.nvg.lightmeter + _id_3777ECE6A73EADA5;
    }

    self.nvg notify("update_nvg_hud");
    wait(interval);
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = value;
}

needle_noise() {
  if(self.data["time"] >= self.data["period"]) {
    self.data["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data["old"] = self.data["target"];
    self.data["time"] = 0;
    self.data["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  _id_2E95586C3F064A36 = scripts\engine\math::normalize_value(0, self.data["period"], self.data["time"]);
  _id_2E95586C3F064A36 = scripts\engine\math::_id_889BEF0AD1600791(_id_2E95586C3F064A36);
  self.data["val"] = self.data["old"] * (1 - _id_2E95586C3F064A36) + self.data["target"] * _id_2E95586C3F064A36;
  self.data["time"] = self.data["time"] + 0.05;
}

_id_2B33D97EDE70B8BC() {
  self endon("disconnect");
  self notify("turn_nvgsOnOffDependingOnLight");
  self endon("turn_nvgsOnOffDependingOnLight");

  while(!isDefined(self.operatorcustomization))
    waitframe();

  for(;;) {
    if(self getplayerlightlevel() >= 0.1) {
      if(istrue(self._id_E6692CC0F7DB74AB)) {
        wait 2;

        if(self getplayerlightlevel() >= 0.1) {
          self nightvisionviewoff();
          self._id_E6692CC0F7DB74AB = 0;
          savenvgstate();
          nvg_update3rdperson(0);
        }
      }
    } else if(!istrue(self._id_E6692CC0F7DB74AB)) {
      wait 0.25;

      if(self getplayerlightlevel() < 0.1) {
        self nightvisionviewon();
        self._id_E6692CC0F7DB74AB = 1;
        savenvgstate();
        nvg_update3rdperson(1);
        level notify("player_enabled_nvgs");
      }
    }

    wait 0.25;
  }
}

clearnvg(_id_D82B5FC6A04B17F3) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(_id_D82B5FC6A04B17F3)
      self detach(self.nvg3rdpersonmodel, "j_head");

    self.nvg3rdpersonmodel = undefined;
  }
}

turnoffnvgs() {
  foreach(player in level.players) {
    if(isalive(player))
      player savenvgstate();

    if(player isnightvisionon())
      player nightvisionviewoff();

    player thread removenvg();
  }
}

removenvg() {
  self setactionslot(2, "");
  self notify("nvg_removed");
}

savenvgstate() {
  if(self isnightvisionon())
    self.pers["useNVG"] = 1;
  else if(!self isnightvisionon() && !istrue(self.pers["killstreak_forcedNVGOff"]))
    self.pers["useNVG"] = 0;
}

nvg_monitor() {
  self notify("nvg_monitor");
  self endon("nvg_monitor");
  self endon("disconnect");
  self endon("death");
  self endon("nvg_removed");
  _id_941CDE8837521CFF = gettime();

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_2("night_vision_on", "night_vision_off");

    if(!isDefined(result)) {
      continue;
    }
    savenvgstate();
    enabled = result == "night_vision_on";
    nvg_update3rdperson(enabled);

    if(istrue(enabled)) {
      level notify("player_enabled_nvgs");

      if(getdvarint("dvar_EBCB3F34320B715C", 0) != 0)
        thread _id_B45A0EF34FAAE45B();
    }

    _id_2A3902259F88E70E = gettime();
    duration = _id_2A3902259F88E70E - _id_941CDE8837521CFF;
    _id_941CDE8837521CFF = _id_2A3902259F88E70E;
  }
}

nvg_get3rdpersonupmodel() {
  _id_2626C56CE4ECC11B = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    _id_2626C56CE4ECC11B = level.nvgheadoverrides[self.operatorcustomization.head]["up"];

  if(!isDefined(_id_2626C56CE4ECC11B))
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_1_up";
  else if(_id_2626C56CE4ECC11B == "nvg_2")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_2_up";
  else if(_id_2626C56CE4ECC11B == "nvg_3")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_3_up";
  else if(_id_2626C56CE4ECC11B == "nvg_4")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_3_up";
  else if(_id_2626C56CE4ECC11B == "none")
    _id_2626C56CE4ECC11B = undefined;
  else
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_1_up";

  return _id_2626C56CE4ECC11B;
}

nvg_get3rdpersondownmodel() {
  _id_4E05BAF0BB66C66E = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    _id_4E05BAF0BB66C66E = level.nvgheadoverrides[self.operatorcustomization.head]["down"];

  if(!isDefined(_id_4E05BAF0BB66C66E))
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_1";
  else if(_id_4E05BAF0BB66C66E == "nvg_2")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_2";
  else if(_id_4E05BAF0BB66C66E == "nvg_3")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_3";
  else if(_id_4E05BAF0BB66C66E == "nvg_4")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_4";
  else if(_id_4E05BAF0BB66C66E == "none")
    _id_4E05BAF0BB66C66E = undefined;
  else
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_1";

  return _id_4E05BAF0BB66C66E;
}

nvg_update3rdperson(enabled) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(enabled) {
    _id_4E05BAF0BB66C66E = nvg_get3rdpersondownmodel();

    if(isDefined(_id_4E05BAF0BB66C66E)) {
      self.nvg3rdpersonmodel = _id_4E05BAF0BB66C66E;
      self attach(self.nvg3rdpersonmodel, "j_head");
      return;
    }
  } else {
    _id_2626C56CE4ECC11B = nvg_get3rdpersonupmodel();

    if(isDefined(_id_2626C56CE4ECC11B)) {
      self.nvg3rdpersonmodel = _id_2626C56CE4ECC11B;
      self attach(self.nvg3rdpersonmodel, "j_head");
    }
  }
}

start_with_nvgs() {
  thread give_nvgs_after_delay(2);
}

give_nvgs_after_delay(delay, _id_DCB6B158A9A8D74E) {
  if(scripts\cp\utility::is_wave_gametype())
    self waittill("loadout_given");
  else {
    if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
      scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

    scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  }

  thread show_hint_after_delay(delay / 2, _id_DCB6B158A9A8D74E);
  wait(delay);
  self nightvisionviewon();
  thread nvg_update3rdperson(1);
}

show_hint_after_delay(delay, _id_DCB6B158A9A8D74E) {
  wait(delay);
  time = 5;

  if(isDefined(_id_DCB6B158A9A8D74E) && (isint(_id_DCB6B158A9A8D74E) || isfloat(_id_DCB6B158A9A8D74E)))
    time = _id_DCB6B158A9A8D74E;

  if(self usinggamepad())
    thread scripts\cp\cp_hud_message::tutorialprint(&"MP/PRESS_TO_USE_NVG", time);
  else
    thread scripts\cp\cp_hud_message::tutorialprint(&"MP/PRESS_TO_USE_NVG_KB", time);
}

_id_B45A0EF34FAAE45B() {
  self endon("disconnect");
  self notify("nvg_runScanMechanic");
  self endon("nvg_runScanMechanic");
  self.activate_radar = 0;
  self notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  self notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
  thread scripts\cp\cp_relics::updatescoperadar(self);
}

_id_375575E87D552F1A(_id_997A68D0145B4469) {
  foreach(_id_A234A65C378F3289 in _id_997A68D0145B4469)
  self endon(_id_A234A65C378F3289);

  self waittill("forever");
}

_id_0667CD1010758D81() {
  owner = self;
  position = self.origin;
  angles = self.angles;
  _id_7AA1FF687CFC30D1 = undefined;

  if(1) {
    _id_7AA1FF687CFC30D1 = spawnStruct();
    _id_7AA1FF687CFC30D1.owner = owner;
    _id_7AA1FF687CFC30D1.position = position;
    _id_7AA1FF687CFC30D1.isalive = 1;
    _id_7AA1FF687CFC30D1.targets = [];
    _id_7AA1FF687CFC30D1.endtimes = [];
    _id_7AA1FF687CFC30D1.outlineids = [];
  }

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);

  foreach(player in level.characters) {
    if(!isDefined(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isPlayer(player)) {
      continue;
    }
    _id_8423818ECF85A883 = player.origin - position;
    _id_457471485336C961 = lengthsquared(_id_8423818ECF85A883);

    if(_id_457471485336C961 > 4194304) {
      continue;
    }
    if(1) {
      entnum = player getentitynumber();
      _id_7AA1FF687CFC30D1.targets[entnum] = player;
      _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + 2500;
      _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforall(player, "snapshotgrenade", "equipment");

      if(isPlayer(player))
        player scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);

      _id_7AA1FF687CFC30D1 thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_update_outlines();
    }

    if(0)
      owner thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_create_marker(player gettagorigin("j_spineupper"), player.angles, player);
  }

  if(1)
    triggerportableradarping(position, owner, 2048, 500);
}