/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
    self waittill("victim_damaged", var_00, var_01);
    if(var_00 scripts\mp\utility::_hasperk("specialty_coldblooded") || var_00 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      continue;
    }

    thread func_10222(var_00);
    wait(0.05);
  }
}

func_10222(param_00) {
  param_00 endon("disconnect");
  var_01 = scripts\mp\utility::outlineenableforplayer(param_00, "red", self, 0, 0, "level_script");
  param_00 scripts\mp\hud_message::showmiscmessage("spotted");
  thread func_13AA0(var_01, param_00, 2);
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
  self.var_C408 = self _meth_816D();
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
    if((self issprinting() || self iswallrunning()) && !self ismeleeing() && !scripts\mp\killstreaks\_emp_common::isemped() && !self ismantling() && !self usebuttonpressed() && !self adsbuttonpressed() && !isDefined(self.var_9FF6) && !isDefined(self.var_6F43)) {
      func_37DA();
    } else {
      wait(1.5);
      continue;
    }

    wait(0.1);
    scripts\engine\utility::waittill_any_3("camo_off", "emp_damage");
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
    if(!self ismeleeing() && !scripts\mp\killstreaks\_emp_common::isemped()) {
      func_37DA();
    } else {
      wait(1.5);
      continue;
    }

    wait(0.1);
    scripts\engine\utility::waittill_any_3("camo_off", "emp_damage");
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
    self waittill("weapon_fired", var_00);
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
    if(self iswallrunning() && self getweaponrankinfominxp() > 0.3) {
      var_00 = self goal_position(0);
      var_01 = self energy_getmax(0);
      self goal_radius(0, var_01);
      self.var_138CE = var_00;
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
  while(self getweaponrankinfominxp() > 0.3 && self goal_position(0) > 0) {
    self goal_radius(0, self goal_position(0) - 3);
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
  var_00 = scripts\engine\utility::spawn_tag_origin();
  self setscriptablepartstate("perch", "active", 0);
  self playerlinkto(var_00);
  thread func_49EE(var_00.origin, scripts\mp\utility::getotherteam(self.team));
  thread managetimeout(var_00);
}

managetimeout(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("walllock_ended");
  level endon("game_ended");
  wait(10);
  var_01 = param_00.origin - (0, 0, 100);
  var_02 = scripts\common\trace::ray_trace(param_00.origin, var_01);
  if(length(param_00.origin - var_02["position"]) < length(param_00.origin - var_01)) {
    var_01 = var_02["position"];
  }

  param_00 moveto(var_01, 4, 3.5);
  wait(4);
  self notify("walllock_ended");
}

func_639B() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_00 = self.angles;
  self.var_9FF6 = undefined;
  self allowmovement(1);
  self allowjump(1);
  self setstance("stand");
  self playlocalsound("ghost_wall_detach");
  if(isDefined(self.var_138CE)) {
    self goal_radius(0, self.var_138CE);
  }

  self.var_138CE = undefined;
  self unlink();
  scripts\engine\utility::waitframe();
  self.angles = var_00;
  self setscriptablepartstate("perch", "neutral", 0);
}

func_20CE() {
  self setclientomnvar("ui_camouflageOverlay", 1);
}

func_E12D() {
  self setclientomnvar("ui_camouflageOverlay", 0);
}

func_49EE(param_00, param_01) {
  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
  if(var_02 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", self.origin, "cb_compassping_sniper_enemy", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_02, param_01);
  scripts\engine\utility::waittill_any_3("death", "disconnect", "stop_minimap_decoys", "walllock_ended");
  scripts\mp\objidpoolmanager::returnminimapid(var_02);
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
    var_00 = scripts\engine\utility::waittill_any_return("adjustedStance", "doubleJumpEnd", "unlinked");
    if(var_00 == "doubleJumpEnd" || var_00 == "unlinked") {
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
  self goalflag(0, 0);
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

playflyoveraudioline(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  if(!param_00 islinked(self)) {
    param_00.origin = self gettagorigin("tag_shield_back");
    param_00.angles = self gettagangles("tag_shield_back");
    param_00 linkto(self, "tag_shield_back");
    wait(0.05);
  }

  param_00 show();
  wait(0.1);
  scripts\mp\utility::func_D486(self, param_00, "tag_origin", self.team, scripts\engine\utility::getfx("heavyThrustFr"), scripts\engine\utility::getfx("heavyThrustEn"), undefined, undefined, [self]);
}

func_10358() {
  self.var_6F43 = undefined;
  self.var_5FF1 hide();
  stopFXOnTag(level._effect["heavyThrustFr"], self.var_5FF1, "tag_origin");
  self goalflag(0, self.var_5039);
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

func_BCB9(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    var_01 = self getnormalizedmovement();
    if(var_01[0] >= 0.15 || var_01[1] >= 0.15 || var_01[0] <= -0.15 || var_01[1] <= -0.15) {
      thread func_B31F(param_00, var_01);
    } else {
      thread func_DCBD(param_00, var_01);
    }

    wait(0.05);
    func_8D14(param_00);
  }
}

func_B31F(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  param_00.var_BCD9 = 80;
  var_02 = anglesToForward(self.angles) * param_00.var_BCD9 * param_01[0];
  var_03 = anglestoright(self.angles) * param_00.var_BCD9 * param_01[1];
  var_04 = var_02 + var_03;
  var_05 = self.origin + var_04;
  var_06 = self.origin[2] - param_00.var_BCD9 / 4;
  var_05 = var_05 * (1, 1, 0);
  var_05 = var_05 + (0, 0, var_06);
  var_05 = func_EA27(var_05);
  param_00 moveto(var_05, 0.5);
}

func_DCBD(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  var_02 = self.origin[2] - 12.5;
  var_03 = self.origin;
  var_03 = var_03 * (1, 1, 0);
  var_03 = var_03 + (0, 0, var_02);
  var_03 = func_EA27(var_03);
  param_00 moveto(var_03, 0.5);
}

func_EA27(param_00) {
  var_01 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_02 = scripts\common\trace::capsule_trace(self.origin, param_00, 16, 32, (0, 0, 0), self, var_01, 0);
  var_03 = var_02["fraction"];
  var_04 = var_02["position"];
  var_05 = undefined;
  var_06 = var_02["normal"];
  var_07 = 0;
  if(var_03 != 1) {
    if(var_06[0] > 0.8 || var_06[0] < -0.8) {
      var_07 = 1;
    }

    if(var_06[1] > 0.8 || var_06[1] < -0.8) {
      var_07 = 1;
    }

    if(var_03 < 0.25 && !var_07) {
      return self.origin;
    } else if(var_03 < 0.25 && var_07) {
      return (self.origin[0], self.origin[1], param_00[2]);
    }

    var_08 = param_00 - self.origin;
    var_09 = vectortoangles(var_08);
    var_0A = anglesToForward(var_09);
    var_05 = distance(self.origin, param_00);
    var_05 = var_05 - 32;
    var_0B = self.origin + var_0A * var_05;
  } else {
    var_0B = var_01;
  }

  if(isDefined(var_05) && var_05 < 16) {
    return self.origin;
  }

  return var_0B;
}

func_8D14(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("unlinked");
  self endon("removeArchetype");
  level endon("game_ended");
  var_01 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_02 = scripts\common\trace::player_trace(param_00.origin, param_00.origin - (0, 0, 100), self.angles, self, var_01);
  var_03 = var_02["position"];
  var_04 = var_02["normal"];
  var_05 = 0;
  if(var_04[0] == 1 || var_04[0] == -1) {
    var_05 = 1;
  }

  if(var_04[1] == 1 || var_04[1] == -1) {
    var_05 = 1;
  }

  if(!var_02["fraction"] && var_05) {
    var_06 = scripts\common\trace::ray_trace(param_00.origin, param_00.origin - (0, 0, 100), self, var_01);
    var_05 = 0;
    var_04 = var_06["normal"];
    if(var_04[0] > 0.8 || var_04[0] < -0.8) {
      var_05 = 1;
    }

    if(var_04[1] > 0.8 || var_04[1] < -0.8) {
      var_05 = 1;
    }

    if(var_05) {
      return;
    }
  }

  if(distancesquared(param_00.origin, var_03) < 256) {
    func_10358();
  }
}

marktarget_run(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\engine\utility::isbulletdamage(param_01) && isplayer(param_00) && param_00.team != self.team && !param_00 scripts\mp\utility::_hasperk("specialty_coldblooded") || param_00 scripts\mp\utility::_hasperk("specialty_empimmune") && !isDefined(param_00.ismarkedtarget)) {
    thread marktarget_execute(param_00);
  }
}

marktarget_execute(param_00) {
  var_01 = param_00 scripts\engine\utility::spawn_tag_origin();
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel("tag_origin");
  var_02 linkto(var_01, "tag_origin", (0, 0, 45), (0, 0, 0));
  var_01 linkto(param_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  param_00.ismarkedtarget = 1;
  param_00.healthregendisabled = 1;
  wait(0.1);
  if(level.gametype != "dm") {
    var_03 = playfxontagforteam(scripts\engine\utility::getfx("marked_target"), var_02, "tag_origin", self.team);
  } else {
    var_03 = playfxontagforclients(scripts\engine\utility::getfx("marked_target"), var_03, "tag_origin", self);
  }

  param_00 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  stopFXOnTag(scripts\engine\utility::getfx("marked_target"), param_00, "tag_origin");
  var_01 delete();
  wait(0.1);
  param_00.ismarkedtarget = undefined;
  param_00.healthregendisabled = undefined;
}

func_13AA0(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_02, "leave");
  if(isDefined(param_01)) {
    scripts\mp\utility::outlinedisable(param_00, param_01);
  }
}

runequipmentping(param_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = self.triggerportableradarping;
  var_02 = level.uavsettings["uav_3dping"];
  if(var_01 scripts\mp\utility::_hasperk("specialty_equipment_ping")) {
    for(;;) {
      foreach(var_04 in level.players) {
        if(!var_01 scripts\mp\utility::isenemy(var_04)) {
          continue;
        }

        if(var_04 scripts\mp\utility::_hasperk("specialty_engineer") || var_04 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
          continue;
        }

        if(isDefined(var_04.var_C78B)) {
          continue;
        }

        var_05 = scripts\engine\utility::array_add(level.players, self);
        if(isDefined(param_00)) {
          var_05 = scripts\engine\utility::array_add(var_05, param_00);
        }

        if(distance2d(var_04.origin, self.origin) < 300 && scripts\common\trace::ray_trace_passed(self.origin, var_04 gettagorigin("j_head"), var_05)) {
          playfxontagforclients(var_02.var_7636, self, "tag_origin", var_01);
          playsoundatpos(self.origin + (0, 0, 5), var_02.var_10469);
          var_04 scripts\mp\hud_message::showmiscmessage("spotted");
          var_01 scripts\mp\damagefeedback::hudicontype("eqp_ping");
          var_01 thread markdangerzoneonminimap(var_04, self);
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

markdangerzoneonminimap(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
  if(var_02 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", param_01.origin, "cb_compassping_eqp_ping", "icon_large");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
  param_00 thread watchfordeath(var_02);
  wait(3);
  scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

watchfordeath(param_00) {
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(param_00);
}

func_C7A6(param_00) {
  param_00 endon("disconnect");
  var_01 = scripts\mp\utility::outlineenableforplayer(param_00, "orange", self, 0, 0, "level_script");
  param_00 scripts\mp\hud_message::showmiscmessage("spotted");
  param_00.var_C78B = 1;
  func_13AA0(var_01, param_00, 0.35);
  wait(3);
  param_00.var_C78B = undefined;
}

func_E7FE() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(self getstance() == "prone" && scripts\mp\utility::_hasperk("specialty_improved_prone")) {
      wait(0.2);
      var_00 = self.movespeedscaler;
      self.movespeedscaler = 3;
      scripts\mp\weapons::updatemovespeedscale();
      func_BA22();
      self.movespeedscaler = var_00;
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