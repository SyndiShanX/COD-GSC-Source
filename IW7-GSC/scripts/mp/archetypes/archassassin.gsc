/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archassassin.gsc
**************************************************/

applyarchetype() {}

func_97D0() {
  level._effect["atomize_body"] = loadfx("vfx\iw7\_requests\mp\vfx_atomize_body.vfx");
}

removearchetype() {
  self notify("removeArchetype");
  self setclientomnvar("ui_dodge_charges", 0);
  if(isDefined(self.var_1166A)) {
    self.var_1166A delete();
  }
}

func_CAAF() {
  self endon("death");
  self endon("removeArchetype");
  for(;;) {
    self setclientomnvar("ui_dodge_charges", 4);
    self waittill("sprint_slide_begin");
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
      continue;
    }

    wait(0.1);
    self setclientomnvar("ui_dodge_charges", 0);
    scripts\mp\equipment\phase_shift::func_6626(0);
    func_CAAE();
    wait(4);
    self setclientomnvar("ui_dodge_charges", 4);
  }
}

func_CAAE() {
  self endon("death");
  self endon("removeArchetype");
  self endon("phase_shift_power_activated");
  scripts\engine\utility::waittill_notify_or_timeout("sprint_slide_end", 1);
  scripts\mp\equipment\phase_shift::exitphaseshift(0);
}

func_1166B() {
  self endon("death");
  self endon("removeArchetype");
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("ks_marker_mp");
  var_0 rotatepitch(-90, 0.05);
  self.var_1166A = var_0;
  for(;;) {
    self setclientomnvar("ui_dodge_charges", 4);
    self waittill("sprint_slide_begin");
    var_1 = scripts\engine\utility::waittill_any_timeout(0.1, "sprint_slide_end");
    if(var_1 != "timeout") {
      continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
      continue;
    }

    var_2 = func_81C1(320);
    var_3 = getdvarint("teleport_minDrawDistanceForFX", 16);
    if(distance2dsquared(var_2, self.origin) <= var_3 * var_3) {
      continue;
    }

    self setclientomnvar("ui_dodge_charges", 0);
    var_4 = var_2 - self.origin;
    wait(0.1);
    var_5 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
    var_6 = scripts\common\trace::player_trace(var_2, var_2 - (0, 0, 100), self.angles, self, var_5);
    var_7 = var_6["position"] + (0, 0, 6);
    var_8 = scripts\common\trace::player_get_closest_point(var_7, self.angles, 0, self, var_5, 0);
    var_9 = var_8["position"];
    var_9 = var_9 + (0, 0, 12);
    thread func_10148(var_9);
    wait(0.2);
    wait(4);
    self setclientomnvar("ui_dodge_charges", 4);
  }
}

func_10148(var_0) {
  self.var_1166A.origin = var_0;
  self.var_1166A show();
  wait(0.45);
  self.var_1166A hide();
}

func_81C1(var_0) {
  var_1 = self.origin + (0, 0, 0);
  var_2 = anglesToForward(self.angles);
  var_3 = var_1 + var_2 * var_0;
  var_4 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_5 = scripts\common\trace::player_trace(var_1, var_3, self.angles, self, var_4, 0, 35);
  var_6 = var_5["fraction"];
  var_7 = var_5["position"];
  if(var_6 != 1) {
    var_8 = var_0 * var_6;
    var_8 = var_8 - 32;
    var_7 = var_1 + var_2 * var_8;
  }

  var_9 = getclosestpointonnavmesh3d(var_7);
  if(isDefined(var_9)) {
    return var_9;
  }

  return var_7;
}

func_CAA7() {
  self endon("death");
  self endon("removeArchetype");
  for(;;) {
    self waittill("doubleJumpBegin");
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
      continue;
    }

    scripts\mp\equipment\phase_shift::func_6626(0);
    func_CAA6();
  }
}

func_CAA6() {
  self endon("death");
  self endon("removeArchetype");
  self endon("phase_shift_power_activated");
  var_0 = 0;
  for(;;) {
    if(var_0 >= 0.5) {
      scripts\mp\equipment\phase_shift::exitphaseshift(0);
      return;
    }

    wait(0.05);
    var_0 = var_0 + 0.05;
  }
}

func_E88E() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  for(;;) {
    self waittill("got_a_kill", var_0, var_1, var_2);
    if(var_2 != "MOD_MELEE") {
      continue;
    }

    self notify("phase_slash_entered");
    wait(0.5);
    wait(0.1);
  }
}

func_20D9(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  playFX(scripts\engine\utility::getfx("phase_slash_spool"), var_1 + (0, 0, 36));
  playsoundatpos(var_1, "blackhole_grenade_explode_default");
  scripts\mp\utility::_launchgrenade("phaseSlash_grenade_mp", var_1 + (0, 0, 36), (0, 0, 0), 1.5);
  wait(1.5);
  playFX(scripts\engine\utility::getfx("phase_blast"), var_1);
  playsoundatpos(var_1, "kinetic_pulse_npc");
}

func_CAAD() {
  self endon("death");
  self endon("removeArchetype");
  self endon("phase_shift_power_activated");
  wait(2.5);
  scripts\mp\equipment\phase_shift::exitphaseshift(0);
}

func_1091C() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  var_0 = level.players.size - 1;
  for(;;) {
    if(level.players.size != var_0) {
      foreach(var_2 in level.players) {
        if(var_2 == self) {
          continue;
        }

        if(var_2.team == self.team) {
          continue;
        }

        if(var_2 scripts\mp\utility::_hasperk("specialty_coldblooded")) {
          continue;
        }

        var_2 thread func_BA1A(self);
      }

      var_0 = level.players.size;
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA1A(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("removearchetype");
  self endon("end_spawnview");
  for(;;) {
    self waittill("spawned_player");
    wait(0.1);
    func_C7A6(var_0);
  }
}

func_C7A6(var_0) {
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "red", var_0, 0, 1, "level_script");
  if(!isai(var_0)) {
    var_0 scripts\mp\utility::_hudoutlineviewmodelenable(5);
  }

  var_0 func_13AA0(var_1, self, 6);
}

func_13AA0(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_2, "leave", "end_spawnview");
  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
    if(!isai(var_1)) {
      var_1 scripts\mp\utility::_hudoutlineviewmodeldisable();
    }
  }
}