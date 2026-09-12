/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58269.gsc
***********************************************/

function init() {
  if(!getdvarint("scr_br_plague_killstreak_enable", 0)) {
    return;
  }

  scripts\mp\killstreaks\killstreaks::registerkillstreak("plague_box", &ref_13e2d, undefined, &ref_13e10);
}

function ref_13e2d(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  if(!istrue(var_1)) {
    var_2 = getcompleteweaponname("ks_gesture_generic_mp");
    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_2);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return 0;
    }
  }

  var_4 = ref_1239e(var_0);

  if(!istrue(var_4)) {
    return var_4;
  }

  ref_1239f();
  return 1;
}

function ref_13e10() {}

function ref_1239e(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (100, 0, 0);
  var_2.angles = var_1.angles;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("lm_offhand_vm_stim_zmb_loot");
  var_3.angles = var_2.angles;
  var_3 makeusable();
  var_3 setCursorHint("HINT_NOICON");
  var_3 setuseholdduration("duration_none");
  var_3 sethintdisplayfov(120);
  var_3 setusefov(120);
  var_3 setuserange(80);
  var_3 setusepriority(-1);
  var_3 setHintString(&"MP/X1FIN_RENDEZVOUS");
  var_3 sethinttag("tag_use");
  var_3 setuseprioritymax();
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "current", var_2.origin, "hud_icon_killstreak_plague_box");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_4);
  }

  return true;
}

function ref_1239f() {
  var_0 = self;
  wait 5;
  iprintlnbold("PLAGUE BOX USED");
}