/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_aiparachute.gsc
***********************************************/

init_cp_aiparachute() {
  level.spawnfunc_registered = [];
  level.ac130_paratrooper_veh = [];
}

request_paratroopers(groupname, _id_A9B1DA94E346BBA3, spawnpos, spawnpoints) {
  if(!isDefined(level.spawnfunc_registered))
    level.spawnfunc_registered = [];

  if(!isDefined(level.spawnfunc_registered[groupname])) {
    _id_18A73A64992DD07D::register_module_ai_spawn_func(groupname, ::paratrooper_spawnfunc);
    level.spawnfunc_registered[groupname] = 1;
  }

  spawners = scripts\engine\utility::getStructArray(groupname, "targetname");

  if(isDefined(spawnpoints))
    spawners = spawnpoints;

  foreach(spawner in spawners) {
    spawner _id_18A73A64992DD07D::enable_spawner();

    if(!isDefined(spawner.parachute_land_origin))
      spawner.parachute_land_origin = spawner.origin;
  }

  spawner = spawners[0];
  _id_1E4BCE6C927436E0 = spawner.parachute_land_origin + (0, 0, 12000);

  if(isDefined(_id_A9B1DA94E346BBA3))
    _id_1E4BCE6C927436E0 = spawner.parachute_land_origin + (0, 0, _id_A9B1DA94E346BBA3);

  ac130 = spawn("script_model", spawnpos);
  ac130 setModel("veh9_mil_air_cargo_plane_wm");
  ac130.angles = vectortoangles(_id_1E4BCE6C927436E0 - ac130.origin);
  ac130 playLoopSound("cp_reinforcement_drop_c130");
  ac130 setscriptablepartstate("lights2", "on", 0);
  ac130 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh))
    level.ac130_paratrooper_veh = [];

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  ac130.spawngroup = groupname;
  _id_273771FF28315234 = 10;

  if(isDefined(level._id_7E0688B1C67F2B22))
    _id_273771FF28315234 = level._id_7E0688B1C67F2B22;

  if(_id_273771FF28315234 < 1)
    _id_273771FF28315234 = 1;

  ac130 moveTo(_id_1E4BCE6C927436E0 + anglesToForward(ac130.angles) * 4500, _id_273771FF28315234, 0.1, _id_273771FF28315234 * 0.25);
  wait(_id_273771FF28315234);
  spawners = scripts\engine\utility::getStructArray(groupname, "targetname");

  foreach(spawner in spawners)
  spawner.origin = ac130.origin;

  _id_C78F7D61791CD00A = _id_18A73A64992DD07D::run_spawn_module(groupname);
  ac130 moveTo(ac130.origin + anglesToForward(ac130.angles) * 24500, 10);
  wait 10;
  level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, ac130);
  ac130 stoploopsound();
  ac130 setscriptablepartstate("lights2", "off", 0);
  ac130 setscriptablepartstate("contrails", "off", 0);
  ac130 delete();
  return _id_C78F7D61791CD00A;
}

ac130_flight_path(_id_1E4BCE6C927436E0) {
  level endon("game_ended");
  self endon("death");
  self moveTo(_id_1E4BCE6C927436E0 + anglesToForward(self.angles) * 4500, 10);
  wait 10;
  thread fly_to_end_point();
}

fly_to_end_point() {
  self moveTo(self.origin + anglesToForward(self.angles) * 24500, 10);
  wait 10;

  if(scripts\engine\utility::array_contains(level.ac130_paratrooper_veh, self))
    level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, self);

  self delete();
}

spawn_paratrooper_ac130(groupname, spawnpos, _id_1E4BCE6C927436E0) {
  ac130 = spawn("script_model", spawnpos);
  ac130 setModel("veh8_mil_air_acharlie130_ks");
  ac130.angles = vectortoangles(_id_1E4BCE6C927436E0 - ac130.origin);
  ac130.health = 50000;
  ac130.maxhealth = 50000;
  ac130.team = "axis";

  if(!isDefined(level.ac130_paratrooper_veh))
    level.ac130_paratrooper_veh = [];

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  ac130.spawngroup = groupname;
  return ac130;
}

paratrooper_spawnfunc(spawngroup) {
  thread create_paratrooper();
}

create_paratrooper() {
  self endon("death");
  thread watch_for_death();
  parachute_set_spawn_values();
  parachute_get_path();
  parachute_skydive();
  parachute_idle();
}

parachute_set_spawn_values() {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  _id_18A73A64992DD07D::set_kill_off_time(1000);
  ac130 = undefined;

  foreach(veh in level.ac130_paratrooper_veh) {
    if(veh.spawngroup != self.enemy_group) {
      continue;
    }
    ac130 = veh;
  }

  if(isDefined(ac130)) {
    self.ac130 = ac130;
    self asmsetstate(self.asmname, "parachute_freefall");
    self._blackboard.parachutestate = "freefall";
    self setOrigin(ac130.origin + (0, 0, 50), 0);
  }
}

parachute_get_path(_id_4F200828059689DB) {
  self endon("death");

  if(!isDefined(_id_4F200828059689DB))
    _id_4F200828059689DB = 5;

  if(!isDefined(self.spawnpoint.parachute_land_origin))
    self.spawnpoint.parachute_land_origin = self.spawnpoint.origin;

  startorigin = self.spawnpoint.parachute_land_origin + (randomfloatrange(_id_4F200828059689DB * -1.0, _id_4F200828059689DB), randomfloatrange(_id_4F200828059689DB * -1.0, _id_4F200828059689DB), 0);
  self.landing_spot = undefined;
  _id_C1FB2D429477B8D8 = getgroundposition(startorigin, 64, 15000, 15000);

  if(isDefined(_id_C1FB2D429477B8D8))
    self.landing_spot = getclosestpointonnavmesh(_id_C1FB2D429477B8D8 + (0, 0, 32));

  if(!isDefined(self.landing_spot))
    self.landing_spot = getclosestpointonnavmesh(self.spawnpoint.origin);

  offset = (0, 0, 0);

  if(isDefined(self.spawnpoint.allow_momentum)) {
    fwd = vectortoangles(self.origin - self.landing_spot);
    offset = anglesToForward(fwd) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1500) + (offset[0], offset[1], 0);
}

parachute_skydive() {
  self endon("death");

  if(isDefined(self.ac130)) {
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);
    _id_340B0316991F7183 = 12;

    if(isDefined(level._id_752D2F716AFE7FCF)) {
      _id_340B0316991F7183 = level._id_752D2F716AFE7FCF;

      if(_id_340B0316991F7183 < 2.1)
        _id_340B0316991F7183 = 2.1;
    }

    self.anchor rotateTo((0, self.ac130.angles[1], 0) + (0, 180, 0), 2);
    self.anchor moveTo(self.skydive_dest, _id_340B0316991F7183);
    wait(_id_340B0316991F7183 - 3);
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
  wait 3.5;
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
  self setscriptablepartstate("skydiveVfx", "enabled", 0);
}

parachute_move() {
  self endon("death");
  _id_69E534485EF2759C = 6;

  if(isDefined(self.spawnpoint.allow_momentum))
    _id_69E534485EF2759C = 9;

  _id_FECC6E7F3326E7CA = 1.5;
  self.anchor moveTo(self.landing_spot, _id_69E534485EF2759C, 0.1, 1.5);
  point1 = (self.origin[0], self.origin[1], 0);
  waitframe();
  _id_BF69DB3C5A539FAD = (self.origin[0], self.origin[1], 0);
  self.anchor rotateTo(vectortoangles(_id_BF69DB3C5A539FAD - point1), 3, 1, 1);
  wait(_id_69E534485EF2759C - 1.5);
  self._blackboard.parachutestate = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  wait 3.4;
  self.chute delete();
  self.chute notify("parachute_detached");
  thread do_landing();
}

do_landing() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self setplayerangles((0, self.anchor.angles[1], 0));
  self motionwarpcancel();
  self unlink();
  self setplayerangles((0, self.anchor.angles[1], 0));

  if(isDefined(self.anchor))
    self.anchor delete();

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;
  self.landing_spot = undefined;

  if(!ispointonnavmesh(self.origin, self, 1))
    _id_18A73A64992DD07D::teleport_to_nearby_spawner("Landed off NavMesh", self.origin);
  else {
    _id_18A73A64992DD07D::set_kill_off_time(20);
    thread _id_18A73A64992DD07D::enter_combat();
  }

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
  self movez(100, 2);
  wait 2;
  self delete();
}