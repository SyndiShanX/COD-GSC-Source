/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_pentagon_teleporter.csc
********************************************************/

#include clientscripts\_fx;
#include clientscripts\_utility;
#include clientscripts\_music;

main() {
  level thread wait_for_teleport_aftereffect();
  waitforallclients();
  level.portal_effect = level._effect["zombie_pentagon_teleporter"];
  level.pack_effect = level._effect["zombie_pent_portal_pack"];
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread teleporter_fx_setup(i);
    players[i] thread teleporter_fx_cool_down(i);
  }
}

teleporter_fx_setup(clientNum) {
  teleporters = getEntArray(clientNum, "pentagon_teleport_fx", "targetname");
  level.fxents[ClientNum] = [];
  level.packtime[ClientNum] = true;
  teleporter_pack = getEnt(clientNum, "pentagon_teleport_fx_pack", "targetname");
  teleporter_pack.fx_ent = spawn(clientNum, teleporter_pack.origin, "script_model");
  teleporter_pack.fx_ent setModel("tag_origin");
  teleporter_pack.fx_ent.angles = teleporter_pack.angles;
  teleporter_pack.portalfx = playFXOnTag(clientNum, level.portal_effect, teleporter_pack.fx_ent, "tag_origin");
  teleporter_pack playLoopSound("evt_teleporter_loop", 1.75);
  for(i = 0; i < teleporters.size; i++) {
    fx_ent = spawn(clientNum, teleporters[i].origin, "script_model");
    fx_ent setModel("tag_origin");
    fx_ent.angles = teleporters[i].angles;
    level.fxents[ClientNum] = array_add(level.fxents[ClientNum], fx_ent);
  }
}

teleporter_fx_init(clientNum, set, newEnt) {
  fx_array = level.fxents[ClientNum];
  if(set && level.packtime[ClientNum] == true) {
    println("*** Client : regular portal fx on. ", ClientNum);
    level.packtime[ClientNum] = false;
    for(i = 0; i < fx_array.size; i++) {
      if(isDefined(fx_array[i].portalfx)) {
        deletefx(clientNum, fx_array[i].portalfx);
      }
      wait(0.01);
      fx_array[i].portalfx = playFXOnTag(clientNum, level.portal_effect, fx_array[i], "tag_origin");
      playSound(clientNum, "evt_teleporter_start", fx_array[i].origin);
      fx_array[i] playLoopSound("evt_teleporter_loop", 1.75);
    }
  } else if(!set && level.packtime[ClientNum] == false) {
    level notify("end_cool_downs");
    println("*** Client : pack portal fx on. ", ClientNum);
    level.packtime[ClientNum] = true;
    for(i = 0; i < fx_array.size; i++) {
      if(isDefined(fx_array[i].portalfx)) {
        deletefx(clientNum, fx_array[i].portalfx);
      }
      wait(0.01);
      fx_array[i].portalfx = playFXOnTag(clientNum, level.pack_effect, fx_array[i], "tag_origin");
      fx_array[i] thread play_packa_special_looper(clientNum);
    }
  }
}

teleporter_fx_cool_down(clientNum) {
  while(true) {
    level waittill("cool_fx", ClientNum);
    players = getLocalPlayers();
    if(level.packtime[ClientNum] == false) {
      fx_pos = undefined;
      closest = 512;
      for(i = 0; i < level.fxents[ClientNum].size; i++) {
        if(isDefined(level.fxents[ClientNum][i])) {
          if(closest > Distance(level.fxents[ClientNum][i].origin, players[ClientNum].origin)) {
            closest = Distance(level.fxents[ClientNum][i].origin, players[ClientNum].origin);
            fx_pos = level.fxents[ClientNum][i];
          }
        }
      }
      if(isDefined(fx_pos) && isDefined(fx_pos.portalfx)) {
        deletefx(clientNum, fx_pos.portalfx);
        fx_pos.portalfx = playFXOnTag(clientNum, level._effect["zombie_pent_portal_cool"], fx_pos, "tag_origin");
        self thread turn_off_cool_down_fx(fx_pos, ClientNum);
      }
    }
    wait(0.1);
  }
}

turn_off_cool_down_fx(fx_pos, ClientNum) {
  fx_pos thread cool_down_timer();
  fx_pos waittill("cool_down_over");
  if(isDefined(fx_pos) && isDefined(fx_pos.portalfx)) {
    deletefx(clientNum, fx_pos.portalfx);
    if(level.packtime[ClientNum] == false) {
      fx_pos.portalfx = playFXOnTag(clientNum, level.portal_effect, fx_pos, "tag_origin");
    } else {
      fx_pos.portalfx = playFXOnTag(clientNum, level.pack_effect, fx_pos, "tag_origin");
    }
  }
}

cool_down_timer() {
  time = 0;
  self.defcon_active = false;
  self thread pack_cooldown_listener();
  while(!self.defcon_active && time < 20) {
    wait(1);
    time++;
  }
  self notify("cool_down_over");
}

pack_cooldown_listener() {
  self endon("cool_down_over");
  level waittill("end_cool_downs");
  self.defcon_active = true;
}

wait_for_teleport_aftereffect() {
  while(true) {
    level waittill("ae1", ClientNum);
    visionSetNaked(clientNum, "flare", 0.4);
  }
}

play_packa_special_looper(clientNum) {
  self playLoopSound("mus_packapunch_special", 1);
  level waittill("pack_portal_fx_off", ClientNum);
  self stopLoopSound(1);
}