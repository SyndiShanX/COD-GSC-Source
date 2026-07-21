/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\player.gsc
***********************************************/

getstancecenter() {
  if(self getstance() == "_encstr_B13D076BED70539F23")
    var_0 = self.origin + (0, 0, 24);
  else if(self getstance() == "_encstr_922406F1A6FD5E05")
    var_0 = self.origin + (0, 0, 10);
  else
    var_0 = self.origin + (0, 0, 32);

  return var_0;
}

round_smoke_logic() {
  if(self getstance() == "_encstr_B13D076BED70539F23")
    var_0 = self.origin + (0, 0, 48);
  else if(self getstance() == "_encstr_922406F1A6FD5E05")
    var_0 = self.origin + (0, 0, 20);
  else
    var_0 = self.origin + (0, 0, 64);

  return var_0;
}

isreallyalive(var_0) {
  return isalive(var_0) && !isDefined(var_0.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

isarchetype(var_0) {
  return isDefined(self.loadoutarchetype) && var_0 == self.loadoutarchetype;
}

isplayerads() {
  return self playerads() > 0.5;
}

setthirdpersondof(var_0) {
  if(var_0)
    setdof_thirdperson();
  else
    setdof_default();
}

updatesessionstate(var_0, var_1) {
  switch (var_0) {
    case "_encstr_877508C1D8C22F2DDC3B":
    case "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258":
      var_1 = "_encstr_B40101";
      break;
    case "_encstr_84670547C3E9F4":
    case "_encstr_AF8C0A1B6A1D6045925B4F7D":
      if(istrue(level.doingbroshot))
        var_1 = "_encstr_B40101";
      else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable))
          var_1 = "_encstr_816912E0BB7B4878C3B93923B36188280FC35989";
        else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "_encstr_B1A81513C04D71C7BB082B439B4F93BB0337DB65690878")
            var_1 = "_encstr_B1A81513C04D71C7BB082B439B4F93BB0337DB65690878";
          else
            var_1 = "_encstr_A6A81504CF8F27D653378B3F4BC7E2389B63D3A7CF93F3";
        } else
          var_1 = "_encstr_8D2810A1EA91AFE6E816D1D5E6BE8C59C28C";
      } else
        var_1 = "_encstr_8D2810A1EA91AFE6E816D1D5E6BE8C59C28C";

      break;
  }

  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  self.sessionstate = var_0;
  self.statusicon = var_1;
  self setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", var_0);
}

getteamarray(var_0, var_1) {
  var_2 = [];

  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(isDefined(var_4.team) && var_4.team == var_0)
        var_2[var_2.size] = var_4;
    }
  } else {
    foreach(var_4 in level.players) {
      if(isDefined(var_4.team) && var_4.team == var_0)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

get_players_watching(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(isDefined(var_5.team) && (var_5.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_5.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")) {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self)
          var_6 = 1;
      }

      if(var_5.forcespectatorclient == var_2)
        var_6 = 1;
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2)
        var_6 = 1;
    }

    if(var_6)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");

    if(isDefined(var_3) && var_3)
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    else
      var_8 visionsetnakedforplayer(var_0, var_1);

    if(var_0 != "_encstr_B40101" && isDefined(var_2)) {
      var_8 thread reset_visionset_on_team_change(self, var_1 + var_2);
      var_8 thread reset_visionset_on_disconnect(self);

      if(var_8 isinkillcam())
        var_8 thread reset_visionset_on_spawn();
    }
  }
}

reset_visionset_on_spawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BA350853C128FB939DB9");
  self visionsetnakedforplayer("_encstr_B40101", 0.0);
}

reset_visionset_on_team_change(var_0, var_1) {
  self endon("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 get_players_watching(), self)) {
      self visionsetnakedforplayer("_encstr_B40101", 0.0);
      self notify("_encstr_932313AE040AC5F979B338012B81B303322D1E259B");
      break;
    }

    waitframe();
  }
}

reset_visionset_on_disconnect(var_0) {
  self endon("_encstr_A6D61C1B3458B9EC4BB9ECFADD5847360DA5373BEBEC96DC5ADE7337CA1D");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self visionsetnakedforplayer("_encstr_B40101", 0.0);
}

restorebasevisionset(var_0) {
  if(istrue(level.wpinprogress)) {
    return;
  }
  self visionsetnakedforplayer("_encstr_B40101", var_0);
}

init_visionsetnight() {
  if(isDefined(level._id_11F4A) && isstring(level._id_11F4A))
    visionsetnight(level._id_11F4A);
  else
    visionsetnight("_encstr_B1A70C73B3ECF53185DC59BE6B83");
}

overridevisionsetnightforlevel(var_0) {
  visionsetnight(var_0);
  level._id_11F4A = var_0;
}

_id_12C86() {
  level._id_11F4A = undefined;
  visionsetnight("_encstr_B1A70C73B3ECF53185DC59BE6B83");
}

isenemy(var_0) {
  if(level.teambased)
    return var_0.team != self.team;
  else if(isDefined(var_0.owner))
    return var_0.owner != self;
  else
    return var_0 != self;
}

getuniqueid() {
  if(!isDefined(self.pers))
    self.pers = [];

  if(isDefined(self.pers["_encstr_917205E4A0C380"]))
    return self.pers["_encstr_917205E4A0C380"];

  var_0 = self getguid();

  if(var_0 == "_encstr_81FB113061820ACA17131F272B2F8242DA0948") {
    if(isDefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    var_0 = "_encstr_AC29077FFB0AD8B75B" + level.guidgen;
  }

  self.pers["_encstr_917205E4A0C380"] = var_0;
  return self.pers["_encstr_917205E4A0C380"];
}

getplayersinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  return scripts\cp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

getplayersinradiusview(var_0, var_1, var_2, var_3) {
  var_4 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  var_5 = [];
  var_6 = scripts\cp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));

  foreach(var_8 in var_6) {
    var_9 = undefined;
    var_10 = [var_8 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_8 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_8 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(!scripts\engine\trace::ray_trace_passed(var_0, var_10[var_11], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }
      if(!isDefined(var_9)) {
        var_5[var_5.size] = spawnStruct();
        var_5[var_5.size - 1].player = var_8;
        var_5[var_5.size - 1].visiblelocations = [];
        var_9 = 1;
      }

      var_5[var_5.size - 1].visiblelocations[var_5[var_5.size - 1].visiblelocations.size] = var_10[var_11];
    }
  }

  return var_5;
}

isfriendly(var_0, var_1) {
  if(!level.teambased)
    return 0;

  if(!isPlayer(var_1) && !isDefined(var_1.team))
    return 0;

  if(var_0 != var_1.team)
    return 0;

  return 1;
}

_enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies))
    self.enabledcollisionnotifies = 0;

  if(var_0) {
    if(self.enabledcollisionnotifies == 0)
      self enablecollisionnotifies(1);

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1)
      self enablecollisionnotifies(0);

    self.enabledcollisionnotifies--;
  }
}

allow_dodge(var_0) {
  if(self.loadoutarchetype != "_encstr_965C10C227B143CA1D5E38B27DCD36BDBAA3") {
    return;
  }
  if(var_0) {
    if(!isDefined(self.disableddodge))
      self.disableddodge = 0;

    self.disableddodge--;

    if(!self.disableddodge)
      self allowdodge(1);
  } else {
    if(!isDefined(self.disableddodge))
      self.disableddodge = 0;

    self.disableddodge++;
    self allowdodge(0);
  }
}

allow_gesture(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_8F0508CE59DCA357392B", var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0) {
    if(scripts\engine\utility::is_player_gamepad_enabled())
      self setactionslot(1, "_encstr_AD2906FBFA7593E3");
    else
      self setactionslot(7, "_encstr_AD2906FBFA7593E3");
  } else if(scripts\engine\utility::is_player_gamepad_enabled())
    self setactionslot(1, "_encstr_B40101");
  else
    self setactionslot(7, "_encstr_B40101");
}

isplayerproxyagent(var_0, var_1) {
  var_2 = 0;

  if(isagent(var_0) && isDefined(var_0.agent_type) && var_0.agent_type == "_encstr_811D0C63ED6F2733535F5B48F21B") {
    if(var_0.owner == var_1)
      var_2 = 1;
  }

  return var_2;
}

enableragdollzerog(var_0, var_1) {
  if(var_0) {
    physics_setgravityragdollscalar(var_1);
    level.ragdollzerog = 1;
  } else {
    physics_setgravityragdollscalar(1.0);
    level.ragdollzerog = undefined;
  }
}

isragdollzerog() {
  return istrue(level.ragdollzerog);
}

_visionsetnaked(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isai(var_3)) {
      continue;
    }
    var_3 visionsetnakedforplayer(var_0, var_1);
  }

  return;
}

hidehudenable() {
  if(!isDefined(self.ui_hudhidden))
    self.hidehudenabled = 0;

  if(self.hidehudenabled == 0)
    self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);

  self.hidehudenabled++;
}

hidehuddisable() {
  if(self.hidehudenabled == 1)
    self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);

  self.hidehudenabled--;
}

hideminimap(var_0) {
  if(alwaysshowminimap() && !istrue(var_0)) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  var_1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0)
    self.minimapstatetracker = 0;

  if(istrue(var_0) || self.minimapstatetracker == 0 && var_1 > self.minimapstatetracker) {
    self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);

    if(istrue(var_0))
      self.minimapstatetracker = 0;
  }
}

showminimap() {
  if(scripts\cp\utility::trophy_get_part_by_tag()) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  var_0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var_0 < self.minimapstatetracker)
    self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
}

alwaysshowminimap() {
  return istrue(level.minimaponbydefault) || level.gametype == "_encstr_B607038AAB" || level.gametype == "_encstr_BA1904921B3B";
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39";
}

getlowestclientnum(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && (!var_1 || var_4 scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(var_2) || var_4 getentitynumber() < var_2)
        var_2 = var_4 getentitynumber();
    }
  }

  return var_2;
}

setusingremote(var_0) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_0;
  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_ads(0);
  self setclientomnvar("_encstr_85DD1BD3A8285F52D845C7F767F0DD636663DB5A319A3FCA405BF7C403", 1);
  self notify("_encstr_86070DEB73A488448FCB4970221B0D");
}

getremotename() {
  return self.usingremote;
}

clearusingremote(var_0) {
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    scripts\cp\utility::_freezecontrols(0);
  }

  self setclientomnvar("_encstr_85DD1BD3A8285F52D845C7F767F0DD636663DB5A319A3FCA405BF7C403", 0);
  self notify("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
}

isusingremote() {
  return isDefined(self.usingremote);
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0)
      return var_2;
  }

  return undefined;
}

set_temp_energy_restore_rate(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getrestorerate(var_0);
  self.temprateset = 1;
  self energy_setrestorerate(var_0, var_1);

  if(!isDefined(var_3) || !var_3)
    wait(var_2);
  else {
    var_5 = self energy_getmax(var_0);

    for(;;) {
      if(self energy_getenergy(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setrestorerate(var_0, var_4);
  self.temprateset = 0;
}

set_temp_energy_rest_time(var_0, var_1, var_2, var_3) {
  var_4 = self energy_getresttimems(var_0);
  self.tempresttime = 1;
  self energy_setresttimems(var_0, var_1);

  if(!isDefined(var_3) || !var_3)
    wait(var_2);
  else {
    var_5 = self energy_getmax(var_0);

    for(;;) {
      if(self energy_getenergy(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self energy_setresttimems(var_0, var_4);
  self.tempresttime = 0;
}

_enableignoreme() {
  if(!isDefined(self.enabledignoreme))
    self.enabledignoreme = 0;

  if(self.enabledignoreme == 0)
    self.ignoreme = 1;

  self.enabledignoreme++;
}

_disableignoreme() {
  if(self.enabledignoreme == 1)
    self.ignoreme = 0;

  self.enabledignoreme--;
}

_resetenableignoreme() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

watchbuttonPressed(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.buttonspressed))
    self.buttonspressed = [];

  if(!isDefined(self.buttonspressed[var_0])) {
    var_4 = spawnStruct();
    var_4.player = self;
    var_4.key = var_0;
    var_4.commanddown = var_1;
    var_4.commandup = var_2;
    var_4.notifydown = var_0 + "_encstr_92930C2E29A549FDE84E0537A8A0";
    var_4.notifyup = var_0 + "_encstr_B8860AD1699DFB3348E51538";
    var_4.pressed = istrue(var_3);
    self.buttonspressed[var_0] = var_4;
    var_4 thread watchbuttonpressedinternal();
  }
}

getbuttonPressed(var_0) {
  if(!isDefined(self.buttonspressed))
    return 0;

  if(!isDefined(self.buttonspressed[var_0]))
    return 0;

  return self.buttonspressed[var_0].pressed;
}

watchbuttonpressedend(var_0) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[var_0]) {
    return;
  }
  self.buttonspressed[var_0] notify("_encstr_A2EE160837C4C17980C3ADB55D9AD12B3D87A02B8B4D3829");
  self.buttonspressed[var_0] = undefined;
}

watchbuttonpressedinternal() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A2EE160837C4C17980C3ADB55D9AD12B3D87A02B8B4D3829");

  for(;;) {
    self.down = 0;
    self.up = 0;
    childthread watchbuttondown();
    childthread watchbuttonup();
    self waittill("_encstr_AB830B932B1763B3495DA1AB1B");
    waittillframeend;
    self notify("_encstr_A15C098556ABD6A51E7A78");

    if(self.down && self.up) {
      continue;
    }
    if(self.down) {
      self.pressed = 1;
      continue;
    }

    self.pressed = 0;
  }
}

watchbuttondown() {
  self endon("_encstr_A15C098556ABD6A51E7A78");
  self.player notifyonplayercommand(self.notifydown, self.commanddown);
  self.player waittill(self.notifydown);
  self.down = 1;
  self notify("_encstr_AB830B932B1763B3495DA1AB1B");
}

watchbuttonup() {
  self endon("_encstr_A15C098556ABD6A51E7A78");
  self.player notifyonplayercommand(self.notifyup, self.commandup);
  self.player waittill(self.notifyup);
  self.up = 1;
  self notify("_encstr_AB830B932B1763B3495DA1AB1B");
}

watchbuttonpressendondisconnect() {
  self endon("_encstr_A2EE160837C4C17980C3ADB55D9AD12B3D87A02B8B4D3829");
  self.player waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A2EE160837C4C17980C3ADB55D9AD12B3D87A02B8B4D3829");
}

_setdof_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(1) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  var_0 = max(var_0, 0.0);
  var_1 = clamp(var_1, 1.0, 9994.0);
  var_2 = clamp(var_2, 2.0, 9998.0);
  var_3 = clamp(var_3, 3.0, 9999);

  if(var_2 > 9994.0)
    var_5 = 0.0;
}

setdof_dynamic() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  setdof_default();

  if(isai(self)) {
    return;
  }
  var_0 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  var_9["_encstr_88180476B2B7"] = spawnStruct();
  var_9["_encstr_88180476B2B7"].nearstartfactor = getdvarfloat("_encstr_85AB127810CF67152A9F2337E3BFEDC15F6A9FE7", 0.01);
  var_9["_encstr_88180476B2B7"].nearendfactor = getdvarfloat("_encstr_B6EF10E24894D735987BB28D0DF8316F4DE0", 0.95);
  var_9["_encstr_88180476B2B7"].farstartfactor = getdvarfloat("_encstr_81971174B8C1779FC368C1ABE83DD3BF5915F7", 1.5);
  var_9["_encstr_88180476B2B7"].farendfactor = getdvarfloat("_encstr_AA450F5AF02C5FBF20D57D2E81A987FFC0", 2.5);
  var_9["_encstr_88180476B2B7"].nearblur = getdvarfloat("_encstr_84F911D04F960635B286EEEEDDEB554EFF1F7B", 3.9);
  var_9["_encstr_88180476B2B7"].farblur = getdvarfloat("_encstr_977310C0127F5721778ADE3165D3CEFF67BA", 2.25);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"] = spawnStruct();
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearstartfactor = getdvarfloat("_encstr_BA7A0E7D952AF78825BFA0B1F37943E9", 0.01);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearendfactor = getdvarfloat("_encstr_8CD40C5A60D5C1ABA1B772BDD869", 0.95);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farstartfactor = getdvarfloat("_encstr_ACE90DDF223129A007A8D1FB099363", 1.5);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farendfactor = getdvarfloat("_encstr_A2E60B6AC01C4FAF30A50D3E91", 2.5);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].nearblur = getdvarfloat("_encstr_A6790D5AF02C5FBD2BF34A0291F8C2", 7.0);
  var_9["_encstr_92F109A5B9E8ACC92B9BD1"].farblur = getdvarfloat("_encstr_97590CE2FF3317017638F0239512", 3.5);

  for(;;) {
    waitframe();
    var_10 = "_encstr_88180476B2B7";

    if(istrue(self.usingcustomdof)) {
      continue;
    }
    var_11 = self playerads() > 0.9;

    if(var_7 && !var_11) {
      if(var_8) {
        var_8 = 0;
        _setdof_internal(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    var_12 = self getEye();
    var_13 = self getplayerangles();
    var_14 = anglesToForward(var_13);
    var_15 = -1;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = undefined;
    var_19 = undefined;

    if(var_4) {
      var_20 = 0;

      foreach(var_22 in level.players) {
        if(!scripts\cp_mp\utility\player_utility::playersareenemies(self, var_22)) {
          continue;
        }
        if(!var_22 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        var_23 = var_22 getEye();
        var_24 = vectordot(var_14, vectorNormalize(var_23 - var_12));

        if(var_24 < var_6) {
          continue;
        }
        var_25 = distance(var_12, var_23);

        if(!isDefined(var_16) || var_25 < var_16) {
          if(var_22 sightconetrace(var_12, self) > 0)
            var_16 = var_25;
        }

        if(!isDefined(var_17) || var_25 > var_17) {
          if(var_22 sightconetrace(var_12, self) > 0)
            var_17 = var_25;
        }
      }
    }

    var_27 = var_12 + var_14 * 10000;
    var_28 = scripts\engine\trace::sphere_trace(var_12, var_27, 0.1, self, var_1, 0);
    var_19 = distance(var_12, var_28["_encstr_BD260953AA97E3F014279D"]);
    var_29 = scripts\engine\trace::sphere_trace(var_12, var_27, 20.0, self, var_3, 0);
    var_30 = var_29["_encstr_850E077B0BF30318B9"];
    var_31 = isDefined(var_30) && isPlayer(var_30) && scripts\cp_mp\utility\player_utility::playersareenemies(self, var_30);
    var_32 = var_31 && var_30 sightconetrace(var_12, self) > 0;

    if(!isDefined(var_16) || var_19 < var_16)
      var_16 = var_19;

    if(!isDefined(var_17) || var_19 > var_17)
      var_17 = var_19;

    var_8 = 1;
    var_33 = max(abs(var_16 - var_17) * 0.5, 300.0);
    var_34 = 0.0;
    var_35 = max(var_16 - 50.0, 1.0);
    var_36 = var_17 + 50.0;
    var_37 = var_36 + var_33;
    var_38 = scripts\engine\utility::ter_op(var_32, 6.0, 4.0);
    var_39 = scripts\engine\utility::ter_op(var_32, 2.5, 1.25);
    _setdof_internal(var_34, var_35, var_36, var_37, var_38, var_39);
  }
}

setdof_killer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

setdof_killer_update() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8D831549924785F861D46379F9D07944CFBA6053AA8F35");
  var_0 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120.0;
  var_5 = scripts\engine\trace::sphere_trace(var_3, var_4, 2.0, self, var_1, 0);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var_7 = distance(var_6, self.lastkilledby.origin);
    var_8 = 0.0;
    var_9 = max(var_7 - 12.0, 1.0);
    var_10 = var_7 + 12.0;
    var_11 = var_10 + 50.0;
    var_12 = 8.0;
    var_13 = 4.5;
    _setdof_internal(var_8, var_9, var_10, var_11, var_12, var_13);
    waitframe();
  }
}

setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_spectator() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_infil() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

setdof_apache() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisefirst() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_tank() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 120, 1000, 6500, 7, 3.5);
}

setdof_thirdperson() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 110, 512, 4096, 6, 1.8);
}

setdof_gunship() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_gunship_zoom() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 10, 5);
}

setdof_scrambler_strength_1() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 5000, 4, 3.5);
}

setdof_scrambler_strength_2() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 800, 4000, 4.5, 3.5);
}

setdof_scrambler_strength_3() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 600, 3000, 5, 3.5);
}

setdof_scrambler_strength_4() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 500, 2000, 5.5, 3.5);
}

setdof_scrambler_strength_5() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 400, 1000, 6, 3.5);
}

enableplayerforspawnlogic(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_AA780D4E5191F73BBF0CA910C796B2", var_0, var_1);

  if(isDefined(var_2))
    self ignorecharacterduringspawnselection(!var_2);
}

isplayerallowedforspawnlogic() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AA780D4E5191F73BBF0CA910C796B2");
}

clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.archiveusepotg = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

isinkillcam() {
  if(isai(self))
    return 0;

  if(self.spectatekillcam) {
    if(self.forcespectatorclient == -1 && self.killcamentity == -1)
      return 0;
  }

  return self.spectatekillcam;
}

waittillrecoveredhealth(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = 0;

  if(!isDefined(var_1))
    var_1 = 0.05;

  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    if(self.health != self.maxhealth)
      var_2 = 0;
    else
      var_2 = var_2 + var_1;

    wait(var_1);

    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }

  return;
}

allow_health_regen(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_A9350D834DDE8871B8C7AD38FF21E2", var_0, var_1);
}

is_health_regen_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A9350D834DDE8871B8C7AD38FF21E2");
}

allow_one_hit_melee_victim(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F", var_0, var_1);
}

is_one_hit_melee_victim_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F");
}

allow_flashed(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_8E400866D8589B1AB2C8", var_0, var_1);
}

is_allowed_to_be_flashed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_8E400866D8589B1AB2C8");
}

allow_stunned(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_8ED90887F39B73AD5BFF", var_0, var_1);
}

is_allowed_to_be_stunned() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_8ED90887F39B73AD5BFF");
}

allow_stick_kill(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_83290B682399813F110463F9DD", var_0, var_1);
}

is_stick_kill_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_83290B682399813F110463F9DD");
}

_setsuit(var_0) {
  self setsuit(var_0);
  self.suit = var_0;
}

earthquake_for_client(var_0, var_1) {
  if(!isDefined(self.eq))
    init_earthquake_for_client();

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = undefined;

  if(var_1)
    var_2 = level.eqforclient.partnamesview[var_0];
  else
    var_2 = level.eqforclient.partnames[var_0];

  var_3 = self.eq.curstates[var_2];
  var_4 = "_encstr_930B07BB1B6B3854FF" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4)
    var_3 = scripts\engine\utility::mod(var_3, 4);

  self.eq.curstates[var_2] = var_3;
}

clear_earthquake_for_client() {
  if(!isDefined(self.eq)) {
    return;
  }
  if(!isDefined(level.eqforclient))
    init_earthquake();

  foreach(var_1 in level.eqforclient.partnames)
  self setscriptablepartstate(var_1, "_encstr_A7A408B9CA5D1D4E2C63", 0);

  foreach(var_1 in level.eqforclient.partnamesview)
  self setscriptablepartstate(var_1, "_encstr_A7A408B9CA5D1D4E2C63", 0);

  self.eq = undefined;
}

rumble_for_client(var_0, var_1) {
  if(!isDefined(self.rumb))
    init_rumble_for_client();

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = undefined;

  if(var_1)
    var_2 = level.rumbforclient.partnamesview[var_0];
  else
    var_2 = level.rumbforclient.partnames[var_0];

  var_3 = self.rumb.curstates[var_2];
  var_4 = "_encstr_930B07BB1B6B3854FF" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4)
    var_3 = scripts\engine\utility::mod(var_3, 4);

  self.rumb.curstates[var_2] = var_3;
}

clear_rumble_for_client() {
  if(!isDefined(self.rumb)) {
    return;
  }
  foreach(var_1 in level.rumbforclient.partnames)
  self setscriptablepartstate(var_1, "_encstr_A7A408B9CA5D1D4E2C63", 0);

  foreach(var_1 in level.rumbforclient.partnamesview)
  self setscriptablepartstate(var_1, "_encstr_A7A408B9CA5D1D4E2C63", 0);

  self.rumb = undefined;
}

init_earthquake() {
  level.eqforclient = spawnStruct();
  var_0 = [];
  var_1 = "_encstr_82A308B0AA76E799AF31";

  for(var_2 = 1; var_2 <= 4; var_2++)
    var_0[var_2] = var_1 + var_2;

  level.eqforclient.partnames = var_0;
  var_0 = [];
  var_1 = "_encstr_B1E60CDC3485B556AC2E9DD22B77";

  for(var_2 = 1; var_2 <= 4; var_2++)
    var_0[var_2] = var_1 + var_2;

  level.eqforclient.partnamesview = var_0;
}

init_earthquake_for_client() {
  if(!isDefined(level.eqforclient))
    init_earthquake();

  self.eq = spawnStruct();
  var_0 = [];

  foreach(var_2 in level.eqforclient.partnames)
  var_0[var_2] = 1;

  foreach(var_2 in level.eqforclient.partnamesview)
  var_0[var_2] = 1;

  self.eq.curstates = var_0;
}

init_rumble() {
  level.rumbforclient = spawnStruct();
  var_0 = [];
  var_1 = "_encstr_86880ACD4358B52B4ED5AD13";

  for(var_2 = 1; var_2 <= 4; var_2++)
    var_0[var_2] = var_1 + var_2;

  level.rumbforclient.partnames = var_0;
  var_0 = [];
  var_1 = "_encstr_A7C90E1BFC63725F9DB05319CCAFD763";

  for(var_2 = 1; var_2 <= 4; var_2++)
    var_0[var_2] = var_1 + var_2;

  level.rumbforclient.partnamesview = var_0;
}

init_rumble_for_client() {
  if(!isDefined(level.rumbforclient))
    init_rumble();

  self.rumb = spawnStruct();
  var_0 = [];

  foreach(var_2 in level.rumbforclient.partnames)
  var_0[var_2] = 1;

  foreach(var_2 in level.rumbforclient.partnamesview)
  var_0[var_2] = 1;

  self.rumb.curstates = var_0;
}