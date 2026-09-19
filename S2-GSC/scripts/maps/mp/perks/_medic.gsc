/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\perks\_medic.gsc
********************************************/

initmedic() {
  level.medics = [];
  level.medictriggers = [];
  thread _id_87A7();
}

_id_87A7() {
  level._id_0A41["medic_patient"] = [];
  level._id_0A41["medic_patient"]["spawn"] = ::spawnmedicpatient;
  level._id_0A41["medic_patient"]["think"] = ::medicpatientthink;
  level._id_0A41["medic_patient"]["on_killed"] = ::onmedicpatientkilled;
  level waittill("agent_funcs_init");
  level._id_0A41["medic_patient"]["on_damaged"] = ::onmedicpatientdamaged;
  level._id_0A41["medic_patient"]["on_damaged_finished"] = level._id_0A41["player"]["on_damaged_finished"];
}

setmedic() {
  self.medic_patient_array = [];
  level.medics = common_scripts\utility::_id_0F6F(level.medics, self);
}

unsetmedic() {
  self.medic_patient_array = undefined;
  level.medics = common_scripts\utility::_id_0F93(level.medics, self);
}

ondeath_handlemedic() {
  self endon("disconnect");
  level endon("game_ended");

  if(canspawnmedicpatienttrigger())
    thread setupmedicpatienttrigger();
}

canspawnmedicpatienttrigger() {
  self endon("disconnect");
  level endon("game_ended");

  if(level.medics.size <= 0)
    return 0;

  var_0 = maps\mp\agents\_agent_utility::get_max_agents();

  if(maps\mp\agents\_agent_utility::_id_45BB() >= var_0)
    return 0;

  foreach(var_2 in level.medics) {
    if(var_2 canmediccreatepatient(self))
      return 1;
  }

  return 0;
}

canmediccreatepatient(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(self) || !maps\mp\_utility::isreallyalive(self))
    return 0;

  if(self == var_0 || self.team != var_0.team)
    return 0;

  if(!maps\mp\_utility::_hasperk("specialty_medic"))
    return 0;

  if(isDefined(self.medic_patient_array) && self.medic_patient_array.size > 0)
    return 0;

  var_1 = maps\mp\agents\_agent_utility::get_max_agents();

  if(maps\mp\agents\_agent_utility::_id_45BB() >= var_1)
    return 0;

  return 1;
}

setupmedicpatienttrigger() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.angles = (0, 0, 0);
  var_0._id_9D65 = spawn("script_origin", var_0.origin);
  var_0._id_9D65._id_68FB = var_0;
  var_0._id_9D65 makeusable();
  var_0._id_9D65 sethintstring(&"DIVISIONS_DLC3_MEDIC_PATIENT_TRIGGER");
  var_0.model = spawn("script_model", var_0.origin);
  var_0.model linkto(self, "tag_origin");
  var_0.model setModel("tag_origin");
  level.medictriggers = common_scripts\utility::_id_0F6F(level.medictriggers, var_0);
  thread medic_trigger_enable_use_watcher(var_0);
  var_1 = [[level._id_0A4D]]("medic_patient", self.team, undefined, self.origin, self.angles, undefined, 0, 0, "recruit");
  var_0 thread handlemedictrigger(var_1);
  var_0 thread handlemedictriggerdeleteaftertime(var_1);
  var_1 setpatientactive(0);
  var_1 maps\mp\agents\_agent_utility::hudoutlineenable(self.team);
  var_1 _meth_86D0();
}

medic_trigger_enable_use_watcher(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_0._id_9D65 endon("deleted");

  foreach(var_2 in level.players) {
    if(var_2 canmediccreatepatient(self)) {
      var_0._id_9D65 enableplayeruse(var_2);
      continue;
    }

    var_0._id_9D65 disableplayeruse(var_2);
  }

  for(;;) {
    level waittill("joined_team", var_2);

    if(var_2 canmediccreatepatient(self)) {
      var_0._id_9D65 enableplayeruse(var_2);
      continue;
    }

    var_0._id_9D65 disableplayeruse(var_2);
  }
}

handlemedictrigger(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self._id_9D65 waittill("trigger", var_1);
  var_0 maps\mp\agents\_agent_utility::hudoutlineenable(var_1.team, var_1);
  var_0 _meth_86D1();
  var_1 thread end_medic_patient(var_0);
  var_1.medic_patient_array = common_scripts\utility::_id_0F6F(var_1.medic_patient_array, var_0);
  var_0._id_0117 = var_1;
  var_0 setpatientactive(1);
  var_0 thread[[level._id_0A55]](var_1);

  foreach(var_3 in level.medictriggers)
  var_3._id_9D65 disableplayeruse(var_1);

  var_0 notify("patient_revived");
  handlemedictriggerdelete();
}

setpatientactive(var_0) {
  self botsetflag("disable_attack", !var_0);
  self botsetflag("disable_movement", !var_0);
  self botsetflag("disable_rotation", !var_0);

  if(var_0) {
    self.patientdown = undefined;
    self._id_0009 = &"DIVISIONS_DLC3_MEDIC_PATIENT";
  } else
    self.patientdown = 1;
}

handlemedictriggerdeleteaftertime(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 common_scripts\utility::_id_A71A(20);
  var_0 _meth_86D1();
  var_0.patientdown = undefined;
  maps\mp\agents\_agent_utility::_id_5A28(var_0);
  handlemedictriggerdelete();
}

handlemedictriggerdelete() {
  if(isDefined(self)) {
    level.medictriggers = common_scripts\utility::_id_0F93(level.medictriggers, self);
    self.model delete();
    self._id_9D65 notify("deleted");
    self._id_9D65 delete();
    self notify("death");
  }
}

spawnmedicpatient(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  maps\mp\agents\_agent_utility::_id_5334(1);
  self._id_5BE0 = spawnStruct();
  self._id_5BE0.origin = var_0;
  self._id_5BE0.angles = var_1;
  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(self.name);
  self._id_5BE2 = gettime();
  var_7 = var_0 + (0, 0, 25);
  var_8 = var_0;
  var_9 = _playerphysicstrace(var_7, var_8);

  if(distancesquared(var_9, var_7) > 1)
    var_0 = var_9;

  self spawnagent(var_0, var_1);

  if(isDefined(var_5))
    self[[level.bot_funcs["bot_set_difficulty"]]](var_5);

  self[[level.bot_funcs["bot_set_personality"]]]("default");
  maps\mp\agents\_agent_common::_id_83FD(getdvarint("scr_player_maxhealth", 100));
  self[[level._id_0A5B]]();
  maps\mp\gametypes\_class::_id_4773(self.team, self.class, 1);

  if(isDefined(self._id_0117))
    self thread[[level._id_0A55]](self._id_0117);

  thread maps\mp\_flashgrenades::_id_6394();
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]](1);
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();

  if(!self._id_4B60)
    _id_050D::_id_09FA();

  thread _id_0513::_id_9B90();
  self._id_4B60 = 0;
  thread _id_04D6::_id_73FC();

  if(self.team == "allies") {
    self setModel("usa_paratrooper_streak_org1_mp");
    self attach("mp_head_clark_org1");
  } else {
    self setModel("ita_paratrooper_streak_org1_mp");
    self attach("mp_head_clark_org1");
  }

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

medicpatientthink() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self._id_6F7F]]();
    waitframe();
  }
}

onmedicpatientdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level endon("game_ended");
  self endon("death");

  if(common_scripts\utility::_id_562E(self.patientdown))
    return 0;

  self[[level._id_0A41["player"]["on_damaged"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

onmedicpatientkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self[[level._id_0A5D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  thread _id_0513::_id_34A9(var_1, var_3, var_4);

  if(self._id_565F) {
    self._id_4B60 = 1;
    maps\mp\agents\_agent_utility::_id_2A73();
  }

  if(isDefined(self._id_0117)) {
    self._id_0117 notify("patient_died");
    self._id_0117.medic_patient_array = common_scripts\utility::_id_0F93(self._id_0117.medic_patient_array, self);
  }

  self.patientdown = undefined;
}

end_medic_patient(var_0) {
  level endon("game_ended");
  self endon("patient_died");
  var_1 = common_scripts\utility::_id_A71B(60, "disconnect", "joined_team");
  maps\mp\agents\_agent_utility::_id_5A28(var_0);
  self.medic_patient_array = common_scripts\utility::_id_0F93(self.medic_patient_array, var_0);
}