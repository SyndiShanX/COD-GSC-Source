/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\180.gsc
**************************************/

init() {
  anim._id_130C = spawnStruct();
  anim._id_130C._id_130D = [];
  anim._id_130C._id_130D["check_fire"] = "threat_friendly_fire";
  anim._id_130C._id_130D["reload"] = "inform_reload_generic";
  anim._id_130C._id_130D["frag_out"] = "inform_attack_grenade";
  anim._id_130C._id_130D["flash_out"] = "inform_attack_flashbang";
  anim._id_130C._id_130D["smoke_out"] = "inform_attack_smoke";
  anim._id_130C._id_130D["c4_plant"] = "inform_attack_c4";
  anim._id_130C._id_130D["claymore_plant"] = "inform_plant_claymore";
  anim._id_130C._id_130D["downed"] = "inform_suppressed";
  anim._id_130C._id_130D["bleedout"] = "inform_bleedout";
  anim._id_130C._id_130D["reviving"] = "inform_reviving";
  anim._id_130C._id_130D["revived"] = "inform_revived";
  anim._id_130C._id_130D["sentry_out"] = "inform_place_sentry";
  anim._id_130C._id_130D["area_secure"] = "inform_area_secure";
  anim._id_130C._id_130D["kill_generic"] = "inform_kill_generic";
  anim._id_130C._id_130D["kill_infantry"] = "inform_kill_infantry";
  anim._id_130C._id_130D["affirmative"] = "inform_roger";
  anim._id_130C._id_130D["negative"] = "inform_negative";
  anim._id_130C._id_130D["on_comms"] = "inform_comms";
  anim._id_130C._id_130D["mark_dropzone"] = "inform_markdz";
  anim._id_130C._id_130D["glowstick_out"] = "inform_use_glowstick";
  anim._id_130C._id_0B6D = [];
  anim._id_130C._id_0B6D["check_fire"] = 4;
  anim._id_130C._id_0B6D["reload"] = 8;
  anim._id_130C._id_0B6D["frag_out"] = 3;
  anim._id_130C._id_0B6D["flash_out"] = 3;
  anim._id_130C._id_0B6D["smoke_out"] = 3;
  anim._id_130C._id_0B6D["c4_plant"] = 2;
  anim._id_130C._id_0B6D["claymore_plant"] = 2;
  anim._id_130C._id_0B6D["downed"] = 0.5;
  anim._id_130C._id_0B6D["bleedout"] = 0.5;
  anim._id_130C._id_0B6D["reviving"] = 2;
  anim._id_130C._id_0B6D["revived"] = 2;
  anim._id_130C._id_0B6D["sentry_out"] = 3;
  anim._id_130C._id_0B6D["kill_generic"] = 2;
  anim._id_130C._id_0B6D["kill_infantry"] = 2;
  anim._id_130C._id_0B6D["area_secure"] = 0.5;
  anim._id_130C._id_0B6D["affirmative"] = 2;
  anim._id_130C._id_0B6D["negative"] = 2;
  anim._id_130C._id_0B6D["on_comms"] = 0.5;
  anim._id_130C._id_0B6D["mark_dropzone"] = 0.5;
  anim._id_130C._id_0B6D["glowstick_out"] = 3;
  anim._id_130C._id_130E = [];
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "affirmative";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "negative";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "area_secure";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "on_comms";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "mark_dropzone";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "downed";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "bleedout";
  anim._id_130C._id_130E[anim._id_130C._id_130E.size] = "check_fire";
  anim._id_130C._id_130F = [];
  anim._id_130C._id_130F[anim._id_130C._id_130F.size] = "m79";
  anim._id_130C._id_130F[anim._id_130C._id_130F.size] = "ranger";
  anim._id_130C._id_130F[anim._id_130C._id_130F.size] = "claymore";
  anim._id_130C._id_130F[anim._id_130C._id_130F.size] = "rpg";
  anim._id_130C._id_130F[anim._id_130C._id_130F.size] = "rpg_player";
  anim._id_130C._id_1310 = 640000;
  anim._id_130C._id_0B41 = "^3***** BCS FAILURE: ";
  common_scripts\utility::array_thread(level.players, ::_id_1314);
  _id_1311();
}

_id_1311() {
  level._id_1312 = 1;
}

_id_1313() {
  level._id_1312 = 0;
}

_id_1314() {
  self._id_1315 = 0;
  self._id_1316 = [];
  thread _id_1317();
  thread _id_1318();
  thread _id_1322();
  thread _id_1324();
  thread _id_1325();
  thread _id_1327();
  thread _id_1319();
  thread _id_131A();
  thread _id_131B();
  thread _id_131C();
  thread _id_131D();
  thread _id_131E();
  thread _id_131F();
  thread _id_1320();
  thread _id_1321();
}

_id_1317() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("so_downed", "so_bleedingout", "so_reviving", "so_revived");

    if(var_0 == "so_downed") {
      _id_1330("downed");
      continue;
    }

    if(var_0 == "so_bleedingout") {
      _id_1330("bleedout");
      continue;
    }

    if(var_0 == "so_reviving") {
      _id_1330("reviving");
      continue;
    }

    if(var_0 == "so_revived") {
      _id_1330("revived");
    }
  }
}

_id_1318() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("begin_firing");
    var_0 = self getcurrentweapon();

    if(var_0 == "claymore") {
      _id_1330("claymore_plant");
    }
  }
}

_id_1319() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("sentry_placement_finished");
    _id_1330("sentry_out");
  }
}

_id_131A() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_kill_generic");
    _id_1330("kill_generic");
  }
}

_id_131B() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_kill_infantry");
    _id_1330("kill_infantry");
  }
}

_id_131C() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_area_secure");
    _id_1330("area_secure");
  }
}

_id_131D() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_affirmative");
    _id_1330("area_secure");
  }
}

_id_131E() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_negative");
    _id_1330("negative");
  }
}

_id_131F() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_on_comms");
    _id_1330("on_comms");
  }
}

_id_1320() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_mark_dropzone");
    _id_1330("mark_dropzone");
  }
}

_id_1321() {}

_id_1322() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();

    if(_id_1323(var_0)) {
      continue;
    }
    if(_id_133B()) {
      continue;
    }
    _id_1330("reload");
  }
}

_id_1323(var_0) {
  foreach(var_2 in anim._id_130C._id_130F) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_1324() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = undefined;

    if(var_1 == "fraggrenade") {
      var_2 = "frag_out";
    } else if(var_1 == "semtex_grenade") {
      var_2 = "frag_out";
    } else if(var_1 == "flash_grenade") {
      var_2 = "flash_out";
    } else if(var_1 == "smoke_grenade_american") {
      var_2 = "smoke_out";
    } else if(var_1 == "c4") {
      var_2 = "c4_plant";
    }
    if(isDefined(var_2)) {
      _id_1330(var_2);
    }
  }
}

_id_1325() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!_id_1326(var_0, var_1, var_4)) {
      continue;
    }
    _id_1330("check_fire");
  }
}

_id_1326(var_0, var_1, var_2) {
  if(var_0 <= 0) {
    return 0;
  }
  if(!isPlayer(var_1)) {
    return 0;
  }
  if(var_1 == self) {
    return 0;
  }
  if(var_2 == "MOD_MELEE") {
    return 0;
  }
  if(isDefined(level._id_0AD3) && !level._id_0AD3) {
    return 0;
  }
  return 1;
}

_id_1327() {
  level endon("special_op_terminated");
  self endon("death");
  self addaieventlistener("bulletwhizby");

  for(;;) {
    self waittill("ai_event", var_0, var_1, var_2);

    if(var_0 == "bulletwhizby") {
      if(!_id_1328(var_1, var_2)) {
        continue;
      }
      _id_1330("check_fire");
    }
  }
}

_id_1328(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return 0;
  }
  if(var_0 == self) {
    return 0;
  }
  if(_id_133B()) {
    return 0;
  }
  if(abs(var_1[2] - self.origin[2] > 128)) {
    return 0;
  }
  var_2 = distance2d(self.origin, var_1);

  if(!animscripts\battlechatter_ai::_id_0B35(var_0, var_2)) {
    return 0;
  }
  if(isDefined(level._id_0AD3) && !level._id_0AD3) {
    return 0;
  }
  return 1;
}

_id_1329() {
  var_0 = _id_132A();
  _id_1330(var_0);
}

_id_132A() {
  var_0 = "downed";
  var_1 = self._id_132B._id_132C;
  var_2 = self._id_132B._id_132D;

  if(var_1 < var_2 * level._id_132E) {
    var_0 = "bleedout";
  }
  return var_0;
}

_id_132F() {
  var_0 = _id_132A();
  return _id_1331(var_0);
}

_id_1330(var_0) {
  level endon("special_op_terminated");
  self endon("death");

  if(!_id_1331(var_0)) {
    return;
  }
  if(!_id_1339(var_0)) {
    return;
  }
  var_1 = _id_1335(self) + anim._id_130C._id_130D[var_0];
  var_1 = _id_1333(var_0, var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!soundexists(var_1)) {
    return;
  }
  self._id_1315 = 1;
  self playSound(var_1, "bc_done", 1);
  self waittill("bc_done");
  self._id_1315 = 0;
  _id_1332(var_0);
}

_id_1331(var_0) {
  if(!isDefined(level._id_1312) || !level._id_1312) {
    return 0;
  }
  if(self._id_1315) {
    return 0;
  }
  if(!isDefined(self._id_1316[var_0])) {
    return 1;
  }
  var_1 = self._id_1316[var_0];
  var_2 = anim._id_130C._id_0B6D[var_0] * 1000;

  if(gettime() - var_1 >= var_2) {
    return 1;
  }
  return 0;
}

_id_1332(var_0) {
  self._id_1316[var_0] = gettime();
}

_id_1333(var_0, var_1) {
  if(var_0 == "reload") {
    if(isDefined(level._id_1334["skip_inform_reloading"]) && level._id_1334["skip_inform_reloading"]) {
      return undefined;
    }
    if(isDefined(level._id_1334["inform_reloading"])) {
      return level._id_1334["inform_reloading"];
    }
  }

  return var_1;
}

_id_1335(var_0) {
  var_1 = "";

  if(isDefined(level._id_1336) && level._id_1336) {
    var_1 = "STEALTH_";
  }
  var_2 = "1";

  if(var_0 == level._id_1337) {
    var_2 = "2";
  }
  switch (level._id_1338) {
    case "fso":
    case "hijack":
    case "delta":
    case "ranger":
      return "SO_US_" + var_2 + "_" + var_1;
    case "seal":
      return "SO_NS_" + var_2 + "_" + var_1;
    case "sas":
    case "ghillie":
    case "woodland":
    case "desert":
    case "arctic":
      return "SO_UK_" + var_2 + "_" + var_1;
    default:
  }
}

_id_1339(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in anim._id_130C._id_130E) {
      if(var_2 == var_0) {
        return 1;
      }
    }
  }

  var_4 = maps\_utility::_id_133A(self);

  if(distancesquared(var_4.origin, self.origin) > anim._id_130C._id_1310) {
    return 0;
  }
  return 1;
}

_id_133B() {
  if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
    return 1;
  }
  return 0;
}