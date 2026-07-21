/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\drone\scout_drone.gsc
***********************************************/

init() {
  level.use_scout_drone_func = ::deploy_scout_drone;
  level.use_ac130_drone_func = ::deploy_ac130_drone;
  level.use_detonate_drone_func = ::deploy_scout_detonate_drone;
  load_fx();
}

craft_scout_drone(var_0) {
  if(istrue(self.using_drone)) {
    return;
  }
  if(istrue(self.tablet_out)) {
    return;
  }
  self.nvg_was_on = 0;

  if(self isnightvisionon()) {
    self.nvg_was_on = 1;
    self nightvisionviewoff();
  }

  if(!isDefined(var_0))
    var_0 = make_scout_config();

  thread scripts\cp\drone\utility::deploy_drone(self, var_0);
}

deploy_scout_drone(var_0) {
  var_1 = make_scout_config();
  var_0 thread craft_scout_drone(var_1);
}

deploy_ac130_drone(var_0) {
  var_1 = make_ac130_drone_config();
  var_0 thread craft_scout_drone(var_1);
}

deploy_scout_detonate_drone(var_0) {
  var_1 = make_scout_detonate_config();
  var_0 thread craft_scout_drone(var_1);
}

deploy_collection_drone(var_0) {
  var_1 = make_collection_config();
  var_0 thread craft_scout_drone(var_1);
}

deploy_scout_drone_generic(var_0) {
  scripts\cp\drone\utility::deploy_drone(var_0, make_scout_config());
}

make_scout_config() {
  var_0 = spawnStruct();
  var_0.model = "_encstr_8C1519D3C333875F90D8F531F198BA491963231BB3F07B552880ED";
  var_0.vehicle_info = "_encstr_9A351928CA841FEB2FD40786974393376D52E9B0629E87A0FFF597";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30;
  var_0.use_func = ::use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 1;
  return var_0;
}

make_ac130_drone_config() {
  var_0 = spawnStruct();
  var_0.model = "_encstr_8C1519D3C333875F90D8F531F198BA491963231BB3F07B552880ED";
  var_0.vehicle_info = "_encstr_A59512930108592730F07216B3B64F083ABE88DF";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30000;
  var_0.use_func = ::use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 0;
  var_0.send_down = 1;
  return var_0;
}

make_scout_detonate_config() {
  var_0 = spawnStruct();
  var_0.model = "_encstr_8C1519D3C333875F90D8F531F198BA491963231BB3F07B552880ED";
  var_0.vehicle_info = "_encstr_A59512930108592730F07216B3B64F083ABE88DF";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30000;
  var_0.use_func = ::use_scout_drone;
  var_0.detonate_mines = 1;
  var_0.play_intro = 0;
  return var_0;
}

make_collection_config() {
  var_0 = spawnStruct();
  var_0.model = "_encstr_8C1519D3C333875F90D8F531F198BA491963231BB3F07B552880ED";
  var_0.vehicle_info = "_encstr_9A351928CA841FEB2FD40786974393376D52E9B0629E87A0FFF597";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30;
  var_0.use_func = ::use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 1;
  var_0.no_control = 1;
  return var_0;
}

use_scout_drone(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");

  foreach(var_3 in level.players) {
    if(var_3 != var_0)
      var_3 thread scripts\cp\cp_hud_message::showsplash("_encstr_B2A8162EC9B7AB678B8BA66F38FF21C8B883F783336FB591", undefined, var_0);
  }

  var_1.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_B8070A12833060F0C234F563", var_0.owner, undefined, 0, 1);
  var_1.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", var_0, var_0, 1);
  var_1 thread scout_drone_clean_up(var_0, var_1);

  if(istrue(var_1.mark_ai))
    var_1 thread scout_drone_mark_npcs();

  if(istrue(var_1.mark_vehicles))
    var_1 thread scout_drone_markvehicles();

  if(istrue(var_1.self_destruct)) {
    var_0 notifyonplayercommand("_encstr_82A313087A32E9D8DF1FFEFE37B7E3C71E52A82883", "_encstr_97410B23BD6B976233901AF2F8");

    for(;;) {
      var_0 thread scripts\cp\utility::hint_prompt("_encstr_85540E4743B1E2DF58D9B27B13F82B7B", 1);
      var_0 waittill("_encstr_82A313087A32E9D8DF1FFEFE37B7E3C71E52A82883");
      var_1 radiusdamage(var_1.origin, 160, 180, 10, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
      var_1 thread notify_nearby_enemies();
      var_0 thread scripts\cp\utility::hint_prompt("_encstr_85540E4743B1E2DF58D9B27B13F82B7B", 0);
      break;
    }

    var_1 thread delay_exit_drone(var_0, var_1);
  } else if(istrue(var_1.detonate_mines)) {
    var_0 notifyonplayercommand("_encstr_96F80C83EDB5126B0179723D10F8", "_encstr_A6E308B2DCE8B0B936B2");

    for(;;) {
      var_0 waittill("_encstr_96F80C83EDB5126B0179723D10F8");
      var_1 thread notify_nearby_enemies();
      break;
    }

    var_1 thread delay_exit_drone(var_0, var_1);
  }
}

playremotesequence(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp\utility::isusingremote())
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  self notify("_encstr_AD66151CC6B0CBBE93566BED1D56BE37952ED5ACCDD8CA");
  self playlocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
  var_2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground())
    return 0;

  var_2 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
  scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

  if(istrue(var_3))
    thread scripts\cp\cp_weapons::watchformanualweaponend(var_2);
  else
    return 0;

  scripts\cp\utility::setusingremote(var_0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var_4 = scripts\engine\utility::_id_143B9(1.8, "_encstr_AD75063D571AE108");
  self notify("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();

  if(isDefined(var_2))
    self takeweapon(var_2);

  self stoplocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
  return 1;
}

scout_drone_mark_npcs() {
  var_0 = self.owner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  for(;;) {
    foreach(var_3 in var_1) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_3 scripts\cp\utility::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
        continue;
      }
      if(isbeingmarked(var_3)) {
        continue;
      }
      if(isreconmarked(var_3)) {
        continue;
      }
      if(!isinmarkingrange(var_3)) {
        continue;
      }
      if(!canseetarget(var_3)) {
        continue;
      }
      if(var_0 helperdrone_istargetinreticle(var_3, 70, 50))
        thread startmarkingtarget(var_3, "_encstr_88BF06FD784A6393", 0, 1);
    }

    wait 0.05;
  }
}

canseetarget(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var_3 = [var_0.origin];

  if(isPlayer(var_0) || isagent(var_0))
    var_3 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0.origin];

  var_4 = [self, var_0];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var_3[var_5], var_4, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

scout_drone_markvehicles(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    var_2 = vehicle_getarray();

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(var_4)) {
        continue;
      }
      if(level.teambased && isDefined(var_4.script_team) && var_4.script_team == self.team)
        continue;
      else if(level.teambased && isDefined(var_4.team) && var_4.team == self.team)
        continue;
      else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }
      if(isbeingmarked(var_4)) {
        continue;
      }
      if(isreconmarked(var_4)) {
        continue;
      }
      if(!isinmarkingrange(var_4)) {
        continue;
      }
      if(!canseetarget(var_4)) {
        continue;
      }
      if(var_1 helperdrone_istargetinreticle(var_4, 70, 50))
        thread startmarkingtarget(var_4, "_encstr_BE8F0A272F9B2BE97268AE8B", 0, 1);
    }

    wait 0.1;
  }
}

helperdrone_markequipment(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    var_2 = [[level.getactiveequipmentarray]]();

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(var_4)) {
        continue;
      }
      if(level.teambased && var_4.team == self.team)
        continue;
      else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }
      if(isbeingmarked(var_4)) {
        continue;
      }
      if(isreconmarked(var_4)) {
        continue;
      }
      if(!isinmarkingrange(var_4)) {
        continue;
      }
      if(!canseetarget(var_4)) {
        continue;
      }
      if(var_1 helperdrone_istargetinreticle(var_4, 70, 50))
        thread startmarkingtarget(var_4, "_encstr_BE8F0A272F9B2BE97268AE8B", 0, 1);
    }

    waitframe();
  }
}

helperdrone_markkillstreaks(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    var_2 = level.activekillstreaks;

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(var_4)) {
        continue;
      }
      if(level.teambased && var_4.team == self.team)
        continue;
      else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }
      if(isbeingmarked(var_4)) {
        continue;
      }
      if(isreconmarked(var_4)) {
        continue;
      }
      if(!isinmarkingrange(var_4)) {
        continue;
      }
      if(!canseetarget(var_4)) {
        continue;
      }
      if(var_1 helperdrone_istargetinreticle(var_4, 70, 50))
        thread startmarkingtarget(var_4, "_encstr_85CE0B9770B02C73A1760F06D2", 0, 1);
    }

    waitframe();
  }
}

isreconmarked(var_0) {
  return istrue(var_0.reconmarked);
}

isinouterradius(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_0.targetsinouterradius, var_1);
}

isbeingmarked(var_0) {
  return isDefined(var_0.beingmarked);
}

isinmarkingrange(var_0) {
  return distancesquared(self.origin, var_0.origin) < 4000000;
}

startmarkingtarget(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_5 = self.enemytargetmarkergroup;

  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(self.enemiesmarked))
    self.enemiesmarked = [];

  var_0.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("_encstr_921D0FCBD1C8481B52778FDB7BA3D9101B");
  self.owner setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 2);
  var_6 = 0.5;

  while(var_6 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_4 helperdrone_istargetinreticle(var_0, 70, 50)) {
      var_0.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 1);
      return;
    }

    var_6 = var_6 - 0.05;
    wait 0.05;
  }

  var_0.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var_0, self, undefined, "_encstr_917A092B37C8AF6BC2C9D6");
  self.owner setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 3);
  self.owner playlocalsound("_encstr_8ABE0FFBA9A75F40E0A8C0AECDB9A3C78F");
  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "_encstr_8ABE0FFBA9A75F40E0A8C0AECDB9A3C78F");
  targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var_0, 1);
  var_7 = 30;
  var_0 scripts\engine\utility::_id_143BA(var_7, "_encstr_AD75063D571AE108", "_encstr_8AEC13372BE8F5B97BB9C6B70E597BEA3AB19673AC");

  if(var_4 helperdrone_istargetinreticle(var_0, 70, 150) && !var_0 scripts\cp\utility::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
    targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var_0, 0);
  else
    targetmarkergroupsetentitystate(self.enemytargetmarkergroup, var_0);

  var_0 notify("_encstr_917A092B37C8AF6BC2C9D6");
}

resetreticlemarkingprogressstate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_921D0FCBD1C8481B52778FDB7BA3D9101B");
  wait(var_0);
  self.owner setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 1);
}

helperdrone_istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [var_0.origin];

  if(isPlayer(var_0) || isagent(var_0))
    var_4 = [var_0.origin, var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62")];

  foreach(var_6 in var_4) {
    if(self worldpointinreticle_circle(var_6, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

markent(var_0, var_1, var_2, var_3) {
  self.enemiesmarked[self.enemiesmarked.size] = var_0;
  var_4 = var_1.owner;

  if(level.teambased)
    var_4 = var_1.team;

  var_0 hudoutlineenable(1, 0, 1);
  var_1 thread markent_watchmarkingentstatus(var_0);
  var_1 thread markent_watchtargetstatus(var_0, var_2, var_3);
}

markent_getclassperkicon(var_0, var_1) {
  var_2 = var_0;
  var_3 = undefined;

  if(isDefined(var_1.loadoutperks)) {
    foreach(var_5 in var_1.loadoutperks) {
      if(scripts\engine\utility::array_contains(level.perkpackagelist, var_5)) {
        var_3 = var_5;
        break;
      }
    }

    if(isDefined(var_3))
      var_2 = level.perktable[var_3].npicon;
  }

  return var_2;
}

markent_getweaponicon(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_5 = spawnStruct();

  if(isDefined(var_2.weapon_name)) {
    var_6 = undefined;

    if(issubstr(var_2.weapon_name, "_encstr_9BD1091BC62CBCB5F6E4CA"))
      var_6 = "_encstr_82A70F2B3B73E33B472371FF21D7809DDF";
    else if(issubstr(var_2.weapon_name, "_encstr_8B07036CD0"))
      var_6 = "_encstr_843D095F2B7D52B041D9A3";
    else if(issubstr(var_2.weapon_name, "_encstr_8DD607A129A99C737D"))
      var_6 = "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95";
    else if(issubstr(var_2.weapon_name, "_encstr_9BB4074B8EEF3942D8"))
      var_6 = "_encstr_AA870D15FAF37393C74318F8BB184A";

    if(isDefined(var_6))
      var_3 = level.equipment.table[var_6].image;
  } else if(isDefined(var_2.streakinfo)) {
    var_7 = var_2.streakinfo.streakname;
    var_3 = game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref[var_7]["_encstr_8FAE0D7BECCA4ED05958C892B1B737"];
    var_4 = 75;
  }

  var_5.weaponicon = var_3;
  var_5.weaponoffset = var_4;
  return var_5;
}

markent_watchmarkingentstatus(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_872409FFF591325240B917");
  scripts\engine\utility::_id_143A6("_encstr_860808CB78E2984063BA", "_encstr_AD75063D571AE108", "_encstr_BA2D081B2B58B32D37EC");
  wait 3;
  unmark(var_0);
}

markent_watchtargetstatus(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_872409FFF591325240B917");
  thread resetreticlemarkingprogressstate(0.5);

  if(isDefined(var_1))
    var_0 scripts\engine\utility::_id_143BB(var_1, "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", var_2);
  else
    var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", var_2);

  unmark(var_0);
}

unmark(var_0) {
  var_0 hudoutlinedisable();

  if(isDefined(var_0)) {
    var_0.reconmarked = undefined;
    var_0.beingmarked = undefined;

    if(isDefined(self)) {
      if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0)
        self.enemiesmarked = scripts\engine\utility::array_remove(self.enemiesmarked, var_0);
    }

    if(isPlayer(var_0))
      var_0 setclientomnvar("_encstr_B81115C3DFC1DB481F7764911B0FBDC317882064779E6B", 0);

    var_0 notify("_encstr_872409FFF591325240B917");
  } else if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0)
    self.enemiesmarked = scripts\engine\utility::array_removeundefined(self.enemiesmarked);
}

notify_nearby_enemies() {
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, undefined, 1000);

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 notify("_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
      var_3 notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
    }
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    var_0 = scripts\cp\utility::getactorsinradius(self.origin, 1000);

    if(var_0.size > 0) {
      foreach(var_6 in var_0) {
        if(isai(var_6)) {
          var_6 notify("_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
          var_6 notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
        }
      }
    }
  }
}

delay_exit_drone(var_0, var_1) {
  wait 0.3;

  if(isDefined(var_0))
    scripts\cp\drone\utility::exit_drone(var_0, var_1);

  if(isDefined(var_1))
    scripts\cp\drone\utility::drone_explode(var_1);
}

self_destruct_drone(var_0, var_1) {
  var_2 = 0.3;

  if(isDefined(var_1.extra_drone_delay))
    var_2 = var_1.extra_drone_delay;

  if(isDefined(var_1))
    playFX(level._effect["_encstr_BE52103B07CAD707F23870738F8543EBA910"], var_1.origin);

  if(isDefined(var_0))
    drone_exit_delayed(var_0, var_1, var_1.extra_drone_delay);

  if(isDefined(var_1))
    var_1 delete();
}

drone_exit_delayed(var_0, var_1, var_2) {
  if(isent(var_1))
    var_1 playSound("_encstr_B6011586E78A6778D463D8E807D7F1BB534B7E807842C9");

  if(!isent(var_1)) {
    return;
  }
  scripts\cp\drone\utility::turn_off_drone_hud(var_0);
  var_0 setplayerangles(var_0.pre_drone_angles);
  var_0.using_drone = undefined;
  var_0.disable_map_tablet = undefined;
  wait(var_2);
  var_0 remotecontrolvehicleoff();
  var_0 cameraunlink(var_1);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_3 = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 switchtoweapon(var_3);
  var_0 takeweapon("_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1");
  var_0 scripts\common\utility::allow_weapon(1);
  var_0 scripts\common\utility::allow_usability(1);
  var_0 notify("_encstr_88D00E3B7B9B3CA095EFB8551AAA05C9");
  var_0 notify("_encstr_B80910D79858A80105B4FE12F101C5F76343");
}

scout_drone_clean_up(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 waittill("_encstr_AD75063D571AE108");
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1.enemytargetmarkergroup);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1.friendlytargetmarkergroup);
  var_0 thread scripts\cp\utility::hint_prompt("_encstr_AABA12C8628DB3D31F0A59C7F35B7E45F7AAE810", 0);
  var_0 thread scripts\cp\utility::hint_prompt("_encstr_A77411A770800533C74BDC933849BACA29F833", 0);
  var_0 thread delay_nvgs();

  if(isDefined(level.scout_drone_clean_up_func))
    level thread[[level.scout_drone_clean_up_func]](var_0, var_1);
}

delay_nvgs() {
  wait 0.75;

  if(self.nvg_was_on)
    self nightvisionviewon();
}

load_fx() {
  scripts\cp\drone\utility::load_fx();
}