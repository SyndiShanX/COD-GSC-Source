/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\light_tank_mp.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#using scripts\mp\vehicles\damage;
#using scripts\mp\vehicles\vehicle_oob_mp;
#namespace light_tank_mp;

function light_tank_mp_init() {
  registersharedfunc("light_tank", "activate", &light_tank_mp_activate);
  registersharedfunc("light_tank", "startCapture", &light_tank_mp_startcapture);
  registersharedfunc("light_tank", "endCapture", &light_tank_mp_endcapture);
  registersharedfunc("light_tank", "filterDropSpawns", &light_tank_mp_filterdropspawns);
  registersharedfunc("light_tank", "getDropSpawnIgnoreList", &light_tank_mp_getdropspawnignorelist);
  registersharedfunc("light_tank", "spawn", &light_tank_mp_spawncallback);
  registersharedfunc("light_tank", "initLate", &light_tank_mp_initlate);
  registersharedfunc("light_tank", "onDeathRespawn", &light_tank_mp_ondeathrespawncallback);
  vehicle_tracking_limitgameinstances("light_tank", 6);
  vehicle_tracking_limitteaminstances("light_tank", 3);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(getsharedfunc("light_tank", "updateHeadIconForPlayerOnJoinTeam"));
  light_tank_mp_initspawning();
  light_tank_mp_initcapture();
}

function light_tank_mp_initlate() {}

function light_tank_mp_initspawning() {
  leveldataforvehicle = vehicle_spawn_getleveldataforvehicle("light_tank");
  leveldataforvehicle.abandonedtimeoutcallback = getsharedfunc("light_tank", "timeOut");

  if(getgametype() == "arm" || getgametype() == "risk") {
    leveldataforvehicle.abandonedtimeoutdelay = 105;
    leveldataforvehicle.respawndelay = level.tankrespawntime;
    return;
  }

  leveldataforvehicle.abandonedtimeoutdelay = 40;
}

function light_tank_mp_initcapture() {
  val::group_register("vehicleCapture", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function light_tank_mp_activate(vehicle) {
  vehicle thread bctracking();
  scripts\mp\outofbounds::registerentforoob(vehicle, "vehicle");
}

function light_tank_mp_startcapture(vehicle, owner, team) {
  if(isDefined(owner)) {
    light_tank_mp_createownercaptureobject(vehicle, owner);
  }

  if(level.teambased) {
    light_tank_mp_createothercaptureobject(vehicle);
  }
}

function light_tank_mp_endcapture(vehicle) {
  vehicle light_tank_mp_deletecaptureobjects();
}

function light_tank_mp_createownercaptureobject(vehicle, owner) {
  captureobject = spawn("script_model", vehicle gettagorigin("TAG_PLAYER"));
  captureobject linkTo(vehicle);
  captureobject light_tank_mp_setupcaptureobject(0.5);
  captureobject.vehicle = vehicle;
  vehicle.ownercaptureobject = captureobject;
  captureobject thread light_tank_mp_monitorownercapture(owner, vehicle);
  captureobject thread light_tank_mp_monitorownercapturevisibility(owner);
  return captureobject;
}

function light_tank_mp_createothercaptureobject(vehicle) {
  captureobject = spawn("script_model", vehicle gettagorigin("TAG_PLAYER"));
  captureobject linkTo(vehicle);
  captureobject light_tank_mp_setupcaptureobject(3);
  captureobject.vehicle = vehicle;
  vehicle.othercaptureobject = captureobject;
  captureobject thread light_tank_mp_monitorothercapture(vehicle);
  captureobject thread light_tank_mp_monitorothercapturevisibility();
  return captureobject;
}

function light_tank_mp_setupcaptureobject(usetime) {
  self makeusable();
  self setCursorHint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    self setHintString(&"KILLSTREAKS_HINTS/BRADLEY_CAPTURE");
  }

  self sethinttag("none");
  self sethintdisplayrange(200);
  self sethintdisplayfov(360);
  self setuserange(200);
  self setusefov(360);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self setusehideprogressbar(1);
  self.userate = 1;
  self.curprogress = 0;
  self.usetime = usetime;
  self.inuse = 0;
  self.playerusing = undefined;
  self.id = "care_package";
}

function light_tank_mp_deletecaptureobject() {
  if(isDefined(self.playerusing)) {
    light_tank_mp_playerstopcapture(self.playerusing);
  }

  self delete();
}

function light_tank_mp_deletecaptureobjects() {
  if(isDefined(self.ownercaptureobject)) {
    self.ownercaptureobject light_tank_mp_deletecaptureobject();
  }

  if(isDefined(self.othercaptureobject)) {
    self.othercaptureobject light_tank_mp_deletecaptureobject();
  }
}

function light_tank_mp_monitorownercapture(owner, vehicle) {
  self endon("death");
  owner endon("disconnect");
  self.vehicle = vehicle;

  while(true) {
    self waittillmatch("trigger", owner);

    if(light_tank_mp_canstartcapture(owner)) {
      self.playerusing = owner;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(owner);
      captured = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;
      light_tank_mp_playerstopcapture(owner);

      if(istrue(captured) && issharedfuncdefined("light_tank", "capture")) {
        thread[[getsharedfunc("light_tank", "capture")]](vehicle, owner);
      }

      waitframe();
    }
  }
}

function light_tank_mp_monitorothercapture(vehicle) {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(light_tank_mp_canstartcapture(player)) {
      self.playerusing = player;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(player);
      captured = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;

      if(isDefined(player)) {
        light_tank_mp_playerstopcapture(player);
      }

      if(istrue(captured) && issharedfuncdefined("light_tank", "capture")) {
        thread[[getsharedfunc("light_tank", "capture")]](vehicle, player);
      }

      waitframe();
    }
  }
}

function light_tank_mp_monitorcaptureinternal() {
  self.playerusing endon("death_or_disconnect");

  while(light_tank_mp_cankeepcapturing()) {
    self.curprogress += level.framedurationseconds * self.userate;

    if(self.curprogress >= self.usetime) {
      return 1;
    }

    self.playerusing scripts\mp\gameobjects::updateuiprogress(self, 1);
    waitframe();
  }
}

function light_tank_mp_monitorownercapturevisibility(owner) {
  self endon("death");

  while(isDefined(owner)) {
    foreach(player in level.players) {
      self disableplayeruse(player);

      if(player == owner) {
        if(isDefined(self.playerusing)) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(owner);
          }

          continue;
        }

        if(light_tank_mp_canstartcapture(owner)) {
          self enableplayeruse(owner);
        }
      }
    }

    wait 0.1;
  }

  thread light_tank_mp_deletecaptureobject();
}

function light_tank_mp_monitorothercapturevisibility() {
  self endon("death");

  while(true) {
    if(isDefined(self.playerusing)) {
      foreach(player in level.players) {
        self disableplayeruse(player);

        if(player == self.playerusing) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(player);
          }
        }
      }
    } else {
      foreach(player in level.players) {
        self disableplayeruse(player);

        if(light_tank_mp_canstartcapture(player)) {
          self enableplayeruse(player);
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_canstartcapture(player) {
  if(istrue(self.vehicle.isdestroyed)) {
    return false;
  }

  if(!isDefined(player)) {
    return false;
  }

  if(!player _isalive()) {
    return false;
  }

  if(player.team == "spectator") {
    return false;
  }

  if(!player val::get("vehicle_use")) {
    return false;
  }

  if(!istrue(vehicle_interact_playercanusevehicle(player, self.vehicle))) {
    return false;
  }

  return true;
}

function light_tank_mp_cankeepcapturing() {
  if(istrue(self.vehicle.isdestroyed)) {
    return false;
  }

  if(!self.playerusing val::get("vehicle_use")) {
    return false;
  }

  if(!istrue(vehicle_interact_playercanusevehicle(self.playerusing, self.vehicle))) {
    return false;
  }

  if(!self.playerusing useButtonPressed()) {
    return false;
  }

  if(self.playerusing isonladder()) {
    return false;
  }

  if(self.playerusing meleeButtonPressed()) {
    return false;
  }

  if(distancesquared(self.playerusing.origin, self.origin) > 90000) {
    return false;
  }

  return true;
}

function light_tank_mp_playerstartcapture(player) {
  player val::group_set("vehicleCapture", 0);
  player scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_playerstopcapture(player) {
  if(player _isalive()) {
    player val::group_reset("vehicleCapture");
  }

  player scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_shouldawardattacker(vehicle, attacker) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(level.teambased && attacker.team == vehicle.team) {
    return false;
  }

  if(isDefined(vehicle.owner) && attacker == vehicle.owner) {
    return false;
  }

  return true;
}

function bctracking() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    if(scripts\mp\utility\teams::isgameplayteam(self.team)) {
      nearplayers = utility::playersinsphere(self.origin, 3000);

      foreach(player in nearplayers) {
        validplayer = isDefined(player) && player _isalive() && scripts\cp_mp\utility\player_utility::isenemy(player);

        if(!validplayer) {
          continue;
        }

        playerfacingdir = anglesToForward(player getplayerangles());
        var_e402c093911c20ee = math::anglebetweenvectors(playerfacingdir, self.origin - player.origin);

        if(isDefined(var_e402c093911c20ee) && var_e402c093911c20ee <= 60) {
          if(self sightconetrace(player getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_spawncallback(spawndata, faildata) {
  assert(scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1("<dev string:x1c>"));
  [[getsharedfunc("light_tank", "initSpawnData")]](spawndata);

  if(!isDefined(spawndata.spawnmethod)) {
    spawndata.spawnmethod = "place_at_position_unsafe";
  }

  if(!isDefined(spawndata.showheadicon)) {
    spawndata.showheadicon = 0;
  }

  spawndata.cantimeout = 0;
  vehicle = [[getsharedfunc("light_tank", "tankSpawn")]](spawndata, faildata);
  return vehicle;
}

function light_tank_mp_ondeathrespawncallback() {
  thread light_tank_mp_waitandspawn();
}

function light_tank_mp_waitandspawn() {
  if(!scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1("light_tank")) {
    return;
  }

  oldspawndata = getvehiclespawndata(self);

  if(isDefined(oldspawndata.basevehiclespawndata)) {
    oldspawndata = oldspawndata.basevehiclespawndata;
  }

  spawndata = spawnStruct();
  copyvehiclespawndata(oldspawndata, spawndata);
  [[getsharedfunc("light_tank", "copySpawnData")]](oldspawndata, spawndata);
  faildata = spawnStruct();
  vehicle = vehicle_spawn_waitandrespawn("light_tank", spawndata, faildata);

  if(isDefined(vehicle)) {
    if(getgametype() == "arm" || getgametype() == "risk") {
      if(scripts\mp\flags::gameflag("prematch_done")) {
        scripts\mp\gametypes\arm_vehicles::droptank_playincomingdialog(spawndata);
      }

      foreach(player in level.players) {
        if(player.team == vehicle.team) {
          player scripts\mp\utility\lower_message::setlowermessageomnvar("gw_iav_respawn", undefined, 5);
        }
      }
    }
  }
}

function light_tank_mp_filterdropspawns(dropspawns) {
  var_30492e606ac5ccff = dropspawns;

  if(isDefined(level.vehspawnvol)) {
    var_30492e606ac5ccff = [];

    foreach(dropspawn in dropspawns) {
      if(ispointinvolume(dropspawn.origin, level.vehspawnvol)) {
        var_30492e606ac5ccff[var_30492e606ac5ccff.size] = dropspawn;
      }
    }
  }

  return var_30492e606ac5ccff;
}

function light_tank_mp_getdropspawnignorelist(ignorelist) {
  var_8496e2572c67cb8c = [];
  var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = ignorelist;

  if(isDefined(level.helis)) {
    var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = level.helis;
  }

  if(isDefined(level.littlebirds)) {
    var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = level.littlebirds;
  }

  if(isDefined(level.supportdrones)) {
    var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = level.supportdrones;
  }

  var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = vehicle_tracking_getgameinstances("emp_drone");
  var_8496e2572c67cb8c[var_8496e2572c67cb8c.size] = vehicle_tracking_getgameinstances("cruise_predator");
  return scripts\engine\utility::array_combine_multiple(var_8496e2572c67cb8c);
}