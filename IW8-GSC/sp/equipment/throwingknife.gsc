/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\throwingknife.gsc
***********************************************/

precache(var_0) {
  setdvarifuninitialized("scr_highlight_throwingknife", 0);
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::throwingknifefiremain);
}

throwingknifefiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.targetname = "offhand_throwingknife";

  if(getdvarint("scr_highlight_throwingknife") == 1)
    var_0 scripts\engine\sp\utility::hudoutline_enable("outline_depth_cyan");

  var_0 waittill("missile_stuck", var_1);
  var_0 thread pickupfunc();
  var_0 hide();
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0.model);
  var_2 notsolid();
  var_2 linkTo(var_0, "tag_origin", (2, 0, 0), (0, 0, 0));
  var_0 waittill("entitydeleted");
  var_2 delete();
  wait 0.05;
  var_0 notify("entitydeleted_delayed");
}

pickupfunc() {
  self endon("entitydeleted_delayed");
  self waittill("trigger");
  scripts\sp\loot::lootfuncandnotification("Throwing Knife");
}