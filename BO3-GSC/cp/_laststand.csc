/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_laststand.csc
*************************************************/

#using scripts\cp\_load;
#using scripts\cp\_util;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace _laststand;

function autoexec init() {
  level.laststands = [];
  for(i = 0; i < 4; i++) {
    level.laststands[i] = spawnStruct();
    level.laststands[i].bleedouttime = 0;
    level.laststands[i].laststand_update_clientfields = "laststand_update" + i;
    level.laststands[i].lastbleedouttime = 0;
    clientfield::register("world", level.laststands[i].laststand_update_clientfields, 1, 5, "counter", & update_bleedout_timer, 0, 0);
  }
  level thread wait_and_set_revive_shader_constant();
}

function wait_and_set_revive_shader_constant() {
  while(true) {
    level waittill("notetrack", localclientnum, note);
    if(note == "revive_shader_constant") {
      player = getlocalplayer(localclientnum);
      player mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(localclientnum) / 1000);
    }
  }
}

function animation_update(model, oldvalue, newvalue) {
  self endon("new_val");
  starttime = getrealtime();
  timesincelastupdate = 0;
  if(oldvalue == newvalue) {
    newvalue = oldvalue - 1;
  }
  while(timesincelastupdate <= 1) {
    timesincelastupdate = (getrealtime() - starttime) / 1000;
    lerpvalue = lerpfloat(oldvalue, newvalue, timesincelastupdate) / 30;
    setuimodelvalue(model, lerpvalue);
    wait(0.016);
  }
}

function update_bleedout_timer(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  substr = getsubstr(fieldname, 16);
  playernum = int(substr);
  level.laststands[playernum].lastbleedouttime = level.laststands[playernum].bleedouttime;
  level.laststands[playernum].bleedouttime = newval - 1;
  if(level.laststands[playernum].lastbleedouttime < level.laststands[playernum].bleedouttime) {
    level.laststands[playernum].lastbleedouttime = level.laststands[playernum].bleedouttime;
  }
  model = getuimodel(getuimodelforcontroller(localclientnum), ("WorldSpaceIndicators.bleedOutModel" + playernum) + ".bleedOutPercent");
  if(isDefined(model)) {
    if(newval == 30) {
      level.laststands[playernum].bleedouttime = 0;
      level.laststands[playernum].lastbleedouttime = 0;
      setuimodelvalue(model, 1);
    } else {
      if(newval == 29) {
        level.laststands[playernum] notify("new_val");
        level.laststands[playernum] thread animation_update(model, 30, 28);
      } else {
        level.laststands[playernum] notify("new_val");
        level.laststands[playernum] thread animation_update(model, level.laststands[playernum].lastbleedouttime, level.laststands[playernum].bleedouttime);
      }
    }
  }
}