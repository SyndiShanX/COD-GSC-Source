/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_747ad1ab3322f8bc.gsc
***********************************************/

_id_35669831B02DC8FA(spawnorigin, targetorigin, _id_44EB7C4EAFC2E56E) {
  ac130 = spawn("script_model", spawnorigin);
  ac130 setModel("veh9_mil_air_cargo_plane_wm_dmz");
  ac130.angles = vectortoangles(targetorigin - spawnorigin);
  ac130.spawnorigin = spawnorigin;
  ac130 playLoopSound("iw8_bradley_drop_c130");
  ac130 setscriptablepartstate("lights2", "on", 0);
  ac130 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh))
    level.ac130_paratrooper_veh = [];

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  _id_F945F5534FFEDF42 = scripts\engine\utility::ter_op(isDefined(_id_44EB7C4EAFC2E56E), _id_44EB7C4EAFC2E56E, 4500);
  droporigin = targetorigin + anglesToForward(ac130.angles) * _id_F945F5534FFEDF42;
  _id_5AA0D059A6ED7C56 = distance2d(spawnorigin, droporigin);
  time = _id_5AA0D059A6ED7C56 / 2000;
  ac130 moveTo(droporigin, time);
  wait(time);
  return ac130;
}

_id_16DFD690940AE271(_id_66FA427056010163) {
  ac130 = self;
  _id_05E99EFFA86EF3AF = ac130.origin + anglesToForward(ac130.angles) * 64500;

  if(isDefined(_id_66FA427056010163)) {
    _id_A211BD3FFA8E8B6E = _id_66FA427056010163;
    _id_BA8D59C006AB07C1 = _id_05E99EFFA86EF3AF[0];
    _id_BA8D58C006AB058E = _id_05E99EFFA86EF3AF[1];
    _id_1B11EAA9B42E5081 = ac130.spawnorigin[0];
    _id_1B11E9A9B42E4E4E = ac130.spawnorigin[1];
    _id_688F97559BF04D6A = _id_A211BD3FFA8E8B6E[0];
    _id_688F98559BF04F9D = _id_A211BD3FFA8E8B6E[1];

    if(_id_BA8D59C006AB07C1 > _id_688F97559BF04D6A) {
      if(_id_BA8D59C006AB07C1 > _id_1B11EAA9B42E5081)
        _id_BA8D59C006AB07C1 = _id_688F97559BF04D6A;
    } else if(_id_BA8D59C006AB07C1 < _id_688F97559BF04D6A) {
      if(_id_BA8D59C006AB07C1 < _id_1B11EAA9B42E5081)
        _id_BA8D59C006AB07C1 = _id_688F97559BF04D6A;
    }

    if(_id_BA8D58C006AB058E > _id_688F98559BF04F9D) {
      if(_id_BA8D58C006AB058E > _id_1B11E9A9B42E4E4E)
        _id_BA8D58C006AB058E = _id_688F98559BF04F9D;
    } else if(_id_BA8D58C006AB058E < _id_688F98559BF04F9D) {
      if(_id_BA8D58C006AB058E < _id_1B11E9A9B42E4E4E)
        _id_BA8D58C006AB058E = _id_688F98559BF04F9D;
    }

    _id_05E99EFFA86EF3AF = (_id_BA8D59C006AB07C1, _id_BA8D58C006AB058E, _id_05E99EFFA86EF3AF[2]);
  }

  _id_5AA0D059A6ED7C56 = distance2d(ac130.origin, _id_05E99EFFA86EF3AF);
  time = _id_5AA0D059A6ED7C56 / 2000;
  ac130 moveTo(_id_05E99EFFA86EF3AF, time);
  wait(time);
  level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, ac130);
  ac130 stoploopsound();
  ac130 setscriptablepartstate("lights2", "off", 0);
  ac130 setscriptablepartstate("contrails", "off", 0);
  ac130 delete();
}

create_paratrooper(_id_19FA2154A6002EC3, _id_4F200828059689DB) {
  self endon("death");
  thread watch_for_death();
  parachute_set_spawn_values();
  parachute_get_path(0, undefined);
  parachute_skydive();

  if(isDefined(self._id_48713689EB4DB4B4))
    [[self._id_48713689EB4DB4B4]]();

  parachute_idle();
}

parachute_set_spawn_values() {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  _id_D57DE274B5C1D827 = 128;
  ac130 = undefined;

  if(isDefined(level.ac130_paratrooper_veh)) {
    foreach(veh in level.ac130_paratrooper_veh) {
      if(veh.spawngroup != self.enemy_group) {
        continue;
      }
      if(isDefined(self.ac130) && veh != self.ac130) {
        continue;
      }
      ac130 = veh;
    }
  }

  self asmsetstate(self.asmname, "parachute_freefall");
  self._blackboard.parachutestate = "freefall";

  if(isDefined(ac130)) {
    self.ac130 = ac130;
    _id_5856C0B118701A9F = (randomfloatrange(_id_D57DE274B5C1D827 * -1.0, _id_D57DE274B5C1D827), randomfloatrange(_id_D57DE274B5C1D827 * -1.0, _id_D57DE274B5C1D827), 0);
    self setOrigin(ac130.origin + (0, 0, 50) + _id_5856C0B118701A9F, 0);
  }
}

parachute_get_path(_id_C225E4DD6095FDCD, _id_C201CEDD606D52B3, _id_7DC1DF4FF378A6F4) {
  self endon("death");

  if(!isDefined(_id_C225E4DD6095FDCD))
    _id_C225E4DD6095FDCD = 100;

  if(!isDefined(_id_C201CEDD606D52B3))
    _id_C201CEDD606D52B3 = 500;

  _id_767D3482B0029903 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(0, 359));
  startorigin = self.spawnpoint.parachute_land_origin + _id_767D3482B0029903 * randomfloatrange(_id_C225E4DD6095FDCD, _id_C201CEDD606D52B3);
  landing_spot = getclosestpointonnavmesh(getgroundposition(startorigin, 64, 15000, 15000) + (0, 0, 32));
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  ignoreents = [self];

  if(isDefined(self.ac130) && self.ac130 != self)
    ignoreents[ignoreents.size] = self.ac130;

  trace = scripts\engine\trace::sphere_trace(self.origin, landing_spot + (0, 0, 128), 64, ignoreents, contents);

  if(trace["fraction"] < 1.0) {
    landing_spot = getclosestpointonnavmesh(trace["position"]);
    trace = scripts\engine\trace::sphere_trace(self.origin, landing_spot + (0, 0, 128), 64, ignoreents, contents);

    if(trace["fraction"] < 1.0) {
      nodes = getnodesinradiussorted(landing_spot, 1024, 0, 2048, "Exposed");
      _id_1E8AFDD8574541CB = 0;

      if(isDefined(nodes) && nodes.size > 0) {
        _id_7898211D070BAE3C = 2;

        foreach(index, node in nodes) {
          if(index >= _id_7898211D070BAE3C) {
            break;
          }

          if(!isDefined(self._id_0B767444B528BF22))
            self._id_0B767444B528BF22 = [];

          if(scripts\engine\utility::array_contains(self._id_0B767444B528BF22, node)) {
            continue;
          }
          trace = scripts\engine\trace::sphere_trace(self.origin, node.origin + (0, 0, 128), 64, ignoreents, contents);

          if(trace["fraction"] == 1.0) {
            landing_spot = node.origin;
            _id_1E8AFDD8574541CB = 1;
            break;
          } else
            self._id_0B767444B528BF22[self._id_0B767444B528BF22.size] = node;
        }
      }

      if(_id_1E8AFDD8574541CB) {
        _id_F69C1C88941DF67A(landing_spot);
        return;
      } else if(_id_C201CEDD606D52B3 < 2000)
        parachute_get_path(_id_C201CEDD606D52B3, _id_C201CEDD606D52B3 * 2);
      else
        _id_F69C1C88941DF67A(landing_spot);
    }
  }

  _id_F69C1C88941DF67A(landing_spot);
}

_id_F69C1C88941DF67A(landing_spot) {
  if(istrue(self._id_FAEB5E8CC0F1400A)) {
    return;
  }
  self._id_0B767444B528BF22 = undefined;
  self.landing_spot = landing_spot;
  self._id_FAEB5E8CC0F1400A = 1;
  offset = (0, 0, 0);

  if(isDefined(self.spawnpoint.allow_momentum)) {
    fwd = vectortoangles(self.origin - self.landing_spot);
    offset = anglesToForward(fwd) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1200) + (offset[0], offset[1], 0);
}

parachute_skydive(_id_19FA2154A6002EC3) {
  self endon("death");

  if(isDefined(self.ac130)) {
    _id_815D30728A6EF9D9 = self.spawnpoint.parachute_land_origin;
    dir = _id_815D30728A6EF9D9 - self.origin;
    yaw = vectortoyaw(dir);
    self.angles = (self.angles[0], yaw, self.angles[2]);
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);
    movetime = 9;
    movetime = movetime + randomfloatrange(-1, 1);
    _id_CC5BC42930ABBC4F = 2;
    self.anchor rotateTo((0, yaw, 0), _id_CC5BC42930ABBC4F);
    self.anchor moveTo(self.skydive_dest, movetime);
    wait(movetime - 3);
    parachute_spawn();
    parachute_deploy();
    wait 2;
  } else {
    self.nocorpse = 1;
    self dodamage(self.health + 100, self.origin);
  }
}

parachute_spawn() {
  chute = spawn("script_model", self gettagorigin("j_spine4"));
  chute.angles = self gettagangles("j_spine4");
  chute setModel("misc_wm_br_parachute");
  chute linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = chute;
  chute thread unlink_on_ai_death(self);
}

parachute_deploy() {
  self.chute scriptmodelplayanim("sdr_com_parachute_pullcord");
  self._blackboard.parachutestate = "parachuting";
  self asmsetstate(self.asmname, "parachute_deploy");
  thread delayeventfired();
}

delayeventfired() {
  self endon("death");
  wait 2.5;
  self asmfireevent(self.asmname, "finish");
}

parachute_idle() {
  thread parachute_move();
  thread parachute_idle_internal();
}

parachute_idle_internal() {
  self endon("death");
  wait 1.5;
  self.chute scriptmodelplayanim("sdr_com_parachute_idle");
}

parachute_move() {
  self endon("death");
  _id_69E534485EF2759C = 6;

  if(isDefined(self.spawnpoint.allow_momentum))
    _id_69E534485EF2759C = 9;

  _id_69E534485EF2759C = _id_69E534485EF2759C + randomfloatrange(-1, 1);
  _id_FECC6E7F3326E7CA = 1.5;
  self.anchor moveTo(self.landing_spot, _id_69E534485EF2759C, 0.1, 1.5);
  point1 = (self.origin[0], self.origin[1], 0);
  waitframe();
  _id_BF69DB3C5A539FAD = (self.origin[0], self.origin[1], 0);
  self.anchor rotateTo(vectortoangles(_id_BF69DB3C5A539FAD - point1), 3, 1, 1);
  wait(_id_69E534485EF2759C - 1.5);
  self._blackboard.parachutestate = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  wait 1.0;
  self.chute._id_D98BE71C27D2D22D = 1;
  wait 2.4;
  self.chute delete();
  self.chute notify("parachute_detached");
  thread do_landing();
}

do_landing() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self.angles = (0, self.anchor.angles[1], 0);
  self motionwarpcancel();
  self unlink();
  self.angles = (0, self.anchor.angles[1], 0);

  if(isDefined(self.anchor))
    self.anchor delete();

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;
  self.landing_spot = undefined;

  if(isDefined(self._id_55DDEB59DF2DEE74))
    [[self._id_55DDEB59DF2DEE74]]();

  if(isDefined(level._id_6D98A0934D4E3CA9))
    [[level._id_6D98A0934D4E3CA9]]();

  self notify("delete_chute");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

watch_for_death() {
  self endon("parachute_detached");
  self waittill("death");

  if(isDefined(self.anchor))
    self.anchor delete();
}

unlink_on_ai_death(ai) {
  self endon("death");
  ai endon("parachute_detached");
  ai waittill("death");
  self unlink();

  if(!istrue(self._id_D98BE71C27D2D22D)) {
    self movez(100, 2);
    wait 2;
  }

  self delete();
}