/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perks.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#namespace zm_perks;

function init() {
  callback::on_start_gametype( & init_perk_machines_fx);
  init_custom_perks();
  perks_register_clientfield();
  init_perk_custom_threads();
}

function perks_register_clientfield() {
  if(isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
    clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", & perk_meteor_fx, 0, 0);
  }
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for (i = 0; i < a_keys.size; i++) {
      if(isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
        level[[level._custom_perks[a_keys[i]].clientfield_register]]();
      }
    }
  }
  level thread perk_init_code_callbacks();
}

function perk_init_code_callbacks() {
  wait(0.1);
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for (i = 0; i < a_keys.size; i++) {
      if(isdefined(level._custom_perks[a_keys[i]].clientfield_code_callback)) {
        level[[level._custom_perks[a_keys[i]].clientfield_code_callback]]();
      }
    }
  }
}

function init_custom_perks() {
  if(!isdefined(level._custom_perks)) {
    level._custom_perks = [];
  }
}

function register_perk_clientfields(str_perk, func_clientfield_register, func_code_callback) {
  _register_undefined_perk(str_perk);
  if(!isdefined(level._custom_perks[str_perk].clientfield_register)) {
    level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
  }
  if(!isdefined(level._custom_perks[str_perk].clientfield_code_callback)) {
    level._custom_perks[str_perk].clientfield_code_callback = func_code_callback;
  }
}

function register_perk_effects(str_perk, str_light_effect) {
  _register_undefined_perk(str_perk);
  if(!isdefined(level._custom_perks[str_perk].machine_light_effect)) {
    level._custom_perks[str_perk].machine_light_effect = str_light_effect;
  }
}

function register_perk_init_thread(str_perk, func_init_thread) {
  _register_undefined_perk(str_perk);
  if(!isdefined(level._custom_perks[str_perk].init_thread)) {
    level._custom_perks[str_perk].init_thread = func_init_thread;
  }
}

function init_perk_custom_threads() {
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for (i = 0; i < a_keys.size; i++) {
      if(isdefined(level._custom_perks[a_keys[i]].init_thread)) {
        level thread[[level._custom_perks[a_keys[i]].init_thread]]();
      }
    }
  }
}

function _register_undefined_perk(str_perk) {
  if(!isdefined(level._custom_perks)) {
    level._custom_perks = [];
  }
  if(!isdefined(level._custom_perks[str_perk])) {
    level._custom_perks[str_perk] = spawnstruct();
  }
}

function perk_meteor_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.meteor_fx = playfxontag(localclientnum, level._effect["perk_meteor"], self, "tag_origin");
  } else if(isdefined(self.meteor_fx)) {
    stopfx(localclientnum, self.meteor_fx);
  }
}

function init_perk_machines_fx(localclientnum) {
  if(!level.enable_magic) {
    return;
  }
  wait(0.1);
  machines = struct::get_array("zm_perk_machine", "targetname");
  array::thread_all(machines, & perk_start_up);
}

function perk_start_up() {
  if(isdefined(self.script_int)) {
    power_zone = self.script_int;
    int = undefined;
    while (int != power_zone) {
      level waittill("power_on", int);
    }
  } else {
    level waittill("power_on");
  }
  timer = 0;
  duration = 0.1;
  while (true) {
    if(isdefined(level._custom_perks[self.script_noteworthy]) && isdefined(level._custom_perks[self.script_noteworthy].machine_light_effect)) {
      self thread vending_machine_flicker_light(level._custom_perks[self.script_noteworthy].machine_light_effect, duration);
    }
    timer = timer + duration;
    duration = duration + 0.2;
    if(timer >= 3) {
      break;
    }
    waitrealtime(duration);
  }
}

function vending_machine_flicker_light(fx_light, duration) {
  players = level.localplayers;
  for (i = 0; i < players.size; i++) {
    self thread play_perk_fx_on_client(i, fx_light, duration);
  }
}

function play_perk_fx_on_client(client_num, fx_light, duration) {
  fxobj = spawn(client_num, self.origin + (vectorscale((0, 0, -1), 50)), "script_model");
  fxobj setmodel("tag_origin");
  playfxontag(client_num, level._effect[fx_light], fxobj, "tag_origin");
  waitrealtime(duration);
  fxobj delete();
}