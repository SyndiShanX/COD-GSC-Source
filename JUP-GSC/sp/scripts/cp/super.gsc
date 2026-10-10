/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\super.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\armor;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_relics;
#using scripts\cp\kits;
#using scripts\cp\laststand;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\objective_trigger;
#using scripts\cp\perks;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\sonar_pulse;
#using scripts\cp_mp\killstreaks\emp_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace super;

function init_super() {
  if(!isDefined(level.supertable)) {
    if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.super_list)) {
      level.supertable = "superlist:" + level.gametypebundle.super_list;
    } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.super_list)) {
      level.supertable = "superlist:" + level.gamemodebundle.super_list;
    }

    assertex(isDefined(level.supertable), "Define Super List asset for the gamemodebundle asset for this mode or override level.superTable in script");
  }

  globals = spawnStruct();
  level.superglobals = globals;
  globals.staticsuperdata = [];
  globals.superweapons = [];
  globals.supersbyid = [];
  globals.supersbyoffhand = [];
  scripts\cp_mp\supers\supers::function_f0327aead8f016e2(globals);
  scripts\cp_mp\supers\supers::function_e3234be372f6209d(level.supertable);

  if(!isDefined(level.superglobals.staticsuperdata["super_recon_drone"])) {
    level.superglobals.staticsuperdata["super_recon_drone"] = spawnStruct();
    level.superglobals.staticsuperdata["super_recon_drone"].id = 11;
  }

  if(!isDefined(level.superglobals.staticsuperdata["super_tac_cover"])) {
    level.superglobals.staticsuperdata["super_tac_cover"] = spawnStruct();
    level.superglobals.staticsuperdata["super_tac_cover"].id = 10;
  }

  if(!isDefined(level.superglobals.staticsuperdata["super_emp_drone"])) {
    level.superglobals.staticsuperdata["super_emp_drone"] = spawnStruct();
    level.superglobals.staticsuperdata["super_emp_drone"].id = 12;
  }

  level.superglobals.staticsuperdata[""] = spawnStruct();
  level.superglobals.staticsuperdata[""].id = 666;

  if(issharedfuncdefined("super_suppression_rounds", "init")) {
    [[getsharedfunc("super_suppression_rounds", "init")]]();
  }

  registersupers();

  thread function_fc293489e21293c4();
}

function function_fc293489e21293c4() {
  cmd = "<dev string:x1c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x7d>";
  addentrytodevgui(cmd);
}

function registersupers() {}

function give_player_super(super_choice, var_2cbc4002b1724081) {
  if(!isDefined(super_choice)) {
    super_choice = "role_tank";
  }

  if(isDefined(self.super) && isDefined(self.super.supername) && super_choice == self.super.supername && !istrue(var_2cbc4002b1724081)) {
    return;
  }

  clear_player_class_and_super();
  function_1f8539b231e93107(super_choice);
  thread update_super_icon(super_choice);

  switch (self.super.supername) {
    case #"hash_508fbdd5b269310c":
      thread give_team_auto_revive();
      break;
    case #"hash_875b1dd917623c0a":
      thread give_team_armor_buff();
      break;
    case #"hash_65b382df72f6ae4d":
      break;
    case #"hash_643b7aa347db7fe8":
      thread give_thermite_launcher();
      break;
    case #"hash_f3ed47e335da1748":
      thread give_scout_drone();
      break;
    case #"hash_611bc3cc30ec563f":
      thread giv_emp_drone();
      break;
  }

  thread init_super_for_player("super_default_zm");
}

function clear_player_class_and_super() {}

function give_player_class_abilities() {
  clear_player_class_and_super();
}

function update_super_icon(super) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  set_omnvar_for_icon(super);
  self setclientomnvar("cp_loadout_changed", 0);
  wait 2;
  self setclientomnvar("cp_loadout_changed", 1);
}

function set_omnvar_for_icon(super) {
  omnvar = int(tablelookup("cp/cp_fieldupgrades.csv", 1, super, 0));
  self setclientomnvar("ui_field_upgrade_icon", omnvar);
}

function init_super_for_player(super) {
  give_super_weapon(super);
  thread give_super_ammo_after_loadout_given(super);
  thread watch_for_super_button(super);
}

function watch_for_super_ammo_depleted(super) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_super_watcher");

  while(true) {
    amt = self getammocount(super);

    if(amt == 0) {
      self setweaponammoclip(super, 1);
    }

    wait 0.1;
  }
}

function function_c5ea07dac9d83685() {
  setomnvar("ui_class_power_ready", -1);
  setomnvar("ui_class_power_inuse", -1);
  setomnvar("ui_class_power_reloading", -1);
}

function give_super_weapon(super) {
  self giveweapon(super);
  self assignweaponoffhandspecial(super);
  self.specialoffhandgrenade = super;
  self setweaponammoclip(super, 1);
  function_c5ea07dac9d83685();
}

function give_super_ammo_after_loadout_given(super) {
  self endon("disconnect");
  flag_wait("player_spawned_with_loadout");
  self setweaponammoclip(super, 1);
}

function watch_for_super_button(super) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("end_super_watcher");
  self endon("end_super_watcher");
  self.super_ready = 0;
  thread recharge_super(super);
  thread watch_for_super_ammo_depleted(super);
  self setclientomnvar("ui_super_progress", 0);
  self setclientomnvar("cp_super_ready", 0);
  flag_wait("player_spawned_with_loadout");

  while(true) {
    self waittill("special_weapon_fired", objweapon);

    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
      scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      self setweaponammoclip(super, 1);
      continue;
    }

    firedweapon = objweapon;

    if(isweapon(objweapon)) {
      firedweapon = getcompleteweaponname(objweapon);
    }

    if(firedweapon == super) {
      fail = 0;

      if(!self.super_ready) {
        fail = 1;
      } else if(istrue(self.inlaststand)) {
        fail = 1;
      } else if(istrue(self.disable_super)) {
        fail = 1;
      } else if(istrue(level.regroup_process_started)) {
        fail = 1;
      } else if(istrue(self.interrogating)) {
        fail = 1;
      } else if(scripts\cp\weapon::player_has_minigun(self)) {
        fail = 1;
      } else if(!istrue(self isonground())) {
        fail = 1;
      } else if(istrue(self.var_23a6763562820c70)) {
        fail = 1;
      }

      if(isDefined(level.can_use_super_func) && ![[level.can_use_super_func]](self)) {
        fail = 1;
      }

      if(!fail) {
        thread fire_super(super);
      } else {
        scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      }
    }

    self setweaponammoclip(super, 1);
  }
}

function fire_super(super) {
  self.super_ready = 0;
  self setclientomnvar("cp_super_ready", 0);
  self setclientomnvar("ui_super_state", 3);
  setsuperisinuse(1);
  super_ref = scripts\cp\super::getcurrentsuperref();

  if(isDefined(super_ref)) {
    scripts\cp\cp_analytics::logevent_superused(self, super_ref);
  }

  thread display_super_fired_splash();
  run_super_loop(super);
  self setclientomnvar("ui_super_state", 4);
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  setsuperisinuse(0);
  self setclientomnvar("cp_super_fired", 0);
  self.super_ready = 0;

  if(istrue(level.var_5ebda93137c97b1c)) {
    self.disable_super = 1;
    thread update_super_icon("none");
  }
}

function issuperinuse() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isinuse;
}

function getcurrentsuperref() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return undefined;
  }

  return superinfo.staticdata.ref;
}

function getcurrentsuper() {
  return self.super;
}

function setsuperisinuse(isinuse) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  superinfo.isinuse = isinuse;
  updatesuperuistate();
}

function updatesuperuistate() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(!isDefined(superinfo.isactive)) {
    return;
  }

  if(!isalive(self)) {
    superinfo.state = undefined;
    return;
  }

  oldstate = superinfo.state;
  state = 1;

  if(issuperexpended()) {
    state = 4;
  } else if(issuperready()) {
    state = 2;
  } else if(issuperinuse()) {
    state = 3;
  }

  if(!isDefined(oldstate) || state != oldstate) {
    self setclientomnvar("ui_super_state", state);
  }

  superinfo.state = state;
}

function issuperexpended() {
  return istrue(self.pers["superExpended"]);
}

function issuperready() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || superinfo.isinuse) {
    return false;
  }

  return getcurrentsuperpoints() >= getsuperpointsneeded();
}

function getcurrentsuperpoints() {
  superinfo = getcurrentsuper();
  return superinfo.basepoints + superinfo.extrapoints;
}

function getsuperpointsneeded() {
  superinfo = getcurrentsuper();
  pointsneeded = superinfo.staticdata.pointsneeded;

  if(!isDefined(pointsneeded)) {
    pointsneeded = 0;
  }

  if(isDefined(superinfo.overridepointsneeded)) {
    pointsneeded = superinfo.overridepointsneeded;
  }

  return pointsneeded;
}

function function_32d75c33471450d3() {
  var_17a208de8e7cd188 = scripts\cp\kits::function_cab56589fd214c7e();

  if(!isDefined(var_17a208de8e7cd188)) {
    return undefined;
  }

  switch (var_17a208de8e7cd188) {
    case #"hash_36cdfbfaeba9a21a":
      return 180;
    case #"hash_f7803221ec64d903":
      return 90;
    case #"hash_2b0e6b98c99852f2":
      return 60;
  }

  return undefined;
}

function recharge_super(super) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_super_watcher");
  self setclientomnvar("ui_super_state", 1);
  meter_time = function_32d75c33471450d3();
  dvar_check = getdvarint(@ "hash_b0c572ab1605350a", 0);

  if(dvar_check) {
    meter_time = dvar_check;
  }

  if(istrue(self.role_edit)) {
    if(!isDefined(self.super_progress)) {
      self.super_progress = 890;
    } else if(self.super_progress > 996) {
      self.super_progress = 997;
    }

    self.role_edit = undefined;
  } else {
    self.super_progress = 890;
  }

  starttime = gettime();
  lasttime = starttime;

  while(true) {
    dvar_check = getdvarint(@ "hash_b0c572ab1605350a", 0);

    if(dvar_check) {
      meter_time = dvar_check;
    } else {
      meter_time = function_32d75c33471450d3();
    }

    paused = 0;
    curtime = gettime();

    if(istrue(self.super_activated)) {
      paused = 1;
    } else if(istrue(self.inlaststand)) {
      paused = 1;
    } else if(istrue(self.super_ready)) {
      paused = 1;
    } else if(istrue(self.disable_super)) {
      paused = 1;
    }

    if(flag_exist("infil_complete") && !flag("infil_complete")) {
      paused = 1;
    }

    if(paused) {
      lasttime = curtime;
      waitframe();
      continue;
    }

    timediff = curtime - lasttime;

    if(isDefined(meter_time)) {
      amount = timediff / meter_time * 1000 * 1000;
      amount *= scripts\cp\perks::get_perk("super_fill_scalar");
      increase_super_progress(amount);
    }

    progress = self.super_progress / 1000;

    if(progress > 0.998) {
      progress = 1;
    }

    self setclientomnvar("ui_super_progress", progress);
    lasttime = curtime;

    if(progress >= 1) {
      self.super_ready = 1;
      self setclientomnvar("cp_super_ready", 1);
      self setclientomnvar("ui_super_state", 2);

      if(self getclientomnvar("ui_cp_bink_overlay_state") == 0) {
        display_super_ready_splash();
      }
    }

    waitframe();
  }
}

function display_super_ready_splash() {
  if(istrue(self.var_76fdc69357652407)) {
    return;
  }

  if(!istrue(self.super_displayed)) {
    self.super_displayed = 1;
    return;
  }

  if(self usinggamepad()) {
    splash = "super_revive";

    switch (self.kit_data.kit) {
      case #"hash_f7803221ec64d903":
        splash = "cp_super_revive";
        break;
      case #"hash_36cdfbfaeba9a21a":
        splash = "cp_super_armor";
        break;
      case #"hash_2b0e6b98c99852f2":
        splash = "cp_super_snapshot_pulse";
        break;
    }
  } else {
    splash = "cp_super_revive_kbm";

    switch (self.kit_data.kit) {
      case #"hash_f7803221ec64d903":
        splash = "cp_super_revive_kbm";
        break;
      case #"hash_36cdfbfaeba9a21a":
        splash = "cp_super_armor_kbm";
        break;
      case #"hash_2b0e6b98c99852f2":
        splash = "cp_super_snapshot_pulse_kbm";
        break;
    }
  }

  function_c5ea07dac9d83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_ready", clientnum);
  thread scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
}

function display_super_fired_splash() {
  self endon("disconnect");
  splash = "super_revive_used";
  function_c5ea07dac9d83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_inuse", clientnum);
  self setclientomnvar("cp_super_fired", 1);
  wait 6;
  self setclientomnvar("cp_super_fired", 0);
}

function increase_super_progress(amount) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      if(isDefined(self.super_progress_scalar)) {
        amount *= self.super_progress_scalar;
      }

      self.super_progress += amount;

      if(self.super_progress > 1000) {
        self.super_progress = 1000;
      }
    }
  }
}

function drain_super_meter(time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("end_super_meter_early");
  thread set_progress_to_zero_on_death();
  self.super_meter_draining = 1;
  clientnum = self getentitynumber();
  starttime = gettime();
  lasttime = starttime;
  var_b28845cfb5a6978b = 1;

  while(true) {
    curtime = gettime();
    timediff = curtime - lasttime;
    amount = timediff / time * 1000;
    var_b28845cfb5a6978b -= amount;

    if(var_b28845cfb5a6978b < 0) {
      var_b28845cfb5a6978b = 0;
    }

    self setclientomnvar("ui_super_progress", var_b28845cfb5a6978b);
    lasttime = curtime;
    waitframe();

    if(var_b28845cfb5a6978b <= 0) {
      self.super_progress = 0;
      self notify("meter_drained");
      break;
    }
  }

  kit_name = scripts\cp\kits::function_cab56589fd214c7e();
  function_c5ea07dac9d83685();

  switch (kit_name) {
    case #"hash_2b0e6b98c99852f2":
    case #"hash_36cdfbfaeba9a21a":
    case #"hash_f7803221ec64d903":
      setomnvar("ui_class_power_reloading", clientnum);
      break;
  }

  self.super_meter_draining = 0;
}

function set_progress_to_zero_on_death() {
  self endon("meter_drained");
  self waittill("death");
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self setclientomnvar("cp_super_fired", 0);
}

function end_super_meter_progress_early() {
  self notify("end_super_meter_early");
  self.super_progress = 0;
  self setclientomnvar("ui_super_progress", self.super_progress);
  self.super_meter_draining = 0;
}

function run_super_loop(super) {
  if(isDefined(self.super_activate_func)) {
    self[[self.super_activate_func]]();
  }

  while(istrue(self.super_activated)) {
    wait 0.1;
  }
}

function give_scout_drone() {
  function_674934b4db05639a(&activate_scout_drone);
}

function give_team_armor_buff() {
  function_674934b4db05639a(&activate_team_armor_buff);
  self.super_progress_scalar = 0.25;
}

function give_thermite_launcher() {
  function_674934b4db05639a(&activate_thermite_launcher);
  self.super_progress_scalar = 0.5;
}

function give_team_auto_revive() {
  function_674934b4db05639a(&activate_team_auto_revive);
  self.super_progress_scalar = 0.25;
}

function give_team_stopping_power() {
  function_674934b4db05639a(&activate_team_stopping_power);
}

function giv_emp_drone() {
  if(isDefined(level.activate_emp_drone_func)) {
    function_674934b4db05639a(level.activate_emp_drone_func);
    return;
  }

  function_674934b4db05639a(&activate_emp_drone);
}

function activate_thermite_launcher() {
  self.super_activated = 1;
  self.gl_proj_override = "thermite";

  if(scripts\cp\weapon::player_has_minigun(self)) {
    scripts\cp\weapon::drop_minigun(self);
    self waittill("weapon_change");

    if(istrue(self.inlaststand)) {
      self.super_activated = 0;
      return;
    }
  }

  scripts\cp\munitions::givegrenadelauncher();
  thread drain_super_meter(1);
  scripts\cp\cp_analytics::logevent_superused(self, "thermite_launcher");
  self setclientomnvar("ui_thermite_class_power_on", gettime());
  clientnum = self getentitynumber();
  splash = "cp_super_cluster_used";

  foreach(player in level.players) {
    player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
  }

  while(istrue(self.has_gl)) {
    self waittill("weapon_removed");
  }

  function_c5ea07dac9d83685();
  setomnvar("ui_class_power_reloading", clientnum);
  self setclientomnvar("ui_thermite_class_power_off", gettime());
  self.gl_proj_override = undefined;
  self.super_activated = 0;
}

function team_unlimited_ammo() {
  foreach(player in level.players) {
    player.has_infinite_ammo = 1;
    ammo = ammo_round_up();
    player thread unlimited_ammo(ammo);
  }
}

function activate_scout_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  self.var_2332678633fe1728 = 1;
  thread listen_for_drone_ent();
  success = scripts\cp_mp\killstreaks\recon_drone::recondrone_beginsuper();

  if(success) {
    msg = waittill_any_return_3("super_use_succeeded", "super_use_failed", "laststand");

    if(msg == "super_use_succeeded") {
      splash = "cp_super_mark_used";

      foreach(player in level.players) {
        player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
      }

      scripts\cp\cp_analytics::logevent_superused(self, "scout drone");
      thread drain_super_meter(1);
      wait_until_done();
    } else {
      self.super_activated = 0;
      self.var_2332678633fe1728 = 0;
    }

    return;
  }

  self.super_activated = 0;
  self.var_2332678633fe1728 = 0;
}

function listen_for_drone_ent() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", drone);
  scripts\cp\objective_trigger::function_b0637efa07ab9df9(drone, "killstreak");
  self.scout_drone = drone;
  self setplayerusingdrone(drone);
}

function wait_until_done() {
  clientnum = self getentitynumber();
  thread waittill_drone_timeout(5);
  waittill_drone_defined();

  while(isDefined(self.scout_drone)) {
    waitframe();
  }

  function_c5ea07dac9d83685();
  setomnvar("ui_class_power_reloading", clientnum);
  self.super_activated = 0;
  self.var_2332678633fe1728 = 0;
}

function waittill_drone_defined() {
  self endon("scout_drone_timeout");

  while(!isDefined(self.scout_drone)) {
    wait 0.1;
  }

  self notify("scout_drone_timeout");
}

function waittill_drone_timeout(timer) {
  self endon("scout_drone_timeout");
  wait timer;
  self notify("scout_drone_timeout");
}

function superusefinished(var_3179afaa208defa2, fromdeath, var_e68637fb8c1c346b, var_e743a22765d93795) {
  self notify("super_use_finished_lb");

  if(istrue(var_3179afaa208defa2)) {
    self notify("super_use_failed");
  } else {
    self notify("super_use_succeeded");
  }

  self notify("super_use_finished");
}

function ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  ammo = [];

  foreach(weapon in self.weaponlist) {
    ammo[getcompleteweaponname(weapon)] = self getammocount(weapon);
  }

  return ammo;
}

function unlimited_ammo(ammo) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_unlimited_ammo");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_infinite_ammo)) {
    var_76d0240ac996ca7b = 0;

    foreach(index in self.weaponlist) {
      clip_size = weaponclipsize(index);

      if(index == self getcurrentweapon() && weapon_no_unlimited_check(index)) {
        var_76d0240ac996ca7b = 1;

        if(clip_size == 1) {
          new_stock = self getweaponammostock(index);
          new_stock++;
          self setweaponammostock(index, new_stock);
        } else {
          self setweaponammoclip(index, weaponclipsize(index), "left");
        }
      }

      if(index == self getcurrentweapon() && weapon_no_unlimited_check(index)) {
        var_76d0240ac996ca7b = 1;
        self setweaponammoclip(index, weaponclipsize(index), "right");
      }

      if(var_76d0240ac996ca7b == 0) {
        ammo_round_up();
      }
    }

    wait 0.05;
  }
}

function weapon_no_unlimited_check(weapon) {
  assert(isweapon(weapon));
  var_76d0240ac996ca7b = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(opweapon in level.opweaponsarray) {
      if(weapon.basename == opweapon) {
        var_76d0240ac996ca7b = 0;
      }
    }
  }

  return var_76d0240ac996ca7b;
}

function activate_team_auto_revive(amount) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  splash = "cp_super_revive_used";
  var_c98f63203dea02cf = 0;

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    if(scripts\cp\laststand::player_in_laststand(player)) {
      if(isDefined(player.last_stand_state) && player.last_stand_state == "bleed_out") {
        continue;
      }

      player thread team_instant_revive();
      player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
      scripts\cp\laststand::record_revive_success(self, player);
      var_c98f63203dea02cf = 1;
    }
  }

  if(var_c98f63203dea02cf) {
    scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
    scripts\cp\cp_analytics::logevent_superused(self, "team auto-revive");
    drain_super_meter(1);
  }

  self.super_activated = 0;
}

function team_instant_revive() {
  if(scripts\cp\laststand::player_in_laststand(self)) {
    if(!isDefined(self.dogtag)) {
      self.using_self_revive = 1;
      self giveandfireoffhand("adrenaline_mp");

      if(isDefined(self.reviveiconent)) {
        scripts\cp\laststand::set_revive_icon_color(self.reviveiconent);
        self.reviveent makeunusable();
      }

      wait 3;
      scripts\cp\laststand::instant_revive(self);
      self.using_self_revive = undefined;
    }
  }
}

function deactivate_instant_revive(amount) {
  level endon("disconnect");
  level endon("game_ended");
  result = waittill_any_timeout_1(amount, "force_end_super");
  self notify("stop_instant_revive");
  self.has_instant_revive = undefined;
  self.perk_data["revive_time_scalar"] = self.old_revive_time_scalar;
}

function aoe_instant_revive(timer) {
  self endon("stop_instant_revive");
  self endon("death");
  dist = 100;
  dist_sq = dist * dist;
  end_time = gettime() + timer * 1000;

  while(gettime() < end_time) {
    foreach(player in level.players) {
      if(scripts\cp\laststand::player_in_laststand(player)) {
        if(distancesquared(self.origin, player.origin) < dist_sq) {
          player scripts\cp\laststand::instant_revive(player);

          if(isDefined(player.dogtag)) {
            player.dogtag delete();
          }
        }
      }
    }

    wait 0.1;
  }
}

function activate_team_armor_buff() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  turn_on_team_armor_buff();
  scripts\cp\cp_analytics::logevent_superused(self, "team armor");
  thread deactivate_team_armor_buff(20);
  drain_super_meter(1);
  self.super_activated = 0;
}

function turn_on_team_armor_buff() {
  full_armor = 100;
  armor_dvar = getdvarint(@ "hash_e6924e7c0a5aad1f", 0);

  if(armor_dvar) {
    full_armor = armor_dvar;
  }

  splash = "cp_super_armor_used";

  foreach(player in level.players) {
    if(on_the_same_team(self, player) && isalive(player)) {
      player.has_team_armor = 1;
      scripts\cp\armor::givearmor(player, full_armor, 1);
      player.old_armor_scalar = player scripts\cp\perks::get_perk("enemy_damage_to_player_armor_scalar");
      player scripts\cp\perks::set_perk("enemy_damage_to_player_armor_scalar", player.old_armor_scalar * 1.5);
      player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
    }

    player setclientomnvar("ui_armor_class_power_used", 1);
  }
}

function on_the_same_team(player_one, player_two) {
  if(isDefined(player_one.team_number) && isDefined(player_two.team_number)) {
    return (player_one.team_number == player_two.team_number);
  }

  return 1;
}

function remove_team_armor_buff() {
  foreach(player in level.players) {
    if(on_the_same_team(self, player)) {
      player.has_team_armor = undefined;
      player scripts\cp\perks::set_perk("enemy_damage_to_player_armor_scalar", player.old_armor_scalar);
    }
  }
}

function deactivate_team_armor_buff(amount) {
  level endon("disconnect");
  level endon("game_ended");
  clientnum = self getentitynumber();
  result = waittill_any_timeout_1(amount, "force_end_super");
  function_c5ea07dac9d83685();
  setomnvar("ui_class_power_reloading", clientnum);

  foreach(player in level.players) {
    player setclientomnvar("ui_armor_class_power_used", 0);
  }

  remove_team_armor_buff();
}

function activate_team_stopping_power() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  scripts\cp\cp_analytics::logevent_superused(self, "team stopping_power");
  splash = "cp_super_ammo_used";

  foreach(player in level.players) {
    player give_full_stoppingpower_clip();
    player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
  }

  drain_super_meter(1);

  foreach(player in level.players) {
    self setclientomnvar("ui_ammo_class_power_on", gettime());
  }

  self.super_activated = 0;
}

function give_full_stoppingpower_clip() {
  weapon = scripts\cp\utility::getvalidtakeweapon();
  maxclipammo = weaponclipsize(weapon);
  self setweaponammoclip(weapon, maxclipammo);
  thread watch_bullet_count(weapon, maxclipammo);
}

function watch_bullet_count(weapon, maxclipammo) {
  self endon("disconnect");
  thread remove_on_death();
  thread stoppingpower_watchhcrweaponchange(weapon);
  thread stoppingpower_watchhcrweaponfire(weapon, maxclipammo);
  self waittill("stoppingPower_removeHCR");
  takeperk("specialty_bulletdamage");
}

function remove_on_death() {
  self waittill("death");
  takeperk("specialty_bulletdamage");
}

function stoppingpower_watchhcrweaponchange(weapon) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.gavehcr = 0;

  while(self hasweapon(weapon)) {
    if(self getcurrentweapon() == weapon) {
      if(!self.gavehcr) {
        giveperk("specialty_bulletdamage");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      takeperk("specialty_bulletdamage");
      self.gavehcr = 0;
    }

    self waittill("weapon_change");
  }

  foreach(player in level.players) {
    self setclientomnvar("ui_ammo_class_power_off", gettime());
  }

  self notify("stoppingPower_removeHCR");
}

function stoppingpower_watchhcrweaponfire(weapon, amount) {
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

  foreach(player in level.players) {
    self setclientomnvar("ui_ammo_class_power_off", gettime());
  }

  self notify("stoppingPower_removeHCR");
}

function stoppingpower_watchhcrammodrain(weapon, amount) {
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

  foreach(player in level.players) {
    self setclientomnvar("ui_ammo_class_power_off", gettime());
  }

  self notify("stoppingPower_removeHCR");
}

function allowsuperweaponstow() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !superinfo.isinuse) {
    return;
  }

  superinfo.canstow = 1;
}

function private function_9105217782a39139(superinfo) {
  maxclipammo = weaponmaxammo(superinfo.staticdata.useweapon);
  ammopool = 0;
  ammopool += superinfo.staticdata.useweaponclipammo;
  ammopool += min(maxclipammo, superinfo.staticdata.useweaponstockammo);
  return 1 / ammopool;
}

function reducesuperusepercent(percentoff, var_1e71e1f458960b93, var_80bd4dd71b59356b) {
  superinfo = getcurrentsuper();
  assertex(superinfo.isinuse, "reduceSuperUsePercent() called while the super is not in use.");
  superinfo.usepercent = max(superinfo.usepercent - percentoff, 0);

  if(istrue(var_1e71e1f458960b93)) {
    superinfo.allowrefund = 0;
  }

  if(!isDefined(var_80bd4dd71b59356b) || var_80bd4dd71b59356b == 0) {
    superusedurationupdated();
  }
}

function superusedurationupdated() {
  superinfo = getcurrentsuper();

  if(superinfo.usepercent <= 0) {
    superusefinished();
  }
}

function getcurrentsuperbasepoints() {
  return getcurrentsuper().basepoints;
}

function updatesuperuiprogress() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  if(scripts\cp\utility\player::isinkillcam() || !isalive(self)) {
    superinfo.oldprogress = undefined;
    return;
  }

  progress = 0;

  if(superinfo.isinuse) {
    progress = getsuperuseuiprogress();
  } else {
    pointsneeded = getsuperpointsneeded();
    progress = clamp(getcurrentsuperbasepoints() / pointsneeded, 0, 1);
  }

  if(!isDefined(superinfo.oldprogress) || progress != superinfo.oldprogress) {
    self setclientomnvar("ui_super_progress", progress);
  }

  self setplayersupermeterprogress(progress);
  superinfo.oldprogress = progress;
}

function getsuperuseuiprogress() {
  superinfo = getcurrentsuper();
  assertex(superinfo.isinuse, "getSuperUseProgress() called when super is not in use.");

  print(superinfo.usepercent + "<dev string:xe2>");

  return superinfo.usepercent;
}

function function_c4c44e009d4f4c6b() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo.staticdata.useweapon) || superinfo.staticdata.useweaponclipammo < 1) {
    return;
  }

  if(istrue(superinfo.staticdata.var_ff2e3a3658646a3f)) {
    allowsuperweaponstow();
  }

  var_569d925e5a25df1 = function_9105217782a39139(superinfo);
  reducesuperusepercent(0.001);
  updatesuperuiprogress();
  updatesuperuistate();

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(issameweapon(objweapon, superinfo.staticdata.useweapon, 1)) {
      reducesuperusepercent(var_569d925e5a25df1);
      updatesuperuiprogress();
      updatesuperuistate();
    }
  }
}

function function_15fe9c03174d698d() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("super_use_finished");
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo.staticdata.usetime)) {
    return;
  }

  while(true) {
    waitframe();
    success = 0;

    if(!function_c3479770ffec05e2() && issuperinuse() && !isbot(self)) {
      if(is_player_gamepad_enabled()) {
        self notifyonplayercommand("tacButtonPress", "+smoke");
        self notifyonplayercommand("fragButtonPress", "+frag");
        thread function_8d6d95114b2c9b0d(["tacButtonPress", "fragButtonPress"], [], 0.75);
        self waittill("controllerSuperPress", msg);

        if(msg == "success") {
          success = 1;
        }
      } else {
        self notifyonplayercommand("specialRepeat", "+special");
        self waittill("specialRepeat");
        success = 1;
      }

      if(success) {
        function_ada5045140ee0fdf();
      }
    }
  }
}

function function_ada5045140ee0fdf() {
  if(!isalive(self)) {
    return 0;
  }

  if(!val::get("supers")) {
    return 0;
  }

  if(isusingremote()) {
    return 0;
  }

  superinfo = getcurrentsuper();

  if(isDefined(superinfo.staticdata.var_e0af69536a727f03)) {
    [[superinfo.staticdata.var_e0af69536a727f03]]();
  }
}

function switchandtakesuperuseweapon() {
  self endon("death");
  superinfo = getcurrentsuper();
  useweapon = superinfo.staticdata.useweapon;

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

function trygiveuseweapon(useweapon, clipammo, stockammo) {
  self endon("death_or_disconnect");
  _giveweapon(useweapon);
  self setweaponammoclip(useweapon, clipammo);
  self setweaponammostock(useweapon, stockammo);
  switchresult = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon, isbot(self));

  if(switchresult) {
    thread function_573f49bb5d5a86ea(useweapon);
    return true;
  }

  scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
  return false;
}

function function_ff3b77706565dacf(useweapon, newweapon) {
  if(!issameweapon(useweapon, newweapon, 1) && newweapon.basename != "iw9_knifestab_mp" && newweapon.basename != "iw9_lm_dblmg_execution_mp") {
    return 1;
  }

  return 0;
}

function function_573f49bb5d5a86ea(useweapon) {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self waittill("weapon_change", useweapon);

  while(true) {
    self waittill("weapon_change", newweapon);
    weapon = self getcurrentweapon();

    if(function_ff3b77706565dacf(useweapon, newweapon)) {
      clipammo = self getweaponammoclip(useweapon);
      stockammo = self getweaponammostock(useweapon);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(useweapon);
      setsuperisactive(0);

      if(is_player_gamepad_enabled()) {
        self notifyonplayercommand("tacButtonPress", "+smoke");
        self notifyonplayercommand("fragButtonPress", "+frag");
        thread function_8d6d95114b2c9b0d(["tacButtonPress"], ["fragButtonPress"], 0.75);
        self waittill("controllerSuperPress", msg);

        if(msg == "success") {
          success = 1;
        }
      } else {
        self notifyonplayercommand("useWeaponActivated", "+special");
        self waittill("useWeaponActivated");
      }

      setsuperisactive(1);
      _giveweapon(useweapon);
      self setweaponammoclip(useweapon, clipammo);
      self setweaponammostock(useweapon, stockammo);

      if(!istrue(self.var_4b6e638cb12a3e90)) {
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon);
      }
    }
  }
}

function function_8d6d95114b2c9b0d(var_cf95e74ffd3666c0, var_ad02f85b88a0b345, time) {
  level endon("game_ended");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(endonnotify in var_ad02f85b88a0b345) {
    self endon(endonnotify);
  }

  foreach(stringnotify in var_cf95e74ffd3666c0) {
    childthread waittill_string_no_endon_death(stringnotify, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread timeout_struct(time);
        ent waittill("returned", msg);

        if(msg == "timeout") {
          self notify("controllerSuperPress", "timeout");
        } else {
          self notify("controllerSuperPress", "success");
        }

        ent.threads--;
      }

      continue;
    }

    ent waittill("returned", message);
    ent.threads--;
  }

  ent notify("die");
}

function function_c3479770ffec05e2() {
  return isDefined(getcurrentsuper()) && getcurrentsuper().isactive;
}

function setsuperisactive(isactive) {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo)) {
    return;
  }

  superinfo.isactive = isactive;
}

function function_832d0277ebcade25() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  self.super_activated = 1;
  thread scripts\cp_mp\equipment\sonar_pulse::function_12248061aabb5b60();
  objweapon = makeweapon("sonar_pulse_mp");

  if(!istrue(scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(objweapon))) {
    self.super_activated = 0;
    scripts\cp\super::function_c5ea07dac9d83685();
    clientnum = self getentitynumber();
    setomnvar("ui_class_power_reloading", clientnum);
    delay_amount = 0.2;
    thread scripts\cp\munitions::function_8f741e1e8e870100(delay_amount, 915);
    scripts\cp\super::superusefinished();
    scripts\cp\super::setsuperisinuse(0);
    return undefined;
  }

  msg = waittill_any_return_4("portable_radar_thrown", "offhand_end", "weapon_change", "offhand_pullback");
  self.super_activated = 0;
  function_c5ea07dac9d83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_reloading", clientnum);

  if(msg == "offhand_pullback" || msg == "weapon_change") {
    delay_amount = 0.2;
    thread scripts\cp\munitions::function_8f741e1e8e870100(delay_amount, 915);
    superusefinished();
    return undefined;
  }

  scripts\cp\super::end_super_meter_progress_early();
  scripts\cp\super::setsuperisinuse(0);
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "equipment_deployed");
}

function activate_emp_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread listen_for_emp_drone_ent();
  success = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();

  if(success) {
    emp_drone_success_use();
    wait_until_emp_drone_done();
    return;
  }

  self.super_activated = 0;
}

function emp_drone_success_use() {
  splash = "cp_super_sentry_used";

  foreach(player in level.players) {
    player scripts\cp\cp_hud_message::showsplash(splash, undefined, self);
  }

  scripts\cp\cp_analytics::logevent_superused(self, "emp drone");
  thread drain_super_meter(1);
}

function listen_for_emp_drone_ent() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", drone);
  self.emp_drone = drone;
  self setplayerusingdrone(drone);
  drone thread emp_drone_proximity_explode();
  drone thread check_for_vehicle_in_front();
}

function wait_until_emp_drone_done() {
  thread waittill_scout_drone_timeout(5);
  waittill_scout_drone_defined();

  while(isDefined(self.emp_drone)) {
    wait 0.1;
  }

  self.super_activated = 0;
}

function waittill_scout_drone_defined() {
  self endon("emp_drone_timeout");

  while(!isDefined(self.emp_drone)) {
    wait 0.1;
  }

  self notify("emp_drone_timeout");
}

function waittill_scout_drone_timeout(timer) {
  self endon("emp_drone_timeout");
  wait timer;
  self notify("emp_drone_timeout");
}

function emp_drone_proximity_explode() {
  level endon("game_ended");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner endon("disconnect");

  while(true) {
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
          distsqr = distancesquared(self.origin, vehicle.origin);

          if(distsqr > 250000) {
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

function get_axis_vehicles() {
  vehicles = getvehiclearray();
  new_list = [];

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.team) && vehicle.team == "axis") {
      new_list[new_list.size] = vehicle;
    }
  }

  turrets = getEntArray("misc_turret", "classname");

  foreach(turret in turrets) {
    if(isDefined(turret.team) && turret.team == "axis") {
      new_list[new_list.size] = turret;
    }
  }

  foreach(guy in level.spawned_enemies) {
    if(istrue(isDefined(guy.unittype) && guy.unittype == "suicidebomber")) {
      new_list[new_list.size] = guy;
    }
  }

  return new_list;
}

function proximity_explode() {
  self.owner notify("emp_drone_detonate");
  weapon = "emp_drone_player_mp";
  vehicles = get_axis_vehicles();

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle)) {
      continue;
    }

    if(isDefined(vehicle.vehiclename) && isDefined(level.vehicle.instances[vehicle.vehiclename])) {
      if(isDefined(level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()])) {} else {
        vehicle dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
      }

      continue;
    }

    vehicle dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
  }
}

function check_for_vehicle_in_front() {
  level endon("game_ended");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner endon("disconnect");
  dist = 500;

  while(true) {
    start = self.origin;
    fwd = anglesToForward(self.angles);
    fwd = vectorNormalize(fwd);
    offset_left = rotatevector((0, 30, 0), self.angles);
    start_left = start + offset_left;
    offset_right = rotatevector((0, -30, 0), self.angles);
    start_right = start + offset_right;
    vehicles = get_axis_vehicles();
    check_for_vehicle_trace(start, start + fwd * dist, vehicles, "fwd");
    check_for_vehicle_trace(start_left, start_left + fwd * dist, vehicles, "left");
    check_for_vehicle_trace(start_right, start_right + fwd * dist, vehicles, "right");
    waitframe();
  }
}

function check_for_vehicle_trace(start, end, vehicles, type) {
  trace = scripts\engine\trace::ray_trace(start, end, self);

  if(isDefined(trace)) {
    if(trace["fraction"] == 1) {
      return;
    }

    if(isDefined(trace["entity"])) {
      if(array_contains(vehicles, trace["entity"])) {
        proximity_explode();
        return;
      }
    }

    if(trace["fraction"] < 0.2) {
      if(type != "fwd") {
        wait 0.25;
      }

      proximity_explode();
      return;
    }
  }
}

function function_1f8539b231e93107(superref) {
  staticdata = spawnStruct();
  staticdata.ref = superref;
  staticdata.superref = superref;
  superinfo = spawnStruct();
  superinfo.isinuse = 0;
  superinfo.staticdata = staticdata;
  superinfo.isactive = 0;
  superinfo.staticdata.graceperiod = 0;
  superinfo.allowrefund = 1;
  superinfo.numkills = 0;
  superinfo.wasrefunded = 0;
  superinfo.canstow = 0;
  superinfo.basepoints = 0;
  superinfo.extrapoints = 0;
  superinfo.usestarttime = undefined;
  superinfo.staticdata.usetime = undefined;
  superinfo.usepercent = 0;
  superinfo.overridepointsneeded = undefined;
  superinfo.supername = superref;
  self.super = superinfo;
  self setclientomnvar("ui_super_ref", superref);
}

function function_7c67c8e12db38300(seconds) {
  superinfo = getcurrentsuper();
  maxseconds = superinfo.staticdata.usetime;

  if(!isDefined(seconds)) {
    return 0;
  }

  if(seconds <= 0) {
    return 0;
  }

  if(seconds > maxseconds) {
    seconds = maxseconds;
  }

  percentage = seconds / maxseconds;
  function_a2a1403d5924109(percentage);
}

function function_a2a1403d5924109(percentage) {
  superinfo = getcurrentsuper();
  var_b4588f310900dba5 = superinfo.usepercent + percentage;
  superinfo.usepercent = clamp(var_b4588f310900dba5, 0, 1);
  return var_b4588f310900dba5;
}

function function_674934b4db05639a(func) {
  self.super_activate_func = func;
}

function unstowsuperweapon() {
  superinfo = getcurrentsuper();

  if(!isDefined(superinfo) || !superinfo.canstow) {
    return;
  }

  if(!superinfo.isinuse || !isDefined(superinfo.staticdata.useweapon)) {
    superinfo.canstow = 0;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(superinfo.staticdata.useweapon);
  superinfo.canstow = 0;
}

function function_6b384ba557a25934() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(self.var_f6fe24c104c96355)) {
    return;
  }

  self.var_f6fe24c104c96355 = 1;
  delay = 45;

  while(true) {
    wait 0.25;

    if(scripts\cp\laststand::player_in_laststand(self) || !scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    empty_slot = scripts\cp\loot_system::get_empty_munition_slot(self);

    if(!isDefined(empty_slot)) {
      continue;
    }

    scripts\cp\loot_system::give_munition("brloot_munition_grenade_launcher", self);
    function_ea6d72b04228d21();

    if(delay >= 10) {
      thread scripts\cp\cp_hud_message::showsplash("cp_recharge", delay, self);
    }

    wait delay;
  }
}

function function_ea6d72b04228d21() {
  while(true) {
    self waittill("weapon_removed", type);

    if(isDefined(type) && type == "grenade_launcher") {
      break;
    }
  }
}

function function_50eb338949884fca() {
  enabled = getdvarint(@ "hash_13453d792d353e5f", 1);

  if(!enabled) {
    return;
  }

  if(scripts\cp\cp_relics::function_7915e88a08f28705()) {
    return;
  }

  totalintel = self getplayerdata("cp", "totalIntel");
  var_9966b1468b120387 = 150;

  var_9966b1468b120387 = getdvarint(@ "hash_e82bf0e129d236fa", var_9966b1468b120387);

  if(totalintel >= var_9966b1468b120387) {
    thread function_6b384ba557a25934();
  }
}

function getsuperrefforsuperuseweapon(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[weapon])) {
    return undefined;
  }

  return level.superglobals.superweapons[weapon].ref;
}

function getsuperrefforsuperoffhand(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals.supersbyoffhand[weapon])) {
    return undefined;
  }

  return level.superglobals.supersbyoffhand[weapon].ref;
}

function getsuperrefforsuperextraweapon(weapon) {
  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(!isDefined(level.superglobals.supersbyextraweapon[weapon])) {
    return undefined;
  }

  return level.superglobals.supersbyextraweapon[weapon].ref;
}

function getsuperrefforsuperweapon(weapon) {
  if(!isDefined(level.superglobals)) {
    return undefined;
  }

  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  superuseweapon = getsuperrefforsuperuseweapon(weapon);

  if(isDefined(superuseweapon)) {
    return superuseweapon;
  }

  superoffhand = getsuperrefforsuperoffhand(weapon);

  if(isDefined(superoffhand)) {
    return superoffhand;
  }

  superoffhand = getsuperrefforsuperextraweapon(weapon);

  if(isDefined(superoffhand)) {
    return superoffhand;
  }

  switch (weapon) {
    case #"hash_1a30d3a1753a5b6":
      return "super_tac_insert";
    case #"hash_e2c74e289201361":
      return "super_loadout_drop";
  }

  return undefined;
}