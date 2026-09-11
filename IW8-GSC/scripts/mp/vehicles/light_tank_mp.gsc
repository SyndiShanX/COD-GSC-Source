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
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("light_tank", 1);
  var0.frontextents = 115;
  var0.backextents = 110;
  var0.leftextents = 60;
  var0.rightextents = 60;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
}

function light_tank_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\light_tank::light_tank_timeout;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var0.areplayersnear = 105;
    var0.ref_12ca1 = level.ref_13a58;
    return;
  }

  var0.areplayersnear = 40;
}

function light_tank_mp_initcapture() {
  scripts\mp\playeractions::registeractionset("vehicleCapture", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function light_tank_mp_activate(var0) {
  thread bctracking();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registerinstance(var0);
}

function light_tank_mp_startcapture(var0, var1, var2) {
  if(isDefined(var1)) {
    light_tank_mp_createownercaptureobject(var0, var1);
  }

  if(level.teambased) {
    light_tank_mp_createothercaptureobject(var0);
    return;
  }
}

function light_tank_mp_endcapture(var0) {
  light_tank_mp_deletecaptureobjects(var0);
}

function light_tank_mp_createownercaptureobject(var0, var1) {
  var2 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
  var3 = spawn("script_model", var2 gettagorigin("TAG_PLAYER"));
  var3 linkTo(var2);
  light_tank_mp_setupcaptureobject(var3, 0.5);
  var3.vehicle = var0;
  var0.ownercaptureobject = var3;
  thread light_tank_mp_monitorownercapture(var3, var1);
  thread light_tank_mp_monitorownercapturevisibility(var3);
  return var3;
}

function light_tank_mp_createothercaptureobject(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, "tur_bradley_mp");
  var2 = spawn("script_model", var1 gettagorigin("TAG_PLAYER"));
  var2 linkTo(var1);
  light_tank_mp_setupcaptureobject(var2, 3);
  var2.vehicle = var0;
  var0.othercaptureobject = var2;
  thread light_tank_mp_monitorothercapture(var2);
  thread light_tank_mp_monitorothercapturevisibility();
  return var2;
}

function light_tank_mp_setupcaptureobject(var0) {
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
  self.usetime = var0;
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

function light_tank_mp_monitorownercapture(var0, var1) {
  self endon("death");
  var0 endon("disconnect");
  self.vehicle = var1;

  for(;;) {
    self waittillmatch("trigger", var0);

    if(light_tank_mp_canstartcapture(var0)) {
      self.playerusing = var0;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var0);
      var2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;
      light_tank_mp_playerstopcapture(var0);

      if(istrue(var2)) {
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var1, var0);
      }

      waitframe();
    }
  }
}

function light_tank_mp_monitorothercapture(var0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(light_tank_mp_canstartcapture(var1)) {
      self.playerusing = var1;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var1);
      var2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;

      if(isDefined(var1)) {
        light_tank_mp_playerstopcapture(var1);
      }

      if(istrue(var2)) {
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var0, var1);
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

function light_tank_mp_monitorownercapturevisibility(var0) {
  self endon("death");

  while(isDefined(var0)) {
    foreach(var2 in level.players) {
      self disableplayeruse(var2);

      if(var2 == var0) {
        if(isDefined(self.playerusing)) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(var0);
          }

          continue;
        }

        if(light_tank_mp_canstartcapture(var0)) {
          self enableplayeruse(var0);
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
      foreach(var1 in level.players) {
        self disableplayeruse(var1);

        if(var1 == self.playerusing) {
          if(light_tank_mp_cankeepcapturing()) {
            self enableplayeruse(var1);
          }
        }
      }
    } else {
      foreach(var1 in level.players) {
        self disableplayeruse(var1);

        if(light_tank_mp_canstartcapture(var1)) {
          self enableplayeruse(var1);
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_canstartcapture(var0) {
  if(istrue(self.vehicle.isdestroyed)) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var0.team == "spectator") {
    return false;
  }

  if(!var0 scripts\common\utility::is_vehicle_use_allowed()) {
    return false;
  }

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(var0, self.vehicle))) {
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

function light_tank_mp_playerstartcapture(var0) {
  var0 scripts\mp\playeractions::allowactionset("vehicleCapture", 0);
  var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_playerstopcapture(var0) {
  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 scripts\mp\playeractions::allowactionset("vehicleCapture", 1);
  }

  var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

function light_tank_mp_shouldawardattacker(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  if(level.teambased && var1.team == var0.team) {
    return false;
  }

  if(isDefined(var0.owner) && var1 == var0.owner) {
    return false;
  }

  return true;
}

function bctracking() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(scripts\mp\utility\teams::isgameplayteam(self.team)) {
      var0 = scripts\common\utility::playersinsphere(self.origin, 3000);

      foreach(var2 in var0) {
        var3 = isDefined(var2) && var2 scripts\cp_mp\utility\player_utility::_isalive() && scripts\mp\utility\player::isenemy(var2);

        if(!var3) {
          continue;
        }

        var4 = anglesToForward(var2 getplayerangles());
        var5 = scripts\engine\math::anglebetweenvectors(var4, self.origin - var2.origin);

        if(isDefined(var5) && var5 <= 60) {
          if(self sightconetrace(var2 getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

function light_tank_mp_spawncallback(var0, var1) {
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var0);

  if(!isDefined(var0.spawnmethod)) {
    var0.spawnmethod = "place_at_position_unsafe";
  }

  if(!isDefined(var0.showheadicon)) {
    var0.showheadicon = 0;
  }

  var0.cantimeout = 0;
  var2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &light_tank_mp_ondeathrespawncallback;
  }

  return var2;
}

function light_tank_mp_ondeathrespawncallback() {
  thread light_tank_mp_waitandspawn();
}

function light_tank_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("light_tank", var1, var2);

  if(isDefined(var3)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      if(scripts\mp\flags::gameflag("prematch_done")) {
        scripts\mp\gametypes\arm::droptank_playincomingdialog(var1);
      }

      if(istrue(level.ref_13377)) {
        scripts\mp\gametypes\arm::ref_1413b(var3, var3.team);
      }

      foreach(var5 in level.players) {
        if(var5.team == var3.team) {
          var5 scripts\mp\utility\lower_message::setlowermessageomnvar(62, undefined, 5);
        }
      }

      return;
    }

    return;
  }
}

function light_tank_mp_filterdropspawns(var0) {
  var1 = var0;

  if(isDefined(level.vehspawnvol)) {
    var1 = [];

    foreach(var3 in var0) {
      if(ispointinvolume(var3.origin, level.vehspawnvol)) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function light_tank_mp_getdropspawnignorelist(var0) {
  var1 = [];
  GscBinSkip0(0x2e, var1.size, var0);
}