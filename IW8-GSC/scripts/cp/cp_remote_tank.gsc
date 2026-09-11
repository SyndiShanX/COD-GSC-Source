/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_remote_tank.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("veh_pac_sentry_mp", var0, var1, var2);
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

function spawn_remote_tank(var0, var1, var2) {
  var3 = level.tanksettings["remote_tank"];

  if(isDefined(var2)) {
    var3 = var2;
  }

  var4 = var0.origin;
  var5 = var0.angles;

  if(!isDefined(var5)) {
    var5 = (0, 0, 0);
  }

  var6 = spawnVehicle(var3.modelbase, "veh_pac_sentry_mp_cp", var3.vehicleinfo, var4, var5);

  if(!isDefined(var6)) {
    return undefined;
  }

  var6.team = "axis";
  var6.tanktype = "remote_tank";
  var6.streakname = "pac_sentry";
  var6.config = var3;
  var6.maxhealth = var3.maxhealth;
  var6.health = var6.maxhealth;
  var6.lifetime = var3.lifetime;
  var7 = var6 getentitynumber();
  addtoassaultdronelist(var6, var7);
  thread removefromassaultdronelistondeath(var6);
  var8 = var6 gettagorigin("tag_turret");
  var9 = spawnturret("misc_turret", var8, var3.mgturretinfo, 0);
  var9 linkTo(var6, "tag_turret", (0, 0, 0), (0, 0, 0));
  var9 setModel(level.tanksettings["remote_tank"].mgturretmodelbase);
  var9.angles = var6.angles;
  var9.tank = var6;
  var9 setmode("manual");
  var9 setturretteam("axis");
  var9 setdefaultdroppitch(0);
  var9 setleftarc(360);
  var9 setrightarc(360);
  var9 settoparc(45);
  var9 setbottomarc(45);
  var9 setconvergencetime(0.05, "yaw");
  var9 setconvergencetime(0.05, "pitch");
  var6.mgturret = var9;
  var6.spawn_node = var0;
  var6.repulsor = createnavrepulsor("tank_repulsor", 0, var6, 128, 1);

  if(isDefined(var1)) {
    if(!isDefined(level.remote_tanks)) {
      level.remote_tanks = [];
    }

    level.remote_tanks[var1] = var6;
  }

  thread remotetank_rumble();
  return var6;
}

function remotetank_rumble() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

function use_remote_tank(var0) {
  var1 = playremotesequence("remotetank", 1);

  if(var1) {
    tank_finishdropoffsequence(self, var0);
    return;
  }
}

function addtoassaultdronelist(var0) {
  if(!isDefined(level.assaultdrones)) {
    level.assaultdrones = [];
  }

  level.assaultdrones[var0] = self;
}

function removefromassaultdronelistondeath(var0) {
  self waittill("death");
  level.assaultdrones[var0] = undefined;
}

function tank_finishdropoffsequence(var0, var1) {
  var2 = var1.origin + (0, 0, 200);
  var3 = var1.angles;
  var4 = var2 - anglesToForward(var3) * 100;
  var5 = var3;
  var6 = "on";

  if(isDefined(self.config.ref_13e88)) {
    var6 = self.config.ref_13e88;
  }

  var1.mgturret setscriptablepartstate("lights", var6);
  var1.mgturret laseron();
  var0 scripts\common\utility::allow_fire(0);
  var1.owner = var0;
  var1.mgturret maketurretoperable();
  tank_playercameratransition(var1, var2, var3, var4, var5);
  var0 scripts\common\utility::allow_fire(1);
  thread startusingtank(var0);
  thread tank_watchfortimeoutdisowned();
  thread tank_handleairburst();
  thread tank_handlewheeldustfx();
}

function tank_playercameratransition(var0, var1, var2, var3) {
  level endon("game_ended");
  self.owner unlink();
  var4 = spawn("script_model", var0);
  var4 setModel("tag_player");
  var4.owner = self.owner;
  var4.angles = var1;
  self.owner playerlinkweaponviewtodelta(var4, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  level notify("vision_set_change_request", "tac_ops_slamzoom", self.owner, 0.2);
  var2 += (0, 0, 20);
  var3 = vectortoangles(var0 - var2);
  var4 moveTo(var2, 0.5);
  var4 rotateTo(var3, 0.5);
  thread tank_startfadetransition();
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("vision_set_change_request", undefined, self.owner, 0.2, "tac_ops_slamzoom");
  self.owner unlink();
  var4 delete();
}

function tank_startfadetransition() {
  self endon("disconnect");
  level notify("vision_set_change_request", "tac_ops_slamzoom", self, 0.5);
  wait 0.5;
  level notify("vision_set_change_request", undefined, self, 0.5, "tac_ops_slamzoom");
}

function startusingtank(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingremotetank = 1;
  var0.mgturret setCanDamage(1);
  var0 setCanDamage(1);
  var1 = spawnStruct();
  var1.playdeathfx = 1;
  var1.deathoverridecallback = &tank_override_moving_platform_death;
  var0 setotherent(self);
  var0 setentityowner(self);
  var0.driver = self;
  self controlslinkTo(var0);
  self remotecontrolturret(var0.mgturret);
  self painvisionoff();
  self setclientomnvar("ui_hide_hud", 1);
  self setclientomnvar("ui_pac_sentry_controls", 1);
  self setclientomnvar("ui_pac_sentry_speed", 0);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var0.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", var0.health / var0.maxhealth);
  thread tank_earthquake();
  var0 thread scripts\cp\utility::allowridekillstreakplayerexit("death");
  scripts\cp\utility::_freezecontrols(0);
}

function tank_handlehelidamage() {
  self endon("death");
}

function tank_modifyhelidamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  return var6;
}

function tank_handlehelideathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(isDefined(self.intromodel)) {
    self.intromodel delete();
  }

  self notify("death");
}

function tank_modifydamageresponse(var0) {
  thread tank_modifydamagestate(var0);
  var1 = var0.damage;
  var2 = var0.meansofdeath;
  return true;
}

function tank_modifydamagestate(var0) {
  var1 = var0.damage;
  self.currenthealth = self.health - var1;
  return true;
}

function tank_override_moving_platform_death(var0) {
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

function tank_destroy(var0) {
  if(istrue(self.destroyed)) {
    return;
  } else {
    self.destroyed = 1;
  }

  level.remote_tanks = scripts\engine\utility::array_remove(level.remote_tanks, self);
  self notify("death");
  self.mgturret notify("death");

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  if(isDefined(self.driver)) {
    thread tank_driverexit(self.driver);
  }

  self.health = 0;
  self setCanDamage(0);
  self.mgturret setmode("sentry_offline");
  waitframe();
}

function tank_destroycallback(var0) {
  thread tank_destroy(var0.attacker);
  return false;
}

function tank_driverexit(var0) {
  self waittill("killstreakExit");
  self notify("end_remote");
  self.driver = undefined;
  var0.isusingremotetank = undefined;
  var0 controlsunlink();

  if(isDefined(self.mgturret)) {
    var0 remotecontrolturretoff(self.mgturret);
  }

  if(isDefined(var0.restoreangles)) {
    var0 setplayerangles(var0.restoreangles);
    var0.restoreangles = undefined;
  }

  var0 setclientomnvar("ui_pac_sentry_controls", 0);
  thread stopremotesequence(var0);
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  self.mgturret maketurretinoperable();
  var0 painvisionon();
}

function tank_handleairburst() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", var0);
    var1 = spawn("script_model", var0.origin);
    var1 setModel("ks_pac_sentry_mp");
    var1.angles = var0.angles;
    var1 linkTo(var0);
    var1 setentityowner(self.owner);
    thread tank_watchprojectiledeath(var0, var1);
    thread tank_findclosestairbursttarget(var0);
  }
}

function tank_watchprojectiledeath(var0, var1) {
  var1 endon("death");
  var2 = var0 scripts\engine\utility::ref_143ad("death", "perform_airburst");

  if(isDefined(var2) && var2 == "perform_airburst") {
    var1 setscriptablepartstate("airburst", "airExpl");
    var1 unlink();
    thread tank_delayairburstscriptabledeath();

    if(isDefined(var0)) {
      var0 delete();
      return;
    }

    return;
  }

  var1 delete();
}

function tank_delayairburstscriptabledeath() {
  self endon("death");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2);
  self delete();
}

function tank_findclosestairbursttarget(var0) {
  var0 endon("death");
  self endon("death");

  for(;;) {
    var1 = undefined;
    var2 = undefined;
    var3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var4 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, undefined, 10, 100);

    foreach(var6 in var4) {
      if(!isDefined(var6) || !scripts\cp\utility::should_be_affected_by_trap(var6, 1)) {
        continue;
      }

      if(level.teambased && var6.team == self.owner.team) {
        continue;
      }

      if(!tank_canseetarget(var0, var6)) {
        continue;
      }

      var2 = var6;
      break;
    }

    if(isDefined(var2)) {
      var0 notify("perform_airburst");
      break;
    }

    waitframe();
  }
}

function tank_handlewheeldustfx() {
  self endon("death");
  var0 = 0;
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

function tank_watchfiring(var0) {
  self endon("disconnect");
  self endon("end_remote");
  var0 endon("death");
  var1 = 50;
  var2 = var1;
  var3 = weaponfiretime(level.tanksettings[var0.tanktype].mgturretinfo);

  for(;;) {
    if(var0.mgturret isfiringvehicleturret()) {
      var2--;

      if(var2 <= 0) {
        var0.mgturret turretfiredisable();
        wait 2.5;
        var0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var2 = var1;
        var0.mgturret turretfireenable();
      }
    }

    wait var3;
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

function tank_canseetarget(var0, var1) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var2 = 0;
  var3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1);
  var4 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var5 = 0; var5 < var4.size; var5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + var1, var4[var5], self, var3)) {
      continue;
    }

    var2 = 1;
    break;
  }

  return var2;
}

function stopremotesequence(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var1 = "ks_remote_device_mp";

    if(istrue(var0)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + var1);
    } else {
      self notify("killstreak_finished_with_weapon_" + var1);
    }

    self takeweapon(var1);
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::ref_143b9(1.3, "death");
  self setclientomnvar("ui_remote_control_sequence", 0);
  self setclientomnvar("ui_hide_hud", 0);
}

function playremotesequence(var0, var1) {
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
  var2 = undefined;

  if(istrue(var1)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE");
      return false;
    }

    var2 = "ks_remote_device_mp";
    scripts\cp\utility::_giveweapon(var2, 0, 0, 1);
    self setclientomnvar("ui_remote_control_sequence", 1);
    var3 = scripts\cp\cp_weapons::switchtoweaponreliable(var2);

    if(!istrue(var3)) {
      return false;
    }
  }

  scripts\cp\utility::setusingremote("remotetank");
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.8);
  var4 = scripts\engine\utility::ref_143b9(1.8, "death");
  self notify("ks_freeze_end");

  if(!isDefined(var4) || var4 != "timeout") {
    self setclientomnvar("ui_remote_control_sequence", 0);
    scripts\cp\utility::_freezecontrols(0);
    scripts\cp\utility::clearusingremote();

    if(isDefined(var2)) {
      self notify("finished_with_manual_weapon_" + var2);
    }

    self stoplocalsound("mp_killstreak_tablet_gear");
    self notify("cancel_remote_sequence");
    return false;
  }

  scripts\cp\utility::_freezecontrols(0);
  self setclientomnvar("ui_remote_control_sequence", 0);
  return true;
}

function fire_on_nearby_players(var0) {
  self endon("death");
  level endon("wheelsons_deactivated");
  self.targetent = spawn("script_origin", self.origin);
  var1 = 0;
  var2 = 0.75;

  if(isDefined(self.ref_13b64)) {
    var2 = self.ref_13b64;
  }

  var3 = 0.5;

  if(isDefined(self.ref_13b63)) {
    var3 = self.ref_13b63;
  }

  if(!isDefined(self.max_detection_sq)) {
    self.max_detection_sq = 640000;
  }

  thread flicker_tank_lights();
  var4 = (0, 0, 50);

  for(;;) {
    while(!isDefined(self.owner)) {
      var5 = undefined;

      foreach(var7 in level.players) {
        if(distancesquared(self.mgturret.origin, var7.origin) > self.max_detection_sq) {
          continue;
        }

        if(isDefined(self.waittill_any_return_no_endon_death_5) && gettime() <= self.waittill_any_return_no_endon_death_4 + 5000) {} else if(isDefined(var0)) {
          var8 = var0;

          if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, var7.origin, var8)) {
            continue;
          }
        }

        var4 = questtimerupdate(var5);

        if(!tank_canseetarget(var7, var4)) {
          continue;
        }

        if(!isDefined(self.waittill_objective_start) || var7 != self.waittill_objective_start) {
          self.waittill_objective_start = undefined;
        }

        var5 = var7;
        break;
      }

      if(!isDefined(var5)) {
        wait 0.5;
        self.mgturret cleartargetentity();

        if(var1) {
          self.mgturret laseroff();
          var1 = 0;
        }

        self.waittill_objective_start = undefined;
        continue;
      } else {
        if(!var1) {
          self.mgturret laseron();
          thread flicker_tank_lights();
          var1 = 1;
        }

        var4 = questtimerupdate(var5);
        self.mgturret settargetentity(var5, var4);
        self.mgturret scripts\engine\utility::ref_143b9(5, "turret_on_target");

        if(!var5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var5, var4)) {
          wait 0.5;

          if(var1) {
            self.mgturret laseroff();
            var1 = 0;
          }

          self.waittill_objective_start = undefined;
          continue;
        }

        if(var5 scripts\cp\utility::is_valid_player()) {
          if(!isDefined(self.waittill_objective_start)) {
            self.waittill_objective_start = var5;
            var5 playlocalsound("canister_warning");
          }
        }

        wait var2;
        var4 = questtimerupdate(var5);

        if(!var5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var5, var4) || distancesquared(self.mgturret.origin, var5.origin) > self.max_detection_sq) {
          if(var1) {
            self.mgturret laseroff();
            var1 = 0;
          }

          continue;
        }

        if(isDefined(self.config.ref_13e8c)) {
          [[self.config.ref_13e8c]](var5);
        } else {
          self.mgturret shootturret();
        }

        thread notify_nearby_enemies();
        thread damage_nearby_dynolights();
        wait var3;
      }

      wait 0.5;
    }

    wait 0.1;
  }
}

function notify_nearby_enemies() {
  level notify("enemy_spotted", self);
  var0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var1 = 1000;

  if(isDefined(self.enemy_notify_range)) {
    var1 = self.enemy_notify_range;
  }

  var2 = scripts\engine\utility::get_array_of_closest(self.origin, var0, undefined, undefined, var1);

  foreach(var4 in var2) {
    var4 notify("bulletwhizby");
  }
}

function questtimerupdate(var0) {
  var1 = (0, 0, 50);

  if(isPlayer(var0)) {
    var2 = var0 getstance();

    switch (var2) {
      case "crouch":
        var1 = (0, 0, 25);
        break;
      case "prone":
        var1 = (0, 0, 0);
        break;
      default:
        var1 = (0, 0, 50);
        break;
    }
  }

  return var1;
}

function damage_nearby_dynolights() {
  if(!scripts\cp\utility::is_valid_player()) {
    return;
  }

  var0 = getEntArray("office_light_destructible", "script_noteworthy");
  var1 = scripts\engine\utility::get_array_of_closest(self.origin, var0, undefined, 2, 350);

  if(var1.size == 0) {
    return;
  }

  foreach(var3 in var1) {
    var3 notify("damage", 1000);
  }
}

function flicker_tank_lights() {
  self endon("death");
  var0 = "on";

  if(isDefined(self.config.ref_13e88)) {
    var0 = self.config.ref_13e88;
  }

  self.mgturret setscriptablepartstate("lights", "off");
  wait 0.5;
  self.mgturret setscriptablepartstate("lights", var0);
}