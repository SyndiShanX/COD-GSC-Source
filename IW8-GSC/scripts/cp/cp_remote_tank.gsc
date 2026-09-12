/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_remote_tank.gsc
***********************************************/

function main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("veh_pac_sentry_mp", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
}

function init_local() {}

function init_remote_tank() {
  level._effect["wheelson_light"] = loadfx("vfx/iw8_cp/level/cp_lab/vfx_wheelson_spotlight_14.vfx");
  level._effect["remote_tank_explode"] = loadfx("vfx/iw8_cp/level/cp_lab/vfx_wheelson_death_exp_no_model.vfx");
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60;
  level.tanksettings["remote_tank"].maxhealth = 500;
  level.tanksettings["remote_tank"].hitstokill = 5;
  level.tanksettings["remote_tank"].streakname = "pac_sentry";
  level.tanksettings["remote_tank"].modelbase = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].modeldestroyed = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].mgturretmodelbase = "veh8_mil_lnd_whotel_turret";
  level.tanksettings["remote_tank"].mgturretinfo = "pac_sentry_turret_cp";
  level.tanksettings["remote_tank"].sentrymodeon = "sentry";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].vehicleinfo = "veh_pac_sentry_mp_cp";
  level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level.tanksettings["remote_tank"].scorepopup = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].vodestroyed = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].destoyedsplash = "callout_destroyed_pac_sentry";
  level.tanksettings["remote_tank"].premoddamagefunc = undefined;
  level.tanksettings["remote_tank"].lifetime = 600;
  level.remote_tank_armor_bulletdamage = 0.5;
  setdvarifuninitialized("scr_pac_sentry_3rd", 0);
  setdvarifuninitialized("scr_pac_sentry_lifetime", level.tanksettings["remote_tank"].timeout);
  setdvarifuninitialized("scr_pac_sentry_instaspawn", 0);
}

function spawn_remote_tank(var_0, var_1, var_2) {
  var_3 = level.tanksettings["remote_tank"];

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  var_4 = var_0.origin;
  var_5 = var_0.angles;

  if(!isDefined(var_5)) {
    var_5 = (0, 0, 0);
  }

  var_6 = spawnVehicle(var_3.modelbase, "veh_pac_sentry_mp_cp", var_3.vehicleinfo, var_4, var_5);

  if(!isDefined(var_6)) {
    return undefined;
  }

  var_6.team = "axis";
  var_6.tanktype = "remote_tank";
  var_6.streakname = "pac_sentry";
  var_6.config = var_3;
  var_6.maxhealth = var_3.maxhealth;
  var_6.health = var_6.maxhealth;
  var_6.lifetime = var_3.lifetime;
  var_7 = var_6 getentitynumber();
  addtoassaultdronelist(var_6, var_7);
  thread removefromassaultdronelistondeath(var_6);
  var_8 = var_6 gettagorigin("tag_turret");
  var_9 = spawnturret("misc_turret", var_8, var_3.mgturretinfo, 0);
  var_9 linkTo(var_6, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_9 setModel(level.tanksettings["remote_tank"].mgturretmodelbase);
  var_9.angles = var_6.angles;
  var_9.tank = var_6;
  var_9 setmode("manual");
  var_9 setturretteam("axis");
  var_9 setdefaultdroppitch(0);
  var_9 setleftarc(360);
  var_9 setrightarc(360);
  var_9 settoparc(45);
  var_9 setbottomarc(45);
  var_9 setconvergencetime(0.05, "yaw");
  var_9 setconvergencetime(0.05, "pitch");
  var_6.mgturret = var_9;
  var_6.spawn_node = var_0;
  var_6.repulsor = createnavrepulsor("tank_repulsor", 0, var_6, 128, 1);

  if(isDefined(var_1)) {
    if(!isDefined(level.remote_tanks)) {
      level.remote_tanks = [];
    }

    level.remote_tanks[var_1] = var_6;
  }

  thread remotetank_rumble();
  return var_6;
}

function remotetank_rumble() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

function use_remote_tank(var_0) {
  var_1 = playremotesequence("remotetank", 1);

  if(var_1) {
    tank_finishdropoffsequence(self, var_0);
    return;
  }
}

function addtoassaultdronelist(var_0) {
  if(!isDefined(level.assaultdrones)) {
    level.assaultdrones = [];
  }

  level.assaultdrones[var_0] = self;
}

function removefromassaultdronelistondeath(var_0) {
  self waittill("death");
  level.assaultdrones[var_0] = undefined;
}

function tank_finishdropoffsequence(var_0, var_1) {
  var_2 = var_1.origin + (0, 0, 200);
  var_3 = var_1.angles;
  var_4 = var_2 - anglesToForward(var_3) * 100;
  var_5 = var_3;
  var_6 = "on";

  if(isDefined(self.config.ref_13E88)) {
    var_6 = self.config.ref_13E88;
  }

  var_1.mgturret setscriptablepartstate("lights", var_6);
  var_1.mgturret laseron();
  var_0 scripts\common\utility::allow_fire(0);
  var_1.owner = var_0;
  var_1.mgturret maketurretoperable();
  tank_playercameratransition(var_1, var_2, var_3, var_4, var_5);
  var_0 scripts\common\utility::allow_fire(1);
  thread startusingtank(var_0);
  thread tank_watchfortimeoutdisowned();
  thread tank_handleairburst();
  thread tank_handlewheeldustfx();
}

function tank_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.owner unlink();
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_player");
  var_4.owner = self.owner;
  var_4.angles = var_1;
  self.owner playerlinkweaponviewtodelta(var_4, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  level notify("vision_set_change_request", "tac_ops_slamzoom", self.owner, 0.2);
  var_2 += (0, 0, 20);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 moveTo(var_2, 0.5);
  var_4 rotateTo(var_3, 0.5);
  thread tank_startfadetransition();
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("vision_set_change_request", undefined, self.owner, 0.2, "tac_ops_slamzoom");
  self.owner unlink();
  var_4 delete();
}

function tank_startfadetransition() {
  self endon("disconnect");
  level notify("vision_set_change_request", "tac_ops_slamzoom", self, 0.5);
  wait 0.5;
  level notify("vision_set_change_request", undefined, self, 0.5, "tac_ops_slamzoom");
}

function startusingtank(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingremotetank = 1;
  var_0.mgturret setCanDamage(1);
  var_0 setCanDamage(1);
  var_1 = spawnStruct();
  var_1.playdeathfx = 1;
  var_1.deathoverridecallback = &tank_override_moving_platform_death;
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0.driver = self;
  self controlslinkTo(var_0);
  self remotecontrolturret(var_0.mgturret);
  self painvisionoff();
  self setclientomnvar("ui_hide_hud", 1);
  self setclientomnvar("ui_pac_sentry_controls", 1);
  self setclientomnvar("ui_pac_sentry_speed", 0);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", var_0.health / var_0.maxhealth);
  thread tank_earthquake();
  var_0 thread scripts\cp\utility::allowridekillstreakplayerexit("death");
  scripts\cp\utility::_freezecontrols(0);
}

function tank_handlehelidamage() {
  self endon("death");
}

function tank_modifyhelidamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  return var_6;
}

function tank_handlehelideathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.intromodel)) {
    self.intromodel delete();
  }

  self notify("death");
}

function tank_modifydamageresponse(var_0) {
  thread tank_modifydamagestate(var_0);
  var_1 = var_0.damage;
  var_2 = var_0.meansofdeath;
  return true;
}

function tank_modifydamagestate(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;
  return true;
}

function tank_override_moving_platform_death(var_0) {
  thread tank_destroy();
}

function tank_watchfortimeoutdisowned() {
  self endon("death");
  tank_watchfortimeoutdisownedendearly();
  thread tank_destroy();
}

function tank_watchfortimeoutdisownedendearly() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

function tank_destroy(var_0) {
  if(istrue(self.destroyed)) {
    return;
  } else {
    self.destroyed = 1;
  }

  level.remote_tanks = scripts\engine\utility::array_remove(level.remote_tanks, self);
  self notify("death");
  self.mgturret notify("death");

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  if(isDefined(self.driver)) {
    thread tank_driverexit(self.driver);
  }

  self.health = 0;
  self setCanDamage(0);
  self.mgturret setmode("sentry_offline");
  waitframe();
}

function tank_destroycallback(var_0) {
  thread tank_destroy(var_0.attacker);
  return false;
}

function tank_driverexit(var_0) {
  self waittill("killstreakExit");
  self notify("end_remote");
  self.driver = undefined;
  var_0.isusingremotetank = undefined;
  var_0 controlsunlink();

  if(isDefined(self.mgturret)) {
    var_0 remotecontrolturretoff(self.mgturret);
  }

  if(isDefined(var_0.restoreangles)) {
    var_0 setplayerangles(var_0.restoreangles);
    var_0.restoreangles = undefined;
  }

  var_0 setclientomnvar("ui_pac_sentry_controls", 0);
  thread stopremotesequence(var_0);
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  self.mgturret maketurretinoperable();
  var_0 painvisionon();
}

function tank_handleairburst() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", var_0);
    var_1 = spawn("script_model", var_0.origin);
    var_1 setModel("ks_pac_sentry_mp");
    var_1.angles = var_0.angles;
    var_1 linkTo(var_0);
    var_1 setentityowner(self.owner);
    thread tank_watchprojectiledeath(var_0, var_1);
    thread tank_findclosestairbursttarget(var_0);
  }
}

function tank_watchprojectiledeath(var_0, var_1) {
  var_1 endon("death");
  var_2 = var_0 scripts\engine\utility::ref_143AD("death", "perform_airburst");

  if(isDefined(var_2) && var_2 == "perform_airburst") {
    var_1 setscriptablepartstate("airburst", "airExpl");
    var_1 unlink();
    thread tank_delayairburstscriptabledeath();

    if(isDefined(var_0)) {
      var_0 delete();
      return;
    }

    return;
  }

  var_1 delete();
}

function tank_delayairburstscriptabledeath() {
  self endon("death");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2);
  self delete();
}

function tank_findclosestairbursttarget(var_0) {
  var_0 endon("death");
  self endon("death");

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, undefined, 10, 100);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\cp\utility::should_be_affected_by_trap(var_6, 1)) {
        continue;
      }

      if(level.teambased && var_6.team == self.owner.team) {
        continue;
      }

      if(!tank_canseetarget(var_0, var_6)) {
        continue;
      }

      var_2 = var_6;
      break;
    }

    if(isDefined(var_2)) {
      var_0 notify("perform_airburst");
      break;
    }

    waitframe();
  }
}

function tank_handlewheeldustfx() {
  self endon("death");
  var_0 = 0;
  jumpiffalse(istrue(level.wet_level)) LOC_00000015;
  return;
}

function tank_empgrenaded() {
  self notify("tank_EMPGrenaded");
  self endon("tank_EMPGrenaded");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;
  self.mgturret turretfiredisable();
  wait 3.5;
  self.empgrenaded = 0;
  self.mgturret turretfireenable();
}

function tank_watchfiring(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  var_0 endon("death");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_2 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_2 = var_1;
        var_0.mgturret turretfireenable();
      }
    }

    wait var_3;
  }
}

function tank_earthquake() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  while(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.07, 0.25, self gettagorigin("tag_body"), 500);
    wait 0.25;
  }
}

function tank_canseetarget(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1);
  var_4 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + var_1, var_4[var_5], self, var_3)) {
      continue;
    }

    var_2 = 1;
    break;
  }

  return var_2;
}

function stopremotesequence(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var_1 = "ks_remote_device_mp";

    if(istrue(var_0)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + var_1);
    } else {
      self notify("killstreak_finished_with_weapon_" + var_1);
    }

    self takeweapon(var_1);
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::ref_143B9(1.3, "death");
  self setclientomnvar("ui_remote_control_sequence", 0);
  self setclientomnvar("ui_hide_hud", 0);
}

function playremotesequence(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp\utility::isusingremote()) {
    return false;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  self notify("play_remote_sequence");
  self playlocalsound("mp_killstreak_tablet_gear");
  var_2 = undefined;

  if(istrue(var_1)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE");
      return false;
    }

    var_2 = "ks_remote_device_mp";
    scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
    self setclientomnvar("ui_remote_control_sequence", 1);
    var_3 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

    if(!istrue(var_3)) {
      return false;
    }
  }

  scripts\cp\utility::setusingremote("remotetank");
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.8);
  var_4 = scripts\engine\utility::ref_143B9(1.8, "death");
  self notify("ks_freeze_end");

  if(!isDefined(var_4) || var_4 != "timeout") {
    self setclientomnvar("ui_remote_control_sequence", 0);
    scripts\cp\utility::_freezecontrols(0);
    scripts\cp\utility::clearusingremote();

    if(isDefined(var_2)) {
      self notify("finished_with_manual_weapon_" + var_2);
    }

    self stoplocalsound("mp_killstreak_tablet_gear");
    self notify("cancel_remote_sequence");
    return false;
  }

  scripts\cp\utility::_freezecontrols(0);
  self setclientomnvar("ui_remote_control_sequence", 0);
  return true;
}

function fire_on_nearby_players(var_0) {
  self endon("death");
  level endon("wheelsons_deactivated");
  self.targetent = spawn("script_origin", self.origin);
  var_1 = 0;
  var_2 = 0.75;

  if(isDefined(self.ref_13B64)) {
    var_2 = self.ref_13B64;
  }

  var_3 = 0.5;

  if(isDefined(self.ref_13B63)) {
    var_3 = self.ref_13B63;
  }

  if(!isDefined(self.max_detection_sq)) {
    self.max_detection_sq = 640000;
  }

  thread flicker_tank_lights();
  var_4 = (0, 0, 50);

  for(;;) {
    while(!isDefined(self.owner)) {
      var_5 = undefined;

      foreach(var_7 in level.players) {
        if(distancesquared(self.mgturret.origin, var_7.origin) > self.max_detection_sq) {
          continue;
        }

        if(isDefined(self.waittill_any_return_no_endon_death_5) && gettime() <= self.waittill_any_return_no_endon_death_4 + 5000) {} else if(isDefined(var_0)) {
          var_8 = var_0;

          if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, var_7.origin, var_8)) {
            continue;
          }
        }

        var_4 = questtimerupdate(var_5);

        if(!tank_canseetarget(var_7, var_4)) {
          continue;
        }

        if(!isDefined(self.waittill_objective_start) || var_7 != self.waittill_objective_start) {
          self.waittill_objective_start = undefined;
        }

        var_5 = var_7;
        break;
      }

      if(!isDefined(var_5)) {
        wait 0.5;
        self.mgturret cleartargetentity();

        if(var_1) {
          self.mgturret laseroff();
          var_1 = 0;
        }

        self.waittill_objective_start = undefined;
        continue;
      } else {
        if(!var_1) {
          self.mgturret laseron();
          thread flicker_tank_lights();
          var_1 = 1;
        }

        var_4 = questtimerupdate(var_5);
        self.mgturret settargetentity(var_5, var_4);
        self.mgturret scripts\engine\utility::ref_143B9(5, "turret_on_target");

        if(!var_5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var_5, var_4)) {
          wait 0.5;

          if(var_1) {
            self.mgturret laseroff();
            var_1 = 0;
          }

          self.waittill_objective_start = undefined;
          continue;
        }

        if(var_5 scripts\cp\utility::is_valid_player()) {
          if(!isDefined(self.waittill_objective_start)) {
            self.waittill_objective_start = var_5;
            var_5 playlocalsound("canister_warning");
          }
        }

        wait var_2;
        var_4 = questtimerupdate(var_5);

        if(!var_5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var_5, var_4) || distancesquared(self.mgturret.origin, var_5.origin) > self.max_detection_sq) {
          if(var_1) {
            self.mgturret laseroff();
            var_1 = 0;
          }

          continue;
        }

        if(isDefined(self.config.ref_13E8C)) {
          [[self.config.ref_13E8C]](var_5);
        } else {
          self.mgturret shootturret();
        }

        thread notify_nearby_enemies();
        thread damage_nearby_dynolights();
        wait var_3;
      }

      wait 0.5;
    }

    wait 0.1;
  }
}

function notify_nearby_enemies() {
  level notify("enemy_spotted", self);
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_1 = 1000;

  if(isDefined(self.enemy_notify_range)) {
    var_1 = self.enemy_notify_range;
  }

  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, undefined, var_1);

  foreach(var_4 in var_2) {
    var_4 notify("bulletwhizby");
  }
}

function questtimerupdate(var_0) {
  var_1 = (0, 0, 50);

  if(isPlayer(var_0)) {
    var_2 = var_0 getstance();

    switch (var_2) {
      case "crouch":
        var_1 = (0, 0, 25);
        break;
      case "prone":
        var_1 = (0, 0, 0);
        break;
      default:
        var_1 = (0, 0, 50);
        break;
    }
  }

  return var_1;
}

function damage_nearby_dynolights() {
  if(!scripts\cp\utility::is_valid_player()) {
    return;
  }

  var_0 = getEntArray("office_light_destructible", "script_noteworthy");
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, 2, 350);

  if(var_1.size == 0) {
    return;
  }

  foreach(var_3 in var_1) {
    var_3 notify("damage", 1000);
  }
}

function flicker_tank_lights() {
  self endon("death");
  var_0 = "on";

  if(isDefined(self.config.ref_13E88)) {
    var_0 = self.config.ref_13E88;
  }

  self.mgturret setscriptablepartstate("lights", "off");
  wait 0.5;
  self.mgturret setscriptablepartstate("lights", var_0);
}