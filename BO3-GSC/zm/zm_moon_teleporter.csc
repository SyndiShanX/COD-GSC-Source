/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_teleporter.csc
*************************************************/

#using scripts\shared\util_shared;
#namespace zm_moon_teleporter;

function main() {
  level thread wait_for_teleport_aftereffect();
  util::waitforallclients();
  level.portal_effect = level._effect["zombie_pentagon_teleporter"];
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    players[i] thread teleporter_fx_setup(i);
    players[i] thread teleporter_fx_cool_down(i);
  }
}

function teleporter_fx_setup(clientnum) {
  teleporters = getentarray(clientnum, "pentagon_teleport_fx", "targetname");
  level.fxents[clientnum] = [];
  level.packtime[clientnum] = 1;
  for (i = 0; i < teleporters.size; i++) {
    fx_ent = spawn(clientnum, teleporters[i].origin, "script_model");
    fx_ent setmodel("tag_origin");
    fx_ent.angles = teleporters[i].angles;
    if(!isdefined(level.fxents[clientnum])) {
      level.fxents[clientnum] = [];
    } else if(!isarray(level.fxents[clientnum])) {
      level.fxents[clientnum] = array(level.fxents[clientnum]);
    }
    level.fxents[clientnum][level.fxents[clientnum].size] = fx_ent;
  }
}

function teleporter_fx_init(clientnum, set, newent) {
  fx_array = level.fxents[clientnum];
  if(set && level.packtime[clientnum] == 1) {
    println("", clientnum);
    level.packtime[clientnum] = 0;
    for (i = 0; i < fx_array.size; i++) {
      if(isdefined(fx_array[i].portalfx)) {
        deletefx(clientnum, fx_array[i].portalfx);
      }
      wait(0.01);
      fx_array[i].portalfx = playfxontag(clientnum, level.portal_effect, fx_array[i], "tag_origin");
      playsound(clientnum, "evt_teleporter_start", fx_array[i].origin);
      fx_array[i] playloopsound("evt_teleporter_loop", 1.75);
    }
  }
}

function teleporter_fx_cool_down(clientnum) {
  while (true) {
    level waittill("cool_fx", clientnum);
    players = getlocalplayers();
    if(level.packtime[clientnum] == 0) {
      fx_pos = undefined;
      closest = 512;
      for (i = 0; i < level.fxents[clientnum].size; i++) {
        if(isdefined(level.fxents[clientnum][i])) {
          if(closest > distance(level.fxents[clientnum][i].origin, players[clientnum].origin)) {
            closest = distance(level.fxents[clientnum][i].origin, players[clientnum].origin);
            fx_pos = level.fxents[clientnum][i];
          }
        }
      }
      if(isdefined(fx_pos) && isdefined(fx_pos.portalfx)) {
        deletefx(clientnum, fx_pos.portalfx);
        fx_pos.portalfx = playfxontag(clientnum, level._effect["zombie_pent_portal_cool"], fx_pos, "tag_origin");
        self thread turn_off_cool_down_fx(fx_pos, clientnum);
      }
    }
    wait(0.1);
  }
}

function turn_off_cool_down_fx(fx_pos, clientnum) {
  fx_pos thread cool_down_timer();
  fx_pos waittill("cool_down_over");
  if(isdefined(fx_pos) && isdefined(fx_pos.portalfx)) {
    deletefx(clientnum, fx_pos.portalfx);
    if(level.packtime[clientnum] == 0) {
      fx_pos.portalfx = playfxontag(clientnum, level.portal_effect, fx_pos, "tag_origin");
    }
  }
}

function cool_down_timer() {
  time = 0;
  self.defcon_active = 0;
  self thread pack_cooldown_listener();
  while (!self.defcon_active && time < 20) {
    wait(1);
    time++;
  }
  self notify("cool_down_over");
}

function pack_cooldown_listener() {
  self endon("cool_down_over");
  level waittill("end_cool_downs");
  self.defcon_active = 1;
}

function wait_for_teleport_aftereffect() {
  while (true) {
    level waittill("ae1", clientnum);
    visionsetnaked(clientnum, "flare", 0.4);
  }
}