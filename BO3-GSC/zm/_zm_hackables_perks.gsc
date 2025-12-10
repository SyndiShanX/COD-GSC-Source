/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_hackables_perks.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equip_hacker;
#namespace zm_hackables_perks;

function hack_perks() {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  for(i = 0; i < vending_triggers.size; i++) {
    struct = spawnStruct();
    if(isDefined(vending_triggers[i].machine)) {
      machine[0] = vending_triggers[i].machine;
    } else {
      machine = getEntArray(vending_triggers[i].target, "targetname");
    }
    struct.origin = (machine[0].origin + (anglestoright(machine[0].angles) * 18)) + vectorscale((0, 0, 1), 48);
    struct.radius = 48;
    struct.height = 64;
    struct.script_float = 5;
    while(!isDefined(vending_triggers[i].cost)) {
      wait(0.05);
    }
    struct.script_int = int(vending_triggers[i].cost * -1);
    struct.perk = vending_triggers[i];
    if(isDefined(level._hack_perks_override)) {
      struct = struct[[level._hack_perks_override]]();
    }
    vending_triggers[i].hackable = struct;
    struct.no_bullet_trace = 1;
    zm_equip_hacker::register_pooled_hackable_struct(struct, &perk_hack, &perk_hack_qualifier);
  }
  level._solo_revive_machine_expire_func = &solo_revive_expire_func;
}

function solo_revive_expire_func() {
  if(isDefined(self.hackable)) {
    zm_equip_hacker::deregister_hackable_struct(self.hackable);
    self.hackable = undefined;
  }
}

function perk_hack_qualifier(player) {
  if(isDefined(player._retain_perks)) {
    return false;
  }
  if(isDefined(self.perk) && isDefined(self.perk.script_noteworthy)) {
    if(player hasperk(self.perk.script_noteworthy)) {
      return true;
    }
  }
  return false;
}

function perk_hack(hacker) {
  if(level flag::get("solo_game") && self.perk.script_noteworthy == "specialty_quickrevive") {
    hacker.lives--;
  }
  hacker notify(self.perk.script_noteworthy + "_stop");
  hacker playsoundtoplayer("evt_perk_throwup", hacker);
  if(isDefined(hacker.perk_hud)) {
    keys = getarraykeys(hacker.perk_hud);
    for(i = 0; i < hacker.perk_hud.size; i++) {
      hacker.perk_hud[keys[i]].x = i * 30;
    }
  }
}