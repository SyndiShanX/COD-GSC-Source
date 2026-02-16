/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_area_invalidation.gsc
**************************************************/

init() {
  level._effect["zone_explode"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
  level._effect["pickup_camo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_camo");
  level.breachzones = [];
  level.breachtimers = [];
  level.get_breached_zones_func = ::get_breached_zones;
  level.zone_is_breached_func = ::zone_is_breached;
  level.zone_is_contaminated_func = ::zone_is_contaminated;
  level.defusedamagemultiplier = 2.0;
  level.breachmapfunc = ::breach_map_func;
  level.bombsdefused = 0;
  var_0 = getEntArray("zombies_defuse_bomb", "targetname");

  foreach(var_2 in var_0) {
    var_3 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_2.origin);

    if(!isDefined(level.breachzones[var_3])) {
      level.breachzones[var_3] = spawnStruct();
      level.breachzones[var_3].status = 0;
      level.breachzones[var_3].lastfixtime = 0;
      level.breachzones[var_3].defuseobjs = [];
    }

    var_4 = var_2 initdefuseobject();
    var_4.zonename = var_3;
    level.breachzones[var_3].defuseobjs[level.breachzones[var_3].defuseobjs.size] = var_4;
  }

  level thread run_breach_logic();
  level thread initsaboteurdata();
  level thread monitordefusetime();
}

breach_map_func(var_0) {
  if(!isDefined(var_0.script_flag_true)) {
    return;
  }
  if(!common_scripts\utility::flag_exist(var_0.script_flag_true)) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    var_0 ghost();
    common_scripts\utility::flag_wait(var_0.script_flag_true);
    var_0 show();
    common_scripts\utility::flag_waitopen(var_0.script_flag_true);
  }
}

monitordefusetime() {
  level endon("game_ended");

  for(;;) {
    if(maps\mp\zombies\_util::getnumplayers() == 1) {
      level.defusetime = 2.0;
    } else {
      level.defusetime = 5.0;
    }

    wait 1.0;
  }
}

initsaboteurdata() {
  while(!isDefined(level.agent_funcs) || !isDefined(level.agent_funcs["ranged_elite_soldier"])) {
    wait 0.05;
  }

  level.area_invalidation_soldier_type = "ranged_elite_soldier_saboteur";
  level.agent_funcs[level.area_invalidation_soldier_type] = level.agent_funcs["ranged_elite_soldier"];
  level.agent_funcs[level.area_invalidation_soldier_type]["think"] = ::soldier_think;
  var_0 = level.agentclasses["ranged_elite_soldier"];
  maps\mp\zombies\_util::agentclassregister(var_0, level.area_invalidation_soldier_type);

  while(!isDefined(level.agent_funcs["ranged_elite_soldier_goliath"])) {
    wait 0.05;
  }

  level.area_invalidation_goliath_type = "ranged_elite_soldier_goliath_saboteur";
  level.agent_funcs[level.area_invalidation_goliath_type] = level.agent_funcs["ranged_elite_soldier_goliath"];
  level.agent_funcs[level.area_invalidation_goliath_type]["think"] = ::soldier_think;
  level.getloadout[level.area_invalidation_goliath_type] = level.getloadout["ranged_elite_soldier_goliath"];
  level.onspawnfinished[level.area_invalidation_goliath_type] = level.onspawnfinished["ranged_elite_soldier_goliath"];
  var_1 = level.agentclasses["ranged_elite_soldier_goliath"];
  maps\mp\zombies\_util::agentclassregister(var_1, level.area_invalidation_goliath_type);
}

initdefuseobject() {
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"AREA_INVALIDATION_BOMB_DEFUSE");
  var_0 = getent(self.target, "targetname");
  var_0 makeunusable();
  self.trigger = var_0;
  var_1 = maps\mp\gametypes\_gameobjects::createuseobject("allies", var_0, [self], (0, 0, 32), 1);
  var_1 maps\mp\gametypes\_gameobjects::allowuse("friendly");
  var_1 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
  var_1.onbeginuse = ::defuseonbeginuse;
  var_1.onenduse = ::defuseonenduse;
  var_1.onuse = ::onusedefuseobject;
  var_1.nousebar = 1;
  var_1.id = "defuseObject";
  var_1.useweapon = "search_dstry_bomb_defuse_mp";
  var_1.visuals[0] hide();
  var_1.visuals[0].enabled = 0;
  return var_1;
}

activatedefuseobject() {
  maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
  self.visuals[0] hudoutlineenable(0, 0);
  self.visuals[0] setbombenabled(1);
  self.visuals[0] thread defusethink();
  self.hudicon = newhudelem();
  self.hudicon setshader("hud_waypoint_bomb", 8, 8);
  self.hudicon setwaypoint(1, 1);
  self.hudicon.x = self.visuals[0].origin[0];
  self.hudicon.y = self.visuals[0].origin[1];
  self.hudicon.z = self.visuals[0].origin[2] + 40;
}

deactivatedefuseobject() {
  self.visuals[0] setbombenabled(0);
  self.visuals[0] notify("bomb_exploded");

  if(isDefined(self.hudicon)) {
    self.hudicon destroy();
  }
}

defusethink() {
  level endon("game_ended");
  level endon("defuse_completed");
  self endon("bomb_exploded");

  for(;;) {
    self waittill("trigger", var_0);
    self.trigger notify("trigger", var_0);
  }
}

defuseonbeginuse(var_0) {
  var_0 notifysoldiersbombbeingused("defuse");
  var_0 playSound("mp_bomb_defuse");
  var_0.isdefusing = 1;
  self.visuals[0] setbombenabled(0);
  self.hudicon setshader("hud_waypoint_bomb_defuse", 8, 8);
  self.hudicon setwaypoint(1, 1);
}

defuseonenduse(var_0, var_1, var_2) {
  if(level.breachzones[self.zonename].status != 2) {
    self.visuals[0] setbombenabled(1);
    self.hudicon setshader("hud_waypoint_bomb", 8, 8);
    self.hudicon setwaypoint(1, 1);
  }

  if(isDefined(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }
}

onusedefuseobject(var_0) {
  var_0 notify("bomb_defused");
  self.visuals[0] setbombenabled(0);
  var_1 = var_0;

  if(!isPlayer(var_1) && isPlayer(var_1.owner)) {
    var_1 = var_1.owner;
  }

  var_1 maps\mp\gametypes\zombies::givepointsforevent("breach_fix");

  if(isPlayer(var_0)) {
    givedefuseachievement(var_0);
  }

  level.bombsdefused++;
  var_2 = var_0;

  if(!isPlayer(var_0)) {
    var_2 = level.players[0];
  }

  if(isDefined(var_2)) {
    var_2 thread maps\mp\_matchdata::loggameevent("zm_bomb_defuse", self.curorigin);
  }

  if(maps\mp\zombies\_util::is_true(level.breachinitial)) {
    var_3 = maps\mp\gametypes\zombies::selectnextvalidpickupavoid("ammo");
    maps\mp\gametypes\zombies::createpickup(var_3, var_0.origin, "Defuse Bomb");
  }

  level thread clean_zone(self.zonename);
  self.hudicon destroy();
  level thread dodefusefailvo();
}

dodefusefailvo() {
  wait 1;
  waittilldonespeaking();
  wait 1;
  var_0 = [];

  foreach(var_2 in level.participants) {
    if(isai(var_2) && var_2.team != level.playerteam) {
      var_2 notify("fail_gas");
      var_0[var_0.size] = var_2;
    }
  }

  for(var_4 = gettime() + 5000; var_4 > gettime() && var_0.size > 0; var_0 = common_scripts\utility::array_removeundefined(var_0)) {
    if(var_0[0] soldierplayvo("fail")) {
      break;
    }

    wait 0.1;
  }
}

waittilldonespeaking() {
  while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking()) {
    wait 0.1;
  }
}

anyplayersspeaking() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

givedefuseachievement(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.bombdefusecount)) {
    var_0.bombdefusecount = 0;
  }

  var_0.bombdefusecount++;

  if(var_0.bombdefusecount == 5) {
    var_0 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_DEFUSEBOMBS");
  }
}

setbombenabled(var_0) {
  if(var_0) {
    self show();
    self makeusable();
    self.enabled = 1;
  } else {
    self hide();
    self makeunusable();
    self.enabled = 0;
  }
}

notifysoldiersbombbeingused(var_0) {
  foreach(var_2 in level.participants) {
    if(!isai(var_2) || isalliedsentient(self, var_2)) {
      continue;
    }
    var_3 = 0;

    if(var_0 == "plant") {
      var_3 = 300 + var_2 botgetdifficultysetting("strategyLevel") * 100;
    } else if(var_0 == "defuse") {
      var_3 = 500 + var_2 botgetdifficultysetting("strategyLevel") * 500;
    }

    if(distancesquared(var_2.origin, self.origin) < squared(var_3)) {
      var_2.player_defuse_time = gettime();
      var_2 soldierplayvo("trydefuse");
    }
  }
}

setupzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.breachzones[var_0].exploderid = var_1;
  level.breachzones[var_0].omnvarid = var_2;
  level.breachzones[var_0].locname = var_3;
  level.breachzones[var_0].splashname = var_4;
  level.breachzones[var_0].defusesplashname = var_5;
  level.breachzones[var_0].detonatesplashname = var_6;
  level.breachzones[var_0].hascurestation = var_7;
  common_scripts\utility::flag_init("breach_" + var_0);
}

clean_zone_splash_delayed(var_0) {
  level endon("game_ended");

  if(maps\mp\zombies\_util::is_true(level.breachinitial)) {
    wait 1.0;
  }

  if(isDefined(level.breachzones[var_0].defusesplashname)) {
    maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[var_0].defusesplashname);
  }

  level thread dobreachclearedvo(var_0);
}

clean_zone(var_0) {
  if(level.breachzones[var_0].status == 0) {
    return;
  }
  if(level.breachzones[var_0].status == 1) {
    level thread clean_zone_splash_delayed(var_0);
    playsoundatpos((0, 0, 0), "event_gas_success");
    var_1 = get_soldiers_breaching_zone(var_0);

    foreach(var_3 in var_1) {
      var_3.bomb_guarding = undefined;
    }
  } else {
    stopclientexploder(level.breachzones[var_0].exploderid);
  }

  remove_breach_timer(var_0);
  level.breachzones[var_0].status = 0;
  level.breachzones[var_0].lastfixtime = gettime();
  common_scripts\utility::flag_clear("breach_" + var_0);
  level notify("clean" + var_0);

  foreach(var_6 in level.breachzones[var_0].defuseobjs) {
    var_6.soldiers = [];
  }
}

try_continue_breach(var_0, var_1) {
  if(var_0.size > 0) {
    var_2 = common_scripts\utility::getStructArray("soldier_teleport_struct", "targetname");

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];
      thread playteleportspawnfx(var_4.origin, 1.0);
      var_4 hide_soldier_and_make_invulnerable(1);
      var_4 setorigin(var_2[var_3].origin, 1);
    }

    wait 5.0;
    var_5 = get_contaminated_zones();
    var_6 = 0;

    if(var_5.size < 3) {
      var_6 = do_breach(var_0, var_1);

      if(!var_6) {
        var_6 = do_breach(var_0);
      }
    }

    if(!var_6) {
      foreach(var_4 in var_0) {
        var_4 suicide();
      }
    }
  }
}

hide_soldier_and_make_invulnerable(var_0) {
  if(var_0) {
    self hide();
  } else {
    self show();
  }

  self.ignoreme = var_0;
  self.ignoreall = var_0;
  self.godmode = var_0;
  self botsetflag("disable_movement", var_0);
}

breach_zone_timer(var_0) {
  level endon("game_ended");
  level endon("clean" + var_0);
  level endon("contaminate" + var_0);
  var_1 = gettime() + get_breach_time();

  for(;;) {
    var_2 = max(0, var_1 - gettime()) / 1000;
    var_3 = int(var_2 + 0.5);

    if(var_3 == 0) {
      break;
    }

    if(var_3 <= 10 || var_3 <= 30 && var_3 % 2 == 0) {
      playsoundatpos((0, 0, 0), "ui_mp_timer_countdown");
    }

    if(var_2 - floor(var_2) >= 0.05) {
      wait(var_2 - floor(var_2));
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  while(some_player_is_defusing()) {
    wait 0.05;
  }

  level thread contaminate_zone(var_0);
}

some_player_is_defusing() {
  foreach(var_1 in level.participants) {
    if(var_1.team == level.playerteam) {
      if(maps\mp\zombies\_util::is_true(var_1.isdefusing)) {
        return 1;
      }
    }
  }

  return 0;
}

get_active_bomb_ent(var_0) {
  foreach(var_2 in level.breachzones[var_0].defuseobjs) {
    if(var_2.visuals[0].enabled) {
      return var_2;
    }
  }

  return undefined;
}

breach_zone(var_0, var_1) {
  if(level.breachzones[var_0].status == 1) {
    return;
  }
  if(level.breachzones[var_0].status == 2) {
    clean_zone(var_0);
  }

  var_2 = level.breachzones[var_0].defuseobjs[randomint(level.breachzones[var_0].defuseobjs.size)];

  if(isDefined(var_1)) {
    movesoldierstonewzone(var_2, var_1);
  } else {
    spawnsoldiers(var_2, getnumsoldierstospawn());
  }

  var_2 activatedefuseobject();

  if(isDefined(level.players[0])) {
    level.players[0] thread maps\mp\_matchdata::loggameevent("zm_bomb_plant", var_2.curorigin);
  }

  if(isDefined(level.breachzones[var_0].splashname)) {
    maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[var_0].splashname);
  }

  level thread maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority", "exp_" + var_0, 1.5, undefined, undefined, undefined, undefined, level.players);
  playsoundatpos((0, 0, 0), "event_gas_start");
  level.breachzones[var_0].status = 1;
  level.breachinitial = !isDefined(var_1);
  add_breach_timer(var_0);
  level thread breach_zone_timer(var_0);
  common_scripts\utility::flag_set("breach_" + var_0);
  level notify("breach" + var_0);
}

getnumsoldierstospawn() {
  var_0 = maps\mp\zombies\_util::getnumplayers();

  if(var_0 == 2) {
    return 3;
  } else if(var_0 == 1) {
    return 2;
  }

  return 4;
}

movesoldierstonewzone(var_0, var_1) {
  var_2 = var_0.visuals[0] maps\mp\zombies\killstreaks\_zombie_squadmate::getvalidspawnnodesforsquadmate(var_1.size);
  var_0.soldiers = var_1;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] setorigin(var_2[var_3].origin);
    var_1[var_3] setangles(vectortoangles(var_0.curorigin - var_2[var_3].origin));
    var_1[var_3].bomb_guarding = var_0;
    var_1[var_3] hide_soldier_and_make_invulnerable(0);
    var_1[var_3] thread soldier_think();
    thread playteleportspawnfx(var_2[var_3].origin, 3.0);
  }
}

spawnsoldiers(var_0, var_1) {
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  while(!var_4) {
    var_5 = level.players[0] maps\mp\zombies\_util::getenemyagents();
    var_6 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
    var_2 = var_5.size + var_6 - (maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - var_1);
    var_3 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_5);

    if(var_3.size >= var_2) {
      var_4 = 1;
      continue;
    }

    wait 0.05;
  }

  var_7 = 0;

  if(var_2 > 0) {
    maps\mp\zombies\_util::pausezombiespawning(1);
    var_7 = 1;
    var_3 = common_scripts\utility::array_randomize(var_3);
    var_8 = [];

    for(var_9 = 0; var_9 < var_2; var_9++) {
      var_8[var_9] = var_3[var_9];
    }

    foreach(var_11 in var_8) {
      var_11 suicide();
    }

    wait 0.5;
  }

  var_15 = var_0.visuals[0] maps\mp\zombies\killstreaks\_zombie_squadmate::getvalidspawnnodesforsquadmate(var_1);
  var_0.soldiers = [];

  for(var_9 = 0; var_9 < var_1; var_9++) {
    var_16 = var_15[var_9].origin;
    var_17 = vectortoangles(var_0.curorigin - var_15[var_9].origin);
    var_18 = level.area_invalidation_soldier_type;

    if(level.wavecounter >= 20 && var_9 == 0) {
      var_18 = level.area_invalidation_goliath_type;
    }

    var_19 = maps\mp\agents\_agent_common::connectnewagent(var_18, level.enemyteam);
    var_19.bomb_guarding = var_0;
    var_19 maps\mp\agents\_agents::spawn_agent_player(var_16, var_17);
    var_0.soldiers[var_0.soldiers.size] = var_19;
    var_19 thread soldierhandlevo();
    var_20 = int(maps\mp\gametypes\zombies::calculatezombiehealth(level.agentclasses[var_18]));

    if(var_18 == level.area_invalidation_goliath_type) {
      var_20 = int(var_20 * 0.5 * maps\mp\zombies\_util::getnumplayers());
    }

    var_19 maps\mp\agents\_agent_common::set_agent_health(var_20);
    thread playteleportspawnfx(var_16, 3.0);
    wait 0.05;
  }

  if(var_7) {
    maps\mp\zombies\_util::pausezombiespawning(0);
  }
}

playteleportspawnfx(var_0, var_1) {
  playFX(common_scripts\utility::getfx("npc_teleport_enemy"), var_0, (1, 0, 0), (0, 0, 1));
}

soldier_think() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("soldier_think");
  self endon("soldier_think");
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
  childthread maps\mp\zombies\_zombies::monitorbadzombieai();
  childthread disableattacksandmovement();
  thread dropcamoondeath();

  for(;;) {
    if(isDefined(self.bomb_guarding)) {
      if(isDefined(self.player_defuse_time) && gettime() - self.player_defuse_time < 3000) {
        if(maps\mp\bots\_bots_util::bot_is_defending()) {
          maps\mp\bots\_bots_strategy::bot_defend_stop();
        }

        self botsetscriptgoal(self.bomb_guarding.curorigin, 0, "guard");
      } else if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.bomb_guarding.curorigin)) {
        var_0["score_flags"] = "strict_los";
        maps\mp\bots\_bots_strategy::bot_protect_point(self.bomb_guarding.curorigin, 725, var_0);
      }
    } else {
      maps\mp\bots\_bots_strategy::bot_defend_stop();
      childthread maps\mp\zombies\_util::locateenemypositions();
      break;
    }

    wait 0.05;
  }
}

disableattacksandmovement() {
  self botsetflag("disable_attack", 1);
  self botsetflag("disable_movement", 1);
  self botsetflag("disable_rotation", 1);
  wait 3.0;
  self botsetflag("disable_attack", 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
}

dropcamoondeath() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("dropCamoOnDeath");
  self endon("dropCamoOnDeath");
  self waittill("death");
  var_0 = 0;

  if(self.agent_type == "ranged_elite_soldier_goliath_saboteur") {
    var_0 = 1;
  } else if(maps\mp\agents\_agent_utility::getactiveagentsoftype("ranged_elite_soldier_saboteur").size == 1) {
    var_0 = 1;
  } else if(randomfloat(1.0) < 0.25) {
    var_0 = 1;
  }

  if(var_0 && isDefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinenabledzone(self)) {
    var_0 = 0;
  }

  if(var_0) {
    maps\mp\gametypes\zombies::spawnpickupmodel(self.origin + (0, 0, 22), undefined, undefined, "pickup_camo", ::camopickup, ::canactivatecamopickup, 0);
  }
}

canactivatecamopickup(var_0) {
  if(isDefined(var_0) && isagent(var_0)) {
    return 0;
  }

  if(maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
    return 0;
  }

  return 1;
}

camopickup(var_0) {
  var_1 = 8;

  if(maps\mp\zombies\_util::getnumplayers() == 1) {
    var_1 = 10;
  }

  var_0 thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(var_1);
  level thread maps\mp\gametypes\zombies::removepickup(self);
}

infectplayersinzone(var_0) {
  level endon("game_ended");
  level endon("clean" + var_0);
  var_1 = gettime();

  for(;;) {
    foreach(var_3 in level.players) {
      if(!isalive(var_3)) {
        continue;
      }
      if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
        continue;
      }
      if(var_3 isgod()) {
        continue;
      }
      if(maps\mp\zombies\_util::isplayerteleporting(var_3)) {
        continue;
      }
      if(maps\mp\zombies\_util::is_true(var_3.onisland)) {
        continue;
      }
      if(var_3.sessionstate == "spectator" || var_3.sessionstate == "intermission") {
        continue;
      }
      if(!isDefined(var_3.currentzone) || var_3.currentzone != var_0) {
        continue;
      }
      if(maps\mp\zombies\_util::isplayerinfected(var_3)) {
        if(!isDefined(var_3.lastinfectdamagetime)) {
          var_3.lastinfectdamagetime = gettime();
          continue;
        }

        if(gettime() - var_3.lastinfectdamagetime < 2500) {
          continue;
        }
        if(gettime() - var_1 < 10000) {
          continue;
        }
        var_3 dodamage(25, var_3.origin, undefined, undefined, "MOD_TRIGGER_HURT");
        var_3.lastinfectdamagetime = gettime();
        continue;
      } else {
        var_4 = 1000;
        var_5 = 1500;

        if(!isDefined(var_3.lastalmostinfecttime) || gettime() - var_3.lastalmostinfecttime > var_5) {
          var_3.lastalmostinfecttime = gettime();
        }

        if(gettime() - var_3.lastalmostinfecttime < var_4) {
          continue;
        }
      }

      var_3 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
      var_3.lastinfectdamagetime = gettime();
    }

    wait 0.1;
  }
}

contaminate_zone(var_0) {
  if(level.breachzones[var_0].status == 2) {
    return;
  }
  if(isDefined(level.breachzones[var_0].detonatesplashname)) {
    maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[var_0].detonatesplashname);
  }

  var_1 = get_contaminated_zones();
  var_2 = var_1.size + 1;
  level thread maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority", "exp_fail" + var_2, 1.5, undefined, undefined, undefined, undefined, level.players);
  var_3 = get_active_bomb_ent(var_0);

  if(!isDefined(var_3)) {
    var_3 = level.breachzones[var_0].defuseobjs[0];
  }

  var_3 deactivatedefuseobject();
  playsoundatpos(var_3.curorigin, "event_gas_fail");
  earthquake(0.5, 1.0, var_3.curorigin, 10000);
  playFX(common_scripts\utility::getfx("zone_explode"), var_3.curorigin);

  if(isDefined(level.players[0])) {
    level.players[0] thread maps\mp\_matchdata::loggameevent("zm_bomb_explode", var_3.curorigin);
  }

  activatepersistentclientexploder(level.breachzones[var_0].exploderid);
  level thread infectplayersinzone(var_0);
  contaminate_breach_timer(var_0);
  level notify("contaminate" + var_0);
  level.breachzones[var_0].status = 2;

  foreach(var_5 in level.participants) {
    var_5 notify("stop_useHoldThinkLoop");
  }

  var_7 = get_soldiers_breaching_zone(var_0);
  thread try_continue_breach(var_7, var_0);
  var_3.soldiers = [];
}

get_soldiers_breaching_zone(var_0) {
  var_1 = [];

  foreach(var_3 in level.breachzones[var_0].defuseobjs) {
    if(isDefined(var_3.soldiers)) {
      foreach(var_5 in var_3.soldiers) {
        if(isalive(var_5) && (var_5.agent_type == level.area_invalidation_soldier_type || var_5.agent_type == level.area_invalidation_goliath_type)) {
          var_1[var_1.size] = var_5;
        }
      }
    }
  }

  return var_1;
}

find_breach_timer_index(var_0) {
  for(var_1 = 0; var_1 < level.breachtimers.size; var_1++) {
    if(level.breachtimers[var_1].zonename == var_0) {
      return var_1;
    }
  }

  return -1;
}

add_breach_timer(var_0) {
  var_1 = spawnStruct();
  var_1.zonename = var_0;
  var_1.endtime = gettime() + get_breach_time();
  var_1.status = 0;
  level.breachtimers[level.breachtimers.size] = var_1;
  update_breach_timer_omnvars();
  level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_bomb", var_1.endtime);
}

get_breach_time() {
  var_0 = 60000;
  var_1 = 5000;

  if(level.wavecounter >= 30) {
    var_0 = 20000;
    var_1 = 3333;
  } else if(level.wavecounter >= 20) {
    var_0 = 25000;
    var_1 = 3333;
  } else if(level.wavecounter >= 10) {
    var_0 = 45000;
    var_1 = 5000;
  }

  var_2 = 4 - maps\mp\zombies\_util::getnumplayers();
  return var_0 + var_2 * var_1;
}

contaminate_breach_timer(var_0) {
  var_1 = find_breach_timer_index(var_0);

  if(var_1 == -1) {
    var_1 = level.breachtimers.size;
    var_2 = spawnStruct();
    var_2.zonename = var_0;
    var_2.endtime = gettime() + get_breach_time();
    var_2.status = 1;
    level.breachtimers[level.breachtimers.size] = var_2;
  }

  level.breachtimers[var_1].status = 1;
  update_breach_timer_omnvars();
  setomnvar("ui_zm_bomb", 0);
  level notify("ui_zm_bomb_cancel");
}

remove_breach_timer(var_0) {
  var_1 = find_breach_timer_index(var_0);

  if(var_1 == -1) {
    return;
  }
  level.breachtimers = maps\mp\zombies\_util::array_remove_index(level.breachtimers, var_1);
  update_breach_timer_omnvars();
  setomnvar("ui_zm_bomb", 0);
  level notify("ui_zm_bomb_cancel");
}

update_breach_timer_omnvars() {
  var_0 = [0, 0, 0];
  var_1 = 0;
  var_2 = 1;

  for(var_3 = 0; var_3 < level.breachtimers.size; var_3++) {
    var_4 = level.breachtimers[var_3].zonename;
    var_5 = level.breachzones[var_4].omnvarid;
    var_0[var_3] = level.breachtimers[var_3].endtime;
    var_1 = var_1 + var_5 * var_2;
    var_2 = var_2 * 10;

    if(level.breachtimers[var_3].status > 0) {
      var_1 = var_1 + var_2;
    }

    var_2 = var_2 * 10;
  }

  setomnvar("ui_zm_zone_timer_1", var_0[0]);
  setomnvar("ui_zm_zone_timer_2", var_0[1]);
  setomnvar("ui_zm_zone_timer_3", var_0[2]);
  setomnvar("ui_zm_zone_identifier", var_1);
}

do_breach(var_0, var_1) {
  level notify("do_breach");
  level endon("do_breach");
  var_2 = [];
  var_3 = getarraykeys(level.breachzones);

  if(isDefined(var_1)) {
    var_3 = getarraykeys(level.zone_data.zones[var_1].adjacent_zones);
  }

  var_4 = 0;
  var_5 = get_contaminated_zones();

  foreach(var_7 in var_5) {
    if(maps\mp\zombies\_util::is_true(level.breachzones[var_7].hascurestation)) {
      var_4++;
    }
  }

  foreach(var_10 in var_3) {
    if(!isDefined(level.breachzones[var_10])) {
      continue;
    }
    if(level.breachzones[var_10].status != 0) {
      continue;
    }
    if(gettime() - level.breachzones[var_10].lastfixtime < 30000) {
      continue;
    }
    if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_10)) {
      continue;
    }
    if(var_4 > 0 && maps\mp\zombies\_util::is_true(level.breachzones[var_10].hascurestation)) {
      continue;
    }
    var_2[var_2.size] = var_10;
  }

  if(var_2.size > 0) {
    var_12 = var_2[randomint(var_2.size)];
    breach_zone(var_12, var_0);
    return 1;
  } else {
    return 0;
  }
}

get_breach_min_wave() {
  var_0 = 6;

  if(maps\mp\zombies\_util::getnumplayers() <= 1) {
    var_0 = var_0 + 2;
  }

  return var_0;
}

get_breach_max_wave() {
  var_0 = 20;

  if(maps\mp\zombies\_util::getnumplayers() <= 1) {
    var_0 = var_0 + 2;
  }

  return var_0;
}

some_player_has_exo_suit() {
  foreach(var_1 in level.players) {
    if(isalive(var_1) && maps\mp\zombies\_util::is_true(var_1.exosuitonline)) {
      return 1;
    }
  }

  return 0;
}

run_breach_logic() {
  level.prevbreachwave = 0;
  childthread handle_round_end_breach_logic();

  for(;;) {
    level waittill("zombie_wave_started");

    if(level.wavecounter >= get_breach_min_wave()) {
      if(!some_player_has_exo_suit()) {
        if(level.wavecounter < get_breach_min_wave() + 2) {
          continue;
        }
      }

      break;
    }
  }

  var_0 = randomfloatrange(15.0, 30.0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  while(maps\mp\zombies\_util::iszombiegamepaused()) {
    waitframe();
  }

  for(;;) {
    while(!can_do_breach()) {
      wait 60;
    }

    level thread do_breach();
    level.prevbreachwave = level.wavecounter;
    var_1 = undefined;
    var_2 = undefined;

    if(level.wavecounter >= get_breach_max_wave()) {
      var_1 = 270;
      var_2 = 30;
    } else if(level.wavecounter <= get_breach_min_wave()) {
      var_1 = 360;
      var_2 = 60;
    } else {
      var_3 = (level.wavecounter - get_breach_min_wave()) / (get_breach_max_wave() - get_breach_min_wave());
      var_1 = maps\mp\zombies\_util::lerp(var_3, 360, 270);
      var_2 = maps\mp\zombies\_util::lerp(var_3, 60, 30);
    }

    var_4 = randomfloatrange(var_1 - var_2, var_1 + var_2);
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_4);

    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }
  }
}

can_do_breach() {
  if(level.roundtype == "zombie_host") {
    return 0;
  }

  if(maps\mp\agents\_agent_utility::getactiveagentsoftype("zombie_melee_goliath").size > 0) {
    return 0;
  }

  var_0 = get_breached_zones();

  if(var_0.size != 0) {
    return 0;
  }

  var_1 = get_contaminated_zones();

  if(var_1.size >= 3) {
    return 0;
  }

  var_2 = level.totalaispawned / level.totaldesiredai;

  if(var_2 >= 0.8) {
    return 0;
  }

  return 1;
}

handle_round_end_breach_logic() {
  for(;;) {
    level waittill("zombie_wave_ended");
    waittillframeend;
    var_0 = get_contaminated_zones();

    if(var_0.size > 0) {
      var_1 = get_breached_zones();

      if(var_1.size == 0) {
        foreach(var_3 in var_0) {
          clean_zone(var_3);
        }

        if(var_0.size >= 3) {
          maps\mp\gametypes\zombies::showteamsplashzombies("zombie_vent_goliath");
          maps\mp\zombies\zombie_melee_goliath::spawnenhancedgoliath();
          level thread handle_round_transition_vo(1);
        } else {
          maps\mp\gametypes\zombies::showteamsplashzombies("zombie_vent_gas");
          level thread handle_round_transition_vo(0);
        }
      }
    }
  }
}

handle_round_transition_vo(var_0) {
  var_1 = "exp_round";

  if(var_0) {
    var_1 = var_1 + "_gol";
  }

  wait 1.5;
  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority", var_1, undefined, undefined, undefined, undefined, level.players);
  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();

  if(var_0) {
    foreach(var_3 in level.players) {
      var_3 playlocalsound("zmb_gol_round_start_front");
    }

    wait 2;
  }

  level notify("area_invalidation_vo_complete");
}

is_next_round_transition_venting() {
  var_0 = get_breached_zones();
  var_1 = get_contaminated_zones();
  return var_0.size == 0 && var_1.size > 0;
}

is_next_round_zombie_goliath_round() {
  var_0 = get_breached_zones();
  var_1 = get_contaminated_zones();
  return var_0.size == 0 && var_1.size >= 3;
}

get_contaminated_zones() {
  var_0 = [];

  foreach(var_3, var_2 in level.breachzones) {
    if(var_2.status == 2) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

get_breached_zones() {
  var_0 = [];

  foreach(var_3, var_2 in level.breachzones) {
    if(var_2.status == 1) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

zone_is_breached(var_0) {
  return level.breachzones[var_0].status == 1;
}

zone_is_contaminated(var_0) {
  if(!isDefined(level.breachzones) || !isDefined(level.breachzones[var_0])) {
    return 0;
  }

  return level.breachzones[var_0].status == 2;
}

soldierhandlevo() {
  self endon("death");
  wait 1;

  if(!isDefined(level.atlasdebouncevo)) {
    return;
  }
  thread soldierdochatter();
  thread soldierdogoliathvo();
}

soldierdogoliathvo() {
  var_0 = 250000;

  if(!isDefined(self.agent_type) || !issubstr(self.agent_type, "goliath")) {
    return;
  }
  for(;;) {
    foreach(var_2 in level.players) {
      var_3 = distancesquared(self.origin, var_2.origin);

      if(var_3 <= var_0 && soldierplayvo("goliath")) {
        return;
      }
    }

    wait 1;
  }
}

soldierdochatter() {
  self endon("death");
  self endon("fail_gas");
  var_0 = 250000;

  for(;;) {
    foreach(var_2 in level.players) {
      var_3 = distancesquared(self.origin, var_2.origin);

      if(var_3 <= var_0) {
        if(soldierplayvo("chatter")) {
          wait 10;
        }
      }
    }

    wait 1;
  }
}

soldierplayvo(var_0) {
  if(!isDefined(self.zmbvoxid)) {
    self.zmbvoxid = "atlas";
  }

  if(!isDefined(level.atlasdebouncevo)) {
    return 0;
  }

  if(isDefined(level.atlasdebouncevo[var_0]) && level.atlasdebouncevo[var_0] > gettime()) {
    return 0;
  }

  if(maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", var_0)) {
    if(isDefined(level.atlasdebouncevo[var_0])) {
      level.atlasdebouncevo[var_0] = gettime() + 30000;
    }

    return 1;
  }

  return 0;
}

dobreachclearedvo(var_0) {
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority", "exp_win", 2, undefined, undefined, undefined, undefined, level.players);

  if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedatlasconv)) {
    level.zmbaudioplayedatlasconv = 0;
    maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
    wait 0.5;
    var_1 = get_soldiers_breaching_zone(var_0);

    if(var_1.size == 0) {
      var_2 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");

      if(isDefined(var_2)) {
        var_3 = var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "atlas_conv");

        if(var_3) {
          level.zmbaudioplayedatlasconv = 1;
          var_2 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 8);
        }
      }

      var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");

      if(isDefined(var_4)) {
        var_3 = var_4 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "atlas_conv");

        if(var_3) {
          level.zmbaudioplayedatlasconv = 1;
          var_4 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 8);
        }
      }

      var_5 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");

      if(isDefined(var_5)) {
        var_3 = var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "atlas_conv");

        if(var_3) {
          level.zmbaudioplayedatlasconv = 1;
          var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 8);
        }
      }

      var_6 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");

      if(isDefined(var_6)) {
        var_3 = var_6 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "atlas_conv");

        if(var_3) {
          level.zmbaudioplayedatlasconv = 1;
          var_6 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 8);
        }
      }
    }
  }
}