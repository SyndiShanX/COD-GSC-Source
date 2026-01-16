/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spiderhole.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;

spiderhole() {
  self endon("death");
  assertex(isDefined(level.scr_anim["spiderhole"]["sprint"][0]), "Missing spiderhole sprint animations (array).");
  assertex(isDefined(level.scr_anim["spiderhole"]["spiderhole_idle_crouch"][0]), "Missing spiderhole spiderhole_idle_crouch animations (array).");
  assertex(isDefined(level.scr_anim["spiderhole"]["jump_out"]), "Missing spiderhole jump_out animation.");
  assertex(isDefined(level.scr_anim["spiderhole"]["stumble_out"]), "Missing spiderhole stumble_out animation.");
  assertex(isDefined(level.scr_anim["spiderhole"]["grenade_toss"]), "Missing spiderhole grenade_toss animation.");
  assertex(isDefined(level.scr_anim["spiderhole"]["gun_spray"]), "Missing spiderhole gun_spray animation.");
  assertex(isDefined(level.scr_anim["spiderhole"]["crouch2stand"]), "Missing spiderhole crouch2stand animation.");
  assertex(isDefined(level.scr_anim["spiderhole"]["jump_attack"]), "Missing spiderhole jump_attack animation.");
  self waittill("finished spawning");
  wait_network_frame();
  self.ignoreme = true;
  self.pacifist = true;
  self.old_animname = self.animname;
  self.animname = "spiderhole";
  spider_lid = undefined;
  target_node = undefined;
  ASSERTex(isDefined(self.target), " Spiderhole Spawner @ " + self.origin + " does NOT target anything!");
  ents = getentarray(self.target, "targetname");
  anim_org = GetStruct(self.target, "targetname");
  for (i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_noteworthy) && ents[i].script_noteworthy == "spiderhole_lid") {
      assertex(isDefined(level.scr_animtree["spiderhole_lid"]), "Missing spiderhole lid animtree.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["jump_out"]), "Missing spiderhole lid jump_out animation.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["stumble_out"]), "Missing spiderhole lid stumble_out animation.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["grenade_toss"]), "Missing spiderhole lid grenade_toss animation.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["gun_spray"]), "Missing spiderhole lid gun_spray animation.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["crouch2stand"]), "Missing spiderhole_lid crouch2stand animation.");
      assertex(isDefined(level.scr_anim["spiderhole_lid"]["jump_attack"]), "Missing spiderhole lid jump_attack animation.");
      spider_lid = ents[i];
    }
  }
  ASSERTex(isDefined(anim_org), " SpiderHole Spawner @ " + self.origin + " does NOT target a script_struct!");
  anim_org thread anim_loop_solo(self, "spiderhole_idle_crouch", undefined, "open_lid");
  if(isDefined(spider_lid) && isDefined(spider_lid.radius)) {
    emerge_trig = spawn("trigger_radius", self.origin, 0, spider_lid.radius, spider_lid.radius);
    emerge_trig waittill("trigger");
    emerge_trig delete();
  }
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(RandomFloatRange(self.script_delay_min, self.script_delay_max));
  }
  while (1) {
    closest_player = get_closest_player(self.origin);
    if(distancesquared(closest_player.origin, self.origin) > 96 * 96) {
      break;
    }
    wait(0.05);
  }
  nodes = getnodearray(self.target, "targetname");
  if(nodes.size > 0) {
    target_node = nodes[RandomInt(nodes.size)];
  }
  if(isDefined(spider_lid)) {
    if(isDefined(spider_lid.script_fxid)) {
      playfx(level._effect[spider_lid.script_fxid], spider_lid.origin);
    }
  }
  chance = 0;
  if(isDefined(self.script_spiderhole_charge)) {
    chance = self.script_spiderhole_charge;
  }
  self notify("open_lid");
  anim_org notify("open_lid");
  level notify("open_lid");
  spider_lid notify("emerge");
  spider_lid notSolid();
  radius = 1024;
  if(isDefined(spider_lid) && isDefined(spider_lid.script_radius)) {
    radius = spider_lid.script_radius;
  }
  self.pacifist = false;
  closest_player = get_closest_player(self.origin);
  if(chance >= RandomInt(100)) {
    self thread spiderhole_charge(anim_org, spider_lid, closest_player);
  } else {
    self thread spiderhole_run_to_node(anim_org, spider_lid, target_node);
  }
}

spiderhole_charge(anim_org, spider_lid, closest_player) {
  self endon("death");
  self spiderhole_anim(anim_org, spider_lid, closest_player);
  self.goalradius = 64;
  self.ignoreall = false;
  self.pacifist = false;
  self.banzai_no_wait = true;
  self maps\_banzai::banzai_force();
}

spiderhole_charge_internal() {
  players = get_players();
  squad = getaiarray("allies");
  squad = array_remove(squad, level.sarge);
  squad = array_remove(squad, level.polonsky);
  combined = array_combine(players, squad);
  guy = get_closest_living(self.origin, combined, 1024);
  if(!isDefined(guy)) {
    guy = players[randomint(players.size)];
  }
  self thread set_goal_to_guy(guy);
  self playsound("jpn_charge");
  self thread spiderhole_charge_think();
}

set_goal_to_guy(guy) {
  self endon("death");
  while (issentient(guy)) {
    self setgoalpos(guy.origin);
    wait(.1);
  }
  self thread spiderhole_charge_internal();
}

spiderhole_charge_think() {
  self endon("death");
  self waittill("stop_spiderhole");
  self.goalradius = 2048;
  self set_default_pathenemy_settings();
  if(isDefined(self.old_run_combatanim)) {
    self.run_combatanim = self.old_run_combatanim;
  }
}

spiderhole_run_to_node(anim_org, spider_lid, target_node) {
  self endon("death");
  if(isDefined(target_node)) {
    closest_player = get_closest_player(self.origin);
    self spiderhole_anim(anim_org, spider_lid, closest_player);
    assertex(self.goalheight == 80, "Tried to set goalheight on guy with export " + self.export+" before running spawn_failed on the guy.");
    if(isDefined(target_node.height)) {
      self.goalheight = target_node.height;
    } else {
      self.goalheight = level.default_goalheight;
    }
    if(target_node.radius != 0) {
      self.goalradius = target_node.radius;
    } else {
      self.goalradius = 32;
    }
    self SetGoalNode(target_node);
  } else {
    self.allowdeath = true;
    self spiderhole_anim_internal(self.script_spiderhole_anim, self, spider_lid);
  }
}

spiderhole_reset_death(delay) {
  self endon("death");
  wait(delay);
  self.nodeathragdoll = false;
  self.deathanim = undefined;
  self.nodeathragdoll = undefined;
}

#using_animtree("generic_human");

spiderhole_anim(anim_org, lid, closest_object) {
  if(isDefined(self.script_spiderhole_anim)) {
    self.allowdeath = true;
    self.deathanim = % exposed_crouch_death_fetal;
    self.nodeathragdoll = true;
    self.ignoreme = false;
    self spiderhole_anim_internal(self.script_spiderhole_anim, anim_org, lid, closest_object);
    self spiderhole_duck(self.script_spiderhole_anim, anim_org, lid, closest_object);
    return;
  }
  self spiderhole_getout_anim(anim_org, lid, closest_object);
  self.nodeathragdoll = false;
  self.deathanim = undefined;
  self.nodeathragdoll = undefined;
}

spiderhole_getout_anim(anim_org, lid, closest_object) {
  num = RandomInt(100);
  if(num > 80) {
    getout_anim = "stumble_out";
  } else {
    getout_anim = "jump_out";
  }
  self spiderhole_anim_internal(getout_anim, anim_org, lid, closest_object);
  lid thread spiderhole_drop_lid_to_ground();
  self thread spiderhole_reset_death(1);
}

spiderhole_anim_internal(anim_ref, anim_org, lid, closest_object) {
  if(isDefined(closest_object)) {
    angles = VectorToAngles(closest_object.origin - self.origin);
    anim_org.angles = (0, angles[1], 0);
  }
  if(isDefined(lid)) {
    tag_origin = Spawn("script_model", lid.origin);
    tag_origin SetModel("tag_origin_animate");
    tag_origin.angles = anim_org.angles;
    lid LinkTo(tag_origin, "origin_animate_jnt");
    lid.tag_lid = tag_origin;
    lid.tag_lid.anim_ref = anim_ref;
    tag_origin assign_animtree("spiderhole_lid");
    tag_origin SetAnimKnob(level.scr_anim["spiderhole_lid"][anim_ref], 1, 0.2, 1);
  }
  addNotetrack_customFunction(self.animname, "fire", ::spiderhole_gun_spray, anim_ref);
  addNotetrack_customFunction(self.animname, "grenade_toss", ::spiderhole_grenade_toss, anim_ref);
  anim_org anim_single_solo(self, anim_ref);
  self notify("out_of_spiderhole");
  if(isDefined(lid)) {
    lid notify("out_of_spiderhole");
  }
}

spiderhole_drop_lid_to_ground() {
  if(!isDefined(level.no_spider_lid_drop)) {
    wait(1.5);
    self Unlink();
    groundPos = PhysicsTrace(self.origin + (0, 0, 64), self.origin - (0, 0, 256));
    self MoveTo(groundPos + (0, 0, 6), 0.5);
  }
}

spiderhole_duck(anim_ref, anim_org, lid, closest_object) {
  self endon("death");
  if(anim_ref == "grenade_toss" || anim_ref == "gun_spray") {
    anim_org thread anim_loop_solo(self, "spiderhole_idle_crouch", undefined, "emerge");
    if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
      wait(RandomFloatRange(self.script_delay_min, self.script_delay_max));
    } else {
      wait(.1);
    }
    while (1) {
      closest_player = get_closest_player(self.origin);
      if(DistanceSquared(closest_player.origin, self.origin) > 96 * 96) {
        break;
      }
      wait(0.05);
    }
    self notify("emerge");
    self spiderhole_getout_anim(anim_org, lid, closest_object);
  }
}

spiderhole_grenade_toss(guy) {
  tag = guy GetTagOrigin("tag_weapon_left");
  target = get_closest_player(guy.origin);
  guy MagicGrenade(tag, target.origin, 3);
}

spiderhole_gun_spray(guy) {
  guy Shoot(guy.accuracy);
}

line_to_tag(tag_name) {
  self endon("death");
  player = get_players()[0];
  while (1) {
    line(player.origin, self GetTagorigin(tag_name));
    wait(0.05);
  }
}

do_print3d(msg, time, offset) {
  if(!isDefined(time)) {
    time = 3;
  }
  time = GetTime() + (time * 1000);
  if(!isDefined(offset)) {
    offset = (0, 0, 32);
  }
  while (GetTime() < time) {
    offset = offset + (0, 0, 1.5);
    print3d(self.origin + offset, msg);
    wait(0.05);
  }
}

draw_tag_angles(tagname) {
  while (1) {
    forward = AnglesToForward(self GetTagAngles(tagname));
    pos2 = self GetTagOrigin(tagname) + vector_multiply(forward, 48);
    line(self GetTagOrigin(tagname), pos2);
    wait(0.05);
  }
}

monitor_spiderhole_death(lid) {
  self endon("out_of_spiderhole");
  self waittill("death");
  lid solid();
  lid notify("guy_dead");
}