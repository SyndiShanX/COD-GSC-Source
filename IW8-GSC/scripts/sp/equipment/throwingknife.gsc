/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\throwingknife.gsc
**************************************************/

function precache(var0) {
  setdvarifuninitialized("scr_highlight_throwingknife", 0);
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &throwingknifefiremain);
}

function throwingknifefiremain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var0.targetname = "offhand_throwingknife";
  jumpiffalse(getdvarint("scr_highlight_throwingknife") == 1) LOC_00000030;
  var0 scripts\engine\sp\utility::hudoutline_enable("outline_depth_cyan");
  var0 waittill("missile_stuck", var1);
  thread pickupfunc();
  var0 hide();
  var2 = spawn("script_model", var0.origin);
  var2 setModel(var0.model);
  var2 notsolid();
  var2 linkTo(var0, "tag_origin", (2, 0, 0), (0, 0, 0));
  var0 waittill("entitydeleted");
  var2 delete();
  wait 0.05;
  var0 notify("entitydeleted_delayed");
}

function pickupfunc() {
  self endon("entitydeleted_delayed");
  self waittill("trigger");
  scripts\sp\loot::lootfuncandnotification("Throwing Knife");
}