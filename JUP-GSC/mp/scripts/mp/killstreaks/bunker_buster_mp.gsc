/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\bunker_buster_mp.gsc
**********************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\bunker_buster;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\weapons;
#namespace bunker_buster_mp;

function autoexec main() {
  utility::registersharedfunc("bunker_buster", "init", &init);
}

function private init() {
  devgui_init();

  utility::registersharedfunc("bunker_buster", "missile_gas_volume", &missile_gas_volume);
  utility::registersharedfunc("bunker_buster", "dialog_deploy", &dialog_deploy);
  utility::registersharedfunc("bunker_buster", "dialog_warning", &dialog_warning);
  utility::registersharedfunc("bunker_buster", "dialog_hits", &dialog_hits);
  game["dialog"]["bunker_buster" + "_deploy"] = "dx_br_smis_kbbu_grav_bbkd";
  game["dialog"]["bunker_buster" + "_warning_friendly"] = "dx_br_smis_kbbu_grav_kfsi";
  game["dialog"]["bunker_buster" + "_warning_enemy"] = "dx_br_smis_kbbu_grav_kesi";
  game["dialog"]["bunker_buster" + "_no_hits"] = "dx_br_smis_kbbu_grav_bkne";
  game["dialog"]["bunker_buster" + "_single_hit"] = "dx_br_smis_kbbu_grav_bksh";
  game["dialog"]["bunker_buster" + "_multiple_hits"] = "dx_br_smis_kbbu_grav_bkmh";
}

function missile_gas_volume(startposition, endposition, radius, streak_info) {
  level thread function_8800c8028368dc18(endposition, self, self.team, level.bunker_buster.gas_lifetime, radius, distance(startposition, endposition), streak_info);
}

function function_8800c8028368dc18(position, owner, team, duration, radius, height, streak_info) {
  trigger = spawn("trigger_radius", position, 0, radius, height);
  trigger scripts\cp_mp\ent_manager::registerspawn(1, &sweepgas);
  trigger.height = height;
  trigger.radius = radius;
  trigger.duration = duration;
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.weapon = level.bunker_buster.projectile_weapon;
  trigger.playersintrigger = [];
  trigger.var_aeeca2bc23f59ea4 = [];

  if(gas_grenade::function_4cd5239298745de7()) {
    trigger thread scripts\mp\gametypes\br::function_4b2456ab9e1c7b81(position);
  }

  trigger thread gas_grenade::gas_watchtriggerenter();
  trigger thread gas_grenade::gas_watchtriggerexit();
  trigger thread function_69a839ba80dc08f0(2, streak_info);
  trigger thread gas_grenade::function_4a5b553867d71fa9(duration, "gas_cleared");
}

function function_69a839ba80dc08f0(duration, streak_info) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", ent);
    num = ent getentitynumber();

    if(!isDefined(streak_info.gas_victims[num]) && (isPlayer(ent) || isagent(ent)) && ent.team != self.team) {
      streak_info.gas_victims[num] = 1;
    }
  }
}

function dialog_deploy(player) {
  scripts\mp\gametypes\br_public::brleaderdialogplayer("bunker_buster" + "_deploy", player, 1, 0, 1, undefined, "");
}

function dialog_warning(friendlies, enemies) {
  if(isDefined(friendlies) && friendlies.size > 0) {
    scripts\mp\gametypes\br_public::brleaderdialog("bunker_buster" + "_warning_friendly", 1, friendlies, 0, undefined, undefined, "");
  }

  if(isDefined(enemies) && enemies.size > 0) {
    scripts\mp\gametypes\br_public::brleaderdialog("bunker_buster" + "_warning_enemy", 1, enemies, 0, undefined, undefined, "");
  }
}

function dialog_hits(player, streak_info) {
  dialog = "";
  total_victims = [];

  foreach(k, v in streak_info.explosion_victims) {
    total_victims[k] = 1;
  }

  foreach(k, v in streak_info.gas_victims) {
    total_victims[k] = 1;
  }

  switch (total_victims.size) {
    case 0:
      dialog = "bunker_buster" + "_no_hits";
      break;
    case 1:
      dialog = "bunker_buster" + "_single_hit";
      break;
    default:
      dialog = "bunker_buster" + "_multiple_hits";
      break;
  }

  scripts\mp\gametypes\br_public::brleaderdialogplayer(dialog, player, 1, 0, undefined, undefined, "");
}

function private devgui_init() {
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::add_devgui_command("<dev string:x42>", "<dev string:x4a>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x98>", "<dev string:xbf>", &function_1d3ab9e562b3e3db);
  devgui::function_b23a59dfb4ca49a1("<dev string:xd3>", "<dev string:xf7>", &function_1d3ab9e562b3e3db);
  devgui::function_b23a59dfb4ca49a1("<dev string:x10b>", "<dev string:x122>", &function_ac26cf14f95df3f8);
  devgui::function_b23a59dfb4ca49a1("<dev string:x132>", "<dev string:x147>", &function_ac26cf14f95df3f8);
  devgui::function_b23a59dfb4ca49a1("<dev string:x157>", "<dev string:x16e>", &function_ac26cf14f95df3f8);
  devgui::function_fe953f000498048f();

  if(game_utility::isbrstylegametype()) {
    devgui::function_6e7290c8ee4f558b("<dev string:x17e>");
    devgui::add_devgui_command("<dev string:x19c>", "<dev string:x1ad>");
    devgui::function_fe953f000498048f();
  }
}

function private function_1d3ab9e562b3e3db(params) {
  level.player thread function_a685587c650ff936(int(params[0]));
}

function private function_ac26cf14f95df3f8(params) {
  direction = int(params[0]);
  level.player thread function_cf8e244be65c5a69(direction);
}

function private function_a685587c650ff936(team) {
  player = undefined;

  if(team == 0) {
    player = self;
  } else {
    foreach(p in level.players) {
      if(p.team != self.team) {
        player = p;
      }
    }

    if(!isDefined(player)) {
      iprintlnbold("<dev string:x1f1>");
      return;
    }
  }

  streakinfo = namespace_2b1145f62aa835b8::createstreakinfosharedfunc("<dev string:x227>", player);
  streakinfo.targetoverride = self.origin;
  streakinfo.uid = player bunker_buster::function_a9a0e979105b948d();
  player thread bunker_buster::strike_fire(streakinfo);
}

function private function_cf8e244be65c5a69(direction) {
  self notify("<dev string:x238>");
  self endon("<dev string:x238>");
  origin = self.origin;

  if(getdvarint(@ "hash_1826bea9905c3eea", 0)) {
    origin = level.var_8665203d66afed4f;
    setDvar(@ "hash_1826bea9905c3eea", 0);
  } else {
    level.var_8665203d66afed4f = origin;
  }

  missile = spawn_missile(origin);
  do_opposite = 0;

  if(direction == 2) {
    direction = 0;
    do_opposite = 1;
  }

  dir_trace = missile full_rt(direction);

  if(isDefined(dir_trace)) {
    if(do_opposite) {
      var_b7d610ade1b826e8 = missile full_rt(!direction);
    }
  }

  stuck_to = missile function_e9b8d48cb8dd3d5a();

  if(getdvarint(@ "hash_d2398cc34f83ff2b", 1)) {
    level thread missile_explosion(missile, stuck_to);

    if(isDefined(dir_trace) && dir_trace.size > 0) {
      has_debug = isDefined(dir_trace["<dev string:x258>"]) + isDefined(dir_trace[dir_trace.size - 1]["<dev string:x265>"]);

      for(i = 0; i < dir_trace.size - has_debug; i++) {
        potential_output = dir_trace[i];

        if(i > 1) {
          var_f5ba189e648743db = dir_trace[i - 1];
          dist = distance(potential_output["<dev string:x26d>"], var_f5ba189e648743db["<dev string:x26d>"]);

          if(dist > 512) {
            break;
          }

          if(dist < 64) {
            continue;
          }
        }

        missile = spawn_missile(potential_output["<dev string:x26d>"], -32, (0, 0, -1024), missile);
        stuck_to = missile function_e9b8d48cb8dd3d5a();
        level thread missile_explosion(missile, stuck_to);
      }
    }
  }

  if(isDefined(missile)) {
    missile thread utility::delete_after_delay(level.framedurationseconds);
    missile function_f6ddf2accdb58432();
  }
}

function private full_rt(direction) {
  start = direction == 0 ? self.origin : utility::flat_origin(self.origin);
  end = direction == 0 ? utility::flat_origin(self.origin) : self.origin;
  contents = trace::create_contents(0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0);
  rt_type = getdvarint(@ "hash_604388345506b32e", 0);

  if(rt_type == 0) {
    trace = trace::ray_trace_get_all_results(start, end, [self], contents, 1);
  } else if(rt_type == 1) {
    trace = trace::capsule_trace_get_all_results(start, end, 16, 32, self.angles, [self], contents, 1);
  } else if(rt_type == 2) {
    trace = trace::sphere_trace_get_all_results(start, end, 32, [self], contents, 1, 0);
  }

  if(trace.size == 1) {
    key = getarraykey(trace, 0);

    if(isstring(key) && key == "<dev string:x258>") {
      return undefined;
    }
  }

  trace = adjust_trace(trace, end, direction, 128, 360);

  if(isDefined(trace)) {
    switch (direction) {
      case 0:
        color = (1, 1, 1);
        break;
      case 1:
        color = (1, 0.5, 0);
        break;
      case 2:
        color = (1, 1, 0);
        break;
    }

    trace::draw_trace(trace, color, 1, int(60 / level.framedurationseconds));
  }

  return trace;
}

function private adjust_trace(trace, end, direction, min_dist, max_dist) {
  if(!getdvarint(@ "hash_e4b86b7a307bc35", 1)) {
    return trace;
  }

  if(trace.size == 0) {
    return undefined;
  }

  valid_trace = [];

  if(isDefined(trace["<dev string:x258>"])) {
    debug_data = trace["<dev string:x258>"];
    trace["<dev string:x258>"] = undefined;
  }

  if(direction == 1) {
    trace = utility::array_reverse(trace);
  }

  for(i = 0; i < trace.size; i++) {
    if(!isDefined(trace[i])) {
      continue;
    }

    ct = trace[i];

    if(!isDefined(trace[i + 1])) {
      if(valid_trace.size == 0) {
        break;
      }

      ntp = valid_trace[valid_trace.size - 1]["<dev string:x26d>"];
    } else {
      ntp = trace[i + 1]["<dev string:x26d>"];
    }

    dist = abs(distance(ct["<dev string:x26d>"], ntp));

    if(dist == 0) {
      valid_trace = utility::array_add(valid_trace, ct);
      break;
    }

    if(dist < min_dist) {
      continue;
    }

    if(getdvarint(@ "hash_65fd9d08dc67fde1", 0)) {
      if(dist >= max_dist) {
        if(i < trace.size) {
          valid_trace = utility::array_add(valid_trace, ct);
        }

        break;
      }
    }

    if(direction == 1 && getdvarint(@ "hash_95dca2c14e359be2", 1)) {
      test_trace = trace::ray_trace(ct["<dev string:x26d>"], utility::flat_origin(ct["<dev string:x26d>"]), undefined, undefined, 1, 1, 0);

      if(test_trace["<dev string:x279>"] == "<dev string:x284>") {
        continue;
      }
    }

    valid_trace = utility::array_add(valid_trace, ct);
  }

  if(valid_trace.size > 0) {
    if(isDefined(debug_data)) {
      valid_trace = utility::array_add(valid_trace, debug_data);
    }

    return valid_trace;
  }

  if(isDefined(ct) && direction == 1 && getdvarint(@ "hash_95dca2c14e359be2", 1)) {
    test_trace = trace::ray_trace(ct["<dev string:x26d>"], utility::flat_origin(ct["<dev string:x26d>"]), undefined, undefined, 1, 1, 0);

    if(test_trace["<dev string:x279>"] == "<dev string:x284>") {
      return undefined;
    }
  }

  if(isDefined(debug_data)) {
    trace = utility::array_add(trace, debug_data);
  }

  return trace;
}

function private spawn_missile(origin, offset, velocity, prev_missile) {
  if(!isDefined(offset)) {
    offset = 4096;
  }

  if(!isDefined(velocity)) {
    velocity = (0, 0, 0);
  }

  var_206dbd116490dd48 = {
    #initvelocity: velocity, #sourcepos: origin + (0, 0, offset), #goalpos: origin
  };

  if(!isDefined(prev_missile)) {
    streakinfo = namespace_2b1145f62aa835b8::createstreakinfosharedfunc("<dev string:x227>", self);
  } else {
    streakinfo = prev_missile.streakinfo;
  }

  missile = magicgrenademanual("<dev string:x294>", var_206dbd116490dd48.sourcepos, var_206dbd116490dd48.initvelocity, 6, self);
  missile setscriptablepartstate("<dev string:x2a4>", "<dev string:x2ad>", 0);

  if(!isDefined(prev_missile)) {
    missile setscriptablepartstate("<dev string:x2b7>", "<dev string:x2ad>", 0);
  }

  if(isDefined(prev_missile)) {
    minimapid = prev_missile.minimapid;
    prev_missile delete();
  } else {
    minimapid = undefined;

    if(utility::issharedfuncdefined("<dev string:x2c1>", "<dev string:x2c9>")) {
      minimapid = missile[[utility::getsharedfunc("<dev string:x2c1>", "<dev string:x2c9>")]]("<dev string:x2dc>", self.team, undefined, 1, 1);
    }
  }

  missile.minimapid = minimapid;
  missile.streakinfo = streakinfo;
  missile.owner = self;
  missile setentityowner(self);
  missile setotherent(self);
  missile forcenetfieldhighlod(1);
  return missile;
}

function private function_f6ddf2accdb58432() {
  if(self.classname != "<dev string:x309>") {
    namespace_2b1145f62aa835b8::setmissileminimapvisiblesharedfunc(0);
  }

  if(isDefined(self.minimapid)) {
    if(utility::issharedfuncdefined("<dev string:x2c1>", "<dev string:x319>")) {
      [[utility::getsharedfunc("<dev string:x2c1>", "<dev string:x319>")]](self.minimapid);
    }

    self.minimapid = undefined;
  }
}

function private function_e9b8d48cb8dd3d5a() {
  impact_info = killstreak_shared::function_675ba1ee79efdc70("<dev string:x32e>", "<dev string:x33f>");
  stuck_to = undefined;

  if(isDefined(impact_info)) {
    if(impact_info.msg == "<dev string:x32e>") {
      stuck_to = impact_info.param1;
    } else if(impact_info.msg == "<dev string:x33f>") {
      self.water_impact = 1;
    }
  }

  return stuck_to;
}

function private missile_explosion(missile, stuck_to) {
  if(!getdvarint(@ "hash_21fb555b256afb3a", 1)) {
    return;
  }

  explosion_ent = toma_strike::toma_strike_create_explosion(missile.origin, missile.angles, stuck_to, missile.owner, gettime(), missile.streakinfo);
  explode_part = istrue(missile.water_impact) ? "<dev string:x357>" : "<dev string:x36e>";
  explosion_ent setscriptablepartstate(explode_part, "<dev string:x2ad>", 0);
  explosion_ent thread utility::delete_after_delay(0.1);
}

# /