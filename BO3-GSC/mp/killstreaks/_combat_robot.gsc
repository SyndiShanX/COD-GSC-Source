/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_combat_robot.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_puppeteer_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\entityheadicons_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\objpoints_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicleriders_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#namespace combat_robot;

function init() {
  killstreaks::register("combat_robot", "combat_robot_marker", "killstreak_" + "combat_robot", "combat_robot" + "_used", & activatecombatrobot, undefined, 1);
  killstreaks::register_alt_weapon("combat_robot", "lmg_light_robot");
  killstreaks::register_strings("combat_robot", & "KILLSTREAK_COMBAT_ROBOT_EARNED", & "KILLSTREAK_COMBAT_ROBOT_NOT_AVAILABLE", & "KILLSTREAK_COMBAT_ROBOT_INBOUND", undefined, & "KILLSTREAK_COMBAT_ROBOT_HACKED");
  killstreaks::register_dialog("combat_robot", "mpl_killstreak_combat_robot", "combatRobotDialogBundle", "combatRobotPilotDialogBundle", "friendlyCombatRobot", "enemyCombatRobot", "enemyCombatRobotMultiple", "friendlyCombatRobotHacked", "enemyCombatRobotHacked", "requestCombatRobot", "threatCombatRobot");
  level.killstreaks["inventory_combat_robot"].threatonkill = 1;
  level.killstreaks["combat_robot"].threatonkill = 1;
  level thread _cleanuprobotcorpses();
}

function private _calculateprojectedguardposition(player) {
  return getclosestpointonnavmesh(player.origin, 48);
}

function private _calculaterobotspawnposition(player) {
  desiredspawnposition = (anglestoforward(player.angles) * 72) + player.origin;
  return getclosestpointonnavmesh(desiredspawnposition, 48);
}

function private _cleanuprobotcorpses() {
  corpsedeletetime = 15000;
  while (true) {
    deletecorpses = [];
    foreach(corpse in getcorpsearray()) {
      if(isdefined(corpse.birthtime) && isdefined(corpse.archetype) && corpse.archetype == "robot" && (corpse.birthtime + corpsedeletetime) < gettime()) {
        deletecorpses[deletecorpses.size] = corpse;
      }
    }
    for (index = 0; index < deletecorpses.size; index++) {
      deletecorpses[index] delete();
    }
    wait((corpsedeletetime / 1000) / 2);
  }
}

function configureteampost(player, ishacked) {
  robot = self;
  robot.propername = "";
  robot.ignoretriggerdamage = 1;
  robot.empshutdowntime = 750;
  robot.minwalkdistance = 60;
  robot.supersprintdistance = 180;
  robot.robotrusherminradius = 64;
  robot.robotrushermaxradius = 120;
  robot.allowpushactors = 0;
  robot.chargemeleedistance = 0;
  robot.fovcosine = 0;
  robot.fovcosinebusy = 0;
  robot.maxsightdistsqrd = 2000 * 2000;
  blackboard::setblackboardattribute(robot, "_robot_mode", "combat");
  robot.gib_state = 0 | (8 & (512 - 1));
  robot clientfield::set("gib_state", robot.gib_state);
  _configurerobotteam(robot, player, ishacked);
  robot ai::set_behavior_attribute("can_become_crawler", 0);
  robot ai::set_behavior_attribute("can_be_meleed", 0);
  robot ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
  robot ai::set_behavior_attribute("supports_super_sprint", 1);
}

function private _configurerobotteam(robot, player, ishacked) {
  if(ishacked) {
    lightsstate = 3;
  } else {
    lightsstate = 0;
  }
  robot ai::set_behavior_attribute("robot_lights", lightsstate);
  robot thread watchcombatrobotownerdisconnect(player);
  if(!isdefined(robot.objective)) {
    robot.objective = getequipmentheadobjective(getweapon("combat_robot_marker"));
  }
  robot thread _watchmodeswap(robot, player);
  robot thread _underwater(robot);
}

function private _createguardmarker(robot, position) {
  owner = robot.owner;
  guardmarker = spawn("script_model", (0, 0, 0));
  guardmarker.origin = position;
  guardmarker entityheadicons::setentityheadicon(owner.pers["team"], owner, undefined, & "airdrop_combatrobot");
  return guardmarker;
}

function private _destroyguardmarker(robot) {
  if(isdefined(robot.guardmarker)) {
    robot.guardmarker delete();
  }
}

function private _underwater(robot) {
  robot endon("death");
  while (true) {
    if((robot.origin[2] + 36) <= getwaterheight(robot.origin)) {
      robot asmsetanimationrate(0.85);
    } else {
      robot asmsetanimationrate(1);
    }
    wait(0.1);
  }
}

function private _escort(robot) {
  robot endon("death");
  robot.escorting = 1;
  robot.guarding = 0;
  _destroyguardmarker(robot);
  while (robot.escorting) {
    attackingenemy = 0;
    if(isdefined(robot.enemy) && isalive(robot.enemy)) {
      if((robot lastknowntime(robot.enemy) + 10000) >= gettime()) {
        robot ai::set_behavior_attribute("move_mode", "rusher");
        attackingenemy = 1;
      } else {
        robot clearenemy();
      }
    }
    if(!attackingenemy && isdefined(robot.owner) && isalive(robot.owner)) {
      lookaheadtime = 1;
      predicitedposition = robot.owner.origin + vectorscale(robot.owner getvelocity(), lookaheadtime);
      robot ai::set_behavior_attribute("escort_position", predicitedposition);
      robot ai::set_behavior_attribute("move_mode", "escort");
    }
    wait(1);
  }
}

function private _ignoreunattackableenemy(robot, enemy) {
  robot endon("death");
  robot setignoreent(enemy, 1);
  wait(5);
  robot setignoreent(enemy, 0);
}

function private _guardposition(robot, position) {
  robot endon("death");
  robot.goalradius = 1000;
  robot setgoal(position);
  robot.escorting = 0;
  robot.guarding = 1;
  _destroyguardmarker(robot);
  robot.guardmarker = _createguardmarker(robot, position);
  while (robot.guarding) {
    attackingenemy = 0;
    if(isdefined(robot.enemy) && isalive(robot.enemy)) {
      if((robot lastknowntime(robot.enemy) + 10000) >= gettime()) {
        robot ai::set_behavior_attribute("move_mode", "rusher");
        attackingenemy = 1;
      } else {
        robot clearenemy();
      }
    }
    if(!attackingenemy) {
      robot ai::set_behavior_attribute("move_mode", "guard");
    }
    wait(1);
  }
}

function _watchmodeswap(robot, player) {
  robot endon("death");
  nextswitchtime = gettime();
  while (true) {
    wait(0.05);
    if(!isdefined(robot.usetrigger)) {
      continue;
    }
    robot.usetrigger waittill("trigger");
    if(nextswitchtime <= gettime() && isalive(player)) {
      if(isdefined(robot.guarding) && robot.guarding) {
        robot.guarding = 0;
        robot.escorting = 1;
        player playsoundtoplayer("uin_mp_combat_bot_escort", player);
        robot thread _escort(robot);
        if(isdefined(robot.usetrigger)) {
          robot.usetrigger sethintstring(&"KILLSTREAK_COMBAT_ROBOT_GUARD_HINT");
        }
        if(isdefined(robot.markerfxhandle)) {
          robot.markerfxhandle delete();
        }
      } else {
        navguardposition = _calculateprojectedguardposition(player);
        if(isdefined(navguardposition)) {
          robot.guarding = 1;
          robot.escorting = 0;
          player playsoundtoplayer("uin_mp_combat_bot_guard", player);
          robot thread _guardposition(robot, navguardposition);
          if(isdefined(robot.usetrigger)) {
            robot.usetrigger sethintstring(&"KILLSTREAK_COMBAT_ROBOT_ESCORT_HINT");
          }
          if(isdefined(robot.markerfxhandle)) {
            robot.markerfxhandle delete();
          }
          params = level.killstreakbundle["combat_robot"];
          if(isdefined(params.kscombatrobotpatrolfx)) {
            point = player.origin;
            if(!isdefined(point)) {
              point = navguardposition;
            }
            robot.markerfxhandle = spawnfx(params.kscombatrobotpatrolfx, point + vectorscale((0, 0, 1), 3), (0, 0, 1), (1, 0, 0));
            robot.markerfxhandle.team = player.team;
            triggerfx(robot.markerfxhandle);
            robot.markerfxhandle setinvisibletoall();
            robot.markerfxhandle setvisibletoplayer(player);
          }
        } else {
          player iprintlnbold(&"KILLSTREAK_COMBAT_ROBOT_PATROL_FAIL");
        }
      }
      robot notify("bhtn_action_notify", "modeSwap");
      nextswitchtime = gettime() + 1000;
    }
  }
}

function activatecombatrobot(killstreak) {
  player = self;
  team = self.team;
  if(!self supplydrop::issupplydropgrenadeallowed(killstreak)) {
    return 0;
  }
  killstreak_id = self killstreakrules::killstreakstart(killstreak, team, 0, 0);
  if(killstreak_id == -1) {
    return 0;
  }
  context = spawnstruct();
  context.prolog = & prolog;
  context.epilog = & epilog;
  context.hasflares = 1;
  context.radius = level.killstreakcorebundle.ksairdroprobotradius;
  context.dist_from_boundary = 18;
  context.max_dist_from_location = 4;
  context.perform_physics_trace = 1;
  context.drop_from_goal_distance2d = 96;
  context.islocationgood = & supplydrop::islocationgood;
  context.objective = & "airdrop_combatrobot";
  context.killstreakref = killstreak;
  context.validlocationsound = level.killstreakcorebundle.ksvalidcombatrobotlocationsound;
  context.vehiclename = "combat_robot_dropship";
  context.killstreak_id = killstreak_id;
  context.tracemask = 1 | 4;
  context.dropoffset = vectorscale((0, -1, 0), 120);
  result = self supplydrop::usesupplydropmarker(killstreak_id, context);
  if(!isdefined(result) || !result) {
    killstreakrules::killstreakstop(killstreak, team, killstreak_id);
    return 0;
  }
  self killstreaks::play_killstreak_start_dialog("combat_robot", self.team, killstreak_id);
  self killstreakrules::displaykillstreakstartteammessagetoall("combat_robot");
  self addweaponstat(getweapon("combat_robot_marker"), "used", 1);
  return result;
}

function dropkillthread() {
  robot = self;
  robot endon("death");
  robot endon("combat_robot_land");
  while (true) {
    robot supplydrop::is_touching_crate();
    robot supplydrop::is_clone_touching_crate();
    wait(0.05);
  }
}

function watchhelicopterdeath(context) {
  helicopter = self;
  helicopter waittill("death");
  callback::callback("hash_acb66515");
  if(isdefined(context.marker)) {
    context.marker delete();
    context.marker = undefined;
    if(isdefined(context.markerfxhandle)) {
      context.markerfxhandle delete();
      context.markerfxhandle = undefined;
    }
    supplydrop::deldroplocation(context.killstreak_id);
  }
}

function prolog(context) {
  helicopter = self;
  player = helicopter.owner;
  spawnposition = (0, 0, 0);
  spawnangles = (0, 0, 0);
  combatrobot = spawnactor("spawner_bo3_robot_grunt_assault_mp", spawnposition, spawnangles, "", 1);
  combatrobot.missiletrackdamage = 0;
  combatrobot killstreaks::configure_team("combat_robot", context.killstreak_id, player, "small_vehicle", undefined, & configureteampost);
  combatrobot killstreak_hacking::enable_hacking("combat_robot", undefined, & hackedcallbackpost);
  combatrobot thread _escort(combatrobot);
  combatrobot thread watchcombatrobothelicopterhacked(helicopter);
  combatrobot thread watchcombatrobotshutdown();
  combatrobot thread watchcombatrobotdeath();
  combatrobot thread killstreaks::waitfortimeout("combat_robot", 90000, & oncombatrobottimeout, "combat_robot_shutdown");
  combatrobot thread sndwatchcombatrobotvoxnotifies();
  helicopter thread watchhelicopterdeath(context);
  helicopter.unloadtimeout = 6;
  killstreak_detect::killstreaktargetset(combatrobot, vectorscale((0, 0, 1), 50));
  combatrobot.maxhealth = combatrobot.health;
  tablehealth = killstreak_bundles::get_max_health("combat_robot");
  if(isdefined(tablehealth)) {
    combatrobot.maxhealth = tablehealth;
  }
  combatrobot.health = combatrobot.maxhealth;
  combatrobot.treat_owner_damage_as_friendly_fire = 1;
  combatrobot.ignore_team_kills = 1;
  combatrobot.remotemissiledamage = combatrobot.maxhealth + 1;
  combatrobot.rocketdamage = (combatrobot.maxhealth / 2) + 1;
  combatrobot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
  combatrobot clientfield::set("enemyvehicle", 1);
  combatrobot.soundmod = "drone_land";
  aiutility::addaioverridedamagecallback(combatrobot, & combatrobotdamageoverride);
  combatrobot.vehicle = helicopter;
  combatrobot.vehicle.ignore_seat_check = 1;
  combatrobot vehicle::get_in(helicopter, "driver", 1);
  combatrobot.overridedropposition = player.markerposition;
  combatrobot thread watchcombatrobotlanding();
  combatrobot thread sndwatchexit();
  combatrobot thread sndwatchlanding();
  combatrobot thread sndwatchactivate();
  foreach(player in level.players) {
    combatrobot respectnottargetedbyrobotperk(player);
  }
  callback::on_spawned( & respectnottargetedbyrobotperk, combatrobot);
  context.robot = combatrobot;
}

function respectnottargetedbyrobotperk(player) {
  combatrobot = self;
  combatrobot setignoreent(player, player hasperk("specialty_nottargetedbyrobot"));
}

function epilog(context) {
  helicopter = self;
  context.robot thread dropkillthread();
  context.robot.starttime = gettime() + 750;
  thread cleanupthread(context);
  debug_delay_robot_deploy();
  helicopter waitthensetdeleteafterdestructionwaittime(0.8, (isdefined(self.unloadtimeout) ? self.unloadtimeout : 0) + 0.1);
  helicopter vehicle::unload("all", undefined, 1, 0.8);
}

function debug_delay_robot_deploy() {
  seconds_to_wait = getdvarint("", 0);
  while (seconds_to_wait > 0) {
    iprintlnbold("" + seconds_to_wait);
    wait(1);
    seconds_to_wait--;
    if(seconds_to_wait == 0) {
      iprintlnbold("");
    }
  }
}

function waitthensetdeleteafterdestructionwaittime(set_wait_time, delete_after_destruction_wait_time) {
  wait(set_wait_time);
  if(isdefined(self)) {
    self.delete_after_destruction_wait_time = delete_after_destruction_wait_time;
  }
}

function hackedcallbackpost(hacker) {
  robot = self;
  robot clearenemy();
  robot setupcombatrobothinttrigger(hacker);
}

function watchcombatrobothelicopterhacked(helicopter) {
  robot = self;
  robot endon("death");
  robot endon("killstreak_hacked");
  robot endon("combat_robot_land");
  helicopter endon("death");
  helicopter waittill("killstreak_hacked", hacker);
  if(robot flagsys::get("in_vehicle") == 0) {
    return;
  }
  robot[[robot.killstreak_hackedcallback]](hacker);
}

function cleanupthread(context) {
  robot = context.robot;
  while (isdefined(robot) && isdefined(context.marker) && robot flagsys::get("in_vehicle")) {
    wait(1);
  }
  if(isdefined(context.marker)) {
    context.marker delete();
    context.marker = undefined;
    if(isdefined(context.markerfxhandle)) {
      context.markerfxhandle delete();
      context.markerfxhandle = undefined;
    }
    supplydrop::deldroplocation(context.killstreak_id);
  }
}

function watchcombatrobotdeath() {
  combatrobot = self;
  combatrobot endon("combat_robot_shutdown");
  callback::remove_on_spawned( & respectnottargetedbyrobotperk, combatrobot);
  combatrobot waittill("death", attacker, damagefromunderneath, weapon);
  attacker = self[[level.figure_out_attacker]](attacker);
  if(isdefined(attacker) && isplayer(attacker) && (!isdefined(combatrobot.owner) || combatrobot.owner util::isenemyplayer(attacker))) {
    attacker challenges::destroyscorestreak(weapon, 0, 1);
    attacker challenges::destroynonairscorestreak_poststatslock(weapon);
    scoreevents::processscoreevent("destroyed_combat_robot", attacker, combatrobot.owner, weapon);
    luinotifyevent(&"player_callout", 2, & "KILLSTREAK_DESTROYED_COMBAT_ROBOT", attacker.entnum);
  }
  combatrobot killstreaks::play_destroyed_dialog_on_owner("combat_robot", combatrobot.killstreak_id);
  combatrobot notify("combat_robot_shutdown");
}

function watchcombatrobotlanding() {
  robot = self;
  robot endon("death");
  robot endon("combat_robot_shutdown");
  while (robot flagsys::get("in_vehicle")) {
    wait(1);
  }
  robot notify("combat_robot_land");
  robot.ignoretriggerdamage = 0;
  while (isdefined(robot.traversestartnode)) {
    robot waittill("traverse_end");
  }
  v_on_navmesh = getclosestpointonnavmesh(robot.origin, 50, 20);
  if(isdefined(v_on_navmesh)) {
    player = robot.owner;
    robot setupcombatrobothinttrigger(player);
  } else {
    robot notify("combat_robot_shutdown");
  }
}

function setupcombatrobothinttrigger(player) {
  robot = self;
  if(isdefined(robot.usetrigger)) {
    robot.usetrigger delete();
  }
  robot.usetrigger = spawn("trigger_radius_use", player.origin, 32, 32);
  robot.usetrigger enablelinkto();
  robot.usetrigger linkto(player);
  robot.usetrigger sethintlowpriority(1);
  robot.usetrigger setcursorhint("HINT_NOICON");
  robot.usetrigger sethintstring(&"KILLSTREAK_COMBAT_ROBOT_GUARD_HINT");
  robot.usetrigger setteamfortrigger(player.team);
  robot.usetrigger.team = player.team;
  player clientclaimtrigger(robot.usetrigger);
  player.remotecontroltrigger = robot.usetrigger;
  robot.usetrigger.claimedby = player;
}

function watchcombatrobotownerdisconnect(player) {
  combatrobot = self;
  combatrobot notify("watchcombatrobotownerdisconnect_singleton");
  combatrobot endon("watchcombatrobotownerdisconnect_singleton");
  combatrobot endon("combat_robot_shutdown");
  player util::waittill_any("joined_team", "disconnect", "joined_spectators");
  combatrobot notify("combat_robot_shutdown");
}

function private _corpsewatcher() {
  archetype = self.archetype;
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("arch_actor_fire_fx", 3);
}

function private _exploderobot(combatrobot) {
  combatrobot clientfield::set("arch_actor_fire_fx", 1);
  clientfield::set("robot_mind_control_explosion", 1);
  combatrobot thread _corpsewatcher();
  if(randomint(100) >= 50) {
    gibserverutils::gibleftarm(combatrobot);
  } else {
    gibserverutils::gibrightarm(combatrobot);
  }
  gibserverutils::giblegs(combatrobot);
  gibserverutils::gibhead(combatrobot);
  velocity = combatrobot getvelocity() * 0.125;
  combatrobot startragdoll();
  combatrobot launchragdoll((velocity[0] + (randomfloatrange(-20, 20)), velocity[1] + (randomfloatrange(-20, 20)), randomfloatrange(60, 80)), "j_mainroot");
}

function oncombatrobottimeout() {
  combatrobot = self;
  combatrobot killstreaks::play_pilot_dialog_on_owner("timeout", "combat_robot");
  combatrobot ai::set_behavior_attribute("shutdown", 1);
  wait(randomfloatrange(3, 4.5));
  _exploderobot(combatrobot);
  params = level.killstreakbundle["combat_robot"];
  if(isdefined(params.ksexplosionfx)) {
    playfxontag(params.ksexplosionfx, combatrobot, "tag_origin");
  }
  target_remove(combatrobot);
  if(!isdefined(params.ksexplosionouterradius)) {
    params.ksexplosionouterradius = 200;
  }
  if(!isdefined(params.ksexplosioninnerradius)) {
    params.ksexplosioninnerradius = 1;
  }
  if(!isdefined(params.ksexplosionouterdamage)) {
    params.ksexplosionouterdamage = 25;
  }
  if(!isdefined(params.ksexplosioninnerdamage)) {
    params.ksexplosioninnerdamage = 350;
  }
  if(!isdefined(params.ksexplosionmagnitude)) {
    params.ksexplosionmagnitude = 1;
  }
  physicsexplosionsphere(combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerradius, params.ksexplosionmagnitude, params.ksexplosionouterdamage, params.ksexplosioninnerdamage);
  if(isdefined(combatrobot.owner)) {
    radiusdamage(combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, combatrobot.owner, "MOD_EXPLOSIVE", getweapon("combat_robot_marker"));
    if(isdefined(params.ksexplosionrumble)) {
      combatrobot.owner playrumbleonentity(params.ksexplosionrumble);
    }
  }
  wait(0.2);
  combatrobot notify("combat_robot_shutdown");
}

function watchcombatrobotshutdown() {
  combatrobot = self;
  combatrobotteam = combatrobot.originalteam;
  combatrobotkillstreakid = combatrobot.killstreak_id;
  combatrobot waittill("combat_robot_shutdown");
  combatrobot playsound("evt_combat_bot_mech_fail_explode");
  if(isdefined(combatrobot.usetrigger)) {
    combatrobot.usetrigger delete();
  }
  if(isdefined(combatrobot.markerfxhandle)) {
    combatrobot.markerfxhandle delete();
  }
  _destroyguardmarker(combatrobot);
  killstreakrules::killstreakstop("combat_robot", combatrobotteam, combatrobotkillstreakid);
  if(isdefined(combatrobot)) {
    if(target_istarget(combatrobot)) {
      target_remove(combatrobot);
    }
    if(!level.gameended) {
      if(combatrobot flagsys::get("in_vehicle")) {
        combatrobot unlink();
      }
      combatrobot kill();
    }
  }
}

function sndwatchcombatrobotvoxnotifies() {
  combatrobot = self;
  combatrobot endon("combat_robot_shutdown");
  combatrobot endon("death");
  combatrobot playsoundontag("vox_robot_chatter", "j_head");
  while (true) {
    soundalias = undefined;
    combatrobot waittill("bhtn_action_notify", notify_string);
    switch (notify_string) {
      case "attack_kill":
      case "attack_melee":
      case "charge":
      case "modeSwap": {
        soundalias = "vox_robot_chatter";
        break;
      }
    }
    if(isdefined(soundalias)) {
      combatrobot playsoundontag(soundalias, "j_head");
      wait(1.2);
    }
  }
}

function sndwatchexit() {
  combatrobot = self;
  combatrobot endon("combat_robot_shutdown");
  combatrobot endon("death");
  combatrobot waittill("exiting_vehicle");
  combatrobot playsound("veh_vtol_supply_robot_launch");
}

function sndwatchlanding() {
  combatrobot = self;
  combatrobot endon("combat_robot_shutdown");
  combatrobot endon("death");
  combatrobot waittill("falling", falltime);
  wait_time = falltime - 0.5;
  if(wait_time > 0) {
    wait(wait_time);
  }
  combatrobot playsound("veh_vtol_supply_robot_land");
}

function sndwatchactivate() {
  combatrobot = self;
  combatrobot endon("combat_robot_shutdown");
  combatrobot endon("death");
  combatrobot waittill("landing");
  wait(0.1);
  combatrobot playsound("veh_vtol_supply_robot_activate");
}

function combatrobotdamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  combatrobot = self;
  if(combatrobot flagsys::get("in_vehicle") && smeansofdeath == "MOD_TRIGGER_HURT") {
    idamage = 0;
  } else {
    idamage = killstreaks::ondamageperweapon("combat_robot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  }
  combatrobot.missiletrackdamage = combatrobot.missiletrackdamage + idamage;
  if(idamage > 0 && isdefined(eattacker)) {
    if(isplayer(eattacker)) {
      if(isdefined(combatrobot.owner)) {
        challenges::combat_robot_damage(eattacker, combatrobot.owner);
      }
    }
  }
  return idamage;
}