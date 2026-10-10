/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\script_items.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace script_items;

function scriptitem_buildspawnflags(suspendinair, usephysics, disableusable, var_f09e7de41dc186ea, disabledelete) {
  spawnflags = 0;

  if(istrue(suspendinair)) {
    spawnflags |= 1;
  }

  if(istrue(usephysics)) {
    spawnflags |= 2;
  }

  if(istrue(disableusable)) {
    spawnflags |= 4;
  }

  if(istrue(var_f09e7de41dc186ea)) {
    spawnflags |= 8;
  }

  if(istrue(disabledelete)) {
    spawnflags |= 16;
  }

  return spawnflags;
}

function scriptitem_testspawn(position, angles, hintstring) {
  suspendinair = 0;
  usephysics = 1;
  disableuse = 0;
  disabletouch = 0;
  disabledelete = 0;
  classname = "script_item" + "_example";
  spawnflags = scriptitem_buildspawnflags(suspendinair, usephysics, disableuse, disabletouch, disabledelete);
  model = "equipment_oxygen_tank_01";
  impulse = (randomintrange(-200, 200), randomintrange(-200, 200), 1000);
  contact_pos = position + (2, 2, -1);

  if(!isDefined(hintstring)) {
    hintstring = "hint string";
  }

  script_item = spawnscriptitem(classname, position, angles, spawnflags, model, hintstring, impulse, contact_pos);
  return script_item;
}

function scriptitem_playerwatchforanypickup() {
  self endon("<dev string:x1c>");

  for(;;) {
    self waittill("<dev string:x22>");
    println("<dev string:x29>");
  }
}

function scriptitem_itemwatchfortrigger(message) {
  self endon("death");
  self waittill("trigger", player);
  println("<dev string:x47>" + message);
  earthquake(0.6, 0.5, level.player.origin, 300);
}