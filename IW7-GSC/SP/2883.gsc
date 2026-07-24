/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2883.gsc
**************************************/

register_interaction(var_0, var_1) {
  level.interactions[var_0] = var_1;
}

_id_DED9(var_0, var_1) {
  level._id_10E1C[var_0] = var_1;
}

_id_7A45(var_0) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[var_0]))
    return undefined;

  return level.interactions[var_0];
}

_id_7CA7(var_0) {
  if(!issubstr(var_0, "casual") && !issubstr(var_0, "alert")) {
    if(isDefined(self.asm)) {
      var_1 = scripts\asm\asm::asm_getdemeanor();

      if(var_1 == "casual")
        var_0 = var_0 + "_" + var_1;
      else
        var_0 = var_0 + "_alert";
    } else
      var_0 = var_0 + "_casual";
  }

  if(!isDefined(level._id_10E1C) || !isDefined(level._id_10E1C[var_0]))
    return undefined;

  return level._id_10E1C[var_0];
}

_id_9C27(var_0) {
  return isDefined(level.interactions) && isDefined(level.interactions[var_0]);
}

_id_9CD8(var_0) {
  return isDefined(level._id_10E1C) && isDefined(level._id_10E1C[var_0 + "_casual"]);
}

_id_9CD7(var_0) {
  if(isDefined(var_0._id_EE92) && _id_9CD8(var_0._id_EE92))
    return 1;

  return 0;
}

_id_9C26(var_0) {
  if(isDefined(var_0._id_EE92) && _id_9C27(var_0._id_EE92))
    return 1;

  if(isDefined(var_0.script_noteworthy) && _id_9C27(var_0.script_noteworthy))
    return 1;

  return 0;
}

_id_9C25(var_0) {
  if(isDefined(var_0._id_EE92)) {
    if(_id_9C27(var_0._id_EE92) || var_0._id_EE92 == "combat_reaction")
      return 1;
  }

  return 0;
}

_id_7837(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var_0._id_22F2))
    return var_0._id_22F2[var_1];
  else
    return undefined;
}

_id_79A5(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var_0._id_6980))
    return var_0._id_6980[var_1];
  else
    return undefined;
}

_id_7A30(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  return var_0._id_92FA;
}

_id_F96C(var_0) {
  if(!isai(self)) {
    return;
  }
  self.asm._id_4C86.interaction = var_0;
  var_1 = _id_7A45(var_0);

  if(!isDefined(var_1))
    var_1 = _id_7CA7(var_0);

  self.asm._id_4C86._id_697F = _id_79A5(var_1);
}

_id_CD4C(var_0, var_1, var_2, var_3, var_4) {
  var_0 = _id_7A45(var_0);

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.05;

  if(!isDefined(var_4))
    var_4 = 1;

  _id_10C47(var_0._id_EBEA[var_1]);
  self _meth_82E1(var_1, var_0._id_EBEA[var_1], var_2, var_3, var_4);
}

_id_509D(var_0) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_1 = undefined;

  for(;;) {
    if(isstruct(var_0) || isent(var_0))
      var_1 = var_0.origin;
    else if(isvector(var_0))
      var_1 = var_0;

    if(isDefined(self._id_B004))
      self._id_B004["interaction_position"] = var_1;

    scripts\engine\utility::waitframe();
  }
}

_id_DE14(var_0) {
  var_1 = undefined;

  if(isDefined(self._id_B004)) {
    var_1 = self._id_B004["trigger_radius"];
    self._id_B004["trigger_radius"] = var_0;
    thread _id_13B1(var_1);
  }
}

_id_13B1(var_0) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self._id_B004["trigger_radius"] = var_0;
}

_id_CD4B(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = _id_7A45(var_0);
  _id_F96C(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  self._id_B004 = var_3._id_EBEA;

  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  self._id_1F25 = 0;
  self._id_EBF8 = 0;
  self._id_F274 = 0;
  self._id_10254 = 0;
  self._id_9C84 = 0;
  self._id_BE79 = 0;
  self._id_9A30 = var_0;
  self._id_DD4C = 1;

  if(!isDefined(self._id_1C4D))
    self._id_1C4D = 1;

  if(isDefined(level._id_9A2E)) {
    scripts\sp\interaction_manager::_id_168F();
    level._id_9A2E._id_4D94["registered_interactions"][var_0] = [];

    if(isDefined(var_3._id_EBEA["vo_lines_male"]))
      level._id_9A2E._id_4D94["registered_interactions"][var_0]["vo_lines_male"] = var_3._id_EBEA["vo_lines_male"];

    if(isDefined(var_3._id_EBEA["vo_lines_female"]))
      level._id_9A2E._id_4D94["registered_interactions"][var_0]["vo_lines_female"] = var_3._id_EBEA["vo_lines_female"];
  }

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(self._id_B004["idle"]))
      var_5 = self._id_B004["idle"][0];
    else
      var_5 = self._id_B004["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);

    if(!isDefined(self._id_9B89))
      self _meth_80F1(var_7, var_8);
    else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self._id_9B89))
      self animmode("noclip");

    self._id_C6B9 = var_4;
  }

  if(!isDefined(self._id_1EDB))
    self._id_1EDB = spawnStruct();

  if(isDefined(self._id_B004["no_gun"])) {
    if(!isDefined(self._id_9B89))
      scripts\sp\utility::_id_86E4();
  }

  if(isDefined(self._id_9B89)) {
    if(!isDefined(var_2)) {
      thread _id_9A35();
      thread _id_9A10();
    } else {
      thread _id_9A11();
      thread _id_9A10();
    }
  } else if(!isDefined(var_2))
    _id_0A1E::_id_2307(::_id_9A35, ::_id_9A0F);
  else
    _id_0A1E::_id_2307(::_id_9A11, ::_id_9A0F);

  self waittill("reaction_end");
}

_id_CE18(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var_8 = _id_7A45(var_0)._id_EBEA["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::_id_DD45(var_8);
  _id_CD51(var_0, var_5, var_1, var_7);
  self waittill("interaction_done");
  thread scripts\sp\utility::_id_77B9(0.7);
  self notify("stop_reaction_look");
  _id_137F5(var_6);
  play_looping_acknowlegdements(var_2, var_6);
}

#using_animtree("generic_human");

setup_interaction_head() {
  self._id_8C7E = % head;
  self._id_EF82 = % scripted_talking;
  self._id_504D = % generic_talker_allies;
}

_id_CD51(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "blended"))
    thread _id_CD4D(var_0, var_1);
  else
    thread _id_CD4B(var_0, var_1);

  _id_DB73(var_2, var_3);
}

_id_DB73(var_0, var_1) {
  if(!isDefined(var_1))
    thread _id_CDB1(var_0);
  else {
    self waittill("playing_interaction_scene");
    scripts\engine\utility::delaythread(var_1, scripts\sp\interaction_manager::_id_CE17, var_0);
  }
}

_id_CE1A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_smart_reaction");
  self._id_8C7E = % head;
  self._id_EF82 = % scripted_talking;
  self._id_504D = % generic_talker_allies;
  thread _id_CD50(var_0, var_5);
  scripts\sp\interaction_manager::_id_CD24(85.0, 50.0, var_1, var_3, var_4);
  self notify("first_acknowledgement_done");
  _id_137F5(var_6);
  var_7 = _id_4906(var_2);

  for(;;) {
    var_8 = var_7 _id_7A4D();
    scripts\sp\interaction_manager::_id_CD24(85.0, 50.0, var_8, var_3, var_4);
    _id_137F5(var_6);
  }
}

_id_CE16(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_smart_reaction");
  self._id_8C7E = % head;
  self._id_EF82 = % scripted_talking;
  self._id_504D = % generic_talker_allies;
  _id_CE0D(var_0);
  self notify("first_acknowledgement_done");
  _id_137F5(var_4);
  play_looping_acknowlegdements(var_1, var_4);
}

_id_CE19(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  self._id_8C7E = % head;
  self._id_EF82 = % scripted_talking;
  self._id_504D = % generic_talker_allies;
  _id_CE0D(undefined);
  _id_137F5(var_0);
  play_looping_acknowlegdements(undefined, var_0);
}

_id_CE1B(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_smart_reaction");
  self._id_8C7E = % head;
  self._id_EF82 = % scripted_talking;
  self._id_504D = % generic_talker_allies;
  thread _id_CD50(var_0, var_1);
  scripts\sp\interaction_manager::_id_CD24(85.0, 50.0);
  self notify("first_acknowledgement_done");
  _id_137F5(var_2);
  play_looping_acknowlegdements(undefined, var_2);
}

_id_CE0D(var_0) {
  self endon("stop_smart_reaction");
  var_1 = 110;
  var_2 = 85;
  scripts\sp\interaction_manager::_id_CD24(var_1, var_2, var_0);
}

play_looping_acknowlegdements(var_0, var_1) {
  self endon("death");
  self endon("stop_smart_reaction");

  if(!isDefined(var_1))
    var_1 = 300;

  if(isDefined(var_0)) {
    var_2 = _id_4906(var_0);

    for(;;) {
      var_3 = var_2 _id_7A4D();
      _id_CE0D(var_3);
      _id_137F5(var_1);
    }
  } else {
    for(;;) {
      _id_CE0D();
      _id_137F5(var_1);
    }
  }
}

_id_CE0C() {
  var_0 = 110;
  var_1 = 85;
  scripts\sp\interaction_manager::_id_CD24(var_0, var_1);
}

_id_137F5(var_0) {
  if(!isDefined(var_0))
    var_0 = 256;

  for(;;) {
    if(distance2d(self.origin, level.player.origin) >= var_0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_4906(var_0) {
  if(!isarray(var_0) && !isstruct(var_0) && !isstring(var_0) && !isvector(var_0) && !var_0)
    return undefined;

  var_1 = spawnStruct();
  var_1._id_2857 = var_0;
  var_1._id_269A = var_0;
  var_1.used = [];
  return var_1;
}

_id_E1F7() {
  self.used = [];
  self._id_269A = self._id_2857;
}

_id_7A4D() {
  var_0 = undefined;

  if(isDefined(self._id_269A)) {
    if(self._id_269A.size <= 0)
      _id_E1F7();

    var_0 = self._id_269A[randomint(self._id_269A.size)];
    self.used = scripts\engine\utility::array_add(self.used, var_0);
    self._id_269A = scripts\engine\utility::array_remove(self._id_269A, var_0);
    return var_0;
  }
}

_id_CE15(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("death");
    var_5 endon("stop_smart_reaction");
    var_5._id_8C7E = % head;
    var_5._id_EF82 = % scripted_talking;
    var_5._id_504D = % generic_talker_allies;
  }

  if(var_0.size != var_1.size || var_0.size != var_2.size) {
    return;
  }
  _id_CD35(var_0, var_1);
  var_7 = scripts\sp\interaction_manager::_id_491D(var_0);
  var_7 _id_137F5(var_3);
  _id_CD38(var_0, var_2, var_3);
}

_id_CD35(var_0, var_1) {
  var_2 = 110;
  var_3 = 85;
  scripts\sp\interaction_manager::_id_CD37(var_0, var_2, var_3, var_1);
}

_id_CD38(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
    var_4 endon("stop_smart_reaction");
  }

  var_6 = _id_48F8(var_1);
  var_7 = scripts\sp\interaction_manager::_id_491D(var_0);

  for(;;) {
    var_8 = _id_7A4E(var_6);
    _id_CD35(var_0, var_8);
    var_7 _id_137F5(var_2);
  }
}

_id_48F8(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = _id_4906(var_0[var_2]);

  return var_1;
}

_id_7A4E(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = var_0[var_2] _id_7A4D();

  return var_1;
}

_id_CD53(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = _id_7CA7(var_0);
  _id_F96C(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  self._id_9C84 = 0;
  self._id_BE79 = 0;
  self._id_9A30 = var_0;
  self._id_DD4C = 1;

  if(!isDefined(self._id_1C4D))
    self._id_1C4D = 1;

  if(isDefined(level._id_9A2E))
    scripts\sp\interaction_manager::_id_168F();

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(var_3._id_EBEA["idle"]))
      var_5 = var_3._id_EBEA["idle"][0];
    else
      var_5 = var_3._id_EBEA["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);

    if(!isDefined(self._id_9B89))
      self _meth_80F1(var_7, var_8);
    else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self._id_9B89))
      self animmode("noclip");

    self._id_C6B9 = var_4;
  }

  if(!isDefined(self._id_1EDB))
    self._id_1EDB = spawnStruct();

  if(isDefined(var_3._id_EBEA["no_gun"])) {
    if(!isDefined(self._id_9B89) && self.weapon != "none")
      scripts\sp\utility::_id_86E4();
  }

  if(isDefined(self._id_9B89)) {
    thread _id_9A37();
    thread _id_9A10();
  } else
    _id_0A1E::_id_2307(::_id_9A37, scripts\sp\interaction_manager::_id_11048);

  self waittill("reaction_end");
}

_id_CD50(var_0, var_1, var_2) {
  self endon("death");
  self endon("reaction_end");
  var_3 = _id_7A45(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  self._id_B004 = var_3._id_EBEA;

  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  self._id_1F25 = 0;
  self._id_EBF8 = 0;
  self._id_F274 = 0;
  self._id_10254 = 0;
  self._id_9C84 = 0;
  self._id_BE79 = 0;
  self._id_9A30 = var_0;
  self._id_DD4C = 1;
  self._id_C6B9 = undefined;
  self._id_C6B7 = undefined;

  if(!isDefined(self._id_1C4D))
    self._id_1C4D = 1;

  if(isDefined(level._id_9A2E))
    level._id_9A2E._id_4D94["actors"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["actors"], self);

  if(isDefined(var_2))
    self._id_C6B7 = var_2;

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(self._id_B004["idle"]))
      var_5 = self._id_B004["idle"][0];
    else
      var_5 = self._id_B004["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);
    self._id_C6B9 = var_1;
  }

  if(!isDefined(self._id_9B89))
    self animmode("noclip");

  if(!isDefined(self._id_1EDB))
    self._id_1EDB = spawnStruct();

  if(isDefined(self._id_B004["no_gun"])) {
    if(!isDefined(self._id_9B89) && self.weapon != "none")
      scripts\sp\utility::_id_86E4();
  }

  if(isDefined(self._id_9B89)) {
    thread _id_101F9();
    thread _id_9A10();
  } else
    _id_0A1E::_id_2307(::_id_101F9, ::_id_9A0F);

  self waittill("reaction_end");
}

_id_CD4D(var_0, var_1) {
  self endon("death");
  self notify("reaction_end");
  var_2 = _id_7A45(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  _id_E1CE(var_2, var_0);
  _id_1690();
  _id_BBFA(var_1);
  _id_E7DE();
}

_id_E1CE(var_0, var_1) {
  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  self._id_B004 = var_0._id_EBEA;
  self._id_1F25 = 0;
  self._id_EBF8 = 0;
  self._id_F274 = 0;
  self._id_10254 = 0;
  self._id_9C84 = 0;
  self._id_BE79 = 0;
  self._id_9A30 = var_1;
  self._id_DD4C = 1;

  if(!isDefined(self._id_1C4D) || isDefined(self._id_1C4D) && !self._id_1C4D)
    self._id_1C4D = 1;

  if(!isDefined(self._id_1EDB))
    self._id_1EDB = spawnStruct();

  if(isDefined(self._id_B004["no_gun"])) {
    if(!isDefined(self._id_9B89))
      scripts\sp\utility::_id_86E4();
  }
}

_id_1690() {
  if(isDefined(level._id_9A2E))
    level._id_9A2E._id_4D94["actors"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["actors"], self);
}

_id_7A46() {
  if(isarray(self._id_B004["idle"]))
    return self._id_B004["idle"][0];
  else
    return self._id_B004["idle"];
}

_id_7A47(var_0) {
  var_1 = undefined;

  if(isstring(var_0))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  else if(isstruct(var_0))
    var_1 = var_0;
  else if(isent(var_0))
    var_1 = var_0;
  else {}

  return var_1;
}

_id_BBFA(var_0) {
  if(isDefined(var_0)) {
    var_1 = _id_7A46();
    var_2 = _id_7A47(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    self._id_C6B8 = var_0;
    var_3 = getstartorigin(var_2.origin, var_2.angles, var_1);
    var_4 = getstartangles(var_2.origin, var_2.angles, var_1);
    _id_1162B(var_3, var_4);

    if(!isDefined(self._id_9B89))
      self animmode("noclip");
  }
}

_id_1162B(var_0, var_1) {
  if(isDefined(self._id_9B89)) {
    self.origin = var_0;
    self.angles = var_1;
  } else
    self _meth_80F1(var_0, var_1);
}

_id_E7DE() {
  if(isDefined(self._id_9B89)) {
    thread _id_9A36();
    thread _id_9A10();
  } else
    _id_0A1E::_id_2307(::_id_9A36, ::_id_9A0F);

  self waittill("reaction_end");
}

_id_CD4F(var_0, var_1) {
  self endon("death");
  var_2 = _id_7A45(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  self._id_B004 = var_2._id_EBEA;

  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  self._id_9A30 = var_0;
  self._id_1F25 = 0;
  self._id_EBF8 = 0;
  self._id_F274 = 0;
  self._id_10254 = 0;
  self._id_9C84 = 0;
  self._id_BE79 = 0;

  if(!isDefined(self._id_1C4D))
    self._id_1C4D = 1;

  if(isDefined(level._id_9A2E))
    level._id_9A2E._id_4D94["actors"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["actors"], self);

  if(isDefined(var_1)) {
    var_3 = undefined;
    var_4 = self._id_B004["lastanim"];

    if(isstring(var_1))
      var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_3 = var_1;
    else
      return;

    self._id_B004["optional_struct"] = var_3;
  }

  if(!isDefined(self._id_1EDB))
    self._id_1EDB = spawnStruct();

  if(isDefined(self._id_B004["no_gun"])) {
    if(!isDefined(self._id_9B89))
      scripts\sp\utility::_id_86E4();
  }

  thread _id_0A1E::_id_2307(::_id_9A13);
  self waittill("interaction_done");
}

_id_4179() {
  self clearanim(%body, 0.2);
}

_id_9C3D(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectorNormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 >= var_1)
    return 1;
  else
    return 0;
}

_id_9A13() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_7245 = 0;
  _id_4179();

  if(!isDefined(self._id_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = self._id_B004["optional_struct"];
  var_1 = "single anim";

  if(!scripts\sp\utility::_id_65DF("interaction_end"))
    scripts\sp\utility::_id_65E0("interaction_end");

  scripts\sp\utility::_id_65DD("interaction_end");
  var_2 = 0.25;
  var_3 = 0.25;

  if(isDefined(self._id_B004["common_name"]))
    thread scripts\sp\interaction_manager::_id_12754();

  if(!self._id_BE79) {
    self._id_9C84 = 1;
    self notify("playing_interaction");
    var_4 = undefined;

    if(isDefined(self._id_B004["interaction_position"]))
      var_4 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
    else
      var_4 = vectortoangles(level.player.origin - self.origin);

    var_5 = abs(angleclamp(var_4 - self.angles[1]) - 360);
    var_6 = scripts\sp\math::_id_C097(0, 360, var_5);
    var_7 = self._id_B004["lastanim"];

    if(isDefined(self._id_B004["angles"])) {
      foreach(var_9 in self._id_B004["angles"]) {
        if(var_5 <= var_9) {
          var_7 = self._id_B004[var_9];
          break;
        }
      }
    }

    if(isDefined(var_0)) {
      var_11 = getstartorigin(var_0.origin, var_0.angles, var_7);
      var_12 = getstartangles(var_0.origin, var_0.angles, var_7);
      self _meth_80F1(var_11, var_12);
    }

    _id_10C47(var_7);
    self _meth_82E1(var_1, var_7, 1.0, var_2);
    var_13 = getanimlength(var_7);
    wait(var_13);
    self clearanim(var_7, var_3);
    level notify("interaction_done");
    self notify("interaction_done");
  }
}

_id_9A11() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_7245 = 0;
  _id_4179();

  if(!isDefined(self._id_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self._id_DC80 = 0;

  if(isarray(self._id_B004["idle"])) {
    var_0 = self._id_B004["idle"][0];
    thread _id_DC7D();
  } else
    var_0 = self._id_B004["idle"];

  _id_10C47(var_0);
  self _meth_82E1("idle", var_0, 1, 0.5, 1);
  thread _id_9A3B("stop");
  var_1 = "single anim";

  if(!scripts\sp\utility::_id_65DF("scene_end"))
    scripts\sp\utility::_id_65E0("scene_end");

  scripts\sp\utility::_id_65DD("scene_end");

  if(!scripts\sp\utility::_id_65DF("playing_interaction"))
    scripts\sp\utility::_id_65E0("playing_interaction");

  scripts\sp\utility::_id_65DD("playing_interaction");
  var_2 = 0.11;
  var_3 = 0.25;
  var_4 = 0.25;
  var_5 = 350;
  var_6 = 0.45;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(self._id_B004["reacquire_left"]) || isDefined(self._id_B004["reacquire_right"]))
    var_7 = 1;

  self._id_DD54 = spawn("trigger_radius", self.origin, 0, self._id_B004["trigger_radius"], self._id_B004["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self._id_DD54) || _id_9C3D(self, 0.925)) && !self._id_DC80) {
      if(self._id_F274)
        self._id_10254 = 1;
      else
        self._id_10254 = 0;
    } else
      self._id_10254 = 0;

    var_10 = lengthsquared(level.player.origin - self.origin);
    var_11 = undefined;
    var_12 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_13 = undefined;

    for(;;) {
      if(isDefined(self._id_B004["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::_id_3839(self._id_B004["trigger_radius"] * 2)) {
        if(isDefined(self._id_B004["interaction_position"]))
          var_10 = lengthsquared(self._id_B004["interaction_position"] - self.origin);
        else
          var_10 = lengthsquared(level.player.origin - self.origin);

        if(isDefined(self._id_B004["interaction_trigger_override"])) {
          break;
        } else if(self._id_B004["trigger_radius"] > 0 && var_10 < squared(self._id_B004["trigger_radius"]) && _id_9C3D(self, 0.925) && !self._id_DC80) {
          var_14 = self.origin + anglestoup(self.angles) * 66;
          var_11 = vectorNormalize(level.player getEye() - var_14) * self._id_B004["trigger_radius"] + var_14;
          var_13 = scripts\common\trace::ray_trace(var_14, var_11, self, var_12);

          if(isPlayer(var_13["entity"]) || isDefined(self._id_B004["interaction_trigger_override"])) {
            break;
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    if(isDefined(self._id_B004["common_name"]))
      thread scripts\sp\interaction_manager::_id_12754();

    self._id_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_15 = undefined;

    if(isDefined(self._id_B004["interaction_position"]))
      var_15 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
    else
      var_15 = vectortoangles(level.player.origin - self.origin);

    var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
    var_17 = scripts\sp\math::_id_C097(0, 360, var_16);

    if(isDefined(self._id_B004["backseam"])) {
      if(var_17 >= 0 && var_17 <= 0.5)
        var_17 = var_17 + 0.5;
      else
        var_17 = var_17 - 0.5;
    }

    var_18 = self._id_B004["lastanim"];

    if(isDefined(self._id_B004["angles"]) && !self._id_F274) {
      foreach(var_20 in self._id_B004["angles"]) {
        if(var_16 <= var_20) {
          var_18 = self._id_B004[var_20];
          break;
        }
      }
    }

    if(isarray(var_18)) {
      if(isarray(var_18[0])) {
        var_22 = self._id_1F25;
        var_23 = var_18[0][var_22][0];
      } else
        var_23 = var_18[0];
    } else
      var_23 = var_18;

    if(!self._id_10254) {
      _id_10C47(var_23);
      self _meth_82E2(var_1, var_23, 1, var_3, 1);
      self._id_9C84 = 1;
    }

    if(!self._id_10254) {
      if(isarray(var_18)) {
        if(isarray(var_18[0]) && !isarray(self._id_B004["diff"])) {
          var_22 = self._id_1F25;
          var_24 = var_18[0][var_22];
          thread _id_F59A(var_24);
          thread _id_CC8C(var_24);
        } else if(var_18.size > 1)
          thread _id_CC8C(var_18);
      }
    }

    if(isDefined(self._id_B004["reaction_func"]))
      self thread[[self._id_B004["reaction_func"]]]();

    var_25 = getanimlength(var_23);
    var_25 = var_25 - var_4;

    if(var_25 < 0)
      var_25 = 0;

    if(!self._id_10254)
      wait(var_25);

    if(!self._id_10254) {
      _id_10C47(self._id_B004["follow"]);
      self _meth_82E8(var_1, self._id_B004["follow"], 1, 0.25, 1);
      self _meth_82B0(self._id_B004["follow"], var_17);
      self setanimknob(self._id_B004["ring"], 1, var_4, 1);
    }

    var_26 = undefined;

    if(isarray(self._id_B004["diff"])) {
      var_22 = self._id_1F25;
      var_26 = self._id_B004["diff"][var_22];
    } else
      var_26 = self._id_B004["diff"];

    _id_10C47(var_26);
    self _meth_82E8(var_1, var_26, 1, 0.25, 1);
    self._id_9C84 = 1;

    if(!self._id_10254)
      self _meth_82AC(self._id_B004["additive"], 1, var_4, 1);

    scripts\engine\utility::delaythread(getanimlength(var_26), scripts\sp\utility::_id_65E1, "scene_end");
    scripts\sp\utility::_id_65E1("playing_interaction");
    thread scripts\sp\utility::_id_65DE("playing_interaction", getanimlength(var_26));
    var_27 = var_17;

    for(;;) {
      var_28 = distance2d(level.player.origin, self.origin);

      if((var_28 >= var_5 || scripts\sp\utility::_id_65DB("scene_end")) && !isDefined(var_7)) {
        var_10 = lengthsquared(level.player.origin - self.origin);

        if(var_10 < squared(self._id_B004["trigger_radius"])) {
          var_14 = self.origin + anglestoup(self.angles) * 66;
          var_11 = vectorNormalize(level.player getEye() - var_14) * self._id_B004["trigger_radius"] + var_14;
          var_13 = scripts\common\trace::ray_trace(var_14, var_11, self, var_12);

          if(isPlayer(var_13["entity"]) || isDefined(self._id_B004["interaction_trigger_override"])) {
            if(isarray(self._id_B004["diff"]) && self._id_1F25 < self._id_B004["diff"].size - 1) {
              self._id_F274 = 1;
              scripts\sp\utility::_id_65DD("scene_end");
              self._id_1F25 = self._id_1F25 + 1;
              self clearanim(var_26, 0.15);
              self._id_9C84 = 0;
              break;
            }
          }
        }

        if(isDefined(self._id_B004["exitangles"])) {
          var_29 = self._id_B004["exitangles_anims"]["lastexitanim"];

          if(isDefined(self._id_B004["interaction_position"]))
            var_15 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
          else
            var_15 = vectortoangles(level.player.origin - self.origin);

          var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);

          foreach(var_31 in self._id_B004["exitangles"]) {
            if(var_16 <= var_31) {
              var_29 = self._id_B004["exitangles_anims"][var_31];
              break;
            }
          }

          _id_10C47(var_29);
          self _meth_82E2(var_1, var_29, 1, var_6, 1);
          wait(getanimlength(var_29));

          if(isDefined(self._id_B004["end_idle"])) {
            if(isarray(var_18[0])) {
              if(self._id_1F25 >= var_18[0].size) {
                _id_10C47(self._id_B004["end_idle"]);
                self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
              } else {
                _id_10C47(var_0);
                self _meth_82E2(var_1, var_0, 1, var_6, 1);
              }
            } else {
              _id_10C47(self._id_B004["end_idle"]);
              self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
            }
          } else {
            _id_10C47(var_0);
            self _meth_82E2(var_1, var_0, 1, var_6, 1);
          }

          self._id_9C84 = 0;

          if(isarray(self._id_B004["diff"])) {
            if(self._id_1F25 < self._id_B004["diff"].size) {
              scripts\sp\utility::_id_65DD("scene_end");
              self clearanim(self._id_B004["follow"], 0.1);
              self clearanim(self._id_B004["ring"], 0.1);
              self._id_1F25 = self._id_1F25 + 1;
              self._id_9C84 = 0;
            }

            if(self._id_1F25 >= self._id_B004["diff"].size) {
              self._id_9C84 = 0;
              var_9 = 1;

              if(!isDefined(self._id_B004["allow_multi_use"]))
                self waittill("forever");
            }
          } else {
            var_9 = 1;

            if(!isDefined(self._id_B004["allow_multi_use"]))
              self waittill("forever");
          }

          self._id_9C84 = 0;
          break;
        } else {
          if(isDefined(self._id_B004["end_idle"])) {
            if(isarray(var_18[0])) {
              if(self._id_1F25 >= var_18[0].size) {
                _id_10C47(self._id_B004["end_idle"]);
                self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
              } else {
                _id_10C47(var_0);
                self _meth_82E2(var_1, var_0, 1, var_6, 1);
              }
            } else {
              _id_10C47(self._id_B004["end_idle"]);
              self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
            }
          } else {
            _id_10C47(var_0);
            self _meth_82E2(var_1, var_0, 1, var_6, 1);
          }

          self._id_9C84 = 0;

          if(isarray(self._id_B004["diff"])) {
            if(self._id_1F25 < self._id_B004["diff"].size) {
              scripts\sp\utility::_id_65DD("scene_end");
              self clearanim(self._id_B004["follow"], 0.1);
              self clearanim(self._id_B004["ring"], 0.1);
              self._id_1F25 = self._id_1F25 + 1;
              self._id_9C84 = 0;
            }

            if(self._id_1F25 >= self._id_B004["diff"].size) {
              self._id_9C84 = 0;
              var_9 = 1;

              if(!isDefined(self._id_B004["allow_multi_use"]))
                self waittill("forever");
            }
          } else {
            var_9 = 1;

            if(!isDefined(self._id_B004["allow_multi_use"]))
              self waittill("forever");
          }

          self._id_9C84 = 0;
          break;
        }
      }

      if(isDefined(self._id_B004["interaction_position"]))
        var_15 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
      else
        var_15 = vectortoangles(level.player.origin - self.origin);

      var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
      var_17 = scripts\sp\math::_id_C097(0, 360, var_16);

      if(self._id_7245)
        var_17 = 0;

      if(isDefined(self._id_B004["backseam"])) {
        if(var_17 >= 0 && var_17 <= 0.5)
          var_17 = var_17 + 0.5;
        else
          var_17 = var_17 - 0.5;

        var_27 = var_27 + (var_17 - var_27) * var_2;
      } else
        var_27 = var_27 + (var_17 - var_27) * var_2;

      if(isDefined(var_7)) {
        var_33 = vectorNormalize(level.player.origin - self.origin);
        var_33 = scripts\engine\utility::flatten_vector(var_33, anglestoup(self.angles));
        var_34 = anglesToForward(self.angles);
        var_35 = vectordot(var_33, var_34);
        var_16 = acos(var_35);
        var_36 = vectorcross(var_33, var_34);

        if(vectordot(var_36, anglestoup(self.angles)) < 0)
          var_16 = var_16 * -1;

        var_37 = 0;

        if(var_16 >= 90.0 && !var_37 && !scripts\sp\utility::_id_65DB("playing_interaction")) {
          var_37 = 1;
          _id_10C47(self._id_B004["reacquire_right"]);
          self clearanim(%body, 0.25);
          self _meth_82EA(var_1, self._id_B004["reacquire_right"], 1.0, 0.25);
          wait(clamp(getanimlength(self._id_B004["reacquire_right"]) - 0.25, 0, 100));
          self clearanim(self._id_B004["reacquire_right"], 0.25);
        } else if(var_16 < -90.0 && !var_37 && !scripts\sp\utility::_id_65DB("playing_interaction")) {
          var_37 = 1;
          _id_10C47(self._id_B004["reacquire_left"]);
          self clearanim(%body, 0.25);
          self _meth_82EA(var_1, self._id_B004["reacquire_left"], 1.0, 0.25);
          wait(clamp(getanimlength(self._id_B004["reacquire_left"]) - 0.25, 0, 100));
          self clearanim(self._id_B004["reacquire_left"], 0.25);
        } else
          _id_F5CD(self._id_B004["follow"], var_27);

        if(var_37) {
          if(isDefined(self._id_B004["interaction_position"]))
            var_15 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
          else
            var_15 = vectortoangles(level.player.origin - self.origin);

          var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
          var_17 = scripts\sp\math::_id_C097(0, 360, var_16);
          _id_10C47(self._id_B004["follow"]);
          self _meth_82E8(var_1, self._id_B004["follow"], 1, 0.25, 1);
          self _meth_82B0(self._id_B004["follow"], 0.5);
          self setanimknob(self._id_B004["ring"], 1, var_4, 1);

          if(!scripts\sp\utility::_id_65DB("playing_interaction") && !scripts\sp\utility::_id_65DB("scene_end")) {
            _id_10C47(self._id_B004["diff"]);
            self _meth_82E8(var_1, self._id_B004["diff"], 1, 0.05, 1);
          }

          self _meth_82AC(self._id_B004["additive"], 1, var_4, 1);
          var_27 = 0.5;
        }
      } else
        _id_F5CD(self._id_B004["follow"], var_27);

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9A35() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_7245 = 0;
  _id_4179();

  if(!isDefined(self._id_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self._id_DC80 = 0;

  if(isarray(self._id_B004["idle"])) {
    var_0 = self._id_B004["idle"][0];
    thread _id_DC7D();
  } else
    var_0 = self._id_B004["idle"];

  _id_10C47(var_0);
  self _meth_82E1("idle", var_0, 1, 0.05, 1);
  thread _id_9A3B("stop");
  var_1 = "single anim";

  if(!scripts\sp\utility::_id_65DF("scene_end"))
    scripts\sp\utility::_id_65E0("scene_end");

  scripts\sp\utility::_id_65DD("scene_end");
  var_2 = 0.11;

  if(isDefined(self._id_B004["lookat_lerp"]))
    var_2 = self._id_B004["lookat_lerp"];

  var_3 = 0.25;

  if(isDefined(self._id_B004["initial_reaction_blendtime"]))
    var_3 = self._id_B004["initial_reaction_blendtime"];

  var_4 = 0.25;

  if(isDefined(self._id_B004["lookat_follow_blendtime"]))
    var_4 = self._id_B004["lookat_follow_blendtime"];

  var_5 = 350;

  if(isDefined(self._id_B004["lookat_end_distance"]))
    var_5 = self._id_B004["lookat_end_distance"];

  var_6 = 0.45;

  if(isDefined(self._id_B004["lookat_end_blendtime"]))
    var_6 = self._id_B004["lookat_end_blendtime"];

  self._id_DD54 = spawn("trigger_radius", self.origin, 0, self._id_B004["trigger_radius"], self._id_B004["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self._id_DD54) || _id_9C3D(self, 0.925)) && !self._id_DC80) {
      if(self._id_F274)
        self._id_10254 = 1;
      else
        self._id_10254 = 0;
    } else
      self._id_10254 = 0;

    var_7 = lengthsquared(level.player.origin - self.origin);
    var_8 = undefined;
    var_9 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_10 = undefined;

    for(;;) {
      if(isDefined(self._id_B004["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::_id_3839(self._id_B004["trigger_radius"] * 2)) {
        if(isDefined(self._id_B004["interaction_position"]))
          var_7 = lengthsquared(self._id_B004["interaction_position"] - self.origin);
        else
          var_7 = lengthsquared(level.player.origin - self.origin);

        if(isDefined(self._id_B004["interaction_trigger_override"])) {
          break;
        } else if(self._id_B004["trigger_radius"] > 0 && var_7 < squared(self._id_B004["trigger_radius"]) && _id_9C3D(self, 0.925) && !self._id_DC80) {
          var_11 = self.origin + anglestoup(self.angles) * 66;
          var_8 = vectorNormalize(level.player getEye() - var_11) * self._id_B004["trigger_radius"] + var_11;
          var_10 = scripts\common\trace::ray_trace(var_11, var_8, self, var_9);

          if(isPlayer(var_10["entity"]) || isDefined(self._id_B004["interaction_trigger_override"])) {
            break;
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    if(isDefined(self._id_B004["common_name"]))
      thread scripts\sp\interaction_manager::_id_12754();

    self._id_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_12 = undefined;

    if(isDefined(self._id_B004["interaction_position"]))
      var_12 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
    else
      var_12 = vectortoangles(level.player.origin - self.origin);

    var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);
    var_14 = self._id_B004["lastanim"];

    if(isDefined(self._id_B004["angles"])) {
      foreach(var_16 in self._id_B004["angles"]) {
        if(var_13 <= var_16) {
          var_14 = self._id_B004[var_16];
          break;
        }
      }
    }

    if(isarray(var_14)) {
      if(isarray(var_14[0]) && self._id_1F25 < var_14[0].size) {
        var_18 = self._id_1F25;
        var_19 = var_14[0][var_18][0];
      } else
        var_19 = var_14[0];
    } else
      var_19 = var_14;

    if(!self._id_10254) {
      _id_10C47(var_19);
      self _meth_82E2(var_1, var_19, 1, var_3, 1);
      self._id_9C84 = 1;
    }

    level thread scripts\sp\interaction_manager::_id_9A0E(self);

    if(isDefined(self._id_B004["scene"])) {
      if(isDefined(self._id_B004["interaction_position"]))
        var_12 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
      else
        var_12 = vectortoangles(level.player.origin - self.origin);

      var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);

      if(self._id_10254)
        wait 0.0;
      else
        wait(getanimlength(var_19));

      if(isarray(self._id_B004["scene"])) {
        var_20 = self._id_EBF8;
        _id_10C47(self._id_B004["scene"][var_20]);
        self _meth_82E2(var_1, self._id_B004["scene"][var_20], 1, var_4, 1);
        wait(getanimlength(self._id_B004["scene"][var_20]));
        self._id_EBF8 = self._id_EBF8 + 1;
        self._id_F274 = 1;
      } else {
        _id_10C47(self._id_B004["scene"]);
        self _meth_82E2(var_1, self._id_B004["scene"], 1, var_4, 1);
        wait(getanimlength(self._id_B004["scene"]));
      }
    }

    if(isDefined(self._id_B004["exitangles"])) {
      if(isDefined(self._id_B004["interaction_position"]))
        var_12 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
      else
        var_12 = vectortoangles(level.player.origin - self.origin);

      var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);
      var_21 = self._id_B004["exitangles_anims"]["lastexitanim"];

      foreach(var_23 in self._id_B004["exitangles"]) {
        if(var_13 <= var_23) {
          var_21 = self._id_B004["exitangles_anims"][var_23];
          break;
        }
      }

      _id_10C47(var_21);
      self _meth_82E2(var_1, var_21, 1, var_6, 1);
      wait(getanimlength(var_21));

      if(isDefined(self._id_B004["end_idle"])) {
        if(isarray(var_14[0])) {
          if(self._id_1F25 >= var_14[0].size) {
            _id_10C47(self._id_B004["end_idle"]);
            self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
          } else {
            _id_10C47(var_0);
            self _meth_82E2(var_1, var_0, 1, var_6, 1);
          }
        } else {
          _id_10C47(self._id_B004["end_idle"]);
          self _meth_82E2(var_1, self._id_B004["end_idle"], 1, var_6, 1);
        }
      } else {
        _id_10C47(var_0);
        self _meth_82E2(var_1, var_0, 1, var_6, 1);
      }

      self._id_9C84 = 0;

      if(!isDefined(self._id_B004["allow_multi_use"]))
        self waittill("forever");
    }

    if(!self._id_10254) {
      if(isarray(var_14)) {
        if(isarray(var_14[0]) && self._id_1F25 < var_14[0].size) {
          var_18 = self._id_1F25;
          var_25 = var_14[0][var_18];
          thread _id_F59A(var_25);
          thread _id_CC8C(var_25);
        } else if(var_14.size > 1)
          thread _id_CC8C(var_14);
      }
    }

    if(isDefined(self._id_B004["reaction_func"]))
      self[[self._id_B004["reaction_func"]]]();

    var_26 = getanimlength(var_19);
    wait(var_26);

    if(isDefined(self._id_B004["end_idle"])) {
      if(isarray(var_14)) {
        if(isarray(var_14[0])) {
          _id_10C47();

          if(self._id_1F25 >= var_14[0].size - 1)
            self _meth_82E3(var_1, self._id_B004["end_idle"], %body, 1, var_6, 1);
          else
            self _meth_82E3(var_1, var_0, %body, 1, var_6, 1);
        } else
          self _meth_82E3(var_1, self._id_B004["end_idle"], %body, 1, var_6, 1);
      } else {
        _id_10C47();
        self _meth_82E3(var_1, self._id_B004["end_idle"], %body, 1, var_6, 1);
      }
    } else {
      _id_10C47();
      self _meth_82E3(var_1, var_0, %body, 1, var_6, 1);
    }

    self._id_1F25 = self._id_1F25 + 1;
    level notify("interaction_done");
    self notify("interaction_done");

    if(isarray(var_14)) {
      if(isarray(var_14[0]) && self._id_1F25 < var_14[0].size) {
        var_27 = self._id_F273 + self._id_F275 - getanimlength(var_19);
        var_28 = self._id_F273 + self._id_F275 + getanimlength(var_19);
        var_29 = clamp(var_27, 0, var_28);
        wait(var_29);
        self clearanim(var_19, 0.1);
        self._id_9C84 = 0;
      } else {
        self._id_9C84 = 0;

        if(!isDefined(self._id_B004["allow_multi_use"]))
          self waittill("forever");
      }
    } else {
      self._id_9C84 = 0;

      if(!isDefined(self._id_B004["allow_multi_use"]))
        self waittill("forever");
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9A37() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  _id_4179();

  if(!isDefined(self._id_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self._id_DC80 = 0;
  var_1 = _id_7CA7(self._id_9A30);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 = var_1._id_EBEA;
  var_2 = undefined;

  if(isarray(var_1["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female"))
      var_2 = "idle_female";
    else
      var_2 = "idle";

    var_0 = var_1[var_2][0];
    thread _id_DC7E();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female"))
      var_2 = "idle_female";
    else
      var_2 = "idle";

    var_0 = var_1[var_2];
  }

  var_3 = "single anim";
  _id_10C47(var_0);
  self _meth_82E1(var_3, var_0, 1, 0.5, 1);
  self _meth_82B0(var_0, randomfloat(1));
  thread _id_9A3B("stop");
  thread _id_CC88();

  if(!scripts\sp\utility::_id_65DF("scene_end"))
    scripts\sp\utility::_id_65E0("scene_end");

  scripts\sp\utility::_id_65DD("scene_end");
  var_4 = 0.11;
  var_5 = 0.25;
  var_6 = 0.25;
  var_7 = 350;
  var_8 = 0.45;
  self._id_DD54 = spawn("trigger_radius", self.origin, 0, var_1["trigger_radius"], var_1["trigger_radius"]);

  for(;;) {
    var_9 = lengthsquared(level.player.origin - self.origin);
    var_10 = undefined;
    var_11 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_12 = undefined;

    for(;;) {
      if(!isDefined(self._id_DD49) || isDefined(self._id_DD49) && self._id_DD49 != "busy" && self._id_DD49 != "nag") {
        if(scripts\sp\interaction_manager::_id_3839(var_1["trigger_radius"] * 2)) {
          if(isDefined(var_1["interaction_position"]))
            var_9 = lengthsquared(var_1["interaction_position"] - self.origin);
          else
            var_9 = lengthsquared(level.player.origin - self.origin);

          if(isDefined(var_1["interaction_trigger_override"])) {
            break;
          } else if(var_1["trigger_radius"] > 0 && var_9 < squared(var_1["trigger_radius"]) && _id_9C3D(self, 0.925) && !self._id_DC80) {
            var_13 = self.origin + anglestoup(self.angles) * 66;
            var_10 = vectorNormalize(level.player getEye() - var_13) * var_1["trigger_radius"] + var_13;
            var_12 = scripts\common\trace::ray_trace(var_13, var_10, self, var_11);

            if(isPlayer(var_12["entity"]) || isDefined(var_1["interaction_trigger_override"])) {
              break;
            }
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    self._id_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_14 = undefined;

    if(isDefined(var_1["interaction_position"]))
      var_14 = vectortoangles(var_1["interaction_position"] - self.origin);
    else
      var_14 = vectortoangles(level.player.origin - self.origin);

    var_15 = abs(angleclamp(var_14 - self.angles[1]) - 360);
    var_16 = "lastanim";

    if(isDefined(var_1["angles"])) {
      foreach(var_18 in var_1["angles"]) {
        if(var_15 <= var_18) {
          var_16 = var_18;
          break;
        }
      }
    }

    if(level._id_10E1C[self._id_9A30]._id_EBEA[var_16].size < 1) {
      level._id_10E1C[self._id_9A30]._id_EBEA[var_16] = level._id_10E1C[self._id_9A30]._id_EBEA["angle_" + scripts\sp\utility::string(var_16) + "_spent"];
      level._id_10E1C[self._id_9A30]._id_EBEA["angle_" + var_16 + "_spent"] = [];
    }

    var_20 = randomint(level._id_10E1C[self._id_9A30]._id_EBEA[var_16].size);
    var_21 = level._id_10E1C[self._id_9A30]._id_EBEA[var_16][var_20];
    _id_10C47(var_21);
    self _meth_82E2(var_3, var_21, 1, var_5, 1);
    self._id_9C84 = 1;
    thread scripts\sp\interaction_manager::_id_9A39();
    wait(getanimlength(var_21));
    level._id_10E1C[self._id_9A30]._id_EBEA["angle_" + var_16 + "_spent"] = scripts\engine\utility::array_add(level._id_10E1C[self._id_9A30]._id_EBEA["angle_" + var_16 + "_spent"], var_21);
    level._id_10E1C[self._id_9A30]._id_EBEA[var_16] = scripts\engine\utility::array_remove(level._id_10E1C[self._id_9A30]._id_EBEA[var_16], var_21);

    if(isDefined(var_1["exitangles"])) {
      if(isDefined(var_1["interaction_position"]))
        var_14 = vectortoangles(var_1["interaction_position"] - self.origin);
      else
        var_14 = vectortoangles(level.player.origin - self.origin);

      var_15 = abs(angleclamp(var_14 - self.angles[1]) - 360);
      var_22 = "lastexitanim";

      foreach(var_24 in var_1["exitangles"]) {
        if(var_15 <= var_24) {
          var_22 = var_24;
          break;
        }
      }

      if(level._id_10E1C[self._id_9A30]._id_EBEA[var_22].size < 1) {
        level._id_10E1C[self._id_9A30]._id_EBEA[var_22][var_22] = level._id_10E1C[self._id_9A30]._id_EBEA[var_22]["exit_angle_" + scripts\sp\utility::string(var_22) + "_spent"];
        level._id_10E1C[self._id_9A30]._id_EBEA[var_22]["exit_angle_" + scripts\sp\utility::string(var_22) + "_spent"] = [];
      }

      var_20 = randomint(level._id_10E1C[self._id_9A30]._id_EBEA[var_22].size);
      var_26 = level._id_10E1C[self._id_9A30]._id_EBEA[var_22][var_20];
      _id_10C47(var_26);
      self _meth_82E2(var_3, var_26, 1, var_8, 1);
      wait(getanimlength(var_26));
      level._id_10E1C[self._id_9A30]._id_EBEA[var_22] = scripts\engine\utility::array_remove(level._id_10E1C[self._id_9A30]._id_EBEA[var_22], var_26);
    }

    _id_10C47(var_0);
    self _meth_82E2(var_3, var_0, 1, var_8, 1);
    self._id_9C84 = 0;

    if(isDefined(var_1["reaction_func"]))
      self[[var_1["reaction_func"]]]();

    level notify("interaction_done");
    thread scripts\sp\interaction_manager::_id_F566("busy");
    scripts\engine\utility::waitframe();
    level waittill("forever");
  }
}

_id_9A36() {
  self endon("death");
  self endon("reaction_end");
  _id_9843();
  var_0 = 0.11;
  var_1 = 0.25;
  var_2 = 0.25;
  var_3 = 350;
  var_4 = _id_F8D1();
  var_5 = "single anim";

  for(;;) {
    self._id_10254 = _id_9C61();
    _id_2B88();
    self._id_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");

    if(isDefined(self._id_B004["common_name"]))
      thread scripts\sp\interaction_manager::_id_12754();

    _id_CCA9();
    scripts\engine\utility::waitframe();
  }
}

_id_9843() {
  self _meth_83A1();
  self._id_7245 = 0;
  _id_4179();

  if(!isDefined(self._id_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  if(!scripts\sp\utility::_id_65DF("scene_end"))
    scripts\sp\utility::_id_65E0("scene_end");

  scripts\sp\utility::_id_65DD("scene_end");
  self._id_DD54 = spawn("trigger_radius", self.origin, 0, self._id_B004["trigger_radius"], self._id_B004["trigger_radius"]);
}

_id_F8D1() {
  var_0 = _id_7A4C();
  self._id_DC80 = 0;
  _id_10C47(var_0);
  self _meth_82E1("single anim", var_0, 1, 0.05, 1);
  thread _id_9A3B("stop");
}

_id_7A4C() {
  var_0 = undefined;

  if(isarray(self._id_B004["idle"]))
    var_0 = self._id_B004["idle"][0];
  else
    var_0 = self._id_B004["idle"];

  return var_0;
}

_id_9C61() {
  var_0 = undefined;

  if((level.player istouching(self._id_DD54) || _id_9C3D(self, 0.925)) && !self._id_DC80) {
    if(self._id_F274)
      var_0 = 1;
    else
      var_0 = 0;
  } else
    var_0 = 0;

  return var_0;
}

_id_2B88() {
  var_0 = lengthsquared(level.player.origin - self.origin);
  var_1 = undefined;
  var_2 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_3 = undefined;

  for(;;) {
    var_4 = scripts\sp\interaction_manager::_id_3839(self._id_B004["trigger_radius"] * 2);

    if(var_4) {
      if(isDefined(self._id_B004["interaction_position"]))
        var_0 = lengthsquared(self._id_B004["interaction_position"] - self.origin);
      else
        var_0 = lengthsquared(level.player.origin - self.origin);

      if(isDefined(self._id_B004["interaction_trigger_override"])) {
        break;
      } else if(self._id_B004["trigger_radius"] > 0 && var_0 < squared(self._id_B004["trigger_radius"]) && _id_9C3D(self, 0.925) && !self._id_DC80) {
        var_5 = self.origin + anglestoup(self.angles) * 66;
        var_1 = vectorNormalize(level.player getEye() - var_5) * self._id_B004["trigger_radius"] + var_5;
        var_3 = scripts\common\trace::ray_trace(var_5, var_1, self, var_2);

        if(isPlayer(var_3["entity"]) || isDefined(self._id_B004["interaction_trigger_override"])) {
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_CCA9() {
  _id_9842();
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime() / 1000;
  var_3 = getanimlength(self._id_B004["fwd_anim"]);

  while(gettime() / 1000 - var_2 < var_3) {
    var_4 = vectorNormalize(level.player.origin - self.origin);
    var_5 = anglesToForward(self.angles);
    var_6 = anglesToForward(self.angles) * -1;
    var_7 = anglestoright(self.angles);
    var_8 = anglestoright(self.angles) * -1;
    var_9 = anglestoup(self.angles);
    var_10 = clamp(vectordot(var_4, var_5), 0.005, 1);
    var_11 = clamp(vectordot(var_4, var_7), 0.005, 1);
    var_12 = clamp(vectordot(var_4, var_8), 0.005, 1);
    var_13 = clamp(vectordot(var_4, var_6), 0.005, 1);
    self _meth_82AC(self._id_B004["right_anim"], var_11, 0.2);
    self _meth_82AC(self._id_B004["left_anim"], var_12, 0.2);
    self _meth_82E8("single anim", self._id_B004["fwd_anim"], var_10 + 0.005, 0.2);
    var_14 = 1;

    if(scripts\engine\utility::anglebetweenvectorssigned(var_5, var_4, var_9) > 0)
      var_14 = 0;

    if(var_14) {
      var_1 = scripts\sp\math::_id_AB6F(var_1, var_13, 0.1);
      var_0 = scripts\sp\math::_id_AB6F(var_0, 0.005, 0.1);
    } else {
      var_1 = scripts\sp\math::_id_AB6F(var_1, 0.005, 0.1);
      var_0 = scripts\sp\math::_id_AB6F(var_0, var_13, 0.1);
    }

    self _meth_82AC(self._id_B004["back_right_anim"], var_1, 0.2);
    self _meth_82AC(self._id_B004["back_left_anim"], var_0, 0.2);
    scripts\engine\utility::waitframe();
  }

  var_15 = 0.45;
  _id_62AB(var_15);
  _id_CD4E(var_15);
}

_id_9842() {
  var_0 = undefined;
  var_0 = vectortoangles(level.player.origin - self.origin);
  self._id_9C84 = 1;
  level thread scripts\sp\interaction_manager::_id_9A0E(self);
  self _meth_82AC(self._id_B004["interaction_blend_parent"], 1.0, 0.2);
  var_1 = _id_7A4C();
  self clearanim(var_1, 0.2);
  self clearanim(%head, 0.2);
  _id_10C47(self._id_B004["fwd_anim"]);
  self _meth_82E8("single anim", self._id_B004["fwd_anim"], 0.005, 0.05);
  self _meth_82AC(self._id_B004["right_anim"], 0.005, 0.05);
  self _meth_82AC(self._id_B004["left_anim"], 0.005, 0.05);
  self _meth_82AC(self._id_B004["back_right_anim"], 0.005, 0.05);
  self _meth_82AC(self._id_B004["back_left_anim"], 0.005, 0.05);
}

_id_62AB(var_0) {
  self._id_DD3C = undefined;
  self clearanim(self._id_B004["fwd_anim"], var_0);
  self clearanim(self._id_B004["right_anim"], var_0);
  self clearanim(self._id_B004["left_anim"], var_0);
  self clearanim(self._id_B004["back_right_anim"], var_0);
  self clearanim(self._id_B004["back_left_anim"], var_0);
  level notify("interaction_done");
  self notify("interaction_done");
  self._id_9C84 = 0;
}

_id_CD4E(var_0) {
  for(;;) {
    var_1 = undefined;

    if(isDefined(self._id_B004["end_idle"])) {
      var_1 = self._id_B004["end_idle"];
      _id_10C47(var_1);
      self _meth_82B0(var_1, 0);
      self _meth_82E3("single anim", var_1, %body, 1, var_0, 1);
    } else {
      var_1 = _id_7A4C();
      _id_10C47(var_1);
      self _meth_82B0(var_1, 0);
      self _meth_82E3("single anim", var_1, %body, 1, var_0, 1);
    }

    wait(getanimlength(var_1));
  }
}

_id_101F9() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = _id_7A45(self._id_9A30);

  if(!scripts\sp\utility::_id_65DF("hold_simple_idles"))
    scripts\sp\utility::_id_65E0("hold_simple_idles");
  else
    scripts\sp\utility::_id_65DD("hold_simple_idles");

  if(!isarray(var_0._id_EBEA["idle"])) {
    return;
  }
  if(isarray(var_0._id_EBEA["idle"]) && var_0._id_EBEA["idle"].size <= 1) {
    return;
  }
  var_1 = [];
  var_2 = var_0._id_EBEA["idle"];
  var_3 = var_2[0];
  var_2 = scripts\sp\utility::array_remove_index(var_2, 0);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_0._id_EBEA["idle_prop"]) && isDefined(self._id_C6B7)) {
    var_4 = [];
    var_0._id_EBEA["spent_array_prop"] = var_4;
    var_6 = var_0._id_EBEA["idle_prop"];
    var_5 = var_6[0];
    var_6 = scripts\sp\utility::array_remove_index(var_6, 0);
    var_7 = var_6;
    var_6 = undefined;
  }

  var_8 = var_2;
  var_2 = undefined;
  thread _id_4179();
  _id_9A3B("stop");

  for(;;) {
    if(isDefined(self._id_C6B9))
      _id_13CA(self._id_C6B9, var_3);

    _id_10C47(var_3);
    self _meth_82E2("single anim", var_3, 1, 0.2, 1);
    thread _id_0C4C::_id_19BE();

    if(isDefined(self._id_C6B7))
      thread _id_1404(var_5);

    wait(getanimlength(var_3) * randomintrange(1, 2));

    while(scripts\sp\utility::_id_65DB("hold_simple_idles"))
      wait(getanimlength(var_3));

    if(var_8.size <= 0) {
      var_8 = var_1;
      var_1 = [];
    }

    var_9 = randomint(var_8.size);
    var_10 = var_8[var_9];
    var_1 = scripts\engine\utility::array_add(var_1, var_10);
    var_8 = scripts\sp\utility::array_remove_index(var_8, var_9);

    if(isDefined(self._id_C6B7)) {
      if(var_7.size <= 0) {
        var_7 = var_4;
        var_4 = [];
      }

      var_11 = var_7[var_9];
      var_4 = scripts\engine\utility::array_add(var_4, var_11);
      var_7 = scripts\sp\utility::array_remove_index(var_7, var_9);
      thread _id_1403(var_11);
    }

    self clearanim(var_3, 0.2);

    if(isDefined(self._id_C6B9))
      _id_13CA(self._id_C6B9, var_10);

    _id_10C47(var_10);
    self _meth_82E2("single anim", var_10, 1, 0.2, 1);
    thread _id_0C4C::_id_19BD();
    wait(getanimlength(var_10));
    self clearanim(var_10, 0.2);

    if(isDefined(self._id_C6B7))
      thread _id_1402();

    scripts\engine\utility::waitframe();
  }
}

_id_13CA(var_0, var_1) {
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);

  if(!isDefined(self._id_9B89)) {
    self _meth_80F1(var_2, var_3, 100000);
    wait 0.05;
  } else {
    self.origin = var_2;
    self.angles = var_3;
    self dontinterpolate();
    wait 0.05;
  }
}

#using_animtree("script_model");

_id_1403(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_C6B7 _meth_83D0(#animtree);
  self._id_C6B7 clearanim(self._id_C6B7._id_4B31, 0.2);
  self._id_C6B7 setanimknob(var_0, 1, 0.2, 1);
  self._id_C6B7._id_4B31 = var_0;
}

_id_1404(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_C6B7 _meth_83D0(#animtree);
  self._id_C6B7 setanimknob(var_0, 1, 0.2, 1);
  self._id_C6B7._id_4B31 = var_0;
}

_id_1402() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_C6B7 _meth_83D0(#animtree);
  self._id_C6B7 clearanim(self._id_C6B7._id_4B31, 0.2);
}

_id_CC8B(var_0, var_1) {
  wait(var_0);
  var_2 = strtok(var_1, "_");

  if(scripts\engine\utility::array_contains(var_2, "plr"))
    level.player scripts\sp\utility::play_sound_on_entity(var_1);
  else
    scripts\sp\utility::_id_10346(var_1);
}

_id_1368() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");

  for(;;) {
    self waittill("single anim", var_0);

    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(issubstr(var_2, "vo_") && !issubstr(var_2, "_plr")) {
          var_3 = getsubstr(var_2, 3);
          thread scripts\sp\utility::_id_10346(var_3);
          wait(lookupsoundlength(var_3) / 1000);
          self notify("single dialogue");

          if(isDefined(self._id_EF82))
            self clearanim(self._id_EF82, 0.2);
        }
      }

      continue;
    }

    if(issubstr(var_0, "vo_") && !issubstr(var_0, "_plr")) {
      var_3 = getsubstr(var_0, 3);
      thread scripts\sp\utility::_id_10346(var_3);
      wait(lookupsoundlength(var_3) / 1000);
      self notify("single dialogue");

      if(isDefined(self._id_EF82))
        self clearanim(self._id_EF82, 0.2);
    }
  }
}

_id_CDB1(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  var_1 = 0;

  while(!var_1) {
    self waittill("single anim", var_2);

    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "reaction_vo") {
          var_1 = 1;
          break;
        }
      }
    } else if(var_2 == "reaction_vo") {
      var_1 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::_id_CE17(var_0);
}

_id_CC88() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = undefined;
  var_1 = undefined;

  if(!isDefined(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"])) {
    return;
  }
  if(!isDefined(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"])) {
    return;
  }
  if(!isDefined(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_male_vo"]))
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_male_vo"] = [];

  if(isDefined(self.gender) && issubstr(self.gender, "male")) {
    if(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"].size < 1)
      level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"] = level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_male_vo"];

    var_2 = level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_male"], var_3);
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_male_vo"], var_1);
  }

  if(!isDefined(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_female_vo"]))
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_female_vo"] = [];

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"].size < 1)
      level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"] = level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_female_vo"];

    var_2 = level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["vo_lines_female"], var_3);
    level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["registered_state_interactions"][self._id_9A30]["used_female_vo"], var_1);
  }

  var_4 = undefined;

  for(;;) {
    self waittill("single anim", var_5);

    if(isarray(var_5)) {
      foreach(var_7 in var_5) {
        if(var_7 == "reaction_vo") {
          var_4 = 1;
          break;
        }
      }
    } else if(var_5 == "reaction_vo")
      var_4 = 1;

    if(isDefined(var_4)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_10346(var_1);
}

_id_CC8C(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30];

  if(isDefined(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"])) {
    var_1 = 1;

    if(!isDefined(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_male_vo"]))
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_male_vo"] = [];

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"].size < 1)
        level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"] = level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_male_vo"];

      var_4 = level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_male"], var_5);
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_male_vo"], var_2);
    }
  }

  if(isDefined(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"])) {
    var_1 = 1;

    if(!isDefined(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_female_vo"]))
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_female_vo"] = [];

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"].size < 1)
        level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"] = level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_female_vo"];

      var_4 = level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["vo_lines_female"], var_5);
      level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["registered_interactions"][self._id_9A30]["used_female_vo"], var_2);
    }
  }

  var_6 = var_0.size - 1;

  if(!isDefined(var_1)) {
    if(isstring(var_0[var_6])) {
      for(var_7 = 1; var_7 < var_0.size; var_7 = var_7 + 2)
        _id_CC8B(var_0[var_7], var_0[var_7 + 1]);

      return;
    }

    for(var_7 = 1; var_7 < var_0.size - 1; var_7 = var_7 + 2)
      _id_CC8B(var_0[var_7], var_0[var_7 + 1]);

    return;
  } else
    _id_CC8B(var_0[1], var_2);
}

_id_F59A(var_0) {
  self._id_F275 = 0.0;
  self._id_F273 = 0.0;
  var_1 = var_0.size - 1;

  if(isstring(var_0[var_1])) {
    self._id_F273 = 0.0;

    for(var_2 = 1; var_2 < var_0.size; var_2 = var_2 + 2)
      self._id_F275 = self._id_F275 + var_0[var_2];
  } else {
    self._id_F273 = var_0[var_1];

    for(var_2 = 1; var_2 < var_0.size - 1; var_2 = var_2 + 2)
      self._id_F275 = self._id_F275 + var_0[var_2];
  }
}

_id_DC7D() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_0 = undefined;
  var_1 = _id_7A45(self._id_9A30);

  if(!isDefined(var_1))
    var_1 = _id_7CA7(self._id_9A30);

  self._id_383A = 1;
  self._id_9C83 = undefined;

  if(!isarray(var_1._id_EBEA["idle"]))
    var_1._id_EBEA["idle"] = [var_1._id_EBEA["idle"], var_1._id_EBEA["idle"]];

  var_2 = [];
  var_3 = var_1._id_EBEA["idle"];
  var_4 = var_3[0];
  var_3 = scripts\sp\utility::array_remove_index(var_3, 0);
  var_5 = var_3;
  var_3 = undefined;
  self._id_10DB2 = var_4;

  for(;;) {
    self._id_9C83 = 1;
    var_6 = getanimlength(var_4);
    var_7 = randomint(2) + 1;
    var_8 = var_6 * float(var_7);
    wait(var_8);

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150.0)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    if(var_5.size <= 0) {
      var_5 = var_2;
      var_2 = [];
    }

    var_9 = var_5[randomint(var_5.size)];
    var_2 = scripts\engine\utility::array_add(var_2, var_9);
    var_5 = scripts\engine\utility::array_remove(var_5, var_9);
    var_10 = undefined;
    var_11 = undefined;

    if(isDefined(self._id_C6B9)) {
      var_10 = getstartorigin(self._id_C6B9.origin, self._id_C6B9.angles, var_9);
      var_11 = getstartangles(self._id_C6B9.origin, self._id_C6B9.angles, var_9);

      if(!isDefined(self._id_9B89))
        self _meth_80F1(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    while(self._id_9C84)
      scripts\engine\utility::waitframe();

    _id_10C47(var_9);
    self _meth_82E2("single anim", var_9, 1, 0.2, 1);
    self._id_DC80 = 1;
    var_12 = getanimlength(var_9);
    wait(var_12);

    while(self._id_9C84)
      scripts\engine\utility::waitframe();

    if(isDefined(self._id_C6B9)) {
      var_10 = getstartorigin(self._id_C6B9.origin, self._id_C6B9.angles, var_4);
      var_11 = getstartangles(self._id_C6B9.origin, self._id_C6B9.angles, var_4);

      if(!isDefined(self._id_9B89))
        self _meth_80F1(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    self._id_DC80 = 0;
    self clearanim(var_9, 0.3);
    self._id_9C83 = undefined;
    _id_10C47(var_4);
    self _meth_82E2("single anim", var_4, 1, 0.2, 1);
    self _meth_82B0(var_4, randomfloat(1));

    for(;;) {
      if(isDefined(self._id_383A)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_DC7E() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_0 = undefined;
  var_1 = _id_7CA7(self._id_9A30);
  self._id_383A = 1;
  self._id_9C83 = undefined;
  var_2 = undefined;

  if(isDefined(self.gender) && issubstr(self.gender, "female"))
    var_2 = "idle_female";
  else
    var_2 = "idle";

  var_3 = var_1._id_EBEA[var_2][0];
  self._id_10DB2 = var_3;

  for(;;) {
    self._id_9C83 = 1;
    var_4 = getanimlength(var_3);
    var_5 = randomint(2) + 1;
    var_6 = var_4 * float(var_5);
    wait(var_6);

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150.0)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_7 = undefined;
    var_8 = undefined;

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_7 = "random_idles_female";
      var_8 = "spent_random_idles_female";
    } else {
      var_7 = "random_idles";
      var_8 = "spent_random_idles";
    }

    if(level._id_10E1C[self._id_9A30]._id_EBEA[var_7].size <= 0) {
      level._id_10E1C[self._id_9A30]._id_EBEA[var_7] = level._id_10E1C[self._id_9A30]._id_EBEA[var_8];
      level._id_10E1C[self._id_9A30]._id_EBEA[var_8] = [];
    }

    var_9 = level._id_10E1C[self._id_9A30]._id_EBEA[var_7][randomint(level._id_10E1C[self._id_9A30]._id_EBEA[var_7].size)];
    level._id_10E1C[self._id_9A30]._id_EBEA[var_8] = scripts\engine\utility::array_add(level._id_10E1C[self._id_9A30]._id_EBEA[var_8], var_9);
    level._id_10E1C[self._id_9A30]._id_EBEA[var_7] = scripts\engine\utility::array_remove(level._id_10E1C[self._id_9A30]._id_EBEA[var_7], var_9);
    var_10 = undefined;
    var_11 = undefined;

    if(isDefined(self._id_C6B9)) {
      var_10 = getstartorigin(self._id_C6B9.origin, self._id_C6B9.angles, var_9);
      var_11 = getstartangles(self._id_C6B9.origin, self._id_C6B9.angles, var_9);

      if(!isDefined(self._id_9B89))
        self _meth_80F1(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    while(self._id_9C84)
      scripts\engine\utility::waitframe();

    _id_10C47(var_9);
    self _meth_82E2("single anim", var_9, 1, 0.2, 1);
    self._id_DC80 = 1;
    var_12 = getanimlength(var_9);
    wait(var_12);

    while(self._id_9C84)
      scripts\engine\utility::waitframe();

    if(isDefined(self._id_C6B9)) {
      var_10 = getstartorigin(self._id_C6B9.origin, self._id_C6B9.angles, var_3);
      var_11 = getstartangles(self._id_C6B9.origin, self._id_C6B9.angles, var_3);

      if(!isDefined(self._id_9B89))
        self _meth_80F1(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    self._id_DC80 = 0;
    self clearanim(var_9, 0.3);
    self._id_9C83 = undefined;
    _id_10C47(var_3);
    self _meth_82E2("single anim", var_3, 1, 0.2, 1);
    self _meth_82B0(var_3, randomfloat(1));

    for(;;) {
      if(isDefined(self._id_383A)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_DC7F(var_0, var_1, var_2) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");

  if(!scripts\engine\utility::flag_exist("hold_group_vignettes"))
    scripts\engine\utility::flag_init("hold_group_vignettes");

  var_3 = [];
  var_4 = var_2;

  for(;;) {
    wait(randomfloatrange(var_1 * 0.5, var_1));

    foreach(var_6 in var_0) {
      if(!isDefined(var_6)) {
        self notify("stop_group_idle_controller");
        return;
      }

      var_6 endon("death");
      var_6 endon("entitydeleted");
      var_6._id_383A = undefined;
    }

    var_8 = 0;

    for(;;) {
      if(!scripts\engine\utility::flag("hold_group_vignettes")) {
        foreach(var_10 in var_0) {
          if(!isDefined(var_10._id_9C83))
            var_8++;
        }

        if(var_8 >= var_0.size) {
          break;
        } else
          var_8 = 0;
      }

      scripts\engine\utility::waitframe();
    }

    var_12 = undefined;

    if(isarray(var_2)) {
      if(var_4.size <= 0) {
        var_4 = var_2;
        var_3 = [];
      }

      var_12 = var_4[randomint(var_4.size)];
    } else
      var_12 = var_2;

    var_13 = 0;

    if(!scripts\engine\utility::flag("hold_group_vignettes")) {
      foreach(var_6 in var_0) {
        if(!isDefined(var_6)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_15 = var_6 scripts\sp\utility::_id_7DC1(var_12);
        var_16 = getstartorigin(var_6.origin, var_6.angles, var_15);
        var_17 = getstartangles(var_6.origin, var_6.angles, var_15);

        if(isai(var_6))
          var_6 _meth_80F1(var_16, var_17);
        else {
          var_6.origin = var_16;
          var_6.angles = var_17;
        }

        var_6 thread _id_10C47(var_15);
        var_6 _meth_82E2("single anim", var_15, 1.0, 0.2);
        var_6._id_1C4D = 0;
        var_6._id_906F = 1;
        var_13 = getanimlength(var_15);
      }

      wait(var_13);

      if(isarray(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_12);
        var_4 = scripts\engine\utility::array_remove(var_4, var_12);
      }

      foreach(var_20 in var_0) {
        if(!isDefined(var_20)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_15 = var_20 scripts\sp\utility::_id_7DC1(var_12);
        var_20 thread _id_10C47(var_20._id_10DB2);
        var_20 setanimknob(var_15, 0.0, 0.2);
        var_20 _meth_82E2("single anim", var_20._id_10DB2, 1, 0.2, 1);
        var_20 _meth_82B0(var_20._id_10DB2, randomfloat(1));
        var_20._id_383A = 1;
        var_20._id_1C4D = 1;
        var_20._id_906F = undefined;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9A0F() {
  if(!isDefined(self._id_DD4C)) {
    _id_0A1E::_id_2386();
    _id_9A3B("stop");
  }

  scripts\sp\interaction_manager::_id_DFB5();
  self notify("reaction_end");
  thread scripts\sp\interaction_manager::_id_10FF9();
  self notify("stop_smart_reaction");
  self._id_9CE2 = undefined;
}

_id_9A10() {
  self waittill("reaction_end");
  scripts\sp\interaction_manager::_id_DFB5();
  self notify("interaction_done");
  self notify("stop_reaction");
  self._id_9CE2 = undefined;
}

_id_F5CD(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = self islegacyagent(var_0);
  var_4 = getanimlength(var_0);
  var_5 = (var_1 - var_3) * var_4 / 0.05;
  self _meth_82AC(var_0, var_2, 0.25, var_5);
}

_id_CCCA(var_0, var_1) {
  self endon("death");
  self endon("interaction_done");
  self endon("stop_reaction");
  self endon("reaction_end");
  self._id_1F25 = 0;
  self._id_EBF8 = 0;
  self._id_F274 = 0;
  self._id_10254 = 0;
  self._id_9C84 = 0;
  self._id_BE79 = 0;
  self._id_43E5 = var_1;

  if(isDefined(level._id_9A2E))
    level._id_9A2E._id_4D94["actors"] = scripts\engine\utility::array_add(level._id_9A2E._id_4D94["actors"], self);

  while(self.script == "init")
    scripts\engine\utility::waitframe();

  for(;;) {
    for(;;) {
      var_2 = lengthsquared(level.player.origin - self.origin);

      if(var_2 < squared(150.0) && _id_9C3D(self, 0.925)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_3 = self.asmname;
    var_4 = self._id_164D[var_3]._id_4BC0;
    var_5 = anim.asm[var_3].states[var_4];
    var_6 = var_5._id_C87F;
    self._id_43E4 = _id_0A1E::asm_getallanimsforstate(var_3, var_1);
    anim.asm[var_3].states[var_4]._id_C87F = var_6;

    if(var_4 == self._id_43E5 && !self._id_BE79) {
      if(var_0._id_EE92 == "combat_reaction") {
        var_7 = [];

        if(isDefined(var_0.type)) {
          switch (var_0.type) {
            case "Cover Crouch":
              var_7 = ["combat_crouch_1", "combat_crouch_2"];
              break;
            case "Cover Left":
              switch (self.a.pose) {
                case "stand":
                  var_7 = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;
                case "crouch":
                  var_7 = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;
                case "prone":
                  break;
              }

              break;
            case "Cover Right":
              switch (self.a.pose) {
                case "stand":
                  var_7 = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;
                case "crouch":
                  var_7 = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
                  break;
                case "prone":
                  break;
              }

              break;
            case "Cover Prone":
              break;
            case "Cover Stand":
              break;
            case "Cover Crouch Window":
              var_7 = ["combat_cover_crouch_1"];
              break;
          }

          if(var_7.size > 0) {
            var_8 = randomint(var_7.size);
            var_9 = var_7[var_8];
            _id_43DA(var_9, var_0);
          } else
            return;
        }
      } else
        _id_43DA(var_0._id_EE92, var_0);
    }

    wait 1.5;
  }
}

_id_43DA(var_0, var_1) {
  self endon("death");
  self endon("interaction_done");
  var_2 = _id_7A45(var_0);
  thread scripts\sp\anim::_id_10CBF(self, "vo");
  thread _id_1368();

  if(!isDefined(var_2)) {
    return;
  }
  self._id_B004 = var_2._id_EBEA;

  if(!isDefined(self._id_1FBB))
    self._id_1FBB = "generic";

  var_3 = lengthsquared(level.player.origin - self.origin);
  var_4 = undefined;
  var_5 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_6 = undefined;

  if(isDefined(self._id_B004["interaction_position"]))
    var_3 = lengthsquared(self._id_B004["interaction_position"] - self.origin);
  else
    var_3 = lengthsquared(level.player.origin - self.origin);

  if(var_3 < squared(self._id_B004["trigger_radius"]) && _id_9C3D(self, 0.925)) {
    var_4 = vectorNormalize(level.player getEye() - self getEye()) * self._id_B004["trigger_radius"] + self getEye();
    var_6 = scripts\common\trace::ray_trace(self getEye(), var_4, self, var_5);

    if(isPlayer(var_6["entity"]))
      _id_43DB();
  }
}

#using_animtree("generic_human");

_id_43DB() {
  self endon("death");
  self endon("interaction_done");
  self._id_9C84 = 1;
  self notify("playing_interaction_scene");
  level notify("playing_interaction");
  var_0 = self._id_43E4;
  var_1 = undefined;

  if(isDefined(self._id_B004["interaction_position"]))
    var_1 = vectortoangles(self._id_B004["interaction_position"] - self.origin);
  else
    var_1 = vectortoangles(level.player.origin - self.origin);

  var_2 = abs(angleclamp(var_1 - self.angles[1]) - 360);
  var_3 = self._id_B004["lastanim"];

  if(isDefined(self._id_B004["angles"])) {
    foreach(var_5 in self._id_B004["angles"]) {
      if(var_2 <= var_5) {
        var_3 = self._id_B004[var_5];
        break;
      }
    }
  }

  if(isarray(var_3)) {
    if(isarray(var_3[0])) {
      var_7 = self._id_1F25;
      var_8 = var_3[0][var_7][0];
    } else
      var_8 = var_3[0];
  } else
    var_8 = var_3;

  _id_10C47(var_8);
  self _meth_82AC(%cover, 0, 0.25, 1);
  self _meth_82E3("vo", var_8, %body, 1, 0.25, 1);
  wait(getanimlength(var_8));
  self clearanim(%scripted, 0.25);
  self _meth_82AC(%cover, 1, 0.25, 1);
  self._id_9C84 = 0;
  wait 0.25;
  self notify("interaction_done");
  level notify("interaction_done");
  thread _id_9A0F();
}

_id_43E7(var_0) {
  var_0._id_43E6 = 1;
  wait 2.0;
  var_0._id_43E6 = undefined;
}

_id_BF07() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_0 = undefined;

  if(isDefined(self._id_A906)) {
    var_0 = self._id_A906.origin;

    while(isDefined(self._id_A906) && self._id_A906.origin == var_0)
      scripts\engine\utility::waitframe();
  } else if(isDefined(self._id_A905)) {
    var_0 = self._id_A905.origin;

    while(isDefined(self._id_A905) && self._id_A905.origin == var_0)
      scripts\engine\utility::waitframe();
  } else if(isDefined(self._id_A907)) {
    var_0 = self._id_A907;

    while(isDefined(self._id_A907) && self._id_A907 == var_0)
      scripts\engine\utility::waitframe();
  }

  self notify("interaction_done");
  thread _id_9A0F();
}

_id_9A32() {
  self endon("death");
  self endon("interaction_done");
  self._id_9A31 = undefined;

  for(;;) {
    self._id_9A31 = undefined;
    self waittill("pain");
    self._id_9A31 = 1;
    wait 5.0;
  }
}

_id_9A3B(var_0) {
  if(!isDefined(var_0))
    var_0 = "stop";

  if(isai(self))
    self.a.movement = var_0;
  else
    return;
}

_id_10C47(var_0) {
  var_1 = undefined;

  if(isDefined(self._id_9A30))
    var_1 = self._id_9A30;

  thread scripts\sp\anim::_id_10CBF(self, "single anim", var_1, undefined, var_0);
  thread scripts\sp\anim::_id_1FCA(self, "single anim", var_1);
}