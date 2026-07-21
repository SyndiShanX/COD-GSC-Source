/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\script_items.gsc
***********************************************/

scriptitem_buildspawnflags(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(istrue(var_0))
    var_5 = var_5 | 1;

  if(istrue(var_1))
    var_5 = var_5 | 2;

  if(istrue(var_2))
    var_5 = var_5 | 4;

  if(istrue(var_3))
    var_5 = var_5 | 8;

  if(istrue(var_4))
    var_5 = var_5 | 16;

  return var_5;
}

scriptitem_testspawn(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = "script_item_example";
  var_9 = scriptitem_buildspawnflags(var_3, var_4, var_5, var_6, var_7);
  var_10 = "equipment_oxygen_tank_01";
  var_11 = (randomintrange(-200, 200), randomintrange(-200, 200), 1000);
  var_12 = var_0 + (2, 2, -1);

  if(!isDefined(var_2))
    var_2 = "hint string";

  var_13 = spawnscriptitem(var_8, var_0, var_1, var_9, var_10, var_2, var_11, var_12);
  return var_13;
}

scriptitem_playerwatchforanypickup() {
  self endon("death");

  for(;;)
    self waittill("pickup");
}

scriptitem_itemwatchfortrigger(var_0) {
  self endon("death");
  self waittill("trigger", var_1);
  earthquake(0.6, 0.5, level.player.origin, 300);
}