/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_init.gsc
**********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_turret;
#include animscripts\init;
#include animscripts\debug;
#include animscripts\anims;
#include animscripts\move;
#include animscripts\bigdog\anims_table_bigdog;
#include maps\_gameskill;
#include animscripts\bigdog\bigdog_pain;
#include animscripts\shared;
#include animscripts\pain;
#include animscripts\bigdog\bigdog_utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#using_animtree("bigdog");

main() {
  animscripts\init::firstinit();
  anim._effect["bigdog_spark_big"] = loadfx("env/electrical/fx_elec_bigdog_spark_lg_runner");
  anim._effect["bigdog_explosion"] = loadfx("destructibles/fx_claw_exp_death");
  anim._effect["bigdog_panel_explosion_large"] = loadfx("destructibles/fx_claw_exp_panel_lg");
  anim._effect["bigdog_panel_explosion_small"] = loadfx("destructibles/fx_claw_exp_panel");
  anim._effect["bigdog_leg_explosion"] = loadfx("destructibles/fx_claw_exp_leg_break");
  anim._effect["bigdog_leg_knee_hit_spark"] = loadfx("env/electrical/fx_elec_bigdog_spark_os");
  anim._effect["bigdog_leg_knee_spark_left"] = loadfx("electrical/fx_elec_claw_leg_joint_med_lft");
  anim._effect["bigdog_leg_knee_spark_right"] = loadfx("electrical/fx_elec_claw_leg_joint_med");
  anim._effect["bigdog_smoke"] = loadfx("destructibles/fx_claw_dmg_smk_lt");
  anim._effect["bigdog_dust_cloud"] = loadfx("dirt/fx_dust_impact_claw");
  anim._effect["bigdog_lights_green"] = loadfx("light/fx_vlight_claw_eye_grn");
  anim._effect["bigdog_lights_red"] = loadfx("light/fx_vlight_claw_eye_red");
  anim._effect["bigdog_emped"] = loadfx("electrical/fx_elec_sp_emp_stun_claw");

  if(!isDefined(anim.bigdog_globals)) {
    anim.bigdog_globals = spawnstruct();
    anim.bigdog_globals.bonemap = [];
    anim.bigdog_globals.bonemap["jnt_f_l_balljoint"] = "FL";
    anim.bigdog_globals.bonemap["jnt_f_l_knee_upper"] = "FL";
    anim.bigdog_globals.bonemap["jnt_f_l_knee_lower"] = "FL";
    anim.bigdog_globals.bonemap["jnt_f_l_ankle"] = "FL";
    anim.bigdog_globals.bonemap["jnt_f_r_balljoint"] = "FR";
    anim.bigdog_globals.bonemap["jnt_f_r_knee_upper"] = "FR";
    anim.bigdog_globals.bonemap["jnt_f_r_knee_lower"] = "FR";
    anim.bigdog_globals.bonemap["jnt_f_r_ankle"] = "FR";
    anim.bigdog_globals.bonemap["jnt_r_l_balljoint"] = "RL";
    anim.bigdog_globals.bonemap["jnt_r_l_knee_upper"] = "RL";
    anim.bigdog_globals.bonemap["jnt_r_l_knee_lower"] = "RL";
    anim.bigdog_globals.bonemap["jnt_r_l_ankle"] = "RL";
    anim.bigdog_globals.bonemap["jnt_r_r_balljoint"] = "RR";
    anim.bigdog_globals.bonemap["jnt_r_r_knee_upper"] = "RR";
    anim.bigdog_globals.bonemap["jnt_r_r_knee_lower"] = "RR";
    anim.bigdog_globals.bonemap["jnt_r_r_ankle"] = "RR";
    anim.bigdog_globals.leghierarchy["FL"] = array("jnt_f_l_balljoint", "jnt_f_l_knee_upper", "jnt_f_l_knee_lower", "jnt_f_l_ankle");
    anim.bigdog_globals.leghierarchy["FR"] = array("jnt_f_r_balljoint", "jnt_f_r_knee_upper", "jnt_f_r_knee_lower", "jnt_f_r_ankle");
    anim.bigdog_globals.leghierarchy["RL"] = array("jnt_r_l_balljoint", "jnt_r_l_knee_upper", "jnt_r_l_knee_lower", "jnt_r_l_ankle");
    anim.bigdog_globals.leghierarchy["RR"] = array("jnt_r_r_balljoint", "jnt_r_r_knee_upper", "jnt_r_r_knee_lower", "jnt_r_r_ankle");
    anim.bigdog_globals.legdamagedmap["FL"] = "jnt_f_l_knee_upper_dmg";
    anim.bigdog_globals.legdamagedmap["FR"] = "jnt_f_r_knee_upper_dmg";
    anim.bigdog_globals.legdamagedmap["RL"] = "jnt_r_l_knee_upper_dmg";
    anim.bigdog_globals.legdamagedmap["RR"] = "jnt_r_r_knee_upper_dmg";
    anim.bigdog_globals.bodydamagedmap["left"] = array("tag_panel_mid_l_lower_fx", "tag_panel_mid_l_upper_fx");
    anim.bigdog_globals.bodydamagedmap["right"] = array("tag_panel_mid_r_lower_fx", "tag_panel_mid_r_upper_fx");
    anim.bigdog_globals.bodydamagedmap["front"] = array("tag_panel_front_l_fx", "tag_panel_front_r_fx");
    anim.bigdog_globals.bodydamagedmap["back"] = array("tag_panel_rear_l_fx", "tag_panel_rear_r_fx");
    anim.bigdog_globals.bodydamagetags = array("tag_panel_mid_l_lower_fx", "tag_panel_mid_l_upper_fx", "tag_panel_mid_r_lower_fx", "tag_panel_mid_r_upper_fx", "tag_panel_front_l_fx", "tag_panel_front_r_fx", "tag_panel_rear_l_fx", "tag_panel_rear_r_fx");
  }

  if(!isDefined(level.difficultysettings["bigdog_axis_grenade_cooloff"])) {
    level.difficultysettings["bigdog_axis_grenade_cooloff"]["easy"] = 30;
    level.difficultysettings["bigdog_axis_grenade_cooloff"]["normal"] = 25;
    level.difficultysettings["bigdog_axis_grenade_cooloff"]["hardened"] = 20;
    level.difficultysettings["bigdog_axis_grenade_cooloff"]["veteran"] = 10;
    level.difficultysettings["bigdog_allies_burst_scale"]["easy"] = 1.5;
    level.difficultysettings["bigdog_allies_burst_scale"]["normal"] = 1;
    level.difficultysettings["bigdog_allies_burst_scale"]["hardened"] = 0.8;
    level.difficultysettings["bigdog_allies_burst_scale"]["veteran"] = 0.75;
    level.difficultysettings["bigdog_axis_burst_scale"]["easy"] = 0.75;
    level.difficultysettings["bigdog_axis_burst_scale"]["normal"] = 1;
    level.difficultysettings["bigdog_axis_burst_scale"]["hardened"] = 1.25;
    level.difficultysettings["bigdog_axis_burst_scale"]["veteran"] = 1.5;
  }

  self.a = spawnstruct();
  self.moveplaybackrate = 1;
  self.usecombatscriptatcover = 1;
  self.combatmode = "any_exposed_nodes_only";
  self.badplaceawareness = 0;
  self setcurrentweapon("none");
  self setprimaryweapon(self.weapon);
  self setsecondaryweapon(self.weapon);
  self.a.weaponpos["right"] = "none";
  self.a.weaponpos["left"] = "none";
  self.audio_is_targeting = 1;
  self.a.allow_shooting = 1;

  thread animscripts\debug::updatedebuginfo();

  self useanimtree(#animtree);
  self.animtype = "bigdog";
  self.lastanimtype = self.animtype;
  self animscripts\anims::clearanimcache();
  setup_bigdog_anims(self.animtype);
  self.a.pose = "stand";
  self.a.prevpose = self.a.pose;
  self.a.movement = "stop";
  self.a.script = "init";
  self.issniper = 0;
  self.bulletsinclip = 0;
  self.a.lastshoottime = 0;
  self.a.misstime = 0;
  self.ignoresuppression = 1;
  self.sprint = 0;
  self.walk = 1;
  self.turnrate = 5;
  self.turnanglethreshold = 15;
  self.canmove = 1;
  self.overrideactordamage = ::bigdog_damage_override;
  self.turretindependent = 0;
  self.parthealth = [];
  self.parthealth["FL"] = self.health * 0.5;
  self.parthealth["FR"] = self.health * 0.5;
  self.parthealth["RL"] = self.health * 0.5;
  self.parthealth["RR"] = self.health * 0.5;
  self.parthealth["body"] = self.health * 1.0;
  self.initialhealth = self.health;
  self.initialhealthleg = self.health * 0.5;
  self.initialhealthbody = self.health * 1.0;
  self.health = 99999999;
  partkeys = getarraykeys(self.parthealth);
  self.hitcount = [];

  foreach(key in partkeys)
  self.hitcount[key] = 0;

  self.hitcount["total"] = 0;
  self.launchercoolofftime = -1;
  self.nonplayerdamagetime = -1;
  self.nextmovetonextbestcovernodetime = gettime() + randomintrange(7000, 12000);
  self.minpaindamage = 2;
  self.a.wounded = 0;
  self.grenadeammo = 0;
  self.hunkereddown = 0;
  self.damageleg = "";
  self.damagedlegs = [];
  self.missinglegs = [];
  self.bullethintshown = 0;
  self.chargedbullethintshown = 0;
  self.bodydamagedmap = anim.bigdog_globals.bodydamagedmap;
  self.baseaccuracy = self.accuracy;

  if(!isDefined(self.script_accuracy))
    self.script_accuracy = 1;

  self setphysparams(28, 0, 70);
  animscripts\move::moveglobalsinit();
  setup_bigdog_turret();
  bonekeys = getarraykeys(anim.bigdog_globals.legdamagedmap);

  foreach(key in bonekeys)
  self hidepart(anim.bigdog_globals.legdamagedmap[key]);

  bigdog_lights_on();
  self thread set_fight_dist();
  self thread decay_hit_counts();
  self thread walking_loop_audio();
  self thread play_spawn_alarm();
  self thread bigdog_kill_all_fx_on_death();
  level.is_player_inside_arena = 0;
  self thread handle_badplaces();
}

handle_badplaces() {
  self endon("death");
  bigdogusebiggerbadplace = isDefined(self.bigdogusebiggerbadplace) && self.bigdogusebiggerbadplace;
  badplace_name = "bdog_" + self getentitynumber();
  self.a.badplacename = badplace_name;
  thresh2 = 2500;
  radius = 100;
  height = 300;
  self.a.last_badplace_pos = self.origin;
  badplace_cylinder(badplace_name + "1", -1, self.origin, radius, height, "all");

  if(bigdogusebiggerbadplace) {
    origin = self.origin + vectorscale(anglestoforward(self.angles), 100);
    badplace_cylinder(badplace_name + "2", -1, origin, radius, height, "all");
  }

  while(true) {
    wait 3;
    bigdogusebiggerbadplace = isDefined(self.bigdogusebiggerbadplace) && self.bigdogusebiggerbadplace;

    if(distancesquared(self.origin, self.a.last_badplace_pos) > thresh2) {
      self.a.last_badplace_pos = self.origin;
      badplace_delete(badplace_name + "1");

      if(bigdogusebiggerbadplace)
        badplace_delete(badplace_name + "2");

      wait 0.1;
      badplace_cylinder(badplace_name, -1, self.origin, radius, height, "all");

      if(bigdogusebiggerbadplace) {
        origin = self.origin + vectorscale(anglestoforward(self.angles), 100);
        badplace_cylinder(badplace_name + "2", -1, origin, radius, height, "all");
      }
    }
  }
}

set_fight_dist() {
  self endon("death");
  wait 0.05;
  self.pathenemylookahead = 96;
  self.pathenemyfightdist = 96;
}

setup_bigdog_anims(animtype) {
  assert(isDefined(anim.anim_array) && isarray(anim.anim_array));

  if(isDefined(anim.anim_array[animtype])) {
    return;
  }
  anim.anim_array = animscripts\bigdog\anims_table_bigdog::setup_bigdog_anim_array(animtype, anim.anim_array);
}

bigdog_chase_enemy_behavior() {
  self endon("death");
  curenemy = undefined;

  while(true) {
    if(isDefined(self.enemy) && (!isDefined(curenemy) || self.enemy != curenemy)) {
      if(isplayer(self.enemy) || isai(self.enemy)) {
        curenemy = self.enemy;
        self setgoalentity(curenemy);
      }
    }

    wait 1;
  }
}

setup_bigdog_turret() {
  self detach(self.headmodel);

  if(self.team == "axis")
    self.headmodel = "veh_t6_drone_claw_mk2_turret_alt";

  self.turret = create_turret(self.origin, self.angles, self.team, "bigdog_dual_turret", self.headmodel, vectorscale((0, 0, 1), 50.0));
  self.turret maketurretunusable();
  self.turret maps\_turret::pause_turret(0);
  self setontargetangle(2);

  recordent(self.turret);

  self.turret linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  self thread update_turret_target();
  self thread fire_when_on_target();
  self thread stopturretondeath();
}

update_turret_target() {
  self endon("death");
  self endon("stop_fire_turret");
  paused = 0;
  offset = (0, 0, 0);

  while(true) {
    if(!self.turretindependent) {
      shouldshootatscriptedtarget = isDefined(self.scripted_target);

      if(isDefined(self.enemy) || shouldshootatscriptedtarget) {
        if(shouldshootatscriptedtarget)
          self.turret set_turret_target(self.scripted_target);
        else if(bigdog_isemped()) {
          if(!isDefined(self.fakeenemy)) {
            self.fakeenemy = spawn("script_origin", self.enemy.origin);
            self thread delete_on_death(self.fakeenemy);
          }

          self.fakeenemy.origin = self.enemy.origin;
          offset = (randomint(400), randomint(400), randomint(400));
          self.turret set_turret_target(self.fakeenemy, offset);
        } else if(canbigdogturretshoottarget()) {
          if(isplayer(self.enemy)) {
            offset = getplayerstancebasedoffset(self.enemy);
            self.turret set_turret_target(self.enemy, offset);

            if(getdvar(#"_id_0C5E1FC8") == "on") {
              recordline(self.turret gettagorigin("tag_flash"), self.enemy.origin + offset, (1, 0, 0), "Script", self);
              recordline(self.turret gettagorigin("tag_laser"), self.enemy.origin + offset, (1, 0, 0), "Script", self);
            }

          } else {
            self.turret set_turret_target(self.enemy);

            if(getdvar(#"_id_0C5E1FC8") == "on") {
              recordline(self.turret gettagorigin("tag_flash"), self.enemy.origin, (0, 1, 0), "Script", self);
              recordline(self.turret gettagorigin("tag_laser"), self.enemy.origin, (1, 0, 0), "Script", self);
            }

          }
        } else
          self.turret clear_turret_target();
      } else
        self.turret clear_turret_target();
    }

    wait 0.2;
  }
}

getplayerstancebasedoffset(player) {
  stance = player getstance();
  offset = (0, 0, 0);

  switch (stance) {
    case "stand":
      offset = vectorscale((0, 0, 1), 40.0);
      break;
    case "crouch":
      offset = vectorscale((0, 0, 1), 20.0);
      break;
    case "prone":
      offset = (randomintrange(-40, 40), randomintrange(-40, 40), 10);
      break;
  }

  return offset;
}

canbigdogturretshoottarget(currenttarget) {
  canshoottarget = 0;

  if(!isDefined(currenttarget))
    currenttarget = self.turret get_turret_target();

  if(!isDefined(currenttarget))
    currenttarget = self.enemy;

  if(isDefined(currenttarget)) {
    if(isDefined(self.shoot_only_on_sight) && self.shoot_only_on_sight)
      canshoottarget = bullettracepassed(self.turret gettagorigin("tag_flash"), currenttarget.origin + vectorscale((0, 0, 1), 20.0), 1, self, currenttarget);
    else
      canshoottarget = bullettracepassed(self.turret gettagorigin("tag_flash"), currenttarget getshootatpos(self), 1, self, currenttarget);

    if(!canshoottarget && !(isDefined(self.shoot_only_on_sight) && self.shoot_only_on_sight) && distancesquared(self.origin, currenttarget.origin) < 22500)
      canshoottarget = 1;
  }

  return canshoottarget;
}

fire_when_on_target() {
  self endon("death");
  self endon("stop_fire_turret");
  weaponspinsettings = weaponspinsettings("bigdog_dual_turret");
  spinuptime = weaponspinsettings["up"] / 1000;
  turretspinning = 0;
  self thread bigdog_targeting_audio();

  while(true) {
    while(isDefined(self.a.pausefiring) && self.a.pausefiring)
      wait 0.05;

    self.turret waittill("turret_on_target");

    if(self.team == "axis") {
      waittime_scale = maps\_gameskill::getcurrentdifficultysetting("bigdog_allies_burst_scale");
      bursttime_scale = maps\_gameskill::getcurrentdifficultysetting("bigdog_axis_burst_scale");
    } else {
      waittime_scale = maps\_gameskill::getcurrentdifficultysetting("bigdog_axis_burst_scale");
      bursttime_scale = maps\_gameskill::getcurrentdifficultysetting("bigdog_allies_burst_scale");
    }

    currenttarget = self.turret get_turret_target();
    canshoottarget = 0;

    if(isDefined(currenttarget))
      canshoottarget = 1;

    if(self.a.allow_shooting && !self.turretindependent && canshoottarget) {
      if(!turretspinning) {
        self.turret setturretspinning(1);
        wait(spinuptime);
        turretspinning = 1;
      }

      bursttime = randomfloatrange(0.9, 1) * bursttime_scale;
      waittime = randomfloatrange(1, 1.4) * waittime_scale;

      if(isDefined(self.enemy)) {
        disttoenemy = distance(self.origin, self.enemy.origin);
        distlerpval = min(1, max(0, (disttoenemy - 300) / (600 - 300)));
        waittime = lerpfloat(0, waittime, distlerpval);
      }

      self.audio_is_targeting = 0;
      self.turret maps\_turret::set_turret_burst_parameters(bursttime, bursttime, waittime, waittime);
      self thread bigdog_fire_turret(bursttime);

      if(waittime > 0) {
        self.turret setturretspinning(0);
        turretspinning = 0;
      }

      wait(bursttime);
    } else
      waittime = 0.25;

    bigdog_try_launcher();
    wait(waittime);
    self.audio_is_targeting = 1;
  }
}

bigdog_has_target() {
  return isDefined(self.turret get_turret_target());
}

bigdog_fire_turret(bursttime) {
  self endon("death");
  self endon("pain");
  self endon("stop_fire_turret");
  self.turret notify("fire_on_target");
  self.turret laseron();
  self.turret maps\_turret::fire_turret_for_time(bursttime);
  self.turret laseroff();
}

stopturretondeath() {
  self waittill("death");

  if(isDefined(self.turret)) {
    self.turret maps\_turret::disable_turret();

    while(isDefined(self))
      wait 0.05;

    if(isDefined(self.turret))
      self.turret delete();
  }
}

stopturretfortime(time) {
  self endon("death");
  self.a.allow_shooting = 0;
  wait(time);
  self.a.allow_shooting = 1;
}

bigdog_lights_on() {
  if(self.team == "allies")
    self.a.lightsfxent = bigdog_add_fx("tag_neck", anim._effect["bigdog_lights_green"], undefined, 1);
  else
    self.a.lightsfxent = bigdog_add_fx("tag_neck", anim._effect["bigdog_lights_red"], undefined, 1);
}

bigdog_lights_off() {
  if(isDefined(self.a.lightsfxent))
    self.a.lightsfxent delete();
}

bigdog_add_fx(bonename, effect, sound, useangles, playonself) {
  if(!isDefined(self.fx_ents))
    self.fx_ents = [];

  if(isDefined(playonself) && playonself)
    playfxontag(effect, self, bonename);
  else {
    fxorigin = self gettagorigin(bonename);
    tempent = spawn("script_model", fxorigin);

    if(isDefined(useangles) && useangles)
      tempent.angles = self gettagangles(bonename);

    tempent setmodel("tag_origin");
    tempent linkto(self, bonename);
    playfxontag(effect, tempent, "tag_origin");
    self.fx_ents[self.fx_ents.size] = tempent;
    return tempent;
  }

  if(isDefined(sound))
    self playsound(sound);
}

bigdog_kill_all_fx_on_death() {
  self waittill_any("stop_bigdog_scripted_fx_threads", "death");

  if(isDefined(self.fx_ents)) {
    fx_ents = self.fx_ents;
    array_delete(fx_ents);
  }

  bigdog_lights_off();
}

bigdog_emped_behavior() {
  self endon("death");
  self.turret laseroff();
  self thread bigdog_emped_lights_blinking();
  bigdog_add_fx("tag_body_animate", anim._effect["bigdog_emped"], undefined, 1);
  self playsound("veh_hunker_down_flinch_b");
  self thread stopturretfortime(7.5);
  self.a.empedendtime = gettime() + 7500.0;
  self animcustom(::bigdog_emp_anim);
  wait 7.5;
  self playsound("veh_qrdrone_boot_bdog");
  wait 1;
  self notify("bigdog_emped_done");
  bigdog_lights_on();
}

bigdog_emp_anim() {
  self endon("death");

  if(!self.hunkereddown) {
    empanim = animscripts\bigdog\bigdog_pain::gethunkerdownpainanim();
    assert(isDefined(empanim));
    self setflaggedanimknoballrestart("empAnim", empanim, % body, 1, 0.2, 1.0);
    self animscripts\shared::donotetracks("empAnim");
    self.hunkereddown = 1;
  } else if(self.hunkereddown) {
    empanim = animscripts\bigdog\bigdog_pain::getflinchanim();
    assert(isDefined(empanim));
    self setflaggedanimknoballrestart("empAnim", empanim, % body, 1, 0.2, 0.7);
    self animscripts\shared::donotetracks("empAnim");
  }

  if(gettime() < self.a.empedendtime)
    self waittill("bigdog_emped_done");
}

bigdog_emped_lights_blinking() {
  self endon("death");
  self endon("bigdog_emped_done");

  while(true) {
    bigdog_lights_off();
    wait 0.2;
    bigdog_lights_on();
    wait 0.2;
  }
}

bigdog_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  self.damageleg = "";

  if(meansofdeath == "MOD_TRIGGER_HURT")
    return 0;

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return 0;

  if(shouldignorenonplayernonbigdogdamage(attacker, meansofdeath))
    return 0;

  isleghit = bigdog_is_leg_hit(bonename);
  isbodyhit = bigdog_is_body_hit(bonename);
  weaponchargeable = isDefined(weapon) && ischargedshotsniperrifle(weapon);
  weaponischarged = weaponchargeable && isDefined(attacker) && isDefined(attacker.chargeshotlevel) && attacker.chargeshotlevel >= 2;
  weaponissniperrifle = weaponissniperweapon(weapon);
  weaponisminigun = issubstr(weapon, "minigun");
  bigdog_bullet_hint_trigger(attacker, damage, meansofdeath, weapon, bonename, isleghit, isbodyhit, weaponchargeable, weaponischarged, weaponissniperrifle, weaponisminigun);
  dobodydamage = 0;
  doexplosivebodydamage = 0;
  doonlylegdamage = 0;
  returndamage = damage;

  if(wasdamagedbyempgrenade(weapon, meansofdeath)) {
    if(!bigdog_isemped()) {
      self thread bigdog_emped_behavior();
      return 0;
    }
  } else if(animscripts\pain::isexplosivedamagemod(meansofdeath) && !issubstr(weapon, "flash")) {
    damageyaw = angleclamp180(vectortoangles(vdir)[1] - self.angles[1]);

    if(damageyaw > 135 || damageyaw <= -135)
      legshit = array("FL", "FR");
    else if(damageyaw > 45 && damageyaw < 135)
      legshit = array("FR", "RR");
    else if(damageyaw > -135 && damageyaw < -45)
      legshit = array("FL", "RL");
    else
      legshit = array("RL", "RR");

    doexplosivebodydamage = 1;
  } else if((weaponissniperrifle || weaponischarged || weaponisminigun) && isbodyhit)
    dobodydamage = 1;
  else if(attackedbyplayer(attacker)) {
    if(is_bullet_damage(attacker, meansofdeath) && isleghit) {
      legshit = array(anim.bigdog_globals.bonemap[bonename]);
      doonlylegdamage = 1;
    } else if(attackedbyplayerusingbigdogvehicle(inflictor, attacker))
      dobodydamage = 1;
  } else {
    assert(!isplayer(attacker));

    if(is_bullet_damage(attacker, meansofdeath)) {
      if(isleghit) {
        legshit = array(anim.bigdog_globals.bonemap[bonename]);
        doonlylegdamage = 1;
      } else
        dobodydamage = 1;
    }
  }

  if(doexplosivebodydamage) {
    if(bigdog_damage_body(attacker, damage, meansofdeath, weapon, vpoint))
      return self.health;

    bigdog_damage_leg(attacker, damage, meansofdeath, weapon, vpoint, vdir, legshit[randomintrange(0, legshit.size)], bonename, weaponischarged);
    returndamage = bigdog_try_pain("body", attacker);
    return returndamage;
  } else if(dobodydamage) {
    if(bigdog_damage_body(attacker, damage, meansofdeath, weapon, vpoint))
      return self.health;

    returndamage = bigdog_try_pain("body", attacker);
    return returndamage;
  } else if(doonlylegdamage) {
    bigdog_damage_leg(attacker, damage, meansofdeath, weapon, vpoint, vdir, legshit[0], bonename);

    if(!isbigdoglegmissing(legshit[0])) {
      returndamage = bigdog_try_pain(legshit[0], attacker);
      return returndamage;
    } else
      return 0;
  }

  return 0;
}

bigdog_is_leg_hit(bonename) {
  return array(anim.bigdog_globals.bonemap[bonename]).size > 0;
}

bigdog_is_body_hit(bonename) {
  return array(anim.bigdog_globals.bonemap[bonename]).size <= 0;
}

is_bullet_damage(attacker, meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET")
    return true;

  if(meansofdeath == "MOD_PISTOL_BULLET")
    return true;

  return false;
}

shouldignorenonplayernonbigdogdamage(attacker, meansofdeath) {
  if(!attackedbyplayer(attacker) && !attackedbyotherbigdog(attacker) && !attackedbyasd(attacker)) {
    if(animscripts\pain::isexplosivedamagemod(meansofdeath))
      return false;

    if(gettime() < self.nonplayerdamagetime)
      return true;
  }

  return false;
}

bigdog_try_pain(location, attacker) {
  returndamage = 0;
  returndamage = self.minpaindamage + 1;
  self.hitcount[location] = 0;
  self.nonplayerdamagetime = gettime() + 5000;
  return returndamage;
}

attackedbyplayer(attacker) {
  if(isDefined(attacker) && isplayer(attacker))
    return true;

  return false;
}

attackedbyplayerusingbigdogvehicle(inflictor, attacker) {
  if(!attackedbyplayer(attacker))
    return false;

  if(isDefined(inflictor) && inflictor isvehicle() && issubstr(inflictor.vehicletype, "claw_rts"))
    return true;

  return false;
}

attackedbyotherbigdog(attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.classname) && attacker.classname == "misc_turret" && issubstr(attacker.model, "claw"))
      return true;

    if(isDefined(attacker.isbigdog) && attacker.isbigdog)
      return true;
  }

  return false;
}

attackedbyasd(attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.vehicletype) && issubstr(attacker.vehicletype, "metalstorm"))
      return true;
  }

  return false;
}

attackedbyhumanai(attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker) && isai(attacker) && attacker.type == "human")
      return true;
  }

  return false;
}

bigdog_try_launcher() {
  canuselauncher = bigdog_can_use_launcher();

  if(!canuselauncher) {
    self.grenadeammo = 0;
    self.grenade_fire = 0;
    self notify("stop_grenade_launcher");
  }

  animscripts\bigdog\bigdog_utility::setactivegrenadetimer(self.enemy);
  selfcooloff = gettime() >= self.launchercoolofftime;
  globalcooloff = gettime() >= anim.grenadetimers[self.activegrenadetimer];

  if(canuselauncher && isDefined(self.enemy) && selfcooloff && globalcooloff) {
    if(bigdog_launcher_fire()) {
      self.launchercoolofftime = gettime() + maps\_gameskill::getcurrentdifficultysetting("bigdog_axis_grenade_cooloff") * 1000;
      nextgrenadetimetouse = animscripts\combat_utility::getdesiredgrenadetimervalue();
      animscripts\combat_utility::setgrenadetimer(self.activegrenadetimer, min(gettime() + 5000, nextgrenadetimetouse));
    }
  }
}

bigdog_can_use_launcher() {
  if(self.grenadeammo != 0)
    return false;

  if(!isDefined(self.enemy))
    return false;

  if(!self.a.allow_shooting)
    return false;

  if(!self seerecently(self.enemy, 3)) {
    lastknownpos = self lastknownpos(self.enemy);

    if(distancesquared(self.origin, lastknownpos) < 250000)
      return false;
  } else {
    if(self.hitcount["total"] < 10)
      return false;

    if(distancesquared(self.origin, self.enemy.origin) < 90000)
      return false;

    yawtoenemy = getyawtospot(self.enemy.origin);

    if(abs(yawtoenemy) > 90)
      return false;
  }

  return true;
}

bigdog_launcher_fire() {
  self endon("death");
  self endon("stop_grenade_launcher");

  if(isDefined(self.grenade_fire) && self.grenade_fire) {
    return;
  }
  self.grenade_fire = 1;
  self.grenadeammo = 1;
  firedgrenade = firelauncher();
  self.grenadeammo = 0;
  self.grenade_fire = 0;

  if(firedgrenade)
    return 1;
  else
    return 0;
}

firelauncher() {
  toenemy = self.enemy.origin - self.origin;
  toenemy = (toenemy[0], toenemy[1], 0);
  toenemy = vectornormalize(toenemy);

  if(!self seerecently(self.enemy, 3)) {
    lastknownpos = self lastknownpos(self.enemy);
    grenadetarget = self.enemy.origin + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
  } else
    grenadetarget = self.enemy.origin;

  launchpos = self gettagorigin("tag_grenade");
  launchpos = launchpos + vectorscale((0, 0, 1), 20.0);
  launchoffset = launchpos - self.origin;
  tempvec = (launchoffset[0], launchoffset[1], 0);
  launchoffset = (length(tempvec), 0, launchoffset[2]);

  recordline(self.origin, launchpos, (1, 0, 0), "Script");

  throwvel = self checkgrenadethrowpos(launchoffset, "min time", grenadetarget);

  if(!isDefined(throwvel)) {
    throwvel = self checkgrenadethrowpos(launchoffset, "min energy", grenadetarget);

    if(!isDefined(throwvel))
      throwvel = self checkgrenadethrowpos(launchoffset, "max time", grenadetarget);
  }

  if(!isDefined(throwvel))
    return false;

  self magicgrenademanual(launchpos, throwvel, 7.5);
  self playsoundontag("wpn_claw_gren_fire_npc", "tag_neck");
  self notify("grenade_fire_bigdog", grenadetarget);
  return true;
}

bigdog_damage_leg(attacker, damage, meansofdeath, weapon, vpoint, vdir, leg, bonename, weaponischarged) {
  if(attackedbyhumanai(attacker))
    self.parthealth[leg] = self.parthealth[leg] - damage * 1.5;
  else if(attackedbyotherbigdog(attacker))
    moddamage = int(damage * 2);
  else if(isDefined(weaponischarged) && weaponischarged)
    self.parthealth[leg] = self.parthealth[leg] - damage * 1;
  else
    self.parthealth[leg] = self.parthealth[leg] - damage * 0.6;

  iprintln("leg: " + leg + " health: " + self.parthealth[leg]);

  self.damageleg = leg;

  if(self.parthealth[leg] <= 0) {
    if(trytobreakoffleg(leg)) {
      self.a.wounded = 1;
      self notify("wounded");

      if(!hasenoughlegstomove())
        bigdodsetcantmove(attacker, damage, meansofdeath, weapon, vpoint);
    }
  } else if(self.parthealth[leg] < self.initialhealthleg * 0.5) {
    if(self.damageleg == "FL" && !(isDefined(self.damagedlegs["FL"]) && self.damagedlegs["FL"])) {
      self.damagedlegs["FL"] = 1;
      bigdog_add_fx("jnt_f_l_knee_upper", anim._effect["bigdog_leg_knee_spark_left"]);
    } else if(self.damageleg == "FR" && !(isDefined(self.damagedlegs["FR"]) && self.damagedlegs["FR"])) {
      self.damagedlegs["FR"] = 1;
      bigdog_add_fx("jnt_f_r_knee_upper", anim._effect["bigdog_leg_knee_spark_right"]);
    } else if(self.damageleg == "RL" && !(isDefined(self.damagedlegs["RL"]) && self.damagedlegs["RL"])) {
      self.damagedlegs["RL"] = 1;
      bigdog_add_fx("jnt_r_l_knee_upper", anim._effect["bigdog_leg_knee_spark_left"]);
    } else if(self.damageleg == "RR" && !(isDefined(self.damagedlegs["RR"]) && self.damagedlegs["RR"])) {
      self.damagedlegs["RR"] = 1;
      bigdog_add_fx("jnt_r_r_knee_upper", anim._effect["bigdog_leg_knee_spark_right"]);
    }
  } else if(self.damageleg == "FL")
    playfxontag(anim._effect["bigdog_leg_knee_hit_spark"], self, "jnt_r_r_knee_upper");
  else if(self.damageleg == "FR")
    playfxontag(anim._effect["bigdog_leg_knee_hit_spark"], self, "jnt_f_r_knee_upper");
  else if(self.damageleg == "RL")
    playfxontag(anim._effect["bigdog_leg_knee_hit_spark"], self, "jnt_r_l_knee_upper");
  else if(self.damageleg == "RR")
    playfxontag(anim._effect["bigdog_leg_knee_hit_spark"], self, "jnt_r_r_knee_upper");

  increase_hit_count(leg);
  return false;
}

bigdodsetcantmove(attacker, damage, meansofdeath, weapon, vpoint) {
  self.canmove = 0;
  self notify("immobilized");
  bigdog_damage_body(attacker, int(self.parthealth["body"] / 2), meansofdeath, weapon, vpoint, 1);
}

forcebigdogsetcanmoveifneeded() {
  if(!hasenoughlegstomove()) {
    self.canmove = 0;
    self.hunkereddown = 1;
  }
}

trytobreakoffleg(leg) {
  if(!isDefined(self.missinglegs[leg])) {
    for(i = 1; i < anim.bigdog_globals.leghierarchy[leg].size; i++)
      self hidepart(anim.bigdog_globals.leghierarchy[leg][i]);

    self showpart(anim.bigdog_globals.legdamagedmap[leg]);
    bonename = anim.bigdog_globals.leghierarchy[leg][1];
    bigdog_add_fx(bonename, anim._effect["bigdog_spark_big"], "wpn_bigdog_damaged");
    playfxontag(anim._effect["bigdog_leg_explosion"], self, bonename);
    playsoundatposition("wpn_bigdog_explode", self.origin);
    self.missinglegs[leg] = "bottom";
    return true;
  }

  return false;
}

isbigdoglegmissing(leg) {
  if(isDefined(self.missinglegs[leg]))
    return true;

  return false;
}

hasenoughlegstomove() {
  if(self.missinglegs.size == 2)
    return false;

  return true;
}

bigdog_damage_body(attacker, damage, meansofdeath, weapon, vpoint, ignoredamagescale) {
  moddamage = 0;

  if(isDefined(ignoredamagescale) && ignoredamagescale)
    moddamage = damage;
  else if(attackedbyhumanai(attacker))
    moddamage = int(damage * 1.5);
  else if(attackedbyotherbigdog(attacker))
    moddamage = int(damage * 2);
  else {
    wasdamagedbyplayergrenade = isDefined(weapon) && weaponclass(weapon) == "grenade";
    wasdamagedbygodrod = isDefined(weapon) && weapon == "god_rod_sp";

    if(wasdamagedbyplayergrenade || wasdamagedbygodrod)
      moddamage = int(damage * 3.0);
    else
      moddamage = int(damage * 0.4);
  }

  self.parthealth["body"] = self.parthealth["body"] - moddamage;

  if(self.parthealth["body"] <= 0)
    return true;

  iprintln("body: " + self.parthealth["body"]);

  if(self.parthealth["body"] < self.initialhealthbody * 0.5) {
    self thread playneardeathbodydamagefx();
    self.a.wounded = 1;
  } else if(self.parthealth["body"] < self.initialhealthbody)
    self thread playbodydamagefx();

  increase_hit_count("body");
  return false;
}

getbodydamagedirection(point) {
  yaw = animscripts\utility::getyawtospot(point);
  direction = "front";

  if(yaw >= 135 || yaw <= -135)
    direction = "back";
  else if(yaw > 45 && yaw < 135)
    direction = "right";
  else if(yaw < -45 && yaw > -135)
    direction = "left";
}

playneardeathbodydamagefx() {
  self endon("death");
  self endon("stop_bigdog_scripted_fx_threads");

  if(isDefined(self.a.alreadyplayedneardeathfx) && self.a.alreadyplayedneardeathfx) {
    return;
  }
  self.a.alreadyplayedneardeathfx = 1;
  smokestacks = 0;

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    boneindex = randomint(anim.bigdog_globals.bodydamagetags.size);
    tag = anim.bigdog_globals.bodydamagetags[boneindex];
    playsoundatposition("wpn_bigdog_damaged", self.origin);
    playfxontag(anim._effect["bigdog_panel_explosion_large"], self, tag);

    if(smokestacks < 1) {
      bigdog_add_fx(tag, anim._effect["bigdog_smoke"]);
      smokestacks++;
    }

    wait(randomfloatrange(3, 6));
  }
}

playbodydamagefx() {
  self endon("death");
  boneindex = randomint(anim.bigdog_globals.bodydamagetags.size);
  tag = anim.bigdog_globals.bodydamagetags[boneindex];
  playsoundatposition("wpn_bigdog_damaged", self.origin);
  playfxontag(anim._effect["bigdog_panel_explosion_small"], self, tag);
}

increase_hit_count(bodypart) {
  self.hitcount[bodypart] = self.hitcount[bodypart] + 1;
  self.hitcount["total"] = self.hitcount["total"] + 1;
}

decay_hit_counts() {
  self endon("death");
  decayrate = 0.15;

  while(true) {
    keys = getarraykeys(self.hitcount);

    foreach(key in keys) {
      if(self.hitcount[key] > 0)
        self.hitcount[key] = max(0, self.hitcount[key] - decayrate);
    }

    wait 0.05;
  }
}

bigdog_targeting_audio() {
  self endon("death");

  while(true) {
    self.turret waittill("fire_on_target");

    if(self.audio_is_targeting) {
      self.turret playsound("wpn_bigdog_turret_lockon_npc");
      wait 1;
    }
  }
}

walking_loop_audio() {
  self endon("death");
  self thread stop_sounds_on_death();
  self playloopsound("blk_bigdog_loop", 0.1);

  while(true) {
    if(self.a.wounded == 1) {
      self thread damaged_walking_audio();
      break;
    }

    wait_network_frame();
  }
}

stop_sounds_on_death() {
  self waittill("death");

  if(isDefined(self))
    self stoploopsound(0.1);
}

damaged_walking_audio() {
  self endon("death");
  self stoploopsound(0.1);
  wait 0.2;
  self playloopsound("blk_bigdog_vuln_loop", 0.1);
  self playsound("");
}

play_spawn_alarm() {
  self endon("death");
  wait 0.5;
  wait(randomintrange(1, 6));
  self playsound("veh_claw_alert");
  wait 4;

  if(level.is_player_inside_arena == 0) {
  } else {
  }
}

play_speech_warning() {
  if(!isDefined(level.bigdog_speak))
    level.bigdog_speak = 0;

  if(level.bigdog_speak == 0) {
    level.bigdog_speak = 1;
    self playsound("veh_claw_speak_alert", "sound_complete");
    self waittill("sound_complete");
    self playsound("veh_claw_vo", "sound_complete");
    self waittill("sound_complete");
    level.bigdog_speak = 0;
  }
}

play_ambient_vo() {
  self endon("death");

  while(true) {
    speechvar = randomintrange(0, 100);

    if(speechvar < 30 && self bigdog_has_target())
      self thread play_speech_warning();

    wait 5.0;
  }
}

bigdog_bullet_hint_trigger(attacker, damage, meansofdeath, weapon, bonename, isleghit, isbodyhit, weaponchargeable, weaponischarged, weaponissniperrifle, weaponisminigun) {
  if(!isDefined(self.n_bullet_damage))
    self.n_bullet_damage = 0;

  if(self.bullethintshown && self.chargedbullethintshown) {
    return;
  }
  if(isplayer(attacker) && isbodyhit) {
    if(weaponchargeable) {
      if(!self.chargedbullethintshown && !weaponischarged) {
        if(!isDefined(self.bullet_hint_timer) || level.bullet_hint_timer get_time_in_seconds() > 5) {
          level thread show_bullet_charge_hint();
          level.bullet_hint_timer = new_timer();
          self.n_bullet_damage = 0;
          self.chargedbullethintshown = 1;
        }
      }
    } else if(!self.bullethintshown && is_bullet_damage(attacker, meansofdeath) && !weaponissniperrifle && !weaponisminigun) {
      self.n_bullet_damage = self.n_bullet_damage + damage;

      if(self.n_bullet_damage > 500) {
        if(!isDefined(level.bullet_hint_timer) || level.bullet_hint_timer get_time_in_seconds() > 5) {
          level.bullet_hint_timer = new_timer();
          self.n_bullet_damage = 0;
          self.bullethintshown = 1;
        }
      }
    }
  }
}

show_bullet_damage_hint() {
  screen_message_create(&"SCRIPT_HINT_BIGDOG_BULLET_DAMAGE");
  wait 3;
  screen_message_delete();
}

show_bullet_charge_hint() {
  screen_message_create(&"SCRIPT_HINT_BIGDOG_CHARGED_SHOT");
  wait 3;
  screen_message_delete();
}