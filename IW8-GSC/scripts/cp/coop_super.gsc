/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_super.gsc
***********************************************/

function init_super() {
  var0 = spawnStruct();
  level.superglobals = var0;
  var0.staticsuperdata = [];
  var0.superweapons = [];
  var0.superearnratemultiplier = 1;
  var0.supersbyid = [];
  var0.supersbyoffhand = [];
  var0.pointeventdata = [];
  level.superglobals.staticsuperdata["super_recon_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_emp_drone"] = spawnStruct();
  level.superglobals.staticsuperdata["super_emp_drone"].id = 1;
  level.superglobals.staticsuperdata["super_recon_drone"].id = 11;
}

function give_player_super(var0) {
  var1 = get_super_from_playerdata();

  if(!isDefined(var1)) {
    var1 = "role_tank";
  }

  if(isDefined(self.super) && var1 == self.super) {
    return;
  }

  hasselfrevivetoken();
  self.super = var1;
  thread update_super_icon(var1);

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
        thread scripts\cp\classes\cp_class_progression::ref_12bde();
        break;
      case "role_tank":
        thread scripts\cp\classes\cp_class_progression::ref_12bf8();
        break;
      case "role_assault":
        thread scripts\cp\classes\cp_class_progression::ref_12bc2();
        break;
      case "role_demolition":
        thread scripts\cp\classes\cp_class_progression::ref_12bc8();
        break;
      case "role_hunter":
        thread scripts\cp\classes\cp_class_progression::ref_12bd5();
        break;
      case "role_engineer":
        thread scripts\cp\classes\cp_class_progression::ref_12bca();
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
    var0 = getDvar("scr_super_override", "");

    if(var0 != "") {
      if(self.class != var0) {
        hasselfrevivetoken();
        self setweaponammoclip("super_default_zm", 1);

        switch (var0) {
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
  var0 = ["medic", "tank", "crusader", "assault", "hunter", "engineer"];
  var1 = 0;
  wait 10;

  for(;;) {
    var2 = get_super_from_playerdata();
    var1++;

    if(var1 >= var0.size) {
      var1 = 0;
    }

    wait 1;
  }
}

function update_super_icon(var0) {
  ref_130a6(var0);
  self setclientomnvar("cp_loadout_changed", 0);
  wait 2;
  self setclientomnvar("cp_loadout_changed", 1);
}

function debug_give_super(var0) {
  give_player_super(var0);
}

function get_super_from_playerdata() {
  var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
  return var0;
}

function ref_130a6(var0) {
  var1 = int(tablelookup("cp/cp_fieldupgrades.csv", 1, var0, 0));
  self setclientomnvar("ui_field_upgrade_icon", var1);
}

function init_super_for_player(var0) {
  give_super_weapon(var0);
  thread scriptable_door_freeze_open(var0);
  watch_for_super_button(var0);
}

function ref_14476(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_super_watcher");

  for(;;) {
    var1 = self getammocount(var0);

    if(var1 == 0) {
      self setweaponammoclip(var0, 1);
    }

    wait 0.1;
  }
}

function give_super_weapon(var0) {
  self giveweapon(var0);
  self assignweaponoffhandspecial(var0);
  self.specialoffhandgrenade = var0;
  self setweaponammoclip(var0, 1);
}

function scriptable_door_freeze_open(var0) {
  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_init("player_spawned_with_loadout");
  }

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  self setweaponammoclip(var0, 1);
}

function watch_for_super_button(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("end_super_watcher");
  self endon("end_super_watcher");
  self.super_ready = 0;
  thread recharge_super(var0);
  thread ref_14476(var0);
  self setclientomnvar("zm_faction_super", 0);
  self setclientomnvar("cp_super_ready", 0);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  jumpiffalse(scripts\engine\utility::flag_exist("player_safehouse_settings_toggled")) LOC_0000006d;
  scripts\engine\utility::flag_wait("player_safehouse_settings_toggled");

  for(;;) {
    self waittill("offhand_fired", var1);

    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
      scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      self setweaponammoclip(var0, 1);
      continue;
    }

    var2 = var1;

    if(issameweapon(var1)) {
      var2 = createheadicon(var1);
    }

    if(var2 == var0) {
      var3 = 0;

      if(!self.super_ready) {
        var3 = 1;
      } else if(istrue(self.inlaststand)) {
        var3 = 1;
      } else if(istrue(self.disable_super)) {
        var3 = 1;
      } else if(istrue(level.ref_12b46)) {
        var3 = 1;
      } else if(istrue(self.interrogating)) {
        var3 = 1;
      } else if(scripts\cp\cp_weapon::ref_124ad(self)) {
        var3 = 1;
      } else if(!istrue(self isonground())) {
        var3 = 1;
      }

      if(isDefined(self.currentturret)) {
        var3 = little_bird_mg_init(self);
      }

      if(!ref_13977()) {
        var3 = 1;
      }

      if(isDefined(level.generate_grenade_types_via_dvar) && ![[level.generate_grenade_types_via_dvar]](self)) {
        var3 = 1;
      }

      if(!var3) {
        thread fire_super(var0);
      } else {
        scripts\cp\utility::hint_prompt("super_disabled", 1, 2);
      }
    }

    self setweaponammoclip(var0, 1);
  }
}

function fire_super(var0) {
  self.super_ready = 0;
  self setclientomnvar("cp_super_ready", 0);
  thread display_super_fired_splash();
  run_super_loop(var0);
}

function ref_13977() {
  if(self.class == "medic") {
    var0 = 0;

    foreach(var2 in level.players) {
      if(var2 == self) {
        continue;
      }

      if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
        var0 = 1;
      }
    }

    return var0;
  }

  return 1;
}

function recharge_super(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_super_watcher");
  var1 = 120;
  var2 = getdvarint("scr_super_time", 0);

  if(var2) {
    var1 = var2;
  }

  if(istrue(self.ref_12d7d)) {
    if(!isDefined(self.super_progress)) {
      self.super_progress = 997;
    } else if(self.super_progress > 996) {
      self.super_progress = 997;
    }

    self.ref_12d7d = undefined;
  } else {
    self.super_progress = 997;
  }

  var3 = gettime();
  var4 = var3;

  for(;;) {
    var2 = getdvarint("scr_super_time", 0);

    if(var2) {
      var1 = var2;
    }

    var5 = 0;
    var6 = gettime();

    if(istrue(self.super_activated)) {
      var5 = 1;
    } else if(istrue(self.inlaststand)) {
      var5 = 1;
    } else if(istrue(self.super_ready)) {
      var5 = 1;
    } else if(istrue(self.disable_super)) {
      var5 = 1;
    }

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete")) {
      var5 = 1;
    }

    if(var5) {
      var4 = var6;
      waitframe();
      continue;
    }

    var7 = var6 - var4;
    var8 = var7 / var1 * 1000 * 1000;
    var8 *= scripts\cp\perks\cp_perks::get_perk("super_fill_scalar");
    increase_super_progress(var8);
    var9 = self.super_progress / 1000;

    if(var9 > 0.998) {
      var9 = 1;
    }

    self setclientomnvar("zm_faction_super", var9);
    var4 = var6;

    if(var9 >= 1) {
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
    var0 = "super_revive";

    switch (self.class) {
      case "medic":
        var0 = "cp_super_revive";
        break;
      case "tank":
        var0 = "cp_super_armor";
        break;
      case "crusader":
        var0 = "cp_super_cluster";
        break;
      case "assault":
        var0 = "cp_super_ammo";
        break;
      case "hunter":
        var0 = "cp_super_mark";
        break;
      case "engineer":
        var0 = "cp_super_emp";
        break;
    }
  } else {
    var0 = "cp_super_revive_kbm";

    switch (self.class) {
      case "medic":
        var0 = "cp_super_revive_kbm";
        break;
      case "tank":
        var0 = "cp_super_armor_kbm";
        break;
      case "crusader":
        var0 = "cp_super_cluster_kbm";
        break;
      case "assault":
        var0 = "cp_super_ammo_kbm";
        break;
      case "hunter":
        var0 = "cp_super_mark_kbm";
        break;
      case "engineer":
        var0 = "cp_super_emp_kbm";
        break;
    }
  }

  var1 = self getentitynumber();
  setomnvar("ui_class_power_ready", var1);
  thread scripts\cp\cp_hud_message::showsplash(var0, undefined, self);
}

function display_super_fired_splash() {
  self endon("disconnect");
  var0 = "super_revive_used";

  switch (self.class) {
    case "medic":
      var0 = "cp_super_revive_used";
      break;
    case "tank":
      var0 = "cp_super_armor_used";
      break;
    case "crusader":
      var0 = "cp_super_cluster_used";
      break;
    case "assault":
      var0 = "super_ammo_used";
      break;
    case "hunter":
      var0 = "cp_super_mark_used";
      break;
    case "engineer":
      var0 = "cp_super_sentry_used";
      break;
  }

  var1 = self getentitynumber();
  setomnvar("ui_class_power_inuse", var1);

  if(self.class == "medic" || self.class == "tank" || self.class == "assault") {
    setomnvar("cp_team_oriented_super_fired", var1);
    wait 6;
    setomnvar("cp_team_oriented_super_ended", var1);
    return;
  }

  self setclientomnvar("cp_super_fired", 1);
  wait 6;
  self setclientomnvar("cp_super_fired", 0);
}

function increase_super_progress(var0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      if(isDefined(self.super_progress_scalar)) {
        var0 *= self.super_progress_scalar;
      }

      self.super_progress += var0;

      if(self.super_progress > 1000) {
        self.super_progress = 1000;
        return;
      }

      return;
    }

    return;
  }
}

function decrease_super_progress(var0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      self.super_progress -= var0;

      if(self.super_progress <= 0) {
        self.super_progress = 0;
        return;
      }

      return;
    }

    return;
  }
}

function drain_super_meter(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("end_super_meter_early");
  thread set_progress_to_zero_on_death();
  self.super_meter_draining = 1;
  var1 = self getentitynumber();
  var2 = gettime();
  var3 = var2;
  var4 = 1;

  for(;;) {
    var5 = gettime();
    var6 = var5 - var3;
    var7 = var6 / var0 * 1000;
    var4 -= var7;

    if(var4 < 0) {
      var4 = 0;
    }

    self setclientomnvar("zm_faction_super", var4);
    var3 = var5;
    waitframe();

    if(var4 <= 0) {
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
      setomnvar("ui_class_power_reloading", var1);
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

function run_super_loop(var0) {
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

  if(scripts\cp\cp_weapon::ref_124ad(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    self waittill("weapon_change");

    if(istrue(self.inlaststand)) {
      self.super_activated = 0;
      return;
    }
  }

  scripts\cp\crafting_system::givegrenadelauncher();
  thread drain_super_meter(1);
  scripts\cp\cp_analytics::ref_119be(self, "thermite_launcher");
  self setclientomnvar("ui_thermite_class_power_on", gettime());
  var0 = self getentitynumber();
  var1 = "cp_super_cluster_used";

  foreach(var3 in level.players) {
    var3 scripts\cp\cp_hud_message::showsplash(var1, undefined, self);
  }

  while(istrue(self.has_gl)) {
    self waittill("weapon_removed");
  }

  setomnvar("ui_class_power_reloading", var0);
  self setclientomnvar("ui_thermite_class_power_off", gettime());
  self.gl_proj_override = undefined;
  self.super_activated = 0;
}

function remove_launcher_after_timeout(var0) {
  self endon("weapon_removed");
  wait var0;
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_weapon_pickup(1);
  var1 = "iw8_la_mike32_mp";
  self takeweapon(var1);
  self switchtoweapon(self.last_weapon);
  self.has_gl = undefined;
  self notify("weapon_removed");
}

function team_unlimited_ammo() {
  foreach(var1 in level.players) {
    var1.has_infinite_ammo = 1;
    var2 = ammo_round_up();
    thread unlimited_ammo(var1);
  }
}

function at_mine_movingplatform_update() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread x1ops4();
  var0 = scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();

  if(var0) {
    var1 = scripts\engine\utility::ref_143ae("super_use_succeeded", "super_use_failed", "laststand");

    if(var1 == "super_use_succeeded") {
      var2 = "cp_super_mark_used";

      foreach(var4 in level.players) {
        var4 scripts\cp\cp_hud_message::showsplash(var2, undefined, self);
      }

      scripts\cp\cp_analytics::ref_119be(self, "scout drone");
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
  self waittill("killstreak_vehicle_made", var0);
  self.ref_12f15 = var0;
}

function ref_14356() {
  var0 = self getentitynumber();
  thread ref_143c5(5);
  ref_143c4();

  while(isDefined(self.ref_12f15)) {
    waitframe();
  }

  setomnvar("ui_class_power_reloading", var0);
  self.super_activated = 0;
}

function ref_143c4() {
  self endon("scout_drone_timeout");

  while(!isDefined(self.ref_12f15)) {
    wait 0.1;
  }

  self notify("scout_drone_timeout");
}

function ref_143c5(var0) {
  self endon("scout_drone_timeout");
  wait var0;
  self notify("scout_drone_timeout");
}

function superusefinished(var0, var1, var2, var3) {
  self notify("super_use_finished_lb");

  if(istrue(var0)) {
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

function deactivate_mark_enemies(var0) {
  level endon("disconnect");
  level endon("game_ended");
  var1 = scripts\engine\utility::ref_143b9(var0, "force_end_super");
  self.marked_enemies = 0;
}

function mark_enemies(var0) {
  var1 = 2;
  var2 = 2;
  var3 = 3000;
  var4 = var3 * var3;
  var5 = gettime();
  var6 = var5 + var0 * 1000;

  while(var5 < var6) {
    var7 = [];

    foreach(var9 in level.agentarray) {
      if(isalive(var9) && isDefined(var9.team)) {
        var7 = var9;
      }
    }

    var7 = scripts\engine\utility::array_combine(var7, level.players);
    var7 = sortbydistance(var7, self.origin);
    self setscriptablepartstate("marked_enemies_pulse", "active");

    for(var11 = 0; var11 < var7.size; var11++) {
      if(!isDefined(var7[var11])) {
        continue;
      }

      if(!isalive(var7[var11])) {
        continue;
      }

      if(distancesquared(var7[var11].origin, self.origin) > var4) {
        continue;
      }

      if(self.team != var7[var11].team) {
        var7[var11] hudoutlineenable("outline_nodepth_red");
        waitframe();
      }
    }

    wait var1;

    if(var2 > 0) {
      var7 = [];

      foreach(var9 in level.agentarray) {
        if(isalive(var9) && isDefined(var9.team)) {
          var7 = var9;
        }
      }

      var7 = scripts\engine\utility::array_combine(var7, level.players);
      var7 = sortbydistance(var7, self.origin);

      for(var11 = 0; var11 < var7.size; var11++) {
        if(!isDefined(var7[var11])) {
          continue;
        }

        if(!isalive(var7[var11])) {
          continue;
        }

        if(self.team != var7[var11].team) {
          var7[var11] hudoutlinedisable();
          waitframe();
        }
      }

      self setscriptablepartstate("marked_enemies_pulse", "neutral");
      self notify("stop_mark_enemies");
      wait var2;
    }

    var5 = gettime();
  }

  var7 = [];

  foreach(var9 in level.agentarray) {
    if(isalive(var9) && isDefined(var9.team)) {
      var7 = var9;
    }
  }

  var7 = scripts\engine\utility::array_combine(var7, level.players);

  foreach(var17 in var7) {
    if(self.team != var17.team) {
      self notify("stop_mark_enemies");
      var17 hudoutlinedisable();
      var17 notify("stopped_being_marked");
    }
  }

  self setscriptablepartstate("marked_enemies_pulse", "neutral");
}

function ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  var0 = [];

  foreach(var2 in self.weaponlist) {
    var0 = self getammocount(var2);
  }

  return var0;
}

function unlimited_ammo(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_unlimited_ammo");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_infinite_ammo)) {
    var1 = 0;

    foreach(var3 in self.weaponlist) {
      var4 = weaponclipsize(var3);

      if(var3 == self getcurrentweapon() && weapon_no_unlimited_check(var3)) {
        var1 = 1;

        if(var4 == 1) {
          var5 = self getweaponammostock(var3);
          var5++;
          self setweaponammostock(var3, var5);
        } else {
          self setweaponammoclip(var3, weaponclipsize(var3), "left");
        }
      }

      if(var3 == self getcurrentweapon() && weapon_no_unlimited_check(var3)) {
        var1 = 1;
        self setweaponammoclip(var3, weaponclipsize(var3), "right");
      }

      if(var1 == 0) {
        ammo_round_up();
      }
    }

    wait 0.05;
  }
}

function weapon_no_unlimited_check(var0) {
  var1 = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(var3 in level.opweaponsarray) {
      if(var0.basename == var3) {
        var1 = 0;
      }
    }
  }

  return var1;
}

function deactivate_infinite_ammo(var0) {
  level endon("disconnect");
  level endon("game_ended");
  var1 = scripts\engine\utility::ref_143b9(var0, "force_end_super");

  foreach(var3 in level.players) {
    var3.has_infinite_ammo = undefined;
    var3 scripts\cp\utility::enable_infinite_ammo(0);
  }
}

function activate_auto_revive_crate(var0) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  var1 = scripts\cp\crafting_system::giveadrenalinecrate();

  if(!istrue(var1)) {
    return 0;
  }

  thread drain_super_meter(1);
  self.super_activated = 0;
}

function activate_team_auto_revive(var0) {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  var1 = "cp_super_revive_used";
  var2 = 0;

  foreach(var4 in level.players) {
    if(var4 == self) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var4)) {
      if(isDefined(var4.last_stand_state) && var4.last_stand_state == "bleed_out") {
        continue;
      }

      thread team_instant_revive();
      var4 scripts\cp\cp_hud_message::showsplash(var1, undefined, self);
      scripts\cp\cp_laststand::record_revive_success(self, var4);
      var2 = 1;
    }
  }

  if(var2) {
    scripts\cp\cp_hud_message::showsplash(var1, undefined, self);
    scripts\cp\cp_analytics::ref_119be(self, "team auto-revive");
    drain_super_meter(1);
  }

  self.super_activated = 0;
}

function team_instant_revive() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(!isDefined(self.dogtag)) {
      self.ref_140ac = 1;
      self giveandfireoffhand("adrenaline_mp");

      if(isDefined(self.reviveiconent)) {
        scripts\cp\cp_laststand::set_revive_icon_color(self.reviveiconent);
        self.reviveent makeunusable();
      }

      wait 3;
      scripts\cp\cp_laststand::instant_revive(self);
      self.ref_140ac = undefined;
      return;
    }

    return;
  }
}

function activate_instant_revive(var0) {
  self.has_instant_revive = 1;
  self.old_revive_time_scalar = self.perk_data["revive_time_scalar"];
  self.perk_data["revive_time_scalar"] = 0;
  thread aoe_instant_revive(15);
  thread drain_super_meter(1);
  deactivate_instant_revive(15);
  self.super_activated = 0;
  var1 = "cp_super_revive_used";

  foreach(var3 in level.players) {
    var3 scripts\cp\cp_hud_message::showsplash(var1, undefined, self);
  }
}

function deactivate_instant_revive(var0) {
  level endon("disconnect");
  level endon("game_ended");
  var1 = scripts\engine\utility::ref_143b9(var0, "force_end_super");
  self notify("stop_instant_revive");
  self.has_instant_revive = undefined;
  self.perk_data["revive_time_scalar"] = self.old_revive_time_scalar;
}

function aoe_instant_revive(var0) {
  self endon("stop_instant_revive");
  self endon("death");
  var1 = 100;
  var2 = var1 * var1;
  var3 = gettime() + var0 * 1000;

  while(gettime() < var3) {
    foreach(var5 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var5)) {
        if(distancesquared(self.origin, var5.origin) < var2) {
          var5 scripts\cp\cp_laststand::instant_revive(var5);

          if(isDefined(var5.dogtag)) {
            var5.dogtag delete();
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
  scripts\cp\cp_analytics::ref_119be(self, "team armor");
  thread deactivate_team_armor_buff(20);
  drain_super_meter(1);
  self.super_activated = 0;
}

function turn_on_team_armor_buff() {
  var0 = 100;
  var1 = getdvarint("scr_armor_max", 0);

  if(var1) {
    var0 = var1;
  }

  var2 = "cp_super_armor_used";

  foreach(var4 in level.players) {
    if(on_the_same_team(self, var4) && isalive(var4)) {
      var4.has_team_armor = 1;
      scripts\cp\cp_armor::givearmor(var4, var0, 1);
      var4.old_armor_scalar = var4 scripts\cp\perks\cp_perks::get_perk("enemy_damage_to_player_armor_scalar");
      var4 scripts\cp\perks\cp_perks::set_perk("enemy_damage_to_player_armor_scalar", var4.old_armor_scalar * 1.5);
      var4 scripts\cp\cp_hud_message::showsplash(var2, undefined, self);
    }
  }

  setomnvar("ui_armor_class_power_used", 1);
}

function on_the_same_team(var0, var1) {
  if(isDefined(var0.team_number) && isDefined(var1.team_number)) {
    return (var0.team_number == var1.team_number);
  }

  return 1;
}

function remove_team_armor_buff() {
  foreach(var1 in level.players) {
    if(on_the_same_team(self, var1)) {
      var1.has_team_armor = undefined;
      var1 scripts\cp\perks\cp_perks::set_perk("enemy_damage_to_player_armor_scalar", var1.old_armor_scalar);
    }
  }
}

function deactivate_team_armor_buff(var0) {
  level endon("disconnect");
  level endon("game_ended");
  var1 = self getentitynumber();
  var2 = scripts\engine\utility::ref_143b9(var0, "force_end_super");
  setomnvar("ui_class_power_reloading", var1);
  setomnvar("ui_armor_class_power_used", 0);
  remove_team_armor_buff();
}

function activate_team_stopping_power() {
  level endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  scripts\cp\cp_analytics::ref_119be(self, "team stopping_power");
  var0 = "cp_super_ammo_used";

  foreach(var2 in level.players) {
    scr_br_collection_findpath(var2);
    var2 scripts\cp\cp_hud_message::showsplash(var0, undefined, self);
  }

  drain_super_meter(1);
  setomnvar("ui_ammo_class_power_on", gettime());
  self.super_activated = 0;
}

function scr_br_collection_findpath() {
  var0 = scripts\cp\utility::getvalidtakeweapon();
  var1 = weaponclipsize(var0);
  self setweaponammoclip(var0, var1);
  thread ref_14442(var0, var1);
}

function ref_14442(var0, var1) {
  self endon("disconnect");
  thread ref_12be5();
  thread stoppingpower_watchhcrweaponchange(var0);
  thread stoppingpower_watchhcrweaponfire(var0, var1);
  self waittill("stoppingPower_removeHCR");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

function ref_12be5() {
  self waittill("death");
  scripts\cp\utility::takeperk("specialty_bulletdamage");
}

function stoppingpower_watchhcrweaponchange(var0) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.gavehcr = 0;

  while(self hasweapon(var0)) {
    if(self getcurrentweapon() == var0) {
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

function stoppingpower_watchhcrweaponfire(var0, var1) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = var1;
  thread ref_138f1(var0, var1);

  while(self hasweapon(var0)) {
    self waittill("weapon_fired", var2);

    if(var2 == var0) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self setclientomnvar("ui_ammo_class_power_off", gettime());
  self notify("stoppingPower_removeHCR");
}

function ref_138f1(var0, var1) {
  self endon("stoppingPower_removeHCR");
  self endon("disconnect");
  self endon("stoppingPower_clearHCR");
  self.rounds = var1;

  while(self hasweapon(var0)) {
    self waittill("ammo_drained");
    self.rounds--;

    if(self.rounds <= 0) {
      break;
    }
  }

  self setclientomnvar("ui_ammo_class_power_off", gettime());
  self notify("stoppingPower_removeHCR");
}

function remove_team_stopping_power(var0) {
  level notify("give_team_stopping_power");
  level endon("give_team_stopping_power");
  wait var0;
  setomnvar("ui_ammo_class_power_off", gettime());

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_ammo_class_power_off", gettime());
    var2 scripts\cp\utility::takeperk("specialty_bulletdamage");
  }
}

function activate_emp_drone() {
  self endon("disconnect");
  level endon("game_ended");
  self.super_activated = 1;
  thread x1ops5();
  var0 = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();

  if(var0) {
    monitormounted();
    ref_14357();
    return;
  }

  self.super_activated = 0;
}

function monitormounted() {
  var0 = "cp_super_sentry_used";

  foreach(var2 in level.players) {
    var2 scripts\cp\cp_hud_message::showsplash(var0, undefined, self);
  }

  scripts\cp\cp_analytics::ref_119be(self, "emp drone");
  thread drain_super_meter(1);
}

function x1ops5() {
  self endon("death_or_disconnect");
  self waittill("killstreak_vehicle_made", var0);
  self.monitorhotfoot = var0;
  thread monitoringimpact();
  thread getcrateusetime();
}

function ref_14357() {
  thread ref_143e5(5);
  ref_143e4();

  while(isDefined(self.monitorhotfoot)) {
    wait 0.1;
  }

  self.super_activated = 0;
}

function ref_143e4() {
  self endon("emp_drone_timeout");

  while(!isDefined(self.monitorhotfoot)) {
    wait 0.1;
  }

  self notify("emp_drone_timeout");
}

function ref_143e5(var0) {
  self endon("emp_drone_timeout");
  wait var0;
  self notify("emp_drone_timeout");
}

function monitoringimpact() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");

  for(;;) {
    var0 = prewaitandspawnclient();

    foreach(var2 in var0) {
      if(isDefined(var2)) {
        if(var2 == self) {
          continue;
        }

        if(isDefined(var2.chopper)) {
          continue;
        }

        if(isDefined(var2) && var2 scripts\cp_mp\emp_debuff::can_be_empd()) {
          var3 = distancesquared(self.origin, var2.origin);

          if(var3 > 250000) {
            continue;
          }

          ref_1292b();
          return;
        }
      }
    }

    waitframe();
  }
}

function prewaitandspawnclient() {
  var0 = scripts\cp\utility::getvehiclearray();
  var1 = [];

  foreach(var3 in var0) {
    if(isDefined(var3.team) && var3.team == "axis") {
      var1 = var3;
    }
  }

  var5 = getEntArray("misc_turret", "classname");

  foreach(var7 in var5) {
    if(isDefined(var7.team) && var7.team == "axis") {
      var1 = var7;
    }
  }

  foreach(var10 in level.spawned_enemies) {
    if(istrue(isDefined(var10.unittype) && var10.unittype == "suicidebomber")) {
      var1 = var10;
    }
  }

  return var1;
}

function ref_1292b() {
  self.owner notify("emp_drone_detonate");
  var0 = "emp_drone_player_mp";
  var1 = prewaitandspawnclient();

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3.vehiclename) && isDefined(level.vehicle.instances[var3.vehiclename])) {
      if(isDefined(level.vehicle.instances[var3.vehiclename][var3 getentitynumber()])) {} else {
        var3 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var0);
      }

      continue;
    }

    var3 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var0);
  }
}

function getcrateusetime() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  var0 = 500;

  for(;;) {
    var1 = self.origin;
    var2 = anglesToForward(self.angles);
    var2 = vectorNormalize(var2);
    var3 = rotatevector((0, 30, 0), self.angles);
    var4 = var1 + var3;
    var5 = rotatevector((0, -30, 0), self.angles);
    var6 = var1 + var5;
    var7 = prewaitandspawnclient();
    getcrossbowimpactfunc(var1, var1 + var2 * var0, var7, "fwd");
    getcrossbowimpactfunc(var4, var4 + var2 * var0, var7, "left");
    getcrossbowimpactfunc(var6, var6 + var2 * var0, var7, "right");
    waitframe();
  }
}

function getcrossbowimpactfunc(var0, var1, var2, var3) {
  var4 = scripts\engine\trace::ray_trace(var0, var1, self);

  if(isDefined(var4)) {
    if(var4["fraction"] == 1) {
      return;
    }

    if(isDefined(var4["entity"])) {
      if(scripts\engine\utility::array_contains(var2, var4["entity"])) {
        ref_1292b();
        return;
      }
    }

    if(var4["fraction"] < 0.2) {
      if(var3 != "fwd") {
        wait 0.25;
      }

      ref_1292b();
      return;
    }

    return;
  }
}

function little_bird_mg_init(var0) {
  if(isDefined(var0.class)) {
    switch (var0.class) {
      case "medic":
      case "tank":
      case "assault":
        return 0;
      case "vanguard":
      case "engineer":
      case "hunter":
        var0.disable_super = 1;
        return 1;
    }

    return;
  }
}

function mousetraps(var0) {
  var0.disable_super = undefined;
}