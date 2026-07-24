/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_maintenance.gsc
***********************************************************/

_id_E95F() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  thread _id_0F16::_id_3E3E("maintenance_start");
  thread _id_0F16::_id_3E3D("maintenance_start", undefined, 1);
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B259();
  level thread _id_0F16::_id_991E(undefined, 1);
  visionsetalternate(4, 0);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  level thread _id_0E4B::_id_1348D(1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  scripts\sp\utility::_id_F44E(1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0, 1);
  scripts\engine\utility::flag_set("player_started_elevator_scene");
  wait 1;
  level.player _id_0B2A::_id_11429();
}

_id_E956() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F53C(1);
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  thread _id_0F16::_id_88EC();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B258();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132BF(0);
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132C4(0);
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132CA(1);
  thread _id_0BB6::_id_39DF();
  level thread _id_E95B();
  level._id_6754 thread _id_E958();
  level._id_C47F thread _id_E95C();
  level._id_EA2C thread _id_E95E();
  level thread _id_E960();
  level thread _id_E95D();
  level thread _id_B260();
  scripts\engine\utility::flag_wait("move_down_maintenance_01");
  level notify("hallway_crate");
  level.player scripts\sp\utility::_id_2B78(50, 1);
  level.player allowsprint(0);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_5141();
  thread scripts\sp\utility::_id_12641("sa_moon_hallway_tr");
  thread scripts\sp\utility::_id_266F();
  scripts\engine\utility::flag_wait("move_down_maintenance_02");
  level notify("hallway_crate");
  waitforalltransients();
}

_id_E958() {
  level endon("maintenance_tunnel_runners_alerted");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_61ED();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");
  self.animplaybackrate = 0.7;
  scripts\engine\utility::flag_wait("move_down_maintenance_01");
  scripts\engine\utility::flag_wait("maintenance_hatch_01_opened");
  scripts\engine\utility::flag_wait("move_down_maintenance_02");
  self.animplaybackrate = 1;
}

_id_E95C() {
  level endon("maintenance_tunnel_runners_alerted");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_61ED();
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");

  if(!scripts\engine\utility::flag("move_down_maintenance_01")) {
    var_0 = getnode("omar_maintenance_node_01", "targetname");
    scripts\sp\utility::_id_F3E0(var_0.radius);
    self _meth_82EE(var_0);
    scripts\engine\utility::flag_wait("move_down_maintenance_01");
  }

  scripts\engine\utility::flag_set("open_maintenance_hatch_01_enabled");
  scripts\engine\utility::flag_wait("open_maintenance_hatch_01");
  level thread _id_E959();
  scripts\engine\utility::flag_wait("maintenance_hatch_01_opened");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B253();
}

_id_E95E() {
  level endon("maintenance_tunnel_runners_alerted");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_61ED();
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");
  scripts\engine\utility::flag_wait("move_down_maintenance_01");
  scripts\engine\utility::flag_wait("maintenance_hatch_01_opened");
}

_id_B260() {
  scripts\engine\utility::flag_wait("maintenance_tunnel_runners_alerted");
  level._id_6754 scripts\sp\utility::_id_551B();
  level._id_6754 scripts\sp\utility::_id_F415(0);
  level._id_6754 scripts\sp\utility::_id_F416(0);
  level._id_6754._id_C3B2 = level._id_6754._id_2894;
  level._id_6754 scripts\sp\utility::_id_F2D8(1000);
  level._id_6754._id_CA15 = 1;
  level._id_C47F scripts\sp\utility::_id_551B();
  level._id_C47F scripts\sp\utility::_id_F415(0);
  level._id_C47F scripts\sp\utility::_id_F416(0);
  level._id_C47F._id_C3B2 = level._id_C47F._id_2894;
  level._id_C47F scripts\sp\utility::_id_F2D8(1000);
  level._id_C47F._id_CA15 = 1;
  level._id_EA2C scripts\sp\utility::_id_551B();
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  level._id_EA2C._id_C3B2 = level._id_EA2C._id_2894;
  level._id_EA2C scripts\sp\utility::_id_F2D8(1000);
  level._id_EA2C._id_CA15 = 1;
  var_0 = getEnt("maintenance_tunnel_allies_gv", "targetname");
  level._id_6754 _meth_82F1(var_0);
  level._id_C47F _meth_82F1(var_0);
  level._id_EA2C _meth_82F1(var_0);
  scripts\engine\utility::flag_wait("maintenance_tunnel_runners_dead");
  level._id_6754._id_CA15 = 0;
  level._id_6754 scripts\sp\utility::_id_F2D8(level._id_6754._id_C3B2);
  level._id_C47F._id_CA15 = 0;
  level._id_C47F scripts\sp\utility::_id_F2D8(level._id_C47F._id_C3B2);
  level._id_EA2C._id_CA15 = 0;
  level._id_EA2C scripts\sp\utility::_id_F2D8(level._id_EA2C._id_C3B2);
  level._id_6754 thread _id_E958();
  level._id_C47F thread _id_E95C();
  level._id_EA2C thread _id_E95E();
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_too_easy");
}

_id_E959() {
  var_0 = getEnt("vent_cover_model", "targetname");
  var_1 = getEnt("maintenance_hatch_01", "targetname");
  var_2 = getEnt("maintenance_hatch_01_collision", "targetname");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B250(var_1);
  var_1 movez(116, 1.5);
  wait 1.55;
  var_2 notsolid();
  var_2 connectpaths();
  var_3 = getEnt("maintenance_hatch_02_bsp", "targetname");
  var_3 hide();
  wait 0.05;
  scripts\engine\utility::flag_set("maintenance_hatch_01_opened");
}

_id_E95A(var_0) {
  var_1 = getEnt("vent_cover_model", "targetname");
  var_1.tag_origin = var_1.origin;
  var_1._id_113D6 = var_1.angles;
  var_1 linkTo(var_0, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_2 = getEnt("maintenance_hatch_02_collision", "targetname");
  var_3 = getEnt("maintenance_hatch_02_bsp", "targetname");
  var_3 hide();
  var_3 connectpaths();
  wait 5.0;
  var_2 notsolid();
  var_2 connectpaths();
  level.player _id_0B2A::_id_E2C0();
  setomnvar("ui_hud_ability_primary", 1);
  setomnvar("ui_hud_ability_secondary", 1);
  level._id_EA2C thread scripts\sp\coverwall::_id_596D();
  level._id_C47F thread scripts\sp\coverwall::_id_596D();
  level._id_6754 thread scripts\sp\coverwall::_id_596D();
  level._id_EA2C scripts\sp\utility::_id_54F7();
  wait 0.05;
  scripts\engine\utility::flag_set("maintenance_hatch_02_opened");
}

_id_E960() {
  scripts\engine\utility::flag_wait("move_down_maintenance_01");
  level._id_EA2C scripts\sp\utility::_id_1034D("mn_slt_combat_control_close");
}

_id_E95D() {
  scripts\sp\utility::_id_22CA("maintenance_tunnel_runners", ::_id_B25F);
  scripts\sp\utility::_id_22CA("maintenance_tunnel_runners", ::_id_B25E);
  scripts\engine\utility::flag_wait("spawn_maintenence_tunnel_runners");
  wait 1.0;
  level._id_EA2C thread scripts\sp\utility::_id_10346("mn_ss1_get_to_bridge_163");
  wait 1.0;
  level endon("maintenance_tunnel_runners_alerted");
  wait 1.5;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_check_fire");
}

_id_B25F() {
  level endon("maintenance_tunnel_runners_alerted");
  self endon("death");
  scripts\sp\utility::_id_F4B2(1);
  self.health = 10;
  var_0 = getnode(self.target, "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  self waittill("goal");
  self delete();
}

_id_B25E() {
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "maintenance_tunnel_runners_alerted");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("maintenance_tunnel_runners_alerted");

  if(isDefined(self) && isalive(self)) {
    var_0 = getEnt("maintenance_tunnel_runners_gv", "targetname");
    self _meth_82F1(var_0);
    scripts\sp\utility::_id_F4B2(0);
  }
}

_id_E95B() {
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_secondary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_SECONDARY_DEFENSES");
  var_0 = scripts\engine\utility::getStruct("maintenance_tunnel_obj_org_01", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin);
  scripts\engine\utility::flag_wait("open_maintenance_hatch_01");
  var_0 = scripts\engine\utility::getStruct("maintenance_tunnel_obj_org_02", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin);
}

_id_E957() {
  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F53C(1);
}