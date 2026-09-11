/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58269.gsc
***********************************************/

function init() {
  if(!getdvarint("scr_br_plague_killstreak_enable", 0)) {
    return;
  }

  scripts\mp\killstreaks\killstreaks::registerkillstreak("plague_box", &ref_13e2d, undefined, &ref_13e10);
}

function ref_13e2d(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return 0;
    }
  }

  if(!istrue(var1)) {
    var2 = getcompleteweaponname("ks_gesture_generic_mp");
    var3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, var2);

    if(!istrue(var3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return 0;
    }
  }

  var4 = ref_1239e(var0);

  if(!istrue(var4)) {
    return var4;
  }

  ref_1239f();
  return 1;
}

function ref_13e10() {}

function ref_1239e(var0) {
  var1 = self;
  var2 = spawnStruct();
  var2.origin = var1.origin + (100, 0, 0);
  var2.angles = var1.angles;
  var3 = spawn("script_model", var2.origin);
  var3 setModel("lm_offhand_vm_stim_zmb_loot");
  var3.angles = var2.angles;
  var3 makeusable();
  var3 setCursorHint("HINT_NOICON");
  var3 setuseholdduration("duration_none");
  var3 sethintdisplayfov(120);
  var3 setusefov(120);
  var3 setuserange(80);
  var3 setusepriority(-1);
  var3 setHintString(&"MP/X1FIN_RENDEZVOUS");
  var3 sethinttag("tag_use");
  var3 setuseprioritymax();
  var4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var4, "current", var2.origin, "hud_icon_killstreak_plague_box");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var4, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var4);
  }

  return true;
}

function ref_1239f() {
  var0 = self;
  wait 5;
  iprintlnbold("PLAGUE BOX USED");
}