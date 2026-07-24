/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_parade_attack.gsc
*********************************************************************/

_id_C9DC() {
  setdvarifuninitialized("dropship_control", 1);
  setdvarifuninitialized("dropship_spin", 0);
  scripts\engine\utility::flag_init("dropship_player_controlled_begin");
  scripts\engine\utility::flag_init("dropship_start_crash");
  scripts\engine\utility::flag_init("dropship_spin_stop");
  scripts\engine\utility::flag_init("un_destroyer_water_crash_start");
  scripts\engine\utility::flag_init("enemy_capships_entry");
  scripts\engine\utility::flag_init("dropship_start_crash_flak");
  scripts\engine\utility::flag_init("kill_handle_scripts");
  scripts\engine\utility::flag_init("aatis_has_fired");
  var_0 = getEntArray("parade_run_dropship_triggers", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_C8D5);
}

_id_C8C2() {
  setsaveddvar("sm_sunSampleSizeNear", 27);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_48BF();
  level._id_D03A = scripts\sp\vehicle::_id_1080C("parade_dropship_heli");
  level._id_D03A _id_0BBC::_id_C5F1("right", undefined, 1);
  var_0 = getvehiclenode("proto_parade_dropship_plane_path", "targetname");
  level._id_D03A vehicle_teleport(var_0.origin, var_0.angles);
  level._id_5F23 = scripts\sp\vehicle::_id_1080C("parade_attacked_ship");
  scripts\sp\maps\pearlharbor\pearlharbor_parade::_id_D211(1);
  scripts\engine\utility::flag_set("parade_dropship_at_hover_pos");
}

#using_animtree("vehicles");

_id_C8C1() {
  scripts\engine\utility::flag_wait("parade_dropship_at_hover_pos");
  thread _id_C8C3();
  var_0 = getEnt("mover_atisguns", "targetname");
  var_0 notify("trigger");
  wait 6.0;
  scripts\sp\utility::_id_2670();
  wait 2;
  scripts\engine\utility::flag_set("aatis_has_fired");
  wait 4;
  scripts\engine\utility::flag_set("kill_handle_scripts");
  level._id_D03A notify("stop_dropship_idles");
  var_1 = level._id_D03A.origin;
  var_2 = level._id_D03A.angles;
  level._id_D03A delete();
  level._id_D03A = _id_0BBF::_id_106B8("parade_dropship_plane", undefined, "rear");
  level._id_D03A vehicle_teleport(var_1, var_2);
  level._id_D03A._id_1FBB = "dropship";
  level._id_D03A _id_0BBC::_id_5DC2();
  level.player _meth_80EF(level._id_D03A._id_4D94._id_4348);
  level._id_D03A._id_4D94._id_4348 notsolid();
  level._id_D03A notify("stop_parade_flight");
  var_3 = scripts\sp\utility::_id_10639("player_rig");
  var_3 linkTo(level._id_D03A);
  level._id_D03A scripts\sp\anim::_id_1EC3(var_3, "attack_dropship_knockback");
  scripts\engine\utility::waitframe();
  level.player playSound("scn_phparade_dropship_expl_lr");
  level._id_D03A scripts\engine\utility::delaythread(2.5, ::_id_5EEA);
  level.player _meth_823B(var_3, "tag_player");
  level notify("aatis_fires");
  level._id_D267 delete();
  var_4 = scripts\sp\utility::_id_107EA("parade_attack_pilot", 1);
  var_4 scripts\sp\utility::_id_B14F();
  var_4._id_1FBB = "pilot";
  var_5 = scripts\engine\utility::array_add(level.allies, var_4);
  level._id_5D72 = var_5;

  foreach(var_7 in var_5) {
    var_7 linkTo(level._id_D03A, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_7 show();
  }

  level._id_D03A clearanim(%vh_dropship_front_door_right_open, 0.05);
  var_5 = scripts\engine\utility::array_add(var_5, level._id_D03A);
  var_5 = scripts\engine\utility::array_add(var_5, var_3);
  level notify("aatis_fires");

  if(isDefined(level._id_CB8E))
    level._id_CB8E delete();

  foreach(var_10 in level.allies)
  var_10 unlink();

  level._id_D03A scripts\sp\anim::_id_1F2C(var_5, "attack_dropship_knockback");
  level._id_D03A._id_4D94._id_4348 solid();
  level.player unlink();
  var_3 delete();
  level notify("pilot_dead");
  level._id_D03A thread _id_0BBF::_id_F457(1);
  level._id_D03A thread scripts\sp\anim::_id_1EE7(level._id_5D72, "dropship_attack_idle");
  level._id_D03A _id_0E46::_id_48C4("tag_player", (15, 15, 0), undefined, undefined, undefined, undefined, 1);
  level._id_D03A waittill("trigger");
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 linkTo(level._id_D03A, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player _meth_823B(level._id_D267, "tag_player");
  level._id_D03A thread scripts\sp\anim::_id_1F35(level._id_D267, "attack_cockpit_getin");
  wait 2;
  setomnvar("ui_dropship_active", 1);
  scripts\engine\utility::flag_set("dropship_spin_stop");
  thread _id_C8C0();
}

_id_C8C3() {
  var_0 = level.player;
  var_1 = level.allies["salter"];
  var_2 = level.allies["eth3n"];
  var_3 = level.allies["admiral"];
  var_4 = [var_1, var_2, var_3];
  var_5 = level._id_D03A;
  var_0 scripts\sp\utility::_id_10350("phparade_plt_approachingthev");
  var_5 notify("stop_dropship_idles");
  var_5 scripts\sp\anim::_id_1F2C(var_4, "attack_dropship");
}

_id_5EEA() {
  if(!getdvarint("dropship_spin")) {
    return;
  }
  thread scripts\engine\utility::play_loop_sound_on_entity("dropship_helicopter_dying_loop");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("dropship_crash_final_alarm");
  var_0 = level._id_D03A scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_D03A, "tag_origin", (350, -750, 100), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("dropship_spin_door_smoke"), var_0, "tag_origin");
  self.angles = self.angles + (-5, 0, 0);
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_2 = anglesToForward(self.angles);
  self linkTo(var_1);

  while(!scripts\engine\utility::flag("dropship_spin_stop")) {
    var_1 rotateTo(var_1.angles + (0, -2, 0), 0.05);
    wait 0.05;
  }

  level._id_D03A unlink();
  var_1 delete();
  var_0 delete();
  scripts\engine\utility::flag_wait("dropship_player_controlled_begin");
  level.player scripts\engine\utility::stop_loop_sound_on_entity("dropship_crash_final_alarm");
  scripts\engine\utility::stop_loop_sound_on_entity("dropship_helicopter_dying_loop");
}

_id_C8C0() {}

_id_C8BF() {
  thread _id_C8C0();
}

_id_C8D7() {
  setsaveddvar("sm_sunSampleSizeNear", 27);
  level._id_D03A = _id_0BBF::_id_106B8("parade_dropship_plane", undefined, "rear");
  _id_D0EC();
}

_id_C8D6() {
  level.player playSound("scn_phparade_dropship_dive_lr");
  thread _id_C8D4();
  var_0 = getvehiclenode("proto_parade_dropship_plane_path", "targetname");
  level._id_D03A scripts\sp\vehicle::_id_2471(var_0);
  level._id_D03A._id_4D94._id_4348 notsolid();

  if(getdvarint("dropship_control")) {
    scripts\engine\utility::flag_wait("dropship_player_controlled_begin");
    level._id_D03A notify("stop_loop");

    if(isDefined(level._id_5D72))
      scripts\engine\utility::array_thread(level._id_5D72, scripts\sp\maps\pearlharbor\pearlharbor_util::_id_518F);

    level.player unlink();
    level._id_D267 unlink();
    level._id_D267 delete();
    level._id_D03A delete();
    _id_0BDC::_id_A226();
    setomnvar("ui_hide_hud", 1);
    var_1 = scripts\sp\vehicle::_id_1080C("player_dropship");
    _id_0BDC::_id_10CD1(var_1);
    _id_0BDC::_id_A153(1);
    _id_0BDC::_id_A155(1);
    _id_0BDC::_id_A14A(1);
    _id_0BDC::_id_A149(1);
    var_2 = spawn("script_model", var_1.origin);
    var_2.angles = var_1.angles;
    var_2 setModel("veh_mil_air_un_dropship_hero");
    var_2 attach("veh_mil_air_un_dropship_hero_interior", "tag_connect");
    var_2 _id_0BDC::_id_A25B(0, "j_mainroot_ship", (-190, 20, -132), (0, 0, 0));
    level._id_D03A = var_2;
    var_1 hide();
    var_1 thread _id_5DE9();
    _id_0BDC::_id_A302(0.6, 0);
    var_3 = getcsplineid("dropship_lookat_start");
    var_4 = getcsplinepointposition(var_3, 1);
    var_5 = getcsplinepointtangent(var_3, 1);
    var_6 = spawnVehicle("veh_mil_air_un_jackal_02", "lookat_jackal", "dropship_spaceship", var_4, var_5);
    var_6 _meth_8184();
    var_6 notsolid();
    var_6 _id_0C24::_id_10A49();
    var_6 _meth_8479(var_3);
    var_6 _meth_847B(0);
    _id_0BDC::_id_D165(var_6, 0.45, 0.8, 0);
    var_3 = getcsplineid("dropship_moveto_start");
    var_4 = getcsplinepointposition(var_3, 0);
    var_5 = getcsplinepointtangent(var_3, 0);
    var_7 = spawnVehicle("veh_mil_air_un_jackal_02", "moveto_jackal", "dropship_spaceship", var_4, var_5);
    var_7 _meth_8184();
    var_7 notsolid();
    var_7 _id_0C24::_id_10A49();
    var_7 _meth_8479(var_3);
    var_7 _meth_847B(0);
    _id_0BDC::_id_D16C(var_7, 0.45, 0.8, 0);
    var_7 thread _id_D03B();
    thread _id_5DC3(0.15);
    scripts\engine\utility::flag_wait("enemy_capships_entry");
    scripts\engine\utility::flag_wait("dropship_start_crash");
    var_1 _id_0BDC::_id_F358("instant");
    var_1 _id_0BDB::_id_F51F();
    var_6 delete();
    _id_0BDC::_id_A228();
    setomnvar("ui_hide_hud", 0);
    var_0 = getvehiclenode("pa_dropship_crash_start", "script_noteworthy");
    level._id_D03A = scripts\sp\vehicle::_id_1080C("parade_dropship_plane");
    level._id_D03A scripts\sp\utility::_id_65DD("thrusterEffects");
    level._id_D03A vehicle_teleport(var_0.origin, var_0.angles);
    var_8 = level._id_D03A scripts\engine\utility::spawn_tag_origin();
    var_8 linkTo(level._id_D03A, "tag_origin", (410, -20, 105), (0, 0, 0));
    level.player _meth_823B(var_8, "tag_origin");
    level._id_D03A scripts\sp\vehicle::_id_2471(var_0);
  }

  thread _id_C8D3();
}

_id_C8D4() {
  var_0 = level.player;
  var_1 = level.allies["salter"];
  var_2 = level.allies["eth3n"];
  var_3 = level.allies["admiral"];
  var_1 scripts\sp\utility::_id_10347("phparade_slt_keepusintheair");
  scripts\engine\utility::flag_wait("dropship_player_controlled_begin");
  var_0 scripts\sp\utility::_id_10350("phparade_plr_howbad");
  wait 0.5;
  var_1 scripts\sp\utility::_id_10346("phparade_slt_wentstraightthr");
  wait 0.5;
  var_2 scripts\sp\utility::_id_10346("phparade_slt_ethan");
  wait 1;
  var_2 scripts\sp\utility::_id_10346("phparade_eth_admiralissecure");
  var_3 scripts\sp\utility::_id_10346("phparade_adm_getustotheaatis");
  scripts\engine\utility::flag_wait("dropship_start_crash_flak");
  wait 1;
  var_0 scripts\sp\utility::_id_10350("phparade_plr_ahshit");
  wait 1;
  var_0 scripts\sp\utility::_id_10350("phparade_plr_brace");
}

_id_C8D5() {
  if(isDefined(self.script_prefab_exploder))
    level notify("killexplodertridgers" + self.script_prefab_exploder);

  scripts\engine\utility::trigger_off();
  scripts\engine\utility::flag_wait("dropship_player_controlled_begin");
  scripts\engine\utility::trigger_on();

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level._id_D127) {
      break;
    }
  }

  if(isDefined(self.script_prefab_exploder))
    thread scripts\sp\trigger::exploder_load(self);

  if(isDefined(self._id_ED9E))
    scripts\engine\utility::flag_set(self._id_ED9E);

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "geo_mover")
      thread scripts\sp\geo_mover::_id_12764(self);
    else if(self.script_parameters == "spawner")
      thread _id_0B77::_id_12797(self);
  }
}

_id_D03B() {
  self endon("death");
  var_0 = 400;

  for(;;) {
    wait 0.05;
    var_1 = length(self.spaceship_vel);
    var_2 = var_1 / var_0;
    _id_0BDC::_id_A301(var_2, 0);
  }
}

_id_73B6() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  var_0 _id_0E46::_id_48C4("tag_origin", undefined, "Follow", 360, 999999999, 999999999, 1);
}

_id_5E5C(var_0) {
  self notify("new_dropship_path");
  self endon("new_dropship_path");
  thread _id_5DC3(0.1);
  var_1 = 125;
  self vehicle_setspeedimmediate(var_1, var_1, var_1);
  self sethoverparams(0, 0, 0);
  self setmaxpitchroll(0, 30);
  self setyawspeedbyname("fast");
  self setvehgoalpos(self.origin, 1);
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_4 = vectorNormalize(var_3.origin - var_2.origin);
  var_5 = 1000;
  var_6 = var_2.origin;
  var_7 = var_6[2];

  for(;;) {
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = self.origin;
    var_10 = var_10 + var_9 * var_5;
    var_6 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, self.origin);
    var_11 = vectorNormalize(var_3.origin - var_10);

    if(vectordot(var_4, var_11) < 0) {
      var_2 = var_3;

      if(!isDefined(var_2.target)) {
        break;
      }

      var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      var_4 = vectorNormalize(var_3.origin - var_2.origin);

      if(isDefined(var_2._id_ED9E))
        scripts\engine\utility::flag_set(var_2._id_ED9E);
    }

    var_7 = var_6[2];
    var_12 = level.player getnormalizedmovement();
    var_12 = var_12 * -15;
    var_13 = var_8 + var_12;
    var_14 = anglesToForward(var_13);
    var_15 = self.origin + var_14 * var_5;
    var_15 = (var_15[0], var_15[1], var_7);
    var_16 = var_2.radius;

    if(distance2d(var_15, var_6) > var_16) {
      var_17 = vectortoangles(var_4);
      var_18 = anglestoright(var_17);
      var_19 = anglestoright(self.angles);
      var_20 = undefined;

      if(vectordot(var_11, var_18) > 0)
        var_20 = var_18;
      else
        var_20 = var_18 * -1;

      var_15 = var_15 + var_20 * var_5;
    }

    self setvehgoalpos(var_15, 0);
    wait 0.05;
  }

  level.player notify("stop_earthquake_loop");
}

_id_5DC3(var_0) {
  level.player notify("stop_earthquake_loop");
  level.player endon("stop_earthquake_loop");

  for(;;) {
    earthquake(var_0, 1, level.player.origin, 999999);
    wait 0.05;
  }
}

_id_5DE9() {
  self endon("death");
  level endon("stop_dropship_crash_flag");
  scripts\engine\utility::flag_wait("dropship_start_crash_flak");
  level.player scripts\engine\utility::delaycall(3.5, ::playsound, "scn_phparade_dropship_crash_lr");
  level.player notify("stop_earthquake_loop");

  for(;;) {
    playFX(scripts\engine\utility::getfx("dropship_crash_flak"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    var_0 = (0, self.angles[1], 0);
    var_1 = anglesToForward(var_0);
    var_2 = anglestoright(var_0);
    var_3 = self.origin + var_1 * randomintrange(1000, 2000);
    var_4 = self.origin + var_2 * randomintrange(-2000, 2000);
    wait(randomfloatrange(0.05, 0.1));
  }
}

_id_12B57() {
  self waittill("reached_end_node");
  scripts\engine\utility::flag_wait("un_destroyer_water_crash_start");
  showmayhem("un_destroyer_water_crash_mayhem");
  playmayhem("un_destroyer_water_crash_mayhem");
  level.player scripts\engine\utility::delaythread(3.0, scripts\engine\utility::play_sound_in_space, "scn_phparade_capital_crash_eng", (19708, 17205, -34501));
  level.player scripts\engine\utility::delaythread(6.0, scripts\engine\utility::play_sound_in_space, "scn_phparade_capital_crash_impact", (19708, 17205, -34501));
  self delete();
}

_id_11741() {
  var_0 = (13237, 6277, -33224);
  var_1 = (0, 55, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  level.player _meth_823B(var_2);
  showmayhem("un_destroyer_water_crash_mayhem");
  playmayhem("un_destroyer_water_crash_mayhem");
}

_id_C84A() {
  self endon("reached_end_node");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self, "fx_entryburn_1", (0, 0, 0), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_0, "tag_origin");
  thread _id_52E4();
  _id_0B0F::_id_1D84();

  for(;;) {
    self waittill("noteworthy", var_1);
    var_2 = strtok(var_1, " ");

    foreach(var_4 in var_2) {
      switch (var_4) {
        case "blast":
          break;
        case "stop_entry_fireball":
          stopFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a"), var_0, "tag_origin");
          self notify("stop_entryburn_fx");
          break;
        case "fire_missiles":
          var_5 = self._id_4BF7;
          var_6 = scripts\engine\utility::getStructArray(var_5.target, "targetname");
          var_7 = _id_0B0F::_id_39D3(var_6);
          thread _id_0B0F::_id_3987(var_7["l"], [1, 3], [0.25, 0.5]);
          thread _id_0B0F::_id_3987(var_7["r"], [1, 3], [0.25, 0.5]);
          break;
      }
    }
  }
}

_id_52E4() {
  self endon("stop_entryburn_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("enemy_entry_fireball_base_a_trail"), self, "fx_entryburn_1");
    wait 0.05;
  }
}

_id_1171D() {
  var_0 = getvehiclenode("debug_falling_capship_spot", "script_noteworthy");
  level._id_D03A = scripts\sp\vehicle::_id_1080C("parade_dropship_plane");
  var_1 = level._id_D03A scripts\engine\utility::spawn_tag_origin();
  level._id_D03A linkTo(var_1);
  _id_D0EC();
  var_1.origin = var_0.origin;
  var_1.angles = (-15, 30, 0);
  scripts\sp\vehicle::_id_1080F("pa_falling_capships");
}

_id_C8D3() {}

_id_C8D2() {
  thread _id_C8D3();
}

_id_C8C7() {
  var_0 = getvehiclenode("pa_dropship_crash_start", "script_noteworthy");
  level._id_D03A = scripts\sp\vehicle::_id_1080C("parade_dropship_plane");
  _id_D0EC();
  level._id_D03A scripts\sp\vehicle::_id_2471(var_0);
}

_id_C8C6() {
  level._id_D03A scripts\engine\utility::waittill_any("reached_end_node");
  _id_0BDC::_id_A226();
  setomnvar("ui_dropship_active", 0);
  setomnvar("ui_hide_hud", 1);
  level.player clearclienttriggeraudiozone(3.0);
  thread _id_C8C5();

  if(getdvarint("dont_load_nextmission", 0) == 0)
    scripts\sp\utility::_id_BF95();
  else
    level waittill("forever");
}

_id_C8C5() {}

_id_C8C4() {
  thread _id_C8C5();
}

_id_D0EC() {
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D03A thread scripts\sp\anim::_id_1EEA(level._id_D267, "dropship_cockpit_idle");
  level._id_D267 linkTo(level._id_D03A, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player _meth_823B(level._id_D267, "tag_player");
  level.player setstance("stand");
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
}