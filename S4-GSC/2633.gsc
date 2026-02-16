/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2633.gsc
*************************************************/

init() {
  level._id_76FF = [];
  level._id_77D3 = [];
  level._id_77D3["heli_pilot"] = spawnStruct();
  level._id_77D3["heli_pilot"]._id_F224 = 60.0;
  level._id_77D3["heli_pilot"].maxhealth = 2000;
  level._id_77D3["heli_pilot"].streakname = "heli_pilot";
  level._id_77D3["heli_pilot"].vehicleinfo = "heli_pilot_mp";
  level._id_77D3["heli_pilot"].modelbase = "vehicle_aas_72x_killstreak";
  level._id_77D3["heli_pilot"]._id_EFAC = "used_heli_pilot";
  _id_77CC();
  level._id_7702 = scripts\cp_mp\utility\game_utility::_id_6B17("heli_pilot_mesh");

  if(!isDefined(level._id_7702)) {} else
    level._id_7702.origin = level._id_7702.origin + scripts\mp\utility\killstreak::_id_6A98();

  var_0 = spawnStruct();
  var_0._id_CC16 = "destroyed_helo_pilot";
  var_0._id_1068F = undefined;
  var_0._id_2F66 = "callout_destroyed_helo_pilot";
  var_0._id_CB13 = 0.09;
  var_0._id_5463 = "tag_engine_right";
  level._id_776D["heli_pilot"] = var_0;
}

_id_F786(var_0, var_1) {
  var_2 = "heli_pilot";
  var_3 = 1;

  if(isDefined(self._id_F941) && self._id_F941) {
    return 0;
  } else if(_id_56CE(self.team)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 + var_3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::_id_7DEF();
  var_4 = _id_3FEE(var_2);

  if(!isDefined(var_4)) {
    scripts\mp\utility\killstreak::_id_455A();
    return 0;
  }

  level._id_76FF[self.team] = var_4;
  var_5 = _id_E6B8(var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return var_5;
}

_id_56CE(var_0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level._id_76FF[var_0]) || isDefined(level._id_76FF[scripts\mp\utility\game::_id_6BE2(var_0)[0]])) {
      return 1;
    } else {
      return 0;
    }
  } else if(isDefined(level._id_76FF[var_0]))
    return 1;
  else {
    return 0;
  }
}

_id_10B81(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    var_0 setclientomnvar("ui_heli_pilot", 1);
  }
}

_id_3FEE(var_0) {
  var_1 = _id_77C8(self.origin);
  var_2 = _id_77C9(var_1);
  var_3 = vectortoangles(var_2.origin - var_1.origin);
  var_4 = anglesToForward(self.angles);
  var_5 = var_2.origin + var_4 * -100;
  var_6 = var_1.origin;
  var_7 = spawnhelicopter(self, var_6, var_3, level._id_77D3[var_0].vehicleinfo, level._id_77D3[var_0].modelbase);

  if(!isDefined(var_7)) {
    return;
  }
  var_7 makevehiclesolidcapsule(18, -9, 18);
  var_7 scripts\mp\utility\killstreak::_id_1162(var_7 getentitynumber());
  var_7 thread scripts\mp\utility\killstreak::_id_C4AE(var_7 getentitynumber());
  var_7.maxhealth = level._id_77D3[var_0].maxhealth;
  var_7.speed = 40;
  var_7.owner = self;
  var_7 setotherent(self);
  var_7.team = self.team;
  var_7._id_77E7 = "littlebird";
  var_7._id_77D4 = "heli_pilot";
  var_7 setmaxpitchroll(45, 45);
  var_7 vehicle_setspeed(var_7.speed, 40, 40);
  var_7 setyawspeed(120, 60);
  var_7 setneargoalnotifydist(32);
  var_7 sethoverparams(100, 100, 100);
  var_7 _id_0812::_id_C2B2("Killstreak_Air", self);
  var_7._id_EEF5 = var_5;
  var_7._id_41D8 = var_2;
  var_7._id_1E2B = 10000;
  var_7._id_1E2A = 150;
  var_7._id_1E2E = _func_014B(var_7, var_7._id_1E2B, var_7._id_1E2A);
  var_7 thread scripts\mp\killstreaks\helicopter::_id_7699("heli_pilot");
  var_7 thread _id_77CB();
  var_7 thread _id_77D2();
  var_7 thread _id_77D0();
  var_7 thread _id_77D1();
  var_7 thread _id_77CF();
  var_7 thread _id_77CE();
  var_7 thread _id_10B81(self);
  var_7.owner scripts\common\utility::_id_F73A(level._id_9BB4, level._id_77D3[var_7._id_77D4].streakname, var_7._id_EEF5);
  return var_7;
}

_id_77CB() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

_id_E6B8(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  scripts\mp\utility\player::_id_D8D4(var_0._id_77D4);

  if(getdvarint("#x36c8f5946a1247e70")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self._id_C707 = self.angles;
  var_0 thread _id_0A44::_id_8E49(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread _id_10B8B(var_0);
  scripts\mp\utility\player::_freezecontrols(1);
  var_1 = scripts\mp\killstreaks\killstreaks::_id_827A(var_0._id_77D4);

  if(var_1 != "success") {
    if(!scripts\common\utility::_id_871C()) {
      scripts\common\utility::_id_158D(1);
    }

    var_0 notify("death");
    return 0;
  }

  scripts\mp\utility\player::_freezecontrols(0);
  var_2 = scripts\mp\utility\killstreak::_id_6A99();
  var_3 = var_0._id_41D8.origin + (scripts\mp\utility\killstreak::_id_6A98() + var_2);
  var_4 = var_0._id_41D8.origin + (scripts\mp\utility\killstreak::_id_6A98() - var_2);
  var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, undefined, 0, 0, 1);

  if(!isDefined(var_5["entity"])) {}

  var_6 = var_5["position"] - scripts\mp\utility\killstreak::_id_6A98() + (0, 0, 250);
  var_7 = spawn("script_origin", var_6);
  self remotecontrolvehicle(var_0);
  var_0 thread _id_77BB(var_7);
  var_0 thread _id_77CD();
  level thread scripts\mp\hud_util::_id_EF8D(level._id_77D3[var_0._id_77D4]._id_EFAC, self);
  var_0.killcament = spawn("script_origin", self getvieworigin());
  return 1;
}

_id_77BB(var_0) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(var_0);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  var_0 delete();
}

_id_10B8B(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, self, "outline_nodepth_cyan", "killstreak");
  _id_C4F9(var_1, var_0);

  foreach(var_3 in level._id_AE7C) {
    if(!scripts\mp\utility\player::isreallyalive(var_3) || var_3.sessionstate != "playing") {
      continue;
    }
    if(scripts\mp\utility\player::isenemy(var_3)) {
      if(!var_3 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "outline_nodepth_orange", "killstreak");
        var_3 _id_C4F9(var_1, var_0);
        continue;
      }

      var_3 thread _id_10B37(var_0);
    }
  }

  var_0 thread _id_10BE4();
  thread _id_10AD5(var_0);
}

_id_10B37(var_0) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0.owner, "outline_nodepth_orange", "killstreak");
  _id_C4F9(var_1, var_0);
}

_id_10BE4() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(var_0.sessionstate == "playing" && self.owner scripts\mp\utility\player::isenemy(var_0)) {
      var_0 thread _id_10B37(self);
    }
  }
}

_id_C4F9(var_0, var_1) {
  thread _id_77D8(var_0, var_1);
  thread _id_B763(var_0, var_1);
}

_id_77D8(var_0, var_1) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["leaving", "death"];
  var_1 scripts\engine\utility::_id_10893(var_2);

  if(isDefined(self)) {
    scripts\mp\utility\outline::outlinedisable(var_0, self);
    self notify("outline_removed");
  }
}

_id_B763(var_0, var_1) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["death"];
  scripts\engine\utility::_id_10893(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("outline_removed");
}

_id_77CE() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner _id_77C6(self);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread scripts\mp\killstreaks\helicopter::_id_9122();
}

_id_77CF() {
  level endon("game_ended");
  self endon("gone");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread scripts\mp\killstreaks\helicopter::_id_9122();

  if(isDefined(self.owner)) {
    self.owner _id_77C6(self);
  }
}

_id_77D2() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_0 = level._id_77D3[self._id_77D4]._id_F224;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread _id_77CA();
}

_id_77D0() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread _id_77CA();
}

_id_77D1() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread _id_77CA();
}

_id_77CA() {
  self endon("death");
  self notify("leaving");

  if(isDefined(self.owner)) {
    self.owner _id_77C6(self);
  }

  var_0 = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_0);
  self waittill("goal");
  var_0 = var_0 + anglesToForward(self.angles) * 15000;
  var_1 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    self setlookatent(var_1);
    var_1 thread _id_106C5(3.0);
  }

  self setvehgoalpos(var_0);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::_id_C4DF();
}

_id_106C5(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

_id_77C6(var_0) {
  if(isDefined(var_0)) {
    self setclientomnvar("ui_heli_pilot", 0);
    var_0 notify("end_remote");

    if(scripts\mp\utility\player::_id_8ACE()) {
      scripts\mp\utility\player::_id_3990();
    }

    if(getdvarint("#x36c8f5946a1247e70")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self _meth_8294(var_0);
    self setplayerangles(self._id_C707);
    thread _id_77C7();
  }
}

_id_77C7() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

_id_77CD() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!var_0) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          var_0 = 1;
        }
      } else if(var_0) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        var_0 = 0;
      }
    }

    wait 0.1;
  }
}

_id_77CC() {
  level._id_1367 = scripts\engine\utility::getStructArray("chopper_boss_path_start", "targetname");
}

_id_77C9(var_0) {
  if(isDefined(var_0._id_0399)) {
    var_1 = var_0 scripts\engine\utility::_id_6562();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getstruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

_id_77C8(var_0) {
  var_1 = undefined;
  var_2 = 999999;

  foreach(var_4 in level._id_1367) {
    var_5 = distance(var_4.origin, var_0);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_10AD5(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("leaving");
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_15CF();
  var_0 waittill("killstreakExit");
  var_0 thread _id_77CA();
}