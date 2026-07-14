/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\script_items.gsc
***************************************/

#namespace script_items;

function scriptitem_buildspawnflags(suspendinair, usephysics, disableusable, var_53d50c439728c1ef, disabledelete) {
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

  if(istrue(var_53d50c439728c1ef)) {
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
  classname = "\x1a\xe2\xde\x93\xe5F\xa5\x1d\xc75\xcf" + "_\x95\x0f,[\xe0lV";
  spawnflags = scriptitem_buildspawnflags(suspendinair, usephysics, disableuse, disabletouch, disabledelete);
  model = "o\xd7\x1d\xe7\xe5\t\xb4(@\\!\xcd'E\x83\x82D\xc3M\xfb\x81\xe0\xa1U";
  impulse = (randomintrange(-200, 200), randomintrange(-200, 200), 1000);
  contact_pos = position + (2, 2, -1);

  if(!isDefined(hintstring)) {
    hintstring = "\xf1\xd8?\xc3\v\x93g\x8e\x85\x1bc";
  }

  script_item = spawnscriptitem(classname, position, angles, spawnflags, model, hintstring, impulse, contact_pos);
  return script_item;
}

function scriptitem_playerwatchforanypickup() {
  self endon("<dev string:x24>");

  for(;;) {
    self waittill("<dev string:x2d>");
    println("<dev string:x37>");
  }
}

function scriptitem_itemwatchfortrigger(message) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x91`\xb1\xe7T\x97>", player);
  println("<dev string:x58>" + message);
  earthquake(0.6, 0.5, level.player.origin, 300);
}