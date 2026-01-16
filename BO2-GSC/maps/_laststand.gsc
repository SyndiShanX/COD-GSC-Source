/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_laststand.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

laststand_global_init() {
  level.const_laststand_getup_count_start = 0;
  level.const_laststand_getup_bar_start = 0.5;
  level.const_laststand_getup_bar_regen = 0.0025;
  level.const_laststand_getup_bar_damage = 0.1;
}

init(getupallowed) {
  if(level.script == "frontend") {
    return;
  }
  laststand_global_init();
  precacheitem("syrette_sp");
  precachestring(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  precachestring(&"GAME_PLAYER_NEEDS_TO_BE_REVIVED");
  precachestring(&"GAME_PLAYER_IS_REVIVING_YOU");
  precachestring(&"GAME_REVIVING");

  if(!isDefined(level.laststandpistol)) {
    level.laststandpistol = "m1911_sp";
    precacheitem(level.laststandpistol);
  }

  level thread revive_hud_think();
  level.primaryprogressbarx = 0;
  level.primaryprogressbary = 110;
  level.primaryprogressbarheight = 4;
  level.primaryprogressbarwidth = 120;

  if(issplitscreen())
    level.primaryprogressbary = 280;

  if(getdvar(#"_id_A17166B0") == "")
    setdvar("revive_trigger_radius", "40");

  level.laststandgetupallowed = 0;

  if(is_true(getupallowed)) {
    level.laststandgetupallowed = 1;
    add_global_spawn_function("axis", ::ai_laststand_on_death);
    onplayerconnect_callback(::player_getup_setup);
  }
}

player_is_in_laststand() {
  return isDefined(self.revivetrigger);
}

player_num_in_laststand() {
  num = 0;
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(players[i] player_is_in_laststand())
      num++;
  }

  return num;
}

player_all_players_in_laststand() {
  return player_num_in_laststand() == get_players().size;
}

player_any_player_in_laststand() {
  return player_num_in_laststand() > 0;
}

playerlaststand(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(smeansofdeath == "MOD_CRUSH") {
    if(self player_is_in_laststand())
      self mission_failed_during_laststand(self);

    return;
  }

  if(self player_is_in_laststand()) {
    return;
  }
  self.downs++;
  self.stats["downs"] = self.downs;
  dvarname = "player" + self getentitynumber() + "downs";
  setdvar(dvarname, self.downs);
  self allowjump(0);

  if(isDefined(level.playerlaststand_func))
    [[level.playerlaststand_func]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);

  if(!laststand_allowed(sweapon, smeansofdeath, shitloc)) {
    self mission_failed_during_laststand(self);
    return;
  }

  if(player_all_players_in_laststand()) {
    self mission_failed_during_laststand(self);
    return;
  }

  self visionsetlaststand("laststand", 1);
  self.health = 1;
  self revive_trigger_spawn();
  self laststand_disable_player_weapons();
  self laststand_give_pistol();
  self.ignoreme = 1;

  if(level.laststandgetupallowed)
    self thread laststand_getup();
  else
    self thread laststand_bleedout(getdvarfloat(#"player_lastStandBleedoutTime"));

  self notify("player_downed");
  self thread refire_player_downed();
}

refire_player_downed() {
  self endon("player_revived");
  self endon("death");
  wait 1.0;

  if(self.num_perks)
    self notify("player_downed");
}

laststand_allowed(sweapon, smeansofdeath, shitloc) {
  if(smeansofdeath != "MOD_PISTOL_BULLET" && smeansofdeath != "MOD_RIFLE_BULLET" && smeansofdeath != "MOD_HEAD_SHOT" && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_BAYONET" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_BURNED")
    return false;

  if(level.laststandpistol == "none")
    return false;

  return true;
}

laststand_disable_player_weapons() {
  weaponinventory = self getweaponslist();
  self.lastactiveweapon = self getcurrentweapon();
  self setlaststandprevweap(self.lastactiveweapon);
  self.laststandpistol = undefined;
  self.hadpistol = 0;

  if(isDefined(self.weapon_taken_by_losing_specialty_additionalprimaryweapon) && self.lastactiveweapon == self.weapon_taken_by_losing_specialty_additionalprimaryweapon) {
    self.lastactiveweapon = "none";
    self.weapon_taken_by_losing_specialty_additionalprimaryweapon = undefined;
  }

  for(i = 0; i < weaponinventory.size; i++) {
    weapon = weaponinventory[i];

    if(weaponclass(weapon) == "pistol" && !isDefined(self.laststandpistol)) {
      self.laststandpistol = weapon;
      self.hadpistol = 1;
    }

    switch (weapon) {
      case "syrette_sp":
        self takeweapon(weapon);
        self.lastactiveweapon = "none";
        break;
    }
  }

  if(!isDefined(self.laststandpistol))
    self.laststandpistol = level.laststandpistol;

  self disableweaponcycling();
  self disableoffhandweapons();
}

laststand_enable_player_weapons() {
  if(!self.hadpistol)
    self takeweapon(self.laststandpistol);

  self enableweaponcycling();
  self enableoffhandweapons();

  if(self.lastactiveweapon != "none" && self.lastactiveweapon != "mortar_round" && self.lastactiveweapon != "mine_bouncing_betty" && self.lastactiveweapon != "claymore_zm" && self.lastactiveweapon != "spikemore_zm")
    self switchtoweapon(self.lastactiveweapon);
  else {
    primaryweapons = self getweaponslistprimaries();

    if(isDefined(primaryweapons) && primaryweapons.size > 0)
      self switchtoweapon(primaryweapons[0]);
  }
}

laststand_clean_up_on_disconnect(playerbeingrevived, revivergun) {
  revivetrigger = playerbeingrevived.revivetrigger;
  playerbeingrevived waittill("disconnect");

  if(isDefined(revivetrigger))
    revivetrigger delete();

  if(isDefined(self.reviveprogressbar))
    self.reviveprogressbar destroyelem();

  if(isDefined(self.revivetexthud))
    self.revivetexthud destroy();

  self revive_give_back_weapons(revivergun);
}

laststand_give_pistol() {
  assert(isDefined(self.laststandpistol));
  assert(self.laststandpistol != "none");
  self giveweapon(self.laststandpistol);
  self givemaxammo(self.laststandpistol);
  self switchtoweapon(self.laststandpistol);
}

laststand_bleedout(delay) {
  self endon("player_revived");
  self endon("disconnect");
  setclientsysstate("lsm", "1", self);
  self.bleedout_time = delay;

  while(self.bleedout_time > int(delay * 0.5)) {
    self.bleedout_time = self.bleedout_time - 1;
    wait 1;
  }

  self visionsetlaststand("death", delay * 0.5);

  while(self.bleedout_time > 0) {
    self.bleedout_time = self.bleedout_time - 1;
    wait 1;
  }

  while(self.revivetrigger.beingrevived == 1)
    wait 0.1;

  self notify("bled_out");
  wait_network_frame();
  setclientsysstate("lsm", "0", self);
  level notify("bleed_out", self getentitynumber());

  if(isDefined(level.is_specops_level) && level.is_specops_level)
    self thread[[level.spawnspectator]]();
  else {
    self.ignoreme = 0;
    self mission_failed_during_laststand(self);
  }
}

revive_trigger_spawn() {
  radius = getdvarint(#"_id_A17166B0");
  self.revivetrigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  self.revivetrigger sethintstring("");
  self.revivetrigger setcursorhint("HINT_NOICON");
  self.revivetrigger enablelinkto();
  self.revivetrigger linkto(self);
  self.revivetrigger.beingrevived = 0;
  self.revivetrigger.createtime = gettime();
  self thread revive_trigger_think();
}

revive_trigger_think() {
  self endon("disconnect");
  self endon("zombified");
  self endon("stop_revive_trigger");

  while(true) {
    wait 0.1;
    players = get_players();
    self.revivetrigger sethintstring("");

    for(i = 0; i < players.size; i++) {
      d = 0;
      d = self depthinwater();

      if(players[i] can_revive(self) || d > 20) {
        self.revivetrigger sethintstring(&"GAME_BUTTON_TO_REVIVE_PLAYER");
        break;
      }
    }

    for(i = 0; i < players.size; i++) {
      reviver = players[i];

      if(!reviver is_reviving(self)) {
        continue;
      }
      gun = reviver getcurrentweapon();
      assert(isDefined(gun));

      if(gun == "syrette_sp") {
        continue;
      }
      reviver giveweapon("syrette_sp");
      reviver switchtoweapon("syrette_sp");
      reviver setweaponammostock("syrette_sp", 1);
      revive_success = reviver revive_do_revive(self, gun);
      reviver revive_give_back_weapons(gun);
      self allowjump(1);

      if(revive_success) {
        self thread revive_success(reviver);
        return;
      }
    }
  }
}

revive_give_back_weapons(gun) {
  self takeweapon("syrette_sp");

  if(self player_is_in_laststand()) {
    return;
  }
  if(gun != "none" && gun != "mine_bouncing_betty" && gun != "claymore_zm" && gun != "spikemore_zm" && gun != "equip_gasmask_zm" && gun != "lower_equip_gasmask_zm" && self hasweapon(gun))
    self switchtoweapon(gun);
  else {
    primaryweapons = self getweaponslistprimaries();

    if(isDefined(primaryweapons) && primaryweapons.size > 0)
      self switchtoweapon(primaryweapons[0]);
  }
}

can_revive(revivee) {
  if(!isalive(self))
    return false;

  if(self player_is_in_laststand())
    return false;

  if(isDefined(self.current_equipment_active) && isDefined(self.current_equipment_active["equip_hacker_zm"]) && self.current_equipment_active["equip_hacker_zm"])
    return false;

  if(!isDefined(revivee.revivetrigger))
    return false;

  if(!self istouching(revivee.revivetrigger))
    return false;

  if(revivee depthinwater() > 10)
    return true;

  if(!self is_facing(revivee))
    return false;

  if(!sighttracepassed(self.origin + vectorscale((0, 0, 1), 50.0), revivee.origin + vectorscale((0, 0, 1), 30.0), 0, undefined))
    return false;

  if(!bullettracepassed(self.origin + vectorscale((0, 0, 1), 50.0), revivee.origin + vectorscale((0, 0, 1), 30.0), 0, undefined))
    return false;

  return true;
}

is_reviving(revivee) {
  return can_revive(revivee) && self usebuttonpressed();
}

is_facing(facee) {
  orientation = self getplayerangles();
  forwardvec = anglestoforward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = facee.origin - self.origin;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > 0.9;
}

revive_do_revive(playerbeingrevived, revivergun) {
  assert(self is_reviving(playerbeingrevived));
  revivetime = 3;

  if(self hasperk("specialty_quickrevive"))
    revivetime = revivetime / 2;

  timer = 0;
  revived = 0;
  playerbeingrevived.revivetrigger.beingrevived = 1;
  playerbeingrevived.revive_hud settext(&"GAME_PLAYER_IS_REVIVING_YOU", self);
  playerbeingrevived revive_hud_show_n_fade(3.0);
  playerbeingrevived.revivetrigger sethintstring("");
  playerbeingrevived startrevive(self);

  if(!isDefined(self.reviveprogressbar))
    self.reviveprogressbar = self createprimaryprogressbar();

  if(!isDefined(self.revivetexthud))
    self.revivetexthud = newclienthudelem(self);

  self thread laststand_clean_up_on_disconnect(playerbeingrevived, revivergun);
  self.reviveprogressbar updatebar(0.01, 1 / revivetime);
  self.revivetexthud.alignx = "center";
  self.revivetexthud.aligny = "middle";
  self.revivetexthud.horzalign = "center";
  self.revivetexthud.vertalign = "bottom";
  self.revivetexthud.y = -113;

  if(issplitscreen())
    self.revivetexthud.y = -107;

  self.revivetexthud.foreground = 1;
  self.revivetexthud.font = "default";
  self.revivetexthud.fontscale = 1.8;
  self.revivetexthud.alpha = 1;
  self.revivetexthud.color = (1, 1, 1);
  self.revivetexthud settext(&"GAME_REVIVING");

  while(self is_reviving(playerbeingrevived)) {
    wait 0.05;
    timer = timer + 0.05;

    if(self player_is_in_laststand()) {
      break;
    }

    if(isDefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive == 1) {
      break;
    }

    if(timer >= revivetime) {
      revived = 1;
      break;
    }
  }

  if(isDefined(self.reviveprogressbar))
    self.reviveprogressbar destroyelem();

  if(isDefined(self.revivetexthud))
    self.revivetexthud destroy();

  if(isDefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive == 1) {
  } else if(!revived)
    playerbeingrevived stoprevive(self);

  playerbeingrevived.revivetrigger sethintstring(&"GAME_BUTTON_TO_REVIVE_PLAYER");
  playerbeingrevived.revivetrigger.beingrevived = 0;
  return revived;
}

auto_revive(reviver) {
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger.auto_revive = 1;

    if(self.revivetrigger.beingrevived == 1) {
      while(true) {
        if(self.revivetrigger.beingrevived == 0) {
          break;
        }

        wait_network_frame();
      }
    }

    self.revivetrigger.auto_trigger = 0;
  }

  self reviveplayer();

  if(isDefined(self.premaxhealth))
    self setmaxhealth(self.premaxhealth);

  setclientsysstate("lsm", "0", self);
  self notify("stop_revive_trigger");
  self.revivetrigger delete();
  self.revivetrigger = undefined;
  self laststand_enable_player_weapons();
  self allowjump(1);
  self.ignoreme = 0;
  reviver.revives++;
  reviver.stats["revives"] = reviver.revives;
  self notify("player_revived", reviver);
}

remote_revive(reviver) {
  if(!self player_is_in_laststand()) {
    return;
  }
  reviver giveachievement_wrapper("SP_ZOM_NODAMAGE");
  self auto_revive(reviver);
}

revive_success(reviver) {
  self notify("player_revived", reviver);
  self reviveplayer();

  if(isDefined(self.premaxhealth))
    self setmaxhealth(self.premaxhealth);

  reviver.revives++;
  reviver.stats["revives"] = reviver.revives;

  if(isDefined(level.missioncallbacks)) {
  }

  setclientsysstate("lsm", "0", self);
  self.revivetrigger delete();
  self.revivetrigger = undefined;
  self laststand_enable_player_weapons();
  self.ignoreme = 0;
}

revive_force_revive(reviver) {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(self player_is_in_laststand());
  self thread revive_success(reviver);
}

revive_hud_create() {
  self.revive_hud = newclienthudelem(self);
  self.revive_hud.alignx = "center";
  self.revive_hud.aligny = "middle";
  self.revive_hud.horzalign = "center";
  self.revive_hud.vertalign = "bottom";
  self.revive_hud.y = -50;
  self.revive_hud.foreground = 1;
  self.revive_hud.font = "default";
  self.revive_hud.fontscale = 1.5;
  self.revive_hud.alpha = 0;
  self.revive_hud.color = (1, 1, 1);
  self.revive_hud settext("");
}

revive_hud_think() {
  self endon("disconnect");

  while(true) {
    wait 0.1;

    if(!player_any_player_in_laststand()) {
      continue;
    }
    players = get_players();
    playertorevive = undefined;

    for(i = 0; i < players.size; i++) {
      if(!players[i] player_is_in_laststand() || !isDefined(players[i].revivetrigger.createtime)) {
        continue;
      }
      if(!isDefined(playertorevive) || playertorevive.revivetrigger.createtime > players[i].revivetrigger.createtime)
        playertorevive = players[i];
    }

    if(isDefined(playertorevive)) {
      for(i = 0; i < players.size; i++) {
        if(players[i] player_is_in_laststand()) {
          continue;
        }
        if(getdvar(#"g_gametype") == "vs") {
          if(players[i].team != playertorevive.team)
            continue;
        }

        players[i] thread faderevivemessageover(playertorevive, 3.0);
      }

      playertorevive.revivetrigger.createtime = undefined;
      wait 3.5;
    }
  }
}

faderevivemessageover(playertorevive, time) {
  revive_hud_show();
  self.revive_hud settext(&"GAME_PLAYER_NEEDS_TO_BE_REVIVED", playertorevive);
  self.revive_hud fadeovertime(time);
  self.revive_hud.alpha = 0;
}

revive_hud_show() {
  assert(isDefined(self));
  assert(isDefined(self.revive_hud));
  self.revive_hud.alpha = 1;
}

revive_hud_show_n_fade(time) {
  revive_hud_show();
  self.revive_hud fadeovertime(time);
  self.revive_hud.alpha = 0;
}

drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;

  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }

}

mission_failed_during_laststand(dead_player) {
  if(isDefined(level.no_laststandmissionfail) && level.no_laststandmissionfail) {
    return;
  }
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      if(players[i] == self) {
        println("Player #" + i + " is dead");

        continue;
      }

      println("Player #" + i + " is alive");

    }
  }

  missionfailed();
}

ai_laststand_on_death() {
  level endon("special_op_terminated");
  self waittill("death", attacker, type, weapon);
  revive_kill = 0;

  if(isDefined(weapon) && isDefined(attacker) && isalive(attacker) && isplayer(attacker) && attacker player_is_in_laststand()) {
    if(isDefined(level.coop_incap_weapon)) {
      if(level.coop_incap_weapon == weapon)
        revive_kill = 1;
    } else if(weaponclass(weapon) == "pistol")
      revive_kill = 1;
  }

  if(revive_kill)
    attacker auto_revive(attacker);
}

laststand_can_pick_self_up() {
  return level.laststandgetupallowed && get_lives_remaining() > 0;
}

get_lives_remaining() {
  assert(level.laststandgetupallowed, "Lives only exist in the Laststand type GETUP.");

  if(level.laststandgetupallowed && isDefined(self.laststand_info) && isDefined(self.laststand_info.type_getup_lives))
    return max(0, self.laststand_info.type_getup_lives);

  return 0;
}

update_lives_remaining(increment) {
  assert(level.laststandgetupallowed, "Lives only exist in the Laststand type GETUP.");
  assert(isDefined(increment), "Must specify increment true or false");
  increment = isDefined(increment) ? increment : 0;
  self.laststand_info.type_getup_lives = max(0, increment ? self.laststand_info.type_getup_lives + 1 : self.laststand_info.type_getup_lives - 1);
  self notify("laststand_lives_updated");
}

player_getup_setup() {
  self.laststand_info = spawnstruct();
  self.laststand_info.type_getup_lives = level.const_laststand_getup_count_start;
}

laststand_getup() {
  self endon("player_revived");
  self endon("disconnect");
  self update_lives_remaining(0);
  setclientsysstate("lsm", "1", self);
  self.laststand_info.getup_bar_value = level.const_laststand_getup_bar_start;
  self thread laststand_getup_hud();
  self thread laststand_getup_damage_watcher();

  while(self.laststand_info.getup_bar_value < 1) {
    self.laststand_info.getup_bar_value = self.laststand_info.getup_bar_value + level.const_laststand_getup_bar_regen;
    wait 0.05;
  }

  self auto_revive(self);
  setclientsysstate("lsm", "0", self);
}

laststand_getup_damage_watcher() {
  self endon("player_revived");
  self endon("disconnect");

  while(true) {
    self waittill("damage");
    self.laststand_info.getup_bar_value = self.laststand_info.getup_bar_value - level.const_laststand_getup_bar_damage;

    if(self.laststand_info.getup_bar_value < 0)
      self.laststand_info.getup_bar_value = 0;
  }
}

laststand_getup_hud() {
  self endon("player_revived");
  self endon("disconnect");
  hudelem = newclienthudelem(self);
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
  hudelem.horzalign = "left";
  hudelem.vertalign = "middle";
  hudelem.x = 5;
  hudelem.y = 170;
  hudelem.font = "big";
  hudelem.fontscale = 1.5;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;
  hudelem.hidewhendead = 1;
  hudelem.sort = 2;
  hudelem.label = & "SO_WAR_LASTSTAND_GETUP_BAR";
  self thread laststand_getup_hud_destroy(hudelem);

  while(true) {
    hudelem setvalue(self.laststand_info.getup_bar_value);
    wait 0.05;
  }
}

laststand_getup_hud_destroy(hudelem) {
  self waittill_either("player_revived", "disconnect");
  hudelem destroy();
}