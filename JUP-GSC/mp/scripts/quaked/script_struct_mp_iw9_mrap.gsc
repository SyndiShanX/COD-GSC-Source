/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\quaked\script_struct_mp_iw9_mrap.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\customization\battle_tracks;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_69b5676020104b55;

function main() {
  function_c0b3ddc9a6bdcc46("veh9_mil_lnd_mrap", &function_8385e33cb3e5e39e);
}

function private function_8385e33cb3e5e39e() {
  if(!function_9697379150687859("veh9_mil_lnd_mrap")) {
    return;
  }

  if(utility::iscp()) {
    return;
  }

  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  assertex(!isDefined(level.vehicle.mrap), "<dev string:x49>");
  callbacks = [];
  callbacks["spawn"] = &function_c02dd63d8657cf38;
  callbacks["delete"] = &function_72b740c96f213c47;
  callbacks["enterStart"] = &function_517bcf849b4ec232;
  callbacks["enterEnd"] = &function_edfacde58cb56417;
  callbacks["exitEnd"] = &function_ccd9db63cabe6ff1;
  callbacks["reenter"] = &function_a4d7a7606411e415;
  callbacks["createGrenadeTurret"] = &function_fcacbcc0004574a0;
  callbacks["exitExternalTurret"] = &function_1346cdf1abb57e5b;
  function_8497e7e46b5e397("veh9_mil_lnd_mrap", callbacks);
  leveldataforvehicle = vehomn_getleveldataforvehicle("veh9_mil_lnd_mrap", 1);
  leveldataforvehicle.ammoids["popsmoke"] = 1;
  level.vehicle.mrap = spawnStruct();
  level.vehicle.mrap.canautodestruct = 1;
}

function private function_c02dd63d8657cf38(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh9_mil_lnd_mrap", spawndata, faildata);
  var_42691f43db8e6783 = function_4c0a67070435b7be();
  mgturret = function_994f2f7fd7a2bbdb(vehicle, "iw9_mg_mrap_mp", "veh9_mil_lnd_mrap_turret_gun", var_42691f43db8e6783.tag, var_42691f43db8e6783.tagoffset, var_42691f43db8e6783.exitoffset);
  vehicle_registerturret(vehicle, mgturret, makeweapon("iw9_mg_mrap_mp"));
  vehicle.mgturret = mgturret;

  if(!istrue(spawndata.var_427538f5a2ad4f8b)) {
    turret = function_fcacbcc0004574a0(vehicle, spawndata);
    vehicle_registerturret(vehicle, turret, makeweapon("iw9_tur_mrap_mp"));
  } else if(isDefined(spawndata.var_14cde247ac3313a4)) {
    vehicle.var_fadc8ce0c904abda = spawndata.var_14cde247ac3313a4;
  }

  if(istrue(spawndata.var_65da0a245b653cc)) {
    vehicle.occupantsreserving["gunner"] = vehicle;
    vehicle.var_65da0a245b653cc = 1;
  }

  if(istrue(spawndata.var_d04816fe2f5bcee6)) {
    vehicle.fuel = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh9_mil_lnd_mrap").maxfuel;
  }

  vehicle.var_ec76ffdbe2f37c5b = istrue(spawndata.var_ec76ffdbe2f37c5b);
  vehicle.var_b3c822af793d474f = [];
  vehicle.var_9cd07317ba52df4 = !vehicle.var_ec76ffdbe2f37c5b;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    vehicle.var_c2594ac36ee74a08 = 35;
  } else {
    vehicle.var_c2594ac36ee74a08 = 10;
  }

  vehicle thread function_9c0fbc8660be15b7();
  return vehicle;
}

function private function_fcacbcc0004574a0(vehicle, spawndata) {
  weaponname = "iw9_tur_mrap_mp";
  turret = spawnturret("misc_turret", vehicle gettagorigin("tag_turret_front"), weaponname, 0);
  turret linkTo(vehicle, "tag_turret_front", (0, 0, 0), (0, 0, 0));
  model = "veh9_mil_lnd_mrap_turret_grenade";

  if(isDefined(spawndata.var_14cde247ac3313a4)) {
    model = spawndata.var_14cde247ac3313a4 + "::" + model;
  }

  turret setModel(model);
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  vehicle thread function_6546f94c0980e1dd(turret);
  return turret;
}

function private function_6546f94c0980e1dd(turret) {
  self endon("death");

  while(true) {
    turret waittill("missile_fire", grenade);
    grenade.owner = turret.owner;
  }
}

function private function_4c0a67070435b7be() {
  var_42691f43db8e6783 = spawnStruct();
  var_42691f43db8e6783.tag = "tag_turret";
  var_42691f43db8e6783.tagoffset = (0, 0, 0);
  var_42691f43db8e6783.exitoffset = (-40, 0, 11);
  return var_42691f43db8e6783;
}

function private function_994f2f7fd7a2bbdb(vehicle, turret_weapon, turret_model, turret_tag, var_f7c8fc384585fa86, var_721f077d971e21d5) {
  turret = spawnturret("misc_turret", vehicle gettagorigin(turret_tag), turret_weapon, 0);
  turret linkTo(vehicle, turret_tag, var_f7c8fc384585fa86, (0, 0, 0));
  turret setModel(turret_model);
  turret makeunusable();
  turret setmode("sentry_offline");
  turret setdefaultdroppitch(30);
  turret setturretmodechangewait(1);
  useradius = getdvarfloat(@ "hash_b1bcf912f9600c0e", 150);
  hintpos = turret gettagorigin("tag_origin");

  if(scripts\engine\utility::issharedfuncdefined("vehicle", "createHint")) {
    turret.useobject = [[scripts\engine\utility::getsharedfunc("vehicle", "createHint")]](hintpos, "HINT_BUTTON", undefined, &"VEHICLES_HINTS/USE_TURRET", -1, "duration_none", "show", useradius, undefined, useradius);
  }

  turret.useobject linkTo(turret, "tag_origin", (0, getdvarfloat(@ "hash_634c96fa241f9c5d", 0), 0), (0, 0, 0));
  turret thread function_5c1dbb360748154d(turret.useobject, vehicle, turret_weapon, turret_tag);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  turret.maxhealth = 400;
  turret.health = turret.maxhealth;
  turret.exit = var_721f077d971e21d5;
  return turret;
}

function private function_5c1dbb360748154d(triggerobject, vehicle, turretweapon, turret_tag) {
  self endon("kill_turret");
  level endon("game_ended");

  foreach(player in level.players) {
    triggerobject enableplayeruse(player);
  }

  thread function_eedbab7faf413258(triggerobject);

  while(true) {
    triggerobject waittill("trigger", player);

    if(istrue(self.inuse)) {
      continue;
    }

    if(player isonladder() || !player isonground() || player ismantling() || istrue(player.isjuggernaut) || player isskydiving()) {
      if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
        player[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("VEHICLES/CANNOT_ENTER_TURRET");
      }

      continue;
    }

    self.inuse = 1;
    triggerobject function_dfb78b3e724ad620(0);
    vehicle vehicle_spawn_stopwatchingabandoned();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_hidecashbag(vehicle, undefined, player);
    player function_5847240c0f9900f2(0);
    weapon = "iw9_mg_mrap_mp";
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deleteseatcorpse(vehicle, turret_tag, 1);
    scripts\cp_mp\utility\vehicle_omnvar_utility::function_d2d9c09551d91164(vehicle, player);
    turret = vehicle_getturretbyweapon(vehicle, weapon);
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, ter_op(istrue(turret.var_ecc491f42aaceaf4), 850, 2200));
    turret.var_ecc491f42aaceaf4 = 1;
    function_160ef1c877c69ab1(player, vehicle, self, turret_tag);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, weapon);
    scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onentervehicle(vehicle, player);
    turret thread function_9bf55f5544386843(player);
    turret thread function_ed8363986249e9a4(player, vehicle);
    turret thread function_47f1f11faa1e0bfc(player, vehicle);
    turret thread function_870a09b029f348e(player, vehicle);
  }
}

function private function_eedbab7faf413258(useobj) {
  if(isDefined(self)) {
    self endon("kill_turret");
  }

  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    useobj enableplayeruse(player);
  }
}

function private function_ed8363986249e9a4(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");
  detachdistancesq = 62500;

  while(true) {
    if(player isinexecutionvictim() || distancesquared(self.origin, player.origin) >= detachdistancesq) {
      thread function_1346cdf1abb57e5b(player, vehicle);
      break;
    }

    waitframe();
  }
}

function private function_47f1f11faa1e0bfc(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");

  while(player useButtonPressed()) {
    waitframe();
  }

  while(true) {
    if(player useButtonPressed()) {
      thread function_1346cdf1abb57e5b(player, vehicle);
      break;
    }

    waitframe();
  }
}

function private function_870a09b029f348e(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  level endon("game_ended");
  player waittill_any_2("death_or_disconnect", "last_stand_start");
  thread function_1346cdf1abb57e5b(player, vehicle);
}

function private function_9bf55f5544386843(player) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self.lastuserangles = player getplayerangles();
    waitframe();
  }
}

function private function_1346cdf1abb57e5b(player, vehicle) {
  self.inuse = 0;

  if(isDefined(player)) {
    player notify("end_turret_use");
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_showcashbag(vehicle, undefined, player);
    player function_5847240c0f9900f2(1);
  }

  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onexitvehicle(vehicle, player);
  function_4d2324450a951b2b(player, vehicle);
  vehicle thread vehicle_spawn_watchabandoned();
  self.useobject function_dfb78b3e724ad620(1);

  if(isDefined(player)) {
    player enableturretdismount();
    player controlturretoff(self);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, self.objweapon.basename, spawnStruct(), 0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::function_5211953231a09ed5(vehicle, player);
  }

  self.owner = undefined;
  self setotherent(undefined);
  self setentityowner(undefined);

  if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive()) {
    player function_a055801da45d769(rotatevector(self.exit + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0), vehicle.angles) + vehicle.origin, vehicle);
    player setplayerangles(self.lastuserangles);
    thread vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
  }
}

function private function_72b740c96f213c47(vehicle) {
  if(isDefined(vehicle.mgturret)) {
    vehicle.mgturret notify("kill_turret");

    if(isDefined(vehicle.mgturret.owner)) {
      vehicle.mgturret thread function_1346cdf1abb57e5b(vehicle.mgturret.owner, self);
    }

    vehicle_deregisterturret(self, vehicle.mgturret.objweapon);
    vehicle.mgturret.useobject delete();
    vehicle.mgturret delete();
  }
}

function private function_517bcf849b4ec232(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(seatid == "gunner") {
    if(istrue(player.insertingarmorplate)) {
      player notify("try_armor_cancel");

      while(isDefined(player.currentweapon) && isDefined(player.currentweapon.basename) && player.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
        waitframe();
      }
    }
  }
}

function private function_edfacde58cb56417(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(istrue(data.success)) {
    thread function_9c320c91ab9708ee(vehicle, seatid, var_fc7c7a874b43a31a, player, data);
  }
}

function private function_9c320c91ab9708ee(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(seatid == "driver") {
    vehicle thread function_d6b5ad0707b3539e(player);
    thread vehicle_occupancy_disablefirefortime(player, 250);
    thread function_50f0644ffd3cd614(player);
  } else if(seatid == "gunner") {
    level thread vehicle_occupancy_disablefirefortime(player, 100);
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, "iw9_tur_mrap_mp");
    player visionsetkillstreakforplayer("aviCougarGunner", 0);
    player playerlinkTo(vehicle, "tag_seat_1");
    function_e13dfe8ce29194bb(player);
    thread function_bc35436299b4b69d(player);
  }

  if(!isDefined(var_fc7c7a874b43a31a)) {
    vehicle function_63f3c4df75521924(player);
  }

  vehomn_updateomnvarsonseatenter(vehicle, var_fc7c7a874b43a31a, seatid, player);
  function_48658d8851154485(vehicle, var_fc7c7a874b43a31a, seatid, player);
}

function private function_ccd9db63cabe6ff1(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(istrue(data.success)) {
    thread function_ccf255acab209214(vehicle, seatid, var_7558f98f3236963d, player, data);
  }
}

function private function_ccf255acab209214(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(seatid == "driver") {
    vehicle notify("mrap_driver_exit");

    if(istrue(data.playerdisconnect)) {}
  } else if(seatid == "gunner") {
    turret = vehicle_getturretbyweapon(vehicle, "iw9_tur_mrap_mp");
    thread function_50f0644ffd3cd614(player);

    if(!istrue(data.playerdisconnect)) {
      thread vehicle_occupancy_taketurret(player, vehicle, "iw9_tur_mrap_mp", spawnStruct());
      player enableturretdismount();

      if(player islinked()) {
        player unlink();
      }

      player visionsetkillstreakforplayer("");
      thread vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
    function_6c43fbfc4c4772b2(player);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!isDefined(var_7558f98f3236963d)) {
      vehicle function_63f3c4df75521924(player);
    }

    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, var_7558f98f3236963d, player, data);

    if(!success) {
      if(scripts\engine\utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\engine\utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, var_7558f98f3236963d, player);
}

function private function_a4d7a7606411e415(vehicle, var_9de41f2ee77c33ba, var_3f68c37bafd38606, player, data) {
  if(isDefined(var_3f68c37bafd38606) && var_3f68c37bafd38606 == "gunner") {
    thread vehicle_occupancy_taketurret(player, vehicle, "iw9_tur_mrap_mp", data, 1);
  }
}

function private function_bc35436299b4b69d(player) {
  player setclienttriggeraudiozone("veh_mrap_turret", 0.2);
}

function private function_50f0644ffd3cd614(player) {
  player clearclienttriggeraudiozone(0.2);
}

function private function_e13dfe8ce29194bb(player) {
  if(isDefined(player.gunnerdamagemodifier)) {
    return;
  }

  player scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, &function_cda65dc0eb19e782);
}

function private function_6c43fbfc4c4772b2(player) {
  if(!isDefined(player.gunnerdamagemodifier)) {
    return;
  }

  player.gunnerdamagemodifier = undefined;
  player scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

function private function_cda65dc0eb19e782(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath != "MOD_PROJECTILE_SPLASH" && meansofdeath != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(objweapon)) {
    return 1;
  }

  switch (objweapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_6b9700922cc910a9":
    case #"hash_708fb6e22f87a3a4":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_b5e9f2d6fac1a505":
    case #"hash_e704ecf8710c6f57":
    case #"hash_f55c20924061bd15":
    case #"hash_fd9c279f85990dad":
      return 0;
    default:
      return 1;
  }
}

function private function_ce4c02d228c5b367(var_45c9b66826527876) {
  icon = self.headicon;

  if(!isDefined(icon)) {
    icon = scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(icon)) {
      return 0;
    }

    self.headicon = icon;
    setheadiconzoffset(icon, 110);
  }

  self.headiconforcapture = istrue(var_45c9b66826527876);
  naturaldist = ter_op(istrue(var_45c9b66826527876), 0, 0);
  maxdist = ter_op(istrue(var_45c9b66826527876), 2250, 2250);
  var_94dc5deab609fdc9 = ter_op(istrue(var_45c9b66826527876), 1, 0);
  var_c18f8868bd35fee2 = ter_op(istrue(var_45c9b66826527876), 1, 0);
  setheadiconnaturaldistance(icon, naturaldist);
  setheadiconmaxdistance(icon, maxdist);
  setheadicondrawthroughgeo(icon, var_94dc5deab609fdc9);
  setheadiconsnaptoedges(icon, var_c18f8868bd35fee2);

  if(istrue(level.var_32fe21b3c5052471) && level.teambased) {
    function_ce9d0299637c2c24(icon, 1);
  }
}

function private function_a9df40a21cd98d19() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

function private function_6457b39281a7f9ca(owneroverride, teamoverride) {
  if(!isDefined(self.headicon)) {
    return;
  }

  if(isDefined(owneroverride)) {
    if(isstring(owneroverride) && owneroverride == "none") {
      self.headiconowneroverride = undefined;
    } else {
      self.headiconowneroverride = owneroverride;
    }
  }

  if(isDefined(teamoverride)) {
    if(teamoverride == "none") {
      self.headiconteamoverride = undefined;
    } else {
      self.headiconteamoverride = teamoverride;
    }
  }

  function_ab60ec681ca9af95();
  function_ecb6f9099a4e8f6b();
  function_4cd40b506a2f07ff();

  foreach(player in level.players) {
    function_63f3c4df75521924(player);
  }
}

function private function_63f3c4df75521924(player) {
  if(!isDefined(self.headicon)) {
    return;
  }

  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && vehicle == self) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    return;
  }

  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  team = undefined;

  if(isDefined(self.headiconteamoverride)) {
    team = self.headiconteamoverride;
  } else {
    team = self.team;
  }

  leveldata = function_c38a5128f25cfbee();

  if(level.teambased) {
    if(team == "neutral") {
      if(!isDefined(owner)) {
        if(true) {
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          return;
        }

        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
        return;
      } else {
        team = owner.team;
      }
    }

    if(isenemyteam(team, player.team)) {
      if(istrue(leveldata.showheadicontoenemy)) {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
      } else {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
      }
    } else {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    }

    return;
  }

  if(!isDefined(owner)) {
    if(true) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
      return;
    }

    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    return;
  }

  if(player != owner) {
    if(leveldata.showheadicontoenemy) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    } else {
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    }

    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
}

function private function_fa5fbaf4803f160(player) {
  lighttanks = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("veh9_mil_lnd_mrap");

  foreach(lighttank in lighttanks) {
    lighttank function_63f3c4df75521924(player);
  }
}

function private function_ab60ec681ca9af95() {
  if(level.teambased) {
    return false;
  }

  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  if(isDefined(owner)) {
    setheadiconowner(self.headicon, owner);
  } else {
    setheadiconowner(self.headicon, undefined);
  }

  return true;
}

function private function_ecb6f9099a4e8f6b() {
  if(!level.teambased) {
    return;
  }

  team = function_a52340952557c2b6();

  if(isDefined(team) && team != "neutral") {
    setheadiconteam(self.headicon, team);
    return;
  }

  setheadiconteam(self.headicon, undefined);
}

function private function_4cd40b506a2f07ff() {
  leveldata = function_c38a5128f25cfbee();
  var_9318d957cb71a518 = ter_op(istrue(self.headiconforcapture), 1, 1);

  if(var_9318d957cb71a518) {
    setheadiconfriendlyimage(self.headicon, level.factionfriendlyheadicon);

    if(true) {
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);
    }

    if(leveldata.showheadicontoenemy) {
      setheadiconenemyimage(self.headicon, level.factionenemyheadicon);
    }

    return;
  }

  var_c3e202acf77e4dd4 = ter_op(istrue(self.headiconforcapture), 1, 1);
  var_f1a0dcc04676e92f = ter_op(istrue(self.headiconforcapture), 0, leveldata.showheadicontoenemy);
  friendlyimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
  neutralimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
  enemyimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
  setheadiconfriendlyimage(self.headicon, friendlyimage);

  if(var_c3e202acf77e4dd4) {
    setheadiconneutralimage(self.headicon, neutralimage);
  }

  if(var_f1a0dcc04676e92f) {
    setheadiconenemyimage(self.headicon, enemyimage);
  }
}

function private function_a52340952557c2b6() {
  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  team = undefined;

  if(isDefined(self.headiconteamoverride)) {
    team = self.headiconteamoverride;
  } else {
    team = self.team;
  }

  var_9a6fccc729b4650a = team;

  if(!isDefined(var_9a6fccc729b4650a) || team == "neutral") {
    if(isDefined(owner)) {
      var_9a6fccc729b4650a = owner.team;
    }
  }

  return var_9a6fccc729b4650a;
}

function private function_9c0fbc8660be15b7() {
  self endon("death");

  while(true) {
    driver = vehicle_occupancy_getdriver(self);

    if(istrue(self.var_ec76ffdbe2f37c5b)) {
      if(isDefined(driver)) {
        driver setclientomnvar("ui_veh_flares_charge_perc", 0);
      }

      waitframe();
      continue;
    } else if(self.var_9cd07317ba52df4) {
      if(isDefined(driver)) {
        if(driver getclientomnvar("ui_veh_flares_charge_perc") < 1.05) {
          driver setclientomnvar("ui_veh_flares_charge_perc", 1.05);
          vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", 1, driver);
        }
      }
    } else {
      var_77151e8d83f062cb = 0;

      while(var_77151e8d83f062cb < self.var_c2594ac36ee74a08) {
        wait 0.05;
        var_77151e8d83f062cb += 0.05;
        var_e9227a816ed1d671 = var_77151e8d83f062cb / self.var_c2594ac36ee74a08;
        driver = vehicle_occupancy_getdriver(self);

        if(isDefined(driver)) {
          driver setclientomnvar("ui_veh_flares_charge_perc", var_e9227a816ed1d671);
        }
      }

      self.var_9cd07317ba52df4 = 1;
    }

    waitframe();
  }
}

function private function_d6b5ad0707b3539e(player) {
  self endon("death");
  self endon("mrap_driver_exit");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");
  player notifyonplayercommand("pop_smoke", "+attack");
  vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", ter_op(self.var_9cd07317ba52df4, 1, 0), player);

  while(true) {
    player waittill("pop_smoke");

    if(istrue(self.var_ec76ffdbe2f37c5b)) {
      continue;
    }

    if(!self.var_9cd07317ba52df4) {
      self playsoundtoplayer("lbravo_noflares_warning", player);
      continue;
    }

    if(issharedfuncdefined("popsmoke", "deploy")) {
      self thread[[getsharedfunc("popsmoke", "deploy")]](["tag_smoke_grenade_front_left", "tag_smoke_grenade_front_right", "tag_smoke_grenade_back_left", "tag_smoke_grenade_back_right"]);
    }

    self.var_9cd07317ba52df4 = 0;
    vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", 0, player);
    vehicle_occupancy_fadeoutcontrols(player);
  }
}

function private function_c38a5128f25cfbee() {
  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  assertex(isDefined(level.vehicle.mrap), "<dev string:x74>");
  return level.vehicle.mrap;
}

function private function_48658d8851154485(vehicle, var_fc7c7a874b43a31a, var_7558f98f3236963d, player) {
  vehicle function_e9e5cd0650ee3e3e(player);
}

function private function_e9e5cd0650ee3e3e(player) {
  leveldata = function_c38a5128f25cfbee();

  if(leveldata.canautodestruct) {
    if(istrue(self.autodestructactivated)) {
      vehomn_showwarning("burningDown", player, "veh9_mil_lnd_mrap");
    } else {
      vehomn_hidewarning("burningDown", player, "veh9_mil_lnd_mrap");
    }

    return;
  }

  vehomn_hidewarning("burningDown", player, "veh9_mil_lnd_mrap");
}