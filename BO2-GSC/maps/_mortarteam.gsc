/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mortarteam.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include animscripts\shared;

main(team) {
  level.prop_mortar_ammunition = "mortar_shell";
  level.prop_mortar = "t6_wpn_mortar_prop";
  precachemodel(level.prop_mortar_ammunition);
  precachemodel(level.prop_mortar);
  anims();
  array_thread(getentarray("mortar_team", "targetname"), ::mortartrigger);
}

mortarteam(spawners, node, mortar_targets, delay_base, delay_range) {
  ent = spawnstruct();
  ent.delay_base = delay_base;
  ent.delay_range = delay_range;
  ent thread mortarteamspawn(spawners, node, mortar_targets);
  return ent;
}

mortartrigger() {
  spawner = getent(self.target, "targetname");
  spawner endon("death");
  self waittill("trigger");
  spawner mortarspawner(self);
}

mortarspawner(delayent) {
  if(!isDefined(delayent))
    delayent = self;

  spawners[0] = self;

  if(is_true(self.script_mortar_team_size)) {
    if(self.script_mortar_team_size == 2)
      spawners[1] = self;
  } else {
    ents = getentarray(self.target, "targetname");

    for(i = 0; i < ents.size; i++) {
      if(issubstr(ents[i].classname, "actor"))
        spawners[1] = ents[i];
    }
  }

  node = random(getnodearray(self.target, "targetname"));
  assert(isDefined(node), "Mortar_team spawner at origin " + self.origin + " must target a node or nodes");
  assert(isDefined(node.target), "Mortar node at origin " + node.origin + " must target script origins for mortar targetting");
  mortar_targets = getstructarray(node.target, "targetname");
  delay_base = 0;
  delay_range = 0;

  if(isDefined(delayent.script_delay))
    delay_base = delayent.script_delay;
  else if(isDefined(delayent.script_delay_min)) {
    delay_base = delayent.script_delay_min;
    delay_range = delayent.script_delay_max - delayent.script_delay_min;
  }

  ent = mortarteam(spawners, node, mortar_targets, delay_base, delay_range);
  return ent;
}

mortarteamspawn(spawners, node, mortar_targets) {
  assert(isDefined(level.scr_anim["loadguy"]), "Add maps_mortarteam::anims(); to the top of your script");
  assert(isDefined(level.mortar), "Define the level.mortar effect that should be used");
  assert(spawners.size <= 2, "Mortarteams can't support more than 2 spawners");
  assert(spawners.size, "Mortarteams need at least 1 spawner");
  name[0] = "loadguy";
  name[1] = "aimguy";
  node endon("stop_mortar");

  if(!isDefined(node.mortarsetup))
    node.mortarsetup = 0;

  mortarthink[0] = ::loadguy;
  mortarthink[1] = ::aimguy;
  self.objectivepositionentity = undefined;
  self.setup = 0;

  if(!isDefined(node.mortarteamactive))
    node.mortarteamactive = 0;

  assert(!node.mortarteamactive, "Mortarteam that runs to " + node.origin + " has multiple mortar teams active on it. Can only have 1 team at a time operating each unique mortar.");
  index = 0;

  for(;;) {
    spawners[index].count = 1;
    spawners[index].script_moveoverride = 1;
    spawn = undefined;

    if(!isDefined(spawners[index].script_forcespawn))
      spawn = spawners[index] dospawn();
    else
      spawn = spawners[index] stalingradspawn();

    if(spawn_failed(spawn)) {
      wait 1;
      continue;
    }

    if(isDefined(spawners[index].script_pacifist)) {
      spawn.pacifist = spawners[index].script_pacifist;
      spawn.pacifistwait = 0.05;
      spawn.ignoreall = 1;
    }

    node.mortarteamactive = 1;
    self.guy[index] = spawn;
    spawn.animname = name[index];

    if(spawn.health < 5000)
      spawn.health = 1;

    spawn thread[[mortarthink[index]]](self, node);
    index++;

    if(index >= spawners.size) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self.loadguy))
    self.loadguy thread stop_mortar_if_player_nearby(node);

  self waittill("loadguy_done");

  if(!isalive(self.loadguy)) {
    node notify("mortar_done");
    node.mortarteamactive = 0;
    self notify("mortar_done");
    return;
  }

  node.mortarent = self;
  node.mortarent endon("stop_mortar");
  self.node = node;
  node.mortar_targets = mortar_targets;

  if(isalive(self.aimguy))
    self thread transferobjectivepositionentity();

  for(;;) {
    if(isalive(self.loadguy)) {
      if(isalive(self.aimguy) && self.aimguy.ready)
        dualmortaruntildeath(node);
      else
        singlemortaronerep(node);

      continue;
    }

    if(isalive(self.aimguy)) {
      aimguymortarsuntildeath(node);
      continue;
    }

    break;
  }

  node notify("stopIdle");
  waittillframeend;
  node.mortarent = undefined;
  node.mortar_targets = undefined;
  node.mortarteamactive = 0;
  self notify("mortar_done");
  node notify("mortar_done");
}

transferobjectivepositionentity() {
  self.loadguy waittill("death");

  if(isalive(self.aimguy))
    self.objectivepositionentity = self.aimguy;
}

singlemortaronerep(node) {
  loadguy = self.loadguy;
  loadguy endon("death");
  loadguy endon("stop_mortar");

  if(loadguy.health < 5000)
    loadguy.health = 1;

  node notify("stopIdle");
  loadguy gun_remove();
  node thread anim_loop_aligned(loadguy, "wait_idle", undefined, "stopIdle");
  wait(self.delay_base + randomfloat(self.delay_range));
  node notify("stopIdle");
  node anim_single_aligned(loadguy, "pickup");
  node anim_single_aligned(loadguy, "fire");
  level notify("mortarteam_fire");
}

stop_mortar_if_player_nearby(node) {
  self endon("death");

  if(is_true(level.stop_mortar_if_player_nearby)) {
    while(true) {
      if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 22500 && level.player is_player_looking_at(self.origin, -0.5, 1, self)) {
        wait 0.1;
        self notify("stop_mortar");
        node notify("stop_mortar");
        self anim_stopanimscripted();
        self animcustom(::player_nearby_reaction_animcustom);
        break;
      }

      wait 0.2;
    }
  }
}

#using_animtree("generic_human");

player_nearby_reaction_animcustom() {
  self endon("death");
  self gun_recall();
  self.ignoreall = 0;
  self.ignoreme = 0;
  self orientmode("face point", level.player.origin);
  react_anim = random(array( % ai_exposed_backpedal, % ai_exposed_idle_react_b));
  self clearanim( % root, 0.2);
  self setflaggedanimknobrestart("react_anim", react_anim, 1, 0.2, 1);
  self animscripts\shared::donotetracks("react_anim");
}

aimguymortarsuntildeath(node) {
  aimguy = self.aimguy;

  if(aimguy.health < 5000)
    aimguy.health = 1;

  aimguy endon("death");
  aimguy endon("stop_mortar");
  node notify("stopIdle");
  aimguy gun_remove();
  aimguy.a.deathforceragdoll = 1;

  for(;;) {
    node notify("stopIdle");
    node thread anim_loop_aligned(aimguy, "wait_idle", undefined, "stopIdle");
    wait(self.delay_base + randomfloat(self.delay_range));
    node notify("stopIdle");
    node anim_single_aligned(aimguy, "pickup_alone");
    node anim_single_aligned(aimguy, "fire_alone");
    level notify("mortarteam_fire");
  }
}

dualmortaruntildeath(node) {
  loadguy = self.loadguy;
  aimguy = self.aimguy;
  guy = self.guy;

  if(loadguy.health < 5000)
    loadguy.health = 1;

  if(aimguy.health < 5000)
    aimguy.health = 1;

  loadguy endon("death");
  aimguy endon("death");
  loadguy endon("stop_mortar");
  aimguy endon("stop_mortar");
  node endon("stop_mortar");
  node notify("stopIdle");
  loadguy gun_remove();
  aimguy gun_remove();
  node thread anim_loop_aligned(guy, "wait_idle", undefined, "stopIdle");
  aimguy.a.deathforceragdoll = 1;

  for(;;) {
    node thread anim_loop_aligned(guy, "wait_idle", undefined, "stopIdle");
    wait(self.delay_base + randomfloat(self.delay_range));
    node notify("stopIdle");
    node anim_single_aligned(guy, "pickup");
    node anim_single_aligned(guy, "fire");
    level notify("mortarteam_fire");
  }
}

aimguy(ent, node) {
  ent.aimguy = self;
  self endon("death");
  self.ready = 0;
  self.allowdeath = 1;
  self.script_longdeath = 0;
  just_setup = isDefined(node.script_nodestate) && node.script_nodestate == "just_setup";

  if(!just_setup)
    node anim_reach(self, "pickup");

  self gun_remove();
  node thread anim_loop_aligned(self, "wait_idle", undefined, "stopIdle");
  self.ready = 1;
  thread detachmortarondeath();
}

deathnotify(ent) {
  ent endon("loadguy_done");
  self waittill("death");
  ent notify("loadguy_done");
}

loadguy(ent, node) {
  ent.loadguy = self;
  ent.objectivepositionentity = self;
  ent notify("objective_created");
  self endon("death");
  self endon("stop_mortar");
  self thread deathnotify(ent);
  self.allowdeath = 1;
  self.script_longdeath = 0;
  self.a.combatrunanim = % ai_mortar_loadguy_run;
  self.alwaysrunforward = 1;
  self disable_react();
  self disable_pain();
  thread detachmortarondeath();

  if(node.mortarsetup) {
    node anim_reach(self, "pickup");
    ent.mortar = node.mortar;
    ent.setup = 1;
    ent notify("loadguy_done");
    return;
  }

  setupanim[0] = % ai_mortar_loadguy_setup;
  setupstring[0] = "setup_straight";
  setupanim[1] = % ai_mortar_loadguy_setup_left;
  setupstring[1] = "setup_left";
  setupanim[2] = % ai_mortar_loadguy_setup_right;
  setupstring[2] = "setup_right";
  just_setup = isDefined(node.script_nodestate) && node.script_nodestate == "just_setup";

  if(!just_setup) {
    self gun_remove();
    self attach(level.prop_mortar, "TAG_WEAPON_LEFT");
    dist = undefined;

    for(i = 0; i < setupanim.size; i++)
      dist[i] = distance(self.origin, getstartorigin(node.origin, node.angles, setupanim[i]));

    index = 0;
    current_dist = dist[0];

    for(i = 1; i < dist.size; i++) {
      if(dist[i] >= current_dist) {
        continue;
      }
      index = i;
      current_dist = dist[i];
    }

    node anim_reach(self, setupstring[index]);
  } else
    index = 0;

  ent notify("loadguy_starting");
  node thread anim_single_aligned(self, setupstring[index]);
  self waittillmatch("single anim", "open_mortar");

  if(soundexists("weapon_setup"))
    thread play_sound_in_space("weapon_setup");

  node waittill(setupstring[index]);
  mortar = spawn("script_model", (0, 0, 0));
  mortar.origin = self gettagorigin("TAG_WEAPON_LEFT");
  mortar.angles = self gettagangles("TAG_WEAPON_LEFT");
  mortar setmodel(level.prop_mortar);
  node.mortarsetup = 1;
  ent.mortar = mortar;
  node.mortar = mortar;

  if(!just_setup)
    self detach(level.prop_mortar, "TAG_WEAPON_LEFT");

  ent.setup = 1;
  ent notify("loadguy_done");
  ent notify("mortar_setup_finished", self.script_squadname);
}

fire(guy) {
  if(!isalive(guy)) {
    return;
  }
  mortarent = self.mortarent;
  mortar_targets = self.mortar_targets;
  mortar = mortarent.mortar;
  org = guy.origin;
  wait 0.25;

  switch (randomint(3)) {
    case 1:
      break;
    case 2:
      break;
    default:
      break;
  }

  wait 0.4;

  if(isDefined(level._effect["mortar_flash_special"]))
    playfxontag(level._effect["mortar_flash_special"], mortar, "TAG_fx");
  else if(isDefined(level._effect["mortar_flash"]))
    playfxontag(level._effect["mortar_flash"], mortar, "TAG_fx");

  if(isDefined(level.scr_sound["mortar_flash"])) {
  }

  target = random(mortar_targets);

  if(isDefined(mortarent))
    mortarent notify("mortar_fired");

  if(!isDefined(level.mortarteam_incoming_sound))
    level.mortarteam_incoming_sound = "prj_mortar_incoming";

  if(isDefined(level.timetoimpact))
    wait(level.timetoimpact);
  else {
    incoming_ent = spawn("script_origin", target.origin);
    wait(distance(self.origin, target.origin) * 0.0008);
    incoming_ent playsound(level.mortarteam_incoming_sound, "sound_done");
    incoming_ent waittill("sound_done");
    incoming_ent delete();
  }

  if(!isDefined(level.explosionhide)) {
    if(isDefined(level.mortarteam_exp_sound))
      thread play_sound_in_space(level.mortarteam_exp_sound, target.origin);
    else
      thread play_sound_in_space("exp_mortar", target.origin);

    playfx(level.mortar, target.origin);
  }
}

attachmortar(guy) {
  if(!isDefined(guy.mortarammo))
    guy.mortarammo = 0;

  if(!guy.mortarammo)
    guy attach(level.prop_mortar_ammunition, "TAG_WEAPON_RIGHT");

  guy.mortarammo = 1;
}

detachmortar(guy) {
  if(guy.mortarammo) {
    guy detach(level.prop_mortar_ammunition, "TAG_WEAPON_RIGHT");
    thread fire(guy);
  }

  guy.mortarammo = 0;
}

detachmortarondeath() {
  self waittill("death");

  if(!isDefined(self.mortarammo)) {
    return;
  }
  if(!self.mortarammo) {
    return;
  }
  self detach(level.prop_mortar_ammunition, "TAG_WEAPON_RIGHT");
  self.mortarammo = 0;
}

anims() {
  level._effect["mortar_flash"] = loadfx("maps/afghanistan/fx_afgh_mortar_launch_fake");
  level.scr_anim["loadguy"]["ready_idle"][0] = % ai_mortar_loadguy_readyidle;
  level.scr_anim["loadguy"]["wait_idle"][0] = % ai_mortar_loadguy_waitidle;
  level.scr_anim["loadguy"]["wait_idle"][1] = % ai_mortar_loadguy_waittwitch;
  level.scr_anim["loadguy"]["fire"] = % ai_mortar_loadguy_fire;
  level.scr_anim["loadguy"]["pickup"] = % ai_mortar_loadguy_pickup;
  level.scr_anim["loadguy"]["setup_straight"] = % ai_mortar_loadguy_setup;
  level.scr_anim["loadguy"]["setup_left"] = % ai_mortar_loadguy_setup_left;
  level.scr_anim["loadguy"]["setup_right"] = % ai_mortar_loadguy_setup_right;
  addnotetrack_customfunction("loadguy", "attach shell = right", ::attachmortar);
  addnotetrack_customfunction("loadguy", "detach shell = right", ::detachmortar);
  level.scr_anim["aimguy"]["ready_idle"][0] = % ai_mortar_aimguy_readyidle;
  level.scr_anim["aimguy"]["ready_alone_idle"][0] = % ai_mortar_aimguy_readyidle_alone;
  level.scr_anim["aimguy"]["wait_idle"][0] = % ai_mortar_aimguy_waitidle;
  level.scr_anim["aimguy"]["wait_idle"][1] = % ai_mortar_aimguy_waittwitch;
  level.scr_anim["aimguy"]["fire"] = % ai_mortar_aimguy_fire;
  level.scr_anim["aimguy"]["pickup"] = % ai_mortar_aimguy_pickup;
  level.scr_anim["aimguy"]["pickup_alone"] = % ai_mortar_aimguy_pickup_alone;
  level.scr_anim["aimguy"]["fire_alone"] = % ai_mortar_aimguy_fire_alone;
  addnotetrack_customfunction("aimguy", "attach shell = right", ::attachmortar);
  addnotetrack_customfunction("aimguy", "detach shell = right", ::detachmortar);
}