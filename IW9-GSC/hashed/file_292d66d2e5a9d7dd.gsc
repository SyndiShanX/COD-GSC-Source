/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_292d66d2e5a9d7dd.gsc
***********************************************/

_id_185D82A83A8485D6(objectivestruct) {
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\engine\utility::flag_init("elevator_reach_bottom");

  foreach(player in level.players)
  player scripts\cp\utility::allow_player_basejumping(0, "obj_silo");

  _id_12569E8D8459E544 = spawn("trigger_radius", (5509.98, 11522.2, 6610.2), 0, 2048, 4048);
  level.outofboundstriggers[level.outofboundstriggers.size] = _id_12569E8D8459E544;
  level thread scripts\cp\cp_outofbounds::watchoobtrigger(_id_12569E8D8459E544);
  level._id_12569E8D8459E544 = _id_12569E8D8459E544;
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  level._id_CF829458F676A8EF = 1;
  level.stealth.bstayincombatoncealerted = 1;
  _func_AA9FA9C5A97D0F6E(1);
  level thread _id_01B1A46EFB26E5A9::_id_1D8B88C55E1DA251();
  level thread _id_EC34594B7C37E880();
  level._id_142FFEF4BA6476C6 = elevator_init();
  level thread _id_6C79069826EA15C1();
  level _id_88936EE73B181E1E();
  waitframe();

  if(scripts\engine\utility::flag("goto_silo_2nd_stop") || scripts\engine\utility::flag("goto_silo_2nd_power")) {
    if(scripts\engine\utility::flag("goto_silo_2nd_power"))
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("silo", undefined, "started second power");
    else
      scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("silo", undefined, "started second stop");

    level._id_142FFEF4BA6476C6 _id_B30B5141A592A70F();
    level thread _id_7DDBEFE693B6CD03();
  } else {
    scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("silo");
    level._id_142FFEF4BA6476C6 thread _id_357E2B443EE2FA59();
    level thread _id_9C9008D0A364C465();
  }

  if(scripts\engine\utility::flag("goto_silo_2nd_power")) {
    level thread _id_F442577D391DB354();
    level thread _id_F34AB4F89EDFC099();
  }

  level._id_142FFEF4BA6476C6 thread elevator_think();
  level thread _id_8107D9089475D20C();
  level thread scripts\cp\killstreaks\airdrop_cp::_id_20C12AA7546FCAA5();
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("silo_end_door", 1, 250, "elevator_reach_bottom");
  level thread _id_F7643056E96E96AE();
  scripts\engine\utility::flag_wait("elevator_reach_bottom");

  if(!isDefined(level.tripwire_init)) {
    thread scripts\cp_mp\tripwire::init();
    level.tripwire_init = 1;
  }

  _id_5ACFC0760B417445 = getEnt("silo_end", "targetname");

  for(;;) {
    _id_5ACFC0760B417445 waittill("trigger", ent);

    if(isPlayer(ent)) {
      break;
    } else
      continue;
  }

  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_end");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("b1_silo_end_playerstart", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  scripts\cp\cp_analytics::_id_B6283AC45A607764("silo");
}

_id_88936EE73B181E1E() {
  _id_230C7BB3F08D2D78::_id_B0CA36875BE60C39(getEnt("silo_saw_pickup", "targetname"), 1);
  level._id_AFBA65BA56C47A5E = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("silo_door_objective", "targetname").origin);
  level._id_AFBA64BA56C4782B = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("silo_door_objective2", "targetname").origin);
  level._id_AFBA63BA56C475F8 = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("silo_door_objective3", "targetname").origin);
  _id_C130CE2E2A968C75 = [];
  door = getEnt("saw_door_intro_1", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("silo_door_cut", "targetname");
  _id_C130CE2E2A968C75[_id_C130CE2E2A968C75.size] = _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_AFBA65BA56C47A5E, interactionstruct.origin, "silo_door_cut");
  door = getEnt("saw_door_intro_2", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("silo_door2_cut", "targetname");
  _id_C130CE2E2A968C75[_id_C130CE2E2A968C75.size] = _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_AFBA64BA56C4782B, interactionstruct.origin, "silo_door2_cut");
  door = getEnt("saw_door_intro_3", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("silo_door3_cut", "targetname");
  _id_C130CE2E2A968C75[_id_C130CE2E2A968C75.size] = _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_AFBA63BA56C475F8, interactionstruct.origin, "silo_door3_cut");
  level._id_C130CE2E2A968C75 = _id_C130CE2E2A968C75;
  level thread _id_4E916A672E838B06();
  level thread _id_4E9169672E8388D3();
  level thread _id_4E9168672E8386A0();
  level thread _id_E3F218839E1E1801();
  level thread _id_26F88B4BA4C7D3D2();
}

_id_4E916A672E838B06() {
  scripts\engine\utility::flag_wait("silo_door_cut");
  clip = getEnt("silo_saw_clip_1", "targetname");
  door = getEnt("saw_door_intro_1", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
  _id_2F1BF7830DA89FF8();
}

_id_4E9169672E8388D3() {
  scripts\engine\utility::flag_wait("silo_door2_cut");
  clip = getEnt("silo_saw_clip_2", "targetname");
  door = getEnt("saw_door_intro_2", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
  _id_2F1BF7830DA89FF8();
}

_id_4E9168672E8386A0() {
  scripts\engine\utility::flag_wait("silo_door3_cut");
  clip = getEnt("silo_saw_clip_3", "targetname");
  door = getEnt("saw_door_intro_3", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
}

_id_2F1BF7830DA89FF8() {
  _id_0C4281EAA20D7F9B = scripts\engine\utility::getStructArray("silo_door_cut1", "targetname");
  _id_6936DF147A7672FC = scripts\engine\utility::getStructArray("silo_door_cut2", "targetname");

  foreach(interaction in _id_0C4281EAA20D7F9B) {
    if(isDefined(interaction) && isDefined(interaction.interact))
      interaction.interact makeunusable();
  }

  foreach(interaction in _id_6936DF147A7672FC) {
    if(isDefined(interaction) && isDefined(interaction.interact))
      interaction.interact makeunusable();
  }
}

_id_E3F218839E1E1801() {
  for(;;) {
    level waittill("saw_used", objectiveindex);

    if(objectiveindex == 3) {
      wait 1;
      _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("saw_entrance_wave1", "script_noteworthy");
      thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      wait 4;
      _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("saw_entrance_wave2", "script_noteworthy");
      thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      wait 6;
      thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      break;
    }
  }
}

_id_26F88B4BA4C7D3D2() {
  for(;;) {
    level waittill("saw_used", objectiveindex);

    if(objectiveindex == 1 || objectiveindex == 2) {
      wait 3;
      _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("saw_gen_room_wave1", "script_noteworthy");
      thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      wait 4;
      thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
      break;
    }
  }
}

elevator_init() {
  _id_EEC55FABA21F3653 = getEnt("silo_elevator", "targetname");
  _id_EEC55FABA21F3653._id_BD901692981B143A = getEnt("silo_elevator_rope", "targetname");
  _id_EEC55FABA21F3653 linkTo(_id_EEC55FABA21F3653._id_BD901692981B143A, "tag_elevator", (0, 0, 0), (0, 0, 0));
  _id_EEC55FABA21F3653._id_6F1AA4031135D230 = _id_EEC55FABA21F3653._id_BD901692981B143A.origin;
  _id_EEC55FABA21F3653._id_8530C9BF8F6A0276 = _id_EEC55FABA21F3653._id_BD901692981B143A.origin + (0, 0, -5774);
  _id_EEC55FABA21F3653._id_B639DBB74BD003BC = _id_EEC55FABA21F3653._id_BD901692981B143A.origin + (0, 0, -1276);
  _id_EEC55FABA21F3653._id_B639DEB74BD00A55 = _id_EEC55FABA21F3653._id_BD901692981B143A.origin + (0, 0, -3400);
  _id_1CA72225D98F7DD6 = getEntArray("silo_elevator_panels", "targetname");

  foreach(_id_9A01675C5F6B90A1 in _id_1CA72225D98F7DD6)
  _id_9A01675C5F6B90A1 linkTo(_id_EEC55FABA21F3653);

  _id_B8D865E526028EC2 = getEnt("silo_elevator_clip", "targetname");
  _id_B8D865E526028EC2 linkTo(_id_EEC55FABA21F3653);
  _id_EEC55FABA21F3653.clip = _id_B8D865E526028EC2;
  _id_EEC55FABA21F3653._id_7D66973885E513AB = spawn("script_origin", _id_EEC55FABA21F3653._id_BD901692981B143A.origin);
  _id_EEC55FABA21F3653._id_2F39D137AEBDB1C2 = spawn("script_origin", _id_EEC55FABA21F3653._id_BD901692981B143A.origin);
  _id_EEC55FABA21F3653._id_7D66973885E513AB.angles = _id_EEC55FABA21F3653._id_BD901692981B143A.angles;
  _id_EEC55FABA21F3653._id_2F39D137AEBDB1C2.angles = _id_EEC55FABA21F3653._id_BD901692981B143A.angles;
  _id_EEC55FABA21F3653 thread _id_0E65DD627540CB34();
  return _id_EEC55FABA21F3653;
}

_id_FEDEC9DB63A6C8EF() {
  level endon("game_ended");
  self endon("death");
  self.health = 250;

  if(getdvarint("dvar_635AD64FAB3AD914", 250) != 250)
    self.health = getdvarint("dvar_635AD64FAB3AD914", 250);

  self setCanDamage(1);
  self setCanRadiusDamage(1);

  for(;;) {
    self waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    self.health = self.health - _id_8BBC2903A2793B49;

    if(self.health <= 0)
      self delete();
  }
}

_id_357E2B443EE2FA59() {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  checkpoint = scripts\engine\utility::ter_op(checkpoint != "", checkpoint, getDvar("start"));

  if(scripts\engine\utility::_id_5B7E9A4C946F3A13(checkpoint, ["silo_power", "boss1_silo_power"])) {
    return;
  }
  startpos = self._id_BD901692981B143A.origin;
  self._id_BD901692981B143A.origin = self._id_BD901692981B143A.origin + (0, 0, -1000);
  level endon("game_ended");
  self endon("stop_moving");
  self endon("death");
  self._id_BD901692981B143A endon("death");
  self playLoopSound("evt_raid3_silo_elevator_move_lp");
  button = getEnt("silo_power_switch_0", "targetname");
  button makeusable();
  button setHintString(&"CP_RAID1_BOSS1/ELEVATOR_MOVING");
  button sethintinoperable(1);
  level thread _id_14EA8436B9568F19();
  level scripts\engine\utility::waittill_any_2("vo_spotElevator", "playerCloseToElevator");
  self._id_BD901692981B143A moveTo(startpos, 18);
  wait 18;
  self stoploopsound("evt_raid3_silo_elevator_move_lp");
  self playSound("evt_raid3_silo_elevator_stop");
  wait 0.5;
  earthquake(randomfloatrange(0.15, 0.21), 2, self.origin, 500);
  button setHintString(&"CP_RAID1_BOSS1/ELEVATOR_DOWN");
  button sethintinoperable(0);
  scripts\engine\utility::flag_set("elevator_raised");
}

_id_14EA8436B9568F19() {
  level endon("vo_spotElevator");
  level endon("game_ended");
  button = getEnt("silo_power_switch_0", "targetname");

  while(!scripts\cp\utility::any_player_nearby(button.origin, squared(1024)))
    wait 1;

  level notify("playerCloseToElevator");
}

elevator_think() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_9B1941CB7354665E = scripts\engine\utility::waittill_any_return_3("down", "stop");

    if(!isDefined(_id_9B1941CB7354665E)) {
      continue;
    }
    if(_id_9B1941CB7354665E == "stop") {
      thread _id_FDD2AB6268576FCC();
      continue;
    }

    thread elevator_move();
  }
}

_id_FDD2AB6268576FCC() {
  self notify("stop_moving");
  self endon("death");
  self playSound("evt_raid3_silo_elevator_stop");
  self stoploopsound("evt_raid3_silo_elevator_move_lp");
  wait 0.5;
  earthquake(randomfloatrange(0.15, 0.21), 2, self.origin, 500);
  wait 1;
}

elevator_move() {
  level endon("game_ended");
  self endon("stop_moving");
  self endon("death");
  self._id_BD901692981B143A endon("death");
  self playSound("evt_raid3_silo_elevator_start");
  self playLoopSound("evt_raid3_silo_elevator_move_lp");
  _id_67349707D2D7FEFD = 0.125;

  if(getdvarfloat("dvar_0566919EC11E968C", 0.125) != 0.125)
    _id_67349707D2D7FEFD = getdvarfloat("dvar_0566919EC11E968C", 0.125);

  for(;;) {
    earthquake(randomfloatrange(0.05, 0.1), 1, self.origin, 500);

    if(self._id_BD901692981B143A.origin[2] - 10 <= self._id_8530C9BF8F6A0276[2]) {
      self._id_476BDD32D16066DA = 1;
      scripts\engine\utility::flag_set("elevator_reach_bottom");
      self._id_BD901692981B143A moveTo(self._id_8530C9BF8F6A0276, _id_67349707D2D7FEFD);
      thread _id_FDD2AB6268576FCC();
      return;
    }

    self._id_BD901692981B143A movez(-10, _id_67349707D2D7FEFD);
    level._id_10C35EC751227DA5 movez(-10, _id_67349707D2D7FEFD);
    wait(_id_67349707D2D7FEFD);
  }
}

_id_0E65DD627540CB34() {
  level notify("elevatorSway");
  level endon("game_ended");
  level endon("elevatorSway");
  self endon("death");
  self._id_BD901692981B143A endon("death");

  while(scripts\cp\utility::_id_95E3A48DBAF38216())
    wait 0.1;

  _id_A5337F8300110201 = 0.45;
  _id_2EC0815DFA0F672E = 0.45;
  _id_3C5DF5BF59ED9678 = 180;
  reverse = 0;
  _id_EBF05B5978327EC0 = self._id_BD901692981B143A.angles[1] + 10;

  for(;;) {
    if(_id_EBF05B5978327EC0 > _id_3C5DF5BF59ED9678)
      reverse = 1;

    if(_id_EBF05B5978327EC0 < -180)
      reverse = 0;

    if(reverse)
      _id_EBF05B5978327EC0 = self._id_BD901692981B143A.angles[1] - 10;
    else
      _id_EBF05B5978327EC0 = self._id_BD901692981B143A.angles[1] + 10;

    self playSound("evt_raid3_silo_elevator_sway");
    self._id_BD901692981B143A rotateTo((_id_A5337F8300110201, _id_EBF05B5978327EC0, _id_2EC0815DFA0F672E), 5, 2, 2);
    wait 5;

    if(_id_EBF05B5978327EC0 > _id_3C5DF5BF59ED9678)
      reverse = 1;

    if(_id_EBF05B5978327EC0 < -180)
      reverse = 0;

    if(reverse)
      _id_EBF05B5978327EC0 = self._id_BD901692981B143A.angles[1] - 10;
    else
      _id_EBF05B5978327EC0 = self._id_BD901692981B143A.angles[1] + 10;

    self playSound("evt_raid3_silo_elevator_sway");
    self._id_BD901692981B143A rotateTo((_id_A5337F8300110201 * -1, _id_EBF05B5978327EC0, _id_2EC0815DFA0F672E * -1), 5, 2, 2);
    wait 5;
  }
}

_id_B30B5141A592A70F() {
  self._id_BD901692981B143A movez((0, 0, -3400)[2], 0.1);

  while(!isDefined(level._id_10C35EC751227DA5))
    waitframe();

  level._id_10C35EC751227DA5 movez((0, 0, -3400)[2] - 250, 0.1);
}

_id_CD3380A016493090() {
  return (0, 0, -3400)[2];
}

_id_E414B38B36DE2CE2() {
  self._id_BD901692981B143A movez((0, 0, -5774)[2], 0.1);
}

_id_1334B2364257FB07(_id_9469E42781D4A97E, delay, _id_C103BFC366A53063, _id_D153C3A40B959FE7) {
  level endon("game_ended");
  button = getEnt(_id_9469E42781D4A97E, "targetname");

  if(!isDefined(_id_C103BFC366A53063))
    _id_C103BFC366A53063 = &"CP_RAID1_BOSS1/POWER_ON";

  ent = _id_558A9A418B2D3405::_id_F9020783100CB7B2(button, _id_C103BFC366A53063);

  if(isDefined(ent)) {}

  wait(delay);
}

_id_9C9008D0A364C465() {
  level endon("game_ended");
  _id_80622D919893EB3C();
  level notify("elevator_button_pressed");
  level._id_142FFEF4BA6476C6 notify("down");
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_power");
  wait 4;
  _id_3A7057EA13B2908E("silo_spawngroup_1");
  wait 9;
  _id_3A7057EA13B2908E("silo_spawngroup_2");

  while(level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin[2] > level._id_142FFEF4BA6476C6._id_B639DBB74BD003BC[2])
    waitframe();

  level._id_142FFEF4BA6476C6 notify("stop");
  _id_CE15E68E59D99AE6 = getEnt("silo_power_switch_1", "targetname");
  _id_D2C70120BE3F5778 = getEnt("generator_1", "targetname");
  _id_CE15E68E59D99AE6 thread _id_170DEF6E8CFE801F();
  _id_1334B2364257FB07("silo_power_switch_1", 1);
  _id_D2C70120BE3F5778 _id_D8B31E7D66181956();
  level._id_142FFEF4BA6476C6 notify("down");
  level notify("silo_power_switch_1_pulled");
  wait 9;
  _id_3A7057EA13B2908E("silo_spawngroup_4");

  while(level._id_142FFEF4BA6476C6._id_BD901692981B143A.origin[2] > level._id_142FFEF4BA6476C6._id_B639DEB74BD00A55[2])
    waitframe();

  _id_D2C70120BE3F5778 = getEnt("generator_2", "targetname");
  _id_CE15E68E59D99AE6 = getEnt("silo_power_switch_2", "targetname");
  level._id_142FFEF4BA6476C6 notify("stop");
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_2nd_stop");
  level._id_10C35EC751227DA5 movez(-250, 0.1);
  _id_CE15E68E59D99AE6 thread _id_170DEF6E8CFE801F();
  _id_1334B2364257FB07("silo_power_switch_2", 2);
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_2nd_power");
  level thread _id_C1B0D62AC36C0D27();
  _id_D2C70120BE3F5778 _id_D8B31E7D66181956();
  level notify("silo_power_switch_2_pulled");
  level._id_142FFEF4BA6476C6 notify("down");
  level notify("enemy_reinforcements");
}

_id_7DDBEFE693B6CD03() {
  level endon("game_ended");
  _id_CE15E68E59D99AE6 = getEnt("silo_power_switch_2", "targetname");
  _id_CE15E68E59D99AE6 thread _id_170DEF6E8CFE801F();
  _id_1334B2364257FB07("silo_power_switch_2", 2);
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_2nd_power");
  level thread _id_C1B0D62AC36C0D27();
  _id_CE15E68E59D99AE6 _id_D8B31E7D66181956();
  level._id_142FFEF4BA6476C6 notify("down");
  level notify("enemy_reinforcements");
}

_id_3A7057EA13B2908E(groupname) {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(groupname, "targetname");
  group = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_9E4E1482CB40C9C5, 1);

  foreach(guy in group) {
    guy.goalradius = 48;

    if(isDefined(guy.spawner.target)) {
      pos = scripts\engine\utility::getStruct(guy.spawner.target, "targetname");
      nodes = getnodesinradius(pos.origin, 128, 0);
      guy usecovernode(scripts\engine\utility::getclosest(pos.origin, nodes));
    }
  }

  return group;
}

_id_170DEF6E8CFE801F() {
  playsoundatpos(self.origin, "evt_raid3_generator_stop");
  self stoploopsound("evt_raid3_generator_lp");
  wait 0.25;
}

_id_D8B31E7D66181956() {
  playsoundatpos(self.origin, "evt_raid3_generator_start");
  self playLoopSound("evt_raid3_generator_lp");
  self scriptmodelplayanim("iw9_cp_raid_diesel_generator_start");
  wait 4;
  self scriptmodelplayanim("iw9_cp_raid_diesel_generator_idle");
}

_id_E4BA482BCD4566DB() {
  wait 5;
  _id_00B2F2239FF08FFE = getEnt("silo_fil_connection", "targetname");

  for(;;) {
    touching = 0;

    foreach(player in level.players) {
      if(player istouching(_id_00B2F2239FF08FFE))
        touching++;
    }

    if(touching >= 1) {
      break;
    }

    wait 0.5;
  }

  scripts\engine\utility::flag_set("silo_end");
}

_id_3CAB251A752FBE38(objectivestruct) {
  scripts\engine\utility::flag_wait("silo_ready");
  scripts\engine\utility::flag_init("silo_end");
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_silo_end");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("silo_end");
  level._id_CF829458F676A8EF = undefined;
  level._id_D82FF154FFF994E7 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(!istrue(level.tripwire_init)) {
    thread scripts\cp_mp\tripwire::init();
    level.tripwire_init = 1;
    level thread _id_382959D7794736CC::_id_A0E2527CF709959D();
  }

  level thread _id_01B1A46EFB26E5A9::_id_49AD3A42842B4118();
  _id_594132FAB60AA90D::_id_246582E2CB860BCD();
  level thread _id_382959D7794736CC::_id_9EFDF9D69B3E813C();
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();

  if(!isDefined(level._id_142FFEF4BA6476C6)) {
    level._id_142FFEF4BA6476C6 = elevator_init();
    waitframe();
    level._id_142FFEF4BA6476C6 _id_E414B38B36DE2CE2();
  }

  level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
  wait 5;

  if(!istrue(level._id_B9E06F3785D1AC04)) {
    level thread _id_382959D7794736CC::_id_BF11D3FD19E18ABE();
    level._id_B9E06F3785D1AC04 = 1;
  }

  level thread _id_E4BA482BCD4566DB();
  scripts\engine\utility::flag_wait("silo_end");
  thread _id_FFEC324BD5085987();
  scripts\cp\cp_checkpoint::checkpoint_set("boss1_fil");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("fil_playerstart", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }

  scripts\cp\cp_analytics::_id_B6283AC45A607764("silo_end");
}

_id_8107D9089475D20C() {
  scripts\engine\utility::flag_init("silo_valve_complete");
  scripts\engine\utility::flag_init("silo_valve_ee_puzzle_completed");
  level thread _id_558A9A418B2D3405::_id_6C7AFDA240D43C96();
  _id_51E791B4D5448C42 = getEntArray("silo_ee_valve", "targetname");
  _id_637839EE4AE18CD8 = getEntArray("silo_ee_needle_1", "targetname");
  _id_63783CEE4AE19371 = getEntArray("silo_ee_needle_2", "targetname");
  _id_63783BEE4AE1913E = getEntArray("silo_ee_needle_3", "targetname");
  _id_63783EEE4AE197D7 = getEntArray("silo_ee_needle_4", "targetname");
  level._id_E8AFE4A6F6374A88 = getEnt("silo_ee_note", "targetname");

  if(isDefined(level._id_E8AFE4A6F6374A88))
    level._id_E8AFE4A6F6374A88 hide();

  setdvarifuninitialized("dvar_FDB40791AC68BE16", 0);
  level._id_3B89E22E62E3D672 = _id_51E791B4D5448C42;
  level thread _id_CC77EA943756403E(_id_637839EE4AE18CD8);
  scripts\engine\utility::array_thread(_id_51E791B4D5448C42, ::_id_B5720FC7FA6386D7, _id_63783EEE4AE197D7, _id_63783BEE4AE1913E, _id_63783CEE4AE19371);
}

_id_CC77EA943756403E(_id_6807D3BF426B1917) {
  level endon("silo_valve_complete");
  level endon("game_ended");
  level._id_DA375EE6274EACF8 = randomintrange(60, 200);

  foreach(_id_633CAFA47D2991FE in _id_6807D3BF426B1917)
  _id_633CAFA47D2991FE rotateroll(-220, 0.05);

  wait 0.1;

  foreach(_id_633CAFA47D2991FE in _id_6807D3BF426B1917) {
    _id_633CAFA47D2991FE.ogangles = _id_633CAFA47D2991FE.angles;
    _id_633CAFA47D2991FE rotateroll(level._id_DA375EE6274EACF8 * -1, 0.05);
  }

  for(;;) {
    wait 45;
    _id_4E2C8F59BEFD65D4 = randomintrange(60, 180);

    foreach(_id_633CAFA47D2991FE in _id_6807D3BF426B1917)
    _id_633CAFA47D2991FE.angles = _id_633CAFA47D2991FE.ogangles;

    level._id_DA375EE6274EACF8 = -1;
    wait 1;

    foreach(_id_633CAFA47D2991FE in _id_6807D3BF426B1917)
    _id_633CAFA47D2991FE rotateroll(_id_4E2C8F59BEFD65D4 * -1, 0.1);

    wait 0.01;
    level._id_DA375EE6274EACF8 = _id_4E2C8F59BEFD65D4;
  }
}

_id_B5720FC7FA6386D7(_id_2B03B72C8DD12D48, _id_816C95350772F759, _id_77C33F859BB7A07E) {
  scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/EE_VALVE_TURN", undefined, "duration_none", "hide", 96, 35, 72, 35);
  _id_6807D3BF426B1917 = scripts\engine\utility::array_combine(_id_2B03B72C8DD12D48, _id_816C95350772F759, _id_77C33F859BB7A07E);
  _id_1C1714273CCD15BA = scripts\engine\utility::getclosest(self.origin, _id_6807D3BF426B1917);

  switch (_id_1C1714273CCD15BA.targetname) {
    case "silo_ee_needle_4":
      self._id_021DFFAE375570BE = _id_2B03B72C8DD12D48;
      break;
    case "silo_ee_needle_3":
      self._id_021DFFAE375570BE = _id_816C95350772F759;
      break;
    case "silo_ee_needle_2":
      self._id_021DFFAE375570BE = _id_77C33F859BB7A07E;
      break;
  }

  level thread _id_4CC882C107CB6670();
  thread _id_EF64696BCBA4D267();
}

_id_4CC882C107CB6670() {
  level endon("game_ended");
  level endon("silo_valve_complete");

  for(;;) {
    _id_14DEF404993C3887 = 1;

    foreach(_id_05CE5B54E58D14C5 in level._id_3B89E22E62E3D672) {
      if(!istrue(_id_05CE5B54E58D14C5._id_78928AD4E7BBF9F6)) {
        _id_14DEF404993C3887 = 0;
        continue;
      }

      if(getdvarint("dvar_8BF37E0D79C52385", 0) > 0)
        _id_22C2229E5E39376A = 1;

      if(getdvarint("dvar_EC29E44A428ED339", 0) > 0)
        iprintlnbold("valve " + _id_05CE5B54E58D14C5.origin + " matching");
    }

    if(_id_14DEF404993C3887) {
      level thread _id_5C523B298008AA96();
      return;
    }

    waitframe();
  }
}

_id_EF64696BCBA4D267() {
  level endon("silo_valve_complete");
  level endon("game_ended");
  self._id_0AC5ACEB2230C3A5 = 0;
  self._id_D4FDE2EACFCDE2C9 = 260;
  self setModel("ee_pipe_05_valve_02_wheel");
  self.scenenode = spawnStruct();
  self.scenenode.origin = self.origin;
  self.scenenode.angles = vectortoangles(anglestoup(self.angles) * -1);
  thread _id_382959D7794736CC::_id_A0D3C7111B497557();

  foreach(_id_633CAFA47D2991FE in self._id_021DFFAE375570BE)
  _id_633CAFA47D2991FE rotateroll(-220, 0.05);

  for(;;) {
    self waittill("trigger", ent);

    if(!ent isonground() && !ent _meth_E40102956C887F7C()) {
      continue;
    }
    self._id_FEAF5D8BE6377441 = 1;
    self _meth_DFB78B3E724AD620(0);
    self notify("start_audio");
    wait 0.1;

    while(ent useButtonPressed() && distance(ent.origin, self.origin) < 64) {
      ent._id_5D43389756907528 = 1;

      if(self._id_0AC5ACEB2230C3A5 >= 260) {
        self notify("reached_max");
        self._id_0AC5ACEB2230C3A5 = 260;
        wait 0.05;
        continue;
      }

      foreach(_id_633CAFA47D2991FE in self._id_021DFFAE375570BE) {
        if(!isDefined(_id_633CAFA47D2991FE.ogangles))
          _id_633CAFA47D2991FE.ogangles = _id_633CAFA47D2991FE.angles;

        _id_633CAFA47D2991FE rotateroll(-1, 0.05);
      }

      self rotatepitch(1, 0.05);
      self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 + 1;
      _id_A8A89843FE7397A3();
      scripts\engine\utility::waittill_notify_or_timeout("rotatedone", 0.1);
    }

    if(ent scripts\cp\utility::is_valid_player(1))
      ent._id_5D43389756907528 = undefined;

    self._id_FEAF5D8BE6377441 = 0;
    thread _id_89B84A70186C3730();
    wait 0.25;
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_89B84A70186C3730() {
  level endon("silo_valve_complete");
  level endon("game_ended");
  self notify("stop_audio");
  wait 1;
  _id_CF70FB0CAB5AB856 = 3;

  if(!istrue(self._id_FEAF5D8BE6377441))
    self notify("start_depaudio");

  for(;;) {
    if(istrue(self._id_FEAF5D8BE6377441)) {
      self notify("stop_depaudio");
      return;
    }

    self rotatepitch(-1 * _id_CF70FB0CAB5AB856, 0.05);

    foreach(_id_633CAFA47D2991FE in self._id_021DFFAE375570BE)
    _id_633CAFA47D2991FE rotateroll(1 * _id_CF70FB0CAB5AB856, 0.05);

    self._id_0AC5ACEB2230C3A5 = self._id_0AC5ACEB2230C3A5 - 1 * _id_CF70FB0CAB5AB856;

    if(self._id_0AC5ACEB2230C3A5 < 0)
      self._id_0AC5ACEB2230C3A5 = 0;

    scripts\engine\utility::waittill_notify_or_timeout("rotatedone", 0.1);
    _id_A8A89843FE7397A3();

    if(self._id_0AC5ACEB2230C3A5 == 0) {
      self notify("stop_depaudio");

      foreach(_id_633CAFA47D2991FE in self._id_021DFFAE375570BE) {
        if(isDefined(_id_633CAFA47D2991FE.ogangles))
          _id_633CAFA47D2991FE.angles = _id_633CAFA47D2991FE.ogangles;
      }

      return;
    }
  }
}

_id_A8A89843FE7397A3() {
  if(_id_62215A4BF8913593(self._id_0AC5ACEB2230C3A5))
    self._id_78928AD4E7BBF9F6 = 1;
  else
    self._id_78928AD4E7BBF9F6 = 0;
}

_id_62215A4BF8913593(val) {
  return (val - level._id_DA375EE6274EACF8 - 4) * (val - level._id_DA375EE6274EACF8 + 4) <= 0;
}

_id_5C523B298008AA96() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("silo_valve_complete");
  scripts\engine\utility::flag_set("silo_valve_ee_puzzle_completed");

  foreach(_id_05CE5B54E58D14C5 in level._id_3B89E22E62E3D672) {
    _id_05CE5B54E58D14C5 _meth_DFB78B3E724AD620(0);
    earthquake(0.075, 1, _id_05CE5B54E58D14C5.origin, 500);
    playrumbleonposition("grenade_rumble", _id_05CE5B54E58D14C5.origin);
  }

  level notify("ee_valve_complete");
}

_id_73735189BE43ABA7() {
  self waittill("trigger", ent);
  ent thread _id_E8D3B1291B67AEBD(self);
  wait 0.35;
  self hide();
}

_id_E8D3B1291B67AEBD(_id_A234A65C378F3289) {
  self endon("death_or_disconnect");
  thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
  wait 0.35;
  self playlocalsound("iw9_br_pickup_key");
}

_id_EC34594B7C37E880() {
  level._id_967C31FE0BDF2752 = getEntArray("reinforcement_trigger", "targetname");

  foreach(trigger in level._id_967C31FE0BDF2752)
  trigger scripts\engine\utility::trigger_off();

  level waittill("enemy_reinforcements");

  foreach(trigger in level._id_967C31FE0BDF2752)
  trigger scripts\engine\utility::trigger_on();
}

_id_FFEC324BD5085987() {
  scripts\engine\utility::flag_set("silo_valve_complete");
  _id_51E791B4D5448C42 = getEntArray("silo_ee_valve", "targetname");
  _id_637839EE4AE18CD8 = getEntArray("silo_ee_needle_1", "targetname");
  _id_63783CEE4AE19371 = getEntArray("silo_ee_needle_2", "targetname");
  _id_63783BEE4AE1913E = getEntArray("silo_ee_needle_3", "targetname");
  _id_63783EEE4AE197D7 = getEntArray("silo_ee_needle_4", "targetname");
  _id_74369673F033BD30 = getEnt("silo_bottom", "targetname");
  triggers = getEntArray("trigger_rotatable_radius", "classname");

  foreach(trigger in triggers) {
    if(!isDefined(trigger) || trigger == _id_74369673F033BD30) {
      continue;
    }
    if(trigger.origin[2] > 500)
      trigger delete();
  }

  _id_1D2BE7531AAF82AF = scripts\engine\utility::array_combine(_id_51E791B4D5448C42, _id_637839EE4AE18CD8, _id_63783CEE4AE19371, _id_63783BEE4AE1913E, _id_63783EEE4AE197D7);

  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(isDefined(ent))
      ent delete();

    waitframe();
  }

  if(isDefined(level._id_10C35EC751227DA5))
    level._id_10C35EC751227DA5 delete();

  if(isDefined(level._id_D82FF154FFF994E7)) {
    foreach(enemy in level._id_D82FF154FFF994E7) {
      if(isDefined(enemy))
        enemy kill();
    }
  }

  if(isDefined(level._id_12569E8D8459E544))
    level._id_12569E8D8459E544 delete();
}

_id_6C79069826EA15C1() {
  level._id_C2333025DE5D7825 = getEnt("silo_instakill", "targetname");
  level._id_C2333025DE5D7825 endon("death");
  level._id_10C35EC751227DA5 = scripts\engine\utility::spawn_script_origin(level._id_C2333025DE5D7825.origin, (0, 0, 0));
  level._id_C2333025DE5D7825 enablelinkTo();
  level._id_C2333025DE5D7825 linkTo(level._id_10C35EC751227DA5);
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("elevator_tags", "targetname");
  level._id_142FFEF4BA6476C6._id_727D0F6175F238E0 = [];

  foreach(struct in _id_9E4E1482CB40C9C5) {
    origin = scripts\engine\utility::spawn_script_origin(struct.origin, (0, 0, 0));
    origin linkTo(level._id_142FFEF4BA6476C6);
    level._id_142FFEF4BA6476C6._id_727D0F6175F238E0[level._id_142FFEF4BA6476C6._id_727D0F6175F238E0.size] = origin;
  }

  for(;;) {
    level._id_C2333025DE5D7825 waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    if(!istrue(ent.shouldskiplaststand))
      ent thread _id_B118DF0D58750572();
  }
}

_id_B118DF0D58750572() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(_id_0AFB7E332AEE4BF2::isinlaststand(self))) {
    self.health = 0;
    self notify("last_stand_bleedout");
    thread _id_1E3C3FCD29F87F9F();
  } else {
    self.shouldskiplaststand = 1;
    scripts\engine\utility::waittill_any_timeout_1(3, "damage");
    self dodamage(10000, self.origin, level._id_C2333025DE5D7825, level._id_C2333025DE5D7825, "MOD_TRIGGER_HURT");
    thread _id_1E3C3FCD29F87F9F();
  }
}

_id_1E3C3FCD29F87F9F(_id_7E536FA6CBB8F492) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.dogtag))
    waitframe();

  foreach(_id_D09B626A1EACC3D3 in level._id_142FFEF4BA6476C6._id_727D0F6175F238E0) {
    if(positionwouldtelefrag(_id_D09B626A1EACC3D3.origin)) {
      continue;
    }
    _id_8419A6366C7137CE = 0;

    foreach(_id_6EE5484560EC747C in level.players) {
      if(_id_6EE5484560EC747C != self) {
        if(isDefined(_id_6EE5484560EC747C.dogtag) && isDefined(_id_6EE5484560EC747C._id_E622CFFA4EDD97EB) && _id_6EE5484560EC747C._id_E622CFFA4EDD97EB == _id_D09B626A1EACC3D3)
          _id_8419A6366C7137CE = 1;
      }
    }

    if(_id_8419A6366C7137CE) {
      continue;
    }
    self setOrigin(_id_D09B626A1EACC3D3.origin + (0, 0, 60));
    self.dogtag.origin = _id_D09B626A1EACC3D3.origin + (0, 0, 5);
    self.respawn_forcespawnorigin = _id_D09B626A1EACC3D3.origin + (0, 0, 5);
    self._id_E622CFFA4EDD97EB = _id_D09B626A1EACC3D3;
    self._id_A4F1D87B225A8D61 = 1;
    thread _id_9DBB48934C1BAC33();
    return;
  }
}

_id_9DBB48934C1BAC33() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_revived");
  self endon("laststand_revived");

  if(isDefined(self.dogtag))
    self.dogtag endon("death");

  if(isDefined(self.revive_icons[0]))
    self.revive_icons[0] settargetEnt(self.dogtag);

  for(;;) {
    self.dogtag.origin = self._id_E622CFFA4EDD97EB.origin + (0, 0, 10);
    self.respawn_forcespawnorigin = self._id_E622CFFA4EDD97EB.origin + (0, 0, 10);
    wait 0.05;
  }
}

_id_80622D919893EB3C() {
  level endon("game_ended");
  button = getEnt("silo_power_switch_0", "targetname");
  _id_C103BFC366A53063 = &"CP_RAID1_BOSS1/ELEVATOR_DOWN";
  _id_558A9A418B2D3405::_id_1A3A5E66BF63BEB5(button, _id_C103BFC366A53063, 1, 750);
}

_id_F7643056E96E96AE() {
  level endon("game_ended");

  if(getdvarint("dvar_F8E93A6B71A0651A", 0) < 1) {
    return;
  }
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_boss1_create_script", "cp_raid1_boss1_create_script", level.scripted_spawner_func.size, _id_120A4F027A4AE8F8::main);
  wait 0.05;
  _id_120A4F027A4AE8F8::main();
  scripts\engine\utility::flag_wait("cp_raid1_boss1_create_script_completed");
  trigger = getEnt("test_notes_trigger", "targetname");
  _id_8FA93A72C3FA36E7 = scripts\engine\utility::getStructArray(trigger.target, "targetname");
  index = 0;

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    foreach(droppoint in _id_8FA93A72C3FA36E7) {
      _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, droppoint.origin, droppoint.angles);
      item = _id_66122A002AFF5D57::spawnpickup("interactable_note_raid_" + index, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
      index++;

      if(index > 9)
        index = 0;

      wait 1;
    }

    wait 30;
  }
}

_id_C1B0D62AC36C0D27() {
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("saw_entrance_wave2", "script_noteworthy");
  thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
  wait 3;
  thread scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(_id_BFE291B401A9BF2A, 1);
}

_id_F442577D391DB354() {
  clip = getEnt("silo_saw_clip_1", "targetname");
  door = getEnt("saw_door_intro_1", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.1);
  clip = getEnt("silo_saw_clip_2", "targetname");
  door = getEnt("saw_door_intro_2", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  clip = getEnt("silo_saw_clip_3", "targetname");
  door = getEnt("saw_door_intro_3", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.1);

  foreach(interact in level._id_C130CE2E2A968C75)
  interact _meth_DFB78B3E724AD620(0);
}

_id_F34AB4F89EDFC099() {
  triggers = getEntArray("2nd_stop_enemy_trigger", "script_noteworthy");

  foreach(trigger in triggers) {
    if(isDefined(trigger))
      trigger scripts\engine\utility::trigger_off();
  }
}