/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_super.gsc
***********************************************/

function init_super() {
  var_0 = spawnStruct();
  level.superglobals = var_0;
  var_0.staticsuperdata = [];
  var_0.superweapons = [];
  var_0.superearnratemultiplier = 1;
  var_0.supersbyid = [];
  var_0.supersbyoffhand = [];
  var_0.pointeventdata = [];
  level.superglobals.staticsuperdata["super_recon_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_emp_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_emp_drone"].id = 1;
  level.superglobals.staticsuperdata["super_recon_drone"].id = 11;
}

function give_player_super(var_0) {
  var_1 = get_super_from_playerdata();

  if(!isDefined(var_1)) {
    var_1 = "role_tank";
  }

  if(isDefined(self.super) && var_1 == self.super) {
    return;
  }

  hasselfrevivetoken();
  self.super = var_1;
  thread update_super_icon(var_1);

  switch (self.super) {
    case "role_medic":
      thread scripts\cp\classes\cp_class_progression::give_medic_class();
      thread give_team_auto_revive();
      break;
    case "role_tank":
      thread scripts\cp\classes\cp_class_progression::give_tank_class();
      thread give_team_armor_buff();
      break;
    case "role_assault":
      thread scripts\cp\classes\cp_class_progression::give_assault_class();
      thread give_team_stopping_power();
      break;
    case "role_demolition":
      thread scripts\cp\classes\cp_class_progression::give_crusader_class();
      thread give_thermite_launcher();
      break;
    case "role_hunter":
      thread scripts\cp\classes\cp_class_progression::give_hunter_class();
      thread scriptable_carriable_use();
      break;
    case "role_engineer":
      thread scripts\cp\classes\cp_class_progression::give_engineer_class();
      thread giv_emp_drone();
      break;
  }

  thread init_super_for_player("super_default_zm");
}

function hasselfrevivetoken() {
  if(isDefined(self.super)) {
    switch (self.super) {
      case "role_medic":
        thread scripts\cp\classes\cp_class_progression::ref_12BDE();
        break;
      case "role_tank":
        thread scripts\cp\classes\cp_class_progression::ref_12BF8();
        break;
      case "role_assault":
        thread scripts\cp\classes\cp_class_progression::ref_12BC2();
        break;
      case "role_demolition":
        thread scripts\cp\classes\cp_class_progression::ref_12BC8();
        break;
      case "role_hunter":
        thread scripts\cp\classes\cp_class_progression::ref_12BD5();
        break;
      case "role_engineer":
        thread scripts\cp\classes\cp_class_progression::ref_12BCA();
        break;
    }

    return;
  }
}

function script_end() {
  hasselfrevivetoken();

  if(isDefined(self.super)) {
    switch (self.super) {
      case "role_medic":
        thread scripts\cp\classes\cp_class_progression::give_medic_class();
        break;
      case "role_tank":
        thread scripts\cp\classes\cp_class_progression::give_tank_class();
        break;
      case "role_assault":
        thread scripts\cp\classes\cp_class_progression::give_assault_class();
        break;
      case "role_demolition":
        thread scripts\cp\classes\cp_class_progression::give_crusader_class();
        break;
      case "role_hunter":
        thread scripts\cp\classes\cp_class_progression::give_hunter_class();
        break;
      case "role_engineer":
        thread scripts\cp\classes\cp_class_progression::give_engineer_class();
        break;
    }

    return;
  }
}

function debug_set_super() {
  self endon("death");

  for(;;) {
    var_0 = getDvar("scr_super_override", "");

    if(var_0 != "") {
      if(self.class != var_0) {
        hasselfrevivetoken();
        self setweaponammoclip("super_default_zm", 1);

        switch (var_0) {
          case "role_medic":
            thread scripts\cp\classes\cp_class_progression::give_medic_class();
            thread give_team_auto_revive();
            break;
          case "role_tank":
            thread scripts\cp\classes\cp_class_progression::give_tank_class();
            thread give_team_armor_buff();
            break;
          case "role_assault":
            thread scripts\cp\classes\cp_class_progression::give_assault_class();
            thread give_team_stopping_power();
            break;
          case "role_demolition":
            thread scripts\cp\classes\cp_class_progression::give_crusader_class();
            thread give_thermite_launcher();
            break;
          case "role_hunter":
            thread scripts\cp\classes\cp_class_progression::give_hunter_class();
            thread scriptable_carriable_use();
            break;
          case "role_engineer":
            thread scripts\cp\classes\cp_class_progression::give_engineer_class();
            thread giv_emp_drone();
            break;
        }
      }
    }

    wait 0.5;
  }
}

function test_player_data_set() {
  var_0 = ["medic", "tank", "crusader", "assault", "hunter", "engineer"];
  var_1 = 0;
  wait 10;

  for(;;) {
    var_2 = get_super_from_playerdata();
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }

    wait 1;
  }
}

function update_super_icon(var_0) {
  ref_130A6(var_0);
  self setclientomnvar("cp_loadout_changed", 0);
  wait 2;
  self setclientomnvar("cp_loadout_changed", 1);
}

function debug_give_super(var_0) {
  give_player_super(var_0);
}

function get_super_from_playerdata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
  return var_0;
}

function ref_130A6(var_0) {
  var_1 = int(tablelookup("cp/cp_fieldupgrades.csv", 1, var_0, 0));
  self setclientomnvar("ui_field_upgrade_icon", var_1);
}

function init_super_for_player(var_0) {
  give_super_weapon(var_0);
  thread scriptable_door_freeze_open(var_0);
  watch_for_super_button(var_0);
}

function ref_14476(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_super_watcher");

  for(;;) {
    var_1 = self getammocount(var_0);

    if(var_1 == 0) {
      self setweaponammoclip(var_0, 1);
    }

    wait 0.1;
  }
}

function give_super_weapon(var_0) {
  self giveweapon(var_0);
  self assignweaponoffhandspecial(var_0);
  self.specialoffhandgrenade = var_0;
  self setweaponammoclip(var_0, 1);
}

function scriptable_door_freeze_open(var_0) {
  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_init("player_spawned_with_loadout");
  }

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  self setweaponammoclip(var_0, 1);
}

function watch_for_super_button(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("end_super_watcher");
  self endon("end_super_watcher");
  self.super_ready = 0;
  thread recharge_super(var_0);
  thread ref_14476(var_0);
  self setclientomnvar("zm_faction_super", 0);
  self setclientomnvar("cp_super_ready", 0);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  jumpiffalse(scripts\engine\utility::flag_exist("player_safehouse_settings_toggled")) LOC_0000006d;
  scripts\engine\utility::flag_wait("player_safehouse_settings_toggled");

  for(;;) {
    self waittill("offhand_fired", var_1);

    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
      scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      self setweaponammoclip(var_0, 1);
      continue;
    }

    var_2 = var_1;

    if(issameweapon(var_1)) {
      var_2 = createheadicon(var_1);
    }

    if(var_2 == var_0) {
      var_3 = 0;

      if(!self.super_ready) {
        var_3 = 1;
      } else if(istrue(self.inlaststand)) {
        var_3 = 1;
      } else if(istrue(self.disable_super)) {
        var_3 = 1;
      } else if(istrue(level.ref_12B46)) {
        var_3 = 1;
      } else if(istrue(self.interrogating)) {
        var_3 = 1;
      } else if(scripts\cp\cp_weapon::ref_124AD(self)) {
        var_3 = 1;
      } else if(!istrue(self isonground())) {
        var_3 = 1;
      }

      if(isDefined(self.currentturret)) {
        var_3 = little_bird_mg_init(self);
      }

      if(!ref_13977()) {
        var_3 = 1;
      }

      if(isDefined(level.generate_grenade_types_via_dvar) && ![[level.generate_grenade_types_via_dvar]](self)) {
        var_3 = 1;
      }

      if(!var_3) {
        thread fire_super(var_0);
      } else {
        scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      }
    }

    self setweaponammoclip(var_0, 1);
  }
}

function fire_super(var_0) {
  self.super_ready = 0;
  self setclientomnvar("cp_super_ready", 0);
  thread display_super_fired_splash();
  run_super_loop(var_0);
}

function ref_13977() {
  if(self.class == "medic") {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      }

      if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
        var_0 = 1;
      }
    }

    return var_0;
  }

  return 1;
}

function recharge_super(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_super_watcher");
  var_1 = 120;
  var_2 = getdvarint("scr_super_time", 0);

  if(var_2) {
    var_1 = var_2;
  }

  if(istrue(self.ref_12D7D)) {
    if(!isDefined(self.super_progress)) {
      self.super_progress = 997;
    } else if(self.super_progress > 996) {
      self.super_progress = 997;
    }

    self.ref_12D7D = undefined;
  } else {
    self.super_progress = 997;
  }

  var_3 = gettime();
  var_4 = var_3;

  for(;;) {
    var_2 = getdvarint("scr_super_time", 0);

    if(var_2) {
      var_1 = var_2;
    }

    var_5 = 0;
    var_6 = gettime();

    if(istrue(self.super_activated)) {
      var_5 = 1;
    } else if(istrue(self.inlaststand)) {
      var_5 = 1;
    } else if(istrue(self.super_ready)) {
      var_5 = 1;
    } else if(istrue(self.disable_super)) {
      var_5 = 1;
    }

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete")) {
      var_5 = 1;
    }

    if(var_5) {
      var_4 = var_6;
      waitframe();
      continue;
    }

    var_7 = var_6 - var_4;
    var_8 = var_7 / var_1 * 1000 * 1000;
    var_8 *= scripts\cp\perks\cp_perks::get_perk("super_fill_scalar");
    increase_super_progress(var_8);
    var_9 = self.super_progress / 1000;

    if(var_9 > 0.998) {
      var_9 = 1;
    }

    self setclientomnvar("zm_faction_super", var_9);
    var_4 = var_6;

    if(var_9 >= 1) {
      self.super_ready = 1;
      self setclientomnvar("cp_super_ready", 1);
      display_super_ready_splash();
    }

    waitframe();
  }
}

function display_super_ready_splash() {
  if(!istrue(self.ref_13975)) {
    self.ref_13975 = 1;
    return;
  }

  if(!isDefined(self.class)) {
    self.class = "tank";
  }

  if(self usinggamepad()) {
    var_0 = "super_revive";

    switch (self.class) {
      case "medic":
        var_0 = "cp_super_revive";
        break;
      case "tank":
        var_0 = "cp_super_armor";
        break;
      case "crusader":
        var_0 = "cp_super_cluster";
        break;
      case "assault":
        var_0 = "cp_super_ammo";
        break;
      case "hunter":
        var_0 = "cp_super_mark";
        break;
      case "engineer":
        var_0 = "cp_super_emp";
        break;
    }
  } else {
    var_0 = "cp_super_revive_kbm";

    switch (self.class) {
      case "medic":
        var_0 = "cp_super_revive_kbm";
        break;
      case "tank":
        var_0 = "cp_super_armor_kbm";
        break;
      case "crusader":
        var_0 = "cp_super_cluster_kbm";
        break;
      case "assault":
        var_0 = "cp_super_ammo_kbm";
        break;
      case "hunter":
        var_0 = "cp_super_mark_kbm";
        break;
      case "engineer":
        var_0 = "cp_super_emp_kbm";
        break;
    }
  }

  var_1 = self getentitynumber();
  setomnvar("ui_class_power_ready", var_1);
  thread scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);
}

function display_super_fired_splash() {
  self endon("disconnect");
  var_0 = "super_revive_used";

  switch (self.class) {
    case "medic":
      var_0 = "cp_super_revive_used";
      break;
    case "tank":
      var_0 = "cp_super_armor_used";
      break;
    case "crusader":
      var_0 = "cp_super_cluster_used";
      break;
    case "assault":
      var_0 = "super_ammo_used";
      break;
    case "hunter":
      var_0 = "cp_super_mark_used";
      break;
    case "engineer":
      var_0 = "cp_super_sentry_used";
      break;
  }

  var_1 = self getentitynumber();
  setomnvar("ui_class_power_inuse", var_1);

  if(self.class == "medic" || self.class == "tank" || self.class == "assault") {
    setomnvar("cp_team_oriented_super_fired", var_1);
    wait 6;
    setomnvar("cp_team_oriented_super_ended", var_1);
    return;
  }

  self setclientomnvar("cp_super_fired", 1);
  wait 6;
  self setclientomnvar("cp_super_fired", 0);
}

function increase_super_progress(var_0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      if(isDefined(self.super_progress_scalar)) {
        var_0 *= self.super_progress_scalar;
      }

      self.super_progress += var_0;

      if(self.super_progress > 1000) {
        self.super_progress = 1000;
        return;
      }

      return;
    }

    return;
  }
}

function decrease_super_progress(var_0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      self.super_progress -= var_0;

      if(self.super_progress <= 0) {
        self.super_progress = 0;
        return;
      }

      return;
    }

    return;
  }
}

function drain_super_meter(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("end_super_meter_early");
  thread set_progress_to_zero_on_death();
  self.super_meter_draining = 1;
  var_1 = self getentitynumber();
  var_2 = gettime();
  var_3 = var_2;
  var_4 = 1;

  for(;;) {
    var_5 = gettime();
    var_6 = var_5 - var_3;
    var_7 = var_6 / var_0 * 1000;
    var_4 -= var_7;

    if(var_4 < 0) {
      var_4 = 0;
    }

    self setclientomnvar("zm_faction_super", var_4);
    var_3 = var_5;
    waitframe();

    if(var_4 <= 0) {
      self.super_progress = 0;
      self notify("meter_drained");
      break;
    }
  }

  switch (self.class) {
    case "engineer":
    case "medic":
    case "tank":
    case "assault":
      setomnvar("ui_class_power_reloading", var_1);
      break;
  }

  self.super_meter_draining = 0;
}

function set_progress_to_zero_on_death() {
  self endon("meter_drained");
  self waittill("death");
  self.super_progress = 0;
  self setclientomnvar("zm_faction_super", self.super_progress);
  self setclientomnvar("cp_super_fired", 0);
}

function end_super_meter_progress_early() {
  self notify("end_super_meter_early");
  self.super_progress = 0;
  self setclientomnvar("zm_faction_super", self.super_progress);
  self.super_meter_draining = 0;
}

function run_super_loop(var_0) {
  if(isDefined(self.super_activate_func)) {
    self[[self.super_activate_func]]();
  }

  while(istrue(self.super_activated)) {
    wait 0.1;
  }
}

function scriptable_carriable_use() {
  self.super_activate_func = &at_mine_movingplatform_update;
}

function give_instant_revive() {
  self.super_activate_func = &activate_instant_revive;
}

function give_team_armor_buff() {
  self.super_activate_func = &activate_team_armor_buff;
  self.super_progress_scalar = 0.25;
}

function give_thermite_launcher() {
  self.super_activate_func = &activate_thermite_launcher;
  self.super_progress_scalar = 0.5;
}

function give_auto_revive_crate() {
  self.super_activate_func = &activate_auto_revive_crate;
}

function give_team_auto_revive() {
  self.super_activate_func = &activate_team_auto_revive;
  self.super_progress_scalar = 0.25;
}

function give_team_stopping_power() {
  self.super_activate_func = &activate_team_stopping_power;
}

function giv_emp_drone() {
  if(isDefined(level.assassinationtimewarning)) {
    self.super_activate_func = level.assassinationtimewarning;
    return;
  }

  self.super_activate_func = &activate_emp_drone;
}

function activate_thermite_launcher() {
  self.super_activated = 1;
  self.gl_proj_override = "thermite";

  if(scripts\cp\cp_weapon::ref_124AD(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    self waittill("weapon_change");

    if(istrue(self.inlaststand)) {
      self.super_activated = 0;
      return;
    }
  }

  scripts\cp\crafting_system::givegrenadelauncher();
  thread drain_super_meter(1);
  scripts\cp\cp_analytics::ref_119BE(self, "thermite_launcher");
  self setclientomnvar("ui_thermite_class_power_on", gettime());
  var_0 = self getentitynumber();
  var_1 = "cp_super_cluster_used";

  foreach(var_3 in level.players) {
    var_3 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
  }

  while(istrue(self.has_gl)) {
    self waittill("weapon_removed");
  }

  setomnvar("ui_class_power_reloading", var_0);
  self setclientomnvar("ui_thermite_class_power_off", gettime());
  self.gl_proj_override = undefined;
  self.super_activated = 0;
}

function remove_launcher_after_timeout(var_0) {
  self endon("weapon_removed");
  wait var_0;
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_weapon_pickup(1);
  var_1 = "iw8_la_mike32_mp";
  self takeweapon(var_1);
  self switchtoweapon(self.last_weapon);
  self.has_gl = undefined;
  self notify("weapon_removed");
}

function team_unlimited_ammo() {
  foreach(var_1 in level.players) {
    var_1.has_infinite_ammo = 1;
    var_2 = ammo_round_up();
    thread unlimited_ammo(var_1);
  }
}

function at_mine_movingplatform_update() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread x1ops4();
  var_0 = scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();

  if(var_0) {
    var_1 = scripts\engine\utility::ref_143AE("super_use_succeeded", "super_use_failed", "laststand");

    if(var_1 == "super_use_succeeded") {
      var_2 = "cp_super_mark_used";

      foreach(var_4 in level.players) {
        var_4 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
      }

      scripts\cp\cp_analytics::ref_119BE(self, "scout drone");
      thread drain_super_meter(1);
      ref_14356();
      return;
    }

    self.super_activated = 0;
    return;
  }

  self.super_activated = 0;
}

function x1ops4() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", var_0);
  self.ref_12F15 = var_0;
}

function ref_14356() {
  var_0 = self getentitynumber();
  thread ref_143C5(5);
  ref_143C4();

  while(isDefined(self.ref_12F15)) {
    waitframe();
  }

  setomnvar("ui_class_power_reloading", var_0);
  self.super_activated = 0;
}

function ref_143C4() {
  self endon("scout_drone_timeout");

  while(!isDefined(self.ref_12F15)) {
    wait 0.1;
  }

  self notify("scout_drone_timeout");
}

function ref_143C5(var_0) {
  self endon("scout_drone_timeout");
  wait var_0;
  self notify("scout_drone_timeout");
}

function superusefinished(var_0, var_1, var_2, var_3) {
  self notify("super_use_finished_lb");

  if(istrue(var_0)) {
    self notify("super_use_failed");
  } else {
    self notify("super_use_succeeded");
  }

  self notify("super_use_finished");
}

function activate_mark_enemies() {
  self.super_activated = 1;
  self.marked_enemies = 1;
  thread drain_super_meter(1);
  thread scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();
  self.super_activated = 0;
}

function deactivate_mark_enemies(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\utility::ref_143B9(var_0, "force_end_super");
  self.marked_enemies = 0;
}

function mark_enemies(var_0) {
  var_1 = 2;
  var_2 = 2;
  var_3 = 3000;
  var_4 = var_3 * var_3;
  var_5 = gettime();
  var_6 = var_5 + var_0 * 1000;

  while(var_5 < var_6) {
    var_7 = [];

    foreach(var_9 in level.agentarray) {
      if(isalive(var_9) && isDefined(var_9.team)) {
        var_7 = var_9;
      }
    }

    var_7 = scripts\engine\utility::array_combine(var_7, level.players);
    var_7 = sortbydistance(var_7, self.origin);
    self setscriptablepartstate("marked_enemies_pulse", "active");

    for(var_11 = 0; var_11 < var_7.size; var_11++) {
      if(!isDefined(var_7[var_11])) {
        continue;
      }

      if(!isalive(var_7[var_11])) {
        continue;
      }

      if(distancesquared(var_7[var_11].origin, self.origin) > var_4) {
        continue;
      }

      if(self.team != var_7[var_11].team) {
        var_7[var_11] hudoutlineenable("outline_nodepth_red");
        waitframe();
      }
    }

    wait var_1;

    if(var_2 > 0) {
      var_7 = [];

      foreach(var_9 in level.agentarray) {
        if(isalive(var_9) && isDefined(var_9.team)) {
          var_7 = var_9;
        }
      }

      var_7 = scripts\engine\utility::array_combine(var_7, level.players);
      var_7 = sortbydistance(var_7, self.origin);

      for(var_11 = 0; var_11 < var_7.size; var_11++) {
        if(!isDefined(var_7[var_11])) {
          continue;
        }

        if(!isalive(var_7[var_11])) {
          continue;
        }

        if(self.team != var_7[var_11].team) {
          var_7[var_11] hudoutlinedisable();
          waitframe();
        }
      }

      self setscriptablepartstate("marked_enemies_pulse", "neutral");
      self notify("stop_mark_enemies");
      wait var_2;
    }

    var_5 = gettime();
  }

  var_7 = [];

  foreach(var_9 in level.agentarray) {
    if(isalive(var_9) && isDefined(var_9.team)) {
      var_7 = var_9;
    }
  }

  var_7 = scripts\engine\utility::array_combine(var_7, level.players);

  foreach(var_17 in var_7) {
    if(self.team != var_17.team) {
      self notify("stop_mark_enemies");
      var_17 hudoutlinedisable();
      var_17 notify("stopped_being_marked");
    }
  }

  self setscriptablepartstate("marked_enemies_pulse", "neutral");
}

function ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  var_0 = [];

  foreach(var_2 in self.weaponlist) {
    var_0 = self getammocount(var_2);
  }

  return var_0;
}

function unlimited_ammo(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_unlimited_ammo");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_infinite_ammo)) {
    var_1 = 0;

    foreach(var_3 in self.weaponlist) {
      var_4 = weaponclipsize(var_3);

      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;

        if(var_4 == 1) {
          var_5 = self getweaponammostock(var_3);
          var_5++;
          self setweaponammostock(var_3, var_5);
        } else {
          self setweaponammoclip(var_3, weaponclipsize(var_3), "left");
        }
      }

      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;
        self setweaponammoclip(var_3, weaponclipsize(var_3), "right");
      }

      if(var_1 == 0) {
        ammo_round_up();
      }
    }

    wait 0.05;
  }
}

function weapon_no_unlimited_check(var_0) {
  var_1 = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(var_3 in level.opweaponsarray) {
      if(var_0.basename == var_3) {
        var_1 = 0;
      }
    }
  }

  return var_1;
}

function deactivate_infinite_ammo(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\utility::ref_143B9(var_0, "force_end_super");

  foreach(var_3 in level.players) {
    var_3.has_infinite_ammo = undefined;
    var_3 scripts\cp\utility::enable_infinite_ammo(0);
  }
}

function activate_auto_revive_crate(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  var_1 = scripts\cp\crafting_system::giveadrenalinecrate();

  if(!istrue(var_1)) {
    return 0;
  }

  thread drain_super_meter(1);
  self.super_activated = 0;
}

function activate_team_auto_revive(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  var_1 = "cp_super_revive_used";
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_4)) {
      if(isDefined(var_4.last_stand_state) && var_4.last_stand_state == "bleed_out") {
        continue;
      }

      thread team_instant_revive();
      var_4 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
      scripts\cp\cp_laststand::record_revive_success(self, var_4);
      var_2 = 1;
    }
  }

  if(var_2) {
    scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
    scripts\cp\cp_analytics::ref_119BE(self, "team auto-revive");
    drain_super_meter(1);
  }

  self.super_activated = 0;
}

function team_instant_revive() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(!isDefined(self.dogtag)) {
      self.ref_140AC = 1;
      self giveandfireoffhand("adrenaline_mp");

      if(isDefined(self.reviveiconent)) {
        scripts\cp\cp_laststand::set_revive_icon_color(self.reviveiconent);
        self.reviveent makeunusable();
      }

      wait 3;
      scripts\cp\cp_laststand::instant_revive(self);
      self.ref_140AC = undefined;
      return;
    }

    return;
  }
}

function activate_instant_revive(var_0) {
  self.has_instant_revive = 1;
  self.old_revive_time_scalar = self.perk_data["revive_time_scalar"];
  self.perk_data["revive_time_scalar"] = 0;
  thread aoe_instant_revive(15);
  thread drain_super_meter(1);
  deactivate_instant_revive(15);
  self.super_activated = 0;
  var_1 = "cp_super_revive_used";

  foreach(var_3 in level.players) {
    var_3 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
  }
}

function deactivate_instant_revive(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\utility::ref_143B9(var_0, "force_end_super");
  self notify("stop_instant_revive");
  self.has_instant_revive = undefined;
  self.perk_data["revive_time_scalar"] = self.old_revive_time_scalar;
}

function aoe_instant_revive(var_0) {
  self endon("stop_instant_revive");
  self endon("death");
  var_1 = 100;
  var_2 = var_1 * var_1;
  var_3 = gettime() + var_0 * 1000;

  while(gettime() < var_3) {
    foreach(var_5 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_5)) {
        if(distancesquared(self.origin, var_5.origin) < var_2) {
          var_5 scripts\cp\cp_laststand::instant_revive(var_5);

          if(isDefined(var_5.dogtag)) {
            var_5.dogtag delete();
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
  scripts\cp\cp_analytics::ref_119BE(self, "team armor");
  thread deactivate_team_armor_buff(20);
  drain_super_meter(1);
  self.super_activated = 0;
}

function turn_on_team_armor_buff() {
  var_0 = 100;
  var_1 = getdvarint("scr_armor_max", 0);

  if(var_1) {
    var_0 = var_1;
  }

  var_2 = "cp_super_armor_used";

  foreach(var_4 in level.players) {
    if(on_the_same_team(self, var_4) && isalive(var_4)) {
      var_4.has_team_armor = 1;
      scripts\cp\cp_armor::givearmor(var_4, var_0, 1);
      var_4.old_armor_scalar = var_4 scripts\cp\perks\cp_perks::get_perk("enemy_damage_to_player_armor_scalar");
      var_4 scripts\cp\perks\cp_perks::set_perk("enemy_damage_to_player_armor_scalar", var_4.old_armor_scalar * 1.5);
      var_4 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
    }
  }

  setomnvar("ui_armor_class_power_used", 1);
}

function on_the_same_team(var_0, var_1) {
  if(isDefined(var_0.team_number) && isDefined(var_1.team_number)) {
    return (var_0.team_number == var_1.team_number);
  }

  return 1;
}

function remove_team_armor_buff() {
  foreach(var_1 in level.players) {
    if(on_the_same_team(self, var_1)) {
      var_1.has_team_armor = undefined;
      var_1 scripts\cp\perks\cp_perks::set_perk("enemy_damage_to_player_armor_scalar", var_1.old_armor_scalar);
    }
  }
}

function deactivate_team_armor_buff(var_0) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = self getentitynumber();
  var_2 = scripts\engine\utility::ref_143B9(var_0, "force_end_super");
  setomnvar("ui_class_power_reloading", var_1);
  setomnvar("ui_armor_class_power_used", 0);
  remove_team_armor_buff();
}

function activate_team_stopping_power() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  scripts\cp\cp_analytics::ref_119BE(self, "team stopping_power");
  var_0 = "cp_super_ammo_used";

  foreach(var_2 in level.players) {
    scr_br_collection_findpath(var_2);
    var_2 scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);
  }

  drain_super_meter(1);
  setomnvar("ui_ammo_class_power_on", gettime());
  self.super_activated = 0;
}

function scr_br_collection_findpath() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = weaponclipsize(var_0);
  self setweaponammoclip(var_0, var_1);
  thread ref_14442(var_0, var_1);
}

function ref_14442(var_0, var_1) {
  self endon("disconnect");
  thread ref_12BE5();
  thread stoppingpower_watchhcrweaponchange(var_0);
  thread stoppingpower_watchhcrweaponfire(var_0, var_1);
  self waittill("stoppingPower_removeHCR");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

function ref_12BE5() {
  self waittill("death");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

function stoppingpower_watchhcrweaponchange(var_0) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.gavehcr = 0;

  while(self hasweapon(var_0)) {
    if(self getcurrentweapon() == var_0) {
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

  self setclientomnvar("ui_ammo_class_power_off", gettime());
  self notify("stoppingPower_removeHCR");
}

function stoppingpower_watchhcrweaponfire(var_0, var_1) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = var_1;
  thread ref_138F1(var_0, var_1);

  while(self hasweapon(var_0)) {
    self waittill("weapon_fired", var_2);

    if(var_2 == var_0) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self setclientomnvar("ui_ammo_class_power_off", gettime());
  self notify("stoppingPower_removeHCR");
}

function ref_138F1(var_0, var_1) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = var_1;

  while(self hasweapon(var_0)) {
    self waittill("ammo_drained");
    self.rounds--;

    if(self.rounds <= 0) {
      break;
    }
  }

  self setclientomnvar("ui_ammo_class_power_off", gettime());
  self notify("stoppingPower_removeHCR");
}

function remove_team_stopping_power(var_0) {
  level notify("give_team_stopping_power");
  level endon("give_team_stopping_power");
  wait var_0;
  setomnvar("ui_ammo_class_power_off", gettime());

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_ammo_class_power_off", gettime());
    var_2 scripts\cp\utility::takeperk("specialty_bulletdamage");
  }
}

function activate_emp_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread x1ops5();
  var_0 = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();

  if(var_0) {
    monitormounted();
    ref_14357();
    return;
  }

  self.super_activated = 0;
}

function monitormounted() {
  var_0 = "cp_super_sentry_used";

  foreach(var_2 in level.players) {
    var_2 scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);
  }

  scripts\cp\cp_analytics::ref_119BE(self, "emp drone");
  thread drain_super_meter(1);
}

function x1ops5() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", var_0);
  self.monitorhotfoot = var_0;
  thread monitoringimpact();
  thread getcrateusetime();
}

function ref_14357() {
  thread ref_143E5(5);
  ref_143E4();

  while(isDefined(self.monitorhotfoot)) {
    wait 0.1;
  }

  self.super_activated = 0;
}

function ref_143E4() {
  self endon("emp_drone_timeout");

  while(!isDefined(self.monitorhotfoot)) {
    wait 0.1;
  }

  self notify("emp_drone_timeout");
}

function ref_143E5(var_0) {
  self endon("emp_drone_timeout");
  wait var_0;
  self notify("emp_drone_timeout");
}

function monitoringimpact() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");

  for(;;) {
    var_0 = prewaitandspawnclient();

    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        if(var_2 == self) {
          continue;
        }

        if(isDefined(var_2.chopper)) {
          continue;
        }

        if(isDefined(var_2) && var_2 scripts\cp_mp\emp_debuff::can_be_empd()) {
          var_3 = distancesquared(self.origin, var_2.origin);

          if(var_3 > 250000) {
            continue;
          }

          ref_1292B();
          return;
        }
      }
    }

    waitframe();
  }
}

function prewaitandspawnclient() {
  var_0 = scripts\cp\utility::getvehiclearray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.team) && var_3.team == "axis") {
      var_1 = var_3;
    }
  }

  var_5 = getEntArray("misc_turret", "classname");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.team) && var_7.team == "axis") {
      var_1 = var_7;
    }
  }

  foreach(var_10 in level.spawned_enemies) {
    if(istrue(isDefined(var_10.unittype) && var_10.unittype == "suicidebomber")) {
      var_1 = var_10;
    }
  }

  return var_1;
}

function ref_1292B() {
  self.owner notify("emp_drone_detonate");
  var_0 = "emp_drone_player_mp";
  var_1 = prewaitandspawnclient();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.vehiclename) && isDefined(level.vehicle.instances[var_3.vehiclename])) {
      if(isDefined(level.vehicle.instances[var_3.vehiclename][var_3 getentitynumber()])) {} else {
        var_3 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_0);
      }

      continue;
    }

    var_3 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_0);
  }
}

function getcrateusetime() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  var_0 = 500;

  for(;;) {
    var_1 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_2 = vectorNormalize(var_2);
    var_3 = rotatevector((0, 30, 0), self.angles);
    var_4 = var_1 + var_3;
    var_5 = rotatevector((0, -30, 0), self.angles);
    var_6 = var_1 + var_5;
    var_7 = prewaitandspawnclient();
    getcrossbowimpactfunc(var_1, var_1 + var_2 * var_0, var_7, "fwd");
    getcrossbowimpactfunc(var_4, var_4 + var_2 * var_0, var_7, "left");
    getcrossbowimpactfunc(var_6, var_6 + var_2 * var_0, var_7, "right");
    waitframe();
  }
}

function getcrossbowimpactfunc(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, self);

  if(isDefined(var_4)) {
    if(var_4["fraction"] == 1) {
      return;
    }

    if(isDefined(var_4["entity"])) {
      if(scripts\engine\utility::array_contains(var_2, var_4["entity"])) {
        ref_1292B();
        return;
      }
    }

    if(var_4["fraction"] < 0.2) {
      if(var_3 != "fwd") {
        wait 0.25;
      }

      ref_1292B();
      return;
    }

    return;
  }
}

function little_bird_mg_init(var_0) {
  if(isDefined(var_0.class)) {
    switch (var_0.class) {
      case "medic":
      case "tank":
      case "assault":
        return 0;
      case "vanguard":
      case "engineer":
      case "hunter":
        var_0.disable_super = 1;
        return 1;
    }

    return;
  }
}

function mousetraps(var_0) {
  var_0.disable_super = undefined;
}