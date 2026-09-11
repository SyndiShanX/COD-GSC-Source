/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_bb_recovery.gsc
*****************************************************************/

function main(var_0) {
  level.obj_bb_recovery = &register_objective;
}

function blank(var_0) {}

function register_objective() {
  scripts\cp\cp_objectives::registerobjective("event_bb_recovery", &blank, &bb_recovery, &blank, &blank, &blank);
}

function bb_recovery(var_0) {
  level endon("bb_recovered");
  objective_position(var_0.objectiveindex, level.current_blackbox_corpse.origin + (0, 0, 100));
  thread bb_timer();
  level waittill("bb_timeout");
  level.current_blackbox = undefined;
  level.current_blackbox_corpse = undefined;
  scripts\cp\cp_objectives::lua_objective_incomplete("event_bb_recovery");
}

function start_bb_recovery(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, -136));
  var_1.angles = var_0.angles;
  var_1 setModel("prop_veh8_mil_air_air_blima_dst");
  var_0 delete();
  var_1 setscriptablepartstate("impact", "on");
  var_1 setscriptablepartstate("stage3", "on");
  var_2 = randomint(360);
  var_3 = randomintrange(150, 500);
  var_4 = var_1.origin + anglesToForward((0, var_2, 0)) * var_3;
  var_5 = getgroundposition(getclosestpointonnavmesh(var_4), 24) + (0, 0, 3);
  var_6 = spawn("script_model", var_5);
  var_6 setModel("equipment_military_radio_old_06_destr");
  var_6.angles = (-90, 0, 0);
  var_1.script_noteworthy = "blackbox";
  level.current_blackbox = var_6;
  level.current_blackbox_corpse = var_1;
  level.current_blackbox playLoopSound("scn_cp_blackbox_beep_lp");

  if(getdvarint("show_blackbox") > 0) {
    var_6 hudoutlineenable("outline_nodepth_green");
  }

  thread recover_bb(level);
  thread scripts\cp\cp_objectives::run_objective("event_bb_recovery");
}

function bb_timer() {
  var_0 = level.current_blackbox_corpse.origin;
  wait 90;
  level notify("bb_timeout");
  playFX(level._effect["vfx_blima_explosion"], var_0);
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
  wait 0.15;
  level.current_blackbox_corpse delete();

  if(isDefined(level.current_blackbox)) {
    level.current_blackbox stoploopsound();
  }

  waitframe();

  if(isDefined(level.current_blackbox)) {
    level.current_blackbox delete();
  }

  earthquake(0.45, 3, var_0, 1024);
  radiusdamage(var_0 + (0, 0, 50), 1024, 500, 50);
}

function recover_bb(var_0) {
  var_0 makeusable();
  var_0 setHintString(&"CP_STRIKE/HINT_RECORDER");
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(96);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_none");
  thread bb_think();
}

function bb_think() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    scripts\cp\cp_objectives::lua_objective_complete("event_bb_recovery");
    level notify("bb_recovered");
    level.current_blackbox stoploopsound();
    var_0 playlocalsound("cp_generic_placement");
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_STRIKE/RECORDER_FOUND", "allies", 5);
    waitframe();
    self delete();
    return;
  }
}