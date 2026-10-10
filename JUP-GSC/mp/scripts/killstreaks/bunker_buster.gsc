/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\bunker_buster.gsc
****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace bunker_buster;

function autoexec main() {
  killstreak_shared::function_df7ab5b0f898e8bc(function_1823ff50bb28148d("bunker_buster"), &init);
}

function private init() {
  utility::function_2bf8ec790b5a10f8(@ "hash_fa92580eadd91682", &debug_init);

  if(utility::issharedfuncdefined("bunker_buster", "init")) {
    [[utility::getsharedfunc("bunker_buster", "init")]]();
  }

  namespace_2b1145f62aa835b8::function_62de81d97c7d9e49("bunker_buster", &function_4927316e0d7c0fde, undefined, undefined);
  utility::registersharedfunc("bunker_buster", "tryUseKillstreak", &function_4927316e0d7c0fde);
  init_vars();
}

function private init_vars() {
  level.bunker_buster = {
    #count: 0, #active: []
  };
  level.bunker_buster.max_active = getdvarint(@ "hash_fefb922caac82d40", 3);
  level.bunker_buster.var_d402c1bdbe81e7fe = getdvarint(@ "hash_22beca14dc5c5e9e", 1);
  level.bunker_buster.var_d1bf099ff9ac4ee6 = getdvarint(@ "hash_7531df69c5e1c03c", 25000);
  level.bunker_buster.var_d1bf099ff9ac4ee6 *= level.bunker_buster.var_d1bf099ff9ac4ee6;
  level.bunker_buster.var_fdc62d807ea3440b = getdvarint(@ "hash_f6c741cacf5a1bd1", 1);
  level.bunker_buster.cooldown = getdvarint(@ "hash_359501fa941316db", 10);
  bundle = level.streakglobals.streakbundles["bunker_buster"];
  assertex(isDefined(bundle), "<dev string:x1c>" + "<dev string:x38>" + "<dev string:x52>" + "<dev string:x63>");
  level.bunker_buster.gas_lifetime = getdvarint(@ "hash_13661b583bd4e977", bundle.var_af691ff0e5ce5649);
  level.bunker_buster.gas_radius = getdvarint(@ "hash_84afb79d4b21c60a", bundle.var_9f87e4c344f40cb8);
  level.bunker_buster.travel_distance = getdvarint(@ "hash_45fce07839c26931", bundle.bunker_buster_distance);
  level.bunker_buster.explosion_radius = getdvarint(@ "hash_e9222aff0b6e25e4", bundle.bunker_buster_explosionradius);
  level.bunker_buster.var_daf4bed8de8f6195 = getdvarint(@ "hash_3dd9eddc725440b6", bundle.var_f650a0ecedab0825);
  level.bunker_buster.var_fc268ff83cc63313 = getdvarint(@ "hash_c84afea8311a2900", bundle.var_1029beb459a7eeb3);
  level.bunker_buster.drop_time = getdvarint(@ "hash_183522347c70eb09", bundle.bunker_buster_droptime);
  level.bunker_buster.projectile_weapon = bundle.projectileweapon;
}

function private function_4927316e0d7c0fde(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = killstreak_utility::createstreakinfo("bunker_buster", self);
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  bundle = level.streakglobals.streakbundles["bunker_buster"];
  deployresult = namespace_2b1145f62aa835b8::function_de31b76c1bf488e8(streakinfo, weapon_utility::function_eeaa22f0cd1ff845(bundle.deployweaponname), "weapon_fired", &function_bc826a7fccd0726, &airstrike::weaponswitchendedairstrike, &function_ae65fc01c45c017);

  if(!istrue(deployresult)) {
    self setclientomnvar("ui_using_bunkerbuster", 0);
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  if(utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "bunker_buster", self);
  }

  strike_create(streakinfo);
  return true;
}

function private function_51cd3b505e34ce9e() {
  mindistsq = level.bunker_buster.var_d1bf099ff9ac4ee6;

  if(level.mapname == "<dev string:x75>") {
    mindistsq = 1000000;
  }

  return mindistsq;
}

function function_d060d792db569706(strikelocation) {
  shortestleft = 2147483647;

  foreach(activestrike in level.bunker_buster.active) {
    timeleft = int(max(1, activestrike.endtimems - gettime()));

    if(timeleft < shortestleft) {
      shortestleft = timeleft;
    }
  }

  return int(function_c89ed1840c8d0f0f(shortestleft)) + 1;
}

function function_6c7ff6391027eb0c(strikelocation) {
  shortestleft = 2147483647;
  mindistsq = function_51cd3b505e34ce9e();
  numactive = 0;

  foreach(activestrike in level.bunker_buster.active) {
    if(distance2dsquared(activestrike.origin, strikelocation) <= mindistsq) {
      timeleft = int(max(1, activestrike.endtimems - gettime()));

      if(timeleft < shortestleft) {
        shortestleft = timeleft;
      }
    }
  }

  return int(function_c89ed1840c8d0f0f(shortestleft)) + 1;
}

function private function_bc826a7fccd0726(streakinfo) {
  if(!function_d0ae421563f27fe()) {
    if(level.bunker_buster.var_fdc62d807ea3440b) {
      timesec = function_d060d792db569706();
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME", timesec);
    } else {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return false;
  }

  self setclientomnvar("ui_using_bunkerbuster", 1);
  return true;
}

function private function_d0ae421563f27fe() {
  if(level.bunker_buster.active.size >= level.bunker_buster.max_active) {
    return false;
  }

  return true;
}

function private function_ae65fc01c45c017(streakinfo, var_a9dd4e8c5e5c7178, firedprojectile) {
  if(!isDefined(streakinfo.targetoverride)) {
    mappoint = airstrike::airstrike_getownerlookatpos(self, 1);

    if(isDefined(mappoint)) {
      if(!function_d0ae421563f27fe()) {
        if(level.bunker_buster.var_fdc62d807ea3440b) {
          timesec = function_d060d792db569706();

          if(issharedfuncdefined("hud", "showErrorMessage")) {
            [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME", timesec);
          }
        } else if(issharedfuncdefined("hud", "showErrorMessage")) {
          [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
        }

        return "continue";
      } else if(level.bunker_buster.var_d402c1bdbe81e7fe > 0) {
        mindistsq = function_51cd3b505e34ce9e();
        numactive = 0;

        foreach(activestrike in level.bunker_buster.active) {
          if(distance2dsquared(activestrike.origin, mappoint) <= mindistsq) {
            numactive++;

            if(numactive >= level.bunker_buster.var_d402c1bdbe81e7fe) {
              if(level.bunker_buster.var_fdc62d807ea3440b) {
                timesec = function_6c7ff6391027eb0c(mappoint);

                if(issharedfuncdefined("hud", "showErrorMessage")) {
                  [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME", timesec);
                }
              } else if(issharedfuncdefined("hud", "showErrorMessage")) {
                [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA");
              }

              return "continue";
            }
          }
        }
      }
    } else {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      }

      return "continue";
    }
  }

  if(namespace_2b1145f62aa835b8::function_f3890748bda5f813()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  if(namespace_2b1145f62aa835b8::function_b1412f0ab907bab7()) {
    self setclientomnvar("ui_using_bunkerbuster", 0);
  }

  return "success";
}

function function_9e6e776ebef42c6b(origin, streakinfo) {
  newstrike = spawnStruct();
  newstrike.origin = origin;
  newstrike.id = streakinfo.uid;
  newstrike.endtimems = gettime() + 1000 * (level.bunker_buster.cooldown + 5);
  level.bunker_buster.active[newstrike.id] = newstrike;
  return newstrike.id;
}

function private strike_create(streakinfo) {
  streakinfo.uid = function_a9a0e979105b948d();
  thread strike_fire(streakinfo);
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });
}

function strike_fire(streakinfo) {
  streakinfo.shots_fired++;
  marker_pos = isDefined(streakinfo.targetoverride) ? streakinfo.targetoverride : airstrike::airstrike_getownerlookatpos(self, 1);
  assertex(isDefined(marker_pos), "<dev string:x88>");
  function_9e6e776ebef42c6b(marker_pos, streakinfo);
  marker = utility::spawn_model("ks_toma_strike_marker_mp", marker_pos);
  marker.objidnum = 0;
  marker.icon = "icon_waypoint_bunker_buster";

  if(utility::issharedfuncdefined("game", "requestObjectiveID")) {
    marker.objidnum = [[utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  marker setotherent(self);
  marker toma_strike::toma_strike_setmarkerobjective(marker.objidnum, marker.icon, self, 50);
  marker thread function_aad1a178bf665f2a();
  utility::function_f3bb4f4911a1beb2("bunker_buster", "dialog_deploy", self);
  namespace_2b1145f62aa835b8::function_940b2080e171a9d3(self, self.team, 1024, "bunker_buster", marker_pos);
  notify_players = function_153d5add7253b500(self, self.team, 1024, marker_pos);
  utility::function_f3bb4f4911a1beb2("bunker_buster", "dialog_warning", notify_players[0], notify_players[1]);
  namespace_2b1145f62aa835b8::function_2284137aa92dbd16(level.bunker_buster.drop_time);
  strike_logic(marker_pos, streakinfo);
  wait level.bunker_buster.cooldown;
  strike_end(streakinfo);
}

function strike_end(streakinfo) {
  level.bunker_buster.active = array_remove_index(level.bunker_buster.active, streakinfo.uid, 1);
  level notify("bunker_buster" + "_finished_" + streakinfo.uid);
}

function private function_153d5add7253b500(owner, team, range, location) {
  players = getplayersinradius(location, range, 1000);
  friendlies = [];
  enemies = [];

  foreach(player in players) {
    if(player == owner) {
      continue;
    }

    if(player.team == team) {
      friendlies[friendlies.size] = player;
      continue;
    }

    enemies[enemies.size] = player;
  }

  return [friendlies, enemies];
}

function function_a9a0e979105b948d() {
  level.bunker_buster.count++;
  return self getxuid() + "_" + level.bunker_buster.count;
}

function strike_logic(position, streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("bunker_buster" + "_finished_" + streakinfo.uid);
  missile = missile_spawn(position, 5000, (0, 0, -1000));
  missile.streakinfo = streakinfo;
  missile.streakname = streakinfo.streakname;
  results = missile function_f4b21fbcf97269e8(self);
  stuck_to = results[0];
  missile = results[1];
  hit = results[2];

  if(!isDefined(missile)) {
    return;
  }

  streakinfo.impact_location = missile.origin;
  streakinfo.water_impact = missile.water_impact;
  streakinfo.impact_time = scripts\cp_mp\utility\game_utility::gettimepassed();
  activestrike = level.bunker_buster.active[streakinfo.uid];

  if(isDefined(activestrike)) {
    activestrike.endtimems = gettime() + 1000 * (level.bunker_buster.cooldown + 1);
  }

  missile function_9d0257c1da72ca5d();
  missile.angles = (0, 0, 0);

  if(missile islinked()) {
    missile unlink();
  }

  missile setscriptablepartstate("visibility", "hide");
  missile.exploded = 1;
  streakinfo.explosion_victims = function_5ddd621f797a85b5(streakinfo.impact_location, self);
  streakinfo.gas_victims = [];
  waitframe();
  missile setscriptablepartstate("explode", istrue(streakinfo.water_impact) ? "explode_water" : "explode");
  missile function_5300adfce0ef3191();

  if(istrue(hit)) {
    streakinfo.explosion_victims["exception_credit"] = 1;
  }

  wait 0.25;
  currentradius = 30;
  streakinfo.mapcircle = function_dc11c1caffe56e16("NovaGas_Br", streakinfo.impact_location[0], streakinfo.impact_location[1], currentradius, self);
  streakinfo.mapcircle show();
  deltaradius = level.bunker_buster.gas_radius - currentradius;
  level thread function_c6c97baa041205e(streakinfo, &game_utility::function_4584ad1c0e2c58ec, currentradius, deltaradius, 1.25);
  wait 0.75;
  missile delete();
  utility::function_f3bb4f4911a1beb2("bunker_buster", "missile_gas_volume", streakinfo.impact_location + (0, 0, 128), streakinfo.impact_location - (0, 0, level.bunker_buster.travel_distance), level.bunker_buster.gas_radius, streakinfo);
  thread function_61ac63303c87acda(3, streakinfo);
  level thread function_4c86258acf5f82bf(streakinfo.impact_location, streakinfo.water_impact);
  streakinfo.mapcircle thread utility::function_b4b04de87729a6f3(level.bunker_buster.gas_lifetime);
  level thread function_d86280932be7b254(level.bunker_buster.gas_lifetime, streakinfo);
}

function function_d86280932be7b254(delay, streak_info) {
  level endon("game_ended");
  wait delay;
  thread function_184a66360bf3e401(streak_info);
  thread function_ce7b42754785fc(streak_info);
}

function private function_5ddd621f797a85b5(location, owner) {
  affected_players = getplayersinradius(location, level.bunker_buster.travel_distance);
  victims = [];

  foreach(player in affected_players) {
    if(player != owner && player.team == owner.team) {
      continue;
    }

    if(distance2d(player.origin, location) > level.bunker_buster.explosion_radius) {
      continue;
    }

    victims[victims.size] = player;
  }

  return victims;
}

function private function_61ac63303c87acda(delay, streak_info) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait delay;
  utility::function_f3bb4f4911a1beb2("bunker_buster", "dialog_hits", self, streak_info);
}

function missile_spawn(origin, offset, velocity, exp_time, prev_missile) {
  if(!isDefined(offset)) {
    offset = 4096;
  }

  if(!isDefined(velocity)) {
    velocity = (0, 0, 0);
  }

  if(!isDefined(exp_time)) {
    exp_time = 6;
  }

  var_206dbd116490dd48 = {
    #initvelocity: velocity, #sourcepos: origin + (0, 0, offset), #goalpos: origin
  };
  missile = magicgrenademanual("bunker_buster_proj_jup_mp", var_206dbd116490dd48.sourcepos, var_206dbd116490dd48.initvelocity, exp_time);

  if(!isDefined(prev_missile)) {
    missile setscriptablepartstate("trail", "active", 0);
  } else {
    missile setscriptablepartstate("trail", "continue", 0);
  }

  if(!isDefined(prev_missile)) {
    missile setscriptablepartstate("launch", "active", 0);
    missile thread function_2a1d38d2eba581d2(self);
  }

  if(isDefined(prev_missile)) {
    minimapid = prev_missile.minimapid;
    streakinfo = prev_missile.streakinfo;
    prev_missile delete();
  } else {
    minimapid = undefined;

    if(utility::issharedfuncdefined("game", "createObjective")) {
      minimapid = missile[[utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_bunker_buster", self.team, undefined, 1, 1);
    }
  }

  missile.minimapid = minimapid;
  missile.owner = self;

  if(isDefined(streakinfo)) {
    missile.streakinfo = streakinfo;
    missile.streakname = streakinfo.streakname;
  }

  missile setentityowner(self);
  missile setotherent(self);
  missile forcenetfieldhighlod(1);
  missile thread function_fd8677bd03da3d3b();
  missile thread function_93c5e685b2a30986();
  missile.empapplycallback = &function_240e63c6a103482b;

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    missile[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_240e63c6a103482b);
  }

  return missile;
}

function function_2a1d38d2eba581d2(owner) {
  level endon("game_ended");
  owner endon("disconnect");
  self endon("death");
  self endon("emp_debuff");
  self endon("missile_stuck");
  self endon("missile_water_impact");
  wait 1;
  function_9d0257c1da72ca5d(1);
  self setmissileminimapvisible(1);
}

function function_5300adfce0ef3191() {
  streakinfo = self.streakinfo;

  if(isDefined(streakinfo.explosion_victims)) {
    foreach(player in streakinfo.explosion_victims) {
      v_dist = abs(self.origin[2] - player.origin[2]);
      travel_time = mapfloat(0, level.bunker_buster.travel_distance, 0, 0.5, v_dist);
      thread function_f71fc273e43f587b(player, travel_time);
    }
  }

  function_e45e5fd94ec4af36(0.5, 0.3, 0.2, 1.5, self.origin, level.bunker_buster.explosion_radius, 1000, 5000);
}

function function_f71fc273e43f587b(player, travel_time) {
  player endon("disconnect");

  if(travel_time >= level.framedurationseconds) {
    wait travel_time;
  }

  h_dist = distance2d(player.origin, self.origin);
  damage = int(mapfloat(0, level.bunker_buster.explosion_radius, level.bunker_buster.var_fc268ff83cc63313, level.bunker_buster.var_daf4bed8de8f6195, h_dist));
  player dodamage(damage, self.origin, self.owner, self, "MOD_EXPLOSIVE", level.bunker_buster.projectile_weapon, "none", undefined, 1);
}

function function_93c5e685b2a30986() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("missile_stuck");
  self endon("missile_water_impact");
  self waittill("emp_debuff");
  self setscriptablepartstate("explode", "explode_air");
  self setscriptablepartstate("visibility", "hide");
  waitframe();
  function_5300adfce0ef3191();
  function_9d0257c1da72ca5d();
  strike_end(self.streakinfo);
  self delete();
}

function function_fd8677bd03da3d3b() {
  self endon("death");
  level endon("game_ended");
  self.owner waittill("disconnect");
  function_9d0257c1da72ca5d();
  strike_end(self.streakinfo);
  self delete();
}

function function_aad1a178bf665f2a() {
  self endon("death");
  self setscriptablepartstate("target", "on", 0);
  namespace_2b1145f62aa835b8::function_2284137aa92dbd16(6);

  if(isDefined(self)) {
    if(utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
    }

    self delete();
  }
}

function function_9d0257c1da72ca5d(obj_only) {
  if(!isDefined(obj_only)) {
    obj_only = 0;
  }

  if(!obj_only) {
    self setmissileminimapvisible(0);
  }

  if(isDefined(self.minimapid)) {
    if(utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }
}

function function_f4b21fbcf97269e8(player) {
  missile = self;
  hit = 0;

  while(true) {
    impact_info = missile killstreak_shared::function_675ba1ee79efdc70("missile_stuck", "missile_water_impact");
    stuck_to = undefined;

    if(impact_info.msg == "missile_stuck") {
      stuck_to = impact_info.param1;
    } else if(impact_info.msg == "missile_water_impact") {
      missile.water_impact = 1;
    } else if(impact_info.msg == "death") {
      break;
    }

    if(!isDefined(stuck_to) && isDefined(impact_info.param5)) {
      var_c8004735a05ab3f7 = sortbydistance(getentitylessscriptablearray("scriptable_scriptable_redeploy_drone", "classname"), impact_info.param5)[0];

      if(isDefined(var_c8004735a05ab3f7) && istrue(var_c8004735a05ab3f7.b_occupied) && distancesquared(impact_info.param5, var_c8004735a05ab3f7.origin) < squared(100)) {
        if(!istrue(var_c8004735a05ab3f7.var_3d94e3b5be6fd3d1)) {
          if(utility::issharedfuncdefined("redeploy_drone", "redeploy_drone_repopulation_watcher")) {
            level thread[[utility::getsharedfunc("redeploy_drone", "redeploy_drone_repopulation_watcher")]](var_c8004735a05ab3f7);
          }
        }

        if(utility::issharedfuncdefined("redeploy_drone", "redeploy_drone_destroyed")) {
          var_c8004735a05ab3f7[[utility::getsharedfunc("redeploy_drone", "redeploy_drone_destroyed")]](player, undefined, 1);
        }

        hit = 1;
        missile = player missile_spawn(missile.origin, 0, (0, 0, -3000), undefined, missile);
        continue;
      }
    }

    if(isDefined(stuck_to) && isDefined(stuck_to.classname) && stuck_to.classname == "script_vehicle" && stuck_to function_89db472b36958666()) {
      data = spawnStruct();
      data.inflictor = self;
      data.objweapon = undefined;
      data.meansofdeath = "MOD_CRUSH";
      data.attacker = player;
      stuck_to thread scripts\cp_mp\vehicles\vehicle::vehicle_explode(data, 1);
      hit = 1;
      var_feaa972f48639274 = 0;

      if(stuck_to isairplane() || stuck_to ishelicopter()) {
        var_feaa972f48639274 = getdvarint(@ "hash_152940226617a500", 150);
      }

      missile = player missile_spawn(missile.origin - (0, 0, var_feaa972f48639274), 0, (0, 0, -3000), undefined, missile);
      continue;
    }

    break;
  }

  return [stuck_to, missile, hit];
}

function function_4c86258acf5f82bf(impact_position, water_impact) {
  level endon("game_ended");
  scriptables = [];

  if(!istrue(water_impact)) {
    dir = (0, 0, -1);
    base_offset = level.bunker_buster.travel_distance / 2 * dir;
    height_offset = base_offset * 0.5;

    for(i = 0; i < 2; i++) {
      s = spawnscriptable("ks_bunker_buster_gas_sfx", impact_position + base_offset * i + height_offset);
      s setscriptablepartstate("ks_bunker_buster_gas_sfx", "on");
      scriptables[scriptables.size] = s;
    }
  } else {
    s = spawnscriptable("ks_bunker_buster_gas_sfx", impact_position);
    s setscriptablepartstate("ks_bunker_buster_gas_sfx", "on");
    scriptables[scriptables.size] = s;
  }

  wait level.bunker_buster.gas_lifetime + 1;

  foreach(scriptable in scriptables) {
    scriptable freescriptable();
  }
}

function function_240e63c6a103482b(data) {
  if(isDefined(self) && isDefined(self.owner) && !istrue(self.exploded)) {
    self notify("emp_debuff");
  }
}

function function_184a66360bf3e401(streak_info) {
  eventparams = ["pos_x", streak_info.impact_location[0], "pos_y", streak_info.impact_location[1], "pos_z", streak_info.impact_location[2], "impact_time", streak_info.impact_time, "explosion_victims", streak_info.explosion_victims.size, "gas_victims", streak_info.gas_victims.size];
  dlog_recordevent("dlog_event_br_bunker_buster_complete", eventparams);
}

function function_ce7b42754785fc(streak_info) {
  if(!isDefined(streak_info.owner)) {
    return;
  }

  victims = streak_info.explosion_victims;

  if(victims.size > 0) {
    challenges::function_8359cadd253f9604(streak_info.owner, "br_decay_ks_strike_hit", victims.size);
  }
}

function private function_c6c97baa041205e(object, func, currentparam, deltaparam, seconds) {
  level endon("game_ended");
  starttime = gettime();
  seconds *= 1000;

  while(true) {
    elapsedtime = gettime() - starttime;

    if(elapsedtime >= seconds) {
      break;
    }

    scale = elapsedtime / seconds;
    newparam = currentparam + deltaparam * scale;
    object[[func]](newparam);
    waitframe();
  }
}

function function_b1eab7c7fda1fb57() {}

function debug_init() {
  level thread function_db5c75f2a84ff03d();
}

function function_db5c75f2a84ff03d() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:xb8>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:xd0>", "<dev string:xdf>", &function_defff2269ca98e79);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:xfc>", "<dev string:x10f>", &function_b45f9974855e1e8);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_defff2269ca98e79() {
  v_pos = (3673, 7719, 5000);
  heli = sortbydistance(level.vehicle.instances["<dev string:x130>"], v_pos)[0];

  if(heli == level.research_vessel.heli) {
    heli = sortbydistance(level.vehicle.instances["<dev string:x130>"], v_pos)[1];
  }

  while(isalive(heli)) {
    heli vehicle_teleport(v_pos, (0, 0, 0), 1);
    waitframe();
  }
}

function function_b45f9974855e1e8() {
  level init_vars();
}

# /