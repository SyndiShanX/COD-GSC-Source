/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_dna_aoe_grenade.gsc
***************************************************************/

init() {
  level._effect["dna_aoe"] = loadfx("vfx/unique/vfx_killstreak_missilestrike_dna_friendly_sml");
  level.zombie_dna_grenades_active = [];
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self notify("onPlayerSpawnDNAAOEGrenade");
  self endon("onPlayerSpawnDNAAOEGrenade");
  var_0 = self.team;

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);
    var_3 = maps\mp\_utility::strip_suffix(var_2, "_lefthand");

    if(var_3 != "dna_aoe_grenade_zombie_mp" && var_3 != "dna_aoe_grenade_throw_zombie_mp") {
      continue;
    }
    if(!isDefined(var_1)) {
      continue;
    }
    var_4 = var_1 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("explode", "dud_explode", "repulsor_repel");

    if(var_4.size < 2 || var_4[0] == "dud_explode" || var_4[0] == "repulsor_repel") {
      continue;
    }
    thread addaoecloud(var_4[1], var_0);
  }
}

addaoecloud(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  level.zombie_dna_grenades_active[level.zombie_dna_grenades_active.size] = var_2;
  level.zombie_dna_grenades_active = common_scripts\utility::array_removeundefined(level.zombie_dna_grenades_active);

  if(level.zombie_dna_grenades_active.size > 6) {
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dna_aoe"), level.zombie_dna_grenades_active[0], "tag_origin");
    level.zombie_dna_grenades_active[0] notify("stopGrenade");
  }

  waitframe();
  var_2 playLoopSound("dna_grenade_front_lp");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dna_aoe"), var_2, "tag_origin");
  var_2 updateaoe(var_1, self);
  var_2 stoploopsound();
  var_2 playSound("dna_grenade_front_end");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dna_aoe"), var_2, "tag_origin");
  wait 0.05;
  var_2 delete();
}

updateaoe(var_0, var_1) {
  self endon("death");
  self endon("stopGrenade");
  var_2 = squared(160);
  var_3 = 0;
  var_4 = 0.15;

  while(var_3 < 20) {
    wait(var_4);
    var_3 = var_3 + var_4;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(!isDefined(level.agentarray)) {
      continue;
    }
    foreach(var_6 in level.agentarray) {
      if(!isDefined(var_6) || !isalive(var_6) || isDefined(var_6.team) && !isenemyteam(var_0, var_6.team)) {
        continue;
      }
      if(distancesquared(self.origin, var_6.origin) > var_2) {
        continue;
      }
      var_6 maps\mp\zombies\_zombies::addbuff("dnaBuff", var_6 getdnabuff(var_1));
    }
  }
}

getdnabuff(var_0) {
  var_1 = maps\mp\zombies\_zombies::getbuff("dnaBuff");

  if(!isDefined(var_1)) {
    var_1 = spawndnabuff();
  }

  var_1.lifespan = 0.2;
  var_1.player = var_0;
  return var_1;
}

spawndnabuff() {
  var_0 = spawnStruct();
  var_0.buffupdate = ::updatednabuff;
  var_0.buffremove = ::removednabuff;
  var_0.lifespan = 0.2;
  var_0.damageperstep = 60 * maps\mp\zombies\_zombies::getbufftimestep();
  var_0.speedmultiplier = 0.4;
  self notify("speed_debuffs_changed");
  return var_0;
}

updatednabuff(var_0) {
  var_1 = var_0.player;

  if(isremovedentity(var_1)) {
    var_1 = undefined;
  }

  self dodamage(var_0.damageperstep, self.origin, var_1, undefined, "MOD_TRIGGER_HURT", "dna_aoe_grenade_zombie_mp", "none");
}

removednabuff(var_0) {
  self notify("speed_debuffs_changed");
}