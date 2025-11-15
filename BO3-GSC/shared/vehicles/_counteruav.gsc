/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_counteruav.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace counteruav;

function autoexec __init__sytem__() {
  system::register("counteruav", & __init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("counteruav", & counteruav_initialize);
}

function counteruav_initialize() {
  self useanimtree($generic);
  target_set(self, (0, 0, 0));
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self setvehicleavoidance(1);
  self sethoverparams(50, 100, 100);
  self.vehaircraftcollisionenabled = 1;
  assert(isDefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.goalradius = 999999;
  self.goalheight = 999999;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.overridevehicledamage = & drone_callback_damage;
  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }
}

function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  return idamage;
}