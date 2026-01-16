/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_claymore.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_claymore;

function autoexec __init__sytem__() {
  system::register("claymore", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["claymore_laser"] = "_t6/weapon/claymore/fx_claymore_laser";
  zm_placeable_mine::add_mine_type("claymore", & "ZOMBIE_CLAYMORE_PICKUP");
  zm_placeable_mine::add_planted_callback( & play_claymore_effects, "claymore");
  zm_placeable_mine::add_planted_callback( & claymore_detonation, "claymore");
}

function play_claymore_effects(e_planter) {
  self endon("death");
  self zm_utility::waittill_not_moving();
  playfxontag(level._effect["claymore_laser"], self, "tag_fx");
}

function claymore_detonation(e_planter) {
  self endon("death");
  self zm_utility::waittill_not_moving();
  detonateradius = 96;
  damagearea = spawn("trigger_radius", self.origin, 9, detonateradius, detonateradius * 2);
  damagearea setexcludeteamfortrigger(self.owner.team);
  damagearea enablelinkto();
  damagearea linkto(self);
  if(isdefined(self.isonbus) && self.isonbus) {
    damagearea setmovingplatformenabled(1);
  }
  self.damagearea = damagearea;
  self thread delete_mines_on_death(self.owner, damagearea);
  if(!isdefined(self.owner.placeable_mines)) {
    self.owner.placeable_mines = [];
  } else if(!isarray(self.owner.placeable_mines)) {
    self.owner.placeable_mines = array(self.owner.placeable_mines);
  }
  self.owner.placeable_mines[self.owner.placeable_mines.size] = self;
  while (true) {
    damagearea waittill("trigger", ent);
    if(isdefined(self.owner) && ent == self.owner) {
      continue;
    }
    if(isdefined(ent.pers) && isdefined(ent.pers["team"]) && ent.pers["team"] == self.team) {
      continue;
    }
    if(isdefined(ent.ignore_placeable_mine) && ent.ignore_placeable_mine) {
      continue;
    }
    if(!ent should_trigger_claymore(self)) {
      continue;
    }
    if(ent damageconetrace(self.origin, self) > 0) {
      self playsound("wpn_claymore_alert");
      wait(0.4);
      if(isdefined(self.owner)) {
        self detonate(self.owner);
      } else {
        self detonate(undefined);
      }
      return;
    }
  }
}

function private should_trigger_claymore(e_mine) {
  n_detonation_dot = cos(70);
  pos = self.origin + vectorscale((0, 0, 1), 32);
  dirtopos = pos - e_mine.origin;
  objectforward = anglestoforward(e_mine.angles);
  dist = vectordot(dirtopos, objectforward);
  if(dist < 20) {
    return 0;
  }
  dirtopos = vectornormalize(dirtopos);
  dot = vectordot(dirtopos, objectforward);
  return dot > n_detonation_dot;
}

function private delete_mines_on_death(player, ent) {
  self waittill("death");
  if(isdefined(player)) {
    arrayremovevalue(player.placeable_mines, self);
  }
  wait(0.05);
  if(isdefined(ent)) {
    ent delete();
  }
}