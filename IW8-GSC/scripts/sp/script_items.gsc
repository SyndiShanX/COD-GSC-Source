/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\script_items.gsc
***********************************************/

function scriptitem_buildspawnflags(var0, var1, var2, var3, var4) {
  var5 = 0;

  if(istrue(var0)) {
    var5 |= 1;
  }

  if(istrue(var1)) {
    var5 |= 2;
  }

  if(istrue(var2)) {
    var5 |= 4;
  }

  if(istrue(var3)) {
    var5 |= 8;
  }

  if(istrue(var4)) {
    var5 |= 16;
  }

  return var5;
}

function scriptitem_testspawn(var0, var1, var2) {
  var3 = 0;
  var4 = 1;
  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = "script_item_example";
  var9 = scriptitem_buildspawnflags(var3, var4, var5, var6, var7);
  var10 = "equipment_oxygen_tank_01";
  var11 = (randomintrange(-200, 200), randomintrange(-200, 200), 1000);
  var12 = var0 + (2, 2, -1);

  if(!isDefined(var2)) {
    var2 = "hint string";
  }

  var13 = spawnscriptitem(var8, var0, var1, var9, var10, var2, var11, var12);
  return var13;
}

function scriptitem_playerwatchforanypickup() {
  self endon("death");

  for(;;) {
    self waittill("pickup");
  }
}

function scriptitem_itemwatchfortrigger(var0) {
  self endon("death");
  self waittill("trigger", var1);
  earthquake(0.6, 0.5, level.player.origin, 300);
}