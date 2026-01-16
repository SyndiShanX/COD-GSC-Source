/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archsniper.gsc
************************************************/

func_97D0() {
  level.var_37D3 = [];
  level._effect["marked_target"] = loadfx("vfx\iw7\_requests\mp\vfx_marked_target");
  level._effect["wall_lock_engaged"] = loadfx("vfx\iw7\_requests\mp\vfx_sonic_sensor_pulse");
}

applyarchetype() {}

removearchetype() {
  self notify("removeArchetype");
}

func_E89D() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  for(;;) {
    self waittill("victim_damaged", var_0, var_1);
    if(var_0 scripts\mp\utility::_hasperk("specialty_coldblooded") || var_0 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      continue;
    }

    thread func_10222(var_0);
    wait(0.05);
  }
}

func_10222(var_0) {
  var_0 endon("disconnect");
  var_1 = scripts\mp\utility::outlineenableforplayer(var_0, "red", self, 0, 0, "level_script");
  var_0 scripts\mp\hud_message::showmiscmessage("spotted");
  thread func_13AA0(var_1, var_0, 2);
  wait(2);
}

func_E83E() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  setdvarifuninitialized("camo_method", 0);
  if(level.ingraceperiod == 0) {
    self waittill("spawned_player");
  } else {
    wait(1);
  }

  self.var_9E3F = 0;
  self.var_37E5 = 0.1;
  self.var_C3E6 = self.model;
  self.var_C408 = self func_816D();
  thread func_37DD();
  if(getdvarint("camo_method", 1)) {
    thread func_37D4();
    return;
  }

  thread func_37D5();
}

func_37D4() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  thread func_37E0();
  thread func_37DB();
  thread func_37DF();
  thread func_37E3();
  thread func_37DE();
  if(scripts\mp\utility::_hasperk("specialty_camo_elite")) {
    self.var_37D2 = "mp_fullbody_synaptic_1";
  } else {
    self.var_37D2 = "mp_fullbody_synaptic_1";
  }

  for(;;) {
    if((self issprinting() || self iswallrunning()) && !self ismeleeing() && !scripts\mp\killstreaks\emp_common::isemped() && !self ismantling() && !self usebuttonpressed() && !self adsbuttonpressed() && !isDefined(self.var_9FF6) && !isDefined(self.var_6F43)) {
      func_37DA();
    } else {
      wait(1.5);
      continue;
    }

    wait(0.1);
    scripts\engine\utility::waittill_any("camo_off", "emp_damage");
    wait(0.05);
    func_37D9();
    wait(self.var_37E5);
    self.var_37E5 = 0.1;
  }
}

func_37D5() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  thread func_37DF();
  thread func_37E3();
  if(scripts\mp\utility::_hasperk("specialty_camo_elite")) {
    self.var_37D2 = "mp_fullbody_synaptic_1";
  } else {
    self.var_37D2 = "mp_fullbody_synaptic_1";
  }

  for(;;) {
    if(!self ismeleeing() && !scripts\mp\killstreaks\emp_common::isemped()) {
      func_37DA();
    } else {
      wait(1.5);
      continue;
    }

    wait(0.1);
    scripts\engine\utility::waittill_any("camo_off", "emp_damage");
    wait(0.05);
    func_37D9();
    wait(self.var_37E5);
    self.var_37E5 = 0.1;
  }
}

func_37E3() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_fired", var_0);
    if(self.var_9E3F) {
      self.var_37E5 = 3.5;
      self notify("camo_off");
    }
  }
}

func_37E4() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    self waittill("weapon_change");
    if(self.var_9E3F && scripts\mp\utility::getweapongroup(self getcurrentweapon()) == "weapon_sniper") {
      self notify("camo_off");
    }
  }
}

func_37E0() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    if((!self issprinting() && !self iswallrunning() && !self isjumping() && !self ismantling()) || isDefined(self.var_9FF6) || isDefined(self.var_6F43)) {
      self notify("camo_off");
      self waittill("camo_on");
    }

    wait(0.05);
  }
}

func_37DB() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("removeArchetype");
  for(;;) {
    if(self adsbuttonpressed()) {
      self notify("camo_off");
      self waittill("camo_on");
    }

    wait(0.05);
  }
}

func_37DF() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("removeArchetype");
  for(;;) {
    if(self ismeleeing()) {
      self notify("camo_off");
      self waittill("camo_on");
    }

    wait(0.05);
  }
}

func_37E2() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("removeArchetype");
  for(;;) {
    if(self iswallrunning()) {
      self notify("camo_off");
      self waittill("camo_on");
    }

    wait(0.05);
  }
}

func_37DA() {
  if(!self.var_9E3F) {
    self.var_9E3F = 1;
    self setModel(self.var_37D2);
    func_20CE();
    self playlocalsound("ghost_wall_camo_on");
    scripts\mp\utility::giveperk("specialty_blindeye");
    scripts\mp\utility::giveperk("specialty_noscopeoutline");
    self notify("camo_on");
  }
}

func_37D9() {
  if(self.var_9E3F) {
    self.var_9E3F = 0;
    self setModel(self.var_C3E6);
    func_E12D();
    self playlocalsound("ghost_wall_camo_off");
    scripts\mp\utility::removeperk("specialty_blindeye");
    scripts\mp\utility::removeperk("specialty_noscopeoutline");
  }
}

func_561B() {
  self endon("death");
  self endon("disconnect");
  self getradiuspathsighttestnodes();
  self waittill("camo_off");
  self enableweapons();
}

func_37DE() {
  self endon("death");
  self endon("disconnect");
  self endon("camo_off");
  for(;;) {
    if(self usebuttonpressed() || self adsbuttonpressed() && !isDefined(self.var_9FF6)) {
      self notify("camo_off");
    }

    scripts\engine\utility::waitframe();
  }
}

func_37DD() {
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self waittill("death");
  if(self.var_9E3F) {
    func_37D9();
    self.var_9FF6 = undefined;
    self notify("camo_off");
  }
}

func_E8AC() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.var_138CE = undefined;
  for(;;) {
    if(self iswallrunning() && self playerads() > 0.3) {
      var_0 = self goal_position(0);
      var_1 = self energy_getmax(0);
      self energy_setenergy(0, var_1);
      self.var_138CE = var_0;
      func_68D7();
      thread func_13BA3();
      self waittill("walllock_ended");
      func_639B();
    }

    wait(0.1);
  }
}

func_13BA3() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");
  wait(0.05);
  while(self playerads() > 0.3 && self goal_position(0) > 0) {
    self energy_setenergy(0, self goal_position(0) - 3);
    wait(0.05);
  }

  self notify("walllock_ended");
}

func_68D7() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.var_9FF6 = 1;
  self allowmovement(0);
  self allowjump(0);
  self setstance("crouch");
  self playlocalsound("ghost_wall_attach");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self setscriptablepartstate("perch", "active", 0);
  self playerlinkto(var_0);
  thread func_49EE(var_0.origin, scripts\mp\utility::getotherteam(self.team));
  thread managetimeout(var_0);
}

managetimeout(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("walllock_ended");
  level endon("game_ended");
  wait(10);
  var_1 = var_0.origin - (0, 0, 100);
  var_2 = scripts\common\trace::ray_trace(var_0.origin, var_1);
  if(length(var_0.origin - var_2["position"]) < length(var_0.origin - var_1)) {
    var_1 = var_2["position"];
  }

  var_0 moveto(var_1, 4, 3.5);
  wait(4);
  self notify("walllock_ended");
}

func_639B() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_0 = self.angles;
  self.var_9FF6 = undefined;
  self allowmovement(1);
  self allowjump(1);
  self setstance("stand");
  self playlocalsound("ghost_wall_detach");
  if(isDefined(self.var_138CE)) {
    self energy_setenergy(0, self.var_138CE);
  }

  self.var_138CE = undefined;
  self unlink();
  scripts\engine\utility::waitframe();
  self.angles = var_0;
  self setscriptablepartstate("perch", "neutral", 0);
}

func_20CE() {
  self setclientomnvar("ui_camouflageOverlay", 1);
}

func_E12D() {
  self setclientomnvar("ui_camouflageOverlay", 0);
}

func_49EE(var_0, var_1) {
  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_2 = scripts\mp\objidpoolmanager::requestminimapid(10);
  if(var_2 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", self.origin, "cb_compassping_sniper_enemy", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_2, var_1);
  scripts\engine\utility::waittill_any("death", "disconnect", "stop_minimap_decoys", "walllock_ended");
  scripts\mp\objidpoolmanager::returnminimapid(var_2);
}

func_13A2A() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  wait(0.05);
  if(!isDefined(self.var_AD33)) {
    self.var_AD33 = scripts\engine\utility::spawn_tag_origin();
    self.var_5FF1 = spawn("script_model", self.origin);
    self.var_5FF1 setModel("tag_origin");
  } else {
    self.var_5FF1.origin = self gettagorigin("tag_shield_back");
    self.var_5FF1.angles = self gettagangles("tag_shield_back");
    self.var_5FF1 linkto(self, "tag_shield_back");
    self.var_AD33.origin = self.origin;
  }

  self notifyonplayercommand("floatPressed", "+stance");
  for(;;) {
    self waittill("doubleJumpBegin");
    if(self isonground()) {
      continue;
    }

    if(self ismantling()) {
      continue;
    }

    func_10B46();
  }
}

func_10B46() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("adjustedStance", "doubleJumpEnd", "unlinked");
    if(var_0 == "doubleJumpEnd" || var_0 == "unlinked") {
      break;
    }

    if(isDefined(self.var_1D42) && self.var_1D42) {
      break;
    }

    if(self goal_position(0) > 10) {
      continue;
    }

    func_1608();
  }
}

func_1608() {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  self.var_6F43 = 1;
  self.var_1D42 = 1;
  self.var_AD33.origin = self.origin;
  self playerlinkto(self.var_AD33);
  self setstance("stand");
  thread playflyoveraudioline(self.var_5FF1);
  thread func_13A43();
  thread func_13A7C();
  thread func_13A49();
  thread func_BCB9(self.var_AD33);
  self.var_5039 = self energy_getrestorerate(0);
  self energy_setrestorerate(0, 0);
  wait(5);
  func_10358();
}

func_13A43() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    if(self isonground()) {
      self.var_1D42 = 0;
      return;
    } else {
      wait(0.05);
    }
  }
}

playflyoveraudioline(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  if(!var_0 islinked(self)) {
    var_0.origin = self gettagorigin("tag_shield_back");
    var_0.angles = self gettagangles("tag_shield_back");
    var_0 linkto(self, "tag_shield_back");
    wait(0.05);
  }

  var_0 show();
  wait(0.1);
  scripts\mp\utility::func_D486(self, var_0, "tag_origin", self.team, scripts\engine\utility::getfx("heavyThrustFr"), scripts\engine\utility::getfx("heavyThrustEn"), undefined, undefined, [self]);
}

func_10358() {
  self.var_6F43 = undefined;
  self.var_5FF1 hide();
  stopFXOnTag(level._effect["heavyThrustFr"], self.var_5FF1, "tag_origin");
  self energy_setrestorerate(0, self.var_5039);
  self unlink();
  self notify("unlinked");
}

func_13A7C() {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  self waittill("floatPressed");
  func_10358();
}

func_13A49() {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  self waittill("adjustedStance");
  func_10358();
}

func_BCB9(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    var_1 = self getnormalizedmovement();
    if(var_1[0] >= 0.15 || var_1[1] >= 0.15 || var_1[0] <= -0.15 || var_1[1] <= -0.15) {
      thread func_B31F(var_0, var_1);
    } else {
      thread func_DCBD(var_0, var_1);
    }

    wait(0.05);
    func_8D14(var_0);
  }
}

func_B31F(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  var_0.var_BCD9 = 80;
  var_2 = anglesToForward(self.angles) * var_0.var_BCD9 * var_1[0];
  var_3 = anglestoright(self.angles) * var_0.var_BCD9 * var_1[1];
  var_4 = var_2 + var_3;
  var_5 = self.origin + var_4;
  var_6 = self.origin[2] - var_0.var_BCD9 / 4;
  var_5 = var_5 * (1, 1, 0);
  var_5 = var_5 + (0, 0, var_6);
  var_5 = func_EA27(var_5);
  var_0 moveto(var_5, 0.5);
}

func_DCBD(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  var_2 = self.origin[2] - 12.5;
  var_3 = self.origin;
  var_3 = var_3 * (1, 1, 0);
  var_3 = var_3 + (0, 0, var_2);
  var_3 = func_EA27(var_3);
  var_0 moveto(var_3, 0.5);
}

func_EA27(var_0) {
  var_1 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_2 = scripts\common\trace::capsule_trace(self.origin, var_0, 16, 32, (0, 0, 0), self, var_1, 0);
  var_3 = var_2["fraction"];
  var_4 = var_2["position"];
  var_5 = undefined;
  var_6 = var_2["normal"];
  var_7 = 0;
  if(var_3 != 1) {
    if(var_6[0] > 0.8 || var_6[0] < -0.8) {
      var_7 = 1;
    }

    if(var_6[1] > 0.8 || var_6[1] < -0.8) {
      var_7 = 1;
    }

    if(var_3 < 0.25 && !var_7) {
      return self.origin;
    } else if(var_3 < 0.25 && var_7) {
      return (self.origin[0], self.origin[1], var_0[2]);
    }

    var_8 = var_0 - self.origin;
    var_9 = vectortoangles(var_8);
    var_10 = anglesToForward(var_9);
    var_5 = distance(self.origin, var_0);
    var_5 = var_5 - 32;
    var_11 = self.origin + var_10 * var_5;
  } else {
    var_11 = var_1;
  }

  if(isDefined(var_5) && var_5 < 16) {
    return self.origin;
  }

  return var_11;
}

func_8D14(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  var_1 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_2 = scripts\common\trace::player_trace(var_0.origin, var_0.origin - (0, 0, 100), self.angles, self, var_1);
  var_3 = var_2["position"];
  var_4 = var_2["normal"];
  var_5 = 0;
  if(var_4[0] == 1 || var_4[0] == -1) {
    var_5 = 1;
  }

  if(var_4[1] == 1 || var_4[1] == -1) {
    var_5 = 1;
  }

  if(!var_2["fraction"] && var_5) {
    var_6 = scripts\common\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 100), self, var_1);
    var_5 = 0;
    var_4 = var_6["normal"];
    if(var_4[0] > 0.8 || var_4[0] < -0.8) {
      var_5 = 1;
    }

    if(var_4[1] > 0.8 || var_4[1] < -0.8) {
      var_5 = 1;
    }

    if(var_5) {
      return;
    }
  }

  if(distancesquared(var_0.origin, var_3) < 256) {
    func_10358();
  }
}

marktarget_run(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\engine\utility::isbulletdamage(var_1) && isplayer(var_0) && var_0.team != self.team && !var_0 scripts\mp\utility::_hasperk("specialty_coldblooded") || var_0 scripts\mp\utility::_hasperk("specialty_empimmune") && !isDefined(var_0.ismarkedtarget)) {
    thread marktarget_execute(var_0);
  }
}

marktarget_execute(var_0) {
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2 linkto(var_1, "tag_origin", (0, 0, 45), (0, 0, 0));
  var_1 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.ismarkedtarget = 1;
  var_0.healthregendisabled = 1;
  wait(0.1);
  if(level.gametype != "dm") {
    var_3 = playfxontagforteam(scripts\engine\utility::getfx("marked_target"), var_2, "tag_origin", self.team);
  } else {
    var_3 = playfxontagforclients(scripts\engine\utility::getfx("marked_target"), var_3, "tag_origin", self);
  }

  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  stopFXOnTag(scripts\engine\utility::getfx("marked_target"), var_0, "tag_origin");
  var_1 delete();
  wait(0.1);
  var_0.ismarkedtarget = undefined;
  var_0.healthregendisabled = undefined;
}

func_13AA0(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_2, "leave");
  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
  }
}

runequipmentping(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = self.owner;
  var_2 = level.uavsettings["uav_3dping"];
  if(var_1 scripts\mp\utility::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      foreach(var_4 in level.players) {
        if(!var_1 scripts\mp\utility::isenemy(var_4)) {
          continue;
        }

        if(var_4 scripts\mp\utility::_hasperk("specialty_engineer") || var_4 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
          continue;
        }

        if(isDefined(var_4.var_C78B)) {
          continue;
        }

        var_5 = scripts\engine\utility::array_add(level.players, self);
        if(isDefined(var_0)) {
          var_5 = scripts\engine\utility::array_add(var_5, var_0);
        }

        if(distance2d(var_4.origin, self.origin) < 300 && scripts\common\trace::ray_trace_passed(self.origin, var_4 gettagorigin("j_head"), var_5)) {
          playfxontagforclients(var_2.var_7636, self, "tag_origin", var_1);
          playsoundatpos(self.origin + (0, 0, 5), var_2.var_10469);
          var_4 scripts\mp\hud_message::showmiscmessage("spotted");
          var_1 scripts\mp\damagefeedback::hudicontype("eqp_ping");
          var_1 thread markdangerzoneonminimap(var_4, self);
          wait(3);
        }
      }

      scripts\engine\utility::waitframe();
    }
  }
}

func_1B45() {
  self playsoundtoplayer("mp_cranked_countdown", self);
}

markdangerzoneonminimap(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_2 = scripts\mp\objidpoolmanager::requestminimapid(10);
  if(var_2 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", var_1.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_2, self.team);
  var_0 thread watchfordeath(var_2);
  wait(3);
  scripts\mp\objidpoolmanager::returnminimapid(var_2);
}

watchfordeath(var_0) {
  scripts\engine\utility::waittill_any("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(var_0);
}

func_C7A6(var_0) {
  var_0 endon("disconnect");
  var_1 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", self, 0, 0, "level_script");
  var_0 scripts\mp\hud_message::showmiscmessage("spotted");
  var_0.var_C78B = 1;
  func_13AA0(var_1, var_0, 0.35);
  wait(3);
  var_0.var_C78B = undefined;
}

func_E7FE() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(self getstance() == "prone" && scripts\mp\utility::_hasperk("specialty_improved_prone")) {
      wait(0.2);
      var_0 = self.movespeedscaler;
      self.movespeedscaler = 3;
      scripts\mp\weapons::updatemovespeedscale();
      func_BA22();
      self.movespeedscaler = var_0;
      scripts\mp\weapons::updatemovespeedscale();
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA22() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("changed_kit");
  while(self getstance() == "prone") {
    scripts\engine\utility::waitframe();
  }
}