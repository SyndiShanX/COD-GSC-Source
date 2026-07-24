/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_parade.gsc
**************************************************************/

_id_C9E1() {
  scripts\engine\utility::flag_init("vengeance_final_position");
  scripts\sp\utility::_id_22CA("south_un_exterior_fake_actor", ::_id_10484);
}

_id_C8CD() {
  setsaveddvar("sm_sunSampleSizeNear", 27);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_parade_flight");
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_parade_flight", var_0);
  level.allies["admiral"] scripts\sp\utility::_id_51E1("casual");
  level.allies["salter"] scripts\sp\utility::_id_51E1("casual");
  level.player scripts\sp\utility::_id_F526("safe");
  level.allies["admiral"].goalradius = 64;
  level.allies["salter"].goalradius = 64;
  level._id_D03A = scripts\sp\vehicle::_id_1080C("parade_dropship_heli");
  var_1 = scripts\engine\utility::getStruct("parade_dropship_pathstart", "targetname");
  level._id_D03A scripts\sp\vehicle::_id_2470(var_1);
  level._id_D03A _id_0BBC::_id_C5F1("right", 0, 1);
}

_id_C8CC() {
  level._id_D03A setmaxpitchroll(5, 2);
  var_0 = 0;
  thread _id_D211();
  wait 1.0;
  thread _id_C8BE();
  thread _id_13273();
  level._id_D03A thread scripts\sp\vehicle_paths::_id_845A();
  level.player _meth_82C0("phparade_UNHQ_dropship_int_cockpit", 2.5);
  thread _id_C8D1();
  level._id_D03A waittill("reached_dynamic_path_end");
  _id_C8CE();
  scripts\engine\utility::flag_set("parade_dropship_at_hover_pos");
  thread _id_C8CB();
}

_id_C8BE() {
  var_0 = [level.allies["salter"], level.allies["admiral"], level.allies["eth3n"]];
  var_1 = level._id_D03A;
  wait 8;
  var_1 notify("stop_dropship_idles");
  var_1 scripts\sp\anim::_id_1F2C(var_0, "flyover");
  var_1 thread scripts\sp\anim::_id_1EE7(var_0, "parade_ride", "stop_dropship_idles");
}

_id_C8DE() {
  var_0 = level.player;
  var_1 = level.allies["salter"];
  var_2 = level.allies["eth3n"];
  var_3 = level.allies["admiral"];
  var_0 scripts\sp\utility::_id_10350("phparade_plt_zeusthisiskings");
  var_0 scripts\sp\utility::_id_10350("phparade_plt_sixtoredcrownwe");
  var_0 scripts\sp\utility::_id_10350("phparade_rcr_rogersixcrowns");
  var_0 scripts\sp\utility::_id_10350("phparade_plt_copyravensixtov");
  var_0 scripts\sp\utility::_id_10350("phparade_vnv_copysixvengeanc");
}

_id_13273() {
  scripts\engine\utility::flag_wait("delete_roof_guys");
  wait 1;
  var_0 = level._id_5F23;
  var_1 = var_0.spawners;
  var_2 = ["A", "B"];
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = scripts\sp\utility::_id_5CC9(var_5);
    var_6._id_1FBB = "vengeance_actor_" + var_2[randomint(2)];
    var_3[var_3.size] = var_6;
    var_6 linkTo(var_0, "tag_origin", var_5.origin_offset, var_5.angles_offset);
  }

  scripts\engine\utility::waitframe();

  foreach(var_6 in var_3) {
    var_6 thread scripts\sp\anim::_id_1EEA(var_6, "intro", "stop_vengeance_idles");
  }

  level._id_D03A waittill("reached_dynamic_path_end");
  wait 5;

  foreach(var_6 in var_3) {
    var_6 notify("stop_vengeance_idles");
    var_6 thread _id_13271("salute", "salute_idle", "stop_vengeance_idles");
  }

  scripts\engine\utility::flag_wait("aatis_has_fired");

  foreach(var_6 in var_3) {
    var_6 notify("stop_vengeance_idles");
    var_6 thread _id_13272("boom");
  }
}

_id_13271(var_0, var_1, var_2) {
  scripts\sp\anim::_id_1F35(self, var_0);
  thread scripts\sp\anim::_id_1EEA(self, var_1, var_2);
}

_id_13272(var_0) {
  scripts\sp\anim::_id_1F35(self, var_0);
  self delete();
}

_id_C8CE() {
  wait 4;
}

_id_C8D1() {
  var_0 = getEnt("mover_carrier_flyin", "targetname");
  var_0 notify("trigger");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_10D14();
}

_id_C8CB() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1103B();
}

_id_C8CA() {
  thread _id_C8CB();
}

_id_10CCD(var_0) {
  if(!isDefined(level._id_C8D8)) {
    level._id_C8D8 = [];
    level._id_C8D8 = scripts\sp\vehicle::_id_1080E("parade_ship");
  }

  foreach(var_2 in level._id_C8D8) {
    var_3 = getvehiclenode(var_2.script_parameters + "_" + var_0, "targetname");

    if(!isDefined(var_3)) {
      var_3 = getvehiclenode(var_2.target, "targetname");
    }

    if(isDefined(var_2.script_noteworthy)) {
      var_2._id_C121 = strtok(var_2.script_noteworthy, ",");
      var_2._id_B918 = 0;
    }

    var_2 scripts\sp\vehicle::_id_2471(var_3);
    var_2 thread _id_FD40();
  }
}

_id_FD40() {
  self endon("death");
  self endon("cleanup_parade_ships");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("model_swap");

    if(var_0 == "model_swap") {
      var_1 = self._id_C121[self._id_B918];
      self._id_B918++;
      self setModel(var_1);
    }
  }
}

_id_D211(var_0) {
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 hide();
  level._id_D03A scripts\sp\anim::_id_1EC3(level._id_D267, "dropship_stand");
  level._id_D267 linkTo(level._id_D03A);
  level.player setstance("stand");
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  var_1 = 1;

  if(isDefined(var_0)) {
    var_1 = 0;
  }

  level.player _meth_823C(level._id_D267, "tag_player", var_1);
  wait 1;
  var_2 = 15;
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 20, 85, var_2, var_2, 1);
  level._id_D267 show();
  scripts\sp\utility::_id_22CD("south_un_exterior_fake_actor");
}

#using_animtree("player");

_id_892C() {
  level.player _meth_823F(level._id_D03A);
  var_0 = 0;

  while(!scripts\engine\utility::flag("kill_handle_scripts")) {
    var_1 = level.player _meth_814B();

    if(var_1[1] >= 0.3) {
      var_0 = scripts\sp\math::_id_6A8E(0, 1, scripts\sp\math::_id_C097(0, 1, var_1[1])) * -1;
    } else if(var_1[1] <= -0.3) {
      var_0 = scripts\sp\math::_id_6A8E(-1, 0, scripts\sp\math::_id_C097(-1, 0, var_1[1])) * -1;
    } else {
      var_0 = 0;
    }

    if(var_0 < 0 && self islegacyagent(%ph_parade_dropship_plr) <= 0.05) {
      var_0 = 0;
    }

    self _meth_82B1(%ph_parade_dropship_plr, var_0);
    wait 0.05;
  }

  scripts\engine\utility::flag_wait("kill_handle_scripts");
  level.player _meth_823F(undefined);
}

_id_10484() {
  self endon("death");
  var_0 = self.spawner;
  self setModel("body_un_crew_ship_a_low");

  if(isDefined(var_0.animation)) {
    var_1 = var_0;

    if(isDefined(var_0.script_linkto)) {
      var_1 = scripts\engine\utility::getStruct(var_0.script_linkto, "script_linkname");
    }

    var_1 thread scripts\sp\anim::_id_1ECC(self, var_0.animation);
  }

  if(isDefined(self.target)) {
    self waittill("reached_path_end");
  }

  var_2 = self._id_A905;

  if(isDefined(var_2) && isDefined(var_2.animation)) {
    var_2 thread scripts\sp\anim::_id_1ECC(self, var_2.animation);
  }

  wait 15;
  scripts\engine\utility::flag_set("delete_roof_guys");
  self delete();
}