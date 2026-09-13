/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\super.gsc
***********************************************/

init_super() {
  _id_584994FAB4A8712B = spawnStruct();
  level.superglobals = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.staticsuperdata = [];
  _id_584994FAB4A8712B.superweapons = [];
  _id_584994FAB4A8712B.supersbyid = [];
  _id_584994FAB4A8712B.supersbyoffhand = [];
  level.superglobals.staticsuperdata["super_recon_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_recon_drone"].id = 11;
  level.superglobals.staticsuperdata["super_tac_cover"] = spawnStruct();
  level.superglobals.staticsuperdata["super_tac_cover"].id = 10;
  level.superglobals.staticsuperdata["super_emp_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_emp_drone"].id = 1;
  level.superglobals.staticsuperdata["super_high_jump"] = spawnStruct();
  level.superglobals.staticsuperdata["super_high_jump"].id = 667;
  level.superglobals.staticsuperdata[""] = spawnStruct();
  level.superglobals.staticsuperdata[""].id = 666;
  registersupers();
  thread _id_FC293489E21293C4();
}

_id_FC293489E21293C4() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Field Upgrade / Fast Recharge\" \"set scr_start_debug super_rechargefast\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Field Upgrade / Normal Recharge\" \"set scr_start_debug super_rechargenormal\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

registersupers() {
  _id_53110A12409D01DA("super_high_jump", undefined, undefined, ::_id_F98D4EC41407BC75, ::_id_975965422D6BCB49, undefined, undefined, undefined);
}

_id_53110A12409D01DA(ref, setfunc, unsetfunc, beginusefunc, endusefunc, _id_E0AF69536A727F03, _id_70B09ED29C10732F, _id_1BB8C2DE6198881A) {
  staticdata = level.superglobals.staticsuperdata[ref];

  if(!isDefined(staticdata)) {
    return;
  }
  staticdata.setfunc = setfunc;
  staticdata.unsetfunc = unsetfunc;
  staticdata.beginusefunc = beginusefunc;
  staticdata.endusefunc = endusefunc;
  staticdata._id_E0AF69536A727F03 = _id_E0AF69536A727F03;
  staticdata._id_70B09ED29C10732F = _id_70B09ED29C10732F;
  staticdata._id_1BB8C2DE6198881A = _id_1BB8C2DE6198881A;

  if(!isDefined(_id_E0AF69536A727F03) && istrue(staticdata._id_FF2E3A3658646A3F))
    staticdata._id_E0AF69536A727F03 = ::_id_97EECCE0124A7B50;
}

_id_F98D4EC41407BC75() {
  return scripts\cp\cp_relics::_id_D45FD98510D7B7E9();
}

_id_975965422D6BCB49(_id_FCEF8D217A441961, attacker) {}

_id_97EECCE0124A7B50() {
  _id_330825804EBBD918(1);
  _id_19163E14365D9264 = getcurrentsuper();
  clipammo = _id_19163E14365D9264.staticdata.useweaponclipammo;
  stockammo = _id_19163E14365D9264.staticdata.useweaponstockammo;

  if(isDefined(_id_19163E14365D9264._id_2EBCBD70919376A7)) {
    clipammo = _id_19163E14365D9264._id_2EBCBD70919376A7.clipammo;
    stockammo = _id_19163E14365D9264._id_2EBCBD70919376A7.stockammo;
  }

  result = trygiveuseweapon(_id_19163E14365D9264.staticdata.useweapon, clipammo, stockammo);

  if(istrue(result))
    _id_330825804EBBD918(1);
  else
    _id_330825804EBBD918(0);

  return result;
}

give_player_super(_id_5DFDD9EEE27DC736, _id_2CBC4002B1724081) {
  if(!isDefined(_id_5DFDD9EEE27DC736))
    _id_5DFDD9EEE27DC736 = "role_tank";

  if(isDefined(self.super) && (isDefined(self.super._id_5237A188CCDA4D7B) && _id_5DFDD9EEE27DC736 == self.super._id_5237A188CCDA4D7B) && !istrue(_id_2CBC4002B1724081)) {
    return;
  }
  clear_player_class_and_super();
  _id_1F8539B231E93107(_id_5DFDD9EEE27DC736);
  thread update_super_icon(_id_5DFDD9EEE27DC736);

  switch (self.super._id_5237A188CCDA4D7B) {
    case "role_medic":
      thread give_team_auto_revive();
      break;
    case "role_tank":
      thread give_team_armor_buff();
      break;
    case "role_assault":
      break;
    case "role_demolition":
      thread give_thermite_launcher();
      break;
    case "role_hunter":
      thread give_scout_drone();
      break;
    case "role_engineer":
      thread giv_emp_drone();
      break;
  }

  thread init_super_for_player("super_default_zm");
}

clear_player_class_and_super() {}

give_player_class_abilities() {
  clear_player_class_and_super();
}

update_super_icon(super) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  set_omnvar_for_icon(super);
  self setclientomnvar("cp_loadout_changed", 0);
  wait 2;
  self setclientomnvar("cp_loadout_changed", 1);
}

set_omnvar_for_icon(super) {
  omnvar = int(tablelookup("cp/cp_fieldupgrades.csv", 1, super, 0));
  self setclientomnvar("ui_field_upgrade_icon", omnvar);
}

init_super_for_player(super) {
  give_super_weapon(super);
  thread give_super_ammo_after_loadout_given(super);
  thread watch_for_super_button(super);
}

watch_for_super_ammo_depleted(super) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_super_watcher");

  for(;;) {
    _id_8BBC2903A2793B49 = self getammocount(super);

    if(_id_8BBC2903A2793B49 == 0)
      self setweaponammoclip(super, 1);

    wait 0.1;
  }
}

_id_C5EA07DAC9D83685() {
  setomnvar("ui_class_power_ready", -1);
  setomnvar("ui_class_power_inuse", -1);
  setomnvar("ui_class_power_reloading", -1);
}

give_super_weapon(super) {
  self giveweapon(super);
  self assignweaponoffhandspecial(super);
  self.specialoffhandgrenade = super;
  self setweaponammoclip(super, 1);
  _id_C5EA07DAC9D83685();
}

give_super_ammo_after_loadout_given(super) {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  self setweaponammoclip(super, 1);
}

watch_for_super_button(super) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("end_super_watcher");
  self endon("end_super_watcher");
  self.super_ready = 0;
  thread recharge_super(super);
  thread watch_for_super_ammo_depleted(super);
  self setclientomnvar("ui_super_progress", 0);
  self setclientomnvar("cp_super_ready", 0);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  for(;;) {
    self waittill("special_weapon_fired", objweapon);

    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
      scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      self setweaponammoclip(super, 1);
      continue;
    }

    _id_637DE03F2C6B6C33 = objweapon;

    if(isweapon(objweapon))
      _id_637DE03F2C6B6C33 = getcompleteweaponname(objweapon);

    if(_id_637DE03F2C6B6C33 == super) {
      fail = 0;

      if(!self.super_ready)
        fail = 1;
      else if(istrue(self.inlaststand))
        fail = 1;
      else if(istrue(self.disable_super))
        fail = 1;
      else if(istrue(level.regroup_process_started))
        fail = 1;
      else if(istrue(self.interrogating))
        fail = 1;
      else if(_id_74502A9E0EF1F19C::player_has_minigun(self))
        fail = 1;
      else if(!istrue(self isonground()))
        fail = 1;
      else if(istrue(self._id_23A6763562820C70))
        fail = 1;

      if(isDefined(level.can_use_super_func) && ![[level.can_use_super_func]](self))
        fail = 1;

      if(!fail)
        thread fire_super(super);
      else
        scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
    }

    self setweaponammoclip(super, 1);
  }
}

fire_super(super) {
  self.super_ready = 0;
  self setclientomnvar("cp_super_ready", 0);
  self setclientomnvar("ui_super_state", 3);
  setsuperisinuse(1);
  _id_FA603D3B6BE45842 = getcurrentsuperref();

  if(isDefined(_id_FA603D3B6BE45842))
    scripts\cp\cp_analytics::logevent_superused(self, _id_FA603D3B6BE45842);

  thread display_super_fired_splash();
  run_super_loop(super);
  self setclientomnvar("ui_super_state", 4);
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  setsuperisinuse(0);
  self setclientomnvar("cp_super_fired", 0);
  self.super_ready = 0;

  if(istrue(level._id_5EBDA93137C97B1C)) {
    self.disable_super = 1;
    thread update_super_icon("none");
  }
}

issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

getcurrentsuperref() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264))
    return undefined;

  return _id_19163E14365D9264.staticdata.ref;
}

getcurrentsuper() {
  return self.super;
}

setsuperisinuse(isinuse) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.isinuse = isinuse;
  updatesuperuistate();
}

updatesuperuistate() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(!isDefined(_id_19163E14365D9264.isactive)) {
    return;
  }
  if(!isalive(self)) {
    _id_19163E14365D9264.state = undefined;
    return;
  }

  _id_38149715B031CF37 = _id_19163E14365D9264.state;
  state = 1;

  if(issuperexpended())
    state = 4;
  else if(issuperready())
    state = 2;
  else if(issuperinuse())
    state = 3;

  if(!isDefined(_id_38149715B031CF37) || state != _id_38149715B031CF37)
    self setclientomnvar("ui_super_state", state);

  _id_19163E14365D9264.state = state;
}

issuperexpended() {
  return istrue(self.pers["superExpended"]);
}

issuperready() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || _id_19163E14365D9264.isinuse)
    return 0;

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

getcurrentsuperpoints() {
  _id_19163E14365D9264 = getcurrentsuper();
  return _id_19163E14365D9264.basepoints + _id_19163E14365D9264.extrapoints;
}

getsuperpointsneeded() {
  _id_19163E14365D9264 = getcurrentsuper();
  pointsneeded = _id_19163E14365D9264.staticdata.pointsneeded;

  if(!isDefined(pointsneeded))
    pointsneeded = 0;

  if(isDefined(_id_19163E14365D9264.overridepointsneeded))
    pointsneeded = _id_19163E14365D9264.overridepointsneeded;

  return pointsneeded;
}

_id_32D75C33471450D3() {
  _id_17A208DE8E7CD188 = _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();

  if(!isDefined(_id_17A208DE8E7CD188))
    return undefined;

  switch (_id_17A208DE8E7CD188) {
    case "kitAssault":
      return 180;
    case "kitMedic":
      return 90;
    case "kitRecon":
      return 60;
  }

  return undefined;
}

recharge_super(super) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_super_watcher");
  self setclientomnvar("ui_super_state", 1);
  _id_1D940AAD29A009B2 = _id_32D75C33471450D3();
  _id_21FB8A21B88A9A93 = getdvarint("dvar_B0C572AB1605350A", 0);

  if(_id_21FB8A21B88A9A93)
    _id_1D940AAD29A009B2 = _id_21FB8A21B88A9A93;

  if(istrue(self.role_edit)) {
    if(!isDefined(self.super_progress))
      self.super_progress = 890;
    else if(self.super_progress > 996)
      self.super_progress = 997;

    self.role_edit = undefined;
  } else
    self.super_progress = 890;

  starttime = gettime();
  _id_B4C04337A6A90C84 = starttime;

  for(;;) {
    _id_21FB8A21B88A9A93 = getdvarint("dvar_B0C572AB1605350A", 0);

    if(_id_21FB8A21B88A9A93)
      _id_1D940AAD29A009B2 = _id_21FB8A21B88A9A93;
    else
      _id_1D940AAD29A009B2 = _id_32D75C33471450D3();

    paused = 0;
    _id_6B7BEE46F2C6DA28 = gettime();

    if(istrue(self.super_activated))
      paused = 1;
    else if(istrue(self.inlaststand))
      paused = 1;
    else if(istrue(self.super_ready))
      paused = 1;
    else if(istrue(self.disable_super))
      paused = 1;

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete"))
      paused = 1;

    if(paused) {
      _id_B4C04337A6A90C84 = _id_6B7BEE46F2C6DA28;
      waitframe();
      continue;
    }

    _id_FBD43DA47D8CECDF = _id_6B7BEE46F2C6DA28 - _id_B4C04337A6A90C84;

    if(isDefined(_id_1D940AAD29A009B2)) {
      amount = _id_FBD43DA47D8CECDF / (_id_1D940AAD29A009B2 * 1000) * 1000;
      amount = amount * _id_6E09A830FAB9468F::get_perk("super_fill_scalar");
      increase_super_progress(amount);
    }

    progress = self.super_progress / 1000;

    if(progress > 0.998)
      progress = 1.0;

    self setclientomnvar("ui_super_progress", progress);
    _id_B4C04337A6A90C84 = _id_6B7BEE46F2C6DA28;

    if(progress >= 1) {
      self notify("super_ready");
      self.super_ready = 1;
      self setclientomnvar("cp_super_ready", 1);
      self setclientomnvar("ui_super_state", 2);

      if(self getclientomnvar("ui_cp_bink_overlay_state") == 0)
        display_super_ready_splash();
    }

    waitframe();
  }
}

display_super_ready_splash() {
  if(istrue(self._id_76FDC69357652407)) {
    return;
  }
  if(!istrue(self.super_displayed)) {
    self.super_displayed = 1;
    return;
  }

  if(self usinggamepad()) {
    _id_1B4ADA49A21B51CA = "super_revive";

    switch (self._id_698900C6211CC03C._id_1C7DBF040C780003) {
      case "kitMedic":
        _id_1B4ADA49A21B51CA = "cp_super_revive";
        break;
      case "kitAssault":
        _id_1B4ADA49A21B51CA = "cp_super_armor";
        break;
      case "kitRecon":
        _id_1B4ADA49A21B51CA = "cp_super_snapshot_pulse";
    }
  } else {
    _id_1B4ADA49A21B51CA = "cp_super_revive_kbm";

    switch (self._id_698900C6211CC03C._id_1C7DBF040C780003) {
      case "kitMedic":
        _id_1B4ADA49A21B51CA = "cp_super_revive_kbm";
        break;
      case "kitAssault":
        _id_1B4ADA49A21B51CA = "cp_super_armor_kbm";
        break;
      case "kitRecon":
        _id_1B4ADA49A21B51CA = "cp_super_snapshot_pulse_kbm";
    }
  }

  _id_C5EA07DAC9D83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_ready", clientnum);
  thread scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
}

display_super_fired_splash() {
  self endon("disconnect");
  _id_1B4ADA49A21B51CA = "super_revive_used";
  _id_C5EA07DAC9D83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_inuse", clientnum);
  self setclientomnvar("cp_super_fired", 1);
  wait 6;
  self setclientomnvar("cp_super_fired", 0);
}

increase_super_progress(amount) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      if(isDefined(self.super_progress_scalar))
        amount = amount * self.super_progress_scalar;

      self.super_progress = self.super_progress + amount;

      if(self.super_progress > 1000)
        self.super_progress = 1000;
    }
  }
}

drain_super_meter(time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("end_super_meter_early");
  thread set_progress_to_zero_on_death();
  self.super_meter_draining = 1;
  clientnum = self getentitynumber();
  starttime = gettime();
  _id_B4C04337A6A90C84 = starttime;
  _id_B28845CFB5A6978B = 1.0;

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_FBD43DA47D8CECDF = _id_6B7BEE46F2C6DA28 - _id_B4C04337A6A90C84;
    amount = _id_FBD43DA47D8CECDF / (time * 1000);
    _id_B28845CFB5A6978B = _id_B28845CFB5A6978B - amount;

    if(_id_B28845CFB5A6978B < 0)
      _id_B28845CFB5A6978B = 0;

    self setclientomnvar("ui_super_progress", _id_B28845CFB5A6978B);
    _id_B4C04337A6A90C84 = _id_6B7BEE46F2C6DA28;
    waitframe();

    if(_id_B28845CFB5A6978B <= 0) {
      self.super_progress = 0;
      self notify("meter_drained");
      break;
    }
  }

  _id_E05E59B00CE25F0F = _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();
  _id_C5EA07DAC9D83685();

  switch (_id_E05E59B00CE25F0F) {
    case "kitAssault":
    case "kitMedic":
    case "kitRecon":
      setomnvar("ui_class_power_reloading", clientnum);
      break;
  }

  self.super_meter_draining = 0;
}

set_progress_to_zero_on_death() {
  self endon("meter_drained");
  self waittill("death");
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self setclientomnvar("cp_super_fired", 0);
}

end_super_meter_progress_early() {
  self notify("end_super_meter_early");
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self.super_meter_draining = 0;
}

run_super_loop(super) {
  if(isDefined(self.super_activate_func))
    self[[self.super_activate_func]]();

  while(istrue(self.super_activated))
    wait 0.1;
}

give_scout_drone() {
  _id_674934B4DB05639A(::activate_scout_drone);
}

give_team_armor_buff() {
  _id_674934B4DB05639A(::activate_team_armor_buff);
  self.super_progress_scalar = 0.25;
}

give_thermite_launcher() {
  _id_674934B4DB05639A(::activate_thermite_launcher);
  self.super_progress_scalar = 0.5;
}

give_team_auto_revive() {
  _id_674934B4DB05639A(::activate_team_auto_revive);
  self.super_progress_scalar = 0.25;
}

give_team_stopping_power() {
  _id_674934B4DB05639A(::activate_team_stopping_power);
}

giv_emp_drone() {
  if(isDefined(level.activate_emp_drone_func))
    _id_674934B4DB05639A(level.activate_emp_drone_func);
  else
    _id_674934B4DB05639A(::activate_emp_drone);
}

activate_thermite_launcher() {
  self.super_activated = 1;
  self.gl_proj_override = "thermite";

  if(_id_74502A9E0EF1F19C::player_has_minigun(self)) {
    _id_74502A9E0EF1F19C::drop_minigun(self);
    self waittill("weapon_change");

    if(istrue(self.inlaststand)) {
      self.super_activated = 0;
      return;
    }
  }

  _id_644C18834356D9DC::givegrenadelauncher();
  thread drain_super_meter(1);
  scripts\cp\cp_analytics::logevent_superused(self, "thermite_launcher");
  self setclientomnvar("ui_thermite_class_power_on", gettime());
  clientnum = self getentitynumber();
  _id_1B4ADA49A21B51CA = "cp_super_cluster_used";

  foreach(player in level.players)
  player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);

  while(istrue(self.has_gl))
    self waittill("weapon_removed");

  _id_C5EA07DAC9D83685();
  setomnvar("ui_class_power_reloading", clientnum);
  self setclientomnvar("ui_thermite_class_power_off", gettime());
  self.gl_proj_override = undefined;
  self.super_activated = 0;
}

team_unlimited_ammo() {
  foreach(player in level.players) {
    player.has_infinite_ammo = 1;
    ammo = ammo_round_up();
    player thread unlimited_ammo(ammo);
  }
}

activate_scout_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  self._id_2332678633FE1728 = 1;
  thread listen_for_drone_ent();
  success = _id_6D68CFDF0836123C::recondrone_beginsuper();

  if(success) {
    msg = scripts\engine\utility::waittill_any_return_3("super_use_succeeded", "super_use_failed", "laststand");

    if(msg == "super_use_succeeded") {
      _id_1B4ADA49A21B51CA = "cp_super_mark_used";

      foreach(player in level.players)
      player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);

      scripts\cp\cp_analytics::logevent_superused(self, "scout drone");
      thread drain_super_meter(1);
      wait_until_done();
      return;
    }

    self.super_activated = 0;
    self._id_2332678633FE1728 = 0;
    return;
  } else {
    self.super_activated = 0;
    self._id_2332678633FE1728 = 0;
  }
}

listen_for_drone_ent() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", drone);
  _id_476B6443E3798F5E::_id_B0637EFA07AB9DF9(drone, "killstreak");
  self.scout_drone = drone;
  self _meth_FD165588822885F4(drone);
}

wait_until_done() {
  clientnum = self getentitynumber();
  thread waittill_drone_timeout(5);
  waittill_drone_defined();

  while(isDefined(self.scout_drone))
    waitframe();

  _id_C5EA07DAC9D83685();
  setomnvar("ui_class_power_reloading", clientnum);
  self.super_activated = 0;
  self._id_2332678633FE1728 = 0;
}

waittill_drone_defined() {
  self endon("scout_drone_timeout");

  while(!isDefined(self.scout_drone))
    wait 0.1;

  self notify("scout_drone_timeout");
}

waittill_drone_timeout(timer) {
  self endon("scout_drone_timeout");
  wait(timer);
  self notify("scout_drone_timeout");
}

superusefinished(_id_3179AFAA208DEFA2, _id_FCEF8D217A441961, _id_E68637FB8C1C346B, _id_E743A22765D93795) {
  self notify("super_use_finished_lb");

  if(istrue(_id_3179AFAA208DEFA2))
    self notify("super_use_failed");
  else
    self notify("super_use_succeeded");

  self notify("super_use_finished");
}

ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  ammo = [];

  foreach(weapon in self.weaponlist)
  ammo[getcompleteweaponname(weapon)] = self getammocount(weapon);

  return ammo;
}

unlimited_ammo(ammo) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_unlimited_ammo");

  if(!isDefined(self.weaponlist))
    self.weaponlist = self getweaponslistprimaries();

  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_infinite_ammo)) {
    _id_76D0240AC996CA7B = 0;

    foreach(index in self.weaponlist) {
      _id_1903A4E1B4C39DE1 = weaponclipsize(index);

      if(index == self getcurrentweapon() && weapon_no_unlimited_check(index)) {
        _id_76D0240AC996CA7B = 1;

        if(_id_1903A4E1B4C39DE1 == 1) {
          _id_749FFCD446F2CFA0 = self getweaponammostock(index);
          _id_749FFCD446F2CFA0++;
          self setweaponammostock(index, _id_749FFCD446F2CFA0);
        } else
          self setweaponammoclip(index, weaponclipsize(index), "left");
      }

      if(index == self getcurrentweapon() && weapon_no_unlimited_check(index)) {
        _id_76D0240AC996CA7B = 1;
        self setweaponammoclip(index, weaponclipsize(index), "right");
      }

      if(_id_76D0240AC996CA7B == 0)
        ammo_round_up();
    }

    wait 0.05;
  }
}

weapon_no_unlimited_check(weapon) {
  _id_76D0240AC996CA7B = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(_id_C8F89C941CF44FEE in level.opweaponsarray) {
      if(weapon.basename == _id_C8F89C941CF44FEE)
        _id_76D0240AC996CA7B = 0;
    }
  }

  return _id_76D0240AC996CA7B;
}

activate_team_auto_revive(amount) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  _id_1B4ADA49A21B51CA = "cp_super_revive_used";
  _id_C98F63203DEA02CF = 0;

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      if(isDefined(player.last_stand_state) && player.last_stand_state == "bleed_out") {
        continue;
      }
      player thread team_instant_revive();
      player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
      _id_0AFB7E332AEE4BF2::record_revive_success(self, player);
      _id_C98F63203DEA02CF = 1;
    }
  }

  if(_id_C98F63203DEA02CF) {
    scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
    scripts\cp\cp_analytics::logevent_superused(self, "team auto-revive");
    drain_super_meter(1);
  }

  self.super_activated = 0;
}

team_instant_revive() {
  if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
    if(!isDefined(self.dogtag)) {
      self.using_self_revive = 1;
      self giveandfireoffhand("adrenaline_mp");

      if(isDefined(self.reviveiconent)) {
        _id_0AFB7E332AEE4BF2::set_revive_icon_color(self.reviveiconent);
        self.reviveent makeunusable();
      }

      wait 3;
      _id_0AFB7E332AEE4BF2::instant_revive(self);
      self.using_self_revive = undefined;
    }
  }
}

deactivate_instant_revive(amount) {
  level endon("disconnect");
  level endon("game_ended");
  result = scripts\engine\utility::waittill_any_timeout_1(amount, "force_end_super");
  self notify("stop_instant_revive");
  self.has_instant_revive = undefined;
  self.perk_data["revive_time_scalar"] = self.old_revive_time_scalar;
}

aoe_instant_revive(timer) {
  self endon("stop_instant_revive");
  self endon("death");
  dist = 100;
  _id_ABD9EE4725B96FC2 = dist * dist;
  end_time = gettime() + timer * 1000;

  while(gettime() < end_time) {
    foreach(player in level.players) {
      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        if(distancesquared(self.origin, player.origin) < _id_ABD9EE4725B96FC2) {
          player _id_0AFB7E332AEE4BF2::instant_revive(player);

          if(isDefined(player.dogtag))
            player.dogtag delete();
        }
      }
    }

    wait 0.1;
  }
}

activate_team_armor_buff() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  turn_on_team_armor_buff();
  scripts\cp\cp_analytics::logevent_superused(self, "team armor");
  thread deactivate_team_armor_buff(20);
  drain_super_meter(1);
  self.super_activated = 0;
}

turn_on_team_armor_buff() {
  _id_C791EAD1F39669F4 = 100;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  _id_1B4ADA49A21B51CA = "cp_super_armor_used";

  foreach(player in level.players) {
    if(on_the_same_team(self, player) && isalive(player)) {
      player.has_team_armor = 1;
      scripts\cp\cp_armor::givearmor(player, _id_C791EAD1F39669F4, 1);
      player.old_armor_scalar = player _id_6E09A830FAB9468F::get_perk("enemy_damage_to_player_armor_scalar");
      player _id_6E09A830FAB9468F::set_perk("enemy_damage_to_player_armor_scalar", player.old_armor_scalar * 1.5);
      player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
    }

    player setclientomnvar("ui_armor_class_power_used", 1);
  }
}

on_the_same_team(_id_35892088904EB273, _id_B147B9882EBDBD7D) {
  if(isDefined(_id_35892088904EB273.team_number) && isDefined(_id_B147B9882EBDBD7D.team_number))
    return _id_35892088904EB273.team_number == _id_B147B9882EBDBD7D.team_number;
  else
    return 1;
}

remove_team_armor_buff() {
  foreach(player in level.players) {
    if(on_the_same_team(self, player)) {
      player.has_team_armor = undefined;
      player _id_6E09A830FAB9468F::set_perk("enemy_damage_to_player_armor_scalar", player.old_armor_scalar);
    }
  }
}

deactivate_team_armor_buff(amount) {
  level endon("disconnect");
  level endon("game_ended");
  clientnum = self getentitynumber();
  result = scripts\engine\utility::waittill_any_timeout_1(amount, "force_end_super");
  _id_C5EA07DAC9D83685();
  setomnvar("ui_class_power_reloading", clientnum);

  foreach(player in level.players)
  player setclientomnvar("ui_armor_class_power_used", 0);

  remove_team_armor_buff();
}

activate_team_stopping_power() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  scripts\cp\cp_analytics::logevent_superused(self, "team stopping_power");
  _id_1B4ADA49A21B51CA = "cp_super_ammo_used";

  foreach(player in level.players) {
    player give_full_stoppingpower_clip();
    player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
  }

  drain_super_meter(1);

  foreach(player in level.players)
  self setclientomnvar("ui_ammo_class_power_on", gettime());

  self.super_activated = 0;
}

give_full_stoppingpower_clip() {
  weapon = scripts\cp\utility::getvalidtakeweapon();
  _id_A7BE10E54A3A4B99 = weaponclipsize(weapon);
  self setweaponammoclip(weapon, _id_A7BE10E54A3A4B99);
  thread watch_bullet_count(weapon, _id_A7BE10E54A3A4B99);
}

watch_bullet_count(weapon, _id_A7BE10E54A3A4B99) {
  self endon("disconnect");
  thread remove_on_death();
  thread stoppingpower_watchhcrweaponchange(weapon);
  thread stoppingpower_watchhcrweaponfire(weapon, _id_A7BE10E54A3A4B99);
  self waittill("stoppingPower_removeHCR");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

remove_on_death() {
  self waittill("death");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

stoppingpower_watchhcrweaponchange(weapon) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.gavehcr = 0;

  while(self hasweapon(weapon)) {
    if(self getcurrentweapon() == weapon) {
      if(!self.gavehcr) {
        scripts\cp\utility::giveperk("specialty_bulletdamage");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      scripts\cp\utility::takeperk("specialty_bulletdamage");
      self.gavehcr = 0;
    }

    self waittill("weapon_change");
  }

  foreach(player in level.players)
  self setclientomnvar("ui_ammo_class_power_off", gettime());

  self notify("stoppingPower_removeHCR");
}

stoppingpower_watchhcrweaponfire(weapon, amount) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = amount;
  thread stoppingpower_watchhcrammodrain(weapon, amount);

  while(self hasweapon(weapon)) {
    self waittill("weapon_fired", objweapon);

    if(objweapon == weapon) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  foreach(player in level.players)
  self setclientomnvar("ui_ammo_class_power_off", gettime());

  self notify("stoppingPower_removeHCR");
}

stoppingpower_watchhcrammodrain(weapon, amount) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = amount;

  while(self hasweapon(weapon)) {
    self waittill("ammo_drained");
    self.rounds--;

    if(self.rounds <= 0) {
      break;
    }
  }

  foreach(player in level.players)
  self setclientomnvar("ui_ammo_class_power_off", gettime());

  self notify("stoppingPower_removeHCR");
}

allowsuperweaponstow() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || !_id_19163E14365D9264.isinuse) {
    return;
  }
  _id_19163E14365D9264.canstow = 1;
}

_id_9105217782A39139(_id_19163E14365D9264) {
  _id_A7BE10E54A3A4B99 = weaponmaxammo(_id_19163E14365D9264.staticdata.useweapon);
  _id_F49F1F75577FA9B1 = 0;
  _id_F49F1F75577FA9B1 = _id_F49F1F75577FA9B1 + _id_19163E14365D9264.staticdata.useweaponclipammo;
  _id_F49F1F75577FA9B1 = _id_F49F1F75577FA9B1 + min(_id_A7BE10E54A3A4B99, _id_19163E14365D9264.staticdata.useweaponstockammo);
  return 1 / _id_F49F1F75577FA9B1;
}

reducesuperusepercent(_id_631A8A84E35497BB, _id_1E71E1F458960B93, _id_80BD4DD71B59356B) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.usepercent = max(_id_19163E14365D9264.usepercent - _id_631A8A84E35497BB, 0.0);

  if(istrue(_id_1E71E1F458960B93))
    _id_19163E14365D9264.allowrefund = 0;

  if(!isDefined(_id_80BD4DD71B59356B) || _id_80BD4DD71B59356B == 0)
    superusedurationupdated();
}

superusedurationupdated() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(_id_19163E14365D9264.usepercent <= 0.0)
    superusefinished();
}

getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

updatesuperuiprogress() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264)) {
    return;
  }
  if(scripts\cp\utility\player::isinkillcam() || !isalive(self)) {
    _id_19163E14365D9264.oldprogress = undefined;
    return;
  }

  progress = 0.0;

  if(_id_19163E14365D9264.isinuse)
    progress = getsuperuseuiprogress();
  else {
    pointsneeded = getsuperpointsneeded();
    progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0.0, 1.0);
  }

  if(!isDefined(_id_19163E14365D9264.oldprogress) || progress != _id_19163E14365D9264.oldprogress)
    self setclientomnvar("ui_super_progress", progress);

  self setplayersupermeterprogress(progress);
  _id_19163E14365D9264.oldprogress = progress;
}

getsuperuseuiprogress() {
  _id_19163E14365D9264 = getcurrentsuper();
  return _id_19163E14365D9264.usepercent;
}

_id_C4C44E009D4F4C6B() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264.staticdata.useweapon) || _id_19163E14365D9264.staticdata.useweaponclipammo < 1) {
    return;
  }
  if(istrue(_id_19163E14365D9264.staticdata._id_FF2E3A3658646A3F))
    allowsuperweaponstow();

  _id_0569D925E5A25DF1 = _id_9105217782A39139(_id_19163E14365D9264);
  reducesuperusepercent(0.001);
  updatesuperuiprogress();
  updatesuperuistate();

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(issameweapon(objweapon, _id_19163E14365D9264.staticdata.useweapon, 1)) {
      reducesuperusepercent(_id_0569D925E5A25DF1);
      updatesuperuiprogress();
      updatesuperuistate();
    }
  }
}

_id_15FE9C03174D698D() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264.staticdata.usetime)) {
    return;
  }
  for(;;) {
    waitframe();
    success = 0;

    if(!_id_C3479770FFEC05E2() && issuperinuse() && !isbot(self)) {
      if(scripts\engine\utility::is_player_gamepad_enabled()) {
        self notifyonplayercommand("tacButtonPress", "+smoke");
        self notifyonplayercommand("fragButtonPress", "+frag");
        thread _id_8D6D95114B2C9B0D(["tacButtonPress", "fragButtonPress"], [], 0.75);
        self waittill("controllerSuperPress", msg);

        if(msg == "success")
          success = 1;
      } else {
        self notifyonplayercommand("specialRepeat", "+special");
        self waittill("specialRepeat");
        success = 1;
      }

      if(success)
        _id_ADA5045140EE0FDF();
    }
  }
}

_id_ADA5045140EE0FDF() {
  if(!isalive(self))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  if(scripts\cp\utility::isusingremote())
    return 0;

  _id_19163E14365D9264 = getcurrentsuper();

  if(isDefined(_id_19163E14365D9264.staticdata._id_E0AF69536A727F03))
    [[_id_19163E14365D9264.staticdata._id_E0AF69536A727F03]]();
}

switchandtakesuperuseweapon() {
  self endon("death");
  _id_19163E14365D9264 = getcurrentsuper();
  useweapon = _id_19163E14365D9264.staticdata.useweapon;

  if(!isDefined(useweapon)) {
    return;
  }
  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(useweapon)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
    return;
  }

  self notify("super_switched");
  scripts\cp_mp\utility\inventory_utility::getridofweapon(useweapon);
}

trygiveuseweapon(useweapon, clipammo, stockammo) {
  self endon("death_or_disconnect");
  scripts\cp\utility::_giveweapon(useweapon);
  self setweaponammoclip(useweapon, clipammo);
  self setweaponammostock(useweapon, stockammo);
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon, isbot(self));

  if(_id_41BF9BF4918115AC) {
    thread _id_573F49BB5D5A86EA(useweapon);
    return 1;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
  return 0;
}

_id_FF3B77706565DACF(useweapon, _id_DD515FCF025B2E79) {
  if(!issameweapon(useweapon, _id_DD515FCF025B2E79, 1) && _id_DD515FCF025B2E79.basename != "iw9_knifestab_mp" && _id_DD515FCF025B2E79.basename != "iw9_lm_dblmg_execution_mp")
    return 1;
  else
    return 0;
}

_id_573F49BB5D5A86EA(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self waittill("weapon_change", useweapon);

  for(;;) {
    self waittill("weapon_change", _id_DD515FCF025B2E79);
    weapon = self getcurrentweapon();

    if(_id_FF3B77706565DACF(useweapon, _id_DD515FCF025B2E79)) {
      clipammo = self getweaponammoclip(useweapon);
      stockammo = self getweaponammostock(useweapon);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(useweapon);
      _id_330825804EBBD918(0);

      if(scripts\engine\utility::is_player_gamepad_enabled()) {
        self notifyonplayercommand("tacButtonPress", "+smoke");
        self notifyonplayercommand("fragButtonPress", "+frag");
        thread _id_8D6D95114B2C9B0D(["tacButtonPress"], ["fragButtonPress"], 0.75);
        self waittill("controllerSuperPress", msg);

        if(msg == "success")
          success = 1;
      } else {
        self notifyonplayercommand("useWeaponActivated", "+special");
        self waittill("useWeaponActivated");
      }

      _id_330825804EBBD918(1);
      scripts\cp\utility::_giveweapon(useweapon);
      self setweaponammoclip(useweapon, clipammo);
      self setweaponammostock(useweapon, stockammo);

      if(!istrue(self._id_4B6E638CB12A3E90))
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon);
    }
  }
}

_id_8D6D95114B2C9B0D(_id_CF95E74FFD3666C0, _id_AD02F85B88A0B345, time) {
  level endon("game_ended");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(_id_374D7614ECBD032A in _id_AD02F85B88A0B345)
  self endon(_id_374D7614ECBD032A);

  foreach(_id_989505A1920845A5 in _id_CF95E74FFD3666C0) {
    childthread scripts\engine\utility::waittill_string_no_endon_death(_id_989505A1920845A5, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread scripts\engine\utility::_id_2C91B6C857AA73CC(time);
        ent waittill("returned", msg);

        if(msg == "timeout")
          self notify("controllerSuperPress", "timeout");
        else
          self notify("controllerSuperPress", "success");

        ent.threads--;
      }

      continue;
    }

    ent waittill("returned", message);
    ent.threads--;
  }

  ent notify("die");
}

_id_C3479770FFEC05E2() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isactive;
}

_id_330825804EBBD918(isactive) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_19163E14365D9264.isactive = isactive;
}

_id_832D0277EBCADE25() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  self.super_activated = 1;
  thread _id_14E0AEC82EF0352C::_id_12248061AABB5B60();
  objweapon = makeweapon("sonar_pulse_mp");

  if(!istrue(scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon))) {
    self.super_activated = 0;
    _id_C5EA07DAC9D83685();
    clientnum = self getentitynumber();
    setomnvar("ui_class_power_reloading", clientnum);
    _id_89656F67C2EA228D = 0.2;
    thread _id_644C18834356D9DC::_id_8F741E1E8E870100(_id_89656F67C2EA228D, 915);
    superusefinished();
    setsuperisinuse(0);
    return undefined;
  }

  msg = scripts\engine\utility::waittill_any_return_4("portable_radar_thrown", "offhand_end", "weapon_change", "offhand_pullback");
  self.super_activated = 0;
  _id_C5EA07DAC9D83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_reloading", clientnum);

  if(msg == "offhand_pullback" || msg == "weapon_change") {
    _id_89656F67C2EA228D = 0.2;
    thread _id_644C18834356D9DC::_id_8F741E1E8E870100(_id_89656F67C2EA228D, 915);
    superusefinished();
    return undefined;
  }

  end_super_meter_progress_early();
  setsuperisinuse(0);
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
}

activate_emp_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread listen_for_emp_drone_ent();
  success = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();

  if(success) {
    emp_drone_success_use();
    wait_until_emp_drone_done();
  } else
    self.super_activated = 0;
}

emp_drone_success_use() {
  _id_1B4ADA49A21B51CA = "cp_super_sentry_used";

  foreach(player in level.players)
  player scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);

  scripts\cp\cp_analytics::logevent_superused(self, "emp drone");
  thread drain_super_meter(1);
}

listen_for_emp_drone_ent() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", drone);
  self.emp_drone = drone;
  self _meth_FD165588822885F4(drone);
  drone thread emp_drone_proximity_explode();
  drone thread check_for_vehicle_in_front();
}

wait_until_emp_drone_done() {
  thread waittill_scout_drone_timeout(5);
  waittill_scout_drone_defined();

  while(isDefined(self.emp_drone))
    wait 0.1;

  self.super_activated = 0;
}

waittill_scout_drone_defined() {
  self endon("emp_drone_timeout");

  while(!isDefined(self.emp_drone))
    wait 0.1;

  self notify("emp_drone_timeout");
}

waittill_scout_drone_timeout(timer) {
  self endon("emp_drone_timeout");
  wait(timer);
  self notify("emp_drone_timeout");
}

emp_drone_proximity_explode() {
  level endon("game_ended");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner endon("disconnect");

  for(;;) {
    vehicles = get_axis_vehicles();

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle)) {
        if(vehicle == self) {
          continue;
        }
        if(isDefined(vehicle.chopper)) {
          continue;
        }
        if(isDefined(vehicle) && vehicle scripts\cp_mp\emp_debuff::can_be_empd()) {
          _id_457471485336C961 = distancesquared(self.origin, vehicle.origin);

          if(_id_457471485336C961 > 250000) {
            continue;
          }
          proximity_explode();
          return;
        }
      }
    }

    waitframe();
  }
}

get_axis_vehicles() {
  vehicles = scripts\cp\utility::getvehiclearray();
  _id_5F8B983A9CC28FB2 = [];

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.team) && vehicle.team == "axis")
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = vehicle;
  }

  turrets = getEntArray("misc_turret", "classname");

  foreach(turret in turrets) {
    if(isDefined(turret.team) && turret.team == "axis")
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = turret;
  }

  foreach(guy in level.spawned_enemies) {
    if(istrue(isDefined(guy.unittype) && guy.unittype == "suicidebomber"))
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = guy;
  }

  return _id_5F8B983A9CC28FB2;
}

proximity_explode() {
  self.owner notify("emp_drone_detonate");
  weapon = "emp_drone_player_mp";
  vehicles = get_axis_vehicles();

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle)) {
      continue;
    }
    if(isDefined(vehicle.vehiclename) && isDefined(level.vehicle.instances[vehicle.vehiclename])) {
      if(isDefined(level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()])) {} else
        vehicle dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);

      continue;
    }

    vehicle dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
  }
}

check_for_vehicle_in_front() {
  level endon("game_ended");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner endon("disconnect");
  dist = 500;

  for(;;) {
    start = self.origin;
    fwd = anglesToForward(self.angles);
    fwd = vectorNormalize(fwd);
    _id_8A444F6F271A657A = rotatevector((0, 30, 0), self.angles);
    _id_F4E944D612636975 = start + _id_8A444F6F271A657A;
    _id_E520906C5F9D7A67 = rotatevector((0, -30, 0), self.angles);
    _id_79736304E483B1CE = start + _id_E520906C5F9D7A67;
    vehicles = get_axis_vehicles();
    check_for_vehicle_trace(start, start + fwd * dist, vehicles, "fwd");
    check_for_vehicle_trace(_id_F4E944D612636975, _id_F4E944D612636975 + fwd * dist, vehicles, "left");
    check_for_vehicle_trace(_id_79736304E483B1CE, _id_79736304E483B1CE + fwd * dist, vehicles, "right");
    waitframe();
  }
}

check_for_vehicle_trace(start, end, vehicles, type) {
  trace = scripts\engine\trace::ray_trace(start, end, self);

  if(isDefined(trace)) {
    if(trace["fraction"] == 1) {
      return;
    }
    if(isDefined(trace["entity"])) {
      if(scripts\engine\utility::array_contains(vehicles, trace["entity"])) {
        proximity_explode();
        return;
      }
    }

    if(trace["fraction"] < 0.2) {
      if(type != "fwd")
        wait 0.25;

      proximity_explode();
      return;
    } else {}
  }
}

_id_1F8539B231E93107(_id_EBEC497FF8B18A45) {
  staticdata = spawnStruct();
  staticdata.ref = _id_EBEC497FF8B18A45;
  staticdata._id_EBEC497FF8B18A45 = _id_EBEC497FF8B18A45;
  _id_19163E14365D9264 = spawnStruct();
  _id_19163E14365D9264.isinuse = 0;
  _id_19163E14365D9264.staticdata = staticdata;
  _id_19163E14365D9264.isactive = 0;
  _id_19163E14365D9264.staticdata.graceperiod = 0;
  _id_19163E14365D9264.allowrefund = 1;
  _id_19163E14365D9264.numkills = 0;
  _id_19163E14365D9264.wasrefunded = 0;
  _id_19163E14365D9264.canstow = 0;
  _id_19163E14365D9264.basepoints = 0;
  _id_19163E14365D9264.extrapoints = 0;
  _id_19163E14365D9264.usestarttime = undefined;
  _id_19163E14365D9264.staticdata.usetime = undefined;
  _id_19163E14365D9264.usepercent = 0.0;
  _id_19163E14365D9264.overridepointsneeded = undefined;
  _id_19163E14365D9264._id_5237A188CCDA4D7B = _id_EBEC497FF8B18A45;
  self.super = _id_19163E14365D9264;
  self setclientomnvar("ui_super_ref", _id_EBEC497FF8B18A45);
}

_id_7C67C8E12DB38300(_id_CC748B6D457627FE) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_211A8547BB6AB09A = _id_19163E14365D9264.staticdata.usetime;

  if(!isDefined(_id_CC748B6D457627FE))
    return 0;

  if(_id_CC748B6D457627FE <= 0.0)
    return 0;

  if(_id_CC748B6D457627FE > _id_211A8547BB6AB09A)
    _id_CC748B6D457627FE = _id_211A8547BB6AB09A;

  _id_2BF3C98575BA0BE1 = _id_CC748B6D457627FE / _id_211A8547BB6AB09A;
  _id_0A2A1403D5924109(_id_2BF3C98575BA0BE1);
}

_id_0A2A1403D5924109(_id_2BF3C98575BA0BE1) {
  _id_19163E14365D9264 = getcurrentsuper();
  _id_B4588F310900DBA5 = _id_19163E14365D9264.usepercent + _id_2BF3C98575BA0BE1;
  _id_19163E14365D9264.usepercent = clamp(_id_B4588F310900DBA5, 0.0, 1.0);
  return _id_B4588F310900DBA5;
}

_id_674934B4DB05639A(func) {
  self.super_activate_func = func;
}

unstowsuperweapon() {
  _id_19163E14365D9264 = getcurrentsuper();

  if(!isDefined(_id_19163E14365D9264) || !_id_19163E14365D9264.canstow) {
    return;
  }
  if(!_id_19163E14365D9264.isinuse || !isDefined(_id_19163E14365D9264.staticdata.useweapon)) {
    _id_19163E14365D9264.canstow = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_19163E14365D9264.staticdata.useweapon);
  _id_19163E14365D9264.canstow = 0;
}

_id_6B384BA557A25934() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(self._id_F6FE24C104C96355)) {
    return;
  }
  self._id_F6FE24C104C96355 = 1;
  delay = 45;

  for(;;) {
    wait 0.25;

    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self) || !scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    _id_C64B92D56EC838B3 = scripts\cp\loot_system::get_empty_munition_slot(self);

    if(!isDefined(_id_C64B92D56EC838B3)) {
      continue;
    }
    scripts\cp\loot_system::give_munition("brloot_munition_grenade_launcher", self);
    _id_0EA6D72B04228D21();

    if(delay >= 10)
      thread scripts\cp\cp_hud_message::showsplash("cp_recharge", delay, self);

    wait(delay);
  }
}

_id_0EA6D72B04228D21() {
  for(;;) {
    self waittill("weapon_removed", type);

    if(isDefined(type) && type == "grenade_launcher") {
      break;
    }
  }
}

_id_50EB338949884FCA() {
  enabled = getdvarint("dvar_13453D792D353E5F", 1);

  if(!enabled) {
    return;
  }
  if(scripts\cp\cp_relics::_id_7915E88A08F28705()) {
    return;
  }
  _id_BA11A925EC503D8B = _id_0998572FF3C96EE5::_id_34819F005DAD50A9();
  _id_9966B1468B120387 = 100;

  if(_id_BA11A925EC503D8B >= _id_9966B1468B120387)
    thread _id_6B384BA557A25934();
}