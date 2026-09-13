/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_helicopters.gsc
***************************************************/

setuphalodropplayer(player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("cancel_heli");
  playerlinkent = spawn("script_model", (0, 0, 0));
  playerlinkent setModel("tag_origin");
  self.playerlinkent = playerlinkent;
  self.playerstartpos = player.origin;

  if(istrue(player.isbombcarrier))
    level.bombdroploc = self.playerstartpos;

  playerlinkent playLoopSound("veh_apache_killstreak_amb_lr");
  playerlinkent linkTo(self, "tag_origin", self.playeroffsets[self.playerslots.size], (0, 90, 0));
  player setstance("stand");
  player setCanDamage(0);
  player cancelmantle();
  player playerlinktodelta(playerlinkent, "tag_player", 1.0, 40, 40, -5, 70, 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  player notifyonplayercommand("halo_jump_c130", "+gostand");
  player thread _id_45B2B4A889E633FA::listenjump(self, 1);
  player thread _id_45B2B4A889E633FA::listenkick(self, 1);
}

spawnplayertohelicam(player) {
  player.angles = self.angles;
  player thread _id_45B2B4A889E633FA::listenjump(self, 1);
  player thread _id_45B2B4A889E633FA::listenkick(self, 1);
  player.br_infil_type = "heli";
  player thread orbitcam(self);
}

orbitcam(heli) {
  radius = 450;
  _id_0FE0C08DDC602E96 = (-5, 0, 0);
  _id_7599C0B16DDED944 = anglesToForward(_id_0FE0C08DDC602E96) * radius * -1;
  heli.br_vieworigin = _id_7599C0B16DDED944 + (150, 150, 0);
  self.angles = heli.angles;
  self playerlinkTo(heli, "tag_origin");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_helicopters::orbitCam()");
  scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0);

  if(isDefined(self.br_orbitcam))
    self.br_orbitcam delete();

  _id_B205BE0302D9F3A6 = spawn("script_model", heli.origin);
  _id_B205BE0302D9F3A6 setModel("tag_player");
  _id_B205BE0302D9F3A6 linkTo(heli, "tag_origin", (0, 0, 50), (0, 0, 0));
  self.br_orbitcam = _id_B205BE0302D9F3A6;
  self cameraset("camera_custom_orbit_2");
}

forceejectall() {
  foreach(player in level.players) {
    player notify("halo_jump");
    player notify("halo_kick_c130");
  }
}

jumplistener(heli, _id_6A4B8CF506139680) {
  level endon("game_ended");
  self endon("br_jump");
  _id_3B64EB40368C1450::set("br_heli", "melee", 0);
  _id_3B64EB40368C1450::set("br_heli", "player_for_spawn_logic", 0);
  _id_3B64EB40368C1450::set("br_heli", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("br_heli", "usability", 0);
  self notifyonplayercommand("halo_jump", "+gostand");
  self waittill("halo_jump");
  _id_71F6A255DCFAA75E = self getplayerangles();
  _id_59CA84FF0B0B2C1B = heli getfirstopenjumporigin();
  left = anglestoleft(heli.angles);
  _id_F9805AAD354A150E = _id_59CA84FF0B0B2C1B.origin + left * 200;
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  spawnpos = (0, 0, 0);
  _id_E021C2744CC7ED68 = physics_raycast(_id_F9805AAD354A150E, _id_F9805AAD354A150E + (0, 0, -20000), contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    castend = _id_E021C2744CC7ED68[0]["position"];
    spawnpos = getclosestpointonnavmesh(castend);
  } else
    iprintln("ERROR NOTHING BELOW TO CAST ON");

  self unlink();
  _id_44FA3F00F2040A19 = spawn("script_model", self.origin);
  _id_44FA3F00F2040A19.angles = self.angles;
  _id_44FA3F00F2040A19 setModel("tag_origin");
  self playerlinkTo(_id_44FA3F00F2040A19);
  _id_44FA3F00F2040A19 moveTo(spawnpos + (0, 0, 24), _id_6A4B8CF506139680, 0, 1.0);
  self playerlinkTo(_id_44FA3F00F2040A19);
  parachute = spawn("script_model", self.origin + (0, 0, 300));
  parachute setModel("ctl_parachute_player");
  parachute notsolid();
  childthread parachuteupdater(parachute);
  wait(_id_6A4B8CF506139680 - 0.333);
  self unlink();
  heli.playerslots = scripts\engine\utility::array_remove(heli.playerslots, self);
  self setCanDamage(1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("br_heli");

  if(isDefined(heli))
    heli jumpdone();
}

parachuteupdater(parachute) {
  for(;;) {
    if(self isonground() || !isalive(self)) {
      self.br_fallaccel = (0, 0, 0);
      parachute delete();
      break;
    } else {
      parachute.angles = self.angles;
      parachute.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

spawnheli(_id_DBA28832815DB73F, spawnpos) {
  streakname = "jackal";
  streakinfo = fakestreakinfo();
  _id_D451D87B8D202BE6 = "veh_blima_gunner_proto_mp";
  _id_A7AFBEBB4DC98CE7 = "veh8_mil_air_blima_gunner_streak_proto";
  _id_075E017AE58F23A0 = 1500;
  heli = spawnVehicle(_id_A7AFBEBB4DC98CE7, "br_spawn_heli_" + _id_DBA28832815DB73F, _id_D451D87B8D202BE6, spawnpos, (0, -90, 0));
  heli.streakinfo = streakinfo;
  heli vehicle_setspeed(30, 15, 5);
  heli notsolid(0);
  heli setCanDamage(0);
  heli setscriptablepartstate("engine", "on");
  heli playLoopSound("lbravo_engine_high");
  heli.health = _id_075E017AE58F23A0;
  heli.targetpos = level.mapcenter;
  heli.targetent = undefined;
  heli.team = "allies";
  heli.dying = 0;
  heli.leaving = 0;
  heli.queuetokens = 0;
  heli.playerslots = [];
  heli.playeroffsets = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  heli.jumpslots = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    heli.jumpslots[_id_AC0E594AC96AA3A8] = 0;

  return heli;
}

getfirstopenjumporigin() {
  if(!isDefined(self.jumpslots))
    return self.trail[0];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    if(self.jumpslots[_id_AC0E594AC96AA3A8] == 0) {
      self.jumpslots[_id_AC0E594AC96AA3A8] = 1;
      return self.trail[_id_AC0E594AC96AA3A8];
    }
  }

  return self.trail[9];
}

calctrailpoint() {
  droppoint = self.origin - anglesToForward(self.angles) * 150;
  return droppoint;
}

helipathmemory() {
  self endon("death");
  self endon("leaving");
  self.trail = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    struct = spawnStruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    self.trail[_id_AC0E594AC96AA3A8] = struct;
  }

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 9; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
      self.trail[_id_AC0E594AC96AA3A8].origin = self.trail[_id_AC0E594AC96AA3A8 - 1].origin;
      self.trail[_id_AC0E594AC96AA3A8].angles = self.trail[_id_AC0E594AC96AA3A8 - 1].angles;
      self.jumpslots[_id_AC0E594AC96AA3A8] = self.jumpslots[_id_AC0E594AC96AA3A8 - 1];
    }

    self.trail[0].origin = self.origin;
    self.trail[0].angles = self.angles;
    self.jumpslots[0] = 0;
    wait 1.0;
  }
}

fakestreakinfo() {
  streakinfo = spawnStruct();
  streakinfo.available = 1;
  streakinfo.firednotify = "offhand_fired";
  streakinfo.isgimme = 1;
  streakinfo.kid = 5;
  streakinfo.lifeid = 0;
  streakinfo.madeavailabletime = gettime();
  streakinfo.scriptuseagetype = "gesture_script_weapon";
  streakinfo.streakname = "jackal";
  streakinfo.streaksetupinfo = undefined;
  streakinfo.variantid = -1;
  streakinfo.weaponname = "ks_gesture_generic_mp";
  streakinfo.objweapon = makeweapon(streakinfo.weaponname);
  streakinfo.hits = 0;
  return streakinfo;
}

ishelicopterfull(_id_B0F792173C02C214) {
  return _id_B0F792173C02C214.playerslots.size == 10;
}

sorthelosize(a, b) {
  return a.playerslots.size < b.playerslots.size;
}

getnexthelicopterwithroom(team) {
  if(level.teambased) {
    foreach(heli in level.br_helicopters) {
      if(isDefined(heli.spawnteam) && heli.spawnteam == team && !ishelicopterfull(heli))
        return heli;
    }

    foreach(heli in level.br_helicopters) {
      if(!isDefined(heli.spawnteam)) {
        heli.spawnteam = team;
        return heli;
      }
    }
  } else {
    _id_2CC0A74E48CBF1CF = scripts\engine\utility::array_sort_with_func(level.br_helicopters, ::sorthelosize);

    foreach(_id_E1FC45CB1D9E92F7 in _id_2CC0A74E48CBF1CF) {
      if(!ishelicopterfull(_id_E1FC45CB1D9E92F7))
        return _id_E1FC45CB1D9E92F7;
    }
  }

  return undefined;
}

kickanyremainingplayers() {
  foreach(_id_AC0E424AC96A7113 in self.playerslots) {
    if(isDefined(_id_AC0E424AC96A7113) && isDefined(_id_AC0E424AC96A7113.br_infil_type) && _id_AC0E424AC96A7113.br_infil_type == "heli") {
      _id_AC0E424AC96A7113 cameradefault();
      _id_AC0E424AC96A7113 notify("halo_kick_c130");
    }
  }
}

exitandcleanup() {
  self endon("death");
  level notify("infil_locked");
  kickanyremainingplayers();
  self notify("begin_exit");
  self.leaving = 1;
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  spawnheight = _id_5FA1E1697A302583.origin[2];
  mapcenter = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  _id_D30D83160ADFA539 = self.origin - mapcenter;
  _id_D30D83160ADFA539 = (_id_D30D83160ADFA539[0], _id_D30D83160ADFA539[1], 0);
  _id_A050D016A21F5700 = vectorNormalize(_id_D30D83160ADFA539);
  _id_FFCE0466E6339868 = self.origin + _id_A050D016A21F5700 * 10000 + (0, 0, 1) * spawnheight;
  exit_speed = 150;
  _id_D1EF5A7D6B232A76 = 50;
  _id_62773AC99D83D437 = 350;
  self vehicle_setspeed(exit_speed, _id_D1EF5A7D6B232A76, _id_D1EF5A7D6B232A76);
  self setvehgoalpos(_id_FFCE0466E6339868, 0);
  self setneargoalnotifydist(_id_62773AC99D83D437);
  self waittill("near_goal");
  self delete();
}

jumpdone() {
  foreach(heli in level.br_helicopters) {
    if(isDefined(heli) && heli.playerslots.size == 0)
      heli thread exitandcleanup();
  }
}