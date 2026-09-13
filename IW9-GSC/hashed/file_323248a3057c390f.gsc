/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_323248a3057c390f.gsc
***********************************************/

_id_2D7992159C9B6DEF() {
  if(!isDefined(level._id_51FBA2BBD80629D9))
    level._id_51FBA2BBD80629D9 = [];

  if(!isDefined(level._id_CC86627703B86AF5))
    level._id_CC86627703B86AF5 = [];

  level._id_CC86627703B86AF5["subpen"] = getEnt("area1_elec_trigger", "targetname");
  level._id_51FBA2BBD80629D9["subpen"] = scripts\engine\utility::getStructArray("electic_fx", "targetname");
  scripts\engine\utility::stop_exploder("electric_water_boss1");
  waitframe();
  scripts\engine\utility::stop_exploder("electric_water_boss2");
}

_id_9168E4D97136F379(area) {}

_id_1609D9F10A1663F4(area, notifyname) {
  level notify("electrifyArea");
  level endon("electrifyArea");
  _id_8927E0F5F68E6073 = "electric_water";

  if(area == "floor_is_lava") {
    playsoundatpos((9291, 14607, 440), "emt_raid3_boss_electrify_start_powerup");
    playsoundatpos((9060, 11611, 410), "emt_raid3_boss_electrify_start_impact");
    playsoundatpos((9156, 13130, 306), "emt_raid3_boss_electrify_start_atmo");
    wait 4;
    scripts\engine\utility::exploder(_id_8927E0F5F68E6073);
    level._id_ADA37E04EF513474 = spawn("script_origin", (9156, 13130, 306));
    level._id_ADA37E04EF513474 playLoopSound("emt_raid3_boss_electrify_hum_lp");
    level._id_CC86627703B86AF5[area] thread _id_A7F83006EF7FD7B8();
    level waittill(notifyname);
    scripts\engine\utility::stop_exploder(_id_8927E0F5F68E6073);
    level._id_CC86627703B86AF5[area] notify("stop_electricity");
    level notify("vo_stop_electricity");
    return;
  } else if(area == "subpen")
    _id_8927E0F5F68E6073 = "electric_water_boss1";
  else if(area == "subpen2")
    _id_8927E0F5F68E6073 = "electric_water_boss2";

  level childthread _id_1C06BEDD9980B7AF::_id_EB859C0F231E4CFF();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    playsoundatpos(scripts\engine\utility::getStruct("alarm_audio", "targetname").origin, "emt_raid3_boss_electrify_alarm");
    wait 1;
  }

  playsoundatpos((14169, 8662, 366), "emt_raid3_boss_electrify_start_powerup");
  playsoundatpos((14373, 9615, 485), "emt_raid3_boss_electrify_start_impact");
  playsoundatpos((14373, 9615, 485), "emt_raid3_boss_electrify_start_atmo");
  wait 4;
  scripts\engine\utility::exploder(_id_8927E0F5F68E6073);

  if(isDefined(level._id_ADA37E04EF513474))
    level._id_ADA37E04EF513474.origin = (14994, 8400, 292);
  else {
    level._id_ADA37E04EF513474 = spawn("script_origin", (14994, 8400, 292));
    level._id_ADA37E04EF513474 playLoopSound("emt_raid3_boss_electrify_hum_lp");
  }

  level._id_CC86627703B86AF5[area] thread _id_A7F83006EF7FD7B8();
  endtime = gettime() + 15000;

  while(gettime() < endtime)
    wait 0.05;

  if(isDefined(level._id_ADA37E04EF513474))
    level._id_ADA37E04EF513474 stoploopsound();

  scripts\engine\utility::stop_exploder(_id_8927E0F5F68E6073);
  playsoundatpos((14169, 8662, 366), "emt_raid3_boss_electrify_end_powerdown");
  playsoundatpos((14373, 9615, 485), "emt_raid3_boss_electrify_end_impact");
  playsoundatpos((14373, 9615, 485), "emt_raid3_boss_electrify_end_atmo");
  level._id_CC86627703B86AF5[area] notify("stop_electricity");
  level notify("vo_stop_electricity");
}

_id_A7F83006EF7FD7B8() {
  self endon("stop_electricity");

  for(;;) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      thread _id_6D8CBAB68D23E670(ent);
      continue;
    }

    thread _id_EB7B9E468AC48C76(ent);
  }
}

_id_EB7B9E468AC48C76(agent) {
  agent endon("death");

  if(!istrue(agent._id_14EF2878291D78B9)) {
    agent._id_14EF2878291D78B9 = 1;
    agent _id_F4F1C9111714EA25();
    agent dodamage(30, agent.origin);
    wait 0.25;
    agent._id_14EF2878291D78B9 = 0;
  }
}

_id_F4F1C9111714EA25() {
  self endon("death");

  if(isDefined(self._id_7E60FF1A33E2C4AC) && !scripts\engine\utility::time_has_passed(self._id_7E60FF1A33E2C4AC, 1)) {
    return;
  }
  self._id_7E60FF1A33E2C4AC = gettime();
  self playsoundonmovingent("cp_raid_electric_water_zap");

  if(isPlayer(self))
    self playlocalsound("cp_raid_electric_water_zap_plr");
}

_id_6D8CBAB68D23E670(player) {
  player endon("disconnect");

  if(!istrue(player._id_14EF2878291D78B9)) {
    player._id_14EF2878291D78B9 = 1;
    player thread _id_F4F1C9111714EA25();
    player thread _id_1C06BEDD9980B7AF::_id_90E51894C4E50751();
    player dodamage(10, player.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    wait 0.5;
    player._id_14EF2878291D78B9 = 0;
  }

  if(!istrue(player._id_B7DB5CCD69188E24)) {
    player._id_B7DB5CCD69188E24 = 1;
    player setscriptablepartstate("shockStickVfx", "vfx_start", 0);
    wait 2;
    player setscriptablepartstate("shockStickVfx", "off", 0);
    wait 0.5;
    player._id_B7DB5CCD69188E24 = undefined;
  }
}

_id_401DA6FCA69E6822(area) {
  self endon("death");

  if(istrue(self._id_8FFF9E977E206515) || istrue(self._id_1C9A41EC57318EC8) || istrue(self._id_5D765B7A01E415D8)) {
    return;
  }
  self.goalradius = 16;
  self._id_5D765B7A01E415D8 = 1;
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::getStruct("boss_attack_electric", "targetname");
  self setgoalpos(getclosestpointonnavmesh(_id_0C3EA9B1A20FF199.origin));
  self waittill("goal");
  wait 1;
  level thread _id_1609D9F10A1663F4(area);
  wait 5;
  self._id_5D765B7A01E415D8 = undefined;
  self.goalradius = 2048;
  self.goalheight = 100;
}