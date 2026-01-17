/*********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_roulette.gsc
*********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\_ability_gadgets;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace roulette;

function autoexec __init__sytem__() {
  system::register("gadget_roulette", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "roulette_state", 11000, 2, "int");
  ability_player::register_gadget_activation_callbacks(43, &gadget_roulette_on_activate, &gadget_roulette_on_deactivate);
  ability_player::register_gadget_possession_callbacks(43, &gadget_roulette_on_give, &gadget_roulette_on_take);
  ability_player::register_gadget_flicker_callbacks(43, &gadget_roulette_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(43, &gadget_roulette_is_inuse);
  ability_player::register_gadget_ready_callbacks(43, &gadget_roulette_is_ready);
  ability_player::register_gadget_is_flickering_callbacks(43, &gadget_roulette_is_flickering);
  ability_player::register_gadget_should_notify(43, 0);
  callback::on_connect(&gadget_roulette_on_connect);
  callback::on_spawned(&gadget_roulette_on_player_spawn);
  if(sessionmodeismultiplayergame()) {
    level.gadgetrouletteprobabilities = [];
    level.gadgetrouletteprobabilities[0] = 0;
    level.gadgetrouletteprobabilities[1] = 0;
    level.weaponnone = getweapon("none");
    level.gadget_roulette = getweapon("gadget_roulette");
    registergadgettype("gadget_flashback", 1, 1);
    registergadgettype("gadget_combat_efficiency", 1, 1);
    registergadgettype("gadget_heat_wave", 1, 1);
    registergadgettype("gadget_vision_pulse", 1, 1);
    registergadgettype("gadget_speed_burst", 1, 1);
    registergadgettype("gadget_camo", 1, 1);
    registergadgettype("gadget_armor", 1, 1);
    registergadgettype("gadget_resurrect", 1, 1);
    registergadgettype("gadget_clone", 1, 1);
  }
}

function updatedvars() {
  while(true) {
    wait(1);
  }
}

function gadget_roulette_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_roulette_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_roulette_on_flicker(slot, weapon) {
  self thread gadget_roulette_flicker(slot, weapon);
}

function gadget_roulette_on_give(slot, weapon) {
  self clientfield::set_to_player("roulette_state", 0);
  if(sessionmodeismultiplayergame()) {
    self.isroulette = 1;
  }
}

function gadget_roulette_on_take(slot, weapon) {
  if(level.devgui_giving_abilities === 1) {
    self.isroulette = 0;
  }
}

function gadget_roulette_on_connect() {
  roulette_init_allow_spin();
}

function roulette_init_allow_spin() {
  if(self.isroulette === 1) {
    if(!isDefined(self.pers[# "hash_9f129a92"])) {
      self.pers[# "hash_9f129a92"] = 1;
    }
  }
}

function gadget_roulette_on_player_spawn() {
  roulette_init_allow_spin();
}

function watch_entity_shutdown() {}

function gadget_roulette_on_activate(slot, weapon) {
  gadget_roulette_give_earned_specialist(weapon, 1);
}

function gadget_roulette_is_ready(slot, weapon) {
  if(self gadgetisactive(slot)) {
    return;
  }
  gadget_roulette_give_earned_specialist(weapon, 0);
}

function gadget_roulette_give_earned_specialist(weapon, playsound) {
  self giverandomweapon(weapon, 1);
  if(playsound) {
    self playsoundtoplayer("mpl_bm_specialist_roulette", self);
  }
  self thread watchgadgetactivated(weapon);
  self thread watchrespin(weapon);
}

function disable_hero_gadget_activation(duration) {
  self endon("death");
  self endon("disconnect");
  self endon("roulette_respin_activate");
  self disableoffhandspecial();
  wait(duration);
  self enableoffhandspecial();
}

function watchrespingadgetactivated() {
  self endon("watchrespingadgetactivated");
  self endon("death");
  self endon("disconnect");
  self waittill("hero_gadget_activated");
  self clientfield::set_to_player("roulette_state", 0);
}

function watchrespin(weapon) {
  self endon("hero_gadget_activated");
  self notify("watchrespin");
  self endon("watchrespin");
  if(!isDefined(self.pers[# "hash_9f129a92"]) || self.pers[# "hash_9f129a92"] == 0) {
    return;
  }
  self thread watchrespingadgetactivated();
  self clientfield::set_to_player("roulette_state", 1);
  wait(getdvarfloat("scr_roulette_pre_respin_wait_time", 1.3));
  while(true) {
    if(!isDefined(self)) {
      break;
    }
    if(self dpad_left_pressed()) {
      self.pers[# "hash_65987563"] = undefined;
      self giverandomweapon(weapon, 0);
      self.pers[# "hash_9f129a92"] = 0;
      self notify("watchrespingadgetactivated");
      self notify("roulette_respin_activate");
      self clientfield::set_to_player("roulette_state", 2);
      self playsoundtoplayer("mpl_bm_specialist_roulette", self);
      self thread reset_roulette_state_to_default();
      break;
    }
    wait(0.05);
  }
  if(isDefined(self)) {
    self notify("watchrespingadgetactivated");
  }
}

function failsafe_reenable_offhand_special() {
  self endon("end_failsafe_reenable_offhand_special");
  wait(3);
  if(isDefined(self)) {
    self enableoffhandspecial();
  }
}

function reset_roulette_state_to_default() {
  self endon("death");
  self endon("disconnect");
  wait(0.5);
  self clientfield::set_to_player("roulette_state", 0);
}

function watchgadgetactivated(weapon) {
  self endon("death");
  self notify("watchgadgetactivated");
  self endon("watchgadgetactivated");
  self waittill("hero_gadget_activated");
  self.pers[# "hash_9f129a92"] = 1;
  if(isDefined(weapon) || weapon.name != "gadget_roulette") {
    self clientfield::set_to_player("roulette_state", 0);
  }
}

function giverandomweapon(weapon, isprimaryroll) {
  for(i = 0; i < 3; i++) {
    if(isDefined(self._gadgets_player[i])) {
      self takeweapon(self._gadgets_player[i]);
    }
  }
  randomweapon = weapon;
  if(isDefined(self.pers[# "hash_65987563"])) {
    randomweapon = self.pers[# "hash_65987563"];
  } else {
    if(isDefined(self.pers[# "hash_cbcfa831"]) || isDefined(self.pers[# "hash_cbcfa832"])) {
      randomweapon = getrandomgadget(isprimaryroll);
      while(randomweapon == self.pers[# "hash_cbcfa831"] || (isDefined(self.pers[# "hash_cbcfa832"]) && randomweapon == self.pers[# "hash_cbcfa832"])) {
        randomweapon = getrandomgadget(isprimaryroll);
      }
    } else {
      randomweapon = getrandomgadget(isprimaryroll);
    }
  }
  if(isDefined(level.playgadgetready) && !isprimaryroll) {
    self thread[[level.playgadgetready]](randomweapon, !isprimaryroll);
  }
  self thread gadget_roulette_on_deactivate_helper(weapon);
  self giveweapon(randomweapon);
  self.pers[# "hash_65987563"] = randomweapon;
  self.pers[# "hash_cbcfa832"] = self.pers[# "hash_cbcfa831"];
  self.pers[# "hash_cbcfa831"] = randomweapon;
}

function gadget_roulette_on_deactivate(slot, weapon) {
  thread gadget_roulette_on_deactivate_helper(weapon);
}

function gadget_roulette_on_deactivate_helper(weapon) {
  self notify("gadget_roulette_on_deactivate_helper");
  self endon("gadget_roulette_on_deactivate_helper");
  self waittill("heroability_off", weapon_off);
  if(isDefined(weapon_off) && weapon_off.name == "gadget_speed_burst") {
    self waittill("heroability_off", weapon_off);
  }
  for(i = 0; i < 3; i++) {
    if(isDefined(self) && isDefined(self._gadgets_player[i])) {
      self takeweapon(self._gadgets_player[i]);
    }
  }
  if(isDefined(self)) {
    self giveweapon(level.gadget_roulette);
    self.pers[# "hash_65987563"] = undefined;
  }
}

function gadget_roulette_flicker(slot, weapon) {}

function set_gadget_status(status, time) {
  timestr = "";
  if(isDefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(("Gadget Roulette: " + status) + timestr);
  }
}

function dpad_left_pressed() {
  return self actionslotthreebuttonpressed();
}

function getrandomgadget(isprimaryroll) {
  if(isprimaryroll) {
    category = 0;
    totalcategory = 0;
  } else {
    category = 1;
    totalcategory = 1;
  }
  randomgadgetnumber = randomintrange(1, level.gadgetrouletteprobabilities[totalcategory] + 1);
  gadgetnames = getarraykeys(level.gadgetrouletteprobabilities);
  selectedgadget = "";
  foreach(gadget in gadgetnames) {
    randomgadgetnumber = randomgadgetnumber - level.gadgetrouletteprobabilities[gadget][category];
    if(randomgadgetnumber <= 0) {
      selectedgadget = gadget;
      break;
    }
  }
  return selectedgadget;
}

function registergadgettype(gadgetnamestring, primaryweight, secondaryweight) {
  gadgetweapon = getweapon(gadgetnamestring);
  assert(isDefined(gadgetweapon));
  if(gadgetweapon == level.weaponnone) {
    assertmsg(gadgetnamestring + "");
  }
  if(!isDefined(level.gadgetrouletteprobabilities[gadgetweapon])) {
    level.gadgetrouletteprobabilities[gadgetweapon] = [];
  }
  level.gadgetrouletteprobabilities[gadgetweapon][0] = primaryweight;
  level.gadgetrouletteprobabilities[gadgetweapon][1] = secondaryweight;
  level.gadgetrouletteprobabilities[0] = level.gadgetrouletteprobabilities[0] + primaryweight;
  level.gadgetrouletteprobabilities[1] = level.gadgetrouletteprobabilities[1] + secondaryweight;
}