/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\helicopter.gsc
***********************************************/

init() {
  level._effect["_encstr_91940F1BD14B275EE85BC7C671B8225F6E"] = loadfx("_encstr_8AD4322327D2AD98742B5F8837D732731A7AEE2BF2519BF2081C4FA37187EF8E01FB5379731260451BA98F19A62E718FDD131380");
  level._effect["_encstr_BE750BE4D1D8271259ABABCFB7"] = loadfx("_encstr_BEC6332377888A438BE2B7CBDBD69A70244D0BFB1AFDA00A2633CDE94FCAD710D2E471B3C9211034FA6347EDFB62A6E08BAD9B49A8");

  if(level.gametype != "_encstr_B607038AAB")
    level thread getaveragelowspawnpoint();
}

getaveragelowspawnpoint() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1++;
    var_2 = var_2 + var_4.origin[2];
  }

  if(var_1 > 0)
    level.averagealliesz = var_2 / var_1;
  else
    level.averagealliesz = 0;
}

makehelitype(var_0, var_1, var_2) {
  level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_AD75063D571AE108"][var_0] = loadfx(var_1);
  level.lightfxfunc[var_0] = var_2;
}

addairexplosion(var_0, var_1) {
  level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8F6D0AC2A5E4FAC8AC85D1A1"][var_0] = loadfx(var_1);
}

defaultlightfx() {
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_A5AD056A019C63"], self, "_encstr_83F611472C3BD78DA57634A3EBC4F5EE2D9BD9");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_8253060E2B5FE330"], self, "_encstr_A6A4118EB03BFAD84B3B0D47BE297DDDA5DC3B");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_915E0613420DC132"], self, "_encstr_ABC910472CD9FAC6D2CE34D17D982B36B1F2");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_B1EF0591524C08"], self, "_encstr_AAA20F5B8061CF524B2CBCB31829DAB168");
}

usehelicopter(var_0, var_1) {
  return tryusehelicopter(var_0, "_encstr_8F010BD0591B4B36B7831D5693");
}

tryusehelicopter(var_0, var_1) {
  var_2 = 1;

  if(isDefined(level.chopper))
    var_3 = 1;
  else
    var_3 = 0;

  if(isDefined(level.chopper) && var_3) {
    self iprintlnbold(&"_encstr_B6C91A962998264DA8252A14966A7D215162A4BE52E4EBA8552A55A2");

    if(isDefined(var_1) && var_1 != "_encstr_8F010BD0591B4B36B7831D5693")
      var_4 = "_encstr_88DD0C8057AC907F42B29D2D0A79" + var_1;
    else
      var_4 = "_encstr_8F010BD0591B4B36B7831D5693";

    var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_5 hide();
    var_5 thread deleteonentnotify(self, "_encstr_8D820B49520F0EC02DDE6367EC");
    var_5.player = self;
    var_5.lifeid = var_0;
    var_5.helitype = var_1;
    var_5.streakname = var_4;
    scripts\mp\utility\script::queueadd("_encstr_8F010BD0591B4B36B7831D5693", var_5);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    return 0;
  }

  var_2 = 1;
  starthelicopter(var_0, var_1);
  return 1;
}

deleteonentnotify(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill(var_1);
  self delete();
}

starthelicopter(var_0, var_1) {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_2 = undefined;

  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_3 = "_encstr_8F010BD0591B4B36B7831D5693";
  var_4 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
  scripts\common\utility::_id_13E0A(level._id_11B2A, var_3, self.origin);
  thread heli_think(var_0, self, var_2, self.pers["_encstr_8AEF05472BC2D6"], var_1);
}

precachehelicoptersounds() {
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_BD1904D06B18"] = "_encstr_A65818EC590DFAC643EDE0C1CA4EAF9BAE0783DE4E3AF5432D3A";
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_B6AF0D3189C340655F3A0831A26323"] = "_encstr_B8C51F5AE78B2B09597B55654A8A9D191B4D3B462B68A7589D72DF4D8AFFC7A363";
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_B876094EEA622D60875F58"] = "_encstr_845B1C41F552A087C9E38389FF52D8F8FCCFEB5EDFA1A0C862579987CF8B";
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_88BB0AEBBB8A65966841F873"] = "_encstr_82BA1D893D8A785F015BCBD1B72A90B03417138667E9E880BA9F21D3CF1266";
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_8F9E06C26033324B"] = "_encstr_AF73140D3BFB572AB79A176E47087BED9A49EE15DD05";
  level.heli_sound["_encstr_9A8507BA4040188D08"]["_encstr_BA950C5B96E69B2D36AC9996392B"] = "_encstr_A2DD18EECA85387D8DF6989CB0EBB5D29BE6B43659D7992D9359";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_BD1904D06B18"] = "_encstr_A65818EC590DFAC643EDE0C1CA4EAF9BAE0783DE4E3AF5432D3A";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_B6AF0D3189C340655F3A0831A26323"] = "_encstr_B8C51F5AE78B2B09597B55654A8A9D191B4D3B462B68A7589D72DF4D8AFFC7A363";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_B876094EEA622D60875F58"] = "_encstr_845B1C41F552A087C9E38389FF52D8F8FCCFEB5EDFA1A0C862579987CF8B";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_88BB0AEBBB8A65966841F873"] = "_encstr_82BA1D893D8A785F015BCBD1B72A90B03417138667E9E880BA9F21D3CF1266";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_8F9E06C26033324B"] = "_encstr_AF73140D3BFB572AB79A176E47087BED9A49EE15DD05";
  level.heli_sound["_encstr_8E8405EA382B2A"]["_encstr_BA950C5B96E69B2D36AC9996392B"] = "_encstr_A2DD18EECA85387D8DF6989CB0EBB5D29BE6B43659D7992D9359";
}

heli_getteamforsoundclip() {
  var_0 = self.team;

  if(level.multiteambased)
    var_0 = "_encstr_8E8405EA382B2A";

  return var_0;
}

spawn_helicopter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnhelicopter(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_5))
    return undefined;

  if(var_4 == "_encstr_83B614BBF0098C5F40759FDA1F2B4B954B89E2C230F9")
    var_5.heli_type = "_encstr_A38E06A1A0985212";
  else
    var_5.heli_type = level.heli_types[var_4];

  var_5 thread[[level.lightfxfunc[var_5.heli_type]]]();
  var_5 scripts\mp\utility\killstreak::addtohelilist(var_5 getentitynumber());
  var_5.zoffset = (0, 0, var_5 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")[2] - var_5 gettagorigin("_encstr_ACF80B99F702D840F25D235887")[2]);
  var_5.attractor = missile_createattractorent(var_5, level.heli_attract_strength, level.heli_attract_range);
  return var_5;
}

helidialog(var_0) {
  if(gettime() - level.lasthelidialogtime < 6000) {
    return;
  }
  level.lasthelidialogtime = gettime();
  var_1 = randomint(level.helidialog[var_0].size);
  var_2 = level.helidialog[var_0][var_1];
  var_3 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "_encstr_A607032BE0" + var_2;
  self playlocalsound(var_3);
}

updateareanodes(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.validplayers = [];
    var_3.nodescore = 0;
  }

  foreach(var_6 in level.players) {
    if(!isalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    foreach(var_3 in var_0) {
      if(distancesquared(var_6.origin, var_3.origin) > 1048576) {
        continue;
      }
      var_3.validplayers[var_3.validplayers.size] = var_6;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    var_12 = getEnt(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_3.validplayers) {
      var_3.nodescore = var_3.nodescore + 1;

      if(scripts\engine\trace::_bullet_trace_passed(var_6.origin + (0, 0, 32), var_12.origin, 0, var_6))
        var_3.nodescore = var_3.nodescore + 3;
    }

    if(var_3.nodescore > var_10.nodescore)
      var_10 = var_3;
  }

  return getEnt(var_10.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

heli_think(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.origin;
  var_6 = var_2.angles;
  var_7 = "_encstr_A7350988386D1BF98F5F4A";
  var_8 = "_encstr_83B614BBF0098C5F40759FDA1F2B4B954B89E2C230F9";
  var_9 = spawn_helicopter(var_1, var_5, var_6, var_7, var_8);

  if(!isDefined(var_9)) {
    return;
  }
  level.chopper = var_9;

  if(var_3 == "_encstr_9A8507BA4040188D08")
    level.allieschopper = var_9;
  else
    level.axischopper = var_9;

  var_9.helitype = var_4;
  var_9.lifeid = var_0;
  var_9.team = var_3;
  var_9.pers["_encstr_8AEF05472BC2D6"] = var_3;
  var_9.owner = var_1;
  var_9 setotherent(var_1);
  var_9.startnode = var_2;
  var_9.maxhealth = level.heli_maxhealth;
  var_9.targeting_delay = level.heli_targeting_delay;
  var_9.primarytarget = undefined;
  var_9.secondarytarget = undefined;
  var_9.attacker = undefined;
  var_9.currentstate = "_encstr_860703DF6B";
  var_9 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_1);
  var_9.empgrenaded = 0;

  if(var_4 == "_encstr_810E07FAF85B0A07E3" || var_4 == "_encstr_95AD085B5AB9D2ECABE6")
    var_9 thread scripts\mp\killstreaks\flares::flares_monitor(1);

  var_9 thread heli_leave_on_disconnect(var_1);
  var_9 thread heli_leave_on_changeteams(var_1);
  var_9 thread heli_leave_on_gameended(var_1);
  var_9 thread heli_damage_monitor(var_4);
  var_9 thread heli_watchempdamage();
  var_9 thread heli_watchdeath();
  var_9 thread heli_existance();
  var_9 endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  var_9 endon("_encstr_86BD0980BBC647A80FDE04");
  var_9 endon("_encstr_BA2D081B2B58B32D37EC");
  var_9 endon("_encstr_AD75063D571AE108");
  var_10 = getEntArray("_encstr_876E1189CF9AEB990973FB515EFB6117935713", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = undefined;
  var_11 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  var_9 heli_fly_simple_path(var_2);
  var_9 thread heli_targeting();
  var_9 thread heli_leave_on_timeout(60.0);
  var_9 thread heli_fly_loop_path(var_11);
}

heli_existance() {
  var_0 = self getentitynumber();
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_86BD0980BBC647A80FDE04", "_encstr_BA2D081B2B58B32D37EC");
  scripts\mp\utility\killstreak::removefromhelilist(var_0);
  self notify("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  self notify("_encstr_84521381C792E3400F7AE3D9E2D7932D7A0725137B");
  var_1 = undefined;
  var_2 = scripts\mp\utility\script::queueremovefirst("_encstr_8F010BD0591B4B36B7831D5693");

  if(!isDefined(var_2))
    level.chopper = undefined;
  else {
    var_1 = var_2.player;
    var_3 = var_2.lifeid;
    var_4 = var_2.streakname;
    var_5 = var_2.helitype;
    var_2 delete();

    if(isDefined(var_1) && (var_1.sessionstate == "_encstr_877508C1D8C22F2DDC3B" || var_1.sessionstate == "_encstr_84670547C3E9F4")) {
      var_1 starthelicopter(var_3, var_5);
      return;
    }

    level.chopper = undefined;
  }
}

heli_targeting() {
  self notify("_encstr_92420FF1450550B8C31A4B11A23B6BA01F");
  self endon("_encstr_92420FF1450550B8C31A4B11A23B6BA01F");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  for(;;) {
    var_0 = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;

    foreach(var_2 in level.characters) {
      wait 0.05;

      if(!cantarget_turret(var_2)) {
        continue;
      }
      var_0[var_0.size] = var_2;
    }

    if(var_0.size) {
      for(var_4 = getbestprimarytarget(var_0); !isDefined(var_4); var_4 = getbestprimarytarget(var_0))
        waitframe();

      self.primarytarget = var_4;
      self notify("_encstr_959511DB1EC3AB4F6B5BE82E9BE3C38F1312FC");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait 0.25;
  }
}

cantarget_turret(var_0) {
  var_1 = 1;

  if(!isalive(var_0) || isDefined(var_0.sessionstate) && var_0.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  if(distance(var_0.origin, self.origin) > level.heli_visual_range)
    return 0;

  if(!self.owner scripts\mp\utility\player::isenemy(var_0))
    return 0;

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5)
    return 0;

  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
    return 0;

  var_2 = self.origin + (0, 0, -160);
  var_3 = anglesToForward(self.angles);
  var_4 = var_2 + 144 * var_3;

  if(var_0 sightconetrace(var_4, self) < level.heli_target_recognition)
    return 0;

  return var_1;
}

getbestprimarytarget(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    update_player_threat(var_2);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_6.size == 2) {
      var_8 = var_6[0].origin;
      var_9 = var_6[0].origin;

      if(var_6[1].origin[0] > var_9[0])
        var_9 = (var_6[1].origin[0], var_9[1], var_9[2]);
      else
        var_8 = (var_6[1].origin[0], var_8[1], var_8[2]);

      if(var_6[1].origin[1] > var_9[1])
        var_9 = (var_9[0], var_6[1].origin[1], var_9[2]);
      else
        var_8 = (var_8[0], var_6[1].origin[1], var_8[2]);

      if(var_2.origin[0] < var_8[0] || var_2.origin[0] > var_9[0] || var_2.origin[1] < var_8[1] || var_2.origin[1] > var_9[1])
        continue;
    }

    if(var_2.threatlevel < var_4) {
      continue;
    }
    if(!scripts\engine\trace::_bullet_trace_passed(var_2.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    var_4 = var_2.threatlevel;
    var_5 = var_2;
  }

  return var_5;
}

update_player_threat(var_0) {
  var_0.threatlevel = 0;
  var_1 = distance(var_0.origin, self.origin);
  var_0.threatlevel = var_0.threatlevel + (level.heli_visual_range - var_1) / level.heli_visual_range * 100;

  if(isDefined(self.attacker) && var_0 == self.attacker)
    var_0.threatlevel = var_0.threatlevel + 100;

  if(isPlayer(var_0))
    var_0.threatlevel = var_0.threatlevel + var_0.score * 4;

  if(isDefined(var_0.antithreat))
    var_0.threatlevel = var_0.threatlevel - var_0.antithreat;

  if(var_0.threatlevel <= 0)
    var_0.threatlevel = 1;
}

heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self vehicle_setspeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

addrecentdamage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.recentdamageamount = self.recentdamageamount + var_0;
  wait 4.0;
  self.recentdamageamount = self.recentdamageamount - var_0;
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = 2;
  var_8 = 3;
  var_9 = 4;

  if(isDefined(self.helitype) && self.helitype == "_encstr_86F20A19E4F6E659469CDEE0") {
    var_7 = 1;
    var_8 = 1;
    var_9 = 2;
  }

  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, var_7, var_8, var_9);
  thread addrecentdamage(var_6);
  self notify("_encstr_878F0F4B23D172BFF8F9959E5198F7FAB3");
  return var_6;
}

handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(var_1)) {
    var_6 = level.heliconfigs[self.streakname];
    var_7 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.destroyedvo, var_6.callout);

    if(var_7) {
      var_1 notify("_encstr_A9E515C1A03B73E20F10A517DFDBD9BB23372738853FB3");
      self.killingattacker = var_1;
    }
  }
}

heli_damage_monitor(var_0, var_1, var_2) {
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.streakname = var_0;
  self.recentdamageamount = 0;

  if(!istrue(var_2))
    thread heli_health();

  scripts\mp\damage::monitordamage(self.maxhealth, "_encstr_8F010BD0591B4B36B7831D5693", ::handledeathdamage, ::modifydamage, 1, var_1);
}

heli_watchempdamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_93F60B2B5BC1EB912C5BB0ECB2", var_0, var_1);
    self.empgrenaded = 1;

    if(isDefined(self.mgturretleft))
      self.mgturretleft notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");

    if(isDefined(self.mgturretright))
      self.mgturretright notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");

    wait(var_1);
    self.empgrenaded = 0;

    if(isDefined(self.mgturretleft))
      self.mgturretleft notify("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F");

    if(isDefined(self.mgturretright))
      self.mgturretright notify("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F");
  }
}

heli_health() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self.currentstate = "_encstr_860703DF6B";
  self.laststate = "_encstr_860703DF6B";
  self setdamagestage(3);
  var_0 = 3;
  self setdamagestage(var_0);
  var_1 = level.heliconfigs[self.streakname];

  for(;;) {
    self waittill("_encstr_878F0F4B23D172BFF8F9959E5198F7FAB3");

    if(var_0 > 0 && self.damagetaken >= self.maxhealth) {
      var_0 = 0;
      self setdamagestage(var_0);
      stopFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_AB710C138DF945135923C1873708"], self, var_1.enginevfxtag);
      self notify("_encstr_AD75063D571AE108");
      break;
    } else {
      if(var_0 > 1 && self.damagetaken >= self.maxhealth * 0.66) {
        var_0 = 1;
        self setdamagestage(var_0);
        self.currentstate = "_encstr_B1B70CE38FC23DE2E80FD0C807C5";
        stopFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_88B00C804787D031211271086CFA"], self, var_1.enginevfxtag);
        playFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_AB710C138DF945135923C1873708"], self, var_1.enginevfxtag);
        continue;
      }

      if(var_0 > 2 && self.damagetaken >= self.maxhealth * 0.33) {
        var_0 = 2;
        self setdamagestage(var_0);
        self.currentstate = "_encstr_BE640C1B8B5CC3833A7BDDE76C38";
        playFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_88B00C804787D031211271086CFA"], self, var_1.enginevfxtag);
      }
    }
  }
}

heli_watchdeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8772059DDEDCAC");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    thread heli_explode(1);
  else {
    var_0 = level.heliconfigs[self.streakname];
    playFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_B2C108A86B8F011BE3E7"], self, var_0.enginevfxtag);
    thread heli_crash();
  }
}

heli_crash() {
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self clearlookatent();
  var_0 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];

  if(isDefined(self.mgturretleft))
    self.mgturretleft notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");

  if(isDefined(self.mgturretright))
    self.mgturretright notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(var_0);
  thread heli_explode();
}

heli_secondary_explosions() {
  var_0 = heli_getteamforsoundclip();
  var_1 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8DEC06B1E943615B"], self, var_1.enginevfxtag);
  self playSound(level.heli_sound[var_0]["_encstr_B6AF0D3189C340655F3A0831A26323"]);
  wait 3.0;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8DEC06B1E943615B"], self, var_1.enginevfxtag);
  self playSound(level.heli_sound[var_0]["_encstr_B6AF0D3189C340655F3A0831A26323"]);
}

heli_spin(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_1]["_encstr_BD1904D06B18"]);
  thread spinsoundshortly();
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

spinsoundshortly() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.25;
  var_0 = heli_getteamforsoundclip();
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level.heli_sound[var_0]["_encstr_B876094EEA622D60875F58"]);
  wait 0.05;
  self playLoopSound(level.heli_sound[var_0]["_encstr_88BB0AEBBB8A65966841F873"]);
}

heli_explode(var_0) {
  self notify("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && isDefined(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8F6D0AC2A5E4FAC8AC85D1A1"][self.heli_type])) {
    var_1 = self gettagangles("_encstr_871E0CFB5727199459F0D3AB2012");
    playFX(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8F6D0AC2A5E4FAC8AC85D1A1"][self.heli_type], self gettagorigin("_encstr_871E0CFB5727199459F0D3AB2012"), anglesToForward(var_1), anglestoup(var_1));
  } else {
    var_2 = self.origin;
    var_3 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_AD75063D571AE108"][self.heli_type], var_2, var_3);
  }

  var_4 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_4]["_encstr_8F9E06C26033324B"]);
  waitframe();

  if(isDefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["_encstr_8AEF05472BC2D6"]) || self.owner.pers["_encstr_8AEF05472BC2D6"] != self.team) {
    thread heli_leave();
    return 0;
  }

  return 1;
}

heli_leave_on_disconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread heli_leave();
}

heli_leave_on_changeteams(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  var_0 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread heli_leave();
}

heli_leave_on_spawned(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  var_0 waittill("_encstr_BA350853C128FB939DB9");
  thread heli_leave();
}

heli_leave_on_gameended(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread heli_leave();
}

heli_leave_on_timeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread heli_leave();
}

fireontarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 = 15;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.heli_loop_nodes) {
    var_2++;
    var_3 = var_3 + var_5.origin[2];
  }

  var_7 = var_3 / var_2;
  self notify("_encstr_865B0AEA20E71387B344959C");

  if(isDefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth) {
    return;
  }
  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }
  var_8 = self.primarytarget;
  var_8.antithreat = 0;
  var_9 = self.primarytarget.origin * (1, 1, 0);
  var_10 = self.origin * (0, 0, 1);
  var_11 = var_9 + var_10;
  var_12 = distance2d(self.origin, var_8.origin);

  if(var_12 < 1000)
    var_1 = 600;

  var_13 = anglesToForward(var_8.angles);
  var_13 = var_13 * (1, 1, 0);
  var_14 = var_11 + var_1 * var_13;
  var_15 = var_14 - var_11;
  var_16 = vectortoangles(var_15);
  var_16 = var_16 * (1, 1, 0);
  thread attackgroundtarget(var_8);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, var_14) < 1000)
    var_14 = var_14 * 1.5;

  var_14 = var_14 * (1, 1, 0);
  var_14 = var_14 + (0, 0, var_7);
  _setvehgoalpos(var_14, 1, 1);
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");

  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }
  self setlookatent(var_8);
  thread isfacing(10, var_8);
  scripts\engine\utility::_id_143B9(4, "_encstr_8B99079916D85A9BD9");

  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }
  self clearlookatent();
  var_17 = var_11 + var_1 * anglesToForward(var_16);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var_17, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isDefined(var_8) && isalive(var_8)) {
    if(isDefined(var_8.antithreat))
      var_8.antithreat = var_8.antithreat + 100;
    else
      var_8.antithreat = 100;
  }

  scripts\engine\utility::_id_143B9(3, "_encstr_B4D10ADC950BE4EB76DE8536");
}

attackgroundtarget(var_0) {
  self notify("_encstr_B89513858E1DC2D8B68E27B757E6C845C24ECE59A3");
  self endon("_encstr_B89513858E1DC2D8B68E27B757E6C845C24ECE59A3");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetEnt(var_0);
  waitontargetordeath(var_0, 3.0);

  if(!isalive(var_0))
    self.isattacking = 0;
  else {
    var_1 = distance2dsquared(self.origin, var_0.origin);

    if(var_1 < 640000) {
      thread dropbombs(var_0);
      self.isattacking = 0;
      return;
    } else {
      if(checkisfacing(50, var_0) && scripts\engine\utility::cointoss()) {
        thread firemissile(var_0);
        self.isattacking = 0;
        return;
        return;
      }

      var_2 = weaponfiretime("_encstr_8A5B0EF8E57ABAD0C1B22960CDB84528");
      var_3 = 0;
      var_4 = 0;

      for(var_5 = 0; var_5 < level.heli_turretclipsize; var_5++) {
        if(!isDefined(self)) {
          break;
        }

        if(self.empgrenaded) {
          break;
        }

        if(!isDefined(var_0)) {
          break;
        }

        if(!isalive(var_0)) {
          break;
        }

        if(self.damagetaken >= self.maxhealth) {
          continue;
        }
        if(!checkisfacing(55, var_0)) {
          self stoploopsound();
          var_4 = 0;
          wait(var_2);
          var_5--;
          continue;
        }

        if(var_5 < level.heli_turretclipsize - 1)
          wait(var_2);

        if(!isDefined(var_0) || !isalive(var_0)) {
          break;
        }

        if(!var_4) {
          self playLoopSound("_encstr_B20B18F7CD51BBA1A120821AA92D328788B86E91DE79BF357998");
          var_4 = 1;
        }

        self setvehweapon("_encstr_8A5B0EF8E57ABAD0C1B22960CDB84528");
        self fireweapon("_encstr_A14F0AE336178944BA076F41", var_0);
      }

      if(!isDefined(self)) {
        return;
      }
      self stoploopsound();
      var_4 = 0;
      self.isattacking = 0;
    }
  }
}

checkisfacing(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_0))
    var_0 = 10;

  var_2 = anglesToForward(self.angles);
  var_3 = var_1.origin - self.origin;
  var_2 = var_2 * (1, 1, 0);
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectorNormalize(var_3);
  var_2 = vectorNormalize(var_2);
  var_4 = vectordot(var_3, var_2);
  var_5 = cos(var_0);

  if(var_4 >= var_5)
    return 1;
  else
    return 0;
}

isfacing(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_0))
    var_0 = 10;

  while(isalive(var_1)) {
    var_2 = anglesToForward(self.angles);
    var_3 = var_1.origin - self.origin;
    var_2 = var_2 * (1, 1, 0);
    var_3 = var_3 * (1, 1, 0);
    var_3 = vectorNormalize(var_3);
    var_2 = vectorNormalize(var_2);
    var_4 = vectordot(var_3, var_2);
    var_5 = cos(var_0);

    if(var_4 >= var_5) {
      self notify("_encstr_8B99079916D85A9BD9");
      break;
    }

    wait 0.1;
  }
}

waitontargetordeath(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB", var_1);
}

firemissile(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 = 2;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(!isDefined(var_0)) {
      return;
    }
    if(scripts\engine\utility::cointoss()) {
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_81D01086A5CD917DAD2DCDDCB463B2EBAD38"), self gettagorigin("_encstr_87DC123B61C2AEDF5B1A535BCA3280D507FA78A3") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    } else {
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_81D01086A5CD917DAD2DCDDCB463B2EBAD38"), self gettagorigin("_encstr_BD9C11E357FA188352C3D830D3E041303D023B") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    }

    var_3 missile_settargetEnt(var_0);
    var_3.owner = self;
    var_3 missile_setflightmodedirect();
    wait(0.5 / var_1);
  }
}

dropbombs(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_0)) {
    return;
  }
  for(var_1 = 0; var_1 < randomintrange(2, 5); var_1++) {
    if(scripts\engine\utility::cointoss()) {
      var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_9B010D63FB58DC21E26810EB9F65F0"), self gettagorigin("_encstr_BD9C11E357FA188352C3D830D3E041303D023B") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    } else {
      var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_9B010D63FB58DC21E26810EB9F65F0"), self gettagorigin("_encstr_87DC123B61C2AEDF5B1A535BCA3280D507FA78A3") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

getoriginoffsets(var_0) {
  var_1 = self.origin;
  var_2 = var_0.origin;
  var_3 = 0;
  var_4 = 40;
  var_5 = (0, 0, -196);

  for(var_6 = scripts\engine\trace::_bullet_trace(var_1 + var_5, var_2 + var_5, 0, self); distancesquared(var_6["_encstr_BD260953AA97E3F014279D"], var_2 + var_5) > 10 && var_3 < var_4; var_6 = scripts\engine\trace::_bullet_trace(var_1 + var_5, var_2 + var_5, 0, self)) {
    if(var_1[2] < var_2[2])
      var_1 = var_1 + (0, 0, 128);
    else if(var_1[2] > var_2[2])
      var_2 = var_2 + (0, 0, 128);
    else {
      var_1 = var_1 + (0, 0, 128);
      var_2 = var_2 + (0, 0, 128);
    }

    var_3++;
  }

  var_7 = [];
  var_7["_encstr_99AD06D3A5B1538B"] = var_1;
  var_7["_encstr_961804BD954A"] = var_2;
  return var_7;
}

traveltonode(var_0) {
  var_1 = getoriginoffsets(var_0);

  if(var_1["_encstr_99AD06D3A5B1538B"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["_encstr_99AD06D3A5B1538B"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("_encstr_8B7205D9ED5958");
  }

  if(var_1["_encstr_961804BD954A"] != var_0.origin) {
    if(isDefined(var_0.script_airspeed) && isDefined(var_0.script_accel)) {
      var_2 = var_0.script_airspeed;
      var_3 = var_0.script_accel;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["_encstr_961804BD954A"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("_encstr_8B7205D9ED5958");
  }
}

_setvehgoalpos(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = 0;

  if(var_2)
    thread _setvehgoalposadheretomesh(var_0, var_1);
  else
    self setvehgoalpos(var_0, var_1);
}

_setvehgoalposadheretomesh(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_2 = var_0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(self.origin, var_2) < 65536) {
      self setvehgoalpos(var_2, var_1);
      break;
    }

    var_3 = vectortoangles(var_2 - self.origin);
    var_4 = anglesToForward(var_3);
    var_5 = self.origin + var_4 * (1, 1, 0) * 250;
    var_6 = (0, 0, 2500);
    var_7 = var_5 + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + var_6);
    var_8 = var_5 + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - var_6);
    var_9 = scripts\engine\trace::_bullet_trace(var_7, var_8, 0, self, 0, 0, 1);
    var_10 = var_9;

    if(isDefined(var_9["_encstr_850E077B0BF30318B9"]) && var_9["_encstr_850E077B0BF30318B9"] == self && var_9["_encstr_820E07FAE8780B3A4C"][2] > 0.1) {
      var_11 = var_9["_encstr_BD260953AA97E3F014279D"][2] - 4400;
      var_12 = var_11 - self.origin[2];

      if(var_12 > 256) {
        var_9["_encstr_BD260953AA97E3F014279D"] = var_9["_encstr_BD260953AA97E3F014279D"] * (1, 1, 0);
        var_9["_encstr_BD260953AA97E3F014279D"] = var_9["_encstr_BD260953AA97E3F014279D"] + (0, 0, self.origin[2] + 256);
      } else if(var_12 < -256) {
        var_9["_encstr_BD260953AA97E3F014279D"] = var_9["_encstr_BD260953AA97E3F014279D"] * (1, 1, 0);
        var_9["_encstr_BD260953AA97E3F014279D"] = var_9["_encstr_BD260953AA97E3F014279D"] + (0, 0, self.origin[2] - 256);
      }

      var_10 = var_9["_encstr_BD260953AA97E3F014279D"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 600);
    } else
      var_10 = var_2;

    self setvehgoalpos(var_10, 0);
    wait 0.15;
  }
}

heli_fly_simple_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self notify("_encstr_A65507CC1B2F4BDC3B");
  self endon("_encstr_A65507CC1B2F4BDC3B");
  heli_reset();
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      var_3 = var_1.script_airspeed;
      var_4 = var_1.script_accel;
    } else {
      var_3 = 30 + randomint(20);
      var_4 = 15 + randomint(15);
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      waitframe();
      continue;
    }

    self vehicle_setspeed(75, 35);

    if(!isDefined(var_2.target)) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1);
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    } else {
      _setvehgoalpos(var_2.origin + self.zoffset, 0);
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      self setgoalyaw(var_2.angles[1]);
      self waittillmatch("_encstr_8B7205D9ED5958");
    }

    var_1 = var_2;
  }
}

heli_fly_loop_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self notify("_encstr_A65507CC1B2F4BDC3B");
  self endon("_encstr_A65507CC1B2F4BDC3B");
  heli_reset();
  thread heli_loop_speed_control(var_0);
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.25;
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait 0.1;
      continue;
    }

    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      self.desired_speed = var_1.script_airspeed;
      self.desired_accel = var_1.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "_encstr_810E07FAF85B0A07E3") {
      self.desired_speed = self.desired_speed * 0.5;
      self.desired_accel = self.desired_accel * 0.5;
    }

    if(isDefined(var_2.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1, 1);
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      wait(var_2.script_delay);
    } else {
      _setvehgoalpos(var_2.origin + self.zoffset, 0, 1);
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      self setgoalyaw(var_2.angles[1]);
      self waittillmatch("_encstr_8B7205D9ED5958");
    }

    var_1 = var_2;
  }
}

heli_loop_speed_control(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(var_0.script_airspeed) && isDefined(var_0.script_accel)) {
    self.desired_speed = var_0.script_airspeed;
    self.desired_accel = var_0.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  var_1 = 0;
  var_2 = 0;

  for(;;) {
    var_3 = self.desired_speed;
    var_4 = self.desired_accel;

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(self.helitype != "_encstr_810E07FAF85B0A07E3" && isDefined(self.primarytarget) && !heli_is_threatened())
      var_3 = var_3 * 0.25;

    if(var_1 != var_3 || var_2 != var_4) {
      self vehicle_setspeed(75, 35);
      var_1 = var_3;
      var_2 = var_4;
    }

    wait 0.05;
  }
}

heli_is_threatened() {
  if(self.recentdamageamount > 50)
    return 1;

  if(self.currentstate == "_encstr_B1B70CE38FC23DE2E80FD0C807C5")
    return 1;

  return 0;
}

heli_fly_well(var_0) {
  self notify("_encstr_A65507CC1B2F4BDC3B");
  self endon("_encstr_A65507CC1B2F4BDC3B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  for(;;) {
    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    var_1 = get_best_area_attack_node(var_0);
    traveltonode(var_1);

    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      var_2 = var_1.script_airspeed;
      var_3 = var_1.script_accel;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1.origin + self.zoffset, 1);
    self setgoalyaw(var_1.angles[1] + level.heli_angle_offset);

    if(level.heli_forced_wait != 0) {
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      wait(level.heli_forced_wait);
      continue;
    }

    if(!isDefined(var_1.script_delay)) {
      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("_encstr_8B7205D9ED5958");
    wait(var_1.script_delay);
  }
}

get_best_area_attack_node(var_0) {
  return updateareanodes(var_0);
}

heli_leave(var_0) {
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self clearlookatent();

  if(isDefined(self.helitype) && self.helitype == "_encstr_924307FF530288A5F7" && isDefined(self.pathgoal)) {
    _setvehgoalpos(self.pathgoal, 1);
    scripts\engine\utility::_id_143B9(5, "_encstr_8B7205D9ED5958");
  }

  if(!isDefined(var_0)) {
    var_1 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    var_0 = var_1.origin;
  }

  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);

  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread wait_and_delete(3.0);
  }

  var_3 = (var_0 - self.origin) * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var_3, 1);
  scripts\engine\utility::_id_143B9(12, "_encstr_8B7205D9ED5958");
  self notify("_encstr_8772059DDEDCAC");
  self notify("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

wait_and_delete(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  self delete();
}

debug_print3d(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_text(var_0, var_1, var_2, var_3, var_4);
}

debug_print3d_simple(var_0, var_1, var_2, var_3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isDefined(var_3))
      thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, var_3);
    else
      thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, 0);
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0 && !isDefined(var_3))
    thread draw_line(var_0, var_1, var_2);
  else if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(var_0, var_1, var_2, var_3);
}

draw_text(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    while(isDefined(var_2))
      wait 0.05;
  } else {
    for(var_5 = 0; var_5 < var_4; var_5++) {
      if(!isDefined(var_2)) {
        break;
      }

      wait 0.05;
    }
  }
}

draw_line(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    for(var_4 = 0; var_4 < var_3; var_4++)
      wait 0.05;
  } else {
    for(;;)
      wait 0.05;
  }
}

exceededmaxlittlebirds(var_0) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && var_0 == "_encstr_BEC91160B48450C1AA8BDBF58BD11C58278E08")
    return 1;
  else
    return 0;
}

pavelowmadeselectionvo() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self playlocalsound(game["_encstr_8F8206ACFA5A81B5"][self.team] + "_encstr_B2B40F39B9B8141A228E4B6E4BF04D1D67");
  wait 3.5;
  self playlocalsound(game["_encstr_8F8206ACFA5A81B5"][self.team] + "_encstr_82920F74CF59D0FBA12F2F3BBDD8333668");
}

lbonkilled() {
  self endon("_encstr_8772059DDEDCAC");

  if(!isDefined(self)) {
    return;
  }
  self notify("_encstr_86BD0980BBC647A80FDE04");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    waitframe();
  else {
    self vehicle_setspeed(25, 5);
    thread lbspin(randomintrange(180, 220));
    wait(randomfloatrange(1.0, 2.0));
  }

  lbexplode();
}

lbspin(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  playFXOnTag(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_AB5E07609A5B7368E5"], self, "_encstr_A25B0F90226CE1D68B2775E01217385D93");
  thread trail_fx(level.chopper_fx["_encstr_BE7206A2D07B1322"]["_encstr_8AA6067362614831"], "_encstr_A25B0F90226CE1D68B2775E01217385D93", "_encstr_8BDF10BF5BC8433295E75350289BC5D74497");
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

lbexplode() {
  var_0 = self.origin + (0, 0, 1) - self.origin;
  var_1 = self gettagangles("_encstr_871E0CFB5727199459F0D3AB2012");
  playFX(level.chopper_fx["_encstr_860808CB78E2984063BA"]["_encstr_8F6D0AC2A5E4FAC8AC85D1A1"]["_encstr_A3780B731385FBD498E1FC0219"], self gettagorigin("_encstr_871E0CFB5727199459F0D3AB2012"), anglesToForward(var_1), anglestoup(var_1));
  self playSound("_encstr_AF73140D3BFB572AB79A176E47087BED9A49EE15DD05");
  self notify("_encstr_860808CB78E2984063BA");
  removelittlebird();
}

trail_fx(var_0, var_1, var_2) {
  self notify(var_2);
  self endon(var_2);
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    playFXOnTag(var_0, self, var_1);
    wait 0.05;
  }
}

removelittlebird() {
  if(isDefined(self.mgturretleft)) {
    if(isDefined(self.mgturretleft.killcament))
      self.mgturretleft.killcament delete();

    self.mgturretleft delete();
  }

  if(isDefined(self.mgturretright)) {
    if(isDefined(self.mgturretright.killcament))
      self.mgturretright.killcament delete();

    self.mgturretright delete();
  }

  if(isDefined(self.marker))
    self.marker delete();

  if(isDefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self)
    level.heli_pilot[self.team] = undefined;

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}