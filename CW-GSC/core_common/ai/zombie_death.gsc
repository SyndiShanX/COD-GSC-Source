/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_death.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\fx_shared;
#namespace zombie_death;

function on_fire_timeout() {
  self endon(#"death");

  if(isDefined(self.flame_fx_timeout)) {
    wait self.flame_fx_timeout;
  } else {
    wait 8;
  }

  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = 0;
    self notify(#"stop_flame_damage");
  }
}

function flame_death_fx() {
  self endon(#"death");

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }

  if(is_true(self.disable_flame_fx)) {
    return;
  }

  self.is_on_fire = 1;
  self thread on_fire_timeout();

  if(isDefined(level._effect) && isDefined(level._effect[# "character_fire_death_torso"])) {
    fire_tag = "j_spinelower";
    fire_death_torso_fx = level._effect[# "character_fire_death_torso"];

    if(isDefined(self.weapon_specific_fire_death_torso_fx)) {
      fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
    }

    if(!isDefined(self gettagorigin(fire_tag))) {
      fire_tag = "tag_origin";
    }

    if(!isDefined(self.isdog) || !self.isdog) {
      self fx::play(fire_death_torso_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, fire_tag);
    }

    self.weapon_specific_fire_death_torso_fx = undefined;
  } else {
    println("<dev string:x38>");
  }

  if(isDefined(level._effect) && isDefined(level._effect[# "character_fire_death_sm"])) {
    if(!isvehicle(self) && self.archetype !== "raps" && self.archetype !== "spider") {
      fire_death_sm_fx = level._effect[# "character_fire_death_sm"];

      if(isDefined(self.weapon_specific_fire_death_sm_fx)) {
        fire_death_sm_fx = self.weapon_specific_fire_death_sm_fx;
      }

      if(isDefined(self.weapon_specific_fire_death_torso_fx)) {
        fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
      }

      wait 1;
      tagarray = [];
      tagarray[0] = "j_elbow_le";
      tagarray[1] = "j_elbow_ri";
      tagarray[2] = "j_knee_ri";
      tagarray[3] = "j_knee_le";
      tagarray = array::randomize(tagarray);
      self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[0]);
      wait 1;
      tagarray[0] = "j_wrist_ri";
      tagarray[1] = "j_wrist_le";

      if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
        tagarray[2] = "j_ankle_ri";
        tagarray[3] = "j_ankle_le";
      }

      tagarray = array::randomize(tagarray);
      self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[0]);
      self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[1]);
      self.weapon_specific_fire_death_sm_fx = undefined;
    }

    return;
  }

  println("<dev string:xda>");
}

function do_gib() {
  if(!isDefined(self.a.gib_ref)) {
    return;
  }

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }

  switch (self.a.gib_ref) {
    case # "right_arm":
      gibserverutils::gibrightarm(self, 0);
      break;
    case # "left_arm":
      gibserverutils::gibleftarm(self, 0);
      break;
    case # "right_leg":
      gibserverutils::gibrightleg(self, 0);
      break;
    case # "left_leg":
      gibserverutils::gibleftleg(self, 0);
      break;
    case # "no_legs":
      gibserverutils::giblegs(self, 0);
      break;
    case # "head":
      gibserverutils::gibhead(self, 0);
      break;
    case # "guts":
      break;
    default:
      assertmsg("<dev string:x176>" + self.a.gib_ref + "<dev string:x18b>");
      break;
  }
}