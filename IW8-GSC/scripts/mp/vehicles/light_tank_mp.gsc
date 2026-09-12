/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\light_tank_mp.gsc
*************************************************/

function light_tank_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "activate", &light_tank_mp_activate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "startCapture", &light_tank_mp_startcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "endCapture", &light_tank_mp_endcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "filterDropSpawns", &light_tank_mp_filterdropspawns);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "getDropSpawnIgnoreList", &light_tank_mp_getdropspawnignorelist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "spawnCallback", &light_tank_mp_spawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "initLate", &light_tank_mp_initlate);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("light_tank", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitteaminstances("light_tank", 3);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&scripts\cp_mp\vehicles\light_tank::light_tank_updateheadiconforplayeronjointeam);
  light_tank_mp_initmines();
  light_tank_mp_initspawning();
  light_tank_mp_initcapture();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("light_tank", &scripts\cp_mp\vehicles\light_tank::light_tank_explode);
}

function light_tank_mp_initlate() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("bradley", &scripts\cp_mp\vehicles\light_tank::light_tank_tryusefromstruct);
}

function light_tank_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("light_tank", 1);
  var_0.frontextents = 115;
  var_0.backextents = 110;
  var_0.leftextents = 60;
  var_0.rightextents = 60;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
}

function light_tank_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\light_tank::light_tank_timeout;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_0.areplayersnear = 105;
    var_0.ref_12CA1 = level.ref_13A58;
    return;
  }

  var_0.areplayersnear = 40;
}

function light_tank_mp_initcapture() {
  scripts\mp\playeractions::registeractionset("vehicleCapture", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function light_tank_mp_activate(var_0) {
  thread bctracking();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registerinstance(var_0);
}

function light_tank_mp_startcapture(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    light_tank_mp_createownercaptureobject(var_0, var_1);
  }

  if(level.teambased) {
    light_tank_mp_createothercaptureobject(var_0);
    return;
  }
}

function light_tank_mp_endcapture(var_0) {
  light_tank_mp_deletecaptureobjects(var_0);
}

function light_tank_mp_createownercaptureobject(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
  var_3 = spawn("script_model", var_2 gettagorigin("TAG_PLAYER"));
  var_3 linkTo(var_2);
  light_tank_mp_setupcaptureobject(var_3, 0.5);
  var_3.vehicle = var_0;
  var_0.ownercaptureobject = var_3;
  thread light_tank_mp_monitorownercapture(var_3, var_1);
  thread light_tank_mp_monitorownercapturevisibility(var_3);
  return var_3;
}

function light_tank_mp_createothercaptureobject(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, "tur_bradley_mp");
  var_2 = spawn("script_model", var_1 gettagorigin("TAG_PLAYER"));
  var_2 linkTo(var_1);
  light_tank_mp_setupcaptureobject(var_2, 3);
  var_2.vehicle = var_0;
  var_0.othercaptureobject = var_2;
  thread light_tank_mp_monitorothercapture(var_2);
  thread light_tank_mp_monitorothercapturevisibility();
  return var_2;
}

function light_tank_mp_setupcaptureobject(var_0) {
  self setCursorHint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
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
  self makeusable();
  self.userate = 1;
  self.curprogress = 0;
  self.usetime = var_0;
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
    light_tank_mp_deletecaptureobject(self.ownercaptureobject);
  }

  if(isDefined(self.othercaptureobject)) {
    light_tank_mp_deletecaptureobject(self.othercaptureobject);
    return;
  }
}

function light_tank_mp_monitorownercapture(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  self.vehicle = var_1;

  for(;;) {
    self waittillmatch("trigger", var_0);

    if(light_tank_mp_canstartcapture(var_0)) {
      self.playerusing = var_0;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var_0);
      var_2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;
      light_tank_mp_playerstopcapture(var_0);

      if(istrue(var_2)) {
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var_1, var_0);
      }

      waitframe();
    }
  }
}

function light_tank_mp_monitorothercapture(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(light_tank_mp_canstartcapture(var_1)) {
      self.playerusing = var_1;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var_1);
      var_2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;

      if(isDefined(var_1)) {
        light_tank_mp_playerstopcapture(var_1);
      }

      if(istrue(var_2)) {
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var_0, var_1);
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

function light_tank_mp_monitorownercapturevisibility(var_0) {
  self endon("death");

  while(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      self disableplayeruse(var_2);

      if(var_2 == var_0) {
        if(isDefined(self.playerusing)) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(var_0);
          }

          continue;
        }

        if(light_tank_mp_canstartcapture(var_0)) {
          self enableplayeruse(var_0);
        }
      }
    }

    wait 0.1;
  }

  thread light_tank_mp_deletecaptureobject();
}

function light_tank_mp_monitorothercapturevisibility() {
  self endon("death");

  for(;;) {
    if(isDefined(self.playerusing)) {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(var_1 == self.playerusing) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(var_1);
          }
        }
      }
    } else {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(light_tank_mp_canstartcapture(var_1)) {
          self enableplayeruse(var_1);
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_canstartcapture(var_0) {
  if(istrue(self.vehicle.isdestroyed)) {
    return false;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0.team == "spectator") {
    return false;
  }

  if(!var_0 scripts\common\utility::is_vehicle_use_allowed()) {
    return false;
  }

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(var_0, self.vehicle))) {
    return false;
  }

  return true;
}

function light_tank_mp_cankeepcapturing() {
  if(istrue(self.vehicle.isdestroyed)) {
    return false;
  }

  if(!self.playerusing scripts\common\utility::is_vehicle_use_allowed()) {
    return false;
  }

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(self.playerusing, self.vehicle))) {
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

function light_tank_mp_playerstartcapture(var_0) {
  var_0 scripts\mp\playeractions::allowactionset("vehicleCapture", 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_playerstopcapture(var_0) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 scripts\mp\playeractions::allowactionset("vehicleCapture", 1);
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_shouldawardattacker(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(level.teambased && var_1.team == var_0.team) {
    return false;
  }

  if(isDefined(var_0.owner) && var_1 == var_0.owner) {
    return false;
  }

  return true;
}

function bctracking() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(scripts\mp\utility\teams::isgameplayteam(self.team)) {
      var_0 = scripts\common\utility::playersinsphere(self.origin, 3000);

      foreach(var_2 in var_0) {
        var_3 = isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && scripts\mp\utility\player::isenemy(var_2);

        if(!var_3) {
          continue;
        }

        var_4 = anglesToForward(var_2 getplayerangles());
        var_5 = scripts\engine\math::anglebetweenvectors(var_4, self.origin - var_2.origin);

        if(isDefined(var_5) && var_5 <= 60) {
          if(self sightconetrace(var_2 getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_spawncallback(var_0, var_1) {
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_0);

  if(!isDefined(var_0.spawnmethod)) {
    var_0.spawnmethod = "place_at_position_unsafe";
  }

  if(!isDefined(var_0.showheadicon)) {
    var_0.showheadicon = 0;
  }

  var_0.cantimeout = 0;
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &light_tank_mp_ondeathrespawncallback;
  }

  return var_2;
}

function light_tank_mp_ondeathrespawncallback() {
  thread light_tank_mp_waitandspawn();
}

function light_tank_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("light_tank", var_1, var_2);

  if(isDefined(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      if(scripts\mp\flags::gameflag("prematch_done")) {
        scripts\mp\gametypes\arm::droptank_playincomingdialog(var_1);
      }

      if(istrue(level.ref_13377)) {
        scripts\mp\gametypes\arm::ref_1413B(var_3, var_3.team);
      }

      foreach(var_5 in level.players) {
        if(var_5.team == var_3.team) {
          var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(62, undefined, 5);
        }
      }

      return;
    }

    return;
  }
}

function light_tank_mp_filterdropspawns(var_0) {
  var_1 = var_0;

  if(isDefined(level.vehspawnvol)) {
    var_1 = [];

    foreach(var_3 in var_0) {
      if(ispointinvolume(var_3.origin, level.vehspawnvol)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function light_tank_mp_getdropspawnignorelist(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, var_0);
}