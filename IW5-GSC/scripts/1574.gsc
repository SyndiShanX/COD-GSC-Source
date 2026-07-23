/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1574.gsc
**************************************/

armory_preload() {
  maps/_sp_airdrop::sp_airdrop_preload();
  maps/_sp_killstreaks::sp_killstreaks_global_preload();
  common_scripts / _sentry::main();
  level.remotemissile_usethermal = 1;
  level.visionthermaldefault = "thermal_mp";
  level.vision_uav = "thermal_mp";
  maps/_so_survival_code::delete_on_load();
  maps/_so_survival_code::remotemissile_infantry_kills_dialogue_setup();
  precachestring(&"SO_SURVIVAL_ARMORY_USE_WEAPON");
  precachestring(&"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
  precachestring(&"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
  precacheshader("specops_ui_equipmentstore");
  precacheshader("specops_ui_weaponstore");
  precacheshader("specops_ui_airsupport");
  precacheshader("specops_ui_deltasupport");
  precacheshader("specops_ui_riotshieldsupport");
  precachemenu("survival_armory_equipment");
  precachemenu("survival_armory_airsupport");
  precachemenu("survival_armory_weapon");
  precachemenu("survival_armory_replacement_warning");
  maps\_utility::add_hint_string("dpad_right_slot_full", &"SO_SURVIVAL_DPAD_RIGHT_SLOT_FULL");

  for(var_0 = 0; var_0 <= 64; var_0++) {
    var_1 = get_ref_by_index(var_0);

    if(isDefined(var_1) && var_1 != "" && var_1 != "ammo" && _id_3EEF(var_1) == "weapon") {
      maps/_so_survival_code::precache_loadout_item(var_1);
    }
  }

  precacheitem("claymore");
  precacheitem("rpg_survival");
  precacheitem("iw5_riotshield_so");
  precacheitem("air_support_strobe");
  level.air_support_sticky_marker_fx = loadfx("smoke/signal_smoke_air_support_pulse");
  precachemodel("vehicle_ac130_coop");
  precachemodel("c130_zoomrig");
  level.armory = [];
  level.armory_all_items = [];
  armory_populate(100, 120, "weaponupgrade");
  armory_populate(0, 64, "weapon");
  armory_populate(1000, 1020, "equipment");
  armory_populate(10000, 10020, "airsupport");
}

armory_postload() {
  maps/_sp_killstreaks::sp_killstreaks_init();
  level.airdropcrateusetime = 0;
  level.airdropcratetimeout = 60;
  level.airdropcrateunstuck = 1;
  maps/_sp_killstreaks::add_sp_killstreak("carepackage");
  maps/_sp_killstreaks::add_sp_killstreak("remote_missile");
  maps/_sp_killstreaks::add_sp_killstreak("sentry");
  maps/_sp_killstreaks::add_sp_killstreak("sentry_gl");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_longersprint");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_fastreload");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_quickdraw");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_detectexplosive");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_bulletaccuracy");
  maps/_sp_killstreaks::add_sp_killstreak("specialty_stalker");
  maps\_remotemissile::init();
  level thread maps/_so_survival_code::remotemissile_uav();
  level thread maps/_so_survival_code::remotemissile_infantry_kills_dialogue();
  level.claymoresentientfunc = ::claymoresentientfunc;
  maps/_air_support_strobe::main();
  ac130_traverse();
}

ac130_traverse() {
  level.ac130_speed["move"] = 250;
  level.ac130_speed["rotate"] = 70;
  level._id_3E93 = 1;
  level._id_3E94 = 1;
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(var_0.size) {
    var_1 = findboxcenter(var_0[0].origin, var_0[1].origin);
  }
  level.ac130 = spawn("script_model", var_1);
  level.ac130 setModel("c130_zoomrig");
  level.ac130.angles = (0, 115, 0);
  level.ac130 hide();
  level thread rotateplane();
  level thread ac130_spawn();
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

rotateplane() {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");
  var_0 = 10;
  var_1 = level.ac130_speed["rotate"] / 360 * var_0;
  level.ac130 rotateYaw(level.ac130.angles[2] + var_0, var_1, var_1, 0);

  for(;;) {
    level.ac130 rotateYaw(360, level.ac130_speed["rotate"]);
    wait(level.ac130_speed["rotate"]);
  }
}

ac130_spawn() {
  wait 0.05;
  var_0 = spawn("script_model", level.ac130 gettagorigin("tag_origin") + (0, 3000, 4500));
  var_0 setModel("vehicle_ac130_coop");
  var_0 setCanDamage(0);
  var_0.health = 1000;
  var_0 linkTo(level.ac130, "tag_origin", (0, 3000, 4500), (25, -90, 0));
  level.ac130.planemodel = var_0;
  level.ac130.planemodel hide();
  wait 0.05;
  level.ac130.planemodel show();
  maps/_air_support_strobe::set_aircraft(level.ac130.planemodel);
}

armory_init() {
  var_0 = armory_setup("weapon", "specops_ui_weaponstore", &"SO_SURVIVAL_ARMORY_USE_WEAPON");
  var_1 = armory_setup("equipment", "specops_ui_equipmentstore", &"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
  var_2 = armory_setup("airsupport", "specops_ui_airsupport", &"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
  level thread armory_usage_think(var_0);
  level thread armory_usage_think(var_1);
  level thread armory_usage_think(var_2);

  foreach(var_4 in level.players) {
    var_4 thread track_ownership();
    var_4 thread sentry_setup();
  }
}

armory_populate(var_0, var_1, var_2) {
  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = get_ref_by_index(var_3);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = spawnStruct();
    var_5.repeating = var_3;
    var_5.ref = var_4;
    var_5.type = var_2;
    var_5._id_3EC0 = _id_3EF0(var_4);
    var_5.name = get_name(var_4);
    var_5.desc = _id_3EF3(var_4);
    var_5._id_3EC1 = _id_3EF4(var_4);
    var_5.icon = _id_3EED(var_4);
    var_5._id_3EC2 = _id_3EF5(var_4);
    var_5._id_3EC3 = get_func_can_give(var_2, var_4);
    var_5._id_3EC4 = get_func_give(var_2, var_4);

    if(var_2 == "weaponupgrade") {
      var_5.slot = _id_3EEE(var_4);
    }
    if(var_2 == "weapon" && var_4 != "ammo") {
      var_5._id_3EC5 = 1;
      var_5._id_3EC6 = get_upgrades_possible(var_4);
      var_5.dropclip = get_item_drop_clip(var_4);
      var_5.dropstock = get_item_drop_stock(var_4);
    } else {
      var_5.enabled = is_item_enabled(var_4);
      var_5._id_3EC5 = _id_3EF1(var_4);
    }

    level.armory[var_2][var_4] = var_5;
    level.armory_all_items[var_4] = var_5;
  }
}

armory_setup(var_0, var_1, var_2, var_3) {
  var_4 = getEnt("armory_" + var_0, "targetname");

  if(!isDefined(var_4)) {
    return;
  }
  var_4._id_3EC8 = var_0;
  var_4.icon = var_1;
  var_4._id_3EC9 = var_2;
  var_4.menu = "survival_armory_" + var_0;
  var_4._id_3ECA = getEnt(var_4.target, "targetname");
  var_4._id_3ECB = getEnt(var_4._id_3ECA.target, "targetname");
  var_4._id_3ECB hide();
  var_4 thread armory_use_monitor();
  return var_4;
}

armory_setup_players() {
  foreach(var_1 in level.armory) {
    foreach(var_3 in var_1) {
      foreach(var_5 in level.players) {
        var_6 = var_3.type;
        var_7 = var_3.ref;
        var_8 = var_5 can_give_sentry(var_3.ref);
        var_5 set_ownership(var_6, var_7, var_8);
      }
    }
  }
}

can_give_sentry(var_0) {
  var_1 = get_index(var_0);

  if(var_1 == 0) {
    return 1;
  } else if(var_1 == 2) {
    return 2;
  } else {
    return 0;
  }
}

armory_use_monitor() {
  level endon("special_op_terminated");
  waittill_armory_unlocked();
  self._id_3ECB show();
  self._id_3ECA hide();
  var_0 = newhudelem();
  var_0.archived = 1;
  var_0.x = self.origin[0];
  var_0.y = self.origin[1];
  var_0.z = self.origin[2];
  var_0.alpha = 0.75;
  var_0 setshader(self.icon, 12, 12);
  var_0 setwaypoint(1, 1, 0);
  self.crateworldicon = var_0;
  self setHintString(self._id_3EC9);
  self makeusable();
  level notify("armory_open", self);

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    wait 0.1;

    if(!var_1 useButtonPressed()) {
      continue;
    }
    self notify("armory_use", var_1);
  }
}

waittill_armory_unlocked() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("wave_ended", var_0);

    if(level.armory_unlock[self._id_3EC8] == var_0) {
      return;
    }
  }
}

waittill_armory_warning_respond(var_0) {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("armory_interrupted");
  self endon("dog_attacks_player");

  for(;;) {
    self waittill("menuresponse", var_1, var_2);

    if(var_1 != var_0) {
      continue;
    } else {
      break;
    }
  }

  return var_2;
}

waittill_armory_respond() {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("armory_interrupted");
  self endon("dog_attacks_player");
  self waittill("menuresponse", var_0, var_1);
  return var_1;
}

armory_downed_interrupt() {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("dog_attacks_player");

  for(;;) {
    self waittill("player_downed");
    self notify("armory_interrupted");
  }
}

armory_usage_think(var_0) {
  level endon("special_op_terminated");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {}
  var_2._id_3ED4 = 0;

  for(;;) {
    var_0 waittill("armory_use", var_4);

    if(!var_4._id_3ED4) {
      var_4 thread armory_user_thread(var_0);
    }
  }
}

armory_user_thread(var_0) {
  level endon("special_op_terminated");
  self endon("death");
  thread armory_downed_interrupt();

  if(!isDefined(self) || !isPlayer(self) || !isalive(self)) {
    return;
  }
  if(var_0._id_3EC8 == "airsupport" && !has_open_slot_right()) {
    maps\_utility::display_hint("dpad_right_slot_full");
    return;
  }

  self notify("armory_opened", var_0);
  self._id_3ED4 = 1;
  var_1 = var_0.menu;
  self openpopupmenu(var_0.menu);
  self freezecontrols(1);

  for(;;) {
    var_2 = waittill_armory_respond();

    if(!isDefined(var_2)) {
      close_armory_interface();
      break;
    }

    if(var_2 == "quit") {
      self._id_3ED6 = undefined;
      close_armory_interface();
      break;
    }

    if(var_2 == "share") {
      if(self.survival_credit == 0) {
        continue;
      }
      var_3 = 500;

      if(self.survival_credit < 500) {
        var_3 = self.survival_credit;
      }
      foreach(var_5 in level.players) {
        if(var_5 == self) {
          var_5.survival_credit = var_5.survival_credit - var_3;
        }
        if(var_5 != self) {
          var_5.survival_credit = var_5.survival_credit + var_3;
        }
        var_6 = 1;
        var_5 notify("credit_updated", var_6);
      }
    }

    if(issubstr(var_2, "weaponswitch")) {
      var_8 = strtok(var_2, "_")[1];
      var_9 = get_ref_by_index(var_8);

      if(!isDefined(var_9) || var_9 == "") {
        continue;
      }
      var_10 = self getweaponslistprimaries();

      foreach(var_12 in var_10) {
        if(weaponclass(var_12) == "rocketlauncher" || weaponclass(var_12) == "item" || weaponclass(var_12) == "none") {
          continue;
        }
        if(get_weapon_base_name(var_12) == var_9) {
          self._id_3ED6 = var_12;
          self notify("new_weapon_selected");
          break;
        }
      }
    }

    if(issubstr(var_2, "purchase")) {
      var_14 = strtok(var_2, "_")[1];
      var_15 = get_ref_by_index(var_14);
      var_16 = _id_3EF4(var_15);
      var_17 = 0;

      if((var_15 == "rpg_survival" || var_15 == "iw5_riotshield_so") && !self hasweapon(var_15) && isDefined(get_replaceable_weapon())) {
        self openpopupmenu("survival_armory_replacement_warning");
        var_2 = waittill_armory_warning_respond("survival_armory_replacement_warning");

        if(!isDefined(var_2) || var_2 != "continue") {
          close_armory_interface();
          thread armory_user_thread(var_0);
          return;
        } else {
          var_17 = 1;
        }
      }

      if(self.survival_credit >= var_16) {
        if(get_index(var_15)) {
          self notify("armory_opened", var_0);
          get_icon(var_15);

          if(_id_3EF0(var_15) == "sniper") {
            self._id_3ED6 = var_15;
            give_weapon_upgrade(strtok(var_15, "_")[1] + "scope");
          }

          self.survival_credit = self.survival_credit - var_16;
          self notify("credit_updated");
          var_18 = _id_3EEF(var_15);

          if(var_18 == "weapon" || var_18 == "weaponupgrade") {
            maps\_specialops::so_achievement_update("ARMS_DEALER", var_15);
          }
          if(_id_3EF0(var_15) == "sniper") {
            maps\_specialops::so_achievement_update("ARMS_DEALER", strtok(var_15, "_")[1] + "scope");
          }
          if(var_18 == "airsupport") {
            maps\_specialops::so_achievement_update("DANGER_ZONE", var_15);
          }
          if(var_18 == "equipment") {
            maps\_specialops::so_achievement_update("DEFENSE_SPENDING", var_15);
          }
        }
      }

      if(var_17) {
        close_armory_interface();
        thread armory_user_thread(var_0);
        return;
      }

      if(var_0._id_3EC8 == "airsupport") {
        close_armory_interface();
        break;
      }
    }
  }
}

close_armory_interface() {
  self closepopupmenu();
  self freezecontrols(0);
  self notify("armory_closed");
  self._id_3ED4 = 0;
}

create_player_pip() {
  if(!isDefined(self.pip)) {
    self.pip = self newpip();
  }
  self.pip.entity = spawn("script_model", self.origin);
  self.pip.entity setModel("tag_origin");
  wait 0.05;
  self.pip.tag = "tag_origin";
  self.pip.fov = 65;
  self.pip.freecamera = 1;
  self.pip.enableshadows = 0;
  self.pip.x = -40;
  self.pip.y = 310;
  self.pip.width = 240;
  self.pip.height = 135;
  self.pip.enable = 0;
}

sentry_setup() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("new_sentry", var_0);
    var_0 setthreatbiasgroup("sentry");

    if(weapontype(var_0.weaponname) == "projectile") {
      var_0 setconvergenceheightpercent(0);
      continue;
    }

    var_0 setconvergenceheightpercent(0.7);
  }
}

sentry_pip_cam(var_0) {
  self endon("death");
  var_0 endon("death");
  thread death_pip_disable(var_0);

  for(;;) {
    link_pip_cam_to(var_0);
    setup_pip_name(var_0);

    if(!self.pip.enable) {
      self.pip.enable = 1;
    }
    var_0 waittill("sentry_move_started");
    self.pip.entity unlink();

    if(self.pip.enable) {
      self.pip.enable = 0;
    }
    if(isDefined(self.pip_display_name)) {
      self.pip_display_name destroy();
    }
    var_0 waittill("sentry_move_finished");
  }
}

cycle_sentry_pip() {
  self endon("death");
  self notifyonplayercommand("pip_cycle", "+actionslot 2");

  if(!isDefined(self._id_3EDF)) {
    self._id_3EDF = 0;
  }
  for(;;) {
    self waittill("pip_cycle");

    if(isDefined(level.placed_sentry) && level.placed_sentry.size) {
      if(self._id_3EDF > level.placed_sentry.size - 1) {
        self._id_3EDF = 0;
      }
      pip_patch_into(self._id_3EDF);
      self._id_3EDF++;
    }
  }
}

death_pip_disable(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(self.pip.enable) {
    self.pip.enable = 0;
  }
  self.pip_display_name destroy();
}

pip_patch_into(var_0) {
  var_1 = level.placed_sentry[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  if(self.pip.enable) {
    self.pip.enable = 0;
  }
  link_pip_cam_to(var_1);
  setup_pip_name(self);

  if(!self.pip.enable) {
    self.pip.enable = 1;
  }
  self.pip._id_3EE2 = var_0;
}

setup_pip_name(var_0) {
  if(isDefined(self.pip_display_name)) {
    self.pip_display_name destroy();
  }
  self.pip_display_name = newhudelem();
  self.pip_display_name.alpha = 1;
  self.pip_display_name.x = self.pip.x;
  self.pip_display_name.y = self.pip.y - 20;
  self.pip_display_name.hidewheninmenu = 0;
  self.pip_display_name.hidewhendead = 1;
  self.pip_display_name.fontscale = 1.25;

  if(!isDefined(self.pip._id_3EE2)) {
    self.pip._id_3EE2 = 0;
  }
  self.pip_display_name.label = "Sentry #" + self.pip._id_3EE2 + " [Dpad down to cycle]";
}

link_pip_cam_to(var_0) {
  var_1 = -12 * vectorNormalize(anglesToForward(var_0.angles));
  var_2 = var_0 gettagorigin("mg01") + (0, 0, 12) + var_1;
  self.pip.entity unlink();
  self.pip.entity.origin = var_2;
  self.pip.entity.angles = var_0.angles;
  self.pip.entity linkTo(var_0, "mg01");
}

get_total_sentries() {
  var_0 = 0;

  if(isDefined(level.placed_sentry) && level.placed_sentry.size) {
    var_0 = var_0 + level.placed_sentry.size;
  }
  foreach(var_2 in level.players) {
    if(var_2 maps/_sp_killstreaks::has_killstreak("sentry")) {
      var_0++;
    }
    if(var_2 maps/_sp_killstreaks::has_killstreak("sentry_gl")) {
      var_0++;
    }
  }

  return var_0;
}

has_sentry() {
  if(maps/_sp_killstreaks::has_killstreak("sentry")) {
    return 1;
  }
  if(maps/_sp_killstreaks::has_killstreak("sentry_gl")) {
    return 1;
  }
  foreach(var_1 in level.placed_sentry) {
    if(isDefined(var_1) && isDefined(var_1.attacker) && isPlayer(var_1.attacker) && var_1.attacker == self) {
      return 1;
    }
  }

  return 0;
}

track_ownership() {
  self endon("death");
  wait 0.05;

  for(;;) {
    self waittill("armory_opened", var_0);

    for(;;) {
      foreach(var_2 in level.armory[var_0._id_3EC8]) {
        var_3 = can_give_sentry(var_2.ref);
        set_ownership(var_2.type, var_2.ref, var_3);
      }

      if(var_0._id_3EC8 == "weapon") {
        foreach(var_2 in level.armory["weaponupgrade"]) {
          var_3 = can_give_sentry(var_2.ref);
          set_ownership(var_2.type, var_2.ref, var_3);
        }
      }

      var_7 = common_scripts\utility::waittill_any_timeout(0.05, "armory_closed", "new_weapon_selected");

      if(var_7 == "armory_closed") {
        break;
      }
    }
  }
}

set_ownership(var_0, var_1, var_2) {
  maps\_specialops::_setplayerdata_array("armory" + var_0, var_1, var_2);
}

claymoresentientfunc(var_0) {
  self makeentitysentient(var_0, 1);
  self.attackeraccuracy = 2;
  self.maxvisibledist = 356;
  self.threatbias = -1000;
  self.detonateradius = 96;
}

has_open_slot_right() {
  var_0 = self getweaponhudiconoverride("actionslot4");

  if(isDefined(var_0) && var_0 != "none") {
    return 0;
  }
  if(self hasweapon("air_support_strobe")) {
    return 0;
  }
  return !maps/_sp_killstreaks::has_any_killstreak();
}

hint_bubble() {}

item_exist(var_0) {
  return isDefined(level.armory_all_items) && isDefined(level.armory_all_items[var_0]);
}

_id_3EEC(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].repeating;
  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 0));
}

get_ref_by_index(var_0) {
  return tablelookup("sp/survival_armories.csv", 0, var_0, 1);
}

_id_3EED(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].icon;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 6);
}

_id_3EEE(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].slot;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 2);
}

_id_3EEF(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].type;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 2);
}

_id_3EF0(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0]._id_3EC0;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 11);
}

_id_3EF1(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0]._id_3EC5;
  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 10));
}

get_upgrades_possible(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0]._id_3EC6;
  }
  var_1 = tablelookup("sp/survival_armories.csv", 1, var_0, 8);
  var_1 = strtok(var_1, " ");
  return var_1;
}

get_name(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].name;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 4);
}

_id_3EF3(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].desc;
  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 5);
}

_id_3EF4(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0]._id_3EC1;
  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 3));
}

_id_3EF5(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0]._id_3EC2;
  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 7));
}

is_item_enabled(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].enabled;
  }
  var_1 = tablelookup("sp/survival_armories.csv", 1, var_0, 9);

  if(!isDefined(var_1) || var_1 == "") {
    return 1;
  }
  if(!issubstr(var_1, level.script)) {
    return 1;
  }
  return 0;
}

get_item_drop_stock(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].dropstock;
  }
  return int(strtok(tablelookup("sp/survival_armories.csv", 1, var_0, 9), " ")[1]);
}

get_item_drop_clip(var_0) {
  if(item_exist(var_0)) {
    return level.armory_all_items[var_0].dropclip;
  }
  return int(strtok(tablelookup("sp/survival_armories.csv", 1, var_0, 9), " ")[0]);
}

get_index(var_0) {
  var_1 = level.armory_all_items[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }
  return self[[var_1._id_3EC3]](var_0);
}

get_icon(var_0) {
  var_1 = level.armory_all_items[var_0];
  self[[var_1._id_3EC4]](var_0);
}

get_func_can_give(var_0, var_1) {
  if(item_exist(var_1)) {
    return level.armory_all_items[var_1]._id_3EC3;
  }
  var_2 = ::get_slot;

  if(var_0 == "weapon") {
    if(var_1 == "ammo") {
      var_2 = ::can_give_ammo;
    } else {
      var_2 = ::can_give_weapon;
    }
  } else if(var_0 == "weaponupgrade") {
    var_2 = ::can_give_weapon_upgrade;
  } else if(var_0 == "equipment") {
    switch (var_1) {
      case "flash_grenade":
      case "fraggrenade":
        var_2 = ::can_give_grenade;
        break;
      case "c4":
      case "claymore":
        var_2 = ::can_give_slotted_explosive;
        break;
      case "rpg_survival":
        var_2 = ::can_give_launcher;
        break;
      case "iw5_riotshield_so_upgrade":
      case "iw5_riotshield_so":
        var_2 = ::can_give_riotshield_so;
        break;
      case "sentry_gl":
      case "sentry":
        var_2 = ::get_maxstock;
        break;
      case "juggernaut_suit":
      case "armor":
        var_2 = ::can_give_armor;
        break;
      case "laststand":
        var_2 = ::can_give_laststand;
        break;
      default:
        break;
    }
  } else if(var_0 == "airsupport") {
    switch (var_1) {
      case "remote_missile":
        var_2 = ::get_cost;
        break;
      case "friendly_support_riotshield":
      case "friendly_support_delta":
        var_2 = ::can_give_friendlies;
        break;
      case "precision_airstrike":
        var_2 = ::can_give_airstrike;
        break;
      case "manned_chopper":
      case "assault_chopper":
        var_2 = ::give_default;
        break;
      case "specialty_bulletaccuracy":
      case "specialty_detectexplosive":
      case "specialty_quickdraw":
      case "specialty_fastreload":
      case "specialty_longersprint":
      case "specialty_stalker":
        var_2 = ::can_give_perk_care_package;
        break;
      default:
        break;
    }
  } else {}

  return var_2;
}

get_func_give(var_0, var_1) {
  if(item_exist(var_1)) {
    return level.armory_all_items[var_1]._id_3EC4;
  }
  var_2 = ::get_type;

  if(var_0 == "weapon") {
    if(var_1 == "ammo") {
      var_2 = ::give_ammo;
    } else {
      var_2 = ::give_weapon;
    }
  } else if(var_0 == "weaponupgrade") {
    var_2 = ::give_weapon_upgrade;
  } else if(var_0 == "equipment") {
    switch (var_1) {
      case "flash_grenade":
      case "fraggrenade":
        var_2 = ::give_grenade;
        break;
      case "c4":
      case "claymore":
        var_2 = ::give_slotted_explosive;
        break;
      case "rpg_survival":
        var_2 = ::give_launcher;
        break;
      case "iw5_riotshield_so_upgrade":
      case "iw5_riotshield_so":
        var_2 = ::get_sub_type;
        break;
      case "sentry_gl":
      case "sentry":
        var_2 = ::give_sentry;
        break;
      case "juggernaut_suit":
      case "armor":
        var_2 = ::get_desc;
        break;
      case "laststand":
        var_2 = ::give_laststand;
        break;
      default:
        break;
    }
  } else if(var_0 == "airsupport") {
    switch (var_1) {
      case "remote_missile":
        var_2 = ::give_remote_missile;
        break;
      case "friendly_support_riotshield":
      case "friendly_support_delta":
        var_2 = ::get_unlock_rank;
        break;
      case "precision_airstrike":
        var_2 = ::can_give_default;
        break;
      case "manned_chopper":
      case "assault_chopper":
        var_2 = ::give_riotshield_so;
        break;
      case "specialty_bulletaccuracy":
      case "specialty_detectexplosive":
      case "specialty_quickdraw":
      case "specialty_fastreload":
      case "specialty_longersprint":
      case "specialty_stalker":
        var_2 = ::give_perk_care_package;
        break;
      default:
        break;
    }
  } else {}

  return var_2;
}

get_slot(var_0) {
  return 0;
}

get_type(var_0) {
  return;
}

can_give_ammo(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weaponclass(var_3) == "rocketlauncher" || weaponclass(var_3) == "item" || weaponclass(var_3) == "none") {
      continue;
    }
    if(self getweaponammoclip(var_3) < weaponclipsize(var_3) || self getweaponammostock(var_3) < weaponmaxammo(var_3)) {
      return 1;
    }
    var_4 = weaponaltweaponname(var_3);

    if(var_4 != "none" && self getweaponammoclip(var_4) < weaponclipsize(var_4) || self getweaponammostock(var_4) < weaponmaxammo(var_4)) {
      return 1;
    }
  }

  return 0;
}

give_ammo(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == "rpg_survival") {
      continue;
    }
    give_ammo_max(var_3);
  }
}

give_ammo_max(var_0) {
  if(weaponinventorytype(var_0) == "altmode") {
    var_0 = get_weapon_name_from_alt(var_0);
  }
  self setweaponammoclip(var_0, weaponclipsize(var_0));
  self setweaponammostock(var_0, weaponmaxammo(var_0));
  var_1 = weaponaltweaponname(var_0);

  if(var_1 != "none") {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
    self setweaponammostock(var_1, weaponmaxammo(var_1));
  }
}

can_give_weapon(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = 0;
  var_3 = self getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(weaponclass(var_5) == var_1) {
      var_2 = 1;
      break;
    }
  }

  if(var_2 == 0) {
    return 1;
  }
  var_7 = get_weapon_base_name(var_0);

  foreach(var_5 in var_3) {
    if(weaponclass(var_5) == "rocketlauncher" || weaponclass(var_5) == "item" || weaponclass(var_5) == "none") {
      continue;
    }
    var_9 = get_weapon_base_name(var_5);

    if(var_9 == var_7) {
      return 0;
    }
  }

  return 1;
}

give_weapon(var_0, var_1) {
  var_2 = get_replaceable_weapon();

  if(isDefined(var_2)) {
    self takeweapon(var_2);
  }
  self giveweapon(var_0);

  if(!isDefined(var_1)) {
    give_ammo_max(var_0);
  }
  self switchtoweapon(var_0);
}

get_replaceable_weapon() {
  var_0 = self getweaponslistprimaries();

  if(var_0.size > 1) {
    var_1 = self getcurrentweapon();

    if(weaponinventorytype(var_1) == "altmode") {
      var_1 = get_weapon_name_from_alt(var_1);
    }
    if(isDefined(var_1) && weaponinventorytype(var_1) == "primary") {
      return var_1;
    } else {
      var_2 = self getweaponslist("primary");

      foreach(var_4 in var_2) {
        if(weaponclass(var_4) != "item") {
          return var_4;
        }
      }
    }
  }

  return undefined;
}

can_give_weapon_upgrade(var_0) {
  var_1 = undefined;

  if(isDefined(self._id_3ED6)) {
    var_1 = self._id_3ED6;
  } else {
    var_1 = self getcurrentweapon();
  }
  if(weaponinventorytype(var_1) == "altmode") {
    var_1 = get_weapon_name_from_alt(var_1);
  }
  if(!isDefined(var_1) || var_1 == "none" || weaponinventorytype(var_1) != "primary" || weaponclass(var_1) == "item" || weaponclass(var_1) == "rocketlauncher" || weaponclass(var_1) == "none") {
    return 0;
  }
  var_2 = get_weapon_base_name(var_1);
  var_3 = get_upgrades_possible(var_2);

  if(!var_3.size) {
    return 0;
  }
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(var_0 == var_6) {
      var_4 = 1;
      break;
    }
  }

  if(!var_4) {
    return 0;
  }
  var_8 = get_upgrades_on_weapon(var_1);

  foreach(var_6 in var_8) {
    if(var_0 == var_6) {
      return 2;
    }
  }

  return 1;
}

give_weapon_upgrade(var_0) {
  var_1 = self getcurrentweapon();

  if(isDefined(self._id_3ED6)) {
    var_1 = self._id_3ED6;
  }
  if(weaponinventorytype(var_1) == "altmode") {
    var_1 = get_weapon_name_from_alt(var_1);
  }
  if(!isDefined(var_1) || weaponinventorytype(var_1) != "primary") {
    return;
  }
  var_2 = get_upgrades_on_weapon(var_1);
  var_3 = undefined;
  var_4 = _id_3EEE(var_0);

  if(var_2.size) {
    foreach(var_6 in var_2) {
      if(var_4 == _id_3EEE(var_6)) {
        var_3 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_3)) {
    foreach(var_9, var_6 in var_2) {
      if(var_6 == var_3) {
        var_2[var_9] = var_0;
        break;
      }
    }
  } else {
    var_2[var_2.size] = var_0;
  }
  var_10 = get_weapon_base_name(var_1);

  for(var_11 = var_10; var_2.size > 0; var_2 = common_scripts\utility::array_remove(var_2, var_12)) {
    var_12 = var_2[0];

    for(var_13 = 1; var_13 < var_2.size; var_13++) {
      if(common_scripts\utility::is_later_in_alphabet(var_12, var_2[var_13])) {
        var_12 = var_2[var_13];
      }
    }

    var_11 = var_11 + ("_" + get_attachment_fullname(var_12, var_10));
  }

  var_14 = self getweaponammoclip(var_1);
  var_15 = self getweaponammostock(var_1);
  var_16 = undefined;
  var_17 = undefined;
  var_18 = weaponaltweaponname(var_1);

  if(var_18 != "none") {
    var_16 = self getweaponammoclip(var_18);
    var_17 = self getweaponammostock(var_18);
  }

  self takeweapon(var_1);
  self giveweapon(var_11);
  self setweaponammoclip(var_11, var_14);
  self setweaponammostock(var_11, var_15);
  var_19 = weaponaltweaponname(var_11);

  if(var_19 != "none") {
    if(var_4 != "main") {
      self setweaponammoclip(var_19, var_16);
      self setweaponammostock(var_19, var_17);
    } else {
      self setweaponammoclip(var_19, weaponclipsize(var_19));
      self setweaponammostock(var_19, weaponmaxammo(var_19));
    }
  }

  maps\_so_survival::wave_has_boss(var_11);
  self switchtoweapon(var_11);
}

get_attachment_fullname(var_0, var_1) {
  var_2 = _id_3EF0(var_1);

  switch (var_2) {
    case "smg":
      if(var_0 == "reflex") {
        return "reflexsmg";
      } else if(var_0 == "eotech") {
        return "eotechsmg";
      } else if(var_0 == "acog") {
        return "acogsmg";
      } else if(var_0 == "thermal") {
        return "thermalsmg";
      }
    case "lmg":
      if(var_0 == "reflex") {
        return "reflexlmg";
      } else if(var_0 == "eotech") {
        return "eotechlmg";
      }
    case "machinepistol":
      if(var_0 == "reflex") {
        return "reflexsmg";
      } else if(var_0 == "eotech") {
        return "eotechsmg";
      }
    default:
      return var_0;
  }
}

get_attachment_basename(var_0) {
  if(issubstr(var_0, "reflex")) {
    return "reflex";
  }
  if(issubstr(var_0, "eotech")) {
    return "eotech";
  }
  if(issubstr(var_0, "acog")) {
    return "acog";
  }
  if(issubstr(var_0, "reflex")) {
    return "reflex";
  }
  return var_0;
}

get_weapon_base_name(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(weaponinventorytype(var_0) == "altmode") {
    var_2 = 4;
  }
  for(var_4 = var_2 + 4; var_4 < var_0.size; var_4++) {
    if(var_0[var_4] == "_") {
      var_3 = var_4 + 3;
      break;
    }
  }

  var_1 = getsubstr(var_0, var_2, var_3);
  return var_1;
}

get_upgrades_on_weapon(var_0) {
  var_1 = [];
  var_2 = get_weapon_base_name(var_0);

  if(var_2 == var_0) {
    return var_1;
  }
  var_3 = getsubstr(var_0, var_2.size);
  var_4 = strtok(var_3, "_");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] = get_attachment_basename(var_4[var_5]);
  }
  return var_4;
}

get_weapon_name_from_alt(var_0) {
  if(weaponinventorytype(var_0) != "altmode") {
    return var_0;
  }
  return getsubstr(var_0, 4);
}

can_give_grenade(var_0) {
  var_1 = _id_3EF1(var_0);
  return self getweaponammostock(var_0) < var_1;
}

give_grenade(var_0) {
  if(!self hasweapon(var_0)) {
    self giveweapon(var_0);
  }
  if(issubstr(var_0, "flash") && self getoffhandprimaryclass() != "flash") {
    self setoffhandsecondaryclass("flash");
  }
  var_1 = _id_3EF1(var_0);
  self setweaponammostock(var_0, var_1);
}

can_give_launcher(var_0) {
  if(self hasweapon(var_0)) {
    if(var_0 == "rpg_survival") {
      var_1 = self getweaponammoclip("rpg_survival") + self getweaponammostock("rpg_survival");
      return _id_3EF1("rpg_survival") > var_1;
    }
  }

  return 1;
}

can_give_slotted_explosive(var_0) {
  if(self hasweapon(var_0)) {
    if(var_0 == "claymore") {
      var_1 = self getweaponammostock(var_0);
      return _id_3EF1(var_0) != var_1;
    }

    if(var_0 == "c4") {
      var_1 = self getweaponammostock(var_0);
      return _id_3EF1(var_0) != var_1;
    }
  }

  return 1;
}

give_launcher(var_0) {
  if(!self hasweapon(var_0)) {
    if(var_0 == "rpg_survival") {
      give_weapon("rpg_survival", 1);
      self setweaponammoclip("rpg_survival", 1);
      self setweaponammostock("rpg_survival", 1);
    }
  } else if(var_0 == "rpg_survival") {
    var_1 = self getweaponammoclip(var_0) + self getweaponammostock(var_0);
    var_2 = 1;
    var_3 = int(min(1 + var_1, _id_3EF1(var_0) - 1));
    self setweaponammoclip("rpg_survival", var_2);
    self setweaponammostock("rpg_survival", var_3);
    self switchtoweapon("rpg_survival");
  }
}

give_slotted_explosive(var_0) {
  var_1 = 5;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  if(!self hasweapon(var_0)) {
    if(var_0 == "claymore") {
      var_4 = 1;
    } else if(var_0 == "c4") {
      var_4 = 2;
    }
    self giveweapon(var_0);
    self setactionslot(var_4, "weapon", var_0);
  } else {
    var_2 = self getweaponammostock(var_0);
  }
  self setweaponammostock(var_0, var_2 + var_1 - var_3);
}

can_give_riotshield_so(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "riotshield")) {
      return 0;
    }
  }

  return 1;
}

get_sub_type(var_0) {
  give_weapon(var_0, 1);
}

get_maxstock(var_0) {
  if(!has_open_slot_right()) {
    return 0;
  }
  if(maps\_utility::is_coop()) {
    return !has_sentry() && get_total_sentries() < 2;
  } else {
    return get_total_sentries() < 2;
  }
}

give_sentry(var_0) {
  thread maps/_sp_killstreaks::give_sp_killstreak(var_0);
}

can_give_armor(var_0) {
  if(!isDefined(self.armor)) {
    return 1;
  }
  var_1 = 0;

  if(var_0 == "armor") {
    var_1 = 250;
  } else if(var_0 == "juggernaut_suit") {
    var_1 = 500;
  }
  if(self.armor["points"] < var_1) {
    return 1;
  }
  return 0;
}

get_desc(var_0) {
  give_armor_amount(var_0);
}

armor_init() {
  self._id_3F19 = 0;
  self.armor = [];
  self.armor["type"] = "";
  self.armor["points"] = 0;
  thread player_armor_shield();
}

give_armor_amount(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(var_0 == "armor") {
      var_1 = 250;
    } else if(var_0 == "juggernaut_suit") {
      var_1 = 500;
    } else {
      return;
    }
  }

  if(!isDefined(self.armor)) {
    armor_init();
  }
  self.dogs_dont_instant_kill = 1;
  self.armor["type"] = var_0;
  self.armor["points"] = var_1;
  self._id_3F19 = var_1;
  self notify("health_update");
}

player_armor_shield() {
  self endon("death");

  if(isDefined(self._id_3F1C)) {
    return;
  }
  self._id_3F1C = 1;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.previous_health = int(min(100, self.health + var_0));
    self.saved_by_armor = 0;

    if(self.armor["points"] > 0) {
      self.saved_by_armor = 1;
      var_10 = self.armor["points"] - var_0;
      var_11 = int(max(0, 0 - var_10));

      if(!var_11) {
        self.armor["points"] = self.armor["points"] - var_0;
        self setnormalhealth(1);
      } else {
        var_12 = maps/_so_survival_code::int_capped(self.previous_health - var_11, 1, 100) / 100;
        self setnormalhealth(var_12);

        if(self.armor["points"] + self.previous_health <= var_0) {
          self.saved_by_armor = 0;
        }
        self.armor["points"] = 0;
      }

      if(self.armor["points"] <= 0) {
        self.dogs_dont_instant_kill = undefined;
      }
      self notify("health_update");
    }
  }
}

can_give_laststand(var_0) {
  return maps\_laststand::get_lives_remaining() == 0;
}

give_laststand(var_0) {
  maps\_laststand::update_lives_remaining(1);
}

get_cost(var_0) {
  return has_open_slot_right();
}

give_remote_missile(var_0) {
  thread maps/_sp_killstreaks::give_sp_killstreak(var_0);
}

can_give_friendlies(var_0) {
  if(!has_open_slot_right()) {
    return 0;
  }
  var_1 = getaiarray("allies");

  foreach(var_3 in var_1) {
    if(isalive(var_3) && isDefined(var_3.owner) && var_3.owner == self) {
      return 0;
    }
  }

  return 1;
}

get_unlock_rank(var_0) {
  thread give_friendlies_monitor_use(var_0);
}

give_friendlies_monitor_use(var_0) {
  self endon("death");
  var_1 = "specops_ui_deltasupport";

  if(var_0 == "friendly_support_delta") {
    var_1 = "specops_ui_deltasupport";
  }
  if(var_0 == "friendly_support_riotshield") {
    var_1 = "specops_ui_riotshieldsupport";
  }
  self setweaponhudiconoverride("actionslot4", var_1);
  notifyoncommand("friendly_support_called", "+actionslot 4");
  self waittill("friendly_support_called");
  maps\_so_survival::spawn_allies(self.origin, var_0, self);
  self setweaponhudiconoverride("actionslot4", "none");
}

can_give_airstrike(var_0) {
  return !self hasweapon("air_support_strobe");
}

can_give_default(var_0) {
  thread maps/_air_support_strobe::enable_strobes_for_player();
  thread sticky_strobe();
  thread disable_strobe_for_player();
}

sticky_strobe() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("strobe_timeout");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0._id_3E9B = 0;

    if(var_1 != "air_support_strobe") {
      continue;
    }
    var_2 = getaispeciesarray("axis", "all");

    foreach(var_4 in var_2) {
      if(isai(var_4) && isalive(var_4)) {
        var_4 thread watch_for_strobe_hit();
      }
    }

    if(isDefined(level.bosses) && level.bosses.size) {
      foreach(var_7 in level.bosses) {
        if(isDefined(var_7.vehicletype)) {
          var_7 thread watch_for_strobe_hit();
        }
      }
    }

    thread strobe_timeout();
    self waittill("strobe_stuck_on_ai", var_9);
    var_0._id_3E9B = 1;

    if(isDefined(var_9)) {
      if(isai(var_9)) {
        var_0.origin = var_9 gettagorigin("j_mainroot");
        var_0 linkTo(var_9, "j_mainroot");
      } else {
        var_0.origin = var_9.origin;
        var_0 linkTo(var_9);
      }

      for(;;) {
        var_9 waittill("death");

        if(isDefined(var_0)) {
          var_0 unlink();
        }
        return;
      }
    }
  }
}

strobe_timeout() {
  self endon("strobe_stuck_on_ai");
  wait 5;
  self notify("strobe_timeout");
}

watch_for_strobe_hit() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_9) || !isDefined(var_1) || !isPlayer(var_1)) {
      continue;
    }
    if(var_9 == "air_support_strobe") {
      var_1 notify("strobe_stuck_on_ai", self);
      return;
    }
  }
}

disable_strobe_for_player() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("air_suport_strobe_fired_upon", var_0);

    if(var_0.owner == self && !self hasweapon("air_support_strobe")) {
      thread maps/_air_support_strobe::disable_strobes_for_player();
      return;
    }
  }
}

give_default(var_0) {
  return 0;
}

give_riotshield_so(var_0) {
  return;
}

can_give_perk_care_package(var_0) {
  if(self hasperk(var_0, 1)) {
    return 0;
  }
  return has_open_slot_right();
}

give_perk_care_package(var_0) {
  thread maps/_sp_killstreaks::give_sp_killstreak(var_0);
}

get_item_ent(var_0, var_1) {
  var_2 = "called get_item_ent() before armory tables are built!";

  if(isDefined(var_1)) {
    return level.armory[var_1][var_0];
  }
  return level.armory_all_items[var_0];
}

give_armor(var_0) {
  var_1 = var_0._id_3EC2;
  var_2 = maps\_rank::getrank();
  return var_2 >= var_1;
}

can_give_remote_missile(var_0) {
  return self.survival_credit >= var_0._id_3EC1;
}