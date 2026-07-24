/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_hill_dropship.gsc
*********************************************************************/

_id_8F57() {
  level._id_2CF7 = [];
  setdvarifuninitialized("hill_dropship_debug", 0);
  scripts\engine\utility::flag_init("hill_dropship_boss_spawned");
  scripts\engine\utility::flag_init("hill_dropship_boss_dialogue_start");
  scripts\engine\utility::flag_init("hill_dropship_boss_intro_done");
  scripts\engine\utility::flag_init("hill_player_hacking_dropship");
  scripts\engine\utility::flag_init("hill_player_hacked_dropship");
  scripts\engine\utility::flag_init("hill_dropship_boss_dead");
  scripts\engine\utility::flag_init("hill_dropship_kill_player");
  getEnt("hill_dropship_boss", "targetname") scripts\sp\utility::_id_1747(::_id_8F56);
  scripts\sp\utility::_id_22C9("boss_dropship_alllies", ::_id_2CE5);
}

_id_8F5C() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_combat");
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_combat", var_0);
  scripts\sp\utility::_id_22CD("hill_combat_start_allies");
  thread scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_4307();
  scripts\sp\vehicle::_id_1080C("hill_dropship_boss");
  scripts\sp\utility::_id_15F5("hill_combat_color_start_trig");
  scripts\sp\utility::_id_15F5("dropship_boss_allies_right_colortrig");
  getEnt("hill_combat_color_start_trig", "targetname") delete();
  getEnt("hill_mg_dropship_trig", "script_noteworthy") delete();
  scripts\sp\utility::_id_228A(getEntArray("hill_running_triggers", "script_noteworthy"));
}

_id_8F56() {
  self endon("dropship_boss_killed");
  level.player endon("death");
  scripts\engine\utility::flag_set("hill_dropship_boss_spawned");
  level._id_8805 = "phstreets_hack_robot_on_dropship ";
  level._id_5D81 = self;
  level._id_2CDE = scripts\engine\utility::getStruct("dropship_default_position", "script_noteworthy");
  level._id_5D81._id_4BC2 = level._id_2CDE;
  level._id_5D81._id_11538 = undefined;
  level._id_5D81._id_5D0A = [];
  level._id_2CD9 = "center";
  level._id_2CFE = scripts\engine\utility::spawn_script_origin();
  level._id_2CFE._id_1155F = level.player;
  level._id_2CF5 = scripts\engine\utility::spawn_script_origin();
  level._id_5D81 scripts\engine\utility::delaythread(1.5, scripts\sp\utility::play_sound_on_entity, "scn_phstreets_hill_dropship_vehicle_flyin");
  self._id_4074 = [];
  scripts\sp\utility::_id_65E0("dropping_c6s");
  scripts\sp\utility::_id_65E0("allow_death");
  scripts\sp\utility::_id_65E1("allow_death");
  self setneargoalnotifydist(128);
  self._id_1FBB = "hacked_dropship";
  scripts\sp\vehicle::_id_8441();
  self dontcastshadows();
  self.team = "axis";
  self makeentitysentient("axis");
  _id_F8D5();
  thread _id_5D83();
  thread _id_2CF0();
  thread _id_2CF1();
  level._id_5D81._id_19EE = level._id_5D81 scripts\engine\utility::spawn_tag_origin();
  level._id_5D81._id_19EE.origin = level._id_5D81._id_19EE.origin + (0, 0, 500);
  level._id_5D81._id_19EE linkTo(level._id_5D81);
  self._id_7441 = spawn("script_model", self.origin);
  self._id_7441 setModel("veh_mil_air_ca_dropship_severed_front");
  self._id_7441 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self._id_7441 hide();
  self._id_4074[self._id_4074.size] = self._id_7441;
  thread _id_5D7D();
  var_0 = scripts\sp\vehicle::_id_1080D("dropship_boss_entrance_center");
  self linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 notsolid();
  var_0 hide();
  scripts\engine\utility::delaythread(0.5, ::_id_2CEF);
  var_0 waittill("start_targeting");
  scripts\engine\utility::flag_set("hill_dropship_boss_dialogue_start");
  var_1 = scripts\engine\utility::spawn_script_origin((74156, 48012, -33893));
  self._id_11538 = var_1;
  var_2 = self.mgturret[0];
  var_2 setmode("manual");
  var_2 setleftarc(180);
  var_2 setrightarc(120);
  var_2 settoparc(65);
  var_2 setbottomarc(65);
  var_2 settargetentity(level._id_2CFE, (0, 0, 32));
  _id_2CEE();
  thread _id_2CFD();
  thread _id_2CF2();
  thread _id_2CD8();
  thread _id_2CE9();
  var_2 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_035A(undefined, undefined, undefined, undefined, undefined, 0.165);
  thread _id_0BBD::_id_5DCE(::_id_CA92);
  thread _id_F993();
  thread _id_2CEA();
  var_0 waittill("reached_end_node");
  scripts\engine\utility::flag_set("hill_dropship_boss_intro_done");
  self unlink();
  self vehicle_teleport(self.origin, self.angles);
  thread _id_2CDA();
  thread _id_2CDC();
  _id_2CDD();
  var_0 delete();
  var_3 = getEntArray("dropship_boss_movement_triggers", "targetname");
  scripts\engine\utility::array_thread(var_3, ::_id_2CF8);
  thread _id_2CF9();
  scripts\sp\utility::_id_65E3("dropping_c6s");
  scripts\sp\utility::_id_65E8("dropping_c6s");
  self._id_11538 = undefined;
  var_1 delete();
}

_id_5D7D() {
  var_0 = scripts\engine\utility::getStruct("hill_dropship_crash_struct", "script_noteworthy");
  self._id_0056 = scripts\sp\utility::_id_10639("dropship_rear");
  self._id_0056 hide();
  self._id_4074[self._id_4074.size] = self._id_0056;
  var_0 thread scripts\sp\anim::_id_1EC3(self._id_0056, "rear_crash");
  self waittill("break_up");
  self._id_0056 show();
  var_0 scripts\sp\anim::_id_1F35(self._id_0056, "rear_crash");
}

_id_2CF8() {
  level._id_5D81 endon("death");
  level._id_5D81 endon("dropship_boss_killed");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

  for(;;) {
    self waittill("trigger");

    if(!isDefined(level._id_5D81._id_24C0) || isDefined(level._id_5D81._id_24C0) && level._id_5D81._id_24C0) {
      continue;
    }
    if(level._id_5D81 scripts\sp\utility::_id_65DB("dropping_c6s")) {
      continue;
    }
    level._id_5D81._id_4BC2 = var_0;
    level._id_5D81 setvehgoalpos(var_0.origin, 1);
    self notify("new_goal");

    if(isDefined(self.script_parameters)) {
      level._id_2CD9 = self.script_parameters;
    } else {
      level._id_2CD9 = "center";
    }

    while(level.player istouching(self)) {
      wait 0.15;
    }

    if(level._id_5D81 scripts\sp\utility::_id_65DB("dropping_c6s")) {
      level._id_5D81 scripts\sp\utility::_id_65E8("dropping_c6s");
    }

    self notify("new_goal");
    level._id_5D81._id_4BC2 = level._id_2CDE;
    level._id_5D81 setvehgoalpos(level._id_2CDE.origin, 1);
  }
}

_id_2CF9() {
  level._id_5D81 endon("death");
  level._id_5D81 endon("dropship_boss_killed");

  for(;;) {
    wait 0.15;

    if(scripts\sp\utility::_id_65DB("dropping_c6s")) {
      continue;
    }
    var_0 = level._id_5D81._id_4BC2;
    _id_2CFA(var_0);
  }
}

_id_2CFA(var_0) {
  self endon("dropping_c6s");
  self endon("new_goal");
  self endon("dropship_boss_killed");

  while(distance(self.origin, var_0.origin) < 30) {
    wait 0.15;
  }

  for(;;) {
    var_1 = anglestoright(var_0.angles);
    var_2 = randomintrange(60, 80);
    var_3 = var_0.origin + var_1 * var_2;
    level._id_5D81 setvehgoalpos(var_3, 1);
    _id_8F59(var_3, 24, (0, 1, 0), 25);
    scripts\engine\utility::waittill_any("near_goal", "goal");
    wait(randomfloatrange(3, 6));
    var_4 = var_1 * -1;
    var_2 = randomintrange(60, 80);
    var_3 = var_0.origin + var_4 * var_2;
    level._id_5D81 setvehgoalpos(var_3, 1);
    _id_8F59(var_3, 24, (0, 1, 0), 25);
    scripts\engine\utility::waittill_any("near_goal", "goal");
    wait(randomfloatrange(3, 6));
  }
}

_id_2CDA() {
  level._id_5D81 endon("death");
  level._id_5D81 endon("dropship_boss_killed");

  for(;;) {
    if(scripts\sp\utility::_id_65DB("thruster_near_death")) {
      break;
    }

    var_0 = level._id_5D81._id_4BC2;
    var_1 = var_0 scripts\sp\utility::_id_7A96();

    if(isDefined(var_1)) {
      scripts\sp\utility::_id_65E1("dropping_c6s");
      self notify("dropping_c6s");
      thread scripts\engine\utility::play_loop_sound_on_entity("ph_dropship_alarm_a");
      level._id_5D81 setvehgoalpos(var_1.origin, 1);
      var_2 = anglesToForward(var_1.angles);
      var_3 = var_1.origin + var_2 * 1000;
      _id_2CF3(var_3);
      var_4 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
      scripts\engine\utility::waittill_any("near_goal", "goal");
      scripts\sp\vehicle_code::_id_13804();
      _id_3364(3, var_4);
      scripts\sp\utility::_id_178D(scripts\engine\utility::_timeout, 3);
      scripts\sp\utility::_id_178D(scripts\sp\utility::_id_65E3, "thruster_near_death");
      scripts\sp\utility::_id_57D6();
      thread scripts\engine\utility::stop_loop_sound_on_entity("ph_dropship_alarm_a");
      level._id_5D81 setvehgoalpos(var_0.origin, 1);
      scripts\engine\utility::waittill_any("near_goal", "goal");
      _id_2CF4();
      scripts\sp\utility::_id_65DD("dropping_c6s");
    }

    wait(randomintrange(15, 30));
  }
}

_id_2CFD() {
  self endon("death");
  self endon("dropship_boss_killed");
  var_0 = level.player;
  var_1 = level.player.origin;

  for(;;) {
    var_2 = 0;
    var_3 = scripts\common\trace::ray_trace(self.origin, level.player getEye(), self);

    if(isDefined(var_3["entity"]) && var_3["entity"] == level.player) {
      var_2 = 1;
    }

    if(isDefined(self._id_11538)) {
      var_0 = self._id_11538;
      var_1 = self._id_11538.origin;
    } else if(_id_FFA7(var_2)) {
      var_0 = level.player;

      if(var_2) {
        var_1 = level.player.origin;
      }
    } else if(!isDefined(var_0) || !isalive(var_0) || var_0 == level.player) {
      var_0 = _id_2CE7();

      if(isDefined(var_0)) {
        var_1 = var_0.origin;
      }
    }

    if(!isDefined(var_0)) {
      var_4 = level.player;

      if(scripts\engine\utility::flag("hill_player_hacking_dropship") && isDefined(level.player._id_6AF9)) {
        var_4 = level.player._id_6AF9;
      }

      var_0 = var_4;
      var_1 = var_4.origin;
    }

    level._id_2CFE._id_1155F = var_0;
    level._id_2CFE.origin = var_1;
    _id_8F59(level._id_2CFE.origin, 24, (1, 0, 0), 3);
    wait 0.15;
  }
}

_id_2CF2() {
  self endon("death");
  self endon("dropship_boss_killed");

  for(;;) {
    var_0 = level._id_2CFE.origin;

    if(isDefined(level._id_2CF6)) {
      var_0 = level._id_2CF6;
    }

    level._id_2CF5.origin = var_0;
    _id_8F59(level._id_2CF5.origin, 20, (0, 0, 1), 3);
    wait 0.15;
  }
}

_id_2CEE() {
  self sethoverparams(175, 50, 5);
}

_id_2CF3(var_0) {
  level._id_2CF6 = var_0;
}

_id_2CF4() {
  level._id_2CF6 = undefined;
}

_id_FFA7(var_0) {
  if(scripts\engine\utility::flag("hill_player_hacking_dropship")) {
    return 0;
  }

  if(scripts\engine\utility::flag("hill_dropship_kill_player")) {
    return 1;
  }

  if(!isDefined(level._id_5D81._id_24C0)) {
    level._id_5D81._id_24C0 = 3;
  } else {
    level._id_5D81._id_24C0 = level._id_5D81._id_24C0 - 0.15;
  }

  if(!var_0) {
    if(isDefined(level._id_5D81._id_A8FF)) {
      if(gettime() - level._id_5D81._id_A8FF >= 3) {
        level._id_5D81._id_24C0 = undefined;

        if(gettime() - level._id_5D81._id_A8FF < 7000) {
          return 1;
        } else {
          return 0;
        }
      }
    }
  } else
    level._id_5D81._id_A8FF = gettime();

  if(level._id_5D81._id_24C0 <= 0) {
    level._id_5D81._id_24C0 = 0;
    return 1;
  }

  return 0;
}

_id_2CE7() {
  var_0 = level._id_2CF7[level._id_2CD9];

  if(!isDefined(var_0)) {
    return undefined;
  }

  return scripts\engine\utility::random(var_0);
}

_id_2CF1() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  playFXOnTag(scripts\engine\utility::getfx("vfx_enemy_dropship_gunner_light"), var_0, "tag_origin");
  self._id_4074[self._id_4074.size] = var_0;
}

_id_2CE8() {
  var_0 = 256;
  var_1 = 64;
}

_id_2CEA() {
  self endon("dropship_boss_killed");
  level.player endon("death");
  level endon("jackal_v_dropship");
  var_0 = self.mgturret[0];

  for(;;) {
    level.player scripts\sp\utility::_id_65E3("is_controlling_robot");

    if(level._id_880A != self._id_8854._id_45D1) {
      level.player scripts\sp\utility::_id_65E8("is_controlling_robot");
      continue;
    }

    if(isDefined(self._id_8854._id_45D1)) {
      self._id_8854._id_45D1._id_215D hide();
      self._id_8854._id_45D1 delete();
      self._id_6B54 = scripts\engine\utility::array_remove(self._id_6B54, self._id_8854._id_45D1);
    }

    scripts\engine\utility::flag_set("hill_player_hacking_dropship");
    scripts\engine\utility::flag_set("hill_player_hacked_dropship");
    self notify("stop_engine_damage_manager");
    thread _id_2CEB();
    enableforcednosunshadows();
    level._id_1024F = 1;
    scripts\engine\utility::flag_wait("hack_hud_control_outro_finished");
    disableforcedsunshadows();
    earthquake(0.3, 0.3, level.player.origin, 100);
    level.player playRumbleOnEntity("damage_heavy");
    scripts\sp\utility::_id_228A(scripts\engine\utility::array_removeundefined(level._id_5D81._id_5D0A));
    scripts\sp\utility::_id_22A4(self._id_6B54, "player_hack_faded_out");
    scripts\engine\utility::flag_clear("hill_player_hacking_dropship");
    break;
  }

  level.player clearclienttriggeraudiozone(0.4);
  thread _id_CA92();
}

_id_2CEB() {
  thread _id_2CED();
  thread scripts\sp\utility::_id_10350("phstreets_plr_checkhacking");

  foreach(var_1 in self._id_6B54) {
    var_1 = var_1 _id_2CFB(self);
    var_1 _id_0E29::_id_19CA();
    var_1 thread _id_2CEC(self);
    wait 0.05;
  }

  var_3 = self._id_879D;
  wait 0.5;

  if(isDefined(var_3[0])) {
    var_3[0] thread _id_3363(undefined, 2);
  }

  wait 2.5;

  if(isDefined(var_3[1])) {
    var_3[1] thread _id_3363(undefined, 2);
  }
}

_id_2CFB(var_0) {
  var_1 = self._id_1FEB;
  var_2 = self._id_215D;
  var_3 = getspawner("c6_dropship_hacked_spawner", "targetname");
  var_3.count = 999;
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4 dontcastshadows();
  _id_0E29::_id_877F(var_4);
  var_4._id_1FBB = "c6";
  var_0._id_6B54 = scripts\engine\utility::array_remove(var_0._id_6B54, self);
  var_0._id_6B54 = scripts\engine\utility::array_add(var_0._id_6B54, var_4);
  self delete();
  var_4._id_1FEB = var_1;
  var_4._id_215D = var_2;
  var_1 thread scripts\sp\anim::_id_1EEA(var_4, "boss_dropship_c6_idle");
  var_4 linkTo(var_1);
  return var_4;
}

_id_2CEC(var_0) {
  level endon("hack_hud_control_outro_finished");
  self endon("c6_drop");
  self setCanDamage(1);
  scripts\sp\utility::_id_F2A8(1);
  self waittill("death");
  var_0._id_6B54 = scripts\engine\utility::array_remove(var_0._id_6B54, self);
  self._id_1FEB notify("stop_loop");
  self _meth_83A1();
  scripts\sp\maps\phstreets\phstreets_anim::_id_C11B();
}

_id_2CED() {
  level.player endon("hack_suicide");
  var_0 = 9000;
  var_1 = gettime();

  while(gettime() - var_1 < var_0) {
    if(self._id_6B54.size <= 3) {
      break;
    }

    wait 0.1;
  }

  _id_0E29::_id_87A1();
}

_id_2CF0() {
  self endon("death");
  self endon("dropship_boss_killed");

  for(;;) {
    scripts\engine\utility::flag_wait("hill_dropship_kill_player");
    self._id_11538 = level.player;

    while(scripts\engine\utility::flag("hill_dropship_kill_player")) {
      wait(randomfloatrange(0.15, 0.35));
      var_0 = self.mgturret[0];
      var_1 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(level.player.origin, 128, 64);
      bullettracer(var_0 gettagorigin("tag_flash"), var_1, "sdf_dropship_turret_energy", 1);
      var_2 = randomintrange(15, 25);
      radiusdamage(level.player.origin, 512, var_2, var_2, self);
    }

    self._id_11538 = undefined;
  }
}

_id_CA92() {
  if(isDefined(self._id_4E2B)) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("dropping_c6s")) {
    var_0 = self.origin + (0, 0, 150);
    level._id_5D81 setvehgoalpos(var_0);
    level._id_5D81 vehicle_setspeedimmediate(50);
    self waittill("near_goal");
  }

  self._id_4E2B = 1;
  var_1 = scripts\engine\utility::getStruct("hill_dropship_crash_struct", "script_noteworthy");
  thread _id_0BBD::_id_CD70(var_1, "custom_death", 11.3);
}

_id_2CDD() {
  var_0 = self.mgturret[0];
  var_0 settargetentity(level._id_2CFE, (0, 0, 32));
  self setlookatent(level._id_2CF5);
}

_id_5D83() {
  self waittill("custom_death_begin");
  thread _id_5D87();
  scripts\engine\utility::delaythread(8.75, _id_0BBE::_id_A61F);
  scripts\engine\utility::delaythread(8.75, scripts\sp\utility::_id_65DD, "thrusterEffects");
  thread _id_5D84();
  thread _id_0E29::_id_87D1(self._id_8854);
  thread _id_0BBE::_id_A61E(self._id_65CD["j_wing_mid_ri"]._id_11867);
  thread _id_5D82();
  level._id_8805 = undefined;
  self notify("dropship_boss_killed");
  self notify("stop_engine_damage_manager");
  self.mgturret[0] notify("stop_fire");
  self._id_5D85 = 1;

  if(isDefined(self._id_8854)) {
    self._id_8854 delete();
  }

  level._id_2CFE delete();
  level._id_2CF5 delete();
  level._id_1024F = undefined;
  scripts\engine\utility::flag_set("hill_dropship_boss_dead");
  self waittill("custom_death_end");
  self delete();
}

_id_5D87() {
  var_0 = 8250;
  var_1 = gettime();

  while(gettime() - var_1 < var_0) {
    level.player playRumbleOnEntity("grenade_rumble");
    earthquake(0.1, 0.2, level.player.origin, 200);
    wait(randomfloatrange(0.1, 0.3));
  }
}

_id_5D84() {
  earthquake(0.45, 1, self.origin, 9999);
  level.player playRumbleOnEntity("heavy_1s");
  wait 0.25;
  var_0 = gettime();
  var_1 = 8500;

  while(gettime() - var_0 < var_1) {
    var_2 = randomfloatrange(0.1, 0.15);
    earthquake(var_2, 1, self.origin, 9999);
    wait 0.05;
  }

  earthquake(0.75, 1.25, self.origin, 9999);
  level.player playRumbleOnEntity("heavy_1s");
}

_id_5D82() {
  playworldsound("scn_phstreets_hill_dropship_explo", self.origin);
  wait 0.3;
  thread scripts\sp\utility::play_sound_on_entity("scn_phstreets_hill_dropship_crashing");
  self waittill("custom_death_end");
  earthquake(0.45, 0.5, level.player.origin, 100);
}

_id_2CD8() {
  var_0 = newhudelem();
  var_0 setshader("blank");
  var_0 settargetEnt(self);
  var_0 setwaypoint(1, 1, 0, 0);
  var_0 setwaypointiconoffscreenonly();

  while(isDefined(self) && isalive(self)) {
    var_1 = cos(40);

    while(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_1) || scripts\engine\utility::flag("jackal_streak_spawned")) {
      if(isDefined(self._id_5D85)) {
        break;
      }

      wait 0.1;
    }

    if(isDefined(self._id_5D85)) {
      break;
    }

    thread scripts\sp\utility::_id_918B("ar_callouts_robotdropship", 1, (0, 0, 0));
    scripts\engine\utility::waittill_any_timeout(7, "dropship_boss_killed", "jackal_streak_spawned");
    scripts\sp\utility::_id_918C();

    if(isDefined(self._id_5D85)) {
      break;
    }

    scripts\engine\utility::waittill_notify_or_timeout("dropship_boss_killed", 10);
  }

  var_0 destroy();
}

_id_2CE9() {
  self endon("dropship_boss_killed");
  level endon("jackal_v_dropship");

  for(;;) {
    wait 0.05;
    var_0 = _id_0E29::_id_87A7();

    if(var_0 == "scanning" || var_0 == "locking" || var_0 == "locked") {
      wait 0.3;
      scripts\sp\utility::_id_9196(0, 0, 0, "hackTarget");

      while(var_0 == "scanning" || var_0 == "locking" || var_0 == "locked") {
        var_0 = _id_0E29::_id_87A7();
        wait 0.05;
      }

      scripts\sp\utility::_id_9193("hackTarget");
    }
  }
}

#using_animtree("script_model");

_id_F8D5() {
  self._id_6B54 = [];
  self._id_879D = [];
  var_0 = scripts\engine\utility::getStructArray("hill_boss_structs", "targetname");
  var_1 = getspawner("c6_bodyonly_dropship_spawner", "targetname");
  var_1._id_EDB3 = 1;
  var_1.count = 9999;

  foreach(var_3 in var_0) {
    if(var_3.script_modelname == "robot_c6") {
      var_4 = scripts\sp\utility::_id_2C17(var_1);
      var_4._id_1FBB = "c6";
      var_4.origin = var_3.origin;
      var_4.angles = var_3.angles;
      var_4 scripts\sp\utility::_id_86E4();
      var_4 dontcastshadows();
      var_4._id_C124 = 1;
      _id_0E29::_id_8795(var_4);
      self._id_4074[self._id_4074.size] = var_4;
      var_5 = spawn("script_model", var_4.origin);
      var_5._id_1FBB = "arm";
      var_5 setModel("veh_mil_air_ca_drop_pod_arm");
      var_5 _meth_83D0(#animtree);
      var_5 notsolid();
      var_5 dontcastshadows();
      var_4._id_215D = var_5;
      self._id_4074[self._id_4074.size] = var_5;
      var_6 = var_4 scripts\engine\utility::spawn_tag_origin();
      var_4._id_1FEB = var_6;
      self._id_4074[self._id_4074.size] = var_6;
      var_7 = [var_4, var_5];
      var_6 thread scripts\sp\anim::_id_1EE7(var_7, "boss_dropship_c6_idle");
      var_4 linkTo(var_6);
      var_5 linkTo(var_6);
      var_6 linkTo(self);

      if(var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("hack")) {
        var_4._id_8854 = 1;
        var_4._id_87CF = (0, 0, -5);
        var_4._id_87BD = 45;
      } else if(var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("hack_dropper")) {
        var_4._id_879C = 1;
        self._id_879D[var_3.script_index] = var_4;
      }

      self._id_6B54[self._id_6B54.size] = var_4;
      scripts\engine\utility::waitframe();
    }
  }
}

_id_F993() {
  self endon("dropship_boss_killed");
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("robot_c6_red");
  var_0 linkTo(self, "tag_origin", (0, 0, 120), (0, 0, 0));
  var_0.health = 500;
  var_0.weapon = "iw7_ar57+ar57scope";
  var_0 hide();
  var_0._id_884B = 9999;
  self._id_8854 = var_0;

  foreach(var_2 in self._id_6B54) {
    if(isDefined(var_2._id_8854)) {
      var_0._id_45D1 = var_2;
      _id_0E29::_id_8795(var_0, var_2);
      break;
    }
  }

  self._id_4074[self._id_4074.size] = var_0;
  level waittill("jackal_v_dropship");
  self._id_4074 = self._id_4074 scripts\engine\utility::array_remove(self._id_4074, var_0);
  var_0 delete();
}

_id_DC16() {
  foreach(var_1 in self._id_6B54) {
    wait(randomfloatrange(1, 3));
    self._id_6B54 = scripts\engine\utility::array_remove(self._id_6B54, var_1);
    playFXOnTag(level._effect["vfx_ph_c6_damage_fall_fire"], var_1, "tag_origin");
    var_1 unlink();
    var_1 startragdoll();
  }
}

_id_3364(var_0, var_1) {
  self endon("death");
  var_2 = scripts\engine\utility::array_randomize(var_1);

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = scripts\engine\utility::random(self._id_6B54);

    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4._id_8854)) {
      continue;
    }
    if(isDefined(var_4._id_879C)) {
      continue;
    }
    self._id_6B54 = scripts\engine\utility::array_remove(self._id_6B54, var_4);
    var_4 thread _id_3363(var_2[var_3]);
    wait(randomfloatrange(0.25, 1));
  }
}

_id_3363(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(!isDefined(self)) {
    return;
  }
  self notify("c6_drop");
  _id_0E29::_id_87D1(self);
  var_3 = self._id_1FEB;
  var_4 = self._id_215D;
  var_5 = self;

  if(!isai(self)) {
    var_6 = getspawner("c6_dropship_spawner", "targetname");
    var_6.count = 999;
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_5 = var_6 scripts\sp\utility::_id_10619(1);
    self delete();
  }

  var_5 scripts\sp\utility::_id_B14F(1);
  var_5 setCanDamage(0);
  var_5 setscriptablepartstate("torso_overload_fx", "overload");
  var_5._id_1FBB = "c6";
  level._id_5D81._id_5D0A = scripts\engine\utility::array_add(level._id_5D81._id_5D0A, var_5);
  _id_0E29::_id_877F(var_5);

  if(scripts\engine\utility::flag("hill_player_hacking_dropship")) {
    var_5 _id_0E29::_id_19CA();
  }

  var_5 linkTo(var_3);
  var_7 = [var_5, var_4];
  var_3 notify("stop_loop");
  var_3 scripts\sp\anim::_id_1F2C(var_7, "boss_dropship_c6_release");

  if(!isDefined(var_5)) {
    return;
  }
  var_8 = var_3 scripts\engine\utility::spawn_script_origin();
  var_5 linkTo(var_8);
  var_5 thread scripts\sp\utility::play_sound_on_entity("droppod_c6_reveal_incoming_dist_far");
  var_8 thread scripts\sp\anim::_id_1EEA(var_5, "boss_dropship_c6_fall");
  var_9 = scripts\sp\utility::_id_864C(var_5.origin);
  var_9 = var_9 + (0, 0, 36);
  var_10 = getstartorigin(var_9, var_5.angles, var_5 scripts\sp\utility::_id_7DC1("boss_dropship_c6_land"));
  var_11 = length((0, 0, var_9[2]) - (0, 0, var_8.origin[2]));
  var_12 = 350;
  var_13 = var_11 / var_12;
  var_8 moveTo(var_9, var_13);
  var_8 waittill("movedone");
  var_8 notify("stop_loop");
  var_8 delete();

  if(!isDefined(var_5)) {
    return;
  }
  var_5 endon("death");
  var_5 scripts\sp\utility::_id_1101B();

  if(isDefined(var_2)) {
    var_5 delete();
  }

  var_5 setCanDamage(1);
  var_5.health = int(var_5.health * 0.25);
  var_14 = spawnStruct();
  var_14.origin = var_9;
  var_14.angles = invertangles(var_5.angles);
  var_14 scripts\sp\anim::_id_1F35(var_5, "boss_dropship_c6_land");
  _id_0E29::_id_87D0(var_5);
  var_14 = undefined;

  if(isDefined(var_0)) {
    var_5 _meth_8481(var_0.origin);

    while(distance(var_5.origin, var_0.origin) > var_0.radius) {
      wait 0.15;
    }
  }

  var_15 = scripts\engine\utility::getclosest(var_5.origin, getaiarray("allies"));

  if(isDefined(var_15)) {
    var_5.favoriteenemy = var_15;
    var_5 setgoalentity(var_15);
  }

  var_5.bt.forceselfdestructtimer = 0;
  var_5 _meth_84E5(0.0);
  var_5 waittill("death");
  var_5 setscriptablepartstate("torso_overload_fx", "normal");
}

_id_2CEF() {
  var_0 = spawnStruct();
  var_0.origin = (72186, 47120, -34255.8);
  var_0.radius = 250;
  var_1 = spawnStruct();
  var_1.origin = (72540, 47722, -34045.1);
  var_1.radius = 250;
  var_2 = scripts\engine\utility::spawn_script_origin();
  var_3 = self.mgturret[0];
  var_3 setmode("manual");
  var_3 settargetentity(var_2);
  var_4 = distance(var_0.origin, var_1.origin);
  var_5 = 70;
  var_6 = int(var_4 / var_5);
  var_7 = var_0.origin;
  var_8 = vectorNormalize(var_1.origin - var_0.origin);
  var_9 = var_0.radius;
  thread _id_5DE7(6.5, 19);

  for(var_10 = 0; var_10 < var_6; var_10++) {
    var_2.origin = var_7;
    var_11 = randomintrange(1, 3);

    for(var_12 = 0; var_12 < var_11; var_12++) {
      var_13 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_7, var_9);
      var_13 = scripts\sp\utility::_id_864C(var_13, (0, 0, 1));
      var_14 = var_3 gettagorigin("tag_flash");
      magicbullet("sdf_dropship_turret_energy", var_14, var_13);
      bullettracer(var_14, var_13, "sdf_dropship_turret_energy");
      playworldsound("phstreets_hill_dirt_bullet_impact_jackal", var_13);
      playFX(scripts\engine\utility::getfx("hill_jackal_bullet_impact"), var_13, (0, 0, 1));
      wait 0.165;
    }

    var_7 = var_7 + var_8 * var_5;
  }

  var_2 delete();
}

_id_2CE5() {
  var_0 = self.script_parameters;
  thread _id_B34E(var_0);

  if(isDefined(level._id_5D81) && isDefined(level._id_5D81._id_19EE)) {
    self _meth_82DE(level._id_5D81._id_19EE, 0.25);
    scripts\sp\utility::_id_F417(1);
  }

  scripts\engine\utility::flag_wait("ok_to_delete_hill_AI");

  if(isDefined(self)) {
    self delete();
  }
}

_id_B347(var_0) {
  var_1 = undefined;

  if(var_0 == "y" || var_0 == "g") {
    var_1 = "center";
  } else if(var_0 == "p" || var_0 == "o") {
    var_1 = "right";
  }

  thread _id_B34E(var_1);
}

_id_B34E(var_0) {
  if(!isDefined(level._id_2CF7)) {
    level._id_2CF7 = [];
  }

  if(!isDefined(level._id_2CF7[var_0])) {
    level._id_2CF7[var_0] = [];
  }

  level._id_2CF7[var_0] = ::scripts\engine\utility::array_add(level._id_2CF7[var_0], self);
  self waittill("death");
  level._id_2CF7[var_0] = ::scripts\engine\utility::array_remove(level._id_2CF7[var_0], self);
}

_id_2CDC() {
  self waittill("death");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(self._id_6B54);
  scripts\sp\utility::_id_228A(scripts\engine\utility::array_removeundefined(self._id_4074));
}

_id_5DE7(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = 0.1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.15;
  }

  wait(var_0);
  var_4 = anglestoright(self.angles);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = randomfloatrange(220, 280);
    var_7 = randomfloatrange(100, 150);
    var_8 = randomfloatrange(10, 15);

    if(var_5 % 2) {
      thread _id_6E98(self gettagorigin("tag_wing_mid_ri"), var_4, var_6, var_7, var_8);
    } else {
      thread _id_6E98(self gettagorigin("tag_wing_mid_le"), var_4 * -1, var_6, var_7, var_8);
    }

    wait(randomfloatrange(var_2, var_3));
  }
}

_id_6E98(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 + var_1 * var_2;
  var_6 = (var_5 + var_0) * 0.5;
  var_7 = var_6[2];
  var_8 = var_3 + var_0[2] - var_7;
  var_9 = var_6 + (0, 0, 1) * var_8;
  var_10 = distance(var_0, var_9) + distance(var_5, var_9);
  var_11 = scripts\sp\utility::_id_BD6B(var_4, var_10);
  var_12 = 30;
  var_13 = 1 / (var_12 * var_11);
  var_14 = scripts\engine\utility::spawn_tag_origin(var_0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_dropship_flare"), var_14, "tag_origin");
  var_15 = 0;
  var_16 = 0;

  while(!var_15) {
    var_16 = var_16 + var_13;
    var_17 = scripts\sp\math::_id_7BC5(var_0, var_5, var_8, var_16);
    var_18 = undefined;

    if(isDefined(self)) {
      var_18 = self;
    }

    var_19 = scripts\common\trace::ray_trace(var_14.origin, var_17, var_18, scripts\common\trace::create_solid_ai_contents(), 1);

    if(var_19["hittype"] == "hittype_entity" || var_19["hittype"] == "hittype_world" && var_19["surfacetype"] != "surftype_none") {
      var_15 = 1;
      var_14.origin = var_19["position"];
    } else
      var_14.origin = var_17;

    wait 0.05;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_dropship_flare"), var_14, "tag_origin");
  var_14 delete();
}

_id_8F59(var_0, var_1, var_2, var_3) {
  if(!getdvarint("hill_dropship_debug")) {
    return;
  }
}