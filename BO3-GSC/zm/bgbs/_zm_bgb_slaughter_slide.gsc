/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_slaughter_slide.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_slaughter_slide;

function autoexec __init__sytem__() {
  system::register("zm_bgb_slaughter_slide", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_slaughter_slide", "event", &event, undefined, undefined, undefined);
  bgb::register_actor_damage_override("zm_bgb_slaughter_slide", &actor_damage_override);
  bgb::register_vehicle_damage_override("zm_bgb_slaughter_slide", &vehicle_damage_override);
  level.var_77eb3698 = getweapon("frag_grenade_slaughter_slide");
}

function event() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  self.var_abd23dd0 = 6;
  while(self.var_abd23dd0 > 0) {
    var_2a23ce90 = self is_sliding(2);
    if(var_2a23ce90) {
      self thread function_42722ac4();
      while(self issliding()) {
        wait(0.2);
      }
    }
    wait(0.05);
  }
}

function is_sliding(n_count) {
  var_2a23ce90 = 0;
  for(x = 0; x < n_count; x++) {
    var_2a23ce90 = self issliding();
    wait(0.05);
  }
  return var_2a23ce90;
}

function function_42722ac4() {
  v_launch_offset = vectorscale((0, 0, 1), 48);
  v_facing = anglesToForward(self.angles);
  v_right = anglestoright(self.angles);
  self magicgrenadetype(level.var_77eb3698, self.origin + v_launch_offset, v_facing * 1000, 0.5);
  util::wait_network_frame();
  self magicgrenadetype(level.var_77eb3698, self.origin + v_launch_offset, (v_facing * -1) * 100, 0.05);
  self bgb::do_one_shot_use();
  self.var_abd23dd0--;
  self bgb::set_timer(self.var_abd23dd0, 6);
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(weapon === level.var_77eb3698) {
    if(isDefined(self.ignore_nuke) && self.ignore_nuke || (isDefined(self.marked_for_death) && self.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(self)) {
      return damage;
    }
    return self.health + 666;
  }
  return damage;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(weapon === level.var_77eb3698) {
    if(isDefined(self.ignore_nuke) && self.ignore_nuke || (isDefined(self.marked_for_death) && self.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(self)) {
      return idamage;
    }
    return self.health + 666;
  }
  return idamage;
}