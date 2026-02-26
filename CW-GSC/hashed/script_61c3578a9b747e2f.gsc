/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_61c3578a9b747e2f.gsc
***********************************************/

#using script_24c32478acf44108;
#using script_62caa307a394c18c;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#namespace namespace_9111e6ab;

function private autoexec __init__system__() {
  system::register(#"hash_6c156e681484d01a", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("allplayers", "" + # "hash_1668fcf85f7c231", 1, 2, "int");
  clientfield::register("actor", "" + # "hash_70a85ea8b0e1b09c", 1, 2, "int");
  namespace_1b527536::function_36e0540e(#"lightning_links", 1, 50, #"field_upgrade_lightning_links_item_sr");
  namespace_1b527536::function_36e0540e(#"lightning_links_1", 1, 50, #"field_upgrade_lightning_links_1_item_sr");
  namespace_1b527536::function_36e0540e(#"lightning_links_2", 1, 50, #"field_upgrade_lightning_links_2_item_sr");
  namespace_1b527536::function_36e0540e(#"lightning_links_3", 1, 50, #"field_upgrade_lightning_links_3_item_sr");
  namespace_1b527536::function_36e0540e(#"lightning_links_4", 1, 50, #"field_upgrade_lightning_links_4_item_sr");
  namespace_1b527536::function_36e0540e(#"lightning_links_5", 1, 50, #"field_upgrade_lightning_links_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"lightning_links", &function_913fe266);
  namespace_1b527536::function_dbd391bf(#"lightning_links_1", &function_913fe266);
  namespace_1b527536::function_dbd391bf(#"lightning_links_2", &function_913fe266);
  namespace_1b527536::function_dbd391bf(#"lightning_links_3", &function_913fe266);
  namespace_1b527536::function_dbd391bf(#"lightning_links_4", &function_913fe266);
  namespace_1b527536::function_dbd391bf(#"lightning_links_5", &function_913fe266);
  zm_equipment::function_76beede2(#"lightning_links", "MOD_ELECTROCUTED");
  zm_equipment::function_76beede2(#"lightning_links_1", "MOD_ELECTROCUTED");
  zm_equipment::function_76beede2(#"lightning_links_2", "MOD_ELECTROCUTED");
  zm_equipment::function_76beede2(#"lightning_links_3", "MOD_ELECTROCUTED");
  zm_equipment::function_76beede2(#"lightning_links_4", "MOD_ELECTROCUTED");
  zm_equipment::function_76beede2(#"lightning_links_5", "MOD_ELECTROCUTED");
}

function function_913fe266(params) {
  self namespace_1b527536::function_460882e2(1);
  var_9cec4bff = 100;
  var_53a5b34d = 400;

  switch (params.weapon.name) {
    case # "lightning_links":
    case # "lightning_links_1":
      var_91a257a3 = 10;
      break;
    case # "lightning_links_2":
    case # "lightning_links_3":
    case # "lightning_links_4":
    case # "lightning_links_5":
      var_91a257a3 = 15;
      break;
  }

  self thread function_1e0fa475(params.weapon, var_9cec4bff, var_53a5b34d, var_91a257a3);
}

function function_1e0fa475(weapon, var_2b003a39, var_5baceff5, n_duration) {
  self.var_60b31640 = 1;
  var_e041507a = self getentitynumber();

  if(is_true(self.var_23fa23a9)) {
    self.var_23fa23a9 = undefined;
    self clientfield::set("" + # "hash_1668fcf85f7c231", 0);
    self function_7b69ae3f();
    util::wait_network_frame();

    if(!isDefined(self)) {
      return;
    }
  }

  self flag::increment("zm_field_upgrade_in_use");
  self function_65e5989c(weapon);
  self clientfield::set("" + # "hash_1668fcf85f7c231", 1);
  util::wait_network_frame();

  while(isalive(self) && !self laststand::player_is_in_laststand() && !self scene::is_igc_active() && n_duration > 0) {
    var_281b41ca = function_a1ef346b(self.team, self.origin, var_5baceff5);

    foreach(player in var_281b41ca) {
      if(!isDefined(player) || player === self) {
        continue;
      }

      if(self function_6c7755f9(player)) {
        player thread function_5bcee875(self, weapon, var_5baceff5, var_2b003a39);
        continue;
      }

      if(self function_6c7755f9(player, 1) && !isDefined(player.var_65a13a0f)) {
        player.var_23fa23a9 = 1;
        player.var_65a13a0f = self;
        player clientfield::set("" + # "hash_1668fcf85f7c231", 3);
        continue;
      }

      if(!self function_6c7755f9(player, 1, 0) && is_true(player.var_60b31640) && is_true(player.var_23fa23a9) && player.var_65a13a0f === self) {
        n_current_time = gettime();
        player clientfield::set("" + # "hash_1668fcf85f7c231", 1);
        player.var_23fa23a9 = undefined;
        player.var_65a13a0f = undefined;
        self clientfield::set("" + # "hash_1668fcf85f7c231", 0);
        self.var_23fa23a9 = undefined;
        self.var_65a13a0f = undefined;
        util::wait_network_frame();

        if(is_true(self.var_60b31640) && !is_true(self.var_23fa23a9) && !isDefined(self.var_65a13a0f)) {
          self clientfield::set("" + # "hash_1668fcf85f7c231", 1);
        }

        var_600ca6d2 = float(gettime() - n_current_time) / 1000;
        n_duration -= var_600ca6d2;
      }
    }

    if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
      circle(self.origin, var_2b003a39, (1, 0, 0), undefined, 1);
      circle(self.origin, var_5baceff5, (0, 1, 0), undefined, 1);
    }

    a_enemies = self getenemiesinradius(self.origin, var_5baceff5);

    foreach(ai in a_enemies) {
      if(ai function_165a06f0(self, var_2b003a39, var_5baceff5, weapon)) {
        ai thread function_c79f4bd7(weapon, self, self);
      }
    }

    waitframe(1);
    n_duration -= float(function_60d95f53()) / 1000;
  }

  if(isDefined(self)) {
    self flag::decrement("zm_field_upgrade_in_use");
    self.var_60b31640 = undefined;
    self clientfield::set("" + # "hash_1668fcf85f7c231", 0);
    self util::delay(2, ["disconnect", #"hash_2873117ec68db93c"], &function_7b69ae3f);
    util::wait_network_frame();

    if(isDefined(self)) {
      self.var_23fa23a9 = undefined;
      self.var_65a13a0f = undefined;
    }
  }
}

function function_5bcee875(player_source, weapon, var_5baceff5, var_2b003a39) {
  self.var_23fa23a9 = 1;
  self clientfield::set("" + # "hash_1668fcf85f7c231", 2);
  self function_65e5989c(weapon);
  var_e041507a = player_source getentitynumber();
  var_e42a877c = 0;
  var_a01d6a1b = randomintrange(10, 15);
  util::wait_network_frame();

  while(isalive(self) && isalive(player_source) && is_true(self.var_23fa23a9) && !self laststand::player_is_in_laststand() && !player_source laststand::player_is_in_laststand() && is_true(player_source.var_60b31640) && !self scene::is_igc_active() && !player_source scene::is_igc_active() && distance(self.origin, player_source.origin) <= var_5baceff5 && !is_true(self.var_16735873) && !is_true(player_source.var_16735873)) {
    if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
      circle(self.origin, var_2b003a39, (1, 0, 0), undefined, 1);
    }

    a_enemies = self getenemiesinradius(self.origin, var_5baceff5);

    foreach(ai in a_enemies) {
      if(ai function_165a06f0(self, var_2b003a39, var_5baceff5, weapon)) {
        ai thread function_c79f4bd7(weapon, self, player_source);
      }
    }

    var_e42a877c++;

    if(var_e42a877c % var_a01d6a1b == 0) {
      if(!player_source function_6c7755f9(self, undefined, 0)) {
        break;
      }

      var_79b05a2b = 0;
      var_a01d6a1b = randomintrange(10, 15);
    }

    waitframe(1);
  }

  if(isDefined(self)) {
    self.var_23fa23a9 = undefined;
    self.var_65a13a0f = undefined;
    self clientfield::set("" + # "hash_1668fcf85f7c231", 0);
    self util::delay(2, ["disconnect", #"hash_2873117ec68db93c"], &function_7b69ae3f);
  }
}

function function_65e5989c(weapon) {
  if(weapon.name === # "lightning_links_4" || weapon.name === # "lightning_links_5") {
    self function_7b69ae3f();
    var_e3ad032b = self getmovespeedscale() + self getmovespeedscale() * 0.25;
    self notify(#"hash_2873117ec68db93c");
    self val::set(#"lightning_links", "move_speed_scale", var_e3ad032b);
    self.var_11994308 = 1;
  }
}

function function_7b69ae3f() {
  self val::reset(#"lightning_links", "move_speed_scale");
  self.var_11994308 = undefined;
}

function function_165a06f0(player_source, var_2b003a39, var_5baceff5, weapon) {
  if(isactor(self) && isalive(self) && !self flag::get(#"hash_6ab8e3db32b20d33") && isalive(player_source) && !player_source laststand::player_is_in_laststand() && self.team === level.zombie_team && !is_true(self.var_c8065bf4) && !is_true(self.var_8576e0be) && !is_true(player_source.var_16735873)) {
    if(self.zm_ai_category === # "boss") {
      return false;
    } else if(self.zm_ai_category === # "elite") {
      switch (weapon.name) {
        case # "lightning_links":
        case # "lightning_links_1":
        case # "lightning_links_2":
        case # "lightning_links_3":
        case # "lightning_links_4":
          return false;
      }
    } else if(self.zm_ai_category === # "special") {
      switch (weapon.name) {
        case # "lightning_links":
        case # "lightning_links_1":
        case # "lightning_links_2":
          return false;
      }
    }

    if(distance(self.origin, player_source.origin) < var_2b003a39) {
      return true;
    }

    if(is_true(player_source.var_60b31640)) {
      var_281b41ca = function_a1ef346b(player_source.team, player_source.origin, var_5baceff5);

      foreach(player in var_281b41ca) {
        if(player == player_source || !is_true(player.var_23fa23a9)) {
          continue;
        }

        v_start_pos = player_source gettagorigin("j_spineupper");
        v_end_pos = player gettagorigin("j_spineupper");

        if(!(isDefined(v_start_pos) && isDefined(v_end_pos))) {
          continue;
        }

        var_5e6f4f75 = math::closest_point_on_line(self.origin, v_start_pos, v_end_pos);
        v_enemy = self getcentroid();
        var_790ce634 = distance(v_enemy, var_5e6f4f75) <= 25;

        if(var_790ce634) {
          if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
            line(v_start_pos, v_end_pos, (0, 0, 1), undefined, 20);
          }

          return true;
        }
      }
    }
  }

  return false;
}

function function_6c7755f9(player, var_347c484e = 0, var_6f40c449 = 1) {
  var_38e2a777 = self gettagorigin("j_spineupper");
  var_4985c8bd = player gettagorigin("j_spineupper");

  if(!self isinvehicle() && !player isinvehicle() && (!var_6f40c449 || !is_true(player.var_23fa23a9)) && !self scene::is_igc_active() && !player scene::is_igc_active() && !self laststand::player_is_in_laststand() && !player laststand::player_is_in_laststand() && isDefined(var_38e2a777) && isDefined(var_4985c8bd) && beamtrace(var_38e2a777, var_4985c8bd, 0, self, 1, 1, player)[#"fraction"] === 1 && !is_true(self.var_16735873) && !is_true(player.var_16735873)) {
    if(var_347c484e) {
      return true;
    } else if(!is_true(player.var_60b31640)) {
      return true;
    }
  }

  return false;
}

function function_c79f4bd7(weapon, player_source, var_15625d6b) {
  self endon(#"death");

  if(!isDefined(var_15625d6b)) {
    var_15625d6b = player_source;
  }

  if(!self flag::get(#"hash_6ab8e3db32b20d33")) {
    switch (weapon.name) {
      case # "lightning_links":
        var_da4a3267 = self.maxhealth * 0.1;
        break;
      case # "lightning_links_1":
        var_da4a3267 = self.maxhealth * 0.2;
        break;
      case # "lightning_links_2":
        var_da4a3267 = self.maxhealth * 0.2;
        break;
      case # "lightning_links_3":
        var_da4a3267 = self.maxhealth * 0.2;
        var_34e3b3f7 = self.maxhealth * 0.1;
        break;
      case # "lightning_links_4":
        var_da4a3267 = self.maxhealth * 0.2;
        var_34e3b3f7 = self.maxhealth * 0.1;
        break;
      case # "lightning_links_5":
        var_da4a3267 = self.maxhealth * 0.2;
        var_34e3b3f7 = self.maxhealth * 0.1;
        var_19ba813e = self.maxhealth * 0.05;
        break;
    }

    if(self.zm_ai_category === # "elite") {
      var_70ab6bc = var_19ba813e;
      n_clientfield = 3;
    } else if(self.zm_ai_category === # "special") {
      var_70ab6bc = var_34e3b3f7;
      n_clientfield = 2;
    } else if(self.zm_ai_category === # "normal") {
      var_70ab6bc = var_da4a3267;
      n_clientfield = 1;
    }

    if(!isDefined(var_70ab6bc)) {
      return;
    }

    self flag::set(#"hash_6ab8e3db32b20d33");

    if(!isDefined(level.var_cef2e607[#"hash_13c4587dc27db042"])) {
      level.var_cef2e607[#"hash_13c4587dc27db042"] = -1;
    }

    level.var_cef2e607[#"hash_13c4587dc27db042"]++;
    wait float(function_60d95f53()) / 1000 * (level.var_cef2e607[#"hash_13c4587dc27db042"] % int(float(function_60d95f53()) / 1000 / float(function_60d95f53()) / 1000) + 1);

    if(isDefined(var_70ab6bc) && isDefined(n_clientfield) && isalive(player_source) && isalive(var_15625d6b)) {
      self.var_5f6261a5 = var_15625d6b;
      self clientfield::set("" + # "hash_70a85ea8b0e1b09c", n_clientfield);
      scoreevents::processscoreevent("tesla_storm_stun_zm", var_15625d6b, self, weapon);
      self ai::stun(1);
      self namespace_42457a0::function_601fabe9(#"electrical", var_70ab6bc, player_source.origin, var_15625d6b, var_15625d6b, "none", "MOD_ELECTROCUTED", 0, weapon);
      wait 1;
    }

    self.var_5f6261a5 = undefined;
    self flag::clear(#"hash_6ab8e3db32b20d33");
    self clientfield::set("" + # "hash_70a85ea8b0e1b09c", 0);
  }
}