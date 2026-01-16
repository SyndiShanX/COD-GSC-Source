/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_firefly.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_firefly;

function init() {
  init_clientfields();
  level._effect["swarm_attack"] = "weapon/fx_ability_firefly_attack";
  level._effect["swarm_attack_dmg"] = "weapon/fx_ability_firefly_attack_damage";
  level._effect["swarm_hunt"] = "weapon/fx_ability_firefly_hunting";
  level._effect["swarm_hunt_trans_to_move"] = "weapon/fx_ability_firefly_travel";
  level._effect["swarm_die"] = "weapon/fx_ability_firefly_swarm_die";
  level._effect["swarm_move"] = "weapon/fx_ability_firefly_travel";
  level._effect["upgraded_swarm_attack"] = "weapon/fx_ability_firebug_attack";
  level._effect["upgraded_swarm_attack_dmg"] = "weapon/fx_ability_firebug_attack_damage";
  level._effect["upgraded_swarm_hunt"] = "weapon/fx_ability_firebug_hunting";
  level._effect["upgraded_swarm_hunt_trans_to_move"] = "weapon/fx_ability_firebug_travel";
  level._effect["upgraded_swarm_die"] = "weapon/fx_ability_firebug_swarm_die";
  level._effect["upgraded_swarm_move"] = "weapon/fx_ability_firebug_travel";
}

function init_clientfields() {
  clientfield::register("vehicle", "firefly_state", 1, 4, "int", & firefly_state, 0, 0);
  clientfield::register("actor", "firefly_state", 1, 4, "int", & actor_firefly_state, 0, 0);
}

function firefly_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0 || newval == oldval) {
    return;
  }
  if(isdefined(self.fx)) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
  switch (newval) {
    case 1: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_hunt"], self, "tag_origin");
      break;
    }
    case 2: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_hunt_trans_to_move"], self, "tag_origin");
      break;
    }
    case 3: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_move"], self, "tag_origin");
      break;
    }
    case 5: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_die"], self, "tag_origin");
      self playsound(0, "gdt_firefly_die");
      break;
    }
    case 6: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_hunt"], self, "tag_origin");
      break;
    }
    case 7: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_hunt_trans_to_move"], self, "tag_origin");
      break;
    }
    case 8: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_move"], self, "tag_origin");
      break;
    }
    case 10: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_die"], self, "tag_origin");
      self playsound(0, "gdt_firefly_die");
      break;
    }
  }
  if(sessionmodeiscampaignzombiesgame()) {
    if(isdefined(self.fx)) {
      setfxignorepause(localclientnum, self.fx, 1);
    }
  }
  self.currentstate = newval;
}

function actor_firefly_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0 || newval == oldval) {
    return;
  }
  if(isdefined(self.fx)) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
  switch (newval) {
    case 4: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_attack_dmg"], self, "j_neck");
      self.snd = self playloopsound("gdt_firefly_attack_lp", 0.5);
      break;
    }
    case 9: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_attack_dmg"], self, "j_neck");
      self.snd = self playloopsound("gdt_firefly_attack_fire_lp", 0.5);
      break;
    }
    case 5: {
      self.fx = playfxontag(localclientnum, level._effect["swarm_die"], self, "j_neck");
      self playsound(0, "gdt_firefly_die");
      if(isdefined(self.snd)) {
        self stoploopsound(self.snd);
      }
      break;
    }
    case 10: {
      self.fx = playfxontag(localclientnum, level._effect["upgraded_swarm_die"], self, "j_neck");
      self playsound(0, "gdt_firefly_die");
      if(isdefined(self.snd)) {
        self stoploopsound(self.snd);
      }
      break;
    }
    default: {
      break;
    }
  }
  if(sessionmodeiscampaignzombiesgame()) {
    if(isdefined(self.fx)) {
      setfxignorepause(localclientnum, self.fx, 1);
    }
  }
  self.currentstate = newval;
}