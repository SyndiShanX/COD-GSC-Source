/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_exfil.gsc
***********************************************************************/

_id_3C0B(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_1);
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1 moveTo(var_2.origin, 1, 0.3, 0);
  var_1 rotateTo(var_2.angles, 1, 0.3, 0);
  var_1 waittill("movedone");

  while(isDefined(var_2.target)) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_1 moveTo(var_2.origin, 1);
    var_1 rotateTo(var_2.angles, 1);
    var_1 waittill("movedone");
  }

  self unlink();
  var_1 delete();
}

_id_CFBE(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.angles = level.player getplayerangles();
  self playerlinktodelta(var_1, "tag_origin", 1, 0, 0, 0, 0, 1);
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = var_2;

  if(isDefined(var_2.script_delay))
    var_4 = var_2.script_delay;
  else
    var_4 = 1;

  var_1 moveTo(var_2.origin, var_4, var_4 * 0.3, 0);
  var_1 rotateTo(var_2.angles, var_4, var_4 * 0.3, 0);
  var_1 waittill("movedone");

  while(isDefined(var_3.target)) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");

    if(isDefined(var_2.script_delay))
      var_4 = var_2.script_delay;
    else
      var_4 = 1;

    var_1 moveTo(var_2.origin, 1, 0, 0);
    var_1 rotateTo(var_2.angles, 1, 0, 0);
    var_1 waittill("movedone");
  }

  if(isDefined(var_3.script_delay))
    var_4 = var_3.script_delay;
  else
    var_4 = 1;

  var_1 moveTo(var_3.origin, var_4, 0, var_4 * 0.3);
  var_1 rotateTo(var_3.angles, var_4, 0, var_4 * 0.3);
  var_1 waittill("movedone");
  self unlink();
  level.player setworldupreferenceangles(var_1.angles);
  var_1 delete();
}

_id_10D68() {
  if(isDefined(level._id_EA2C)) {
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("assist_salter"));
    level._id_EA2C scripts\sp\utility::_id_1101B();
    level._id_EA2C delete();
  }

  var_0 = getspawner("salter_0G", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("exfil_salter_start", "targetname");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1, 1);
  level._id_EA2C hide();
  level._id_EA2C _id_0C6D::_id_1104E();
  level._id_EA2C scripts\sp\utility::_id_413D();
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  var_3 = getnode("exfil_salter_idle", "targetname");
  level._id_EA2C _meth_82EE(var_3);
  level._id_EA2C waittill("do_the_hop");
  level._id_EA2C show();
  level._id_EA2C _id_0C6D::_id_10D48();
  wait 2.5;
  level._id_EA2C _meth_82EE(getnode(var_3.target, "targetname"));
}

_id_5254() {
  level._id_E99E["exfil_door_interior"] waittill("door_sequence_complete");
  wait 1;
  level._id_E99E["exfil_door_interior"] _id_0F05::_id_5253();
}

_id_E7F1() {
  var_0 = scripts\sp\vehicle::_id_1080D("exfil_enemy_dropship");
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0 scripts\sp\vehicle::_id_8441();
  var_1 = getspawnerarray(var_0.target);

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_1747(::_id_5DCD);

  var_0 waittill("reached_dynamic_path_end");
  var_0 notify("delete");
  var_0 delete();
}

_id_5DCD() {
  if(!isDefined(level._id_5DCB))
    level._id_5DCB = [];

  level._id_5DCB[level._id_5DCB.size] = self;

  if(!isDefined(level._id_5DCC))
    level._id_5DCC = scripts\engine\utility::spawn_tag_origin();

  var_0 = self.pos;
  self waittill("death");
  level._id_5DCC.position = var_0;
}

_id_68FE() {
  var_0["destroyer"] = scripts\sp\utility::_id_8200("exfil_destroyer", "targetname");
  level._id_68FE = [];
  var_0["destroyer"]._id_EEF9 = "cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_7A97();

    foreach(var_5 in var_3) {
      if(isDefined(var_5.script_noteworthy)) {
        var_2 dontinterpolate();
        var_2.origin = var_5.origin;

        if(isDefined(var_5.angles))
          var_2.angles = var_5.angles;

        while(isDefined(var_2._id_1323B))
          scripts\engine\utility::waitframe();

        var_6 = var_2 scripts\sp\utility::_id_10808();
        level._id_68FE[level._id_68FE.size] = var_6;
        var_6._id_B904 = "veh_mil_air_ca_destroyer";
        var_6 thread _id_0B53::_id_B909();
        var_6 _id_0BB8::_id_39CD("idle");
        var_6 _id_0BB8::_id_39CE("low");
        var_6 notify("kill_rumble_forever");
        var_6 solid();
        var_6 castspotshadows(0);
        var_6 _id_0BB8::_id_397F(1, 1);
        var_6 _id_9738(var_5);
      }
    }
  }

  _id_0BDC::_id_A321(1);

  if(!isDefined(level._id_A359))
    level._id_A359 = scripts\sp\utility::_id_8200("jackal_swarm_spawner", "targetname");

  level._id_A359 thread _id_1DC4();
}

_id_967D(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = getcsplineid(var_1);
  var_2.origin = getcsplinepointposition(var_3, 0);
  var_4 = var_2 scripts\sp\utility::_id_10808();
  level._id_B7E1 = var_4;
  var_4 _meth_8479(var_3);
  var_4 _meth_847B();
  var_4._id_10A43 = var_3;
  var_4 _id_0C24::_id_10A49();
}

_id_1DC4() {
  var_0 = getcsplineidarray("dogfight_spline");
  level._id_1DAA = [];
  var_1 = 6;

  foreach(var_5, var_3 in var_0) {
    if(var_5 > var_1) {
      break;
    }

    while(isDefined(self._id_1323B))
      scripts\engine\utility::waitframe();

    self.origin = getcsplinepointposition(var_3, 0);
    var_4 = level._id_A359 scripts\sp\utility::_id_10808();
    var_4 thread _id_1DC5(var_3);
    level._id_1DAA[level._id_1DAA.size] = var_4;
  }

  for(;;) {
    self waittill("respawn");

    while(isDefined(self._id_1323B))
      scripts\engine\utility::waitframe();

    self.origin = getcsplinepointposition(var_0[randomint(var_0.size - 1)], 0);
    var_4 = level._id_A359 scripts\sp\utility::_id_10808();
    var_4 thread _id_1DC5();
  }
}

_id_1DC5(var_0) {
  self endon("aceified");
  self endon("death");
  thread _id_0BDC::_id_A1EF(var_0, undefined, 32);
  level._id_1DAA[level._id_1DAA.size] = self;
  _id_0BDC::_id_19B3("patrol", "dogfight_spline");
  _id_0BDC::_id_19B3("combat", "dogfight_spline");
  _id_0BDC::_id_19B3("escape", "dogfight_spline");
  _id_0BDC::_id_19B1(1);
  _id_0BDC::_id_1990(1);
  self waittill("death");
  level._id_A359 notify("respawn");
  level._id_1DAA = scripts\engine\utility::array_remove(level._id_1DAA, self);
}

_id_E7D5() {
  objective_add(scripts\sp\utility::_id_C264("aces"), "current", &"SA_ASSASSINATION_KILL_SKELTER_ACES");
  _id_0B76::_id_16FE(0, "jackal_objective_aces", 3);
  _id_0B76::_id_F432(0, 0);
  _id_0B76::_id_100EC(0);
  level waittill("ace_death");
  _id_0B76::_id_F432(0, 1);
  level waittill("ace_death");
  _id_0B76::_id_F432(0, 2);
  level waittill("ace_death");
  _id_0B76::_id_F432(0, 3);
  _id_0B76::_id_4474(0);
  _id_0B76::_id_16FE(1, "jackal_objective_return_to_ret");
  _id_0B76::_id_100EC(1);
  thread _id_4475();
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("aces"));
}

_id_4475() {
  objective_add(scripts\sp\utility::_id_C264("exfil_ret"), "current", &"SA_ASSASSINATION_BOARD_THE_RETRIBUTION");
  level waittill("player_jackal_drone_dock");
  setmusicstate("");
  _id_0B76::_id_4474(1);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("exfil_ret"));
}

_id_9834() {
  var_0 = scripts\sp\utility::_id_8200("exfil_ace", "targetname");
  var_1 = scripts\sp\utility::_id_8200("exfil_semiace", "targetname");
  var_2 = getcsplineid("ace_intro_spline_1");
  var_3 = getcsplineid("ace_intro_spline_2");
  level._id_282E = scripts\engine\utility::getStructArray("barrage_node", "targetname");

  while(isDefined(var_0._id_1323B))
    scripts\engine\utility::waitframe();

  var_0.origin = getcsplinepointposition(var_2, 0) - (500, 0, 0);
  var_4 = var_0 scripts\sp\utility::_id_10808();
  var_4 thread _id_168E();
  var_4 _id_0BDC::_id_19AB(450, 100);
  wait 6;
  var_1.origin = getcsplinepointposition(var_3, 0) - (500, 0, 0);
  var_5 = var_1 scripts\sp\utility::_id_10808();
  var_5 _id_0BDC::_id_A36D();
  var_5 thread _id_282F();
  var_5 thread _id_1552();
  var_5 thread ace_pilot_dead_notify();
  var_5 _id_0BDC::_id_19B3("patrol", "ace_intro_spline_2");
  var_5 _id_0BDC::_id_19B3("escape", "ace_intro_spline_2");
  var_5 _id_0BDC::_id_19B1(0);
  var_5 _id_0BDC::_id_1990(1);
  var_5 _id_0BDC::_id_19AB(450, 100);
  level waittill("ace_pilot_dead");
  wait 0.1;
  var_0.origin = getcsplinepointposition(var_2, 0) - (500, 0, 0);
  var_4 = var_0 scripts\sp\utility::_id_10808();
  var_4 thread _id_168E();
  var_4 _id_0BDC::_id_19AB(450, 100);
}

_id_1552() {
  self waittill("death");
  level notify("ace_death");
}

ace_pilot_dead_notify() {
  self waittill("death");
  level notify("ace_pilot_dead");
}

_id_282F() {
  self endon("death");
  level._id_575E = 0;
  var_0 = 0;
  var_1 = [];
  var_1[var_1.size] = ["Maintenance", "Pressure loss, deck C, compartment A, sealing off now!"];
  var_1[var_1.size] = ["Salter", "My hand's are full here Reyes, Keep the heat off the Retribution!"];
  var_1[var_1.size] = ["Gator", "We can't take another hit like that! Take those bastards out!"];
  var_1[var_1.size] = ["Engineering", "That hit took out our stabilizers! We need time to recalibrate!"];

  for(;;) {
    self waittill("barrage");
    thread _id_282D();

    if(isDefined(level.player._id_58B7)) {
      if(level.player._id_58B7 == self && !level._id_575E) {
        var_0++;

        if(var_0 >= var_1.size)
          var_0 = 0;
      }
    }
  }
}

_id_282D() {
  self endon("death");
  var_0 = scripts\engine\utility::getclosest(self.origin, level._id_282E, 1024);
  var_1 = ["tag_flash_right", "tag_flash_left"];
  var_2 = 0;

  if(isDefined(var_0)) {
    while(isDefined(var_0.target)) {
      var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      var_3 = _id_0B76::_id_1992(var_1[var_2 % 2], var_0, 1);
      wait 0.5;
    }
  }
}

_id_282C() {
  level notify("stop_dlg_timeout");
  level endon("stop_dlg_timeout");
  level._id_575E = 1;
  wait 6;
  level._id_575E = 0;
}

_id_6A46(var_0, var_1) {
  self waittill("missile_explode");
  playFX(scripts\engine\utility::getfx(var_0), var_1.origin);
}

_id_981B() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0._id_154F)) {
      break;
    }
  }

  var_1 = scripts\engine\utility::getStruct(self.target, "targetname");

  for(;;) {
    playFX(scripts\engine\utility::getfx("retribution_barrage"), var_1.origin);

    if(isDefined(var_1.target))
      var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    else
      break;

    wait 0.5;
  }
}

_id_168E() {
  self notify("aceified");
  self._id_154F = 1;
  thread _id_282F();
  _id_0BDC::_id_19B3("patrol", "ace_intro_spline_1");
  _id_0BDC::_id_19B3("escape", "ace_intro_spline_1");
  _id_0BDC::_id_19B1(0);
  _id_0BDC::_id_1990(1);
  thread _id_1552();

  if(!isDefined(level._id_1553))
    level._id_1553 = 0;

  var_0 = level._id_1553;
  level._id_1553++;
  var_1 = 1;

  if(!isDefined(level._id_1559))
    level._id_1559 = [];

  level._id_1559[level._id_1559.size] = self;
  _id_0BDC::_id_A36D();

  if(var_0 < 1) {
    objective_onentity(scripts\sp\utility::_id_C264("obj_kill_aces"), self);
    var_1 = 0;
  } else
    objective_additionalentity(scripts\sp\utility::_id_C264("obj_kill_aces"), var_0, self);

  self waittill("death");
  level notify("ace_pilot_dead");
  scripts\engine\utility::waitframe();
  level._id_1559 = scripts\sp\utility::_id_DFEB(level._id_1559);
}

_id_1557() {
  self endon("death");

  for(;;) {
    self waittill("fd_notify_ace_mode_engaged");
    objective_state(scripts\sp\utility::_id_C264("obj_kill_aces"), "invisible");
    self waittill("fd_notify_ace_mode_disengaged");
    objective_state(scripts\sp\utility::_id_C264("obj_kill_aces"), "current");
  }
}

_id_9738(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7A97();

  if(!isDefined(level._id_6E81))
    level._id_6E81 = [];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "flak_struct") {
      var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
      var_4 linkTo(self);
      level._id_6E81[level._id_6E81.size] = var_4;
    }
  }
}

_id_E3AA() {
  level._id_FD6E._id_E35D _id_0B51::_id_C5FD();
  level waittill("ftl_retribution");
  level._id_FD6E._id_E35D._id_749D = ::_id_E310;
  level._id_FD6E._id_E35D._id_7482 = "retribution_un_warp";
  level._id_FD6E._id_E35D._id_748F = "vfx_ftl_ca_destroyer";
  level._id_FD6E._id_E35D _id_7487();
  level._id_FD6E._id_E35D thread _id_E307();
  level._id_FD6E._id_E35D thread _id_E308();
  level._id_FD6E._id_E35D _id_0BB8::_id_39CD("idle");
  level._id_FD6E._id_E35D _id_0BB8::_id_39D0("idle");
  level._id_FD6E._id_E35D _id_0BB8::_id_39CE("low");
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("show");
  level._id_FD6E._id_E35D castspotshadows(0);
  level._id_FD6E._id_E35D thread _id_0B51::_id_4268(2);
}

_id_7487() {
  self.origin = self.origin - anglesToForward(self.angles) * 4000;
  _id_0BB8::_id_39CD("off");
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CE("off");
  self._id_6A8D = "un";
  _id_0BB6::_id_39E8();
  _id_0BB6::_id_39EE(0);
  _id_0BB8::_id_39AE();
  self hide();
  _id_0BB8::_id_398C("idle", "idle", "high");
  self moveTo(self.origin + anglesToForward(self.angles) * 4000, 6, 0, 6);
}

_id_E310() {
  visionsetnaked("sa_assassination_ftl", 0.1);
  wait 0.4;
  visionsetnaked("sa_assassination", 0.4);
}

_id_51FE() {
  level._id_68F7 = scripts\sp\utility::_id_8200("exfil_ally_jackal", "targetname");
  var_0 = getcsplineid("gunner_exfil_jackal_spline");
  level._id_68F7 _id_51FD(var_0, "dogfight_spline");
}

_id_51FB() {
  level._id_68F7 = scripts\sp\utility::_id_8200("exfil_ally_jackal", "targetname");
  level._id_68F7 scripts\sp\utility::_id_1747(::_id_F8B2);
  var_0 = getcsplineidarray("exfil_wingman_spline");
  var_1 = getcsplineidarray("dogfight_spline");
  level._id_68F7 _id_51EE(var_0, "dogfight_spline");
  level._id_68F7 _id_51EE([var_1[1], var_1[2]], "dogfight_spline");
}

_id_F8B2() {
  if(!isDefined(level._id_68F6))
    level._id_68F6 = [];

  self.maxhealth = 999999;
  self.health = 999999;
  level._id_68F6[level._id_68F6.size] = self;
}

_id_51EE(var_0, var_1) {
  foreach(var_3 in var_0) {
    while(isDefined(self._id_1323B))
      scripts\engine\utility::waitframe();

    self.origin = getcsplinepointposition(var_3, 0);
    var_4 = scripts\sp\utility::_id_10808();
    var_4 _id_F8B2();
    var_4 thread _id_0BDC::_id_A1EF(var_3, undefined, 32);
    var_4 thread _id_1D08(var_1);
  }
}

_id_51FD(var_0, var_1) {
  while(isDefined(self._id_1323B))
    scripts\engine\utility::waitframe();

  self.origin = getcsplinepointposition(var_0, 0);
  var_2 = scripts\sp\utility::_id_10808();
  var_2 thread _id_0BDC::_id_A1EF(var_0, undefined, 32);
  var_2._id_12A88 = 1;
  var_2 notify("stop_kicking_up_dust");
  var_2 endon("death");
  var_2 waittill("gun_em_down");
  var_2 _id_0BDC::_id_19A9();
  var_2 thread _id_1D08(var_1);
  var_2 _id_0BDC::_id_19B0("hover");
  var_2 thread _id_A367();
  var_2 _id_0BDC::_id_1980(1, 0.5);
  var_2 waittill("gun_em_down_end");
  var_2 _id_0BDC::_id_19AE("shoot_at_will");
  var_2 _id_0BDC::_id_19B0("fly");
  var_2 _id_0BDC::_id_198A();
  var_2 _id_0BDC::_id_1980(undefined, undefined);
  var_2 _id_0BDC::_id_1988();
}

_id_A367() {
  var_0 = undefined;
  _id_0BDC::_id_19AE("shoot_forever");

  foreach(var_2 in level._id_91BF) {
    if(isalive(var_2) && distance(level.player.origin, var_2.origin) > 512) {
      var_0 = var_2;
      _id_0BDC::_id_19B5(var_0);
      var_0 thread _id_91C0(self);
      break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  while(level._id_91BF.size > 0) {
    var_0 waittill("death");
    scripts\engine\utility::waitframe();
    level._id_91BF = scripts\sp\utility::_id_DFEB(level._id_91BF);
    scripts\engine\utility::waitframe();

    if(level._id_91BF.size > 0) {
      foreach(var_5, var_2 in level._id_91BF) {
        if(distance(level.player.origin, var_2.origin) > 512) {
          var_0 = level._id_91BF[var_5];
          _id_0BDC::_id_19B5(var_0);
          var_0 thread _id_91C0(self);
          break;
        }
      }
    }
  }

  _id_0BDC::_id_19AE("dont_shoot");
}

_id_91C0(var_0) {
  self endon("death");
  self waittill("damage", var_1, var_2);

  if(var_2 == var_0)
    self dodamage(2000, var_0.origin);
}

_id_1D08(var_0) {
  scripts\sp\vehicle::_id_8441();
  _id_0BDC::_id_19B3("patrol", var_0);
  _id_0BDC::_id_19B3("escape", var_0);
  _id_0BDC::_id_19B1(0);
  _id_0BDC::_id_1990(1);
}

_id_68C8() {
  _id_94F6();

  foreach(var_1 in level._id_68FE) {
    if(var_1.model == "veh_mil_air_ca_destroyer")
      var_1 _id_0BB6::_id_39F0();
  }
}

_id_94F6() {
  if(!isDefined(level._id_6E81))
    level._id_6E81 = scripts\engine\utility::getStructArray("flak_spot", "targetname");
  else
    scripts\engine\utility::array_combine(level._id_6E81, scripts\engine\utility::getStructArray("flak_spot", "targetname"));

  scripts\engine\utility::array_thread(level._id_6E81, ::_id_B03D);
}

_id_B03D() {
  level endon("player_jackal_drone_dock");

  for(;;) {
    wait(3 + randomfloat(6));
    playFX(scripts\engine\utility::getfx("ambient_flak"), self.origin + scripts\engine\utility::randomvector(1) * randomint(50));
    thread _id_6935();
  }
}

_id_6935() {
  visionsetnaked("sa_assassination_flak", 0.1);
  wait 0.1;
  visionsetnaked("sa_assassination_ext", 0.1);
}

_id_11541() {
  self endon("death");

  for(;;) {
    self._id_114FB = level._id_FD6E._id_E35D;
    wait 1;
  }
}

_id_A1B1() {
  level endon("player_is_flying");
  var_0 = scripts\engine\utility::spawn_tag_origin((3130, -664, -560), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("exfil_zerog"), "current", "", var_0.origin);
  _func_2E9(scripts\sp\utility::_id_C264("exfil_zerog"), 1);
  var_0 thread _id_2FAF();
  var_1 = getEnt("exfil_enemy_chain", "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(var_1.target)) {
      var_3 = getEntArray(var_1.target, "targetname");
      var_4 = scripts\engine\utility::getStruct(var_1.target, "targetname");
      var_1 = undefined;
      var_5 = undefined;

      foreach(var_7 in var_3) {
        if(var_7.classname == "trigger_multiple")
          var_1 = var_7;
      }

      if(isDefined(var_4))
        objective_position(scripts\sp\utility::_id_C264("exfil_zerog"), var_4.origin);
    } else
      break;

    if(!isDefined(var_1)) {
      break;
    }
  }

  while(!isDefined(level._id_D127))
    wait 0.2;

  var_0 dontinterpolate();
  var_0.origin = level._id_D127 gettagorigin("tag_player") + anglestoup(level._id_D127.angles) * 128;
  var_0 linkTo(level._id_D127);
  objective_onentity(scripts\sp\utility::_id_C264("exfil_zerog"), var_0);
  level waittill("jackal_enter");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("exfil_zerog"));
  var_0 delete();
}

_id_2FAF() {
  self endon("death");
  level waittill("player_is_flying");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("exfil_zerog"));
  self delete();
}

_id_BBDC() {
  while(!isDefined(level._id_D127))
    wait 0.2;

  while(distance(level.player.origin, level._id_D127.origin) > 5000)
    wait 0.2;

  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_D127 gettagorigin("tag_player") + anglestoup(level._id_D127.angles) * 128, (0, 0, 0));
  var_0 linkTo(level._id_D127);
  objective_onentity(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), var_0);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), "");
  level waittill("jackal_enter");
  var_0 delete();
}

_id_170E() {
  if(!isDefined(level._id_5DCB))
    level._id_5DCB = [];

  level._id_5DCB[level._id_5DCB.size] = self;
}

_id_6924() {
  var_0 = scripts\engine\utility::getStruct("exfil_retribution_obj", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  objective_add(scripts\sp\utility::_id_C264("exfil_ret"), "current", &"SA_ASSASSINATION_BOARD_THE_RETRIBUTION");
}

_id_95D3() {
  level._id_6917 = getEntArray("exfil_battle_flashers", "targetname");
  level._id_6918 = scripts\sp\utility::_id_7853(level._id_6917);
  scripts\engine\utility::array_thread(level._id_6917, ::_id_C073, 0);
  level._id_11214 = getmapsuncolorandintensity();
  level._id_11219 = getmapsundirection();
  level._id_11215 = [255, 255, 255, level._id_11214[3] * 1.5];
  var_0 = scripts\engine\utility::getStruct("flak_sun_dir", "targetname");

  if(isDefined(var_0))
    level._id_1121A = anglesToForward(var_0.angles);
  else
    level._id_1121A = (-20, -40, 0);
}

_id_C073(var_0) {
  self setlightintensity(var_0);
}

_id_6915() {
  var_0 = 15000;
  var_1 = 600;
  var_2 = distance(level._id_6918, self.origin);
  var_3 = 200;

  if(var_2 > var_0) {
    return;
  }
  if(var_2 < var_0 / 2)
    var_4 = 600;
  else
    var_4 = (var_0 - var_2) / (var_0 / 2) * var_1;

  if(var_3 < 200)
    var_4 = 200;

  if(var_4 > 0)
    scripts\engine\utility::array_thread(level._id_6917, ::_id_6916, var_4);

  setsuncolorandintensity(1, 0.968627, 0.913725, level._id_11215[3]);
  wait 0.05;
  resetsundirection();
  resetsunlight();
}

_id_6916(var_0) {
  self setlightintensity(var_0);
  wait 0.05;
  self setlightintensity(0);
}

_id_F9B3() {
  var_0 = scripts\sp\utility::_id_8201("gun_down_jackal", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_A1F9);
}

_id_F9C1() {
  var_0 = scripts\sp\utility::_id_8201("missile_death_jackal", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_A1D2);
}

_id_A1F9() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = getcsplineid(self.target);
  var_2 = scripts\sp\utility::_id_7A97();
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(isDefined(var_6.script_noteworthy)) {
      if(var_6.script_noteworthy == "target") {
        var_3 = var_6 scripts\engine\utility::spawn_tag_origin();
        var_3.team = "allies";
      }

      if(var_6.script_noteworthy == "missile")
        var_4 = var_6;
    }
  }

  var_0 waittill("trigger", var_8);
  var_9 = scripts\sp\utility::_id_10808();
  var_9 vehicle_teleport(getcsplinepointposition(var_1, 0), (0, 0, 0));
  var_9 thread _id_0BDC::_id_A342(var_1);
  var_9 waittill("gun_down");
  var_9 _meth_8491("hover");
  var_9 _id_0BDC::_id_19B5(var_3);
  var_9 _id_0BDC::_id_19B2("face enemy");
  var_9 _id_0BDC::_id_19AE("shoot_now");
  var_9 waittill("gun_down_end");
  var_9 _id_0BDC::_id_19B0("fly");
  var_3 delete();
  var_9 dodamage(200000, var_9.origin);
}

_id_A1D2() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = scripts\sp\utility::_id_7A96();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isDefined(level._id_D127)) {
      continue;
    }
    if(var_2 == level._id_D127 && scripts\engine\utility::player_is_in_jackal()) {
      break;
    }
  }

  var_3 = scripts\sp\utility::_id_10808();
  var_3 _id_0BDC::_id_A373(self.target);
  var_3 waittill("missile_fire");
  var_3 dodamage(200000, var_3.origin);
}

_id_A272(var_0, var_1) {
  var_2 = magicbullet("spaceship_homing_missile", var_0.origin, anglesToForward(var_0.angles) * 256);
  wait(var_1);
  var_2 missile_settargetEnt(self, (0, 0, 0));
  var_2 missile_setflightmodedirect();
}

_id_6905() {
  level endon("kill_exfil_docking_nag");
  level endon("player_jackal_drone_dock");

  for(;;) {
    wait 10;
    scripts\sp\utility::_id_10350("asn_gtr_sirweneedyou");
    wait 10;
    scripts\sp\utility::_id_10350("asn_gtr_captainwecanthold");
  }
}

_id_A838() {
  level waittill("player_jackal_drone_dock");
  _id_0F16::_id_F603("sa_assassination_ext", 0.1);
  wait 2.25;
  _id_0F16::_id_F603("sa_assassination_ext_02", 1.5);
}

_id_F430() {
  var_0 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_player") + anglestoright(self gettagangles("tag_player")) * -60);
  var_0.origin = var_0.origin + anglesToForward(self gettagangles("tag_player")) * 40;
  var_0.origin = var_0.origin + anglestoup(self gettagangles("tag_player")) * -18;
  var_0 linkTo(self, "tag_player");
  _id_0F35::_id_FB25(1, 1, 1);
  level.player _meth_8501(var_0);
  self notify("end_jackal_interact");
  _id_0E46::_id_DFE3();
  _id_0E46::_id_48C4("tag_body", (230, 48, self._id_99F5.height), undefined, self._id_99F5._id_56B6, self._id_99F5.draw_distance, self._id_99F5._id_12FC3);
  thread player_jackal_use_mount();

  for(;;) {
    level.player waittill("spacejump_takeoff", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_5) && var_5 == var_0) {
      level.player _meth_8502();
      break;
    }
  }

  level.player scripts\engine\utility::waittill_any_return("spacejump_land", "spacegrapple_cancel");
  level.player notify("spacegrapple_cancel");
  level.player notify("side_evaluator_end");
  self notify("trigger", level.player);
}

player_jackal_use_mount() {
  self waittill("trigger");
  thread _id_0BDB::_id_F51F();
}

_id_84A8(var_0, var_1) {
  self endon("side_evaluator_end");
  var_2 = var_0;

  for(;;) {
    var_3 = scripts\engine\utility::getclosest(level.player getEye(), [var_0, var_1], 2048);

    if(isDefined(var_3) && var_3 != var_2) {
      var_2 = var_3;
      level.player _meth_8501(var_2);
    }

    wait 0.5;
  }
}

_id_EAC1() {
  var_0 = (-95, 0, 0);
  var_1 = getcsplineid("salter_exfil_jackal_spline", "targetname");

  while(isDefined(level._id_68F7._id_1323B))
    scripts\engine\utility::waitframe();

  level._id_68F7.origin = getcsplinepointposition(var_1, 0);
  var_2 = level._id_68F7 scripts\sp\utility::_id_10808();
  var_2._id_CB8D = level._id_68F7 scripts\engine\utility::spawn_tag_origin();
  var_2._id_CB8D linkTo(var_2, "tag_player", var_0, (0, 0, 0));
  level._id_EA99 = var_2;
  var_2 _id_0BDC::_id_19A0(1);
  var_2._id_55A4 = 1;
  var_2.ignoreme = 1;
  var_2 hidepart("j_gun_left");
  var_2 hidepart("j_gun_right");
  var_2 hidepart("j_gun_barrel_2_right");
  var_2 hidepart("j_gun_barrel_2_left");
  var_2 _meth_8479(var_1);
  var_2 _meth_847B();
  var_2._id_12A88 = 1;
  var_2 waittill("near_goal");
  var_2 _meth_8491("hover");
  var_2 _meth_8455(var_2.origin, 1);
  wait 2;
  _id_0BDC::_id_137CF();
  wait 8;
  var_2 _meth_8491("fly");
  var_2 showpart("j_gun_left");
  var_2 showpart("j_gun_right");
  var_2 showpart("j_gun_barrel_2_right");
  var_2 showpart("j_gun_barrel_2_left");
  _id_EA84();
}

_id_13BC(var_0, var_1) {
  level endon("player_dogfight_ready");
  level._id_EA2C setgoalpos(var_0 gettagorigin("tag_player"));
  level._id_EA2C scripts\sp\utility::_id_F3DD(32);
  level._id_EA2C scripts\engine\utility::waittill_any("goal", "near_goal");
  var_0 notify("salter_mounting");
  var_0._id_CB8D scripts\sp\anim::_id_1F35(self, var_1, "tag_origin");
  var_0._id_CB8D thread scripts\sp\anim::_id_1EE0(self, var_1, "tag_origin");
  self linkTo(var_0._id_CB8D);
}

_id_EAC2(var_0, var_1) {
  var_0 _id_0BDC::_id_1986();
  var_0 _id_0BDC::_id_19A9();
  var_0._id_CB8D thread scripts\sp\anim::_id_1EE0(level._id_EA2C, "sa_exfil_salter_mount", "tag_origin");
  level._id_EA2C linkTo(var_0._id_CB8D);
}

_id_EA84() {
  var_0 = getcsplineid("salter_dogfight_spline", "targetname");
  level._id_EA99 _id_0BDC::_id_1988();
  level._id_EA99 thread _id_0BDC::_id_A1EF(var_0, undefined, 32);
  level._id_EA99 _id_0BDC::_id_19B3("patrol", "dogfight_spline");
  level._id_EA99 _id_0BDC::_id_19B3("escape", "dogfight_spline");
  level._id_EA99 _id_0BDC::_id_19B1(0);
  level._id_EA99 _id_0BDC::_id_1990(1);
}

_id_10688() {
  var_0 = getEnt("exfil_enemy_wave_1", "targetname");
  var_0 waittill("trigger");
}

_id_10689() {
  var_0 = getEnt("exfil_enemy_wave_2", "targetname");
  var_0 _id_137AB("trigger", 9);
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_10619, 1);
}

_id_106EB() {
  var_0 = getEnt("exfil_enemy_wave_1", "targetname");
  var_0 notify("trigger");
  wait 2;
  var_0 = getEnt("exfil_enemy_wave_2", "targetname");
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_10619, 1);
}

_id_A36E() {
  self.fixednode = 1;
  self._id_2894 = 0.5;

  if(!isDefined(level._id_91BF))
    level._id_91BF = [];

  level._id_91BF[level._id_91BF.size] = self;
}

_id_137AB(var_0, var_1) {
  level endon("game_ended");
  self endon(var_0);
  wait(var_1);
}

_id_4C6D() {
  scripts\sp\utility::_id_56BA("jackal_takeoff");
  _id_0BDC::_id_A302(0.1, 0, "vtol_turn_takeoff");
  _id_0BDC::_id_A301(0.01, 0, "vtol_speed_takeoff");

  for(;;) {
    wait 0.05;

    if(level.player buttonPressed("BUTTON_A")) {
      break;
    }
  }

  _id_0BDC::_id_A302(1.0, 0, "vtol_turn_takeoff");
  _id_0BDC::_id_A301(1.0, 0, "vtol_speed_takeoff");
  _id_0BDB::_id_11478();
}

_id_68F1() {
  var_0 = scripts\engine\utility::getStruct("int_airlock_aligner", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_E99E["exfil_door_interior"]._id_1FBB = "airlock_door_int";
  var_1 thread scripts\sp\anim::_id_1EC3(level._id_E99E["exfil_door_interior"], "door_airlock_int", "tag_origin");
  var_0 = scripts\engine\utility::getStruct("exfil_underbelly_mover", "targetname");
  var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_E99E["exfil_door"]._id_1FBB = "exfil_door";
  var_2 thread scripts\sp\anim::_id_1EC3(level._id_E99E["exfil_door"], "exfil_door", "tag_origin");
}

_id_68F0() {
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  objective_state(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), "invisible");
  var_0 = scripts\engine\utility::getStruct("int_airlock_aligner", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  self._id_1FBB = "airlock_door_int";
  var_2 = scripts\sp\utility::_id_10639("player_rig_disguise");
  var_2 hide();
  var_1 thread scripts\sp\anim::_id_1EC3(var_2, "plr_airlock_int", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1EC3(self, "door_airlock_int", "tag_origin");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  level.player _meth_823C(var_2, "tag_player", 0.25, 0.1, 0.1);
  wait 0.25;
  thread _id_10D68();
  var_2 show();
  scripts\sp\utility::_id_65E1("begin_opening");
  var_1 thread scripts\sp\anim::_id_1F35(self, "door_airlock_int", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "plr_airlock_int", "tag_origin");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6914();
  var_2 waittillmatch("single anim", "end");
  scripts\sp\utility::_id_E006();
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  var_2 delete();
  var_1 delete();
  level._id_EA2C notify("do_the_hop");
  level._id_E99E["exfil_door"] _id_0F05::_id_12BD3(undefined, "tag_ui_front");
  setsaveddvar("player_zeroGravDisableWalk", 0);
  _id_0F35::_id_FB24(0, level.player);
  wait 2;
  scripts\engine\utility::exploder("vfx_assn_airlock_depress");
  wait 1;
  _id_0F35::_id_FB24(1, level.player);
  scripts\sp\utility::_id_266F();
}

_id_68F2() {
  var_0 = scripts\engine\utility::getStruct("exfil_underbelly_mover", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  self._id_1FBB = "exfil_door";
  var_2 = scripts\sp\utility::_id_10639("player_rig_disguise");
  var_2 hide();
  var_1 thread scripts\sp\anim::_id_1EC3(var_2, "exfil_plr", "tag_origin");
  var_1 thread scripts\sp\anim::_id_1EC3(self, "exfil_door", "tag_origin");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player _meth_823C(var_2, "tag_player", 0.25, 0.1, 0.1);
  wait 0.25;
  var_2 show();
  scripts\sp\utility::_id_65E1("begin_opening");
  var_1 thread scripts\sp\anim::_id_1F35(self, "exfil_door", "tag_origin");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6926();
  scripts\engine\utility::delaythread(2, scripts\sp\maps\sa_assassination\sa_assassination_util::_id_13481, "sa_assassination_ext", 1);
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "exfil_plr", "tag_origin");
  var_2 waittillmatch("single anim", "ret_ftl_early");
  level notify("ftl_retribution");
  var_2 waittillmatch("single anim", "end");
  setsaveddvar("player_zeroGravDisableWalk", 1);
  thread _id_0F36::_id_12AB4("exfil_zero_g_end");
  level.player unlink();
  level.player freezecontrols(0);
  level.player enableweapons();
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  var_2 delete();
  var_1 delete();
  scripts\engine\utility::flag_clear("player_in_gravity");
  _id_0F35::_id_FB25(1, 1, 1);
}

_id_68F4() {
  scripts\sp\utility::_id_10350("asn_gtr_actualthisisthe");
  scripts\sp\utility::_id_1034D("asn_plr_copygatorgetour");
}

_id_EA91() {
  if(isalive(level._id_EA2C)) {
    level._id_EA2C scripts\sp\utility::_id_1101B();
    level._id_EA2C delete();
  }

  var_0 = getspawner("salter_0G", "script_noteworthy");
  var_0.origin = level.player.origin - anglesToForward(level.player getplayerangles()) * 32;
  var_0.angles = level.player getplayerangles();
  scripts\engine\utility::waitframe();
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1, 0);
  level._id_EA2C scripts\sp\utility::_id_B14F();
  level._id_EA2C scripts\engine\utility::delaythread(2, ::_id_671B);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C[[level._id_EA2C._id_72D0]](level.player getplayerangles());
  level._id_EA2C scripts\sp\utility::_id_413D();
  var_1 = getnode("salter_zg_cover_goal", "targetname");
  level._id_EA2C _meth_82EE(var_1);
  level._id_EA2C scripts\sp\utility::_id_F3DD(32);

  while(!isDefined(level._id_EA99))
    wait 0.5;

  level._id_EA99 scripts\engine\utility::waittill_either("goal", "near_goal");

  while(isDefined(var_1.target)) {
    var_1 = getnode(var_1.target, "targetname");
    level._id_EA2C _meth_82EE(var_1, "targetname");
    level._id_EA2C waittill("goal");
  }

  _id_0BDC::_id_137CF();

  if(isDefined(level._id_EA2C._id_B14F) && level._id_EA2C._id_B14F)
    level._id_EA2C scripts\sp\utility::_id_1101B();

  level waittill("mount dialog done");

  if(isalive(level._id_EA2C))
    level._id_EA2C delete();
}

_id_A280() {
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_weneedthoseskelters");
  scripts\sp\utility::_id_1034D("asn_plr_gatorspoolupfor");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_scar2syouheardthe");
  level notify("mount dialog done");
  setmusicstate("mx_165_assassination_jackal");
}

_id_671B() {
  objective_add(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), "current");
  _func_2E9(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), 1);
  setsaveddvar("objectiveFadeTooFar", 1);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), &"SA_ASSASSINATION_SUPPORT");
  objective_onentity(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), level._id_EA2C, (0, 0, 60));
}

_id_4C73() {}

_id_E3AC() {
  visionsetnaked("sa_assassination_ftl", 0.1);
  wait 0.4;
  visionsetnaked("sa_assassination_ext", 0.3);
}

_id_D844() {
  wait 3;
  thread scripts\sp\utility::_id_BF97();
}

_id_589D() {
  level waittill("ace_death");
  scripts\engine\utility::delaythread(0.75, scripts\sp\utility::_id_10350, "asn_slt_niceshootingtwomore");
  scripts\engine\utility::waitframe();
  level waittill("ace_death");
  scripts\engine\utility::delaythread(0.75, scripts\sp\utility::_id_1034D, "asn_plr_almostcleargator");
}

_id_E3AF() {
  level._effect["un_thruster_rear_med_idle"] = loadfx("vfx/iw7/core/vehicle/retr/vfx_veh_retr_thrust_rear_idle_child.vfx");
  level._effect["un_thruster_down_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/retr/vfx_veh_retr_thrust_vert_large_idle.vfx");
}

_id_E307() {
  var_0 = [];
  self._id_11856 = [];
  var_1 = getnumparts(self._id_E505);

  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0[var_0.size] = getpartname(self._id_E505, var_2);

  foreach(var_4 in var_0) {
    var_5 = strtok(var_4, "_");

    if(var_5.size < 5) {
      continue;
    }
    if(var_5[1] == "engine" && var_5.size >= 5) {
      if(var_5[4] == "in" || var_5[4] == "out" && var_5.size != 7)
        self._id_11856[self._id_11856.size] = playFXOnTag(scripts\engine\utility::getfx("un_thruster_rear_med_idle"), self, var_4);
      else if(var_5[2] == "bottom")
        self._id_11856[self._id_11856.size] = playFXOnTag(scripts\engine\utility::getfx("un_thruster_down_lrg_idle"), self, var_4);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_E308() {
  self._id_EEF9 = "cannon_small_ca,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  self setModel("veh_mil_air_un_retribution_rig");
  _id_0BB6::_id_39E8();
  self setModel("veh_mil_air_un_retribution");
  level._id_FD6E._id_E35D.team = "allies";
  level._id_FD6E._id_E35D.script_team = "allies";

  foreach(var_1 in level._id_FD6E._id_E35D.turrets) {
    foreach(var_3 in var_1) {
      var_3.script_team = "allies";
      var_3.team = "allies";
    }
  }

  level._id_FD6E._id_E35D thread _id_0BB6::_id_39F0();
}

_id_D149() {
  var_0 = scripts\engine\utility::getStruct("dogfight_orienter", "targetname");
  self waittill("trigger");
  wait 1.5;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_1, "tag_origin");
  var_1 moveTo(var_0.origin, 5, 2.3, 2.3);
  var_1 rotateTo(var_0.angles, 5, 2.3, 2.3);
  var_1 waittill("movedone");
  self unlink();
  var_1 delete();
}

_id_A7DA() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_titan_plr_retributionthis");
  scripts\sp\utility::_id_10350("ja_titan_amb_rogerjackalsare");
  scripts\sp\utility::_id_1034D("ja_titan_plr_towerthisis11");
  scripts\sp\utility::_id_10350("ja_titan_slt_12unbound");
}

_id_A7D9() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_titan_plr_retributionthis");
}

_id_A82F() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_titan_amb_lineupfordrone");
  scripts\sp\utility::_id_1034D("ja_titan_plr_gearsoutforbaton");
}

_id_A7F4() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_titan_amb_lockisgood11");
}

_id_A7BE(var_0) {
  level.player endon("death");
  level waittill("player_jackal_drone_dock");
  thread _id_10B0::_id_CE85(var_0);
}

_id_A7BD(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::flag_init("jackal_assault_vo_playing");
  scripts\engine\utility::flag_init("jackal_assault_vo_playing_important");
  level notify("land_on_retribution");

  if(isDefined(var_4))
    thread _id_A7BE(var_4);

  level endon("player_jackal_drone_dock");
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    if(!var_5 && distance(level._id_FD6E._id_E35D.origin, level._id_D127.origin) > 48000) {
      var_5 = 1;
      var_6 = 0;
      wait 0.05;
      continue;
    }

    while(distance(level._id_FD6E._id_E35D.origin, level._id_D127.origin) <= 48000) {
      if(!var_7) {
        if(!var_6) {
          if(isDefined(var_1) && _id_0B76::_id_7A60(level._id_FD6E._id_E35D.origin) >= 0.7) {
            thread _id_10B0::_id_CE83(var_1);
            var_7 = 1;
          }
        } else if(isDefined(var_2) && _id_0B76::_id_7A60(level._id_FD6E._id_E35D.origin) >= 0.7) {
          thread _id_10B0::_id_CE83(var_2);
          var_7 = 1;
        }
      }

      level notify("land_on_ret_near_ret");
      var_5 = 0;
      var_6 = 1;

      if(!var_8) {
        if(scripts\engine\utility::flag("jackal_landing_active")) {
          thread _id_10B0::_id_CE85(var_3);
          var_8 = 1;
        }
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

_id_E30F() {
  level._effect["retribution_un_warp_pre"] = loadfx("vfx/iw7/core/vehicle/retr/vfx_vehicle_retr_warp_in_anticipation.vfx");
  level._effect["retribution_un_warp_in"] = loadfx("vfx/iw7/core/vehicle/retr/vfx_vehicle_retr_warp_in_anticipation.vfx");
  level._effect["retribution_un_warp_in_post"] = loadfx("vfx/iw7/core/vehicle/retr/vfx_vehicle_retr_warp_in.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_a_startup_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_a_startup_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_a_startup_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_a_startup_r.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_b_travel_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_b_travel_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_b_travel_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_b_travel_r.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_c_stop_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_c_stop_l.vfx");
  level._effect["vfx_veh_retr_ftl_00_panel_aggregate_c_stop_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_00_panel_aggregate_c_stop_r.vfx");
  level._effect["vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_small"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_small.vfx");
  level._effect["vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_large"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_02_panel_cool_charge_a_startup_large.vfx");
  level._effect["vfx_veh_retr_ftl_04_energy_waves_a_startup_l"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_04_energy_waves_a_startup_l.vfx");
  level._effect["vfx_veh_retr_ftl_04_energy_waves_a_startup_r"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_04_energy_waves_a_startup_r.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_a_startup"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_a_startup.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_05_dialation_sphere_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_05_dialation_sphere_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_a_startup"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_a_startup.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_06_center_energy_point_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_06_center_energy_point_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_08_sparks_b_travel"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_08_sparks_b_travel.vfx");
  level._effect["vfx_veh_retr_ftl_08_sparks_c_stop"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_08_sparks_c_stop.vfx");
  level._effect["vfx_veh_retr_ftl_11_panel_warm_charge_small"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_11_panel_warm_charge_small.vfx");
  level._effect["vfx_veh_retr_ftl_11_panel_warm_charge_large"] = loadfx("vfx/iw7/core/vehicle/retr/ftl/vfx_veh_retr_ftl_11_panel_warm_charge_large.vfx");
}

clean_up_robot_racks() {
  var_0 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    scripts\sp\utility::_id_228A(var_3);
  }
}