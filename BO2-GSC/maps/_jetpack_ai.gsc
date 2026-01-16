/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_jetpack_ai.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;

autoexec init() {
  precachemodel("veh_t6_air_jetpack");
  precachemodel("fxanim_gp_parachute_jetpack_mod");
  init_jetpack_ai_anims();
  init_jetpack_drone_anims();
  level._effect["jetpack_exhaust"] = loadfx("maps/haiti/fx_haiti_jetpack1_cheap");
  level._effect["jetpack_explode"] = loadfx("vehicle/vexplosion/fx_vexp_jetpack");
}

#using_animtree("generic_human");
#using_animtree("fxanim_props");

init_jetpack_ai_anims() {
  level.scr_anim["jetpack_ai"]["landing_0"] = % ai_crew_jetpack_blackout_landing_a;
  level.scr_anim["jetpack_ai"]["landing_1"] = % ai_crew_jetpack_blackout_landing_b;
  level.scr_anim["jetpack_ai"]["landing_2"] = % ai_crew_jetpack_blackout_landing_c;
  level.scr_anim["jetpack_ai"]["air_death_0"] = % ai_crew_jetpack_blackout_air_death_a;
  level.scr_anim["jetpack_ai"]["air_death_1"] = % ai_crew_jetpack_blackout_air_death_b;
  level.scr_anim["jetpack_ai"]["air_death_2"] = % ai_crew_jetpack_blackout_air_death_c;
  level.scr_anim["jetpack_ai"]["land_death_0"] = % ai_crew_jetpack_blackout_ground_death_a;
  level.scr_anim["jetpack_ai"]["land_death_1"] = % ai_crew_jetpack_blackout_ground_death_b;
  level.scr_anim["jetpack_ai"]["land_death_2"] = % ai_crew_jetpack_blackout_ground_death_c;
  addnotetrack_customfunction("jetpack_ai", "deploy_chute", ::_jetpack_deploy_chute);
  addnotetrack_customfunction("jetpack_ai", "ground_death", ::_jetpack_set_altitude);
  addnotetrack_customfunction("jetpack_ai", "near_ground", ::_jetpack_set_grounded);
  addnotetrack_customfunction("jetpack_ai", "kill", ::_jetpack_ai_kill);
  level.scr_anim["chute"]["chute_0"] = % fxanim_gp_parachute_jetpack01_anim;
  level.scr_anim["chute"]["chute_1"] = % fxanim_gp_parachute_jetpack02_anim;
  level.scr_anim["chute"]["chute_2"] = % fxanim_gp_parachute_jetpack03_anim;
}

#using_animtree("fakeshooters");

init_jetpack_drone_anims() {
  level.scr_anim["jetpack_drone"]["landing_0"] = % ai_crew_jetpack_blackout_landing_a;
  level.scr_anim["jetpack_drone"]["landing_1"] = % ai_crew_jetpack_blackout_landing_b;
  level.scr_anim["jetpack_drone"]["landing_2"] = % ai_crew_jetpack_blackout_landing_c;
  level.scr_anim["jetpack_drone"]["air_death_0"] = % ai_crew_jetpack_blackout_air_death_a;
  level.scr_anim["jetpack_drone"]["air_death_1"] = % ai_crew_jetpack_blackout_air_death_b;
  level.scr_anim["jetpack_drone"]["air_death_2"] = % ai_crew_jetpack_blackout_air_death_c;
  level.scr_anim["jetpack_drone"]["land_death_0"] = % ai_crew_jetpack_blackout_ground_death_a;
  level.scr_anim["jetpack_drone"]["land_death_1"] = % ai_crew_jetpack_blackout_ground_death_b;
  level.scr_anim["jetpack_drone"]["land_death_2"] = % ai_crew_jetpack_blackout_ground_death_c;
  addnotetrack_customfunction("jetpack_drone", "deploy_chute", ::_jetpack_deploy_chute);
  addnotetrack_customfunction("jetpack_drone", "ground_death", ::_jetpack_set_altitude);
  addnotetrack_customfunction("jetpack_drone", "near_ground", ::_jetpack_set_grounded);
  addnotetrack_customfunction("jetpack_drone", "kill", ::_jetpack_ai_kill);
}

create_jetpack_ai(s_align, strname_or_ai, b_drone, func_spawn) {
  if(!isDefined(b_drone))
    b_drone = 0;

  need_to_spawn_ai = !isai(strname_or_ai);

  if(need_to_spawn_ai) {
    a_sp_jetpack = getentarray(strname_or_ai, "targetname");

    if(a_sp_jetpack.size > 1)
      sp_jetpack = random(a_sp_jetpack);
    else
      sp_jetpack = a_sp_jetpack[0];
  }

  ai_jetpack = undefined;

  if(b_drone)
    ai_jetpack = create_fake_jetpack_ai(sp_jetpack);
  else {
    if(need_to_spawn_ai) {
      ai_jetpack = simple_spawn_single(sp_jetpack);

      while(!isDefined(ai_jetpack)) {
        ai_jetpack = simple_spawn_single(sp_jetpack);
        wait 1.0;
      }
    } else
      ai_jetpack = strname_or_ai;

    ai_jetpack set_allowdeath(1);
    ai_jetpack magic_bullet_shield();
    ai_jetpack.animname = "jetpack_ai";
  }

  ai_jetpack.s_align = s_align;
  ai_jetpack ent_flag_init("high_altitude", 1);
  ai_jetpack ent_flag_init("near_ground", 0);
  ai_jetpack thread _jetpack_death_watch();
  ai_jetpack _create_and_link_jetpack();
  ai_jetpack endon("damage");
  ai_jetpack endon("death");
  ai_jetpack _attach_jetpack_fx();

  if(isDefined(func_spawn))
    ai_jetpack thread[[func_spawn]]();

  ai_jetpack _play_landing_anim();
  ai_jetpack stop_magic_bullet_shield();
  ai_jetpack notify("landed");

  if(b_drone) {
    ai_jetpack.m_jetpack delete();
    ai_jetpack delete();
  } else
    ai_jetpack.m_jetpack delay_thread(10, ::_jetpack_destroy);
}

create_jetpack_drone(s_start, v_destination, params) {
  self.s_align = s_start;
  self ent_flag_init("high_altitude", 1);
  self ent_flag_init("near_ground", 0);
  self.animname = "jetpack_drone";
  self _create_and_link_jetpack();
  self _attach_jetpack_fx();
  self thread _jetpack_death_watch();
  self _play_landing_anim();
  self notify("landed");
  self.m_jetpack thread _jetpack_destroy();
}

create_fake_jetpack_ai(sp_jetpack) {
  ai_jetpack = spawn("script_model", sp_jetpack.origin);
  ai_jetpack getdronemodel(sp_jetpack.classname);
  ai_jetpack makefakeai();
  ai_jetpack.team = "axis";
  ai_jetpack setcandamage(1);
  ai_jetpack init_anim_model("jetpack_drone", 0, #animtree);
  return ai_jetpack;
}

_create_and_link_jetpack() {
  v_origin = self gettagorigin("J_SpineUpper") + -10 * anglestoforward(self.angles);
  v_angles = self gettagangles("J_SpineUpper") + vectorscale((0, 0, 1), 90.0);
  self.m_jetpack = spawn("script_model", v_origin);
  self.m_jetpack.angles = v_angles;
  self.m_jetpack setmodel("veh_t6_air_jetpack");
  self.m_jetpack linkto(self, "J_SpineUpper");
}

_attach_jetpack_fx() {
  self.m_jetpack play_fx("jetpack_exhaust", undefined, undefined, "detach", 1, "tag_engine_left");
}

_play_landing_anim() {
  self.n_jetpack_anim = randomint(3);
  str_scene = "landing_" + self.n_jetpack_anim;
  self.s_align anim_single_aligned(self, str_scene);
}

_jetpack_set_altitude(ai_jetpack) {
  ai_jetpack ent_flag_clear("high_altitude");
}

#using_animtree("fxanim_props");

_jetpack_deploy_chute(ai_jetpack) {
  m_chute = spawn("script_model", (0, 0, 0));
  m_chute.angles = ai_jetpack.s_align.angles;
  m_chute setmodel("fxanim_gp_parachute_jetpack_mod");
  m_chute useanimtree(#animtree);
  m_chute endon("death");
  ai_jetpack.s_align anim_single_aligned(m_chute, "chute_" + ai_jetpack.n_jetpack_anim, undefined, "chute", 0.0);
  m_chute delete();
}

_jetpack_set_grounded(ai_jetpack) {
  ai_jetpack ent_flag_set("near_ground");
  ai_jetpack.m_jetpack unlink();
  v_release = anglestoforward(ai_jetpack.angles) * 10;
  ai_jetpack.m_jetpack physicslaunch(ai_jetpack.m_jetpack.origin + vectorscale((0, 0, -1), 3.0), v_release);
  ai_jetpack.m_jetpack notify("detach");
}

_jetpack_death_watch() {
  self endon("landed");
  self waittill("damage", undefined, e_attacker);

  if(self ent_flag("high_altitude")) {
    str_scene = "air_death_" + randomint(3);
    self anim_single_aligned(self, str_scene);
    self.m_jetpack thread _jetpack_destroy();
  } else {
    self.m_jetpack delay_thread(5, ::_jetpack_destroy);

    if(!self ent_flag("near_ground")) {
      self ent_flag_wait("near_ground");
      str_scene = "land_death_" + randomint(3);
      self.s_align anim_single_aligned(self, str_scene);
    } else {
      v_origin = self.origin;
      self stop_magic_bullet_shield();
      self ragdoll_death();
      physicsexplosionsphere(v_origin, 150, 50, 1);
    }
  }

  if(isDefined(e_attacker) && isplayer(e_attacker))
    level notify("jetpack_guy_killed_midair");
}

_jetpack_ai_kill(ai_jetpack) {
  ai_jetpack.m_jetpack thread _jetpack_destroy();
  v_origin = ai_jetpack.m_jetpack.origin;

  if(isai(ai_jetpack)) {
    ai_jetpack stop_magic_bullet_shield();
    ai_jetpack ragdoll_death();
    physicsexplosionsphere(v_origin, 150, 50, 1);
  } else {
    if(ai_jetpack ent_flag("high_altitude"))
      ai_jetpack delete();
    else
      ai_jetpack ragdoll_death();

    physicsexplosionsphere(v_origin, 150, 50, 1);
  }
}

_jetpack_destroy() {
  playfx(getfx("jetpack_explode"), self gettagorigin("tag_body_animate"), self gettagangles("tag_body_animate"));
  wait 0.1;

  if(isDefined(self))
    self delete();
}