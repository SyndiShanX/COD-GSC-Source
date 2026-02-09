/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_newworld_sound.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#namespace cp_mi_zurich_newworld_sound;

function main() {
  level thread function_9f9f219();
  level thread function_cfd80c1b();
  level thread function_166fca02();
  level thread function_694458bd();
}

function function_9f9f219() {
  trigger = getent(0, "security_det", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(who isPlayer()) {
      playSound(0, "amb_security_detector", (-10363, -24283, 9450));
      break;
    }
  }
}

function function_cfd80c1b() {
  trigger = getent(0, "horn", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(who isPlayer()) {
      playSound(0, "amb_train_horn_distant", (21054, -3421, -6031));
      break;
    }
  }
}

function function_166fca02() {
  trigger = getent(0, "train_horn_dist", "targetname");
  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", who);
    if(who isPlayer()) {
      playSound(0, "amb_train_horn_distant", (-13099, -18453, 10228));
      break;
    }
  }
}

function function_694458bd() {
  soundloopemitter("amb_wind_tarp", (-17754, 15606, 4288));
  soundloopemitter("amb_wind_door", (-12556, 15887, 4201));
  soundloopemitter("amb_wind_door", (-12164, 15338, 4207));
  soundloopemitter("anb_snow_plow", (-14268, 15963, 4248));
  soundloopemitter("anb_snow_plow", (-14281, 15331, 4235));
}

function function_98d2df25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setsoundcontext("train", "country");
  } else {
    if(newval == 2) {
      setsoundcontext("train", "city");
      return;
    } else {
      setsoundcontext("train", "tunnel");
      return;
    }
  }
}