/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\straferun.gsc
***********************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\targetting_delay;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\util;
#include scripts\weapons\heatseekingmissile;

#namespace straferun;

autoexec __init__system__() {
  system::register(#"straferun", &__init__, undefined, #"killstreaks");
}

__init__() {
  level.straferunnumrockets = 8;
  level.straferunrocketdelay = 0.35;
  level.straferungunlookahead = 4000;
  level.straferungunoffset = -800;
  level.straferungunradius = 500;
  level.straferunexitunits = 20000;
  level.straferunmaxstrafes = 6;
  level.straferunflaredelay = 2;
  level.straferunshellshockduration = 2.5;
  level.straferunshellshockradius = 512;
  level.straferunkillsbeforeexit = 10;
  level.straferunnumkillcams = 5;
  level.straferunmodel = "veh_t6_air_a10f";
  level.straferunmodelenemy = "veh_t6_air_a10f_alt";
  level.straferunvehicle = "vehicle_straferun_mp";
  level.straferungunweapon = getweapon(#"straferun_gun");
  level.straferungunsound = "wpn_a10_shot_loop_npc";
  level.straferunrocketweapon = getweapon(#"straferun_rockets");
  level.straferunrockettags = [];
  level.straferunrockettags[0] = "tag_attach_hardpoint_1";
  level.straferunrockettags[1] = "tag_attach_hardpoint_9";
  level.straferunrockettags[2] = "tag_attach_hardpoint_2";
  level.straferunrockettags[3] = "tag_attach_hardpoint_8";
  level.straferuncontrailfx = "_t7/killstreaks/fx_wh_contrail";
  level.var_346e1cce = "killstreaks/fx_wh_chaff_trail";
  level.straferunexplodefx = "destruct/fx8_atk_chppr_exp";
  level.straferunexplodesound = "evt_helicopter_midair_exp";
  level.straferunshellshock = "straferun";
  killstreaks::register_killstreak("killstreak_straferun", &usekillstreakstraferun);
  killstreaks::register_alt_weapon("straferun", level.straferungunweapon);
  killstreaks::register_alt_weapon("straferun", level.straferunrocketweapon);
  createkillcams(level.straferunnumkillcams, level.straferunnumrockets);
  callback::on_finalize_initialization(&function_3675de8b);
  killcam::function_2f7579f(#"straferun_gun");
}

function_3675de8b() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("straferun"), &function_bff5c062);
  }
}

function_bff5c062(var_c4b91241, attackingplayer) {
  var_c4b91241 killstreaks::function_73566ec7(attackingplayer, getweapon(#"gadget_icepick"), var_c4b91241.owner);
  var_c4b91241 thread explode();
}

usekillstreakstraferun(hardpointtype) {
  startnode = getvehiclenode("warthog_start", "targetname");

  if(!isDefined(startnode)) {
    println("<dev string:x38>");
    return false;
  }

  killstreak_id = self killstreakrules::killstreakstart("straferun", self.team, 0, 1);

  if(killstreak_id == -1) {
    return false;
  }

  plane = spawnvehicle(level.straferunvehicle, startnode.origin, (0, 0, 0), "straferun");
  plane.attackers = [];
  plane.attackerdata = [];
  plane.attackerdamage = [];
  plane.flareattackerdamage = [];
  plane killstreaks::configure_team("straferun", killstreak_id, self);
  plane setenemymodel(level.straferunmodelenemy);
  plane makevehicleunusable();
  plane thread cleanupondeath(plane.team);
  plane.health = 999999;
  plane.maxhealth = 999999;
  plane clientfield::set("enemyvehicle", 1);
  plane.targetname = "strafePlane";
  plane.identifier_weapon = getweapon("straferun");
  plane.numstrafes = 0;
  plane.numflares = 1;
  plane.soundmod = "straferun";
  plane setdrawinfrared(1);
  self.straferunkills = 0;
  self.straferunbda = 0;
  self killstreaks::play_killstreak_start_dialog("straferun", self.pers[#"team"], killstreak_id);
  self stats::function_e24eec31(getweapon(#"straferun"), #"used", 1);
  plane thread function_d4896942();
  target_set(plane, (0, 0, 0));
  plane.gunsoundentity = spawn("script_model", plane gettagorigin("tag_flash"));
  plane.gunsoundentity linkto(plane, "tag_flash", (0, 0, 0), (0, 0, 0));

  if(!issentient(plane)) {
    plane util::make_sentient();
    plane.ignoreme = 1;
  }

  plane.killcament = spawn("script_model", plane.origin + (0, 0, 700));
  plane.killcament setfovforkillcam(25);
  plane.killcament.angles = (15, 0, 0);
  plane.killcament.starttime = gettime();
  offset_x = getdvarint(#"hash_6354a081bacd5b72", -2500);
  offset_y = getdvarint(#"hash_6354a181bacd5d25", 0);
  offset_z = getdvarint(#"hash_63549e81bacd580c", -150);
  offset_pitch = getdvarint(#"hash_53fdb5b01cf6f7dc", 2);
  plane.killcament linkto(plane, "tag_origin", (offset_x, offset_y, offset_z), (offset_pitch, 0, 0));
  plane.killcament setweapon(level.straferungunweapon);
  plane resetkillcams();
  plane thread watchforotherkillstreaks();
  plane thread watchforkills();
  plane thread watchdamage();
  plane thread dostraferuns();
  plane thread vehicle::get_on_and_go_path(startnode);
  plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
  plane thread watchforownerexit(self);
  plane thread targetting_delay::function_7e1a12ce(12000);
  plane thread function_c24cc26a();
  util::function_5a68c330(21, self.team, self getentitynumber(), level.killstreaks[#"straferun"].uiname);
  aiutility::addaioverridedamagecallback(plane, &function_16abaea4);
  return true;
}

function_16abaea4(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  chargelevel = 0;
  weapon_damage = killstreak_bundles::get_weapon_damage("straferun", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
  }

  return weapon_damage;
}

function_c24cc26a() {
  self endon(#"death");
  level endon(#"game_ended");

  if(isDefined(level.var_ac6052e9)) {
    var_2974acb8 = [[level.var_ac6052e9]]("taacomPilotWarnDistanceWarthog", 5000);
  } else {
    var_2974acb8 = 1;
  }

  var_13d70215 = var_2974acb8 * var_2974acb8;

  while(true) {
    wait 0.1;

    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.currentnode)) {
      continue;
    }

    if(isDefined(self.var_90110858) ? self.var_90110858 : 0) {
      continue;
    }

    var_19d3cc8e = 0;
    currentnode = getvehiclenode(self.currentnode.target, "targetname");

    if(!isDefined(currentnode)) {
      return;
    }

    var_661ad37a = distancesquared(currentnode.origin, self.origin);
    var_4c8f226e = 0;

    while(true) {
      if(!isDefined(currentnode.target)) {
        continue;
      }

      if(var_661ad37a > var_13d70215) {
        var_4c8f226e = 1;
        break;
      }

      nextnode = getvehiclenode(currentnode.target, "targetname");

      if(!isDefined(nextnode)) {
        continue;
      }

      if(isDefined(nextnode.script_noteworthy) && nextnode.script_noteworthy == "strafe_start") {
        break;
      }

      var_50eb39dc = distancesquared(currentnode.origin, nextnode.origin);
      var_661ad37a += var_50eb39dc;
      currentnode = nextnode;
    }

    if(var_4c8f226e) {
      continue;
    }

    if(!(isDefined(self.leavenexttime) && self.leavenexttime)) {
      if(self.numstrafes == 0) {
        self killstreaks::play_pilot_dialog_on_owner("arrive", "straferun", self.killstreak_id);
      } else if(self.numstrafes == level.straferunmaxstrafes - 1) {
        self killstreaks::play_pilot_dialog_on_owner("waveStartFinal", "straferun", self.killstreakid);
      } else {
        self killstreaks::play_pilot_dialog_on_owner("waveStart", "straferun", self.killstreakid);
      }
    }

    self.var_90110858 = 1;
  }
}

playcontrail() {
  self endon(#"death");
  wait 0.1;
  playFXOnTag(level.straferuncontrailfx, self, "tag_origin");
  self playLoopSound(#"veh_a10_engine_loop", 1);
}

cleanupondeath(team) {
  self waittill(#"death");
  killstreakrules::killstreakstop("straferun", team, self.killstreakid);

  if(isDefined(self.gunsoundentity)) {
    self.gunsoundentity stoploopsound();
    self.gunsoundentity delete();
    self.gunsoundentity = undefined;
  }
}

watchdamage() {
  self endon(#"death");
  self.maxhealth = 999999;
  self.health = self.maxhealth;
  self.maxhealth = 5400;
  low_health = 0;
  damage_taken = 0;

  for(;;) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    mod = waitresult.mod;
    damage = waitresult.amount;
    weapon = waitresult.weapon;

    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }

    self.damage_debug = damage + "<dev string:x66>" + weapon.name + "<dev string:x6b>";

      if(!isDefined(weapon) || weapons::getbaseweapon(weapon) != level.weaponflechette) {
        if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
          damage += 5400;
        }
      }

    if(!issentient(self) && damage > 0) {
      self.attacker = attacker;
    }

    damage_taken += damage;

    if(damage_taken >= 5400) {
      self thread explode();

      if(self.owner util::isenemyplayer(attacker)) {
        attacker battlechatter::function_dd6a6012("straferun", weapon);
        self killstreaks::play_destroyed_dialog_on_owner("straferun", self.killstreak_id);
        self killstreaks::function_73566ec7(attacker, weapon, self.owner);
        challenges::destroyedaircraft(attacker, weapon, 0, 1);
        attacker challenges::addflyswatterstat(weapon, self);
      }

      return;
    }
  }
}

watchforotherkillstreaks() {
  self endon(#"death");

  for(;;) {
    waitresult = level waittill(#"killstreak_started");
    hardpointtype = waitresult.hardpoint_type;
    teamname = waitresult.team;
    attacker = waitresult.attacker;

    if(!isDefined(self.owner)) {
      self thread explode();
      return;
    }

    if(hardpointtype == "emp") {
      if(self.owner util::isenemyplayer(attacker)) {
        self thread explode();
        attacker challenges::addflyswatterstat(hardpointtype, self);
        return;
      }

      continue;
    }

    if(hardpointtype == "missile_swarm") {
      if(self.owner util::isenemyplayer(attacker)) {
        self.leavenexttime = 1;
      }
    }
  }
}

watchforkills() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"killed");

    if(isplayer(waitresult.victim)) {}
  }
}

watchforownerexit(owner) {
  self endon(#"death");
  owner waittill(#"disconnect", #"joined_team", #"joined_spectators");
  self.leavenexttime = 1;
}

addstraferunkill() {
  if(!isDefined(self.straferunkills)) {
    self.straferunkills = 0;
  }

  self.straferunkills++;
}

dostraferuns() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"noteworthy");
    noteworthy = waitresult.noteworthy;
    noteworthynode = waitresult.noteworthy_node;

    if(noteworthy == "strafe_start") {
      self.straferungunlookahead = level.straferungunlookahead;
      self.straferungunradius = level.straferungunradius;
      self.straferungunoffset = level.straferungunoffset;
      self.var_90110858 = 0;

      self.straferungunlookahead = getdvarint(#"scr_straferunlookahead", level.straferungunlookahead);
      self.straferungunradius = getdvarint(#"scr_straferunradius", level.straferungunradius);
      self.straferungunoffset = getdvarint(#"scr_straferunoffset", level.straferungunoffset);

        if(isDefined(noteworthynode)) {
          if(isDefined(noteworthynode.script_parameters)) {
            self.straferungunlookahead = float(noteworthynode.script_parameters);
          }

          if(isDefined(noteworthynode.script_radius)) {
            self.straferungunradius = float(noteworthynode.script_radius);
          }

          if(isDefined(noteworthynode.script_float)) {
            self.straferungunoffset = float(noteworthynode.script_float);
          }
        }

      if(isDefined(self.owner)) {
        self thread startstrafe();
      }

      continue;
    }

    if(noteworthy == "strafe_stop") {
      self stopstrafe();
      continue;
    }

    if(noteworthy == "strafe_leave") {
      if(self shouldleavemap()) {
        if(!(isDefined(self.leavenexttime) && self.leavenexttime)) {
          self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", "straferun", self.killstreakid);
        }

        self thread leavemap();
      }
    }
  }
}

function_d4896942() {
  self endon(#"death", #"strafe_stop");

  while(true) {
    self waittill(#"flare_deployed");

    if(!(isDefined(self.leavenexttime) && self.leavenexttime)) {
      self killstreaks::play_pilot_dialog_on_owner("damageEvaded", "straferun", self.killstreakid);
    }
  }
}

startstrafe() {
  self endon(#"death", #"strafe_stop");

  if(isDefined(self.strafing)) {
    iprintlnbold("TRYING TO STRAFE WHEN ALREADY STRAFING!\n");
    return;
  }

  self.strafing = 1;
  self thread firerockets();
  count = 0;
  weaponshoottime = level.straferungunweapon.firetime;

  for(;;) {
    gunorigin = self gettagorigin("tag_flash");
    gunorigin += (0, 0, self.straferungunoffset);
    forward = anglesToForward(self.angles);
    forwardnoz = vectornormalize((forward[0], forward[1], 0));
    right = vectorcross(forwardnoz, (0, 0, 1));
    perfectattackstartvector = gunorigin + vectorscale(forwardnoz, self.straferungunlookahead);
    attackstartvector = perfectattackstartvector + vectorscale(right, randomfloatrange(0 - self.straferungunradius, self.straferungunradius));
    trace = bulletTrace(attackstartvector, (attackstartvector[0], attackstartvector[1], -500), 0, self, 0);
    self turretsettarget(0, trace[#"position"]);
    self fireweapon();
    self shellshockplayers(trace[#"position"]);

    if(getdvarint(#"scr_devstraferunbulletsdebugdraw", 0)) {
      time = 300;
      airsupport::debug_line(attackstartvector, trace[#"position"] - (0, 0, 20), (1, 0, 0), time, 0);

      if(count % 30 == 0) {
        trace = bulletTrace(perfectattackstartvector, (perfectattackstartvector[0], perfectattackstartvector[1], -100000), 0, self, 0, 1);
        airsupport::debug_line(trace[#"position"] + (0, 0, 20), trace[#"position"] - (0, 0, 20), (0, 0, 1), time, 0);
      }
    }

      count++;
    wait weaponshoottime;
  }
}

firststrafe() {}

firerockets() {
  self notify(#"firing_rockets");
  self endon(#"death", #"strafe_stop", #"firing_rockets");
  self.owner endon(#"disconnect");
  forward = anglesToForward(self.angles);
  self.firedrockettargets = [];

  for(rocketindex = 0; rocketindex < level.straferunnumrockets; rocketindex++) {
    rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
    targets = getvalidtargets();
    rocketorigin = self gettagorigin(rockettag);
    targetorigin = rocketorigin + forward * 10000;

    if(targets.size > 0) {
      selectedtarget = undefined;

      foreach(target in targets) {
        alreadyattacked = 0;

        foreach(oldtarget in self.firedrockettargets) {
          if(oldtarget == target) {
            alreadyattacked = 1;
            break;
          }
        }

        if(!alreadyattacked) {
          selectedtarget = target;
          break;
        }
      }

      if(isDefined(selectedtarget)) {
        self.firedrockettargets[self.firedrockettargets.size] = selectedtarget;
        targetorigin = deadrecontargetorigin(rocketorigin, selectedtarget);
      }
    }

    rocketorigin = self gettagorigin(rockettag);
    rocket = magicbullet(level.straferunrocketweapon, rocketorigin, rocketorigin + forward, self);

    if(isDefined(selectedtarget)) {
      rocket missile_settarget(selectedtarget, (0, 0, 0));
    }

    rocket.soundmod = "straferun";
    rocket attachkillcamtorocket(level.straferunkillcams.rockets[rocketindex], selectedtarget, targetorigin);

    if(getdvarint(#"scr_devstraferunkillcamsdebugdraw", 0)) {
      rocket thread airsupport::debug_draw_bomb_path(undefined, (0, 0.5, 0), 400);
    }

      wait level.straferunrocketdelay;
  }
}

stopstrafe() {
  self notify(#"strafe_stop");
  self.strafing = undefined;
  self thread resetkillcams(3);
  self turretcleartarget(0);
  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }

  if(owner.straferunbda == 0) {
    bdadialog = "killNone";
  } else if(owner.straferunbda == 1) {
    bdadialog = "kill1";
  } else if(owner.straferunbda == 2) {
    bdadialog = "kill2";
  } else if(owner.straferunbda == 3) {
    bdadialog = "kill3";
  } else if(owner.straferunbda > 3) {
    bdadialog = "killMultiple";
  }

  if(isDefined(bdadialog) && !(isDefined(self.leavenexttime) && self.leavenexttime)) {
    self killstreaks::play_pilot_dialog_on_owner(bdadialog, "straferun", self.killstreakid);
  }

  owner.straferunbda = 0;
  self.gunsoundentity stoploopsound();
  self.gunsoundentity playSound(#"wpn_a10_shot_decay_npc");
  self.numstrafes++;
}

shouldleavemap() {
  if(isDefined(self.leavenexttime) && self.leavenexttime) {
    return true;
  }

  if(self.numstrafes >= level.straferunmaxstrafes) {
    return true;
  }

  if(self.owner.straferunkills >= level.straferunkillsbeforeexit) {
    return true;
  }

  return false;
}

leavemap() {
  self unlinkkillcams();
  exitorigin = self.origin + vectorscale(anglesToForward(self.angles), level.straferunexitunits);
  self setyawspeed(5, 999, 999);
  self setgoal(exitorigin, 1);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  wait 5;

  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
      self.killcament = undefined;
    }

    self delete();
  }
}

explode() {
  self endon(#"delete");
  forward = self.origin + (0, 0, 100) - self.origin;
  playFX(level.straferunexplodefx, self.origin, forward);
  self playSound(level.straferunexplodesound);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  wait 0.1;

  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
      self.killcament = undefined;
    }

    self delete();
  }
}

cantargetentity(entity) {
  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;
  visible_amount = entity sightconetrace(heli_turret_point, self);

  if(visible_amount < level.heli_target_recognition) {
    return false;
  }

  return true;
}

cantargetplayer(player) {
  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }

  if(player == self.owner) {
    return false;
  }

  if(player airsupport::cantargetplayerwithspecialty() == 0) {
    return false;
  }

  if(!isDefined(player.team)) {
    return false;
  }

  if(level.teambased && player.team == self.team) {
    return false;
  }

  if(player.team == #"spectator") {
    return false;
  }

  if(isDefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
    return false;
  }

  if(!targetinfrontofplane(player)) {
    return false;
  }

  if(player isinmovemode("noclip")) {
    return false;
  }

  var_2910def0 = self targetting_delay::function_1c169b3a(player);
  self targetting_delay::function_a4d6d6d8(player, int((isDefined(level.straferunrocketdelay) ? level.straferunrocketdelay : 0.35) * 1000));

  if(!var_2910def0) {
    return false;
  }

  return cantargetentity(player);
}

cantargetactor(actor) {
  if(!isDefined(actor)) {
    return false;
  }

  if(actor.team == self.team) {
    return false;
  }

  if(isDefined(actor.script_owner) && self.owner == actor.script_owner) {
    return false;
  }

  if(!targetinfrontofplane(actor)) {
    return false;
  }

  return cantargetentity(actor);
}

targetinfrontofplane(target) {
  forward_dir = anglesToForward(self.angles);
  target_delta = vectornormalize(target.origin - self.origin);
  dot = vectordot(forward_dir, target_delta);

  if(dot < 0.5) {
    return true;
  }

  return true;
}

getvalidtargets() {
  targets = [];

  foreach(player in level.players) {
    if(self cantargetplayer(player)) {
      if(isDefined(player)) {
        targets[targets.size] = player;
      }
    }
  }

  tanks = getEntArray("talon", "targetname");

  foreach(tank in tanks) {
    if(self cantargetactor(tank)) {
      targets[targets.size] = tank;
    }
  }

  return targets;
}

deadrecontargetorigin(rocket_start, target) {
  target_velocity = target getvelocity();
  missile_speed = 7000;
  target_delta = target.origin - rocket_start;
  target_dist = length(target_delta);
  time_to_target = target_dist / missile_speed;
  return target.origin + target_velocity * time_to_target;
}

shellshockplayers(origin) {
  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(player == self.owner) {
      continue;
    }

    if(!isDefined(player.team)) {
      continue;
    }

    if(level.teambased && player.team == self.team) {
      continue;
    }

    if(distancesquared(player.origin, origin) <= level.straferunshellshockradius * level.straferunshellshockradius) {
      player thread straferunshellshock(self);
    }
  }
}

straferunshellshock(straferun) {
  self endon(#"disconnect");

  if(isDefined(self.beingstraferunshellshocked) && self.beingstraferunshellshocked) {
    return;
  }

  self.beingstraferunshellshocked = 1;
  params = getstatuseffect("deaf_straferun");
  self status_effect::status_effect_apply(params, level.straferunrocketweapon, straferun.owner, 0, int(level.straferunshellshockduration * 1000));
  wait level.straferunshellshockduration + 1;
  self.beingstraferunshellshocked = 0;
}

createkillcams(numkillcams, numrockets) {
  if(!isDefined(level.straferunkillcams)) {
    level.straferunkillcams = spawnStruct();
    level.straferunkillcams.rockets = [];

    for(i = 0; i < numrockets; i++) {
      level.straferunkillcams.rockets[level.straferunkillcams.rockets.size] = createkillcament();
    }
  }
}

resetkillcams(time) {
  self endon(#"death");

  if(isDefined(time)) {
    wait time;
  }

  for(i = 0; i < level.straferunkillcams.rockets.size; i++) {
    level.straferunkillcams.rockets[i] resetrocketkillcament(self, i);
  }
}

unlinkkillcams() {
  for(i = 0; i < level.straferunkillcams.rockets.size; i++) {
    level.straferunkillcams.rockets[i] unlink();
  }
}

createkillcament() {
  killcament = spawn("script_model", (0, 0, 0));
  killcament setfovforkillcam(25);
  return killcament;
}

resetkillcament(parent) {
  self notify(#"reset");
  parent endon(#"death");
  offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
  offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
  offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
  self linkto(parent, "tag_origin", (offset_x, offset_y, offset_z), (10, 0, 0));
  self thread unlinkwhenparentdies(parent);
}

resetrocketkillcament(parent, rocketindex) {
  self notify(#"reset");
  parent endon(#"death");
  offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
  offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
  offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
  rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
  self linkto(parent, rockettag, (offset_x, offset_y, offset_z), (10, 0, 0));
  self thread unlinkwhenparentdies(parent);
}

deletewhenparentdies(parent) {
  parent waittill(#"death");
  self delete();
}

unlinkwhenparentdies(parent) {
  self endon(#"reset", #"unlink");
  parent waittill(#"death");
  self unlink();
}

attachkillcamtorocket(killcament, selectedtarget, targetorigin) {
  offset_x = getdvarint(#"scr_killcamrocketoffsetx", -400);
  offset_y = getdvarint(#"scr_killcamrocketoffsety", 0);
  offset_z = getdvarint(#"scr_killcamrocketoffsetz", 110);
  self.killcament = killcament;
  forward = vectorscale(anglesToForward(self.angles), offset_x);
  right = vectorscale(anglestoright(self.angles), offset_y);
  up = vectorscale(anglestoup(self.angles), offset_z);
  killcament unlink();
  killcament.angles = (0, 0, 0);
  killcament.origin = self.origin;
  killcament linkto(self, "", (offset_x, offset_y, offset_z), (9, 0, 0));
  killcament thread unlinkwhenclose(selectedtarget, targetorigin, self);
}

unlinkwhenclose(selectedtarget, targetorigin, plane) {
  plane endon(#"death");
  self notify(#"unlink_when_close");
  self endon(#"unlink_when_close");
  distsqr = 1000000;

  while(true) {
    if(isDefined(selectedtarget)) {
      if(distancesquared(self.origin, selectedtarget.origin) < distsqr) {
        self unlink();
        self.angles = (0, 0, 0);
        return;
      }
    } else if(distancesquared(self.origin, targetorigin) < distsqr) {
      self unlink();
      self.angles = (0, 0, 0);
      return;
    }

    wait 0.1;
  }
}