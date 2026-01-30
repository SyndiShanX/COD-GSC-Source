/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_explosive_drone.gsc
***************************************************************/

init() {
  level._effect["zed_explode"] = loadfx("vfx/explosion/explosive_drone_explosion");
  level._effect["zed_beacon"] = loadfx("vfx/test/zombie_explosive_drone_beacon");
  level.zed_active = [];
  maps\mp\zombies\weapons\_zombie_weapons::addplaceableminetype("explosive_drone_zombie_mp");
  maps\mp\zombies\weapons\_zombie_weapons::addplaceableminetype("explosive_drone_throw_zombie_mp");
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "explosive_drone_zombie_mp" || var_2 == "explosive_drone_throw_zombie_mp") {
      var_0.team = self.team;
      var_0.activated = 0;

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.weaponname)) {
        var_0.weaponname = var_1;
      }

      level.zed_active[level.zed_active.size] = var_0;
      var_0 thread watchowner();
      var_0 thread watchforstick();
    }
  }
}

watchowner() {
  self endon("death");
  self.owner waittill("disconnect");
  self delete();
}

watchforstick() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", var_0);

  if(isDefined(var_0)) {
    self linkto(var_0);
  }

  self.explosive = spawn("script_model", self.origin);
  self.explosive setModel("npc_drone_explosive_main");
  self.explosive linkto(self, "tag_spike", (0, 0, 0), (0, 0, 0));
  level.zed_active = common_scripts\utility::array_removeundefined(level.zed_active);

  if(level.zed_active.size > 8) {
    level.zed_active[0] activategrenade();
  }

  waitframe();
  thread beaconfx();
  thread triggerthink();
  thread pickupthink();

  if(isDefined(var_0) && maps\mp\zombies\_util::is_true(var_0.activateexplosivedrone)) {
    activategrenade();
  }
}

beaconfx() {
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zed_beacon"), self.explosive, "TAG_BEACON");
}

triggerthink() {
  self endon("death");
  var_0 = 80;
  var_1 = spawn("trigger_radius", self.origin - (0, 0, var_0), 0, var_0, 2 * var_0);
  var_1 thread maps\mp\zombies\_util::delete_on_death_of(self);
  var_1 enablelinkto();
  var_1 linkto(self);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(var_2.team == self.team) {
      continue;
    }
    var_3 = anglestoup(self.angles);

    if(var_2 damageconetrace(self.origin + var_3 * 10) == 0) {
      continue;
    }
    thread activategrenade();
    break;
  }
}

activategrenade() {
  if(self.activated) {
    return;
  }
  self.activated = 1;
  var_0 = self.explosive;
  self playsoundonmovingent("wpn_explosive_drone_open");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("zed_beacon"), var_0, "TAG_BEACON");
  droneanimate();
  var_1 = var_0.origin + (0, 0, 5);
  var_0 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::getfx("zed_explode"), var_0, "tag_origin");
  var_0 playsoundonmovingent("wpn_explosive_drone_exp");
  self radiusdamage(var_1, 200, 200, 50, self.owner, "MOD_EXPLOSIVE", "explosive_drone_zombie_mp");
  self delete();
  wait 1;
  var_0 delete();
}

droneanimate() {
  self.explosive endon("death");
  var_0 = 0.7;
  var_1 = anglestoup(self.angles);
  self.explosive unlink();
  self.explosive moveto(self.origin + var_1 * 30, var_0, 0, var_0);
  wait(var_0);
}

pickupthink() {
  self endon("death");
  var_0 = spawn("script_model", self.origin);
  var_0.owner = self.owner;
  var_0 makeusable();
  var_0 sethintstring(&"ZOMBIES_PICKUP_EXPLOSIVE_DRONE");
  var_0 sethintstringvisibleonlytoowner(1);
  var_0 thread maps\mp\zombies\_util::delete_on_death_of(self);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 != self.owner) {
      continue;
    }
    if(var_1 maps\mp\zombies\_terminals::hasexosuit()) {
      var_1 setweaponammostock("explosive_drone_zombie_mp", var_1 getweaponammostock("explosive_drone_zombie_mp") + 1);
    } else {
      var_1 setweaponammostock("explosive_drone_throw_zombie_mp", var_1 getweaponammostock("explosive_drone_throw_zombie_mp") + 1);
    }

    if(isDefined(self.explosive)) {
      self.explosive delete();
    }

    self delete();
  }
}