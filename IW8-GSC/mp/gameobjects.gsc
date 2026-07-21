/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gameobjects.gsc
***********************************************/

main(var_0) {
  var_0[var_0.size] = "_encstr_847C0F309F4AB9D5DA3AB02F56C2214194";
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest()) {
      if(var_3 scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_isvehiclespawnStruct())
        continue;
    }

    var_4 = var_3.script_gameobjectname;

    if(isDefined(var_4)) {
      var_5 = 0;

      if(getsubstr(var_4, 0, 1) == "_encstr_AD4C0212") {
        var_4 = getsubstr(var_4, 1);
        var_5 = 1;
      }

      var_6 = 0;
      var_7 = strtok(var_4, "_encstr_974C0246");

      for(var_8 = 0; var_8 < var_0.size; var_8++) {
        for(var_9 = 0; var_9 < var_7.size; var_9++) {
          if(var_7[var_9] == var_0[var_8]) {
            var_6 = 1;
            break;
          }
        }

        if(var_6) {
          break;
        }
      }

      if(var_5) {
        if(var_6)
          var_3 delete();
      } else if(!var_6)
        var_3 delete();
    }

    if(!scripts\mp\spawnlogic::generatinglosdata()) {
      var_4 = var_3.script_noteworthy;

      if(isDefined(var_4)) {
        if(level._id_11AD3 == 1) {
          if(var_4 == "_encstr_B27706C1CF833659")
            continue;
          else if(var_4 == "_encstr_8A1804CF18C5")
            var_3 delete();

          continue;
        }

        if(var_4 == "_encstr_8A1804CF18C5")
          continue;
        else if(var_4 == "_encstr_B27706C1CF833659")
          var_3 delete();
      }
    }
  }
}

init() {
  level.numgametypereservedobjectives = 0;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level thread getleveltriggers();
}

onplayerspawned() {
  if(isbot(self))
    level.botsenabled = 1;

  var_0 = !istrue(level.disableinitplayergameobjects);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B41904BB8593")
    var_0 = 0;

  if(getdvarint("_encstr_8DEE1E3EEB43665D4DBBB880C0E61379DF92CABD43E34F813613B020587DD393", 0) == 1)
    var_0 = 1;

  if(var_0) {
    if(isDefined(self.gameobject_fauxspawn))
      self.gameobject_fauxspawn = undefined;
    else
      init_player_gameobjects();
  }
}

init_player_gameobjects() {
  thread ondeathordisconnect();
  self.touchtriggers = [];
  self.carryobject = undefined;
  self.canpickupobject = 1;
  self.initialized_gameobject_vars = 1;
}

ondeathordisconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  _ondeathordisconnectinternal();
}

_ondeathordisconnectinternal() {
  if(isDefined(self.carryobject))
    self.carryobject thread setdropped();
}

onjuggernaut() {
  waittillframeend;

  if(isDefined(self.carryobject)) {
    self.carryobject thread setdropped();
    self switchtoweapon(scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle());
  }
}

createtrackedobject(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 = spawnStruct();
  var_3.type = "_encstr_935F0C1B58279C2FD31335AC6C1D";
  var_3.carrier = var_0;
  var_3.curorigin = var_0.origin;
  var_3.entnum = var_2 getentitynumber();
  var_3.ownerteam = var_0.team;
  var_3.offset3d = var_1;
  var_3.triggertype = "_encstr_8BBA05185F8B99";
  var_3.compassicons = [];
  var_3.objidpingfriendly = 0;
  var_3.objidpingenemy = 0;
  var_3.carriervisible = 0;
  var_3.visibleteam = "_encstr_8BBA05185F8B99";
  var_3 requestid(1, 1);
  var_3 thread updatecarryobjectorigin();
  var_3 thread deletetrackedobjectoncarrierdisconnect();
  return var_3;
}

deletetrackedobjectoncarrierdisconnect() {
  self.carrier waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  deletetrackedobject();
}

deletetrackedobject() {
  if(self.type != "_encstr_935F0C1B58279C2FD31335AC6C1D") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0.carrier = undefined;
  var_0.curorigin = undefined;
  var_0.entnum = undefined;
  var_0.ownerteam = undefined;
  var_0.compassicons = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  releaseid();
  self notify("_encstr_AC7C1348F71DC1B742C4E5FE5BC9F989749F58C04B");
}

createcarryobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "_encstr_935F0C1B58279C2FD31335AC6C1D";
  var_6.curorigin = var_1.origin;
  var_6.ownerteam = var_0;
  var_6.useifproximity = var_4;
  var_6.entnum = var_1 getentitynumber();

  if(issubstr(var_1.classname, "_encstr_AB19049D0FC0"))
    var_6.triggertype = "_encstr_AB19049D0FC0";
  else
    var_6.triggertype = "_encstr_83650AB19BA26B100D3CE35A";

  var_1.gameobject = var_6;
  var_1.baseorigin = var_1.origin;
  var_6.trigger = var_1;

  if(!isDefined(var_1.linktoenabledflag)) {
    var_1.linktoenabledflag = 1;
    var_1 enablelinkTo();
  }

  var_6.useweapon = undefined;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_6.offset3d = var_3;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_2[var_7].baseorigin = var_2[var_7].origin;
    var_2[var_7].baseangles = var_2[var_7].angles;
  }

  var_6.visuals = var_2;
  var_6.compassicons = [];
  var_6.objidpingfriendly = 0;
  var_6.objidpingenemy = 0;

  if(!isDefined(var_5))
    var_6 requestid(1, 1);

  var_6.carrier = undefined;
  var_6.isresetting = 0;
  var_6.interactteam = "_encstr_8BBA05185F8B99";
  var_6.allowweapons = 0;
  var_6.carriervisible = 0;
  var_6.visibleteam = "_encstr_8BBA05185F8B99";
  var_6.carryicon = undefined;
  var_6.ondrop = undefined;
  var_6.onpickup = undefined;
  var_6.onreset = undefined;
  var_6._id_12355 = [];

  if(var_6.triggertype == "_encstr_AB19049D0FC0")
    var_6 thread carryobjectusethink();
  else {
    var_6.curprogress = 0;
    var_6.teamprogress = [];
    var_6.teamprogress["_encstr_8BBA05185F8B99"] = 0;
    var_6.usetime = 0;
    var_6.userate = 0;
    var_6.useratemultiplier = 1.0;
    var_6.mustmaintainclaim = 0;
    var_6.cancontestclaim = 0;
    var_6.teamusetimes = [];
    var_6.teamusetexts = [];
    var_6.numtouching["_encstr_A7A408B9CA5D1D4E2C63"] = 0;
    var_6.touchlist["_encstr_A7A408B9CA5D1D4E2C63"] = [];
    var_6.numtouching["_encstr_8BBA05185F8B99"] = 0;
    var_6.touchlist["_encstr_8BBA05185F8B99"] = [];

    foreach(var_9 in level.teamnamelist) {
      var_6.teamprogress[var_9] = 0;
      var_6.numtouching[var_9] = 0;
      var_6.touchlist[var_9] = [];
    }

    var_6.claimteam = "_encstr_8BBA05185F8B99";
    var_6.claimplayer = undefined;
    var_6.lastclaimteam = "_encstr_8BBA05185F8B99";
    var_6.lastclaimtime = 0;
    var_6 thread carryobjectproxthink();
  }

  var_6 thread updatecarryobjectorigin();
  return var_6;
}

_id_12B13(var_0) {
  self._id_12355[self._id_12355.size] = var_0;
}

getfullweaponobjfromscriptablename(var_0) {
  var_1 = 1;

  foreach(var_3 in self._id_12355)
  var_1 = var_1 &[[var_3]](var_0);

  return var_1;
}

deletecarryobject() {
  if(self.type != "_encstr_935F0C1B58279C2FD31335AC6C1D") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0.curorigin = undefined;
  var_0.ownerteam = undefined;
  var_0.entnum = undefined;
  var_0.triggertype = undefined;
  var_0.trigger unlink();
  var_0.trigger = undefined;
  var_0.useweapon = undefined;
  var_0.offset3d = undefined;

  foreach(var_2 in var_0.visuals)
  var_2 delete();

  var_0.visuals = undefined;
  var_0.compassicons = undefined;
  var_0.objidpingfriendly = undefined;
  var_0.objidpingenemy = undefined;
  var_0.objpingdelay = undefined;
  releaseid();
  var_0.carrier = undefined;
  var_0.isresetting = undefined;
  var_0.interactteam = undefined;
  var_0.allowweapons = undefined;
  var_0.keepprogress = undefined;
  var_0.carriervisible = undefined;
  var_0.visibleteam = undefined;
  var_0.carryicon = undefined;
  var_0.ondrop = undefined;
  var_0.onpickup = undefined;
  var_0.onreset = undefined;
  var_0.curprogress = undefined;
  var_0.usetime = undefined;
  var_0.userate = undefined;
  var_0.useratemultiplier = 1.0;
  var_0.mustmaintainclaim = undefined;
  var_0.cancontestclaim = undefined;
  var_0.teamusetimes = undefined;
  var_0.teamusetexts = undefined;
  var_0.numtouching = undefined;
  var_0.touchlist = undefined;
  var_0.claimteam = undefined;
  var_0.claimplayer = undefined;
  var_0.lastclaimteam = undefined;
  var_0.lastclaimtime = undefined;
  var_0 notify("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_8BE208E31FA8E1631D65");
}

carryobjectusethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 ismeleeing()) {
      continue;
    }
    var_1 = var_0 getcurrentweapon();

    if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1.basename)) {
      continue;
    }
    if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_2.basename))
        continue;
    }

    if(istrue(var_0.inlaststand)) {
      continue;
    }
    if(self.isresetting) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["_encstr_8AEF05472BC2D6"], var_0)) {
      continue;
    }
    if(!var_0.canpickupobject) {
      continue;
    }
    if(isDefined(var_0.nopickuptime) && var_0.nopickuptime > gettime()) {
      continue;
    }
    if(!isDefined(var_0.initialized_gameobject_vars)) {
      continue;
    }
    if(!unset_relic_bang_and_boom() && var_0 scripts\mp\utility\weapon::grenadeinpullback()) {
      var_3 = var_0 getheldoffhand();

      if(!scripts\mp\utility\weapon::isgesture(var_3))
        continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!proxtriggerlos(var_0)) {
      continue;
    }
    setpickedup(var_0);
  }
}

carryobjectproxthink() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7" || istrue(self.useifproximity))
    thread carryobjectusethink();
  else
    thread carryobjectproxthinkdelayed();
}

carryobjectproxthinkdelayed() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.trigger))
    self.trigger endon("_encstr_8DD610AD1F709FB77CF90AB2EDC6AB571BC1");

  thread proxtriggerthink();

  for(;;) {
    if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
      self.curprogress = 0.0;
      self.teamprogress[self.claimteam] = self.curprogress;
      var_0 = getearliestclaimplayer();
      setclaimteam("_encstr_8BBA05185F8B99");
      self.claimplayer = undefined;

      if(isDefined(self.onenduse))
        self[[self.onenduse]](getlastclaimteam(), var_0, isDefined(var_0));

      if(isDefined(var_0))
        setpickedup(var_0);
    }

    if(self.claimteam != "_encstr_8BBA05185F8B99") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("_encstr_8BBA05185F8B99");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse))
            self[[self.onenduse]](getlastclaimteam(), self.claimplayer, 0);
        } else {
          self.curprogress = self.curprogress + level.frameduration * self.userate;
          self.teamprogress[self.claimteam] = self.curprogress;
          var_1 = scripts\mp\utility\teams::getenemyteams(self.claimteam);

          foreach(var_3 in var_1) {
            if(self.ownerteam != var_3)
              self.teamprogress[var_3] = 0;
          }

          if(isDefined(self.onuseupdate))
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
        }
      } else {
        if(scripts\mp\utility\player::isreallyalive(self.claimplayer))
          setpickedup(self.claimplayer);

        setclaimteam("_encstr_8BBA05185F8B99");
        self.claimplayer = undefined;
      }
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

pickupobjectdelay(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.canpickupobject = 0;

  if(isDefined(var_0.ballindex))
    var_1 = 1024;
  else
    var_1 = 4096;

  for(;;) {
    if(distancesquared(self.origin, var_0.trigger.origin) > var_1) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

setpickedup(var_0, var_1, var_2) {
  if(isai(var_0) && isDefined(var_0.owner)) {
    return;
  }
  if(isDefined(var_0.carryobject) || isDefined(self.carryweapon) && !var_0 scripts\common\utility::is_weapon_allowed() || !getfullweaponobjfromscriptablename(var_0)) {
    if(isDefined(self.onpickupfailed))
      self[[self.onpickupfailed]](var_0);

    return;
  }

  var_0 giveobject(self);
  setcarrier(var_0);

  if(isDefined(self.trigger getlinkedparent())) {
    for(var_3 = 0; var_3 < self.visuals.size; var_3++)
      self.visuals[var_3] unlink();

    self.trigger unlink();
  }

  for(var_3 = 0; var_3 < self.visuals.size; var_3++)
    self.visuals[var_3] hide();

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self notify("_encstr_AD740E37543ADFAB708788F84BBDA129");

  if(isDefined(self.onpickup))
    self[[self.onpickup]](var_0, var_1, var_2);
}

updatecurorigin() {
  self endon("_encstr_AC7C1348F71DC1B742C4E5FE5BC9F989749F58C04B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.trigger))
    self.trigger endon("_encstr_8DD610AD1F709FB77CF90AB2EDC6AB571BC1");

  if(scripts\mp\utility\game::getgametype() == "_encstr_AA5606FD1AF05085")
    self.carrier endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
      self.curcarrierorigin = self.carrier.origin;
    } else {
      self.curorigin = self.trigger.origin;
      self.curcarrierorigin = undefined;
    }

    waitframe();
  }
}

updatecarryobjectorigin() {
  self endon("_encstr_AC7C1348F71DC1B742C4E5FE5BC9F989749F58C04B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.trigger))
    self.trigger endon("_encstr_8DD610AD1F709FB77CF90AB2EDC6AB571BC1");

  thread updatecurorigin();

  if(!isDefined(self.objpingdelay))
    self.objpingdelay = 4.0;

  for(;;) {
    if(self.objpingdelay == 0) {
      break;
    }

    if(isDefined(self.carrier)) {
      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "_encstr_ACFC091AE8AB2FCBE15119" || self.visibleteam == "_encstr_9A19040BCDBC") && !isfriendlyteam(var_1) && self.objidpingfriendly) {
          if(self.showworldicon) {
            if(isDefined(self.pingobjidnum)) {
              scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.curorigin);

              if(istrue(self.pingplayers))
                objective_setpings(self.pingobjidnum, 1);
              else
                objective_setpingsforteam(self.pingobjidnum, var_1);

              objective_ping(self.pingobjidnum);
              continue;
            }

            if(istrue(self.pingplayers))
              objective_setpings(self.objidnum, 1);
            else
              objective_setpingsforteam(self.objidnum, var_1);

            objective_ping(self.objidnum);
          }
        }
      }

      foreach(var_1 in level.teamnamelist) {
        if((self.visibleteam == "_encstr_88BF06FD784A6393" || self.visibleteam == "_encstr_9A19040BCDBC") && isfriendlyteam(var_1) && self.objidpingenemy) {
          if(self.showworldicon) {
            if(isDefined(self.pingobjidnum)) {
              scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.curorigin);

              if(istrue(self.pingplayers))
                objective_setpings(self.pingobjidnum, 1);
              else
                objective_setpingsforteam(self.pingobjidnum, var_1);

              objective_ping(self.pingobjidnum);
              continue;
            }

            if(istrue(self.pingplayers))
              objective_setpings(self.objidnum, 1);
            else
              objective_setpingsforteam(self.objidnum, var_1);

            objective_ping(self.objidnum);
          }
        }
      }

      scripts\engine\utility::_id_143C0(self.objpingdelay, "_encstr_88C60846397B83835919", "_encstr_88F20627959BCAE8");
      continue;
    }

    waitframe();
  }
}

hidecarryiconongameend() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;
}

gameobjects_getcurrentprimaryweapon() {
  var_0 = self getcurrentweapon();
  var_1 = self getcurrentprimaryweapon();
  var_2 = var_1 getaltweapon();

  if(var_2 == var_0)
    return var_0;

  return var_1;
}

watchcarryobjectweaponswitch(var_0) {
  self endon("_encstr_A7ED0CEFAFDFAA37F8318DD2E918");
  var_1 = gettime();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);

  if(isDefined(var_2)) {
    if(var_2 == 0) {
      if(var_1 == gettime())
        waittillframeend;

      if(isDefined(self.carryobject))
        self.carryobject thread setdropped();
    }
  }
}

giveobject(var_0) {
  self.carryobject = var_0;
  thread trackcarrier();

  if(isDefined(var_0.carryweapon)) {
    var_0.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
    var_0.carrierhascarryweaponinloadout = self hasweapon(var_0.carryweapon);

    if(isDefined(var_0.carryweaponthink))
      self thread[[var_0.carryweaponthink]]();

    self giveweapon(var_0.carryweapon);
    thread watchcarryobjectweaponswitch(var_0.carryweapon);
    self disableweaponpickup();
    scripts\common\utility::allow_weapon_switch(0);
  } else if(!var_0.allowweapons) {
    scripts\common\utility::allow_weapon(0);
    thread manualdropthink();
  }

  if(isDefined(var_0.carryicon)) {
    if(level.splitscreen) {
      self.carryicon = scripts\mp\hud_util::createicon(var_0.carryicon, 33, 33);
      self.carryicon scripts\mp\hud_util::setpoint("_encstr_92D20C1DD7833128BF86F4DD0833", "_encstr_92D20C1DD7833128BF86F4DD0833", -50, -78);
    } else {
      self.carryicon = scripts\mp\hud_util::createicon(var_0.carryicon, 50, 50);
      self.carryicon scripts\mp\hud_util::setpoint("_encstr_92D20C1DD7833128BF86F4DD0833", "_encstr_92D20C1DD7833128BF86F4DD0833", 175, -30);
    }

    self.carryicon.hidewheninmenu = 1;
    thread hidecarryiconongameend();
  }
}

returnhome() {
  self.isresetting = 1;
  self notify("_encstr_88F20627959BCAE8");

  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    var_1 = self.visuals[var_0] getlinkedparent();

    if(isDefined(var_1))
      self.visuals[var_0] unlink();

    if(isbombmode() && self.visuals[var_0].targetname == "_encstr_9B1308E20DFF6227E040") {
      self.visuals[var_0].origin = level.bombrespawnpoint;
      self.visuals[var_0].angles = level.bombrespawnangles;
    } else {
      self.visuals[var_0].origin = self.visuals[var_0].baseorigin;
      self.visuals[var_0].angles = self.visuals[var_0].baseangles;
    }

    self.visuals[var_0] show();
  }

  var_1 = self.trigger getlinkedparent();

  if(isDefined(var_1))
    self.trigger unlink();

  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isDefined(self.onreset))
    self[[self.onreset]]();

  clearcarrier();
  updatecompassicons();
  self.isresetting = 0;
  self notify("_encstr_A6F70B83ED07C20BDE7FB01079");
}

ishome() {
  if(isDefined(self.carrier))
    return 0;

  if(self.curorigin != self.trigger.baseorigin)
    return 0;

  return 1;
}

setposition(var_0, var_1) {
  self.isresetting = 1;

  for(var_2 = 0; var_2 < self.visuals.size; var_2++) {
    self.visuals[var_2].origin = var_0;
    self.visuals[var_2].angles = var_1;
    self.visuals[var_2] show();
  }

  self.trigger.origin = var_0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    self.trigger linkTo(self.visuals[0]);

  self.curorigin = self.trigger.origin;
  clearcarrier();
  updatecompassicons();
  self.isresetting = 0;
}

carryobject_overridemovingplatformdeath(var_0) {
  for(var_1 = 0; var_1 < var_0.carryobject.visuals.size; var_1++)
    var_0.carryobject.visuals[var_1] unlink();

  var_0.carryobject.trigger unlink();
  var_0.carryobject thread setdropped(1);
}

setdropped(var_0, var_1) {
  if(isDefined(self.setdropped)) {
    if([[self.setdropped]]())
      return;
  }

  self.isresetting = 1;
  self.resetnow = undefined;
  self notify("_encstr_88C60846397B83835919");

  foreach(var_3 in self.visuals)
  var_3 notsolid();

  if(isDefined(self.carrier))
    var_5 = self.carrier.origin;
  else
    var_5 = self.curorigin;

  if(istrue(level.botsenabled) || touchingdroptonavmeshtrigger(var_5) || level.mapname == "_encstr_8147082D8A3F48F84548" && level.gametype == "_encstr_8E1904B3F501" && !self.carrier touchingarbitraryuptrigger())
    var_5 = getclosestpointonnavmesh(var_5);

  if(isDefined(level.bombdroploc)) {
    var_5 = level.bombdroploc;
    level.bombdroploc = undefined;
  }

  if(isDefined(var_1))
    var_6 = var_1;
  else
    var_6 = 20;

  var_7 = 4000;
  var_8 = (0, 0, 0);
  var_9 = var_5 + (0, 0, var_6);
  var_10 = var_5 - (0, 0, var_7);
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_12 = [];
  var_12[var_12.size] = self.visuals[0];

  if(isDefined(self.carrier))
    var_12[var_12.size] = self.carrier;

  if(isDefined(self.carrier) && isDefined(self.carrier.lastdroppableweaponobj))
    var_12[var_12.size] = self.carrier.lastdroppableweaponobj;

  if(isDefined(self.carrier) && self.carrier.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_13 = 8;
    var_14 = 16;

    if(scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8") {
      var_13 = 4;
      var_14 = 8;
    } else if(scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7") {
      var_13 = 2;
      var_14 = 4;
    }

    var_15 = scripts\engine\trace::capsule_trace(var_9, var_10, var_13, var_14, (0, 0, 0), var_12, var_11, 0);

    for(var_16 = 0; var_16 < 4; var_16++) {
      var_17 = var_15["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_17)) {
        if(isDefined(var_17.code_classname) && var_17.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || isDefined(var_17.objweapon) && issameweapon(var_17.objweapon) || isDefined(var_17) && istrue(var_17.issuper) && (var_17.equipmentref == "_encstr_B6820FFA831517AA4103A5BD071976473B" || var_17.equipmentref == "_encstr_AA870D15FAF37393C74318F8BB184A")) {
          var_12[var_12.size] = var_15["_encstr_850E077B0BF30318B9"];
          var_15 = scripts\engine\trace::capsule_trace(var_9, var_10, var_13, var_14, (0, 0, 0), var_12, var_11, 0);
        }

        continue;
      }

      break;
    }
  } else {
    var_15 = scripts\engine\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), var_12, var_11, 0);

    if(isPlayer(var_15["_encstr_850E077B0BF30318B9"]))
      var_15["_encstr_850E077B0BF30318B9"] = undefined;

    if(isDefined(var_15["_encstr_850E077B0BF30318B9"]) && isDefined(var_15["_encstr_850E077B0BF30318B9"].code_classname) && var_15["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_12[var_12.size] = var_15["_encstr_850E077B0BF30318B9"];
      var_15 = scripts\engine\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), var_12, var_11, 0);
    }
  }

  foreach(var_3 in self.visuals)
  var_3 solid();

  var_20 = self.carrier;
  var_21 = 0;

  if(isDefined(var_15)) {
    var_22 = randomfloat(360);
    var_23 = var_15["_encstr_BD260953AA97E3F014279D"];

    if(isDefined(self.visualgroundoffset))
      var_23 = var_23 + self.visualgroundoffset;

    var_24 = (cos(var_22), sin(var_22), 0);
    var_24 = vectorNormalize(var_24 - var_15["_encstr_820E07FAE8780B3A4C"] * vectordot(var_24, var_15["_encstr_820E07FAE8780B3A4C"]));
    var_25 = 0;

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7" || isbombmode()) {
      var_26 = (0, 0, 0);

      if(scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8") {
        var_26 = vectortoangles(var_24);
        var_26 = var_26 + (90, 0, 0);
      }
    } else
      var_26 = vectortoangles(var_24);

    for(var_27 = 0; var_27 < self.visuals.size; var_27++) {
      self.visuals[var_27].origin = var_23;
      self.visuals[var_27].angles = var_26;
      self.visuals[var_27] show();
    }

    self.trigger.origin = var_23 + (0, 0, var_25);
    self.curorigin = self.trigger.origin;
    var_28 = undefined;
    var_17 = var_15["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_17) && !isPlayer(var_17) && !issameweapon(var_17) && (isDefined(var_17.objweapon) && !issameweapon(var_17.objweapon)) && !isbot(var_17) && !isagent(var_17) && !scripts\mp\utility\entity::isturret(var_17) && (!isDefined(var_17.classname) || var_17.classname != "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && var_17.classname != "_encstr_8D8A07F05F6987BF4B"))
      var_28 = var_15["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_17) && istrue(var_17.issuper)) {
      for(var_27 = 0; var_27 < self.visuals.size; var_27++)
        self.visuals[var_27] linkTo(var_17);

      thread _id_143FB(var_17);
    }

    if(isDefined(var_28) && isDefined(var_28.owner)) {
      var_29 = var_28 getlinkedparent();

      if(isDefined(var_29))
        var_28 = var_29;
    }

    if(isDefined(var_28)) {
      if(isDefined(var_28.invalid_gameobject_mover) && var_28.invalid_gameobject_mover == 1)
        self.resetnow = 1;
      else {
        for(var_27 = 0; var_27 < self.visuals.size; var_27++)
          self.visuals[var_27] linkTo(var_28);

        self.trigger linkTo(var_28);
        var_30 = spawnStruct();
        var_30.carryobject = self;
        var_30.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
        self.trigger thread scripts\mp\movers::handle_moving_platforms(var_30);
      }
    }

    if(!isDefined(var_0))
      thread pickuptimeout();
  } else {
    for(var_27 = 0; var_27 < self.visuals.size; var_27++) {
      self.visuals[var_27].origin = self.visuals[var_27].baseorigin;
      self.visuals[var_27].angles = self.visuals[var_27].baseangles;
      self.visuals[var_27] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop) && !isDefined(var_0))
    self[[self.ondrop]](var_20);

  clearcarrier();

  if(isDefined(self.objidnum))
    updatecompassicons();

  self.isresetting = 0;
}

_id_143FB(var_0) {
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  var_0 waittill("_encstr_AD75063D571AE108");
  thread setdropped();
}

setcarrier(var_0) {
  self.carrier = var_0;
  thread updatevisibilityaccordingtoradar();
}

clearcarrier() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier thread takeobject(self);
  self.carrier = undefined;
  self.curcarrierorigin = undefined;
  self notify("_encstr_8D33106C0B39C996CA4EAFB136AC0BC9AC19");
}

pickuptimeout() {
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_A6F70B83ED07C20BDE7FB01079");
  waitframe();

  if(isDefined(self.resetnow)) {
    self.resetnow = undefined;
    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.radtriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.radtriggers[var_0])) {
      continue;
    }
    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.minetriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.minetriggers[var_0])) {
      continue;
    }
    returnhome();
    return;
  }

  for(var_0 = 0; var_0 < level.hurttriggers.size; var_0++) {
    if(!self.visuals[0] istouching(level.hurttriggers[var_0])) {
      continue;
    }
    returnhome();
    return;
  }

  if(istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;

    foreach(var_2 in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(var_2)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(var_2 in level.outofboundstriggers) {
      if(istrue(self.allowedintrigger)) {
        break;
      }

      if(!self.visuals[0] istouching(var_2)) {
        continue;
      }
      returnhome();
      return;
    }
  }

  if(isDefined(self.autoresettime)) {
    wait(self.autoresettime);

    if(!isDefined(self.carrier))
      returnhome();
  }
}

takeobject(var_0) {
  if(isDefined(self.carryicon))
    self.carryicon scripts\mp\hud_util::destroyelem();

  if(isDefined(self))
    self.carryobject = undefined;

  self notify("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  if(var_0.triggertype == "_encstr_83650AB19BA26B100D3CE35A")
    thread pickupobjectdelay(var_0);

  if(scripts\mp\utility\player::isreallyalive(self) && !var_0.allowweapons) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = isDefined(var_0.keepcarryweapon) && var_0.keepcarryweapon;

      if(!var_0.carrierhascarryweaponinloadout && !var_1) {
        if(isDefined(var_0.ballindex))
          wait 0.25;

        self notify("_encstr_93330E4AF0CD071A7157F9D24DF8E703");

        if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0.carryweapon))
          scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0.carryweapon);
        else
          scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.carryweapon);

        thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(self.lastdroppableweaponobj);
      } else {}

      self enableweaponpickup();
      scripts\common\utility::allow_weapon_switch(1);
    } else if(!var_0.allowweapons)
      scripts\common\utility::allow_weapon(1);
  }
}

trackcarrier() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  while(isDefined(self.carryobject) && scripts\mp\utility\player::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["_encstr_A53009A25003666B9818C6"] < 1)
        self.carryobject.safeorigin = var_0["_encstr_BD260953AA97E3F014279D"];
    }

    wait 0.05;
  }
}

manualdropthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed())
      wait 0.05;

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() || self meleeButtonPressed())
      wait 0.05;

    if(isDefined(self.carryobject) && !self useButtonPressed())
      self.carryobject thread setdropped();
  }
}

deleteuseobject() {
  releaseid();
  self.trigger delete();
  self.trigger = undefined;
  self notify("_encstr_8BE208E31FA8E1631D65");
}

createuseobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(var_1.vampirepoints))
    var_8 = var_1;
  else
    var_8 = spawnStruct();

  var_8.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_8.curorigin = var_1.origin;
  var_8.ownerteam = var_0;
  var_8.entnum = var_1 getentitynumber();
  var_8.keyobject = undefined;

  if(issubstr(var_1.classname, "_encstr_AB19049D0FC0") || istrue(var_1.usetype))
    var_8.triggertype = "_encstr_AB19049D0FC0";
  else
    var_8.triggertype = "_encstr_83650AB19BA26B100D3CE35A";

  var_1.gameobject = var_8;
  var_8.trigger = var_1;

  for(var_9 = 0; var_9 < var_2.size; var_9++) {
    var_2[var_9].baseorigin = var_2[var_9].origin;
    var_2[var_9].baseangles = var_2[var_9].angles;
  }

  var_8.visuals = var_2;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_8.offset3d = var_3;
  var_8.compassicons = [];

  if(!istrue(var_5))
    var_8 requestid(1, 1, var_4, var_6);

  var_8.interactteam = "_encstr_8BBA05185F8B99";
  var_8.visibleteam = "_encstr_8BBA05185F8B99";
  var_8.onuse = undefined;
  var_8.oncantuse = undefined;
  var_8.usetext = "_encstr_8B1608EC43B8D647A113";
  var_8.usetime = 10000;
  var_8.curprogress = 0;
  var_8.majoritycapprogress = 0;
  var_8.wasmajoritycapprogress = 0;
  var_8.stalemate = 0;
  var_8.wasstalemate = 0;
  var_8.exclusiveuse = 1;
  var_8.teamprogress = [];
  var_8.teamprogress["_encstr_8BBA05185F8B99"] = 0;

  if(var_8.triggertype == "_encstr_83650AB19BA26B100D3CE35A") {
    var_8.teamusetimes = [];
    var_8.teamusetexts = [];
    var_8.numtouching["_encstr_A7A408B9CA5D1D4E2C63"] = 0;
    var_8.touchlist["_encstr_A7A408B9CA5D1D4E2C63"] = [];
    var_8.numtouching["_encstr_8BBA05185F8B99"] = 0;
    var_8.touchlist["_encstr_8BBA05185F8B99"] = [];

    foreach(var_11 in level.teamnamelist) {
      var_8.teamprogress[var_11] = 0;
      var_8.numtouching[var_11] = 0;
      var_8.touchlist[var_11] = [];
      var_8.assisttouchlist[var_11] = [];
    }

    var_8.userate = 0;
    var_8.useratemultiplier = 1.0;
    var_8.claimteam = "_encstr_8BBA05185F8B99";
    var_8.claimplayer = undefined;
    var_8.lastclaimteam = "_encstr_8BBA05185F8B99";
    var_8.lastclaimtime = 0;
    var_8.mustmaintainclaim = 0;
    var_8.cancontestclaim = 0;

    if(isDefined(var_7))
      var_8.brking_givepoints = var_7;

    var_8 thread useobjectproxthink();
  } else {
    foreach(var_14 in level.teamnamelist)
    var_8.teamprogress[var_14] = 0;

    var_8.userate = 1;
    var_8.useratemultiplier = 1.0;
    var_8 thread useobjectusethink();
  }

  return var_8;
}

createholduseobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_4.curorigin = var_1.origin;
  var_4.ownerteam = var_0;
  var_4.entnum = var_1 getentitynumber();
  var_4.keyobject = undefined;
  var_4.triggertype = "_encstr_AB19049D0FC0";
  var_1.gameobject = var_4;
  var_4.trigger = var_1;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangles = var_2[var_5].angles;
  }

  var_4.visuals = var_2;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_4.offset3d = var_3;
  var_4.compassicons = [];
  var_4.interactteam = "_encstr_8BBA05185F8B99";
  var_4.visibleteam = "_encstr_8BBA05185F8B99";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.usetext = "_encstr_8B1608EC43B8D647A113";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.exclusiveuse = 1;
  var_4.teamprogress = [];
  var_4.teamprogress["_encstr_8BBA05185F8B99"] = 0;

  foreach(var_7 in level.teamnamelist)
  var_4.teamprogress[var_7] = 0;

  var_4.userate = 1;
  var_4.useratemultiplier = 1.0;
  var_4 thread useobjectusethink();
  return var_4;
}

createdynamicholduseobject(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_4.curorigin = var_1;
  var_4.ownerteam = var_0;
  var_4.keyobject = undefined;
  var_4.triggertype = "_encstr_AB19049D0FC0";

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5].baseorigin = var_2[var_5].origin;
    var_2[var_5].baseangles = var_2[var_5].angles;
  }

  var_4.visuals = var_2;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_4.offset3d = var_3;
  var_4.compassicons = [];
  var_4.interactteam = "_encstr_8BBA05185F8B99";
  var_4.visibleteam = "_encstr_8BBA05185F8B99";
  var_4.onuse = undefined;
  var_4.oncantuse = undefined;
  var_4.usetext = "_encstr_8B1608EC43B8D647A113";
  var_4.usetime = 10000;
  var_4.curprogress = 0;
  var_4.stalemate = 0;
  var_4.wasstalemate = 0;
  var_4.exclusiveuse = 1;
  var_4.teamprogress = [];
  var_4.teamprogress["_encstr_8BBA05185F8B99"] = 0;

  foreach(var_7 in level.teamnamelist)
  var_4.teamprogress[var_7] = 0;

  var_4.userate = 1;
  var_4.useratemultiplier = 1.0;
  var_2[0] makeusable();
  var_2[0] thread usedynamicobjectusethink();
  return var_4;
}

setkeyobject(var_0) {
  self.keyobject = var_0;
}

usedynamicobjectusethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["_encstr_8AEF05472BC2D6"], var_0)) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }
    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_0))
        continue;
    }

    if(isDefined(self.keyobject) && (!isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](var_0);

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }
    if(!var_0 scripts\common\utility::is_weapon_allowed()) {
      continue;
    }
    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(var_0);
      continue;
    }

    useholdloop(var_0);
  }
}

useobjectusethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["_encstr_8AEF05472BC2D6"], var_0)) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon()) && !istrue(var_0.isjuggernaut)) {
      continue;
    }
    if(isDefined(level._id_11C89)) {
      if(![[level._id_11C89]](var_0))
        continue;
    }

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_0))
        continue;
    }

    if(isDefined(self.keyobject) && (!isDefined(var_0.carryobject) || var_0.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](var_0);

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }
    if(!var_0 scripts\common\utility::is_weapon_allowed()) {
      continue;
    }
    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(var_0);
      continue;
    }

    useholdloop(var_0);
  }
}

useholdloop(var_0) {
  var_1 = 1;

  if(self.usetime > 0) {
    if(isDefined(self.onbeginuse)) {
      var_0 updateuiprogress(self, 0);
      self[[self.onbeginuse]](var_0);
    }

    if(!isDefined(self.keyobject))
      thread cantusehintthink();

    var_2 = var_0.pers["_encstr_8AEF05472BC2D6"];
    var_1 = useholdthink(var_0);
    self notify("_encstr_A12F0D50C70E70BFD21775906B1BEB");

    if(isDefined(self.onenduse))
      self[[self.onenduse]](var_2, var_0, var_1);
  }

  if(var_1) {
    if(isDefined(self.onuse))
      self[[self.onuse]](var_0);
  }
}

checkobjectiskeyobject(var_0) {
  var_1 = self.keyobject;

  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_3 in var_1) {
    if(var_3 istouching(self.trigger))
      return 1;
  }

  return 0;
}

checkplayercarrykeyobject(var_0) {
  var_1 = self.keyobject;

  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_3 in var_1) {
    if(var_3 == var_0.carryobject)
      return 1;
  }

  return 0;
}

cantusehintthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self endon("_encstr_A12F0D50C70E70BFD21775906B1BEB");

  if(!isDefined(self.trigger)) {
    return;
  }
  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!caninteractwith(var_0.pers["_encstr_8AEF05472BC2D6"], var_0)) {
      continue;
    }
    if(isDefined(self.oncantuse))
      self[[self.oncantuse]](var_0);
  }
}

getearliestclaimplayer() {
  var_0 = self.claimteam;
  var_1 = self.claimplayer;

  if(isDefined(self.playerzombiedestroyhud) && istrue(self.getinventoryslotvo)) {
    if(self.playerzombiedestroyhud[var_0].size > 0) {
      var_2 = undefined;
      var_3 = getarraykeys(self.playerzombiedestroyhud[var_0]);

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = self.playerzombiedestroyhud[var_0][var_3[var_4]];

        if(scripts\mp\utility\player::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
          var_1 = var_5.player;
          var_2 = var_5.starttime;
        }
      }
    }

    self.getinventoryslotvo = 0;
    level endon("_encstr_A2FA163B83B8D3C1A0E35C53E908D5C7C8FBA30249045F42");
    return var_1;
  }

  if(isDefined(self.touchlist[var_0]) && self.touchlist[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self.touchlist[var_0]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self.touchlist[var_0][var_3[var_4]];

      if(scripts\mp\utility\player::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
        var_1 = var_5.player;
        var_2 = var_5.starttime;
      }
    }
  }

  return var_1;
}

isteamtouching() {
  var_0 = "_encstr_8BBA05185F8B99";

  foreach(var_2 in level.teamnamelist) {
    if(self.numtouching[var_2]) {
      var_0 = var_2;
      break;
    }
  }

  return var_0 != "_encstr_8BBA05185F8B99";
}

useobjectproxthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  thread proxtriggerthink();

  if(!isDefined(self.ignorestomp))
    self.ignorestomp = 0;

  for(;;) {
    if(self.interactteam == "_encstr_8BBA05185F8B99") {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      continue;
    }

    self.wasuncontested = 0;

    if(self.cancontestclaim) {
      if(self.stalemate != self.wasstalemate) {
        if(self.stalemate) {
          if(isDefined(self.oncontested))
            self[[self.oncontested]]();
        } else {
          var_0 = "_encstr_8BBA05185F8B99";

          foreach(var_2 in level.teamnamelist) {
            if(self.numtouching[var_2]) {
              var_0 = var_2;
              break;
            }
          }

          if(var_0 == "_encstr_8BBA05185F8B99" && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
            var_0 = self.ownerteam;

          setclaimteam("_encstr_8BBA05185F8B99");
          self.claimplayer = undefined;

          foreach(var_0 in level.teamnamelist) {
            if(self.touchlist[var_0].size) {
              var_5 = self.touchlist[var_0];
              var_6 = getarraykeys(var_5);

              for(var_7 = 0; var_7 < var_6.size; var_7++) {
                var_8 = var_5[var_6[var_7]].player;
                var_8 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
              }

              break;
            }
          }

          if(isDefined(self.onuncontested))
            self[[self.onuncontested]](var_0);

          self.wasuncontested = 1;
        }

        self.wasstalemate = self.stalemate;
      }

      if(!self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress)
        self.wasmajoritycapprogress = self.majoritycapprogress;
    }

    if(!self.stalemate && !self.majoritycapprogress && !self.wasuncontested) {
      if(self.mustmaintainclaim && !istrue(self.isunoccupied)) {
        if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam]) {
          if(isDefined(self.onunoccupied))
            self[[self.onunoccupied]]();

          self.isunoccupied = 1;
          setclaimteam("_encstr_8BBA05185F8B99");
          self.claimplayer = undefined;
        } else if(self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          if(!isteamtouching()) {
            if(isDefined(self.onunoccupied))
              self[[self.onunoccupied]]();

            self.isunoccupied = 1;
            setclaimteam("_encstr_8BBA05185F8B99");
            self.claimplayer = undefined;
          } else if(isDefined(self.numtouchrequireduse))
            self[[self.numtouchrequireduse]](self.claimplayer.team);
        }
      } else if(!istrue(self.isunoccupied) && isDefined(self.onunoccupied)) {
        var_0 = "_encstr_8BBA05185F8B99";

        foreach(var_2 in level.teamnamelist) {
          if(self.numtouching[var_2]) {
            var_0 = var_2;
            break;
          }
        }

        if(var_0 == "_encstr_8BBA05185F8B99") {
          self.isunoccupied = 1;
          self[[self.onunoccupied]]();
        }
      }
    }

    var_12 = 1;

    if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
      var_12 = 0;

    if(self.claimteam != "_encstr_8BBA05185F8B99" && var_12) {
      if(!self.usetime) {
        if(!self.stalemate) {
          var_13 = getearliestclaimplayer();
          setclaimteam("_encstr_8BBA05185F8B99");
          self.claimplayer = undefined;

          if(isDefined(self.onuse))
            self[[self.onuse]](var_13);
        }
      } else if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
        self.curprogress = 0.0;
        self.teamprogress[self.claimteam] = self.curprogress;
        var_13 = getearliestclaimplayer();
        setclaimteam("_encstr_8BBA05185F8B99");
        self.claimplayer = undefined;

        if(isDefined(self.onenduse))
          self[[self.onenduse]](self.claimteam, var_13, isDefined(var_13));

        if(isDefined(var_13) && isDefined(self.onuse))
          self[[self.onuse]](var_13);
      } else if(!self.stalemate && self.usetime && (self.ownerteam != self.claimteam || istrue(self.majoritycapprogress))) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("_encstr_8BBA05185F8B99");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse))
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);
        } else if(canstompprogresswithstalemate(self.claimteam) && self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          if(self.lastclaimteam == self.claimteam && istrue(self.majoritycapprogress)) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63" && self.lastclaimteam != self.claimteam) {
          if(self.lastclaimteam != self.claimteam) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == self.claimteam) {
          if(isDefined(self.lastprogressteam) && self.lastprogressteam == self.claimteam && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
          else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
        } else if(self.ownerteam != self.claimteam) {
          self.setblocking = 0;
          self.setdefending = 0;
          applycaptureprogressanduseupdate();
        } else if(self.ownerteam == self.claimteam && istrue(self.majoritycapprogress)) {
          var_14 = getnumtouchingexceptteam(self.claimteam);

          if(var_14 && !istrue(self.setblocking)) {
            self.setblocking = 1;
            self.setdefending = 0;
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F");
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E");
          } else if(!var_14 && !istrue(self.setdefending)) {
            self.setblocking = 0;
            self.setdefending = 1;
            setobjectivestatusicons(level.icondefending, level.iconcapture);
          }
        }
      }
    } else if(canstompprogress(self.ownerteam) && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
      stompenemyteamprogress(self.ownerteam);

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

canstompprogress(var_0) {
  return !istrue(self.ignorestomp) && self.touchlist[var_0].size > 0 && !istrue(self.stalemate) && self.curprogress > 0;
}

canstompprogresswithstalemate(var_0) {
  return !istrue(self.ignorestomp) && self.touchlist[var_0].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

applycaptureprogressanduseupdate() {
  if(isDefined(self._id_128B9)) {
    var_0 = self[[self._id_128B9]](1);

    if(!var_0)
      return;
  }

  applycaptureprogress(self.claimteam, level.frameduration * self.userate);

  if(isDefined(self.onuseupdate))
    self[[self.onuseupdate]](self.claimteam, self.teamprogress[self.claimteam] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);

  if(isDefined(self._id_12079))
    self[[self._id_12079]](1);
}

stompenemyteamprogress(var_0) {
  if(isDefined(self._id_138B2))
    self[[self._id_138B2]](var_0);

  var_1 = level.frameduration * self.userate;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0);

  foreach(var_4 in var_2) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      if(var_5 < var_1) {
        self.teamprogress[var_4] = 0;
        self.curprogress = self.teamprogress[var_4];
        scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
        scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
        var_1 = var_1 - var_5;
        continue;
      }

      self.isunoccupied = 0;
      self.teamprogress[var_4] = self.teamprogress[var_4] - var_1;
      var_1 = 0;
      self.curprogress = self.teamprogress[var_4];
      scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_4);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "_encstr_8D3421A982AF25E48E28A6A2AFE972312BCB3D2449EB0DC415A02592E41DAFD0A028A6");
    }
  }

  if(self.curprogress <= 0) {
    foreach(var_8 in self.touchlist[self.ownerteam]) {
      if(isDefined(self.stompprogressreward))
        [[self.stompprogressreward]](var_8.player);
    }

    self.lastprogressteam = undefined;
  }
}

useobjectdecay(var_0) {
  if(getcapturebehavior() != "_encstr_820E07FAE8780B3A4C" && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B") {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self notify("_encstr_83D00F5D37B23D26359536D111AC6CB0BC");
  self endon("_encstr_83D00F5D37B23D26359536D111AC6CB0BC");
  var_1 = 0;

  for(;;) {
    waitframe();
    var_2 = self.objidnum;

    if(self.stalemate)
      var_1 = 0;

    if(self.claimteam == "_encstr_8BBA05185F8B99" || istrue(self.playerkilled_washitbyvehicle)) {
      if(self.usetime) {
        if(!self.stalemate) {
          if(istrue(self.decaygraceperiod) && var_1 < self.decaygraceperiod) {
            var_1 = var_1 + level.framedurationseconds;
            continue;
          }

          if(isDefined(self.permcapturethresholds)) {
            if(!isDefined(self.decaythreshold))
              self.decaythreshold = 0.0;

            var_3 = self.curprogress / self.usetime;

            foreach(var_5 in self.permcapturethresholds) {
              if(var_3 >= var_5 && var_5 > self.decaythreshold)
                self.decaythreshold = var_5;
            }

            if(!isDefined(self.decayrate))
              self.decayrate = self.usetime * 0.025 * level.framedurationseconds;

            if(var_3 > self.decaythreshold)
              self.curprogress = self.curprogress - self.decayrate;
          } else {
            var_7 = 1;

            if(isDefined(self.forest_barrels))
              var_7 = [[self.forest_barrels]]();

            self.curprogress = self.curprogress - 0.1 * var_7 * level.frameduration;

            if(isDefined(self._id_12079))
              self[[self._id_12079]](0);
          }
        }

        self.teamprogress[var_0] = self.curprogress;
      }

      if(self.teamprogress[var_0] <= 0) {
        self.curprogress = 0;
        self.teamprogress[var_0] = self.curprogress;
        scripts\mp\objidpoolmanager::objective_show_progress(var_2, 0);
        break;
      }

      scripts\mp\hostmigration::waittillhostmigrationdone();

      if(isDefined(self.objidnum)) {
        if(isDefined(self.overrideprogressteam)) {
          var_3 = self.teamprogress[self.overrideprogressteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_3);
        } else {
          var_3 = self.teamprogress[self.lastclaimteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_3);
        }
      }
    }
  }
}

canclaim(var_0) {
  if(isDefined(self.carrier))
    return 0;

  if(self.cancontestclaim) {
    var_1 = getnumtouchingforteam(var_0.pers["_encstr_8AEF05472BC2D6"]);
    var_2 = getnumtouchingexceptteam(var_0.pers["_encstr_8AEF05472BC2D6"]);

    if(var_1 && !var_2 || var_1 && var_2 && var_1 != var_2 && !istrue(self._id_133A5)) {
      self.majoritycapprogress = 1;
      self.wasmajoritycapprogress = 0;
      return 1;
    }

    if(var_1 && var_2 && (var_1 == var_2 || istrue(self._id_133A5))) {
      self.stalemate = 1;
      self.majoritycapprogress = 0;
      self.wasmajoritycapprogress = 1;
      return 0;
    }
  }

  if(!isDefined(self.keyobject))
    return 1;

  if(isDefined(self.nocarryobject)) {
    if(checkobjectiskeyobject(var_0))
      return 1;
  }

  if(isDefined(var_0.carryobject)) {
    if(checkplayercarrykeyobject(var_0))
      return 1;
  }

  return 0;
}

proxtriggerthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8BE208E31FA8E1631D65");
  var_0 = self.entnum;

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(istrue(self.brking_givepoints)) {
      if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
        if(!istrue(var_1.isempty) && isDefined(var_1.occupants["_encstr_9AE307B956E345D0AB"]))
          var_1 = var_1.occupants["_encstr_9AE307B956E345D0AB"];
      }
    }

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(istrue(self.trigger.trigger_off)) {
      continue;
    }
    if(isagent(var_1)) {
      continue;
    }
    if(!scripts\mp\utility\entity::isgameparticipant(var_1)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(istrue(self.tv_station_gas_rise) && (var_1 scripts\mp\utility\player::isusingremote() || isDefined(var_1.spawningafterremotedeath))) {
      continue;
    }
    if(istrue(var_1.inlaststand) && !istrue(self.trigger.brkillstreakbeginusefunc)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(!isDefined(var_1.initialized_gameobject_vars)) {
      continue;
    }
    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](var_1))
        continue;
    }

    var_2 = getrelativeteam(var_1.pers["_encstr_8AEF05472BC2D6"]);

    if(isDefined(self.teamusetimes[var_2]) && self.teamusetimes[var_2] < 0) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0])) {
      var_3 = var_1.pers["_encstr_8AEF05472BC2D6"];
      self.numtouching[var_3]++;
      var_4 = var_1.guid;
      var_5 = spawnStruct();
      var_5.player = var_1;
      var_5.starttime = gettime();
      self.touchlist[var_3][var_4] = var_5;

      if(isDefined(self.assisttouchlist)) {
        if(!isDefined(self.assisttouchlist[var_3][var_4]))
          self.assisttouchlist[var_3][var_4] = var_5;
      }
    }

    if(self.cancontestclaim) {
      var_6 = getnumtouchingforteam(var_1.pers["_encstr_8AEF05472BC2D6"]);
      var_7 = getnumtouchingexceptteam(var_1.pers["_encstr_8AEF05472BC2D6"]);

      if(var_6 && !var_7 || var_6 && var_7 && var_6 != var_7) {
        self.majoritycapprogress = 1;
        self.isunoccupied = 0;
      }
    }

    if(self.claimteam == "_encstr_8BBA05185F8B99" || !istrue(self.allowcapture) || istrue(self.majoritycapprogress)) {
      if(caninteractwith(var_1.pers["_encstr_8AEF05472BC2D6"], var_1)) {
        if(canclaim(var_1)) {
          if(!proxtriggerlos(var_1)) {
            continue;
          }
          if(istrue(self.majoritycapprogress)) {
            if(isDefined(self.mostnumtouching) && isDefined(self.mostnumtouchingteam)) {
              setclaimteam(self.mostnumtouchingteam);
              var_8 = getearliestclaimplayer();
              self.claimplayer = var_8;
            }
          } else {
            setclaimteam(var_1.pers["_encstr_8AEF05472BC2D6"]);
            self.claimplayer = var_1;
          }

          if(isDefined(self.teamusetimes[var_2]))
            self.usetime = self.teamusetimes[var_2];

          self.allowcapture = 1;

          if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
            self.allowcapture = 0;

          if(self.usetime && isDefined(self.onbeginuse) && self.allowcapture && self.ownerteam != self.claimteam) {
            self.isunoccupied = 0;

            if(isDefined(self.didstatusnotify) && !self.didstatusnotify)
              self[[self.onbeginuse]](self.claimplayer);
            else if(!isDefined(self.didstatusnotify))
              self[[self.onbeginuse]](self.claimplayer);
          }
        } else if(isDefined(self.oncantuse))
          self[[self.oncantuse]](var_1);
      }
    }

    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1.touchtriggers[var_0]))
      var_1 thread triggertouchthink(self);
  }
}

proxtriggerlos(var_0) {
  if(!isDefined(self.requireslos))
    return 1;

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7" || istrue(level.devball)) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_5 = 0;
    var_3[0] = self.visuals[0];
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB" || istrue(level.debughostagegame)) {
    var_4 = self.trigger.origin + (0, 0, 8);
    var_5 = 0;
    var_3[0] = self.visuals[0];
  } else {
    var_4 = self.trigger.origin + (0, 0, 32);
    var_5 = 1;
    var_3[0] = self.visuals;
  }

  var_3[1] = self.carrier;
  var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);

  if(var_6["_encstr_A53009A25003666B9818C6"] != 1 && var_5) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["_encstr_A53009A25003666B9818C6"] != 1) {
    var_4 = self.trigger.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["_encstr_A53009A25003666B9818C6"] == 1;
}

setclaimteam(var_0) {
  if(getcapturebehavior() == "_encstr_820E07FAE8780B3A4C") {
    if(!isDefined(self.claimgracetime))
      self.claimgracetime = 1000;

    if(!istrue(self.ignorestomp) && scripts\mp\utility\teams::isgameplayteam(var_0)) {
      if(self.lastclaimteam != "_encstr_8BBA05185F8B99") {
        if(!isDefined(self.lastprogressteam))
          self.lastprogressteam = self.lastclaimteam;
      }
    }
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = var_0;
  updateuserate();
}

getclaimteam() {
  return self.claimteam;
}

getlastclaimteam() {
  return self.lastclaimteam;
}

triggertouchthink(var_0) {
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];

  if(istrue(var_0.pinobj)) {
    scripts\mp\objidpoolmanager::objective_pin_player(var_0.objidnum, self);
    self.pinnedobjid = var_0.objidnum;

    if(isDefined(var_0.onpinnedstate))
      var_0[[var_0.onpinnedstate]]();
  }

  if(!isDefined(self.touchinggameobjects))
    self.touchinggameobjects = [];

  var_2 = var_0.trigger getentitynumber();
  self.touchinggameobjects[var_2] = var_0;

  if(!isDefined(var_0.nousebar))
    var_0.nousebar = 0;

  self.touchtriggers[var_0.entnum] = var_0.trigger;
  var_0 updateuserate();

  while(scripts\mp\utility\player::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(isDefined(var_0.checkinteractteam) && var_0.team != var_1) {
      break;
    }

    if(istrue(self.inlaststand) && !istrue(var_0.trigger.brkillstreakbeginusefunc)) {
      break;
    }

    if(isDefined(var_0.interactsquads) && !isDefined(var_0.interactsquads[self.team]) || isDefined(var_0.interactsquads) && !scripts\engine\utility::array_contains(var_0.interactsquads[self.team], self.squadindex)) {
      break;
    }

    if(istrue(var_0.trigger.trigger_off)) {
      break;
    }

    if(istrue(var_0.getrandompointincirclewithindistance) && isDefined(var_0.usecondition) && !var_0[[var_0.usecondition]](self)) {
      break;
    }

    if(!scripts\mp\utility\player::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(var_0.objidnum, self);
      self.remoteunpinned = undefined;
    }

    if(isPlayer(self) && var_0.usetime > 50)
      updateuiprogress(var_0, 1);

    waitframe();
  }

  if(isDefined(self)) {
    if(var_0.usetime > 50) {
      if(isPlayer(self))
        updateuiprogress(var_0, 0);

      self.touchtriggers[var_0.entnum] = undefined;
    } else
      self.touchtriggers[var_0.entnum] = undefined;

    self.touchinggameobjects[var_2] = undefined;
  }

  if(level.gameended) {
    return;
  }
  var_0.oldtouchlist = var_0.touchlist;

  if(isDefined(var_0.touchlist[var_1])) {
    if(isDefined(self))
      var_0.touchlist[var_1][self.guid] = undefined;
    else {
      var_3 = [];

      foreach(var_6, var_5 in var_0.touchlist[var_1]) {
        if(!isDefined(var_5.player))
          var_3[var_3.size] = var_6;
      }

      foreach(var_6 in var_3)
      var_0.touchlist[var_1][var_6] = undefined;
    }
  }

  if(isDefined(self) && isDefined(var_0.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(var_0.objidnum, self, var_0.showoncompass);
    self.pinnedobjid = undefined;

    if(var_0.lastclaimteam == "_encstr_8BBA05185F8B99") {
      if(isDefined(var_0.capturebehavior) && var_0.capturebehavior == "_encstr_92FC0B5BB01A6B73D09459526B")
        scripts\mp\objidpoolmanager::objective_show_progress(var_0.objidnum, 0);
    }
  }

  var_0.numtouching[var_1]--;
  var_0 updateuserate();

  if(isDefined(var_0.onunpinnedstate))
    var_0[[var_0.onunpinnedstate]]();
}

migrationcapturereset(var_0) {
  var_0.migrationcapturereset = 1;
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  self.migrationcapturereset = undefined;
}

getnumtouchingforteam(var_0) {
  return self.numtouching[var_0];
}

getnumtouchingexceptteam(var_0) {
  var_1 = 0;
  var_2 = 0;
  self.mostnumtouching = 0;
  self.mostnumtouchingteam = "_encstr_8BBA05185F8B99";

  foreach(var_4 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
      continue;
    }
    var_2 = var_2 + self.numtouching[var_4];

    if(var_2 > 0 && var_2 > self.mostnumtouching) {
      self.mostnumtouching = var_2;
      self.mostnumtouchingteam = var_4;
      var_2 = 0;
    }

    if(var_4 != var_0)
      var_1 = var_1 + self.numtouching[var_4];
  }

  return var_1;
}

updateuiprogress(var_0, var_1, var_2) {
  if(!isDefined(level.hostmigrationtimer)) {
    if(isDefined(var_0.interactteam) && var_0.interactteam == "_encstr_8BBA05185F8B99")
      self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    else {
      if(!isDefined(var_2))
        var_2 = var_0;

      var_3 = undefined;

      if(isDefined(var_0.objidnum))
        var_3 = var_0.objidnum;

      var_4 = 0;

      if(isDefined(var_0.teamprogress) && isDefined(var_0.claimteam)) {
        if(var_0.teamprogress[var_0.claimteam] > var_2.usetime)
          var_0.teamprogress[var_0.claimteam] = var_2.usetime;

        var_4 = var_0.teamprogress[var_0.claimteam] / var_2.usetime;
      } else {
        if(var_2.curprogress > var_2.usetime)
          var_2.curprogress = var_2.usetime;

        var_4 = var_2.curprogress / var_2.usetime;

        if(var_2.usetime <= 1000)
          var_4 = min(var_4 + 0.05, 1);
        else
          var_4 = min(var_4 + 0.01, 1);
      }

      if((scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7" || scripts\mp\utility\game::getgametype() == "_encstr_97AB06BBB583D1F5") && !isDefined(var_0.id)) {
        if(var_1 && istrue(var_0.stalemate)) {
          if(!isDefined(self.ui_ctf_stalemate)) {
            if(!isDefined(self.ui_ctf_securing))
              self.ui_ctf_securing = 1;

            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", -1);
            self.ui_ctf_stalemate = 1;
          }

          var_4 = 0.01;
        } else if(var_1 && isDefined(self.ui_ctf_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam != self.team) {
          self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
          self.ui_ctf_securing = 1;
          self.ui_ctf_stalemate = undefined;
        } else if(var_1 && isDefined(self.ui_ctf_securing) && isDefined(var_0.stalemate) && !var_0.stalemate && var_0.ownerteam == self.team) {
          self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
          self.ui_ctf_securing = 1;
          self.ui_ctf_stalemate = undefined;
        } else {
          if(!var_1 && isDefined(self.ui_ctf_stalemate)) {
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
            self.ui_ctf_securing = undefined;
          }

          if(var_1 && !isDefined(self.ui_ctf_stalemate) && var_0.ownerteam == self.team) {
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
            self.ui_ctf_securing = undefined;
          }

          if(var_1 && !isDefined(self.ui_ctf_securing)) {
            if(var_0.ownerteam != self.team) {
              self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
              self.ui_ctf_securing = 1;
            } else if(var_0.interactteam == "_encstr_9A19040BCDBC") {
              self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
              self.ui_ctf_securing = 1;
            }
          }

          self.ui_ctf_stalemate = undefined;
        }

        if(!var_1) {
          var_4 = 0.01;
          self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
          self.ui_ctf_securing = undefined;
        }

        if(var_4 != 0) {
          scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, self.team);
          scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(var_3, var_4);
        }
      }

      if(hasdomflags() && isDefined(var_0.id) && (var_0.id == "_encstr_87D9083A6F628DDB5F1F" || var_0.id == "_encstr_B67B0A1A2C279107DBB49BA3" || var_0.id == "_encstr_A9200A903FED31C743345DED" || var_0.id == "_encstr_8DF90B33B8DF96EFEECA8D9754")) {
        if(var_1 && isDefined(var_0.stalemate) && var_0.stalemate && !istrue(var_0.majoritycapprogress)) {
          if(!isDefined(self.ui_dom_stalemate)) {
            if(!isDefined(self.ui_dom_securing))
              self.ui_dom_securing = 1;

            self.ui_dom_stalemate = 1;
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 3);
          }
        } else if(var_1 && isDefined(self.ui_dom_securing) && (isDefined(var_0.stalemate) && !var_0.stalemate && !istrue(var_0.majoritycapprogress)) && var_0.ownerteam != self.team) {
          self.ui_dom_securing = 1;
          self.ui_dom_stalemate = undefined;

          if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
            if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
              self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
            else
              self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
          } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", var_0 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::relic_nuketimer_timerloop());
          else
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
        } else {
          if(!var_1 && isDefined(self.ui_dom_stalemate)) {
            if(isDefined(var_0.overrideprogressteam))
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.overrideprogressteam);
            else if(isDefined(var_0.lastprogressteam) && var_0.lastprogressteam != var_0.claimteam)
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.lastprogressteam);
            else if(var_0.claimteam != "_encstr_8BBA05185F8B99")
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);

            self.ui_dom_securing = undefined;
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
          } else if(var_1 && istrue(var_0.majoritycapprogress) && isDefined(var_0.lastprogressteam) && var_0.lastprogressteam == var_0.claimteam) {
            if(isDefined(var_0.overrideprogressteam))
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.overrideprogressteam);
            else if(var_0.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && var_0.claimteam == var_0.ownerteam)
              self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
            else if(var_0.claimteam != "_encstr_8BBA05185F8B99") {
              if(istrue(level.spawn_lot_paratroopers)) {} else if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
                if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
                else
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
              } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
                self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", var_0 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::relic_nuketimer_timerloop());
              else
                self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);

              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);
            }
          } else if(scripts\mp\utility\game::getgametype() == "_encstr_AF6A069265315388") {
            if(!isDefined(var_0.claimteam) || var_0.claimteam == "_encstr_8BBA05185F8B99") {
              var_0.numtouching[self.team] = 1;

              if(!isDefined(var_0.lastclaimteam))
                var_0.lastclaimteam = "_encstr_8BBA05185F8B99";

              var_0 setclaimteam(self.pers["_encstr_8AEF05472BC2D6"]);
              var_0 setownerteam(self.pers["_encstr_8AEF05472BC2D6"]);
            }

            if(var_1) {
              if(var_0.claimteam != "_encstr_8BBA05185F8B99") {
                self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
                scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, var_0.claimteam);
                scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);
                scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);
              }
            } else
              var_0.claimteam = "_encstr_8BBA05185F8B99";
          }

          if(var_1 && !isDefined(self.ui_dom_stalemate) && var_0.ownerteam == self.team) {
            self.ui_dom_securing = undefined;
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
          }

          if(var_1 && !isDefined(self.ui_dom_securing) && var_0.ownerteam != self.team)
            self.ui_dom_securing = 1;

          self.ui_dom_stalemate = undefined;
        }

        if(scripts\mp\utility\game::getgametype() != "_encstr_A61F054B28EBE0") {
          if(!var_1 || !var_0 caninteractwith(self.team, self) && (!isDefined(var_0.stalemate) || isDefined(var_0.stalemate) && !var_0.stalemate)) {
            if(var_2.curprogress == 0)
              scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);

            self.ui_dom_securing = undefined;
            self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
          }
        }

        if(var_4 != 0) {
          if(showspecificteamprogress(var_0))
            scripts\mp\objidpoolmanager::objective_show_team_progress(var_3, var_0.claimteam);
          else
            scripts\mp\objidpoolmanager::objective_show_progress(var_3, 1);

          if(level.teambased && isDefined(var_0.teamprogress) && isDefined(var_0.claimteam) && var_1) {
            if(!var_0.stalemate) {
              if(isDefined(var_0.overrideprogressteam)) {
                scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.overrideprogressteam);
                scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_0.teamprogress[var_0.overrideprogressteam] / var_2.usetime);
              } else {
                scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.claimteam);
                scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);
              }

              if(self.team == var_0.claimteam) {
                if(istrue(level.spawn_lot_paratroopers)) {
                  return;
                }
                if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
                  if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
                    self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
                  else
                    self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
                } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", var_0 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::relic_nuketimer_timerloop());
                else {
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
                  return;
                }
              } else
                self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 5);
            } else if(var_0.stalemate && istrue(var_0.majoritycapprogress)) {
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, var_0.claimteam);
              scripts\mp\objidpoolmanager::objective_set_progress(var_0.objidnum, var_4);

              if(self.team == var_0.claimteam) {
                if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
                  if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
                    self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
                  else
                    self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);
                } else if(istrue(var_0.neutralizing) && var_0.ownerteam != self.team && var_0.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 6);
                else
                  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
              } else
                self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 5);
            } else
              scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, undefined);
          } else if(!level.teambased)
            scripts\mp\objidpoolmanager::objective_set_progress_client(var_3, self);
        }
      } else {
        if(isbombmode() && isDefined(var_0.id) && (var_0.id == "_encstr_BED80ABE90F30A6F7A40FBDF" || var_0.id == "_encstr_86DB0E32ACCC579B56BEBD31A9CAB11D")) {
          if(isDefined(self)) {
            if(var_1 && isDefined(self)) {
              if(!isDefined(self.ui_bomb_planting_defusing)) {
                var_5 = 0;

                if(var_0.id == "_encstr_BED80ABE90F30A6F7A40FBDF")
                  var_5 = 1;
                else if(var_0.id == "_encstr_86DB0E32ACCC579B56BEBD31A9CAB11D")
                  var_5 = 2;

                self.ui_bomb_planting_defusing = 1;
              }
            } else {
              self.ui_bomb_planting_defusing = undefined;

              if(!isDefined(var_0.resetprogress) || istrue(var_0.resetprogress))
                var_4 = 0.01;
            }

            if(var_4 != 0) {
              if(!isDefined(var_0.showprogressforteam)) {
                scripts\mp\objidpoolmanager::objective_set_progress_team(var_3, self.team);
                scripts\mp\objidpoolmanager::objective_show_team_progress(var_3, self.team);
                var_0.showprogressforteam = self.team;
              }

              scripts\mp\objidpoolmanager::objective_set_progress(var_3, var_4);
              setomnvar("_encstr_AFE011EA4BFA4CDEDA98BE83277B9D27596EDC", var_4);
              return;
            }

            return;
          }

          return;
        }

        if(isDefined(var_0.id)) {
          var_5 = 0;

          switch (var_0.id) {
            case "_encstr_BAE50DE60E739BA638C72068AF47B9":
            case "_encstr_8CC008133958C81BACCB":
              var_5 = 1;
              break;
            case "_encstr_A98F06181E4BCA85":
              var_5 = 2;
              break;
            case "_encstr_992E0C97A7734F7BF29B66D945D0":
              var_5 = 3;
              break;
            case "_encstr_AFA1181B75302922131A765909619B2951DBD555E9071BFFC59F":
              var_5 = 4;
              break;
            case "_encstr_9A43124032FAC143E35908750F93C99D24EBB038":
              var_5 = 5;
              break;
            case "_encstr_914312E1D7AB3973F5914AA92753C7F573F4FDCB":
              var_5 = 6;
              break;
            case "_encstr_BAD70791FB4F67C8D4":
              var_5 = 7;
              break;
            case "_encstr_AB19049D0FC0":
              var_5 = 8;
              break;
            case "_encstr_A6530EFD4A6F389E8BD191B96AD74EC0":
              var_5 = 9;
              break;
            case "_encstr_B64C0742801D38E33F":
              var_5 = 10;
              break;
            case "_encstr_95CC050D168DDA":
              var_5 = 13;
              break;
            case "_encstr_BA3B0B49EB63875F6DA6288B38":
              var_5 = 15;
              break;
            case "_encstr_8BE206FB5F08C023":
              var_5 = 21;
              break;
            case "_encstr_AFCB082AC1D6A3EA7B73":
              var_5 = 22;
              break;
            case "_encstr_8F130D770F8AA7D8C6793BF39EB4F0":
              var_5 = 23;
              break;
            case "_encstr_9BF9133863589BD196739DAFAC8738B1ED3796D956":
              var_5 = 24;
              break;
          }

          updateuisecuring(var_4, var_1, var_5, var_0, var_2.usetime);
        }
      }
    }
  }
}

showspecificteamprogress(var_0) {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_951904D8F1E0":
      if(var_0.claimteam == game["_encstr_991C0AB9ED5B57161FE89B83"])
        return 1;
  }

  return 0;
}

hasdomflags() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_9719046E3182":
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_A10C0780F23F6F400B":
    case "_encstr_AF6A069265315388":
    case "_encstr_A61F054B28EBE0":
    case "_encstr_A9190405B4E5":
    case "_encstr_8E07030349":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_93A2056DBB5853":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_A9B606B0C956B916":
    case "_encstr_B607038AAB":
    case "_encstr_B81904B04E6B":
      return 1;
    default:
      return 0;
  }

  return 0;
}

updateuisecuring(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(var_1) {
    if(!isDefined(var_3.usedby))
      var_3.usedby = [];

    if(!isDefined(self.migrationcapturereset))
      var_3 thread migrationcapturereset(self);

    if(!existinarray(self, var_3.usedby))
      var_3.usedby[var_3.usedby.size] = self;

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", var_2);
      self.ui_securing = 1;

      if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
        if(isDefined(var_3.trigger.owner)) {
          var_3.trigger.owner setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", self getentitynumber());
          var_3.trigger.owner setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 6);
        }
      }
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && var_3.id == "_encstr_9A43124032FAC143E35908750F93C99D24EBB038") {
      var_6 = undefined;

      if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger())
        var_6 = var_3.trigger.owner;

      if(isDefined(var_6) && self == var_6)
        self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 16);

      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1401F(var_6, self, var_0);
    }
  } else {
    if(isDefined(var_3.usedby) && existinarray(self, var_3.usedby))
      var_3.usedby = scripts\engine\utility::array_remove(var_3.usedby, self);

    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    self.ui_securing = undefined;

    if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
        var_3.trigger.owner setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      }
    }

    var_0 = 0.01;

    if(isDefined(var_3.objidnum))
      var_5 = var_3.objidnum;
  }

  if(var_4 == 500)
    var_0 = min(var_0 + 0.15, 1);

  if(var_0 != 0) {
    self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);

    if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
      if(isDefined(var_3.trigger.owner))
        var_3.trigger.owner setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);
    }

    if(isDefined(var_3.objidnum) && !istrue(var_3._encstr_930C1C721A63B3CDB3E04F03F008925AC3A63B6C7C936BF278900B4F6863))
      scripts\mp\objidpoolmanager::objective_set_progress(var_3.objidnum, var_0);
  }
}

existinarray(var_0, var_1) {
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0)
        return 1;
    }
  }

  return 0;
}

updateuserate() {
  if(self.claimteam == "_encstr_8BBA05185F8B99" && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.ownerteam != "_encstr_9A19040BCDBC")
    var_0 = self.ownerteam;
  else
    var_0 = self.claimteam;

  var_1 = self.numtouching[var_0];
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
      continue;
    }
    if(var_0 != var_5)
      var_2 = var_2 + self.numtouching[var_5];
  }

  if(isDefined(self.touchlist[var_0])) {
    foreach(var_8 in self.touchlist[var_0]) {
      if(!isDefined(var_8.player)) {
        continue;
      }
      if(var_8.player.pers["_encstr_8AEF05472BC2D6"] != var_0) {
        continue;
      }
      if(var_8.player.objectivescaler == 1) {
        continue;
      }
      var_1 = var_1 * var_8.player.objectivescaler;
      var_3 = var_8.player.objectivescaler;
    }
  }

  if(!istrue(self._id_133E5))
    self.stalemate = scripts\engine\utility::ter_op(istrue(self.alwaysstalemate), var_1 && var_2, var_1 && var_2 && var_1 == var_2);

  if(!var_1 && !var_2)
    self.majoritycapprogress = 0;

  if(isDefined(self.triggertype) && self.triggertype == "_encstr_AB19049D0FC0") {} else
    self.userate = 0;

  if(var_1) {
    if(var_1 > var_2) {
      self.userate = min(var_1 - var_2, scripts\engine\utility::ter_op(isDefined(level.objectivescaler), level.objectivescaler, 4));

      if(self.userate > 1.0)
        self.userate = self.userate * self.useratemultiplier;
    }
  }

  if(isDefined(self.isarena) && self.isarena && var_3 != 0)
    self.userate = 1 * var_3;
  else if(isDefined(self.isarena) && self.isarena)
    self.userate = 1;
}

useholdthink(var_0) {
  var_0 notify("_encstr_BADC09F86FAA67201F8012");

  if(self.exclusiveuse)
    var_0 clientclaimtrigger(self.trigger);

  var_0 allowmovement(0);
  var_1 = isDefined(self.id) && (self.id == "_encstr_86D610CBDA29F8FD7397A3B1F74B3ED8D3B3" || self.id == "_encstr_BAD70791FB4F67C8D4" || self.id == "_encstr_BAE50DE60E739BA638C72068AF47B9");

  if(isbombmode()) {
    if(var_1 || level.gametype == "_encstr_ACF906B79752C5E8") {} else if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant)) {
      var_0 setentitysoundcontext("_encstr_B8BA0D53AA8B85403377C1C1719D58", "_encstr_AB0703DBB9");

      if(istrue(var_0.isdefusing))
        self.useweapon = getcompleteweaponname("_encstr_A5C31BC1EE4C2259A23B9B23D10FF16D3DF6B9C1F3012D1F528519A53B");
      else
        self.useweapon = getcompleteweaponname("_encstr_84F4147148CADD4A7148A60D26477822F5230B0FD752");
    }
  }

  var_2 = self.useweapon;
  var_3 = var_0 getcurrentweapon();

  if(isDefined(var_2)) {
    var_4 = 0;

    if(var_3.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8")
      var_4 = 1;

    if(var_3 == var_2)
      var_3 = var_0.lastnonuseweapon;

    var_0.lastnonuseweapon = var_3;
    var_5 = 0;
    var_6 = 0;

    if(scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8") {
      var_5 = 1;
      var_6 = 0;
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 0);
    var_0 setweaponammostock(var_2, var_5);
    var_0 setweaponammoclip(var_2, var_5);
    var_0 thread switchtouseweapon(var_2, var_4);
  } else if(!var_1) {
    if(isDefined(self.trigger) && self.trigger isrevivetrigger() || isDefined(self.id) && self.id == "_encstr_8DF90B33B8DF96EFEECA8D9754") {
      if(!var_0 scripts\mp\utility\perk::_hasperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75")) {
        var_0.weaponsdisabledwhilereviving = 1;

        if(!level.allowreviveweapons) {
          var_0 thread playerplunderdepositcallback(1);
          var_0 scripts\common\utility::allow_sprint(0);
          var_0 scripts\common\utility::allow_fire(0);
          var_0 scripts\common\utility::allow_ads(0);
          var_0 scripts\common\utility::allow_offhand_weapons(0);
        } else
          var_0 scripts\mp\playeractions::allowactionset("_encstr_81CA0CCAF9E0392BF5E79B8FF725", 0);
      }
    } else
      var_0 scripts\common\utility::allow_weapon(0);
  }

  if(!isDefined(var_0.usinggameobjects))
    var_0.usinggameobjects = [];

  var_7 = self.trigger getentitynumber();
  var_0.usinggameobjects[var_7] = self;

  if(!isDefined(self.resetprogress) || istrue(self.resetprogress))
    self.curprogress = 0;

  self.inuse = 1;
  self.userate = 0;
  var_8 = useholdthinkloop(var_0, var_3);

  if(isDefined(var_0)) {
    var_0.usinggameobjects[var_7] = undefined;
    var_0 detachusemodels();
    var_0 notify("_encstr_B4220B0BE050C5514316EC2574");
  }

  if(isDefined(var_2) && isDefined(var_0)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8" && !isrevivetrigger() && !istrue(var_8)) {
      var_0 setweaponammostock(var_2, 0);
      var_0 setweaponammoclip(var_2, 0);
    }

    var_0 scripts\mp\supers::unstowsuperweapon();

    if(var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
    } else if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284") {
      if(!istrue(var_8)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);
      }

      if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
        var_0 scripts\mp\utility\inventory::switchtolastweapon();
      } else
        var_0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
    } else if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
      var_0 scripts\mp\utility\inventory::switchtolastweapon();
    } else
      var_0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
  }

  if(istrue(var_8)) {
    var_0 allowmovement(1);
    return 1;
  } else if(!istrue(var_8)) {
    if(!isDefined(self.resetprogress) || istrue(self.resetprogress))
      self.curprogress = 0;
    else
      managecurprogress(var_0);
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_2) && !var_1) {
      if(isDefined(self.trigger) && self.trigger isrevivetrigger() || isDefined(self.id) && self.id == "_encstr_8DF90B33B8DF96EFEECA8D9754") {
        if(istrue(var_0.weaponsdisabledwhilereviving)) {
          var_0.weaponsdisabledwhilereviving = undefined;

          if(!level.allowreviveweapons) {
            var_0 thread playerplunderdepositcallback(0);
            var_0 scripts\common\utility::allow_sprint(1);
            var_0 scripts\common\utility::allow_fire(1);
            var_0 scripts\common\utility::allow_ads(1);
            var_0 scripts\common\utility::allow_offhand_weapons(1);
          } else
            var_0 scripts\mp\playeractions::allowactionset("_encstr_81CA0CCAF9E0392BF5E79B8FF725", 1);
        }
      } else
        var_0 scripts\common\utility::allow_weapon(1);
    }

    var_0 allowmovement(1);
  }

  self.inuse = 0;

  if(self.exclusiveuse && isDefined(self.trigger))
    self.trigger releaseclaimedtrigger();

  return 0;
}

playerplunderdepositcallback(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BDAF1266DE271B2B1159AD2BC2CDED27A6163395");
  self endon("_encstr_BDAF1266DE271B2B1159AD2BC2CDED27A6163395");

  if(var_0) {
    while(self issprinting())
      wait 0.5;

    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
  } else {
    var_1 = 0;

    while(!var_1) {
      var_1 = self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      waitframe();
    }
  }
}

managecurprogress(var_0) {
  if(!isDefined(self.prevprogress))
    self.prevprogress = 0;

  var_1 = self.curprogress - self.prevprogress;

  if(var_1 <= 1000)
    self.curprogress = self.prevprogress;

  var_2 = self.usetime - self.curprogress;

  if(var_2 < 1000) {
    if(self.usetime <= 1000)
      self.curprogress = self.usetime;
    else
      self.curprogress = self.usetime - 1000;
  }

  var_1 = 0;

  if(self.curprogress > 0) {
    if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
      if(self.teamprogress[self.claimteam] > self.usetime)
        self.teamprogress[self.claimteam] = self.usetime;

      var_1 = self.teamprogress[self.claimteam] / self.usetime;
    } else {
      if(self.curprogress > self.usetime)
        self.curprogress = self.usetime;

      var_1 = self.curprogress / self.usetime;

      if(self.usetime <= 1000)
        var_1 = min(var_1 + 0.05, 1);
      else
        var_1 = min(var_1 + 0.01, 1);
    }
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_1);

  if(self.curprogress > 0)
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, var_0.team);
  else
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  self.prevprogress = self.curprogress;
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "_encstr_8BC20B14A358B1CF58786A6201");
    self.attachedusemodel = undefined;
  }
}

switchtouseweapon(var_0, var_1) {
  scripts\mp\supers::allowsuperweaponstow();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    else
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }
}

usetest(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(!var_0 scripts\common\utility::is_usability_allowed())
    return 0;

  if(!isDefined(self.skiptouching) && (isDefined(self.trigger) && !var_0 istouching(self.trigger)))
    return 0;

  if(!level.allowreviveweapons && !var_0 useButtonPressed(1))
    return 0;

  if(var_0 scripts\mp\utility\weapon::grenadeinpullback())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(var_0 isinexecutionattack())
    return 0;

  if(var_0 isinexecutionvictim())
    return 0;

  if(isDefined(self.trigger) && isDefined(self.trigger._id_1408A) && distance2dsquared(self.trigger.origin, var_0.origin) >= self.trigger._id_1408A)
    return 0;

  if(self.curprogress >= self.usetime)
    return 0;

  if(!self.userate && !var_1)
    return 0;

  if(var_1 && var_2 > var_3)
    return 0;

  if(istrue(self.getrandompointincirclewithindistance) && isDefined(self.usecondition) && !self[[self.usecondition]](var_0))
    return 0;

  if(isDefined(self.useweapon)) {
    if(var_0 getcurrentweapon() != self.useweapon && !var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(self.useweapon))
      return 0;
  }

  if(self.trigger isrevivetrigger()) {
    if(!var_0 isonground())
      return 0;
  }

  return 1;
}

useholdthinkloop(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_921D09D9D9C0090D7275B4");
  var_2 = self.useweapon;
  var_3 = 1;

  if(isDefined(self.waitforweapononuse))
    var_3 = self.waitforweapononuse;

  if(!var_3)
    self.userate = 1 * var_0.objectivescaler;

  var_4 = 0;
  var_5 = 1.5;
  var_6 = level.framedurationseconds;
  var_7 = var_6 * 1000;
  var_8 = undefined;

  while(usetest(var_0, var_3, var_4, var_5)) {
    if(isDefined(self.objidnum))
      scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, var_0);

    var_4 = var_4 + var_6;

    if(!var_3 || !isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      self.curprogress = self.curprogress + var_7 * self.userate;
      self.userate = 1 * var_0.objectivescaler;
      var_3 = 0;
    } else
      self.userate = 0;

    var_0 updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;

      if(self.exclusiveuse)
        var_0 clientreleasetrigger(self.trigger);

      var_9 = isDefined(self.id) && (self.id == "_encstr_86D610CBDA29F8FD7397A3B1F74B3ED8D3B3" || self.id == "_encstr_BAD70791FB4F67C8D4" || self.id == "_encstr_BAE50DE60E739BA638C72068AF47B9");

      if(!isDefined(var_2) && !var_9) {
        if(self.trigger isrevivetrigger() || isDefined(self.id) && self.id == "_encstr_8DF90B33B8DF96EFEECA8D9754") {
          if(istrue(var_0.weaponsdisabledwhilereviving)) {
            var_0.weaponsdisabledwhilereviving = undefined;

            if(!level.allowreviveweapons) {
              var_0 thread playerplunderdepositcallback(0);
              var_0 scripts\common\utility::allow_sprint(1);
              var_0 scripts\common\utility::allow_fire(1);
              var_0 scripts\common\utility::allow_ads(1);
              var_0 scripts\common\utility::allow_offhand_weapons(1);
            } else
              var_0 scripts\mp\playeractions::allowactionset("_encstr_81CA0CCAF9E0392BF5E79B8FF725", 1);
          }
        } else
          var_0 scripts\common\utility::allow_weapon(1);
      }

      var_0 unlink();

      if(isDefined(self.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_0);

      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    wait(var_6);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  if(isDefined(self.objidnum))
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_0);

  var_0 updateuiprogress(self, 0);
  return 0;
}

updatetrigger() {
  if(self.triggertype != "_encstr_AB19049D0FC0") {
    return;
  }
  if(self.trigger.classname != "_encstr_AFF60C939B634707C80DAF8DE720" && self.trigger.classname != "_encstr_A38E124303C0477207C357B07F1D8725F85596B3") {
    return;
  }
  if(self.interactteam == "_encstr_8BBA05185F8B99") {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
      self.trigger setteamfortrigger("_encstr_8BBA05185F8B99");
  } else if(self.interactteam == "_encstr_9A19040BCDBC") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("_encstr_8BBA05185F8B99");
  } else if(self.interactteam == "_encstr_ACFC091AE8AB2FCBE15119") {
    self.trigger.origin = self.curorigin;

    if(scripts\engine\utility::array_contains(level.teamnamelist, self.ownerteam))
      self.trigger setteamfortrigger(self.ownerteam);
    else
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
  } else if(self.interactteam == "_encstr_88BF06FD784A6393") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "_encstr_9A8507BA4040188D08")
      self.trigger setteamfortrigger("_encstr_8E8405EA382B2A");
    else if(self.ownerteam == "_encstr_8E8405EA382B2A")
      self.trigger setteamfortrigger("_encstr_9A8507BA4040188D08");
    else
      self.trigger setteamfortrigger("_encstr_8BBA05185F8B99");
  }
}

getmlgteamcolor(var_0) {
  if(var_0 == "_encstr_9A8507BA4040188D08")
    return game["_encstr_928707BA60B92F0A9B"]["_encstr_ACFC091AE8AB2FCBE15119"];
  else if(var_0 == "_encstr_8E8405EA382B2A")
    return game["_encstr_928707BA60B92F0A9B"]["_encstr_88BF06FD784A6393"];

  return (1, 1, 1);
}

setobjpointteamcolor(var_0, var_1, var_2) {
  if(var_1 == "_encstr_8C760B65B03B672219F1878FF7") {
    var_0 setmlgdraw(1, 0);
    var_3 = self.objiconscolor[var_2];

    if(var_3 == "_encstr_ACFC091AE8AB2FCBE15119") {
      var_0.color = getmlgteamcolor("_encstr_9A8507BA4040188D08");
      return;
    }

    if(var_3 == "_encstr_88BF06FD784A6393") {
      var_0.color = getmlgteamcolor("_encstr_8E8405EA382B2A");
      return;
    }

    var_0.color = game["_encstr_928707BA60B92F0A9B"][var_3];
    return;
    return;
  } else if(var_1 == "_encstr_878109218DE22FA1F027E0") {
    var_0 setmlgdraw(1, 0);
    var_3 = self.objiconscolor[var_2];

    if(var_3 == "_encstr_ACFC091AE8AB2FCBE15119") {
      var_0.color = getmlgteamcolor("_encstr_8E8405EA382B2A");
      return;
    }

    if(var_3 == "_encstr_88BF06FD784A6393") {
      var_0.color = getmlgteamcolor("_encstr_9A8507BA4040188D08");
      return;
    }

    var_0.color = game["_encstr_928707BA60B92F0A9B"][var_3];
    return;
    return;
  } else {
    var_0.color = game["_encstr_928707BA60B92F0A9B"][self.objiconscolor[var_2]];
    var_0 setmlgdraw(0, 1);
  }
}

hideworldiconongameend() {
  self notify("_encstr_88B317A0478471772252F18DE49A7F58C7C35150FF5D8DCDBA");
  self endon("_encstr_88B317A0478471772252F18DE49A7F58C7C35150FF5D8DCDBA");
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self.alpha = 0;
}

updatetimer(var_0, var_1) {}

_id_1317F(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = var_1;

  if(!isDefined(var_1))
    var_1 = var_0;

  if(!isDefined(self.iconname))
    self.iconname = "_encstr_B40101";

  if(level.codcasterenabled) {
    if(!isDefined(var_2))
      self.compassicons["_encstr_95F90A8DED321B58371D2B39"] = undefined;
    else
      self.compassicons["_encstr_95F90A8DED321B58371D2B39"] = var_2 + self.iconname;
  }

  self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"] = var_0 + self.iconname;
  self.compassicons["_encstr_88BF06FD784A6393"] = var_1 + self.iconname;
  updatecompassicons(var_3, var_4);
}

setobjectivestatusicons(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = var_1;

  if(!isDefined(var_1))
    var_1 = var_0;

  if(!isDefined(self.iconname))
    self.iconname = "_encstr_B40101";

  self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"] = var_0 + self.iconname;
  self.compassicons["_encstr_88BF06FD784A6393"] = var_1 + self.iconname;

  if(!istrue(var_4))
    updatecompassicons(var_2, var_3);
}

_id_13172(var_0, var_1, var_2) {
  if(!level.codcasterenabled) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.iconname))
    self.iconname = "_encstr_B40101";

  self.compassicons["_encstr_95F90A8DED321B58371D2B39"] = var_0 + self.iconname;
  updatecompassicons(var_1, var_2);
}

_id_12C75(var_0, var_1) {
  self.compassicons["_encstr_95F90A8DED321B58371D2B39"] = undefined;
  updatecompassicons(var_0, var_1);
}

updatecompassicons(var_0, var_1) {
  var_2 = self.visibleteam;

  if(!isDefined(self.visibleteam))
    var_2 = "_encstr_8BBA05185F8B99";

  updatecompassicon(var_2, var_0, var_1);
}

updatecompassicon(var_0, var_1, var_2) {
  var_3 = var_0 == "_encstr_9A19040BCDBC";
  var_4 = var_0 == "_encstr_8BBA05185F8B99";

  if(var_3 || var_4)
    var_5 = level.teamnamelist;
  else {
    var_6 = getupdateteams(var_0);
    var_5 = var_6.teams;
  }

  var_7 = 0;

  for(var_8 = 0; var_8 < var_5.size; var_8++) {
    var_9 = var_5[var_8];

    if(var_3 || var_4)
      var_10 = var_9;
    else
      var_10 = var_9.team;

    if(!var_4 && !var_3 && !scripts\mp\utility\teams::isgameplayteam(var_10)) {
      continue;
    }
    var_11 = !var_4 && (var_3 || var_9.showtoteam);

    if(!var_11 && shouldshowcompassduetoradar(var_10))
      var_11 = 1;

    if(!isDefined(var_1))
      var_1 = self.objidnum;

    if(var_1 != -1) {
      if(level.codcasterenabled) {
        if(isDefined(self.compassicons["_encstr_95F90A8DED321B58371D2B39"])) {
          var_12 = getwaypointshader(self.compassicons["_encstr_95F90A8DED321B58371D2B39"]);
          scripts\mp\objidpoolmanager::_id_13FA0(var_1, var_12);
        } else
          scripts\mp\objidpoolmanager::_id_13FA1(var_1);
      }

      if(!istrue(self.visibilitymanuallycontrolled)) {
        if(!isDefined(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]) || !var_11) {
          scripts\mp\objidpoolmanager::objective_teammask_removefrommask(var_1, var_10);
          continue;
        } else
          scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_1, var_10);

        if(!isDefined(self.compassicons["_encstr_88BF06FD784A6393"]) || !var_11) {
          scripts\mp\objidpoolmanager::objective_teammask_removefrommask(var_1, var_10);
          continue;
        } else
          scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_1, var_10);
      }

      if(!var_7) {
        var_13 = getwaypointshader(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]);
        scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_13);
        var_14 = getwaypointbackgroundcolor(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]);
        var_14 = scripts\engine\utility::ter_op(isDefined(var_14), var_14, "_encstr_A7A408B9CA5D1D4E2C63");
        var_15 = getwaypointbackgroundcolor(self.compassicons["_encstr_88BF06FD784A6393"]);
        var_15 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, "_encstr_A7A408B9CA5D1D4E2C63");
        var_16 = 0;
        var_17 = getobjectivestate(var_14, var_15);

        if(var_17 == "_encstr_93B508770F528D90B3DB")
          var_16 = 1;

        if(var_16) {
          scripts\mp\objidpoolmanager::objective_set_progress_team(var_1, undefined);
          scripts\mp\objidpoolmanager::update_objective_sethot(var_1, 1);
        } else
          scripts\mp\objidpoolmanager::update_objective_sethot(var_1, 0);

        if(isDefined(var_2))
          self.ownerteam = var_2;

        var_18 = getwaypointstring(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]);
        var_19 = getwaypointstring(self.compassicons["_encstr_88BF06FD784A6393"]);

        if(var_17 == "_encstr_A7A408B9CA5D1D4E2C63" || !isDefined(self.ownerteam)) {
          if(isDefined(self.claimteam) && self.claimteam != "_encstr_8BBA05185F8B99") {
            scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.claimteam);
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(var_1, var_18);
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(var_1, var_19);
          } else {
            scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, undefined);
            scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var_1, var_18);
          }
        } else if(var_17 == "_encstr_AC8A08C76061FB6ABA10") {
          if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
            scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.ownerteam);
          else
            scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, undefined);

          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(var_1, var_18);
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(var_1, var_19);
        } else if(var_17 == "_encstr_93B508770F528D90B3DB") {
          if(self.cancontestclaim && self.stalemate != self.wasstalemate || self.cancontestclaim && istrue(self.majoritycapprogress) && self.majoritycapprogress != self.wasmajoritycapprogress)
            objective_setlabel(var_1, var_18);
          else {
            if(!scripts\mp\utility\teams::isgameplayteam(self.claimteam)) {
              continue;
            }
            scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.claimteam);
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(var_1, var_18);
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(var_1, var_19);
          }
        }

        var_20 = getwaypointbackgroundtype(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, var_20);

        if(level.codcasterenabled && isDefined(self.compassicons["_encstr_95F90A8DED321B58371D2B39"])) {
          var_20 = getwaypointbackgroundtype(self.compassicons["_encstr_95F90A8DED321B58371D2B39"]);
          scripts\mp\objidpoolmanager::_id_13FA3(var_1, var_20);
        }

        var_21 = getwaypointobjpulse(self.compassicons["_encstr_ACFC091AE8AB2FCBE15119"]);
        scripts\mp\objidpoolmanager::objective_set_pulsate(var_1, var_21);

        if(hasdomflags()) {
          if(!istrue(self.stalemate) && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63") {
            if(self.numtouching["_encstr_8E8405EA382B2A"] > 0 && self.numtouching["_encstr_9A8507BA4040188D08"] > 0) {
              self.captureblocked = 1;
              scripts\mp\objidpoolmanager::update_objective_sethot(var_1, 1);
            } else {
              self.captureblocked = 0;
              scripts\mp\objidpoolmanager::update_objective_sethot(var_1, 0);
            }
          }
        }

        if(self.type == "_encstr_935F0C1B58279C2FD31335AC6C1D") {
          if(scripts\mp\utility\player::isreallyalive(self.carrier) && !shouldpingobject(var_0)) {
            scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self.carrier);
            scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, self.offset3d[2]);
          } else if(isDefined(self.visuals) && isDefined(self.visuals[0]) && isDefined(self.visuals[0] getlinkedparent()))
            scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self.visuals[0]);
          else if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
            if(!shouldpingobject(var_0)) {
              scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self.visuals[0]);

              if(isDefined(self.objectiveonvisualsoffset3d))
                scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, self.objectiveonvisualsoffset3d[2]);
            } else if(isDefined(self.objectiveonvisualsoffset3d))
              scripts\mp\objidpoolmanager::update_objective_position(var_1, self.curorigin + (0, 0, self.objectiveonvisualsoffset3d[2]));
            else
              scripts\mp\objidpoolmanager::update_objective_position(var_1, self.curorigin);
          } else {
            scripts\mp\objidpoolmanager::update_objective_position(var_1, self.curorigin);
            scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, self.offset3d[2]);
          }
        } else if(isDefined(self.objiconent))
          scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self.objiconent);

        var_7 = 1;
      }
    }
  }
}

shouldpingobject(var_0) {
  if(var_0 == "_encstr_ACFC091AE8AB2FCBE15119" && self.objidpingenemy)
    return 1;
  else if(var_0 == "_encstr_88BF06FD784A6393" && self.objidpingfriendly)
    return 1;

  return 0;
}

getupdateteams(var_0) {
  var_1 = spawnStruct();
  var_1.teams = [];

  foreach(var_3 in level.teamnamelist) {
    var_4 = var_1.teams.size;
    var_1.teams[var_4] = spawnStruct();

    if(var_0 == "_encstr_9A19040BCDBC") {
      var_1.teams[var_4].team = var_3;
      var_1.teams[var_4].showtoteam = 1;
      continue;
    }

    if(var_0 == "_encstr_ACFC091AE8AB2FCBE15119") {
      if(isfriendlyteam(var_3)) {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 1;
      } else {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 0;
      }

      continue;
    }

    if(var_0 == "_encstr_88BF06FD784A6393") {
      if(isfriendlyteam(var_3)) {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 0;
      } else {
        var_1.teams[var_4].team = var_3;
        var_1.teams[var_4].showtoteam = 1;
      }

      continue;
    }

    if(var_0 == "_encstr_8BBA05185F8B99") {
      var_1.teams[var_4].team = var_3;
      var_1.teams[var_4].showtoteam = 0;
    }
  }

  return var_1;
}

getobjectivestate(var_0, var_1) {
  if(var_0 == "_encstr_93B508770F528D90B3DB" || var_1 == "_encstr_93B508770F528D90B3DB")
    return "_encstr_93B508770F528D90B3DB";
  else if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    return "_encstr_A7A408B9CA5D1D4E2C63";
  else
    return "_encstr_AC8A08C76061FB6ABA10";
}

shouldshowcompassduetoradar(var_0) {
  if(!isDefined(self.carrier))
    return 0;

  if(self.carrier scripts\mp\utility\perk::_hasperk("_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693"))
    return 0;

  return getteamradar(var_0);
}

updatevisibilityaccordingtoradar() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D33106C0B39C996CA4EAFB136AC0BC9AC19");

  for(;;) {
    level waittill("_encstr_8E0D141E7E62E35347DFA8082B858B67FAA41FA8572A");
    updatecompassicons();
  }
}

setownerteam(var_0) {
  self.ownerteam = var_0;
  updatetrigger();
  updatecompassicons();

  if(var_0 != "_encstr_A7A408B9CA5D1D4E2C63")
    self.prevownerteam = var_0;
}

getownerteam() {
  return self.ownerteam;
}

setusetime(var_0) {
  self.usetime = int(var_0 * 1000);
}

pinobjiconontriggertouch() {
  self.pinobj = 1;
}

setwaitweaponchangeonuse(var_0) {
  self.waitforweapononuse = var_0;
}

setusetext(var_0) {
  self.usetext = var_0;
}

setteamusetime(var_0, var_1) {
  self.teamusetimes[var_0] = int(var_1 * 1000);
}

setteamusetext(var_0, var_1) {
  self.teamusetexts[var_0] = var_1;
}

setusehinttext(var_0) {
  self.trigger setHintString(var_0);
}

allowcarry(var_0) {
  self.interactteam = var_0;
}

allowuse(var_0) {
  self.interactteam = var_0;
  updatetrigger();
}

squadallowuse(var_0, var_1) {
  if(!isDefined(self.interactsquads))
    self.interactsquads = [];

  if(!isDefined(self.interactsquads[var_0]))
    self.interactsquads[var_0] = [];

  if(!scripts\engine\utility::array_contains(self.interactsquads[var_0], var_1))
    self.interactsquads[var_0][self.interactsquads[var_0].size] = var_1;
}

squaddenyuse(var_0, var_1) {
  if(!isDefined(self.interactsquads))
    self.interactsquads = [];

  if(!isDefined(self.interactsquads[var_0]))
    self.interactsquads[var_0] = [];

  if(scripts\engine\utility::array_contains(self.interactsquads[var_0], var_1))
    self.interactsquads[var_0] = scripts\engine\utility::array_remove(self.interactsquads[var_0], var_1);
}

setvisibleteam(var_0, var_1, var_2) {
  self.visibleteam = var_0;

  if(!istrue(var_2))
    updatecompassicons(var_1);
}

setmodelvisibility(var_0) {
  if(var_0) {
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] show();

      if(self.visuals[var_1].classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" || self.visuals[var_1].classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self.visuals[var_1]))
            var_3 scripts\mp\utility\damage::_suicide();
        }

        self.visuals[var_1] thread makesolid();
      }
    }
  } else {
    for(var_1 = 0; var_1 < self.visuals.size; var_1++) {
      self.visuals[var_1] hide();

      if(self.visuals[var_1].classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" || self.visuals[var_1].classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
        self.visuals[var_1] notify("_encstr_825213862947FBA88BF35FA79B6061587DA01F1717");
        self.visuals[var_1] notsolid();
      }
    }
  }
}

makesolid() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_825213862947FBA88BF35FA79B6061587DA01F1717");
  self endon("_encstr_825213862947FBA88BF35FA79B6061587DA01F1717");

  for(;;) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] istouching(self)) {
        break;
      }
    }

    if(var_0 == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

setcarriervisible(var_0) {
  self.carriervisible = var_0;
}

setcanuse(var_0) {
  self.useteam = var_0;
}

getwaypointshader(var_0) {
  var_1 = level.waypointshader[var_0];

  if(!isDefined(var_1))
    return "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1";

  return var_1;
}

getwaypointbackgroundtype(var_0) {
  var_1 = level.waypointbgtype[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

getwaypointbackgroundcolor(var_0) {
  var_1 = level.waypointcolors[var_0];

  if(!isDefined(var_1))
    return "_encstr_A7A408B9CA5D1D4E2C63";

  return var_1;
}

getwaypointstring(var_0) {
  var_1 = level.waypointstring[var_0];

  if(!isDefined(var_1))
    return "_encstr_84841E2FB9B8805E312DADA70699960813EF97B727C6C80609F6D2FB9FF1EEF0";

  return var_1;
}

getwaypointobjpulse(var_0) {
  var_1 = level.waypointpulses[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

set3duseicon(var_0, var_1) {
  self.worlduseicons[var_0] = var_1;
}

setcarryicon(var_0) {
  self.carryicon = var_0;
}

disableobject() {
  self notify("_encstr_921D09D9D9C0090D7275B4");

  if(self.type == "_encstr_935F0C1B58279C2FD31335AC6C1D") {
    if(isDefined(self.carrier))
      self.carrier takeobject(self);

    for(var_0 = 0; var_0 < self.visuals.size; var_0++)
      self.visuals[var_0] hide();
  }

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("_encstr_8BBA05185F8B99");
}

enableobject() {
  if(self.type == "_encstr_935F0C1B58279C2FD31335AC6C1D") {
    for(var_0 = 0; var_0 < self.visuals.size; var_0++)
      self.visuals[var_0] show();
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("_encstr_9A19040BCDBC");
}

getrelativeteam(var_0) {
  if(var_0 == self.ownerteam)
    return "_encstr_ACFC091AE8AB2FCBE15119";
  else
    return "_encstr_88BF06FD784A6393";
}

isfriendlyteam(var_0) {
  if(self.ownerteam == "_encstr_9A19040BCDBC")
    return 1;

  if(self.ownerteam == var_0)
    return 1;

  if(self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63" && isDefined(self.prevownerteam) && self.prevownerteam == var_0)
    return 1;

  return 0;
}

caninteractwith(var_0, var_1) {
  if(isDefined(var_1) && isDefined(self.interactsquads))
    return isDefined(self.interactsquads[var_1.team]) && scripts\engine\utility::array_contains(self.interactsquads[var_1.team], var_1.squadindex);
  else {
    switch (self.interactteam) {
      case "_encstr_8BBA05185F8B99":
        return 0;
      case "_encstr_9A19040BCDBC":
        return 1;
      case "_encstr_ACFC091AE8AB2FCBE15119":
        if(var_0 == self.ownerteam)
          return 1;
        else
          return 0;
      case "_encstr_88BF06FD784A6393":
        if(var_0 != self.ownerteam)
          return 1;
        else
          return 0;
      default:
        return 0;
    }
  }
}

isteam(var_0) {
  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    return 1;

  if(var_0 == "_encstr_9A19040BCDBC")
    return 1;

  if(var_0 == "_encstr_8BBA05185F8B99")
    return 1;

  foreach(var_2 in level.teamnamelist) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

isrelativeteam(var_0) {
  if(var_0 == "_encstr_ACFC091AE8AB2FCBE15119")
    return 1;

  if(var_0 == "_encstr_88BF06FD784A6393")
    return 1;

  if(var_0 == "_encstr_9A19040BCDBC")
    return 1;

  if(var_0 == "_encstr_8BBA05185F8B99")
    return 1;

  return 0;
}

getlabel() {
  if(!isDefined(self.trigger.script_label))
    return "_encstr_B40101";
  else
    return self.trigger.script_label;
}

initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

mustmaintainclaim(var_0) {
  self.mustmaintainclaim = var_0;
}

cancontestclaim(var_0) {
  self.cancontestclaim = var_0;
}

getleveltriggers() {
  level.minetriggers = getEntArray("_encstr_84D90AA20B9A5A6AE3208D59", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hurttriggers = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");
  level.radtriggers = getEntArray("_encstr_BD3E0A4EC2325A85E82DEDB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ballallowedtriggers = getEntArray("_encstr_991F11EA1CB15A9BDA058DB1DEDDB2C83D9E90", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.nozonetriggers = getEntArray("_encstr_87310E8BD3E9477DB04F966FFD6885BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.droptonavmeshtriggers = getEntArray("_encstr_AA510EB28B7BB8D5F89BBBBB07831369", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();
}

isbombmode() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_917E062D776791E9":
    case "_encstr_9719046E3182":
    case "_encstr_A9190405B4E5":
    case "_encstr_B60703EACA":
    case "_encstr_ACF906B79752C5E8":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      return 1;
    default:
      return 0;
  }
}

unset_relic_bang_and_boom() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_85EF050CB150E7":
    case "_encstr_8E1904B3F501":
      return 1;
    default:
      return 0;
  }
}

touchingdroptonavmeshtrigger(var_0) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501" || scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
      self.visuals[0].origin = var_0;

    foreach(var_2 in level.droptonavmeshtriggers) {
      foreach(var_4 in self.visuals) {
        if(var_4 istouching(var_2))
          return 1;
      }
    }
  }

  return 0;
}

touchingarbitraryuptrigger() {
  if(level.arbitraryuptriggers.size > 0) {
    foreach(var_1 in level.arbitraryuptriggers) {
      if(self istouching(var_1))
        return 1;
    }
  }

  return 0;
}

resetcaptureprogress() {
  if(isDefined(self.teamprogress)) {
    foreach(var_2, var_1 in self.teamprogress)
    self.teamprogress[var_2] = 0;
  }
}

getcaptureprogress() {
  if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
    if(self.claimteam != "_encstr_8BBA05185F8B99")
      return self.teamprogress[self.claimteam] / self.usetime;
    else
      return self.teamprogress[self.lastclaimteam] / self.usetime;
  }

  return 0.0;
}

requestid(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2))
    self.objidnum = scripts\mp\objidpoolmanager::requestreservedid(var_2);
  else
    self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.objidnum != -1) {
    var_5 = "_encstr_8267056410C669";

    if(var_0 && var_1)
      var_5 = "_encstr_AF5A081BBAC993AC73A3";
    else if(var_0)
      var_5 = "_encstr_930B07BB1B6B3854FF";
    else if(var_1)
      var_5 = "_encstr_A2BE0AB4DC3BB46E5A981BAC";

    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, var_5, self.curorigin + self.offset3d);

    if(getdvarint("_encstr_ABA015C39A630898C6F55B37EFEE38F8EBA019EB3087D6", 0) == 1) {
      if(isDefined(var_3) && var_3 == 0) {
        objective_setshowoncompass(self.objidnum, 0);
        self.showoncompass = 0;
      } else
        objective_setshowoncompass(self.objidnum, 1);
    }

    if(isDefined(var_4)) {
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, var_4);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, var_4);
    }

    self.showworldicon = 0;
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);

    if(var_1)
      self.showworldicon = 1;
  }
}

releaseid(var_0, var_1) {
  if(istrue(var_0))
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.objidnum, var_1);
  else
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);

  self.objidnum = -1;
}

getcapturebehavior() {
  if(!isDefined(self.capturebehavior))
    setcapturebehavior("_encstr_820E07FAE8780B3A4C");

  return self.capturebehavior;
}

setcapturebehavior(var_0) {
  self.capturebehavior = var_0;
}

applycaptureprogress(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0);

  switch (getcapturebehavior()) {
    case "_encstr_A74C1063C360CFABADCE2B13D0F49B07F09F":
      self.teamprogress[var_0] = self.teamprogress[var_0] + level.frameduration;
      self.curprogress = self.teamprogress[var_0];
      break;
    case "_encstr_92FC0B5BB01A6B73D09459526B":
      self.teamprogress[var_0] = self.teamprogress[var_0] + var_1;
      self.curprogress = self.teamprogress[var_0];
      break;
    case "_encstr_9A1C0D1BED371DCA373AD7B7DCB15E":
      if(!isDefined(self.ownerteam) || self.ownerteam == var_0) {
        return;
      }
      break;
    case "_encstr_A10F0BD0F2FB41E337D40BFAB5":
      foreach(var_4 in var_2) {
        var_5 = self.teamprogress[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self.teamprogress[var_4] = 0;
            var_1 = var_1 - var_5;
            continue;
          }

          self.teamprogress[var_4] = self.teamprogress[var_4] - var_1;
          var_1 = 0;
          self.curprogress = self.teamprogress[var_4];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(var_1 > 0) {
        self.teamprogress[var_0] = self.teamprogress[var_0] + var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
    case "_encstr_842716DE9B365EAF0BB9CD7B1BB42CE8B246EBE8AC2CD69B":
      if(!isDefined(self.associatedteams) || !scripts\engine\utility::array_contains(self.associatedteams, var_0)) {
        return;
      }
      foreach(var_4 in var_2) {
        var_5 = self.teamprogress[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self.teamprogress[var_4] = 0;
            var_1 = var_1 - var_5;
            continue;
          }

          self.teamprogress[var_4] = self.teamprogress[var_4] - var_1;
          var_1 = 0;
          self.curprogress = self.teamprogress[var_4];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(var_1 > 0) {
        self.teamprogress[var_0] = self.teamprogress[var_0] + var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
    case "_encstr_BDFB154710895FC3DBD8F932802DFB4FA385EFCFB8F08F":
      if(var_0 != self.team) {
        return;
      }
      if(var_0 == self.team) {
        foreach(var_10 in var_2) {
          if(self.numtouching[var_10] > 0)
            return;
        }
      }

      self.teamprogress[var_0] = self.teamprogress[var_0] + var_1;
      self.curprogress = self.teamprogress[var_0];
      break;
    default:
      var_12 = self.teamprogress[var_0];
      var_12 = var_12 + var_1;
      var_13 = 0;
      var_14 = getnumtouchingforteam(var_0);
      var_15 = getnumtouchingexceptteam(var_0);

      if(var_14 && var_15 && var_14 != var_15)
        var_13 = 1;

      if(istrue(self.majoritycapprogress) && var_12 >= self.usetime * 0.95 && istrue(var_13)) {
        if(self.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          foreach(var_0 in level.teamnamelist) {
            if(self.touchlist[var_0].size) {
              var_17 = self.touchlist[var_0];
              var_18 = getarraykeys(var_17);

              for(var_19 = 0; var_19 < var_18.size; var_19++) {
                var_20 = var_17[var_18[var_19]].player;
                var_20 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 4);
              }

              break;
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E");
        } else {
          foreach(var_0 in level.teamnamelist) {
            if(var_0 == self.ownerteam) {
              if(self.touchlist[var_0].size) {
                var_17 = self.touchlist[var_0];
                var_18 = getarraykeys(var_17);

                for(var_19 = 0; var_19 < var_18.size; var_19++) {
                  var_20 = var_17[var_18[var_19]].player;
                  var_20 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 4);
                }

                break;
              }
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F");
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E");
        }
      } else {
        if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63") {
          if(self.ownerteam != var_0)
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9");
        }

        self.teamprogress[var_0] = self.teamprogress[var_0] + var_1;
        self.curprogress = self.teamprogress[var_0];
      }

      break;
  }
}

createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_11 makeusable();

  if(isDefined(var_1))
    var_11 setCursorHint(var_1);
  else
    var_11 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  if(isDefined(var_2))
    var_11 sethinticon(var_2);

  if(isDefined(var_3))
    var_11 setHintString(var_3);

  if(isDefined(var_4))
    var_11 setusepriority(var_4);
  else
    var_11 setusepriority(0);

  if(isDefined(var_5))
    var_11 setuseholdduration(var_5);
  else
    var_11 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_6))
    var_11 sethintonobstruction(var_6);
  else
    var_11 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    var_11 sethintdisplayrange(var_7);
  else
    var_11 sethintdisplayrange(200);

  if(isDefined(var_8))
    var_11 sethintdisplayfov(var_8);
  else
    var_11 sethintdisplayfov(160);

  if(isDefined(var_9))
    var_11 setuserange(var_9);
  else
    var_11 setuserange(50);

  if(isDefined(var_10))
    var_11 setusefov(var_10);
  else
    var_11 setusefov(120);

  return var_11;
}

sethintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    var_3 = undefined;

  self makeusable();

  if(isDefined(var_0))
    self sethinttag(var_0);

  if(isDefined(var_1))
    self setCursorHint(var_1);
  else
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  if(isDefined(var_2))
    self sethinticon(var_2);

  if(isDefined(var_3))
    self setHintString(var_3);

  if(isDefined(var_4))
    self setusepriority(var_4);
  else
    self setusepriority(0);

  if(isDefined(var_5))
    self setuseholdduration(var_5);
  else
    self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_6))
    self sethintonobstruction(var_6);
  else
    self sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    self sethintdisplayrange(var_7);
  else
    self sethintdisplayrange(200);

  if(isDefined(var_8))
    self sethintdisplayfov(var_8);
  else
    self sethintdisplayfov(160);

  if(isDefined(var_9))
    self setuserange(var_9);
  else
    self setuserange(50);

  if(isDefined(var_10))
    self setusefov(var_10);
  else
    self setusefov(120);
}

createobjidobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_6.curorigin = var_0;
  var_6.ownerteam = var_1;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_6.offset3d = var_2;
  var_6 requestid(1, 1, var_3, var_5);
  var_6.compassicons = [];
  var_6.interactteam = "_encstr_8BBA05185F8B99";

  if(isDefined(var_4))
    var_6.visibleteam = var_4;
  else
    var_6.visibleteam = "_encstr_8BBA05185F8B99";

  return var_6;
}

isrevivetrigger() {
  if(isDefined(self.id) && self.id == "_encstr_9A43124032FAC143E35908750F93C99D24EBB038")
    return 1;

  return 0;
}