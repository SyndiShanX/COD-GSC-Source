/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2a1239c9bdda2e7.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\cp_mp\challenges;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\teams;
#namespace namespace_90cf6fc2ac1b5b14;

function main() {
  level._effect["vfx_esc5_hell_teleport_screen_01"] = loadfx("vfx/jup/level/mp_jup_escape5_hell/vfx_esc5_hell_teleport_screen_01.vfx");
  level thread function_7cbec80c89bfbded();
}

function function_7cbec80c89bfbded() {
  waittillframeend();
  teleporter_locs = getStructArray("limbo_mode_teleporter_loc", "targetname");

  foreach(struct in teleporter_locs) {
    teleporter = spawn("script_model", struct.origin);
    model = "limbo_mode_teleporter";

    if(isDefined(struct.script_noteworthy)) {
      model = "location_" + struct.script_noteworthy + "::limbo_mode_teleporter";
    }

    teleporter setModel(model);
    teleporter.destination = getStruct(struct.target, "targetname");
    teleporter thread run_teleporter();
    teleporter thread function_564b73bb9fd91ef6();

    teleporter thread function_e697fb04e5f75758();
  }
}

function function_564b73bb9fd91ef6() {
  level endon("game_ended");

  while(true) {
    foreach(player in level.players) {
      var_2d58e8aae155cc83 = distancesquared(self.origin, player.origin);

      if(var_2d58e8aae155cc83 < 1000000 && !isDefined(player.var_544cf16eac472605)) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_portalNear", player, 1, 0);
        player.var_544cf16eac472605 = 1;
        player thread function_855d3cc5689d1cd4();
      }
    }

    wait 5;
  }
}

function function_855d3cc5689d1cd4() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 60;
  self.var_544cf16eac472605 = undefined;
}

function run_teleporter() {
  tag = "j_teleporter";
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  if(!self tagexists(tag)) {
    return;
  }

  origin = self gettagorigin(tag);
  trigger = spawn("trigger_radius", origin, 0, 42, 42);

  while(true) {
    trigger waittill("trigger", player);

    if(isai(player) || !isPlayer(player)) {
      continue;
    }

    player setOrigin(self.destination.origin);
    self playSound("jup_wz_purgatory_teleport_3d");
    player playsoundtoplayer("jup_wz_purgatory_teleport_plr", player);
    playsoundatpos(self.destination.origin + (0, 0, 15), "jup_wz_purgatory_teleport_arrive");
    playFXOnTag(level._effect["vfx_esc5_hell_teleport_screen_01"], player, "tag_origin");

    if(player isskydiving()) {
      player skydive_interrupt();
    }

    player skydive_beginfreefall();
    player scripts\cp_mp\challenges::function_9dd45fb7c1b7de56("event_limbo_teleport");
  }
}

function function_e697fb04e5f75758() {
  while(true) {
    if(getdvarint(@ "hash_aa72b7c24c6294a6", 0)) {
      line(self.origin, self.destination.origin, (1, 1, 1), 1, 0, 1);
      box(self.destination.origin, 0, (0, 1, 0), 0, 1);
    }

    waitframe();
  }
}

# /