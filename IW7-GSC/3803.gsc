/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3803.gsc
**************************************/

_id_7F84() {
  if(isDefined(level._id_30E1)) {
    return level._id_30E1;
  } else {}
}

_id_7E0E(var_0) {
  if(isDefined(level._id_30E1)) {
    if(isDefined(level._id_30E1._id_1684)) {
      if(isDefined(level._id_30E1._id_1684[var_0])) {
        return level._id_30E1._id_1684[var_0];
      }
    }
  }
}

_id_179B(var_0) {
  if(isDefined(level._id_30E1._id_1684)) {
    level._id_30E1._id_1684 = scripts\engine\utility::array_add(level._id_30E1._id_1684, var_0);
  }
}

_id_181A(var_0) {
  if(isDefined(level._id_30E1._id_DD3B)) {
    level._id_30E1._id_DD3B = scripts\engine\utility::array_add(level._id_30E1._id_DD3B, var_0);
  }
}

addspeaker(var_0, var_1) {
  if(isDefined(level._id_30E1.speakers)) {
    level._id_30E1.speakers[var_0] = var_1;
  }
}

_id_984C(var_0, var_1, var_2, var_3, var_4, var_5) {
  [[var_3]]();
  level._id_30E1 = spawnStruct();
  level._id_30E1.name = var_0;
  level._id_30E1._id_1FBD = _id_48AC(var_1);
  level._id_30E1._id_1684 = _id_9861(var_2, level._id_30E1._id_1FBD);
  level._id_30E1._id_10F99 = _id_7884(var_4);
  level._id_30E1._id_2AE5 = _id_7882(var_5);
  scripts\engine\utility::flag_set("broadcast_setup_complete");
}

_id_984A() {
  if(!scripts\engine\utility::flag_exist("broadcast_started")) {
    scripts\engine\utility::flag_init("broadcast_started");
  } else {
    scripts\engine\utility::flag_clear("broadcast_started");
  }

  if(!scripts\engine\utility::flag_exist("broadcast_complete")) {
    scripts\engine\utility::flag_init("broadcast_complete");
  } else {
    scripts\engine\utility::flag_clear("broadcast_complete");
  }

  if(!scripts\engine\utility::flag_exist("broadcast_setup_complete")) {
    scripts\engine\utility::flag_init("broadcast_setup_complete");
  } else {
    scripts\engine\utility::flag_clear("broadcast_setup_complete");
  }

  if(!scripts\engine\utility::flag_exist("broadcast_postfunc_complete")) {
    scripts\engine\utility::flag_init("broadcast_postfunc_complete");
  } else {
    scripts\engine\utility::flag_clear("broadcast_postfunc_complete");
  }
}

_id_7881() {
  if(isDefined(level._id_30E1) && isDefined(level._id_30E1._id_1FBD)) {
    return level._id_30E1._id_1FBD;
  }
}

_id_48AC(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_2 rotateYaw(-180, 0.05);
  return var_2;
}

_id_7882(var_0) {
  var_1 = getEnt(var_0, "targetname");
  return var_1;
}

_id_7884(var_0) {
  var_1 = getEnt(var_0, "targetname");
  return var_1;
}

_id_9861(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = _id_1075F(var_4, var_1);
    var_5 _id_23BE(var_4);
    var_2[var_5._id_1FBB] = var_5;
    var_5 thread _id_A5B3("stop_broadcast");
  }

  return var_2;
}

_id_A5B3(var_0) {
  level waittill(var_0);
  _id_0EFB::_id_FDBA(self);
}

_id_1075F(var_0, var_1) {
  var_2 = var_0 _id_7880();
  var_3 = var_0 _id_787F();
  var_4 = [[var_3]](var_2, var_1, "cheap");
  return var_4;
}

_id_7880() {
  if(isDefined(self._id_10880)) {
    return self._id_10880;
  } else {
    return "spawner_interior";
  }
}

_id_787F() {
  if(isDefined(self.gender)) {
    if(self.gender == "female") {
      var_0 = _id_0EF8::_id_FDFD;
    } else {
      var_0 = _id_0EF8::_id_FE01;
    }
  } else
    var_0 = _id_0EF8::_id_FE01;

  return var_0;
}

_id_23BE(var_0) {
  _id_23BD(var_0);
  _id_23D4(var_0);
  _id_23BF(var_0);
  _id_23C0(var_0);
  _id_23C1(var_0);
}

_id_23BD(var_0) {
  if(isDefined(var_0._id_1FBB)) {
    self._id_1FBB = var_0._id_1FBB;
  } else {}
}

_id_23D4(var_0) {
  if(isDefined(var_0._id_DD4D)) {
    self._id_DD4D = var_0._id_DD4D;
  }
}

_id_23BF(var_0) {
  if(isDefined(var_0._id_C6B3)) {
    var_1 = getEnt(var_0._id_C6B3, "targetname");

    if(isDefined(var_1)) {
      self._id_C6B3 = var_1;
    }
  }
}

_id_23C0(var_0) {
  self._id_C7D9 = var_0._id_C7D9;
}

_id_23C1(var_0) {
  if(isDefined(var_0._id_DD42)) {
    self._id_DD42 = var_0._id_DD42;
  }
}

_id_4047(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\sp\utility::_id_22B9(var_0);
  return var_0;
}

_id_CCB8() {
  level endon("stop_broadcast");
  level._id_30E1 endon("stop_broadcast");
  _id_0EDD::_id_5552();
  childthread _id_CCB2();
  childthread _id_CCB3();
  childthread _id_CCA1();
  wait 1;
  scripts\engine\utility::flag_set("broadcast_started");
}

_id_CCA1() {
  if(!scripts\engine\utility::flag("broadcast_started")) {
    switch (level._id_30E1.name) {
      case "geneva_broadcast":
        thread scripts\engine\utility::play_sound_in_space("shipcrib_titan_walla_news_scene", (-890, -72, 284));
        break;
      default:
        break;
    }
  }
}

_id_CCB2() {
  if(!scripts\engine\utility::flag("broadcast_started")) {
    foreach(var_1 in level._id_30E1._id_1684) {
      var_1 thread _id_CCB6();
    }
  }
}

_id_CCB6() {
  self endon("death");

  if(_id_0EE4::_id_1FA3("broadcast_scene") && !scripts\engine\utility::flag("broadcast_started")) {
    _id_CC67();
  }

  _id_CC68();
}

#using_animtree("generic_human");

_id_CC67() {
  level endon("early_end_broadcast");
  self clearanim(%root, 0);

  if(!isDefined(self._id_9B89)) {
    self animmode("noclip");
  }

  level._id_30E1._id_1FBD thread scripts\sp\anim::_id_1F35(self, "broadcast_scene");
  var_0 = getanimlength(scripts\sp\utility::_id_7DC1("broadcast_scene"));
  wait(var_0);
}

early_out_broadcast() {
  stopcinematicingame();
  level notify("early_end_broadcast");
}

_id_CC68() {
  self clearanim(%root, 0.66);

  if(!isDefined(self._id_DD42)) {
    switch (self._id_C7D9) {
      case "custom_interaction":
        _id_0EE5::_id_202D(self._id_C6B5, "Sir");
        break;
      case "anim_interaction":
        _id_0EE5::_id_202D(undefined, self._id_DD4D);
        level._id_30E1._id_1FBD thread scripts\sp\anim::_id_1EEA(self, "broadcast_post_scene", self._id_1FBB + "_stop_idle");
        break;
      case "anim_only":
        level._id_30E1._id_1FBD thread scripts\sp\anim::_id_1EEA(self, "broadcast_post_scene", self._id_1FBB + "_stop_idle");
        break;
    }
  } else
    level._id_30E1._id_1FBD thread scripts\sp\anim::_id_1EEA(self, "broadcast_post_scene", self._id_1FBB + "_stop_idle");
}

_id_492F() {
  var_0 = [];

  foreach(var_2 in level._id_30E1._id_1684) {
    if(isDefined(var_2._id_DD42) && isDefined(var_2._id_DD4D)) {
      if(!isDefined(var_0[var_2._id_DD42])) {
        var_0[var_2._id_DD42] = [var_2];
        continue;
      }

      var_0[var_2._id_DD42] = ::scripts\engine\utility::array_add(var_0[var_2._id_DD42], var_2);
    }
  }

  foreach(var_5 in var_0) {
    var_6 = [];

    foreach(var_2 in var_5) {
      var_6 = scripts\engine\utility::array_add(var_6, var_2._id_DD4D);
    }

    _id_0EE5::_id_2032(var_5, var_6);
  }
}

_id_30D8(var_0) {
  wait(var_0 - 0.25);
  level notify("broadcast_scene_done");
}

_id_CCB3() {
  if(level.script == "shipcrib_europa") {
    wait 0.75;
  }

  if(!scripts\engine\utility::flag("broadcast_started")) {
    stopcinematicingame();
    _id_8EB4();
    _id_100C9();
    var_0 = _id_0EE9::_id_7C5D();
    var_1 = undefined;
    var_1 = _id_0EE9::_id_7C5C(level._id_FD7A);
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "1");

    if(isDefined(var_1) && var_1 != "none") {
      var_2 = scripts\engine\utility::getStruct("broadcast_speaker", "targetname");
      level._id_B0C0._id_10928 = spawn("script_origin", var_2.origin);
      level._id_B0C0._id_10928 playSound(var_1);
    }

    _id_13647(var_0);
    thread _id_13646();

    if(issubstr(var_0, "sc_world_lounge")) {
      cinematicingameloopresident(var_0);
      scripts\engine\utility::flag_set("broadcast_complete");
    } else
      cinematicingame(var_0);
  }
}

_id_13647(var_0) {
  if(var_0 == "sc_assault_world_newscast_vips" || var_0 == "sc_assault_world_newscast_empambush" || var_0 == "sc_assault_world_newscast_wounded" || var_0 == "sc_rogue_world_newscast") {
    var_1 = _id_7881();

    while(!var_1 scripts\sp\interaction_manager::_id_9EED(600)) {
      scripts\engine\utility::waitframe();
    }
  }
}

_id_13646() {
  level endon("broadcast_complete");
  var_0 = _id_7881();

  while(isDefined(var_0) && !var_0 scripts\sp\interaction_manager::_id_9EED(600)) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_834F("NEWSCAST");
}

_id_100C9() {
  level._id_30E1._id_10F99 hide();
  level._id_30E1._id_2AE5 show();
}

_id_8E70() {
  level._id_30E1._id_2AE5 hide();
  level._id_30E1._id_10F99 show();
}

_id_8EB4() {
  _id_0EDD::_id_8EB2();
}

_id_62BF() {
  wait 1.0;
  thread _id_0EDD::_id_6217();

  if(!scripts\engine\utility::flag("broadcast_complete")) {
    stopcinematicingame();
    _id_8E70();
  }

  scripts\engine\utility::flag_set("broadcast_complete");

  if(isDefined(level._id_B0C0._id_10928)) {
    level._id_B0C0._id_10928 stopsounds();
    wait 0.1;
    level._id_B0C0._id_10928 delete();
  }
}

_id_40C2() {
  if(isDefined(level._id_30E1)) {
    thread _id_E817();
  }
}

_id_E817() {
  scripts\engine\utility::flag_wait("broadcast_setup_complete");
  _id_10FCC();
  _id_405B();
  _id_405C();
  _id_405E();
  level._id_30E1 = undefined;
}

_id_10FCC() {
  level._id_30E1 notify("stop_broadcast");
  level notify("stop_broadcast");
}

_id_405B() {
  if(isDefined(level._id_30E1._id_1684)) {
    foreach(var_1 in level._id_30E1._id_1684) {
      _id_0EFB::_id_FDBA(var_1);
    }

    level._id_30E1._id_1684 = undefined;
  }
}

_id_405C() {
  if(isDefined(level._id_30E1._id_2AE5) && isDefined(level._id_30E1._id_10F99)) {
    if(!scripts\engine\utility::flag("broadcast_started")) {
      _id_8E70();
    }
  }
}

_id_405E() {
  if(isDefined(level._id_B0C0._id_10928)) {
    level._id_B0C0._id_10928 stopsounds();
    wait 0.1;
    level._id_B0C0._id_10928 delete();
  }
}

_id_13744() {
  if(!scripts\engine\utility::flag("broadcast_complete")) {
    while(!iscinematicplaying()) {
      scripts\engine\utility::waitframe();
    }

    while(iscinematicplaying()) {
      scripts\engine\utility::waitframe();
    }
  }

  level notify("broadcast_cinematic_complete");
}

_id_30DC(var_0) {
  if(isDefined(var_0)) {
    scripts\engine\utility::flag_wait(var_0);
  }

  _id_0EDD::_id_5552();
  _id_0EDD::_id_5553();
}