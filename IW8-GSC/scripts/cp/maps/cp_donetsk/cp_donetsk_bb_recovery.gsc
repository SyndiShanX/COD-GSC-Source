/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_bb_recovery.gsc
*****************************************************************/

function main(var0) {
  level.obj_bb_recovery = &register_objective;
}

function blank(var0) {}

function register_objective() {
  scripts\cp\cp_objectives::registerobjective("event_bb_recovery", &blank, &bb_recovery, &blank, &blank, &blank);
}

function bb_recovery(var0) {
  level endon("bb_recovered");
  objective_position(var0.objectiveindex, level.current_blackbox_corpse.origin + (0, 0, 100));
  thread bb_timer();
  level waittill("bb_timeout");
  level.current_blackbox = undefined;
  level.current_blackbox_corpse = undefined;
  scripts\cp\cp_objectives::lua_objective_incomplete("event_bb_recovery");
}

function start_bb_recovery(var0) {
  var1 = spawn("script_model", var0.origin + (0, 0, -136));
  var1.angles = var0.angles;
  var1 setModel("prop_veh8_mil_air_air_blima_dst");
  var0 delete();
  var1 setscriptablepartstate("impact", "on");
  var1 setscriptablepartstate("stage3", "on");
  var2 = randomint(360);
  var3 = randomintrange(150, 500);
  var4 = var1.origin + anglesToForward((0, var2, 0)) * var3;
  var5 = getgroundposition(getclosestpointonnavmesh(var4), 24) + (0, 0, 3);
  var6 = spawn("script_model", var5);
  var6 setModel("equipment_military_radio_old_06_destr");
  var6.angles = (-90, 0, 0);
  var1.script_noteworthy = "blackbox";
  level.current_blackbox = var6;
  level.current_blackbox_corpse = var1;
  level.current_blackbox playLoopSound("scn_cp_blackbox_beep_lp");

  if(getdvarint("show_blackbox") > 0) {
    var6 hudoutlineenable("outline_nodepth_green");
  }

  thread recover_bb(level);
  thread scripts\cp\cp_objectives::run_objective("event_bb_recovery");
}

function bb_timer() {
  var0 = level.current_blackbox_corpse.origin;
  wait 90;
  level notify("bb_timeout");
  playFX(level._effect["vfx_blima_explosion"], var0);
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
  wait 0.15;
  level.current_blackbox_corpse delete();

  if(isDefined(level.current_blackbox)) {
    level.current_blackbox stoploopsound();
  }

  waitframe();

  if(isDefined(level.current_blackbox)) {
    level.current_blackbox delete();
  }

  earthquake(0.45, 3, var0, 1024);
  radiusdamage(var0 + (0, 0, 50), 1024, 500, 50);
}

function recover_bb(var0) {
  var0 makeusable();
  var0 setHintString(&"CP_STRIKE/HINT_RECORDER");
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(96);
  var0 sethintdisplayfov(65);
  var0 setuserange(72);
  var0 setusefov(65);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_none");
  thread bb_think();
}

function bb_think() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    scripts\cp\cp_objectives::lua_objective_complete("event_bb_recovery");
    level notify("bb_recovered");
    level.current_blackbox stoploopsound();
    var0 playlocalsound("cp_generic_placement");
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_STRIKE/RECORDER_FOUND", "allies", 5);
    waitframe();
    self delete();
    return;
  }
}