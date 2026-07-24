/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_stealth_street.gsc
**********************************************************/

_id_10F08() {
  scripts\sp\maps\titan\titan_code::_id_BC52("first_encounter_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  thread _id_10F2A();
  level._id_C47F _id_8E36();
  var_0 = scripts\engine\utility::getStruct("first_encounter_omar", "targetname");
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles, 10000);
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_15F5, "gate_guys_trigger");
  scripts\sp\utility::_id_15F5("squad_gate_color_trig");
  scripts\sp\maps\titan\titan_code::_id_BC2A("first_encounter_", [level._id_2429, level._id_B33B, level._id_B33E]);
  level._id_C47F.target = "omar_stealth_start";
  level._id_C47F.goalradius = 24;
  level._id_C47F thread _id_8E2B();
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\sp\utility::_id_15F5("street1_colortrig_01");
  level._id_C47F thread _id_C481();
  thread _id_11126();
  wait 1;
  scripts\engine\utility::exploder("cell_storm_2");
}

_id_10F10() {
  scripts\sp\maps\titan\titan_code::_id_BC52("stealth2_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  var_0 = scripts\engine\utility::getStruct("stealth2_omar", "targetname");
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles, 10000);
  level._id_C47F _id_8E36();
  thread _id_10F2A();
  thread _id_11127();
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\engine\utility::flag_set("building1_exit_clear");
  scripts\engine\utility::flag_set("stealth_street_entered");
  scripts\engine\utility::exploder("cell_storm_2");
}

_id_10F0E() {
  thread _id_10F0D();
  thread _id_10F12();
  thread _id_C49D();
  thread _id_11128();
  thread _id_5EA4();
  thread scripts\sp\maps\titan\titan_code::_id_5195("2", "dropship_building_exited");
  thread scripts\sp\maps\titan\titan_code::_id_5195("reinforce_2", "dropship_building_exited");
  thread scripts\sp\maps\titan\titan_code::_id_5195("building1_interior", "dropship_building_exited");
  thread scripts\sp\maps\titan\titan_code::_id_5195("street_building1_interior", "dropship_building_exited");
  thread delete_street2_seekers();
  thread _id_10F0A();
  thread _id_10F11();
  thread _id_10F1B();
  level._id_2429 _id_8E36();
  scripts\engine\utility::flag_set("apc_blocker_moveup");
  scripts\engine\utility::flag_wait("street3_start");
  wait 0.05;

  if(!level.console)
    waitforalltransients();
}

_id_10F0D() {
  level endon("stealth_street3_started");
  level.player endon("death");
  var_0 = getEntArray("stealth_street2_reinforce_spawner", "targetname");
  scripts\engine\utility::flag_wait("stealth_spotted");
  scripts\sp\maps\titan\titan_code::_id_10F25("2");
  scripts\sp\maps\titan\titan_code::_id_10F25("building1_interior");
  scripts\sp\maps\titan\titan_code::_id_10F25("street_building1_interior");
  _id_10F2D();
  wait 5;
  thread _id_10F32();
  playworldsound("scn_stealth_spawn_alarm_lr", level.player.origin);
  level endon("cancel_stealth_reinforcement");

  for(;;) {
    foreach(var_2 in var_0) {
      if(getaicount("axis") < 15) {
        if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, cos(65)) && distance(level.player.origin, var_2.origin) > 800)
          scripts\sp\maps\titan\titan_code::_id_10F31(var_2);
      }
    }

    wait 1;
  }
}

_id_10F0A() {
  level endon("player_entered_exit_building");
  var_0 = getEnt("streets2_backtrack_blocker", "targetname");
  var_1 = getEnt("streets2_backtrack_blocker_col", "targetname");
  var_2 = [var_0, var_1];

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_8E9A();

  var_1 connectpaths();
  scripts\engine\utility::flag_wait("dropship_building_exited");

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_100FC();

  var_1 disconnectPaths();
  level notify("streets2_teleport_heroes");
}

_id_10F11() {
  var_0 = getEnt("street2_all_in_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct("street2_ethan_teleport", "targetname");
  var_2 = scripts\engine\utility::getStruct("street2_omar_teleport", "targetname");
  level waittill("streets2_teleport_heroes");

  if(!level._id_2429 istouching(var_0))
    level._id_2429 _meth_80F1(var_1.origin, var_1.angles);

  if(!level._id_C47F istouching(var_0)) {
    level._id_C47F _meth_80F1(var_2.origin, var_2.angles);
    scripts\sp\utility::_id_15F5("streets3_color_trig_00");
  }
}

delete_street2_seekers() {
  var_0 = getEnt("stealth_street2_seeker_trig", "targetname");
  level waittill("streets2_teleport_heroes");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      return;
    }
    if(var_3.classname == "actor_ally_equipment_seeker" && var_3 istouching(var_0))
      var_3 delete();
  }
}

_id_11127() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("omar_fence_crawl_complete");
  var_0 = getEntArray("streets2_color_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_10F0B);
}

_id_C49D() {
  level endon("dropship_building_exited");
  scripts\engine\utility::flag_wait("building1_exit_clear");

  while(isDefined(level._id_11117) && isalive(level._id_11117) && scripts\engine\utility::flag("street_c12_is_near"))
    wait 1;

  scripts\sp\utility::_id_15F5("street2_colortrig_08");
}

_id_11128() {
  level endon("player_entered_exit_building");
  var_0 = scripts\sp\utility::_id_22CD("ethan_enemies");
  scripts\engine\utility::flag_wait("stealth2_start");
  level thread _id_10F59(var_0, level._id_2429);
  var_1 = scripts\engine\utility::getStruct("atom_jump_start", "targetname");
  level._id_2429 _meth_80F1(var_1.origin, var_1.angles, 10000);
  level._id_2429 thread scripts\sp\maps\titan\titan_code::_id_10FC2();
  thread streets2_team_takedown_check(var_0);
}

streets2_team_takedown_check(var_0) {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("street3_start");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  if(var_0.size > 0) {
    foreach(var_2 in var_0)
    var_2 _meth_84F7("sight", level.player, level.player.origin);
  }
}

_id_2553() {
  var_0 = scripts\sp\utility::_id_8200("apc_blocker", "targetname");
  var_0 waittill("spawned", var_1);
  level._id_2553 = var_1;
  var_1.turret = var_1.mgturret[0];
  var_1.turret setmode("manual");
  var_1.turret setdefaultdroppitch(0);
  var_1.turret thread _id_256C();

  foreach(var_3 in var_1._id_E4FB)
  var_3 thread _id_2563();
}

_id_2563() {
  self.ignoreall = 1;
}

_id_256C() {
  self endon("death");
  self endon("emergency_unload");
  var_0 = 970;
  var_1 = 680;

  for(;;) {
    while(distance2dsquared(self.origin, level.player.origin) < squared(var_0)) {
      if(scripts\engine\utility::flag("player_is_on_road"))
        self settargetentity(level.player, (0, 0, 50));

      if(distance2dsquared(self.origin, level.player.origin) <= squared(var_1)) {
        if(scripts\engine\utility::flag("player_is_on_road")) {
          _id_256B();
          level.player dodamage(level.player.health + 100, level.player.origin);
        }
      }

      wait 0.65;
    }

    self cleartargetentity();
    wait 0.05;
  }
}

_id_2567(var_0) {
  if(var_0) {
    playFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self.turret, "tag_flash");
    playFXOnTag(scripts\engine\utility::getfx("spotlight_flare"), self.turret, "tag_flash");
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self.turret, "tag_flash");
    stopFXOnTag(scripts\engine\utility::getfx("spotlight_flare"), self.turret, "tag_flash");
  }
}

_id_256B(var_0) {
  if(!_id_0B1D::_id_385D(self gettagorigin("tag_flash"))) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = randomintrange(5, 8);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    wait 0.05;
    self shootturret();
  }
}

_id_B15A(var_0) {
  var_1 = "iw7_kbs";
  var_2 = 0;
  var_3 = undefined;

  if(isai(self)) {
    self.dontevershoot = 1;
    self.ignoreall = 0;
    var_4 = distance(var_0.origin, self.origin);
    self._id_C3C9 = self.maxvisibledist;
    self.maxvisibledist = var_4;
    self.maxsightdistsqrd = squared(var_4);
    scripts\sp\utility::_id_F39C(var_0);
  } else {}

  if(var_2)
    var_3 = self gettagorigin("tag_flash");
  else
    var_3 = self.origin;

  magicbullet(var_1 + "+silencersniperhide", var_3, var_0 getEye());
  wait 0.3;

  if(isalive(var_0))
    var_0 dodamage(var_0.health + 100, var_0 getEye(), self, undefined, "MOD_HEAD_SHOT");

  wait 0.3;

  if(var_2) {
    self.maxvisibledist = self._id_C3C9;
    self.maxsightdistsqrd = squared(self._id_C3C9);
  }
}

_id_A868(var_0) {
  var_0 endon("death");

  if(isai(self))
    var_1 = self gettagorigin("tag_flash");
  else
    var_1 = self.origin;

  var_2 = 1;
  var_3 = vectortoangles(var_0.origin - var_1);
  self._id_A86C.angles = var_3;
  self._id_A86C _meth_81D6();
  self._id_A86C thread _id_6AF5(var_0);
  var_4 = vectortoangles(var_0 getEye() - var_1);
  self._id_A86C rotateTo(var_4, var_2, var_2 * 0.2, var_2 * 0.8);
  wait(var_2);
}

_id_6AF5(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_1 = distance(self.origin, var_0.origin);
    var_1 = var_1 + 30;
    var_2 = anglesToForward(self.angles);
    var_3 = self.origin + var_2 * var_1;
    wait 0.05;
  }
}

_id_10F0F() {}

_id_10F12() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("streets2_start_c12_move");
  scripts\engine\utility::flag_wait("omar_streets2_roof_go");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_rejoiningyoucaptainbrooks");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_multipletargetsguardingthe");
  scripts\engine\utility::flag_wait("street3_start");
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_thanksfortheass");
  scripts\sp\utility::_id_127B3("stealth_street_dropship_spawner");
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_enemydropshipsi");
}

_id_10F1F() {
  scripts\sp\maps\titan\titan_code::_id_BC52("stealth_street3_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  thread _id_10F2A();
  var_0 = scripts\engine\utility::getStruct("street3_omar", "targetname");
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles, 20000);
  level._id_C47F _id_8E36();
  var_0 = scripts\engine\utility::getStruct("street3_atom", "targetname");
  level._id_2429 _meth_80F1(var_0.origin, var_0.angles, 20000);
  thread _id_5EA4();
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\engine\utility::exploder("cell_storm_2");
}

_id_10F1D() {
  thread _id_10F20();
  thread _id_4600();
  thread _id_10F19();
  thread _id_10F15();
  thread _id_6ED1("streets3_final");
  thread _id_6ED1("streets3_jeep_guys");
  thread _id_10F18();
  thread _id_6797();
  thread _id_F10F("streets3_pod");
  thread buddy_boost();
  thread scripts\sp\maps\titan\titan_code::_id_5195("streets3_door", "player_buddy_door_hallway");
  thread scripts\sp\maps\titan\titan_code::_id_5195("streets3_pod", "player_buddy_door_hallway");
  thread scripts\sp\maps\titan\titan_code::_id_5195("reinforce_3", "player_buddy_door_hallway");
  thread scripts\sp\maps\titan\titan_code::_id_5195("streets3_catwalk", "player_buddy_door_hallway");
  thread scripts\sp\maps\titan\titan_code::_id_5195("streets3_final", "player_buddy_door_hallway");
  level thread _id_EA11();
  thread _id_11129();
  thread _id_10F27();
  thread _id_10F1A();
  scripts\engine\utility::flag_wait("buddy_door_room_entered");
}

_id_10F1E() {}

_id_10F17() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait(self.script_parameters);
  level._id_C47F scripts\sp\utility::_id_61C7();
  level._id_C47F scripts\sp\utility::_id_F3B5("r");
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429 scripts\sp\utility::_id_F3B5("o");

  if(scripts\engine\utility::flag("streets3_flag_ground_2") && self.script_parameters == "streets3_pod_clear") {
    return;
  }
  scripts\sp\utility::_id_15F5(self.targetname);
}

_id_10F1B() {
  level endon("player_entered_exit_building");
  level._id_B33B scripts\sp\utility::_id_54F7();
  level._id_B33E scripts\sp\utility::_id_54F7();
  level._id_C47F scripts\sp\utility::_id_61C7();
  level._id_C47F scripts\sp\utility::_id_F3B5("r");
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429 scripts\sp\utility::_id_F3B5("o");
  scripts\engine\utility::flag_wait("ethan_enemies_dead");
  scripts\sp\utility::_id_15F5("street2_colortrig_11");
  scripts\engine\utility::flag_wait("street3_start");
  scripts\sp\utility::_id_15F5("streets3_color_trig_takedown");
  wait 1.5;
  scripts\sp\utility::_id_15F5("streets3_color_trig_takedown_2");
}

_id_10F1C() {
  level endon("player_at_streets_exit_door");
  level.player endon("death");
  var_0 = getEntArray("stealth_street3_reinforce_spawner", "targetname");
  scripts\engine\utility::flag_wait("stealth_spotted");
  scripts\sp\maps\titan\titan_code::_id_10F25("streets3_door");
  scripts\sp\maps\titan\titan_code::_id_10F25("streets3_pod");
  scripts\sp\maps\titan\titan_code::_id_10F25("streets3_catwalk");
  scripts\sp\maps\titan\titan_code::_id_10F25("streets3_final");
  _id_10F2D();
  wait 5;
  thread _id_10F32();
  playworldsound("scn_stealth_spawn_alarm_lr", level.player.origin);
  level endon("cancel_stealth_reinforcement");

  for(;;) {
    foreach(var_2 in var_0) {
      if(getaicount("axis") < 15) {
        if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, cos(65)) && distance(level.player.origin, var_2.origin) > 800)
          scripts\sp\maps\titan\titan_code::_id_10F31(var_2);
      }
    }

    wait 1;
  }
}

_id_10F32() {
  wait 60;
  level notify("cancel_stealth_reinforcement");
}

_id_10F2D() {}

_id_10F15() {
  level endon("player_entered_exit_building");

  while(!isDefined(level._id_10E6D.group.groups["streets3_catwalk"]))
    wait 1;

  var_0 = _id_0F27::_id_79F5("streets3_catwalk");
  thread _id_6ED1("streets3_catwalk");
  level thread _id_10F59(var_0, level._id_C47F);
  var_0 thread _id_10F16();
  thread _id_10F1C();
  scripts\sp\utility::_id_13754(var_0, 2);
  scripts\engine\utility::flag_set("streets3_catwalk_clear");
  scripts\engine\utility::flag_wait("streets3_pod_guy_dead");
  var_1 = getEnt("road_enemy_check_trig", "targetname");
  var_2 = _id_0F27::_id_79F5("streets3_pod");

  foreach(var_4 in var_2) {
    while(isDefined(var_4) && isalive(var_4) && var_4 istouching(var_1))
      wait 0.5;
  }

  scripts\engine\utility::flag_set("streets3_pod_clear");
}

stealth_street3_pod_guard_vo() {
  self waittill("death", var_0);
  wait 0.35;

  if(isDefined(var_0)) {
    if(var_0 == level.player)
      scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_down");
  }
}

_id_10F16() {
  scripts\engine\utility::flag_wait("streets3_convoy_start");
  var_0 = scripts\sp\utility::array_removedeadvehicles(self);

  if(var_0.size > 0) {
    foreach(var_2 in level._id_8E42)
    var_2 notify("cleartoengage");
  }
}

_id_10F18() {
  while(!isDefined(level._id_10E6D.group.groups["streets3_pod"]))
    wait 1;

  thread _id_6ED1("streets3_pod");
  var_0 = _id_0F27::_id_79F5("streets3_pod");

  foreach(var_2 in var_0)
  var_2 thread _id_1300D();

  while(!isDefined(level._id_10E6D.group.groups["streets3_door"]))
    wait 1;

  var_4 = _id_0F27::_id_79F5("streets3_door");
  thread _id_6ED1("streets3_door");
  var_4[0] thread stealth_street3_pod_guard_vo();
  var_4[0] endon("death");
  scripts\engine\utility::flag_wait("dropship_unload_trigger_flag");

  if(isalive(var_4[0]) && !scripts\engine\utility::flag("stealth_spotted"))
    var_4[0] _meth_84F7("sight", level.player, level.player.origin);

  level._id_C47F scripts\sp\utility::_id_F39C(var_4[0]);
  level._id_2429 scripts\sp\utility::_id_F39C(var_4[0]);
}

_id_10F14() {
  var_0 = getEnt("streets3_c12_spawner", "targetname");
  scripts\engine\utility::flag_wait("dropship_building_exited");
  var_1 = var_0 scripts\sp\utility::_id_10619();
}

_id_10F1A() {
  level endon("player_entered_exit_building");
  level scripts\engine\utility::waittill_any("ethan_streets3_takedown_complete", "stealth_street3_started");
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429 scripts\sp\utility::_id_F3B5("o");
  scripts\sp\utility::_id_15F5("streets3_color_trig_00");
  var_0 = getEntArray("streets3_color_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_10F17);
  scripts\sp\utility::_id_127B3("stealth_street_dropship_spawner");
  level._id_1111E = scripts\sp\vehicle::_id_1080C("steealth_street_dropship");
  var_1 = scripts\engine\utility::getStruct("street3_dropship_node", "script_noteworthy");
  level._id_1111E castspotshadows(0);
  level._id_1111E scripts\sp\vehicle::_id_2471(var_1);
  level._id_1111E vehicle_setspeedimmediate(12);
  scripts\engine\utility::array_thread(level._id_1111E._id_E4FB, ::_id_5E78);

  while(!isDefined(level._id_10E6D.group.groups["streets3_final"]))
    wait 1;

  var_2 = _id_0F27::_id_79F5("streets3_final");
  scripts\sp\utility::_id_13753(var_2, var_2.size);

  if(!scripts\engine\utility::flag("buddy_door_room_entered"))
    scripts\engine\utility::flag_set("stealth_street_3_clear");

  level notify("stealth_streets3_final_clear");
  level._id_C47F.target = "streets3_final_bldg_omar";
  level._id_C47F.goalradius = 24;
  level._id_C47F thread _id_8E2B();
  level._id_C47F scripts\sp\utility::_id_61C7();
  level._id_C47F scripts\sp\utility::_id_F3B5("r");
  level._id_2429.target = "streets3_final_bldg_ethan";
  level._id_2429.goalradius = 24;
  level._id_2429 thread _id_8E2B();
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429 scripts\sp\utility::_id_F3B5("o");
  scripts\sp\utility::_id_15F5("streets3_color_trig_07");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_theyregone");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_letsmovethrough");
}

_id_11129() {
  level endon("player_entered_exit_building");
  var_0 = scripts\engine\utility::getStruct("omar_grenade_toss", "targetname");
  thread streets3_grenade_bypass();
  scripts\engine\utility::flag_wait("streets3_pod_clear");
  scripts\engine\utility::flag_wait("streets3_flag_ground_2");
  var_0 scripts\sp\anim::_id_1F17(level._id_C47F, "grenade_toss");
  level._id_C47F scripts\sp\utility::_id_61C7();
  var_1 = _id_0F27::_id_79F5("streets3_final");

  if(var_1.size > 0 && !scripts\engine\utility::flag("stealth_spotted")) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_tightbatchtossi");
    wait 1;
    var_1 = _id_0F27::_id_79F5("streets3_final");

    if(var_1.size < 4 || scripts\engine\utility::flag("stealth_spotted")) {
      return;
    }
    var_2 = spawn("script_model", level._id_C47F gettagorigin("tag_inhand"));
    var_2.angles = level._id_C47F gettagangles("tag_inhand");
    var_2 linkTo(level._id_C47F, "tag_inhand");
    var_2 setModel("anti_grav_grenade_wm");
    var_0 thread scripts\sp\anim::_id_1F35(level._id_C47F, "grenade_toss");
    var_2 thread grenade_timeout();
    level waittill("grenade_release");
    var_2 delete();
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_go");
  }
}

grenade_timeout() {
  self endon("death");
  level scripts\engine\utility::waittill_any_timeout(10, "player_entered_exit_building");

  if(isDefined(self))
    self delete();
}

streets3_grenade_bypass() {
  scripts\engine\utility::flag_wait("player_entered_exit_building");
  var_0 = _id_0F27::_id_79F5("streets3_final");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  if(var_0.size > 0) {
    foreach(var_2 in var_0)
    var_2 _meth_84F7("sight", level.player, level._id_C47F.origin);
  }
}

_id_1112A() {
  level._id_5BCF = scripts\sp\vehicle::_id_1080C("driveway_jeep");
  var_0 = level._id_5BCF;
  level._id_5BCF scripts\sp\vehicle::_id_1320C("running");
  var_0 thread _id_1112B();
  thread _id_5BD0();
  var_0 thread _id_5BD1();
  var_0 thread _id_5BD4();
  scripts\engine\utility::flag_wait("stealth_spotted");
  var_0 scripts\sp\vehicle::_id_13253();
}

_id_1112B() {
  var_0 = self._id_E4FB;
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  if(var_0.size > 0) {
    thread scripts\sp\vehicle_paths::_id_845A(self);
    scripts\engine\utility::flag_wait("driveway_jeep_end_path");
    var_1 = scripts\sp\utility::array_removedeadvehicles(self._id_E4FB);

    foreach(var_3 in var_1)
    var_3 delete();
  }
}

_id_1112C() {
  scripts\sp\utility::_id_F415(1);
  self waittill("unload");
  scripts\sp\utility::_id_F415(0);
}

_id_5BCF() {
  level._id_5BCF = scripts\sp\vehicle::_id_1080C("driveway_jeep");
  var_0 = level._id_5BCF;
  var_0 scripts\engine\utility::delaythread(2, scripts\sp\vehicle::_id_1320B, "running");
  level._id_5BCF thread _id_5BD1();
  level._id_5BCF thread _id_5BD4();
  scripts\engine\utility::flag_wait("driveway_jeep_exits");
  thread _id_5BD0();
  level._id_5BCF scripts\sp\vehicle::_id_1320C("running");
  thread scripts\sp\vehicle_paths::_id_845A(level._id_5BCF);
  scripts\engine\utility::flag_set("driveway_clear");
  scripts\engine\utility::flag_wait("stealth_street_jeep_passed");
}

_id_5BD0() {
  var_0 = getEnt("streets3_gate_left", "targetname");
  var_1 = getEnt("streets3_gate_right", "targetname");
  scripts\engine\utility::flag_wait("streets3_jeep_open_gate");
  var_0 rotateYaw(90, 2);
  var_1 rotateYaw(-90, 2);
  scripts\engine\utility::flag_wait("driveway_jeep_end_path");
  var_0 rotateYaw(-90, 2);
  var_1 rotateYaw(90, 2);
}

_id_5BD1() {
  self waittill("damage", var_0, var_1);

  if(!scripts\engine\utility::flag("stealth_spotted")) {
    self vehicle_setspeed(0, 10, 10);

    while(self vehicle_getspeed() > 0)
      wait 0.05;

    var_2 = scripts\sp\utility::array_removedeadvehicles(self._id_E4FB);
    scripts\sp\vehicle::_id_13253();
    scripts\engine\utility::array_thread(var_2, ::_id_5BD2);
  }
}

_id_5BD4() {
  self endon("death");
  self endon("damage");

  while(!scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::flag_wait("stealth_spotted");
    self vehicle_setspeed(0, 10, 10);

    while(self vehicle_getspeed() > 0)
      wait 0.05;

    var_0 = scripts\sp\utility::array_removedeadvehicles(self._id_E4FB);
    scripts\engine\utility::array_thread(var_0, ::_id_5BD2);
    scripts\sp\vehicle::_id_13253();
  }
}

_id_5BD5() {
  self endon("death");

  for(;;) {
    self settargetentity(level.player, (0, 0, 50));
    _id_13638(level.player, 4);
    _id_256B();
    wait 0.65;
  }
}

_id_13638(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon("waittill_aim_timeout");
    thread scripts\sp\utility::_id_C12D("waittill_aim_timeout", var_1);
  }

  if(issentient(var_0))
    var_0 endon("death");

  while(!scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var_0.origin, cos(60)))
    wait 0.05;
}

_id_5BD2() {
  self endon("death");
  self waittill("unloaded");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self _meth_81D6();
  thread _id_5775();
}

_id_5DE2() {
  scripts\engine\utility::flag_wait("driveway_clear");
}

_id_5BD3() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self waittill("damage");
  self._id_E500 dodamage(20, self._id_E500.origin, level.player);
}

_id_10F20() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("streets3_catwalk_clear");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_pushinup");
  scripts\engine\utility::flag_wait("streets3_convoy_start");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_moredeadahead");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_keepitdarkcapta");
  scripts\engine\utility::flag_wait("driveway_jeep_exits");
}

_id_4600() {
  while(!isDefined(level._id_10E6D.group.groups["streets3_catwalk"]))
    wait 1;

  var_0 = _id_0F27::_id_79F5("streets3_catwalk");

  foreach(var_2 in var_0) {
    var_2 endon("stealth_alertlevel_change");
    var_2 endon("death");
  }

  scripts\engine\utility::flag_wait("dropship_building_exited");
  wait 1;
  var_4 = ["titan_sd5_theyhaventcheck", "titan_sd6_whichteams", "titan_sd5_bravoechoandfox", "titan_sd6_itsthisdustands", "titan_sd5_idontquestionth", "titan_sd6_yeahfine"];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_0[0] scripts\sp\utility::play_sound_on_entity(var_4[var_5]);
    wait(randomfloatrange(0.15, 0.5));
    var_0[1] scripts\sp\utility::play_sound_on_entity(var_4[var_5 + 1]);
    var_5++;
    wait(randomfloatrange(0.15, 0.5));
  }

  wait 2;
  scripts\engine\utility::flag_set("streets3_catwalk_vo_finished");
}

_id_10F19() {
  while(!isDefined(level._id_10E6D.group.groups["streets3_pod"]))
    wait 1;

  var_0 = _id_0F27::_id_79F5("streets3_pod");
  var_0[2] endon("stealth_alertlevel_change");
  var_0[3] endon("stealth_alertlevel_change");
  var_0[2] endon("death");
  var_0[3] endon("death");
  scripts\engine\utility::flag_wait("streets3_convoy_start");
  wait 1;
  var_1 = ["titan_sf3_youspenttwentyt", "titan_sf4_inonemonth", "titan_sf3_onemonth", "titan_sf4_ijustwentthorug", "titan_sf3_twentythousandd", "titan_sf4_ihadeveryoneoft", "titan_sf3_bullshit", "titan_sf4_imnotlyingyoush", "titan_sf3_apatiotheyhaveb", "titan_sf4_yepclassyplaces"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[2] scripts\sp\utility::play_sound_on_entity(var_1[var_2]);
    wait(randomfloatrange(0.15, 0.5));
    var_0[3] scripts\sp\utility::play_sound_on_entity(var_1[var_2 + 1]);
    var_2++;
    wait(randomfloatrange(0.15, 0.5));
  }
}

_id_5ED2() {
  scripts\engine\utility::flag_wait("dropship_unload_trigger_flag");
  scripts\engine\utility::flag_set("dropship_door_flyby");
  self._id_E2FC = self._id_4BF7;
  var_0 = scripts\engine\utility::getStruct("unload_guys", "targetname");
  thread scripts\sp\vehicle::_id_1321A(var_0);
}

_id_5E78() {
  thread scripts\sp\utility::_id_B14F(1);
  self waittill("jumping_out");
  thread _id_6ED1("dropship_riders");
  self waittill("anim_on_tag_done");
  thread scripts\sp\utility::_id_1101B();
}

_id_5775() {
  self endon("death");

  for(;;) {
    var_0 = self _meth_80E3();

    if(isDefined(var_0)) {
      self.goalradius = 32;
      self _meth_82EE(var_0);
      self waittill("goal");
      self.goalradius = 1000;
      return;
    }

    wait 0.5;
  }
}

_id_5EA4() {
  level endon("player_entered_exit_building");
  var_0 = scripts\sp\utility::_id_8200("steealth_street_dropship", "targetname");
  var_0 waittill("spawned", var_1);
  level._id_1111E = var_1;
  level._id_1111E vehicle_setspeedimmediate(30);
  level._id_EA11 = 1;
  scripts\engine\utility::flag_wait("streets3_flag_ground_2");
}

_id_5DAB() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player) {
      scripts\engine\utility::flag_set("player_attacked_street_dropship");
      return;
    }
  }
}

_id_5EB3() {
  level._id_EA11 = 1;
  var_0 = "tag_wing_front_le";
  var_1 = (10, 0, -170);
  var_2 = self gettagorigin(var_0);
  self._id_10A5F = spawnturret("misc_turret", var_2 + var_1, "fighter_spotlight");
  self._id_10A5F.angles = self.angles;
  self._id_10A5F linkTo(self, var_0, var_1, (0, 0, 0));
  self._id_10A5F makeunusable();
  self._id_10A5F setmode("manual");
  self._id_10A5F setdefaultdroppitch(-90);
  self._id_10A5F setleftarc(180);
  self._id_10A5F setrightarc(180);
  self._id_10A5F settoparc(180);
  self._id_10A5F setbottomarc(180);
  self._id_10A5F _meth_82C9(0.75, "yaw");
  self._id_10A5F _meth_82C9(0.75, "pitch");
  self._id_10A5F.light = getEnt("dropship_spotlight", "script_noteworthy");
  self._id_10A5F.light setlightintensity(0);
  self._id_10A5F.light _meth_8300(1500);
  var_3 = 20;
  var_4 = var_3 * 1.25;
  self._id_10A5F.light _meth_82FD(var_4, var_3);
  self._id_10A5F.light linkTo(self._id_10A5F, "tag_flash", (0, 0, 0), (0, 0, 0));
  self._id_10A5F.light._id_B451 = self._id_10A5F.light _meth_8136();
  self._id_10A5F.light._id_B43A = self._id_10A5F.light _meth_8132();
  self._id_10A5F.light._id_B43B = self._id_10A5F.light _meth_8133();
  self._id_10A5F.light._id_4FE3 = self._id_10A5F.light _meth_8131();
  self._id_10A5F.active = 0;
  self._id_10A5F._id_11512 = scripts\engine\utility::spawn_tag_origin();
}

_id_5EBA(var_0) {
  if(var_0 && !self._id_10A5F.active) {
    playFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self._id_10A5F, "tag_flash");
    playFXOnTag(scripts\engine\utility::getfx("spotlight_flare"), self._id_10A5F, "tag_flash");
    self._id_10A5F.light setlightintensity(250000);
    self._id_10A5F.active = 1;
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("search_spotlight"), self._id_10A5F, "tag_flash");
    stopFXOnTag(scripts\engine\utility::getfx("spotlight_flare"), self._id_10A5F, "tag_flash");
    self._id_10A5F.light setlightintensity(0);
    self._id_10A5F.active = 0;
  }
}

_id_5EB4(var_0) {
  self endon("stop_spotlight_following_ent");
  self notify("new_spotlight_target");
  self endon("death");
  self._id_10A5F._id_72AF = 1;

  for(;;) {
    if(_id_10A66(var_0, 45)) {
      _id_10A8A(var_0.origin);
      wait(randomfloatrange(1, 2));
    }

    wait 0.05;
  }
}

_id_5EB5(var_0, var_1) {
  self endon("death");
  self notify("new_spotlight_target");
  self._id_10A5F._id_72AF = 1;
  _id_10A8A(var_0);
  wait(var_1);
  self._id_10A5F._id_72AF = undefined;
}

_id_5EB9(var_0) {
  self endon("stop_spotlight_sweep");
  self endon("death");
  self._id_10A5F settargetentity(self._id_10A5F._id_11512);

  for(;;) {
    if(isDefined(self._id_10A5F._id_72AF)) {
      wait 1;
      continue;
    }

    if(isDefined(self.veh_speed) && self.veh_speed > 5) {
      var_1 = scripts\engine\utility::getclosest(self.origin, var_0).origin;
      _id_10A8A(var_1);
      _id_1132A(randomfloatrange(0.3, 0.8));
      continue;
    }

    var_0 = sortbydistance(var_0, self.origin);

    for(var_2 = 0; var_2 < 3; var_2++) {
      if(isDefined(self._id_10A5F._id_72AF)) {
        break;
      }

      if(isDefined(var_0[var_2].origin)) {
        if(isDefined(var_0[var_2].targetname) && var_0[var_2].targetname == "ai_crossing")
          _id_119C8(0);
        else
          scripts\engine\utility::delaythread(2, ::_id_119C8, 1);

        _id_10A8A(var_0[var_2].origin);
        _id_1132A(randomfloatrange(2.5, 3.5));
      }
    }

    wait 0.05;
  }
}

_id_119C8(var_0) {
  level._id_EA11 = var_0;
}

_id_EA11() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("dropship_building_exited");
  level notify("stealth_street3_started");

  while(!scripts\engine\utility::flag("ethan_takedown_enemy_dead") && !scripts\engine\utility::flag("ethan_takedown_skipped"))
    scripts\engine\utility::waitframe();

  if(!scripts\engine\utility::flag("streets3_catwalk_clear"))
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_twotargetsahead");

  scripts\engine\utility::flag_set("building3_safe_to_cross");
  return;
}

_id_1132A(var_0) {
  self endon("new_spotlight_target");
  wait(var_0);
}

_id_10A8A(var_0) {
  self endon("new_spotlight_target");
  var_1 = distance(self._id_10A5F._id_11512.origin, var_0);
  var_2 = scripts\sp\utility::_id_BD6B(40, var_1);

  if(var_2 <= 0)
    var_2 = 1;

  if(scripts\engine\utility::flag("player_attacked_street_dropship"))
    var_2 = var_2 * 0.3;

  self._id_10A5F._id_11512 moveTo(var_0, var_2, var_2 * 0.8, var_2 * 0.2);
  wait(var_2);
}

_id_10A66(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if(!self._id_10A5F.active)
    return 0;

  var_2 = 100000000;

  if(distance2dsquared(self._id_10A5F.origin, var_0.origin) > var_2)
    return 0;

  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 20);
  var_3 = self._id_10A5F gettagorigin("tag_flash");

  if(scripts\engine\utility::within_fov(var_3, self._id_10A5F gettagangles("tag_flash"), var_0.origin, cos(var_1))) {
    var_4 = scripts\common\trace::ray_trace(var_3, var_0.origin, self._id_10A5F);

    if(isDefined(var_4["entity"])) {
      if(var_4["entity"] == var_0)
        return 1;
    }
  }

  return 0;
}

_id_5EBB(var_0, var_1) {
  self endon("stop_monitoring_spotted_player");
  self endon("death");
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 2);
  var_2 = var_0 * 20;
  var_3 = 0;
  var_4 = 2;
  var_5 = 0;

  for(;;) {
    while(_id_10A66(level.player, 5)) {
      if(!var_5)
        var_5 = 1;

      var_3++;

      if(var_3 >= var_2) {
        if(isDefined(var_1))
          scripts\engine\utility::flag_set(var_1);

        level notify("dropship_sees_player");
        scripts\sp\utility::play_sound_on_entity("titan_sdp_gotemdeployingr");
        thread _id_5EB4(level.player);

        if(scripts\engine\utility::cointoss())
          var_6 = "titan_usf_werespottedfind";
        else
          var_6 = "titan_usf_theyvespottedus";

        return;
      }

      wait 0.05;
    }

    var_3 = 0;
    wait 0.05;
  }
}

_id_10F27() {
  scripts\engine\utility::flag_wait("player_entered_exit_building");
  var_0 = 0;
  var_1 = 0;
  var_2 = getEnt("buddy_door_trig", "targetname");
  bucket();
}

_id_D1F1() {
  scripts\sp\maps\titan\titan_code::_id_BC52("first_encounter_player");
  scripts\sp\maps\titan\titan_code::_id_557D();
  thread _id_DC32();
  wait 2;
  var_0 = scripts\engine\utility::getStruct("first_encounter_omar", "targetname");
  var_1 = getEntArray("stealth_road_enemies", "script_noteworthy");
  var_2 = var_1[0];

  for(;;) {
    var_3 = scripts\sp\utility::_id_864C(var_0.origin);
    var_2.count = var_2.count + 1;
    var_4 = var_2 scripts\sp\utility::_id_10619(1);
    var_4.ignoreall = 1;
    var_4 _meth_80F1(var_3, var_0.angles, 99999);
    var_4.goalradius = 32;
    var_4 setgoalentity(level.player, 5000);
    var_4 waittill("death");
    wait 2;
  }
}

_id_DC32() {
  var_0 = 1;
  level.player notifyonplayercommand("rain_toggle", "+actionslot 2");
  iprintlnbold("D-Pad DOWN to toggle rain");

  for(;;) {
    level.player waittill("rain_toggle");
    thread scripts\sp\maps\titan\titan_code::_id_D250(var_0);
    iprintln("rain severity " + var_0);
    var_0++;

    if(var_0 > 3)
      var_0 = 1;

    wait 0.25;
  }
}

_id_76E8() {
  level endon("stealth_street_entered");

  while(!isDefined(level._id_10E6D.group.groups["gate_guys"]))
    wait 1;

  var_0 = _id_0F27::_id_79F5("gate_guys");
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = var_0[0] _id_0F27::_id_79F6("stealth_spotted");
  else
    return;

  scripts\engine\utility::flag_wait(var_1);

  for(;;) {
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

    if(!var_0.size) {
      break;
    }

    level._id_B33E _id_B15A(scripts\engine\utility::random(var_0));
    var_2 = scripts\engine\utility::ter_op(randomint(100) >= 50, "titan_ksh_hesdown", "titan_ksh_gothim");
    scripts\sp\maps\titan\titan_code::_id_134B7(var_2);
    wait 0.5;
  }

  var_3 = ["titan_omr_quickworkkashim", "titan_eth_cleartomoveupsi", "titan_omr_copythat"];
  scripts\sp\maps\titan\titan_code::_id_48BD(var_3);
}

_id_76E7() {
  wait 1;
  var_0 = scripts\sp\utility::_id_107EA("gate_guys_headshot_victim", 1);
  var_0 thread _id_10F29();
  scripts\engine\utility::flag_wait("stealth_street_arrive");

  if(isDefined(var_0) && isalive(var_0) && !scripts\engine\utility::flag("stealth_spotted")) {
    var_0 thread _id_8C9C();
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_holdupyourshotm");
    wait 1;

    if(isDefined(var_0) && isalive(var_0))
      level._id_B33E _id_B15A(var_0);
  }
}

_id_8C9C() {
  self waittill("damage", var_0, var_1);

  if(var_1 != level.player) {
    wait 0.5;
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_targetdownyourewelcome");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_quickworkkashim");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_cleartomoveupsi");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_copythat");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_keepittightcapt");
  }
}

_id_10F29() {
  playFXOnTag(scripts\engine\utility::getfx("flashlight_enemy_bright"), self, "tag_flash");
  self waittill("death");

  if(isDefined(self) && scripts\sp\utility::hastag(self.model, "tag_flash"))
    stopFXOnTag(scripts\engine\utility::getfx("flashlight_enemy_bright"), self, "tag_flash");
}

_id_10F2A() {
  _id_10F2C();
  _id_10F35();
  thread _id_CCF8();
  var_0 = [level._id_B33B, level._id_B33E, level._id_2429];

  foreach(var_2 in var_0) {
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("stealth_street_entered");
  level notify("stealth_street2_started");
}

_id_10F2E() {
  var_0 = getEnt("streets1_pool_player_speed_modifier", "targetname");
  var_0 waittill("trigger");
  level endon("stealth2_start");

  for(;;) {
    if(level.player istouching(var_0))
      level.player setmovespeedscale(0.4);
    else
      level.player setmovespeedscale(1.0);

    wait 0.5;
  }
}

_id_10F2F() {
  var_0 = getEnt("streets1_pool_ai_nav_modifier", "targetname");
  var_0 waittill("trigger");
  level endon("stealth2_start");

  for(;;) {
    if(self istouching(var_0)) {
      scripts\sp\utility::_id_F48E("combat", "water_wade_mid");
      scripts\sp\utility::_id_F492(0.4, 0.5);
    } else
      scripts\sp\utility::_id_4169("combat");

    scripts\sp\utility::_id_F492(1.0, 1);
    wait 0.1;
  }
}

_id_10F06() {
  thread _id_10F09();
  thread _id_C49A();
  thread _id_6ED1("2");
  thread _id_F10F("2");
  thread _id_11127();
  scripts\engine\utility::flag_wait("stealth_street_entered");
}

_id_10F0B() {
  level endon("ethan_enemies_dead");
  scripts\engine\utility::flag_wait(self.script_parameters);
  level._id_C47F scripts\sp\utility::_id_61C7();
  level._id_C47F scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5(self.targetname);
}

_id_10F0C() {
  scripts\engine\utility::flag_wait("stealth_building1_exit");
  wait 1;
  thread _id_6ED1("2");
  thread _id_F10F("2");
}

_id_10F05() {
  level endon("stealth_street2_started");
  level.player endon("death");
  var_0 = getEntArray("stealth_street1_reinforce_spawner", "targetname");
  scripts\engine\utility::flag_wait("stealth_spotted");
  scripts\sp\maps\titan\titan_code::_id_10F25("gate_guys");
  _id_10F2D();
  wait 5;
  thread _id_10F32();
  playworldsound("scn_stealth_spawn_alarm_lr", level.player.origin);
  level endon("cancel_stealth_reinforcement");

  for(;;) {
    foreach(var_2 in var_0) {
      if(getaicount("axis") < 15) {
        if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, cos(65)) && distance(level.player.origin, var_2.origin) > 800)
          scripts\sp\maps\titan\titan_code::_id_10F31(var_2);
      }
    }

    wait 1;
  }
}

_id_35B3() {
  var_0 = getEnt("streets1_c12_spawner", "targetname");
  scripts\engine\utility::flag_wait("player_exits_building1");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "stealth_c12";
  level._id_11117 = var_1;
  var_1 endon("death");
  var_1 thread _id_3528();
  var_1 thread _id_3625();
  var_1 thread _id_35D1();
  var_1 thread _id_3636();
  var_1 thread _id_3618();
  var_1 thread _id_3512();
  var_1 thread _id_10F28();
  var_1 thread _id_35E0();
  var_1 thread _id_3572();
  level.player thread _id_D26C();
  scripts\engine\utility::flag_wait("stealth_spotted");
  var_1 notify("c12_spotted");
  var_1 thread _id_3557();
}

_id_3528() {
  scripts\engine\utility::flag_wait("dropship_building_exited");

  if(isDefined(self))
    self delete();
}

_id_3636() {
  var_0 = 348;
  self._id_C3C9 = self.maxvisibledist;
  self._id_C3C8 = self.maxsightdistsqrd;
  self.maxvisibledist = var_0;
  self.maxsightdistsqrd = squared(var_0);
  scripts\engine\utility::waittill_any("damage", "bulletwhizby", "c12_spotted", "bullethit", "missile_hit");
  self.maxvisibledist = self._id_C3C9;
  self.maxsightdistsqrd = self._id_C3C8;
}

_id_35D1() {
  self endon("death");

  while(!scripts\engine\utility::flag("stealth_spotted")) {
    self waittill("goal");

    if(self._id_290A == 1) {
      break;
    }

    thread scripts\sp\anim::_id_1EEA(self, "stealth_idle", "c12_stealth_stop_idle");
    self notify("c12_started_patrol_idle");
    scripts\engine\utility::waittill_any("go_to_node_new_goal", "c12_new_goal", "damage", "bulletwhizby", "c12_spotted", "bullethit", "missile_hit");
    self notify("c12_stealth_stop_idle");
    scripts\sp\utility::anim_stopanimScripted();
  }

  scripts\sp\utility::anim_stopanimScripted();
}

_id_3572() {
  scripts\engine\utility::flag_wait("flag_c12_return_gate");
  self notify("c12_new_goal");
  scripts\engine\utility::flag_wait("stealth_street_entered");
  self notify("c12_new_goal");
  scripts\engine\utility::flag_wait("streets2_start_c12_move");
  self notify("c12_new_goal");
}

_id_3625() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("street2_c12_teleport_start", "targetname");
  scripts\engine\utility::flag_wait("stealth_street_entered");

  if(scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg"))
    scripts\engine\utility::delaycall(1, ::_meth_81D0);
  else {
    self notify("c12_stealth_stop_idle");
    self notify("stop_going_to_node");
    self _meth_80F1(var_0.origin, var_0.angles);
    thread _id_35E5(var_0);
  }

  if(self._id_290A == 1)
    thread _id_1B34();
}

_id_35E5(var_0) {
  self endon("death");
  level endon("stealth_spotted");
  self.target = var_0.targetname;

  for(;;) {
    var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
    var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    self notify("c12_new_goal");
    self setgoalpos(var_2.origin);
    self.target = var_2.targetname;
    scripts\engine\utility::waittill_multiple("goal", "c12_started_patrol_idle");

    if(isDefined(var_2._id_EDA0))
      scripts\engine\utility::flag_wait(var_2._id_EDA0);

    if(isDefined(var_2._id_EF15))
      wait(var_2._id_EF15);
  }
}

_id_1B34() {
  while(!isDefined(level._id_10E6D.group.groups["2"]))
    wait 1;

  scripts\engine\utility::flag_set("stealth_spotted");
}

_id_10F28() {
  if(isDefined(self.bt._id_71C9))
    self[[self.bt._id_71C9]]();

  var_0 = getEnt("c12_street_omni_a", "targetname");
  var_1 = getEnt("c12_street_omni_b", "targetname");
  var_2 = getEnt("c12_street_spot_a", "targetname");
  var_0.origin = (0, 0, 0);
  var_0.angles = (0, 0, 0);
  var_0 linkTo(self, "J_Clavicle_Inner_RI", (10, -7, 1), (0, 0, 0));
  var_1.origin = (0, 0, 0);
  var_1.angles = (0, 0, 0);
  var_1 linkTo(self, "J_Clavicle_Inner_LE", (10, -7, 1), (0, 0, 0));
  var_2.origin = (0, 0, 0);
  var_2.angles = (0, 0, 0);
  var_2 linkTo(self, "J_frontCamera", (4.5, 4, -1), (0, 90, 0));
  thread _id_10F26();
  self waittill("death");
  var_0 setlightintensity(0);
  var_1 setlightintensity(0);
  var_2 setlightintensity(0);
  var_0.origin = var_0.origin + (0, 0, 15000);
  var_1.origin = var_1.origin + (0, 0, 15000);
  var_2.origin = var_2.origin + (0, 0, 15000);
}

_id_10F26() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkTo(self, "J_frontCamera", (4.5, 4, -1), (0, 90, 0));
  var_1 = scripts\engine\utility::getfx("c12_headlight");
  playFXOnTag(var_1, var_0, "tag_origin");
  self waittill("death");
  var_0 delete();
}

_id_3557() {
  level.player endon("death");
  self endon("death");
  self notify("stop_going_to_node");
  scripts\engine\utility::flag_set("stealth_spotted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 _meth_84F7("attack", level.player, level.player.origin);

  var_4 = getEntArray("c12_street_player_volumes", "targetname");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  self.goalradius = 512;
  scripts\sp\maps\titan\titan_code::_id_3550("left", 1);
  _id_0A05::_id_3551(1);
  _id_0A05::_id_3552(0);
  self.favoriteenemy = level.player;

  for(;;) {
    self setgoalpos(getclosestpointonnavmesh(level.player.origin, self));
    wait(randomfloatrange(3.0, 5.0));
  }
}

_id_3618() {
  self endon("death");

  while(self cansee(level.player) == 0)
    wait 0.5;

  self notify("c12_spotted");
}

_id_3512() {
  self endon("death");
  scripts\engine\utility::waittill_any("damage", "bulletwhizby", "c12_spotted", "bullethit", "missile_hit");
  self._id_9B59 = 1;
  self notify("c12_stealth_stop_idle");
  scripts\engine\utility::flag_set("stealth_spotted");
}

_id_D26C() {
  self endon("death");
  self endon("disable_player_rocket_launched");

  while(!scripts\engine\utility::flag("stealth_spotted")) {
    self waittill("weapon_fired");
    var_0 = getweaponbasename(self getcurrentweapon());

    if(!isDefined(var_0) || var_0 != "iw7_lockon") {
      continue;
    }
    wait(randomfloatrange(0.25, 0.35));
    scripts\engine\utility::flag_set("stealth_spotted");
  }
}

_id_35E0() {
  self endon("death");
  var_0 = getEnt("streets2_c12_nogo_trig", "targetname");

  for(;;) {
    if(self istouching(var_0))
      scripts\engine\utility::flag_set("street_c12_is_near");
    else
      scripts\engine\utility::flag_clear("street_c12_is_near");

    wait 1;
  }
}

_id_10F09() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("street1_crawl_fence_flag");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_throughhere");
  scripts\engine\utility::flag_wait("streets1_crawl_start");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_sittightsir");
  wait 0.5;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_whatdyagotkash");
  wait 0.5;
  scripts\sp\maps\titan\titan_code::_id_48BD(["titan_ksh_enemymegapatrol", "titan_omr_rogerthat"]);
  wait 0.25;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_twoguardsinside");
  scripts\engine\utility::flag_wait("building1_interior_clear");
  wait 1.5;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_onemorefarentra");
  _id_31ED();
  scripts\engine\utility::flag_wait("stealth_building1_exit");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_lookoutincomingmech");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_adviseskippingp");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_copythat");
}

_id_31ED() {
  while(!isDefined(level._id_10E6D.group.groups["building1_interior"]))
    wait 1;

  var_0 = _id_0F27::_id_79F5("building1_interior");

  if(!var_0.size) {
    return;
  }
  var_1 = var_0[0];
  var_1 waittill("death", var_2);
  wait 1.2;

  if(isDefined(var_2)) {
    if(var_2 == level.player)
      scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_down");
    else
      scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_clear");
  }
}

_id_8E2B(var_0) {
  _id_0B77::_id_8409(var_0, undefined, ::_id_8E3A, 400, ::_id_8E3B);
}

_id_8E3A(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "building3_attack":
        if(scripts\engine\utility::flag("building3_player_outside"))
          _id_31F8();

        break;
      default:
        break;
    }
  }
}

_id_8E3B(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "omar_takedown":
        _id_C492();
        break;
      default:
        break;
    }
  }
}

_id_31F8() {
  var_0 = _id_0F27::_id_79F5("4");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_65E1("stealth_attack");

  wait 2;

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 scripts\sp\utility::_id_54C6();
  }
}

_id_C49A() {
  level endon("player_entered_exit_building");
  scripts\engine\utility::flag_wait("stealth_street_entered");
  level._id_C494 = scripts\sp\utility::_id_107EA("omar_takedown_enemy", 1);
  level._id_C494 _id_C498();
  level._id_C47F _id_C492();
}

_id_C498() {
  self endon("death");
  self setModel("body_sdf_army_light_1");
}

_id_C492() {
  level endon("omar_takedown_interupted");
  level endon("player_entered_exit_building");
  level endon("stealth_spotted");
  level._id_C494 endon("start_context_melee");
  var_0 = scripts\engine\utility::getStruct("omar_melee", "targetname");
  scripts\engine\utility::flag_wait("street_building1_enter");
  setmusicstate("");
  thread stealth_broken_music();

  if(!isDefined(level._id_C494)) {
    return;
  }
  if(scripts\engine\utility::flag("stealth_spotted")) {
    return;
  }
  if(self._id_1FBB == "generic") {
    return;
  }
  level._id_C494 endon("death");
  level._id_C494 thread _id_C495();
  level._id_C494 thread _id_C49B();
  scripts\engine\utility::delaythread(1.5, scripts\sp\maps\titan\titan_code::_id_134B7, "titan_omr_igotthisone");
  level thread _id_C493();

  while(!scripts\engine\utility::flag("omar_fence_crawl_complete"))
    scripts\engine\utility::waitframe();

  level endon("stop_omar_takedown");
  thread omar_takedown_threat_monitor();
  var_0 scripts\sp\anim::_id_1F17(level._id_C47F, "generic_takedown");
  level thread scripts\sp\utility::_id_C12D("omar_takedown_interupt_over", 0.6);
  level notify("stop_omar_takedown_enemy_convo");
  var_1 = getanimlength(level._id_C494 scripts\sp\utility::_id_7DC1("generic_takedown"));
  var_0 thread scripts\sp\anim::_id_1F2C([level._id_C47F, level._id_C494], "generic_takedown");
  level._id_C494._id_BFE4 = 1;
  level._id_C494 thread _id_C497();
  level waittill("omar_takedown_knife_attached");
  scripts\engine\utility::flag_set("omar_knife_is_attached");
  level._id_C47F scripts\sp\utility::_id_F415(0);
}

omar_takedown_threat_monitor() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1B44) && var_2 scripts\sp\maps\titan\titan_code::_id_9B55())
      level notify("stop_omar_takedown");
  }
}

_id_C497() {
  self endon("death");
  self._id_C3C8 = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  level waittill("omar_takedown_interupted");
  self.maxsightdistsqrd = self._id_C3C8;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

_id_C496(var_0) {
  level endon("streets3_convoy_start");
  self endon("death");
  wait(var_0);
  self _meth_83A1();

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  self.allowdeath = 1;
  self.a.nodeath = 1;
  scripts\sp\utility::_id_19D3();
}

_id_C493() {
  level endon("omar_takedown_interupted");
  level endon("stop_omar_takedown_enemy_convo");
  level._id_C494 endon("death");
  var_0 = ["titan_sf1_wishicouldvebee", "titan_sf2_youreherebecaus", "titan_sf1_theywouldhavesu", "titan_sf2_wedidsucceednow"];

  foreach(var_2 in var_0) {
    level._id_C494 scripts\sp\utility::play_sound_on_entity(var_2);
    wait 0.15;
  }
}

_id_C499() {
  self endon("death");
  self._id_1FBB = "enemy";
  scripts\engine\utility::flag_wait("street_building1_enter");
  self.fixednode = 0;
  self.allowdeath = 0;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self._id_28CF = 0;
  self._id_10265 = 1;
  level waittill("omar_takedown_knife_detached");
  scripts\engine\utility::flag_clear("omar_knife_is_attached");
}

_id_C495() {
  level endon("omar_takedown_interupt_over");
  level endon("omar_knife_detached");
  self endon("death");
  self endon("custom_player_melee");
  self endon("stealth_alertlevel_change");

  if(!isDefined(self._id_B14F))
    thread scripts\sp\utility::_id_B14F();

  while(isalive(self)) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      level notify("omar_takedown_interupted");
      thread _id_244C(var_0);

      if(scripts\engine\utility::flag("omar_fence_crawl_complete"))
        level._id_C47F thread scripts\sp\maps\titan\titan_code::_id_10FC2();

      if(scripts\engine\utility::flag("omar_knife_is_attached")) {
        level._id_C47F detach("tactical_knife_iw7", "TAG_INHAND");
        level notify("omar_knife_detached");
      }

      return;
    }
  }
}

_id_C49B() {
  self endon("death");
  level endon("omar_takedown_interupt_over");
  self endon("custom_player_melee");
  level endon("omar_knife_detached");
  self.ignoreme = 1;
  self waittill("stealth_alertlevel_change");

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  self.ignoreme = 0;
  level notify("omar_takedown_interupted");

  if(scripts\engine\utility::flag("omar_fence_crawl_complete"))
    level._id_C47F thread scripts\sp\maps\titan\titan_code::_id_10FC2();

  level._id_C47F scripts\sp\utility::_id_F39C(self);

  if(scripts\engine\utility::flag("omar_knife_is_attached")) {
    level._id_C47F detach("tactical_knife_iw7", "TAG_INHAND");
    level notify("omar_knife_detached");
  }
}

_id_C48E() {
  level endon("stealth2_start");
  var_0 = getnode("omar_pool_slide_start", "targetname");
  var_1 = "pool_slide";
  var_2 = scripts\engine\utility::getStruct("omar_pool_climb_start", "targetname");
  var_3 = "pool_climb";
  self.fixednode = 1;
  self._id_C3EE = self.goalradius;
  scripts\sp\utility::_id_F3E0(8);
  self _meth_8250(1);
  self waittill("goal");

  if(scripts\engine\utility::flag("flag_omar_start_slide"))
    var_0 scripts\sp\anim::_id_1F35(self, var_1);
  else {
    scripts\engine\utility::flag_wait("flag_omar_start_slide");
    var_0 scripts\sp\anim::_id_1F35(self, var_1);
  }

  self _meth_8250(0);
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_15F5("omar_streets1_colortrig_climb");
  thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_keepitdarkcapta");
  self waittill("goal");
  var_4 = getanimlength(scripts\sp\utility::_id_7DC1(var_3));

  if(scripts\engine\utility::flag("flag_omar_start_climb")) {
    thread _id_C487();

    if(!scripts\engine\utility::flag("headshot_victim_dead"))
      scripts\sp\utility::_id_15F5("street1_colortrig_00");

    var_2 scripts\sp\anim::_id_1F35(self, var_3);
    scripts\sp\utility::_id_61C7();
  } else {
    scripts\engine\utility::flag_wait("flag_omar_start_climb");
    thread _id_C487();

    if(!scripts\engine\utility::flag("headshot_victim_dead"))
      scripts\sp\utility::_id_15F5("street1_colortrig_00");

    var_2 scripts\sp\anim::_id_1F35(self, var_3);
    scripts\sp\utility::_id_61C7();
  }

  scripts\engine\utility::flag_wait("omar_moveto_fence");
  scripts\sp\utility::_id_15F5("street1_colortrig_01");
  thread _id_C481();
  scripts\engine\utility::flag_wait("street1_crawl_fence_flag");
}

_id_C487() {
  scripts\engine\utility::flag_wait("headshot_victim_dead");
  wait 2;

  if(!scripts\engine\utility::flag("omar_moveto_fence")) {
    scripts\sp\maps\titan\titan_code::_id_10FC2();
    scripts\sp\utility::_id_61C7();
    scripts\sp\utility::_id_15F5("omar_streets1_colortrig_barricade");
  }
}

_id_C481() {
  self endon("skip_fence_crawl");
  var_0 = scripts\engine\utility::getStruct("omar_fence_crawl_struct", "targetname");
  var_1 = "fence_crawl";
  self.goalradius = 4;
  self waittill("goal");

  if(scripts\engine\utility::flag("street1_crawl_fence_flag")) {
    scripts\engine\utility::delaycall(0.6, ::playsound, "scn_titan_stealth_omar_crawl_mud");
    var_0 scripts\sp\anim::_id_1F35(self, var_1);
  } else {
    scripts\engine\utility::flag_wait("street1_crawl_fence_flag");
    scripts\engine\utility::delaycall(0.6, ::playsound, "scn_titan_stealth_omar_crawl_mud");
    var_0 scripts\sp\anim::_id_1F35(self, var_1);
  }

  scripts\sp\utility::_id_61C7();
  scripts\engine\utility::flag_set("omar_fence_crawl_complete");
}

_id_C491() {
  var_0 = getnode("streets2_start_node", "targetname");
  scripts\engine\utility::flag_wait_any("streets1_closed", "stealth2_start");

  if(!scripts\engine\utility::flag("omar_fence_crawl_complete")) {
    level._id_C47F notify("skip_fence_crawl");
    level._id_C47F scripts\sp\maps\titan\titan_code::_id_10FC2();
    level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
    level._id_C47F scripts\sp\utility::_id_61C7();
  }
}

_id_11126() {
  var_0 = getEnt("streets1_fence_blocker", "targetname");
  var_1 = getEnt("streets1_fence_blocker_coll", "targetname");
  var_2 = scripts\engine\utility::getStruct("streets1_fence_blocker_dest1", "targetname");
  var_3 = scripts\engine\utility::getStruct("streets1_fence_blocker_dest2", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
  scripts\engine\utility::flag_wait("streets1_begin");
  var_1 solid();
  var_1 disconnectPaths();
  scripts\engine\utility::flag_wait("omar_fence_crawl_complete");
  var_0 moveTo(var_2.origin, 0.1);
  var_0 rotateTo(var_2.angles, 0.1);
  wait 0.1;
  var_0 moveTo(var_3.origin, 0.1);
  var_0 rotateTo(var_3.angles, 0.1);
  wait 0.1;
  scripts\engine\utility::flag_set("streets1_closed");
}

_id_31EF() {
  _id_1300D();
  scripts\sp\maps\titan\titan_friendly_follow::_id_EA10();
  playFXOnTag(scripts\engine\utility::getfx("flashlight_spotlight_odin_bright"), self, "tag_flash");
  self waittill("death");

  if(isDefined(self) && scripts\sp\utility::hastag(self.model, "tag_flash"))
    stopFXOnTag(scripts\engine\utility::getfx("flashlight_spotlight_odin_bright"), self, "tag_flash");
}

_id_31EE() {
  scripts\engine\utility::flag_wait("building1_searcher_kill_flag");

  if(isDefined(self) && isalive(self))
    magicbullet(level._id_C47F.weapon, level._id_C47F gettagorigin("tag_flash"), self getEye());

  wait 0.25;

  if(isalive(self))
    self _meth_81D0(self.origin, level._id_C47F);
}

_id_8E36() {
  _id_0F27::_id_57C7();
  scripts\sp\maps\titan\titan_friendly_follow::_id_8E38();
  level thread scripts\sp\maps\titan\titan_friendly_follow::_id_B7D2([self]);

  if(!scripts\engine\utility::flag("stealth_spotted"))
    _id_0F18::_id_10E8B("hidden");
}

_id_6797() {
  level endon("streets3_convoy_start");
  level endon("ethan_streets3_takedown_interrupted");
  var_0 = scripts\engine\utility::getStruct("ethan_street3_takedown_struct", "targetname");
  scripts\sp\utility::_id_22CA("ethan_streets_takedown_enemy", ::_id_244B);
  scripts\engine\utility::flag_wait("start_ethan_streets3_takedown");
  level._id_2429 scripts\sp\maps\titan\titan_code::_id_10FC2();
  var_0 scripts\sp\anim::_id_1F17(level._id_2429, "ethan_street3_takedown");

  if(!scripts\engine\utility::flag("dropship_building_exited")) {
    var_1 = scripts\sp\utility::_id_107EA("ethan_streets_takedown_enemy", 1);
    var_1._id_BFE4 = 1;
    var_2 = [var_1, level._id_2429];
    var_3 = getanimlength(var_1 scripts\sp\utility::_id_7DC1("ethan_street3_takedown"));
    level thread scripts\sp\utility::_id_C12D("ethan_takedown_interrupt_over", 2.5);
    var_0 thread scripts\sp\anim::_id_1F2C(var_2, "ethan_street3_takedown");
    thread sfx_ethan_takedown();
    thread scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_guardsinside");
    var_1 thread _id_6798(var_0);
    var_1 _id_244A(var_3);
    level notify("ethan_streets3_takedown_complete");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_weregood");
  } else
    scripts\engine\utility::flag_set("ethan_takedown_skipped");
}

sfx_ethan_takedown() {
  var_0 = spawn("script_origin", level._id_2429.origin);
  var_0 linkTo(level._id_2429);
  var_0 playSound("scn_titan_eth3n_melee_takedown");
  level scripts\engine\utility::waittill_any("ethan_streets3_takedown_interrupted", "ethan_streets3_takedown_complete");
  var_0 scripts\sp\utility::_id_10460(0.3);
}

_id_6798(var_0) {
  level endon("ethan_takedown_interrupt_over");
  self endon("death");
  scripts\engine\utility::flag_wait("dropship_building_exited");
  level notify("ethan_streets3_takedown_interrupted");
  _id_244C(150);
  level._id_2429 thread scripts\sp\maps\titan\titan_code::_id_10FC2();
  level._id_2429 scripts\sp\utility::_id_F39C(self);
  self.allowdeath = 1;
  self.a._id_5605 = 0;
  self.allowpain = 1;
  self._id_28CF = 1;
  self._id_10265 = undefined;
}

_id_2447() {
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  level endon("streets3_convoy_start");
  scripts\sp\utility::_id_22CA("atom_takedown_enemy", ::_id_244B);
  scripts\engine\utility::flag_wait("atom_takedown");

  if(level.player scripts\sp\utility::_id_65DF("player_retract_shield_active") && level.player scripts\sp\utility::_id_65DB("player_retract_shield_active")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("atom_takedown", "targetname");
  level._id_2429._id_11461 = spawnStruct();
  level._id_2429._id_11461.origin = var_0.origin;
  level._id_2429._id_11461.angles = var_0.angles;
  level._id_2449 = scripts\sp\utility::_id_107EA("atom_takedown_enemy", 1);
  thread scripts\sp\anim::_id_1EC2(level._id_2449, "atom_takedown", var_0.origin, var_0.angles);
  level._id_2429.ignoreall = 1;
  level._id_2429 scripts\sp\utility::_id_4145();
  level endon("atom_takedown_interupted");
  var_1 = [level._id_2449, level._id_2429];
  var_0 scripts\sp\anim::_id_1F17(level._id_2429, "atom_takedown");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_2449, "atom_takedown");
  level._id_2429._id_11461 scripts\sp\anim::_id_1F35(level._id_2429, "atom_takedown");
  level notify("atom_takedown_complete");
  level._id_2429 scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("takedown_complete");
  level._id_2429.ignoreall = 0;
}

_id_2451() {
  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level._id_2429.origin, cos(65)) && level.player cansee(level._id_2429))
    return 0;

  return 1;
}

_id_244B() {
  self._id_1FBB = "enemy";
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self._id_28CF = 0;
  self._id_10265 = 1;
  self.diequietly = 1;
}

_id_244A(var_0) {
  level endon("atom_takedown_interupted");
  level endon("streets3_convoy_start");
  wait(var_0 - 2.5);
  self _meth_83A1();
  self _meth_81D0();
  self startragdoll();
}

_id_244F() {
  level endon("atom_takedown_complete");
  level endon("streets3_convoy_start");
  thread scripts\sp\utility::_id_B14F();

  while(isalive(self)) {
    self waittill("damage", var_0, var_1);

    if(isDefined(level._id_2429._id_38DE)) {
      return;
    }
    if(var_1 == level.player) {
      level notify("atom_takedown_interupted");
      thread _id_244C(var_0);
      level._id_2429 thread _id_2448();
      return;
    }
  }
}

_id_244C(var_0) {
  self endon("death");
  thread scripts\sp\maps\titan\titan_code::_id_10FC2();
  self.maxsightdistsqrd = 1000;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.newenemyreactiondistsq = 150;
  self.allowdeath = 1;
  self.a._id_5605 = 0;
  self.allowpain = 1;
  self._id_28CF = 0;
  self._id_10265 = undefined;

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();
}

_id_2448() {
  thread scripts\sp\maps\titan\titan_code::_id_10FC2();
  level._id_2429.ignoreall = 0;
}

_id_134BB() {
  level endon("stealth_buddy_door_clear");
  var_0 = getEnt("buddy_door_room_hint_area", "script_noteworthy");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(scripts\engine\utility::flag("stealth_buddy_door_clear")) {
      return;
    }
    if(var_1 == level.player)
      wait 7;
  }
}

_id_10F2C() {
  var_0 = scripts\engine\utility::getfx("vfx_light_stealth_red_01");
  var_1 = scripts\engine\utility::getfx("vfx_light_stealth_blue_01");
  var_2 = scripts\engine\utility::getfx("vfx_light_stealth_white_01");

  foreach(var_4 in scripts\engine\utility::getStructArray("light_red", "targetname"))
  playFX(var_0, var_4.origin);

  foreach(var_4 in scripts\engine\utility::getStructArray("light_white", "targetname"))
  playFX(var_2, var_4.origin);

  foreach(var_4 in scripts\engine\utility::getStructArray("light_blue", "targetname"))
  playFX(var_1, var_4.origin);
}

_id_134B5() {
  level endon("second_encounter_enemies_dead");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_spotted");

    if(scripts\engine\utility::cointoss())
      var_0 = "titan_usf_werespottedfind";
    else
      var_0 = "titan_usf_theyvespottedus";

    scripts\sp\maps\titan\titan_code::_id_134B7(var_0);
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("buddy_door_room_entered"))
      scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_thisareasclearno");
  }
}

buddy_down_dialogue() {
  var_0 = scripts\sp\utility::_id_7B27("last_building_entrance");
  var_1 = 0;
  var_2 = [];

  while(!var_1) {
    if(level._id_2429 istouching(var_0) && !scripts\engine\utility::array_contains(var_2, level._id_2429))
      var_2 = scripts\engine\utility::add_to_array(var_2, level._id_2429);

    if(level._id_C47F istouching(var_0) && !scripts\engine\utility::array_contains(var_2, level._id_C47F))
      var_2 = scripts\engine\utility::add_to_array(var_2, level._id_C47F);

    if(var_2.size == 2)
      var_1 = 1;

    wait 0.05;
  }
}

bucket() {
  var_0 = getEntArray("last_building", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2._id_BE5E = createnavobstaclebybounds(var_2.origin, (55, 55, 55), (0, 0, 0), "axis");
}

_id_10F35() {
  level._id_10F2B = [];
  level._id_10F2B["prone"] = 400;
  level._id_10F2B["crouch"] = 600;
  level._id_10F2B["stand"] = 800;
  level._id_10F33 = [];
  level._id_10F33["prone"] = 800;
  level._id_10F33["crouch"] = 1500;
  level._id_10F33["stand"] = 3000;
  _id_0F27::_id_F353(level._id_10F2B, level._id_10F33);
  var_0 = [];
  var_0["sight_dist"] = 200;
  var_0["detect_dist"] = 100;
  var_0["found_dist"] = 75;
  _id_0F19::_id_F30E(var_0);
  var_1["ai_eventDistDeath"]["spotted"] = 384;
  var_1["ai_eventDistDeath"]["hidden"] = 384;
  var_1["ai_eventDistPain"]["spotted"] = 192;
  var_1["ai_eventDistPain"]["hidden"] = 192;
  var_1["ai_eventDistExplosion"]["spotted"] = 1536;
  var_1["ai_eventDistExplosion"]["hidden"] = 1536;
  var_1["ai_eventDistBullet"]["spotted"] = 48;
  var_1["ai_eventDistBullet"]["hidden"] = 48;
  var_1["ai_eventDistFootstep"]["spotted"] = 150;
  var_1["ai_eventDistFootstep"]["hidden"] = 75;
  var_1["ai_eventDistFootstepWalk"]["spotted"] = 75;
  var_1["ai_eventDistFootstepWalk"]["hidden"] = 38;
  var_1["ai_eventDistFootstepSprint"]["spotted"] = 300;
  var_1["ai_eventDistFootstepSprint"]["hidden"] = 200;
  var_1["ai_eventDistGunShot"]["spotted"] = 1536;
  var_1["ai_eventDistGunShot"]["hidden"] = 1536;
  var_1["ai_eventDistSilencedShot"]["spotted"] = 96;
  var_1["ai_eventDistSilencedShot"]["hidden"] = 96;
  var_1["ai_eventDistGunShotTeam"]["spotted"] = 535;
  var_1["ai_eventDistGunShotTeam"]["hidden"] = 535;
  var_1["ai_eventDistNewEnemy"]["spotted"] = 96;
  var_1["ai_eventDistNewEnemy"]["hidden"] = 96;
  _id_0F23::_id_F395(var_1);
  _id_0F23::_id_6806("hidden");
}

_id_10F07() {}

_id_1300D() {
  wait 0.1;
  _id_0F27::_id_F4C8("seek");
}

_id_10EF4() {
  self._id_10E6D._id_24CB = 800;
  thread _id_6482();
}

_id_6482() {
  self endon("death");
  wait 0.15;

  if(!isDefined(self._id_10E6D)) {
    return;
  }
  self.health = 45;
  scripts\sp\utility::_id_65E3("stealth_attack");
  self.health = self.health + 105;
}

_id_64EB() {
  self endon("death");
  var_0 = "titan_usf_hesalerted";
  var_1 = "titan_usf_heseesus";
  level._id_4B8F = var_0;
  level._id_C480 = 0;

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("stealth_alertlevel_change", "stealth_attack");

    if(distance(self.origin, level.player.origin) <= 600) {
      if(!scripts\engine\utility::flag("stealth_spotted") && !level._id_C480) {
        level._id_C480 = 1;
        wait 0.5;

        if(!isalive(self)) {
          level._id_C480 = 0;
          return;
        }

        scripts\sp\maps\titan\titan_code::_id_134B7(level._id_4B8F);
        wait 6;
        level._id_C480 = 0;
      }
    }

    level._id_4B8F = scripts\engine\utility::ter_op(level._id_4B8F == var_0, var_1, var_0);
  }
}

_id_10AA4(var_0) {
  level endon("second_encounter_enemies_dead");
  var_1 = "stealth_spotted";

  for(;;) {
    scripts\engine\utility::flag_wait(var_1);
    thread _id_10AA3(var_0);
    scripts\engine\utility::flag_waitopen(var_1);
    level notify("stop_spreading_enemies");
  }
}

_id_10AA3(var_0) {
  level endon("stop_spreading_enemies");
  var_1 = 0;

  if(!isDefined(var_0))
    var_0 = 1000;

  for(;;) {
    while(length(level.player getvelocity()) > 90)
      wait 0.05;

    var_2 = getaiarray("axis");

    if(var_2.size == 0) {
      wait 2;
      continue;
    }

    if(var_2.size == 1) {
      var_2[0] setgoalentity(level.player);
      wait 3;
      continue;
    }

    if(var_0 < 700 && !var_1)
      var_1 = 1;

    var_3 = _id_79B1(var_0);
    var_4 = 0;

    foreach(var_6 in var_2) {
      var_6 thread _id_841E(var_3[var_4]);
      var_4++;

      if(var_4 == 3)
        var_4 = 0;

      wait 0.65;
    }

    wait(randomintrange(10, 15));
    var_0 = var_0 * 0.8;

    if(var_0 < 400)
      var_0 = 400;
  }
}

_id_79B1(var_0) {
  var_1 = [];
  var_2 = randomintrange(500, 900);
  var_1[0] = level.player scripts\sp\maps\titan\titan_code::_id_79D9(var_0, level.player.angles);
  var_1[1] = level.player scripts\sp\maps\titan\titan_code::_id_7C16(var_1[0], var_2);
  var_1[2] = level.player scripts\sp\maps\titan\titan_code::_id_7C16(var_1[0], var_2, 1);
  return var_1;
}

_id_841E(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self endon("death");
  self notify("new_cover_spot");
  self endon("new_cover_spot");
  self allowedstances("crouch", "stand", "prone");
  self.fixednode = 0;
  self.attackeraccuracy = 0.25;
  self.combatmode = "cover";
  self._id_EDB0 = 0;
  self.goalradius = 500;
  self setgoalpos(var_0);
  self waittill("goal");
  var_1 = self _meth_80E3();

  if(isDefined(var_1)) {
    if(isDefined(self.node) && var_1 == self.node)
      return var_1;
    else {
      self _meth_82EE(var_1);
      return var_1;
    }
  } else {
    var_2 = 5;
    var_3 = 250;

    for(var_4 = 0; var_4 < var_2; var_4++) {
      var_1 = self _meth_80E5(var_3);

      if(!isDefined(var_1)) {
        var_3 = var_3 + 75;
        continue;
      }

      if(isDefined(self.node) && var_1 == self.node)
        return var_1;
      else {
        self _meth_82EE(var_1);
        return var_1;
      }
    }

    var_5 = randomint(100);

    if(var_5 < 33)
      self allowedstances("prone");
    else if(var_5 < 66)
      self allowedstances("crouch");
  }
}

buddy_down_damage_thread() {
  scripts\sp\maps\titan\titan_code::_id_BC52("buddy_door_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  scripts\sp\maps\titan\titan_code::_id_BC71("buddy_door_ai", level._id_8E42);
  level._id_C47F _id_8E36();
  level._id_2429 _id_8E36();
  scripts\engine\utility::flag_set("buddy_door_room_entered");
  scripts\engine\utility::exploder("cell_storm_2");
}

buddy_boost_restart() {
  foreach(var_1 in level._id_8E42)
  var_1.script_pushable = 0;

  level notify("stop_wind_gusts");
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  var_3 = level._id_C47F;
  thread _id_73DD(var_3);

  if(isDefined(level._id_1111E))
    level._id_1111E delete();

  var_4 = scripts\engine\utility::getStruct("squeeze_through", "targetname");
  level._id_C47F thread _id_C490(var_4);
  level._id_2429 thread _id_6782();
  level waittill("stealth_street3_exited");
}

_id_134BA() {
  level.player scripts\sp\utility::play_sound_on_entity("titan_usf_brookskashimawerepushing");
  level.player scripts\sp\utility::play_sound_on_entity("titan_usf_Igotcha");
}

buddy_down() {
  scripts\engine\utility::flag_set("buddy_door_room_entered");

  if(isDefined(level._id_8E42))
    scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_F3B5, "r");
}

_id_9B80() {
  var_0 = getEntArray("buddy_door_building_trigs", "script_noteworthy");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_0) {
    foreach(var_5 in var_1) {
      if(var_5 istouching(var_3))
        return 0;
    }
  }

  return 1;
}

_id_119DD() {
  if(scripts\engine\utility::flag("stealth_spotted")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(scripts\sp\maps\titan\titan_code::_id_65EC(var_2, level.player, 900))
        return 1;
    }
  }

  return 0;
}

buddy_boost() {
  var_0 = level.doors["stealth_street_exit"];
  var_0 _id_0B1F::_id_5982(scripts\sp\maps\titan\titan_anim::_id_11112, scripts\sp\maps\titan\titan_anim::_id_11113, scripts\sp\maps\titan\titan_anim::_id_11111);
  var_0 _id_0B1F::_id_59EB("scn_titan_bnkr_door_open_grab", "scn_titan_bnkr_door_open_start", "scn_titan_bnkr_door_open_lp", "scn_titan_bnkr_door_shut", "scn_titan_bnkr_door_open_finish");
  var_0._id_28B6 = "left_door_01";
}

_id_73DD(var_0) {
  var_0 scripts\sp\utility::_id_54F7();
  var_0._id_73B7 = undefined;

  if(!var_0 scripts\sp\utility::_id_65DF("override_follow_mode"))
    var_0 scripts\sp\utility::_id_65E0("override_follow_mode");

  var_0 scripts\sp\utility::_id_65E1("override_follow_mode");
  level._id_2429 scripts\sp\utility::_id_54F7();
  var_1 = [var_0, level._id_2429];
  var_2 = level.doors["stealth_street_exit"];
  var_2._id_D83A = 100;
  _id_C49C();
  var_2 thread _id_0B1F::_id_168A(var_1);
  var_2 thread _id_C483();
  var_2 thread _id_D033();
  var_2 thread _id_676C();
  setmusicstate("mx_193_titan_buddydoor");
  thread stealth_broken_music();
  var_2 scripts\sp\utility::_id_65E3("door_sequence_complete");
  level notify("stealth_street3_exited");
  var_0._id_73B7 = 1;
  var_0 scripts\sp\utility::_id_65DD("override_follow_mode");
  scripts\sp\utility::_id_10FEC("cell_storm_2");
}

stealth_broken_music() {
  scripts\engine\utility::flag_wait("stealth_spotted");
  setmusicstate("mx_382_titan_stealth");
  wait 6;
  scripts\engine\utility::flag_waitopen("stealth_spotted");
  setmusicstate("");
}

_id_C49C() {
  var_0 = scripts\engine\utility::getStruct("omar_buddy_door_teleport", "targetname");
  var_1 = distance(level.player.origin, level._id_C47F.origin);

  if(var_1 > 600) {
    level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
    level._id_C47F scripts\sp\maps\titan\titan_code::_id_10FC2();
    level._id_C47F scripts\sp\utility::_id_F415(1);
    wait 1;
  }
}

_id_C483() {
  scripts\sp\utility::_id_65E3("omar_at_door");
  thread _id_C482();
  scripts\sp\utility::_id_65E3("omar_door_sequence_complete");
  level._id_C47F notify("omar_move_to_squeeze");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_Igotcha");
}

_id_C482() {
  self endon("player_at_door");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  self endon("player_used_door");

  if(!scripts\sp\utility::_id_65DB("player_used_door")) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_letsgetthisdoor");
    wait 10;
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_gottapressupthe");
  }
}

_id_D033() {
  scripts\sp\utility::_id_65E3("player_used_door");
  level notify("player_at_streets_exit_door");
  thread _id_0E26::_id_DFC1();
  var_0 = getaiarray("axis");
  scripts\sp\utility::_id_228A(var_0);
  thread scripts\sp\maps\titan\gen\titan_art::_id_99F6(0.1, undefined, "buddy_door_streets3_complete", 5, 120, 1.6);

  if(!scripts\sp\utility::_id_65DB("omar_at_door")) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_givemeahandgeton");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_brookskashimawerepushing1");
  }
}

_id_676C() {
  scripts\sp\utility::_id_65E3("atom_door_sequence_complete");
  scripts\engine\utility::flag_set("buddy_door_streets3_complete");
  level._id_2429 notify("ethan_move_to_squeeze");
}

_id_E227(var_0) {
  var_1 = self._id_1FBB + "_door_sequence_complete";
  var_0 scripts\sp\utility::_id_65E3(var_1);
  self._id_1EFF = undefined;
}

_id_1025E(var_0, var_1, var_2) {}

_id_F3A4(var_0) {
  var_0 scripts\sp\utility::_id_65E3("actor_at_door");
  scripts\engine\utility::flag_set("buddy_door_opened");
}

_id_F09F() {
  scripts\sp\maps\titan\titan_code::_id_BC52("second_encounter_player");
  thread _id_F09A();
  scripts\engine\utility::flag_set("player_buddy_door_hallway");
  scripts\sp\maps\titan\titan_code::_id_10758();
  level._id_C47F _id_8E36();
  level._id_2429 _id_8E36();
  scripts\sp\maps\titan\titan_code::_id_BC71("second_encounter_ai", level._id_8E42);
  thread _id_CCF8();
  scripts\engine\utility::flag_set("stealth_squeeze_through_complete");
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  scripts\engine\utility::exploder("fx_apc_zone_lensflare_on");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119C2();
}

_id_F0A0() {
  level._id_F096 = [];
  level._id_F096["prone"] = 70;
  level._id_F096["crouch"] = 600;
  level._id_F096["stand"] = 1024;
  level._id_F09D = [];
  level._id_F09D["prone"] = 512;
  level._id_F09D["crouch"] = 5000;
  level._id_F09D["stand"] = 8000;
  _id_0F27::_id_F353(level._id_F096, level._id_F09D);
  var_0 = [];
  var_0["sight_dist"] = 1500;
  var_0["detect_dist"] = 256;
  var_0["found_dist"] = 96;
  _id_0F19::_id_F30E(var_0);
  _id_0F23::_id_6806("hidden");
  thread scripts\sp\maps\titan\titan_code::_id_12D90("titan_stealth2");
}

_id_F099() {
  scripts\engine\utility::flag_wait("stealth_squeeze_through_complete");
  level.player scripts\sp\utility::_id_10350("titan_slt_copyairdropcargoincoming");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119C2();
  level._id_2429 scripts\sp\utility::_id_72EC("iw7_crb", "primary");
  level._id_C47F scripts\sp\utility::_id_72EC("iw7_fhr", "primary");
  scripts\engine\utility::flag_wait("second_encounter_enemies_dead");
  scripts\sp\maps\titan\titan_friendly_follow::_id_1017F();
  scripts\sp\maps\titan\titan_friendly_follow::_id_10180();
  level notify("stop_friendly_door_blocker_monitoring");
  level notify("stop_spreading_enemies");
  scripts\sp\utility::_id_E81F("apc_dropoff_color_trigs", scripts\engine\utility::trigger_off);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_thatsthelastof");
}

_id_F09E() {
  scripts\sp\utility::_id_E81F("apc_dropoff_color_trigs", scripts\engine\utility::trigger_off);
}

_id_F118() {
  scripts\engine\utility::flag_wait("flag_vo_seeker_crate");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_theresacrateof");
}

_id_F0A2() {
  scripts\engine\utility::flag_wait("flag_vo_second_encounter_ambush");

  if(!scripts\engine\utility::flag("second_encounter_enemies_dead")) {
    foreach(var_1 in self) {
      if(isalive(var_1) && var_1.alertlevelint > 1)
        return;
    }

    scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_Thenletsclearthe");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_Onyou2");
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_theresacrateof");
  }
}

_id_F09A() {
  scripts\engine\utility::flag_wait("second_encounter_approach");
  _id_6DC2();
  var_0 = getEnt("dropoff_building_enemies", "targetname");
  var_1 = getEnt("dropoff_hobo_enemies", "targetname");
  var_2 = getEntArray("second_encounter_enemies", "targetname");
  var_3 = scripts\sp\utility::_id_22C6(var_2);
  var_3 thread _id_F0A2();
  var_3 thread _id_F093();
  scripts\engine\utility::flag_wait("stealth_squeeze_through_complete");
  scripts\engine\utility::flag_wait("stealth_spotted");
  _id_0F27::_id_558C();
  scripts\engine\utility::array_thread(var_3, ::_id_F094, var_0, var_1);
  scripts\sp\utility::_id_E81F("apc_dropoff_color_trigs", scripts\engine\utility::trigger_off);
  var_4 = getEnt("dropoff_hero_volume", "targetname");
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_F095, var_4);
  scripts\sp\utility::_id_13754(var_3, var_3.size);
  scripts\engine\utility::flag_set("second_encounter_enemies_dead");
}

_id_F095(var_0) {
  thread scripts\sp\maps\titan\titan_friendly_follow::_id_1017F();
  thread scripts\sp\maps\titan\titan_friendly_follow::_id_10180();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.dontevershoot = undefined;
  self _meth_82F1(var_0);
  thread scripts\sp\utility::_id_F2DA(1);
  wait 3;

  for(;;) {
    level endon("second_encounter_enemies_dead");
    var_1 = self _meth_80E3();
    self _meth_82EE(var_1);
    wait(randomfloatrange(9, 17));
  }
}

_id_F093() {
  scripts\sp\utility::_id_13754(self, 1);
  var_0 = scripts\sp\utility::array_removedeadvehicles(self);

  foreach(var_2 in self)
  var_2 thread _id_0F1B::_id_10E20();

  scripts\engine\utility::flag_set("stealth_spotted");
}

_id_F094(var_0, var_1) {
  if(isDefined(self) && isDefined(self.script_noteworthy) && self.script_noteworthy == "dropoff_building_enemies")
    thread _id_F38D(var_0);
  else if(isDefined(self) && isDefined(self.script_noteworthy) && self.script_noteworthy == "dropoff_hobo_enemies")
    thread _id_F38D(var_1);
}

_id_F38D(var_0) {
  self _meth_82F1(var_0);
}

_id_10B25() {
  scripts\sp\maps\titan\titan_code::_id_BC52("squeeze_through_player");
  scripts\engine\utility::flag_set("player_buddy_door_hallway");
  scripts\sp\maps\titan\titan_code::_id_10758();
  scripts\sp\maps\titan\titan_code::_id_BC71("squeeze_through_ai", level._id_8E42);
  level._id_C47F _id_8E36();
  level._id_2429 _id_8E36();
  thread _id_CCF8();
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  thread _id_F0A0();
  setaudiotriggerstate("default", "wind_heavy", 0);
  setaudiotriggerstate("titan_ext", "wind_heavy", 0);
  setaudiotriggerstate("indoorrooms", "wind_heavy", 0);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119C2();
  level notify("stealth_street3_exited");
}

_id_10B24() {
  _id_F0A0();
}

_id_10B23() {
  _id_F0A0();
  thread _id_F09A();
  thread scripts\sp\maps\titan\titan_code::_id_D250(2);
  var_0 = scripts\engine\utility::getStruct("squeeze_through", "targetname");
  scripts\engine\utility::flag_wait("player_buddy_door_hallway");

  foreach(var_2 in level._id_8E42)
  var_2.script_pushable = 0;

  level._id_6457 = scripts\sp\vehicle::_id_1080C("courtyard_enemy_dropship");
  level._id_6457 castspotshadows(0);
  thread _id_10B20(var_0);
  _id_10B1D(var_0);

  foreach(var_2 in level._id_8E42) {
    var_2 scripts\sp\utility::_id_F3B5("r");
    var_2 scripts\sp\utility::_id_61C7();
    var_2.ignoreall = 0;
    var_2.script_pushable = 1;
  }

  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119C2();
}

_id_C490(var_0) {
  self waittill("omar_move_to_squeeze");
  thread _id_10B1F(var_0);
}

_id_6782() {
  self waittill("ethan_move_to_squeeze");
  thread _id_10B1C();
}

_id_10B1D(var_0) {
  scripts\engine\utility::flag_wait("squeeze_through_briefing_start");
  var_1 = [level.player._id_1E9C, level._id_C47F, level._id_2429];
  thread _id_10B22();
  var_0 scripts\sp\anim::_id_1F2C(var_1, "squeeze_through_exit");
}

_id_10B22() {
  wait 1;
  var_0 = level.player._id_1E9C._id_117C;

  while(level.player._id_1E9C._id_117C == var_0)
    wait 0.05;

  scripts\sp\maps\titan\titan_code::_id_DF3D(level.player._id_1E9C);
  level.player scripts\engine\utility::allow_stances(1);
  level.player._id_1E9C hide();
  scripts\engine\utility::flag_set("stealth_squeeze_through_complete");
  thread scripts\sp\utility::_id_266F();
  wait 10;
  scripts\engine\utility::exploder("fx_apc_zone_lensflare_on");
}

_id_10B20(var_0) {
  if(!isDefined(level.player._id_1E9C))
    level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_0.origin, var_0.angles);
  else {
    level.player._id_1E9C.origin = var_0.origin;
    level.player._id_1E9C.angles = var_0.angles;
  }

  level.player._id_1E9C hide();
  var_0 scripts\sp\anim::_id_1EC3(level.player._id_1E9C, "squeeze_through_intro");

  for(;;) {
    if(scripts\engine\utility::flag("player_can_squeeze") && level.player getstance() == "crouch" && scripts\engine\utility::flag("squeeze_through_omar_middle")) {
      break;
    }

    wait 0.05;
  }

  wait 0.05;

  if(!level.console)
    waitforalltransients();

  var_1 = level._id_EC85["player_rig"]["squeeze_through_intro"];
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_stances(0);
  thread scripts\sp\maps\titan\gen\titan_art::_id_99F6(0.1, 10.0, undefined, 10, 350, 2.0);
  thread scripts\sp\maps\titan\gen\titan_art::_id_99F6(8.0, undefined, "eyes_on_second_encounter", 10, 400, 1.16);
  level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1, 30, 20, 15, 5, 1);
  level.player._id_1E9C show();
  level.player freezecontrols(0);
  level.player._id_1E9C _meth_82B1(var_1, 0.5);
  var_0 scripts\sp\anim::_id_1F35(level.player._id_1E9C, "squeeze_through_intro");
  scripts\engine\utility::flag_wait("squeeze_through_allow_input");
  thread _id_10B21(var_0);
}

_id_10B21(var_0) {
  var_1 = level._id_EC85["player_rig"]["squeeze_through"];
  var_0 thread scripts\sp\anim::_id_1F35(level.player._id_1E9C, "squeeze_through");
  var_2 = getanimlength(var_1);
  var_3 = 1;
  var_4 = 0.1;
  var_5 = 0.85;
  var_6 = 0;

  for(;;) {
    var_7 = level.player getnormalizedmovement()[0];
    var_7 = clamp(var_7, 0, 1);
    var_8 = scripts\sp\math::_id_6A8E(0, var_5, var_7);
    var_3 = var_3 + (var_8 - var_3) * var_4;

    if(var_7 > 0)
      level.player._id_1E9C _meth_82B1(var_1, var_3);
    else
      level.player._id_1E9C _meth_82B1(var_1, 0);

    var_9 = level.player._id_1E9C islegacyagent(var_1);

    if(var_9 >= 0.5 && !var_6) {
      var_6 = 1;
      level._id_6457 playSound("scn_enemy_dropship_takeoff");
      level._id_6457 thread scripts\sp\vehicle_paths::_id_845A();
    } else if(var_9 == 1) {
      scripts\engine\utility::flag_set("squeeze_through_briefing_start");
      scripts\engine\utility::flag_set("eyes_on_second_encounter");
      return;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("squeeze_through_end");
}

_id_10B1C() {
  var_0 = getnode("atom_squeeze", "targetname");

  if(!scripts\sp\utility::_id_65DF("override_follow_colors"))
    scripts\sp\utility::_id_65E0("override_follow_colors");

  level._id_2429 scripts\sp\utility::_id_65E1("override_follow_colors");

  if(!scripts\sp\utility::_id_65DF("override_follow_mode"))
    scripts\sp\utility::_id_65E0("override_follow_mode");

  level._id_2429 scripts\sp\utility::_id_65E1("override_follow_mode");
  level._id_2429 scripts\sp\utility::_id_54F7();
  level._id_2429 _meth_82EE(var_0);
}

_id_10B1F(var_0) {
  if(!scripts\sp\utility::_id_65DF("override_follow_colors"))
    scripts\sp\utility::_id_65E0("override_follow_colors");

  scripts\sp\utility::_id_65E1("override_follow_colors");
  scripts\sp\utility::_id_65E1("override_follow_mode");
  scripts\sp\utility::_id_54F7();
  self.ignoreall = 1;
  self._id_1EEF = spawnStruct();
  self._id_1EEF.origin = var_0.origin;
  self._id_1EEF.angles = var_0.angles;
  self._id_1EEF scripts\sp\anim::_id_1F17(self, "squeeze_through_intro");
  wait 0.01;

  if(!level.console)
    waitforalltransients();

  var_1 = ["squeeze_through_intro", "squeeze_through_enter", "squeeze_through_move_end"];
  var_2 = 200;

  foreach(var_4 in var_1) {
    self._id_1EEF scripts\sp\anim::_id_1F35(self, var_4);

    if(var_4 == "squeeze_through_intro") {
      var_5 = level._id_EC85["omar"]["squeeze_through_intro"];
      thread _id_10B27(var_5, "squeeze_through_omar_middle", 1.0);
    }

    if(var_4 == "squeeze_through_enter") {
      var_6 = level._id_EC85["omar"]["squeeze_through_enter"];
      thread _id_10B27(var_6, "squeeze_through_allow_input", -6);
    }

    if(var_4 == "squeeze_through_move_end" && !scripts\engine\utility::flag("squeeze_through_briefing_start")) {
      self._id_1EEF thread scripts\sp\anim::_id_1EEA(self, var_4 + "_idle");
      scripts\engine\utility::flag_wait("squeeze_through_briefing_start");
      self._id_1EEF notify("stop_loop");
      return;
    } else if(distance2d(self.origin, level.player.origin) > var_2 && var_4 != "squeeze_through_intro") {
      self._id_1EEF thread scripts\sp\anim::_id_1EEA(self, var_4 + "_idle");

      while(distance2d(self.origin, level.player.origin) > var_2)
        wait 0.05;

      self._id_1EEF notify("stop_loop");
    }
  }
}

_id_10B27(var_0, var_1, var_2) {
  var_3 = getanimlength(var_0);
  wait(var_3 + var_2);
  scripts\engine\utility::flag_set(var_1);
}

_id_2A0E() {
  scripts\sp\utility::_id_E81F("apc_dropoff_color_trigs", scripts\engine\utility::trigger_off);
  scripts\sp\maps\titan\titan_code::_id_BC52("beacon_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  var_0 = scripts\engine\utility::getStruct("beacon_ai_omar", "targetname");
  var_1 = scripts\engine\utility::getStruct("beacon_ai_ethen", "targetname");
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
  level._id_2429 _meth_80F1(var_1.origin, var_1.angles);
  setaudiotriggerstate("default", "nowind", 0);
  setaudiotriggerstate("titan_ext", "nowind", 0);
  setaudiotriggerstate("indoorrooms", "nowind", 0);
  thread scripts\sp\maps\titan\titan_code::_id_D250(2);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  scripts\engine\utility::exploder("fx_apc_zone_lensflare_on");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_119C2();
}

_id_2A08() {
  scripts\sp\utility::_id_2669("titan_beacon_moment");
  _id_29FE();
}

_id_2A0C() {
  scripts\engine\utility::flag_set("second_encounter_enemies_dead");
  scripts\sp\maps\titan\titan_code::_id_557D();
  var_0 = getEntArray("stealth_shadow", "targetname");
  scripts\sp\utility::_id_228A(var_0);

  if(isDefined(level._id_C47F))
    level._id_C47F scripts\sp\maps\titan\titan_code::_id_8DEC(0);
}

_id_29FE() {
  scripts\engine\utility::flag_clear("stealth_spotted");
  scripts\sp\maps\titan\titan_code::_id_557D();
  setglobalsoundcontext("wind", "none", 4.0);
  setaudiotriggerstate("default", "nowind", 10);
  setaudiotriggerstate("titan_ext", "nowind", 10);
  setaudiotriggerstate("indoorrooms", "nowind", 4);
  scripts\engine\utility::flag_set("stop_wind_emitters");
  var_0 = getEntArray("stealth_shadow", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  level._id_2A07 = spawnStruct();
  var_1 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  level._id_2A07.node = var_1;
  level._id_2A07._id_B357 = 0;
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_54F7);
  thread _id_B352();
  thread _id_2A14();
  scripts\engine\utility::waitframe();

  foreach(var_3 in level._id_B351)
  var_3 thread _id_B34C();

  _id_8E48();
  level waittill("show_beacon_prompt");
  scripts\engine\utility::flag_wait_all("beacon_omar_in_pos", "beacon_ethan_in_pos");
  _id_2A03();
  level._id_C47F notify("beacon_scene_started");
  level._id_C47F scripts\sp\maps\titan\titan_code::_id_8DEC(0);
  level._id_C47F thread scripts\sp\interaction::_id_CD4F("titan_beacon_smoke_scene");
  wait 2.1;
  _id_134B8();
  level._id_C47F _meth_82EE(getnode("beacon_omar_node", "targetname"));
  level._id_2429 _meth_82EE(getnode("beacon_atom_node", "targetname"));
  level._id_B33B _meth_82EE(getnode("beacon_brooks_node", "targetname"));
  level._id_B33E _meth_82EE(getnode("beacon_kashima_node", "targetname"));
  scripts\sp\utility::_id_22A4(level._id_8E42, "move_to_apc");
  thread _id_29FF();

  while(level._id_2A07._id_B357 < 2)
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_22A4(level._id_B351, "move_to_apc");
}

_id_29FF() {
  level._id_2A07.node scripts\sp\anim::_id_1F35(level._id_2429, "beacon_exit");
}

_id_B352() {
  scripts\sp\maps\titan\titan_code::_id_10764();
  var_0[0] = scripts\engine\utility::getStruct("beacon_tp_ksh", "targetname");
  var_0[1] = scripts\engine\utility::getStruct("beacon_tp_brk", "targetname");

  foreach(var_4, var_2 in var_0) {
    var_3 = 0;

    while(!var_3) {
      if(!scripts\sp\utility::_id_13D91(level.player.origin, level.player.angles, var_2.origin, cos(25))) {
        if(!_id_0B1D::_id_385D(var_2.origin))
          var_3 = 1;
      }

      wait 0.05;
    }

    level._id_B351[var_4] _meth_80F1(var_2.origin, var_2.angles, 20000);
  }
}

_id_B34C() {
  scripts\sp\maps\titan\titan_code::_id_10FC2();
  self notify("stop_group_split_idle");
  thread scripts\sp\anim::_id_1F12(self);
  self.allowpain = 0;
  self._id_29DC = spawn("script_origin", level._id_2A07.node.origin);
  self._id_29DC.angles = level._id_2A07.node.angles;
  self._id_29DC scripts\sp\anim::_id_1F17(self, "beacon_intro");
  self._id_29DC scripts\sp\anim::_id_1F35(self, "beacon_intro");
  self._id_29DC thread scripts\sp\anim::_id_1EEA(self, "beacon_idle", "stop_loop");
  self.allowpain = 1;
  level._id_2A07._id_B357++;
  self waittill("move_to_apc");
  self._id_29DC notify("stop_loop");
}

_id_8E48() {
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_3B14, 200);

  foreach(var_1 in level._id_8E42) {
    var_1 clearenemy();
    var_1 notify("stop_going_to_node");
    var_1 notify("new_anim_reach");
    var_1 scripts\sp\utility::_id_F3DC(var_1.origin);
    var_1 scripts\sp\utility::_id_4145();
    var_1.allowpain = 0;
    var_1 thread _id_8E43();
  }

  thread _id_2A00();
}

_id_8E43() {
  var_0 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_2 = var_1.origin;
  var_3 = var_1.origin + (0, 0, 1);

  if(self == level._id_C47F) {
    var_1 scripts\sp\anim::_id_1F0D(self, "beacon_intro");
    var_1.origin = var_3;
    var_1 scripts\sp\anim::_id_1F35(self, "beacon_intro");
    var_1 thread scripts\sp\anim::_id_1EEA(self, "beacon_idle", "stop_loop");
    level notify("show_beacon_prompt");
    scripts\engine\utility::flag_set("beacon_omar_in_pos");
    self waittill("move_to_apc");
    var_1 notify("stop_loop");
    var_1.origin = var_2;
    self.allowpain = 1;
  } else {
    var_1 scripts\sp\anim::_id_1F0D(self, "beacon_intro");
    var_1 scripts\sp\anim::_id_1F35(self, "beacon_intro");
    var_1 thread scripts\sp\anim::_id_1EEA(self, "beacon_idle", "stop_loop");
    scripts\engine\utility::flag_set("beacon_ethan_in_pos");
    self waittill("move_to_apc");
    var_1 notify("stop_loop");
    self.allowpain = 1;
  }
}

_id_3B14(var_0) {
  var_1 = getstartorigin(level._id_2A07.node.origin, level._id_2A07.node.angles, scripts\sp\utility::_id_7DC1("beacon_intro"));

  while(distance2d(self.origin, var_1) > var_0)
    wait 0.05;

  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_2A00() {
  level._id_C47F endon("beacon_scene_started");
  var_0 = ["titan_usf_Readywhenyouare", "titan_usf_captainreesewereover"];

  for(;;) {
    foreach(var_2 in var_0) {
      wait(randomintrange(7, 9));

      while(distance2d(level.player.origin, level._id_C47F.origin) < 512)
        wait 0.05;

      scripts\sp\maps\titan\titan_code::_id_C48A(var_2);
    }

    wait 0.05;
  }
}

_id_2A14() {
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_Regrouponme");
  level._id_C47F scripts\sp\maps\titan\titan_code::_id_1962("hold");
}

_id_29EF(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_2 = 1;
  var_3 = anglesToForward(var_1.angles);
  var_4 = anglestoup(var_1.angles);
  wait(var_2);
  var_0 waittill("landed");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_beacon_light"), var_0._id_29D7, "tag_fx");
}

_id_2A09(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playSound("scn_titan_dropship_holo_on");
  wait 0.2;
  var_1 playLoopSound("scn_titan_dropship_holo_lp");
  scripts\engine\utility::flag_wait("dropships_inbound");
  wait 0.1;
  var_1 playSound("scn_titan_dropship_holo_off");
  var_1 stoploopsound();
  wait 3;
  var_1 delete();
}

_id_2A03() {
  level._id_C47F thread _id_0E46::_id_48C4("j_spine4", (3, -10, -5), undefined, undefined, 3000, 128);
  level._id_C47F waittill("trigger");
  scripts\sp\utility::_id_A6F2();
}

_id_134B8() {
  level.player thread scripts\sp\utility::_id_D091("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_1102B);
  level.player scripts\engine\utility::delaycall(3, ::playsound, "ges_plr_radio_off");
  level.player scripts\sp\utility::_id_10350("titan_plr_Sendit");
  scripts\engine\utility::flag_set("dropships_inbound");
}

_id_6DC2() {
  foreach(var_1 in getaiarray("axis")) {
    if(isDefined(var_1._id_B14F))
      var_1 scripts\sp\utility::_id_1101B();

    var_1 delete();
  }
}

_id_B353() {
  var_0 = scripts\engine\utility::getStructArray("marines_teleport", "targetname");
  scripts\engine\utility::array_thread(level._id_B351, scripts\sp\utility::_id_F416, 0);
  scripts\engine\utility::array_thread(level._id_B351, scripts\sp\utility::_id_F415, 0);
}

_id_CCF8() {
  level._id_3784 = [];
  level._id_E2A3 = [];
  level._id_3784["sf1"] = ["titan_sf1_sectorsweeping", "titan_sf1_ekiasfromc6", "titan_sf1_c8array", "titan_sf1_enemycontact"];
  level._id_E2A3["sf1"] = ["titan_sf1_affirmative", "titan_sf1_nocando"];
  level._id_3784["sf2"] = ["titan_sf2_statusupdate", "titan_sf2_shootonsight", "titan_sf2_sector9ongrid", "titan_sf2_youreclear", "titan_sf2_confirmthatlast"];
  level._id_E2A3["sf2"] = ["titan_sf2_rog", "titan_sf2_negative"];
  level._id_3784["sf3"] = ["titan_sf3_zuluteamreports", "titan_sf3_hqrevising", "titan_sf3_howcopy", "titan_sf3_jackalrefueling", "titan_sf3_prisoner627"];
  level._id_E2A3["sf3"] = ["titan_sf3_sayagain", "titan_sf3_standby"];
  level._id_3784["sf4"] = ["titan_sf4_negativeairsupport", "titan_sf4_gunshipsinbound", "titan_sf4_gazisdown", "titan_sf4_awaitingorders"];
  level._id_E2A3["sf4"] = ["titan_sf4_affirm", "titan_sf4_thatsanegative", "titan_sf4_stillunavailable"];
  level._id_1016A = [level._id_3784["sf1"], level._id_3784["sf2"], level._id_3784["sf3"], level._id_3784["sf4"]];
  level._id_1016A = scripts\engine\utility::array_randomize(level._id_1016A);
  var_0 = 5;
  var_1 = 12;

  for(;;) {
    foreach(var_3 in level._id_1016A) {
      var_3 = scripts\engine\utility::array_randomize(var_3);

      foreach(var_5 in var_3) {
        while(!getaiarray("axis").size)
          wait 2;

        var_6 = scripts\sp\utility::_id_78AA(level.player.origin, "axis");
        var_6 _id_CDD3(var_5);
        wait(randomintrange(var_0, var_1));
      }
    }

    wait 0.05;
  }
}

_id_CDD3(var_0) {
  self endon("death");
  scripts\sp\utility::play_sound_on_entity(var_0);
  wait(randomfloatrange(0.6, 2.3));
  var_1 = _id_7BF1(var_0);
  var_2 = scripts\sp\maps\titan\titan_code::_id_10169(2, level._id_E2A3[var_1]);
  scripts\sp\utility::play_sound_on_entity(var_2);
}

_id_7BF1(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1[1];
  var_3 = ["sf1", "sf2", "sf3", "sf4"];
  var_4 = scripts\engine\utility::array_remove(var_3, var_2);
  var_5 = scripts\sp\maps\titan\titan_code::_id_10169(3, var_4);
  return var_5;
}

_id_10F59(var_0, var_1, var_2) {
  level endon("stealthtakedownComplete");
  var_3 = spawnStruct();

  if(isDefined(var_2)) {
    level endon(var_2);
    var_3._id_C6BA = var_2;
  }

  var_3.enemies = var_0;
  var_3._id_7395 = var_1;
  var_3._id_D435 = undefined;
  var_3._id_7423 = undefined;
  var_3._id_10D8F = 0;
  var_3.finished = 0;
  var_3._id_4040 = undefined;
  level childthread _id_10F52(var_3);
  level childthread _id_10F56(var_3);
  level childthread _id_10F57(var_3);
  level childthread _id_10F54(var_3);
  scripts\engine\utility::array_thread(var_3.enemies, ::_id_10F53, var_3);
  level waittill("stealthtakedownComplete");
}

_id_10F57(var_0) {
  for(;;) {
    wait 0.5;

    foreach(var_2 in var_0.enemies) {
      if(!isalive(var_2)) {
        continue;
      }
      if(isDefined(var_2._id_10E6D)) {
        if(var_2._id_10E6D.state != 0 && !isDefined(var_0._id_D435)) {
          var_0._id_10D8F = 1;
          var_0._id_4040 = 0;

          foreach(var_2 in var_0.enemies) {
            if(isDefined(var_2._id_12FF) && var_2._id_12FF == "player_knife_kill")
              var_0._id_D435 = var_2;
          }

          if(!isDefined(var_0._id_D435))
            var_0._id_D435 = var_2;

          var_0._id_7395 notify("cleartoengage");
          return;
        }
      }
    }
  }
}

_id_10F52(var_0) {
  for(;;) {
    var_0.enemies = scripts\sp\utility::array_removedeadvehicles(var_0.enemies);

    if(var_0.enemies.size < 2) {
      return;
    }
    foreach(var_2 in var_0.enemies) {
      if(_id_D35D(var_2)) {
        wait 1;

        if(_id_D35D(var_2) && !var_0._id_10D8F && isalive(var_2)) {
          if(scripts\engine\utility::cointoss())
            scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_dropemcaptain");
          else
            scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_onyourgosir");

          return;
        }
      }
    }

    wait 0.5;
  }
}

_id_10F53(var_0) {
  if(isDefined(var_0._id_C6BA))
    self endon(var_0._id_C6BA);

  for(;;) {
    self waittill("damage", var_1, var_2);
    var_0._id_10D8F = 1;

    if(!isDefined(var_0._id_D435) && isDefined(var_2) && (var_2 == level.player || isDefined(var_2.asmname) && var_2.asmname == "seeker")) {
      var_0._id_D435 = self;

      if(isalive(self))
        self _meth_81D0(self.origin, level.player);
    }

    var_0._id_7395 notify("cleartoengage");
    return;
  }
}

_id_10F56(var_0) {
  var_0._id_7395 waittill("cleartoengage");
  wait 0.65;

  foreach(var_2 in var_0.enemies) {
    if(isDefined(var_0._id_D435) && var_0._id_D435 == var_2)
      continue;
    else if(!isDefined(var_0._id_D435)) {
      var_0._id_7423 = var_2;
      _id_10F55(var_0._id_7423, var_0);
    } else
      var_0._id_7423 = var_2;

    _id_10F55(var_0._id_7423, var_0);
  }
}

_id_10F55(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1._id_7395 shoot(10, var_0);
  wait 0.25;

  if(isalive(var_0) && !var_0.damageshield)
    var_0 _meth_81D0(var_0.origin, var_1._id_7395);
}

_id_10F54(var_0) {
  for(;;) {
    if(var_0._id_10D8F) {
      wait 1.65;

      if(isalive(var_0._id_D435)) {
        _id_10F55(var_0._id_D435, var_0);
        wait 0.35;
        scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_sloppyworkreyes");
        break;
      } else {
        wait 0.35;
        scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_targetsdown");
      }

      return;
    }

    wait 0.05;
  }

  var_0.finished = 1;
  level notify("stealthtakedownComplete");
}

_id_D35D(var_0) {
  if(!isalive(var_0))
    return 0;

  if(level.player adsButtonPressed() && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, cos(5))) {
    if(_id_0B1D::_id_385C(level.player getEye(), var_0))
      return 1;
  }

  return 0;
}

_id_D2E0() {
  level.player thread _id_0F24::main();
  level thread _id_0F21::_id_F5B6(1);
}

_id_D2DF() {
  level thread _id_0F21::_id_F5B6(0);
}

_id_F10F(var_0) {
  while(!isDefined(level._id_10E6D.group.groups[var_0]))
    wait 1;

  var_1 = _id_0F27::_id_79F5(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "seeker_enabled")
      var_3 _id_107D3();
  }
}

_id_107D3() {
  _id_0E26::_id_107D1(self, 0);
  thread _id_F10D();
  thread _id_F10B();
  thread _id_F14A();
}

_id_F10D() {
  if(!isDefined(self._id_F10A)) {
    return;
  }
  self._id_F10A._id_595E = 1;
  self._id_F10A.ignoreme = 1;
}

_id_F14A() {
  level endon("dropship_building_exited");
  scripts\engine\utility::waittill_any("damage", "bulletwhizby");
  wait(randomfloatrange(1.25, 2));
  scripts\engine\utility::flag_set("stealth_spotted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 _meth_84F7("attack", level.player, level.player.origin);
  }
}

_id_F10B() {
  if(!isDefined(self._id_F10A)) {
    return;
  }
  self endon("death");
  self._id_F10A endon("death");
  scripts\engine\utility::flag_wait("stealth_spotted");
  self._id_F10A._id_C93D = undefined;
  self._id_F10A.ignoreall = 0;
  self._id_F10A.ignoreme = 0;
  self._id_F10A._id_728A = level.player;
  self._id_F10A.favoriteenemy = level.player;
}

_id_6ED1(var_0) {
  while(!isDefined(level._id_10E6D.group.groups[var_0]))
    wait 1;

  var_1 = _id_0F27::_id_79F5(var_0);

  foreach(var_3 in var_1)
  var_3 thread _id_10F29();
}

_id_19D0(var_0) {
  self endon("death");
  self endon("stop_looping_gesture");

  for(;;) {
    scripts\sp\utility::_id_77B7(var_0);
    wait(randomfloatrange(3, 6));
  }
}